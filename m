Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB41545C95C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhKXQDD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 11:03:03 -0500
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:36448
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347615AbhKXQDC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgMFmdK9E3eZWRyx/Wnd0Nakrqz8xTwjPpXsA5rip/Mh2dgAEXUX8z1jrQ5MBXMYsFX7mm+3HNRncgLzJt76ck2r3wYfRv+rHdZcSk84tZV3mJ/NCkFuyNkkfOfPDLVBgjJujTBLf80Jz1OZ7WnxL18WC6Y9CRKUu4R6UdmRtEIvK8w/oXJbmn4cjSo2bCjtDbyvnL1amR1+C4yU20c/YgnF/30ML+Ycd0XAUCBYRnvKrKZ/uDWq3Q3N+Gq0DqrtqSRVDwFPHVzSrrHyiHgtHfAhRPUtA0efXekDfve8vAkhnlCxFNvaZIgRUNs+O5+Nx9VWnYP/SWHvEkkGuzF6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb/uiqWuVB9nzGwu8vAno7kwdKiMm0kIZCfvrcl1HPQ=;
 b=HO/PTEcqjz9/g26POMMABlERGDnXy7rWpMW0pfdT3l9XilliQDA0gslb7dFeNJEoZy3qJD5HB82ApNJXJ2WJ0xUkzrE0CuZYqq6WVWd7NeDGxV+2V1YIkWHeXCeZ4BgMm+++S0kTBA5wCIkIRaS+FkdLVa6jJb+8pDH3Jo/X9FRhkEzwrdfTiaMvWZtnRc8Hw5u0wfzDkclXkSKzFYPuu9tLHDfAcglZluuyGWbe3guCeT0tTXj+deHPx14lziu8v3LFh0AqQniNS3wagohsjDSpcwvPlbptLHfsVYWv1LoK5/1fHCd7nNjsf2Y+dOKI81HTE/myzpYdkOQBUR+HcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb/uiqWuVB9nzGwu8vAno7kwdKiMm0kIZCfvrcl1HPQ=;
 b=aIzF9A83nuLHR0NRci6sFTWvGPGvgcaExVwqEhr7ioYZsYI3s310V+vj+r6PykH9BAtuY3WkYyoq9/5Ecwq3zA/+YOcrTzuaZjJUG6wP+NZWSfgIqQmJ61OsVEAboooJA6i+qkLNkEtVy8eulUuKKal7XLqUk4vy7mjvQAq8sts=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4444.namprd13.prod.outlook.com (2603:10b6:610:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7; Wed, 24 Nov
 2021 15:59:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 15:59:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Topic: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Index: AQHWn6R0BWW7FfEHY0ewFe9+CvNb36mUB/AAgAAVOICAAA6DgIAI+hOAgitf9YCAST4LAIAAZRgAgAMoGoCAAAhggA==
Date:   Wed, 24 Nov 2021 15:59:47 +0000
Message-ID: <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
References: <20201011075913.GA8065@eldamar.lan>
         <20201012142602.GD26571@fieldses.org> <20201012154159.GA49819@eldamar.lan>
         <20201012163355.GF26571@fieldses.org> <20201018093903.GA364695@eldamar.lan>
         <YV3vDQOPVgxc/J99@eldamar.lan>
         <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
         <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
         <20211124152947.GA30602@fieldses.org>
In-Reply-To: <20211124152947.GA30602@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84409464-334b-42f7-cfe4-08d9af6370a0
x-ms-traffictypediagnostic: CH2PR13MB4444:
x-microsoft-antispam-prvs: <CH2PR13MB4444E51528615211B35AB8E3B8619@CH2PR13MB4444.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gLYWd+HgAqYD8iAMEM1Zjs+d+rwP9ULmL7C6GyuYx1u2a0JQ4rYCwX7HZ0/huj3hF5RsMdO/MCtQa/jdoMbzil7HXAvXIIog57PbtlT7gLO+4YJ6+Z2e5Qwi/lvHqtRElkvQXauJ2ldq9HDTsUaLvP1aLLeWnff2rbjre/UnbNpC5v1gjCnQy3sj4WWoa8sHGcpPUaHupOOzpWCt7k2HadiOQFh/Qknxad8cGsJv1Yv1N5on4zj3BumVWtuY0D7Zj/rUnG3cSHBINKMzxy+UmBxVRs3PKJr05Wq5VMkNdciyBYcGk0o/oOeZRiha1pnta1J63nJztLCq2JJnM4XJPt5UJri/kG65vipZI6G3S+bryRb7lfl2YBDU1sdcqdxfwEUw31lMKf1k2TEiB6r8/7Ndb+V44EFTQLrb/c+3lKWIDnKg8oj0zxOET1ABUvOJ9cLfElK8KB52mKLjEKxzFicuhLTgcTXJgUpotfEUmpZNFw+m1bqwIQwPcIpBZJ6JKF/dIZtK4TqGl9WmLJzrjvz84hqhif3657TWhMvnGIQ2bwufzi+OrVfgEi66YeEqfIqaTrpJqwTlUxI+DLsxZbVpiHw4wb3Rg3BiPkLh8G5zauVLqJpnNe0iTduFmSDbnzGSTvDPRB8gFFd7fUuzyN+tNYq0e43mYyszjsvebe4smjs2Oj/Ah2wd09EoPsCJyePFgiLIVOUZ0UYturga8W8ul1XmYatSiG1pyoXb10cFqbnDl/e4znZJoVjd9v/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(396003)(376002)(366004)(6512007)(2906002)(110136005)(508600001)(8936002)(83380400001)(4326008)(5660300002)(36756003)(2616005)(76116006)(38070700005)(4001150100001)(66446008)(316002)(54906003)(122000001)(26005)(186003)(66946007)(64756008)(66556008)(8676002)(66476007)(86362001)(966005)(6486002)(71200400001)(6506007)(53546011)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmdESEpwWm92RUtnbTVNRkUvSWhRc0tzREpwT2E2c1lubFVML2p3TUJKb1dN?=
 =?utf-8?B?cVZVUkp6T1pUZWxQeFMxMm5YTzhTZEVlek9PdE9DRmZtSStHNzQ5U3ZONGRI?=
 =?utf-8?B?YlgxZkxGaWJDS3VGNWVmQk4wd0dSOVAwbmh3aHFVeFZvanQyQzNHNCt3WUpu?=
 =?utf-8?B?V0Faa28wSmt0NW5TTE9LME5JNFY0ek4wWDhpK3FuMkNsa3IydkVldERoaUIy?=
 =?utf-8?B?dVJqM2srRm1LTjZ1dExNbW1jNUFiMGlkSkNtQjlraXV2N1krK3cvNTFZNlRW?=
 =?utf-8?B?cXVFN1Mzc0JRUi9ScUlPd3NTQnM1Wk9XWlFQZlM0VG4rRVRCSldabTk3eW1B?=
 =?utf-8?B?cktPMG11d2Q5WnEvTzhZMGtPREJKMEFsUHBoZG9DdGl2ZFZPdlJ0V05LcmRJ?=
 =?utf-8?B?QWZqOTVLbnRLVGRDNXdFMjMveHV2NHZhT3dXZlBHQ3QvekYzMURjYjF2VHhs?=
 =?utf-8?B?bmE1S1ZLeG9ra3hrSjBzU2cxYlFVY05xdmZ2WXRPeVJVaDNWOU9acXZmb3NI?=
 =?utf-8?B?SFh2S3ZlK25seEVodVJlWUxieWIzeWpHYnI3MXl0SXJhQXZOSEpFeGhPZGQz?=
 =?utf-8?B?R0hBalFqWkhUSFZhVHBRL3hDQnNKV0pReHRLZVFlRmdIZjdPSHNaWHRYditn?=
 =?utf-8?B?ekxnbzc4emtTY0VDVWZBa3hvTTlTOWIwZXgzWUFrSU5CN2RBanNZRWxyM3VH?=
 =?utf-8?B?bTZ1Y2hic3pmK0RhOU9RU2h0L01Nczg0ak1yUEJRNXNaN1VIclgxMUF6WkRC?=
 =?utf-8?B?Wm4wMEJ4TkVlT1hXOFBIUHRiMDJneDkvaWtyekExQmJYTjNNbUNWeDJoWDlx?=
 =?utf-8?B?dnh6dEgyUXYrS255VCtQeG5ONFpUeFAzWDNLZ2w4MjREeFUvbTkzSmJlTkZJ?=
 =?utf-8?B?T3RKbTFvcERBQkNjeWZpdlFmTXpoWmlGOGlkbDgxUklJcFBBa0FqQTEzTHdM?=
 =?utf-8?B?WnMwNTFTRTBBVGlJY0t4Zy9VMGR3T1hNOWJ2b2krQTJQSEdJU2N3Q2x3cEZN?=
 =?utf-8?B?UW1tRWhIQzZ3KzZjZHhIUWRWZzJkei95Y2N3Qm1RQUhiZFBOdkpWUGtEbnhO?=
 =?utf-8?B?SmR1b1FwQ0xTQ2w4cHdPZVdadGNPVTVGL2FaRWtXOHIzbW9qVWJHM2xMUGw1?=
 =?utf-8?B?UWxiQ3VzUys5U2p3OW9tR1ViKzZ4U2JVY1ZSNm0vMWw3WjV1MCtYdUlvTGpU?=
 =?utf-8?B?SDQrREdCUW9XMWdXSERGT0R3a3FwRjcwYlovVTRCcWFyYTJrS3BlaE0yVkVl?=
 =?utf-8?B?MmdRT1MxY3BDV2tidDlSKzgvWDVGZUp4Qnh5RUpKc3NWbzltejZpcnVRWWQy?=
 =?utf-8?B?MStGNkV4ay85Q0dhelMwa1p1Y09lOFVzZHJyTHlLQ1RIUUIvVFFLd2s1bVJX?=
 =?utf-8?B?UURxc044V1ZPbE9pVnhmRktWc0I2VVkrS1gwVThOZTMyM2gzVHNEeUJ2bysz?=
 =?utf-8?B?bDI5U283alJOWEdiSWhzdjNtU3o2LzJrN1hRLy9MYnZMR3dPR21OWXoyNzlO?=
 =?utf-8?B?TmoxUkx2bzJ1MENwdUQ5dC93Qkd2RGVtS0JUSmVKbkxSaE1ibngwckZzbWFS?=
 =?utf-8?B?OHhpMHpDMUFiaGtOejJRa3EvS3dwRUtkYXkyQURacFRWcnNFMkFUaVZ1NGkz?=
 =?utf-8?B?OWFUd0NHbVZGVURXSW1kZ1ZhUWlWbmxQaXFDbFgxaUE4MFNPbUI0eUY2Tzl6?=
 =?utf-8?B?N3RFaFNLMHQ2MDhZVy9KWHpWUkprL3d5MTdWelpLY3l0ZFlHRERYZjcvSFlL?=
 =?utf-8?B?V0g3OW1DekNrRWtHRFRSdTl2ZUFaNkg3SWxHaDNIQ1l6VW41ZUFaS21JWG1M?=
 =?utf-8?B?eUxrOGdxakhsb2xqakRIcmNXcW5pMkV3ZEdTZHpDTi9yNGhiV0poM0hsbDRk?=
 =?utf-8?B?LzlxcXNLeEhDc1FIVVVZYmpvSVQyNlFrK3drZldpNEhscExtSldiS29NWExl?=
 =?utf-8?B?aDhZRW13elE3Wm1tWXdlY0ZmWE1pQW1MYjZYa0JHRndXUzR3OWVRZU1EWXA0?=
 =?utf-8?B?QTV3RDcySVlQTS9hNDJ4ODRsQXcxWTZDOVhZVktiOEJLcHErWHRFcDAwT1Q3?=
 =?utf-8?B?bmFhRUlhMjQvdnhlTm1oY3phdGtKQmFNN3c0L1lDdnk2T0VnWWFVZXhzbmFH?=
 =?utf-8?B?U2VZSGZMcnpYelFscE1KMXZPMnRnRzhhc1REb1lBZk5OTWd6dDBaVGo5VFg5?=
 =?utf-8?Q?QlOJ9RwK1OGUjDncLkJzEtI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED036F04926644EB79A02C76B70C25A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84409464-334b-42f7-cfe4-08d9af6370a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 15:59:47.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cSKEfsFUBT9SK1HpkG9bp9aS4Sru0DYQd8BSy8TLhENUVkNSOAFgGs/7fHV7Z0v0t9mNyb6cr2uE5Y2Fd5cwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4444
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTI0IGF0IDEwOjI5IC0wNTAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIE1vbiwgTm92IDIyLCAyMDIxIGF0IDAzOjE3OjI4UE0gKzAwMDAsIENodWNrIExldmVyIElJ
SSB3cm90ZToNCj4gPiANCj4gPiANCj4gPiA+IE9uIE5vdiAyMiwgMjAyMSwgYXQgNDoxNSBBTSwg
T2xpdmllciBNb25hY28NCj4gPiA+IDxvbGl2aWVyQGJtLXNlcnZpY2VzLmNvbT4gd3JvdGU6DQo+
ID4gPiANCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIG15IHByb2JsZW0gaXMgcmVs
YXRlZCB0byB0aGlzIHRocmVhZC4NCj4gPiA+IA0KPiA+ID4gV2UgYXJlIHJ1bm5pbmcgYSBWTXdh
cmUgdkNlbnRlciBwbGF0Zm9ybSBydW5uaW5nIDkgZ3JvdXBzIG9mDQo+ID4gPiB2aXJ0dWFsIG1h
Y2hpbmVzLiBFYWNoIGdyb3VwIGluY2x1ZGVzIGEgVk0gd2l0aCBORlMgZm9yIGZpbGUNCj4gPiA+
IHNoYXJpbmcgYW5kIDMgVk1zIHdpdGggTkZTIGNsaWVudHMsIHNvIHdlIGFyZSBydW5uaW5nIDkN
Cj4gPiA+IGluZGVwZW5kZW50IGZpbGUgc2VydmVycy4NCj4gPiANCj4gPiBJJ3ZlIG9wZW5lZCBo
dHRwczovL2J1Z3ppbGxhLmxpbnV4LW5mcy5vcmcvc2hvd19idWcuY2dpP2lkPTM3MQ0KPiA+IA0K
PiA+IEp1c3QgYSByYW5kb20gdGhvdWdodDogd291bGQgZW5hYmxpbmcgS0FTQU4gc2hlZCBzb21l
IGxpZ2h0Pw0KPiANCj4gSW4gZmFjdCwgd2UndmUgZ290dGVuIHJlcG9ydHMgZnJvbSBSZWRoYXQg
UUUgb2YgYSBLQVNBTiB1c2UtYWZ0ZXItDQo+IGZyZWUNCj4gd2FybmluZyBpbiB0aGUgbGF1bmRy
b21hdCB0aHJlYWQsIHdoaWNoIEkgdGhpbmsgbWlnaHQgYmUgdGhlIHNhbWUNCj4gYnVnLg0KPiBX
ZSd2ZSBiZWVuIGdldHRpbmcgb2NjYXNpb25hbCByZXBvcnRzIG9mIHByb2JsZW1zIGhlcmUgZm9y
IGEgbG9uZw0KPiB0aW1lLA0KPiBidXQgdGhleSd2ZSBiZWVuIHZlcnkgaGFyZCB0byByZXByb2R1
Y2UuDQo+IA0KPiBBZnRlciBmb29saW5nIHdpdGggdGhlaXIgcmVwcm9kdWNlciwgSSB0aGluayBJ
IGZpbmFsbHkgaGF2ZSBpdC4NCj4gRW1iYXJyYXNpbmdseSwgaXQncyBub3RoaW5nIHRoYXQgY29t
cGxpY2F0ZWQuwqAgWW91IGNhbiBtYWtlIGl0IG11Y2gNCj4gZWFzaWVyIHRvIHJlcHJvZHVjZSBi
eSBhZGRpbmcgYW4gbXNsZWVwIGNhbGwgYWZ0ZXIgdGhlIHZmc19zZXRsZWFzZQ0KPiBpbg0KPiBu
ZnM0X3NldF9kZWxlZ2F0aW9uLg0KPiANCj4gSWYgaXQncyBwb3NzaWJsZSB0byBydW4gYSBwYXRj
aGVkIGtlcm5lbCBpbiBwcm9kdWN0aW9uLCB5b3UgY291bGQgdHJ5DQo+IHRoZSBmb2xsb3dpbmcs
IGFuZCBJJ2QgZGVmaW5pdGVseSBiZSBpbnRlcmVzdGVkIGluIGFueSByZXN1bHRzLg0KPiANCj4g
T3RoZXJ3aXNlLCB5b3UgY2FuIHByb2JhYmx5IHdvcmsgYXJvdW5kIHRoZSBwcm9ibGVtIGJ5IGRp
c2FibGluZw0KPiBkZWxlZ2F0aW9ucy7CoCBTb21ldGhpbmcgbGlrZQ0KPiANCj4gwqDCoMKgwqDC
oMKgwqDCoHN1ZG8gZWNobyAiZnMubGVhc2VzLWVuYWJsZSA9IDAiID4vZXRjL3N5c2N0bC5kL25m
c2QtDQo+IHdvcmthcm91bmQuY29uZg0KPiANCj4gc2hvdWxkIGRvIGl0Lg0KPiANCj4gTm90IHN1
cmUgaWYgdGhpcyBmaXggaXMgYmVzdCBvciBpZiB0aGVyZSdzIHNvbWV0aGluZyBzaW1wbGVyLg0K
PiANCj4gLS1iLg0KPiANCj4gY29tbWl0IDZkZTUxMjM3NTg5ZQ0KPiBBdXRob3I6IEouIEJydWNl
IEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiBEYXRlOsKgwqAgVHVlIE5vdiAyMyAyMjoz
MTowNCAyMDIxIC0wNTAwDQo+IA0KPiDCoMKgwqAgbmZzZDogZml4IHVzZS1hZnRlci1mcmVlIGR1
ZSB0byBkZWxlZ2F0aW9uIHJhY2UNCj4gwqDCoMKgIA0KPiDCoMKgwqAgQSBkZWxlZ2F0aW9uIGJy
ZWFrIGNvdWxkIGFycml2ZSBhcyBzb29uIGFzIHdlJ3ZlIGNhbGxlZA0KPiB2ZnNfc2V0bGVhc2Uu
wqAgQQ0KPiDCoMKgwqAgZGVsZWdhdGlvbiBicmVhayBydW5zIGEgY2FsbGJhY2sgd2hpY2ggaW1t
ZWRpYXRlbHkgKGluDQo+IMKgwqDCoCBuZnNkNF9jYl9yZWNhbGxfcHJlcGFyZSkgYWRkcyB0aGUg
ZGVsZWdhdGlvbiB0byBkZWxfcmVjYWxsX2xydS7CoA0KPiBJZiB3ZQ0KPiDCoMKgwqAgdGhlbiBl
eGl0IG5mczRfc2V0X2RlbGVnYXRpb24gd2l0aG91dCBoYXNoaW5nIHRoZSBkZWxlZ2F0aW9uLCBp
dA0KPiB3aWxsIGJlDQo+IMKgwqDCoCBmcmVlZCBhcyBzb29uIGFzIHRoZSBjYWxsYmFjayBpcyBk
b25lIHdpdGggaXQsIHdpdGhvdXQgZXZlciBiZWluZw0KPiDCoMKgwqAgcmVtb3ZlZCBmcm9tIGRl
bF9yZWNhbGxfbHJ1Lg0KPiDCoMKgwqAgDQo+IMKgwqDCoCBTeW1wdG9tcyBzaG93IHVwIGxhdGVy
IGFzIHVzZS1hZnRlci1mcmVlIG9yIGxpc3QgY29ycnVwdGlvbg0KPiB3YXJuaW5ncywNCj4gwqDC
oMKgIHVzdWFsbHkgaW4gdGhlIGxhdW5kcm9tYXQgdGhyZWFkLg0KPiDCoMKgwqAgDQo+IMKgwqDC
oCBTaWduZWQtb2ZmLWJ5OiBKLiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAcmVkaGF0LmNvbT4NCj4g
DQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUu
Yw0KPiBpbmRleCBiZmFkOTRjNzBiODQuLjhlMDYzZjQ5MjQwYiAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzZC9uZnM0c3RhdGUuYw0KPiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+IEBAIC01MTU5
LDE1ICs1MTU5LDE2IEBAIG5mczRfc2V0X2RlbGVnYXRpb24oc3RydWN0IG5mczRfY2xpZW50ICpj
bHAsDQo+IHN0cnVjdCBzdmNfZmggKmZoLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGxvY2tzX2ZyZWVfbG9jayhmbCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc3RhdHVzKQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2NsbnRfb2RzdGF0ZTsN
Cj4gKw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gbmZzZDRfY2hlY2tfY29uZmxpY3Rpbmdf
b3BlbnMoY2xwLCBmcCk7DQo+IC3CoMKgwqDCoMKgwqDCoGlmIChzdGF0dXMpDQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF91bmxvY2s7DQo+IMKgDQo+IMKgwqDCoMKg
wqDCoMKgwqBzcGluX2xvY2soJnN0YXRlX2xvY2spOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9s
b2NrKCZmcC0+ZmlfbG9jayk7DQo+IC3CoMKgwqDCoMKgwqDCoGlmIChmcC0+ZmlfaGFkX2NvbmZs
aWN0KQ0KPiArwqDCoMKgwqDCoMKgwqBpZiAoc3RhdHVzIHx8IGZwLT5maV9oYWRfY29uZmxpY3Qp
IHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsX2luaXQoJmRwLT5k
bF9yZWNhbGxfbHJ1KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRwLT5kbF90
aW1lKys7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gLUVBR0FJ
TjsNCj4gLcKgwqDCoMKgwqDCoMKgZWxzZQ0KPiArwqDCoMKgwqDCoMKgwqB9IGVsc2UNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBoYXNoX2RlbGVnYXRpb25fbG9j
a2VkKGRwLCBmcCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmZnAtPmZpX2xvY2sp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJnN0YXRlX2xvY2spOw0KDQpXaHkgd29u
J3QgdGhpcyBsZWFrIGEgcmVmZXJlbmNlIHRvIHRoZSBzdGlkPyBBZmFpY3MNCm5mc2RfYnJlYWtf
b25lX2RlbGVnKCkgZG9lcyB0YWtlIGEgcmVmZXJlbmNlIGJlZm9yZSBsYXVuY2hpbmcgdGhlDQpj
YWxsYmFjayBkYWVtb24sIGFuZCB0aGF0IHJlZmVyZW5jZSBpcyByZWxlYXNlZCB3aGVuIHRoZSBk
ZWxlZ2F0aW9uIGlzDQpsYXRlciBwcm9jZXNzZWQgYnkgdGhlIGxhdW5kcm9tYXQuDQoNCkhtbS4u
LiBJc24ndCB0aGUgcmVhbCBidWcgaGVyZSByYXRoZXIgdGhhdCB0aGUgbGF1bmRyb21hdCBpcyBj
b3JydXB0aW5nDQpib3RoIHRoZSBubi0+Y2xpZW50X2xydSBhbmQgbm4tPmRlbF9yZWNhbGxfbHJ1
IGxpc3RzIGJlY2F1c2UgaXQgaXMNCnVzaW5nIGxpc3RfYWRkKCkgaW5zdGVhZCBvZiBsaXN0X21v
dmUoKSB3aGVuIGFkZGluZyB0aGVzZSBvYmplY3RzIHRvDQp0aGUgcmVhcGxpc3Q/DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
