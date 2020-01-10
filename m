Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50A137840
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 22:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgAJVDk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 16:03:40 -0500
Received: from mail-bn8nam12on2116.outbound.protection.outlook.com ([40.107.237.116]:8160
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbgAJVDk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 Jan 2020 16:03:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd++eCIiSBsneV8FiGKYQwwhGKYF3jCOhuD0OKwIkwCVtU5dcXugpo091qDtRZpZ3fEWGuWu9H/xJvPzR2HVoJuDyc7jZhvedkfJOQQCK4MNSItM5EQqCZOSgwaRIkmsAh5JN8pfWmsVUr0Xq41ng+s7b2U6KkzmBZ5Mt0QN3lpqpwTiU61WKNadGM85W/mwYn2HOnD5lZi8FtCfmyM+789nG0mnlJyddgiKxywUntzE96KmKpa/z5dBm17KRJQFHmbXrM/6i/xCAc5e/Z+3os6b4Jkl0DFmCoIBmdzX6VEmXRhzuTin/Rcn9x5YIIkhs0T8W9OVBD1uu2Y/9Umrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C6T7LmST+eujcLSo3jte7rPWzLvEKuTPI7AEvnguv0=;
 b=P+FcsY3Qz+5Uoz/RApIf6dkxkrNeyTZdQu+0OEIkTAf/TfWzRDsN/4UbYD0QlqOUgL4nhu1St1iMqFCkbRSGi4176+8ohp5cL9ngAOuk1hHJwwHsdf2iwRfQEv/0yJRIyLF482G6TjcyNexYKcHVo+OCro7ed9D/1dI/yDVdvtn1JsE8Ilg10GfL7KzCFpLHEsOELwdm6wA+fkG3AfW8oniC2HBxH3f6aOiLvMfiiydVXl3CC4idFhB2wgvnaCEPq+1a7KssoBAVQexAp6BQL/tFusdJbqm9TZgLk7G4fXZawPKGbAyd+puaGO/yNlZQpHp8c4E1K5xVSAU55BHzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C6T7LmST+eujcLSo3jte7rPWzLvEKuTPI7AEvnguv0=;
 b=D6HUGunVZglYXLyX7frPOoVU5vPkTFKS298hpGymBbsLqr+DNov/YmMB0nPnuWqGegq0H9Uh6KaE7g9tXDpuktmp7IMn29fQF4JMPaUTzE0Jo9WvE6WSKiBLpcMUoj7i2WdiudBAXz27PJiIXUEnvOKAZL66IO/T0oxIhJbPCDU=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2060.namprd13.prod.outlook.com (10.174.186.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Fri, 10 Jan 2020 21:03:36 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 21:03:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: interrupted rpcs problem
Thread-Topic: interrupted rpcs problem
Thread-Index: AQHVx+xAF9geEgvaYEKYoTth6kuH4qfkYv+A
Date:   Fri, 10 Jan 2020 21:03:36 +0000
Message-ID: <3b89b01911b5149533e45478fdcec941a4f915ba.camel@hammerspace.com>
References: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
In-Reply-To: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9861236d-2502-4f74-589e-08d796108f91
x-ms-traffictypediagnostic: DM5PR1301MB2060:
x-microsoft-antispam-prvs: <DM5PR1301MB206051DD24C3C45A3D353DF2B8380@DM5PR1301MB2060.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(376002)(396003)(136003)(189003)(199004)(2906002)(186003)(6512007)(66556008)(110136005)(66476007)(91956017)(26005)(81156014)(8676002)(3480700007)(8936002)(7116003)(81166006)(2616005)(66446008)(64756008)(6506007)(66946007)(316002)(71200400001)(76116006)(6486002)(86362001)(5660300002)(36756003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2060;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4F5X3y9JGc7XgFpvY1/n+wS/ou6jhb2SvU12/jlXRUcyhYSfc8qeLmHsiJ3sUK7KoN4pQb/jRNOf0UC2RRtbROtWGJGTj8tOmw83MRBLJphGRLUOPfBcZ12IfDR+5IO5PPSAteCxc0Nmr+6jWsnwjQ9M1qcqIloF6nKfNyzsolv6X4VoA5PQg4b1bqotgRgPHg3L2lu6N0Y9aK3uQuq0sE+Ua54b1OLa/g3GNZ4lfK9QauDSYPNjIR2rHknW4z4ISi+AZwK8xv8bmhcQNvOyI7sCndB/NnrrxDuCJJDEj0wz4Gv8VqEPTZqCt5G+BJr4Evf5fDFREtltYhmFX9N42R484vs8o+uYaDWC6qtFPI0dN2qF1W15ugROn19PLV0URuBMkqRZOCt2OIGh9b1hRcgCRVwhDir7sVJouRDk734k0TDAEfdb/PVkAHmer9sl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DC3203A8D5092478D3AA1BFBEF3F08B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9861236d-2502-4f74-589e-08d796108f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 21:03:36.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmRXEgnLcyxLY9iAlM7XZ3EaoSVF0ZnJy37Tp3feSHP+zrQRqL6EUMyauDVWAir/4eZGaauA5hKH6h4DOm/22g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2060
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTEwIGF0IDE0OjI5IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgZm9sa3MsDQo+IA0KPiBXZSBhcmUgaGF2aW5nIGFuIGlzc3VlIHdpdGggYW4gaW50
ZXJydXB0ZWQgUlBDcyBhZ2Fpbi4gSGVyZSdzIHdoYXQgSQ0KPiBzZWUgd2hlbiB4ZnN0ZXN0cyB3
ZXJlIGN0cmwtYy1lZC4NCj4gDQo+IGZyYW1lIDMzMiBTRVRBVFRSIGNhbGwgc2xvdD0wIHNlcWlk
PTB4MDAwMDEzY2EgKEknbSBhc3N1bWluZyB0aGlzIGlzDQo+IGludGVycnVwdGVkIGFuZCByZWxl
YXNlZCkNCj4gZnJhbWUgMzMzIENMT1NFIGNhbGwgc2xvdD0wIHNlcWlkPTB4MDAwMDEzY2IgIChv
bmx5IHdheSB0aGUgc2xvdA0KPiBjb3VsZA0KPiBiZSBmcmVlIGJlZm9yZSB0aGUgcmVwbHkgaWYg
aXQgd2FzIGludGVycnVwdGVkLCByaWdodD8gT3RoZXJ3aXNlIHdlDQo+IHNob3VsZCBuZXZlciBo
YXZlIHRoZSBzbG90IHVzZWQgYnkgbW9yZSB0aGFuIG9uZSBvdXRzdGFuZGluZyBSUEMpDQo+IGZy
YW1lIDMzNCByZXBseSB0byAzMzMgd2l0aCBTRVFfTUlTX09SREVSRUQgKEknbSBhc3N1bWluZyBz
ZXJ2ZXINCj4gcmVjZWl2ZWQgZnJhbWUgMzMzIGJlZm9yZSAzMzIpDQo+IGZyYW1lIDMzNiBDTE9T
RSBjYWxsIHNsb3Q9MCBzZXFpZD0weDAwMDAxM2NhICg/Pz8gd2h5IGRpZCB3ZQ0KPiBkZWNyZW1l
bnRlZCBpdC4gSSBtZWFuIEkga25vdyB3aHkgaXQncyBpbiB0aGUgY3VycmVudCBjb2RlIDotLyAp
DQo+IGZyYW1lIDMzNyByZXBseSB0byAzMzYgU0VRVUVOQ0Ugd2l0aCBFUlJfREVMQVkNCj4gZnJh
bWUgMzM5IHJlcGx5IHRvIDMzMiBTRVRBVFRSIHdoaWNoIG5vYm9keSBpcyB3YWl0aW5nIGZvcg0K
PiBmcmFtZSA1NDMgQ0xPU0UgY2FsbCBzbG90PTAgc2VxaWQ9MHgwMDAwMTNjYSAocmV0cnkgYWZ0
ZXIgd2FpdGluZyBmb3INCj4gZXJyX2RlbGF5KQ0KPiBmcmFtZSA1NDQgcmVwbHkgdG8gNTQzIHdp
dGggU0VUQVRUUiAob3V0IG9mIHRoZSBjYWNoZSkuDQo+IA0KPiBXaGF0IHRoaXMgbGVhZHMgdG8g
aXM6IGZpbGUgaXMgbmV2ZXIgY2xvc2VkIG9uIHRoZSBzZXJ2ZXIuIENhbid0DQo+IHJlbW92ZSBp
dC4gVW5tb3VudCBmYWlscyB3aXRoIENMSURfQlVTWS4NCj4gDQo+IEkgYmVsaWV2ZSB0aGF0J3Mg
dGhlIHJlc3VsdCBvZiBjb21taXQNCj4gMzQ1M2Q1NzA4YjMzZWZlNzZmNDBlY2ExYzBlZDYwOTIz
MDk0Yjk3MS4NCj4gV2UgdXNlZCB0byBoYXZlIGNvZGUgdGhhdCBidW1wZWQgdGhlIHNlcXVlbmNl
IHVwIHdoZW4gdGhlIHNsb3Qgd2FzDQo+IGludGVycnVwdGVkIGJ1dCBhZnRlciB0aGUgY29tbWl0
ICJORlN2NC4xOiBBdm9pZCBmYWxzZSByZXRyaWVzIHdoZW4NCj4gUlBDIGNhbGxzIGFyZSBpbnRl
cnJ1cHRlZCIuDQo+IA0KPiBDb21taXQgaGFzIHRoaXMgIlRoZSBvYnZpb3VzIGZpeCBpcyB0byBi
dW1wIHRoZSBzZXF1ZW5jZSBudW1iZXINCj4gcHJlLWVtcHRpdmVseSBpZiBhbg0KPiAgICAgUlBD
IGNhbGwgaXMgaW50ZXJydXB0ZWQsIGJ1dCBpbiBvcmRlciB0byBkZWFsIHdpdGggdGhlIGNvcm5l
cg0KPiBjYXNlcw0KPiAgICAgd2hlcmUgdGhlIGludGVycnVwdGVkIGNhbGwgaXMgbm90IGFjdHVh
bGx5IHJlY2VpdmVkIGFuZCBwcm9jZXNzZWQNCj4gYnkNCj4gICAgIHRoZSBzZXJ2ZXIsIHdlIG5l
ZWQgdG8gaW50ZXJwcmV0IHRoZSBlcnJvciBORlM0RVJSX1NFUV9NSVNPUkRFUkVEDQo+ICAgICBh
cyBhIHNpZ24gdGhhdCB3ZSBuZWVkIHRvIGVpdGhlciB3YWl0IG9yIGxvY2F0ZSBhIGNvcnJlY3QN
Cj4gc2VxdWVuY2UNCj4gICAgIG51bWJlciB0aGF0IGxpZXMgYmV0d2VlbiB0aGUgdmFsdWUgd2Ug
c2VudCwgYW5kIHRoZSBsYXN0IHZhbHVlDQo+IHRoYXQNCj4gICAgIHdhcyBhY2tlZCBieSBhIFNF
UVVFTkNFIGNhbGwgb24gdGhhdCBzbG90LiINCj4gDQo+IElmIHdlIGNhbid0IG5vIGxvbmdlciBq
dXN0IGJ1bXAgdGhlIHNlcXVlbmNlIHVwLCBJIGRvbid0IHRoaW5rIHRoZQ0KPiBjb3JyZWN0IGFj
dGlvbiBpcyB0byBhdXRvbWF0aWNhbGx5IGJ1bXAgaXQgZG93biAoYXMgcGVyIGV4YW1wbGUNCj4g
aGVyZSk/DQo+IFRoZSBjb21taXQgZG9lc24ndCBkZXNjcmliZSB0aGUgY29ybmVyIGNhc2Ugd2hl
cmUgaXQgd2FzIG5lY2Vzc2FyeSB0bw0KPiBidW1wIHRoZSBzZXF1ZW5jZSB1cC4gSSB3b25kZXIg
aWYgd2UgY2FuIHJldHVybiB0aGUga25vd2xlZGdlIG9mIHRoZQ0KPiBpbnRlcnJ1cHRlZCBzbG90
IGFuZCBtYWtlIGEgZGVjaXNpb24gYmFzZWQgb24gdGhhdCBhcyB3ZWxsIGFzDQo+IHdoYXRldmVy
DQo+IHRoZSBvdGhlciBjb3JuZXIgY2FzZSBpcy4NCj4gDQo+IEkgZ3Vlc3Mgd2hhdCBJJ20gZ2V0
dGluZyBpcywgY2FuIHNvbWVib2R5IChUcm9uZCkgcHJvdmlkZSB0aGUgaW5mbw0KPiBmb3INCj4g
dGhlIGNvcm5lciBjYXNlIGZvciB0aGlzIHRoYXQgcGF0Y2ggd2FzIGNyZWF0ZWQuIEkgY2FuIHNl
ZSBpZiBJIGNhbg0KPiBmaXggdGhlICJjb21tb24iIGNhc2Ugd2hpY2ggaXMgbm93IGJyb2tlbiBh
bmQgbm90IGJyZWFrIHRoZSBjb3JuZXINCj4gY2FzZS4uLi4NCj4gDQoNClRoZXJlIGlzIG5vIHB1
cmUgY2xpZW50IHNpZGUgc29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbS4NCg0KVGhlIGNoYW5nZSB3
YXMgbWFkZSBiZWNhdXNlIGlmIHlvdSBoYXZlIG11bHRpcGxlIGludGVycnVwdGlvbnMgb2YgdGhl
DQpSUEMgY2FsbCwgdGhlbiB0aGUgY2xpZW50IGhhcyB0byBzb21laG93IGZpZ3VyZSBvdXQgd2hh
dCB0aGUgY29ycmVjdA0Kc2xvdCBudW1iZXIgaXMuIElmIGl0IHN0YXJ0cyBsb3csIGFuZCB0aGVu
IGdvZXMgaGlnaCwgYW5kIHRoZSBzZXJ2ZXIgaXMNCm5vdCBjYWNoaW5nIHRoZSBhcmd1bWVudHMg
Zm9yIHRoZSBSUEMgY2FsbCB0aGF0IGlzIGluIHRoZSBzZXNzaW9uDQpjYWNoZSwgdGhlbiB3ZSB3
aWxsIF9hbHdheXNfIGhpdCB0aGlzIGJ1ZyBiZWNhdXNlIHdlIHdpbGwgYWx3YXlzIGhpdA0KdGhl
IHJlcGxheSBvZiB0aGUgbGFzdCBlbnRyeS4NCg0KQXQgbGVhc3QgaWYgd2Ugc3RhcnQgaGlnaCwg
YW5kIGl0ZXJhdGUgYnkgbG93LCB0aGVuIHdlIHJlZHVjZSB0aGUNCnByb2JsZW0gdG8gYmVpbmcg
YSByYWNlIHdpdGggdGhlIHByb2Nlc3Npbmcgb2YgdGhlIGludGVycnVwdGVkIHJlcXVlc3QNCmFz
IGl0IGlzIGluIHRoaXMgY2FzZS4NCg0KSG93ZXZlciwgYXMgSSBzYWlkLCB0aGUgcmVhbCBzb2x1
dGlvbiBoZXJlIGhhcyB0byBpbnZvbHZlIHRoZSBzZXJ2ZXIuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
