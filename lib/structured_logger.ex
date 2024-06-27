defmodule StructuredLogger do
  def format(level, message, timestamp, _metadata) do
    %{
      message: format_message(message),
      syslog: %{
        level: level,
        timestamp: format_timestamp(timestamp),
      }
    }
    |> Jason.encode!()
    |> append_newline()
  end

  defp format_timestamp({{y,m,d},{h,mn,s,ms}}) do
    NaiveDateTime.new!(y, m, d, h, mn, s, {ms, 3})
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.to_iso8601()
  end

  defp append_newline(str) do
    str <> "\n"
  end

  defp format_message(message) when is_binary(message), do: message
  defp format_message(message) when is_list(message), do: Enum.join(Enum.map(message, &inspect/1), " ")
end
