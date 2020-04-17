Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16101AE131
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgDQPbK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 11:31:10 -0400
Received: from mail-eopbgr690095.outbound.protection.outlook.com ([40.107.69.95]:15684
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728959AbgDQPbJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:31:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brJLYd3+SkDjc48bSpkLjqO6d/d5z4L8CM/zZxemqNu1ybh1rTLD61GRpoKAlE/W4uZf9whZpzqDIKUIn0DViAfRjXO0BO6JePolBAzs1Nj7EeIDBK5Jv+Ow2wuhoNi/+o6sintzDS3lbIzou4N0FrtlLXFePwr97BzqHaHqk9z6YG1zJkg0QgqhLFpUjz3DZ0MyP8K8jsB/8gcZ6mRWEQtKCKOCDNnvHy7FCO5J5pbQx7pIKYrZJPYDWWfjggoUg1L1qV7/x7I5mGbBoPvxp1HIQdsFykL6HVCyPUK0aKVCKcaIUQmxVUhnbx6JHoEni7QzxrwT0QHIPBWgQ2Yqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvz4U8QSWB6zhVtRhRB+bKlZWoOTz+75Rvw23gUZR1M=;
 b=C8Y7lmvZyPJogz7V5Jfo6Qgkzaz5u4v4h3mZKmqHQM2OWtmRMgsIpQ3w2z3SsshVawbdTXf7u8Qzhvyij7L6xSiHAcfLn/Y3M4EzS9ElprBPXN7I8w5BHqpSg+nVV8RU6bX7llV08f+7O66wNjNYhRyQ86OuXSfZRozFE4Iq/ODuq77d8X+1hDxYVumkA1GXNd7U897/5ACUrYokx73UpL6Ei/qbNXyTZcqAtUrELuLbWEEK56GxhgFapXurS9Zi74qrqfVmv9qmdKusoi3rmYIWAaytz3mNc3iKmZW3Ajn5X+wAU9htojv/zJBgw8q2jSzbuuKHPVM1ozDNT5ks4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvz4U8QSWB6zhVtRhRB+bKlZWoOTz+75Rvw23gUZR1M=;
 b=KJ9+SRIX7W+Sayfkn0yjWOFhfkvXb5vOTb+q2xCrNs+efNV8cdR8gsKKyjGrcmrvSmz2ewKN9kwhwe7D2DwZvI0Ulq4wvV8NI0hYGD9wUTZnOtovxC/h6M75Td988RBiTM0EFT+UdTAsg1LJsqJIM9O5XwLRt3JM373ENBfYnCY=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3336.namprd13.prod.outlook.com (2603:10b6:610:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Fri, 17 Apr
 2020 15:31:04 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.007; Fri, 17 Apr 2020
 15:31:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Topic: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Index: AQHWFMsRjFm2JNXk8kav0WOkI+SUpah9cM+A
Date:   Fri, 17 Apr 2020 15:31:03 +0000
Message-ID: <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51e695e8-3165-4fae-86ce-08d7e2e4571b
x-ms-traffictypediagnostic: CH2PR13MB3336:
x-microsoft-antispam-prvs: <CH2PR13MB3336D68DE3FF1FF3BB9F9A56B8D90@CH2PR13MB3336.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(346002)(366004)(376002)(136003)(396003)(36756003)(66556008)(66946007)(64756008)(66446008)(5660300002)(66476007)(8676002)(478600001)(76116006)(91956017)(81156014)(2906002)(8936002)(4326008)(26005)(316002)(86362001)(6512007)(6506007)(186003)(6486002)(2616005)(110136005)(71200400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uyVFx6mewQunGvZnbMkUkrvUeXKolQ/I5sgopK7rykk+8kpO1rBzreIF/wvC9jUzxY9DGabSZjZ7EdHlaKhRROq+RiOmkp9Zo/yBqTRYzMO/53grbjZEUWOcrTQut2oPK7eKuZ7d1jgk5p1tHu8cOMItdtnWXmOESgf8heuHRJxSIFk0LwDBcQ7cgHDqVIp6eOUBM00kh6h941+vr61rqkMhaQgdpFveyIRW9x7NsUoHlido9yV1d6vDoLXkLmEF6G9PJJRN9Ug8TlMd64ed/fXTjaVJ+c9O+nuuIArPhmlxeTrTmXmN1I8O87K3k3M3K+aAtbBTZIcvodB6MzX6bkgImDmySgqmDXU3Iv/WhmSPeWdo8WbfUp1uucmIVerEV1vSv1Y3sEbaD6ADgyGErEz7JaYI4+VfYHD7bPOkaPRSM/PdfU4rbWbq6JDHuUzz
x-ms-exchange-antispam-messagedata: 8vYqwTQeIXd8hQJ8MWGHCsV1AZCuFBjr5nydVZaFVJ36zltR4SufSauQ+fEKG2FRYcrID/b9kGPblvnfdJBj4VI1KYC+aw+qvt3TzYiqpGdizfO25+Zoh3tQn8Q8vn1u5vpoApQMMLOC2KPPSU5T/eY4ScP8PU/jjOl3MiCBVc46a9Q3gxWTp2m+prabn0VSCosIyZkW9mrxOvUP0ez6Sf6T6blunMuwfovFdyAScm/r8zi6oigaQ2rz0We4LWXH+yRQ4YCXPGouV0UxQ9kUVDOOHI9Ihrf5YdAimvAVh+R4Cvj2n/skYnMf3qyll3HwrFtiYnkcC5OLeKfsYdRloj/Z5a78ZEfmtAeC2fmtbohNTujhG6DrhZoF5oGd+xaAFaphvlVMn6ZuVwfT32x6bt6KtD3MrXym4u0KmGjdM4p3btIpSonqftmVZHVFXs/CrjUx1PcWqtaIXkl3wMLJNi+pLLPxcK/ZYfZlSrnaHpyFKThRt8amYtHWmMEhuieNt1LMFbYkBCMtPeDgNUICtYB/flleYps31DtVGJCWx/9QuNV/gz7xCuZMwZKmFD4yDiussA8UxyPjYJ3DCeLWlwcWn5zjxlCjwCEl2EE5ErTSYKuJ48JWDGdinySe+zGoPpHx5KsvO0wiomX4XwVxmeClqdWwrV9HayLnYu9GmJtOJ5UaEHfZGVThoM0PKF0x29qGfL+93qFC84KbaeVuya8lWIWTmHSARAmNxdp8oWzpknYf9QtXfk4pqoLMxVPypFSycLCvEZk3KHrDsjgubHEcsBcnQ7Ws4BG9G0jVjU0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE581296BDD39D46811A581F5F7AF66A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e695e8-3165-4fae-86ce-08d7e2e4571b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 15:31:03.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKsXQD9Cr0heLtt/PQyrwZA9lPTr8kZ1WomNO5NsNWzyYN5s/uwqqgi/jK9DHpuv5HUhEcpXavYLjZE2KRdPOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3336
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gRnJpLCAyMDIwLTA0LTE3IGF0IDExOjE1IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gV2hlbiBuY29ubmVjdCBpcyB1c2VkLCBTRVFVRU5DRSBvcGVyYXRp
b24gY3VycmVudGx5IGlzbid0IGJvdW5kIHRvDQo+IGEgcGFydGljdWxhciB0cmFuc3BvcnQuIFRo
ZSBwcm9ibGVtIGlzIGNyZWF0ZWQgb24gYW4gaWRsZSBtb3VudCwNCj4gd2hlcmUgU0VRVUVOQ0Ug
aXMgdGhlIG9ubHkgb3BlcmF0aW9uIGJlaW5nIHNlbnQgYW5kIG9wZW5lZCBUUEMNCj4gY29ubmVj
dGlvbnMgYXJlIHNsb3dseSBiZWluZyBjbG9zZSBmcm9tIHRoZSBsYWNrIG9mIHVzZS4gSWYgU0VR
VUVOQ0UNCj4gaXMgbm90IGFzc2lnbmVkIHRvIHRoZSBtYWluIGNvbm5lY3Rpb24sIHRoZSBtYWlu
IGNvbm5lY3Rpb24gY2FuDQo+IGJlIGNsb3NlZCBhbmQgd2l0aCB0aGF0IHNvIGlzIHRoZSBiYWNr
IGNoYW5uZWwgYm91bmQgdG8gdGhhdA0KPiBjb25uZWN0aW9uLg0KPiANCj4gU2luY2UgdGhlIG9u
bHkgd2F5IGNsaWVudCBoYW5kbGVzIGNhbGxiYWNrX3BhdGggZG93biBpcyBieSBzZW5kaW5nDQo+
IEJJTkRfQ09OTl9UT19TRVNTSU9OIHJlcXVlc3RpbmcgdG8gYmluZCBib3RoIGJhY2tjaGFubmVs
IGFuZCBmb3JlDQo+IGNoYW5uZWwgb24gdGhlIGNvbm5lY3Rpb24gdGhhdCB3YXMgbGVmdCBnb2lu
ZywgYnV0IHRoYXQgY29ubmVjdGlvbg0KPiB3YXMgYWxyZWFkeSBib3VuZCB0byBvbmx5IGZvcmVj
aGFubmVsLiBBY2NvcmRpbmcgdG8gdGhlIHNwZWMsIGl0J3MNCj4gbm90IGFsbG93ZWQgdG8gY2hh
bmdlIGNoYW5uZWwgYmluZGluZyBhZnRlciB0aGV5IGFyZSBkb25lLg0KPiANCj4gVGhlIGZpeCBp
cyB0byBtYWtlIHN1cmUgdGhhdCBhIGxvbmUgU0VRVUVOQ0UgYWx3YXlzIGdvZXMgb24gdGhlDQo+
IG1haW4gY29ubmVjdGlvbiwga2VlcGluZyBiYWNrY2hhbm5lbCBhbGl2ZS4NCj4gDQo+IEZpeGVz
OiA1YTBjMjU3ZjggKCJORlM6IHNlbmQgc3RhdGUgbWFuYWdlbWVudCBvbiBhIHNpbmdsZQ0KPiBj
b25uZWN0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5l
dGFwcC5jb20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRwcm9jLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IDk5ZTlmMmUu
LjQ2MWY4NWQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25m
cy9uZnM0cHJvYy5jDQo+IEBAIC04ODU3LDcgKzg4NTcsNyBAQCBzdGF0aWMgc3RydWN0IHJwY190
YXNrDQo+ICpfbmZzNDFfcHJvY19zZXF1ZW5jZShzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwLA0KPiAg
CQkucnBjX2NsaWVudCA9IGNscC0+Y2xfcnBjY2xpZW50LA0KPiAgCQkucnBjX21lc3NhZ2UgPSAm
bXNnLA0KPiAgCQkuY2FsbGJhY2tfb3BzID0gJm5mczQxX3NlcXVlbmNlX29wcywNCj4gLQkJLmZs
YWdzID0gUlBDX1RBU0tfQVNZTkMgfCBSUENfVEFTS19USU1FT1VULA0KPiArCQkuZmxhZ3MgPSBS
UENfVEFTS19BU1lOQyB8IFJQQ19UQVNLX1RJTUVPVVQgfA0KPiBSUENfVEFTS19OT19ST1VORF9S
T0JJTiwNCj4gIAl9Ow0KPiAgCXN0cnVjdCBycGNfdGFzayAqcmV0Ow0KPiAgDQoNClRoaXMgd29y
a3Mgb25seSBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgY2xpZW50IGlzIG9ubHkgc2VuZGluZyBTRVFV
RU5DRQ0KaW5zdHJ1Y3Rpb25zLiBUaGVyZSBhcmUgb3RoZXIgY2FzZXMgd2hlcmUgaXQgY291bGQg
YmUgc2VuZGluZyBvdXQgb3RoZXINCm9wZXJhdGlvbnMgdGhhdCBhbHNvIHJlbmV3IHRoZSBsZWFz
ZSwgYnV0IGlzIGRvaW5nIGl0IHZlcnkNCmluZnJlcXVlbnRseS4gV29uJ3QgdGhhdCBhbHNvIHJ1
biBpbnRvIHRoZSBzYW1lIHByb2JsZW0/DQoNCklzIHRoZSBmdW5kYW1lbnRhbCBwcm9ibGVtIGhl
cmUgdGhhdCB3ZSdyZSBub3QgaGFuZGxpbmcgdGhlDQpTRVE0X1NUQVRVU19DQl9QQVRIX0RPV04g
LyBTRVE0X1NUQVRVU19DQl9QQVRIX0RPV05fU0VTU0lPTiBmbGFncw0KY29ycmVjdGx5IG9yIGlz
IHRoZXJlIHNvbWV0aGluZyBlbHNlIGdvaW5nIG9uPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
