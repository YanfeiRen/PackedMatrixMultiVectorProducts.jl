import Base.*

(LinearAlgebra.mul!(C::StridedVecOrMat{T}, A::SparseMatrixCSC, B::StridedVecOrMat{T})
  where T <: SArray = LinearAlgebra.mul!(C, A, B, one(eltype(T)), zero(eltype(T))))
*(A::SparseMatrixCSC{TA,S}, x::StridedVector{Tx}) where {TA,S,Tx <: SArray} =
    (T = promote_type(TA, eltype(Tx)); LinearAlgebra.mul!(similar(x, similar_type(Tx, T, Size(Tx)), A.m), A, x, one(T), zero(T)))
*(A::SparseMatrixCSC{TA,S}, B::StridedMatrix{Tx}) where {TA,S,Tx <: SArray} =
    (T = promote_type(TA, Tx); LinearAlgebra.mul!(similar(B, T, (A.m, size(B, 2))), A, B, one(T), zero(T)))
