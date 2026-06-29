return {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  root_markers = { ".git", "compile_commands.json" },
  init_options = {
    fallbackFlags = { "-Wall", "-Wextra" },
  },
}
