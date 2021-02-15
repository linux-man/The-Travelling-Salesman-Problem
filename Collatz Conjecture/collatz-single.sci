// For this script to work, you need to install bigint toolbox (https://forge.scilab.org/index.php/p/bigint/)

SAVEPATH = "" //Working directory
exec(SAVEPATH + 'bigint/loader.sce',-1)
format("v",25)
warning("off")
scf(0)

n = brand("1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", ..
          "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
//n = bigint("5593453462105867303059672839305273454795820192759372658302057663936930396610304852723594386")
//n = bigint("5593453462105869")

p2Count = 0
nEven = 0
oddCount = 0
x = n
coll = mbigint(x)
while x ~= 1 do
    if odd(x) then
        x = x * 3 + 1
        nEven = 0
        oddCount = oddCount + 1
    else
        x = div2(x)
        nEven = nEven + 1
        // Counting multiples of powers of 2
        if length(p2Count) < nEven then p2Count(nEven) = 0; end
        if nEven > 1 then p2Count(nEven - 1) = p2Count(nEven - 1) - 1; end
        p2Count(nEven) = p2Count(nEven) + 1
    end
    coll($ + 1) = x
    if modulo(length(coll), 100) == 0 then
        clf()
        xtitle("collatz Conjecture: n = " + string(n), string(length(coll)), string(iconvert(x, 64)))
        plot("nl", iconvert(coll, 64))
    end
end

p2Freq = p2Count/sum(p2Count)
for i = 1:length(p2Count) p2(i)=2^i; end
for i = 1:length(p2Count) p2Weight(i) = p2(i)^p2Freq(i); end
disp("Count of powers of 2", p2Count)
disp("Frequency of powers of 2", p2Freq)
disp("Weight of powers of 2", p2Weight)
disp("Total weight of powers of 2", prod(p2Weight))

clf()
xtitle("collatz Conjecture: n = " + string(n), string(length(coll)), string(iconvert(x, 64)))
plot("nl", iconvert(coll, 64))

scf(1)
clf();
title("Collatz Conjecture: Powers of 2 frequency")
plot(p2Freq, "r")
plot((2^(1:length(p2Count)))^-1)
legend(['Real';'Expected']);
