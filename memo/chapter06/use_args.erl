%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 6 2014 3:27
%%%-------------------------------------------------------------------
-module(use_args).
-author("ksomemo").

%% API
-compile(export_all).

main(Args) ->
  io:format("Args is ~w.~n", [Args]),
  TypeFuncs = [
    fun is_atom/1 % これだけがtrueになる
    , fun is_binary/1
    , fun is_bitstring/1
    , fun is_boolean/1 % true,falseの場合こちらも
    , fun is_float/1
    , fun is_function/1
    , fun is_integer/1
    , fun is_list/1
    , fun is_number/1
    , fun is_pid/1
    , fun is_port/1
%    , fun is_process_alive/1 型調べとは違う
    , fun is_tuple/1
  ],
  [io:format("~w(~w).~n", [Arg, F(Arg)]) || Arg <- Args, F <- TypeFuncs].
