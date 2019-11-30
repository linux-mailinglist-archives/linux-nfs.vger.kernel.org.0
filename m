Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBED10DF62
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2019 22:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfK3VVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Nov 2019 16:21:11 -0500
Received: from mail-eopbgr750124.outbound.protection.outlook.com ([40.107.75.124]:42308
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfK3VVL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 30 Nov 2019 16:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4paU17EzykxL6GW14Ytr8dzSRgDFODLyzlrK56c0qVUKk4zVIhkENHBjvUtYtMq8VFiGmrWah+SL7yFDppE9XUD471TyzwBlHhtmpm6MjWodycxfJ3AD2m6i7+hY0NaHo7KJSuMbsfvEUlDoWUTVP0X1oAAjC6mIOfCBSuXWY2o3DZDvoLIbW/jC92BKMpOhVr9OXoh3c3bw/Z7mkR5hI42yGqkcyAdpEsvUOOHuMifyaY+bBvQvfzDL8nr/mftuUqG1jNOhfoOSgM43nmJIIh7syJsiu8J7h3Jk0XPvkYqSQLicQRupVAeBRWZ2vgVaNqoH/AMOAeEtvGRSHHHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcfQLZVNeUASGu9wJa2h2Q/Y64xCof7du2bc2uptjCg=;
 b=MrzyVBDfi2/QV7xHIwcpCL+IKX7KDUlokWph1JynEZkLFTkBCTBY5wtYWyHS+xB3f94mzTyjhKyfEX0aUthEC31nu6tcp1SVCcXWzzPTBbhl8I/KBEmN3MPu/F51Zi70/+tfPCbZHwY4bfJD2srXbrHf8aTYjI2RKwUZp1NzBlU1OQtqgmxDg3ZtD7Rub3OuQ2vNC17RtXzT8NSqf0kfETKm8roCPt9T+ns7+OJK4Y+YK1c43i6WRsPZcYL50XNuPJMPB1E3/KghleVnAiCgovFWd6qPuacF6YbVJkMWACZ2vPgFYREf3FeHKPialOFQZDXs/VKyORCz26MJHmEgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcfQLZVNeUASGu9wJa2h2Q/Y64xCof7du2bc2uptjCg=;
 b=dihSrmfMmxntG7GYV7ePQRPZ/lHrvrMT4/XZOEaBo4YRAp/uFSMlHsVXs28tspbrCFhjRpjizVuS4umIi4leg5kOH/vXh8xs9ZleHE7oaJCBo2UqdiHEUR5pPCc/3+LA0GO6DUJ5OB6EJQ+IAhLOyDMNxz2J1D43RNZrPOOLEdY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2028.namprd13.prod.outlook.com (10.174.182.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.4; Sat, 30 Nov 2019 21:21:06 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2516.003; Sat, 30 Nov 2019
 21:21:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] nfsd: Ensure CLONE persists data and metadata changes to
 the target file
Thread-Topic: [PATCH] nfsd: Ensure CLONE persists data and metadata changes to
 the target file
Thread-Index: AQHVpW8lTY4fVVpBxUyHMk/Wshk8q6eg3oqAgANHj4CAABctAA==
Date:   Sat, 30 Nov 2019 21:21:05 +0000
Message-ID: <1b1218603c483b8bf9e703a8e2176d4d24024b39.camel@hammerspace.com>
References: <20191127220551.36159-1-trond.myklebust@hammerspace.com>
         <201911290023.E0Ae2YFx%lkp@intel.com> <20191130195807.GA19460@fieldses.org>
In-Reply-To: <20191130195807.GA19460@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7aca45e-b717-49f3-3b4c-08d775db35f0
x-ms-traffictypediagnostic: DM5PR1301MB2028:
x-microsoft-antispam-prvs: <DM5PR1301MB20288FE7A47C4EC9C535C1EBB8410@DM5PR1301MB2028.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:158;
x-forefront-prvs: 02379661A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39830400003)(346002)(199004)(189003)(76116006)(36756003)(118296001)(4001150100001)(2616005)(6436002)(6486002)(2906002)(508600001)(229853002)(446003)(6246003)(5660300002)(66066001)(256004)(11346002)(91956017)(81166006)(6506007)(316002)(66946007)(66446008)(66476007)(66556008)(64756008)(110136005)(305945005)(8936002)(54906003)(81156014)(4744005)(6306002)(6512007)(14454004)(99286004)(3846002)(6116002)(8676002)(102836004)(26005)(76176011)(86362001)(25786009)(2501003)(71200400001)(71190400001)(186003)(4326008)(966005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2028;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRUzF0rXU0eNXrBERXQthZuVKV2ryqGgFKtQevu96b+XAEpRqNTbf/AsMBYNtVw0iixyb4cZc0KNPdrTyhA9KCvVi/A2ppdP0IK2AAKx2KA5pJn58xrJ0SEoDiOwmL3fWOQeiAY3rUCEOXge8M0ZPhriiaSV+id1FEisUqPCv2QdG6w9NOkv9zAoyOl+ZBKiAuLDXFMnCAb59+7gAc+8JqPabVGqlM3Hs21EaimCJxP64j61D84E7ZOC7H26oxfelJpUdFBQLELNMMqhXD0I/ce+7vCf5X0S8ZQMBHf+sIBmPoPmJKT8235aBfS/Ja6UYuSSlh/ydSsyJq5RTjqn74pQL8PchZQoO9y0n/QqCN/VjxYhT4fCdlvyJq2mYAgQVyJzyQTCL0BE9InFg5dkWH4/rA+loEp9mt2k0EPsIoeTY5eTGyUTdQlp/VX4JcI9oTpp/ofPF3u1MYFsVx/2G/Q2YD4YnSXsjPqtJqqrnzQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <944A9328D8D2E2498F12979DE2C281D3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aca45e-b717-49f3-3b4c-08d775db35f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2019 21:21:05.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we4rd7eesMh9bBuHLP3v+JRNRP8+eHZpSjAq08ipXkBYtWJ4n4PJXd96PoLXbHRlOcB1FXmwMRjB559oaVWTxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2028
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDE5LTExLTMwIGF0IDE0OjU4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgTm92IDI5LCAyMDE5IGF0IDAxOjUzOjEzQU0gKzA4MDAsIGtidWlsZCB0ZXN0
IHJvYm90IHdyb3RlOg0KPiA+ICAgIGZzLy9uZnNkL3Zmcy5jOiBJbiBmdW5jdGlvbiAnbmZzZDRf
Y2xvbmVfZmlsZV9yYW5nZSc6DQo+ID4gPiA+IGZzLy9uZnNkL3Zmcy5jOjU0MDo1OiBlcnJvcjog
J2NvbW1pdF9pc19kYXRhc3luYycgdW5kZWNsYXJlZA0KPiA+ID4gPiAoZmlyc3QgdXNlIGluIHRo
aXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4gJ2NvbW1pdF9tZXRhZGF0YSc/DQo+IC4uLg0KPiA+
ICAgIDUzOQkJCWludCBzdGF0dXMgPSB2ZnNfZnN5bmNfcmFuZ2UoZHN0LA0KPiA+IGRzdF9wb3Ms
IGRzdF9lbmQsDQo+ID4gID4gNTQwCQkJCQljb21taXRfaXNfZGF0YXN5bmMpOw0KPiANCj4gSSd2
ZSByZXBsYWNlZCBjb21taXRfaXNfZGF0YXN5bmMgYnkgMC4gIFRyb25kLCBjb3JyZWN0IG1lIGlm
IEkgZ290DQo+IHRoYXQNCj4gd3JvbmcuDQoNCkRvaCEgU29ycnkgYWJvdXQgdGhhdC4gSSBibGFt
ZSBFTk9DT0ZGRUUuLi4NCg0KVGhhbmtzIQ0KICBUcm9uZA0KPiANCj4gLS1iLg0KPiANCj4gPiAg
ICA1NDEJCQlpZiAoc3RhdHVzIDwgMCkNCj4gPiAgICA1NDIJCQkJcmV0dXJuIG5mc2Vycm5vKHN0
YXR1cyk7DQo+ID4gICAgNTQzCQl9DQo+ID4gICAgNTQ0CQlyZXR1cm4gMDsNCj4gPiAgICA1NDUJ
fQ0KPiA+ICAgIDU0NgkNCj4gPiANCj4gPiAtLS0NCj4gPiAwLURBWSBrZXJuZWwgdGVzdCBpbmZy
YXN0cnVjdHVyZSAgICAgICAgICAgICAgICAgT3BlbiBTb3VyY2UNCj4gPiBUZWNobm9sb2d5IENl
bnRlcg0KPiA+IGh0dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxs
QGxpc3RzLjAxLm9yZyBJbnRlbA0KPiA+IENvcnBvcmF0aW9uDQo+IA0KPiANCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
