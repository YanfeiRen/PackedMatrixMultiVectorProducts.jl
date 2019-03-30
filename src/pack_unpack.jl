# TODO: we currently have an issue with X having a 0 dimension
# SVectors do no support this: (possibly a bug in their code)
#=
julia> SVector{0}([])
ERROR: UndefVarError: T not defined
Stacktrace:
 [1] SArray{Tuple{0},T,1,0} where T(::Tuple{}) at /Users/hudanassar/.julia/packages/StaticArrays/VyRz3/src/SVector.jl:19
 [2] convert at /Users/hudanassar/.julia/packages/StaticArrays/VyRz3/src/convert.jl:26 [inlined]
 [3] SArray{Tuple{0},T,1,0} where T(::Array{Any,1}) at /Users/hudanassar/.julia/packages/StaticArrays/VyRz3/src/convert.jl:7
 [4] top-level scope at none:0

julia> SVector{1}([0])
1-element SArray{Tuple{1},Int64,1,1}:
 0
=#
# But we should be able to support A*x when x is n-by-0
#=
julia> A = rand(n,k);

julia> x = rand(k,0);

julia> A*x
10×0 Array{Float64,2}

julia> @time A*x
  0.000005 seconds (5 allocations: 240 bytes)
10×0 Array{Float64,2}
=#
#= alternatively,
We could check the dimensions at the beginning and treat them as special cases
=#

function pack(X::AbstractArray{T,2}) where T
    isbitstype(T) || error("$(T) is not a bitstype")
    return reinterpret(SVector{size(X,2),T}, vec(copy(transpose(X))))
end

# based on
# https://github.com/JuliaArrays/StaticArrays.jl/pull/496/commits/92287a299af7bfc47cf3b26c135c6ce6a4c99ba0
function unpack(a::StridedVector{SArray{SZT, T, NDIMS, L}}) where {T,SZT,NDIMS,L}
    isbitstype(T) || error("$(T) is not a bitstype")
    szres = (size(eltype(a))..., size(a)...)
    return copy(transpose(reshape(reinterpret(T, a),szres)))
end
