defmodule Rocketpay.Accounts.Withdraw do
  alias Accounts.Operation
 alias Rocketpay.Repo

 def call(params) do
   params
   |> Operation.call(:withdraw )
   |> run_transaction()
 end

 defp run_transaction(multi) do
   case Repo.transaction(multi) do
     {:error, _operation, reason, _changes} -> {:error, reason}
     {:ok, %{update_balance: account}} -> {:ok, account}
   end
 end
end
