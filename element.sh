#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if argument is not provided:
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
# otherwise an argument is provided
else
  ##FIX NEEDED: ERROR MESSAGE PRINTING TO TERMINAL WHEN NOT MATCHED
  ARG_NO=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
  ARG_SYM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
  ARG_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
  
  # if an argument is not matched with database
  if [[ -z $ARG_NO && $ARG_SYM && $ARG_NAME ]]
  then
    echo I could not find that element in the database.
  
  # if argument is provided that matches database
  else
    ARG=$ARG_NO$ARG_SYM$ARG_NAME
    echo $ARG
    #if argument provided is atomic number
    if [[ $ARG_NO == $1 ]]
    then
      ##FIX NEEDED: NOT PIPING INTO THE VARIABLES!
      ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1;") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
  #if argument provided is symbol
    elif [[ $ARG_SYM == $1 ]]
    then
      echo Symbol!
      #ATOMIC_NO=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
      ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol=$1;") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
  #if argument provided is name
    elif [[ $ARG_NAME == $1 ]]
    then
      echo Name!
      #ATOMIC_NO=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
      ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name=$1;") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    fi
  fi
fi