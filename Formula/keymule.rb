class Keymule < Formula
  desc "Let AI coding agents use your API tokens and passwords without ever seeing them"
  homepage "https://github.com/Rorogogogo/keymule"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.17.0/keymule-aarch64-apple-darwin.tar.xz"
      sha256 "fddd4377b6af5ffc2292df28e544a2f2a0535753e3ea6c058e12817b37a85331"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.17.0/keymule-x86_64-apple-darwin.tar.xz"
      sha256 "10272444196ec3238d9a79a63b253b88b77fc6bc2bfa4bc4f43dfffe01b557b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.17.0/keymule-aarch64-unknown-linux-musl.tar.xz"
      sha256 "603514509a04457118c14284851f683dfdd689b3cb554000ac83fda45d674efa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.17.0/keymule-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3bf9a4443fe3ed5aaa43682d2aad566c5cf86eaba00b9e9b382e9491b5de943f"
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
