third([_,_,X|_], X).

del3([A,B,X|C], [A,B|C]).

isDuped(Y) :-
  Y=[].
isDuped(Y) :-
  Y=[X,X].
isDuped(Y) :-
  Y=[X,X|Z],
  isDuped(Z).

evenSize(X) :-
  X=[].
evenSize(X) :-
  X=[_,_|Z],
  evenSize(Z).
