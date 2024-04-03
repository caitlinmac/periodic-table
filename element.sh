#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if argument is not provided:
if [[ -z $1 ]]
then
echo NO ARG
echo Please provide an element as an argument.
fi 

ARG_NO=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
ARG_SYM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
ARG_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")

#pipe error message? I know if wont exist for all of them but need to check!

if [[ -z $ARG_NO && $ARG_SYM && $ARG_NAME ]]
then
echo I could not find that element in the database.
else
#if argument is provided:
ARG=$ARG_NO$ARG_SYM$ARG_NAME
echo $ARG
if [[ ]]
$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'";)

#Retrieve atomic_number, name, symbol, type, mass, melting point, boiling point. 
## What was that thing we did where we could pull the full row and assign it to var?

#Input that info into the sentence: The element with atomic number <atomic_number>  is <name> 
#(<symbol>) with a mass of <atomic_mass> amu. <name> has a melting point of <melting_point>
#celsius and a boiling point of <boiling point> celsius.

fi



