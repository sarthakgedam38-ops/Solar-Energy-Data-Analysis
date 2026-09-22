import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv("solar_data_messy.csv")
# print(df.head())
# print(df.isnull().sum())
# print(df.duplicated().sum())
# print(df.describe())
# print(df.info())
# print(df.dtypes)
# print(df.shape)
# print(df.isnull().sum()/len(df)*100)

# Finding Duplicates
duplicates = df.duplicated(subset=['installation_id'])  # for finding duplicates

df = df.drop_duplicates(subset=['installation_id'])     # for droping duplicatesn

df = df.dropna(how='all')                               # For removing all blank rows

df.columns = df.columns.str.strip().str.title()

df['State'] = df['State'].str.strip().str.title()
df = df.dropna(subset=['State'])

df['City'] = df['City'].str.strip().str.title().fillna('Unknown')

df['Category'] = df['Category'].str.strip().str.title()

df['Capacity_Kw'] = (df['Capacity_Kw'].astype(str).str.replace(r'[Kk][wW]','',regex=True).str.strip().replace('nan', None).astype(float))
# df['Capacity_Kw'] = df['Capacity_Kw'].astype(str) + ' KW'
df['Capacity_Kw'] = pd.to_numeric(df['Capacity_Kw'], errors='coerce')
# df.loc[(df['Capacity_Kw'] < 0) | (df['Capacity_Kw'] > 15)] = np.nan


df['Panel_Type'] = df['Panel_Type'].str.strip().str.title().fillna("Unknown")


df['Vendor'] = df['Vendor'].str.strip().str.title().fillna("Unknown")

df['Installation_Date'] = pd.to_datetime(df['Installation_Date'], format='mixed')

df['Year'] = df['Installation_Date'].dt.year

missing_placeholders = ['Unknown', 'unknown', 'N/A', 'NA', 'None', '-', 'unknown', '']
df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].replace(missing_placeholders, pd.NA)

df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].astype(str)
df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].str.replace(r'[^\d\.-]', '', regex=True).str.replace('.','').str.strip()
df['Gross_Cost_Rs'] = pd.to_numeric(df['Gross_Cost_Rs'], errors='coerce').round(0)
df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].abs()

df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].fillna(df.groupby('Capacity_Kw')['Gross_Cost_Rs'].transform('median'))
df['Gross_Cost_Rs'] = df['Gross_Cost_Rs'].fillna(df['Gross_Cost_Rs'].median())

df['State_Subsidy_Rs'] = df['State_Subsidy_Rs'].fillna(0)

df['Monthly_Generation_Units'] = df['Monthly_Generation_Units'].fillna(df['Monthly_Generation_Units'].median())

df['Tariff_Rs_Per_Unit'] = df.groupby(
    ['State', 'Year']
)['Tariff_Rs_Per_Unit'].transform(
    lambda x: x.fillna(x.median())
)

df['Tariff_Rs_Per_Unit'] = df['Tariff_Rs_Per_Unit'].fillna(
    df['Tariff_Rs_Per_Unit'].median()
)

df['Net_Metering_Status'] = df['Net_Metering_Status'].str.strip().str.title()

df['Net_Metering_Status'] = df['Net_Metering_Status'].replace({
    'Y':'Approved',
    'Yes':'Approved',
    'P':'Pending',
    'Submitted':'Application Submitted'
}).fillna('Unknown')

                                                        # Outliers

Q1 = df['Capacity_Kw'].quantile(0.25)
Q3 = df['Capacity_Kw'].quantile(0.75)

IQR = Q3 - Q1

lower_limit = Q1 - 1.5 * IQR
upper_limit = Q3 + 1.5 * IQR

print("Lower limit:", lower_limit)
print("Upper limit:", upper_limit)

outlier_rows = df[
    (df['Capacity_Kw'] < lower_limit) | (df['Capacity_Kw'] > upper_limit)
]

# print(outlier_rows)

# Removing Outliers

df = df[
    (df['Capacity_Kw'] >= lower_limit) &
    (df['Capacity_Kw'] <= upper_limit)
].reset_index(drop=True)

# Find Outliers of Monthly Generation Units

Q1 = df['Monthly_Generation_Units'].quantile(0.25)
Q3 = df['Monthly_Generation_Units'].quantile(0.75)

IQR = Q3 - Q1

lower_limit = Q1 - 1.5 * IQR
upper_limit = Q3 + 1.5 * IQR

print("Lower limit:", lower_limit)
print("Upper limit:", upper_limit)

outlier_row = df[
    (df['Monthly_Generation_Units'] < lower_limit) | (df['Monthly_Generation_Units'] > upper_limit)
]

# print(outlier_row)

# Removing Outliers

df = df[
    (df['Monthly_Generation_Units'] >= lower_limit) &
    (df['Monthly_Generation_Units'] <= upper_limit)
].reset_index(drop=True)

# plt.boxplot(x=df['Monthly_Generation_Units'])
# plt.title("Outliers of Capacity KW")
# plt.show()

# df.to_csv("Clean_Solar.csv", index=False)

# print(df.dtypes)
# print(df.isnull().sum())
# print(df.isnull().sum()/len(df)*100)
# print(df.duplicated().sum())
# print(df.shape)