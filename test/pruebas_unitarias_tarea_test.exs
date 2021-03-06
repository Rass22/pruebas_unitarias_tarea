defmodule InvoiceValidatorTest do
  use ExUnit.Case, async: false

  Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)

  @tz_cdmx "America/Mexico_City"

  #timbrado
  @pac_dt DateTime.from_naive!(~N[2022-03-23 15:06:35], @tz_cdmx)

  data =  [

   {"72 hrs atras",    "America/Tijuana",  ~N[2022-03-20 13:06:31],  :error},
   {"72 hrs atras",    "America/Mazatlan",  ~N[2022-03-20 14:06:31],  :error},
   {"72 hrs atras",    "America/Mexico_City",     ~N[2022-03-20 15:06:31],  :error},
   {"72 hrs atras",    "America/Cancun",     ~N[2022-03-20 16:06:31],  :error},
   {"72 hrs atras",    "America/Tijuana",  ~N[2022-03-20 14:06:35],  :ok},
   {"72 hrs atras",    "America/Mazatlan",  ~N[2022-03-20 14:06:35],  :ok},
   {"72 hrs atras",    "America/Mexico_City",     ~N[2022-03-20 15:06:35],  :ok},
   {"72 hrs atras",    "America/Cancun",     ~N[2022-03-20 16:06:35],  :ok},
   {"5 mns adelante",  "America/Tijuana",  ~N[2022-03-23 14:11:35],  :ok},
   {"5 mns adelante",  "America/Mazatlan",  ~N[2022-03-23 14:11:35],  :ok},
   {"5 mns adelante",  "America/Mexico_City",     ~N[2022-03-23 15:11:35],  :ok},
   {"5 mns adelante",  "America/Cancun",     ~N[2022-03-23 16:11:35],  :ok},
   {"5 mns adelante",  "America/Tijuana",  ~N[2022-03-23 14:11:36],  :error},
   {"5 mns adelante",  "America/Mazatlan",  ~N[2022-03-23 14:11:36],  :error},
   {"5 mns adelante",  "America/Mexico_City",     ~N[2022-03-23 15:11:36],  :error},
   {"5 mns adelante",  "America/Cancun",     ~N[2022-03-23 16:11:36],  :error},

  ]

  for {a, b, c, d} <- data do
    @a a
    @b b
    @c c
    @d d

    test "#{@a}, emisor in #{@b} at #{@c} returns #{@d}" do
      assert InvoiceValidator.validate_dates(datetime(@c, @b),@pac_dt) == @d
    end
  end

    defp datetime(%NaiveDateTime{} = ndt, tz) do
      DateTime.from_naive!(ndt, tz)
    end
end
