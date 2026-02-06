@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection CDSView for Material Report'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true
define root view entity ZC_LO05_05_MAT
  as projection on ZI_LO05_05_R_MAT

{
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductText', element: 'Product' } }]
  key     Product,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_PlantStdVH', element: 'Plant' } }]
          @Consumption.filter.defaultValue: '5730'
          @Consumption.filter.mandatory: true
  key     Plant,
  key     ValuationArea,
  key     PurchasingInfoRecord,
  key     ProductSalesOrg,
  key     ProductDistributionChnl,
  key     InspectionLotType,
  key     ClassType,
          
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Product Name'
          ProductName,
          @Search.defaultSearchElement: true
          ProductNameVI,
          @EndUserText.label: 'Old Product Number'
          ProductOldID,
          //          PurchasingInfoRecord,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LO05_05_R_MAT_VIR'
          @EndUserText.label: 'Long Text'
  virtual ZLONGTEXT       : abap.string( 0 ),
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LO05_05_R_MAT_VIR'
          @EndUserText.label: 'VAT'
  virtual ZVAT            : abap.char(10),
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LO05_05_R_MAT_VIR'
          @EndUserText.label: 'Avaibility Start Date'
  virtual ZAvaibStartDate : abap.dats,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LO05_05_R_MAT_VIR'
          @EndUserText.label: 'Avaibility End Date'
  virtual ZAvaibEndDate   : abap.dats,
          //      @ObjectModel.readOnly: true

          //      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_LO05_03_MATUPL_JOB'
          //      cast ( ' ' as abap.char(40) ) as ProductLongText,
          //      _pir.,// MOQ ,
          @Semantics.quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit'
          MOQ,
          PurgDocOrderQuantityUnit,
          LeadTime, //leadtime
          Maker,
          CountryOfOrigin,
          BaseUnit,
          PurchaseOrderQuantityUnit,
          @Semantics.amount.currencyCode: 'CurrencyPIR'
          SellingPrice,
          CurrencyPIR,
          TaxCode,
          //          VAT,
          ProductManufacturerNumber,
          SupplierMaterialNumber, //Supplier Material Number
          Supplier, //Supplier
          @EndUserText.label: 'Supplier Short Name'
          SupplierName,
          SupplierRespSalesPersonName,
          PurchasingGroup,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductTypeText', element: 'ProductType' } }]
          ProductType,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductGroupText_2', element: 'ProductGroup' } }]
          ProductGroup,
          ExternalProductGroup,
          @Semantics.quantity.unitOfMeasure : 'VolumeUnit'
          MaterialVolume,
          VolumeUnit,
          @Semantics.quantity.unitOfMeasure : 'WeightUnit'
          GrossWeight,
          @Semantics.quantity.unitOfMeasure : 'WeightUnit'
          NetWeight,
          WeightUnit,
          CrossPlantStatus,
          IsBatchManagementRequired,
          QltyMgmtInProcmtIsActive,

          ValuationClass,
          InventoryValuationProcedure,
          PriceDeterminationControl,
          CurrencyVal,
          @Semantics.amount.currencyCode: 'CurrencyVal'
          MovingAveragePrice,
          @Semantics.amount.currencyCode: 'CurrencyVal'
          StandardPrice,

          PriceUnitQty,
          IsMaterialCostedWithQtyStruc,
          CostOriginGroup,
          CostingOverheadGroup,
          AvailabilityCheckType,
          ProfitCenter,
          MRPType,
          MRPResponsible,
          MRPGroup,
          PlanningStrategyGroup,
          @Semantics.quantity.unitOfMeasure : 'BaseUnit'
          ReorderThresholdQuantity,
          @Semantics.quantity.unitOfMeasure : 'BaseUnit'
          SafetyStockQuantity,
          ProductionInvtryManagedLoc,
          MatlCompIsMarkedForBackflush,
          ProcurementType,
          LotSizingProcedure,
          DependentRequirementsType,
          ProductionSupervisor,
          SalesMeasureUnit,
          SupplyingPlant,
          ItemCategoryGroup,
          AccountDetnProductGroup,
          Country,
          TaxCategory,
          TaxClassification,
          //          InspectionLotType,
          QualityMgmtCtrlKey,
          Class
}
