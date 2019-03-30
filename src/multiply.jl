import Base.*

(LinearAlgebra.mul!(C::StridedVecOrMat{T}, A::SparseMatrixCSC, B::StridedVecOrMat{T})
  where T <: SArray = LinearAlgebra.mul!(C, A, B, one(eltype(T)), zero(eltype(T))))
*(A::SparseMatrixCSC{TA,S}, x::StridedVector{Tx}) where {TA,S,Tx <: SArray} =
    (T = promote_type(TA, eltype(Tx)); LinearAlgebra.mul!(similar(x, similar_type(Tx, T, Size(Tx)), A.m), A, x, one(T), zero(T)))
*(A::SparseMatrixCSC{TA,S}, B::StridedMatrix{Tx}) where {TA,S,Tx <: SArray} =
    (T = promote_type(TA, Tx); LinearAlgebra.mul!(similar(B, T, (A.m, size(B, 2))), A, B, one(T), zero(T)))
*(adjA::Adjoint{<:Any,<:SparseMatrixCSC{TA,S}}, x::StridedVector{Tx}) where {TA,S,Tx <: SArray} =
    (A = adjA.parent; T = promote_type(TA, eltype(Tx)); LinearAlgebra.mul!(similar(x, similar_type(Tx, T, Size(Tx)), A.n), adjoint(A), x, one(T), zero(T)))
*(adjA::Adjoint{<:Any,<:SparseMatrixCSC{TA,S}}, B::StridedMatrix{Tx}) where {TA,S,Tx <: SArray} =
    (A = adjA.parent; T = promote_type(TA, Tx); LinearAlgebra.mul!(similar(B, T, (A.n, size(B, 2))), adjoint(A), B, one(T), zero(T)))
*(transA::Transpose{<:Any,<:SparseMatrixCSC{TA,S}}, x::StridedVector{Tx}) where {TA,S,Tx <: SArray} =
    (A = transA.parent; T = promote_type(TA, eltype(Tx)); LinearAlgebra.mul!(similar(x, similar_type(Tx, T, Size(Tx)), A.n), transpose(A), x, one(T), zero(T)))
*(transA::Transpose{<:Any,<:SparseMatrixCSC{TA,S}}, B::StridedMatrix{Tx}) where {TA,S,Tx <: SArray} =
    (A = transA.parent; T = promote_type(TA, Tx); LinearAlgebra.mul!(similar(B, T, (A.n, size(B, 2))), transpose(A), B, one(T), zero(T)))
