sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"sana/ul/managepo/test/integration/pages/PurchaseOrderSetList",
	"sana/ul/managepo/test/integration/pages/PurchaseOrderSetObjectPage",
	"sana/ul/managepo/test/integration/pages/PurchaseItemSetObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, PurchaseItemSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('sana/ul/managepo') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePurchaseItemSetObjectPage: PurchaseItemSetObjectPage
        },
        async: true
    });

    return runner;
});

