# PubPeer-comments-finder

A simple R function to retrieve the number of PubPeer comments for any PubMed ID by web scraping.

## Installation

This script requires:

R packages:
- `httr`
- `rvest`
- `reticulate`

Python dependencies:
- `selenium`
- `webdriver_manager`

Installation steps:
1. Install Python from python.org
2. Run these commands in terminal:
   ```bash
   pip install selenium webdriver_manager
   ```
3. Install R packages:
   ```r
   install.packages(c("httr", "rvest", "reticulate"))
   ```

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
- Throws an error if there are connection issues or scraping problems

## Notes

- Requires an active internet connection
- Uses web scraping to get comment counts
- Requires Chrome browser to be installed
- Returns 0 for publications not found on PubPeer or without comments
- Includes error handling for connection and scraping issues

## License

This project is open source and available under the MIT License.