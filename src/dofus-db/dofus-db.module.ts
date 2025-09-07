import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { DofusDbService } from './dofus-db.service';

@Module({
  imports: [HttpModule],
  providers: [DofusDbService],
  exports: [DofusDbService],
})
export class DofusDbModule {}
