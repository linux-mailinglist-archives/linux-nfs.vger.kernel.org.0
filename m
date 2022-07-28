Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813658424C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiG1OyM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiG1Oxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:53:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC568DE5
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjfHy9/zhHW6lRAfMvUU6Zr0OxVUHYx6aV+vcE38jUw4NxY8eL7YnZR63zHn80RUQ24GXhQn4uBs6HIJEgxz5kPNGDa+Jorxu9tSAWnBbI46a1Lwd+gKHUWUjx9Ugt/FQ2sMv01aLxdhTsEA7zj/cr+1Yw7wIJtrEFKCHLHD/fQgLwRSRKjz1czv4i/dCRuCVopAI4BDoCQ9r0rJzpiNlz6jM4dR9mB2xMJjQWHR6WqeFSh0lBkshiVP6U5O41dLGnSBUncWeEgd/KesKptTTA0lt41G7hiVlTkwLTDVTbDuFyBP+6Pmq4ToE6CLH385VegNY0JDDOuGUzgJ+cbsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvPbc9yjSJ5fhfOfmhpU9lgqNwhi++bLwc8kpArhnqY=;
 b=PE4SStWQfP2YlJAflSA3aIN0rjk0G77uj3f9JP+tfk9viiZZZHSF+p3LJO7jJqBYdFOMW6wG+bKz3HDmeXwNteL4kvcqDzSzDQ/yeQlrmzmrMJbifY5A6ygXuWafuWhz1Aqef11tnEiGVE5Cq/mGCQa0WeiZRkZif86SNKfGXS+3CHAzHm7p2EKOcxnphYh5IQTQZ56B1qrnrvlWOEFovZsdABhJN15XmEmqC6Vt6D1l31S8WWcbZ1IHtH25rW4EaUX7tlkiRJoTzVhCUocMwwznP2YvR27NmPVj4N639RsAL0D1A9kjKb67veEYk6CM+FMOgbJYOkIAWMD+PtTTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvPbc9yjSJ5fhfOfmhpU9lgqNwhi++bLwc8kpArhnqY=;
 b=SxnVY3qE0J4qDmcE1N8Y/ppl1ReqqYae6vpJ1D3/2x1FMBdVrBcfdC2szqejoGct3xdwdA6v5XIN9ljDeS1Lzh0HAzgTcnigywMf5l0Po3JPYObkapwJcIyz1n5L6PVJJoS2Yhpirib3UHaiVYTKY97m1iaSThd1WoPEgSG8SSc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1339.namprd13.prod.outlook.com (2603:10b6:3:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 14:53:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:53:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "kolga@netapp.com" <kolga@netapp.com>
Subject: Re: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
Thread-Topic: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
Thread-Index: AQHYoo22EvI6SCZQSU6Evb804BNG4K2T3myA
Date:   Thu, 28 Jul 2022 14:53:17 +0000
Message-ID: <1514326848e2874284a4af016fbda6dea67327fb.camel@hammerspace.com>
References: <20220728142406.91832-1-jlayton@kernel.org>
In-Reply-To: <20220728142406.91832-1-jlayton@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4768f4e-b7f1-4bbb-3155-08da70a8e7c0
x-ms-traffictypediagnostic: DM5PR13MB1339:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8pE8xDjZzRyV9QbU9NdKX9ywmVkWhTpaIcjrfl2awRhD71WHP6ozfm7xCRcXkQp9HWf2qnFDjqCj3UUvrRIpAp6EA9l6a4U6GvbkOENjkW3RU9MG3qg7a7QSsBWpXyoUrLQyaYN+nJH7h1B8Jrv6bT/PN4DSpCe8JdvnEIEAPiLm2z/KvAmUqcQcVOegVPYUMWqlHlwSXFdiR1Iup9/VblEv09OuWaotdji8Gp18hTbRqpaDGHlQk50C1eqezKtJs3SuvdF97nEuI7KtRd9Ukl1z45HdPEQMaBLQbkHg4kRDE1R2coDfG8+HAabr+u2lXHybdr90RKfgXQ/WjVexWUUeDP0kjCOFg54b/rjP0btys3FSJ1C2KTxcAO77HXaIrBaKnnfxlOl3WAQNr8GNEFxDEJUCwixWFXY0D5/6YjGzrroWgsw+K/dHT/Io0Wxg7U5d6PPEsG0qvfQEVjF1/rDfmLmUFUT+N3xt7O6oq4hAM/DeH1hcw/KRy1P+pWU8TPFyzJjUfWMnW3niZsmAutGAmgHiCGo202hNHnkfElKOCYRdqhNFs4toPRnSBbuT3HnKoUg+RbCaYLtkrKYk39dkQhdFsr6XSBX8Wut4gch6MwAsVc3V33m0UTnken5RODXgSzdsJ7TLL2fxHxqi1TtTiZ53r4Qu2uQRVqN6x16WBmE7+YwgzLxVDrGyyOn2l4HdTOzu1qoyw6g0HBGBDHY/e8mC32Q9VftKNoWs44CtlR2zABUWBiN0PIlD9bsRqNad1DaEF1JuyTXjuNI9mrj7NIeJjU7s1jf7wbJdv+ZagbzW4VdACBt8LQthQ68LUEOUbyzFrcztcsCGF/XFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39840400004)(396003)(136003)(376002)(346002)(86362001)(71200400001)(478600001)(6486002)(38100700002)(38070700005)(6506007)(41300700001)(6512007)(122000001)(2616005)(186003)(83380400001)(26005)(5660300002)(8936002)(36756003)(2906002)(54906003)(66556008)(66476007)(76116006)(64756008)(66446008)(8676002)(66946007)(4326008)(316002)(110136005)(26953001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmRqUi8rdVJTTlhQQkFxNXlTWFB3OEdRY0ZXRGNoUEk2TlRLRnYrVk41NEsy?=
 =?utf-8?B?UWNLMDVRY2pHQTZrY1F1VE1odGl6akVxREhJdzJKQzRYR3RucmpqZWFNZ25K?=
 =?utf-8?B?WkQwdFlDYis0NFRJc3RSb1pGSWlNL2hJQnQyZk16alU1UTdML2lOTjd1SGV0?=
 =?utf-8?B?SVFnUDNQclg0K0hLSXBOb1hYNm0yRW1nclZZdk5LYTQraTRhWDVpSnVNMWYy?=
 =?utf-8?B?cEtDdkpuMnM5T0Z3Q1RrQXpZQ3JJMW4vNzk3RDlZUE1sRHhxeWNaYXl3NkpO?=
 =?utf-8?B?ek9peU0vY2Fad1BsR3R5NkFGM3FFd1A3THM3WmpSZHE5dGNwSjNvTGRHN0VU?=
 =?utf-8?B?SXl5dWhKbUV6WktQMlA4YTFRbjhra3p6WGEray9ZUW5CTGdqdWgybmxtOXA0?=
 =?utf-8?B?TzEwWFhBNFVUWFgxdUdnSHFQTENqWU5tOStmU29LWFJnenFrd1EvaEZSS0pM?=
 =?utf-8?B?NzJsZlhkWnRzZGNiQnlFc2gxbzFTU0lQNDJrMEIvdnJtUy9rbC9OM2J5WHBV?=
 =?utf-8?B?TG1yUEk1SWpobWZBRHFIS2ZaaXB4WTZyVkpUOUJ1Y003TUdjN2J1QVBGSThU?=
 =?utf-8?B?Z0hEMVkyMVBZbzJOMFBTLzRqRzlaSEhYU3NZa2JWL3JkenJvbnc5cEVXTXR3?=
 =?utf-8?B?YWFabTBJYSsxRkdsK04vSUJmZEpkcUQ3SEpWdlRtK2h3eW9IUkxzN2o3VDE0?=
 =?utf-8?B?bDBGOFRaQitIMlJBdk9ybmNMRkhUUEQ5TUsyOWdCbzFrdWJGd1ROUVdDVWZU?=
 =?utf-8?B?OTNOOTdxY0lRemdYQ1hVQzZ2VnhmY2M3TGdYK0VMM0pBNVhyMnZRM29HNFkz?=
 =?utf-8?B?UXJaTDc3Wk1hZkorZ3hxKzV0MW91cVorbzkvU3FTTTF0cDg5STZ6aEdsUGJ0?=
 =?utf-8?B?Und1UEJ5YjhnYmhUdzd5c1AzQzBmYXJDUXBBZGNtek5pQ05qaFMrSkRhOHVx?=
 =?utf-8?B?YTB2VzQ4WVlIeStUT3ZzR05lYWhySzFRa0M5ak5QOUpPYjhoTEZOekFoc0Zl?=
 =?utf-8?B?RFFCNGEyTENhbUZJV2lkaWJlM0J4ek1GVjFURzBRSmR1V3JRUzZSVERnVEI4?=
 =?utf-8?B?S0grRHpQS2RpQ2pNejZJam9HVHBJUm93VXZaNFAxcGpNYU1uM3ZEZVVxeS92?=
 =?utf-8?B?YkwyZ3FpWjFLVWFXNmp2UzdDUUoxT0FRT2RCTU1HVStzOGN0RUFKSXp6VXBT?=
 =?utf-8?B?VlJNRmJqeEhkOG0vVEI2MUMvMXhxM0ZZcnJHc3V3M21CSzhCclNvOEhlYXZX?=
 =?utf-8?B?VVEvbXVQYmNzRzBYeHIwazlFWWR2b1lCS0J0ZVVMbE95ZUNNdTFvM0laa3h6?=
 =?utf-8?B?WVhJaHltem1SRlEzMkdUYTVYb1VsQ2dXMGhYUldXTnN6QTBKcWRYaEYwSWVD?=
 =?utf-8?B?NjRHY0d6SVc0a05EMlJwSndVN2s2b3FVSXNCV2pOYkFXZWtrMDE0QkJSeG1s?=
 =?utf-8?B?dnAyOGNEa0tueHYrZ0p4UVdQQWI1U05QZlRMbThNbkEwSHZUdjdOSkhuRE1h?=
 =?utf-8?B?WXdmYytLakRyNW1ydVBXYk9IcE5UUkVYRW43Y2U0L0RvMFR1UDJmZW5vRGpv?=
 =?utf-8?B?eEdmekNJRmkwNDJ5cWxmMTIxS0Q2VDZrWDZaWVk4VEdmTHV2a2t3MW9ybjJD?=
 =?utf-8?B?Wm4xRWpROUpjRkdacWJFc3REaFdBMVBKWDU0QXRuaWhoaTZIODlXMTJGbllX?=
 =?utf-8?B?d1hxNzFVK1BUdGpUVzJoRjFSYkF6MmdETW12OTVRbVAvTjUzSXlNUDBuaFJ3?=
 =?utf-8?B?Zmc3dDdjYUJhcW1PQW1MNkxCQ2lNNWtta091V2RrZUV1MWVDUFQ1T3lvM09M?=
 =?utf-8?B?aWNMVE8xZHBGeGJiNlVORDViV0QwMzd3T3RaNUIvQ3ZtL1lPb3FQaW12bHY0?=
 =?utf-8?B?K2kxUWw2My9YNFAxVTF2V1dEcHZsSmlQKzZNbm0zSjQ1c1NJNElVclp6c2ZR?=
 =?utf-8?B?UXBWZDdrLzVXNTBPNzJ1cWl6cWNiTkdCRnJmZ1h3Nnc4RG1QS1M3dTBkSTNq?=
 =?utf-8?B?dGgwcENKS09QNTF6aXZ3L2Z5TzRDNktZTHNrNUduWkt1Qk1DbGs0VXR4a21h?=
 =?utf-8?B?SEpaZ2Y5T2x4RnNjRDkyU1NIQ0tnd09LWXVLUHJxZDdJSngrZkhIK1dZMzVW?=
 =?utf-8?B?eGlKb3Z6Tm1xSEtpSFlJQlVrNjVxWWc2UllrWGhTTUtoVS80bys5SjVycjRZ?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB28D1F8BDF33E478419896E48F5F19D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4768f4e-b7f1-4bbb-3155-08da70a8e7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:53:17.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gfl5g7HdHhn5nWX89rmPct8n45GhNKnpcnf57IH113svT9pnxMdrqV7TIlKgFPcFBewjzDowkAjH3xOIzlHZmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDEwOjI0IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T2xnYSByZXBvcnRlZCBhIGNhc2Ugb2YgZGF0YSBjb3JydXB0aW9uIGluIGEgc2l0dWF0aW9uIHdo
ZXJlIHR3bw0KPiBjbGllbnRzDQo+ICh2MyBhbmQgdjQpIHdlcmUgYWx0ZXJuYXRlbHkgZG9pbmcg
b3Blbi93cml0ZS9jbG9zZSB0aGUgc2FtZSBmaWxlLg0KPiANCj4gTG9va2luZyBhdCBjYXB0dXJl
cywgdGhlIHYzIGNsaWVudCBmYWlsZWQgdG8gcGVyZm9ybSBhbnkgb2YgdGhlDQo+IEdFVEFUVFIN
Cj4gY2FsbHMgZm9yIENUTyBkdXJpbmcgb25lIG9mIHRoZSBldmVudHMsIGxlYWRpbmcgaXQgdG8g
b3ZlcndyaXRlIHNvbWUNCj4gZGF0YSB0aGF0IGhhZCBiZWVuIHdyaXR0ZW4gYnkgdGhlIHY0IGNs
aWVudC4NCj4gDQo+IFdlIGhhdmUgdHdvIGNhbGxzIHRoYXQgd29yayBzaW1pbGFybHk6IHB1dF9u
ZnNfb3Blbl9jb250ZXh0IGFuZA0KPiBwdXRfbmZzX29wZW5fY29udGV4dF9zeW5jLiBUaGUgb25s
eSBkaWZmZXJlbmNlIGlzIHRoZSBpc19zeW5jDQo+IHBhcmFtZXRlcg0KPiB0aGF0IGdldHMgcGFz
c2VkIHRvIGNsb3NlX2NvbnRleHQuIFRoZSBvbmx5IGNhbGxlciBvZiB0aGUgX3N5bmMNCj4gdmFy
aWFudA0KPiBpcyBpbiB0aGUgY2xvc2UgY29kZXBhdGguDQo+IA0KPiBPbiBhIHYyLzMgbW91bnQs
IGlmIHRoZSBsYXN0IHJlZmVyZW5jZSBpcyBub3QgcHV0IGJ5DQo+IHB1dF9uZnNfb3Blbl9jb250
ZXh0X3N5bmMsIHRoZW4gQ1RPIHJldmFsaWRhdGlvbiBuZXZlciBoYXBwZW5zLiBGaXgNCj4gdGhp
cw0KPiBieSBhZGRpbmcgYSBuZXcgZmxhZyB0byBuZnNfb3Blbl9jb250ZXh0IGFuZCBzZXQgdGhh
dCBpbg0KPiBwdXRfbmZzX29wZW5fY29udGV4dF9zeW5jLiBJbiBuZnNfY2xvc2VfY29udGV4dCwg
Y2hlY2sgZm9yIHRoYXQgZmxhZw0KPiB3aGVuIHdlJ3JlIGNoZWNraW5nIGlzX3N5bmMgYW5kIHRy
ZWF0IHRoZW0gYXMgZXF1aXZhbGVudC4NCj4gDQo+IENjOiBTY290dCBNYXloZXcgPHNtYXloZXdA
cmVkaGF0LmNvbT4NCj4gQ2M6IEJlbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0K
PiBSZXBvcnRlZC1ieTogT2xnYSBLb3JuaWVza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gLS0tDQo+IMKg
ZnMvbmZzL2lub2RlLmPCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4gwqBpbmNsdWRlL2xpbnV4
L25mc19mcy5oIHwgMyArKy0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIHRoZSByaWdodCBmaXgu
IE1heWJlIHdlJ2QgYmUgYmV0dGVyIG9mZiBqdXN0DQo+IGlnbm9yaW5nIHRoZSBpc19zeW5jIHBh
cmFtZXRlciBpbiBuZnNfY2xvc2VfY29udGV4dD8gSXQncyBwcm9iYWJseQ0KPiBmdW5jdGlvbmFs
bHkgZXF1aXZhbGVudCBhbnl3YXkuDQo+IA0KPiBUaG91Z2h0cz8NCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9pbm9kZS5jDQo+IGluZGV4IGI0ZTQ2YjBmZmEyZC4u
NThiNTA2YTBhMmYyIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvaW5vZGUuYw0KPiArKysgYi9mcy9u
ZnMvaW5vZGUuYw0KPiBAQCAtMTAwNSw3ICsxMDA1LDcgQEAgdm9pZCBuZnNfY2xvc2VfY29udGV4
dChzdHJ1Y3QgbmZzX29wZW5fY29udGV4dA0KPiAqY3R4LCBpbnQgaXNfc3luYykNCj4gwqANCj4g
wqDCoMKgwqDCoMKgwqDCoGlmICghKGN0eC0+bW9kZSAmIEZNT0RFX1dSSVRFKSkNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+IC3CoMKgwqDCoMKgwqDCoGlmICgh
aXNfc3luYykNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFpc19zeW5jICYmICF0ZXN0X2JpdChORlNf
Q09OVEVYVF9ET19DTE9TRSwgJmN0eC0+ZmxhZ3MpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybjsNCj4gwqDCoMKgwqDCoMKgwqDCoGlub2RlID0gZF9pbm9kZShjdHgt
PmRlbnRyeSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoTkZTX1BST1RPKGlub2RlKS0+aGF2ZV9k
ZWxlZ2F0aW9uKGlub2RlLCBGTU9ERV9SRUFEKSkNCg0KTkFDSy4gSWYgdGhlICdpc19zeW5jJyBm
bGFnIGlzIG5vdCBzZXQsIHRoZW4gaXQgaXMgYmVjYXVzZSB0aGUgZnVuY3Rpb24NCmlzIGJlaW5n
IGNhbGxlZCBmcm9tIGEgY29udGV4dCB3aGVyZSBpdCBpcyBub3Qgc2FmZSB0byBkbyBhIHN5bmNo
cm9ub3VzDQpSUEMgY2FsbC4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
