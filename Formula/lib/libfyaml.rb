class Libfyaml < Formula
  desc "Fully feature complete YAML parser and emitter"
  homepage "https://github.com/pantoniou/libfyaml"
  url "https://github.com/pantoniou/libfyaml/releases/download/v0.9/libfyaml-0.9.tar.gz"
  sha256 "7731edc5dfcc345d5c5c9f6ce597133991a689dabede393cd77bae89b327cd6d"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "fb88f2b33ea21571db8874dad3dd30b7d0245462361a70888c88e3f2b5c10d13"
    sha256 cellar: :any, arm64_ventura:  "fa7e81a89971ca3a452b831bfa017778b24f734b49b57ea730dda4b6791e2cb2"
    sha256 cellar: :any, arm64_monterey: "40163086b94a5d8e80da16ca8bdafe7d36a751aa5cf29a341b0e48d4dc4ff1ea"
    sha256 cellar: :any, arm64_big_sur:  "dd5c5d612403756d6385e35682010025e859a40cc4ed470589847516de520404"
    sha256 cellar: :any, sonoma:         "962c227be12ffda0b09dd65eb73c13aa7050a7bf9e7e0bc569dafe3d16463a74"
    sha256 cellar: :any, ventura:        "03600f95a70968eb1769442bad770abe8a872c4d0ed0d175cb19cc2f359acbfb"
    sha256 cellar: :any, monterey:       "2abbe7b8e83aa2f820ef0096f8bf2eedccb134f732dd7c819c64406a81a78883"
    sha256 cellar: :any, big_sur:        "e64216b07a8bcc58d1fd8186721901a91feb5b7d67389220f479cb5ea2ae2fab"
  end

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #ifdef HAVE_CONFIG_H
      #include "config.h"
      #endif

      #include <iostream>
      #include <libfyaml.h>

      int main(int argc, char *argv[])
      {
        std::cout << fy_library_version() << std::endl;
        return EXIT_SUCCESS;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lfyaml", "-o", "test"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_equal version.to_s, shell_output("#{testpath}/test").strip
    assert_equal version.to_s, shell_output("#{bin}/fy-tool --version").strip
  end
end
