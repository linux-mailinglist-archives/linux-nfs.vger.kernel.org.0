Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8E257E5
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfEUS7J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 14:59:09 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com ([40.107.68.113]:18368
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbfEUS7J (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 14:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SF/BiSPn2q6syvsB3o4vxS7PXFhBKZe+1+d/JMfV4k=;
 b=PEu7Cx/GUXL2GWfvj3RknmIi2wzhr/FBRkw20RKTi8c3sizwBiGoD/qFAZt4Z9xdiIJzUO4eMwFhXR/K2QfpzCajAHekQM1KsQpiobfmQHYMaiYJE/mY95wuZwt0gjFhwMI+rh8BwAa59BJz4hcR2/nPkGWwBvHrVSL+3xWrrn4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1644.namprd13.prod.outlook.com (10.171.156.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.7; Tue, 21 May 2019 18:59:05 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 18:59:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagCAAAuogA==
Date:   Tue, 21 May 2019 18:59:04 +0000
Message-ID: <8ed1dd2918cdc95c629c5a8376173d7f02979734.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
         <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
In-Reply-To: <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7820786f-ce7d-4e05-f805-08d6de1e654f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR13MB1644;
x-ms-traffictypediagnostic: DM5PR13MB1644:
x-microsoft-antispam-prvs: <DM5PR13MB164477C935ED55B3795FAF34B8070@DM5PR13MB1644.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(66066001)(305945005)(7736002)(6512007)(478600001)(14454004)(229853002)(6116002)(64756008)(66556008)(66476007)(476003)(486006)(3846002)(66446008)(6916009)(26005)(86362001)(102836004)(186003)(6436002)(25786009)(5640700003)(53546011)(6506007)(6486002)(53936002)(99286004)(76176011)(4326008)(2501003)(6246003)(118296001)(54906003)(2906002)(8936002)(8676002)(81156014)(81166006)(1730700003)(2351001)(71200400001)(1411001)(71190400001)(36756003)(66946007)(2616005)(73956011)(5660300002)(76116006)(316002)(11346002)(68736007)(14444005)(256004)(446003)(1361003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1644;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3C+2pxZVXdUZmQCGkIVBapcTItKF19Y+/ghzsqqeQEVDj5AZkFgMCHIqWbT5xOr7ZrpANDXt6US89R9y90JQa+DgvWSojNEBQYqXwXdmiMYvDrN6gFcbhsXTAR0SdNiv/hJ8MWXnRj5NVPPAa3Lm3w2AnSKdAODuv0WjBC+K7VRAn5l5jMT8sIkwC613He6bM+SRFfHyrKzOdJteJAaBhCHh+Zr4KHOnoA1WJiLz/wFhE9/ibeu4g7yFOrn5QmLTF21zGm0gcUwIjJnM7cw0F+IFFuHNF7IEoK5cElO/Y48IJm64MEB62DaDP4ZRD50fTSElwleNZ+3lE2K/Yr0i1KYa6Ouxb/lrHtDCgg5O1+eDfNLUknByyaqRytY7ErtIyUUOQfT9tTYu45QVpirb8LTY4wCfPURv7i+UOIVAFng=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12B8A2EFE83F84B81D1614D459F5FB6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7820786f-ce7d-4e05-f805-08d6de1e654f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 18:59:04.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1644
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDE4OjE3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOS0wNS0yMSBhdCAxMzo0MCAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6
DQo+ID4gSGkgVHJvbmQgLQ0KPiA+IA0KPiA+ID4gT24gTWF5IDIxLCAyMDE5LCBhdCA4OjQ2IEFN
LCBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAZ21haWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4g
PiANCj4gPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2hzZXQgYWRkcyBzdXBwb3J0IGZvciB0aGUgJ3Jv
b3RfZGlyJw0KPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4gb3B0aW9uIGZvciBuZnNkIGluIG5m
cy5jb25mLiBJZiBhIHVzZXIgc2V0cyB0aGlzIG9wdGlvbiB0byBhDQo+ID4gPiB2YWxpZA0KPiA+
ID4gZGlyZWN0b3J5IHBhdGgsIHRoZW4gbmZzZCB3aWxsIGFjdCBhcyBpZiBpdCBpcyBjb25maW5l
ZCB0byBhDQo+ID4gPiBjaHJvb3QNCj4gPiA+IGphaWwgYmFzZWQgb24gdGhhdCBkaXJlY3Rvcnku
IEFsbCBwYXRocyBpbiAvZXRjL2V4cG9yZnMgYW5kIGZyb20NCj4gPiA+IGV4cG9ydGZzIGFyZSB0
aGVuIHJlc29sdmVkIHJlbGF0aXZlIHRvIHRoYXQgZGlyZWN0b3J5Lg0KPiA+IA0KPiA+IFdoYXQg
YWJvdXQgZmlsZXMgdW5kZXIgL3Byb2MgdGhhdCBtb3VudGQgbWlnaHQgYWNjZXNzPyBJIGFzc3Vt
ZQ0KPiA+IHRoZXNlDQo+ID4gcGF0aG5hbWVzIGFyZSBub3QgYWZmZWN0ZWQuDQo+ID4gDQo+IFRo
YXQncyB3aHkgd2UgaGF2ZSAyIHRocmVhZHMuIE9uZSB0aHJlYWQgaXMgcm9vdCBqYWlsZWQgdXNp
bmcgY2hyb290LA0KPiBhbmQgaXMgdXNlZCB0byB0YWxrIHRvIGtuZnNkLiBUaGUgb3RoZXIgdGhy
ZWFkIGlzIG5vdCByb290IGphaWxlZCAob3INCj4gYXQgbGVhc3Qgbm90IGJ5IHJvb3RfZGlyKSBh
bmQgc28gaGFzIGZ1bGwgYWNjZXNzIHRvIC9ldGMsIC9wcm9jLA0KPiAvdmFyLA0KPiAuLi4NCg0K
SSBzaG91bGQgcGVyaGFwcyBub3RlIHRoYXQgdGhlIHJlYXNvbiB3aHkgSSB1c2VkIGEgc2Vjb25k
IHRocmVhZCwNCnJhdGhlciB0aGFuIHVzaW5nIGZvcmsoKWVkIHByb2Nlc3NlcyBsaWtlIHRoZSBy
ZXN0IG9mIHRoZSBtb3VudGQgY29kZQ0KaXMgdG8gYWxsb3cgdGhlIHNoYXJpbmcgb2YgZmlsZSBk
ZXNjcmlwdG9ycywgc28gdGhhdCB0aGUgdW5jb25maW5lZA0KdGhyZWFkIGNhbiBvcGVuIGZpbGVz
IHRoYXQgY2FuIHRoZW4gYmUgZWFzaWx5IHVzZWQgYnkgdGhlIHJvb3QgamFpbGVkDQp0aHJlYWQu
DQoNClRoaXMgbWVhbnMgdGhhdCBpZiB5b3UgaGF2ZSBhbiBvbGQgZ2xpYmMgdGhhdCBkb2VzIG5v
dCBzdXBwb3J0IFBPU0lYDQp0aHJlYWRzLCB0aGVuIHRoZSAncm9vdF9kaXInIGZ1bmN0aW9uYWxp
dHkgaXMgZGlzYWJsZWQuIERpdHRvIGlmIHlvdQ0KaGF2ZSBhIGtlcm5lbCB0aGF0IGRvZXMgbm90
IHN1cHBvcnQgdGhlIHVuc2hhcmUoKSBzeXN0ZW0gY2FsbCBvciBpZiBpdA0KZG9lcyBub3Qgc3Vw
cG9ydCBvcGVuYXQoKStmc3RhdGF0KCkuDQoNCj4gPiBBcmVuJ3QgdGhlcmUgYWxzbyBvbmUgb3Ig
dHdvIG90aGVyIGZpbGVzIHRoYXQgbWFpbnRhaW4gZXhwb3J0IHN0YXRlDQo+ID4gbGlrZSAvdmFy
L2xpYi9uZnMvcm10YWI/IEFyZSB0aG9zZSBhZmZlY3RlZD8NCj4gDQo+IFNlZSBhYm92ZS4gVGhl
eSBhcmUgbm90IGFmZmVjdGVkLg0KPiANCj4gPiBJTUhPIGl0IGNvdWxkIGJlIGxlc3MgY29uZnVz
aW5nIHRvIGFkbWluaXN0cmF0b3JzIHRvIG1ha2Ugcm9vdF9kaXINCj4gPiBhbg0KPiA+IFtleHBv
cnRmc10gb3B0aW9uIGluc3RlYWQgb2YgYSBbbW91bnRkXSBvcHRpb24sIGlmIHRoaXMgaXMgbm90
IGENCj4gPiB0cnVlDQo+ID4gY2hyb290IG9mIG1vdW50ZC4NCj4gDQo+IEl0IGlzIG5laXRoZXIu
IEkgbWFkZSBpbiBhIFtuZnNkXSBvcHRpb24sIHNpbmNlIGl0IGdvdmVybnMgdGhlIHdheQ0KPiB0
aGF0DQo+IGJvdGggZXhwb3J0ZnMgYW5kIG1vdW50ZCB0YWxrIHRvIG5mc2QuDQo+IA0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
