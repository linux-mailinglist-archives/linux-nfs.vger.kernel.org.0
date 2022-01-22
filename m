Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58CF496D45
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 19:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiAVS2B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 13:28:01 -0500
Received: from mail-sn1anam02on2132.outbound.protection.outlook.com ([40.107.96.132]:35927
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231531AbiAVS2A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 22 Jan 2022 13:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRRElIs4ysIe+UPqK5lr/a2K+4DmDKqjjEzztvBCoIDAYTnFzkgAh7uWB/ppW3VMo2fMenLu3QnGgTrgmfOKxyNGKyd+IQLWKt+M/CCCZMWQ3ahHM3nuE9G7BCHyqTNUd+1FZWuS6VKOFKQsHvTtgvWlyle7CaKyswzu2DotIppmGwUS+DcAbYjafofkMRdWQd0lE8Gob8+qIm4zHYOpkK/BB7F8OHNIJqercMBZI3LMjUdIIPv6x/Rce3cwo0/Nrp8nG+U735xArrdoqE1FqfLPwaQoQ7kFAnlIEOXRpJzp+ItIeA4qp5OT2iDfDyCGnjMTIZ8EgDfhDtbvXUXa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IipqJwEuOxBBQLjyws3m18dRHN8zo6u8oLfC9Ogt4XM=;
 b=iEnNIExmRxiHU20V+Ac8m/mloZt2Wve+C3buXsE/y+LF1UKsg9k+jn/i43Iq1eaU6NFAkXGnjx7pjf8Dwc+5xhoAHo+zAvyPOI5sxVV9Ejeg2RlPsXEGEHNSur2v5oSnfT56WtwVPE8R9eqx3OhqBs0sJwMFfO48ZAV1+63w8azPvRApq50zBAC509co6zm1eo3DML7KJHArdKMAcdzLZ535rtXMZDEtkvCduUQ8mCRic6/oRZIQx9WxIoAEWJ8JXIYcGBT92GW/c1yc921qDPvZwqFGzv3XGHdD8cNK8UUc+bE/vy3rpCaNzZf4EwhwqC0DrTY1bq6mP2opLnB1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IipqJwEuOxBBQLjyws3m18dRHN8zo6u8oLfC9Ogt4XM=;
 b=DIa6MAQ7S0hwde34JbDESjzyOXXAHi2BxNFUgc8rIfn6P99vJ+7c6BfMdevUEvizRmUVxFTnlH0IzDpPp588lmYbpzBD1TJ8ScFpYhPYyUvqqMW0CuT4nLQ+RT2rWf04muMzD5d1wbrXj8mMBWDowOxbDn+zQWVJ3X7ezrSgu+I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW3PR13MB4010.namprd13.prod.outlook.com (2603:10b6:303:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Sat, 22 Jan
 2022 18:27:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%5]) with mapi id 15.20.4930.009; Sat, 22 Jan 2022
 18:27:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfQx4I0NsJdCEimB7zH1Nz4w6xuD5oAgADuzQCAAEhEgIAAFvGA
Date:   Sat, 22 Jan 2022 18:27:56 +0000
Message-ID: <b780f2adabad8beb13c0deca62561116b61e2402.camel@hammerspace.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
         <20220121185023.260128-1-dan.aloni@vastdata.com>
         <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
         <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
         <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
In-Reply-To: <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ddbf9db-3794-476f-d2e3-08d9ddd4e94c
x-ms-traffictypediagnostic: MW3PR13MB4010:EE_
x-microsoft-antispam-prvs: <MW3PR13MB4010B761F7E54BBC30056DF1B85C9@MW3PR13MB4010.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbZWrXBVdSdfS3O4Ee4rJfGMOaz5pnw9r+23/pJArvX+xtyuOqBqgvriC3g77tmkBGgZLsE+obtMvnZgWj/gZ7wRQG5gdCZyxunaE6UsIdYXRxFqxmlOgKtIvFW0lo+7zmc7YWOZXmg8PMpwWx/555MNlVDZTGli9FCwnvXvf6+227MST/E1KVaH/x1Xn7XB3vRA6aNB44E+b5PXKO3M6YFY8dfPhacQ93KYAuQSQ6j3kLzDJOGjc2Ml3UDVUGbDqhpphJ6169tOn5KNIMOd+9ky6bV1zd6F0FFORH6KAG+4/j49C9Q4YttHx47R7ZVGYvfBZas51M3tuf8pnGVn9JmYsP+c9Kse9BGJKGuR5C9ZQhq036y++zf19CzXVepFKAT+9Znb2G131JKtOpi940D9R5Yjx9nzLf6NVF5EnIDlxszPP5dJVsmXiAW3icKIEXdW7fP3nQPdmCwtb1KCh+uI7fvMRzfubwqCGQ95SWbb9ypcNGyykmklhyjEvPt4rNRE04jXP5AMg920FughvFZrnJHnq+tmcBsFsbLl5AMcwlgRq4x7Ky2pcXa8Y3XHf868WQ5LNDxo9m+Ufu1+MYwIa8Lj5v5sEceNEnAWxD/hYzF/jCKDR5xlGfaxoVVrkDKQhG4qQCyX0ZR50eIWt+eDHUB//iTI5a9cgd2+D0WKz1L3Dhe3Tn0xsF2W95OWQM7/UQ/DwZEneih8qKEPmEjCuSa786NPjU8PfwkHloecEZjGQDKsLmBuoxDht3OM/XICfZXdZ4E71Jsxl05Fi6W02SDrd10L+eAea59uYQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(136003)(39830400003)(376002)(83380400001)(71200400001)(316002)(53546011)(110136005)(54906003)(508600001)(26005)(186003)(2616005)(36756003)(6486002)(966005)(6512007)(6506007)(2906002)(38100700002)(86362001)(8936002)(38070700005)(8676002)(4326008)(5660300002)(76116006)(66556008)(66946007)(66476007)(64756008)(122000001)(66446008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umx0N0ljRDcwaXBtamt1OHUzY242dWttQnVIRDRsbGh6NmxNcVlMQUxDMHk0?=
 =?utf-8?B?TWVBODFUM1Q3ZDJxc24zTm44TTdnRGNoYnNQQy95a1l0SEFsZTM5cnY5M2Qz?=
 =?utf-8?B?MlBXTUo1MW5MY1JSVURNOFhjcmhldW5tdHF5U2dSMjM5dktsSlRjQXpLSUQw?=
 =?utf-8?B?cHdWWTVrRGM5Sm9peFQ1NktuN3NuWUFOVlVyMjNDRjc0K1AyTllJd0xhQmRO?=
 =?utf-8?B?RGlQSGdrTWRqR013R2NFQXJvTVpWbkJmdGJXajNteFZEbTZxNHlnTksvMUg1?=
 =?utf-8?B?bklmKzVzOWlMWlpqRCt6enBzMldBWERoUXdaaWxmWHlCdGtUYjNmWFJRbTFy?=
 =?utf-8?B?OHo1d3BuSTVQek9ZMlZ5Q1Nock5hYXF6aEpBaWNqRzZ6bVlIMmlQZ09BbnhX?=
 =?utf-8?B?VWliZWw0WEQvMURTOWdIZmJhVFVxVUVyb3ZLUnZKZHhuTzBOUUVDRzJTd0hz?=
 =?utf-8?B?UkpOWlV1a0tFay9SS1dTRkhhcTBPMGhQQlZrcVhiRVA5V2NMN0dQY013dEVw?=
 =?utf-8?B?RlIzTDZrTWw1RkpSak9ucmZnVUpJeDhkc3dhTDQxajZLTHpRWXZoMmJzckh3?=
 =?utf-8?B?Qm93UXZFRzErc2ZlRGNBQ08rSnNNVGhGRzVKazNDczBvL0hsd0xLMVdnMGh2?=
 =?utf-8?B?bFBTNjhWOHhRMzFaaGsyN2RoTDhPY3FlVURIT1JyMU1BWXd6blpOM2tBUmkv?=
 =?utf-8?B?UXlkSkVxNjFyTVZPSEhMVFdFM3VwWTlFeWJRK0NQeDJBYXM2L3dablduYSta?=
 =?utf-8?B?Y1VrVHEzODBZaW1HVnduUFRCTW1USlBWS1lFZ2dESWxPaUpubXNUNHQ5RjVE?=
 =?utf-8?B?NjQ1ZGhLa1UvK1pFcHQrWEljM2hWczV4THpZc24yQlV1VUR2d1JFYzRrN1Bk?=
 =?utf-8?B?TXAzTXk2ZEVFTXY0UmI0RklnREcyVnZpTzhxZkpDMUhQRjdKMGs4RklINGxz?=
 =?utf-8?B?U3lxVUJ0Umd5bExlY2ZJVEpJMjNGUHdxNWwxaU9BRmhDdzc4M0xjay8rbGVV?=
 =?utf-8?B?ZWliRTFPT1BuVUFMVjNFc3ZqU2s4ZDFJWHJwTVorOTFEajY4OExJK3pFeWRj?=
 =?utf-8?B?dUh1YTFPUDZZa0xvN3Q4d3M0cFhiSkc2Mm5YamJwMlhCNzYwdjIzWXFWVGRC?=
 =?utf-8?B?RXlrclhvSnN2M2hDYU93MGhuZjk0Mko1TTdRcTVDalRYMmxoMkdvODZYTGZC?=
 =?utf-8?B?d2tNR3ErSHNQaVU5a3VWVkZVdE56bG12YWFwNHdJS3pSaFAyaThVdUhweEtj?=
 =?utf-8?B?bTdSVEx0VGl2UjIveDYrSnk3OXVkVElvZDNOYUJNV3BPNkZSNEp1NHFiVTg4?=
 =?utf-8?B?TXc4WTJpM0lkbyt5N2lqeUx4OUo1MVFpQ1lGMjY0clJWRGpUczc4NjFOWUVJ?=
 =?utf-8?B?Zk01Z1JiZVhQRlA5QldhbGx4YkJydWlCTnJwQmFmb3dwRStPdVBoWDlaajNh?=
 =?utf-8?B?REV1TU4xNE4zVTd4dWxsYkNYRDRUYzV5V0ZIYUNLNVJuZWZmZnpwZmdmYis3?=
 =?utf-8?B?RjNVODFiVlhaQXl2Y2dydkd6cjA5NldidXBRdXJWcUVxRkV5WXdlZnJFUVdN?=
 =?utf-8?B?YWJnN01SdEttR1Q4OEp0VitSbERUQytweU9iWUZ2VDlvVm1kOWtGRUI3K2VI?=
 =?utf-8?B?MWxxeVVsM2NUa1ZOeDhRQzFSSjc3bWdaaVVVWEJFWEFGTVNBWFJPWFV4U1N0?=
 =?utf-8?B?bkRVNEcwYm1JOWZYSmN6SVJoNDlaclc1UW4zRzF1dFRaWEVBaXVaZUpDQVFq?=
 =?utf-8?B?Q0hNSEtvOHlENC9FT2dHV2NLdStScW5LcUczTmt4NUIrZFc5RVdzaTEzT1Rp?=
 =?utf-8?B?Nzk4OENIcmNLOHZLNW15YnNWaEFWVmZMZkVKSXkyOUQ4OGRzQjQwRGVRSDJJ?=
 =?utf-8?B?M1hxR3ZFa1hDM21BYk93VkFhKzB5UDYzQTVmR0lEbElyampCaEtiUEZJcG9l?=
 =?utf-8?B?ak9odlkxdXhXZEdGdXFvamNxWkhmb2w3K1o5cStWRmo4Wm5IaUlGTzNXWUVR?=
 =?utf-8?B?aUQwcTR0cUYvWW10QWhRSkxCSE16eFpFUERCOC9wMndZQUtiZy9oWWZBRWli?=
 =?utf-8?B?QnVRWW92a0tnTjdoWFJBbndrS3ZKcm5ZV1ZMcjNnaElTb0ljWmpScVZEZXhL?=
 =?utf-8?B?NjBiN3RqTTVzb242OGZEVGd5cWtDN3hsUGg0UWl1Y01wQ3dvalVVSzZwWk9W?=
 =?utf-8?Q?s34+7xS9Gmfl1/uAi1t8mwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9544489E6488794E91A853F34AE5D5A9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddbf9db-3794-476f-d2e3-08d9ddd4e94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 18:27:56.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1qNS3Aj9R/jIl9/mLI6NtIMehC4dlhYZW4UiMqgoTPeKm97fu6lJcQ2GhBcHj/7oxxPKBHyJR62hT2PAx5Mbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4010
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAxLTIyIGF0IDE3OjA1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIEphbiAyMiwgMjAyMiwgYXQgNzo0NyBBTSwgRGFuIEFsb25pIDxkYW4uYWxv
bmlAdmFzdGRhdGEuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgSmFuIDIxLCAy
MDIyIGF0IDEwOjMyOjI4UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiA+ID4g
T24gSmFuIDIxLCAyMDIyLCBhdCAxOjUwIFBNLCBEYW4gQWxvbmkgPGRhbi5hbG9uaUB2YXN0ZGF0
YS5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gRHVlIHRvIGNoYW5nZSA4
Y2ZiOTAxNTI4MGQgKCJORlM6IEFsd2F5cyBwcm92aWRlIGFsaWduZWQNCj4gPiA+ID4gYnVmZmVy
cyB0byB0aGUNCj4gPiA+ID4gUlBDIHJlYWQgbGF5ZXJzIiksIGEgcmVhZCBvZiAweGZmZiBpcyBh
bGlnbmVkIHVwIHRvIHNlcnZlcg0KPiA+ID4gPiByc2l6ZSBvZg0KPiA+ID4gPiAweDEwMDAuDQo+
ID4gPiA+IA0KPiA+ID4gPiBBcyBhIHJlc3VsdCwgaW4gYSB0ZXN0IHdoZXJlIHRoZSBzZXJ2ZXIg
aGFzIGEgZmlsZSBvZiBzaXplDQo+ID4gPiA+IDB4N2ZmZmZmZmZmZmZmZmZmZiwgYW5kIHRoZSBj
bGllbnQgdHJpZXMgdG8gcmVhZCBmcm9tIHRoZQ0KPiA+ID4gPiBvZmZzZXQNCj4gPiA+ID4gMHg3
ZmZmZmZmZmZmZmZmMDAwLCB0aGUgcmVhZCBjYXVzZXMgbG9mZl90IG92ZXJmbG93IGluIHRoZQ0K
PiA+ID4gPiBzZXJ2ZXIgYW5kIGl0DQo+ID4gPiA+IHJldHVybnMgYW4gTkZTIGNvZGUgb2YgRUlO
VkFMIHRvIHRoZSBjbGllbnQuIFRoZSBjbGllbnQgYXMgYQ0KPiA+ID4gPiByZXN1bHQNCj4gPiA+
ID4gaW5kZWZpbml0ZWx5IHJldHJpZXMgdGhlIHJlcXVlc3QuDQo+ID4gPiANCj4gPiA+IEFuIGlu
ZmluaXRlIGxvb3AgaW4gdGhpcyBjYXNlIGlzIGEgY2xpZW50IGJ1Zy4NCj4gPiA+IA0KPiA+ID4g
U2VjdGlvbiAzLjMuNiBvZiBSRkMgMTgxMyBwZXJtaXRzIHRoZSBORlN2MyBSRUFEIHByb2NlZHVy
ZQ0KPiA+ID4gdG8gcmV0dXJuIE5GUzNFUlJfSU5WQUwuIFRoZSBSRUFEIGVudHJ5IGluIFRhYmxl
IDYgb2YgUkZDDQo+ID4gPiA1NjYxIHBlcm1pdHMgdGhlIE5GU3Y0IFJFQUQgb3BlcmF0aW9uIHRv
IHJldHVybg0KPiA+ID4gTkZTNEVSUl9JTlZBTC4NCj4gPiA+IA0KPiA+ID4gV2FzIHRoZSBjbGll
bnQgc2lkZSBmaXggZm9yIHRoaXMgaXNzdWUgcmVqZWN0ZWQ/DQo+ID4gDQo+ID4gWWVhaCwgc2Vl
IFRyb25kJ3MgcmVzcG9uc2UgaW4NCj4gPiANCj4gPiDCoA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW5mcy9mYTk5NzQ3MjQyMTZjNDNmOWJkYjNmZDM5NTU1ZDM5OGZkZTExZTU5
LmNhbWVsQGhhbW1lcnNwYWNlLmNvbS8NCj4gPiANCj4gPiBTbyBpdCBpcyBib3RoIGEgY2xpZW50
IGFuZCBzZXJ2ZXIgYnVncz8NCj4gDQo+IFNwbGl0dGluZyBoYWlycywgYnV0IHllcyB0aGVyZSBh
cmUgaXNzdWVzIG9uIGJvdGggc2lkZXMNCj4gSU1PLiBCYWQgYmVoYXZpb3IgZHVlIHRvIGJ1Z3Mg
b24gYm90aCBzaWRlcyBpcyBhY3R1YWxseQ0KPiBub3QgdW5jb21tb24uDQo+IA0KPiBUcm9uZCBp
cyBjb3JyZWN0IHRoYXQgdGhlIHNlcnZlciBpcyBub3QgZGVhbGluZyB0b3RhbGx5DQo+IGNvcnJl
Y3RseSB3aXRoIHRoZSByYW5nZSBvZiB2YWx1ZXMgaW4gYSBSRUFEIHJlcXVlc3QuDQo+IA0KPiBI
b3dldmVyLCBhcyBJIHBvaW50ZWQgb3V0LCB0aGUgc3BlY2lmaWNhdGlvbiBwZXJtaXRzIE5GUw0K
PiBzZXJ2ZXJzIHRvIHJldHVybiBORlNbMzRdRVJSX0lOVkFMIG9uIFJFQUQuIEFuZCBpbiBmYWN0
LA0KPiB0aGVyZSBpcyBhbHJlYWR5IGNvZGUgaW4gdGhlIE5GU3Y0IFJFQUQgcGF0aCB0aGF0IHJl
dHVybnMNCj4gSU5WQUwsIGZvciBleGFtcGxlOg0KPiANCj4gwqA3ODXCoMKgwqDCoMKgwqDCoMKg
IGlmIChyZWFkLT5yZF9vZmZzZXQgPj0gT0ZGU0VUX01BWCkNCj4gwqA3ODbCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmZzZXJyX2ludmFsOw0KPiANCj4gSSdtIG5vdCBz
dXJlIHRoZSBzcGVjaWZpY2F0aW9ucyBkZXNjcmliZSBwcmVjaXNlbHkgd2hlbg0KPiB0aGUgc2Vy
dmVyIC9tdXN0LyByZXR1cm4gSU5WQUwsIGJ1dCB0aGUgY2xpZW50IG5lZWRzIHRvDQo+IGJlIHBy
ZXBhcmVkIHRvIGhhbmRsZSBpdCByZWFzb25hYmx5LiBJZiBJTlZBTCByZXN1bHRzIGluDQo+IGFu
IGluZmluaXRlIGxvb3AsIHRoZW4gdGhhdCdzIGEgY2xpZW50IGJ1Zy4NCj4gDQo+IElNTyBjaGFu
Z2luZyB0aGUgYWxpZ25tZW50IGZvciB0aGF0IGNhc2UgaXMgYSBiYW5kLWFpZC4NCj4gVGhlIHVu
ZGVybHlpbmcgbG9vcGluZyBiZWhhdmlvciBpcyB3aGF0IGlzIHRoZSByb290DQo+IHByb2JsZW0u
IChTby4uLiBJIGFncmVlIHdpdGggVHJvbmQncyBOQUNLLCBidXQgZm9yDQo+IGRpZmZlcmVudCBy
ZWFzb25zKS4NCg0KSWYgSSdtIHJlYWRpbmcgRGFuJ3MgdGVzdCBjYXNlIGNvcnJlY3RseSwgdGhl
IGNsaWVudCBpcyB0cnlpbmcgdG8gcmVhZA0KYSBmdWxsIHBhZ2Ugb2YgMHgxMDAwIGJ5dGVzIHN0
YXJ0aW5nIGF0IG9mZnNldCAweDdmZmZmZmZmZmZmZmZmMDAwLg0KVGhhdCBtZWFucyB0aGUgZW5k
IG9mZnNldCBmb3IgdGhhdCByZWFkIGlzIDB4N2ZmZmZmZmZmZmZmZmYwMDAgKyAweDEwMDANCi0g
MSA9IDB4N2ZmZmZmZmZmZmZmZmZmZi4NCg0KSU9XOiBhcyBmYXIgYXMgdGhlIHNlcnZlciBpcyBj
b25jZXJuZWQsIHRoZXJlIGlzIG5vIGxvZmZfdCBvdmVyZmxvdyBvbg0KZWl0aGVyIHRoZSBzdGFy
dCBvciBlbmQgb2Zmc2V0IGFuZCBzbyB0aGVyZSBpcyBubyByZWFzb24gZm9yIGl0IHRvDQpyZXR1
cm4gTkZTNEVSUl9JTlZBTC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
