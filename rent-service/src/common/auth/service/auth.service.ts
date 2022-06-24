import { Injectable } from '@nestjs/common';
import { AuthRepository } from '../repository/auth.repository';

@Injectable()
export class AuthService {
  constructor(private readonly authRepository: AuthRepository) {}
  public async getToken(): Promise<string> {
    const authDto = await this.authRepository.getToken();
    console.debug(
      'bearer token',
      authDto.token_type.concat(' ', authDto?.access_token),
    );
    return authDto.token_type.concat(' ', authDto?.access_token);
  }
}
