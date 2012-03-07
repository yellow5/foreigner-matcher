#!/bin/sh

case $DB in
  'mysql')
    mysql -e 'create database `foreigner-matcher_test`;'
    ;;
  'postgres')
    psql -c 'create database "foreigner-matcher_test";' -U postgres
    ;;
esac
