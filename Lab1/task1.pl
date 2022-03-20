llength([], 0).
llength([_|TAIL], N) :- llength(TAIL, K), N is K + 1.

lmember([], _) :- false.
lmember([HEAD|TAIL],M) :- HEAD = M; lmember(TAIL, M).

lappend([], Y, Y).
lappend([XHEAD|XTAIL], Y, [XHEAD|Z]) :- lappend(XTAIL, Y, Z).

lremove(X, [X|TAIL], TAIL).
lremove(X, [Y|TAIL], [Y|TAIL1]) :- lremove(X, TAIL, TAIL1).

lpermute([],[]).
lpermute(L, [X|TAIL]) :- remove(X, L, R), lpermute(R, TAIL).
 
lsublist(S, L) :- lappend(_, X, L), lappend(S, _, X).

lerase(1, [_|TAIL], TAIL). 
lerase(N, [HEAD|TAIL], [HEAD|TAIL1]) :- N1 is N - 1, lerase(N1, TAIL, TAIL1).

lsum([], A, A).
lsum(A, [], A).
lsum([A|X],[B|Y],[C|Z]) :- sum(X,Y,Z), C is A + B, !.

example(A, L, B):-llength(A, L), lerase(L, A, B), !.
