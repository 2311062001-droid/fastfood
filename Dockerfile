FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# 1. Copy toàn bộ code vào
COPY . .

# 2. XÓA BỎ các file rác của Windows để tránh xung đột trên Linux (FIX LỖI 155)
RUN rm -rf obj bin

# 3. Chạy khôi phục và đóng gói
RUN dotnet restore "FastFoodWeb.csproj"
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]