Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694BA34B12
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfFDO4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 10:56:54 -0400
Received: from mail-eopbgr770112.outbound.protection.outlook.com ([40.107.77.112]:28567
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbfFDO4y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 10:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6btThLJv1OziVy/F9BX+iKEyT0RMGFi7d2DmcY2ufE=;
 b=OXs3FYGv6yWjKlMjQzqi5aLhB58xWN9uECRVJwAQadt1pZL+gqTML0ot86mX7kQHTS0+8ZvAKu2KTV2ZiIhFHhCpYphl1PwEESnqFXE3GX1/0iNu04gCh7zLFsMxziBCh5vdy6oLNrfpsZO6K4MOaV8mPAHfgFvP0TULkPftua4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1850.namprd13.prod.outlook.com (10.171.155.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.9; Tue, 4 Jun 2019 14:56:51 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Tue, 4 Jun 2019
 14:56:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
Thread-Topic: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
Thread-Index: AQHVEaQVt0VVxeWsEEWfgDZT3xjJf6aEPOOAgAALcQCAAAO6AIAA+TWAgAUS1gCAAAC5gIABTDuAgAADIgA=
Date:   Tue, 4 Jun 2019 14:56:51 +0000
Message-ID: <7e31982c7194ea8b2427837d52df708fb1c1ce40.camel@hammerspace.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
         <20190523201351.12232-3-dwysocha@redhat.com>
         <20190530213857.GA24802@fieldses.org>
         <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
         <20190530223314.GA25368@fieldses.org>
         <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
         <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
         <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
         <20190604144535.GA19422@fieldses.org>
In-Reply-To: <20190604144535.GA19422@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a4abb7-0067-4697-8455-08d6e8fce082
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1850;
x-ms-traffictypediagnostic: DM5PR13MB1850:
x-microsoft-antispam-prvs: <DM5PR13MB1850723C0C5FC5672354A3BFB8150@DM5PR13MB1850.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(136003)(396003)(346002)(366004)(54094003)(199004)(189003)(76116006)(8936002)(73956011)(66946007)(3846002)(53936002)(478600001)(76176011)(81166006)(6116002)(11346002)(446003)(54906003)(476003)(102836004)(7736002)(6512007)(2906002)(118296001)(305945005)(99286004)(2616005)(110136005)(6246003)(86362001)(4326008)(53546011)(8676002)(66446008)(64756008)(66556008)(66476007)(25786009)(6506007)(36756003)(6486002)(186003)(81156014)(486006)(229853002)(66066001)(26005)(2501003)(6436002)(316002)(5660300002)(71200400001)(71190400001)(68736007)(14454004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1850;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qDFuuuKSglprK4JaHs2oJMjfeRc64AW3NhF0LFlU0tDpD+UcFVcpUYZu/EW9EWhcqTbkvvDBYUUzfrb/+AiOCGKGJl7QxGiHjeAzSFa4WFl71N//YOg0WtJ7W+FwE/dyvAon9o5HJ2BZ6Eor808cTQDVYMSDuT+c97jKUzTvoUVKQKpzCovGxcaLU5iOzgm85/RsrePwm/2khP5DwXyTXWVJ7Zv8KB9p7oTh3OF47+DEcEa86qtfBCJqA1kAbY3ziW85xeGl1Lj+ouVSjKmZwKhcn1XPSRRDZAwGdUX2/cR4/oJz74TpC+j+fjoNXm0z/+ajRWpTaKSBtKa8FUrV5OBH595PybgOTyPzLAen5OjH7zB8i0wqgdGdC8VQed9K8xda8UGqMX3jvImy5CxetYW0gHnnxh8CCplrnwKST0E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D58BE673869794D861B9AC5B28C65FC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a4abb7-0067-4697-8455-08d6e8fce082
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 14:56:51.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1850
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDEwOjQ1IC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIE1vbiwgSnVuIDAzLCAyMDE5IGF0IDAyOjU2OjI5UE0gLTA0MDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+ID4gT24gSnVuIDMsIDIwMTksIGF0IDI6NTMgUE0sIERhdmUgV3lzb2NoYW5za2kg
PGR3eXNvY2hhQHJlZGhhdC5jb20NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMTkt
MDUtMzEgYXQgMDk6MjUgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1h
eSAzMCwgMjAxOSwgYXQgNjozMyBQTSwgQnJ1Y2UgRmllbGRzIDwNCj4gPiA+ID4gPiBiZmllbGRz
QGZpZWxkc2VzLm9yZz4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIE1heSAz
MCwgMjAxOSBhdCAwNjoxOTo1NFBNIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+ID4g
PiA+IFdlIG5vdyBoYXZlIHRyYWNlIHBvaW50cyB0aGF0IGNhbiBkbyB0aGF0IHRvby4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBZb3UgbWVhbiwgdGhhdCBjYW4gcmVwb3J0IGV2ZXJ5IGVycm9yIChh
bmQgaXRzIHZhbHVlKT8NCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgdGhlIG5mc194ZHJfc3RhdHVz
IHRyYWNlIHBvaW50IHJlcG9ydHMgdGhlIGVycm9yIGJ5IHZhbHVlDQo+ID4gPiA+IGFuZA0KPiA+
ID4gPiBzeW1ib2xpYyBuYW1lLg0KPiA+ID4gDQo+ID4gPiBUaGUgdHJhY2Vwb2ludCBpcyB2ZXJ5
IHVzZWZ1bCBJIGFncmVlLiAgSSBkb24ndCB0aGluayBpdCB3aWxsDQo+ID4gPiBzaG93Og0KPiA+
ID4gYSkgdGhlIG1vdW50DQo+ID4gPiBiKSB0aGUgb3Bjb2RlDQo+ID4gPiANCj4gPiA+IE9yIGFt
IEkgbWlzdGFrZW4gYW5kIHRoZXJlJ3MgYSB3YXkgdG8gZ2V0IHRob3NlIHdpdGggYSBmaWx0ZXIg
b3INCj4gPiA+IGFub3RoZXIgdHJhY2Vwb2ludD8NCj4gPiANCj4gPiBUaGUgb3Bjb2RlIGNhbiBi
ZSBleHBvc2VkIGJ5IGFub3RoZXIgdHJhY2UgcG9pbnQsIGJ1dCB0aGUgbGluaw0KPiA+IGJldHdl
ZW4NCj4gPiB0aGUgdHdvIHRyYWNlIHBvaW50cyBpcyB0ZW51b3VzIGFuZCBjb3VsZCBiZSBpbXBy
b3ZlZC4NCj4gPiANCj4gPiBJIGRvbid0IGJlbGlldmUgYW55IG9mIHRoZSBORlMgdHJhY2UgcG9p
bnRzIGV4cG9zZSB0aGUgbW91bnQuIE15DQo+ID4gdGVzdGluZw0KPiA+IGlzIGxhcmdlbHkgb24g
YSBzaW5nbGUgbW91bnQgc28gbXkgaW1hZ2luYXRpb24gc3RvcHBlZCB0aGVyZS4NCj4gDQo+IER1
bWIgcXVlc3Rpb246IGlzIGl0IHBvc3NpYmxlIHRvIGFkZCBtb3JlIGZpZWxkcyB0byB0cmFjZXBv
aW50cw0KPiB3aXRob3V0DQo+IGJyZWFraW5nIHNvbWUga2luZCBvZiBiYWNrd2FyZHMgY29tcGF0
aWJpbGl0eT8NCg0KVHJhY2Vwb2ludHMgYXJlIG5vdCB0byBiZSBjb25zaWRlcmVkIGFuIEFQSS4N
Cg0KPiBJIHdvbmRlciBpZiBhZGRpbmcsIHNheSwgYW4geGlkIGFuZCBhbiB4cHJ0IHBvaW50ZXIg
dG8gdHJhY2Vwb2ludHMNCj4gd2hlbg0KPiBhdmFpbGFibGUgd291bGQgaGVscCB3aXRoIHRoaXMg
a2luZCBvZiB0aGluZy4NCj4gDQo+IEluIGFueSBjYXNlLCBJIHRoaW5rIERhdmUncyBzdGF0cyB3
aWxsIHN0aWxsIGJlIGhhbmR5IGlmIG9ubHkgYmVjYXVzZQ0KPiB0aGV5J3JlIG9uIGFsbCB0aGUg
dGltZS4NCg0KR2l2ZW4gdGhhdCBzb21lb25lIHdobyBzaGFsbCByZW1haW4gYW5vbnltb3VzIGFk
ZGVkIHRoZSBzdHJ1Y3QgcnBjX3Jxc3QNCnRvIHRoZSBzdHJ1Y3QgeGRyX3N0cmVhbSBmb3IgImRl
YnVnZ2luZyBwdXJwb3NlcyIsIGl0IHNob3VsZCBiZSBxdWl0ZQ0KcG9zc2libGUgdG8gYWRkIGJv
dGggdGhlIFhJRCBhbmQgdGhlIHhwcnQgaW4gdGhpcyBjYXNlLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
