Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962C36A888
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDYR14 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 13:27:56 -0400
Received: from mail-bn7nam10on2135.outbound.protection.outlook.com ([40.107.92.135]:53856
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbhDYR1z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 25 Apr 2021 13:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPFxxCycrvH8g35HqacIipAN89BnmkrMXrveE9ezfExo95sFlu2d1m0GAjvJeWWWpEKEsMyZj5cUNExLUPj5dP8jz83VUv+KPdYZP7jbd+rOLnVoVuSqxSdUK5YkNTQZIDTgws8FBrOdilve9iqo0LAlnzaHFlUsYGTo8DIyLu3VgZxapfvfcAdJnEXEmkCqkgw3u1Zq8HjJTXOgkyj9olZhf527njyWuLFq1ZFH/xlaqQs2g2wNgKTQDd91m7u566u7aWp5N+ofQ6tweO0JNVvw/l58cTxNl6fv7TNhBt1LUOXCu3+7NB3km8jY8btIJthftCjkxT0AFn3u6RN4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szKWQ9kIS4dzELDnc0PF0yvHpQP5UE1N0Wg74DFynPc=;
 b=Y3dIK/e4g6uLKKZNhTUzIPNpEkDUZBJd7LG0kOMlX65z4Uc85dbiR0gh3RHbOL45euZZknZecPNuYje1F1AKPGH+J6EyYqUDk03TaodFG/bUnAW9qo3Ycn12cGDSO3FI1VE7MT+0mduBG7XFg3TrQPcwopFPhTUuKXMlVrZXv7suGX5OaLebwYDB5NnmtoyEo2E+z4cOF3bdLg5VZChaMhH+Olf4o1nnbXU+1hwjAQP0mnnbgruFXoniXLMHJZEn4+TOeoQtFztPkeAehTPCeoMIEa/BxAI0eJJlXkEiiUFkbOWlqJbd+t9+BJDvjCYbrVB8OQKLASoPOEg6exO5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szKWQ9kIS4dzELDnc0PF0yvHpQP5UE1N0Wg74DFynPc=;
 b=aDMLXO/TE/FHldwF25baLZc05REBel2cvMagMma/4J0oFgHmDHish7Gh7fzN7lPgfHZw8YK8i3FYErbI/TBacdWJB2Trl5TabHD6u+5ayzy3M2csR9MDBK/Ztyfb0a9BM/GjCoYK1MxPG+AKqMZbv31b9XygZrc7NvlOgiNq7A4=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1225.namprd13.prod.outlook.com (2603:10b6:3:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8; Sun, 25 Apr
 2021 17:27:13 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4087.024; Sun, 25 Apr 2021
 17:27:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>
Subject: Re: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Topic: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Index: AQHXOXfnjixeaFEWH0C9YjMT3U0+MarFfYOA
Date:   Sun, 25 Apr 2021 17:27:12 +0000
Message-ID: <9dfaa112431882110d6795f93f52d7561b466b80.camel@hammerspace.com>
References: <YQXPR0101MB0968124A7F9024769EC90F23DD439@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB0968124A7F9024769EC90F23DD439@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 508a6ea8-2f19-4e2f-de15-08d9080f5d32
x-ms-traffictypediagnostic: DM5PR13MB1225:
x-microsoft-antispam-prvs: <DM5PR13MB1225253600CA974272B9303BB8439@DM5PR13MB1225.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQlb0p0EKeuVR6AwE349+pwvakpR95BjV/gVQpQ9S0H1Sg188GcQDUDqGmfY27TdqfP0RPk3U2awKIvSGc5ou766eD8cDX8XP0Egg40EiYohe57NHmje39GzePmErGqbPxG3D69K0ZXbbdbFjZIqy3ocwJydoQ5h11oWebyvAEHp9tbtUz6uXIFwaXUZVmksz7w1pSNN7/XycumNsMM/XkTHHt15LDuYIBZekVrjiAnYZa3RRYQ+oBRlVuc5I1WflWrwLlY9YFuSBhRQLp+LVYj05/z4SmenJTDjhM5kr/e2M7RAZVIX0musyhuBvcL5GMGNwuWCbPtHFl85TktX+7MLg1jbRq0KVVE7HJeO0cI3Fe9DquLfiO8wmCXZm0+I5ZH2pm4KxHeOGldBgu2y8KZ/PQ3HUvJsc4dfKjqgsGPf5cniFpYFI48k8AfkAWUe869+jNmtnAyFgtHykUE2mWO3J31wgpzQODymVn9FgI5V6t1lZjYCn59I2KWf2MuWjKEQZ3w5PBBpqAwj5ldVYJhUKGPC5xd5xlpPRXktbo2+wUJRtMajNVUlZd8Zdz2aqjEy8mNIXVuWZ35RgNdNh29Tmau7f86izTw4hsywOzq3EQsMxWNxEaFtvhyFgGSpkVev3tJBHUlP0qlvyliZGkILMfX/ZgHNps+zn7Af1yB9cthfc3SsKWDclXTW3idz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(6486002)(966005)(508600001)(83380400001)(86362001)(26005)(38100700002)(110136005)(122000001)(36756003)(2616005)(6506007)(186003)(6512007)(8936002)(8676002)(66556008)(64756008)(66476007)(66946007)(66446008)(76116006)(91956017)(2906002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y3RrdGNoZkt1STBld0dCdHFIK1paQUlBaEVtUkJ1dndsek1EQTJsS0l5RXdQ?=
 =?utf-8?B?S0hCOTgyV0J3SUgwQTNXTS9GNUYrWVcrQy9aV0tQSUV4dDBQVVVYLytObHRC?=
 =?utf-8?B?R0p1VGMzelBiVndVanFNZmJrRnczVWV5dzBqbDZacklrTS9pYy9rTElYRitU?=
 =?utf-8?B?VnJ0cUxiMkJPeXgxMU9kQ1FXdDBiMzIyUzdyc21UTnk2dzhGZTQ3NEJGS2pu?=
 =?utf-8?B?WmtDdTZXQXQ4b0d3N0JFM2FoRkw1dXBhRFJ2ZFV5cU5WTFZQMTVzYmpoeVVF?=
 =?utf-8?B?VHVTK0d4aVd3TitEaHNKU2lBY2VLMFIvYmgvbEdQc0pMRVI0ZUZvUGRHcFFM?=
 =?utf-8?B?b2RMS01CdHExeXVXR0NweDR4YmxnQWRhMGo3anNsNWxHTXQ2TW1GdWdla0M2?=
 =?utf-8?B?Zk9TYzFoakIwTlpqVFVYRWw2aFdIdWdlRVdWRkZ0WnpONjYrTzE3Um1rUHVB?=
 =?utf-8?B?S2tnMG1pRmlLaHF1Nk1XVDJ4TlhQU3lWc2JtVHVLWUpPdnVUSU5ZWWdzUDd3?=
 =?utf-8?B?ZWZxSCtKZGdSYXJtR2FiZWMrMmhUZ1hTTXhUQTZtN1g4ckdTRXkrSTBNajdo?=
 =?utf-8?B?aVRXRWFCSW5EZmFqNUlqajhwWm5mTVVPNGl1N3ZtZWIvb2xlMHlJM0hQRGZ6?=
 =?utf-8?B?cE1mSHZaa2xXZVJvQ0FRRUF1YTYvQ0RjUGlSSzNsR1lqNHRkellwMGdaK2RV?=
 =?utf-8?B?ZTgzRXIvNzNsNEtlUmI5YjcvTVZ6ekRvNzZ4RG1PQjVSaFJ5YWZldWZIQVBo?=
 =?utf-8?B?VzhLYkJPb2h5UW5rbkJ1SElvSVRMU3lvaE1FeWZRTjYzMVJyaC9Bck5OcHh5?=
 =?utf-8?B?aU1DeG9uZ2tNZ2llb2FVQldqMEtnekQ4bVQrNXpVeEpRSVVicE5Za3k4OVkx?=
 =?utf-8?B?MStTN1lobUc4QnhDQTZMcFpFSXV1SGFjMkFQWGRiTXU5a2IzMXhEYk1ycGhy?=
 =?utf-8?B?K3h4Q1g0ZkNsaUVRU0k2ZjBxZlBiblV4VGh2anZ0Q0FoMGozNE5wTHZmU1F0?=
 =?utf-8?B?UWRDWnFwVk8zUFpEZEthQVBQK3QzWjBDZ1ZKcTVtRmRjMFVpNFVrQlZLRXh6?=
 =?utf-8?B?dGsyVUQxTW5FM3phQmRCeG9ZcFJOVkpzOGk5NFc5UEZSRnBHT2pIU0t0ZTlv?=
 =?utf-8?B?SCtZTXpTM3pzWlNOMkRSUVROUUtYVDNsSlIzNEZjR3puTktBSGZOVXlteG9P?=
 =?utf-8?B?Zk9CeUxNZ0JRYmlwaVhCME11Y3p6MTBVRk1OOC80aXB4ZkZBU0ZNeWZyTU9H?=
 =?utf-8?B?bERNSElhRmZDUlRtZ1diYUJnand1dDg4cVptaFNQVitaOW9GZHZOWkVHR1BB?=
 =?utf-8?B?REI4YWFoTjkwWWdSL2xReVVhajRGclNkVzdieldjSXZMbzNmbnZhVGxjaXcr?=
 =?utf-8?B?WVlsSDQxZExINGhIQUsyUXJvV0lQUHVpcUIreTVSU2dBUklKWXQvMnBCNzU3?=
 =?utf-8?B?YUVpRVNveFdPVjlZTHZxbTh5WnZyaHliVVl0dUVuU3dFYTBZR2pFVkQvckw4?=
 =?utf-8?B?Y1kxUThuSC9yRUN6RGYrR3pkYm1VT3FtWlNRV0FTUCtVc3Q1WlBuTHFDVlZs?=
 =?utf-8?B?ejh2L3c4aTJVdEZzZWxNTStKQUJFc0R2aFlTSHFOWTh5M0p5RW1pTjdGN3hG?=
 =?utf-8?B?cTkvRXdDNFljRUpCWkl0SlQ0bjVyVXpTODJ1V09pNjlrd283TVRsYTkvbFhP?=
 =?utf-8?B?cTlURDhGSHVHamRRUTE4QTlzMmVyc1hKMlZ2bE1waitjVlh3aXZwR2ZqWmFo?=
 =?utf-8?Q?J+KhM0KTfjxtinnJ7SxSWa8PHiEcN1zzFjmfP2P?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DC0C3C2E0B434A8B50B7B665E0E729@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508a6ea8-2f19-4e2f-de15-08d9080f5d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 17:27:12.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGucfaKrkLD78+kK3RCqjJXS34ufg/kkhVjJFq4TehrMpHnDJPqZnfXdlEJUKxYz1R8thQFW9rr/htDL5CgrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1225
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTA0LTI1IGF0IDAyOjI5ICswMDAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSBoYXZlIGJlZW4gcnVubmluZyBhIHNpbXBsZSB0ZXN0IHVzaW5nIHR3byBj
bGllbnRzIChvbmUgRnJlZUJTRA0KPiBhbmQgdGhlIG90aGVyIExpbnV4LCBGZXJkb3JhIENvcmUz
MCwgNS4yIGtlcm5lbCkgd2l0aCBkZWxlZ2F0aW9ucw0KPiBlbmFibGVkIGluIHRoZSBzZXJ2ZXIu
DQo+IA0KPiBUaGUgdGVzdCBjb25zaXN0cyBvZiBydW5uaW5nIHRoZSBjb25uZWN0YXRob24gZ2Vu
ZXJhbCB0ZXN0cw0KPiBhbHRlcm5hdGVseSBvbSBlYWNoIGNsaWVudCwgdXNpbmcgdGhlIHNhbWUg
ZGlyZWN0b3J5IG9uIHRoZQ0KPiBzZXJ2ZXIuDQo+IC0tPiBBcyBzdWNoLCBlYWNoIG9uZSByZXN1
bHRzIGluIENCX1JFQ0FMTHMgb2YgZGVsZWdhdGlvbnMNCj4gwqDCoMKgwqDCoCBmcm9tIHRoZSBv
dGhlciBjbGllbnQuDQo+IEV2ZXJ5dGhpbmcgc2VlbXMgZmluZSB1bnRpbCB0aGUgc2VydmVyIGRv
ZXMgbXVsdGlwbGUgY29uY3VycmVudA0KPiBDQl9SRUNBTExzIGZvciBkaWZmZXJlbnQgZmlsZXMv
ZGVsZWdhdGlvbnMgdXNpbmcgZGlmZmVyZW50DQo+IGNhbGxiYWNrIHNlc3Npb24gc2xvdHMuDQo+
IC0tPiBUaGVuIHRoZSBMaW51eCBjbGllbnQgZGVjaWRlcyBpdCBtdXN0IGNyZWF0ZSBhIG5ldyBj
b25uZWN0aW9uLA0KPiDCoMKgwqDCoMKgwqAgd2hpY2ggYnJlYWtzIHRoZSBiYWNrIGNoYW5uZWwu
DQo+IMKgwqDCoMKgwqDCoCBBZnRlciAwLjFzZWMsIHRoZSBGcmVlQlNEIHNlcnZlciBub3RpY2Vz
IHRoZSBicm9rZW4gYmFjaw0KPiDCoMKgwqDCoMKgwqAgY2hhbm5lbCBhbmQgc3RhcnRzIHNldHRp
bmcgU0VRNF9TVEFUVVNfQ0JfUEFUSF9ET1dOLg0KPiDCoMKgwqDCoMKgwqAgLS0+IDE1c2VjIGFm
dGVyIHRoYXQsIHRoZSBMaW51eCBjbGllbnQgZG9lcyBhDQo+IEJpbmRDb25uZWN0aW9uVG9TZXNz
aW9uDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFuZCB0aGluZ3Mgc3RhcnQgd29ya2lu
ZyBhZ2Fpbi4NCj4gDQo+IFRoZSBteXN0ZXJ5IHRvIG1lIGlzIHdoeSB0aGUgY2xpZW50IGRlY2lk
ZXMgdG8gY3JlYXRlIGEgbmV3IFRDUA0KPiBjb25uZWN0aW9uLCBmb3JjaW5nIHRoaXMgMTVzZWMg
aGlja3VwIGVhY2ggdGltZSBpdCBoYXBwZW5zPw0KPiANCj4gSWYgeW91IGFyZSBpbnRlcmVzdGVk
IGluIGxvb2tpbmcgYXQgYSBwYWNrZXQgY2FwdHVyZS4geW91IGNhbg0KPiAlIGZldGNoIGh0dHBz
Oi8vcGVvcGxlLmZyZWVic2Qub3JnL35ybWFja2xlbS90d29jbGllbnRkZWxlZy5wY2FwDQo+IFRo
ZXJlIGFyZSBtdWx0aXBsZSBleGFtcGxlcyBpbiBpdC4gT25lIGlzIGF0Og0KPiBwYWNrZXQjIDM1
MTgsIDM1MjAsIDM1MjEgQ0JfUkVDQUxMIHJlcXVlc3RzIGZvciAzIGRpZmZlcmVudA0KPiBkZWxl
Z2F0aW9ucw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdGltZSAxMzcuNQ0KPiAtLT4gVGhpcyBpcyBmb2xsb3dlZCBieSBhIGNsb3NlIGFuZCBvcGVu
IG9mIGEgbmV3IFRDUCBjb25uZWN0aW9uLi4uDQo+IHBhY2tldCMgMzU4MiAtIGZpcnN0IG9uZSB3
aXRoIFNFUTRfU1RBVFVTX0NCX1BBVEhfRE9XTiBhdA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGltZSAxMzcuNg0KPiBwYWNrZXQjIDM2MDQgLSBj
bGllbnQgZG9lcyBhIGJpbmRjb25uZWN0aW9udG9zZXNzaW9uIGF0DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW1lIDE1Mi43DQo+IFRoZW4gdGhp
bmdzIHN0YXJ0IHRvIGhhcHBlbiBhZ2Fpbi4uLg0KPiAxOTIuMTY4LjEuNSAtIEZyZWVCU0Qgc2Vy
dmVyDQo+IDE5Mi4xNjguMS42IC0gTGludXggY2xpZW50DQo+IDE5Mi4xNjguMS4xMyAtIEZyZWVC
U0QgY2xpZW50DQo+IA0KPiBJZiB0aGlzIGlzIGEga25vd24gaXNzdWUgdGhhdCB5b3UgdGhpbmsg
aXMgZml4ZWQgaW4gYSBtb3JlIHJlY2VudA0KPiBMaW51eCBrZXJuZWwsIHRoZW4gc29ycnkgYWJv
dXQgdGhlIG5vaXNlLg0KPiANCg0KU2hvdWxkIGhhdmUgYmVlbiBmaXhlZCBpbiBMaW51eCA1LjMg
YnkgY29tbWl0IDc0MDJhNGZlZGMyYiAoIlNVTlJQQzoNCkZpeCB1cCBiYWNrY2hhbm5lbCBzbG90
IHRhYmxlIGFjY291bnRpbmciKSBBRkFJQ1QuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
