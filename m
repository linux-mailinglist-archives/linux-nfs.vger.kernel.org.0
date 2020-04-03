Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F251D19DEEF
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDCUAP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 16:00:15 -0400
Received: from mail-bn8nam12on2134.outbound.protection.outlook.com ([40.107.237.134]:25025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgDCUAP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Apr 2020 16:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+7tm1kK3yDEaI7JlEwmtzWHnxfVoRcxu5+RYjtIQG1qgSMN1P/Dsp07ASHUu8ea4h07phoMwngL8msMF2Luscj9fLbNnaleA6N/LHheS3RcQvmNBmFKCbjQ1GkSm6Z+Z0T/reEvxcW/nJx+Kn88VcVZcp69J3jDtJX90pcucTP708ozUlZw0UwJtQH5WKDn2kZenAE4+TS65mEGqmksULUeRQXhAcIM95pfNs86CvGxuI/rvtYOCCPJtRXwChC1Cco+yG4Tiuk+3rLI7/+kjuCp3xSG5fwdy5/M6+y8tWxEEaWtrMcZ5AVcE2nDSUtMLzTD4xGihqhUVuzsWgx+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id72Z9EWfzyzbtxKQf+uh0aUUit8o2MJQas+ALLKE8E=;
 b=N/esnumrK5NuwkPDcaCIvbjiVjh/gyX01t8hPE8pd1a33IyJ5Pym6nKHGEy+j+xnEqvvVsbfIBp5th+u8sfijyiQg7B2f0ASS3DWmi3LbX4gPFWbh4NT0tLUa5OZuiJBZZqKdGWGW7qb69v4zLSJjMxYrB+aPB7OAKKhEfGSocNrPnDR/KwMoic0xRvqKiIKD9ytyAqAdqRPXZhuM+5yKwHnoopI3MVoEZWD+l5+pkoWYcL3MdwpCOVaUGxTIeMz+I2icJBQX+bb61nT+3ox6bVRMcMbUO8bVg4WhqwG/FL/Y9VFuxNTZc3JOxEOrEEm+Cfn0GdlX6SLbqsriVY8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id72Z9EWfzyzbtxKQf+uh0aUUit8o2MJQas+ALLKE8E=;
 b=cmAoDxBckm/DHW49i/pcOrpdKUPgsJq5i9ib2bDfgWnjM4v+vEXsWcPQloVNfdjW4R9VeA+D7VdThM/qdQVb1InoYHG9n9UtjFVcM4wbaIl2UugIx59Ve9fHLdkYSVQZWbdm5TgHBQs3nYE+FADs8Z/AZ1nq1CluqyLcU/y2OVA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Fri, 3 Apr
 2020 20:00:11 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:00:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
Thread-Topic: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
Thread-Index: AQHWCe/8JD/KzSg5Vka4lHj4HknStqhn0RSA
Date:   Fri, 3 Apr 2020 20:00:11 +0000
Message-ID: <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
References: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
In-Reply-To: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 338533c5-139a-4980-c5ae-08d7d8099e33
x-ms-traffictypediagnostic: CH2PR13MB3814:
x-microsoft-antispam-prvs: <CH2PR13MB38146FD9E64030BC70565720B8C70@CH2PR13MB3814.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39830400003)(81166006)(36756003)(26005)(81156014)(66476007)(2906002)(478600001)(86362001)(5660300002)(71200400001)(66556008)(66946007)(8676002)(66446008)(316002)(110136005)(76116006)(64756008)(186003)(8936002)(6486002)(6512007)(91956017)(2616005)(6506007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 533Adov92f7GuZNGL1yYk6UcVD2KAu9GqcoJJYVGHeRTs5rxmVPWrKp+HPl8d9GlNwEc6MjIrqYzrekD/SNY9y9zp+xzEr6deADGYkBWcHfeis91Uu8oxxs51+xGNRwERb7UH0xBpHAvkHus0lb+g4C6LMv2yvz+mWN4EfGkJ3YOFgzZUdjeQ+rOpFp5PSvolbcy9JiPumgT1jZlJk9sJVwFEO3xPGe6PdioMgjgh3XV1iV4xdkhuDlGHT+71XKDlQ75J0wX7h3/zQGdhxjPP6iBJLYnYBG+CdbqlRRHqjzrSQIx51Dlcxn3Q4CSMTNTE/e+5mYLluusXKp7uLK93eMyn5WkTk6xM/YHGQw9IxfkX1YFlkr9p7VE9Ilpe4npzyndxd69+WBlDfcoppmn/fyOAeKgIEW5sHpG+nAK6JiPZCCWLJDiChGOsWJunIW2
x-ms-exchange-antispam-messagedata: NZWYn3g/3+glDV1Aufyi2gHqY0nVT1WhteaNuW85Mz0miI/33NryTlAgUkW98L86rpjHr2HiQM3QTPZnZnodbzWss/oeE6dnDd8wjwq6rtdDp9mOIlzpeutamAr5zxnyO7SjN8vOCn5R+9NSup2C1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F4601A743937048876D46E6515D005C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338533c5-139a-4980-c5ae-08d7d8099e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:00:11.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLf6PZ9qfuL4YfIUft8sb/ICQajVrrByAmt3fl/TQQOFkQ0WnlvVteJs7KD1CJAlpAfq5IF+OaYrD89ZDtBR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTAzIGF0IDE1OjQyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
Q29tbWl0IDM4MzI1OTFlNmZhNSAoIlNVTlJQQzogSGFuZGxlIGNvbm5lY3Rpb24gaXNzdWVzIGNv
cnJlY3RseSBvbg0KPiB0aGUgYmFjayBjaGFubmVsIikgaW50ZW5kZWQgdG8gbWFrZSBiYWNrY2hh
bm5lbCBSUENzIGZhaWwNCj4gaW1tZWRpYXRlbHkgd2hlbiB0aGVyZSBpcyBubyBmb3J3YXJkIGNo
YW5uZWwgY29ubmVjdGlvbi4gV2hhdCdzDQo+IGN1cnJlbnRseSBoYXBwZW5pbmcgaXMsIHdoZW4g
dGhlIGZvcndhcmQgY2hhbm5lbCBjb25uZWNpdG9uIGdvZXMNCj4gYXdheSwgYmFja2NoYW5uZWwg
b3BlcmF0aW9ucyBhcmUgY2F1c2luZyBoYXJkIGxvb3BzIGJlY2F1c2UNCj4gY2FsbF90cmFuc21p
dF9zdGF0dXMncyBTT0ZUQ09OTiBsb2dpYyBpZ25vcmVzIEVOT1RDT05OLg0KDQpXb24ndCBSUENf
VEFTS19OT0NPTk5FQ1QgZG8gdGhlIHJpZ2h0IHRoaW5nPyBJdCBzaG91bGQgY2F1c2UgdGhlDQpy
ZXF1ZXN0IHRvIGV4aXQgd2l0aCBhbiBFTk9UQ09OTiBlcnJvciB3aGVuIGl0IGhpdHMgY2FsbF9j
b25uZWN0KCkuDQoNCj4gDQo+IFRvIGF2b2lkIGNoYW5naW5nIHRoZSBiZWhhdmlvciBvZiBjYWxs
X3RyYW5zbWl0X3N0YXR1cyBpbiB0aGUNCj4gZm9yd2FyZCBkaXJlY3Rpb24sIG1ha2UgYmFja2No
YW5uZWwgUlBDcyByZXR1cm4gd2l0aCBhIGRpZmZlcmVudA0KPiBlcnJvciB0aGFuIEVOT1RDT05O
IHdoZW4gdGhleSBmYWlsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgbmV0L3N1bnJwYy94cHJ0cmRtYS9zdmNfcmRt
YV9iYWNrY2hhbm5lbC5jIHwgICAxNSArKysrKysrKysrLS0tLS0NCj4gIG5ldC9zdW5ycGMveHBy
dHNvY2suYyAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYgKysrKy0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBJJ20gcGxheWlu
ZyB3aXRoIHRoaXMgZml4LiBJdCBzZWVtcyB0byBiZSByZXF1aXJlZCBpbiBvcmRlciB0byBnZXQN
Cj4gS2VyYmVyb3MgbW91bnRzIHRvIHdvcmsgdW5kZXIgbG9hZCB3aXRoIE5GU3Y0LjEgYW5kIGxh
dGVyIG9uIFJETUEuDQo+IA0KPiBJZiB0aGVyZSBhcmUgbm8gb2JqZWN0aW9ucywgSSBjYW4gY2Fy
cnkgdGhpcyBmb3IgdjUuNy1yYyAuLi4NCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJw
Yy94cHJ0cmRtYS9zdmNfcmRtYV9iYWNrY2hhbm5lbC5jDQo+IGIvbmV0L3N1bnJwYy94cHJ0cmRt
YS9zdmNfcmRtYV9iYWNrY2hhbm5lbC5jDQo+IGluZGV4IGQ1MTBhM2ExNWQ0Yi4uYjhhNzJkN2Zi
Y2MyIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1hL3N2Y19yZG1hX2JhY2tjaGFu
bmVsLmMNCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS9zdmNfcmRtYV9iYWNrY2hhbm5lbC5j
DQo+IEBAIC0yMDcsMTEgKzIwNywxNiBAQCBycGNyZG1hX2JjX3NlbmRfcmVxdWVzdChzdHJ1Y3Qg
c3ZjeHBydF9yZG1hDQo+ICpyZG1hLCBzdHJ1Y3QgcnBjX3Jxc3QgKnJxc3QpDQo+ICANCj4gIGRy
b3BfY29ubmVjdGlvbjoNCj4gIAlkcHJpbnRrKCJzdmNyZG1hOiBmYWlsZWQgdG8gc2VuZCBiYyBj
YWxsXG4iKTsNCj4gLQlyZXR1cm4gLUVOT1RDT05OOw0KPiArCXJldHVybiAtRUhPU1RVTlJFQUNI
Ow0KPiAgfQ0KPiAgDQo+IC0vKiBTZW5kIGFuIFJQQyBjYWxsIG9uIHRoZSBwYXNzaXZlIGVuZCBv
ZiBhIHRyYW5zcG9ydA0KPiAtICogY29ubmVjdGlvbi4NCj4gKy8qKg0KPiArICogeHBydF9yZG1h
X2JjX3NlbmRfcmVxdWVzdCAtIHNlbmQgYW4gUlBDIGJhY2tjaGFubmVsIENhbGwNCj4gKyAqIEBy
cXN0OiBSUEMgQ2FsbCBpbiBycV9zbmRfYnVmDQo+ICsgKg0KPiArICogUmV0dXJuczoNCj4gKyAq
CSUwIGlmIHRoZSBSUEMgbWVzc2FnZSBoYXMgYmVlbiBzZW50DQo+ICsgKgklLUVIT1NUVU5SRUFD
SCBpZiB0aGUgQ2FsbCBjb3VsZCBub3QgYmUgc2VudA0KPiAgICovDQo+ICBzdGF0aWMgaW50DQo+
ICB4cHJ0X3JkbWFfYmNfc2VuZF9yZXF1ZXN0KHN0cnVjdCBycGNfcnFzdCAqcnFzdCkNCj4gQEAg
LTIyNSwxMSArMjMwLDExIEBAIHhwcnRfcmRtYV9iY19zZW5kX3JlcXVlc3Qoc3RydWN0IHJwY19y
cXN0DQo+ICpycXN0KQ0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmc3hwcnQtPnhwdF9tdXRleCk7DQo+
ICANCj4gLQlyZXQgPSAtRU5PVENPTk47DQo+ICsJcmV0ID0gLUVIT1NUVU5SRUFDSDsNCj4gIAly
ZG1hID0gY29udGFpbmVyX29mKHN4cHJ0LCBzdHJ1Y3Qgc3ZjeHBydF9yZG1hLCBzY194cHJ0KTsN
Cj4gIAlpZiAoIXRlc3RfYml0KFhQVF9ERUFELCAmc3hwcnQtPnhwdF9mbGFncykpIHsNCj4gIAkJ
cmV0ID0gcnBjcmRtYV9iY19zZW5kX3JlcXVlc3QocmRtYSwgcnFzdCk7DQo+IC0JCWlmIChyZXQg
PT0gLUVOT1RDT05OKQ0KPiArCQlpZiAocmV0IDwgMCkNCj4gIAkJCXN2Y19jbG9zZV94cHJ0KHN4
cHJ0KTsNCj4gIAl9DQo+ICANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHNvY2suYyBi
L25ldC9zdW5ycGMveHBydHNvY2suYw0KPiBpbmRleCAxN2NiOTAyZTUxNTMuLjkyYTM1OGZkMmZm
MCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ICsrKyBiL25ldC9zdW5y
cGMveHBydHNvY2suYw0KPiBAQCAtMjU0Myw3ICsyNTQzLDkgQEAgc3RhdGljIGludCBiY19zZW5k
dG8oc3RydWN0IHJwY19ycXN0ICpyZXEpDQo+ICAJcmVxLT5ycV94dGltZSA9IGt0aW1lX2dldCgp
Ow0KPiAgCWVyciA9IHhwcnRfc29ja19zZW5kbXNnKHRyYW5zcG9ydC0+c29jaywgJm1zZywgeGRy
LCAwLCBtYXJrZXIsDQo+ICZzZW50KTsNCj4gIAl4ZHJfZnJlZV9idmVjKHhkcik7DQo+IC0JaWYg
KGVyciA8IDAgfHwgc2VudCAhPSAoeGRyLT5sZW4gKyBzaXplb2YobWFya2VyKSkpDQo+ICsJaWYg
KGVyciA8IDApDQo+ICsJCXJldHVybiAtRUhPU1RVTlJFQUNIOw0KPiArCWlmIChzZW50ICE9ICh4
ZHItPmxlbiArIHNpemVvZihtYXJrZXIpKSkNCj4gIAkJcmV0dXJuIC1FQUdBSU47DQo+ICAJcmV0
dXJuIHNlbnQ7DQo+ICB9DQo+IEBAIC0yNTY3LDcgKzI1NjksNyBAQCBzdGF0aWMgaW50IGJjX3Nl
bmRfcmVxdWVzdChzdHJ1Y3QgcnBjX3Jxc3QNCj4gKnJlcSkNCj4gIAkgKi8NCj4gIAltdXRleF9s
b2NrKCZ4cHJ0LT54cHRfbXV0ZXgpOw0KPiAgCWlmICh0ZXN0X2JpdChYUFRfREVBRCwgJnhwcnQt
PnhwdF9mbGFncykpDQo+IC0JCWxlbiA9IC1FTk9UQ09OTjsNCj4gKwkJbGVuID0gLUVIT1NUVU5S
RUFDSDsNCj4gIAllbHNlDQo+ICAJCWxlbiA9IGJjX3NlbmR0byhyZXEpOw0KPiAgCW11dGV4X3Vu
bG9jaygmeHBydC0+eHB0X211dGV4KTsNCj4gDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
