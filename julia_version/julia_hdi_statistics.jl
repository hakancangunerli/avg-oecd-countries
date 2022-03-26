using Pkg
# Pkg.add("DataConvenience")
using DataFrames
using Statistics
using CSV
using DataConvenience

df_hdi = DataFrame(CSV.File("../datasets/hdi.csv"))
# this is somewhat changed compared to other lists since we remove all the gaps within the data. 
oecd_countries = ["Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "CostaRica", "CzechRepublic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", "Italy", "Japan",
    "Korea,Rep.", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", "NewZealand", "Norway", "Poland", "Portugal", "SlovakRepublic", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey", "UnitedKingdom", "UnitedStates"]

#add values to oecd_countries
push!(oecd_countries, "Czechia")
push!(oecd_countries, "SouthKorea")
push!(oecd_countries, "Slovakia")
df_hdi_names = df_hdi[!, "Country"]
df_hdi_2019 = df_hdi[:, "2019"]

for i in 1:length(df_hdi_names)
   df_hdi_names[i] = filter(x -> !isspace(x), df_hdi_names[i])
end

df_combined = DataFrame(Country=df_hdi_names, Combined=df_hdi_2019)

df_hdi = df_combined[in.(df_combined.Country, [Set(oecd_countries)]), :]

df_combined = sort(df_hdi, [:Combined, :Country], rev=true)

print(df_combined)

CSV.write("hdi_outputfile.csv",df_combined,delim=',')
