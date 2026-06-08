class Astrodb < Formula
  desc "TUI for querying, cleaning, and persisting astronomical database records"
  homepage "https://github.com/lldddv2/astrodb"
  url "https://github.com/lldddv2/astrodb/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b2175b57822a0998343a2332c0c1f28e4099d3538e0105f8ac56f64afbbd780b"
  license "MIT"

  depends_on "python@3.13"

  def install
    venv = libexec
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", venv
    system venv/"bin/pip", "install", "--upgrade", "pip"
    system venv/"bin/pip", "install", "--prefer-binary", buildpath
    (bin/"astrodb").write <<~SH
      #!/bin/bash
      exec "#{venv}/bin/astrodb" "$@"
    SH
    chmod 0755, bin/"astrodb"
  end

  test do
    assert_match "astrodb", shell_output("#{bin}/astrodb --version")
  end
end
