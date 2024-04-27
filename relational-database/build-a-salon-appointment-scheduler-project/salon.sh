#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only --no-align -c"

OFFER_SERVICE () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nSelect your service:"
  SERVICES_OFFERED=$($PSQL "SELECT service_id, name FROM services")
  echo "$SERVICES_OFFERED" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED
  IFS="|" read SERVICE_ID_SELECTED SERVICE_NAME_SELECTED <<< $($PSQL "SELECT service_id, name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_ID_SELECTED ]]
  then
    OFFER_SERVICE "Please select a valid service."
  else
    echo -e "\nEnter your Phone Number:"
    read CUSTOMER_PHONE
    IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< $($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e"\nEnter your name:"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
      IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< $($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi
    echo -e "\nEnter service time:"
    read SERVICE_TIME
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id,time) VALUES ($SERVICE_ID_SELECTED,$CUSTOMER_ID,'$SERVICE_TIME')")
    if [[ $INSERT_APPOINTMENT_RESULT == "INSERT 0 1" ]]
    then
      echo "I have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}


OFFER_SERVICE