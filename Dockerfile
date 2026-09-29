FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["FastFoodWeb.csproj", "./"]
RUN dotnet restore "FastFoodWeb.csproj"
COPY . .
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]