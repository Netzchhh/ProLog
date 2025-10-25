my_length([], 0).
my_length([_|T], N) :- my_length(T, N1), N is N1 + 1.

my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

my_append([], L, L).
my_append([H|T], L, [H|R]) :- my_append(T, L, R).

my_remove(X, [X|T], T).
my_remove(X, [H|T], [H|R]) :- my_remove(X, T, R).

my_permute([], []).
my_permute(L, [H|T]) :- my_remove(H, L, R), my_permute(R, T).

my_sublist(S, L) :- my_append(_, T, L), my_append(S, _, T).

% Реализация пункта 4 со стандартными предикатами.
remove_three_std(List, Result) :-
    length(Prefix, 3),
    append(Prefix, Result, List),
    !.
%Когда список состоит из 3 элементов и менее.
remove_three_std(_, []).

% Реализация пункта 4 без стандартных предикатов.
%
remove_three_rec_helper(0, List, List).
remove_three_rec_helper(N, [_|Tail], Result) :-
    N > 0,
    N1 is N - 1,
    remove_three_rec_helper(N1, Tail, Result).
%Когда список состоит из 3 элементов и менее.
remove_three_rec_helper(_, [], []).

remove_three_rec(List, Result) :-
    remove_three_rec_helper(3, List, Result).
% Обработка пустого списка на любом шаге.
remove_three_rec_helper(_, [], []).

% Основной предикат для вызова.
remove_three_rec(List, Result) :-
    remove_three_rec_helper(3, List, Result).

% Реализация пункта 5 со стандартными предикатами.
multiply(A, B, R) :-
    R is A * B.

product_std(List, Product) :-
    foldl(multiply, List, 1, Product).

% Реализация пункта 5 без стандартных предикатов.
product_rec([], 1).
product_rec([Head|Tail], Product) :-
    product_rec(Tail, SubProduct),
    Product is Head * SubProduct.

% Реализация содержательного примера, основанного на 4-5 пунктах.
% Реализация предиката умножения элементов списка, не умножая первые 3 из них.
product_after_three(List, Product) :-
    remove_three_std(List, SubList),
    product_rec(SubList, Product).
