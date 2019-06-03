Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDB334A8
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfFCQNI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 12:13:08 -0400
Received: from mail-eopbgr810100.outbound.protection.outlook.com ([40.107.81.100]:32746
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfFCQNI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 12:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJlBSDt6qfBd+7U9ck2Ot5btsE5LGVxFjq0xi4GXhh4=;
 b=Pk3RO5PwcVW1zeuGLx+4BdxoKfCAhOHi9G15s+AxYiH+p7gPgz2H3gSvAWzFWIb7kvuu8E16y1JOXjqv4jCeRog2W2V8CWSBmtWlmQtTgNTWsEVzMOFwRETZxIZ0vmTmy9jVvTprZaldYYx/KIH8YTlqiTHr6mbdkQJuS6PqEVo=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1866.namprd13.prod.outlook.com (10.171.161.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 3 Jun 2019 16:13:04 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Mon, 3 Jun 2019
 16:13:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS (pNFS) and VM dirty bytes
Thread-Topic: NFS (pNFS) and VM dirty bytes
Thread-Index: cmnjngump0CQm9y9bsnEoMSaFt7C8dZtElgA
Date:   Mon, 3 Jun 2019 16:13:04 +0000
Message-ID: <dc63d09f3bd397da1da82a8ebd6e6a768f12c509.camel@hammerspace.com>
References: <1811809323.9701664.1559574448351.JavaMail.zimbra@desy.de>
In-Reply-To: <1811809323.9701664.1559574448351.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d3b2911-2e7a-4986-c6da-08d6e83e5bc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1866;
x-ms-traffictypediagnostic: DM5PR13MB1866:
x-microsoft-antispam-prvs: <DM5PR13MB1866219B4F9491FD1F0A1493B8140@DM5PR13MB1866.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39830400003)(376002)(189003)(199004)(413944005)(6246003)(186003)(71190400001)(71200400001)(5660300002)(68736007)(66066001)(2906002)(478600001)(26005)(102836004)(110136005)(6436002)(6486002)(6512007)(14454004)(53936002)(25786009)(99286004)(3846002)(6506007)(76176011)(229853002)(305945005)(36756003)(6116002)(66556008)(66446008)(316002)(118296001)(73956011)(66946007)(66476007)(76116006)(91956017)(64756008)(2616005)(476003)(81166006)(81156014)(11346002)(86362001)(486006)(8676002)(14444005)(256004)(446003)(8936002)(7736002)(2501003)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1866;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QB80M+wjWiZ9oDjkgm7LLLTapy7OEA0ti32ayDwPvl7+jgpLDQQK4HUG/JMxAIkL+4c2AKMo0KDhCUqB0eeMArB/ewPdHDHhVasJXPC7r9vz7Ojs2akMkmKNPrGzfhYar/8xpopoz7SkdpgZSYzjwuoUpP7si1wWbgE/asvhdM9BskdKU1m9+4Y05pw71iKRciA5XDKgob1bxrIoYhay8v1IHOP1JnOZWaT6GzZIJAbj6jA9VqoqcMRIDlV2ctr4XaL1wnQzyU5rNLBOkL/tgAoOkRhOFx1jkueoxReNh5EIT+TdGvs+Pdvepsru1xvEZ9Ih/RgzPArVs1LMCyF5Rke5Ua0xQwBDW2TQkALFgFJPOUEQNHIHEZ7Q2Q/nMyvoW5cNlY8PUCOkijMFsYSUkqJnk0A8Z4yCfi1CXtwPiy0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61788C109FFE7C4DA643081B811013DE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3b2911-2e7a-4986-c6da-08d6e83e5bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 16:13:04.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1866
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTAzIGF0IDE3OjA3ICswMjAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gDQo+IERlYXIgTkZTIGZlbGxvd3MsDQo+IA0KPiB0aG91Z2ggdGhpcyBpcyBub3QgZGly
ZWN0bHkgTkZTIGlzc3VlLCBJIHBvc3QgdGhpcyBxdWVzdGlvbg0KPiBoZXJlIGFzIHdlIG1vc3Rs
eSBhZmZlY3RlZCBieSBORlMgY2xpZW50cyAoYW5kIHlvdSBoYXZlIGVub3VnaA0KPiBrZXJuZWwg
Y29ubmVjdGlvbiB0byByb3V0ZSBpdCB0byB0aGUgcmlnaHQgcGVvcGxlKS4NCj4gDQo+IFdlIGhh
dmUgMjUgbmV3IGRhdGEgcHJvY2Vzc2luZyBub2RlcyB3aXRoIDMyIGNvcmVzLCAyNTYgR0IgUkFN
IGFuZCAyNQ0KPiBHYi9zIE5JQy4NCj4gVGhleSBydW4gQ2VudE9TIDcgKGJ1dCB0aGlzIGlzIGly
cmVsZXZhbnQsIEkgdGhpbmspLg0KPiANCj4gV2hlbiBlYWNoIG5vZGUgcnVucyAyNCBwYXJhbGxl
bCB3cml0ZSBpbmNlbnRpdmUgKDc1JSB3cml0ZSwgMjUlIHJlYWQpDQo+IHdvcmtsb2Fkcywgd2Ug
c2VlIGEgc3Bpa2Ugb2YNCj4gSU8gZXJyb3JzIG9uIGNsb3NlLiBDbGllbnQgcnVucyBpbnRvIHRp
bWVvdXQgZHVlIHRvIHNsb3cgbmV0d29yayBvcg0KPiBJTyBzdGFydmF0aW9uIG9uIHRoZSBORlMg
c2VydmVycy4NCj4gSXQgc3R1bWJsZXMsIGRpc2Nvbm5lY3RzLCBlc3RhYmxpc2hlcyBhIG5ldyBj
b25uZWN0aW9uIGFuZCBzdHVtYmxlZA0KPiBhZ2Fpbi4uLg0KDQpZb3UgY2FuIGFkanVzdCB0aGUg
cE5GUyB0aW1lb3V0IGJlaGF2aW91ciB1c2luZyB0aGUgJ2RhdGFzZXJ2ZXJfdGltZW8nDQphbmQg
J2RhdGFzZXJ2ZXJfcmV0cmFucycgbW9kdWxlIHBhcmFtZXRlcnMgb24gYm90aCB0aGUgZmlsZXMg
YW5kDQpmbGV4ZmlsZXMgcE5GUyBkcml2ZXIgbW9kdWxlcy4NCg0KPiANCj4gQXMgZGVmYXVsdCB2
YWx1ZXMgZm9yIGRpcnR5IHBhZ2VzIGlzDQo+IA0KPiB2bS5kaXJ0eV9iYWNrZ3JvdW5kX2J5dGVz
ID0gMA0KPiB2bS5kaXJ0eV9iYWNrZ3JvdW5kX3JhdGlvID0gMTANCj4gdm0uZGlydHlfYnl0ZXMg
PSAwDQo+IHZtLmRpcnR5X3JhdGlvID0gMzANCj4gDQo+IHRoZSBmaXJzdCBkYXRhIGdldCBzZW50
IHdoZW4gYXQgbGVhc3QgMjVHQiBvZiBkYXRhIGlzIGFjY3VtdWxhdGVkLg0KPiANCj4gVG8gZ2V0
IHRoZSBmdWxsIGRlcGxveW1lbnQgbW9yZSByZXNwb25zaXZlLCB3ZSBoYXZlIHJlZHVjZWQgZGVm
YXVsdA0KPiBudW1iZXJzIHRvIHNvbWV0aGluZyBtb3JlIHJlYXNvbmFibGU6DQo+IA0KPiB2bS5k
aXJ0eV9iYWNrZ3JvdW5kX3JhdGlvID0gMA0KPiB2bS5kaXJ0eV9yYXRpbyA9IDANCj4gdm0uZGly
dHlfYmFja2dyb3VuZF9ieXRlcyA9IDY3MTA4ODY0DQo+IHZtLmRpcnR5X2J5dGVzID0gNTM2ODcw
OTEyDQo+IA0KPiBJT1csIHdlIGZvcmNlIGNsaWVudCB0byBzdGFydCB0byBzZW5kIGRhdGEgYXMg
c29vbiBhcyA2NE1CIGlzDQo+IHdyaXR0ZW4uIFRoZSBxdWVzdGlvbiBpcyBob3cgZ2V0IHRoaXMN
Cj4gdmFsdWVzIG9wdGltYWwgYW5kIGhvdyBtYWtlIHRoZW0gZmlsZSBzeXN0ZW0vbW91bnQgcG9p
bnQgc3BlY2lmaWMuDQoNClRoZSBtZW1vcnkgbWFuYWdlbWVudCBzeXN0ZW0ga25vd3Mgbm90aGlu
ZyBhYm91dCBtb3VudCBwb2ludHMsIGFuZCB0aGUNCmZpbGVzeXN0ZW1zIGtub3cgbm90aGluZyBh
Ym91dCB0aGUgbWVtb3J5IG1hbmFnZW1lbnQgbGltaXRzLiBUaGF0IGlzIGJ5DQpkZXNpZ24uDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
