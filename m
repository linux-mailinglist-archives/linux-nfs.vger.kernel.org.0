Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827122CAD50
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgLAU2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:28:32 -0500
Received: from mail-dm6nam12on2128.outbound.protection.outlook.com ([40.107.243.128]:63648
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729347AbgLAU2b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Dec 2020 15:28:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkCTEeXSfLzfyEE1TmdkXREL9GiuQ9GVSpFWq1C21zJSpeGXqVtFR5tGAGkI75rllxvb9J9yC5zRqt3OsQhPBDvfRfR5zFVLWRNJsSmUaLOjHXPs0tTuPQCZH2l1QqBuFytj1d9N2Ev6O+0yWPhaykgFPd56zH4SJITQBehsKEnWn0FiqzFYCHAawByr6zNBhOvNpZlh0VX6SvAcgaACsAIupHkHgAnU/YfpxvAZK+rGDZ7byCb2AalL+6pB1UUQnfb7ha9cTKR+rhuec11n/nFlWp/BZPf74g41kE/ZMDalj2aae8wmuINk9K8VxW9k4FwDzAfzpAbSDYfLUjtkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1IRsJCEpUFxKpPDDqHCtcqCY/CPVJR7jF8FlpCbP+k=;
 b=dLhcGuhWmjLU9QANL3PgRGVoXQ67ADhzzNmrwjZ5rcgMeDHBobREotvA07nfoCY2nUg6GR1K8mg8C8jZp/5Ne1aSBfJHQwi3LzQ31TJY6L773rh88CdmoDhRXLv4dcLek3I/aeFONPR/2GbaCUaidy0FZofBPPUcTTfblks7LNKBUANhZE8Bclpyd6xenwgqPiGyALipSRf6K8KhmKG3WYTdCg2EtFzOHRlLsG3InztdkNHRpxKX9EZdBrWFxxGCNEAJSEsMn+syqGVrqFClcSGAkWdjdSPaeip6r/QJOYyjVTd/nuvjonT0Esv4QM3HOoRFpF1vEhFHaGv0F9yB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1IRsJCEpUFxKpPDDqHCtcqCY/CPVJR7jF8FlpCbP+k=;
 b=SoZIFacpoIdtKpcnntcVnAktZe55wdtrVneyTldF4PCimWNFgonmQsGVFtXFPoZ0eZyOU4rake+C/9/xEt74BtoN5gKKhQk3a3NjeRsUgsNUlnSiivvJaP7prwZbdXwVSL95IHUXVIg2kf0m1hLtLCmmSRoZQHzWeQLHHkCto7I=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3840.namprd13.prod.outlook.com (2603:10b6:208:1f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Tue, 1 Dec
 2020 20:27:39 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 20:27:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Topic: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Index: AQHWx5izYc2p09we50GI2WLg2u+XVqniowSAgAAMEQCAAAKKgA==
Date:   Tue, 1 Dec 2020 20:27:38 +0000
Message-ID: <7181b1e7290dcfe4f92d9a8b00117a81b30f0cce.camel@hammerspace.com>
References: <20201201041427.756749-1-trondmy@kernel.org>
         <20201201041427.756749-2-trondmy@kernel.org>
         <20201201193521.GA21355@fieldses.org>
         <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
In-Reply-To: <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc51e3a8-b593-4db2-11d0-08d896378c09
x-ms-traffictypediagnostic: MN2PR13MB3840:
x-microsoft-antispam-prvs: <MN2PR13MB3840C94C798535ADA710151DB8F40@MN2PR13MB3840.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhqoMOA8fmXX13hFncww30IjxY8hN8Q4HpmvLYzC1maInVuSLeWQq2OcszLffNbBkoHyqyCR063M8v6xC6tV5QF5d8YENF/OO1oSNW8bajX3tjb2kUXIj4NiKCuFG1VLTIuTU5s/UEo+56alNMDg+h6E0qfp9M8xrk9+jh3ElCG2qBrIyDU4PaJMKQMIQ4X5Rvxc6rUplHXsoGrptQmbVNIqhRZ4wGelZeL7nIrifOJ/G2rx4JcgWWswfHkZc32sHmo/EeJ9N5HuBGxvOvyU8leQv5HAdBECsTgnB3W9PKgUkDDX/94qAJgOU/V3HeEv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(376002)(396003)(136003)(54906003)(66446008)(86362001)(316002)(64756008)(83380400001)(2616005)(76116006)(36756003)(8676002)(91956017)(6506007)(66556008)(478600001)(6512007)(26005)(5660300002)(71200400001)(6916009)(8936002)(4326008)(6486002)(66946007)(2906002)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?enpobmk2TzFYRTJjcldHTExPT0JuM2RtR2YvTnNrSXNoMVMrT0hqOENIQXgy?=
 =?utf-8?B?R3pxR1BPbXVaNGZUbWE1aS9iQW1iTDBvSlgycEhIc2E4K0l3ajB2WWtpaWlP?=
 =?utf-8?B?N2tHRUhEbTg1OVV4VHJuSE13Ym16L2k5WVBORVhQVndhcTZmd3g3bzB4MFpY?=
 =?utf-8?B?djhiYStlbUkySllRUEtlTzFwWGw2QTNhMWxQNXFhcDJ6V1lpMWl4Q2tDWG82?=
 =?utf-8?B?ZWF5Sk1TOTRNd0kzeC9iWEtSWEdWYlh4VWtCbWZuVHlhMUszSzJNcVJUVmgy?=
 =?utf-8?B?OVZuQytQdk5DTnoyRVhnM0h4NENwMmdUVU1QYklxR1ExRXNSY3BlR3VYS2t1?=
 =?utf-8?B?azdoSlVoazJnOFlndnIzM2NOWXNFY1ExMklsSTFoOEpXakZVNUZldzhPbFdj?=
 =?utf-8?B?ZU5FY1ZzTTltd3dXbFgwZTNIQjQ1RlNMdEJoUkxVanZBMDhvQzRPeFd5ZVFv?=
 =?utf-8?B?UlpkbmpaanIvV3hKaUVsQUlJNUhQMXRXQ2pzaEQvWUVlTDVERjlPbExUUGdL?=
 =?utf-8?B?c0tSS05QcmNwSTlhYlJwRmRVQ0FCZTI2ZlpJK2tqcWNBbE5QdWZkR1NsQkxa?=
 =?utf-8?B?SnpFcXVFbEgrMEpaK0lValByL3ZxVDg5UmRMVEtCanJOeksxT3lSNk4xWmZN?=
 =?utf-8?B?eWpxVGR2Z2k2d1hWam83MnR4aEQySUo5RklEYjZBelFwZDhzOFJCdDhUMVhD?=
 =?utf-8?B?OXE1Sk9LY1ZLcXRhQ2RpaWtXVzVXMytPVUltNnlQZGpqb283MFBPMCtKNzk1?=
 =?utf-8?B?dStkeEhuQ0dlZnVMdzlUcDBPMWNrVVBuYm1NSlpDWjQ1ejRZMWRiZWpzZ3di?=
 =?utf-8?B?b1RjQkxia1lsR0VYSThEZnNkT2xXTUpJZ3haWGFKb1A4cEczVlQySUh3WGZY?=
 =?utf-8?B?WnNmQUZicHYzbVY1SGtNT0J4OHo2Tmo0OVVreWlQU1VyYmZLVnBIMmQ0MzhO?=
 =?utf-8?B?N2lleFlLaHVmWlNuRE1TOGtGZktnTDdTblN6UlpEQTFUM2t5aVMzNSt2Z0VC?=
 =?utf-8?B?eS85ZDJtWFhxckxtQVY4b29nOVV0cFQ0T0l2aUFNYVNlSkN3aGExRnRNMEt1?=
 =?utf-8?B?VVRLZU1sdXZKWWF6dlFsck5rNGhiQkRUT0Ztb1FHelk0RzhrVkhPZXE2Q3hs?=
 =?utf-8?B?dzNWUXRCOVpqREk4WEFLRERVRlpBSW5YZ251WUZlK0lsNDc4QlJ6d1U1UEJ6?=
 =?utf-8?B?VGYxMjdaMndhSzFCTmE5L1VlRUEwL25EMkVYOEo5WnkrcTY4WGdxNXhLU2pk?=
 =?utf-8?B?cWxmdGpSR3lLVlhQVlZwZjlqajVOTWVabzB2WnNacEFEZTkrRnpqbHlZejFr?=
 =?utf-8?Q?7qpCChKmN+Gddvluf9Wo2oyXEPuoDeLDB2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BB255C89FEE404498FAB467D7A99103@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc51e3a8-b593-4db2-11d0-08d896378c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 20:27:38.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3CzNIQnYxznI66rSxAIeiX/GftRoVCnOUmVJH1CY1lFM6CvxFDlQBySU1gMKdOTQNY7xRajyGSYnJgkX9nP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3840
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDE1OjE4IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMC0xMi0wMSBhdCAxNDozNSAtMDUwMCwgSi4gQnJ1Y2UgRmllbGRzIHdy
b3RlOg0KPiA+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjE0OjI3UE0gLTA1MDAsIHRyb25k
bXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiANCj4gPiA+IEZvciB0aGUgY2FzZSBv
ZiBORlN2NCwgc3BlY2lmeSB0byB0aGUgY2xpZW50IHRoYXQgdGhlIHRoZQ0KPiA+ID4gcHJlL3Bv
c3QtDQo+ID4gPiBvcA0KPiA+ID4gYXR0cmlidXRlcyB3ZXJlIG5vdCByZWNvcmRlZCBhdG9taWNh
bGx5IHdpdGggdGhlIG1haW4gb3BlcmF0aW9uLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+IMKgZnMvbmZzL2V4cG9ydC5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0N
Cj4gPiA+IMKgZnMvbmZzZC9uZnNmaC5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKysrDQo+ID4g
PiDCoGZzL25mc2QvbmZzZmguaMKgwqDCoMKgwqDCoMKgwqDCoCB8IDUgKysrKysNCj4gPiA+IMKg
ZnMvbmZzZC94ZHI0LmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gPiA+IMKgaW5jbHVk
ZS9saW51eC9leHBvcnRmcy5oIHwgMyArKysNCj4gPiA+IMKgNSBmaWxlcyBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZnMvbmZzL2V4cG9ydC5jIGIvZnMvbmZzL2V4cG9ydC5jDQo+ID4gPiBpbmRleCA0OGI4NzljZmU2
ZTMuLjc0MTJiYjE2NGZhNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9leHBvcnQuYw0KPiA+
ID4gKysrIGIvZnMvbmZzL2V4cG9ydC5jDQo+ID4gPiBAQCAtMTcyLDUgKzE3Miw2IEBAIGNvbnN0
IHN0cnVjdCBleHBvcnRfb3BlcmF0aW9ucyBuZnNfZXhwb3J0X29wcw0KPiA+ID4gPQ0KPiA+ID4g
ew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC5maF90b19kZW50cnkgPSBuZnNfZmhfdG9fZGVudHJ5
LA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC5nZXRfcGFyZW50ID0gbmZzX2dldF9wYXJlbnQsDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgLmZsYWdzID0gRVhQT1JUX09QX05PV0NDfEVYUE9SVF9PUF9O
T1NVQlRSRUVDSEt8DQo+ID4gPiAtDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBFWFBPUlRfT1BfQ0xPU0VfQkVGT1JFX1VOTElOS3xFWFBPUlRfT1BfUkVNT1RFX0ZTLA0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEVYUE9SVF9PUF9DTE9TRV9CRUZPUkVf
VU5MSU5LfEVYUE9SVF9PUF9SRU1PVEVfRlMNCj4gPiA+IHwNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBFWFBPUlRfT1BfTk9BVE9NSUNfQVRUUiwNCj4gPiANCj4gPiBTbyBJ
IHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgd2h5IHdlIG5lZWQgYSBuZXcgZmxhZyBmb3IgdGhpcy4N
Cj4gPiANCj4gPiBCZWZvcmUgeW91IHNhaWQgaXQgd2FzIGJlY2F1c2UgYSBmaWxlc3lzdGVtIG1p
Z2h0IHdhbnQgdG8gdHVybiBvZmYNCj4gPiB0aGUNCj4gPiB2NCBhdG9taWMgZmxhZyBidXQgc3Rp
bGwgcmV0dXJuIHYzIHBvc3Qtd2NjIGF0dHJpYnV0ZXMuDQo+ID4gDQo+ID4gQnV0IGl0IHNlZW1z
IHRoYXQgYSkgd2UgaGF2ZSBubyBleGFtcGxlIG9mIGEgZmlsZXN5c3RlbSB0aGF0IHdhbnRzDQo+
ID4gdG8NCj4gPiBkbw0KPiA+IHRoYXQsIGIpIGl0IHdvdWxkIHZpb2xhdGUgdGhlIHByb3RvY29s
IGFueXdheS4NCj4gPiANCj4gPiBJcyB0aGF0IHJpZ2h0Pw0KPiA+IA0KPiA+IElmIHNvLCB0aGVu
IGxldCdzIGp1c3Qgc3RpY2sgdG8gb25lIGZsYWcgZm9yIGJvdGguDQo+IA0KPiBUaGUgImF0b21p
YyIgZmxhZyBpbiBORlN2NCBpcyB2ZXJ5IHNwZWNpZmljYWxseSB0aWVkIHRvIGEgc2luZ2xlDQo+
IGF0dHJpYnV0ZSAodGhlIGNoYW5nZSBhdHRyaWJ1dGUpIGFuZCBob3cgaXQgaXMgY29sbGVjdGVk
IGluIGEgdmVyeQ0KPiBsaW1pdGVkIHNldCBvZiBvcGVyYXRpb25zLiBUaGUgdHJ1dGggaXMgdGhh
dCB3ZSBwcm9iYWJseSBfY2FuXw0KPiBldmVudHVhbGx5IHNldCBpdCB3aGVuIHJlLWV4cG9ydGlu
ZyBORlN2NCBhcyBORlN2NCwgYXNzdW1pbmcgdGhhdCB0aGUNCj4gc2VydmVyIGFjdHVhbGx5IHN1
cHBsaWVzIHVzIHdpdGggYW4gYXRvbWljIHVwZGF0ZS4NCj4gDQo+IFRoZSBzYW1lIGlzIG5vdCB0
cnVlIG9mIFdDQy4gV2UgbWlnaHQgYmUgYWJsZSB0byBzdXBwbHkga25mc2Qgd2l0aA0KPiBhdG9t
aWMgdXBkYXRlcyBmb3Igc29tZSBvcGVyYXRpb25zLCBidXQgY2VydGFpbmx5IG5vdCBmb3Igc29t
ZXRoaW5nDQo+IGxpa2UgUkVBRCBvciBXUklURS4NCj4gDQo+IFNvIEkgZG8gdGhpbmsgdGhpcyBu
ZWVkcyB0byBiZSBzZXBhcmF0ZSBmbGFncy4gSXQgaXMgZGVmaW5pdGVseQ0KPiBkZXNjcmliaW5n
IGNvbXBsZXRlbHkgZGlmZmVyZW50IGZ1bmN0aW9uYWxpdHkuDQo+IA0KDQpBY3R1YWxseS4gVGhl
IGFib3ZlIGlzIGEgZ29vZCByZWFzb24gdG8ganVzdCBkcm9wIHRoZQ0KRVhQT1JUX09QX05PQVRP
TUlDX0FUVFIgYWx0b2dldGhlci4NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZXJlIGlzIG5v
IG5lZWQgZm9yIGl0IGF0IGFsbCwgc2luY2UgYm90aCB0aGUNCk5GU3YzIGFuZCBORlN2NCBjbGll
bnQgY2FuIHN1cHBseSBhdG9taWMgc3RydWN0IGNoYW5nZV9pbmZvNCBpbiB0aGUNCmNhc2VzIHdo
ZXJlIGl0IGlzIHJlbGV2YW50ICh0aG9zZSBjYXNlcyBiZWluZyByZWNvcmRpbmcgdGhlIGNoYW5n
ZXMgdG8NCnRoZSBwYXJlbnQgZGlyZWN0b3J5L2llcyB3aGVuIGRvaW5nIENSRUFURSwgT1BFTihP
X0NSRUFUKSwgTElOSywgUkVNT1ZFDQphbmQgUkVOQU1FKS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
