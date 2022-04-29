class Purescript < Formula
  desc "Strongly typed programming language that compiles to JavaScript"
  homepage "https://www.purescript.org/"
  url "https://hackage.haskell.org/package/purescript-0.15.0/purescript-0.15.0.tar.gz"
  sha256 "0fa583c045d1e3507df4e2071ea20a895c81d6be98bf486221d61b7eeacca155"
  license "BSD-3-Clause"
  head "https://github.com/purescript/purescript.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3f395ea2cb830ef9c17f4a8d05c8facd6ce4484c105b6093f90935091f80ea04"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7d7caf6afbc1cf35d381c68754226ae9f115ad2bb321c2a207d6665423376ad5"
    sha256 cellar: :any_skip_relocation, monterey:       "b8fc40aa41afce138ead62d9ecb778c7f19da5a4d0a8c34325875ed49776f7a1"
    sha256 cellar: :any_skip_relocation, big_sur:        "640f904f6597bed9716225de0b79d623ac8cd84c4a0f5a5229429b5dc6ca56df"
    sha256 cellar: :any_skip_relocation, catalina:       "f3b1152ab3e9de832db4fe099593750a2180cfe3c46d204e271c0808f719084e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53408a9bc19055190f0c92baca868f356adb2ac8a0703a40ff2efca8aab9d7f6"
  end

  depends_on "ghc" => :build
  depends_on "haskell-stack" => :build

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "stack", "install", "--system-ghc", "--no-install-ghc", "--skip-ghc-check", "--local-bin-path=#{bin}"
  end

  test do
    test_module_path = testpath/"Test.purs"
    test_target_path = testpath/"test-module.js"
    test_module_path.write <<~EOS
      module Test where

      main :: Int
      main = 1
    EOS
    system bin/"purs", "compile", test_module_path, "-o", test_target_path
    assert_predicate test_target_path, :exist?
  end
end
