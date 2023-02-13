:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

% RESULT
%[a,c,d,j,n,s]
%[b,f,i,o,u,w]
%[e,g,l,p,t,y]
%[h,k,m,r,v,x]

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    
    % 1. Domini:
    append([D1,D2,D3,D4],Vars),
    %listVars(Vars,L),      LISTVARS et genera una llista en base a una mida donada: listVars(mida,llista)
    Vars ins 1..24,
    
    % 2. Constraints
    all_distinct(Vars),
    sorted(D1),
    sorted(D2),
    sorted(D3),
    sorted(D4),
    computeIncompatiblePairs(L),
    makeConstraint(L,D1),
    makeConstraint(L,D2),
    makeConstraint(L,D3),
    makeConstraint(L,D4),
    
    % 3. Labeling
    
    labeling([min],Vars),
    
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
sorted([_]).
sorted([A,B|L]) :- A #< B, sorted([B|L]).

computeIncompatiblePairs(L) :- findall(N-M, (inSameWord(N,M), N<M), L).

inSameWord(N,M) :- word(W), num(X,N), num(Y,M), member(X,W), member(Y,W).

makeConstraint(_,[_]).
makeConstraint(L,[Z|D]) :- pairNotInDice(L,Z,D), makeConstraint(L,D).

pairNotInDice(_,_,[]).
pairNotInDice(L,X,[Y|D]) :- checkPairs(L,X,Y), pairNotInDice(L,X,D).

checkPairs([],_,_).
checkPairs([A-B|L], X, Y) :-  X #\= A #\/ Y #\=B, checkPairs(L,X,Y).
    
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.
