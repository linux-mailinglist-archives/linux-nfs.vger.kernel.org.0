Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA44DA02F
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiCOQhe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344566AbiCOQhe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:37:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7925E90;
        Tue, 15 Mar 2022 09:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9L8pODU8xCi/rF3R827iS48yRahyKsT0daIr7q7Fq6P8snrKX9dYzMOq4BSUufypyOawpMUgDcqIBv1ulbWV5vsnGojnTqQeS0BadlgJAqbggymbsYvJTEE6NiWJlhH2lfanMg9W7yJ8v4I5APdGgIqE/wlbkpMZDf1s8mPAl4mY3EoELJ+9qAhfYOkpqXOjLi1z3nRH8C34Yx2lhQf2UVwS+ZKwA3Gn0Bp+zqhKbvkeOrWg5s9VFTayHc4arAOcr50QPAH5i5UGK3wQy0io65XUpMhA+BZa1owr6v1OcPWicq82TKo1B8HGhUIYorOyQpWrDSdWCew7f+PUW5ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6H7879ToU65BjtJ2Flj7XpcTQxEF6MpJjIkE8WW2Q4=;
 b=TZhVndyafvD8U5VX4sul/UUnWeMpRUxndjc/ECFuubdv8KvfaONWCduf+6VDwYagaNSY9Eyk7p23sXxLb38E2M4Snwh8fJ3QcmfrZKtq9NmZUaeoEotwhhOnKZPAvm+kL5wfLAqVGXbWvWHKMrBmBt+ixO+vpCmIEeZbHqfmurDMqdwD9dGfVLXSykqkeIAo/TW/eXcMKwqQod6NwjUxAdLHwU7F3TA45jWM7a/wHh/Ct6acO+uejyKyLj2Xz91eRvA/LypTojjurhW4loL8dcVpzUDRBGWrwtqVxvtkNDneb+kHzS8G9CvNqWgfH2kizb4WQO9Tz/6wgon2JiguXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6H7879ToU65BjtJ2Flj7XpcTQxEF6MpJjIkE8WW2Q4=;
 b=VN2WK3BQsBO9U7Zctw+6DoE8kYcKN6dzyxQ8+Bsk7jxro0nOwR2BLTdt0IETTiTFjZGdbP5hJFSC21aMznlFXEXzN0f3UnAKcH1jN3AlxvBjpp0c+xM1ncEOfn/+y/h2127Z8GWExWI7eNmDBRNtthFTl72v/BIipbIrL6MZ8Lo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4874.namprd13.prod.outlook.com (2603:10b6:510:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10; Tue, 15 Mar
 2022 16:30:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 16:30:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYOIIlIseqOTsZTUW+GxAwe0lt46zAoJeAgAACcYA=
Date:   Tue, 15 Mar 2022 16:30:48 +0000
Message-ID: <6229c1c4ab4b82d59503b8c5cd4d909f0e165e2e.camel@hammerspace.com>
References: <20220315153406.GA1527@kili>
         <C81665CA-D2FB-45EC-BE01-7384B567356B@oracle.com>
In-Reply-To: <C81665CA-D2FB-45EC-BE01-7384B567356B@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7499b1a2-b947-4d69-17d7-08da06a129bb
x-ms-traffictypediagnostic: PH0PR13MB4874:EE_
x-microsoft-antispam-prvs: <PH0PR13MB4874989346E6B8209501559AB8109@PH0PR13MB4874.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4VIu101gSUwTbMrwQVNIpuTbo/7MXlvSwIRB/1I1JzbKCXsFbnKlvd1z/tmYMUXkHNbZPBnXAhTob3RLJn/XHbq7QRcytZFyancOvV7/VoDlZ6vi6BDbEz1MlnGW9oF8ANnsXaDIwIM0P+h0kdauXRJM2BFoBHDk9DSEQDZ+rfDY8eJtn//Z24bXjwtYCWr+2xz/7iGPuzCDXq5JTEuNJsp7ieBu4I2qzRbZYQZ2pKZ8S9FC0ETaM5K7QwrVghUhptxu3/+Yyln/JFyIYagw4MM82waKH+Uft70RCgoieAEzdNdOj16gJkXGkYfYgP1FnNgRUj448lxIz9UPtBUpthrog/E9lazmmjwTHuTQJcNk5WhRx+skxIs2Unm+HUKCjlV6teBk1Pi7XJm7jN2X5Ot97CVB8S9H4eHWchf+20SevF4pUZ7NxOyvwSmFtFRPitMi5nEVe0ytNkPiPuu5ckckRasVxb4zZ0zPkVdA8xNUO849z1F0d+8TUN+ueETbfZH/38nCTjI7rwx7YATWbb4WYa9msGDBJml1LNr0jTh7TRPTwY4EohVxY5C9NTQqjAHLjO9nrf2ha6ub134hqtoSqTaVxdoAewU2ThLwi6ONfkIpltsmee+0Zon0xL4vi6eBfL2elGObYkcGmOMAmx2aDb/fd4MYBk5Z96LgLpc81Xe2aEZTHCsCbqmr9FoxKOvsUqbgkujyWeBwAoYGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(4744005)(66556008)(64756008)(2906002)(498600001)(122000001)(4326008)(38100700002)(5660300002)(66946007)(76116006)(36756003)(8936002)(53546011)(6506007)(8676002)(6916009)(54906003)(86362001)(71200400001)(6486002)(38070700005)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTFYbUs2N05zQXNMSm11T1ZRR056S0tTeElBYUYvcjVINnRob0lZeFlwcFFD?=
 =?utf-8?B?d29UZVB1L3FTYU1rT0k1VWVBYmRRdlNXVWFNT1hJbHlmcEc5OFJLL1BDaHVY?=
 =?utf-8?B?WHBZL1orOHJGRTJuZUtzOEYxcEdPNUxwai9oclUzd0JMUllTdXBGblF1Q3ZR?=
 =?utf-8?B?STZqUi9RQnhZaGVzd2c1dHRtNGNvNmtCZXcvemZGbjBwM1ZNS3pxMnhwUkdj?=
 =?utf-8?B?cTU4YWVIdUZxTXUwYlY1S0pKdFk0Y0NTd1NROURxQTdTTG9jM0xuZE15VWVx?=
 =?utf-8?B?clMvd1R0SDRQdGd2ZEVXaE0vcCtsQUQzTmpmcitaa1JOQWV1MmJib1RCKzFX?=
 =?utf-8?B?TlNKcm9mRlVITFpzTUNDYXNtUFY2Q1oxaE5tbk03dlJYNGZwUXdQTW5HbHdY?=
 =?utf-8?B?TDJqMkFZQ0lvNERmUnB2RE9OWnZRYUQ2SDcwTGd2VFJ2MEdzTkdKbU9qa0V1?=
 =?utf-8?B?YkhXQUFPVm52MklxV1VnQzlmYkJ0M0E4K0k2UHR2VXMzKzVCQ3JzZU8wQU5w?=
 =?utf-8?B?WGRqQjU5OUV6LzQ1QXVnWGk3MG11N3l4TVh2ZVNXV1V0cGRRWUxDdjh4bzZF?=
 =?utf-8?B?cGVaYmg3dkx4Znl1V1BLV1d4UUpLekovMEg0MDFJN29pOGhvT2pIeHFkVEI4?=
 =?utf-8?B?aXZEcm9PYzJ5ZmRScUdnRk8wL2ZsU25TVDNCcnk1REl5M0wyM1pKZThyb3lr?=
 =?utf-8?B?TXYxR0FybjVOb2hnVEU0QjhQRXQvVkY1WlBkaVNYYW5yWlMrM282NDdNL0JP?=
 =?utf-8?B?bWFCMWhwSnFER3FuaTB4WWFOSDNRWWRUQzZXTmk2ZXZNKzlpQzFocFQvK0JG?=
 =?utf-8?B?VVRvMnJiUXNZcnpjU1hiZzBxRVpvNExndzY3RDNkMlB1RjBCQVlpc0ZQNlNK?=
 =?utf-8?B?TEtVN204Tm1HZEp6aC9kNGlLbzNuRzR2MHVldjF5dVlLdHd2b3NYMmlJRHJN?=
 =?utf-8?B?MWNxWmNhM3U4Yy9CN2dLYkFVcWNsYTM3TVI3b0gwUFV0Y3c0VkFjU1R5UmhS?=
 =?utf-8?B?ZDFIZUVWUGlyVmozWUsxZklpZzNKaFg0elFsalhOT0tGRjkyWm1vRjFvZXdl?=
 =?utf-8?B?cHcwN0ZOeE1PMkZLRWJQOGYxN25BaksrdWZZSkJYdWJ5NlJVRCtZVEVTSVpV?=
 =?utf-8?B?WG9HWkJXeTlXREhlQmc3ZjUvRFVMZ0hienZobi9sQ0pYVm1LVGVJV2ZZYmhs?=
 =?utf-8?B?eWRpZDVMaUhhdTZvbEdBZlFnZVlheFBVUUF2eFdHSEF2MWsvaHFiVmhrWEw4?=
 =?utf-8?B?SzBLK3kwTzc3MEpSNkNTZHJ1akx3bkY4cWJnckNjVFo2YytNMmZrdkI5U05s?=
 =?utf-8?B?Tjc2a290VjFXR2JwN1FBanAzOWsxSlBmcXEzWGxyLzZLNFkzNUJRclYyY3Nw?=
 =?utf-8?B?bUMvNW9VN1NvU1AwME55UDhvekhSeU5CTi9MVGQrOW9UOE1uWWgxK05vaUx3?=
 =?utf-8?B?b3gzMjVodTN0dHhBU0tOTnl2T1B1TUNLRkZHTzZjTGVUeVZzcFBOUkNnN2dk?=
 =?utf-8?B?YXdTay81NEh0c1g2RTdpUHNORmhkM2Y2YU4wK1ZPaktqb3JyQ1BoRFFmb3FU?=
 =?utf-8?B?RGVqL2RCSHAyL2JXU1dSZDVVQmpiL1VXWHc2aDVCRUtuWnBXQ2liR0ZFZWVh?=
 =?utf-8?B?MExuOEhXekx3QSthNmZJOTA3VDU5L01GZzc1UzBTMklNczlHakU5aUJRd2FT?=
 =?utf-8?B?b0hQRlE1L0orcUdQcUVuVTdXWkkyeWNwTldDV3ZCNXpxNW4yeDVxVGxPZ2dQ?=
 =?utf-8?B?MW16TmN5bEhoMUdGSnY1QWRYYXlaYkZ2ZS9GaWNjd3FHWExzb1loajZTUjBo?=
 =?utf-8?B?NnVsMmFtY3QrNFQ4T3Rrak51ZTlsVW45d3NXMVU3N1pjeFBLRjZvL0xDZlA3?=
 =?utf-8?B?THRncVg2WGVOSjJVaTQ3aTN6WWNSaVNneFJrTzErNTBkS2hGY3dNcFpQMmZE?=
 =?utf-8?B?dFZWTUJoVmJZZ0llcTlaT2pObDloRWc4WWNOd2ptQ25QamR3aTFidWVXRnUy?=
 =?utf-8?B?cFlSRG8za3JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <759885ED8DA306498FF4273E606432DC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7499b1a2-b947-4d69-17d7-08da06a129bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:30:48.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sg3zi+4CUi9tiSGol8DU1Ef16aC9lHShuhebBFsbSeJjF0FgHje3/K5j3ljLIeIrmPiPk9YXoDp6onb1qoiuig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDE2OjIyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMTUsIDIwMjIsIGF0IDExOjM0IEFNLCBEYW4gQ2FycGVudGVy
DQo+ID4gPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gYSAz
MiBiaXQgc3lzdGVtLCB0aGUgImxlbiAqIHNpemVvZigqcCkiIG9wZXJhdGlvbiBjYW4gaGF2ZSBh
bg0KPiA+IGludGVnZXIgb3ZlcmZsb3cuDQo+ID4gDQo+ID4gYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3Jh
Y2xlLmNvbT4NCj4gDQo+IFRyb25kLCB0aGlzIHBhdGNoIHdhcyBUbzogbWUsIGJ1dCBlaXRoZXIg
eW91IG9yIEkgY2FuIHRha2UgdGhpcy4NCj4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgcHJlZmVy
ZW5jZS4NCj4gDQoNCkkgZG9uJ3QgbWluZCBlaXRoZXIgd2F5LiBJZiB5b3UndmUgZ290IGl0IGFw
cGxpZWQgYWxyZWFkeSwgdGhlbiBsZXQncw0Kc2VuZCBpdCB0aHJvdWdoIHlvdXIgdHJlZS4NCg0K
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
