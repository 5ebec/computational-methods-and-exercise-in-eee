using OffsetArrays
using LinearAlgebra
using LaTeXStrings
using Plots
pyplot(w=3, legend=false)
ENV["PLOTS_TEST"]="true"

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
    savefig("../img/$(filename).png")
    return
end

# time evolution
function timeevo(method!::Function, v::AbstractArray, n_max::Int, Δt::Float64, filename::String)
    vc = method!(v, n_max, Δt)
    eᵣ = map(n -> norm(vc[:,n] - [sin(Δt*n); cos(Δt*n); 0.]), 0:n_max)
    plot!((0:n_max)*Δt, eᵣ)
    savefig("../img/$(filename).png")
    return
end

# the classical Runge–Kutta method
function RK4!(y::AbstractArray, n_max::Int, Δx::Float64)
    for n = 0:n_max-1
        k₁ = diff(y[:,n])Δx
        k₂ = diff(y[:,n] + k₁/2)Δx
        k₃ = diff(y[:,n] + k₂/2)Δx
        k₄ = diff(y[:,n] + k₃)Δx
        y[:,n+1] = y[:,n] + (k₁+2k₂+2k₃+k₄)/6
    end
    return y
end

plot(title=L"v_c(t) \; (\rm{Runge–Kutta\;Method})", xlabel=L"v_x", ylabel=L"v_y")
locus(RK4!, v, n_max, Δt, "3_2_4-a")
plot(title=L"e_r(t) \; (\rm{Runge–Kutta\;Method})", xlabel=L"t", ylabel=L"e_r")
timeevo(RK4!, v, n_max, Δt, "3_2_4-b")
