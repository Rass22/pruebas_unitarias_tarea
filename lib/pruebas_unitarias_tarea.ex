defmodule InvoiceValidator do
  def validate_dates(%DateTime{} = emisor_dt, %DateTime{} = pac_dt) do
    case DateTime.compare(emisor_dt, pac_dt) do
      :gt -> #greater than
        cond do
          # diff -> devuelve la diferencia en segundos
          DateTime.diff(emisor_dt, pac_dt) <= 300 ->
            :ok
          true -> :error
        end
      :lt -> #less than
        cond do
          DateTime.diff(pac_dt, emisor_dt) <= 259200 ->
            :ok
          true -> :error
        end
      :eq -> #equal
        :ok
    end
  end
end

# 300 segundos = 5 min
# 259200 segundos = 72 horas = 3 dias
