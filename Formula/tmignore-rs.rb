class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  version "0.3.11"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.11/tmignore-rs_0.3.11_aarch64.zip"
    sha256 "7594eda8e2ec5d51afef4494f97f0aefa6cd5ed1398a9d512c1c465ba0123bd9"
  end

  on_intel do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.11/tmignore-rs_0.3.11_x86-64.zip"
    sha256 "5cfdfd6af3523d4ca27ac3af9098843fa05fd759550b13cd8ed33429a81fc865"
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