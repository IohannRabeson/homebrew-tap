class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  version "0.3.9"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.9/tmignore-rs_0.3.9_aarch64.zip"
    sha256 "d640c5f45130882554d3fa8493663c059b43d803b75caaa82e67e6a1993f292b"
  end

  on_intel do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.9/tmignore-rs_0.3.9_x86-64.zip"
    sha256 "9e89053a6b5655c47b0fa3bc9825644d358f39e9fae5faf1e43a84ceb0516733"
  end

  def install
    bin.install "tmignore-rs"
  end

  service do
    run [opt_bin/"tmignore-rs", "monitor"]
    keep_alive true
    log_path "/dev/null"
    error_log_path "/dev/null"
  end

  def caveats
    <<~EOS
      tmignore-rs reads its configuration from:
        ~/.config/tmignore-rs/config.json

      A default configuration will be created automatically on first run.

      To start the monitor service:
        brew services start tmignore-rs

      To stop it:
        brew services stop tmignore-rs

      Note: Homebrew suggests running `tmignore-rs monitor` directly below,
        but for a one-shot scan without monitoring, use `tmignore-rs run` instead.
        See `tmignore-rs --help` for more details.
    EOS
  end

  test do
    assert_match "tmignore-rs", shell_output("#{bin}/tmignore-rs --version")
  end
end