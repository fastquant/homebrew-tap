require "formula"

class Mfast < Formula
  homepage "http://objectcomputing.github.io/mFAST/"
  head "https://github.com/objectcomputing/mFAST.git"
  
  depends_on "cmake" => :build
  depends_on "poco"

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
