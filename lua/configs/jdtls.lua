local home = os.getenv("HOME")
local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.1.jar", 1)
}

require('jdtls').start_or_attach({
  cmd = {'jdtls'},
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  init_options = { bundles = bundles },
})

require('jdtls').setup_dap({ hotcodereplace = 'auto' })
