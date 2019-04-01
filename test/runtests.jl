#PackedMatrixMultiVectorProducts tests
using PackedMatrixMultiVectorProducts
using Test

all_tests = [
             "pack"
             "mat_multi_vec"]

for ti = 1:length(all_tests)
    t = all_tests[ti]
    test_name = join(["$(t)", "_test",".jl"])
    @show test_name
    test_path = joinpath(dirname(@__FILE__), test_name)
    include(test_path)
end
