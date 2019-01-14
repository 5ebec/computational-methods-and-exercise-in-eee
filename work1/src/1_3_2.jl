using LinearAlgebra
using Plots
gr()


# Existence probability
S(s,p,q) = [s+p p 0 0 0 0  0
             q  s p 0 0 0  0
             0  q s p 0 0  0
             0  0 q s p 0  0
             0  0 0 q s p  0
             0  0 0 0 q s  p
             0  0 0 0 0 q s+q]


# Temporal change plot
function temporalchange(g, f)

    # 0sec
    g2 = g

    # 1-60sec
    for t = 1:60
        g = f*g
        g2 = hcat(g2, g)
    end

    # plot
    plot(0:60, g2',
    w=2, marker=1,
    label=["0" "1" "2" "3" "4" "5" "6"],
    title = "Temporal Change",
    xlabel = "sec",
    ylabel = "Existence probability")

    # existence probability at 60sec
    return g2[:,61]
end


# main
function main()
    for i = 2:7
        g = Matrix{Float64}(I, 7, 7)[i,:]
        println(temporalchange(g, S(0.03, 0.485, 0.485)))
        title!("g(0) = $(g)")
        savefig("../img/1_3_2-$(i).png")
    end
end


main()
