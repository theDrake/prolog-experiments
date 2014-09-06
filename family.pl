/* Family tree data */

parent(shmi,vader).
parent(ruweee,padme).
parent(jobal,padme).
parent(vader,luke).
parent(vader,leia).
parent(padme,luke).
parent(padme,leia).
parent(luke,ben).
parent(mara,ben).
parent(leia,jaina).
parent(leia,jacen).
parent(leia,anakin).
parent(han,jaina).
parent(han,jacen).
parent(han,anakin).

/* Sex data */

male(ruweee).
male(vader).
male(luke).
male(han).
male(ben).
male(jacen).
male(anakin).
female(shmi).
female(jobal).
female(padme).
female(mara).
female(leia).
female(jaina).

/* Family relationships */

mother(X, Y) :-
  parent(X, Y),
  female(X).

father(X, Y) :-
  parent(X, Y),
  male(X).

sister(X, Y) :-
  parent(P, X),
  parent(P, Y),
  female(X),
  not(X=Y).

brother(X, Y) :-
  parent(P, X),
  parent(P, Y),
  male(X),
  not(X=Y).

grandson(X, G) :-
  parent(G, P),
  parent(P, X),
  male(X).

firstCousin(X, Y) :-
  parent(P1, X),
  parent(P2, Y),
  parent(G, P1),
  parent(G, P2),
  not(brother(X, Y)),
  not(sister(X, Y)),
  not(X=Y).

descendent(X, Y) :-
  parent(Y, X).
descendent(X, Y) :-
  parent(Y, Z),
  descendent(X, Z).
