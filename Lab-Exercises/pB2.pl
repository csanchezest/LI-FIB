% Problema B

% B.2
% [ missioner , canibal , barca]
main:-  EstadoInicial = [[0,0,0], [3,3,1]], EstadoFinal = [[3,3,1], [0,0,0]],
        between(1,1000,CosteMax), % Buscamos solución de coste 0; si no, de 1, etc.
        camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
        reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
        CosteMax>0,
        unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
        \+member( EstadoSiguiente, CaminoHastaAhora ),
        CosteMax1 is CosteMax-CostePaso,
        camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).  
        
unPaso(1, [[X,Y,0], [M,N,1]], [[Z,Y,1], [O,N,0]]) :- O is M-1, Z is X+1, (Z >= Y | Z is 0 | Y is 0), (O >= N | O is 0 | N is 0). % Moure un missioner de dreta a esquerra
unPaso(1, [[X,Y,1], [M,N,0]], [[Z,Y,0], [O,N,1]]) :- O is M+1, Z is X-1, (Z >= Y | Z is 0 | Y is 0), (O >= N | O is 0 | N is 0). % Moure un missioner d'esquerra a dreta

unPaso(1, [[X,Y,0], [M,N,1]], [[X,T,1], [M,P,0]]) :- P is N-1, T is Y+1, (T =< X | T is 0 | X is 0), (P =< M | P is 0 | M is 0). % Moure un canibal de dreta a esquerra
unPaso(1, [[X,Y,1], [M,N,0]], [[X,T,0], [M,P,1]]) :- P is N+1, T is Y-1, (T =< X | T is 0 | X is 0), (P =< M | P is 0 | M is 0). % Moure un canibal d'esquerra a dreta

unPaso(1, [[X,Y,0], [M,N,1]], [[Z,T,1], [O,P,0]]) :- P is N-1, O is M-1, T is Y+1, Z is X+1, (Z >= T | Z is 0 | T is 0), (O >= P | O is 0 | P is 0). % Moure un missioner i un canibal de dreta a esquerra
unPaso(1, [[X,Y,1], [M,N,0]], [[Z,T,0], [O,P,1]]) :- P is N+1, O is M+1, T is Y-1, Z is X-1, (Z >= T | Z is 0 | T is 0), (O >= P | O is 0 | P is 0). % Moure un missioner i un canibal d'esquerra a dreta

unPaso(1, [[X,Y,0], [M,N,1]], [[Z,Y,1], [O,N,0]]) :- O is M-2, Z is X+2, (Z >= Y | Z is 0 | Y is 0), (O >= N | O is 0 | N is 0).% Moure dos missioners de dreta a esquerra
unPaso(1, [[X,Y,1], [M,N,0]], [[Z,Y,0], [O,N,1]]) :- O is M+2, Z is X-2, (Z >= Y | Z is 0 | Y is 0), (O >= N | O is 0 | N is 0).% Moure dos missioners d'esquerra a dreta

unPaso(1, [[X,Y,0], [M,N,1]], [[X,T,1], [M,P,0]]) :- P is N-2, T is Y+2, (T =< X | T is 0 | X is 0), (P =< M | P is 0 | M is 0). % Moure dos canibals de dreta a esquerra
unPaso(1, [[X,Y,1], [M,N,0]], [[X,T,0], [M,P,1]]) :- P is N+2, T is Y-2, (T =< X | T is 0 | X is 0), (P =< M | P is 0 | M is 0). % Moure dos canibals d'esquerra a dreta
