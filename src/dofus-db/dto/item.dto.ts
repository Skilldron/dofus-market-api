import { DofusDbLanguage } from '../dofus-db.interface';

export class ItemDto {
  id: number;
  typeId: number;
  level: number;
  name: DofusDbLanguage;
  description: DofusDbLanguage;
  createdAt: string;
  updatedAt: string;
  img: string;
  type: {
    id: number;
    name: DofusDbLanguage;
    className: string;
    createdAt: string;
    updatedAt: string;
    superType: {
      id: number;
      className: string;
      name: DofusDbLanguage;
      createdAt: string;
      updatedAt: string;
    };
  };
}
