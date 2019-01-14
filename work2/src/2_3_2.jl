using SymPy

@syms ϕ0 ϕ1 ϕ2 ϕ3 ϕ4

f1 = 4ϕ0 - ϕ1 ⩵ 0
f2 = ϕ0 - 4ϕ1 + ϕ2 ⩵ 0
f3 = ϕ1 - 4ϕ2 + 2ϕ3 ⩵ -100
f4 = ϕ2 - 4ϕ3 + ϕ4 ⩵ -100
f5 = ϕ3 - 4ϕ4 ⩵ -150

s = solve([f1, f2, f3, f4, f5])
println(s)
