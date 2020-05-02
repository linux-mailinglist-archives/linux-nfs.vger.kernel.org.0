Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58C1C25B9
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2020 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEBNfI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 May 2020 09:35:08 -0400
Received: from mail-bn8nam11on2095.outbound.protection.outlook.com ([40.107.236.95]:51169
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbgEBNfH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 2 May 2020 09:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N92PpPTieuhuHwmsnKQR5STROa3II0h+8nGwlQ7nx7Dgcp1i4WymaAlEo0ckRWphpEmxVVvdgQXj4utLXmKvE10v9itFhLicO+tKOxkLcjudIWrvpggaP62ARflerp5okqGnsLuWlkVQ1lKj88KkrU90VtueqNQJGHFAoR/iLZXOy/wjUGoKNiTFt0Y8gJeagexTWCi+gsBk/1eM1iwUl1qVOUxRunxHyPSC9pnSRTMsy/qfMhDeifO4yEZAbqg6WbEE9xA1y8gOo3ShfOXf146TWhVToC2ge2DyR1A9CyW/VPdrqfvD9/gAazoVKqIgJNb8HQ+BKzLkGM9wmj9ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjE9ZNJxcWx17eXgA/xDzGb3e/hzwL3ZJJBovi8f39I=;
 b=Peu0d9fXu2RPEBLyJaz4wXVbFmJLVE1WhVCUz24hajgH4FVWQ6FUocXha3tGT7pDz099wF8F3jLPr4b03AgesIjPn7gTmtELFRgxoMA9Q/al0fapL+EWA5tXknSel05vFPzCgYJRYNu1CQwj4vrRLVLhYttFdjOCPivH3SQzCJwb0DtAE3IzZlT3JsE5x8XCKe15erfmKFTtAkzQkPZr3/LjBfXWUMdFi+x1rQpEiTMyUDEgKvWvMnqv58ObR02l7NcPL8mDDg3Hyj8RTQKyg35roA51pA0irWXj+EYNZp01NyFufDcGkxYvsu8tJOUjzWunUl53J1XDEuTcMZmy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjE9ZNJxcWx17eXgA/xDzGb3e/hzwL3ZJJBovi8f39I=;
 b=Lz1n5FgdfN94kWyyNEkPKZdZD7QER3mR68z8aiChLRdiPCneV93pN9xFe54fw5pgHBIZ0dcydX9wNeecAhbonQMS5A0g70l2mtk+hUsGm8ocmsP90LooZ/5H/ZT2VvTcnwb3e/D+1pNpI5QpJWE7hHcgMU7+y0qVX5xbov0o/0Y=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3830.namprd13.prod.outlook.com (2603:10b6:610:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Sat, 2 May
 2020 13:35:03 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.029; Sat, 2 May 2020
 13:35:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHWIIZ7HW2JFWZpdUq+M5Vh5X+tMQ==
Date:   Sat, 2 May 2020 13:35:02 +0000
Message-ID: <c19d10e89cda7061d6aa41c1c6ad7e75affd4051.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af477aeb-2a3f-4201-8d40-08d7ee9d9e67
x-ms-traffictypediagnostic: CH2PR13MB3830:
x-microsoft-antispam-prvs: <CH2PR13MB383061C11052F73994C2EFCFB8A80@CH2PR13MB3830.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 039178EF4A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csvwtOUHBJifYTsSSP6Dg/UMUGPCFW7Gq4MjOKf7ukYcffi7uccmw9Ex3PCic1kWm0xFM3jvEFxapVuEcCKUICAxs1i35CxsDJo8mtoFK4sdPwAp/oNt9bZ+g/6oRYY6T6GzMhOqwl6FwSqdKfSs+5JCPOVhpT17Ss0zvaPawmn39DwsrujEu6kzgh0nxH6i1pyh7kM+pf/VkGCT2RT0pIpnEnKdUR11Z6ciV3zsWBYsXwTtSzK11eWdP68g4TeQNn6/bTLeqle+AALd3nMY8en3ef8lgiAiWrJDs6ULtScOQ1y1oGrVnz2MWmDUbUzsdQUy7DqhAzpIULU3luSz0uQKzmbcpuNb/TZKug8uU2VU+qOfJWHBd/RVJxZhoZCTaUzTwQg7lPHKIsTel+VfyGrJErbiC93ev74FIvuojZk4guYxxm9yZ6FOXSWOUGzN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(366004)(39830400003)(5660300002)(6512007)(6486002)(26005)(36756003)(6506007)(2906002)(86362001)(6916009)(71200400001)(4326008)(54906003)(8676002)(2616005)(66476007)(91956017)(76116006)(186003)(66446008)(478600001)(316002)(8936002)(66946007)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: n3Znw6CsFVZO2Mnob1CUK62Yle94Ty2DUpqBXEKskdkCaAs6rp/pYy1tCXoQ75mczaE5aF4dZZNA/OiLP4P9J9tYG4Fzkh32RvPcbvrmKKLS2Qq6a+4oQr4btw0DYEvfApJoN9ILqjxL0UQEDpIHH8u4z2glOKeEtttRmsmm6uvb5tPbalxSCyHyCCF7qQj1ypt4JjLvYKEDZwFOAHH9LQt1EQoHQYGnvMTdDaVhX+DnTxnwl1vL+B5S/0uwP58Cykf9T3vH6OY3Hp4+QPM0pZwCziMQOre4f0p2txGjPe9xUaJ6Ni0PVYmJiiYFfVGsGzWhJ7WwFE1qNwRyRPeFtBTUtqd47/u0zdyY8fIfnMTFY+jjHjLS035HmnN0wzLiZbcrli6xXOVJvEo+KNCkl36OcBCLPQhitMfGe1eFWMeVhXpHof81DK8RCk9erdpH2b5m6QbGoMOb5JonkJJEk79iZM01CWFCoP6gz6WOolaalzw2enZrz5CE38/rY0j6PW14NlKR7jxm5Y/SvFNnsTyJ9jznvI1BChdzmfc5t2WG4/gDd7czXxJJegBq61CdY+jKr6K3BPQ1TpEUNM3wqx58iYyoPGqrkImFq6EbMc4F7M66QOQ7asJOE3AiVggNbZIS3Swvy3mRLEUyr9ISxp1hSD0wQSp1tIAktwdijFPiV3xxyJkV0Zv0u6GU1fNs1umPrAC978RdfNPcM2igmi/JXQso3ZjxjiK2Ugm0kREmUxNmISciiNKV/Rs0Lj10TN2w0c2oUzx+PlEWwb2PcdObabiRgTZsdIyDljwdbGU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E737769FC400E94C9DC710A43A5BE38B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af477aeb-2a3f-4201-8d40-08d7ee9d9e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 13:35:03.0287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGgEHxzzEax+XpzGlh1kDx+OffvkepI7G3XW1avqdr3eldNIKvotnOM2TTPYSOiK1t8bGHSifqYLWbpR1E2nwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3830
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYWU4M2QwYjQx
NmRiMDAyZmU5NTYwMWU3Zjk3ZjY0YjU5NTE0ZDkzNjoNCg0KICBMaW51eCA1LjctcmMyICgyMDIw
LTA0LTE5IDE0OjM1OjMwIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuNy00DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA5YzA3Yjc1YjgwZWVmZjcxNDQyMGZiNmE0Yzg4MGIyODRlNTI5ZDBmOg0KDQogIE5G
UzogRml4IGEgcmFjZSBpbiBfX25mc19saXN0X2Zvcl9lYWNoX3NlcnZlcigpICgyMDIwLTA0LTMw
IDE1OjA4OjI2IC0wNDAwKQ0KDQpUaGFua3MNCiAgVHJvbmQNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVu
dCBidWdmaXhlcyBmb3IgTGludXggNS43DQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0KU3RhYmxl
IGZpeGVzDQotIGZpeCBoYW5kbGluZyBvZiBiYWNrY2hhbm5lbCBiaW5kaW5nIGluIEJJTkRfQ09O
Tl9UT19TRVNTSU9ODQoNCkJ1Z2ZpeGVzDQotIEZpeCBhIGNyZWRlbnRpYWwgdXNlLWFmdGVyLWZy
ZWUgaXNzdWUgaW4gcG5mc19yb2MoKQ0KLSBGaXggcG90ZW50aWFsIHBvc2l4X2FjbCByZWZjbnQg
bGVhayBpbiBuZnMzX3NldF9hY2wNCi0gZGVmZXIgc2xvdyBwYXJ0cyBvZiBycGNfZnJlZV9jbGll
bnQoKSB0byBhIHdvcmtxdWV1ZQ0KLSBGaXggYW4gT29wc2FibGUgcmFjZSBpbiBfX25mc19saXN0
X2Zvcl9lYWNoX3NlcnZlcigpDQotIEZpeCB0cmFjZSBwb2ludCB1c2UtYWZ0ZXItZnJlZSByYWNl
DQotIFJlZ3Jlc3Npb246IHRoZSBSRE1BIGNsaWVudCBubyBsb25nZXIgcmVzcG9uZHMgdG8gc2Vy
dmVyIGRpc2Nvbm5lY3QgcmVxdWVzdHMNCi0gRml4IHJldHVybiB2YWx1ZXMgb2YgeGRyX3N0cmVh
bV9lbmNvZGVfaXRlbV97cHJlc2VudCwgYWJzZW50fQ0KLSBfcG5mc19yZXR1cm5fbGF5b3V0KCkg
bXVzdCBhbHdheXMgd2FpdCBmb3IgbGF5b3V0cmV0dXJuIGNvbXBsZXRpb24NCg0KQ2xlYW51cHMN
Ci0gUmVtb3ZlIHVucmVhY2hhYmxlIGVycm9yIGNvbmRpdGlvbnMNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQW5kcmVh
cyBHcnVlbmJhY2hlciAoMSk6DQogICAgICBuZnM6IEZpeCBwb3RlbnRpYWwgcG9zaXhfYWNsIHJl
ZmNudCBsZWFrIGluIG5mczNfc2V0X2FjbA0KDQpDaHVjayBMZXZlciAoMyk6DQogICAgICB4cHJ0
cmRtYTogUmVzdG9yZSB3YWtlLXVwLWFsbCB0byBycGNyZG1hX2NtX2V2ZW50X2hhbmRsZXIoKQ0K
ICAgICAgeHBydHJkbWE6IEZpeCB0cmFjZSBwb2ludCB1c2UtYWZ0ZXItZnJlZSByYWNlDQogICAg
ICB4cHJ0cmRtYTogRml4IHVzZSBvZiB4ZHJfc3RyZWFtX2VuY29kZV9pdGVtX3twcmVzZW50LCBh
YnNlbnR9DQoNCk5laWxCcm93biAoMSk6DQogICAgICBTVU5SUEM6IGRlZmVyIHNsb3cgcGFydHMg
b2YgcnBjX2ZyZWVfY2xpZW50KCkgdG8gYSB3b3JrcXVldWUuDQoNCk9sZ2EgS29ybmlldnNrYWlh
ICgxKToNCiAgICAgIE5GU3Y0LjE6IGZpeCBoYW5kbGluZyBvZiBiYWNrY2hhbm5lbCBiaW5kaW5n
IGluIEJJTkRfQ09OTl9UT19TRVNTSU9ODQoNClRyb25kIE15a2xlYnVzdCAoNCk6DQogICAgICBO
RlMvcG5mczogRW5zdXJlIHRoYXQgX3BuZnNfcmV0dXJuX2xheW91dCgpIHdhaXRzIGZvciBsYXlv
dXRyZXR1cm4gY29tcGxldGlvbg0KICAgICAgTkZTL3BuZnM6IEZpeCBhIGNyZWRlbnRpYWwgdXNl
LWFmdGVyLWZyZWUgaXNzdWUgaW4gcG5mc19yb2MoKQ0KICAgICAgTWVyZ2UgdGFnICduZnMtcmRt
YS1mb3ItNS43LTInIG9mIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL2FubmEvbGlu
dXgtbmZzDQogICAgICBORlM6IEZpeCBhIHJhY2UgaW4gX19uZnNfbGlzdF9mb3JfZWFjaF9zZXJ2
ZXIoKQ0KDQpYaXl1IFlhbmcgKDIpOg0KICAgICAgU1VOUlBDOiBSZW1vdmUgdW5yZWFjaGFibGUg
ZXJyb3IgY29uZGl0aW9uDQogICAgICBORlN2NDogUmVtb3ZlIHVucmVhY2hhYmxlIGVycm9yIGNv
bmRpdGlvbiBkdWUgdG8gcnBjX3J1bl90YXNrKCkNCg0KIGZzL25mcy9uZnMzYWNsLmMgICAgICAg
ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKy0tLS0tLS0NCiBmcy9uZnMvbmZzNHByb2MuYyAg
ICAgICAgICAgICAgfCAxMSArKysrKysrKystLQ0KIGZzL25mcy9wbmZzLmMgICAgICAgICAgICAg
ICAgICB8IDExICsrKysrLS0tLS0tDQogZnMvbmZzL3N1cGVyLmMgICAgICAgICAgICAgICAgIHwg
IDIgKy0NCiBpbmNsdWRlL2xpbnV4L25mc194ZHIuaCAgICAgICAgfCAgMiArKw0KIGluY2x1ZGUv
bGludXgvc3VucnBjL2NsbnQuaCAgICB8IDEzICsrKysrKysrKysrKy0NCiBpbmNsdWRlL3RyYWNl
L2V2ZW50cy9ycGNyZG1hLmggfCAxMiArKysrLS0tLS0tLS0NCiBuZXQvc3VucnBjL2NsbnQuYyAg
ICAgICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKystLS0tLS0NCiBuZXQvc3VucnBjL3hw
cnRyZG1hL3JwY19yZG1hLmMgfCAxNSArKysrKysrKysrKy0tLS0NCiBuZXQvc3VucnBjL3hwcnRy
ZG1hL3ZlcmJzLmMgICAgfCAgMyArKy0NCiAxMCBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25z
KCspLCAzNiBkZWxldGlvbnMoLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
