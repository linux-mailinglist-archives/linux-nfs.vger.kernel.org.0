Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667743A059D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHVVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:21:24 -0400
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:37889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230297AbhFHVVY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 17:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyeL5/rsGiTJDTzzBzOoP4/KI2yk3BGKJnkrcIWcgyXY+u13egO3IcKDP2ipurVlYj5XK4dkqYvYKGjteJSyqRNHFB//c5RNEjLpachsaCMxlS30wdLEjxe3Qbk9tDMg3+6dSXBTY+9vS8PoY0zYVuZTOxtlTZevhTdSTR4Jd8RJ/X5u4kVGHltAAHT4ypehA1u8D5dM6e7H9PUp4ixRNXuia7yhICiRIxXpezykaL6b3XYiaXXp1O70bNHOb18Bf742/ZpVUNFspshSamLQkYBbdULsV/vT4Xf5Zf/1QygjA+Jp6xbyEHU4/+5MmsfXKLUARDdxJ1a5z0nn5cE/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7webFF+iTjcwNkW+1tNp6zLJjsEntAuYun/N2okITY=;
 b=IB3qSrm9WnxeEGW+6s7VjA5IhAAND2dTvJulm3Y0iiMMdeV3SQ9V1vCibqr96iZ4+0gu93bj2rh3zq6eMV/fV4hfydbIPG3VLAkUbrjCmxtdNl0ZSnrzhUPyqHWoFytReYF2biAlvNIelObkR66+V4Ie/zzXdmWlZdNyiVWL7liSg5Hac/9sdy8/S+PMK/ox2kaAUEMdnxSQcOdKt0HI9BMT1+uhBN9joCcAI3V5tTqj12m/4wiShwTkO5J7apb+bccyA27c+sqdsRCB1Q3QX5pd2rd3MrJKPJ5MFjMJgkSjZKyxHlBp7BnossH82jUT5Z9EQsVa+b3FJ6W4BQFvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7webFF+iTjcwNkW+1tNp6zLJjsEntAuYun/N2okITY=;
 b=A5YXHOL6GS8Zx3kxAMlDWGelumlim3VTxsb05+S18k0BIG/gXhd0HGh0MlLigjxMYgDwedraktaXuPArC1R6xP+CIrLVgAJvVOSm7qPJPtU1VclHPu/TmY+ECkAGFgQ0x2qgbGl0BaDuBPWBtUaINSmewOph9CnjSgIOiRdOuRU=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3722.namprd13.prod.outlook.com (2603:10b6:5:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12; Tue, 8 Jun
 2021 21:19:26 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 21:19:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAAA5OA
Date:   Tue, 8 Jun 2021 21:19:26 +0000
Message-ID: <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
In-Reply-To: <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78ad672c-8d20-49da-b94e-08d92ac3186f
x-ms-traffictypediagnostic: DM6PR13MB3722:
x-microsoft-antispam-prvs: <DM6PR13MB3722CF07445B9A023FE17971B8379@DM6PR13MB3722.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54cWR4/NfYPr6NX9u5eYmapqQZZxDml0J4Tp3foEQt23zBXhsbGzYKfU8fMgXVS4dsdF8y2Oqh9UF5RdItkzxOCcTetuNz89JEY2EN5iTiN0QFE0iNl+SjzKRH7Oxbfv68Lz5svy6Jt4wq44QlOcAby9TWUdlKiVcNhezfbA+aMQuXILOiQOIBAJmnED7/IW8haeeO50Fg8zde/an6WSyz69a3JVamy3Ap8RBVJkJf3UTPe2AbDR1d3YOMpdJwgOYQly4dADxCyAa/si5Md9l9+rcFBsh1sSYhP4H3q3LGkrnjRI8APrsrZBbZTn9nRzI5LqwovdOP4j+DEmnoKp4kRHpcg92E7aBVRIF3Z8lLqkJvXPw2aIxlkr3OEK1fv8brcnMGyDOjZqMtptYJZGzlqrbbYFJA4o0K6uDiEfPDi7BGKt8lKhl+Fxh6/48kf1rgjxpLVwJK6WOXjLIExCrWWWqUsLgAEYPwZJaR3f4V2oeBs1mWZfqnHMZwnwLrSr6jLp5Q3o1UK7mKnwWm7rURkdUInZDhv/QErQxUVMFAepuwySxoeNZxLXx/lyy/A3WrLpy5E62pVKmDEMwSRLLkfg3YwWbWgaj9nxlClFVHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39830400003)(376002)(366004)(136003)(53546011)(66946007)(6506007)(5660300002)(86362001)(66476007)(8676002)(64756008)(66446008)(66556008)(91956017)(8936002)(76116006)(36756003)(4326008)(6486002)(2616005)(6512007)(186003)(122000001)(478600001)(38100700002)(83380400001)(54906003)(26005)(110136005)(316002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2llRVYvTThmeTR3MnBWcVJuUThYdFVOaCt2dEtJM0x2MmxWa3dmVlhQVWta?=
 =?utf-8?B?S21sSm5DSnIzaWlpbytPdUNkUi9idHpDRFRqL2YrZ1JySlpKeG1mdTAxNlUw?=
 =?utf-8?B?eVRYMjdzdmJPdmE0SzJ0RVZLSG9vam9SY3o1dzlKTTZMVCtOaTJjQ0hSSkVt?=
 =?utf-8?B?NGFEZFViemZjeStmUVhYQ3ZLMTZJOXo2RGk0MGVtdGRoU3ZibnFWNVRlT2Yv?=
 =?utf-8?B?Z3BQbUhtQlp3L1JpbWNSK0M3ZGNsWTVmQjE2UlFYMVRvcEFIQWMwUVpPcVpy?=
 =?utf-8?B?K25mQjFQVjkzT2dmSzAwY0xrTWZ0MEZ6Z0lKUXJaRFhGS0gvZ21VbG1KUStQ?=
 =?utf-8?B?a1FWblhBZHdwZWFsLytoRXQ1TjJPclBBTVlTdG8vZ01zd3o1dTZwTTBrU2FG?=
 =?utf-8?B?YlcvSDV3RmU2VWoyb3hZcFJ2VUVhY0lITWdQOXJyVmJ0UCthYktFaUYrbFA3?=
 =?utf-8?B?TnVCSEJSQllpeHRZWTJ0QVFoaGxtK2Q4QlphSVU0WHNHbHMwTGFvVG11bU9P?=
 =?utf-8?B?eXdZTXBlNFljVXpaNlBzSXFibGlMRytGbGZoTDQ4WHBSTmZXQUNxOWdwZldt?=
 =?utf-8?B?REZtaW91aFhFNzdEN1JUV2VYSFZuVUYwODlFR1AwbUVNMEhmSWR6TmFGTjdy?=
 =?utf-8?B?L2ZJMU9pMVpRL3F3L1BBZGlBa05Ja3NTelROakd3NFF6NE1sNmZ2VklwY29r?=
 =?utf-8?B?dERtRTR5WUtnMkYzd3FuR0FMeTF2QVBwdDZkS1g4ekdyYWlUU2MzZDcrdUJo?=
 =?utf-8?B?aTRHNGVEQTlJM3hpc3hMMXNBTHlIa3Q2a0pRak5rR0NON1lqNmFXY1R2R0RP?=
 =?utf-8?B?b1lKRFpoc0xsdGFDRzgxaUtXTExMcDlzNHI3dmlueHhVWHdFRTA0ZkNIRHRw?=
 =?utf-8?B?Yk5FTlJpK2RVQkhyckpFeFBFOWZ6bnY4T1JaTWpvUkVKMEpEcDNDcWxCblNj?=
 =?utf-8?B?Q1h5VkVCcE1zR013MkE3elVyRzEwdVdqMEdtVGppSFh1WnQ5NVNWMkJvekh4?=
 =?utf-8?B?VVRsNHJQQXZMeUc2ZnBHSkR6ci9LUzFBQ01kM2lVTVA1UTIyellaN2F3eFUx?=
 =?utf-8?B?VEpPcVdackZlbEd2UjdDTGFxSmNWblUyeXpDUGFtbE5GMXBlWi94N0pWVWp2?=
 =?utf-8?B?cjJWemhiZFFzWmcyUHdwUTJvcUpQbXFjbC9uSEp3OWlSSWZOVXltVGRveTNt?=
 =?utf-8?B?Y3grVGF3bE9ILzIvYUhkMzNFTkxMT1FPVGJzVVRITzF6a1pRSEdrUWptM1hY?=
 =?utf-8?B?MWg5bGU2RXdCSmt2NjRKRnNMOElJYkd1UnFkTy9tRHdNdG5sZEIxUjJwNVc2?=
 =?utf-8?B?bWs2UU94enlFZUNtczUrbFFOejVJUEtPYzIybitLUTBpWlFITUhNQnZCSEYy?=
 =?utf-8?B?T3BPWTA5MXFwd1JvWW1IRXM2MmhwUmhsRDF0eDNnQVR0ZkhmUGxMRStseFFR?=
 =?utf-8?B?cVRXanIwVlo4U3lQUHV1M2hUZUVXV01nVGZiSEhCMDRIcG1iaHd5VTJjeStn?=
 =?utf-8?B?b1U2M2JnajRpNzhOUFNTTTZDaUlhQXJ4WjNzQld0bGUvenVmRHRQSlpELzF1?=
 =?utf-8?B?MzE1NThjTU5sUTgzZ0RZK1BZQVdoNmJ0T0NLTnJ0S1RiTjlBRjVlZUdoT1Fh?=
 =?utf-8?B?Y3pwem4rN0xFT3VRdlovREVwcjkvK3JSR0V3TjB4U29hZUxhWEpLMTB1bUky?=
 =?utf-8?B?TzhpUEcvUTdIQVJIeFArNktTd1pQYUNObElnay85WHAwZnZkQWMzeHRXYlo5?=
 =?utf-8?Q?f1aae8rc57qEwEvNBFh/udMqrF7vz65J7/pxeUH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1EDE8BE220AF4BABD08A9F15373EA7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ad672c-8d20-49da-b94e-08d92ac3186f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 21:19:26.5475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf4nINZnwTZiw4xqe0sPI/ZQKY1+maEVQ99OOEJ5EBiJQVlfmTfmk1wNJh6EFUp/aM8AdOigOz2gt5eAT2X5Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3722
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDIxOjA2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gOCwgMjAyMSwgYXQgNDo1NiBQTSwgT2xnYSBLb3JuaWV2c2th
aWEgPCANCj4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IE9uIFR1ZSwgSnVuIDgsIDIwMjEgYXQgNDo0MSBQTSBDaHVjayBMZXZlciBJSUkgPCANCj4gPiBj
aHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4g
PiA+ID4gT24gSnVuIDgsIDIwMjEsIGF0IDI6NDUgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwgDQo+
ID4gPiA+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+
ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+ID4g
DQo+ID4gPiA+IEFmdGVyIHRydW5raW5nIGlzIGRpc2NvdmVyZWQgaW4NCj4gPiA+ID4gbmZzNF9k
aXNjb3Zlcl9zZXJ2ZXJfdHJ1bmtpbmcoKSwNCj4gPiA+ID4gYWRkIHRoZSB0cmFuc3BvcnQgdG8g
dGhlIG9sZCBjbGllbnQgc3RydWN0dXJlIGJlZm9yZSBkZXN0cm95aW5nDQo+ID4gPiA+IHRoZSBu
ZXcgY2xpZW50IHN0cnVjdHVyZSAoYWxvbmcgd2l0aCBpdHMgdHJhbnNwb3J0KS4NCj4gPiA+ID4g
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gZnMvbmZzL25mczRjbGllbnQuYyB8IDQwDQo+ID4g
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gMSBm
aWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvbmZzNGNsaWVudC5jIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiA+ID4gPiBp
bmRleCA0MjcxOTM4NGUyNWYuLjk4NGM4NTE4NDRkOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMv
bmZzL25mczRjbGllbnQuYw0KPiA+ID4gPiArKysgYi9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ID4g
PiA+IEBAIC0zNjEsNiArMzYxLDQ0IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gbmZzNF9pbml0X2Ns
aWVudF9taW5vcl92ZXJzaW9uKHN0cnVjdCBuZnNfY2xpZW50ICpjbHApDQo+ID4gPiA+IMKgwqDC
oMKgIHJldHVybiBuZnM0X2luaXRfY2FsbGJhY2soY2xwKTsNCj4gPiA+ID4gfQ0KPiA+ID4gPiAN
Cj4gPiA+ID4gK3N0YXRpYyB2b2lkIG5mczRfYWRkX3RydW5rKHN0cnVjdCBuZnNfY2xpZW50ICpj
bHAsIHN0cnVjdA0KPiA+ID4gPiBuZnNfY2xpZW50ICpvbGQpDQo+ID4gPiA+ICt7DQo+ID4gPiA+
ICvCoMKgwqDCoCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBjbHBfYWRkciwgb2xkX2FkZHI7DQo+
ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc29ja2FkZHIgKmNscF9zYXAgPSAoc3RydWN0IHNvY2th
ZGRyICopJmNscF9hZGRyOw0KPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyICpvbGRf
c2FwID0gKHN0cnVjdCBzb2NrYWRkciAqKSZvbGRfYWRkcjsNCj4gPiA+ID4gK8KgwqDCoMKgIHNp
emVfdCBjbHBfc2FsZW4sIG9sZF9zYWxlbjsNCj4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCB4cHJ0
X2NyZWF0ZSB4cHJ0X2FyZ3MgPSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LmlkZW50ID0gb2xkLT5jbF9wcm90bywNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAubmV0ID0gb2xkLT5jbF9uZXQsDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LnNlcnZlcm5hbWUgPSBvbGQtPmNsX2hvc3RuYW1lLA0KPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4g
PiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBuZnM0X2FkZF94cHJ0X2RhdGEgeHBydGRhdGEgPSB7DQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNscCA9IG9sZCwNCj4gPiA+ID4gK8Kg
wqDCoMKgIH07DQo+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgcnBjX2FkZF94cHJ0X3Rlc3QgcnBj
ZGF0YSA9IHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuYWRkX3hwcnRfdGVz
dCA9IG9sZC0+Y2xfbXZvcHMtPnNlc3Npb25fdHJ1bmssDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLmRhdGEgPSAmeHBydGRhdGEsDQo+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoCBpZiAoY2xwLT5jbF9wcm90byAhPSBvbGQtPmNsX3By
b3RvKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiA+ID4g
K8KgwqDCoMKgIGNscF9zYWxlbiA9IHJwY19wZWVyYWRkcihjbHAtPmNsX3JwY2NsaWVudCwgY2xw
X3NhcCwNCj4gPiA+ID4gc2l6ZW9mKGNscF9hZGRyKSk7DQo+ID4gPiA+ICvCoMKgwqDCoCBvbGRf
c2FsZW4gPSBycGNfcGVlcmFkZHIob2xkLT5jbF9ycGNjbGllbnQsIG9sZF9zYXAsDQo+ID4gPiA+
IHNpemVvZihvbGRfYWRkcikpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoCBpZiAoY2xw
X2FkZHIuc3NfZmFtaWx5ICE9IG9sZF9hZGRyLnNzX2ZhbWlseSkNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgIHhw
cnRfYXJncy5kc3RhZGRyID0gY2xwX3NhcDsNCj4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5h
ZGRybGVuID0gY2xwX3NhbGVuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoCB4cHJ0ZGF0
YS5jcmVkID0gbmZzNF9nZXRfY2xpZF9jcmVkKG9sZCk7DQo+ID4gPiA+ICvCoMKgwqDCoCBycGNf
Y2xudF9hZGRfeHBydChvbGQtPmNsX3JwY2NsaWVudCwgJnhwcnRfYXJncywNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19jbG50X3NldHVw
X3Rlc3RfYW5kX2FkZF94cHJ0LA0KPiA+ID4gPiAmcnBjZGF0YSk7DQo+ID4gPiANCj4gPiA+IElz
IHRoZXJlIGFuIHVwcGVyIGJvdW5kIG9uIHRoZSBudW1iZXIgb2YgdHJhbnNwb3J0cyB0aGF0DQo+
ID4gPiBhcmUgYWRkZWQgdG8gdGhlIE5GUyBjbGllbnQncyBzd2l0Y2g/DQo+ID4gDQo+ID4gSSBk
b24ndCBiZWxpZXZlIGFueSBsaW1pdHMgZXhpc3QgcmlnaHQgbm93LiBXaHkgc2hvdWxkIHRoZXJl
IGJlIGENCj4gPiBsaW1pdD8gQXJlIHlvdSBzYXlpbmcgdGhhdCB0aGUgY2xpZW50IHNob3VsZCBs
aW1pdCB0cnVua2luZz8gV2hpbGUNCj4gPiB0aGlzIGlzIG5vdCB3aGF0J3MgaGFwcGVuaW5nIGhl
cmUsIGJ1dCBzYXkgRlNfTE9DQVRJT04gcmV0dXJuZWQgMTAwDQo+ID4gaXBzIGZvciB0aGUgc2Vy
dmVyLiBBcmUgeW91IHNheWluZyB0aGUgY2xpZW50IHNob3VsZCBiZSBsaW1pdGluZw0KPiA+IGhv
dw0KPiA+IG1hbnkgdHJ1bmthYmxlIGNvbm5lY3Rpb25zIGl0IHdvdWxkIGJlIGVzdGFibGlzaGlu
ZyBhbmQgcGlja2luZw0KPiA+IGp1c3QgYQ0KPiA+IGZldyBhZGRyZXNzZXMgdG8gdHJ5PyBXaGF0
J3MgaGFwcGVuaW5nIHdpdGggdGhpcyBwYXRjaCBpcyB0aGF0IHNheQ0KPiA+IHRoZXJlIGFyZSAx
MDBtb3VudHMgdG8gMTAwIGlwcyAoZWFjaCByZXByZXNlbnRpbmcgdGhlIHNhbWUgc2VydmVyDQo+
ID4gb3INCj4gPiB0cnVua2FibGUgc2VydmVyKHMpKSwgd2l0aG91dCB0aGlzIHBhdGNoIGEgc2lu
Z2xlIGNvbm5lY3Rpb24gaXMNCj4gPiBrZXB0LA0KPiA+IHdpdGggdGhpcyBwYXRjaCB3ZSdsbCBo
YXZlIDEwMCBjb25uZWN0aW9ucy4NCj4gDQo+IFRoZSBwYXRjaCBkZXNjcmlwdGlvbiBuZWVkcyB0
byBtYWtlIHRoaXMgYmVoYXZpb3IgbW9yZSBjbGVhci4gSXQNCj4gbmVlZHMgdG8gZXhwbGFpbiAi
d2h5IiAtLSB0aGUgYm9keSBvZiB0aGUgcGF0Y2ggYWxyZWFkeSBleHBsYWlucw0KPiAid2hhdCIu
IENhbiB5b3UgaW5jbHVkZSB5b3VyIGxhc3Qgc2VudGVuY2UgaW4gdGhlIGRlc2NyaXB0aW9uIGFz
DQo+IGEgdXNlIGNhc2U/DQo+IA0KPiBBcyBmb3IgdGhlIGJlaGF2aW9yLi4uIFNlZW1zIHRvIG1l
IHRoYXQgdGhlcmUgYXJlIGdvaW5nIHRvIGJlIG9ubHkNCj4gaW5maW5pdGVzaW1hbCBnYWlucyBh
ZnRlciB0aGUgZmlyc3QgZmV3IGNvbm5lY3Rpb25zLCBhbmQgYWZ0ZXINCj4gdGhhdCwgaXQncyBn
b2luZyB0byBiZSBhIGxvdCBmb3IgYm90aCBzaWRlcyB0byBtYW5hZ2UgZm9yIG5vIHJlYWwNCj4g
Z2Fpbi4gSSB0aGluayB5b3UgZG8gd2FudCB0byBjYXAgdGhlIHRvdGFsIG51bWJlciBvZiBjb25u
ZWN0aW9ucw0KPiBhdCBhIHJlYXNvbmFibGUgbnVtYmVyLCBldmVuIGluIHRoZSBGU19MT0NBVElP
TlMgY2FzZS4NCj4gDQoNCkknZCB0ZW5kIHRvIGFncmVlLiBJZiB5b3Ugd2FudCB0byBzY2FsZSBJ
L08gdGhlbiBwTkZTIGlzIHRoZSB3YXkgdG8gZ28sDQpub3QgdmFzdCBudW1iZXJzIG9mIGNvbm5l
Y3Rpb25zIHRvIGEgc2luZ2xlIHNlcnZlci4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
