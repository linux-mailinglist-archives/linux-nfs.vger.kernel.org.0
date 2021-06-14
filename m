Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3E3A696D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhFNO7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 10:59:05 -0400
Received: from mail-dm6nam12on2125.outbound.protection.outlook.com ([40.107.243.125]:40672
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233089AbhFNO7E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Jun 2021 10:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2xIOE4CZ5ZWMjv0oWNeNFqBu4UK30bYrek6MbOJjKGamFSmnorKFmqUn2fvQMUIK4kG/NQ0zU0d/ORTtlodxeu+UiBk5jN7fLSWpK+EOZatFVkx/gSdD3OUhIj3UClcn83Ysf/hnLaFEVKwgcvqc+6say6h12zKiCavhzQghJLFJN8wTWi2rd+fUdyY023enP/ekbvHuWjZgxO9ESoG4uVRGcODEzz02vgDcm7Hd1/kJjTLBBkuO5s1KID8wWTdJxDatwDX1ELrLML54AIaUgF62SXHrqjNxEV9GAeXfrCPtkICoyVjMoSBy1V/LFk/A6AX3BI04gsfV5Tn0PShhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWM7sWEGH0JihvZ2dWi1hDJs1m35VCD7eLQaeO0BRYE=;
 b=fsGzxkg6Kj8oogl28pqHB+NSlfcvslKoiSdEDnDkh+dJwZWIjvofon3DBVrZrKuG7NyihK8Kn5N6x1QX8a/NM7rnMLYUTX3QbW9EURoXpwyfKUv9i34XjR7CoWthmiHax709oAhlpnFhbZOonhMV7JChMAOCwBboeo3ell+3f9MIFddeRTZ/dFtx4fpfXDAmD6vKOSrvQxZgNNu+1LLbRxG/sA6rcFpykTn2rZhTPgHQgRM9wl5F5mTFG+jhk2GibIi0zPdRqiyEkdRAfKnuOajnH3kU/+1g1epRYQ8l8I8uSQG8iQNLnnIgNN5wW/NqNv3NeMjMR+H1nISbuh6Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWM7sWEGH0JihvZ2dWi1hDJs1m35VCD7eLQaeO0BRYE=;
 b=eHj0TQ8jMCrYjsvUIHrAvOVBBe03zD8UOEebVW5lRFQwzYqrxZUupsVlZZbr8kZhs+ByRZ2J7rR0hMSRYlc9D5+A0s4axOuy531tB2d2cScLE3PrV1Mv2B7eeJS0lmfX3Rv6H5RTMiScBZ4xTSjn/5zpWmXatTx/XmgJRCIHt64=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2426.namprd13.prod.outlook.com (2603:10b6:5:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.14; Mon, 14 Jun
 2021 14:56:56 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.015; Mon, 14 Jun 2021
 14:56:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "bfields@redhat.com" <bfields@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Topic: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Index: AQHXYSxS/VKgzyaqykaajV5W1gWJEKsTmK2A
Date:   Mon, 14 Jun 2021 14:56:55 +0000
Message-ID: <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
         <1623682098-13236-4-git-send-email-bfields@redhat.com>
In-Reply-To: <1623682098-13236-4-git-send-email-bfields@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15affe01-6891-4eb1-d10f-08d92f44a750
x-ms-traffictypediagnostic: DM6PR13MB2426:
x-microsoft-antispam-prvs: <DM6PR13MB24261F929A4D804B1D102456B8319@DM6PR13MB2426.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ap7rIdu9QooedYzUbnyU/Nj4Mpm9YTzTSQuR/RDJF+oneO2sNanlouffl2jLEASzHGu9j0HIUMuAuXyjOXW0gK3EbR0Q7d9g5JM64lN6zoo54lKtSF8GoZAKa2mH8RJ/xaH477hAzmWVHOEY/2mi1s/1h1dHncMtzuQ3r5CWMdPYFfom4TZMCZX/as2jodbEwIg+uOnxYvuNjUC+DP8M43+kOCW7Ymn4w8mT7DHkB0V2DHyr/gryHW03SUeYrxOlOZrrnPaIVa+ImS0Bs8W/u8dBvUcd+T/2E/Py4Zb8Z2C/qGV2U+WA4oOejqDoXPFqOSZAX+4R/80HnGnADyPztb/H8/ZQjIi3W2WdtRZuySu5lXfSDnNlz8QWBEV8x/thc6uzsxSehO22yILPVzqA3zDUvsM0J8fWGkXp9CMxTPr0x4oSRwNtzzQ7MlZEOWuhmgW8SA/4D9mfRwdhTSOqMAgo9mhgRLQuhdQyloRUIGgb3OYUkZxq2Ig4pfaw0seInPqZjl4PousexBkx4Rs9GEujSsYEyAn+z+4zBEAqmaWR4K7gI7XCXalHWvvBX7YsbNb/vahxDqUniW/e2XaAj8lcrGbpFIK75mF/0z5FBH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39830400003)(83380400001)(2906002)(66946007)(64756008)(66556008)(478600001)(122000001)(38100700002)(66446008)(76116006)(186003)(26005)(8936002)(110136005)(5660300002)(54906003)(4326008)(71200400001)(86362001)(6486002)(6506007)(8676002)(316002)(2616005)(6512007)(91956017)(66476007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9kdDNMTThEMWVycGtRdzVaSHk4c29wTGZhcE9xNmtJcmNkWkVYdGd5WUtJ?=
 =?utf-8?B?WlJVcWQwZ09mRWphTzViM2xCU1pyYWgxdnVIY2hhTWRJa3FIZzFhNEFzRVZz?=
 =?utf-8?B?eXB1enRJUkRIcFhsOFAzQTdIb0E0eWhMRXk2NlNtYmpXY0pxUlFqMlJaT25I?=
 =?utf-8?B?c0JXRy9xanNWOEtNNlJueTNwQ0Z3SG1FTFdlRmoyc1ZlekxkaGo2bGdLcytR?=
 =?utf-8?B?UzNIRXQ0a3dWQWZ5YXdsUDl5TTk1S2ExaVNmU0RzdTRtVDdzT1lxQ0RzSkdi?=
 =?utf-8?B?OGR0YjRsc0JKcmV1Y09QRmJ4WUcrWUNYT2ZxbGZMamFCZmhTU0x6cmMwdzht?=
 =?utf-8?B?ZGJCT2trVC9LTEo1OWtuTGJ4eHc2VjFVT2kzYTM0b3MrajFBbDJrUHVYZ3hS?=
 =?utf-8?B?S0ZvSElXd0Z4M2pTN3hvYWY2aGY1dVVHcnBmc0U3bkxHU3MwUUFMMHptZXRv?=
 =?utf-8?B?NDlPaGV6QTIxVkE4TjlmT1dhMjRMRkdyRlRDNUZPWlRtQVB0TFh0T3BTUTlx?=
 =?utf-8?B?VlZPTnRJL0JjUGpsUjlDZXJWb0ZDN0doYmgxVmhUUFplQnN4aVU3eFlLMWNX?=
 =?utf-8?B?ZXpEQlZnUitoUTdXcCt0MXY0RjJXa012ZXd1blBiNEVPajFVd1BQYnYwS0lI?=
 =?utf-8?B?Uit5dkk0eG0rWXNCQzlKdzJ2ZXlRaks4TnU2M3pXamF2Ymd3OVU2NkdPeHVX?=
 =?utf-8?B?RDlLNUM3WmYrSHhyc2dZRDJEVU0raUtxeXN0T2w0aGQxOTlDUHpubnBzNlFh?=
 =?utf-8?B?T01sSDY1R0paOUJhUkNwSmtyTkpoV3BsUzhySXNWb2hNZWZtcGJ6eDZUbC9F?=
 =?utf-8?B?SUxpN0NPajZTenR1ZGRveFdnUTZRRzhDekpGMXZrU0pleVU0NXZXZHh1cyt2?=
 =?utf-8?B?dithUjRyaGN2eXhSQ21TUlR0T3pmUE1qNHVacHM1VzVEODE4eGs2bVZ2blJZ?=
 =?utf-8?B?T0huYXhnTXJjMjRKWUllUUh4QnFOSjVvSHNkUVhEcnFVLzUyeXYxT2xXTWxk?=
 =?utf-8?B?NUpIaUxaUW9VZ3JhMFkwK0t1ZGZjY3QvNDh6bE1nM0dYNXJGeVY4UDlZeVBj?=
 =?utf-8?B?RHljc1B0Wm4wVFZwUnZ5RndEM3laRnlmWG9Xb1ZRVHg3M3RhK0JaMVgwbHpS?=
 =?utf-8?B?dm1lMUw3Vk1MV2pEM0N0ZkdRTnVrVjEwbVY1R1ZJdnM0cnFzQlBoVXlzMms4?=
 =?utf-8?B?ZlVhd1cySG1aMUdUcFJOVnVtaks0d25FVTJIeWxyYTNFOFZlYS9QMnRwTzE2?=
 =?utf-8?B?d2Rla0hIUldZdWhxT05DejVUa3Iyb2V3Sk9Rc3lEL1YrbXRrR28vdHZTT0VY?=
 =?utf-8?B?Y1NuRGhUQktLcDZhNHRiazR0SFljeFB0OGFiSHVJcEFkRnZOa1hWbSsxYmk0?=
 =?utf-8?B?eFVpWjlNUVQweTRpc2ZqK0NNbGp6WTE1aUkwb1QzMW5RUGxUTFN5ZnRaZm5t?=
 =?utf-8?B?Wm05Q1o5SzdEd3ZUWnlhYklzREVva1FiSkNmS3BzbHpPQ21DQ1dzTnM0K1Rj?=
 =?utf-8?B?VTFMVGxKNU92QkYybGxGS2ROZVZQMG15ZEM2YUhKbzdSclVqbXpINGhUVlMy?=
 =?utf-8?B?TWlPL1A1cGNlWDJHVFdLSURjUUNsYjc2K2QxTzQ0bDkxZmlESEt1eGowS3Vl?=
 =?utf-8?B?RTZJcktxa0ZCUitFR2d0RS8wQWl5cXlnWjBvWFZGMjJIZzZFRWloU01EYVdq?=
 =?utf-8?B?WXdXZUZPWGRTdkZtd29YK0FqV2c4eGZWOFRaU1dvbkVtT0VYRTMxLzkwRDV6?=
 =?utf-8?Q?nzsb29R5IkmcIGA7Sv9rEdyW8OoX7/j5ezj6W3/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1474F8E0AE50B24398301A51123215DC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15affe01-6891-4eb1-d10f-08d92f44a750
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 14:56:55.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uGaTcYblgyp3F+i5KiddZugIIScysWZzmLhFBPXsOgr4Ml8pzUyRrvx1pKvse2qrSb/l6ImLTWtyPvUhHM9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2426
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTE0IGF0IDEwOjQ4IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQHJlZGhhdC5jb20+DQo+IA0KPiBJ
biB0aGUgcmVleHBvcnQgY2FzZSwgbmZzZCBpcyBjdXJyZW50bHkgcGFzc2luZyBhbG9uZyBsb2Nr
cyB3aXRoIHRoZQ0KPiByZWNsYWltIGJpdCBzZXQuwqAgVGhlIGNsaWVudCBzZW5kcyBhIG5ldyBs
b2NrIHJlcXVlc3QsIHdoaWNoIGlzDQo+IGdyYW50ZWQNCj4gaWYgdGhlcmUncyBjdXJyZW50bHkg
bm8gY29uZmxpY3QtLWV2ZW4gaWYgaXQncyBwb3NzaWJsZSBhIGNvbmZsaWN0aW5nDQo+IGxvY2sg
Y291bGQgaGF2ZSBiZWVuIGJyaWVmbHkgaGVsZCBpbiB0aGUgaW50ZXJpbS4NCj4gDQo+IFdlIGRv
bid0IGN1cnJlbnRseSBoYXZlIGFueSB3YXkgdG8gc2FmZWx5IGdyYW50IHJlY2xhaW0sIHNvIGZv
ciBub3cNCj4gbGV0J3MganVzdCBkZW55IHRoZW0gYWxsLg0KPiANCj4gSSdtIGRvaW5nIHRoaXMg
YnkgcGFzc2luZyB0aGUgcmVjbGFpbSBiaXQgdG8gbmZzIGFuZCBsZXR0aW5nIGl0IGZhaWwNCj4g
dGhlDQo+IGNhbGwsIHdpdGggdGhlIGlkZWEgdGhhdCBldmVudHVhbGx5IHRoZSBjbGllbnQgbWln
aHQgYmUgYWJsZSB0byBkbw0KPiBzb21ldGhpbmcgbW9yZSBmb3JnaXZpbmcgaGVyZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiAt
LS0NCj4gwqBmcy9uZnMvZmlsZS5jwqDCoMKgwqDCoMKgIHwgMyArKysNCj4gwqBmcy9uZnNkL25m
czRzdGF0ZS5jIHwgMyArKysNCj4gwqBmcy9uZnNkL25mc3Byb2MuY8KgwqAgfCAxICsNCj4gwqBp
bmNsdWRlL2xpbnV4L2ZzLmjCoCB8IDEgKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZpbGUuYyBiL2ZzL25mcy9maWxlLmMN
Cj4gaW5kZXggMWZlZjEwNzk2MWJjLi4zNWEyOWI0NDBlM2UgMTAwNjQ0DQo+IC0tLSBhL2ZzL25m
cy9maWxlLmMNCj4gKysrIGIvZnMvbmZzL2ZpbGUuYw0KPiBAQCAtODA2LDYgKzgwNiw5IEBAIGlu
dCBuZnNfbG9jayhzdHJ1Y3QgZmlsZSAqZmlscCwgaW50IGNtZCwgc3RydWN0DQo+IGZpbGVfbG9j
ayAqZmwpDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBuZnNfaW5jX3N0YXRzKGlub2RlLCBORlNJ
T1NfVkZTTE9DSyk7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGlmIChmbC0+ZmxfZmxhZ3MgJiBG
TF9SRUNMQUlNKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1ORlNF
UlJfTk9fR1JBQ0U7DQoNCk5BQ0suIG5mc19sb2NrKCkgaXMgcmVxdWlyZWQgdG8gcmV0dXJuIGEg
UE9TSVggZXJyb3IuIEkga25vdyB0aGF0IHJpZ2h0DQpub3csIG5mc2QgaXMgdGhlIG9ubHkgdGhp
bmcgc2V0dGluZyBGTF9SRUNMQUlNLCBidXQgd2UgY2FuJ3QgZ3VhcmFudGVlDQp0aGF0IHdpbGwg
YWx3YXlzIGJlIHRoZSBjYXNlLg0KDQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoC8qIE5vIG1hbmRh
dG9yeSBsb2NrcyBvdmVyIE5GUyAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKF9fbWFuZGF0b3J5
X2xvY2soaW5vZGUpICYmIGZsLT5mbF90eXBlICE9IEZfVU5MQ0spDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZXJyOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9u
ZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gaW5kZXggMDBkOThiYmFiMmE2Li4z
ZWY0MmMwZDVkMzggMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gKysrIGIv
ZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBAQCAtNjkwMyw2ICs2OTAzLDkgQEAgbmZzZDRfbG9jayhz
dHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gbmZzZDRfY29tcG91bmRfc3RhdGUgKmNz
dGF0ZSwNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghbG9ja3NfaW5fZ3JhY2UobmV0KSAmJiBsb2Nr
LT5sa19yZWNsYWltKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0
Ow0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqBpZiAobG9jay0+bGtfcmVjbGFpbSkNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZsX2ZsYWdzIHw9IEZMX1JFQ0xBSU07DQo+ICsNCj4g
wqDCoMKgwqDCoMKgwqDCoGZwID0gbG9ja19zdHAtPnN0X3N0aWQuc2NfZmlsZTsNCj4gwqDCoMKg
wqDCoMKgwqDCoHN3aXRjaCAobG9jay0+bGtfdHlwZSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNhc2UgTkZTNF9SRUFEV19MVDoNCj4gZGlmZiAtLWdpdCBhL2ZzL25mc2Qv
bmZzcHJvYy5jIGIvZnMvbmZzZC9uZnNwcm9jLmMNCj4gaW5kZXggNjBkN2M1OWU3OTM1Li44MGM0
MzBjMzdhYjcgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZzcHJvYy5jDQo+ICsrKyBiL2ZzL25m
c2QvbmZzcHJvYy5jDQo+IEBAIC04ODEsNiArODgxLDcgQEAgbmZzZXJybm8gKGludCBlcnJubykN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB7IG5mc2Vycl9zZXJ2ZXJmYXVsdCwg
LUVORklMRSB9LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHsgbmZzZXJyX2lv
LCAtRVVDTEVBTiB9LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHsgbmZzZXJy
X3Blcm0sIC1FTk9LRVkgfSwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHsgbmZz
ZXJyX25vX2dyYWNlLCAtTkZTRVJSX05PX0dSQUNFfSwNCj4gwqDCoMKgwqDCoMKgwqDCoH07DQo+
IMKgwqDCoMKgwqDCoMKgwqBpbnTCoMKgwqDCoMKgaTsNCj4gwqANCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiBpbmRleCBjM2M4OGZkYjli
MmEuLjliZTQ3OTk5OTEwOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+ICsr
KyBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiBAQCAtOTk3LDYgKzk5Nyw3IEBAIHN0YXRpYyBpbmxp
bmUgc3RydWN0IGZpbGUgKmdldF9maWxlKHN0cnVjdCBmaWxlDQo+ICpmKQ0KPiDCoCNkZWZpbmUg
RkxfVU5MT0NLX1BFTkRJTkfCoMKgwqDCoMKgwqA1MTIgLyogTGVhc2UgaXMgYmVpbmcgYnJva2Vu
ICovDQo+IMKgI2RlZmluZSBGTF9PRkRMQ0vCoMKgwqDCoMKgwqAxMDI0wqDCoMKgwqAvKiBsb2Nr
IGlzICJvd25lZCIgYnkgc3RydWN0IGZpbGUgKi8NCj4gwqAjZGVmaW5lIEZMX0xBWU9VVMKgwqDC
oMKgwqDCoDIwNDjCoMKgwqDCoC8qIG91dHN0YW5kaW5nIHBORlMgbGF5b3V0ICovDQo+ICsjZGVm
aW5lIEZMX1JFQ0xBSU3CoMKgwqDCoMKgNDA5NsKgwqDCoMKgLyogcmVjbGFpbWluZyBmcm9tIGEg
cmVib290IHNlcnZlciAqLw0KPiDCoA0KPiDCoCNkZWZpbmUgRkxfQ0xPU0VfUE9TSVggKEZMX1BP
U0lYIHwgRkxfQ0xPU0UpDQo+IMKgDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
