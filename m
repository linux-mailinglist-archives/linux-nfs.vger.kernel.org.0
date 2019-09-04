Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0445AA8D87
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfIDRLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 13:11:34 -0400
Received: from mail-eopbgr760108.outbound.protection.outlook.com ([40.107.76.108]:9790
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731456AbfIDRLe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 13:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1eTD57IfQe6wlC0vN9oTjrgr9HbjSFu/kclMzlm1GVrpSmbEV3CqXbdtPry1icganheDGSEvE5VNz5fZ4DVg09JKWcYqvJuteeFbJNr4wzqhkMNwOYuZ6k/AeVlYVS/47QbzWe+OlCQrwXApgsuXGAonrjuYhbU9hk/q8qp17V4tXDEDxtSlJHBibHzpERiijDP7pcqN015jhEG0B+ROYyGRBxfpuIrqIwoisymSPSbRKTj7PQz2yC+xZiMCfBr7xk84Mq/gHPmywjqCMnAd6mtajZetKrsxjHh1BRFovD5L0yoPG1MwRN678m/pcmUSuLWerB7OVwGlUl/4W7oVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/m87E4OWikD98fSXwSswp2BNsqnXDAA/oRNzC3cIQ=;
 b=BFLW4MvYBVutErnBsbdXCKWR2/sj4JLvA+pXVcz+n4cSplYygxSVhZ6Fx3+h5N1IkeQknHWig87N3DlSAL4eBY6i7kU/vR8RERXKTS7jrbuKkD9djzhywj70rUb2FyCb6fWg6m4vK5n9Hjkb96pXFw0rTEmvRI7+ZtkYOo0n3FVjrKx7UNp6uuZaldZXFT7UStmeZtytpqLRBuMHDCQIBRQSvtX9fnnxcuRWMtvRbOlHD1f1kgqoA8fyq5SrhPRjgyStcHJLDnbrFU1T0dIzECP7p/oLy3UCHpajsKnHQVuimaIKlHXcvI/lmPTj3eCNmxzvGBlhVucKHVNN7Kdgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/m87E4OWikD98fSXwSswp2BNsqnXDAA/oRNzC3cIQ=;
 b=cxGrZjgEhptrtW+6ggKYxP9plaR6WfUF0wK4BNJ9LKyjxbjcUxNgkuGWpXnIStfqtJiJ/BywLsy7Tk25xtwTXzz9GhkrDqBociGNUcJJ9OXzIGkanmt4TINTqKg5yfHP1Qm0xR1uAZEfAHHsXlTNsOjDDPHsWT1kHGg7iDyOxPk=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1836.namprd13.prod.outlook.com (10.171.154.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Wed, 4 Sep 2019 17:11:30 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2241.013; Wed, 4 Sep 2019
 17:11:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS bugfix
Thread-Topic: [GIT PULL] Please pull NFS bugfix
Thread-Index: AQHVY0PLxUsm9zdUMUCZqGsscZqnDQ==
Date:   Wed, 4 Sep 2019 17:11:29 +0000
Message-ID: <9c0f3a52cd4e0075713fb7b9a2adbc7f05adadb3.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.244.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b67a9f-2ef4-4159-7a0d-08d7315aedac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1836;
x-ms-traffictypediagnostic: DM5PR13MB1836:
x-microsoft-antispam-prvs: <DM5PR13MB18367C5F6834F5435A079890B8B80@DM5PR13MB1836.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(346002)(396003)(376002)(199004)(189003)(4326008)(4744005)(8936002)(5660300002)(6506007)(102836004)(26005)(316002)(2501003)(54906003)(186003)(53936002)(81156014)(8676002)(1730700003)(81166006)(6436002)(118296001)(3846002)(6116002)(5640700003)(86362001)(36756003)(7736002)(2906002)(2351001)(6512007)(305945005)(25786009)(99286004)(14444005)(256004)(71200400001)(71190400001)(486006)(66066001)(14454004)(2616005)(6486002)(476003)(91956017)(6916009)(76116006)(64756008)(66446008)(66946007)(478600001)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1836;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aF7/e3Qsg9xT6/Puly8LSoD1txaaaWbvCYQt67tvlFLQcEeoPaYDxPM01ctt9OQzmA3wNber6alTmkEX0QeZ3m7nN86IjUiWXzBdWnd9iAokjP8NhoNHdo73i/IVtEp5mY05yBgPyDEiTESF581IcWPLfyVz/5hDSj8aPOmJyEVi66utAZU2vSHDgxOTYk9OPRQGS57/Y9llYOwo/C/C2xgBHJ0xmxFL0d3TiVQNEH6kI5KmBY3x7g/Dpp3pz+QeECnwVnyJ9iNpT89igfAqX8FSj7cMCvS6NFLxdkLH3hvsYvdadx5lKgdgoIInU0R+GvTsX5NGl27O84RJZEB6qRo/gBqb5vk5z54onarQQ2IDF13VWC3qI76YzST26g0EMgnng6x6qEvKk1jFkhOCFkDa6IwQm5APRqHjg/8MKoY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53D3C44811B7347B0081207776CC1C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b67a9f-2ef4-4159-7a0d-08d7315aedac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 17:11:29.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7keZ30yCcUDXG5LOeVPNWxxvfCbdWquueCkYIV2+J6BeaaLjfvCtbAUnvsvNY7Jc76LijwhTDgo36LZNMKAM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1836
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNCk9uZSBtb3JlIHB1bGwgcmVxdWVzdCB0byBmaXggYSBORlN2NCByZWdyZXNz
aW9uIHRoYXQgYWZmZWN0cyBvbmx5IHRoZQ0KdjUuMy1yYyBzZXJpZXMuDQoNClRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMDg5Y2Y3ZjZlY2IyNjZiNmE0MTY0OTE5YTJlNjliZDJm
OTM4Mzc0YToNCg0KICBMaW51eCA1LjMtcmM3ICgyMDE5LTA5LTAyIDA5OjU3OjQwIC0wNzAwKQ0K
DQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQu
bGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xpbnV4LW5mcy5naXQgdGFncy9uZnMtZm9y
LTUuMy00DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlYjNkOGY0MjIzMWFlYzY1
YjY0YjA3OWRkMTdiZDZjMDA4YTNmZTI5Og0KDQogIE5GUzogRml4IGlub2RlIGZpbGVpZCBjaGVj
a3MgaW4gYXR0cmlidXRlIHJldmFsaWRhdGlvbiBjb2RlICgyMDE5LTA5LTAyIDEzOjEwOjE5IC0w
NDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IGJ1Z2ZpeGVzIGZvciBMaW51eCA1LjMNCg0KSGln
aGxpZ2h0cyBpbmNsdWRlOg0KDQpCdWdmaXhlczoNCi0gRml4IGlub2RlIGZpbGVpZCBjaGVja3Mg
aW4gYXR0cmlidXRlIHJldmFsaWRhdGlvbiBjb2RlDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRyb25kIE15a2xlYnVz
dCAoMSk6DQogICAgICBORlM6IEZpeCBpbm9kZSBmaWxlaWQgY2hlY2tzIGluIGF0dHJpYnV0ZSBy
ZXZhbGlkYXRpb24gY29kZQ0KDQogZnMvbmZzL2lub2RlLmMgfCAxOCArKysrKysrKysrLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
