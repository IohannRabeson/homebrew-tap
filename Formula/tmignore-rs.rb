class TmignoreRs < Formula
  desc "Makes Time Machine respect .gitignore files"
  homepage "https://github.com/IohannRabeson/tmignore-rs"
  url "https://github.com/IohannRabeson/tmignore-rs.git",
      using:    :git,
      revision: "20ae4e33ee963b969368f56fa45a737ddaced6c6"
  version "0.2.0"
  license "MIT"
  depends_on "rust" => :build
  depends_on :macos

  def install
    ENV["TMIGNORE_RS_VERSION"] = version
    system "cargo", "install", *std_cargo_args
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
        ~/.config/tmignore/config.json

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
