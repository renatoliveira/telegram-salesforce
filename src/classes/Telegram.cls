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
global class Telegram {
    /**
     * Send a message to a specific user using a bot.
     *
     * @param message Message to send
     * @param bot_token Telegram Bot API Token
     * @param telegram_id Telegram's Chat Identifier
     */
    @future(callout=true)
    global static void sendMessage (String message, String bot_token, String telegram_id) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.telegram.org/bot' + bot_token + '/sendMessage');
        req.setMethod('POST');
        req.setHeader('content-type', 'application/json');
        req.setBody('{"chat_id" : "' + telegram_id + '", "text" : "' + message + '"}');
        Http http = new Http();
        HttpResponse res = http.send(req);
    }

    /**
     * Send an error message to all assigned users to receive it.
     *
     * TODO:
     * Check how many can receive at once. At the moment, tested with 6 messages being sent at
     * the same time, and it worked, but might fail if there are too many users (10+ maybe?).
     *
     * @param message
     */
    global static void sendError (String message) {
        String request_body = '';
        String bot_token = TelegramBot__c.getOrgDefaults().Token__c;
        List<TelegramCredential__c> users= [SELECT
            TelegramId__c
            FROM TelegramCredential__c
            WHERE ReceiveErrors__c = true];
        for (TelegramCredential__c user : users) {
            sendMessage(message, bot_token, user.TelegramId__c);
        }
    }
}