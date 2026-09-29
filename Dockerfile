FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

COPY . .
RUN rm -f global.json
RUN rm -rf obj bin
RUN dotnet restore "FastFoodWeb.csproj"
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Lấy file DB từ thư mục src của bước build
COPY --from=build /src/fastfood .
RUN chmod 777 fastfood

ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]