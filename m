Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A2695368
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 22:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMVvw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMVvv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 16:51:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1FEB6D
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 13:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMJCuNHuk6qKMUY595yhAuP4v+jK72fZpBDL5TDPQfUPpW7lAzzha8vwGk8Jz5oFmuu4kbFJ4BvTZxgx7HUBil9m6qOicPD5k01Z0kRYBEHCohUMB3NDMp/hUQufnBGp7dDxgNX3xskQGGELs9G/HC6h3kB8frjmnzogiuA7/vTIZSyGWSsyzvUxb0dD8BR6VzaDwCx0h/6jnyuyYe2JO2tg3cwkIlJjL+eOp5oTjtVmMYQvgQbsClkI5mqStxr7kBRud7jKWKMtHCdPwaHdwiVPDExTnBco04eFoD2zNf6/M+YprvHgpP9Q8OJSmSOh3X0RluGwEcs3baUwYi9hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+0e9RClHIJDuC+LC9jUrQO93gnlX5WosBnPzuuSnX4=;
 b=dqhGQtSaQ2vyG17yJckc6S3CSuSzpMH0prvKryoc/dQE1Q+YpNs6yZFWiicjUNTxGsZQn5v/6FuGrF3AfWT9uYdsO17k+CzE/1ttaZJPLTzcQfMHdB6d4HCtYDB3XrKsTyzXMbueeM6RvfOFPvyGKKbvBwKNQq2vSOIsogsOAmDVb3uqFfaWdTiTJJ+DRbJi+Q13+h1W2jeiC6g3B4ziHUvTa4X5CquiTAXIkmHwMlM2YcROi7P2F0mHH/ZKQjKcM7LQcrNPLO/WkD4MrxdED+qcC3uPEh0TAlFcbnSpqm2DaKzzamjTvulNZ4qWdjZWZ2nDe8GEg6U3OrgpQ049cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+0e9RClHIJDuC+LC9jUrQO93gnlX5WosBnPzuuSnX4=;
 b=gTkbv4k/hpq4/RGZTjj4nmoX3mtTtRhFixDJQQSzJsFdpD5f2cR88DQKYX+7XiU1J50T3NZnPR5yKvVHXy2GccB/NTyqqaZAcP0nWZj6kbs1ve4SHkZMlhm3tU79nVmYtL6e4B71Dz2rsa38P4RLPCaQLrpEwSWLm4NaWFZkkFs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3788.namprd13.prod.outlook.com (2603:10b6:5:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 21:51:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 21:51:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFS: Simplify struct nfs_cache_array_entry
Thread-Topic: [bug report] NFS: Simplify struct nfs_cache_array_entry
Thread-Index: AQHZNjla74iZ+CtJT0uTP8kksa93ma7Nfj6A
Date:   Mon, 13 Feb 2023 21:51:47 +0000
Message-ID: <31EB0FBE-7791-477C-B3D9-62339EF32570@hammerspace.com>
References: <Y9pMmpqzjwQUn1XP@kili>
In-Reply-To: <Y9pMmpqzjwQUn1XP@kili>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3788:EE_
x-ms-office365-filtering-correlation-id: 17d38db4-e33f-4b0f-cb1a-08db0e0c8151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PRxHV732PDa7ibl/960bBYN2r0cRKfX6plYTEuJ2FhcjHYYQpNCa4h2Ydu5f8NSYtzG15ZJZaCFr5ni2CoU9U+b3jbaK6B4ZfnOM+QyAoZFY3hEHjE3zaudeD1hdv+ynYFYt1sf1u3oXfb5tjsD76qzCbwiljsUeu85HiBkdY1whevOlUAMsWHxgKu33x/vTVhOthuLkB0F3Y2V9EuEllXS87p+SwWIGpBlJeXzhxW2kfLQoOZfj6vjCZXLblTbuga1v2Eh8kocMM/AVNCE+hN8hlxk9IOp3z0yqgyk+mDxtberoIlBlDjC4ys63iFKU4jXculO8UPyWKo7i79bASkvDjX1rrUKgcqwjYm+OJIHbL/IULcPWEWUHhfk2tClwNx8gwg7hPBcsDwVRNVyS7lonYLCDfG7009FVbDhWAqWg4ZkNQl3Y6PLMdDDSQlt0xesqH3LDU5BI+dadOzML+MNlNwy9z90p93bS/wcWPs+h9cIUrzcSzhrkL5Gj71lRyOFuzGkqJk2c2UJ0Ljho6LgX8OkGaitTqhMKo+Y/g1M2pG0+EKDDc+DO3bfFUdzm1I5e0l/puC6wiCvUsQ6noVE98E6P+C8U/59wW6ZfitrKUOfNjAFpm3jmovXEEBnNMd6+zxo+WFWWhV1n7pwiOBUjodo7gjZUAYjgg/0dhcdbd1VAQUAqc5wzsBK7mKbQh/4hfOX1DDv4mqHg/D+pryPUENbDwXh3zaGCc7YrAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39830400003)(396003)(136003)(366004)(451199018)(38100700002)(122000001)(5660300002)(8936002)(41300700001)(6916009)(2616005)(86362001)(66556008)(66476007)(8676002)(64756008)(66946007)(66446008)(76116006)(6506007)(4326008)(71200400001)(53546011)(478600001)(186003)(6512007)(38070700005)(316002)(6486002)(2906002)(83380400001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTFXQzBuNXpZemgvNndodUNaRzAvWW40dlNBQkJJNENqNzZVOHJ3ZnRMeXpr?=
 =?utf-8?B?UThHczZaa0hpa3pkSDJoelUzTkxKeWplL1AzQVNaYk01YUlMaU1GN2lMSFZm?=
 =?utf-8?B?Rk1jRGFGSnRud081WHpXb0xkRTE0S3RBWExtTExxVU55ZDdJMnl6OWMzMkxP?=
 =?utf-8?B?MktjbHVzSXdlZmVzNzVVRHkwVUFGYk5lUElweTZJQzd4VkZLQldxMVhEVVZG?=
 =?utf-8?B?M3BKL0d1RmJNMk1RT2xuc1QrZ1dqR2lKNks5K1hyS3ZwU0hzWXZzaTI2Q1lR?=
 =?utf-8?B?eTFOK2V6SXZydlpEVHMvTDk4Z2dsdFJNYjBwZ09heEJCM1VhZmcrdkN4VXgr?=
 =?utf-8?B?WDZDMEhna3FBTS93MVhDOVNiTWtTMklrK3dhV25uODNCNG95M3FHUExkOWNZ?=
 =?utf-8?B?ek1pakt2by9LNjZzRkhHOVpZczJsMGVhNDVEWC9SbWRKc0ZhbXMxYUJ4SExi?=
 =?utf-8?B?cXB3KzNjWDdsRWZlWEgxekdzU1oyVCtkRUtBenN1WWF6RWVFeFhvdDdJTWhM?=
 =?utf-8?B?QUdWT2UyWStScjdycFJpQ1dva1J3QVhKeEJRODJ1TTNjM1IwVjN4K2Y0b0NM?=
 =?utf-8?B?bHllbGRDbHNYN1lSZnN1a0tvSUVPVldFTWhDb0dJMzZuelFxYURCSW1zRlZI?=
 =?utf-8?B?RHZCVTlJbXUvNkxFbFBzR2U5TUNPN0V3RnZxTys0dXNOSmVxSXNaTEtzK3BE?=
 =?utf-8?B?eEtOZVF4ZVVQRXk2ZXdtT0ttbWNqS3lBOG0zUHNmbTdvbWE4U2RiR1g1ZGV2?=
 =?utf-8?B?Wmg4azFxQm5jcjBRMXFOZ3IxREFpczhjS2R6T3FRbUk2OS9yQVlOaGFpRWVX?=
 =?utf-8?B?dGJPSS9hUE9HYUxDWXkzeEhhMGRrSmI5NEZtNGJCZm5uTmt3V1p1eGduc1pn?=
 =?utf-8?B?N2hIbExhZUxLaGp6WEtCTUNKNE5Db0Y1cXpQR3VpTGhqZFdxc3ZkL3RXeDNN?=
 =?utf-8?B?bHh5Vk1lNDhpMmkzTlplRVpSMHQrUDVMTHpFeGJ3QngzRWh6bDl4MVU3Rkpa?=
 =?utf-8?B?SUxyd3FPZGJpRkNmRllxa3c1Q3NZb0RwWHlUeWlLR01JeTN6eDBLYVprenVl?=
 =?utf-8?B?dlBBZGdSdUNyWVgzZndmL25pK0wvUWpoWUpsYTNQOXZWeG56cUVQT0UyZlBx?=
 =?utf-8?B?UnZGRFQ0RHBnUnNTcGgrOVZLcGRTWDgxSjVKMGhFRFRRN3F3TkdiYkJjaklw?=
 =?utf-8?B?eXdUNGNFOFg0Y21XOVlUWm52a2JBZDBKNFhmVDdrV3c2Yk15enlqbERORXl0?=
 =?utf-8?B?RHc1bzNwZk9tTm0waDZHUThrVDFnVGRlMTFtbGRtNlhyQlVuNDM3NVVTYUFh?=
 =?utf-8?B?c0o0TEg5ajM0UjMyOC8vRmpyREdTNmFKMzc0aDdDdFBsMnJ5UlM2Tm1QTUZp?=
 =?utf-8?B?dCtyUnU4NCtubmlYTGp2STk3dW5Ia1hSZEZOSmJIalJ1RjFTMHNRVlFScHU5?=
 =?utf-8?B?Y3FGaiswekVVYXgxaFNlaUlSS0dUZEpMcVZGUmNWNmtlNnBNZHNxeVhwK2lo?=
 =?utf-8?B?VGVIbEhiS1lGRTYzZ0FvS0dxQlNNd2dqb3VWMDRTbXYzOGhBNlJ6UTMxbndi?=
 =?utf-8?B?bWZqYmFQU0RDeE9xV0lNTGlTR2lhZ0FZcnRXbGNEaEF3OXRaNk0xRWw5WGZN?=
 =?utf-8?B?akVLSnY4bk40QTQvTE1jMlJKM0hSRUlZRkdMdThMMStheTFvVTM5QXlMOWJn?=
 =?utf-8?B?OW1ua1VhLzVicTQ4YjhuWmxTYkRqY0dKZzBIanZLb3ZUUDBUbjdQVEpnMXh4?=
 =?utf-8?B?a0pvaG50cUEzWVlISkJGbEFPTCs2M2tsYnhIUDZCbGUwR0JSTkZBdU1OMHNV?=
 =?utf-8?B?NjEwU0FLY3ExRnZabDcwSFNjbzRpV2thWTc5UVRLUFN3Si9KYktFK1dneElq?=
 =?utf-8?B?Q2svWDVGczYwSFJQVWk2M1F2MFQ3bDlRekl2MkdnTGtvWk1xMUpGbGFrQWc2?=
 =?utf-8?B?S01qUjYzSWY0S0dUeitPZXNKaFdGT2RlT2F2eEtDQ2JqTDVSNkpWWHhELzBo?=
 =?utf-8?B?RmI3TlFrMHlzNnlFRnRzRDZLak11Nk8zck5GSXBrT2c5YUNOMWpCZlp0TjVi?=
 =?utf-8?B?cEY4czVHcUtFeDM1MzhFK0h6eStPVGI1bFRyUFFtY3JFNDUyL0FnSVdiQmx0?=
 =?utf-8?B?c1dMVjBvUW4wcDNBdkY2MHZpcW9WLzdmbnpLak1aWlhaQXJyUE82N3RoZkwx?=
 =?utf-8?B?WlQ0ejdQMmtWbzkvaWlsZUNLVWZlbGMyWm52SU5qdFEySVpKTXp6bHRzN2RB?=
 =?utf-8?B?ajJzTjFmdUJlYW9TUnZ3WWJQQjdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFE589F03218414E89B50E07525BC4CA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d38db4-e33f-4b0f-cb1a-08db0e0c8151
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 21:51:47.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY6/Z9rnjz5QfcJ/HZU2NKuu/zujC0iMNrfn8wufHUUvjIWQO1GLKlxT3+acfFxZIp9AEfpOR8MDsiM6+pXNWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRGFuLA0KDQo+IE9uIEZlYiAxLCAyMDIzLCBhdCAwNjoyNywgRGFuIENhcnBlbnRlciA8ZXJy
b3IyN0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gVHJvbmQgTXlrbGVidXN0LA0KPiAN
Cj4gVGhlIHBhdGNoIGE1MmE4YTZhZGFkOTogIk5GUzogU2ltcGxpZnkgc3RydWN0IG5mc19jYWNo
ZV9hcnJheV9lbnRyeSINCj4gZnJvbSBOb3YgMSwgMjAyMCwgbGVhZHMgdG8gdGhlIGZvbGxvd2lu
ZyBTbWF0Y2ggc3RhdGljIGNoZWNrZXINCj4gd2FybmluZzoNCj4gDQo+IGZzL25mcy9kaXIuYzoy
MjYgbmZzX3JlYWRkaXJfY2xlYXJfYXJyYXkoKQ0KPiB3YXJuOiB1bmNhcHBlZCB1c2VyIGxvb3Ag
aW5kZXggJ2knDQo+IA0KPiBmcy9uZnMvZGlyLmMNCj4gICAgMjE5IHN0YXRpYyB2b2lkIG5mc19y
ZWFkZGlyX2NsZWFyX2FycmF5KHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgICAyMjAgew0KPiAgICAy
MjEgICAgICAgICBzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5ICphcnJheTsNCj4gICAgMjIyICAgICAg
ICAgdW5zaWduZWQgaW50IGk7DQo+ICAgIDIyMyANCj4gICAgMjI0ICAgICAgICAgYXJyYXkgPSBr
bWFwX2F0b21pYyhwYWdlKTsNCj4gICAgMjI1ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGFycmF5
LT5zaXplOyBpKyspDQo+IC0tPiAyMjYgICAgICAgICAgICAgICAgIGtmcmVlKGFycmF5LT5hcnJh
eVtpXS5uYW1lKTsNCj4gDQo+IEkgZ3Vlc3MgSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCBob3cg
a21hcCgpIHdvcmtzLiAgSSB0aG91Z2h0IGl0IHdhcw0KPiBmb3IgbWFwcGluZyB1c2Vyc3BhY2Ug
bWVtb3J5IGludG8ga2VybmVsIHNwYWNlLiAgU28gU21hdGNoIG1hcmtzICJhcnJheSINCj4gYXMg
dW50cnVzdGVkIHVzZXIgY29udHJvbGxlZCBkYXRhLg0KPiANCj4gSG93IHNob3VsZCBzbWF0Y2gg
dHJlYXQga21hcCgpPw0KPiANCj4gICAgMjI3ICAgICAgICAgYXJyYXktPnNpemUgPSAwOw0KPiAg
ICAyMjggICAgICAgICBrdW5tYXBfYXRvbWljKGFycmF5KTsNCj4gICAgMjI5IH0NCj4gDQo+IHJl
Z2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCg0KU29ycnkgZm9yIHRoZSBkZWxheS4gSeKAmW0gbm90
IHJlYWxseSB0aGUgcmlnaHQgYXV0aG9yaXR5IGZvciBrbWFwKCksIGJ1dCBteSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgaXQgaXMgYWJvdXQgbWFuYWdpbmcgaGlnaCBtZW1vcnkgcmF0aGVyIHRoYW4g
dXNlciBtZW1vcnkuIEluIG90aGVyIHdvcmRzLCBpbiBjYXNlcyB3aGVyZSB5b3UgaGF2ZSBhIDMy
LWJpdCBQQUUga2VybmVsIHRoYXQgY2FuIHVzZSBtb3JlIHRoYW4gNEdCIG9mIFJBTSwgYnV0IG9u
bHkgaGFzIGEgMzItYml0IGFkZHJlc3Mgc3BhY2UsIHRoZW4gdGhlIGttYXAoKSBmdW5jdGlvbiwg
a21hcF9hdG9taWMoKSwga21hcF9sb2NhbCgpIGV0YyBhbGxvd3MgeW91IHRvIHRlbXBvcmFyaWx5
IG1hcCB0aGUgaGlnaCBSQU0gaW50byB5b3VyIDMyLWJpdCBhZGRyZXNzIHNwYWNlLg0KDQpUaGUg
cmVhc29uIGZvciB0aGUgYWJvdmUgY29kZSBpcyB0aGF0IHVudGlsIHJlY2VudGx5LCB3ZSB3ZXJl
IGFsbG9jYXRpbmcgdGhlIHBhZ2UgY2FjaGUgcGFnZXMgZm9yIHJlYWRkaXIgdXNpbmcgR0ZQX0hJ
R0hVU0VSLiBXZSBjb3VsZCBhbHdheXMgY2hhbmdlIGJhY2sgdG8gdXNpbmcgdGhhdCwgYnV0IHNp
bmNlIG1vc3QgQ1BVcyB0aGVzZSBkYXlzIGFyZSA2NC1iaXQsIGl0IHByb2JhYmx5IG1ha2VzIG1v
cmUgc2Vuc2UgdG8gZ28gdGhlIG90aGVyIHdheSwgYW5kIHN0YXJ0IHJpcHBpbmcgb3V0IHRoZSBr
bWFwIGNvZGXigKYNCg0KQ2hlZXJzLA0KICBUcm9uZA0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
