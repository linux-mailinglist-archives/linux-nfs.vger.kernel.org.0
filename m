Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016837E2C2F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 19:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjKFSog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 13:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKFSog (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 13:44:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5CBA2
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 10:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkVgQRPZ5N++zcmDqlhfUifOo/uGk4FapsMXo6jYTXdWEmNU5+md+V2iCPaippyPCzDvy/UIyKGoY/1Pq5NX7EGbxHLtH+c7R/WmD7cvNs45gOKTnFiu3hGPcIaIhe00XjHk9e9ppevKrN0ullf+Vqq9zoIAikSLsgdhZl2FiiwQ6BskLP3WLENxGGd2QyiRjL46YZrj9AfyojCa3gMw3GfEI9X0bo61elvL0R4GZpdwZyrUSxiFdVbgkgzWQ3Ou2AMod37ovSWCTmRCdRj3jf8bO+NP2KwgqFlI8emJHDVZT+Y7CGHX0ApL+k7VjYzXk+PK96Aa/HifeujFQA+e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMLIyuCHX200wcWbUE9nFqAZHi0h+K6sOLnLCN4+8i0=;
 b=liQQbY+NE8ufZSyKabJfKxHXd4SAxZcj2rAOmx1eNTK5qYn49aDNh4YhWC3Zmu/dxlMIbTEq9tpY/jGppArpyhOYfzNG7+y0TFS84YLjNn+KVe1uMSdo20Cifi98iIAJC9PlogcdwixO3gvANxDrHTQQOzJk1UyVVimyzVVrqlIgYE8Z2O75GjP2ibUS9MXS1FByVqhSvHZyZddr2s671OPtX20HdK07fbe3UNFyyXNQoaeHcFo7KIdTbj+cRP+zmwBP2WGjiEp3vY63Cb2AnRhi9sHjm0RVrY1JtzzWgHe+ajXwnvw1xM+CSwPXM8RoDtexP20lvfEejFe9qOI3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMLIyuCHX200wcWbUE9nFqAZHi0h+K6sOLnLCN4+8i0=;
 b=XlA2n0ZoR9l3U5cUYKRn+yG+7iwdlGOGN4izavESEbMiPExqctj8MYivm7tpFeHHwy2Sv4tpAIb5DxwUBR+CPDzs+QMPfx2D7JUoYWKGvNzWKYkmaxseS9/HY8ira7Bd+JjzByGvINRdKxa4GcuMQ0ulJvYlGQBqLwuWNOfSiYk=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH0PR13MB5589.namprd13.prod.outlook.com (2603:10b6:510:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 18:44:27 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 18:44:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Topic: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Index: AQHaEB5BKQ5QGSlnh06Lj6cEjRIJpLBtfMoAgAAeP4CAAAdBgA==
Date:   Mon, 6 Nov 2023 18:44:26 +0000
Message-ID: <ed79385ef7c8ce2c6ff6753bcf8c5301f2d39584.camel@hammerspace.com>
References: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
         <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
         <c53af0da-58f4-4981-9006-a6acbf404de4@oracle.com>
In-Reply-To: <c53af0da-58f4-4981-9006-a6acbf404de4@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|PH0PR13MB5589:EE_
x-ms-office365-filtering-correlation-id: b67d68c6-1e7a-40e9-9371-08dbdef8673c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRiFxIm5uuSG0EjOTXk1+ro1pQnRqdF0Ho3Y3RnqqgPnCssxxpUeCDdtzEMr6ufNiuLcN0v2KpwMGThi+6W0NELIyfGjcUEtx7xUH5yVFTCpRu1fz39rHI8oH8aIkAwL7o9oA49rZz/BDecgOAkdfLHO6gPukfIdlEoI4aiYfx1hSWJkBP9vG1/MPVMvHsM5dHhQW1kof6/Uf/EmeIdc2HZvec1UvYNZI/TzcfTIv/vUFYsK+TEmBqlUmITa3nyDqsSAOQbYWJTRngx2uSHGJ8RGiDeWCag66tUWiZFnm/MgPQZFabtTHuCEdfHnp58d5O5BhWo5KBd0A33O0dXCu1B20+t4mcdOpKVDBxjrs5AYhkls6uTiXeaKZa8Y1spY2CG5HIiKmGRaXFE2oRgoRf4X810/nH+qpwg7IX74bjNuf0mrtfjnSJbOyd6S7a32PJ5NCe2cYABheOIl7xop1qPqkW03QnvUPLHCpWXpE6bo4rM2LoZ6e6arGk9ZqeVjTEGCkVnm9B493MTyukiWFBakg53PzosTHepXhs7TuyJcEyXDCiqKvL2HqGyp8s1y0q0yTcHQD11uEvB4+01X0kj+M+zaGS5ysie6KkVtkB0TWMTZzBBCjR8Q8U99t4DiWRYrZO3AZKIYzEz2z5aIFJrVmessLErNshwTQ1Nma2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39840400004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6486002)(83380400001)(71200400001)(38100700002)(2616005)(8936002)(316002)(8676002)(2906002)(5660300002)(41300700001)(478600001)(110136005)(53546011)(66476007)(6512007)(76116006)(64756008)(66446008)(91956017)(66946007)(66556008)(6506007)(36756003)(86362001)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZCtYN0h3VjRTS3ErWXZubXNVZUtvbnZLdHl6YUYxUlI5QlBiZkczOGIydndh?=
 =?utf-8?B?UXVZdFphZWdycUhQd2o5SG8vUG9wbTFnUEN4dHgvZW1xeWhUczlJMEtlWDhs?=
 =?utf-8?B?QXgrTm5BNTZXQ01RNnJSd2VVRDlKUXcyMytQZlA1dzgybUhuWG9CMGszUFN4?=
 =?utf-8?B?WXRjZ29sSlRhQy84Vnk2c1VQMmtnTFFPOEdlR1pHVzJmQ1lsS2tIdWlDTjVt?=
 =?utf-8?B?QWVjZDFkaW85Szg5TTN6K3dSbE15b1Q5K0FnYVY0ZTlwaTVraEVnblFWWHZR?=
 =?utf-8?B?UWlDbDgzUzZtVjNyNklSWFZ3QlhlSTRzTDduVE92WTVvTUY3MUFFald3L0c3?=
 =?utf-8?B?bDJEOUhJQkNZUm1yY3N0SFdFOTNjODBKc1dkL1IrNExYWVJVZkN4UjdncVhH?=
 =?utf-8?B?WGJFNDlZZThqWEFlcGs1ZWxPTUtMNFpzSUpDTGdoQ3ZMWjFIZldiNC84empt?=
 =?utf-8?B?TTNRQ004STE2ZWhkTkNHVFE4QXpjb0pGY25MU2hYUURuRndUSlJVejYwa1dm?=
 =?utf-8?B?ODh4eGNxb2ZQTDRPZi84TTZIZStxOTN3VEsrM0xjOEE1MXB4V0VIZjRpT01w?=
 =?utf-8?B?NHBZRHN4R1BGM0ZyalQxemV5UjFWeVphdGltT0MrNkJ0UlhlY1pGOWhjZGda?=
 =?utf-8?B?ZmwzV0Fwc0pUaVp3RUdWWGpVeEsxRVJtZjE1UTliWmczYU9kSWNDYXdXb1Nr?=
 =?utf-8?B?VU0wRXdKUitsKzVIQ3l4TkNFSUg3Z2JpU0ViU2xuZXpteWZvblU4anprTEl5?=
 =?utf-8?B?T0F2ZFpaRkRMb3VjZGVsWlluL1dnMzVJMU9rYlBtNmVjUHY5dDRObzk4aWdI?=
 =?utf-8?B?ZFdiM2pvandIUGVKLzBrMUU5UTZxZU1Ea3JLQVU3ZW84TTBXY0wvYTlpRmw4?=
 =?utf-8?B?RWNWQklORFVMaDdGQjlzWCtzZlJwaXBrU0tlaWgvN2Y1Z05lMUM2YU9BWEU3?=
 =?utf-8?B?NjU4U1RpUlVGdUpveHN0dG1VWVJIUHRGblBPeTd2WXNSWi9zN1NpQ2lyMks4?=
 =?utf-8?B?cFRPQjdVYjdIUHhmR1J3UHpCRmsya2doWlVBUnM2Y2hoR05JdlhiQjV4b0xn?=
 =?utf-8?B?dGNMMnZ2Q0NtNjhEWSt4czVvdnFlakFkNGdHbGdiSFpFTDBkcldPcWMwS3FZ?=
 =?utf-8?B?OWlVU041RmJXZ0ljUngwV0I5cFM1cG9wUDJJZENCTmdoT1UyME5HSVJJZ090?=
 =?utf-8?B?c3Rkd3V2VjZJZXIvZ3dQUXZDNy9iSGY5b1haL1B6alJLbFU5UDVYTWhsZFFl?=
 =?utf-8?B?Zlg2YUtuOUhuUFJMd1VkTFpMdXh4N2Zyc0U3WHhjTHI1YjBzSVpLZ0ZIeXJT?=
 =?utf-8?B?Y1d1ZWgzaTNxQnB1cGRyc3BCYzdnN1k0WkJTRU9SRUhaY3ZIQmV3U252aHlC?=
 =?utf-8?B?QjFhNEt1M0d2MTFXT2RZelozWVVaaVRKZ0N6RHR6UVdaM3JTVWkyR3kwUjNF?=
 =?utf-8?B?YWV6dDlHT2t2SEtsNHNPRWI1aFJ1UnViUlAyaCsyK2pjMUJPSHkrRlVUU0xG?=
 =?utf-8?B?cW9Kb25VZU80ejQvRGxvRjdBS29vcGw3eGlqYkpiNFFjVStaNzJnQVJIZks2?=
 =?utf-8?B?TWxQbWFMdmU4U0NGNWVKUHBUSjBLcDZDbk1rRGhEb1ZyOWMveEZraFFRZDAx?=
 =?utf-8?B?WW9EaDROaG9nN01TUFJPQ041c1NLMllLUzJobkttYmtvTzlmbi96blhjWms1?=
 =?utf-8?B?cXVXd1B2SjV4czgxUWhTS2R6aUUwdXdpWWM0TW9ENXhidUpFakd2ZFJHa0F4?=
 =?utf-8?B?ZnQzcUVzMC9RODhLNlNtVUJHaTlmSkhSWjdpdUxxdHJWY3VxVVpFTnhOcFJI?=
 =?utf-8?B?RFVIYjFpRjM1UWF3YUFsTmpTYnJUM3FJRXAxU2tSemRBY21sVStHbUlKT0Fv?=
 =?utf-8?B?QTN1SExDMUs4V2QveGcyTmFIRlVPUGtuNC9MTlZLbmg1NzR0b3pGbWxqNjZE?=
 =?utf-8?B?bFJTTy9xTHp3YnhIa3NKRkl0dzNxdUpUaFY2YkxwdzBDZUFTNDJ0Ym1Kd1ox?=
 =?utf-8?B?SDZyRGRSY3Y2V2JLOENiaUxJenlpNm5JcG1oakJ1NUNPc002MHVIUDFUZHhm?=
 =?utf-8?B?ZmNyUE5XZ2xmV0FVR0U3Rm9keTdvT0p4bldFRWhIMkJILzAzdm1pbGZkOTVJ?=
 =?utf-8?B?YTJ0WDh2MWNoUFNNQTJSYTJCeS9keFV5aXYvZEQ5WjNwR3pOeFpvc0p6UUtr?=
 =?utf-8?B?TFFmaERsWlRSYkNBL0kwVEVnOXppZEI3cks1VXJsYkU4bDh0d3ZYVE5nRnJ3?=
 =?utf-8?B?U1p3UzFaYzdZVlI5VjJLRk5CVW1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD9695CBA19F0408DB32E34698EBFC7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d68c6-1e7a-40e9-9371-08dbdef8673c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 18:44:26.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir9uH+ZkVPQnX7WXbMQqDun9/G+/ncOmEvXSPrqWiJmPJMEwxRUrrLapbRjGD1/nKrO22azcOaePkhJNNYuHwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDEwOjE4IC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IA0KPiBPbiAxMS82LzIzIDg6MzAgQU0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4g
PiBIaSBEYWksDQo+ID4gDQo+ID4gT24gU3VuLCAyMDIzLTExLTA1IGF0IDExOjI3IC0wODAwLCBk
YWkubmdvQG9yYWNsZS5jb23CoHdyb3RlOg0KPiA+ID4gSGkgVHJvbmQsDQo+ID4gPiANCj4gPiA+
IFdoZW4gdW5tb250aW5nIGEgTkZTIGV4cG9ydCwgbmZzX2ZyZWVfc2VydmVyIGlzIGNhbGxlZC4g
SW4NCj4gPiA+IG5mc19mcmVlX3NlcnZlciwNCj4gPiA+IHdlIGNhbGwgcnBjX3NodXRkb3duX2Ns
aWVudChzZXJ2ZXItPmNsaWVudCkgdG8ga2lsbCBhbGwgcGVuZGluZw0KPiA+ID4gUlBDDQo+ID4g
PiB0YXNrcw0KPiA+ID4gYW5kIHdhaXQgZm9yIHRoZW0gdG8gdGVybWluYXRlIGJlZm9yZSBjb250
aW51ZSBvbiB0byBjYWxsDQo+ID4gPiBuZnNfcHV0X2NsaWVudC4NCj4gPiA+IEluIG5mc19wdXRf
Y2xpZW50LCBpZiB0aGUgcmVmY291bmYgaXMgZHJlY2VtZW50ZWQgdG8gMCB0aGVuIHdlDQo+ID4g
PiBjYWxsDQo+ID4gPiBuZnNfZnJlZV9jbGllbnQgd2hpY2ggY2FsbHMgcnBjX3NodXRkb3duX2Ns
aWVudChjbHAtDQo+ID4gPiA+Y2xfcnBjY2xpZW50KSB0bw0KPiA+ID4ga2lsbCBhbGwgcGVuZGlu
ZyBSUEMgdGFza3MgdGhhdCB1c2UgbmZzX2NsaWVudC0+Y2xfcnBjY2xpZW50IHRvDQo+ID4gPiBz
ZW5kDQo+ID4gPiB0aGUNCj4gPiA+IHJlcXVlc3QuDQo+ID4gPiANCj4gPiA+IE5vcm1hbGx5IHRo
aXMgd29ya3MgZmluZS4gSG93ZXZlciwgZHVlIHRvIHNvbWUgcmFjZSBjb25kaXRpb25zLA0KPiA+
ID4gaWYNCj4gPiA+IHRoZXJlIGFyZQ0KPiA+ID4gZGVsZWdhdGlvbiByZXR1cm4gUlBDIHRhc2tz
IGhhdmUgbm90IGJlZW4gZXhlY3V0ZWQgeWV0IHdoZW4NCj4gPiA+IG5mc19mcmVlX3NlcnZlcg0K
PiA+ID4gaXMgY2FsbGVkIHRoZW4gdGhpcyBjYW4gY2F1c2Ugc3lzdGVtIHRvIGNyYXNoIHdpdGgg
Z2VuZXJhbA0KPiA+ID4gcHJvdGVjdGlvbg0KPiA+ID4gZmF1bHQuDQo+ID4gPiANCj4gPiA+IFRo
ZSBjb25kaXRpb25zIHRoYXQgY2FuIGNhdXNlIHRoZSBjcmFzaCBhcmU6ICgxKSB0aGVyZSBhcmUN
Cj4gPiA+IHBlbmRpbmcNCj4gPiA+IGRlbGVnYXRpb24NCj4gPiA+IHJldHVybiB0YXNrcyBjYWxs
ZWQgZnJvbSBuZnM0X3N0YXRlX21hbmFnZXIgdG8gcmV0dXJuIGlkbGUNCj4gPiA+IGRlbGVnYXRp
b25zIGFuZA0KPiA+ID4gKDIpIHRoZSBuZnNfY2xpZW50J3MgYXVfZmxhdm9yIGlzIGVpdGhlciBS
UENfQVVUSF9HU1NfS1JCNUkgb3INCj4gPiA+IFJQQ19BVVRIX0dTU19LUkI1UA0KPiA+ID4gYW5k
ICgzKSB0aGUgY2FsbCB0byBuZnNfaWdyYWJfYW5kX2FjdGl2ZSwgZnJvbQ0KPiA+ID4gX25mczRf
cHJvY19kZWxlZ3JldHVybiwgZmFpbHMNCj4gPiA+IGZvciBhbnkgcmVhc29ucyBhbmQgKDQpIHRo
ZXJlIGlzIGEgcGVuZGluZyBSUEMgdGFzayByZW5ld2luZyB0aGUNCj4gPiA+IGxlYXNlLg0KPiA+
ID4gDQo+ID4gPiBTaW5jZSB0aGUgZGVsZWdhdGlvbiByZXR1cm4gdGFza3Mgd2VyZSBjYWxsZWQg
d2l0aCAnaXNzeW5jID0gMCcNCj4gPiA+IHRoZQ0KPiA+ID4gcmVmY291bnQgb24NCj4gPiA+IG5m
c19zZXJ2ZXIgd2VyZSBkcm9wcGVkIChpbiBuZnNfY2xpZW50X3JldHVybl9tYXJrZWRfZGVsZWdh
dGlvbnMNCj4gPiA+IGFmdGVyIFJQQyB0YXNrDQo+ID4gPiB3YXMgc3VibWl0ZWQgdG8gdGhlIFJQ
QyBsYXllcikgYW5kIHRoZSBuZnNfaWdyYWJfYW5kX2FjdGl2ZSBjYWxsDQo+ID4gPiBmYWlscywg
dGhlc2UNCj4gPiA+IFJQQyB0YXNrcyBkbyBub3QgaG9sZCBhbnkgcmVmY291bnQgb24gdGhlIG5m
c19zZXJ2ZXIuDQo+ID4gPiANCj4gPiA+IFdoZW4gbmZzX2ZyZWVfc2VydmVyIGlzIGNhbGxlZCwg
cnBjX3NodXRkb3duX2NsaWVudChzZXJ2ZXItDQo+ID4gPiA+Y2xpZW50KQ0KPiA+ID4gZmFpbHMg
dG8NCj4gPiA+IGtpbGwgdGhlc2UgZGVsZWdhdGlvbiByZXR1cm4gdGFza3Mgc2luY2UgdGhlc2Ug
dGFza3MgdXNpbmcNCj4gPiA+IG5mc19jbGllbnQtPmNsX3JwY2NsaWVudA0KPiA+ID4gdG8gc2Vu
ZCB0aGUgcmVxdWVzdHMuIFdoZW4gbmZzX3B1dF9jbGllbnQgaXMgY2FsbGVkLA0KPiA+ID4gbmZz
X2ZyZWVfY2xpZW50DQo+ID4gPiBpcyBub3QNCj4gPiA+IGNhbGxlZCBiZWNhdXNlIHRoZXJlIGlz
IGEgcGVuZGluZyBsZWFzZSByZW5ldyBSUEMgdGFzayB3aGljaCB1c2VzDQo+ID4gPiBuZnNfY2xp
ZW50LT5jbF9ycGNjbGllbnQNCj4gPiA+IHRvIHNlbmQgdGhlIHJlcXVlc3QgYW5kIGFsc28gYWRk
cyBhIHJlZmNvdW50IG9uIHRoZSBuZnNfY2xpZW50Lg0KPiA+ID4gVGhpcw0KPiA+ID4gYWxsb3dz
DQo+ID4gPiB0aGUgZGVsZWdhdGlvbiByZXR1cm4gdGFza3MgdG8gc3RheSBhbGl2ZSBhbmQgY29u
dGludWUgb24gYWZ0ZXINCj4gPiA+IHRoZQ0KPiA+ID4gbmZzX3NlcnZlcg0KPiA+ID4gd2FzIGZy
ZWVkLg0KPiA+ID4gDQo+ID4gPiBJJ3ZlIHNlZW4gdGhlIE5GUyBjbGllbnQgd2l0aCA1LjQga2Vy
bmVsIGNyYXNoZXMgd2l0aCB0aGlzIHN0YWNrDQo+ID4gPiB0cmFjZToNCj4gPiA+IA0KPiA+ID4g
ISMgMCBbZmZmZmI5M2I4ZmJkYmQ3OF0gbmZzNF9zZXR1cF9zZXF1ZW5jZSBbbmZzdjRdIGF0DQo+
ID4gPiBmZmZmZmZmZmMwZjI3ZTQwIGZzL25mcy9uZnM0cHJvYy5jOjEwNDE6MA0KPiA+ID4gwqDC
oCAjIDEgW2ZmZmZiOTNiOGZiZGJkYjhdIG5mczRfZGVsZWdyZXR1cm5fcHJlcGFyZSBbbmZzdjRd
IGF0DQo+ID4gPiBmZmZmZmZmZmMwZjI4YWQxIGZzL25mcy9uZnM0cHJvYy5jOjYzNTU6MA0KPiA+
ID4gwqDCoCAjIDIgW2ZmZmZiOTNiOGZiZGJkZDhdIHJwY19wcmVwYXJlX3Rhc2sgW3N1bnJwY10g
YXQNCj4gPiA+IGZmZmZmZmZmYzA1ZTMzYWYgbmV0L3N1bnJwYy9zY2hlZC5jOjgyMTowDQo+ID4g
PiDCoMKgICMgMyBbZmZmZmI5M2I4ZmJkYmRlOF0gX19ycGNfZXhlY3V0ZSBbc3VucnBjXSBhdA0K
PiA+ID4gZmZmZmZmZmZjMDVlYjUyNw0KPiA+ID4gbmV0L3N1bnJwYy9zY2hlZC5jOjkyNTowDQo+
ID4gPiDCoMKgICMgNCBbZmZmZmI5M2I4ZmJkYmU0OF0gcnBjX2FzeW5jX3NjaGVkdWxlIFtzdW5y
cGNdIGF0DQo+ID4gPiBmZmZmZmZmZmMwNWViOGUwIG5ldC9zdW5ycGMvc2NoZWQuYzoxMDEzOjAN
Cj4gPiA+IMKgwqAgIyA1IFtmZmZmYjkzYjhmYmRiZTY4XSBwcm9jZXNzX29uZV93b3JrIGF0IGZm
ZmZmZmZmOTJhZDQyODkNCj4gPiA+IGtlcm5lbC93b3JrcXVldWUuYzoyMjgxOjANCj4gPiA+IMKg
wqAgIyA2IFtmZmZmYjkzYjhmYmRiZWIwXSB3b3JrZXJfdGhyZWFkIGF0IGZmZmZmZmZmOTJhZDUw
Y2YNCj4gPiA+IGtlcm5lbC93b3JrcXVldWUuYzoyNDI3OjANCj4gPiA+IMKgwqAgIyA3IFtmZmZm
YjkzYjhmYmRiZjEwXSBrdGhyZWFkIGF0IGZmZmZmZmZmOTJhZGFjMDUNCj4gPiA+IGtlcm5lbC9r
dGhyZWFkLmM6Mjk2OjANCj4gPiA+IMKgwqAgIyA4IFtmZmZmYjkzYjhmYmRiZjU4XSByZXRfZnJv
bV9mb3JrIGF0IGZmZmZmZmZmOTM2MDAzNjQNCj4gPiA+IGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0
LlM6MzU1OjANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCANCj4gPiA+IFdoZXJlIHRoZSBwYXJh
bXMgb2YgbmZzNF9zZXR1cF9zZXF1ZW5jZToNCj4gPiA+IMKgwqDCoMKgwqDCoCBjbGllbnQgPSAo
c3RydWN0IG5mc19jbGllbnQgKikweDRkNTQxNThlYmM2Y2ZjMDENCj4gPiA+IMKgwqDCoMKgwqDC
oCBhcmdzID0gKHN0cnVjdCBuZnM0X3NlcXVlbmNlX2FyZ3MgKikweGZmZmY5OTg0ODdmODU4MDAN
Cj4gPiA+IMKgwqDCoMKgwqDCoCByZXMgPSAoc3RydWN0IG5mczRfc2VxdWVuY2VfcmVzICopMHhm
ZmZmOTk4NDg3Zjg1ODMwDQo+ID4gPiDCoMKgwqDCoMKgwqAgdGFzayA9IChzdHJ1Y3QgcnBjX3Rh
c2sgKikweGZmZmY5OTdkNDFkYTdkMDANCj4gPiA+IA0KPiA+ID4gVGhlICdjbGllbnQnIHBvaW50
ZXIgaXMgaW52YWxpZCBzaW5jZSBpdCB3YXMgZXh0cmFjdGVkIGZyb20NCj4gPiA+IGRfZGF0YS0N
Cj4gPiA+ID4gcmVzLnNlcnZlci0+bmZzX2NsaWVudA0KPiA+ID4gYW5kIHRoZSBuZnNfc2VydmVy
IHdhcyBmcmVlZC4NCj4gPiA+IA0KPiA+ID4gSSd2ZSByZXZpZXdlZCB0aGUgbGF0ZXN0IGtlcm5l
bCA2LjYtcmM3LCBldmVuIHRob3VnaCB0aGVyZSBhcmUNCj4gPiA+IG1hbnkNCj4gPiA+IGNoYW5n
ZXMNCj4gPiA+IHNpbmNlIDUuNCBJIGNvdWxkIG5vdCBzZWUgYW55IGFueSBjaGFuZ2VzIHRvIHBy
ZXZlbnQgdGhpcw0KPiA+ID4gc2NlbmFyaW8gdG8NCj4gPiA+IGhhcHBlbg0KPiA+ID4gc28gSSBi
ZWxpZXZlIHRoaXMgcHJvYmxlbSBzdGlsbCBleGlzdHMgaW4gNi42LXJjNy4NCj4gPiA+IA0KPiA+
ID4gSSdkIGxpa2UgdG8gZ2V0IHlvdXIgb3BpbmlvbiBvbiB0aGlzIHBvdGVudGlhbCBpc3N1ZSB3
aXRoIHRoZQ0KPiA+ID4gbGF0ZXN0DQo+ID4gPiBrZXJuZWwNCj4gPiA+IGFuZCBpZiB0aGUgcHJv
YmxlbSBzdGlsbCBleGlzdHMgdGhlbiB3aGF0J3MgdGhlIGJlc3Qgd2F5IHRvIGZpeA0KPiA+ID4g
aXQuDQo+ID4gPiANCj4gPiBuZnNfaW5vZGVfZXZpY3RfZGVsZWdhdGlvbigpIHNob3VsZCBiZSBj
YWxsaW5nDQo+ID4gbmZzX2RvX3JldHVybl9kZWxlZ2F0aW9uKCkgd2l0aCB0aGUgaXNzeW5jIGZs
YWcgc2V0LCB3aGVyZWFzDQo+ID4gbmZzX3NlcnZlcl9yZXR1cm5fbWFya2VkX2RlbGVnYXRpb25z
KCkgc2hvdWxkIGJlIGhvbGRpbmcgYQ0KPiA+IHJlZmVyZW5jZSB0bw0KPiA+IHRoZSBpbm9kZSBi
ZWZvcmUgaXQgY2FsbHMgbmZzX2VuZF9kZWxlZ2F0aW9uX3JldHVybigpLg0KPiA+IA0KPiA+IFNv
IHdoZXJlIGlzIHRoaXMgY29tYmluYXRpb24gbm8gaW5vZGUgcmVmZXJlbmNlICsgaXNzeW5jPTAN
Cj4gPiBvcmlnaW5hdGluZw0KPiA+IGZyb20/DQo+IA0KPiBUaGUgaW5vZGUgcmVmZXJlbmNlIHdh
cyBkcm9wcGVkIGluDQo+IG5mc19zZXJ2ZXJfcmV0dXJuX21hcmtlZF9kZWxlZ2F0aW9ucw0KPiBh
ZnRlciByZXR1cm5pbmcgZnJvbSBuZnNfZW5kX2RlbGVnYXRpb25fcmV0dXJuLg0KPiANCj4gSSBk
b24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoeSBkbyB3ZSBjb250aW51ZSBvbiB3aXRoIHRoZSBkZWxl
Z2F0aW9uDQo+IHJldHVybg0KPiBpbiBfbmZzNF9wcm9jX2RlbGVncmV0dXJuIGFmdGVyIG5mc19p
Z3JhYl9hbmRfYWN0aXZlIGZhaWxzIGFuZCBpc3N5bmMNCj4gPSAwPw0KDQpJJ20gbm90IHNlZWlu
ZyBob3cgdGhhdCBjYXNlIGNhbiBvY2N1ciBhdCBhbGwuDQoNCklmIG5mc19zZXJ2ZXJfcmV0dXJu
X21hcmtlZF9kZWxlZ2F0aW9ucygpIGlzIGhvbGRpbmcgYSByZWZlcmVuY2UgdG8gdGhlDQpzdXBl
cmJsb2NrIGFuZCB0byB0aGUgaW5vZGUgYWNyb3NzIHRoZSBjYWxsIHRvDQpuZnNfZW5kX2RlbGVn
YXRpb25fcmV0dXJuKCksIHRoZW4gaXQgc2hvdWxkIG5vdCBiZSBwb3NzaWJsZSBmb3IgdGhlDQpj
YWxsIHRvIG5mc19pZ3JhYl9hbmRfYWN0aXZlKCkgdG8gZmFpbCBiZWNhdXNlIG5vbmUgb2YgdGhl
IHJlZmVyZW5jZQ0KY291bnRzIGl0IHRyaWVzIHRvIGJ1bXAgY2FuIGFscmVhZHkgYmUgemVyby4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
