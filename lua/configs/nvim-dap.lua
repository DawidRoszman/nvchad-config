local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Attach to Spring Boot",
    hostName = "127.0.0.1",
    port = 5005,
  },
}
