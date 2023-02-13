% A matrix which contains zeroes and ones gets "x-rayed" vertically and
% horizontally, giving the total number of ones in each row and column.
% The problem is to reconstruct the contents of the matrix from this
% information. Sample run:
%
%	?- p.
%	    0 0 7 1 6 3 4 5 2 7 0 0
%	 0                         
%	 0                         
%	 8      * * * * * * * *    
%	 2      *             *    
%	 6      *   * * * *   *    
%	 4      *   *     *   *    
%	 5      *   *   * *   *    
%	 3      *   *         *    
%	 7      *   * * * * * *    
%	 0                         
%	 0                         
%	

:- use_module(library(clpfd)).

ejemplo1( [0,0,8,2,6,4,5,3,7,0,0], [0,0,7,1,6,3,4,5,2,7,0,0] ).
ejemplo2( [10,4,8,5,6], [5,3,4,0,5,0,5,2,2,0,1,5,1] ).
ejemplo3( [11,5,4], [3,2,3,1,1,1,1,2,3,2,1] ).

declareConstraints([], []).
declareConstraints([X|L], [Y|Lsum]) :- sum(X,#=,Y), declareConstraints(L,Lsum).

p:-	ejemplo3(RowSums,ColSums),
	length(RowSums,NumRows),
	length(ColSums,NumCols),
	NVars is NumRows*NumCols,
	listVars(NVars,L),  % generate a list of Prolog vars (their names do not matter)
	% 1 domini
	L ins 0..1,
	matrixByRows(L,NumCols,MatrixByRows),
	% transposada (li passes la matriu per files i et retorna matriu per columnes)
	transpose(MatrixByRows, MatrixByCols),
	% 2 declaracio de constraints
	declareConstraints(MatrixByRows, RowSums),
	declareConstraints(MatrixByCols, ColSums),
    % 3 labeling (per cada fila, la suma ha de ser igual a RowSums[i])
    label(L),
	pretty_print(RowSums,ColSums,MatrixByRows).

listVars(N,L) :- length(L,N).

matrixByRows([],_,[]).
matrixByRows(L, N, NMatrix) :- take(N,L,X), drop(N,L,Lp), matrixByRows(Lp,N,Matrix), append([[X],Matrix],NMatrix).

drop(N,L,X) :- length(Y,N), append(Y,X,L).

take(N,L,X) :- length(X,N), append(X,_,L).

%take(_,0,[]) :- !.
%take([X|_],1,[X]).
%take([X|L],N,[X|Lp]) :- N>=0, M is N-1, take(L,M,Lp).

pretty_print(_,ColSums,_):- write('     '), member(S,ColSums), writef('%2r ',[S]), fail.
pretty_print(RowSums,_,M):- nl,nth1(N,M,Row), nth1(N,RowSums,S), nl, writef('%3r   ',[S]), member(B,Row), wbit(B), fail.
pretty_print(_,_,_):- nl.
wbit(1):- write('*  '),!.
wbit(0):- write('   '),!.
