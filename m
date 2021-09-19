Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08F4410DC4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 01:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhISXVR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Sep 2021 19:21:17 -0400
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com ([40.107.237.135]:31841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229517AbhISXVR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 19 Sep 2021 19:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJZ947Ke2sKygYLPlGDjjLn/j8sdJ41YU4Q7k/JlvoaNNsBwW54A0Z69Mxu5fF2KNgvq62ZdO88aKRVLHh9ib9Q4vPaQJr0JkQIR2ikTHs8jhUweIonHH4w0T7YaVAc1t8zfaT8gn5JN+oXvXChFKN4diz+2W8p8Cd2itxWoXk83L9sOf1fZIGleA5jf43dHNIBHslb2HiWWIUNX9gbXWxsuuwc7ZqbTTQy4Ig8owmtB0Ie2RnX1erKwl4PRtrfUugMVyi1WcD3q7elQ/EpmlJQg59QT+2/VpTMK/A1aw9AsU4z6t5c0EDE/Om/B2wtShWQj0j0veFuqPUwOORVbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jqeeibM8cmP6SVp4RwBjlGJDBwgKX6dc/0pAQPST5hM=;
 b=Xjfu+Giy5BvhuDrf6DD8sL41Sj4ayUW6z0I3INAAShtUK5NV26yAf2sK1YbPsHTE1Z/n2dC4i72OHi78oXBJv2hRGmiJJyuHMM/F84P9QFd7Jo0PedhO4zrFV15COknNkDp/RqKx9zIziEJr7KLqkTeJUUJ0IQRCJf+vPXpTgfaPvOr4QR0PcgN7I6NivLNnYf3gUxKEeEKRebCeRitOZulpGVNN9b5BmwPDaYgAji1P1eti8bIF7t5+oCgKM28SFeURo/YROLiZQHgIc7dpSoyMxRADDEWH6buS9j2JKye927JbvAib7anMnS/cPwKNvqOFjzEsOJS5CIqGHOYtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqeeibM8cmP6SVp4RwBjlGJDBwgKX6dc/0pAQPST5hM=;
 b=btGzrwYXYwVetCB6cDqx0wfgLGilq/OLEE6rxvgIZrxP9cb4iNskaOqFE5BpZfVcTqcpMZKHlIXFL5VxXY0XcXU0LpUn8rLj1ApQQ8o6Bjq3YBDDMLuArOrXUxUqMlyAGlUqEXozmh+VlZAw+mJ+CoG7OP2ISFa7TR2qzpevcSY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5169.namprd13.prod.outlook.com (2603:10b6:610:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5; Sun, 19 Sep
 2021 23:19:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.013; Sun, 19 Sep 2021
 23:19:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fcA3+DfY3OUmOk0QnMZuIQ6tRAXuAgFtTrwCAAASBgA==
Date:   Sun, 19 Sep 2021 23:19:46 +0000
Message-ID: <7bfcfea962bc88eca24fb6fdfcaa9ef47138e531.camel@hammerspace.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
         <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
         <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
In-Reply-To: <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44a35606-bf4b-4dd8-e538-08d97bc3f86a
x-ms-traffictypediagnostic: CH0PR13MB5169:
x-microsoft-antispam-prvs: <CH0PR13MB51695646AADE4CC2D1C7B0B1B8DF9@CH0PR13MB5169.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMjtgygpdvhvoy2jY9Pht3V1fEf4/u6I/Ey1cqk9s57E+yDRRUyEencm4hqPTOxh8T02xwv5xds8XN9pu497k50vz2HIVUD47i0vNITI2Pa/cdxfTYqUlPHx4UYYXZVcIdr0QKf88W+XVHFoSU4hO5C3lgYoNEqCuKwUdUw99EVx/JzEYORv+sS7pjzujsd/1dSxtp9WpRXeE23gzgxVPUi5a1eFP19uycpDSUL62+bvh53Loa4wjn4Kix+q5VDnTv8UH//zShPmX2Bv58cquZSu0HykrOr2gY7LqAtqrfcKk9foCVrPFyK+t+7cvyfkIWBE9HDMF3Lo3cqeAwqh/YKech6id6B8oV5qBDN0H7Z3xBFYSRYRkVSLR5TVgv5pYOGNwPNKfTgpfBvdvfWOyK7hYygtG9R5KwP9c5EOCa7rPiEa2EmiTt3VkFQsLj9NYMgA9G2Ckg0K+B5QSso6Erob1evVWmJ5PlX1/7rwCgVW685fZ5bKgZsVzap81f2k8AJ7xur3GN7WMyKWIRkp4doChFgqjTCOGDggVqxGeZVCgcil7OiuT7jugQ/Xjikt1SUtvvr7csV+ay6GMQ+CYt2vt/03QRj9UDEeMnH4DkI90xB22TkQRpVXbAFqAcAuIJ8DEk9pM3XPtpSY0QZdfojT1XDqfr1N2Zj3nG2iMNU7WL4dV5tJRnn8b3y/Z0tP7S899uBT2E365APG9pG5CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39830400003)(8676002)(6506007)(53546011)(38100700002)(316002)(71200400001)(5660300002)(76116006)(2616005)(26005)(66946007)(83380400001)(66476007)(478600001)(6486002)(66556008)(64756008)(66446008)(6916009)(186003)(6512007)(3480700007)(2906002)(122000001)(38070700005)(86362001)(8936002)(4326008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVBiREpiWGgzQ2ltbWtRNWNINUhGTGZPS0lHSGZaMlMxa013ZXFKdE9wOVov?=
 =?utf-8?B?WVRUUUMzSmxUcVBzMElHenVoWlhncjBpN0FzdHFCZGliK1NSK0VMeHpURmZS?=
 =?utf-8?B?cko0eUZNMzBKbjdOZjB4ZURiNTBpVk5OL3Q1TXQxOHAxUi8xMFQ2MmRxMWN5?=
 =?utf-8?B?MkhMei9qQmlMOThwSVF2MjN0dXZFMWpzc2haQzNCaVY1R0hHREcydmFhRGRL?=
 =?utf-8?B?Zk1seHVaTE9keHhRRUFrK3lXZklveFh1NWJBZzFCSVB5akdsaGNvN3NmRksr?=
 =?utf-8?B?eU1pbXFYbEc4RldoUjBXSWF2akVvL3NIK29BOE9aeEdQZG1nSzRnZWo3NUpW?=
 =?utf-8?B?OURCV1AxMGc1VlFFSzZtNzNiRGRmTERlc1lQMG9jdmlZSDFxZHV1OVZRbVdj?=
 =?utf-8?B?L1pGWGU0VUkwUXBVTXc0K211bW9FWnpXL3kvelZLbWhzMHM3QWI2emh4bnRT?=
 =?utf-8?B?Zzk3NnZ0czhDcE9lUUVjZGdXY2NHc0ZSRWlHc0wwdlZ4czNOTXdxeXJSSUQr?=
 =?utf-8?B?TVd4LzVjbHBLT0ptR0NCeVZzMjFUcjhoeW1kVENydGlDdDV5d0pFWE9jZjds?=
 =?utf-8?B?M3ZwTkJ6Nk5YcnVRZDNnU3ZndlRqaFVxdERIbEpEQ2dCVkVyK01RQ2xWWVgy?=
 =?utf-8?B?Yi8yMzB4cENXaW5WRUxvWTNCcjEzdnVrOGdZUlpwTkxQSjhtOFV2SzUwZ1VI?=
 =?utf-8?B?WjN4Y05XeVc5QldZSmpGVjVnZHZpZVdFRFFZRCtIaDVoWmNpMlVQa1VTV2pV?=
 =?utf-8?B?UmpYTnB6ek5NeHdzdnV0YlNPaTg3NGMwTml1MGcvOC9yR2lEc21WRjl1ZnFl?=
 =?utf-8?B?dzczZ0xUcG16NEl5S0xDU1dvSFhEaEZLbjBtWmxvaFRuRlVGd3dSOGFyZG1j?=
 =?utf-8?B?MEdyL3ZwVTRqMnl0TnhZN2dyY2psZGlCK0NobEJXMFo4My9uaERueEdNTUlO?=
 =?utf-8?B?ZG13emJJMFZsSURpVjQxUUdhMDRnbGVyTXN1VDRLeGpGQy96VTBKMTJjSHoy?=
 =?utf-8?B?bm1sdDFkMGhVSkUyMXFqRVR0OTZXSVhhcTE2aFNyc1ArRGxFY3crZ0V3TTNE?=
 =?utf-8?B?OFlCSWlxOXhGVHR0SFV4d0hmTzBvcHBFTDh0RGlSS2FHRTdHZitNaUFxUkQ4?=
 =?utf-8?B?SDdWWlBtQkpuVThwVkZZSjBSWWZQYUJMcGhRUXZGeVV6dkNEREhVai9KMTdC?=
 =?utf-8?B?WWQyMndEVWY1bjdLYXJNUG1qU0E4cjFhNERHTjJmeVd1R1Mya0NBMkdBbDh4?=
 =?utf-8?B?OWVMTXROUjNFT0hORlQ2QlpFZ0lheXdIb1U5K0FVempENmZLdFIzRTY5d1RF?=
 =?utf-8?B?TE1mL2N0MS9nMDBySy9OOFZTWWZUeS9KVnFtcHNDcFRKWXR5WUx3ZmoxblU1?=
 =?utf-8?B?U252RnQybVFxc2h0Qm45YitlTVQ3NmdOVXV6cUJadktlOWowTEdVTzlQcnRw?=
 =?utf-8?B?VnhtT2ZGNXJmMk1vVkpSRWlYU3lnN2JTZVlKd3F3eERTZExnMU1oNnlLM2dG?=
 =?utf-8?B?NllsbkE2cDZVb1Zud3h0MFBtai90ank2VE5uZmVZYVVEYlVjamJqMk1oVURl?=
 =?utf-8?B?NWZHZFJyQUdqV2I4ODd0WmpUMEd6aVVoMmFXSXdrMm9Pa3loaXFySG0wcUVP?=
 =?utf-8?B?UnZrMWJmR3JFdnJMRThqckVIZ2RlQUJsSlhBSHZiOS9IK3JLaVJrcjZxeTNm?=
 =?utf-8?B?Y1l0alRZRWUxL2sxb1ZiYkpjckw5VjdTTVU1aDNvemFaYXpKd2dpYmJoRmU2?=
 =?utf-8?Q?QWUFT70hJmNlV6cMJCxoCixVVOG1c1qpyFvfHZV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A5CF54E76E16045914D38CDE3A5DEC3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a35606-bf4b-4dd8-e538-08d97bc3f86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2021 23:19:46.2098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OlI0frvXYEWKZfXWw06woQvpVjlmmD4k49RV3+x/8Fu2QJ7V/64v/7xbynrERt4fU/22yH1bE6lus3QIpe8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5169
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTA5LTE5IGF0IDIzOjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdWwgMjMsIDIwMjEsIGF0IDQ6MjQgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJp
LCAyMDIxLTA3LTIzIGF0IDIwOjEyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiBIaS0NCj4gPiA+IA0KPiA+ID4gSSBub3RpY2VkIHJlY2VudGx5IHRoYXQgZ2VuZXJpYy8wNzUs
IGdlbmVyaWMvMTEyLCBhbmQgZ2VuZXJpYy8xMjcNCj4gPiA+IHdlcmUNCj4gPiA+IGZhaWxpbmcg
aW50ZXJtaXR0ZW50bHkgb24gTkZTdjMgbW91bnRzLiBBbGwgdGhyZWUgb2YgdGhlc2UgdGVzdHMN
Cj4gPiA+IGFyZQ0KPiA+ID4gYmFzZWQgb24gZnN4Lg0KPiA+ID4gDQo+ID4gPiAiZ2l0IGJpc2Vj
dCIgbGFuZGVkIG9uIHRoaXMgY29tbWl0Og0KPiA+ID4gDQo+ID4gPiA3YjI0ZGFjZjA4NDAgKCJO
RlM6IEFub3RoZXIgaW5vZGUgcmV2YWxpZGF0aW9uIGltcHJvdmVtZW50IikNCj4gPiA+IA0KPiA+
ID4gQWZ0ZXIgcmV2ZXJ0aW5nIDdiMjRkYWNmMDg0MCBvbiB2NS4xNC1yYzEsIEkgY2FuIG5vIGxv
bmdlcg0KPiA+ID4gcmVwcm9kdWNlDQo+ID4gPiB0aGUgdGVzdCBmYWlsdXJlcy4NCj4gPiA+IA0K
PiA+ID4gDQo+ID4gDQo+ID4gU28geW91IGFyZSBzZWVpbmcgZmlsZSBtZXRhZGF0YSB1cGRhdGVz
IHRoYXQgZW5kIHVwIG5vdCBjaGFuZ2luZw0KPiA+IHRoZQ0KPiA+IGN0aW1lPw0KPiANCj4gQXMg
ZmFyIGFzIEkgY2FuIHRlbGwsIGEgV1JJVEUgYW5kIHR3byBTRVRBVFRScyBhcmUgaGFwcGVuaW5n
IGluDQo+IHNlcXVlbmNlIHRvIHRoZSBzYW1lIGZpbGUgZHVyaW5nIHRoZSBzYW1lIGppZmZ5LiBU
aGUgV1JJVEUgZG9lcw0KPiBub3QgcmVwb3J0IHByZS9wb3N0IGF0dHJpYnV0ZXMsIGJ1dCB0aGUg
U0VUQVRUUnMgZG8uIFRoZSByZXBvcnRlZA0KPiBwcmUtIGFuZCBwb3N0LSBtdGltZSBhbmQgY3Rp
bWUgYXJlIGFsbCB0aGUgc2FtZSB2YWx1ZSBmb3IgYm90aA0KPiBTRVRBVFRScywgSSBiZWxpZXZl
IGR1ZSB0byB0aW1lc3RhbXBfdHJ1bmNhdGUoKS4NCj4gDQo+IE15IHRoZW9yeSBpcyB0aGF0IHBl
cnNpc3RlbnQtc3RvcmFnZS1iYWNrZWQgZmlsZXN5c3RlbXMgc2VlbSB0bw0KPiBnbyBzbG93IGVu
b3VnaCB0aGF0IGl0IGRvZXNuJ3QgYmVjb21lIGEgc2lnbmlmaWNhbnQgcHJvYmxlbS4gQnV0DQo+
IHdpdGggdG1wZnMsIHRoaXMgY2FuIGhhcHBlbiBvZnRlbiBlbm91Z2ggdGhhdCB0aGUgY2xpZW50
IGdldHMNCj4gY29uZnVzZWQuIEFuZCBJIGNhbiBtYWtlIHRoZSBwcm9ibGVtIHVucmVwcm9kdWNh
YmxlIGlmIEkgZW5hYmxlDQo+IGVub3VnaCBkZWJ1Z2dpbmcgcGFyYXBoZXJuYWxpYSBvbiB0aGUg
c2VydmVyIHRvIHNsb3cgaXQgZG93bi4NCj4gDQo+IEknbSBub3QgZXhhY3RseSBzdXJlIGhvdyB0
aGUgY2xpZW50IGJlY29tZXMgY29uZnVzZWQgYnkgdGhpcw0KPiBiZWhhdmlvciwgYnV0IGZzeCBy
ZXBvcnRzIGEgc3RhbGUgc2l6ZSB2YWx1ZSwgb3IgaXQgY2FuIGhpdCBhDQo+IGJ1cyBlcnJvci4g
SSdtIHNlZWluZyBhdCBsZWFzdCBmb3VyIG9mIHRoZSBmc3gtYmFzZWQgeGZzIHRlc3RzDQo+IGZh
aWwgaW50ZXJtaXR0ZW50bHkuDQo+IA0KDQpJdCByZWFsbHkgaXNuJ3QgYSBjbGllbnQgcHJvYmxl
bSB0aGVuLiBJZiB0aGUgc2VydmVyIGlzIGZhaWxpbmcgdG8NCnVwZGF0ZSB0aGUgdGltZXN0YW1w
cywgdGhlbiB5b3UgZ2V0cyB3aGF0IHlvdSBnZXRzLg0KDQpUaGlzIGlzIG9uZSBvZiB0aGUgcmVh
c29ucyB3aHkgd2UgbmVlZCB0byBtb3ZlIG9uIGZyb20gTkZTdjMuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
