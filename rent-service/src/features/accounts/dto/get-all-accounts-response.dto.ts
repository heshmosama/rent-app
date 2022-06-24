import { ApiProperty } from '@nestjs/swagger';
export class GetALLAccountsResponseDto {
  @ApiProperty()
  name: string;

  @ApiProperty()
  email: string;

  @ApiProperty()
  phone: string;

  @ApiProperty()
  addressComposite: string;

  @ApiProperty()
  accountNumber: string;

  @ApiProperty()
  stateCode: number;

  @ApiProperty()
  addressCity: string;

  @ApiProperty()
  addressLine1: string;

  @ApiProperty()
  addressStateOrProvince: string;

  @ApiProperty()
  addressPostalCode: string;

  @ApiProperty()
  accountId: string;

  @ApiProperty()
  addressCountry: string;

  @ApiProperty()
  imageUrl?: string;
}
