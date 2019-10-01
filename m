Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A37C412D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfJATil (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 15:38:41 -0400
Received: from mail-eopbgr810111.outbound.protection.outlook.com ([40.107.81.111]:32128
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfJATil (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 15:38:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSIqJ7huS38wL5fz2RRjUy4hnuCt7Mi4TpffnAFoCJmQBzuSvKYW/I13QQNqn+O69gSytFm0BCNJuhm1/1qQdP4/ri/e+PUSMoFMxeSzg8QYw611hQ4cZGBVprjTDAb0/zBD/i08m62ZC3MDamYLS6njEGqPVZCWf994l6YPc5jOQjvewghgvLbUQDWc99O3GDNMmJAb6qXwpiPlVAEHuaronoDvBDQLPouO8cDiMGh7107M8A9agWD/ET9r3RJN7/Go+YWep7x3lxA8r+lhexORUTPrcoILaavrfg77BJcaKb5zTCYeRMgFFmsYbHQwvvMn3QeiCepIzQqRJ2J1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pam5DTdpU5TTT3E0UjQjnLUTZVmrYl0ccUbTT944c5M=;
 b=k1PMMIdo+v92itsDcLFdvklXzhFg221Bme+sSgjJ9QpneJ0VY/uTqfZSb1pc09NMlmFEZmnEcahl0Le61JZfuUn061XGBHclsItLC3iwh5L5k3RIiOUQ/cJkBg8sJ+FkHjCIpq1WyjXkZnVJ4cHZgv/8E7NOhvaxj4KzOc13M8/2WFg1Y6hPj835/Ys6/d9bR4VcR2y6Ia+ZPTY0WeqeIE6VqJ9fS5SagECiK1+7QvRFLmfArjYsWKQnMiGkt2bZRr+CU+DxYJXGxErXMUY9/WwIk7c8PGLzXMLOQxJOQEBt2Eg4PhELSRtnlxYBOmJ3rrjaehjyVSR6p4P4hfexPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pam5DTdpU5TTT3E0UjQjnLUTZVmrYl0ccUbTT944c5M=;
 b=Ct2AlQnb5gYgAmk1uuW9an8MDapLt4C/JMNazSm84ZDadX0+/zE4gMKsoKK9/JRGhHBkgtImfazl1KoP5aDAv2TkTVs/R/XGVWquNv0moqVyAeHqbSZTAHI3qHr3E4omW1j/zfcJGpzH5iuB6AX5Gctl7oCw/bl87oqSUbucvKU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1307.namprd13.prod.outlook.com (10.168.119.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 19:38:31 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 19:38:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jamespharvey20@gmail.com" <jamespharvey20@gmail.com>
Subject: Re: [PATCH] SUNRPC: fix race to sk_err after xs_error_report
Thread-Topic: [PATCH] SUNRPC: fix race to sk_err after xs_error_report
Thread-Index: AQHVeIZbIUo+TvWWXkm27VI6sP6bYqdGLo2A
Date:   Tue, 1 Oct 2019 19:38:31 +0000
Message-ID: <d9bf3f1092ed0361cc344e04a915ea337a3aa9e8.camel@hammerspace.com>
References: <9796ba15d926f65923965c2aedf777aaa59861e8.1569954618.git.bcodding@redhat.com>
In-Reply-To: <9796ba15d926f65923965c2aedf777aaa59861e8.1569954618.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c946f851-9c1b-460e-0bb6-08d746a6f0ab
x-ms-traffictypediagnostic: DM5PR13MB1307:
x-microsoft-antispam-prvs: <DM5PR13MB130735B26468D0B8CD232927B89D0@DM5PR13MB1307.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(136003)(366004)(346002)(39830400003)(199004)(189003)(66946007)(118296001)(66476007)(486006)(110136005)(446003)(316002)(76116006)(476003)(91956017)(305945005)(66556008)(2616005)(6436002)(6486002)(11346002)(2906002)(54906003)(36756003)(7736002)(81156014)(6512007)(64756008)(66446008)(6246003)(6116002)(3846002)(4326008)(229853002)(76176011)(26005)(478600001)(14454004)(5660300002)(8676002)(186003)(102836004)(25786009)(256004)(81166006)(71190400001)(8936002)(71200400001)(14444005)(99286004)(2501003)(66066001)(86362001)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1307;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLPvWxAan3MBaE7BBJ9blb5WuukV6j3z3VxPhyUSyLWJ42mKWd2n6QyjMVxH6qUlcuqDRjw7W1sHS00L2Wi8a3POBn216lcyUKkFQHvxWN1pVf3IGcwasSYAXFit2D21QaKyr+1wMmwPWkeJrYjNuWEBEKSMSqQh+jHhsBnBfyf7qyb6h6s+PW8lZbXkWTvHkWMEyt1TiQ8GSypVYvMgJQrvejrzAudW9vYTospoa2O3OpCNZbeRrssm+4+rD5u33So5wpHTqhQyNXUUVqM0ZYEaynACdimf8vIZZoXWQN7tnI/eBpTP6hqOdwiWKDZuzGhR2Xu0gwgTwYkkEr4Rj0WY9OYwI4qxtu62vDVFDlKoelzxQ/iMZtgsxbWu0t9ZVg4DPaz/ghQROFqKouN2OP8mgo6IrSjWwYF0XG7xuO4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <630542868D0BA448AF3A0EC5E704A0C9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c946f851-9c1b-460e-0bb6-08d746a6f0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 19:38:31.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5+WmjymFg9G5U+LKSeMJOIC3+fcID8MLqnBjb1Ig/oI6CKG7R/QF6v4Nqr/rGYl4X+swLiB+6gFO+wr4NE34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1307
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDE0OjMwIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBTaW5jZSBjb21taXQgNGY4OTQzZjgwODgzICgiU1VOUlBDOiBSZXBsYWNlIGRpcmVj
dCB0YXNrIHdha2V1cHMgZnJvbQ0KPiBzb2Z0aXJxIGNvbnRleHQiKSB0aGVyZSBoYXMgYmVlbiBh
IHJhY2UgdG8gdGhlIHZhbHVlIG9mIHRoZSBza19lcnIgaWYNCj4gYm90aA0KPiBYUFJUX1NPQ0tf
V0FLRV9FUlJPUiBhbmQgWFBSVF9TT0NLX1dBS0VfRElTQ09OTkVDVCBhcmUgc2V0LiAgSW4gdGhh
dA0KPiBjYXNlLA0KPiB3ZSBtYXkgZW5kIHVwIGxvc2luZyB0aGUgc2tfZXJyIHZhbHVlIHRoYXQg
ZXhpc3RlZCB3aGVuDQo+IHhzX2Vycm9yX3JlcG9ydCB3YXMNCj4gY2FsbGVkLg0KPiANCj4gRml4
IHRoaXMgYnkgcmV2ZXJ0aW5nIHRvIHRoZSBwcmV2aW91cyBiZWhhdmlvcjogaW5zdGVhZCBvZiB1
c2luZw0KPiBTT19FUlJPUg0KPiB0byByZXRyaWV2ZSB0aGUgdmFsdWUgYXQgYSBsYXRlciB0aW1l
ICh3aGljaCBtaWdodCBhbHNvIHJldHVybg0KPiBza19lcnJfc29mdCksDQo+IGNvcHkgdGhlIHNr
X2VyciB2YWx1ZSBvbnRvIHN0cnVjdCBzb2NrX3hwcnQsIGFuZCB1c2UgdGhhdCB2YWx1ZSB0bw0K
PiB3YWtlDQo+IHBlbmRpbmcgdGFza3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBD
b2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0KPiBGaXhlczogNGY4OTQzZjgwODgzICgi
U1VOUlBDOiBSZXBsYWNlIGRpcmVjdCB0YXNrIHdha2V1cHMgZnJvbQ0KPiBzb2Z0aXJxIGNvbnRl
eHQiKQ0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2NrLmggfCAgMSArDQo+
ICBuZXQvc3VucnBjL3hwcnRzb2NrLmMgICAgICAgICAgIHwgMTMgKysrKystLS0tLS0tLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydHNvY2suaA0KPiBiL2luY2x1ZGUv
bGludXgvc3VucnBjL3hwcnRzb2NrLmgNCj4gaW5kZXggNzYzOGRiZTdiYzUwLi44ZmZhZTczZGVh
NmMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2NrLmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydHNvY2suaA0KPiBAQCAtNTYsNiArNTYsNyBAQCBz
dHJ1Y3Qgc29ja194cHJ0IHsNCj4gIAkgKi8NCj4gIAl1bnNpZ25lZCBsb25nCQlzb2NrX3N0YXRl
Ow0KPiAgCXN0cnVjdCBkZWxheWVkX3dvcmsJY29ubmVjdF93b3JrZXI7DQo+ICsJaW50CQkJeHBy
dF9lcnI7DQoNClBlcmhhcHMgbW92ZSB0aGlzIGRvd24ganVzdCBhZnRlciBzcmNwb3J0IHNvIHdl
IGRvbid0IGNyZWF0ZSBhbg0KdW5uZWNlc3NhcnkgaG9sZSBpbiB0aGUgc3RydWN0dXJlPw0KDQo+
ICAJc3RydWN0IHdvcmtfc3RydWN0CWVycm9yX3dvcmtlcjsNCj4gIAlzdHJ1Y3Qgd29ya19zdHJ1
Y3QJcmVjdl93b3JrZXI7DQo+ICAJc3RydWN0IG11dGV4CQlyZWN2X211dGV4Ow0KPiBkaWZmIC0t
Z2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IGlu
ZGV4IGUyMTc2YzE2N2E1Ny4uN2ZlNzdlZWY3MDgwIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBj
L3hwcnRzb2NrLmMNCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IEBAIC0xMjUwLDEy
ICsxMjUwLDEyIEBAIHN0YXRpYyB2b2lkIHhzX2Vycm9yX3JlcG9ydChzdHJ1Y3Qgc29jayAqc2sp
DQo+ICAJCWdvdG8gb3V0Ow0KPiAgDQo+ICAJdHJhbnNwb3J0ID0gY29udGFpbmVyX29mKHhwcnQs
IHN0cnVjdCBzb2NrX3hwcnQsIHhwcnQpOw0KPiAtCWVyciA9IC1zay0+c2tfZXJyOw0KPiAtCWlm
IChlcnIgPT0gMCkNCj4gKwl0cmFuc3BvcnQtPnhwcnRfZXJyID0gLXNrLT5za19lcnI7DQoNCkRv
ZXNuJ3QgdGhpcyBuZWVkIGEgc21wIHdyaXRlIGJhcnJpZXIgdG8gZW5zdXJlIGl0IGlzbid0IHJl
b3JkZXJlZCB3aXRoDQp0aGUgc2V0X2JpdCgpIGluIHhzX3J1bl9lcnJvcl93b3JrZXIoKT8NCg0K
PiArCWlmICh0cmFuc3BvcnQtPnhwcnRfZXJyID09IDApDQo+ICAJCWdvdG8gb3V0Ow0KPiAgCWRw
cmludGsoIlJQQzogICAgICAgeHNfZXJyb3JfcmVwb3J0IGNsaWVudCAlcCwgZXJyb3I9JWQuLi5c
biIsDQo+IC0JCQl4cHJ0LCAtZXJyKTsNCj4gLQl0cmFjZV9ycGNfc29ja2V0X2Vycm9yKHhwcnQs
IHNrLT5za19zb2NrZXQsIGVycik7DQo+ICsJCQl4cHJ0LCAtdHJhbnNwb3J0LT54cHJ0X2Vycik7
DQo+ICsJdHJhY2VfcnBjX3NvY2tldF9lcnJvcih4cHJ0LCBzay0+c2tfc29ja2V0LCB0cmFuc3Bv
cnQtDQo+ID54cHJ0X2Vycik7DQo+ICAJeHNfcnVuX2Vycm9yX3dvcmtlcih0cmFuc3BvcnQsIFhQ
UlRfU09DS19XQUtFX0VSUk9SKTsNCj4gICBvdXQ6DQo+ICAJcmVhZF91bmxvY2tfYmgoJnNrLT5z
a19jYWxsYmFja19sb2NrKTsNCj4gQEAgLTI0NzAsNyArMjQ3MCw2IEBAIHN0YXRpYyB2b2lkIHhz
X3dha2Vfd3JpdGUoc3RydWN0IHNvY2tfeHBydA0KPiAqdHJhbnNwb3J0KQ0KPiAgc3RhdGljIHZv
aWQgeHNfd2FrZV9lcnJvcihzdHJ1Y3Qgc29ja194cHJ0ICp0cmFuc3BvcnQpDQo+ICB7DQo+ICAJ
aW50IHNvY2tlcnI7DQo+IC0JaW50IHNvY2tlcnJfbGVuID0gc2l6ZW9mKHNvY2tlcnIpOw0KPiAg
DQo+ICAJaWYgKCF0ZXN0X2JpdChYUFJUX1NPQ0tfV0FLRV9FUlJPUiwgJnRyYW5zcG9ydC0+c29j
a19zdGF0ZSkpDQo+ICAJCXJldHVybjsNCj4gQEAgLTI0NzksOSArMjQ3OCw3IEBAIHN0YXRpYyB2
b2lkIHhzX3dha2VfZXJyb3Ioc3RydWN0IHNvY2tfeHBydA0KPiAqdHJhbnNwb3J0KQ0KPiAgCQln
b3RvIG91dDsNCj4gIAlpZiAoIXRlc3RfYW5kX2NsZWFyX2JpdChYUFJUX1NPQ0tfV0FLRV9FUlJP
UiwgJnRyYW5zcG9ydC0NCj4gPnNvY2tfc3RhdGUpKQ0KPiAgCQlnb3RvIG91dDsNCj4gLQlpZiAo
a2VybmVsX2dldHNvY2tvcHQodHJhbnNwb3J0LT5zb2NrLCBTT0xfU09DS0VULCBTT19FUlJPUiwN
Cj4gLQkJCQkoY2hhciAqKSZzb2NrZXJyLCAmc29ja2Vycl9sZW4pICE9IDApDQo+IC0JCWdvdG8g
b3V0Ow0KPiArCXNvY2tlcnIgPSB4Y2hnKCZ0cmFuc3BvcnQtPnhwcnRfZXJyLCAwKTsNCj4gIAlp
ZiAoc29ja2VyciA8IDApDQo+ICAJCXhwcnRfd2FrZV9wZW5kaW5nX3Rhc2tzKCZ0cmFuc3BvcnQt
PnhwcnQsIHNvY2tlcnIpOw0KPiAgb3V0Og0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
