% Problema B

% B.3
% [persona , minuts]
main:-  EstadoInicial = [[0,1], [0,2], [0,5], [0,8], 0], EstadoFinal = [[1,1], [1,2], [1,5], [1,8], 1],
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


%unPaso(Max, [[A,1], [B,2], [C,5], [0,8]], [[X,1], [Y,2], [Z,5], [1,8]]) :- 2 is A+B+C, T is X+Y+Z, T >= 1, Max is 8.
%unPaso(Max, [[A,1], [B,2], [0,5], [1,8]], [[X,1], [Y,2], [1,5], [1,8]]) :- 1 is A+B, 1 is X+Y, Max is 5.
%unPaso(Max, [[0,1], [0,2], [1,5], [1,8]], [[1,1], [1,2], [1,5], [1,8]]) :- Max is 2.

unPaso(Max, [[A,1], [B,2], [0,5], [0,8], 0], [[A,1], [B,2], [1,5], [1,8], 1]) :- Max is 8.
unPaso(Max, [[A,1], [0,2], [B,5], [0,8], 0], [[A,1], [1,2], [B,5], [1,8], 1]) :- Max is 8.
unPaso(Max, [[0,1], [A,2], [B,5], [0,8], 0], [[1,1], [A,2], [B,5], [1,8], 1]) :- Max is 8.
unPaso(Max, [[A,1], [0,2], [0,5], [B,8], 0], [[A,1], [1,2], [1,5], [B,8], 1]) :- Max is 5.
unPaso(Max, [[0,1], [A,2], [0,5], [B,8], 0], [[1,1], [A,2], [1,5], [B,8], 1]) :- Max is 5.
unPaso(Max, [[0,1], [0,2], [A,5], [B,8], 0], [[1,1], [1,2], [A,5], [B,8], 1]) :- Max is 2.

unPaso(Max, [[1,1], [A,2], [B,5], [C,8], 1], [[0,1], [A,2], [B,5], [C,8], 0]) :- Max is 1.
unPaso(Max, [[A,1], [1,2], [B,5], [C,8], 1], [[A,1], [0,2], [B,5], [C,8], 0]) :- Max is 2.
unPaso(Max, [[A,1], [B,2], [1,5], [C,8], 1], [[A,1], [B,2], [0,5], [C,8], 0]) :- Max is 5.
unPaso(Max, [[A,1], [B,2], [C,5], [1,8], 1], [[A,1], [B,2], [C,5], [0,8], 0]) :- Max is 8.
