# load custom module "Potential"
push!(LOAD_PATH, "./Potential/src")
using Potential
using Plots
gr()


# potential distribution map
function distromap(g, w, d, l, h)
    heatmap(potential(g, w, d, l, h),
        yaxis=:flip,
        fill=true,
        c=:viridis,
        title="g=$(g)mm,w=$(w)mm,d=$(d)mm,l=$(l)mm,h=$(h)mm",
        aspect_ratio=1)
end


# main
function main()
    for l = [10 30 50]
        distromap(10, 10, 10, l, 5)
        savefig("../img/2_3_4-l=$(l).png")
    end
end


main()
