Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8522A3602
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKBVcg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 16:32:36 -0500
Received: from mail-dm6nam10on2117.outbound.protection.outlook.com ([40.107.93.117]:46560
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgKBVcg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 16:32:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcJHLw30w9oWz/pNSsIIKzmKv5y8ZMEtB8QQ27Hy5XZmsarkpw4/3JCQIZHhNYSnTSlQb29F70RaKQNWS+3G/yeSIng03dgTEwsp2jsNH4kBsNh6aeT5/gIcnvNldBP09xoxQPWd4CZw69Lo1XSxAqZqZCOxrBarPJIrqfV3GSbZiZT5df2wl4RS3v5+AqG9WbC+VeG8EOwx71rysh7uBewpFGvru8dCtQV9c9+hyEZHBCGS8B5WKdslTImP9ebLchdQ2YTRgHoVjmfkFEtmHiYE8G1pZhmW2npIAn4liviWpKL45XxHaSj7Ozrf5qmffnkbb/W62IrZcLUo5C1pZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJb8fSqSrKCaM9b5wB5yFPnI58w66ADZS3F82VdHucE=;
 b=fkh2mFjaHSAJOB12mSfecxhWrjqPfsY7jr9MhAkCJXT7m9FI8H1fAgst0BQviy1qgN8N00FVaKZ/+TR90ZIE5kkqrI1B0V+t7qkxR4+X/OGg43gVnro1dc82dKgVtquhxEgMujNlcer026IHq5YDKCcKnlZOltHywTPvvyYH3LQeHBTDrDSUzD0ml0mQU7WSiBZe0NFpagcVVANfd8n6i6fT0mUTecvM/OP1Ob+eS6w9unvoJFEBTcvhFcrMsdcxyp7NG5znJ1baTmKwJe8TJi8Xqsn8fX5nJMBlpDciX0ODPk4VcEdbZ038fjlirqHp1JVW1tSiyGe2c2g/Ty3sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJb8fSqSrKCaM9b5wB5yFPnI58w66ADZS3F82VdHucE=;
 b=WLm/0j1Sl/aL/+WlfLwtL0tKs30ZMQnmJM0sCd/QpqmCe957PyN3Jt7DUO/WoRQYqluePaHB/GOmAJGsqjXcjeaIi1yI7e5cy2CYLKbr+HdrvdKxg+OsRFrcqTqWisTE5RakPXjhConzaoMbrfZecKLc/j3I2lMXliN1djSbvJk=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3198.namprd13.prod.outlook.com (2603:10b6:208:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 2 Nov
 2020 21:32:32 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.010; Mon, 2 Nov 2020
 21:32:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] Readdir enhancements
Thread-Topic: [PATCH 00/12] Readdir enhancements
Thread-Index: AQHWsURphCIBMaG44UWslt+RffEISqm1Tl8AgAAOb4A=
Date:   Mon, 2 Nov 2020 21:32:32 +0000
Message-ID: <d138ab6baf73a19d7808dc36b506a8f723c9f986.camel@hammerspace.com>
References: <20201102180658.6218-1-trondmy@kernel.org>
         <CALF+zOm4LwsgBBcA8AoHA2NMZddkRdCXRM8UNqBSxd6gj1ci9g@mail.gmail.com>
In-Reply-To: <CALF+zOm4LwsgBBcA8AoHA2NMZddkRdCXRM8UNqBSxd6gj1ci9g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538ffce3-4e65-4cba-8477-08d87f76cece
x-ms-traffictypediagnostic: MN2PR13MB3198:
x-microsoft-antispam-prvs: <MN2PR13MB31988176203DDB5A307D828DB8100@MN2PR13MB3198.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KBKso6uRMSnDUuDHRPosG+w5v7p3dcpbkrHvqgo+2CRKzVhnnB0/OKeH5FIVJkIy/ufPwJskN7Jl4gjYdMLdNojuUKxuBv9FIMv0iokeVzRZaqNkZ2nfkouM5I+Fd8qWzgahsQeN3KCGxCa8ZqMa4btTxu/SyqmfPkkbxOY7JXnzT1ECfSyapgsNw/Yc3g4v6bDO049YC+p580lmKkvis7TvNF/deLcwlLls+K411lR0EA+13cfZ102XVwGPAjZCpxhH4EspQp3I5LJglocFb4aO1t0cnB4AF4xdznrje6K5S7Ce771mVcF6ZhDl10m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39830400003)(5660300002)(2906002)(186003)(71200400001)(91956017)(26005)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(36756003)(83380400001)(8936002)(8676002)(86362001)(316002)(478600001)(2616005)(53546011)(6512007)(6916009)(6506007)(6486002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wUuzD5oHbNaMWGxy+jqJ3ZtQmYyjBjDrV71ruK3eAMfCKESfEYI775Y8pdvJc96grFxt8vqT5fmHN4uJVnUyVaEpUG78+8Yt89nTkYEfqKkXhpE+HS57fdnRR6ZoWvfYQSSAFVDJfl9R/E8KrYdcxmqJ3bFvEjTSnVSRE6Jy0kX5bVEgq6qpj6KS1BT1EzC7Soy5g2y5y7EFjZHcDPN+LOd4uqDdR+WWFcnoImYwu61AY3L5rndWJh2t/CoCHDT7TEQhxJRZLqhvWBKGAF33qrK5jbU8OXPqaPqR5+z87f4bp/qOyCC0m+HQrVcmwDkH2fYI0+S7v2H74rJzO9j9lE8FK+1AXj+wecECmbzIN2reGHUh1s58idBGYn/A4pojRijExk6X5/5bNKovYAXjFgXwxEJh6Sja01IiC8EPf+Ss5E22eCGRuVYJUzi9Br9++j4uO2Ey4P8KGEUQN1hq0UlvosepXM18ZBLnT9rnI937esUC7jHRK8UfXQm/BAXU3j/r6/Mn2w4v4wsJxdg7TGhgfFiqMHLWPpzJgKRUBNE9rKfowHc3QOOJw70cH/zcGJWT5uviYqpETEGQOC9ymtV1WnMRZOoJj5OUHvfNqDHfUf/Lixx2r3I16JQdqrB7AhYh33xjaPXYfNqWisCy1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3A470C5B897B443BA287C9DBCAB9613@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ffce3-4e65-4cba-8477-08d87f76cece
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 21:32:32.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdISsdvVLXJKa/lPRthwgZXFTF08U0yS7pZh12sNAGnViJ4ccvy+13yei36wnbQoSybqfC1p5jRjL+mgXi0Q/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3198
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTAyIGF0IDE1OjQwIC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMiwgMjAyMCBhdCAxOjE3IFBNIDx0cm9uZG15QGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIHBhdGNoIHNlcmllcyBw
ZXJmb3JtcyBhIG51bWJlciBvZiBjbGVhbnVwcyBvbiB0aGUNCj4gPiByZWFkZGlyDQo+ID4gY29k
ZS4NCj4gPiBJdCBhbHNvIGFkZHMgc3VwcG9ydCBmb3IgMU1CIHJlYWRkaXIgUlBDIGNhbGxzIG9u
LXRoZS13aXJlLCBhbmQNCj4gPiBtb2RpZmllcw0KPiA+IHRoZSBjYWNoaW5nIGNvZGUgdG8gZW5z
dXJlIHRoYXQgd2UgY2FjaGUgdGhlIGVudGlyZSBjb250ZW50cyBvZg0KPiA+IHRoYXQNCj4gPiAx
TUIgY2FsbCAoaW5zdGVhZCBvZiBkaXNjYXJkaW5nIHRoZSBkYXRhIHRoYXQgZG9lc24ndCBmaXQg
aW50byBhDQo+ID4gc2luZ2xlDQo+ID4gcGFnZSkuDQo+ID4gDQo+ID4gVHJvbmQgTXlrbGVidXN0
ICgxMik6DQo+ID4gwqAgTkZTOiBFbnN1cmUgY29udGVudHMgb2Ygc3RydWN0IG5mc19vcGVuX2Rp
cl9jb250ZXh0IGFyZQ0KPiA+IGNvbnNpc3RlbnQNCj4gPiDCoCBORlM6IENsZWFuIHVwIHJlYWRk
aXIgc3RydWN0IG5mc19jYWNoZV9hcnJheQ0KPiA+IMKgIE5GUzogQ2xlYW4gdXAgbmZzX3JlYWRk
aXJfcGFnZV9maWxsZXIoKQ0KPiA+IMKgIE5GUzogQ2xlYW4gdXAgZGlyZWN0b3J5IGFycmF5IGhh
bmRsaW5nDQo+ID4gwqAgTkZTOiBEb24ndCBkaXNjYXJkIHJlYWRkaXIgcmVzdWx0cw0KPiA+IMKg
IE5GUzogUmVtb3ZlIHVubmVjZXNzYXJ5IGttYXAgaW4gbmZzX3JlYWRkaXJfeGRyX3RvX2FycmF5
KCkNCj4gPiDCoCBORlM6IFJlcGxhY2Uga21hcCgpIHdpdGgga21hcF9hdG9taWMoKSBpbg0KPiA+
IG5mc19yZWFkZGlyX3NlYXJjaF9hcnJheSgpDQo+ID4gwqAgTkZTOiBTaW1wbGlmeSBzdHJ1Y3Qg
bmZzX2NhY2hlX2FycmF5X2VudHJ5DQo+ID4gwqAgTkZTOiBTdXBwb3J0IGxhcmdlciByZWFkZGly
IGJ1ZmZlcnMNCj4gPiDCoCBORlM6IE1vcmUgcmVhZGRpciBjbGVhbnVwcw0KPiA+IMKgIE5GUzog
bmZzX2RvX2ZpbGxkaXIoKSBkb2VzIG5vdCByZXR1cm4gYSB2YWx1ZQ0KPiA+IMKgIE5GUzogUmVk
dWNlIHJlYWRkaXIgc3RhY2sgdXNhZ2UNCj4gPiANCj4gPiDCoGZzL25mcy9jbGllbnQuY8KgwqDC
oMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4gPiDCoGZzL25mcy9kaXIuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNTU1ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAtLS0t
DQo+ID4gwqBmcy9uZnMvaW50ZXJuYWwuaMKgwqDCoMKgwqAgfMKgwqAgNiAtDQo+ID4gwqBpbmNs
dWRlL2xpbnV4L25mc19mcy5oIHzCoMKgIDEgLQ0KPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAzMjUg
aW5zZXJ0aW9ucygrKSwgMjQxIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tDQo+ID4gMi4yOC4w
DQo+ID4gDQo+IA0KPiBOaWNlIHRvIHNlZSB0aGVzZSwgZXNwZWNpYWxseQ0KPiBbUEFUQ0ggMDUv
MTJdIE5GUzogRG9uJ3QgZGlzY2FyZCByZWFkZGlyIHJlc3VsdHMNCj4gDQo+IEFyZSB5b3UgdGVz
dGluZyB0aGVzZSBvbiB0b3Agb2YgNS4xMC1yYzIgb3Igc29tZXRoaW5nIGVsc2U/DQo+IA0KVGhl
eSBhcmUgYmVpbmcgdGVzdGVkIG9uIDUuMTAtcmMyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
