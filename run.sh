#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path="$1"
file_name=$(basename -- "$file_path")
file_name_no_ext="${file_name%.*}"

echo "Compiling..."
as -gstabs -o "$file_name_no_ext.o" "$file_path"

if [ $? -eq 0 ]; then
    echo "Compilation successful!"
else
    echo "Compilation failed!"
fi

echo "Linking..."
ld -o "$file_name_no_ext" "$file_name_no_ext.o"

if [ $? -eq 0 ]; then
    echo "Linking successful!"
else
    echo "Linking failed."
fi

echo "Running..."

echo -e "-------------------------------------------------"
./"$file_name_no_ext" # run the program
echo -e "-------------------------------------------------"

if [ $? -eq 0 ]; then
    echo "Running successful!"
else
    echo "Running failed."
fi

echo "Cleaning up..."
rm "$file_name_no_ext.o"
rm "$file_name_no_ext"
echo "DONE!"