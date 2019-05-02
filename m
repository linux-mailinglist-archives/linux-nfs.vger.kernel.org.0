Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A111871
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEBLtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 07:49:07 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:64704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfEBLtG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 May 2019 07:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpSgq/aeE1D89gCfBFl2AswgCjHUE/jsQCtMepo+3UI=;
 b=pf4dIksYOGfQLt+gG5W+6vi9/4zZ36nYX0UUnNjwnCAPltXbwQxcQkbsLjRfYQi+JB0KQEU3Uh5wtQrCpwOqsuI6Oi3uAvRNXF6Q4GaoT8bKendQJhaXBXETz0Ke5rD35R3iawWf7er+6nbbU7wIuN0aY2aBW6+0dMakFGjz0e4=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2542.namprd13.prod.outlook.com (52.135.95.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.5; Thu, 2 May 2019 11:49:02 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1878.004; Thu, 2 May 2019
 11:49:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Thread-Topic: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Thread-Index: AQHU9eoA+LnbIrF7jEWsGwkuP/UCjKZCBqYAgABeNgCAAA0pAIASr5+AgAABTwCAAqdfAIAAA+oA
Date:   Thu, 2 May 2019 11:49:02 +0000
Message-ID: <aeb95b24e600d8400dc860d88cbd4f79a33766a7.camel@hammerspace.com>
References: <20190418132400.24161-1-smayhew@redhat.com>
         <20190418151312.GB29274@fieldses.org>
         <20190418205024.GB15226@coeurl.usersys.redhat.com>
         <20190418213730.GA1891@fieldses.org>
         <20190430185845.GG15226@coeurl.usersys.redhat.com>
         <5ef90bd5ac79236458ffa04b7eb1d7812431859f.camel@hammerspace.com>
         <20190502113500.GH15226@coeurl.usersys.redhat.com>
In-Reply-To: <20190502113500.GH15226@coeurl.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf874d51-2a3b-4c6f-830d-08d6cef42c1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2542;
x-ms-traffictypediagnostic: SN6PR13MB2542:
x-microsoft-antispam-prvs: <SN6PR13MB2542E610A449A1A64D931CECB8340@SN6PR13MB2542.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(189003)(199004)(81166006)(25786009)(6916009)(6512007)(229853002)(1730700003)(186003)(66476007)(76176011)(118296001)(8676002)(305945005)(4326008)(81156014)(14454004)(508600001)(7736002)(66946007)(73956011)(64756008)(66556008)(99286004)(76116006)(91956017)(3846002)(6116002)(2351001)(66446008)(66066001)(36756003)(8936002)(6246003)(2501003)(68736007)(2906002)(5660300002)(2616005)(54906003)(71200400001)(102836004)(86362001)(71190400001)(6436002)(256004)(5640700003)(26005)(446003)(6486002)(6506007)(53936002)(476003)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2542;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Iff5N9iJ9O3UjL50w6vFiJN5po1YuJdY+WqXwgyO954BJxGKeUI8ZOoAQSsuiy5QAnGom9gmFAtPDd0hplJTu6OZWAXxUnuyXiu9RhE56xi6uUsqh+8NuQCbOUvVwGvSt2xtRaKRXJoTzEuyOgFpjYle2gqRlWQhGfAMrwQx0Ry8ISz60gH6taGwyITBjquvJM6bFIQRfb4eT8fSpOgCYLgkbkR1+TTNO7unmM2rLs08wA15tAlypFh+TWTFIhyeUzH7vt1Qx4o4l2DKyOnl4rt/BT/k2O+vUZ4t5lV5RdnS3tK6a1Qsnyc9Nc1P0azJb4sgEfjX2popz79293ibXBe+FGhQEhADF23PEa20OasWDvMCprLsm304Z5kgU+157NZpQW6OpKBjLRXmsQ/1k0o6MgHgQpS5EVyU8D/eqs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <891D117872415E4A8802615F815AB442@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf874d51-2a3b-4c6f-830d-08d6cef42c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 11:49:02.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2542
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTAyIGF0IDA3OjM1IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIFR1ZSwgMzAgQXByIDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24g
VHVlLCAyMDE5LTA0LTMwIGF0IDE0OjU4IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+ID4g
PiBPbiBUaHUsIDE4IEFwciAyMDE5LCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiANCj4g
PiA+ID4gT24gVGh1LCBBcHIgMTgsIDIwMTkgYXQgMDQ6NTA6MjRQTSAtMDQwMCwgU2NvdHQgTWF5
aGV3IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMTggQXByIDIwMTksIEouIEJydWNlIEZpZWxk
cyB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIFRodSwgQXByIDE4LCAyMDE5IGF0
IDA5OjI0OjAwQU0gLTA0MDAsIFNjb3R0IE1heWhldw0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+ID4gPiA+IFdoaWxlIHRyeWluZyB0byB0cmFjayBkb3duIHNvbWUgaXNzdWVzIGludm9sdmlu
ZyBsYXJnZQ0KPiA+ID4gPiA+ID4gPiBudW1iZXJzIG9mDQo+ID4gPiA+ID4gPiA+IGRlbGVnYXRp
b25zIGJlaW5nIHJlY2FsbGVkL3Jldm9rZWQsIEkgY2F1Z2h0IHRoZSBzZXJ2ZXINCj4gPiA+ID4g
PiA+ID4gc2V0dGluZw0KPiA+ID4gPiA+ID4gPiBTRVE0X1NUQVRVU19DQl9QQVRIX0RPV04gd2hp
bGUgdGhlIGNsaWVudCB3YXMgYWN0aXZlbHkNCj4gPiA+ID4gPiA+ID4gcmVzcG9uZGluZyB0bw0K
PiA+ID4gPiA+ID4gPiBDQl9SRUNBTExzLiAgSXQgdHVybnMgb3V0IHRoYXQgdGhlIGNsaWVudCBo
YWQgYWxyZWFkeQ0KPiA+ID4gPiA+ID4gPiBkb25lIGENCj4gPiA+ID4gPiA+ID4gVEVTVF9TVEFU
RUlEIGFuZCBGUkVFX1NUQVRFSUQgZm9yIGEgZGVsZWdhdGlvbiBiZWluZw0KPiA+ID4gPiA+ID4g
PiByZWNhbGxlZA0KPiA+ID4gPiA+ID4gPiBieSB0aGUNCj4gPiA+ID4gPiA+ID4gdGltZSBpdCBy
ZWNlaXZlZCB0aGUgQ0JfUkVDQUxMLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGF0J3Mg
aW50ZXJlc3RpbmcsIHRoYW5rcyENCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBleGNl
cHRpb24gc2VlbXMgYXdmdWxseSBuYXJyb3csIHRob3VnaC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gSWYgd2UgZ2V0IGJhY2sgYW55IE5GUy1sZXZlbCBlcnJvciBhdCBhbGwsIHRoZW4gSSB0
aGluayB0aGUNCj4gPiA+ID4gPiA+IGNhbGxiYWNrDQo+ID4gPiA+ID4gPiBjaGFubmVsIGlzIHdv
cmtpbmcgKGFtIEkgd3Jvbmc/KQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENvcnJlY3QsIGlmIHRo
ZSBjbGllbnQgcmVwbGllcyB3aXRoIGVpdGhlciBORlM0RVJSX0RFTEFZIG9yDQo+ID4gPiA+ID4g
TkZTNEVSUl9CQURfU1RBVEVJRCwgdGhlIHNlcnZlciB3aWxsIHJldHJ5IDEgdGltZSAoc2VlDQo+
ID4gPiA+ID4gZGxfcmV0cmllcykuDQo+ID4gPiA+ID4gQWZ0ZXIgdGhhdCwgd2UgZmFsbCB0aHJ1
IGFuZCBuZnNkNF9jYl9yZWNhbGxfZG9uZSgpIHJldHVybnMNCj4gPiA+ID4gPiAtMQ0KPiA+ID4g
PiA+IHdoaWNoDQo+ID4gPiA+ID4gY2F1c2VzIHRoZSBTRVE0X1NUQVRVU19DQl9QQVRIX0RPV04g
ZmxhZyB0byBiZSBzZXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBhbmQgdGVsbGluZyB0aGUg
Y2xpZW50IHRvIHNldCB1cCBhIG5ldw0KPiA+ID4gPiA+ID4gb25lIGlzIHByb2JhYmx5IG5vdCBn
b2luZyB0byBoZWxwLiAgVGhlIGJlc3Qgd2UgY2FuIGRvIGlzDQo+ID4gPiA+ID4gPiBwcm9iYWJs
eSBqdXN0DQo+ID4gPiA+ID4gPiBnaXZlIHVwDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhdCdz
IHdoYXQgdGhlIHBhdGNoIGlzIGVzc2VudGlhbGx5IGRvaW5nLiAgT3IgYXJlIHlvdQ0KPiA+ID4g
PiA+IHNheWluZw0KPiA+ID4gPiA+IGRvbid0DQo+ID4gPiA+ID4gZXZlbiBib3RoZXIgd2l0aCB0
aGUgY2hlY2tzIGJ1dCBzdGlsbCByZXR1cm4gMSBzbyB3ZSBkb24ndA0KPiA+ID4gPiA+IHNldA0K
PiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IFNFUTRfU1RBVFVTX0NCX1BBVEhfRE9XTiBmbGFnPw0K
PiA+ID4gPiANCj4gPiA+ID4gUmlnaHQsIEkgZG9uJ3Qgc2VlIGFueSBwb2ludCByZXR1cm5pbmcg
LTEgKHdoaWNoIGVuZHMgdXANCj4gPiA+ID4gc2V0dGluZw0KPiA+ID4gPiBDQl9QQVRIX0RPV04p
IGluIGFueSBjYXNlIHdoZXJlIHdlIGdldCBhbiBuZnMtbGV2ZWwgZXJyb3IuICBJZg0KPiA+ID4g
PiB0aGUNCj4gPiA+ID4gY2xpZW50IGdvdCBzbyBmYXIgYXMgcmV0dXJuaW5nIGFuIGVycm9yLCB0
aGVuIHRoZSBjYWxsYmFjayBwYXRoDQo+ID4gPiA+IGlzDQo+ID4gPiA+IHdvcmtpbmcuDQo+ID4g
PiA+IA0KPiA+ID4gPiBJJ20gbm90IHN1cmUgZXhhY3RseSB3aGF0IGVycm9ycyAqc2hvdWxkKiBy
ZXN1bHQgaW4NCj4gPiA+ID4gQ0JfUEFUSF9ET1dOLA0KPiA+ID4gPiB0aG91Z2guICBFVElNRURP
VVQsIEVOT1RDT05OLCBFSU8/DQo+ID4gPiANCj4gPiA+IEknbSBub3Qgc3VyZSBlaXRoZXIuICBM
b29raW5nIGF0DQo+ID4gPiBjYWxsX3N0YXR1cy9jYWxsX3RpbWVvdXQvcnBjX2NoZWNrX3RpbWVv
dXQsIGl0IGxvb2tzIHRvIG1lIGxpa2UNCj4gPiA+IEVOT1RDT05ODQo+ID4gPiB3aWxsIGJlIHRy
YW5zbGF0ZWQgdG8gRVRJTUVET1VUIGJlY2F1c2UgbmZzZDRfcnVuX2NiX3dvcmsgc2V0cw0KPiA+
ID4gdGhlIA0KPiA+ID4gUlBDX1RBU0tfU09GVENPTk4gZmxhZyBpbiB0aGUgY2FsbCB0byBycGNf
Y2FsbF9hc3luYy4NCj4gPiA+IA0KPiA+ID4gSXQgbG9va3MgbGlrZSBjYWxsX3N0YXR1cyBjYW4g
cmV0dXJuIEVIT1NURE9XTiwgRU5FVERPV04sDQo+ID4gPiBFSE9TVFVOUkVBQ0gsDQo+ID4gPiBF
TkVUVU5SRUFDSCwgYW5kIEVQRVJNLi4uIHNob3VsZCB0aG9zZSBiZSBoYW5kbGVkIGFzIHdlbGw/
DQo+ID4gDQo+ID4gVGhvc2UgZXJyb3JzIHNob3VsZCBuZXZlciBiZSBwYXNzZWQgYmFjayB0byBh
cHBsaWNhdGlvbnMuDQo+IA0KPiBJJ20gY29uZnVzZWQuICBJZiBjYWxsX3N0YXR1cyBwYXNzZXMg
YW55IG9mIHRob3NlIGVycm9ycyB0byBycGNfZXhpdCwNCj4gdGhlbiBJJ2xsIHNlZSB0aGVtIGlu
IHJwY19jYWxsX2RvbmUvbmZzZDRfY2JfZG9uZSwgd29uJ3QgST8NCj4gDQoNCklmIHlvdSBldmVy
IHNlZSB0aGVtIGluIHJwY19jYWxsX2RvbmUvbmZzZDRfY2JfZG9uZSwgdGhlbiBpdCB3aWxsIGJl
DQpkdWUgdG8gYW4gUlBDIGJ1ZyB3aGljaCB3aWxsIG5lZWQgdG8gYmUgZml4ZWQuDQoNCmNhbGxf
c3RhdHVzKCkgc2hvdWxkIGJlIGhhbmRsaW5nIHRob3NlIGVycm9ycyBieSByZXRyeWluZywgYW5k
IGlmIGl0DQpydW5zIG91dCBvZiByZXRyeSBhdHRlbXB0cywgdGhlbiBpdCBzaG91bGQgYmUgc2V0
dGluZyBlaXRoZXIgYW4gRUlPDQplcnJvciBvciBhbiBFVElNRURPVVQgZXJyb3IsIGRlcGVuZGlu
ZyBvbiB3aGljaCBycGNfdGFzayBmbGFncyBoYXZlDQpiZWVuIHNwZWNpZmllZC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
