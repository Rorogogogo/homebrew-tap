class Keymule < Formula
  desc "Let AI coding agents use your API tokens and passwords without ever seeing them"
  homepage "https://github.com/Rorogogogo/keymule"
  version "0.19.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.19.0/keymule-aarch64-apple-darwin.tar.xz"
      sha256 "94c8e9b12697adb7d14dea69b55807b54faf8fce23548f1251291fefc456def4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.19.0/keymule-x86_64-apple-darwin.tar.xz"
      sha256 "dfb697ec8a6e0b082ed5d6129aa0122557126960a3814025700770e868aa344c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.19.0/keymule-aarch64-unknown-linux-musl.tar.xz"
      sha256 "40e7b1cebc9db92d74f4c02349ab747ddc876f149809fdeaea59d0d51a986267"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.19.0/keymule-x86_64-unknown-linux-musl.tar.xz"
      sha256 "efd6dcb643d08c94db2b65c9959e2b445dd1a1ec744b22d23cf8ad51ef7df4aa"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "keymule"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "keymule"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "keymule"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "keymule"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
