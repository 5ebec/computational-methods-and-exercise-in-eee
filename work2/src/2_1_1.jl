# LU decomposition
function ludecomp!(A)
    n = size(A)[1]
    for j = 1:n
        # u_{ij} (i <= j)
        for i = 1:j
            u = A[i,j]
            for k = 1:(i-1)
                u -= A[i,k]*A[k,j]
            end
            A[i,j] = u
        end
        # l_{ij} (i > j)
        for i = (j+1):n
            l = A[i,j]
            for k = 1:(j-1)
                l -= A[i,k]*A[k,j]
            end
            A[i,j] = l/A[j,j]
        end
    end
    return A
end


# main
function main()
    A = [3. 1. 1.
         1. 3. 1.
         1. 1. 3.]
    println("LU=")
    Base.print_array(IOContext(stdout, :compact => true), ludecomp!(A))
end


main()
