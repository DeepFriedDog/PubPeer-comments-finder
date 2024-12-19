# Load required packages
library(httr)
library(rvest)
library(reticulate)

# Configure Python path explicitly
use_python("C:/Python312/python.exe")

# Install Python dependencies if not present
if (!py_module_available("selenium")) {
  system("pip install selenium webdriver_manager")
}

# Import Python modules
selenium <- import("selenium")
webdriver <- import("selenium.webdriver")
webdriver_manager <- import("webdriver_manager.chrome")

#' Get PubPeer Comments Count
#' 
#' This function retrieves the number of PubPeer comments for a given PubMed ID
#' @param pmid A character string containing the PubMed ID
#' @return The number of PubPeer comments (integer)
#' @examples
#' comments_count <- get_pubpeer_comments_count("12345678")
#' 
get_pubpeer_comments_count <- function(pmid) {
  tryCatch({
    # Initialize Chrome driver
    driver <- webdriver$Chrome(
      service=webdriver$chrome$service$Service(
        webdriver_manager$ChromeDriverManager()$install()
      )
    )
    
    # Navigate to PubPeer
    url <- paste0("https://pubpeer.com/search?q=", pmid)
    message("Searching URL:", url)
    driver$get(url)
    
    # Wait for element and get text
    Sys.sleep(2)  # Wait for page to load
    comments_text <- driver$find_element("css selector", ".panel-footer .pull-right")$text
    
    message("Raw text found:", comments_text)
    
    # Clean up
    driver$quit()
    
    # Extract the number
    if (!is.null(comments_text)) {
      clean_text <- sub("^[^0-9]*", "", comments_text)
      clean_text <- sub("\\s.*$", "", clean_text)
      
      if (clean_text != "") {
        count <- as.integer(clean_text)
        message("Found comments count:", count)
        return(count)
      }
    }
    
    return(0)
    
  }, error = function(e) {
    message("Error:", e$message)
    if (exists("driver")) driver$quit()
    return(0)
  })
}

# Test with PMID
pmid <- "39520719"
result <- get_pubpeer_comments_count(pmid)
print(paste("Number of PubPeer comments:", result)) 