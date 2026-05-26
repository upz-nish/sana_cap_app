const cds = require('@sap/cds')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { EmployeeSet, BusinessPartnerSet, AddressSet, ProductSet, PurchaseOrderSet, PurchaseItemSet } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], EmployeeSet, async (req) => {
    //console.log('Before CREATE/UPDATE EmployeeSet', req.data)
    const salary = req.data.salaryAmount;
    if (salary > 1000000) {
      req.error(500, 'No one allowed a million salary');
    }
  })
  this.after ('READ', EmployeeSet, async (employeeSet, req) => {
    console.log('After READ EmployeeSet', employeeSet)
  })
  this.before (['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
    console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
  })
  this.after ('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
    console.log('After READ BusinessPartnerSet', businessPartnerSet)
  })
  this.before (['CREATE', 'UPDATE'], AddressSet, async (req) => {
    console.log('Before CREATE/UPDATE AddressSet', req.data)
  })
  this.after ('READ', AddressSet, async (addressSet, req) => {
    console.log('After READ AddressSet', addressSet)
  })
  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    console.log('After READ ProductSet', productSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
    //console.log('After READ PurchaseOrderSet', purchaseOrderSet)
    for (let i = 0; i < purchaseOrderSet.length; i++) {
      const note = purchaseOrderSet[i];
      if (!note.NOTE) {
        note.NOTE = "No note found";
      }
    }
  })
  this.before (['CREATE', 'UPDATE'], PurchaseItemSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseItemSet', req.data)
  })
  this.after ('READ', PurchaseItemSet, async (purchaseItemSet, req) => {
    console.log('After READ PurchaseItemSet', purchaseItemSet)
  })

  this.on('boost', async (req) => {
    try {
          const ID = req.params[0]; //automatically get the primary key value of the PO for which boost action is called
          var tx = cds.tx(req);
          await tx.update(PurchaseOrderSet).with({
            GROSS_AMOUNT: { '+=': 20000 },
            NOTE: 'Boosted by 20K'
          }).where(ID);

          return await tx.read(PurchaseOrderSet).where(ID);
    } catch (error) {
      return 'Error ' + error.toString();
    }
    });

    //implementation of the function
    this.on('getLargestPurchaseOrder', async (req) => {
    try {
          //CQL syntax to get the largest purchase order based on gross amount
          var tx = cds.tx(req);
          const lt_orders = await tx.read(PurchaseOrderSet).orderBy({
            GROSS_AMOUNT: 'desc'
          }).limit(3);

          return lt_orders;
    } catch (error) {
      return 'Error ' + error.toString();
    }
    });

    //implementation of the function to make status N as default value for new purchase orders
    this.on('getSanaValues', async (req) => {
      return{
        OVERALL_STATUS: 'N'
      }
    });

    this.on('setOrderProcessing', async (req) => {
    try {
          const ID = req.params[0]; //automatically get the primary key value of the PO for which boost action is called
          var tx = cds.tx(req);
          await tx.update(PurchaseOrderSet).with({
            OVERALL_STATUS: 'D',
            NOTE: 'Delivered!'
          }).where(ID);

          return await tx.read(PurchaseOrderSet).where(ID);
    } catch (error) {
      return 'Error ' + error.toString();
    }
    });

  return super.init()
}}
