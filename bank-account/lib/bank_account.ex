defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(BankAccount, %{balance: 0, is_open: true})
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.cast(account, :close_account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end

  @impl true
  @spec init(any) :: {:ok, any}
  def init(account) do
    {:ok, account}
  end

  @impl true
  def handle_call(_, _, %{balance: balance, is_open: false}) do
    {:reply, {:error, :account_closed}, %{balance: balance, is_open: false}}
  end

  @impl true
  def handle_call(:balance, _form, %{balance: balance, is_open: is_open}) do
    {:reply, balance, %{balance: balance, is_open: is_open}}
  end

  @impl true
  def handle_call({:update, amount}, _, %{balance: balance, is_open: is_open}) do
    {:reply, :ok, %{balance: balance + amount, is_open: is_open}}
  end

  def handle_cast(_, %{balance: balance, is_open: false}) do
    {:reply, {:error, :account_closed}, %{balance: balance, is_open: false}}
  end

  @impl true
  def handle_cast(:close_account, %{balance: balance, is_open: _}) do
    {:noreply, %{balance: balance, is_open: false}}
  end
end
