using Plots
gr(legend=false)

# given cubic formula
p3(x) = (5x^3 - 3x)/2
# p3 diff
p3d(x) = (15x^2 - 3)/2
# true value
t = √(3/5)


# Newton method error
function newtonerror(f, fdiff, tval, x0)
    #init x
    x = x0
    # absolute error
    e = []
    for i = 1:20
        # aproximate solution
        x = x - f(x)/fdiff(x)
        push!(e, abs(x - tval))
    end
    return e
end


# main
function main()
    ε = newtonerror(p3, p3d, t, 0.5)
    println(ε)
    #plot and save
    plot(1:20, ε,
        w=2, marker=1,
        title = "Newton Method",
        xlabel = "Count",
        ylabel = "Absolute error")
    savefig("../img/1_1_2.png")
end


main()
