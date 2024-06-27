# DatadogLoggerExample

This is an example project for using the
[Gigalixir Datadog Logger Buildpack](https://github.com/gigalixir/gigalixir-buildpack-datadog-logger).


## Usage

### Create a custom logger

We are using a pretty basic [structured logger](/lib/structured_logger.ex).
You can customize this to your hearts content.

Change the `:logger` configuration in `config/config.exs` to use your custom logger.
```
config :logger, :console,
  format: { StructuredLogger, :format },
  metadata: [:request_id]
```

### Set the config variables for the logger

See the documentation on the buildpack.
At the time of writing you will need to set `GIG_DD_LOGGER__API_KEY` and `GIG_DD_LOGGER__URL`.


### Add the buildpack

Create a [.buildpacks](/.buildpacks) file with the custom logger.

At the time of writing, you will have to utilize Mix Mode (the mix buildpack),
as the releases buildpack does not support the datadog-logger buildpack.
