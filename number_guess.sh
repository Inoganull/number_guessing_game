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
