Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D794E9B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfHST4g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:56:36 -0400
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:21730
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727925AbfHST4g (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Aug 2019 15:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvvsu2ysaY5wSG0dsxJ5HkxVg09rnuUQZKoeHSYOEA/LMzqF3lMYa1GJ/+DEFqtgdZswBFydOhljSnZc6PrNkidB4RUqcx/2ncuvCvF6b7rbrz+HWkUAW1XsAghX30mHwlbpJ7HpjWnxRUOV+gxROs6jc+/hj4aWQYSwmNMz7Izfm1FfHgwyRBYYGPTwWxABD7muP13tDHnf6mgNua5/hY6aQgu8TCEZTsksQNVB63BTjQCjiKKFd6eZ/AZoVuxc58uL7/5nzXrVOdJkGIthAVjZG0GpUwhIDSlqsrgY1XxLM7Zxkgzsk2feahBdoU8h/bK2fIqba0YIhqB5DB1bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGLuL6F8GuOQNeUruA5VrXrw4xtiptL9NbhhE6NWqug=;
 b=SO3RJM6YsiuXG6cNyfxIxzM/qBquReLYM6bnau3Nrb54IsSVI1QmFRpib0svg6Qg+xaw6O8R95A8bShNGG/q4p2+zGOO7eYblBSvYDi+v0CxnUJLE2og0PzuuYk236f/a9WTDO2JjVbI2qydzk+fgUnq25w/atMOQ0uy3Yn0TqZG44VEtTHxmR8mz5DquZrChCPJra7m7J5qBuXWL3HdWN76yIQPIOeplAKf893JcHFbJ7iLR/F8dS0gmvaKyt/d/Ya78SJ0qClamXNtTK+mZETRLuK2H4+Kh0ZAAw9H2ZUI1oHgJ6o/fOktzZ5oeT0Ex+IHoG7W6YspNoH01zRfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGLuL6F8GuOQNeUruA5VrXrw4xtiptL9NbhhE6NWqug=;
 b=MqXQhfC74dF4BlXprZ1nlIr4td/QixmB6WZxuMLEVVFFqFltQFT2789DjqX1hxmhPDqHHiTZvrauNOvclY6TjbWSTagDn5FDAa5XmGkybLi5LNL/ici1S/hDaumVg/4zaY9Ri5ydNxWTJem9zmMr9/VPApMkD5hfM/0jav3TVmY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.9; Mon, 19 Aug 2019 19:56:33 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2199.011; Mon, 19 Aug 2019
 19:56:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call
 nfs4_call_sync_custom()
Thread-Topic: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call
 nfs4_call_sync_custom()
Thread-Index: AQHVVsRfEZKA6bhAqkO4h31uRUg2rKcC4tuA
Date:   Mon, 19 Aug 2019 19:56:32 +0000
Message-ID: <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
         <20190819192900.19312-5-Anna.Schumaker@Netapp.com>
In-Reply-To: <20190819192900.19312-5-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 428b99ec-63e3-4238-8846-08d724df55db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1851;
x-ms-traffictypediagnostic: DM5PR13MB1851:
x-microsoft-antispam-prvs: <DM5PR13MB1851E700414ABF21AD2C5316B8A80@DM5PR13MB1851.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(136003)(346002)(189003)(199004)(7736002)(6116002)(5660300002)(186003)(76116006)(91956017)(66446008)(66476007)(66556008)(81166006)(64756008)(8676002)(66946007)(305945005)(81156014)(256004)(25786009)(6506007)(2616005)(4326008)(6246003)(6512007)(102836004)(36756003)(26005)(486006)(53936002)(476003)(446003)(11346002)(66066001)(2906002)(118296001)(478600001)(86362001)(71200400001)(316002)(6486002)(99286004)(14454004)(2501003)(229853002)(6436002)(8936002)(3846002)(76176011)(71190400001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1851;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FldnwxLhv5zj8EMRursROqXvIh+K723EWAR1hpNxMvSivVxhqmBYQHdhOyt5hp3xAyryefytAJDEURyStkf3B8GoTJx4eN9hkoxKKVu2/OpINEs/Lj6KYKbq83F9A8IAZb/23aiRPO8XSbHJygOnl1aLLur8X8ru2ZcLEDBq1mmSJa0G+i+1QDEN8X5cecS+UwDXCBmdNrnCt01z2BsnVFjQ+KiZL2sxt7LrOjKt9tJrjHNjYGrYXsvzkR5B3tuBSKeGvJs1XMCa4fu/dOPFGkNmWcQPdixMQJNW8mkUEILsJjpbkVdXhsFsw6ziUHoPcPqugUrtg1zqXHBpqXLZJamoAtblMg0juZNzUcC8065B+zB7EVnG3m8n1GuHz8NNt9Y2VEGG9O1MgMZJyaOBVOGvC1CcQV+FueB6TwCvYCM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <135D4B24B31778479A702358B62B61B5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428b99ec-63e3-4238-8846-08d724df55db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 19:56:33.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOkr+dAPbQQnL5hakc4SqL1+BF2k7VaXCyJoHry/8gHcjed+MQ7rww3CmAtVlj/ptTSQ7qVSodZWhpYGx/ItDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1851
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDE1OjI4IC0wNDAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gQW4gYXN5bmMgY2FsbCBmb2xsb3dlZCBieSBhbiBycGNfd2FpdF9mb3JfY29t
cGxldGlvbigpIGlzIGJhc2ljYWxseQ0KPiB0aGUNCj4gc2FtZSBhcyBhIHN5bmNocm9ub3VzIGNh
bGwsIHNvIHdlIGNhbiB1c2UgbmZzNF9jYWxsX3N5bmNfY3VzdG9tKCkgdG8NCj4ga2VlcCBvdXIg
Y3VzdG9tIGNhbGxiYWNrIG9wcyBhbmQgdGhlIFJQQ19UQVNLX05PX1JPVU5EX1JPQklOIGZsYWcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0
YXBwLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDEzICsrLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4g
aW5kZXggZGUyYjNmZDgwNmVmLi4xYjc4NjNlYzEyZDMgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9u
ZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC04ODU3LDcgKzg4NTcs
NiBAQCBzdGF0aWMgaW50IG5mczQxX3Byb2NfcmVjbGFpbV9jb21wbGV0ZShzdHJ1Y3QNCj4gbmZz
X2NsaWVudCAqY2xwLA0KPiAgCQljb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgbmZzNF9yZWNsYWltX2NvbXBsZXRlX2RhdGEgKmNhbGxkYXRhOw0KPiAtCXN0cnVjdCBy
cGNfdGFzayAqdGFzazsNCj4gIAlzdHJ1Y3QgcnBjX21lc3NhZ2UgbXNnID0gew0KPiAgCQkucnBj
X3Byb2MgPQ0KPiAmbmZzNF9wcm9jZWR1cmVzW05GU1BST0M0X0NMTlRfUkVDTEFJTV9DT01QTEVU
RV0sDQo+ICAJCS5ycGNfY3JlZCA9IGNyZWQsDQo+IEBAIC04ODY2LDcgKzg4NjUsNyBAQCBzdGF0
aWMgaW50IG5mczQxX3Byb2NfcmVjbGFpbV9jb21wbGV0ZShzdHJ1Y3QNCj4gbmZzX2NsaWVudCAq
Y2xwLA0KPiAgCQkucnBjX2NsaWVudCA9IGNscC0+Y2xfcnBjY2xpZW50LA0KPiAgCQkucnBjX21l
c3NhZ2UgPSAmbXNnLA0KPiAgCQkuY2FsbGJhY2tfb3BzID0gJm5mczRfcmVjbGFpbV9jb21wbGV0
ZV9jYWxsX29wcywNCj4gLQkJLmZsYWdzID0gUlBDX1RBU0tfQVNZTkMgfCBSUENfVEFTS19OT19S
T1VORF9ST0JJTiwNCj4gKwkJLmZsYWdzID0gUlBDX1RBU0tfTk9fUk9VTkRfUk9CSU4sDQo+ICAJ
fTsNCj4gIAlpbnQgc3RhdHVzID0gLUVOT01FTTsNCj4gIA0KPiBAQCAtODg4MSwxNSArODg4MCw3
IEBAIHN0YXRpYyBpbnQgbmZzNDFfcHJvY19yZWNsYWltX2NvbXBsZXRlKHN0cnVjdA0KPiBuZnNf
Y2xpZW50ICpjbHAsDQo+ICAJbXNnLnJwY19hcmdwID0gJmNhbGxkYXRhLT5hcmc7DQo+ICAJbXNn
LnJwY19yZXNwID0gJmNhbGxkYXRhLT5yZXM7DQo+ICAJdGFza19zZXR1cF9kYXRhLmNhbGxiYWNr
X2RhdGEgPSBjYWxsZGF0YTsNCj4gLQl0YXNrID0gcnBjX3J1bl90YXNrKCZ0YXNrX3NldHVwX2Rh
dGEpOw0KPiAtCWlmIChJU19FUlIodGFzaykpIHsNCj4gLQkJc3RhdHVzID0gUFRSX0VSUih0YXNr
KTsNCj4gLQkJZ290byBvdXQ7DQo+IC0JfQ0KPiAtCXN0YXR1cyA9IHJwY193YWl0X2Zvcl9jb21w
bGV0aW9uX3Rhc2sodGFzayk7DQo+IC0JaWYgKHN0YXR1cyA9PSAwKQ0KPiAtCQlzdGF0dXMgPSB0
YXNrLT50a19zdGF0dXM7DQo+IC0JcnBjX3B1dF90YXNrKHRhc2spOw0KPiArCXN0YXR1cyA9IG5m
czRfY2FsbF9zeW5jX2N1c3RvbSgmdGFza19zZXR1cF9kYXRhKTsNCj4gIG91dDoNCj4gIAlkcHJp
bnRrKCI8LS0gJXMgc3RhdHVzPSVkXG4iLCBfX2Z1bmNfXywgc3RhdHVzKTsNCj4gIAlyZXR1cm4g
c3RhdHVzOw0KDQpIbW0uLi4gSSdtIGEgbGl0dGxlIGNvbmZ1c2VkLiBXaHkgZG9lcyBSRUNMQUlN
X0NPTVBMRVRFIG5lZWQNClJQQ19UQVNLX05PX1JPVU5EX1JPQklOPyBJdCBzaG91bGQgYmUgb3Jk
ZXJlZCBzbyBpdCBpcyBjYWxsZWQgYWZ0ZXINCkJJTkRfQ09OTl9UT19TRVNTSU9OIGluIG5mczRf
c3RhdGVfbWFuYWdlcigpLCBzbyBpbiBwcmluY2lwbGUgaXQgaXMNCnN1cHBvc2VkIHRvIGJlIGFi
bGUgdG8gcmVjb3ZlciBmcm9tIGFuIGVycm9yIGxpa2UNCk5GUzRFUlJfQ09OTl9OT1RfQk9VTkRf
VE9fU0VTU0lPTi4gQXJlIHRoZXJlIG90aGVyIHNpdHVhdGlvbnMgd2hlcmUgd2UNCm5lZWQgUlBD
X1RBU0tfTk9fUk9VTkRfUk9CSU4/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
