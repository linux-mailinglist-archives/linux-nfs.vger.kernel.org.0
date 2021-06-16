Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1B3A9D71
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhFPOW5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 10:22:57 -0400
Received: from mail-dm6nam11on2109.outbound.protection.outlook.com ([40.107.223.109]:20992
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232694AbhFPOW5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTnacWv4SHJSiRP77BxgjLE9dwhLM9xMSo2jhriqVj1MIkDJn/3IgOKLD3P2ECVSliedjC/PwhFovPDqIorRtnU3EroNUG7fP/YkyZO9V8BdxHQa8ee6OHmkiroeeH5LvQLyLJ5aT/8Q4V0QXJlMK1cFguQd7VlJ/64X3kgEdo2I4UyQ+tOV/MXKawq59i3dmEoO0rZJEOYqflgUrMG6C4Aetm0taNDXtfc31Ah6QxyO3Dt9fBBZyzN8qASO+I8jd4aXKIWybD/B4SvIM5OdAL2+apcqUYrYii/Jbua8BMkqI6ipdZaMX0Gho6RqQVu8HyOSeQd+0ckg8pp4qM06+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJPL8E0XrPRH8Z6036TdgTvW1P25xnPWQ6W3K9ElOok=;
 b=fo3tu5cwzZERuI/wP5Yun8nXledCy2yUm3saF7MbjQC9EjvZQrupkE9ghnS0kzHZfqZ1V0pEh/QcVpMeJ6tcUE5YMbv95VfTgQqAPl8e0FGUhPEZ+b5KnXY54URMDFeq4pQlltiYRaBgoZ9JpaF+5de38ksFe9QbXtGpPgsPi59mYV/lVWez4uLnVsmKl0PaR1P1/OkZI/atCoct1q62SMqKkgavRznsgsh2vKEpPQHD90vxzjKYYZwAbfPLtGT1Ytk28jOFmptscxGHdvnCxE/TDK8wUEgEFIQycIpXdW4wcwL5W4vyJB6s2/7moXwbqm2kD6VkjrPws4D5KnVDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJPL8E0XrPRH8Z6036TdgTvW1P25xnPWQ6W3K9ElOok=;
 b=LI1KCrzlG7qA9CHaRAQw3mk1LxlltOKTuTnNoa1ujLsHfAefmJ7D9bJ8Zt8J9VzUjbvrwi8lvtua5j5OO6Bs8Lrfa/Z9Kw661ITGitl/NKnELPH7+pS+MhqTf5VQo3ydz1HLfXAPMnzFVc0oXlRoGmWoGFGA6ELXZwFLhmTnASo=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB0985.namprd13.prod.outlook.com (2603:10b6:3:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.12; Wed, 16 Jun 2021 14:20:49 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.018; Wed, 16 Jun 2021
 14:20:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Topic: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Index: AQHXYq1gTBPriIHjLEyaSjnxbRPdFqsWptwAgAAFcoCAAAPyAA==
Date:   Wed, 16 Jun 2021 14:20:49 +0000
Message-ID: <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
         <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
         <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
In-Reply-To: <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f26fdc5-550d-47fb-2ea4-08d930d1f0d5
x-ms-traffictypediagnostic: DM5PR13MB0985:
x-microsoft-antispam-prvs: <DM5PR13MB09854F0F2C0973AD077B357EB80F9@DM5PR13MB0985.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOMQx/0ljpc7iySZRnK+4T3CVO2B7evpSEcH+6kGZXsfLjPnz8u3s8NI/HCscMAKLfJFDtU6RqHooOnlzHptMArb/m1Txsv9sEv+k68ggUtcbyVdNkBNEE6qBVl/q6yHuP4CQYbO2HCDx84QPR7p9M1V+EIMg1uUVpcYcSvSBTTaCoqMU/i/XhPbQQzEU/EDeOamA9IY2thMsVAix/g5j2HCOJCnjuonYzEXJvQYn4qBcg9x+Y/OBNgSZr8gI/ntjy304ieE532Vf9MT42xexKDKIc96vibBskI7n8wd4Fq3WIjuJCTQ5M+kwFYdXJutw+Mg+dTJH3ouUAI2G/0uSXkONALfaaLk+xL9rHAP3BV6352FSRI214egdYYy9ftMGbZHGOckEBHUA6FPxDnYcPH81+ntPYVb4dz+ghmwlPyeS4CcawB5aBLfEHWiAB7LV/zctNIzhc128ODlcBAjXh+ix/mogbQYQrP9oXPsRaJUuJd77oOdwtSPDBDSzPuS8AIQOo7/GdXn2fYaO/QD6EVrNE2kC6/WE3OOGH69TyfG9Unp8gISk4rR//hCSRAz75N0l9avXP8RA+qXqaM2V21Xw3IrgUzrS9pjA8SflXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(366004)(396003)(346002)(136003)(316002)(6512007)(86362001)(38100700002)(8936002)(36756003)(71200400001)(6506007)(54906003)(122000001)(4326008)(8676002)(6486002)(5660300002)(2906002)(478600001)(76116006)(83380400001)(91956017)(186003)(64756008)(66476007)(66556008)(66446008)(26005)(2616005)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhEcHg0dG1aL1VBWm1BTmNmcEFLWlRZMUhKNTFIN2tXcksxT1Z0ME13REJk?=
 =?utf-8?B?U20rOUxOWVZmNVh1ZDcvRlRTanhXTW1vNVBpTHJ1bHQzUDRMV2pjU3BRMDUz?=
 =?utf-8?B?aW54T1JHb1dFQWVZQ0x1eWVMU1FldWNEUS9Md1FnTnZmdDlzYUVlOUVBOTZH?=
 =?utf-8?B?eG9rWVZXdGZNbHBHSjIySEFMdlN0VDBnbDAzRVJMc0Ywa2E0OTBSTzlrYW9y?=
 =?utf-8?B?UEgzTFc2d3NoMGJQQTJyekM0c2dJZjhFSlNJbEU0OTZyd2VpSXVvcjRKeDVR?=
 =?utf-8?B?Y0pDUk5neWx2eWdpRU9sRGJJTWdPYVlZbi96Q0htSmtGWlBJMXpXMTNpVkZ1?=
 =?utf-8?B?ZDh3QmZDWHhnTDRxWi81Umw0QTBoZXZLMzkvNm5VTVpzeFpqOXB2YWRPS1Mx?=
 =?utf-8?B?VHYxdDQwRVF1c0tPYU1ISzhIS1M3elMwb1NOWVN4am1pQzl0OXgzK1JuS1VO?=
 =?utf-8?B?enlFTklrQUtxeXJwMmhLMVlHa0pnQytSYzh4RnBYNktvaVhPMWRUOGtoWmNu?=
 =?utf-8?B?c0lEZ3l3Uk12eG54VnJTZDZocGlUZ052cytZeEdNRW5GKzdZMjZQdk0vYk93?=
 =?utf-8?B?eHRnM3JFeGpnd2hwTEZmSWs3ZmtWbFFJWWpoRXF4RkNGSEtud1QrVDhPZzND?=
 =?utf-8?B?cEtGcXRrS1d0cHJ1VDg1VXkxMTgwRkpESmVYWVpndGhPa3BVRmdtL1hpbHh0?=
 =?utf-8?B?K2JzekIwTkhTL1B2TGZVUStWTlU5Q2FqcXE4RDlNQms2VDZ4c2VONElXRGdD?=
 =?utf-8?B?dlIvNHcvTjJJdUo2VHhVditHSVBUMENKaHpEZ2JVNmxwdkhPckNBZTc3YTJK?=
 =?utf-8?B?UW1WblV1cU5teGJsT3BTeTA1UUJrbHNOeXllY3hURU1mZDBncW9WNm8rVlFt?=
 =?utf-8?B?UEQ4WitZQ2sySHRucXRoVGpzUTZZd2tVOGpHYUFOeWo4ODhmWTJRV21SaDVE?=
 =?utf-8?B?M0tGUnJWdno1bWhLTmY5RFkreXpPVWhCNUtVMC90QURhMGI1eVBsVkZRUFcz?=
 =?utf-8?B?ZEVVOSs2a2JvdHFCWXpWM1NJRE96d0c0REZVZE5saEFZRDI0RHJpUjJldXJQ?=
 =?utf-8?B?NzZWMUllMVdmMnFNcDRCS2tDaUV0bGlBNzk3aDMyN3NSYnRQY2REVkhmWEsr?=
 =?utf-8?B?SS9GMldyRnlaeFBmVWU3Z2c4ZHV5MGg0Wmd3VEFkaXVEemxuNnVkZXIycjJZ?=
 =?utf-8?B?YXF1TFd1MWRHUVMzVC9TWVMxSngrb2ZydWJ1Q1Y0OEppWncyR0JETEh0Vlgr?=
 =?utf-8?B?QlNmT3RFY1ZLcDhqQi9ldWJZdzZDcXo3M1hGTUg1b1p6NDdwc25iMUFyeEIr?=
 =?utf-8?B?QTVnN0p6NnBhZTZKTEJDVkltNzdVQkExL2lCeXE3cnZ6d3N1Z2NEZ040dkh3?=
 =?utf-8?B?Qnk0akhBUTIwL0RPam4zaDl2M0p0cVR1M21pbGRFb0VDVzlVcWNjWWNRQzEr?=
 =?utf-8?B?anlkazRBSHJwQkFSM01qRlplbUNHQmlZTlRHdnAreUZNUEw1ZURkeUpUVm9X?=
 =?utf-8?B?ZWFuSC9zQkt3Uk9XM0h1WTdrUU8xRGZTMGFDa3FOSTV0VlBXd0orU2lFdzlP?=
 =?utf-8?B?QU5RS05YNDZOUTVQT0lXSUJBbVNmR1I2WHZZbWdBdW9COFhwWGs5SXhHVU9o?=
 =?utf-8?B?Y1oyYjhTOFc2NEJOcys2d3VEK2g3WVBHWnJRY2ZWRHEwOVNlTzh2ZTNnTmpn?=
 =?utf-8?B?M1IwY2wxSUxOdkc1Q3NWcjJLOUZvcDNTQmxDOVpYZHJ4SUpDdS9JU2xrM0lz?=
 =?utf-8?Q?Kr2e3wR/EFK+7bDPAc4XGui1ScdsB1LnEAyC8Yj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A0B0EF0475F4547B05ADFEFB24B30C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f26fdc5-550d-47fb-2ea4-08d930d1f0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 14:20:49.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGk6FtpP+AeFezEWAkFbl1bdUz7Wd6DX57LbfbEbfmIVwaREt7YouEtlxCf3MTxA5AA0zEo0QTuVO4jK64FKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0985
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDIyOjA2ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IE9u
IFdlZCwgSnVuIDE2LCAyMDIxIGF0IDAxOjQ3OjEzUE0gKzAwMDAsIFRyb25kIE15a2xlYnVzdCB3
cm90ZToNCj4gPiBPbiBXZWQsIDIwMjEtMDYtMTYgYXQgMjA6NDQgKzA4MDAsIEdhbyBYaWFuZyB3
cm90ZToNCj4gPiA+IFdoZW4gdGVzdGluZyBmc3Rlc3RzIHdpdGggZXh0NCBvdmVyIG5mcyA0LjIs
IEkgZm91bmQgZ2VuZXJpYy80ODYNCj4gPiA+IGZhaWxlZC4gVGhlIHJvb3QgY2F1c2UgaXMgdGhh
dCB0aGUgbGVuZ3RoIG9mIGl0cyB4YXR0ciB2YWx1ZSBpcw0KPiA+ID4gwqAgbWluKHN0X2Jsa3Np
emUgKiAzIC8gNCwgWEFUVFJfU0laRV9NQVgpDQo+ID4gPiANCj4gPiA+IHdoaWNoIGlzIDQwOTYg
KiAzIC8gNCA9IDMwNzIgZm9yIHVuZGVybGF5ZnMgZXh0NCByYXRoZXIgdGhhbg0KPiA+ID4gWEFU
VFJfU0laRV9NQVggPSA2NTUzNiBmb3IgbmZzIHNpbmNlIHRoZSBibG9jayBzaXplIHdvdWxkIGJl
DQo+ID4gPiB3c2l6ZQ0KPiA+ID4gKD0xMzEwNzIpIGlmIGJzaXplIGlzIG5vdCBzcGVjaWZpZWQu
DQo+ID4gPiANCj4gPiA+IExldCdzIHVzZSBwbmZzX2Jsa3NpemUgZmlyc3QgaW5zdGVhZCBvZiB1
c2luZyB3c2l6ZSBkaXJlY3RseSBpZg0KPiA+ID4gYnNpemUgaXNuJ3Qgc3BlY2lmaWVkLiBBbmQg
dGhlIHRlc3RjYXNlIGl0c2VsZiBjYW4gcGFzcyBub3cuDQo+ID4gPiANCj4gPiA+IENjOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiBDYzog
QW5uYSBTY2h1bWFrZXIgPGFubmEuc2NodW1ha2VyQG5ldGFwcC5jb20+DQo+ID4gPiBDYzogSm9z
ZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gQ29uc2lkZXJpbmcgYnNpemUgaXMgbm90IHNwZWNpZmllZCwgd2UgbWlnaHQgdXNlIHBuZnNf
Ymxrc2l6ZQ0KPiA+ID4gZGlyZWN0bHkgZmlyc3QgcmF0aGVyIHRoYW4gd3NpemUuDQo+ID4gPiAN
Cj4gPiA+IMKgZnMvbmZzL3N1cGVyLmMgfCA4ICsrKysrKy0tDQo+ID4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnMvc3VwZXIuYyBiL2ZzL25mcy9zdXBlci5jDQo+ID4gPiBpbmRleCBmZTU4
NTI1Y2ZlZDQuLjUwMTVlZGYwY2Q5YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9zdXBlci5j
DQo+ID4gPiArKysgYi9mcy9uZnMvc3VwZXIuYw0KPiA+ID4gQEAgLTEwNjgsOSArMTA2OCwxMyBA
QCBzdGF0aWMgdm9pZCBuZnNfZmlsbF9zdXBlcihzdHJ1Y3QNCj4gPiA+IHN1cGVyX2Jsb2NrDQo+
ID4gPiAqc2IsIHN0cnVjdCBuZnNfZnNfY29udGV4dCAqY3R4KQ0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoHNucHJpbnRmKHNiLT5zX2lkLCBzaXplb2Yoc2ItPnNfaWQpLA0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiV1OiV1IiwgTUFKT1Ioc2ItPnNfZGV2KSwgTUlOT1Io
c2ItPnNfZGV2KSk7DQo+ID4gPiDCoA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHNiLT5zX2Js
b2Nrc2l6ZSA9PSAwKQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNiLT5z
X2Jsb2Nrc2l6ZSA9IG5mc19ibG9ja19iaXRzKHNlcnZlci0+d3NpemUsDQo+ID4gPiArwqDCoMKg
wqDCoMKgwqBpZiAoc2ItPnNfYmxvY2tzaXplID09IDApIHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgYmxrc2l6ZSA9IHNlcnZlci0+cG5mc19ibGtz
aXplID8NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc2VydmVyLT5wbmZzX2Jsa3NpemUgOiBzZXJ2ZXItPndzaXplOw0KPiA+IA0KPiA+IE5BQ0su
IFRoZSBwbmZzIGJsb2NrIHNpemUgaXMgYSBsYXlvdXQgZHJpdmVyLXNwZWNpZmljIHF1YW50aXR5
LCBhbmQNCj4gPiBzaG91bGQgbm90IGJlIHVzZWQgdG8gc3Vic3RpdHV0ZSBmb3IgdGhlIHNlcnZl
ci1hZHZlcnRpc2VkIGJsb2NrDQo+ID4gc2l6ZS4NCj4gPiBJdCBvbmx5IGFwcGxpZXMgdG8gSS9P
IF9pZl8gdGhlIGNsaWVudCBpcyBob2xkaW5nIGEgbGF5b3V0IGZvciBhDQo+ID4gc3BlY2lmaWMg
ZmlsZSBhbmQgaXMgdXNpbmcgcE5GUyB0byBkbyBJL08gdG8gdGhhdCBmaWxlLg0KPiANCj4gSG9u
ZXN0bHksIEknbSBub3Qgc3VyZSBpZiBpdCdzIG9rIGFzIHdlbGwuDQo+IA0KPiA+IA0KPiA+IEl0
IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggeGF0dHJzIGF0IGFsbC4NCj4gDQo+IFlldCBteSBxdWVz
dGlvbiBpcyBob3cgdG8gZGVhbCB3aXRoIGdlbmVyaWMvNDg2LCBzaG91bGQgd2UganVzdCBza2lw
DQo+IHRoZSBjYXNlIGRpcmVjdGx5PyBJIGNhbm5vdCBmaW5kIHNvbWUgcHJvcGVyIHdheSB0byBn
ZXQgdW5kZXJsYXlmcw0KPiBibG9jayBzaXplIG9yIHJlYWwgeGF0dHIgdmFsdWUgbGltaXQuDQo+
IA0KDQpSRkM4Mjc2IHByb3ZpZGVzIG5vIG1ldGhvZCBmb3IgZGV0ZXJtaW5pbmcgdGhlIHhhdHRy
IHNpemUgbGltaXRzLiBJdA0KanVzdCBub3RlcyB0aGF0IHN1Y2ggbGltaXRzIG1heSBleGlzdCwg
YW5kIHByb3ZpZGVzIHRoZSBlcnJvciBjb2RlDQpORlM0RVJSX1hBVFRSMkJJRywgdGhhdCB0aGUg
c2VydmVyIG1heSB1c2UgYXMgYSByZXR1cm4gdmFsdWUgd2hlbiB0aG9zZQ0KbGltaXRzIGFyZSBl
eGNlZWRlZC4NCg0KPiBGb3Igbm93LCBnZW5lcmljLzQ4NiB3aWxsIHJldHVybiBFTk9TUEMgYXQN
Cj4gZnNldHhhdHRyKGZkLCAidXNlci53b3JsZCIsIHZhbHVlLCA2NTUzNiwgWEFUVFJfUkVQTEFD
RSk7DQo+IHdoZW4gdGVzdGluZyBuZXcgbmZzNC4yIHhhdHRyIHN1cHBvcnQuDQo+IA0KDQpBcyBu
b3RlZCBhYm92ZSwgdGhlIE5GUyBzZXJ2ZXIgc2hvdWxkIHJlYWxseSBiZSByZXR1cm5pbmcNCk5G
UzRFUlJfWEFUVFIyQklHIGluIHRoaXMgY2FzZSwgd2hpY2ggdGhlIGNsaWVudCwgYWdhaW4sIHNo
b3VsZCBiZQ0KdHJhbnNmb3JtaW5nIGludG8gLUUyQklHLiBXaGVyZSBkb2VzIEVOT1NQQyBjb21l
IGZyb20/DQoNCj4gVGhhbmtzLA0KPiBHYW8gWGlhbmcNCj4gDQo+ID4gDQo+ID4gPiArDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2ItPnNfYmxvY2tzaXplID0gbmZzX2Js
b2NrX2JpdHMoYmxrc2l6ZSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAmc2ItDQo+ID4gPiA+IHNfYmxvY2tzaXplX2JpdHMpOw0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgfQ0KPiA+ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBuZnNfc3VwZXJfc2V0X21h
eGJ5dGVzKHNiLCBzZXJ2ZXItPm1heGZpbGVzaXplKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBz
ZXJ2ZXItPmhhc19zZWNfbW50X29wdHMgPSBjdHgtPmhhc19zZWNfbW50X29wdHM7DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
