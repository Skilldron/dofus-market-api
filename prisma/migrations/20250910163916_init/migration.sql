-- CreateTable
CREATE TABLE "public"."Item" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT,
    "level" INTEGER,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Server" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,

    CONSTRAINT "Server_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ItemPrice" (
    "price" BIGINT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "sourceClient" TEXT,
    "observedAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "itemId" BIGINT NOT NULL,
    "serverId" INTEGER NOT NULL,

    CONSTRAINT "ItemPrice_pkey" PRIMARY KEY ("itemId","observedAt")
);

-- CreateIndex
CREATE INDEX "Item_name_idx" ON "public"."Item"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Server_name_key" ON "public"."Server"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Server_slug_key" ON "public"."Server"("slug");

-- CreateIndex
CREATE INDEX "po_item_server_time_desc" ON "public"."ItemPrice"("itemId", "serverId", "observedAt");

-- CreateIndex
CREATE INDEX "ItemPrice_observedAt_idx" ON "public"."ItemPrice" USING BRIN ("observedAt");

-- AddForeignKey
ALTER TABLE "public"."ItemPrice" ADD CONSTRAINT "ItemPrice_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "public"."Item"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ItemPrice" ADD CONSTRAINT "ItemPrice_serverId_fkey" FOREIGN KEY ("serverId") REFERENCES "public"."Server"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
