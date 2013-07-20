-module(hrtree).
-export([
    emptyRectangle/0,
    isRectangle/1,
    overlapped/2,
    newPoint/2,
    centroid/1
    ]).

-export([
    aRectangle/0]).

% LHV = Largest Hilbert Value
% MBR = Minimum Bounding Rectangle

-record(
    rect, {
        tl,
        bl,
        br,
        tr
    }).

-record(
    point, {
        x,
        y
    }).

newRect(X, Y, Z, N) ->
    #rect {
        tl = X,
        bl = Y,
        br = Z,
        tr = N}.

newPoint(X, Y) ->
    #point {
        x = X,
        y = Y
    }.

emptyRectangle() ->
    newRect({0,0},{0,0},{0,0},{0,0}).

% isRectangle and not a Point
isRectangle(R) ->
    (element(2, R#rect.tl) > element(2, R#rect.bl)) and
    (element(2, R#rect.tr) > element(2, R#rect.br)) and
    (element(1, R#rect.bl) < element(1, R#rect.br)) and
    (element(1, R#rect.tl) < element(1, R#rect.tr)) and
    (element(2, R#rect.bl) == element(2, R#rect.br)) and
    (element(2, R#rect.tl) == element(2, R#rect.tr)) and
    (element(1, R#rect.bl) == element(1, R#rect.tl)) and
    (element(1, R#rect.br) == element(1, R#rect.tr)).

% if two rectangles overlap, return true
overlapped(Ra, Rb) ->
    not ((element(1, Ra#rect.tl) > element(1, Rb#rect.br)) or
        (element(1, Ra#rect.br) < element(1, Rb#rect.tl)) or
        (element(2, Ra#rect.tl) < element(2, Rb#rect.br)) or
        (element(2, Ra#rect.br) > element(2, Rb#rect.tl))).


% Use of div here means integer division.
% Is that what we want? ie: are we considering the
% hilbert curve to be integers on a dxd grid?
centroid(R) ->
    X = (element(1, R#rect.tl) + element(1, R#rect.br)) div 2,
    Y = (element(2, R#rect.tl) + element(2, R#rect.br)) div 2,
    newPoint(X,Y).



% Can Delete
aRectangle() ->
    newRect({0,1},{0,0},{1,0},{1,1}).




