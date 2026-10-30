class Navicatmonitor3 < Formula
  desc "Navicat Monitor is a safe, simple and agentless remote server monitoring tool that is packed with powerful features to make your monitoring effective as possible."
  homepage "https://www.navicat.com/en/products#navicat-monitor"
  url "https://navicat-download.oss-us-east-1.aliyuncs.com/monitor3-download/homebrew/navicat-monitor_3.2.2.3.tar.gz"
  sha256 "7c5f1b8a4bc90d2880109562f0681c35b1d1cca648dbd37a78a116b0313ef16e"

  def install
    # Preload
    system "./install.sh"
    libexec.install Dir["*"]

    # Symlink var and tmp to persist across version update
    rm_rf "#{libexec}/var"
    mkdir_p "#{var}/navicatmonitor/var"
    ln_s "#{var}/navicatmonitor/var", "#{libexec}/var"

    rm_rf "#{libexec}/tmp"
    mkdir_p "#{var}/navicatmonitor/tmp"
    ln_s "#{var}/navicatmonitor/tmp", "#{libexec}/tmp"

    # Create wrapper binary
    bin.write_exec_script "#{libexec}/wrapper"
    mv "#{bin}/wrapper", "#{bin}/navicatmonitor"
  end

  service do
    run [libexec/"wrapper start"]
    working_dir libexec
  end

  test do
    system "#{bin}/navicatmonitor version"
  end
end
