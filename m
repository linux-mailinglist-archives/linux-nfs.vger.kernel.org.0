Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E171471CD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAWTdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 14:33:37 -0500
Received: from mail-bn8nam12on2128.outbound.protection.outlook.com ([40.107.237.128]:11969
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbgAWTdh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 14:33:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfqjUOwx/u9Bw/aTyNGPuabS6CZiukjTqnvBjcDz7czda3OzHr5CITSZjo5Snk6rOGeqzux5grzcOvPKAvFUO92M9Ip5vb3z6nCS4OYYa0FG9gnNJPWtyGF3UNkWSbndWa6fa+4vjhwehtld3KAioLDcP5mPHpdKFNiBuRL3jE0nj7gRhxEoMjnJRkS68ILBtRmP9fm5DwKcaHR6yJ2ZtreU8+964TFlec4MKRkvbkxNh3Gt47woPjOCJhygPqy2/tniD6rKE9rJtepMjUtk2YQXO2AEyYVGVFmT8CykW5yT8i0fXpKMQSQptwRqhNJy6qppdeWx2x5MIhR1MolsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDLoLbWmdwDdW+/XbN5o4vZGZTT652tIC1kGfv42C0s=;
 b=Bbs7hbR9DuSPK42ctvixjjHT11qsf5JK5WdoP7gemufW1fz7jbXw/1c+jnIi0MUeeIBcSgteHnV6mjYoVhY4ABhl8YrSBlRn/uStcpArengpS5+nbCAi1UIh/6u1/fX2B+zfl4zeRK5PcnlL1J2y/Xy/U43aqlsbrRCeH1S8MGD3KgoBJnlywx6pAa/qkqSAb+RWmH0gbJC8NmFKPHo+5sdFb8B9QF9hc8N+dNX6r8rt2Jvb7Xx3XMW6o+QMSGQplfKn32LgaOpCY1aieXQOFHAGUkxiz675WfK307A0zXZPxiy8GaMterHDQ0Tbe95xIx5+QLdIFwnYGLIDJsxLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDLoLbWmdwDdW+/XbN5o4vZGZTT652tIC1kGfv42C0s=;
 b=OMFGCymApmwQLhBN8L50+Sj+lkTtmnWrzpA5dQToA2Vk4g4Cx1VxDLrC4wkNjg0+443Hc6pU/6BCbGVXDIrtYk0DjZk1smgbWT5k4GFZacWAeHRmuK9fDBI+uungWeJT6/7c2xkkPZWYiQ2hVrPqa2ko9OYwRQ8eUxB1mvbi+VI=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1995.namprd13.prod.outlook.com (10.174.184.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.17; Thu, 23 Jan 2020 19:33:32 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 19:33:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Topic: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Index: AdXGbKgtqm1QJU8yQtKfQBn7K7s7ZQG5DpoAAAKE7AAA9QWygAA9O98A
Date:   Thu, 23 Jan 2020 19:33:32 +0000
Message-ID: <76d4ebdbb76c8ac95e79e9db81e86625144d929a.camel@hammerspace.com>
References: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>
         <041101d5cd50$e398d720$aaca8560$@gmail.com>
         <962370db9ae3ba5a17ba390afe7f9de6cea571d4.camel@hammerspace.com>
         <06bd01d5d12f$0e2288b0$2a679a10$@gmail.com>
In-Reply-To: <06bd01d5d12f$0e2288b0$2a679a10$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a735ccdf-7f7e-4621-c83e-08d7a03b217a
x-ms-traffictypediagnostic: DM5PR1301MB1995:
x-microsoft-antispam-prvs: <DM5PR1301MB199559FA0C930CBCF7FB9D54B80F0@DM5PR1301MB1995.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(8676002)(478600001)(86362001)(316002)(81166006)(6506007)(8936002)(81156014)(4326008)(53546011)(26005)(186003)(64756008)(66476007)(76116006)(66446008)(6512007)(66556008)(91956017)(54906003)(6486002)(71200400001)(2906002)(2616005)(110136005)(36756003)(66946007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1995;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaqB2i/zn7PG6n0KmpdotzLPwz79956+SuHdw+tqqPjqAkKqTbjNHejN41IT89UjpK5jOqmJ/kq5LdbC51LVbAlYvBY4ZwKn/RCNUU3GIYuwSrmeTR3ZdB38faB4FpE0qwnaBo2qWK5/Cnx+VC21Jx6cWQbvBlG/6A0/3wb7M/znA58JwU5RsVq+hErO5rY90XK0Btg1S2K8Af3LzIrYzezl6bCduQBLDLqnf9JO1rDH3QhwjRFZuq5aA7txdzL1MlWmzZhlsEIZ/pXR1xxqm5yVCcZ+FJr4MBZoVAP7hS6gninC6mFf7zcXPiDaVSUeoJnkjr6r7AzKwJrVwNU8aR9JUYhm3Dvh+dFXSazYL66Kj97tzHBvFrOPaUezDVwmkyeNCxirKPELyiO2G2ybk7WE0J+7lU7I7EfnaWCchJ8jFzABDSaZ7p/g6ChKAIOi
x-ms-exchange-antispam-messagedata: DYC3i65K4fKiGwjujO/i9YRubZKrTCeHrv+DXii+TBB/XTPK1AhESXcz8Yg14HAK51UQ/kyzL4Rv51qpkyFi6BAqUeoCH2HUR2NBiHKc3Pge8hdrog74E7czrSkNf/wFmPzaj8qFNk5vn+Owo2LZWg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1530A3C429874A439B7E26D28BFC74C0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a735ccdf-7f7e-4621-c83e-08d7a03b217a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 19:33:32.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNtfoCDVNpJ+J+sZq7SvGROxludZEZJBKrSNcfyHeEUZoCYyhAUY/wTqEst0fvV4owmMCi2ckQSetph3p/5oLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1995
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTIyIGF0IDE0OjIwICswMDAwLCBSb2JlcnQgTWlsa293c2tpIHdyb3Rl
Og0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVi
dXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiBTZW50OiAxNyBKYW51YXJ5IDIwMjAg
MTc6MjQNCj4gPiBUbzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZzsgcm1pbGtvd3NraUBnbWFp
bC5jb20NCj4gPiBDYzogYW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbTsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gPiBjaHVjay5sZXZlckBvcmFjbGUuY29tDQo+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gTkZTdjQ6IHRyeSBsZWFzZSByZWNvdmVyeSBvbg0KPiA+IE5GUzRFUlJf
RVhQSVJFRA0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMC0wMS0xNyBhdCAxNjoxMiArMDAwMCwgUm9i
ZXJ0IE1pbGtvd3NraSB3cm90ZToNCj4gPiA+IEFueW9uZSBwbGVhc2U/DQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJvYmVydCBN
aWxrb3dza2kgPHJtaWxrb3dza2lAZ21haWwuY29tPg0KPiA+ID4gU2VudDogMDggSmFudWFyeSAy
MDIwIDIxOjQ4DQo+ID4gPiBUbzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6
ICdUcm9uZCBNeWtsZWJ1c3QnIDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT47ICdDaHVjayBMZXZl
cicNCj4gPiA+IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPjsgJ0FubmEgU2NodW1ha2VyJyA8DQo+
ID4gPiBhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29tDQo+ID4gPiA+IDsNCj4gPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gTkZTdjQ6IHRy
eSBsZWFzZSByZWNvdmVyeSBvbiBORlM0RVJSX0VYUElSRUQNCj4gPiA+IA0KPiA+ID4gRnJvbTog
Um9iZXJ0IE1pbGtvd3NraSA8cm1pbGtvd3NraUBnbWFpbC5jb20+DQo+ID4gPiANCj4gPiA+IEN1
cnJlbnRseSwgaWYgYW4gbmZzIHNlcnZlciByZXR1cm5zIE5GUzRFUlJfRVhQSVJFRCB0byBvcGVu
KCksDQo+ID4gPiBldGMuDQo+ID4gPiB3ZSByZXR1cm4gRUlPIHRvIGFwcGxpY2F0aW9ucyB3aXRo
b3V0IGV2ZW4gdHJ5aW5nIHRvIHJlY292ZXIuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiAyNzIyODlh
M2RmNzIgKCJORlN2NDogbmZzNF9kb19oYW5kbGVfZXhjZXB0aW9uKCkgaGFuZGxlDQo+ID4gPiBy
ZXZva2UvZXhwaXJ5IG9mIGEgc2luZ2xlIHN0YXRlaWQiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
Um9iZXJ0IE1pbGtvd3NraSA8cm1pbGtvd3NraUBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBmcy9uZnMvbmZzNHByb2MuYyB8IDQgKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5j
IGIvZnMvbmZzL25mczRwcm9jLmMgaW5kZXgNCj4gPiA+IDc2ZDM3MTYuLjI0Nzg0MDUNCj4gPiA+
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ICsrKyBiL2ZzL25m
cy9uZnM0cHJvYy5jDQo+ID4gPiBAQCAtNDgxLDYgKzQ4MSwxMCBAQCBzdGF0aWMgaW50IG5mczRf
ZG9faGFuZGxlX2V4Y2VwdGlvbihzdHJ1Y3QNCj4gPiA+IG5mc19zZXJ2ZXIgKnNlcnZlciwNCj4g
PiA+ICAJCQkJCQlzdGF0ZWlkKTsNCj4gPiA+ICAJCQkJZ290byB3YWl0X29uX3JlY292ZXJ5Ow0K
PiA+ID4gIAkJCX0NCj4gPiA+ICsJCQlpZiAoc3RhdGUgPT0gTlVMTCkgew0KPiA+ID4gKwkJCQlu
ZnM0X3NjaGVkdWxlX2xlYXNlX3JlY292ZXJ5KGNscCk7DQo+ID4gPiArCQkJCWdvdG8gd2FpdF9v
bl9yZWNvdmVyeTsNCj4gPiA+ICsJCQl9DQo+ID4gPiAgCQkJLyogRmFsbCB0aHJvdWdoICovDQo+
ID4gPiAgCQljYXNlIC1ORlM0RVJSX09QRU5NT0RFOg0KPiA+ID4gIAkJCWlmIChpbm9kZSkgew0K
PiA+ID4gLS0NCj4gPiA+IDEuOC4zLjENCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gRG9lcyB0
aGlzIGFwcGx5IHRvIGFueSBjYXNlIG90aGVyIHRoYW4gTkZTNEVSUl9FWFBJUkVEIGluIHRoZQ0K
PiA+IHNwZWNpZmljDQo+ID4gY2FzZSBvZiBuZnM0X2RvX29wZW4oKT8gSSBjYW4ndCBzZWUgdGhh
dCBpdCBkb2VzLiBJdCBsb29rcyB0byBtZSBhcw0KPiA+IGlmDQo+ID4gdGhlIG9wZW4gcmVjb3Zl
cnkgcm91dGluZXMgYWxyZWFkeSBoYXZlIHRoZWlyIG93biBoYW5kbGluZyBvZiB0aGlzDQo+ID4g
Y2FzZS4NCj4gDQo+IEkgb25seSBvYnNlcnZlZCB0aGUgaXNzdWUgd2l0aCBvcGVuKCkuIEFmdGVy
IGZ1cnRoZXINCj4gcmV2aWV3IEkgdGhpbmsgeW91IGFyZSByaWdodCBhbmQgaXQgb25seSBhcHBs
aWVzIHRvIG5mczRfZG9fb3BlbigpLg0KPiANCj4gDQo+ID4gSWYgc28sIHdoeSBub3QganVzdCBh
ZGQgaXQgYXMgYSBzcGVjaWFsIGNhc2UgaW4gdGhlIG5mczRfZG9fb3BlbigpDQo+ID4gZXJyb3IN
Cj4gPiBoYW5kbGluZz8gT3RoZXJ3aXNlIHRoaXMgcGF0Y2ggd2lsbCBlbmQgdXAgb3ZlcnJpZGlu
ZyBvdGhlciBnZW5lcmljDQo+ID4gY2FzZXMgd2hlcmUgd2UgaGF2ZSBhbiBpbm9kZSwgYnV0IG5v
IG9wZW4gc3RhdGUuDQo+ID4gDQo+IA0KPiBGYWlyIHBvaW50Lg0KPiBTbyBwZXJoYXBzLCBmZXcg
bGluZXMgZnVydGhlciBpbnN0ZWFkIG9mOg0KPiANCj4gCQkJaWYgKGlub2RlKSB7DQo+IC4uLg0K
PiAJCQlpZiAoc3RhdGUgPT0gTlVMTCkgew0KPiAJCQkJCWJyZWFrOw0KPiAJCQl9DQo+IA0KPiBU
aGVyZSBzaG91bGQgYmU6DQo+IA0KPiAJCQlpZiAoaW5vZGUpIHsNCj4gLi4uDQo+IAkJCWlmIChz
dGF0ZSA9PSBOVUxMKSB7DQo+IAkJCQluZnM0X3NjaGVkdWxlX2xlYXNlX3JlY292ZXJ5KGNscCk7
DQo+IAkJCQlnb3RvIHdhaXRfb25fcmVjb3Zlcnk7DQo+IAkJCX0NCj4gDQo+IA0KPiANCj4gVGhp
cyB3YXkgd2Uga25vdyB0aGF0IGlub2RlIGNhbm5vdCBiZSBudWxsIGF0IHRoaXMgcG9pbnQsIGFu
ZCBpdCdzIGENCj4gY2FzZSB3aGVyZSBib3RoIGlub2RlIGFuZCBzdGF0ZSBhcmUgTlVMTC4NCj4g
VGhpcyB3b3VsZCBiZSBhIGxpdHRsZSBiaXQgbW9yZSBnZW5lcmFsIGluIGNhc2Ugd2UgcmVhY2gg
dGhpcyBwb2ludC4NCj4gDQo+IEJ1dCBpZiB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIG1vdmUg
aXQgdG8gbmZzNF9kb19vcGVuKCkgdGhlbiBJJ3ZlDQo+IGp1c3QgdGVzdGVkIHRoZSBmb2xsb3dp
bmcgcGF0Y2g6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMv
bmZzNHByb2MuYw0KPiBpbmRleCA3NmQzNzE2Li5iN2M0MDQ0IDEwMDY0NA0KPiAtLS0gYS9mcy9u
ZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtMzE4Nyw2ICsz
MTg3LDExIEBAIHN0YXRpYyBzdHJ1Y3QgbmZzNF9zdGF0ZSAqbmZzNF9kb19vcGVuKHN0cnVjdA0K
PiBpbm9kZSAqZGlyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBleGNlcHRpb24ucmV0cnkg
PSAxOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICAgICAg
ICAgIH0NCj4gKyAgICAgICAgICAgICAgIGlmIChzdGF0dXMgPT0gLU5GUzRFUlJfRVhQSVJFRCkg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICBuZnM0X3NjaGVkdWxlX2xlYXNlX3JlY292ZXJ5
KHNlcnZlci0NCj4gPm5mc19jbGllbnQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBleGNl
cHRpb24ucmV0cnkgPSAxOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4g
KyAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIGlmIChzdGF0dXMgPT0gLUVBR0FJ
Tikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBXZSBtdXN0IGhhdmUgZm91bmQgYSBk
ZWxlZ2F0aW9uICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGV4Y2VwdGlvbi5yZXRyeSA9
IDE7DQo+IA0KDQpUaGlzIGxvb2tzIGxpa2Ugd2hhdCBJJ20gYXNraW5nIGZvciwgeWVzLiBUaGF0
IHNlZW1zIGxpa2UgdGhlIG1pbmltYWwNCnBhdGNoIHRoYXQgYWRkcmVzc2VzIHRoZSBwcm9ibGVt
IHlvdSdyZSBkZXNjcmliaW5nLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
