import React from "react";
import LogoIcon from "./LogoIcon";

// Brand mark for Intelligent Speech. Name kept for existing call sites
// (width={200} / width={120}); it now renders only the logo icon.
const HandyTextLogo = ({
  width,
  height,
  className,
}: {
  width?: number;
  height?: number;
  className?: string;
}) => {
  const size = Math.round((width ?? 120) / 2);
  return (
    <div className={`flex justify-center ${className ?? ""}`}>
      <LogoIcon width={height ?? size} height={height ?? size} />
    </div>
  );
};

export default HandyTextLogo;
