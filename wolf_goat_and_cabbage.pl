% A Prolog program for solving the classic wolf, goat, and cabbage problem,
% often known by other names, such as the fox, goose, and bag of beans puzzle
% (http://en.wikipedia.org/wiki/Fox,_goose_and_bag_of_beans_puzzle).

change(e,w).
change(w,e).

move([X,X,Goat,Cabbage],    wolf,    [Y,Y,Goat,Cabbage])    :- change(X,Y).
move([X,Wolf,X,Cabbage],    goat,    [Y,Wolf,Y,Cabbage])    :- change(X,Y).
move([X,Wolf,Goat,X],       cabbage, [Y,Wolf,Goat,Y])       :- change(X,Y).
move([X,Wolf,Goat,Cabbage], nothing, [Y,Wolf,Goat,Cabbage]) :- change(X,Y).

oneEq(X,X,_).
oneEq(X,_,X).

safe([Man,Wolf,Goat,Cabbage]) :-
  oneEq(Man,Goat,Wolf),
  oneEq(Man,Goat,Cabbage).

solution([e,e,e,e],[]).
solution(Config,[Move|Rest]) :-
  move(Config,Move,NextConfig),
  safe(NextConfig),
  solution(NextConfig,Rest).
