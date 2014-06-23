%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 6 2014 20:05
%%%-------------------------------------------------------------------
-module(processes).
-author("ksomemo").

%% API
-export([
  max/1
]).

%% @doc N個のプロセスを作ってから破棄し、その処理にかかる時間を調べる
-spec max(N::integer()) -> none().
max(N) ->
  Max = erlang:system_info(process_limit),
  io:format("Maximum allowed processes:~p~n", [Max]),
  statistics(runtime),
  statistics(wall_clock),
  L = for(1, N, fun() -> spawn(fun() -> wait() end) end),
  {_, Time1} = statistics(runtime),
  {_, Time2} = statistics(wall_clock),
  lists:foreach(fun(Pid) -> Pid ! die end, L),
  U1 = Time1 * 1000 / N,
  U2 = Time2 * 1000 / N,
  io:format("Process spawn time=~p (~p) microseconds~n", [U1, U2]).

%% @doc
-spec wait() -> none().
wait() ->
  receive
    die -> void
  end.

%% @doc for文(range?)の数字に関数を適用し、リストに結果を格納するの代わり
-spec for(I::integer(), N::integer(), F::fun()) -> list().
for (N, N, F) -> [F()];
for (I, N, F) -> [F()|for(I+1, N, F)].
