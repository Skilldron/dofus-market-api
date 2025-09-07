import { Injectable, Logger } from '@nestjs/common';
import { catchError, firstValueFrom } from 'rxjs';
import { AxiosError } from 'axios';
import { DofusDbService } from 'src/dofus-db/dofus-db.service';
import { ItemDto } from 'src/dofus-db/dto/item.dto';

@Injectable()
export class ItemService {
  private readonly logger = new Logger(ItemService.name);
  constructor(private readonly dofusDbService: DofusDbService) {}

  async searchItem(slug?: string): Promise<ItemDto[]> {
    const { data } = await firstValueFrom(
      this.dofusDbService.searchItem(slug).pipe(
        catchError((error: AxiosError) => {
          this.logger.error(error.response?.data);
          throw error;
        }),
      ),
    );
    return data.data;
  }
}
