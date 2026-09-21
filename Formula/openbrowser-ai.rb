class OpenbrowserAi < Formula
  desc "AI-powered browser automation using CodeAgent and CDP"
  homepage "https://docs.openbrowser.me"
  url "https://files.pythonhosted.org/packages/f2/8e/0888a4f38c73ebffe46dce91c5575e30302ba77a4269b40a4ee2b5873f9b/openbrowser_ai-0.1.54.tar.gz"
  sha256 "a1992adec83dbcbce516cc21a849364af115f76ddc85108c6f1b5a9804742707"
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
