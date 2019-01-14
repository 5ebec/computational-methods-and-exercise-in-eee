using OffsetArrays
using LinearAlgebra
using Statistics
using LaTeXStrings
using Plots
pyplot(w=3, legend=true)

# parameter
const m = 1.
const q = 1.
const τ = 2π
B = [0.; 0.; 1.]

# v init
vinit(n_max::Int) = OffsetArray(hcat([0.; 1.; 0.], zeros(Float64, 3, n_max)), 1:3, 0:n_max)

# differential equation
diff(y_n::AbstractArray) = (y_n × B)q/m

# log₂Eᵣ plot
function Erplot(method!::Function, filename::String)
    domain = 3:18
    Eᵣ = zeros(Float64, domain[end])
    for p = domain
        Δt = τ * 2.0^-p
        n_max = Int(τ/Δt)
        v = vinit(n_max)
        vc = method!(v, n_max, Δt)
        Eᵣ[p] = map(n -> norm(vc[:,n] - [sin(Δt*n); cos(Δt*n); 0.]), 0:n_max)|>maximum
    end
    log₂Eᵣ = log2.(Eᵣ)

    scatter!(domain, log₂Eᵣ[domain], xlim=(0,19), lab=L"\log_2E_r(p)")

    # least squares method
    @show a = cov(domain, log₂Eᵣ[domain])/var(domain)
    b = mean(log₂Eᵣ[domain]) - a*mean(domain)
    plot!(domain, a.*domain .+ b, lab="least squares")

    savefig("../img/$(filename).png")
    return
end

# Euler Method
function euler!(y::AbstractArray, n_max::Int, h::Float64)
    for n = 0:n_max-1
        y[:,n+1] = y[:,n] + diff(y[:,n])h
    end
    return y
end

# main
function main()
    plot(xlabel=L"p", ylabel=L"\log_2E_r", title=L"\rm{Euler\;Method}")
    Erplot(euler!, "3_2_2-c")
end

main()
