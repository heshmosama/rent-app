import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common';

export function handleError(response: any) {
  if (response && response.status && response.status === 400) {
    throw new BadRequestException();
  } else if (response && response.status && response.status !== 400) {
    throw new InternalServerErrorException();
  }
}
