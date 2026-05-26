namespace ul.commons;
using { Currency } from '@sap/cds/common';


type Guid : String(32);

//address data of student - like structure in abap - reusable
aspect address{
    city : String(64);
    country : String(64);
    pincode : Int32;
    landmark : String(100);
    flatNo : String(50);
}

type  Gender : String(1) enum{
    Male = 'M';
    Female = 'F';
    Undisclosed = 'U';
};

type AmountT : Decimal(10,2)@(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

aspect Amount: {
    CURRENCY: Currency;
    GROSS_AMOUNT: AmountT @(title : '{i18n>GROSS}');
    NET_AMOUNT: AmountT @(title : '{i18n>NET}');
    TAX_AMOUNT: AmountT @(title : '{i18n>TAX}');
}

type PhoneNumber: String(30)@assert.format : '^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
//type Email: String(255)@assert.format : '/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/';
type Email: String(255)@assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';