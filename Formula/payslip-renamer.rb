class PayslipRenamer < Formula
  desc "A tool to rename payslip"
  homepage "https://github.com/IohannRabeson/payslip-renamer"
  url "https://github.com/IohannRabeson/payslip-renamer/releases/download/0.1.3/payslip-renamer_0.1.3_aarch64.zip"
  sha256 "1d282cf6141c0e26350c5bcf43e598a7206e231f4cdf5cabbc1753f366ff0c5b"
  version "0.1.3"
  license "MIT"
  depends_on :macos

  def install
    bin.install "payslip-renamer"
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
        - `PAYSLIP_RENAMER_DATE_PATTERN`: optional, the pattern to extract the date, it expects three captures, example: `DATE PAYABLE: (\\d{4})/(\\d{2})/(\\d{2})`
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
