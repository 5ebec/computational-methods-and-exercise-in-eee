using Plots
gr(legend=false)

# given cubic formula
p3(x) = (5x^3 - 3x)/2
# true value
t = √(3/5)


#Bisection method error
function bisectionerror(f, tval, a, b)
    # absolute error
    e = []
    for i = 1:20
        # aproximate solution
        c = (a + b)/2
        f(a)*f(c) > 0 && (a = c)
        f(b)*f(c) > 0 && (b = c)
        push!(e, abs(c - tval))
    end
    return e
end


#main
function main()
    ε = bisectionerror(p3, t, 0.1, 0.9)
    println(ε)
    #plot and save
    plot(1:20, ε,
        w=2, marker=1,
        title = "Bisection Method",
        xlabel = "Count",
        ylabel = "Absolute error")
    savefig("../img/1_1_1.png")
end


main()
