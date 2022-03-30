Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F74ECF91
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 00:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiC3WYl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiC3WYl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 18:24:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2122.outbound.protection.outlook.com [40.107.220.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459D3D1D6;
        Wed, 30 Mar 2022 15:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XusHHFp7ES4zGpxOaZmj1y4f6lqmLQlmiQEa20PQ3cVyY4JiUNTI4C4ZXj0O7NjrFFWhhvdgu+XseVWw8l18ld/y6UYo8ZseYX2JlODEW5G+0M3dpNaXEPY/j5b8QxDnEV0GenPbNksyFVnl1Dc9FaEetBzL8s9lOwx32mscuNQDlfT2wNgn0PJutIBo1xdnQl/d7xIp0gK3NhMJU87eUuXbbGiIWoUJI829Jldz9cVs4rfhY+ySHGomnWzNuKqVSit2W0+Yp0mkNxT0yLVakS1V3+R/fR/pV6i2F+IK2aYsSDkFMg9VZqXhGW0kTpNNesULiD6Vq9x63Km/M6ujHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUV2gZ1ZLVS9B0Ekm+Cz8C66aQNMQba/onju2UF4b0I=;
 b=V9jTVHqrv7e3V0g+5c78hbcwsDsGOhp2GaU49LEmHpOyGFjeCCmrbPikR9GQhfN2S+pM9DLHy30aG6AzB3z/QWKG3y2FrgOmaleNJxJ5dL+LYgGP+6bzlcPj0XpdfiM4SCuFM4mj+saAHl7Ql4LLcvEWQu7z9KOYRBf3n6K40ggfAm0O55AX+xSc9kwnFmxhA8UL4RCUV1qzgoJQ0JHgNDe7YrnO+1zfzziUvvuA2kgdGFsvOUUtH1UJ6KMkK8INTBewmRSpvTEx5ThJ8Z1kDv+K3jZEeZz8S7thsPYOAqGe8nh0NgOFIJpWe1PINtRlZyjZV+gj4fAr+mkOCHvKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUV2gZ1ZLVS9B0Ekm+Cz8C66aQNMQba/onju2UF4b0I=;
 b=CzXbm7x4b/m4CL/3u7GMz4GxHH6ja3xvgoSxzpRD71GRbM22tUV1B7SYNYjsKBtVUQNIIWHeNSzqReLG2St4zHlcxNN0bpHW585iLptoMOf355SAJqGqTdfIfUum4rJSUa2coMJYwR88KIGFOllmHxUSnroiP52HtnK/JerAD24=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2553.namprd13.prod.outlook.com (2603:10b6:5:cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.10; Wed, 30 Mar
 2022 22:22:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 22:22:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.18
Thread-Topic: [GIT PULL] Please pull NFS client changes for Linux 5.18
Thread-Index: AQHYQ6Q4oVl0Qpju8kuE1WA18VVEPazYPZGAgAAdHgCAACdrgA==
Date:   Wed, 30 Mar 2022 22:22:52 +0000
Message-ID: <4eed252caf56f16c290f0c54b5d850d4eab5dc1b.camel@hammerspace.com>
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
         <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
         <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com>
In-Reply-To: <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9892ffe-f082-424c-6f41-08da129bd4d8
x-ms-traffictypediagnostic: DM6PR13MB2553:EE_
x-microsoft-antispam-prvs: <DM6PR13MB25533CBB9B1862C0D4D60F0FB81F9@DM6PR13MB2553.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sv9rnj0Xv9ICcRhhRrXuVX0YFZSnZlbUnXpKUDV9aa/5vtcb5Bfvs5sIIwmYuGZYnCzy3f/37EbEnESD7xSo8kzU+lxtm3mSEJiW8F5qFMppNxexM6NFQahe+Mv4tsw2hExOD2hwiuAhir4i2HHPcqAmOrBK4vRpMky1lq93Sua8szEmae/czHVyIj6rl1YQsNlwcBY3bwrWMBRd39XxH7/3lHQg3wjCUYyOILKC/53Tum96Xd43ay/uJd6+5+Mx7/1Fbu908GNZKf21epBsvg5sSALGIcunxaks3uiYkBMqKPwZqox7lTKjVpW+FWuSWKMMroQjKsjeC5ueoWYGD9XuNVHKJqsCOkGnqROgFdCZRaz+zMEx/H6+MwFuhnA8JFfS4cLmPwpEJtJZAazbBmMhRd65gYI4Lk8+6sFor28aZPYWgYXW2JnldTlOjXaChl2AEY/ffx81JmczMH6c34lXTBrKNjQjZiPXLZlvOThRM3/FWwn6/G0QAMjEWAXsvy0Vhlaax95V+bf/tR2cRgDm0QgbANaATiSfD4kVTTWkxn4lQ8lTpqBcrjwPEdbLtys2haLmN+ZpUTwWEXijSlfdkKpNn67neTxP8tk9G2d2Q3RLvqnb6pLSy06b2VlwJOlw3915aKN/Qg/krddVdEgxlZSkaflhD+kb/YAXPgmI0rh7qBZRKFwCOZdRaa7dQDA8T84LTqyAmbpYBvtXuusoHjzacdxl5IW8b2McBHfF28rrUho03KMcIRhBHM/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6506007)(8936002)(6512007)(36756003)(6916009)(54906003)(2616005)(26005)(86362001)(316002)(186003)(53546011)(71200400001)(38070700005)(5660300002)(2906002)(508600001)(8676002)(122000001)(6486002)(38100700002)(4326008)(66556008)(76116006)(66946007)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFNPcmdxUHFseG9TZ2xCMVRCdWRpM2Z4S3F2enY2eVRYRTExR2hoU1ZpVGxr?=
 =?utf-8?B?aEl5eVRaOHpmeHJkM2s3dHhhS1h1MGdQeld5VUpWZXdQNUN5YkJMNjJ1Mml1?=
 =?utf-8?B?eFZWemhkdVlvdWZpYjBVOXowZnZQbUIram83aWM4V1ljWnBZei9Nd0o1K0d6?=
 =?utf-8?B?dEJZbi9ra0MraUxmeTlUNFEwVWhJT1dWbkhxN2FnYXhTM2NYbzFnS0F4OXoy?=
 =?utf-8?B?bG8xc0lLbllxdkcxN2NJd0FoRzJNLzdnU3VlUUJmZTI1L1RYMlMvN0lFYmpC?=
 =?utf-8?B?K1NBTXAxc1VnY1pUb05Hb3hKRU1XL0hobERzYXhkUDhVTzZPQmZOZlNkYUlY?=
 =?utf-8?B?NnBlVWZidzRubU9RVEpIMDRjKzJZUE1LSHFZNHRIWkR3N3Y0Mjl4MVI4WFYr?=
 =?utf-8?B?aDZpbDhZUlNUREsrd09RNzU3ZjhXTjVkS0MzWWpONjYzN2Zhd2p1YWFqZlJW?=
 =?utf-8?B?dW04QzhQQVlzaVJieStuelpFRTNwTlplSzcvamhPTGZMOHhzU3NnTkpadTZK?=
 =?utf-8?B?TXE1Q0xqZkFZWmlIUS9YWTFJaloySHdJRkh6L09jWFNTZHNoQUNWcDY0VnVz?=
 =?utf-8?B?Ry9CeXhBaDZCUExSNUhlV3RqcTlQYWJWc0hUNGU2MDRLN0xDVUlWK0lZWFFt?=
 =?utf-8?B?UVMzNmgvUzZzSTB1MkNxQkNERDE0UjE2dlBjU2hGWmJ5bHZRbUlpZnBDTWNq?=
 =?utf-8?B?cGZnOUFUM2hsU2hJRDJHUUFGamRHT1hwL0s2blNraTE4R2Zxc1B3Y21rWmdI?=
 =?utf-8?B?Y2JsOFpPOUxuMEdUZWEvY1ppVkF3REVZSDlIdmNBQmZXMHBXc2hsYXhMN1pE?=
 =?utf-8?B?MlhjeDNtK3BUV0tVWVJQUlp3bzFOZ2F1c2VlTmlwcXZqSlVscEJKWmppQVR5?=
 =?utf-8?B?enowa1oramtTUS9TR0JHMGVqSUJ1WVh6OTAvZU5KRzQxaExPSzZRRWF5N0pQ?=
 =?utf-8?B?Z1FjNzEzTXFtMHVJNFpidVVBcXdPa3hUT0ttakNQalNJM2RwSmZXcGVsSW1S?=
 =?utf-8?B?NTFGK2FJMkJwTTBtZVVJWk44VWhEaUdDYndOUzJvZmZNdkorN2dJYWEvUFZ2?=
 =?utf-8?B?anFkcHBNVkplaXMvdUVQbzdvUzA3ZFNoeXA4Ylp6QW54dGtueitsSCt1SVA5?=
 =?utf-8?B?VEY4Z1cxTDF3UXhoR0xvRjRUYW5US3g5SjRFN2V4NnVtQmdUY3Z0a3krbFNs?=
 =?utf-8?B?RmY5VnlxQ2VGRnJaeGpabk56ZEF6THZIWnJEcWVGNnhCeFZLdWliU0dOTHR3?=
 =?utf-8?B?UFZITDhXZ1RrSGJHWTI2bmE4Wlk5REV1V0psKzd4UXZrVmF1YVI2a0xqWTYy?=
 =?utf-8?B?eTgwK1lHazAzbStSQ21nUG94MDd0WUw4ZXlWVTREaEZwZWFNWUZYS0dXTloz?=
 =?utf-8?B?OUFiTHREMzlWVmFQNEtuOTVjYlRUQm1GM1daVW5JU3dVV0dHVzBKU1VHOGdo?=
 =?utf-8?B?dk1XU0grSWxta2owRHNFY0Nsa2dhT3d4aUpCaysxUnVzYUF1OTdkcG1ZT2FC?=
 =?utf-8?B?R2JMc0FENmZZQ284bys5WCs5aC9jbEl0b29vMjFXQ3o1RHlBQk0waEV4UGZr?=
 =?utf-8?B?cTFobEVuQVpuRXg3TDBxTG00M0Y3Ymc1ZTdMYm1hRWZwdlh3cGlLQWcxMUR5?=
 =?utf-8?B?QmR2RHVUQ28wdVQ5Rzh5dXNVR0hqK3N1aTdqNmcwN0dPTmsxcWdTQTlLZWtz?=
 =?utf-8?B?NzlBTXowaVZJWU5yL1dXNG9OTURJQ2tWS21jZUJRVFFqb1JkdjNqcEV2M1Va?=
 =?utf-8?B?eWxFdzFJelVtUTdkM0QwQ0d3TmtQUDdBaXJsUm11dm4reHc1RVpqQzR3QW9B?=
 =?utf-8?B?ek5FUTJpejlXOHhLVktCMW5rRmtRQ1NqTTZ2NVF6WWhSS0MyR09tREFNRjJ4?=
 =?utf-8?B?bmVmRm9BSG80cHcrTjdpeWJPVFEwNVR6N2czbXZJeFNvMUtnUHFWaW5PTFEr?=
 =?utf-8?B?TUFaamFLMU9vOWtHMTZ6S3JMRzJUNTQ4NTkrRFBzaUxXSHQ1Y3NOdkRlM2F3?=
 =?utf-8?B?TWRtaFJXZ0dqS2Z4andLZk1lNzR6bEtHOFZrQnRENU8yN050NVlCbGI1Mmpm?=
 =?utf-8?B?aHlVNVZxdjR0RXNXWVhXTkZjS3QrK0QySkJIdVNwejNiTGZLVGN3R1Evckpi?=
 =?utf-8?B?TkVlVU5LRlpWV2xxb294bkZRbTE1emFCZE41S1UrWmtINlZEUUJoQjhCdUtW?=
 =?utf-8?B?dlZ4L3k1NDI5OEhDR0dBNm85eituNEh5U1lGelBKRUZ5YWJ4aGhnalJLVitw?=
 =?utf-8?B?VzVwcVhGSi9xOFE2S1d3VVR3dFRRalpoV2NLdGpsVk4yTHV5Y28raGtjUm0y?=
 =?utf-8?B?UkRIYjI2TTFYQnJ6cmJXZmF1aFg1NGl3bEkrNTF5S0NycDlXN2h2Njl5Q25Q?=
 =?utf-8?Q?NDrY8sru3QdeNeu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <977A16527FC77C49B389AD230B870F35@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9892ffe-f082-424c-6f41-08da129bd4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 22:22:52.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0thXlRYcewr1QHmNbD+ibPXuHksOOW3TdmPBJY2QJTyjPzIf4SpBZiawReP98KyXCme21zHjHKV04lIb6XZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTMwIGF0IDE2OjAxIC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMi0wMy0zMCBhdCAxMToxNyAtMDcwMCwgTGludXMgVG9ydmFsZHMgd3Jv
dGU6DQo+ID4gT24gVHVlLCBNYXIgMjksIDIwMjIgYXQgMTI6MzYgUE0gVHJvbmQgTXlrbGVidXN0
DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gLSBS
ZWFkZGlyIGZpeGVzIHRvIGltcHJvdmUgY2FjaGVhYmlsaXR5IG9mIGxhcmdlIGRpcmVjdG9yaWVz
IHdoZW4NCj4gPiA+IHRoZXJlDQo+ID4gPiDCoCBhcmUgbXVsdGlwbGUgcmVhZGVycyBhbmQgd3Jp
dGVycy4NCj4gPiANCj4gPiBTbyBJIG9ubHkgdG9vayBhIGxvb2sgYXQgdGhpcyBwYXJ0IG5vdy4g
SSd2ZSBvYnZpb3VzbHkgYWxyZWFkeQ0KPiA+IHB1bGxlZA0KPiA+IGl0LCBidXQgdGhhdCB1c2Ug
b2YgJ3h4aGFzaCgpJyBqdXN0IG1hZGUgbWUgZ28gIldoYWFhPyINCj4gPiANCj4gPiBJdCdzIGNs
YWltZWQgdGhhdCBpdCdzIHVzZWQgYmVjYXVzZSBvZiBpdHMgZXh0cmVtZSBwZXJmb3JtYW5jZSwg
YnV0DQo+ID4gdGhlIHBlcmZvcm1hbmNlIG51bWJlcnMgY29tZSBmcm9tIHVzaW5nIGl0IGFzIGEg
YmxvY2sgaGFzaC4NCj4gPiANCj4gPiBUaGF0J3Mgbm90IHdoYXQgbmZzIGRvZXMuDQo+ID4gDQo+
ID4gVGhlIG5mcyBjb2RlIGp1c3QgZG9lcw0KPiA+IA0KPiA+IMKgwqDCoCB4eGhhc2goJmNvb2tp
ZSwgc2l6ZW9mKGNvb2tpZSksIDApICYgTkZTX1JFQURESVJfQ09PS0lFX01BU0s7DQo+ID4gDQo+
ID4gd2hlcmUgdGhhdCAiY29va2llIiBpcyBqdXN0IGEgNjQtYml0IGVudGl0eS4gQW5kIHRoZW4g
aXQgbWFza3Mgb2ZmDQo+ID4gZXZlcnl0aGluZyBidXQgMTggYml0cy4NCj4gPiANCj4gPiBJcyB0
aGF0ICpyZWFsbHkqIGFwcHJvcHJpYXRlIHVzZSBvZiBhIG5ldyBoYXNoIGZ1bmN0aW9uPw0KPiA+
IA0KPiA+IFdoeSBpcyB0aGlzIG5vdCBqdXN0IGRvaW5nDQo+ID4gDQo+ID4gwqAgI2luY2x1ZGUg
PGhhc2guaD4NCj4gPiANCj4gPiDCoCBoYXNoXzY0KGNvb2tpZSwgMTgpOw0KPiA+IA0KPiA+IHdo
aWNoIGlzIGEgbG90IG1vcmUgb2J2aW91cyB0aGFuIHh4aGFzaCgpLg0KPiA+IA0KPiA+IElmIHRo
ZXJlIHJlYWxseSBhcmUgc29tZSBzZXJpb3VzIHByb2JsZW1zIHdpdGggdGhlIHBlcmZlY3RseQ0K
PiA+IHN0YW5kYXJkDQo+ID4gaGFzaCgpIGZ1bmN0aW9uYWxpdHksIEkgdGhpbmsgeW91IHNob3Vs
ZCBkb2N1bWVudCB0aGVtLg0KPiA+IA0KPiA+IEJlY2F1c2UganVzdCByYW5kb21seSBwaWNraW5n
IHh4aGFzaCgpIHdpdGhvdXQgZXhwbGFpbmluZyBfd2h5XyB5b3UNCj4gPiBjYW4ndCBqdXN0IHVz
ZSB0aGUgc2FtZSBzaW1wbGUgdGhpbmcgd2UgdXNlIGVsc2V3aGVyZSBpcyB2ZXJ5IG9kZC4NCj4g
PiANCj4gPiBPciByYXRoZXIsIHdoZW4gdGhlIG9ubHkgZG9jdW1lbnRhdGlvbiBpcyAicGVyZm9y
bWFuY2UiLCB0aGVuIEkNCj4gPiB0aGluaw0KPiA+IHRoZSByZWd1bGFyICJoYXNoXzY0KCkiIGlz
IHRoZSBvYnZpb3VzIGFuZCB0cml2aWFsIGNob2ljZS4NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIExpbnVzDQo+IA0KPiBNeSBtYWluIHdvcnJ5IHdhcyB0aGF0
IGhhc2hfNjQoKSB3b3VsZCBoYXZlIHRvbyBtYW55IGNvbGxpc2lvbnMuDQo+IFNpbmNlDQo+IHRo
aXMgaXMgdXNpbmcgY3Vja29vIG5lc3RpbmcsIHRoYXQgd291bGQgYmUgYSBwcm9ibGVtLg0KPiAN
Cj4gSSBkaWQgc29tZSBxdWljayBzdHVkaWVzIGFmdGVyIEkgZ290IHlvdXIgZW1haWwsIGFuZCBp
dCBzZWVtcyBhcyBpZg0KPiBteQ0KPiBjb25jZXJucyB3ZXJlIHVuZm91bmRlZC4gSSd2ZSB0ZXN0
ZWQgYm90aCBhIGxpbmVhciBpbmRleCBhbmQgYSBzYW1wbGUNCj4gb2YgZXh0NCBnZXRkZW50cyBv
ZmZzZXRzLg0KPiBXaGlsZSB0aGUgc2FtcGxlIG9mIGV4dDQgb2Zmc2V0cyBkaWQgc2hvdyBhIGxh
cmdlciBudW1iZXIgb2YNCj4gY29sbGlzaW9ucw0KPiB0aGFuIGEgc2ltcGxlIGxpbmVhciBpbmRl
eCwgaXQgd2Fzbid0IHRvbyB0ZXJyaWJsZSAoMyBjb2xsaXNpb25zIGluIGENCj4gc2FtcGxlIG9m
IDkwMDAgZW50cmllcykuDQoNCkFjdHVhbGx5LCBsZXQgbWUgY29ycmVjdCB0aGF0Lg0KDQpXaXRo
IDkxNzUgZXh0NCBvZmZzZXRzLCBJIHNlZSAxNTcgY29sbGlzaW9ucyAoPT0gaGFzaCBidWNrZXRz
IHdpdGggPiAxDQplbnRyeSkuIFNvIGhhc2hfNjQoKSBkb2VzIHBlcmZvcm0gbGVzcyB3ZWxsIHdo
ZW4geW91J3JlIGhhc2hpbmcgYSB2YWx1ZQ0KdGhhdCBpcyBhbHJlYWR5IGEgaGFzaC4NCg0KPiBU
aGUgbGluZWFyIGluZGV4IHNob3dlZCBubyBjb2xsaXNpb25zIHVwIHRvIGFib3V0IDEwMDAwMCBl
bnRyaWVzLg0KDQpUaGlzIGlzIHVuY2hhbmdlZCwgc28gd2l0aCBYRlMgYW5kIGJ0cmZzIGFzIHRo
ZSBleHBvcnRlZCBmaWxlc3lzdGVtcywNCndlIHNob3VsZCBub3QgaGF2ZSBhIHByb2JsZW0uDQoN
Cj4gDQo+IFNvLCBJJ2QgYmUgT0sgd2l0aCBjaGFuZ2luZyB0byBoYXNoXzY0KCkgYW5kIHdpbGwg
cXVldWUgdXAgYSBidWdmaXgNCj4gZm9yDQo+IGl0LiBJIHNob3VsZCBoYXZlIGRvbmUgdGhpcyBz
dHVkeSBlYXJsaWVyLi4uDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
