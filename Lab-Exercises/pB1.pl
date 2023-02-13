% Problema B

% B.1
main:-  EstadoInicial = [0,0], EstadoFinal = [0,4],
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

unPaso(1, [N,M], [5,M]) :- N < 5.   % Omplir cub5
unPaso(1, [N,M], [N,8]) :- M < 8.   % Omplir cub8
unPaso(1, [N,M], [0,M]) :- N > 0.   % Buidar cub5
unPaso(1, [N,M], [N,0]) :- M > 0.   % Buidar cub8

unPaso(1, [Y,X], [0,M]) :- M is X+Y, M =< 8.   % Traspassar aigua de cub5 a cub8 fins buidar-lo
unPaso(1, [Y,X], [N,0]) :- N is Y+X, N =< 5.   % Traspassar aigua de cub8 a cub5 fins buidar-lo

unPaso(1, [Y,X], [N,8]) :- between(0,5,N), 8 is X+Y-N. % Traspassar aigua de cub5 a cub8 sense acabar de buidar-se
unPaso(1, [Y,X], [5,M]) :- between(0,8,M), 5 is X+Y-M. % Traspassar aigua de cub8 a cub5 sense acabar de buidar-se
