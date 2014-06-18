%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 6 2014 22:42
%%%-------------------------------------------------------------------
-module(try_catch_after).
-author("ksomemo").

%% API
-export([
  gen_exception/1
  , demo1/0
  , demo2/0
]).
gen_exception(1) -> return_value;
gen_exception(2) -> throw(thorow_test);
gen_exception(3) -> exit(exit_test);
gen_exception(4) -> {return, tuple};
gen_exception(5) -> error(error_test).

demo1() ->
  [catcher(I) || I <- lists:seq(1, 6)].

catcher(N) ->
  try gen_exception(N) of
    Val ->
      io:format("try:~p.~n", [N]),
      {N, normal, Val}
  catch
    throw:X -> io:format("catch:~p.~n", [N]), {N, caught, th, X};
    exit:X  -> io:format("catch:~p.~n", [N]), {N, caught, ex, X};
    error:X -> io:format("catch:~p.~n", [N]), {N, caught, er, X}
  after
    io:format("after:~p.~n", [N])
  end.

-spec demo2() -> any().
demo2() ->
%%  [{I, catch gen_exception(I)} || I <- lists:seq(1, 6)].
%%  [{I, catch gen_exception(I)} || I <- lists:reverse(lists:seq(1, 6))].
  [{I, catch gen_exception(I)} || I <- [2,2]].

%% 逆順にしても内容は変わらなかったので、errorのときしか詳細を得られない？
%% 2,3,5 それぞれの番号のみのリストで試した結果、上記のとおりであった
