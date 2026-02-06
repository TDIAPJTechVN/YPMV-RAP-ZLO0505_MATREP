@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDSView of Product PIR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_LO05_05_PIR
  as select from    I_PurchasingInfoRecordApi01    as _pir
    left outer join I_PurgInfoRecdOrgPlntDataApi01 as plant on  plant.PurchasingInfoRecord = _pir.PurchasingInfoRecord
                                                            and plant.IsMarkedForDeletion  = ''
    left outer join I_PurgInfoRecdPriceCndnAPI01   as cond  on  cond.PurchasingInfoRecord       = plant.PurchasingInfoRecord
                                                            and cond.ConditionType              = 'PPR0'
                                                            and cond.Plant                      = plant.Plant
                                                            and cond.ConditionValidityEndDate   >= $session.system_date
                                                            and cond.ConditionValidityStartDate <= $session.system_date
  //    left outer join I_TaxCodeRate                  as _tax  on  plant.TaxCode = _tax.TaxCode
  //                                                            and _tax.Country  = 'VN'
    left outer join I_Supplier                     as _supp on _supp.Supplier = _pir.Supplier
{
  key _pir.Material,
  key _pir.PurchasingInfoRecord,
      @Semantics.quantity.unitOfMeasure : 'PurgDocOrderQuantityUnit'
      plant.MinimumPurchaseOrderQuantity as MOQ,
      _pir.PurgDocOrderQuantityUnit      as PurgDocOrderQuantityUnit,
      plant.MaterialPlannedDeliveryDurn  as LeadTime, //leadtime
      @Semantics.amount.currencyCode: 'CurrencyPIR'
      //      plant.NetPriceAmount               as SellingPrice,
      cond.ConditionRateValue            as SellingPrice,
      plant.Currency                     as CurrencyPIR,
      plant.TaxCode,
      //      _tax.ConditionRateRatioUnit        as VAT,
      _pir.SupplierMaterialNumber, //Supplier Material Number
      _pir.Supplier, //Supplier
      _pir.SupplierRespSalesPersonName,
      _supp.BusinessPartnerName1
}
where
  _pir.IsDeleted = ''
