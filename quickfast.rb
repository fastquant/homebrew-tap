require "formula"

class Quickfast < Formula
  homepage "https://code.google.com/p/quickfast/"
  url "https://quickfast.googlecode.com/files/QuickFAST_lnx_src_1_5_0.tar"
  sha1 "3dd779060b4da3378f6f3dffda3a69443d56ce75"
    
  resource "mpc" do
    url "http://downloads.ociweb.com/MPC/MPC_4_0_0.tar.gz"
    sha1 "aace8545cde71c58756ebe48ae293b5f2f259409"
  end

  depends_on "boost"
  depends_on "xerces-c"

  def install
    boost = Formula["boost"]
    xerces_c = Formula["xerces-c"]
    
    resource("mpc").stage do
      cp_r(pwd, buildpath/'MPC')
    end

    ENV['QUICKFAST_ROOT'] = pwd
    ENV['BOOST_ROOT'] = boost.prefix
    ENV['BOOST_ROOT_LIB'] = boost.lib
    ENV['XERCESCROOT'] = xerces_c.prefix
    ENV['XERCES_INCLUDE'] = xerces_c.include
    ENV['XERCES_LIBPATH'] = xerces_c.lib
    ENV['BOOST_CFG'] = "-mt"

    #system "./m.sh"
    system "MPC/mwc.pl -type make -value_template platforms=macosx QuickFAST.mwc"
    system "make"

    (include/"QuickFAST/Common").install Dir['src/Common/*.h']
    (include/"QuickFAST/Application").install Dir['src/Application/*.h']
    (include/"QuickFAST/Codecs").install Dir['src/Codecs/*.h']
    (include/"QuickFAST/Communication").install Dir['src/Communication/*.h']
    (include/"QuickFAST/Messages").install Dir['src/Messages/*.h']
    (include/"QuickFAST/DotNet").install Dir['src/DotNet/*.h']
    lib.install 'lib/libQuickFAST.dylib'
    
    bin.install 'bin/FileToMulticast'
    bin.install 'bin/FileToTCP'
    bin.install 'bin/InterpretApplication'
    bin.install 'bin/PCapToMulticast'
    bin.install 'bin/PerformanceTest'
    bin.install 'bin/QuickFASTTest'
    bin.install 'bin/TutorialApplication'
  end
end
