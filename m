Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F72CDC24
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgLCROX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 12:14:23 -0500
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:45693
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731388AbgLCROW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 12:14:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTQjclHbFjFGdPQaRDpCBFEMj2JKK4R9goAlkfTMeDw5YukVqzMNh0yAC+7MeMzxONbHuionGaBvzkMaLVPzU4ZL3zkWEXhSug0o7beuGk8TfvqzLLhNKs067j3oSuy2CHX9wux3E1VU95HWtgjBDmD90WCroo7OoNVa7MKMnz8w55/74myqLL99i6eJrhfnG6C41EK1Ah8yul0y8B3kC9ICdfIscIqi1HIvvajcCezLyYoab5uKWyWFLIjQs+u/ieaXPz1eqzaiNBDQRPUDSmgwfKLiKzuKqWardhAL3zND83H5nApRDSCmAdsgbvPqNNcI+6gaid61YQK8vufLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NDpOspe7RtiLP/Ap6IaOLhhLSfdQkOw0bQlcRYyM9E=;
 b=BUa3W/6gJWybDrJvulX2YZSPd4yqjgxdjHGTcjvFIv5zTGT6E2kyk8Y2XiMYELMqtyWIpoXglq2G0BRoutsCWXkVfvTL6y42eKfC+TsxGU1FUjPeLSe/1uFL5eJBEI/YgEo2aI3R/WVKQ0MFLcAvsz1/jhlwyCyXuzwJ3Wi5A5ok8Ju95F7w9mrtHbcqzwGd0G9kw+riFxDftjQ7HDwz6SFslkU9yLoHLKaX0ez4X9mAanjgDxDr4Ii9aH/S2XdNiNZNA+5OI++2/WW7cd3uCqR2ckD0GSXeUHUlqyGZFvk9qRoq4cNbsQFfRu3xOxIMW1s3shoF1uxqm00JzvLepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NDpOspe7RtiLP/Ap6IaOLhhLSfdQkOw0bQlcRYyM9E=;
 b=W/aXHltYAo0zncByFPrxEtI/T+G0PIhAUCQoKJppw/9gftqtfi4pt5pxiUeOuPFNmDZ7h8Trn9N+Nil76LhunSFwygY0aWOymvcaVTz5wYHzW+FeI5yWBY3GUHq7Y4UcbS/zI0hXLYrwAoM9chGXU3Im8YxlySBAxFuYCVUnn0U=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4351.namprd13.prod.outlook.com (2603:10b6:208:3f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Thu, 3 Dec
 2020 17:13:26 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 17:13:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Kernel OPS when using xattr
Thread-Topic: Kernel OPS when using xattr
Thread-Index: Gy/PzTaHdY6Ui5eV5iBg9axQHgH8es3zcbcAgCc3dgv/2OuegA==
Date:   Thu, 3 Dec 2020 17:13:26 +0000
Message-ID: <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
         <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
         <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
In-Reply-To: <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: desy.de; dkim=none (message not signed)
 header.d=none;desy.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e35d6e4b-ed31-48d5-ec15-08d897aebf89
x-ms-traffictypediagnostic: MN2PR13MB4351:
x-microsoft-antispam-prvs: <MN2PR13MB4351DA0BB910EAD361DF197FB8F20@MN2PR13MB4351.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTnnZ5btnEgsQwPEXMd+T91msWh6aE2UXDVexDVT/iMmj9OA05FTMKJzOWwkCTTNt8THNpwS0v4Q+DDmBT1W8pjl0Tj4D1wQuoSN1/A2SxZLjaWV82cXB7BlW11KDwJ+PZSZ3hfHC1La/5SR+03SZzV+NMDES3vXUjViVdsuuiUt4Vp9tgU48JKKMmyZkbGhBNCf8YcnTinbZ1TfL+0eJajx2S5+rgI5fPrYgpR8twIJVXZL8pihTyi7cPUGUGRx0r+CLo/lGY9/n20KNJ2QzzBYk7VjKDaPD+bpfxK6OFCZmOA1RdmEIeaKrvxV/Rsx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(346002)(376002)(396003)(36756003)(5660300002)(6512007)(6916009)(6486002)(186003)(26005)(8676002)(2616005)(8936002)(86362001)(2906002)(91956017)(316002)(66556008)(71200400001)(66476007)(66946007)(76116006)(64756008)(83380400001)(54906003)(4326008)(6506007)(53546011)(478600001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2FGc3lMSnVaZDcvU1Q2M04zcGhBbFB1S2c4SHdURUo1eGF6ZkpTbHV2ckhK?=
 =?utf-8?B?WjVDTTl0blFVZmY2TVQ2dGlLL1M1Qnptd2dzZUE2MEZlS3pjTkcrc0swYUpU?=
 =?utf-8?B?U2VpYWVpb1RZTTlHNWFFWjlHUDhKSDRiYmR6bm03cGM1dk56MWdPRlJISXgy?=
 =?utf-8?B?dm5sb0Fhdi8xclpLSXYxV0ozSzR1eitDWFBFUXN6MUdrZEt1ZUhoNlNNRS9O?=
 =?utf-8?B?Q1Foc1orN3phT3dtSzRPUHp5QTYwUU01UENnUDJQLzJKYzJtdDVBd3gzYTdG?=
 =?utf-8?B?aFJpQ1ZhMGl5TmFXd1U1R1ZPK2xNejJRZTZzdFhhV2x4cWI0bnNsWlBOWDVw?=
 =?utf-8?B?dlpvNGxuZjRiVnVETk1yblFZVnlDTWt6UXRyb3BTdUhlbmJuaVlMcFVHNnps?=
 =?utf-8?B?cFd4RnZNQUNPVWMvZnFJU0dick1IVGpUenhXSlF1NGZuNG50aUh3RjZja0pJ?=
 =?utf-8?B?UG5jV2dnRWVUaWRJcGIrZjZZT3F6VWZWZ0dXZ2YyTml4dGcvckUvNHRJclVC?=
 =?utf-8?B?alN4K1lQazQzSFd3bEZWblN6SWE4ajRnS1Y3WFVPVkZ4VmZhYVNaVUxmTnRP?=
 =?utf-8?B?WlNEUVB1eUhhV2R5TGhKMW5FYjVjcUYrNjhoazRmOHVIWXU0TDM1SGNNcFM3?=
 =?utf-8?B?ZHZ5Ynd2RTMraU5TOElpMmgzazd3a0I4MzJveGtBMGtvUjRSR2FEM0d3MWNm?=
 =?utf-8?B?c0owZ0tnbk83U0FjUmgvd3Z6MlFUR1FDYTN4bGdQelhkV2dTTE9zUk4rNU5K?=
 =?utf-8?B?V1ZMRlpnTVJpM0R5Z3ZBV0wxa2NmNEhTODdBSXQ0WnRXNmRmN0k3cWV6dk5W?=
 =?utf-8?B?bVFjOUh3WkM3Yy9mYlNQYVhZdCtsMWdQUzJsSlJWTlU3Vkhoc0tKTUkwSFNO?=
 =?utf-8?B?cGpSdWFJZjlMS3AzUktkREt3ZndQUEJHMTRYNUFSK3RNNWt6V2dTNEtQajdz?=
 =?utf-8?B?cXFuSjRQMEFwRmJNN1ljQmFacGdLdCtpQk90UGNrUGlIYmtmbXZiY2xXb0p3?=
 =?utf-8?B?L3JkVU1tTkJLMk41MEJta2JueHNYRlJqdFc2a3lPNXVEVmJ0dlZKVXJWZkE4?=
 =?utf-8?B?SHlaa1BnNG9OZVRQTXo0em1nTXFENi9ETGZsU1RBam5mVmpFbElYMzlEWFky?=
 =?utf-8?B?ci9BdWhENUJqbGpxQzRTVnI1ajVPNnFTanRTZnVpRkdTKzJDL2hRK3FLK1hj?=
 =?utf-8?B?NkdxdkpQOG1PM1pFNXE1YThHbjdkanVzNUNBckdmakFIaXc5bEZDVnBpdHlG?=
 =?utf-8?B?c3YwQU9vZVJKYnRHVkJ4MWpKZ0RCT0luY1ZCSG9Eakw4c2tvejc1OEN6Zk1G?=
 =?utf-8?Q?Yy5REpk0/erWFSPwcByDzJKmpZeZV40LHO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <621085D293CA5542978A303E17737003@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35d6e4b-ed31-48d5-ec15-08d897aebf89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 17:13:26.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVi1tPn3uhiqiG3PkxBkxv0riY9ACuu5QwbhrBX0sg7PhaIeaz+iiB9OtIl81iKsLvoqV9DCzqCgGUdciSRd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4351
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE3OjA0ICswMTAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gDQo+IA0KPiBIaSBUcm9uZCwNCj4gDQo+IHVuZm9ydHVuYXRlbHkgdGhlIHNhbWUgcmVz
dWx0LiBIZXJlIHRoZSBvdXRwdXQgb2YgZ2RiLCBpZiBpdCBoZWxwcy4NCj4gDQo+IChnZGIpIGxp
c3QgKjB4MDAwMDAwMDAwMDAyNTJiZQ0KPiAweDI1MmJlIGlzIGluIF9zaGlmdF9kYXRhX3JpZ2h0
X3BhZ2VzIChuZXQvc3VucnBjL3hkci5jOjM0NCkuDQo+IDMzOcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgqcGd0byAhPSAqcGdmcm9tKSB7DQo+IDM0MMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2ZnJv
bSA9IGttYXBfYXRvbWljKCpwZ2Zyb20pOw0KPiAzNDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtY3B5KHZ0byArIHBndG9fYmFzZSwg
dmZyb20gKw0KPiBwZ2Zyb21fYmFzZSwgY29weSk7DQo+IDM0MsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrdW5tYXBfYXRvbWljKHZmcm9t
KTsNCj4gMzQzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNl
DQo+IDM0NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBtZW1tb3ZlKHZ0byArIHBndG9fYmFzZSwgdnRvICsNCj4gcGdmcm9tX2Jhc2UsIGNv
cHkpOw0KPiAzNDXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmbHVz
aF9kY2FjaGVfcGFnZSgqcGd0byk7DQo+IDM0NsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGt1bm1hcF9hdG9taWModnRvKTsNCj4gMzQ3DQo+IDM0OMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfSB3aGlsZSAoKGxlbiAtPSBjb3B5KSAhPSAwKTsNCj4gKGdkYikNCj4g
DQoNCllvdSBwcm9iYWJseSBuZWVkIHRoaXMgb25lIGluIGFkZGl0aW9uIHRvIHRoZSBmaXJzdCBw
YXRjaC4NCjg8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KRnJvbSBmZWM3NzQ2OWYzNzNmYmNjYjI5MmMyZDUyMmYyZWJlZTNiOTAxMWE4IE1vbiBT
ZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KRGF0ZTogVGh1LCAzIERlYyAyMDIwIDEyOjA0OjUxIC0wNTAw
DQpTdWJqZWN0OiBbUEFUQ0hdIE5GU3Y0LjI6IEZpeCB1cCB0aGUgZ2V0L2xpc3R4YXR0ciBjYWxs
cyB0bw0KIHJwY19wcmVwYXJlX3JlcGx5X3BhZ2VzKCkNCg0KRW5zdXJlIHRoYXQgYm90aCBnZXR4
YXR0ciBhbmQgbGlzdHhhdHRyIHBhZ2UgYXJyYXkgYXJlIGNvcnJlY3RseQ0KYWxpZ25lZCwgYW5k
IHRoYXQgZ2V0eGF0dHIgY29ycmVjdGx5IGFjY291bnRzIGZvciB0aGUgcGFnZSBwYWRkaW5nDQp3
b3JkLg0KDQpTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20+DQotLS0NCiBmcy9uZnMvbmZzNDJ4ZHIuYyB8IDEyICsrKysrKystLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJ4ZHIuYyBiL2ZzL25mcy9uZnM0Mnhkci5jDQppbmRleCA4
NDMyYmQ2Yjk1ZjAuLjEwMzk3OGZmNzZjOSAxMDA2NDQNCi0tLSBhL2ZzL25mcy9uZnM0Mnhkci5j
DQorKysgYi9mcy9uZnMvbmZzNDJ4ZHIuYw0KQEAgLTE5MSw3ICsxOTEsNyBAQA0KIA0KICNkZWZp
bmUgZW5jb2RlX2dldHhhdHRyX21heHN6ICAgKG9wX2VuY29kZV9oZHJfbWF4c3ogKyAxICsgXA0K
IAkJCQkgbmZzNF94YXR0cl9uYW1lX21heHN6KQ0KLSNkZWZpbmUgZGVjb2RlX2dldHhhdHRyX21h
eHN6ICAgKG9wX2RlY29kZV9oZHJfbWF4c3ogKyAxICsgMSkNCisjZGVmaW5lIGRlY29kZV9nZXR4
YXR0cl9tYXhzeiAgIChvcF9kZWNvZGVfaGRyX21heHN6ICsgMSArDQpwYWdlcGFkX21heHN6KQ0K
ICNkZWZpbmUgZW5jb2RlX3NldHhhdHRyX21heHN6ICAgKG9wX2VuY29kZV9oZHJfbWF4c3ogKyBc
DQogCQkJCSAxICsgbmZzNF94YXR0cl9uYW1lX21heHN6ICsgMSkNCiAjZGVmaW5lIGRlY29kZV9z
ZXR4YXR0cl9tYXhzeiAgIChvcF9kZWNvZGVfaGRyX21heHN6ICsNCmRlY29kZV9jaGFuZ2VfaW5m
b19tYXhzeikNCkBAIC0xNDc2LDE3ICsxNDc2LDE4IEBAIHN0YXRpYyB2b2lkIG5mczRfeGRyX2Vu
Y19nZXR4YXR0cihzdHJ1Y3QNCnJwY19ycXN0ICpyZXEsIHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIs
DQogCXN0cnVjdCBjb21wb3VuZF9oZHIgaGRyID0gew0KIAkJLm1pbm9ydmVyc2lvbiA9IG5mczRf
eGRyX21pbm9ydmVyc2lvbigmYXJncy0NCj5zZXFfYXJncyksDQogCX07DQorCXVpbnQzMl90IHJl
cGxlbjsNCiAJc2l6ZV90IHBsZW47DQogDQogCWVuY29kZV9jb21wb3VuZF9oZHIoeGRyLCByZXEs
ICZoZHIpOw0KIAllbmNvZGVfc2VxdWVuY2UoeGRyLCAmYXJncy0+c2VxX2FyZ3MsICZoZHIpOw0K
IAllbmNvZGVfcHV0ZmgoeGRyLCBhcmdzLT5maCwgJmhkcik7DQorCXJlcGxlbiA9IGhkci5yZXBs
ZW4gKyBvcF9kZWNvZGVfaGRyX21heHN6ICsgMTsNCiAJZW5jb2RlX2dldHhhdHRyKHhkciwgYXJn
cy0+eGF0dHJfbmFtZSwgJmhkcik7DQogDQogCXBsZW4gPSBhcmdzLT54YXR0cl9sZW4gPyBhcmdz
LT54YXR0cl9sZW4gOiBYQVRUUl9TSVpFX01BWDsNCiANCi0JcnBjX3ByZXBhcmVfcmVwbHlfcGFn
ZXMocmVxLCBhcmdzLT54YXR0cl9wYWdlcywgMCwgcGxlbiwNCi0JICAgIGhkci5yZXBsZW4pOw0K
KwlycGNfcHJlcGFyZV9yZXBseV9wYWdlcyhyZXEsIGFyZ3MtPnhhdHRyX3BhZ2VzLCAwLCBwbGVu
LA0KcmVwbGVuKTsNCiAJcmVxLT5ycV9yY3ZfYnVmLmZsYWdzIHw9IFhEUkJVRl9TUEFSU0VfUEFH
RVM7DQogDQogCWVuY29kZV9ub3BzKCZoZHIpOw0KQEAgLTE1MjAsMTQgKzE1MjEsMTUgQEAgc3Rh
dGljIHZvaWQgbmZzNF94ZHJfZW5jX2xpc3R4YXR0cnMoc3RydWN0DQpycGNfcnFzdCAqcmVxLA0K
IAlzdHJ1Y3QgY29tcG91bmRfaGRyIGhkciA9IHsNCiAJCS5taW5vcnZlcnNpb24gPSBuZnM0X3hk
cl9taW5vcnZlcnNpb24oJmFyZ3MtDQo+c2VxX2FyZ3MpLA0KIAl9Ow0KKwl1aW50MzJfdCByZXBs
ZW47DQogDQogCWVuY29kZV9jb21wb3VuZF9oZHIoeGRyLCByZXEsICZoZHIpOw0KIAllbmNvZGVf
c2VxdWVuY2UoeGRyLCAmYXJncy0+c2VxX2FyZ3MsICZoZHIpOw0KIAllbmNvZGVfcHV0ZmgoeGRy
LCBhcmdzLT5maCwgJmhkcik7DQorCXJlcGxlbiA9IGhkci5yZXBsZW4gKyBvcF9kZWNvZGVfaGRy
X21heHN6ICsgMiArIDE7DQogCWVuY29kZV9saXN0eGF0dHJzKHhkciwgYXJncywgJmhkcik7DQog
DQotCXJwY19wcmVwYXJlX3JlcGx5X3BhZ2VzKHJlcSwgYXJncy0+eGF0dHJfcGFnZXMsIDAsIGFy
Z3MtDQo+Y291bnQsDQotCSAgICBoZHIucmVwbGVuKTsNCisJcnBjX3ByZXBhcmVfcmVwbHlfcGFn
ZXMocmVxLCBhcmdzLT54YXR0cl9wYWdlcywgMCwgYXJncy0NCj5jb3VudCwgcmVwbGVuKTsNCiAN
CiAJZW5jb2RlX25vcHMoJmhkcik7DQogfQ0KLS0gDQoyLjI4LjANCg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
