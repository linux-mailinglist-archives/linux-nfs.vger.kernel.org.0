Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF2B12C9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfILQ3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 12:29:24 -0400
Received: from mail-eopbgr720130.outbound.protection.outlook.com ([40.107.72.130]:35172
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730310AbfILQ3X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 12:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyWhCzSLOA3tPyp3CbMa54mm7QTTTopgaBMp/L3UTXu6lPeX9WOJ9BaChtpKeFPTNKuKn+9V0HMyzdh8E45sS6/ZmvLiYSiyiirBiMQQa5Tt6XqvUS9TY2kOuiAo/GSgEpqsdLTbeskrBAvu/cjtDaYkc9+LkeKvdzGWg78Uk3iLWPvR4RSsdeOVdgWZ6C0R+QW36Iva9iamy2/Jt5Mg7mrVhZ/pdMiT0XIAkhoozKm13lA4hiNm5bjaysdIea2Kn0DtTqHH1PkVebZORafanwt54lhEZgfX7VPPiA+z4r6Vv5HzSLvRFjilxRH8uYecJwDPY3dNLC5BZVOrWoTKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z14OIJwJImxbo9GnWPCBK1Mf/94i2owiJdJP+mKUCEs=;
 b=Mx6z3b3livacq5E+Pks/o/Ps8R+9NSzkBNwdO+0MTxqgunLL0uGi7IxZF3NbR3eXXwibv7xFWAEAKxIdkZzGPD0Zs1O+p1lHCJ+ztN0PfCXObLMHYJIrSI3QXLTaPnE02/TNIbg2LTLuwgkzQzJhDp6mGdMvmrXJeq816ogS+GRuA/D+Rbc4hNxypjbne3g6o3z2u+1iuLMbv5GWJYz6Y9H7W8BURAEpQ/vEhBIQ3GQhf29rjcHz0nTOQIwtYK8NO6Z9NaUXJSaz5+oNycfL8PAhzfZPdIIr95Aao/3P9I3QQsOGddmoDWWceC7IG6qjAgfdakIU6Kv+fyfDlkbRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z14OIJwJImxbo9GnWPCBK1Mf/94i2owiJdJP+mKUCEs=;
 b=A2ODwiXwfrioqaCYLnilKAiLvKmmyutKRMZFAWEunF51lgiy9drWfPoJ20kXRrYMDy/GoOGVKpQLgko642fvMsBkxWV9PvOp8nUzOKEDQqk3Ox/4CUlFcTvrwfBGgdNmw3DE32puI4pIfLGMs4DLLVagD5xlXNcP5HBYkKmrHEE=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1610.namprd13.prod.outlook.com (10.175.111.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Thu, 12 Sep 2019 16:29:20 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 16:29:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by
 bumping the state seqid
Thread-Topic: [PATCH 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by
 bumping the state seqid
Thread-Index: AQHVZxdY53I16qsfSkWn2G4GRaRuXacoK2iAgAAU2oA=
Date:   Thu, 12 Sep 2019 16:29:19 +0000
Message-ID: <56f43f996e42e970e1633aec5a12c756bbb3e1c7.camel@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
         <20190909140104.78818-2-trond.myklebust@hammerspace.com>
         <20190909140104.78818-3-trond.myklebust@hammerspace.com>
         <20190909140104.78818-4-trond.myklebust@hammerspace.com>
         <20190909140104.78818-5-trond.myklebust@hammerspace.com>
         <20190909140104.78818-6-trond.myklebust@hammerspace.com>
         <CAN-5tyGOjTGft-rvqD7EzhCS9CK1dNKpUq9hRZTqs8ivLZ0_cg@mail.gmail.com>
In-Reply-To: <CAN-5tyGOjTGft-rvqD7EzhCS9CK1dNKpUq9hRZTqs8ivLZ0_cg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a52d6050-c52f-4f4e-5021-08d7379e5cf6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1610;
x-ms-traffictypediagnostic: DM5PR13MB1610:
x-microsoft-antispam-prvs: <DM5PR13MB16104D3A00E53AC65AE5BBB1B8B00@DM5PR13MB1610.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39830400003)(189003)(199004)(66446008)(66946007)(2351001)(8676002)(2501003)(71190400001)(476003)(71200400001)(6246003)(14444005)(118296001)(5640700003)(486006)(8936002)(229853002)(7736002)(86362001)(81156014)(66066001)(6116002)(2171002)(256004)(81166006)(1730700003)(305945005)(4326008)(5660300002)(6916009)(3846002)(6436002)(446003)(6506007)(2906002)(14454004)(54906003)(53936002)(76176011)(53546011)(6486002)(102836004)(186003)(26005)(25786009)(316002)(6512007)(91956017)(99286004)(64756008)(66476007)(76116006)(478600001)(11346002)(36756003)(66556008)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1610;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ogamy9PvRel+g+YyAFISJhgHKal2jZuqxdt46cRzSney3nKOjS0UvYD2h2ldgYfyVcU9h0n/hk2jxRnHgAPm9l2ei2RxNtGSDCwCAIkDTbWGeka/491QES35koCbAr7i+uFj3go+hEytGKzUzDgByl8jshLkDgznROu2w11mhYY6ZlVPchl92nFV9Pj8XZw6qjt6J4z/a2i+pajuSiJYVKvg5uCywUihejrUAGy4JMGcBTcoS/vKi0Dc63SI6cz0v3I3SwLN92GToMoSb1sG4xio6OCTUIHXIufV0FD4UQyLgXdPJtvu29qHc/on7vOBsb797MY3o8L0hcgnID/SgGQCmrJ6ROP72LY6TEDZFpTuI6MCb4Uj07GHS3+WljWRuF/CS4AbiM7EQS4gNmT37+eiAT1bK7UnOB9ZC78hpjI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4BE057B49E39047B0C7D7EC4D2980D8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52d6050-c52f-4f4e-5021-08d7379e5cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 16:29:19.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+AY565xFjrc0fm5q3zJhxNPicZxQW4w4BQMbd1aVAr2Vdlohqh2zB+cIAnkKxVgkW/eljDjr+FZf5Ls3BXgeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1610
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDExOjE0IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gd2h5IGFyZSB3ZSBqdXN0IGJ1
bXBpbmcgdGhlIHNlcWlkIGJ5IDEgaW5zdGVhZCBvZg0KPiB3aGF0DQo+IGl0IHdhcyBjdXJyZW50
bHkgdXNpbmcgdG8gdXBkYXRlIGl0IHRvIHRoZSBjdXJyZW50IHZhbHVlIHdoaWNoIGNvdWxkDQo+
IGJlIG1vcmUgdGhhbiBvZmYgYnkgb25lPyBJJ20ganVzdCBzcGVjdWxhdGluZyB0aGF0IHdlJ2xs
IHNlZSB0aGUgc2FtZQ0KPiBiZWhhdmlvciB0aGF0IHdlJ2xsIGdldCB0aGUgRVJSX09MRF9TVEFU
RUlEIGluY3JlbWVudGVkIGJ5IG9uZSB1bnRpbA0KPiB0aGUgY3VycmVudCB2YWx1ZT8NCg0KV2Ug
b25seSBidW1wIGJ5IDEgaWYgd2Ugc2VlIHRoYXQgd2UncmUgYWxyZWFkeSBhYm92ZSB0aGUgc2Vx
aWQgb2YgdGhlDQpjdXJyZW50IGxheW91dCBzdGF0ZWlkLiBPdGhlcndpc2UsIHdlIHN5bmMgdG8g
dGhlIHZhbHVlIG9mIHRoYXQgbGF5b3V0DQpzdGF0ZWlkIGJlZm9yZSByZXRyeWluZy4NCg0KPiAN
Cj4gT24gVHVlLCBTZXAgMTAsIDIwMTkgYXQgNDowOSBBTSBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
bXlAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPiBJZiBhIExBWU9VVFJFVFVSTiByZWNlaXZlcyBh
IHJlcGx5IG9mIE5GUzRFUlJfT0xEX1NUQVRFSUQgdGhlbg0KPiA+IGFzc3VtZSB3ZSd2ZQ0KPiA+
IG1pc3NlZCBhbiB1cGRhdGUsIGFuZCBqdXN0IGJ1bXAgdGhlIHN0YXRlaWQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnMvbmZzNHByb2MuYyB8ICAyICstDQo+ID4gIGZz
L25mcy9wbmZzLmMgICAgIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ID4gIGZzL25mcy9wbmZz
LmggICAgIHwgIDQgKystLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5j
IGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiBpbmRleCBhNWRlYjAwYjVhZDEuLmNiYWY2YjdhYzEy
OCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ICsrKyBiL2ZzL25mcy9u
ZnM0cHJvYy5jDQo+ID4gQEAgLTkwNjksNyArOTA2OSw3IEBAIHN0YXRpYyB2b2lkIG5mczRfbGF5
b3V0cmV0dXJuX2RvbmUoc3RydWN0DQo+ID4gcnBjX3Rhc2sgKnRhc2ssIHZvaWQgKmNhbGxkYXRh
KQ0KPiA+ICAgICAgICAgc2VydmVyID0gTkZTX1NFUlZFUihscnAtPmFyZ3MuaW5vZGUpOw0KPiA+
ICAgICAgICAgc3dpdGNoICh0YXNrLT50a19zdGF0dXMpIHsNCj4gPiAgICAgICAgIGNhc2UgLU5G
UzRFUlJfT0xEX1NUQVRFSUQ6DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChuZnM0X2xheW91dHJl
dHVybl9yZWZyZXNoX3N0YXRlaWQoJmxycC0NCj4gPiA+YXJncy5zdGF0ZWlkLA0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAobmZzNF9sYXlvdXRfcmVmcmVzaF9vbGRfc3RhdGVpZCgmbHJwLQ0KPiA+
ID5hcmdzLnN0YXRlaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZscnAtPmFyZ3MucmFuZ2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGxycC0+YXJncy5pbm9kZSkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBvdXRfcmVzdGFydDsNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3BuZnMuYyBiL2ZzL25m
cy9wbmZzLmMNCj4gPiBpbmRleCBhYmM3MTg4ZjE4NTMuLmJiODAwMzRhNzY2MSAxMDA2NDQNCj4g
PiAtLS0gYS9mcy9uZnMvcG5mcy5jDQo+ID4gKysrIGIvZnMvbmZzL3BuZnMuYw0KPiA+IEBAIC0z
NTksOSArMzU5LDEwIEBAIHBuZnNfY2xlYXJfbHNlZ19zdGF0ZShzdHJ1Y3QNCj4gPiBwbmZzX2xh
eW91dF9zZWdtZW50ICpsc2VnLA0KPiA+ICB9DQo+ID4gDQo+ID4gIC8qDQo+ID4gLSAqIFVwZGF0
ZSB0aGUgc2VxaWQgb2YgYSBsYXlvdXQgc3RhdGVpZA0KPiA+ICsgKiBVcGRhdGUgdGhlIHNlcWlk
IG9mIGEgbGF5b3V0IHN0YXRlaWQgYWZ0ZXIgcmVjZWl2aW5nDQo+ID4gKyAqIE5GUzRFUlJfT0xE
X1NUQVRFSUQNCj4gPiAgICovDQo+ID4gLWJvb2wgbmZzNF9sYXlvdXRyZXR1cm5fcmVmcmVzaF9z
dGF0ZWlkKG5mczRfc3RhdGVpZCAqZHN0LA0KPiA+ICtib29sIG5mczRfbGF5b3V0X3JlZnJlc2hf
b2xkX3N0YXRlaWQobmZzNF9zdGF0ZWlkICpkc3QsDQo+ID4gICAgICAgICAgICAgICAgIHN0cnVj
dCBwbmZzX2xheW91dF9yYW5nZSAqZHN0X3JhbmdlLA0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1
Y3QgaW5vZGUgKmlub2RlKQ0KPiA+ICB7DQo+ID4gQEAgLTM3Nyw3ICszNzgsMTUgQEAgYm9vbA0K
PiA+IG5mczRfbGF5b3V0cmV0dXJuX3JlZnJlc2hfc3RhdGVpZChuZnM0X3N0YXRlaWQgKmRzdCwN
Cj4gPiANCj4gPiAgICAgICAgIHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQo+ID4gICAgICAg
ICBsbyA9IE5GU19JKGlub2RlKS0+bGF5b3V0Ow0KPiA+IC0gICAgICAgaWYgKGxvICYmIG5mczRf
c3RhdGVpZF9tYXRjaF9vdGhlcihkc3QsICZsby0+cGxoX3N0YXRlaWQpKQ0KPiA+IHsNCj4gPiAr
ICAgICAgIGlmIChsbyAmJiAgcG5mc19sYXlvdXRfaXNfdmFsaWQobG8pICYmDQo+ID4gKyAgICAg
ICAgICAgbmZzNF9zdGF0ZWlkX21hdGNoX290aGVyKGRzdCwgJmxvLT5wbGhfc3RhdGVpZCkpIHsN
Cj4gPiArICAgICAgICAgICAgICAgLyogSXMgb3VyIGNhbGwgdXNpbmcgdGhlIG1vc3QgcmVjZW50
IHNlcWlkPyBJZiBzbywNCj4gPiBidW1wIGl0ICovDQo+ID4gKyAgICAgICAgICAgICAgIGlmICgh
bmZzNF9zdGF0ZWlkX2lzX25ld2VyKCZsby0+cGxoX3N0YXRlaWQsIGRzdCkpDQo+ID4gew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIG5mczRfc3RhdGVpZF9zZXFpZF9pbmMoZHN0KTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSB0cnVlOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAg
ICAgICAgIC8qIFRyeSB0byB1cGRhdGUgdGhlIHNlcWlkIHRvIHRoZSBtb3N0IHJlY2VudCAqLw0K
PiA+ICAgICAgICAgICAgICAgICBlcnIgPSBwbmZzX21hcmtfbWF0Y2hpbmdfbHNlZ3NfcmV0dXJu
KGxvLCAmaGVhZCwNCj4gPiAmcmFuZ2UsIDApOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZXJy
ICE9IC1FQlVTWSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRzdC0+c2VxaWQgPSBs
by0+cGxoX3N0YXRlaWQuc2VxaWQ7DQo+ID4gQEAgLTM4NSw2ICszOTQsNyBAQCBib29sDQo+ID4g
bmZzNF9sYXlvdXRyZXR1cm5fcmVmcmVzaF9zdGF0ZWlkKG5mczRfc3RhdGVpZCAqZHN0LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHRydWU7DQo+ID4gICAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgIH0NCj4gPiArb3V0Og0KPiA+ICAgICAgICAgc3Bpbl91bmxvY2soJmlu
b2RlLT5pX2xvY2spOw0KPiA+ICAgICAgICAgcG5mc19mcmVlX2xzZWdfbGlzdCgmaGVhZCk7DQo+
ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IEBAIC0xNDc1LDcgKzE0ODUsNyBAQCBpbnQgcG5m
c19yb2NfZG9uZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssDQo+ID4gc3RydWN0IGlub2RlICppbm9k
ZSwNCj4gPiAgICAgICAgICAgICAgICAgKnJldCA9IC1ORlM0RVJSX05PTUFUQ0hJTkdfTEFZT1VU
Ow0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAgIGNhc2UgLU5GUzRF
UlJfT0xEX1NUQVRFSUQ6DQo+ID4gLSAgICAgICAgICAgICAgIGlmICghbmZzNF9sYXlvdXRyZXR1
cm5fcmVmcmVzaF9zdGF0ZWlkKCZhcmctDQo+ID4gPnN0YXRlaWQsDQo+ID4gKyAgICAgICAgICAg
ICAgIGlmICghbmZzNF9sYXlvdXRfcmVmcmVzaF9vbGRfc3RhdGVpZCgmYXJnLT5zdGF0ZWlkLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYXJnLT5yYW5nZSwg
aW5vZGUpKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAg
ICAgICAgICAqcmV0ID0gLU5GUzRFUlJfTk9NQVRDSElOR19MQVlPVVQ7DQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9wbmZzLmggYi9mcy9uZnMvcG5mcy5oDQo+ID4gaW5kZXggM2VmMzc1NmQ0Mzdj
Li5mOGEzODA2NWM3ZTQgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL3BuZnMuaA0KPiA+ICsrKyBi
L2ZzL25mcy9wbmZzLmgNCj4gPiBAQCAtMjYxLDcgKzI2MSw3IEBAIGludCBwbmZzX2Rlc3Ryb3lf
bGF5b3V0c19ieWZzaWQoc3RydWN0DQo+ID4gbmZzX2NsaWVudCAqY2xwLA0KPiA+ICAgICAgICAg
ICAgICAgICBib29sIGlzX3JlY2FsbCk7DQo+ID4gIGludCBwbmZzX2Rlc3Ryb3lfbGF5b3V0c19i
eWNsaWQoc3RydWN0IG5mc19jbGllbnQgKmNscCwNCj4gPiAgICAgICAgICAgICAgICAgYm9vbCBp
c19yZWNhbGwpOw0KPiA+IC1ib29sIG5mczRfbGF5b3V0cmV0dXJuX3JlZnJlc2hfc3RhdGVpZChu
ZnM0X3N0YXRlaWQgKmRzdCwNCj4gPiArYm9vbCBuZnM0X2xheW91dF9yZWZyZXNoX29sZF9zdGF0
ZWlkKG5mczRfc3RhdGVpZCAqZHN0LA0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgcG5mc19s
YXlvdXRfcmFuZ2UgKmRzdF9yYW5nZSwNCj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IGlub2Rl
ICppbm9kZSk7DQo+ID4gIHZvaWQgcG5mc19wdXRfbGF5b3V0X2hkcihzdHJ1Y3QgcG5mc19sYXlv
dXRfaGRyICpsbyk7DQo+ID4gQEAgLTc5OCw3ICs3OTgsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQN
Cj4gPiBuZnM0X3BuZnNfdjNfZHNfY29ubmVjdF91bmxvYWQodm9pZCkNCj4gPiAgew0KPiA+ICB9
DQo+ID4gDQo+ID4gLXN0YXRpYyBpbmxpbmUgYm9vbCBuZnM0X2xheW91dHJldHVybl9yZWZyZXNo
X3N0YXRlaWQobmZzNF9zdGF0ZWlkDQo+ID4gKmRzdCwNCj4gPiArc3RhdGljIGlubGluZSBib29s
IG5mczRfbGF5b3V0X3JlZnJlc2hfb2xkX3N0YXRlaWQobmZzNF9zdGF0ZWlkDQo+ID4gKmRzdCwN
Cj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IHBuZnNfbGF5b3V0X3JhbmdlICpkc3RfcmFuZ2Us
DQo+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ID4gIHsNCj4gPiAt
LQ0KPiA+IDIuMjEuMA0KPiA+IA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
