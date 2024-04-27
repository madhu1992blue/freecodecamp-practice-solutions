#!/bin/bash
if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  ELEMENT=$1
  PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
  ALL_ELEMENT_INFO_COMMAND="SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id)"
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_INFO=$($PSQL "$ALL_ELEMENT_INFO_COMMAND WHERE elements.atomic_number=$1")
  else
    ELEMENT_INFO=$($PSQL "$ALL_ELEMENT_INFO_COMMAND WHERE elements.symbol='$1' or elements.name='$1'")

  fi
  if [[ -z $ELEMENT_INFO ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read ATOMIC_NUMBER ELEMENT_SYMBOL ELEMENT_NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE <<< $(echo "$ELEMENT_INFO")
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi

fi

