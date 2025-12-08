use rayon::prelude::*;
use std::path::Path;
use std::process::{Command, Output};

fn main() {
    // 1. Define your repositories
    let repos = vec!["books", "misc/dotfiles", "comp-prog", "obsidian", "papers"];

    // Get home directory safely
    let home = std::env::var("HOME").expect("Could not find HOME directory");

    // 2. Process in parallel using Rayon (par_iter)
    repos.par_iter().for_each(|repo_subpath| {
        let path = Path::new(&home).join(repo_subpath);

        // Construct the atomic log message to print at the end
        let mut log = String::new();
        log.push_str(&format!("\n--- Processing: {:?} ---\n", path));

        if !path.exists() {
            log.push_str("Directory does not exist. Skipping.\n");
            println!("{}", log);
            return;
        }

        // Helper closure to run commands inside the directory
        let run_git = |args: &[&str]| -> Result<Output, std::io::Error> {
            Command::new("git").current_dir(&path).args(args).output() // Captures stdout/stderr instead of piping to console immediately
        };

        // 3. Execute Git Chain
        // git add .
        if let Ok(_) = run_git(&["add", "."]) {
            let date = chrono::Local::now().format("%Y-%m-%d").to_string();
            let commit_msg = format!("backup for {}", date);

            // git commit
            match run_git(&["commit", "-m", &commit_msg]) {
                Ok(out) => {
                    // Only log if something actually happened or failed
                    if !out.status.success() {
                        log.push_str(&String::from_utf8_lossy(&out.stdout));
                        log.push_str(&String::from_utf8_lossy(&out.stderr));
                    } else {
                        log.push_str("Committed changes.\n");
                    }
                }
                Err(e) => log.push_str(&format!("Commit failed: {}\n", e)),
            }

            // git push
            match run_git(&["push"]) {
                Ok(out) => {
                    if out.status.success() {
                        log.push_str("Push successful.\n");
                    } else {
                        log.push_str(&format!(
                            "Push failed:\n{}",
                            String::from_utf8_lossy(&out.stderr)
                        ));
                    }
                }
                Err(e) => log.push_str(&format!("Push execution error: {}\n", e)),
            }
        }

        // 4. Print the collected log atomically
        println!("{}", log);
    });
}
