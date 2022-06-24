import { Module } from '@nestjs/common';

import { AccountsModule } from './features/accounts/accounts.module';

@Module({
  imports: [AccountsModule],
})
export class AppModule {}
