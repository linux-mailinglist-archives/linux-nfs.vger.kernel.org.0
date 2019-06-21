Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112214EF86
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2019 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUTgK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 15:36:10 -0400
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:62096
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfFUTgK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Jun 2019 15:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYwL2O+qOWWspH87roA/XkVuT9PPT5VtV6SsD/Nz5Sk=;
 b=XfFoYHjFlZx4scEDrNTptOO/dLzV5Tt6R17jhYpJiKlPZCkkQXEqKhZCcU4MwmfLpHPCLgZ0DJnt7pO/PVBgq3PvJxL9ZCG6I37RHII8NKp+s/0PLvlxREXgJM7Wzo6y5HMSRnpPFzVyrZSqk9mK/If/YuLqfohRGs/vanW1pLc=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB5379.namprd06.prod.outlook.com (20.178.208.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 19:36:07 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::bc27:e0e1:e3e2:7b52]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::bc27:e0e1:e3e2:7b52%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 19:36:07 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] A few more NFS client bugfixes for 5.2
Thread-Topic: [GIT PULL] A few more NFS client bugfixes for 5.2
Thread-Index: AQHVKGiRZQgBmYUuw02FJzQkwXnr/Q==
Date:   Fri, 21 Jun 2019 19:36:06 +0000
Message-ID: <5fd7ed91090e8c12df4968440d74f88f86dba612.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb826f1-916a-4085-77e5-08d6f67fb499
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR06MB5379;
x-ms-traffictypediagnostic: BN8PR06MB5379:
x-microsoft-antispam-prvs: <BN8PR06MB53793012957358BE34915151F8E70@BN8PR06MB5379.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(5640700003)(118296001)(99286004)(81156014)(8676002)(7736002)(478600001)(26005)(14454004)(8936002)(53936002)(1730700003)(72206003)(81166006)(186003)(6506007)(54906003)(316002)(6512007)(71190400001)(2351001)(66476007)(91956017)(68736007)(305945005)(86362001)(6486002)(76116006)(73956011)(66946007)(66446008)(66556008)(64756008)(6116002)(36756003)(5660300002)(486006)(71200400001)(476003)(3846002)(2501003)(58126008)(6436002)(25786009)(4326008)(2616005)(2906002)(14444005)(256004)(102836004)(6916009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5379;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F6Y4IJjBr+jFY4XXYxlBQU/epqIMaa9up9+DOMD8bbkma5B34rJ95xEVbk4HrQLyBgn4jI+efTaSnid2sOAEtQ2QRRmuEiOcvQXYL6XMeoCZuOo7O+9U35nFDAYDETkNHrs8eW6vOwr6Vy9KsIYS63+hcsvywHUXCBq07g05DsrK14uLCiKeSQMaR3TfB7dwX1+d56UPzxMbLNmkXtwwLP3EHKD0xf9bnzWvT+s63/uPyGNz5M2FmO6vhqgNsr15faza33/innmKSzwS88Qc1A1N+F0pKyUW/Z17tbR4L1JsLvP6ajYw57nrSVCzXYYLTScPjVxX/aZHQUzkS4uaDOIBcloEnTPYNhKXlmbapmmweH11MN5X2s2AOyQ6COvwFdrIx8BhuQF1lw+E2gVKr8d2H/zDpLPfVam4i/RdZ0U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB53B57959322147A537818A9762CFAF@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb826f1-916a-4085-77e5-08d6f67fb499
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 19:36:06.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5379
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQNCjllMGJhYmYy
YzA2YzczY2RhMmMwY2QzN2ExNjUzZDgyM2FkYjQwZWM6DQoNCiAgTGludXggNS4yLXJjNSAoMjAx
OS0wNi0xNiAwODo0OTo0NSAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvYW5uYS9saW51
eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjItDQozDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0bw0KMTlkNTUwNDZjZDgyNGJhYWI1MzUzNGJhN2U3Zjk5OTQ1YzZmZGNiMToNCg0KICBT
VU5SUEM6IEZpeCBhIGNyZWRlbnRpYWwgcmVmY291bnQgbGVhayAoMjAxOS0wNi0yMSAxNDo0NTow
OSAtMDQwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhlc2UgYXJlIG1vc3RseSByZWZjb3VudGluZyBpc3N1ZXMg
dGhhdCBwZW9wbGUgaGF2ZSBmb3VuZCByZWNlbnRseS4gICANClRoZSByZXZlcnQgZml4ZXMgYSBz
dXNwZW5kIHJlY292ZXJ5IHBlcmZvcm1hbmNlIGlzc3VlLg0KDQpUaGFua3MsDQpBbm5hDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpBbm5hDQpTY2h1bWFrZXIgKDEpOg0KICAgICAgUmV2ZXJ0ICJTVU5SUEM6IERlY2xhcmUg
UlBDIHRpbWVycyBhcyBUSU1FUl9ERUZFUlJBQkxFIg0KDQpCZW5qYW1pbiBDb2RkaW5ndG9uICgx
KToNCiAgICAgIE5GUzQ6IE9ubHkgc2V0IGNyZWF0aW9uIG9wZW5kYXRhIGlmIE9fQ1JFQVQNCg0K
TGluIFlpICgxKToNCiAgICAgIG5ldCA6c3VucnBjIDpjbG50IDpGaXggeHBzIHJlZmNvdW50IGlt
YmFsYW5jZSBvbiB0aGUgZXJyb3IgcGF0aA0KDQpUcm9uZCBNeWtsZWJ1c3QgKDEpOg0KICAgICAg
U1VOUlBDOiBGaXggYSBjcmVkZW50aWFsIHJlZmNvdW50IGxlYWsNCg0KIGZzL25mcy9uZnM0cHJv
Yy5jICB8IDIwICsrKysrKysrKysrLS0tLS0tLS0tDQogbmV0L3N1bnJwYy9jbG50LmMgIHwgIDIg
Ky0NCiBuZXQvc3VucnBjL3NjaGVkLmMgfCAgNCArLS0tDQogbmV0L3N1bnJwYy94cHJ0LmMgIHwg
IDQgKy0tLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25z
KC0pDQo=
