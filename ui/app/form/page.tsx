"use client";
import MultiStepForm from "@/components/directory/MultiStepForm";
import StepsCard from "@/components/directory/StepsCard";
import Footer from "@/components/Footer";
import Header from "@/components/Header";

export default function Form() {
  return (
    <div className="bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF]">
      <Header />
      <div className="flex flex-col px-40 pb-20">
        <MultiStepForm />
      </div>
      <Footer />
    </div>
  );
}
