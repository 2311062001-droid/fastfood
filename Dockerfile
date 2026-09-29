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

# CHỈNH SỬA TẠI ĐÂY: Copy trực tiếp file database và cấp quyền đọc/ghi (Fix lỗi 139)
COPY fastfood .
RUN chmod 777 fastfood

ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]