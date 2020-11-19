Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4492B94B1
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgKSOee (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 09:34:34 -0500
Received: from mail-dm6nam10on2125.outbound.protection.outlook.com ([40.107.93.125]:17281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbgKSOed (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Nov 2020 09:34:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNHcp6ZAtgOVBftwcFYYiyQ+jcSKfg9oDvOwqoUDvZfexm0TBFL6GYGG4cvl2R0uUADwVS413Nc1qd+0xWi3b4fP6Ai4nK7D9NgiNTCJnOoAeSUE6gFidXeUgNUDwRwaNRHafIsmPP0jWmbeg0rHq125eccyAJYi7SWwh7N0qx8lleO6EsOBkox75Hyau6Fa3gZNgizY+kNEfXTWbSJltKDZj4F2lrWDbJrWBju2E2uqpKfT+nxX10tKyUCEDIFNDbqAvL2tsLUYz9v0+mvEDhTMMhpZIanqRgZw+WRHDdpJlETbmdS/QnuFD9kNM7TPtRT8Xh5khrMWYrFuXjbIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NRr7UHrvXh0Q4cyCBv9OJUgtQoHJCRtybQ8EMKWRwI=;
 b=R9Zg/v5Z1o7W5oamcjjHFUxznQnl0a31Umsp2K0N2ewn0JzVRr9AUzpF6L3vQpUeED4RnS7+fv6ohrUGUCevMVHFFpQzodr1kD6gxVWwRMAJxA7q1asCHD2BdW2+R0EhmsgYEp7VvYsDuDoYtAywkwV5L/mcW4xBetfXQ6Mb0dux6aGDTDl0vhwNDwqkBT/8vPuTh5mLVN6H+/ChqhlL4secxSxrWj9b2qWgSMPZrDJpQ/4lICC8R6hrGjEtj2wcIeUFS+XWxkkKag0ljlvVawCF52l0gUAKkdcsjwaNVX/tMFpuWth71PXY1Q1kUJfvB4KHHKQEzgStT56CP702DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NRr7UHrvXh0Q4cyCBv9OJUgtQoHJCRtybQ8EMKWRwI=;
 b=eT0k7JmcQRN/D0WbhJzaV8TsEOE/VTkLYcOVRzEQk11cjfw3Q11HXY5WHtMwoh6lR0+mWTgV2y6HkN3hQuMnxFIHtXLpgr90oV38ivj7NtMm0jPrkNEQyLsig30j23ktvcOkMyBJseMBaMh6SNOU94vNyP3iaU3cGFsf5e059yQ=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2941.namprd13.prod.outlook.com (2603:10b6:208:13d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.9; Thu, 19 Nov
 2020 14:34:29 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Thu, 19 Nov 2020
 14:34:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Topic: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Index: AQHWvfkXUHuTZLUV8keMpBIY5a4z6anPgYwAgAADcYCAAACHAIAAALUA
Date:   Thu, 19 Nov 2020 14:34:29 +0000
Message-ID: <6f13978155f7f6fd6cc885f9efdb13c0e890faf3.camel@hammerspace.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
         <20201118221939.20715-2-trondmy@kernel.org>
         <20201118221939.20715-3-trondmy@kernel.org>
         <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
         <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
         <D322F599-E680-4715-AD9A-CC6017AFF8E0@oracle.com>
In-Reply-To: <D322F599-E680-4715-AD9A-CC6017AFF8E0@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f751f987-eafe-45ac-29b9-08d88c98390b
x-ms-traffictypediagnostic: MN2PR13MB2941:
x-microsoft-antispam-prvs: <MN2PR13MB2941660BCF313A7529E12F26B8E00@MN2PR13MB2941.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApJ5KF74Wqs5E86eVmXpe5FfC2YNn9hLbq4AQl9GbbuoJy292X+QTNyHrFstisU32OC6zPCQWp4LvgX3VJ+BfLKx5a6hTLDhrM2QgagPqXmma81LLYOt7lO20f7SmSw0wxQM8mqayRi6bk8dRN2XM3orVVAExNTAsQ6DSC0OwL1EBAf+qViU172oqy4RIgeFIXTB4rmk930fYx5fw0pTQe8ws5ICjLUhLRCfI1dRyBGqSh+eeFGBobPf4ePIasyRXES7ndPMRvmSkUHQlLFpICDlA8NjgGip7nywZDNSQ4jWjKfuY/uTLvPoi91pzMIu6x4ejj4IxMy5pJFKPzBOxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(376002)(39840400004)(8936002)(8676002)(5660300002)(83380400001)(6512007)(6486002)(36756003)(4001150100001)(71200400001)(4326008)(2906002)(66556008)(6916009)(478600001)(2616005)(26005)(6506007)(186003)(53546011)(316002)(86362001)(76116006)(66446008)(66476007)(64756008)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WlkHhnu50xBMkrJTdp87WRkArNwLl6qVI7z2Yrbs4Mk1ABT+48bCO3hf30XoMG0VGMVN94zoAcI5xJrNYWa2o2mFfZUhCwOm+g/kzDOQZrndZzZYzNdc19RFMTvYa1963cLLEFpRgED5T3VFwNKinSOI1tpvQtra+9Uq4HwB5GoUiZ7I9Lu3gbM7V8NRf/+VEZQPics1ePdIQoxzEj9kwgTCNY4TQ+aJ8iBvVWnk4frxEzl14dNqboIIgME+RgQ4BayqSBT10/5q9A2ywnS9Tk2U07bY8fhsYUoc5JiScnmBwHUVEl4EUwfVLYDHAL++ZHtjB91K8hohNeBiNho5k3YwQ1JFKCblru949bDnAdp/D2aFz/YdO3+QceFSsreUzsvsnJ2aHxSQLVAo6OR1Ss4/jwTrj3v/KYHtGrsOdGHSaPmDdbNUdSxR5oRkU5VTy9X5Dt3u802xAPBOO/ArNk5poxhIWtMitAXjKUTGKMe/UiH6oma/osXit8m0g9VZCQpAO7+2Qo1ahql/FYhpoGR1yyH+UiRGDNrT2vctKk2Lhn6ZuuGHFosE+ONhOKoYeQzF8g3UpuCMJJyPALfSKNryabV4zs44Kkte+WVksj+9ujnlQ6hYVbylRgUkxW4xIj6Gah7rm5sI9HcHBsYAng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDFDD07C911F1F449799A49FC63EBD93@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f751f987-eafe-45ac-29b9-08d88c98390b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 14:34:29.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnDyIbCamIi+qOzzR07G1HAoaNDOWRasOhpo5SZY2HZ0f1fB2dQXJd+RfGIWeJWhWtyr+Xn7boEHhcYgVVTlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2941
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDA5OjMxIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiAxOSwgMjAyMCwgYXQgOTozMCBBTSwgVHJvbmQgTXlrbGVidXN0IDwN
Cj4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAy
MDIwLTExLTE5IGF0IDA5OjE3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiA+IE9uIE5vdiAxOCwgMjAyMCwgYXQgNToxOSBQTSwgdHJvbmRteUBrZXJuZWwu
b3JnwqB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoZW4gZG9p
bmcgYSByZWFkKCkgaW50byBhIHBhZ2UsIHdlIGFsc28gZG9uJ3QgY2FyZSBpZiB0aGUgbnVsDQo+
ID4gPiA+IHBhZGRpbmcNCj4gPiA+ID4gc3RheXMgaW4gdGhhdCBsYXN0IHBhZ2Ugd2hlbiB0aGUg
ZGF0YSBsZW5ndGggaXMgbm90IDMyLWJpdA0KPiA+ID4gPiBhbGlnbmVkLg0KPiA+ID4gDQo+ID4g
PiBXaGF0IGlmIHRoZSBSRUFEIHBheWxvYWQgbGFuZHMgaW4gdGhlIG1pZGRsZSBvZiBhIGZpbGU/
IFRoZQ0KPiA+ID4gcGFkIG9uIHRoZSBlbmQgd2lsbCBvdmVyd3JpdGUgZmlsZSBjb250ZW50IGp1
c3QgcGFzdCB3aGVyZQ0KPiA+ID4gdGhlIFJFQUQgcGF5bG9hZCBsYW5kcy4NCj4gPiANCj4gPiBJ
ZiB0aGUgc2l6ZSA+IGJ1Zi0+cGFnZV9sZW4sIHRoZW4gaXQgZ2V0cyB0cnVuY2F0ZWQgaW4NCj4g
PiB4ZHJfYWxpZ25fcGFnZXMoKSBhZmFpay4NCj4gDQo+IEkgd2lsbCBuZWVkIHRvIGNoZWNrIGhv
dyBSUEMvUkRNQSBiZWhhdmVzLiBJdCBtaWdodCBidWlsZCBhDQo+IGNodW5rIHRoYXQgaW5jbHVk
ZXMgdGhlIHBhZCBpbiB0aGlzIGNhc2UsIHdoaWNoIHdvdWxkIGJyZWFrDQo+IHRoaW5ncy4NCg0K
VGhhdCB3b3VsZCBiZSBhIGJ1ZyBpbiB0aGUgZXhpc3RpbmcgY29kZSB0b28sIHRoZW4uIEl0IHNo
b3VsZG4ndCBiZQ0Kd3JpdGluZyBiZXlvbmQgdGhlIGJ1ZmZlciBzaXplIHdlIHNldCBpbiB0aGUg
TkZTIGxheWVyLg0KDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdA0KPiA+
ID4gPiA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IGZzL25mcy9uZnMyeGRyLmMgfCAyICstDQo+ID4gPiA+IGZzL25mcy9uZnMzeGRyLmMgfCAy
ICstDQo+ID4gPiA+IGZzL25mcy9uZnM0eGRyLmMgfCAyICstDQo+ID4gPiA+IDMgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnMyeGRyLmMgYi9mcy9uZnMvbmZzMnhkci5jDQo+ID4gPiA+
IGluZGV4IGRiOWMyNjVhZDllMS4uNDY4YmZiZmU0NGQ3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9m
cy9uZnMvbmZzMnhkci5jDQo+ID4gPiA+ICsrKyBiL2ZzL25mcy9uZnMyeGRyLmMNCj4gPiA+ID4g
QEAgLTEwMiw3ICsxMDIsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9uZnNkYXRhKHN0cnVjdCB4ZHJf
c3RyZWFtDQo+ID4gPiA+ICp4ZHIsIHN0cnVjdCBuZnNfcGdpb19yZXMgKnJlc3VsdCkNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KCFwKSkNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlPOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBj
b3VudCA9IGJlMzJfdG9fY3B1cChwKTsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCByZWN2ZCA9IHhk
cl9yZWFkX3BhZ2VzKHhkciwgY291bnQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHJlY3ZkID0g
eGRyX3JlYWRfcGFnZXMoeGRyLCB4ZHJfYWxpZ25fc2l6ZShjb3VudCkpOw0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoCBpZiAodW5saWtlbHkoY291bnQgPiByZWN2ZCkpDQo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9jaGVhdGluZzsNCj4gPiA+ID4gb3V0Og0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczN4ZHIuYyBiL2ZzL25mcy9uZnMzeGRyLmMN
Cj4gPiA+ID4gaW5kZXggZDNlMTcyNmQ1MzhiLi44ZWY3Yzk2MWQzZTIgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2ZzL25mcy9uZnMzeGRyLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL25mczN4ZHIuYw0K
PiA+ID4gPiBAQCAtMTYxMSw3ICsxNjExLDcgQEAgc3RhdGljIGludCBkZWNvZGVfcmVhZDNyZXNv
ayhzdHJ1Y3QNCj4gPiA+ID4geGRyX3N0cmVhbSAqeGRyLA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oCBvY291bnQgPSBiZTMyX3RvX2NwdXAocCsrKTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgaWYg
KHVubGlrZWx5KG9jb3VudCAhPSBjb3VudCkpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dF9taXNtYXRjaDsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCByZWN2
ZCA9IHhkcl9yZWFkX3BhZ2VzKHhkciwgY291bnQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHJl
Y3ZkID0geGRyX3JlYWRfcGFnZXMoeGRyLCB4ZHJfYWxpZ25fc2l6ZShjb3VudCkpOw0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoY291bnQgPiByZWN2ZCkpDQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9jaGVhdGluZzsNCj4gPiA+ID4g
b3V0Og0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczR4ZHIuYyBiL2ZzL25mcy9uZnM0
eGRyLmMNCj4gPiA+ID4gaW5kZXggNzU1YjU1NmU4NWMzLi41YmFhNzY3MTA2ZGMgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0eGRyLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL25mczR4
ZHIuYw0KPiA+ID4gPiBAQCAtNTIwMiw3ICs1MjAyLDcgQEAgc3RhdGljIGludCBkZWNvZGVfcmVh
ZChzdHJ1Y3QgeGRyX3N0cmVhbQ0KPiA+ID4gPiAqeGRyLCBzdHJ1Y3QgcnBjX3Jxc3QgKnJlcSwN
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlPOw0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoCBlb2YgPSBiZTMyX3RvX2NwdXAocCsrKTsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqAgY291bnQgPSBiZTMyX3RvX2NwdXAocCk7DQo+ID4gPiA+IC3CoMKgwqDCoMKg
wqAgcmVjdmQgPSB4ZHJfcmVhZF9wYWdlcyh4ZHIsIGNvdW50KTsNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCByZWN2ZCA9IHhkcl9yZWFkX3BhZ2VzKHhkciwgeGRyX2FsaWduX3NpemUoY291bnQpKTsN
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGNvdW50ID4gcmVjdmQpIHsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRwcmludGsoIk5GUzogc2VydmVyIGNoZWF0aW5n
IGluIHJlYWQgcmVwbHk6ICINCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImNvdW50ICV1ID4gcmVjdmQgJXVcbiIs
IGNvdW50LA0KPiA+ID4gPiByZWN2ZCk7DQo+ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjI4LjANCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
