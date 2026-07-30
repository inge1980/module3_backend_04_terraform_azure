FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY src/Web/Web.csproj src/Web/
RUN dotnet restore src/Web/Web.csproj

COPY . .

WORKDIR /src/src/Web
RUN dotnet publish Web.csproj -c Release -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:10.0

WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Web.dll"]