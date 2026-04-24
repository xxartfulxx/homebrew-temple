class Temple < Formula
  desc "C-backed runtime boundary and proof harness for Temple"
  homepage "https://github.com/xxartfulxx/Temple"
  url "https://github.com/xxartfulxx/Temple/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ab3f31d88c942142548fc0face245129671450195ac2fa901d8a1f6823f55c1c"
  license "MIT"

  head "https://github.com/xxartfulxx/Temple.git", branch: "main"

  def install
    libexec.install "cli.py", "provider_runtime.py", "temple", "temple_model_select.py", "temple_upstream.py"
    libexec.install "src"

    mkdir_p libexec/".temple/bin"
    system ENV.cc, "-O2", "-std=c99", "-Wall", "-Wextra", "-pedantic",
      libexec/"src/temple.c", "-o", libexec/".temple/bin/temple_engine"

    chmod 0755, libexec/"temple"
    chmod 0755, libexec/".temple/bin/temple_engine"
    bin.install_symlink libexec/"temple" => "temple"

    doc.install "README.md", "ARCHITECTURE.md", "DEBUGGING.md", "FRESH_INSTALL.md",
      "PRODUCTION.md", "REPO_MAP.md", "TROUBLESHOOTING.md"
  end

  def caveats
    <<~EOS
      Temple expects `python3` to be available on PATH for install and management commands.

      After install, run `temple` once to set up your user-space runtime state and optional
      provider launchers.

      Use `brew install --HEAD temple` only if you want the latest unreleased Temple code.
    EOS
  end

  test do
    assert_match "Install and configure the Temple runtime", shell_output("#{bin}/temple --help")
  end
end
