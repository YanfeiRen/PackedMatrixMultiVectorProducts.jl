using SparseArrays
using LinearAlgebra

@testset "operation_tests" begin
    n = 10
    for k = [1,2,4,8,16]
        X = randn(n,k)
        @test (5I)*X == unpack((5I)*pack(X))

        D = Diagonal(randn(10))
        @test (D)*X == unpack((D)*pack(X))

        MySymTridiagonal(X) = SymTridiagonal(X+X')
        BidiagU(X) = Bidiagonal(X,:U)
        BidiagL(X) = Bidiagonal(X,:L)

        for Mtype = [Symmetric,Hermitian,UpperTriangular,LowerTriangular,
                     Tridiagonal,MySymTridiagonal,BidiagU,BidiagL]
            M = Mtype(randn(10,10))
            @test (M)*X ≈ unpack((M)*pack(X))
        end
    end
end

@testset "* operators" begin
    for k = [1, 4, 8, 16]
        for  TA = [Float32, Float64, Complex{Float32}, Complex{Float64}]
            m = rand(1:100)
            n = rand(1:100)
            A = sprand(TA, m, n, 1/max(m, n))
            for TX = [Int8, Int16, Int32, Int64, Float32, Float64, Complex{Float32}, Complex{Float64}]

                X = TX.(rand(0:1, n, k))
                @test A*X ≈ unpack(A*pack(X))

                X = TX.(rand(0:1, m, k))
                @test A'*X ≈ unpack(A'*pack(X))

                X = TX.(rand(0:1, k, n))
                @test A*X' ≈ unpack(A*pack(X'))

                X = TX.(rand(0:1, k, m))
                @test A'*X' ≈ unpack(A'*pack(X'))
            end
        end

        for TA = [Int8, Int16, Int32, Int64]
            m = rand(1:100)
            n = rand(1:100)
            A = TA.(sparse(rand(0:1, m, n)))
            for TX = [Int8, Int16, Int32, Int64, Float32, Float64, Complex{Float32}, Complex{Float64}]

                X = TX.(rand(0:1, n, k))
                @test A*X ≈ unpack(A*pack(X))

                X = TX.(rand(0:1, m, k))
                @test A'*X ≈ unpack(A'*pack(X))

                X = TX.(rand(0:1, k, n))
                @test A*X' ≈ unpack(A*pack(X'))

                X = TX.(rand(0:1, k, m))
                @test A'*X' ≈ unpack(A'*pack(X'))
            end
        end
    end
end


@testset "mul!" begin
    for k = [1, 4, 8, 16]
        for T = [Int8, Int16, Int32, Int64, Float32, Float64, Complex{Float32}, Complex{Float64}]
            m = rand(1:100)
            n = rand(1:100)
            A = sprand(T, m, n, 1/max(m, n))

            Y = zeros(T, m, k)
            X = rand(T, n, k)
            @test mul!(Y, A, X) ≈ unpack(mul!(pack(Y), A, pack(X)))
            X = rand(T, k, n)
            @test mul!(Y, A, X') ≈ unpack(mul!(pack(Y), A, pack(X')))

            Y = zeros(T, n, k)
            X = rand(T, m, k)
            @test mul!(Y, A', X) ≈ unpack(mul!(pack(Y), A', pack(X)))
            X = rand(T, k, m)
            @test mul!(Y, A', X') ≈ unpack(mul!(pack(Y), A', pack(X')))
        end
    end
end
