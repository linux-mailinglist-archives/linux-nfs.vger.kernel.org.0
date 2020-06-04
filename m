Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDA1EDA8E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 03:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgFDBmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jun 2020 21:42:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24433 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbgFDBmA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jun 2020 21:42:00 -0400
X-IronPort-AV: E=Sophos;i="5.73,470,1583164800"; 
   d="scan'208";a="93797075"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2020 09:41:57 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EA3F24BCC8BC;
        Thu,  4 Jun 2020 09:41:56 +0800 (CST)
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 4 Jun 2020 09:41:58 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::90ed:382f:828d:5124])
 by G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::90ed:382f:828d:5124%14]) with
 mapi id 15.00.1497.006; Thu, 4 Jun 2020 09:41:57 +0800
From:   "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
To:     "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dang@redhat.com" <dang@redhat.com>,
        "calum.mackay@oracle.com" <calum.mackay@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Thread-Topic: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Thread-Index: AdY6EQgccjAJRQM6T5aGDF3NhcIYxQ==
Date:   Thu, 4 Jun 2020 01:41:57 +0000
Message-ID: <3de3748749ea47398f5dc4ab0abbebfa@G08CNEXMBPEKD05.g08.fujitsu.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.226.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: EA3F24BCC8BC.AEF8A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

QW55IHBpbmc/DQoNCj5IaSBGcmFuaw0KDQo+V2UgaGF2ZW4ndCBjb250YWN0
ZWQgZm9yIGEgbG9uZyB0aW1lLiBMZXQncyBzb3J0IG91dCB0aGUgcHJvYmxl
bS4gVGhlIGRldGFpbHMgYXJlIGFzIGZvbGxvd3M6DQoNCj5XZSB0ZXN0ZWQg
dGhlIHB5bmZzIG9mIE5GU3Y0LjAgb24gdGhlIGxhdGVzdCB2ZXJzaW9uIG9m
IHRoZSBrZXJuZWwoNS4yLjAtcmM3KS4NCj5JIGVuY291bnRlcmVkIGEgcHJv
YmxlbSB3aGlsZSB0ZXN0aW5nIHN0X2xvY2sudGVzdE9wZW5VcGdyYWRlTG9j
ay4NCj5UaGUgcHJvYmxlbSBpcyBub3cgYXMgZm9sbG93czoNCj4qKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0K
PkxPQ0syNCBzdF9sb2NrLnRlc3RPcGVuVXBncmFkZUxvY2sgOiBGQUlMVVJF
DQo+ICAgICAgICAgICAgT1BfTE9DSyBzaG91bGQgcmV0dXJuIE5GUzRfT0ss
IGluc3RlYWQgZ290DQo+ICAgICAgICAgICAgTkZTNEVSUl9CQURfU0VRSUQN
Cj4qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKg0KDQo+VGhlIGNhc2UgaXMgYXMgZm9sbG93czoNCj5EZWYgdGVz
dE9wZW5VcGdyYWRlTG9jayh0LCBlbnYpOg0KPiAgICAgIiIiVHJ5IG9wZW4s
IGxvY2ssIG9wZW4sIGRvd25ncmFkZSwgY2xvc2UNCj4NCj4gICAgIEZMQUdT
OiBhbGwgbG9jaw0KPiAgICAgQ09ERTogTE9DSzI0DQo+ICAgICAiIiINCj4g
ICAgIGM9IGVudi5jMQ0KPiAgICAgQy5pbml0X2Nvbm5lY3Rpb24oKQ0KPiAg
ICAgT3MgPSBvcGVuX3NlcXVlbmNlKGMsIHQuY29kZSwgbG9ja293bmVyPSJs
b2Nrb3duZXJfTE9DSzI0IikNCj4gICAgIE9zLm9wZW4oT1BFTjRfU0hBUkVf
QUNDRVNTX1JFQUQpDQo+ICAgICBPcy5sb2NrKFJFQURfTFQpDQo+ICAgICBP
cy5vcGVuKE9QRU40X1NIQVJFX0FDQ0VTU19XUklURSkNCj4gICAgIE9zLnVu
bG9jaygpDQo+ICAgICBPcy5kb3duZ3JhZGUoT1BFTjRfU0hBUkVfQUNDRVNT
X1dSSVRFKQ0KPiAgICAgT3MubG9jayhXUklURV9MVCkNCj4gICAgIE9zLmNs
b3NlKCkNCg0KPkFmdGVyIGludmVzdGlnYXRpb24sIHRoZXJlIHdhcyBhbiBl
cnJvciBpbiB1bmxvY2stPmxvY2suIFdoZW4gdW5sb2NraW5nLCB0aGUgbG9j
a293bmVyIG9mIHRoZSBmaWxlIHdhcyBub3QgcmVsZWFzZWQsIGNhdXNpbmcg
YW4gZXJyb3Igd2hlbiBsb2NraW5nIGFnYWluLg0KDQo+V2UgbW9kaWZpZWQg
dGhlIGNhc2UgYWNjb3JkaW5nIHRvIENhbHVtIE1hY2theSdzIHN1Z2dlc3Rp
b24gKHNldCB0aGUgcGFyYW1ldGVyIGxrX2lzX25ldyBpbiB0aGUgc2Vjb25k
IGxvY2sgdG8gRkFMU0UpIGFuZCB0aGUgdGVzdCByZXN1bHQgcGFzc2VkLg0K
PkNhbiB5b3UgdGVsbCBtZSBpZiB0aGlzIG1vZGlmaWNhdGlvbiBpcyBjb3Jy
ZWN0o78NCg0KPkFuZCB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBpcyBoZXJl
Lg0KPmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW5mcy9t
c2c3NjA2MS5odG1sDQoNCgoK
