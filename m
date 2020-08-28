Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C7256260
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1VNO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 17:13:14 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:55350
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbgH1VNK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Aug 2020 17:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUtuZZtHpD0BM+dqjzPUzBWtDThRDpbT92zQdJgv61ASxsUVjPZ24gyXGyU5TJMAqcFv29sv8RQfELLHgcKfQZapmWxXUM2FNwBWqtVfUt5WDDM07DaNjgreUyTAe03H1E4QkFny08Q0fN66Zpze/EXRlRkbg836BkOUgDEJojtz7St+TBYV5w2eAX5SptYmg+O/VU0SH37pP+ro6h5qi2Jn6tqkmjOdHrn1ycApbDjP9HffV+gCNRuz5dGGMTg1Abo9UEkYJp+EVlQj3RkHapiF+rAJInWjQLG534NF1ak8LBMrShmXn4lUtmKjYtT7g61AplHXxNcLw+8lQ3qL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKQGjHWBhPhubi70ZDiklAcSykvSfiUxHxYF4Rp+8pg=;
 b=Ldq+YA/fhywtBDvgnBgyqzW5H2BmHkrBUBuTUsEpGpSuWDrT1Hsj4/qdirk1u3YT8B7FWTRFuWNXOKeRquUD+ttWBLWwVoYiGAzjpVDrW5MklSDtDH72Ea6+OfT6SpzXBeF1VExjFA/v8QJ+i2p1ULlAdOc0KQZeHDYMqQeNmPZwanBTVCQCBvXi+28T0f2Cf2xh+BrXviPk8vhn/C/fxjZm1zwCJowYKSAQjEK0yOOr3rngA5ixu8VghN190NHVtnRcEQ5jSstSd5b2+0n7v46QfaTGnupF4e4+RsxbXlvBmDo0lOwARg2Wp0ibN6oryOXVBC9RT1o7u29cPDryfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKQGjHWBhPhubi70ZDiklAcSykvSfiUxHxYF4Rp+8pg=;
 b=XBqA/tp13xy38DQHD6AOw0acoD9OFhLT47iGcTaZIItylOoSsiuIxGQPKngSGDgQN5umhlZisc+bCbnXtjwJIDx1GVUNJXAD5KGSN0NKDEQMSDHcx+TghWRAdYQkyeL5/SINGwcN905MinnHz26x+tRKQ8O8crFkk34Nm80S0KY=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3461.namprd13.prod.outlook.com (2603:10b6:610:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Fri, 28 Aug
 2020 21:13:07 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3348.005; Fri, 28 Aug 2020
 21:13:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFS: Zero-stateid SETATTR should first return
 delegation
Thread-Topic: [PATCH v1] NFS: Zero-stateid SETATTR should first return
 delegation
Thread-Index: AQHWfXWajEjc3MEXOEudAjC+XP9kGqlOBR0A
Date:   Fri, 28 Aug 2020 21:13:07 +0000
Message-ID: <f5827110d3627096bdd4c07060876e69089a8d87.camel@hammerspace.com>
References: <159864470513.1031951.14868951913532221090.stgit@manet.1015granger.net>
In-Reply-To: <159864470513.1031951.14868951913532221090.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.124.247.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92c1aefe-9235-46e7-e890-08d84b97292a
x-ms-traffictypediagnostic: CH2PR13MB3461:
x-microsoft-antispam-prvs: <CH2PR13MB3461911326A3C77D3924B5B6B8520@CH2PR13MB3461.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PRKGt0gGNKaOK/9BCKklACGgvKiiIWoo1dC/31nZlBmFwUm4va0mXUgaHecxgml/s0I0rJbQBky8HdpP5JudeABQvbl6lFRl4qhLfV7x0nTQ3xZ4uvVDPO9oDjdNAFtVb/6LXvaKzeYqrpYosMM/yII8fUXCOwsL2kMOVB78Mh6dyvB4uI1XYuMbZtqguN+//LK/u1Qo+uDDKcePC7QvCYyMTVE49tseZEQYlN8UYeUQCd5zqOhx6Vcf9XFZPRMbf6+ARQYdbKQtAFL2vD3W48xS585ULQ0NjVRPpG42JbDxjwNNyg/V8k8bojdp4uhcFi4DteWnqjgeOOYxSrpFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(346002)(376002)(136003)(366004)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(86362001)(36756003)(4326008)(6506007)(83380400001)(5660300002)(316002)(478600001)(2906002)(6512007)(110136005)(8676002)(71200400001)(8936002)(2616005)(186003)(6486002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8aKzsey0z6bWa7uTlrRiY8+ERET0HtthBWB68OphTXCN1qsAzYa8c56RT6yC9ykTs8KuvSZPwL5OAcXk9uBty9cm1fJTq+Se3UuxdXoFUs1LGWNfT3LsG93QIX86JUIYQk+RLIRQj8n2ijyZ4klGIzNnHXOf9wMQJYXGtw6DiT6h1bkaUiVKo7cji7nRvWn7Gva60ARNdwp4uhOTbQtFZfYcKc2iWjOhIe+tJCfVB+lnM0XMy9pMBeZXf/Im8UjdDYRD9xxRLM80pt+G5aWMTH3/vRSD9NQ8+Jkwe7XSlK51RGHWNq+FtnxFkSHgCgXGSxJq5mw9b6iqWjfOQJ+d+MzljhlIJ8RabQWyYsooZeH9xqe6/C+KQfc8DPV6AOzYPHzdal4766+IVdThfsEMZVAfZwp2b91lmAoJlfvmE1VVMjciYThXmZgulkNZ6jweG5J9pCiPfQ0L/kT4VPpie0SfdlyjdNA0OIZcTb3eGzYbSF2S9Gr4TtOUU99O+rwhIyVCpgNdcvC7++rk+S6OcwqvulZMuI6MrlWs3BFvtBz/jQLDTslQM55+ELO7EvmBM5jf/Nu+bOvBqqh0bYrzY+48OD5SBVu1tWW3ATK4ISjsXHnl8Tt8hwepRmsmK5OB2wLFsVkADqoJnb8JDzo/Lw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <219642899F771B4BB7C2577BF1DED2EF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1aefe-9235-46e7-e890-08d84b97292a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 21:13:07.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxYgvchIk2l1mkB4h7QOZ8J8/iX2CkmLiAIQfps/rr9+TIVGqLnnM+kM3VuC58x742WSxdmQ+r1h0chOTDcGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3461
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA4LTI4IGF0IDE1OjU4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SWYgYSB3cml0ZSBkZWxlZ2F0aW9uIGlzbid0IGF2YWlsYWJsZSwgdGhlIExpbnV4IE5GUyBjbGll
bnQgdXNlcw0KPiBhIHplcm8tc3RhdGVpZCB3aGVuIHBlcmZvcm1pbmcgYSBTRVRBVFRSLg0KPiAN
Cj4gSWYgdGhhdCBjbGllbnQgaGFwcGVucyB0byBob2xkIGEgcmVhZCBkZWxlZ2F0aW9uLCB0aGUg
c2VydmVyIHdpbGwNCj4gcmVjYWxsIGl0IGltbWVkaWF0ZWx5LCByZXN1bHRpbmcgaW4gYSBzaG9y
dCBkZWxheSB3aGlsZSB0aGUNCj4gQ0JfUkVDQUxMIG9wZXJhdGlvbiBpcyBkb25lLiBPcHRpbWl6
ZSBvdXQgdGhpcyBkZWxheSBieSBoYXZpbmcgdGhlDQo+IGNsaWVudCByZXR1cm4gYW55IGRlbGVn
YXRpb24gaXQgbWF5IGhvbGQgb24gYSBmaWxlIGJlZm9yZSBpc3N1aW5nIGENCj4gU0VUQVRUUih6
ZXJvLXN0YXRlaWQpIG9uIHRoYXQgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9uZnM0cHJvYy5j
IHwgICAgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IGRi
ZDAxNTQ4MzM1Yi4uNTNhNTYyNTBjZjRiIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2Mu
Yw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtMzMxNCw2ICszMzE0LDcgQEAgc3Rh
dGljIGludCBfbmZzNF9kb19zZXRhdHRyKHN0cnVjdCBpbm9kZQ0KPiAqaW5vZGUsDQo+ICAJCQln
b3RvIHplcm9fc3RhdGVpZDsNCj4gIAl9IGVsc2Ugew0KPiAgemVyb19zdGF0ZWlkOg0KPiArCQlu
ZnM0X2lub2RlX3JldHVybl9kZWxlZ2F0aW9uKGlub2RlKTsNCj4gIAkJbmZzNF9zdGF0ZWlkX2Nv
cHkoJmFyZy0+c3RhdGVpZCwgJnplcm9fc3RhdGVpZCk7DQo+ICAJfQ0KPiAgCWlmIChkZWxlZ2F0
aW9uX2NyZWQpDQo+IA0KDQpUaGlzIHNob3VsZCBub3QgYmUgbmVlZGVkIGZvciBORlN2NC4xIG9y
IGdyZWF0ZXIuIE9ubHkgTkZTdjQuMCBpcw0KaW5jYXBhYmxlIG9mIGlkZW50aWZ5aW5nIHRoZSBj
YWxsZXIgYW5kIHJlY29nbmlzaW5nIHRoYXQgaXQgaXMgdGhlDQpob2xkZXIgb2YgdGhlIGRlbGVn
YXRpb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
