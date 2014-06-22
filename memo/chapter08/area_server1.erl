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
  loop/0
  , rpc/2
]).

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