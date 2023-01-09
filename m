Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53821662A45
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjAIPlo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjAIPkp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:40:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2098.outbound.protection.outlook.com [40.107.92.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A327B8D;
        Mon,  9 Jan 2023 07:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNRRnG5XR+7sXslnIb1EemDVb6jQ9balSNqUxy1A/W4KoYp7K+9tNjT0LFdE9Elez5+K1tJtbqrZy2USZx+elAcZvwNpC/rdAvUj/YeKTuWm70l4zuni4bsk6WJj2ZAS3kJuPpeYE8y6gMaimS83gbn7mqFPT42w7pR74GaPWvuLhnP+8VbAgkZ4S84JLfHW3h7qZp0OwMBHiTK5oz4nMPfydH+LhVn07slt5bMVBq+XgiTQlzKM7rUHL2YyrMKNLPZsv5cdA2wginagXHVb+bToWOMmBDloNOkvmFCORWcY/utWsCnH4fP8YoajS8eHyaw55ouU1EfSU7opbEh0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfTOlJTCiI4B0a1GZnfHT5yI4oxCRAeesQvrVhnsCrg=;
 b=FRdLJsFWijo4J1SEeGfXv8ZK2n/94rISas7F/8fYn0hbgI9wQNgvQdC7YkNPF9wnuolewLza6sxAqvEoF4lAINELlRgBuC3jiAe96m+izif5aIi0rLF7LwQcuBFMqjG5Pg9bEK2aNjKpAqGwYBBTpcQX5u38IuDoY3PjlEgXEuQTzbg3EZvDmuheNyU82o9DUoRZz4qBMahbgz6meOWgY+EzQnIvbHT8kWa+R5UmCUrbL2+RuJ07cCXpF81B8Pjo4U6ykkplSHkaKC+F6xcdcExgRB985u2Va6NprTcQVGG71Qn/u07D+gzjRbG6LLKL46td8+C5xNiGP8UZGa0BGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfTOlJTCiI4B0a1GZnfHT5yI4oxCRAeesQvrVhnsCrg=;
 b=Qj4dhU5h+/MSLO8PwXgIWx6NDcKm+eNPA2kPGlk3wu69Cm44LXRIuG4Xp6/GH4pGxhjW5EvvUvGIRS8ZFtNgqdyvnLqfBh//TbOhcQ4HFdJCrSSHPG5vnQO59heDe/cTVTdYWXBb1rItujRtp0zJorAKmqim18aHlxICgwEvMKo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5810.namprd13.prod.outlook.com (2603:10b6:806:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:38:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:38:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8B7z8v0ucKO06SfuzpI9LIG66UhAWAgAA+kYCAAPzGAIAAB+QAgABlCYCAAAabAIAACJ4A
Date:   Mon, 9 Jan 2023 15:38:47 +0000
Message-ID: <1B9DE484-2543-44CC-83DB-46A3A9A9BEA9@hammerspace.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
 <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
In-Reply-To: <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN4PR13MB5810:EE_
x-ms-office365-filtering-correlation-id: 4c9bbce9-2f35-40f4-aef1-08daf2579929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: an269/Ml5E0rZq2nv/t25sY1EJRzqCr83BZPFEHqngIML/KO2PUMm+9g02AJAEf2Y43ENim2csbnj0eoAXUgGb8CWxgT3wQ3WW+z2c4tkoKeQ7qGlr9EpTbcq1tztLRYBwbBnQoNEqS+P9xf3HJOfRnyT1p+b+gY6CG9DdClH8xVikQsjJ1W77WBWzE9fjczPFEj7iZ8yufg4bIY8EudyW68wPIeJYS5/7oA2SXHHFoJDaGJ1NGa9jRdRoFXPYXq51JuiLYixI/WbcxQPja0OMh8Aan2H0iTujxBw0av4jHClwU+gF/2XxfmY4T5z/m6/8ZBVDrMYNjBTUlmKTyfi7vPYBhiGbiGJC1a5/drfHE8Y670Ke8mHDj5Rif2ezuSMcWZlV5elMp3YVTKlvPvYncpotmX3b+P31MnVIoh/4ArwY/VyuO6Fd336UqTS3/6dwq9ztqg4/d1XRawy+B40GA3YSzqwcrkqvs2wtzyhgCUsGrx4JDh+9R6dP1+l22vN+XFvpRy/GMWYbYuyUapvIP2rCnOdk0URmLMNtotC+q4qCOlRoj2w4MN8zFw5cGz4exeY8djjPVtk/nq+Nti8RyBFyhUon6HYzUOrl2S1AAUGNZDqj4Cdcz99mhoA9niJbnKIGqJailgZBjBk+ph/Ap6K5ka4mi3mm4leBokXYFmp23kAIYJMS/OVeeaNh7XXxjs5BYa3T+jT5IdS53yVmmot+F1nd4vHPebHFe/MWP9zmXH5YGT12KAmMWaO+4dM2Wc8yQ9nITym5FYF9LRUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(39830400003)(136003)(451199015)(478600001)(36756003)(86362001)(54906003)(76116006)(122000001)(5660300002)(4326008)(64756008)(8676002)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700005)(41300700001)(8936002)(26005)(71200400001)(316002)(33656002)(6486002)(83380400001)(966005)(2906002)(6916009)(53546011)(6506007)(6512007)(186003)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzRwenE0bVJrQy9NMnJMdnhjS1YvVTVUVkxUMUpoY0NDYWpmMWZoNFl1WTNO?=
 =?utf-8?B?NllZRnJjaFdSdUsyMzNkL3grN01zUTE3RFlQbFhGUUxqd1VXYVlsc1BwUnhR?=
 =?utf-8?B?V0NMTTJXSW91V2VmYVJyRHJ2S2o0TlBGL1MxdzJJWU9jRi9ZVkdjU3ZiVzB3?=
 =?utf-8?B?WDNISE50QitrV01vREthL1ZJN1Q2TmxnWGNjZ1kxVkFsdzlCTTZNNnVLWWJU?=
 =?utf-8?B?eDdOYnhIVEFRVjJoYWRNT1g5WXVNUjVwY1ZOdUVYZU9DZXBCYkdiZEJzUWNF?=
 =?utf-8?B?S29HQXpBeUVISktQZ1FleEJxZ3BQbytMN0hDQ1NqbHh1VVlFNlBCM0UwLy95?=
 =?utf-8?B?SHBuQlJTbVR2LytNT3lhVG5UR0JTdW9ZSmQvU2N3eUcwMEJubU5vTy9QaUd5?=
 =?utf-8?B?bW5aZnpHdG1lSGE2alBEWGZxeTB1UHlZd1ZqQUx5OUxiaWhDTmttTlRZK1FN?=
 =?utf-8?B?TmIvNk9tOVBONWEzNlVwUVFTRzFPSTR6MCtJRjJOWkpzK1NPWTFWUUkvY2J6?=
 =?utf-8?B?N1VSNWhwTGpQaEVLOUlFMHkzM3pHVWdDWGtWUmloNzQzQWxwcUlYbDVtaTlH?=
 =?utf-8?B?Y1BmbUFsSjl2RWtaZm01SzFZK1pLWjczVVMxYUJQbm5DbWFYSzROY0plTVh2?=
 =?utf-8?B?cElWdTg2Vkk0dUlLZ2lRRFJvTDAxdDdaMW9XUlZ1azJpbkhjTFpCVWZxdDFK?=
 =?utf-8?B?bTc3VmNYUVU5TWRDSkRCR0hlQkw5YnR1WE1LSFMvVUo0ZnFTdkprT3AvZm04?=
 =?utf-8?B?SVlwZ0xLNzMvSFU5SjF4T0NwV3VUbzVxZzlHaS9YVCtyVCsxL0dSQWFLeXNW?=
 =?utf-8?B?NS9kMkJYb204eDUraUo1YkFmTFNHaHNWOVJNc01Xb2RyTXlsb2t4QWpaRDAy?=
 =?utf-8?B?VVk5RDhUTVJjbnJHWFd2amdubFBMZjVkS1JRMk93dloyeEpOcXpBc3RXdklN?=
 =?utf-8?B?WTJxMmJuOVlkaThLckhWcE9vY3phUDB0S0hmVDVkb2N5bUMySGlkeDlFemg3?=
 =?utf-8?B?MlZNdHdsWXpRbkFZMVAwU1RuUEVqeHpjN0ZWWXgrazl6VGo1NFFMRzMwZEFw?=
 =?utf-8?B?RklwY09YSnFudUFHMldiVGtPWXdsbEZqcnRlamlDUzR1d3F1Q0VYYks5M280?=
 =?utf-8?B?QVdUdUhPT0dMVkdHSmFxa2VmU3dHS0dXekNKREcvc2tFSUphM2dLUFQrRHl5?=
 =?utf-8?B?L0ROVEptUTU0YVExcGpTSzAxYnVJeXc3R3JPdVMzYzBiVitvSkQwbXJuWVQw?=
 =?utf-8?B?eU1nWUZPTEJFZW5zYjNQaXoxWUdPMkRINWVueVk4b1Y2WXdKV0ZKMDJycTJp?=
 =?utf-8?B?Uk1KRDhJTkFoU092QWZ5MTV5K0NZNnRhU2luajVLaHZKL0RacWQ3c2JFT1hm?=
 =?utf-8?B?ejdhWVNmMC8zMjMzM2d2Nk9nZDhSVkdDU2VZc2tHWGIyQ0cwVUYxTjVIMnQ4?=
 =?utf-8?B?bm5GNVJBTm40YUFET3RpV2VlRzIrdEdlbkV1K0ZzemVsTEJTRit3VG5IbEhS?=
 =?utf-8?B?OStQc2JmV0ZyQ0VaTHVJaE1WblE4c3ZqVCtQaUdBd1B1ZDMxUGUydGxJcnBM?=
 =?utf-8?B?VXlOa3lqdUJyVVZhSGxDemEyRDB0L2g5SXd0b0dVbzB2bE5Xc3p4RlYvWUgx?=
 =?utf-8?B?T2tjNE1qZ25NYUFUMHg1RGpibVMzMWtRd0U0VVJoVytaTllqOEV0SE4yK2o5?=
 =?utf-8?B?ejUvU0lxVks4Y29Sd2JqVGxrR2l2OG5TcUcwM1FzbVVZcFpLdnRMWGg2c3lX?=
 =?utf-8?B?dTA1dm9nb3NVV1hDYlZGZ2JiU1dkbmFidWRBMkluYUlZSUM1SGRZdVBOUGVy?=
 =?utf-8?B?M3BSL2YzUndkeWtCY1NadzU4SDBqeVhraW9CSXpxdzVWeWhaMFZZZURScmF2?=
 =?utf-8?B?Q2diQWlLb2huS1lEeCtjWEVjcXBRSng3aHZWYzFWUjh4N0ZWTG1aWlhZdHpU?=
 =?utf-8?B?QUJYcHdUN0VnME1GTkwyWG9JK2lrUEdKYzF1VWxJUUE2TVBqN2VEeGc1OUlq?=
 =?utf-8?B?NVRhV1RsODlPN2NTTlg0dHlYVVpaSlZvV3Ivelc3QlIzTVpFYlN3QkU3U3Vl?=
 =?utf-8?B?bHg5ekZxbmdEVGc4MVNhS0RFcGtWelczZEZ1cGxaNlBHWEpjeDVzaHRLNU1D?=
 =?utf-8?B?cWMvUXBvbUVlYVp4Q0xxcVdjRWFkditsMHVKTWl6a3lQNURDZmhBRjRPbnFG?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A86D00108BE1244EAC1ADF59D7EBEF6E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9bbce9-2f35-40f4-aef1-08daf2579929
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:38:47.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piX0IHa3fnoYj7D6iq7rSSVwsOsWETg48xtaj+WJYpwmrbkfLqw97tO5EmKTkAQc/TOs+OhqCMBj9+PpCHfD+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5810
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSmFuIDksIDIwMjMsIGF0IDEwOjA3LCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gSmFuIDksIDIwMjMsIGF0
IDk6NDQgQU0sIFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3Rl
Og0KPj4gDQo+PiANCj4+IA0KPj4+IE9uIEphbiA5LCAyMDIzLCBhdCAwMzo0MiwgS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiAwOS8wMS8yMDIzIDA5OjE0LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+
PiBPbiAwOC8wMS8yMDIzIDE4OjA5LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+Pj4+PiBIaSBL
cnp5c3p0b2YsDQo+Pj4+PiANCj4+Pj4+PiBPbiBKYW4gOCwgMjAyMywgYXQgMDg6MjUsIEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6DQo+
Pj4+Pj4gDQo+Pj4+Pj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb25dDQo+Pj4+Pj4gDQo+Pj4+
Pj4gT24gMDcvMDEvMjAyMyAxNjo0NCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4+
Pj4gSGksDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBCaXNlY3QgaWRlbnRpZmllZCBjb21taXQgN2ZkNDYx
YzQ3YzZjICgiTkZTdjQuMjogQ2hhbmdlIHRoZSBkZWZhdWx0DQo+Pj4+Pj4+IEtDb25maWcgdmFs
dWUgZm9yIFJFQURfUExVUyIpIGFzIG9uZSBsZWFkaW5nIHRvIE5VTEwgcG9pbnRlciBleGNlcHRp
b24NCj4+Pj4+Pj4gd2hlbiBtb3VudGluZyBORlMgcm9vdCBvbiBORlN2NCBjbGllbnQ6DQo+Pj4+
Pj4+IA0KPj4+Pj4+PiBbICAgMjUuNzM5MDAzXSBzeXN0ZW1kWzFdOiBTZXQgaG9zdG5hbWUgdG8g
PG9kcm9pZGhjMT4uDQo+Pj4+Pj4+IFsgICAyNS43NzE3MTRdIHN5c3RlbWRbMV06IEZhaWxlZCB0
byBidW1wIGZzLmZpbGUtbWF4LCBpZ25vcmluZzogSW52YWxpZA0KPj4+Pj4+PiBhcmd1bWVudA0K
Pj4+Pj4+PiBbICAgMjYuMTk5NDc4XSA4PC0tLSBjdXQgaGVyZSAtLS0NCj4+Pj4+Pj4gWyAgIDI2
LjIwMTM2Nl0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGF0DQo+Pj4+Pj4+IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwNA0KPj4+Pj4+PiAuLi4NCj4+Pj4+
Pj4gWyAgIDI2LjU1NTUyMl0gIG1taW9jcHkgZnJvbSB4ZHJfaW5saW5lX2RlY29kZSsweGVjLzB4
MTZjDQo+Pj4+Pj4+IFsgICAyNi41NjA2MjhdICB4ZHJfaW5saW5lX2RlY29kZSBmcm9tIG5mczRf
eGRyX2RlY19yZWFkX3BsdXMrMHgxNzgvMHgzNTgNCj4+Pj4+Pj4gWyAgIDI2LjU2NzEzMF0gIG5m
czRfeGRyX2RlY19yZWFkX3BsdXMgZnJvbSBjYWxsX2RlY29kZSsweDIwNC8weDMwNA0KPj4+Pj4+
PiANCj4+Pj4+Pj4gRnVsbCBPT1BTIGF0dGFjaGVkLiBGdWxsIGxvZyBhdmFpbGFibGUgaGVyZToN
Cj4+Pj4+Pj4gaHR0cHM6Ly9rcnprLmV1LyMvYnVpbGRlcnMvMjEvYnVpbGRzLzM5MDEvc3RlcHMv
MTUvbG9ncy9zZXJpYWwwDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBEaXNhYmxpbmcgTkZTX1Y0XzJfUkVB
RF9QTFVTIGZpeGVzIHRoZSBpc3N1ZSwgc28gb2J2aW91c2x5IHRoZSBjb21taXQgaXMNCj4+Pj4+
Pj4gbm90IHRoZSBjYXVzZSwgYnV0IHJhdGhlciBtYWtpbmcgaXQgZGVmYXVsdCBjYXVzZWQgdGhl
IHJlZ3Jlc3Npb24uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBJIGRpZCBub3QgbWFrZSB0aGUgYmlzZWN0
IHlldCB3aGljaCBjb21taXQgaW50cm9kdWNlZCBpdCwgaWYgZXZlcnkNCj4+Pj4+Pj4gY29uZmln
IGluY2x1ZGVzIE5GU19WNF8yX1JFQURfUExVUy4NCj4+Pj4+PiANCj4+Pj4+PiBXaGVuIGV2ZXJ5
IGtlcm5lbCBpcyBidWlsdCB3aXRoIE5GU19WNF8yX1JFQURfUExVUywgYmlzZWN0IHBvaW50ZWQg
dG86DQo+Pj4+Pj4gZDNiMDBhODAyYzg0ICgiTkZTOiBSZXBsYWNlIHRoZSBSRUFEX1BMVVMgZGVj
b2RpbmcgY29kZSIpDQo+Pj4+Pj4gDQo+Pj4+Pj4gY29tbWl0IGQzYjAwYTgwMmM4NDVhNjAyMTE0
OGNlMmU2NjliNWEwYjU3Mjk5NTkNCj4+Pj4+PiBBdXRob3I6IEFubmEgU2NodW1ha2VyIDxBbm5h
LlNjaHVtYWtlckBOZXRhcHAuY29tPg0KPj4+Pj4+IERhdGU6ICAgVGh1IEp1bCAyMSAxNDoyMToz
NCAyMDIyIC0wNDAwDQo+Pj4+Pj4gDQo+Pj4+Pj4gTkZTOiBSZXBsYWNlIHRoZSBSRUFEX1BMVVMg
ZGVjb2RpbmcgY29kZQ0KPj4+Pj4+IA0KPj4+Pj4+IFdlIG5vdyB0YWtlIGEgMi1zdGVwIHByb2Nl
c3MgdGhhdCBhbGxvd3MgdXMgdG8gcGxhY2UgZGF0YSBhbmQgaG9sZQ0KPj4+Pj4+IHNlZ21lbnRz
IGRpcmVjdGx5IGF0IHRoZWlyIGZpbmFsIHBvc2l0aW9uIGluIHRoZSB4ZHJfc3RyZWFtIHdpdGhv
dXQNCj4+Pj4+PiBuZWVkaW5nIHRvIGRvIGEgYnVuY2ggb2YgcmVkdW5kYW50IGNvcGllcyB0byBl
eHBhbmQgaG9sZXMuIER1ZSB0byB0aGUNCj4+Pj4+PiB2YXJpYWJsZSBsZW5ndGhzIG9mIGVhY2gg
c2VnbWVudCwgdGhlIHhkciBtZXRhZGF0YSBtaWdodCBjcm9zcyBwYWdlDQo+Pj4+Pj4gYm91bmRh
cmllcyB3aGljaCBJIGFjY291bnQgZm9yIGJ5IHNldHRpbmcgYSBzbWFsbCBzY3JhdGNoIGJ1ZmZl
ciBzbw0KPj4+Pj4+IHhkcl9pbmxpbmVfZGVjb2RlKCkgd29uJ3QgZmFpbC4NCj4+Pj4+PiANCj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+Pj4+Pj4gDQo+Pj4+Pj4gV2l0aCBhIHRyYWNlOg0KPj4+
Pj4+IFsgICAyNS44OTg0NjJdIHN5c3RlbWRbMV06IFNldCBob3N0bmFtZSB0byA8b2Ryb2lkaGMx
Pi4NCj4+Pj4+PiBbICAgMjUuOTMzNzQ2XSBzeXN0ZW1kWzFdOiBGYWlsZWQgdG8gYnVtcCBmcy5m
aWxlLW1heCwgaWdub3Jpbmc6IEludmFsaWQNCj4+Pj4+PiBhcmd1bWVudA0KPj4+Pj4+IFsgICAy
NS45ODYyMzddIHJhbmRvbTogY3JuZyBpbml0IGRvbmUNCj4+Pj4+PiBbICAgMjYuMjY0NTY0XSA4
PC0tLSBjdXQgaGVyZSAtLS0NCj4+Pj4+PiBbICAgMjYuMjY2ODIzXSBVbmFibGUgdG8gaGFuZGxl
IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCj4+Pj4+PiB2aXJ0dWFsIGFkZHJl
c3MgMDAwMDBmZTgNCj4+Pj4+PiAuLi4NCj4+Pj4+PiBbICAgMjYuNTk3MjYzXSAgbmZzNF94ZHJf
ZGVjX3JlYWRfcGx1cyBmcm9tIGNhbGxfZGVjb2RlKzB4MjA0LzB4MzA0DQo+Pj4+Pj4gWyAgIDI2
LjYwMzIyMl0gIGNhbGxfZGVjb2RlIGZyb20gX19ycGNfZXhlY3V0ZSsweGQwLzB4ODkwDQo+Pj4+
Pj4gWyAgIDI2LjYwODMyOF0gIF9fcnBjX2V4ZWN1dGUgZnJvbSBycGNfYXN5bmNfc2NoZWR1bGUr
MHgxYy8weDM0DQo+Pj4+Pj4gWyAgIDI2LjYxMzk2MF0gIHJwY19hc3luY19zY2hlZHVsZSBmcm9t
IHByb2Nlc3Nfb25lX3dvcmsrMHgyOTQvMHg3OTANCj4+Pj4+PiBbICAgMjYuNjIwMDMwXSAgcHJv
Y2Vzc19vbmVfd29yayBmcm9tIHdvcmtlcl90aHJlYWQrMHg1NC8weDUxOA0KPj4+Pj4+IFsgICAy
Ni42MjU1NzBdICB3b3JrZXJfdGhyZWFkIGZyb20ga3RocmVhZCsweGY0LzB4MTI4DQo+Pj4+Pj4g
WyAgIDI2LjYzMDMzNl0gIGt0aHJlYWQgZnJvbSByZXRfZnJvbV9mb3JrKzB4MTQvMHgyYw0KPj4+
Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBJcyB0aGlzIHRlc3QgYmVpbmcgcnVuIGFnYWluc3QgYSA2LjIt
cmMyIHNlcnZlciwgb3IgaXMgaXQgYW4gb2xkZXIgc2VydmVyIHBsYXRmb3JtPyBXZSBrbm93IHRo
ZXJlIHdlcmUgYnVncyBpbiBvbGRlciBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zLCBzbyB0aGUgcXVl
c3Rpb24gaXMgd2hldGhlciB0aGlzIG1pZ2h0IGJlIGEgcHJvYmxlbSB3aXRoIGhhbmRsaW5nIGEg
YmFkL2NvcnJ1cHQgUlBDIHJlcGx5IGZyb20gdGhlIHNlcnZlciwgb3Igd2hldGhlciBpdCBpcyBo
YXBwZW5pbmcgYWdhaW5zdCBjb2RlIHRoYXQgaXMgc3VwcG9zZWQgdG8gaGF2ZSBiZWVuIGZpeGVk
Pw0KPj4+PiANCj4+Pj4gSSB3b3VsZCBzYXkgdGhhdCBidWdneSBzZXJ2ZXIgc2hvdWxkIG5vdCBj
YXVzZSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2VzDQo+Pj4+IG9uIHRoZSBjbGllbnQuIE90aGVy
d2lzZSB0aGlzIGlzIGEgcGVyZmVjdCByZWNpcGUgZm9yIGEgcm9ndWUgc2VydmVyIGluDQo+Pj4+
IHRoZSBuZXR3b3JrIHRvIHN0YXJ0IGNyYXNoaW5nIGNsaWVudHMgYW5kIHJ1bm5pbmcgZXhwbG9p
dHMuLi4gSW1hZ2luZSBhDQo+Pj4+IGNvbXByb21pc2VkIG1hY2hpbmUgKHRocm91Z2ggc29tZSBv
dGhlciBtZWFucykgaW4gYSBsb2NhbCBjb21wYW55DQo+Pj4+IG5ldHdvcmsgcnVubmluZyBub3cg
YSBzZXJ2ZXIgd2l0aCBORlMgc2hhcmUgIkhSIHNhbGFyeSBkYXRhIiBvciAiSFINCj4+Pj4gcGxh
bm5lZCBsYXlvZmZzIiwgd2hlcmUgdW5zdXNwZWN0ZWQgcGVvcGxlIGluIHRoYXQgbmV0d29yayBh
Y2Nlc3MgaXQNCj4+Pj4gbGVhZGluZyB0byBleHBsb2l0IG9mIE5GUyBjb2RlIG9uIHRoZWlyIHNp
ZGUuLi4NCj4+Pj4gDQo+Pj4+IFNlcnZlciBpcyBSYXNwYmVycnkgUGkgMyBrZXJuZWw6IDUuMTAu
OTItMi1ycGktbGVnYWN5LUFSQ0gNCj4+Pj4gDQo+Pj4+IFdoaWNoIHBvaW50cyB0aGF0IGl0IGlz
IG5vdCBsYXRlc3Qgc3RhYmxlLCBzbyBhbnl3YXkgSSBuZWVkIHRvIHVwZGF0ZS4NCj4+PiANCj4+
PiBJIHVwZGF0ZWQgdGhlIGtlcm5lbCB0byA1LjE1Ljg0LTMtcnBpLUFSQ0ggd2hpY2ggaXMgcHJl
dHR5IGNsb3NlIHRvDQo+Pj4gbGF0ZXN0IHN0YWJsZSBhbmQgSSBjYW4gcmVwcm9kdWNlIHRoZSBp
c3N1ZS4gVGhlcmVmb3JlOg0KPj4+IDEuIEl0IGlzIHZpc2libGUgb24gdHdvIHN0YWJsZSAob25l
IG5ldywgb25lIG9sZCkga2VybmVscyBvbiB0aGUgc2VydmVyLA0KPj4+IDIuIEJ1Z2d5IG9yIHJv
Z3VlIHNlcnZlciBzaG91bGQgbm90IGNhdXNlIE5VTEwgcG9pbnRlciBvbiByZW1vdGUgZGV2aWNl
cy4uLg0KPj4+IA0KPj4gDQo+PiBUaGUgbmZzZCBSRUFEX1BMVVMgY29kZSBpcyBib3JrZWQgdXAg
YW5kIHVudGlsIDYuMi1yYzEuIEkgdGhvdWdodCB3ZSBoYWQgYSBzZXJ2ZXIgb3B0aW9uIHRvIGRp
c2FibGUgdGhhdCBjb2RlLCBidXQgaXQgc2VlbXMgYXMgaWYgdGhhdCBpcyBub3QgdGhlIGNhc2Uu
DQo+PiBDaHVjayArIEFubmEsIGNhbiB3ZSBwbGVhc2Ugc2VuZCBhIHN0YWJsZSBwYXRjaCB0byBy
aXAgb3V0IHRoYXQgY29kZSBhbHRvZ2V0aGVyIGZyb20gYWxsIHRoZSBvbGRlciB2ZXJzaW9ucz8g
SWYgd2Ugd2FudCB0byBlbmFibGUgUkVBRF9QTFVTIGJ5IGRlZmF1bHQgb24gdGhlIGNsaWVudCwg
dGhlbiB3ZSBjYW5ub3QgZG8gc28gaWYgdGhlIG1ham9yaXR5IG9mIE5GU3Y0LjIgc2VydmVycyBv
dXQgdGhlcmUgYXJlIHJ1bm5pbmcgYSBib3JrZWQgaW1wbGVtZW50YXRpb24uDQo+PiANCj4+IEkg
ZG8gYWdyZWUgdGhhdCB3ZSBjYW5ub3QgYWxsb3cgYnVnZ3kNCj4gDQo+IG9yIG1hbGljaW91cywg
b3Igbm9uLUxpbnV4LA0KPiANCj4gDQo+PiBzZXJ2ZXJzIHRvIGNhdXNlIG1lbW9yeSBjb3JydXB0
aW9uIGluIHRoZSBjbGllbnQgY29kZSwgc28gSSBwcm9wb3NlIHRoYXQgd2UgcmV2ZXJ0IHRoZSBL
Y29uZmlnIGRlZmF1bHQgc2V0dGluZyBjaGFuZ2UgYWdhaW4gdW50aWwgYm90aCB0aGUgY2xpZW50
IGNvZGUgYW5kIHRoZSBsZWdhY3kgc2VydmVycyBoYXZlIGJlZW4gZml4ZWQuDQo+IA0KPiBJIHN0
YW5kIHJlYWR5IHRvIHJlY2VpdmUgYW5kIGFwcGx5IHNlcnZlci1zaWRlIGZpeGVzLCBhcyB5b3Ug
c3VnZ2VzdGVkLg0KPiANCj4gSG93ZXZlciBJTU8gaXQgd291bGQgYmUgbW9zdCByZXNwb25zaWJs
ZSB0byBnbyBzdHJhaWdodCBmb3IgYSBjbGllbnQgY29kZSBmaXguIFRoZSBLY29uZmlnIHNldHRp
bmcgaXMgYSByZWQgaGVycmluZyAoYXMgZGVsaWNpb3VzIGFzIHRoYXQgbWlnaHQgc291bmQpLiBB
bnkgdGhvdWdodHMgYWJvdXQgaG93IGRpZmZpY3VsdCB0aGF0IGZpeCBtaWdodCBiZT8NCj4gDQoN
CkEgY2xpZW50IGZpeCBpcyBuZWNlc3NhcnksIGJ1dCBub3Qgc3VmZmljaWVudC4gVGhlIG9sZGVy
IHNlcnZlciBSRUFEX1BMVVMgY29kZSBpcyBzbG93ZXIgdGhhbiBvcmRpbmFyeSByZWFkIGZvciBz
ZXZlcmFsIGZpbGVzeXN0ZW1zLCBzaW5jZSBpdCByZWxpZXMgdXBvbiB0aGUgKG9mdGVuIHBvb3Ip
IHBlcmZvcm1hbmNlIG9mIGxzZWVrKFNFRUtfSE9MRSkuIExlYXZpbmcgbGVnYWN5IHNlcnZlcnMg
YXMgaXMsIHdvdWxkIHRoZXJlZm9yZSBzdGlsbCBjYXVzZSByZWdyZXNzaW9ucyBmb3IgY2xpZW50
cyB0aGF0IGRlZmF1bHQgdG8gdHJ5aW5nIFJFQURfUExVUywgZXZlbiBpZiB0aGUgY29kZSBpcyBm
aXhlZCB0byBub3QgT29wcy4NCg0KQXMgZm9yIHRoZSBjbGllbnQgZml4LCBJ4oCZbSBsZWF2aW5n
IHRoYXQgdG8gQW5uYSwgc2luY2Ugc2hlIG93bnMgdGhlIFJFQURfUExVUyBmZWF0dXJlLiBJIHN0
YW5kIHJlYWR5IHRvIHJldmVydCB0aGUgS2NvbmZpZyBzZXR0aW5nIGlmIHRoZXNlIGZpeGVzIGNh
bm5vdCBiZSBtYWRlIGluIHRoZSA2LjIgdGltZSBmcmFtZS4NCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
