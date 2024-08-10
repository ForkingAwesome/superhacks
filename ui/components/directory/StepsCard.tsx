"use client";
import { IDKitWidget, VerificationLevel } from "@worldcoin/idkit";
import Image from "next/image";
import Helix from "@/public/assests/cube-helix 1.png";
import Cube from "@/public/assests/cube-helix.png";
import Button from "../home/Button";
import Link from "next/link";
import { useState } from "react";

const StepsCard = () => {
  const [isVerified, setIsVerified] = useState(false);

  const stepsData = [
    {
      step: 1,
      title: "Select blockchain",
      image: Helix,
    },
    {
      step: 2,
      title: "Describe your DAO",
      image: Cube,
    },
    {
      step: 3,
      title: "Define membership",
      image: Helix,
    },
    {
      step: 4,
      title: "Select governance settings",
      image: Cube,
    },
  ];

  const verifyProof = async (proof: any) => {
    // Implement your server-side verification logic here
    console.log("Proof received: ", proof);
    // Simulate successful verification
    setIsVerified(true);
  };

  const onSuccess = () => {
    console.log("Verification successful");
  };

  return (
    <div className="flex flex-col items-center">
      <div className="flex flex-col items-center justify-center pt-10 px-12 pb-10 md:w-[600px]">
        <div className="border-2 w-fit p-0.5 px-3 text-sm rounded-xl border-slate-300/80">
          Everything you need
        </div>
        <div className="text-3xl md:text-4xl lg:text-5xl py-6 font-bold tracking-tighter text-center bg-gradient-to-b from-black to-[#002499] text-transparent bg-clip-text">
          Streamlined for easy management
        </div>

        <div className="text-center text-lg mb-8 md:text-xl">
          In 4 easy steps, setup the basic foundation for your DAO, add members
          and scale up the DAO as it progresses
        </div>
        {!isVerified ? (
          <IDKitWidget
            app_id="app_staging_cbe412024f72a1cd5e10f0f7dfc60524"
            action="dao-vote"
            verification_level={VerificationLevel.Orb}
            handleVerify={verifyProof}
            onSuccess={onSuccess}
          >
            {({ open }: any) => (
              <button
                onClick={open}
                className="bg-black text-white py-2 px-4 rounded-md"
              >
                Verify with World ID
              </button>
            )}
          </IDKitWidget>
        ) : (
          <Link href="/form">
            <Button text="Build your SubDAO" />
          </Link>
        )}
      </div>

      <div className="flex flex-col gap-16 pt-4 lg:flex-row justify-center items-center px-8">
        {stepsData.map((step) => (
          <div
            key={step.step}
            className="shadow-2xl rounded-xl flex justify-center items-center flex-col p-8 w-[300px]"
          >
            <Image src={step.image} alt={step.title} className="pb-4" />
            <div className="text-2xl font-bold pb-3 text-center">
              Step {step.step}
            </div>
            <div className="text-center">{step.title}</div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default StepsCard;
