#!/bin/bash
julia -e '\
using JLD2
abstract type Foo end
struct Baz
    z1::Int
    z2::Int
end
Base.@kwdef mutable struct Bar <: Foo
    r1::Vector{Baz} = Baz[]
end
do_something(f::Foo) = @show f

@show bar = JLD2.load("step1.jld2")["bar"]
do_something(bar)
'
