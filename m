Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73682FF54C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAUUBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 15:01:54 -0500
Received: from mail-dm6nam11on2107.outbound.protection.outlook.com ([40.107.223.107]:62629
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbhAUUBt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 15:01:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NelyUSur+MGKF1T5DTHAfK748CCKt07cYr0kw5OL+ndoM6CrdoxPhxLmNrjmSi/PT7NxN8eeuyM58ZhsncPx5zcrv8t7E0OgfvziTm3tej9N0QPT8ND0mNn7KoLu6/BmsC2NUPN+SsMHDLGkAIDw/iF5c1ZUaUOe+2nZxHd+SJa9UpkGKc22RWh+RDTVt2rL1Mr4bxh/2mhgXpVMH3rvaO+1wG3HnLH493s8ZsitqvZ9U6zNDYMU9ZvwzaKy3MYnS2SOcxK81Dly/myUWdxj4kGBxnY+5kVX4pPpt/DKltmoGx1LkRW3A2Q+zR1U1R6sooXrmHM1keBiPLWQ7mx+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVGHZBVgfTZsjc3/G5L6WiP5/zREJKH1uE2IvBfXJzg=;
 b=BwF0Q60Y/ao/Sh81fSRJ5ybvlf/60gNRs8b6REzXt/gPBJrBstD8LIi5hrwa7qKKS8ckglRVP9TiEkxryPppJ9xVtAga5ZBaxS303OaDWN/2+FRBmsoAUK7KauOJLW1ufskM2uVdPqosoPx28uJupFYzZl0FzHH4K/B0RlOCjiJSjvQuJj0u7BoZYJxljpKL5epDWF4jrQphjmK7xmGV6d5GP7pzRuCwvN2Ex8LcAuM9Jan2PzUbjDFXpQYdJRfnC9d5XMZtkoGF5J9HEnIvKra/AGFCsJ0KQjJqWLklRijtXrdtyCW5zTK1qDp764nCeFKiyW8B2FKDDKclUKRtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVGHZBVgfTZsjc3/G5L6WiP5/zREJKH1uE2IvBfXJzg=;
 b=W4Az21CC+damp7lXGY7VMBPW59F6z83YqnNWW82qyX8tesejG8UVYYKxg3qj3924zdOoDomYzmJFMypdjFgJ6siMTgbh0OxX3oqZxerq/fxeza7+H5OThxp9ykW+ahmM2a6fgpbcQeFtrlo4stVz2rlrVZRUexlTFeJ4TFXJP5g=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3895.namprd13.prod.outlook.com (2603:10b6:610:94::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6; Thu, 21 Jan 2021 20:00:53 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3805.006; Thu, 21 Jan 2021
 20:00:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Thread-Topic: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Thread-Index: AQHW706uPXeu1qrbdUiJKwuBPKUG1aoygaAA
Date:   Thu, 21 Jan 2021 20:00:53 +0000
Message-ID: <76fd114e0f4018cf7e00f565759e10acd1f0ba92.camel@hammerspace.com>
References: <cover.1611160120.git.bcodding@redhat.com>
         <f803021382040dba38ce8414ed1db8e400c0cc49.1611160121.git.bcodding@redhat.com>
In-Reply-To: <f803021382040dba38ce8414ed1db8e400c0cc49.1611160121.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.124.244.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba0390c-620f-483b-4bdc-08d8be474249
x-ms-traffictypediagnostic: CH2PR13MB3895:
x-microsoft-antispam-prvs: <CH2PR13MB389573DB1E6DF8A69AD3FA4CB8A19@CH2PR13MB3895.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBNAkHjQ1pgRrRx9sOR6EfOZ1lauDD1k5QVyrRtlTEVSOh52HNTFMWApoPhD9XTU91dgimVT0zX4VhQTDWmx+GPaYwWCVZSELeonRXaFeAhAF6Xq8jdGw4yofOP2FYsHD6f0LEp4qDsfiPnPTU9U7adUqdT9ozAbkjH/zRKZ2BxYQV1Oi78PZoq+ljvpF6rGDAM2qQVQCcsw6fPldSp8jtzuX1Gi0NdypU/dia6XJWjvN/G7HT0sVMcvWafbuDprwvC4yTlmYMvNY0ApGM+94faWtVHTGo8dpzWt865KpaW5UoVcS0u38z20fe3JoVNyLxWdXi6+xqUClEszlSzclVjWBmi0vYvhS6fgzQWXzJEkUdXAl1gshNSyefXkyLXXWinZmeAeU8/8qlRjeFoaQ5sI+kaP5oz/cJ1/jXaHNO52KyHlA0GbNuEZHCk7eJd9PLps0R7c3RLPg5vhL6idDTyPN8Dw+jZ8Dgi41/8GfjYhLku+S1fpM2B1mzu8VBCD2xYdO4LzDFf+wg4MyCI7C1hbEbpT8dVjhoHJ9kw7DMof1gcfWlE8OGe2ym3M2Tf/NwJIYG7BTXf1oF7b+beY9LKqK+UZzJronbzCm6cKpT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39840400004)(136003)(376002)(8936002)(2616005)(5660300002)(6486002)(8676002)(64756008)(36756003)(15974865002)(76116006)(86362001)(6512007)(83380400001)(66476007)(478600001)(15650500001)(110136005)(6506007)(66446008)(186003)(66556008)(66946007)(26005)(2906002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R2gva29qcnQ5M3ptUjNUK2xGS1lVTy82NTRIdmRNTWtPYlhxM25YWkp5OTJQ?=
 =?utf-8?B?SVFLODZFTDk3clF0aHhlSUJzS3JtN3RSR2pqUUx4a0pEOExnWFJlNFVDODR1?=
 =?utf-8?B?dzZ6Y1k3U0lDM0NSaXltMXlTWUxNekRCUUpLbytQc0N5WkFsWDNUNEVMWExz?=
 =?utf-8?B?NFBEOUt1SDJ2bFFDb0M5a0hleUZ3Ym5wcHNOSlg5ODF5RElaVVFPendPdG45?=
 =?utf-8?B?NU1QNmNaT05wZEFMQ0JTeVVLNjJlKytVL09uRnBHQ2xYRkszMEJ5TXRTbTR3?=
 =?utf-8?B?STdib293SVhWc3hEejdaVkZXUHYrZmVxY0Vta1JWams2eVZPSzVtYjBBTW9G?=
 =?utf-8?B?ZHJvbEFTRjFVem13L1lFWEdGT1B2Qm1jQ1lPbUlRU2R4OEI2bS9zT01CTzc1?=
 =?utf-8?B?cC9ORXQyYmZ3RDNBQWNBSitqOGMxMmI0b3d1NXVFOVFkTmlwdk55NU4zWUxW?=
 =?utf-8?B?Y3VqK2Ewd0U2M0FReHpRZmtHdUJJbERaYVdrclZlQ0NreWx1dkpiczU1NXY4?=
 =?utf-8?B?QVRmL0krcWFFaGczME5TK05ZWjdPSW1HTzFwa2NCOWpjbFA4bTEzaU1iREdI?=
 =?utf-8?B?VUxBTktmR1BCek5GaTdmamlialFtWnBaenhqNzNkZnQ1N3N6bnhnVmM0TXQv?=
 =?utf-8?B?MGx6MWtlY04vQm02aGo5RUNpbk5yRDF2RUo0eTNhVkh0UTljS0U4WWZRQnA0?=
 =?utf-8?B?ZEJ5UTczdlZCM0NKb3FvdEVQdWgwYUtSeHN4aGtYT0VOY3Nxc0xPeHJkZTFV?=
 =?utf-8?B?TWU4d2xTZHl2WXNvanRUZDdsb1FHajMrWUdDYm5TKzk4UURSc1hjUnVWOHZj?=
 =?utf-8?B?R1J3QkFBOVJIaUo5WXRXN0Jybm5zblFHNXN1Mzd5QlRYaE5YdXptamVXbWIw?=
 =?utf-8?B?aFhHWjllbW92UnhseWw0OTMyS0NudzFZS0p4WWZIYjl5cWQrM0YrdWV3TWZD?=
 =?utf-8?B?UjlDZ3JQaTRVMmNRdFU1aEVyWDFUU2Yvb1VYeEUrbHRtRnI2RHpmVUVOZXJo?=
 =?utf-8?B?aUJ4TkFBL0NsZzcySDhzYnpuUDNKZkp3UDRFS3FEcm9nU2dCTzk0Q2tNeTQ1?=
 =?utf-8?B?dXd0OUlwSXRnTDNua09TdDhSc1piNUZWVHBYbTFmL3lrQWExUC9waWVCQ0dj?=
 =?utf-8?B?ajBoY3I5a0NSdk9HQXV1YjlLYnBWK2VCM2hxb294MHFTbE5UTjR1c1E0QU4y?=
 =?utf-8?B?KzM5Z09ieFhBY2l6ODlnVTNLdkhuR1BLbzdIS2VZNFBqU1R5LzJkT2dieG1P?=
 =?utf-8?B?dCt3Tlc0dEZMRVRvTmhqVUJidU81UElHcVlnOE4xbkozcGdMeUpZTGFFN2pj?=
 =?utf-8?Q?uiZvOivJ7/7FXZAWY+2f96bNfjt65NlnvU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <451F0A036B394C4A9CBB97D950E42949@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0390c-620f-483b-4bdc-08d8be474249
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 20:00:53.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zZ1posX+vvJ+GNGHEsWwXkoXC3Mxst5+bxHItVR3mEyGiCyJfvUkiR4lhs3iTiviS6KgBax3FZSfdwTD/boOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3895
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTIwIGF0IDExOjU5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBXaGVuZXZlciB3ZSBzdWNjZXNzZnVsbHkgbG9jYXRlIG91ciBkaXJfY29va2llIHdp
dGhpbiB0aGUgcGFnZWNhY2hlLA0KPiBvcg0KPiBmaW5pc2ggZW1pdHRpbmcgZW50cmllcyB0byB1
c2Vyc3BhY2UsIHVwZGF0ZSB0aGUgcGFnZWNhY2hlIGN1cnNvci7CoA0KPiBUaGVzZQ0KPiB1cGRh
dGVzIHByb3ZpZGUgbWFya2VyIHBvaW50cyB0byB2YWxpZGF0ZSBwYWdlY2FjaGUgcGFnZXMgaW4g
YSBmdXR1cmUNCj4gcGF0Y2guDQoNCkhvdyBpc24ndCB0aGlzIGdvaW5nIHRvIGVuZCB1cCBzdWJq
ZWN0IHRvIHRoZSBleGFjdCBzYW1lIHByb2JsZW0gdGhhdA0KRGF2ZSBXeXNvY2hhbnNraSdzIHBh
dGNoc2V0IGhhZD8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzL2Rpci5jIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9m
cy9uZnMvZGlyLmMNCj4gaW5kZXggNjYyNmFmZjlmNTRkLi43ZjZjODRjOGE0MTIgMTAwNjQ0DQo+
IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gQEAgLTE1MCw2ICsx
NTAsMTAgQEAgc3RydWN0IG5mc19jYWNoZV9hcnJheSB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgbmZzX2NhY2hlX2FycmF5X2VudHJ5IGFycmF5W107DQo+IMKgfTsNCj4gwqANCj4gK3N0YXRp
YyBjb25zdCBpbnQgY2FjaGVfZW50cmllc19wZXJfcGFnZSA9DQo+ICvCoMKgwqDCoMKgwqDCoChQ
QUdFX1NJWkUgLSBzaXplb2Yoc3RydWN0IG5mc19jYWNoZV9hcnJheSkpIC8NCj4gK8KgwqDCoMKg
wqDCoMKgc2l6ZW9mKHN0cnVjdCBuZnNfY2FjaGVfYXJyYXlfZW50cnkpOw0KPiArDQo+IMKgc3Ry
dWN0IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3Igew0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGZp
bGXCoMKgwqDCoMKgKmZpbGU7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGFnZcKgwqDCoMKg
wqAqcGFnZTsNCj4gQEAgLTI1MSw2ICsyNTUsMjEgQEAgc3RhdGljIGJvb2wgbmZzX3JlYWRkaXJf
YXJyYXlfaXNfZnVsbChzdHJ1Y3QNCj4gbmZzX2NhY2hlX2FycmF5ICphcnJheSkNCj4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBhcnJheS0+cGFnZV9mdWxsOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRp
YyB2b2lkIG5mc19yZWFkZGlyX3NldF9jdXJzb3Ioc3RydWN0IG5mc19yZWFkZGlyX2Rlc2NyaXB0
b3INCj4gKmRlc2MsIGludCBpbmRleCkNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgZGVzYy0+cGdj
LmVudHJ5X2luZGV4ID0gaW5kZXg7DQo+ICvCoMKgwqDCoMKgwqDCoGRlc2MtPnBnYy5pbmRleF9j
b29raWUgPSBkZXNjLT5kaXJfY29va2llOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBuZnNf
cmVhZGRpcl9jdXJzb3JfbmV4dChzdHJ1Y3QgbmZzX2Rpcl9wYWdlX2N1cnNvciAqcGdjLA0KPiB1
NjQgY29va2llKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgwqBwZ2MtPmluZGV4X2Nvb2tpZSA9IGNv
b2tpZTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCsrcGdjLT5lbnRyeV9pbmRleCA9PSBjYWNoZV9l
bnRyaWVzX3Blcl9wYWdlKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2Mt
PmVudHJ5X2luZGV4ID0gMDsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBnYy0+
cGFnZV9pbmRleCsrOw0KPiArwqDCoMKgwqDCoMKgwqB9DQo+ICt9DQo+ICsNCj4gwqAvKg0KPiDC
oCAqIHRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGZyZWVpbmcgcXN0ci5uYW1lDQo+IMKg
ICogd2hlbiBjYWxsZWQgYnkgbmZzX3JlYWRkaXJfYWRkX3RvX2FycmF5LCB0aGUgc3RyaW5ncyB3
aWxsIGJlDQo+IGZyZWVkIGluDQo+IEBAIC00MjQsNyArNDQzLDcgQEAgc3RhdGljIGludCBuZnNf
cmVhZGRpcl9zZWFyY2hfZm9yX3BvcyhzdHJ1Y3QNCj4gbmZzX2NhY2hlX2FycmF5ICphcnJheSwN
Cj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGluZGV4ID0gKHVuc2lnbmVkIGludClkaWZmOw0KPiDC
oMKgwqDCoMKgwqDCoMKgZGVzYy0+ZGlyX2Nvb2tpZSA9IGFycmF5LT5hcnJheVtpbmRleF0uY29v
a2llOw0KPiAtwqDCoMKgwqDCoMKgwqBkZXNjLT5wZ2MuZW50cnlfaW5kZXggPSBpbmRleDsNCj4g
K8KgwqDCoMKgwqDCoMKgbmZzX3JlYWRkaXJfc2V0X2N1cnNvcihkZXNjLCBpbmRleCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gwqBvdXRfZW9mOg0KPiDCoMKgwqDCoMKgwqDCoMKg
ZGVzYy0+ZW9mID0gdHJ1ZTsNCj4gQEAgLTQ5Miw3ICs1MTEsNyBAQCBzdGF0aWMgaW50IG5mc19y
ZWFkZGlyX3NlYXJjaF9mb3JfY29va2llKHN0cnVjdA0KPiBuZnNfY2FjaGVfYXJyYXkgKmFycmF5
LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNl
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXNjLT5jdHgtPnBvcyA9IG5ld19wb3M7DQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2MtPnByZXZfaW5kZXggPSBuZXdfcG9z
Ow0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2Mt
PnBnYy5lbnRyeV9pbmRleCA9IGk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbmZzX3JlYWRkaXJfc2V0X2N1cnNvcihkZXNjLCBpKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiBA
QCAtNTE5LDkgKzUzOCw5IEBAIHN0YXRpYyBpbnQgbmZzX3JlYWRkaXJfc2VhcmNoX2FycmF5KHN0
cnVjdA0KPiBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yICpkZXNjKQ0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IG5mc19yZWFkZGlyX3NlYXJjaF9mb3JfY29va2llKGFy
cmF5LCBkZXNjKTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChzdGF0dXMgPT0gLUVBR0FJ
Tikgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+cGdjLmluZGV4X2Nv
b2tpZSA9IGFycmF5LT5sYXN0X2Nvb2tpZTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRlc2MtPnBnYy5lbnRyeV9pbmRleCA9IGFycmF5LT5zaXplIC0gMTsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWFkZGlyX2N1cnNvcl9uZXh0KCZkZXNjLT5wZ2Ms
IGFycmF5LQ0KPiA+bGFzdF9jb29raWUpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRlc2MtPmN1cnJlbnRfaW5kZXggKz0gYXJyYXktPnNpemU7DQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkZXNjLT5wZ2MucGFnZV9pbmRleCsrOw0KPiDCoMKgwqDCoMKgwqDC
oMKgfQ0KPiDCoMKgwqDCoMKgwqDCoMKga3VubWFwX2F0b21pYyhhcnJheSk7DQo+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gc3RhdHVzOw0KPiBAQCAtMTAzNSw2ICsxMDU0LDggQEAgc3RhdGljIHZv
aWQgbmZzX2RvX2ZpbGxkaXIoc3RydWN0DQo+IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2Mp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+ZW9mID0gdHJ1ZTsNCj4g
wqANCj4gwqDCoMKgwqDCoMKgwqDCoGt1bm1hcChkZXNjLT5wYWdlKTsNCj4gK8KgwqDCoMKgwqDC
oMKgZGVzYy0+cGdjLmVudHJ5X2luZGV4ID0gaS0xOw0KPiArwqDCoMKgwqDCoMKgwqBuZnNfcmVh
ZGRpcl9jdXJzb3JfbmV4dCgmZGVzYy0+cGdjLCBkZXNjLT5kaXJfY29va2llKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoGRmcHJpbnRrKERJUkNBQ0hFLCAiTkZTOiBuZnNfZG9fZmlsbGRpcigpIGZpbGxp
bmcgZW5kZWQgQA0KPiBjb29raWUgJWxsdVxuIiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKHVuc2lnbmVkIGxvbmcgbG9uZylkZXNjLT5kaXJfY29v
a2llKTsNCj4gwqB9DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhhbW1lcnNwYWNlIElu
Yw0KNDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMjA4DQpMb3MgQWx0b3MsIENBIDk0MDIyDQri
gIsNCnd3dy5oYW1tZXIuc3BhY2UNCg0K
