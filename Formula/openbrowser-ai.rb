class OpenbrowserAi < Formula
  desc "AI-powered browser automation using CodeAgent and CDP"
  homepage "https://docs.openbrowser.me"
  url "https://files.pythonhosted.org/packages/1a/70/a29f6baffad8611645c5f86e0fec1e86900e6dba898f11009d81ea2b139e/openbrowser_ai-0.1.46.tar.gz"
  sha256 "3b25aa61808fe8d7d66a3a4b0627693eb31c2ea3c0aa4a64a225815279620676"
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
    system bin/"openbrowser-ai", "install"
  rescue StandardError
    opoo "Chromium install skipped. Run 'openbrowser-ai install' manually."
  end

  test do
    assert_match "usage", shell_output("#{bin}/openbrowser-ai --help 2>&1", 0).downcase
  end
end
