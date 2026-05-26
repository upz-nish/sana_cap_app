using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(

    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem:[

        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Label : 'Boost',
            Inline : true
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : IconColor
        }
    ],
    UI.HeaderInfo:{
        TypeName:'Purchase Order',
        TypeNamePlural:'Purchase Orders',
        Title:{Value:PO_ID},
        Description:{Value:PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://p7.hiclipart.com/preview/301/258/530/logo-sap-se-businessobjects-business-intelligence-business-thumbnail.jpg'
    },
    UI.Facets: [
        {
            $Type: 'UI.CollectionFacet',
             Label: 'General Information',
             Facets:[
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'PO Details',
                    Target: '@UI.Identification'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Price Details',
                    Target: '@UI.FieldGroup#PriceData'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Additional Details',
                    Target: '@UI.FieldGroup#AdditionalData'
                },
             ],
        },
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Items',
            Target: 'Items/@UI.LineItem'
        },
    ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: NOTE
        },
        {
            $Type: 'UI.DataFieldForAction',
            Action: 'CatalogService.setOrderProcessing',
            Label: 'Set to Delivered',
        }
    ],
    UI.FieldGroup #PriceData : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            }
        ]
    },
    UI.FieldGroup #AdditionalData : {
        Data : [
            {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
        ]
    }
);

annotate service.PurchaseItemSet with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ],
    UI.HeaderInfo: {
        TypeName:'Purchase Item',
        TypeNamePlural:'Purchase Order Items',
        Title:{Value:PO_ITEM_POS},
        Description:{Value:PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Details',
            Target : '@UI.Identification'
        }
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ]
);

annotate service.PurchaseOrderSet with {
    @Common.Text: PO_ID
    PO_ID;
    @Common.Text: PARTNER_GUID.COMPANY_NAME
    PARTNER_GUID;
};

annotate  service.PurchaseItemSet with {
    @Common.Text: PRODUCT_GUID.DESCRIPTION
    PRODUCT_GUID;
};
annotate service.PurchaseOrderSet with {
    OVERALL_STATUS @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'StatusCode',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OverallStatus,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Status Code',
        },
        Common.ValueListWithFixedValues : true,
);
@ValueList.entity: service.BusinessPartnerSet
    PARTNER_GUID;
};

annotate service.PurchaseItemSet with {
    @ValueList.entity: service.ProductSet
        PRODUCT_GUID
};

annotate service.StatusCode with {
    code @(
        Common.Text : text,
        Common.Text.@UI.TextArrangement : #TextFirst,
)};

//CREATE VALUE HELPS
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME,
        }
    ]
);

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: DESCRIPTION,
        }
    ]
);
