using OffsetArrays
using Plots
gr(w=3, legend=false)
ENV["PLOTS_TEST"]="true"

# parameter
const N = 100
const Δx = 1.0/N
const Δt = 0.001
const c = 5.0
const T_D = 0.1
const μ = c^2 * Δt^2/Δx^2

function ufunc(k_max::Int, N::Int, edge::String)
    # init u
    u = OffsetArray(zeros(Float64, k_max, N+1), 0:k_max-1, 0:N)
    u[0:Int(T_D/Δt)-1, 0] .= 1

    for k = 2:k_max-1, i = 1:N
        i <= N-1 && (u[k, i] = -u[k-2, i] + μ*u[k-1, i-1] + 2(1-μ)u[k-1, i] + μ*u[k-1, i+1])
        if edge == "fixed"
            u[k, N] = 0
        elseif edge == "free"
            u[k, N] = u[k, N-1]
        end
    end
    return u
end

function main()
    k_max = 1000

    # free edge
    u_free = ufunc(k_max, N, "free")
    anim2 = @animate for k=0:k_max-1
        plot(0:N, u_free[k,0:N], xaxis="i", yaxis="u", title="Free edge",
            ylim=(minimum(u_free), maximum(u_free)))
    end
    gif(anim2, "../img/3_1_2-free.gif", fps = 40)

    contour(u_free, xaxis="i", yaxis="k", title="u (Free edge)",
            fill=true, legend=true, c=:pu_or,
            clim=(minimum(u_free), maximum(u_free)))
    savefig("../img/3_1_2-free.png")

    # fixed edge
    u_fixed = ufunc(k_max, N, "fixed")
    anim1 = @animate for k=0:k_max-1
        plot(0:N, u_fixed[k,0:N], xaxis="i", yaxis="u", title="Fixed edge",
            ylim=(minimum(u_fixed), maximum(u_fixed)))
    end
    gif(anim1, "../img/3_1_2-fixed.gif", fps = 40)

    contour(u_fixed, xaxis="i", yaxis="k", title="u (Fixed edge)",
            fill=true, legend=true, c=:pu_or,
            clim=(minimum(u_free), maximum(u_free)))
    savefig("../img/3_1_2-fixed.png")
end

main()
