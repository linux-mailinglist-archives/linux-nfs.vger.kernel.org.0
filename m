Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0758380D90
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhENPsM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 11:48:12 -0400
Received: from mail-bn8nam08on2093.outbound.protection.outlook.com ([40.107.100.93]:5057
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230326AbhENPsL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 11:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9qxxpoE9PBDroWkH9PWF2xsKpMhdYDAe/Cq55KGE2Z2sxaQQ4ij22y66VPmQbXDYPw6gdkjFv8QvsAiJWu9ZP2pK+QZiDGQQZ2KgbgwgZJOgZLwIHnKPC8uEOVjPjnfZT8Z8bCvad6mZ+hP+ve2O7BHnG6eH7IqkiibCxakXbn9XbImw79Wi+zpQkUSeJOl0H1Pri+Rsanj6wGoTYcMplidLMFMWFamODT7N7/bV07wfEUxOrduWPnAAREy1fUWV4S4WWk+9QdctGMmAAseU25J38KKEuxehqhfl+qcauh77R/F3YKqeWBJNg+6iKuNTMwlX4XB81xPR27hlR88ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEilnMCAeALt5G7a//iQAVyvyPZdGReiQyALqTUlaVo=;
 b=Ajevx4dIa8YJRlAm6VDf1RUmTEKdRBjkdiYZSIQWYoGaD84H7KJ9BgOUoLUyRMH/UR/9e4pC/MYIMdTVhTAprha4JrxprRmatbXafiSx+M8TnkNaRqWuPfMPTLMfuoyBVA8rph1jEqJy0rLGhM9TjHwepY39OdCw+p7MY4jmxy4QLUqylJZvexz9juaWPd3z7wqkBDcCG6nraz3oD6ExYIz6o0nSWegctesdXVuUNWHzSxABfTbweCwXOFsAs5MOhBy+guUJdx/7J4bgHG/jgZv9dZn7RLhy6QUjDHvfNoFHNTjhI/6I1DLGF2dyphPMxGne5r4CYw2j88m2IQXurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEilnMCAeALt5G7a//iQAVyvyPZdGReiQyALqTUlaVo=;
 b=U4G+Rh8OT/gKJP2l9Bim5uUZuwAkyCn+YOCllNu2sZSdZ3BjwHVlAeeoCVnyDfmhcrAnvTk2eMScgAu/laFhqIoN1tvtRYQy+0PgIhckYS+FlpUDyn8WUwH8hzOT7UG2ijPtjbNMxDEnXWR/ExfDuEas612J54l2RiE/bfEK4Ak=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4573.namprd13.prod.outlook.com (2603:10b6:5:3a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12; Fri, 14 May
 2021 15:46:58 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Fri, 14 May 2021
 15:46:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Topic: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Index: AQHXSHWIwC4sG/njP0aIKkyiTSP2PqrjH9EA
Date:   Fri, 14 May 2021 15:46:57 +0000
Message-ID: <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
References: <20210514035829.5230-1-nickhuang@synology.com>
In-Reply-To: <20210514035829.5230-1-nickhuang@synology.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a07139a2-2b69-44c2-ef7c-08d916ef81ce
x-ms-traffictypediagnostic: DS7PR13MB4573:
x-microsoft-antispam-prvs: <DS7PR13MB4573C393C3AD09E573320C64B8509@DS7PR13MB4573.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TDe4GFUw5K9jFg28SdNg1W5QfM5Jv6guxVr4AI1s/gpJKWlX90ZAmxPYJItDjWOIfq2/gDQVa0yeEDI2evavxDPgiiiIVErJs0M/GP1ivCZGFpbBnVFZBtGOK+mSZLMvc3DXzLkXaC/c3kBLvNTmFUkSvhM9VFo/VSLsFY9C3HPZayeg7ybxqxXDQLvnKxUek6k+Oedmq2Yj9cbSeeZSMco5/wzKEgnN8l7GM8dJcxgGdUC7Md19RewrPIQl4f1UJ3VmmFtZTC2SwkblowOKMtLvfOKrFKKGPC8AOC7boV6AdRM04is2i9XAdT8smGB8Uu2va2kEq47HF4THTZHxEfR3hBdkIsZoEM4HRjpB/y8m9Yyc7NC5j4VooDolb2gpDbg5Vsnxhe4HG0K/NbQOEQLw+mMdg6gCQknjoVCvvklTZdNDlFIKq+mBA5Z1zc/3o2C0wjndbtvTG99nmETkgUK8DtePIVz6+60l9Lq93kgZgUZNZxgxo6wJHNujke4DioKbNoN6Nl5wqpms0eMS7p3hyXBUCbS6psFTiizbbD2glN6JqzP76aHsw0XgTixx2xBUxS4TI/Z1LzFp9TnZ+iZL6MzclH9bNI0wC0G6I8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(366004)(396003)(376002)(6512007)(2906002)(478600001)(4326008)(26005)(6506007)(8676002)(64756008)(86362001)(66476007)(36756003)(66446008)(66556008)(6486002)(91956017)(5660300002)(122000001)(38100700002)(83380400001)(110136005)(8936002)(316002)(66946007)(2616005)(54906003)(186003)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?enRCYitzbTZLc0NWa1haakErWHh2NVVrcUF2c0hLelpJVGZ4amd3S2EvVjA3?=
 =?utf-8?B?WmRsdnUyRHpLM1NiclZXSXZLU2lYcEllc0hmcytOOW5jUjlFUWNpRVJQYWNI?=
 =?utf-8?B?aGVsUGtIY2tpVjBLS0ozamozSWFmVEdqT0pYUytjbWdsU1c5MVNNMkZmdml1?=
 =?utf-8?B?cFdiOUhMaWNOQVlQcXdjZHd2WWRybW4zZjRXVGFmc29KY0JSMUgzZWFuVVFQ?=
 =?utf-8?B?U2hydVlxT1BIYXNQNjhRem1PeWFqM0hiQXRmWUVOa3JLZG5ZTWRlQ2VUSFF3?=
 =?utf-8?B?M2tWc1IxcVBIdXFWUkdwTWlQbEQyeElqTWkzdlFOMmdDS0JzUkpXMjZ6R240?=
 =?utf-8?B?UGJ4ci8yaytzaHFaOXZsSVJjQ25iZEJuM04ra2xVYmtyZHhyUFN3RzNmWXJ5?=
 =?utf-8?B?VStaL0t0QmVUK0oyM3hmdW5tMGt3YmNlaU5VaFZoaE0rYkNmT0prcXl2M2lC?=
 =?utf-8?B?RlNybnhBNTN3LzR5OFQ2SHZEbDU4V2xjd05BeFo5K1BlemhYV3FuWWlOK2NZ?=
 =?utf-8?B?M2lxT3diU3lyLzQ4TFFpOUlyT0hXTUVyUTB2MlhBNWZBaHQxWjZ5ZGNkY0NN?=
 =?utf-8?B?N1UrVVAxQ1c5N1AwT2JsMWp4ZXpIUWRrelBMak1tOXZwKzVLQmlCb2xZdVlX?=
 =?utf-8?B?MWZCbHJYOHdRTmNtRjl3VjVsbXdVaG1rUUhpTlk5RGRHbWF5Z3ZSR0V4VGtS?=
 =?utf-8?B?MjF2RHBCVm9MSmhSUkFmTUpnY0gzZDJTSHF6NXkwWHhmVTVIZCtuOFlabEFH?=
 =?utf-8?B?RGRwbWthSEJjV2t3am8zNUZJME9IdENlOFNVQ2VwTWZVYjRtTGtBRlpKOE9D?=
 =?utf-8?B?T2toZjRvYmVRS2NodGVZcHhSZEZ1YS9zemdiUEhYZHk4L09FQjYrNzZ4Y0J6?=
 =?utf-8?B?Q29yVHo1UktmYVhTT3ZWMUdzc2xCeXlOb3F6LzdFeVpOelkvQkt0WFdMeDVC?=
 =?utf-8?B?OTRZMGx2SDlwSktTTVhyTzM2cURaakFnMEhER2wvakh1Yzg0YXJPWXZKbGx0?=
 =?utf-8?B?aU9vejcxMVdtcklJMUJhbEljbmpiQTVUU20rZzRSSjhSMGM0SzRGaWVSNi9W?=
 =?utf-8?B?N2tUWXYvcFFNbEk5d2FTREIxbjNNdUhyc3p4OTh3WWtVRGdoWFZzb1lROWQ0?=
 =?utf-8?B?WWI0OGJQdWxZRXpUT3hSeWM3Qm9BTEorSGphOUVRSGFnMTdrL2FSMnVGMVFB?=
 =?utf-8?B?N2h4eFlzZUYwNUlPbmtDdk9mQVBHUXVBZVFTb1NLaTQ0MVpVbkJrNTJXNGkz?=
 =?utf-8?B?RFNWNTlVRVErK3RNa2VoV2lNc1NaazZzQ1dwUWpmQS91bzN4cHhKdXBhaEhP?=
 =?utf-8?B?UnZBVlBDM0thcE4yeUF4UmpsMzdEblNRTDNuTXFzN1RpR1VwbFpRQmxmclRE?=
 =?utf-8?B?L0NwRlliUXE0NnExOTdMd0E1dDd1V3hXYytaZG9tdHN6eFNZZ1pFdlc0UnIy?=
 =?utf-8?B?UDFDOWc2bmhZZnJIWngrcjB1dWZKcFlrelpHWFZrMW5pZ0J3WlhjaXlQVG5n?=
 =?utf-8?B?cEc1K0pwZGZjekxFb0tjNUJGZHFJVktyc2liaG1YMW1OODNHN2gxUVM0cFZz?=
 =?utf-8?B?bGFRcXZLN0FkQmNUQkdFZ1RsWnF6QmF1cFVrK3NYRjJGOGprQXJkOHNkcVBu?=
 =?utf-8?B?SDQ1SW0zWjVxL1pYazZYRWpvbkN1N1M1Tlh3d1pZenE1dEJnQkpNeGdoOEdj?=
 =?utf-8?B?bmtpYkJWcHJxakJJRjBvcHZwSDEyeHZDNFRIZjdlb3l5L3pOck8wb2dqWVhy?=
 =?utf-8?Q?VzL2QbEclxDXUM90azbvlVO2y5LKvisI2spaNEA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC9D4FFC5D6EC149B31D682C7BAC5CB5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07139a2-2b69-44c2-ef7c-08d916ef81ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:46:57.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0yQZnr6FJOHkVix5tswkQnd6vZEUjjtp1BcMhC6bBnS3/A9Bun2UzzPCFjsXleJ75zb6ZPmgVkNISbZw7mfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4573
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTE0IGF0IDExOjU4ICswODAwLCBOaWNrIEh1YW5nIHdyb3RlOg0KPiBG
cm9tOiBZdSBIc2lhbmcgSHVhbmcgPG5pY2todWFuZ0BzeW5vbG9neS5jb20+DQo+IA0KPiBUcnVu
Y2F0aW9uIG9mIGFuIHVubGlua2VkIGlub2RlIG1heSB0YWtlIGEgbG9uZyB0aW1lIGZvciBJL08g
d2FpdGluZywNCj4gYW5kDQo+IGl0IGRvZXNuJ3QgaGF2ZSB0byBwcmV2ZW50IGFjY2VzcyB0byB0
aGUgZGlyZWN0b3J5LiBUaHVzLCBsZXQNCj4gdHJ1bmNhdGlvbg0KPiBvY2N1ciBvdXRzaWRlIHRo
ZSBkaXJlY3RvcnkncyBtdXRleCwganVzdCBsaWtlIGRvX3VubGlua2F0KCkgZG9lcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFl1IEhzaWFuZyBIdWFuZyA8bmlja2h1YW5nQHN5bm9sb2d5LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQmluZyBKaW5nIENoYW5nIDxiaW5namluZ2NAc3lub2xvZ3kuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JiaWUgS28gPHJvYmJpZWtvQHN5bm9sb2d5LmNvbT4NCj4g
LS0tDQo+IMKgZnMvbmZzZC92ZnMuYyB8IDUgKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC92ZnMuYyBiL2ZzL25mc2Qv
dmZzLmMNCj4gaW5kZXggMTVhZGYxZjZhYjIxLi4zOTk0OGYxMzA3MTIgMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mc2QvdmZzLmMNCj4gKysrIGIvZnMvbmZzZC92ZnMuYw0KPiBAQCAtMTg1OSw2ICsxODU5
LDcgQEAgbmZzZF91bmxpbmsoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwgc3RydWN0DQo+IHN2Y19m
aCAqZmhwLCBpbnQgdHlwZSwNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGVudHJ5
wqDCoMKgKmRlbnRyeSwgKnJkZW50cnk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGXC
oMKgwqDCoCpkaXJwOw0KPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGXCoMKgwqDCoCpyaW5v
ZGU7DQo+IMKgwqDCoMKgwqDCoMKgwqBfX2JlMzLCoMKgwqDCoMKgwqDCoMKgwqDCoGVycjsNCj4g
wqDCoMKgwqDCoMKgwqDCoGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaG9zdF9lcnI7DQo+
IMKgDQo+IEBAIC0xODg3LDYgKzE4ODgsOCBAQCBuZnNkX3VubGluayhzdHJ1Y3Qgc3ZjX3Jxc3Qg
KnJxc3RwLCBzdHJ1Y3QNCj4gc3ZjX2ZoICpmaHAsIGludCB0eXBlLA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGhvc3RfZXJyID0gLUVOT0VOVDsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9kcm9wX3dyaXRlOw0KPiDCoMKgwqDCoMKgwqDCoMKg
fQ0KPiArwqDCoMKgwqDCoMKgwqByaW5vZGUgPSBkX2lub2RlKHJkZW50cnkpOw0KPiArwqDCoMKg
wqDCoMKgwqBpaG9sZChyaW5vZGUpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCF0eXBl
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHR5cGUgPSBkX2lub2RlKHJkZW50
cnkpLT5pX21vZGUgJiBTX0lGTVQ7DQo+IEBAIC0xOTAyLDYgKzE5MDUsOCBAQCBuZnNkX3VubGlu
ayhzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gc3ZjX2ZoICpmaHAsIGludCB0eXBl
LA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFob3N0X2VycikNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBob3N0X2VyciA9IGNvbW1pdF9tZXRhZGF0YShmaHApOw0KDQpXaHkgbGVh
dmUgdGhlIGNvbW1pdF9tZXRhZGF0YSgpIGNhbGwgdW5kZXIgdGhlIGxvY2s/IElmIHlvdSdyZQ0K
Y29uY2VybmVkIGFib3V0IGxhdGVuY3ksIHRoZW4gaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBjYWxs
IGZoX3VubG9jaygpDQpiZWZvcmUgZmx1c2hpbmcgdGhvc2UgbWV0YWRhdGEgdXBkYXRlcyB0byBk
aXNrLg0KDQpUaGlzIGlzLCBCVFcsIGFuIG9wdGltaXNhdGlvbiB0aGF0IGFwcGVhcnMgdG8gYmUg
cG9zc2libGUgaW4gc2V2ZXJhbA0Kb3RoZXIgY2FzZXMgaW4gZnMvbmZzZC92ZnMuYy4NCg0KPiDC
oMKgwqDCoMKgwqDCoMKgZHB1dChyZGVudHJ5KTsNCj4gK8KgwqDCoMKgwqDCoMKgZmhfdW5sb2Nr
KGZocCk7DQo+ICvCoMKgwqDCoMKgwqDCoGlwdXQocmlub2RlKTvCoMKgwqAgLyogdHJ1bmNhdGUg
dGhlIGlub2RlIGhlcmUgKi8NCj4gwqANCj4gwqBvdXRfZHJvcF93cml0ZToNCj4gwqDCoMKgwqDC
oMKgwqDCoGZoX2Ryb3Bfd3JpdGUoZmhwKTsNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
