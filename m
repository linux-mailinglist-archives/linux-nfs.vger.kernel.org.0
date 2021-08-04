Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2D3DF8B9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhHDAEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 20:04:47 -0400
Received: from mail-bn8nam08on2133.outbound.protection.outlook.com ([40.107.100.133]:52736
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234132AbhHDAEq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 20:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ+zScx9QGPZ+0mcNKD2UZ7Toqaon3rElc+HD1lrw3MSUMMatXXaw+4LG2eqvRP8uZy93V2BKMMC/187is+rLUsZAPZi7WO3KpWZABDQ+Sry+lmGLLQcZ64HBShr9Fk95R2/SuBmlJR6NtghfufmRVWg717Jtp7lBwh18sACHCWOFHill1RMzDnGUBffo7ZMyVbeCkriFuyvI3ye2SM33vVhfJeddGmr/Hc1dAipGO7OkQYAr8k/8rUO8a8MUNXJmjEurJViIwIkK7y9f7W3tSsF8xQMupTXAB/y9Wpim7W0ofTPUEczF9yMD4eT04rAMdCJjtsVSa1urKL25yf9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OymH1q6U776SCYhp7/rajrAoWMcFKSMQXcA61vO7Uls=;
 b=WinbxUB3qsrVRDbiSYs9RTSze26QAHWeizvqNsHbq00ajBMsuMSrTdHvmmqkPQVO5ict/40Uw6g+dWKs149VcNJsld2mpDNdsCMFBn3/yFsbVTqzKSfzqvcsQuxczO32mmlraAetcbvJ/68biSx9w3HPHsbqK21hxARCBYiWZ0/IHZuduwY6BUw/GGcrmGvjTOA0luJrU3N9Tfi9LbJxhKAeZgvNHIV4qfY2f6AZ8dT8cHINscfvhsk5JHxEVx2L3qhrv9hZTZ6/Zb7fYpoDWJ2RmcdN37hwf6WkHkVGoQc+f7EcjZso9JGK4JyxN5kb1WrrU21Vo6h7Cmio4v2xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OymH1q6U776SCYhp7/rajrAoWMcFKSMQXcA61vO7Uls=;
 b=DfXcrAqzzOFnb84Prs4uC1YoAwls7gsQZj+bfIzUtlOCxx4PL7QTF7DuiU/CjXb6XyqxiuRvSa1s4wdxm70MS9cQTbbloti3a4yc12wbaaDM3WkULmZQZtpJQiPmWJdWTg3VfJDVMtj38K9aaaX17unK1qwHWGAEJ8N6WHFAKUI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5115.namprd13.prod.outlook.com (2603:10b6:610:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.12; Wed, 4 Aug
 2021 00:04:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 00:04:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WAgAABQIA=
Date:   Wed, 4 Aug 2021 00:04:32 +0000
Message-ID: <4c2be981f40a6be310975fff924d768b88e9ea3d.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>      ,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>              ,
 <20210803203051.GA3043@fieldses.org>      ,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>              ,
 <20210803213642.GA4042@fieldses.org>      ,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
         <162803443497.32159.4120609262211305187@noble.neil.brown.name>
         <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
In-Reply-To: <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d47e42-dad2-4fbe-6e29-08d956db7000
x-ms-traffictypediagnostic: CH0PR13MB5115:
x-microsoft-antispam-prvs: <CH0PR13MB511552D1B54A9D5957AC5CC3B8F19@CH0PR13MB5115.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mc9ULoKFPUKrcjWJreh/mCy1zhtHoPR9U0YEMKmApAVj3Fo71Sc/GHplPqVcZClCz+GxTuhi09n9qY2d0YaKdXlzM/BzyJzDH2tWVRc0bo5QqYebCK+czpwyZCnYcViBDUicHpZLuEfdt79xj6AanUXtrE/tVns6nqCVRfL+04a4gy24KjaKf9kLIKuWAPW3gUWe04yMa9yxQCxBbTlHHbDGN2RSFBQc4URsY61GbEFfzE1n8ZMo4z4N5keO19rr98IjNyKdkcMaCDWDWPUlX6e7+uCR3WxAtaOijblGjlAIA9i4F2n66EAg1OpIRhUSuQu4xj2xCuKKWd/5U0eLvrgsSZJPsFgFdn6ONjK0uCDOLfqaKngHHHwmjGGv5T5Lgx+TbB+35PhWR6ixvHawM/P4ACbOGqV9SRLFLT35YcVSckVS9zPTyLjt4r3hPndJkKvfSSHDVPXsAe85bOv7/itHwaS1urfScqp6QOV5WZv7bgvC7ka21JAvNUi1tmqTfGWxJNUnyJDJ1b/Qk6Zb5s5vaU15kOjKV+5ewKxIWqClXlsLyjsTEr7s6Myn0TJPAot0XQjEF9AIGOOA0N8jNGOHfAkaJ/jbo9qyI/VufxuqPxuVulmtc89mXn5lflClTJvK86x08YykIV9BuNzZqWO2ebFzAT33jiJ3//qwO5oCxKbamqwTnlezbEDlWEXxgyuW7DcalepiASGsLGBt3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(38100700002)(6512007)(316002)(54906003)(71200400001)(508600001)(8936002)(8676002)(2906002)(6916009)(66946007)(64756008)(66446008)(76116006)(36756003)(2616005)(38070700005)(5660300002)(66556008)(66476007)(6506007)(83380400001)(186003)(122000001)(26005)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk1ya2w5dytuUk5FNlpCeE1jZWZ5TUJzVGxhWFI4M01rdkRlYmpXVStoUjJE?=
 =?utf-8?B?b1hjaFJSZW1XaEZxMFFDTUNhTmtKcklvVWsvWEdFTFk5a2lLZFRGV2gvS2Q1?=
 =?utf-8?B?SFQyaDhPc0I4QlNLR3RsdVBRYWh0UjFIay9kNkg4Y3loUEQ5OFB2Rzl0OTJp?=
 =?utf-8?B?M2tKMCtLc1NMSENqSlJWajlrUGExc1d1ckg5dmlTMEZOQW9qOGlsNUoxT0NT?=
 =?utf-8?B?S0RuT2hYekpRWDM3Tk5zRk1NYyt5RUpEa3hYUkdPa1FpWksxMWlCaU5tUHJi?=
 =?utf-8?B?SEMrSkJHVVdRVHdCdkZwU21NeUhmaFlIWkFtRU80RVBvNDZ4cmMwcUNIUkEx?=
 =?utf-8?B?aFcyVFhmL0hWQUJnOEY5c3EyNEZET1c2L3JZb0ozT2tjZWtPRVErSEI2OVNz?=
 =?utf-8?B?T1htdk9yOTFvdldMV05rR3liRmhPWGZDTldvVDJUTEtkSC9xb1A4bkpzWDJo?=
 =?utf-8?B?TjlzVEE2QjJKMlArZ3phRlByc2dmN25tdlpSczJacHhiTkVMUmFCRjUxNnlL?=
 =?utf-8?B?aGJFZWY1c3IzeUZzVW82NjhzMjd5RS9lRUJMVTFBR3Z4bm5mcDlsU0RSWGhM?=
 =?utf-8?B?djgwSnE1UkM5VUZRU2wvWENGenFSNXZCeU9uZ1l2SEpBUXdGNGZKZ0I0RVZa?=
 =?utf-8?B?VlJ4NUx1aXBGUjBkbUl6MVRJL0FrQmx3ZzJDTTlhYUV0WmhuODNtK2g0WVNK?=
 =?utf-8?B?ZUFHbHJqTzhXK2hHcUhudWJCRmR4dW1ZNVFiTHdOS3JoMkphT2grOGVJeDFJ?=
 =?utf-8?B?VVVwemFyOWNibkxJMnJPa0dwVUxUcGpuM1RxYWdjSFFyWGxSOHVCeXY4bFNZ?=
 =?utf-8?B?dExHNEdZSithbTViOW90UFdxbEd6ZGhrQ0NPMldIOWtJM3F5UzVpWDlsbDlB?=
 =?utf-8?B?VEh3UE1kVmF5ZllCK3BYMVJYT2tSK3FHQ0ZjL0JBeFArbFBLR2tUaG50eXAz?=
 =?utf-8?B?VmxzN3N3cktEOUZybi9FN2orVkRab2ZIbkV1d2xWb3VFWXBJVnN4YlV5UjJ2?=
 =?utf-8?B?Z1lWWi9taUovU3k5Q3FNeTVTaUFCRXFYUEFGUDMybnJ4cGpBRG5YcUNQSUlS?=
 =?utf-8?B?RzJZNHJzajhRTWNnVjRkTjVnZzRsT0pOS3NZNm9tWWVablg0QlBkRzBHdGxM?=
 =?utf-8?B?Q2xiMXltNHl6OTJoOFFPNjQ2YXN1VVZISldaOWNIV0hHVWU5N0kyNG9Sejg3?=
 =?utf-8?B?RkptK0MxNWs4ejN5MHRHN0pSdW5BRHJuRkw1MGEzaHpQUlFPQnd4TkRHdW9S?=
 =?utf-8?B?SzFPSFdkWi9JR1QvZlg4YnIzbUNwK3lTN1pIZ2lsbk1TYVRpZzdiMVVMdXBG?=
 =?utf-8?B?NUk1ZzdQOGdLaHlzSlBRQTQ4VFQvQ3FSZWFyYjlXVW9ERWFwNW92MTRqc3BZ?=
 =?utf-8?B?Nm9DdURYNHY2WnFSeVRkQTZQZERTUE9neXFLWjZ5OHBBbDV6KytOWm5ValBP?=
 =?utf-8?B?SXBJMm9RMGlqcllJMXRBQUhNZWN5YzU5dDFFS3ZKNjNaNGJNOUpZNWdvMUk3?=
 =?utf-8?B?M2lPNXJQRjEyZmZoclVNZ2FpckkrS2hCcVRuSmRZOHluV1hQM3FJazJGRzZq?=
 =?utf-8?B?b3hxaXN3amZhdEp0L0VhMk1iekR3RzNjUDFQc1Q3UW4yRE9KVDk2MWlGVWsw?=
 =?utf-8?B?NnU5MTBDVWJUMkpXV1VmREh1UDkwcHpMQStQaGd0SFhucXVvZXg0NmpYZ2dt?=
 =?utf-8?B?OUd6SzhDalZiSlY5LzYwTCsvZzlLWEVQUXZ0QW5ndmhkbHNsU1dqMENBQWh4?=
 =?utf-8?Q?UQ/RmGbA8+8p4FiP4kORo6lld+xJnSqdN0L1wed?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A793B3F30FC2E49A421653D1D2A4986@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d47e42-dad2-4fbe-6e29-08d956db7000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 00:04:32.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bhy9IFfQQ7Boib7GOFk4A0gmgpi6Qf6yyQ067xlrPVTQ+DqXEbZjSge5OrsrwnCSF8yhBk4lKz0KQ3TYXdRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5115
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTA0IGF0IDAwOjAwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMS0wOC0wNCBhdCAwOTo0NyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0K
PiA+IE9uIFdlZCwgMDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgMjAyMS0wOC0wMyBhdCAxNzozNiAtMDQwMCwgYmZpZWxkc0BmaWVsZHNlcy5vcmfCoHdy
b3RlOg0KPiA+ID4gPiBPbiBUdWUsIEF1ZyAwMywgMjAyMSBhdCAwOTowNzoxMVBNICswMDAwLCBU
cm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCAyMDIxLTA4
LTAzIGF0IDE2OjMwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gPiBP
biBGcmksIEp1bCAzMCwgMjAyMSBhdCAwMjo0ODo0MVBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBGcmksIDIwMjEtMDctMzAgYXQg
MDk6MjUgLTA0MDAsIEJlbmphbWluIENvZGRpbmd0b24NCj4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gSSBoYXZlIHNvbWUgZm9sa3MgdW5oYXBweSBhYm91dCBiZWhhdmlvciBj
aGFuZ2VzIGFmdGVyOg0KPiA+ID4gPiA+ID4gPiA+IDQ3OTIxOTIxOGZiZQ0KPiA+ID4gPiA+ID4g
PiA+IE5GUzoNCj4gPiA+ID4gPiA+ID4gPiBPcHRpbWlzZSBhd2F5IHRoZSBjbG9zZS10by1vcGVu
IEdFVEFUVFIgd2hlbiB3ZSBoYXZlDQo+ID4gPiA+ID4gPiA+ID4gTkZTdjQNCj4gPiA+ID4gPiA+
ID4gPiBPUEVODQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQmVmb3JlIHRoaXMg
Y2hhbmdlLCBhIGNsaWVudCBob2xkaW5nIGEgUk8gb3BlbiB3b3VsZA0KPiA+ID4gPiA+ID4gPiA+
IGludmFsaWRhdGUNCj4gPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBwYWdlY2Fj
aGUgd2hlbiBkb2luZyBhIHNlY29uZCBSVyBvcGVuLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+IE5vdyB0aGUgY2xpZW50IGRvZXNuJ3QgaW52YWxpZGF0ZSB0aGUgcGFnZWNhY2hl
LCB0aG91Z2gNCj4gPiA+ID4gPiA+ID4gPiB0ZWNobmljYWxseQ0KPiA+ID4gPiA+ID4gPiA+IGl0
IGNvdWxkDQo+ID4gPiA+ID4gPiA+ID4gYmVjYXVzZSB3ZSBzZWUgYSBjaGFuZ2VhdHRyIHVwZGF0
ZSBvbiB0aGUgUlcgT1BFTg0KPiA+ID4gPiA+ID4gPiA+IHJlc3BvbnNlLg0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IEkgZmVlbCB0aGlzIGlzIGEgZ3JleSBhcmVhIGluIENUTyBp
ZiB3ZSdyZSBhbHJlYWR5DQo+ID4gPiA+ID4gPiA+ID4gaG9sZGluZyBhbg0KPiA+ID4gPiA+ID4g
PiA+IG9wZW4uwqANCj4gPiA+ID4gPiA+ID4gPiBEbyB3ZQ0KPiA+ID4gPiA+ID4gPiA+IGtub3cg
aG93IHRoZSBjbGllbnQgb3VnaHQgdG8gYmVoYXZlIGluIHRoaXMgY2FzZT/CoA0KPiA+ID4gPiA+
ID4gPiA+IFNob3VsZA0KPiA+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGNsaWVu
dCdzIG9wZW4NCj4gPiA+ID4gPiA+ID4gPiB1cGdyYWRlIHRvIFJXIGludmFsaWRhdGUgdGhlIHBh
Z2VjYWNoZT8NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IEl0J3Mgbm90IGEgImdyZXkgYXJlYSBpbiBjbG9zZS10by1vcGVuIiBhdCBhbGwuIEl0IGlzDQo+
ID4gPiA+ID4gPiA+IHZlcnkNCj4gPiA+ID4gPiA+ID4gY3V0DQo+ID4gPiA+ID4gPiA+IGFuZA0K
PiA+ID4gPiA+ID4gPiBkcmllZC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IElmIHlv
dSBuZWVkIHRvIGludmFsaWRhdGUgeW91ciBwYWdlIGNhY2hlIHdoaWxlIHRoZSBmaWxlDQo+ID4g
PiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiA+IG9wZW4sDQo+ID4gPiA+ID4gPiA+IHRoZW4NCj4g
PiA+ID4gPiA+ID4gYnkgZGVmaW5pdGlvbiB5b3UgYXJlIGluIGEgc2l0dWF0aW9uIHdoZXJlIHRo
ZXJlIGlzIGENCj4gPiA+ID4gPiA+ID4gd3JpdGUNCj4gPiA+ID4gPiA+ID4gYnkNCj4gPiA+ID4g
PiA+ID4gYW5vdGhlcg0KPiA+ID4gPiA+ID4gPiBjbGllbnQgZ29pbmcgb24gd2hpbGUgeW91IGFy
ZSByZWFkaW5nLiBZb3UncmUgY2xlYXJseSBub3QNCj4gPiA+ID4gPiA+ID4gZG9pbmcNCj4gPiA+
ID4gPiA+ID4gY2xvc2UtDQo+ID4gPiA+ID4gPiA+IHRvLW9wZW4uDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IERvY3VtZW50YXRpb24gaXMgcmVhbGx5IHVuY2xlYXIgYWJvdXQgdGhpcyBjYXNl
LsKgIEV2ZXJ5DQo+ID4gPiA+ID4gPiBkZWZpbml0aW9uIG9mDQo+ID4gPiA+ID4gPiBjbG9zZS10
by1vcGVuIHRoYXQgSSd2ZSBzZWVuIHNheXMgdGhhdCBpdCByZXF1aXJlcyBhIGNhY2hlDQo+ID4g
PiA+ID4gPiBjb25zaXN0ZW5jeQ0KPiA+ID4gPiA+ID4gY2hlY2sgb24gZXZlcnkgYXBwbGljYXRp
b24gb3Blbi7CoCBJJ3ZlIG5ldmVyIHNlZW4gb25lIHRoYXQNCj4gPiA+ID4gPiA+IHNheXMNCj4g
PiA+ID4gPiA+ICJvbg0KPiA+ID4gPiA+ID4gZXZlcnkgb3BlbiB0aGF0IGRvZXNuJ3Qgb3Zlcmxh
cCB3aXRoIGFuIGFscmVhZHktZXhpc3RpbmcNCj4gPiA+ID4gPiA+IG9wZW4NCj4gPiA+ID4gPiA+
IG9uDQo+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiBjbGllbnQiLg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBUaGV5ICp1c3VhbGx5KiBhbHNvIHByZWZhY2UgdGhhdCBieSBzYXlpbmcg
dGhhdCB0aGlzIGlzDQo+ID4gPiA+ID4gPiBtb3RpdmF0ZWQNCj4gPiA+ID4gPiA+IGJ5DQo+ID4g
PiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IHVzZSBjYXNlIHdoZXJlIG9wZW5zIGRvbid0IG92ZXJs
YXAuwqAgQnV0IGl0J3MgbmV2ZXIgbWFkZQ0KPiA+ID4gPiA+ID4gY2xlYXINCj4gPiA+ID4gPiA+
IHRoYXQNCj4gPiA+ID4gPiA+IHRoYXQncyBwYXJ0IG9mIHRoZSBkZWZpbml0aW9uLg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIG5vdCBmb2xsb3dpbmcgeW91ciBsb2dp
Yy4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0J3MganVzdCBhIHF1ZXN0aW9uIG9mIHdoYXQgZXZlcnkg
c291cmNlIEkgY2FuIGZpbmQgc2F5cw0KPiA+ID4gPiBjbG9zZS0NCj4gPiA+ID4gdG8tDQo+ID4g
PiA+IG9wZW4NCj4gPiA+ID4gbWVhbnMuwqAgRS5nLiwgTkZTIElsbHVzdHJhdGVkLCBwLiAyNDgs
ICJDbG9zZS10by1vcGVuDQo+ID4gPiA+IGNvbnNpc3RlbmN5DQo+ID4gPiA+IHByb3ZpZGVzIGEg
Z3VhcmFudGVlIG9mIGNhY2hlIGNvbnNpc3RlbmN5IGF0IHRoZSBsZXZlbCBvZiBmaWxlDQo+ID4g
PiA+IG9wZW5zDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiBjbG9zZXMuwqAgV2hlbiBhIGZpbGUgaXMg
Y2xvc2VkIGJ5IGFuIGFwcGxpY2F0aW9uLCB0aGUgY2xpZW50DQo+ID4gPiA+IGZsdXNoZXMNCj4g
PiA+ID4gYW55DQo+ID4gPiA+IGNhY2hlZCBjaGFuZ3MgdG8gdGhlIHNlcnZlci7CoCBXaGVuIGEg
ZmlsZSBpcyBvcGVuZWQsIHRoZSBjbGllbnQNCj4gPiA+ID4gaWdub3Jlcw0KPiA+ID4gPiBhbnkg
Y2FjaGUgdGltZSByZW1haW5pbmcgKGlmIHRoZSBmaWxlIGRhdGEgYXJlIGNhY2hlZCkgYW5kDQo+
ID4gPiA+IG1ha2VzDQo+ID4gPiA+IGFuDQo+ID4gPiA+IGV4cGxpY2l0IEdFVEFUVFIgY2FsbCB0
byB0aGUgc2VydmVyIHRvIGNoZWNrIHRoZSBmaWxlDQo+ID4gPiA+IG1vZGlmaWNhdGlvbg0KPiA+
ID4gPiB0aW1lLiINCj4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIGNsb3NlLXRvLW9wZW4gbW9kZWwg
YXNzdW1lcyB0aGF0IHRoZSBmaWxlIGlzIG9ubHkgYmVpbmcNCj4gPiA+ID4gPiBtb2RpZmllZCBi
eQ0KPiA+ID4gPiA+IG9uZSBjbGllbnQgYXQgYSB0aW1lIGFuZCBpdCBhc3N1bWVzIHRoYXQgZmls
ZSBjb250ZW50cyBtYXkgYmUNCj4gPiA+ID4gPiBjYWNoZWQNCj4gPiA+ID4gPiB3aGlsZSBhbiBh
cHBsaWNhdGlvbiBpcyBob2xkaW5nIGl0IG9wZW4uDQo+ID4gPiA+ID4gVGhlIHBvaW50IGNoZWNr
cyBleGlzdCBpbiBvcmRlciB0byBkZXRlY3QgaWYgdGhlIGZpbGUgaXMNCj4gPiA+ID4gPiBiZWlu
Zw0KPiA+ID4gPiA+IGNoYW5nZWQNCj4gPiA+ID4gPiB3aGVuIHRoZSBmaWxlIGlzIG5vdCBvcGVu
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IExpbnV4IGRvZXMgbm90IGhhdmUgYSBwZXItYXBwbGlj
YXRpb24gY2FjaGUuIEl0IGhhcyBhIHBhZ2UNCj4gPiA+ID4gPiBjYWNoZQ0KPiA+ID4gPiA+IHRo
YXQNCj4gPiA+ID4gPiBpcyBzaGFyZWQgYW1vbmcgYWxsIGFwcGxpY2F0aW9ucy4gSXQgaXMgaW1w
b3NzaWJsZSBmb3IgdHdvDQo+ID4gPiA+ID4gYXBwbGljYXRpb25zDQo+ID4gPiA+ID4gdG8gb3Bl
biB0aGUgc2FtZSBmaWxlIHVzaW5nIGJ1ZmZlcmVkIEkvTywgYW5kIHlldCBzZWUNCj4gPiA+ID4g
PiBkaWZmZXJlbnQNCj4gPiA+ID4gPiBjb250ZW50cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFJpZ2h0
LCBzbyBiYXNlZCBvbiB0aGUgZGVzY3JpcHRpb25zIGxpa2UgdGhlIG9uZSBhYm92ZSwgSSB3b3Vs
ZA0KPiA+ID4gPiBoYXZlDQo+ID4gPiA+IGV4cGVjdGVkIGJvdGggYXBwbGljYXRpb25zIHRvIHNl
ZSBuZXcgZGF0YSBhdCB0aGF0IHBvaW50Lg0KPiA+ID4gDQo+ID4gPiBXaHk/IFRoYXQgd291bGQg
YmUgYSBjbGVhciB2aW9sYXRpb24gb2YgdGhlIGNsb3NlLXRvLW9wZW4gcnVsZQ0KPiA+ID4gdGhh
dA0KPiA+ID4gbm9ib2R5IGVsc2UgY2FuIHdyaXRlIHRvIHRoZSBmaWxlIHdoaWxlIGl0IGlzIG9w
ZW4uDQo+ID4gPiANCj4gPiANCj4gPiBJcyB0aGUgcnVsZQ0KPiA+IEEgLcKgICJpdCBpcyBub3Qg
cGVybWl0dGVkIGZvciBhbnkgb3RoZXIgYXBwbGljYXRpb24vY2xpZW50IHRvIHdyaXRlDQo+ID4g
dG8NCj4gPiDCoMKgwqDCoMKgIHRoZSBmaWxlIHdoaWxlIGFub3RoZXIgaGFzIGl0IG9wZW4iDQo+
ID4gwqBvcg0KPiA+IEIgLcKgICJpdCBpcyBub3QgZXhwZWN0ZWQgZm9yIGFueSBvdGhlciBhcHBs
aWNhdGlvbi9jbGllbnQgdG8gd3JpdGUNCj4gPiB0bw0KPiA+IMKgwqDCoMKgwqAgdGhlIGZpbGUg
d2hpbGUgYW5vdGhlciBoYXMgaXQgb3BlbiINCj4gPiANCj4gPiBJIHRoaW5rIEIsIGJlY2F1c2Ug
QSBpcyBjbGVhcmx5IG5vdCBlbmZvcmNlZC7CoCBUaGF0IHN1Z2dlc3RzIHRoYXQNCj4gPiB0aGVy
ZQ0KPiA+IGlzIG5vICpuZWVkKiB0byBjaGVjayBmb3IgY2hhbmdlcywgYnV0IGVxdWFsbHkgdGhl
cmUgaXMgbm8gYmFycmllcg0KPiA+IHRvDQo+ID4gY2hlY2tpbmcgZm9yIGNoYW5nZXMuwqAgU28g
dGhhdCBmYWN0IHRoYXQgb25lIGFwcGxpY2F0aW9uIGhhcyB0aGUNCj4gPiBmaWxlDQo+ID4gb3Bl
biBzaG91bGQgbm90IHByZXZlbnQgYSBjaGVjayB3aGVuIGFub3RoZXIgYXBwbGljYXRpb24gb3Bl
bnMgdGhlDQo+ID4gZmlsZS4NCj4gPiBFcXVhbGx5IGl0IHNob3VsZCBub3QgcHJldmVudCBhIGZs
dXNoIHdoZW4gc29tZSBvdGhlciBhcHBsaWNhdGlvbg0KPiA+IGNsb3Nlcw0KPiA+IHRoZSBmaWxl
Lg0KPiA+IA0KPiA+IEl0IGlzIHNvbWV3aGF0IHdlaXJkIHRoYXQgaWYgYW4gYXBwbGljYXRpb24g
b24gb25lIGNsaWVudA0KPiA+IG1pc2JlaGF2ZXMNCj4gPiBieQ0KPiA+IGtlZXBpbmcgYSBmaWxl
IG9wZW4sIHRoYXQgd2lsbCBwcmV2ZW50IG90aGVyIGFwcGxpY2F0aW9ucyBvbiB0aGUNCj4gPiBz
YW1lDQo+ID4gY2xpZW50IGZyb20gc2VlaW5nIG5vbi1sb2NhbCBjaGFuZ2VzLCBidXQgd2lsbCBu
b3QgcHJldmVudA0KPiA+IGFwcGxpY2F0aW9ucw0KPiA+IG9uIG90aGVyIGNsaWVudHMgZnJvbSBz
ZWVpbmcgYW55IGNoYW5nZXMuDQo+ID4gDQo+ID4gTmVpbEJyb3duDQo+IA0KPiBOby4gV2hhdCB5
b3UgcHJvcG9zZSBpcyB0byBvcHRpbWlzZSBmb3IgYSBmcmluZ2UgY2FzZSwgd2hpY2ggd2UNCj4g
Y2Fubm90DQo+IGd1YXJhbnRlZSB3aWxsIHdvcmsgYW55d2F5LiBJJ2QgbXVjaCByYXRoZXIgb3B0
aW1pc2UgZm9yIHRoZSBjb21tb24NCj4gY2FzZSwgd2hpY2ggaXMgdGhlIG9ubHkgY2FzZSB3aXRo
IHByZWRpY3RhYmxlIHNlbWFudGljcy4NCj4gDQoNClRoZSBwb2ludCBpcyB0aGF0IHdlIGRvIHN1
cHBvcnQgdW5jYWNoZWQgSS9PIChhLmsuYS4gT19ESVJFQ1QpDQpwcmVjaXNlbHkgZm9yIHRoZSBj
YXNlcyB3aGVyZSB1c2VycyBjYXJlIGFib3V0IHRoZSBkaWZmZXJlbmNlIGluIHRoZQ0KYWJvdmUg
dG8gc2NlbmFyaW9zLiBXaHkgc2hvdWxkIHdlIGJyZWFrIGNhY2hlZCBJL08ganVzdCBiZWNhdXNl
IG9mIEZVRD8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
