/*******************************************************************************
   Filename: adventure.pl

     Author: David C. Drake (https://davidcdrake.com)

Description: "I USED TO BE AN ADVENTURER LIKE YOU": A simple text adventure
             game utilizing the Prolog programming language. Your goal is to
             find the treasure without dying or taking an arrow in the knee.
*******************************************************************************/

/* location descriptions */
description(valley,
  'You are in a valley with a trail stretching out before you.').
description(path,
  'You are on a narrow path with ravines on either side.').
description(cliff,
  'You are teetering on the edge of a cliff.').
description(fork,
  'You are at a fork in the path.').
description(maze(_),
  'You are in a maze of twisty little passages, all alike.').
description(mountaintop,
  'You are on a snowy mountaintop.').

/* report = print the current location's description */
report :-
  at(you,X),
  description(X,Y),
  write(Y),
  nl.

/* connect(X,Dir,Y) = if at X and moving in direction Dir, go to Y */
connect(valley,forward,path).
connect(path,right,cliff).
connect(path,left,cliff).
connect(path,forward,fork).
connect(fork,left,maze(0)).
connect(fork,right,mountaintop).
connect(maze(0),left,maze(1)).
connect(maze(0),right,maze(3)).
connect(maze(1),left,maze(0)).
connect(maze(1),right,maze(2)).
connect(maze(2),left,fork).
connect(maze(2),right,maze(0)).
connect(maze(3),left,maze(0)).
connect(maze(3),right,maze(3)).

/* move(Dir) = move the player in direction Dir, then print a description */
move(Dir) :-
  at(you,Loc),
  connect(Loc,Dir,Next),
  retract(at(you,Loc)),
  assert(at(you,Next)),
  report,
  !.
move(_) :-
  write('That is not a legal move.\n'),
  report.

/* treasure = if found, the player wins */
treasure :-
  at(treasure,Loc),
  at(you,Loc),
  write('You have found the treasure. Congratulations, you win!\n'),
  retract(at(you,Loc)),
  assert(at(you,done)),
  !.
treasure. % Otherwise, nothing happens.

/* archer = if the player and archer are at the same location, game over */
archer :-
  at(archer,Loc),
  at(you,Loc),
  write('You take an arrow in the knee. Your adventuring days are over.\n'),
  retract(at(you,Loc)),
  assert(at(you,done)),
  !.
archer. % Otherwise, nothing happens.

/* cliff = if the player is at the cliff, game over */
cliff :-
  at(you,cliff),
  write('You fall off the edge. Your adventuring days are over.\n'),
  retract(at(you,cliff)),
  assert(at(you,done)),
  !.
cliff. % Otherwise, nothing happens.

/* main = while not done, get moves from the player, check state, repeat */
main :-
  at(you,done),
  !.
main :-
  write('\nNext move: '),
  read(Move),
  nl,
  call(Move),
  treasure,
  archer,
  cliff,
  main.

/* start = starting point for the game */
start :-
  retractall(at(_,_)), % clean up from previous runs
  assert(at(you,valley)),
  assert(at(archer,maze(3))),
  assert(at(treasure,mountaintop)),
  write('\nWelcome to the I USED TO BE AN ADVENTURER LIKE YOU game!\n'),
  write('Legal commands: "left.", "right.", and "forward."\n'),
  write('(Each command must end with a period.)\n\n'),
  report,
  main.

/* additional commands */
forward :- move(forward).
left    :- move(left).
right   :- move(right).
begin   :- start.
play    :- start.
go      :- start.
