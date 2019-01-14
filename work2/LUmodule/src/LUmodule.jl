module LUmodule

export lusolve!

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


# Forward Substitution
function fwdsub!(L, b)
    for i = 1:size(b)[1]
        y = b[i]
        for k = 1:i-1
            y -= b[k]*L[i,k]
        end
        b[i] = y
    end
    return b
end


# Backward Substitution
function bwdsub!(U, y)
    n = size(y)[1]
    for i = n:-1:1
        x = y[i]
        for k = (i+1):n
            x -= y[k]*U[i,k]
        end
        y[i] = x/U[i,i]
    end
    return y
end


# simultaneous linear equations solution
function lusolve!(A, b)
    ludecomp!(A)
    fwdsub!(A, b)
    bwdsub!(A, b)
end
end # module
