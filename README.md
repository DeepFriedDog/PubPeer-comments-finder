# PubPeer-comments-finder

A simple R function to retrieve the number of PubPeer comments for any PubMed ID using the PubPeer API.

## Installation

This script requires two R packages:
- `httr`
- `jsonlite`

These will be automatically installed if they're not already present on your system.

## Usage

1. Clone this repository or download the `pubpeer_comments.R` file.

2. Source the file in R:
```
source("pubpeer_comments.R")
```

3. Use the function with any PubMed ID:
```r
# Example with a single PubMed ID
comments_count <- get_pubpeer_comments_count("12345678")
print(paste("Number of PubPeer comments:", comments_count))

# Example with error handling
tryCatch({
  comments_count <- get_pubpeer_comments_count("12345678")
  print(paste("Number of PubPeer comments:", comments_count))
}, error = function(e) {
  print(paste("Error:", e$message))
})
```

## Function Details

`get_pubpeer_comments_count(pmid)`

### Parameters
- `pmid`: A character string containing the PubMed ID

### Returns
- An integer representing the number of PubPeer comments
- Returns 0 if the publication is not found or has no comments
- Throws an error if there are connection issues or API problems

## Notes

- Requires an active internet connection
- Uses PubPeer API v3
- Returns 0 for publications not found on PubPeer or without comments
- Includes error handling for API and connection issues

## License

This project is open source and available under the MIT License.