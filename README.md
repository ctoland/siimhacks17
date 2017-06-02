#README

## Build Container

```bash
docker build -t ctoland/dockFHIR .
```

## Run Container

```bash
docker run -itP -e APIKEY=your-api-key dockFHIR
```

## Determine container's port

```bash
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
4f5e909cf184        dockFHIR              "bundle exec rails..."   2 minutes ago       Up 2 minutes        0.0.0.0:32768->3000/tcp   admiring_noyce
```

## Use

http://localhost:32768


