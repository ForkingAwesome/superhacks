"use client";
import StepsCard from "@/components/directory/StepsCard";
import Footer from "@/components/Footer";
import Header from "@/components/Header";

export default function Create() {
  return (
    <div className="bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF]">
      <Header />
      <div className="flex flex-col px-40 pb-20">
        <StepsCard />
      </div>
      <Footer />
    </div>
  );
}
