"use client";
import Image from "next/image";
import Logo from "@/public/assests/logo.png";
import { FaBars } from "react-icons/fa";
import Button from "./home/Button";
import { ChevronDown } from "lucide-react";
import { useState } from "react";
import Link from "next/link";

const Header = () => {
  const [openDropdown, setOpenDropdown] = useState(null);

  const toggleDropdown = (dropdown: any) => {
    setOpenDropdown((prevDropdown) =>
      prevDropdown === dropdown ? null : dropdown
    );
  };

  return (
    <header className="flex justify-between items-center px-6 py-4 backdrop-blur-md sticky top-0 z-20 bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF]">
      <div className="flex items-center gap-2 justify-center">
        <Image src={Logo} alt="Logo" className="cursor-pointer" />
        <div className="text-xl font-semibold">CommuDAO</div>
      </div>
      <FaBars className="block md:hidden" />
      <nav className="hidden md:block">
        <ul className="flex gap-6 items-center relative">
          <li>
            <a href="#">Dashboard</a>
          </li>
          <li className="relative">
            <button
              onClick={() => toggleDropdown("subdaos")}
              className="flex items-center focus:outline-none"
            >
              Daohub
              <ChevronDown
                className={`ml-1 transition-transform duration-300 ${
                  openDropdown === "subdaos" ? "rotate-180" : ""
                }`}
              />
            </button>
            {openDropdown === "subdaos" && (
              <ul className="absolute top-full left-0 bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF] shadow-md rounded-md mt-2 py-2 w-48">
                <li className="px-4 py-2 hover:bg-[#E0E7FD]">
                  <Link href="/directory"><button>Directory</button></Link>
                </li>
                <li className="px-4 py-2 hover:bg-[#E0E7FD]">
                  <Link href="/create-subdao"><button>Setup SubDAO</button></Link>
                </li>
              </ul>
            )}
          </li>
          <li className="relative">
            <button
              onClick={() => toggleDropdown("proposals")}
              className="flex items-center focus:outline-none"
            >
              Proposals
              <ChevronDown
                className={`ml-1 transition-transform duration-300 ${
                  openDropdown === "proposals" ? "rotate-180" : ""
                }`}
              />
            </button>
            {openDropdown === "proposals" && (
              <ul className="absolute top-full left-0 bg-gradient-to-r from-[#E0E7FD] to-[#FDFEFF] shadow-md rounded-md mt-2 py-2 w-40">
                <li className="px-4 py-2 hover:bg-[#E0E7FD]">
                  <a href="#">Create Proposal</a>
                </li>
                <li className="px-4 py-2 hover:bg-[#E0E7FD]">
                  <a href="#">View Proposals</a>
                </li>
              </ul>
            )}
          </li>
          <Button text="Connect Wallet" />
        </ul>
      </nav>
    </header>
  );
};

export default Header;
