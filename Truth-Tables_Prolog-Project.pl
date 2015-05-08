% ___Team D2Real(02) NSBM-CS Batch.04___

% Create operators. 'inf'=infix, 'una'=unary
:- op(1000,inf,'and').
:- op(1000,inf,'or').
:- op(900,una,'not').

% Variables Extract from the boolean expression.
find_vars(N,V,V) :- member(N,[0,1]),!.
find_vars(X,Vin,Vout) :- atom(X),
                         (member(X,Vin) -> Vout = Vin ;
			   Vout = [X|Vin]).
find_vars(X and Y,Vin,Vout) :- find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(X or Y,Vin,Vout) :-  find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(not X,Vin,Vout) :-   find_vars(X,Vin,Vout).

%Find the initial assignments of variables
initial_assignment1([],[]).
initial_assignmet1([_X|R],[0|S]) :- initial_assignment1(R,S).

% truth assignments changes by binary addition with 1
next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).

% Reverse a list
reverse([],[]).
reverse([P],[P]).
reverse(A,B) :- reverse(A,[],B).
reverse([],R,R).
reverse([P|T],S,L) :- reverse(T,[P|S],L).

% The next set of truth table values
successor(A,S) :- reverse(A,R),
                  next(R,N),
                  reverse(N,S).

% Create Boolean Values for and, or, & not
boolean_and(0,0,0).
boolean_and(0,1,0).
boolean_and(1,0,0).
boolean_and(1,1,1).
boolean_or(0,0,0).
boolean_or(0,1,1).
boolean_or(1,0,1).
boolean_or(1,1,1).
boolean_not(0,1).
boolean_not(1,0).

% Truth value returns for Passed expresion
truth_value(N,_,_,N) :- member(N,[0,1]).
truth_value(X,Vars,A,Val) :- atom(X),
                             lookup(X,Vars,A,Val).
truth_value(X and Y,Vars,A,Val) :- truth_value(X,Vars,A,VX),
                                   truth_value(Y,Vars,A,VY),
                                   boolean_and(VX,VY,Val).
truth_value(X or Y,Vars,A,Val) :-  truth_value(X,Vars,A,VX),
                                   truth_value(Y,Vars,A,VY),
                                   boolean_or(VX,VY,Val).
truth_value(not X,Vars,A,Val) :-   truth_value(X,Vars,A,VX),
                                   boolean_not(VX,Val).

% List of values and List of keys Lists The last parameter as the output parameters.
lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).

% Truth table Generating 
tt(E) :- find_vars(E,[],V),
         reverse(V,Vars),
         initial_assign(Vars,A),
         write('  '), write(Vars), write('    '), write(E), nl,
         write('-----------------------------------------'), nl,
         write_row(E,Vars,A),
         write('-----------------------------------------'), nl.

% print things
write_row(E,Vars,A) :- write('  '), write(A), write('        '),
                       truth_value(E,Vars,A,V), write(V), nl,
                       (successor(A,N) -> write_row(E,Vars,N) ; true).


% How to use:
% tt(x or (not y  and z)).
