FROM node:latest as build
WORKDIR /app
COPY hello_world_react /app/
RUN ["npm", "i", "--silent"]

FROM node:latest
WORKDIR /app
COPY --from=build /app/ /app/
EXPOSE 8000
CMD ["npm", "start", "&"]