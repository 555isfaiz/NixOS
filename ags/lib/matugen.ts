import wallpaper from "service/wallpaper"
import options from "options"
import { bash, sh, dependencies } from "./utils"
import { exec } from 'child_process';

export default function init() {
    wallpaper.connect("changed", () => matugen())
    options.autotheme.connect("changed", () => matugen())
}

function animate(...setters: Array<() => void>) {
    const delay = options.transition.value / 2
    setters.forEach((fn, i) => Utils.timeout(delay * i, fn))
}

function hexToRgb(hex: string): { r: number, g: number, b: number } | null {
  // Remove the leading '#' if present
  if (hex.startsWith('#')) {
    hex = hex.slice(1);
  }

  // Ensure the hex code is valid
  if (hex.length !== 6) {
    return null; // Invalid hex code
  }

  // Parse the hex code
  const r = parseInt(hex.substring(0, 2), 16);
  const g = parseInt(hex.substring(2, 4), 16);
  const b = parseInt(hex.substring(4, 6), 16);

  // Return the RGB values
  return { r, g, b };
}

export async function matugen(
    type: "image" | "color" = "image",
    arg = wallpaper.wallpaper,
) {
    if (!options.autotheme.value || !dependencies("matugen"))
        return

    const colors = await sh(`matugen --dry-run -j hex ${type} ${arg}`)
    const c = JSON.parse(colors).colors as { light: Colors, dark: Colors }
    const { dark, light } = options.theme

    animate(
        () => {
            dark.widget.value = c.dark.on_surface
            light.widget.value = c.light.on_surface
        },
        () => {
            dark.border.value = c.dark.outline
            light.border.value = c.light.outline
        },
        () => {
            dark.bg.value = c.dark.surface
            light.bg.value = c.light.surface
        },
        () => {
            dark.fg.value = c.dark.on_surface
            light.fg.value = c.light.on_surface
        },
        () => {
            dark.primary.bg.value = c.dark.primary
            light.primary.bg.value = c.light.primary
            options.bar.battery.charging.value = options.theme.scheme.value === "dark"
                ? c.dark.primary : c.light.primary
        },
        () => {
            dark.primary.fg.value = c.dark.on_primary
            light.primary.fg.value = c.light.on_primary
        },
        () => {
            dark.error.bg.value = c.dark.error
            light.error.bg.value = c.light.error
        },
        () => {
            dark.error.fg.value = c.dark.on_error
            light.error.fg.value = c.light.on_error
        },
    )

    const primary = hexToRgb(c.dark.primary)
    const bg = hexToRgb(c.dark.surface)
    const fg = hexToRgb(c.dark.on_surface)

    const firefoxColor: FirefoxColor = {
        colors: {
            toolbar: bg,
            toolbar_text: {
                r: 255,
                g: 255,
                b: 255,
            },
            frame: bg,
            tab_background_text: {
                r: 215,
                g: 226,
                b: 239,
            },
            toolbar_field: bg,
            toolbar_field_text: fg,
            tab_line: primary,
            popup: bg,
            popup_text: fg,
        }
    }
    const jsonstring = JSON.stringify(firefoxColor).replace(/(["\\$`])/g, '\\$1')
    const out = await bash(`echo "${jsonstring}" | json2msgpack | lzma | basenc --base64url`)
    const url = out.replace(/\n/g, '')
    sh(`firefox https://color.firefox.com/?theme=${url}`)
    const bg_hex = c.dark.surface
    const fg_hex = c.dark.on_surface
    sh(`alacritty msg config \'colors.primary.background="${bg_hex}"\'`)
    sh(`alacritty msg config \'colors.primary.foreground="${fg_hex}"\'`)
}

interface FirefoxColor {
  colors?: {
    toolbar?: {r: number, g: number, b: number};
    toolbar_text?: {r: number, g: number, b: number};
    frame?: {r: number, g: number, b: number};
    tab_background_text?: {r: number, g: number, b: number};
    toolbar_field?: {r: number, g: number, b: number};
    toolbar_field_text?: {r: number, g: number, b: number};
    tab_line?: {r: number, g: number, b: number};
    popup?: {r: number, g: number, b: number};
    popup_text?: {r: number, g: number, b: number};
    images?: {
      additional_backgrounds: [];
      custom_backgrounds: [];
    }
    title: 004;
  };
}

type Colors = {
    background: string
    error: string
    error_container: string
    inverse_on_surface: string
    inverse_primary: string
    inverse_surface: string
    on_background: string
    on_error: string
    on_error_container: string
    on_primary: string
    on_primary_container: string
    on_primary_fixed: string
    on_primary_fixed_variant: string
    on_secondary: string
    on_secondary_container: string
    on_secondary_fixed: string
    on_secondary_fixed_variant: string
    on_surface: string
    on_surface_variant: string
    on_tertiary: string
    on_tertiary_container: string
    on_tertiary_fixed: string
    on_tertiary_fixed_variant: string
    outline: string
    outline_variant: string
    primary: string
    primary_container: string
    primary_fixed: string
    primary_fixed_dim: string
    scrim: string
    secondary: string
    secondary_container: string
    secondary_fixed: string
    secondary_fixed_dim: string
    shadow: string
    surface: string
    surface_bright: string
    surface_container: string
    surface_container_high: string
    surface_container_highest: string
    surface_container_low: string
    surface_container_lowest: string
    surface_dim: string
    surface_variant: string
    tertiary: string
    tertiary_container: string
    tertiary_fixed: string
    tertiary_fixed_dim: string
}
