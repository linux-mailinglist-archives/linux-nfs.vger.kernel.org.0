Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F382FF2C0
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbhAUSCj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 13:02:39 -0500
Received: from mail-eopbgr690113.outbound.protection.outlook.com ([40.107.69.113]:65508
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389251AbhAUSCQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 13:02:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrb2OVObcYGFdjc5oil9+bQY4XQebJAAFlBp7ZZQLHtEfVfT3Ity8gFI4Pyp4lrWWHAhDDzoDf7pX/kSi59mRR/BWrw5ayFpL9fyuxjfYaCIYvMlnQGj5QUoC+ezhe5cLrpYScO/XpolcCh8K9tiBSUL+QMGMh2li+fAhvc3ioSxJYfqDFJNphsQk0w5HG1RicFg93K/Xln7yNZJtUSIzP686TnufwBFX4lA9PeYpeTxUTV/XLD0YDW99LV8YmtJBAnmHsdQ0FSm+GRTQhVpdZjOVUrB8IhkZnkMSvpzdvxXIzimAHDHEoKoeszNpx2cKHbE/pLT2PVsSlai3WbPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKGu/g6e6x7ctPEK8GUKxvvpyOd25adJr/XUlrToMpo=;
 b=XYzjm1uFW1Ni6oHriWXXYSuOET3Ym8Pz7z58N4PCTQQ0zTxq5F6TPWzP/Ux0SO0x5gUsPumDXs4rxAJ0DNEUm14e6BvjVrcdaio6QCKi7hn8UDnE+jlezQ5bhWAzChgYAAqCae+igA+MzcrOLQZvFZsGmpU24T7LjVDFTaCQnoMw5GHUWszqElnqBPPpoBBBHGE8STHysXsDgD2y9WXIgZmj6Z6I0vLFivTCgm3spc8eBVhkMaYoWbfPz2vJcHAn1SSlyuQ1/4DOoSNb4r2I3X1s52sPMXV3MIZL0Loz+1ujRM2Ljo2uXZfbnQbzKeMdSyiRLu+26ZYRMCTR8mdfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKGu/g6e6x7ctPEK8GUKxvvpyOd25adJr/XUlrToMpo=;
 b=O0+tjSy1cSJIgSweo6U5Cf6WZ+k3evA/ctsiaWFQlvNf9oF3KqKY6WSeYMnxCiIQqKHIF1GqiuqwQQsv8TgoXzpeJDqIT9YkwqPcFJ8w3G3FMhY7hQByKJkvFBc8y7xzejLjabDyhE2V2g4Quiu0a3gfCKouGSK73qZGjjw6fzA=
Received: from (2603:10b6:610:21::29) by
 CH0PR13MB4764.namprd13.prod.outlook.com (2603:10b6:610:df::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.7; Thu, 21 Jan 2021 18:01:28 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3805.006; Thu, 21 Jan 2021
 18:01:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 1/2] SUNRPC: Move simple_get_bytes and
 simple_get_netobj into xdr.h
Thread-Topic: [PATCH v2 1/2] SUNRPC: Move simple_get_bytes and
 simple_get_netobj into xdr.h
Thread-Index: AQHW8BFUpA/ZT1i+pEyZz1SO9zCmGqoyTvUAgAAFHoCAAAqcgA==
Date:   Thu, 21 Jan 2021 18:01:28 +0000
Message-ID: <168df2212fee0592976bc1c6d509d8eeffb477a2.camel@hammerspace.com>
References: <1611246016-21129-1-git-send-email-dwysocha@redhat.com>
         <1611246016-21129-2-git-send-email-dwysocha@redhat.com>
         <4a3f8595d74221ca560e7f92f1b3abc68f5d48a1.camel@hammerspace.com>
         <CALF+zOmNZPNam11aX_qf1q_1gG1ZcHam_uPriURXydbWJAe0Fw@mail.gmail.com>
In-Reply-To: <CALF+zOmNZPNam11aX_qf1q_1gG1ZcHam_uPriURXydbWJAe0Fw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.124.246.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90297f1a-27aa-457a-8b08-08d8be36935c
x-ms-traffictypediagnostic: CH0PR13MB4764:
x-microsoft-antispam-prvs: <CH0PR13MB47645DF1959BFC7D2CC59158B8A19@CH0PR13MB4764.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zble6mqbBKlO0OYhOLxX8LC70SinRcY0pPZtYnGO44XBOT9vkncMFMkVA2lQlxGEObzLNNhLnQGd3Ke5u8WY6KeQ9nAUYpuF3O4l3K5teHn5MkU8Z6L2cfHlT1UWUEg1ynVjGqpbTADnEM+WSle7GT8NeRpLxT93JlbkJdFHo3rZbA0XFIPLEuB2gbS83YhzTn7dCmBJFPRz0AUGuG53XT790/29/PAtiOQ95jlnA47DVhkgrZrnhBh6LkN3AHwqZ2lPUyeWurGwA5W1TESiHmOUrbsosOIwsMuYkxLCr6uhQorR0A2Fdj7UYy2NT0mpiN9IpsIhSg05TBj/G36FeFohXsnd9idbQBEDL85HOKc3xnJha29etMOeQvOgFcanuQ1PhmmBwvl8TdmSZ2RTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39840400004)(396003)(376002)(346002)(6486002)(53546011)(54906003)(6506007)(36756003)(2906002)(2616005)(5660300002)(8936002)(316002)(8676002)(186003)(26005)(83380400001)(6512007)(478600001)(4326008)(6916009)(86362001)(76116006)(71200400001)(66476007)(66446008)(64756008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NU5WODZubnJwTG54M0xQQmFROXg2MFU5RWZaL2hhcXdqb3VhbjBDLzhPY2pP?=
 =?utf-8?B?cGhlajVDL05HcFdqRk5HUWRTcUt1WDF0OWd4aUZ6dktpREUzSTdPMTRkRWNP?=
 =?utf-8?B?V21PL0VvOUNrb3pPWCtvSEJmdmw0WXFsR05RcUlJZmlWM3RLcG5LckNPRHVD?=
 =?utf-8?B?QjVyWll3bDhRUHhQVkk4Qzl1cnZRKzFUU0N4M0I3aFJTMlRDLzE0M1ZZSUNz?=
 =?utf-8?B?bW9hSGhtWnp3djg4eCt2dmVJNk5Ga0lKZHdYRFA5QlRYTzMvRnNoajFOTk8v?=
 =?utf-8?B?em1ydTNITnFjQzQ2UEhSV1R5VnZ4RVBSTGdqSWcybGsvVXp1U3NkVnpBYm1r?=
 =?utf-8?B?TFFPVmtWWFJ6Q01mNklPU2M4U0xZUnVCZGhWWE9Id2VVKzFZRFNldHFoWFc0?=
 =?utf-8?B?TEo5OVpsRDgzY1QwNmwxU2pTZDlzOG12MDhEVjVOeG80aFExV01XR0UzNEYv?=
 =?utf-8?B?cUtuQVBpK09sbGxHbGVOaFFXOUtEUGtaeWtuUmNhd05Xd0xUU3NaRFdNajZP?=
 =?utf-8?B?ZkVrRVJ4aHdweFVlOGVWU3c3WHJQeGtBRVhPZ0U2SWxxaEF2cWhVSUMzVWVs?=
 =?utf-8?B?WmNmMWc5aTgxWXp1Q1lUdTcvMEowdC95aVROeC9mb3JCdmlJVkJPNWI2Rm1n?=
 =?utf-8?B?MHQwaEFMUGVybDJiS29sVUtNamMwTmpnZ3VXVktIUUlNQUo3WlR5ekNWN2xp?=
 =?utf-8?B?NkpjSS9wNEtqd0U5WStPam54WGRiMWFsb1IxMHdWMUR1dzBJdER5VXVrK1VE?=
 =?utf-8?B?WlRuY0M0NXRqYmlwSW9RWm5UU0ZKanRYblNYRTdlUm1xb2RXNUI4MEhiVTdv?=
 =?utf-8?B?L1NGR1hQRVpXZmRsTXpZVGQ4a1ZRdnd3Mkp5ZVVDR2o1aDJ4eDdWc2JCdXZv?=
 =?utf-8?B?NWxsMG1ZeklrQ0FYb2Voc1FLd05rL1djdFBZeStHLzNCMitjWkpMaVZraTdI?=
 =?utf-8?B?U2p0dnIrcG1IQkRUanlxa2tNeUR5NHNyMk9SOG5kRkdmNUtldVZreDdmMmtU?=
 =?utf-8?B?VnczWFdjMlRnMVk4REgyMWMwblZUNlBmbi8rMzZHemwrZjNFK2p0cFU2bkZk?=
 =?utf-8?B?anUvZXB3cktsVGkzSjBCb3NncThGVXBkR3N4SGNyUlFYeXlCVFd6Mk5Nbmdo?=
 =?utf-8?B?K3dLcjVsdGtlUllRTmNCMUhNRXdPMW1zaWlxSEVBOTBJa0llWjlFNDUwRWc4?=
 =?utf-8?B?bThFZnNMaDJEeXY1ZVdXcXdZdlQ3OTdDSzNmMTJ4V0F1ZG5jdnlja1pMWVlh?=
 =?utf-8?B?Skc4R1RKb3VYcUlYZWlWWHk2UXlnTXNIa1pZYjYyYzYvNTBualJ0bG0xdVFS?=
 =?utf-8?Q?W1JPfgQYr8f2yLra2MNgpbEA2bh8acUAIF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C24EC3CB51E5469C3C1A63BDDD037F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90297f1a-27aa-457a-8b08-08d8be36935c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 18:01:28.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhTvzjFfKkbn+n6zQ3pHDqwlEqZfJQxkC21eno0kiGzBGBGMP7ipWrye2r2b2KZAQb1tUrRutdbin7JPyghLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4764
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDEyOjIzIC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gVGh1LCBKYW4gMjEsIDIwMjEgYXQgMTI6MDUgUE0gVHJvbmQgTXlrbGVidXN0DQo+
IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIx
LTAxLTIxIGF0IDExOjIwIC0wNTAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3RlOg0KPiA+ID4gUmVt
b3ZlIGR1cGxpY2F0ZWQgaGVscGVyIGZ1bmN0aW9ucyB0byBwYXJzZSBvcGFxdWUgWERSIG9iamVj
dHMNCj4gPiA+IGFuZCBwbGFjZSBpbnNpZGUgdGhlIHhkci5oIGZpbGUuwqAgQWxzbyB1cGRhdGUg
Y29tbWVudCB3aGljaA0KPiA+ID4gaXMgd3Jvbmcgc2luY2UgbG9ja2QgaXMgbm90IHRoZSBvbmx5
IHVzZXIgb2YgeGRyX25ldG9iai4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBX
eXNvY2hhbnNraSA8ZHd5c29jaGFAcmVkaGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBpbmNs
dWRlL2xpbnV4L3N1bnJwYy94ZHIuaMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMzDQo+ID4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiA+IMKgbmV0L3N1bnJwYy9hdXRoX2dz
cy9hdXRoX2dzcy5jwqDCoMKgwqDCoCB8IDI5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
PiAtLS0tDQo+ID4gPiAtLQ0KPiA+ID4gwqBuZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1X21l
Y2guYyB8IDI5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAtLS0tDQo+ID4gPiAtLQ0K
PiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDYwIGRlbGV0aW9ucygt
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmgN
Cj4gPiA+IGIvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmgNCj4gPiA+IGluZGV4IDE5YjZkZWEy
NzM2Ny4uOGVmNzg4ZmY4MGI5IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zdW5y
cGMveGRyLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oDQo+ID4gPiBA
QCAtMjUsOCArMjUsNyBAQA0KPiA+ID4gwqAjZGVmaW5lIFhEUl9RVUFETEVOKGwpwqDCoMKgwqDC
oMKgwqDCoCAoKChsKSArIDMpID4+IDIpDQo+ID4gPiANCj4gPiA+IMKgLyoNCj4gPiA+IC0gKiBH
ZW5lcmljIG9wYXF1ZSBgbmV0d29yayBvYmplY3QuJyBBdCB0aGUga2VybmVsIGxldmVsLCB0aGlz
DQo+ID4gPiB0eXBlDQo+ID4gPiAtICogaXMgdXNlZCBvbmx5IGJ5IGxvY2tkLg0KPiA+ID4gKyAq
IEdlbmVyaWMgb3BhcXVlIGBuZXR3b3JrIG9iamVjdC4nDQo+ID4gPiDCoCAqLw0KPiA+ID4gwqAj
ZGVmaW5lIFhEUl9NQVhfTkVUT0JKwqDCoMKgwqDCoMKgwqDCoCAxMDI0DQo+ID4gPiDCoHN0cnVj
dCB4ZHJfbmV0b2JqIHsNCj4gPiA+IEBAIC0zNCw2ICszMywzNiBAQCBzdHJ1Y3QgeGRyX25ldG9i
aiB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCB1OCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGF0YTsNCj4gPiA+IMKgfTsNCj4gPiA+IA0KPiA+ID4gK3N0YXRpYyBpbmxp
bmUgY29uc3Qgdm9pZCAqDQo+ID4gPiArc2ltcGxlX2dldF9ieXRlcyhjb25zdCB2b2lkICpwLCBj
b25zdCB2b2lkICplbmQsIHZvaWQgKnJlcywNCj4gPiA+IHNpemVfdA0KPiA+ID4gbGVuKQ0KPiA+
ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqcSA9IChjb25zdCB2b2lkICop
KChjb25zdCBjaGFyICopcCArIGxlbik7DQo+ID4gPiArwqDCoMKgwqDCoMKgIGlmICh1bmxpa2Vs
eShxID4gZW5kIHx8IHEgPCBwKSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBFUlJfUFRSKC1FRkFVTFQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBtZW1jcHkocmVz
LCBwLCBsZW4pOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gcTsNCj4gPiA+ICt9DQo+ID4g
PiArDQo+ID4gPiArc3RhdGljIGlubGluZSBjb25zdCB2b2lkICoNCj4gPiA+ICtzaW1wbGVfZ2V0
X25ldG9iaihjb25zdCB2b2lkICpwLCBjb25zdCB2b2lkICplbmQsIHN0cnVjdA0KPiA+ID4geGRy
X25ldG9iag0KPiA+ID4gKmRlc3QpDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoMKgwqDCoCBjb25z
dCB2b2lkICpxOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbGVuOw0KPiA+ID4g
Kw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBwID0gc2ltcGxlX2dldF9ieXRlcyhwLCBlbmQsICZsZW4s
IHNpemVvZihsZW4pKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihwKSkNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBwOw0KPiA+ID4gK8KgwqDCoMKg
wqDCoCBxID0gKGNvbnN0IHZvaWQgKikoKGNvbnN0IGNoYXIgKilwICsgbGVuKTsNCj4gPiA+ICvC
oMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHEgPiBlbmQgfHwgcSA8IHApKQ0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVGQVVMVCk7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgIGRlc3QtPmRhdGEgPSBrbWVtZHVwKHAsIGxlbiwgR0ZQX05PRlMpOw0KPiA+
ID4gK8KgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoZGVzdC0+ZGF0YSA9PSBOVUxMKSkNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0K
PiA+ID4gK8KgwqDCoMKgwqDCoCBkZXN0LT5sZW4gPSBsZW47DQo+ID4gPiArwqDCoMKgwqDCoMKg
IHJldHVybiBxOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiANCj4gPiBIbW0uLi4gSSdtIG5vdCB0
b28ga2VlbiBvbiBoYXZpbmcgdGhlc2UgaW4gc3VucnBjL3hkci5oLiBGb3Igb25lDQo+ID4gdGhp
bmcsDQo+ID4gdGhleSBkbyBub3QgZGVzY3JpYmUgb2JqZWN0cyB0aGF0IGFyZSBYRFIgZW5jb2Rl
ZC4gU2Vjb25kbHksIHRoZWlyDQo+ID4gbmFtaW5nIGlzbid0IHJlYWxseSBjb25zaXN0ZW50IHdp
dGggYW55IG9mIHRoZSBleGlzdGluZyBjb252ZW50aW9ucw0KPiA+IGZvcg0KPiA+IHhkci4NCj4g
PiANCj4gPiBDYW4gd2UgcGxlYXNlIHJhdGhlciBqdXN0IGNyZWF0ZSBhIG5ldyBoZWFkZXIgZmls
ZSB0aGF0IGlzIHByaXZhdGUNCj4gPiBpbg0KPiA+IG5ldC9zdW5ycGMvYXV0aF9nc3MvID8NCj4g
PiANCj4gDQo+IFN1cmUuwqAgRG8geW91IGhhdmUgYW55IHByZWZlcmVuY2UgZm9yIHRoZSBuYW1l
Pw0KPiBpbnRlcm5hbC5oDQo+IGF1dGhfZ3NzLmgNCj4gc29tZXRoaW5nIGVsc2UuLi4NCj4gDQoN
Ckl0IGlzIHVuZm9ydHVuYXRlIHRoYXQgd2UgYWxyZWFkeSBoYXZlIGFuIGF1dGhfZ3NzLmggaW4N
CmluY2x1ZGUvbGludXgvc3VucnBjLiBIb3cgYWJvdXQgYXV0aF9nc3NfaW50ZXJuYWwuaCBpbnN0
ZWFkPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
