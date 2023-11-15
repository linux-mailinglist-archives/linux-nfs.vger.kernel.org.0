Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDF7EC978
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKORQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKORQS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 12:16:18 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2121.outbound.protection.outlook.com [40.107.102.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1373FA
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 09:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J45GHvhi5AQYshZm64cfKvvzzmWx6zXRRB3FvKWs/j9/4Ka2QZv3WaHjyTig73/1Tv/+FskKvKOMdq8I1tFbtUcsOtvWXufY9Ij2W3hOqg14gyl+gTPAEKj6B9StP3yuflCgZZYIDuUiTGl2HL410x80A7wFkSnlwtDCnm/zPGYYanbDmg4t745TL4cpk6G92xnqb839c3FJYN72hEQy2aeb+yLqUy/3KjDnLToKHHicYIET2R52HA5pA/vXt0i8M7jvVnFq3nDw4oeJLniv+gHf6IpD0QUXKpw9f2G5E4dCZDqmCcO6aqks/DtIS+YgisCdTNJHWCh9VehMxDoo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/iTHGkGfV769TZoyGKOMu1tZoJIg00pDZoaak6CKu8=;
 b=UuOROsTwHC6ePojkecSo5O0ZaUpjhHIHOl+kDykLNR8Ez3KPZyT2ebx/s2B/BDU4hh6iIrQxTdDTsoLkOpo0AkRKL0cD2pk1kIirRcXol4uZ+M1ZaMMmr46i59wz+qbVYxLqcxsR3PV3i1cuN52/4ALjj5n18gY+fwbiryfCTSPiIN4tdPk2J8nXnq71N/Ko9H9rZimdcvjiou2JLE+7vhXRbyXDnY/pK2YGLZp98EIUO/TwMPhtXqzuLVRs0S45ZvL1+WV25kfWpYOby/rS9XIXGpgeKcpWeLrFCL91qBlz06zycdIvkHtjp6YiDLqojXNI8tTZRi+0IHmk/LluvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/iTHGkGfV769TZoyGKOMu1tZoJIg00pDZoaak6CKu8=;
 b=CVATTYu+VB2m48mZUFOWenbkTPl2PZ41APl/nYNu+aDL2Vhbwin6re14O8Lk7I6tlgfZE9sO56BCD4GhoMbjlcaK63dorDlWnVvl91749KCOZR3a+x7xvQRIwjnetInHgwrrIay9pk4iSdSGrY5YjcjWEYuLmjVLmws2XIUfxAQ=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SJ0PR13MB6038.namprd13.prod.outlook.com (2603:10b6:a03:3e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 17:16:10 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 17:16:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Thread-Topic: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Thread-Index: AQHZ306sMYUBwkk2F0uv3y3KiOfJVrByfb+AgAAePACAAAjJAIAJJQkAgABGb4A=
Date:   Wed, 15 Nov 2023 17:16:10 +0000
Message-ID: <73e48b3b4e835231a1c2a79613baf6bb01d3f6a3.camel@hammerspace.com>
References: <20230904163441.11950-1-trondmy@kernel.org>
         <20230904163441.11950-2-trondmy@kernel.org>
         <02FDFFF6-8512-4BBA-845D-72C21864E621@redhat.com>
         <44d134dd65a4c7194f5200a390e5229003ba4016.camel@hammerspace.com>
         <4EBFA030-C144-4017-842F-B8D6B2ADC19A@redhat.com>
         <EA084F46-9E51-4A9E-AEE4-018499819F12@redhat.com>
In-Reply-To: <EA084F46-9E51-4A9E-AEE4-018499819F12@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SJ0PR13MB6038:EE_
x-ms-office365-filtering-correlation-id: 12c844da-df8a-466d-692f-08dbe5fe900e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8kHpbV9FmbYMLWT+w8ELIK6icV9Zj8bbJ4xOED/1j0D+MLqXrlao6JDAwsaZnXFyvGPun75+FeRFGlm1EAEsCOxYzYM2EAe2sPJug/STAPIINNK0H5Wt6TjSzFvrN9YN7TZ4FG1sLI+WkldfeSDubBDYIfvsv4fQeEbZYvLXNpzWb9+CpYnoIWgS95FkcRvB7//K4dOziBmCK5/25MyL1YZXuXHZ6B/WKT9SG4M/4vc6RorZhx/y+MTeas2alUpImk0SdBLGT0GnoCQvNeNl0pzb4P8AQxeu8+6NpBBpVN4TolUeSJCgx+HmV5FvUBGqj1twPyXeXA8FKSKTiN3pAdFa1KMPnAvf45qLojmplf9d4wEtibL8YHhMrnODyWJ6jmDp6mNM4EvqZSVZuUXS2EGJ28c8lA7KvNti8ap3BZq2zNi7fLVrXil4eQkpx6G7Yx2Ihhu53P+f83pN7MB0Z42rWzhV0G3oS56nbZ8C1LLJY4ndUXB4rHJPIISy/hEV8t0Jd1cVPPOsSJc6KKgwN9UvwKLQ1nUBfGWXSPkX9cCDxT6gUsqMg0eP5VkoJTWuR4+eQJ01/E086KLpknL/yAAxr5IBXpmANee/kxdcXAeMjAB15VtFyafaZrSf1PTyBf7PDADRTRJXn0IHaMSZP6ZbotPikNPpLtwbij6Rqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(6512007)(83380400001)(122000001)(38070700009)(6486002)(478600001)(66946007)(41300700001)(2906002)(4001150100001)(4326008)(8936002)(5660300002)(8676002)(86362001)(66446008)(6916009)(66556008)(66476007)(54906003)(76116006)(91956017)(316002)(36756003)(64756008)(71200400001)(53546011)(6506007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZSS1RKMVhsb2xTRzFGR3VrT0w0eVMyb1IvTUFHTFl2OGxqdWRtVjE2SUhh?=
 =?utf-8?B?OXBKUkF1UmNsZG44ZEp3clIxcE8rSHByaFZGYnY1Ni8rVE9XSEZJK1B2WHBk?=
 =?utf-8?B?amdXR2dEc2UxVHRLOExvNy9DL1ZabUZ3Mll1S0lTeW5RTXloYnYrdDlZOUxN?=
 =?utf-8?B?NkMrS1g4Y3E4UHgxUkNaOVBybDRpWmVlY1pINDZ6eDUxYTlpcVdZejZydVdl?=
 =?utf-8?B?LzArSUl5NFNGQ0IxYTYxbFl2ZzRWY2dSNXlSNHNzRTNMNEpydlBnSFBiTTdM?=
 =?utf-8?B?REdEUjlVQThieUxkV0p1WVdoQ1NRU25ONTUzNFlSRURqR29Va0JVSWx1aDVr?=
 =?utf-8?B?bmlBc0E4TXZzRUlzUU10ODVlYlZhSWsxQkkzNVlCYW52VlgwUWJyVFdzNUFh?=
 =?utf-8?B?WkFCb1lDeGtubk1veHRscnZuWUc5N3VZVnZnQ0tYdUtiWkp6U3l5OHNxbGpI?=
 =?utf-8?B?Uk12Qm8zMHZoODF1TkJGL1FBb2xacEpObVNjLzB5aC9BUWRqcVVROHhGY3Vw?=
 =?utf-8?B?YTY5VDZIMDBnbUlKbitaVldoVlhPYlc3OWUrNmJIc1hWak1DZ25jOHk3ODV3?=
 =?utf-8?B?Wm11RGZLUFBYL1lFN3lRdjd2eW0wV2x5SEtuMEkwZXMzVXJCNTJ2Skhyb2Uy?=
 =?utf-8?B?VmM1TEZPSmxtSjVIMVRwVVBENWdHajNZRXRPNEdEdk1HeGlsUkJMRVZTTFlT?=
 =?utf-8?B?V29OOW5QY3BLbGxNck5LQnUvM2VJVFNNNFRLK0JNZVlYWHVYbE1yNFcxTTkv?=
 =?utf-8?B?cnBQbVRmZkIxZUxaOUlKMWhpU3BVR003V3VsVlBCdTdDTDljWEE4Y095TCtm?=
 =?utf-8?B?VXcvR3o3aWxGZ2NVSHdBNkVFSjl6ekMwUjkyNEo0MFZ4OEg2QndsdDJueHZY?=
 =?utf-8?B?a3N5dzRLVkdRSDJBUndyeW9meFZxcGtXdW5XdUN6QkdVbVdQL1pxUGdFRkow?=
 =?utf-8?B?Wk5BWFVrYjJNODFUVlRQTm9VZjdLNHhmbmhOeHlzSi9JbWE1T2tUWkVKcmkx?=
 =?utf-8?B?T3gveDhWZzhmd2MxbktGZ1Jia1JDaTZJNUVsRDkzdW9rL2NvL3AyOEZQU0JH?=
 =?utf-8?B?RllGVlVaM0laQWM3U2ZKeWQ0V3pIcnpKVXJuZjNRendGYyszZnYwVDM2ZC9y?=
 =?utf-8?B?bFJYOVAyZC9JWU5aVitQWlNtY3hSNk1ac0dJTFBnVDc0QVN0OTlEQUNnWDB5?=
 =?utf-8?B?ZzNzZTNVTWE2RFp0MjR1Qm9uTTJTQ0FHRG5SeFI1V2RjSUg2RDFLTGw5Mmtx?=
 =?utf-8?B?UHl6S1lQaXhYQ3VVT0pqaXdBSUMyV2M0Ui9IVjkwUC8zT2RiVDdhaFhVUlFU?=
 =?utf-8?B?OWxLMlFjWFBVMUsxenZzVGFuTWk2VXNnV2llaHV2cnhJWnR6dU5OczBUMlg4?=
 =?utf-8?B?V3l2d2Y3aVZOOGJJM2NGSUhXTU5zREtKdWlFenVzazhGK0FRRmlGRW9xUldn?=
 =?utf-8?B?c1c4cFA3Z251Q2dFOVIrSnJoQ2xOYVVwWG15cUlzdzAxRDBmbXlHbjF2eHZY?=
 =?utf-8?B?TmJjQVBEdmRZZjhNQmlNcXd2N0dmbUxKc2llSHRpVW1DOWc0SlhKc3krM0wr?=
 =?utf-8?B?b0cyMXg0R2pJQ0h0ejB5Zk95QVE2dmdsb05TZ2lVcW9QTUhpQU1DSXFSUUJl?=
 =?utf-8?B?Z0FkWUt4Wk8vUE1LMjk3ckpGNlk4ZU96RkVOaG9NUURDWHlONlVQS0hCbC9M?=
 =?utf-8?B?d0pQS0xzOE4wMzVpN3orQXh1VVdrWnRGTXBINE85UWRJK2hvSTRTdlYzcVFu?=
 =?utf-8?B?aHdxblB2WEpVZFpxLzhtdGszUk84RGF1ZVBERjVqL0V2UjJSMHIwZC9OZG5T?=
 =?utf-8?B?ZVVrTE5ZWHhwcUtOMWJ5dERpUVZuR29SejhtNFNyWmFhK1VOTjFSVWp5ZHQx?=
 =?utf-8?B?M3k1ZjdKc3hZd2ZWSWQxMmgyNHBISVhhaEpQTUhXR0cydU16K2p2bng3akZS?=
 =?utf-8?B?Y1lFNXFWRE04d2JPYnRJYmo0TnJwS29qNzZiZ25jSTJ6Y2tLVEtsaGlkY0pT?=
 =?utf-8?B?QmZJVVQ3MTFNdlJXSkh0SHZKc0djQmIxc0JVNkNvdStsbU0xclVpcjdBc0Rw?=
 =?utf-8?B?RWNIUU9pOFpNZ0d3KzNiR3V6dHZrcDg1SEF1NFk4NHBwSzlSelNYN053VWor?=
 =?utf-8?B?Z2xqUFJndUxFMzZOYTZyeitNb05FN1lpOWJqSDdIU3BORHRHRU1tUEtZUVUw?=
 =?utf-8?B?MHIzSzZOWG93S2QvaGhKTnlTWTdIUi9penFOSCswVCtDTkRtbXR5RVdoM2lU?=
 =?utf-8?B?RW1iNE9XcWh3R29YZU10OEVtanJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37CCC4C8DED4DF41A843BAD316334CBD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c844da-df8a-466d-692f-08dbe5fe900e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 17:16:10.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FNv6jI4WVByW8OAIzlihrCFeNfiDj6UDYwanfujiGoDVa0S/CIsp+4kOsSVGAdJV1vMzKvFmA4Mjio8lafNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTE1IGF0IDA4OjA0IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA5IE5vdiAyMDIzLCBhdCAxMjoyNSwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToNCj4gDQo+ID4gT24gOSBOb3YgMjAyMywgYXQgMTE6NTMsIFRyb25kIE15a2xlYnVzdCB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gSGkgQmVuLA0KPiA+ID4gDQo+ID4gPiBSZWx5aW5nIG9uIHRoZSB2
YWx1ZSBvZiBkcmVxLT5ieXRlc19sZWZ0IGlzIGp1c3Qgbm90IGEgZ29vZCBpZGVhLA0KPiA+ID4g
Z2l2ZW4NCj4gPiA+IHRoYXQgdGhlIGxheW91dGdldCByZXF1ZXN0IGNvdWxkIGVuZCB1cCByZXR1
cm5pbmcgTkZTNEVSUl9ERUxBWS4NCj4gPiA+IA0KPiA+ID4gSG93IGFib3V0IHNvbWV0aGluZyBs
aWtlIHRoZSBmb2xsb3dpbmcgcGF0Y2g/DQo+ID4gDQo+ID4gVGhhdCBsb29rcyBwcm9taXNpbmch
wqAgSSB0aGluayAtPmJ5dGVzX2xlZnQgY291bGQgZ2V0IGRyb3BwZWQgYWZ0ZXINCj4gPiB0aGlz
Lg0KPiA+IA0KPiA+IEknbGwgc2VuZCBpdCB0aHJvdWdoIHNvbWUgdGVzdGluZyBhbmQgcmVwb3J0
IGJhY2ssIHRoYW5rcyENCj4gDQo+IFRoaXMgZGVmaW5pdGVseSBmaXhlcyBpdCwgc29ycnkgZm9y
IHRoZSBkZWxheSBnZXR0aW5nIGJhY2suDQo+IA0KPiBGaXhlczogOTU0OTk4YjYwY2FhICgiTkZT
OiBGaXggZXJyb3IgaGFuZGxpbmcgZm9yIE9fRElSRUNUIHdyaXRlDQo+IHNjaGVkdWxpbmciKQ0K
PiBSZXZpZXdlZC1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4N
Cj4gVGVzdGVkLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0K
PiANCj4gSXQgY3JlYXRlcyBzb21lIGNsZWFyIGFkZGl0aW9uYWwgd29yayB0byByZW1vdmUgbmZz
X2RpcmVjdF9yZXEtDQo+ID5ieXRlc19sZWZ0DQo+IChJIGRvbid0IHRoaW5rIGl0cyBuZWVkZWQg
YW55bW9yZSkgYW5kIGZpeHVwIHRoZSBuZnNfZGlyZWN0X3JlcV9jbGFzcw0KPiB0cmFjZXBvaW50
LCB3aGljaCBjb3VsZCBiZSBhIGZvbGxvdy11cCBwYXRjaCBvciBnZXQgZm9sZGVkIGluLg0KPiAN
Cg0KVGhhbmsgeW91ISBJJ2xsIHF1ZXVlIHRoYXQgcGF0Y2ggdXAgc28gaXTCoGdldHMgaW5jbHVk
ZWQgaW4gdGhlIG5leHQNCmJ1Z2ZpeCBwdWxsIHJlcXVlc3QuDQoNCkkgYWdyZWUgdGhhdCB3ZSBz
aG91bGQgZ2V0IHJpZCBvZiB0aGUgYnl0ZXNfbGVmdCBmaWVsZC4gV2UgY2FuIHF1ZXVlDQpzb21l
dGhpbmcgdXAgZm9yIHRoYXQgaW4gdGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
