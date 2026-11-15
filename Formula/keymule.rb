class Keymule < Formula
  desc "Let AI coding agents use your API tokens and passwords without ever seeing them"
  homepage "https://github.com/Rorogogogo/keymule"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.16.0/keymule-aarch64-apple-darwin.tar.xz"
      sha256 "5796c0cbdf07d18b41f71bfffb2d1d1259cf489668bf394806a9464124c98b4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.16.0/keymule-x86_64-apple-darwin.tar.xz"
      sha256 "56b6f39c88405bb0e88829999234cd4b519a436cb56f8141d04825756eea6f28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.16.0/keymule-aarch64-unknown-linux-musl.tar.xz"
      sha256 "367d09c9c1563fc4ddd36dcc8d70143b100d9921efaefdd47d73d3f9a7862e0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.16.0/keymule-x86_64-unknown-linux-musl.tar.xz"
      sha256 "598e77acbfc85315915a5dea8c21ac97ea6d758a0626d127243ffc91e0874fc8"
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
