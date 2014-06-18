%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 6 2014 2:44
%%%-------------------------------------------------------------------
-module(geometry).
-author("ksomemo").

%% API
-export([area/1, functionName/1]).
area({rectangle, Width, Ht}) -> Width * Ht;
%% 同じアリティのときは、セミコロンで続ける
area({circle, R})            -> 3.14159 * R * R.
%% 最後の定義になるので式と同様にピリオドで終わる

functionName(X) when X == 1 -> true;
functionName(X) -> false.
