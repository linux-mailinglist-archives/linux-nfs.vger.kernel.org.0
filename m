Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B033147136
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 19:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWSz5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 13:55:57 -0500
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:15182
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbgAWSz5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 13:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keuEPQVGPStwj6i0J3wxSF6/PkosPYZSi2w0Nf49jFYWaqRpHR7bon3fN+EjklbYN8OpkTKs85/uyZOvswNoTpEPzILGcA7If3tyskjIfALOY/74nR5PfkeJZIqTXGL9LXpYq94HMzQefbc684UyNf8uOSTt3z6GA+mAQzGVX1aJU2HSsXrZ4JcfszRR3eq43FYrGwfXY8vfKg01DV/OCcYb37bF2XgCFuLk9942sUJmIapiT4ms618mRn812e46OTtvZK2TbELjMBslgAF6dPPWjy/1bidcsUixluJqcBhIk6aQrZfDIkHnB0ZaG7+pIvuSl6rVk/T+M3bsdWsejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jnWFBqJz3eU3ZdCKPvEKESGJrf69bJXekkkq+25dl0=;
 b=RYOc3IrZ+E7T6TdRFrKF/Jf+BOT7e8Xxz+J6CV+ozUWJ/QGh5C1lGv4J+Vg5lthzTTxNgfQaGvbSWYzsb2xxRzeZ9bRC46FmkvBgC5yEP26Fl0h2uf4CGHxWJGyYP00Ey0TJpuQxeNi80SuAApRMjgLxuOwpI7u2wyK4usuYWtfaseJkGNV2a8mxVI7ykM2WXl70fJsruTNf3cJzkuzCqRWauOs9w3K3smFAkVd3SVdcRT/HgI0oZyXM3Z5PEUZ7e0A4djm43eJ6WoNLytHDsV17h7cqCfEn0UnG2yaRyQ/Monn0TAVes/PnV4deipLJ78fTJjpYWFxHJwhPwt3SfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jnWFBqJz3eU3ZdCKPvEKESGJrf69bJXekkkq+25dl0=;
 b=iGqp3dDc0jnGelcbKq1F1dXJIHOejFG/NIw1f8C8KxWTe/qaIeecLlWC3JXVmQ25mPzvQfYrAwH8oduZIGiuNaJS2iFy/8G+f+5bBELGSj2Ti0XOZwe8rCKqnOVN7uLOhVsICX+Ag1VfBWG5Vrac1YpNbqGCB3xQoD3ArgjHf5s=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4948.namprd06.prod.outlook.com (10.167.240.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19; Thu, 23 Jan 2020 18:55:50 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 18:55:50 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Topic: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Index: AQHV0X6X/2P0WX5/m02FhMkM0gkT8Kf4lLeAgAAAvgCAAAUBgA==
Date:   Thu, 23 Jan 2020 18:55:50 +0000
Message-ID: <44325945a594ba9235393ce6344dd94ab4eaf3e7.camel@netapp.com>
References: <20200122234853.101576-1-dai.ngo@oracle.com>
         <3a456c6e607700ee745b19d82481ec7193ca08eb.camel@hammerspace.com>
         <e04a5d2e2ca57d932346d2372ec45ce32df84231.camel@hammerspace.com>
In-Reply-To: <e04a5d2e2ca57d932346d2372ec45ce32df84231.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d78437-3d18-446f-22fe-08d7a035dd7c
x-ms-traffictypediagnostic: BL0PR06MB4948:
x-microsoft-antispam-prvs: <BL0PR06MB494887F0DC7F9C8D18EEE5DBF80F0@BL0PR06MB4948.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(8676002)(15974865002)(36756003)(316002)(91956017)(76116006)(186003)(66446008)(66476007)(66556008)(71200400001)(5660300002)(2616005)(6512007)(64756008)(110136005)(81156014)(81166006)(66946007)(6506007)(8936002)(2906002)(86362001)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4948;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pdO325E36oOiIOITDJIQTArGvu7x1ZgzLjhqZbcb4qP5YUmsUWFfdE9Z+IBMPUloIBSJkigjH1SyF6nB1G1FR/R56ZFDW4ekgqfGnLsK2VoODiknEXzipYx5Zmnf7ss+FDNQB6xvb5yQouQdAGpz0WEskrAWA9gqNE40Nlzy1Mtb25TswJDgUM2uIFB0WkaJGAIKXKhtcbjE5PJd8D5fPMV7IJ7flM+RsQgaayaUaxslSGJnqMs0u35FZqk/JaxSxPBnhx6DGWBjok0Hdpd6U/j5GNU++XQpx+t1CmMkFZNUNYmF2tjQWW9lH5a7tVv8C7sSzpJUSVbK7AL3SWnw+qPBJvVi2zqVyCNgnYtafOiiIyO85a32RKQhdbr8l1Q+Nr2hwjFH0IpKGcJB1bm1/pbYI8G9GD8Os0t41CKE8betbvofzyvwmRpv1OAWQ8DpdFXpfRdmVgEBoq+JGtsI+QtwGL+XiR+wx33UoQyfz8=
x-ms-exchange-antispam-messagedata: 6HPElrzlgaejVzA9/bKx75hxfk/qhdLdh3HVGsuxo6o+IECH/Of4zloKG6HeIXpKrbSqXv/NAy+29TW8I5kytOeY7YAHqroHvkRCdvUE52iauSc1WRvJ0PUP5U7C5QZ9KCqTVgHAY6aE+X0MOaQNpQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E03431871E848469CDFE7B1D0DA9C09@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d78437-3d18-446f-22fe-08d7a035dd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 18:55:50.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3Tn4u9INySCJAk1j5SwUxHONCuZ0ghnayYEMd7+53u+VaoY1XMBJGZ3JKc3oIyK38CGOp9TZcrO3Cf2QW2yjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4948
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTIzIGF0IDE4OjM3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE5ldEFwcCBTZWN1cml0eSBXQVJOSU5HOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4g
DQo+IA0KPiBPbiBUaHUsIDIwMjAtMDEtMjMgYXQgMTA6MzUgLTA4MDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjAtMDEtMjIgYXQgMTg6NDggLTA1MDAsIERhaSBOZ28g
d3JvdGU6DQo+ID4gPiBXaGVuIHRoZSBkaXJlY3RvcnkgaXMgbGFyZ2UgYW5kIGl0J3MgYmVpbmcg
bW9kaWZpZWQgYnkgb25lIGNsaWVudA0KPiA+ID4gd2hpbGUgYW5vdGhlciBjbGllbnQgaXMgZG9p
bmcgdGhlICdscyAtbCcgb24gdGhlIHNhbWUgZGlyZWN0b3J5DQo+ID4gPiB0aGVuDQo+ID4gPiB0
aGUgY2FjaGUgcGFnZSBpbnZhbGlkYXRpb24gZnJvbSBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVz
IGNhdXNlcw0KPiA+ID4gdGhlIHJlYWRpbmcgY2xpZW50IHRvIGtlZXAgcmVzdGFydGluZyBSRUFE
RElSUExVUyBmcm9tIGNvb2tpZSAwDQo+ID4gPiB3aGljaCBjYXVzZXMgdGhlICdscyAtbCcgdG8g
dGFrZSBhIHZlcnkgbG9uZyB0aW1lIHRvIGNvbXBsZXRlLA0KPiA+ID4gcG9zc2libHkgbmV2ZXIg
Y29tcGxldGluZy4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5IHdoZW4gbmZzX2ZvcmNlX3VzZV9y
ZWFkZGlycGx1cyBpcyBjYWxsZWQgdG8gc3dpdGNoIGZyb20NCj4gPiA+IFJFQURESVIgdG8gUkVB
RERJUlBMVVMsIGl0IGludmFsaWRhdGVzIGFsbCB0aGUgY2FjaGVkIHBhZ2VzIG9mIHRoZQ0KPiA+
ID4gZGlyZWN0b3J5LiBUaGlzIGNhY2hlIHBhZ2UgaW52YWxpZGF0aW9uIGNhdXNlcyB0aGUgbmV4
dCBuZnNfcmVhZGRpcg0KPiA+ID4gdG8gcmUtcmVhZCB0aGUgZGlyZWN0b3J5IGNvbnRlbnQgZnJv
bSBjb29raWUgMC4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBpcyB0byBvcHRpbWlzZSB0aGUg
Y2FjaGUgaW52YWxpZGF0aW9uIGluDQo+ID4gPiBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzIGJ5
IG9ubHkgdHJ1bmNhdGluZyB0aGUgY2FjaGVkIHBhZ2VzIGZyb20NCj4gPiA+IGxhc3QgcGFnZSBp
bmRleCBhY2Nlc3NlZCB0byB0aGUgZW5kIHRoZSBmaWxlLiBJdCBhbHNvIG1hcmtzIHRoZQ0KPiA+
ID4gaW5vZGUgdG8gZGVsYXkgaW52YWxpZGF0aW5nIGFsbCB0aGUgY2FjaGVkIHBhZ2Ugb2YgdGhl
IGRpcmVjdG9yeQ0KPiA+ID4gdW50aWwgdGhlIG5leHQgaW5pdGlhbCBuZnNfcmVhZGRpciBvZiB0
aGUgbmV4dCAnbHMnIGluc3RhbmNlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYWkg
TmdvIDxkYWkubmdvQG9yYWNsZS5jb20+DQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gDQo+IFNvcnJ5IEkg
aW50ZW5kZWQgdGhpcyBmb3IgdGhlIFBBVENIdjIuLi4gSSd2ZSBsb29rZWQgdGhyb3VnaCB0aGF0
DQo+IHZlcnNpb24gYW5kIGl0IGxvb2tzIE9LIHRvIG1lLg0KPiANCj4gQW5uYSwgcGxlYXNlIGFw
cGx5IHRoZSBsYXRlciB2MiBpbnN0ZWFkIG9mIHRoaXMgb25lLi4uDQoNCkkgYXBwbGllZCB0aGUg
djIgYWJvdXQgNSBtaW51dGVzIGJlZm9yZSB5b3Ugc2VudCB0aGlzLiBJJ2xsIG1ha2Ugc3VyZSB5
b3VyDQpSZXZpZXdlZC1ieSBnZXRzIGFkZGVkIHRvIGl0LCB0b28gOikgDQoNCkFubmENCj4gDQo+
ID4gPiAtLS0NCj4gPiA+ICBmcy9uZnMvZGlyLmMgICAgICAgICAgIHwgMTQgKysrKysrKysrKysr
Ky0NCj4gPiA+ICBpbmNsdWRlL2xpbnV4L25mc19mcy5oIHwgIDMgKysrDQo+ID4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiA+IGluZGV4IGUx
ODAwMzNlMzVjZi4uM2ZiZjJlNDFkNTIzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL2Rpci5j
DQo+ID4gPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gPiA+IEBAIC00MzcsNyArNDM3LDEwIEBAIHZv
aWQgbmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyhzdHJ1Y3QgaW5vZGUNCj4gPiA+ICpkaXIpDQo+
ID4gPiAgICAgaWYgKG5mc19zZXJ2ZXJfY2FwYWJsZShkaXIsIE5GU19DQVBfUkVBRERJUlBMVVMp
ICYmDQo+ID4gPiAgICAgICAgICFsaXN0X2VtcHR5KCZuZnNpLT5vcGVuX2ZpbGVzKSkgew0KPiA+
ID4gICAgICAgICAgICAgc2V0X2JpdChORlNfSU5PX0FEVklTRV9SRFBMVVMsICZuZnNpLT5mbGFn
cyk7DQo+ID4gPiAtICAgICAgICAgICBpbnZhbGlkYXRlX21hcHBpbmdfcGFnZXMoZGlyLT5pX21h
cHBpbmcsIDAsIC0xKTsNCj4gPiA+ICsgICAgICAgICAgIG5mc196YXBfbWFwcGluZyhkaXIsIGRp
ci0+aV9tYXBwaW5nKTsNCj4gPiA+ICsgICAgICAgICAgIGlmIChORlNfUFJPVE8oZGlyKS0+dmVy
c2lvbiA9PSAzKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICBpbnZhbGlkYXRlX21hcHBpbmdf
cGFnZXMoZGlyLT5pX21hcHBpbmcsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
bmZzaS0+cGFnZV9pbmRleCArIDEsIC0xKTsNCj4gPiA+ICAgICB9DQo+ID4gPiAgfQ0KPiA+ID4g
DQo+ID4gPiBAQCAtNzA5LDYgKzcxMiw5IEBAIHN0cnVjdCBwYWdlDQo+ID4gPiAqZ2V0X2NhY2hl
X3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0KPiA+ID4gIGludCBmaW5kX2Nh
Y2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0KPiA+ID4gIHsNCj4gPiA+
ICAgICBpbnQgcmVzOw0KPiA+ID4gKyAgIHN0cnVjdCBpbm9kZSAqaW5vZGU7DQo+ID4gPiArICAg
c3RydWN0IG5mc19pbm9kZSAqbmZzaTsNCj4gPiA+ICsgICBzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7
DQo+ID4gPiANCj4gPiA+ICAgICBkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2UoZGVzYyk7DQo+
ID4gPiAgICAgaWYgKElTX0VSUihkZXNjLT5wYWdlKSkNCj4gPiA+IEBAIC03MTcsNiArNzIzLDEy
IEBAIGludCBmaW5kX2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90DQo+ID4gPiAq
ZGVzYykNCj4gPiA+ICAgICByZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+
ID4gPiAgICAgaWYgKHJlcyAhPSAwKQ0KPiA+ID4gICAgICAgICAgICAgY2FjaGVfcGFnZV9yZWxl
YXNlKGRlc2MpOw0KPiA+ID4gKw0KPiA+ID4gKyAgIGRlbnRyeSA9IGZpbGVfZGVudHJ5KGRlc2Mt
PmZpbGUpOw0KPiA+ID4gKyAgIGlub2RlID0gZF9pbm9kZShkZW50cnkpOw0KPiA+ID4gKyAgIG5m
c2kgPSBORlNfSShpbm9kZSk7DQo+ID4gPiArICAgbmZzaS0+cGFnZV9pbmRleCA9IGRlc2MtPnBh
Z2VfaW5kZXg7DQo+ID4gPiArDQo+ID4gPiAgICAgcmV0dXJuIHJlczsNCj4gPiA+ICB9DQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oIGIvaW5jbHVkZS9s
aW51eC9uZnNfZnMuaA0KPiA+ID4gaW5kZXggYzA2YjFmZDEzMGYzLi5hNWY4ZjAzZWNkNTkgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+ID4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L25mc19mcy5oDQo+ID4gPiBAQCAtMTY4LDYgKzE2OCw5IEBAIHN0cnVjdCBuZnNf
aW5vZGUgew0KPiA+ID4gICAgIHN0cnVjdCByd19zZW1hcGhvcmUgICAgIHJtZGlyX3NlbTsNCj4g
PiA+ICAgICBzdHJ1Y3QgbXV0ZXggICAgICAgICAgICBjb21taXRfbXV0ZXg7DQo+ID4gPiANCj4g
PiA+ICsgICAvKiB0cmFjayBsYXN0IGFjY2VzcyB0byBjYWNoZWQgcGFnZXMgKi8NCj4gPiA+ICsg
ICB1bnNpZ25lZCBsb25nICAgICAgICAgICBwYWdlX2luZGV4Ow0KPiA+ID4gKw0KPiA+ID4gICNp
ZiBJU19FTkFCTEVEKENPTkZJR19ORlNfVjQpDQo+ID4gPiAgICAgc3RydWN0IG5mczRfY2FjaGVk
X2FjbCAgKm5mczRfYWNsOw0KPiA+ID4gICAgICAgICAgLyogTkZTdjQgc3RhdGUgKi8NCj4gLS0N
Cj4gVHJvbmQgTXlrbGVidXN0DQo+IENUTywgSGFtbWVyc3BhY2UgSW5jDQo+IDQzMDAgRWwgQ2Ft
aW5vIFJlYWwsIFN1aXRlIDEwNQ0KPiBMb3MgQWx0b3MsIENBIDk0MDIyDQo+IHd3dy5oYW1tZXIu
c3BhY2UNCj4gDQo+IA0K
