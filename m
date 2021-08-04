Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EED3DF920
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhHDBEN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:04:13 -0400
Received: from mail-bn8nam08on2118.outbound.protection.outlook.com ([40.107.100.118]:48800
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232223AbhHDBEN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 21:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+0KOTiCBVzJxBi75Oy4vw0aklWpeF3xq3jRPrhVJULc4xjVnf4J5wg5th9PTjNVa+j+kCSWCHjoH+we3aq4nLEIFQj4aBGwyPIjuT6SWZT3MuUmXmxqyGkw1bPOnnH/cfs2XwiVAkBC3JdWAllG9xFNAEFLC7U6iqgZixGWZ82P4uZlcQY2TxxDa3pdQEzSp5EGuIWIRc6HubFbu+KpuNqdNmuvH++k7vRdA+qiYhqh/UzMrfpw+bPZM4Vg0We1Df9bwndJYELgF+wb2ynZb+tePMd2MGvE12c+nN9o02WkE0TvP7pir6bAvHlDHY/U+gcsoB8oVvMWrtsPgFIeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reUE429gmpB/Y4RSMnfwmXuqEfAUPFS+6zZ+QjWo7FE=;
 b=BcgxKP7hwJ8c0YjeqBbRYOz+3fnsdshp3ZXFLhhIj3wH9u4jNcDaPT3Y71Fb6TKNvGmHzrTaZxqPjHAUcnBm1s5gFbxUnF2l42J2yU5t+CgPoQDQ1cgBxPS0KkgfYUbQobOr+uPRlT07HVfMpkgnD1QmwXFZDS88mpD7UwuE8ewkOVE/RPx1yQ46N0+TWaKRCy6vEQ/ekHWpD+Mus/rvKT8MPid7P8OEANbzjHv1TJ7Ge9bi+8VLoxgW9/Vnu1zPLbn3iva9cd7AQuzFWXBUeyeyGqM0vkCz6xH8yZjuR0jMZzpzc5H05o2o1M1+bsTXmcD8xnkTIdSyBgJEZJasFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reUE429gmpB/Y4RSMnfwmXuqEfAUPFS+6zZ+QjWo7FE=;
 b=bM2HhAjwDZ72KsOtXZ879haQrqK1r2PGuJFBRUEUeyZim8rOX23lI8zpLDlq5zzBLUAfK5EDDbpqWWSAkq/l7o7wSUHx1Ogf6g3Xnc7h2C2JycuN2RqC2xqsmdJrPYHi++caozEOOYxeOX9hpISDyxFK7xUhEplCUIrJkEePuS0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3736.namprd13.prod.outlook.com (2603:10b6:610:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.12; Wed, 4 Aug
 2021 01:03:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 01:03:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WAgAAQJoCAAAG1gA==
Date:   Wed, 4 Aug 2021 01:03:58 +0000
Message-ID: <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>   ,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>       ,
 <20210803203051.GA3043@fieldses.org>   ,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>       ,
 <20210803213642.GA4042@fieldses.org>   ,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>       ,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name> ,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
         <162803867150.32159.9013174090922030713@noble.neil.brown.name>
In-Reply-To: <162803867150.32159.9013174090922030713@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9adbd38a-c7a5-4629-a14a-08d956e3bd70
x-ms-traffictypediagnostic: CH2PR13MB3736:
x-microsoft-antispam-prvs: <CH2PR13MB37364C38D233CB795B6B6C10B8F19@CH2PR13MB3736.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pl7ur+LOTO7+zA2OkiMfyb3xSEl2sXlfnHgYNYQeTvEUJ9Vbasx59AuTNTte/C59BjLedsixiW7KgskF5GX/VX/Xn2SRNxTtVEpTu26jlPNojGFv8hyMvCOwydXZWC+2ENPl4/SxNUZxSPvaxVCKmLuONp/2SWWztEODeoAKu+D60mc1RFxS75VIYwcR7DiqvzmsTplb0NvqGOjvmpMsGRWYkFpqYtY64AMbWINUsRSIlWMFan5301px6fr2+tQXn1c33yImIcUtz31lyUnBZoapskLg6V+i0OmqH2m4kX1/17mxBVxkgFaDcENMJyPP0XRvTHqq3yGzwlD/UWTXELobN48ey+0waN9Am988+hVhbmiqUyOYJjxQVLoQenIgiXXXN3iW7BofVPdHWS4UMw7X9Fnvh9miw0TOWLKt05uo8Ly0DyOiz2cqpc9zrjF/aPjiDs3YHxJBxnQ2nsClPFXoLc11TYyOSR3TqQ8/pXVbMV7va4BLaNtXezOBLOik60prk9SQvDModsUbA6DG424sKiRZl0sYgOPZrA2thNGo7ms9ay9cWStuK+p09++xFltCZqNTW94PoEln0tLHdpqEPnxL0dD6zFMvVBeZCUgGYu/mJoNtBfK7YTFH/+Nplv9HoQcGaBY7kkXvmY0WRkBaqz63GlUMVDqUxMj892arM77V8WcWOMjBLZ1ysyD+dA5D380PbdHyR/6HvqozUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39840400004)(366004)(6512007)(2906002)(83380400001)(38070700005)(316002)(5660300002)(66556008)(8936002)(36756003)(66946007)(186003)(66476007)(54906003)(71200400001)(66446008)(64756008)(8676002)(478600001)(2616005)(76116006)(86362001)(4326008)(26005)(6486002)(6506007)(38100700002)(122000001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1Znbk5SVlFncVZZRzFQS0V1eGo0RzNGa0dpNFNBQmJjdDFPUFR3c3gxVnZa?=
 =?utf-8?B?alkvRS9TbzZRWTVmUnVIdkVZcHZYaXFlNjRHYTVuOEdMaUdValkvWS95MUpV?=
 =?utf-8?B?cTRuYXcveGlGcEpicHhKaENaenBQK0NOeUg4VDJVZExOS2d0UmhIZ2hYSHJp?=
 =?utf-8?B?aEdlb1J5K1NZUlI4OGVPbldQQndBVnRwTGN3THJHeWRnL0hPeTdWMHUwNmFk?=
 =?utf-8?B?eC9kdmxIMHF0QklUWE5CYUl3K2EwWW1pZkxSVmhmY2J2dGx5Z0JwQVl3RUtL?=
 =?utf-8?B?WFNrdGxwc0JFOWh2c2RaQ2N6TlovNEpBMm5NY09lT2hCbGN0M2hPb0N3dUNY?=
 =?utf-8?B?TXNCRUUrb0s0cUVJaUIvYmhzRXNUQmFheGhMRDE5KzBtNnQ4bVRQVDdDUHZ4?=
 =?utf-8?B?YURheGVVVFcxdmo4RkVCSzJTQjN4NVRiTW5KblRnSFQ5ZFo4RzRCc1RvcFpF?=
 =?utf-8?B?NlNTRWlONEJrR3BtZ0xzT0MvMHRodFR0TTVHWmo4MGNPUDBRQW0yNVkrWjUw?=
 =?utf-8?B?NVhoY0llM2h2V3lnaUEyQzNmVTB3d2xyZXRKMnArT1NkLzdoVjNhdGhITlZ4?=
 =?utf-8?B?bDY3SWNhN21VZk5zbEhZZlQremFGTUIwWkhMOGhXcUN5bHVWUEhaSjJ1dmk1?=
 =?utf-8?B?Z1h1bUVzc2pqeHI1ZzdSNExxYmV2eDU0NWlWUlNVbEQ5cTZBT1l4d0MrS1dt?=
 =?utf-8?B?NlhkNEY2enJVWmFsSnQzQ3NxWlhoNEVUTys2Qk45UlBSeTJNRHBrOTNwR3Yw?=
 =?utf-8?B?dDJIZ216MUVNN1l5KzdaMEU5WkQzSktOc1VKdFFaRlgzRnBhT1M5Zjl3elRG?=
 =?utf-8?B?b2tEZWNnZHVnMUE3cmFlZzJJbDRHNHFzL2RuTHhtRzVmVHR6cWlWekRhNVBh?=
 =?utf-8?B?NHJ6R2xQVVBORGJYWE1TOGJEeEVmOGVoOWhtZDVOSDVMSDN5UFJLU2N1QU5Q?=
 =?utf-8?B?RUQ3UU5HNWVZN0xDQlZRZXhmTGY2VGUwZ08vZ3hUNy9OS2p2alpQMkpJSWhu?=
 =?utf-8?B?YXdjbzZNMU5UbXhHeW15bmY2UHBCQjJ0M1dEMDdienpkRWdkUGFvUHpvYnVQ?=
 =?utf-8?B?SnhCdnl0V2xReVlQamFRalZ2VFVHZnlwVkFqelBxaEtLcElzMGxrU1ZEZGtM?=
 =?utf-8?B?VXQvdHF3WlJWVFFCaDg4VHFnV3VSVi9kUFVNZ1VaQTZ0N3ZBV1NiVjVncHlB?=
 =?utf-8?B?VmZuVjluOHFVK21hM0lzb2d3U2RaeEFldnc2S3BQUEVBR0lBRnRCbFE4UmdZ?=
 =?utf-8?B?UDV6N21EQitkMFdwczl4SXJUVGR1MGM5OVd4bWxiR3RuSjhLY1dxRlVyTzZZ?=
 =?utf-8?B?K2xhTUJIc205SnJIVEI4VTgrZEk3V3dTcTVhRmh6VnB4aVFoRjAySnByaGFt?=
 =?utf-8?B?eUlERE13QnhlTG5LR1Q3SFNiNk43c08vblZmTkdpaEVhaWRNN0RlVmVHZWdU?=
 =?utf-8?B?NjhyazVRRVE1K0R6WGRXQnVDZy8wT0dkY3RYdlcwS0RCaDJqRVRRWmVjYmN1?=
 =?utf-8?B?c0piaVVXbmlzbGVTOHlEbHhaamdQbk9TajltVTFIMFZNWXRBVHBJN0w0NVoy?=
 =?utf-8?B?YWY5OXRRSTU4cExscDVWSXhJNGxLaklzSE1IKzFObGZGM2dueUNlRDJ0K2U1?=
 =?utf-8?B?ZFFsMlZrNGY3T0g1UUdqTktUUHlUMkJNaDNQK0k0NmlHekM4d3crZi9SY1ps?=
 =?utf-8?B?cWttN3dkbEJ2OUlSdWZpeEJaSEI4SjJhOFhnLzRWd3RqcmdRbTVwQmxjazhu?=
 =?utf-8?Q?TL/li2qBq2qjzEm8TxHAgNMmaAwC8JITJo5EpOh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <76E0F335AFB6644FA40BDFBA6C4FA3C5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adbd38a-c7a5-4629-a14a-08d956e3bd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 01:03:58.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZMjt2jBsBdyM0PoOo4SXsWmeJLFkz7qZ9B+i8FoCs4f5DBqdyDcuR5j247w2Eo6Q/3r0wUsCiMZyj5g0NzvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3736
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTA0IGF0IDEwOjU3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiANCj4gPiBOby4g
V2hhdCB5b3UgcHJvcG9zZSBpcyB0byBvcHRpbWlzZSBmb3IgYSBmcmluZ2UgY2FzZSwgd2hpY2gg
d2UNCj4gPiBjYW5ub3QNCj4gPiBndWFyYW50ZWUgd2lsbCB3b3JrIGFueXdheS4gSSdkIG11Y2gg
cmF0aGVyIG9wdGltaXNlIGZvciB0aGUgY29tbW9uDQo+ID4gY2FzZSwgd2hpY2ggaXMgdGhlIG9u
bHkgY2FzZSB3aXRoIHByZWRpY3RhYmxlIHNlbWFudGljcy4NCj4gPiANCj4gDQo+ICJwcmVkaWN0
YWJsZSI/Pw0KPiANCj4gQXMgSSB1bmRlcnN0YW5kIGl0IChJIGhhdmVuJ3QgZXhhbWluZWQgdGhl
IGNvZGUpIHRoZSBjdXJyZW50DQo+IHNlbWFudGljcw0KPiBpbmNsdWRlczoNCj4gwqBJZiBhIGZp
bGUgaXMgb3BlbiBmb3IgcmVhZCwgc29tZSBvdGhlciBjbGllbnQgY2hhbmdlZCB0aGUgZmlsZSwg
YW5kDQo+IHRoZQ0KPiDCoCBmaWxlIGlzIHRoZW4gb3BlbmVkLCB0aGVuIHRoZSBzZWNvbmQgb3Bl
biBtaWdodCBzZWUgbmV3IGRhdGEsIG9yDQo+IG1pZ2h0DQo+IMKgIHNlZSBvbGQgZGF0YSwgZGVw
ZW5kaW5nIG9uIHdoZXRoZXIgdGhlIHJlcXVlc3RlZCBkYXRhIGlzIHN0aWxsIGluDQo+IMKgIGNh
Y2hlIG9yIG5vdC4NCj4gDQo+IEkgZmluZCB0aGlzIHRvIGJlIGxlc3MgcHJlZGljdGFibGUgdGhh
biB0aGUgZWFzeS10by11bmRlcnN0YW5kDQo+IHNlbWFudGljcw0KPiB0aGF0IEJydWNlIGhhcyBx
dW90ZWQ6DQo+IMKgIC0gcmV2YWxpZGF0ZSBvbiBldmVyeSBvcGVuLCBmbHVzaCBvbiBldmVyeSBj
bG9zZQ0KPiANCj4gSSdtIHN1Z2dlc3Rpbmcgd2Ugb3B0aW1pemUgZm9yIGZyaW5nZSBjYXNlcywg
SSdtIHN1Z2dlc3Rpbmcgd2UNCj4gcHJvdmlkZQ0KPiBzZW1hbnRpY3MgdGhhdCBhcmUgc2ltcGxl
LCBkb2N1bWVudGF0ZWQsIGFuZCBwcmVkaWN0YWJsZS4NCj4gDQoNCiJQcmVkaWN0YWJsZSIgaG93
Pw0KDQpUaGlzIGlzIGNhY2hlZCBJL08uIEJ5IGRlZmluaXRpb24sIGl0IGlzIGFsbG93ZWQgdG8g
ZG8gdGhpbmdzIGxpa2UNCnJlYWRhaGVhZCwgd3JpdGViYWNrIGNhY2hpbmcsIG1ldGFkYXRhIGNh
Y2hpbmcuIFdoYXQgeW91J3JlIHByb3Bvc2luZw0KaXMgdG8gb3B0aW1pc2UgZm9yIGEgY2FzZSB0
aGF0IGJyZWFrcyBhbGwgb2YgdGhlIGFib3ZlLiBXaGF0J3MgdGhlDQpwb2ludD8gV2UgbWlnaHQg
anVzdCBhcyB3ZWxsIHRocm93IGluIHRoZSB0b3dlbCBhbmQganVzdCBtYWtlIHVuY2FjaGVkDQpJ
L08gYW5kICdub2FjJyBtb3VudHMgdGhlIGRlZmF1bHQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
