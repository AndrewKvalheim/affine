#!/usr/bin/env node

import puppeteer from "puppeteer";
import { pathToFileURL } from "url";

const [source, destination] = process.argv.slice(2);

const browser = await puppeteer.launch();
const page = await browser.newPage();

await page.emulateMediaType("print");
await page.setViewport({ deviceScaleFactor: 2, width: 576, height: 324 });
await page.goto(pathToFileURL(source));
await page.screenshot({ fullPage: true, path: destination });

await browser.close();
