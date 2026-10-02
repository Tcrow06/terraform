terraform {
  required_version = "1.16.4"

  cloud {
    
    organization = "Dev-Thinz"

    workspaces {
      name = "Import"
    }
  }
}