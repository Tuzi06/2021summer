using Base: Float64
using LinearAlgebra
using Statistics
using Printf
using Random
using Test
# array of function
function print1(n)
    println("asd sda ", n)
    return 1
end
function print2(n)
    println("sadfasd", n)
    return 2
end
function print3(n)
    println("asd sda ", n)
    return 3
end

a2= [print1,print2,print3]

println(map(x->x(10) ,a2))
println(print1(10))
println(print2(10))
println(print3(10))

# linear Algebra

martix = [1 2 4;6 5 9;2 4 4]
println("det =", det(martix))

a1=sin(20*π)
@printf "sin is %f\n" a1

println(map(x->cos(x*π), martix))

#Random 
r1 = rand(Float64, (1,100))
println("r1 ",r1)

n1 = mean(r1)
n2 = median(r1)
n3 = middle(r1)
println("mean of r1 ",n1)
println("median of r1 ", n2)
println("middle of r1 ", n3)


macro add(a,b)
    return a+b
end
println("10+20 =", @add 10 20)

@test typeof("cmpt383") == String
println("test above is sucuess")
@test typeof("cmpt383") == Float64