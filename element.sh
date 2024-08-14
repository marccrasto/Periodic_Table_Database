#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $1 =~ ^[0-9]+*$ ]]
  then
    ELEMENT_INFO=($($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN TYPES USING(type_id) WHERE name = '$1' OR symbol = '$1'"))
    if [[ ! -z $ELEMENT_INFO ]]
    then
      echo $(echo $ELEMENT_INFO | sed  's/|/ /g')  | while read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo -e "I could not find that element in the database."
    fi 
  else
    ELEMENT_INFO=($($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN TYPES USING(type_id) WHERE atomic_number = $1"))
    if [[ ! -z $ELEMENT_INFO ]]
    then
      echo $(echo $ELEMENT_INFO | sed  's/|/ /g')  | while read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo -e "I could not find that element in the database."
    fi
  fi
fi