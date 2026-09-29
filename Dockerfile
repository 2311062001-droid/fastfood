FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

COPY . .

# ĐÂY LÀ DÒNG LỆNH CỐT LÕI ĐỂ FIX LỖI 155: Xóa global.json để gỡ bỏ khóa phiên bản SDK
RUN rm -f global.json
RUN rm -rf obj bin

RUN dotnet restore "FastFoodWeb.csproj"
RUN dotnet publish "FastFoodWeb.csproj" -c Release -o /app/out /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "FastFoodWeb.dll"]