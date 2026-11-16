class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  version "0.4.2"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.4.2/tmignore-rs_0.4.2_aarch64.zip"
    sha256 "864ee567d9ce3a2e3c66ff62917c56f2d39551a392b9b227e35b605c5d21d4fa"
  end

  on_intel do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.4.2/tmignore-rs_0.4.2_x86-64.zip"
    sha256 "cda4e0b19204f7d3c6efb7e20b96dd7840154851fb2fd4bf9abae7ecaf977535"
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