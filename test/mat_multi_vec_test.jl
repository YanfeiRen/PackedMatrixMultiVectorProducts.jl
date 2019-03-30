@testset "mat_multi_vec" begin
    A = sprand(10_000,10_000,1/10_000)
    X = randn(10_000,32)
    @test A*X ≈ unpack(A*pack(X))
     
    X = randn(32,10_000)
    @test A*X' ≈ unpack(A*pack(X'))
end