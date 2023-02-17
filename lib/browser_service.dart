import 'package:indicadores_desenvolvimento/repositories/configuration_repository.dart';
import 'package:puppeteer/puppeteer.dart';

const buttonSelector = '.css-d4blq8 a';

class BrowserService {
  // var browser = await puppeteer.launch(devTools: true);
  // var page = await browser.newPage();
  //
  // await page.goto('https://developers.google.com/web/', wait: Until.networkIdle);
  // await page.type('.devsite-search-field', 'Headless Chrome');
  //
  // var allResultsSelector = '.devsite-suggest-all-results';
  // await page.waitForSelector(allResultsSelector);
  // await page.click(allResultsSelector);
  //
  // await browser.close();

  late Browser _browser;
  late Page _page;

  Future init(String url) async {
    _browser = await puppeteer.launch(devTools: true);
    _page = await _browser.newPage();
    await _page.goto(url, wait: Until.domContentLoaded);
  }

  Future clickButton(String selector) async {
    await _page.waitForSelector(selector);
    await _page.click(selector);
  }

  Future typeInput(String selector, String input, bool waitSelector) async {
    // await _page.$(selector);

    if (waitSelector) await _page.waitForSelector(selector);

    await _page.type(selector, input);
  }

  Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));

  Future dispose() async {
    await _browser.close();
  }
}

class BrowserHandle {
  Future handle(String url) async {
    // var browser = await service.getBrowser();

    final service = BrowserService();
    await service.init(url);

    try {
      await service.clickButton('.css-d4blq8 a');

      await service.typeInput('#username', ConfigurationRepository.get().userName, true);

      await service.clickButton('#login-submit');

      await service.delay(1);

      await service.typeInput('#password', ConfigurationRepository.get().passWord, true);

      await service.clickButton('#login-submit');

      // await service.dispose();
    } catch (_) {}
  }
}
