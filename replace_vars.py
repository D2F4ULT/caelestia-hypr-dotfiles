import os
import re
import shutil

# --- CONFIGURATION ---
VARIABLES_FILE = "variables.conf"
TARGET_FILE = "hyprland/keybinds.conf"  # Change this to the exact file you want to edit
BACKUP_FILE = TARGET_FILE + ".bak"
# ---------------------


def load_variables(filepath):
    variables = {}
    # Matches lines like: $variable = value # optional comment
    var_pattern = re.compile(r"^\s*(\$[a-zA-Z0-9_]+)\s*=\s*([^#\n]+)")

    if not os.path.exists(filepath):
        print(f"Error: {filepath} not found!")
        return None

    with open(filepath, "r") as f:
        for line in f:
            match = var_pattern.match(line)
            if match:
                var_name = match.group(1).strip()
                var_value = match.group(2).strip()
                variables[var_name] = var_value
    return variables


def replace_in_file():
    vars_dict = load_variables(VARIABLES_FILE)
    if not vars_dict:
        return

    if not os.path.exists(TARGET_FILE):
        print(f"Error: Target file '{TARGET_FILE}' does not exist.")
        return

    # 1. Safely make a backup first
    print(f"Backing up {TARGET_FILE} to {BACKUP_FILE}...")
    shutil.copy2(TARGET_FILE, BACKUP_FILE)

    # 2. Read the target content
    with open(TARGET_FILE, "r") as f:
        content = f.read()

    # 3. Replace variables (sorting by length longest-first prevents partial matching bugs)
    replacements_count = 0
    for var_name in sorted(vars_dict.keys(), key=len, reverse=True):
        if var_name in content:
            # Simple exact string replacement to keep it safe
            count = content.count(var_name)
            content = content.replace(var_name, vars_dict[var_name])
            print(f"Replaced {var_name} -> '{vars_dict[var_name]}' ({count} times)")
            replacements_count += count

    # 4. Write back to the target file
    with open(TARGET_FILE, "w") as f:
        f.write(content)

    print(
        f"\nDone! Successfully processed file and performed {replacements_count} replacements."
    )


if __name__ == "__main__":
    replace_in_file()
