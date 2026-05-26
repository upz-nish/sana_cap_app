const cds = require('@sap/cds')

module.exports = class CDSService extends cds.ApplicationService { init() {

  const { ProductSet, POItemSet } = cds.entities('CDSService')

  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    //get all product ids in an array
    const ids = productSet.map(prd => prd.ProductID);
    
    //get the count of items  it ws sold in items
    const items = await SELECT.from(POItemSet)
                                      .columns('ProductID', {'func' : 'count', as: 'item_count'})
                                      .where({ 'ProductID': {in: ids} })
                                      .groupBy('ProductID');
    
    for (const wa of productSet) {
      const rec = items.find(pc => pc.ProductID === wa.ProductID)
      wa.soldCount = rec ? rec.item_count : 0
    }

  })
  this.before (['CREATE', 'UPDATE'], POItemSet, async (req) => {
    console.log('Before CREATE/UPDATE POItemSet', req.data)
  })
  this.after ('READ', POItemSet, async (pOItemSet, req) => {
    console.log('After READ POItemSet', pOItemSet)
  })


  return super.init()
}}
