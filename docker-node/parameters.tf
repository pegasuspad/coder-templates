variable "dotfiles_uri" {
  description = <<-EOF
  Dotfiles repo URI (optional)

  see https://dotfiles.github.io
  EOF

  default = ""
}

data "coder_parameter" "dotfiles_uri" {
  default     = ""
  description = "URI of the git repository containing dotfiles to load."
  mutable     = true
  name        = "Dotfiles git uri"
  type        = "string"
}

data "coder_parameter" "node_version" {
  default     = "18"
  description = "Which version of node.js should be activated by default?"
  mutable     = true
  name        = "Node Version"
  type        = "string"

  option {
    name = "16"
    value = "16"
  }

  option {
    name = "18"
    value = "18"
  }

  option {
    name = "20"
    value = "20"
  }
}