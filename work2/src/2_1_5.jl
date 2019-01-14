push!(LOAD_PATH, "./LUmodule/src")

using LinearAlgebra
using LUmodule

# A matrix
function amtx(n, a)
    mtx = Array(SymTridiagonal(fill(1., n), fill(a, n-1)))
    mtx[1,n] = mtx[n,1] = a
    return mtx
end


# b vector
function bvec(n)
    vec = zeros(n,1)
    vec[1] = 1
    vec[n] = -1
    return vec
end


# main
function main()
    n = 50
    println("a=-0.25 : x=", lusolve!(amtx(n, -1/4), bvec(n)))
    println("a=-0.75 : x=", lusolve!(amtx(n, -3/4), bvec(n)))
end


main()
