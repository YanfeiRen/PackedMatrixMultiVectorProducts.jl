Linux and macOS: [![Build Status](https://travis-ci.org/YanfeiRen/PackedMatrixMultiVectorProducts.jl.svg?branch=master)](https://travis-ci.org/YanfeiRen/PackedMatrixMultiVectorProducts.jl)

[![Coverage Status](https://coveralls.io/repos/YanfeiRen/PackedMatrixMultiVectorProducts.jl/badge.svg?branch=master)](https://coveralls.io/r/YanfeiRen/PackedMatrixMultiVectorProducts.jl?branch=master)


[![codecov.io](http://codecov.io/github/YanfeiRen/PackedMatrixMultiVectorProducts.jl)]((http://codecov.io/github/YanfeiRen/PackedMatrixMultiVectorProducts.jl?branch=master)

# PackedMatrixMultiVectorProducts.jl

The goal of this package is to perform operations such
as `A*X`, `A'*X`, `A*X'`, `A'*X'` a little faster than Julia's builtin routines
for a few vectors encoded into a matrix X.
To do so, we use the StaticArrays to encode the righthand side matrix to
a `Vector` of `StaticArrays`s. Using `StaticArrays` the compiler already
know the size of the vector we are multiplying by and hence it can generate
efficient SIMD code.

The initial reason to build this
was to use multiple iterative methods at once and use
the SIMD feature to do this in less time. Hence, we are interested in the case
when `A` is sparse and `X` is dense.
In [benchmarks.md](benchmarks.md), we show benchmarks with for the 4 operations.
Our current code works, however, when `A` is a dense matrix and also any
of the specialized types in the standard LinearAlgebra package
(`UniformScaling`, `Diagonal`, `Bidiagonal`, `Tridiagonal`, `Symmetric`,
`Hermitian`, `UpperTriangular`, `LowerTriangular`, `SymTridiagonal`) although
we make no claims about performance for these cases.

Also, we would advise not using more than 16 columns if you are interested in
performance. There are a few issues that slow down the computation with a large
number of columns.

## Getting started and how to do a matrix-vector product.
```
using Pkg
Pkg.clone("https://github.com/YanfeiRen/PackedMatrixMultiVectorProducts.jl")
using PackedMatrixMultiVectorProducts
A = sprand(100,100,0.1)
X = randn(100,8)
YJulia = A*X
YPacked = unpack(A*pack(X))
@assert YJulia == YPacked
PackedMatrixMultiVectorProducts.benchmark(A,X)
```
