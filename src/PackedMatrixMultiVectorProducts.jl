# PackedMatrixMultiVectorProducts
module PackedMatrixMultiVectorProducts
using LinearAlgebra
using SparseArrays
using StaticArrays
using BenchmarkTools

include("pack_unpack.jl")
include("multiply.jl")
include("benchmark.jl")

export pack,unpack,*
end
