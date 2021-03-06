# toggle-spec.vim
Quickly jump to spec file from your source.

## Introduction

**Toggle Spec** is a pure vimscript plug-in which allows you to quickly open the test file of the current buffer. It works with any extension, and supports both `.spec.` and `.test.` naming conventions.

Toggle Spec will recursively search for files within your entire project, by using your `.git` folder as the project root.

## Usage

To switch to the spec of the current buffer, use the `:Spec` command.

For example, from within `component.js`, running `:Spec` will attempt to switch to either `component.spec.js` or `component.test.js`.

## Limitations

Toggle Spec currently only works within Git projects.

## License

[MIT](LICENSE)

Based on original [code](https://vi.stackexchange.com/a/24682/28745) by Andy Massimino.
