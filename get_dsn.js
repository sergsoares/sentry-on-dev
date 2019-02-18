const puppeteer = require('puppeteer')
const screenshot = 'sentry.png';

const SENTRY_DOCKER_URL = 'http://sentry:9000'
const USERNAME_INPUT = '#id_username'
const PASSWORD_INPUT = '#id_password'
const LOGIN_BUTTON = '#login > form > fieldset > button'
const CONTINUE_CONFIG_BUTTON = '#blk_router > div > div.app > div.setup-wizard > form > div > button'

async function getSentryDsnText(page) {
    return await page.evaluate(() => document.querySelector('#blk_router > div > div.css-5omm91.e1krdl7w0 > div > div.css-u5z08j.ervyuv12 > div > div.css-vti0ei.ervyuv14 > div > div:nth-child(3) > div:nth-child(1) > div > div.box-clippable.clipped > div.css-wf6ctz > div:nth-child(1) > div > div > div.e78b1iv1.css-pno2s3 > div > div > input').value);
}

async function login(page) {
    await page.goto(`${SENTRY_DOCKER_URL}/settings/sentry/internal/keys/`)
    await page.type(USERNAME_INPUT, 'admin')
    await page.type(PASSWORD_INPUT, 'admin')
    await page.click(LOGIN_BUTTON)
    await page.waitForNavigation()
    await page.waitFor(3000)
}

async function clickContinue(page) {
    await page.click(CONTINUE_CONFIG_BUTTON)
    await page.waitFor(5000)
}

(async () => {
    console.log('Start extract SENTRY_DSN... ')
    const browser = await puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox'], headless: true})
    const page = await browser.newPage()

    console.log('Accessing Sentry... ')
    await login(page);

    console.log('Logged... ')
    const existsConfigButton = await page.$(CONTINUE_CONFIG_BUTTON)

    if(existsConfigButton) {
        await clickContinue(page);
    }

    console.log('Copying DSN... ')
    const text = await getSentryDsnText(page);

    // Screenshot for debug purpose.
    // await page.screenshot({ path: screenshot })
    browser.close()

    const DSN = 'http' + text
    console.log('')
    console.log('* * * * * * * * * * * * * *')
    console.log('')
    console.log('This is your Internal Sentry DSN (Development Purpose): ')
    console.log(DSN)
    console.log('')
    console.log('To use in laravel for example, put in your .env')
    console.log('SENTRY_DSN=' + DSN)
    console.log('')
    console.log('To access your events')
    console.log('http://localhost:7000/sentry/internal/')
})()

