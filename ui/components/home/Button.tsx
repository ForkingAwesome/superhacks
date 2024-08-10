const Button = ({ text, onClick }: { text: string; onClick?: () => void }) => {
  return (
    <button
      className="text-white bg-black py-2 px-3 rounded-lg cursor-pointer"
      onClick={onClick}
    >
      {text}
    </button>
  );
};

export default Button;