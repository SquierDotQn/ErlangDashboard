-module(connexion).
-export([start/1]).

start(Browser) ->
    case whereis(irc) of
	undefined -> irc:start();
	_ -> true
    end,
    idle(Browser).

idle(Browser) ->
    receive
	{Browser, {struct, [{join,Who}]}} ->
	    irc ! {join, self(), Who},
	    idle(Browser);
	{irc, welcome, _} ->
	    Browser ! [{cmd,hide_div},{id,menu_connexion}],
	    Browser ! [{cmd,show_div},{id,fenetre}];
	X ->
	    io:format("chat idle received:~p~n",[X]),
	    idle(Browser)
    end.
