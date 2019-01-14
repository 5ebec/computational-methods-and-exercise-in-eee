using OffsetArrays
using LinearAlgebra
using LaTeXStrings
using Plots
pyplot(w=3, legend=false)

const σ = 10.
const b = 8/3
const r = 28
const Δt = 0.001
const t_max = 10

# diff
diff(y::AbstractArray) = [σ*(y[2] - y[1])
                          r*y[1] - y[2] - y[1]*y[3]
                          y[1]*y[2] - b*y[3]]

# y init
yinit(y0::AbstractArray, n_max::Int) = OffsetArray(hcat(y0, zeros(Float64, 3, n_max)), 1:3, 0:n_max)

# the classical Runge–Kutta method
function RK4!(y::AbstractArray, n_max::Int, h::Float64)
    for n = 0:n_max-1
        k₁ = diff(y[:,n])h
        k₂ = diff(y[:,n] + k₁/2)h
        k₃ = diff(y[:,n] + k₂/2)h
        k₄ = diff(y[:,n] + k₃)h
        y[:,n+1] = y[:,n] + (k₁+2k₂+2k₃+k₄)/6
    end
    return y
end

# y1 time evolution
function y1timeevo(y0::AbstractArray, n_max::Int, Δx::Float64, filename::String)
    y = yinit(y0, n_max)
    yc = RK4!(y, n_max, Δx)
    plot!((0:n_max)*Δx, yc[1,0:n_max], xlabel=L"t", ylabel=L"y_1")
    savefig("../img/$(filename).png")
    return
end

# (y1, y2) locus
function y1y2locus(y0::AbstractArray, n_max::Int, Δx::Float64, filename::String)
    y = yinit(y0, n_max)
    yc = RK4!(y, n_max, Δx)
    plot!(yc[1,0:n_max], yc[2,0:n_max], xlabel=L"y_1", ylabel=L"y_2")
    savefig("../img/$(filename).png")
    return
end

# main
function main()
    plot(title=L"y_1(t) \; (y(0)=[1; 0; 20])")
    y1timeevo([1.; 0.; 20.], Int(t_max/Δt), Δt, "3_3_1-a")
    plot(title=L"(y_1(t),y_2(t)) \; (y(0)=[1; 0; 20])")
    y1y2locus([1.; 0.; 20.], Int(t_max/Δt), Δt, "3_3_1-b")
end

main()
