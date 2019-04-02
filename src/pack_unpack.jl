function pack(X::AbstractArray{T,2}) where T
    isbitstype(T) || error("$(T) is not a bitstype")
    size(X,2)==0 && return repeat([SArray{Tuple{0},T,1,0}()],size(X,1))
    return reinterpret(SVector{size(X,2),T}, vec(copy(transpose(X))))
end

# based on
# https://github.com/JuliaArrays/StaticArrays.jl/pull/496/commits/92287a299af7bfc47cf3b26c135c6ce6a4c99ba0
# function unpack(a::StridedVector{SArray{SZT, T, NDIMS, L}}) where {T,SZT,NDIMS,L}
#     isbitstype(T) || error("$(T) is not a bitstype")
#     szres = (size(eltype(a))..., size(a)...)
#     return copy(transpose(reshape(reinterpret(T, a),szres)))
# end


function new_unpack(a::StridedVector{SArray{SZT, T, NDIMS, L}}) where {T,SZT,NDIMS,L}
    k = L
    n = length(a)
    X = Matrix{T}(undef, n,k)
    @inbounds for rowid = 1:n
        X[rowid,:] .= a[rowid]
    end
    return X
end