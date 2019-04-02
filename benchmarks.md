
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
  minimum time:     2.990 ms (0.00% GC)
  median time:      3.005 ms (0.00% GC)
  mean time:        3.086 ms (1.82% GC)
  maximum time:     74.153 ms (90.40% GC)
  --------------
  samples:          1619
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  23
  --------------
  minimum time:     1.704 ms (0.00% GC)
  median time:      1.902 ms (0.00% GC)
  mean time:        1.916 ms (2.83% GC)
  maximum time:     73.163 ms (92.01% GC)
  --------------
  samples:          2606
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
  minimum time:     5.168 ms (0.00% GC)
  median time:      5.192 ms (0.00% GC)
  mean time:        5.298 ms (1.56% GC)
  maximum time:     59.448 ms (86.74% GC)
  --------------
  samples:          944
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  23
  --------------
  minimum time:     2.086 ms (0.00% GC)
  median time:      2.147 ms (0.00% GC)
  mean time:        2.239 ms (3.75% GC)
  maximum time:     54.181 ms (95.31% GC)
  --------------
  samples:          2230
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
  minimum time:     10.356 ms (0.00% GC)
  median time:      11.445 ms (0.00% GC)
  mean time:        11.497 ms (1.62% GC)
  maximum time:     67.277 ms (77.39% GC)
  --------------
  samples:          435
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  23
  --------------
  minimum time:     3.055 ms (0.00% GC)
  median time:      3.335 ms (0.00% GC)
  mean time:        3.420 ms (5.37% GC)
  maximum time:     58.206 ms (89.67% GC)
  --------------
  samples:          1461
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
  minimum time:     20.869 ms (0.00% GC)
  median time:      22.566 ms (0.00% GC)
  mean time:        22.546 ms (2.12% GC)
  maximum time:     79.146 ms (66.33% GC)
  --------------
  samples:          222
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  23
  --------------
  minimum time:     10.186 ms (0.00% GC)
  median time:      12.182 ms (4.73% GC)
  mean time:        11.967 ms (5.56% GC)
  maximum time:     65.624 ms (79.54% GC)
  --------------
  samples:          418
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
  minimum time:     18.472 s (0.00% GC)
  median time:      18.472 s (0.00% GC)
  mean time:        18.472 s (0.00% GC)
  maximum time:     18.472 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  23
  --------------
  minimum time:     1.663 ms (0.00% GC)
  median time:      1.686 ms (0.00% GC)
  mean time:        1.757 ms (2.83% GC)
  maximum time:     56.947 ms (93.21% GC)
  --------------
  samples:          2842
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
  minimum time:     22.167 s (0.00% GC)
  median time:      22.167 s (0.00% GC)
  mean time:        22.167 s (0.00% GC)
  maximum time:     22.167 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  23
  --------------
  minimum time:     2.203 ms (0.00% GC)
  median time:      2.240 ms (0.00% GC)
  mean time:        2.468 ms (6.12% GC)
  maximum time:     77.481 ms (96.13% GC)
  --------------
  samples:          2024
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
  minimum time:     29.584 s (0.00% GC)
  median time:      29.584 s (0.00% GC)
  mean time:        29.584 s (0.00% GC)
  maximum time:     29.584 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  23
  --------------
  minimum time:     3.196 ms (0.00% GC)
  median time:      3.584 ms (0.00% GC)
  mean time:        3.859 ms (7.62% GC)
  maximum time:     84.567 ms (88.14% GC)
  --------------
  samples:          1294
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
  minimum time:     44.763 s (0.00% GC)
  median time:      44.763 s (0.00% GC)
  mean time:        44.763 s (0.00% GC)
  maximum time:     44.763 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  23
  --------------
  minimum time:     13.673 ms (0.00% GC)
  median time:      15.872 ms (6.00% GC)
  mean time:        15.656 ms (6.63% GC)
  maximum time:     95.191 ms (78.48% GC)
  --------------
  samples:          320
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
  minimum time:     2.401 ms (0.00% GC)
  median time:      2.433 ms (0.00% GC)
  mean time:        2.501 ms (2.29% GC)
  maximum time:     80.782 ms (92.03% GC)
  --------------
  samples:          1997
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  24
  --------------
  minimum time:     1.632 ms (0.00% GC)
  median time:      1.654 ms (0.00% GC)
  mean time:        1.746 ms (4.03% GC)
  maximum time:     80.467 ms (92.68% GC)
  --------------
  samples:          2857
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
  minimum time:     4.853 ms (0.00% GC)
  median time:      4.870 ms (0.00% GC)
  mean time:        5.011 ms (2.33% GC)
  maximum time:     83.939 ms (88.79% GC)
  --------------
  samples:          998
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  24
  --------------
  minimum time:     2.040 ms (0.00% GC)
  median time:      2.082 ms (0.00% GC)
  mean time:        2.249 ms (6.28% GC)
  maximum time:     77.342 ms (96.75% GC)
  --------------
  samples:          2219
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
  minimum time:     10.282 ms (0.00% GC)
  median time:      10.450 ms (0.00% GC)
  mean time:        11.046 ms (2.49% GC)
  maximum time:     96.929 ms (81.70% GC)
  --------------
  samples:          453
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  24
  --------------
  minimum time:     3.357 ms (0.00% GC)
  median time:      3.780 ms (0.00% GC)
  mean time:        4.048 ms (9.03% GC)
  maximum time:     84.155 ms (88.20% GC)
  --------------
  samples:          1234
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
  minimum time:     18.111 ms (0.00% GC)
  median time:      19.129 ms (0.00% GC)
  mean time:        20.057 ms (2.95% GC)
  maximum time:     101.556 ms (73.62% GC)
  --------------
  samples:          250
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  24
  --------------
  minimum time:     36.908 ms (0.00% GC)
  median time:      39.248 ms (2.60% GC)
  mean time:        40.527 ms (3.90% GC)
  maximum time:     118.482 ms (62.84% GC)
  --------------
  samples:          124
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
  minimum time:     17.557 s (0.00% GC)
  median time:      17.557 s (0.00% GC)
  mean time:        17.557 s (0.00% GC)
  maximum time:     17.557 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  2.29 MiB
  allocs estimate:  24
  --------------
  minimum time:     1.545 ms (0.00% GC)
  median time:      1.571 ms (0.00% GC)
  mean time:        1.624 ms (2.48% GC)
  maximum time:     6.011 ms (0.00% GC)
  --------------
  samples:          3073
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
  minimum time:     21.290 s (0.00% GC)
  median time:      21.290 s (0.00% GC)
  mean time:        21.290 s (0.00% GC)
  maximum time:     21.290 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  4.58 MiB
  allocs estimate:  24
  --------------
  minimum time:     1.789 ms (0.00% GC)
  median time:      1.842 ms (0.00% GC)
  mean time:        1.962 ms (5.05% GC)
  maximum time:     6.496 ms (0.00% GC)
  --------------
  samples:          2544
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
  minimum time:     28.655 s (0.00% GC)
  median time:      28.655 s (0.00% GC)
  mean time:        28.655 s (0.00% GC)
  maximum time:     28.655 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  9.16 MiB
  allocs estimate:  24
  --------------
  minimum time:     2.995 ms (0.00% GC)
  median time:      3.355 ms (0.00% GC)
  mean time:        3.659 ms (9.16% GC)
  maximum time:     80.682 ms (93.72% GC)
  --------------
  samples:          1365
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
  minimum time:     43.607 s (0.00% GC)
  median time:      43.607 s (0.00% GC)
  mean time:        43.607 s (0.00% GC)
  maximum time:     43.607 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

Benchmark PackedMatrixMultiVectorProducts
BenchmarkTools.Trial: 
  memory estimate:  18.31 MiB
  allocs estimate:  24
  --------------
  minimum time:     38.680 ms (2.61% GC)
  median time:      40.496 ms (2.45% GC)
  mean time:        41.055 ms (3.52% GC)
  maximum time:     117.588 ms (62.71% GC)
  --------------
  samples:          122
  evals/sample:     1
###################
```

## Todo
# make this report auto-generated!
