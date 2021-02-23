Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7359E322CE3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Feb 2021 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBWOxB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 09:53:01 -0500
Received: from mail-co1nam11on2128.outbound.protection.outlook.com ([40.107.220.128]:60384
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233166AbhBWOwk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Feb 2021 09:52:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB3ZN6WW8Cf32HUEbXGgIMu8VEPUEH+bVrdKpu5hBv4SU3yv0lH9t1ynA1uplzK0Dp1J6s1NZxDPMUetDZ8n9TrL9zf/HxX32eSUF50xhRHeENpW4zNd5FfcYfw9GKCTL8XbYckvSDOZJggHv//8zRVpcPyELctBeJZ0uwkGH7RRt+IkC2T1AMU86SER7FBgWMAWBVK2rvU/SmmQemBRnAYdYBuJKCzUz6gqRS8JXraUToTCahrZtwdVq2dm5c8BT8X6EtZ1b3B5uaYi18vxCoS49L5n8mvYUO6xga6VyDEaFNB2Hytj2LWHEXF43vd+ft15HDHVSsSXD8ZyAOmxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPClPQ0CpA12b7QUvdYzfZp9+dkU1O3CrmMwuP7Zj3g=;
 b=N1V/+h4Ib60lupN60SKJxTZiTYqTx54rWBzcrhwr17H0H070UHLWX7KM32Z4Fd5nX4DEG3kUTYIjH7sgjIiguAhb1ziTrp1faOzfJEvE+ltYbCh7U6T8nThQ23faptBGeIBouL3lEBJwHA3K8oaAEO7MsaS4tbmv3iIVGefM+UWPI7i7SwVBpFgqjaYdu0Zrn9aikMwXGP1D5z5c2yVKvNMnER0oNANohWnSr92usTvmzNkcGQjL/oLDBVLAtNrS4pCC7HBBdbbD+TaUgnzUfDlE39JcJ3+g5QVd1aqX2KxPLhbd8z9jyYpqixTuP5tx71R1ySL2DLCocvFIFLXb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPClPQ0CpA12b7QUvdYzfZp9+dkU1O3CrmMwuP7Zj3g=;
 b=J1n7BD4ac4ZuIk8eMmYZq1azVD7sy8IqeMNpN3JF22Icm3AoFcFtMRZS4WkYJeZLvfDPgPFHc6sO+Aq69J2tS0ZZLsQwu4g82KPgGQV5l6/01e4XPWfdU3uHoGzypc3b8RAe/2Qq4N/a7/zWP8p018YcaV68eFQjOE2dSHsuY/E=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4441.namprd13.prod.outlook.com (2603:10b6:610:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8; Tue, 23 Feb
 2021 14:51:46 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3890.018; Tue, 23 Feb 2021
 14:51:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "timo@rothenpieler.org" <timo@rothenpieler.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
Thread-Topic: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
Thread-Index: AQHXCe8dex9I+OTxNEGYGDFZCJLwZapl0u8A
Date:   Tue, 23 Feb 2021 14:51:46 +0000
Message-ID: <6626a1877551f25f8e57addc720acba5af674d1f.camel@hammerspace.com>
References: <20210223141901.1652-1-timo@rothenpieler.org>
In-Reply-To: <20210223141901.1652-1-timo@rothenpieler.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faffc56f-f0b9-4f5f-986c-08d8d80a8b1b
x-ms-traffictypediagnostic: CH2PR13MB4441:
x-microsoft-antispam-prvs: <CH2PR13MB4441EF4C937DF97B5375C502B8809@CH2PR13MB4441.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OWI6/i49wauh7w32Raz+Ko4/7ZOle+EEoYYqHSLNVQDIN0aUnYgmb2xECaenbq3vwITrmZnEygqEf0elqM3nztez2Nm1lum5mVoICc2yuOgxxAKEItwj2+ETbKIMgbGQwGzBiiLXC3rGvRdlJsfluvrQQs2O2YsxUASg3ikmkSrvVxYptcRtxIARgR33EtGVM5o+DfhXrXT9y8Ljh6Fmp2Lhk+M1yAoevn+Aq3RK7aeYAz/Zk7IohzpcxAps759UNKFe2LhAo7nhpnCcNsOP3S9oDUpP8PZof3oW8bstPvinGcJ3asvXn4LIViSmmzSYCwq8vRzXGnRrIlRVyp0q3tWrTyoydrs1z/+72qRRslpxEVGZB3ND6ORZJyp3VF8mFVTQb7YQe+dDM2Xca67DF/fDwoAJHvvLAHUxG9uCb/w5Rw4pec1WZXast3vzxNPY/K8YlD+9NsM+5sU3BUq5y5+SxjnDuHLL/DpuEc2hzwFSa+P9cFzaGLi9RhoGKQYTpQ2Fm1KSlnVNJGUhcy51Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(346002)(396003)(136003)(366004)(8676002)(6512007)(478600001)(6506007)(71200400001)(8936002)(36756003)(2906002)(316002)(5660300002)(66556008)(66946007)(64756008)(110136005)(6486002)(76116006)(186003)(2616005)(26005)(86362001)(66446008)(66476007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OEt2cDJDc1RnMTh0dGhhbERrR3dtMGd5RnM2aFVoTmNsOVdaMFZUZjhMeHQr?=
 =?utf-8?B?aVNBbDVsZVJzQnNheFdjN3J6bUs5QzRub3hOdEh1dWY4MEhEOXdySUVRUU02?=
 =?utf-8?B?NDNrRXp6N2JtOHhTNUlidXR2N3QrcllxM1hwNjl2aFBRdlM0cStNclpGTDgz?=
 =?utf-8?B?ZEJOVXMxdUg1SWxhMGpENmtzR2RFMmtzZEFkM2tPRVRPQWZsUkRzd0VscHk2?=
 =?utf-8?B?MFN2eGdwMkp2NVNTTVA2SHRTRzl0QmRJV09QN05MMjJMZnlUWkh1Nk5nWGZD?=
 =?utf-8?B?WGJtZnRZekZnS2hhK0FSUlc2dW5YZVl1dmt5dE5zV0hCdTB2UVE5YVNJWm5L?=
 =?utf-8?B?YW05S25FcVpHaDFRNENqUXVzRmxOZnVnaVRkNDYzVnNaNUphS1hmZHlFTlpq?=
 =?utf-8?B?THpzNjVKN3NqMDN5MEhpcEpHUVNDcE5ZckdaUVlyZjhUbVcyNG9ScHNnL2No?=
 =?utf-8?B?V3VNak5sZFlqc2JKNnM4dHUyam5aL1pUbmNLVERLeE00MkkzMExwaXF6SHY2?=
 =?utf-8?B?QWdOVFR3eC8rNmk5dDdpQnVTdWxQQzFSUFdJaHF6OU9UMjdlMnZNWWtsY1VV?=
 =?utf-8?B?TytPUmN6TjUyejNBbjh5M2hEYTg4dzZVM1c3NUVwTy9uZjBFOTMvT0J3dXd1?=
 =?utf-8?B?TUVTTXlBSjlRWlk4MmFMOXdoVWYyQ1loWkp0TW9vSDEyRXVNSmJsZXNudnBl?=
 =?utf-8?B?Nit4UEdUamgvNm1NVlFHQkZxaDhIdEhwUkd4L1FFaWRMNmhLUnNRdzBEWGRy?=
 =?utf-8?B?WXBRUnRjQW05Z0wzalROS2dxek50Nk5wNmdZdU4rclRmcjVqK29kS0VZK2J6?=
 =?utf-8?B?azR4OVcyc2hSNmc2WUw1cXRFZFVpdXlHRHdTb3A2L3ZYSW8vOXBFL3E4Y0Ns?=
 =?utf-8?B?SWNFQ0pCT3NQakswNmhwRUJWWVVyL2ZMVlRKcmc5WnFCTWgvdC9zNUxaeTFD?=
 =?utf-8?B?UW9UWnByR1JBeVhSZzNDZUNtb2daSnJVdlRiZHcxTUFJZlY4cjA4QmZrMTJL?=
 =?utf-8?B?cnR4eGc2VU0yVmduVFRQdUd1Q1R6bk1FQzVORk9CVi9zWDdCNjRXaVdNVitB?=
 =?utf-8?B?TVNGdFlWYkgvdVc0NkdpTXZlQ245UXZ3Zm4xZ3FZandDTmhUQnluaXgrN2N5?=
 =?utf-8?B?eUVBa082cDJYMEhxNUNoWHAza3F4TlVuQU9wc0QvNUNXelZQNVN0ODNIRFND?=
 =?utf-8?B?eDNYV1l2a2FoUmtPQU80MzkvQUZ0enYwaE5QVkIzOThnME9TOXNwNHlMRWla?=
 =?utf-8?B?bjJOTXkrRmlMTWlHbVk3cHZXQzFxNnIvMGhKekR3cjJaOUtXSXFUUEx0S0ho?=
 =?utf-8?B?ZlQ2cFQ0a1BxaXE1aEQzZVJITEYwbmM3aVlMNHBwWDBtbnB4V3dXaThGRjd5?=
 =?utf-8?B?TkxNK1ZBVTBLM2JRK3BacHpmV3VrN1l2eXFVZTFRRURFTTZrZy9MUkh6d2Ja?=
 =?utf-8?B?RUFkR215SXRBeHpNOEJuVThnSHlBaHRmeW9oOEZmV1dTOERDQnBENVk1TG1i?=
 =?utf-8?B?S0FFL1RJVmxPcHV3L1JqQi9OZlR5cEVWUTEzZzZTY2l4SXF6a3cxa1l5Y0l3?=
 =?utf-8?B?NGxuSkt0YXFXKzI5b3Qxa2tnTCszM3VYU3F5dmRQVU52SkVwL3NJaFNwYnBk?=
 =?utf-8?B?bkZub3VmRWZlWHJCamlDaWNOM0xHREVLWWpSTWtWTXA2OWk0ZlNtdEorSDIy?=
 =?utf-8?B?b3lmOVFFSStSUDV1Y1ZhVThVYTFPVWZ5M2VGUzhJdTh1YzBlb0Nqc1FHU3Er?=
 =?utf-8?Q?E3Yjuha0BbGHe45G1CARKhS/PUye+ep6r7tqlst?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <852311F7CF28AB42B46C2CE2642FC833@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faffc56f-f0b9-4f5f-986c-08d8d80a8b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 14:51:46.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Et7/DLzeZiAbKx+7AI844LNhQaOPth9endQPC0Qwp6YeNBFEd4onyJDI/CFBcnGmzb220pNiQKRTYrR2D/xMCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4441
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTIzIGF0IDE1OjE5ICswMTAwLCBUaW1vIFJvdGhlbnBpZWxlciB3cm90
ZToNCj4gVGhpcyBmb2xsb3dzIHdoYXQgd2FzIGRvbmUgaW4NCj4gOGMyZmFiYzY1NDJkOWQwZjhi
MTZiZDEwNDVjMmVkYTU5YmRjZGUxMy4NCj4gV2l0aCB0aGUgZGVmYXVsdCBiZWluZyBtLCBpdCdz
IGltcG9zc2libGUgdG8gYnVpbGQgdGhlIG1vZHVsZSBpbnRvDQo+IHRoZQ0KPiBrZXJuZWwuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaW1vIFJvdGhlbnBpZWxlciA8dGltb0Byb3RoZW5waWVsZXIu
b3JnPg0KPiAtLS0NCj4gwqBmcy9uZnMvS2NvbmZpZyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvS2NvbmZpZyBiL2ZzL25mcy9LY29uZmlnDQo+IGluZGV4IGUyYTQ4OGQ0MDNhNi4uMTRhNzIy
MjRiNjU3IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvS2NvbmZpZw0KPiArKysgYi9mcy9uZnMvS2Nv
bmZpZw0KPiBAQCAtMTI3LDcgKzEyNyw3IEBAIGNvbmZpZyBQTkZTX0JMT0NLDQo+IMKgY29uZmln
IFBORlNfRkxFWEZJTEVfTEFZT1VUDQo+IMKgwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZQ0KPiDCoMKg
wqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBORlNfVjRfMSAmJiBORlNfVjMNCj4gLcKgwqDCoMKgwqDC
oMKgZGVmYXVsdCBtDQo+ICvCoMKgwqDCoMKgwqDCoGRlZmF1bHQgTkZTX1Y0DQo+IMKgDQoNCkxl
dCdzIGp1c3QgbWFrZSB0aGF0DQoNCiAgICBkZWZhdWx0IHkNCg0KLi4uYW5kIGxldCB0aGUgZGVw
ZW5kZW5jaWVzIHdvcmsgb3V0IHdoZXRoZXIgb3Igbm90IHRoaXMgbmVlZHMgdG8gYmUgYQ0KJ3kn
LCAnbScgb3IgJ04nLiBUeWluZyBpdCB0byBORlNfVjQganVzdCBtYWtlcyB0aGUgS2NvbmZpZyBo
YXJkZXIgdG8NCnJlYWQsIHdpdGggdGhlIHJlc3VsdCBiZWluZyB0aGUgc2FtZSBhbnl3YXkuDQoN
Cj4gwqBjb25maWcgTkZTX1Y0XzFfSU1QTEVNRU5UQVRJT05fSURfRE9NQUlODQo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJpbmcgIk5GU3Y0LjEgSW1wbGVtZW50YXRpb24gSUQgRG9tYWluIg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
