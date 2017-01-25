# Smashing on DC/OS
Run [Smashing](http://dashing.io/) in an [Alpine](https://alpinelinux.org/about/) [Docker](http://docker.io/) container on DC/OS.

Based on Smashing Alpine Container - https://hub.docker.com/r/rgcamus/alpine_smashing

## Build (optional)

```git clone https://github.com/keithmcclellan/smashing-on-dcos```

```cd smashing-on-dcos```

```docker build -t smashing-on-dcos . ```

## Run
```docker run -d -p 8080:3030 keithmcclellan/smashing-on-dcos```
or 
```dcos marathon app add marathon.json```

(local)
And point your browser to [http://localhost:8080/](http://localhost:8080/),
or to [http://localhost:8080/sampletv](http://localhost:8080/sampletv) for a 1080p TV layout.

(on DC/OS)
Install and configure marathon-lb
Browse to (public-node):3030

## Configuration
### Custom smashing port
If you want smashing to use a custom port inside the container, e g 8080, use the environment variable `$PORT`:

```docker run -d -e PORT=8080 -p 80:8080 keithmcclellan/smashing_on_dcos```

### Dashboards
To provide a custom dashboard, use container volume **/dashboards**:

```docker run -v=/my/custom/dashboards:/dashboards -d -p 8080:3030 keithmcclellan/smashing_on_dcos```

(*Don't forget to also provide the layout.erb*)

### Jobs
To provide custom jobs, use container volume **/jobs**:

```docker run -v=/my/cool/job:/jobs -d -p 8080:3030 keithmcclellan/smashing_on_dcos```

### Widgets
To install custom widgets supply the gist IDs of the widgets as an environment variable:

```docker run -d -e WIDGETS=5641535 -p 8080:3030 keithmcclellan/smashing_on_dcos```

This example will install the [Random Aww](https://gist.github.com/chelsea/5641535) widget
before starting smashing. Multiple widgets can be supplied.

Also you can use local custom widgets

```docker run -v=/my/cool/widgets:/widgets -d -p 8080:3030 keithmcclellan/smashing_on_dcos```


### Gems
To install gems, supply the gem name(s) as an environment variable:

```docker run -d -e GEMS=instagram -e WIDGETS=5278790 -p 8080:3030 keithmcclellan/smashing_on_dcos```

This example installs the [Instagram photos by location](https://gist.github.com/mjamieson/5278790) widget,
which depends on the instagram gem. Multiple gems and widgets can be supplied like so:

```docker run -d -e GEMS="mysql instagram" -e WIDGETS=5278790 -p 8080:3030 keithmcclellan/smashing_on_dcos```

### Public (favicon, 404)
To provide custom 404 and favicon, use container volume **/public**.

### Configuration File
The configuration file ```config.ru``` is available on volume */config*.

Edit this file to change your API key, to add authentication and more.

### lib volume
The smashing lib dir is available on volume */lib-smashing*.

## ToDo
Update advanced examples to demonstrate Marathon.json changes

## Thanks
- [@rgcamus](https://github.com/rgcamus), author of smashing on docker)
- [@frvi](https://github.com/frvi), original author of run.sh)
- [@mattgruter](https://github.com/mattgruter), awesome contributions!
- [@rowanu](https://github.com/rowanu), [Hotness Widget](https://gist.github.com/rowanu/6246149).
- [@munkius](https://github.com/munkius), [fork](https://gist.github.com/munkius/9209839) of Hotness Widget.
- [@chelsea](https://github.com/chelsea), [Random Aww](https://gist.github.com/chelsea/5641535).

## License
Distributed under the MIT license
