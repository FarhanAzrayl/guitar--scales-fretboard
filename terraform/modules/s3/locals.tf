# This is just to "translate" the file extensions into MIME types for Terraform to read
# If file type is not detected here, it will return a default value so no worries

locals {

  mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"

    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    gif  = "image/gif"
    svg  = "image/svg+xml"
    ico  = "image/x-icon"

    json = "application/json"

    txt = "text/plain"
  }

}