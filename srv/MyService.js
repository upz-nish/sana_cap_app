const cds = require('@sap/cds')

module.exports = class MyService extends cds.ApplicationService { init() {



  this.on ('hello', async (req) => {
    const userName = req.data.name;
    return `Hello, ${userName}!`;
  })

  return super.init()
}}
