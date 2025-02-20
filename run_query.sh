#! /bin/bash

# Run a CodeQL query on a database
# Usage: ./run_query.sh -d <database> -q <query> -o <output>

# Parse command line arguments
while getopts "d:q:o:" opt; do
  case $opt in
    d)
      DB_PATH="$OPTARG"
      ;;
    q)
      QUERY_PATH="$OPTARG"
      ;;
    o)
      OUTPUT_PATH="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Check if all required arguments are provided
if [ -z "$DB_PATH" ] || [ -z "$QUERY_PATH" ] || [ -z "$OUTPUT_PATH" ]; then
    echo "Error: All arguments must be specified"
    echo "Usage: ./run_query.sh -d <database> -q <query> -o <output>"
    exit 1
fi

# Check if database exists
if [ ! -d "$DB_PATH" ]; then
    echo "Error: Database directory '$DB_PATH' does not exist"
    exit 1
fi

# Check if query file exists
if [ ! -f "$QUERY_PATH" ]; then
    echo "Error: Query file '$QUERY_PATH' does not exist"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT_PATH")"

# Run the CodeQL query
echo "Running query '$QUERY_PATH' on database '$DB_PATH'"
codeql query run "$QUERY_PATH" \
    --database="$DB_PATH" \
    --output="$OUTPUT_PATH" || {
    echo "Failed to run query"
    exit 1
}

echo "Query results saved to $OUTPUT_PATH"
