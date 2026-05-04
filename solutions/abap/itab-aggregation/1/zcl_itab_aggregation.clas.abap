CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    LOOP AT initial_numbers INTO DATA(initial_number).
      READ TABLE aggregated_data REFERENCE INTO              DATA(aggregated_item) WITH KEY group = initial_number-group.

      IF sy-subrc <> 0. 
        APPEND VALUE #(
        group = initial_number-group
        count = 1
        sum = initial_number-number
        min = initial_number-number
        max = initial_number-number
        ) TO aggregated_data.
      ELSE.
      aggregated_item->count = aggregated_item->count + 1.
      aggregated_item->sum = aggregated_item->sum + initial_number-number.

      IF initial_number-number < aggregated_item->min.
        aggregated_item->min = initial_number-number.
      ENDIF.

       IF initial_number-number > aggregated_item->max.
        aggregated_item->max = initial_number-number.
      ENDIF.
    ENDIF.
ENDLOOP.

LOOP AT aggregated_data REFERENCE INTO DATA(aggregated_result).
  aggregated_result->average = aggregated_result->sum / aggregated_result->count.
ENDLOOP.
  ENDMETHOD.

ENDCLASS.
