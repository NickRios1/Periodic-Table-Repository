#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1

ELEMENT_INFO() {
  if [[ -z $INPUT ]]
  then
    echo "Please provide an element as an argument."
  else
    if [[ $INPUT =~ ^[0-9]+$ ]]
    then
      ELEMENT_NUMBER=$INPUT
      ELEMENT_NAME=$($PSQL "select name from elements where atomic_number=$ELEMENT_NUMBER")
      if [[ -z $ELEMENT_NAME ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_TYPE=$($PSQL "select type from properties inner join types using(type_id) where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_NUMBER")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_NUMBER") 
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_NUMBER")
        echo "The element with atomic number ${ELEMENT_NUMBER// /} is ${ELEMENT_NAME// /} (${ELEMENT_SYMBOL// /}). It's a ${ELEMENT_TYPE// /}, with a mass of ${ELEMENT_MASS// /} amu. ${ELEMENT_NAME// /} has a melting point of ${MELTING_POINT// /} celsius and a boiling point of ${BOILING_POINT// /} celsius."
      fi
    elif [[ $INPUT =~ ^[A-Za-z]{1,2}$ ]]
    then
      ELEMENT_SYMBOL=$INPUT
      ELEMENT_NUMBER=$($PSQL "select atomic_number from elements where symbol='$ELEMENT_SYMBOL'")
      if [[ -z $ELEMENT_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_NAME=$($PSQL "select name from elements where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_TYPE=$($PSQL "select type from properties inner join types using(type_id) where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_NUMBER")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_NUMBER") 
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_NUMBER")
        echo "The element with atomic number ${ELEMENT_NUMBER// /} is ${ELEMENT_NAME// /} (${ELEMENT_SYMBOL// /}). It's a ${ELEMENT_TYPE// /}, with a mass of ${ELEMENT_MASS// /} amu. ${ELEMENT_NAME// /} has a melting point of ${MELTING_POINT// /} celsius and a boiling point of ${BOILING_POINT// /} celsius."
      fi
    elif [[ $INPUT =~ ^[A-Za-z]+$ ]]
    then
      ELEMENT_NAME=$INPUT
      ELEMENT_NUMBER=$($PSQL "select atomic_number from elements where name='$ELEMENT_NAME'")
      if [[ -z $ELEMENT_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_TYPE=$($PSQL "select type from properties inner join types using(type_id) where atomic_number=$ELEMENT_NUMBER")
        ELEMENT_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ELEMENT_NUMBER")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ELEMENT_NUMBER") 
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ELEMENT_NUMBER")
        echo "The element with atomic number ${ELEMENT_NUMBER// /} is ${ELEMENT_NAME// /} (${ELEMENT_SYMBOL// /}). It's a ${ELEMENT_TYPE// /}, with a mass of ${ELEMENT_MASS// /} amu. ${ELEMENT_NAME// /} has a melting point of ${MELTING_POINT// /} celsius and a boiling point of ${BOILING_POINT// /} celsius."
      fi
    fi
  fi

}

ELEMENT_INFO

