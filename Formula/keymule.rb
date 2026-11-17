class Keymule < Formula
  desc "Let AI coding agents use your API tokens and passwords without ever seeing them"
  homepage "https://github.com/Rorogogogo/keymule"
  version "0.18.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.18.0/keymule-aarch64-apple-darwin.tar.xz"
      sha256 "8135f78459a263df819bfc85ec220bbdfdbbe8f0fb95f6f95e2f6de848e3f5a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.18.0/keymule-x86_64-apple-darwin.tar.xz"
      sha256 "9de2b7980f67e7cde7c7f8316da4863e75bb87bd013dc971c88406a071932c46"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.18.0/keymule-aarch64-unknown-linux-musl.tar.xz"
      sha256 "7eeead5b0d7460239007b0590b46d4e265cb4f64a05e10c21c479256a1f47100"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.18.0/keymule-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5920c0445eb88055fe993a2e885286953ce8a1b002b8b9ae07551fac80224bd9"
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
