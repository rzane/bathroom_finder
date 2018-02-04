![release](http://learnyousomeerlang.com/static/img/release.png)

---

# What are OTP Releases?

* Releases are packages of compiled Erlang bytecode.
* They contain scripts to start and stop the application.
* Totally self-contained: no external dependencies (with very few exceptions).
* ERTS (the Erlang Runtime System) is packaged with the application.
* Capable of hot updates, but I haven't tried it, so I won't talk about it.

---

# How do I configure a release?

* Just use [distillery](https://github.com/bitwalker/distillery).
* They provide a [walkthrough](https://hexdocs.pm/distillery/use-with-phoenix.html) for setting up your Phoenix app.

---

# How do I build a release?

```
$ yarn build
$ MIX_ENV=prod mix phx.digest
$ MIX_ENV=prod mix release
Compiling 19 files (.ex)
Generated bathroom_finder app
==> Assembling release..
==> Building release bathroom_finder:0.0.1 using environment prod
==> Including ERTS 9.0.5 from /usr/local/Cellar/erlang/20.0.5/lib/erlang/erts-9.0.5
==> Packaging release..
==> Release successfully built!
    You can run it in one of the following ways:
      Interactive: _build/prod/rel/bathroom_finder/bin/bathroom_finder console
      Foreground: _build/prod/rel/bathroom_finder/bin/bathroom_finder foreground
      Daemon: _build/prod/rel/bathroom_finder/bin/bathroom_finder start
```

---

### How do I run it?

Export our configuration:

    $ export DATABASE_URL=postgres://localhost:5432/bathroom_finder_prod
    $ export PORT=4000

Setup your database:

    $ MIX_ENV=prod mix do ecto.create, ecto.migrate

Start the server:

    $ cd _build/prod/rel/bathroom_finder
    $ bin/bathroom_finder start

---

### Poking around

We can attach to the running process and poke around:

    $ bin/bathroom_finder attach

*Note:* `ctrl+c` kills the node, `ctrl+d` exits.

---

### Observing

    $ cookie='iR0E.qCgdd~FEfl3P|IE5VrWkD?oYMGD_3g$}$o=GIN0W0?G.XnN1L_xj^~hVY%~'
    $ erl -name debug@127.0.0.1 -setcookie "$cookie" -hidden -run observer

*Note:* Typically, I think you'd treat this cookie a little more securely that I have.

---

# Caveat: No Mix Tasks 

That's not too big of a deal though, because we can create custom scripts in our release.

```
$ bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks migrate
```

```elixir
# lib/bathroom_finder/release_tasks.ex
defmodule BathroomFinder.ReleaseTasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:bathroom_finder)
    dir = Application.app_dir(:bathroom_finder, "priv/repo/migrations")
    Ecto.Migrator.run(BathroomFinder.Repo, dir, :up, all: true)
  end
end
```

---

# Caveat: Configuration

Make sure config vars are loaded from the environment at __run time__, not compile time.

```elixir
# BAD
config :bathroom_finder,
  blah: System.get_env("BLAH")
  
# BETTER
config :bathroom_finder,
  blah: {:system, "BLAH"}
```

---

# Let's build a docker image

    $ docker build -t rzane/bathroom_finder .

---

# Multi-stage is great!


|                           | Dockerfile | Dockerfile.horrible |
|---------------------------|------------|---------------------|
| Image size                | 39.8MB     | 507MB               |
| Build time (no cache)     | 2m 27s     | 2m 28s              |
| Build time (cache busted) | 1m 04s     | 1m 51s              |
| Push time                 | 37s        | 3m 42s              |
| Pull time                 | 10s        | 59s                 |

---

# Run the image

    $ docker-compose up app
    
*Note:* You might see some errors while the setup container is running.