Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE14192820
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCYMWi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 08:22:38 -0400
Received: from mail-dm6nam11on2105.outbound.protection.outlook.com ([40.107.223.105]:46817
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgCYMWi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Mar 2020 08:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMzY/DhwKWDsVprX3f4uL1fW8HUN4Wd74ox7mMNf0nJqnY7ZjppTcUsywPeLz6GCBrACvL+kXWeiYAIeuFyC6vxBfMnGxNrDVBLezHp5m4yBkguiX5nniQ2ITYElNer60Nzn1YyWd+dDD+t9owRQOaOgfLHLRmrzKm32yFeoB+uMDr/OMZp4KSlywZCgQHOxEnyrRQ9+G2qS1W0VLtV0Hg+y/BftB2L5Y3bTMHFxQrasqiRV8PknYT7jk5mo6yyvm9sVMKRVqKBGeqkrjrhVLpt84dRwj6PwyV93qZcEsBpF1LSGC9GkpSPmB+9N5rxWSPk7rIRp1yHEqaD9J9T4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV3MMEsWn2FchVXm1glsWZfXrSI6JvUt/dXI4syd+Wc=;
 b=f9tE3D0pKmeBi3/h33w1WuLHKkmbTke6XRKaR6QfJgWF08n5BxNf9bc/Mb03S1snIAnFXbnxhSoNAjPK7V3R/WXb/M7Lrvx/2PZqKRtH9inFrQW0pLgvQ67jGkROylemfh3HGC85Tlq0UbU/WHdTJ+i+vFAsinX8BD+I60+Lol8pQANNAYX8DJNw7akcx2GHLH9nan/WSqCbs94pinysunF78/h2EJcZu1s+kbggI5zr82jC871SPDFx5Z0AQ5pv/DUyp1E25bgBl/nGKCA6GVXjjC61xUFGnY6Busb0OD5RIRIw2vyZirYHH5ulp1RAl9jmq5gxu4XHoZHHqkWsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV3MMEsWn2FchVXm1glsWZfXrSI6JvUt/dXI4syd+Wc=;
 b=D5O7crMlOFWI83KEGqOAovKNioYMoTU/hCYtWBXCtb2apctiDI+K2anRxOtIfAQL3IkUV0We13ZYJJcCYwh3uUql/qkc5TC+gRqUKvrzfbJSObzu4XIE/aAIB7QpgNYmDBWgEIG7GPA3QQD6YNbF/dz8q16HkyIfNAkOXDk4XYs=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3495.namprd13.prod.outlook.com (2603:10b6:610:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9; Wed, 25 Mar
 2020 12:22:34 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2856.019; Wed, 25 Mar 2020
 12:22:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jcpearson@gmail.com" <jcpearson@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
Thread-Topic: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
Thread-Index: AQHWApB2dty+EHb2pEm1vl64uVQzXqhZOvwA
Date:   Wed, 25 Mar 2020 12:22:34 +0000
Message-ID: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com>
References: <CAK3fRr_Yh9Ko+E3-=z6g8p0vvUA9QW+PAoQ+ct3EWya9_oxZ3w@mail.gmail.com>
In-Reply-To: <CAK3fRr_Yh9Ko+E3-=z6g8p0vvUA9QW+PAoQ+ct3EWya9_oxZ3w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed3711c-89bd-4d63-f205-08d7d0b732c0
x-ms-traffictypediagnostic: CH2PR13MB3495:
x-microsoft-antispam-prvs: <CH2PR13MB3495A8599884A2F438DEB625B8CE0@CH2PR13MB3495.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39830400003)(136003)(396003)(8676002)(110136005)(91956017)(76116006)(5660300002)(26005)(71200400001)(6486002)(186003)(8936002)(2906002)(478600001)(6512007)(81156014)(316002)(86362001)(36756003)(66946007)(6506007)(66476007)(66446008)(2616005)(64756008)(66556008)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR13MB3495;H:CH2PR13MB3398.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J46l4s2QNBqxkZvnGGUNpcRu0Ivl9Qm+92Uz3grEbDq4yNiyVgI995KygET6H2YTJ+sOnFkH86O929RFcLoerZ5mnNmBpeRfMXJBanBiT0AQDM8zRfdtdLJrlmTZHNGahlYfBi5cur1U8nQrxVtYES9cTNZlotAj1KdblNRcovj0fcHSUgOyo1WGUk7UTbBTEmM//kK1hqKnnQq3u5m6yY2fmtBRfqJNrIpMyhZUGmP6oHC3N3e/2wIDt0nVev3MNemVjNmCwKacCP0RCfZ8e+fnKfu+npRrzNIqDbGPCiBBeD/9OQKasoOUDBwjcgbqxQskta0t8nsURIlahJPwgFoab+6Kom6Py3ttKUmAKTaXG72fNe7cYA0BVInfZVcGqRMlCrcN6XB+X3ABegdzIUI+ckTHDeEN/yG/WvyYNUphMIfrAYfUrESj5YZeMUYE
x-ms-exchange-antispam-messagedata: uyKwzdwW47ab02qcwHfFK1gPE23np49YuODWeWMhE8rrjLKPZ6MWd6vuEEWuwcdDxSpFwRawU6VSFhBC3INYuazQX3hMmLH+8z73Ngj4xsICYqelkvBWkasJkInMgVMSZWfqPjRX2oFF+2IoYADK7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDCFE66AE8FFC54EB2F285462BFB2393@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed3711c-89bd-4d63-f205-08d7d0b732c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 12:22:34.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHbhfgjnyVmOQslkInvPyzERQMH2hqHcBXdhDSbVrombQ8cqLkJtajVrfCxbdYWHHPkBJJN5BCj3aEIS5z87yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3495
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDEwOjMwICswMDAwLCBKYW1lcyBQZWFyc29uIHdyb3RlOg0K
PiBXZSdyZSBzZWVpbmcgYSBudW1iZXIgb2YgTGludXggKENlbnRPUyA3LjUpIGNsaWVudHMgZ2V0
dGluZyBuZnM6DQo+IHNlcnZlciBpc2lsb24gbm90IHJlc3BvbmRpbmcsIHN0aWxsIHRyeWluZycg
IGZyb20gdmFyaW91cyBleHBvcnRzDQo+IGZyb20NCj4gYSBJc2lsb24NCj4gDQo+IEkgYXBwcmVj
aWF0ZSB3ZSdyZSB1c2luZyBhIHZlbmRvcidzIExpbnV4IChvdXQtb2YtZGF0ZSkga2VybmVsIGFu
ZCBhDQo+IHRoaXJkIHBhcnR5IGZpbGVyLCBidXQgaWYgYW55b25lIGNhbiBnaXZlIG1lIGFueSBw
b2ludGVycyBvZiBob3cgdG8NCj4gZGVidWcgdGhpcyBpc3N1ZSwgSSB3b3VsZCBiZSBncmF0ZWZ1
bCAod2UgYWxzbyBoYXZlIGEgc3VwcG9ydCBjYXNlDQo+IG9wZW4gd2l0aCB0aGUgSXNpbG9uIHZl
bmRvcikNCj4gDQo+IFJ1bm5pbmcgdHNoYXJrIG9uIGEgY2xpZW50IHdoZW4gdGhpcyBpc3N1ZSBo
YXBwZW5zICh0YWtlbiBzZXZlcmFsDQo+IGhvdXJzIGFmdGVyIHRoZSBpc3N1ZSBoYXBwZW5lZCks
IHdlIGdldCByZXBlYXRpbmc6DQo+IA0KPiAgIDEgICAxMjoxODoxMSAxMC43OC4yMDEuOTUgLT4g
MTAuNzguMTk2LjE4NCBORlMgMTk0IFY0IENhbGwgUkVORVcNCj4gQ0lEOiAweGRlNjgNCj4gICAy
ICAgMTI6MTg6MTEgMTAuNzguMTk2LjE4NCAtPiAxMC43OC4yMDEuOTUgTkZTIDExNCBWNCBSZXBs
eSAoQ2FsbA0KPiBJbg0KPiAxKSBSRU5FVyBTdGF0dXM6IE5GUzRFUlJfU1RBTEVfQ0xJRU5USUQN
Cj4gICA0ICAgMTI6MTg6MTYgMTAuNzguMjAxLjk1IC0+IDEwLjc4LjE5Ni4xODQgTkZTIDE5NCBW
NCBDYWxsIFJFTkVXDQo+IENJRDogMHhkZTY4DQo+ICAgNSAgIDEyOjE4OjE2IDEwLjc4LjE5Ni4x
ODQgLT4gMTAuNzguMjAxLjk1IE5GUyAxMTQgVjQgUmVwbHkgKENhbGwNCj4gSW4NCj4gNCkgUkVO
RVcgU3RhdHVzOiBORlM0RVJSX1NUQUxFX0NMSUVOVElEDQo+ICAgNyAgIDEyOjE4OjIxIDEwLjc4
LjIwMS45NSAtPiAxMC43OC4xOTYuMTg0IE5GUyAxOTQgVjQgQ2FsbCBSRU5FVw0KPiBDSUQ6IDB4
ZGU2OA0KPiAgIDggICAxMjoxODoyMSAxMC43OC4xOTYuMTg0IC0+IDEwLjc4LjIwMS45NSBORlMg
MTE0IFY0IFJlcGx5IChDYWxsDQo+IEluDQo+IDcpIFJFTkVXIFN0YXR1czogTkZTNEVSUl9TVEFM
RV9DTElFTlRJRA0KPiAuLi4NCj4gDQo+IE15IGtub3dsZWRnZSBvZiBORlN2NCBpcyBza2V0Y2h5
LCBidXQgZnJvbSBteSAocGFydGlhbCkgcmVhZGluZyBvZg0KPiByZmM3NTMwIHNob3VsZG4ndCB0
aGUgY2xpZW50IGJlIHNlbmRpbmcgYSBTRVRDTElFTlRJRCBpbiByZXNwb25zZSB0bw0KPiBhDQo+
IE5GUzRFUlJfU1RBTEVfQ0xJRU5USUQgLSB3aGljaCBkb2Vzbid0IGFwcGVhciB0byBiZSBoYXBw
ZW5pbmcgaGVyZT8NCj4gDQo+IEFsdGhvdWdoIHRoZSBzZXJ2ZXIgaGFzbid0IHJlYm9vdGVkIHNp
bmNlIHRoZSBjbGllbnQgbW91bnRlZCB0aGUgZmlsZQ0KPiBzeXN0ZW0gLSBzbyBub3Qgc3VyZSB3
aGF0IG1pZ2h0IGJlIGdvaW5nIG9uID8NCj4gDQo+IFdlIGFyZSB1cGdyYWRpbmcgY2xpZW50cyB0
byB0aGUgbGF0ZXN0IENlbnRPUyAoUkhFTCkgNy43IHRvIHNlZSBpZg0KPiB0aGF0ICdmaXhlcycg
dGhlIGlzc3VlIC0gYnV0IHdvdWxkIGFwcHJlY2lhdGUgYW55IG90aGVyIHBvaW50ZXJzDQo+IA0K
DQpXQUc6IHRoZSBjbGllbnRzIGFsbCBoYXZlIHRoZSBkZWZhdWx0IGhvc3RuYW1lICdsb2NhbGhv
c3QubG9jYWxkb21haW4nDQphbmQgYXJlIHVzaW5nIHRoYXQgdG8gaWRlbnRpZnkgdGhlbXNlbHZl
cyBpbiB0aGUgU0VUQ0xJRU5USUQgY2FsbD8gSWYNCnNvLCB0aGF0IHdvdWxkIGNhdXNlIHRoZW0g
dG8gY2FuY2VsIGVhY2ggb3RoZXIncyBsZWFzZXMgYnkgZGVjbGFyaW5nDQpjbGllbnQgcmVib290
cyBvZiB0aGUgY2xpZW50IHdpdGggbmFtZSAnbG9jYWxob3N0LmxvY2FsZG9tYWluJy4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
