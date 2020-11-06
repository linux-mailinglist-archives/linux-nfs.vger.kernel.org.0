Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD32A98A2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 16:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgKFPio (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 10:38:44 -0500
Received: from mail-dm6nam10on2117.outbound.protection.outlook.com ([40.107.93.117]:42333
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbgKFPio (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Nov 2020 10:38:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJswrzvUa6c/pJ6Cf+/V0mV+4BT4RGqJTpq8lK8yArcM1LB0ciYAgOYHO6WSLgU+ZSX63IWJ63iLyNB2TGcrXAjfplcr+mUZ35M5AvXguF5FBkf4VsBG0PfCupuXPlyxfACFvV6BHECdfUUeBlrWUqWMPeBhXkps+v995sFSoDcS/KUrS2JtIsiMuT388p4D6qKL06Po7S6SkZQDUFcLFecNr0sgiIxRVF0lnTJAPOn3kFWoB00XI8F5VHNPntzsLOfLXZxDT397N5+ilIRZRXknhYfkTkOlYOP3OP0ZjyD139gKg1c4/RAbuWuQJf1J72F2oU9l5/H2MMHFwovB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G+D8YSpHpKt7+8Zn+rqKobeQjt25nNXB5mVV8lr0vc=;
 b=R5x9aZlvjm5pl8dF8ZZdVVNVLq+f1bahhiyS5WhJHJZ8rAiD6mvj39tlsaqD1qUdItji1SJVQ+5Mukc0vgzOFOX07Ywq7br1OkilMbxBQNply4o6qsM2kb+jtiapdBq2Zs/rjFLpnT7wKwrfB1FGKDR2dzcwRBIRaUaIcYLEKR6dk5YW3oqxOld5Z/70fnuIs1xz0uLndqAu2KDfYD8LS6XwlQ6gLKb7jNiVn1PeqqfAXk24aqmDw+5eEWN6zucbivF6ZsHK0/5XuYlTOy55jwELWYrKLiEAkRYk/dna+vtGIZnwhL2PKs9gFGnbj123u/9g0SHuvwb0H5praXe9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G+D8YSpHpKt7+8Zn+rqKobeQjt25nNXB5mVV8lr0vc=;
 b=K8n3nJmMMMx8lmfQ5iUICC4plj9cC/HMXFFJqE1n8ZfQgxDi+Hixsqij48C1HMZYZeNHI6DgiRj1S3/RDVxQ/KlZqM5UXU/OCWCQzMQ9qT47j6RjSfsiLSJ0c3OeyOx7UvIGisGDfM74STYNrJj8wzh2xGb77qaMQh/raNMpPZw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3229.namprd13.prod.outlook.com (2603:10b6:208:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Fri, 6 Nov
 2020 15:38:39 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Fri, 6 Nov 2020
 15:38:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
Thread-Topic: [PATCH v3 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
Thread-Index: AQHWtEr71WGV1p719k2sMh2biXEKzqm7PTOA
Date:   Fri, 6 Nov 2020 15:38:39 +0000
Message-ID: <858fb8f0623a9a75de5633e9761d632ca80b49b2.camel@hammerspace.com>
References: <20201106144154.3610-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20201106144154.3610-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: decff2a5-c182-49df-4130-08d8826a088e
x-ms-traffictypediagnostic: MN2PR13MB3229:
x-microsoft-antispam-prvs: <MN2PR13MB3229C91201C7921B798013DBB8ED0@MN2PR13MB3229.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00VDl8Qi+A0r9Ak5M+rXIpqMYirIRVJTm/3NqTgxUWR9ukVV0bCk+unKy/Qb1+6qDNlP+sYiPbBaXEuUq1+Hpl2RoOMz/nceAeEnErfVGRf8MdcDW3K+ey7XZ3tohMqZyMkb/zAHUPmuKgoEjeHfUwxcQQHYhbyTMILlJP/6HSVrH6mijGTZYYS5ybOlE++XrbS12XFdkU35o2swap8tOPlCkBSyCivTZDVSPkij5A++leBoKzISXd1Xa/62fLGv+1/cc8u3edtu0oRzVk2LdY2ZLEXqqMd/LBIM1q45xIJHDeVWqWaoPDERhDfkZicBw9+TLSJQDePUNPnzs86D4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39830400003)(396003)(136003)(36756003)(110136005)(6512007)(86362001)(6486002)(2906002)(54906003)(5660300002)(66556008)(26005)(316002)(6506007)(66946007)(186003)(64756008)(66476007)(2616005)(4326008)(76116006)(66446008)(8936002)(8676002)(15650500001)(478600001)(91956017)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ab+ZPr0RX4uwjrpqwlfX878FNVFwAsmwa6qinN06Wo3hkx7fd73oxkWU8rIVPRlQEUMYjHNU3B47+k5zfJ4tB8Ql3JMVxJiJoib8ArtvgdPBj1fYSgQqIzzU1tDRcw7x73TcL3R9EFDS5Q7yC9lpqecWO2bjywRw3pN8PNnoIaFsyHT9Ygudq51OEmGgzSARh4SUFMfpOAcbATG1wN9oxvh4Q6EyTzssTNvoOJ0qqk/2gUOq58Y8qrUgk01aO4XPJPTefqkrr9G24w0f9g3+rj+EahyxGqsuM152IQJJUMTk/LVGg5mj2PMZx5Nac+d1Kgvm4ucjO3wJBKi2bSVDQqBq5uimHRTHWE2WvYGYhuS0xe+2Jcir76vE7GHMllYvHDk+LY3Fdkksv47VtUhHQ3J8kP/AZgz7piEi/sWZAZeD6IM3FpYLBWimMD1dYCqiKTnmOYOGZ0YnK8NhB5vnLvh4hvzTg06QlWDiXLgSstTTwi8ePFPH4btYU5ESOSkGo+Lnh22IQF4EjS3fBRJ/R5E8Rt/HL2iApGNeHl3eVnMvjAP+oGjJhZC660b87H+swmSCzpq1aO1HaX9nkY7uioXR9Jc43r/KRa5SX2OUhUKwK/CAWSYMGkgum3N5ThtOObBdhlZesn9Bk34dqkXjoA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <02540BB9FA0F7A4282FA97851421C1CA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decff2a5-c182-49df-4130-08d8826a088e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 15:38:39.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hYO/qCwbNFFsUANMZRsViWFfNUz+1saQgCqwm6sLIGI9S40JF5VKGPQXxwyC2q7AGNpXMnnRLfEEW3of+Z9rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3229
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTA2IGF0IDA5OjQxIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBD
dXJyZW50bHksIHRoZSBjbGllbnQgd2lsbCBhbHdheXMgYXNrIGZvciBzZWN1cml0eV9sYWJlbHMg
aWYgdGhlDQo+IHNlcnZlcg0KPiByZXR1cm5zIHRoYXQgaXQgc3VwcG9ydHMgdGhhdCBmZWF0dXJl
IHJlZ2FyZGxlc3Mgb2YgYW55IExTTSBtb2R1bGVzDQo+IChzdWNoIGFzIFNlbGludXgpIGVuZm9y
Y2luZyBzZWN1cml0eSBwb2xpY3kuIFRoaXMgYWRkcyBwZXJmb3JtYW5jZQ0KPiBwZW5hbHR5IHRv
IHRoZSBSRUFERElSIG9wZXJhdGlvbi4NCj4gDQo+IENsaWVudCBhZGp1c3RzIHN1cGVyYmxvY2sn
cyBzdXBwb3J0IG9mIHRoZSBzZWN1cml0eV9sYWJlbCBiYXNlZCBvbg0KPiB0aGUgc2VydmVyJ3Mg
c3VwcG9ydCBidXQgYWxzbyBjdXJyZW50IGNsaWVudCdzIGNvbmZpZ3VyYXRpb24gb2YgdGhlDQo+
IExTTSBtb2R1bGVzLiBUaHVzLCBwcmlvciB0byB1c2luZyB0aGUgZGVmYXVsdCBiaXRtYXNrIGlu
IFJFQURESVIsDQo+IHRoaXMgcGF0Y2ggY2hlY2tzIHRoZSBzZXJ2ZXIncyBjYXBhYmlsaXRpZXMg
YW5kIHRoZW4gaW5zdHJ1Y3RzDQo+IFJFQURESVIgdG8gcmVtb3ZlIEZBVFRSNF9XT1JEMl9TRUNV
UklUWV9MQUJFTCBmcm9tIHRoZSBiaXRtYXNrLg0KPiANCj4gdjM6IGNoYW5naW5nIGxhYmVsJ3Mg
aW5pdGlhbGl6YXRpb24gcGVyIE9uZHJlaidzIGNvbW1lbnQNCj4gdjI6IGRyb3BwaW5nIHNlbGlu
dXggaG9vayBhbmQgdXNpbmcgdGhlIHNiIGNhcC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogT25kcmVq
IE1vc25hY2VrIDxvbW9zbmFjZUByZWRoYXQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IFNjb3R0IE1h
eWhldyA8c21heWhld0ByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZz
a2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzL25mczRwcm9jLmPCoMKg
wqDCoMKgwqAgfCAyICsrDQo+IMKgZnMvbmZzL25mczR4ZHIuY8KgwqDCoMKgwqDCoMKgIHwgMyAr
Ky0NCj4gwqBpbmNsdWRlL2xpbnV4L25mc194ZHIuaCB8IDEgKw0KPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBpbmRleCA5ZTBjYTliMmIyMTAu
LmQ4NWM3ODY1N2VmNCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIv
ZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTQ5NjgsNiArNDk2OCw4IEBAIHN0YXRpYyBpbnQgX25m
czRfcHJvY19yZWFkZGlyKHN0cnVjdCBkZW50cnkNCj4gKmRlbnRyeSwgY29uc3Qgc3RydWN0IGNy
ZWQgKmNyZWQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmNvdW50ID0gY291
bnQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmJpdG1hc2sgPSBORlNfU0VS
VkVSKGRfaW5vZGUoZGVudHJ5KSktPmF0dHJfYml0bWFzaywNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAucGx1cyA9IHBsdXMsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAubGFiZWxzID0gISEoTkZTX1NCKGRlbnRyeS0+ZF9zYiktPmNhcHMgJg0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBO
RlNfQ0FQX1NFQ1VSSVRZX0xBQkVMKSwNCg0KU2luY2UgYm90aCBiaXRtYXNrIGFuZCBsYWJlbHMg
ZGVyZWZlcmVuY2UgdGhlIHNhbWUgJ3N0cnVjdCBuZnNfc2VydmVyJw0KKGFsdGhvdWdoIG9uZSBk
b2VzIGl0IHRocm91Z2ggTkZTX1NFUlZFUigpIGFuZCB0aGUgb3RoZXIgdXNlcyBORlNfU0IoKSkN
CnRoZW4gd2h5IG5vdCBhZGQgYSAnc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZlcicgdmFyaWFibGUg
Zm9yIGJvdGggdG8NCnVzZT8NCg0KPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBuZnM0X3JlYWRkaXJfcmVzIHJlczsNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBycGNfbWVzc2FnZSBtc2cgPSB7DQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHhkci5jIGIv
ZnMvbmZzL25mczR4ZHIuYw0KPiBpbmRleCBjNmRiZmNhZTc1MTcuLjU4NWQ1YjVjYzNkYyAxMDA2
NDQNCj4gLS0tIGEvZnMvbmZzL25mczR4ZHIuYw0KPiArKysgYi9mcy9uZnMvbmZzNHhkci5jDQo+
IEBAIC0xNjA1LDcgKzE2MDUsOCBAQCBzdGF0aWMgdm9pZCBlbmNvZGVfcmVhZGRpcihzdHJ1Y3Qg
eGRyX3N0cmVhbQ0KPiAqeGRyLCBjb25zdCBzdHJ1Y3QgbmZzNF9yZWFkZGlyX2FyZw0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBGQVRUUjRfV09SRDFf
T1dORVJfR1JPVVB8RkFUVFI0X1dPUkQxX1JBV0RFVnwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRkFUVFI0X1dPUkQxX1NQQUNFX1VTRUR8RkFUVFI0
X1dPUkQxX1RJTUVfQUNDDQo+IEVTU3wNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgRkFUVFI0X1dPUkQxX1RJTUVfTUVUQURBVEF8RkFUVFI0X1dPUkQx
X1RJTUVfDQo+IE1PRElGWTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF0dHJz
WzJdIHw9IEZBVFRSNF9XT1JEMl9TRUNVUklUWV9MQUJFTDsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChyZWFkZGlyLT5sYWJlbHMpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXR0cnNbMl0gfD0gRkFUVFI0X1dPUkQyX1NFQ1VS
SVRZX0xBQkVMOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRpcmNvdW50ID4+
PSAxOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgLyogVXNlIG1vdW50
ZWRfb25fZmlsZWlkIG9ubHkgaWYgdGhlIHNlcnZlciBzdXBwb3J0cyBpdCAqLw0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9uZnNfeGRyLmggYi9pbmNsdWRlL2xpbnV4L25mc194ZHIuaA0K
PiBpbmRleCBkNjNjYjg2MmQ1OGUuLjk1ZjY0OGIyNjUyNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9uZnNfeGRyLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9uZnNfeGRyLmgNCj4gQEAg
LTExMTksNiArMTExOSw3IEBAIHN0cnVjdCBuZnM0X3JlYWRkaXJfYXJnIHsNCj4gwqDCoMKgwqDC
oMKgwqDCoHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwZ2Jhc2U7wqAvKiB6ZXJvLWNvcHkgZGF0YSAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qg
dTMyICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaXRtYXNrOw0K
PiDCoMKgwqDCoMKgwqDCoMKgYm9vbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcGx1czsNCj4gK8KgwqDCoMKgwqDCoMKgYm9vbMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGFiZWxzOw0K
PiDCoH07DQo+IMKgDQo+IMKgc3RydWN0IG5mczRfcmVhZGRpcl9yZXMgew0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
