Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCB350791
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhCaTmz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:42:55 -0400
Received: from mail-bn8nam12on2107.outbound.protection.outlook.com ([40.107.237.107]:46123
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236314AbhCaTmm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLJYKvo6p0Mypir3+Gz+T4g8pVujCrvdTZC1saaXQuhD4tqZ7AaPDIsDZqOD59/ibgsBThyePIQgke9Pwke8ytnFbmLQqqnV5nGyrZr/RS1Lcy7xys6bSZDou14u9Yjiupo0GZ8t/Vig2qxtIEjJV0OvaX7PWbB/k5h4CZadBXbK5sz0F5PjB1ga99KVOCSGmsq+clVy8HEQurVKvb1AC+piPbQfLcpmZyXxr9/Kxed23kXj4f6+1VYVLGveNXoBItFOZCJ6MCPG6Sps+feBgvl9tNuup/AyyhsMfi/t8g+ItTSMDDoilEZGaZQMwm0ZpPVZE3gYM47e9Jah7Joy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRGF8TdH0AWkPxg4P4vtEtVUwXXj+cWqFCBZy7OP67o=;
 b=DpOoFAW6eSbDejaTMy2/0X/uJiE++qrE5KEYMCCEBSVhfwlX+c9GlYBk4Vl6MmYuSPekXv+TlcajhBXVPPEL1nyHxgSsirdWdXx4ab3Ttl+cuX+PoFB+SgrkkREsk2kxh0iDSMyeNZEvFSGnz3AWwMWwASMEhi5HAWwWGmsgEcnm2C3qjbYCql5XkmbhR89f1pz9nfTlZ+wgKSOGoulS58KqoFCpbep5KnioaImAaaLLL3i57i5LAMUopKBaJ/wQkzyB1OA1omo5WwoBpBrrrcYUvNXt3/okCk2W8yOp5C5mxdVTr1m+2oGZoe1HClJWfcrWjpaT30qfUo59/hkLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRGF8TdH0AWkPxg4P4vtEtVUwXXj+cWqFCBZy7OP67o=;
 b=awXxnrfr5mAFlZPMcz77f3MGVYSu1klX7aKSi7YHO6YUrHT799QFJtymJvkpf6d9pvsjNIWyh9ctxNH8g2DxNaat/i9xhe7lZK063UzQ4D3CWTXP8CU/ODxQxJ0LOTJXKDBXL40e5idkLSX1VGFOKpdTnzBA5Wl3IcHiGKttdjo=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3735.namprd13.prod.outlook.com (2603:10b6:610:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14; Wed, 31 Mar
 2021 19:42:41 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74%7]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 19:42:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
Thread-Topic: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
Thread-Index: AQHXJmRPskF9kJm73U6OPU3MAvy7UaqefzwA
Date:   Wed, 31 Mar 2021 19:42:41 +0000
Message-ID: <0ca40f087491acec8f26816b43b6d64bb624c35e.camel@hammerspace.com>
References: <20210331193025.25724-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210331193025.25724-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee5880b4-d724-4264-35d0-08d8f47d25ae
x-ms-traffictypediagnostic: CH2PR13MB3735:
x-microsoft-antispam-prvs: <CH2PR13MB3735581A67DE6EE4F8D12364B87C9@CH2PR13MB3735.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bq7hpCo/ylnXwzQP5qBzmh4hjTFGrGQATTjIILuEeu5n0JHT7szYcOjIpPsOni5wYsP4nbMYgEVxLiJQRJKbWCzN1Fh9KqHI/taRnF+tT3fSHts+GyPdXXNX2AC0RAmg7UT/8Q10YivgpYyQyL4pfxXd7kVWUlXkoF4iWWd8c4kyyukAw/A7k3ADCpxcKpLFBUX6qknA/cb8djnnJHPX3/OzeJXokxzSooofwMM+FPGhgdWCOG11MCw96U5eIjPZMLF3roFbuy91y/vVzaBVxMAL/f985CNf4HVY16RDLG1DQOjAhB8PsfnDD9/H8MWOrA6PWnSFohA+xaCnyOS3ygakSEEshRyye1TEgqBSLF+oLYl8Cq936ZXM9ljpdS3QKZoOYRZu78EVC4FOzQn6IeSHpGBw9yxy46gOHndI8VsKNUCWrCX+cFveBD4gU1qpVH6Pq4tvZbfGx3MPRCoIwp9PjtvynuBCjuHrk/1I5fW2Aj1WFi99EuMnCrPkcLDRsr04yGZ2SIym2Gtn6VKRklX0csihH//AHcaRetsK5HZdUqoT+bqs41yRcUI2MRfRBph/f3+tKNVpkJKxCDxRFgWuZYGiTWqsNolzqnTIp3unIkLONueIuCGsbptzfH2yYsJQmsK2gC1MnUSrn20T5QIIkbGDee5yYNi7jOl5CLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39840400004)(136003)(346002)(376002)(186003)(38100700001)(6512007)(8936002)(2616005)(2906002)(110136005)(71200400001)(478600001)(6506007)(4326008)(5660300002)(6486002)(66556008)(64756008)(66446008)(66476007)(66946007)(316002)(36756003)(86362001)(26005)(8676002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WG9tY1YrZHkrd0FESWF5SVBmYnRFK2s5ZmRwQ0tXWEpFMm5RcUVGWlhKZnow?=
 =?utf-8?B?L2ZWMVNSTzBkdTB1U2NyZ0xuQU55Mkh4aEN0djFtTy9KdWMwdzFpNFJGc2J6?=
 =?utf-8?B?aDQzUVovdmh2ck5HQWJpUlhQSk1nSlN2V0dsMVRIenEwRXJyMFh0Sm5zQ2J6?=
 =?utf-8?B?ME1NRGpKN29pYWc3NndzVGtmQ2pXeHZyN3ZjaWRQZ2pHc2ZSSTBuQ1J6aWJl?=
 =?utf-8?B?SWdkbEVXeEY4ZnlhTGJ2emVjVW9xUkVSQytVQjcyQ1hTYkJUdVJEL21kOU96?=
 =?utf-8?B?WGY2WTVCRUlQc0piUnVhVGp1czVSY0dzMlJ0TktacUZIVGQwTTl5aTRJTURC?=
 =?utf-8?B?eW5teDMzZHJCWGVWQ2srWlhwZFpWbGliVE5aWjd5OFFTcEFTTGRkWEJtNDcz?=
 =?utf-8?B?UDFVbGtCUXJiclpZdVVuMHJSNXVweStjalpVVGJxdERIaC9IWUdTcmVvUFNy?=
 =?utf-8?B?RGo5a2JlYnB6dm5sSVhVUGsvREZzUHdHTjlpNmsxUlJuVS9FNEJ5OEZlOXRL?=
 =?utf-8?B?ZVRxeDlpV3BiVlpCbnJkSUdqU3R1UjNJeDFXU1Q2OHdWVzBYU1RhZzlrMEVH?=
 =?utf-8?B?dG5uVEJxVDBnSHVkemxia2hpbjJlUjNQcU9EYWw3TFlrdE9OSHQ0d0NqbXE2?=
 =?utf-8?B?M0hFZnNGcnVrZWFKSWI2cUJTZVBJTzd3TlNrVjBXSmZEZ001dUhlMUNVY3hl?=
 =?utf-8?B?Y3B5TC9OV3VqWHQyNHI3UGJiUEFQeUU5ZkhsNUJ5QUE2aG1sWml1eXNZVlJy?=
 =?utf-8?B?OVk4T2FqMkowVmtSM0VsT3Q4Z3RaY1hybWVqcDkybDNGNkdTNXRXMnlMNWhF?=
 =?utf-8?B?cHFZNHpId245YStEczcwcTF0bDZkb2Z3ZjNsZ3J6dXE4V2ltY3hSaG8wbGUw?=
 =?utf-8?B?Mm9DMHpibE51d3REc1NqZGFmOURpQTE1VlBPYURmL2Q3WmNlYjJQNmQ4S0RU?=
 =?utf-8?B?VG0rcnhneDlyQXNCM2o3NjBwQ0xDTlhvaDhOVW5CTkNNRlpwTkRZSWk2Qzh0?=
 =?utf-8?B?bm5Zc1RDdmFOVkhKb2JSTTdxVml6MFhQTlU0d3hrZjBiV1dtQkFWNDduL1d6?=
 =?utf-8?B?MTRCM2k0UmFlVnhPUHQxcmp3V0NFa2ZnTU8vZGxpL1N2UDJrVU5sdlNrM09y?=
 =?utf-8?B?eldaVXJLTCt2MVFrQURtU0FnbHZiRXVtZjNsUjVFUUVvTVpXQkVJU1Z4aWxv?=
 =?utf-8?B?dHdYRTFNSHZLYzRlWHhzMTdFK1VQblkvclB3Ni9TOHBLckFvK01oaDRNbHNw?=
 =?utf-8?B?MkNlWHkxYktFbjJwRWUrb1l2ZVBqVHlmUzdMeW9TVVlDZXhDODZMTFoxNzdo?=
 =?utf-8?B?MzBSVEd2VUNTZlI5YTVEVVEwRkVtbHdONVRVQ1VEYnAwWXVZYng2ZzFJN1R0?=
 =?utf-8?B?VXZ2WWFlZ3RVd1BXbWNNRXlkSVdsdURpU2YvVEdObnF3ZldUbzZIN2xwNjlQ?=
 =?utf-8?B?QS91S0FjSWEySVF3VmpsdDVOSW55MEYyNHRsTEZtaHg4Vm9WaTZHQmhUU3gx?=
 =?utf-8?B?cExVM3psTjNaVU5sdjRpQWlSM3k5Mnd0STFzL2JlVVh2WHVmdGlxWVJQb3Mx?=
 =?utf-8?B?MkxhWGdjRWNic3FTdnJGV3E1eS9FY2piNzNwb2RhUW11MllWcWV6ZTdsaTR2?=
 =?utf-8?B?dVpyNnpmZE1xeG5Fd0JkTGg3ZEphZXorNU5zL1lGVGl2SCsyVWxqZnV6a2Vq?=
 =?utf-8?B?UEduZG5WSXRCUGZOZWZNOTllTktpVU5tUUZ1dnpQNmZMMnNMditOYmFUYXJ5?=
 =?utf-8?Q?jge05Su+kiY9NGxgFmt2t+aqMajhgkxWNPQ7Nnm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0780A1BED9827A469FC29ED7785E0907@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5880b4-d724-4264-35d0-08d8f47d25ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 19:42:41.1479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VO24ZVnJcGVk5LUMRPjpOHaAB6NndZaGJTp2a9yqEn8WY7hsagCXUj2tPG4KpptYQYHZ8oWpx/cjcFhLFDp9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3735
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTMxIGF0IDE1OjMwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBD
dXJyZW50bHkgdGhlIGNsaWVudCBpZ25vcmVzIHRoZSB2YWx1ZSBvZiB0aGUgc3JfZW9mIG9mIHRo
ZSBTRUVLDQo+IG9wZXJhdGlvbi4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCBpZiB0aGUgc2VydmVy
IGRpZG4ndCBmaW5kIHRoZQ0KPiByZXF1ZXN0ZWQgZXh0ZW50IGFuZCByZWFjaGVkIHRoZSBlbmQg
b2YgdGhlIGZpbGUsIHRoZSBzZXJ2ZXINCj4gd291bGQgcmV0dXJuIHNyX2VvZj10cnVlLiBJbiBj
YXNlIHRoZSByZXF1ZXN0IGZvciBEQVRBIGFuZCBubw0KPiBkYXRhIHdhcyBmb3VuZCAoaWUgaW4g
dGhlIG1pZGRsZSBvZiB0aGUgaG9sZSksIHRoZW4gdGhlIGxzZWVrDQo+IGV4cGVjdHMgdGhhdCBF
TlhJTyB3b3VsZCBiZSByZXR1cm5lZC4NCj4gDQo+IEZpeGVzOiAxYzZkY2JlNWNlZmY4ICgiTkZT
OiBJbXBsZW1lbnQgU0VFSyIpDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxr
b2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCA1ICsrKyst
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0MnByb2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0K
PiBpbmRleCAwOTQwMjRiMGFjYTEuLmQzNTllNzEyYzExZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZz
L25mczQycHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiBAQCAtNjU5LDcgKzY1
OSwxMCBAQCBzdGF0aWMgbG9mZl90IF9uZnM0Ml9wcm9jX2xsc2VlayhzdHJ1Y3QgZmlsZQ0KPiAq
ZmlsZXAsDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc3RhdHVzKQ0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBzdGF0dXM7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoHJl
dHVybiB2ZnNfc2V0cG9zKGZpbGVwLCByZXMuc3Jfb2Zmc2V0LCBpbm9kZS0+aV9zYi0NCj4gPnNf
bWF4Ynl0ZXMpOw0KPiArwqDCoMKgwqDCoMKgwqBpZiAod2hlbmNlID09IFNFRUtfREFUQSAmJiBy
ZXMuc3JfZW9mKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1ORlM0
RVJSX05YSU87DQo+ICvCoMKgwqDCoMKgwqDCoGVsc2UNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiB2ZnNfc2V0cG9zKGZpbGVwLCByZXMuc3Jfb2Zmc2V0LCBpbm9kZS0+
aV9zYi0NCj4gPnNfbWF4Ynl0ZXMpOw0KPiDCoH0NCj4gwqANCj4gwqBsb2ZmX3QgbmZzNDJfcHJv
Y19sbHNlZWsoc3RydWN0IGZpbGUgKmZpbGVwLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQNCj4gd2hlbmNl
KQ0KDQpEb24ndCB3ZSBhbHNvIG5lZWQgdG8gZGVhbCB3aXRoIFNFRUtfSE9MRSB3aXRoIHRoZSBv
ZmZzZXQgYmVpbmcgZ3JlYXRlcg0KdGhhbiB0aGUgZW5kLW9mLWZpbGUgaW4gdGhlIHNhbWUgd2F5
Pw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
