Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C36231097
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgG1RKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 13:10:39 -0400
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com ([40.107.236.135]:46944
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731070AbgG1RKi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jul 2020 13:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDLggyN/sx7pMu99r0OfQi3e0hev9q8YJpkPNXM/D/X6SMvKyPGUf3OTg7TbdzVyGdCDKNqND93rV7pPZ/5nfJlH6MQhroZ1LzACxffQMhw6TnhzlgU6hC9UOcu5QJjc+3ywUKE+O0bsBQHIL9kxDC5+czGkJWRQqUGKgV99bTjGXNSG1B0qICBPL2lkx5HdvlsGKr/Y/uuujLVUuNr5kxKBwuB4lP4uxmUj8aqoK8KztU8Qch5oVvawkxldPGW1fVrlAu+tyd1+eVdtoTRDFWp2isEtaiLcf4/k67Ufkne8vFKXl7S2BZDjeuhlluI8IyGw0+tb2LTQ9HtVul93/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buDAFhDuiSDLXyPwcXaqDRp2ISrWJvPu7Otu+Q0A4l4=;
 b=K6cl8utb+51UCf/UvD/KatnsfB2uzmr+RLJXk2FZXCxxZVfy3e9iUha815/SBQBPH8DpIHCaBABbE0suucV51RA7dE8kfErODSASOjibGGB8rPJ0nWzZgoiveY4BtWzFoikjrgYnBNU0tkxsXr25PxUnbcKAT4GElqxSompk1GpzLDVYWQQPgAwiZv9SehpQvDiXF0G/8hEtIFPDEvaBbRTp5ExoRINqaZcGpruMS7Y8RHJP7AmliMJZtfeAkdEdSZATSKupbUAQypcxfTcdYNsjFo5q8rNLmMFEopAdP3XarXAnEYOBM3xEB3girgS6jXp2KElV4TwZ30TTrbtVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buDAFhDuiSDLXyPwcXaqDRp2ISrWJvPu7Otu+Q0A4l4=;
 b=ViBVEHja6kc2zGbKqYxpWnKFxNkeVkhBd2PdpY6m2MUBC/Uaal7j9XiNlOXLnxgqzI4yvqWrOkylyLDApoNGC2o/t+9Ztlg7uEZCaQAp186XhvxFuFQT1jyBx24j+Nf9fUjcaidV0S1D9kRJDNCD3I5NL5p+MwN72j5co7FYdSc=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3848.namprd13.prod.outlook.com (2603:10b6:610:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10; Tue, 28 Jul
 2020 17:10:34 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 17:10:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Topic: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Index: AQHWZAhvCZQFVT7SMUyvX1UCoywirakbn4CAgAF8w4CAAA66gIAAEPOA
Date:   Tue, 28 Jul 2020 17:10:34 +0000
Message-ID: <61d4e88c18818cd94dfbd14f054e6a2cb8858c8d.camel@hammerspace.com>
References: <20200727112344.GH389488@mwanda>
         <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
         <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859c0f39-9373-4592-b87a-08d83319243f
x-ms-traffictypediagnostic: CH2PR13MB3848:
x-microsoft-antispam-prvs: <CH2PR13MB3848FD80F2F7AC169F991816B8730@CH2PR13MB3848.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uh/moCz7fTJso3tnkI2pr5XIgZgUNQ5EIFHqDUms/IvYSjoSIyTmwIY9K/9w3/wfoeNBkG8FX9gMskmoiTCjsmB/pAakyzN5by5uxkAKmQUACWKCzz1tw6dETUX/L8xNRmxovuNwhx7m3IwY5wEuGXNXTT8feA6XZJD0Va9vYH7HnDZcGCfJ2PwrULVSJES/abJni1awFd4QKuEMRqUBBtWkTDYvjqGpGRvlVO2KFWvxoIaAtpw8LE87KABuh4sml5TLyYKVptJVTeJMbTiy/CEQ+GdenlzdJ+e6XWjjnbLo4rscdc74BVANK1C7X4XbcUwjrB6Ja7DDq2Brhh9SzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(39840400004)(366004)(346002)(6512007)(66446008)(66946007)(478600001)(66476007)(66556008)(71200400001)(6916009)(54906003)(64756008)(6486002)(2906002)(5660300002)(76116006)(8936002)(8676002)(36756003)(2616005)(4326008)(86362001)(316002)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wh6CbxwjhHsVzH7q/mGlVKe5yJcYuuGiNW5xQZnZT9gRr/q19cE2tYGQtQd+gB8b+7uRowV6m6kT1iZBYv1EVqBd6Yfnj8StB4W2TY4CWvabhaLvux3RYfavNGWshWV4SK7/Cn2MgZ5b4XDo5+tEtE6+Wqus69SmWsMNYTiN6Ywk1W/n3ylKD5RozJQwHuU4zwCrI/PucZbDsV0uKJuGPuYbOmFiSpOT2fkMSzKHm5WmUxU79Xvn7VNeMAbHNeSU9ilYrwPZzaPE+AoE+p//dRWeC6DvrKrMxFWBXkC9QG30p0X15z2L2gRbDSCqf8Yq9lLNhzaHcc0eKmNaUf+T92wjzhF6QTQ5nSOrZu7VWZMQiFzcFj5M4Dbj/bX4D7DPXDLGajhV64A7TRtjO/dDj3G0FI2Ev5c+WZy/zwamHe3R1phceUZ1k592BqMPAwPW3AyYaty3AxP6VwPpaAS0gKsd6vtwkJoUNK8A5XHU5//Y3YQ/aBXVLjdDaR7pxXuenrINO3mehsaGaWE8GKiHb1CkgGUOr3AE6fhjtIc6Pc1RFIX1KrTQUbip0n3t2mYt7OAsA1kL/1Ksx+QcRNW0ilJIgU0heb+raurcYlhl2slhuY0031Sm9zi4l+EDTs11lds6jjlz1pKU/4v/vD1jNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BDD9EAD26EDC746A360CB3EF4FB1A15@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859c0f39-9373-4592-b87a-08d83319243f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 17:10:34.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kVqV9/ElocRywsm8oCssZJ3NHOoa/PBycrVfAcoXjjzgek+vKGUwB+AKxguCkdcco4xTCmLHFO9/5zBzO6fCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3848
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTI4IGF0IDE2OjA5ICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBPbiBUdWUsIEp1bCAyOCwgMjAyMCBhdCAwMzoxNzox
MlBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIwLTA3LTI3
IGF0IDE2OjM0ICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3cm90ZToNCj4gPiA+IEhpIERh
biwNCj4gPiA+IA0KPiA+ID4gT24gTW9uLCBKdWwgMjcsIDIwMjAgYXQgMDI6MjM6NDRQTSArMDMw
MCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gPiA+ID4gVGhpcyBzaG91bGQgcmV0dXJuIC1FTk9N
RU0gb24gZmFpbHVyZSBpbnN0ZWFkIG9mIHN1Y2Nlc3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhl
czogOTVhZDM3ZjkwYzMzICgiTkZTdjQuMjogYWRkIGNsaWVudCBzaWRlIHhhdHRyIGNhY2hpbmcu
IikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBmcy9uZnMvbmZz
NDJ4YXR0ci5jIHwgNCArKystDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L25mczQyeGF0dHIuYyBiL2ZzL25mcy9uZnM0MnhhdHRyLmMNCj4gPiA+ID4gaW5kZXggMjNmZGFi
OTc3YTJhLi5lNzVjNGJiNzAyNjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Mnhh
dHRyLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL25mczQyeGF0dHIuYw0KPiA+ID4gPiBAQCAtMTA0
MCw4ICsxMDQwLDEwIEBAIGludCBfX2luaXQgbmZzNF94YXR0cl9jYWNoZV9pbml0KHZvaWQpDQo+
ID4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIG91dDI7DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAg
ICAgIG5mczRfeGF0dHJfY2FjaGVfd3EgPSBhbGxvY193b3JrcXVldWUoIm5mczRfeGF0dHIiLA0K
PiA+ID4gPiBXUV9NRU1fUkVDTEFJTSwgMCk7DQo+ID4gPiA+IC0gICAgICAgaWYgKG5mczRfeGF0
dHJfY2FjaGVfd3EgPT0gTlVMTCkNCj4gPiA+ID4gKyAgICAgICBpZiAobmZzNF94YXR0cl9jYWNo
ZV93cSA9PSBOVUxMKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgZ290byBvdXQxOw0KPiA+ID4gPiArICAgICAgIH0NCj4g
PiA+ID4gDQo+ID4gPiA+ICAgICAgICAgcmV0ID0gcmVnaXN0ZXJfc2hyaW5rZXIoJm5mczRfeGF0
dHJfY2FjaGVfc2hyaW5rZXIpOw0KPiA+ID4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gPiA+IC0t
DQo+ID4gPiA+IDIuMjcuMA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciBjYXRj
aGluZyB0aGF0IG9uZS4gU2luY2UgdGhpcyBpcyBhZ2FpbnN0IGxpbnV4LW5leHQNCj4gPiA+IHZp
YQ0KPiA+ID4gVHJvbmQsDQo+ID4gPiBJIGFzc3VtZSBUcm9uZCB3aWxsIGFkZCBpdCB0byBoaXMg
dHJlZSAocmlnaHQ/KQ0KPiA+ID4gDQo+ID4gPiBJbiBhbnkgY2FzZToNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBSZXZpZXdlZC1ieTogRnJhbmsgdmFuIGRlciBMaW5kZW4gPGZsbGluZGVuQGFtYXpv
bi5jb20+DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gLSBGcmFuaw0KPiA+IA0KPiA+IEZyYW5rLCB3
aHkgZG8gd2UgbmVlZCBhIHdvcmtxdWV1ZSBoZXJlIGF0IGFsbD8NCj4gDQo+IFRoZSB4YXR0ciBj
YWNoZXMgYXJlIHBlci1pbm9kZSwgYW5kIGdldCBjcmVhdGVkIG9uIGRlbWFuZC4NCj4gSW52YWxp
ZGF0aW5nDQo+IGEgY2FjaGUgaXMgZG9uZSBieSBzZXR0aW5nIHRoZSBpbnZhbGlkYXRlIGZsYWcg
KGFzIGl0IGlzIGZvciBvdGhlcg0KPiBjYWNoZWQgYXR0cmlidWVzIGFuZCBkYXRhKS4NCj4gDQo+
IFdoZW4gbmZzNF94YXR0cl9nZXRfY2FjaGUoKSBzZWVzIGFuIGludmFsaWRhdGVkIGNhY2hlLCBp
dCB3aWxsIGp1c3QNCj4gdW5saW5rIGl0DQo+IGZyb20gdGhlIGlub2RlLCBhbmQgY3JlYXRlIGEg
bmV3IG9uZSBpZiBuZWVkZWQuDQo+IA0KPiBUaGUgb2xkIGNhY2hlIHRoZW4gc3RpbGwgbmVlZHMg
dG8gYmUgZnJlZWQuIFRoZW9yZXRpY2FsbHksIHRoZXJlIGNhbg0KPiBiZQ0KPiBxdWl0ZSBhIGZl
dyBlbnRyaWVzIGluIGl0LCBhbmQgbmZzNF94YXR0cl9nZXRfY2FjaGUoKSB3aWxsIGJlIGNhbGxl
ZA0KPiBpbg0KPiB0aGUgZ2V0L3NldHhhdHRyIHN5c3RlbWNhbGwgcGF0aC4gU28gbXkgcmVhc29u
aW5nIGhlcmUgd2FzIHRoYXQgaXQncw0KPiBiZXR0ZXINCj4gdG8gdXNlIGEgd29ya3F1ZXVlIHRv
IGZyZWUgdGhlIG9sZCBpbnZhbGlkYXRlZCBjYWNoZSBpbnN0ZWFkIG9mDQo+IHdhc3RpbmcNCj4g
Y3ljbGVzIGluIHRoZSBJL08gcGF0aC4NCj4gDQo+IC0gRnJhbmsNCg0KSSB0aGluayB3ZSBtaWdo
dCB3YW50IHRvIGV4cGxvcmUgdGhlIHJlYXNvbnMgZm9yIHRoaXMgYXJndW1lbnQuIFdlIGRvDQpu
b3Qgb2ZmbG9hZCBhbnkgb3RoZXIgY2FjaGUgaW52YWxpZGF0aW9ucywgYW5kIHRoYXQgaW5jbHVk
ZXMgdGhlIGNhc2UNCndoZW4gd2UgaGF2ZSB0byBpbnZhbGlkYXRlIHRoZSBlbnRpcmUgaW5vZGUg
ZGF0YSBjYWNoZSBiZWZvcmUgcmVhZGluZy4NCg0KU28gd2hhdCBpcyBzcGVjaWFsIGFib3V0IHhh
dHRycyB0aGF0IGNhdXNlcyBpbnZhbGlkYXRpb24gdG8gYmUgYQ0KcHJvYmxlbSBpbiB0aGUgSS9P
IHBhdGg/IFdoeSBkbyB3ZSBleHBlY3QgdGhlbSB0byBncm93IHNvIGxhcmdlIHRoYXQNCnRoZXkg
YXJlIG1vcmUgdW53aWVsZHkgdGhhbiB0aGUgaW5vZGUgZGF0YSBjYWNoZT8NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
