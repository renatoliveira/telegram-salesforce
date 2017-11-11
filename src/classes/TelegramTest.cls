//    MIT License
//
//    Copyright (c) 2017 Renato Oliveira
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
@IsTest
private class TelegramTest {
    static testMethod void test_sendMessage () {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TelegramCalloutMock());
        Telegram.sendMessage('test', '1234', '0000');
        Test.stopTest();
    }

    static testMethod void test_sendError () {
        TelegramBot__c bot_setting = new TelegramBot__c();
        bot_setting.Token__c = '1234';
        insert bot_setting;

        TelegramCredential__c credential = new TelegramCredential__c();
        credential.User__c = UserInfo.getUserId();
        credential.TelegramId__c = '0000';
        credential.ReceiveErrors__c = true;
        insert credential;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TelegramCalloutMock());
        Telegram.sendError('test');
        Test.stopTest();
    }
}