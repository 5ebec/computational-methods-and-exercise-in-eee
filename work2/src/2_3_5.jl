# load custom module "Potential"
push!(LOAD_PATH, "./Potential/src")
using Potential
using Plots
gr()


# main
function main()
    for h = [5 2 1]
        distromap(10, 10, 10, 30, h)
        savefig("../img/2_3_5-h=$(h).png")
    end
end


main()
