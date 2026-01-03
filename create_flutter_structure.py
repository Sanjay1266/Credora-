import os

# Base directory
base_dir = "lib"

# Folder & file structure
structure = {
    "core/theme": ["app_theme.dart"],
    "features/auth": ["login_screen.dart"],
    "features/dashboard": ["dashboard_screen.dart"],
    "features/project": ["create_project_screen.dart"],
    "router": ["app_router.dart"],
    "": ["main.dart"]
}

# Create directories and files
for folder, files in structure.items():
    folder_path = os.path.join(base_dir, folder)
    os.makedirs(folder_path, exist_ok=True)

    for file in files:
        file_path = os.path.join(folder_path, file)
        if not os.path.exists(file_path):
            with open(file_path, "w") as f:
                f.write("// Auto-generated file\n")

print("✅ Flutter lib folder structure created successfully!")
