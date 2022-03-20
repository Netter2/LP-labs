:- encoding(utf8).

decompose([H|T], X) :- 
    work(H ,T, X).

work(H, T, X) :-
    append(L1, [HL2, _|L2], T),
    HL2 = ',',
    (
        analysis(H, L1, X);
        analysis(H, L2, X)
    ).

analysis(H, [XH1, XH2|XT], Ans) :-
    (
        (
            XH1 = 'любит',
            deconst([XH2|XT], A),
            Ans = likes(H, A)
            
        );
        (
            XH1 = 'не',
            XH2 = 'любит',
            deconst(XT, A),
            Ans = not_likes(H, A)
        )
    ).

deconst(['.'], _) :- fail.
deconst([], _) :- fail.
deconst([H|T], Ans) :-
    not(H = 'и'),
    Ans = H;
    deconst(T, Ans).