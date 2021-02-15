SAVEPATH = "" //Working directory

if exists(["collatzList", "p2List"]) == 0 then load(SAVEPATH + "Collatz.dat") end

if exists(["maxX"]) == 0 then
    for n = 1:size(collatzList)
        maxX(n) = max(collatzList(n))
    end
end

if exists(["maxTab"]) == 0 then maxTab = tabul(double(maxX)) end

count = 0
maxp2 = 0
evenCount = 0

for n = 1:size(p2List)
    maxp2 = max(maxp2, length(p2List(n)))
end

p2Count = []
for n = 1:maxp2 p2Count(n) = 0; end

p2Factor = (1:maxp2)'
for n = 1:size(collatzList)
    count = count + length(collatzList(n))
    p2Count = p2Count + resize_matrix(p2List(n), maxp2, -1)
    evenCount = evenCount + sum(resize_matrix(p2List(n), maxp2, -1) .* p2Factor)
end

p2Freq = p2Count / sum(p2Count)

stoppingTime = []
for n = 1:length(collatzList)
    stoppingTime(n) = length(collatzList(n)) 
end
x = (1:length(stoppingTime))'

disp("Total", count)
disp("Total evens", evenCount)
disp("Evens frequency", evenCount/count)
oddCount = count - evenCount
disp("Total odds", oddCount)
disp("Odds frequency", oddCount / count)
disp("Max power of 2", "2^" + string(maxp2) + " = " + string(2^maxp2))
disp("Total power of 2", sum(p2Count))
disp("Count of powers of 2", p2Count)
disp("Frequency of powers of 2", p2Freq)

scf(0)
clf();
title("Collatz Conjecture: Max values")
plot(maxX)

scf(1)
clf();
title("Collatz Conjecture: Max values frequency")
plot(maxTab(:, 1), maxTab(:, 2))

scf(2)
clf();
title("Collatz Conjecture: Powers of 2 frequency")
plot(p2Freq, "r")
plot((2^(1:length(p2Count)))^-1)
legend(['Real';'Expected']);

scf(3)
clf();
title("Collatz Conjecture: Stopping time")
scatter(x, stoppingTime, 1)

scf(4)
clf();
title("Collatz Conjecture: Stopping time histogram")
histplot(1000, stoppingTime)
