FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base
WORKDIR /app
 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
 
# Install prerequisites for Native AOT
RUN apt-get update && apt-get install -y \
    clang \
    gcc \
    libc6-dev \
    libssl-dev \
    zlib1g-dev
 
COPY . .
RUN dotnet publish ./Mid_HelloWorld.csproj -c Release -o /app/publish
 
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Mid_HelloWorld.dll"]