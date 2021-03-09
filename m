Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDB333085
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 22:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCIVAO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 16:00:14 -0500
Received: from mail-bn7nam10on2117.outbound.protection.outlook.com ([40.107.92.117]:50198
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231616AbhCIU7y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Mar 2021 15:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOtHXIfIbtb7OfvoUxUlzXoLAsG0B+p35pH0qJyAVQfUDtF48/XaHzo2WzJGhsArh+/9dTyUuW6bPQcjAxcr+9M0A3uuzQnuHB6jCZo9JH7QEl/vDKmcc0o82C1aFNGt6KpiiNd7rKQr0ZE9uWYhu+xFDMyE/UBI2MyZC/DPUE5If1v2JBObVbWfFWuMM9/HK+fb8QNkMpXRCtVRV9x7QbmmpwvmLgyOqoT08Rkq7Rn9BafHKHAhORlflNjx1h+AElCw6xbvIlh7YbCYsQLCMx9eM+MHeOF6/4KBF+oOva0f7t3Jz6bF6bfJ1ub96yMKPrsL032DEoVq1xL1qbWkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDSKAUzfOt7WC/1ZgxdE0LgPQt/hzGWkh+hODHuZpg=;
 b=dApsvK9Iusa2EtdYsT9cFOzx47pfUXLpOMlNoFmMu69O0bD85HS7c6D5MgnInFIlDd/9J7gmGaldBb3SKhK1qOKwVuJ9swALyu4NWoU08UV5uMEhmdT0tFfOtDz/WkBEAcg4x5RIGLg3dAIoIIKNmLBiDtz8uleUwPw5XrJ2aG/hX18N7H0V8yMwL275XH4/SyUD6WGCq5txOTzuOAwB6QWL8XzGXJW6VZVp1Cb6HJcZGE1THb9bRjQGXtXjERBcrEIVhAtF8dl9lIOZPvPPesRJq13QxrIGtKJWJulTcOb2wlUYmF/4nCegBEsWH2kB2w+hs2RVOascnYGt92queQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDSKAUzfOt7WC/1ZgxdE0LgPQt/hzGWkh+hODHuZpg=;
 b=KiMCWW2RnDE2bYrs6LOHiuNhZTI8dlvPUDWlfpFsrTA4NTO9oYFxyjM6g6YCWXqjgZUg0Xf6IvzkTegETG90t8uXjNtnX4WV5L3oIQ0xySRG+0PH4vDoDUO0rpVitW3bWxbVy8RvcLWWidU5GnOiVXiK+Jg1iocmixAH2OFAvgs=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3670.namprd13.prod.outlook.com (2603:10b6:610:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Tue, 9 Mar
 2021 20:59:51 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 20:59:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Topic: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Index: AQHXFPJtj0F8JgkddEiUQJPR5oySTqp7ykSAgABPy4CAAAVGgIAABQ+A
Date:   Tue, 9 Mar 2021 20:59:51 +0000
Message-ID: <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
         <YEeWK+gs4c8O7k0u@pick.fieldses.org>
         <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
         <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.124.244.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7ac66be-976c-4e2d-b019-08d8e33e4889
x-ms-traffictypediagnostic: CH2PR13MB3670:
x-microsoft-antispam-prvs: <CH2PR13MB36704C785892E774B993C16DB8929@CH2PR13MB3670.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ieh3Anbe6ymWsBBaVJMZ+D5jJcpIMhKzXOpTysmqva/SYClpl8cwLLzjVzmPlPZ6hmP3Tr9ue8aqVSkB6KNK8v8Sk7mVvB6LkQ4eP2Um5OFliQCrgdKz5uYxI4iuEeqEBLYkwcY6usvsjfrQVCBPpKyJnuq6s7TN4TF4hgHg54cPpX26+rvpFMx4c0WuXx3D+5h2GI8hE5N5wSjWwdznIMW6ClRjfztw0AENsuX0zTyqE1Nqb4GA792WPf61gFivrwqfaPdA2RqtX8kWR0VJ5mBAL/+/1+qZPcb7iSJ3Uiuc1JEHbYt5jSCvu1hUGv41a4Usoq9776L1OihsqIp4Hra0qT/wXAQVfy6W56qa3hFqpVU1k7tYWemSlxz+z/ZctE8Ngu5a43Qw46z/mn7Nwfi7rtBpWxzLTxaRLrty6X4NNFT3Yp78hTcX0GPZjsQN0ZvV80bMOU+4XlGnYDIQlOKlkNQ5H0r1Mxtu3Tol3ClAdqdpZG+GONjHH+K2T1Ca1X7LQJAqtWocey5Nsql9pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39840400004)(136003)(26005)(86362001)(186003)(66946007)(53546011)(36756003)(6916009)(2906002)(4326008)(66556008)(6512007)(8936002)(66446008)(66476007)(64756008)(76116006)(8676002)(478600001)(54906003)(5660300002)(316002)(6486002)(71200400001)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eG11YlhBMUpIOTZmTzNCZGF6T2JoQ3VuRkZSWGxzc2pEdHpJc0dmaElLTWll?=
 =?utf-8?B?UENiZXB3Y2YvK3gzaE4zMFJXcUZlM3lqYmMzbE9Dclc5UDduYk9YZGFBY3lu?=
 =?utf-8?B?d09kZnR4THJHZ25mR0xlRC9XUXBMWEpkN3d4V3B6RGgzc1lyVFlCcGxhN2lj?=
 =?utf-8?B?VjBGVnlJekZwTEova0E3RzNvcXFFWE5WVFhFU09iUUJQb2V6MEJPcGJPbEpu?=
 =?utf-8?B?dkY0Z3QzcU01ZWpCaTB5YTlMdjRCOFZYNTJacmpIaXNaa2J4WmpoRHlGcHdU?=
 =?utf-8?B?UmYwZUhpWDZQb2VwVTFsVGM5ek5YemcydW1aTDZDMzA5Ynd2WXBEdDR6OGF2?=
 =?utf-8?B?Z0h6Q256anFyV3RPbTNUbDExZjR1ZVNjazAzalFUY0s3VGtYUXVyZ0J3Uy9J?=
 =?utf-8?B?ajIwK2Q2YkxyeGhSNlZPRTFvRjBDWjVJLzRlTDMxUVlneGRPYjhRSmFGbGRR?=
 =?utf-8?B?eUhCcDhReEw2VDcxekhTS1BlazBVL2h0WGgwb0dGejNhSVh4STlVMmg1Qzh4?=
 =?utf-8?B?cDhBci9GblBJS0ZoR0FPY3hNaFI2NFdLYjB2c25YNVNRSXBqVWQrcUpFRkRX?=
 =?utf-8?B?M29rcFI2WTZ6WmdxSEFldkFpeE5yWk5IU0R1RkF4dWgyZ0IybWJKQW5STHRa?=
 =?utf-8?B?M0xSNThYZ1B5engzQTVEMDB0dEw2SEpnaUtkOXgxcGFybk1LdllQY1diVDBI?=
 =?utf-8?B?SmtxaWk0clRXSU5JbDd5RjM0OEo0VjlLOTZ6MnE5N01CYVhMUG9TLy9MZWtQ?=
 =?utf-8?B?THBhTXJsQ2RVS2pBMi9IeU1yakMwalZlN0tOUjFZb25ja3NRZEUwbUI3VlRh?=
 =?utf-8?B?S2ZqQnkzZHIzNytoaEFuNVRqR2VmbUJ6eFZmZURPS09NdlBPWHp6dEcyT0NT?=
 =?utf-8?B?UlFqQmd6MnNMZ0EvY0R6bnhXZForcVNvZXJxM3QvV1ZQVDlzS09NWlZ0SGhZ?=
 =?utf-8?B?UldydmkyRWlZRE5WNk05bTVwNkhpM1YrVWpwQVp3RTJiYmpSOFBLbHFwa1pQ?=
 =?utf-8?B?WWtRdzdWVHlJTTJVTGdBeDBGbnJEVEJxYTYxUHNERjNhcEJCUnlnT2VoZW0z?=
 =?utf-8?B?TGp6aVJPUkdhcUdPbUtBTVBQYjBrNUQ3RXpwczZ0RW1yeVFZZERROUxzZEN0?=
 =?utf-8?B?Sk9TaUpSRWdDempVNVNvSW1rMkdGYWhjVytLNkxHWmpXTm5KWE1MYzlQd2E0?=
 =?utf-8?B?bWFrT3dodmVYMWpXOXhDOVpsdlUzWUhrZVB0VWg0VnNCRm5mLytEZWQxNFh6?=
 =?utf-8?B?dUFObEFqQ09NQkNEZFlobkgxV0tXOHJISytNbjFlZnpWbkc3azd2dGZNKzl2?=
 =?utf-8?B?aTFpems5VC83VmVRb2d5ai9xc1FqVHhUQ2J5RklQRWxSdFJaQzUvdE9BelR2?=
 =?utf-8?B?bEVXbTNmUWVBWlhFMU04UE51eGZuOFpMOFpxZ1MvejJWb0hYSHhNdFJJNTZn?=
 =?utf-8?B?b2VFVzVvNVdEM3VZVHBSaTg2Q0RVWTRHUE8wSjdTbHVEakNJdklSRHV6SGlD?=
 =?utf-8?B?TEluQkZUWmMyVGJDMnFybGVoL09wYjV2K0RqT3VGK3dQOXoyd2FIc0pmN2My?=
 =?utf-8?B?QUs4NzlsMlZFeDdBeTFPaEFRQktZVEdhZlZVVFlJUmhBb2ZaelNHeXpiZEl5?=
 =?utf-8?B?a0pTTWxnbWo1Q1BnNlBZMS9yYU9PYXdiYWdNNFg4OTF2Q3FhcHN5NU9mdmpm?=
 =?utf-8?B?dk9IZ0U3dnpUMGZHaE05SW5xZ0Nsc2dmNGg4TlNUOHpRTndvZFFVSzJSN2NX?=
 =?utf-8?B?OWpLVHcvZjZCMGtKcjdkQlJMaTFtZlg2dGpURU9Qa1lIQnVJRUNPWnZSUFMx?=
 =?utf-8?B?NWVjVFgyd1I2UHl0TXFTZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A141E7EDBEC66A4BBBADFC673ECAEB1D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ac66be-976c-4e2d-b019-08d8e33e4889
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:59:51.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+OX1QHnSVet3E692guJ8ZbpgLGEwGo0otFBgsevH41XQxiHfw/QhpKH5gkawoto1JzpbDP0pD1LxAB+7EfleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3670
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDE1OjQxIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBNYXIgOSwgMjAyMSBhdCAzOjIyIFBNIFRyb25kIE15a2xlYnVzdCA8DQo+
IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjEt
MDMtMDkgYXQgMTA6MzcgLTA1MDAsIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IE9uIFR1
ZSwgTWFyIDA5LCAyMDIxIGF0IDA5OjQxOjI3QU0gLTA1MDAsIE9sZ2EgS29ybmlldnNrYWlhDQo+
ID4gPiB3cm90ZToNCj4gPiA+ID4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFw
cC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVuIHRoZSBzZXJ2ZXIgdHJpZXMgdG8gZG8gYSBj
YWxsYmFjayBhbmQgYSBjbGllbnQgZmFpbHMgaXQNCj4gPiA+ID4gZHVlIHRvDQo+ID4gPiA+IGF1
dGhlbnRpY2F0aW9uIHByb2JsZW1zLCB3ZSBuZWVkIHRoZSBzZXJ2ZXIgdG8gc2V0IGNhbGxiYWNr
DQo+ID4gPiA+IGRvd24NCj4gPiA+ID4gZmxhZyBpbiBSRU5FVyBzbyB0aGF0IGNsaWVudCBjYW4g
cmVjb3Zlci4NCj4gPiA+IA0KPiA+ID4gSSB3YXMgbG9va2luZyBhdCB0aGlzLsKgIEl0IGxvb2tz
IHRvIG1lIGxpa2UgdGhpcyBzaG91bGQgcmVhbGx5IGJlDQo+ID4gPiBqdXN0Og0KPiA+ID4gDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoCBjYXNlIDE6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHRhc2stPnRrX3N0YXR1cykNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzZDRfbWFya19jYl9kb3duKGNscCwgdGFzay0+
dGtfc3RhdHVzKTsNCj4gPiA+IA0KPiA+ID4gSWYgdGtfc3RhdHVzIHNob3dlZCBhbiBlcnJvciwg
YW5kIHRoZSAtPmRvbmUgbWV0aG9kIGRvZXNuJ3QNCj4gPiA+IHJldHVybiAwDQo+ID4gPiB0bw0K
PiA+ID4gdGVsbCB1cyBpdCBzb21ldGhpbmcgd29ydGggcmV0cnlpbmcsIHRoZW4gdGhlIGNhbGxi
YWNrIGZhaWxlZA0KPiA+ID4gcGVybWFuZW50bHksIHNvIHdlIHNob3VsZCBtYXJrIHRoZSBjYWxs
YmFjayBwYXRoIGRvd24sIHJlZ2FyZGxlc3MNCj4gPiA+IG9mDQo+ID4gPiB0aGUNCj4gPiA+IGV4
YWN0IGVycm9yLg0KPiA+IA0KPiA+IEkgZGlzYWdyZWUuIHRhc2stPnRrX3N0YXR1cyBjb3VsZCBi
ZSBhbiB1bmhhbmRsZWQgTkZTdjQgZXJyb3IgKHNlZQ0KPiA+IG5mc2Q0X2NiX3JlY2FsbF9kb25l
KCkpLiBUaGUgY2xpZW50IG1pZ2h0LCBmb3IgaW5zdGFuY2UsIGJlIGluIHRoZQ0KPiA+IHByb2Nl
c3Mgb2YgcmV0dXJuaW5nIHRoZSBkZWxlZ2F0aW9uIGJlaW5nIHJlY2FsbGVkLiBXaHkgc2hvdWxk
IHRoYXQNCj4gPiByZXN1bHQgaW4gdGhlIGNhbGxiYWNrIGNoYW5uZWwgYmVpbmcgbWFya2VkIGFz
IGRvd24/DQo+ID4gDQo+IA0KPiBBcmUgeW91IHRhbGtpbmcgYWJvdXQgc2F5IHRoZSBjb25uZWN0
aW9uIGdvaW5nIGRvd24gYW5kIHNlcnZlciBzaG91bGQNCj4ganVzdCByZWNvbm5lY3QgaW5zdGVh
ZCBvZiByZWNvdmVyaW5nIHRoZSBjYWxsYmFjayBjaGFubmVsLiBJIGFzc3VtZWQNCj4gdGhhdCBj
b25uZWN0aW9uIGJyZWFrIGlzIHNvbWV0aGluZyB0aGF0J3Mgbm90wqAgcmVjb3ZlcmFibGUgYnkg
dGhlDQo+IGNhbGxiYWNrIGJ1dCBwZXJoYXBzIEknbSB3cm9uZy4NCg0KTm8uIEknbSBzYXlpbmcg
dGhhdCBuZnNkNF9jYl9yZWNhbGxfZG9uZSgpIHdpbGwgcmV0dXJuIGEgdmFsdWUgb2YgJzEnDQpm
b3IgYm90aCB0YXNrLT50a19zdGF0dXMgPT0gLUVCQURIQU5ETEUgYW5kIC1ORlM0RVJSX0JBRF9T
VEFURUlELiBJJ20NCm5vdCBzZWVpbmcgd2h5IGVpdGhlciBvZiB0aG9zZSBlcnJvcnMgc2hvdWxk
IGJlIGhhbmRsZWQgYnkgbWFya2luZyB0aGUNCmNhbGxiYWNrIGNoYW5uZWwgYXMgYmVpbmcgZG93
bi4NCg0KTG9va2luZyBmdXJ0aGVyLCBpdCBzZWVtcyB0aGF0IHRoZSBzYW1lIGZ1bmN0aW9uIHdp
bGwgYWxzbyByZXR1cm4gJzEnDQp3aXRob3V0IGNoZWNraW5nIHRoZSB2YWx1ZSBvZiB0YXNrLT50
a19zdGF0dXMgaWYgdGhlIGRlbGVnYXRpb24gaGFzDQpiZWVuIHJldm9rZWQgb3IgcmV0dXJuZWQu
IFNvIHRoYXQgd291bGQgbWVhbiB0aGF0IGV2ZW4gTkZTNEVSUl9ERUxBWQ0KY291bGQgdHJpZ2dl
ciB0aGUgY2FsbCB0byBuZnNkNF9tYXJrX2NiX2Rvd24oKSB3aXRoIHRoZSBhYm92ZSBjaGFuZ2Uu
DQoNCj4gDQo+ID4gPiANCj4gPiA+IC0tYi4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiDCoGZzL25mc2QvbmZzNGNhbGxiYWNrLmMgfCAxICsNCj4gPiA+ID4gwqAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnNkL25mczRjYWxsYmFjay5jIGIvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYw0KPiA+
ID4gPiBpbmRleCAwNTJiZTViZjllZjUuLjczMjU1OTJiNDU2ZSAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYw0KPiA+ID4gPiArKysgYi9mcy9uZnNkL25mczRjYWxs
YmFjay5jDQo+ID4gPiA+IEBAIC0xMTg5LDYgKzExODksNyBAQCBzdGF0aWMgdm9pZCBuZnNkNF9j
Yl9kb25lKHN0cnVjdCBycGNfdGFzaw0KPiA+ID4gPiAqdGFzaywgdm9pZCAqY2FsbGRhdGEpDQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKHRhc2stPnRrX3N0
YXR1cykgew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAtRUlP
Og0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAtRVRJTUVET1VU
Og0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIC1FQUNDRVM6DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZz
ZDRfbWFya19jYl9kb3duKGNscCwgdGFzay0NCj4gPiA+ID4gPnRrX3N0YXR1cyk7DQo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yNy4wDQo+ID4g
PiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gLS0NCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KPiA+IA0KPiA+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
