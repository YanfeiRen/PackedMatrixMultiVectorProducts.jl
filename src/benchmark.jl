using Printf
using Statistics
using Markdown
function benchmark(A,X)
    @assert A*X ≈ unpack(A*pack(X))
    
    # benchmark mul!(Y,A,X)
    Y = zeros(size(A,1),size(X,2))
    b1 = @benchmark mul!($Y,$A,$X)
    
    # benchmark mul!(y,A,x)
    pX = pack(X)
    y = zeros(SVector{size(X,2),Float64},size(A,1))
    b2 = @benchmark mul!($y,$A,$pX) 
    
    # benchmark A*X
    b3 = @benchmark $A*$X
    
    # benchmark unpack(A*pack(X))
    b4 = @benchmark unpack($A*pack($X))
    
    # numeric times
    m1 = median(b1.times)
    m2 = median(b2.times)
    m3 = median(b3.times)
    m4 = median(b4.times)
    
    # nice looking times (in strings)
    s1 = BenchmarkTools.prettytime(m1)
    s2 = BenchmarkTools.prettytime(m2)
    s3 = BenchmarkTools.prettytime(m3)
    s4 = BenchmarkTools.prettytime(m4)
    
    # speedups:
    # mul!(Y,A,X) vs mul!(y,A,x)
    r1 = m1/m2
    
    # A*X vs unpack(A*pack(X))
    r2 = m3/m4

    # return array of all info needed
    typeof(X) <: Adjoint ? sizex = size(X.parent) : sizex = size(X)    
    return Any[size(A),sizex, s1,s2,round(r1,digits=2),
                              s3,s4,round(r2,digits=2)]
end

function benchmark(n::Int64)
    kvalues = [2,4,8,16]
    @assert n>=100 #just to get a reasonable size network
    p = 10/n
    A = sprand(n,n,p)
    At = A'
    rows = []
    push!(rows,Any["size(A)","size(x)","mul!(Y,A,X)","mul!(y,A,x)","Ratio",
                                        "Julia's A*X","unpack(A*pack(X))","Ratio"])

    for k in kvalues
        X = randn(n,k)
        b = benchmark(A,X)
        push!(rows,b)
    end
    for k in kvalues
        Xt = randn(k,n)'
        b = benchmark(A,Xt)
        push!(rows,b)
    end
    
    for k in kvalues
        X = randn(n,k)
        b = benchmark(At,X)
        push!(rows,b)
    end
    
    for k in kvalues
        Xt = randn(k,n)'
        b = benchmark(At,Xt)
        push!(rows,b)
    end
    table = Markdown.MD(Any[Markdown.Table(rows, Symbol[:l, :r, :l, :r,:r,:r,:r,:r])])
    println(table)
end