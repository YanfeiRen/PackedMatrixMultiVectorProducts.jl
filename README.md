Linux and macOS: [![Build Status](https://travis-ci.org/nassarhuda/PackedMatrixMultiVectorProducts.jl.svg?branch=master)](https://travis-ci.org/nassarhuda/PackedMatrixMultiVectorProducts.jl)

[![Coverage Status](https://coveralls.io/repos/nassarhuda/PackedMatrixMultiVectorProducts.jl/badge.svg?branch=master)](https://coveralls.io/r/nassarhuda/PackedMatrixMultiVectorProducts.jl?branch=master)

# PackedMatrixMultiVectorProducts.jl

The goal of this package is to perform operations such
as `A*X`, `A'*X`, `A*X'`, `A'*X'` a little faster than Julia's builtin routines
where `A` is a sparse matrix and `X` is a matrix that 
represents a small number (less than 32, say) vectors.
To do so, we use the [StaticArrays.jl](https://github.com/JuliaArrays/StaticArrays.jl) 
package to encode the righthand side matrix to
a `Vector` of `StaticArrays`s. Using `StaticArrays` the compiler already
know the size of the vector we are multiplying by and hence it can generate
efficient SIMD code and code with better memory locality for a sparse matrix
vector product. The initial reason to build this
was to use multiple iterative methods at once and use
the accelerated computation to do this in less time. 

Our current code works when `A` is a dense matrix and also any
of the specialized types in the standard LinearAlgebra package
(`UniformScaling`, `Diagonal`, `Bidiagonal`, `Tridiagonal`, `Symmetric`,
`Hermitian`, `UpperTriangular`, `LowerTriangular`, `SymTridiagonal`) although
we make no claims about performance for these cases.

## Getting started and how to do a matrix-vector product.

First, acquire and load the package. 
```
using Pkg
Pkg.clone("https://github.com/YanfeiRen/PackedMatrixMultiVectorProducts.jl")
using PackedMatrixMultiVectorProducts
using SparseArrays
```

Second, allocate a sparse matrix and right hand side.
```
A = sprand(100,100,0.1)
X = randn(100,8)
```

Third, just replace `A*X` with `unpack(A*pack(X))`
```
YJulia = A*X
YPacked = unpack(A*pack(X))
@assert YJulia == YPacked
```

Of course, if you really want performance, you probably want to use 
the in-place operations
```
x = pack(X)  # start off by packing
y = similar(x, size(A,1))
mul!(y,A,x) # compute y = A*x
mul!(x,A,y) # compute x = A*y = A^2 x
mul!(y,A,x) # compute y = A*x = A^3 x now
Y = unpack(y) # convert pack to a matrix 
@assert Y ≈ A*(A*(A*X))
```

Because we expect the performance to vary a lot based on the
scenario, we include tools to make benchmarking easy. 
```
print_single_benchmark(PackedMatrixMultiVectorProducts.benchmark(A,X))
```

## Performance
In [benchmarks.md](benchmarks.md), we show benchmarks with for the 4 operations.
Also, we would advise not using more than 16 columns if you are interested in
performance. There are a few issues that slow down the computation with a large
number of columns.

Here is a quick sample of the performance results.
`x` and `y` are packed multi-vectors that represent the matrix `X` and `Y`.
So the benchmark compares
`mul!(Y,A,X)` vs. `mul!(y,A,x)` in the case where everything is pre-allocated
and `A*X` vs. `unpack(A*pack(X))` in the case where we allocate memory. 
Note that even with the allocations, all by one case are faster. 

At the moment, there is a performance issue with Julia for the case
of `X'*A'`, which results in very slow performance. (the last 4 rows...)

Benchmarks on `A` of size `1000-by-1000` and varying sizes of `X` (more benchmarks available in [benchmarks.md](benchmarks.md))
```
julia> PackedMatrixMultiVectorProducts.benchmark(1000)
```

| size(A)      | typeof(A)       | size(x)    | mul!(Y,A,X) | mul!(y,A,x) | Ratio | Julia's A*X | unpack(A*pack(X)) | Ratio |
|:------------ |:--------------- |:---------- | -----------:| -----------:| -----:| -----------:| -----------------:| -----:|
| (1000, 1000) | SparseMatrixCSC | (1000, 2)  |   23.454 μs |   12.756 μs |  1.84 |   25.842 μs |         22.462 μs |  1.15 |
| (1000, 1000) | SparseMatrixCSC | (1000, 4)  |   46.750 μs |   13.687 μs |  3.42 |   51.163 μs |         30.053 μs |   1.7 |
| (1000, 1000) | SparseMatrixCSC | (1000, 8)  |   92.942 μs |   15.868 μs |  5.86 |  101.470 μs |         45.475 μs |  2.23 |
| (1000, 1000) | SparseMatrixCSC | (1000, 16) |  186.950 μs |   75.710 μs |  2.47 |  200.991 μs |        121.567 μs |  1.65 |
| (1000, 1000) | SparseMatrixCSC | (2, 1000)  |   23.550 μs |   12.871 μs |  1.83 |   26.196 μs |         21.494 μs |  1.22 |
| (1000, 1000) | SparseMatrixCSC | (4, 1000)  |   47.135 μs |   13.471 μs |   3.5 |   51.480 μs |         27.614 μs |  1.86 |
| (1000, 1000) | SparseMatrixCSC | (8, 1000)  |   94.229 μs |   15.794 μs |  5.97 |  102.398 μs |         40.828 μs |  2.51 |
| (1000, 1000) | SparseMatrixCSC | (16, 1000) |  188.355 μs |   62.623 μs |  3.01 |  203.222 μs |        110.298 μs |  1.84 |
| (1000, 1000) | Adjoint         | (1000, 2)  |   21.170 μs |   10.959 μs |  1.93 |   23.754 μs |         22.099 μs |  1.07 |
| (1000, 1000) | Adjoint         | (1000, 4)  |   42.215 μs |   11.828 μs |  3.57 |   46.928 μs |         28.133 μs |  1.67 |
| (1000, 1000) | Adjoint         | (1000, 8)  |   84.390 μs |   13.138 μs |  6.42 |   92.927 μs |         43.127 μs |  2.15 |
| (1000, 1000) | Adjoint         | (1000, 16) |  168.312 μs |  441.177 μs |  0.38 |  182.696 μs |        505.777 μs |  0.36 |
| (1000, 1000) | Adjoint         | (2, 1000)  |   24.304 μs |   10.950 μs |  2.22 |   26.991 μs |         20.366 μs |  1.33 |
| (1000, 1000) | Adjoint         | (4, 1000)  |   49.046 μs |   11.834 μs |  4.14 |   53.713 μs |         25.723 μs |  2.09 |
| (1000, 1000) | Adjoint         | (8, 1000)  |   98.888 μs |   13.248 μs |  7.46 |  106.528 μs |         38.456 μs |  2.77 |
| (1000, 1000) | Adjoint         | (16, 1000) |  197.933 μs |  444.836 μs |  0.44 |  214.610 μs |        491.540 μs |  0.44 |

```
julia> versioninfo()
Julia Version 1.3.0-rc1.0
Commit 768b25f6a8 (2019-08-18 00:04 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Xeon(R) Platinum 8168 CPU @ 2.70GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.1 (ORCJIT, skylake)
```
