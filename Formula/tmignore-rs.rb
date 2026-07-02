class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  version "0.3.10"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.10/tmignore-rs_0.3.10_aarch64.zip"
    sha256 "24d045b5696aa35578fb655d9944590fd63215902f51fb6730f5b483d0d789b4"
  end

  on_intel do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.10/tmignore-rs_0.3.10_x86-64.zip"
    sha256 "89623fe8f222903ae6eff5a44202885809881c53ea78570049e6babea9756d35"
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