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

| size(A)      | typeof(A)       | size(x)    | mul!(Y,A,X) | mul!(y,A,x) |  Ratio | Julia's A*X | unpack(A*pack(X)) |  Ratio |
|:------------ |:--------------- |:---------- | -----------:| -----------:| ------:| -----------:| -----------------:| ------:|
| (1000, 1000) | SparseMatrixCSC | (1000, 2)  |   33.154 μs |   15.876 μs |   2.09 |   34.247 μs |         24.106 μs |   1.42 |
| (1000, 1000) | SparseMatrixCSC | (1000, 4)  |   61.941 μs |   15.863 μs |    3.9 |   62.732 μs |         27.364 μs |   2.29 |
| (1000, 1000) | SparseMatrixCSC | (1000, 8)  |  123.407 μs |   24.793 μs |   4.98 |  125.089 μs |         43.959 μs |   2.85 |
| (1000, 1000) | SparseMatrixCSC | (1000, 16) |  248.119 μs |   88.641 μs |    2.8 |  249.962 μs |        127.159 μs |   1.97 |
| (1000, 1000) | SparseMatrixCSC | (2, 1000)  |    7.659 ms |   14.580 μs |  525.3 |    7.646 ms |         21.465 μs | 356.23 |
| (1000, 1000) | SparseMatrixCSC | (4, 1000)  |    9.285 ms |   16.129 μs | 575.66 |    9.277 ms |         25.918 μs | 357.93 |
| (1000, 1000) | SparseMatrixCSC | (8, 1000)  |   12.562 ms |   24.940 μs | 503.69 |   12.564 ms |         40.525 μs | 310.02 |
| (1000, 1000) | SparseMatrixCSC | (16, 1000) |   19.201 ms |   88.249 μs | 217.58 |   19.200 ms |        120.361 μs | 159.52 |
| (1000, 1000) | Adjoint         | (1000, 2)  |   28.041 μs |   14.380 μs |   1.95 |   29.448 μs |         20.752 μs |   1.42 |
| (1000, 1000) | Adjoint         | (1000, 4)  |   55.757 μs |   14.817 μs |   3.76 |   57.497 μs |         29.225 μs |   1.97 |
| (1000, 1000) | Adjoint         | (1000, 8)  |  111.909 μs |   20.850 μs |   5.37 |  113.699 μs |         40.880 μs |   2.78 |
| (1000, 1000) | Adjoint         | (1000, 16) |  224.365 μs |  498.570 μs |   0.45 |  226.214 μs |        535.645 μs |   0.42 |
| (1000, 1000) | Adjoint         | (2, 1000)  |    7.801 ms |   12.769 μs | 610.93 |    7.786 ms |         20.492 μs | 379.94 |
| (1000, 1000) | Adjoint         | (4, 1000)  |    9.286 ms |   14.688 μs | 632.24 |    9.262 ms |         26.572 μs | 348.56 |
| (1000, 1000) | Adjoint         | (8, 1000)  |   12.240 ms |   21.467 μs |  570.2 |   12.232 ms |         38.212 μs |  320.1 |
| (1000, 1000) | Adjoint         | (16, 1000) |   18.180 ms |  498.760 μs |  36.45 |   18.196 ms |        529.596 μs |  34.36 |
```
