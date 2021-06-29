Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09E43B6BC8
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 02:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhF2Alu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 20:41:50 -0400
Received: from mail-co1nam11on2095.outbound.protection.outlook.com ([40.107.220.95]:47201
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232254AbhF2Als (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 20:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFjcNNE9VW6LdVgkgTCqdCpQ0F+HKsB0m0xFvbaSKiI01xtINdwpr2XiM7RSliYMbed0x2y++t8dlrRNNDSpu/yhv0UO+weYtWiHOL1jkPrypB1gRKkezJvNIxWPwjDm50gFYuw7Ip9soGXoDpVjVjs5PWTZoIZZfmEnau1MDLY/f+nLqO9m4Wr9bZdenrAa6wh15MlY6TRAc2Hw8BJcMA3y64MjYpMa/7MdIbrol1khzIq7QifknncMKsg+caqqmMIaO/cXJd9x8q0KQNPeyCJecWVR8Q0tth+y4cw85EsWBe5nS0ECfzqQIMizVqbqs/CaYnfQx3E66tmoRDNwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVgEJaI/ViQ0Th3SwEjDowduwrZF3ke4kActWaQSTZw=;
 b=T3lmEaafTB1262NdgAhdxFFR5D/G84lUeqz4MEwePVEbVSO295P1OA2lpr0eG4a2oDGxE9OPpEHmMTXiA+pKypHlj65OcejYJI0AsWTq4ttMeHuS9UBRsaGeMuGwlqHDQWSy2eM++zHvhI20IV3bee2vTuNlmk8WHf8ZiIJ1wBM/vE9YrIuaOnUkPRYnqd9Kjmq7Dl8hY0JcLxMOnePbXCYzQ7ZlovrI1m8RF1efBUzIQGp67zJei1tm1C6S1GVI+bEX0zH392KKNXHUV9615ym7bcRZdtMOYRTKK9kMQDmJwGX81pRXr0nYoW1BZhDAr7P/LG96WsLalQUc0xG1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVgEJaI/ViQ0Th3SwEjDowduwrZF3ke4kActWaQSTZw=;
 b=LoalFZADYkNxsVCqId7HoA7AVuXBJ9xAMf4erdccF73+fdvE6gsCtpr7iNIwcL1uHtRCowHLE2MUgQ5qzgkjjKI3HrpNvM1AzUKuYTlEXZenkBncVxYAbottWBAehGBK9mN2dPzkg3R+qfwmBvNlno0F1XpS1HvdS7sb+xXTPk4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM6PR13MB3483.namprd13.prod.outlook.com (2603:10b6:5:14a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8; Tue, 29 Jun 2021 00:39:20 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::1cbe:81ae:4a8f:1068]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::1cbe:81ae:4a8f:1068%6]) with mapi id 15.20.4287.016; Tue, 29 Jun 2021
 00:39:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Topic: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Index: AQHXbESDVNEfZ6l1Z0mr+wlKyxwP6KspybkAgAAiQ4CAAA1AgIAAHcgAgAAO1gA=
Date:   Tue, 29 Jun 2021 00:39:20 +0000
Message-ID: <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
         <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
         <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
         <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
         <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
In-Reply-To: <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b13bcd-3721-4586-7638-08d93a9655c0
x-ms-traffictypediagnostic: DM6PR13MB3483:
x-microsoft-antispam-prvs: <DM6PR13MB348333F5A8FF9988D54DCBF6B8029@DM6PR13MB3483.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mr8Cp+x8xFo9pFoawruIfMg0VKBY+YCADN/lYWUh4v/76Sn2IdvpTyx+ivKrFRSnFuWLC3GmRF36CR+mBLovIdx7S4zR3QHhTK9Tf/ezRrGEpV6byVZ0t1Z6qTPZ26pjy3ypJg8+pUmKU4UQPT1EOz6O6s0F6w2+0eB27b7ZSM2lie4mTJSYYRzfk1pEF481hymnbqn4nKlvWMD2GlKNu6CZgpmCE7LQgu8GKFx/dJPsNpoJpdAvga8iaiWl0krDIL12h6oiziKLBkcOQw/78nUgESYsZ5er6TPCQpuTtf5qElEVKZu4TX7ovE0YxnbEaqeSObI7qkid+6YdzByg2r5QRzxDZE74P/D0qQ40vbaJxq2WBj9/fKWUDLq9YAykJtmeJ2Yn9bPbmf9t8GvZqAPv/ou3GZix9PsdvOH2OVd/Ukbjji+U8zCErG9WQGDmpsqD203d1uK20AkvhIjm9dMPsWEC2ESPpUrBRqLzmrwOSSSkeDlXsYINdau/Wktlc/QF+QUgEXASC1/YUn3M2j7kowF9d/6vfghBZjOqCwt2BtGOHA8P+oi+Br+RQLUhrWcKtf6VWTVdj0P/3kg152aTnrn3sgBOlK+YH/9Fmz3LJoFbD5V+wS6tfJHB7LyAvXUE4NUu49ZF+tNmz342KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(136003)(376002)(396003)(346002)(66476007)(71200400001)(8676002)(66446008)(66556008)(64756008)(76116006)(66946007)(5660300002)(91956017)(8936002)(38100700002)(6506007)(122000001)(4326008)(478600001)(2616005)(316002)(2906002)(6916009)(86362001)(54906003)(53546011)(83380400001)(36756003)(6512007)(186003)(6486002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWs3aC8rQnFPbkY0RmxGM29scDNUWW5YM05jS01MVEJZaEFUTnNEZnFGTEI2?=
 =?utf-8?B?QkhrckUwczdsRHpNcXNwbUFQdXNONFViSzN2WXFwYi9ncGk5V2FrVDlrbmd4?=
 =?utf-8?B?cHlvbHE0Z0pJMGR3eGFwaG40QzMyUlBxOWd1SWpKSnlsS0hlUHUybVE3U09X?=
 =?utf-8?B?Yy9CVFZGSDEzY29INFlUcUtjZXUwaUVWbjdrenhXZnZLbjNjcWxGd1h0UzBq?=
 =?utf-8?B?ZE1Fb2dJTCtlb0RuQnRsaDZyVU00QTNuU1F0NVpmU1cyNU1DZWlJVGkwOGZM?=
 =?utf-8?B?VzJTR3QwYmFOcE1JOTVKRHBnazR0RTh3S1BZMnNETTQ1SmFTRnlyVjBKdGxL?=
 =?utf-8?B?QzVSK0FBYzhFWFl1WDA5L0RKZkJTZ2dPZjJCd3ZyVlYwLzdFRTJielV4QitL?=
 =?utf-8?B?RElEUk15cWk3TEtseVRSRkRBdEpSb2VaRTVXU1NQSjhPdkFTUGxma09menB2?=
 =?utf-8?B?alltT3hYSGdvbktYNE83SUZ6OFRyeUR1cmc3WUQrd1dLYkZBOUJUYXBMdEdS?=
 =?utf-8?B?L1cwWU5rMXUwMmdTdjg0MFhpa05KT2wvanJQR0N2MEV4OG12cSttNmJ2RFdS?=
 =?utf-8?B?clJzSGwrbk1SdHJDc0ZCTUZ4Yml1bzFEWlUzSmxUdmhmamR0M2hKQ0YwYzZl?=
 =?utf-8?B?MFM1ejMydmY0Q2l0NVc4UkR2Y3pNTGlSbFh4ZTZMZ1BqN25vbG9vS2ROdjdE?=
 =?utf-8?B?R0ZmWkQ1Sm12WHI5WnJnVmQ0K0VlRWwvL2NhamlzTzJjalBQdGg5S2ZiRE9o?=
 =?utf-8?B?QUEwZjZuVzd2OUF3WHVBMW1mRzNXNWJJQkN5c0gzNXYzTHZPR0drcWNwUUZv?=
 =?utf-8?B?cUdrRVlEZHc3dlNFRFRvSk1Ra3dyekhqYndjZGFldE1zcThDbndMcmI2b3Fw?=
 =?utf-8?B?S284VnhFMUhCbU1DWHpuZ1JLc0d2OWFGcC9LUmxPV2d0YWd0SHNubG1HS0Y4?=
 =?utf-8?B?dlV6azNBd0NBek1wSkh5QkF6R3V6NWxqcEE5N2k1OGZYQiszN1llNFlVRmdQ?=
 =?utf-8?B?eURjcXJaRklrdHBwc1RSL1Q0Z25nRUNRV0ZYb3l4ZUo3ZkRKRTMyd0tnVTFp?=
 =?utf-8?B?eHgwV0MyMzQwVkFDcUZlYXBldEJJaHVtbTFORHNKNzdUeGxmTmN1dUYwNm5x?=
 =?utf-8?B?ZnhjcWhZeVhubmwrdVNtUU90MTgvTDBCZmZ0NGxKUDU4S1BEUmU0Y1hxaUNK?=
 =?utf-8?B?eTNSZnMraUZQV3EvRmM5OGg3anNkSTJVdHN1Uk5Va0o0Q09mTW5UVDYvVTVs?=
 =?utf-8?B?em5BdDQwbVNKS1NmNnV3dWlpcG9kOXg3N0tiS0M0MzhBVmExdVVyQkZ2RlV3?=
 =?utf-8?B?NDVVZzdTUjQwTitaTDBIcWhWdm5RT1dLL3JHSE9TS2RJdEJUbjVQSCt2amV6?=
 =?utf-8?B?ZU5yUnpTZFJCSDJ4ZTBPd1RRV1FCYW80azNlRk9aZm43WVdVcGFtdWxZNk9R?=
 =?utf-8?B?Y3hxMUtxM01QeHhORmtTR3F5YTYxKzhUYWw5OWszdzBuY3ZSSVVsRzZTQ004?=
 =?utf-8?B?WVhIekJBMmJzTjFQaVhZQ2swMmhLZ1RpekRFY1RXbWxmTi91akpwM0pPTzJD?=
 =?utf-8?B?NGp2OWV1djY4QkVGVWd2L2FyWEY1VEFPeVg1a29oYkFjbzZ5R2s4cHQxRFZy?=
 =?utf-8?B?d0JMdFdnME1xZGY3Rkp0Uko5Rklwblc0ZmpFTHJ2TWxZYnZFMW93OGFpOGtz?=
 =?utf-8?B?MElIam4yNmNESmZKNjB2ZzVnRnlRRE1SM1hRWVNrQnR2dlJEbVpaSXh0Tmkz?=
 =?utf-8?Q?GlEhSu4a3RqmKQqDSa27myk6Gfd4m6M9aKVBKp1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA00955DD8B68449B2047104A80CEAC4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b13bcd-3721-4586-7638-08d93a9655c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 00:39:20.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmfnS0hBSxNLgSfp24INOGhPTJm8N+kLPAJlDmITyYIkbQ71vd9tvYnTctEqGK41usbxeAsuXc3owprQ8ZuiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3483
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDE5OjQ2IC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgNTo1OSBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjEt
MDYtMjggYXQgMTc6MTIgLTA0MDAsIERhdmlkIFd5c29jaGFuc2tpIHdyb3RlOg0KPiA+ID4gT24g
TW9uLCBKdW4gMjgsIDIwMjEgYXQgMzowOSBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24sIDIw
MjEtMDYtMjggYXQgMTM6MzkgLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6DQo+ID4gPiA+
ID4gRWFybGllciBjb21taXRzIHJlZmFjdG9yZWQgc29tZSBORlMgcmVhZCBjb2RlIGFuZCByZW1v
dmVkDQo+ID4gPiA+ID4gbmZzX3JlYWRwYWdlX2FzeW5jKCksIGJ1dCBuZWdsZWN0ZWQgdG8gcHJv
cGVybHkgZml4dXANCj4gPiA+ID4gPiBuZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBsZXRl
KCkuwqAgVGhlIGNvZGUgcGF0aCBpcw0KPiA+ID4gPiA+IG9ubHkgaGl0IHdoZW4gc29tZXRoaW5n
IHVudXN1YWwgb2NjdXJzIHdpdGggdGhlIGNhY2hlZmlsZXMNCj4gPiA+ID4gPiBiYWNraW5nIGZp
bGVzeXN0ZW0sIHN1Y2ggYXMgYW4gSU8gZXJyb3Igb3Igd2hpbGUgYSBjb29raWUNCj4gPiA+ID4g
PiBpcyBiZWluZyBpbnZhbGlkYXRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBEYXZlIFd5c29jaGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+IMKgZnMvbmZzL2ZzY2FjaGUuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ID4g
PiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZzY2FjaGUuYyBiL2Zz
L25mcy9mc2NhY2hlLmMNCj4gPiA+ID4gPiBpbmRleCBjNGMwMjFjNmViYmQuLmQzMDhjYjdlMWRk
NCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvZnNjYWNoZS5jDQo+ID4gPiA+ID4gKysr
IGIvZnMvbmZzL2ZzY2FjaGUuYw0KPiA+ID4gPiA+IEBAIC0zODEsMTUgKzM4MSwyNSBAQCBzdGF0
aWMgdm9pZA0KPiA+ID4gPiA+IG5mc19yZWFkcGFnZV9mcm9tX2ZzY2FjaGVfY29tcGxldGUoc3Ry
dWN0IHBhZ2UgKnBhZ2UsDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdm9pZCAqY29udGV4dCwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbnQgZXJyb3IpDQo+ID4gPiA+ID4gwqB7DQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoCBzdHJ1Y3QgbmZzX3JlYWRkZXNjIGRlc2M7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBz
dHJ1Y3QgaW5vZGUgKmlub2RlID0gcGFnZS0+bWFwcGluZy0+aG9zdDsNCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZGZwcmludGsoRlNDQUNIRSwNCj4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTkZTOiByZWFkcGFnZV9mcm9tX2ZzY2FjaGVf
Y29tcGxldGUNCj4gPiA+ID4gPiAoMHglcC8weCVwLyVkKVxuIiwNCj4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYWdlLCBjb250ZXh0LCBlcnJvcik7DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoCAvKiBpZiB0aGUgcmVhZCBjb21wbGV0ZXMgd2l0
aCBhbiBlcnJvciwgd2UganVzdA0KPiA+ID4gPiA+IHVubG9jaw0KPiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+IHBhZ2UgYW5kIGxldA0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCAqIHRoZSBWTSBy
ZWlzc3VlIHRoZSByZWFkcGFnZSAqLw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghZXJy
b3IpIHsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU2V0UGFnZVVw
dG9kYXRlKHBhZ2UpOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bmxvY2tfcGFnZShwYWdlKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy5jdHggPSBjb250ZXh0Ow0K
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5mc19wYWdlaW9faW5pdF9y
ZWFkKCZkZXNjLnBnaW8sIGlub2RlLA0KPiA+ID4gPiA+IGZhbHNlLA0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiAmbmZzX2FzeW5jX3JlYWRfY29tcGxldGlvbl9vcHMpOw0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yID0gcmVhZHBhZ2VfYXN5bmNfZmlsbGVyKCZk
ZXNjLCBwYWdlKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZXJyb3IpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybjsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgY29kZSBwYXRoIGNhbiBjbGVh
cmx5IGZhaWwgdG9vLiBXaHkgY2FuIHdlIG5vdCBmaXggdGhpcw0KPiA+ID4gPiBjb2RlDQo+ID4g
PiA+IHRvDQo+ID4gPiA+IGFsbG93IGl0IHRvIHJldHVybiB0aGF0IHJlcG9ydGVkIGVycm9yIHNv
IHRoYXQgd2UgY2FuIGhhbmRsZQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZmFpbHVyZSBjYXNlIGlu
IG5mc19yZWFkcGFnZSgpIGluc3RlYWQgb2YgZGVhZC1lbmRpbmcgaGVyZT8NCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IE1heWJlIHRoZSBiZWxvdyBwYXRjaCBpcyB3aGF0IHlvdSBoYWQgaW4gbWlu
ZD/CoCBUaGF0IHdheSBpZg0KPiA+ID4gZnNjYWNoZQ0KPiA+ID4gaXMgZW5hYmxlZCwgbmZzX3Jl
YWRwYWdlKCkgc2hvdWxkIGJlaGF2ZSB0aGUgc2FtZSB3YXkgYXMgaWYgaXQncw0KPiA+ID4gbm90
LA0KPiA+ID4gZm9yIHRoZSBjYXNlIHdoZXJlIGFuIElPIGVycm9yIG9jY3VycyBpbiB0aGUgTkZT
IHJlYWQgY29tcGxldGlvbg0KPiA+ID4gcGF0aC4NCj4gPiA+IA0KPiA+ID4gSWYgd2UgY2FsbCBp
bnRvIGZzY2FjaGUgYW5kIHdlIGdldCBiYWNrIHRoYXQgdGhlIElPIGhhcyBiZWVuDQo+ID4gPiBz
dWJtaXR0ZWQsDQo+ID4gPiB3YWl0IHVudGlsIGl0IGlzIGNvbXBsZXRlZCwgc28gd2UnbGwgY2F0
Y2ggYW55IElPIGVycm9ycyBpbiB0aGUNCj4gPiA+IHJlYWQNCj4gPiA+IGNvbXBsZXRpb24NCj4g
PiA+IHBhdGguwqAgVGhpcyBkb2VzIG5vdCBzb2x2ZSB0aGUgImNhdGNoIHRoZSBpbnRlcm5hbCBl
cnJvcnMiLCBJT1csDQo+ID4gPiB0aGUNCj4gPiA+IG9uZXMgdGhhdCBzaG93IHVwIGFzIHBnX2Vy
cm9yLCB0aGF0IHdpbGwgcHJvYmFibHkgcmVxdWlyZSBjb3B5aW5nDQo+ID4gPiBwZ19lcnJvciBp
bnRvIG5mc19vcGVuX2NvbnRleHQuZXJyb3IgZmllbGQuDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvcmVhZC5jIGIvZnMvbmZzL3JlYWQuYw0KPiA+ID4gaW5kZXggNzhiOTE4MWU5
NGJhLi4yOGUzMzE4MDgwZTAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvcmVhZC5jDQo+ID4g
PiArKysgYi9mcy9uZnMvcmVhZC5jDQo+ID4gPiBAQCAtMzU3LDEzICszNTcsMTMgQEAgaW50IG5m
c19yZWFkcGFnZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0DQo+ID4gPiBwYWdlDQo+ID4gPiAq
cGFnZSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIH0gZWxzZQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRlc2MuY3R4ID0NCj4gPiA+IGdldF9uZnNfb3Blbl9jb250ZXh0KG5m
c19maWxlX29wZW5fY29udGV4dChmaWxlKSk7DQo+ID4gPiANCj4gPiA+ICvCoMKgwqDCoMKgwqAg
eGNoZygmZGVzYy5jdHgtPmVycm9yLCAwKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghSVNf
U1lOQyhpbm9kZSkpIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQg
PSBuZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlKGRlc2MuY3R4LCBpbm9kZSwNCj4gPiA+IHBhZ2Up
Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPT0gMCkNCj4g
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dDsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dF93YWl0Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gDQo+ID4gPiAtwqDC
oMKgwqDCoMKgIHhjaGcoJmRlc2MuY3R4LT5lcnJvciwgMCk7DQo+ID4gPiDCoMKgwqDCoMKgwqDC
oCBuZnNfcGFnZWlvX2luaXRfcmVhZCgmZGVzYy5wZ2lvLCBpbm9kZSwgZmFsc2UsDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
bmZzX2FzeW5jX3JlYWRfY29tcGxldGlvbl9vcHMpOw0KPiA+ID4gDQo+ID4gPiBAQCAtMzczLDYg
KzM3Myw3IEBAIGludCBuZnNfcmVhZHBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdA0KPiA+
ID4gcGFnZQ0KPiA+ID4gKnBhZ2UpDQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgwqDCoMKgIG5mc19w
YWdlaW9fY29tcGxldGVfcmVhZCgmZGVzYy5wZ2lvKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHJl
dCA9IGRlc2MucGdpby5wZ19lcnJvciA8IDAgPyBkZXNjLnBnaW8ucGdfZXJyb3IgOiAwOw0KPiA+
ID4gK291dF93YWl0Og0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXQpIHsNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB3YWl0X29uX3BhZ2VfbG9ja2VkX2tp
bGxhYmxlKHBhZ2UpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
UGFnZVVwdG9kYXRlKHBhZ2UpICYmICFyZXQpDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiANCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKCZkZXNjLnBnaW8pOw0KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIH0NCj4gPiA+ID4gPiDCoH0NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IC0t
DQo+ID4gPiA+IFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiBMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gWWVzLCBwbGVhc2UuIFRo
aXMgYXZvaWRzIHRoYXQgZHVwbGljYXRpb24gb2YgTkZTIHJlYWQgY29kZSBpbiB0aGUNCj4gPiBm
c2NhY2hlIGxheWVyLg0KPiA+IA0KPiANCj4gSWYgeW91IG1lYW4gcGF0Y2ggNCB3ZSBzdGlsbCBu
ZWVkIHRoYXQgLSBJIGRvbid0IHNlZSBhbnl3YXkgdG8NCj4gYXZvaWQgaXQuwqAgVGhlIGFib3Zl
IGp1c3Qgd2lsbCBtYWtlIHRoZSBmc2NhY2hlIGVuYWJsZWQNCj4gcGF0aCB3YWl0cyBmb3IgdGhl
IElPIHRvIGNvbXBsZXRlLCBzYW1lIGFzIHRoZSBub24tZnNjYWNoZSBjYXNlLg0KPiANCg0KV2l0
aCB0aGUgYWJvdmUsIHlvdSBjYW4gc2ltcGxpZnkgcGF0Y2ggNC80IHRvIGp1c3QgbWFrZSB0aGUg
cGFnZSB1bmxvY2sNCnVuY29uZGl0aW9uYWwgb24gdGhlIGVycm9yLCBubz8NCg0KaS5lLg0KCWlm
ICghZXJyb3IpDQoJCVNldFBhZ2VVcHRvZGF0ZShwYWdlKTsNCgl1bmxvY2tfcGFnZShwYWdlKTsN
Cg0KRW5kIHJlc3VsdDogdGhlIGNsaWVudCBqdXN0IGRvZXMgdGhlIHNhbWUgY2hlY2sgYXMgYmVm
b3JlIGFuZCBsZXQncyB0aGUNCnZmcy9tbSBkZWNpZGUgYmFzZWQgb24gdGhlIHN0YXR1cyBvZiB0
aGUgUEdfdXB0b2RhdGUgZmxhZyB3aGF0IHRvIGRvDQpuZXh0LiBJJ20gYXNzdW1pbmcgdGhhdCBh
IHJldHJ5IHdvbid0IGNhdXNlIGZzY2FjaGUgdG8gZG8gYW5vdGhlciBiaW8NCmF0dGVtcHQ/DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
