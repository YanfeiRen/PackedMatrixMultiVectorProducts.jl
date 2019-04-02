
Code to reproduce:
```
PackedMatrixMultiVectorProducts.benchmark()
```
Results
## Benchmarks of `A*X`
```
##### Benchmarks for A*X #####
***** k = 2 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 2)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.33 KiB
  allocs estimate:  2
  --------------
  minimum time:     3.050 ms (0.00% GC)
  median time:      3.067 ms (0.00% GC)
  mean time:        3.175 ms (2.47% GC)
  maximum time:     100.093 ms (92.80% GC)
  --------------
  samples:          1574
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  25
  --------------
  minimum time:     2.474 ms (0.00% GC)
  median time:      2.504 ms (0.00% GC)
  mean time:        2.599 ms (3.18% GC)
  maximum time:     100.142 ms (93.67% GC)
  --------------
  samples:          1922
  evals/sample:     1
###################
***** k = 4 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 4)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  2
  --------------
  minimum time:     5.233 ms (0.00% GC)
  median time:      5.527 ms (0.00% GC)
  mean time:        5.575 ms (2.20% GC)
  maximum time:     76.026 ms (89.49% GC)
  --------------
  samples:          897
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  25
  --------------
  minimum time:     3.205 ms (0.00% GC)
  median time:      3.251 ms (0.00% GC)
  mean time:        3.393 ms (3.73% GC)
  maximum time:     73.461 ms (93.89% GC)
  --------------
  samples:          1472
  evals/sample:     1
###################
***** k = 8 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 8)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  2
  --------------
  minimum time:     10.494 ms (0.00% GC)
  median time:      10.635 ms (0.00% GC)
  mean time:        11.074 ms (2.36% GC)
  maximum time:     83.274 ms (82.85% GC)
  --------------
  samples:          452
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  25
  --------------
  minimum time:     5.172 ms (0.00% GC)
  median time:      5.385 ms (0.00% GC)
  mean time:        6.051 ms (5.59% GC)
  maximum time:     77.723 ms (88.67% GC)
  --------------
  samples:          826
  evals/sample:     1
###################
***** k = 16 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 16)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  2
  --------------
  minimum time:     21.220 ms (0.00% GC)
  median time:      21.407 ms (0.00% GC)
  mean time:        22.380 ms (2.51% GC)
  maximum time:     96.325 ms (72.02% GC)
  --------------
  samples:          224
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  25
  --------------
  minimum time:     14.750 ms (0.00% GC)
  median time:      15.667 ms (3.89% GC)
  mean time:        15.830 ms (4.60% GC)
  maximum time:     86.785 ms (79.79% GC)
  --------------
  samples:          316
  evals/sample:     1
###################
```
## Benchmarks of `A*X'`
```
##### Benchmarks for A*X' #####
***** k = 2 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 2)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.66 KiB
  allocs estimate:  8
  --------------
  minimum time:     18.461 s (0.00% GC)
  median time:      18.461 s (0.00% GC)
  mean time:        18.461 s (0.00% GC)
  maximum time:     18.461 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  25
  --------------
  minimum time:     2.274 ms (0.00% GC)
  median time:      2.299 ms (0.00% GC)
  mean time:        2.394 ms (3.17% GC)
  maximum time:     74.503 ms (94.10% GC)
  --------------
  samples:          2086
  evals/sample:     1
###################
***** k = 4 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 4)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  8
  --------------
  minimum time:     22.113 s (0.00% GC)
  median time:      22.113 s (0.00% GC)
  mean time:        22.113 s (0.00% GC)
  maximum time:     22.113 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  25
  --------------
  minimum time:     3.166 ms (0.00% GC)
  median time:      3.204 ms (0.00% GC)
  mean time:        3.350 ms (3.99% GC)
  maximum time:     74.253 ms (95.22% GC)
  --------------
  samples:          1491
  evals/sample:     1
###################
***** k = 8 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 8)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  8
  --------------
  minimum time:     29.484 s (0.00% GC)
  median time:      29.484 s (0.00% GC)
  mean time:        29.484 s (0.00% GC)
  maximum time:     29.484 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  25
  --------------
  minimum time:     5.044 ms (0.00% GC)
  median time:      5.412 ms (0.00% GC)
  mean time:        5.659 ms (5.32% GC)
  maximum time:     78.152 ms (89.73% GC)
  --------------
  samples:          883
  evals/sample:     1
###################
***** k = 16 *****
###################
typeof(A) = SparseArrays.SparseMatrixCSC{Float64,Int64}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 16)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  8
  --------------
  minimum time:     44.373 s (0.00% GC)
  median time:      44.373 s (0.00% GC)
  mean time:        44.373 s (0.00% GC)
  maximum time:     44.373 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  25
  --------------
  minimum time:     15.394 ms (0.00% GC)
  median time:      15.709 ms (3.72% GC)
  mean time:        16.046 ms (4.43% GC)
  maximum time:     86.792 ms (80.86% GC)
  --------------
  samples:          312
  evals/sample:     1
###################
```

## Benchmarks of `A'*X`
```
##### Benchmarks for A'*X #####
***** k = 2 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 2)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.34 KiB
  allocs estimate:  3
  --------------
  minimum time:     2.655 ms (0.00% GC)
  median time:      2.672 ms (0.00% GC)
  mean time:        2.738 ms (2.13% GC)
  maximum time:     75.142 ms (93.69% GC)
  --------------
  samples:          1824
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  26
  --------------
  minimum time:     2.103 ms (0.00% GC)
  median time:      2.134 ms (0.00% GC)
  mean time:        2.217 ms (3.38% GC)
  maximum time:     74.620 ms (94.50% GC)
  --------------
  samples:          2252
  evals/sample:     1
###################
***** k = 4 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 4)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  3
  --------------
  minimum time:     4.566 ms (0.00% GC)
  median time:      4.628 ms (0.00% GC)
  mean time:        4.748 ms (2.28% GC)
  maximum time:     77.263 ms (91.09% GC)
  --------------
  samples:          1053
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  26
  --------------
  minimum time:     2.961 ms (0.00% GC)
  median time:      3.012 ms (0.00% GC)
  mean time:        3.171 ms (4.53% GC)
  maximum time:     74.258 ms (95.60% GC)
  --------------
  samples:          1575
  evals/sample:     1
###################
***** k = 8 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 8)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  3
  --------------
  minimum time:     9.913 ms (0.00% GC)
  median time:      9.968 ms (0.00% GC)
  mean time:        10.240 ms (2.32% GC)
  maximum time:     83.777 ms (84.46% GC)
  --------------
  samples:          489
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  26
  --------------
  minimum time:     5.121 ms (0.00% GC)
  median time:      5.329 ms (0.00% GC)
  mean time:        5.614 ms (5.30% GC)
  maximum time:     78.455 ms (89.98% GC)
  --------------
  samples:          890
  evals/sample:     1
###################
***** k = 16 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = Array{Float64,2}
size(A) = (50000, 50000)
size(X) = (50000, 16)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  3
  --------------
  minimum time:     20.244 ms (0.00% GC)
  median time:      20.336 ms (0.00% GC)
  mean time:        20.935 ms (2.41% GC)
  maximum time:     95.300 ms (74.58% GC)
  --------------
  samples:          239
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  26
  --------------
  minimum time:     39.183 ms (1.69% GC)
  median time:      40.272 ms (1.46% GC)
  mean time:        40.886 ms (2.92% GC)
  maximum time:     111.801 ms (63.15% GC)
  --------------
  samples:          123
  evals/sample:     1
###################
```

## Benchmarks of `A'*X'`
```
##### Benchmarks for A'*X' #####
***** k = 2 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 2)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  781.66 KiB
  allocs estimate:  8
  --------------
  minimum time:     17.376 s (0.00% GC)
  median time:      17.376 s (0.00% GC)
  mean time:        17.376 s (0.00% GC)
  maximum time:     17.376 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  26
  --------------
  minimum time:     2.066 ms (0.00% GC)
  median time:      2.086 ms (0.00% GC)
  mean time:        2.134 ms (1.69% GC)
  maximum time:     4.170 ms (0.00% GC)
  --------------
  samples:          2340
  evals/sample:     1
###################
***** k = 4 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 4)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  1.53 MiB
  allocs estimate:  8
  --------------
  minimum time:     21.050 s (0.00% GC)
  median time:      21.050 s (0.00% GC)
  mean time:        21.050 s (0.00% GC)
  maximum time:     21.050 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  26
  --------------
  minimum time:     2.892 ms (0.00% GC)
  median time:      2.937 ms (0.00% GC)
  mean time:        3.043 ms (2.93% GC)
  maximum time:     5.201 ms (0.00% GC)
  --------------
  samples:          1642
  evals/sample:     1
###################
***** k = 8 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 8)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  3.05 MiB
  allocs estimate:  8
  --------------
  minimum time:     28.432 s (0.00% GC)
  median time:      28.432 s (0.00% GC)
  mean time:        28.432 s (0.00% GC)
  maximum time:     28.432 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  26
  --------------
  minimum time:     4.938 ms (0.00% GC)
  median time:      5.170 ms (0.00% GC)
  mean time:        5.465 ms (5.57% GC)
  maximum time:     77.644 ms (92.12% GC)
  --------------
  samples:          915
  evals/sample:     1
###################
***** k = 16 *****
###################
typeof(A) = LinearAlgebra.Adjoint{Float64,SparseArrays.SparseMatrixCSC{Float64,Int64}}
typeof(X) = LinearAlgebra.Adjoint{Float64,Array{Float64,2}}
size(A) = (50000, 50000)
size(X) = (50000, 16)
Benchmark Julia's matmul
BenchmarkTools.Trial: 
  memory estimate:  6.10 MiB
  allocs estimate:  8
  --------------
  minimum time:     43.321 s (0.00% GC)
  median time:      43.321 s (0.00% GC)
  mean time:        43.321 s (0.00% GC)
  maximum time:     43.321 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  26
  --------------
  minimum time:     41.628 ms (0.00% GC)
  median time:      42.571 ms (1.62% GC)
  mean time:        43.222 ms (2.95% GC)
  maximum time:     116.020 ms (61.47% GC)
  --------------
  samples:          116
  evals/sample:     1
###################
```

## Todo
# make this report auto-generated!
