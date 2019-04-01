using Test
@testset "pack_vectors" begin
    X = rand(100,10)
    Xpack = pack(X)
    @test X == unpack(Xpack)

    X = rand(Int, 0,10)
    Xpack = pack(X)
    @test X == unpack(Xpack)

    X = rand(Int, 1,10)
    @test X == unpack(pack(X))

    X = rand(Int, 5,1)
    @test X == unpack(pack(X))

    X = rand(Complex{Float64}, 10,1)
    @test X == unpack(pack(X))

    for  T = [Int8,Int16,Int32,Int64,Float32,Float64,Complex{Float32},Complex{Float64}]
        #for sz = [(0,0), (1,0), (0,1), (5,0), (0,5), (2,5), (5,5), (5,2), (100,10)]
        for sz = [(1,1), (5,1), (1,5), (2,5), (5,5), (5,2), (100,10)]
            X = rand(T,sz...)
            @test X == unpack(pack(X))
        end
    end
end


@testset "pack_empty_vectors" begin
    # just throw the errors for Float64 now...
    for  T = [Int8,Int16,Int32,Int64,Float32,Float64,Complex{Float32},Complex{Float64}]
        for sz = [(0,0), (1,0), (0,1), (5,0), (0,5)]
            X = rand(T,sz...)
            @test X == unpack(pack(X))
        end
    end
end
