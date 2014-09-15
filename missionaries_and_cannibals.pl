% A Prolog program for solving the classic missionaries and cannibals problem
% (http://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem).
%
% M = Missionaries on the near shore.
% C = Cannibals on the near shore.
% B = Boat location (near or far).

change(near, far).
change(far, near).

valid([M, C, B]) :-
  %write('  valid(['), write(M), write(','), write(C), write(','), write(B),
  %  write('])'), nl,
  valid_num(M),
  valid_num(C),
  valid_boat_location(B).

safe([M, C, _]) :-
  %write('  safe(['), write(M), write(','), write(C), write(',_])'), nl,
  M =:= C.
safe([M, _, _]) :-
  %write('  safe(['), write(M), write(',_,_])'), nl,
  M =:= 3.
safe([M, _, _]) :-
  %write('  safe(['), write(M), write(',_,_])'), nl,
  M =:= 0.

valid_boat_location(near).
valid_boat_location(far).

valid_num(0).
valid_num(1).
valid_num(2).
valid_num(3).

% Here, 'near' and 'far' refer to boat location prior to a move:
valid_num_change(N1, N2, near, Amount) :-
  N1 is N2 + Amount.
valid_num_change(N1, N2, far, Amount) :-
  N1 is N2 - Amount.

move([M1, C, B1], onemissionary, [M2, C, B2]) :-
  %write(' move(['), write(M1), write(','), write(C), write(','), write(B1),
  %  write('],onemissionary,['), write(M2), write(','), write(C), write(','),
  %  write(B2), write('])'), nl,
  change(B1, B2),
  valid_num(M1),
  valid_num(M2),
  valid_num(C),
  valid_num_change(M1, M2, B1, 1).
move([M1, C, B1], twomissionaries, [M2, C, B2]) :-
  %write(' move(['), write(M1), write(','), write(C), write(','), write(B1),
  %  write('],twomissionaries,['), write(M2), write(','), write(C), write(','),
  %  write(B2), write('])'), nl,
  change(B1, B2),
  valid_num(M1),
  valid_num(M2),
  valid_num(C),
  valid_num_change(M1, M2, B1, 2).
move([M, C1, B1], onecannibal, [M, C2, B2]) :-
  %write(' move(['), write(M), write(','), write(C1), write(','), write(B1),
  %  write('],onecannibal,['), write(M), write(','), write(C2), write(','),
  %  write(B2), write('])'), nl,
  change(B1, B2),
  valid_num(M),
  valid_num(C1),
  valid_num(C2),
  valid_num_change(C1, C2, B1, 1).
move([M, C1, B1], twocannibals, [M, C2, B2]) :-
  %write(' move(['), write(M), write(','), write(C1), write(','), write(B1),
  %  write('],twocannibals,['), write(M), write(','), write(C2), write(','),
  %  write(B2), write('])'), nl,
  change(B1, B2),
  valid_num(M),
  valid_num(C1),
  valid_num(C2),
  valid_num_change(C1, C2, B1, 2).
move([M1, C1, B1], oneofeach, [M2, C2, B2]) :-
  %write(' move(['), write(M1), write(','), write(C1), write(','), write(B1),
  %  write('],oneofeach,['), write(M2), write(','), write(C2), write(','),
  %  write(B2), write('])'), nl,
  change(B1, B2),
  valid_num(M1),
  valid_num(M2),
  valid_num(C1),
  valid_num(C2),
  valid_num_change(M1, M2, B1, 1),
  valid_num_change(C1, C2, B1, 1).

solution([0, 0, far], RemainingMoves) :-
  length(RemainingMoves, L),
  L =:= 0.
solution(State1, [Move|RemainingMoves]) :-
  %write('solution(['), write(State1), write(',['), write(Move), write('|'),
  %  write(RemainingMoves), write('])'), nl,
  move(State1, Move, State2),
  valid(State2),
  safe(State2),
  solution(State2, RemainingMoves).

solve(MoveList) :-
  length(MoveList, 11),             % The shortest solution is 11 moves long.
  solution([3, 3, near], MoveList). % [3, 3, near] is the starting state.
  %write('SOLUTION = '), write(MoveList).
