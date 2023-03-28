Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019BA6CC479
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjC1PFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjC1PFU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 11:05:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2118.outbound.protection.outlook.com [40.107.220.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1FEC52;
        Tue, 28 Mar 2023 08:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYw0l4UXtAuMbQNb9PdGgI88iiS6A4wiR20sC+Zwbl6rPAvfhVhbX58OPtuip+ECw+IjNW+0CPmi3I75zNWPTqNsEsRfv+hQpYE6iw8fhj4VjX3NS/kqUuCmg7hrnxgUzaBKFcGO5r06mIDVekw6tJxVMIdghLpjzQfALBTDLHtwdRspEFi77aXKfOjvqWz52Da8vq6jpL/sXRZJmbpTOejI757xqZRL/bBdV/3rUaang1Oa/0C15zCDYjB/ArpgsxKjnc/gceG+qDRhOwk/eEZgsNNmvMTNy7mR0JlyI6YIAQmwZuF57A7v+GC/xUad9kgCbQ9zEdAl9q8FwkNxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSPJYFIed4F2uPmNXEQzSKIjvKEEzWu8gvOOFXQ84kY=;
 b=PsP4JrvNTw7XFBNYM6COdv0j3qeYIq4B7wWfnccesX8E75/wkoXU5d20kYCyHfwhEFucBokHpAf0KQkbmVN/AcCJus242KMJ3gxHv8jFjESEAcMZBu8bkiOBfMYkojPSfaFyy+mVlyT7Y2796eW3BTDpW+Yq4+yJPMAPBOe7V4ws6GJRe8zpcPdns3VjHcDmwEJnaTzQG3JkhXlxy7Nm2RLqOlqlXlq+fq424kW1GGl8eHa9YTFeOU0v/ydbxl0nIUeEkMkYU5FdTTW0drwieBuOW8Et1wFiFMY/K7ALT1QYqr6nSIZ59Xz5Z+0iY7qy6PJYJC3D4WWDTmK9act9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSPJYFIed4F2uPmNXEQzSKIjvKEEzWu8gvOOFXQ84kY=;
 b=gXyHTSXZRANlx1LvXeiuOT1qp+4FFNvHbD58keNP+k53vq0p5gU4GIIBLzxZIMqDr/Auens3F/1tIJ5WLAO61DhgL9QP0R+wp/AsIIzOmUYc+XT+//25C/Dj9URi4ec7vwGZKL4fL9OXjnNqmrpXs8gAEo93TVQ/7t4eZeRThAw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4796.namprd13.prod.outlook.com (2603:10b6:510:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:02:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 15:02:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Topic: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Index: AQHZYUaR/53jDx68k0Sm+k98CUAcnq8QMzwAgAAWuYA=
Date:   Tue, 28 Mar 2023 15:02:13 +0000
Message-ID: <FF31002F-003E-4C43-8FC7-E2250788F516@hammerspace.com>
References: <42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be>
 <2968C736-0150-4AFC-94BE-F9F8C2859F3E@oracle.com>
In-Reply-To: <2968C736-0150-4AFC-94BE-F9F8C2859F3E@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB4796:EE_
x-ms-office365-filtering-correlation-id: 8535160d-6be3-4381-b385-08db2f9d69f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cjh8YdsNMOk7CDhUBrbDgeVipywVLpS+QwS4V9EvbRvSDWraxR2Artqsqx5bZduuNxL4k0/lrJuFoif6kbvlGYiJdfGMtE+IjInTrdt5z8ToUQGt9jK21YitveqZnEVLvORWSmmu3OgglyQBjAQapQ7PqeLYGQP+J4pdgoEbMnnyQTaQNKDkQ723QXvwu1nmdz857ABbOAqF1amzPY2ThAJu6nB3DqHCS5CHGb8WS5PhO3O9GkeoPJPhvx+pzthh+oYq4d1euMXwjYgpk2zU4BscGdg7eTO1Btd2zaF7ywHAYPX2auHoWAezUzQsV9aZ0isnSNihiR0on9YrB+T9bEty7qL4N2y3mNQvCMKXsEttoAipyuL4K3eqcUJpgxgGEomoFSXblmt3A7WT6cMXw50+bCn0X43TOgIfs1KFnWI10tCJyh6uDgC1pLtHuXg2EQFRGxyAW1uv6XY4cX8mj26fgcFukQkqsXm1dVLmtXUwYzozfUDhM1boD17B5tct4kMPV3JFkYvYS1Hck7gO8QwKHzdVpq5Boi6pLcvRoEmSArlVu3BeOkARTVIfvWGDN1pPrdVOl4eKnXrBcqmvtkeDY7D1vBBa42pQTsm7qfSUEJ33Bvm9ane5T1+VUrDr7UIkAEwHcMkI1WkEGfOdQKtbOi2Ld58Bv7dMHMoEV/qjaHWJKSztR2dKwwBeVdG1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39840400004)(366004)(346002)(396003)(451199021)(41300700001)(66446008)(64756008)(8676002)(6916009)(66476007)(66946007)(76116006)(4326008)(66556008)(186003)(2906002)(36756003)(38070700005)(5660300002)(66574015)(83380400001)(38100700002)(86362001)(33656002)(122000001)(8936002)(2616005)(478600001)(6486002)(54906003)(966005)(71200400001)(53546011)(6512007)(26005)(6506007)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1hXelVvTjlSUG5yNENnMHF4S2ZLSEZ5d2xLdEdSVVJPcjQwS3V3QkdFZzVQ?=
 =?utf-8?B?NFNTQnluZ1RGSldKcmhiMHVwYjlWTUJ1THR0RE9OU3ozUVhMbGtTcGFzbHlR?=
 =?utf-8?B?b3pMcVZZWmxJWWlUUy91bDd5YjgxWDltc2ttL3ZtOHZ2ejJYOUZuSndxVTF0?=
 =?utf-8?B?dEFOODI2WEc4dDgxZUNIRld1blh6VFVnb1lTK08rNnVXTm0yNW1PYUJ1Yk9v?=
 =?utf-8?B?V0h4eG1pVS9WTkpyVVNod0RzWXFzNi9EemVLOHJMRUxFcXBwSnhLeURuTFpR?=
 =?utf-8?B?M2VtNTRBWUVVL1IraHNPREZhSnY0SEVoekJRcG9vL3UzNU5DK2ZzeXBVa2xN?=
 =?utf-8?B?ZmlHZ3NPUzFZcmZoTDBId3E0SU1nZVNzdmJ6RUprNlJjWmw3dTVieGhmOEQz?=
 =?utf-8?B?VGlqZkFsMUF3UGZnWS9TcUQ3UHl6Z3FJN0hnd0U3UUltNVNieVlqSmtzK1hs?=
 =?utf-8?B?dDdGNllmQTJYalhxbUtMSFZmQmVWSG5rMWtKRXl2WlBqNy9DeHNOaXhPemJZ?=
 =?utf-8?B?Q25JLzFoVHl6YzZaenJpditYM2xjMzVpQkJROHoyTzg3QTRRZ01CM1NRZjQy?=
 =?utf-8?B?TzlOeVRveGxSbUs5SlFBN3dXWVVBcHduR2tTaUo1T29FUlFyV0gxODZzdEEv?=
 =?utf-8?B?YnZrZlV1a3I4K0xPak40b21SY29NbjZ1U3BIUkt1OTVYZ0NpeGJORHE3T3lr?=
 =?utf-8?B?cHdTeXVUcnYrc0FKcStibFduVGFXZnZPdmRFbXowZitZNGpDWWdCcjN2eGVu?=
 =?utf-8?B?Z01PdFNCQjczR2NHK1NOaUFUUHRyMUl6bTFHaHB5enBpZ09DOHVlUVBKcVh0?=
 =?utf-8?B?UzhBNEZwalN6ZDF3YzNkL2U1QVF5a3RwTjFVaDl1YS9aTVRYMEhwdmt1eVU3?=
 =?utf-8?B?Uy9iUVlRQTRLOU1hSldvbWlBd1MzanNKMGcwMUMvMkZ6Uk5SZnJGT0toSlpU?=
 =?utf-8?B?T1J0RU1JS2RIYnFRWDh5VFpsT2hFdWxEclZaSFZVTmJtZVpBUm1GdnhGcGNF?=
 =?utf-8?B?QWw1OVRqMFozNEE5RW1YRXd3S1RnVG93Q21VTlV3aFBkYnV6bzg3VFlpcVdy?=
 =?utf-8?B?T1hOY3NrYjlVOHhidGYzcnNsdWN2VUJZOUplOHVWS1BOc3E3cUdjekV6V09S?=
 =?utf-8?B?a1FlWWpRUFhoSGlHeVNwNWdOR0lmTjRWbFBJdUVkM2FBNUt6YWJCdGE4ZkZT?=
 =?utf-8?B?Vm5HSEFsZVNkMjBwVnlCMnhDa2haMFRVeHdjWlNRS2ZqSXkyOTJTWEl6S3Bw?=
 =?utf-8?B?RFdKeEFhVHdpc09qSjQwZEtMdUw0dlFhUzBUWnhsbnhDN0JtdEZBODNwNVJN?=
 =?utf-8?B?OHlaUjVISTM2VmtlNXdPY2FDd0xMdWp2emZTcnFXd3JHK2pJQXJnOXM1RDN5?=
 =?utf-8?B?Mk94bjVuenFyZnlFbXluYnRBWkIremIvc1ZJWXI3UDYwSzlPV2V1LzQxd1J1?=
 =?utf-8?B?Q2lkWkRKL2RPNjRMSWFGOENOZjl5eVlkWDVqMkplV2FMaFZkdzcwRnhKT2FQ?=
 =?utf-8?B?dGFzSjlqcVVhS2pDS0dDWXU2OUZtV0F1eGxUVDZCTGRFaURkVXBNY2MwN2c0?=
 =?utf-8?B?cHVwK3dkN2krUFUwTW5tak05WlFrMDA5RDJuNFA0bU5CSzhreElTK2lTNWJB?=
 =?utf-8?B?OHFydWZQY1BnMUFIK1UwNGJPY1hrd003N2UySEtKdkFNclhHeXYxMUtjcWJr?=
 =?utf-8?B?TlpJS1V1ZHczcXRKNVFIdVJlUUMyTlRwaDY0RTNWcDdpd093SmxtWHNYU2hB?=
 =?utf-8?B?dTR5RVJIRVRuTTZVazJjZXAxaUIxWmN5WHp2TG53bFZ2Vzdoa3JqSERQTUwv?=
 =?utf-8?B?OUZXd29Ub3JFRThjTE9KQ29oYlJqTW9YY0wxejhOc0k5NExFUkFTU0dBZWhm?=
 =?utf-8?B?TEJsSCt4SlluOXE3dWFTYWtMQkYvczF5dU5YYndLeGU4MlRFR1UrQmZUU1h4?=
 =?utf-8?B?V3AvS1ZMYTZIZTBFbHlaa3V0ZmQxcWRadEw2a0YyZW5UQUhBYmRvb0djRk1o?=
 =?utf-8?B?VUVGcS82Titpcno4cTNxZWYySklCQXM5cm1MVkQrWExORVB3Z2lnaldwbk1i?=
 =?utf-8?B?SEFlUTNyOVErVDh6a2xqSy9LVW0vZXplcHFVL2tFWDk4TFJzeEhhNnphc0dG?=
 =?utf-8?B?WjlyREp4bDhvNnNtbG8xYkFodU5kZURCZVhFK1lhQllRN3IveG01WDVJUWlk?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7873699D90A1D4A9349821BA96037E4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8535160d-6be3-4381-b385-08db2f9d69f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:02:13.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnO7bNamD6b/RoJHWwSXqYUMBA9y0pI6+FEI57xzFjl7wGwUwm9FQ6C4lja54CZ8YLo+LHRGjKVZZLfXTYyXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4796
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDI4LCAyMDIzLCBhdCAwOTo0MCwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIE1hciAyOCwgMjAyMywg
YXQgMzoyNSBBTSwgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4g
d3JvdGU6DQo+PiANCj4+IElmIENPTkZJR19DUllQVE89biAoZS5nLiBhcm0vc2htb2JpbGVfZGVm
Y29uZmlnKToNCj4+IA0KPj4gICBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRl
dGVjdGVkIGZvciBSUENTRUNfR1NTX0tSQjUNCj4+ICAgICBEZXBlbmRzIG9uIFtuXTogTkVUV09S
S19GSUxFU1lTVEVNUyBbPXldICYmIFNVTlJQQyBbPXldICYmIENSWVBUTyBbPW5dDQo+PiAgICAg
U2VsZWN0ZWQgYnkgW3ldOg0KPj4gICAgIC0gTkZTX1Y0IFs9eV0gJiYgTkVUV09SS19GSUxFU1lT
VEVNUyBbPXldICYmIE5GU19GUyBbPXldDQo+PiANCj4+IEFzIE5GU3Y0IGNhbiB3b3JrIHdpdGhv
dXQgY3J5cHRvIGVuYWJsZWQsIGZpeCB0aGlzIGJ5IG1ha2luZyB0aGUNCj4+IHNlbGVjdGlvbiBv
ZiBSUENTRUNfR1NTX0tSQjUgY29uZGl0aW9uYWwgb24gQ1JZUFRPLg0KPj4gDQo+PiBGaXhlczog
ZTU3ZDA2NTI3NzM4Nzk4MCAoIk5GUyAmIE5GU0Q6IFVwZGF0ZSBHU1MgZGVwZW5kZW5jaWVzIikN
Cj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+IExp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzAzMjQxMzA3LmY2
TmVXOWdaLWxrcEBpbnRlbC5jb20vDQo+PiBSZXBvcnRlZC1ieTogTmlrbGFzIFPDtmRlcmx1bmQg
PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci9aQ0c2dElvejBWTjZkK295QHNsZWlwbmVyLmR5bi5iZXJ0by5zZQ0KPj4gU2ln
bmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4N
Cj4+IC0tLQ0KPj4gTmZzcm9vdCAoInJvb3Q9L2Rldi9uZnMgcncgbmZzcm9vdD1hYWEuYmJiLmNj
Yy5kZGQ6L3BhdGgvdG8vZnMsdGNwLHY0IikNCj4+IHdvcmtzIGZpbmUgd2l0aG91dCBDUllQVE8g
YW5kIFJQQ1NFQ19HU1NfS1JCNS4NCj4+IENPTkZJR19ORlNEX1Y0IHNlbGVjdHMgQ1JZUFRPLCBz
byB3YXMgbm90IGFmZmVjdGVkIGJ5IHRoZSBzaW1pbGFyIGNoYW5nZS4NCj4gDQo+IE1ha2VzIHNl
bnNlIHRvIG1lLg0KPiANCj4gSSBjYW4gcXVpY2tseSB0YWtlIHRoaXMgdGhyb3VnaCBuZnNkLWZp
eGVzIGlmIHRoZSBORlMgbWFpbnRhaW5lcnMNCj4gY2FuIHNlbmQgbWUgYW4gQWNrZWQtYnkuDQo+
IA0KPiANCj4+IC0tLQ0KPj4gZnMvbmZzL0tjb25maWcgfCAyICstDQo+PiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Zz
L25mcy9LY29uZmlnIGIvZnMvbmZzL0tjb25maWcNCj4+IGluZGV4IDQ1MGQ2YzNiYzA1ZTI3ZGQu
LmYwNWMxM2NlMDE1NWJkNjkgMTAwNjQ0DQo+PiAtLS0gYS9mcy9uZnMvS2NvbmZpZw0KPj4gKysr
IGIvZnMvbmZzL0tjb25maWcNCj4+IEBAIC03NSw3ICs3NSw3IEBAIGNvbmZpZyBORlNfVjNfQUNM
DQo+PiBjb25maWcgTkZTX1Y0DQo+PiB0cmlzdGF0ZSAiTkZTIGNsaWVudCBzdXBwb3J0IGZvciBO
RlMgdmVyc2lvbiA0Ig0KPj4gZGVwZW5kcyBvbiBORlNfRlMNCj4+IC0gc2VsZWN0IFJQQ1NFQ19H
U1NfS1JCNQ0KPj4gKyBzZWxlY3QgUlBDU0VDX0dTU19LUkI1IGlmIENSWVBUTw0KPj4gc2VsZWN0
IEtFWVMNCj4+IGhlbHANCj4+ICAgVGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciB2ZXJz
aW9uIDQgb2YgdGhlIE5GUyBwcm90b2NvbA0KPj4gLS0gDQo+PiAyLjM0LjENCj4+IA0KDQpIbW3i
gKYgUGVyaGFwcyBpdCBpcyB0aW1lIHRvIGp1c3QgcmVtb3ZlIHRoZSBhYm92ZSBSUENTRUNfR1NT
X0tSQjUgZGVwZW5kZW5jeSBhbHRvZ2V0aGVyPyBJdCBpcyBwb3NzaWJsZSB0byB1c2UgdGhlIE5G
U3Y0LjEgY2xpZW50IHdpdGgganVzdCBBVVRIX1NZUywgYW5kIGluIGZhY3QgdGhlcmUgYXJlIHBs
ZW50eSBvZiBwZW9wbGUgb3V0IHRoZXJlIHVzaW5nIG9ubHkgdGhhdC4gVGhlIGZhY3QgdGhhdCBS
RkM1NjYxIGdldHMgaXRzIGtuaWNrZXJzIGluIGEgdHdpc3QgYWJvdXQgUlBDU0VDX0dTUyBzdXBw
b3J0IGlzIGxhcmdlbHkgaXJyZWxldmFudCB0byB0aG9zZSBwZW9wbGUuDQoNClRoZSBvdGhlciBp
c3N1ZSBpcyB0aGF0IOKAmXNlbGVjdOKAmSBlbmZvcmNlcyB0aGUgc3RyaWN0IGRlcGVuZGVuY3kg
dGhhdCBpZiB0aGUgTkZTIGNsaWVudCBpcyBjb21waWxlZCBpbnRvIHRoZSBrZXJuZWwsIHRoZW4g
dGhlIFJQQ1NFQ19HU1MgYW5kIGtlcmJlcm9zIGNvZGUgbmVlZHMgdG8gYmUgY29tcGlsZWQgaW4g
YXMgd2VsbDogdGhleSBjYW5ub3QgZXhpc3QgYXMgbW9kdWxlcy4NCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
