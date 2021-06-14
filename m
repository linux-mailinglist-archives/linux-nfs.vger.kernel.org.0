Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A853A70F5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 23:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhFNVFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 17:05:42 -0400
Received: from mail-co1nam11on2100.outbound.protection.outlook.com ([40.107.220.100]:52577
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229771AbhFNVFl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Jun 2021 17:05:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBiV/94txJD/tWBSX7PqIL3KRlCHoDBHOc08yPcZuq/3qOVhMe2808/av2qGqhltbg6P7l1/37GTDiVYy9sBDuavRFuNlBPv2LOSSLF9UyTmcTcqW1gyd3I8lg5lii+GsBI5O6c4J5UYygW9/QX2xyt4Lyz7jza8vO6sV90inCz51yn2w6yMlUQROuIhrf86TU8AkymXWM+Pe2HDnJtboYVu7OGVXFwPZBxlghoUrYANbc7fRF17r1393VbjDHFdwQDwL9f8LUeUDWXUJat3J2GKJoAJwOmI+te5VCOyjPdwcr452rHocsP3Ycx3sKDvk5REoDwVaVRyFS/Ox0L3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=havRxyrpr0VRyX24W3LN2VAqNipuHw/EJMfiQWNrMRY=;
 b=YBg/yXSHtfPe+V9xCOm870RfE6Wde7FtdfOTi37e5tlOTQv8otr4gQhV4VeTdOjHngy0qMyiEcoQOauTc1uMBb73iW6IMuND2MkH/pOwpupsOPpk6qSgdHKEuzxvIw7huPz4o7wl4KmcDNZaOccnB7eWqZaD3eSkhbTiJYf31ZTnH/esjYv49yAzEKxSYu3vzmelBdJQHSYpw1+l8D3ei8clt9NgKAbRNLOs7Woyj8euGCacglHWZ/gBmP55mcF8NLA709sy+JvjyXfmo7lD0oNr9ZMjD4BvNllLq4480eBdBa5YbYpFa54OJDeJBi+f1QZO9AwpWystjN5wnI+EFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=havRxyrpr0VRyX24W3LN2VAqNipuHw/EJMfiQWNrMRY=;
 b=Lrox4veE+T5XwzkMKOsfCBX1IySTHSl6dShdAYz0guIrXu6eXshXetoOl2oW6wVusq1q8yxFRt7nnbI7YXRltMaJqs2ozT2k4wPikK12kvSk/CjNRX6ywbaDNdX/7vvQM6BoVqJgVqPx8odCDcWJ6SslwrXIaxwBIz2fpUml/H0=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3955.namprd13.prod.outlook.com (2603:10b6:5:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9; Mon, 14 Jun
 2021 21:03:35 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.015; Mon, 14 Jun 2021
 21:03:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Topic: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Index: AQHXYSxS/VKgzyaqykaajV5W1gWJEKsTmK2AgABNeICAAAWBgIAAAtSAgAAQpYA=
Date:   Mon, 14 Jun 2021 21:03:35 +0000
Message-ID: <2c776400a50afcd3e82f71f6ecb806fda1bce984.camel@hammerspace.com>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
         <1623682098-13236-4-git-send-email-bfields@redhat.com>
         <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
         <20210614193409.GA16500@fieldses.org>
         <7b119b40fd29c424ce4e85fa4703b472bf0d379d.camel@hammerspace.com>
         <20210614200359.GC16500@fieldses.org>
In-Reply-To: <20210614200359.GC16500@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 852ef78c-1e98-4697-0479-08d92f77e02b
x-ms-traffictypediagnostic: DM6PR13MB3955:
x-microsoft-antispam-prvs: <DM6PR13MB3955A4B2A678770C71E551A9B8319@DM6PR13MB3955.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRlezawdD10nrW+MT1aGN+ETOKzn/jb3SyTc6fxzOiKvfSjwNZgJ50wNmB8to0wxU7yjo3nO/DORukEbLbnxOoD5gOVYz607IuTOzqoroCqTNQK/U48SuVD/aDNHSQv5CCwXejbO6pyx2TFADrMJrCVfyQjcrEagSU0syu3yVd4OQPyD3WdKQcve/YfLV+vg8YRMIunCOzW2kOHeT5Cui2jpmr7BOPnQe+QNx0QiM3lXUsyi6j88vHgPW/0pv9P5e0zuSOqFiaTUF+VvX9ixO9LgDLPlGukvFTjgplYq1/Nhc9o0AXNuBpp75kh7kqeyvQ9X0VWuIzZwkDTFQvBhpFG2i6CQnN919E7mci3Wacj+lDkUKA/CVhRKXTvIezAyRT1t3zdsBcRYDoqoobwTWkSkaRV9Hw/5vN/BmXpxwg4VV//C8cv+Ps5+naR43lyvPF0erCgJ7k4t7m5MN9zgqYY6ud4HefcfljzDq3ma+Sp/vOl5uhRAW9lqLl7AN0I+PuWhd1t30Uek+ahB8bYSNH3p4l2Ky9W9VasBVe1TR+MnGjTmPtOJ7bS6DV1L2oapE0yCI6EWhaJi22hqp7t+dVDNPPmE2/uYHWq6athXHxu60PEATdTPMSAzFMhO35vbcxlrKjKN8QAH7c8Wk/m5Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39830400003)(366004)(4326008)(36756003)(478600001)(71200400001)(26005)(38100700002)(54906003)(2906002)(122000001)(6506007)(83380400001)(8936002)(66476007)(6512007)(186003)(5660300002)(66946007)(91956017)(2616005)(76116006)(86362001)(64756008)(66446008)(66556008)(6916009)(8676002)(316002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0hqL1owYkJTd25IYWJPYUFxMkgyOGFrT0tHbGszMXlzcFRRbHNCdlNqdWpu?=
 =?utf-8?B?K3NJbzVwZkoyQnNHVFF6MlNZckNTa1Q4SURqWjdmTm1DNFJCWjR4ZTl4RUQ0?=
 =?utf-8?B?ZHNJZmZpWk5ZT2lCSml0N09aYVBXNlZWYWZUTXFja1I3QU5HNEwxZjRucmhk?=
 =?utf-8?B?UjJYYjZlYWJKeElmbFZ1aEhjUmM2WEJyTXR3OE9XQitjYzZYRVlqeXN0ZG9w?=
 =?utf-8?B?UFF4WWZjRlFneUpKMEt2a3NyWkpxSU9kKzZ2VnhDQVgzaGN1UU1xOEpIcEdo?=
 =?utf-8?B?akJKc2lQYU9Td2VTeUlvREN4VFc3bXNCK2NpYUhCbkZ0UEFjM3krdDJWVjFV?=
 =?utf-8?B?TEdCTGR3NjQ4dEdabXIya3VoV3NGQStpUzJjWkFqaWxLZDluR0ltUmdXSmhI?=
 =?utf-8?B?bGtXRU8vL2paMXVlMEQ2bU9tdTBhclRCNVMrdUQwTjQ4R09PRER5V3QydVZv?=
 =?utf-8?B?OE5LUmpXazY1TlIyck9LbGVkcU1OMjZNVWNqZGpLYmRyQ29ZRHhMeU5xZ3Vq?=
 =?utf-8?B?T3N3UTh0WjZ6Yi9zUHN5S3VUdENERmV2bDhDWndiUTNNTmZ0em5aL296SkND?=
 =?utf-8?B?d3Z2QWZXVnhiVGYzemNzYjNWWUZQZDRvempyNTlBNGo2QitFeXRCYms1MXpp?=
 =?utf-8?B?VWliZ0N3WGEyUzVqUXlzSWZBSncyTFVDUTc5Z1pvTEdtVDZ4S0xtenFPc29K?=
 =?utf-8?B?QjZYUHN2UGcvMU1ZWlM4YzcwVlRjRHl0WE44a2hJWGlBRWlnc3pGYnJaTkRG?=
 =?utf-8?B?M254UWV3c0NhSHRQOVhubEdLNzBWdmxVZXRvT1J1YVRoTUpJNXhwTW9IN0Rz?=
 =?utf-8?B?ZFpBVDNwT1JJU0I0a1ExRjZGSWhFd0MvRE5XQVZWMmtjK1NCclBMSnZxWUFn?=
 =?utf-8?B?RVJvYTFkZTJLSTVCc1F4QXJoZ0xneURGT1pNdmFvbmNuMDdxUFVEMDhRQXp6?=
 =?utf-8?B?Uzl1SjlHd1NVc2I3WXBuZnNzSS90ZnBadXppREhhT1dKODA2anIvZ3VPT3VJ?=
 =?utf-8?B?T29qWFB1N0xHZjcxWit3eVVzMGNENndXQlpoL0FYV0hjS2pwSkVVL05Jcm80?=
 =?utf-8?B?UlBHTXVudXZSNy8rZGxZOXZudFRqU3hEajZIRHkzZTZaSGdrakVqd2hQYnJQ?=
 =?utf-8?B?OUcvd0I2N3oxTWxRcGx4ZUxhM3FUdGJ0RTdlUUR5cHRmTzZuTEtscjk5c204?=
 =?utf-8?B?M0Npc2VsS3QzNVdoalAyZVRpUmFRMVBQcXlXYkRacWNCc01wWE53eTFoNWlJ?=
 =?utf-8?B?eVdaVXJHRm9TV3owRmZpT3RhVkZPNUVXNi9YbWJQWjhjeVNTVmlkQ243NlBK?=
 =?utf-8?B?YTI5cXFSYlRrZ1FUOGZydlBjVStvcHVwU2xlZWpXNnQxWnNXc251TGNRcW5F?=
 =?utf-8?B?NG1CRDBDSmg2dkxTTThmNldQa3I1OGpKOHNabUVGWjViZkNqdU94WmIzRmRo?=
 =?utf-8?B?UFYxZ245MGZUQkVXMEcxUHlFaGEyMlBDdHZnREhwWVdxNzZGcGNnTWNTaEtF?=
 =?utf-8?B?VVFoQnhxTkpMdURpd0dUSWZzSkxnekF0bk9ibG4xN01HUUZ4NFdIeXAvUUNy?=
 =?utf-8?B?Q3ozRkpZVXMwOVRFYkJ3SVExbVVHdEVaRGw2U3RqUndya3U0YUxESkpEY1Ux?=
 =?utf-8?B?ekdXeTBzVlRRVzFRelR6Y2VPb1RuekVyNkJMb0ZvcDd3STZyT1Erb3JwVlJG?=
 =?utf-8?B?aDZQVDJmaVZmaWVNSnFhUGo3RVRzWm1TN0ZmWVZRUUtEbFJNSFczVVFvVWht?=
 =?utf-8?Q?qxkESKynQ6Dt1Ey6X4rsDwfrUhNKn1/2Gvt2JA7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A72AA7C5C96C240B3AB10EB8F21545F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ef78c-1e98-4697-0479-08d92f77e02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 21:03:35.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2K86ztv2jgVwq3JurmWs2o1UoaIiLqbGO31fsJBiJTROSm9F1oJvCLAgyNT6kJY3F6r4DUmPzxnb02shIZ2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3955
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTE0IGF0IDE2OjAzIC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gTW9uLCBKdW4gMTQsIDIwMjEgYXQgMDc6NTM6NTJQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMS0wNi0xNCBhdCAxNTozNCAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBKdW4gMTQsIDIwMjEgYXQgMDI6
NTY6NTVQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDIw
MjEtMDYtMTQgYXQgMTA6NDggLTA0MDAsIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4g
PiBGcm9tOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEluIHRoZSByZWV4cG9ydCBjYXNlLCBuZnNkIGlzIGN1cnJlbnRseSBwYXNz
aW5nIGFsb25nIGxvY2tzDQo+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+
IHJlY2xhaW0gYml0IHNldC7CoCBUaGUgY2xpZW50IHNlbmRzIGEgbmV3IGxvY2sgcmVxdWVzdCwg
d2hpY2gNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGdyYW50ZWQNCj4gPiA+ID4gPiBpZiB0aGVy
ZSdzIGN1cnJlbnRseSBubyBjb25mbGljdC0tZXZlbiBpZiBpdCdzIHBvc3NpYmxlIGENCj4gPiA+
ID4gPiBjb25mbGljdGluZw0KPiA+ID4gPiA+IGxvY2sgY291bGQgaGF2ZSBiZWVuIGJyaWVmbHkg
aGVsZCBpbiB0aGUgaW50ZXJpbS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXZSBkb24ndCBjdXJy
ZW50bHkgaGF2ZSBhbnkgd2F5IHRvIHNhZmVseSBncmFudCByZWNsYWltLCBzbw0KPiA+ID4gPiA+
IGZvcg0KPiA+ID4gPiA+IG5vdw0KPiA+ID4gPiA+IGxldCdzIGp1c3QgZGVueSB0aGVtIGFsbC4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ20gZG9pbmcgdGhpcyBieSBwYXNzaW5nIHRoZSByZWNs
YWltIGJpdCB0byBuZnMgYW5kIGxldHRpbmcNCj4gPiA+ID4gPiBpdA0KPiA+ID4gPiA+IGZhaWwN
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBjYWxsLCB3aXRoIHRoZSBpZGVhIHRoYXQgZXZlbnR1
YWxseSB0aGUgY2xpZW50IG1pZ2h0IGJlIGFibGUNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IGRv
DQo+ID4gPiA+ID4gc29tZXRoaW5nIG1vcmUgZm9yZ2l2aW5nIGhlcmUuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5j
b20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqBmcy9uZnMvZmlsZS5jwqDCoMKgwqDCoMKg
IHwgMyArKysNCj4gPiA+ID4gPiDCoGZzL25mc2QvbmZzNHN0YXRlLmMgfCAzICsrKw0KPiA+ID4g
PiA+IMKgZnMvbmZzZC9uZnNwcm9jLmPCoMKgIHwgMSArDQo+ID4gPiA+ID4gwqBpbmNsdWRlL2xp
bnV4L2ZzLmjCoCB8IDEgKw0KPiA+ID4gPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZpbGUuYyBi
L2ZzL25mcy9maWxlLmMNCj4gPiA+ID4gPiBpbmRleCAxZmVmMTA3OTYxYmMuLjM1YTI5YjQ0MGUz
ZSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+ID4gPiA+ID4gKysrIGIv
ZnMvbmZzL2ZpbGUuYw0KPiA+ID4gPiA+IEBAIC04MDYsNiArODA2LDkgQEAgaW50IG5mc19sb2Nr
KHN0cnVjdCBmaWxlICpmaWxwLCBpbnQgY21kLA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiA+
IGZpbGVfbG9jayAqZmwpDQo+ID4gPiA+ID4gwqANCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
bmZzX2luY19zdGF0cyhpbm9kZSwgTkZTSU9TX1ZGU0xPQ0spOw0KPiA+ID4gPiA+IMKgDQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGZsLT5mbF9mbGFncyAmIEZMX1JFQ0xBSU0pDQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtTkZTRVJSX05PX0dS
QUNFOw0KPiA+ID4gPiANCj4gPiA+ID4gTkFDSy4gbmZzX2xvY2soKSBpcyByZXF1aXJlZCB0byBy
ZXR1cm4gYSBQT1NJWCBlcnJvci4gSSBrbm93DQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gcmlnaHQN
Cj4gPiA+ID4gbm93LCBuZnNkIGlzIHRoZSBvbmx5IHRoaW5nIHNldHRpbmcgRkxfUkVDTEFJTSwg
YnV0IHdlIGNhbid0DQo+ID4gPiA+IGd1YXJhbnRlZQ0KPiA+ID4gPiB0aGF0IHdpbGwgYWx3YXlz
IGJlIHRoZSBjYXNlLg0KPiA+ID4gDQo+ID4gPiBTZXR0aW5nIEZMX1JFQ0xBSU0gdGVsbHMgdGhl
IGZpbGVzeXN0ZW0gdGhhdCB5b3UncmUgcHJlcGFyZWQgdG8NCj4gPiA+IGhhbmRsZQ0KPiA+ID4g
TkZTRVJSX05PX0dSQUNFLsKgIEknbSBub3Qgc2VlaW5nIHRoZSByaXNrLg0KPiA+IA0KPiA+IFlv
dSBhcmUgdXNpbmcgYSBmdW5jdGlvbiB0aGF0IGlzIGV4cG9zZWQgdG8gdGhlIFZGUy4gT24gZXJy
b3IsIHRoYXQNCj4gPiBmdW5jdGlvbiBpcyBleHBlY3RlZCB0byByZXR1cm4gYSB2YWx1ZSB0aGF0
IGlzIGEgTGludXggZXJyb3INCj4gPiBiZXR3ZWVuIC0xDQo+ID4gYW5kIC00MDk1Lg0KPiANCj4g
T3IgMSwgYWN0dWFsbHkgKEZJTEVfTE9DS19ERUZFUlJFRCkuDQo+IA0KPiA+IEkgc3VnZ2VzdCBh
ZGRpbmcgYW4gZXJyb3IgdmFsdWUgRU5PR1JBQ0UgdG8gaW5jbHVkZS9saW51eC9lcnJuby5oLg0K
PiANCj4gSSBjYW4gbGl2ZSB3aXRoIHRoYXQsIGJ1dCBJJ20gc3RpbGwgY3VyaW91cyB3aGF0IGV4
YWN0bHkgeW91J3JlDQo+IHdvcnJpZWQNCj4gYWJvdXQuDQo+IA0KDQpJIHdhbnQgdG8gYXZvaWQg
dGhlIGtpbmQgb2YgaXNzdWVzIHdlJ3ZlIGJlIG1ldCB3aXRoIGVhcmxpZXIgd2hlbg0KbWl4aW5n
IHR5cGVzIGp1c3QgYmVjYXVzZSB0aGV5IGhhcHBlbmVkIHRvIGJlIGludGVnZXIgdmFsdWVkLg0K
DQpXZSBpbnRyb2R1Y2VkIHRoZSBtaXhpbmcgb2YgUE9TSVgvTGludXggYW5kIE5GUyBlcnJvcnMg
aW4gdGhlIE5GUw0KY2xpZW50IGJhY2sgaW4gdGhlIDE5OTBzLCBhbmQgdGhhdCB3YXMgYSBtaXN0
YWtlIHRoYXQgd2UncmUgc3RpbGwNCnBheWluZyBmb3IuIEZvciBpbnN0YW5jZSwgdGhlIHZhbHVl
IEVSUl9QVFIoLU5GU0VSUl9OT19HUkFDRSkgd2lsbCBiZQ0KaGFwcGlseSBkZWNsYXJlZCBhcyBh
IHZhbGlkIHBvaW50ZXIgYnkgdGhlIElTX0VSUigpIHRlc3QsIGFuZCBldmVyeSBzbw0Kb2Z0ZW4g
d2UgZmluZCBhbiBPb3BzIGFyb3VuZCB0aGF0IGlzc3VlIGJlY2F1c2Ugc29tZW9uZSB1c2VkIHRo
ZSByZXR1cm4NCnZhbHVlIGZyb20gYSBmdW5jdGlvbiB0aGF0IHRoZXkgdGhvdWdodCB3YXMgUE9T
SVgvTGludXggZXJyb3IgdmFsdWVkLA0KYmVjYXVzZSBpdCB1c3VhbGx5IGlzIHJldHVybmluZyBQ
T1NJWCBlcnJvcnMuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
