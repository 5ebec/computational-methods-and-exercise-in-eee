push!(LOAD_PATH, "./LUmodule/src")
using LinearAlgebra
using LUmodule
using Plots
gr(title = "LU decomposition vs. Jacobi method",
    xlabel = "n",
    ylabel = "calculation time")


# x calculation
function xrecur(A, x0, b)
    n = size(b)[1]
    x1 = zeros(n)
    for i = 1:n
        x1[i] = b[i]
        for j = 1:n
            x1[i] -= (j != i ? A[i,j]*x0[j] : 0.)
        end
        x1[i] /= A[i,i]
    end
    return x1
end


# Jacobi method
function jacobi(A, x0, b)
    #init
    x1 = x0
    for i=1:150
        x1 = xrecur(A, x0, b)
        if sum(abs, x1 - x0) < 1e-7
            break
        else
            x0 = x1
        end
    end
    return x1
end


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
    maxn = 225
    jacobit = []
    lut = []
    anim = @animate for n = 1:maxn
        A1 = amtx(n, -1/4)
        b = bvec(n)
        push!(jacobit, @elapsed jacobi(A1, rand(n), b))
        push!(lut, @elapsed lusolve!(A1, b))
        plot(jacobit, lab="Jacobi")
        plot!(lut, lab="LU")
        xlims!(0, maxn)
    end
    gif(anim, "../img/2-3_1.gif", fps = 20)
    savefig("../img/2-3_1.png")
    plot!()
end


main()
