parents('Kirill_Kalugin', 'Aleksey_Kalugin', 'Tatyana_Kalugina').                                                                                                                
parents('Aleksey_Kalugin', 'Valentin_Kalugin', 'Natalia_Kalugina').                                                                                                              
parents('Ekaterina_Kalugina', 'Valentin_Kalugin', 'Natalia_Kalugina').                                                                                                           
parents('Ivan_Ivanovich', 'Valentin_Kalugin', 'Natalia_Kalugina').                                                                                                               
parents('Tatyana_Kalugina', 'Boris_Kalugin', 'Victoria_Kalugina').                                                                                                               
parents('Elena_Petrovich', 'Boris_Kalugin', 'Victoria_Kalugina').                                                                                                                
parents('Egor_Berzin', 'Dmitriy_Berzin', 'Ekaterina_Kalugina').                                                                                                                  
parents('Irina_Berzina', 'Dmitriy_Berzin', 'Ekaterina_Kalugina').                                                                                                                
parents('Oleg_Ivanovich', 'Ivan_Ivanovich', 'Maria_Ivanovich').                                                                                                                  
parents('Anna_Petrovich', 'Petr_Petrovich', 'Elena_Petrovich').

persL1(P) :-
    parents(_, P, _);
    parents(_, _, P).

persL2(P) :-
    parents(P, _, _).

filter([], []).
filter([H | T], R) :- 
    not(member(H, T)),
    R = [H | R1],
    filter(T, R1);
    member(H, T),
    R = R1,
    filter(T, R1).

person(P) :-
    findall(S, persL2(S), L1),
    findall(S1, persL1(S1), L2),
    append(L1, L2, L),
    filter(L, R),
    !,
    member(P, R).


zolovka(R2, R1) :- parents(_, H, R2), parents(H, MH, FH), parents(R1, MH, FH), parents(_, _, R1).

move(P1, P2, FM) :-
    parents(P1, P2, _), FM = child;
    parents(P1, _, P2), FM = child;
    parents(P2, P1, _), FM = father;
    parents(P2, _, P1), FM = mother.

prolong([X|T1], [Y, X|T1], Z, [Z1|Z]) :- 
    move(X, Y, Z1),
    not(member(Y, [X|T1])).

relation(FR, SR, R) :-
    relation1(FR, SR, [], R).

relation1(FR, SR, R1, R2) :- 
    relative(FR, SR, Res), not(member(Res, R1)), !,
    (
        R2 = Res;
        relation1(FR, SR, [Res | R1], R2)
    ).

relative(FR, SR, Res1) :- 
    int(CC, 1, 11),
    rfind([FR], SR, Res1, CC).%,
    %reverse(Res1, Res).

rfind([H|_], H, [], _).
rfind(P, G, R, C) :-
    C > 0,
    prolong(P, P1, R1, R),
    C1 is C - 1,
    rfind(P1, G, R1, C1).

int(A, B, C) :-
    A = B, A < C;
    B1 is B + 1, 
    B1 < C,
    int(A, B1, C).

sibling(R1, R2) :-
    parents(R1, P1, P2),
    parents(R2, P1, P2),
    not(R1 = R2).

children(R2, R1) :-%родитель - ребенок
    parents(R1, _, R2);
    parents(R1, R2, _).

descendants(R1, R2) :-
    children(R1, R3),
    (R3 = R2;
    descendants(R3, R2)).

ancestors(R1, R2) :-
    children(R3, R1),
    (R3 = R2;
    ancestors(R3, R2)).

question(['Who', 'is', R1, 'to', R2,'?'], Ans) :-
    relation(R1, R2, Ans).

question(['How', 'many', T, 'does', R1, 'have', '?'], Ans) :-
    (T = 'siblings',
    findall(R2, sibling(R1, R2), A),
    length(A, Ans));

    (T = 'ancestors',
    findall(R2, ancestors(R1, R2), A),
    length(A, Ans));

    (T = 'children',
    findall(R2, children(R1, R2), A),
    length(A, Ans));

    (T = 'descendants',
    findall(R2, descendants(R1, R2), A),
    length(A, Ans));

    (T = 'zolovkas',
    findall(R2, zolovka(R1, R2), A),
    length(A, Ans)).

question(['Who', 'are', T, 'of', R2,'?'], Ans) :-
    (T = 'siblings',
    sibling(R2, Ans));

    (T = 'ancestors',
    ancestors(R2, Ans));

    (T = 'children',
    children(R2, Ans));

    (T = 'descendants',
    descendants(R2, Ans));

    (T = 'zolovkas',
    zolovka(R2, Ans)).

