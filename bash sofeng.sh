#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

copy_files() {
    local from=$1
    local to=$2
    local filename
    local filedest
    local i

    while IFS= read -r -d $'0' file; do
        filename=$(basename "$file")
        filedest="$dest/$filename"
        i=1

        while [ -e "$filedest" ]; do
            filedest="${to}/${filename%.*}_$i.${filename##*.}"
            (( i++))
        done

        cp "$file" "$filedest"
    done < <(find "$from" -type f -print0)
}

copy_files "$input_dir" "$output_dir" 
find "$input_dir" -type f -exec cp {} "$output_dir"