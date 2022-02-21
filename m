Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16554BEC21
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 21:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiBUU4R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 15:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBUU4Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 15:56:16 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2111.outbound.protection.outlook.com [40.107.236.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E9237F4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 12:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhwMox9EsUEsGu/Zd8TjcXeGQWcyWijoF0y5vfjQFGVAY3RKH1Pc/QW2b2H7a+TPTuI3UrPm3K5HVxj6G9pS69x7OgNDgz2IHxcw4Km7B/9RxhF+ipWAYeZTRRuutRJjIbMYpgT6o7Pfh9MnrfGF+bn2CRbCg8/56P94SHIyW2tM96Hi91MeSy9Jyqf5WF/33GRixaMKqx6V/7VcDUuncQZOa2di1kB+p7sar7h6ENu915rRxV4oP9N11zi7M6zgV+4DbhWOu1ekfY48DdK18qNAdoWfDn8jBCioxiB09TURZapfCI1jlqRvNyVTywiwj2gE6vbBc+U8AgsNlIMzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVKCRlT+E6Kf3rvPs4WM6pN+uPpXv+gfacX9MlSbyzY=;
 b=foXQXyjcQ4JB5p5Mh8ucH7GEA1amxQOP9URW42TDkFfZIXmzOC2YS8RMppTPgbAwuZQM3d0NYaeb6eqs7gH7gGCRAdYtbDpoWzNWA8MoU/T+YbJhKUjlaVPTVeiU3GD1E6HE/UiHvlFX3b+24fjC+FdtxM3G1+7GHxFmomglo4uqF9UfST0Q+Bt/1Z7nmVCuJhS9Vy5aVPxV3IWk17NDmh5z9cG3WA3ZPqIXzmIqdO1pCMBOrBatxt/I8G3Yi6lqa4Bt9KpQa9pVe1xoQO4Z+t+MC2IcT6l6aRF7l2YkADCLWS9GqrvUbPeDSdOR9NqUCicS0pDI/5cA1uYzpFT0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVKCRlT+E6Kf3rvPs4WM6pN+uPpXv+gfacX9MlSbyzY=;
 b=cCmyiFS/jl+eGKNBIXilCf9efoPDsY2BoXfNYbrbCh8w8fezv6qh/mf04wGxXMVoQDUEf4SZE6PAlKRLt1AEe3Ng4AppnjWZfHfRJdzeRxdDDXKUn+mbnj6mXm2/GH9np0VRBmpjavsf9Q9fWDPppC9dkmi5BvHAo62p/wqHUOU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1566.namprd13.prod.outlook.com (2603:10b6:300:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.20; Mon, 21 Feb
 2022 20:55:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.021; Mon, 21 Feb 2022
 20:55:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQCAAAazAIAACUeA
Date:   Mon, 21 Feb 2022 20:55:48 +0000
Message-ID: <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
         <20220221160851.15508-2-trondmy@kernel.org>
         <20220221160851.15508-3-trondmy@kernel.org>
         <20220221160851.15508-4-trondmy@kernel.org>
         <20220221160851.15508-5-trondmy@kernel.org>
         <20220221160851.15508-6-trondmy@kernel.org>
         <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
         <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
         <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
In-Reply-To: <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 424ab320-d1a5-4c76-f2bb-08d9f57c89fa
x-ms-traffictypediagnostic: MWHPR13MB1566:EE_
x-microsoft-antispam-prvs: <MWHPR13MB15668A597736732EAF937802B83A9@MWHPR13MB1566.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQBt0ngCxCwDC6/+JA5Q8mWM+oFhB+L6fbeI8tgTAhRfrP+fr4URpJMWy3Z2QxBjO3WpZckNejLJAD5uSHKU7mydKFTG+TDX2cMs6fqQ3d+OmWrH9OgJV8mL/4YABZbGR+w9C3qZpgXiI+gt3M63YkR7x2h08b2jJC0RGmOMiUdcEHjzUtTARQrRbX4/AfWFckqUB9rk38EnqMWAWwpwmnGejkLqXm7ZkWOE92qkM5LxM9CJoW5PAjCX7d8F+4XYlv1ndYH7Brn7GZG7mXWFYhIzd/dg9/i7nNHNIg2y3cI7EDfWF6SgmO36/UkA1EcL5y4eN4uSD7DvyaI2ebMHM0cqoCoYN0U1TFkZ0Qxd8wWU55WvHHTXvVjkX7GOPOaQTUcV338QFUJt7Ir3tlCUrYZAUH4p2QykmyJz8jlV4/SdzYnMFW+P3s9Ca4j8lBHuX20NcLrKscezYjiLHFY95e8+Y86wjL4eXk1ajZk+iYCq9jOX4gNWH3Y83G82DIPtz/ttVtEBxllyc9uF9YM19+tlrj3QhA58RH/mj2C61eURDwQp6dI3+Zfn+Jze43bhosFF1k1yqBDpSul29qF5FKLrLRAXTCU1T13UnRYlPFTN7Pii5U7vYd0rAXNZk5h/BApKTG+wiOj4AVqaOdPp+78LVa6RPUHKO5xa1Nal6OYCxOa85ggkhgYVZEfg/mbBSIJ3Gb8GY7WkCjium9w8Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(2906002)(5660300002)(6916009)(6512007)(36756003)(6506007)(316002)(83380400001)(66946007)(71200400001)(186003)(8676002)(508600001)(38070700005)(8936002)(122000001)(6486002)(26005)(38100700002)(53546011)(66556008)(66476007)(66446008)(64756008)(76116006)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWVnUUdxTkpDNUg5MGdBNktRck1CSG80MVJWNlh4R3dnYno1VlhsS3dQcEJx?=
 =?utf-8?B?ZlFNdjNqbXFlT1RXOHdEYW92blBMRExNdllJWjJGVlZFYnNTOGFLeStsbDJJ?=
 =?utf-8?B?bVpQM05udVJMMHZuUmFqVm5CRW5yQnQ1cG9aejAyUEhGeXZSdkpyVDYrU0pX?=
 =?utf-8?B?T0JNd2d1RE5HRWxNajNabEZhMm1yb2FyT2Q5NTRld0ZLcGRudVpnTUh2Q1J6?=
 =?utf-8?B?Y09rSXpCajQ1aTQxcit1ZVZPbnE5N3Rkc0h2b2hidE9yVHRybjgzWVZpQytE?=
 =?utf-8?B?MnFZUmFybmY3Ump4Z0M3TTJuV1RPQ2laK3dvbzJHa0htQTNoUUM3VzVlek9S?=
 =?utf-8?B?K0RvY0QrOEVpWUl5bExqMUEzOXdUdndIY2FleUU2OWh4K3o1N3Z3QnV2SnZv?=
 =?utf-8?B?L2hMbnpRV25pRkZrbEt3QXVJb050QlRHVFlKVW45VUowMWRxUHlvRU9tZE81?=
 =?utf-8?B?NXpiSHRtSVJLUnV4N3dYck1oM05QZU5HY2pZQXI0UXY1UjV2d09ITmRHanRk?=
 =?utf-8?B?eDl0VzJOa0pnZXFyZkdhM0VFRXNzdjhPMnUvUllDVmZjMTNXOGhRN2kyZmZY?=
 =?utf-8?B?WnIxSGNtUFBRcXJlV1haMzRIc2o4bnZpcDNjNmpML0ErcDlpVHBIU0N6VitE?=
 =?utf-8?B?K2dSV0NQbE5BK1JnRmtvY2tuVmx2cVVxQ05lUnlsZ2VXdjBDc1BKbFY0RHEx?=
 =?utf-8?B?K1FoNGxFSG1yM2xkTkNZTzdpcllKY2xiajJmaUZqNWdJZVJQdWhpSUZSRVVk?=
 =?utf-8?B?S0hXaU90TkFDN0RGRms0amhBWTlJSEJEMjVkUDM1Nlh0TGR4eFluUGd5aXdY?=
 =?utf-8?B?RzAwWTFoYnhNVzlCeWkvZ2pnbDJKbU9VNWE3dGV1WUl6eHpTSURXUUthVFpl?=
 =?utf-8?B?d0V2UlFJZHNnOXJOWFE1R3ZyckVrODkrN2xPYm1EQU5ZQzRzOXlvOU93eTBV?=
 =?utf-8?B?WXloZUdKOXM1MExBSCtyQmNneFZUdnlabWFEenp3dnJkemszL0tSa0RWb1hH?=
 =?utf-8?B?N2ZqNS9KNXlrYlEybkcwOXpGVSs4THZYdkJ3My9obWUrMnpQaW11SVhmazhr?=
 =?utf-8?B?QytwRUxNNzJHWXAvSWJ3Rk4xNVkvdXA4czRYWExRY08vWFRobklBdHRCa21C?=
 =?utf-8?B?eXlEYzVkaWorQmJmOTNUbzhNdnQ2YTRncTZmSEVMS3BXbGNYelpTNnBDL2Va?=
 =?utf-8?B?SEhzWlhKS0lwc2Q4c0M5T2RFRGlxbzZBdzc3UHFaaGJxK1gvUnVvUjJmVDNw?=
 =?utf-8?B?OCtsWVVUcTRZTm9hOU1TMG40Sk5EWktBMG05a2xud0sxMk9lUDRuR3ZRVURO?=
 =?utf-8?B?Vlcwck9GeWxrcVZja2Z3K09lZUhsWFZ5OGltdzd6THNGR0VVT0YrZnZRUkVp?=
 =?utf-8?B?b2VraXB2ZWdyVVJWTmJWaXoxeVh6TXNkZDlzcytPMU5hSmhwL09jZmtTci95?=
 =?utf-8?B?QzR5MmwvVVF6YlBVaHA1Q2RPVnFvdGZzeEFOL1VETmpxSXVLYTcxNE1qajZ0?=
 =?utf-8?B?bXJZTUJadmhybmRhWm40SWdYejIrbnhvd3MwbjdpVnJsR0lCaXR5NUxSN0Fv?=
 =?utf-8?B?cXpPK0E0V0h5Nm1JRGVkMkZzOWdkY09kV1FDVVJ3QkwzWEY3VGpta1JETWJK?=
 =?utf-8?B?dSsyZjNnUHhDSzZZYW9uMVJPdUZad2hYZS9jM3hzZkd0aXZrWUoxSTFYQS9Y?=
 =?utf-8?B?Tm1oeTh6WWhlNTMzRjc3ZEZDcnA0ZERwdHppRXBRL1h1UTQzWVFMMlFCWDd5?=
 =?utf-8?B?bS9tclZ3ZWoxY2NvUTdyMmRDUE1MQ0g0Njh6VWhibnE4Q0EvdS9NMm1MSUF6?=
 =?utf-8?B?UUZYcGxNZzJvNVVaVUcwZU1jN2lUT1dwYzhqVVNQaVJOS2wydHVVRVpiOCty?=
 =?utf-8?B?NGQrYVB0QThrYUFySjVUMDNTZWJIU2o4Z003YURrRkllUWNlY3VSTE1XWWtv?=
 =?utf-8?B?WHlKQ1FUMTY3cnE4OGhOTVlIUi9GKzhVelZteW9xSWR1NGFtYk5kQzVtaGV2?=
 =?utf-8?B?OWE1cFlRcnVMUGgwY3h2dHBPbHp1a1VEY2NrS29wbVBSUFZSc25VdnNJY2lR?=
 =?utf-8?B?b0JxeHBRMlQ1MGNSbWdWczBUNTA4bFBJUmdWMDUrV1BLTktHM0wzeE5qT0JC?=
 =?utf-8?B?NkhDdXlqSk1EMHRoK0tsOExhUnp3VDJsclV4R0p2TEVZWXFrbHpodVBVZ25X?=
 =?utf-8?Q?TZt9bEJ5Um5rxLwF7NRL10c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3119394F88FD9841A119F6BFD44E6AAB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424ab320-d1a5-4c76-f2bb-08d9f57c89fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 20:55:48.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z5IANUh50mqcG5nGaw7QBXBSD551kp1shdaFszACHFS8gJVR3h+aTrfV0FGxsHrTB4zzoadCYBR14NuG6EuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTIxIGF0IDE1OjIyIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMSBGZWIgMjAyMiwgYXQgMTQ6NTgsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gTW9uLCAyMDIyLTAyLTIxIGF0IDExOjQ1IC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjEgRmViIDIwMjIsIGF0IDExOjA4LCB0cm9uZG15QGtl
cm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoZW4g
cmVhZGluZyBhIHZlcnkgbGFyZ2UgZGlyZWN0b3J5LCB3ZSB3YW50IHRvIHRyeSB0byBrZWVwIHRo
ZQ0KPiA+ID4gPiBwYWdlDQo+ID4gPiA+IGNhY2hlIHVwIHRvIGRhdGUgaWYgZG9pbmcgc28gaXMg
aW5leHBlbnNpdmUuIFJpZ2h0IG5vdywgd2Ugd2lsbA0KPiA+ID4gPiB0cnkNCj4gPiA+ID4gdG8N
Cj4gPiA+ID4gcmVmaWxsIHRoZSBwYWdlIGNhY2hlIGlmIGl0IGlzIG5vbi1lbXB0eSwgaXJyZXNw
ZWN0aXZlIG9mDQo+ID4gPiA+IHdoZXRoZXINCj4gPiA+ID4gb3Igbm90DQo+ID4gPiA+IGRvaW5n
IHNvIGlzIGdvaW5nIHRvIHRha2UgYSBsb25nIHRpbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZXBs
YWNlIHRoYXQgYWxnb3JpdGhtIHdpdGggc29tZXRoaW5nIHRoYXQgbG9va3MgYXQgaG93IG1hbnkN
Cj4gPiA+ID4gdGltZXMNCj4gPiA+ID4gd2UndmUNCj4gPiA+ID4gcmVmaWxsZWQgdGhlIHBhZ2Ug
Y2FjaGUgd2l0aG91dCBzZWVpbmcgYSBjYWNoZSBoaXQuDQo+ID4gPiANCj4gPiA+IEhpIFRyb25k
LCBJJ3ZlIGJlZW4gZm9sbG93aW5nIHlvdXIgd29yayBoZXJlIC0gdGhhbmtzIGZvciBpdC4NCj4g
PiA+IA0KPiA+ID4gSSdtIHdvbmRlcmluZyBpZiB0aGVyZSBtaWdodCBiZSBhIHJlZ3Jlc3Npb24g
b24gdGhpcyBwYXRjaCBmb3INCj4gPiA+IHRoZQ0KPiA+ID4gY2FzZQ0KPiA+ID4gd2hlcmUgdHdv
IG9yIG1vcmUgZGlyZWN0b3J5IHJlYWRlcnMgYXJlIHBhcnQgd2F5IHRocm91Z2ggYSBsYXJnZQ0K
PiA+ID4gZGlyZWN0b3J5DQo+ID4gPiB3aGVuIHRoZSBwYWdlY2FjaGUgaXMgdHJ1bmNhdGVkLsKg
IElmIEknbSByZWFkaW5nIHRoaXMgY29ycmVjdGx5LA0KPiA+ID4gdGhvc2UNCj4gPiA+IHJlYWRl
cnMgd2lsbCBzdG9wIGNhY2hpbmcgYWZ0ZXIgNSBmaWxscyBhbmQgZmluaXNoIHRoZSByZW1haW5k
ZXINCj4gPiA+IG9mDQo+ID4gPiB0aGVpcg0KPiA+ID4gZGlyZWN0b3J5IHJlYWRzIGluIHRoZSB1
bmNhY2hlZCBtb2RlLg0KPiA+ID4gDQo+ID4gPiBJc24ndCB0aGVyZSBhbiBPUCBhbXBsaWZpY2F0
aW9uIHBlciByZWFkZXIgaW4gdGhpcyBjYXNlPw0KPiA+ID4gDQo+ID4gDQo+ID4gRGVwZW5kcy4u
LiBJbiB0aGUgb2xkIGNhc2UsIHdlIGJhc2ljYWxseSBzdG9wcGVkIGRvaW5nIHVuY2FjaGVkDQo+
ID4gcmVhZGRpcg0KPiA+IGlmIGEgdGhpcmQgcHJvY2VzcyBzdGFydHMgZmlsbGluZyB0aGUgcGFn
ZSBjYWNoZSBhZ2Fpbi4gSW4NCj4gPiBwYXJ0aWN1bGFyLA0KPiA+IHRoaXMgbWVhbnMgd2Ugd2Vy
ZSB2dWxuZXJhYmxlIHRvIHJlc3RhcnRpbmcgb3ZlciBhbmQgb3ZlciBvbmNlIHBhZ2UNCj4gPiBy
ZWNsYWltIHN0YXJ0cyB0byBraWNrIGluIGZvciB2ZXJ5IGxhcmdlIGRpcmVjdG9yaWVzLg0KPiA+
IA0KPiA+IEluIHRoaXMgbmV3IG9uZSwgd2UgaGF2ZSBlYWNoIHByb2Nlc3MgZ2l2ZSBpdCBhIHRy
eSAoNSBmaWxscyBlYWNoKSwNCj4gPiBhbmQNCj4gPiB0aGVuIGZhbGxiYWNrIHRvIHVuY2FjaGVk
LiBZZXMsIHRoZXJlIHdpbGwgYmUgY29ybmVyIGNhc2VzIHdoZXJlDQo+ID4gdGhpcw0KPiA+IHdp
bGwgcGVyZm9ybSBsZXNzIHdlbGwgdGhhbiB0aGUgb2xkIGFsZ29yaXRobSwgYnV0IGl0IHNob3Vs
ZCBhbHNvDQo+ID4gYmUNCj4gPiBtb3JlIGRldGVybWluaXN0aWMuDQo+ID4gDQo+ID4gSSBhbSBv
cGVuIHRvIHN1Z2dlc3Rpb25zIGZvciBiZXR0ZXIgd2F5cyB0byBkZXRlcm1pbmUgd2hlbiB0byBj
dXQNCj4gPiBvdmVyDQo+ID4gdG8gdW5jYWNoZWQgcmVhZGRpci4gVGhpcyBpcyBvbmUgd2F5LCB0
aGF0IEkgdGhpbmsgaXMgYmV0dGVyIHRoYW4NCj4gPiB3aGF0DQo+ID4gd2UgaGF2ZSwgaG93ZXZl
ciBJJ20gc3VyZSBpdCBjYW4gYmUgaW1wcm92ZWQgdXBvbi4NCj4gDQo+IEkgc3RpbGwgaGF2ZSBv
bGQgcGF0Y2hlcyB0aGF0IGFsbG93IGVhY2ggcGFnZSB0byBiZSAidmVyc2lvbmVkIiB3aXRoDQo+
IHRoZQ0KPiBjaGFuZ2UgYXR0cmlidXRlLCBwYWdlX2luZGV4LCBhbmQgY29va2llLsKgIFRoaXMg
YWxsb3dzIHRoZSBwYWdlIGNhY2hlDQo+IHRvIGJlDQo+IGN1bGxlZCBwYWdlLWJ5LXBhZ2UsIGFu
ZCBtdWx0aXBsZSBmaWxsZXJzIGNhbiBjb250aW51ZSB0byBmaWxsIHBhZ2VzDQo+IGF0DQo+ICJo
ZWFkbGVzcyIgcGFnZSBvZmZzZXRzIHRoYXQgbWF0Y2ggdGhlaXIgb3JpZ2luYWwgY29va2llIGFu
ZA0KPiBwYWdlX2luZGV4DQo+IHBhaXIuwqAgVGhpcyBjaGFuZ2Ugd291bGQgbWVhbiByZWFkZXJz
IGRvbid0IGhhdmUgdG8gc3RhcnQgb3Zlcg0KPiBmaWxsaW5nIHRoZQ0KPiBwYWdlIGNhY2hlIHdo
ZW4gdGhlIGNhY2hlIGlzIGRyb3BwZWQsIHNvIHdlIHdvdWxkbid0IG5lZWQgdG8gd29ycnkNCj4g
YWJvdXQNCj4gd2hlbiB0byBjdXQgb3ZlciB0byB0aGUgdW5jYWNoZWQgbW9kZSAtIGl0IG1ha2Vz
IHRoZSBwcm9ibGVtIGdvIGF3YXkuDQo+IA0KPiBJIGZlbHQgdGhlcmUgd2Fzbid0IG11Y2ggaW50
ZXJlc3QgaW4gdGhpcyB3b3JrLCBhbmQgb3VyIG1vc3Qgdm9jYWwNCj4gY3VzdG9tZXINCj4gd2Fz
IGhhcHB5IGVub3VnaCB3aXRoIGxhc3Qgd2ludGVyJ3MgcmVhZGRpciBpbXByb3ZlbWVudHMgKHRo
YW5rcyEpDQo+IHRoYXQgSQ0KPiBkaWRuJ3QgZm9sbG93IHVwLCBidXQgSSBjYW4gcmVmcmVzaCB0
aG9zZSBwYXRjaGVzIGFuZCBzZW5kIHRoZW0gYWxvbmcNCj4gYWdhaW4uDQo+IA0KDQpXZSB3aWxs
IGFsd2F5cyBuZWVkIHRoZSBhYmlsaXR5IHRvIGN1dCBvdmVyIHRvIHVuY2FjaGVkIHJlYWRkaXIu
DQoNCklmIHRoZSBjb29raWUgaXMgbm8gbG9uZ2VyIHJldHVybmVkIGJ5IHRoZSBzZXJ2ZXIgYmVj
YXVzZSBvbmUgb3IgbW9yZQ0KZmlsZXMgd2VyZSBkZWxldGVkIHRoZW4gd2UgbmVlZCB0byByZXNv
bHZlIHRoZSBzaXR1YXRpb24gc29tZWhvdyAoSU9XOg0KdGhlICdybSAqJyBjYXNlKS4gVGhlIG5l
dyBhbGdvcml0aG0gX2RvZXNfIGltcHJvdmUgcGVyZm9ybWFuY2Ugb24gdGhvc2UNCnNpdHVhdGlv
bnMsIGJlY2F1c2UgaXQgbm8gbG9uZ2VyIHJlcXVpcmVzIHVzIHRvIHJlYWQgdGhlIGVudGlyZQ0K
ZGlyZWN0b3J5IGJlZm9yZSBzd2l0Y2hpbmcgb3Zlcjogd2UgdHJ5IDUgdGltZXMsIHRoZW4gZmFp
bCBvdmVyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
