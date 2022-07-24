Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2A57F70D
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Jul 2022 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiGXUSg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jul 2022 16:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGXUSf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jul 2022 16:18:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2091.outbound.protection.outlook.com [40.107.243.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D2DF97
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jul 2022 13:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Hq6RhBXhoEVYM2r2Z5U6avqHRBbttBFu7EpqPkGAHIvLWEVSBpMOwlJvT2TAcjutLiyCH9lm2M8QRIsitrYAzelrjskdaOr0oYK87Se1PAHE9rTTCFNU6fBFLfdvBzUXEgYQqFJhnf/EJk7wLLWIPF+iBhwBs5mt7pkaYvABS48HKera7EBK2d1ESjRqoNC/izMBpz3ELs6uVhwinBWAettMzgNnZsMeurH3nTdc+p/RIKO74ei8uo+qrWgyWKJOmMDgOsB8YN4nHKYC1SwabOB/cveEmXJItsbjk7KhLyKf3dIa3dPPpmaHhARTnONfUZybkzpX/rlh5brK336g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH1RuWRPPgTVVsKoz0n7iXlr5aHnYRzdJyJfeWS+244=;
 b=fV54iusR4nobQAl+wmJqdd7gcYKxCx5Y23QgP0Hpn3ILIhM6/ww+Dw7/8WqvzXZW5x3+4yPpemj1tTe2VJwKuKvzySdjqqPXD0oMBk1VAn/Eez+4yMj7e3W1K5MWRQMRY3r/ngNShAb07oZG2iUkBFQLjnfS/LRNbEiKbPpVWsCqEvLWNsX8K64aXjLeMkom76zIONimBYlQzPvYmtxZbB8VuKsE4WZQ1KXVEQVw9S9YomGE3XfMfFUsrqxGxOa52HBgbojKDEK6KTGTntFL03nRXdwIl+Q3qeFTJ5YsFtu3xa1BmGqIPsGGLrFkhL0nkb2pvdhPh7WgtpaQyIzjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH1RuWRPPgTVVsKoz0n7iXlr5aHnYRzdJyJfeWS+244=;
 b=UDNQDSWVBRYJs3nw+wxkgJlwLV1L0OVpIb5HDlB+/E12EjAyfcXVGDp1hhtlE75A6z87Gtm3+zQY0UQIRHpcRvHomLOquwUL9dmth5mQO6/oyNcHYNCGnqEC+Ee21qebPr1ZQ8+TthZ2HwhK0TWZ3/H4L9EXeNWFYb0wx2ZnfCU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1050.namprd13.prod.outlook.com (2603:10b6:3:7a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.5; Sun, 24 Jul 2022 20:18:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.006; Sun, 24 Jul 2022
 20:18:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "bxue@redhat.com" <bxue@redhat.com>
Subject: Re: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
Thread-Topic: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
Thread-Index: AQHYnfaaDPf4fauhz06BX9UrDdUC1K2N5iIAgAATBQA=
Date:   Sun, 24 Jul 2022 20:18:31 +0000
Message-ID: <94be0eef64eb8ed3236b587484dbe607fe1cf31d.camel@hammerspace.com>
References: <20220722181220.81636-1-jlayton@kernel.org>
         <950a7026534945a1090d4dd671bd56c363bd9417.camel@hammerspace.com>
In-Reply-To: <950a7026534945a1090d4dd671bd56c363bd9417.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 836d6e91-8299-4e02-c691-08da6db1add5
x-ms-traffictypediagnostic: DM5PR13MB1050:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnVZTfQ2veVpVFEzB7S5vi/v1ngwpGWMJm+2mDeljIiGQ4uaezuGREpRPBNFcxmS0VhihIepPw3kMplv7zaua6RnXLZadVKjIwUrA9mamZ/zvtFuqrRSgbukQQZROAwpQ/wTlk78IO4LI585W1oZ4ZhzqhhCMJRxWuDUgNkfQOiz1IIyM5vpG2RBm3t9tALbx8hp9jEkJsbij2Fk5IPttXSr/BHYYDuNvvYvYs0PuOcfEEmyhaGv2JieOcMYwG5Z3BsvM0soRvHZYydwialSerTtvEpq8d/05yGH6y7X3umMcDv5tt6uXJhQvh5VvqvYXVQeEtg2G7xSgwLCvObXnuwJ4ZNDz9q+vj5N9Guaz7LawUrbH/FAgwTetQvMGsOhB8XA4uqbbJjRi2uCSVYYqqUp2rsiGOrPOdSqEhXpa5jqQDVfk0f/+X293w3ns3Zmhri/k0ZAXDJfO4+TqkG9gOml4hiqd6pLH7jB5n5dIsXglOo1nl3YtA9yBpXsv9K4ya68uxiJ9AqZ6sHMx84bq3L/fT10ThDLaMLmx13ktAwVxfMqDZLPp7FnFiTbP5yD/Ws2um6UvzGz7A5ryaMsUzJd4N4g9i8x91KrdDBK7Zt5ctn24ASBAqIHwEtcs8JqrTlWn8/o72+yPxJibw5UZeLYOK+tOvsBX0s0saXnsKIII2SJb8J0RkI5m3gCB+hFZMgTnMeegI9wy/NN5Nhmj9100yH31lMcD9ewsHwA9SDQBDLtZnC81hbuWB1Kf0A0dob0/pg8PhwdmldG0IBlvrxRl76EY7oKvsH6QuYUB1ox6gHziR8C/LJ0QG7U7PsG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(376002)(366004)(346002)(396003)(122000001)(38100700002)(38070700005)(8936002)(66446008)(478600001)(6486002)(71200400001)(5660300002)(2906002)(110136005)(6512007)(41300700001)(26005)(6506007)(83380400001)(4326008)(8676002)(66476007)(76116006)(66556008)(66946007)(64756008)(54906003)(186003)(316002)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGN3MnI2Rnh0K3RvSlhQWHR0ZWNMZjlWRlQ2Sm1ZRWhsWC9tQ1duWCtFYUJj?=
 =?utf-8?B?cVExSzVESzVlQUxuSU9QeFFJbzNZVDErM1d6Z2lrWUNHcmVLTHBibDJVN2Nh?=
 =?utf-8?B?aWthK0Q1NjMvM1NMaHdFdTRWMDNKWXNsMWZOaFM3MjRlT1FYdllkU3VZSjJo?=
 =?utf-8?B?TzFkb1dXRVZrQVZiQnEwSDl6aCtlZjdWZ3ZNQUY2djZCWlN0bjRZa1RyQitW?=
 =?utf-8?B?cFdHeFZSK1lPZlpDZUxPOTBRdnlVOEdVdkVjdHZSNVBUTHl0U1hkblY3MTVT?=
 =?utf-8?B?V3RVK245QkU3N2F0V2R0cXk5aUFmcnFSZFMzMGE3WVpXTHZ4ZUd1bDhBVVQz?=
 =?utf-8?B?anlObzhqamxLRUtyQ1VIUUc0RS9rVm5jVFlWVWlLRGNoU3A2TGNyMjNCM3Za?=
 =?utf-8?B?YXhXcjhKcC9tVWZpWmJvT3dzbG9MTGE1R2ZXTDZWL0VQSVdOVDJkdVhOTThK?=
 =?utf-8?B?dldkTDU0QnNFUGQ0bDhqWU5vZUVJeDhsdjJOSUE5anhqejdFQ1Q4MmZYOURr?=
 =?utf-8?B?bFJUT3dpU0xwQzN4MzVZNWRnUXA1UTR0NlZaVVBIUENPYkNYc1FQVXVXV0ZZ?=
 =?utf-8?B?ZzJtOUZRZW1kb3pQckxtL2FSR3JubEJ2ZkpEYWtWLzNxTFNsc1NqY294M2hT?=
 =?utf-8?B?MkRHUzZjZXdlUWdXMkFNcjJUdHZ6ekJNeGFDNlVOeTFUSHNOTlVBbjVDMnMy?=
 =?utf-8?B?OXAvbTd4NE9lT2w1VEpJclVoeDgwc21vV2c4d2NwNkY4dER4QUpvWlpJenli?=
 =?utf-8?B?cUdRSW5DSlVpUGdEUlBTS0lLMGdBUVR6cFU1YU9qVEhESTh3dUp0dGI5MnRJ?=
 =?utf-8?B?THhGaW5ZdHdqM0x1cUVjZEZhZkxtVXQ2aTJZSWZoTmQvRXNwVFg5ODNkN1I0?=
 =?utf-8?B?NGM2ZTN0cUlFQzYwUkZpK3NmZDZBU1FtTW9XOGRSRFhjMmZ0aFpLQkp3Vy82?=
 =?utf-8?B?akFMemgwWU5OMFJBbUkyUk5XNnJpOVF5UUxzQ01EazliQU1BZDRqdUpJTTQ3?=
 =?utf-8?B?WXFxK2kzaDlnOXR0YkkrckYrOGYrd2xodTdKVzlNOE1EMnc4M1B5OFhweGQz?=
 =?utf-8?B?eENYNWFEUUVtY3ZjaHIwL1djZWpmZ21EY3BxM2R0amR3a0tXMVNDa21zNENB?=
 =?utf-8?B?Sk1ZdjF6d1RDdXZPOVVkbFlOR2xGL2l4OWhXa2hldEYrSnBjNUNNbVN2SmNR?=
 =?utf-8?B?NGM4RVZueVlzU0JWSXRQUkxWam5PbjlVOTdMM3k3NmVCZG45SVlhYjRWaElk?=
 =?utf-8?B?Wm9xdGsrd041Nmoyc3EyS0xNbU9xM3MyVnJ2bmttYmJiOTEvWk5CelZUS0hp?=
 =?utf-8?B?WXNRdnk2Wk5mamsrNWxoZ2hIRDh5U094bnZlU0VIS0lzc3g0SkN0b1J2RDNv?=
 =?utf-8?B?ZWFVeDV5WktnZmdKYWNFMmNFMU14clhOOEFrZnpGL0U1RVpCdSt0T2pGMDlw?=
 =?utf-8?B?U2hkaUxyZmZiYm84MnY3Q3lKTUlaMGErVlhIRjBhYk44MUtsd2syaTlEVmZz?=
 =?utf-8?B?TDIyeCsrMjZZTnovb1g0Y1ZZTmpiZlNoS3Z3YlBKRVFmVVR6UkFCbmJvU2NV?=
 =?utf-8?B?K0diSVkxMzV2UWhnQVh0MUFBTEsyVWVNTXdJMVpoMVJqZVJzaWF3WHk2dGdM?=
 =?utf-8?B?SVJQak1sNk4zdGs1MGtCcWQ1T3ZseFRwWEM1dXh6b3FQL2F5NGF3STBJNExn?=
 =?utf-8?B?T2xQZ044b3VDcE1Wd09jRlkyalJqbmpmdFhYSy81Q2J4NmRibk5HSkpqSkYx?=
 =?utf-8?B?MmRVUXhoeitHUTNreXU1VlNGRGxBR1Ntdi9RTjU5Y3QvU0E2cVJ2OGh4Tm4z?=
 =?utf-8?B?VFRYcXQ3ODE1MVFVd2dqcWEwdHlPM2tYQzY2bmhDV216STdpL1ZMNGZUSnFn?=
 =?utf-8?B?djA3QVdreHkrYy8zZWFvUmJsU0lYNk1aSE1xNzFnbnU1VjlBcWtobGdBTzZM?=
 =?utf-8?B?aTBJUjZ2blJDczZNMnZvdGU4enJWbHg3Y2xZaS9WaVJzamdhMU5PV010Kzds?=
 =?utf-8?B?VyswUUNoZlR4OVhlaGJGcGIydGh5bkZabU1LWENoWG5HR3FxTTdybS9USHlh?=
 =?utf-8?B?TXBpd0lrV090TEpiNXVhV2dMWlFLVHdjT0J0UXVQazh0SFpGNjB3cUxjcWtK?=
 =?utf-8?B?azd3dElYWXJBQTBXaGxLZEdUODZ5bFBROXJBd2pKcmozWkFOTWViRFIvQWRP?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03BC585283441498C1AAB2CC699854A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d6e91-8299-4e02-c691-08da6db1add5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 20:18:31.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjTkHjXyabuwniwS21wiyuYYGX9i/U95xgEAwxJiMngkur8AZOVXxcy2jFjhM5kZIN0fbwNK4mTBlrpy5VxljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIyLTA3LTI0IGF0IDE5OjEwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMi0wNy0yMiBhdCAxNDoxMiAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6
DQo+ID4gQm95YW5nIHJlcG9ydGVkIHRoYXQgeGZzdGVzdCBnZW5lcmljLzQ3NiB3b3VsZCBuZXZl
ciBjb21wbGV0ZSB3aGVuDQo+ID4gcnVuDQo+ID4gYWdhaW5zdCBhIGZpbGVzeXN0ZW0gdGhhdCB3
YXMgInRvbyBzbWFsbCIuDQo+ID4gDQo+ID4gV2hhdCBJIGZvdW5kIHdhcyB0aGF0IHdlIHdvdWxk
IGVuZCB1cCB0cnlpbmcgdG8gaXNzdWUgYSBsYXJnZSBESU8NCj4gPiB3cml0ZQ0KPiA+IHRoYXQg
d291bGQgY29tZSBiYWNrIHNob3J0LiBUaGUga2VybmVsIHdvdWxkIHRoZW4gZm9sbG93IHVwIGFu
ZCB0cnkNCj4gPiB0bw0KPiA+IHdyaXRlIG91dCB0aGUgcmVzdCBhbmQgZ2V0IGJhY2sgLUVOT1NQ
Qy4gSXQgd291bGQgdGhlbiB0cnkgdG8gaXNzdWUNCj4gPiBhDQo+ID4gY29tbWl0LCB3aGljaCB3
b3VsZCB0aGVuIHRyeSB0byByZWlzc3VlIHRoZSB3cml0ZXMsIGFuZCBhcm91bmQgaXQNCj4gPiB3
b3VsZA0KPiA+IGdvLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2hzZXQgc2VlbXMgdG8gZml4IGl0LiBV
bmZvcnR1bmF0ZWx5LCBJJ20gbm90IHBvc2l0aXZlDQo+ID4gd2hpY2gNCj4gPiBwYXRjaCBfYnJv
a2VfIHRoaXMgYXMgaXQgc2VlbXMgdG8gaGF2ZSBoYXBwZW5lZCBxdWl0ZSBzb21lIHRpbWUNCj4g
PiBhZ28uDQo+ID4gDQo+ID4gSmVmZiBMYXl0b24gKDMpOg0KPiA+IMKgIG5mczogYWRkIG5ldyBu
ZnNfZGlyZWN0X3JlcSB0cmFjZXBvaW50IGV2ZW50cw0KPiA+IMKgIG5mczogYWx3YXlzIGNoZWNr
IGRyZXEtPmVycm9yIGFmdGVyIGEgY29tbWl0DQo+ID4gwqAgbmZzOiBvbmx5IGlzc3VlIGNvbW1p
dCBpbiBESU8gY29kZXBhdGggaWYgd2UgaGF2ZSB1bmNvbW1pdHRlZA0KPiA+IGRhdGENCj4gPiAN
Cj4gPiDCoGZzL25mcy9kaXJlY3QuY8KgwqDCoMKgwqDCoMKgwqAgfCA1MCArKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+IMKgZnMvbmZzL2ludGVybmFsLmjCoMKgwqDCoMKgwqAgfCAz
MyArKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgZnMvbmZzL25mc3RyYWNlLmjCoMKgwqDCoMKg
wqAgfCA2OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gwqBmcy9uZnMvd3JpdGUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDQ4ICsrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvbmZzX3hkci5oIHzCoCAxICsNCj4g
PiDCoDUgZmlsZXMgY2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiANCj4gV2l0aCB0aGlzIHNlcmllcyBhcHBsaWVkLCBJJ20gc2VlaW5nIHRoaW5ncyBs
aWtlIHhmc3Rlc3RzIGdlbmVyaWMvMDEzDQo+IGxvb3BpbmcgZm9yZXZlci4NCj4gDQoNClNvcnJ5
LCBmYWxzZSBhbGFybS4uLiBUaGF0IHR1cm5lZCBvdXQgdG8gYmUgZHVlIHRvIGFuIGludGVyZXN0
aW5nDQpyZWFkYWhlYWQgY29uZmlnIGlzc3VlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
