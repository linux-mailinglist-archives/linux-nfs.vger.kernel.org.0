Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3012A31AC34
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMOVw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 09:21:52 -0500
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com ([40.107.237.135]:5856
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229598AbhBMOVu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Feb 2021 09:21:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm3uXFhsjuLOyWrUMgAatre6Acjya39OXhWNSd1/axb6rLFu0IoCaIkQ9lPMOdp4DEeckPNYMfm5sfTnSMrkVdboxFAjBeLNdUbOkI9T6Aq/M1RoSKMXEA07L4B87TTmvstyp3RvOjadQC85cvjVrUWyAUFdb5nSXYqzMLAVZFWDc+A1UWq5c8jJxXNwNX/mPiosuflEnTJGgVpNH9Dsch+o+/qkhwfRtteYgX7NGHVLHLibAnqbDBFpjJfbu+AsxrYNv/WASMT6yo2p5cCLTrKkgO7SU6NYuHh5NEkLMChtNpdSxkH/IT8u4odXZoN8AKkmnK6Hal8M9htQj1qunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbzH0fd8YIyBuTQxXCAoaLoYcd7lhgJnH4q5tcrLb7M=;
 b=HxeKoLFNeHr7XJoMYU0EvprO2XZzz4O1ig1l+dVl9vpI+AHRQ8AHChZd3sNDEJ4SkC9Gm4hRzaP7ButbHqoBdtbpHE0JBXzP0eFlVWtiuo86ASFhLwF2kUchUBJ1RNGdEG/7kRKidi/QsneyMohczC49kI8loqefn5BVF8IWYqr5QYu80DFITZGFwTPvXPIBlxVIw7ZRagWLplEaedeSU2KsY5B80rJv9eNMhH5ff8sXRHn1jOJZPNOaz0eVzZND9/z+UVmFq9xAbrL3UWTYFx64OA14dDvHekGC+Mlt13Ri8wBfwld/4FnX+seOHnvrQexJYEFMH7lWtG9hN/CAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbzH0fd8YIyBuTQxXCAoaLoYcd7lhgJnH4q5tcrLb7M=;
 b=Rp7wTsOvx39fKE2iIPDRcAjXxRORwgTWxkNTM/EBJKA4PZXb8bSSEd42XnFEeZnboxODpJ1V69P6VaRS7Lhimi7x40QYEF4wvwG0tekpqWn+zafqEtNoOVy1Qh7FeDdQ0u7vXH1dYtIxB3HzHFALJAT+t6gEotbJyEdQ2xHoj6g=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3606.namprd13.prod.outlook.com (2603:10b6:610:2e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12; Sat, 13 Feb
 2021 14:20:57 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.019; Sat, 13 Feb 2021
 14:20:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add a mount option to support eager writes
Thread-Topic: [PATCH 0/3] Add a mount option to support eager writes
Thread-Index: AQHXAYkv+3VfFQqKZUW5BVowsEzSCqpWI0yAgAAAg4A=
Date:   Sat, 13 Feb 2021 14:20:56 +0000
Message-ID: <bf54d0b012686cc424ed4e3f1f8891bd2ab48dfc.camel@hammerspace.com>
References: <20210212214949.4408-1-trondmy@kernel.org>
         <d6d6c503-cdae-db31-45d4-e05fe46f0a2a@RedHat.com>
In-Reply-To: <d6d6c503-cdae-db31-45d4-e05fe46f0a2a@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe38ff2c-c1c7-4697-25c4-08d8d02a9480
x-ms-traffictypediagnostic: CH2PR13MB3606:
x-microsoft-antispam-prvs: <CH2PR13MB360608EF7D0B1682DA84D118B88A9@CH2PR13MB3606.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1VshuXaf67rkIJro7HqsZ9WHVuaew8yhpTyFK9c8m1keE/kiHcy5gDqt5Fd66bsJ88Z0AUhUs5bFc/LbYMCYlUP4GOafXGQmkPwzCqfzyB5cv3bijKeHDCSx/M15ylysjsEzKEhpOOTXCeo5u3WqiOA9R4uZoc8R4E7QXe7IAt2P7B03Yws7g9mF/04/cu0gR0NOJdwuGL7KA0KYb2eT7aXxF/eME+wFjwMTUelOHyPsdWA50kOR1Yuq+2QpqdL8LBzQ2QYJESdCWGyBvGydibYGx3eV46YSx42cBLAt/Y9BexAv/9OLwJ122V7F6nwx1H6veEUet6n8P9c3hrES+gKRgLVDQWZmktTIQmYPxqO5w1DCAGM0TDWci3t/Nfd/MSwxxMgauftS/NbCQbhP9JpW4IEnrsHSq9hRqrp1u9UtpbatvmG0cnZ83HDGV8EyLE398Ituluy+gRYm/Iv9EYsEUXU5iQdzvshZw5bWSN8la8GrF3hYdUB6e9CptDyERK/mcUhJVE9xiVP/FAi+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39830400003)(136003)(110136005)(76116006)(6506007)(53546011)(66476007)(66946007)(71200400001)(66556008)(66446008)(64756008)(86362001)(2616005)(83380400001)(8936002)(26005)(2906002)(36756003)(478600001)(8676002)(316002)(6486002)(186003)(6512007)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VkVvWVVJMkZJZjI2THBXWXRvTFpSU2wvU0xXS0UrakpSWUljWnp2bDUycHJT?=
 =?utf-8?B?L0taNU1UTE9wMnllNFVXS1dma0JXYm13bU9qRVkwWEdrbHc5SDNNSEJMQ0hI?=
 =?utf-8?B?b2dlZnpqSmU4aVhMN0IyQXJtcjA4YkxvTXZLRUQxeWtpRHBVOWFHT3VCSE9J?=
 =?utf-8?B?UDFGZENUNmRJdUEzNTByRUNEZ0RsbGV4S242RnFZYXYwVTN2bU5TalE2OFI2?=
 =?utf-8?B?VGdyenBhL3ZTOTVxOW9CME1GemFob000Wk1wT3JnaG9IU0QwUERLcGVDQXcy?=
 =?utf-8?B?Y2Q2b1hCYXVQUm54QjdHQmh0RVhLWlJVSVJSajA0OFd1aHhseEpyZklzSjdj?=
 =?utf-8?B?N0Nncm1zaUM5UU15WWxXNlg2czZ0MkxyYVVoaWhJSSttVEFVV1VVSFBpY1ZF?=
 =?utf-8?B?S3JVOHpWZngrYjhzemhsckxqZXZ4eEs1OW1laFhnZS94UFNqZlN0TERyWits?=
 =?utf-8?B?VW1tSC80U2UzcEE2RkpBMjJPWUZJQlZ4K3pUVjdDUVh0S3ZQN3ViTGpkOEVi?=
 =?utf-8?B?c1B4R1hlZytad2wwS216ZVRLOHdsM2d6a001dE9iUTZQWkZpa1dCeVRRU3Ur?=
 =?utf-8?B?bFlXTnVQbU9MZFZyZGhCMkVmeElyZmtTMDROUXNpVEJlV3hkL3VNdEZSc3pB?=
 =?utf-8?B?b0xYQk9BczFjSXBOZGlEc1lvUDNOV3hGd1dEYnJiNlhNdnVGbFJPK1A0V1lx?=
 =?utf-8?B?Wi9PWi94ZDBOQXBkR05jWmVTcUNEZFRXVnVtRGpUeElJcGNYd25wZmhiUGZE?=
 =?utf-8?B?bDdQbU1OemVXalRlZEZzdVJPNzdOVU16VzN6a0J0K011L2RFN1MyVWhrWERI?=
 =?utf-8?B?ZWljcTlwb3JDK2hLMHBYSDFxU3R6dTljd3dJaWczMnNRYzVzUzhzZEVnZytq?=
 =?utf-8?B?VzlmVUNYcDFCZXFUYlhKTVBMT0R2SmtpeDVLQnc4T3Vic01nbzJEN2FySThq?=
 =?utf-8?B?aWFOWi85RGU1TnhJdDJqblVYRm5tQU5wWTA3NTcrSDhacXNmVzZnQUFCd1lB?=
 =?utf-8?B?ZEhGNVNIZ1Bub1V4ZEdoWWxtSTFXN1daUXoyblZ6ODVvVWJtcmpPbFZOK0lq?=
 =?utf-8?B?UlNvaFM5c0pFZWZ4RWpPd3h5bVd0YjNlZGQ2Qkx3aG0rS0xmaGVnVU1RSEE5?=
 =?utf-8?B?WWxtend5aWJJL09tVFdDK25Ebi9sQ2M3SkxXYjNSVk5BaDByUm9MMTBTSmxF?=
 =?utf-8?B?akJibGEwdHdFYlZOYzhGTFA5T2ZsT2pwSHRhcjFJWGsxZVl4M0ZYRkhkRm1T?=
 =?utf-8?B?b3JBQ1pzMFJ1ZHVpSE9wNTZDcGE0M2xpWjJMS0tnSHpBM0ZOc240VUY2Zm1D?=
 =?utf-8?B?YXJDNzRaeE1wcFU0c3NSVDEyelk3cGdWMVVJNnBuaVdwNVBZSW1aQmdqaUhy?=
 =?utf-8?B?Ni9aY2dRVTFCRGFwQzZTZzJ0TWlpblFjcVJxV1RNUGw3K1VkNTJsQng0TTVS?=
 =?utf-8?B?SUtNVkRIZEVyV3EreTNOSmxKanNuOFVxMkg2a3ZhZWYydTJqMFRMSFZiWWlz?=
 =?utf-8?B?M0VYVW5SVFBKSTlYUlViUVJEajhaakthb0ZVQXBYQjJrQ28wOS85ZmJsbmNs?=
 =?utf-8?B?WEZCOFdHT1FSK1drbGJGalpZTEE3QXFoUFRUR2xNRE5sTk0xNlB1OHZJLyt3?=
 =?utf-8?B?MXRpeXRmaitZMUdrOFArRHZmbGk4cnowdGpxQWgvSHVsb2NzTHhrYWVPbUVV?=
 =?utf-8?B?aHdXRkVqVmtzalQ1elhVRkFtSEcyekVuR2FGRXhmdkRrRmxmNkRsZlhaT0NZ?=
 =?utf-8?Q?4yCsFXlXCCAz7wreVPTwcFpdjnIZRAcGMgclpn2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F056798794A14582C0EAB4B054B91C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38ff2c-c1c7-4697-25c4-08d8d02a9480
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 14:20:57.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvCy79mveIhIJsOT2o3Pi0bBh39o18BD9dGvLhji4QEZ2P1IlFCUURBJLsPNPm6KuxDozefKBa7a1rQZTPzK4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3606
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIxLTAyLTEzIGF0IDA5OjE5IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiBIZXkhDQo+IA0KPiBPbiAyLzEyLzIxIDQ6NDkgUE0sIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+IA0KPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIHNldHMgdXAgYSBu
ZXcgbW91bnQgb3B0aW9uDQo+ID4gJ3dyaXRlcz1sYXp5L2VhZ2VyL3dhaXQnLiBUaGUgbW91bnQg
b3B0aW9uIGJhc2ljYWxseSBjb250cm9scyBob3cNCj4gPiB0aGUNCj4gPiB3cml0ZSgpIHN5c3Rl
bSBjYWxsIHdvcmtzLg0KPiA+IC0gd3JpdGVzPWxhenkgaXMgdGhlIGRlZmF1bHQsIGFuZCBrZWVw
cyB0aGUgY3VycmVudCBiZWhhdmlvdXINCj4gPiAtIHdyaXRlcz1lYWdlciBtZWFucyB3ZSBzZW5k
IG9mZiB0aGUgd3JpdGUgaW1tZWRpYXRlbHkgYXMgYW4NCj4gPiB1bnN0YWJsZQ0KPiA+IMKgIHdy
aXRlIHRvIHRoZSBzZXJ2ZXIuDQo+ID4gLSB3cml0ZXM9d2FpdCBtZWFucyB3ZSBzZW5kIG9mZiB0
aGUgd3JpdGUgYXMgYW4gdW5zdGFibGUgd3JpdGUsIGFuZA0KPiA+IHRoZW4NCj4gPiDCoCB3YWl0
IGZvciB0aGUgcmVwbHkuDQo+ID4gDQo+ID4gVGhlIG1haW4gbW90aXZhdG9yIGZvciB0aGlzIGJl
aGF2aW91ciBpcyB0aGF0IHNvbWUgYXBwbGljYXRpb25zDQo+ID4gZXhwZWN0DQo+ID4gd3JpdGUo
KSB0byByZXR1cm4gRU5PU1BDLiBTZXR0aW5nIHdyaXRlcz13YWl0IHNob3VsZCBzYXRpc2Z5IHRo
b3NlDQo+ID4gYXBwbGljYXRpb25zIHdpdGhvdXQgdGFraW5nIHRoZSBmdWxsIG92ZXJoZWFkIG9m
IGEgc3luY2hyb25vdXMNCj4gPiB3cml0ZS4NCj4gPiANCj4gPiB3cml0ZXM9ZWFnZXIsIG9uIHRo
ZSBvdGhlciBoYW5kLCBjYW4gYmUgdXNlZnVsIGZvciBhcHBsaWNhdGlvbnMNCj4gPiBzdWNoIGFz
DQo+ID4gcmUtZXhwb3J0aW5nIE5GUywgc2luY2UgaXQgd291bGQgYWxsb3cga25mc2Qgb24gdGhl
IHByb3h5aW5nIHNlcnZlcg0KPiA+IHRvDQo+ID4gaW1tZWRpYXRlbHkgZm9yd2FyZCB0aGUgd3Jp
dGVzIHRvIHRoZSBvcmlnaW5hbCBzZXJ2ZXIuDQo+ID4gDQo+ID4gVHJvbmQgTXlrbGVidXN0ICgz
KToNCj4gPiDCoCBORlM6ICdmbGFncycgZmllbGQgc2hvdWxkIGJlIHVuc2lnbmVkIGluIHN0cnVj
dCBuZnNfc2VydmVyDQo+ID4gwqAgTkZTOiBBZGQgc3VwcG9ydCBmb3IgZWFnZXIgd3JpdGVzDQo+
ID4gwqAgTkZTOiBBZGQgbW91bnQgb3B0aW9ucyBzdXBwb3J0aW5nIGVhZ2VyIHdyaXRlcw0KPiA+
IA0KPiA+IMKgZnMvbmZzL2ZpbGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE5ICsrKysr
KysrKysrKysrKysrLS0NCj4gPiDCoGZzL25mcy9mc19jb250ZXh0LmPCoMKgwqDCoMKgwqAgfCAz
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoGZzL25mcy93cml0ZS5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+ID4gwqBpbmNs
dWRlL2xpbnV4L25mc19mc19zYi5oIHzCoCA0ICsrKy0NCj4gPiDCoDQgZmlsZXMgY2hhbmdlZCwg
NjUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiANCj4gU2hvdWxkbid0IHNvbWV0
aGluZyBiZSBhZGRlZCB0byB0aGUgbmZzKDUpIG1hbiBwYWdlIA0KPiBhcyB3ZWxsIGFzIGJsdXJi
IGFkZGVkIHRvIC9ldGMvbmZzbW91bnQuY29uZiBmaWxlPw0KPiANCg0KU3VyZSwgYnV0IEknZCBs
aWtlIGNvbW1lbnRzL2NvbnNlbnN1cyBvbiB0aGUga2VybmVsIGJpdHMgZmlyc3QuIPCfmYINCg0K
Q2hlZXJzDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
