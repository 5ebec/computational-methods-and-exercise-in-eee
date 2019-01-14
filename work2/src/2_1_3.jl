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


# main
function main()
    U = [3.0 1.0     1.0
         0.0 2.66667 0.666667
         0.0 0.0     2.5]
    y=[0.; 4.; 5.]
   println("x=", bwdsub!(U, y))
end


main()
