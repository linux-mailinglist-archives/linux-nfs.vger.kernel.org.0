Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8025416A72
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 05:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbhIXDhN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 23:37:13 -0400
Received: from mail-dm6nam10on2103.outbound.protection.outlook.com ([40.107.93.103]:1377
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244008AbhIXDhM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Sep 2021 23:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS1frjekuejOtkBg6LjJFlUvskh1MU8WTvQ0WjjmLzp0qy5YglfaJX/M6atrI8Aek9njV9CnEoweFGtiFEFXqprNp4S5FTJfIc5HRq2GOwjoeC+k9FH0X67g5tA8p/xn4X3V30XeS4iyzyb4ybO7LpxOPVmZeuwxBMjIUDGrUakiMKt0VgP3LRwXBkFIijA3vckCZBq99tawYCUcxWC1lwo0RKzpq+zcJwMDGvaxg0TLsOqikYfFV7Trt9NPdwhLISZ0jMHHt1LVBzszAQIHa9Cltq72Fs983L3zpJjQ7/YydWzFk5ULJ2zx5jN0LEf6qBHZpQuO5RxPT0Ct9p7LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9jMpf8+kNZqIR7QRljc7rVyP1py7GT7uOQJ0XvODnI=;
 b=byBdxKrp6ij2vU7f4tQdaBivPsarthBumCyMLK6vUlAUmC8xmM5WPxlbgJCf5n0dSRjQtiaJsMB05/jXppB7AqHUMe0oFEnursVKFNqLEMoyJxvqdyv88SWJmXSsSkke301hnhGnd2Xu7vMZlQ9eV7FdU4RfKXVQ2JnJxtxPFH8S6ovoYMuUM6b8t8A7iS0L2pV+R1z2Dd7jVBi/WDr1vnmS0r9aYkYgQGLajByEs7f59sOWLGD6KKmpC1Tqycqvy5UtuMwiHJEzb5QH3DjhfAMq56suzQpvcm4YdrqfGM+N9uMURQvN+bWvaFfXUUlwPYnkygWY5FYzlBv7XxuDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9jMpf8+kNZqIR7QRljc7rVyP1py7GT7uOQJ0XvODnI=;
 b=ZQfRkWB3E2njPCFAK69U8nfEzvKgLVOuEQHFOymgEwGrFpNKiQbny6Oz7VRRear37RYC+ZqiknDDqe4TZpcwkhlotFQwCrfXRdANWQbyJ9e8cyqSbTTWIi/ut1+S1aIuq9QJ6QjiSfDSn670y5LVZFN2rBQyEB89Q6GO7lspi0g=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3637.namprd13.prod.outlook.com (2603:10b6:610:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6; Fri, 24 Sep
 2021 03:35:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.013; Fri, 24 Sep 2021
 03:35:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jra@samba.org" <jra@samba.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Thread-Topic: Locking issue between NFSv4 and SMB client
Thread-Index: AQHXedODTOIDb0BSHkCFWx5UQXQvwauyloUAgABgTQA=
Date:   Fri, 24 Sep 2021 03:35:38 +0000
Message-ID: <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
         <20210923215056.GH18334@fieldses.org>
In-Reply-To: <20210923215056.GH18334@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84f23aed-9424-4fb9-80d4-08d97f0c605d
x-ms-traffictypediagnostic: CH2PR13MB3637:
x-microsoft-antispam-prvs: <CH2PR13MB3637658BC8DA069A88506B0FB8A49@CH2PR13MB3637.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKoPR6P0bJ0pmQVIl/1TuxAx3NbC5atw/aJL3p1zC1djwLUK9VjeOBk5oQhwCi1ApL3oTG+UvnmixPTKN3C9KbNNAI/BTy6pV+V/ISQbFJqa4anTvzE9x9Rn26LUWKf6PIlMqv3loHIC4lBG7kMU5Zdzqa+8eo7y9vKgI2eB6W3TBSY99YueKD+3WZ8qam1D6IOVMHKisR9wWUd5BSdb1XUUw5tl4Kddcz9zEFZe7hinr9/F5mHVx+zxZQeS6hn2yDuuPkSci3FZRxJmntDqitqE0vZPI6R4Roj9AY8p2q51UuHrZ98oBupcvyMNaMF9gE7w5GT74FZQOPM5+KTO8TBSAVtaRf7BEhvEiJ/O8bw4s5nw2qJREzJg/zoBi56RgNYaCuhaVM0SFACfDhpWxTJsd3TEGtjqfwMJPty+l656oCS+UkKKi7g/dIuBmOzaX53xHLM81qfQrwoOkmXhZeKY7M0CRvF/OJwPNlMolyVJKoqY9I65qkY2Q17sAVGX9dKiCvTnS2fA+fbIZfKFyZSxqMHfD2DxJgNCpjeB59tzoPiWjDEYnbvyJKx9r830CryAuBVoxpXfCv1UbkbHV1ZOACPcfB3WrOad54VoT6D8tYYtgrybQo9FmStLh7r5v0tchfxIf/H+D1bqaWitWlQSgDcDMwDZbceGJvON9ZZBiBrkd0mgxMWw6VFgEVrDkb9j5+INE+0QggLEnwjcsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(39840400004)(376002)(86362001)(38070700005)(36756003)(508600001)(2906002)(122000001)(83380400001)(66946007)(66476007)(66446008)(76116006)(66556008)(64756008)(6512007)(4326008)(8936002)(6486002)(8676002)(71200400001)(316002)(110136005)(54906003)(26005)(186003)(5660300002)(2616005)(6506007)(45080400002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZQTis3Qm1HRlNJMjFvaVg1MUwzY2RxUjY5ZXBsby9MbTZXbDQzRTVBQlE1?=
 =?utf-8?B?ZE9sSmVrK2diN1orQkFiUnEzMXR5bXp4NjdLUzdZaVBEQ3ZldTZRcWlsaG1v?=
 =?utf-8?B?Rk5ZZzI1QWEwVmpsOEkyWlZLVnJGKzBHRjNRZWR2blQwWDJNZURFVGlZdytx?=
 =?utf-8?B?UnV6SXJqT1FtUDg5ZzNpMVlEM0JBUmU5YzdlbUtQL1MwU3hRM0VCenJ4NkNm?=
 =?utf-8?B?QURNdHJodVhUay81NFBQakNka1h1S1RRZGZOcVRyQ1czQUFJaHl0OXNJRXJY?=
 =?utf-8?B?T2xYTDNBZDEyb055c0xoMHhPQ1VUWkIyem1NcmN0Nkhjc0IzWjhHdUhMUGsr?=
 =?utf-8?B?b1dIU1VaN3BGWWlJVWxVczJVQzg5SzUxVmh5L1FuS2xESElnYlk0OUU1MVpv?=
 =?utf-8?B?V1BDdzdqWVM0VTg5Yk5nd0lOQXRZbHdkVGhnY1M2bjNCV1NuR1JBa2JSSDRu?=
 =?utf-8?B?SzZsTHpMdWVMNUE4R2RBSEZOVTM3ZWNPUVdIWHZtRFhaR0lVWFFJUGVaQ3NB?=
 =?utf-8?B?Q2NtTTVxdHhVaTgwR2YwdEZ0MXhhRys4UWgrQzl0NHl2dzFFcDRoZDJ6UGpa?=
 =?utf-8?B?bkN1U04wUUwvWEZiQjdPTlhRNDFwdVhqZExBbk9iZEViS1BiQWFRa0ZnL2Rt?=
 =?utf-8?B?U0pmTFRkU1M0b2hGKzlyV3FLVUhYZUtNaThNcTVkcEk5NEozaVBvMXNaaC9h?=
 =?utf-8?B?SXRDQ2xCK3FYNzJsYjNEbXVsWXJKT1YzT2V4UGlYcGpadFZNbTA5TEoyMVBw?=
 =?utf-8?B?WGNCVlhiSG9UMXVRSXNsVTN3YnRqdkJqTFpGelRyV0N0Qm5SaFNoY0tVS2or?=
 =?utf-8?B?U2dTdzJsdUo1eThvZXhWcTgzVEY1dlRiMkVyUTZGL3RWM082Sm5hSzhkSmQ0?=
 =?utf-8?B?OUMwNnpjT01kWVd1ZzNmUytNc3Z6dWdoWGxYd3RQVnF1OXBhSnhBSzB6Vkky?=
 =?utf-8?B?ZHUzZ1pGTVl6bEpMOUVtRHl2S0hCRnZOQ2ZaMFc0STkvM200TnBxWHNQVy9U?=
 =?utf-8?B?N3lOYjJXd2ZXWHZnS01PazJ5RVJyT3k4dDAzZjNpRVAwaCtGaTZXdTN4aEFY?=
 =?utf-8?B?WE1rOS9SSU5mWHpsYmZ5N2wyWVltc3oxUVQrSEtxNUtJVU5rRXRCKytIWlJX?=
 =?utf-8?B?WTFobXg2b1JGY1lEVGtKZE5EUlhtLzZlRFNHVFNoU050eDZnTWZpNnBUellX?=
 =?utf-8?B?UG8zY2lvdkVkUWtGYkpSbEhsQkU1TkNKb1hJQnFMWUZ6Nlk3MFVqc3hJNGdJ?=
 =?utf-8?B?SUlIQzdVQS9mQTZTK1RZeWUxWnBPN3M0ZUlJTitwa3RHNm9QbnE3anJZZ2xi?=
 =?utf-8?B?OG1FRkZJRTA0alpnZE50SDc0dmVnaktGajgyaDkycDE5aDIvOWJKTXR4a25U?=
 =?utf-8?B?SjU3OTJyNFFhZVU0Yks4K3VZempUUEhVc1ErR2pTUzA3SXFBNGlxckFzcDRU?=
 =?utf-8?B?ZkpMRFhIZytWajhCUXNnS3hpNkVHTmpDNUZHMDRhSHljRzlvOUpUbHVKVlFy?=
 =?utf-8?B?Um1yclJDMXJSazVNbFFxQkN6SnNocFp4S2x3OFB0K25lQWN3cGo1VXpuRHly?=
 =?utf-8?B?WXhxWXJlRGhTbWIzbzUwYnBSbTBzOFdsSmhZMW9iS0s2WThXalRvSkpGazBQ?=
 =?utf-8?B?QlFFa0RmQk9jckV0MTVFUDcyamtRVXY5eUk3MGFSYUFFQlljQVdZalJTVG1S?=
 =?utf-8?B?WFFzZkI0dUU2ampRRndQK25iTFVFR0w3UDM1cWRoWmN0cXFZSVBQU2xjMjhC?=
 =?utf-8?Q?JpBl1FQBT1OC9C18Cx75RTeGzGUNtpdqhUvDiX/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7838CD47590DE4F897BDD28AA990DE1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f23aed-9424-4fb9-80d4-08d97f0c605d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 03:35:38.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8/e32TKcSlJlRNUY7ZVy5SUsJh4TCeEKBoBkAh2m/nfS494tMIJdEuX+2nmIpyADBANB9JdnK+dochHamQSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3637
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTIzIGF0IDE3OjUwIC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFRodSwgSnVsIDE1LCAyMDIxIGF0IDA0OjQ1OjIyUE0gLTA3MDAsIGRhaS5uZ29Ab3JhY2xl
LmNvbcKgd3JvdGU6DQo+ID4gSGkgQnJ1Y2UsDQo+IA0KPiBPb3BzLCBzb3JyeSBmb3IgbmVnbGVj
dGluZyB0aGlzLg0KPiANCj4gPiBJJ20gZG9pbmcgc29tZSBsb2NraW5nIHRlc3RpbmcgYmV0d2Vl
biBORlN2NCBhbmQgU01CIGNsaWVudCBhbmQNCj4gPiB0aGluayB0aGVyZSBhcmUgc29tZSBpc3N1
ZXMgb24gdGhlIHNlcnZlciB0aGF0IGFsbG93cyBib3RoIGNsaWVudHMNCj4gPiB0byBsb2NrIHRo
ZSBzYW1lIGZpbGUgYXQgdGhlIHNhbWUgdGltZS4NCj4gDQo+IEl0J3Mgbm90IHRvbyBzdXJwcmlz
aW5nIHRvIG1lIHRoYXQgZ2V0dGluZyBjb25zaXN0ZW50IGxvY2tzIGJldHdlZW4NCj4gdGhlDQo+
IHR3byB3b3VsZCBiZSBoYXJkLg0KPiANCj4gRGlkIHlvdSBnZXQgYW55IHJldmlldyBmcm9tIGEg
U2FtYmEgZXhwZXJ0P8KgIEkgc2VlbSB0byByZWNhbGwgaXQNCj4gaGF2aW5nDQo+IGEgbG90IG9m
IG9wdGlvbnMsIGFuZCBJIHdvbmRlciBpZiBpdCdzIGNvbmZpZ3VyZWQgY29ycmVjdGx5IGZvciB0
aGlzDQo+IGNhc2UuDQo+IA0KPiBJdCBzb3VuZHMgbGlrZSBTYW1iYSBtYXkgYmUgZ2l2aW5nIG91
dCBvcGxvY2tzIHdpdGhvdXQgZ2V0dGluZyBhDQo+IGxlYXNlDQo+IGZyb20gdGhlIGtlcm5lbC4N
Cj4gDQoNCk5vdCBpZiB5b3Ugc2V0IHRoZSAia2VybmVsIG9wbG9ja3MiIHBhcmFtZXRlciBpbiB0
aGUgc21iLmNvbmYgZmlsZS4gV2UNCmp1c3QgYWRkZWQgc3VwcG9ydCBmb3IgdGhpcyBpbiB0aGUg
TGludXggNS4xNCBrZXJuZWwgTkZTdjQgY2xpZW50Lg0KDQpOb3cgdGhhdCBzYWlkLCAia2VybmVs
IG9wbG9ja3MiIHdpbGwgY3VycmVudGx5IG9ubHkgc3VwcG9ydCBiYXNpYyBsZXZlbA0KSSBvcGxv
Y2tzLCBhbmQgY2Fubm90IHN1cHBvcnQgbGV2ZWwgSUkgb3IgbGVhc2VzLiBBY2NvcmRpbmcgdG8g
dGhlDQpzbWIuY29uZiBtYW5wYWdlLCB0aGlzIGlzIGR1ZSB0byBzb21lIGluY29tcGxldGVuZXNz
IGluIHRoZSBjdXJyZW50IFZGUw0KbGVhc2UgaW1wbGVtZW50YXRpb24uDQoNCkknZCBsb3ZlIHRv
IGdldCBzb21lIG1vcmUgaW5mbyBmcm9tIHRoZSBTYW1iYSB0ZWFtIGFib3V0IHdoYXQgaXMNCm1p
c3NpbmcgZnJvbSB0aGUga2VybmVsIGxlYXNlIGltcGxlbWVudGF0aW9uIHRoYXQgcHJldmVudHMg
dXMgZnJvbQ0KaW1wbGVtZW50aW5nIHRoZXNlIG1vcmUgYWR2YW5jZWQgb3Bsb2NrL2xlYXNlIGZl
YXR1cmVzLiBGcm9tIHRoZQ0KZGVzY3JpcHRpb24gaW4gTWljcm9zb2Z0J3MgZG9jcywgSSdtIHBy
ZXR0eSBzdXJlIHRoYXQgTkZTdjQgZGVsZWdhdGlvbnMNCnNob3VsZCBiZSBhYmxlIHRvIHByb3Zp
ZGUgYWxsIHRoZSBndWFyYW50ZWVzIHRoYXQgYXJlIHJlcXVpcmVkLg0KDQpKZXJlbXksIHdvdWxk
IHlvdSBiZSBhYmxlIHRvIGVsYWJvcmF0ZSBvbiB0aGlzIHRvcGljPw0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
