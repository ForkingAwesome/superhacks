import { useState } from "react";
import ProgressBar from "./ProgressBar";
import Image from "next/image";

const chainsData = {
  mainnet: [
    {
      name: "Ethereum",
      type: "L1 Blockchain",
      image: "/path-to-ethereum-image",
      selected: false,
    },
    {
      name: "Polygon",
      type: "L2 Blockchain",
      image: "/path-to-polygon-image",
      selected: false,
    },
    {
      name: "Arbitrum",
      type: "L2 Blockchain",
      image: "/path-to-arbitrum-image",
      selected: false,
    },
    {
      name: "Base",
      type: "L2 Blockchain",
      image: "/path-to-base-image",
      selected: false,
    },
  ],
  testnet: [
    {
      name: "Goerli",
      type: "Testnet",
      image: "/path-to-goerli-image",
      selected: false,
    },
    {
      name: "Mumbai",
      type: "Testnet",
      image: "/path-to-mumbai-image",
      selected: false,
    },
  ],
};

const MultiStepForm: React.FC = () => {
  const [currentStep, setCurrentStep] = useState(0);
  const [network, setNetwork] = useState<"mainnet" | "testnet">("mainnet");
  const [selectedChain, setSelectedChain] = useState<string | null>(null);

  const steps = [
    "Select blockchain",
    "Describe your DAO",
    "Define membership",
    "Select governance settings",
  ];

  const handleNetworkChange = (network: "mainnet" | "testnet") => {
    setNetwork(network);
    setSelectedChain(null);
  };

  const handleChainSelect = (chainName: string) => {
    setSelectedChain(chainName);
  };

  return (
    <div className="max-w-4xl mx-auto p-8 bg-white shadow-md rounded-lg">
      <ProgressBar currentStep={currentStep} steps={steps} />
      <h2 className="text-2xl font-bold mb-4">
        Step {currentStep + 1}: {steps[currentStep]}
      </h2>
      <p className="mb-8">
        The chain you choose is where your tokens and assets are stored. If you
        already have a token, choose the chain your token is minted on. This
        cannot be changed later.
      </p>
      <div className="flex justify-center mb-6">
        <button
          onClick={() => handleNetworkChange("mainnet")}
          className={`px-4 py-2 mx-2 ${
            network === "mainnet"
              ? "bg-blue-500 text-white"
              : "bg-gray-200 text-gray-700"
          }`}
        >
          Mainnet
        </button>
        <button
          onClick={() => handleNetworkChange("testnet")}
          className={`px-4 py-2 mx-2 ${
            network === "testnet"
              ? "bg-blue-500 text-white"
              : "bg-gray-200 text-gray-700"
          }`}
        >
          Testnet
        </button>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {chainsData[network].map((chain) => (
          <div
            key={chain.name}
            className={`p-4 border rounded-lg flex items-center justify-between cursor-pointer ${
              selectedChain === chain.name
                ? "border-blue-500"
                : "border-gray-200"
            }`}
            onClick={() => handleChainSelect(chain.name)}
          >
            <div className="flex items-center">
              <Image
                src={chain.image}
                alt={chain.name}
                width={30}
                height={30}
                className="mr-4"
              />
              <div>
                <div className="font-bold">{chain.name}</div>
                <div className="text-gray-600">{chain.type}</div>
              </div>
            </div>
            {selectedChain === chain.name && (
              <div className="text-blue-500 font-bold">Selected</div>
            )}
          </div>
        ))}
      </div>
      <div className="flex justify-end mt-8">
        {currentStep < steps.length - 1 && (
          <button
            onClick={() => setCurrentStep(currentStep + 1)}
            className="px-4 py-2 bg-blue-500 text-white rounded-lg"
          >
            Next
          </button>
        )}
      </div>
    </div>
  );
};

export default MultiStepForm;
