%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 6 2014 11:54
%%%-------------------------------------------------------------------
-module(stimer).
-author("ksomemo").

%% API
-export([
  start/2
  , cancel/1
]).

%% @doc Timeミリ秒後に関数を実行を予約する
-spec start(Time::integer(), Fun::function()) -> pid().
start(Time, Fun) ->
  spawn(fun() -> timer(Time, Fun) end).

%% @doc Timeミリ秒後に関数を実行し、解除メッセージを受け取り中止することもできる
-spec timer(Time::integer(), Fun::function()) -> pid().
timer(Time, Fun) ->
  io:format("start at ~p.~n", [time()]),
  receive
    cancel ->
      io:format("cancel at ~p.~n", [time()]),
      void
  after Time ->
    io:format("execute at ~p.~n", [time()]),
    Fun()
  end.

%% @doc startで実行予約を解除する
-spec cancel(Pid::pid()) -> none().
cancel(Pid) ->
  Pid ! cancel.
