% Team D2Real

% Create operators.
:- operation(1000,inf,'and').
:- operation(1000,inf,'or').
:- operation(900,una,'not').

% Create Boolian Values for and, or, & not
bool_not(0,1).
bool_not (1,0).
bool_or (0,1).
bool_or (1,0).
bool_and (0,1).
bool_and (1,0).
