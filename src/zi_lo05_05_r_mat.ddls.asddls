//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDSView for Material Report'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

//@Search.searchable: true
define root view entity ZI_LO05_05_R_MAT
  as select distinct from I_Product as mat
  association [0..1] to I_ProductText              as _zdesc    on  $projection.Product = _zdesc.Product
                                                                and _zdesc.Language     = 'E'
  association [0..1] to I_ProductText              as _zdescvi  on  $projection.Product = _zdescvi.Product
                                                                and _zdescvi.Language   = '쁩'
  association [0..*] to I_ProductPlantBasic        as _plant    on  $projection.Product = _plant.Product
  association [0..*] to ZC_LO05_05_COST            as _val      on  $projection.Product = _val.Product
  association [0..*] to I_ProductSalesDelivery     as _sales    on  $projection.Product = _sales.Product
  association [0..1] to ZC_LO05_05_PIR             as _pir      on  $projection.Product = _pir.Material

  association [0..1] to I_ProductSalesTax          as _salestax on  $projection.Product = _salestax.Product
  association [0..1] to I_ProductInspTypeSetting   as _insp     on  $projection.Product = _insp.Product
  association [0..1] to I_Productplantqtmanagement as _qm       on  $projection.Product = _qm.Product
  association [0..1] to I_Supplier                 as _supplier on  _supplier.Supplier = mat.ManufacturerNumber
  association [0..*] to ZC_LO05_05_BATCHCL         as _class    on  _class.Product = mat.Product

{
       //      @Search.defaultSearchElement: true
       @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductText', element: 'Product' } }]
  key  mat.Product,
  key  _plant.Plant,
  key  _val.ValuationArea,
  key  _pir.PurchasingInfoRecord,
  key  _sales.ProductSalesOrg,
  key  _sales.ProductDistributionChnl,
  key  _insp.InspectionLotType,
  key _class.ClassType,
       //      @Search.defaultSearchElement: true
       _zdesc.ProductName                                                                    as ProductName,
       _zdescvi.ProductName                                                                  as ProductNameVI,
       //      _pir.PurchasingInfoRecord,
       @Semantics.quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit'
       _pir.MOQ,
       _pir.PurgDocOrderQuantityUnit,
       _pir.LeadTime, //leadtime

       concat_with_space(_supplier.BusinessPartnerName2, _supplier.BusinessPartnerName3, 1 ) as Maker,
       //      mat.ManufacturerNumber        as Maker,
       mat.CountryOfOrigin,
       mat.BaseUnit,
       mat.ProductOldID,
       _pir.PurgDocOrderQuantityUnit                                                         as PurchaseOrderQuantityUnit,
       //      mat.PurchaseOrderQuantityUnit,
       @Semantics.amount.currencyCode: 'CurrencyPIR'
       _pir.SellingPrice,
       _pir.CurrencyPIR,
       _pir.TaxCode,
       //      _pir.VAT,
       mat.ProductManufacturerNumber,
       _pir.SupplierMaterialNumber, //Supplier Material Number
       _pir.Supplier, //Supplier
       _pir.BusinessPartnerName1                                                             as SupplierName,
       _pir.SupplierRespSalesPersonName,
       _plant.PurchasingGroup,
       @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductTypeText', element: 'ProductType' } }]
       mat.ProductType,
       @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductGroupText_2', element: 'ProductGroup' } }]
       mat.ProductGroup,
       mat.ExternalProductGroup,
       @Semantics.quantity.unitOfMeasure : 'VolumeUnit'
       mat.MaterialVolume,
       mat.VolumeUnit,
       @Semantics.quantity.unitOfMeasure : 'WeightUnit'
       mat.GrossWeight,
       @Semantics.quantity.unitOfMeasure : 'WeightUnit'
       mat.NetWeight,
       mat.WeightUnit,
       mat.CrossPlantStatus,
       mat.IsBatchManagementRequired,
       mat.QltyMgmtInProcmtIsActive,

       _val.ValuationClass,
       _val.InventoryValuationProcedure,
       _val.PriceDeterminationControl,
       _val.CurrencyVal,
       @Semantics.amount.currencyCode: 'CurrencyVal'
       _val.MovingAveragePrice,
       @Semantics.amount.currencyCode: 'CurrencyVal'
       _val.StandardPrice,

       _val.PriceUnitQty,
       _val.IsMaterialCostedWithQtyStruc,
       _val.CostOriginGroup,
       _val.CostingOverheadGroup,
       _plant.AvailabilityCheckType,
       _plant.ProfitCenter,
       _plant.MRPType,
       _plant.MRPResponsible,
       _plant._MaterialLotSizingProcedure.MRPGroup,
       _plant._MaterialLotSizingProcedure.PlanningStrategyGroup,
       @Semantics.quantity.unitOfMeasure : 'BaseUnit'
       _plant._MaterialLotSizingProcedure.ReorderThresholdQuantity,
       @Semantics.quantity.unitOfMeasure : 'BaseUnit'
       _plant._MaterialLotSizingProcedure.SafetyStockQuantity,
       _plant._MaterialLotSizingProcedure.ProductionInvtryManagedLoc,
       _plant._MaterialLotSizingProcedure.MatlCompIsMarkedForBackflush,
       _plant._MaterialLotSizingProcedure.ProcurementType,
       _plant._MaterialLotSizingProcedure.LotSizingProcedure,
       _plant._MaterialLotSizingProcedure.DependentRequirementsType,
       _plant._GoodsMovementQuantity.ProductionSupervisor,

       _sales.SalesMeasureUnit,
       _sales.SupplyingPlant,
       _sales.ItemCategoryGroup,
       _sales.AccountDetnProductGroup,
       _salestax.Country,
       _salestax.TaxCategory,
       _salestax.TaxClassification,
       _qm.QualityMgmtCtrlKey,
       
       _class.Class
}
