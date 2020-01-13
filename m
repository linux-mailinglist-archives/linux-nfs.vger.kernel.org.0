Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36F4138945
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 02:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgAMBeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jan 2020 20:34:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25426 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732442AbgAMBeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jan 2020 20:34:00 -0500
X-IronPort-AV: E=Sophos;i="5.69,427,1571673600"; 
   d="scan'208";a="81705970"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Jan 2020 09:33:57 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F13B14CE1A00;
        Mon, 13 Jan 2020 09:24:50 +0800 (CST)
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 13 Jan 2020 09:33:57 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::4049:4fec:8ba2:a0e4])
 by G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::4049:4fec:8ba2:a0e4%14]) with
 mapi id 15.00.1395.000; Mon, 13 Jan 2020 09:33:57 +0800
From:   "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
To:     "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dang@redhat.com" <dang@redhat.com>,
        "calum.mackay@oracle.com" <calum.mackay@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Thread-Topic: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in
 5.2.0-rc7
Thread-Index: AdXJsIQXuaZ2SnxFRGWSi1yoPcHO9w==
Date:   Mon, 13 Jan 2020 01:33:57 +0000
Message-ID: <6022b73b087d476f94f591292fdab933@G08CNEXMBPEKD05.g08.fujitsu.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.226.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: F13B14CE1A00.AD447
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

QW55IHBpbmc/DQoNCtTaIDIwMTkvOC82IDE2OjIzLCBTdSBZYW5qdW4g0LS1
wDoNCj4gSGksIEZyYW5rDQo+DQo+IFdlIG1vZGlmaWVkIHRoZSBjYXNlIGFj
Y29yZGluZyB0byBDYWx1bSBNYWNrYXkncyBzdWdnZXN0aW9uIChzZXQgdGhl
IHBhcmFtZXRlciBsa19pc19uZXcgaW4gdGhlIHNlY29uZCBsb2NrIHRvIEZB
TFNFKQ0KPg0KPiBhbmQgdGhlIHRlc3QgcmVzdWx0IHBhc3NlZC4NCj4NCj4g
QnV0IHdlIGRvbid0IGtub3cgaWYgdGhpcyBtb2RpZmljYXRpb24gdmlvbGF0
ZXMgdGhlIHRlc3QgaW50ZW50Lg0KPg0KPiBDYW4geW91IHRlbGwgdXMgeW91
ciB0ZXN0IGludGVudD8NCj4NCj4gQmVjYXVzZSBvdXIgZW1haWwgc3lzdGVt
IGhhcyBzb21lIHByb2JsZW0gIHNvIGkgY29weSBDYWx1bSBNYWNrYXkncyBy
ZXBseSBoZXJlLg0KPg0KPiBGcm9tOiBDYWx1bSBNYWNrYXkgQCAyMDE5LTA3
LTI5IDEzOjEyIFVUQyAocGVybWFsaW5rIC8gcmF3KQ0KPiAgIFRvOiBTdSBZ
YW5qdW4sIEouIEJydWNlIEZpZWxkczsgK0NjOiBjYWx1bS5tYWNrYXksIGxp
bnV4LW5mcywgZGFuZywgZmZpbHpsbngNCj4NCj4gaGksIEkgZG9uJ3QgdGhp
bmsgeW91IHdvdWxkIGV4cGVjdCBhbiB1bmxvY2sgdG8gZGVsZXRlIHRoZSBs
b2NrIG93bmVyOg0KPiB0aGUgY2xpZW50IG1heSB3YW50IHRvIGRvIGZ1cnRo
ZXIgbG9ja2luZyB3aXRoIHRoaXMgbG9jayBvd25lciAod2l0aG91dA0KPiB0
aGUgbGtfaXNfbmV3IGJpdCBzZXQpLg0KPg0KPiBUaGUgc2VydmVyIHdvdWxk
IGRlbGV0ZSB0aGUgTE8gd2hlbiB0aGUgY2xpZW50IHNlbmRzIGENCj4gUkVM
RUFTRV9MT0NLT1dORVIsIG9yIHdoZW4gdGhlIGxlYXNlIGlzIGV4cGlyZWQs
IGlmIGl0IGRvZXNuJ3QuDQo+DQo+IGNoZWVycywNCj4gY2FsdW0uDQo+DQo+
INTaIDIwMTkvNy85IDEzOjI3LCBTdSBZYW5qdW4g0LS1wDoNCj4+IEhpIEJy
dWNlDQo+Pg0KPj4g1NogMjAxOS83LzggMjI6NDUsIEZyYW5rIEZpbHog0LS1
wDoNCj4+PiBZZWEsIHNvcnJ5LCBJIHRvdGFsbHkgbWlzc2VkIHRoaXMsIGJ1
dCBpdCBkb2VzIGxvb2sgbGlrZSBpdCdzIGEgS2VybmVsIG5mc2QgDQo+PiBB
bnkgc3VnZ2VzdGlvbnM/DQo+Pj4gaXNzdWUuDQo+Pj4NCj4+PiBGcmFuaw0K
Pj4+DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZy
b206IERhbmllbCBHcnluaWV3aWN6IFttYWlsdG86ZGFuZ0ByZWRoYXQuY29t
XQ0KPj4+PiBTZW50OiBNb25kYXksIEp1bHkgOCwgMjAxOSA2OjQ5IEFNDQo+
Pj4+IFRvOiBTdSBZYW5qdW4gPHN1eWouZm5zdEBjbi5mdWppdHN1LmNvbT47
IGZmaWx6bG54QG1pbmRzcHJpbmcuY29tDQo+Pj4+IENjOiBsaW51eC1uZnNA
dmdlci5rZXJuZWwub3JnDQo+Pj4+IFN1YmplY3Q6IFJlOiBbUHJvYmxlbV10
ZXN0T3BlblVwZ3JhZGVMb2NrIHRlc3QgZmFpbGVkIGluIG5mc3Y0LjAgaW4N
Cj4+Pj4gNS4yLjAtcmM3DQo+Pj4+DQo+Pj4+IElzIHRoaXMgcnVubmluZyBr
bmZzZCBvciBHYW5lc2hhIGFzIHRoZSBzZXJ2ZXI/ICBJZiBpdCdzIEdhbmVz
aGEsIHRoZQ0KPj4+PiBxdWVzdGlvbg0KPj4+PiB3b3VsZCBiZSBiZXR0ZXIg
YXNrZWQgb24gdGhlIEdhbmVzaGEgRGV2ZWwgbGlzdA0KPj4+PiBkZXZlbEBs
aXN0cy5uZnMtZ2FuZXNoYS5vcmcNCj4+Pj4NCj4+Pj4gSWYgaXQncyBrbmZz
ZCwgdGhhbiBGcmFuayBpc24ndCB0aGUgcmlnaHQgcGVyc29uIHRvIGFzay4g
DQo+PiBXZSBhcmUgdXNpbmcgdGhlIGtuZnNkLg0KPj4+Pg0KPj4+PiBEYW5p
ZWwNCj4+Pj4NCj4+Pj4gT24gNy83LzE5IDEwOjIwIFBNLCBTdSBZYW5qdW4g
d3JvdGU6DQo+Pj4+PiBBbmcgcGluZz8NCj4+Pj4+DQo+Pj4+PiDU2iAyMDE5
LzcvMyA5OjM0LCBTdSBZYW5qdW4g0LS1wDoNCj4+Pj4+PiBIaSBGcmFuaw0K
Pj4+Pj4+DQo+Pj4+Pj4gV2UgdGVzdGVkIHRoZSBweW5mcyBvZiBORlN2NC4w
IG9uIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB0aGUga2VybmVsDQo+Pj4+Pj4g
KDUuMi4wLXJjNykuDQo+Pj4+Pj4gSSBlbmNvdW50ZXJlZCBhIHByb2JsZW0g
d2hpbGUgdGVzdGluZyBzdF9sb2NrLnRlc3RPcGVuVXBncmFkZUxvY2suDQo+
Pj4+Pj4gVGhlIHByb2JsZW0gaXMgbm93IGFzIGZvbGxvd3M6DQo+Pj4+Pj4g
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioNCj4+Pj4+PiBMT0NLMjQgc3RfbG9jay50ZXN0T3BlblVwZ3JhZGVM
b2NrIDogRkFJTFVSRQ0KPj4+Pj4+ICAgICAgICAgICAgIE9QX0xPQ0sgc2hv
dWxkIHJldHVybiBORlM0X09LLCBpbnN0ZWFkIGdvdA0KPj4+Pj4+ICAgICAg
ICAgICAgIE5GUzRFUlJfQkFEX1NFUUlEDQo+Pj4+Pj4gKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4+Pj4+
PiBJcyB0aGlzIG5vcm1hbD8NCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBjYXNlIGlz
IGFzIGZvbGxvd3M6DQo+Pj4+Pj4gRGVmIHRlc3RPcGVuVXBncmFkZUxvY2so
dCwgZW52KToNCj4+Pj4+PiAgICAgICIiIlRyeSBvcGVuLCBsb2NrLCBvcGVu
LCBkb3duZ3JhZGUsIGNsb3NlDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgIEZMQUdT
OiBhbGwgbG9jaw0KPj4+Pj4+ICAgICAgQ09ERTogTE9DSzI0DQo+Pj4+Pj4g
ICAgICAiIiINCj4+Pj4+PiAgICAgIGM9IGVudi5jMQ0KPj4+Pj4+ICAgICAg
Qy5pbml0X2Nvbm5lY3Rpb24oKQ0KPj4+Pj4+ICAgICAgT3MgPSBvcGVuX3Nl
cXVlbmNlKGMsIHQuY29kZSwgbG9ja293bmVyPSJsb2Nrb3duZXJfTE9DSzI0
IikNCj4+Pj4+PiAgICAgIE9zLm9wZW4oT1BFTjRfU0hBUkVfQUNDRVNTX1JF
QUQpDQo+Pj4+Pj4gICAgICBPcy5sb2NrKFJFQURfTFQpDQo+Pj4+Pj4gICAg
ICBPcy5vcGVuKE9QRU40X1NIQVJFX0FDQ0VTU19XUklURSkNCj4+Pj4+PiAg
ICAgIE9zLnVubG9jaygpDQo+Pj4+Pj4gICAgICBPcy5kb3duZ3JhZGUoT1BF
TjRfU0hBUkVfQUNDRVNTX1dSSVRFKQ0KPj4+Pj4+ICAgICAgT3MubG9jayhX
UklURV9MVCkNCj4+Pj4+PiAgICAgIE9zLmNsb3NlKCkNCj4+Pj4+Pg0KPj4+
Pj4+IEFmdGVyIGludmVzdGlnYXRpb24sIHRoZXJlIHdhcyBhbiBlcnJvciBp
biB1bmxvY2stPmxvY2suIFdoZW4NCj4+Pj4+PiB1bmxvY2tpbmcsIHRoZSBs
b2Nrb3duZXIgb2YgdGhlIGZpbGUgd2FzIG5vdCByZWxlYXNlZCwgY2F1c2lu
ZyBhbg0KPj4+Pj4+IGVycm9yIHdoZW4gbG9ja2luZyBhZ2Fpbi4NCj4+Pj4+
PiBXaWxsIG5mczQuMCBzdXBwb3J0IDEpIG9wZW4tPiAyKSBsb2NrLT4gMykg
dW5sb2NrLT4gNCkgbG9jayB0aGlzDQo+Pj4+Pj4gZnVuY3Rpb24/DQo+Pj4+
Pj4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+DQo+Pj4NCj4+DQo+Pg0K
Pg0KPg0KCgo=
