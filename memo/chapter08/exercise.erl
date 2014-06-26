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
