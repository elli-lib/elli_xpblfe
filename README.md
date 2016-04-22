# elli_xpblfe

[![Build Status](https://travis-ci.org/quasiquoting/elli_xpblfe.svg?branch=master)](https://travis-ci.org/quasiquoting/elli_xpblfe)
[![img](https://img.shields.io/hexpm/v/elli_xpblfe.svg)](https://hex.pm/packages/elli_xpblfe)
[![img](https://img.shields.io/badge/docs-100%25-green.svg)](http://quasiquoting.org/elli_xpblfe)

An [elli][] middleware to add the following header to all responses:

```http
X-Powered-By: LFE
```

[elli]: https://github.com/knutin/elli


## Config

rebar.config:
```erlang
{elli_xpblfe, "0.1.1"}
```


## Usage

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
