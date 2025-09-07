export interface DofusDbResponse<T> {
  total: number;
  limit: number;
  skip: number;
  data: T[];
}

export interface DofusDbLanguage {
  id: string;
  de: string;
  en: string;
  es: string;
  fr: string;
  pt: string;
}
