defmodule App.Accounts.User.Authentication.Sms.ClaimsServer do
  use GenServer

  def start_link(claims) do
    GenServer.start_link(__MODULE__, claims, [])
  end

  @spec handle_call({:create_claim, String.t()}, map()) :: {:reply, false, map()} | {:reply, true, map()}
  def handle_call({:create_claim, valid_phone_number}, claims) do
    code = send_claim_code(valid_phone_number)

    case Map.fetch(claims, valid_phone_number) do
      generated_code when not is_nil(generated_code) and generated_code == code ->
        {:reply, true, Map.drop(claims, valid_phone_number)}

      _ ->
        {:reply, false, claims}
    end
  end

  def handle_call({:verify, valid_phone_number, code}, _from, claims) do
    case Map.fetch(claims, valid_phone_number) do
      generated_code when generated_code == code ->
        {:reply, true, Map.drop(claims, valid_phone_number)}

      _ ->
        {:reply, false, claims}
    end
  end

  defp send_claim_code(phone_number) do
  end
end
