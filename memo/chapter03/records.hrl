%%%-------------------------------------------------------------------
%%% @author ksomemo
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 6 2014 11:30
%%%-------------------------------------------------------------------
-author("ksomemo").

%% 本来は、includeファイルに格納するべき？
%% HeaderファイルとしてIntellij Erlang Pluginで作成した
-record(todo, {
  status=remainder
  , who=joe
  , text
}).
