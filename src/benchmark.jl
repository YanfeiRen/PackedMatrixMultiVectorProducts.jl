using Printf
function benchmark(A,X)
    @assert A*X ≈ unpack(A*pack(X))
    
    b1 = @benchmark mul!(Y,$A,$X) setup=(Y=zeros(size($A,1),size($X,2)))
    
    pX = pack(X)
    b2 = @benchmark mul!(Y,$A,$pX) setup=(Y=zeros(SVector{size($X,2),Float64},size($A,1)))
               
    b3 = @benchmark unpack($A*pack($X))
    
    m1 = median(b1.times)
    m2 = median(b2.times)
    m3 = median(b3.times)
    r1 = m1/m2
    r2 = m1/m3
    s1 = BenchmarkTools.prettytime(m1)
    s2 = BenchmarkTools.prettytime(m2)
    s3 = BenchmarkTools.prettytime(m3)
    
    typeof(X) <: Adjoint ? sizex = size(X.parent) : sizex = size(X)
    @printf("(%d,%d)\t(%d,%d)\t\t%s\t%s\t%s\t%.2f\t\t%.2f\n",
            size(A)...,
            sizex...,
            s1, s2, s3,
            r1,r2)
end

function benchmark(n::Int64,p::Float64,k::Int64)
    A = sprand(n,n,p)
    X = randn(n,k)
    Xt = randn(k,n)'
    At = A'
    benchmark(A,X)
    benchmark(A,Xt)
    benchmark(At,X)
    benchmark(At,Xt)
end

function mybenchmark(n::Int64)
    kvalues = [2,4,8,16]
    @assert n>=100 #just to get a reasonable size network
    p = 10/n
    A = sprand(n,n,p)
    At = A'
    
    @printf("size(A)\t\tsize(x)\t\tmul!_time\tMV_time\t\tPMV_time\tMV_speedup\tPMV_speedup\n")   
    
    for k in kvalues
        X = randn(n,k)
        benchmark(A,X)
    end
    
    for k in kvalues
        Xt = randn(k,n)'
        benchmark(A,Xt)
    end
    
    for k in kvalues
        X = randn(n,k)
        benchmark(At,X)
    end
    
    for k in kvalues
        Xt = randn(k,n)'
        benchmark(At,Xt)
    end
end