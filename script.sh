#!/bin/bash

read -p "Enter the directory path (For example Desktop/Personal or press Enter to use default, Downloads folder): " user_input

if [ -n "$user_input" ]; then
    downloads_folder="$HOME/$user_input"
else
    downloads_folder="$HOME/Downloads"
fi

# Create Cleanup folder and its subfolders if they don't exist
cleanup_folder="$downloads_folder/Cleanup"
images_folder="$cleanup_folder/Images"
documents_folder="$cleanup_folder/Documents"
videos_folder="$cleanup_folder/Videos"

mkdir -p "$cleanup_folder"
mkdir -p "$images_folder"
mkdir -p "$documents_folder"
mkdir -p "$videos_folder"

# Move files to appropriate folders based on file type
for file in "$downloads_folder"/*; do
    if [ -f "$file" ]; then
        file_extension="${file##*.}"
        case "$file_extension" in
            jpg|jpeg|png|svg|webp|gif|HEIC)
                mv "$file" "$images_folder/"
                echo "Moved $file to Images folder."
                ;;
            txt|pdf|docx)
                mv "$file" "$documents_folder/"
                echo "Moved $file to Documents folder."
                ;;
            mp4|mov|avi|mkv)
                mv "$file" "$videos_folder/"
                echo "Moved $file to Videos folder."
                ;;
        esac
    fi
done

images_size=$(du -sh "$images_folder" | cut -f 1)
documents_size=$(du -sh "$documents_folder" | cut -f 1)
videos_size=$(du -sh "$videos_folder" | cut -f 1)

echo "Images folder size: $images_size"
echo "Documents folder size: $documents_size"
echo "Videos folder size: $videos_size"

echo -e "\nCleanup completed. :)"
