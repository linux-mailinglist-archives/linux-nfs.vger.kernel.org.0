Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6134956C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 16:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCYP3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 11:29:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53560 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhCYP3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 11:29:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-169-mYGlzNJePAKvQuQAqUb-SA-1; Thu, 25 Mar 2021 15:29:17 +0000
X-MC-Unique: mYGlzNJePAKvQuQAqUb-SA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 25 Mar 2021 15:29:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 25 Mar 2021 15:29:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Gustavo A. R. Silva'" <gustavo@embeddedor.com>,
        "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHXID829xNnc1F6eUqUVWy7MwUgYKqUt3Ig///6swCAACQV0A==
Date:   Thu, 25 Mar 2021 15:29:16 +0000
Message-ID: <1efa90cc6bc24cfb860084e0b888cd4b@AcuMS.aculab.com>
References: <20210323224858.GA293698@embeddedor>
 <629154ce566b4c9c9b7f4124b3260fc3@AcuMS.aculab.com>
 <5331b4e2-eeef-1c27-5efe-bf3986fd6683@embeddedor.com>
In-Reply-To: <5331b4e2-eeef-1c27-5efe-bf3986fd6683@embeddedor.com>
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

RnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiBTZW50OiAyNSBNYXJjaCAyMDIxIDEzOjE4DQo+
IA0KPiBPbiAzLzI1LzIxIDA4OjQ1LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogR3Vz
dGF2byBBLiBSLiBTaWx2YQ0KPiA+PiBTZW50OiAyMyBNYXJjaCAyMDIxIDIyOjQ5DQo+ID4+DQo+
ID4+IFRoZXJlIGlzIGEgcmVndWxhciBuZWVkIGluIHRoZSBrZXJuZWwgdG8gcHJvdmlkZSBhIHdh
eSB0byBkZWNsYXJlIGhhdmluZw0KPiA+PiBhIGR5bmFtaWNhbGx5IHNpemVkIHNldCBvZiB0cmFp
bGluZyBlbGVtZW50cyBpbiBhIHN0cnVjdHVyZS4gS2VybmVsIGNvZGUNCj4gPj4gc2hvdWxkIGFs
d2F5cyB1c2Ug4oCcZmxleGlibGUgYXJyYXkgbWVtYmVyc+KAnVsxXSBmb3IgdGhlc2UgY2FzZXMu
IFRoZSBvbGRlcg0KPiA+PiBzdHlsZSBvZiBvbmUtZWxlbWVudCBvciB6ZXJvLWxlbmd0aCBhcnJh
eXMgc2hvdWxkIG5vIGxvbmdlciBiZSB1c2VkWzJdLg0KPiA+Pg0KPiA+PiBVc2UgYW4gYW5vbnlt
b3VzIHVuaW9uIHdpdGggYSBjb3VwbGUgb2YgYW5vbnltb3VzIHN0cnVjdHMgaW4gb3JkZXIgdG8N
Cj4gPj4ga2VlcCB1c2Vyc3BhY2UgdW5jaGFuZ2VkOg0KPiA+Pg0KPiA+PiAkIHBhaG9sZSAtQyBu
ZnNfZmhiYXNlX25ldyBmcy9uZnNkL25mc2ZoLm8NCj4gPj4gc3RydWN0IG5mc19maGJhc2VfbmV3
IHsNCj4gPj4gICAgICAgICB1bmlvbiB7DQo+ID4+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgew0K
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBfX3U4ICAgICAgIGZiX3ZlcnNpb25fYXV4OyAg
ICAgICAvKiAgICAgMCAgICAgMSAqLw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBfX3U4
ICAgICAgIGZiX2F1dGhfdHlwZV9hdXg7ICAgICAvKiAgICAgMSAgICAgMSAqLw0KPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICBfX3U4ICAgICAgIGZiX2ZzaWRfdHlwZV9hdXg7ICAgICAvKiAg
ICAgMiAgICAgMSAqLw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBfX3U4ICAgICAgIGZi
X2ZpbGVpZF90eXBlX2F1eDsgICAvKiAgICAgMyAgICAgMSAqLw0KPiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICBfX3UzMiAgICAgIGZiX2F1dGhbMV07ICAgICAgICAgICAvKiAgICAgNCAgICAg
NCAqLw0KPiA+PiAgICAgICAgICAgICAgICAgfTsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiAgICAgMCAgICAgOCAqLw0KPiA+PiAgICAgICAgICAgICAgICAgc3RydWN0
IHsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgX191OCAgICAgICBmYl92ZXJzaW9uOyAg
ICAgICAgICAgLyogICAgIDAgICAgIDEgKi8NCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAg
X191OCAgICAgICBmYl9hdXRoX3R5cGU7ICAgICAgICAgLyogICAgIDEgICAgIDEgKi8NCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgX191OCAgICAgICBmYl9mc2lkX3R5cGU7ICAgICAgICAg
LyogICAgIDIgICAgIDEgKi8NCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgX191OCAgICAg
ICBmYl9maWxlaWRfdHlwZTsgICAgICAgLyogICAgIDMgICAgIDEgKi8NCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgX191MzIgICAgICBmYl9hdXRoX2ZsZXhbMF07ICAgICAgLyogICAgIDQg
ICAgIDAgKi8NCj4gPj4gICAgICAgICAgICAgICAgIH07ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDQgKi8NCj4gPj4gICAgICAgICB9OyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDggKi8N
Cj4gPj4NCj4gPj4gICAgICAgICAvKiBzaXplOiA4LCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiAx
ICovDQo+ID4+ICAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6IDggYnl0ZXMgKi8NCj4gPj4gfTsN
Cj4gPg0KPiA+IENvdWxkIHlvdSB1c2UgdGhlIHNpbXBsZXI6DQo+ID4+IHN0cnVjdCBuZnNfZmhi
YXNlX25ldyB7DQo+ID4+ICAgICAgICAgIF9fdTggICAgICAgZmJfdmVyc2lvbjsNCj4gPj4gICAg
ICAgICAgX191OCAgICAgICBmYl9hdXRoX3R5cGU7DQo+ID4+ICAgICAgICAgIF9fdTggICAgICAg
ZmJfZnNpZF90eXBlOw0KPiA+PiAgICAgICAgICBfX3U4ICAgICAgIGZiX2ZpbGVpZF90eXBlOw0K
PiA+PiAgICAgICAgICB1bmlvbiB7DQo+ID4+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAgIGZi
X2F1dGhbMV07DQo+ID4+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAgIGZiX2F1dGhfZmxleFsw
XTsNCj4gPj4gICAgICAgICAgfTsNCj4gPj4gfTsNCj4gPg0KPiA+IEFsdGhvdWdoIEknbSBub3Qg
Y2VydGFpbiBmbGV4aWJsZSBhcnJheXMgYXJlIHN1cHBvcnRlZA0KPiA+IGFzIHRoZSBsYXN0IGVs
ZW1lbnQgb2YgYSB1bmlvbi4NCj4gDQo+IE5vcGU7IHRoaXMgaXMgbm90IGFsbG93ZWQ6IGh0dHBz
Oi8vZ29kYm9sdC5vcmcvei8xNHZkNG84bmENCg0KTm90aGluZyBhbiBleHRyYSAnc3RydWN0IHtf
X3UzMiBmYl9hdXRoX2ZsZXhbMF07IH0nOyB3b24ndCBzb2x2ZS4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

