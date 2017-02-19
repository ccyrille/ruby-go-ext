require "ffi"
require "oj"

module Poly
  extend FFI::Library
  ffi_lib File.expand_path("../ext/poly/poly.so", File.dirname(__FILE__))
  attach_function :decode_polyline_str, :DecodePolyline, [:string, :int], :string

  def self.decode(polyline)
    Oj.strict_load(decode_polyline_str(polyline, 1e5))
  end
end
