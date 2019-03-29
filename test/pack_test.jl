using Test
@testset "pack_vectors" begin
    X = rand(100,10)
    Xpack = pack(X)
    @test X == unpack(Xpack)
end


