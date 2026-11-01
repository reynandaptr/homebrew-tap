class Wtkill < Formula
  desc "Find git worktrees under .worktree/ folders and delete finished ones safely"
  homepage "https://github.com/reynandaptr/wtkill"
  url "https://github.com/reynandaptr/wtkill/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d96b16446d8466be86215a164967733e3d1d75ca4d4909e68f26d4c50a80e73a"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/reynandaptr/wtkill.git", branch: "main"

  depends_on "rust" => :build
  # wtkill needs git 2.38+ (merge-tree --write-tree); macOS's git can be older.
  depends_on "git"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wtkill --version")
    system "git", "init", "-q", testpath/"repo"
    assert_match "SIZE", shell_output("#{bin}/wtkill --list #{testpath}")
  end
end
