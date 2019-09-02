Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C60A5B93
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfIBQyn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 12:54:43 -0400
Received: from mail-eopbgr690098.outbound.protection.outlook.com ([40.107.69.98]:43076
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfIBQym (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Sep 2019 12:54:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwjOiv9eqAhvqwD11elx2vk3aXFlBBBT+gkXMGm2wqFRfAkDXzVstdL60GjkarEvigKtDfRbH0Aqi1SPbigB8ualoMBQqgvs56vBp7Vbx3JMkZ0acvPHHGMYKrmIEYs/GBYJXOmYfjcszlVXEvW9RsJgtZ7uHx4MP3bSvYxQ+/3hqKSl3Fs5Y7GJfdJVGe9JRguJq+sZgiXTiZBQ5QVKKXbw6cBdxaqZ9QpukpFKsANIegWRbj+UTGB0oHkkUNc96S0YFImnryvdIRbrN/+YvTU+V2tIfNXLKjuDvDLwbgIzWoFf6gGA4IhebzFCG8QQ+fpt5qjuEtFtLrnNoW8ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9BAnxtUcvqpzXJH6dqjDbwzieLU8JhkmwRjh2bIG78=;
 b=CVKbKzWRXteX7NO/BR9af3aTANhN6GL1GPWTVzqs7FO9tvauOsXh2J1fiZuCfF+gnaqW5bdaYKut6SOv6dR5hLnZeSsGuAMsM5BHbqQDdyVPonAEcO2pDjmUDoVT9vFj1lpi6ZsMJ/W2ITNAx2cdLQaPFqv6A9VMmMXQJ68o1MSPXxpJuVaoQTwV3xy1vxu+bDWin/xZn8rtFw5lXdjikD+al8ESivYUG4gubkKUk/OpizTzw3Cif9JyV6dxl8AgFHha81WesmeRiNtB5mlN3ZU+l1XAa78Dwdncfgk/a9wfzTSwPhxcryTG76kXa82efSbR8vy+u2h6ZikyzNcLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9BAnxtUcvqpzXJH6dqjDbwzieLU8JhkmwRjh2bIG78=;
 b=S8Hw/7JEsaS8xbr/4S0RU+qEWE61xD55zKwymm8jB9lOX5aiAKOmRK13q5c3NJRC/hf5iQDb+oUcQAkRnjbCtl8aiI4rMcGcL4PtaPXBa9B/polndhFG/1yf/bxK3spT4R94O6Yg9ahzMQymp61m7l2b4S4/t4nd9gTtcfamqf0=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1194.namprd13.prod.outlook.com (10.168.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.10; Mon, 2 Sep 2019 16:54:39 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2241.013; Mon, 2 Sep 2019
 16:54:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call
 nfs4_call_sync_custom()
Thread-Topic: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call
 nfs4_call_sync_custom()
Thread-Index: AQHVVsRfEZKA6bhAqkO4h31uRUg2rKcC4tuAgBTGU4CAAQd+gA==
Date:   Mon, 2 Sep 2019 16:54:39 +0000
Message-ID: <68876eaa4fc3f387ea7e3329af9f3b520ef96c5c.camel@hammerspace.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
         <20190819192900.19312-5-Anna.Schumaker@Netapp.com>
         <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
         <87sgpfec3e.fsf@notabene.neil.brown.name>
In-Reply-To: <87sgpfec3e.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dc19fc8-5f0e-4a51-e3e0-08d72fc63e56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1194;
x-ms-traffictypediagnostic: DM5PR13MB1194:
x-microsoft-antispam-prvs: <DM5PR13MB119432D7FB00B9E3B76EA6BEB8BE0@DM5PR13MB1194.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(189003)(199004)(229853002)(256004)(110136005)(99286004)(118296001)(305945005)(36756003)(66066001)(8936002)(2906002)(486006)(446003)(11346002)(2616005)(476003)(81166006)(81156014)(8676002)(76176011)(64756008)(66556008)(66446008)(66946007)(66476007)(76116006)(91956017)(6116002)(3846002)(7736002)(71190400001)(71200400001)(102836004)(6506007)(186003)(2501003)(26005)(6436002)(6512007)(4326008)(25786009)(6486002)(53936002)(508600001)(14454004)(6246003)(5660300002)(86362001)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1194;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K9qBYmnMeS1k969U9Ufl6uZgPKCQxrKAcIXlhr+FfpLXpRpZPKyFDS71eZe0JRU4ZRdpUPBgscL5pwiDELG8CM4Q267lPb0QO2qVS7dLTx5Sp/lxuoZdWttkhXHVJGsor6QIk3nAbW3UIOJOrG+rvP7k9IzVVKF7UznJlaJNc0/8YdvBajdVxDIasc7VWmTS2PSSVRiN5z4hlFy7iSfzfVfFyoLOmiCjNHlXRbRrHb0dKsyc0ooTPHZeXaEXAXJ4SXec17W2JmnH4R4y8eOkvc0GrVsERzgMJFTiA2wCN++lDYcSfpgPuk7twx/XzJrWqD7f11OLnv5TecQeqB1/Z/AQTXNVFfUaT8oA3UqicNJUl6eLyuUUSCg6hRknSQkZ5xCNeWEkHa7t1XgWQyicmdHoCHv9Yd+fBKcS/AJmmi8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <505104813B41104996EA2181DF4DD26C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc19fc8-5f0e-4a51-e3e0-08d72fc63e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 16:54:39.1116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAY7tPtPI8qoH+qDvvqk1WTrWfIdurYrqynl0oAN+cB7NzwpdPq4+az48AEXZRq89fyBHQkoZ20EW1PJ8ibHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1194
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTAyIGF0IDExOjExICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDE5IDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24gTW9u
LCAyMDE5LTA4LTE5IGF0IDE1OjI4IC0wNDAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5jb20gd3Jv
dGU6DQo+ID4gPiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNv
bT4NCj4gPiA+IA0KPiA+ID4gQW4gYXN5bmMgY2FsbCBmb2xsb3dlZCBieSBhbiBycGNfd2FpdF9m
b3JfY29tcGxldGlvbigpIGlzDQo+ID4gPiBiYXNpY2FsbHkNCj4gPiA+IHRoZQ0KPiA+ID4gc2Ft
ZSBhcyBhIHN5bmNocm9ub3VzIGNhbGwsIHNvIHdlIGNhbiB1c2UgbmZzNF9jYWxsX3N5bmNfY3Vz
dG9tKCkNCj4gPiA+IHRvDQo+ID4gPiBrZWVwIG91ciBjdXN0b20gY2FsbGJhY2sgb3BzIGFuZCB0
aGUgUlBDX1RBU0tfTk9fUk9VTkRfUk9CSU4NCj4gPiA+IGZsYWcuDQo+ID4gPiANCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZnMvbmZzL25mczRwcm9jLmMgfCAxMyArKy0tLS0tLS0tLS0tDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+
ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0
cHJvYy5jDQo+ID4gPiBpbmRleCBkZTJiM2ZkODA2ZWYuLjFiNzg2M2VjMTJkMyAxMDA2NDQNCj4g
PiA+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiArKysgYi9mcy9uZnMvbmZzNHByb2Mu
Yw0KPiA+ID4gQEAgLTg4NTcsNyArODg1Nyw2IEBAIHN0YXRpYyBpbnQNCj4gPiA+IG5mczQxX3By
b2NfcmVjbGFpbV9jb21wbGV0ZShzdHJ1Y3QNCj4gPiA+IG5mc19jbGllbnQgKmNscCwNCj4gPiA+
ICAJCWNvbnN0IHN0cnVjdCBjcmVkICpjcmVkKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IG5m
czRfcmVjbGFpbV9jb21wbGV0ZV9kYXRhICpjYWxsZGF0YTsNCj4gPiA+IC0Jc3RydWN0IHJwY190
YXNrICp0YXNrOw0KPiA+ID4gIAlzdHJ1Y3QgcnBjX21lc3NhZ2UgbXNnID0gew0KPiA+ID4gIAkJ
LnJwY19wcm9jID0NCj4gPiA+ICZuZnM0X3Byb2NlZHVyZXNbTkZTUFJPQzRfQ0xOVF9SRUNMQUlN
X0NPTVBMRVRFXSwNCj4gPiA+ICAJCS5ycGNfY3JlZCA9IGNyZWQsDQo+ID4gPiBAQCAtODg2Niw3
ICs4ODY1LDcgQEAgc3RhdGljIGludA0KPiA+ID4gbmZzNDFfcHJvY19yZWNsYWltX2NvbXBsZXRl
KHN0cnVjdA0KPiA+ID4gbmZzX2NsaWVudCAqY2xwLA0KPiA+ID4gIAkJLnJwY19jbGllbnQgPSBj
bHAtPmNsX3JwY2NsaWVudCwNCj4gPiA+ICAJCS5ycGNfbWVzc2FnZSA9ICZtc2csDQo+ID4gPiAg
CQkuY2FsbGJhY2tfb3BzID0gJm5mczRfcmVjbGFpbV9jb21wbGV0ZV9jYWxsX29wcywNCj4gPiA+
IC0JCS5mbGFncyA9IFJQQ19UQVNLX0FTWU5DIHwgUlBDX1RBU0tfTk9fUk9VTkRfUk9CSU4sDQo+
ID4gPiArCQkuZmxhZ3MgPSBSUENfVEFTS19OT19ST1VORF9ST0JJTiwNCj4gPiA+ICAJfTsNCj4g
PiA+ICAJaW50IHN0YXR1cyA9IC1FTk9NRU07DQo+ID4gPiAgDQo+ID4gPiBAQCAtODg4MSwxNSAr
ODg4MCw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+IG5mczQxX3Byb2NfcmVjbGFpbV9jb21wbGV0ZShz
dHJ1Y3QNCj4gPiA+IG5mc19jbGllbnQgKmNscCwNCj4gPiA+ICAJbXNnLnJwY19hcmdwID0gJmNh
bGxkYXRhLT5hcmc7DQo+ID4gPiAgCW1zZy5ycGNfcmVzcCA9ICZjYWxsZGF0YS0+cmVzOw0KPiA+
ID4gIAl0YXNrX3NldHVwX2RhdGEuY2FsbGJhY2tfZGF0YSA9IGNhbGxkYXRhOw0KPiA+ID4gLQl0
YXNrID0gcnBjX3J1bl90YXNrKCZ0YXNrX3NldHVwX2RhdGEpOw0KPiA+ID4gLQlpZiAoSVNfRVJS
KHRhc2spKSB7DQo+ID4gPiAtCQlzdGF0dXMgPSBQVFJfRVJSKHRhc2spOw0KPiA+ID4gLQkJZ290
byBvdXQ7DQo+ID4gPiAtCX0NCj4gPiA+IC0Jc3RhdHVzID0gcnBjX3dhaXRfZm9yX2NvbXBsZXRp
b25fdGFzayh0YXNrKTsNCj4gPiA+IC0JaWYgKHN0YXR1cyA9PSAwKQ0KPiA+ID4gLQkJc3RhdHVz
ID0gdGFzay0+dGtfc3RhdHVzOw0KPiA+ID4gLQlycGNfcHV0X3Rhc2sodGFzayk7DQo+ID4gPiAr
CXN0YXR1cyA9IG5mczRfY2FsbF9zeW5jX2N1c3RvbSgmdGFza19zZXR1cF9kYXRhKTsNCj4gPiA+
ICBvdXQ6DQo+ID4gPiAgCWRwcmludGsoIjwtLSAlcyBzdGF0dXM9JWRcbiIsIF9fZnVuY19fLCBz
dGF0dXMpOw0KPiA+ID4gIAlyZXR1cm4gc3RhdHVzOw0KPiA+IA0KPiA+IEhtbS4uLiBJJ20gYSBs
aXR0bGUgY29uZnVzZWQuIFdoeSBkb2VzIFJFQ0xBSU1fQ09NUExFVEUgbmVlZA0KPiA+IFJQQ19U
QVNLX05PX1JPVU5EX1JPQklOPyBJdCBzaG91bGQgYmUgb3JkZXJlZCBzbyBpdCBpcyBjYWxsZWQg
YWZ0ZXINCj4gPiBCSU5EX0NPTk5fVE9fU0VTU0lPTiBpbiBuZnM0X3N0YXRlX21hbmFnZXIoKSwg
c28gaW4gcHJpbmNpcGxlIGl0IGlzDQo+ID4gc3VwcG9zZWQgdG8gYmUgYWJsZSB0byByZWNvdmVy
IGZyb20gYW4gZXJyb3IgbGlrZQ0KPiA+IE5GUzRFUlJfQ09OTl9OT1RfQk9VTkRfVE9fU0VTU0lP
Ti4gQXJlIHRoZXJlIG90aGVyIHNpdHVhdGlvbnMgd2hlcmUNCj4gPiB3ZQ0KPiA+IG5lZWQgUlBD
X1RBU0tfTk9fUk9VTkRfUk9CSU4/DQo+IA0KPiBJIHRob3VnaHQgaXQgd2FzIGNvbmNlcHR1YWxs
eSBzaW1wbGVyIHRvIGtlZXAgKmFsbCogc3RhdGUgbWFuYWdlbWVudA0KPiBjb21tYW5kcyBvbiB0
aGUgb25lIGNvbm5lY3Rpb24uICBJdCBwcm9iYWJseSBpc24ndCBzdHJpY3RseSBuZWNlc3NhcnkN
Cj4gYXMNCj4geW91IHNheSwgYnV0IGVxdWFsbHkgdGhlcmUgaXMgbm8gbmVlZCB0byBkaXN0cmli
dXRlIHRoZW0gb3Zlcg0KPiBtdWx0aXBsZQ0KPiBjb25uZWN0aW9ucy4NCj4gSGF2aW5nIHRoZW0g
YWxsIG9uIHRoZSBvbmUgY29ubmVjdGlvbiBtaWdodCBtYWtlIGFuYWx5c2luZyBhIHBhY2tldA0K
PiB0cmFjZSBlYXNpZXIuLi4NCj4gDQoNCldlIGRvIHdhbnQgQklORF9DT05OX1RPX1NFU1NJT04g
dG8gYmUgYSBwYXJ0IG9mIHRoZSByZWNvdmVyeSBwcm9jZXNzDQp3aGVyZSBhbmQgd2hlbiBpdCBp
cyBuZWVkZWQuIElmIG5vdCwgd2UgZW5kIHVwIGhhdmluZyB0byBjYXRjaCBhIGxvYWQNCm9mIE5G
UzRFUlJfQ09OTl9OT1RfQk9VTkRfVE9fU0VTU0lPTiBlcnJvcnMgb25jZSB0aGUgcmVjb3Zlcnkg
dGhyZWFkIGlzDQpkb25lLCBhbmQgaGF2aW5nIHRvIHRoZW4ga2ljayBvZmYgYSBzZWNvbmQgcmVj
b3ZlcnkganVzdCB0byBoYW5kbGUNCnRob3NlIGVycm9ycy4NCg0KSU9XOiBEZWxpYmVyYXRlbHkg
c3VwcHJlc3NpbmcgdGhvc2UgZXJyb3JzIGJ5IHRyeWluZyB0byByb3V0ZSBhbGwgdGhlDQpyZWNv
dmVyeSB0aHJvdWdoIGEgc2luZ2xlIGNvbm5lY3Rpb24gaXMgYWN0dWFsbHkgbm90IGhlbHBmdWwu
DQpSaWdodCBub3csIHdlIHdpbGwgY2F0Y2ggdGhvc2UgZXJyb3JzIGluIHRoZSBjYXNlIHdoZXJl
IHRoZXJlIGlzIHN0YXRlDQpyZWNvdmVyeSB0byBiZSBwZXJmb3JtZWQgKHNpbmNlIHRob3NlIGNh
bGxzIGFyZSBhbGxvd2VkIHRvIGJlIHJvdXRlZA0KdGhyb3VnaCBhbGwgY29ubmVjdGlvbnMpIGJ1
dCBpdCBtaWdodCBiZSBuaWNlIHRvIGFsc28gdXNlDQpSRUNMQUlNX0NPTVBMRVRFIGFzIGEgY2Fu
YXJ5IGZvciBjb25uZWN0aW9uIGJpbmRpbmcuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
