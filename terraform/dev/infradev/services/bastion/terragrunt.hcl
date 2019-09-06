dependency "infrastructure" {
  config_path = "../../infrastructure"
}

include {
  path = find_in_parent_folders()
}
