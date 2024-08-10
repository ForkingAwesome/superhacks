"use client";
import React, { useState } from 'react';

const filters = ['All DAOs', 'Member', 'Following'];

const Filter: React.FC<{ onFilterChange: (filter: string) => void }> = ({ onFilterChange }) => {
  const [selectedFilter, setSelectedFilter] = useState<string>(filters[0]);

  const handleFilterClick = (filter: string) => {
    setSelectedFilter(filter);
    onFilterChange(filter);
  };

  return (
    <div className="flex gap-4 mt-6">
      {filters.map((filter) => (
        <button
          key={filter}
          onClick={() => handleFilterClick(filter)}
          className={`px-4 py-2 rounded-full border ${
            selectedFilter === filter ? 'border-blue-500 text-blue-500' : 'border-gray-300 text-gray-500'
          }`}
        >
          {filter}
        </button>
      ))}
    </div>
  );
};

export default Filter;
