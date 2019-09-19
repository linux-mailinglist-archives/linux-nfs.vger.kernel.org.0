Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD34DB81CD
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbfISTvv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 15:51:51 -0400
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:17919
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404506AbfISTvu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 15:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky8DVpOnDvh85Y71koP6dneAIjE3GwK/bVYbzuNiobnf1UhUeClCCGEkfhjNk7OlydUz/19ix2RP/ks/QMlWtfweCK8/1kW2IlSnAlx+swgiSVZGZjv1J5q8zleg6XfN0MPZ87M/+OXrUum4/qePV5kdsUtdkPfCPCuyOTQ+2yqAY7bF4QLCZlzvzU8/+tN+jGroUg6ndKNba0XOKRvXW2Xb+WcVH+WgSGTOLw1qmWfYxzUl/IcgbCpvPE+7wSuGR6cFFbyQ2bMv38KAsmKsl77lV9nmuL6571DoBkE4VnVwrM8g1voRNF67Xb961BJA5OliAxmtmgpiEQEiLcEJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qDOVB1Nw5GPNrZvYqRJO67Bu5ApH9PhXQ44Ib0tGHs=;
 b=jjLVrwQhYfXicA5qjrk5ttGlzcRdsQ3+AkwpI3xgivsbLYFE28BX2fpln8DHx7I7nTMqnOpI1OjKQZ1oaf2hW/SuyFM1Q7XP0Oqd9tqBmIWjAVrWChse0uUFGHXi4d8NV8/4aOhR5c1V3jWSN6iblFtl0Tmf5tnZB84TSBopHSlfGYV+IJwO0ubs7EEQFfZJCXf/Dsw4S1R1/uAa/ygOL6+jBuZ0Jo7xg8iS86NH81x6qnHuOzWfPmbryfKuKFO7q3hX/pyG85CDqRY9aync6SJ9IYD9yRJkkxLp8zeKAdRezeQcRDKbJ58peh/y0E9e8EH23tIEKpV7gwJvR3MOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qDOVB1Nw5GPNrZvYqRJO67Bu5ApH9PhXQ44Ib0tGHs=;
 b=b7T2aTLZ0sgtaSJ/9lgREiqRrmHQhOl9ceyY7mGypU7iF9mzdsTl3k5rotKNejZnUxtLVKjn/gi4DTjUhEoeYta0+xlEO8dNOuKp+olDR4JZTE/SfCHrIY1PdWVP0BAOeqsNAgRrsdKQKaF3y2eKJlW++fxX3WysK8Xvzux1jgc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1675.namprd13.prod.outlook.com (10.171.160.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.12; Thu, 19 Sep 2019 19:51:46 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 19:51:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Topic: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Index: AQHVbwMN/jYKfSJ+jEOCnZqjx88626czK6CAgAA1K4CAAAiCAA==
Date:   Thu, 19 Sep 2019 19:51:46 +0000
Message-ID: <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
         <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
         <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
         <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
         <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
In-Reply-To: <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d413fe-6db8-406a-4c0a-08d73d3acdd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1675;
x-ms-traffictypediagnostic: DM5PR13MB1675:
x-microsoft-antispam-prvs: <DM5PR13MB167502FC952870262CB57382B8890@DM5PR13MB1675.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39830400003)(346002)(376002)(366004)(189003)(199004)(3846002)(6486002)(14454004)(86362001)(186003)(81166006)(36756003)(6116002)(2616005)(102836004)(71200400001)(71190400001)(76176011)(81156014)(476003)(99286004)(8676002)(229853002)(11346002)(53546011)(25786009)(6506007)(26005)(6512007)(2501003)(110136005)(7736002)(305945005)(118296001)(486006)(446003)(8936002)(6436002)(91956017)(66066001)(478600001)(316002)(66476007)(6246003)(66446008)(64756008)(76116006)(66556008)(5660300002)(66946007)(2906002)(256004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1675;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IzC1APzICOwpmiW+BsR239oQUWJWehrIhrt/k/WR9aVJhsMwQH21QHcCSQ2uVlEjYhINTh+OydFrqSWy0Q+mlAR10SY05j6b0cX/zN9pb0VivXo+pPPrMNOKwB8pnYRQHXsN12CTaa7fuXCsVLqO2EKtnRzmuPPUjLUIRJVAVhp00nwoUTx3GBkpkC45e8TkVrLGqegKxF96hhS0qBms+X9zYOyWF1b+cKAwgls7T06R5r3odg1URZi0PG+KQvfvk/PqZeTOh+zex79dCrxkfKKD8TJuBfZdhJBijiJuHQr2YzzRaWafl7cRQQc5Klxx4Q2C7wpRUv+MiVMIRDDDEi6F1vrDV0meGRe1DjnB5a6ebJD071Lg5i9NhKVzwBoSCU6St93Et8cA2WYPBP0PnlM8K0GzK0dpF2SUStCdXrU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B49BF21935AB44894FFE8BED3FF096D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d413fe-6db8-406a-4c0a-08d73d3acdd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 19:51:46.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3WlvkaXf86YD0/HwPrAMUNtwZFb2XZ4A+A8EiB8gJYE1LYVEPCqkm1N+27+p1r/K3yoSio7SR2qYRh/SeN3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1675
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDIyOjIxICswMzAwLCBBbGtpcyBHZW9yZ29wb3Vsb3Mgd3Jv
dGU6DQo+IE9uIDkvMTkvMTkgNzoxMSBQTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IE5v
LiBJdCBpcyBub3QgYSBwcm9ibGVtLCBiZWNhdXNlIG5mcy11dGlscyBkZWZhdWx0cyB0byB1c2lu
ZyBUQ1ANCj4gPiBtb3VudHMuIEZyYWdtZW50YXRpb24gaXMgb25seSBhIHByb2JsZW0gd2l0aCBV
RFAsIGFuZCB3ZSBzdG9wcGVkDQo+ID4gZGVmYXVsdGluZyB0byB0aGF0IGFsbW9zdCAyIGRlY2Fk
ZXMgYWdvLg0KPiA+IA0KPiA+IEhvd2V2ZXIgaXQgbWF5IHdlbGwgYmUgdGhhdCBrbGliYyBpcyBz
dGlsbCBkZWZhdWx0aW5nIHRvIHVzaW5nIFVEUCwNCj4gPiBpbg0KPiA+IHdoaWNoIGNhc2UgaXQg
c2hvdWxkIGJlIGZpeGVkLiBUaGVyZSBhcmUgbWFqb3IgTGludXggZGlzdHJvcyBvdXQNCj4gPiB0
aGVyZQ0KPiA+IHRvZGF5IHRoYXQgZG9uJ3QgZXZlbiBjb21waWxlIGluIHN1cHBvcnQgZm9yIE5G
UyBvdmVyIFVEUCBhbnkgbW9yZS4NCj4gDQo+IEkgaGF2ZW4ndCB0ZXN0ZWQgd2l0aCBVRFAgYXQg
YWxsOyB0aGUgcHJvYmxlbSB3YXMgd2l0aCBUQ1AuDQo+IEkgc2F3IHRoZSBwcm9ibGVtIGluIGts
aWJjIG5mc21vdW50IHdpdGggVENQICsgTkZTIDMsDQo+IGFuZCBpbiBgbW91bnQgLXQgbmZzIC1v
IHRpbWVvPTcgc2VydmVyOi9zaGFyZSAvbW50YCB3aXRoIFRDUCArIE5GUw0KPiA0LjIuDQo+IA0K
PiBTdGVwcyB0byByZXByb2R1Y2U6DQo+IDEpIENvbm5lY3Qgc2VydmVyIDw9PiBjbGllbnQgYXQg
MTAgb3IgMTAwIE1icHMuDQo+IEdpZ2FiaXQgaXMgYWxzbyAibGVzcyBzbmFwcHkiIGJ1dCBpdCdz
IGxlc3Mgb2J2aW91cyB0aGVyZS4NCj4gRm9yIHJlbGlhYmxlIHJlc3VsdHMsIEkgbWFkZSBzdXJl
IHRoYXQgc2VydmVyL2NsaWVudC9uZXR3b3JrIGRpZG4ndA0KPiBoYXZlIA0KPiBhbnkgb3RoZXIg
bG9hZCBhdCBhbGwuDQo+IA0KPiAyKSBTZXJ2ZXI6DQo+IGVjaG8gJy9zcnYgKihybyxhc3luYyxu
b19zdWJ0cmVlX2NoZWNrKScgPj4gL2V0Yy9leHBvcnRzDQo+IGV4cG9ydGZzIC1yYQ0KPiB0cnVu
Y2F0ZSAtcyAxMEcgL3Nydi8xMEcuZmlsZQ0KPiBUaGUgc3BhcnNlIGZpbGUgZW5zdXJlcyB0aGF0
IGRpc2sgSU8gYmFuZHdpZHRoIGlzbid0IGFuIGlzc3VlLg0KPiANCj4gMykgQ2xpZW50Og0KPiBt
b3VudCAtdCBuZnMgLW8gdGltZW89NyAxOTIuMTY4LjEuMTEyOi9zcnYgL21udA0KPiBkZCBpZj0v
bW50LzEwRy5maWxlIG9mPS9kZXYvbnVsbCBzdGF0dXM9cHJvZ3Jlc3MNCj4gDQo+IDQpIFJlc3Vs
dDoNCj4gZGQgdGhlcmUgc3RhcnRzIHdpdGggMTEuMiBNQi9zZWMsIHdoaWNoIGlzIGZpbmUvZXhw
ZWN0ZWQsDQo+IGFuZCBpdCBzbG93bHkgZHJvcHMgdG8gMiBNQi9zZWMgYWZ0ZXIgYSB3aGlsZSwN
Cj4gaXQgbGFncywgb21pdHRpbmcgc29tZSBzZWNvbmRzIGluIGl0cyBvdXRwdXQgbGluZSwNCj4g
ZS5nLiA1MDc1MTA3ODQgYnl0ZXMgKDUwOCBNQiwgNDg0IE1pQikgY29waWVkLCAxODYgcywgMiw3
IE1CL3NeQywNCj4gYXQgd2hpY2ggcG9pbnQgIkN0cmwrQyIgbmVlZHMgMzArIHNlY29uZHMgdG8g
c3RvcCBkZCwNCj4gYmVjYXVzZSBvZiBJTyB3YWl0aW5nIGV0Yy4NCj4gDQo+IEluIGFub3RoZXIg
dGVybWluYWwgdGFiLCBgZG1lc2cgLXdgIGlzIGZ1bGwgb2YgdGhlc2U6DQo+IFsgIDMxNi40MDQy
NTBdIG5mczogc2VydmVyIDE5Mi4xNjguMS4xMTIgbm90IHJlc3BvbmRpbmcsIHN0aWxsIHRyeWlu
Zw0KPiBbICAzMTYuNzU5NTEyXSBuZnM6IHNlcnZlciAxOTIuMTY4LjEuMTEyIE9LDQo+IA0KPiA1
KSBSZW1hcmtzOg0KPiBXaXRoIHRpbWVvPTYwMCwgdGhlcmUgYXJlIG5vIGVycm9ycyBpbiBkbWVz
Zy4NCj4gVGhlIGZhY3QgdGhhdCB0aW1lbz03ICh0aGUgbmZzbW91bnQgZGVmYXVsdCkgY2F1c2Vz
IGVycm9ycywgcHJvdmVzDQo+IHRoYXQgDQo+IHNvbWUgcGFja2V0cyBuZWVkIG1vcmUgdGhhbiAw
Ljcgc2VjcyB0byBhcnJpdmUuDQo+IFdoaWNoIGluIHR1cm4gZXhwbGFpbnMgd2h5IGFsbCB0aGUg
YXBwbGljYXRpb25zIG9wZW4gZXh0cmVtZWx5DQo+IHNsb3dseSANCj4gYW5kIGZlZWwgc2x1Z2dp
c2ggb24gbmV0cm9vdCA9IDEwMCBNYnBzLCBORlMsIFRDUC4NCj4gDQo+IExvd2VyaW5nIHJzaXpl
LHdzaXplIGZyb20gMU0gdG8gMzJLIHNvbHZlcyBhbGwgdGhvc2UgaXNzdWVzIHdpdGhvdXQNCj4g
YW55IA0KPiBuZWdhdGl2ZSBzaWRlIGVmZmVjdHMgdGhhdCBJIGNhbiBzZWUuIEV2ZW4gb24gZ2ln
YWJpdCwgMzJLIG1ha2VzIA0KPiBhcHBsaWNhdGlvbnMgYSBsb3QgbW9yZSBzbmFwcHkgc28gaXQn
cyBiZXR0ZXIgZXZlbiB0aGVyZS4NCj4gT24gMTAgTWJwcywgcnNpemU9MU0gaXMgY29tcGxldGVs
eSB1bnVzYWJsZS4NCj4gDQo+IFNvIEknbSBub3Qgc3VyZSB3aGVyZSByc2l6ZT0xTSBpcyBhIGJl
dHRlciBkZWZhdWx0LiBJcyBpdCBvbmx5IGZvcg0KPiAxMEcrIA0KPiBjb25uZWN0aW9ucz8NCj4g
DQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkga2xpYmMgd291bGQgZGVmYXVsdCB0byBzdXBwbHlp
bmcgYSB0aW1lbz03DQphcmd1bWVudCBhdCBhbGwuIEl0IHdvdWxkIGJlIE1VQ0ggYmV0dGVyIGlm
IGl0IGp1c3QgbGV0IHRoZSBrZXJuZWwgc2V0DQp0aGUgZGVmYXVsdCwgd2hpY2ggaW4gdGhlIGNh
c2Ugb2YgVENQIGlzIHRpbWVvPTYwMC4NCg0KSSBhZ3JlZSB3aXRoIHlvdXIgYXJndW1lbnQgdGhh
dCByZXBsYXlpbmcgcmVxdWVzdHMgZXZlcnkgMC43IHNlY29uZHMgaXMNCmp1c3QgZ29pbmcgdG8g
Y2F1c2UgY29uZ2VzdGlvbi4gVENQIHByb3ZpZGVzIGZvciByZWxpYWJsZSBkZWxpdmVyeSBvZg0K
UlBDIG1lc3NhZ2VzIHRvIHRoZSBzZXJ2ZXIsIHdoaWNoIGlzIHdoeSB0aGUga2VybmVsIGRlZmF1
bHQgaXMgYSBmdWxsDQptaW51dGUuDQoNClNvIHBsZWFzZSBhc2sgdGhlIGtsaWJjIGRldmVsb3Bl
cnMgdG8gY2hhbmdlIGxpYm1vdW50IHRvIGxldCB0aGUga2VybmVsDQpkZWNpZGUgdGhlIGRlZmF1
bHQgbW91bnQgb3B0aW9ucy4gVGhlaXIgY3VycmVudCBzZXR0aW5nIGlzIGp1c3QgcGxhaW4NCndy
b25nLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
