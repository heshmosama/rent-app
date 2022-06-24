import { CacheModule, Module } from '@nestjs/common';
import { AccountsService } from './accounts.service';
import { AccountsController } from './accounts.controller';
import { AuthRepository } from 'src/common/auth/repository/auth.repository';
import { AuthService } from 'src/common/auth/service/auth.service';
import { AccountsRepository } from './repository/accounts.repository';

@Module({
  imports: [CacheModule.register()],
  controllers: [AccountsController],
  providers: [AccountsService, AuthService, AuthRepository, AccountsRepository],
})
export class AccountsModule {}
