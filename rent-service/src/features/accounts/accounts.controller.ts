import { Controller, Get, HttpStatus, Query } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { AccountsService } from './accounts.service';
import { GetALLAccountsResponseDto } from './dto/get-all-accounts-response.dto';
import { QueryRequestDto } from './dto/query-request.dto';

@Controller('accounts')
@ApiTags('Accounts')
export class AccountsController {
  constructor(private readonly accountsService: AccountsService) {}

  @Get()
  @ApiOkResponse({
    status: HttpStatus.OK,
    type: GetALLAccountsResponseDto,
    isArray: true,
  })
  async findAll(
    @Query() queryRequestDto: QueryRequestDto,
  ): Promise<GetALLAccountsResponseDto[]> {
    console.log(queryRequestDto);
    return this.accountsService.findAll(queryRequestDto);
  }

  @Get('state-or-province')
  @ApiOkResponse({
    isArray: true,
    type: String,
    status: HttpStatus.OK,
  })
  async findAllStateOrProvince(): Promise<string[]> {
    return this.accountsService.getStateOrProvinceList();
  }

  @Get('state-code')
  @ApiOkResponse({
    isArray: true,
    type: String,
    status: HttpStatus.OK,
  })
  async findAllState(): Promise<number[]> {
    return this.accountsService.findAllStateCodesٌ();
  }
}
