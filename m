Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1708D2C904D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgK3Vwr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:52:47 -0500
Received: from mail-dm6nam10on2097.outbound.protection.outlook.com ([40.107.93.97]:56928
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgK3Vwq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:52:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg8XZqULnt1UjOWzFFamRFREaJUnAbAJPteixOBce6frMo6EXhLS4aGZ9jtmbURt+xboG6tDsq1gOfhh3RA6oJu4c87iPHbfej78bW4+2PzPvxa2DuDw7fwH9GXlCL+T6eW3UXOc7PUTTUcBzv+I5i3H9S8YtuO9U78rbom2gSlUifBCp2una0guesZEEpdgOjx6V3TgXUnXDF5Tz9/0AkcLFR5RNhbl8XyT+L9V9yS3ihLt2dY1yT4qg53cC3EYk3Kowm6QsYEZ0XmuMqsI1HigkCk1F4WhUBNKqsDcQGUXTGDc4uwhbmeVv2QV7OD3xjT5bs/+RkxV6qW2IBzxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq/KVDSUXpOA3YXKhqGdvRMyl3BFk/ifRLD/bNdgrWU=;
 b=d30qqlx8DWcxi2zlc4lWEs6Ay5NyZHvUtM0zI0HwPuQi+J76RnlDGmVExrtFJwgicJIntZzKXRLiXLr03/PuYwzQmjn7c9z9vdgzcRdpGBdIalBYIwp+780mLO4YlO6HczrC8SaKhqHhLVAtrioc3l3d4as9gR0YjXZtb985mTE51GWJ0VErKp4Cht2DVrdDIlKAluq5zhUgRxLnB2jITTuuMz+MBnNHe1XyPqvj99ga0xhQMUQQXVXu7ME0DGf5QUINok6L5euDUWig4eT2ZbGBKxu4C3hdSmQBWpT6Ak5eGNLMOTdts1RTGW9D/xQwFzU1kkaE3ciMPhAzvc7Jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq/KVDSUXpOA3YXKhqGdvRMyl3BFk/ifRLD/bNdgrWU=;
 b=Gjo8bVYX7tDKbtnyLXEHKuBnXpv5Q28ACg7xAr+qyrrbrnKIyv+nKP3Pburvw9PInQfm3n5XlfPuOkSE6GjEpgyHEW7y5pGe+6gbyfdmXRjyKPP9VbgsV2HgaL+2l9AcxB+O+y01TFgE7GWcN3OtdG6/XCrRT5mFF+jDmLp1FS0=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4007.namprd13.prod.outlook.com (2603:10b6:208:267::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Mon, 30 Nov
 2020 21:51:52 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Mon, 30 Nov 2020
 21:51:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/6] Patches to support NFS re-exporting
Thread-Topic: [PATCH 0/6] Patches to support NFS re-exporting
Thread-Index: AQHWx197c7iCJUkEwUyEWEMwZd1dGqnhM/0AgAADSIA=
Date:   Mon, 30 Nov 2020 21:51:52 +0000
Message-ID: <43a8e7a29e0fc4b7f225efeb793f121a676f5562.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <C98E8BA2-EB93-40EC-80B3-4D1C8E16D9CA@oracle.com>
In-Reply-To: <C98E8BA2-EB93-40EC-80B3-4D1C8E16D9CA@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c36ef37e-79d2-4628-8004-08d8957a25db
x-ms-traffictypediagnostic: MN2PR13MB4007:
x-microsoft-antispam-prvs: <MN2PR13MB4007787FEC9CA9E3E0FA624DB8F50@MN2PR13MB4007.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zW5qH302HDkWGB0IgpL88xjcXfCmJncrry+exZ8KCT8ZdXSqREf7oARy9qTod2S2whK49cU11Bnf3k2/rDubF8ltU4BvEwC+XIJw8FyPBSZB1Ml8vqZC2AdxvGwD20lDNVtyWVZLRLxAeB7Y0OKSjwXnprGykLJmpotmC7SKp/ks2P0Ey23cWLO+R/xuH9uufj/dIIfNz2ZzMyMJ6DTyFqp5R4OUGjcf/6oT5Kb2W4i5IwWKBgxFlLCJEfp9xDeOsMwxuLXLCjtPl1QnTxzYSYyaKELJpK49dELfu5GYjFt878YMor/G9koqwmo/ryPAM0fLPok529l2yKVL5Guww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39830400003)(396003)(376002)(478600001)(71200400001)(86362001)(53546011)(6506007)(2616005)(5660300002)(66476007)(8676002)(186003)(6916009)(26005)(64756008)(66556008)(66946007)(83380400001)(66446008)(91956017)(6486002)(4001150100001)(76116006)(2906002)(8936002)(4326008)(54906003)(6512007)(316002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2doNkR1RHZvOEhQVmVOamZUTm42VVJNcHNjZDNyazllalZOMjBHakRLam1F?=
 =?utf-8?B?aGtHbHFHbFlpV0xWeitVTHBBaEx0L0tHZ0E5eTNTSW14Z1dDWGx5ZXQrTjMv?=
 =?utf-8?B?WG5kQ2Y5bFF3KzMvbi85OXZKM2ZsQjhPeWhvU0lCUWtYbVRSejV0eVBFdU5H?=
 =?utf-8?B?N3lXRnFPVlVJU0FtK0wvNGpWT2thd2ZFNU5hd0tReWZ1bE9jL0taTE9CRGU4?=
 =?utf-8?B?eFpBWkQ5bStvaTBXYWZidGFWeFF3MTVyZ2xWMDB0MDk4TEpCM01DeEQ4Qklj?=
 =?utf-8?B?MnYxOFl5VVNhdmxCNmZPY01Xc2JHdFRUUEdmOGV3cm56V2VldW1DSTNDM0hs?=
 =?utf-8?B?RHZWOVhpSVFQVmR2T2NOSU03UUN4czhUZkc2enVMREdxbDBQalBjTjFUVmxZ?=
 =?utf-8?B?YkNsYUJOV1huRGI5cEp4U05hWDZQQUZJRWlXd2pld2RPZUhXb0F2dm4xRFpG?=
 =?utf-8?B?TndjNFlNd0RpTXhPeXFLSlJpaXdjcEkwdFd0Z3dvc2I0YkgyNTg0dlRvK2dG?=
 =?utf-8?B?a0tPQkNDZjgzYnhGdkVOTm9QMWlQUnNIV0NzajU0bWE2bDNucHExSVJlVVdQ?=
 =?utf-8?B?R1lUdWswbG5aRDdoNHpiUytCRVZtS0ZMazUzNXNFWGY0ZmFHeS9mRkVZVjFC?=
 =?utf-8?B?eHptOEU0RmEzMW9hekoxejd4ZStXYlVZeDQ1ZFk3MjIyVmR6bTZ1U3JZcTRh?=
 =?utf-8?B?NEdXa09HSHRsVGtRTG1NN0F3ZCtLaHVjU2h6bWxjYkE2Y202ODlHT3pud0xs?=
 =?utf-8?B?eUZzdEY2Nkg1Umo1Z1ZnMjdJeWlUWEp4ZzdmYmtqbVZURUxHRkp4akJWMzc2?=
 =?utf-8?B?THpMR3FtWkYrUnFkM21POTNGdkJpQVIxakloSzB4UmllU2JnYjlldk9sNmlw?=
 =?utf-8?B?L3VkWmtwSjdab0VaMVRYNXFMd28wK1YwVjNjWkRsdzE4WS9pa2hLWW5jbmxY?=
 =?utf-8?B?OGRQM2dUUHcxanR1RWhsOGlZMFBkUmVpL1RzSzFsSGRWNytoemdldFhlTG4v?=
 =?utf-8?B?eUN6RUxwSUhqclJsa1AxdFZLdjVGaTRCL0V6eEJkbkhlclVKb2tqcEdvSXBn?=
 =?utf-8?B?WGYvR0VmNEpiUkJacXZIUUhJVHVPUXdtS3ZDOFlMamFMZU0rdU5VbC9rZjhl?=
 =?utf-8?B?dWowWVRBTVdZTndYTXg0dWx5aHhsNVZOenFpRjVUL1NaanVUVGtHS0tmdDE0?=
 =?utf-8?B?Kzcza3llWll6N1dlSldJcTd0YlVEQmhwMkY0ZDErRnNBcUdYVmxhbVgvOXJ4?=
 =?utf-8?B?alEvZ3c2ZWlWRzhjeUJCMFNNdmE5NFpPU3BGSFlTN2dSSHdKdk5tVk81cEFH?=
 =?utf-8?Q?a6K/P+ip+1hbJG00IiiE4hSHGyN5GUDhBD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15AEE7C20395C74999EF6EDA4A446C5D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36ef37e-79d2-4628-8004-08d8957a25db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 21:51:52.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++YPRuwedrnaL5u9u+BxpmSgQIAxN2boTb8Ud6KDS41IZsZxwykCUWXm1iPPc5tzrxu9TLG6Iq9YLmzTMkjMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4007
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE2OjQwIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgVHJvbmQtDQo+IA0KPiA+IE9uIE5vdiAzMCwgMjAyMCwgYXQgNDoyNCBQTSwgdHJvbmRteUBr
ZXJuZWwub3JnwqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVGhlc2UgcGF0Y2hlcyBmaXgg
YSBudW1iZXIgb2YgaXNzdWVzIHRoYXQgSGFtbWVyc3BhY2UgaGFzIGhpdCB3aGVuDQo+ID4gZG9p
bmcNCj4gPiByZS1leHBvcnRpbmcgb2YgTkZTLg0KPiANCj4gVGhlc2UgZG8gbm90IGFwcGx5IG9u
IHRvcCBvZiBCcnVjZSdzIGNoYW5nZXMgaW4gdGhlIHNhbWUgYXJlYS4NCj4gSSd2ZSBwcmVwYXJl
ZCBhIHRyZWUgdGhhdCB5b3UgY2FuIGFwcGx5IG9udG8uDQo+IA0KDQpIbW0uLi4gVGhleSByZWJh
c2VkIGNsZWFubHkgb24gdG9wIG9mIHlvdXIgYnJhbmNoLCBidXQgSSdsbCByZXNlbmQNCnRob3Nl
IHJlYmFzZWQgcGF0Y2hlcy4NCg0KPiBTZWUgdGhlIGNlbC1uZXh0IHRvcGljIGJyYW5jaCBpbiB0
aGlzIHJlcG86DQo+IA0KPiBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9jZWwvY2Vs
LTIuNi5naXQNCj4gDQo+IA0KPiA+IEplZmYgTGF5dG9uICgzKToNCj4gPiDCoG5mc2Q6IGFkZCBh
IG5ldyBFWFBPUlRfT1BfTk9XQ0MgZmxhZyB0byBzdHJ1Y3QgZXhwb3J0X29wZXJhdGlvbnMNCj4g
PiDCoG5mc2Q6IGFsbG93IGZpbGVzeXN0ZW1zIHRvIG9wdCBvdXQgb2Ygc3VidHJlZSBjaGVja2lu
Zw0KPiA+IMKgbmZzZDogY2xvc2UgY2FjaGVkIGZpbGVzIHByaW9yIHRvIGEgUkVNT1ZFIG9yIFJF
TkFNRSB0aGF0IHdvdWxkDQo+ID4gwqDCoCByZXBsYWNlIHRhcmdldA0KPiA+IA0KPiA+IFRyb25k
IE15a2xlYnVzdCAoMyk6DQo+ID4gwqBleHBvcnRmczogQWRkIGEgZnVuY3Rpb24gdG8gcmV0dXJu
IHRoZSByYXcgb3V0cHV0IGZyb20NCj4gPiBmaF90b19kZW50cnkoKQ0KPiA+IMKgbmZzZDogRml4
IHVwIG5mc2QgdG8gZW5zdXJlIHRoYXQgdGltZW91dCBlcnJvcnMgZG9uJ3QgcmVzdWx0IGluDQo+
ID4gRVNUQUxFDQo+ID4gwqBuZnNkOiBTZXQgUEZfTE9DQUxfVEhST1RUTEUgb24gbG9jYWwgZmls
ZXN5c3RlbXMgb25seQ0KPiA+IA0KPiA+IERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvbmZzL2V4
cG9ydGluZy5yc3QgfCA1Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+IGZzL2V4cG9y
dGZzL2V4cGZzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAzMiArKysrKysrKystLS0tDQo+ID4gZnMvbmZzL2V4cG9ydC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKw0KPiA+IGZz
L25mc2QvZXhwb3J0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDYgKysrDQo+ID4gZnMvbmZzZC9uZnMzeGRyLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrLQ0KPiA+IGZz
L25mc2QvbmZzZmguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMzAgKysrKysrKysrKy0tDQo+ID4gZnMvbmZzZC9uZnNmaC5owqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Ky0NCj4gPiBmcy9uZnNkL3Zmcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjkgKysrKysrKystLS0tDQo+ID4gaW5jbHVkZS9s
aW51eC9leHBvcnRmcy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
MCArKysrDQo+ID4gOSBmaWxlcyBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gLS0gDQo+ID4gMi4yOC4wDQo+ID4gDQo+IA0KPiAtLQ0KPiBDaHVj
ayBMZXZlcg0KPiANCj4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
