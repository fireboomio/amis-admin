import {
  Client,
  type ClientConfig,
  type ExtractMeta,
  type ExtractProfileName,
  type FetchUserRequestOptions,
  type MutationRequestOptions,
  type OperationsDefinition,
  type OperationMetadata,
  type QueryRequestOptions,
  type SubscriptionRequestOptions,
  type SubscriptionEventHandler,
  type UploadValidationOptions,
  type UploadRequestOptions,
  type User,
} from "@fireboom/client";
import type { api__executeRawInput,api__executeRawResponse,api__listPublicResponse,api__queryRawInput,api__queryRawResponse,area__createOneInput,area__createOneResponse,area__findManyInput,area__findManyResponse,area__findMaxSubCodeInput,area__findMaxSubCodeResponse,area__findNamesInput,area__findNamesResponse,log__createOneInput,log__createOneResponse,log__deleteManyInput,log__deleteManyResponse,log__findManyInput,log__findManyResponse,menu__createOneInput,menu__createOneResponse,menu__deleteManyInput,menu__deleteManyResponse,menu__findManyInput,menu__findManyResponse,menu__findMenuByPathInput,menu__findMenuByPathResponse,menu__findUniqueInput,menu__findUniqueResponse,menu__updateOneInput,menu__updateOneResponse,post__author__findManyResponse,post__category__createOneInput,post__category__createOneResponse,post__category__deleteManyInput,post__category__deleteManyResponse,post__category__findManyInput,post__category__findManyResponse,post__category__findUniqueInput,post__category__findUniqueResponse,post__category__updateOneInput,post__category__updateOneResponse,post__createOneInput,post__createOneResponse,post__deleteManyInput,post__deleteManyResponse,post__findManyInput,post__findManyResponse,post__findUniqueInput,post__findUniqueResponse,post__updateOneInput,post__updateOneResponse,role__api__findManyInput,role__api__findManyResponse,role__createOneInput,role__createOneResponse,role__deleteManyInput,role__deleteManyResponse,role__findManyInput,role__findManyResponse,role__findUniqueInput,role__findUniqueResponse,role__updateOneInput,role__updateOneResponse,role__user__updateManyInput,role__user__updateManyResponse,user__casdoor__addUserInput,user__casdoor__addUserResponse,user__casdoor__loginInput,user__casdoor__loginResponse,user__casdoor__refreshTokenInput,user__casdoor__refreshTokenResponse,user__casdoor__sendCodeInput,user__casdoor__sendCodeResponse,user__casdoor__updateUserInput,user__casdoor__updateUserResponse,user__countResponse,user__deleteManyInput,user__deleteManyResponse,user__findManyInput,user__findManyResponse,user__findUniqueInput,user__findUniqueResponse,user__meResponse, } from './models'

export type Role = "admin" | "test" | "test1" | "user"

export type CustomClaims = Record<string, any>

export const S3_ENABLED = true
export const AUTH_ENABLED = false

export interface UploadResponse { key: string }

type S3Providers ={
  tengxunyun: {
    hasProfiles: false,
    profiles: {
    }
  }
}

const S3ProviderData = {
  tengxunyun: {
    useSSL: true,
    bucketName: 'test-1314985928',
    endpoint: 'cos.ap-nanjing.myqcloud.com/'
  }
}

const S3ProfileData: { [provider: string]: { [profile: string]: UploadValidationOptions } } = {
  tengxunyun: {
  },
}


export const defaultClientConfig: ClientConfig = {
  applicationHash: "d41d8cd9",
  baseURL: "http://localhost:9991",
  sdkVersion: "",
}

export const operationMetadata: OperationMetadata = {
  "api/executeRaw": {
    requiresAuthentication: false
  },
  "api/listPublic": {
    requiresAuthentication: false
  },
  "api/queryRaw": {
    requiresAuthentication: false
  },
  "area/createOne": {
    requiresAuthentication: false
  },
  "area/findMany": {
    requiresAuthentication: true
  },
  "area/findMaxSubCode": {
    requiresAuthentication: false
  },
  "area/findNames": {
    requiresAuthentication: false
  },
  "log/createOne": {
    requiresAuthentication: false
  },
  "log/deleteMany": {
    requiresAuthentication: false
  },
  "log/findMany": {
    requiresAuthentication: false
  },
  "menu/createOne": {
    requiresAuthentication: false
  },
  "menu/deleteMany": {
    requiresAuthentication: false
  },
  "menu/findMany": {
    requiresAuthentication: false
  },
  "menu/findMenuByPath": {
    requiresAuthentication: false
  },
  "menu/findUnique": {
    requiresAuthentication: false
  },
  "menu/updateOne": {
    requiresAuthentication: false
  },
  "post/author/findMany": {
    requiresAuthentication: false
  },
  "post/category/createOne": {
    requiresAuthentication: false
  },
  "post/category/deleteMany": {
    requiresAuthentication: false
  },
  "post/category/findMany": {
    requiresAuthentication: false
  },
  "post/category/findUnique": {
    requiresAuthentication: false
  },
  "post/category/updateOne": {
    requiresAuthentication: false
  },
  "post/createOne": {
    requiresAuthentication: false
  },
  "post/deleteMany": {
    requiresAuthentication: false
  },
  "post/findMany": {
    requiresAuthentication: false
  },
  "post/findUnique": {
    requiresAuthentication: false
  },
  "post/updateOne": {
    requiresAuthentication: false
  },
  "role/api/findMany": {
    requiresAuthentication: false
  },
  "role/createOne": {
    requiresAuthentication: false
  },
  "role/deleteMany": {
    requiresAuthentication: false
  },
  "role/findMany": {
    requiresAuthentication: false
  },
  "role/findUnique": {
    requiresAuthentication: false
  },
  "role/updateOne": {
    requiresAuthentication: false
  },
  "role/user/updateMany": {
    requiresAuthentication: false
  },
  "user/casdoor/addUser": {
    requiresAuthentication: false
  },
  "user/casdoor/login": {
    requiresAuthentication: false
  },
  "user/casdoor/refreshToken": {
    requiresAuthentication: false
  },
  "user/casdoor/sendCode": {
    requiresAuthentication: false
  },
  "user/casdoor/updateUser": {
    requiresAuthentication: false
  },
  "user/count": {
    requiresAuthentication: false
  },
  "user/deleteMany": {
    requiresAuthentication: false
  },
  "user/findMany": {
    requiresAuthentication: false
  },
  "user/findUnique": {
    requiresAuthentication: false
  },
  "user/me": {
    requiresAuthentication: true
  }
}

export class FBClient extends Client {
	query<
		OperationName extends Extract<keyof Operations['queries'], string>,
		Input extends Operations['queries'][OperationName]['input'] = Operations['queries'][OperationName]['input'],
		Response extends Operations['queries'][OperationName]['response'] = Operations['queries'][OperationName]['response']
	>(options: OperationName extends string ? QueryRequestOptions<OperationName, Input> : QueryRequestOptions) {
		return super.query<QueryRequestOptions, Response['data'], Response['error']>(options);
	}
	mutate<
		OperationName extends Extract<keyof Operations['mutations'], string>,
		Input extends Operations['mutations'][OperationName]['input'] = Operations['mutations'][OperationName]['input'],
		Response extends Operations['mutations'][OperationName]['response'] = Operations['mutations'][OperationName]['response']
	>(options: OperationName extends string ? MutationRequestOptions<OperationName, Input> : MutationRequestOptions) {
		return super.mutate<MutationRequestOptions, Response['data'], Response['error']>(options);
	}
	subscribe<
		OperationName extends Extract<keyof Operations["subscriptions"], string>,
		Input extends Operations["subscriptions"][OperationName]["input"] = Operations["subscriptions"][OperationName]["input"],
		Response extends Operations["subscriptions"][OperationName]["response"] = Operations["subscriptions"][OperationName]["response"],
	>(
		options: OperationName extends string
			? SubscriptionRequestOptions<OperationName, Input>
			: SubscriptionRequestOptions,
		cb?: SubscriptionEventHandler<Response["data"], Response["error"]>
	) {
		return super.subscribe<SubscriptionRequestOptions, Response["data"], Response["error"]>(options, cb)
	}
  // @ts-ignore
  public async uploadFiles<
    ProviderName extends Extract<keyof S3Providers, string>,
    ProfileName extends ExtractProfileName<S3Providers[ProviderName]['profiles']>
      = ExtractProfileName<S3Providers[ProviderName]['profiles']>,
    Meta extends ExtractMeta<S3Providers[ProviderName]['profiles'], ProfileName>
      = ExtractMeta<S3Providers[ProviderName]['profiles'], ProfileName>
  >(config: UploadRequestOptions<ProviderName, ProfileName, Meta> & { appendEndpoint?: boolean }) {
    const validation = config.profile ? S3ProfileData[config.provider][config.profile as string] : undefined;
    // @ts-ignore
    return super.uploadFiles(config, validation).then((resp) => {
      if (config.appendEndpoint !== false) {
        const { useSSL, bucketName, endpoint } = S3ProviderData[config.provider] ?? {}
        resp.fileKeys = resp.fileKeys.map(
          k => `${useSSL ? `https://` : `http://`}${bucketName}.${endpoint}/${k}`
        )
      }
      return resp
    });
  }
	public login(authProviderID: Operations['authProvider'], redirectURI?: string) {
		return super.login(authProviderID, redirectURI);
	}
	public async fetchUser<TUser extends User = User<Role, CustomClaims>>(options?: FetchUserRequestOptions) {
		return super.fetchUser<TUser>(options);
	}
}

export const createClient = (config?: ClientConfig) => {
  return new FBClient({
    ...defaultClientConfig,
    ...config,
    operationMetadata,
    csrfEnabled: false,
  });
};

export type Queries = {
  'api/listPublic': {
    input?: undefined
    response: api__listPublicResponse
    requiresAuthentication: false
    
  }
  'area/findMany': {
    input: area__findManyInput
    response: area__findManyResponse
    requiresAuthentication: true
    
  }
  'log/findMany': {
    input: log__findManyInput
    response: log__findManyResponse
    requiresAuthentication: false
    
  }
  'menu/findMany': {
    input: menu__findManyInput
    response: menu__findManyResponse
    requiresAuthentication: false
    
  }
  'menu/findMenuByPath': {
    input: menu__findMenuByPathInput
    response: menu__findMenuByPathResponse
    requiresAuthentication: false
    
  }
  'menu/findUnique': {
    input: menu__findUniqueInput
    response: menu__findUniqueResponse
    requiresAuthentication: false
    
  }
  'post/author/findMany': {
    input?: undefined
    response: post__author__findManyResponse
    requiresAuthentication: false
    
  }
  'post/category/findMany': {
    input: post__category__findManyInput
    response: post__category__findManyResponse
    requiresAuthentication: false
    
  }
  'post/category/findUnique': {
    input: post__category__findUniqueInput
    response: post__category__findUniqueResponse
    requiresAuthentication: false
    
  }
  'post/findMany': {
    input: post__findManyInput
    response: post__findManyResponse
    requiresAuthentication: false
    
  }
  'post/findUnique': {
    input: post__findUniqueInput
    response: post__findUniqueResponse
    requiresAuthentication: false
    
  }
  'role/api/findMany': {
    input: role__api__findManyInput
    response: role__api__findManyResponse
    requiresAuthentication: false
    
  }
  'role/findMany': {
    input: role__findManyInput
    response: role__findManyResponse
    requiresAuthentication: false
    
  }
  'role/findUnique': {
    input: role__findUniqueInput
    response: role__findUniqueResponse
    requiresAuthentication: false
    
  }
  'user/count': {
    input?: undefined
    response: user__countResponse
    requiresAuthentication: false
    
  }
  'user/findMany': {
    input: user__findManyInput
    response: user__findManyResponse
    requiresAuthentication: false
    
  }
  'user/findUnique': {
    input: user__findUniqueInput
    response: user__findUniqueResponse
    requiresAuthentication: false
    
  }
  'user/me': {
    input?: undefined
    response: user__meResponse
    requiresAuthentication: true
    
  }
}

export type Mutations = {
  'api/executeRaw': {
    input: api__executeRawInput
    response: api__executeRawResponse
    requiresAuthentication: false
  }
  'api/queryRaw': {
    input: api__queryRawInput
    response: api__queryRawResponse
    requiresAuthentication: false
  }
  'area/createOne': {
    input: area__createOneInput
    response: area__createOneResponse
    requiresAuthentication: false
  }
  'log/deleteMany': {
    input: log__deleteManyInput
    response: log__deleteManyResponse
    requiresAuthentication: false
  }
  'menu/createOne': {
    input: menu__createOneInput
    response: menu__createOneResponse
    requiresAuthentication: false
  }
  'menu/deleteMany': {
    input: menu__deleteManyInput
    response: menu__deleteManyResponse
    requiresAuthentication: false
  }
  'menu/updateOne': {
    input: menu__updateOneInput
    response: menu__updateOneResponse
    requiresAuthentication: false
  }
  'post/category/createOne': {
    input: post__category__createOneInput
    response: post__category__createOneResponse
    requiresAuthentication: false
  }
  'post/category/deleteMany': {
    input: post__category__deleteManyInput
    response: post__category__deleteManyResponse
    requiresAuthentication: false
  }
  'post/category/updateOne': {
    input: post__category__updateOneInput
    response: post__category__updateOneResponse
    requiresAuthentication: false
  }
  'post/createOne': {
    input: post__createOneInput
    response: post__createOneResponse
    requiresAuthentication: false
  }
  'post/deleteMany': {
    input: post__deleteManyInput
    response: post__deleteManyResponse
    requiresAuthentication: false
  }
  'post/updateOne': {
    input: post__updateOneInput
    response: post__updateOneResponse
    requiresAuthentication: false
  }
  'role/createOne': {
    input: role__createOneInput
    response: role__createOneResponse
    requiresAuthentication: false
  }
  'role/deleteMany': {
    input: role__deleteManyInput
    response: role__deleteManyResponse
    requiresAuthentication: false
  }
  'role/updateOne': {
    input: role__updateOneInput
    response: role__updateOneResponse
    requiresAuthentication: false
  }
  'role/user/updateMany': {
    input: role__user__updateManyInput
    response: role__user__updateManyResponse
    requiresAuthentication: false
  }
  'user/casdoor/addUser': {
    input: user__casdoor__addUserInput
    response: user__casdoor__addUserResponse
    requiresAuthentication: false
  }
  'user/casdoor/login': {
    input: user__casdoor__loginInput
    response: user__casdoor__loginResponse
    requiresAuthentication: false
  }
  'user/casdoor/refreshToken': {
    input: user__casdoor__refreshTokenInput
    response: user__casdoor__refreshTokenResponse
    requiresAuthentication: false
  }
  'user/casdoor/sendCode': {
    input: user__casdoor__sendCodeInput
    response: user__casdoor__sendCodeResponse
    requiresAuthentication: false
  }
  'user/casdoor/updateUser': {
    input: user__casdoor__updateUserInput
    response: user__casdoor__updateUserResponse
    requiresAuthentication: false
  }
  'user/deleteMany': {
    input: user__deleteManyInput
    response: user__deleteManyResponse
    requiresAuthentication: false
  }
}

export type Subscriptions = {
}

export type LiveQueries = {
}

export interface Operations extends OperationsDefinition<Queries, Mutations, Subscriptions, LiveQueries, Role, S3Providers> {}