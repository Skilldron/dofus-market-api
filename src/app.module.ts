import { Module } from '@nestjs/common';
import { DofusDbModule } from './dofus-db/dofus-db.module';
import { ItemModule } from './item/item.module';

@Module({
  imports: [DofusDbModule, ItemModule],
})
export class AppModule {}
