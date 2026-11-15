class Keymule < Formula
  desc "Let AI coding agents use your API tokens and passwords without ever seeing them"
  homepage "https://github.com/Rorogogogo/keymule"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.15.0/keymule-aarch64-apple-darwin.tar.xz"
      sha256 "2db23ffe6cf507c1b8047102ab1977ee4639b9adee973cc65aec65a80872a707"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.15.0/keymule-x86_64-apple-darwin.tar.xz"
      sha256 "76c890574d4dafdccc46e9bacc9a2a3c252a6c7a1ac5bc2c17cfffe9a18bc92d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.15.0/keymule-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a89d539644bae65a3508db3fa235cb64f4649d599c90fb562522f4241e61e87f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rorogogogo/keymule/releases/download/v0.15.0/keymule-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f47e1d84d8b7ee74f20fbcde8975d829f48848cbacb4286e61d47a9d4814ee13"
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
