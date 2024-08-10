"use client";
import { useState, ChangeEvent } from 'react';
import { FaSearch } from 'react-icons/fa';

export default function Search() {
  const [searchTerm, setSearchTerm] = useState('');

  const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };

  return (
    <div className="flex items-center border border-gray-300 rounded-md px-4 py-2 w-full md:w-[30rem]">
      <FaSearch className="text-gray-400 mr-2" />
      <input
        type="text"
        placeholder="Search"
        value={searchTerm}
        onChange={handleInputChange}
        className="bg-transparent outline-none text-gray-600 placeholder-gray-400 w-full"
      />
    </div>
  );
}