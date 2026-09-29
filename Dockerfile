FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Copy toàn bộ code vào trước khi restore và publish
COPY . .
RUN dotnet restore "FastFoodWeb.csproj"
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]