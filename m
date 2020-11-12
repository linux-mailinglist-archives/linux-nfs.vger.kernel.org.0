Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5862B0C90
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 19:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKLS0a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 13:26:30 -0500
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com ([40.107.237.135]:16480
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgKLS0Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 13:26:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqfZyYQ4PY+RoNnhdJi+eXI5kg0BObLCQ5NE+j9UwtfXpVRtvdJA9cTtYkxoCGkl/C9ZbP8ii9ZDYSnO3oOiF70Xc1yo3/yzeyrIomTlJMsA+LKznwBy2v2zClRC7/p8iPyXUPA9mIfFivsOE8g4cePcx3eZ2Nn1pu0DB47eGMJr/E3L9y+zQfmLHJIR064OV60bQ3iFJxfpvl+7Kz555TT5+E90wXyxgZl7plKCavN3cv1OvrBkDjdD2Wx6Xv/TB4zL+WHHutgUJRBYsdwtLeKyH2WHJDTkjCT4M8xl0rozuOGKDCDm1ndgYmCTaYIQIgo8QgdatCBuXJLl84oCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmnFvw1ItWedz+3mXutYTydMPIuSqAkU4pOgCR682C0=;
 b=Xl7IG0JgL/L/+Bze7NlpxPH7PGn9TetoCi9cvoSTUiesExWTwV/k6qfPk+CmCQozXHkQc8DgIyW0GxSiJSNf/H3ERMgSPpRtO9/nkySTMKHB66oxDWYQLOGkVy2ZQs+x0nu43yoAgtvJpKPMXe6cMyp0WvoqMalciLzxOA3LwkBu2EE9rC5C+LaskXx+YmU0EZpZs2KXSl0bkTxB1mlDbraDSL/G+SWe5jV2H1oGQ6nsK6LBo/IwlFXFgsIyWgs9LoYX7VozUEaCuXiWtzPlDrbY403ZG3z7ocYgweS7AKe7HLFsKe1gHbIoBiiU/QxVuHbsNR3eMRkp39FTEN8seA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmnFvw1ItWedz+3mXutYTydMPIuSqAkU4pOgCR682C0=;
 b=gwPH/WYeJNc63LkWFUCUdP9EU2S4b+3J9pNwXrWQY4wf4qOYwkaZ/RJawkVArvNmDWMQaeR4LJgwmRHMDM6fFKkLdUzI9W/YrUhs9AR+VCzjsrFCwi3XJ5riLM7T2ib6otsad0g++7/xSXmNh9auadwdz5Mfa01q5eQQ8C0WxwE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3632.namprd13.prod.outlook.com (2603:10b6:208:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Thu, 12 Nov
 2020 18:26:20 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Thu, 12 Nov 2020
 18:26:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Thread-Topic: [PATCH v5 00/22] Readdir enhancements
Thread-Index: AQHWt6smlycN3byFeUCu4hbFFYYhUqnDgPIAgADhS4CAAFZvgIAAGp0A
Date:   Thu, 12 Nov 2020 18:26:20 +0000
Message-ID: <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
         <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
         <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
         <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
In-Reply-To: <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceabbbbd-5c7d-4edc-83c0-08d8873873f6
x-ms-traffictypediagnostic: MN2PR13MB3632:
x-microsoft-antispam-prvs: <MN2PR13MB3632011733F355C02ACCD71CB8E70@MN2PR13MB3632.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QceI7/bpM9xL6sG6Or7e6B1lxjNlw0xapgPPPpeSGd9g+NvkugxJHtNyn0Q4MVX+kjAviVFeMHioLXFdZsdPncUUCLmITBLF8eq0/D7yRl+VzRhVb9f1vh/rksolWOuUArlq+5AZajH2YzcXoiJTpnxYafVlHoF1Krjmzc95DlvLu6JJr5VKb5erRaklNSkpexkc/qoqAUsL5nPZf7dUgfvDzodD6+9DYkPB7v/v5Vfy4mnuFEg+Sk+Ct9IpuEvhvcg0DdJodlsbvFGYGDmTGB8fdTOYQ8y/JOZhjq3jfXfWti1NvyW7saGTv6Q3w9s43lTrCXQ79WKWhvtjiQRpcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39840400004)(136003)(2616005)(6512007)(2906002)(186003)(316002)(66476007)(5660300002)(64756008)(36756003)(6916009)(26005)(4326008)(8676002)(71200400001)(6486002)(478600001)(86362001)(6506007)(66556008)(83380400001)(4001150100001)(8936002)(66946007)(91956017)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tuI5gfNLjnvoHEJ4NixNK91yPn8BcTpJbbnxewIybV1QpZotkwKCY1dBk9zd2v824//sextFILkZ+9I5PeIJp+kEinn47W1F0Ni6BE2GbNKAfYp00ouSY6oaDQ87NxBowYH3KEyceXxFkwvzqAcR5EO5BxDtguKeaiLDnBM0KlH2TKaXtj6PP1lQTCoO95a6EXtr+Fqb7K0XGtzy7vlpPLPwXzFD04xMwJfwyA7nV76TK+w23IVYokuvdN46ALmgEs2My3DbFEibnZnYrhJY83Et49l2jshqxwDia45ahlhaEz4UR7uK7HhFfaCwpcQ2nx1aahPxxGsg5SRPCpxPzRnfoXg4+NU9Vn4Q0joxGmh6WMkX/XqEl/CNs08nrwgINtCF43VSxnoxBqrPPpxLGhWeHzqkyxW2y8PJ3Zv3s3J9Td6WbX/VWv5DxgAHa5u7BAvwk68mZypjZCMzeWZDeufwXIGjMvraZiaGl4F6kbU9JrNQNlJfg3v0BsE+VffUn1pxef2xgbJk9OL4VFRwKgCpRmLmOC6QQQfWUM7f/AGoCkqrFV7FbPjq4zSLmjSaBKZUUthVqZzWZ8ok6iEBHCGL5xMhgsWor3O7DOu3FFPG4XtqsjlqIoTzlS/GBq46YiyHZxBlYWcJRVtv5r/G+w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B275745C62F643408DBA87A4539AE658@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceabbbbd-5c7d-4edc-83c0-08d8873873f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 18:26:20.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIi8u0zZwQmJ9lYcc4oW/t+ZC7l/ktFpkTOzPx//fWVJrM6PJTbbLoZj+siglYa+0IWq54KLT0jVJfxivCQFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3632
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDE2OjUxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IA0KPiBJIHdhcyBnb2luZyB0byBhc2sgeW91IGlmIHBlcmhhcHMgcmV2ZXJ0aW5nIFNjb3R0
J3MgY29tbWl0DQo+IDA3YjVjZThlZjJkOA0KPiAoIk5GUzogTWFrZSBuZnNfcmVhZGRpciByZXZh
bGlkYXRlIGxlc3Mgb2Z0ZW4iKSBtaWdodCBoZWxwIGhlcmU/DQo+IE15IHRoaW5raW5nIGlzIHRo
YXQgd2lsbCB0cmlnZ2VyIG1vcmUgY2FjaGUgaW52YWxpZGF0aW9ucyB3aGVuIHRoZQ0KPiBkaXJl
Y3RvcnkgaXMgY2hhbmdpbmcgdW5kZXJuZWF0aCB1cywgYW5kIHdpbGwgbm93IHRyaWdnZXIgdW5j
YWNoZWQNCj4gcmVhZGRpciBpbiB0aG9zZSBzaXR1YXRpb25zLg0KPiANCj4gPiANCg0KSU9XLCB0
aGUgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0byBhcHBseSBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93
aW5nIG9uDQp0b3Agb2YgdGhlIGV4aXN0aW5nIHJlYWRkaXIgcGF0Y2hzZXQ6DQoNCi0tLQ0KIGZz
L25mcy9kaXIuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2Zz
L25mcy9kaXIuYw0KaW5kZXggM2Y3MDY5NzcyOWQ4Li4zODRhNDY2M2Y3NDIgMTAwNjQ0DQotLS0g
YS9mcy9uZnMvZGlyLmMNCisrKyBiL2ZzL25mcy9kaXIuYw0KQEAgLTk1NiwxMCArOTU2LDEwIEBA
IHN0YXRpYyBpbnQgcmVhZGRpcl9zZWFyY2hfcGFnZWNhY2hlKHN0cnVjdA0KbmZzX3JlYWRkaXJf
ZGVzY3JpcHRvciAqZGVzYykNCiB7DQogCWludCByZXM7DQogDQotCWlmIChuZnNfcmVhZGRpcl9k
b250X3NlYXJjaF9jYWNoZShkZXNjKSkNCi0JCXJldHVybiAtRUJBRENPT0tJRTsNCi0NCiAJZG8g
ew0KKwkJaWYgKG5mc19yZWFkZGlyX2RvbnRfc2VhcmNoX2NhY2hlKGRlc2MpKQ0KKwkJCXJldHVy
biAtRUJBRENPT0tJRTsNCisNCiAJCWlmIChkZXNjLT5wYWdlX2luZGV4ID09IDApIHsNCiAJCQlk
ZXNjLT5jdXJyZW50X2luZGV4ID0gMDsNCiAJCQlkZXNjLT5wcmV2X2luZGV4ID0gMDsNCkBAIC0x
MDgyLDExICsxMDgyLDkgQEAgc3RhdGljIGludCBuZnNfcmVhZGRpcihzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0DQpkaXJfY29udGV4dCAqY3R4KQ0KIAkgKiB0byBlaXRoZXIgZmluZCB0aGUgZW50
cnkgd2l0aCB0aGUgYXBwcm9wcmlhdGUgbnVtYmVyIG9yDQogCSAqIHJldmFsaWRhdGUgdGhlIGNv
b2tpZS4NCiAJICovDQotCWlmIChjdHgtPnBvcyA9PSAwIHx8IG5mc19hdHRyaWJ1dGVfY2FjaGVf
ZXhwaXJlZChpbm9kZSkpIHsNCi0JCXJlcyA9IG5mc19yZXZhbGlkYXRlX21hcHBpbmcoaW5vZGUs
IGZpbGUtPmZfbWFwcGluZyk7DQotCQlpZiAocmVzIDwgMCkNCi0JCQlnb3RvIG91dDsNCi0JfQ0K
KwlyZXMgPSBuZnNfcmV2YWxpZGF0ZV9tYXBwaW5nKGlub2RlLCBmaWxlLT5mX21hcHBpbmcpOw0K
KwlpZiAocmVzIDwgMCkNCisJCWdvdG8gb3V0Ow0KIA0KIAlyZXMgPSAtRU5PTUVNOw0KIAlkZXNj
ID0ga3phbGxvYyhzaXplb2YoKmRlc2MpLCBHRlBfS0VSTkVMKTsNCg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
