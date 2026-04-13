# Stage 1: Ambil data matang dari OmniRoute resmi
FROM diegosouzapw/omniroute:latest AS omniroute-base

# Stage 2: Bangun ekosistem baru pakai OS Node 22 Slim murni (bebas distroless)
FROM node:22-slim

# Install OpenClaw pakai NPM bawaan (Gak bakal kena limit RAM/Storage karena ini dieksekusi di server GitHub, bukan ClawCloud)
RUN npm install -g openclaw

# Set variabel environment dasar
ENV NODE_ENV=production
ENV PORT=20128
# Biar OmniRoute otomatis nyari CLI tanpa perlu dikasih tau jalurnya lagi
ENV CLI_MODE=auto

# Pindahkan mesin OmniRoute dari image asli ke rumah barunya
WORKDIR /app
COPY --from=omniroute-base /app /app

# Buka port sakral OmniRoute
EXPOSE 20128

# Gas nyalakan mesinnya
CMD ["node", "server.js"]
