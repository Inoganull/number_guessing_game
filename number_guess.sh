#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Prompt for username
echo "Enter your username:"
read USERNAME

# Get user from database
USER_DATA=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")

# Check if new user
if [[ -z $USER_DATA ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, NULL)"
else
  IFS="|" read DB_USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_DATA"
  echo "Welcome back, $DB_UERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Generate random number
SERCRET=$(( RANDOM % 1000 + 1 ))
TRIES=0

# Strat guessing
echo "Guess the secret number between 1 and 1000:"
while true; do
  read GUESS
  ((TRIES++))

  if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  if (( GUESS == SECRET )); then
    echo "You guessed it in $TRIES tries. The secret number was $SECRET. Nice job!"
    break
  elif (( GUESS < SECRET )); then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi

done

