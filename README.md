# docker-rubygems-server

Description
-----------

Docker image providing [rubygems-mirror](https://github.com/rubygems/rubygems-mirror) and a [gem server](https://github.com/geminabox/geminabox).

* [Docker Hub Repository](https://hub.docker.com/r/colstrom/docker-rubygems-server/builds/)

Deploying your Gem Server
-------------------------

Create a data container, so the gem server itself can be redeployed easily:
```
docker create --name rubygems-data -v /srv/gems busybox
```

Run the server:
```
docker run -d --volumes-from rubygems-data -p 9292 colstrom/rubygems-server
```

Using your Gem Server
---------------------

Set your rubygems mirror by following:
* http://bundler.io/v1.10/bundle_config.html

```
bundle config mirror.http://rubygems.org http://0.0.0.0:9292
```

* http://guides.rubygems.org/run-your-own-gem-server/#using-gems-from-your-server
```
gem sources --add http://0.0.0.0:9292
```

License
-------
[MIT](https://tldrlegal.com/license/mit-license)

Contributors
------------
* [Chris Olstrom](https://colstrom.github.io/) | [e-mail](mailto:chris@olstrom.com) | [Twitter](https://twitter.com/ChrisOlstrom)
* [mookjp](https://github.com/mookjp)
