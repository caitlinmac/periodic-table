#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if argument is not provided:
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.

#or if argument is a number but does not match symbol or name
elif [[ $1 =~ [0-9]+ && -z $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;") ]]
then
echo I could not find that element in the database.

#or if argument is a symbol or name but does not match symbol or name
elif [[ $1 =~ [A-Z][a-z]+ &&-z $($PSQL "SELECT atomic_number FROM elements WHERE name='$1';") && -z $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';") ]]
then 
echo I could not find that element in the database.


# otherwise an argument is provided AND is a digit
elif [[ $1 =~ [0-9]+ ]]
then
  ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1;") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
  
# if argument is > 3 letters, it must be a name
  elif [[ $1 =~ [A-Z][a-z][a-z][a-z]+ ]]
  then
  ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1';") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done

# if argument is 3 letters or less, it must be a symbol
  elif [[ $1 =~ [A-Z][a-z]*[a-z]* ]]
  then
    ATOMIC_NO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1';") 
       # Set IFS to tab character
       IFS=$'|'
      echo "$ATOMIC_NO" | while read NUM NAME SYMBOL TYPE MASS MELT BOIL
      do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
 
  else
    echo I could not find that element in the database.
fi