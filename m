Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290CA3A06A2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFHWPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:15:12 -0400
Received: from mail-mw2nam10on2104.outbound.protection.outlook.com ([40.107.94.104]:62561
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229753AbhFHWPL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 18:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JphOALtdJzWtetf+IOFkGpNGLdWvh/AgE1x/ervNQIUgQ1TFTEkzG14djR6oTzqBY3Lmm3zUGKdMiZiOHBCEP84a+eTer/FXubvn6FIgCCDiE+ld6D/HIrdI7IkmJ8nJEtvCS785V2aBygfkamfknbPpSRLO6t1dW+E41TyKeuT4MNOQKGR4RmgpJcge6RT+TGA1z/UdhnWQwZTwowb96/H9iGv1vNtkdCFLmhigWBgOMCRT7At04Q7ARC1xSr3zS9oNhsg6zlsRS/mEyiA78hEv7rIbrE6c4NzUZLFdAUGviuA6KngvJfMYEqpCd7A/urZlF2zXkcEFSvJ/hXHKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBsbVEE6/t5quBzT827Gx/eg44WrGb7M0xjn9g9OxDU=;
 b=WkF7tCY7JsAswwCPbdLfdCwDWINz68oC0sCj/Ib+8EudVgBEFUjsJByINpm++WdYnF2X1oX73bLTBKo+9qZ0XABxQJUpSvw62XZrafTJ66EHX3L+U8ovvhVvdYMqATWM8mY0JGmLIYoYcHrb3DtSrcpok2+Pux0MliiqSoCeU1jcr93glxxNqO5mR/aI96/jJDmcXMQ99TIlp/df+3K0gts+RcgGeVlJm275Zc7ZWG1PCNCe3W9upC4P/D87K9JpkSmyTJ7pvpadv7u5pXBMIYhbgAmIQbLRtbefDuegrzAOptwHgUEgzM7n6tu5jBbcocMzTS2noCd4uYxGpU2SdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBsbVEE6/t5quBzT827Gx/eg44WrGb7M0xjn9g9OxDU=;
 b=QyE1HExIvkrexdlg1IRsgXwkKHHe2mWxMXiH0iNhThwV3+GJBeFCExKT2YoUwGUDzrw14Lm0zxLM8pfg8VMWycJnQKewJrN1CH+tsITKNPfxigHLbIGpLged+NmSyMYtf5CieoUWk0wO82eJP5wLhPPIxPV1qnKSwGmnLz7yGWQ=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3050.namprd13.prod.outlook.com (2603:10b6:5:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.13; Tue, 8 Jun 2021 22:13:15 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 22:13:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAACWKAgAAJNoA=
Date:   Tue, 8 Jun 2021 22:13:15 +0000
Message-ID: <4c73319e5b826a8f3c9a29b085c42e181150d08c.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
In-Reply-To: <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f34a0f-8c99-4499-6f14-08d92aca9d0f
x-ms-traffictypediagnostic: DM6PR13MB3050:
x-microsoft-antispam-prvs: <DM6PR13MB3050B70414D8BB089A5FB8F8B8379@DM6PR13MB3050.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YA/3n+YT2oy4z7r+chxVIXCfELNqFayaMyJBDS1W2kixp8lygYR1EiZNvIFjT9ZZAPYkoqo8jvRfrEadVBLapt2o25tEDL+ILh+IrT/iWjnbV9NwJtruxztTzcZfa05/RIFZ3DHK7CF8qVWXWRG4WhV7Oy9okEA829ThKJ2QXjoXTP+rbr3qt3ccd1zkI7XloLlYrWH6y1sdM4YJKcKR47e3l67ZNWTQzGBsRYSc6FUsIWYFYCKJtFWib+GmOsPXZq3K/2Nf3zIAR8NIq850LtDulr5Mc1K1ECHgHihWJ6LQaTywXloh2jCvXGXHUW/wtCUZMe669x52e1sGWF+ICRF/a5XibOcuMFZmvOYC2c4zqMY+by6IQ7WRUKKsSHQ7LzcIn/Qw/47WYSnEJQgQgQJHShEd9BS+HM3oQQL7fajvP96mxWLV78CaO8zklM/BV4L6IcU319VYsgkPJlp4KI1yODAIQBq/Re31lTesWVXM8VHiHyf8l+nrXIXJeTy7Sivot1HSEooob/SRMv2OlCvySCflQTCWfHRGBXQ0HMY8+ATRScGRzQpf8fN646NDWrETIWxtYz1VLuibZFz22RJAALzvg2WoPtFx/rrHuGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(110136005)(71200400001)(26005)(53546011)(66556008)(2616005)(66946007)(6512007)(54906003)(498600001)(8936002)(2906002)(4326008)(8676002)(6486002)(86362001)(66476007)(6506007)(76116006)(122000001)(38100700002)(5660300002)(36756003)(64756008)(66446008)(91956017)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJWcHRsWTVZamFaQzA0MzNseldxYVRrU2padWFWakVmYkZMaFdHckRMc29Q?=
 =?utf-8?B?c2pvaSt6SHI1WW9leXFvMTZlRGxwUUZNUkJsRmhiakQ5cnBtVzFjVFMwRlAr?=
 =?utf-8?B?REJySGRWdVhKSEdsNEc1OGpleWl5WUNtTUgzbCswaVZoa3JPeWFJQmQyQ2Vw?=
 =?utf-8?B?TzZUV2RhUlZtUGNuTERQMnEySEh1cnJPbVFML3l5d0ptV1g0UWRDb1dkbWQx?=
 =?utf-8?B?U3BodVF3SnZyLzZBL3BxRlNnWktiaW5qRk1HM2llWW5Bam1MUGE3bkNKaDkx?=
 =?utf-8?B?ZUdrU0RuejBzZldhSnQ1Z2Z3ZVRiNEt2NGNNMlNUMEJ3UGVhMjI0TCtFb3ZT?=
 =?utf-8?B?RlREamlBa0pqMFhnOVVZZUVqM1VxODlnVU1OcUZKQ3AwTSt4K0lRYlhIbThO?=
 =?utf-8?B?aUF0SkZqeStSNW1OUEVzWmwrWTJ5M2RzZys5OHRRalVTNTBmL2x1ejdIeTFP?=
 =?utf-8?B?SUMvOEMwbDdISkZPTWI2R3BlbEF4R3FnOFF6aUhlK2c4dmpIVjFGb1VJdjZm?=
 =?utf-8?B?Zzh2aTFiWWVIdzY2V28rK01uTGRNRTBEUXQzOXZST3BRRllZejVvQlRudmZ3?=
 =?utf-8?B?dWkxZG1oSnR2OC9mRERsc05oWVRGK1BWL0ZnNm0yQ1FGalkxOFpydWN0Vmkv?=
 =?utf-8?B?TDJLTmJzQUw5ZVJ5bjlQcmpMNk9OY2MxdHBBR05adWhtaE9rbW1sa3ozbDFM?=
 =?utf-8?B?MFVzemtLNm5GOWdJUkx5MmE1QVU3dmUzOWg2YVVEWmRCbk9UbE8zVjJrMjRz?=
 =?utf-8?B?N2krSU9hM3JuZ1o2WEpZZ1FZZWxhMktRNWJyNG5kSklEY25UUEZnR2JJMmJr?=
 =?utf-8?B?ckJTZmlqblRYUVlFdDhiSXpoRmpFTDRmcDFVTkZYU0J5WXB6d2dqMWFxVlJY?=
 =?utf-8?B?VlgvSVVpSStSZklwWDk3dFJRb09OTTQ5YzZzVGNIWmU4WnJzOVN0NGVnWGFz?=
 =?utf-8?B?THJUV1lKZkZxSkE5OE1icVlubzNiMXJORkdwcWVBOVk1WEdOMkdvNnl6aXdE?=
 =?utf-8?B?REJycnVsVlRWWlVZcElZSU5iempUNTJGWGpNZjlJanRmV3RsNWh6dk54Rk1r?=
 =?utf-8?B?T3ZsOTVzTFRCVGlrVFhicWxtVGZhaHlRbXJ1YS9MNVUxbmZrL1MzK2UwaHBR?=
 =?utf-8?B?M1pZVXA0WGluYndUQ3dYOE51aWJ2cHh1cjR1YUM0U1dHYytUQzhyV1hzUmxj?=
 =?utf-8?B?SWVlUTUvOTJGcFJyYS9vSmFnVUh0dy9xQlBnbm1aOFBPbnp4bkR5MUNJb1RX?=
 =?utf-8?B?eUk1R2pLcjBwdlJrcGVteGRkN1FFZTQrUno2aENIK3hJWk9IaXkvQTV5N3pJ?=
 =?utf-8?B?WnMvVTNSd2RuZWdvMjNtMFMxNS9qWHpuWTcvMTZDN1VPa3RpVXZsOE44Z0Ft?=
 =?utf-8?B?OHhLRmVkY1A2V2Z2T2lrK3kyWVJidG9mQ3Z1eUpoTXk0MFIycmk2TjhLZW1R?=
 =?utf-8?B?UllUTTR1TjlLZ1FVMFc0Q1kraVVHUFNURkg5WHBvVWk3bEdMQ01tRytCQzhQ?=
 =?utf-8?B?aitzVmZBdUdSbWlTakFlWDExcWo3d2VvWGtCdmd1WFRMRHhvL2J1ZEd2elVX?=
 =?utf-8?B?TEhsSkdKV0U5WXY2UmVVRkt1OS91NlNYL0FjWE5YZXQxR0hwejdYenhzbmwy?=
 =?utf-8?B?bEVab2poQkNYSE5YRXFGb01tcXpOTm5ZcWpkSXJsVzRCY1BWZ0dqZHU1UE1m?=
 =?utf-8?B?bjBtWmhJZWVtelA0ZlpzcHBxYjdrMHZtU2tDVUJGYXdJaGRNREtQSnRBU2dT?=
 =?utf-8?Q?USGQFkm8huOiO46DTXOEagBXRvCiHFnln+F6d5B?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59AC70C99405DC4684B35A8F7E74188A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f34a0f-8c99-4499-6f14-08d92aca9d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 22:13:15.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMvJRaoqh75Eb7Ifo7mfQfonKE3rx8bBJr4OUn72h8ewC34Od0f4BjFW8TnqLsZvRE5qo3yu7RxEeMvgB/ZrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3050
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDE3OjQwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA1OjA2IFBNIENodWNrIExldmVyIElJSSA8IA0K
PiBjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPiA+
IE9uIEp1biA4LCAyMDIxLCBhdCA0OjU2IFBNLCBPbGdhIEtvcm5pZXZza2FpYSA8IA0KPiA+ID4g
b2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gVHVl
LCBKdW4gOCwgMjAyMSBhdCA0OjQxIFBNIENodWNrIExldmVyIElJSSA8IA0KPiA+ID4gY2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+ID4gT24gSnVuIDgsIDIwMjEsIGF0IDI6NDUgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwg
DQo+ID4gPiA+ID4gb2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZnRlciB0cnVua2luZyBpcyBkaXNjb3ZlcmVkIGluDQo+
ID4gPiA+ID4gbmZzNF9kaXNjb3Zlcl9zZXJ2ZXJfdHJ1bmtpbmcoKSwNCj4gPiA+ID4gPiBhZGQg
dGhlIHRyYW5zcG9ydCB0byB0aGUgb2xkIGNsaWVudCBzdHJ1Y3R1cmUgYmVmb3JlDQo+ID4gPiA+
ID4gZGVzdHJveWluZw0KPiA+ID4gPiA+IHRoZSBuZXcgY2xpZW50IHN0cnVjdHVyZSAoYWxvbmcg
d2l0aCBpdHMgdHJhbnNwb3J0KS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiBmcy9uZnMvbmZzNGNsaWVudC5jIHwgNDANCj4gPiA+ID4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDQw
IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L25mczRjbGllbnQuYyBiL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiBpbmRleCA0Mjcx
OTM4NGUyNWYuLjk4NGM4NTE4NDRkOCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvbmZz
NGNsaWVudC5jDQo+ID4gPiA+ID4gKysrIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiA+ID4gPiA+
IEBAIC0zNjEsNiArMzYxLDQ0IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiBuZnM0X2luaXRfY2xp
ZW50X21pbm9yX3ZlcnNpb24oc3RydWN0IG5mc19jbGllbnQgKmNscCkNCj4gPiA+ID4gPiDCoMKg
wqDCoCByZXR1cm4gbmZzNF9pbml0X2NhbGxiYWNrKGNscCk7DQo+ID4gPiA+ID4gfQ0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBuZnM0X2FkZF90cnVuayhzdHJ1Y3QgbmZzX2Ns
aWVudCAqY2xwLCBzdHJ1Y3QNCj4gPiA+ID4gPiBuZnNfY2xpZW50ICpvbGQpDQo+ID4gPiA+ID4g
K3sNCj4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgY2xwX2FkZHIs
IG9sZF9hZGRyOw0KPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc29ja2FkZHIgKmNscF9zYXAg
PSAoc3RydWN0IHNvY2thZGRyDQo+ID4gPiA+ID4gKikmY2xwX2FkZHI7DQo+ID4gPiA+ID4gK8Kg
wqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqb2xkX3NhcCA9IChzdHJ1Y3Qgc29ja2FkZHINCj4gPiA+
ID4gPiAqKSZvbGRfYWRkcjsNCj4gPiA+ID4gPiArwqDCoMKgwqAgc2l6ZV90IGNscF9zYWxlbiwg
b2xkX3NhbGVuOw0KPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgeHBydF9jcmVhdGUgeHBydF9h
cmdzID0gew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmlkZW50ID0gb2xk
LT5jbF9wcm90bywNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uZXQgPSBv
bGQtPmNsX25ldCwNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zZXJ2ZXJu
YW1lID0gb2xkLT5jbF9ob3N0bmFtZSwNCj4gPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+ID4g
PiArwqDCoMKgwqAgc3RydWN0IG5mczRfYWRkX3hwcnRfZGF0YSB4cHJ0ZGF0YSA9IHsNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5jbHAgPSBvbGQsDQo+ID4gPiA+ID4gK8Kg
wqDCoMKgIH07DQo+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBycGNfYWRkX3hwcnRfdGVzdCBy
cGNkYXRhID0gew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFkZF94cHJ0
X3Rlc3QgPSBvbGQtPmNsX212b3BzLT5zZXNzaW9uX3RydW5rLA0KPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLmRhdGEgPSAmeHBydGRhdGEsDQo+ID4gPiA+ID4gK8KgwqDCoMKg
IH07DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoMKgwqDCoCBpZiAoY2xwLT5jbF9wcm90byAh
PSBvbGQtPmNsX3Byb3RvKQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOw0KPiA+ID4gPiA+ICvCoMKgwqDCoCBjbHBfc2FsZW4gPSBycGNfcGVlcmFkZHIoY2xwLT5j
bF9ycGNjbGllbnQsIGNscF9zYXAsDQo+ID4gPiA+ID4gc2l6ZW9mKGNscF9hZGRyKSk7DQo+ID4g
PiA+ID4gK8KgwqDCoMKgIG9sZF9zYWxlbiA9IHJwY19wZWVyYWRkcihvbGQtPmNsX3JwY2NsaWVu
dCwgb2xkX3NhcCwNCj4gPiA+ID4gPiBzaXplb2Yob2xkX2FkZHIpKTsNCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gK8KgwqDCoMKgIGlmIChjbHBfYWRkci5zc19mYW1pbHkgIT0gb2xkX2FkZHIuc3Nf
ZmFtaWx5KQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqAgeHBydF9hcmdzLmRzdGFkZHIgPSBjbHBfc2Fw
Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoCB4cHJ0X2FyZ3MuYWRkcmxlbiA9IGNscF9zYWxlbjsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRkYXRhLmNyZWQgPSBuZnM0X2dldF9j
bGlkX2NyZWQob2xkKTsNCj4gPiA+ID4gPiArwqDCoMKgwqAgcnBjX2NsbnRfYWRkX3hwcnQob2xk
LT5jbF9ycGNjbGllbnQsICZ4cHJ0X2FyZ3MsDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19jbG50X3NldHVwX3Rlc3RfYW5kX2FkZF94
cHJ0LA0KPiA+ID4gPiA+ICZycGNkYXRhKTsNCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGFu
IHVwcGVyIGJvdW5kIG9uIHRoZSBudW1iZXIgb2YgdHJhbnNwb3J0cyB0aGF0DQo+ID4gPiA+IGFy
ZSBhZGRlZCB0byB0aGUgTkZTIGNsaWVudCdzIHN3aXRjaD8NCj4gPiA+IA0KPiA+ID4gSSBkb24n
dCBiZWxpZXZlIGFueSBsaW1pdHMgZXhpc3QgcmlnaHQgbm93LiBXaHkgc2hvdWxkIHRoZXJlIGJl
IGENCj4gPiA+IGxpbWl0PyBBcmUgeW91IHNheWluZyB0aGF0IHRoZSBjbGllbnQgc2hvdWxkIGxp
bWl0IHRydW5raW5nPw0KPiA+ID4gV2hpbGUNCj4gPiA+IHRoaXMgaXMgbm90IHdoYXQncyBoYXBw
ZW5pbmcgaGVyZSwgYnV0IHNheSBGU19MT0NBVElPTiByZXR1cm5lZA0KPiA+ID4gMTAwDQo+ID4g
PiBpcHMgZm9yIHRoZSBzZXJ2ZXIuIEFyZSB5b3Ugc2F5aW5nIHRoZSBjbGllbnQgc2hvdWxkIGJl
IGxpbWl0aW5nDQo+ID4gPiBob3cNCj4gPiA+IG1hbnkgdHJ1bmthYmxlIGNvbm5lY3Rpb25zIGl0
IHdvdWxkIGJlIGVzdGFibGlzaGluZyBhbmQgcGlja2luZw0KPiA+ID4ganVzdCBhDQo+ID4gPiBm
ZXcgYWRkcmVzc2VzIHRvIHRyeT8gV2hhdCdzIGhhcHBlbmluZyB3aXRoIHRoaXMgcGF0Y2ggaXMg
dGhhdA0KPiA+ID4gc2F5DQo+ID4gPiB0aGVyZSBhcmUgMTAwbW91bnRzIHRvIDEwMCBpcHMgKGVh
Y2ggcmVwcmVzZW50aW5nIHRoZSBzYW1lIHNlcnZlcg0KPiA+ID4gb3INCj4gPiA+IHRydW5rYWJs
ZSBzZXJ2ZXIocykpLCB3aXRob3V0IHRoaXMgcGF0Y2ggYSBzaW5nbGUgY29ubmVjdGlvbiBpcw0K
PiA+ID4ga2VwdCwNCj4gPiA+IHdpdGggdGhpcyBwYXRjaCB3ZSdsbCBoYXZlIDEwMCBjb25uZWN0
aW9ucy4NCj4gPiANCj4gPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gbmVlZHMgdG8gbWFrZSB0aGlz
IGJlaGF2aW9yIG1vcmUgY2xlYXIuIEl0DQo+ID4gbmVlZHMgdG8gZXhwbGFpbiAid2h5IiAtLSB0
aGUgYm9keSBvZiB0aGUgcGF0Y2ggYWxyZWFkeSBleHBsYWlucw0KPiA+ICJ3aGF0Ii4gQ2FuIHlv
dSBpbmNsdWRlIHlvdXIgbGFzdCBzZW50ZW5jZSBpbiB0aGUgZGVzY3JpcHRpb24gYXMNCj4gPiBh
IHVzZSBjYXNlPw0KPiANCj4gSSBzdXJlIGNhbi4NCj4gDQo+ID4gQXMgZm9yIHRoZSBiZWhhdmlv
ci4uLiBTZWVtcyB0byBtZSB0aGF0IHRoZXJlIGFyZSBnb2luZyB0byBiZSBvbmx5DQo+ID4gaW5m
aW5pdGVzaW1hbCBnYWlucyBhZnRlciB0aGUgZmlyc3QgZmV3IGNvbm5lY3Rpb25zLCBhbmQgYWZ0
ZXINCj4gPiB0aGF0LCBpdCdzIGdvaW5nIHRvIGJlIGEgbG90IGZvciBib3RoIHNpZGVzIHRvIG1h
bmFnZSBmb3Igbm8gcmVhbA0KPiA+IGdhaW4uIEkgdGhpbmsgeW91IGRvIHdhbnQgdG8gY2FwIHRo
ZSB0b3RhbCBudW1iZXIgb2YgY29ubmVjdGlvbnMNCj4gPiBhdCBhIHJlYXNvbmFibGUgbnVtYmVy
LCBldmVuIGluIHRoZSBGU19MT0NBVElPTlMgY2FzZS4NCj4gDQo+IERvIHlvdSB3YW50IHRvIGNh
cCBpdCBhdCAxNiBsaWtlIHdlIGRvIGZvciBuY29ubmVjdD8gSSdtIG9rIHdpdGggdGhhdA0KPiBm
b3Igbm93Lg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBhIHNldHVwIHdoZXJlIHRoZXJl
IFggTklDcyBvbiBlYWNoIHNpZGUNCj4gKGNsaWVudC9zZXJ2ZXIpIGFuZCBYIG1vdW50cyBhcmUg
ZG9uZSwgdGhlcmUgd29uJ3QgYmUgdGhyb3VnaHB1dCBvZg0KPiBjbG9zZSB0byBYICogdGhyb3Vn
aHB1dCBvZiBhIHNpbmdsZSBOSUMuDQoNClRoYXQgc3RpbGwgZG9lcyBub3QgbWFrZSB0aGUgcGF0
Y2ggYWNjZXB0YWJsZS4gVGhlcmUgYXJlIGFscmVhZHkgc2VydmVyDQp2ZW5kb3JzIHNlZWluZyBw
cm9ibGVtcyB3aXRoIHN1cHBvcnRpbmcgbmNvbm5lY3QgZm9yIHZhcmlvdXMgcmVhc29ucy7CoA0K
DQpUaGVyZSBuZWVkcyB0byBiZSBhIHdheSB0byBlbnN1cmUgdGhhdCB3ZSBjYW4ga2VlcCB0aGUg
Y3VycmVudCBjbGllbnQNCmJlaGF2aW91ciB3aXRob3V0IHJlcXVpcmluZyBjaGFuZ2VzIHRvIHNl
cnZlciBETlMgZW50cmllcywgZXRjLg0KDQo+IA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDC
oMKgwqAgaWYgKHhwcnRkYXRhLmNyZWQpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwdXRfY3JlZCh4cHJ0ZGF0YS5jcmVkKTsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiAvKioNCj4gPiA+ID4gPiAqIG5mczRfaW5pdF9jbGllbnQgLSBJbml0aWFsaXNl
IGFuIE5GUzQgY2xpZW50IHJlY29yZA0KPiA+ID4gPiA+ICoNCj4gPiA+ID4gPiBAQCAtNDM0LDYg
KzQ3Miw4IEBAIHN0cnVjdCBuZnNfY2xpZW50DQo+ID4gPiA+ID4gKm5mczRfaW5pdF9jbGllbnQo
c3RydWN0IG5mc19jbGllbnQgKmNscCwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIHdvbid0IHRyeSB0byB1c2UgaXQuDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8NCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX21hcmtf
Y2xpZW50X3JlYWR5KGNscCwgLUVQRVJNKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChvbGQtPmNsX212b3BzLT5zZXNzaW9uX3RydW5rKQ0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5mczRfYWRkX3RydW5rKGNscCwg
b2xkKTsNCj4gPiA+ID4gPiDCoMKgwqDCoCB9DQo+ID4gPiA+ID4gwqDCoMKgwqAgY2xlYXJfYml0
KE5GU19DU19UU01fUE9TU0lCTEUsICZjbHAtPmNsX2ZsYWdzKTsNCj4gPiA+ID4gPiDCoMKgwqDC
oCBuZnNfcHV0X2NsaWVudChjbHApOw0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4yNy4wDQo+
ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiBDaHVjayBMZXZlcg0KPiA+
IA0KPiA+IC0tDQo+ID4gQ2h1Y2sgTGV2ZXINCj4gPiANCj4gPiANCj4gPiANCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
