#!/usr/bin/env python3
import datetime
import os
import subprocess
from concurrent.futures import ThreadPoolExecutor

# Configuration
HOME: str = os.path.expanduser("~")
REPOS: list[str] = [  # REPOS is a list of strings
    "books",
    "misc/dotfiles",
    "comp-prog",
    "obsidian",
    "papers",
]


def sync_repo(repo_subpath: str) -> str:
    """
    Performs git add, commit, and push on a single repository.
    Returns a string containing the detailed log of the operation.
    """
    full_path: str = os.path.join(HOME, repo_subpath)
    log: list[str] = []

    log.append(f"--- Processing: {full_path} ---")

    if not os.path.isdir(full_path):
        log.append(f"Directory {full_path} not found.")
        return "\n".join(log)

    try:

        def run_git(args: list[str]):
            result = subprocess.run(
                ["git"] + args, cwd=full_path, capture_output=True, text=True
            )
            return result

        _: subprocess.CompletedProcess[str] = run_git(["add", "."])

        # 2. Commit
        date_str: str = datetime.date.today().strftime("%Y-%m-%d")
        commit_msg: str = f"backup for {date_str}"
        c_res = run_git(["commit", "-m", commit_msg])

        if c_res.returncode == 0:
            log.append("Changes committed.")
        # Check against stdout for "nothing to commit"
        elif "nothing to commit" in c_res.stdout:
            log.append("Nothing to commit.")
        else:
            log.append(f"Commit output (stdout): {c_res.stdout.strip()}")
            if c_res.stderr:
                log.append(f"Commit output (stderr): {c_res.stderr.strip()}")

        p_res = run_git(["push"])
        if p_res.returncode == 0:
            log.append("Push successful.")
        else:
            log.append(f"Push failed: {p_res.stderr.strip()}")

    except Exception as e:
        log.append(f"Error during execution: {type(e).__name__}: {str(e)}")

    return "\n".join(log)


def main() -> None:
    """
    Sets up the thread pool and maps the sync_repo function across all REPOS.
    """
    with ThreadPoolExecutor(max_workers=os.cpu_count()) as executor:
        results = executor.map(sync_repo, REPOS)

    for result in results:
        print(result)


if __name__ == "__main__":
    main()
