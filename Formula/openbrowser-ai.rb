class OpenbrowserAi < Formula
  desc "AI-powered browser automation using CodeAgent and CDP"
  homepage "https://docs.openbrowser.me"
  url "https://files.pythonhosted.org/packages/49/73/2f797a3ee799c99211063b285095898352e81bc05fd1a36702e5b8ea2817/openbrowser_ai-0.1.49.tar.gz"
  sha256 "e5d157779028aae4e3a1bd5fe9c625b37cfd8c0b30697d283c7152a0f86a49c8"
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
