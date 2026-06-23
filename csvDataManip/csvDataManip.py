import sys
import pandas as pd

## example: python csvDataManip.py input.csv output.csv 2 5.0

def main():
    if len(sys.argv) != 5:
        print("Usage: python script.py <input_csv> <output_csv> <column_index> <add_value>")
        sys.exit(1)

    input_csv = sys.argv[1]
    output_csv = sys.argv[2]
    col_index = int(sys.argv[3])      # 0-based column index
    add_value = float(sys.argv[4])    # value to add

    # Load CSV
    df = pd.read_csv(input_csv)

    # Check column index
    if col_index < 0 or col_index >= len(df.columns):
        print(f"Error: column_index must be between 0 and {len(df.columns) - 1}")
        sys.exit(1)

    col_name = df.columns[col_index]

    # Add value to that column
    df[col_name] = df[col_name] + add_value

    # Write to new CSV with scientific notation (8 digits after decimal)
    df.to_csv(output_csv, index=False, float_format="%.8e")

    print(f"Updated CSV written to {output_csv}")

if __name__ == "__main__":
    main()