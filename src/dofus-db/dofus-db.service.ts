import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { AxiosResponse } from 'axios';
import { Observable } from 'rxjs';
import { DofusDbResponse } from './dofus-db.interface';
import { ItemDto } from './dto/item.dto';

@Injectable()
export class DofusDbService {
  private static baseUrl = 'https://api.dofusdb.fr'; // TODO: use .env
  defaultParams = { 'typeId[$ne]': 203, $sort: 'id', lang: 'fr', $limit: 5 };
  constructor(private readonly httpService: HttpService) {}

  searchItem(
    slug?: string,
  ): Observable<AxiosResponse<DofusDbResponse<ItemDto>>> {
    const params = { ...this.defaultParams };

    if (slug) params[`slug.${this.defaultParams.lang}[$search]`] = slug;

    return this.httpService.get(`${DofusDbService.baseUrl}/items`, { params });
  }
}
