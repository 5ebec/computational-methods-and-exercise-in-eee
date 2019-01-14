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
    # p = q
    anim_s = @animate for s = 0.0:0.01:1.0
        p = q = round((1-s)/2; digits=3)
        temporalchange([1 0 0 0 0 0 0]', S(s, p, q))
        title!("s=$(s), p=$(p), q=$(q)")
        if s == 0.0 || s == 0.3 || s == 0.6 || s == 0.9
            savefig("../img/1_4_1-s_$(Int(s*10)).png")
        end
    end
    gif(anim_s, "../img/1_4_1-s.gif", fps = 20)

    # s = 0.03
    s = 0.03
    anim_p = @animate for p = 0.0:0.01:(1.0-s)
        q = round(1-s-p; digits=2)
        temporalchange([1 0 0 0 0 0 0]', S(s, p, q))
        title!("s=$(s), p=$(p), q=$(q)")
        if p == 0.0 || p == 0.3 || p == 0.6 || p == 0.9
            savefig("../img/1_4_1-p_$(Int(p*10)).png")
        end
    end
    gif(anim_p, "../img/1_4_1-p.gif", fps = 20)
end


main()
