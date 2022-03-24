using Pkg
using DataFrames
using CSV
using Statistics
df_gdp = DataFrame(CSV.File("./datasets/gdppc.csv"))
oecd_countries = ["Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Costa Rica", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", "Italy", "Japan",
    "Korea, Rep.", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States"]

df_gdp_names = df_gdp[!, "Country Name"]
df_gdp_2019 = df_gdp[!, "2019"]
#convert df_gdp_2019 to float 
df_gdp_2020 = df_gdp[!, "2020"]
df_gdp_combined_values = df_gdp_2019 + df_gdp_2020
df_combined = DataFrame(Country=df_gdp_names, Combined=df_gdp_combined_values)


df_combined = sort(df_combined, [:Combined, :Country], rev=true)

df_gdp = df_combined[in.(df_combined.Country, [Set(oecd_countries)]), :]

println(df_gdp)
