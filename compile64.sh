SOURCE_DIR="figma"           
OUTPUT_DIR="figma/obj"      
GAS_FILES=$(find "$SOURCE_DIR" -type f -name "*.S")   
NAAS_FILES=$(find "$SOURCE_DIR" -type f -name "*.asm")   
C_FILES=$(find "$SOURCE_DIR" -type f -name "*.c")         
mkdir -p "$OUTPUT_DIR"

for file in $GAS_FILES; do
    output="$OUTPUT_DIR/$(basename "${file%.S}.o")"
    echo "Assembling $file -> $output"
    x86_64-elf-as "$file" -o "$output"
done

for file in $NASM_FILES; do
    output="$OUTPUT_DIR/$(basename "${file%.asm}.o")"
    echo "Assembling $file -> $output"
    nasm -f elf64 "$file" -o "$output"
    #x86_64-elf-as "$file" -o "$output"
done

for file in $C_FILES; do
    output="$OUTPUT_DIR/$(basename "${file%.c}.o")"
    echo "Compiling $file -> $output"
    x86_64-elf-gcc -c "$file" -o "$output" -std=gnu99 -ffreestanding -O2 -Wall -Wextra
done
echo "Build complete!"
