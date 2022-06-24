import { Injectable } from '@nestjs/common';
import { AuthService } from 'src/common/auth/service/auth.service';
import {
  accountsResponseDto,
  buildParams,
  buildStateList,
  buildStateOrProvinceList,
} from 'src/common/utils/builders';
import {
  DEFAULT_SELECTION,
  STATE_CODE,
  STATE_OR_PROVINCE_SELECTION,
} from 'src/common/utils/constants';
import { handleError } from 'src/common/utils/error-handling';

import { GetALLAccountsResponseDto } from './dto/get-all-accounts-response.dto';
import { QueryRequestDto } from './dto/query-request.dto';
import { AccountsRepository } from './repository/accounts.repository';

@Injectable()
export class AccountsService {
  constructor(
    private readonly authService: AuthService,
    private readonly accountsRepository: AccountsRepository,
  ) {}

  public async getStateOrProvinceList(): Promise<string[]> {
    const params = buildParams(STATE_OR_PROVINCE_SELECTION);
    const token = await this.authService.getToken();
    const response = await this.findAllStateOrProvinceRequest(params, token);
    handleError(response);
    return response;
  }

  public async findAll(
    queryRequestDto: QueryRequestDto,
  ): Promise<GetALLAccountsResponseDto[]> {
    const params = buildParams(DEFAULT_SELECTION, queryRequestDto);
    const token = await this.authService.getToken();
    const response = await this.getAllAccountsRequest(params, token);
    handleError(response);
    return response;
  }

  private async findAllStateOrProvinceRequest(params: any, token: string) {
    return await this.accountsRepository
      .getStateOrProvinceList(params, token)
      .catch((error) => {
        console.error(error);
        return error;
      })
      .then((response) => {
        if (response.status === 200 && response.data) {
          return buildStateOrProvinceList(response.data);
        } else {
          return response;
        }
      });
  }

  public async findAllStateCodesٌ(): Promise<number[]> {
    const params = buildParams(STATE_CODE);
    const token = await this.authService.getToken();
    const response = await this.findAllStateCodesٌRequest(params, token);
    handleError(response);
    return response;
  }

  private async findAllStateCodesٌRequest(params: any, token: string) {
    return await this.accountsRepository
      .getStateOrProvinceList(params, token)
      .catch((error) => {
        console.error(error);
        return error;
      })
      .then((response) => {
        if (response.status === 200 && response.data) {
          return buildStateList(response.data);
        } else {
          return response;
        }
      });
  }

  private async getAllAccountsRequest(params: any, token: string) {
    return await this.accountsRepository
      .getAllAccounts(params, token)
      .catch((error) => {
        console.error(error);
        return error;
      })
      .then((response) => {
        if (response.status === 200 && response.data) {
          return accountsResponseDto(response.data);
        } else {
          return response;
        }
      });
  }
}
