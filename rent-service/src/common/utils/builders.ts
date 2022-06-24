import * as moment from 'moment';
import { GetALLAccountsResponseDto } from 'src/features/accounts/dto/get-all-accounts-response.dto';
import { QueryRequestDto } from 'src/features/accounts/dto/query-request.dto';

import { AuthDto } from '../auth/dto/auth.dto';

export function authDtoBuilder(data: any): AuthDto {
  const duration = moment.duration(data.expires_in, 's').minutes();
  data.expires_on = moment().add(duration, 'm').toString();
  return <AuthDto>{
    ...data,
  };
}

export function accountsResponseDto(data: any): GetALLAccountsResponseDto[] {
  return data.value.map(
    (value) =>
      <GetALLAccountsResponseDto>{
        name: value.name,
        accountId: value.accountid,
        accountNumber: value.accountnumber,
        addressCity: value.address1_city,
        addressComposite: value.address1_composite,
        addressCountry: value.address1_country,
        addressLine1: value.address1_line1,
        addressPostalCode: value.address1_postalcode,
        addressStateOrProvince: value.address1_stateorprovince,
        email: value.emailaddress1,
        phone: value.telephone1,
        stateCode: value.statecode,
        imageUrl: value.entityimage,
      },
  );
}

export function buildStateOrProvinceList(data: any): string[] {
  const uniqList = new Set<string>();
  data.value.map((value) => uniqList.add(value.address1_stateorprovince));
  return Array.from(uniqList);
}

export function buildStateList(data: any): number[] {
  const uniqList = new Set<number>();
  data.value.map((value) => uniqList.add(value.statecode));
  return Array.from(uniqList);
}

export function buildParams(
  selection: string,
  queryRequestDto?: QueryRequestDto,
) {
  const filterQuery = queryRequestDto
    ? buildFilterQuery(queryRequestDto)
    : undefined;

  const params = {
    $select: selection,
    $count: true,
    $filter: filterQuery ? filterQuery : undefined,
  };
  return params;
}

export function buildFilterQuery(queryRequestDto: QueryRequestDto) {
  const searchQuery = queryRequestDto.searchQuery
    ? `(contains(name,'${queryRequestDto.searchQuery}') or contains(accountnumber,'${queryRequestDto.searchQuery}'))`
    : '';

  const filterObject = queryRequestDto?.filterBy
    ? JSON.parse(queryRequestDto.filterBy.toString())
    : '';

  const filterQuery = (
    filterObject?.statecode !== undefined
      ? `statecode eq ${filterObject?.statecode}`
      : ''
  )
    .concat(
      filterObject?.statecode !== undefined &&
        filterObject?.address1_stateorprovince
        ? ' or '
        : '',
      filterObject?.address1_stateorprovince !== undefined
        ? `address1_stateorprovince eq '${filterObject?.address1_stateorprovince}'`
        : '',
    )
    .trim();
  return searchQuery.concat(
    searchQuery && filterQuery ? ' and ' : '',
    filterQuery,
  );
}
