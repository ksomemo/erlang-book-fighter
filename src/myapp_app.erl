%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc documentation
%%% example.
%%% @end
%%% Created : 22. 6 2014 20:05
%%%-------------------------------------------------------------------
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

%% @doc documentation cf.(http://www.erlang.org/doc/apps/edoc/chapter.html)
%% ```
%% multi
%% line
%% documentation.'''
%% @end
-type myType() :: my | type.
-spec format(X::string(), Y::myType()) -> none().
%% -spec format/2 :: (X::string(), Y::myType()) -> none().
%% アリティに関する記述をしなくても同じ出力になったので、こっちでいいかも
format(X, Y) ->
  io:format("X is ~p and Y is ~p.n", [X, Y]).
