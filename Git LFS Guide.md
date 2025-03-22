# How to Set Up Git LFS in a GitHub Repository

This guide outlines the steps to configure Git Large File Storage (Git LFS) for managing large files such as `.dta`, `.pdf`, `.psd`, etc., in a GitHub repository.

---

## 1. Initialize or Clone Your Repository

Navigate to your project directory using Git Bash:

```bash
cd "/path/to/your/project"
```

If starting a new repository:

```bash
git init
```

If cloning an existing GitHub repository:

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

---

## 2. Install Git LFS (One-Time Setup per Machine)

Install Git LFS:

```bash
git lfs install
```

---

## 3. Track Large File Types

Tell Git LFS which file types to track. For example, to track `.dta` files:

```bash
git lfs track "*.dta"
```

Optional examples:

```bash
git lfs track "*.pdf"
git lfs track "*.zip"
```

Then stage the `.gitattributes` file created by Git LFS:

```bash
git add .gitattributes
git commit -m "Track large file types with Git LFS"
```

---

## 4. Remove Previously Committed Large Files (If Applicable)

If large files were already committed to Git before configuring Git LFS, remove them from Git tracking (but not from disk):

```bash
git rm --cached path/to/large-file.dta
```

To remove multiple files from a folder:

```bash
git rm --cached "Stata data/"*.dta
```

Then commit the removal:

```bash
git commit -m "Remove large files from Git before adding with LFS"
```

---

## 5. Re-Add Files to Git (Now Tracked with LFS)

Add the files back:

```bash
git add path/to/large-file.dta
```

Or for multiple files:

```bash
git add "Stata data/"*.dta
```

Commit the changes:

```bash
git commit -m "Re-add files tracked with Git LFS"
```

---

## 6. Push Changes to GitHub

If your local history has diverged due to cleanup or rebase, use a force push:

```bash
git push origin main --force
```

Otherwise, use a regular push:

```bash
git push origin main
```

---

## 7. Verify Git LFS is Tracking Files

To confirm which files are currently tracked by Git LFS:

```bash
git lfs ls-files
```

On GitHub, LFS-tracked files will appear as pointer files rather than showing their full content.

---

## Best Practices

- Run `git lfs install` once on each new machine.
- Run `git lfs track` before adding large files.
- Always commit the `.gitattributes` file after tracking new file types.
- Use `git rm --cached` to remove previously committed large files before adding them with LFS.
- Avoid syncing Git repositories directly in OneDrive/Dropbox/Google Drive folders to prevent file locking issues.
