Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECDB0F26
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfILMxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 08:53:35 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:52237
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731733AbfILMxf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 08:53:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhqhzxcSwN/79xZCPDWkw+Xq5Hev/GOOi0hkGjYRUX4UjQCwRtLgHtfHTs8RLghE9qrSDRunTnno7Cvs4zSFVBVKLNc8/IsOfR5iuWjPOQf9j7OFdH+vCmRjWZTkCpFKfi3gi4wO1tKvG7ilQG5c1fKlEOzB+FKrllcFrfCC6sV/laGDi643+GAn5jrPmzmn7SEz4Ja4p7XMrIQPdYrL4pyI4d+7MpVZH0cPbge9H4TDFldW5a1WrGfzgnGZ99xCoUwgcX3Yaw17Jr7TWc0lDww1BqeWY8ZN6xZFThiDsB+b9Fxv5xOVS1uzLtHwphs36ex/TFcsCqCg2MDbR1XmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y/IubvSeSxvqcnT622Bmd3Ynx/dkv0VOxT6Oc0ow5w=;
 b=V6r7M3wlWaFnzncM94bjgnajs0Q/qYiraSMZMsO9ThDfh6TpxhfQ1ApLzNpnByZhIDR1+MVReHDOw+MQOcLmOlx/a3eQ+n0fYKutL6qjwSVM2wTUjBuuqvNPN8FY6m6VGp3D60z88WID3Hlnjima7TQ7iVCU9ppMGye05vfX3IBIppVKQwxtehdMvm1mKf0FU5oTjzX31ifbpKm5s/i7+k7/8AdyWsgAxt5aPeUKEjR+p5g7bpLPQXgvRSccGJbjwIU4TI8WcW8S2m47CLbwChQevsNeghpyM7nv2oZzN4g3Nx2WM427E+sjDbxJXH7f1X9zcujvOZgGoA55BOaQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y/IubvSeSxvqcnT622Bmd3Ynx/dkv0VOxT6Oc0ow5w=;
 b=ILjitSpMHzfqr7leNEnohNFtn6DxAMxChOHpUKz9Tbc5roweQD9H+EzCfldVkkVUWH6UzdTuDxFmamu7G2wNaLtkx3fzGuMjfRWKflph2rHi+dV7WONgJlV/OUFSyGhD7QljVWjSLV70SDroVs849Mz+b0CKCgTpnZtRaFo7Kpc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1497.namprd13.prod.outlook.com (10.175.110.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Thu, 12 Sep 2019 12:53:17 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 12:53:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux@stwm.de" <linux@stwm.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "km@cm4all.com" <km@cm4all.com>
Subject: Re: Regression in 5.1.20: Reading long directory fails
Thread-Topic: Regression in 5.1.20: Reading long directory fails
Thread-Index: AQHVUfDuoAq39fX+s0K+L+pluMBkM6cHnsTegAlOTYCAAAwCNIAJQZHggAAlEwCAABHoXoAAKhIAgABG1wuAA/3qgIAAZExXgAAA1wCAB5GfgIAAA/sAgAAM/YCAAADmAIAAAysAgAACpICAAAEVAIABN6+AgAAGjQA=
Date:   Thu, 12 Sep 2019 12:53:16 +0000
Message-ID: <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
         <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
         <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
         <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
         <20190906144837.GD17204@fieldses.org>
         <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
         <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
         <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
         <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
         <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
         <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
         <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
         <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
         <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
         <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
In-Reply-To: <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6890cdf-eb7c-4358-1195-08d737802ea0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1497;
x-ms-traffictypediagnostic: DM5PR13MB1497:
x-microsoft-antispam-prvs: <DM5PR13MB14972107173B5841DBF20289B8B00@DM5PR13MB1497.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(199004)(189003)(446003)(25786009)(229853002)(256004)(66066001)(102836004)(36756003)(4326008)(6512007)(5660300002)(7736002)(11346002)(486006)(53546011)(6506007)(66446008)(71200400001)(66476007)(64756008)(71190400001)(66946007)(305945005)(26005)(76176011)(86362001)(14454004)(508600001)(54906003)(8676002)(81156014)(53936002)(110136005)(14444005)(99286004)(118296001)(66556008)(81166006)(8936002)(6116002)(2616005)(476003)(186003)(76116006)(6436002)(91956017)(2501003)(6486002)(6246003)(2906002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1497;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e+xIIpip4rNgRsP48VpsdlVKBhoMIgDc454KYwkXhPegg5op9/DdTes8TnKqlVHM+io/sYmLdn37EoMOPTbYwvhTEv+8lxAeZY0a8xnvtvIZ6YbvL0DX9Vj3JkVmiT9ox4IcT82JQlW3ViT4H15vAHjYLBmRUeU6COq0ry+zsO5d26fdwIJrVaa1zQRFPoc8nDNZYMu+G6VZrbwE+QXm3KQAajgcWK5xrLM2sCrWTElu0KtcnOpaORroxwttONNq+QO34FdKe+nfb53NtfNuJ7ZhGpFCGXdv2Mg6E3NA6WS+sH1X510psCPn9EG4J2qzlLTMlTaCRCmm8TC4QOmmArv2eJ2P8rjxob+ZQ2uWD39DPDRZwygFmBTQFA9VYwV+Q/dLmu09SZQPpAE9fKPFkoDD+GaIu0MUWtQ6Clyt1t4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0128C3CC7EFFF4B9DC284D8D6867D02@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6890cdf-eb7c-4358-1195-08d737802ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 12:53:17.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pe8tX8CshWn3YYPTKvn4k6PabZiJF1bnCTmw+f90jcBInALMsR2OiRiHPSBHuOSr47fSoyobDnBWTDkLYE7a4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1497
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDA4OjI5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxMSBTZXAgMjAxOSwgYXQgMTM6NTQsIENodWNrIExldmVyIHdyb3RlOg0KPiAN
Cj4gPiA+IE9uIFNlcCAxMSwgMjAxOSwgYXQgMTo1MCBQTSwgQmVuamFtaW4gQ29kZGluZ3RvbiAN
Cj4gPiA+IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gMTEg
U2VwIDIwMTksIGF0IDEzOjQwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiA+IE9uIDExIFNlcCAyMDE5LCBhdCAxMzoyOSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gT24gU2VwIDExLCAyMDE5LCBhdCAxOjI2IFBNLCBCZW5qYW1pbiBD
b2RkaW5ndG9uIA0KPiA+ID4gPiA+ID4gPGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIDExIFNlcCAyMDE5LCBhdCAx
MjozOSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBP
biBTZXAgMTEsIDIwMTksIGF0IDEyOjI1IFBNLCBCZW5qYW1pbiBDb2RkaW5ndG9uIA0KPiA+ID4g
PiA+ID4gPiA+IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiBJbnN0ZWFkLCBJIHRoaW5rIHdlIHdhbnQgdG8gbWFrZSBzdXJlIHRo
ZSBtaWMgZmFsbHMNCj4gPiA+ID4gPiA+ID4gPiBzcXVhcmVseSANCj4gPiA+ID4gPiA+ID4gPiBp
bnRvIHRoZSB0YWlsDQo+ID4gPiA+ID4gPiA+ID4gZXZlcnkgdGltZS4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IEknbSBub3QgY2xlYXIgaG93IHlvdSBjb3VsZCBkbyB0aGF0LiBUaGUg
bGVuZ3RoIG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiBwYWdlIGRhdGEgDQo+ID4gPiA+ID4gPiA+IGlz
IG5vdA0KPiA+ID4gPiA+ID4gPiBrbm93biB0byB0aGUgY2xpZW50IGJlZm9yZSBpdCBwYXJzZXMg
dGhlIHJlcGx5LiBBcmUgeW91IA0KPiA+ID4gPiA+ID4gPiBzdWdnZXN0aW5nIHRoYXQNCj4gPiA+
ID4gPiA+ID4gZ3NzX3Vud3JhcCBzaG91bGQgZG8gaXQgc29tZWhvdz8NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gSXMgaXQgdG9vIG5pYXZlIHRvIGFsd2F5cyBwdXQgdGhlIG1pYyBhdCB0aGUg
ZW5kIG9mIHRoZQ0KPiA+ID4gPiA+ID4gdGFpbD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUg
c2l6ZSBvZiB0aGUgcGFnZSBjb250ZW50IGlzIHZhcmlhYmxlLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFRoZSBvbmx5IHdheSB0aGUgTUlDIHdpbGwgZmFsbCBpbnRvIHRoZSB0YWlsIGlzIGlmIHRo
ZSBwYWdlDQo+ID4gPiA+ID4gY29udGVudCANCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGV4YWN0
bHkgdGhlIGxhcmdlc3QgZXhwZWN0ZWQgc2l6ZS4gV2hlbiB0aGUgcGFnZSBjb250ZW50IGlzDQo+
ID4gPiA+ID4gc21hbGxlciANCj4gPiA+ID4gPiB0aGFuDQo+ID4gPiA+ID4gdGhhdCwgdGhlIHJl
Y2VpdmUgbG9naWMgd2lsbCBwbGFjZSBwYXJ0IG9yIGFsbCBvZiB0aGUgTUlDIGluIA0KPiA+ID4g
PiA+IC0+cGFnZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBPaywgcmlnaHQuICBCdXQgd2hhdCBJIG1l
YW50IGlzIHRoYXQgeGRyX2J1Zl9yZWFkX25ldG9iaigpDQo+ID4gPiA+IHNob3VsZCBiZSANCj4g
PiA+ID4gcmVuYW1lZA0KPiA+ID4gPiBhbmQgcmVwdXJwb3NlZCB0byBiZSAibW92ZSB0aGUgbWlj
IGZyb20gd2hlcmV2ZXIgaXQgaXMgdG8gdGhlDQo+ID4gPiA+IGVuZCBvZg0KPiA+ID4gPiB4ZHJf
YnVmJ3MgdGFpbCIuDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgbm93IEkgc2VlIHdoYXQgeW91IG1l
YW4sIGFuZCBJIGFsc28gc2VlIHRoYXQgaXQgaXMgYWxyZWFkeSANCj4gPiA+ID4gdHJ5aW5nIHRv
IGRvDQo+ID4gPiA+IHRoYXQuLiBhbmQgd2UgZG9uJ3Qgd2FudCB0byBvdmVybGFwIHRoZSBjb3B5
Li4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvLCByZWFsbHksIHdlIG5lZWQgdGhlIHRhaWwgdG8gYmUg
bGFyZ2VyIHRoYW4gdHdpY2UgdGhlIG1pYy4uDQo+ID4gPiA+IGxlc3MgDQo+ID4gPiA+IDEuICBU
aGF0DQo+ID4gPiA+IG1lYW5zIHRoZSBmaXggaXMgcHJvYmFibHkganVzdCBpbmNyZWFzaW5nIHJz
bGFjayBmb3Iga3JiNWkuDQo+ID4gPiANCj4gPiA+IC4uIG9yIHdlIGNhbiBrZWVwIHRoZSB0aWdo
dGVyIHRhaWwgc3BhY2UsIGFuZCBpZiB3ZSBkZXRlY3QgdGhlDQo+ID4gPiBtaWMgDQo+ID4gPiBz
dHJhZGRsZXMNCj4gPiA+IHRoZSBwYWdlIGFuZCB0YWlsLCB3ZSBjYW4gbW92ZSB0aGUgbWljIGlu
dG8gdGhlIHRhaWwgd2l0aCAyDQo+ID4gPiBjb3BpZXMsIA0KPiA+ID4gZmlyc3QNCj4gPiA+IG1v
dmUgdGhlIGJpdCBpbiB0aGUgdGFpbCBiYWNrLCB0aGVuIG1vdmUgdGhlIGJpdCBpbiB0aGUgcGFn
ZXMuDQo+ID4gPiANCj4gPiA+IFdoaWNoIGlzIHByZWZlcnJlZCwgbGVzcyBhbGxvY2F0aW9uLCBv
ciBpbiB0aGUgcmFyZSBjYXNlIHRoaXMNCj4gPiA+IG9jY3VycywgDQo+ID4gPiBkb2luZw0KPiA+
ID4gY29weSB0d2ljZT8NCj4gPiANCj4gPiBJdCBzb3VuZHMgbGlrZSB0aGUgYnVnIGlzIHRoYXQg
dGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBkZWFsIA0KPiA+IGNvcnJlY3RseQ0KPiA+IHdoZW4g
dGhlIE1JQyBjcm9zc2VzIHRoZSBib3VuZGFyeSBiZXR3ZWVuIC0+cGFnZXMgYW5kIC0+dGFpbD8g
SSdkDQo+ID4gbGlrZQ0KPiA+IHRvIHNlZSB0aGF0IGFkZHJlc3NlZCByYXRoZXIgdGhhbiBjaGFu
Z2luZyByc2xhY2suDQo+IA0KPiBIZXJlJ3Mgd2hhdCBJJ20gYWJvdXQgdG8gcnVuIHRocm91Z2gg
bXkgdGVzdGluZzoNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1
bnJwYy94ZHIuYw0KPiBpbmRleCA0OGM5M2I5ZTUyNWUuLmQ2ZmZjOTAxMTI2OSAxMDA2NDQNCj4g
LS0tIGEvbmV0L3N1bnJwYy94ZHIuYw0KPiArKysgYi9uZXQvc3VucnBjL3hkci5jDQo+IEBAIC0x
MjM4LDE0ICsxMjM4LDIxIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHhkcl9lbmNvZGVfd29yZCk7DQo+
IA0KPiAgIC8qIElmIHRoZSBuZXRvYmogc3RhcnRpbmcgb2Zmc2V0IGJ5dGVzIGZyb20gdGhlIHN0
YXJ0IG9mIHhkcl9idWYNCj4gaXMgDQo+IGNvbnRhaW5lZA0KPiAgICAqIGVudGlyZWx5IGluIHRo
ZSBoZWFkIG9yIHRoZSB0YWlsLCBzZXQgb2JqZWN0IHRvIHBvaW50IHRvIGl0OyANCj4gb3RoZXJ3
aXNlDQo+IC0gKiB0cnkgdG8gZmluZCBzcGFjZSBmb3IgaXQgYXQgdGhlIGVuZCBvZiB0aGUgdGFp
bCwgY29weSBpdCB0aGVyZSwNCj4gYW5kDQo+IC0gKiBzZXQgb2JqIHRvIHBvaW50IHRvIGl0LiAq
Lw0KPiArICogdHJ5IHRvIGZpbmQgc3BhY2UgZm9yIGl0IGF0IHRoZSBlbmQgb2YgdGhlIHRhaWws
IGFuZCBjb3B5IGl0DQo+IHRoZXJlLiAgDQo+IElmDQo+ICsgKiB0aGUgbmV0b2JqIGlzIHBhcnRs
eSB3aXRoaW4gdGhlIHBhZ2UgZGF0YSBhbmQgdGFpbCwgc2hyaW5rIHRoZQ0KPiBwYWdlcyANCj4g
dG8NCj4gKyAqIG1vdmUgdGhlIG9iamVjdCBpbnRvIHRoZSB0YWlsICovDQo+ICAgaW50IHhkcl9i
dWZfcmVhZF9uZXRvYmooc3RydWN0IHhkcl9idWYgKmJ1Ziwgc3RydWN0IHhkcl9uZXRvYmoNCj4g
Km9iaiwgDQo+IHVuc2lnbmVkIGludCBvZmZzZXQpDQo+ICAgew0KPiAgICAgICAgICBzdHJ1Y3Qg
eGRyX2J1ZiBzdWJidWY7DQo+ICsgICAgICAgdW5zaWduZWQgaW50IHBhZ2VfcmFuZ2U7DQo+IA0K
PiAgICAgICAgICBpZiAoeGRyX2RlY29kZV93b3JkKGJ1Ziwgb2Zmc2V0LCAmb2JqLT5sZW4pKQ0K
PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiArDQo+ICsgICAgICAgcGFnZV9y
YW5nZSA9IGJ1Zi0+aGVhZC0+aW92X2xlbiArIGJ1Zi0+cGFnZV9sZW4gLSBvZmZzZXQgKyA0Ow0K
PiArICAgICAgIGlmIChwYWdlX3JhbmdlID4gMCAmJiBwYWdlX3JhbmdlIDwgb2JqLT5sZW4pDQo+
ICsgICAgICAgICAgICAgICB4ZHJfc2hyaW5rX3BhZ2VsZW4oYnVmLCBwYWdlX3JhbmdlKTsNCj4g
Kw0KPiAgICAgICAgICBpZiAoeGRyX2J1Zl9zdWJzZWdtZW50KGJ1ZiwgJnN1YmJ1Ziwgb2Zmc2V0
ICsgNCwgb2JqLT5sZW4pKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiAN
Cj4gDQoNCkxldCdzIHBsZWFzZSBqdXN0IHNjcmFwIHRoaXMgZnVuY3Rpb24gYW5kIHJld3JpdGUg
aXQgYXMgYSBnZW5lcmljDQpmdW5jdGlvbiBmb3IgcmVhZGluZyB0aGUgTUlDLiBJdCBjbGVhcmx5
IGlzIG5vdCBhIGdlbmVyaWMgZnVuY3Rpb24gZm9yDQpyZWFkaW5nIGFyYml0cmFyeSBuZXRvYmpz
LCBhbmQgbW9kaWZpY2F0aW9ucyBsaWtlIHRoZSBhYm92ZSBqdXN0IG1ha2UNCnRoZSBtaXNub21l
ciBwYWluZnVsbHkgb2J2aW91cy4NCg0KTGV0J3MgcmV3cml0ZSBpdCBhcyB4ZHJfYnVmX3JlYWRf
bWljKCkgc28gdGhhdCB3ZSBjYW4gc2ltcGxpZnkgaXQgd2hlcmUNCnBvc3NpYmxlLg0KDQoNClRo
YW5rcw0KICBUcm9uZA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
