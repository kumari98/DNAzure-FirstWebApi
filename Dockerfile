##See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
#
#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /app
##EXPOSE 80
#
##FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
##WORKDIR /src
##COPY ["WebApiValuesService/WebApiValuesService.csproj", "WebApiValuesService/"]
##COPY WebApiValuesService/WebApiValuesService.csproj .
#COPY *.csproj ./
#COPY . ./
##RUN dotnet restore "WebApiValuesService/WebApiValuesService.csproj"
#RUN dotnet restore WebApiValuesService.csproj
##COPY . .
#COPY ./WebApiValuesService .
##WORKDIR "/src/WebApiValuesService"
##RUN dotnet build "WebApiValuesService.csproj" -c Release -o /app/build
#RUN dotnet build WebApiValuesService.csproj -c Release -o /out
#
##FROM build AS publish
##RUN dotnet publish "WebApiValuesService.csproj" -c Release -o /app/publish
#FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS runtime
##FROM base AS final
#WORKDIR /app
##COPY --from=publish /app/publish .
#COPY --from=build /out ./
#ENTRYPOINT ["dotnet", "WebApiValuesService.dll"]


# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore
# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "WebApplication01.dll"]
