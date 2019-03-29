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

# pack and unpack functions we will need:
function pack(X::AbstractArray{T,2}) where T<:Real
    # convert to Vector{SVector{size(k),T}}
    Xt = X'
    vector_size,nvectors = size(Xt)
    V = Vector{SArray{Tuple{vector_size},T,1,vector_size}}(undef,nvectors)
    for i = 1:nvectors
        V[i] = SVector{vector_size}(Xt[:,i])
    end
    return V
end

function pack(X::Adjoint{T,AbstractArray{T,2}}) where T<:Real
    # convert to Vector{SVector{size(k),T}}
    Xt = X.parent
    vector_size,nvectors = size(Xt)
    V = Vector{SArray{Tuple{vector_size},T,1,vector_size}}(undef,nvectors)
    for i = 1:nvectors
        V[i] = SVector{vector_size}(Xt[:,i])
    end
    return V
end

# function unpack(V::Vector{T}) where T <: SArray
#     k = length(V[1])
#     n = length(V)
#     X = zeros(n,k)
#     for colid = 1:n
#         X[colid,:] = Vector(V[colid])
#     end
#     return X
# end

# this method is faster and uses less allocations
function unpack(V::Vector{T}) where T <: SArray
    k = length(V[1])
    n = length(V)
    X = zeros(n,k)
    for colid = 1:k
        X[:,colid] = map(i->V[i][colid],1:n)
    end
    return X
end
