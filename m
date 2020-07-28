Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12E923113C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgG1SE0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 14:04:26 -0400
Received: from mail-mw2nam12on2103.outbound.protection.outlook.com ([40.107.244.103]:35425
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbgG1SEZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jul 2020 14:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPhQSIibKtkcJ/jp12eh8q0qoLzjFuoH0dWqRpLLEHO5KBCXgoHP01dnwHOwgBtGIKng75do6fm+mn2yk1Xn8dT3aq0P9HkW/qjRfONnYqMseHvLs+4l2dZjwqJLUDDwZrJLi6BzDMxA4e72L9/Do702DQ8Muy6LaEE+m6InQmEylARgAVjOGTZx6nJ/xxG5QFBrRcQKGucBYmHR2bxSdrgyfOb9f74MkF1/9ErFqr9X/CCpycvzzpMDp8fBswrDfx8+/nya+tWM+Lz/XCPgKfiJMBPwQpj6zEsA7ioW/A+Q4n1hAtTXOZrUNX04FzwWDkR0D93Zz88h0SFklICtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eETqeweS9vuD+UAOL1RR57NhzjwNmp2rk2DolwR7Cxk=;
 b=h9wet8m3qPg6Eja37HemM8H8XG8trGgQJVkXIhqsjUCqfSm99bNCftoXGk6zBcKe1Vg77A5E8aeyn415xjasnnuQjS4bCeVBi5cs2DznT+FfHBWEcDQQCRRp8Gw50/8glUkunFA3Uk4wLdeTBEcbHrSAOXNpW8JRCWoRh9aRtktG4ND5IwHrOEMU1f7Z8rHeIDJzXqkNTdwYBcU81Xj2Wlvh372jEBIiulCgi1zf1ehgS97rZE/iP1PQRiRGWaNfkhkUD7TqdTNEE0FcJX7ao536wNFKF9MzaXAbp7Z4EkSIrUkNxTg4VOJZodwPlvEGSfIbBG4T5WQTaEd0no9sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eETqeweS9vuD+UAOL1RR57NhzjwNmp2rk2DolwR7Cxk=;
 b=D8/SJTDDfYaAdRzRgGkXvJ20HLcEivnF5xhIq9pXF9BqSL2PU6MX7bWG9ST5ofTn14Udsj5c9f7OMqkKQevK7HUJ940T/RSloC7FXvRNDop98yJlo//uaa2sD9pTw3XoeSANbhh+Pq4gbG8ZRjRe2z06oVyoJnJpc1O2pRPK7t4=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3781.namprd13.prod.outlook.com (2603:10b6:610:9a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.15; Tue, 28 Jul
 2020 18:04:22 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 18:04:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Topic: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Index: AQHWZAhvCZQFVT7SMUyvX1UCoywirakbn4CAgAF8w4CAAA66gIAAEPOAgAAODoCAAAD5AA==
Date:   Tue, 28 Jul 2020 18:04:21 +0000
Message-ID: <13f86f29cc05944894813632bd537e559859e254.camel@hammerspace.com>
References: <20200727112344.GH389488@mwanda>
         <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
         <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <61d4e88c18818cd94dfbd14f054e6a2cb8858c8d.camel@hammerspace.com>
         <20200728180051.GA10902@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200728180051.GA10902@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5560b2d-0bae-4ff9-34ec-08d83320a7c9
x-ms-traffictypediagnostic: CH2PR13MB3781:
x-microsoft-antispam-prvs: <CH2PR13MB3781D93A1150F16DB2E730D8B8730@CH2PR13MB3781.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tavnGoZJ4JpUQMhDGPwbHeVIvHhi9VPfDqqBMT9EWBbPDciMZ0N6GZrw+Z6Wn3x/fDp7pDc7MTlfkl85zijwoWBfoc2MKyJgB8ugmY/4NuxDuuJZrKN9zeuQwFzUbKQqE+cROPDRo3U0rQQ3YNZcCTTm+AVPT4zdjQMY3gAbBMIl9Mx5WqIpFTEzw2IOCQ7kIsUh/5j/hUTpMZp8LXaANcJ0aa5WqXnUwEa6fJ0So1nOuz0SlEFRiFpEeb7l57I8ffxviPGcmc/qBQ8cYVMDABFEYJ+xfb6X5YkmCXWyjDAgTGsHlpw6qUjc0QPz8z5eBDXg4K5WJvPk4CWab7IpQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(39840400004)(346002)(366004)(36756003)(6916009)(66556008)(64756008)(316002)(86362001)(83380400001)(66476007)(66446008)(186003)(4326008)(8936002)(8676002)(66946007)(26005)(76116006)(2616005)(71200400001)(2906002)(6486002)(54906003)(6512007)(6506007)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aTGqgVcCGb5n5O5fSKgwEW3KI55Z2yj9rGLxYe39rB8P3ifibdwzGqV3FmN0FMiP3pkPgin1yVAZfNpP+UqrhkSyFyMDlt07OPD19t4rLvSO6eMU9INigbTpNPzxZQijsA2wm6RcjA0veEWWOnuGhmEn2eVbuyS73UVmOFgkof7WgWHOd78+hm7LT7BTPcrSPA9fqeJ6j7kVmV55kOreR1+TXk4jnh99IstP4pO3rFvwapa3/QZCLe5cbPC7uTFkfdpsJMsAMxpfUgRCCeemOD9fIvR3rdinZnlKVSvIovYtguZlH5H9u/Lj/5pZKojdjqYM9qhHx7JLftmWtlw1I9whS0SLsEYbidAz0JbyNVH2nU7q35E8+YSUKEHRGc3nG630oLRisijNzElojjj2gw1DNoohWMOThQs9D/o82zjBXbUJIPtC0kdEY4/ND1AtYhuMCdpbTKfHEE6dlawM9L2q79RfJEKbCebUmySn5PIXBIIqTwF/AHXcOQjPY0tu9T8My3A2tIJYrBrGE4p6aVsI6i9BlllCi9APfnJUIkwfJG5tOEVc/Ldv0JGGpzbA73V08qYdIhBuvaqbNVSS5/N/n02B+FR3MvBj66wDkSQL0Tuk5kGalGNuhuZRebnfkl4aG1Xzk/H3QK1/oAYN6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B7BBCE9B301614D8D7B0C60A50FC89C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5560b2d-0bae-4ff9-34ec-08d83320a7c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 18:04:21.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ruwh1Y8jCTer3UBAaw/Y2pYZuTn9gw4JBgP0XOtOfbsqSwphppCMo95+qjZcWeIpR0sA7KHIRMDtRygj7Y5a8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3781
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTI4IGF0IDE4OjAwICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gT24gVHVlLCBKdWwgMjgsIDIwMjAgYXQgMDU6MTA6MzRQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wNy0yOCBhdCAxNjowOSArMDAwMCwg
RnJhbmsgdmFuIGRlciBMaW5kZW4gd3JvdGU6DQo+ID4gPiBIaSBUcm9uZCwNCj4gPiA+IA0KPiA+
ID4gT24gVHVlLCBKdWwgMjgsIDIwMjAgYXQgMDM6MTc6MTJQTSArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDIwMjAtMDctMjcgYXQgMTY6MzQgKzAwMDAsIEZy
YW5rIHZhbiBkZXIgTGluZGVuIHdyb3RlOg0KPiA+ID4gPiA+IEhpIERhbiwNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBPbiBNb24sIEp1bCAyNywgMjAyMCBhdCAwMjoyMzo0NFBNICswMzAwLCBEYW4g
Q2FycGVudGVyDQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBUaGlzIHNob3VsZCByZXR1
cm4gLUVOT01FTSBvbiBmYWlsdXJlIGluc3RlYWQgb2Ygc3VjY2Vzcy4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gRml4ZXM6IDk1YWQzN2Y5MGMzMyAoIk5GU3Y0LjI6IGFkZCBjbGllbnQgc2lk
ZSB4YXR0cg0KPiA+ID4gPiA+ID4gY2FjaGluZy4iKQ0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiA+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBmcy9uZnMvbmZzNDJ4YXR0ci5jIHwg
NCArKystDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L25mczQyeGF0dHIuYyBiL2ZzL25mcy9uZnM0MnhhdHRyLmMNCj4gPiA+ID4gPiA+IGluZGV4IDIz
ZmRhYjk3N2EyYS4uZTc1YzRiYjcwMjY2IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZz
L25mczQyeGF0dHIuYw0KPiA+ID4gPiA+ID4gKysrIGIvZnMvbmZzL25mczQyeGF0dHIuYw0KPiA+
ID4gPiA+ID4gQEAgLTEwNDAsOCArMTA0MCwxMCBAQCBpbnQgX19pbml0DQo+ID4gPiA+ID4gPiBu
ZnM0X3hhdHRyX2NhY2hlX2luaXQodm9pZCkNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBn
b3RvIG91dDI7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgICAgICAgbmZzNF94YXR0cl9j
YWNoZV93cSA9IGFsbG9jX3dvcmtxdWV1ZSgibmZzNF94YXR0ciIsDQo+ID4gPiA+ID4gPiBXUV9N
RU1fUkVDTEFJTSwgMCk7DQo+ID4gPiA+ID4gPiAtICAgICAgIGlmIChuZnM0X3hhdHRyX2NhY2hl
X3dxID09IE5VTEwpDQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChuZnM0X3hhdHRyX2NhY2hlX3dx
ID09IE5VTEwpIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0K
PiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gb3V0MTsNCj4gPiA+ID4gPiA+ICsgICAg
ICAgfQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgICAgIHJldCA9DQo+ID4gPiA+ID4g
PiByZWdpc3Rlcl9zaHJpbmtlcigmbmZzNF94YXR0cl9jYWNoZV9zaHJpbmtlcik7DQo+ID4gPiA+
ID4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi4yNy4w
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MgZm9yIGNhdGNoaW5n
IHRoYXQgb25lLiBTaW5jZSB0aGlzIGlzIGFnYWluc3QgbGludXgtDQo+ID4gPiA+ID4gbmV4dA0K
PiA+ID4gPiA+IHZpYQ0KPiA+ID4gPiA+IFRyb25kLA0KPiA+ID4gPiA+IEkgYXNzdW1lIFRyb25k
IHdpbGwgYWRkIGl0IHRvIGhpcyB0cmVlIChyaWdodD8pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SW4gYW55IGNhc2U6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmV2aWV3ZWQt
Ynk6IEZyYW5rIHZhbiBkZXIgTGluZGVuIDxmbGxpbmRlbkBhbWF6b24uY29tPg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC0gRnJhbmsNCj4gPiA+ID4gDQo+ID4gPiA+IEZyYW5r
LCB3aHkgZG8gd2UgbmVlZCBhIHdvcmtxdWV1ZSBoZXJlIGF0IGFsbD8NCj4gPiA+IA0KPiA+ID4g
VGhlIHhhdHRyIGNhY2hlcyBhcmUgcGVyLWlub2RlLCBhbmQgZ2V0IGNyZWF0ZWQgb24gZGVtYW5k
Lg0KPiA+ID4gSW52YWxpZGF0aW5nDQo+ID4gPiBhIGNhY2hlIGlzIGRvbmUgYnkgc2V0dGluZyB0
aGUgaW52YWxpZGF0ZSBmbGFnIChhcyBpdCBpcyBmb3INCj4gPiA+IG90aGVyDQo+ID4gPiBjYWNo
ZWQgYXR0cmlidWVzIGFuZCBkYXRhKS4NCj4gPiA+IA0KPiA+ID4gV2hlbiBuZnM0X3hhdHRyX2dl
dF9jYWNoZSgpIHNlZXMgYW4gaW52YWxpZGF0ZWQgY2FjaGUsIGl0IHdpbGwNCj4gPiA+IGp1c3QN
Cj4gPiA+IHVubGluayBpdA0KPiA+ID4gZnJvbSB0aGUgaW5vZGUsIGFuZCBjcmVhdGUgYSBuZXcg
b25lIGlmIG5lZWRlZC4NCj4gPiA+IA0KPiA+ID4gVGhlIG9sZCBjYWNoZSB0aGVuIHN0aWxsIG5l
ZWRzIHRvIGJlIGZyZWVkLiBUaGVvcmV0aWNhbGx5LCB0aGVyZQ0KPiA+ID4gY2FuDQo+ID4gPiBi
ZQ0KPiA+ID4gcXVpdGUgYSBmZXcgZW50cmllcyBpbiBpdCwgYW5kIG5mczRfeGF0dHJfZ2V0X2Nh
Y2hlKCkgd2lsbCBiZQ0KPiA+ID4gY2FsbGVkDQo+ID4gPiBpbg0KPiA+ID4gdGhlIGdldC9zZXR4
YXR0ciBzeXN0ZW1jYWxsIHBhdGguIFNvIG15IHJlYXNvbmluZyBoZXJlIHdhcyB0aGF0DQo+ID4g
PiBpdCdzDQo+ID4gPiBiZXR0ZXINCj4gPiA+IHRvIHVzZSBhIHdvcmtxdWV1ZSB0byBmcmVlIHRo
ZSBvbGQgaW52YWxpZGF0ZWQgY2FjaGUgaW5zdGVhZCBvZg0KPiA+ID4gd2FzdGluZw0KPiA+ID4g
Y3ljbGVzIGluIHRoZSBJL08gcGF0aC4NCj4gPiA+IA0KPiA+ID4gLSBGcmFuaw0KPiA+IA0KPiA+
IEkgdGhpbmsgd2UgbWlnaHQgd2FudCB0byBleHBsb3JlIHRoZSByZWFzb25zIGZvciB0aGlzIGFy
Z3VtZW50LiBXZQ0KPiA+IGRvDQo+ID4gbm90IG9mZmxvYWQgYW55IG90aGVyIGNhY2hlIGludmFs
aWRhdGlvbnMsIGFuZCB0aGF0IGluY2x1ZGVzIHRoZQ0KPiA+IGNhc2UNCj4gPiB3aGVuIHdlIGhh
dmUgdG8gaW52YWxpZGF0ZSB0aGUgZW50aXJlIGlub2RlIGRhdGEgY2FjaGUgYmVmb3JlDQo+ID4g
cmVhZGluZy4NCj4gPiANCj4gPiBTbyB3aGF0IGlzIHNwZWNpYWwgYWJvdXQgeGF0dHJzIHRoYXQg
Y2F1c2VzIGludmFsaWRhdGlvbiB0byBiZSBhDQo+ID4gcHJvYmxlbSBpbiB0aGUgSS9PIHBhdGg/
IFdoeSBkbyB3ZSBleHBlY3QgdGhlbSB0byBncm93IHNvIGxhcmdlDQo+ID4gdGhhdA0KPiA+IHRo
ZXkgYXJlIG1vcmUgdW53aWVsZHkgdGhhbiB0aGUgaW5vZGUgZGF0YSBjYWNoZT8NCj4gDQo+IElu
IHRoZSBjYXNlIG9mIGlub2RlIGRhdGEsIHNvIHlvdSBzaG91bGQgcHJvYmFibHkgaW52YWxpZGF0
ZSBpdA0KPiBpbW1lZGlhdGVseSwgb3IgYWNjZXB0IHRoYXQgeW91J3JlIHNlcnZpbmcgdXAga25v
d24tc3RhbGUgZGF0YS4gU28NCj4gb2ZmbG9hZGluZyBpdCBkb2Vzbid0IHNlZW0gbGlrZSBhIGdv
b2QgaWRlYSwgYW5kIHlvdSdsbCBqdXN0IGhhdmUgdG8NCj4gYWNjZXB0DQo+IHRoZSBleHRyYSBj
eWNsZXMgeW91J3JlIHVzaW5nIHRvIGRvIGl0Lg0KPiANCj4gRm9yIHRoaXMgcGFydGljdWxhciBj
YXNlLCB5b3UncmUganVzdCByZWFwaW5nIGEgY2FjaGUgdGhhdCBpcyBubw0KPiBsb25nZXINCj4g
YmVpbmcgdXNlZC4gVGhlcmUgaXMgbm8gY29ycmVjdG5lc3MgZ2FpbiBpbiBkb2luZyBpdCBpbiB0
aGUgSS9PIHBhdGgNCj4gLQ0KPiB0aGUgY2FjaGUgaGFzIGFscmVhZHkgYmVlbiBvcnBoYW5lZCBh
bmQgbmV3IGdldHhhdHRyL2xpc3R4YXR0ciBjYWxscw0KPiB3aWxsIG5vdCBzZWUgaXQuIFNvIHRo
ZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHJlYXNvbiB0byBkbyBpdCBpbiB0aGUNCj4gSS9PIHBh
dGggYXQgYWxsLg0KPiANCj4gVGhlIGNhY2hlcyBzaG91bGRuJ3QgYmVjb21lIHZlcnkgbGFyZ2Us
IG5vLiBJbiB0aGUgbm9ybWFsIGNhc2UsIHRoZXJlDQo+IHNob3VsZG4ndCBiZSBtdWNoIG9mIGEg
cGVyZm9ybWFuY2UgZGlmZmVyZW5jZS4NCj4gDQo+IFRoZW4gYWdhaW4sIHdoYXQgZG8geW91IGdh
aW4gYnkgZG9pbmcgdGhlIHJlYXBpbmcgb2YgdGhlIGNhY2hlIGluIHRoZQ0KPiBJL08gcGF0aCwN
Cj4gaW5zdGVhZCBvZiB1c2luZyBhIHdvcmsgcXVldWU/IEkgY29uY2x1ZGVkIHRoYXQgdGhlcmUg
d2Fzbid0IGFuDQo+IHVwc2lkZSwgb25seQ0KPiBhIGRvd25zaWRlLCBzbyB0aGF0J3Mgd2h5IEkg
aW1wbGVtZW50ZWQgaXQgdGhhdCB3YXkuDQo+IA0KPiBJZiB5b3UgdGhpbmsgaXQncyBiZXR0ZXIg
dG8gZG8gaXQgaW5saW5lLCBJJ20gaGFwcHkgdG8gY2hhbmdlIGl0LCBvZg0KPiBjb3Vyc2UuDQo+
IEl0IHdvdWxkIGp1c3QgbWVhbiBnZXR0aW5nIHJpZCBvZiB0aGUgd29yayBxdWV1ZSBhbmQgdGhl
IHJlYXBfY2FjaGUNCj4gZnVuY3Rpb24sDQo+IGFuZCBjYWxsaW5nIGRpc2NhcmRfY2FjaGUgZGly
ZWN0bHksIGluc3RlYWQgb2YgcmVhcF9jYWNoZS4NCj4gDQo+IC0gRnJhbmsNCg0KSSB0aGluayB3
ZSBzaG91bGQgc3RhcnQgd2l0aCBkb2luZyB0aGUgZnJlZWluZyBvZiB0aGUgb2xkIGNhY2hlIGlu
bGluZS4NCklmIGl0IHR1cm5zIG91dCB0byBiZSBhIHJlYWwgcGVyZm9ybWFuY2UgcHJvYmxlbSwg
dGhlbiB3ZSBjYW4gbGF0ZXINCnJldmlzaXQgdXNpbmcgYSB3b3JrIHF1ZXVlLCBob3dldmVyIGlu
IHRoYXQgY2FzZSwgSSdkIHByZWZlciB0byB1c2UNCm5mc2lvZCByYXRoZXIgdGhhbiBhZGRpbmcg
YSBzcGVjaWFsIHdvcmtxdWV1ZSB0aGF0IGlzIHJlc2VydmVkIGZvcg0KeGF0dHJzLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
