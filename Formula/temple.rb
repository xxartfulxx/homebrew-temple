class Temple < Formula
  desc "C-backed runtime boundary and proof harness for Temple"
  homepage "https://github.com/xxartfulxx/Temple"
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

      This tap currently installs the latest Temple `main` branch via `--HEAD`.
      When Temple has a tagged release, switch this formula to a stable `url` and `sha256`.
    EOS
  end

  test do
    assert_match "Install and configure the Temple runtime", shell_output("#{bin}/temple --help")
  end
end
