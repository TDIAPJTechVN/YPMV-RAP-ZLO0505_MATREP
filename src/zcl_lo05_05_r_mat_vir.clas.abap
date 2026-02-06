CLASS zcl_lo05_05_r_mat_vir DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_LO05_05_R_MAT_VIR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity NS 'ZC_LO05_05'.
      RETURN.
    ENDIF.
    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
      CASE <fs_calc_element>.
        WHEN 'ZLONGTEXT'.
          INSERT `PRODUCT` INTO TABLE et_requested_orig_elements.

        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lt_original_data TYPE TABLE OF zc_lo05_05_mat,
          lv_vat           TYPE i.
    lt_original_data = CORRESPONDING #( it_original_data ).

    SELECT ltext~product, ltext~productlongtext FROM
       i_productbasictexttp_2 AS ltext
       INNER JOIN @lt_original_data AS mat ON mat~product = ltext~product
        ORDER BY mat~product
       INTO TABLE @DATA(lt_longtext)
       .

    " PIR
    SELECT data~product, data~purchasinginforecord,
           pir~availabilitystartdate, pir~availabilityenddate,
           _tax~conditionrateratio, _tax~conditionrateratiounit
    FROM @lt_original_data AS data
    INNER JOIN i_purchasinginforecordtp AS pir ON pir~purchasinginforecord = data~purchasinginforecord
                 AND pir~isdeleted = ''
    LEFT OUTER JOIN i_purginforecdorgplntdatatp AS plant ON plant~purchasinginforecord = pir~purchasinginforecord
                  AND plant~ismarkedfordeletion = ''
    LEFT OUTER JOIN i_taxcoderate                  AS _tax  ON  plant~taxcode = _tax~taxcode
                                                            AND _tax~country  = 'VN'

    INTO TABLE @DATA(lt_pir)
   .
    SORT lt_pir BY product purchasinginforecord ASCENDING.

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<lf_data>).
      READ TABLE lt_longtext INTO DATA(ls_text) WITH KEY product = <lf_data>-product BINARY SEARCH.
      IF sy-subrc = 0.
        <lf_data>-zlongtext = ls_text-productlongtext.
      ENDIF.

      READ TABLE lt_pir INTO DATA(ls_pir)
      WITH KEY product = <lf_data>-product
               purchasinginforecord = <lf_data>-purchasinginforecord
      BINARY SEARCH.
      IF sy-subrc = 0.
        lv_vat = ls_pir-conditionrateratio.
        <lf_data>-zvat  = |{ lv_vat }{ ls_pir-conditionrateratiounit }|.
        <lf_data>-zavaibstartdate = ls_pir-availabilitystartdate.
        <lf_data>-zavaibenddate = ls_pir-availabilityenddate.
      ENDIF.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.
ENDCLASS.
