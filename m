Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E284283C7
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Oct 2021 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhJJV3p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Oct 2021 17:29:45 -0400
Received: from mail-dm6nam10on2134.outbound.protection.outlook.com ([40.107.93.134]:59361
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230364AbhJJV3o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 10 Oct 2021 17:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjERoZY37QGpOeoqdezqSCJwxX5uNC3pOlsthxrz1WmPnOKc86O1XwmdDu56nWAItKZRt0SfU6IXDB/2IitKQsYrIBZId5xTcDmuMLBwAaHjsVtI8D6h3yXFIrx4QY9Bv41HTz5Co6Lxd3eOmcwQnBbfyKU/PoMa3Wuq/mmcgc4/HnsQuRnXM2uP2XJoibaKT0EgbSQX4kN8cF41ALM68gkeaR/P/1T5glyOq6UA6Ds71ya5lzVxyk7nRTizQ8Eu3ZlobtcRrW/3Yom23+mOES5m2U95bj7KGYmXfKd17oKhoi+rhgVXMDb9BcczBdGNHlsT4mpk7xC5Lu1azLkUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTGDUPdghNEpxyUrM0fKy346xavZV+o3Cj/yrVJbarw=;
 b=PbHtdyVzhOPxuZi7MxGoteq41zz8QTEFiNB1marKlWXChP28N7jMSseFcs7I5qZOILPeiO70WuJLgbXBon2BHSetMEfFYJ7OMlFOcW+GrGSchyB8G0sx1zF5vyP2/F+EE7KdkAHGrFnIUwVB9pzFhdlkIfp4sTYKE9riUecEm9wyj9iON9ihSj97dJ8QXkRiCVE2R6gMAb6gA1ZC/tiSo5K57FS8kRuVrZg5HzsjGhOPN5Ml5edpUznaJgfVHlC+iSLM18r9PtavmJ5WccLnHFBEFlWhxi9IAYOm7IRNcgXDm6OIif20tmTM18mp0A4/T/7qCrQdh5BAyzu4TdPQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTGDUPdghNEpxyUrM0fKy346xavZV+o3Cj/yrVJbarw=;
 b=PaXiZT5vbSUzQlEYV+5N5ONRvTda9dqrTF1o57G/hTkrZv87yjD5g8CaZpyAZq/nMxZO6YY6I+Usiz+i0sUcRz9XDmV7YmxOzRIUAe8uxyJkh6AMBvMIaBGIS9tMnGAEkiw2K1Yrt9M1GCFPeyf8XG/Hrnb4TbVxLmj/+ZbTr3s=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3685.namprd13.prod.outlook.com (2603:10b6:610:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.10; Sun, 10 Oct
 2021 21:27:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4608.013; Sun, 10 Oct 2021
 21:27:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Oops in nfs_scan_commit running xfstest generic/005 with NFSv4.2
 and hammerspace flexfiles server
Thread-Topic: Oops in nfs_scan_commit running xfstest generic/005 with NFSv4.2
 and hammerspace flexfiles server
Thread-Index: AQHXvRKNIwNNPcEg7kKtVz2BtayiyKvL8XiAgABcfoCAAHMygA==
Date:   Sun, 10 Oct 2021 21:27:43 +0000
Message-ID: <caaa58479dd20674550dbb98f6f43f1b3568f671.camel@hammerspace.com>
References: <CALF+zOmahudY07tTDGcu7GFvKOOYUbboKoKk6dwhuCkGTXCUcA@mail.gmail.com>
         <4c4591fc3e0a76dda77ea7de8ac43457c25fbfbb.camel@hammerspace.com>
         <CALF+zOkcW9Rm271dSfJ-ukB991iLboXLAVRwd-AosALjqb47Vg@mail.gmail.com>
In-Reply-To: <CALF+zOkcW9Rm271dSfJ-ukB991iLboXLAVRwd-AosALjqb47Vg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9dd7bd8-768a-4c49-c78a-08d98c34cbbf
x-ms-traffictypediagnostic: CH2PR13MB3685:
x-microsoft-antispam-prvs: <CH2PR13MB3685DCE3DDB5E9E0CEC4D04CB8B49@CH2PR13MB3685.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8WKdkYrod/K+TK4KhwIwplb2yu+FB4XvgTN080HYFEgjgJGaQD1X/94GCVcMSsFwk4koSgaJnhabQO5Se6rxVO/F7nSB/0xeMjNrzJ3iVZTl6Ws5EcMUZUZmcUKjaeIAC4kLTmlpNa9K31dwlTc7lg/grtHLtm+8ACINbsO3LyOMcKVd8rynzzto/BKXpf06qbyt6NysD0w8FZzkRzgHPtX69x4AGJiSmrC1mgEqAaMv+izYHQ8+jRAYG755qNyW+oJ9ZqmKi8aNGIN5I8Bo64DePcn7i2J4/VE8Ou1HRcLn8ngGWaHpNbDRsh6kSWxL6j3Y66tkvEeMyDeEeqSLy5Fno3LYwtklibCuhaFcnTlNasE4i7Fstk7l5GHOS3ScuMPkdnGgDsDDjDwtJ/6tOXDCaaQa5Qg46ff0HcLOcgdMmNbd4hhRtegzQk1mDic+MUuI+SAgEBZx1LtcvQWEZwaMaNim6b+3BUL5nkjSNI/e24hKvbczxy7dZ/QNfGgb/LJEsi9XdqvTCdrK+Eew8c96k23jP/rKz86vfBSsngF7TdFtL9kc5Ov6HmD5oOktz9mU61hB5bAXzgKGJYuK7bgqeRpUQTV0vUxWl4ZOXGAUoAplG7LS1Xuzs1x+MtvdkY/3iSUvrVn9XZR7sgIHcfyqNBhPG0hM9+5LYtyX3MmvD5HIak+tQl3trrRKRCh3guL8PwyJsnRwPQTCatto9YVBt2DJSWEZLL8xy5lPGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(8936002)(6506007)(38070700005)(122000001)(508600001)(6486002)(83380400001)(38100700002)(4326008)(6916009)(91956017)(86362001)(36756003)(64756008)(8676002)(66476007)(66946007)(26005)(2906002)(5660300002)(66556008)(66446008)(2616005)(6512007)(186003)(76116006)(4001150100001)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWw0SzFjWkVWSlh2eitkS2ZPa3FTUEFNMTNSaWVUMWZMb0VHeFRNQktVZm9s?=
 =?utf-8?B?ZXZCS2ZhbXM0c2RJUzlRNzVjT3JlWHdVdnlkOWM3clphWndxRHBiZnRMWk1w?=
 =?utf-8?B?Y3gxd2hsWGlrdUkxRXVOTEcwaDc5WFYrWXp4aCtGMUI1WXcraytnZUViSkpa?=
 =?utf-8?B?ZzlVZk5sUkdaYXVxZk8zbnp5eFptTUdnZXdybWtFWmpxcEpmODk2a0cxTlg3?=
 =?utf-8?B?VTlYaVR6SUkwa1VPK2Q1U0Y5OUJ1YzlzSUxOazhzOW9NcUcvNjMzNEVya2Mz?=
 =?utf-8?B?TllDZkhLR2dyUUtidTRGRlgramgrcUtGYjEzbCsveU9tc3dXb2lDSFlGS1d2?=
 =?utf-8?B?Sk9YS3hQYmFUN0p3SjJ1MGVKR3k0SVNmQXlIRDlwb3UwOHZWWGFWb0w5WHFm?=
 =?utf-8?B?cU5Ib2RJRWFOcjQ3ZFlMTzJGeStGb1hPc1ZMVWxFcUpmOVphYmVLV1VrU1BQ?=
 =?utf-8?B?ZlhCcDNyd29pWnpNa1dQM0ExbCtDQVFlOGVSbkE5bWFCVldYdStCM0hHVkFn?=
 =?utf-8?B?Rm92QUFjamVERk1Zam1DOG03VkpRQ3piY3dkbmpTSWdwbXRHanZEeU9NNDZZ?=
 =?utf-8?B?L3c4Q0t1amVFN3JKSlRQOHNrczZNdXdyeXk5MEd5djZyc296UXcvcnN2YkJz?=
 =?utf-8?B?dU4rNGlsMTJyYTdtWlRtK2NmbkhxdGN6VHNEMVFvTVc3cEhvNkF6UFNneit1?=
 =?utf-8?B?ZVo5dXYxNi9iNnVUb3F5T3hGaC9aYlI0WkZMUTQzMjdsaHZBNm9YdElMSklo?=
 =?utf-8?B?VDZldmk3YTNEY2VacXJUNkpLZXN2emJ5dGFDYUJLaTlwdXlqZ2ZoRG14bUpD?=
 =?utf-8?B?QjJhTlRUVkQ2eFp2bWJVaFpmYzA2bzQ5UDlIckxkTlNGRE1sdU5kWU1hdFRi?=
 =?utf-8?B?OTA2N3V1aXdYNDF4NFZ6cUJQb1phNnJQcGU3RGIxV1RKRjVsam1ucUtjY1F0?=
 =?utf-8?B?c2V5dHFjclJGNXZKTFN3bW9GWldTY0p1NXBhMmV2YjlDUWUwRmY0RHkrcldW?=
 =?utf-8?B?TndITDFQNmk0RjRYS2pYcldiUmgraGR3UTRINlJCbyt6UGYzSk42UytFTHJ2?=
 =?utf-8?B?akNHL2w0d3dhaitwU3VsZC9JU20xV0J0UHNZaDV4VEwwWGNFM3M4alBFMGIx?=
 =?utf-8?B?aTJmMUpIZmEvY3V4eUF4c2FPQmhxUjFoYnVtd3VCM3FZN2hsdWxkc2RmVTBw?=
 =?utf-8?B?ZXViNWM4NnMyS3Z3QmNtL2NPT0ZxU3lyMHBqamFyLzI5bVJ2NlphQmFqT0tr?=
 =?utf-8?B?QlZIamtjM1hmcWxYYWQ4dTY1M0Zjc2c1VzlSaFVNaHhUNUgySFBCckZhM1B1?=
 =?utf-8?B?cURFUVhOdVFCZE5WK1ZjUmJrcHYrdEVNbnVBQkk5SlBzQ0NMcEJZemQ1ak81?=
 =?utf-8?B?SXN3UXZad0ZjY09vTkN2Z2RaN1RaalRKTndIOEVET0h6YkJUREExVVZrODJx?=
 =?utf-8?B?VnpkdjFCNlI4OGRyVWV6YXdNREE4OTJEeHJnR0FVbURUSWpHUXhGY2RkaG1S?=
 =?utf-8?B?K3dWalJoQ3VPMTZZQWVScFNnZmMyNUFHYUJSUVV2bmpKVzVsOTRwREtSYzVx?=
 =?utf-8?B?L2ZMY3JpaENqbmVkalRBYTZKV3crbGYvU0JCTU02WUZTd2hrSDRhWmJtQXFH?=
 =?utf-8?B?SU4vTGNoYURhbWdpeWhVVXpZelFjWHUzS0lyMXBWRDd1eVg5WjNFbXJUdXZM?=
 =?utf-8?B?SWczdytscjdBU0FSV0I5UHVvelI5NjVpU1RFUWk2NDQwYWxpYVd2N2dwK0k3?=
 =?utf-8?B?U1hENjZ6ejdSNVpvNEpYSFB6Q25HOXMrbkFOWVBmempIZmNYenZCVVh2bEhY?=
 =?utf-8?B?SmxYa3ZFOUQwQWNPUU4zQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E89CBE8A0E0BCF4C8FE10E08B706EB05@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd7bd8-768a-4c49-c78a-08d98c34cbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2021 21:27:43.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuskuVZdXDEOqz7BcSF6EgpZoki2lKRalxp4dmyGtR4qFZ7Y74TEbeiYxpKw3byGa8dU+5355Fn6vRhmYvwDNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3685
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEwLTEwIGF0IDEwOjM1IC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gTm93IEkgZ2V0IHRoZSBiZWxvdyBXQVJOX09OIHBvcCB0aG91Z2ggaW5kaWNhdGluZw0K
PiBuZnNfaGF2ZV93cml0ZWJhY2tzKCkgaXMgdHJ1ZSB3aGVuIGluc2lkZSBuZnNfY2xlYXJfaW5v
ZGUoKSBhbmQgSQ0KPiB0aGluayBJIHNhdyB0aGlzIG9uY2UgYmVmb3JlLg0KPiBJIHRoaW5rIHdl
IG5lZWQgc29tZSBzaW1wbGUgZml4dXAgdG8gbmZzX2hhdmVfd3JpdGViYWNrcygpIGR1ZSB0byB0
aGUNCj4gdW5pb24taXphdGlvbiBpbiB5b3VyIHBhdGNoOg0KPiBjb21taXQgYjcxMmUxMWI5OWVh
ZGJhNWI0MDAzZGQ4MTVhZGIzNjg4MzVmYjVkNQ0KPiBBdXRob3I6IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gRGF0ZTrCoMKgIFR1ZSBTZXAgMjgg
MTc6NDE6NDEgMjAyMSAtMDQwMA0KPiANCj4gwqDCoMKgIE5GUzogU2F2ZSBzb21lIHNwYWNlIGlu
IHRoZSBpbm9kZQ0KPiANCj4gwqDCoMKgIFNhdmUgc29tZSBzcGFjZSBpbiB0aGUgbmZzX2lub2Rl
IGJ5IHNldHRpbmcgdXAgYW4gYW5vbnltb3VzIHVuaW9uDQo+IHdpdGgNCj4gwqDCoMKgIHRoZSBm
aWVsZHMgdGhhdCBhcmUgcGVjdWxpYXIgdG8gYSBzcGVjaWZpYyB0eXBlIG9mIGZpbGVzeXN0ZW0N
Cj4gb2JqZWN0Lg0KPiANCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gDQo+IA0KPiBZb3UgbWF5IHdhbnQg
dG8gZm9sZCBzb21ldGhpbmcgbGlrZSB0aGlzIGludG8gdGhlIGFib3ZlIHdoaWNoIGZpeGVzDQo+
IHRoZSBXQVJOIGZvciBtZToNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX2ZzLmgg
Yi9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+IGluZGV4IGE1YWVmMmNiZTRlZS4uNWExMTBlY2Yy
ZDg1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvbmZzX2ZzLmgNCj4gQEAgLTU3OSw3ICs1NzksOSBAQCBleHRlcm4gaW50IG5mc19h
Y2Nlc3NfZ2V0X2NhY2hlZChzdHJ1Y3QgaW5vZGUNCj4gKmlub2RlLCBjb25zdCBzdHJ1Y3QgY3Jl
ZCAqY3JlZCwgcw0KPiDCoHN0YXRpYyBpbmxpbmUgaW50DQo+IMKgbmZzX2hhdmVfd3JpdGViYWNr
cyhzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiDCoHsNCj4gLcKgwqDCoMKgwqDCoCByZXR1cm4gYXRv
bWljX2xvbmdfcmVhZCgmTkZTX0koaW5vZGUpLT5ucmVxdWVzdHMpICE9IDA7DQo+ICvCoMKgwqDC
oMKgwqAgaWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBhdG9taWNfbG9uZ19yZWFkKCZORlNfSShpbm9kZSktPm5yZXF1ZXN0
cykgIT0NCj4gMDsNCj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gwqB9DQo+IA0KDQoNClRo
YW5rcyBhZ2FpbiBmb3IgdGVzdGluZyBhbmQgZm9yIHRoZSBidWcgcmVwb3J0cywgRGF2ZSEgQ2Fu
IHlvdSBwbGVhc2UNCnJlc2VuZCB0aGUgYWJvdmUgcGF0Y2ggd2l0aCBhIHNpZ25lZC1vZmYtYnkg
bGluZT8gSSdsbCBiZSBoYXBweSB0bw0KYXBwbHkgaXQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
