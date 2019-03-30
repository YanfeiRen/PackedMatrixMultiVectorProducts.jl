Linux and macOS: [![Build Status](https://travis-ci.org/YanfeiRen/PackedMatrixMultiVectorProducts.jl.svg?branch=master)](https://travis-ci.org/YanfeiRen/PackedMatrixMultiVectorProducts.jl)

[![Coverage Status](https://coveralls.io/repos/YanfeiRen/PackedMatrixMultiVectorProducts.jl/badge.svg?branch=master)](https://coveralls.io/r/YanfeiRen/PackedMatrixMultiVectorProducts.jl?branch=master)

# PackedMatrixMultiVectorProducts.jl

The goal of this package is to perform operations such as `A*X`, `A'*X`, `A*X'`, `A'*X'` faster than Julia's builtin routines.
It takes advantage of a key component and that is StaticArrays. We transform the righthand side matrix to a `Vector` of `SVector`s. The advantage we get is, with `StaticArrays` the compiler already know the size of the vector we are multiplying by.

This package performs operations such as `A*X`, `A'*X`, `A*X'`, `A'*X'` when `A` is sparse and `X` is dense. Below, we show benchmarks with for the 4 operations. These operations are extendable to `A` being dense and special types of matrices. (This is the next step for this package).

TODO: Note about the number of columns of `X`

## Getting started
```
using Pkg
Pkg.clone("https://github.com/YanfeiRen/PackedMatrixMultiVectorProducts.jl")
using PackedMatrixMultiVectorProducts
using BenchmarkTools
A = sprand(100,100,0.1)
X = randn(100,8)
YJulia = A*X
YPacked = unpack(A*pack(X))
@assert YJulia == YPacked
```

## Benchmarks of `A*X`
Code to reproduce:
```
function run_benchmarks_AmulX(n,p,kvalues)
    A = sprand(n,n,p)
    for k in kvalues
        X = randn(n,k)
        @assert A*X ≈ unpack(A*pack(X))
        println("###################")
        println("k = $k")
        println("Benchmark Julia's matmul")
        b = @benchmark $A*$X
        display(b)
        println("")
        println("Benchmark PackedMatrixMultiVectorProducts")
        b = @benchmark unpack($A*pack($X))
        display(b)
        println("###################")
    end
end
```
Results
```
julia> run_benchmarks_AmulX(50_000,10/50_000,[2,4,8,16])
###################
k = 2
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.33 KiB
  allocs estimate:  2
  --------------
  minimum time:     3.199 ms (0.00% GC)
  median time:      3.256 ms (0.00% GC)
  mean time:        3.308 ms (0.60% GC)
  maximum time:     7.290 ms (0.00% GC)
  --------------
  samples:          1511
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  25
  --------------
  minimum time:     2.608 ms (0.00% GC)
  median time:      2.642 ms (0.00% GC)
  mean time:        2.706 ms (2.20% GC)
  maximum time:     6.236 ms (0.00% GC)
  --------------
  samples:          1846
  evals/sample:     1
###################
###################
k = 4
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  2
  --------------
  minimum time:     6.423 ms (0.00% GC)
  median time:      6.582 ms (0.00% GC)
  mean time:        6.669 ms (0.68% GC)
  maximum time:     11.369 ms (0.00% GC)
  --------------
  samples:          750
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  25
  --------------
  minimum time:     3.320 ms (0.00% GC)
  median time:      3.414 ms (0.00% GC)
  mean time:        3.561 ms (3.50% GC)
  maximum time:     7.423 ms (0.00% GC)
  --------------
  samples:          1403
  evals/sample:     1
###################
###################
k = 8
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  2
  --------------
  minimum time:     10.957 ms (0.00% GC)
  median time:      11.705 ms (0.00% GC)
  mean time:        11.993 ms (0.86% GC)
  maximum time:     14.319 ms (5.96% GC)
  --------------
  samples:          417
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  25
  --------------
  minimum time:     5.366 ms (0.00% GC)
  median time:      5.509 ms (0.00% GC)
  mean time:        5.816 ms (5.62% GC)
  maximum time:     8.199 ms (0.00% GC)
  --------------
  samples:          859
  evals/sample:     1
###################
###################
k = 16
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  2
  --------------
  minimum time:     21.835 ms (0.00% GC)
  median time:      22.232 ms (0.00% GC)
  mean time:        22.779 ms (1.07% GC)
  maximum time:     28.070 ms (0.00% GC)
  --------------
  samples:          220
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  25
  --------------
  minimum time:     14.822 ms (0.00% GC)
  median time:      16.271 ms (6.32% GC)
  mean time:        15.956 ms (5.04% GC)
  maximum time:     17.190 ms (5.92% GC)
  --------------
  samples:          314
  evals/sample:     1
###################
```
## Benchmarks of `A*X'`
Code to reproduce:
```
function run_benchmarks_AmulXt(n,p,kvalues)
    A = sprand(n,n,p)
    for k in kvalues
        X = randn(k,n)
        @assert A*X' ≈ unpack(A*pack(X'))
        println("###################")
        println("k = $k")
        println("Benchmark Julia's matmul")
        b = @benchmark $A*$X'
        display(b)
        println("")
        println("Benchmark PackedMatrixMultiVectorProducts")
        b = @benchmark unpack($A*pack($X'))
        display(b)
        println("###################")
    end
end
```
Results:
```
julia> run_benchmarks_AmulXt(50_000,10/50_000,[2,4,8,16])
###################
k = 2
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.67 KiB
  allocs estimate:  9
  --------------
  minimum time:     17.979 s (0.00% GC)
  median time:      17.979 s (0.00% GC)
  mean time:        17.979 s (0.00% GC)
  maximum time:     17.979 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  26
  --------------
  minimum time:     2.290 ms (0.00% GC)
  median time:      2.320 ms (0.00% GC)
  mean time:        2.370 ms (1.97% GC)
  maximum time:     4.632 ms (0.00% GC)
  --------------
  samples:          2107
  evals/sample:     1
###################
###################
k = 4
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  9
  --------------
  minimum time:     21.685 s (0.00% GC)
  median time:      21.685 s (0.00% GC)
  mean time:        21.685 s (0.00% GC)
  maximum time:     21.685 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  26
  --------------
  minimum time:     3.171 ms (0.00% GC)
  median time:      3.228 ms (0.00% GC)
  mean time:        3.347 ms (3.30% GC)
  maximum time:     5.691 ms (0.00% GC)
  --------------
  samples:          1493
  evals/sample:     1
###################
###################
k = 8
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  9
  --------------
  minimum time:     29.122 s (0.00% GC)
  median time:      29.122 s (0.00% GC)
  mean time:        29.122 s (0.00% GC)
  maximum time:     29.122 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  26
  --------------
  minimum time:     5.022 ms (0.00% GC)
  median time:      5.193 ms (0.00% GC)
  mean time:        5.440 ms (5.08% GC)
  maximum time:     8.329 ms (0.00% GC)
  --------------
  samples:          919
  evals/sample:     1
###################
###################
k = 16
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  9
  --------------
  minimum time:     43.992 s (0.00% GC)
  median time:      43.992 s (0.00% GC)
  mean time:        43.992 s (0.00% GC)
  maximum time:     43.992 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  26
  --------------
  minimum time:     15.306 ms (0.00% GC)
  median time:      17.887 ms (5.16% GC)
  mean time:        18.106 ms (5.10% GC)
  maximum time:     23.741 ms (4.24% GC)
  --------------
  samples:          276
  evals/sample:     1
###################
```

## Benchmarks of `A'*X`
Code to reproduce:
```
function run_benchmarks_AtmulX(n,p,kvalues)
    A = sprand(n,n,p)
    for k in kvalues
        X = randn(n,k)
        @assert A'*X ≈ unpack(A'*pack(X))
        println("###################")
        println("k = $k")
        println("Benchmark Julia's matmul")
        b = @benchmark $A'*$X
        display(b)
        println("")
        println("Benchmark PackedMatrixMultiVectorProducts")
        b = @benchmark unpack($A'*pack($X))
        display(b)
        println("###################")
    end
end
```
Results:
```
julia> run_benchmarks_AtmulX(50_000,10/50_000,[2,4,8,16])
###################
k = 2
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.34 KiB
  allocs estimate:  3
  --------------
  minimum time:     2.798 ms (0.00% GC)
  median time:      2.812 ms (0.00% GC)
  mean time:        2.844 ms (0.76% GC)
  maximum time:     6.174 ms (0.00% GC)
  --------------
  samples:          1757
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  27
  --------------
  minimum time:     2.345 ms (0.00% GC)
  median time:      2.370 ms (0.00% GC)
  mean time:        2.440 ms (2.58% GC)
  maximum time:     5.807 ms (0.00% GC)
  --------------
  samples:          2047
  evals/sample:     1
###################
###################
k = 4
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  3
  --------------
  minimum time:     5.594 ms (0.00% GC)
  median time:      5.634 ms (0.00% GC)
  mean time:        5.690 ms (0.81% GC)
  maximum time:     9.199 ms (0.00% GC)
  --------------
  samples:          879
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  27
  --------------
  minimum time:     3.023 ms (0.00% GC)
  median time:      3.076 ms (0.00% GC)
  mean time:        3.230 ms (4.44% GC)
  maximum time:     5.346 ms (0.00% GC)
  --------------
  samples:          1546
  evals/sample:     1
###################
###################
k = 8
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  3
  --------------
  minimum time:     9.856 ms (0.00% GC)
  median time:      9.933 ms (0.00% GC)
  mean time:        10.049 ms (1.02% GC)
  maximum time:     12.819 ms (0.00% GC)
  --------------
  samples:          498
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  27
  --------------
  minimum time:     5.089 ms (0.00% GC)
  median time:      5.205 ms (0.00% GC)
  mean time:        5.532 ms (5.62% GC)
  maximum time:     8.085 ms (0.00% GC)
  --------------
  samples:          903
  evals/sample:     1
###################
###################
k = 16
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  3
  --------------
  minimum time:     19.051 ms (0.00% GC)
  median time:      19.384 ms (0.00% GC)
  mean time:        19.622 ms (1.34% GC)
  maximum time:     23.176 ms (0.00% GC)
  --------------
  samples:          255
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  27
  --------------
  minimum time:     40.228 ms (0.00% GC)
  median time:      42.028 ms (2.77% GC)
  mean time:        41.902 ms (2.18% GC)
  maximum time:     44.720 ms (0.00% GC)
  --------------
  samples:          120
  evals/sample:     1
###################
```

## Benchmarks of `A'*X'`
Code to reproduce:
```
function run_benchmarks_AtmulXt(n,p,kvalues)
    A = sprand(n,n,p)
    for k in kvalues
        X = randn(k,n)
        @assert A'*X' ≈ unpack(A'*pack(X'))
        println("###################")
        println("k = $k")
        println("Benchmark Julia's matmul")
        b = @benchmark $A'*$X'
        display(b)
        println("")
        println("Benchmark PackedMatrixMultiVectorProducts")
        b = @benchmark unpack($A'*pack($X'))
        display(b)
        println("###################")
    end
end
```
Results:
```
julia> run_benchmarks_AtmulXt(50_000,10/50_000,[2,4,8,16])
###################
k = 2
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.69 KiB
  allocs estimate:  10
  --------------
  minimum time:     17.388 s (0.00% GC)
  median time:      17.388 s (0.00% GC)
  mean time:        17.388 s (0.00% GC)
  maximum time:     17.388 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  28
  --------------
  minimum time:     2.123 ms (0.00% GC)
  median time:      2.149 ms (0.00% GC)
  mean time:        2.222 ms (2.79% GC)
  maximum time:     4.374 ms (0.00% GC)
  --------------
  samples:          2247
  evals/sample:     1
###################
###################
k = 4
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  10
  --------------
  minimum time:     21.101 s (0.00% GC)
  median time:      21.101 s (0.00% GC)
  mean time:        21.101 s (0.00% GC)
  maximum time:     21.101 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  28
  --------------
  minimum time:     2.965 ms (0.00% GC)
  median time:      3.005 ms (0.00% GC)
  mean time:        3.162 ms (4.34% GC)
  maximum time:     5.452 ms (0.00% GC)
  --------------
  samples:          1579
  evals/sample:     1
###################
###################
k = 8
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  10
  --------------
  minimum time:     28.501 s (0.00% GC)
  median time:      28.501 s (0.00% GC)
  mean time:        28.501 s (0.00% GC)
  maximum time:     28.501 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  28
  --------------
  minimum time:     4.954 ms (0.00% GC)
  median time:      5.084 ms (0.00% GC)
  mean time:        5.345 ms (5.54% GC)
  maximum time:     8.156 ms (0.00% GC)
  --------------
  samples:          935
  evals/sample:     1
###################
###################
k = 16
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  10
  --------------
  minimum time:     43.356 s (0.00% GC)
  median time:      43.356 s (0.00% GC)
  mean time:        43.356 s (0.00% GC)
  maximum time:     43.356 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  28
  --------------
  minimum time:     42.007 ms (0.00% GC)
  median time:      43.619 ms (2.97% GC)
  mean time:        44.095 ms (2.05% GC)
  maximum time:     48.227 ms (2.57% GC)
  --------------
  samples:          114
  evals/sample:     1
###################
```
