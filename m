Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870663E86EA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhHKAB5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 20:01:57 -0400
Received: from mail-dm6nam10on2137.outbound.protection.outlook.com ([40.107.93.137]:24568
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234289AbhHKAB4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 20:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKA73IiXGJmEy8dYIzeHOx1tHMNU13XOu/lRRh1gPFS3QuGiPgpScleYb6xI5o1rADToMV7OE6+unDzL/HKp+8NfWsZfKM7uotqzlMMaOvHd9EmyuFK4gX5xUQVDtim+bKCRIWRzDNgBJU2EAT/bXvmQ5rtjEeH87SWph8vA+ifkOSnA/k2jxYYm77bjrA+AXrz3SWerTTRaZ9F2VJTvKbME8zc8Rbs7HNYIQMTqWRcM5+HZ5e41NGUx8/oEse088VQv7TGTOCM7RGUlNcg1HkZulIJ5OXjB0QMj0VnPylWFqnbzUAygqzUwncF/xw8CYXHYtykpy1LSd9aDt4h5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjHaTVShTI+GlL3PToSZdTdcQ8FTzH4Ay2qD1clKhoA=;
 b=fGBE1tKUohuUcVeWXqG1MDtu25NxofLblhmRF8xVLmK6KvesYnH8yN0RzH+zGHWz6nDsmKuKqNWDcjJPhXLw7uOX6Z9UBUQgZe+/c/3HWKQu4mK1/t4V6tVRK/S5r5eltcycgy9vw3ZVSbjf8P2bg6E1iNupHYzKdI/oxudYE7lSWS7YYLAEFdvUAcmyhc0tcMkWOw5R9X+Iv8rRzUpKFphRQRpt792/TAAnNV13FqyzUb1h1H9yKmlY0meP/gEkKY4OBxAOgWHNNj+XhBqu5+qoX03VRjEifhxblYse9MdNP9TaI7U0V7NxDpmwZ0/9zYKdBGIWFjHHNCgkqzf4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjHaTVShTI+GlL3PToSZdTdcQ8FTzH4Ay2qD1clKhoA=;
 b=e0aH/y++k8IH7GWe/BSUN35NqilFsdBfl/vCDCBna3STbOoJEGlp2j28uFFPJdSgHyfda+jDkPn2TW5boboy3FUxJXOJJA8fxe65U+gc01eqUBbo44QgaSQchG+LaitBgX/3Wz1J2Ukf0vvtbU4Et1thOxxvY1jS/+F1716UM5g=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3880.namprd13.prod.outlook.com (2603:10b6:610:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.12; Wed, 11 Aug
 2021 00:01:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 00:01:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "calum.mackay@oracle.com" <calum.mackay@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: =?utf-8?B?UmU6IG9wZW4oT19UUlVOQykgbm90IHVwZGF0aW5nIG10aW1lIGlmIGZpbGUg?=
 =?utf-8?B?YWxyZWFkeSBleGlzdHMgYW5kIHNpemUgZG9lc24ndCBjaGFuZ2Ug4oCUIHBv?=
 =?utf-8?Q?ssible_POSIX_violation=3F?=
Thread-Topic: =?utf-8?B?b3BlbihPX1RSVU5DKSBub3QgdXBkYXRpbmcgbXRpbWUgaWYgZmlsZSBhbHJl?=
 =?utf-8?B?YWR5IGV4aXN0cyBhbmQgc2l6ZSBkb2Vzbid0IGNoYW5nZSDigJQgcG9zc2li?=
 =?utf-8?Q?le_POSIX_violation=3F?=
Thread-Index: AQHXjkCPYsHMnhvAmkypMjg3Qd+XfattaQOAgAACjYA=
Date:   Wed, 11 Aug 2021 00:01:30 +0000
Message-ID: <38bf58eb523ae26028ff1cc158ec648f2dc56e95.camel@hammerspace.com>
References: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
         <4c1c058e-2b52-db5f-807b-b0dd9d6cb1a8@oracle.com>
In-Reply-To: <4c1c058e-2b52-db5f-807b-b0dd9d6cb1a8@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b4b065-ff21-4ad8-7ff0-08d95c5b2c9e
x-ms-traffictypediagnostic: CH2PR13MB3880:
x-microsoft-antispam-prvs: <CH2PR13MB388021C006A7D25FB5CD98FAB8F89@CH2PR13MB3880.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6tK2ToJ0NSeJbYtGDfF/IaOPwzEUdxBfEd8SK7atOrivBgAgwn7dNv83lqofTAq0OKApKjG1vtfhKUK4buyLaYDoP782Is5oxvPGNZI33EjqkYKmsb3nV9TLsQk75EBPWGkkgujOxHwdUDnPaPbhS/eaCsrsVyGgUXmzDCDY7tKc+IMFdY4t+TOL4QewZoxYKnjmBjpVOkEpE5qgr4JUL65/zgkzDhHw1zEG88h6vBs1P07l38xHIiPt5VxcJqvk81auDgBdJLKoa4769ou8TN++CmlQ+hxaRjKnY1U2/wtdsV0+ONFipVHV44cFv5AI3pWjHIJtdl4iCMMKo7jwZDCwxxQb1QzqV8qKEPk6lYC+54dTrTOm1zVTABahB22Jjlu4qFDrVh97H9Ce7mO0kkwkv/9G4eBubYXp9XK5dkp51tsyEt9TjJqhyX2VBxoRmHzy8jdDB8YMlTCqyqb8+183ttP3EU8xvTI7zB3pcRsUMslxa2GmxcvzD1D3xNiRES1Y5trl3cjycn+40IksaND8mBxs67Z8CkZZDWXjGZnbb8FDk8jpef4UoYeLJyKt0NqeuCP6DZdf9IG902n43qJMFsJ6q6oHOfBbdLm4mBGIWPZtvRmPYUJzcBc+kzY8KJ39FenP88bouINeHDN0hYdCXhDoB/vORNBz9M7biiHKuEjeNEFsd+zZmWyxyN47ojq26I7nOkueklQnZNBdMqwT6uDSFR8kgmphzGKDcJGiuowI51BJ5yZje3dUk98x08lsGnk96HLvCobJX9SHrX0ELx2kQzcX7koFbZdAU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(122000001)(508600001)(71200400001)(2616005)(186003)(6916009)(66946007)(8936002)(86362001)(6486002)(38070700005)(76116006)(316002)(4326008)(6512007)(5660300002)(66446008)(38100700002)(36756003)(66476007)(64756008)(26005)(6506007)(966005)(53546011)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHRWUWJVUE9iOUhoUXhPaUlPcUlTMlZiY1o5RW9iNlBBbnFUR2thKzBuZlV5?=
 =?utf-8?B?RktSamxuN25aVnF1K2hMZit5UEQ4V1RCRUVpSUdEUE5jc1pyR2ltNEUvU1RF?=
 =?utf-8?B?Q3FoSFN6K25JVUV6SEtEVUFwd1o1RktrdmRUTWxYM3VQUEJuQkJvK2hENnA4?=
 =?utf-8?B?d0lNb28yOGM0QlU5Y0Fwa0N5TDBjcjVOMGJnZFhBNUl5eS9tUkdSU2pjRUV0?=
 =?utf-8?B?eEk2UCtLQ1A5UmtpUVRtalJQTFVmdWFuS3IrWUo4TWVSZTZGZkV3c2x1WTNJ?=
 =?utf-8?B?WDFwd1BsMWhiUlNJaXBMMlRBNmpxZE81WnB3cVM1T0NiZkorUFVJQUxkOTR4?=
 =?utf-8?B?RHM4MjFtY0pXUXpyTWRtWHZ5eXIyY0NmbG5KaWFZalgvcEJSQ25sK01HeExQ?=
 =?utf-8?B?OFpSRGxicVZQMEpDRFNmNWhvQTZndW0ybUNUMG0yS0FUa3loUWdXQjQ4aVZC?=
 =?utf-8?B?MmpzcENMN2lqanBraGRYcnliSGM2cGIwNXJ6WVE4YW83TWdJbnY2aVFuRDFE?=
 =?utf-8?B?R2NCWnBTcno3bVlPdlNVck56aXRCSWpOM0JVNUhocUpXNnE5NGdwQ3ZsaWp4?=
 =?utf-8?B?dUEya1VmZjZRNkhWazA0SjduZ2JtdnVTWXB0cHFxQ2J1WUwyc2dyZE96Kzcy?=
 =?utf-8?B?Y1ZMc2dIMFEwcUptNVJLN2VkcEl2c3c1cE1ESnAyODV5bUpmRHRaTk80VmI0?=
 =?utf-8?B?dWVPdStPelBGRHhTT05mTWJhNEFXQ2o4aWxGdFZSTHozK3ZzSm05MWtCemdm?=
 =?utf-8?B?cWdsTFdpbHVTRWJFSS9ZQ0xPcmlTSzY1OU5JQ0ZjcmJCdkF4VHNHY1BKYkdI?=
 =?utf-8?B?RjdpWk1CK1lZQ1hMTXhCOUM2RzQzcEFpL0w5a25BSGNESkN4OFBuTThmaWl5?=
 =?utf-8?B?S0dBcjFlMGZYYWYwekU1YkZmUDY4VWRrdHdtMFBLRFdtNk96cFFGMmwyNnBB?=
 =?utf-8?B?VGFxd3BuVWpoU0s2OUxvRDZveXprcGJPbFRFdU5Fc1VhYjA0aHVDWGpFM3Vt?=
 =?utf-8?B?N3U4Rzl2OTNaZzZkWFdhL2wraHViS1dFYUFlOE16d2N6M2pDK1BEWTc4Wm1T?=
 =?utf-8?B?S1dTZDYxQVc5WnI4RUtUM2t5RVc3Tzc0Y3A4SlRsTWVXdllZVHBqMmt4SnVw?=
 =?utf-8?B?MzlTeFloakc1TW51d3lGaHcyZ085bU8zNzVOaHk4c0k3RTJaZnFnQm5qd0Vj?=
 =?utf-8?B?ZksvcEtxcHd6RWJYS0pBNUlsdHVFdEhqcXFnZm5yc2Nub3R1ZzErbi85aUdB?=
 =?utf-8?B?NVlWNGY0cFZ2RlAyMnhmQWVwbzQxWXR1dWNaZU9Fbkt5aGxESndYeG42ells?=
 =?utf-8?B?SWZ4ajdiRFVNZkFncUVwRWRuTEFMMElNSXlpMGlXOEJqakJ3aU9yVzQwaHhV?=
 =?utf-8?B?cjRIVGp5MHpTU0hzUi83NFFTeGRlTnhna25YREp0UUY1QjR3S2FjcE1NL2t4?=
 =?utf-8?B?azRoMmlpYkRpUlZwbWhmMng4YmxXQTVzVzNZVElWTnVqODNHVjdOTEtha0N5?=
 =?utf-8?B?WTl2dytsSUpGeXplVENMWkhoMW8wdE5INTJRd0FERnc2MEtHY2lqWWZVZ0N3?=
 =?utf-8?B?dTRWdHFiTHVEWG82RkZCNGRtWHZZcWR2NXhJN1RJZDdMQWxKZjh4WUxIZHhN?=
 =?utf-8?B?WkZZZnA5NHRaSmt3ZU11ZnZxSTlNTDM2cTF4NUhXN1RmTG5XYktWTHJTMFN0?=
 =?utf-8?B?Zlh1VjJjSUlMVEZ6UU1FSlhkZ2wvbmw1SDZaZWo4ckxzSDhlU1B5cWxTNExr?=
 =?utf-8?Q?+AYFSlVpCF387Cl9+sj1SwNK8msr4A9Aop6oQp2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA54B13639AC64C8BE619EEC8A9EC95@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b4b065-ff21-4ad8-7ff0-08d95c5b2c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 00:01:30.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dza/aduVyd5ZqLs7TAAI/0snr9D0pPGbq5emtq57bAGAvSC1S3BDtx+fSaiIM1A8zY7na4Wrks39eh+OoImLng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3880
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTExIGF0IDAwOjUyICswMTAwLCBDYWx1bSBNYWNrYXkgd3JvdGU6DQo+
IGFuZCBJIGZvcmdvdCB0byBhZGTigKYNCj4gDQo+IE9uIDExLzA4LzIwMjEgMTI6MzYgYW0sIENh
bHVtIE1hY2theSB3cm90ZToNCj4gPiBoaSBUcm9uZCwNCj4gPiANCj4gPiBJIGhhZCBhIHJlcG9y
dCB0aGF0IGJhc2ggc2hlbGwgInRydW5jYXRlIiByZWRpcmVjdGlvbiB3YXMgbm90DQo+ID4gdXBk
YXRpbmcgDQo+ID4gYWxyZWFkeSB6ZXJvLg0KPiA+IA0KPiA+IFRoYXQncyB0cml2aWFsIHRvIHJl
cHJvZHVjZSwgaGVyZSBvbiB2NS4xNC1yYzMsIE5GU3Y0LjEgbW91bnQ6DQo+ID4gDQo+ID4gIyBk
YXRlOyA+IGZpbGUxDQo+ID4gVHVlIDEwIEF1ZyAxNDo0MTowOCBQRFQgMjAyMQ0KPiA+ICMgbHMg
LWwgZmlsZTENCj4gPiAtcnctci0tci0tIDEgcm9vdCByb290IDAgQXVnIDEwIDE0OjQxIGZpbGUx
DQo+ID4gDQo+ID4gIyBkYXRlOyA+IGZpbGUxDQo+ID4gVHVlIDEwIEF1ZyAxNDo0MzowNiBQRFQg
MjAyMQ0KPiA+ICMgbHMgLWwgZmlsZTENCj4gPiAtcnctci0tci0tIDEgcm9vdCByb290IDAgQXVn
IDEwIDE0OjQxIGZpbGUxDQo+ID4gDQo+ID4gDQo+ID4gb3BlbihPX1RSVU5DKToNCj4gPiANCj4g
PiAxMDU4MSAxNDo1MjozNi45NjUwNDggb3BlbigiZmlsZTEiLCBPX1dST05MWXxPX0NSRUFUfE9f
VFJVTkMsIDA2NjYpDQo+ID4gPSAzDQo+ID4gPDAuMDEyMTI0Pg0KPiA+IA0KPiA+IGFuZCBhIHBj
YXAgc2hvd3MgdGhhdCB0aGUgY2xpZW50IGlzIHNlbmRpbmcgYW4NCj4gPiBPUEVOKE9QRU40X05P
Q1JFQVRFKSwgDQo+ID4gdGhlbiBhIENMT1NFLCBidXQgbm8gU0VUQVRUUihzaXplPTApLg0KPiA+
IA0KPiA+IA0KPiA+IEkgdGhpbmsgdGhpcyBtaWdodCBiZSBiZWNhdXNlIG9mIHRoaXMgb3B0aW1p
c2F0aW9uLCBpbiB0aGUgaW5vZGUNCj4gPiBzZXRhdHRyIA0KPiA+IG9wIG5mc19zZXRhdHRyKCk6
DQo+ID4gDQo+ID4gwqDCoMKgwqDCoGlmIChhdHRyLT5pYV92YWxpZCAmIEFUVFJfU0laRSkgew0K
PiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAg4oCmDQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAoYXR0ci0+aWFfc2l6ZSA9PSBpX3NpemVfcmVhZChpbm9kZSkpDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGF0dHItPmlhX3ZhbGlkICY9IH5BVFRSX1NJWkU7DQo+ID4gwqDCoMKg
wqDCoH0NCj4gPiANCj4gPiDCoMKgwqDCoMKgLyogT3B0aW1pemF0aW9uOiBpZiB0aGUgZW5kIHJl
c3VsdCBpcyBubyBjaGFuZ2UsIGRvbid0IFJQQyAqLw0KPiA+IMKgwqDCoMKgwqBpZiAoKChhdHRy
LT5pYV92YWxpZCAmIE5GU19WQUxJRF9BVFRSUykgJg0KPiA+IH4oQVRUUl9GSUxFfEFUVFJfT1BF
TikpIA0KPiA+ID09IDApDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiANCj4g
PiBhbmQsIGluZGVlZCwgdGhlcmUgaXMgbm8gY2hhbmdlIGhlcmU6IHRoZSBmaWxlIGFscmVhZHkg
ZXhpc3RzLCBhbmQNCj4gPiBpdHMgDQo+ID4gc2l6ZSBkb2Vzbid0IGNoYW5nZS4NCj4gPiANCj4g
PiBIb3dldmVyLCBQT1NJWCBzYXlzLCBmb3Igb3BlbigpOg0KPiA+IA0KPiA+ID4gSWYgT19UUlVO
QyBpcyBzZXQgYW5kIHRoZSBmaWxlIGRpZCBwcmV2aW91c2x5IGV4aXN0LCB1cG9uDQo+ID4gPiBz
dWNjZXNzZnVsDQo+ID4gPiBjb21wbGV0aW9uLCBvcGVuKCkgc2hhbGwgbWFyayBmb3IgdXBkYXRl
IHRoZSBsYXN0IGRhdGENCj4gPiA+IG1vZGlmaWNhdGlvbiBhbmQNCj4gPiA+IGxhc3QgZmlsZSBz
dGF0dXMgY2hhbmdlIHRpbWVzdGFtcHMgb2YgdGhlIGZpbGUuDQo+ID4gDQo+ID4gWw0KPiA+IGh0
dHBzOi8vcHVicy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvOTY5OTkxOTc5OS9mdW5jdGlvbnMv
b3Blbi5odG1sDQo+ID4gXQ0KPiA+IA0KPiA+IHdoaWNoIHN1Z2dlc3QgdGhhdCB0aGlzIG9wdGlt
aXNhdGlvbiBtYXkgbm90IGJlIHZhbGlkLCBpbiB0aGlzDQo+ID4gY2FzZS4NCj4gDQo+IFRoaXMg
aGFzIGJlZW4gZGlzY3Vzc2VkIGJlZm9yZSwgd2F5IGJhY2sgaW4gMjAwNjoNCj4gDQo+IMKgwqDC
oMKgwqDCoMKgwqANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzQ0ODVDM0ZF
LjUwNzA1MDRAcmVkaGF0LmNvbS8NCj4gDQo+ICJpZiBhbmQgb25seSBpZiB0aGUgZmlsZSBzaXpl
IGNoYW5nZXMiIHdoaWNoIGlzbid0IGluIHRoZSBQT1NJWCBJRUVFDQo+IFN0ZCANCj4gMTAwMy4x
LTIwMTcgSSBxdW90ZWQgYWJvdmUuDQo+IA0KPiANCj4gU28sIEkgdGFrZSBpdCB0aGF0IHRoaXMg
aXMgc3RpbGwgaW50ZW50aW9uYWw/DQo+IA0KDQpTb3J0IG9mLi4uDQoNCldlIGltcGxlbWVudGVk
IHRoZSBjdXJyZW50IGZ1bmN0aW9uYWxpdHkgYXMgYW4gb3B0aW1pc2F0aW9uIGJhY2sgd2hlbg0K
dGhlIFNVUyB3YXMgdGhlIG1vc3QgdXAgdG8gZGF0ZSBhdXRob3JpdHkuIFdlIGNvdWxkIHVuZG8g
dGhhdCB0b2RheSBpbg0Kb3JkZXIgdG8gYmUgUE9TSVggY29tcGF0aWJsZSwgYnV0IGFueSBjaGFu
Z2Ugd2UgbWFrZSBvbiB0aGUgY2xpZW50IHdpbGwNCnJlbHkgb24gdGhlIHNlcnZlciBpbXBsZW1l
bnRpbmcgdGhlIFBPU0lYIGFuZCBub3QgdGhlIFNVUyBzZW1hbnRpY3MuDQoNCklPVzogaW4gZG9p
bmcgc28sIHdlJ2QgYmUgbW92aW5nIHRoZSBwcm9ibGVtIHRvIHRoZSBzZXJ2ZXIuDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
