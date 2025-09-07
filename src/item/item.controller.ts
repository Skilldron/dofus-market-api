import { Controller, Get, Query } from '@nestjs/common';
import { ItemService } from './item.service';
import { ItemDto } from 'src/dofus-db/dto/item.dto';

@Controller('items')
export class ItemController {
  constructor(private readonly itemService: ItemService) {}

  @Get()
  index(@Query('slug') slug?: string): Promise<ItemDto[]> {
    return this.itemService.searchItem(slug);
  }
}
