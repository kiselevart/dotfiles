#!/usr/bin/env python3
import os
import subprocess
import datetime
from concurrent.futures import ThreadPoolExecutor

# Configuration
HOME = os.path.expanduser("~")
REPOS = [
    "books",
    "misc/dotfiles",
    "comp-prog",
    "obsidian",
    "papers",
]

def sync_repo(repo_subpath):
    full_path = os.path.join(HOME, repo_subpath)
    log = [] # Collect output to print atomically

    log.append(f"--- Processing: {full_path} ---")

    if not os.path.isdir(full_path):
        log.append(f"Directory {full_path} not found.")
        return "\n".join(log)

    try:
        # Helper to run commands
        def run_git(args):
            result = subprocess.run(
                ["git"] + args,
                cwd=full_path,
                capture_output=True,
                text=True
            )
            return result

        # 1. Add
        run_git(["add", "."])

        # 2. Commit
        date_str = datetime.date.today().strftime("%Y-%m-%d")
        commit_msg = f"backup for {date_str}"
        c_res = run_git(["commit", "-m", commit_msg])

        # Git commit returns exit code 1 if there is nothing to commit,
        # so we check stdout for "nothing to commit" or similar if we want to be strict.
        if c_res.returncode == 0:
            log.append("Changes committed.")
        elif "nothing to commit" in c_res.stdout:
            log.append("Nothing to commit.")
        else:
            log.append(f"Commit output: {c_res.stdout} {c_res.stderr}")

        # 3. Push
        p_res = run_git(["push"])
        if p_res.returncode == 0:
            log.append("Push successful.")
        else:
            log.append(f"Push failed: {p_res.stderr}")

    except Exception as e:
        log.append(f"Error: {str(e)}")

    return "\n".join(log)

def main():
    # Run in parallel using 5 worker threads
    with ThreadPoolExecutor(max_workers=5) as executor:
        results = executor.map(sync_repo, REPOS)

    # Print results as they complete (or after all are done)
    for result in results:
        print(result)

if __name__ == "__main__":
    main()
