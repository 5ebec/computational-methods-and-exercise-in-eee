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


# main
function main()
    # print S^180
    Base.print_array(IOContext(stdout, :compact => true), S(0.03, 0.485, 0.485)^180)

    # animation heatmap
    anim = @animate for t=1:180
        heatmap(0:6, 0:6, round.(S(0.03, 0.485, 0.485)^t; digits=6), yaxis=:flip, c=:blues, aspect_ratio=1)
    end
    gif(anim, "../img/1_3_3.gif", fps = 30)
end


main()
