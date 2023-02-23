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

  Future init() async {
    _browser = await puppeteer.launch(devTools: true);
    _page = await _browser.newPage();
  }

  Future gotoUrl(String url) async => await _page.goto(url, wait: Until.domContentLoaded);

  Future clickButton(String selector) async {
    await _page.waitForSelector(selector);
    await _page.click(selector);
  }

  Future typeInput(String selector, String input) async {
    await _page.waitForSelector(selector);
    await _page.type(selector, input);
  }

  Future<T> getValue<T>(String selector) async {
    await _page.waitForSelector(selector);
    final value = await _page.evaluate<T>('() => document.querySelector(\'$selector\').innerHTML');
    return value;
  }

  Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));

  Future dispose() async {
    await _browser.close();
  }
}

class BrowserHandle {
  Future handle() async {
    final service = BrowserService();
    await service.init();

    try {
      await service.gotoUrl('https://mercatustecnologia.atlassian.net/issues/?jql=');

      await service.clickButton('.css-d4blq8 a');

      await service.typeInput('#username', ConfigurationRepository.get().userName);

      await service.clickButton('#login-submit');

      await service.delay(1);

      await service.typeInput('#password', ConfigurationRepository.get().passWord);

      await service.clickButton('#login-submit');

      await service.delay(5);

      await service.typeInput('#advanced-search', 'project = Desenvolvimento AND issuetype = Problema AND resolved >= 2023-02-01 AND resolved <= "2023-02-28 23:59" ORDER BY issuetype ASC');

      await service.clickButton('.search-button');

      await service.delay(5);

      // count processos erros
      final erros = await service.getValue('.results-count-total');

      await service.gotoUrl('https://mercatustecnologia.atlassian.net/issues/?jql=');

      await service.typeInput('#advanced-search', 'project = Desenvolvimento AND issuetype in (Novidade, Tarefa) AND resolved >= 2023-02-01 AND resolved <= "2023-02-28 23:59" ORDER BY issuetype ASC');

      await service.clickButton('.search-button');

      await service.delay(5);

      final novidades = await service.getValue('.results-count-total');

      print('Total erros: $erros, total novidades: $novidades');

      // await service.dispose();
    } catch (e) {}
  }
}
