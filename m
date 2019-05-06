Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0D153C2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEFShK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 14:37:10 -0400
Received: from mail-eopbgr790090.outbound.protection.outlook.com ([40.107.79.90]:33984
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfEFShK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 May 2019 14:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN2WADPIzQ/wYCEaD6xQ0RAEh+lpqBwX8MO9Ga0PHQA=;
 b=p42W0kT1Uun+5b3r63n4Da7zMuEnSsrLkoQ1gIpLUrGI6GsPACiLrNqCLljbixty6l6s2E8nFyP0prPmm39OZq7oDQqq9BXqZl+raf/MDaOAYFax96jCC0O9ibh5nD3h1Ri81k/QBlkkZ+4/du7ltOld96hvuMg/eY5w5KEJyxc=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2416.namprd13.prod.outlook.com (52.135.94.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.13; Mon, 6 May 2019 18:37:06 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1878.019; Mon, 6 May 2019
 18:37:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] bh-safe lock removal for SUNRPC
Thread-Topic: [RFC PATCH 0/5] bh-safe lock removal for SUNRPC
Thread-Index: AQHVAaJ8xWprwblII0eOHRMFBBkaiKZebgWAgAAEGgA=
Date:   Mon, 6 May 2019 18:37:05 +0000
Message-ID: <6d1e56b4b352ee29eb8c88f95e4b839117562e42.camel@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
         <39608ABA-9E3F-443A-9F4C-7B91B885C7DD@oracle.com>
In-Reply-To: <39608ABA-9E3F-443A-9F4C-7B91B885C7DD@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.170.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c9e4b32-cb03-4f02-8bc8-08d6d251d713
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR13MB2416;
x-ms-traffictypediagnostic: SN6PR13MB2416:
x-microsoft-antispam-prvs: <SN6PR13MB241689848920B2E9B968452CB8300@SN6PR13MB2416.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(3846002)(2351001)(86362001)(64756008)(66446008)(66476007)(8676002)(99286004)(305945005)(7736002)(66556008)(91956017)(76116006)(81156014)(81166006)(68736007)(71200400001)(71190400001)(66066001)(478600001)(76176011)(4744005)(2501003)(5660300002)(8936002)(229853002)(25786009)(2906002)(476003)(6512007)(66946007)(73956011)(486006)(102836004)(2616005)(6916009)(316002)(14454004)(6436002)(446003)(11346002)(6116002)(5640700003)(118296001)(26005)(256004)(14444005)(4326008)(186003)(53936002)(6246003)(36756003)(6506007)(53546011)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2416;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GIcXNLl2Dyoc98XP9kCH6+/U1YZPo1YgpKUGJMUfMpqUf2XeRYdrxNVC7BoHNnhu8uQhR+duPpLP9mEDeNSUqDx+oHy8/3W0ymFXHxRs5c+PYo0MgRZowJgtRZYJonzCrnjFOcP2BD3yH+Xs3DpLUfy0FuIwB4Crt2592PpSi8wZ+G+GfEJZI6xInTVtV0ds7GYhDRf6T/moknX/E0TKCmzUTHNkGpXyARbv93IFmoa2MJDxwHUbJRnrstL3EHzFQbz/WwtKYYadMKujhxkSRU3ewCejx6G++Msm6B7jGJNkS8cyGHNxleZC0maCMrNbHxRjqZWnaz6s1CswaYl8hLjVmIIGoePWrfjJ9K0L83Yc4QfrRWwoq2Vx5HTUoHTDOFnY8Z8xl0aepq1FSqsVWX8Yow2zebUpF+GFK46GT9I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5F3AE80FA937F40B7E9F2308F657E1A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9e4b32-cb03-4f02-8bc8-08d6d251d713
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 18:37:06.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2416
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTA2IGF0IDE0OjIyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgVHJvbmQtDQo+IA0KPiA+IE9uIE1heSAzLCAyMDE5LCBhdCA3OjE4IEFNLCBUcm9uZCBNeWts
ZWJ1c3QgPHRyb25kbXlAZ21haWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0
Y2hzZXQgYWltcyB0byByZW1vdmUgdGhlIGJoLXNhZmUgbG9ja3Mgb24gdGhlIGNsaWVudCBzaWRl
Lg0KPiA+IEF0IHRoaXMgdGltZSBpdCBzaG91bGQgYmUgc2VlbiBhcyBhIHRveS9zdHJhd21hbiBl
ZmZvcnQgaW4gb3JkZXIgdG8NCj4gPiBoZWxwIHRoZSBjb21tdW5pdHkgZmlndXJlIG91dCB3aGV0
aGVyIG9yIG5vdCB0aGVyZSBhcmUgc2V0dXBzIG91dA0KPiA+IHRoZXJlIHRoYXQgYXJlIGFjdHVh
bGx5IHNlZWluZyBwZXJmb3JtYW5jZSBib3R0bGVuZWNrcyByZXN1bHRpbmcNCj4gPiBmcm9tIHRh
a2luZyBiaC1zYWZlIGxvY2tzIGluc2lkZSBvdGhlciBzcGlubG9ja3MuDQo+IA0KPiBXaGF0IGtl
cm5lbCBkb2VzIHRoaXMgcGF0Y2ggc2V0IGFwcGx5IHRvPyBJJ3ZlIHRyaWVkIGJvdGggdjUuMCBh
bmQNCj4gdjUuMSwgYnV0IHRoZXJlIGFwcGVhciB0byBiZSBzb21lIGNoYW5nZXMgdGhhdCBJJ20g
bWlzc2luZy4gVGhlDQo+IGZpcnN0IHBhdGNoIGRvZXMgbm90IGFwcGx5IGNsZWFubHkuDQo+IA0K
DQpJdCBzaG91bGQgaG9wZWZ1bGx5IGFwcGx5IG9uIHRvcCBvZiBBbm5hJ3MgbGludXgtbmV4dCBi
cmFuY2guDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
