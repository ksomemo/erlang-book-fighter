%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 6 2014 21:45
%%%-------------------------------------------------------------------
-module(area_server1).
-author("ksomemo").

%% API
-export([
  start/0
  , area/2
]).

-spec start() -> pid().
start() ->
  spawn(fun loop/0).

-spec area(Pid::pid(), What::any()) -> any().
area(Pid, What) ->
  rpc(Pid, What).

-spec loop() -> none().
loop() ->
  receive
    {From, {rectangle, Width, Ht}} ->
      From ! {self(), Width * Ht},
      loop();
    {From, {circle, R}} ->
      From ! {self(), 3.14159 * R * R},
      loop();
    {From, Other} ->
      From ! {self(), {error, Other}},
      loop()
  end.

-spec rpc(Pid::pid(), Request::any()) -> any().
rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid ,Response} ->
      Response
  end.
