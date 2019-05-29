Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2715F2E4AB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2SpQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 14:45:16 -0400
Received: from mail-eopbgr690127.outbound.protection.outlook.com ([40.107.69.127]:47318
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfE2SpP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 14:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU90DMXNGF3jJ0oEiIGbLNSzzNKq8tSwp0GNNze43Co=;
 b=LmIhcZC2vhewvbl85f1Q5fkH+6f13Ian7Obi8j8wiXQSIsV/i2EUTGrrEWayk9lO62aXNxV0phiJDMrG3yrv1fgs5YTzUwOxxXJ5csRB/lMTJ8YEPGHWeKNH4vMNla/uiw34sRQMM6heU/xAppOyURzhJlyGZNHhAH7N7rRCFcQ=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1452.namprd13.prod.outlook.com (10.175.108.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Wed, 29 May 2019 18:45:12 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 18:45:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
Thread-Topic: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
Thread-Index: AQHVAaKLteyD+epX90KQZ+FxPa7AuqaBH6AAgAF4hACAAAHegA==
Date:   Wed, 29 May 2019 18:45:12 +0000
Message-ID: <7e6041b400b08d4dc42a9b5fe0f665917f12f65c.camel@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
         <20190503111841.4391-2-trond.myklebust@hammerspace.com>
         <20190503111841.4391-3-trond.myklebust@hammerspace.com>
         <20190503111841.4391-4-trond.myklebust@hammerspace.com>
         <20190503111841.4391-5-trond.myklebust@hammerspace.com>
         <20190503111841.4391-6-trond.myklebust@hammerspace.com>
         <CAN-5tyGDV1O=kfay2iu0g6cFkDRfFQrBTn-wfQowyGrAMY5fBw@mail.gmail.com>
         <CAN-5tyFPxiJ8G581ENZ+T+6y3WLx_5aVcrWDaFZRERTzHu_iZw@mail.gmail.com>
In-Reply-To: <CAN-5tyFPxiJ8G581ENZ+T+6y3WLx_5aVcrWDaFZRERTzHu_iZw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53970682-4d86-4855-b3cc-08d6e465c872
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1452;
x-ms-traffictypediagnostic: DM5PR13MB1452:
x-microsoft-antispam-prvs: <DM5PR13MB1452BFDF26850BBCC3775467B81F0@DM5PR13MB1452.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(199004)(71190400001)(6506007)(118296001)(102836004)(71200400001)(25786009)(54906003)(305945005)(76176011)(2171002)(76116006)(64756008)(256004)(14444005)(53936002)(4326008)(66446008)(66556008)(66476007)(73956011)(5660300002)(6246003)(66946007)(66066001)(6916009)(2351001)(53546011)(7736002)(316002)(229853002)(6116002)(3846002)(2906002)(2501003)(6486002)(478600001)(14454004)(26005)(6512007)(186003)(2616005)(6436002)(68736007)(36756003)(11346002)(81166006)(476003)(446003)(8936002)(81156014)(1730700003)(486006)(99286004)(5640700003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1452;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O3Ez/ANmLhE3HjGUqQ9wJaElbwJf/8ttkNbMH0Qov+GIh8lcDfvrdymwsxO8kVfNU/m8wVLeuLBbfrndTtuSGoEYQ1Z0lzpuXQ6Hai/THkbsl0tLwVnjtA6wFdpNXdpQ99RGHHV73PXwweBPi5R1fcBaOE3LnBb2MqxkkqhLPGISMLIlmC43O7snefUVQb48a+iWaNY0+KmQQFzMLC1RQGthTrE5w2ahrGi+vst5zZOA6FGPcIoqF5WlAeritdlS5LEUHIa3eYk6NEaz9AR22BpA0vUAbzcKcZoj5macr/dNjFAGfpfH4p5tqQKpOfHieG+h8XBKZqd/hpUtskC/w/utgkinb2ge9jNabLgyEk5d1LDryacxux6zDxC6ffOFH6e0+O16efP1ddcgGizE0sf9JxGe/3WPbeel155SC8Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <623205A99727E94B8BAD213A672967A7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53970682-4d86-4855-b3cc-08d6e465c872
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 18:45:12.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1452
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDE0OjM4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBNYXkgMjgsIDIwMTkgYXQgNDoxMCBQTSBPbGdhIEtvcm5pZXZza2FpYSA8
YWdsb0B1bWljaC5lZHU+DQo+IHdyb3RlOg0KPiA+IE9uIEZyaSwgTWF5IDMsIDIwMTkgYXQgNzoy
NCBBTSBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAZ21haWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+
ID4gQWxsb3cgbW9yZSB0aW1lIGZvciBzb2Z0aXJxZA0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBuZXQvc3VucnBjL3NjaGVkLmMgfCAyICstDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL3NjaGVkLmMgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+
IGluZGV4IGM3ZTgxMzM2NjIwYy4uNmIzN2M5YTRiNDhmIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0
L3N1bnJwYy9zY2hlZC5jDQo+ID4gPiArKysgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+IEBA
IC0xMjUzLDcgKzEyNTMsNyBAQCBzdGF0aWMgaW50IHJwY2lvZF9zdGFydCh2b2lkKQ0KPiA+ID4g
ICAgICAgICAgICAgICAgIGdvdG8gb3V0X2ZhaWxlZDsNCj4gPiA+ICAgICAgICAgcnBjaW9kX3dv
cmtxdWV1ZSA9IHdxOw0KPiA+ID4gICAgICAgICAvKiBOb3RlOiBoaWdocHJpIGJlY2F1c2UgbmV0
d29yayByZWNlaXZlIGlzIGxhdGVuY3kNCj4gPiA+IHNlbnNpdGl2ZSAqLw0KPiA+ID4gLSAgICAg
ICB3cSA9IGFsbG9jX3dvcmtxdWV1ZSgieHBydGlvZCIsDQo+ID4gPiBXUV9VTkJPVU5EfFdRX01F
TV9SRUNMQUlNfFdRX0hJR0hQUkksIDApOw0KPiA+IA0KPiA+IEkgdGhvdWdodCB3ZSBuZWVkZWQg
VU5CT1VORCBvdGhlcndpc2UgdGhlcmUgd2FzIHBlcmZvcm1hbmNlDQo+ID4gZGVncmFkYXRpb24g
Zm9yIHJlYWQgSU8uDQo+IA0KPiBJIHJlbW92ZSBteSBvYmplY3Rpb24gYXMgdGhpcyBpcyBmb3Ig
dGhlIHhwcnRpb2QgcXVldWUgYW5kIG5vdCB0aGUNCj4gcnBjaW9kIHF1ZXVlLiBUaGUgbGF0dGVy
IGlzIHRoZSBvbmUgd2hlbiByZW1vdmluZyBXUV9VTkJPVU5EIHdvdWxkDQo+IG9ubHkgdXNlIGEg
c2luZ2xlIHJwY2lvZCB0aHJlYWQgZm9yIGRvaW5nIGFsbCB0aGUgY3J5cHRvIGFuZCB0aHVzDQo+
IGltcGFjdCBwZXJmb3JtYW5jZS4NCj4gDQo+ID4gPiArICAgICAgIHdxID0gYWxsb2Nfd29ya3F1
ZXVlKCJ4cHJ0aW9kIiwgV1FfTUVNX1JFQ0xBSU0gfA0KPiA+ID4gV1FfVU5CT1VORCwgMCk7DQo+
ID4gPiAgICAgICAgIGlmICghd3EpDQo+ID4gPiAgICAgICAgICAgICAgICAgZ290byBmcmVlX3Jw
Y2lvZDsNCj4gPiA+ICAgICAgICAgeHBydGlvZF93b3JrcXVldWUgPSB3cTsNCj4gPiA+IC0tDQo+
ID4gPiAyLjIxLjANCj4gPiA+IA0KDQpJdCB3YXMgb25seSByZW1vdmluZyB0aGUgV1FfSElHSFBS
SSBmbGFnLCBub3QgdGhlIFdRX1VOQk9VTkQuIEhvd2V2ZXINCnRoZSBwb2ludCBpdCBtb290LCBh
cyBJJ20gZHJvcHBpbmcgdGhlIHBhdGNoLg0KDQpDaGVlcnMNCiBUcm9uZA0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
