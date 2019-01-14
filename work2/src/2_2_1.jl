# x's recurrence relation
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
    for k=1:150
        x1 = xrecur(A, x0, b)
        if sum(abs, x1 - x0) < 1e-7
            break
        else
            x0 = x1
        end
    end
    return x1
end


# main
function main()
    A = [3. 1. 1.
         1. 3. 1.
         1. 1. 3.]
    b = [0.; 4.; 6.]
    x0 = zeros(size(b)[1])

    println("x=", jacobi(A, x0, b))
end


main()
