% Problema A
solucio(L) :- L = [ [1,_,_,_,_,_], [2,_,_,_,_,_], [3,_,_,_,_,_], [4,_,_,_,_,_], [5,_,_,_,_,_] ], 
            member( [_,roja,_,_,_,peruano], L),       % El que vive en la casa roja es de Peru
            member( [_,_,_,perro,_,frances], L),    % Al frances le gusta el perro
            member( [_,_,pintor,_,_,japones], L),   % El pintor es japones
            member( [_,_,_,_,ron,chino], L),        % Al chino le gusta el ron
            member( [1,_,_,_,_,hungaro], L),        % El hungaro vive en la primera casa
            member( [_,verde,_,_,conac,_], L),      % Al de la casa verde le gusta el conac
            between(1,5,I), J is I-1, between(1,5,J), member( [I,blanca,_,_,_,_], L), member( [J,verde,_,_,_,_], L), % La casa verde esta justo a la izquierda de la blanca
            member( [_,_,escultor,caracoles,_,_], L), % El escultor cria caracoles
            member( [_,amarilla,actor,_,_,_], L),      % El de la casa amarilla es actor
            member( [3,_,_,_,cava,_], L),              % El de la tercera casa bebe cava
            actorHorseRelation(L),                  % El que vive al lado del actor tiene un caballo
            hungarianNextToBlueHouse(L),            % El hungaro vive al lado de la casa azul
            member( [_,_,notario,_,whisky,_], L),   % Al notario la gusta el whisky
            medicNextToSquirrel(L),                 % El que vive al lado del medico tiene un ardilla
            displaySol(L), nl, fail.
%   NumCasa - ColorCasa - Profesion - Animal - Bebida - Nacionalidad

% OR:  (J is I-1 | J is I+1)
actorHorseRelation(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,_,actor,_,_,_], L), member( [J,_,_,caballo,_,_], L). 
actorHorseRelation(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,_,_,caballo,_,_], L), member( [J,_,actor,_,_,_], L). 

hungarianNextToBlueHouse(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,azul,_,_,_,_], L), member( [J,_,_,_,_,hungaro], L).
hungarianNextToBlueHouse(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,_,_,_,_,hungaro], L), member( [J,azul,_,_,_,_], L).

medicNextToSquirrel(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,_,medico,_,_,_], L), member( [J,_,_,ardilla,_,_], L).
medicNextToSquirrel(L) :- between(1,5,I), J is I-1, between(1,5,J), member( [I,_,_,ardilla,_,_], L), member( [J,_,medico,_,_,_], L).

displaySol(L) :- member(P,L), write(P), nl, fail.
displaySol(_).
