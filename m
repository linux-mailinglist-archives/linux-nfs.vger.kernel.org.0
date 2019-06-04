Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F634AFF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfFDOy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 10:54:26 -0400
Received: from mail-eopbgr800113.outbound.protection.outlook.com ([40.107.80.113]:35840
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727586AbfFDOy0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 10:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5LgD23HEQBPRf6H2cEfoKG9rWQEdPOliSYM2iohLRg=;
 b=gbN+sQjxuMXYV6tOijuPCFwY1hKcW9vi73ArnD/SOjOU1pxn0kg5RcAta4edDs3KczbHTEhWxq2oXgM/X+pdPApvAdp3J9qTxxPv/f+svoBIarbAm+prqajrSknlVWwB4dlKSs4OYFCnlD3v9PTQE0Vr3heBv4LHzMtDox5Ac4s=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1116.namprd13.prod.outlook.com (10.168.116.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 14:53:42 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Tue, 4 Jun 2019
 14:53:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: client skips revalidation if holding a delegation
Thread-Topic: client skips revalidation if holding a delegation
Thread-Index: AQHVGtLKBUNk28aCck+RoJHGu9wZpaaLdE6AgAAUoACAAAwCgA==
Date:   Tue, 4 Jun 2019 14:53:42 +0000
Message-ID: <a595b6962b2e083fef8ad2d3534e1d0964995560.camel@hammerspace.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
         <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
         <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
In-Reply-To: <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd48cbd-e2b1-4345-cdd0-08d6e8fc7011
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1116;
x-ms-traffictypediagnostic: DM5PR13MB1116:
x-microsoft-antispam-prvs: <DM5PR13MB1116D0CC77A2930A51D552F6B8150@DM5PR13MB1116.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(346002)(136003)(376002)(199004)(189003)(6486002)(4326008)(6512007)(5640700003)(2906002)(478600001)(118296001)(305945005)(6436002)(66556008)(102836004)(7736002)(14454004)(8936002)(66066001)(76116006)(6246003)(66446008)(64756008)(66476007)(81166006)(8676002)(316002)(1730700003)(81156014)(73956011)(66946007)(54906003)(53546011)(186003)(6506007)(2351001)(229853002)(76176011)(26005)(99286004)(36756003)(6916009)(14444005)(2616005)(11346002)(446003)(25786009)(486006)(6116002)(3846002)(476003)(71190400001)(71200400001)(68736007)(53936002)(86362001)(256004)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1116;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SMTFKqmN80+PXXpAvjNlVepuuBQFeLxCVxvvjGkxi1sIGYSF/0uZdNZ6VfEyAu5F5JhhwRQ/X65fceqAs1jEyaHoisfc8MAg11J51SOaeDxID253lnwllVY41XjSJV//UFqY6D+F+1cSwrLcLjOTgZr7TJaGJ/X1aoAhHr7FFcnq3yCBJEEPx0xI1PBCCaWewp9ZcPiBmOfdgH1w9CmgtFxP0/SCJMaGrAGz6RNFlLz1eRy+LBd7+62Sh1I2m6ahODG+PI/lRj+xH7tqgQ+35JqvjD3Ey497jFw8OOYFVfP6+gM+8mtb4kcTBsWssrfI+rUPWGMuR8Nw4Fwg2K5fN7snnDpkeCEG7t6AKmRkLNRolqF5l6kTIu3jw5X7P/9S0LRBSwUoZsCcHARv3PuMGQ2M8n+81/eiA/ZX/45TTgY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F187DDB2AF34AC4FA0C99A5C9424152E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd48cbd-e2b1-4345-cdd0-08d6e8fc7011
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 14:53:42.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1116
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDEwOjEwIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA0IEp1biAyMDE5LCBhdCA4OjU2LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+
IA0KPiA+IE9uIFR1ZSwgMjAxOS0wNi0wNCBhdCAwODo0MSAtMDQwMCwgQmVuamFtaW4gQ29kZGlu
Z3RvbiB3cm90ZToNCj4gPiA+IEhleSBsaW51eC1uZnMsIGFuZCBlc3BlY2lhbGx5IG1haW50YWlu
ZXJzLA0KPiA+ID4gDQo+ID4gPiBJJ20gc3RpbGwgaW50ZXJlc3RlZCBpbiB3b3JraW5nIG9uIGEg
cHJvYmxlbSByYWlzZWQgYSBjb3VwbGUNCj4gPiA+IHdlZWtzDQo+ID4gPiBhZ28sIGJ1dA0KPiA+
ID4gY29uZnVzaW9uIG11ZGRsZWQgdGhhdCBkaXNjdXNzaW9uIGFuZCBpdCBkaWVkOg0KPiA+ID4g
DQo+ID4gPiBJZiB0aGUgY2xpZW50IGhvbGRzIGEgcmVhZCBkZWxlZ2F0aW9uLCBpdCB3aWxsIHNr
aXAgcmV2YWxpZGF0aW9uDQo+ID4gPiBvZiBhDQo+ID4gPiBkZW50cnkNCj4gPiA+IGluIGxvb2t1
cC4gIElmIHRoZSBmaWxlIHdhcyBtb3ZlZCBvbiB0aGUgc2VydmVyLCB0aGUgY2xpZW50IGNhbg0K
PiA+ID4gZW5kDQo+ID4gPiB1cCB3aXRoDQo+ID4gPiB0d28gcG9zaXRpdmUgZGVudHJpZXMgaW4g
Y2FjaGUgZm9yIHRoZSBzYW1lIGlub2RlLCBhbmQgdGhlIGRlbnRyeQ0KPiA+ID4gdGhhdA0KPiA+
ID4gZG9lc24ndCBleGlzdCBvbiB0aGUgc2VydmVyIHdpbGwgbmV2ZXIgdGltZSBvdXQgb2YgdGhl
IGNhY2hlLg0KPiA+ID4gDQo+ID4gPiBUaGUgY2xpZW50IGNhbiBkZXRlY3QgdGhpcyBoYXBwZW5p
bmcgYmVjYXVzZSB0aGUgZGlyZWN0b3J5IG9mIHRoZQ0KPiA+ID4gZGVudHJ5DQo+ID4gPiB0aGF0
IHNob3VsZCBiZSByZXZhbGlkYXRlZCB1cGRhdGVzIGl0J3MgY2hhbmdlDQo+ID4gPiBhdHRyaWJ1
dGUuICBTa2lwcGluZw0KPiA+ID4gcmV2YWxpZGF0aW9uIGlzIGFuIG9wdGltaXphdGlvbiBpbiB0
aGUgY2FzZSB3ZSBob2xkIGEgZGVsZWdhdGlvbiwNCj4gPiA+IGJ1dA0KPiA+ID4gdGhpcw0KPiA+
ID4gb3B0aW1pemF0aW9uIHNob3VsZCBvbmx5IGJlIHVzZWQgd2hlbiB0aGUgZGVsZWdhdGlvbiB3
YXMgb2J0YWluZWQNCj4gPiA+IHZpYQ0KPiA+ID4gYQ0KPiA+ID4gbG9va3VwIG9mIHRoZSBkZW50
cnkgd2UgYXJlIGN1cnJlbnRseSByZXZhbGlkYXRpbmcuDQo+ID4gPiANCj4gPiA+IEtlZXBpbmcg
dGhlIG9wdGltaXphdGlvbiBtaWdodCBiZSBkb25lIGJ5IHR5aW5nIHRoZSBkZWxlZ2F0aW9uIHRv
DQo+ID4gPiB0aGUNCj4gPiA+IGRlbnRyeS4gIExhY2tpbmcgc29tZSAoZWFzeT8pIHdheSB0byBk
byB0aGF0IGN1cnJlbnRseSwgaXQgc2VlbXMNCj4gPiA+IHNpbXBsZXIgdG8NCj4gPiA+IHJlbW92
ZSB0aGUgb3B0aW1pemF0aW9uIGFsdG9nZXRoZXIsIGFuZCBJIHdpbGwgc2VuZCBhIHBhdGNoIHRv
DQo+ID4gPiByZW1vdmUNCj4gPiA+IGl0Lg0KPiA+IA0KPiA+IEEgZGVsZWdhdGlvbiBub3JtYWxs
eSBhcHBsaWVzIHRvIHRoZSBlbnRpcmUgaW5vZGUuIEl0IGNvdmVycyBfYWxsXw0KPiA+IGRlbnRy
aWVzIHRoYXQgcG9pbnQgdG8gdGhhdCBpbm9kZSB0b28gYmVjYXVzZSBjcmVhdGUsIHJlbmFtZSBh
bmQNCj4gPiB1bmxpbmsNCj4gPiBhcmUgYWx3YXlzIGF0b21pY2FsbHkgYWNjb21wYW5pZWQgYnkg
YW4gaW5vZGUgY2hhbmdlIGF0dHJpYnV0ZS4NCj4gDQo+IEl0IHNob3VsZCBjb3ZlciBhbGwgZGVu
dHJpZXMgdGhhdCBwb2ludCB0byB0aGF0IGlub2RlIGF0IHRoZSB0aW1lIHRoZQ0KPiBkZWxlZ2F0
aW9uIHdhcyBoYW5kZWQgb3V0LiAgU2hvdWxkbid0IGRlbnRyaWVzIGNhY2hlZCBfYmVmb3JlXyB0
aGUNCj4gZGVsZWdhdGlvbiBiZSBpbnZhbGlkYXRlZD8gIFRoZSBjbGllbnQgZG9lc24ndCBjdXJy
ZW50bHkgY2FyZSBhYm91dA0KPiB0aGUNCj4gb3JkZXIgb2YgZGVudHJpZXMgY2FjaGVkIHdpdGgg
cmVzcGVjdCB0byBkZWxlZ2F0aW9ucy4NCj4gDQo+ID4gSU9XOiBUaGUgcHJvcG9zZWQgcmVzdHJp
Y3Rpb24gaXMgYm90aCB1bm5lY2Vzc2FyeSBhbmQgaW5jb3JyZWN0Lg0KPiANCj4gQnV0IHRoZW4g
SSB0aGluazogbmVlZCB0byBzdG9yZSB0aGF0IGNoYW5nZSBhdHRyaWJ1dGUgb24gdGhlIGRlbnRy
eQ0KPiBpbnN0ZWFkDQo+IG9mIHdoYXQgd2UgY3VycmVudGx5IHVzZSAtIGEgY2xpZW50LW9ubHkg
bW9ub3RvbmljIGNvdW50ZXIuICBUaGVuLCB3ZQ0KPiBjb3VsZA0KPiBjb21wYXJlIHRoZSBkZWxl
Z2F0aW9uJ3MgY2hhbmdlIGF0dHIgdG8gdGhlIGRlbnRyeSdzLg0KPiANCj4gQnV0IHRoYXQgYXNz
dW1lcyB0aGV5IGFyZSBib3RoIGdsb2JhbGx5IHJlbGF0ZWQgLS0gdGhhdCBhIGRpcmVjdG9yeSdz
DQo+IGNoYW5nZV9hdHRyIG9uIGxvb2t1cCByZWxhdGVzIHRvIGFuIGlub2RlJ3MgY2hhbmdlIGF0
dHJpYnV0ZS4gIEkNCj4gZG9uJ3Qgc2VlDQo+IHRoYXQgYW55d2hlcmUgKEknbSBsb29raW5nIGlu
IDc1MzApLi4NCj4gDQoNCk9LLiBOb3cgSSB0aGluayBJIHNlZSB3aGF0IHlvdSBhcmUgc2F5aW5n
LiBUaGlzIHdvdWxkIHRoZSBjYXNlIHRoYXQgaXMNCm9mIGludGVyZXN0Og0KDQoqIEEgZGlyZWN0
b3J5IGNvbnRhaW5zIGEgZmlsZSAiZm9vIiwgd2hpY2ggaGFzIGEgaGFyZGxpbmsgImJhciIuIE91
cg0KY2xpZW50IGhhcyBib3RoIGxpbmsgbmFtZXMgY2FjaGVkIGR1ZSB0byBhIHByZXZpb3VzIHNl
dCBvZiBsb29rdXBzLg0KKiBTb21lIG90aGVyIGNsaWVudCBjaGFuZ2VzIHRoZSBuYW1lIG9mICJi
YXIiIHRvICJiYXJiYXIiIG9uIHRoZQ0Kc2VydmVyLg0KKiBPdXIgY2xpZW50IHRoZW4gb3BlbnMg
ImZvbyIgYW5kIGdldHMgYSBkZWxlZ2F0aW9uLg0KKiBPdXIgY2xpZW50IGlzIHRoZW4gYXNrZWQg
dG8gb3BlbiAiYmFyIiwgYW5kIHN1Y2NlZWRzLCBmYWlsaW5nIHRvDQpyZWNvZ25pc2UgdGhhdCBp
dCBoYXMgYmVlbiByZW5hbWVkIHRvICJiYXJiYXIiLg0KDQpJcyB0aGF0IHdoYXQgeW91IG1lYW4/
IFRoYXQgbG9va3MgbGlrZSBpdCBtaWdodCBoYXBwZW4gd2l0aCB0aGUgY3VycmVudA0KY29kZSwg
YW5kIHdvdWxkIGluZGVlZCBiZSBhIGJ1Zy4NCg0KQWN0dWFsbHksIGluIHRoZSBORlN2NC4xIG9w
ZW4tYnktZmlsZWhhbmRsZSBjYXNlLCB3ZSBtaWdodCBldmVuIHNlZSBhDQpidWcgd2hlbiAiZm9v
IiBpcyByZW5hbWVkIG9uIHRoZSBzZXJ2ZXIgdG9vLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
