Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAC2B3C3F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 05:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKPEu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Nov 2020 23:50:57 -0500
Received: from mail-bn8nam11on2136.outbound.protection.outlook.com ([40.107.236.136]:54172
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbgKPEu4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Nov 2020 23:50:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3dEPy9LbI+Yiwtm7Z1FTEB9TeLw+MQIMxU5Dn/E7yeCaaSBiQCiki2rCJhn4brJB5R9mBcwmD53uEExJTuYsmZcdS8ou9G2Wbn/I8R3MI1Q3y4jZmyomhqiM67GzLDi7/4F/0MfpCLTrV2lh1GL/BQBfj+L0u1zWQaa/4Vkh0zBw87SDD8oIzM2iORDDeZ5Mc2R26/De2oMn0mD7BU9CnwCdqr47cI9PdIViMDkWuSLm1OiTzfCrCm7nT7o9TT4sPF2mqWpZcMTH191cwHepTb/GxAuUWVBujhqxnD6izNZS9FX4Cg4uJ8AIgT56lL/5z7IUw2zExOMrDizIYxLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vpGkOqg9TdyQPZG9Itmp/btiHM33HCJ3ExhL6nwHYc=;
 b=C3CmY7jrO7H45PcxeVjVsY42l6pB/xA7ejdwxBcxyByLNn05cbUhwcN1tWuyI+SHhKJ/HITrfCCHKFCTLDqB5ZHL80O5DkNju+/yPi3l/tIl5b2YgbpKRFcMYaU5NyLg6FwyHbS+i7qmUz6/ZQoyfpsBVbvy1lKb+BEg7whFiRfgozv/BfUj3UZ5KIMkA1JBjDrhrIVArAOY3wGz+pKXjzkhjtwHu3kDL9cuPz2LA+EOwxhGwt6CpbpW2IwVZNJbCHpWTynjcwns5xA5/acOqW+x2zDbEZeZuGK0zCyn1a7UC2mCSLN2wKAZ4bn5XPJhLcXjdPKyqVvXjRg1Gut+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vpGkOqg9TdyQPZG9Itmp/btiHM33HCJ3ExhL6nwHYc=;
 b=d1QGRE68q5UbZImVmHryhhi/QlINjZpIP1Cm/0oHjaqQRXXJNCviwParOGOkQ5kKiIAJAZS4OLNmJ2taeEtevqWy9ooBsigTfu8qFhV2SXS8I0lMxG3EqRhB/HGmSJ5v3kWZ99oozhvG3f/B/6v6Jymau3JmoAgE6RvHzSzDqQI=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3070.namprd13.prod.outlook.com (2603:10b6:208:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.12; Mon, 16 Nov
 2020 04:50:53 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Mon, 16 Nov 2020
 04:50:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
Thread-Topic: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
Thread-Index: AQHWu8R1m5j20T9EEUSCuq70JTb/pqnKKisAgAAEXACAAAINgA==
Date:   Mon, 16 Nov 2020 04:50:52 +0000
Message-ID: <d208c9c085d8abf27a764e31a61e98f9c3743675.camel@hammerspace.com>
References: <87361aovm3.fsf@notabene.neil.brown.name>
         <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
         <87zh3hoqrx.fsf@notabene.neil.brown.name>
In-Reply-To: <87zh3hoqrx.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 408ee660-1bb1-49ee-930b-08d889eb3281
x-ms-traffictypediagnostic: MN2PR13MB3070:
x-microsoft-antispam-prvs: <MN2PR13MB307034402CDC188D8034DD63B8E30@MN2PR13MB3070.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+KQDQdztAJVhJvozvNEkE7QuQKDOrTVX/5CotrcdLd5Xj9MpgqxjsQNzkUXYQorRGVa50VhR2J6Bbfag6vBVKPM1dWel5V9XTw3YW7nBviwz37N67HX3Y9EApjiXXKny258WAqhlaUggrEUPDt0LxVAm4/pfJiDt5Af5q14y9wPprANs2j9NgET7szdQiwS2YSRZhCS/3b0izCrdU3dDZ+mxclCZrDOw2TVY95d4+CRb9GzL4qvq1CshMAZ4KxQl+yCDiUoTlzsGe41BlaZO/U8vcmxG36onsm4ZgTjnAbQT9NOpriMWpcFls+kkvakN6xYu5IxpK6Bam+sZlG7ag3lWc3lueGUEmlO7HP8gqC7slVHFJHGSU6cvY0sUCPmjjbJVINShR4urd0DNTKDNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39830400003)(366004)(54906003)(8936002)(110136005)(5660300002)(76116006)(316002)(91956017)(6506007)(186003)(2906002)(86362001)(6486002)(15974865002)(26005)(6512007)(66946007)(64756008)(2616005)(66446008)(66556008)(66476007)(36756003)(71200400001)(4001150100001)(8676002)(478600001)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T07XXLhHGfCFbxM7gvHGnAeQncPvl8fym4TZ16PP7H2x3BWS+t7xLa9QPbgmvb1H+lwX7R4ftZpKJmGc91kAQqE14Y/URmSyvqDjt/NxC6DlMiPADGXrV1Ugg599A8EVq0Q7YdkIdbXwXWRoZPFP0eRxFH6O6u5V9gRg25Mht22H+1kjzEhBOkr+1PgC5ktmhGj/AEBpx+KhfhDgenAO//4XX8ucboGXf9HBaCC/ymqegdolfi3af6cXPSdy1sDFpuW27ZGEBKTWHa0sgtpwjHgxC+azSxAwysF80jktpnKTiPq65IHOSG9fVE+oqCCS3NjPWhYmw0kiXbBjp4qThLpqS+hWbRyO+0VbIhgKYthmq0yr2961qdmRKHqJrtcqJl4nJ23BBSxES9pCP2lLqn6KXi24OweVCzsk8NIrwjQ67Snf21lCdVXtxK+85F+mZd3vAeUwgZOWlgPgUk2xlDJRhw0gBM+Oba56cp4IOKEtWeeEhBt237PaWzVal2cmo025U7WeYLgwGBTv1a7l4HBGRnR3Ew+t5G8feZMsOlJY/kk23UIUt40qDupGXv/mdHSi+KNvf1F2J9upLkGHusM9IurU5h88Z9i19G/djMCzUc4MtIQiTXhRT3iFGA9eOvnVpEAhd8jUp6jHZZe1Fw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <99172E9ACAEBBF43B90BD861C7B1FB40@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408ee660-1bb1-49ee-930b-08d889eb3281
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 04:50:52.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vov9aAFLC1PTTOnYNroARtyakyPLmxgMF1D6lme9HG6Zi2f7qUQ2qi+mHkiDI5ZWBa3TaF+7z/76FKAS5oIy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3070
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTE2IGF0IDE1OjQzICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgTm92IDE2IDIwMjAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24gTW9u
LCAyMDIwLTExLTE2IGF0IDEzOjU5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiANCj4g
PiA+IFByaW9yIHRvIGNvbW1pdCA1Y2ViOWQ3ZmRhYWYgKCJORlM6IFJlZmFjdG9yDQo+ID4gPiBu
ZnNfbG9va3VwX3JldmFsaWRhdGUoKSIpDQo+ID4gPiBhbmQgZXJyb3IgZnJvbSBuZnNfbG9va3Vw
X3ZlcmlmeV9pbm9kZSgpIG90aGVyIHRoYW4gLUVTVEFMRSB3b3VsZA0KPiA+ID4gcmVzdWx0DQo+
ID4gPiBpbiBuZnNfbG9va3VwX3JldmFsaWRhdGUoKSByZXR1cm5pbmcgdGhhdCBlcnJvciBjb2Rl
ICgtRVNUQUxFIGlzDQo+ID4gPiBtYXBwZWQNCj4gPiA+IHRvIHplcm8pLg0KPiA+ID4gU2luY2Ug
dGhhdCBjb21taXQsIGFsbCBlcnJvcnMgcmVzdWx0IGluIHplcm8gYmVpbmcgcmV0dXJuZWQuDQo+
ID4gPiANCj4gPiA+IFdoZW4gbmZzX2xvb2t1cF9yZXZhbGlkYXRlKCkgcmV0dXJucyB6ZXJvLCB0
aGUgZGVudHJ5IGlzDQo+ID4gPiBpbnZhbGlkYXRlZA0KPiA+ID4gYW5kLCBzaWduaWZpY2FudGx5
LCBpZiB0aGUgZGVudHJ5IGlzIGEgZGlyZWN0b3J5IHRoYXQgaXMgbW91bnRlZA0KPiA+ID4gb24s
DQo+ID4gPiB0aGF0IG1vdW50cG9pbnQgaXMgbG9zdC4NCj4gPiA+IA0KPiA+ID4gSWYgeW91Og0K
PiA+ID4gwqAtIG1vdW50IGFuIE5GUyBmaWxlc3lzdGVtIHdoaWNoIGNvbnRhaW5zIGEgZGlyZWN0
b3J5DQo+ID4gPiDCoC0gbW91bnQgc29tZXRoaW5nIChlLmcuIHRtcGZzKSBvbiB0aGF0IGRpcmVj
dG9yeQ0KPiA+ID4gwqAtIHVzZSBpcHRhYmxlcyAob3Igc2Npc3NvcnMpIHRvIGJsb2NrIHRyYWZm
aWMgdG8gdGhlIHNlcnZlcg0KPiA+ID4gwqAtIGxzIC1sIHRoZS1tb3VudGVkLW9uLWRpcmVjdG9y
eQ0KPiA+ID4gwqAtIGludGVycnVwdCB0aGUgJ2xzIC1sJw0KPiA+ID4geW91IHdpbGwgZmluZCB0
aGF0IHRoZSBkaXJlY3RvcnkgaGFzIGJlZW4gdW5tb3VudGVkLg0KPiA+ID4gDQo+ID4gPiBUaGlz
IGNhbiBiZSBmaXhlZCBieSByZXR1cm5pbmcgdGhlIGFjdHVhbCBlcnJvciBjb2RlIGZyb20NCj4g
PiA+IG5mc19sb29rdXBfdmVyaWZ5X2lub2RlKCkgcmF0aGVyIHRoZW4gemVybyAoZXhjZXB0IGZv
ciAtRVNUQUxFKS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDVjZWI5ZDdmZGFhZiAoIk5GUzogUmVm
YWN0b3IgbmZzX2xvb2t1cF9yZXZhbGlkYXRlKCkiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTmVp
bEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGZzL25mcy9kaXIuYyB8
IDggKysrKystLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2Zz
L25mcy9kaXIuYw0KPiA+ID4gaW5kZXggY2I1MmRiOWEwY2ZiLi5kMjRhY2Y1NTZlOWUgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+
ID4gQEAgLTEzNTAsNyArMTM1MCw3IEBAIG5mc19kb19sb29rdXBfcmV2YWxpZGF0ZShzdHJ1Y3Qg
aW5vZGUgKmRpciwNCj4gPiA+IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgZmxh
Z3MpDQo+ID4gPiDCoHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGUgKmlub2Rl
Ow0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgaW50IGVycm9yOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
aW50IGVycm9yID0gMDsNCj4gPiA+IMKgDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgbmZzX2luY19z
dGF0cyhkaXIsIE5GU0lPU19ERU5UUllSRVZBTElEQVRFKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqBpbm9kZSA9IGRfaW5vZGUoZGVudHJ5KTsNCj4gPiA+IEBAIC0xMzcyLDggKzEzNzIsMTAgQEAg
bmZzX2RvX2xvb2t1cF9yZXZhbGlkYXRlKHN0cnVjdCBpbm9kZQ0KPiA+ID4gKmRpciwNCj4gPiA+
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZz
X2NoZWNrX3ZlcmlmaWVyKGRpciwgZGVudHJ5LCBmbGFncyAmIExPT0tVUF9SQ1UpKQ0KPiA+ID4g
ew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnJvciA9IG5mc19sb29r
dXBfdmVyaWZ5X2lub2RlKGlub2RlLCBmbGFncyk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChlcnJvcikgew0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyb3IgPT0gLUVTVEFMRSkNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycm9yID09IC1F
U1RBTEUpIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfemFwX2NhY2hlcyhkaXIpOw0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZXJyb3IgPSAwOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dF9iYWQ7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzX2FkdmlzZV91
c2VfcmVhZGRpcnBsdXMoZGlyKTsNCj4gPiA+IEBAIC0xMzk1LDcgKzEzOTcsNyBAQCBuZnNfZG9f
bG9va3VwX3JldmFsaWRhdGUoc3RydWN0IGlub2RlICpkaXIsDQo+ID4gPiBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksDQo+ID4gPiDCoG91dF9iYWQ6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGZs
YWdzICYgTE9PS1VQX1JDVSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FQ0hJTEQ7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gbmZzX2xvb2t1cF9y
ZXZhbGlkYXRlX2RvbmUoZGlyLCBkZW50cnksIGlub2RlLCAwKTsNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoHJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShkaXIsIGRlbnRyeSwgaW5vZGUs
DQo+ID4gPiBlcnJvcik7DQo+ID4gDQo+ID4gV2hpY2ggZXJyb3JzIGRvIHdlIGFjdHVhbGx5IG5l
ZWQgdG8gcmV0dXJuIGhlcmU/IEFzIGZhciBhcyBJIGNhbg0KPiA+IHRlbGwsDQo+ID4gdGhlIG9u
bHkgZXJyb3JzIHRoYXQgbmZzX2xvb2t1cF92ZXJpZnlfaW5vZGUoKSBpcyBzdXBwb3NlZCB0bw0K
PiA+IHJldHVybiBpcw0KPiA+IEVOT01FTSwgRVNUQUxFLCBFQ0hJTEQsIGFuZCBwb3NzaWJseSBF
SU8gb3IgRVRpTUVET1VULg0KPiA+IA0KPiA+IFdoeSB3b3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmV0
dXJuIHRob3NlIGVycm9ycyByYXRoZXIgdGhhbiBqdXN0IGEgMA0KPiA+IHdoZW4NCj4gPiB3ZSBu
ZWVkIHRvIGludmFsaWRhdGUgdGhlIGlub2RlLCBwYXJ0aWN1bGFybHkgc2luY2Ugd2UgYWxyZWFk
eSBoYXZlDQo+ID4gYQ0KPiA+IHNwZWNpYWwgY2FzZSBpbiBuZnNfbG9va3VwX3JldmFsaWRhdGVf
ZG9uZSgpIHdoZW4gdGhlIGRlbnRyeSBpcw0KPiA+IHJvb3Q/DQo+IA0KPiBFUkVTVEFSVFNZUyBp
cyB0aGUgZXJyb3IgdGhhdCBlYXNpbHkgY2F1c2VzIHByb2JsZW1zLg0KPiANCj4gUmV0dXJuaW5n
IDAgY2F1c2VzIGRfaW52YWxpZGF0ZSgpIHRvIGJlIGNhbGxlZCB3aGljaCBpcyBxdWl0ZSBoZWF2
eQ0KPiBoYW5kZWQgaW4gbW91bnRwb2ludHMuDQoNCk15IHBvaW50IGlzIHRoYXQgaXQgc2hvdWxk
bid0IGdldCByZXR1cm5lZCBmb3IgbW91bnRwb2ludHMuIFNlZQ0KbmZzX2xvb2t1cF9yZXZhbGlk
YXRlX2RvbmUoKS4NCg0KPiBTbyBpdCBpcyBvbmx5IHJlYXNvbmFibGUgdG8gcmV0dXJuIDAgd2hl
biB3ZSBoYXZlIHVuYW1iaWd1b3VzDQo+IGNvbmZpcm1hdGlvbiBmcm9tIHRoZSBzZXJ2ZXIgdGhh
dCB0aGUgb2JqZWN0IG5vIGxvbmdlciBleGlzdHMuwqANCj4gRVNUQUxFDQo+IGlzIHVuYW1iaWd1
b3VzLiBFSU8gbWlnaHQgYmUgdW5hbWJpZ3VvdXMuwqAgRVJFU1RBUlRTWVMsIEVOT01FTSwNCj4g
RVRJTUVET1VUIGFyZSB0cmFuc2llbnQgYW5kIGRvbid0IGp1c3RpZnkgZF9pbnZhbGlkYXRlKCkg
YmVpbmcNCj4gY2FsbGVkLg0KPiANCj4gKEJUVywgQ29tbWl0IGNjODk2ODRjOWEyNiAoIk5GUzog
b25seSBpbnZhbGlkYXRlIGRlbnRyeXMgdGhhdCBhcmUNCj4gY2xlYXJseSBpbnZhbGlkLiIpDQo+
IMKgZml4ZWQgbXVjaCB0aGUgc2FtZSBidWcgMyB5ZWFycyBhZ28pLg0KPiDCoA0KPiBUaGFua3Ms
DQo+IE5laWxCcm93bg0KPiANCj4gDQo+ID4gDQo+ID4gPiDCoH0NCj4gPiA+IMKgDQo+ID4gPiDC
oHN0YXRpYyBpbnQNCj4gPiANCj4gPiAtLSANCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KQ1RPLCBIYW1tZXJzcGFj
ZSBJbmMNCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOA0KTG9zIEFsdG9zLCBDQSA5NDAy
Mg0K4oCLDQp3d3cuaGFtbWVyLnNwYWNlDQoNCg==
