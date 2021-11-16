Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3924535BC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbhKPP36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 10:29:58 -0500
Received: from mail-mw2nam12on2110.outbound.protection.outlook.com ([40.107.244.110]:14529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238074AbhKPP3z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 10:29:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbSF+4lhJ4WgtoCye6VQqmlWbws1CVorR4RRaEscokdEw0d0YwwwWOCc6P0YU5oR2GqXJs/sjCfv15ZaJTA2aK32J+KHIHlJBoZzDoS5qNwRzzMD5TAX7Cs2hbpTt0ZWu2ALilmfE4+35s4n1Oe3Zef0kNIFxpXuJBmvqZSGLzvdMBPAh13iyABiLX4k5TVPoiSFj5RgTHAW3WLVm/8//bb6LrXnOP7qB9Pi2j25C76OaLvs1O8RetmMe1y30g81T9NhSSNeciBKhhWhMKLYUYi8Tm8LI7wjFdodWOczGr33OigCrPwVRnALzxKj/L8Euzhu6G0DejD9AYSvYJoKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73UzuWlluxJd59Gt5BLrqU85q0e9LDQVPVVZdCuCN9U=;
 b=hSfIDBp6ct/AlWzU3O2RjttPkCFOzqBrKOSBtMtZBwQj3h/6jB8O0jmWh+I7Kuhay+jzYAscrJE0m1t3Ou/Sxby6EOfSOFZIwhV9+0Pl8v0osxwdPraXJ6CLj2b/TCp+AguyhZfU6bCm4hSgzGFfDU91TqXWGJA+UJv9AhpmFBRasx+aBMT9RiwFS3ILRcYpJgaHadcKoRmQ3a1HmgetupLqI/1HrofB9zlzgrxbMdnGbhUvN2d3PBR9sOpKNK09JvkG0tzYoqtJOSMyRHYQ0Djkcg28VR6Jhw5e1yXxbQWJTC5RQKwDsRswZ/qtGaxAcf/uIoFOmQsgsw60kwHTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73UzuWlluxJd59Gt5BLrqU85q0e9LDQVPVVZdCuCN9U=;
 b=HXbEjgIWgekIesSYYBQQ+KpyrZyaKso3I3k8iovmCRDP9px+WO60gcmsQydcxTR2DZBnz7dVm2EjLgAJp+e/WP8MoHej/5mAyM7cFwSZlvgLAC3Syo8aTFZtwdQOwlj/kvPiPTpBDoBN5GJc7FHMONB8FaZRIRwu/F1++GS8DmU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3768.namprd13.prod.outlook.com (2603:10b6:610:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.9; Tue, 16 Nov
 2021 15:26:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 15:26:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Thread-Topic: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Thread-Index: AQHX2vDHrPesKFwW/0+/8ZVGKsEgtawGLdKAgAABTQCAAAFQAIAAFnQA
Date:   Tue, 16 Nov 2021 15:26:56 +0000
Message-ID: <da18020922e8daaa39f8fe78e891b5ec3267e6d0.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
         <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
         <6dbcb2f39dcee7314bf772aaabf4923104ec7aee.camel@hammerspace.com>
         <EE06FD52-D67E-4792-8512-AEF97E8D8570@redhat.com>
         <01F85A5B-483C-41B4-8D3E-0CD6209232C6@redhat.com>
In-Reply-To: <01F85A5B-483C-41B4-8D3E-0CD6209232C6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 241a6e59-cd8f-4fab-a72c-08d9a9158639
x-ms-traffictypediagnostic: CH2PR13MB3768:
x-microsoft-antispam-prvs: <CH2PR13MB3768D88F9B42C35207EBC960B8999@CH2PR13MB3768.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ouR51UzVJheMwmg96zNPRzQxbDNOokPfR5s5e27l8TWehsGQ4jzv4v0xNxCW++BwID+2GNSySUbjTR+iDX8jag3vmKER1LbAJLgXwEnnli54pU7YxENex5PCnTNna9EL6UEDnun6DgpaN2KYRb8cVs7+MThdn6itQ9bxGoueu+ujewiNRnCswUdtCZ1hpgwlFk4nSxNmzhF3R0yks4Tdw2Ylq2GmozUfKB5fmQbsFgvd16GeAPST4pa97uzpuODeI07NbU8Yj0+TSeaGCRw+8XnZdX3YbHtHdEHvSWb7LirthmLefa8C4cE0cBAS7gwelJ33busPnfzKu+tBDIlb9kABEl1YenGDfEX8S7bbmhYrFQGMXIk2r1xxHf1IGvttdJwYv5VAAM0pIKK4PkxenXRSk6iuIbJFMH/P0LqYk7LufcsS/5EHSAs3qy1Nbu8WXIUEppw29sWBp7Ieq3R7/ACBKk+UFSDWb/sUIExQMu0aPOMbcfHHBSvi9AndZKOYpoGsjC4ajRnkvv9AEUPJUwAo+4C7+OIVrNz3h5ngTmloYb0Cqda31iwodhqv25eHu08o3augGHV3l/ZlMfzmCt0SmDqKVAmP583a5slsDVyu1/C02nHepRhMAoLbr6lNGhaji2bk0XYzN/gTsFBnCTsskmnugVzTU1uuveSQrqRmvmAeInfw+FXSMvi8TXRd0eS2swxFf7KU/8ijA63m1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(136003)(376002)(366004)(346002)(6512007)(83380400001)(6486002)(4001150100001)(8936002)(8676002)(71200400001)(316002)(54906003)(6506007)(6916009)(508600001)(38100700002)(66446008)(53546011)(186003)(122000001)(66946007)(4326008)(26005)(5660300002)(66556008)(86362001)(66476007)(2906002)(76116006)(64756008)(36756003)(2616005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVE1OFJCWVh2TjZROThQd0Jta2luYnpPU1p6bTNSQ29Pc3FtZGpnUk5sWnpp?=
 =?utf-8?B?VUhkaGlmak9SRXEzekttU05QOXMyUDkzRFdSSGk3Z3VBTUllUUFTSEhveHZC?=
 =?utf-8?B?dWtFZkFiL0FHUytNMkxGSy9PWDdnUUwzZW90azQrTnhjRjFUTnZSOGJMV28x?=
 =?utf-8?B?czRJYklybFpuZzJuZDN6Q3I2RkVhT216ZVNmQ2kyaE1Wa3ViR2poMnkrR1pT?=
 =?utf-8?B?ZXNQZ091R3NCQWF1a0NVTytZY2R4bktJekFGaVpIS01kRnlwZzdvV0owczBV?=
 =?utf-8?B?THlDQ0tzWVZWcDBtVU5naW0zZ2dJM3BUOUd1Rjl1Y1R1L1RwOFJXcHhoUHI4?=
 =?utf-8?B?QWQzWjFTaUNWS0lyTlJLTjhLVFdKZFFXMjBxTWovNVd6bU9ydGE3Mk4zTXUz?=
 =?utf-8?B?WHZ4SjR0WjVZMHFRR2FlbzlzN1NFcXltSTZVTHBEYURKeWdtSCtKU0FGVXVn?=
 =?utf-8?B?V1htbEVQU0tMYitqTk92S3ZnQzFPV29kV0NxZWZ6YWVYV0ZBLzdRZmZyYmgx?=
 =?utf-8?B?Nzl5c1A3dTRMNFZvanNLTC9rdElBWlU4ZjRFdHB0WlJreHVIMmVkZ2VaMzZM?=
 =?utf-8?B?cE52MWpGK1dRdGQ1QmkvdTh4c0RHcDQ2bkNMbjlUY0FiTXVJOG9uRkFhck1x?=
 =?utf-8?B?eVM2SkFvOElRN0VvMk9sYU9CWWJValFBeFl0VGZTZGF3UTdxU21Mam5IQTFo?=
 =?utf-8?B?VWQ1UDlDRk9sREJUdUZQV290VDRjdzY4eFo4aG9lZDl5NmRLczVJMmVWSjBE?=
 =?utf-8?B?cHFVYXNmUENuYmczNVVvdGFiK0lVVG81SEJFSGpWK1RBYU9TOTczYTY0ZXJt?=
 =?utf-8?B?dEFtZFF2eVk5M202SzJybSsrcUNpTkhQZUE4U2lKWDcrS3cxWUlxeFF0ZUVG?=
 =?utf-8?B?UGNTdlVrT2tGUFMzcFpWV1F6QzNEcXlQZldVWEhwcG9xdnVycU5vRkxFY2FO?=
 =?utf-8?B?YVZuZkd2aVo4S1RjeGd1SzFXcmRsYU1lUjkyQ21OSmdzYnY1alRVRmJoaFVI?=
 =?utf-8?B?SUt3Z2xCMlh6U0d5VHdLODhpMU5TT0xWUjZTRU5NZFdiTGZWTk1ERHVwN2Jt?=
 =?utf-8?B?RlB4bWY4VktQZlljRTRjSnNWSlJkK0ZjMEJIVjhEc3ZyVDBIUTc1bG4vWnI2?=
 =?utf-8?B?cnpFdDdpTERqbW5XZitnR2x0MG9URGIxQmFjckFjUm5zT0JkOWl1TTVhOVNS?=
 =?utf-8?B?bFJBOXNZT05GQ2pCR0VvazVxNnFBOHg4WWlBUnQ5aUN0S0gvM01aWHp0MkJq?=
 =?utf-8?B?d1NPdEwvTXN4L1BnOE5OUVJlcEM0RGNPM25xRjR4L084ZlFHSnYvcGxNSmRB?=
 =?utf-8?B?RDNqUmVxMllqdWhCdDhzQTh1RSt2NnRGY0RYMTVBbXFKYVh3c3NtYkVkMmM0?=
 =?utf-8?B?RG1SNWp6QUlOeU1jTThEMWJacEovNExjNnQwYnNUYUJTeWZZSkRwV1pnSXJh?=
 =?utf-8?B?U0xNVWRpb00vUEhFUkt3M1FCbHNwT0dvN2JSZmZrMUdNL0dYR1ZRalhGTzNK?=
 =?utf-8?B?ZzJTU1pjWm0vM1IyTUJqSlRGMmY5ZWM3bm1YUHlaVlc2NGhIN3lLamxrVXVF?=
 =?utf-8?B?eStxY3ovc2dPSFR0ZmczSGRNUEx1THl5R05ycEVGQ2tmYytmZnh0dk9MYTZk?=
 =?utf-8?B?dU82SnRCNDRnOWRmZlNaNmZraVh2d3Nxb3N6Sk1IWkxTNE16czh4dWMySHE1?=
 =?utf-8?B?ZUJzZHZQRzdHajlRUU5icFVtaUVFNGQ4TW5URjlwSGhLbkNUbm5zeHJabGxv?=
 =?utf-8?B?R2xIcFhVNE9MRjdyK0M2RVhLVFFyOGlNc1R4THN3MXFnT0c1NU1JWXBEOEpx?=
 =?utf-8?B?UzhRSno4T3luNFRxc0ZxSjQ3b1dqMWFkeWRRSlBNa2cxT0p6alNiejBxajdu?=
 =?utf-8?B?OXBHcVluYjhuQk9JZFZua2xUSnFJV25HQlJwWk55eXlHTmhjTzhXZldremRY?=
 =?utf-8?B?Rm5aUE5hZGVKZUFqV21Cc3NVR3BURk1oYTJIMm5jK1FoOVRuUFM3Ukk0S09J?=
 =?utf-8?B?cnpJTGdMVUMxdWl1R0I5bFVOVlJVYkV5QzVKQXIxVW1UYTdtbVBDWnNkRDRJ?=
 =?utf-8?B?RjE4ZHpCNTIvckZEVmVld01yL3dUNENacWtidG9pWGNPOFI2OTNweGpRaXZp?=
 =?utf-8?B?UllVaGJlN0ovNUNBYzJpNjBMNFhkV2wxUjZSd29nMHpjd2dPTjZZL21NLzlU?=
 =?utf-8?Q?rZbi3xj7VX1hbBQ/LxGqcIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0E707FCE26449448C56E5DACE2CA583@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241a6e59-cd8f-4fab-a72c-08d9a9158639
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 15:26:56.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVT3AGPwkbEtS3TX7LQ+Qn0b2MXjwttpAFV2FOk3jebvIlXukeRgfEfQI8a2cXBVBoHC37AEKQ67vOb38VqeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3768
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTE2IGF0IDA5OjA2IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBOb3YgMjAyMSwgYXQgOTowMSwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToNCj4gDQo+ID4gT24gMTYgTm92IDIwMjEsIGF0IDg6NTcsIFRyb25kIE15a2xlYnVzdCB3cm90
ZToNCj4gPiANCj4gPiA+IE9uIFR1ZSwgMjAyMS0xMS0xNiBhdCAwODo0OSAtMDUwMCwgQmVuamFt
aW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiA+ID4gVGhlIG1lY2hhbmlzbSBpbiB1c2UgdG8gYWxs
b3cgdGhlIGNsaWVudCB0byBzZWUgdGhlIHJlc3VsdHMgb2YNCj4gPiA+ID4gQ09QWS9DTE9ORQ0K
PiA+ID4gPiBpcyB0byBkcm9wIHRob3NlIHBhZ2VzIGZyb20gdGhlIHBhZ2VjYWNoZS7CoCBUaGlz
IGZvcmNlcyB0aGUNCj4gPiA+ID4gY2xpZW50IA0KPiA+ID4gPiB0bw0KPiA+ID4gPiByZWFkDQo+
ID4gPiA+IHRob3NlIHBhZ2VzIG9uY2UgbW9yZSBmcm9tIHRoZSBzZXJ2ZXIuwqAgSG93ZXZlciwN
Cj4gPiA+ID4gdHJ1bmNhdGVfcGFnZWNhY2hlX3JhbmdlKCkNCj4gPiA+ID4gemVyb3Mgb3V0IHBh
cnRpYWwgcGFnZXMgaW5zdGVhZCBvZiBkcm9wcGluZyB0aGVtLsKgIExldCB1cw0KPiA+ID4gPiBp
bnN0ZWFkIA0KPiA+ID4gPiB1c2UNCj4gPiA+ID4gaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFu
Z2UoKSB3aXRoIGZ1bGwtcGFnZSBvZmZzZXRzIHRvDQo+ID4gPiA+IGVuc3VyZSB0aGUNCj4gPiA+
ID4gY2xpZW50DQo+ID4gPiA+IHByb3Blcmx5IHNlZXMgdGhlIHJlc3VsdHMgb2YgQ09QWS9DTE9O
RSBvcGVyYXRpb25zLg0KPiA+ID4gPiANCj4gPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPiAjIHY0LjcrDQo+ID4gPiA+IEZpeGVzOiAyZTcyNDQ4YjA3ZGMgKCJORlM6IEFkZCBDT1BZ
IG5mcyBvcGVyYXRpb24iKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBDb2RkaW5n
dG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBmcy9uZnMv
bmZzNDJwcm9jLmMgfCA1ICsrKystDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Zz
L25mcy9uZnM0MnByb2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+ID4gPiBpbmRleCBhMjQz
NDk1MTJmZmUuLmJiY2Q0YzgwYzVhNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvbmZzL25mczQy
cHJvYy5jDQo+ID4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+ID4gPiBAQCAtMjg1
LDcgKzI4NSwxMCBAQCBzdGF0aWMgdm9pZCBuZnM0Ml9jb3B5X2Rlc3RfZG9uZShzdHJ1Y3QNCj4g
PiA+ID4gaW5vZGUNCj4gPiA+ID4gKmlub2RlLCBsb2ZmX3QgcG9zLCBsb2ZmX3QgbGVuKQ0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IG5ld3NpemUgPSBwb3MgKyBsZW47DQo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBsb2ZmX3QgZW5kID0gbmV3c2l6ZSAtIDE7DQo+ID4gPiA+IMKgDQo+
ID4gPiA+IC3CoMKgwqDCoMKgwqDCoHRydW5jYXRlX3BhZ2VjYWNoZV9yYW5nZShpbm9kZSwgcG9z
LCBlbmQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQgZXJyb3IgPSANCj4gPiA+ID4gaW52
YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2UoaW5vZGUtPmlfbWFwcGluZywNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcG9zIA0KPiA+ID4gPiA+ID4gUEFHRV9TSElGVCwgZW5kID4+DQo+ID4gPiA+IFBBR0VfU0hJ
RlQpOw0KPiA+ID4gDQo+ID4gPiBTaG91bGRuJ3QgdGhhdCBiZSAiKGVuZCArIFBBR0VfU0laRSAt
IDEpID4+IFBBR0VfU0hJRlQiIGluIG9yZGVyDQo+ID4gPiB0bw0KPiA+ID4gYWxpZ24gdG8gdGhl
IHNldCBvZiBwYWdlcyB0aGF0IGZ1bGx5IGNvbnRhaW5zIHRoZSBieXRlIHJhbmdlIGZyb20NCj4g
PiA+IHBvcw0KPiA+ID4gdG8gZW5kPw0KPiA+IA0KPiA+IEl0J3MgZW1iYXJyYXNzaW5nIHRoYXQg
SSd2ZSBtZXNzZWQgdGhhdCB1cCwgSSB3aWxsIHJlc2VuZCBpdC4NCj4gDQo+IEkndmUgaGFkIGl0
IHNpdHRpbmcgYXJvdW5kIGEgYml0IHRvbyBsb25nIC0tIG9uIGEgc2Vjb25kIGxvb2sgbm8sIGl0
IA0KPiBzaG91bGQNCj4gYmUgcmlnaHQgYmVjYXVzZSBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9y
YW5nZSgpJ3MgaW5kZXggYXJndW1lbnRzDQo+IGFyZQ0KPiBpbmNsdXNpdmUuDQo+IA0KDQpPSywg
YnV0IGNhbiB5b3UgcmVzZW5kIHdpdGhvdXQgdGhlIHVubmVjZXNzYXJ5IGF0dHJpYnV0ZSBkZWNs
YXJhdGlvbj8NCldBUk5fT05fT05DRShpbnZhbGlkYXRlX2lub2RlX3BhZ2VzKC4uLikpIHNob3Vs
ZCBiZSBnb29kIGVub3VnaC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
