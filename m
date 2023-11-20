Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337EA7F09FC
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 01:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjKTAQr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 19:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKTAQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 19:16:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426D13A
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 16:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB1eSelwxCdncxh07hfO/PUrfLMOIA8vMHcbLPXQqdjweHR3oikPxOItx1rGgUCMsHV2kenTACHIfOn8YanyybrlX8V2IpylrYwN0yn5OuG+cOlXIF4UC8ZIuSUhsj2Pf/JEk2Yo8aDbBssWO0tviEi9ThHgu4K9mnnVsSVRjWfyflEwZZbD4ZJgEvb+T05v9Mf78eLEEvfkaAl8PX97WAesXePU0eSq73NDc1WL4KPn1R/ULPYqvBk04kpcF+d95MKW2N1rSw3lscKw8xHcbTO07fJcLnLEwD5gaP/l/PrHJZesRrSp6suNzI3hw6mORqWfKo7FyaezkmGp44VyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JpQgh8Qb0xRYIWyj8mhZE0MCn8P2oWwHAG5Gh+m2Ww=;
 b=U+DE/rOaQ5Qp1EZbP5bSrqL4f9VlzI11OBpvp4UPyuwJ42yOSbr0qCPwCH/4EuiC+w4iBRE8l6KDsJglU3N1+uqQ9p5pkGHOu7amXE/Ou0s09YjjM+yrnnl2GnLgq+zcCIL7t0gIjr6jncMG5EjHAyIurF5kNQGAV2fsTHty7r91huu1swpRJQo3R0haW0/YVMnyX24uvSMHy0lCUxqbT7aC6py2Wd8hDyMvzirZHFsU9+jLeIvVVlSZkCVxDjwUvTNdpKj11J8AH5X1jMutG+nwvD4SpjkGUCU9J2Fj1tEr7XT5+8yB0ZVC3xBlhiqn+aQ2j8QEvQDRr+UBSyXn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JpQgh8Qb0xRYIWyj8mhZE0MCn8P2oWwHAG5Gh+m2Ww=;
 b=KwgFQbdWwHyf1YHPG+IuKTcTKg7Nyp8kVfNeGyTgoRmjzAlxlaQA3U2TQ/FPdcCpYvMj1raAx4ZBfWOw15QYok5veNXWu3NpnRXlKjc8K3WpNiiQI4XYX+RwIX0FF1pbTPgb3bOnTVdktxtlVoFs28xcRcAG2RBp9n8TBkZy6Y4=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by BY5PR13MB3684.namprd13.prod.outlook.com (2603:10b6:a03:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 00:16:37 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 00:16:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "steved@redhat.com" <steved@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSm5IPgy8h3QmEuPQMOdkvJBtLB/omOAgACnlYCAAAIBgIAAA/eAgAA+KgCAAc03gA==
Date:   Mon, 20 Nov 2023 00:16:36 +0000
Message-ID: <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
         <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
         <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
         <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
         <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
         <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
         <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
         <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
In-Reply-To: <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|BY5PR13MB3684:EE_
x-ms-office365-filtering-correlation-id: 4a59d2a1-f83a-40c3-0a8d-08dbe95df5b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVSa+Dr6Y0wzH7hgDzXRRLK3QeQRt7KrpYgtDORsdwTJ+TRL0E7VZ+DIKuGoG7QFG/2fBqEVdHvTNlcikE7xxEsnSi8UXQrBn3wAzfEEPvNK3m1Ygz4bWDyEVsQPVHZ9nlDbZbA9yf5+vIhNZvQrOCwtD4cc08H9WPyN/AL/v2uN2usAvFvducWcKtRGGriGEB0D1uv+Vgi60KBVwATaB0okTOQsV2ufMdu6sGuIESyZHW2zQgnNMlSrLkfppFkM99guEJtChFJXHzv/OCGyCQqgRNrZ+Jlotxa5MHtBPmLcs4+9oyaV7DOUDmxHy5jnXcdFSd9XwTn9PIV+dT2PFPL6TmpCZp7xBH9cV9ON8B1xcKhknvtDSscM+BQR89lhxz4fVpZT3pXqZlGoFYMH3ajHBaadnM7zSVdfdDqI9/duvOswW9BtGtSNtKcej5rfGTxcmGI3qcuqXH6+sKEgno48QDGfOLBPZzovOGq2gjX0K2IQQOwPRFRK6DZbPeBr3Chs6jUqS2cGDuJRIqFDHNXFVzAZxp7T+0ZyncX3gYQbBeizapo93SY8X66051g9g34XuCtZgD+anUA2cAFOVzt7W+VUDDp5Da19QDKS9kh47Pg9+hB0781tEsuy6GlBCvDXkPpA3oA9sgkx2rGgaxZPrfnCSiXRQuAxYe9wNKNjSivQt1NZBpi/ffA9lV8cjoZCWUbab96UhG6m1TtBnncnl+XRcG9MeFrSHIKVtlw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(366004)(396003)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(2906002)(15650500001)(86362001)(71200400001)(6506007)(478600001)(53546011)(2616005)(26005)(6512007)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(4326008)(36756003)(6486002)(110136005)(91956017)(76116006)(122000001)(38100700002)(83380400001)(38070700009)(41300700001)(4001150100001)(66899024)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi9TS20zYkJFeDI3SGt0RmdQTnFvV3M4eUtZaG45ODAzd0x0MkRiUUtnYy9T?=
 =?utf-8?B?M3VxSkt0K0dIN1NKM1hsY1JPVGY3QjlkdzE3Wmp5ZzU2cVd0Nkl2ZFNEMTdo?=
 =?utf-8?B?RURtcENyZGFuUGlZVTc0UWNwL1l3YnFHT215SklRdkFmb2s5QTRNcER2MmJP?=
 =?utf-8?B?YWlYWmU3SUZsVlBqTytMVDJWay93ekhBZUJtTi9oQ0Q1Zlh1a0p0KzRnUXVT?=
 =?utf-8?B?V0R6Nzl2bHhnN2YvY0VmV3dteVNBOFl6WHdIVktpTGNCdHYyUFpYYkpPYlUz?=
 =?utf-8?B?dkpsSU5wMnk2RG1XT0F3NTlIdlFWZWhvY2E5cHdCSk14TmVKRlNjSlBZMDNt?=
 =?utf-8?B?Y0UySmZZdDlmQjcreUo5dEx5dFY3MEROZnBQZWZyNGNpYkpnV2JlUnV1dU9O?=
 =?utf-8?B?dFFndHd3NWNlV2dsSFJPODA2MFdGcmNhOW53ZlB4cnFiVGp0QlRiL1ZOWllv?=
 =?utf-8?B?S1dMTkJkTEtCYUh6dGhTVXUxWFlXWklFY1BXZUZYNkVQc0NNZTk4SEdXd1Vw?=
 =?utf-8?B?YlhjWE5IR2tzenozbExySzVxRFBESnVseXhVMTE2TERDOS92ekdGVDR6MVV4?=
 =?utf-8?B?djRpOWxWQ0ZXaUdORlY5U3pYa09YNGxsVThLcW1DSnB4TFdYVmx1c0R5OXJp?=
 =?utf-8?B?amNYRkR4dkU3dEV1N3BXaWNZME1kancxdGpFSy81allYcVNRU0dSWDVVTkp4?=
 =?utf-8?B?Y0JaWE5KakVZeXVrcnNJMWUyYkZLWmV5Qjg1a0VVdWpwWmdjUlJ6NnNCYXdT?=
 =?utf-8?B?bC9ONTJYNlZiVGs2SWo5d01iVlM5YThEdWpJbDFZRVdadCtIT1YreGlFcnRt?=
 =?utf-8?B?ZDdBZ3M3Rk1oeUpJREx3TTNmQVZHVnFudkQwNlI4ZmRsS3hOMDFyNWlTNXVL?=
 =?utf-8?B?T3UzQmdidVhuMzBrcXJTbHM0NDI0Q3Z2YUM2Tm1iclp0WXFzb09ib2pIeE8z?=
 =?utf-8?B?eXFmanczWkY1dzhnTkJ2dGErUGFTQzg3bExGNzFrT2xucUg3ZG0rQUJJTXh2?=
 =?utf-8?B?VlUzM2NiQmoyU2NVMFMxejhDSmN0SldSSWNhSlBEZmxWb3l0VXc0Mm9VMEdK?=
 =?utf-8?B?cW9YTU9EME9lYjJnc0UzRUlZTkVXUkVaOXFZQTc4VzRzVkh6Z3BUclEyVDNJ?=
 =?utf-8?B?aStISUp0V0M4QkVmSk9GaDhXWFJUUjM4Z2hLRTM0akNIQlBBS0hYZ28xL2lu?=
 =?utf-8?B?ZFRVZlRPRm5qbTZRWUkreVIzNjNhVko0cEEwV1BNWXE1enlRU1p3TytTb2pF?=
 =?utf-8?B?V0ttNHJSbTZiekNDSnBsNXJyZjkzU3FQWXlIVGw3S0VzRy94d09lazU5UG9r?=
 =?utf-8?B?RlF4UGU2Rit3TnN2dllLNk1EYkpTU1loWlVUbFFLb3haVWJmRndIc1lvTnFh?=
 =?utf-8?B?QmUwRkVheWNCT3ZzeVhJMVcxRXlvcnluc0hTTXprOFRtYmpMdmw2ZWN4MUhl?=
 =?utf-8?B?cDM4d1h3OWpjS1FLWU50TnJHMkJrUFNOcTZHUmQ3Nkp3UzFpV2NPVnVnUkkx?=
 =?utf-8?B?Lzg1YXkzUElqSlV2K2NZZ21acVdycXNxbkV3QmJ6bFdGOTdYWWg5N212WDZh?=
 =?utf-8?B?TmNBR3JvVEkyQTNqdUtWaEhaTk1rWkpSL2gyYWdSVTk1QndUMXp6d1VMNDlj?=
 =?utf-8?B?Uis1L0JiWUFKYkswT0Y3UXIrc0tHWm5SbFdXbWdXTlJUWnMvcFh3cm9xd2VJ?=
 =?utf-8?B?bmIxOVhSbGFXeUY2V3B6OGpJYjMvYUpPMnVnQ0lxcEdWMXF1MXBhTk5BR3Jo?=
 =?utf-8?B?ampGZFl6dmJlSitWT3ZFdU54Q3JDb3I3Um5GQ1R0UWdJWG81TGlPNGhLdkRx?=
 =?utf-8?B?ZThRd1F4bFREeUpkdDdHN0ZWdTdlUXZYTVUxSHBxcHBNcWxRdVRRUjhIT2c4?=
 =?utf-8?B?cWVPeTNmcTNwSGQ1NnhuUWc1bWR4aDN6QzdTSElmVjZXcllpcVEzTkFTTk5Q?=
 =?utf-8?B?Sko2R2pncnh2YnFxQ3RSQkpHOUhkMmx4My9aYy90NmxPMWdHbGRHS0p4M2t6?=
 =?utf-8?B?WDRYZm5Eam1rbTBZTUtKUVpkWVJvZ01KUjRzeDJEZVV5QWlRbEZsQlBqYXNQ?=
 =?utf-8?B?cjJwbVlKaUZVV2dvbFlSd1FReGNwOEJCd3QxYzI2WFFnUStXaUNUd0c2Nk5p?=
 =?utf-8?B?OUdPNnFHcUp1Mk43cGhpNnJqeUw1UkpHYXRydHo5V3NaRGNMb0ZIVmJ5ekZp?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B2B3413B9722841933708B618D4228D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59d2a1-f83a-40c3-0a8d-08dbe95df5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 00:16:36.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0GK5Zp12fsVOAVSreFPHDrNb+44AtctQqk98PqqvrcnXo4PnnJmfIzPHd56l8RyP203cuBBvf/0U0EDIQVX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIzLTExLTE4IGF0IDE1OjQ1IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDExLzE4LzIzIDEyOjAzIFBNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+
ID4gDQo+ID4gPiBPbiBOb3YgMTgsIDIwMjMsIGF0IDExOjQ54oCvQU0sIFRyb25kIE15a2xlYnVz
dA0KPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
T24gU2F0LCAyMDIzLTExLTE4IGF0IDE2OjQxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTo0MuKAr0FNLCBDZWRy
aWMgQmxhbmNoZXINCj4gPiA+ID4gPiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gRnJpLCAxNyBOb3YgMjAyMyBhdCAwODo0MiwgQ2Vk
cmljIEJsYW5jaGVyDQo+ID4gPiA+ID4gPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBIb3cgb3ducyBidWd6aWxsYS5saW51eC1uZnMu
b3JnPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFwb2xvZ2llcyBmb3IgdGhlIHR5cGUsIGl0IHNo
b3VsZCBiZSAid2hvIiwgbm90ICJob3ciLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1dCB0aGUg
cHJvYmxlbSByZW1haW5zLCBJIHN0aWxsIGRpZCBub3QgZ2V0IGFuIGFjY291bnQNCj4gPiA+ID4g
PiBjcmVhdGlvbg0KPiA+ID4gPiA+IHRva2VuDQo+ID4gPiA+ID4gdmlhIGVtYWlsIGZvciAqQU5Z
KiBvZiBteSBlbWFpbCBhZGRyZXNzZXMuIEl0IGFwcGVhcnMgYWNjb3VudA0KPiA+ID4gPiA+IGNy
ZWF0aW9uDQo+ID4gPiA+ID4gaXMgYnJva2VuLg0KPiA+ID4gPiANCj4gPiA+ID4gVHJvbmQgb3du
cyBpdC4gQnV0IGhlJ3MgYWxyZWFkeSBzaG93ZWQgbWUgdGhlIFNNVFAgbG9nIGZyb20NCj4gPiA+
ID4gU3VuZGF5IG5pZ2h0OiBhIHRva2VuIHdhcyBzZW50IG91dC4gSGF2ZSB5b3UgY2hlY2tlZCB5
b3VyDQo+ID4gPiA+IHNwYW0gZm9sZGVycz8NCj4gPiA+IA0KPiA+ID4gSSdtIGNsb3NpbmcgaXQg
ZG93bi4gSXQgaGFzIGJlZW4gcnVuIGFuZCBwYWlkIGZvciBieSBtZSwgYnV0IEkNCj4gPiA+IGRv
bid0DQo+ID4gPiBoYXZlIHRpbWUgb3IgcmVzb3VyY2VzIHRvIGtlZXAgZG9pbmcgc28uDQo+ID4g
DQo+ID4gVW5kZXJzdG9vZCBhYm91dCBsYWNrIG9mIHJlc291cmNlcywgYnV0IGlzIHRoZXJlIG5v
LW9uZSB3aG8gY2FuDQo+ID4gdGFrZSBvdmVyIGZvciB5b3UsIGF0IGxlYXN0IGluIHRoZSBzaG9y
dCB0ZXJtPyBZYW5raW5nIGl0IG91dA0KPiA+IHdpdGhvdXQgd2FybmluZyBpcyBub3QgY29vbC4N
Cj4gPiANCj4gPiBEb2VzIHRoaXMgYW5ub3VuY2VtZW50IGluY2x1ZGUgZ2l0LmxpbnV4LW5mcy5v
cmcNCj4gPiA8aHR0cDovL2dpdC5saW51eC1uZnMub3JnLz4gYW5kDQo+ID4gd2lraS5saW51eC1u
ZnMub3JnIDxodHRwOi8vd2lraS5saW51eC1uZnMub3JnLz4gYXMgd2VsbD8NCj4gPiANCj4gPiBB
cyB0aGlzIHNpdGUgaXMgYSBsb25nLXRpbWUgY29tbXVuaXR5LXVzZWQgcmVzb3VyY2UsIGl0IHdv
dWxkDQo+ID4gYmUgZmFpciBpZiB3ZSBjb3VsZCBjb21lIHVwIHdpdGggYSB0cmFuc2l0aW9uIHBs
YW4gaWYgaXQgdHJ1bHkNCj4gPiBuZWVkcyB0byBnbyBhd2F5Lg0KPiANCj4gSWYgeW91IG5lZWQg
cmVzb3VyY2VzIGFuZCB0aW1lLi4uIFBsZWFzZSByZWFjaCBvdXQuLi4NCj4gDQo+IFRoaXMgaXMg
YSBjb21tdW5pdHkuLi4gSSdtIHN1cmUgd2UgY2FuIGZpZ3VyZSBzb21ldGhpbmcgb3V0Lg0KPiBC
dXQgcGxlYXNlIHR1cm4gaXQgYmFjayBvbi4NCj4gDQoNClNvIGZhciwgSSd2ZSBoZWFyZCBhIGxv
dCBvZiAnd2Ugc2hvdWxkJywgYW5kIGEgbG90IG9mICd3ZSBjb3VsZCcuDQoNCldoYXQgSSBoYXZl
IHlldCB0byBoZWFyIGFyZSB0aGUgbWFnaWMgd29yZHMgIkkgdm9sdW50ZWVyIHRvIGhlbHANCm1h
aW50YWluIHRoZXNlIHNlcnZpY2VzIi4NCg0KU28gaGVyZSBpcyB0aGUgZGVhbDoNCg0KSSB3aWxs
IHR1cm4gdGhlIGJ1Z3ppbGxhIGJhY2sgb24sIGhvd2V2ZXIgdW5sZXNzIEkgaGVhciBzb21lb25l
IHBpcGUgdXANCnRvIHNheSB0aGF0IHRoZXkgYXJlIHdpbGxpbmcgdG8gd29yayB3aXRoIG1lIHRv
IG1haW50YWluIHRoZXNlDQpzZXJ2aWNlcywgdGhlbiB0aGUgYnVnemlsbGEgYW5kIHRoZSB3aWtp
IGdldCB0dXJuZWQgb2ZmIHBlcm1hbmVudGx5IG9uDQoxc3QgTWFyY2ggMjAyNC7CoFRoZSBnaXQg
cmVwbyBpcyBub3doZXJlIG5lYXIgYXMgbXVjaCB3b3JrIGFzIHRoZSB3aWtpICsNCmJ1Z3ppbGxh
IHRoYXQgcmVxdWlyZSBvdXRib3VuZCBtYWlsIHNlcnZpY2VzIGFuZCBhbnRpLXNwYW0gbWVhc3Vy
ZXMsIHNvDQpJIGRvbid0IHNlZSBhIG5lZWQgZm9yIGhlbHAgd2l0aCB0aGF0LCBhbmQgYW0gaGFw
cHkgdG8gY29udGludWUNCm1haW50YWluaW5nIGl0IHdpdGhvdXQgYW55IGZ1cnRoZXIgaGVscC4N
Cg0KSSdtIGFsc28gaGFwcHkgdG8gY29udGludWUgZmluYW5jaW5nIHRoZSBzaXRlIHdpdGhvdXQg
bmVlZGluZyBmdXJ0aGVyDQpoZWxwIGZvciB0aGF0LiBUaGlzIGlzbid0IGEgcXVlc3Rpb24gb2Yg
bW9uZXksIGJ1dCBvZiBjb21taXRtZW50IGZyb20NCnRoZSBwZW9wbGUgd2hvIGNsYWltIHRoZXkg
bmVlZCB0aGUgcmVzb3VyY2UuIEkgbm8gbG9uZ2VyIGhhdmUgdGhlIHNwYXJlDQp0aW1lIHRvIGVu
c3VyZSB0aGF0IGNvbW1pdG1lbnQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
