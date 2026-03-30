class PayslipRenamer < Formula
  desc "A tool to rename payslip"
  homepage "https://github.com/IohannRabeson/payslip-renamer"
  url "https://github.com/IohannRabeson/payslip-renamer.git",
      using:    :git,
      revision: "e7ca4e3be0fc8345847e7958367cfd725eaa8eb8"
  version "0.1.1"
  license "MIT"
  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"payslip-renamer", "--verbose", "monitor"]
    keep_alive true
    log_path "/dev/null"
    error_log_path "/dev/null"
  end

  def caveats
    <<~EOS
      The `monitor` command expects two environment variables:
        - `PAYSLIP_RENAMER_DIRECTORY`: the directory to watch for new payslip
        - `PAYSLIP_RENAMER_DATE_PATTERN`: optional, the pattern to extract the date, it expects three captures, example: `DATE PAYABLE: (\d{4})/(\d{2})/(\d{2})`
      You must use `launchctl` to set the environment variables:
        `launchctl setenv PAYSLIP_RENAMER_DIRECTORY "/Users/You/your_folder/payslips"`

      To start the monitor service:
        brew services start payslip-renamer

      To stop it:
        brew services stop payslip-renamer
    EOS
  end

  test do
    assert_match "payslip-renamer", shell_output("#{bin}/payslip-renamer --version")
  end
end
