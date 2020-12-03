Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E382CCB4C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 01:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgLCAzs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 19:55:48 -0500
Received: from mail-bn8nam11on2118.outbound.protection.outlook.com ([40.107.236.118]:19009
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726929AbgLCAzs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Dec 2020 19:55:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPcdMgM3oiW/PoIXeLVWWtbr4lPiSaItyDpLbzXOBo11tVLYGeX9W0zu0rPFXjyLhN5ddbESR/CaaWn10nDcMGt4+n4Bpy2W3TiZTDMpf6kSoLpTpDRi1wE6eK8tCJY5F3U1QeZJLKSth+rG5XBlvrRghYTPbGGjQGJ8VkMcSv/WP6C3bBdT9l2QP9cvGgFldGnZPFyDyM+l+JAO9e345OR9/ppUkLE+SJ4HbbiCKpt2IsR7kcV0wPJFCHs2Y7MHl/XYEVlWVVwoaTjkn75EwUV/w4b4d5/VN+Vf9IgowvB/b4DyoZD/hun/R1HVk7IwSVSb/n5pk6ceGu+v19OAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Pj9oKPFO/scjRLmUAHwrtwPud22wzEyyDW5hFHCWw=;
 b=PvPBi7uamgCUVKDEuU46iFCHH8U+F9o0WhQVYoI1ASd5aS+ARYvHq8g82/9ebjFZ96nq+lKEY1OE8dWM60Vy/LE8L7JSlEf4HNgSwU2ezm8bT+lGsIHGL97nwqVih/LMguMEaHuwPnJTKtQ69Pil9mJnXW3faqV4gz5NbNEGsWsMOtLwxxUXu6a5MlNrzgHCM/RqLxClVeOW1myFIaH/6ubhGagamdiMGSKJ+Xc05c7wpob1/3a5Yn1LDGMJvCBaD8a9k3LjMmI8031jPKg7/x3nlu+dS51G9JHaq/ptLt6KvZ/nJmj156lc8kyllW23IuMqa5WSOFmXbnH+jnVaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Pj9oKPFO/scjRLmUAHwrtwPud22wzEyyDW5hFHCWw=;
 b=ITRNt46+cxJJWGhMnhwSZkL9ce7NWTvttIJzGj+s7YqJpNbeB49gF8B6BKNeZobcxKYkJKtlzr6MMx55xRLQYZROBl+LblIbPFRDKHC12J15XgSfoB9ZliCZoZQMBkVCm77prrbKNeONeTLliCWUzo5Y2o8FmOaJfHCmQaDmsZY=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4257.namprd13.prod.outlook.com (2603:10b6:208:82::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Thu, 3 Dec
 2020 00:54:54 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 00:54:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "steved@redhat.com" <steved@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/2] mountd: always root squash on the pseudofs
Thread-Topic: [PATCH 2/2] mountd: always root squash on the pseudofs
Thread-Index: AQHWyP6uQPA8SGjJR0WpVnyIOggCC6nki9MA
Date:   Thu, 3 Dec 2020 00:54:53 +0000
Message-ID: <c9f91aa0ac98cd132fb212166aba01864c609939.camel@hammerspace.com>
References: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
         <1606949804-31417-2-git-send-email-bfields@fieldses.org>
In-Reply-To: <1606949804-31417-2-git-send-email-bfields@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b97b8f7-3fb5-44cf-8f34-08d897260c13
x-ms-traffictypediagnostic: BL0PR13MB4257:
x-microsoft-antispam-prvs: <BL0PR13MB4257754FD92E6B37920F64C9B8F20@BL0PR13MB4257.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1agkvS/WxPqICG7bb3sNg5ELrohyDnvoRckDjxH1cxukQdRpQ77htohGvguBXrseMsdpAd7kC7fhBuYPEtyP1udldhUSloU0DzN5Aupu7QC5LxTGKdfSvpUXJ5om90AtR7hERQcVv3U18H9VwQpQdVcNuDiOXalVRx0ia/rXL2tWbKZ451DAfQzq9MC/BWyKFy98V/kq1Kz088qxsJ3N07c2VVH8aKIyZXKg7Vg0gpDpK2Wd3YHuAP6fD1zJF8zc14JMsTjC6bvMMmZaGTc9T/fKn3A2LB5mQ+TY6VBHTqh4+7Th8JXRooMKU7y3VecQk15S1E8T3UTsF8oywNhuYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39840400004)(136003)(346002)(376002)(316002)(6512007)(83380400001)(54906003)(71200400001)(110136005)(186003)(26005)(6506007)(36756003)(5660300002)(86362001)(66476007)(66556008)(4326008)(64756008)(66446008)(2906002)(91956017)(66946007)(76116006)(2616005)(478600001)(6486002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmtXR3hsYUN0Q0NjYjJJQ1NQajlOOCs4VDcxeFZkaVNDalJBSkNnTEsvdEx5?=
 =?utf-8?B?KytEWCtPT3UrS1FUQXBDQXd3aFNISUZrWTE1dE5BSnNUbGU4RXc3S3RvbjB5?=
 =?utf-8?B?N2tkZ25VUmJOOVY0aWV6ZEFwTzMxbkhObFp2Z2lqdE9Hb0ZNbTRpR0Jsa1pF?=
 =?utf-8?B?d0p2L3UzYlljT3BZLy9KVFFjSmFuL3RLbEREdUE4d1cxdlAzL040aDlhbnNI?=
 =?utf-8?B?RmhLOVJKa1F0bUxsakU2OXlLV05xQ1NKdUU4VW5zdTBYYytBVnRTZU4yV0NH?=
 =?utf-8?B?R2Q1ZmNtSUUvMmY3aXp4MU1MeklOSTBnVC9SRmRtTzYreGFtRDhXZWRTMUJr?=
 =?utf-8?B?UkJjd0dEcysrdUZPMlhLYUxmaFYzNGZwUjVXNmxnY3FXZDBWM1NSckNZN1pw?=
 =?utf-8?B?ei9NZkIwQ0JJMVN5Ly9jOWVkaEFlVi9DMEtpbkN1cVA0U2h2RnV2TTZzNkJq?=
 =?utf-8?B?SWVldjJHMDJMYzVMSlNhM0dsY2hBeFpldVNCb3B6TWUyOEhEWWw1WVlKZEZh?=
 =?utf-8?B?akgwM2Qwb2lIQTVnU3UxOUlrYmwwTFlNb2wvbmovYnFjZU13ay8yY0VOS25v?=
 =?utf-8?B?Z3hFK2oxM0hVbEVMRjRCU1JUdGJ4MDVWRXkrTU1OaWJVNXNrWW1wOXdvZVJu?=
 =?utf-8?B?bjRYY3hZSWt2ZWFMN0tDSWM0dWJuVDN6REVWbmhXNlVuQVF3UEY0akdwVWNK?=
 =?utf-8?B?SjVBdzhjT1Fxd20yUVJoUTh0cFM0WkNrOXZkMDlZOTNueC9BcDB0Zmd2VU5z?=
 =?utf-8?B?eGNoZk56dlN0Ulp6dGxCeVhhT0U4OG95RjlEZjhlQzhybVBjMmdLdllISTE3?=
 =?utf-8?B?Ky82T2R3b2wvNktHelJXa1lZUHhJZzNtcHBVTnYyZFprWjFzdEYwV09xSUZZ?=
 =?utf-8?B?bzBMR1c0bXIyY2dyd25KdVI5SlpCQlBJYjR6VnJHQUFoSkxyRE5XU2dOcEFw?=
 =?utf-8?B?VUhmeVV2bk5HQkpyaU9LVXJpdHdWckpYMFNoWHBDV3J1dS9VcjVla0x3Q2h0?=
 =?utf-8?B?VjdBekZ1NGRxWTFhdmtnSG15ZUdqdUZkUUpLVjk1Zk8yRXQxdzdJdHR1Y2J2?=
 =?utf-8?B?MTZsTXFIS0xGTVBtRDA0TDE1MU8rbnZkb0I4MVptdnhmVDJMUU5mT3FhVFgr?=
 =?utf-8?B?RWpybDdmU3ZPVU95c0VNVnhiM20wcDJxTC9WQnlrb1lYbjFsekRGTUtPdVNN?=
 =?utf-8?B?emxDdnU5dGxhQXhEd0RPL3d0cHQ0WlJoY2JsNE1Nem44ZmpTSHZpcmU3eXVS?=
 =?utf-8?B?UjlxSVk4eHdka3lZZlBaOHFjRmlsbC9DZWFScUdhWmVOSU1XVzBtN2wxRXNU?=
 =?utf-8?Q?anL3i4tndVNFUTuBA43+2Q3B7yn4gb3WsW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <813108DFA9E332439267505539BEC896@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b97b8f7-3fb5-44cf-8f34-08d897260c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 00:54:53.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFASvLks/isBZAaPAFxdYoNUVV4ocGBQdqrDLGgpZ6BVjy+waN6e7xyGm7DVCsevL9O1Y+reiD+xgmWWbZivig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4257
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTAyIGF0IDE3OjU2IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQHJlZGhhdC5jb20+DQo+IA0KPiBB
cyB3aXRoIHNlY3VyaXR5IGZsYXZvcnMgYW5kICJzZWN1cmUiIHBvcnRzLCB3ZSB0cmllZCB0byBj
b2RlIHRoaXMgc28NCj4gdGhhdCBwc2V1ZG9mcyBkaXJlY3RvcmllcyB3b3VsZCBpbmhlcml0IHJv
b3Qgc3F1YXNoaW5nIGZyb20gdGhlaXINCj4gY2hpbGRyZW4sIGJ1dCBpdCBkb2Vzbid0IHJlYWxs
eSB3b3JrIGFzIGNvZGVkIGFuZCBJJ20gbm90IHN1cmUgaXQncw0KPiB1c2VmdWwuDQo+IA0KPiBK
dXN0IHJvb3Qgc3F1YXNoIGFsd2F5cy7CoCBJZiBpdCB0dXJucyBvdXQgc29tZWJvZHkncyBleHBv
cnRpbmcNCj4gZGlyZWN0b3JpZXMgdGhhdCBhcmUgb25seSByZWFkYWJsZSBieSByb290LCBJIGd1
ZXNzIHdlIGNhbiB0cnkgdG8gZG8NCj4gc29tZXRoaW5nIGVsc2UgaGVyZSwgYnV0IGZyYW5rbHkg
dGhhdCBzb3VuZHMgbGlrZSBhIHByZXR0eSB3ZWlyZA0KPiBjb25maWd1cmF0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5jb20+DQo+IC0t
LQ0KPiDCoHV0aWxzL21vdW50ZC92NHJvb3QuYyB8IDIgLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS91dGlscy9tb3VudGQvdjRyb290LmMg
Yi91dGlscy9tb3VudGQvdjRyb290LmMNCj4gaW5kZXggMmFjNGU4Nzg5OGMwLi4zNjU0MzQwMWYy
OTYgMTAwNjQ0DQo+IC0tLSBhL3V0aWxzL21vdW50ZC92NHJvb3QuYw0KPiArKysgYi91dGlscy9t
b3VudGQvdjRyb290LmMNCj4gQEAgLTYwLDggKzYwLDYgQEAgc2V0X3BzZXVkb2ZzX3NlY3VyaXR5
KHN0cnVjdCBleHBvcnRlbnQgKnBzZXVkbywgaW50DQo+IGZsYWdzKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IGZsYXZfaW5mbyAqZmxhdjsNCj4gwqDCoMKgwqDCoMKgwqDCoGludCBpOw0KPiDC
oA0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoKGZsYWdzICYgTkZTRVhQX1JPT1RTUVVBU0gpID09IDAp
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwc2V1ZG8tPmVfZmxhZ3MgJj0gfk5G
U0VYUF9ST09UU1FVQVNIOw0KPiDCoMKgwqDCoMKgwqDCoMKgZm9yIChmbGF2ID0gZmxhdl9tYXA7
IGZsYXYgPCBmbGF2X21hcCArIGZsYXZfbWFwX3NpemU7DQo+IGZsYXYrKykgew0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBzZWNfZW50cnkgKm5ldzsNCj4gwqANCg0K
SG1tLi4uIFdoYXQgaXMgdGhlIGhhcm0gaW4gYWxsb3dpbmcgcm9vdCB0byBiZSB1bnNxdWFzaGVk
IGhlcmU/IElzbid0DQp0aGlzIHJlYWxseSBhbGwgYWJvdXQgcmVzcGVjdGluZyBsb29rdXAgcGVy
bWlzc2lvbnMsIG9yIGNvdWxkIGEgdXNlcg0KYWN0dWFsbHkgbW9kaWZ5IHNvbWV0aGluZyBpbiB0
aGUgcHNldWRvZnM/IElmIHRoZSBsYXR0ZXIsIHRoZW4gdGhhdA0Kc291bmRzIGxpa2UgYSBidWcg
KHRoZSBwc2V1ZG9mcyBzaG91bGQgYWx3YXlzIGJlIHJlYWQtb25seSkuDQoNClRoZSBjb25zZXF1
ZW5jZSBvZiBub3QgYmVpbmcgYWJsZSB0byBsb29rIHVwIGEgZGlyZWN0b3J5IGluIHRoZQ0KcHNl
dWRvZnMgaXMgdGhhdCB0aGUgTkZTdjQgY2xpZW50IHdpbGwgYmUgY29tcGxldGVseSB1bmFibGUg
dG8gbW91bnQNCnRoYXQgc3VidHJlZSwgc28gc3F1YXNoaW5nIHJvb3QgY291bGQgbWFrZSBhIG1h
am9yIGRpZmZlcmVuY2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
