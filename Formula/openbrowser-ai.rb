class OpenbrowserAi < Formula
  desc "AI-powered browser automation using CodeAgent and CDP"
  homepage "https://docs.openbrowser.me"
  url "https://files.pythonhosted.org/packages/07/dd/02e7b52ac4f0a1418d3d6a8c4e83bf3b5031c1509adee968e0c4e6f06ebe/openbrowser_ai-0.1.34.tar.gz"
  sha256 "81c5a0807b721878f3035d43956e35622dabac3afc9e8e2d1219e40e637125ba"
  license "MIT"

  depends_on "python@3.12"

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    venv = Utils.safe_popen_read(python3, "-c", "import venv; print('ok')").strip
    if venv != "ok"
      odie "Python venv module not available"
    end

    # Create virtualenv
    system python3, "-m", "venv", libexec
    # Install from PyPI (includes all dependencies)
    system libexec/"bin/pip", "install", "--no-cache-dir", "openbrowser-ai==#{version}"
    # Symlink the CLI entry point
    bin.install_symlink Dir[libexec/"bin/openbrowser*"]
  end

  def post_install
    # Install Chromium for browser automation
    system bin/"openbrowser", "install"
  rescue StandardError
    opoo "Chromium install skipped. Run 'openbrowser install' manually."
  end

  test do
    assert_match "usage", shell_output("#{bin}/openbrowser --help 2>&1", 0).downcase
  end
end
