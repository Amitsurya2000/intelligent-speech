import React from "react";
import logo from "../../assets/brand-logo.png";

interface LogoIconProps {
  width?: number | string;
  height?: number | string;
  className?: string;
  // Accepted for compatibility with the old icon components; the logo is fixed-color.
  color?: string;
}

// The Intelligent Advisory brand mark.
const LogoIcon: React.FC<LogoIconProps> = ({
  width = 24,
  height = 24,
  className = "",
}) => (
  <img
    src={logo}
    width={width}
    height={height}
    className={`object-contain ${className}`}
    alt="Intelligent Advisory"
    draggable={false}
  />
);

export default LogoIcon;
