#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
ensure_team_inserted () {
  local TEAM_NAME=$1
  local TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM_NAME'")"
  if [[ -z $TEAM_ID ]]
  then
    INSERT_TEAM_RESULT="$($PSQL "INSERT INTO teams(name) VALUES ('$TEAM_NAME')")"
    if [[ INSERT_TEAM_RESULT=="INSERT 0 1" ]]
    then
      TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM_NAME'")"
    fi
  fi
  echo $TEAM_ID
}

$PSQL "truncate games,teams"
cat games.csv | while IFS=, read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]] 
  then
    WINNER_ID=$(ensure_team_inserted "$WINNER")
    OPPONENT_ID=$(ensure_team_inserted "$OPPONENT")
    INSERT_GAME_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS
    fi
  fi
done

