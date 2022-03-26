using Pkg
using DataFrames
using CSV
using Statistics
df_happiness = DataFrame(CSV.File("../datasets/happiness.csv"))
oecd_countries = ["Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Costa Rica", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", "Italy", "Japan",
    "Korea, Rep.", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States"]

#add values to oecd_countries
push!(oecd_countries, "United States")
push!(oecd_countries, "South Korea")
push!(oecd_countries, "Slovakia")

df_happiness_names = df_happiness[!, "country"]
df_happiness2021= df_happiness[!, "happiness2021"]
df_happiness_2020 = df_happiness[!, "happiness2020"]
df_happiness_combined = (df_happiness_2020+ df_happiness2021)/2
df_combined = DataFrame(Country=df_happiness_names, Combined=df_happiness_combined)


df_combined = sort(df_combined, [:Combined, :Country], rev=true)

df_happiness = df_combined[in.(df_combined.Country, [Set(oecd_countries)]), :]


println(df_happiness)

CSV.write("happiness_outputfile.csv",df_happiness,delim=',')
