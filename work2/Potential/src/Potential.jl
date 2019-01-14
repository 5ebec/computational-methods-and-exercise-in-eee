module Potential

export potential, distromap

# load custom module "LUmodule"
push!(LOAD_PATH, "./LUmodule/src")
using LUmodule
using Plots
gr()

# Lattice point's potential
function potential(g, w, d, l, h)

    # boundary
    y0, y1, y2 = 1, Int(g/h+1), Int((g+d)/h+1)
    x0, x1, x2, x3 = 1, Int((l-w)/2h+1), Int((l+w)/2h+1), Int(l/h+1)

    # set ϕ
    ϕ = ones(y2, x3)
    ϕ[y0, :] .= 100.
    ϕ[y2, :] .= 0.
    ϕ[y1:y2, x0:x1] .= ϕ[y1:y2, x2:x3] .= 0.
    for y = y0+1:y1-1
        ϕ[y, x0] = ϕ[y, x3] = 100(y1-y)h/g
    end

    # set A, b
    n = y2*x3
    A = one(zeros(n, n))
    b = zeros(n)
    for i=1:n
        if ϕ[i] == 1.
            A[i, i-1] = A[i, i+1] = A[i, i-y2] = A[i, i+y2] = -1/4
        else
            b[i] = ϕ[i]
        end
    end

    # LU solve
    ϕ = reshape(lusolve!(A, b), (y2, x3))
    ϕ[y1+1:y2, x0:x1-1] .= ϕ[y1+1:y2, x2+1:x3] .= NaN

    return ϕ
end


# potential distribution map
function distromap(g, w, d, l, h)
    heatmap(potential(g, w, d, l, h),
        yaxis=:flip,
        fill=true,
        c=:viridis,
        title="g="*string(g)*"mm,w="*string(w)*"mm,d="*string(d)*"mm,l="*string(l)*"mm,h="*string(h)*"mm",
        aspect_ratio=1)
end


end # module
