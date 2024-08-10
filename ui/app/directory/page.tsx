"use client";
import { useState } from "react";
import DAOCard from "@/components/directory/DAOCard";
import Footer from "@/components/Footer";
import Header from "@/components/Header";
import Image from "next/image";
import hand from "@/public/directory/hand.svg";
import Search from "@/components/directory/Search";
import Filter from "@/components/directory/Filter";

export default function Home() {
  const [selectedFilter, setSelectedFilter] = useState<string>("All DAOs");

  const handleFilterChange = (filter: string) => {
    setSelectedFilter(filter);
  };

  const renderContent = () => {
    switch (selectedFilter) {
      case "Member":
        return (
          <div className="mt-10">
            <DAOCard />
            <DAOCard />
          </div>
        );
      case "Following":
        return (
          <div className="mt-10">
            <DAOCard />
          </div>
        );
      case "All DAOs":
      default:
        return (
          <div className="mt-10">
            <DAOCard />
            <DAOCard />
            <DAOCard />
          </div>
        );
    }
  };

  return (
    <div className="bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF]">
      <Header />
      <div className="flex flex-col px-40 pb-20">
        <main className="flex flex-col">
          <div className="flex flex-col pb-8 md:flex-row items-center justify-between">
            <div className="max-w-md">
              <h1 className="text-4xl font-bold">Explore the DAO World</h1>
              <p className="text-gray-700 mt-4 font-semibold">
                Build your SubDAO, explore communities, and find inspiration for
                your project all in one place.
              </p>
              <button className="mt-6 bg-black text-white py-2 px-4 rounded-md">
                Get Started
              </button>
            </div>
            <div className="mt-6 md:mt-0">
              <Image
                src={hand}
                alt="Exploring SubDAOs"
                width={500}
                height={400}
              />
            </div>
          </div>
          <div className="flex justify-between items-center">
            <Filter onFilterChange={handleFilterChange} />
            <Search />
          </div>
          {renderContent()}
        </main>
      </div>
      <Footer />
    </div>
  );
}
