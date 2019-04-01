using SparseArrays
using LinearAlgebra
@testset "mat_multi_vec" begin
    A = sprand(10_000,10_000,1/10_000)
    X = randn(10_000,32)
    @test A*X ≈ unpack(A*pack(X))

    X = randn(32,10_000)
    @test A*X' ≈ unpack(A*pack(X'))
end

@testset "operation_tests" begin
    X = randn(10,2)
    @test (5I)*X == unpack((5I)*pack(X))

    D = Diagonal(randn(10))
    @test (D)*X == unpack((D)*pack(X))

    T = Tridiagonal(randn(10,10))
    @test (T)*X == unpack((T)*pack(X))

    #L = LowerTriangular(ones(10,10))
    #@test (L)*X == unpack((L)*pack(X))
end
