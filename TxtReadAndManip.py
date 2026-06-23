import sys
import os

def process_file(input_path):
    # Build output filename: original name + "_out" before the extension
    base, ext = os.path.splitext(input_path)
    output_path = base + "_out" + ext

    with open(input_path, "r") as infile, open(output_path, "w") as outfile:
        for line in infile:
            # Keep the original newline
            newline = "" if not line.endswith("\n") else "\n"
            stripped = line.rstrip("\n")

            # If line doesn't start with '?? ', write as-is
            if not stripped.startswith("C"):
            # if not stripped.startswith("L"):
                outfile.write(stripped + newline)
                continue

            # Split by whitespace
            parts = stripped.split()

            # Only modify if there are at least 4 entries
            if len(parts) >= 4:
                try:
                    # Convert 4th entry to float, multiply by 0.5, and format back
                    value = float(parts[3])
                    # parts[3] = str(value * 0.5)
                    parts[3] = str(value * 10.)
                except ValueError:
                    # If 4th entry is not a number, leave it unchanged
                    pass

            # Reconstruct the line with single spaces
            outfile.write(" ".join(parts) + newline)

    print(f"Processed file written to: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py input_file.txt")
        sys.exit(1)

    input_file = sys.argv[1]
    process_file(input_file)