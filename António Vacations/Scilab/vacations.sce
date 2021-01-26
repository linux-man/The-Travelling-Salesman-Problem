/*
Cities Codes
Amesterdam  1
Athens      2
Berlin      3
Bern        4
Brussels    5
Budapest    6
Copenhagen  7
Stockolm    8
Helsinki    9
Lisbon     10
London     11
Madrid     12
Oslo       13
Paris      14
Porto      15
Rome       16
Vienna     17
Frankfurt  18
*/

//Data
nCities = 17
visit_duration = [2 2 3 1 3 2 2 2 1 2 4 3 1 4 1 4 3]

distance_matrix = [
0 3122 686 852 210 1476 929 1584 1708 2485 197 1780 1549 506 2242 1768 1182 436;
3122 0 2646 2337 3063 1646 3270 3925 3428 4484 3267 3832 3890 2871 4318 2480 1755 2481;
686 2646 0 974 817 900 724 1379 1421 2887 871 2366 1344 1115 3191 1651 661 520;
852 2337 974 0 672 1117 1344 1999 2544 2230 759 1731 1964 534 2217 982 873 1457;
210 3063 817 672 0 1417 1078 1733 2238 2114 220 1572 1698 296 2032 1545 1127 382;
1476 1646 900 1117 1417 0 1344 1999 1782 3475 1796 2823 1964 1513 3309 1395 278 956;
929 3270 724 1344 1078 1344 0 655 892 3229 2113 2641 620 1379 3115 2088 1105 958;
1584 3925 1379 1999 1733 1999 655 0 237 3086 2768 3296 590 2034 3770 2730 1799 1813;
1708 3428 1421 2544 2238 1782 892 237 0 4927 2492 4228 827 2744 4781 3007 1831 2175;
2485 4484 2887 2230 2114 3475 3229 3086 4927 0 2227 636 3783 1815 321 2708 3200 2474;
197 3267 871 759 220 1796 2113 2768 2492 2227 0 1635 2733 366 2121 1876 1347 602;
1780 3832 2366 1731 1572 2823 2641 3296 4228 636 1635 0 3281 1249 604 2038 2529 1851;
1549 3890 1344 1964 1698 1964 620 590 827 3783 2733 3281 0 1999 3735 2703 1780 1578;
506 2871 1115 534 296 1513 1379 2034 2744 1815 366 1249 1999 0 1736 1490 1248 587;
2242 4318 3191 2217 2032 3309 3115 3770 4781 321 2121 604 3735 1736 0 2524 3090 2337;
1768 2480 1651 982 1545 1395 2088 2730 3007 2708 1876 2038 2703 1490 2524 0 1184 1353;
1182 1755 661 873 1127 278 1105 1799 1831 3200 1347 2529 1780 1248 3090 1184 0 727;
436 2481 520 1457 382 956 958 1813 2175 2474 602 1851 1578 587 2337 1353 727 0;
]

//Calculating Travels (combinations) that respect the travel duration restriction
//One of the best ways to represent a combination is using a "bit" sequence. Each bit represents a city
//17 bits on (1) corresponds to the number 131071, so we know that there are 131071 possible combinations

disp("Calculating travels")
maxBytes = bin2dec(part('1', ones(1:nCities)))
cases = 0
travel_list = list()

for travel = 1:maxBytes
    travel_days = 0
    for bit = 1:nCities
        city = bitget(travel, bit)
        if city == 1 then
            travel_days = travel_days + visit_duration(bit)
        end
    end
    if travel_days <= 7 then
        cases = cases + 1
        travel_list($+1) = travel
        disp(travel)
    end
end
disp("Number of travels", cases)
disp("")

//Convert list to matrix - first column
//Columns: 1- Travel Code 2- Number of Cities 3- Distance 4- Average distance 5-9 Best order
travels = list2vec(travel_list)
travels = resize_matrix(travels, -1, 10)

//Optimizing each travel (finding the shortest path)
disp("Optimizing each travel")
for travel = 1:cases
    cities_list = list()
    for bit = 1:nCities
        city = bitget(travels(travel, 1), bit)
        if city == 1 then
            cities_list($+1) = bit
        end
    end
    permutations = perms(list2vec(cities_list)) //Calculate all permutations fon each travel, choose best and save
    min_distance = %inf
    for permutation = 1:size(permutations, 'r')
        travel_order = list()
        distance = 0
        for city_order = 1:size(permutations, 'c')
            travel_order($+1) = permutations(permutation, city_order)
            if city_order == 1 then //First City
                distance = distance + distance_matrix(nCities + 1, permutations(permutation, city_order))
            else
                distance = distance + distance_matrix(permutations(permutation, city_order - 1), permutations(permutation, city_order))
            end
        end
        distance = distance + distance_matrix(permutations(permutation, size(permutations, 'c')), nCities + 1) //Coming home

        if distance < min_distance then //Saving the best distance
            travels(travel, 2) = size(permutations, 'c')
            travels(travel, 3) = distance
            travels(travel, 4) = distance / size(permutations, 'c')
            for t = 1:size(permutations, 'c')
                travels(travel, 4 + t) = travel_order(t)
            end
        end
        min_distance = min(min_distance, distance)
    end
end
//Sorting by average distance - ascending
[dummy,idx]=gsort(travels(:,4),"g","i")
travels=travels(idx,:)
disp(travels)
disp("")

//Now, the hard part: let's start to combine the best travels so all cities are visited
//Travels with cities already visited are avoided: There is no situation where A->B->C distance < A->C distance
//vectors "step" and "vacation" are travel "slots". The search is linear - incremental. Each slot starts searching at the previous one position + 1
//Each has 17 slots because, teoretically one solution is to visit the 17 cities one at a time
//vacation stores the last valid sequence, step stores the current sequence
//Again, this is a combination problem - the order don't matter
disp("Searching solutions")
step = linspace(0, 0, nCities)
vacation = linspace(0, 0, nCities)
best_vacation = linspace(0, 0, 18)
best_distance = %inf
best_average = %inf
while step(1) < cases
    for v = 1:size(vacation, 'c')
        if vacation(v) ~= 0
            step(v) = vacation(v)
        else
            visited_cities = 0 //Calculate visited cities to test new travels
            for n = 1:v - 1
                if vacation(n) ~= 0
                    visited_cities = bitor(visited_cities, travels(vacation(n), 1))
                end
            end
            while step(v) < cases //This is the cycle for each "slot"
                step(v) = step(v) + 1
                if bitand(visited_cities, travels(step(v), 1)) == 0 //If this new travel don't go to previous cities, add it to the vacation
                    vacation(v) = step(v)
                    step(v + 1) = step(v) + 1
                    break //Stop incrementing and move to next travel
                end
            end
        end
    end
    visited_cities = 0 //See again which cities were visited
    for n = 1:size(vacation, 'c')
        if vacation(n) ~= 0
            visited_cities = bitor(visited_cities, travels(vacation(n), 1))
        end
    end
    if visited_cities == maxBytes //If ALL cities were visited, let's calculate the distance
        vacation_distance = 0
        for n = 1:size(vacation, 'c')
            if vacation(n) > 0
                vacation_distance = vacation_distance + travels(vacation(n), 3)
            end
        end
        if vacation_distance < best_distance //Replace best vacation
            best_distance = vacation_distance
            best_average = vacation_distance / nCities
            best_vacation(1:nCities) = vacation
            best_vacation(18) = best_distance
        end
        disp("Current vacation")
        disp(vacation)
        disp(vacation_distance)
        disp("Best vacation")
        disp(best_vacation)
    end

    vc = 0 //Optimization: if the average distance between visited cities are greater than the best calculated, jump to the next travel
    vd = 0 //There's no use to continue searching on this sequence. Speed up by a HUGE factor (from weeks to hours). It works because travels are ordered by average distance
    for v = 1:size(vacation, 'c')
        if vacation(v) > 0
            vc = vc + travels(vacation(v), 2)
            vd = vd + travels(vacation(v), 3)
            if vd / vc > best_average
                step(v) = cases + 1
            end
        end
    end
    for v = 2:size(vacation, 'c') //Clean up the cycle - if any travel slot reaches maximum (tried all travels), then the previous slot will jump to the next travel
        if step(v) >= cases
            for vv = v:size(vacation, 'c')
                step(vv) == vacation(vv - 1) + 1
                vacation(vv) = 0
            end
            vacation(v - 1) = 0
        end
    end
end
