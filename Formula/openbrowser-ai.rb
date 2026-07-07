class OpenbrowserAi < Formula
  desc "AI-powered browser automation using CodeAgent and CDP"
  homepage "https://docs.openbrowser.me"
  url "https://files.pythonhosted.org/packages/f6/55/b3e714fe963810877d5ae79c27178bddb4bb11fa9e2d5ff323053795fd6d/openbrowser_ai-0.1.50.tar.gz"
  sha256 "456550dce5fe3194c681ac5ec996cbe2630a8481e151d120cdc0a8986328ce7f"
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
