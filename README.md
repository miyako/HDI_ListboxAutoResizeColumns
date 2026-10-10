![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# HDI_ListboxAutoResizeColumns

Automatic listbox column resizing, driven purely by the `resizingMode` form property. Originally published by 4D as a **HDI** (*How Do I*) example for **4D v16**; converted from the binary `.4DB` to the `.4DProject` architecture so it runs on current 4D releases.

## What it demonstrates

- The `resizingMode` listbox property, comparing `"legacy"` (last-column-grows, the pre-existing behaviour) against `"rightToLeft"` (columns are redistributed right-to-left within each column's `minWidth`/`maxWidth`).
- Two identically-laid-out listboxes on the same form page so the two modes can be resized side by side and compared directly.
- What happens at the extremes: once every column reaches its `maxWidth`, a filler column appears on the right; once every column reaches its `minWidth`, the horizontal scrollbar reappears.
- That auto-resizing only ever applies to resizable columns, and only while the horizontal scrollbar is inactive.
- A tab control whose first page shows the explanatory text (loaded from a localized `SAMPLES-{lang}.json`) and whose second page holds the two comparison listboxes.

## Key commands

| Command / property | Used for |
|---|---|
| `resizingMode: "legacy"` | `LB` (page "NOT activated") - only the last column grows on resize |
| `resizingMode: "rightToLeft"` | `LB1` (page "ACTIVATED") - columns are redistributed right-to-left per their `minWidth`/`maxWidth` |
| `JSON Parse` | Reading the localized `SAMPLES-en.json` / `SAMPLES-ja.json` explanatory text |
| `Folder` / `.file(...).getText()` | Loading the sample JSON from the resources folder |
| `ARRAY TEXT` | Backing the two listboxes' columns |

## How it works

`00_Start` opens the `HDI` splash form; its `BtnDemo` object method opens the demo form `HDI2`. `HDI2/method.4dm` runs on `On Load`: it reads the localized `SAMPLES-{lang}.json` file into a collection with `JSON Parse`, drops the first entry's text into the info page, and declares the five text arrays (`Column1`-`Column5`) that back both listboxes' columns.

The whole point of the demo lives in the form JSON, not in code: `LB` and `LB1` are laid out identically - same four columns, same `minWidth`/`maxWidth` per column - except `LB` sets `resizingMode: "legacy"` and `LB1` sets `resizingMode: "rightToLeft"`. Resize the window (or the listbox) and compare: `LB`'s columns stay fixed except the last one, while `LB1`'s columns redistribute proportionally within their configured min/max bounds.

## Points of interest

- The two listboxes are the *only* difference-under-test in this project - everything else (data, columns, layout) is intentionally identical, so resist the urge to "clean up" one without checking the other; a change to `LB1`'s `resizingMode` (as happened during a modernisation pass and was caught before merge) silently defeats the entire demo.
- `truncateMode: "none"` is set on every column/footer project-wide, independent of the `resizingMode` comparison - it stops macOS from ellipsis-truncating the middle of column text, which is unrelated to (and must not be confused with) the auto-resize behaviour under test.
- Both listboxes use a class-based odd-row fill (`hdi-list` in `styleSheets.css`) and `alternateFill: "automaticAlternate"` so the comparison still reads correctly in dark mode.
- Startup uses the modern splash pattern: window-reuse detection, `CALL WORKER`, non-blocking `DIALOG(...;*)`, and `Form.quit`/`BtnDemo` object method instead of interprocess variables and `QUIT 4D`.
- Full XLIFF localisation (English + Japanese) covers the menu, both forms' text/labels, and the listbox column headers.
- The macOS button (`BtnDemo`) is sized via `form-theme` CSS media queries (27px Liquid Glass / 23px classic) rather than a hardcoded `height`, so it stays correctly rounded under macOS Tahoe.

## Modernisation notes

Converted from the 4D v16 binary `.4DB` to the `.4DProject` architecture. This branch modernised the whole project in one pass.

| Branch | Description | Guidance |
|--------|-------------|----------|
| [`miyako-modernize-hdi-project`](../../tree/miyako-modernize-hdi-project) | Full modernisation: XLIFF localisation, `var`/`#DECLARE` syntax, standard menu actions, method visibility, a rebuilt startup dialog (window reuse, `CALL WORKER`, `BtnDemo` object method), dark mode/Liquid Glass CSS, and listbox `truncateMode`/`resizingMode` defaults (preserving `LB1`'s `rightToLeft` mode, the actual subject of the demo). | [`4dlocalise`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dlocalise), [`4dmodernise`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dmodernise), [`4dproject`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dproject), [`4dmethods`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dmethods), [`4dstartup`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dstartup), [hdi.startup.instructions.md](.github/instructions/hdi.startup.instructions.md), [`4dcss`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dcss), [`4dform`](https://github.com/miyako/skills/tree/main/4d-skills/skills/4dform) |

## References

- [4D blog: Listbox columns auto-resizing](https://blog.4d.com/listbox-columns-auto-resizing/)
- [Original download](https://download.4d.com/Demos/4D_v16/HDI_ListboxAutoResizeColumns.zip)
