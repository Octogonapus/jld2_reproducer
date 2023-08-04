#!/bin/bash
julia -e '\
using JLD2
abstract type Foo end
struct Baz
    z1::Int
end
Base.@kwdef mutable struct Bar <: Foo
    r1::Vector{Baz} = Baz[]
end
do_something(f::Foo) = @show f

bar = Bar([Baz(1)])
do_something(bar)

JLD2.save("step1.jld2", Dict("bar" => bar))
'
