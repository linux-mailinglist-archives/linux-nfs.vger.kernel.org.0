Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8653515128F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 23:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCWvC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 17:51:02 -0500
Received: from mail-dm6nam11on2119.outbound.protection.outlook.com ([40.107.223.119]:51168
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgBCWvB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Feb 2020 17:51:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/DY//lavI54bL4qMJyjuiy3+bM7//Vx7w7QQ1tafGGG3Xhu4jIcbjHlGx9cHIi+WK0DVHS+Gaj4uTRurE5nS17loi8UC3AuvpNe0qP2oyxeoif/tsRJNZmU5/su/e76yE/tHnhFycLM1zTnXxRLHrmkEV7tzwTKam04SzYbYhBFCmHhyuve5RmZ3Cra5NsQxcF7Qlj42G720ZraDhCA+jNGBauzRt2iD4w7AuBbqXlfkHxOs6v3TACzkE3Mnb2uwNmHYlcQa+Y/WUDkhYSP+TV7UzrZgtU0OrS6tJSrdNBBncyjx2/pK3UQKMX5mimjh1u/dl6bk30zIZDW9U6ciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi5s1KkwELN8NdLfQb60yNVm+UJMxijEF5/9wYgaJQI=;
 b=HqEM3lPJWRYhymWzJ1JUq/PzvYe7pWDGxvYNz9L4y0aFwoy2V3I7nuLJhIeEvkDDVPEmC/C79R//sOMUo7DhXGdddTE7IsLfsjL/fueNHOOEttPFYNFqJuWjeRQwRdxr0LUG9oOQoFeJek7XMnoajnAyT30dTpzDDHFIskD+EY/qe55DNXF5MLNCHLSie6DD/QgtukbGtd9N6hjWZxYPXoMy1C2vINeTsiRgSKOoJ2jGqq82NmMHRzL3QApnxFHLF6QmqnJmwsZ/YIiHFPRPM1zAYPcK8OIW2djbL+9oTWyf9ssRlNcjLgq7/Jn93sHdCsKnUKfc6/M+nRkcFsTidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi5s1KkwELN8NdLfQb60yNVm+UJMxijEF5/9wYgaJQI=;
 b=OKAuRmPCJjbrFySxUnPy5xfRz9WiWWsH6P+Mvrx6WGRPAvYwRmm513/lkfpnX0zZrZm8wit6cPiwBGp4ScK6F2Vg1/IIabOKI5DoyoVn/NiY6KMImkPnpz+pF6AE2NLWaqgF3L9BJjzKwsWmQSUT0ILr/vRjz/vIc4RRhvZXgUc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1881.namprd13.prod.outlook.com (10.174.184.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.20; Mon, 3 Feb 2020 22:50:57 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.018; Mon, 3 Feb 2020
 22:50:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Topic: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Index: AQHV2hv42rcDbF+6jk2nrb8C0oLYkagJ7Z6AgAANQ4CAAACzgIAAF2eAgAABlYA=
Date:   Mon, 3 Feb 2020 22:50:57 +0000
Message-ID: <fdf116b70a147d169a4b9b6800a34682eba582b6.camel@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
         <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
         <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
         <af1ed1339b6854af4c6def212b1035d18ce863df.camel@netapp.com>
         <7acea747deb126b86fc4a2f2742362155a4cf698.camel@hammerspace.com>
In-Reply-To: <7acea747deb126b86fc4a2f2742362155a4cf698.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eecd516e-2c60-4ec4-fe97-08d7a8fb8840
x-ms-traffictypediagnostic: DM5PR1301MB1881:
x-microsoft-antispam-prvs: <DM5PR1301MB18819EE7AECAF103B0424ACAB8000@DM5PR1301MB1881.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(4326008)(6486002)(186003)(478600001)(54906003)(316002)(86362001)(26005)(66476007)(66446008)(66556008)(5660300002)(64756008)(6916009)(2906002)(36756003)(6506007)(71200400001)(2616005)(6512007)(8936002)(91956017)(81166006)(8676002)(81156014)(76116006)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1881;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5f3SJq1t2pYiP0ZwvuEeHq2pZLcseohO4G1Mb4nvYHZdCIiginLomKWioxz1r0Zvak7EqEjYak8GrYD8dzOJPs9vW6dsQe7W5xXRnpbcKPjYC/ahJ6FpH+tHkkNVbXDUS84S3xbLBm6JAfmEvFBQGaulc7Sw5GnX2NRDW5GWhERYnfjPf70izE9fJeYmADlfhuS+aLxN4/Dw320Bj2PPzUj0IbQDe9WSRYLRX36PqkKjlcnTHLBesRmiGd2UQdJE+lusVOhiybJRtXx8tIf+SmcxKoYopcjeGAgPZce/boSY4URO7rHi0Flw7jlCsFXjpD9ZEOlpt03yEesOe5sStDQhLhYctc596It7IIVpfAlYoMNFkW0vdo0O3bWXUf9c06L1SaZDwrT61IxUtdACMouXmzwqw1sey2XxbyyFJBAGuP1JHpfTH/WqcR3LFbNG
x-ms-exchange-antispam-messagedata: D/AMkFx3uRMORqgA1iYoZZSKGwLvi2bnxzD8uGBbrLSa54+sNHr2MLkeZ7LRhklHXDFCN8hR4EbK8llJoDaxcKo6P5r3mziPzh2cLjOWmQ4vtf29dcD699/CwxoIG2TtLYxRn19ixUIBKHRzkX6Onw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B400545ED6DB2346BB2BF6644C046F2F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecd516e-2c60-4ec4-fe97-08d7a8fb8840
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 22:50:57.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3ICJhrmp6fHuY3bJW19G800X0Om4jWWIiFIX2DQzV/6UPgMxtAuYAdpv7cEbRMPxjqXtLHdC6xTm1xM9LSpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1881
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTAzIGF0IDIyOjQ1ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMToyMSArMDAwMCwgU2NodW1ha2VyLCBBbm5hIHdy
b3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAxNjoxOCAtMDUwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIwLTAyLTAzIGF0IDIwOjMxICswMDAwLCBTY2h1
bWFrZXIsIEFubmEgd3JvdGU6DQo+ID4gPiA+IEhpIFRyb25kLA0KPiA+ID4gPiANCj4gPiA+ID4g
T24gU3VuLCAyMDIwLTAyLTAyIGF0IDE3OjUzIC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gPiA+ID4gV2hlbiBhIE5GUyBkaXJlY3RvcnkgcGFnZSBjYWNoZSBwYWdlIGlzIHJlbW92
ZWQgZnJvbSB0aGUgcGFnZQ0KPiA+ID4gPiA+IGNhY2hlLA0KPiA+ID4gPiA+IGl0cyBjb250ZW50
cyBhcmUgZnJlZWQgdGhyb3VnaCBhIGNhbGwgdG8NCj4gPiA+ID4gPiBuZnNfcmVhZGRpcl9jbGVh
cl9hcnJheSgpLg0KPiA+ID4gPiA+IFRvIHByZXZlbnQgdGhlIHJlbW92YWwgb2YgdGhlIHBhZ2Ug
Y2FjaGUgZW50cnkgdW50aWwgYWZ0ZXINCj4gPiA+ID4gPiB3ZSd2ZQ0KPiA+ID4gPiA+IGZpbmlz
aGVkIHJlYWRpbmcgaXQsIHdlIG11c3QgdGFrZSB0aGUgcGFnZSBsb2NrLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEZpeGVzOiAxMWRlM2IxMWUwOGMgKCJORlM6IEZpeCBhIG1lbW9yeSBsZWFrIGlu
IG5mc19yZWFkZGlyIikNCj4gPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHYy
LjYuMzcrDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+
ID4gPiB0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gIGZzL25mcy9kaXIuYyB8IDMwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0K
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2Zz
L25mcy9kaXIuYw0KPiA+ID4gPiA+IGluZGV4IGJhMGQ1NTkzMGU4YS4uOTA0NjdiNDRlYzEzIDEw
MDY0NA0KPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiA+ICsrKyBiL2ZzL25m
cy9kaXIuYw0KPiA+ID4gPiA+IEBAIC03MDUsOCArNzA1LDYgQEAgaW50IG5mc19yZWFkZGlyX2Zp
bGxlcih2b2lkICpkYXRhLCBzdHJ1Y3QNCj4gPiA+ID4gPiBwYWdlKg0KPiA+ID4gPiA+IHBhZ2Up
DQo+ID4gPiA+ID4gIHN0YXRpYw0KPiA+ID4gPiA+ICB2b2lkIGNhY2hlX3BhZ2VfcmVsZWFzZShu
ZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAt
CWlmICghZGVzYy0+cGFnZS0+bWFwcGluZykNCj4gPiA+ID4gPiAtCQluZnNfcmVhZGRpcl9jbGVh
cl9hcnJheShkZXNjLT5wYWdlKTsNCj4gPiA+ID4gPiAgCXB1dF9wYWdlKGRlc2MtPnBhZ2UpOw0K
PiA+ID4gPiA+ICAJZGVzYy0+cGFnZSA9IE5VTEw7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiBA
QCAtNzIwLDE5ICs3MTgsMjggQEAgc3RydWN0IHBhZ2UNCj4gPiA+ID4gPiAqZ2V0X2NhY2hlX3Bh
Z2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90DQo+ID4gPiA+ID4gKmRlc2MpDQo+ID4gPiA+ID4g
IA0KPiA+ID4gPiA+ICAvKg0KPiA+ID4gPiA+ICAgKiBSZXR1cm5zIDAgaWYgZGVzYy0+ZGlyX2Nv
b2tpZSB3YXMgZm91bmQgb24gcGFnZSBkZXNjLQ0KPiA+ID4gPiA+ID4gcGFnZV9pbmRleA0KPiA+
ID4gPiA+ICsgKiBhbmQgbG9ja3MgdGhlIHBhZ2UgdG8gcHJldmVudCByZW1vdmFsIGZyb20gdGhl
IHBhZ2UNCj4gPiA+ID4gPiBjYWNoZS4NCj4gPiA+ID4gPiAgICovDQo+ID4gPiA+ID4gIHN0YXRp
Yw0KPiA+ID4gPiA+IC1pbnQgZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3Jf
dCAqZGVzYykNCj4gPiA+ID4gPiAraW50IGZpbmRfYW5kX2xvY2tfY2FjaGVfcGFnZShuZnNfcmVh
ZGRpcl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAgCWludCBy
ZXM7DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAJZGVzYy0+cGFnZSA9IGdldF9jYWNoZV9wYWdl
KGRlc2MpOw0KPiA+ID4gPiA+ICAJaWYgKElTX0VSUihkZXNjLT5wYWdlKSkNCj4gPiA+ID4gPiAg
CQlyZXR1cm4gUFRSX0VSUihkZXNjLT5wYWdlKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLQly
ZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+ID4gPiA+ID4gKwlyZXMgPSBs
b2NrX3BhZ2Vfa2lsbGFibGUoZGVzYy0+cGFnZSk7DQo+ID4gPiA+ID4gIAlpZiAocmVzICE9IDAp
DQo+ID4gPiA+ID4gLQkJY2FjaGVfcGFnZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gPiA+ICsJCWdv
dG8gZXJyb3I7DQo+ID4gPiA+ID4gKwlyZXMgPSAtRUFHQUlOOw0KPiA+ID4gPiA+ICsJaWYgKGRl
c2MtPnBhZ2UtPm1hcHBpbmcgIT0gTlVMTCkgew0KPiA+ID4gPiA+ICsJCXJlcyA9IG5mc19yZWFk
ZGlyX3NlYXJjaF9hcnJheShkZXNjKTsNCj4gPiA+ID4gPiArCQlpZiAocmVzID09IDApDQo+ID4g
PiA+ID4gKwkJCXJldHVybiAwOw0KPiA+ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ICsJdW5sb2NrX3Bh
Z2UoZGVzYy0+cGFnZSk7DQo+ID4gPiA+ID4gK2Vycm9yOg0KPiA+ID4gPiA+ICsJY2FjaGVfcGFn
ZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gPiA+ICAJcmV0dXJuIHJlczsNCj4gPiA+ID4gPiAgfQ0K
PiA+ID4gPiA+ICANCj4gPiA+ID4gDQo+ID4gPiA+IENhbiB5b3UgZ2l2ZSBtZSBzb21lIGd1aWRh
bmNlIG9uIGhvdyB0byBhcHBseSB0aGlzIG9uIHRvcCBvZg0KPiA+ID4gPiBEYWkncyB2Mg0KPiA+
ID4gPiBwYXRjaCBmcm9tDQo+ID4gPiA+IEphbnVhcnkgMjM/IFJpZ2h0IG5vdyBJIGhhdmUgdGhl
IG5mc2ktPnBhZ2VfaW5kZXggZ2V0dGluZyBzZXQNCj4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiB1bmxvY2tfcGFnZSgpOg0KPiA+ID4gDQo+ID4gPiBTaW5jZSB0aGlzIG5lZWRz
IHRvIGJlIGEgc3RhYmxlIHBhdGNoLCBpdCB3b3VsZCBiZSBwcmVmZXJhYmxlIHRvDQo+ID4gPiBh
cHBseQ0KPiA+ID4gdGhlbSBpbiB0aGUgb3Bwb3NpdGUgb3JkZXIgdG8gYXZvaWQgYW4gZXh0cmEg
ZGVwZW5kZW5jeSBvbiBEYWkncw0KPiA+ID4gcGF0Y2guDQo+ID4gDQo+ID4gVGhhdCBtYWtlcyBz
ZW5zZS4NCj4gPiANCj4gPiA+IFRoYXQgc2FpZCwgc2luY2UgdGhlIG5mc2ktPnBhZ2VfaW5kZXgg
aXMgbm90IGEgcGVyLXBhZ2UgdmFyaWFibGUsDQo+ID4gPiB0aGVyZQ0KPiA+ID4gaXMgbm8gbmVl
ZCB0byBwdXQgaXQgdW5kZXIgdGhlIHBhZ2UgbG9jay4NCj4gPiANCj4gPiBHb3QgaXQuIEknbGwg
c3dhcCB0aGUgb3JkZXIgb2YgZXZlcnl0aGluZywgYW5kIHB1dCB0aGUgcGFnZV9pbmRleA0KPiA+
IG91dHNpZGUgb2YgdGhlDQo+ID4gcGFnZSBsb2NrIHdoZW4gcmVzb2x2aW5nIHRoZSBjb25mbGlj
dC4NCj4gPiANCj4gDQo+IE9vcHMuLi4gQWN0dWFsbHkgRGFpJ3MgY29kZSBuZWVkcyB0byBnbyBp
biB0aGUgJ3JldHVybiAwJyBwYXRoIGFib3ZlDQo+IChpLmUuIGFmdGVyIGEgc3VjY2Vzc2Z1bCBj
YWxsIHRvIG5mc19yZWFkZGlyX3NlYXJjaF9hcnJheSgpKS4NCj4gSXQgc2hvdWxkbid0IGdvIGlu
IHRoZSBlcnJvciBwYXRoLg0KDQoNCldoaWxlIG1vdmluZyB0aGUgY29kZSwgY291bGQgeW91IGFs
c28gYWRkIGluIGEgc21hbGwgbWljcm8tDQpvcHRpbWlzYXRpb24/IElmIHdlIHVzZSBmaWxlX2lu
b2RlKGRlc2MtPmZpbGUpIGluc3RlYWQgb2YNCmRfaW5vZGUoZmlsZV9kZW50cnkoZGVzYy0+Zmls
ZSkpIHRoZW4gd2UgYXZvaWQgYXQgbGVhc3Qgb25lIHBvaW50ZXINCmluZGlyZWN0aW9uLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
