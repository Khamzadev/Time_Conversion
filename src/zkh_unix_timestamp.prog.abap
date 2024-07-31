*&---------------------------------------------------------------------*
*& Report ZKH_UNIX_TIMESTAMP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZKH_UNIX_TIMESTAMP.

DATA: lv_unix_time TYPE i VALUE 1714833335, " Пример Unix-времени в секундах
      lv_timestamp_msec TYPE string,
      lv_date          TYPE datum,
      lv_time          TYPE uzeit,
      lv_timestamp     TYPE timestampl,
      lv_timezone      TYPE timezone VALUE 'UTC'. " Установите нужную временную зону

* Преобразуем Unix-время в миллисекунды
lv_timestamp_msec = lv_unix_time * 1000.

* Используем метод для преобразования Java-времени в формат ABAP
CALL METHOD cl_pco_utility=>convert_java_timestamp_to_abap
  EXPORTING
    iv_timestamp = lv_timestamp_msec
  IMPORTING
    ev_date      = lv_date
    ev_time      = lv_time.

* Преобразуем дату и время в временную метку
CONVERT DATE lv_date TIME lv_time INTO TIME STAMP lv_timestamp
  TIME ZONE lv_timezone.

* Вывод результата
WRITE: / 'Unix-время:', lv_unix_time,
       / 'Дата:', lv_date,
       / 'Время:', lv_time,
       / 'Временная метка:', lv_timestamp.
