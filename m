Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCCCCA3D
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2019 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJEOHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Oct 2019 10:07:21 -0400
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:56672
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfJEOHV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 5 Oct 2019 10:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IonuP3JT7UCdXh14upaItQumilB8hkJYBQ+rnxc2KNXlyTPgtjgb77VD46npSKUkeKmnTMz57q0q+yqMmJdtUCWJhs6s2EhHyCltH95FWFQCceh0J66tOcSVG6uZM+vVlmRxLh0mLlrUKmKhQ7Ngc4G8QPnR4L0akuhBKIJPD72wXWxbTuw3llPOpoYDiqAJ6W4NTb6GTWkr4NmfvRXaK6MpAU/T2LVn5+APcOCAXv21urfo6XieFZdV0e1xrMvaPBPcqBKWPKqID9Xe/TpqMXcVPjjBde+MTAF1F1cv3Ghi9RXiJ5ulWO3jkrQbTz39Cp6FwNJQAE2X/HAuEWHoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypmD9LsLN/01NGrQZteqUudJGVxK/spw2t3xFw2KpDM=;
 b=jAa0EZsysvQWmoY30/UZ0QPe5h8sZ+ha6uPSrygF8aoOyEX2CBdJyXzCVRTX7U4tRVoxlWJco5Wy7UPEDFvGYD3JVOo7LR4JOGrENKmoTPOzv4yBRK/kA5364zOaUvfvqN+MvgijObSCyVIZTzZ4e5xMxWP+1gOTxv2H8Iv+okVOYkVqAs/iV6y4brA5qVOvLj7hoUgOnMkWMyqJ1/GhVprxuNWuMY/Z3IFKE3TduCvaN7uN9Lcr3qddZfcW9a2NA/SDH/cDxX49OveDv/FnrzpBbgn3eUst5gUmjjX6EVfthBt/sK77STersD5LAPjKywVhxbOAJuVZ+Nw+kbdCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypmD9LsLN/01NGrQZteqUudJGVxK/spw2t3xFw2KpDM=;
 b=f1LWdO84efBBdy1kyi90IOwpuE8TOd7kDj5j3IxqUho4QMpfdiOddBS7VqJx31WzTqdyjft5DsUZX6ua/O8le/Xuy3CPmVFTvB9IF1sciNoZkCHGDhoMbz28ODq4tewYhLHA1TeOV/3fO/DCTnGpccP1WoB65WMqf7KOMcv3WBY=
Received: from CY4PR13MB1847.namprd13.prod.outlook.com (10.171.165.14) by
 CY4PR13MB1128.namprd13.prod.outlook.com (10.173.180.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Sat, 5 Oct 2019 14:07:16 +0000
Received: from CY4PR13MB1847.namprd13.prod.outlook.com
 ([fe80::c922:bc8:f4c3:cd1c]) by CY4PR13MB1847.namprd13.prod.outlook.com
 ([fe80::c922:bc8:f4c3:cd1c%5]) with mapi id 15.20.2347.011; Sat, 5 Oct 2019
 14:07:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Topic: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Index: AQHVdDLYBQhYO0+XeUeeglb5KXlRoKdLVoQAgADNdgA=
Date:   Sat, 5 Oct 2019 14:07:16 +0000
Message-ID: <5c50a4be3562877a5d96523e943b9976a3792e23.camel@hammerspace.com>
References: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
         <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
In-Reply-To: <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 969333cc-8bb4-4234-a5a4-08d7499d53e1
x-ms-traffictypediagnostic: CY4PR13MB1128:
x-microsoft-antispam-prvs: <CY4PR13MB1128383B13794C99442D5ECBB8990@CY4PR13MB1128.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 0181F4652A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39830400003)(366004)(189003)(199004)(91956017)(8676002)(305945005)(2501003)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(6512007)(66066001)(99286004)(14454004)(6246003)(8936002)(36756003)(26005)(7736002)(186003)(2616005)(476003)(118296001)(486006)(446003)(11346002)(229853002)(2201001)(3846002)(478600001)(76176011)(25786009)(5660300002)(81156014)(81166006)(71190400001)(71200400001)(6436002)(316002)(6486002)(6506007)(53546011)(2906002)(86362001)(102836004)(6116002)(256004)(45080400002)(110136005)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1128;H:CY4PR13MB1847.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cvhb/D4+9YOO6pu5nvsKG/qW6cn0K6joNKIlz98v/uyVzffb8a43SN71Jov2d87d5GbataswEjdtA9lvUpaZ7HFKnUH7o+rhEgDvHDuaqe3INrj5/ISOjyWRKxWPSWbBDpUSgvBrEg6G+T3NfBAZitTuKaLUjnwQ42Ofx8IxSmrIe6jAJnBnS1t4INLtcy9f8i28sXNmf6kawXrXxmOBOeDjMBUB2w1Y7TyIL/Ip5v8dIQHW3+XyGDpIH6hb5XblW9im7y14Tsgn8VppuAtpCsFNiDEQkVRLBOmNilt8PaV65ERMwfImYz50Lq2FEM8gLugWaQWYQAxMWcQK51WNM42zz0qwXrNdibF3cNK1mWTLpe5ffzZzL4aX7GPgZ57r0PUubE0qga1NXZnZ2vCKsamMrwQNy5uqmdzQ8YovWww=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <79BB0FF92B97E44B91541C65634BDDCC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969333cc-8bb4-4234-a5a4-08d7499d53e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2019 14:07:16.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sP9cIPeV9RI/eGB/vlAFJl96ZQpsujJMm1IrQkzzNPBBxn0BwEvQfd+cDRjkcBIswN9ZjbQa9owHd84YkxRt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1128
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDE5LTEwLTA1IGF0IDA5OjUxICswODAwLCB6aGFuZ3hpYW94dSAoQSkgd3JvdGU6
DQo+IHBpbmcuDQo+IA0KPiBPbiAyMDE5LzkvMjYgMTQ6MjksIFpoYW5nWGlhb3h1IHdyb3RlOg0K
PiA+IFdoZW4geGZzdGVzdHMgdGVzdGluZywgdGhlcmUgYXJlIHNvbWUgV0FSTklORyBhcyBiZWxv
dzoNCj4gPiANCj4gPiBXQVJOSU5HOiBDUFU6IDAgUElEOiA2MjM1IGF0IGZzL25mcy9pbm9kZS5j
OjEyMg0KPiA+IG5mc19jbGVhcl9pbm9kZSsweDljLzB4ZDgNCj4gPiBNb2R1bGVzIGxpbmtlZCBp
bjoNCj4gPiBDUFU6IDAgUElEOiA2MjM1IENvbW06IHVtb3VudC5uZnMNCj4gPiBIYXJkd2FyZSBu
YW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkNCj4gPiBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRh
aWYgLVBBTiAtVUFPKQ0KPiA+IHBjIDogbmZzX2NsZWFyX2lub2RlKzB4OWMvMHhkOA0KPiA+IGxy
IDogbmZzX2V2aWN0X2lub2RlKzB4NjAvMHg3OA0KPiA+IHNwIDogZmZmZmZjMDAwZjY4ZmMwMA0K
PiA+IHgyOTogZmZmZmZjMDAwZjY4ZmMwMCB4Mjg6IGZmZmZmZTAwYzUzMTU1YzANCj4gPiB4Mjc6
IGZmZmZmZTAwYzUzMTUwMDAgeDI2OiBmZmZmZmMwMDA5YTYzNzQ4DQo+ID4geDI1OiBmZmZmZmMw
MDBmNjhmZDE4IHgyNDogZmZmZmZjMDAwYmZhYWY0MA0KPiA+IHgyMzogZmZmZmZjMDAwOTM2ZDNj
MCB4MjI6IGZmZmZmZTAwYzRmZjVlMjANCj4gPiB4MjE6IGZmZmZmYzAwMGJmYWFmNDAgeDIwOiBm
ZmZmZmUwMGM0ZmY1ZDEwDQo+ID4geDE5OiBmZmZmZmMwMDBjMDU2MDAwIHgxODogMDAwMDAwMDAw
MDAwMDAzYw0KPiA+IHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiB4MTU6IDAwMDAwMDAwMDAwMDAwNDAgeDE0OiAwMDAwMDAwMDAwMDAwMjI4DQo+ID4geDEz
OiBmZmZmZmMwMDBjM2EyMDAwIHgxMjogMDAwMDAwMDAwMDAwMDA0NQ0KPiA+IHgxMTogMDAwMDAw
MDAwMDAwMDAwMCB4MTA6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiB4OSA6IDAwMDAwMDAwMDAwMDAw
MDAgeDggOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4geDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDog
ZmZmZmZjMDAwODRiMDI3Yw0KPiA+IHg1IDogZmZmZmZjMDAwOWE2NDAwMCB4NCA6IGZmZmZmZTAw
YzBlNzc0MDANCj4gPiB4MyA6IGZmZmZmYzAwMGMwNTYzYTggeDIgOiBmZmZmZmZmZmZmZmZmZmZi
DQo+ID4geDEgOiAwMDAwMDAwMDAwMDA3NjRlIHgwIDogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+IENh
bGwgdHJhY2U6DQo+ID4gICBuZnNfY2xlYXJfaW5vZGUrMHg5Yy8weGQ4DQo+ID4gICBuZnNfZXZp
Y3RfaW5vZGUrMHg2MC8weDc4DQo+ID4gICBldmljdCsweDEwOC8weDM4MA0KPiA+ICAgZGlzcG9z
ZV9saXN0KzB4NzAvMHhhMA0KPiA+ICAgZXZpY3RfaW5vZGVzKzB4MTk0LzB4MjEwDQo+ID4gICBn
ZW5lcmljX3NodXRkb3duX3N1cGVyKzB4YjAvMHgyMjANCj4gPiAgIG5mc19raWxsX3N1cGVyKzB4
NDAvMHg4OA0KPiA+ICAgZGVhY3RpdmF0ZV9sb2NrZWRfc3VwZXIrMHhiNC8weDEyMA0KPiA+ICAg
ZGVhY3RpdmF0ZV9zdXBlcisweDE0NC8weDE2MA0KPiA+ICAgY2xlYW51cF9tbnQrMHg5OC8weDE0
OA0KPiA+ICAgX19jbGVhbnVwX21udCsweDM4LzB4NTANCj4gPiAgIHRhc2tfd29ya19ydW4rMHgx
MTQvMHgxNjANCj4gPiAgIGRvX25vdGlmeV9yZXN1bWUrMHgyZjgvMHgzMDgNCj4gPiAgIHdvcmtf
cGVuZGluZysweDgvMHgxNA0KPiA+IA0KPiA+IFRoZSBucmVxdWVzdCBzaG91bGQgYmUgaW5jcmVh
c2VkL2RlY3JlYXNlZCBvbmx5IGlmIFBHX0lOT0RFX1JFRg0KPiA+IGZsYWcNCj4gPiB3YXMgc2V0
dGVkLg0KPiA+IA0KPiA+IEJ1dCBpbiB0aGUgbmZzX2lub2RlX3JlbW92ZV9yZXF1ZXN0IGZ1bmN0
aW9uLCBpdCBtYXliZSBkZWNyZWFzZQ0KPiA+IHdoZW4NCj4gPiBubyBQR19JTk9ERV9SRUYgZmxh
ZywgdGhpcyBtYXliZSBsZWFkIG5yZXF1ZXN0cyBjb3VudCBlcnJvci4NCj4gPiANCj4gPiBSZXBv
cnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogWmhhbmdYaWFveHUgPHpoYW5neGlhb3h1NUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
ZnMvbmZzL3dyaXRlLmMgfCA1ICsrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvd3Jp
dGUuYyBiL2ZzL25mcy93cml0ZS5jDQo+ID4gaW5kZXggODVjYTQ5NS4uNTJjYWI2NSAxMDA2NDQN
Cj4gPiAtLS0gYS9mcy9uZnMvd3JpdGUuYw0KPiA+ICsrKyBiL2ZzL25mcy93cml0ZS5jDQo+ID4g
QEAgLTc4Niw3ICs3ODYsNiBAQCBzdGF0aWMgdm9pZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qo
c3RydWN0DQo+ID4gbmZzX3BhZ2UgKnJlcSkNCj4gPiAgIAlzdHJ1Y3QgbmZzX2lub2RlICpuZnNp
ID0gTkZTX0koaW5vZGUpOw0KPiA+ICAgCXN0cnVjdCBuZnNfcGFnZSAqaGVhZDsNCj4gPiAgIA0K
PiA+IC0JYXRvbWljX2xvbmdfZGVjKCZuZnNpLT5ucmVxdWVzdHMpOw0KPiA+ICAgCWlmIChuZnNf
cGFnZV9ncm91cF9zeW5jX29uX2JpdChyZXEsIFBHX1JFTU9WRSkpIHsNCj4gPiAgIAkJaGVhZCA9
IHJlcS0+d2JfaGVhZDsNCj4gPiAgIA0KPiA+IEBAIC03OTksOCArNzk4LDEwIEBAIHN0YXRpYyB2
b2lkIG5mc19pbm9kZV9yZW1vdmVfcmVxdWVzdChzdHJ1Y3QNCj4gPiBuZnNfcGFnZSAqcmVxKQ0K
PiA+ICAgCQlzcGluX3VubG9jaygmbWFwcGluZy0+cHJpdmF0ZV9sb2NrKTsNCj4gPiAgIAl9DQo+
ID4gICANCj4gPiAtCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoUEdfSU5PREVfUkVGLCAmcmVxLT53
Yl9mbGFncykpDQo+ID4gKwlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwgJnJl
cS0+d2JfZmxhZ3MpKSB7DQo+ID4gICAJCW5mc19yZWxlYXNlX3JlcXVlc3QocmVxKTsNCj4gPiAr
CQlhdG9taWNfbG9uZ19kZWMoJm5mc2ktPm5yZXF1ZXN0cyk7DQo+ID4gKwl9DQo+ID4gICB9DQo+
ID4gICANCj4gPiAgIHN0YXRpYyB2b2lkDQo+ID4gDQoNCkhtbS4uLiBXaGF0IGFib3V0IG5mc19w
YWdlX2dyb3VwX2luaXQoKT8gVGhhdCBhbHNvIGJ1bXBzIG5mc2ktDQo+bnJlcXVlc3RzLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
