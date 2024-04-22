#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

copy_files() {
    local source=$1
    local dest=$2
    local filename
    local filedest
    local counter

    while IFS= read -r -d $'0' file; do
        filename=$(basename "$file")
        filedest="$dest/$filename"
        counter=1

        while [ -e "$filedest" ]; do
            filedest="${dest}/${filename%.*}_$counter.${filename##*.}"
            ((counter++))
        done

        cp "$file" "$filedest"
    done < <(find "$source" -type f -print0)
}

copy_files "$input_dir" "$output_dir"