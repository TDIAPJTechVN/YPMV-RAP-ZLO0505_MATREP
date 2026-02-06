@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDSView of Product Batch class'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_LO05_05_BATCHCL
  as select from I_ClfnObjectClass as _obj
  association [1..1] to I_ClfnClass as _class on  _class.ClassInternalID  = _obj.ClassInternalID 
{
  key _obj.ClfnObjectID as Product,
  key _class.ClassType ,
      _class.Class 
}
