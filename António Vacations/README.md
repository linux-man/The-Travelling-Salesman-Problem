# António Vacations

### A kind of vehicle routing problem

Due to its specificity, this problem can be solved in useful time (several hours) by classical methods - Combinatorics - with Scilab.

Coliop was used for Linear Programming, with one caveat: the number of trips must be fixed

Optimal solution: 6 trips, 21365 Km.

## The problem

António Esteves, son of emigrants and resident in Frankfurt, decided to make several consecutive trips to visit some of the main European cities.

He defined a set of 17 cities to visit that, for financial reasons, he wants to visit at the lowest possible cost (cost is proportional to the distance traveled).

For logistical reasons, António cannot stay away from home for more than 7 consecutive days (ignore the time associated with traveling between cities).

Which trips, visiting the 17 cities in the required time, minimize the total distance covered, thus minimizing the total cost of travel?

## The data

|Distance|Amesterdam|Athens|Berlin|Bern|Brussels|Budapest|Copenhagen|Stockolm|Frankfurt|Helsinki|Lisbon|London|Madrid|Oslo|Paris|Porto|Rome|Vienna|
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|Amesterdam||3122|686|852|210|1476|929|1584|436|1708|2485|197|1780|1549|506|2242|1768|1182|
|Athens|3122||2646|2337|3063|1646|3270|3925|2481|3428|4484|3267|3832|3890|2871|4318|2480|1755|
|Berlin|686|2646||974|817|900|724|1379|520|1421|2887|871|2366|1344|1115|3191|1651|661|
|Bern|852|2337|974||672|1117|1344|1999|1457|2544|2230|759|1731|1964|534|2217|982|873|
|Brussels|210|3063|817|672||1417|1078|1733|382|2238|2114|220|1572|1698|296|2032|1545|1127|
|Budapest|1476|1646|900|1117|1417||1344|1999|956|1782|3475|1796|2823|1964|1513|3309|1395|278|
|Copenhagen|929|3270|724|1344|1078|1344||655|958|892|3229|2113|2641|620|1379|3115|2088|1105|
|Stockolm|1584|3925|1379|1999|1733|1999|655||1813|237|3086|2768|3296|590|2034|3770|2730|1799|
|Frankfurt|436|2481|520|1457|382|956|958|1813||2175|2474|602|1851|1578|587|2337|1353|727|
|Helsinki|1708|3428|1421|2544|2238|1782|892|237|2175||4927|2492|4228|827|2744|4781|3007|1831|
|Lisbon|2485|4484|2887|2230|2114|3475|3229|3086|2474|4927||2227|636|3783|1815|321|2708|3200|
|London|197|3267|871|759|220|1796|2113|2768|602|2492|2227||1635|2733|366|2121|1876|1347|
|Madrid|1780|3832|2366|1731|1572|2823|2641|3296|1851|4228|636|1635||3281|1249|604|2038|2529|
|Oslo|1549|3890|1344|1964|1698|1964|620|590|1578|827|3783|2733|3281||1999|3735|2703|1780|
|Paris|506|2871|1115|534|296|1513|1379|2034|587|2744|1815|366|1249|1999||1736|1490|1248|
|Porto|2242|4318|3191|2217|2032|3309|3115|3770|2337|4781|321|2121|604|3735|1736||2524|3090|
|Rome|1768|2480|1651|982|1545|1395|2088|2730|1353|3007|2708|1876|2038|2703|1490|2524||1184|
|Vienna|1182|1755|661|873|1127|278|1105|1799|727|1831|3200|1347|2529|1780|1248|3090|1184||

|City|Days to visit|
|---|---:|
|Amesterdam|2|
|Athens|2|
|Berlin|3|
|Bern|1|
|Brussels|3|
|Budapest|2|
|Copenhagen|2|
|Stockolm|2|
|Helsinki|1|
|Lisbon|2|
|London|4|
|Madrid|3|
|Oslo|1|
|Paris|4|
|Porto|1|
|Rome|4|
|Vienna|3|

