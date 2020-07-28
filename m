Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0486A231189
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgG1SVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 14:21:24 -0400
Received: from mail-mw2nam10on2116.outbound.protection.outlook.com ([40.107.94.116]:38881
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728829AbgG1SVX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jul 2020 14:21:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnxy5TLcWWBcZedbPfFEw4t2ApahG2VBTgx5zB9O+tuxQ23LjiijUh3nOQCbQLo+0Drhp2DUew8oo1Qtoy+gaqk5jGcHcotHIGdAhrvrh3KX2uS4ppBulpAAm9RyCE5Oo6CrPLBLy3zs8nTUed7XbS6gia7WxDZK2K7nX61JtfuNNW5Q/AINq5NsmjQXMa9L+ZlpbYD7Vo6ViSapg6fDGGjgy2E9qXI4VgC3LnyKILP34g6SPhDg7Cyvr9LnfMTmzuBFmuG9HNOaFPVzEi5oKkLXKd8tkEugUgpPhyzyjGK1VpKp0zAvqV2iHzSc3/aKSvpiFR1xZhOznLIFzP5Zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1LO/+46jIxi2BjuiobjFiGulaJh5BUWdhzob3e8AYM=;
 b=HsMzuJ8qN4XeEtiR4+MdKPjkiu3i2Z0xeyhdv8ficWSIH4rFQutJuy9UM+DCXWL6/yxMxg1oIiAtZIjY3PWebwaAYeNh7JPJf1YQF3KD0GRdDSqUUuHhGZeGNxirEEqKbFqHobQ0WDQIpUkkjA5EuwriBsDM32wRmOtsTz+LP0plhuJ4EViuzdbIAfjPHKPmGH5CTXYJ01WgiieoFE8VRd2Y+p34lG9ETle8PyAppsbNB/CXVz/pF0hrEU/bRmFdQBDqQbUUd9gofdkCIH3zffTrZbunS0bne3ui4tPaWC7F+Qbuk5Yud1+JBqnWUG7QgFYUAw4zl4h6TuEbw1WxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1LO/+46jIxi2BjuiobjFiGulaJh5BUWdhzob3e8AYM=;
 b=ZJ5HmuNjYBDoicuxpR7GrUcabLkPD90OTPKyG6AarJJyAHUPj+GuUK8rKrD+tvczEO1QAXqYYbV/q3Ofmv+Gsn1K0Lqa4g+kzI824FDcDGJAEvhV+8+VfFznY86jy9pTC0i7yrIKc06t/NfNNuKY0o0+CuO2M66RZ/sIjRgBMek=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3863.namprd13.prod.outlook.com (2603:10b6:610:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Tue, 28 Jul
 2020 18:21:19 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 18:21:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Topic: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Index: AQHWZAhvCZQFVT7SMUyvX1UCoywirakbn4CAgAF8w4CAAA66gIAAEPOAgAAODoCAAAD5AIAAAneAgAACRgA=
Date:   Tue, 28 Jul 2020 18:21:19 +0000
Message-ID: <d006b84e722cbebf9a94b8816bd59e11bc7d5219.camel@hammerspace.com>
References: <20200727112344.GH389488@mwanda>
         <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
         <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <61d4e88c18818cd94dfbd14f054e6a2cb8858c8d.camel@hammerspace.com>
         <20200728180051.GA10902@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <13f86f29cc05944894813632bd537e559859e254.camel@hammerspace.com>
         <20200728181309.GA14661@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200728181309.GA14661@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 208ccd4b-8d47-40a0-3fee-08d833230686
x-ms-traffictypediagnostic: CH2PR13MB3863:
x-microsoft-antispam-prvs: <CH2PR13MB386315DCC5627D120D52FDFBB8730@CH2PR13MB3863.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRtrbdBBVMf4GrE4aU616pEWlFH8A3gSnhrmgLAvyclV5roQrf5dcWH9x16VgnrW/t1ERza6cxGtQvz0v6/JhltUNfcfwAXHfHGfCW01F2DcXQBJB4UPihsU5+Ifzbqwyy+BDttti2RR9paaGNepxdS/lxSItkum4I5AFjS4uDsZ09P0mrAtq0cJ0DSgJq2bWV6h8bvCmIXHzjrCD6my4JKyDvvZZeM/z77P9EwewKxU8shsoz5nCCtjemE2mYuiNOGZ+GZSNR4EpHIj1UQIm1GnJoH1WnhtOty7ssJo0wfyqaNGQJLvICLapHw2iYQX1o3JmP9uS1BbKx8J0jF1AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(396003)(136003)(376002)(346002)(6506007)(6916009)(8936002)(186003)(71200400001)(8676002)(4326008)(26005)(478600001)(6486002)(86362001)(5660300002)(36756003)(66476007)(66946007)(83380400001)(6512007)(2616005)(54906003)(76116006)(316002)(66556008)(64756008)(66446008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g4uW/4IeZu/sazvxkGtzuVJZ7HVRT6qWbUHHtLzjTTKsI9OS0qywinuRm+XF5NXaARPKXlVhGNQgPHrDJUqsGpPsNTWrg2Z8SrnPcMTXdwN7h5hfN0ez38Wc8rYPyGLmkaeOeTmclztdpyaHQW6+YoSparWYTDIE8o6zQbLonZl1X3PofHJeg3rdjVdvFhGnQH0D9gtFReyg9La7EUVCuOdD4JpMU7SISTcb1BV6M1cJqYDfkBsYfBKL8OLqCDcRUrR2PqksgUC+bd6fKXrcnqweH9E+bnGVQwt4et/hxycB86daKTxInz/PdHzwT0aqKJUkfxhZNurbjYoRXYr+s/hPGrU/B0sDVYETE5Rv7NGXH/uSKGkZZDfAIkSoWZa+E4ULTU0XPAvPkqnhnYctS3+15xa9oAC9KLiFO6gR5IFkbNL/rOkRel+GpS1uoM+8nVMtMwihpb/SmcwLckpmC7IQ+nF6AcUDEuJ0xraoEwZ2HOe702PidDWRxLuVQnOEnDhuLZRPe1Nm9zVe/u6+8LVDg9PVF2OPZ9nhw2lTmr1VylN18w3J0K62vHV/THnkbB26lZLTIO/wQsSOyRDjjaOEiSjXb5kTRvbQ/qGvptJPq6HiVuiNsdfu9CYulhNfi8Edf1zmricmFYMmkm+tBQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D1698D00806FE4EB32CBB35BDEFEE2A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208ccd4b-8d47-40a0-3fee-08d833230686
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 18:21:19.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMX9Hpsn5liUjVh69Ge/+1TFbH24cxKo6Is1J1oOxXVjkYrQRSvP414x0QJC2NhCEhWm7IxtDoCO/PLUA194dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3863
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTI4IGF0IDE4OjEzICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gT24gVHVlLCBKdWwgMjgsIDIwMjAgYXQgMDY6MDQ6MjFQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wNy0yOCBhdCAxODowMCArMDAwMCwg
RnJhbmsgdmFuIGRlciBMaW5kZW4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEp1bCAyOCwgMjAyMCBh
dCAwNToxMDozNFBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIFR1
ZSwgMjAyMC0wNy0yOCBhdCAxNjowOSArMDAwMCwgRnJhbmsgdmFuIGRlciBMaW5kZW4gd3JvdGU6
DQo+ID4gPiA+ID4gSGkgVHJvbmQsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gVHVlLCBKdWwg
MjgsIDIwMjAgYXQgMDM6MTc6MTJQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIDIwMjAtMDctMjcgYXQgMTY6MzQgKzAwMDAsIEZy
YW5rIHZhbiBkZXIgTGluZGVuDQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSGkg
RGFuLA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMjcsIDIwMjAg
YXQgMDI6MjM6NDRQTSArMDMwMCwgRGFuIENhcnBlbnRlcg0KPiA+ID4gPiA+ID4gPiB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIHNob3VsZCByZXR1cm4gLUVOT01FTSBvbiBmYWlsdXJlIGlu
c3RlYWQgb2YNCj4gPiA+ID4gPiA+ID4gPiBzdWNjZXNzLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IEZpeGVzOiA5NWFkMzdmOTBjMzMgKCJORlN2NC4yOiBhZGQgY2xpZW50IHNp
ZGUgeGF0dHINCj4gPiA+ID4gPiA+ID4gPiBjYWNoaW5nLiIpDQo+ID4gPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiA+
ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ICBm
cy9uZnMvbmZzNDJ4YXR0ci5jIHwgNCArKystDQo+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczQyeGF0dHIuYyBiL2ZzL25mcy9u
ZnM0MnhhdHRyLmMNCj4gPiA+ID4gPiA+ID4gPiBpbmRleCAyM2ZkYWI5NzdhMmEuLmU3NWM0YmI3
MDI2NiAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvbmZzNDJ4YXR0ci5jDQo+
ID4gPiA+ID4gPiA+ID4gKysrIGIvZnMvbmZzL25mczQyeGF0dHIuYw0KPiA+ID4gPiA+ID4gPiA+
IEBAIC0xMDQwLDggKzEwNDAsMTAgQEAgaW50IF9faW5pdA0KPiA+ID4gPiA+ID4gPiA+IG5mczRf
eGF0dHJfY2FjaGVfaW5pdCh2b2lkKQ0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBn
b3RvIG91dDI7DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICBuZnM0
X3hhdHRyX2NhY2hlX3dxID0NCj4gPiA+ID4gPiA+ID4gPiBhbGxvY193b3JrcXVldWUoIm5mczRf
eGF0dHIiLA0KPiA+ID4gPiA+ID4gPiA+IFdRX01FTV9SRUNMQUlNLCAwKTsNCj4gPiA+ID4gPiA+
ID4gPiAtICAgICAgIGlmIChuZnM0X3hhdHRyX2NhY2hlX3dxID09IE5VTEwpDQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICBpZiAobmZzNF94YXR0cl9jYWNoZV93cSA9PSBOVUxMKSB7DQo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ID4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgIGdvdG8gb3V0MTsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIH0NCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHJldCA9DQo+ID4gPiA+ID4g
PiA+ID4gcmVnaXN0ZXJfc2hyaW5rZXIoJm5mczRfeGF0dHJfY2FjaGVfc2hyaW5rZXIpOw0KPiA+
ID4gPiA+ID4gPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiA+ID4gPiA+ID4gPiAtLQ0KPiA+ID4g
PiA+ID4gPiA+IDIuMjcuMA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGF0IG9uZS4gU2luY2UgdGhpcyBpcyBhZ2Fp
bnN0DQo+ID4gPiA+ID4gPiA+IGxpbnV4LQ0KPiA+ID4gPiA+ID4gPiBuZXh0DQo+ID4gPiA+ID4g
PiA+IHZpYQ0KPiA+ID4gPiA+ID4gPiBUcm9uZCwNCj4gPiA+ID4gPiA+ID4gSSBhc3N1bWUgVHJv
bmQgd2lsbCBhZGQgaXQgdG8gaGlzIHRyZWUgKHJpZ2h0PykNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IEluIGFueSBjYXNlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBGcmFuayB2YW4gZGVyIExpbmRlbiA8ZmxsaW5kZW5A
YW1hem9uLmNvbT4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiAtIEZyYW5rDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEZyYW5rLCB3aHkgZG8gd2UgbmVl
ZCBhIHdvcmtxdWV1ZSBoZXJlIGF0IGFsbD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgeGF0
dHIgY2FjaGVzIGFyZSBwZXItaW5vZGUsIGFuZCBnZXQgY3JlYXRlZCBvbiBkZW1hbmQuDQo+ID4g
PiA+ID4gSW52YWxpZGF0aW5nDQo+ID4gPiA+ID4gYSBjYWNoZSBpcyBkb25lIGJ5IHNldHRpbmcg
dGhlIGludmFsaWRhdGUgZmxhZyAoYXMgaXQgaXMgZm9yDQo+ID4gPiA+ID4gb3RoZXINCj4gPiA+
ID4gPiBjYWNoZWQgYXR0cmlidWVzIGFuZCBkYXRhKS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBX
aGVuIG5mczRfeGF0dHJfZ2V0X2NhY2hlKCkgc2VlcyBhbiBpbnZhbGlkYXRlZCBjYWNoZSwgaXQN
Cj4gPiA+ID4gPiB3aWxsDQo+ID4gPiA+ID4ganVzdA0KPiA+ID4gPiA+IHVubGluayBpdA0KPiA+
ID4gPiA+IGZyb20gdGhlIGlub2RlLCBhbmQgY3JlYXRlIGEgbmV3IG9uZSBpZiBuZWVkZWQuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIG9sZCBjYWNoZSB0aGVuIHN0aWxsIG5lZWRzIHRvIGJl
IGZyZWVkLiBUaGVvcmV0aWNhbGx5LA0KPiA+ID4gPiA+IHRoZXJlDQo+ID4gPiA+ID4gY2FuDQo+
ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiBxdWl0ZSBhIGZldyBlbnRyaWVzIGluIGl0LCBhbmQgbmZz
NF94YXR0cl9nZXRfY2FjaGUoKSB3aWxsIGJlDQo+ID4gPiA+ID4gY2FsbGVkDQo+ID4gPiA+ID4g
aW4NCj4gPiA+ID4gPiB0aGUgZ2V0L3NldHhhdHRyIHN5c3RlbWNhbGwgcGF0aC4gU28gbXkgcmVh
c29uaW5nIGhlcmUgd2FzDQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IGl0J3MNCj4gPiA+ID4g
PiBiZXR0ZXINCj4gPiA+ID4gPiB0byB1c2UgYSB3b3JrcXVldWUgdG8gZnJlZSB0aGUgb2xkIGlu
dmFsaWRhdGVkIGNhY2hlIGluc3RlYWQNCj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IHdhc3RpbmcN
Cj4gPiA+ID4gPiBjeWNsZXMgaW4gdGhlIEkvTyBwYXRoLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IC0gRnJhbmsNCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgd2UgbWlnaHQgd2FudCB0byBleHBs
b3JlIHRoZSByZWFzb25zIGZvciB0aGlzIGFyZ3VtZW50Lg0KPiA+ID4gPiBXZQ0KPiA+ID4gPiBk
bw0KPiA+ID4gPiBub3Qgb2ZmbG9hZCBhbnkgb3RoZXIgY2FjaGUgaW52YWxpZGF0aW9ucywgYW5k
IHRoYXQgaW5jbHVkZXMNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGNhc2UNCj4gPiA+ID4gd2hlbiB3
ZSBoYXZlIHRvIGludmFsaWRhdGUgdGhlIGVudGlyZSBpbm9kZSBkYXRhIGNhY2hlIGJlZm9yZQ0K
PiA+ID4gPiByZWFkaW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gU28gd2hhdCBpcyBzcGVjaWFsIGFi
b3V0IHhhdHRycyB0aGF0IGNhdXNlcyBpbnZhbGlkYXRpb24gdG8gYmUNCj4gPiA+ID4gYQ0KPiA+
ID4gPiBwcm9ibGVtIGluIHRoZSBJL08gcGF0aD8gV2h5IGRvIHdlIGV4cGVjdCB0aGVtIHRvIGdy
b3cgc28gbGFyZ2UNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiB0aGV5IGFyZSBtb3JlIHVud2llbGR5
IHRoYW4gdGhlIGlub2RlIGRhdGEgY2FjaGU/DQo+ID4gPiANCj4gPiA+IEluIHRoZSBjYXNlIG9m
IGlub2RlIGRhdGEsIHNvIHlvdSBzaG91bGQgcHJvYmFibHkgaW52YWxpZGF0ZSBpdA0KPiA+ID4g
aW1tZWRpYXRlbHksIG9yIGFjY2VwdCB0aGF0IHlvdSdyZSBzZXJ2aW5nIHVwIGtub3duLXN0YWxl
IGRhdGEuDQo+ID4gPiBTbw0KPiA+ID4gb2ZmbG9hZGluZyBpdCBkb2Vzbid0IHNlZW0gbGlrZSBh
IGdvb2QgaWRlYSwgYW5kIHlvdSdsbCBqdXN0IGhhdmUNCj4gPiA+IHRvDQo+ID4gPiBhY2NlcHQN
Cj4gPiA+IHRoZSBleHRyYSBjeWNsZXMgeW91J3JlIHVzaW5nIHRvIGRvIGl0Lg0KPiA+ID4gDQo+
ID4gPiBGb3IgdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHlvdSdyZSBqdXN0IHJlYXBpbmcgYSBjYWNo
ZSB0aGF0IGlzIG5vDQo+ID4gPiBsb25nZXINCj4gPiA+IGJlaW5nIHVzZWQuIFRoZXJlIGlzIG5v
IGNvcnJlY3RuZXNzIGdhaW4gaW4gZG9pbmcgaXQgaW4gdGhlIEkvTw0KPiA+ID4gcGF0aA0KPiA+
ID4gLQ0KPiA+ID4gdGhlIGNhY2hlIGhhcyBhbHJlYWR5IGJlZW4gb3JwaGFuZWQgYW5kIG5ldyBn
ZXR4YXR0ci9saXN0eGF0dHINCj4gPiA+IGNhbGxzDQo+ID4gPiB3aWxsIG5vdCBzZWUgaXQuIFNv
IHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHJlYXNvbiB0byBkbyBpdCBpbg0KPiA+ID4gdGhl
DQo+ID4gPiBJL08gcGF0aCBhdCBhbGwuDQo+ID4gPiANCj4gPiA+IFRoZSBjYWNoZXMgc2hvdWxk
bid0IGJlY29tZSB2ZXJ5IGxhcmdlLCBuby4gSW4gdGhlIG5vcm1hbCBjYXNlLA0KPiA+ID4gdGhl
cmUNCj4gPiA+IHNob3VsZG4ndCBiZSBtdWNoIG9mIGEgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZS4N
Cj4gPiA+IA0KPiA+ID4gVGhlbiBhZ2Fpbiwgd2hhdCBkbyB5b3UgZ2FpbiBieSBkb2luZyB0aGUg
cmVhcGluZyBvZiB0aGUgY2FjaGUgaW4NCj4gPiA+IHRoZQ0KPiA+ID4gSS9PIHBhdGgsDQo+ID4g
PiBpbnN0ZWFkIG9mIHVzaW5nIGEgd29yayBxdWV1ZT8gSSBjb25jbHVkZWQgdGhhdCB0aGVyZSB3
YXNuJ3QgYW4NCj4gPiA+IHVwc2lkZSwgb25seQ0KPiA+ID4gYSBkb3duc2lkZSwgc28gdGhhdCdz
IHdoeSBJIGltcGxlbWVudGVkIGl0IHRoYXQgd2F5Lg0KPiA+ID4gDQo+ID4gPiBJZiB5b3UgdGhp
bmsgaXQncyBiZXR0ZXIgdG8gZG8gaXQgaW5saW5lLCBJJ20gaGFwcHkgdG8gY2hhbmdlIGl0LA0K
PiA+ID4gb2YNCj4gPiA+IGNvdXJzZS4NCj4gPiA+IEl0IHdvdWxkIGp1c3QgbWVhbiBnZXR0aW5n
IHJpZCBvZiB0aGUgd29yayBxdWV1ZSBhbmQgdGhlDQo+ID4gPiByZWFwX2NhY2hlDQo+ID4gPiBm
dW5jdGlvbiwNCj4gPiA+IGFuZCBjYWxsaW5nIGRpc2NhcmRfY2FjaGUgZGlyZWN0bHksIGluc3Rl
YWQgb2YgcmVhcF9jYWNoZS4NCj4gPiA+IA0KPiA+ID4gLSBGcmFuaw0KPiA+IA0KPiA+IEkgdGhp
bmsgd2Ugc2hvdWxkIHN0YXJ0IHdpdGggZG9pbmcgdGhlIGZyZWVpbmcgb2YgdGhlIG9sZCBjYWNo
ZQ0KPiA+IGlubGluZS4NCj4gPiBJZiBpdCB0dXJucyBvdXQgdG8gYmUgYSByZWFsIHBlcmZvcm1h
bmNlIHByb2JsZW0sIHRoZW4gd2UgY2FuIGxhdGVyDQo+ID4gcmV2aXNpdCB1c2luZyBhIHdvcmsg
cXVldWUsIGhvd2V2ZXIgaW4gdGhhdCBjYXNlLCBJJ2QgcHJlZmVyIHRvIHVzZQ0KPiA+IG5mc2lv
ZCByYXRoZXIgdGhhbiBhZGRpbmcgYSBzcGVjaWFsIHdvcmtxdWV1ZSB0aGF0IGlzIHJlc2VydmVk
IGZvcg0KPiA+IHhhdHRycy4NCj4gDQo+IFN1cmUsIEkgY2FuIGRvIHRoYXQuDQo+IA0KPiBEbyB5
b3Ugd2FudCBtZSB0byBzZW5kIGEgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNlcmllcywgb3Ig
YW4NCj4gaW5jcmVtZW50YWwgcGF0Y2g/DQoNClBsZWFzZSBqdXN0IHNlbmQgYXMgYW4gaW5jcmVt
ZW50YWwgcGF0Y2guDQoNClRoYW5rcyENCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
