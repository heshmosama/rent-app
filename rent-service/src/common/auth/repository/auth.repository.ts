import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import axios from 'axios';
import { Cache } from 'cache-manager';
import * as moment from 'moment';
import { authDtoBuilder } from 'src/common/utils/builders';

import {
  CLIENT_ID,
  CLIENT_SECRET,
  GRANT_TYPE,
  SCOPE,
  TOKEN_KEY,
  AUTH_URL,
  AUTH_ENDPOINT,
  TENANT,
} from '../../utils/constants';
import { AuthDto } from '../dto/auth.dto';

@Injectable()
export class AuthRepository {
  constructor(@Inject(CACHE_MANAGER) private cacheManager: Cache) {}

  public async getToken(): Promise<AuthDto> {
    const cachedResponse = await this.getCachedResponse();
    if (cachedResponse) {
      return cachedResponse;
    } else {
      return await this.requestToken();
    }
  }

  private async requestToken() {
    const data = this.buildTokenRequestData();
    return await axios
      .post(
        `${process.env.AUTH_URL ?? AUTH_URL}/${
          process.env.TENANT ?? TENANT
        }/${AUTH_ENDPOINT}`,
        data,
        {
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          },
        },
      )
      .catch((error) => {
        console.error(error);
        throw error;
      })
      .then(async (response) => {
        if (response && response.status === 200 && response.data) {
          const authDto = authDtoBuilder(response.data);
          await this.cacheResponse(authDto);
          return authDto;
        }
      });
  }

  private buildTokenRequestData() {
    return new URLSearchParams({
      grant_type: process.env.GRANT_TYPE ?? GRANT_TYPE,
      client_id: process.env.CLIENT_ID ?? CLIENT_ID,
      client_secret: process.env.CLIENT_SECRET ?? CLIENT_SECRET,
      scope: process.env.SCOPE ?? SCOPE,
    });
  }

  private async cacheResponse(authDto: AuthDto) {
    await this.cacheManager.set(TOKEN_KEY, authDto, {
      ttl: parseInt(authDto.expires_in) - 60 * 3,
    });
  }

  private async getCachedResponse(): Promise<AuthDto> {
    const token = (await this.cacheManager.get(TOKEN_KEY)) as AuthDto;

    if (token && moment().isBefore(token.expires_on)) {
      return token;
    }
  }
}
