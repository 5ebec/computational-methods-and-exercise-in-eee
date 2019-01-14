using Plots
gr(xlabel = "x", ylabel = "y")


# Legendre polynomial
function p(n, x)
    n == 0 && return 1
    n == 1 && return x
    ((2n-1)x*p(n-1, x) - (n-1)*p(n-2, x))/n
end


# Bisection method
function bisection(n, a, b)
    c = 0.
    for i = 1:20
        c = (a + b)/2
        p(n, a)*p(n, c) > 0 && (a = c)
        p(n, b)*p(n, c) > 0 && (b = c)
    end
    return c
end


# print and plot Zero points
function zp(n)
    n == 3 && return [√(3/5)]
    pzp = zp(n-1)
    arr = []

    # odd
    if n%2 == 1
        for i = 1:Int((n-3)/2)
            push!(arr, bisection(n, pzp[i], pzp[i+1]))
        end
        push!(arr, bisection(n, pzp[Int((n-1)/2)], 1))
        zeropoints = sort(append!([0.], append!(-arr, arr)))

    # even
    elseif n%2 == 0
        push!(arr, bisection(n, 0, pzp[1]))
        for i = 2:Int(n/2 - 1)
            push!(arr, bisection(n, pzp[i-1], pzp[i]))
        end
        push!(arr, bisection(n, pzp[Int(n/2-1)], 1))
        zeropoints = sort(append!(-arr, arr))
    end

    #plot and save
    strn = string(n)
    scatter(zeropoints, zeros(n),
                markersize = 3,
                lab = "$(strn)'th Zero Points",
                title = "$(strn)'th Legendre polynomial")
    plot!(-1:0.01:1, x->p(n, x),
            lab = "$(strn)'th Legendre Polynomial")
    savefig("../img/1_2-$(strn).png")
    println("$(strn)'th Zero Points:\n",zeropoints,"\n")
    return arr
end


zp(10)
