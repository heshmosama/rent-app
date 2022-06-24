import axios from 'axios';
import { ACCOUNT_ENDPOINT, API_URL } from 'src/common/utils/constants';

export class AccountsRepository {
  public async getAllAccounts(params: any, token: string): Promise<any> {
    const FULL_PATH = (process.env.API_URL ?? API_URL).concat(ACCOUNT_ENDPOINT);
    return axios.get(FULL_PATH, {
      params: params,
      headers: {
        Authorization: token,
      },
    });
  }

  public async getStateOrProvinceList(
    params: any,
    token: string,
  ): Promise<any> {
    const FULL_PATH = (process.env.API_URL ?? API_URL).concat(ACCOUNT_ENDPOINT);
    return axios.get(FULL_PATH, {
      params: params,
      headers: {
        Authorization: token,
      },
    });
  }

  public async getAllStateCodes(params: any, token: string): Promise<any> {
    const FULL_PATH = (process.env.API_URL ?? API_URL).concat(ACCOUNT_ENDPOINT);
    return axios.get(FULL_PATH, {
      params: params,
      headers: {
        Authorization: token,
      },
    });
  }
}
