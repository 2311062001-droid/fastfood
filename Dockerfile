FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src
COPY ["FastFoodWeb.csproj", "./"]
RUN dotnet restore "FastFoodWeb.csproj"
COPY . .
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]