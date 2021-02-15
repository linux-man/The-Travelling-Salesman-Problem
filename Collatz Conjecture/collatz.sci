SAVEPATH = "" //Working directory
format("v",25)

minn = 1
maxn = 1000
collatzList = list()
p2List = list()

n = minn
while n <= maxn do
    p2Count = 0
    nEven = 0
    x = uint64(n)
    coll = x
    while x ~= 1 do
        if modulo(x, uint64(2)) == 1 then
            x = x * 3 + 1
            nEven = 0
        else
            x = x / 2
            nEven = nEven + 1
            // Counting multiples of powers of 2
            if length(p2Count) < nEven then p2Count(nEven) = 0; end
            if nEven > 1 then p2Count(nEven - 1) = p2Count(nEven - 1) - 1; end
            p2Count(nEven) = p2Count(nEven) + 1
        end
        coll($ + 1) = x
    end
    collatzList($+1) = coll
    p2List($+1) = p2Count
    if modulo(n, 100) == 0 then clf(); end
    title("Collatz Conjecture: n = " + string(n))
    plot(coll)
    n = n + 1
end

save(SAVEPATH + "Collatz-" + string(minn) + "-" + string(maxn) + ".dat","collatzList", "p2List")

/*
// Merge several lists

load(SAVEPATH + "Collatz-1-1000.dat")
c = collatzList
p = p2List

load(SAVEPATH + "Collatz-1001-2000.dat")
c = lstcat(c, collatzList)
p = lstcat(p, p2List) 

collatzList = c
p2List = p

save(SAVEPATH + "Collatz.dat","collatzList", "p2List")
*/
