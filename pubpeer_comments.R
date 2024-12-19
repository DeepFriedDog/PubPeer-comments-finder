#' Get PubPeer Comments Count
#' 
#' This function retrieves the number of PubPeer comments for a given PubMed ID
#' @param pmid A character string containing the PubMed ID
#' @return The number of PubPeer comments (integer)
#' @examples
#' comments_count <- get_pubpeer_comments_count("12345678")
#' 
get_pubpeer_comments_count <- function(pmid) {
  # Debug: Print PMID
  cat("Checking PMID:", pmid, "\n")
  
  api_url <- paste0("https://pubpeer.com/v3/publications/", pmid)
  cat("API URL:", api_url, "\n")
  
  cat("Making API request...\n")
  response <- tryCatch({
    GET(api_url)
  }, error = function(e) {
    cat("Error in API request:", e$message, "\n")
    stop("Error connecting to PubPeer API: ", e$message)
  })
  
  # Debug: Print response status
  cat("Response status code:", status_code(response), "\n")
  
  if (status_code(response) == 200) {
    cat("Successfully received response\n")
    # Debug: Print raw response
    raw_content <- rawToChar(response$content)
    cat("Raw response:", substr(raw_content, 1, 100), "...\n")
    
    content <- fromJSON(raw_content)
    cat("Parsed JSON content\n")
    
    if (!is.null(content$total_comments)) {
      cat("Found total_comments:", content$total_comments, "\n")
      return(content$total_comments)
    } else {
      cat("No comments found\n")
      return(0)
    }
  } else if (status_code(response) == 404) {
    cat("Publication not found on PubPeer\n")
    return(0)
  } else {
    cat("Unexpected status code\n")
    stop("Error: HTTP status code ", status_code(response))
  }
}

# Example usage
if (FALSE) {  # This block won't run unless explicitly set to TRUE
  pmid <- "12345678"
  tryCatch({
    comments_count <- get_pubpeer_comments_count(pmid)
    print(paste("Number of PubPeer comments:", comments_count))
  }, error = function(e) {
    print(paste("Error:", e$message))
  })
} 