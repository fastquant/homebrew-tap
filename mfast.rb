require "formula"

class Mfast < Formula
  homepage "http://objectcomputing.github.io/mFAST/"
  head "https://github.com/objectcomputing/mFAST.git"

  option :universal
  
  depends_on "cmake" => :build
  depends_on "poco"

  def install
    ENV.universal_binary if build.universal?

    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
