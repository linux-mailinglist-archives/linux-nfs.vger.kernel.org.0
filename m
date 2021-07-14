Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D053C8841
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhGNQDe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 12:03:34 -0400
Received: from mail-dm3nam07on2105.outbound.protection.outlook.com ([40.107.95.105]:31008
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232392AbhGNQDe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 12:03:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzYykpnc288gI1ik6n2IvvwR4HND7PuPggrUfGKXvQ2Qi9D0FN//tnlzo7vmwtxCIhCnyaFpwbe1MMn5YG+/PmHfleaJDZvP9z0vq9XbtMRmCml7TG204DdJ0Gz9qCO/1zONYGNtVgJvHX1pV5SXG+Fx1ZANX3zn7KGcJcYvW8VEqibNFVVpf+uE6toG9ei79NV4aXxrQ20P9ZGSLI0FEOZMQ7MZtktYhc6Gu0uJo3okebxKDthTzW6bNw52OzY/XbRus6EEIEKfl9GXbkkmKVpm90wBM0gzyqEDxpvDNG4gEVoLSe+3wPp01XCSG7RM7/w7pexW1+r3WnU8D2OMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiS0dLxNK1A4cnthQ677X+YGlNzxTsG8mcANF6rP3/c=;
 b=O9GHgSI0XHdKiHCL3/STkfSARsqwTdvFN7Ns5l2U7g1p7olmHv8sKbbFQEq5isX8ntLxdqB4Zi4S+1+femWbqQVB6q5galOV+Cli5QFLrtJzpCm02NYRCbP+zzUzuUWNM0bZxPSBPOe4atAXWQ0+V2cU/hhLHhx7sp0s0+1v2Vd5bRIOUvwLfBQQdv4dFk9n22leuj8soD/yd2UQIa78npSgQZh0oLzeBluvEOM1bgP5OTab66bd9wY/k2PL2jcfYLv8GDzCZbbLuuk1VGAK1yD4CgYOofHuAMJE1oNnz/Nwb3d6ub0qTQzvfRrBy+OFll+h0Ua1h0pcWYiDJ3On3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiS0dLxNK1A4cnthQ677X+YGlNzxTsG8mcANF6rP3/c=;
 b=XbZui+OioOqOWiN9s3drKxSxep0XMpnml+shDtbIx3l7S38VPhZFQXSnB9+Q+BrEiNtgcY+8DpEKlPznKmKIbc8Ca4VikIUaJgWhGvesABfXRalYJCyu94d8eJ6hyI9EjB3ZyfpPx+QzaztD+ArWPoTV25BoZmRFVv9X7PZ5nhw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5187.namprd13.prod.outlook.com (2603:10b6:610:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.16; Wed, 14 Jul
 2021 16:00:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4352.009; Wed, 14 Jul 2021
 16:00:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC 1/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for async
 lease renewal
Thread-Topic: [PATCH RFC 1/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for async
 lease renewal
Thread-Index: AQHXeMf5lQ5bt02h6EW9tXX7bMndO6tCoTYA
Date:   Wed, 14 Jul 2021 16:00:41 +0000
Message-ID: <2debf0bf8076dd81d7aa413a31c32fe48ad06961.camel@hammerspace.com>
References: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
         <162627781762.1294.17862468684529354297.stgit@manet.1015granger.net>
In-Reply-To: <162627781762.1294.17862468684529354297.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b238ee-dffa-4c59-2ca3-08d946e087ca
x-ms-traffictypediagnostic: CH0PR13MB5187:
x-microsoft-antispam-prvs: <CH0PR13MB51878A95BAD83DB073727200B8139@CH0PR13MB5187.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgODk9ZyQQIagMUgyPFBP35bhuXLtnNtLlprPa2/1qG2XDs4GhRIINEXlOYgfdvrziHsJMU9ngTn8dgS/5ZA9tWMw3fXxSdUV1FScxXGAmp1TPPSDoRA4wiLKVTN2WcWw4PWkTnc+BQK2XBsElu5ezZIpRs+ImMkvuguUx9gdc3s5ja3DtMnPLwz5LyXuwF4sYak2/k9KVLehmzpNLaz/MsNtfdslFZsnm9fO1JTB5DA25gsj5Gbu5JBg//jqFqRNcLLoWwj6mtWmIQYpcAIw1AIm6FKYyLYC8HhSw0njlvfumBSq9OQQjVy/dUUuhU33eUZUJxbHj4/ujPhJt9NvTOaCmtfJPGvt1b1jypkCbQd7MMT3TSCqbloh6n/Mf134soUMnmT8iicCoxTW7hu4OelgcJ66kJbOqatP2aVP8QIUeUp/wzJsIdH18Sg09GKpDLQ33aDhcib9v2ZIuashO9/Y1kNhiL1gKgFZX3tCDLV+c59wp8iU/y0vLS0pY+gsoTPyhbE5QLIoJgE1yDQyClGaebGYRY9wGT5Tq1IZPsd2pFXztRVGHD6Zrs6TWOagBYcdPaWlBqpwrlasott2buILJsLTP5Vp9HlsVjFn7tdZFsA1o+Kl00BQeGbKmzc5ea2p3QlSBhE/M8AaMSP1R6Me3y2LvjUl6AaLUwd7BGYNl2tbLX7UgGKR7JgxJAJN+mEk/kE7oPKw5Xj+NhecA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39830400003)(396003)(136003)(8676002)(316002)(38100700002)(2616005)(36756003)(122000001)(186003)(110136005)(6506007)(6512007)(26005)(66476007)(6486002)(66446008)(86362001)(478600001)(8936002)(76116006)(5660300002)(66946007)(64756008)(2906002)(71200400001)(66556008)(83380400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlVBVjZZalpzVEkzeHBsOVlzbFhSUnpXc0NBWFVBc00yS1NaazYwT3BMbXF5?=
 =?utf-8?B?T055dVdkcUtqWmI0NEIvTStkVVFJVWhrV253R0JrZnJWWWt3VEtZYkdmRFI5?=
 =?utf-8?B?Q3c2WG9ncGloVzFKcUpkYm95OHJ1d29FMkltMkp5L1MyY3ZUTHlhSUx5SElx?=
 =?utf-8?B?WVZCWlVvODJCZ0lMZVRYWHB5MnE0WXJmUU9OZERsTjR1WlJ1b1pzSFFHekFG?=
 =?utf-8?B?SERYVmxPWUNvYVF5NmpXd2w5N3lzcGJoQkdBRm9IdjFnZnl6ODNVS04yUVBl?=
 =?utf-8?B?Yk8wU2hOcmJjeHkvU2d1VG9ka1V5dy9GdkIxU3FIR21rUnZxc09Ya1NJY2dE?=
 =?utf-8?B?NllXdlBzc1NCZUg2aDlNSXJ3b3R4TEpsd3ViQitzVngwRnB6OWpIc2pSd1Ru?=
 =?utf-8?B?aVJ2T1ZIbHRUWFRwUjJHREZNbGd4eUl6YkUvaXM4VTRIdVJ4Z3hiZ01MVEV2?=
 =?utf-8?B?QTJLQnZaK1VlU1Zhby9HU3lLS0N1WXRRMFZmcUFLWmRKM2xYTkJnSkRVSEFH?=
 =?utf-8?B?MnpDQitrNUlSYVFaMnU0NnNqcTZOelFTRW5mNVNqVC9uTlUvaEk5Y2tDMFIz?=
 =?utf-8?B?UHRwN3p2d1F0TXBqbVhWUkxaRjQrM3BkS3N1MlRneFYvOERFdDBPYko0bmRZ?=
 =?utf-8?B?WGs5Yit0UnBnTlBlVkNvcEJqRDAzd3ExNGx6RHBZMjJNNU8rSFR3bEwxSnJn?=
 =?utf-8?B?Nk1kKzdHZGsyTU5abGFFTUxQWjNZRndzWUo4QkhyUWtrM1JkczduK1p0S2tz?=
 =?utf-8?B?NWFhV1VVZ2R0aEVnR2gxcjFtMHJZU1FMaTl5OCsvTmlvbmtZaE00ODRJV3c4?=
 =?utf-8?B?U3FCWkhYUTFaRitoZ0tLZTZDRHh3OTVMdUlVb0FaL05jM0VjL2w5aWV4NThU?=
 =?utf-8?B?THdxdEJLQXBpWHBqdy9zYk9wTFY2a1BJNVpRb1hlWmJVT056bEhTZW9MVlBN?=
 =?utf-8?B?MzZNVUJUT2UrcW0wNzVtR1RHZ0hEVXByenBsRnMzV3B0bThhdDROanpyazR1?=
 =?utf-8?B?ZjNwdTN6UFV4WDV6NWUvWnlmQzIrdGR0MnhrN1lpb1ZpSDRGMWhqVk1lODZ5?=
 =?utf-8?B?U005cVdEZldBOWYvbHZtVFp0U2hMZzBFQWY1L2Mrd1JuSDh3Yktic3dzY0Nj?=
 =?utf-8?B?cER1d2FtT0pFWU02bmNLUG5NeHFwaHJkSElVb1R4ZnlQWGY4NThCMkFCT3Jn?=
 =?utf-8?B?c0hVSkFaeTZXLzFaV052SnlvSGtZc0xSMWwwamF3WTh2VFRITE9vTGg1djBN?=
 =?utf-8?B?M3VKY0srd0VlQVJRL215NHJiVkRCYzNIMS9pbDdMRnVMZFFLWVF2ZjhORG1V?=
 =?utf-8?B?SS85eERTRXkxL1c1UFFSaGVzdDRQMnN6SzRkTHVDMmduM0tWbWJTbFU0WnYr?=
 =?utf-8?B?WEY2SVRPcFV4T2hsdm94b1RzTjYxUW5XSHIrNEVydzl1UzgzaGxpMVRNaDVR?=
 =?utf-8?B?UjJaMTRKOHhZYlA0TGIyVUZMSFBsU2QrZ0M1YnhPSG1DdWZQOSs1RW1mT0U1?=
 =?utf-8?B?b1h3d09lSzNWb1lVeDZEQ2YxTGdYV1cxbTl3MlQyNXlsd0tlM2JKN0VlMzZN?=
 =?utf-8?B?YTVqZ2IyVFBua2tQdHltVGV1dWp2R3dmckpIYnUyL2hoLzd6WE1HbTJ0d3Jx?=
 =?utf-8?B?MzI5UkRaS1k2U1p2eUVhNEluR1paZU9WNUhsUTlNVGtleWtIYk1jWjBJQk9s?=
 =?utf-8?B?bTVlUDJlSlg1K1c5OUltQWRkc25MUEdZK2R1WlE2U3QvajRsZ0NwY0ppSjQr?=
 =?utf-8?Q?zOotQuqvQjjpzhVK0UbpcLVFgugKlXqhYe5mqs/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <734A2FAA4FCA5F479C1F499A27D03F89@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b238ee-dffa-4c59-2ca3-08d946e087ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 16:00:41.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ8mH2NH7CTb2wmklC0cKSMMJxQ6xKkowTilE9gaG8g93BHFbnoce8Ep6+8q/b8EGr43oDwh9WvR3U2LMARyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5187
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTE0IGF0IDExOjUwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SW4gc29tZSByYXJlIGZhaWx1cmUgbW9kZXMsIHRoZSBzZXJ2ZXIgaXMgYWN0dWFsbHkgcmVhZGlu
ZyB0aGUNCj4gdHJhbnNwb3J0LCBidXQgdGhlbiBqdXN0IGRyb3BwaW5nIHRoZSByZXF1ZXN0cyBv
biB0aGUgZmxvb3IuDQo+IFRDUF9VU0VSX1RJTUVPVVQgY2Fubm90IGRldGVjdCB0aGF0IGNhc2Uu
DQo+IA0KPiBQcmV2ZW50IHN1Y2ggYSBzdHVjayBzZXJ2ZXIgZnJvbSBwaW5uaW5nIGNsaWVudCBy
ZXNvdXJjZXMNCj4gaW5kZWZpbml0ZWx5IGJ5IGVuc3VyaW5nIHRoYXQgYXN5bmMgbGVhc2UgcmVu
ZXdhbCByZXF1ZXN0cyBjYW4gdGltZQ0KPiBvdXQgZXZlbiBpZiB0aGUgY29ubmVjdGlvbiBpcyBz
dGlsbCBvcGVyYXRpb25hbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZzNHByb2MuYyB8wqDCoMKg
IDkgKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5k
ZXggZTEyMTRiYjZiN2VlLi4zNDYyMTdmNmEwMGIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0
cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC01NjEyLDYgKzU2MTIsMTIg
QEAgc3RydWN0IG5mczRfcmVuZXdkYXRhIHsNCj4gwqAgKiBuZnM0X3Byb2NfYXN5bmNfcmVuZXco
KTogVGhpcyBpcyBub3Qgb25lIG9mIHRoZSBuZnNfcnBjX29wczsgaXQNCj4gaXMgYSBzcGVjaWFs
DQo+IMKgICogc3RhbmRhbG9uZSBwcm9jZWR1cmUgZm9yIHF1ZXVlaW5nIGFuIGFzeW5jaHJvbm91
cyBSRU5FVy4NCj4gwqAgKi8NCj4gK3N0YXRpYyB2b2lkIG5mczRfcmVuZXdfcHJlcGFyZShzdHJ1
Y3QgcnBjX3Rhc2sgKnRhc2ssIHZvaWQNCj4gKmNhbGxkYXRhKQ0KPiArew0KPiArwqDCoMKgwqDC
oMKgwqB0YXNrLT50a19mbGFncyAmPSB+UlBDX1RBU0tfTk9fUkVUUkFOU19USU1FT1VUOw0KPiAr
wqDCoMKgwqDCoMKgwqBycGNfY2FsbF9zdGFydCh0YXNrKTsNCj4gK30NCj4gKw0KPiDCoHN0YXRp
YyB2b2lkIG5mczRfcmVuZXdfcmVsZWFzZSh2b2lkICpjYWxsZGF0YSkNCj4gwqB7DQo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgbmZzNF9yZW5ld2RhdGEgKmRhdGEgPSBjYWxsZGF0YTsNCj4gQEAg
LTU2NTAsNiArNTY1Niw3IEBAIHN0YXRpYyB2b2lkIG5mczRfcmVuZXdfZG9uZShzdHJ1Y3QgcnBj
X3Rhc2sNCj4gKnRhc2ssIHZvaWQgKmNhbGxkYXRhKQ0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMg
Y29uc3Qgc3RydWN0IHJwY19jYWxsX29wcyBuZnM0X3JlbmV3X29wcyA9IHsNCj4gK8KgwqDCoMKg
wqDCoMKgLnJwY19jYWxsX3ByZXBhcmUgPSBuZnM0X3JlbmV3X3ByZXBhcmUsDQo+IMKgwqDCoMKg
wqDCoMKgwqAucnBjX2NhbGxfZG9uZSA9IG5mczRfcmVuZXdfZG9uZSwNCj4gwqDCoMKgwqDCoMKg
wqDCoC5ycGNfcmVsZWFzZSA9IG5mczRfcmVuZXdfcmVsZWFzZSwNCj4gwqB9Ow0KPiBAQCAtOTIx
OSw2ICs5MjI2LDggQEAgc3RhdGljIHZvaWQgbmZzNDFfc2VxdWVuY2VfcHJlcGFyZShzdHJ1Y3QN
Cj4gcnBjX3Rhc2sgKnRhc2ssIHZvaWQgKmRhdGEpDQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
bmZzNF9zZXF1ZW5jZV9hcmdzICphcmdzOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRf
c2VxdWVuY2VfcmVzICpyZXM7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoHRhc2stPnRrX2ZsYWdz
ICY9IH5SUENfVEFTS19OT19SRVRSQU5TX1RJTUVPVVQ7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDC
oGFyZ3MgPSB0YXNrLT50a19tc2cucnBjX2FyZ3A7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXMgPSB0
YXNrLT50a19tc2cucnBjX3Jlc3A7DQo+IMKgDQo+IA0KPiANCg0KVGhpcyBpc24ndCBuZWNlc3Nh
cnkuIFRoZSBzZXJ2ZXIgaXNuJ3QgYWxsb3dlZCB0byBkcm9wIHRoZXNlIGNhbGxzIG9uDQp0aGUg
Zmxvb3IuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
