Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19178176F05
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 06:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgCCF7N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 00:59:13 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:22376
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgCCF7N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Mar 2020 00:59:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbx7RhzOmSdCymlEC9G/eFJjvRJhelwqL3Mf+dEHQshEMELnZdKR8ykKW2tmNIA9Fmr8/HCPW+4KYEcP3HYW1ANzbTboxHJx58gb8cHQKS/UrPFV/EkavE8uyB+MYdlwSzNz5vjry04+/Pws2FVG7JT5VZo/uqq55Q/mIFIrLbfF33fB0C+8gMkCk8ll6FJgLM1WUboYOJ4LoEwcdIwVTYngUNkX0TuMrIpvVRI524s/07EoNfVebr7CqaJsLXIhz7rPuUlDaX2CfW7uo2OI3a1nIiojbnZyk6zgo45TTp96mMipReWsPhVy6PFGHB7EFq3ea99dIgF+tE36S5UkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OtWXdJPK/0+TEu0mI3ePYEDtl5jKiuX/vApB2SIRGM=;
 b=dukq9veOOlVYe14XIca7tlxWX506Pz1LV1hA4PO/krRvdqJWnzp4clZvzkRHHTrnekG1FjVX8rQQk3/isxSec9Qma9gw4/elcbOe+ZJ+WJ/ECQvpSlsWeRN/X8I2lfJPBqTh+QFbcP/Yk3Q43xH+1LvAhCAWBeDVK+EWBtoAjk0AW12jW7jbuk9kr9XMFdz5u0nj7wjzCMF30noOKwIUtcWgWAj3Qg5N59eZNyXWFqIR54nKqTd+9QJzDEClBILz3tuUX5PQbgLJVl++VxiMM+NR2kjlz0QSknFaxPjWtPu3eVsC5e//MZT+f4zdNKG4WA61a1R1MWrXYwUKLc/Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OtWXdJPK/0+TEu0mI3ePYEDtl5jKiuX/vApB2SIRGM=;
 b=bTlTxnRKi1GJ312pFS2tyl4ZV3HCxX6oHrGJQJsfuezDm7p/9U0CxJrk4whjeaLtudRR90+is1zdcWY4tX98ljtO6vGiL7Qww5gZh1xSb9AKNeV3nCmfEU75F0mNGuJ6cZBcv3xoetWAxgekJur7+/FZwy/SAW/0k3lT2XeqGOk=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (2603:10b6:4:34::34)
 by DM5PR1301MB2140.namprd13.prod.outlook.com (2603:10b6:4:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.9; Tue, 3 Mar
 2020 05:59:08 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2793.011; Tue, 3 Mar 2020
 05:59:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/8] nfsd: Add tracing to nfsd_set_fh_dentry()
Thread-Topic: [PATCH 2/8] nfsd: Add tracing to nfsd_set_fh_dentry()
Thread-Index: AQHV8CCsYek8iLOEDUmusjyZKFEn/ag2A36AgABd8gA=
Date:   Tue, 3 Mar 2020 05:59:08 +0000
Message-ID: <3fa96b3a1ec599624d464085854a39a6b2b86447.camel@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
         <08ED0A31-365E-4F40-B041-4E30326FD8B1@gmail.com>
In-Reply-To: <08ED0A31-365E-4F40-B041-4E30326FD8B1@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c763c264-4d51-4e89-4c74-08d7bf37fd32
x-ms-traffictypediagnostic: DM5PR1301MB2140:
x-microsoft-antispam-prvs: <DM5PR1301MB2140BBC25C6646E7E18499DCB8E40@DM5PR1301MB2140.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39840400004)(199004)(189003)(91956017)(71200400001)(5660300002)(6512007)(66556008)(66946007)(76116006)(66476007)(36756003)(6486002)(2906002)(478600001)(4326008)(8936002)(26005)(186003)(53546011)(6506007)(316002)(2616005)(8676002)(81156014)(81166006)(86362001)(6916009)(64756008)(54906003)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2140;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yF9/a8M5lJXLGEcVhijMoBpLyYvxSjT6EtJG4KuRbu+cvqheSXTAlo6ZAD5csRY/cNf308Ojm8Gp8v8FcVoG7QxJj3HJv968uacnYcA/aQSN4HVFVozl6JooVRTXXKTEKPfyy98JocgPRQN+jGPLAzIL71vH8Z0SdKQ06knKH//07JzF540P6gT8LPpsbK7obmqqXpGfGYi6CqZ726TtRlz+lRWiYAmTzcFEdXeVDYzDjGYCxA7rMiWOU/0dwIfg33jAVnHhY49AoesU6tcZVDR2u3EYmfwIGCt1amhW5hzO5sI01BZIpfV69gCsXvuypS+uzuma6IXL1NwEI8OEpdQfoB0B6z10xtcgrkPlnDvr+HNF/rWG1Ms+xUkgGOAXHMY5WOhRaysRJAZOncdbIjw7Avr7AI4mUVXRjxZSfOIyjPf1BeKBsEoz55vZKBif
x-ms-exchange-antispam-messagedata: gnbSt4QV9JtrqEGz7H8ZvBj0eb1epSQ2TpaMe5BnrVhmUZWWk4wg64QLKEkEeQabbp5mesOchTHNJqqPoSgLvo+xlu3K8INY2xM34jV66ISIRYEcea504knlzu4zwC4vxrZ7qF8jrgjzZimd8EY79A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <277CAF7B10A7EB4A85A30430B419EBFE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c763c264-4d51-4e89-4c74-08d7bf37fd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 05:59:08.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzHGy1z97PdpGUesay9baje0mTt2bPCMj8tjOEaaC7bSjmJ+Nc4phA0MOQq14cy3dhBwVNqm7Pwf/7rD1G6jfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2140
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDE5OjIyIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBNYXIgMSwgMjAyMCwgYXQgNjoyMSBQTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGdt
YWlsLmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgdHJhY2luZyB0byBhbGxvdyB1cyB0
byBmaWd1cmUgb3V0IHdoZXJlIGFueSBzdGFsZSBmaWxlaGFuZGxlDQo+ID4gaXNzdWVzDQo+ID4g
bWF5IGJlIG9yaWdpbmF0aW5nIGZyb20uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+
IGZzL25mc2QvbmZzZmguYyB8IDEzICsrKysrKysrKystLS0NCj4gPiBmcy9uZnNkL3RyYWNlLmgg
fCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAyIGZpbGVzIGNoYW5nZWQs
IDQwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2ZzL25mc2QvbmZzZmguYyBiL2ZzL25mc2QvbmZzZmguYw0KPiA+IGluZGV4IGIzMTkwODAyODhj
My4uMzdiYzhmNWY0NTE0IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvbmZzZmguYw0KPiA+ICsr
KyBiL2ZzL25mc2QvbmZzZmguYw0KPiA+IEBAIC0xNCw2ICsxNCw3IEBADQo+ID4gI2luY2x1ZGUg
Im5mc2QuaCINCj4gPiAjaW5jbHVkZSAidmZzLmgiDQo+ID4gI2luY2x1ZGUgImF1dGguaCINCj4g
PiArI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4gDQo+ID4gI2RlZmluZSBORlNEREJHX0ZBQ0lMSVRZ
CQlORlNEREJHX0ZIDQo+ID4gDQo+ID4gQEAgLTIwOSwxMSArMjEwLDE0IEBAIHN0YXRpYyBfX2Jl
MzIgbmZzZF9zZXRfZmhfZGVudHJ5KHN0cnVjdA0KPiA+IHN2Y19ycXN0ICpycXN0cCwgc3RydWN0
IHN2Y19maCAqZmhwKQ0KPiA+IAl9DQo+ID4gDQo+ID4gCWVycm9yID0gbmZzZXJyX3N0YWxlOw0K
PiA+IC0JaWYgKFBUUl9FUlIoZXhwKSA9PSAtRU5PRU5UKQ0KPiA+IC0JCXJldHVybiBlcnJvcjsN
Cj4gPiArCWlmIChJU19FUlIoZXhwKSkgew0KPiA+ICsJCXRyYWNlX25mc2Rfc2V0X2ZoX2RlbnRy
eV9iYWRleHBvcnQocnFzdHAsIGZocCwNCj4gPiBQVFJfRVJSKGV4cCkpOw0KPiA+ICsNCj4gPiAr
CQlpZiAoUFRSX0VSUihleHApID09IC1FTk9FTlQpDQo+ID4gKwkJCXJldHVybiBlcnJvcjsNCj4g
PiANCj4gPiAtCWlmIChJU19FUlIoZXhwKSkNCj4gPiAJCXJldHVybiBuZnNlcnJubyhQVFJfRVJS
KGV4cCkpOw0KPiA+ICsJfQ0KPiA+IA0KPiA+IAlpZiAoZXhwLT5leF9mbGFncyAmIE5GU0VYUF9O
T1NVQlRSRUVDSEVDSykgew0KPiA+IAkJLyogRWxldmF0ZSBwcml2aWxlZ2VzIHNvIHRoYXQgdGhl
IGxhY2sgb2YgJ3InIG9yICd4Jw0KPiA+IEBAIC0yNjcsNiArMjcxLDkgQEAgc3RhdGljIF9fYmUz
MiBuZnNkX3NldF9maF9kZW50cnkoc3RydWN0DQo+ID4gc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qg
c3ZjX2ZoICpmaHApDQo+ID4gCQlkZW50cnkgPSBleHBvcnRmc19kZWNvZGVfZmgoZXhwLT5leF9w
YXRoLm1udCwgZmlkLA0KPiA+IAkJCQlkYXRhX2xlZnQsIGZpbGVpZF90eXBlLA0KPiA+IAkJCQlu
ZnNkX2FjY2VwdGFibGUsIGV4cCk7DQo+ID4gKwkJaWYgKElTX0VSUl9PUl9OVUxMKGRlbnRyeSkp
DQo+ID4gKwkJCXRyYWNlX25mc2Rfc2V0X2ZoX2RlbnRyeV9iYWRoYW5kbGUocnFzdHAsIGZocCwN
Cj4gPiArCQkJCQlkZW50cnkgPyAgUFRSX0VSUihkZW50cnkpIDoNCj4gPiAtRVNUQUxFKTsNCj4g
DQo+IElmIHlvdSdsbCBiZSByZXNwaW5uaW5nIHRoaXMgc2VyaWVzLCBhIGhhbmRmdWwgb2Ygbml0
czoNCj4gDQoNCkkgc2VlIG5vIG5lZWQgdG8gcmVzcGluIHRoZSBlbnRpcmUgc2VyaWVzLiBKdXN0
IHRoZSBsYXN0IHBhdGNoLg0KDQo+IC0gdGhlIGxpbmUgYWJvdmUgaGFzIGEgZG91YmxlIHNwYWNl
DQo+IC0gdGhlIHRyYWNlIHBvaW50IG5hbWVzIGhlcmUgYXJlIGEgbGl0dGxlIGxvbmcsIHdpbGwg
cmVzdWx0IGluDQo+ICAgaGFyZC10by1yZWFkIGZvcm1hdHRpbmcgaW4gdGhlIHRyYWNlIGxvZw0K
PiAtIGNoZWNrcGF0Y2gucGwgY29tcGxhaW5zIGFib3V0IGEgY291cGxlIG9mIHRoZSBsYXRlciBw
YXRjaGVzLA0KPiAgIHdoZXJlIG9uZSBhcm0gb2YgYW4gImlmIiBzdGF0ZW1lbnQgaGFzIGJyYWNl
cyBidXQgdGhlIG90aGVyDQo+ICAgZG9lcyBub3QNCj4gDQo+ID4gCX0NCj4gPiAJaWYgKGRlbnRy
eSA9PSBOVUxMKQ0KPiA+IAkJZ290byBvdXQ7DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvdHJh
Y2UuaCBiL2ZzL25mc2QvdHJhY2UuaA0KPiA+IGluZGV4IDA2ZGQwZDMzNzA0OS4uOWFiZDE1OTFh
ODQxIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvdHJhY2UuaA0KPiA+ICsrKyBiL2ZzL25mc2Qv
dHJhY2UuaA0KPiA+IEBAIC01MCw2ICs1MCwzNiBAQCBUUkFDRV9FVkVOVChuZnNkX2NvbXBvdW5k
X3N0YXR1cywNCj4gPiAJCV9fZ2V0X3N0cihuYW1lKSwgX19lbnRyeS0+c3RhdHVzKQ0KPiA+ICkN
Cj4gPiANCj4gPiArREVDTEFSRV9FVkVOVF9DTEFTUyhuZnNkX2ZoX2Vycl9jbGFzcywNCj4gPiAr
CVRQX1BST1RPKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsDQo+ID4gKwkJIHN0cnVjdCBzdmNfZmgJ
KmZocCwNCj4gPiArCQkgaW50CQlzdGF0dXMpLA0KPiA+ICsJVFBfQVJHUyhycXN0cCwgZmhwLCBz
dGF0dXMpLA0KPiA+ICsJVFBfU1RSVUNUX19lbnRyeSgNCj4gPiArCQlfX2ZpZWxkKHUzMiwgeGlk
KQ0KPiA+ICsJCV9fZmllbGQodTMyLCBmaF9oYXNoKQ0KPiA+ICsJCV9fZmllbGQoaW50LCBzdGF0
dXMpDQo+ID4gKwkpLA0KPiA+ICsJVFBfZmFzdF9hc3NpZ24oDQo+ID4gKwkJX19lbnRyeS0+eGlk
ID0gYmUzMl90b19jcHUocnFzdHAtPnJxX3hpZCk7DQo+ID4gKwkJX19lbnRyeS0+ZmhfaGFzaCA9
IGtuZnNkX2ZoX2hhc2goJmZocC0+ZmhfaGFuZGxlKTsNCj4gPiArCQlfX2VudHJ5LT5zdGF0dXMg
PSBzdGF0dXM7DQo+ID4gKwkpLA0KPiA+ICsJVFBfcHJpbnRrKCJ4aWQ9MHglMDh4IGZoX2hhc2g9
MHglMDh4IHN0YXR1cz0lZCIsDQo+ID4gKwkJICBfX2VudHJ5LT54aWQsIF9fZW50cnktPmZoX2hh
c2gsDQo+ID4gKwkJICBfX2VudHJ5LT5zdGF0dXMpDQo+ID4gKykNCj4gPiArDQo+ID4gKyNkZWZp
bmUgREVGSU5FX05GU0RfRkhfRVJSX0VWRU5UKG5hbWUpCQlcDQo+ID4gK0RFRklORV9FVkVOVChu
ZnNkX2ZoX2Vycl9jbGFzcywgbmZzZF8jI25hbWUsCVwNCj4gPiArCVRQX1BST1RPKHN0cnVjdCBz
dmNfcnFzdCAqcnFzdHAsCVwNCj4gPiArCQkgc3RydWN0IHN2Y19maAkqZmhwLAkJXA0KPiA+ICsJ
CSBpbnQJCXN0YXR1cyksCVwNCj4gPiArCVRQX0FSR1MocnFzdHAsIGZocCwgc3RhdHVzKSkNCj4g
PiArDQo+ID4gK0RFRklORV9ORlNEX0ZIX0VSUl9FVkVOVChzZXRfZmhfZGVudHJ5X2JhZGV4cG9y
dCk7DQo+ID4gK0RFRklORV9ORlNEX0ZIX0VSUl9FVkVOVChzZXRfZmhfZGVudHJ5X2JhZGhhbmRs
ZSk7DQo+ID4gKw0KPiA+IERFQ0xBUkVfRVZFTlRfQ0xBU1MobmZzZF9pb19jbGFzcywNCj4gPiAJ
VFBfUFJPVE8oc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4gPiAJCSBzdHJ1Y3Qgc3ZjX2ZoCSpm
aHAsDQo+ID4gLS0gDQo+ID4gMi4yNC4xDQo+ID4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0K
PiBjaHVja2xldmVyQGdtYWlsLmNvbQ0KPiANCj4gDQo+IA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
