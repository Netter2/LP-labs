:- ['three.pl'].
:- encoding(utf8).

mid_stud(S,Z) :- student(_, S, [grade(_, A), grade(_, B), grade(_, C), grade(_, D), grade(_, E), grade(_, F)]), Z is (A + B + C + D + E + F) / 6.
pass(S) :- student(_,S,A), not(member(grade(_, 2),A)).

npass(P,X) :- student(_, X, A), member(grade(P, B), A), B = 2.
npass(Y,X) :- subject(P, Y), npass(P, X).
all_npass(P,N) :- findall(X, npass(P, X), L), length(L, N).

all(G, L) :- findall(F, student(G, F, _), L).
maxp([X], X, M) :- mid_stud(X, M).
maxp([X|T], Z, M) :- mid_stud(X, N), maxp(T,Y,K), (N > K -> M = N, Z = X; M = K, Z = Y).
all_grop(G,F) :- all(G,L),  findall(X, maxp(L,X,_),F).
