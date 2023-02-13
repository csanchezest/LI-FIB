% Ex. 3

programa(L) :- append([[begin],Ins,[end]],L), instrucciones(Ins), write("yes"), nl, !.
programa(_) :- write("no"), nl, fail.

instrucciones(L) :- instruccion(L).
instrucciones(L) :- append([Ins,[;],Inss], L), instruccion(Ins), instrucciones(Inss).

instruccion(L) :- append([[V0],[=],[V1],[+],[V2]], L), variable(V0), variable(V1), variable(V2).
instruccion(L) :- append([[if],[V0],[=],[V1],[then],Ins1,[else],Ins2,[endif]], L), variable(V0), variable(V1), instrucciones(Ins1), instrucciones(Ins2).

variable(x).
variable(y).
variable(z).
