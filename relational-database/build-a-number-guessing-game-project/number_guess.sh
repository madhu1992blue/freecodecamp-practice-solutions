#!/bin/bash
GENERATED_RANDOM=$((RANDOM % 1000 + 1))
echo "Enter your username:"
read USERNAME

PSQL="psql -X -U freecodecamp --dbname number_guess --no-align --tuples-only -c"
USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")
if [[ -z "$USER_ID" ]]
then
  INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  GAMES_SUMMARY=$($PSQL "SELECT count(*), min(num_guesses) FROM games RIGHT JOIN users USING(user_id) WHERE user_id=$USER_ID and num_guesses is not NULL and num_guesses != 0")
  IFS="|" read GAMES_PLAYED BEST_GAME <<< $(echo $GAMES_SUMMARY)
  if [[ -z $BEST_GAME ]]
  then
    BEST_GAME=0
  fi
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

NUM_GUESSES=0
echo "Guess the secret number between 1 and 1000:"
until [[ $GUESS == "$GENERATED_RANDOM" ]]
do
  read GUESS
  NUM_GUESSES=$(( NUM_GUESSES+1 ))
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    if (( GUESS < GENERATED_RANDOM ))
    then
      echo "It's higher than that, guess again:"
    elif (( GUESS > GENERATED_RANDOM ))
    then
      echo "It's lower than that, guess again:"
    else
      echo "You guessed it in $NUM_GUESSES tries. The secret number was $GUESS. Nice job!"
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, num_guesses) VALUES ($USER_ID, $NUM_GUESSES)")
    fi
  else
    echo "That is not an integer, guess again:"
  fi
done