variable "name" {
    type = string
    description = "System name"
}

variable "holding_count" {
    type = number
    default = 10
    description = "Number of images to keep"
}