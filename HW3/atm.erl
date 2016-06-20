-module(atm).
-export([withdraw/2]).

withdraw_money(Amount,Got,[],Rest,Was) ->
	%io:format("Hello"),
	if not(Amount == 0) ->
		{request_another_amount,[],Was};
	   true -> {ok,Got,Rest}
	end;

withdraw_money(Amount,Got,RestToWatch,Rest,Was) ->
	%io:format("~p~n",[length(Rest)]),	
	MaxEl = lists:max(RestToWatch),
	if 	
		Amount-MaxEl >= 0 ->
			%io:format(">=0!!"),
			withdraw_money(Amount-MaxEl,Got ++	 [MaxEl],RestToWatch -- [MaxEl],Rest -- [MaxEl],Was);
		Amount-MaxEl < 0 ->
			%io:format("<0!!"),
			withdraw_money(Amount,Got,RestToWatch -- [MaxEl], Rest,Was);

	        (Amount == 0) ->
			%io:format("==0!!"),
			{ok,Got,Rest};
		
		true -> {Amount,Got,RestToWatch,Rest}
	end.
	
	
withdraw(0,Banknotes) ->
	{ok,[],Banknotes};

withdraw(Amount,[]) ->
	error("No Cash");

withdraw(Amount,Banknotes) ->
	withdraw_money(Amount,[],Banknotes,Banknotes,Banknotes).


