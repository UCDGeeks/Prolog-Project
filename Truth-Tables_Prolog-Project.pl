% Team D2Real

% Create operators.
:- operation(1000,inf,'and').
:- operation(1000,inf,'or').
:- operation(900,una,'not').

% Changes the truth assignments by doing a binary addition with 1
next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).


% Reverse a list
reverse([],[]).
reverse([P],[P]).
reverse(M,N) :- reverse(M,[],N).
reverse([],R,R).
reverse([P|T],S,L) :- reverse(T,[P|S],L).


% Create Boolian Values for and, or, & not
bool_not(0,1).
bool_not(1,0).
bool_and(0,0,0).
bool_and(1,0,0).
bool_and(1,1,1).
bool_and(0,1,0).
bool_or(0,0,0).
bool_or(1,0,1).
bool_or(1,0,1).
bool_or(1,1,1).
