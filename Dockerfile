FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    curl \
    ca-certificates \
    fonts-dejavu-core \
  && pip3 install --break-system-packages yt-dlp \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm@10

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

COPY lib/ ./lib/
COPY artifacts/api-server/package.json ./artifacts/api-server/
COPY artifacts/video-downloader/package.json ./artifacts/video-downloader/

RUN pnpm install --frozen-lockfile --prod=false

COPY artifacts/api-server/ ./artifacts/api-server/
COPY artifacts/video-downloader/ ./artifacts/video-downloader/
COPY tsconfig.base.json ./

RUN BASE_PATH="/" PORT=3000 pnpm --filter @workspace/video-downloader run build

RUN pnpm --filter @workspace/api-server run build

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "--enable-source-maps", "artifacts/api-server/dist/index.mjs"]
