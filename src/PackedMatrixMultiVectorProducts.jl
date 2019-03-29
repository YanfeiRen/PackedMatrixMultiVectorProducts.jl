# PackedMatrixMultiVectorProducts

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
