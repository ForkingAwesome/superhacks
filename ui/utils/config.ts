import { createConfig, cookieStorage } from "@account-kit/react";
import { QueryClient } from "@tanstack/react-query";
import { sepolia } from "@account-kit/infra"; 

export const config = createConfig(
	{ 
	  apiKey: "2yFeC3hbBSCsHbaIw6YJoD04-1dQfkVg", 
	  chain: sepolia, 
	  ssr: true, 
	  storage: cookieStorage, 
	},
	{ 
	  auth: {
      sections: [
        [{ type: "email" }],
        [{ type: "passkey" }, { type: "injected" }],
      ],
      addPasskeyOnSignup: true,
      //@ts-ignore
      showSignInText: true,
    },
  }
);

export const queryClient = new QueryClient();