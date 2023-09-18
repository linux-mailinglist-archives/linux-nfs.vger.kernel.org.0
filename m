Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182F87A5546
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIRV6Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRV6Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 17:58:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2121.outbound.protection.outlook.com [40.107.95.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F790
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 14:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmW99dOSZvHTSblRN6dCdDwAOnb/bcqrrBFlG5DX/X/Du+rmKcWuNysewzETXACnJ1FaQVGo0VAEA4xPYT0AzA29BifsHTv3jMe5mwBlLVohKVGFbD5+cDkTWr4XEd7dZyJiwkkAuiwfM5ADMefjLMSOt8mig5dY+ZZi4RQcG/ffrFZsLRrwx4NVQChy0pK4r4JpmfxD3XJqtjcqLDIeZHrEjgoNmMNxNiROdJrunSk4AASzB3Xi/oLi64qRhIYXgyj6PhcvruHuOm6a7DNvbdjwyxsm7zPU3qlz4OOQGcamzIrbuyKVhMVYvNHuGR3ZKj9B26r4y0shUs+KK7F9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZVpUGCsOCRgQ4Qha3egb6t4bIL+eg9MtDcaaN3LDgY=;
 b=eVjooabFwkRq64As5MRaeZHuGcvNiu79Wd0YuTOE/JSFFjEFC3OREp85Aao1PJ3NhSeeVhXnAC8Xmzp+IqpkoKQbZgyQa0ZIhprYdKAuTnv1dauI2PM9DvUNPtzcEIe/JaoqvRiT0G7wpIAYgrp9NRpJukzGou6PAe3ZFbkVLwBvl4w+xDJRZ8t0+Dz04EkBdEz1IHVOPF8/4gElwed81TIAzp3t2maLn8ajPxbDPiyhLBuGo6ffHAlCr4xEc/jyGR8qjO1HarsrJJIGWlhsTuWigqUGRbZFYjNIc53IRbghhtIe6EGB9gIISGWGeDeIEkUslDVtSc7plyJRlbJ5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZVpUGCsOCRgQ4Qha3egb6t4bIL+eg9MtDcaaN3LDgY=;
 b=E8RNUw85Ye5gym5mwTTcF3RqOKpOB7uqZoP7i1HGQL1N/tYiYNkPHMahlpp8+9FgncjjtVIe+o1AdNVdpmFPF7EyQ1jXni8F77GtfC/Veuh8wT4xsK9To6ePq2xv2841cPufdqqebPXo5pFqrpGrStokTAnvoVnW1qU3TVnIoY4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV3PR13MB6499.namprd13.prod.outlook.com (2603:10b6:408:196::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 21:58:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 21:58:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
Thread-Topic: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
Thread-Index: AQHZ1rwkaitaLXxh7UiNQTF7cd8yl7AablaAgAbDrYCAABb1gA==
Date:   Mon, 18 Sep 2023 21:58:15 +0000
Message-ID: <6552638dc081922ca5108fdd3f8cadd1cde6924c.camel@hammerspace.com>
References: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
         <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
         <D8B1F20B-E08D-4ED1-A0F5-0C2C763FEC88@redhat.com>
         <B39D8F7D-B852-42C9-BC1E-2DED2AC23ACA@redhat.com>
In-Reply-To: <B39D8F7D-B852-42C9-BC1E-2DED2AC23ACA@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV3PR13MB6499:EE_
x-ms-office365-filtering-correlation-id: 9cab4e35-899b-410c-3afe-08dbb8925bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiP9HUY7zJsXS3J1sD750N0uAh4dAXWsCm9HPSRuUC3EzRCpETQPguxvPDoEaMk8ChKV36jQJ39DLbzido43mGLOZbWodclU5uqJYdb7Bb8Bx9erpVwNgBFKMMCENz24Zrm+ipqqW3naLxbnEcNuC8Z6KrnjPILNTMDpzepZ+ULvoPAzIkV/TNh+/+yOAsxw++AK25QbRUCulPQ+5EHt9r5LEoENLdaeBxOXWql4ahZQoJwXw08EW4VMnhGc5f6N/6eZttPKnIEV9Bp3N8gl6lMjgUihMznohVx2BU8vB7AK3Tv4Dzeuhv9gVzxDItYBd7sr9UGlFNwtK+XQdCCt+cOtyQ1kSviObXnU/pgScWSKKTxilam5WatKq3+Ihpo6VMY2+q8cIFehNXtSq6MKk9nU2Ug+ZQSaxeRbDZxzFM69cwqXyGCWNcZ6RDcWpB2XA6YBbhlyFbo6fV6AiTxuGu1D7FgnUeLYWs3B2IK2VYAu406ftjMsLnt9CZJeVVNG+3IKdOstYwLywVz/GCjfZ19NP4dhbiq/7YAKMDJnvors+wMqGcMbzWdnK/MJT5rbsr5g++nCkh9nERVRKEVP8RbaqFbyRWFHB5XlRaF9FkbeD+o6s5s5yoKQ1U/cG/EnCXg/ImGxoDrClhy3AVzXq516owpuCbVALEyhrDO6UlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39840400004)(1800799009)(186009)(451199024)(26005)(5660300002)(8936002)(4326008)(8676002)(2616005)(2906002)(36756003)(86362001)(122000001)(38100700002)(38070700005)(83380400001)(66446008)(66946007)(6506007)(6486002)(53546011)(76116006)(66476007)(64756008)(66556008)(110136005)(71200400001)(478600001)(6512007)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0M0OXUyUnlUcyt3MWtCa1NlZlBGQ2o1aWZmVFFXVHg3QU9RNjlLL3RlekY1?=
 =?utf-8?B?bkpaaVR0ZEhGR0dkaHJqMmZsQWNBUWVyenRwajhOaDRxVkRjQVVVK3dXL09r?=
 =?utf-8?B?SG1jZFhKYS84bHRHd3RobmJjSyt5bUJFQ1JSQVB5RVVVcXF6UnpvcHVOMnZj?=
 =?utf-8?B?UUxERXBYZlRkbHRmc3M3R3NrUkpnQkNrSWtuSGFWT00vUnloZDJHN3ZqSEhW?=
 =?utf-8?B?R2I4UUs1M3dzNDhzUnZtRVk3Q2U0bW5wUi8vdHN1cWgyaWp3YnlHcVZlWlMv?=
 =?utf-8?B?bStHWmFVTFlZY1EvWU1FRVVlNGNVMUxOaDJ1TlBwVDNTTUhqc0cweC96TkQ2?=
 =?utf-8?B?dzYyNVB5T2hpdFlxMHduTi92cTNGVW0rNzdNQ1R1cGlGaXRlemdxSzc4alp0?=
 =?utf-8?B?ZkFvK3hSSzNuVVlSUkR6d3RKbmpUa3FYYUZjbk9DMkJFVy9LOWt1aEsra1hB?=
 =?utf-8?B?YVBIUmJwSEFKN0lwME5oRDV0TzQ2OUhoZTJvQUxwUndQMTVVdHNJZEtjUDg3?=
 =?utf-8?B?SFFMcUtDUFFrY21hRWdia0QxOUEydUhEbnF3cjJ6YXJTZXFET3VURlhOeWlP?=
 =?utf-8?B?T3Q0RzlEMndtYUhscXNrZkNLTEhNQTUvaytyTmRIUnhOQndLeTVjMTRwdnM1?=
 =?utf-8?B?UjJtNWpuSWpzZHc5MVREeVRLeHR3SmdNVUhYRXBpMFVpeFlIK1ppTVBBT21B?=
 =?utf-8?B?djlZK1h1Nm1aTWk3STFoY0RvMFB6bWVGQlZBVmNNMEV4TmlMcmo4Y0NYSmpZ?=
 =?utf-8?B?ajd3Mll1a0tiZmVDSDB0VE1OUkJXR2tjbVZ3RzhwOEora2VDblRoWlR3dEJq?=
 =?utf-8?B?RWRYc2tFMXdBVGV0MFNPT1hxYzVoam5rY1J4U1YvM2tWei9JV1FzeUN4ZmQ5?=
 =?utf-8?B?M0d6bW9OT3hoVkgzNTdyZ243Vk9ybkxuWkdWR0sySXBmTURiZ3BOaDF3aEMy?=
 =?utf-8?B?RUxjQlhKUk1tSDZBeXFHVW5KaHNxcFBQZk9TTVJYcGJBWWxhOGFPbFQ1Qmo3?=
 =?utf-8?B?WnJaOUZIZkZTa2M4VEJzRmIwS0tZb2VGcGJsK2JKZmZmSzBFY29PM253VEdZ?=
 =?utf-8?B?RUxRUk9QQVlvaUlZN2lnTS9mK3dNUXRsbmQvSVBOK0tnUmlFSkRUaWhxTmNW?=
 =?utf-8?B?OFZOMStwL2hSSGdPUDl0T2EvRS80Zkp2TEp6dVVtaVpzYytOMFhBOVQyL1F4?=
 =?utf-8?B?ODN0ekNsMEJnWnhUNGlrSnJBdzdpZUdleGpFeWhUcmVMT1NlNmV0YnJ5NXBS?=
 =?utf-8?B?UmZCdDhkcUR1QVFmeDFMeit4T1hKUnBlL0U3NGZ6WVNqT3JKR2gzd1diaFhZ?=
 =?utf-8?B?SWNvem5EZFJsSlBpYVN2cHBCWlR1K296U1FUUVBSbjFZRVN5ZXVkUHltRSsr?=
 =?utf-8?B?QXhObG5RVXJKVU1md01xdUNvbitueExvbWRmZVN5ODl3bnF5eW5kU0R5cTVq?=
 =?utf-8?B?RFkrZFNyWS9ZZUVYTkpZMU0xNmRHa2cyd0dJTzlhekF2UjJVTHBLR2Y0Z2tU?=
 =?utf-8?B?WGxvaWJUcXZkZjNLSDdYUHpRWkZPNTRKSHloM0hST1V0TUxLK3FBaFJPRDFN?=
 =?utf-8?B?NEpDdEsyRDFMU3ZBaXBZZlFCSVBPVlcvOVU2bW44WlJiWVd5VlFiL2tyTnB5?=
 =?utf-8?B?dGowd0ZQMGZ0Z2FrL1d0MDhWajRSNkxMNlh2dnQzaEdtT29CbHl5MTMvNGJU?=
 =?utf-8?B?WEM0VnZRckg5eHRMQWJNZTBXby9WL2tudzVJbkFrMTJYTDBzekQxUlo1R2Fo?=
 =?utf-8?B?aGMwRTRkNlUvZUgvMHd3U2oyNkt4MmhNcW9FN0ltU3NvNkNRTGV3aGdyeFpF?=
 =?utf-8?B?ZFdsQU0xMmowTEVnUVp3NkdlZTBvL2ZOTFh3QWY4cGJDSjV6aHJ0aUlxOXZV?=
 =?utf-8?B?MC9PcEJRUG1xaXBQOFZuMWd5OGxZcm5mbkZ2alMzVmVXTDBFOHBIMmhBL3k4?=
 =?utf-8?B?TEg2NlJ3Sm0zN2k5NER1K094bkRQcVZSVFcrNFRwcHlWT3ZLVHlqSEVpWVNY?=
 =?utf-8?B?TTJnUHMyWHdkaExvMDMvb0EyNFQ2aENBZTZ6RmVCcFVVdDk3TUlUbzNRTU1M?=
 =?utf-8?B?L3lWaWJzWFhFM2plTnlBU2todktnMkxMYzRXREIzVmNSUHp5MUxSVEZMM2JU?=
 =?utf-8?B?VG1PQzBCNHp3NldMZVlES25Ka2ZTbWZFNk1EZjR5N2FUMzRBTVQva2krRENx?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <461BF75CB4F90247988B08AD6138323E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab4e35-899b-410c-3afe-08dbb8925bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 21:58:15.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGSYtusDipCgHUQ0fYEIT0IdiA1c+2MYL7z3u0JHFAsT9USdw4wt34Ora0q2e7NGe2/3XotMtBihby7D87vh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDE2OjM2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNCBTZXAgMjAyMywgYXQgOToxOCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToNCj4gDQo+ID4gT24gMjQgQXVnIDIwMjMsIGF0IDE0OjUyLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IHdyb3RlOg0KPiA+IA0KPiA+ID4gV2hlbiB0aGUgY2xpZW50IGlzIHJlcXVpcmVkIHRvIHVzZSBU
RVNUX1NUQVRFSUQgdG8gZGlzY292ZXIgd2hpY2gNCj4gPiA+IGRlbGVnYXRpb24ocykgaGF2ZSBi
ZWVuIHJldm9rZWQsIGl0IG1heSBjb250aW51YWxseSB0ZXN0DQo+ID4gPiBkZWxlZ2F0aW9ucyBh
dCB0aGUNCj4gPiA+IGhlYWQgb2YgdGhlIGxpc3QgaWYgdGhlIHNlcnZlciBjb250aW51ZXMgdG8g
YmUgdW5zYXRpc2ZpZWQgYW5kDQo+ID4gPiBzZW5kDQo+ID4gPiBTRVE0X1NUQVRVU19SRUNBTExB
QkxFX1NUQVRFX1JFVk9LRUQuwqAgRm9yIGEgbGFyZ2UgbnVtYmVyIG9mDQo+ID4gPiBkZWxlZ2F0
aW9ucw0KPiA+ID4gdGhpcyBiZWhhdmlvciBpcyBwcm9uZSB0byBsaXZlLWxvY2sgYmVjYXVzZSB0
aGUgY2xpZW50IG1heSBuZXZlcg0KPiA+ID4gYmUgYWJsZSB0bw0KPiA+ID4gdGVzdCBhbmQgZnJl
ZSByZXZva2VkIHN0YXRlIGF0IHRoZSBlbmQgb2YgdGhlIGxpc3Qgc2luY2UgdGhlDQo+ID4gPiBT
RVE0X1NUQVRVU19SRUNBTExBQkxFX1NUQVRFX1JFVk9LRUQgd2lsbCBjYXVzZSB1cyB0byBmbGFn
DQo+ID4gPiBkZWxlZ2F0aW9ucyBhdA0KPiA+ID4gdGhlIGhlYWQgb2YgdGhlIGxpc3QgdG8gYmUg
dGVzdGVkLsKgIFRoaXMgcHJvYmxlbSBpcyBmdXJ0aGVyDQo+ID4gPiBleGFjZXJiYXRlZCBieQ0K
PiA+ID4gdGhlIHN0YXRlIG1hbmFnZXIncyB3aWxsaW5nbmVzcyB0byBiZSBzY2hlZHVsZWQgb3V0
IG9uIGEgYnVzeQ0KPiA+ID4gc3lzdGVtIHdoaWxlDQo+ID4gPiB0ZXN0aW5nIHRoZSBsaXN0IG9m
IGRlbGVnYXRpb25zLg0KPiA+ID4gDQo+ID4gPiBLZWVwIGEgZ2VuZXJhdGlvbiBjb3VudGVyIGZv
ciBlYWNoIGF0dGVtcHQgdG8gdGVzdCBhbGwNCj4gPiA+IGRlbGVnYXRpb25zLCBhbmQNCj4gPiA+
IHNraXAgZGVsZWdhdGlvbnMgdGhhdCBoYXZlIGFscmVhZHkgYmVlbiB0ZXN0ZWQgaW4gdGhlIGN1
cnJlbnQNCj4gPiA+IHBhc3MuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWlu
IENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+ID4gDQo+ID4gVGhpcyBvbmUgd2Vu
dCB0aHJvdWdoIHRoZSByaW5nZXIgaW4gYW4gZW52aXJvbm1lbnQgdGhhdCBzYXcNCj4gPiBtdWx0
aXBsZSBjbGllbnRzDQo+ID4gbGl2ZS1sb2NraW5nLCBhbmQgcmVzb2x2ZXMgdGhlIHByb2JsZW0g
Zm9yIHRoZW0uwqAgVGhleSBhc2tlZCBtZSB0bw0KPiA+IGFkZDoNCj4gPiANCj4gPiBUZXN0ZWQt
Ynk6IFRvcmtpbCBTdmVuc2dhYXJkIDx0b3JraWxAZHJjbXIuZGs+DQo+ID4gVGVzdGVkLWJ5OiBS
dWJlbiBWZXN0ZXJnYWFyZCA8cnViZW52QGRyY21yLmRrPg0KPiA+IA0KPiA+IEJlbg0KPiANCj4g
RGlkIHRoaXMgb25lIGdldCByZWplY3RlZCB3aXRoIGEgcmVhc29uP8KgIFRoaXMgZml4IGNvdWxk
IGFsc28gYmUNCj4gaW1wbGVtZW50ZWQNCj4gd2l0aCBmbGFnIChhcyBJIG1lbnRpb25lZCBpbiBh
IHJlcGx5IG9uIHYyKS4NCj4gDQo+IEJlbg0KPiANCg0KU3BlYWtpbmcgb25seSBmb3IgbXlzZWxm
LCBJIGhhdmVuJ3QgeWV0IGhhZCB0aW1lIHRvIHByb3Blcmx5IHJldmlldyBpdC4NClNvIG5vdCB5
ZXQgcmVqZWN0ZWQgYnkgbWUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
