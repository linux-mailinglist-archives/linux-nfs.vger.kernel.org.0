Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6A14A96
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFNK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 09:10:58 -0400
Received: from mail-eopbgr770099.outbound.protection.outlook.com ([40.107.77.99]:6896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfEFNK5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 May 2019 09:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgsj4aZ8GJZMcq5OqkBSm1xYeLa3VwuJEih+vshEIz0=;
 b=BwiQSFILI2yu1j9hoW+n7WNucgM7Dt9Pc7skZPcK52kPjhmqiIHD6s8lEiiGzrC3rWIhEUn2DJ/CcxoQRB8rPZuZwC+YtzA12QMiLbcue5iNWb2oldxaleMFj8sxHYJPd4v8NdSu2GyllEyEnAncBpnzSyqvYDREh1qek6WPUvc=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2350.namprd13.prod.outlook.com (52.135.94.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.13; Mon, 6 May 2019 13:10:53 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1878.019; Mon, 6 May 2019
 13:10:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: don't mark all open state for recovery when
 handling recallable state revoked flag
Thread-Topic: [PATCH] NFSv4: don't mark all open state for recovery when
 handling recallable state revoked flag
Thread-Index: AQHVAQzWWD6HAxI2Z0SSIuo9O6rZq6ZeGCYA
Date:   Mon, 6 May 2019 13:10:53 +0000
Message-ID: <ef52b7039799be0624d44d83cef5d3a9db867fdb.camel@hammerspace.com>
References: <20190502173108.8796-1-smayhew@redhat.com>
In-Reply-To: <20190502173108.8796-1-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.170.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78bb0c4d-30f8-4185-f9c8-08d6d22444e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2350;
x-ms-traffictypediagnostic: SN6PR13MB2350:
x-microsoft-antispam-prvs: <SN6PR13MB235078F441580CD417DA65D4B8300@SN6PR13MB2350.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(25786009)(186003)(26005)(102836004)(76176011)(229853002)(7736002)(36756003)(86362001)(66066001)(305945005)(5660300002)(71200400001)(71190400001)(478600001)(66446008)(6506007)(76116006)(14444005)(91956017)(73956011)(64756008)(66946007)(256004)(66476007)(66556008)(6116002)(118296001)(2906002)(53936002)(6512007)(3846002)(8676002)(81156014)(81166006)(6246003)(446003)(476003)(11346002)(2616005)(486006)(6436002)(316002)(6486002)(110136005)(2501003)(8936002)(4326008)(99286004)(14454004)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2350;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: guwvfaXJqff0044RG63a98mmBDYgwnIQRWc4C061T2vcQg5RoHbtBeVHtqCuEYfqcCD7+la3pfisbvHZR2q2//Sxq2mTljAApyhfVhb4WbofJtL6Wgh1C8df3yfulb4XbVE/UKKG7BBaJ6vfs7jd8QsogRRrpfS0t1s7bLN8xVmWEdv/g4prkuKgQsjMUd3FMd/uaai+ulfiynW/nWVwSlhDq1CQ9G2etSFImAoG+YwFPMxHXCN9mX9Gp0DW5oWGjg7GRki/skVN3q7ASTdBhW6MA30r4zwdeZ5Yy0YJm5Qa7LJRXJ+l6YRQwu9X1K15N2ZlCAVdYKfINsGGda0Z3cTK/pmwK4D6QMIa3Nh65GHdAAlyWw5FZ+xh5vbXuYiaCejRvZotakT02DKNmz+Qi25PirU1RPyBJtb6PSKM/0A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7865578C67E2B84BB8A434F0BE57F832@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bb0c4d-30f8-4185-f9c8-08d6d22444e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 13:10:53.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2350
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIFRodSwgMjAxOS0wNS0wMiBhdCAxMzozMSAtMDQwMCwgU2NvdHQgTWF5
aGV3IHdyb3RlOg0KPiBPbmx5IGRlbGVnYXRpb25zIGFuZCBsYXlvdXRzIGNhbiBiZSByZWNhbGxl
ZCwgc28gaXQgc2hvdWxkbid0IGJlDQo+IG5lY2Vzc2FyeSB0byByZWNvdmVyIGFsbCBvcGVucyB3
aGVuIGhhbmRsaW5nIHRoZSBzdGF0dXMgYml0DQo+IFNFUTRfU1RBVFVTX1JFQ0FMTEFCTEVfU1RB
VEVfUkVWT0tFRC4gIFdlJ2xsIHN0aWxsIHdpbmQgdXAgY2FsbGluZw0KPiBuZnM0MV9vcGVuX2V4
cGlyZWQoKSB3aGVuIGEgVEVTVF9TVEFURUlEIHJldHVybnMNCj4gTkZTNEVSUl9ERUxFR19SRVZP
S0VELg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2NvdHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRzdGF0ZS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL25mcy9uZnM0c3RhdGUuYyBiL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiBpbmRleCAzZGUzNjQ3
OWVkN2EuLjRkYjliY2Y5M2ZhZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRzdGF0ZS5jDQo+
ICsrKyBiL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiBAQCAtMjM0Niw4ICsyMzQ2LDggQEAgc3RhdGlj
IHZvaWQNCj4gbmZzNDFfaGFuZGxlX3JlY2FsbGFibGVfc3RhdGVfcmV2b2tlZChzdHJ1Y3QgbmZz
X2NsaWVudCAqY2xwKQ0KPiAgew0KPiAgCS8qIEZJWE1FOiBGb3Igbm93LCB3ZSBkZXN0cm95IGFs
bCBsYXlvdXRzLiAqLw0KPiAgCXBuZnNfZGVzdHJveV9hbGxfbGF5b3V0cyhjbHApOw0KPiAtCS8q
IEZJWE1FOiBGb3Igbm93LCB3ZSB0ZXN0IGFsbCBkZWxlZ2F0aW9ucytvcGVuIHN0YXRlK2xvY2tz
LiAqLw0KPiAtCW5mczQxX2hhbmRsZV9zb21lX3N0YXRlX3Jldm9rZWQoY2xwKTsNCj4gKwluZnNf
bWFya190ZXN0X2V4cGlyZWRfYWxsX2RlbGVnYXRpb25zKGNscCk7DQo+ICsJbmZzNF9zY2hlZHVs
ZV9zdGF0ZV9tYW5hZ2VyKGNscCk7DQo+ICAJZHByaW50aygiJXM6IFJlY2FsbGFibGUgc3RhdGUg
cmV2b2tlZCBvbiBzZXJ2ZXIgJXMhXG4iLA0KPiBfX2Z1bmNfXywNCj4gIAkJCWNscC0+Y2xfaG9z
dG5hbWUpOw0KPiAgfQ0KDQpDYW4gd2UgcGxlYXNlIHBhY2thZ2UgdGhlIGFib3ZlIHR3byBsaW5l
cyBpbnRvIGEgaGVscGVyIGZ1bmN0aW9uIGluDQpmcy9uZnMvZGVsZWdhdGlvbi5jPyBJIHN1Z2dl
c3QganVzdCBjYWxsaW5nIGl0DQpuZnNfdGVzdF9leHBpcmVkX2FsbF9kZWxlZ2F0aW9ucygpLg0K
DQpUaGFua3MhDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
