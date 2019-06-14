Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DE4638E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFNQAy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 12:00:54 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:35338 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNQAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 12:00:53 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 12:00:53 EDT
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 151817032
IronPort-PHdr: =?us-ascii?q?9a23=3AQo55XBzrnk/pENDXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YhGN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZudBkr2MOzCaiUmHIJfSFJ19mr9PERIS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ErAADFwgNdhzYuL2hmHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgT1QbXIDBAsoCoQMYoJlA4UxiTGCV5hjgSQDGDwBCAEBAQE?=
 =?us-ascii?q?BAQEBAQcBHw4CAQECgUmCdQIXglk2Bw4BAwEBBQEBAQEEAgIQAQEBCA0JCCk?=
 =?us-ascii?q?jDIJ4TTkyAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQI?=
 =?us-ascii?q?UJDkBAQEDEhERDAEBNwEPAgEGAg4KAgImAgICMBUQAgQOJ4MAAYFqAx0BjgC?=
 =?us-ascii?q?PPz0CYgILgQQpiF4BAXCBMYJ5AQEFgkeCNBhBB4FHAwaBDCgBi20GgUE+gTi?=
 =?us-ascii?q?CPS4+gmEFgUiDIIJYjjmaNWoJAoIQhkiNAwYblzKUPI88AgQCBAUCDgEBBYF?=
 =?us-ascii?q?WB4IDchODJ4IPGoNWaolpQAExgSmOEQGBIAEB?=
X-IPAS-Result: =?us-ascii?q?A2ErAADFwgNdhzYuL2hmHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?T1QbXIDBAsoCoQMYoJlA4UxiTGCV5hjgSQDGDwBCAEBAQEBAQEBAQcBHw4CA?=
 =?us-ascii?q?QECgUmCdQIXglk2Bw4BAwEBBQEBAQEEAgIQAQEBCA0JCCkjDIJ4TTkyAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIUJDkBAQEDEhERD?=
 =?us-ascii?q?AEBNwEPAgEGAg4KAgImAgICMBUQAgQOJ4MAAYFqAx0BjgCPPz0CYgILgQQpi?=
 =?us-ascii?q?F4BAXCBMYJ5AQEFgkeCNBhBB4FHAwaBDCgBi20GgUE+gTiCPS4+gmEFgUiDI?=
 =?us-ascii?q?IJYjjmaNWoJAoIQhkiNAwYblzKUPI88AgQCBAUCDgEBBYFWB4IDchODJ4IPG?=
 =?us-ascii?q?oNWaolpQAExgSmOEQGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.63,373,1557205200"; 
   d="scan'208";a="151817032"
X-Utexas-Seen-Outbound: true
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by esa10.utexas.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2019 10:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwY9SWpGSLUJsPSIHPU5dYdI6wNyYi4eE/hqI+1LXro=;
 b=NYnIY17Cu9sNqW88R858a6+zNanoo9WsF6texkvEFSEYC8nxF/pPVJ46s84YGc5HgYXV+tKKhWo1EPnNM8UObgc88CBhmVnCMX14gG8K2/mxKqkjyov9DzCHux+jpuwYuBacRxyaBF/A1t7kMIm/JaNk9+GK+u3EpOu9qKIt9cY=
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com (10.167.109.15) by
 DM5PR0601MB3736.namprd06.prod.outlook.com (10.167.109.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Fri, 14 Jun 2019 15:53:44 +0000
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::90e6:fd0b:3011:1ef8]) by DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::90e6:fd0b:3011:1ef8%3]) with mapi id 15.20.1987.013; Fri, 14 Jun 2019
 15:53:44 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Can we setup pNFS with multiple DSs ?
Thread-Topic: Can we setup pNFS with multiple DSs ?
Thread-Index: AQHVIPQs/FvYNmACVUWcCwHAi3gNsqaX7PIAgAHLGwCAATfIgIAAYPAA
Date:   Fri, 14 Jun 2019 15:53:43 +0000
Message-ID: <39e3e544-2f6d-4cf1-8afe-593f7f6027a7@math.utexas.edu>
References: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
 <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
 <5e952e34-bc60-c63d-54c2-d0ae72301a86@math.utexas.edu>
 <30177AD3-E601-44AA-9BA7-434933ABD7B1@redhat.com>
In-Reply-To: <30177AD3-E601-44AA-9BA7-434933ABD7B1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:5:a8::16) To DM5PR0601MB3718.namprd06.prod.outlook.com
 (2603:10b6:4:7d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5526b95c-a1e9-4943-5fb9-08d6f0e07a6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0601MB3736;
x-ms-traffictypediagnostic: DM5PR0601MB3736:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR0601MB373618D4AB4BDE761A66189583EE0@DM5PR0601MB3736.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(52314003)(199004)(189003)(64756008)(6512007)(11346002)(6116002)(229853002)(4326008)(26005)(6306002)(76176011)(14444005)(6486002)(305945005)(3846002)(66066001)(256004)(66556008)(66476007)(7736002)(2906002)(6246003)(66446008)(66946007)(73956011)(71200400001)(71190400001)(8936002)(486006)(86362001)(786003)(966005)(31686004)(6436002)(81156014)(53936002)(316002)(31696002)(99286004)(81166006)(186003)(88552002)(14454004)(102836004)(476003)(25786009)(75432002)(6916009)(6506007)(2616005)(386003)(68736007)(5660300002)(52116002)(478600001)(53546011)(8676002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3736;H:DM5PR0601MB3718.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sxyM9nPwt10ilyqK+6v3T2iAwNh2QlneJ5ztoOYf3sf7q7ro630uGzyWjQ/X5hyObF10JsoaBN4zO12jx573w2aGG94Aw/XtEfxy+wWHeskW0nzqtDgM0wev2nQqewOavHlpXEpnmmBInwtCglZCKwj3ZANlaj4HoyeHuMs+Eq+Rt1S8Wi7g1rb9YVa5JvNEwX9ifYtJupHsR6gBMyjlvnhd5Z7eEiqaODjjjcnQcsknK1jbfEZXtKd2W8IufiO5Z7ve/LeTZZYjsNwUxDqdjSuy0XPxHB1HlbhGe2jjU+SbL2K3Rqesz/mkcbekdC9XCXW6SztWpVJG4Do0N/NvH4tzeaZPwi0PKPxRPPhpvW+gQSc2s3Zn9b1FK6mGeP1BTO8yAld1IFiazzDBXV8aimXwXDZs+CbuKLeLYp476dg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21E672582460FD4085FB31A3C1AD08D6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5526b95c-a1e9-4943-5fb9-08d6f0e07a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:53:43.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgoetz@math.utexas.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3736
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCk9uIDYvMTQvMTkgNTowNiBBTSwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gT24g
MTMgSnVuIDIwMTksIGF0IDExOjMwLCBHb2V0eiwgUGF0cmljayBHIHdyb3RlOg0KPiANCj4+IEV2
ZXJ5IHNvIG9mdGVuIEkgaHVudCBmb3IgZG9jdW1lbnRhdGlvbiBvbiBob3cgdG8gc2V0IHVwIHBO
RlMgYW5kIGNhbg0KPj4gbmV2ZXIgZmluZCBhbnl0aGluZy7CoCBDYW4gc29tZW9uZSBwb2ludCBt
ZSB0byBzb21ldGhpbmcgdGhhdCBJIGNhbiB1c2UNCj4+IHRvIHRlc3QgdGhpcyBteXNlbGY/DQo+
IA0KPiBUaGUgZmlsZSBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL25mcy9wbmZzLXNjc2ktc2Vy
dmVyLnR4dCBpbiB0aGUga2VybmVsDQo+IHNvdXJjZSB0cmVlIGlzIHByb2JhYmx5IHRoZSBiZXN0
IHNvdXJjZSBvZiBjdXJyZW50IGRvY3VtZW50YXRpb24sIGlmIHZlcnkNCj4gY29uY2lzZToNCj4g
DQo+ICDCoMKgwqAgcE5GUyBTQ1NJIGxheW91dCBzZXJ2ZXIgdXNlciBndWlkZQ0KPiAgwqDCoMKg
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+ICDCoMKgwqAgVGhpcyBk
b2N1bWVudCBkZXNjcmliZXMgc3VwcG9ydCBmb3IgcE5GUyBTQ1NJIGxheW91dHMgaW4gdGhlIExp
bnV4IE5GUw0KPiAgwqDCoMKgIHNlcnZlci7CoCBXaXRoIHBORlMgU0NTSSBsYXlvdXRzLCB0aGUg
TkZTIHNlcnZlciBhY3RzIGFzIE1ldGFkYXRhIA0KPiBTZXJ2ZXINCj4gIMKgwqDCoCAoTURTKSBm
b3IgcE5GUywgd2hpY2ggaW4gYWRkaXRpb24gdG8gaGFuZGxpbmcgYWxsIHRoZSBtZXRhZGF0YSAN
Cj4gYWNjZXNzIHRvIHRoZQ0KPiAgwqDCoMKgIE5GUyBleHBvcnQsIGFsc28gaGFuZHMgb3V0IGxh
eW91dHMgdG8gdGhlIGNsaWVudHMgc28gdGhhdCB0aGV5IGNhbiANCj4gZGlyZWN0bHkNCj4gIMKg
wqDCoCBhY2Nlc3MgdGhlIHVuZGVybHlpbmcgU0NTSSBMVU5zIHRoYXQgYXJlIHNoYXJlZCB3aXRo
IHRoZSBjbGllbnQuDQo+IA0KPiAgwqDCoMKgIFRvIHVzZSBwTkZTIFNDU0kgbGF5b3V0cyB3aXRo
IHdpdGggdGhlIExpbnV4IE5GUyBzZXJ2ZXIsIHRoZSANCj4gZXhwb3J0ZWQgZmlsZQ0KPiAgwqDC
oMKgIHN5c3RlbSBuZWVkcyB0byBzdXBwb3J0IHRoZSBwTkZTIFNDU0kgbGF5b3V0cyAoY3VycmVu
dGx5IGp1c3QgWEZTKSwgDQo+IGFuZCB0aGUNCj4gIMKgwqDCoCBmaWxlIHN5c3RlbSBtdXN0IHNp
dCBvbiBhIFNDU0kgTFVOIHRoYXQgaXMgYWNjZXNzaWJsZSB0byB0aGUgDQo+IGNsaWVudHMgaW4N
Cj4gIMKgwqDCoCBhZGRpdGlvbiB0byB0aGUgTURTLsKgIEFzIG9mIG5vdyB0aGUgZmlsZSBzeXN0
ZW0gbmVlZHMgdG8gc2l0IA0KPiBkaXJlY3RseSBvbiB0aGUNCj4gIMKgwqDCoCBleHBvcnRlZCBM
VU4sIHN0cmlwaW5nIG9yIGNvbmNhdGVuYXRpb24gb2YgTFVOcyBvbiB0aGUgTURTIGFuZCANCj4g
Y2xpZW50cyBpcw0KPiAgwqDCoMKgIG5vdCBzdXBwb3J0ZWQgeWV0Lg0KPiANCj4gIMKgwqDCoCBP
biBhIHNlcnZlciBidWlsdCB3aXRoIENPTkZJR19ORlNEX1NDU0ksIHRoZSBwTkZTIFNDU0kgdm9s
dW1lIA0KPiBzdXBwb3J0IGlzDQo+ICDCoMKgwqAgYXV0b21hdGljYWxseSBlbmFibGVkIGlmIHRo
ZSBmaWxlIHN5c3RlbSBpcyBleHBvcnRlZCB1c2luZyB0aGUgDQo+ICJwbmZzIiBvcHRpb24NCj4g
IMKgwqDCoCBhbmQgdGhlIHVuZGVybHlpbmcgU0NTSSBkZXZpY2Ugc3VwcG9ydCBwZXJzaXN0ZW50
IHJlc2VydmF0aW9ucy7CoCBPbiANCj4gdGhlDQo+ICDCoMKgwqAgY2xpZW50IG1ha2Ugc3VyZSB0
aGUga2VybmVsIGhhcyB0aGUgQ09ORklHX1BORlNfQkxPQ0sgb3B0aW9uIA0KPiBlbmFibGVkLCBh
bmQNCj4gIMKgwqDCoCB0aGUgZmlsZSBzeXN0ZW0gaXMgbW91bnRlZCB1c2luZyB0aGUgTkZTdjQu
MSBwcm90b2NvbCB2ZXJzaW9uIA0KPiAobW91bnQgLW8NCj4gIMKgwqDCoCB2ZXJzPTQuMSkuDQo+
IA0KPiBTaG91bGQgd2UgaGF2ZSBtb3JlIHRoYW4gdGhpcz8NCg0KSSBjYW4ndCB0ZWxsIGlmIHlv
dSdyZSBiZWluZyBmYWNldGlvdXMsIHdoaWNoIGlzIGEgYmFkIHNpZ24uICA8OikNCg0KWWVzLCBt
b3N0IGxpbnV4IGFkbWlucyBhcmUgcHJvYmFibHkgbm90IGdvaW5nIHRvIGluc3RhbGwgdGhlIGtl
cm5lbCANCnNvdXJjZSB0cmVlIGxvb2tpbmcgZm9yIGRvY3VtZW50YXRpb24uICBJIHBlcnNvbmFs
bHkgZmluZCB0aGF0IHN0ZXAgYnkgDQpzdGVwIGhvd3RvJ3MgKGV2ZW4gaWYgdGhleSBkb24ndCBt
YXRjaCBteSBleGFjdCB1c2UgY2FzZSkgYXJlIHRoZSBiZXN0IA0Kd2F5IHRvIGdldCBhbiBvdmVy
dmlldyBvZiBob3cgdG8gdXNlIGEgdG9vbCkuICBPZiBjb3Vyc2UgaXQncyBmcmVlIG9wZW4gDQpz
b3VyY2Ugc29mdHdhcmUsIHNvIHRoZXJlJ3Mgbm8gaW5jZW50aXZlIHRvIHdyaXRlIGRvY3VtZW50
YXRpb24sIGJ1dCANCkkndmUgYmVlbiBkb2luZyB0aGlzIGZvciBxdWl0ZSBzb21lIHRpbWUgYW5k
IChwb3N0IHRoZSBzZW5kbWFpbCBlcmEpLCANCnRoZXJlIGlzIGEgcHJldHR5IGNsZWFyIGNvcnJl
bGF0aW9uIGJldHdlZW4gdGhlIHN1Y2Nlc3Mgb2YgYW4gb3BlbiANCnNvdXJjZSBwcm9qZWN0IGFu
ZCB0aGUgcXVhbGl0eSBvZiB0aGUgZG9jdW1lbnRhdGlvbiB0aGF0IGl0IHByb3ZpZGVzLiANCkRq
YW5nbyAoZm9yIGV4YW1wbGUpIGlzIGEgcG9pbnRsZXNzIHdlYiBmcmFtZXdvcmssIGluIG15IG9w
aW5pb24sIGJ1dCANCmV4dHJlbWVseSBwb3B1bGFyIGJlY2F1c2UgdGhleSB0b29rIHRoZSB0aW1l
IHRvIHdyaXRlIGNsZWFyIGRvY3VtZW50YXRpb24uDQoNCkFueXdheSwgdGhhbmtzOyB0aGlzIGF0
IGxlYXN0IGdpdmVzIG1lIGEgc3RhcnRpbmcgcG9pbnQgZm9yIGV4cGVyaW1lbnRhdGlvbi4NCg0K
DQoNCj4gDQo+IEJlbg0KPj4+IFRoaXMgbWVzc2FnZSBpcyBmcm9tIGFuIGV4dGVybmFsIHNlbmRl
ci4gTGVhcm4gbW9yZSBhYm91dCB3aHkgdGhpcyA8PA0KPj4+IG1hdHRlcnMgYXQgaHR0cHM6Ly9s
aW5rcy51dGV4YXMuZWR1L3J0eWNsZi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDw8DQo+IA0K
