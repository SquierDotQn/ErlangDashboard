-module(tweet).
-export([start/1]).

start(Browser) ->
    running(Browser, []).

running(Browser, L) ->
    receive
	{Browser,{struct, [{entry,<<"tell">>},{txt,Txt}]}} ->
	    Browser ! [{cmd, append_div}, {id,scroll},
		       {txt,list_to_binary(["<div id=\"tweet\" > <div id=\"author\">Posted by toto </div> <div id=\"content\">", Txt, "</div> </div>"])}],
	    running(Browser, L);
	X ->
	    io:format("chat received:~p~n",[X])
    end,
    running(Browser, L).


