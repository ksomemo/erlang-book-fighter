%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 6 2014 21:45
%%%-------------------------------------------------------------------
-module(area_server0).
-author("ksomemo").

%% API
-export([loop/0]).

-spec loop/0 :: () -> none().
%% -spec loop() :: none().
loop() ->
  receive
    {rectangle, Width, Ht} ->
      io:format("Area of rectangle is ~p~n", [Width * Ht]),
      loop();
    {circle, R} ->
      io:format("Area of circle is ~p~n", [3.14159 * R * R]),
      loop();
    Other ->
      io:format("I don't know what the area of a ~p is ~n", [Other]),
      loop()
  end.
