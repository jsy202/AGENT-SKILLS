"""Run with python3 -m unittest discover -s tests (requires POSIX sh)."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


class InstallTest(unittest.TestCase):
    def test_single_parent_and_lowercase_skills(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            fixtures = root / "fixtures"
            for path in ("SKILL.md", "single/SKILL.md", "lowercase/skill.md", "collection/child/SKILL.md"):
                file = fixtures / path
                file.parent.mkdir(parents=True, exist_ok=True)
                file.write_text(path)
            (fixtures / "lowercase/reference.txt").write_text("reference")
            (root / "skills.txt").write_text(
                "# fixtures\ntest/fixtures single\ntest/fixtures lowercase\ntest/fixtures collection\ntest/humanizer .\n"
            )
            source = (Path(__file__).resolve().parents[1] / "install.sh").read_text()
            (root / "install.sh").write_text(source.replace("$HOME/", str(root / "home") + "/"))
            binary = root / "bin"
            binary.mkdir()
            git = binary / "git"
            git.write_text('#!/bin/sh\nfor last; do :; done\ncp -R "$REGISTRY_TEST_FIXTURES/." "$last"\n')
            git.chmod(0o755)
            environment = dict(os.environ, PATH=str(binary) + os.pathsep + os.environ["PATH"],
                               REGISTRY_TEST_FIXTURES=str(fixtures))
            subprocess.run(["sh", str(root / "install.sh"), "codex"], env=environment, check=True)
            destination = root / "home/.codex/skills"
            for skill in ("single", "lowercase", "child", "humanizer"):
                self.assertTrue((destination / skill / "SKILL.md").is_file(), skill)
            self.assertFalse((destination / "SKILL.md").exists())
            self.assertEqual((destination / "lowercase/reference.txt").read_text(), "reference")
