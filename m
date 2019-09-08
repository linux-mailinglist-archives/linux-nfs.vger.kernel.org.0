Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA1ACF69
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2019 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfIHPTq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 11:19:46 -0400
Received: from mail-eopbgr780092.outbound.protection.outlook.com ([40.107.78.92]:39577
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfIHPTp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 8 Sep 2019 11:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLUaCUXJBvtYdD7OdfYWZvnfFp89YIJMf65NJ9gpGuCbGLewx/nXSmy2K0+Db/pL9LO6HHzT/IObeFACxImgL2Z1R2dNuimI4EOWmNHI1ZoJVvfBougPxQWTgxZLAf14Vab1A5TrkiCFC+F5nCWFe3tp2UtukzJZ+lwW5lDOBM/OHoZm9PLUIYl0DBjnfjn67oubo9snurEFqcmpIkQPz3m5Lk0wTb2hBItf1JXboQ6/Fw/GJyU+K5l1cyrgTJzl5b64f+7OFREwCq2bf2bW+SgGe6ajdfEopdE2Q4eYs9KlUfwl18vKZY98cLp7306wt/nStlfzhP/ZnxN35OLf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVLRhpyWFGtPnHxfQXCxBrNGS6t4HXiANOQLHvW1Wi4=;
 b=lhKtBGZw0Hxqm0DWJhAeC9ZKM/lvf1ofoDzUtmLKpjCIxeW9ZzsCS0jH8Vj+h8aZ+DjfN0hSR7LwtcqmzOj2DuXW+CuUCMCS1E2IqMS4OSf9mYdPS3vNpySHqTCdFV7vqhkSSa85CYVFQFlzgwa1CYdHpY0MUDwh0YlU7bLLl9+8tvC2Cz/qKefxTFqp8o0zRBdsnWuOsM7lsm2jrIdLn/4u5WHwfFi1q/MXAXoXt6xQ+u21IOmFdqKWSAq3OlKusTmb+VKXUMGzPCVEfeAKlpsB58AmT96amWhOLCHMY0e0VhAjk07Y4h1jTI8I0NBb5p1vQ/OA+FbFnudMZ8upOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVLRhpyWFGtPnHxfQXCxBrNGS6t4HXiANOQLHvW1Wi4=;
 b=H9qUQIwVh1krDNiCHrgk3QWvJbw90ArinfH9AfpM/T3Jj+NfGU0llU/oaiujn9tUn1qfFclkIG709XSz5+lfyVwQIUzBju5/P6BLfeWYZ6QP14c/Qll47SLVAMtJZCwTJhrVrFG3t4zukqyVo+jt3s8395WDZMcX1z4pVDi7Kjg=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1100.namprd13.prod.outlook.com (10.168.118.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Sun, 8 Sep 2019 15:19:40 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.005; Sun, 8 Sep 2019
 15:19:40 +0000
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
Thread-Index: AQHVUfDuoAq39fX+s0K+L+pluMBkM6cHnsTegAlOTYCAAAwCNIAJQZHggAAlEwCAABHoXoAAKhIAgABG1wuAA/3qgIAAZExXgAAA1wCAAoqWAIAAPZqA
Date:   Sun, 8 Sep 2019 15:19:40 +0000
Message-ID: <1ebf86cff330eb15c02249f0dac415a8aff99f49.camel@hammerspace.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
         <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
         <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
         <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
         <20190906144837.GD17204@fieldses.org>
         <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
         <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
         <A862CFCD-76A2-4373-8F44-F156DB38E6A5@redhat.com>
In-Reply-To: <A862CFCD-76A2-4373-8F44-F156DB38E6A5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa43c273-f30b-48fd-d7e4-08d7346ff832
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1100;
x-ms-traffictypediagnostic: DM5PR13MB1100:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB1100297592CEB03906CECFBBB8B40@DM5PR13MB1100.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0154C61618
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(189003)(199004)(81156014)(54906003)(14454004)(6246003)(53546011)(110136005)(14444005)(6486002)(256004)(6512007)(102836004)(81166006)(229853002)(86362001)(4326008)(508600001)(118296001)(25786009)(99286004)(5660300002)(7736002)(6306002)(2616005)(486006)(6116002)(3846002)(91956017)(476003)(36756003)(66066001)(11346002)(8936002)(6506007)(8676002)(446003)(2501003)(53936002)(26005)(71200400001)(71190400001)(186003)(966005)(76176011)(76116006)(66446008)(64756008)(66556008)(66476007)(6436002)(2906002)(305945005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1100;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBzOhXkV6iLghHp7XGUllwBSGxv7h8wD9Fb/FFD7Y23Q8iwE+N3boRG9pG+CGmqGCjdiwEo02Phv9z4LPzhftahmy82zRlHIfy3Bl9F/wLbEa3FVc92P0E8C9kGz8en5Y9EJTnUIMxTcvBOn0xyke2xlp/AQJplnEc4sC7/mHrYRtE7QtUuIUhsjgehhrVV0msH7/YPx1ACUtNqcp26e/GuB8/8k4poqpkP4cd62jMGVrPLYyngDy6edAuMfgSAGTZtTvp99Fek3jCn2iq6uZGttYhP0s8/UrUKrpwUCTAoPGJLJvCB0wvWnwK6BWLEmfgWXu8Hg2rrW0XLp+AeR0n+ZAy3EyX0Xweh4ArDD4uqSU36CZnTbpObo8PIQ4Gp2C06eEXE49MJ5U9K3YOvaF7hbNEkTrb/wBvWVBW1tPZw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAD66A8E5D47354D97A4A29E8F742923@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa43c273-f30b-48fd-d7e4-08d7346ff832
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2019 15:19:40.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LOLU2UBKbefs4jDHuMn0NW6qbniChdvIXc6pDTHCN+zejIw/vrhTkeVPcEYr28zTpBo6/RlscHGEql3kYLwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1100
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTA4IGF0IDA3OjM5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA2IFNlcCAyMDE5LCBhdCAxNjo1MCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+IA0K
PiA+ID4gT24gU2VwIDYsIDIwMTksIGF0IDQ6NDcgUE0sIEphc29uIEwgVGliYml0dHMgSUlJIDwN
Cj4gPiA+IHRpYmJzQG1hdGgudWguZWR1PiANCj4gPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gIkpCRiIgPT0gSiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPiB3
cml0ZXM6DQo+ID4gPiANCj4gPiA+IEpCRj4gVGhvc2UgcmVhZGRpciBjaGFuZ2VzIHdlcmUgY2xp
ZW50LXNpZGUsIHJpZ2h0PyAgQmFzZWQgb24NCj4gPiA+IHRoYXQgDQo+ID4gPiBJJ2QNCj4gPiA+
IEpCRj4gYmVlbiBhc3N1bWluZyBhIGNsaWVudCBidWcsIGJ1dCBtYXliZSBpdCdkIGJlIHdvcnRo
IGdldHRpbmcNCj4gPiA+IGEgDQo+ID4gPiBmdWxsDQo+ID4gPiBKQkY+IHBhY2tldCBjYXB0dXJl
IG9mIHRoZSByZWFkZGlyIHJlcGx5IHRvIG1ha2Ugc3VyZSBpdCdzIGxlZ2l0Lg0KPiA+ID4gDQo+
ID4gPiBJIGhhdmUgYmVlbiB3b3JraW5nIHdpdGggYmNvZGRpbmcgb24gSVJDIGZvciB0aGUgcGFz
dCBjb3VwbGUgb2YNCj4gPiA+IGRheXMgDQo+ID4gPiBvbg0KPiA+ID4gdGhpcy4gIEZvcnR1bmF0
ZWx5IEkgd2FzIGFibGUgdG8gY29tZSB1cCB3aXRoIHdheSB0byBmaWxsIHVwIGEgDQo+ID4gPiBk
aXJlY3RvcnkNCj4gPiA+IGluIHN1Y2ggYSB3YXkgdGhhdCBpdCB3aWxsIGZhaWwgd2l0aCBjZXJ0
YWludHkgYW5kIGFzIGEgYm9udXMNCj4gPiA+IGRvZXNuJ3QNCj4gPiA+IGluY2x1ZGUgYW55IHVz
ZXIgZGF0YSBzbyBJIGNhbiBmZWVsIE9LIGFib3V0IHNoYXJpbmcgcGFja2V0DQo+ID4gPiBjYXB0
dXJlcy4gDQo+ID4gPiAgSQ0KPiA+ID4gaGF2ZSBhIGNhcHR1cmUgYWxvbmdzaWRlIGEga2VybmVs
IHRyYWNlIG9mIHRoZSBwcm9ibGVtYXRpYw0KPiA+ID4gb3BlcmF0aW9uIA0KPiA+ID4gaW4NCj4g
PiA+IGh0dHBzOi8vd3d3Lm1hdGgudWguZWR1L350aWJicy9uZnMvLiAgTm90IHRoYXQgSSBjYW4N
Cj4gPiA+IHBhcnRpY3VsYXJseSANCj4gPiA+IHRlbGwNCj4gPiA+IGFueXRoaW5nIHVzZWZ1bCBm
cm9tIHRoYXQsIGJ1dCBiY29kZGluZyBzYXlzIHRoYXQgaXQgc2VlbXMgdG8NCj4gPiA+IHBvaW50
IA0KPiA+ID4gdG8NCj4gPiA+IHNvbWUgaXNzdWUgaW4gc3VucnBjLg0KPiA+ID4gDQo+ID4gPiBB
bmQgYmVjYXVzZSBJIGNhbiBlYXNpbHkgcmVwcm9kdWNlIHRoaXMgYW5kIEkgd2FzIGFibGUgdG8g
ZG8gYSANCj4gPiA+IGJpc2VjdDoNCj4gPiA+IA0KPiA+ID4gMmM5NGI4ZWNhMWEyNmNkNDYwMTBk
NmU3M2EyM2RhNWYyZTkzYTE5ZCBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KPiA+ID4gY29tbWl0
IDJjOTRiOGVjYTFhMjZjZDQ2MDEwZDZlNzNhMjNkYTVmMmU5M2ExOWQNCj4gPiA+IEF1dGhvcjog
Q2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiBEYXRlOiAgIE1vbiBG
ZWIgMTEgMTE6MjU6NDEgMjAxOSAtMDUwMA0KPiA+ID4gDQo+ID4gPiAgICBTVU5SUEM6IFVzZSBh
dV9yc2xhY2sgd2hlbiBjb21wdXRpbmcgcmVwbHkgYnVmZmVyIHNpemUNCj4gPiA+IA0KPiA+ID4g
ICAgYXVfcnNsYWNrIGlzIHNpZ25pZmljYW50bHkgc21hbGxlciB0aGFuIChhdV9jc2xhY2sgPDwg
MikuDQo+ID4gPiBVc2luZw0KPiA+ID4gICAgdGhhdCB2YWx1ZSByZXN1bHRzIGluIHNtYWxsZXIg
cmVjZWl2ZSBidWZmZXJzLiBJbiBzb21lIGNhc2VzDQo+ID4gPiB0aGlzDQo+ID4gPiAgICBlbGlt
aW5hdGVzIGFuIGV4dHJhIHNlZ21lbnQgaW4gUmVwbHkgY2h1bmtzIChSUEMvUkRNQSkuDQo+ID4g
PiANCj4gPiA+ICAgIFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFj
bGUuY29tPg0KPiA+ID4gICAgU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFrZXIgPEFubmEuU2No
dW1ha2VyQE5ldGFwcC5jb20+DQo+ID4gPiANCj4gPiA+IDowNDAwMDAgMDQwMDAwIGQ0ZDFjZTJm
YmUwMDM1YzViZDlkZjk3NmI4YzQ0OGRmODVkY2I1MDUgDQo+ID4gPiA3MDExYTc5MmRmZTcyZmY5
Y2Q3MGQ2NmU0NWQzNTNmM2Q3ODE3ZTNlIE0gICAgICBuZXQNCj4gPiA+IA0KPiA+ID4gQnV0IG9m
IGNvdXJzZSwgSSBjYW4ndCBzYXkgd2hldGhlciB0aGlzIGlzIHRoZSBhY3R1YWwgYmFkIGNvbW1p
dA0KPiA+ID4gb3INCj4gPiA+IHdoZXRoZXIgaXQganVzdCBpbnRyb2R1Y2VkIGEgYmVoYXZpb3Ig
Y2hhbmdlIHdoaWNoIGFsdGVycyB0aGUgDQo+ID4gPiBjb25kaXRpb25zDQo+ID4gPiB1bmRlciB3
aGljaCB0aGUgcHJvYmxlbSBhcHBlYXJzLg0KPiA+IA0KPiA+IFRoZSBmaXJzdCBwbGFjZSBJJ2Qg
c3RhcnQgbG9va2luZyBpcyB0aGUgWERSIGNvbnN0YW50cyBhdCB0aGUgaGVhZA0KPiA+IG9mIA0K
PiA+IGZzL25mcy9uZnM0eGRyLmMNCj4gPiBoYXZpbmcgdG8gZG8gd2l0aCBSRUFERElSLg0KPiA+
IA0KPiA+IFRoZSByZXBvcnQgb2YgYmVoYXZpb3IgY2hhbmdlcyB3aXRoIHRoZSB1c2Ugb2Yga3Ji
NXAgYWxzbyBtYWtlcw0KPiA+IHRoaXMgDQo+ID4gY29tbWl0IHBsYXVzaWJsZS4NCj4gDQo+IEFm
dGVyIHNwcmlua2xpbmcgdGhlIHByaW50aydzLCB3ZSdyZSBjb21pbmcgdXAgb25lIHdvcmQgc2hv
cnQgaW4gdGhlIA0KPiByZWNlaXZlDQo+IGJ1ZmZlci4gIEkgdGhpbmsgd2UncmUgbm90IGFjY291
bnRpbmcgZm9yIHRoZSB4ZHIgcGFkIG9mIGJ1Zi0+cGFnZXMNCj4gZm9yIA0KPiBORlM0DQo+IHJl
YWRkaXIgLS0gYnV0IEkgbmVlZCB0byBjaGVjayB0aGUgUkZDcy4gIEFueW9uZSBrbm93IGlmIHY0
IFJFQURESVIgDQo+IHJlc3VsdHMNCj4gaGF2ZSB0byBiZSBhbGlnbmVkPw0KPiANCj4gQWxzbyBu
ZWVkIHRvIGNoZWNrIGp1c3Qgd2h5IGtyYjVpIGlzIHRoZSBvbmx5IGF1dGggdGhhdCBjYXJlcy4u
DQo+IA0KDQpJJ20gbm90IHNlZWluZyB0aGF0LiBJZiB5b3UgbG9vayBhdCBjb21taXQgMDJlZjA0
ZTQzMmJhLCB5b3UnbGwgc2VlDQp0aGF0IENodWNrIGRpZCBhZGQgYSAncGFkZGluZyB0ZXJtJyB0
byBkZWNvZGVfcmVhZGRpcl9tYXhzeiBpbiB0aGUNCk5GU3Y0IGNhc2UuDQpUaGUgb3RoZXIgdGhp
bmcgdG8gcmVtZW1iZXIgaXMgdGhhdCBhIHJlYWRkaXIgJ2Rpcmxpc3Q0JyBlbnRyeSBpcw0KYWx3
YXlzIHdvcmQgYWxpZ25lZCAoaXJyZXNwZWN0aXZlIG9mIHRoZSBsZW5ndGggb2YgdGhlIGZpbGVu
YW1lKSwgc28NCnRoZXJlIGlzIG5vIHBhZGRpbmcgdGhhdCBuZWVkcyB0byBiZSB0YWtlbiBpbnRv
IGFjY291bnQuDQoNCkkgdGhpbmsgd2UgcHJvYmFibHkgcmF0aGVyIHdhbnQgdG8gbG9vayBhdCBo
b3cgYXV0aC0+YXVfcmFsaWduIGlzIGJlaW5nDQpjYWxjdWxhdGVkIGZvciB0aGUgY2FzZSBvZiBr
cmI1aS4gSSdtIHJlYWxseSBub3QgdW5kZXJzdGFuZGluZyB3aHkNCmF1dGgtPmF1X3JhbGlnbiBz
aG91bGQgbm90IHRha2UgaW50byBhY2NvdW50IHRoZSBwcmVzZW5jZSBvZiB0aGUgbWljLg0KQ2h1
Y2s/DQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
