using LinearAlgebra
using Plots
gr(ylabel="element",
   ms=2,
   legend=false)


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


# Jacobi method and put out animation gif
function jacobianim(A, x0, b, filename)
    #init
    x1 = x0
    anim = @animate for i=1:150
        x1 = xrecur(A, x0, b)
        if sum(abs, x1 - x0) < 1e-7
            break
        else
            x0 = x1
        end
        scatter(x1, title=filename)
    end
    gif(anim, "../img/2-2_$(filename).gif", fps = 10)
    return x1
end



# A matrix
function amtx(n, a)
    mtx = Array(SymTridiagonal(fill(1., n), fill(a, n-1)))
    mtx[1, n] = mtx[n, 1] = a
    return mtx
end


# B vector
function bvec(n)
    vec = zeros(n)
    vec[1] = 1
    vec[n] = -1
    return vec
end


# main
function main()
    n = 50
    A1 = amtx(n, -1/4)
    A2 = amtx(n, -3/4)
    b = bvec(n)

    println("x=", jacobianim(A1, zeros(n), b, "x0=zeros a=-0.25"))
    println("x=", jacobianim(A2, zeros(n), b, "x0=zeros a=-0.75"))
    println("x=", jacobianim(A1, 1e3*rand(n), b, "x0=rand a=-0.25"))
    println("x=", jacobianim(A2, 1e2*rand(n), b, "x0=rand a=-0.75"))
end


main()
