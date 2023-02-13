%auxiliar
pert(X,[X|_]). % o bien X es el primero, o bien
pert(X,[_|L]):- pert(X,L). % pertenece a la lista de los demas

%concat([],L,L).
%concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

interseccion([],_,[]).
interseccion([X|L1],L2,[X|L3]):-
	pert(X,L2),!,
	interseccion(L1,L2,L3).
interseccion([_|L1],L2,   L3 ):-
	interseccion(L1,L2,L3).

subcjto([],[]). %subcjto(L,S) es: "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

repeated_perm([], _).
repeated_perm([X|L], R):- member(X, R), perms_R(L, R).

print_list([]) :- write(' ').
print_list([X|L]) :- write(X), print_list(L).

der(X, X, 1):-!.
der(C, _, 0) :- number(C).
der(A+B, X, A1+B1) :- der(A, X, A1), der(B, X, B1).
der(A-B, X, A1-B1) :- der(A, X, A1), der(B, X, B1).
der(A*B, X, A*B1+B*A1) :- der(A, X, A1), der(B, X, B1).
der(sin(A), X, cos(A)*B) :- der(A, X, B).
der(cos(A), X, -sin(A)*B) :- der(A, X, B).
der(e^A, X, B*e^A) :- der(A, X, B).
der(ln(A), X, B*1/A) :- der(A, X, B).

powa(B,E,R) :- powa(B,E,1,R).
powa(_,0,A,A).
powa(B,E,A,R) :- E > 0, !, E1 is E - 1, A1 is B * A, powa(B,E1,A1,R).
%----------------------------------------------------------------
%   DADOS
escribir([]):- !.
escribir([S|Sol]):- write(S), nl, escribir(Sol).

% D1 gana almenos en 5 de las 9 combinaciones
gana(D1,D2):- findall((X,Y),(member(X,D1),member(Y,D2),X>Y), G), length(G,L), L > 4.


dados:-
    Sol = [R,A,V],
    R = [CR1,CR2,CR3],
    A = [CA1,CA2,CA3],
    V = [CV1,CV2,CV3],
    permutation([1,2,3,4,5,6,7,8,9],[CR1,CR2,CR3,CA1,CA2,CA3,CV1,CV2,CV3]),
    sort(R,R), sort(A,A), sort(V,V),
    CR1 = 1,
    gana(R,A),
    gana(A,V),
    gana(V,R),
    escribir(Sol), 
    nl.

%----------------------------------------------------------------
%1
prod([],1).
prod([X|L],P) :- prod(L,P1), P is P1 * X. 
%2
pescalar([],[],0).
pescalar([X|L1],[Y|L2],P) :- pescalar(L1,L2,P1), P is P1 + X*Y.
%3
inters([],_,[]).
inters([X|L1],L2,[X|L3]) :- member(X,L2), delete(L2,X,L2b), inters(L1,L2b,L3), !.
inters([_|L1],L2,L3) :- inters(L1,L2,L3).

unio([],L,L).
unio([X|L1],L2,L3) :- member(X,L2), !, unio(L1,L2,L3).
unio([X|L1],L2,[X|L3]) :- unio(L1,L2,L3).
%4
concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

last(L,X) :- concat(_,[X],L), !.

reverse([],[]).
reverse(L,[X|R]) :- last(L,X), concat(L1,[X],L), reverse(L1,R), !.
%5
fib(0,0).
fib(1,1).
fib(N,F) :- N>=2, N1 is N-1, N2 is N-2, fib(N2,F2), fib(N1,F1), F is F1 + F2, !.
%Lliço fib: ojo perque sense N>=2, entres en bucle infinit; se li ha de dir que nomes hi pot entrar en una circumstancia donada; a mes a mes no podem cridar la funcio fib sense especificar en una variable concreta el valor que te, es a dir, no podem posar directament N-2, i per tant s'ha d'indicar previament
%6
dados(0,0,[]).
dados(P,N,[X|L]) :- N>0, member(X,[1,2,3,4,5,6]) ,R is P-X, M is N-1, dados(R,M,L).
%7
suma_demas(L) :- select(X,L,S), sum_list(S,X), !.
%suma_demas(L) :- subcjto(L,S), S \= [], member(X,L), not(member(X,S)), sum_list(S,X), !.
%8
suma_ants(L) :- member(X,L), concat(S,_,L), last(S,X), select(X,S,U), sum_list(U,X), !.
%suma_ants(L) :- subcjto(L,S), S \= [], member(X,L), last(S,X), delete(S,X,T), sum_list(T,X), !.
%9
card(L) :- write('['), cards(L), write(']').

cards([]).
cards(L) :- member(X,L), delete(L,X,B), subtract(L,B,A), proper_length(A,R), write([X,R]), cards(B), !.
%card(L) :- member(X,L), delete(L,X,B), subtract(L,B,A), proper_length(A,R), write('['), write(X), write(,), write(R), write(']'), nl, card(B), !.
%card(L) :- clumped(L,X), write(X).
%card(L) :- member(X,L), subcjto(L,A), delete(L,X,B), inters(A,B,[]), proper_length(A,R), write(X), write(-), write(R), write(-), write(A).
%10
esta_ordenada([]) :- write('yes').
esta_ordenada([X|L]) :- min_member(X,[X|L]), esta_ordenada(L), !.
esta_ordenada(_) :- write('no'), !.
%11
ord(L1,L2) :- permutacion(L1,L2), esta_ordenada(L2), !.
%12
%findall (operador)

diccionario(A,N) :- word_comb(A,N,R), print_list(R), fail.

word_comb(_,0,[]) :- !.
word_comb(A,N,[X|R]) :- M is N-1, pert(X,A), word_comb(A,M,R).

%diccionario(_,0) :- write(' ').
%diccionario(A,N) :- N1 is N-1, findall(A, member(X,A), Y), write(Y).

%diccionario(_,0).
%diccionario(A,N) :- subcjto(A,S), permutation(S,T), proper_length(S,N), write(T), write(' '), fail.

%diccionario(A,N) :- member(X,A), M is N-1, write(X), diccionario(A,M).
%diccionario(A,N) :- permutacion(A,S), list_to_set(S, T), subset(U,T), U \= [], write(U), proper_length(U,N), write(T), write(' ').
%13
palindromos(L) :- setof(S,(permutation(L,S), reverse(S,S)), T), write(T), nl.
%14
find_perm :- subcjto([0,1,2,3,4,5,6,7,8,9],X), proper_length(X,8), permutation(X,[S,E,N,D,M,O,R,Y]), A is S+E+N+D, B is M+O+R+E, C is M+O+N+E+Y, C is A+B, !, write([S,E,N,D,M,O,R,Y]).
%15

%16
first([(X,_)|_],X).
inverted((X,Y),(Y,X)).

ok([(_,Y)|L]) :- first(L,Y), ok(L), !.
ok([(_,_)]).

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).
p(L,[Y|P]) :- select(X,L,R), inverted(X,Y), p(R,P).

dom(L) :- p(L,P), ok(P), write(P), nl.
dom( ) :- write('no hay cadena'), nl.
%17
%p:- readclauses(F), sat([],F).
%p:- write('UNSAT'),nl.

%sat(I,[]):- write('IT IS SATISFIABLE. Model: '), write(I),nl,!.
%sat(I,F):- decision lit(F,Lit), % Select unit clause if any; otherwise, an arbitrary one.
%simplif(Lit,F,F1), % Simplifies F. Warning: may fail and cause backtracking
%sat( ... , ... ).
%18

%19
%maq(L,C,M) :- . 

%20

%21
%Quina diferencia hi ha entre pow y pot?
pot(_,0,1) :- !.
pot(B,E,R) :- E > 0, pot(B,E1,R1), E is E1+1, R is R1*B.
pow(_,0,1) :- !.
pow(B,E,R) :- E > 0,!, E1 is E -1, pow(B,E1,R1), R is B * R1.
%LLIÇO: definim abans de la crida, totes aquelles variables que NECESSITEM saber per tal que es calculin be les coses; es defineixen després de la crida les variables "originals"
log(_,1,0) :- !. 
log(B,N,R) :- N>1, N1 is N//B, R1 is R-1, log(B,N1,R1).
%log(_,1,0) :- !. 
%log(B,N,R) :- N>1, N1 is N//B, log(B,N1,R1), R is R1 +1.
%22
                
                
                
                
