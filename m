Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367173DF93E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHDB0N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:26:13 -0400
Received: from mail-mw2nam10on2125.outbound.protection.outlook.com ([40.107.94.125]:46433
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232195AbhHDB0M (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 21:26:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeWjBeUa3F8MZUyx/Bc8YdZ1eH7fndvl8N3MNwOYYC9P7yvYPcvyGZ/7ZKkp4H3P+CUjWlAAzSKnwDAswdBn+FaLsCCbSa39hZ+MQ12jwFrHqa12i8l5E1532HENU/hudlkn8YjvyLHp0DkvLhkmR86+irs2xAL0JM3ZTMDQT58TzXrmm4HyIY2h9/2mwYpfN+sEU0xhjWSdDZ9NXQq4uDpwT/jDks9qyE1cQbj9w8zqLYg7NdSi1ixKPme29Wt7aqSzXXUXUvf9rsBo5819t39iZJw8W/bGl0gPL5ejiye+kDoNx8MoJFM4xcLO8KgApmn48MqY4Ku16IkAha4/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exZptjSPWQgStU+snmcc8tWzly4tBh4xURlhZgQzuLM=;
 b=GmkbGgAKhwidcwy1ThagahO253XZOvrjHSljkvZgw9g/6jmA3sTUZR+sl1MJYmPCVYWDwZ8jBBK7LSn03fkxFix9FkDTcQkVIpqa7WI4wFj9Dvh0aPNN/oA76o73azpzySraXAHGqS9xt83i4mXE15rdagmzby4ycPeiUHZ31iN57KZMfyF7MgZz2adFN0AI9nzIOHyJfYeHm+Na382v91XhemAz5Bp7P4EaDwnmwIU7IAMAdGo0qBzPJj5LWfJMIbqKd0LqF2zsGsdLJPMpvur+FlMgQUQWOp9oO6/of9ENEjCeDoGPBvRRfDWLV2y3hCeAT/qZBBzGCKakcuI6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exZptjSPWQgStU+snmcc8tWzly4tBh4xURlhZgQzuLM=;
 b=IbiuleYbRXWt3lgaKEjMoxVa3i+cKCvOoMeif4k+asYBuARrEiVRXzh6cuTjNGxbbCQZHprQxuEHJ9xoGdsk9onCYdvEoo6e7v3VXtuoLNji8vOzgT388X9HjS2inNIdVSl8eN+qYjWanUXNwPy90XkJ+5tuv1U615HqJT0hm0U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4523.namprd13.prod.outlook.com (2603:10b6:610:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 01:25:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 01:25:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WAgAAQJoCAAAG1gIAAA30AgAACqIA=
Date:   Wed, 4 Aug 2021 01:25:58 +0000
Message-ID: <67cfb5eead593f1cf306bfa4d23ff6fa0d3567a1.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
         <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
         <20210803203051.GA3043@fieldses.org>
         <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
         <20210803213642.GA4042@fieldses.org>
         <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
         <162803443497.32159.4120609262211305187@noble.neil.brown.name>
         <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
         <162803867150.32159.9013174090922030713@noble.neil.brown.name>
         <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
         <20210804011626.GA19848@fieldses.org>
In-Reply-To: <20210804011626.GA19848@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd67d1e-50e3-4eee-faaf-08d956e6d06a
x-ms-traffictypediagnostic: CH2PR13MB4523:
x-microsoft-antispam-prvs: <CH2PR13MB4523E3EFA92C3E1B6B369BEFB8F19@CH2PR13MB4523.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvhjYfNFB8agsVucgz3HOG6SX711GiwI3SDb88UZ2UfSfov/RRJLFri/B3EXTy1xQrIEUFY6JYzOoLmE++3KM1bVyKUm1dZRt6MYTTRBbNnSJ0Zw9j+pPccTNfDYDUP4VMcVpx2rE2DA++JR6WBe3Ui4fIddGcrRrgdcI3iMcSnWPL00IYqblDjDQgCsVC2RVyYIbIzHzlgxDNZvEnjBRvidic1uOc1vrv74X5gfyW7RlHxE4tpeJ3iRnsJX/TLJ+pTIslLd/5LSb105gEVchmGq2tg5j5j4+KYak+8q09G7KHywj1dEvp9Mqvq9HrafEr5xs49Y8/b/kn8hgnxcAayRtZCsBmjBvZk8YWZbplRE60bYtmnvFp0YKcyioJFGRnwvbroc3vfy5UxMys8bpdjIEG+fwvhN6gki9P7+PK7RTYz2DDvlZw1LwSFDnMMbK9xyQP7CodHjonosNA/KCpHTLrDFXh3JkETOWz2k9Y7wVSR8c6GcRVDXJiDdqxc0IPKs8RXHOgU7lPJGYobSJs6KwxBXZsvVmgesky6mG25Tt5nOMvp/lmDLnLO9K+eyLd1PBAVcd3puijc8pRuojM3shX0NxJu2wqZHrLFcHJtGjjOU2/Wf1e3ZxzK2B1XS+E8BpY/idwy/zKpcPK+r4/cQo8wQRbmDeNyArogNcHTS2otzQqKeew3aDh6uqRbyh+3w9KluzI11fp0r7Mz5pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39840400004)(136003)(346002)(376002)(66556008)(66476007)(76116006)(66946007)(66446008)(122000001)(64756008)(71200400001)(6512007)(38070700005)(6506007)(186003)(5660300002)(2906002)(8936002)(8676002)(6486002)(6916009)(2616005)(38100700002)(4326008)(54906003)(86362001)(36756003)(26005)(83380400001)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFSbGNKVUhxdlV6RWVSU3NWMERteG9FSnFTeEl1cEk4WkR2aFB5VmNYZDhH?=
 =?utf-8?B?WHJPN1ROVDhGZmFTZ0FMelpPUnY5TDlyV09zdmJ2cmNTOG1xWDN5MDhsT0RK?=
 =?utf-8?B?YVkvd3lCYUszemdGeFhDSmpyQlNmcFB4UTdIUEVNWmFraVZvanUra2ZXR1E2?=
 =?utf-8?B?d3cwOCtuYkpoYzVWZkJjcWw1NnN2Qzl5bWZIU3pVTHV3RHFwK29Ha2VtMEx0?=
 =?utf-8?B?elVyN0dNWExQV3AwVHo5cEZCTWgrd0ZIYU1CZ3YzZGRDc0F0cU5DanRDNjAx?=
 =?utf-8?B?NmJLQlV0WUZKdlVNWTJMOGhyajI2c3RROW4yZml4dURxVXhPdWFReU5HN1c2?=
 =?utf-8?B?cEdId1FNZy81cytUYnVFU1pVempzc3FwdkZWSkFHN1VZWkZYY2plZkk4NnVJ?=
 =?utf-8?B?ZkEzSUc1amQybEwvS0NpUDVadWxHWEcrOWVacExvRkF4dE00R09UZEZ0bGdy?=
 =?utf-8?B?L0dGT092WWZTMDBpa1Mxd0t5djNjRS8wNGpwc3hpNjE2TkZVRU1UbnlNdEly?=
 =?utf-8?B?TjczaCtSQ2t0OWJIVmRDVVdEMTRVOENPUXZ1Z0dLYkR5NzNyeWo2bmx1TWJi?=
 =?utf-8?B?RGRpNHpqUmtvZVBnMVZSSUVWTDNkdlppSE5hMDBxTkNCZzBZQUZnVy93dXRz?=
 =?utf-8?B?dmh1dk9LdG5aMjlzS3ZFUGlvQ3ZxV21PNHQyam9jVkRmRW1pTWVvd3ZqVVhp?=
 =?utf-8?B?SzgxTnppcG1PMXNkUzBHRmtuSXAxVUk3V0dWWUR3aWh3N1RQWmhVTFlja3Yr?=
 =?utf-8?B?T0ZWSVp4a2t5SmEzME81S2MrNVB6bldWZWwxS2pCOTQ3WTZ5bm8zdm5rZ01O?=
 =?utf-8?B?QlFTT3JhSGl6aUtQK01qb2k0YUZZQzlPQStHWll5NStzOWZsdmFveUNLaE40?=
 =?utf-8?B?WEhlZG5CUHRhclVpOURTSHpQNm14aUZKUndUWVZNa3dnOTlWc0xnWUNBMlBt?=
 =?utf-8?B?L3NGN0tzZnVmd1U3S2R3OHczM1pXUzBDcVdjSk1PZWFWemliMHloQ3BEMnFZ?=
 =?utf-8?B?cUtXMVlEMDQwZGpFeWowaWNWTnA3WkM4K1NhUjcydmYzOXlnREVxM1FhQm8r?=
 =?utf-8?B?YTMzbjRrTFh5c0tjNUs2bVR0dS9zRU9SdjZhY2k5ZzFXZlZRbE9YNHRraUJn?=
 =?utf-8?B?VEZlWC9mUXJaYURjK21RVlpVY3ZjOWtZSzgwdE9OM21idnNCbytqQ1VHTUhx?=
 =?utf-8?B?eE9UZ3Q3SDN1d2dtam94TkR0ZEN4bVREMGVvVVpHWEM5aGJWUW5STWpXSzc4?=
 =?utf-8?B?UXZUejBUUlhZTzllYVkzZ01ucVZkMmJrbTRybmN3ems3UUpmV3l5U2dOOXVj?=
 =?utf-8?B?Mkxobk5yeTFvQmNuQjVmQ0FkMm5zVkRHK1psNE9rRFdJM2lZYVduSTFmUTIz?=
 =?utf-8?B?SlljSFVSZFJTWS8vSHptTGlFb0tFR0ZqNzY3UzJZMDNGVVJQa08xZnBBck4y?=
 =?utf-8?B?MDloc2VuOUV5MExKbEt5WWQ5MnI3MVNBcDZZS2draWpHWXlsUXBucUNOMHBG?=
 =?utf-8?B?VHVieEpOZnY4ZkEvV1BNUzdvWXErMmFsejlDZVdHcG8ySm9vUEJKeHJNbUV0?=
 =?utf-8?B?ZFl2SjMrYjIzMVVmOGFqMmZUc2VvYkRiRjNoVWhVQitIeUhNK0JKUWNLTm5H?=
 =?utf-8?B?QXVldVdxa0FSSEZDQmd3RVFEQnYvL2ZidldZRGVTNm91dy9paklBS3ArTUlp?=
 =?utf-8?B?WTlCVTR2UGIyUGlVM05pTFlLOHlyd0RXeVZOV0RwOVNYcy9WUXZTc3c2dTdx?=
 =?utf-8?Q?ZUExspShqQbPOqxqJXOYur1SD3x6IM7Pivt5QnG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15FCF2744ADB66419726C2A2AE3581CB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd67d1e-50e3-4eee-faaf-08d956e6d06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 01:25:58.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YO+RXmjijkIb0AQOR5tLEiCCRx1jkNZ+mvlJ2khrW6nws43Y3Day6LmB1B38QzGM03zwxgvRrJ/WYonoWBmSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4523
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDIxOjE2IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBBdWcgMDQsIDIwMjEgYXQgMDE6MDM6NThBTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMS0wOC0wNCBhdCAxMDo1NyArMTAwMCwg
TmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gT24gV2VkLCAwNCBBdWcgMjAyMSwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gTm8uIFdoYXQgeW91IHByb3Bvc2UgaXMgdG8g
b3B0aW1pc2UgZm9yIGEgZnJpbmdlIGNhc2UsIHdoaWNoIHdlDQo+ID4gPiA+IGNhbm5vdA0KPiA+
ID4gPiBndWFyYW50ZWUgd2lsbCB3b3JrIGFueXdheS4gSSdkIG11Y2ggcmF0aGVyIG9wdGltaXNl
IGZvciB0aGUNCj4gPiA+ID4gY29tbW9uDQo+ID4gPiA+IGNhc2UsIHdoaWNoIGlzIHRoZSBvbmx5
IGNhc2Ugd2l0aCBwcmVkaWN0YWJsZSBzZW1hbnRpY3MuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4g
PiAicHJlZGljdGFibGUiPz8NCj4gPiA+IA0KPiA+ID4gQXMgSSB1bmRlcnN0YW5kIGl0IChJIGhh
dmVuJ3QgZXhhbWluZWQgdGhlIGNvZGUpIHRoZSBjdXJyZW50DQo+ID4gPiBzZW1hbnRpY3MNCj4g
PiA+IGluY2x1ZGVzOg0KPiA+ID4gwqBJZiBhIGZpbGUgaXMgb3BlbiBmb3IgcmVhZCwgc29tZSBv
dGhlciBjbGllbnQgY2hhbmdlZCB0aGUgZmlsZSwNCj4gPiA+IGFuZA0KPiA+ID4gdGhlDQo+ID4g
PiDCoCBmaWxlIGlzIHRoZW4gb3BlbmVkLCB0aGVuIHRoZSBzZWNvbmQgb3BlbiBtaWdodCBzZWUg
bmV3IGRhdGEsDQo+ID4gPiBvcg0KPiA+ID4gbWlnaHQNCj4gPiA+IMKgIHNlZSBvbGQgZGF0YSwg
ZGVwZW5kaW5nIG9uIHdoZXRoZXIgdGhlIHJlcXVlc3RlZCBkYXRhIGlzIHN0aWxsDQo+ID4gPiBp
bg0KPiA+ID4gwqAgY2FjaGUgb3Igbm90Lg0KPiA+ID4gDQo+ID4gPiBJIGZpbmQgdGhpcyB0byBi
ZSBsZXNzIHByZWRpY3RhYmxlIHRoYW4gdGhlIGVhc3ktdG8tdW5kZXJzdGFuZA0KPiA+ID4gc2Vt
YW50aWNzDQo+ID4gPiB0aGF0IEJydWNlIGhhcyBxdW90ZWQ6DQo+ID4gPiDCoCAtIHJldmFsaWRh
dGUgb24gZXZlcnkgb3BlbiwgZmx1c2ggb24gZXZlcnkgY2xvc2UNCj4gPiA+IA0KPiA+ID4gSSdt
IHN1Z2dlc3Rpbmcgd2Ugb3B0aW1pemUgZm9yIGZyaW5nZSBjYXNlcywgSSdtIHN1Z2dlc3Rpbmcg
d2UNCj4gPiA+IHByb3ZpZGUNCj4gPiA+IHNlbWFudGljcyB0aGF0IGFyZSBzaW1wbGUsIGRvY3Vt
ZW50YXRlZCwgYW5kIHByZWRpY3RhYmxlLg0KPiA+ID4gDQo+ID4gDQo+ID4gIlByZWRpY3RhYmxl
IiBob3c/DQo+ID4gDQo+ID4gVGhpcyBpcyBjYWNoZWQgSS9PLiBCeSBkZWZpbml0aW9uLCBpdCBp
cyBhbGxvd2VkIHRvIGRvIHRoaW5ncyBsaWtlDQo+ID4gcmVhZGFoZWFkLCB3cml0ZWJhY2sgY2Fj
aGluZywgbWV0YWRhdGEgY2FjaGluZy4gV2hhdCB5b3UncmUNCj4gPiBwcm9wb3NpbmcNCj4gPiBp
cyB0byBvcHRpbWlzZSBmb3IgYSBjYXNlIHRoYXQgYnJlYWtzIGFsbCBvZiB0aGUgYWJvdmUuIFdo
YXQncyB0aGUNCj4gPiBwb2ludD8gV2UgbWlnaHQganVzdCBhcyB3ZWxsIHRocm93IGluIHRoZSB0
b3dlbCBhbmQganVzdCBtYWtlDQo+ID4gdW5jYWNoZWQNCj4gPiBJL08gYW5kICdub2FjJyBtb3Vu
dHMgdGhlIGRlZmF1bHQuDQo+IA0KPiBJdCdzIHBvc3NpYmxlIHRvIHJldmFsaWRhdGUgb24gZXZl
cnkgb3BlbiBhbmQgYWxzbyBzdGlsbCBkbw0KPiByZWFkYWhlYWQsDQo+IHdyaXRlYmFjayBjYWNo
aW5nLCBhbmQgbWV0YWRhdGEgY2FjaGluZy4NCj4gDQoNClN1cmUuIEl0IGlzIGFsc28gcG9zc2li
bGUgdG8gcmV2YWxpZGF0ZSBvbiBldmVyeSByZWFkLCBldmVyeSB3cml0ZSBhbmQNCmV2ZXJ5IG1l
dGFkYXRhIG9wZXJhdGlvbi4gVGhhdCdzIG5vdCB0aGUgcG9pbnQuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
