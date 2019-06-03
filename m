Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EEB334FD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 18:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfFCQcR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 12:32:17 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:33857
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbfFCQcQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 12:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yJilVYBQNTHq1w9j+2OEUMCFifxHGet+ZcG57h23Hk=;
 b=F1wAl1J7kUFzlknaMXmIvEzaJAq5OuQ5rQcOZ2Kx36IPNnbJDGyH+G3EE26UYNVf6GTOpopdfpWFSSmdNi8/uU5bGPyO4UEIBFAOH6Hm3BEoXToj9gEQMJ8XAeI3kp8kHt/Nqhj1PQ/pYmi9CEBEZqMoLRzQMw3Z3H2+0O53KxM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1177.namprd13.prod.outlook.com (10.168.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.9; Mon, 3 Jun 2019 16:32:13 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Mon, 3 Jun 2019
 16:32:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] Add utilities for resolving nfsd paths and
 stat()ing them
Thread-Topic: [PATCH v3 04/11] Add utilities for resolving nfsd paths and
 stat()ing them
Thread-Index: AQHVFZShzYBylqATtkuw/I5cpJzCpKaFZnuAgASdigCAACSZAA==
Date:   Mon, 3 Jun 2019 16:32:13 +0000
Message-ID: <18c39a0eb8212e1024e1fde849eb75011b2d1e12.camel@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
         <20190528203122.11401-2-trond.myklebust@hammerspace.com>
         <20190528203122.11401-3-trond.myklebust@hammerspace.com>
         <20190528203122.11401-4-trond.myklebust@hammerspace.com>
         <20190528203122.11401-5-trond.myklebust@hammerspace.com>
         <20190531155217.GC1251@fieldses.org>
         <c038bbe5-aef6-a740-4591-3814d02c4126@RedHat.com>
In-Reply-To: <c038bbe5-aef6-a740-4591-3814d02c4126@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9597dfc2-2245-43a2-2444-08d6e841087b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1177;
x-ms-traffictypediagnostic: DM5PR13MB1177:
x-microsoft-antispam-prvs: <DM5PR13MB1177DC7E02EEA871AF301A39B8140@DM5PR13MB1177.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39830400003)(189003)(199004)(5660300002)(478600001)(6116002)(3846002)(76176011)(4326008)(6246003)(2501003)(36756003)(76116006)(53936002)(64756008)(66556008)(66476007)(73956011)(66946007)(14454004)(2906002)(186003)(66446008)(25786009)(53546011)(81156014)(102836004)(6506007)(7736002)(316002)(256004)(6436002)(6512007)(86362001)(99286004)(8676002)(118296001)(11346002)(446003)(229853002)(2616005)(486006)(476003)(66066001)(305945005)(81166006)(14444005)(6486002)(68736007)(71200400001)(26005)(110136005)(8936002)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1177;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zhaD0Y84mJ1h0TckxsPl952pByrzXNpIWfiefU64F7+4/ebwwE/zmUDVIwAsjncQOnW0m7G9RbQ4pPIdR6S2DyR4NL8SlP+qSTUZLMwxToJy6xbOZ46/4VSObc84fYcYX6s0lwnkU0iQcw/Fv1WQpop5fcJ1yG9qcBo/JcTpdz0HNEAKD+yn/4oB3y9Jk3RzRrsvUOHsiuqBrTcqKTeSu2Sg97A+7vWAYE/+sJteQUd/T4N1lUbEQrf2iU7t5nLfA09uhyDJpghX1ZdDCUxhYd+KVzZ+KikjVACLGkVKGTZ1RIChYrjfgMijmLE9TtYZOEzUpBd8Yuo6EHzEcdvZ17AtgYNw4wZndL42VeO2tNZpLqDvcmGWL9c6LOKJtcygWSgmY3bGD1b86KOPScOY3toP/jF/+h40Jekh6NMCdXI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B0263F255E9B54C89ED471AB07670C5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9597dfc2-2245-43a2-2444-08d6e841087b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 16:32:13.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1177
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTAzIGF0IDEwOjIxIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gT24gNS8zMS8xOSAxMTo1MiBBTSwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgTWF5IDI4LCAyMDE5IGF0IDA0OjMxOjE1UE0gLTA0MDAsIFRyb25kIE15a2xlYnVzdCB3
cm90ZToNCj4gPiA+ICtjaGFyICoNCj4gPiA+ICtuZnNkX3BhdGhfc3RyaXBfcm9vdChjaGFyICpw
YXRobmFtZSkNCj4gPiA+ICt7DQo+ID4gPiArCWNvbnN0IGNoYXIgKmRpciA9IG5mc2RfcGF0aF9u
ZnNkX3Jvb3RkaXIoKTsNCj4gPiA+ICsJY2hhciAqcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXQg
PSBzdHJzdHIocGF0aG5hbWUsIGRpcik7DQo+ID4gPiArCWlmICghcmV0IHx8IHJldCAhPSBwYXRo
bmFtZSkNCj4gPiA+ICsJCXJldHVybiBwYXRobmFtZTsNCj4gPiANCj4gPiBTaG91bGRuJ3Qgd2Ug
cmV0dXJuIE5VTEwgb3IgYW4gZXJyb3Igb3Igc29tZXRoaW5nIGhlcmU/ICBJdCBzZWVtcyBhDQo+
ID4gbGl0dGxlIHN0cmFuZ2Ugbm90IHRvIGNhcmUgaWYgdGhlIHBhdGggYmVnYW4gd2l0aCByb290
IG9yIG5vdC4gIEkNCj4gPiBndWVzcw0KPiA+IEkgbmVlZCB0byBsb29rIGF0IHRoZSBjYWxsZXIu
Li4uDQo+IFdlbGwgcGF0aG5hbWUgd2lsbCBuZXZlciBiZSBOVUxMLi4uIEl0IGlzIHJldHVybmlu
ZyB3aGF0IGlzIHBhc3NlZA0KPiBpbiwgDQo+IGJ1dCBpdCBtaWdodCBiZSBuaWNlIHRvIGtub3cg
YWJvdXQgdGhlIG1lbW9yeSBmYWlsdXJlLg0KPiANCg0KRWl0aGVyIHdheSwgSSBmaWd1cmUgd2Ug
YWxzbyB3YW50IHRvIGNhbm9uaWNhbGlzZSAnZGlyJyBiZWZvcmUgd2UgYXBwbHkNCml0LCBqdXN0
IGluIGNhc2UgcGVvcGxlIGhhdmUgYW11c2VkIHRoZW1zZWx2ZXMgYnkgY29tcG9zaW5nIHJvb3Rk
aXINCnZhbHVlcyBvZiB0aGUgZm9ybSAnL2Zvby8uL2Jhci8uLy4uL2Jhci8nLg0KQW5vdGhlciBw
YXRjaCBmb3J0aGNvbWluZyBmb3IgdGhpcy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
