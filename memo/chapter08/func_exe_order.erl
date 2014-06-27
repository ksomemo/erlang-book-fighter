%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%% 関数の実行順序の検証
%%% @end
%%% Created : 27. 6 2014 20:16
%%%-------------------------------------------------------------------
-module(func_exe_order).
-author("ksomemo").

%% API
-export([
  main/0
]).

main() ->
  Pid0 = spawn(io, format, ["spawn/1_lambda~n"]),
  io:format("Pid0 bind ~p~n", [Pid0]),
  io:format("Pid0 after~n~n"),

  Pid1 = spawn(fun() -> io:format("spawn/1_lambda~n") end),
  io:format("Pid1 bind ~p~n", [Pid1]),
  io:format("Pid1 after~n~n"),

  Pid2 = spawn(fun sub1/0),
  io:format("Pid2 bind ~p~n", [Pid2]),
  io:format("Pid2 after1~n"),
  io:format("Pid2 after2~n"),
  io:format("Pid2 after3~n~n"),

  io:format("sub2 before~n"),
  sub2(),
  io:format("sub2 after~n"),

  [Pid0, Pid1, Pid2].

sub1() ->
  io:format("sub1~n"),
  Pid3 = spawn(fun() -> io:format("spawn/1_lambda in sub1~n") end),
  io:format("Pid3 bind ~p~n", [Pid3]),
  io:format("Pid3 after~n~n").

sub2() ->
  io:format("sub2_1~n"),
  io:format("sub2_2~n"),
  io:format("sub2_3~n").
