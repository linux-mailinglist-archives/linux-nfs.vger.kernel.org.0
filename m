Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E934141CD75
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbhI2UhR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 16:37:17 -0400
Received: from mail-co1nam11on2099.outbound.protection.outlook.com ([40.107.220.99]:13921
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346753AbhI2UhL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 16:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klEjw4Zbq6SfwCKL8cqhrFYnonkrsBxzvcs3WxebAGyOAaSDZ3ELGO2dJLrhG8zB+1oSA2rjO4eVeat294Zx2TGlumhe8Yo6ZONJDskW9d6lZKsVTxFAQlOkx0RV4+/aVL4cs+zZz46e2wxggLpN+4fOO6D4BjCPH5GA1V6uU1j81fChR8uEQSxGp7dQnXa09sPueEPp0Yjq2bhHGaW4URbqivubNG5zX5RVthRaOtr54ui9yV5br2hHyWqL/36HbKmuZ2JdBQcNIytB+/mneNLhe/cKplwREXPToQ8PcblglfmgAz/OAipqeOMf4dLtKYY80S/bYFywG1NMDAcIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBaa5BBsIxLQiWNiQwtV2yberY6T+G2UAG69D4Z2+xs=;
 b=Q0utrksNGt9gWz2y9f/LIPIb+S7v5ZsU3Mtw3FQNzJ67Rcdqn25C4Ef/xBD1QBXxBjLUZ+4zIkeRWgqCR8eoKoldczbtQL5HVk9P67CZ0p80J16+3UvMA7gbYcWEUmt9Dm2b5u934Oc4YgWNJOVShh66wZmafeRyC3TFKHYv8+F5KTkSjPoQALjIuEGu/359GxC6gkJG3v9tqgu21Qf8KhiqUkcFDq9ZsXJMOeNJx3S6j5AkT6lrYm2rO0bHotFPCRl1or2jclkw8GXOlbWkz2AiLN7025nc6b9MkjU1Q952VNlE5IKI93CJ3y+LXIej9/8lix2v23Z2zW5KNRX7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBaa5BBsIxLQiWNiQwtV2yberY6T+G2UAG69D4Z2+xs=;
 b=Wx+PfypiJ0fG0+ZpUCzukJAOsPJfdLm5hXtwR7004IUrnzKevrN4+wM1BhCVn7EkrSGGORxSU4i0jcfW4flyszy5IiU8gdknBYf0Pugv9Qefc9Hq3+N/TQj062cvPLG3ucFPuXXHdS7tkeh575nlrJegL4/L8EoxFE/XBHTusow=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4762.namprd13.prod.outlook.com (2603:10b6:610:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7; Wed, 29 Sep
 2021 20:35:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 20:35:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Topic: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Index: AQHXtTjgd3gxxmyKIUOhzT+omYBuM6u7GfkAgAAYUICAAEJpgIAAA+yA
Date:   Wed, 29 Sep 2021 20:35:26 +0000
Message-ID: <558be6c89090b38cc9b679a0893649c5067cff14.camel@hammerspace.com>
References: <20210929134944.632844-1-trondmy@kernel.org>
         <20210929134944.632844-2-trondmy@kernel.org>
         <20210929134944.632844-3-trondmy@kernel.org>
         <20210929134944.632844-4-trondmy@kernel.org>
         <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
         <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
         <F6D17359-3190-4A67-9DF7-08BCE61BE075@redhat.com>
In-Reply-To: <F6D17359-3190-4A67-9DF7-08BCE61BE075@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a5a4827-f6a8-4bf8-46f8-08d98388ab48
x-ms-traffictypediagnostic: CH0PR13MB4762:
x-microsoft-antispam-prvs: <CH0PR13MB47629E5D383369D03E30DDDFB8A99@CH0PR13MB4762.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ABVFjtbBfJaklmX2UkFTuInxh9oPebpE2ncmgBnu15UDbhvenCEAOfUDFtbg/ykpX8+Pc3aGjhek4aWLlwdNLb0h2HwhhiQGo8Er5YrdolBMYXc20pYnPcAfLw4FORyESP9vFH0UnwnXx3Cfg7kwi/kWGs+45cLFFXryTAs6a1ooH85I6O1t3faaotFt8O6ldS4F+35cetHMhCQpI3kRqwthL1go/wAbdz3wdSBkEMy8kI/uUmoo91MT20h8mZ6U/zwSXmCvx71C8VlqpmSSFoslFgf38R8gTl5dhjgQRJsiF+Ee9EwIjOfD6uAdO62HQ7X3t8tOQe2owH/LsKxv9Q3iyQds/2itYyE/6OM7O/qo+I3yREjmZjvUu+veci61Z+3pTtxKOa+oA0p1cigF/lfOadGF/+aqwzYUbVzAC1wbQTnJidHIfKS67i/Nn9k9854IZYtFIUOagOGQuDaGi7E4t2s7SvGV4tIM8QXCTyTB5+ftjWPPA/mh8JXFiuhtPWnspMQ1HWDuuJh8UtckuZVJPh9WpOYsZOTrdwALarEsSCNgV3WqlqDKNmKNWXk0v/85FsCPspEnMVqsk8+X+cHKzyA8S3tEJg+Ks6VTtTwqdRPl758GJ0zHeFi8WdVfYG9hrBktGLBoBYHUYdnmrPUipz9cRpUw4FsaHhJP7/RgvkYeU9PjG48xzkGmoqLnGQ4tTOgR3l9gs41qRw0alw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(6486002)(316002)(4326008)(86362001)(26005)(186003)(53546011)(6512007)(6506007)(64756008)(66556008)(76116006)(2906002)(5660300002)(2616005)(66446008)(6916009)(36756003)(71200400001)(508600001)(66476007)(66946007)(122000001)(38100700002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkt6cllZNlFkeXkxeG8yR0x5NHgra0UxU1BTdUU0RGFJNjhKWFpxRnM3OEU2?=
 =?utf-8?B?TXdZY2V4bkx5UHFwaCs3VElzRkYzTFVyNmdlbTJnT3VIL3V5blI0U1BOa3JI?=
 =?utf-8?B?YmJYTmpFVk5QekhLZlZlZmdrZUg1a1lPd2x1aTgxUTZZTmcyWkhtQ1NwSkJr?=
 =?utf-8?B?VGpnS1IwaXNBVi9neUFlV3VpdFB6b3YyRU8vSzNqZEUwU2NLb2tTWG9PcmxJ?=
 =?utf-8?B?WU1QQUJWdjlkQld1VnkxZVRsMDZUWjY4OWUvL3ZPaFE2VUxnQysvU1lrbDMw?=
 =?utf-8?B?NnExdDZmejhyOTZ2VVhQQXRvYUhROXAvVzVSdTJKR3NncW1zRE1RNG96dStD?=
 =?utf-8?B?Wk9QaDVqN1FEaUgyNUpwRnpGL1dKek9yVlF6WTk4aWpKeGplb3R0SmdMQm1K?=
 =?utf-8?B?V2NySEF6VlVJYzQyYjEzbjZsYTZlRGdDbE9sTU9hTmJMSGJmc2h5UjFjMksz?=
 =?utf-8?B?UUM1ZVBMUnRPWG4rcERMSCsvbmQwWDZYcEhKMHpIUFI3akdsdkltR3RyUzl2?=
 =?utf-8?B?ZVFjQTBTeVhlSTJaL2pFK3l0VzZ5UzZFTWdrU1YvSFFkN3lzK0w0c29EMlFW?=
 =?utf-8?B?dnhHL1h6MmkyMmF1NDcwUDFCbjJ4V2FvV0lXdWFpQzdHMGEwcWRJOTVSZkps?=
 =?utf-8?B?R0xZUGQ1RU1IK0hkTkNtNUphdHJ0N2s3N1VUMHVXRjNRMWxKbk92ZHMrQjVm?=
 =?utf-8?B?eDYrQW9PNTJzdUxMNkx6SVNySVYrSUpUak1DMExjZE1ZL29WKzNyTnNLOTkz?=
 =?utf-8?B?KzI3Nyt3MnIyRlN0YWU4SGlUM0lxaElFUTJobmx6eVdZY3lSTWU2b0lvbHhz?=
 =?utf-8?B?cFNyTmNWRUNzWCtObE1lYWVFYnRMV01ZdmtBZnYrcEl5eU1OcGpHdUdadmxh?=
 =?utf-8?B?NnZvdXQvWGRQbDMwWW1HYnJvMDJ4NXdpWXV5TlRsNXM0ZHpuQlZ1VnpHU1N2?=
 =?utf-8?B?cEdEOEdSS29KR3I2SWRKaGdJam5kRWN0aDhVSzg2S2FaTUlzdkhUY2FEbEJw?=
 =?utf-8?B?ekhHQTl6L05IVDl2OU81Ry92MHZXSEFQUnFrMDdtajdOdk11VDcrOTNYV0dj?=
 =?utf-8?B?RzYweVMxa0xtTGtjUWwwTnk1NlF4djFUSTdEZTRwcy9IWE9mM05EMjdnZ1NZ?=
 =?utf-8?B?MVYwU0k5aHBQUUZ1Sll0ZEZPRE1IVndmMTBrb0YwTVZWaUhsOHJZNHgzWnhJ?=
 =?utf-8?B?dkZiS0JXQTZUUGdqRXJMYXhYZkFla0RCMk92RWplRXF3ZlJtVFd1VzVtNWsx?=
 =?utf-8?B?d0wyOWlxVFJBVDNSQm5yRlh5LzN1MStGdWdZcWgvRThVdVpYeC8va09qZ3Zz?=
 =?utf-8?B?ZXRGR01RZktnTEdHbFdQUDA4aS83clkrUGNIQlU2d2tLZytiYjAxRUNydXRx?=
 =?utf-8?B?ZEUxOHMzRUwvTWUyZlFNM0I5V1Bkci9UcVRtRFZMZ1Y1ZlEzdjBJNmI3c1h5?=
 =?utf-8?B?bTlJM3hYc2ZqMHJUeHZCOS8yZGliV0tGbC9YNndleEwvRmcxY05KS2V0RnNI?=
 =?utf-8?B?UEJaVGgzTDM0dVY0Q0d1cStZZGQ0citLMk04VmxSYmQzVGEybGFsMHpuMEhy?=
 =?utf-8?B?d0tWbStoWHVxaVpRL1gwQmRldy9NZ25YamhQajBuMUVrYWJGeHhMdS9sc2Qz?=
 =?utf-8?B?eDE2R2IvRTJpSHFCTDl5UjFRc1psWlQveXdMZmEvV2hjaWI3MUNEZVVnNFpT?=
 =?utf-8?B?TjhKMFYyVlJFUUdMZnl6RktMNGtNWlY1YWxMTERoc0Q3enpLKzNFLzhqWndp?=
 =?utf-8?Q?aOzPRXm0T7EMa9mSTQU0fL40OpvPW3UbLZXcqse?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F4234D5669AD24B925EEB5ACF14FA1F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5a4827-f6a8-4bf8-46f8-08d98388ab48
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 20:35:26.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VDyZ+JbpJgG5D2r8ndjOxGyaLZ1Zher/paGgI36jZgnvjzWYJqfySLi9tZ80K/6GYGoH1HN77uHkugnOyUrgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4762
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTI5IGF0IDE2OjIxIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyOSBTZXAgMjAyMSwgYXQgMTI6MjMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gV2VkLCAyMDIxLTA5LTI5IGF0IDEwOjU2IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjkgU2VwIDIwMjEsIGF0IDk6NDksIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgYSB1
c2VyIGlzIGRvaW5nICdscyAtbCcsIHdlIGhhdmUgYSBoZXVyaXN0aWMgaW4gR0VUQVRUUiB0aGF0
DQo+ID4gPiA+IHRlbGxzDQo+ID4gPiA+IHRoZSByZWFkZGlyIGNvZGUgdG8gdHJ5IHRvIHVzZSBS
RUFERElSUExVUyBpbiBvcmRlciB0byByZWZyZXNoDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBpbm9k
ZQ0KPiA+ID4gPiBhdHRyaWJ1dGVzLiBJbiBjZXJ0YWluIGNpcnVtc3RhbmNlcywgd2UgYWxzbyB0
cnkgdG8gaW52YWxpZGF0ZQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcmVtYWluaW5nIGRpcmVjdG9y
eSBlbnRyaWVzIGluIG9yZGVyIHRvIGVuc3VyZSB0aGlzIHJlZnJlc2guDQo+ID4gPiA+IA0KPiA+
ID4gPiBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgcmVhZGVycyBvZiB0aGUgZGlyZWN0b3J5LCB3ZSBw
cm9iYWJseQ0KPiA+ID4gPiBzaG91bGQNCj4gPiA+ID4gYXZvaWQNCj4gPiA+ID4gaW52YWxpZGF0
aW5nIHRoZSBwYWdlIGNhY2hlLCBzaW5jZSB0aGUgaGV1cmlzdGljIGJyZWFrcyBkb3duIGluDQo+
ID4gPiA+IHRoYXQNCj4gPiA+ID4gc2l0dWF0aW9uIGFueXdheS4NCj4gPiA+IA0KPiA+ID4gSGkg
VHJvbmQsIEknbSBjdXJpb3VzIGFib3V0IHRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIHdvcmsgYmVj
YXVzZQ0KPiA+ID4gd2UncmUgb2Z0ZW4NCj4gPiA+IG1hbmFnaW5nIGV4cGVjdGF0aW9ucyBhYm91
dCBwZXJmb3JtYW5jZSBiZXR3ZWVuIHZhcmlvdXMNCj4gPiA+IHdvcmtsb2Fkcy7CoA0KPiA+ID4g
V2hhdA0KPiA+ID4gZG9lcyB0aGUgd29ya2xvYWQgbG9vayBsaWtlIHRoYXQgcHJvbXB0ZWQgeW91
IHRvIG1ha2UgdGhpcw0KPiA+ID4gb3B0aW1pemF0aW9uPw0KPiA+ID4gDQo+ID4gPiBJJ20gYWxz
byBpbnRlcmVzdGVkIGJlY2F1c2UgSSBoYXZlIHNvbWUgd29yayB0aGF0IGltcHJvdmVzDQo+ID4g
PiByZWFkZGlyDQo+ID4gPiBwZXJmb3JtYW5jZSBmb3IgbXVsdGlwbGUgcmVhZGVycyBvbiBsYXJn
ZSBkaXJlY3RvcmllcywgYnV0IGlzDQo+ID4gPiByb3R0aW5nDQo+ID4gPiBiZWNhdXNlIHRoaW5n
cyBoYXZlIGJlZW4gImdvb2QgZW5vdWdoIiBmb3IgZm9sa3Mgb3ZlciBoZXJlLg0KPiA+ID4gDQo+
ID4gDQo+ID4gQXJlIHlvdSB0YWxraW5nIGFib3V0IHRoaXMgcGF0Y2ggc3BlY2lmaWNhbGx5LCBv
ciB0aGUgc2VyaWVzIGluDQo+ID4gZ2VuZXJhbD8NCj4gDQo+IEEgYml0IG9mIGJvdGggLSB0aGUg
Zmlyc3QgdHdvIHBhdGNoZXMgZGlkbid0IHJlYWxseSBtYWtlIHNlbnNlIHRvIG1lLA0KPiBidXQg
SQ0KPiBnZXQgaXQgbm93LsKgIFRoYW5rcy4NCj4gDQo+ID4gVGhlIGdlbmVyYWwgbW90aXZhdGlv
biBmb3IgdGhlIHNlcmllcyBpcyB0aGF0IGluIGNlcnRhaW4NCj4gPiBjaXJjdW1zdGFuY2VzDQo+
ID4gaW52b2x2aW5nIGEgcmVhZC1vbmx5IHNjZW5hcmlvIChubyBjaGFuZ2VzIHRvIHRoZSBkaXJl
Y3RvcnkpIGFuZA0KPiA+IG11bHRpcGxlIHByb2Nlc3NlcyB3ZSdyZSBzZWVpbmcgYSByZWdyZXNz
aW9uIHcuci50LiBvbGRlciBrZXJuZWxzLg0KPiA+IA0KPiA+IFRoZSBtb3RpdmF0aW9uIGZvciB0
aGlzIHBhcnRpY3VsYXIgcGF0Y2ggaXMgdHdvZm9sZDoNCj4gPiDCoMKgIDEuIEkgd2FudCB0byBn
ZXQgcmlkIG9mIHRoZSBjYWNoZWQgcGFnZV9pbmRleCBpbiB0aGUgaW5vZGUgYW5kDQo+ID4gwqDC
oMKgwqDCoCByZXBsYWNlIGl0IHdpdGggc29tZXRoaW5nIGxlc3MgcGVyc2lzdGVudCAoaW5vZGVz
IGFyZQ0KPiA+IGZvcmV2ZXIsDQo+ID4gwqDCoMKgwqDCoCB1bmxpa2UgZmlsZSBkZXNjcmlwdG9y
cykuDQo+ID4gwqDCoCAyLiBUaGUgaGV1cmlzdGljIGluIHF1ZXN0aW9uIGlzIGRlc2lnbmVkIHRv
IG9ubHkgd29yayBpbiB0aGUNCj4gPiBzaW5nbGUNCj4gPiDCoMKgwqDCoMKgIHByb2Nlc3Mvc2lu
Z2xlIHRocmVhZGVkIGNhc2UuDQo+IA0KPiBNYWtlIHNlbnNlIHRvIG1lIG5vdy4NCj4gDQo+IEkn
bSB3b25kZXJpbmcgaWYgdGhpcyBtaWdodCBiZSBjcmVhdGluZyBhIFJFQURESVIgb3AgYW1wbGlm
aWNhdGlvbg0KPiBmb3IgTg0KPiByZWFkZXJzIHNoYXJpbmcgdGhlIGRpcmVjdG9yeSdzIGZkIGJl
Y2F1c2Ugb25lIHByb2Nlc3MgY2FuIGJlDQo+IGRyb3BwaW5nIHRoZQ0KPiBjYWNoZSwgd2hpY2gg
YXJ0aWZpY2lhbGx5IGRlZmxhdGVzIGRlc2MtPnBhZ2VfaW5kZXggZm9yIGEgZ2l2ZW4NCj4gZGly
X2Nvb2tpZS4NCj4gVGhhdCBsb3dlciBwYWdlX2luZGV4IGdldHMgcmV1c2VkIG9uIHRoZSBuZXh0
IHBhc3MgZHJvcHBpbmcgdGhlDQo+IGNhY2hlLCBhbmQNCj4gaXQnbGwga2VlcCB1c2luZyB0aGUg
Ym90dG9tIHBhZ2VzIGFuZCBkb2luZyBSRUFERElScy7CoCBUaGF0IHdhc24ndA0KPiBwb3NzaWJs
ZQ0KPiBiZWZvcmUgYmVjYXVzZSB3ZSBvbmx5IGludmFsaWRhdGVkIHBhc3QgbmZzaS0+cGFnZV9p
bmRleC4NCj4gDQo+IE1heWJlIGFuIHVubGlrZWx5IGNhc2UgKGJ1dCBJIHRoaW5rIHNvbWUgaHR0
cCBzZXJ2ZXJzIGNvdWxkIGJlaGF2ZQ0KPiB0aGlzDQo+IHdheSksIGFuZCBJJ2QgaGF2ZSB0byB0
ZXN0IGl0IHRvIGJlIHN1cmUuwqAgSSBjYW4gdHJ5IHRvIGRvIHRoYXQNCj4gdW5sZXNzIHlvdQ0K
PiB0aGluayBpdHMgbm90IHBvc3NpYmxlIG9yIGNvbmNlcm5pbmcuDQo+IA0KDQpJdCBpcyBjb25j
ZXJuaW5nLCBhbmQgaW5kZWVkIGluIG91ciB0ZXN0IHdlIGFyZSBzZWVpbmcgUkVBRERJUg0KYW1w
bGlmaWNhdGlvbiB3aXRoIHRoZXNlIG11bHRpcGxlIHByb2Nlc3MgYWNjZXNzZXMuIFNvIHNjZW5h
cmlvcyBsaWtlDQp0aGUgb25lIHlvdSBkZXNjcmliZSBhYm92ZSBhcmUgZXhhY3RseSB0aGUga2lu
ZCBvZiBpc3N1ZSBJIHdhcyBsb29raW5nDQp0byBmaXggd2l0aCB0aGVzZSBwYXRjaGVzLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
