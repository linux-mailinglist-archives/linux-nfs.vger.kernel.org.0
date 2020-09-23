Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84C276177
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWTzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 15:55:09 -0400
Received: from mail-eopbgr760101.outbound.protection.outlook.com ([40.107.76.101]:20238
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgIWTzJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 23 Sep 2020 15:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0cfOXTAxVbeLImkjo1tpmGCW+gbv/jNKX9ig4np4ZiGiG8lvAA2oZdWibQ7ViezqWZBXXtQ+Y6CxVHsceI7uznuoMff7rhPlFKs1lR/g9Cl1ZnOUFUg7HcFetj5sobeSVKZ+8vcc6sTlIGA9HOEpzU+hA+7bXhbDsZ78VGroNXZyzoMKxc3qbHjhKv4LTl77qtQSGMgn1Z/Eyotd9vXMQvlVepz42WAbYu7FxLGquMW8O9VsCPreZ5xtM0ycVskyYTJMBvihe6ectccCGj6HkwJf5usqIuApun3iTN8Mir2dQr8b+7Pvpk+28arrX0syCyJzClzfcyyZGjH3BJpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woduqLLTbnAMVA7FIr5vPO7M2lCHeuFm/FBAq8VozKM=;
 b=Evsq7MWe1gnXqFBAkEORLC/LstbufSPL73/0hf/B6K0iT9QteDX2pXfzrIuWV7yrIBZ40Jf71qMVnQQWOZBdCgY68ONntTmuP8P3yp3cn54mf7KGudUhJN1D0SgXdjREwtuNCdkZKE3D2SbBC8ttpvzXcCPEB+jTIfOIod/2zUh0Wxs94K6xmjaDTqz4T1axWoXk3vDkMRS+GtkS8oAhxI/atHTI7oL7uhk2MvQSTS7xtQtSXwDbbdk5/k28FzYJ9OG29fqOJsZZPIrthHuqkLqUt/t5V7sAdrisYkPDrGHMhq4ohiuw/qv46Ky6xVlVnkTC8cYpXTi1kRoiG2dghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woduqLLTbnAMVA7FIr5vPO7M2lCHeuFm/FBAq8VozKM=;
 b=BkPLbCRnO0uyGVBnEkcMGMBcupNxWHauVoVKwzGZxPbXDd/phyNC0F9oJKE5QobVYLQ+QtbQxwlvn860XsamOS4XLg6WV6HWuqSObhYIg4TjgKwZTBJOiUPyNLiLUfOY5FtIN0EzryBmB8Ev43reQiPMUFUrnz4P5WEx/u4k3Zg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3008.namprd13.prod.outlook.com (2603:10b6:208:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6; Wed, 23 Sep
 2020 19:55:05 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.013; Wed, 23 Sep 2020
 19:55:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Topic: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Index: AQHWkdAtEMKsMIWKs0WWIwkhmSwpm6l2kgaAgAAKGgCAAALUAIAAAfSAgAACUoA=
Date:   Wed, 23 Sep 2020 19:55:05 +0000
Message-ID: <4bf3ea6b9522a15447196774dc0427eaeb83dde6.camel@hammerspace.com>
References: <cover.1600882430.git.bcodding@redhat.com>
         <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
         <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
         <24324678-510B-4524-8C17-EB7365C2A3CD@redhat.com>
         <3053ab24162fbb9431f4918373aaa919c3b55a34.camel@hammerspace.com>
         <A38F09A7-34FC-483C-8629-51BA2D833DAD@redhat.com>
In-Reply-To: <A38F09A7-34FC-483C-8629-51BA2D833DAD@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 116e7f7d-ba66-4b1c-e94b-08d85ffa9148
x-ms-traffictypediagnostic: MN2PR13MB3008:
x-microsoft-antispam-prvs: <MN2PR13MB3008F6C6026D8F25E2467E8CB8380@MN2PR13MB3008.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oM6ZDcxrDthk0Q7jf4TUX2eOOWprihXlXv0lfG5KU32f4XX/QT1RVnXMKBxergI/iyXWSZO2gqcbE1ekNy7fPZTPwmBrfXqmSTyg09Pft6Aj/ie4XS35n8sztXiziesyNPlfxDNOPCHpoPB2rwKgsq2XlxDi5DobLT9wB6FNi1eqjjBSQr/bnYRvSd/vdgF2ibrWgCUs1PxrnnUmCMGb3sTGdHD7K4b7+dZgrd8VUZvBRlcoN+SilEkj6U5Zl3Z0jVkO6G8PyfrttmQURQ9LzQ2emkRj7pwGCvbBBBRGVYecXfVebR/ZzAjtz0IVRlRuhae2SN3xFU19hEWPWnAp/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(346002)(366004)(136003)(396003)(26005)(64756008)(66446008)(478600001)(2616005)(6506007)(53546011)(91956017)(4744005)(71200400001)(66476007)(2906002)(76116006)(66556008)(5660300002)(66946007)(6512007)(8676002)(6486002)(86362001)(186003)(54906003)(36756003)(4326008)(6916009)(83380400001)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: udmKbZwRswmcdsaqE3NKCi5GwXF2s8k9LrZIi0aaausMJzlnbBTuBrdOpumayJ0BmGPTKcIC9LK2pgIceqc7zTLEt5gmm1oPuNingJZhx/nEgLUlyGpDj+vvFACvXuySCPOvY/gaoRCEneJpQO2rV2BD2qs7jXKe9R2MeoKvthUVNz27RoXLwshkfnFgcrPnE1h1wBlIJINDy1cMqBxCrvLXa/J32jz6le3Z6OlnszADb5opT/YZLl66B0/SfkbmZ9E0ca4tNBqQFjfVHFybvo7oQodKLEigADkc55D5cutzAmBSVWMseSM/vpfAroshM6wd78cp64qDUKdmchyWI1PE0MQvX7ge5rBfYiwWRJ4IdMCZP4JyuwCfC1eA3RuZSabwVjlvt4XWPx80MaTfH5aVZXw4yky2ZX1X8vO4ALEbpzjGrkpAZJd50Q3P0oOz2cN68UEP4slhYDhqAvmbfD+OC8z3YxfM7dIGOnOCijFNdw69chfH4IygbNNQBMa+ErdhaIuVS7Z8EmckWIFahtRU6ORPfDHvwogHi3w8GyWE6I8pLkwo81eaZlUftKw0A8zswEudyLo/GwiVWCbSuJCoQwYMZrURGUNpRQ0wmqPU0l7P5HjGj3szQ6nUZZ2qsYflvla6x1ADk+cBJwammg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF1D708EAF28D848B07F9AB030233A13@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e7f7d-ba66-4b1c-e94b-08d85ffa9148
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 19:55:05.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSxT70XIUjvuCPwAsTbZCGz6lE0RbDOJSz2xVI9uVtUXk9J7FkI6JLP4PKADvQzxkwNLUlFCUrrbPVY5/8xPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3008
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDE1OjQ2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMyBTZXAgMjAyMCwgYXQgMTU6MzksIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiBUaGUgY2xpZW50IGNhbid0IHByZWRpY3Qgd2hhdCBpcyBnb2luZyB0byBoYXBwZW4gdy5y
LnQuIGFuIE9QRU4NCj4gPiBjYWxsLg0KPiA+IElmIGl0IGRvZXMgYW4gb3BlbiBieSBuYW1lLCBp
dCBkb2Vzbid0IGV2ZW4ga25vdyB3aGljaCBmaWxlIGlzDQo+ID4gZ29pbmcgdG8NCj4gPiBnZXQg
b3BlbmVkLiBUaGF0J3Mgd2h5IHdlIGhhdmUgdGhlIHdhaXQgbG9vcA0KPiA+IGluIG5mc19zZXRf
b3Blbl9zdGF0ZWlkX2xvY2tlZCgpLiBXaHkgc2hvdWxkIHdlIG5vdCBkbyB0aGUgc2FtZSBpbg0K
PiA+IENMT1NFIGFuZCBPUEVOX0RPV05HUkFERT8gSXQncyB0aGUgc2FtZSBwcm9ibGVtLg0KPiAN
Cj4gSSB3aWxsIGdpdmUgaXQgYSBzaG90LiAgSW4gdGhlIG1lYW50aW1lLCBwbGVhc2UgY29uc2lk
ZXIgYWRkaW5nIHRoaXMNCj4gcGF0Y2gNCj4gd2hpY2ggZml4ZXMgYSByZWFsIGJ1ZyB0b2RheS4g
IFRoYW5rIHlvdSBmb3IgeW91ciBleGNlbGxlbnQgYWR2aWNlDQo+IGFuZCB0aW1lLg0KPiANCg0K
SSBkb24ndCB0aGluayB3ZSBzaG91bGQgdGFrZSB0aGF0IHBhdGNoLCBhbmQgY2VydGFpbmx5IG5v
dCBhcyBhIHN0YWJsZQ0KcGF0Y2guIEknZCBwcmVmZXIgdG8gd2FpdCBmb3IgdGhlIHJlYWwgZml4
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
