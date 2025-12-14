return {
  cmd = { 'sh', '-c', 'tofu-ls serve 2>/dev/null' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
}
