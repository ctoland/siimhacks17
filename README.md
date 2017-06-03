#README

## Build Container from Scratch or skip to next step

```bash
docker build -t ctoland/dockfhir .
```

## Run Container

```bash
docker run -itP -e APIKEY=your-api-key ctoland/dockfhir
```

## Determine container's port

```bash
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
4f5e909cf184        dockfhir              "bundle exec rails..."   2 minutes ago       Up 2 minutes        0.0.0.0:32768->3000/tcp   admiring_noyce
```

## Use

http://localhost:32768


