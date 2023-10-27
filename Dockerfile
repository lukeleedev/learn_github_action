FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /TodoApi

# Copy everything
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /TodoApi
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "TodoApi.dll"]