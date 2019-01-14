using OffsetArrays
using LinearAlgebra
using LaTeXStrings
using Plots
pyplot(w=3, legend=false)

# parameter
const m = 1.
const q = 1.
const τ = 2π
B = [0.; 0.; 1.]

# v init
vinit(n_max::Int) = OffsetArray(hcat([0.; 1.; 0.], zeros(Float64, 3, n_max)), 1:3, 0:n_max)

# differential equation
diff(y_n::AbstractArray) = (y_n × B)q/m

# parameter
Δt = τ/64
n_max = Int(5τ/Δt)
v = vinit(n_max)

# locus
function locus(method!::Function, v::AbstractArray, n_max::Int, Δt::Float64, filename::String)
    vc = method!(v, n_max, Δt)
    plot!(vc[1, 0:n_max], vc[2, 0:n_max], aspect_ratio=1)
    savefig("img/$(filename).png")
    return
end

# time evolution
function timeevo(method!::Function, v::AbstractArray, n_max::Int, Δt::Float64, filename::String)
    vc = method!(v, n_max, Δt)
    eᵣ = map(n -> norm(vc[:,n] - [sin(Δt*n); cos(Δt*n); 0.]), 0:n_max)
    plot!((0:n_max)*Δt, eᵣ)
    savefig("img/$(filename).png")
    return
end

# Heun method
function heun!(y::AbstractArray, n_max::Int, h::Float64)
    for n = 0:n_max-1
        k₁ = diff(y[:,n])h
        k₂ = diff(y[:,n] + k₁)h
        y[:,n+1] = y[:,n] + (k₁+k₂)/2
    end
    return y
end

# main
function main()
    plot(title=L"v_c(t) \; (\rm{Heun\;Method})", xlabel=L"v_x", ylabel=L"v_y")
    locus(heun!, v, n_max, Δt, "3_2_3-a")
    plot(title=L"e_r(t) \; (\rm{Heun\;Method})", xlabel=L"t", ylabel=L"e_r")
    timeevo(heun!, v, n_max, Δt, "3_2_3-b")
end

main()
