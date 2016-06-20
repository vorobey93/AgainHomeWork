-module(atm_server).
-behaviour(gen_server).
-include("server_addr.hrl").
-export([start_link/0]).

-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).


start_link() ->
  gen_server:start_link(?SERVER, ?MODULE, [], []).

init([]) ->
  {ok, []}.

handle_call({withdraw, Amount}, _, State) ->
  HistFull = State,
  if 
	length(HistFull)>0 -> 
		Hist = hd(HistFull),
		{_,_,CurState} = Hist;
	true -> CurState = [5000, 50, 50, 50, 1000, 5000, 1000, 500, 100]
  end,
  	Result=atm:withdraw(Amount,CurState),
  	{Code,Got,_} = Result,
  	{reply,{Code,Got},[Result|State]};

  
handle_call(stop, _From, State) ->
    {stop, normal, ok, State};

handle_call({stop, Reason}, _From, State) ->
    {stop, Reason, ok, State};  

handle_call(history, _, State) ->
  Result = State,
  NewState = State,
  {reply, Result, NewState};

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(clear_history, _State) ->
  {noreply, []};

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.