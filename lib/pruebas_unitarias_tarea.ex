defmodule InvoiceValidator do
  def validate_dates(%DateTime{} = emisor_dt, %DateTime{} = pac_dt) do
    case DateTime.compare(emisor_dt, pac_dt) do
      :gt -> #greater than
        cond do
          # diff -> devuelve la diferencia en segundos
          DateTime.diff(emisor_dt, pac_dt) <= 300 ->
            :ok
          true -> {:error, "Invoice is more than 5 mins ahead in time"}
        end
      :lt -> #less than
        cond do
          DateTime.diff(pac_dt, emisor_dt) <= 259200 ->
            :ok
          true -> {:error, "Invoice was issued more than 72 hrs before received by the PAC"}
        end
      :eq -> #equal
        :ok
    end
  end
end
