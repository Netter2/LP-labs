name(X) :- (X = leon; X = mich; X = nick; X = oleg; X = petr).
surn(X) :- (X = atar; X = bart; X = klen; X = dani; X = ivan).
pers(N, S) :- name(N), surn(S).

less(leon, mich).
less(leon, nick).
less(leon, oleg).
less(leon, petr).
less(mich, nick).
less(mich, oleg).
less(mich, petr).
less(nick, oleg).
less(nick, petr).
less(oleg, petr).

uniq([]).
uniq([H | T]) :- 
   member(H, T), !, fail;
   uniq(T).

rela([]) :- fail.
rela([[N, S], [N1, S1]]) :- 
   pers(N, S), pers(N1, S1), 
   uniq([N, N1]),
   uniq([S, S1]).
rela([[N, S], [N1, S1], [N2, S2]]) :- 
   pers(N, S), pers(N1, S1), pers(N2, S2),
   uniq([N, N1, N2]), less(N1, N2),
   uniq([S, S1, S2]).
rela([[N, S], [N1, S1], [N2, S2], [N3, S3]]) :- 
   pers(N, S), pers(N1, S1), pers(N2, S2), pers(N3, S3),
   uniq([N, N1, N2, N3]), less(N1, N2), less(N1, N3), less(N2, N3),
   uniq([S, S1, S2, S3]).

z([[_, _]]).
z([[N, S] | T]) :- 
   member([N, AS], T), not(AS = S), !, fail;
   member([AN, S], T), not(AN = N), !, fail;
   z(T).

sol(V, W, X, Y, Z) :- 
   V = [[leon, S1] | T1],
   rela([[leon, S1] | T1]),
   append([[leon, S1]], T1, L1),
   %------------------------------------------------------------------------------1111111
   (
      S1 = bart,
      length(T1, 2);
      not(S1 = bart)
   ),

   length(T1, 1),

   (
      S1 = dani,
      not(member([mich, _], T1));
      not(S1 = dani)
   ),
   
   not(member([mich, dani], T1)),

   (
      S1 = ivan,
      member([nick, _], T1);
      not(S1 = ivan)
   ),
   not(member([nick, ivan], T1)),

   (
      S1 = atar,
      length(T1, 3);
      not(S1 = atar)
   ),
   
   (
      S1 = klen,
      length(T1, 1);
      not(S1 = klen)
   ),
   %------------------------------------------------------------------------------2222222

   W = [[mich, S2] | T2],
   rela([[mich, S2] | T2]),
   append([[mich, S2]], T2, L2),
   append(L1, L2, L6),

   (
      S2 = bart,
      length(T2, 2);
      not(S2 = bart)
   ),

   not(member([_, dani], T2)),

   not(S2 = dani),

   (
      S2 = ivan,
      member([nick, _], T2);
      not(S2 = ivan)
   ),

   not(member([nick, ivan], T2)),

   member([nick, _], T2),
   member([oleg, _], T2),

   (
      S2 = atar,
      length(T2, 3);
      not(S2 = atar)
   ),
   
   (
      S2 = klen,
      length(T2, 1);
      not(S2 = klen)
   ),
   %------------------------------------------------------------------------------3333333
   
   X = [[nick, S3] | T3],
   rela([[nick, S3] | T3]),
   append([[nick, S3]], T3, L3),
   append(L6, L3, L7),

   (
      S3 = bart,
      length(T3, 2);
      not(S3 = bart)
   ),

   (
      S3 = dani,
      not(member([mich, S2], T3));
      not(S3 = dani)
   ),
   not(member([mich, dani], T3)),

   member([_, ivan], T3),
   
   not(S3 = ivan),

   member([mich, S2], T3),

   member([oleg, _], T3),

   (
      S3 = atar,
      length(T3, 3);
      not(S3 = atar)
   ),
   
   (
      S3 = klen,
      length(T3, 1);
      not(S3 = klen)
   ),
   %------------------------------------------------------------------------------4444444

   Y = [[oleg, S4] | T4],
   rela([[oleg, S4] | T4]),
   append([[oleg, S4]], T4, L4),
   append(L7, L4, L8),

   (
      S4 = bart,
      length(T4, 2);
      not(S4 = bart)
   ),

   (
      S4 = dani,
      not(member([mich, S2], T4));
      not(S4 = dani)
   ),
   
   not(member([mich, dani], T4)),

   (
      S4 = ivan,
      member([nick, S3], T4);
      not(S4 = ivan)
   ),
   not(member([nick, ivan], T4)),

   member([mich, S2], T4),

   member([nick, S3], T4),

   (
      S4 = atar,
      length(T4, 3);
      not(S4 = atar)
   ),
   
   (
      S4 = klen,
      length(T4, 1);
      not(S4 = klen)
   ),

   (
      member([petr, S5], T1), member([petr, S5], T2), member([petr, S5], T3), not(member([petr, S5], T4));
      member([petr, S5], T1), member([petr, S5], T2), member([petr, S5], T4), not(member([petr, S5], T3));
      member([petr, S5], T1), member([petr, S5], T3), member([petr, S5], T4), not(member([petr, S5], T2));
      member([petr, S5], T2), member([petr, S5], T3), member([petr, S5], T4), not(member([petr, S5], T1))
   ),


   %------------------------------------------------------------------------------5555555

   Z = [[petr, S5] | T5],
   rela([[petr, S5] | T5]),
   uniq([S1, S2, S3, S4, S5]),
   append([[petr, S5]], T5, L5),
   append(L8, L5, L),
   z(L),

   (
      S5 = bart,
      length(T5, 2);
      not(S5 = bart)
   ),

   length(T5, 3),

   (
      member([leon, S1], T2), not(member([leon, S1], T3)), not(member([leon, S1], T4)), not(member([leon, S1], T5));
      member([leon, S1], T3), not(member([leon, S1], T2)), not(member([leon, S1], T4)), not(member([leon, S1], T5));
      member([leon, S1], T4), not(member([leon, S1], T2)), not(member([leon, S1], T3)), not(member([leon, S1], T5));
      member([leon, S1], T5), not(member([leon, S1], T2)), not(member([leon, S1], T3)), not(member([leon, S1], T4))
   ),

   (
      S5 = dani,
      not(member([mich, S2], T5));
      not(S5 = dani)
   ),

   not(member([mich, dani], T5)),

   (
      S5 = ivan,
      member([nick, S3], T5);
      not(S5 = ivan)
   ),
   not(member([nick, ivan], T5)),

   (
      S5 = atar,
      length(T5, 3);
      not(S5 = atar)
   ),
   
   (
      S5 = klen,
      length(T5, 1);
      not(S5 = klen)
   ).
