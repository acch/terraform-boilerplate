# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "content" {
  count = var.lines

  length = var.words
}

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "foo" {
  filename        = "${path.root}/_${var.filename}.txt"
  content         = join("\n", random_pet.content[*].id)
  file_permission = "0644"
}
