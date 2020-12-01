Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0422CAD2B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgLAUTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:19:25 -0500
Received: from mail-eopbgr750092.outbound.protection.outlook.com ([40.107.75.92]:51025
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730794AbgLAUTY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Dec 2020 15:19:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBJza+l76l3DuVtQdQb+TJ0E9V0Yrpsw2nMbx1f7cao3HARhXCZfvAVYGdODaJFxN+qNMSMT44nsTos9GKalepM0uGJTLt65RKu6C0NQjTVG+U/K60wCK3JZHwjpVpGO3dHyHfhmvuVJl2Ga5PViW8dxrlqUJZ7XWNZdme832cupurRcYo65uHYCIkLS3PRFGV3z/oZVwEJ7EUTqrj9DRhm0Z28lo9OuRKhEExFx1h2IjyMOF7iB4adH6MzEdh2b+Y4qWIP9WqFchaTfaqlPP0oy3Sp7TLDew9mRxynyj3DcJOGsZpWBZNcv8dxGwiqh5JfUrAHZr2azNDfHnSuZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Lu7srxHVtp3WZXJVgjyDG1V8AghP+F6syO2AmoeT4=;
 b=llUH/Cs+MDmmoieK/mEpYJpIrTYGhgCxRPlfpUfKzkG/A+HnlGOO/T+gqlcTc7AUngzAS15YpZx5x7h10LiJM9kbwXZ/D5yy1CQZuMsAe3LT32LKAtM2zwOeUgVRZS7wupx1V/Yxy1p3XyHZ+i9RV3GUxPTNXihAe+BPBePTgCuzVNdKULAy6PWd8u6OPvamZmW4F/GOisJFJRMxX1Ts4Ilr/zX3kkZAdPQcU3Yn6sa48WrtO6mQVlfW8BBN1yGWl2VDbofY6xtcTft5i9HHpaIAIqWe6mZBxjG6O67+ukZRjleHgeiVi2NHX+qcHKdGV2Y9smNEz1qY9GpMBX5ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Lu7srxHVtp3WZXJVgjyDG1V8AghP+F6syO2AmoeT4=;
 b=SQvR7vJw1hAWKIcBxlRzuwNWTFxihhUT0ZK3fkLh1nFogseH2E/ItIw4UBa6FsZ0eP6zFyIu8potxSjZE9BQ1MpQmAqvflOcN6KQSqZ7vqZ1kHCqSix4bpkuNn2KAXm6Zb+o0X6eYynj7V8RvoSa38U6f/J8LIwwSLGLLFHBLMg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3840.namprd13.prod.outlook.com (2603:10b6:208:1f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Tue, 1 Dec
 2020 20:18:35 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 20:18:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Topic: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Index: AQHWx5izYc2p09we50GI2WLg2u+XVqniowSAgAAMEQA=
Date:   Tue, 1 Dec 2020 20:18:33 +0000
Message-ID: <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
References: <20201201041427.756749-1-trondmy@kernel.org>
         <20201201041427.756749-2-trondmy@kernel.org>
         <20201201193521.GA21355@fieldses.org>
In-Reply-To: <20201201193521.GA21355@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e4ecb72-b28f-41e6-b9e9-08d896364768
x-ms-traffictypediagnostic: MN2PR13MB3840:
x-microsoft-antispam-prvs: <MN2PR13MB3840E1BB429521F9684ED6F6B8F40@MN2PR13MB3840.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ssrP1F3kZZ49/+z4ZZW7vdWThkR0IMacCtBVWeFRgqqsECEetUb1ud9lKmA6R6FeptapmBQ17SJOcsdZBXy1ixnDfOD+BYwFClepI/roVkuJyFm8SUxItyOA0567VegU0jBe6aidkBiG/ZCvDFC88L8RiN++OacbGIFVNRMs+EONUpxetbeLV1wFnCbFS0MdUM2/OHiKoxhKBlzyQTmzXiX8SBRJwdrDursXTH9Zt4xaVlqAp7Ty3bMCAO7fIpDVsja8FJm290Y4Phh4gWRRBJ7IuBoWK2foGDmxMRlic8jxTSid+g8q+WIXX9VncE23
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39830400003)(366004)(26005)(71200400001)(5660300002)(4326008)(8936002)(6506007)(8676002)(91956017)(478600001)(6512007)(66556008)(66476007)(186003)(66946007)(6486002)(2906002)(54906003)(2616005)(83380400001)(36756003)(110136005)(76116006)(316002)(66446008)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MHRoakdrUC95OUJEODJ6TlUySFEzeTBzaU80dE5IdnE0aGFUL0lrZFFLVVdY?=
 =?utf-8?B?ZEEvVTVHZjJuZHhRZEFTelcrRFk0MzAyVjZXQUUwS0x1YUQ1UEhNNy9kbHZn?=
 =?utf-8?B?T01YSjZtZWd1RXJ2azYwRW52emg4TlAxZzJqMjRrRkZaL0dvSVBIenpnNnl3?=
 =?utf-8?B?bk1sWllyK2hhSlNVaDZucVM1RkZESUtpQzRMSkJZVDlrR2ZEZGp1Ylc2UGRO?=
 =?utf-8?B?S05hRENKRmRVVTJEV3c1QlRJYjh3NUczQWt3SXRCR1dmcmV2bjIxZ1VsV3pL?=
 =?utf-8?B?OWlYbVN2NFZRTExJL0RWWEJuQVQxS0Q4VHFkeVNJMVUrVEx4OXYwNkZObDdY?=
 =?utf-8?B?R01BZ2Yvdjl4dDdvRm44VWRnb3VSRXZzdGROc3dNUnV2UTJEbVlKYkdKb3BH?=
 =?utf-8?B?SU5LU2pTT1JjaWJJWXJIRHI0TWJEVExLMG56OE5tSkJ0UjdUaEhDaExrTU5x?=
 =?utf-8?B?cmtnaHZZb3ZubUJub0xoT3U1Z2tpelRhNjZma3J2ZG9IYzQyS0lGQVNYS2d3?=
 =?utf-8?B?VWZiRGIwWTg1Wm5IRDlpVTJ0UlV4Q0xoZ2FPVzhZeDVCbnpxTnQ1VjZsL2VM?=
 =?utf-8?B?RW94M3RuUGY5WW1ZSTl1YUNFNnl1bUI2K1NrdEtGVUtLU2ZTeG1hWnFVVmg5?=
 =?utf-8?B?ei9WY0xjTUY5cEY4d2FlRUdtb3k5Mi90VEdJQ2NWT1AzSW0xU2h2cStHV3pQ?=
 =?utf-8?B?QmcvcWpFbi9LNzg3VjEwZHVuSVR3Rk5tbmpnZFZvYWYxVmFkUGlscVBrTDlv?=
 =?utf-8?B?aXkvTng5VzBsZkxKbGJGdTRZQ2xmUHpmUTRRZ2RNRlpGTWI4eDhzV3AzQnVi?=
 =?utf-8?B?SEhXZS9lZUZyVUxteXlYY2VUWU1oVFc5U3lrMTBPYlNqOVRuUWdCZjFYaHN3?=
 =?utf-8?B?Y0I3L1RnT1J2OUZ5VXlDUFVTbzBTTWpxZ2ZMRitReVpMTDhpYk81SDgyQld5?=
 =?utf-8?B?dXQ4dzZKRGNmL01DeEhPUElLYk9CWHRQQkxsYi85eERjdEVxbDJmb0hTUkRZ?=
 =?utf-8?B?d2Jja2JqOVBpdGQ3LzlhaklWT0toRGRaWmRxVVNSOTVSQy96WWZkdlBlQVJV?=
 =?utf-8?B?ckVqU2UvK3BGYkJpcTdQd3FjUEM1MFVVb21Zb2laTmNmcDZmNUtGdkpIZGta?=
 =?utf-8?B?YWxIZTFuSXFCMFhVWnYyU1F3eVM4czA2V0o5UlBLNERtNUp3alhqT0FoQXRR?=
 =?utf-8?B?N004ZzkvcFpuUWlTOUppNHR2WmE0d25ZLzJGZCtVdFdKOUFkZEVKeEhudHN4?=
 =?utf-8?B?RCtVV0M5Q2ZEd1lPVTdBYWhNTGtPYjJ4bTc4c0ZwVFNMRHNoTysxT0JLZ0pD?=
 =?utf-8?Q?qrRybFJ5OroELl2xrZy3hEGNL+HyE7eeR3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <08713CDCB259A34FBB6B351D1C8EF769@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4ecb72-b28f-41e6-b9e9-08d896364768
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 20:18:34.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKGamBNT1w4fpLB4+YMv1z4PbY94N10jlqReqkUMcrIZhx3bzcLQ6KlleyNkR9+4BBUyJ7SHv2S+UFtn+6M2Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3840
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDE0OjM1IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjE0OjI3UE0gLTA1MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IEZvciB0aGUgY2FzZSBvZiBORlN2NCwgc3Bl
Y2lmeSB0byB0aGUgY2xpZW50IHRoYXQgdGhlIHRoZSBwcmUvcG9zdC0NCj4gPiBvcA0KPiA+IGF0
dHJpYnV0ZXMgd2VyZSBub3QgcmVjb3JkZWQgYXRvbWljYWxseSB3aXRoIHRoZSBtYWluIG9wZXJh
dGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBmcy9uZnMvZXhwb3J0LmPC
oMKgwqDCoMKgwqDCoMKgwqAgfCAzICsrLQ0KPiA+IMKgZnMvbmZzZC9uZnNmaC5jwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNCArKysrDQo+ID4gwqBmcy9uZnNkL25mc2ZoLmjCoMKgwqDCoMKgwqDCoMKg
wqAgfCA1ICsrKysrDQo+ID4gwqBmcy9uZnNkL3hkcjQuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MiArLQ0KPiA+IMKgaW5jbHVkZS9saW51eC9leHBvcnRmcy5oIHwgMyArKysNCj4gPiDCoDUgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL2V4cG9ydC5jIGIvZnMvbmZzL2V4cG9ydC5jDQo+ID4gaW5kZXgg
NDhiODc5Y2ZlNmUzLi43NDEyYmIxNjRmYTcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL2V4cG9y
dC5jDQo+ID4gKysrIGIvZnMvbmZzL2V4cG9ydC5jDQo+ID4gQEAgLTE3Miw1ICsxNzIsNiBAQCBj
b25zdCBzdHJ1Y3QgZXhwb3J0X29wZXJhdGlvbnMgbmZzX2V4cG9ydF9vcHMgPQ0KPiA+IHsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgLmZoX3RvX2RlbnRyeSA9IG5mc19maF90b19kZW50cnksDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoC5nZXRfcGFyZW50ID0gbmZzX2dldF9wYXJlbnQsDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoC5mbGFncyA9IEVYUE9SVF9PUF9OT1dDQ3xFWFBPUlRfT1BfTk9TVUJUUkVFQ0hL
fA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBFWFBPUlRfT1BfQ0xPU0VfQkVG
T1JFX1VOTElOS3xFWFBPUlRfT1BfUkVNT1RFX0ZTLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBFWFBPUlRfT1BfQ0xPU0VfQkVGT1JFX1VOTElOS3xFWFBPUlRfT1BfUkVNT1RF
X0ZTfA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBFWFBPUlRfT1BfTk9BVE9N
SUNfQVRUUiwNCj4gDQo+IFNvIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCBh
IG5ldyBmbGFnIGZvciB0aGlzLg0KPiANCj4gQmVmb3JlIHlvdSBzYWlkIGl0IHdhcyBiZWNhdXNl
IGEgZmlsZXN5c3RlbSBtaWdodCB3YW50IHRvIHR1cm4gb2ZmDQo+IHRoZQ0KPiB2NCBhdG9taWMg
ZmxhZyBidXQgc3RpbGwgcmV0dXJuIHYzIHBvc3Qtd2NjIGF0dHJpYnV0ZXMuDQo+IA0KPiBCdXQg
aXQgc2VlbXMgdGhhdCBhKSB3ZSBoYXZlIG5vIGV4YW1wbGUgb2YgYSBmaWxlc3lzdGVtIHRoYXQg
d2FudHMgdG8NCj4gZG8NCj4gdGhhdCwgYikgaXQgd291bGQgdmlvbGF0ZSB0aGUgcHJvdG9jb2wg
YW55d2F5Lg0KPiANCj4gSXMgdGhhdCByaWdodD8NCj4gDQo+IElmIHNvLCB0aGVuIGxldCdzIGp1
c3Qgc3RpY2sgdG8gb25lIGZsYWcgZm9yIGJvdGguDQoNClRoZSAiYXRvbWljIiBmbGFnIGluIE5G
U3Y0IGlzIHZlcnkgc3BlY2lmaWNhbGx5IHRpZWQgdG8gYSBzaW5nbGUNCmF0dHJpYnV0ZSAodGhl
IGNoYW5nZSBhdHRyaWJ1dGUpIGFuZCBob3cgaXQgaXMgY29sbGVjdGVkIGluIGEgdmVyeQ0KbGlt
aXRlZCBzZXQgb2Ygb3BlcmF0aW9ucy4gVGhlIHRydXRoIGlzIHRoYXQgd2UgcHJvYmFibHkgX2Nh
bl8NCmV2ZW50dWFsbHkgc2V0IGl0IHdoZW4gcmUtZXhwb3J0aW5nIE5GU3Y0IGFzIE5GU3Y0LCBh
c3N1bWluZyB0aGF0IHRoZQ0Kc2VydmVyIGFjdHVhbGx5IHN1cHBsaWVzIHVzIHdpdGggYW4gYXRv
bWljIHVwZGF0ZS4NCg0KVGhlIHNhbWUgaXMgbm90IHRydWUgb2YgV0NDLiBXZSBtaWdodCBiZSBh
YmxlIHRvIHN1cHBseSBrbmZzZCB3aXRoDQphdG9taWMgdXBkYXRlcyBmb3Igc29tZSBvcGVyYXRp
b25zLCBidXQgY2VydGFpbmx5IG5vdCBmb3Igc29tZXRoaW5nDQpsaWtlIFJFQUQgb3IgV1JJVEUu
DQoNClNvIEkgZG8gdGhpbmsgdGhpcyBuZWVkcyB0byBiZSBzZXBhcmF0ZSBmbGFncy4gSXQgaXMg
ZGVmaW5pdGVseQ0KZGVzY3JpYmluZyBjb21wbGV0ZWx5IGRpZmZlcmVudCBmdW5jdGlvbmFsaXR5
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
