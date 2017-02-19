require_relative "../lib/poly"
require "ffi"
require "byebug"
require "polylines"
require "oj"
require "benchmark"

POLY = "ocshHwfuKkC_GTTg@kAYu@Qe@Yq@s@q@KNaFvC_@FDNVCrC`BcApAsAEErB}AxE" \
         "{FbHkEvLc@KIp@wAr@aPvi@CTwJfUO?Gp@gKdWIJwGiAw_@oJgAoAuAdAC~DaG`" \
         "IwChCgKyEEWa@CkEwB{b@vlAmS`X{SaN{GgGgGkGeOoOwvEwzH_j@}nXO}v@t@}" \
         "WF}l@Wa@Q@_IrGgdAcgAkG}EwAeAyG_I{HuFyrBekBmJcUqBwDyKsUqi@utA_Dy" \
         "NK]vK}Vp{@ypAIuGW}E\h@\i@bCkPXc@`DbASdA"
TURNS = 10_000

def benchmark(&_block)
  bench = Benchmark.measure { yield }
  puts "=> Time spent : #{bench.real.round(2)}"
end

puts "GOLANG RESULT"
puts Poly.decode(POLY).inspect
puts "RUBY RESULT"
puts Polylines::Decoder.decode_polyline(POLY).inspect

# Golang
golang_bench = proc do
  puts "GOLANG BENCHMARK"
  TURNS.times do
    Poly.decode(POLY)
  end
end
benchmark { golang_bench.call }

# Ruby
ruby_bench = proc do
  puts "RUBY BENCHMARK"
  TURNS.times do
    Polylines::Decoder.decode_polyline(POLY)
  end
end
benchmark { ruby_bench.call }
