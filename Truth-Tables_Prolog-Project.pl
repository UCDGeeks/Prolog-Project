% Team D2Real

% Create operators.
:- operation(1000,inf,'and').
:- operation(1000,inf,'or').
:- operation(900,una,'not').

% Extract the variables from the boolean expression.
find_vars(N,V,V) :- member(N,[0,1]),!.    /* Boolean constants in expression */
find_vars(X,Vin,Vout) :- atom(X),
                         (member(X,Vin) -> Vout = Vin ;   /* already have  */
                            Vout = [X|Vin]).              /* include       */
find_vars(X and Y,Vin,Vout) :- find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(X or Y,Vin,Vout) :-  find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(not X,Vin,Vout) :-   find_vars(X,Vin,Vout).

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
