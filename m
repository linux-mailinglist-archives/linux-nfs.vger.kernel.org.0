Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A881156C6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 18:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFRwW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 12:52:22 -0500
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:48366
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfLFRwW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 12:52:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNeQUG9sL9sS5ZRbTeb0Q5Q/Pu8I7sHe0JjJ03Szl1eMMBoai/khAIlbCie+6Gc96lcal1Z7Or/McNlHUGNs+PQ5hxk6jva7txbtR+0dG6MQpmA9Vxl2Lcvu7yTrrcJAENWSEFlVlcOTE9kxSaxFGpCewFgUt8UBBoz9VY/NhzGzNyk06O+fLY1CYWD32N2jUsg3M13E57ElxS/UCMBEU23JAXSW8eanoiC6Iron4nOBu3bCIsZb+i1ucXUg/IHgjs4ZzYqj6ZwzbW6vWyrhqFJZTul9+NbkHzvgEJGfbDnapYHbsXFrVfXDcSU7CJzxWhZcCWyI/L8N4q6y3rcnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBBgBW+lbbplum7iVCngRLCHZ2IiQ4aM/t38K44Fx24=;
 b=H63OAl14sbSV4FqTAOejFyHQA0UkA4mpvHfNpAIc4m+F0bViu333QZ3OTOr4m+O4ixYKpKADESOleqViLPoS91apiyzdjRWTnthkBQgbkx8beam2IayBJZ1zkOOcPKmRJksa+fzrdCklsOKW553JTEsWGdI4jra1kJbAU3P6/iwF0y/mtdCy0O9emqHmXUn5JCLxT+hCIt3oiqfM5/enZeavufEUygiHZC6F7z3G8Ll5BVlgwBrdtygEpkhko76QFOjnQPq+gP52FZaEI7JSEjphO9Zgw4S7XWG3g8JOFXXxmAElvZVFzkMdGcpNOE0Bl5huoH9aEYZ5PAbGwtk/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBBgBW+lbbplum7iVCngRLCHZ2IiQ4aM/t38K44Fx24=;
 b=ek22Sg1sV8qg3VXHpvyVtL6XuKjMEVR8Mm8ACem4AuFr21z3LGo9Z6A+phpUoRz5Sk7cITLZN6Sv33DU+P+nzBQDLHa4FR+OALlvK0I3KAWHEmyjYwelRKaOQ8Cq0AElgNOLmE874P4hTYDIRKQj25K/Z2J+KhGNHhlf+uIXkrg=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1962.namprd13.prod.outlook.com (10.174.184.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.4; Fri, 6 Dec 2019 17:52:10 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 17:52:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "madhuparnabhowmik04@gmail.com" <madhuparnabhowmik04@gmail.com>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Thread-Topic: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Thread-Index: AQHVrEg0Ten5696hykeZOOX4T18u0aetRJkAgAAemAA=
Date:   Fri, 6 Dec 2019 17:52:10 +0000
Message-ID: <2ec21ec537144bb3c0d5fbdaf88ea022d07b7ff8.camel@hammerspace.com>
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
         <20191206160238.GE2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191206160238.GE2889@paulmck-ThinkPad-P72>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [88.95.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b2813b6-f24f-4f89-df0b-08d77a7504d2
x-ms-traffictypediagnostic: DM5PR1301MB1962:
x-microsoft-antispam-prvs: <DM5PR1301MB19625B3D0CBABA8E74A4BDFBB85F0@DM5PR1301MB1962.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(136003)(346002)(366004)(189003)(199004)(66446008)(508600001)(64756008)(2906002)(54906003)(26005)(8676002)(110136005)(229853002)(76116006)(91956017)(66476007)(2616005)(102836004)(36756003)(6486002)(4326008)(66556008)(5660300002)(186003)(316002)(76176011)(118296001)(66946007)(305945005)(99286004)(6506007)(71190400001)(71200400001)(8936002)(6512007)(81166006)(81156014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1962;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1sKE9HcNAbQ9JZwVVnFC3mdOr6xHw1WkyDrRWTgUOk2JpiJMV5yRoc2fu/phXIQuM6sMkFHQ2+rNHyVgJuQm2Cd5lPRN7QaDjP7RWbT+ZSuppry0gMDZYt5buDnv+bO1zT+wm3l/JVcMh3AoJwWd3qPlbxARjbVzK0F9L67vlXhcWVLm17WEOe4EboSJiUC0IItIrgr5VpMZFJbLJno7tcbBAM63Tw2S+SvOUaDRq1TN9VmxVYZ+hE9Y1YthfpOU6nZEHYeGsiTdfDaa7C/nHzrFKBryWlSwSqlyEPTM28gHAKB63GL5NKT+xq36ZWVkb7cjzsJqUOc1MWBU6bWansrOpgamZTPpXmbfiK3kxIz1UYo4Fm0XXAW+cylZUPxe2Mt46oeclPxs7MSrRvbA5CqMPS4k1kdLJI3PSoG8Ykpae78zemm7Ted21ae1aOC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <87B74384B4FA6C48A324B0DD2BE0D477@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2813b6-f24f-4f89-df0b-08d77a7504d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 17:52:10.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrjA+r5zdwZ6zcu8GjAMQ1d0O/sGpSsXD3DMiuKXnQC7K4inSG4qs6FstifRJRXzDsZpgmZ4td2IPs2Mna376A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1962
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgUGF1bCwNCg0KT24gRnJpLCAyMDE5LTEyLTA2IGF0IDA4OjAyIC0wODAwLCBQYXVsIEUuIE1j
S2VubmV5IHdyb3RlOg0KPiBPbiBGcmksIERlYyAwNiwgMjAxOSBhdCAwODo0Njo0MFBNICswNTMw
LCANCj4gbWFkaHVwYXJuYWJob3dtaWswNEBnbWFpbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTWFk
aHVwYXJuYSBCaG93bWlrIDxtYWRodXBhcm5hYmhvd21pazA0QGdtYWlsLmNvbT4NCj4gPiANCj4g
PiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgZXJyb3JzOg0KPiA+IGZzL25mcy9kaXIu
YzoyMzUzOjE0OiBlcnJvcjogaW5jb21wYXRpYmxlIHR5cGVzIGluIGNvbXBhcmlzb24NCj4gPiBl
eHByZXNzaW9uIChkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMpOg0KPiA+IGZzL25mcy9kaXIuYzoy
MzUzOjE0OiAgICBzdHJ1Y3QgbGlzdF9oZWFkIFtub2RlcmVmXSA8YXNuOjQ+ICoNCj4gPiBmcy9u
ZnMvZGlyLmM6MjM1MzoxNDogICAgc3RydWN0IGxpc3RfaGVhZCAqDQo+ID4gDQo+ID4gY2F1c2Vk
IGR1ZSB0byBkaXJlY3RseSBhY2Nlc3NpbmcgdGhlIHByZXYgcG9pbnRlciBvZg0KPiA+IGEgUkNV
IHByb3RlY3RlZCBsaXN0Lg0KPiA+IEFjY2Vzc2luZyB0aGUgcG9pbnRlciB1c2luZyB0aGUgbWFj
cm8gbGlzdF9wcmV2X3JjdSgpIGZpeGVzIHRoaXMNCj4gPiBlcnJvci4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYWRodXBhcm5hIEJob3dtaWsgPG1hZGh1cGFybmFiaG93bWlrMDRAZ21haWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnMvZGlyLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiBpbmRleCBlMTgwMDMzZTM1Y2YuLjIw
MzUyNTRjYzI4MyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gPiArKysgYi9mcy9u
ZnMvZGlyLmMNCj4gPiBAQCAtMjM1MCw3ICsyMzUwLDcgQEAgc3RhdGljIGludCBuZnNfYWNjZXNz
X2dldF9jYWNoZWRfcmN1KHN0cnVjdA0KPiA+IGlub2RlICppbm9kZSwgY29uc3Qgc3RydWN0IGNy
ZWQgKmNyZQ0KPiA+ICAJcmN1X3JlYWRfbG9jaygpOw0KPiA+ICAJaWYgKG5mc2ktPmNhY2hlX3Zh
bGlkaXR5ICYgTkZTX0lOT19JTlZBTElEX0FDQ0VTUykNCj4gPiAgCQlnb3RvIG91dDsNCj4gPiAt
CWxoID0gcmN1X2RlcmVmZXJlbmNlKG5mc2ktPmFjY2Vzc19jYWNoZV9lbnRyeV9scnUucHJldik7
DQo+ID4gKwlsaCA9IHJjdV9kZXJlZmVyZW5jZShsaXN0X3ByZXZfcmN1KCZuZnNpLQ0KPiA+ID5h
Y2Nlc3NfY2FjaGVfZW50cnlfbHJ1KSk7DQo+IA0KPiBBbmQgYXMgbm90ZWQgaW4gdGhlIGVhcmxp
ZXIgZW1haWwsIHdoYXQgaXMgcHJldmVudGluZyBjb25jdXJyZW50DQo+IGluc2VydGlvbnMgaW50
byAgYW5kIGRlbGV0aW9ucyBmcm9tIHRoaXMgbGlzdD8NCj4gDQo+IG8JVGhpcyB1c2Ugb2YgbGlz
dF9tb3ZlX3RhaWwoKSBpcyBPSyBiZWNhdXNlIGl0IGRvZXMgbm90IHBvaXNvbi4NCj4gCVRob3Vn
aCBpdCBpc24ndCBiZWluZyBhbGwgdGhhdCBmcmllbmRseSB0byBsb2NrbGVzcyBhY2Nlc3MgdG8N
Cj4gCS0+cHJldiAtLSBubyBXUklURV9PTkNFKCkgaW4gbGlzdF9tb3ZlX3RhaWwoKS4NCj4gDQo+
IG8JVGhlIHVzZSBvZiBsaXN0X2FkZF90YWlsKCkgaXMgbm90IHNhZmUgd2l0aCBSQ1UgcmVhZGVy
cywgdGhvdWdoDQo+IAl0aGV5IGRvIGF0IGxlYXN0IHBhcnRpYWxseSBjb21wZW5zYXRlIHZpYSB1
c2Ugb2Ygc21wX3dtYigpDQo+IAlpbiBuZnNfYWNjZXNzX2FkZF9jYWNoZSgpIGJlZm9yZSBjYWxs
aW5nDQo+IG5mc19hY2Nlc3NfYWRkX3JidHJlZSgpLg0KPiANCj4gbwlUaGUgbGlzdF9kZWwoKSBu
ZWFyIHRoZSBlbmQgb2YgbmZzX2FjY2Vzc19hZGRfcmJ0cmVlKCkgd2lsbA0KPiAJcG9pc29uIHRo
ZSAtPnByZXYgcG9pbnRlci4gIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGlzIHNhZmUgZ2l2ZW4NCj4g
dGhlDQo+IAlwb3NzaWJpbGl0eSBvZiBhIGNvbmN1cnJlbnQgY2FsbCB0bw0KPiBuZnNfYWNjZXNz
X2dldF9jYWNoZWRfcmN1KCkuDQoNClRoZSBwb2ludGVyIG5mc2ktPmFjY2Vzc19jYWNoZV9lbnRy
eV9scnUgaXMgdGhlIGhlYWQgb2YgdGhlIGxpc3QsIHNvIGl0DQp3b24ndCBnZXQgcG9pc29uZWQu
IEZ1cnRoZXJtb3JlLCB0aGUgb2JqZWN0cyBpdCBwb2ludHMgdG8gYXJlIGZyZWVkDQp1c2luZyBr
ZnJlZV9yY3UoKSwgc28gdGhleSB3aWxsIHN1cnZpdmUgYXMgbG9uZyBhcyB3ZSBob2xkIHRoZSBy
Y3UgcmVhZA0KbG9jay4gVGhlIG9iamVjdCdzIGNyZWQgcG9pbnRlcnMgYWxzbyBwb2ludHMgdG8g
c29tZXRoaW5nIHRoYXQgaXMgZnJlZWQNCmluIGFuIHJjdS1zYWZlIG1hbm5lci4NCg0KVGhlIHBy
b2JsZW0gaGVyZSBpcyByYXRoZXIgdGhhdCBhIHJhY2luZyBsaXN0X2RlbCgpIGNhbiBjYXVzZSBu
ZnNpLQ0KPmFjY2Vzc19jYWNoZV9lbnRyeV9scnUgdG8gYmUgZW1wdHksIHdoaWNoIGlzIHByZXN1
bWFibHkgd2h5IE5laWwgYWRkZWQNCnRoYXQgY2hlY2sgcGx1cyB0aGUgZW1wdHkgY3JlZCBwb2lu
dGVyIGNoZWNrIGluIHRoZSBmb2xsb3dpbmcgbGluZS4NCg0KVGhlIGJhcnJpZXIgc2VtYW50aWNz
IG1heSBiZSBzdXNwZWN0LCBhbHRob3VnaCB0aGUgc3BpbiB1bmxvY2sgYWZ0ZXINCmxpc3RfZGVs
KCkgc2hvdWxkIHByZXN1bWFibHkgZ3VhcmFudGVlIHJlbGVhc2Ugc2VtYW50aWNzPw0KDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
