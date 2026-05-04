CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.
  DATA row_1 TYPE string.
  DATA row_2 TYPE string.
  DATA start_position TYPE i.
  DATA second_position TYPE i.
  DATA cups TYPE string_table.
  DATA cup TYPE string.

  students = VALUE #(
    ( |Alice| )
    ( |Bob| )
    ( |Charlie| )
    ( |David| )
    ( |Eve| )
    ( |Fred| )
    ( |Ginny| )
    ( |Harriet| )
    ( |Ileana| )
    ( |Joseph| )
    ( |Kincaid| )
    ( |Larry| )
  ).

  SPLIT diagram AT '\n' INTO row_1 row_2.

  READ TABLE students WITH KEY table_line = student TRANSPORTING NO FIELDS.
  start_position = ( sy-tabix - 1 ) * 2.
  second_position = start_position + 1.

  cups = VALUE #(
    ( row_1+start_position(1) )
    ( row_1+second_position(1) )
    ( row_2+start_position(1) )
    ( row_2+second_position(1) )
  ).

  LOOP AT cups INTO cup.
    CASE cup.
      WHEN 'G'.
        APPEND |grass| TO results.
      WHEN 'C'.
        APPEND |clover| TO results.
      WHEN 'R'.
        APPEND |radishes| TO results.
      WHEN 'V'.
        APPEND |violets| TO results.
    ENDCASE.
  ENDLOOP.

  ENDMETHOD.


ENDCLASS.
