# PackedMatrixMultiVectorProducts
module PackedMatrixMultiVectorProducts
using LinearAlgebra
using SparseArrays
using StaticArrays
using MatrixNetworks
using BenchmarkTools

include("pack_unpack.jl")

export pack,unpack
end
