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


# main
function main()
    L = [1.0      0.0  0.0
         0.333333 1.0  0.0
         0.333333 0.25 1.0]
    b=[0.; 4.; 6.]
    println("y=", fwdsub!(L, b))
end


main()
