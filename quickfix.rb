require "formula"

class Quickfix < Formula
  homepage "http://www.quickfixengine.org"
  url "http://prdownloads.sourceforge.net/quickfix/quickfix-1.14.0.tar.gz"
  sha1 "af1a26329bb01639648b924c51a530118c002d80"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"
  depends_on "libxml2"

  def install
    system "./bootstrap"
    system "./configure", "--with-java=no",
                          "--with-ruby=no",
                          "--with-python=no",
                          "--prefix=#{prefix}",
                          "--disable-xmltest"
    system "make"
    system "make install"
  end
end
