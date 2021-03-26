Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEC34A315
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Mar 2021 09:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCZIRq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Mar 2021 04:17:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:20449 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhCZIRU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Mar 2021 04:17:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-244-6e-02qyoPCq7M0etr-m45Q-1; Fri, 26 Mar 2021 08:17:14 +0000
X-MC-Unique: 6e-02qyoPCq7M0etr-m45Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 26 Mar 2021 08:17:13 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Fri, 26 Mar 2021 08:17:13 +0000
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
Thread-Index: AQHXID829xNnc1F6eUqUVWy7MwUgYKqUt3Ig///6swCAACQV0IAAYGYAgAC28xA=
Date:   Fri, 26 Mar 2021 08:17:13 +0000
Message-ID: <e516146427db45439c02afe57ce06e97@AcuMS.aculab.com>
References: <20210323224858.GA293698@embeddedor>
 <629154ce566b4c9c9b7f4124b3260fc3@AcuMS.aculab.com>
 <5331b4e2-eeef-1c27-5efe-bf3986fd6683@embeddedor.com>
 <1efa90cc6bc24cfb860084e0b888cd4b@AcuMS.aculab.com>
 <e2e93993-e64b-ce7d-88cf-4c367b747e40@embeddedor.com>
In-Reply-To: <e2e93993-e64b-ce7d-88cf-4c367b747e40@embeddedor.com>
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

RnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiBTZW50OiAyNSBNYXJjaCAyMDIxIDIxOjEyDQo+
IA0KPiBPbiAzLzI1LzIxIDEwOjI5LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+IA0KPiA+Pj4NCj4g
Pj4+IENvdWxkIHlvdSB1c2UgdGhlIHNpbXBsZXI6DQo+ID4+Pj4gc3RydWN0IG5mc19maGJhc2Vf
bmV3IHsNCj4gPj4+PiAgICAgICAgICBfX3U4ICAgICAgIGZiX3ZlcnNpb247DQo+ID4+Pj4gICAg
ICAgICAgX191OCAgICAgICBmYl9hdXRoX3R5cGU7DQo+ID4+Pj4gICAgICAgICAgX191OCAgICAg
ICBmYl9mc2lkX3R5cGU7DQo+ID4+Pj4gICAgICAgICAgX191OCAgICAgICBmYl9maWxlaWRfdHlw
ZTsNCj4gPj4+PiAgICAgICAgICB1bmlvbiB7DQo+ID4+Pj4gICAgICAgICAgICAgICAgIF9fdTMy
ICAgICAgZmJfYXV0aFsxXTsNCj4gPj4+PiAgICAgICAgICAgICAgICAgX191MzIgICAgICBmYl9h
dXRoX2ZsZXhbMF07DQo+ID4+Pj4gICAgICAgICAgfTsNCj4gPj4+PiB9Ow0KPiA+Pj4NCj4gPj4+
IEFsdGhvdWdoIEknbSBub3QgY2VydGFpbiBmbGV4aWJsZSBhcnJheXMgYXJlIHN1cHBvcnRlZA0K
PiA+Pj4gYXMgdGhlIGxhc3QgZWxlbWVudCBvZiBhIHVuaW9uLg0KPiA+Pg0KPiA+PiBOb3BlOyB0
aGlzIGlzIG5vdCBhbGxvd2VkOiBodHRwczovL2dvZGJvbHQub3JnL3ovMTR2ZDRvOG5hDQo+ID4N
Cj4gPiBOb3RoaW5nIGFuIGV4dHJhICdzdHJ1Y3Qge19fdTMyIGZiX2F1dGhfZmxleFswXTsgfSc7
IHdvbid0IHNvbHZlLg0KPiANCj4gV2UgZG9uJ3Qgd2FudCB0byBpbnRyb2R1Y2UgemVyby1sZW5n
dGggYXJyYXlzIFsxXS4NCg0KSSBwcm9iYWJseSBtZWFudCB0byB3cml0ZSBbXSBub3QgWzBdIC0g
ZG9lc24ndCBhZmZlY3QgdGhlIGlkZWEuDQoNClRoZSByZWFsIHByb2JsZW0gaXMgdGhhdCB0aGUg
Y29tcGlsZXIgaXMgbGlrZWx5IHRvIHN0YXJ0IHJlamVjdGluZw0KcmVmZXJlbmNlcyB0byBhIGZs
ZXggYXJyYXkgdGhhdCBnbyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgb3V0ZXINCnN0cnVjdHVyZS4N
Cg0KVGhpbmtpbmcgYmFjaywgaXNuJ3QgZmJfYXV0aFtdIGF0IGxlYXN0IG9uZSBlbnRyeSBsb25n
Pw0KU28gaXQgY291bGQgYmU6DQoNCnN0cnVjdCBuZnNfZmhiYXNlX25ldyB7DQogICAgICAgICBf
X3U4ICAgICAgIGZiX3ZlcnNpb247DQogICAgICAgICBfX3U4ICAgICAgIGZiX2F1dGhfdHlwZTsN
CiAgICAgICAgIF9fdTggICAgICAgZmJfZnNpZF90eXBlOw0KICAgICAgICAgX191OCAgICAgICBm
Yl9maWxlaWRfdHlwZTsNCiAgICAgICAgIF9fdTMyICAgICAgZmJfYXV0aFsxXTsNCiAgICAgICAg
IF9fdTMyICAgICAgZmJfYXV0aF9leHRyYVtdOw0KfTsNCg0KKEkndmUgbWlzc2VkIHRoZSAwIG91
dCB0aGlzIHRpbWUuLi4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

