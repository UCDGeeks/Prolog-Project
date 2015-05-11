% ___Team D2Real(02) NSBM-CS Batch.04___

%defining infix and unary operators declaration.
:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

%Extracting the variables from the boolean expression (from the query).
operands(B,C,C)	  :- member(B,[0,1]),!.
operands(X,A,Out) :- atom(X), (member(X,A) -> Out=A ; Out=[X|A]).
operands(X and Y,A,Out) :- operands(X,A,Temp),operands(Y,Temp,Out).
operands(X or Y,A,Out)  :- operands(X,A,Temp),operands(Y,Temp,Out).
operands(not X,A,Out)	:- operands(X,A,Out).

%Reversing results of operands.
rev([],[]).
rev([A|B],R) :- rev(B,C),append(C,[A],R).

%Generate the first assignment to variables.
initial_assignment([],[]).
initial_assignment([_X|R],[0|S]) :- initial_assignment(R,S).

%truth assignments with binary additions.
next([0|R] , [1|R]).
next([1|R] , [0|S]) :- next(R,S).

%Generate the other occurances for the variables.
successor(A,S) :- reverse(A,R),
		  next(R,N),
		  reverse(N,S).

%truth value definitions.
eval_exp(N,_,_,N) :- member(N,[0,1]).
eval_exp(X,Vars,A,Val) :- atom(X),
			  lookup(X,Vars,A,Val).
eval_exp(X and Y, Vars,A,Val) :- eval_exp(X,Vars,A,VX),
				 eval_exp(Y,Vars,A,VY),
				 boole_and(VX,VY,Val).

eval_exp(X or Y, Vars,A,Val) :- eval_exp(X,Vars,A,VX),
				 eval_exp(Y,Vars,A,VY),
				 boole_or(VX,VY,Val).

eval_exp(not X, Vars,A,Val) :- eval_exp(X,Vars,A,VX),
				   boole_not(VX,Val).

%Associate positions.
lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).

% Truth table Generating
tt(E) :- operands(E,[],V),
	 reverse(V,Vars),
	 initial_assignment(Vars,A),
	 write('Developed By D2Real'),
	 write('   '),write('Vars'),write('   '),write(E),nl,
	 write('***************************************'), nl,
	 write_line(E,Vars,A),
	 write('***************************************'), nl.

%Generate the next instance for truth table recursively.
write_line(E,Vars,A) :- write('  '), write(A), write('    '),
			eval_exp(E,Vars,A,V), write(V), nl,
			(successor(A,N) -> write_line(E,Vars,N) ; true).

%definitions.
boole_and(0,0,0).
boole_and(0,1,0).
boole_and(1,0,0).
boole_and(1,1,1).
boole_or(0,0,0).
boole_or(0,1,1).
boole_or(1,0,1).
boole_or(1,1,1).
boole_not(0,1).
boole_not(1,0).

% How to use:
% tt(x or (not y  and z)).
