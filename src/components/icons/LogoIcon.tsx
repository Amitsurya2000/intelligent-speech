import React from "react";

interface LogoIconProps {
  width?: number | string;
  height?: number | string;
  className?: string;
  // Accepted for compatibility with the old icon components; the logo is fixed-color.
  color?: string;
}

// The one Intelligent Speech brand mark (sound bars + text cursor).
const LogoIcon: React.FC<LogoIconProps> = ({
  width = 24,
  height = 24,
  className = "",
}) => (
  <svg
    width={width}
    height={height}
    viewBox="0 0 1024 1024"
    xmlns="http://www.w3.org/2000/svg"
    className={className}
    aria-label="Intelligent Speech"
  >
    {/* Light inner outline keeps the mark visible on the green selected-item highlight. */}
    <rect
      width="1024"
      height="1024"
      rx="224"
      fill="#0F8A5F"
      stroke="#FFFFFF"
      strokeOpacity="0.7"
      strokeWidth="56"
    />
    <g fill="#FFFFFF">
      <rect x="188" y="362" width="84" height="300" rx="42" />
      <rect x="320" y="252" width="84" height="520" rx="42" />
      <rect x="452" y="322" width="84" height="380" rx="42" />
      <rect x="584" y="392" width="84" height="240" rx="42" />
    </g>
    <g fill="#A7F3D0">
      <rect x="758" y="232" width="36" height="560" rx="18" />
      <rect x="716" y="232" width="120" height="34" rx="17" />
      <rect x="716" y="758" width="120" height="34" rx="17" />
    </g>
  </svg>
);

export default LogoIcon;
