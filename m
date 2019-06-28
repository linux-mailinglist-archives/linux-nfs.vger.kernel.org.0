Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441685A38F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF1S3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 14:29:51 -0400
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:45888
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfF1S3u (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 14:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lDLlu5KTBYJkGI1HIpEe79dc22/ncMEjMd8EdLq7EE=;
 b=IYsuOBCVKLQuz9Bmp0kJkSUb+XlQ++2mJOUVUKmSCsxLzV8llf6lHA1LY02q3SI3XoofbXInB78dgA5ai2fmYb4CVfV5TGuqjCeOktHUEi3xgkdiDPbjcaAQw8gSO1U1abGArqo4ip4/fH3/yNRHJlZ71VrQw/rKqThSqJ47bHY=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB5490.namprd06.prod.outlook.com (20.178.210.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Fri, 28 Jun 2019 18:29:47 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::1de4:694f:e20b:137c]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::1de4:694f:e20b:137c%4]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 18:29:47 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "buczek@molgen.mpg.de" <buczek@molgen.mpg.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 3/4 RESEND] nfs4: Move nfs4_setup_state_renewal
Thread-Topic: [PATCH 3/4 RESEND] nfs4: Move nfs4_setup_state_renewal
Thread-Index: AQHVLa4yJC9mn+CvDkuKMtWMqmdJhaaxY48A
Date:   Fri, 28 Jun 2019 18:29:47 +0000
Message-ID: <4a732990d3f2797591fb79ef0b04983a17a16c6e.camel@netapp.com>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
         <20190628123640.8715-4-buczek@molgen.mpg.de>
In-Reply-To: <20190628123640.8715-4-buczek@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d0ae60d-e5ba-4d19-a93e-08d6fbf699aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR06MB5490;
x-ms-traffictypediagnostic: BN8PR06MB5490:
x-microsoft-antispam-prvs: <BN8PR06MB54909E4B5EFBFC6398EA7FFAF8FC0@BN8PR06MB5490.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(66066001)(81166006)(66946007)(26005)(6116002)(3846002)(316002)(58126008)(229853002)(110136005)(8676002)(81156014)(8936002)(25786009)(118296001)(53936002)(68736007)(7736002)(6436002)(6486002)(99286004)(305945005)(6512007)(478600001)(76176011)(102836004)(6246003)(6506007)(14444005)(2501003)(72206003)(36756003)(486006)(476003)(186003)(64756008)(66476007)(66556008)(66446008)(2616005)(2201001)(76116006)(5660300002)(71200400001)(73956011)(14454004)(71190400001)(11346002)(2906002)(256004)(446003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5490;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P/T5gr/ocyEussDf8MOYcdI5V64UkaLgPNPV0U5VBmJ+iqLZL4CWBKnh7j8xzDa35csWzHxG0Xw8jGGAJITIUj9gQ0bBXYN3qQSVTraxKi5nDvUC90ZSNQmFWkU1lzhUpMfP5GjHHbPplQjbkIFkOeFhpD8F6zdewYUO28PMQZ0cMXgOdYrpZUWMve1MYHSp4KKmR6kiST2T74/YrioDG7P72FKvf8FNiqr8x6xWocy8DFkFgzoeBhe1/0oFxKonlK+ZkGjtCNd35wZIagH52p8eNymar/Ww8Wvoy6WMbfknYaVyyBCMYABYa5HUO15sHS7z8XS35+8wjdfmTgT9/nluFNgYwJ/ORTyZQjzX6lG1FJHxJXQHFfFX5md+w32FlGJYRmkDF3ZI8M9Ig+XnjuxDgJowFUTiAHZZ3046CT0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D17461785A9864B96A2178AA122AC18@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0ae60d-e5ba-4d19-a93e-08d6fbf699aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 18:29:47.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5490
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRG9uYWxkLA0KDQpPbiBGcmksIDIwMTktMDYtMjggYXQgMTQ6MzYgKzAyMDAsIERvbmFsZCBC
dWN6ZWsgd3JvdGU6DQo+IFRoZSBmdW5jdGlvbiBuZnM0X3NldHVwX3N0YXRlX3JlbmV3YWwgaXMg
dG8gYmUgdXNlZCBieQ0KPiBuZnM0X2luaXRfY2xpZW50aWQuIE1vdmUgaXQgZnVydGhlciB0byB0
aGUgdG9wIG9mIHRoZSBzb3VyY2UgZmlsZSB0bw0KPiBpbmNsdWRlIGl0IHJlZ2FyZGxlcyBvZiBD
T05GSUdfTkZTX1Y0XzEgYW5kIHRvIHNhdmUgYSBmb3J3YXJkDQo+IGRlY2xhcmF0aW9uLiBObyBj
b2RlIGNoYW5nZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEb25hbGQgQnVjemVrIDxidWN6ZWtA
bW9sZ2VuLm1wZy5kZT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHN0YXRlLmMgfCA0MiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gaW5kZXggNzc4ZWJmYjAwZDEz
Li5jMmRmMjU3ZjQyNmYgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiArKysg
Yi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gQEAgLTg3LDYgKzg3LDI3IEBAIGNvbnN0IG5mczRfc3Rh
dGVpZCBjdXJyZW50X3N0YXRlaWQgPSB7DQo+ICANCj4gIHN0YXRpYyBERUZJTkVfTVVURVgobmZz
X2NsaWRfaW5pdF9tdXRleCk7DQo+ICANCj4gK3N0YXRpYyBpbnQgbmZzNF9zZXR1cF9zdGF0ZV9y
ZW5ld2FsKHN0cnVjdCBuZnNfY2xpZW50ICpjbHApDQo+ICt7DQo+ICsJaW50IHN0YXR1czsNCj4g
KwlzdHJ1Y3QgbmZzX2ZzaW5mbyBmc2luZm87DQo+ICsJdW5zaWduZWQgbG9uZyBub3c7DQo+ICsN
Cj4gKwlpZiAoIXRlc3RfYml0KE5GU19DU19DSEVDS19MRUFTRV9USU1FLCAmY2xwLT5jbF9yZXNf
c3RhdGUpKSB7DQo+ICsJCW5mczRfc2NoZWR1bGVfc3RhdGVfcmVuZXdhbChjbHApOw0KPiArCQly
ZXR1cm4gMDsNCj4gKwl9DQo+ICsNCj4gKwlub3cgPSBqaWZmaWVzOw0KPiArCXN0YXR1cyA9IG5m
czRfcHJvY19nZXRfbGVhc2VfdGltZShjbHAsICZmc2luZm8pOw0KDQpuZnM0X3Byb2NfZ2V0X2xl
YXNlX3RpbWUoKSBpcyBkZWZpbmVkIHVuZGVyIGEgQ09ORklHX05GU19WNF8xIGJsb2NrLCBzbw0K
dGhpcyBzdGlsbCB3b24ndCBjb21waWxlLiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlcmUgaXNu
J3QgYW55dGhpbmcNCnY0LjEgc3BlY2lmaWMgdG8gbmZzNF9wcm9jX2dldF9sZWFzZV90aW1lKCkg
YW5kIHRoZSBjb3JyZXNwb25kaW5nIHhkcg0KY29kZSBzbyBpdCdzIHByb2JhYmx5IHNhZmUgdG8g
bW92ZSBhbGwgdGhpcyBvdXQgdG9vLg0KDQpBbm5hDQoNCj4gKwlpZiAoc3RhdHVzID09IDApIHsN
Cj4gKwkJbmZzNF9zZXRfbGVhc2VfcGVyaW9kKGNscCwgZnNpbmZvLmxlYXNlX3RpbWUgKiBIWiwN
Cj4gbm93KTsNCj4gKwkJbmZzNF9zY2hlZHVsZV9zdGF0ZV9yZW5ld2FsKGNscCk7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIHN0YXR1czsNCj4gK30NCj4gKw0KPiAgaW50IG5mczRfaW5pdF9jbGll
bnRpZChzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwLCBjb25zdCBzdHJ1Y3QgY3JlZA0KPiAqY3JlZCkN
Cj4gIHsNCj4gIAlzdHJ1Y3QgbmZzNF9zZXRjbGllbnRpZF9yZXMgY2xpZCA9IHsNCj4gQEAgLTI4
NiwyNyArMzA3LDYgQEAgc3RhdGljIGludCBuZnM0X2JlZ2luX2RyYWluX3Nlc3Npb24oc3RydWN0
DQo+IG5mc19jbGllbnQgKmNscCkNCj4gIA0KPiAgI2lmIGRlZmluZWQoQ09ORklHX05GU19WNF8x
KQ0KPiAgDQo+IC1zdGF0aWMgaW50IG5mczRfc2V0dXBfc3RhdGVfcmVuZXdhbChzdHJ1Y3QgbmZz
X2NsaWVudCAqY2xwKQ0KPiAtew0KPiAtCWludCBzdGF0dXM7DQo+IC0Jc3RydWN0IG5mc19mc2lu
Zm8gZnNpbmZvOw0KPiAtCXVuc2lnbmVkIGxvbmcgbm93Ow0KPiAtDQo+IC0JaWYgKCF0ZXN0X2Jp
dChORlNfQ1NfQ0hFQ0tfTEVBU0VfVElNRSwgJmNscC0+Y2xfcmVzX3N0YXRlKSkgew0KPiAtCQlu
ZnM0X3NjaGVkdWxlX3N0YXRlX3JlbmV3YWwoY2xwKTsNCj4gLQkJcmV0dXJuIDA7DQo+IC0JfQ0K
PiAtDQo+IC0Jbm93ID0gamlmZmllczsNCj4gLQlzdGF0dXMgPSBuZnM0X3Byb2NfZ2V0X2xlYXNl
X3RpbWUoY2xwLCAmZnNpbmZvKTsNCj4gLQlpZiAoc3RhdHVzID09IDApIHsNCj4gLQkJbmZzNF9z
ZXRfbGVhc2VfcGVyaW9kKGNscCwgZnNpbmZvLmxlYXNlX3RpbWUgKiBIWiwNCj4gbm93KTsNCj4g
LQkJbmZzNF9zY2hlZHVsZV9zdGF0ZV9yZW5ld2FsKGNscCk7DQo+IC0JfQ0KPiAtDQo+IC0JcmV0
dXJuIHN0YXR1czsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZvaWQgbmZzNDFfZmluaXNoX3Nlc3Np
b25fcmVzZXQoc3RydWN0IG5mc19jbGllbnQgKmNscCkNCj4gIHsNCj4gIAljbGVhcl9iaXQoTkZT
NENMTlRfTEVBU0VfQ09ORklSTSwgJmNscC0+Y2xfc3RhdGUpOw0K
