FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libgdiplus
RUN apt-get install -y libc6-dev 
RUN ln -s /usr/lib/libgdiplus.so/usr/lib/gdiplus.dll

WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src

### Settings for when we deploy on Linux
COPY ["./HelloWorldProgram/", "HelloWorldProgram/"]

RUN dotnet restore "HelloWorldProgram/HelloWorldProgram/HelloWorldProgram.csproj"

COPY . .

WORKDIR "/src/HelloWorldProgram/HelloWorldProgram/"

# change to Release
RUN dotnet build "HelloWorldProgram.csproj" -c Release -o /app

# change to Release
FROM build AS publish
RUN dotnet publish "HelloWorldProgram.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloWorldProgram.csproj"]