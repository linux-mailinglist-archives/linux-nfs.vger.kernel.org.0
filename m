Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD65725A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZULv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 16:11:51 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:22338
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfFZULv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Jun 2019 16:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQvRDlRb7vfY31TS56pTXqKwbhoz2uLeVo3vQ5DiYT0=;
 b=eiSivyCRTeyV3PXEWwkGqYK8Da2mnyOvZxW61Z7/f3coA49nVwEI67iGCuxgEHxdnav81W6aOBsOVyv/qcp7UbUIVwy9yBHH0ssX+LjG9RoIx/UfEjmwx6nBwImPfd4LSEWYxMUoWbIBkaDxMFD5qBRPvjTYTv4IggCeFvrPQdk=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1642.namprd13.prod.outlook.com (10.171.154.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Wed, 26 Jun 2019 20:11:47 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 20:11:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix possible autodisconnect during connect due to
 stale last_used
Thread-Topic: [PATCH] SUNRPC: Fix possible autodisconnect during connect due
 to stale last_used
Thread-Index: AQHVLFheQuKPpmXLNUabIWI7udEXAKauXhCA
Date:   Wed, 26 Jun 2019 20:11:47 +0000
Message-ID: <566e3eb7b501d48a2989461c316b66c03c56b129.camel@hammerspace.com>
References: <1561578606-24602-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1561578606-24602-1-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca81167-4a2f-4460-5ebe-08d6fa728450
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1642;
x-ms-traffictypediagnostic: DM5PR13MB1642:
x-microsoft-antispam-prvs: <DM5PR13MB164260376B2AD4249552C426B8E20@DM5PR13MB1642.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39840400004)(189003)(199004)(86362001)(8936002)(26005)(102836004)(6116002)(186003)(6512007)(229853002)(305945005)(68736007)(5640700003)(118296001)(14444005)(3846002)(53936002)(99286004)(7736002)(76176011)(2501003)(2906002)(6486002)(64756008)(71200400001)(73956011)(66446008)(6506007)(25786009)(486006)(66946007)(66556008)(2351001)(5660300002)(71190400001)(36756003)(6916009)(81156014)(478600001)(14454004)(81166006)(256004)(446003)(66476007)(76116006)(4326008)(11346002)(1730700003)(8676002)(66066001)(476003)(316002)(6246003)(2616005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1642;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gsYq4SBemGfZR9d28iCrJObErJpHtqPnesBVjEHV8PbJzjXPrtdq+wIYnJa1VcE7zFwuHCQvE/8tnIry0ksHuSA6ksz555FQHGr0xK5G5cDchvJCc/uwJdEPx8UwDlLEPtLMH4KMJ6uYSFae5JbEEqmOt/10Fl48eUPTHm8CN6V6ZnFsqbJSwprLH0+MZB+oCmTsaAM0vSVNjPMtYJpZlhJuwgi/7aOwycxdkCqdjd9h/pte9dRLD6jaCFZoI+zmkZQI75+szePmbpiJj/HM67mD+tWA29+TFNEIviFhd8VikUXVKiNj7nrOnXh5CD07vrOGgZXzTcLLrM7f507MJU733kugkZ/Rq96mLiUXTgGtnM6luR2TF6hRrmJYm4PtYAJADQGHCfJY9YQdg107HPztbY1s3RAgR7QdicyQ20o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB9DE7F67C211240989ABD1156F7A7B4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca81167-4a2f-4460-5ebe-08d6fa728450
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:11:47.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1642
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTI2IGF0IDE1OjUwIC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Og0KPiBXaGVuIGEgY29ubmVjdGlvbiBpcyBzdWNjZXNzZnVsIGVuc3VyZSBsYXN0X3VzZWQgaXMg
dXBkYXRlZCBiZWZvcmUNCj4gY2FsbGluZw0KPiB4cHJ0X3NjaGVkdWxlX2F1dG9kaXNjb25uZWN0
IGluc2lkZSB4cHJ0X3VubG9ja19jb25uZWN0LiAgVGhpcyBhdm9pZHMNCj4gYQ0KPiBwb3NzaWJs
ZSB4cHJ0X2F1dG9jbG9zZSBmaXJpbmcgaW1tZWRpYXRlbHkgYWZ0ZXIgY29ubmVjdCBzZXF1ZW5j
ZSBkdWUNCj4gdG8NCj4gYW4gb2xkIHZhbHVlIG9mIGxhc3RfdXNlZCBnaXZlbiB0byBtb2RfdGlt
ZXIgaW4NCj4geHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmUgV3lzb2NoYW5za2kgPGR3eXNvY2hhQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgbmV0
L3N1bnJwYy94cHJ0LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydC5jIGIvbmV0L3N1bnJwYy94cHJ0LmMN
Cj4gaW5kZXggZjZjODJiMS4uZmNlYWVkZSAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0
LmMNCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0LmMNCj4gQEAgLTgwMCw2ICs4MDAsNyBAQCB2b2lk
IHhwcnRfdW5sb2NrX2Nvbm5lY3Qoc3RydWN0IHJwY194cHJ0ICp4cHJ0LA0KPiB2b2lkICpjb29r
aWUpDQo+ICAJCWdvdG8gb3V0Ow0KPiAgCXhwcnQtPnNuZF90YXNrID1OVUxMOw0KPiAgCXhwcnQt
Pm9wcy0+cmVsZWFzZV94cHJ0KHhwcnQsIE5VTEwpOw0KPiArCXhwcnQtPmxhc3RfdXNlZCA9IGpp
ZmZpZXM7DQo+ICAJeHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdCh4cHJ0KTsNCj4gIG91dDoN
Cj4gIAlzcGluX3VubG9ja19iaCgmeHBydC0+dHJhbnNwb3J0X2xvY2spOw0KDQpMZXQncyBqdXN0
IG1vdmUgdGhhdCBsaW5lIGludG8geHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdCgpLCBzaW5j
ZSBpbg0KcHJhY3RpY2UgdGhpcyBtZWFucyBhbGwgY2FsbGVycyBhcmUgZG9pbmcgdGhlIHNhbWUg
dGhpbmcuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
