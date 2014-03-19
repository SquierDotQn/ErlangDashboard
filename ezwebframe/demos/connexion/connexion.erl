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
    	{Browser,{struct,[{clicked,<<"Leave">>}]}} ->
    	io:format("Deco~n"),

    %	io:format("chat idle received:~p~n",[X]),
	%irc ! {leave, Who},
	%VraiDeco(Browser),
	 	Browser ! [{cmd,hide_div},{id,fenetre}],
	    Browser ! [{cmd,show_div},{id,menu_connexion}],
	    idle(Browser); 

	{Browser, {struct, [{join,Who}]}} ->
		irc ! {leave, Who},
	    irc ! {join, self(), Who},
	    idle(Browser);
	{irc, welcome, _} ->
	    Browser ! [{cmd,hide_div},{id,menu_connexion}],
	    Browser ! [{cmd,show_div},{id,fenetre}],
	   idle(Browser);
	X ->
	    io:format("chat idle received:~p~n",[X]),
	    idle(Browser)
	        end.





	