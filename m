Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB391349353
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 14:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCYNvx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 09:51:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30794 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231182AbhCYNvg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 09:51:36 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 09:51:34 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-SGVHtB3kMiW7IbuAL5VZgw-1; Thu, 25 Mar 2021 13:45:17 +0000
X-MC-Unique: SGVHtB3kMiW7IbuAL5VZgw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 25 Mar 2021 13:45:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 25 Mar 2021 13:45:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHXID829xNnc1F6eUqUVWy7MwUgYKqUt3Ig
Date:   Thu, 25 Mar 2021 13:45:16 +0000
Message-ID: <629154ce566b4c9c9b7f4124b3260fc3@AcuMS.aculab.com>
References: <20210323224858.GA293698@embeddedor>
In-Reply-To: <20210323224858.GA293698@embeddedor>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiBTZW50OiAyMyBNYXJjaCAyMDIxIDIyOjQ5DQo+
IA0KPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0aGUga2VybmVsIHRvIHByb3ZpZGUgYSB3
YXkgdG8gZGVjbGFyZSBoYXZpbmcNCj4gYSBkeW5hbWljYWxseSBzaXplZCBzZXQgb2YgdHJhaWxp
bmcgZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuIEtlcm5lbCBjb2RlDQo+IHNob3VsZCBhbHdheXMg
dXNlIOKAnGZsZXhpYmxlIGFycmF5IG1lbWJlcnPigJ1bMV0gZm9yIHRoZXNlIGNhc2VzLiBUaGUg
b2xkZXINCj4gc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVyby1sZW5ndGggYXJyYXlzIHNob3Vs
ZCBubyBsb25nZXIgYmUgdXNlZFsyXS4NCj4gDQo+IFVzZSBhbiBhbm9ueW1vdXMgdW5pb24gd2l0
aCBhIGNvdXBsZSBvZiBhbm9ueW1vdXMgc3RydWN0cyBpbiBvcmRlciB0bw0KPiBrZWVwIHVzZXJz
cGFjZSB1bmNoYW5nZWQ6DQo+IA0KPiAkIHBhaG9sZSAtQyBuZnNfZmhiYXNlX25ldyBmcy9uZnNk
L25mc2ZoLm8NCj4gc3RydWN0IG5mc19maGJhc2VfbmV3IHsNCj4gICAgICAgICB1bmlvbiB7DQo+
ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBfX3U4
ICAgICAgIGZiX3ZlcnNpb25fYXV4OyAgICAgICAvKiAgICAgMCAgICAgMSAqLw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBfX3U4ICAgICAgIGZiX2F1dGhfdHlwZV9hdXg7ICAgICAvKiAgICAg
MSAgICAgMSAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBfX3U4ICAgICAgIGZiX2ZzaWRf
dHlwZV9hdXg7ICAgICAvKiAgICAgMiAgICAgMSAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBfX3U4ICAgICAgIGZiX2ZpbGVpZF90eXBlX2F1eDsgICAvKiAgICAgMyAgICAgMSAqLw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBfX3UzMiAgICAgIGZiX2F1dGhbMV07ICAgICAgICAgICAv
KiAgICAgNCAgICAgNCAqLw0KPiAgICAgICAgICAgICAgICAgfTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiAgICAgMCAgICAgOCAqLw0KPiAgICAgICAgICAgICAgICAg
c3RydWN0IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX191OCAgICAgICBmYl92ZXJzaW9u
OyAgICAgICAgICAgLyogICAgIDAgICAgIDEgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
X191OCAgICAgICBmYl9hdXRoX3R5cGU7ICAgICAgICAgLyogICAgIDEgICAgIDEgKi8NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgX191OCAgICAgICBmYl9mc2lkX3R5cGU7ICAgICAgICAgLyog
ICAgIDIgICAgIDEgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgX191OCAgICAgICBmYl9m
aWxlaWRfdHlwZTsgICAgICAgLyogICAgIDMgICAgIDEgKi8NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgX191MzIgICAgICBmYl9hdXRoX2ZsZXhbMF07ICAgICAgLyogICAgIDQgICAgIDAgKi8N
Cj4gICAgICAgICAgICAgICAgIH07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogICAgIDAgICAgIDQgKi8NCj4gICAgICAgICB9OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDggKi8NCj4gDQo+ICAgICAgICAg
Lyogc2l6ZTogOCwgY2FjaGVsaW5lczogMSwgbWVtYmVyczogMSAqLw0KPiAgICAgICAgIC8qIGxh
c3QgY2FjaGVsaW5lOiA4IGJ5dGVzICovDQo+IH07DQoNCkNvdWxkIHlvdSB1c2UgdGhlIHNpbXBs
ZXI6DQo+IHN0cnVjdCBuZnNfZmhiYXNlX25ldyB7DQo+ICAgICAgICAgIF9fdTggICAgICAgZmJf
dmVyc2lvbjsNCj4gICAgICAgICAgX191OCAgICAgICBmYl9hdXRoX3R5cGU7DQo+ICAgICAgICAg
IF9fdTggICAgICAgZmJfZnNpZF90eXBlOw0KPiAgICAgICAgICBfX3U4ICAgICAgIGZiX2ZpbGVp
ZF90eXBlOw0KPiAgICAgICAgICB1bmlvbiB7DQo+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAg
IGZiX2F1dGhbMV07DQo+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAgIGZiX2F1dGhfZmxleFsw
XTsNCj4gICAgICAgICAgfTsNCj4gfTsNCg0KQWx0aG91Z2ggSSdtIG5vdCBjZXJ0YWluIGZsZXhp
YmxlIGFycmF5cyBhcmUgc3VwcG9ydGVkDQphcyB0aGUgbGFzdCBlbGVtZW50IG9mIGEgdW5pb24u
DQpZb3UgbWlnaHQgbmVlZCB0byB1c2UgYSBuYW1lZCBhbm9ueW1vdXMgc3RydWN0dXJlIGZvciB0
aGUNCmZvdXIgX191OCBmaWVsZHMgYW5kIGNyZWF0ZSB0d28gZGlmZmVyZW50IHN0cnVjdHVyZXMg
dGhhdA0KaW5jbHVkZSB0aGUgZXh0cmEgZmllbGQgb24gdGhlIGVuZC4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

