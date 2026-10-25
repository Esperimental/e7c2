FROM alpine:3.20 AS extract
RUN apk add --no-cache unzip
RUN wget -q -O /tmp/e7c2.nupkg https://esperimental.github.io/e7c2/v3-flatcontainer/e7c2/0.1.0-dev.20261025/e7c2.0.1.0-dev.20261025.nupkg \
    && echo '562aef21cc11b377d26342934844e5d0504c1809171441101afff0d1b178924e  /tmp/e7c2.nupkg' | sha256sum -c - \
    && unzip -q /tmp/e7c2.nupkg -d /tmp/pkg

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=extract /tmp/pkg/app/ ./
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "Universal.Tools.Applications.Server.Api.dll"]
