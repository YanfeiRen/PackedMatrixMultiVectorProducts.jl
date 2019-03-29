# PackedMatrixMultiVectorProducts

# functions we will need:

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

#unpack(x::Vector{T}) #
function unpack(V::Vector{T}) where T <: SArray
    k = length(V[1])
    n = length(V)
    X = zeros(n,k)
    for colid = 1:n
        X[colid,:] = Vector(V[colid])
    end
    return X
end

# try a faster way
# function unpack2(V::Vector{T}) where T <: SArray
#     k = length(V[1])
#     n = length(V)
#     X = zeros(n,k)
#     for colid = 1:k
#         X[:,colid] = map(i->V[colid][i],1:n)
#     end
#     return X
# end
