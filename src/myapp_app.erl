-module(myapp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, format/2]).

-export_type([myType/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    myapp_sup:start_link().

stop(_State) ->
    ok.

-type myType() :: my | type.
%%-spec format/2 :: (X::string(), Y::myType()) -> none().
-spec format(X::string(), Y::myType()) -> none().
%% アリティに関する記述をしなくても同じ出力になったので、こっちでいいかも
format(X, Y) ->
  io:format("X is ~p~ and Y is ~p.n", [X, Y]).
