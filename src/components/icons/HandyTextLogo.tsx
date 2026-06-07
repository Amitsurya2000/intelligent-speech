import React from "react";

// Brand wordmark for Intelligent Speech. Rendered as styled text (instead of an
// SVG wordmark) so it always reflects the product name. Sizing scales from the
// `width` prop so existing call sites (width={200} / width={120}) keep working.
const HandyTextLogo = ({
  width,
  height,
  className,
}: {
  width?: number;
  height?: number;
  className?: string;
}) => {
  const fontSize = width ? Math.max(14, Math.round(width / 7)) : 26;
  return (
    <div
      className={className}
      style={{
        width: width ? `${width}px` : undefined,
        height: height ? `${height}px` : undefined,
        fontSize: `${fontSize}px`,
        fontWeight: 800,
        lineHeight: 1.05,
        letterSpacing: "-0.02em",
        color: "var(--color-logo-primary)",
        textAlign: "center",
      }}
    >
      Intelligent Speech
    </div>
  );
};

export default HandyTextLogo;