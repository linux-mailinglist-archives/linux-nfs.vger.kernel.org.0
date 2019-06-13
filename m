Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3604E43CDF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFMPiW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 11:38:22 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:62509 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfFMPiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 11:38:03 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 11:38:02 EDT
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 143252186
IronPort-PHdr: =?us-ascii?q?9a23=3AdhoxdBdBLQjDqpmuJEgNOHPplGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwGUD57D5adCjOzb++D7VGoM7IzJkUhKcYcEFn?=
 =?us-ascii?q?pnwd4TgxRmBceEDUPhK/u/dyM9EdhQfFps43H9LFRYCM/lIVDevy764A=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FOAQBBawJdhzIiL2hlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYE+UG11BAsoCoQMg0cDhTGJMIJXmgUDGDwBCAEBAQEBAQEBAQcBHw4?=
 =?us-ascii?q?CAQEChD4CF4JWOBMBAwEBBQEBAQEEAgIQAQEBCA0JCCkjAQuCeE05MgEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCFCQ5AQEBAxIREQw?=
 =?us-ascii?q?BATgPAgEGAhgCAiYCAgIwFRACBDWDAAGBagMdAY8Pjz89AmICC4EEKYheAQF?=
 =?us-ascii?q?wgTGCeQEBBYJHgjgYQQeBRwMGgQwoi24GgUE+gTiCNgcuPoJhBYE3JxeCc4J?=
 =?us-ascii?q?YjjWaMWoJAoIQhkeMfwYbgiaHAo4EjRuHGo84AgQCBAUCDgEBBYFmgXpyE4M?=
 =?us-ascii?q?ngg8ag1ZqiWlAATGBKY06gTEBgSABAQ?=
X-IPAS-Result: =?us-ascii?q?A2FOAQBBawJdhzIiL2hlHAEBAQQBAQcEAQGBZYE+UG11B?=
 =?us-ascii?q?AsoCoQMg0cDhTGJMIJXmgUDGDwBCAEBAQEBAQEBAQcBHw4CAQEChD4CF4JWO?=
 =?us-ascii?q?BMBAwEBBQEBAQEEAgIQAQEBCA0JCCkjAQuCeE05MgEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCFCQ5AQEBAxIREQwBATgPAgEGAhgCA?=
 =?us-ascii?q?iYCAgIwFRACBDWDAAGBagMdAY8Pjz89AmICC4EEKYheAQFwgTGCeQEBBYJHg?=
 =?us-ascii?q?jgYQQeBRwMGgQwoi24GgUE+gTiCNgcuPoJhBYE3JxeCc4JYjjWaMWoJAoIQh?=
 =?us-ascii?q?keMfwYbgiaHAo4EjRuHGo84AgQCBAUCDgEBBYFmgXpyE4Mngg8ag1ZqiWlAA?=
 =?us-ascii?q?TGBKY06gTEBgSABAQ?=
X-IronPort-AV: E=Sophos;i="5.63,369,1557205200"; 
   d="scan'208";a="143252186"
X-Utexas-Seen-Outbound: true
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by esa12.utexas.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 10:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UG9Hvn262t/SXEPSAfbNhKKo3ubRcYRTVROmmYfI9bA=;
 b=ie6c7lOVPU+Sdi0lWze2SyvPSGGGu73JTG/iBTd2+nTtQHjbZzmHKPYwUx8EGZihHyyu61DpwhiEYaSthYAfRe0DHnTeFziqlqmBrdRyFPsGI55DZE26JPMCyHXmWQsqoKV2oLdiPyIApuN1V+62gFZ3dcRJOgtRjdODJpgkdZc=
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com (10.167.109.15) by
 DM5PR0601MB3702.namprd06.prod.outlook.com (10.167.109.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 15:30:53 +0000
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::90e6:fd0b:3011:1ef8]) by DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::90e6:fd0b:3011:1ef8%3]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 15:30:53 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Can we setup pNFS with multiple DSs ?
Thread-Topic: Can we setup pNFS with multiple DSs ?
Thread-Index: AQHVIPQs/FvYNmACVUWcCwHAi3gNsqaX7PIAgAHLGwA=
Date:   Thu, 13 Jun 2019 15:30:53 +0000
Message-ID: <5e952e34-bc60-c63d-54c2-d0ae72301a86@math.utexas.edu>
References: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
 <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
In-Reply-To: <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To DM5PR0601MB3718.namprd06.prod.outlook.com (2603:10b6:4:7d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e19d7f4-b6d2-4aa5-3864-08d6f0141f20
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR0601MB3702;
x-ms-traffictypediagnostic: DM5PR0601MB3702:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR0601MB37027703C47DA1645B04AFFB83EF0@DM5PR0601MB3702.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(76176011)(6512007)(186003)(75432002)(88552002)(5660300002)(386003)(68736007)(478600001)(6506007)(2501003)(53546011)(6306002)(86362001)(5640700003)(102836004)(31696002)(8676002)(2906002)(52116002)(2351001)(26005)(446003)(11346002)(66476007)(66556008)(81166006)(64756008)(66446008)(81156014)(966005)(6436002)(66946007)(73956011)(2616005)(316002)(25786009)(14454004)(256004)(6486002)(3846002)(99286004)(6116002)(53936002)(229853002)(8936002)(305945005)(66066001)(786003)(7736002)(476003)(31686004)(486006)(6916009)(71190400001)(6246003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3702;H:DM5PR0601MB3718.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KVUO0tmt01WnFC/Tf5ZXXDia2jXKzgLLx3rA6fC+TvBlrfi2X01Dr+4E/FJox/CPaGz7YWCbM4U1e20YzUHKi53s4XQOZ4g4sL90RRPNYb+kD45aWon4e3ok2MoexbGDLN6zD1ixdRS7lLjv4LN0fRporZtNrfucG7If7Qg6Qyx5rRTOGTGJQwi2WyBpyOF4uoojjrVSXOYo8whL6C0Mj51+4DsUB+ssoRSM2x10G5wOOYzG3ocO4IK3l5N2C1MsnybA2pLQGUED/hwJDvl7uogI+EhMqAcynWyklrNvGZyEgPC0W4xO1gi0lR/RVJzUbILprNdSC4f5PLA+o6V6JtVcQTTHI+Um2LC9HcsY0WaZSyY0+wcltnaULDwCrCafiqqboZ79VoBbjYKmrijHnksMqVdnrHpEjVupWyMjJII=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF1F11ABB75364C8DA16BC050A5B373@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e19d7f4-b6d2-4aa5-3864-08d6f0141f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:30:53.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgoetz@math.utexas.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3702
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RXZlcnkgc28gb2Z0ZW4gSSBodW50IGZvciBkb2N1bWVudGF0aW9uIG9uIGhvdyB0byBzZXQgdXAg
cE5GUyBhbmQgY2FuIA0KbmV2ZXIgZmluZCBhbnl0aGluZy4gIENhbiBzb21lb25lIHBvaW50IG1l
IHRvIHNvbWV0aGluZyB0aGF0IEkgY2FuIHVzZSANCnRvIHRlc3QgdGhpcyBteXNlbGY/DQoNCk9u
IDYvMTIvMTkgNzowNyBBTSwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gSGkgSmlhbmNo
YW8sDQo+IA0KPiBPbiAxMiBKdW4gMjAxOSwgYXQgMzo1NSwgSmlhbmNoYW8gV2FuZyB3cm90ZToN
Cj4gDQo+PiBIaQ0KPj4NCj4+IEknbSB0cnlpbmcgdG8gc2V0dXAgYSBwTkZTIGV4cGVyaW1lbnQg
ZW52aXJvbm1lbnQuDQo+PiBBbmQgdGhpcyBpcyB3aGF0IEkgaGF2ZSBnb3QsDQo+PiBWTS0wIChE
UynCoMKgwqDCoMKgIHJ1bm5pbmcgYSBpc2NzaSB0YXJnZXQNCj4+IFZNLTEgKE1TKcKgwqDCoMKg
wqAgaW5pdGlhdG9yLCBtb3VudCBhIFhGUyBvbiB0aGUgZGV2aWNlLCBhbmQgZXhwb3J0IGl0IGJ5
IA0KPj4gTkZTIHdpdGggcG5mcyBvcHRpb24NCj4+IFZNLTIgKENsaWVudCnCoCBpbml0aWF0b3Is
IGJ1dCBub3QgbW91bnQsIHJ1bm5pbmcgYSBibGttYXBkDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1vdW50IHRoZSBzaGFyZWQgZGlyZWN0b3J5IG9mIFZNLTEgYnkgTkZTDQo+Pg0K
Pj4gQW5kIGl0IHNlbWVzIHRvIHdvcmsgd2VsbCBhcyB0aGUgbW91bnRzdGF0dXMNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTEFZT1VUR0VUOiAxNCAxNCAwIDM0NzIgMjc0NCAxIDEzODEgMTM4
NA0KPj4gwqDCoMKgwqBHRVRERVZJQ0VJTkZPOiAxIDEgMCAxOTYgMTQ4IDAgNSA1DQo+PiDCoMKg
wqDCoCBMQVlPVVRDT01NSVQ6IDggOCAwIDIzNTIgMTM2OCAwIDEyNTYgMTI1Nw0KPj4NCj4+IFRo
ZSBrZXJuZWwgdmVyc2lvbiBJIHVzZSBpcyA0LjE4LjE5Lg0KPj4NCj4+IEFuZCB3b3VsZCBhbnlv
bmUgcGxlYXNlIGhlbHAgdG8gY2xhcmlmeSBmb2xsb3dpbmcgcXVlc3Rpb25zID8NCj4+IDEuIENh
biBJIGludm9sdmUgbXVsdGlwbGUgRFNzIGhlcmUgPw0KPiANCj4gWWVwLCB5b3UgY2FuIGFkZCBh
IG5ldyBpU0NTSSBEUyB3aXRoIGFub3RoZXIgZmlsZXN5c3RlbSBhbmQga2VlcCB0aGUgc2FtZQ0K
PiBNRC7CoCBUaGUgcE5GUyBTQ1NJIGxheW91dCBoYXMgc3VwcG9ydCBmb3IgbXVsdGktZGV2aWNl
IGxheW91dHMsIGJ1dCBJIGRvbid0DQo+IHRoaW5rIGFueW9uZSBoYXMgcHV0IHRoZW0gdGhyb3Vn
aCB0aGUgcGFjZXMuDQo+IA0KPiBUaGUgc3dlZXQgc3BvdCBmb3IgcE5GUyBTQ1NJIGlzIGxhcmdl
LXNjYWxlIEZDIHdoZXJlIHRoZSBmYWJyaWMgYWxsb3dzIA0KPiBub2Rlcw0KPiBkaWZmZXJlbnQg
cGF0aHMgdGhyb3VnaCBkaWZmZXJlbnQgY29udHJvbGxlcnMuwqAgSSBleHBlY3QgdGhlIGRvLWl0
LXlvdXJzZWxmDQo+IHdpdGggaVNDU0kgdGFyZ2V0IG9uIGxpbnV4IHRvIGhhdmUgYSBiaXQgbW9y
ZSBsaW1pdGVkIHBlcmZvcm1hbmNlIGJlbmVmaXRzLg0KPiANCj4+IDIuIElzIHRoaXMgc3RhYmxl
IGVub3VnaCB0byB1c2UgaW4gcHJvZHVjdGlvbiA/IEhvdyBhYm91dCBlYXJsaWVyIA0KPj4gdmVy
c2lvbiwgZm9yIGV4YW1wbGUgNC4xNCA/DQo+IA0KPiBUZXN0IGl0IcKgIEl0IHdvdWxkIGJlIGdy
ZWF0IHRvIGhhdmUgbW9yZSB1c2Vycy4NCj4gDQo+IEl0IHdvdWxkIGFsc28gYmUgZ3JlYXQgdG8g
aGVhciBhYm91dCB5b3VyIHdvcmtsb2FkIGFuZCBpZiB0aGlzIHNob3dzIGFueQ0KPiBpbXByb3Zl
bWVudHMuDQo+IA0KPiBMYXN0IG5vdGUgLSB3aXRoIFNDU0kgbGF5b3V0cywgdGhlcmUncyBubyBu
ZWVkIHRvIHJ1biBibGttYXBkLsKgIFRoZSBrZXJuZWwNCj4gc2hvdWxkIGhhdmUgYWxsIHRoZSBp
bmZvIGl0IG5lZWRzIHRvIGZpbmQgdGhlIGNvcnJlY3QgU0NTSSBkZXZpY2VzLg0KPiANCj4gQmVu
DQo+Pj4gVGhpcyBtZXNzYWdlIGlzIGZyb20gYW4gZXh0ZXJuYWwgc2VuZGVyLiBMZWFybiBtb3Jl
IGFib3V0IHdoeSB0aGlzIDw8DQo+Pj4gbWF0dGVycyBhdCBodHRwczovL2xpbmtzLnV0ZXhhcy5l
ZHUvcnR5Y2xmLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PDwNCj4gDQo=
