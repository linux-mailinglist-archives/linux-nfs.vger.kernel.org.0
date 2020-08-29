Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEE256A52
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgH2VRw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 17:17:52 -0400
Received: from mail-eopbgr750090.outbound.protection.outlook.com ([40.107.75.90]:47745
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbgH2VRt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 29 Aug 2020 17:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYwcArq9q35fmO2y0FyO4UKeVQXgisuSOHgszJflQZOS7ftLV1Z7Zle1hJNvCWzRhm9zN1aSSk3HpSbEoLUClDMArqKZJjGo/CCMWkU92brh4lnfSOjfj9kmU+eafuhkbxrrxG8efZzI5KQV7DYNEkKT7umuSaL3v9fUnDUD7L/sdQsgpMgQ0mBEUR+OtL+P9PWGdJTtZpOT/g19ULhmD8BLWv/4k8e2NzIKuFxED7zp+TWP+xLgnpZ20g9ZI4wOujzJ17ytlVO/MP+mDcpW5hmloCgHodNMFpFY/6BHSPynBRCzkrg631khd63llJdJahnkiJlg1iBQ50RkAr1utQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evE4cIKGy5pdAxIx47LGceUNG4cktnVAyNkps0Hu0nU=;
 b=eheuf53J2FqVaovFO/qsUtDi1XpjQ/9Mm2f5xQTAT8kAGcNglXZaa3QA1XLcTPErLbNr5h6ZF3ZAFegx5z0fUE/8Lc7C4mGDh+enBS0xLbHtM1yOG5I0PupJaLRmOX1xv2Z9JEX2Ki37BCoF93kMVcdvv+N1MBryk80fGrrvvpRnPeLo6RSpyyvQOlAZD2COaC0s0GQ6UpeuXOHw6/5NN7r/bMYFi+/m7qGc48Y2IuT0e4qVzs9Eyn2N+8SOjolRN8SnyRe2ISOrP/GkzWNivoF6pu+66I6qzEd7kRFj3+dmVGiNXEY6DMxwyJWtrQq0yiRZtvsUa3JI5WygOLH5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evE4cIKGy5pdAxIx47LGceUNG4cktnVAyNkps0Hu0nU=;
 b=OQBsl8oncpVwFFFMxKof7s+ZqRJWFAn7FAnM+lX2Vgg5IEB9ZYO18qVUaxd09QO22AewTIlR7475khpw3KeJ841qG2w2/T6ZM7uEV3u0p1RJuJoLkEthDkKoECRjcUXUT56XR3BhA1e+uPqcS26gYrQnzK1EPXrK56svOX1BjJg=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3336.namprd13.prod.outlook.com (2603:10b6:610:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Sat, 29 Aug
 2020 21:17:45 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3348.011; Sat, 29 Aug 2020
 21:17:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Zero-stateid SETATTR should first return
 delegation
Thread-Topic: [PATCH v2] NFS: Zero-stateid SETATTR should first return
 delegation
Thread-Index: AQHWfigV+o3sJiBz30CDvRqJWixucKlPl1iA
Date:   Sat, 29 Aug 2020 21:17:45 +0000
Message-ID: <9e28664e90438384be654a39b23c6d517959c15a.camel@hammerspace.com>
References: <159872131590.1096729.3952588635826859724.stgit@manet.1015granger.net>
In-Reply-To: <159872131590.1096729.3952588635826859724.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.124.247.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 421c539e-9aba-4f97-431d-08d84c60f91a
x-ms-traffictypediagnostic: CH2PR13MB3336:
x-microsoft-antispam-prvs: <CH2PR13MB33362D67C636DC6793ACCD68B8530@CH2PR13MB3336.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzAe2OkkyICRMAypJflilMjWffL8Dz47dODrbmJdYhhq2w/Se93HnVflJ7PgYO6tevl8Fab04NMRMKBlczaCy5oAcd1eqGpzw/+j3HqqvtL7Ae8QtrlL3GPLUUPQcYityTgyD8VJsUVb0H7H5bJSxw1RaoB0Y+YZsjJLgp50XveobgRooOR5wJvsnKoEvGpF8Lj4XQLfCNkOCuJpCiI4GDGrIHAVT+DtsYDZgRBpo20ayOJYMbVtM0ZPswdkv2SOhEvb7hc1xPVPpM73Y470/R3qrengz2OTvXs7JNEPkimPLEpA25uhavigFsRkhemb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(8676002)(6506007)(186003)(508600001)(8936002)(6512007)(2906002)(4326008)(6486002)(76116006)(66476007)(71200400001)(83380400001)(26005)(66556008)(2616005)(110136005)(5660300002)(66946007)(64756008)(86362001)(66446008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dxIQt0jq0LkymnTGPR6G6CZAxlxO/t3vj9W3BrYILcQp0odVZwG7rhhIza6SYJQiaSv94KKsL5IL2Diaie44bmEkICoiEGl2VitJ4qTKQ83ecr1CepXOXQK3khHSjKVnTNFv95KtFkdnWinSD5f+y1PVGD7F+3QPNdRtrtczcriI90nVdyiiYD7UgXt6qQinMNniFKZskMDRRoYJiqu+gNkw97iNLxtv4bjMYqNkK5s/VQCRvXZ0hqi0cp56UVIXTbOLC38fIyefd+/vM3yjh0VEhqJ8Km12cxeJMh0nd5QZNQ+Ey1WSOHFbHZNpYUKckMctF4I2T/R51JCSAv2zxGrG626pS1jDcL7iBFDhXV+2po5nFLDfH4Bwtx3ipayHctmYZSE+wglIcVQoWFvQIRzc01qkVAKM6anZ9S1m1U9YijwyXrRshXTIbziVD0gqW6/rB1cNVElhDvnhfe+3SIFHrn7MOb2DVYwMrtPCh1fKJZWka0ZzRejjEIcSKMHf3gnz4QAI/LFkqcNZ2ynY1bYic8+lSQ26vD0JCeAzxFHRXou0bZYLXX4hyh3j8gDJlpZSYWpc9L6muRj7Uz4bvusa1/amZPAbUnMEjf41aMGlZiolMjOMjJPDdPUbb1KhzJ9+iQbkFFqTJ8F9a0wp0g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A596A7776BD31C48955463DB79825727@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421c539e-9aba-4f97-431d-08d84c60f91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2020 21:17:45.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRq3dC2TIsH9vD9KXWXfz+US6H4hJVNkWusJlLMpUmpsRYBF+jYFE89QinJ0PjLnqjLZYhxSUclq+V28nj/BHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3336
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIwLTA4LTI5IGF0IDEzOjE2IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SWYgYSB3cml0ZSBkZWxlZ2F0aW9uIGlzbid0IGF2YWlsYWJsZSwgdGhlIExpbnV4IE5GUyBjbGll
bnQgdXNlcw0KPiBhIHplcm8tc3RhdGVpZCB3aGVuIHBlcmZvcm1pbmcgYSBTRVRBVFRSLg0KPiAN
Cj4gTkZTdjQuMCBwcm92aWRlcyBubyBtZWNoYW5pc20gZm9yIGFuIE5GUyBzZXJ2ZXIgdG8gbWF0
Y2ggc3VjaCBhDQo+IHJlcXVlc3QgdG8gYSBwYXJ0aWN1bGFyIGNsaWVudC4gSXQgcmVjYWxscyBh
bGwgZGVsZWdhdGlvbnMgZm9yIHRoYXQNCj4gZmlsZSwgZXZlbiBkZWxlZ2F0aW9ucyBoZWxkIGJ5
IHRoZSBjbGllbnQgaXNzdWluZyB0aGUgcmVxdWVzdC4gSWYNCj4gdGhhdCBjbGllbnQgaGFwcGVu
cyB0byBob2xkIGEgcmVhZCBkZWxlZ2F0aW9uLCB0aGUgc2VydmVyIHdpbGwNCj4gcmVjYWxsIGl0
IGltbWVkaWF0ZWx5LCByZXN1bHRpbmcgaW4gYW4gTkZTNEVSUl9ERUxBWS9DQl9SRUNBTEwvDQo+
IERFTEVHUkVUVVJOIHNlcXVlbmNlLg0KPiANCj4gT3B0aW1pemUgb3V0IHRoaXMgcGlwZWxpbmUg
YnViYmxlIGJ5IGhhdmluZyB0aGUgY2xpZW50IHJldHVybiBhbnkNCj4gZGVsZWdhdGlvbnMgaXQg
bWF5IGhvbGQgb24gYSBmaWxlIGJlZm9yZSBpdCBpc3N1ZXMgYQ0KPiBTRVRBVFRSKHplcm8tc3Rh
dGVpZCkgb24gdGhhdCBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRwcm9jLmMgfCAgICAy
ICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBDaGFuZ2VzIHNp
bmNlIHYxOg0KPiAtIFJldHVybiB0aGUgZGVsZWdhdGlvbiBvbmx5IGZvciBORlN2NC4wIG1vdW50
cw0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9j
LmMNCj4gaW5kZXggZGJkMDE1NDgzMzViLi5iY2E3MjQ1ZjFlNzggMTAwNjQ0DQo+IC0tLSBhL2Zz
L25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC0zMzE0LDYg
KzMzMTQsOCBAQCBzdGF0aWMgaW50IF9uZnM0X2RvX3NldGF0dHIoc3RydWN0IGlub2RlDQo+ICpp
bm9kZSwNCj4gIAkJCWdvdG8gemVyb19zdGF0ZWlkOw0KPiAgCX0gZWxzZSB7DQo+ICB6ZXJvX3N0
YXRlaWQ6DQo+ICsJCWlmIChzZXJ2ZXItPm5mc19jbGllbnQtPmNsX21pbm9ydmVyc2lvbiA9PSAw
KQ0KPiArCQkJbmZzNF9pbm9kZV9yZXR1cm5fZGVsZWdhdGlvbihpbm9kZSk7DQoNClNvLCB0aGUg
aW50ZW50aW9uIGlzIHRoYXQgbmZzNF9pbm9kZV9tYWtlX3dyaXRlYWJsZSgpIHRha2VzIGNhcmUg
b2YNCnRoaXMsIGFuZCBpbiBwcmluY2lwbGUgaXQgaXMgZG9uZSBpbiB0aGUgY2FzZXMgdGhhdCBt
YXR0ZXIgaW4NCm5mczRfcHJvY19zZXRhdHRyKCkuDQoNCkkgYWdyZWUgdGhhdCB0aGUgemVyb19z
dGF0ZWlkIGNhc2UgaXMgbm90IGN1cnJlbnRseSBiZWluZyB0YWtlbiBjYXJlDQpvZiwgYnV0IHRo
YXQgb25seSBtYXR0ZXJzIGZvciB0aGUgY2FzZSBvZiB0cnVuY2F0ZS4gU28gcGVyaGFwcyB3ZSBj
YW4NCmp1c3QgYWRkIGEgc2luZ2xlIGNhbGwgdG8gbmZzNF9pbm9kZV9tYWtlX3dyaXRlYWJsZSgp
IGFib3ZlIHRoZQ0KemVyb19zdGF0ZWlkIGxhYmVsIGluc3RlYWQgb2YgYWRkaW5nIHJlZHVuZGFu
Y3kgZm9yIGFsbCB0aGUgb3RoZXINCmNhc2VzPw0KDQo+ICAJCW5mczRfc3RhdGVpZF9jb3B5KCZh
cmctPnN0YXRlaWQsICZ6ZXJvX3N0YXRlaWQpOw0KPiAgCX0NCj4gIAlpZiAoZGVsZWdhdGlvbl9j
cmVkKQ0KPiANCj4gDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
