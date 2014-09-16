% third(L,X) is true if X is the third element in L.
third([_,_,X|_], X).

% del3(L,L2) is true if L2 is identical to L, but with X deleted.
del3([A,B,X|C], [A,B|C]).

% isDuped(L) is true if L is a list of pairs of equivalent values.
isDuped(L) :-
  L=[].
isDuped(L) :-
  L=[X,X|Y],
  isDuped(Y).

% evenSize(L) is true if L is a list of even size/length.
evenSize(L) :-
  L=[].
evenSize(L) :-
  L=[_,_|X],
  evenSize(X).
