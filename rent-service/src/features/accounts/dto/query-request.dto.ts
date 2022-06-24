import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class QueryRequestDto {
  @ApiProperty({
    description: 'Text to filter with',
    required: false,
  })
  @IsOptional()
  @IsString()
  readonly searchQuery?: string;

  @ApiPropertyOptional({
    description: 'Filter by query',
    required: false,
    type: 'object',
  })
  @IsOptional()
  readonly filterBy?: Record<string, any>;
}
