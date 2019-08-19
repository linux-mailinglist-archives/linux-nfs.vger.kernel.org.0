Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3269246E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfHSNL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 09:11:58 -0400
Received: from mail-eopbgr780129.outbound.protection.outlook.com ([40.107.78.129]:8480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727301AbfHSNL6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Aug 2019 09:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuBMjCClFSqat7QKQxZss51O+1leYNPIMeVFjK6wOdxVqTQ0+dvvoWCLofzYd65F5m5GRnHdbxhiQbCnI+YE5v08VOUjsVVmVKtJ5VXafsDmi14u4v9Vz+p02UkOqXug8Xp+ddk9X33nrbIA+ZUilpyo5R0obYO3Kmv6tW6QuV4SEBnCxHZgvHTK6fyHvpT4HbRd55QUMa7udvZIl9nJL+PhvEQKVroe5QRXudyCUM4SIkWKATj9Gc7vmSiDEXtAiwkW1GHfCBxENvmNU95CNbrU6DtLtPuc3CsKGb+023cpq+rQ3qAkwT+JzBi0rFbC+dNxQ0srgbyKhc4OziBn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMimSxGMQKzJ7zlzp83X4BX9FKJ2L0+mJ4EscduhA7U=;
 b=l6ckTOYc5cbo2W7DVSLZ9pflYhGkjaZDBqbaCSrY2We6pv+0LaP2hAg1KxcdKT9q7EKgjaS4z18H745lMPjNUySMlfSoa6PfWkvsi5EeNfzcXnpNWT5tT/r0L1TxY+SvrFRDn0lSfjDh4sg7f9nsLro5Rs0kLqXpC4BvGrKKE+QNNLn0nWXqrzNXdPXnGBkqIagRE/Zd3haeP4lqAB079MlO+TXjb1jtb+yfYikqDSxV+fRg+zVtqZc+4jiXozR6XjPraL+iv6jLuXUVnLkB638g0oVRpl5PbVd4j/N1rkfufYWsvECS7a3vevaOaDMgnkxqv1Jm/vu0Fg57ov56vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMimSxGMQKzJ7zlzp83X4BX9FKJ2L0+mJ4EscduhA7U=;
 b=agJPg9h/Vg3aduNC/E7tWKhRQZUJ+27kw6kOVNcyWuqYOlo5gQz+x2eUVpdGi/Tw5NtzvxRfTjcH4PiNpgfYhP9LVWyKwMk4JIL5x3SadZuxEuTQnM3UbVxvK3aH+N6Y+latnf+BHEhy2hCpTumEEuz89UNnO6QnnNLOWejh/IU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1659.namprd13.prod.outlook.com (10.171.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.7; Mon, 19 Aug 2019 13:11:53 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2199.011; Mon, 19 Aug 2019
 13:11:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "tommi.t.rantala@nokia.com" <tommi.t.rantala@nokia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 server stops responding
Thread-Topic: nfs4 server stops responding
Thread-Index: AQHVVok9rVIGR5acmEyxP58lNJPUi6cCckIA
Date:   Mon, 19 Aug 2019 13:11:53 +0000
Message-ID: <75079be76bed97720bd97128b1b79eba775747e3.camel@hammerspace.com>
References: <eb70e71ba0b1caafb96e136d83aa9c097f2a6930.camel@nokia.com>
In-Reply-To: <eb70e71ba0b1caafb96e136d83aa9c097f2a6930.camel@nokia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10123405-44f8-4bcb-f67f-08d724a6ce34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1659;
x-ms-traffictypediagnostic: DM5PR13MB1659:
x-microsoft-antispam-prvs: <DM5PR13MB1659CE3DB7E80ED3E8890F83B8A80@DM5PR13MB1659.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39830400003)(136003)(199004)(189003)(66946007)(66476007)(64756008)(99286004)(66446008)(66556008)(71190400001)(71200400001)(76116006)(305945005)(91956017)(229853002)(6436002)(4326008)(6486002)(7736002)(76176011)(8936002)(81166006)(8676002)(81156014)(2906002)(14444005)(25786009)(6246003)(256004)(5660300002)(110136005)(53936002)(2616005)(316002)(3846002)(11346002)(118296001)(2501003)(26005)(486006)(102836004)(66066001)(478600001)(446003)(6506007)(2201001)(186003)(86362001)(36756003)(6512007)(14454004)(476003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1659;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ylOsKT4vVptqhCVqgoEqqF6bt57Pgz1HpkvsLZHebFCmZ2gbYzn2NSBuq2BczXX+T4q7NRCmqSEQxCpsT0EmtLw05B89H9Zo1JVbU+4nr37WMo2HBZhgTSOi7xYyxcng07Fd4GumTe0bUD1dJEIwxZjC2bmt/jWwwxskaMo/CW1QiKi16YkgguLnlBigtktvLHb2U0Cg5Pot9bRlucSd0R9mNP0ryZZUq0uoPuC0Lc+hhhTvqjczrB2Ofd6IOKukBzTvMdGfDqF4vqWmTRhbpTf14+vb+fwJiIy5a+UTpyRl10e5Q2k9JqQZbtNvuUaGTaiBYyznOXqCZvA/pasgoIKFmGE35MlvSFDDPIxM0IqhgcM9WUzMKZVlSLEbyQc2c0BmF3qgAR+zcNajMlQXKWT1P/xAeurefVwUCS3Q0R0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3493AFCE81DE144BDF51476312C7DD0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10123405-44f8-4bcb-f67f-08d724a6ce34
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 13:11:53.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y/gwHehs5BKcGxZE49M7HrJcvM5xRixOlzWELLG2Z+ofJ0wzzlGG80XR2W9NBkGdkOT9cmy/KEs0+rOhoYvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1659
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDEyOjI1ICswMDAwLCBSYW50YWxhLCBUb21taSBULiAoTm9r
aWEgLSBGSS9Fc3BvbykNCndyb3RlOg0KPiBIZWxsbywNCj4gDQo+IEkgaGF2ZSB0d28gVk1zLCBl
eHBvcnRpbmcgc29tZSBkaXJlY3RvcmllcyBpbiBvbmUgVk06DQo+ICMgY2F0IC9ldGMvZXhwb3J0
cw0KPiAvbW50IDE5Mi4xNjguMS4wLzI0KHJvLGZzaWQ9MCxub19zdWJ0cmVlX2NoZWNrLHN5bmMp
DQo+IC9tbnQvZXhwb3J0DQo+IDE5Mi4xNjguMS4wLzI0KHJ3LG5vX3Jvb3Rfc3F1YXNoLHN5bmMs
bm9fd2RlbGF5LG5vX3N1YnRyZWVfY2hlY2spDQo+IFsuLi5dDQoNCkFyZSAvbW50IGFuZCAvbW50
L2V4cG9ydCBvbiBkaWZmZXJlbnQgZmlsZXN5c3RlbXM/IElmIG5vdCwgdGhlbiB5b3VyDQpzZXJ2
ZXIgY29uZmlndXJhdGlvbiBpcyBwcmV0dHkgbXVjaCBndWFyYW50ZWVkIHRvIGJlIGJyb2tlbiwg
d2l0aA0KY29uZmxpY3Rpbmcgc2V0cyBvZiBydWxlcyBiZWluZyBpbXBvc2VkIG9uIC9tbnQvZXhw
b3J0LiBJJ20gZ3Vlc3NpbmcNCnRoYXQgaXMgdGhlIGNhc2UsIGJlY2F1c2UgSSdtIG5vdCBzZWVp
bmcgYW55ICdub2hpZGUnIG9yICdjcm9zc21udCcNCmVudHJpZXMgYWJvdmUuDQoNCj4gDQo+IEFu
ZCBORlMgbW91bnRpbmcgaW4gdGhlIHNlY29uZCBWTToNCj4gIyBncmVwIG5mcyAvcHJvYy9tb3Vu
dHMgDQo+IHNlcnZlcjovZXhwb3J0IC9tbnQvZXhwb3J0IG5mczQNCj4gcncscmVsYXRpbWUsdmVy
cz00LjIscnNpemU9MTA0ODU3Nix3c2l6ZT0xMDQ4NTc2LG5hbWxlbj0yNTUsDQo+IGFjcmVnbWlu
PTEsYWNyZWdtYXg9MSxhY2Rpcm1pbj0xLGFjZGlybWF4PTEsaGFyZCxub3JkaXJwbHVzLA0KPiBw
cm90bz10Y3AsdGltZW89NjAwLHJldHJhbnM9MixzZWM9c3lzLGNsaWVudGFkZHI9MTkyLjE2OC4x
LjExLA0KPiBsb2NhbF9sb2NrPW5vbmUsYWRkcj0xOTIuMTY4LjEuMTAgMCAwDQo+IFsuLi5dDQo+
IA0KPiBJZiBJIGtlZXAgc29tZSBmaWxlIGRlc2NyaXB0b3Igb3BlbiBmb3Igc2V2ZXJhbCBtaW51
dGVzIGluIHRoZSBzZWNvbmQNCj4gVk0sDQo+IGZvciBleGFtcGxlIGJ5IHJ1bm5pbmcgdGhpczoN
Cj4gIyBzbGVlcCAxMG0gPi9tbnQvZXhwb3J0L3Rlc3QNCj4gDQo+IFRoZW4gcmVzdWx0IGlzIHRo
YXQgdGhlIE5GUyBtb3VudCBzdG9wcyByZXNwb25kaW5nOiB0aGUgc2xlZXAgcHJvY2Vzcw0KPiBu
ZXZlciBmaW5pc2hlZCBidXQgaXMgImZvcmV2ZXIiIHN0dWNrIGluIChraWxsYWJsZSkgRCBzdGF0
ZSwgYW5kIGFueQ0KPiBJL08NCj4gYXR0ZW1wdCBmcm9tIG90aGVyIHByb2Nlc3NlcyBpbiAvbW50
L2V4cG9ydCBuZXZlciBmaW5pc2guDQo+IEl0J3MgYWx3YXlzIHJlcHJvZHVjaWJsZSB3aXRoIHRo
aXMgc2xlZXAgY29tbWFuZC4NCj4gVG8gcmVjb3ZlciB0aGUgbW91bnRwb2ludCBJIG5lZWQgdG8g
cmVib290IHRoZSBzZWNvbmQgVk0uDQo+IA0KPiBLZXJuZWwgdmVyc2lvbiBpcyA1LjMuMC1yYzQg
aW4gYm90aCBWTXMuDQo+IEFsc28gcmVwcm9kdWNpYmxlIHdpdGggNC4xNC54IGFuZCA0LjE5LngN
Cj4gDQo+ICMgcHMgYXV4fGdyZXAgc2xlZXANCj4gcm9vdCAgICAgIDI1MjQgIDAuMCAgMC4wICAg
NTkwMCAgIDY4OCBwdHMvMCAgICBEICAgIDE0OjA0ICAgMDowMA0KPiBzbGVlcCA1bQ0KPiANCj4g
IyBncmVwIC1DMTAwIG5mcyAvcHJvYy8qL3N0YWNrDQo+IC9wcm9jLzI1MjQvc3RhY2s6WzwwPl0g
bmZzNF9kb19jbG9zZSsweDg3ZC8weGIyMCBbbmZzdjRdDQo+IC9wcm9jLzI1MjQvc3RhY2s6Wzww
Pl0gX19wdXRfbmZzX29wZW5fY29udGV4dCsweDI5Ny8weDRmMCBbbmZzXQ0KPiAvcHJvYy8yNTI0
L3N0YWNrOls8MD5dIG5mc19maWxlX3JlbGVhc2UrMHhiZS8weGYwIFtuZnNdDQo+IC9wcm9jLzI1
MjQvc3RhY2stWzwwPl0gX19mcHV0KzB4MWRmLzB4NjkwDQo+IC9wcm9jLzI1MjQvc3RhY2stWzww
Pl0gdGFza193b3JrX3J1bisweDEyMy8weDFiMA0KPiAvcHJvYy8yNTI0L3N0YWNrLVs8MD5dIGV4
aXRfdG9fdXNlcm1vZGVfbG9vcCsweDEyMS8weDE0MA0KPiAvcHJvYy8yNTI0L3N0YWNrLVs8MD5d
IGRvX3N5c2NhbGxfNjQrMHgyZDEvMHgzNzANCj4gL3Byb2MvMjUyNC9zdGFjay1bPDA+XSBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+IC0tDQo+IC9wcm9jLzU2MS9z
dGFjay1bPDA+XSBfX3JwY19leGVjdXRlKzB4NjkyLzB4YjEwIFtzdW5ycGNdDQo+IC9wcm9jLzU2
MS9zdGFjay1bPDA+XSBycGNfcnVuX3Rhc2srMHg0NWYvMHg1ZDAgW3N1bnJwY10NCj4gL3Byb2Mv
NTYxL3N0YWNrOls8MD5dIG5mczRfY2FsbF9zeW5jX3NlcXVlbmNlKzB4MTJhLzB4MjEwIFtuZnN2
NF0NCj4gL3Byb2MvNTYxL3N0YWNrOls8MD5dIF9uZnM0X3Byb2NfZ2V0YXR0cisweDE5YS8weDIw
MCBbbmZzdjRdDQo+IC9wcm9jLzU2MS9zdGFjazpbPDA+XSBuZnM0X3Byb2NfZ2V0YXR0cisweGRh
LzB4MjMwIFtuZnN2NF0NCj4gL3Byb2MvNTYxL3N0YWNrOls8MD5dIF9fbmZzX3JldmFsaWRhdGVf
aW5vZGUrMHgyZWQvMHg3YTAgW25mc10NCj4gL3Byb2MvNTYxL3N0YWNrOls8MD5dIG5mc19kb19h
Y2Nlc3MrMHg2MDUvMHhkMDAgW25mc10NCj4gL3Byb2MvNTYxL3N0YWNrOls8MD5dIG5mc19wZXJt
aXNzaW9uKzB4NTAwLzB4NWUwIFtuZnNdDQo+IC9wcm9jLzU2MS9zdGFjay1bPDA+XSBpbm9kZV9w
ZXJtaXNzaW9uKzB4MmRkLzB4M2YwDQo+IC9wcm9jLzU2MS9zdGFjay1bPDA+XSBsaW5rX3BhdGhf
d2Fsay5wYXJ0LjYwKzB4NjgxLzB4ZTQwDQo+IC9wcm9jLzU2MS9zdGFjay1bPDA+XSBwYXRoX2xv
b2t1cGF0LmlzcmEuNjMrMHgxYWYvMHg4NTANCj4gL3Byb2MvNTYxL3N0YWNrLVs8MD5dIGZpbGVu
YW1lX2xvb2t1cC5wYXJ0Ljc5KzB4MTY1LzB4MzYwDQo+IC9wcm9jLzU2MS9zdGFjay1bPDA+XSB2
ZnNfc3RhdHgrMHhiOS8weDE0MA0KPiAvcHJvYy81NjEvc3RhY2stWzwwPl0gX19kb19zeXNfbmV3
c3RhdCsweDc3LzB4ZDANCj4gL3Byb2MvNTYxL3N0YWNrLVs8MD5dIGRvX3N5c2NhbGxfNjQrMHg5
YS8weDM3MA0KPiAvcHJvYy81NjEvc3RhY2stWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NDQvMHhhOQ0KPiANCj4gDQo+IEluIGRtZXNnIG9mIHNlY29uZCBWTSBzb21ldGlt
ZXMgbmZzIGNvbXBsYWludHMgYXJlIHNlZW46DQo+IA0KPiBbICAzODYuMzYyODk3XSBuZnM6IHNl
cnZlciB4eXogbm90IHJlc3BvbmRpbmcsIHN0aWxsIHRyeWluZw0KPiANCj4gQW55IGlkZWFzIHdo
YXQncyBnb2luZyB3cm9uZyBoZXJlLi4uPw0KPiANClRoZSAnc2VydmVyIG5vdCByZXNwb25kaW5n
JyBpbXBsaWVzIHRoYXQgdGhlcmUgaXMgYSBuZXR3b3JrIGNvbm5lY3Rpb24NCmlzc3VlLiBEb2Vz
ICduZXRzdGF0IC1udCB8IGdyZXAgOjIwNDknIHNob3cgYSBjb3JyZWN0bHkgZXN0YWJsaXNoZWQg
VENQDQpjb25uZWN0aW9uIGJldHdlZW4gdGhlIGNsaWVudCBhbmQgc2VydmVyIFZNcz8NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
