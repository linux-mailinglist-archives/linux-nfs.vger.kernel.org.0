Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DB3A6F7C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 21:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhFNTz6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 15:55:58 -0400
Received: from mail-co1nam11on2107.outbound.protection.outlook.com ([40.107.220.107]:20665
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234187AbhFNTz6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Jun 2021 15:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajKb54JrkmUCA57XlPAdGinoVeC4ANyjXAt1D09kETPIK0sxhpIex87NUoImvsFab0EVc/6aAOv2KVROjDir6u+BSqm2+nwXiwj7AWguVDxX6FvcYvlKue+7Rs5twrIx0o61TYYOsna/E5RhR6E8bjMmtxpfZ4PlFdjqyVP62bZJy/6QaF8+i38NdKKi2bgx3BSgBZsqn2eKyZSFX6WbNWhLpJRZ/9UvtLMuQhMc0XSfbFugPTNr9VT8NXM59h/aiQdP11JMUhVEeg3mrwdDMDvVh9jIRkleMMcBola4IbLMyG2G7D/47x/6446IN7UxaQLEvW5qN3zlAOzSBC9RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFjrrqo0P7rLw5QFhuJGsp/WJ3vpENxnnWIbbsxumyo=;
 b=P/Zcx77eYJesx8vphRy8WosIR/2EYFRWgX3LKYjq6KcA7rp50Cm27tmMbYBXhmalS4kYNuDwmlyuy7ciGpRqhc0hW23y1zcUjRErojLAZpnKyXoqbq0pdvBacz2POcEfeQHZAERZJIpgzw9XZuiamf/kx6xx0nNbiaE45EfErr1jhIhp0Pmgx3NMwixsrC3DGxdq+ZkpvBR4wbESY7R45uediXlAG3G5GmmZlsug0m8NClBmHayflLddn0yiszxHBIrbRPw0uLK+tKsEtdh6/IhAXKVAZCZHHpZ3MNsFEnH+nGMz5AW3uv3rLaxA2fk5KaVGs677HavnSIf3vOdi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFjrrqo0P7rLw5QFhuJGsp/WJ3vpENxnnWIbbsxumyo=;
 b=IpgDh0i8ztOy3rRWhRRESFW9B8/0I3r679DJ9rmKgC17EY+ZDd5rR62b79gMKk2eWy0AC4Yc75OcqJ05c0ghFoKu5CWFU8bQkbHLnr4Af0f4B+G1XhtKPcAVg6ynWPnNipbBamcaW7wluBS6cwQsjpFXbyYinmyQb/JETymE254=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2428.namprd13.prod.outlook.com (2603:10b6:5:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.14; Mon, 14 Jun
 2021 19:53:52 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.015; Mon, 14 Jun 2021
 19:53:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Topic: [PATCH 3/3] nfs: don't allow reexport reclaims
Thread-Index: AQHXYSxS/VKgzyaqykaajV5W1gWJEKsTmK2AgABNeICAAAWBgA==
Date:   Mon, 14 Jun 2021 19:53:52 +0000
Message-ID: <7b119b40fd29c424ce4e85fa4703b472bf0d379d.camel@hammerspace.com>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
         <1623682098-13236-4-git-send-email-bfields@redhat.com>
         <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
         <20210614193409.GA16500@fieldses.org>
In-Reply-To: <20210614193409.GA16500@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba3c57fd-7cd2-435d-5064-08d92f6e22c9
x-ms-traffictypediagnostic: DM6PR13MB2428:
x-microsoft-antispam-prvs: <DM6PR13MB2428E9D74A631A55374D152CB8319@DM6PR13MB2428.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJWMxm7tSOLUr3lTay/+Xd+fp0jKIuWcMQ8yCEPgH5/w6xV57cT21YIuSagtdhEWXql3SMhn/+v2/shU71RSKFdQsYbsHZfDyFopli+sZ2lLKfE5j8CNVlibvicBRqvhIlAmkHn39CQw9Bm/1i6dyxRJM3RWfu/PVmUR42esAfL5MYIROLoav3vzbtl10Lmo6TYgXGoHm37E4xk0i1nwCK0/JZWTD0gko6DSQ50uFEc/q94kmaJcH1zTX10L8JLH7BM5TgF6FXjzf86chR6xeTTiaDs4D2D2x2dzGgm9JIAmBD+wxAYD1gab19BgZdXt3ZOTT+fKvGdT2tKY2S2aJRZJyaMvWJqUlZVL7Kz+m6Z5qptxIGjE4/DUU0yA02jOePztoxwviiAkN0KyQd2sjxbUh+dWGzmPy3+bWHsgBl6EN2AfZ+MuyhGHTcIVZN5V2KHp3RMMSeff4ThPv33FqwCNxAi94RktZLPlSzs9Pvs03uVZ2FyzG4Sj8rVNAHs/PCby92KkgBRFsIfwn0YZrY5ErnAxp/Cy9oMwPiAc3cUUH2aHki015FcpZ8ihfQSTql8HZdJddkxVYIXC5Yr3I8m3h3Bg0/l3bp+5k5vBaqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39830400003)(376002)(4326008)(316002)(2616005)(36756003)(5660300002)(54906003)(83380400001)(38100700002)(478600001)(122000001)(71200400001)(6506007)(86362001)(2906002)(6486002)(8936002)(91956017)(186003)(66476007)(66556008)(64756008)(76116006)(8676002)(26005)(6916009)(6512007)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmNtby9kMVhBQm9ka0lkdnVMdHdCTTBYeURTMG0vYmd4SDlYVzJvSXRtYndj?=
 =?utf-8?B?SXFsSmJVc3NodHRyRHBjN0VZbEJGWHQxKzhwakdYNkNBcnNEdW1VZWUxT0h6?=
 =?utf-8?B?VlVNN3NrL2RtT3RsZXZiRWRjRWw0aUNKbW1EQ1FrZU5hUGZkUlJEcUdJSUVh?=
 =?utf-8?B?YUtXeEhhZU90V1ZPeVlvWk1YZDVuNVhHRVZzb25MWnBHdUlKL2V4S3hEVWtD?=
 =?utf-8?B?d0tJdkhrTmdjeUNTR2RaQXQyVVdmZThabTFnbDZwY2JjZHQvbUZheXQ5MnlN?=
 =?utf-8?B?WjRmYVdEbjBUL2FKQUErZHRKakhRMDhDSzdwZGM1YXMramI3NzdySlF1M1V5?=
 =?utf-8?B?cVkvamxGUkZHekpiVlZqUnRLTE1xQXF5aWVJczEyMi9kZkcvT0hIYXRjL2Jt?=
 =?utf-8?B?Vzk0eFlqUXhKaFkzSGh6bTNpNnh4R1ZiYUduK1JqMlJVZUNuRTROQjllQ0hx?=
 =?utf-8?B?K283VzdHTDBsTjNMb0pLUEJuOWVWeVZpbjg0NW94SEV2L2JHVTJDRzBLcUNp?=
 =?utf-8?B?THF5TXMvNUQvSndSSHhRK012YTB5anpFQnk0VEtkWDRYZGhuZ0VCQVdQMlFm?=
 =?utf-8?B?VEV1YlV5OVFSOGthRmVJa1Z6Y1pnRTh4SVhqYWlIaDg5MkxtOE1CbHljZFpX?=
 =?utf-8?B?MVRoTGdlbk5yNG5mSkpoYVBLS2d5Y1pKd1hCSUVFWEFQek1KaHRPR283WEgr?=
 =?utf-8?B?VTNzb2FiZzFvblNZWjhZS3lyck9EK2RINXNTYVgzazd6Z0UwU01LWUtZMlU5?=
 =?utf-8?B?VDFDT1gwMyszSjBXakVhRnp1a3lRS1JHajJnM3ZOQmhGdENjc3Bid1A1Z09w?=
 =?utf-8?B?eW5hVndaQUlaMkdqNkJTQVhRbkpHdXNDT2svaEdjM3Vka2JiVEp0ZlFJbCtr?=
 =?utf-8?B?TG1PUW1lK29vcWJybkNqeVBjOSs3ZVUzQWJrL2N6VmNkVEJBVUZZb1pWUXRR?=
 =?utf-8?B?bTVQbVFaaXdZNnlMcnZOUmtDMTE1SEtDUThGRGpBcnovRFpSVmdYTHdzK2dV?=
 =?utf-8?B?UWhXYlJWZHlRQk4rMkpXNEVjVlZMeEgrcEUvSjJKN29GdndtUldzN3FPWklm?=
 =?utf-8?B?ZGRQck8wUFhoa1lkS3BlZmlKWUZwN01kajZUd0ExUmlsY3FhSFlEUCtwc0ly?=
 =?utf-8?B?cmEzNXFSREZHaUpxUmhyVGZRcG9uQ1p0Q2FWL3l0cUp1VnhpaWJYeUhwRWtI?=
 =?utf-8?B?OFlSWGFnTVJnMS9xSjNCM0dMNWtyb3RrZFRyME13Wm85c0R3NUxrenB0Nmxm?=
 =?utf-8?B?ZGJ3WGttZmtsYWJHUnNnQ3ZpdHhZZzJEYlZJK0VtU2FXYkx0U21yWEtlWllw?=
 =?utf-8?B?QlhSeEJhZmxaa0RYTVpOUWpKZVJCd1haUG1xbjhqTmZMb0grM2NTNEQxWmRE?=
 =?utf-8?B?M2tGSU9tRzZYdDRlS3lmbFAxY2NhbnluVUEydG8wUHhGSUdNQmpkYzYvKzRm?=
 =?utf-8?B?QytNdzFlNGlGdVNFeXlyRjFHamZBdkE5dmozTXpacDN2cjRaQjNOTVBjTFZv?=
 =?utf-8?B?alJYV0dMam5mRlNJTEJYOWFiL3Q1L1Z5RE9IMXQ4N0EraVJBUFhyZ0dmdVNJ?=
 =?utf-8?B?V1BGWEg3TFFjMkRpZzh0dllWeGRDVGJMNEN5eDJ5QUs1dW5Dd2ZtZVJrS0Zl?=
 =?utf-8?B?dTQwaW0xbTU3WHRzZEFvbmRONlhFeC9DM1ZLZnJxWDdxQzJZYVM0dXU1OE0z?=
 =?utf-8?B?Y0YvR0ZGVVZFSFZ4TXM1ajZ0b3d6TFNpTUMvanpkR1ZmR3dNczVvb0ZHOGtG?=
 =?utf-8?Q?qOKwOyaDaVdxRvve5ZzBF82jUGkocyypNvASUxC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA469DDD0FC674BB492773F0A188963@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3c57fd-7cd2-435d-5064-08d92f6e22c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 19:53:52.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /82GMjDSpTqfClxnRDEif1ySNG/pa1wly16ELxbVJ1hcNAPRSy14oStaof+Mz6LYLV8kirwTfcVQUYSFmoSt6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2428
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTE0IGF0IDE1OjM0IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgSnVuIDE0LCAyMDIxIGF0IDAyOjU2OjU1UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjEtMDYtMTQgYXQgMTA6NDggLTA0MDAsIEouIEJy
dWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRz
QHJlZGhhdC5jb20+DQo+ID4gPiANCj4gPiA+IEluIHRoZSByZWV4cG9ydCBjYXNlLCBuZnNkIGlz
IGN1cnJlbnRseSBwYXNzaW5nIGFsb25nIGxvY2tzIHdpdGgNCj4gPiA+IHRoZQ0KPiA+ID4gcmVj
bGFpbSBiaXQgc2V0LsKgIFRoZSBjbGllbnQgc2VuZHMgYSBuZXcgbG9jayByZXF1ZXN0LCB3aGlj
aCBpcw0KPiA+ID4gZ3JhbnRlZA0KPiA+ID4gaWYgdGhlcmUncyBjdXJyZW50bHkgbm8gY29uZmxp
Y3QtLWV2ZW4gaWYgaXQncyBwb3NzaWJsZSBhDQo+ID4gPiBjb25mbGljdGluZw0KPiA+ID4gbG9j
ayBjb3VsZCBoYXZlIGJlZW4gYnJpZWZseSBoZWxkIGluIHRoZSBpbnRlcmltLg0KPiA+ID4gDQo+
ID4gPiBXZSBkb24ndCBjdXJyZW50bHkgaGF2ZSBhbnkgd2F5IHRvIHNhZmVseSBncmFudCByZWNs
YWltLCBzbyBmb3INCj4gPiA+IG5vdw0KPiA+ID4gbGV0J3MganVzdCBkZW55IHRoZW0gYWxsLg0K
PiA+ID4gDQo+ID4gPiBJJ20gZG9pbmcgdGhpcyBieSBwYXNzaW5nIHRoZSByZWNsYWltIGJpdCB0
byBuZnMgYW5kIGxldHRpbmcgaXQNCj4gPiA+IGZhaWwNCj4gPiA+IHRoZQ0KPiA+ID4gY2FsbCwg
d2l0aCB0aGUgaWRlYSB0aGF0IGV2ZW50dWFsbHkgdGhlIGNsaWVudCBtaWdodCBiZSBhYmxlIHRv
DQo+ID4gPiBkbw0KPiA+ID4gc29tZXRoaW5nIG1vcmUgZm9yZ2l2aW5nIGhlcmUuDQo+ID4gPiAN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiDCoGZzL25mcy9maWxlLmPCoMKgwqDCoMKgwqAgfCAzICsrKw0K
PiA+ID4gwqBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMyArKysNCj4gPiA+IMKgZnMvbmZzZC9uZnNw
cm9jLmPCoMKgIHwgMSArDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvZnMuaMKgIHwgMSArDQo+ID4g
PiDCoDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnMvZmlsZS5jIGIvZnMvbmZzL2ZpbGUuYw0KPiA+ID4gaW5kZXggMWZlZjEw
Nzk2MWJjLi4zNWEyOWI0NDBlM2UgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+
ID4gPiArKysgYi9mcy9uZnMvZmlsZS5jDQo+ID4gPiBAQCAtODA2LDYgKzgwNiw5IEBAIGludCBu
ZnNfbG9jayhzdHJ1Y3QgZmlsZSAqZmlscCwgaW50IGNtZCwNCj4gPiA+IHN0cnVjdA0KPiA+ID4g
ZmlsZV9sb2NrICpmbCkNCj4gPiA+IMKgDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgbmZzX2luY19z
dGF0cyhpbm9kZSwgTkZTSU9TX1ZGU0xPQ0spOw0KPiA+ID4gwqANCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChmbC0+ZmxfZmxhZ3MgJiBGTF9SRUNMQUlNKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtTkZTRVJSX05PX0dSQUNFOw0KPiA+IA0KPiA+IE5BQ0su
IG5mc19sb2NrKCkgaXMgcmVxdWlyZWQgdG8gcmV0dXJuIGEgUE9TSVggZXJyb3IuIEkga25vdyB0
aGF0DQo+ID4gcmlnaHQNCj4gPiBub3csIG5mc2QgaXMgdGhlIG9ubHkgdGhpbmcgc2V0dGluZyBG
TF9SRUNMQUlNLCBidXQgd2UgY2FuJ3QNCj4gPiBndWFyYW50ZWUNCj4gPiB0aGF0IHdpbGwgYWx3
YXlzIGJlIHRoZSBjYXNlLg0KPiANCj4gU2V0dGluZyBGTF9SRUNMQUlNIHRlbGxzIHRoZSBmaWxl
c3lzdGVtIHRoYXQgeW91J3JlIHByZXBhcmVkIHRvDQo+IGhhbmRsZQ0KPiBORlNFUlJfTk9fR1JB
Q0UuwqAgSSdtIG5vdCBzZWVpbmcgdGhlIHJpc2suDQoNCllvdSBhcmUgdXNpbmcgYSBmdW5jdGlv
biB0aGF0IGlzIGV4cG9zZWQgdG8gdGhlIFZGUy4gT24gZXJyb3IsIHRoYXQNCmZ1bmN0aW9uIGlz
IGV4cGVjdGVkIHRvIHJldHVybiBhIHZhbHVlIHRoYXQgaXMgYSBMaW51eCBlcnJvciBiZXR3ZWVu
IC0xDQphbmQgLTQwOTUuDQoNCkkgc3VnZ2VzdCBhZGRpbmcgYW4gZXJyb3IgdmFsdWUgRU5PR1JB
Q0UgdG8gaW5jbHVkZS9saW51eC9lcnJuby5oLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
