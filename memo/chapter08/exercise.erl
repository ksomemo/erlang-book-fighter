%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%% 8章の練習問題
%%% @end
%%% Created : 25. 6 2014 3:21
%%%-------------------------------------------------------------------
-module(exercise).
-author("ksomemo").

%% API
-export([
  ring_bench_hub/2
  , ring_bench_loop/ 2
  , loop/3
]).

ring_bench_hub(N, M) ->
  Ring = create_ring(N),

  io:format("ring_bench(N=~p, M=~p) start.~n", [N, M]),
  statistics(runtime),
  statistics(wall_clock),

  register(bench, self()),
  message(M, Ring, Ring),
  receive
    finish ->
      {_, Time1} = statistics(runtime),
      {_, Time2} = statistics(wall_clock),
      io:format("ring_bench time=~p (~p) microseconds.~n", [Time1 * 1000, Time2 * 1000]),

      unregister(bench)
  end.

create_ring(N) ->
  lists:map(fun(_) -> spawn(fun() -> loop() end) end, lists:seq(1, N)).

loop() ->
  receive
    _Any ->
%      io:format("Pid is ~p, Request is ~w.~n", [self(), _Any]),
      loop()
  end.

message(0, _, _) ->
  bench ! finish;
message(M, [Pid|T], Ring) ->
  Pid ! {M},
  message(M, T, Ring);
message(M, [], Ring) ->
  message(M - 1, Ring, Ring).

%% ここからloop版
usage() ->
  io:format("ring_bench_loop(N, M) N >= 1, M >= 1").
ring_bench_loop(N, M) when N =< 0 orelse M =< 0 ->
  usage();
ring_bench_loop(N, M) ->
  Main = self(),
  Head = create_ring_loop(Main, N),

  io:format("ring_bench(N=~p, M=~p) start.~n", [N, M]),
  statistics(runtime),
  statistics(wall_clock),

  Head ! {Main, M, msg},
  receive
    {_from, finish} ->
      {_, Time1} = statistics(runtime),
      {_, Time2} = statistics(wall_clock),
      io:format("ring_bench time=~p (~p) milli seconds.~n", [Time1, Time2]),
      Head ! {Main, kill}
  end.

create_ring_loop(Main, N) ->
  IsLastNode    = N =:= 1,
  Head          = create_ring_head(IsLastNode),
  TailFirstNode = create_ring_tail(Main, Head, N - 1),

  Head ! {Main, TailFirstNode},
  Head.

create_ring_head(IsLastNode) ->
  spawn(fun() -> set_head_next(IsLastNode) end).
set_head_next(IsLastNode) ->
  receive
    {Main, NextNode} ->
      loop(Main, NextNode, IsLastNode)
  end.

create_ring_tail(_Main, FirstNode, _Rest) when _Rest =< 0 ->
  FirstNode;
create_ring_tail(Main, FirstNode, Rest) ->
  IsLastNode = Rest =< 1,
  spawn(exercise, loop, [Main, create_ring_tail(Main, FirstNode, Rest - 1), IsLastNode]).

loop(Main, NextNode, IsLastNode) ->
  receive
    {_From, kill} ->
      NextNode ! {self(), kill};
    {_From, Round, Response} ->
%%       io:format(
%%         "From is ~p, self() is ~p, Next is ~p, IsLastNode(~p), Round is ~p.~n"
%%         , [_From, self(), NextNode, IsLastNode, Round]),

      IsLastMessage = Round =< 1 andalso IsLastNode,
      FixRound = if
        IsLastNode -> Round - 1;
        true       -> Round
      end,

      if
        not IsLastMessage ->
          NextNode ! {self(), FixRound, Response},
          loop(Main, NextNode, IsLastNode);
        true ->
          Main ! {self(), finish}
      end
  end.
