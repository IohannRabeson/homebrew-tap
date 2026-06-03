class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  version "0.3.8"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.8/tmignore-rs_0.3.8_aarch64.zip"
    sha256 "8429404b94eb026a8b7e3ba4a2dd467f35752962c1b0071d86bb1d6aaaa2fc22"
  end

  on_intel do
    url "https://github.com/IohannRabeson/tmignore-rs/releases/download/0.3.8/tmignore-rs_0.3.8_x86-64.zip"
    sha256 "720a40bb9b829c5e3a55af40320a4f47e3f4768cd22d87aa64068b40c39a55e8"
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