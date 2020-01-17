Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2EB1412B0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAQVQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:16:59 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:13756
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbgAQVQ6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:16:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyU9+BM2Sci+Gy3TpHsSqqW3gV4VWuUcMat3MOjn1p25qO7Cn7cTpZIafZ76zYGZvI4uRh6gAYdVUhJn9j4B//MBrgCedZPk+s05BG3PKbhkha/xsfBrA7A2Ofexk2cXm/UNeLj3WJYnjDGiS4MmHtR5w8jx880eZAp5ytK4s2FqCotxl48H4M5bE2wtV2xPW0hCQ53xXxLFshOUijd98vUQv3P1JCwvoV4tpCQO1T7nDu6GHN+NaeAThggRz15IAmo+BtOM9Yi+B9qbN/HFbHxSMQUd7N76R9mbw65n0vXORw9vnkYeFOKELrnCzGmB1SACIfwf+bBfBg4VR+B4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GucuhrOvvFbSk6CpfzLqZEr4ozabFYJR7IefEhgMWRc=;
 b=HPkTEft7GK+lYt8p5yhakI2zBaylpe/zJtNahr/cDikNlI5DuDl442riawlOqSlSE5EsTUX6W/wknG5H/vVXCRFlYbwyd9iYGag+fy+yVgRa8nPFQ0RaUX5938jDlHgjMoQtuCSim9VMtjvmRbsWlZtHiCiTaz8E/qT6Ma0ejIKTiIATQwGT1s11sZAGwIIONuaPVcnUW4G604bb4Mwpz8aaFOnZxHdRGavKfBJTpr2oQ4RZojY3F4ChgqL93XuMCxjKVaGCI54NLrpnKRhQDAfrWlXPVpKHtdfn2alp5IGX6Yq0o/RFBIvmi6gGh/fme2BzdN7d2k9ww6i6XavM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GucuhrOvvFbSk6CpfzLqZEr4ozabFYJR7IefEhgMWRc=;
 b=RvO/tVNYe4vpMoP7nRf54CGyWBJTdU1PWwd1+2sSuXbaWQSCgiLmqpueq+9osc5CeX+D/EKIG4Ki50605kSX2vvQVdj+vS0OYrAJNb2SRzc6flxO3DtGW3HG/wOUdQgcgY/oC/dgFkOQxaRshpzPbH8iX63x4C9ajIbKFTqt0pw=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4978.namprd06.prod.outlook.com (10.167.240.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Fri, 17 Jan 2020 21:16:55 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 21:16:55 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Topic: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Index: AQHVzKBvkFwiKJer6kCJD5wdp4VGvafvW6oAgAABPoCAAAC5AA==
Date:   Fri, 17 Jan 2020 21:16:54 +0000
Message-ID: <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
         <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
         <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
In-Reply-To: <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e5d28be-6c87-4969-7ee2-08d79b929436
x-ms-traffictypediagnostic: BL0PR06MB4978:
x-microsoft-antispam-prvs: <BL0PR06MB4978D0D4292F05C6DB5C4427F8310@BL0PR06MB4978.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(76116006)(36756003)(26005)(64756008)(66556008)(6486002)(316002)(6506007)(186003)(91956017)(66476007)(66446008)(110136005)(66946007)(6512007)(86362001)(5660300002)(81166006)(4326008)(81156014)(8676002)(478600001)(8936002)(2906002)(71200400001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4978;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggXSt9pfbMjp/EuZhu4LLsKA3bQ22vPeURqidGI9En62IamAt8uR3yDSZBYkN8ft1eRcMx80fSZz0nrIESqCR86hk7qtHfWN31YV3fZQQhIEFk8XtEAAWcoudkv/hXhr7xHvbZ0ufiGqwEJzG+xQYQzND6j3S3a38k/IoV7bYm70koT+QvdiJDAjqgIQAeYs4nuids/fRt1gZzriGwq/cRiLQSYDSFTfwS1LR6rrU7h9pZdfY2frp6DxmpXrF70ulzE5dA43zlEbeR5kosDH5ErxFGDkPHV8H1qVlCocSofYdrwbGrCQJIolCHoT5LTCJ0M+IHn6Y4I3pKFqGBAz2qDxxZRkT3/BOi4/+qdV/hSfhrrl6rj+rau3GMjVk7Oeks0kleVYWHBPhVaauIFhOP76mdbbHi0z8RJM1O6SbczH7pETW89x8KNkblx958e2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9150EC8FFA95484D87ED4E17B688FF75@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5d28be-6c87-4969-7ee2-08d79b929436
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 21:16:54.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXLORz7/IS5VkQEiVMkB+zgbMoMbhbRTQxN/nUsdslL3EbIbLlShAvAkQcYAKE37WuTVJnGFz8k1sVy1Xy0LuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4978
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDIxOjE0ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMC0wMS0xNyBhdCAyMTowOSArMDAwMCwgU2NodW1ha2VyLCBBbm5hIHdy
b3RlOg0KPiA+IEhpIE9sZ2EsDQo+ID4gDQo+ID4gT24gVGh1LCAyMDIwLTAxLTE2IGF0IDE0OjA4
IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IEZyb206IE9sZ2EgS29ybmll
dnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+IA0KPiA+IEhhdmUgeW91IGRvbmUgYW55IHRl
c3Rpbmcgd2l0aCBuY29ubmVjdCBhbmQgdGhlIHY0LjAgcmVwbGF5IGNhY2hlcz8gSQ0KPiA+IGRp
ZCBzb21lDQo+ID4gZGlnZ2luZyBvbiB0aGUgbWFpbGluZyBsaXN0IGFuZCBmb3VuZCB0aGlzIGlu
IG9uZSBvZiB0aGUgY292ZXINCj4gPiBsZXR0ZXJzIGZyb20NCj4gPiBUcm9uZDogIlRoZSBmZWF0
dXJlIGlzIG9ubHkgZW5hYmxlZCBmb3IgTkZTdjQuMSBhbmQgTkZTdjQuMiBmb3Igbm93Ow0KPiA+
IEkgZG9uJ3QNCj4gPiBmZWVsIGNvbWZvcnRhYmxlIHN1YmplY3RpbmcgTkZTdjMvdjQgcmVwbGF5
IGNhY2hlcyB0byB0aGlzIHRyZWF0bWVudA0KPiA+IHlldC4iDQo+ID4gDQo+IA0KPiBUaGF0IGNv
bW1lbnQgc2hvdWxkIGJlIGNvbnNpZGVyZWQgb2Jzb2xldGUuIFRoZSBjdXJyZW50IGNvZGUgd29y
a3MgaGFyZA0KPiB0byBlbnN1cmUgdGhhdCB3ZSByZXBsYXkgdXNpbmcgdGhlIHNhbWUgY29ubmVj
dGlvbiAob3IgYXQgbGVhc3QgdGhlDQo+IHNhbWUgc291cmNlL2Rlc3QgSVArcG9ydHMpIHNvIHRo
YXQgTkZTdjMvdjQuMCBEUkNzIHdvcmsgYXMgZXhwZWN0ZWQuDQo+IEZvciB0aGF0IHJlYXNvbiB3
ZSd2ZSBoYWQgTkZTdjMgc3VwcG9ydCBzaW5jZSB0aGUgZmVhdHVyZSB3YXMgbWVyZ2VkLg0KPiBU
aGUgTkZTdjQuMCBzdXBwb3J0IHdhcyBqdXN0IGZvcmdvdHRlbi4NCg0KVGhhbmtzIGZvciB0aGUg
ZXhwbGFuYXRpb24hIEknbGwgYWRkIHRoZSBwYXRjaC4NCg0KQW5uYQ0KDQo+IA0KPiA+IFRoYW5r
cywNCj4gPiBBbm5hDQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2Fp
YSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGZzL25mcy9uZnM0Y2xpZW50
LmMgfCAyICstDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNGNsaWVudC5jIGIv
ZnMvbmZzL25mczRjbGllbnQuYw0KPiA+ID4gaW5kZXggNDYwZDYyNS4uNGRmM2ZiMCAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0
Y2xpZW50LmMNCj4gPiA+IEBAIC04ODEsNyArODgxLDcgQEAgc3RhdGljIGludCBuZnM0X3NldF9j
bGllbnQoc3RydWN0IG5mc19zZXJ2ZXINCj4gPiA+ICpzZXJ2ZXIsDQo+ID4gPiAgDQo+ID4gPiAg
CWlmIChtaW5vcnZlcnNpb24gPT0gMCkNCj4gPiA+ICAJCV9fc2V0X2JpdChORlNfQ1NfUkVVU0VQ
T1JULCAmY2xfaW5pdC5pbml0X2ZsYWdzKTsNCj4gPiA+IC0JZWxzZSBpZiAocHJvdG8gPT0gWFBS
VF9UUkFOU1BPUlRfVENQKQ0KPiA+ID4gKwlpZiAocHJvdG8gPT0gWFBSVF9UUkFOU1BPUlRfVENQ
KQ0KPiA+ID4gIAkJY2xfaW5pdC5uY29ubmVjdCA9IG5jb25uZWN0Ow0KPiA+ID4gIA0KPiA+ID4g
IAlpZiAoc2VydmVyLT5mbGFncyAmIE5GU19NT1VOVF9OT1JFU1ZQT1JUKQ0KPiAtLSANCj4gVHJv
bmQgTXlrbGVidXN0DQo+IExpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
Cj4gdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiANCj4gDQo=
