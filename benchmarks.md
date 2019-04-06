
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

## n = 100
```
julia> PackedMatrixMultiVectorProducts.benchmark(100)
| size(A)    | typeof(A)       | size(x)   | mul!(Y,A,X) | mul!(y,A,x) | Ratio | Julia's A*X | unpack(A*pack(X)) | Ratio |
|:---------- |:--------------- |:--------- | -----------:| -----------:| -----:| -----------:| -----------------:| -----:|
| (100, 100) | SparseMatrixCSC | (100, 2)  |    2.560 μs |    1.206 μs |  2.12 |    2.714 μs |          3.385 μs |   0.8 |
| (100, 100) | SparseMatrixCSC | (100, 4)  |    5.116 μs |    1.423 μs |  3.59 |    5.600 μs |          5.071 μs |   1.1 |
| (100, 100) | SparseMatrixCSC | (100, 8)  |   10.542 μs |    2.250 μs |  4.68 |   11.419 μs |          7.293 μs |  1.57 |
| (100, 100) | SparseMatrixCSC | (100, 16) |   20.438 μs |    8.015 μs |  2.55 |   22.093 μs |         16.069 μs |  1.37 |
| (100, 100) | SparseMatrixCSC | (2, 100)  |   92.403 μs |    1.244 μs | 74.27 |   86.612 μs |          3.248 μs | 26.66 |
| (100, 100) | SparseMatrixCSC | (4, 100)  |  108.465 μs |    1.210 μs | 89.64 |  109.364 μs |          4.814 μs | 22.72 |
| (100, 100) | SparseMatrixCSC | (8, 100)  |  141.394 μs |    2.147 μs | 65.86 |  142.252 μs |          6.677 μs | 21.31 |
| (100, 100) | SparseMatrixCSC | (16, 100) |  207.697 μs |    7.971 μs | 26.06 |  194.832 μs |         14.779 μs | 13.18 |
| (100, 100) | Adjoint         | (100, 2)  |    2.766 μs |    1.176 μs |  2.35 |    2.549 μs |          3.214 μs |  0.79 |
| (100, 100) | Adjoint         | (100, 4)  |    4.905 μs |    1.105 μs |  4.44 |    5.262 μs |          4.781 μs |   1.1 |
| (100, 100) | Adjoint         | (100, 8)  |   11.115 μs |    1.494 μs |  7.44 |   11.038 μs |          6.533 μs |  1.69 |
| (100, 100) | Adjoint         | (100, 16) |   19.540 μs |   50.530 μs |  0.39 |   20.988 μs |         58.226 μs |  0.36 |
| (100, 100) | Adjoint         | (2, 100)  |   88.338 μs |    1.012 μs | 87.33 |   89.471 μs |          3.098 μs | 28.88 |
| (100, 100) | Adjoint         | (4, 100)  |  103.730 μs |    1.111 μs | 93.41 |  104.953 μs |          4.515 μs | 23.25 |
| (100, 100) | Adjoint         | (8, 100)  |  133.322 μs |    1.523 μs | 87.52 |  135.610 μs |          6.487 μs |  20.9 |
| (100, 100) | Adjoint         | (16, 100) |  193.137 μs |   50.549 μs |  3.82 |  195.929 μs |         57.417 μs |  3.41 |
```

## n = 1000
```
julia> PackedMatrixMultiVectorProducts.benchmark(1000)
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
