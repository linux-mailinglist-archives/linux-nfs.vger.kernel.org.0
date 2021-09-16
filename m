Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFEA40DCA6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 16:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhIPOZG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Sep 2021 10:25:06 -0400
Received: from mail-mw2nam10on2131.outbound.protection.outlook.com ([40.107.94.131]:12672
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237928AbhIPOZE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Sep 2021 10:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isWrZdMvzjWzfAfxgRuDiCJ5rVLvO2TqP6KtaBrPcCiH71xd44NL8T/v1NyOnvgk4DSKWYpbdYTXHGVZFtIdtckI+Xt4exlGIlAOjHTca9y16mcgC1MrnY/2tzzTEesD8zAJpzp5HpU9VP/VRLswQOoUApkLr4+0F370WIxIKSs5cOFM2Yh6yaudo4ef/czeGGCb+dzaCQtT6DQkLpexRUdvnFR3sGVnXCD6TBjdaUjO/lQR+vVO1iE134fLN63hScn3piJIjS4rQ9ip2qlPsiIG7iZLqS/Y/c7xieS5s0w2iMJRo1Zr0wClFz2xaX4SJlImnys5g+HgJF5AWRN9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AkIIICkEDIWzMxNV9GI6v2Qs5aeQKZ7SAL0Yj3/o/9o=;
 b=hmH1rRiYySN/wtvAalFq2dtY57FdIHzdl6jmwDUafo+kg6S3vdZSBvwWIKmr0hLH8Az2IrwwN409kRYKt0Zo+khXbizDKjceSfF3nBUfcGMtLsXTBzoDAOT4DXTQsZfOMRZ9MYh3COddY7f4YOC7a43GTKSsfSN+YG92nUWSh9pDKpV3CfHZsXpIQ09drtpYFQUhrxjrgLjaCU5m3g8I5TsMd79ypsKG4mizg9EQN9tjoCxiOGAh1cc788Ze7XxPfS9Bk22LcXGTKxVHnpro9wyOEquuFTCJwFtknaZvhfmoAC2euc8DYWw/BL1dEs2S/oSO+SftbtC/5mvBAnacbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkIIICkEDIWzMxNV9GI6v2Qs5aeQKZ7SAL0Yj3/o/9o=;
 b=eBfePi+5LzEFqVgQGAvzZE2c0R9wZBlFhDOkppxpMoIL5bzjXvR/lqonUCSE9Cmrr8iFWpwlC2qYGEMjSW3GWCoNvo6D8na4eKXs/i97R/fVqSzfE5nf7FrhnRSPUk6FXSe4tOptIylO2I73tjMivB5/DRpijq+qu+HnAJBD9IQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3782.namprd13.prod.outlook.com (2603:10b6:610:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7; Thu, 16 Sep
 2021 14:23:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.006; Thu, 16 Sep 2021
 14:23:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "luomeng12@huawei.com" <luomeng12@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: Questions about nfs_sb_active
Thread-Topic: Questions about nfs_sb_active
Thread-Index: AQHXqggqrDZYSx21fUSxNoXGAjuX7KulEMkAgAD2cYCAALGagA==
Date:   Thu, 16 Sep 2021 14:23:42 +0000
Message-ID: <6a3039fe59281dcda4cd29c1c9084d421033e182.camel@hammerspace.com>
References: <ce24474a-39a6-dc3b-0580-378cdfedf0c5@huawei.com>
         <30A81685-4F45-44D3-B497-117BF7B33903@hammerspace.com>
         <951cd849-d6fe-55c0-6f8d-2fbe3ab348f7@huawei.com>
In-Reply-To: <951cd849-d6fe-55c0-6f8d-2fbe3ab348f7@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbbe7517-2725-44c2-9c3c-08d9791d95e4
x-ms-traffictypediagnostic: CH2PR13MB3782:
x-microsoft-antispam-prvs: <CH2PR13MB378280157BF514EE597A9376B8DC9@CH2PR13MB3782.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/K8aCnVccC2KajSY/mgj0SCqoul9hj0cd34ID69tOhbS2gKB/J/Rs5CP4iDSAQPqe9bf5sWS9ZGLlgS4h9iufVZAYRh8gP6yGAnxTZ5BbVbO+XZ948kaKTa8QetuCd11LRH2uvxHvlRDDsnPqA/sf7X/bCrhpc9h6H3dlbyrOxC+eRt3NXm1wxd9eLiPx7vXESl1pS7o2U7LFS4vRe1vXGTgk2mjf+k/5o76LgIccwbBseK2JE1mvKGVErlG0BML9RJbtpr+BTyS6k+Tq7AG7W1zMu8XpdWwmvLlJ/tMBUmZ06Y5Gd2XELdheCW6nUaVi4VhIfUv3qCaMrE6gqqJQg6bbN4fnjtcXXWpqRHYOSG+7vi3xG7/YE+FRYOGJ3p249DBHf2BeAr865dJgQdiveIZBe74ZrxrkszTOC3lFa7DGc/RI2KFOYNs9iDGUphMqAxR+3tWcVXRRAQRCf4MKHtWk6pS7dcpFZh6FfXGQILU7TfMq8kiTqNJgYB68T0kBHgD61skEfMqL0iiZzguPbfRxmiaoldNgAOkVFLwY9s3if0Lpnbtf8V5Ad4KZwglZGf3CsAM2RYAs3FMXBjIzphMBSZe0Nglkri3In5QkzsgLCqNXcMhaUY3f7acy0F2x1thz+chgRTfHqSk2z3fBZxs1bf6WfMQ88eTpQprYZSOLlfyEp/pplUu7auChvWFxDgmmn/4SIXsUUTUE8nvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(396003)(346002)(136003)(366004)(122000001)(2906002)(86362001)(6512007)(6486002)(38070700005)(8676002)(71200400001)(38100700002)(186003)(316002)(76116006)(6916009)(26005)(4326008)(66946007)(6506007)(54906003)(53546011)(36756003)(66556008)(83380400001)(64756008)(66446008)(66476007)(7116003)(5660300002)(8936002)(478600001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnE3T05ZM1AveFdKWDYwdk9COFBNeFpLazlZbkxCM093UmxPZ3hYVVNDUlhH?=
 =?utf-8?B?VHZIbjBXSnI4bm8yRmQybWFhMzVyNjNpMzZZM1RGem5qTTlqNzhNTi9vMElh?=
 =?utf-8?B?VmJncFBNYmtzd28xMDdqRldVQmdjdlFtUTFlQXZPZnFJUmJOdlJ4QzZQeGhT?=
 =?utf-8?B?T01ZVU0zRWpoVkdOKzJVQzVKRkl3bGMvN2hVK0hCMnhFaitkK2pOeHIzUGFl?=
 =?utf-8?B?dHZvT0FHZ0FMTzRXOVlZdkdNeTUvQ2ZnZnZEVEJKTndWYzFIVTB4VnB5L1o5?=
 =?utf-8?B?RUhidzlGNGhCUCsrblZNMEpEaDNBNmJPa015dFR6cUdQWDlkVHNjRDJnNlB1?=
 =?utf-8?B?VE9HaUJLTEI2Smd3emJOZmY0dXlDYUtGSGwrTSs0ZzJocGVtRHFrcG0wU2tT?=
 =?utf-8?B?L1RBNTRQVncydWRyRmFlY2RXY2hxNDF4c2pWUWdRSGJDek16dTNkOFcxUmFn?=
 =?utf-8?B?VE9aU3Jmdzh2bVJPenl2emFZNWpZWVRDL1BScldsM2dTTEFISEtCOEJPTG9v?=
 =?utf-8?B?OVV2TElOalFyTURjQ25JQUdNeC9PWG00eU9XLzg5bStZZXRJMzV1dEozdDZn?=
 =?utf-8?B?TVBSM3VNeXVlNmFPbUJSeVpTTTZKVG1lT2ROOFZ0S2ZVdGdZMjdWTktHS2xT?=
 =?utf-8?B?WndPMmtKNEtuQU44NXd2V2tXMDZmMTlOTG5nVmRCYU1lcWhmdHNRUUVhK3N5?=
 =?utf-8?B?cVgrWEltYUh2V0ZoR01YbHZyTzVGUTBQOXF2NTVRQ0RlNUhFN0RZTDBBTlBS?=
 =?utf-8?B?aTZUZk9uNTdKb0Y0MEpPNUF3M2t5ZEhMblZnb3MzV0YrSWdGTTZnN29INm5B?=
 =?utf-8?B?MnEvZFltNmNXdXZPckZGaDVVTzlvVFI0bDJ6bW5ncEllNmtlc3hHVG9HU1pR?=
 =?utf-8?B?cmMybHRSeHRvSVhTYzR0ZSt3SU5sZG1sVzJGaU5OeXhmOXNlN0NRSGVoa1Yz?=
 =?utf-8?B?RlIrWU9XZHg5RitWNDBNcjVoNmxRdUdQdzFrR1hiNk5jSlFHUmxmc3BldE9N?=
 =?utf-8?B?WnM1bmFoZUpBTVV0Wko4dGFhVEIyY0d2cG81aDZyRGwvU09OR0h0VThLV2Jm?=
 =?utf-8?B?VjF0TTFJRWl5NkY4OHZ1UVcxMEgvRDd6bnlWbDY5U2l3NnArN1NyRVlmT0gv?=
 =?utf-8?B?V0NUc3g1eUlCQk4yd2xoVWdXRzFyQVNaa0g3SWVRMEZleFhhdyt3YmhKSDVD?=
 =?utf-8?B?TjA1ZFN0YmF3SlNpUmpoTGtsMkN0Z1VzN3hxeEtEUlhQWkRPYkFTQ1h0d1k2?=
 =?utf-8?B?ZFc0K05TY0UwMEdZYzdJZjFQd2tzWnlmRUxEamtKWWVUVnB6WHk2N1ZxYmVa?=
 =?utf-8?B?bUxNQklIVUZTZ2NUOVhTQU5yTm5tQXpZMkQrM2xSaXlMT3hYMWZIQ0NKRGU0?=
 =?utf-8?B?UXh6Vm9XUGV5eVo2SjU0Z25ZVlJJWEVEMnRUZTlDS3FlZkJuVFl0aUZBT2U3?=
 =?utf-8?B?SFluVFNsZUh5cjFYMzdiMHFBY09BVkZybndyRndtZ2RhOGdGOE5CSElHYzFM?=
 =?utf-8?B?eG8vMFh2dzVVemN3M0MyaDUrNUVSY0pkcUdpb3E0c1pFUkp4eDB1VzNtanNX?=
 =?utf-8?B?Vk5oQU9zM2dUa1lrbzk1djVLK2NXdm44NjM2UG9hM0RKYXl4WjdkRG5sbXA3?=
 =?utf-8?B?R0dlNzFWL25FTEF5MG9LL2lEUWhRaFZzSm5lSktqK0NJZldRa0s2SFZ6bGlI?=
 =?utf-8?B?cVFpRE0vZ3V6S3NndURvWVRKTTU2NkI4K0pOcmZuR2g4MjdiV1BmOFV2UVBr?=
 =?utf-8?Q?Seg8h8sHkohJYJnpAy2yLYLlfcZ3CxngJkSfN8f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D944F8ED464D048B3ED94AE63A58DAE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbe7517-2725-44c2-9c3c-08d9791d95e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 14:23:42.4061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mj7ojI7XgB6tTxblPhFXuA5OWq3gFALI7nq5Yw5ziUtB+mgKXAur6+2OdoThYBAoPonSofudrcjP/EQp7MzQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3782
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTE2IGF0IDExOjQ4ICswODAwLCB6aGFuZ3hpYW94dSAoQSkgd3JvdGU6
DQo+IA0KPiANCj4g5ZyoIDIwMjEvOS8xNSAyMTowNSwgVHJvbmQgTXlrbGVidXN0IOWGmemBkzoN
Cj4gPiANCj4gPiANCj4gPiA+IE9uIFNlcCAxNSwgMjAyMSwgYXQgMDQ6MDMsIHpoYW5neGlhb3h1
IChBKQ0KPiA+ID4gPHpoYW5neGlhb3h1NUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gSGkgVHJvbmQsDQo+ID4gPiANCj4gPiA+IEkgaGF2ZSBzb21lIGNvbmZ1c2UgYWJvdXQgJ25m
c19zYl9hY3RpdmUnLg0KPiA+ID4gDQo+ID4gPiBUaGUgZm9sbG93aW5nIGNvbW1pdCBpbmNyZWFz
ZSB0aGUgJ3NiLT5zX2FjdGl2ZScgdG8gcHJldmVudA0KPiA+ID4gY29uY3VycmVudCB3aXRoIHVt
b3VudCBwcm9jZXNzIHdoZW4gaGFuZGxlIHRoZSBjYWxsYmFjayBycGMNCj4gPiA+IG1lc3NhZ2Uu
DQo+ID4gPiANCj4gPiA+IMKgIGUzOWQ4YTE4NmVkMCAoIk5GU3Y0OiBGaXggYW4gT29wcyBkdXJp
bmcgZGVsZWdhdGlvbiBjYWxsYmFja3MiKQ0KPiA+ID4gwqAgMTEzYWFjNmQ1NjdiICgiTkZTOiBu
ZnNfZGVsZWdhdGlvbl9maW5kX2lub2RlX3NlcnZlciBtdXN0IGZpcnN0DQo+ID4gPiByZWZlcmVu
Y2UgdGhlIHN1cGVyYmxvY2siKQ0KPiA+ID4gDQo+ID4gPiBCdXQgaXQgYWxzbyBkZWxheSB0aGUg
cHJvY2VzcyBpbiBmdW5jdGlvbg0KPiA+ID4gJ2dlbmVyaWNfc2h1dGRvd25fc3VwZXInLCBzdWNo
IGFzICdzeW5jX2ZpbGVzeXN0ZW0nIGFuZA0KPiA+ID4gJ2Zzbm90aWZ5X3NiX2RlbGV0ZScuDQo+
ID4gPiANCj4gPiA+IEZvciB0aGUgY29tbW9uIGZpbGUgc3lzdGVtLCB3aGVuIHVtb3VudCBzdWNj
ZXNzLCB0aGUgZGF0YSBzaG91bGQNCj4gPiA+IGJlIHN0YWJsZSB0byB0aGUgZGlzaywgYnV0IGlu
IG5mcywgaXQgbWF5YmUgZGVsYXk/DQo+ID4gPiANCj4gPiA+IEkgd2FudCBrbm93IDoNCj4gPiA+
IMKgIDEuIHdoZXRoZXIgd2UgX211c3RfIHN0YWJsZSB0aGUgZGF0YSB0byB0aGUgc2VydmVyPw0K
PiA+ID4gwqAgMi4gaG93IHRvIGVuc3VyZSB0aGUgZGF0YSBub3QgbG9zdCB3aGVuIHVtb3VudCBz
dWNjZXNzIGJ1dA0KPiA+ID4gY2xpZW50IGNyYXNoPw0KPiA+ID4gwqAgMy4gdGhlIGRlbGF5ZWQg
ZnNub3RpZnkgdW1vdW50IGV2ZW50IGlzIHJlYXNvbmFibGUgb3Igbm90Pw0KPiA+ID4gwqAgNC4g
dGhlICduZnNfc2JfYWN0aXZlJyBzaG91bGQgYmUgdXNlZCB1bmRlciB3aGF0IHNjZW5hcmlvPw0K
PiA+ID4gDQo+ID4gPiBUaGFua3MuDQo+ID4gDQo+ID4gVGhhdCBoYXMgbm90aGluZyB0byBkbyB3
aXRoIEkvTy4gRGVsZWdhdGlvbnMgYXJlIHN0YXRlLg0KPiBTaW5jZSB0aGUgY2FsbGJhY2tzIGhv
bGQgdGhlICdzYi0+c19hY3RpdmUnLA0KPiB0aGUgdW1vdW50IG1heWJlIHJldHVybiBzdWNjZXNz
IHdpdGhvdXQgc2h1dGRvd24gdGhlIHN1cGVyYmxvY2suDQo+IA0KPiBJbiBnZW5lcmFsLCB0aGUg
c3VwZXJibG9jayBzaG91bGQgYmUgc2h1dGRvd24gYmVmb3JlIHVtb3VudCBzdWNjZXNzLA0KPiBi
dXQgaW4gdGhlIGNvbmN1cnJlbnQgc2NlbmFyaW8sIHRoZSBzdXBlcmJsb2NrIGlzIHNodXRkb3du
IGFmdGVyIHRoZQ0KPiBjYWxsYmFja3MgZmluaXNoLg0KPiANCj4gSWYgdGhlIHN5c3RlbSBpcyBj
cmFzaGVkIGluIHRoaXMgcGVyaW9kLCB3ZSBtYXkgbG9zdA0KPiAnc3luY19maWxlc3lzdGVtJywN
Cj4gdGhlbiB0aGUgcGFnZSBjYWNoZXMgKHdoaWNoIG5vdCBmbHVzaCB0byBzZXJ2ZXIgc2luY2Ug
aG9sZCB0aGUgd3JpdGUNCj4gZGVsZWdhdGlvbiB3aGVuIGNsb3NlIHRoZSBmaWxlKQ0KPiBhbmQg
bWV0YWRhdGEgY2FjaGVzIG1heWJlIGxvc3Q/DQoNCk5vLiBXZSBzdGlsbCBmbHVzaCB3cml0ZXMg
b24gY2xvc2UuIEV2ZW4gaWYgdGhhdCB3ZXJlIHRoZSBjYXNlLCB0aGVuIGl0DQppcyBubyBkaWZm
ZXJlbnQgZnJvbSB0aGUgYmVoYXZpb3VyIG9mIGJsb2NrIGRldmljZXMuDQoNCj4gDQo+IEFuZCB0
aGUgJ2Zzbm90aWZ5X3NiX2RlbGV0ZScgaXMgYWxzbyBjYWxsZWQgYWZ0ZXIgdGhlIGNhbGxiYWNr
cw0KPiBmaW5pc2guDQo+IElPVywgdGhlIHVtb3VudCBhbHJlYWR5IHJldHVybiB3aXRoIHN1Y2Nl
c3MsIGJ1dCB0aGUgRlNfVU5NT1VOVCBldmVudA0KPiBtYXliZSBkZWxheT8NCj4gDQo+IEkgaGF2
ZSBubyBpZGVhIGFib3V0IGl0IGlzIHJlYXNvbmFibGUgb3Igbm90Lg0KPiA+IA0KDQpJIGRvLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
