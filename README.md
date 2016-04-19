# elli_xpblfe

An [elli][] middleware to add the following header to all responses:

```http
X-Powered-By: LFE
```


## Usage:

Just add it to the `mods` in your `elli_middleware` callback args:

```erlang
Config = [
          {mods, [
                  %% ...
                  {elli_xpblfe, []}
                 ]}
         ],
elli:start_link([..., {callback, elli_middleware}, {callback_args, Config}]).
```


## License

Copyright © 2016 Eric Bailey
This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See the [LICENSE][] file for more details.

[LICENSE]: ./LICENSE
