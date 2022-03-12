Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8814D70E4
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Mar 2022 21:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiCLUfq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Mar 2022 15:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiCLUfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Mar 2022 15:35:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C30A1DDFF7
        for <linux-nfs@vger.kernel.org>; Sat, 12 Mar 2022 12:34:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP39UVqOhEonpyt8LZhOmcxA0PVSAAniW7GG1LDQh6NUTNR+xxqwPMWMdNHKR1Ox3eAr/E5krGIj+V86n7JwouTPNIXnPwW/mLOF7xNZ6Sr608OJ7Fohn8gt1NwVtsAg/s/30fpAzTLfsa/UuDBxo97KiodPmZoZQwvV3JtzcJMbn3luGSDC+hHBzDYcRry8Gh/NBkDLU/xYBYSe4mrdsdlyuvFi/V9RxDH8vuhtM0ec6J6VirKEl/GRxgeKe+4o02ozj0O5k6r+4CKpLpxjKLOGJcfOrrsxxsYrh2DTEfDQthYANRAzr/cNcrpRKlzQZEihgWOh+y7m7DrIPSC1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1oRGbwBmDU+kvWO+0AppAWEqLvgwVNepBBtDnjQm9c=;
 b=Zf0Y8ahFEmLrbA3z+wkFQVhmoP5CDgCgS4lCWv6YpyZ8XuNzDFjsg95P9RcNmnEwLGiUWva3AgZcNRHFS+8J7R9rjQefgNbkYxoNxyY9ttOARkbLemqGSXq3sWTgrUX/zKKkj2yE0fYYGyl7ZX05mA6+qi/2Qj5Cul5hx+FoxNNoFJZBichskRJrS92Db2gn33g4h52Omjs9dtYC0yYwDoX66nb1fHVoEuk4LIjlK1i3do64HuBugpEUA3DO2ask7aeI5SpXZoIKlF/fIPGMh1eAYuCW0OQLLKKcHqWMZlCFDz7wG+D5/rvYKuZ+RTYk2bofiZNtFTcYa6+z7RrGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1oRGbwBmDU+kvWO+0AppAWEqLvgwVNepBBtDnjQm9c=;
 b=AbnPHy00MC1A1VoKupy9c2OPTt9zttwVeSLShlhWvXHbOwmT4kXV1//GYw49kdkvB+u+CuDcYcVpKDQPllMmSciuTeQNo+ykr6KL1lMFZFKWiVwc0esNhCo3+VRgr95tG7jO0PS1T4eKbz7QQLxaRYUSPL2EOGLeIDuUs57RBwA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4367.namprd13.prod.outlook.com (2603:10b6:208:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.8; Sat, 12 Mar
 2022 20:34:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.010; Sat, 12 Mar 2022
 20:34:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: avoid race between mod_timer() and
 del_timer_sync()
Thread-Topic: [PATCH] SUNRPC: avoid race between mod_timer() and
 del_timer_sync()
Thread-Index: AQHYMpYmOuB57OcNMEafOlsIyPwwW6y8O/+A
Date:   Sat, 12 Mar 2022 20:34:36 +0000
Message-ID: <8af5700311c3ca5ea4931072f0717bb133c79dfb.camel@hammerspace.com>
References: <164670733789.31932.14711754930977072270@noble.neil.brown.name>
In-Reply-To: <164670733789.31932.14711754930977072270@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56be93b0-2476-413d-7e4e-08da0467b981
x-ms-traffictypediagnostic: MN2PR13MB4367:EE_
x-microsoft-antispam-prvs: <MN2PR13MB4367F99BE7B94EB08315B101B80D9@MN2PR13MB4367.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZktZT5NOld1u7pEaV8ACgI3CzcH5tT27Yin73+6NbrBna9b9Tx5hr+J9hz1aCwfQdQ7+Yc+EcGd0IlLMr5X+jQ250+EP8rHmGui7GloRjC/vJ9YqYV6C8mRtLv4OSDagnrnMdAwRxMHwQMC/JQMJQWAeIibEg3arl+0LHA7j2RdPxzuD2Su//qx89Q/ZeKqf4fLen69Qg/fYPAKgAwkqliAtXK/+Gh7oX99aaVYvId2S7dvXBWOBXz84dIRLWgmE3x1k8rUu0Nn1GQl+ZprdYAx0KXpzEaw8+qbnBEZD//vs72H9OimJ+f2dfozY/O3AiBL050PhyOBkRnLiy5/F5EX8u9V+vdqg2+SmeMfiPfP3F3+8zeYH7XfxfznAliPYIbtkYY6eESmS57cthBsG54ogVJp7H1UT6ZZFdv0oK/pwKh63v/I6iQtQeKwwfCYHuRpB3WCoSR93x3yaf+gWUUSB0Iq2vmhNPsiGIHysiqVFF9QbBV2a58xqmQQG3ysjotV0lwUPReGmE+lY1G5vBUNXhta1THxyQrpPLe7e7+oll6l+fCTcsCdpihkZDR8XAZ7IqgYqepKMekwF6+gbd5kudTvRNdwl3PsAXN/d3S2pdmIov9Ll6Yfs/lZWzUw1zY+4pGY0+2pL4tcRokTdhxbJw/fePGfmh9PTrtWM33WBLYFSpT3ink80ZYk9OkRkSafIptxVeAIxcKtDu7au0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(2906002)(66446008)(66476007)(76116006)(316002)(64756008)(110136005)(36756003)(6512007)(6506007)(508600001)(6486002)(71200400001)(66946007)(8676002)(4326008)(8936002)(5660300002)(83380400001)(122000001)(186003)(2616005)(26005)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXoyWGZsbXpnRDhrUy9HaTlCcXNiYi9WOFNqbC9jM0pqMUcrUVcrQ2xrenNm?=
 =?utf-8?B?dGdRdW5FblpEakxLNnNjSGxqcytiSWNuN3lHYXVOM3JRaklGOHZsMGdlMU53?=
 =?utf-8?B?QnJkSXRyelBwL1dHMjd2ckxUVG42bThROVA5c1IwUHhhcSs3NkJiWkw4bXBx?=
 =?utf-8?B?elgwUlBCK2ZXY29YdlQ2SlRRa09sazBLY0xmb2lYVnZqZERINVcxbXJzUnY4?=
 =?utf-8?B?bHRMNUswdG0wQ0lDVFNyUnJiUWpGL09laEhkcTN2N2ZMbkNXWXJXa1I4RktE?=
 =?utf-8?B?bmhXK2lLbVBaNjFuNU1iZDI0WnVCblViV2hmQXNuVGFTZGZvcnRkNGR5T3Y0?=
 =?utf-8?B?WmNlcVVNVkdrc2hHNUppYjZEckhHd1hYck9iaWJKRzhsZ0FsRys3MW5mRHlt?=
 =?utf-8?B?RDd2RW9pOFNoa3hXR3FNdTBtOE9zdStDMXJFNUNyLy9UWnh6OVgzVlB2MWdr?=
 =?utf-8?B?UGk3bE9wRGxYTURpZnVYeFNmRnZCOUMrc3lTbUt2UGN0UGViWFFTcEtYK0xZ?=
 =?utf-8?B?VFNBVzlERnZ3UGtnN2U1SzV0SWtvMFV0bFlPeUF3YXZQMk4yNlJxQzcvNVlR?=
 =?utf-8?B?bitueTcrZ1B6SzRWRjI5VmxIWThtdFpzWWhVaEVDVVJpeE53YmF0Z0FjTmFv?=
 =?utf-8?B?b1pvMXdaN2hkUWMxUkZ0T0xvOFZRUGh6WC9BaEF1eTVNOFM0dHR6VWZhU3lY?=
 =?utf-8?B?bTVwbmVMdUZ3emhqT2toVTJTNFJNUm5KSnBqL3pZaGFzZEhFeUpLOW15WVNl?=
 =?utf-8?B?eHhwTmFTY2JsZStIc2pNYlFKQzRJamFicSszREoxYXgrWDZNcDFJU0lxYjBl?=
 =?utf-8?B?dU92RmtHUnM1dzZBQVNNSFhzVzdGYWtIdVBzL2hhait5Zng2SHMyWU51Q0p6?=
 =?utf-8?B?OTJxSGN5RFE4Szd3czRQSzBvc25jeGlIL1N4dDBUWThFMWhJcGhZZ0VqOTJM?=
 =?utf-8?B?Ni9Na1BKYkZrMUJBWmI4U1hucUJGbDFnUnR2OTdsakc0ZDJoUis1bkI1by8w?=
 =?utf-8?B?QWtZS1dFZGg4NHNBUVkwUXdnSzQ3dE0wZytqczgwYnA2OVNHSFMrbm9TVE11?=
 =?utf-8?B?U05OeTFxWEM5SHJ1S3RYOWh3OXJuOHlaQnRvQzg1VDZ1Z25CODJBc00wZmFK?=
 =?utf-8?B?aEViOVhJbGxsdDg5d1g4Y2VmRzI5SXlkZEFneU92YUg4ZGVpTFYrbi9HMW5B?=
 =?utf-8?B?RlBNcktoY3BWWE9tc2dvRlZTN1lDQi9VRlRZQVhjdVBaWFExZzdBaFM3VXZG?=
 =?utf-8?B?b3BxL0VFMWNETUNyOEpmZytRemlVdnk2bG4rYWJxZ2JId1hvRStRL1l5N3ZS?=
 =?utf-8?B?YUlWbndpMy9IN1kvcVhnL0YyZmtOdVFPL28xbExQbTlNQVQvSm5EaWVuYi9Z?=
 =?utf-8?B?VEU4SDJFUm0wVWRFd1RqMTZlelU2ZklHVWlITmhYd2hwa0tndkJoRko5aWxm?=
 =?utf-8?B?UHJzaXlBU0dlcmF1NHJwa1BXNk1QM2VwVTVvZGhVZlBLK2tZUTY3ZFpHZFlL?=
 =?utf-8?B?QXkyUkZFT2E3bTRPcmhCTlREdE95cXljeEEzc21xcGdwVVFYL21oSWlUdTVF?=
 =?utf-8?B?dnFtNzZBSm56VEttR2NnL3FDSktERVBlV1RWYTJDOFlXdGdQRVE2L3IyTkI5?=
 =?utf-8?B?SVNnQUVUcHZxWS9SdytzWVcvYzljNnZDZWxTVG5yZWgwVzN0emowM3Y3THQ5?=
 =?utf-8?B?OHVxWmFtR2NKaHdsVjY0UFIwZkxoRXFhUkZxQjBCOEExQ2U0eVBXOUY1emFD?=
 =?utf-8?B?Y0p3a281Yzc0ZzVNN05vT1hOOU81TStuMXhCeGRZNVRGWWlxT0V3VGNHVm1y?=
 =?utf-8?B?N3BMMDdUNHBVWFExNzZYRDZHS0VNdGJ1VitQQldFWENkczNkYlVMWVdjeHFG?=
 =?utf-8?B?S1FjZUpDRnNzaXhNWDRqMFZNSGRkWDFEbTB2Y0hFdVpqOFFSWEpWa3VDSHNa?=
 =?utf-8?B?dzRNc2dRc0ZGVytaWnpMR0svZkhheG1pS0swMm9GT2JaQWc0bU9ieG1jVjBl?=
 =?utf-8?B?WUFacEozTTFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28E9202DCAE69A45B086B83DA93A982F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56be93b0-2476-413d-7e4e-08da0467b981
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 20:34:36.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mu5Wa+yk1sxYIWL/Pc1BrsZLpHUR+R+4iHgrmUyKy3t9+iPh/eNanLG444ImHQzT+sdIxzbqp0lemQ9sI467jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTA4IGF0IDEzOjQyICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiB4cHJ0X2Rlc3RvcnkoKSBjbGFpbXMgWFBSVF9MT0NLRUQgYW5kIHRoZW4gY2FsbHMgZGVsX3Rp
bWVyX3N5bmMoKS4NCj4gQm90aCB4cHJ0X3VubG9ja19jb25uZWN0KCkgYW5kIHhwcnRfcmVsZWFz
ZSgpIGNhbGwNCj4gwqAtPnJlbGVhc2VfeHBydCgpDQo+IHdoaWNoIGRyb3BzIFhQUlRfTE9DS0VE
IGFuZCAqdGhlbiogeHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdCgpDQo+IHdoaWNoIGNhbGxz
IG1vZF90aW1lcigpLg0KPiANCj4gVGhpcyBtYXkgcmVzdWx0IGluIG1vZF90aW1lcigpIGJlaW5n
IGNhbGxlZCAqYWZ0ZXIqIGRlbF90aW1lcl9zeW5jKCkuDQo+IFdoZW4gdGhpcyBoYXBwZW5zLCB0
aGUgdGltZXIgbWF5IGZpcmUgbG9uZyBhZnRlciB0aGUgeHBydCBoYXMgYmVlbg0KPiBmcmVlZCwN
Cj4gYW5kIHJ1bl90aW1lcl9zb2Z0aXJxKCkgd2lsbCBwcm9iYWJseSBjcmFzaC4NCj4gDQo+IFRo
ZSBwYWlyaW5nIG9mIC0+cmVsZWFzZV94cHJ0KCkgYW5kIHhwcnRfc2NoZWR1bGVfYXV0b2Rpc2Nv
bm5lY3QoKSBpcw0KPiBhbHdheXMgY2FsbGVkIHVuZGVyIC0+dHJhbnNwb3J0X2xvY2suwqAgU28g
aWYgd2UgdGFrZSAtPnRyYW5zcG9ydF9sb2NrDQo+IHRvDQo+IGNhbGwgZGVsX3RpbWVyX3N5bmMo
KSwgd2UgY2FuIGJlIHN1cmUgdGhhdCBtb2RfdGltZXIoKSB3aWxsIHJ1biBmaXJzdA0KPiAoaWYg
aXQgcnVucyBhdCBhbGwpLg0KDQp4cHJ0X2Rlc3Ryb3koKSBuZXZlciByZWxlYXNlcyBYUFJUX0xP
Q0tFRCwgc28gaG93IGNvdWxkIHRoZSBhYm92ZSByYWNlDQpoYXBwZW4/DQoNCj4gDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJA
c3VzZS5kZT4NCj4gLS0tDQo+IMKgbmV0L3N1bnJwYy94cHJ0LmMgfCA3ICsrKysrKysNCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1
bnJwYy94cHJ0LmMgYi9uZXQvc3VucnBjL3hwcnQuYw0KPiBpbmRleCBhMDJkZTJiZGRiMjguLjUz
ODgyNjNmOGZjOCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0LmMNCj4gKysrIGIvbmV0
L3N1bnJwYy94cHJ0LmMNCj4gQEAgLTIxMTIsNyArMjExMiwxNCBAQCBzdGF0aWMgdm9pZCB4cHJ0
X2Rlc3Ryb3koc3RydWN0IHJwY194cHJ0DQo+ICp4cHJ0KQ0KPiDCoMKgwqDCoMKgwqDCoMKgICov
DQo+IMKgwqDCoMKgwqDCoMKgwqB3YWl0X29uX2JpdF9sb2NrKCZ4cHJ0LT5zdGF0ZSwgWFBSVF9M
T0NLRUQsDQo+IFRBU0tfVU5JTlRFUlJVUFRJQkxFKTsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKg
LyoNCj4gK8KgwqDCoMKgwqDCoMKgICogeHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdCgpIGNh
biBydW4gYWZ0ZXIgWFBSVF9MT0NLRUQNCj4gK8KgwqDCoMKgwqDCoMKgICogaXMgY2xlYXJlZC7C
oCBXZSB1c2UgLT50cmFuc3BvcnRfbG9jayB0byBlbnN1cmUgdGhlDQo+IG1vZF90aW1lcigpDQo+
ICvCoMKgwqDCoMKgwqDCoCAqIGNhbiBvbmx5IHJ1biAqYmVmb3JlKiBkZWxfdGltZV9zeW5jKCks
IG5ldmVyIGFmdGVyLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoMKgwqDCoMKgc3Bp
bl9sb2NrKCZ4cHJ0LT50cmFuc3BvcnRfbG9jayk7DQo+IMKgwqDCoMKgwqDCoMKgwqBkZWxfdGlt
ZXJfc3luYygmeHBydC0+dGltZXIpOw0KPiArwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmeHBy
dC0+dHJhbnNwb3J0X2xvY2spOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgLyoNCj4gwqDCoMKg
wqDCoMKgwqDCoCAqIERlc3Ryb3kgc29ja2V0cyBldGMgZnJvbSB0aGUgc3lzdGVtIHdvcmtxdWV1
ZSBzbyB0aGV5IGNhbg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
