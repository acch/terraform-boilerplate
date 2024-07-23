# common values for all test runs
variables {
  lines    = 3
  words    = 1
  filename = "_test.txt"

  tags = {
    Context = "test"
  }
}

run "unit_tests" {
  command = plan

  assert {
    condition     = local_file.foo.file_permission == "0644"
    error_message = "Unexpected file permission"
  }

  assert {
    condition     = local_file.foo.directory_permission == "0777"
    error_message = "Unexpected directory permission"
  }

  assert {
    condition     = length(random_pet.content) == var.lines
    error_message = "Unexpected file length"
  }

  assert {
    condition = alltrue([
      for c in random_pet.content : c.length == var.words
    ])
    error_message = "Unexpected content length"
  }

  assert {
    condition = alltrue([
      for c in random_pet.content : c.separator == "-"
    ])
    error_message = "Unexpected content separator"
  }
}

run "input_validation" {
  command = plan

  # invalid values
  variables {
    lines = -1
    words = -1
  }

  expect_failures = [
    var.lines,
    var.words
  ]
}

run "end_2_end_tests" {
  command = apply

  assert {
    condition = alltrue([
      for c in random_pet.content : can(regex("^[a-z]+$", c.id))
    ])
    error_message = "Unexpected content"
  }
}
