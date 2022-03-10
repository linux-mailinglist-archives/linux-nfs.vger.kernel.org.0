Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652244D536D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Mar 2022 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiCJVIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Mar 2022 16:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiCJVIo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Mar 2022 16:08:44 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2321812
        for <linux-nfs@vger.kernel.org>; Thu, 10 Mar 2022 13:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKZopy/UgZ0z3Zlvf62mLvGdNUmftSRIE3XMMVjXC+s4XC+QMt+Mfkv/f/xQ+uKS9zG+4uhlKZ1alHqkZ6ly8HlD0IiaSb9ZgsZnL9pj8JzGLeIrDy5rJSJE0QNHENF7VR7BqrXfw3j41wJ/EdyAtp+hDtiJTBQSVwed/d7TZDXKHRIFWRyHEoFUowDAyyvdKDIGXU0g5B2byHk5kjKDMB88rXxS/FHNQ8oKcNAedE7F20wNrqN5yJKMPEFXg+1GH69Jg4cL7GaxCyoatOxT8VU9MFkY9B889cSrd1SGIDgtbdDonbFCI3OYIpT6gYx2Qr9+lXUSF+kFqqOp7ZzqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npOjBaTGwcLDnujHtW/Ae0+JoTjY/+/L4FKr2QeqTtQ=;
 b=cYPme1bT0VgN0Y0kq44X/N3GGM7UJQvLzZnWb2SURiPOvUfKAQf3Tw5sOV7iptW1ysW+euXRrTek/no/ifpFzh54bHvLDTExeZbTeB7cxTPxFWYdpkfIVOdUgGOwwj3XYeMh2a7BpVtXUxF3CKceHDY3w+9Y1Q6je8ArQiMbPviked2PcWtlQn9mhcszFp8f8E0gKOYDMNjr/jXls28mjtb8Qe61sFlqWr3On1BIfv5Skp+86A4ZGl5BW1oIswQBvE17xlftyINgQ0U8x15irIZtjtMija8dWTUH7dsEYERRwefftSw58LNfvbdwwXVLpXbFbJeZvCGrFVdZ4VnSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npOjBaTGwcLDnujHtW/Ae0+JoTjY/+/L4FKr2QeqTtQ=;
 b=ad6eBT8TLFWtXS1PdNR9Em6CskpEBqgEaRpb45z2gJEkc6JKt086aL5WMgucYuV7F4ITqzzblx0Gn+Yac0CqIsItFQOyfvylrkl4FhBt6JAtu3US2VxG5eI2xVj4XXGUrLfBe99AX1F5oI2fEdyJ2yabLYD59tpasGogg9LWfcE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4036.namprd13.prod.outlook.com (2603:10b6:5:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6; Thu, 10 Mar
 2022 21:07:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%7]) with mapi id 15.20.5061.018; Thu, 10 Mar 2022
 21:07:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYLDBhnANoa08keUGsN4tf+cdAo6y3iKWAgAGkuYA=
Date:   Thu, 10 Mar 2022 21:07:41 +0000
Message-ID: <9099fead49c961a53027c8ed309a8efd2222d679.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
         <20220227231227.9038-2-trondmy@kernel.org>
         <20220227231227.9038-3-trondmy@kernel.org>
         <20220227231227.9038-4-trondmy@kernel.org>
         <20220227231227.9038-5-trondmy@kernel.org>
         <20220227231227.9038-6-trondmy@kernel.org>
         <20220227231227.9038-7-trondmy@kernel.org>
         <20220227231227.9038-8-trondmy@kernel.org>
         <20220227231227.9038-9-trondmy@kernel.org>
         <20220227231227.9038-10-trondmy@kernel.org>
         <20220227231227.9038-11-trondmy@kernel.org>
         <20220227231227.9038-12-trondmy@kernel.org>
         <20220227231227.9038-13-trondmy@kernel.org>
         <20220227231227.9038-14-trondmy@kernel.org>
         <20220227231227.9038-15-trondmy@kernel.org>
         <20220227231227.9038-16-trondmy@kernel.org>
         <20220227231227.9038-17-trondmy@kernel.org>
         <20220227231227.9038-18-trondmy@kernel.org>
         <20220227231227.9038-19-trondmy@kernel.org>
         <20220227231227.9038-20-trondmy@kernel.org>
         <20220227231227.9038-21-trondmy@kernel.org>
         <20220227231227.9038-22-trondmy@kernel.org>
         <20220227231227.9038-23-trondmy@kernel.org>
         <20220227231227.9038-24-trondmy@kernel.org>
         <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
In-Reply-To: <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e797a0a3-9992-469f-b31f-08da02da03d3
x-ms-traffictypediagnostic: DM6PR13MB4036:EE_
x-microsoft-antispam-prvs: <DM6PR13MB4036E99E9DA4F37263436E0CB80B9@DM6PR13MB4036.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNKeG/p8jmkhrneJI/sgtgpAkwRCig+URwANhu7M+bAKhx53GWBiAgJfwg8ul4vkCFpdW6/ofxLMbii6Qq54rXhmco+DB5tpaOcpmtKCRxhOi2ocmQeA+Cn58GXQp6QlGahM43yuf3LVI2Msyb4Jt9sThQKJ40nzcQzglmIUKxGd17gi1AF1WqfWgNHwr1HBCB07Dnat91HD6ZwdoMqD5QsfebsnQR6T6pfFCjxUUFhPGfet3ZL7JC87OCk3Zsld/mtK8CHW7suZD18ZpaNidtORNYq8wjTcYu8qd2npkm7wYx1xoAwA2ln9yJTNXfFxhT1oTR8v7COa2jBsrtXVjscst/l5fUpA/PI9KIeIKlM0GDym3wdRAQSscCQnXQ9ZgC6Ve+j11f8wzhfvmanaH+e6tJcQ6BLFqwwNQpmbqGF2RYscQo/Bf7ZAKGcap07SeJ5TVKlsHQn53hpgocs5IHOrvySAdUfM3LGKopZU9fWryF4b2RExyfFMYV7193Ezg5NsZwRcP0/U2t+gie/e6OKdZTFWQ5skNfIwzO8jfbN6ovvwVtYQsDvr5V2K39/Jf5B56c9DSi89OP+lc8aDuQqUl4O1Hh3zWw4yKZLcJvh7J8faADKTcFGbJwEucduIv5HM2VQ1KhD621qBIdxmft9Jqp0vsYEqidcTVABAVvuBVM1PdmJxiujMPNrWxC3kfRL3BEL4HjfhQdpmXoTU0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(66446008)(64756008)(4326008)(66556008)(66946007)(8676002)(66476007)(86362001)(83380400001)(122000001)(38100700002)(2906002)(6486002)(5660300002)(38070700005)(8936002)(6916009)(6506007)(36756003)(71200400001)(508600001)(76116006)(2616005)(316002)(6512007)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWNYNTYwZDVwQXBoSnJKRW1NU2lkY2dRdGNWUEppczBObUtUNWpvU1p1ZWJR?=
 =?utf-8?B?UzZ4L1hjbHFjMFNCT2xPeGdGWXo2dUhmN2xwbG5TZW9KMHIySFlLVVRnczNS?=
 =?utf-8?B?R0lENG9VUS9CdjNoMVd1bW5jT2ZXQ3hYU2luL243eFc5bUlTTWxpdUtVTFlz?=
 =?utf-8?B?OG43M0tRa2RTVFp2aXM3ME5VSDRFSlhKKy9VeVVjMUNnZ2U3TG9BTmJFV3dG?=
 =?utf-8?B?Nmg5ODhXa0Z5dU41a2VhR3ovYTJvZnErRU1ma1A4OFE3dEdQQ1hFWjVoaE9u?=
 =?utf-8?B?UlF1K2hnSWsvVkR1b1lmRXhjRFVmY1JySjdneWJxYzRjS2VZWVRUZTFWVTZE?=
 =?utf-8?B?MmZ3ZDN2WlN3Qzdhdkx1blU2ZUhIdFVDWnBZWGVYRXF3SnVFNHpxdDRSNjNU?=
 =?utf-8?B?WFd6bXh6dmFBcWxtY2lDNlZKQUlZeEhzMm05VzNGOUtrMDEycXozOEk2YUNy?=
 =?utf-8?B?eitqanhjSEc2WkhFaDZmYWZKM2pNSkpyelgrVkNGbWNoYUROZk1uYUFZeXdn?=
 =?utf-8?B?ZjFkelFDcDVPSEZNOXRMUSt2aFZnWFRad0ptOVVPTnlwWTJNV2tjcnQzODBl?=
 =?utf-8?B?d1paaUx2L1B4ZlFwRW55bnJzWiswblBNMkFYTDZBeTcvZnZXUlRxdzBzYUY3?=
 =?utf-8?B?SmpPWG9hWktTYzJKM1VnQUQ1VVFRL0dhS1dUYnNoMDJuc21nOUw1NHRwdTV5?=
 =?utf-8?B?YzJHMVJMVndmT3htUDlEbld1dkdZOTVyNlVvRGNHOGhVRU9LaXZXajNrbERI?=
 =?utf-8?B?VG1tTEIvQ1BYd2dyek04bmFJbW9MYXlpTitCTTFRY2tQZTJJMnRMS1p5TE5S?=
 =?utf-8?B?TXBjU3huK0dlVVU0eFNYWmNrQ05GU1g1azNBbGVzVUJRSFFhbjVQeURmN21D?=
 =?utf-8?B?SzhkQXduZVBtUjJibDRLY0h6bnNhZkVVMTlxTkx5WEQ1YURmcDhVWmUrQWRJ?=
 =?utf-8?B?ZmlCd1BuZVJtZHprWklQMnhwSXZPa1JscHZ4dDBCOUh5ZUo4bzNsNVNKdGM2?=
 =?utf-8?B?a0NZaXZ6SVR4K2JrY2EzNVI4dWR6elNVc0owK2R1VHVBa08xT3dMaGc1dmow?=
 =?utf-8?B?VWFoMGZ3a1NjQ0ErVVRKMENJSTBDTk1yY0FRS3hSaytKdWl1U2RwWVVtcWhs?=
 =?utf-8?B?ZmhSS1FpRm56eStQam9HMW5BM3V2RmROaDlDQUpXNnZqZ3hJMUU3ZFU5ODVB?=
 =?utf-8?B?K3hlWFlTYkw2blB1UnU2L01TaXlHZkdMaXVGNDl2UjRYaTVqL1lQOUZ1a3VO?=
 =?utf-8?B?RFpCeUJtWUlseU45S2hyaXVCczZSVksrb253d3dsNlZFMGcxc2tWc2hhZENq?=
 =?utf-8?B?V3UzWEc2UkE3R3MyVTN0K1BqUXZFT1VWZHpGWU51RzNJSVh2QmJnZGJxUDB3?=
 =?utf-8?B?UnUrejF6bGt1NDJ4cWFkVHlTbDdUR1d2a3pId1dHM2N5WXE4dXgrVC82OXdh?=
 =?utf-8?B?cElMbHpoTDNIUkwxV3AxV01FVnhjTjgvUHR0WXd3eUpXL3lqWjVUcmU0L2Fx?=
 =?utf-8?B?SUMrZG9UdjNBY0x1cmZOYXVVLzZPZnE2VTgvNW1sRVR6dzZzYytvU0UrSXlk?=
 =?utf-8?B?bitXWTJGQ1dlQlhWMkZkYjhua2hTZzVNT0hTaXRkZW1tS3hJbUV1Z1lQQzlZ?=
 =?utf-8?B?cEhRMkV4OERGL0ZSRjlSeXhmZ1B0NTFaYU1mTDlqbTd4NnlwYzV4WUdaVTc2?=
 =?utf-8?B?NVpQRmZ1UGxaK2pvaGtSRVNsSFRwd092MWk1aVBzNE94RXdURS9ibkxWa0Ri?=
 =?utf-8?B?L0w3aGdJWGpuendCV3lHUVE3Q3hXekhuQ3ZRNGh2WmsvVFRhc0tObW90ZkRE?=
 =?utf-8?B?QVhWOEJxcWs5MzNpSkVGd3NYMGZOaEczSEpTSEZyTGQ5WHc2cGlBYXE1SjFS?=
 =?utf-8?B?RWpyWGdsbkYzNkMram5POEpJVGp5WEFHYzgzd2lBdGdGSERpUGpaVjVaZnVH?=
 =?utf-8?B?ZmhSYzN6Ynk3WHhmdFFoc2k3TXdBY3VPcERBeHcxd1pxMjQ5UjRCWFdJaGk0?=
 =?utf-8?B?SFVoRmtNcG93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69DE404DDDB3A64589F164407CBA5FAD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e797a0a3-9992-469f-b31f-08da02da03d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 21:07:41.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbU5B1vRmug/eMlDN476o3Foq3mfuQU7vKQovHm7gdZRi6OHNQxn8xwmvBozAuEPa0TBWO7LFB58GkOQoU/Wzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTA5IGF0IDE1OjAxIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNyBGZWIgMjAyMiwgYXQgMTg6MTIsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJbnN0ZWFkIG9mIHVzaW5nIGEgbGluZWFyIGluZGV4IHRv
IGFkZHJlc3MgdGhlIHBhZ2VzLCB1c2UgdGhlDQo+ID4gY29va2llIG9mDQo+ID4gdGhlIGZpcnN0
IGVudHJ5LCBzaW5jZSB0aGF0IGlzIHdoYXQgd2UgdXNlIHRvIG1hdGNoIHRoZSBwYWdlDQo+ID4g
YW55d2F5Lg0KPiA+IA0KPiA+IFRoaXMgYWxsb3dzIHVzIHRvIGF2b2lkIHJlLXJlYWRpbmcgdGhl
IGVudGlyZSBjYWNoZSBvbiBhIHNlZWtkaXIoKQ0KPiA+IHR5cGUNCj4gPiBvZiBvcGVyYXRpb24u
IFRoZSBsYXR0ZXIgaXMgdmVyeSBjb21tb24gd2hlbiByZS1leHBvcnRpbmcgTkZTLCBhbmQNCj4g
PiBpcyBhDQo+ID4gbWFqb3IgcGVyZm9ybWFuY2UgZHJhaW4uDQo+ID4gDQo+ID4gVGhlIGNoYW5n
ZSBkb2VzIGFmZmVjdCBvdXIgZHVwbGljYXRlIGNvb2tpZSBkZXRlY3Rpb24sIHNpbmNlIHdlIGNh
bg0KPiA+IG5vDQo+ID4gbG9uZ2VyIHJlbHkgb24gdGhlIHBhZ2UgaW5kZXggYXMgYSBsaW5lYXIg
b2Zmc2V0IGZvciBkZXRlY3RpbmcNCj4gPiB3aGV0aGVyDQo+ID4gd2UgbG9vcGVkIGJhY2t3YXJk
cy4gSG93ZXZlciBzaW5jZSB3ZSBubyBsb25nZXIgZG8gYSBsaW5lYXIgc2VhcmNoDQo+ID4gdGhy
b3VnaCBhbGwgdGhlIHBhZ2VzIG9uIGVhY2ggY2FsbCB0byBuZnNfcmVhZGRpcigpLCB0aGlzIGlz
IGxlc3MNCj4gPiBvZiBhDQo+ID4gY29uY2VybiB0aGFuIGl0IHdhcyBwcmV2aW91c2x5Lg0KPiA+
IFRoZSBvdGhlciBkb3duc2lkZSBpcyB0aGF0IGludmFsaWRhdGVfbWFwcGluZ19wYWdlcygpIG5v
IGxvbmdlciBjYW4NCj4gPiB1c2UNCj4gPiB0aGUgcGFnZSBpbmRleCB0byBhdm9pZCBjbGVhcmlu
ZyBwYWdlcyB0aGF0IGhhdmUgYmVlbiByZWFkLiBBDQo+ID4gc3Vic2VxdWVudA0KPiA+IHBhdGNo
IHdpbGwgcmVzdG9yZSB0aGUgZnVuY3Rpb25hbGl0eSB0aGlzIHByb3ZpZGVzIHRvIHRoZSAnbHMg
LWwnDQo+ID4gaGV1cmlzdGljLg0KPiANCj4gSSBkaWRuJ3QgcmVhbGl6ZSB0aGUgYXBwcm9hY2gg
d2FzIHRvIGFsc28gaGFzaCBvdXQgdGhlIGxpbmVhcmx5LQ0KPiBjYWNoZWQNCj4gZW50cmllcy7C
oCBJIHRob3VnaHQgd2UnZCBkbyBzb21ldGhpbmcgbGlrZSBmbGFnIHRoZSBjb250ZXh0IGZvcg0K
PiBoYXNoZWQgcGFnZQ0KPiBpbmRleGVzIGFmdGVyIGEgc2Vla2RpciBldmVudCwgYW5kIGlmIHRo
ZXJlIGFyZSBjb2xsaXNpb25zIHdpdGggdGhlDQo+IGxpbmVhcg0KPiBlbnRyaWVzLCB0aGV5J2xs
IGdldCBmaXhlZCB1cCB3aGVuIGZvdW5kLg0KDQpXaHk/IFdoYXQncyB0aGUgcG9pbnQgb2YgdXNp
bmcgMiBtb2RlbHMgd2hlcmUgMSB3aWxsIGRvPw0KDQo+IA0KPiBEb2Vzbid0IHRoYXQgbWVhbiB0
aGF0IHdpdGggdGhpcyBhcHByb2FjaCBzZWVrZGlyKCkgb25seSBoaXRzIHRoZQ0KPiBzYW1lIHBh
Z2VzDQo+IHdoZW4gdGhlIGVudHJ5IG9mZnNldCBpcyBwYWdlLWFsaWduZWQ/wqAgVGhhdCdzIDEg
aW4gMTI3IG9kZHMuDQoNClRoZSBwb2ludCBpcyBub3QgdG8gc3RvbXAgYWxsIG92ZXIgdGhlIHBh
Z2VzIHRoYXQgY29udGFpbiBhbGlnbmVkIGRhdGENCndoZW4gdGhlIGFwcGxpY2F0aW9uIGRvZXMg
Y2FsbCBzZWVrZGlyKCkuDQoNCklPVzogd2UgYWx3YXlzIG9wdGltaXNlIGZvciB0aGUgY2FzZSB3
aGVyZSB3ZSBkbyBhIGxpbmVhciByZWFkIG9mIHRoZQ0KZGlyZWN0b3J5LCBidXQgd2Ugc3VwcG9y
dCByYW5kb20gc2Vla2RpcigpICsgcmVhZCB0b28uDQoNCj4gDQo+IEl0IGFsc28gbWVhbnMgd2Un
cmUgYW1wbGlmeWluZyB0aGUgcGFnZWNhY2hlJ3MgdXNlYWdlIGZvciBzbGlnaHRseQ0KPiBjaGFu
Z2luZw0KPiBkaXJlY3RvcmllcyAtIHJhdGhlciB0aGFuIHJlLXVzaW5nIHRoZSBzYW1lIHBhZ2Vz
IHdlJ3JlIHNjYXR0ZXJpbmcNCj4gb3VyIHVzYWdlDQo+IGFjcm9zcyB0aGUgaW5kZXguwqAgRWgs
IG1heWJlIG5vdCBhIGJpZyBkZWFsIGlmIHdlIGp1c3QgZXhwZWN0IHRoZQ0KPiBwYWdlDQo+IGNh
Y2hlJ3MgTFJVIHRvIGRvIHRoZSB3b3JrLg0KPiANCg0KSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIg
cG9pbnQgYWJvdXQgJ25vdCByZXVzaW5nJy4gSWYgdGhlIHVzZXIgc2Vla3MgdG8NCnRoZSBzYW1l
IGNvb2tpZSwgd2UgcmV1c2UgdGhlIHBhZ2UuIEhvd2V2ZXIgSSBkb24ndCBrbm93IGhvdyB5b3Ug
d291bGQNCmdvIGFib3V0IHNldHRpbmcgdXAgYSBzY2hlbWEgdGhhdCBhbGxvd3MgeW91IHRvIHNl
ZWsgdG8gYW4gYXJiaXRyYXJ5DQpjb29raWUgd2l0aG91dCBkb2luZyBhIGxpbmVhciBzZWFyY2gu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
