Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575B14BC48E
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 02:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbiBSB0O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 20:26:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSB0N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 20:26:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2110.outbound.protection.outlook.com [40.107.101.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22F271E2F
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 17:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQnsTcN0Jh9006nxx0H8m/Tpb//jOgkRvdiON52/QVXDfpJRuy1nqxHfzFD8PGQDmLD8slOF6nJjSs0qAGrqvP+Me0DHaL8QD/hG/JgA8Q5UH6l92BtThHihRPQj8yYCnS0HEgEgNQT/560xi6BltHvGKOfl9dJIyYkr+z0oaQMxRyBsYD12wpUcOo5xHBPEnDyquR9nZFjx5vX6zGxcT0WQiYkTE00b8ZCZVVBlkrWdCymM0SiNg5XnfTzPsaEJNvZK0nplZTQV9wA/j3+cIr4p8/GgyohzLj4RzAk4nTtx3jOoclHKdoSXYCLnj4uO65+Q+mr64OEwrIjtmRvCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr5qE1SywQKz0WJkkv6Nbqk+1bSLJ9tE7rO4k2T6ZbQ=;
 b=cI+N9oLmL/gBmFihplb1OCrgziCiVJl7Zbx4UEWAia43Jw61fUGENz3eKo+xWIrXu/ot7zW9MOcD1eouOJW5jS50/U2RssxrCeML/ss8XsmQGDD3aXVUfnTIQm2mSGfKbZroi9mDtBYuqGhZ0uciEts5xHn19v9G+mdRxkta4V+u4xsODUYR0VKsaEznvvMigYuq6V2CzIsjWd62FQL3vOI6C1WxCGVKn/B3O42NpOjXYoyoSY1GjpRQU6kkz6A+ZNbpBeDeSBuKFUY7pODzukiL+JJagH0LDx7wcyesLtJ8lhTPH16fqD3sxEN0397Hn2M5xKTthiwpCMbvUldEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5qE1SywQKz0WJkkv6Nbqk+1bSLJ9tE7rO4k2T6ZbQ=;
 b=LVI7t0E6/OEQawIndBiVOMoRVPePq/KvqcWZF0BnFbVVwN20SgAUcUWyJl6CQ77DxkUVXxDBt6KnAHol5IA1E5ZE/eAl0YjuIIMVpfvdKMIJou8M00XkrYHhzFpFgsxQ+hUv5QPclR9vk18LRT3cCeccYstlWPCLysCHMPFhwe0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR1301MB2010.namprd13.prod.outlook.com (2603:10b6:4:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Sat, 19 Feb
 2022 01:25:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.013; Sat, 19 Feb 2022
 01:25:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
Thread-Topic: NFSv4 versus NFSv3 parallel client op/s
Thread-Index: AQHYHFU6WYmGYj0+dESJuYL9YW7MrayLfu8AgA49EICAACfVgIAAA3UAgAAzbgCAAAvgAA==
Date:   Sat, 19 Feb 2022 01:25:51 +0000
Message-ID: <194829a2c280364faa6e9c70dbaee463101453a7.camel@hammerspace.com>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>        ,
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>      ,
 <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>   ,
 <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>      ,
 <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>
         <164523140095.10228.17507004698722847604@noble.neil.brown.name>
In-Reply-To: <164523140095.10228.17507004698722847604@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc8159d-2b1f-40fe-dcd4-08d9f346c445
x-ms-traffictypediagnostic: DM5PR1301MB2010:EE_
x-microsoft-antispam-prvs: <DM5PR1301MB2010327AA09CD60C6130329FB8389@DM5PR1301MB2010.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiH7fK8Rf/i/osfYRptkjBqOVCmRuUP5Xe7Ja6Nsp2sYnKI9+VhA3tMGR4HlwDTwhmo++zRmAB0jiRI/zwE7Bh6zEJkoFuFjXjjJfDy5SAz/Vmti53PgiW05oZA7yWJpyPsDe7VraYcy5h3vugT5Cxu7pId1dSJeb6BjSEnR8QHXqp31B6l+6fYCTWn0uHCKiLk9oKtD9DFg6ICOnXXID0+ieuTuCcIo2xgIgxmoMpl4Fz0/OSUBGGQMtkxPYDoaV9X4bSb6qHl5v/KH8w7w7x4PObu/GDHOHsdec/WH3/4o1k6gxf9JP+3ORNapW6wsIvNzkB30YobrsggECppeP1ysbiNyylxjDPGjYR1c1vLK8boacwg60WPth9ICZVvmcbd+14nW2C8pRwu2lh5rTxK1tfzDOaRqxk50cHpd/IKXd9o9QYNfnRdn/ZRDfyVVEwvwoNeHZuFyAc8OMhkUNHLD2r/aPLZje+TwyZsAFFtlZA7plO3ggglI8aqrzmzkROS11CsMyZ/GYIZxzdbRBIT0qKO+ytrkA2lA6bNjz8+4vjgUj5LwN1UzzPi9Ib47xRNvFbOwtKRcnksFOIkKoftlmpfrNgGpvDOsSNLIRSB2lX0RInLu8bNJgDRFyr0azlIPQYhqlg9R71Cd8EAbRmVqKUxaj3csFqKb1sRRr7VBPpTB/MfgK1Y1wMEx9dslOEtTKMaufWKKi2eA8SEUVIjMwNynHDCkUnBMUUfEAqGNFgH1CeIxW70tEggrv7qPlwpqvKWUDHN4Gj53L+F2oJMWMusG6/rHA7M0P2rmktA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8936002)(4744005)(83380400001)(71200400001)(186003)(26005)(2616005)(316002)(66556008)(6486002)(4326008)(38100700002)(2906002)(110136005)(38070700005)(5660300002)(66946007)(54906003)(64756008)(122000001)(76116006)(508600001)(36756003)(66446008)(6512007)(966005)(86362001)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RuSHlqQUVuOUhnVHBoRGdMa0JCV3JxVUVCMDRnTndpSzFJSEo4elcvRktQ?=
 =?utf-8?B?MDZhR0NXNTlKN1VEeUE2STVIeUJ6THNRVnRZSzl4cTRrRVMvU3FGOUw2RDF6?=
 =?utf-8?B?bWUvcHBVa2xPZnNocjBHd3BUdDAyYmRFK0hBRUE2ZEM5OVhlL3JqT3pld0dU?=
 =?utf-8?B?cmNqZVVnMzlib25iN21JUVNLbVhLTzBlSStidk8xNnFYQjdSL2RHT09paFhD?=
 =?utf-8?B?Qms1RU5zSmw5RFBIdkNaazkrTG5uVWtCekZaR2t1Z285eFBFeW1HU1JlcUVH?=
 =?utf-8?B?WjhwM3crS2FwWjBTZTBHcnFOWHJYdzVWY2VGVW5nN1dpOG5HZml5Z09FRHo5?=
 =?utf-8?B?bVh5VGkraUdqWnQ5Y2NGT2RBeDkrS3VOV2lpcUNkM1YxSkN1SkFpWElqTXpj?=
 =?utf-8?B?QlNhYXdCMlNqMHVaKzFrN1VvRXN3Um5QTEliNWVVSDVOM2E0WFJJZVVOZHBP?=
 =?utf-8?B?b3lVbEZGelFRM0hBRG52SlVTVDVMeXdwbnNjZVdXVTYvM0RsTm1pWDZ1UHdC?=
 =?utf-8?B?M3RmV0N4aVA4SmIwTnZoSkxRV3FkbEk1dWdwQ00vNG42N2hrZW1hR1JlajFx?=
 =?utf-8?B?WjFIZDB0R2ljNU1HRnROSU1RU1B1SUVQcmt4WG03K0ZEUzZPUDUzRXQ2bHA1?=
 =?utf-8?B?Qmp1Q1ZWM01LRXVoMjdPSnZDZGowblVNeXgrYUxSbXFoR2hhZ0tTaWE2R3ZT?=
 =?utf-8?B?dEFqOHRGRERHNmtUZmJrR0dFOC9tcWp1M21BSmRkOHFoVXpVOHJNQllpRFZ0?=
 =?utf-8?B?Vmh4Mkp5c21CVTBNc0Z5T0dBOVYzMHc1a0pmYjZ2Y3E4c0ZCc3pmRmQ1bVJF?=
 =?utf-8?B?eGEyYU4yNE1NNUxmRVpVaHRzOEh4RnJuR3dvK0t6a0ZZUElaZmYrWlRYK0ov?=
 =?utf-8?B?NFo0MXprQkg2WlFRYmN2Y3I3aXNJdWl3bkFQTFdhWC96YXRjWE5HYkhWRENx?=
 =?utf-8?B?bWo0dThKeTZabXRPZnk3Y09UeTZWY3ZnSW12emxEVHNRYUdCY3BJOFhHNk45?=
 =?utf-8?B?SVFpdW5YaTF0TVZjdXVmUTN3OGdndEJjUnhZekxwOFp0ZjhYYjh2T0Z6em5E?=
 =?utf-8?B?NSs5aEZvUk5sajUwaWg5Q3Y1K1dMOFNmY3g3eUtodStab3lKSFVyVmFhMmpt?=
 =?utf-8?B?N21sakp6TVJ4K1h3by9UYWNKYXFKb2pkejNuRXJ6cGE0Tnkzbml1clBjT1RR?=
 =?utf-8?B?SnliKzVlQ1JScHFkTGtOT000dDdoUXdvOTRsQ1Zhbm41aUluck8xRHdOaHVy?=
 =?utf-8?B?a2srZWhkbm5XaTRYaWE0TDd2MW1VYnNHZ2FEQVZ1Y0lSSE1DUnA0eU5ENjJK?=
 =?utf-8?B?SnlKWTBxcmJXUGxad3FEOWY0aWpoQ2JpaFZVWitaUjZwMHNiK08zR05ibzBi?=
 =?utf-8?B?eFRyQ1VmRWFsZmFRcXhOS3FSaEN0ZUlrSEV6VUtza2NiK1VWR2MwSU05UzZT?=
 =?utf-8?B?dlZiMGErbjlCbVVlS2k1NVBtTDFhZFc3MjUxcktrT0VLVVF2aTRrM0dFT0o2?=
 =?utf-8?B?TG9NejZyYVhycm82blhnQ1ZIclFRU3ZRMTM1M0d6UTJQSWZpSnRNOGJxQ2xM?=
 =?utf-8?B?MlVKZ2ljZkRSZGtoZkRET0FBYXZIZ1pmZUFEaStYcDlLV0N5Qks3cDNjY3Iz?=
 =?utf-8?B?czZhaHVSSGI4a3FIUFFhME9uUnpBTVJySldRMzhRR0hmOXdncUQ1Y3lSKzRs?=
 =?utf-8?B?NE5FWVU3VklIYkxDaHNBc1FyQTlwcXdOTkNkZ3IxQXc4Y3ZNQWRYckd5MG9u?=
 =?utf-8?B?S0tMNWZLWS8yckxTMSs0Yk80bTR0V2JXQ2NmZ2FoVUw5UnJnK0wycUdvUFNU?=
 =?utf-8?B?T2l1ekZ4YUdQdnlxcGord1pMZ2hYSC82OEoxb1dhbno0YktCVHRqdFJsMFhs?=
 =?utf-8?B?TStiUVFhZTJrN09nQis2SkZrcUE0bFRZcjJGWWlML3ZWcCtQU3EvV0RyM1Fn?=
 =?utf-8?B?YWh2dGw0S05xWER0T2NJZ3dXNklDakh1NXFVdUVabHNlYzkwMmFxckJFQlZl?=
 =?utf-8?B?VlV4S1Z2dkR4RDE5RXRiQTJmUkd0MG5HMytKZlVnS2pVZXRHQUJ0UTYwYngv?=
 =?utf-8?B?cC9XYXVxeTV3dHpKV0kweERxM1g3dkVQaVNqUGtIT3ZvekRyd1J1YzhLZ3R6?=
 =?utf-8?B?ZFZYUU1DN1NWNXcvWmI4YklIUzNWYm1acytIVDJxK0g0b2E0aEllalFrcUtM?=
 =?utf-8?Q?xDLEPE0wLbEGEbtE9+szF+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E352C5A3C7F3B4097D2EDBC4E44D49F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc8159d-2b1f-40fe-dcd4-08d9f346c445
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 01:25:51.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XApI2F8phxeVx4fLjbVqWlA0KTzHrFF/ZjrpkFa7YZLlPNybOgsJxDt6ZJfsIctMoRR+SyIzk/C+ikC4UXiluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAyLTE5IGF0IDExOjQzICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFNhdCwgMTkgRmViIDIwMjIsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiANCj4gPiBGb3Ig
dGhlIExpbnV4IE5GUyBzZXJ2ZXIsIHRoZXJlIGlzIGFuIGVuaGFuY2VtZW50IHJlcXVlc3Qgb3Bl
bg0KPiA+IGluIHRoaXMgYXJlYToNCj4gPiANCj4gPiBodHRwczovL2J1Z3ppbGxhLmxpbnV4LW5m
cy5vcmcvc2hvd19idWcuY2dpP2lkPTM3NQ0KPiA+IA0KPiA+IElmIHRoZXJlIGFyZSBhbnkgcmVs
ZXZhbnQgZGVzaWduIG5vdGVzIG9yIHBlcmZvcm1hbmNlIHJlc3VsdHMsDQo+ID4gdGhhdCB3b3Vs
ZCBiZSB0aGUgcGxhY2UgdG8gcHV0IHRoZW0uDQo+IA0KPiBJIHdvbmRlciBpZiBJIGhhdmUgYSBs
b2dpbiB0aGVyZS4uDQo+IA0KDQpJZiB5b3UncmUgaGF2aW5nIHRyb3VibGUgc2V0dGluZyBvbmUg
dXAsIHRoZW4gbGV0IG1lIGtub3cuIEkgc2hvdWxkIGJlDQphYmxlIHRvIGhlbHAuDQo+IA0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
