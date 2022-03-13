Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7B4D78A4
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 23:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiCMW7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMW7S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 18:59:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A83702C
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 15:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL9XfKRxc7o8wcvGkDF1DOxx5cYpnHHNloiEaQN97U9BE7rmc4LEi3K/FTqRLURxItL0XzFV4cxamAPz37a82NRvbVV8nriL9cSMKHNUu5KpyfeVsHLN7+9XJo1Y6cc4T69bSSNtXxT7wvl9F/PAPyBFUoxejO5FnrefQ8cHp/so7NpQ8yq73FOVlBP/uCaETqZlSRMarMYAua5XC1eJnvInUCcZVZvH1C+FdqWNw2cX0gIjpVHKUnP6w7KLPDL1Fg/rO9SVsDxg/YHaDmIwqVUBdlH+MESJ3Aq3PuIHTTnUN6mbCzGETKuwQZJBdvUd/IA/k0YghRYnIEqWQA20JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofjw1ETjfMQttrAa8/1cwsb9CmDX0wuCNhSR2pshBG0=;
 b=ZLBq6+/+ITGKBqhWv3Bz0eWIo618XSE1IT+8FEuQ1zN9gse0p0j3Fv/QW5+6lhp4yub3vpGgnhdoUMGidij/hOIqi6kWGI8DiSZoX4B1aHyrfz/Zww3xTMdf+KCS/4+nCq3bmH3g+x7Demuw1Hz3vQAwU8OkDa+TGwUEA3ePG3PLuZBquxbvKKWbNgbpApQnABRh/Ib7N8xCN3G6wDlsEnFnEqYiMDUH0oM381qFDOWHUwSMV3+lMfSskXeIGJCC805d6Sjbnav6RoysXN7bUPPYmMLsRGFZOUbz9cMNLzdjuNKee426tQDPGNGjjq+wFDykExVphFNYeeXq/xI8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofjw1ETjfMQttrAa8/1cwsb9CmDX0wuCNhSR2pshBG0=;
 b=giAM9jZscgdYB+yvsjsnjNpuTOfOeDzA3ofDaZD3IPQz6Px84CD7Yl1BZ0mmEOVdKjWULu4AvAMapUfJqX4f2OxkYxxEoUoFvx/rVKL57DtrYNS4opCJxBST7rGojCUFKooP2UTrOGO20z+HXxgg7Aufs1ufmZyoJ5vrEi5Chgk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL3PR13MB5195.namprd13.prod.outlook.com (2603:10b6:208:342::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7; Sun, 13 Mar
 2022 22:58:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.013; Sun, 13 Mar 2022
 22:58:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: avoid race between mod_timer() and
 del_timer_sync()
Thread-Topic: [PATCH] SUNRPC: avoid race between mod_timer() and
 del_timer_sync()
Thread-Index: AQHYMpYmOuB57OcNMEafOlsIyPwwW6y8O/+AgAGrRICAAA8ngA==
Date:   Sun, 13 Mar 2022 22:58:04 +0000
Message-ID: <fc573816f371092d259242448b774e7497dbc5d3.camel@hammerspace.com>
References: <164670733789.31932.14711754930977072270@noble.neil.brown.name>     ,
 <8af5700311c3ca5ea4931072f0717bb133c79dfb.camel@hammerspace.com>
         <164720902908.7120.4478916458622123003@noble.neil.brown.name>
In-Reply-To: <164720902908.7120.4478916458622123003@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19e376e5-f891-4655-95db-08da0544eec5
x-ms-traffictypediagnostic: BL3PR13MB5195:EE_
x-microsoft-antispam-prvs: <BL3PR13MB51953C17DA136A9E7DD94204B80E9@BL3PR13MB5195.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqSE14wUximWbj/cf/JH+KCWenEq4UJW5hZ6znn1TxxAQWztgNAqCi9kjjDrmaaAOb1mX+ixu5N69nwzJNfEBmN0TQEXEcItTxWsqg+sKpvTB9tmqGsLCssvu6OgDGc1y3qnj+dnCY3edqottgN0I/1UnJg0WL8meD6gQMA4QZ6ME9MVGxSa6Z0sF4o7Z+085fxlXt+PBfXrjs3+L+rXHMErmG7CoJXvdE4mHjjRHc5EJTiD1N9xu+TiyBcBEeLr5ejMOVWo9YPR5w8zSKWCWXPHVdxdrZp/O7/K887cCpK8/HRj4ByEXtw1VZemXt5XYwtqp6iuEeZ/l/iWJ48R0YxtX8QcZYRRNWDmNBl5Mmlfn/pgiDWOkrmSTtW5DGMe+kuz9lbvgCBUxpWN5KWvMVSdRVxnB5R7mURNS9d0wFEB6lh6DHKgzzWzLvyRhdUm2zn7CFuSv4CNF7BNR02oAmPVUyRBKi5ui8Cosd3G1jBbLUea9nobHv0FLwBjQH6YcUTuL7b8Xw9WwcoNF+8zJbyVJwz1JjEoFaQ+1i1Jv5dPG+6eMMoYzC5wxmp0n6vSuYhHRUw0CEWs8mwDp82uwReKw2QUON4WWpc9w2L95S5oIo9M3yWr4R41v0dqlAUtSZ9DqFEqCWMX4NNf9hPnZPNkhN6VoMrAmcpvexNc2XwytXKfkzwWUUehNREDYwmcgEEHBA+wgY2056CaYOPBRDJuOXbr7igYF8fkz1k8NE3I7x+avLUUs2Cr5qAy2lRe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(54906003)(6916009)(316002)(6512007)(2906002)(36756003)(71200400001)(6506007)(186003)(26005)(2616005)(5660300002)(64756008)(66946007)(76116006)(66446008)(66476007)(66556008)(86362001)(38100700002)(8936002)(8676002)(4326008)(38070700005)(508600001)(122000001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDFtQnh3VEpBOCtJcHN5ZThuNFdQeE5DQUgrRlBkbHhrYVZ2aEhlcERsbEdz?=
 =?utf-8?B?WVpmUStFRERmY1BvZUlvRFBBVGdmZWppK004L2VQTFRhK2RMdUlSRDVxV2E4?=
 =?utf-8?B?SFFOZjg5SkpGcEVyRkdDSStrQ1JtMThTTnpDdW5Ja1R6TGUzTFhXanFhMXVV?=
 =?utf-8?B?NTgwTlNkZHJSS0xtOVlxWjJvNUUwRS8rb0xDM1NFcEM1MGlTT283NDdxeHdz?=
 =?utf-8?B?LzJnOGpPUTAvTWJUQlRxSUhMNU1SL1lDOHF4MzZCNTJPRnIwRkZYRkxrbFhJ?=
 =?utf-8?B?eHVEU3dScVJLMmc1Q0dtTlBESkhnWDVxMkc2ZHk3Sm5paHhCY0pnZU15NmRo?=
 =?utf-8?B?RjIvSlk2UnNnd25yZUE4aERxUGZNdFNiQzdwNE9RenhLYm1lUzBnUnZXbStN?=
 =?utf-8?B?emM4UGg0c2toV21UaGdydmZuZ2VKclA0UzlDOXo1UXB3ZWVKcVZaMTgzSkdN?=
 =?utf-8?B?MWhzUmROQVduR0ZPWUxDUTcyOEgzNkNnVndaMG4wRG4wUWR4dkI3K0FyZUs4?=
 =?utf-8?B?UVdnbitMMnpnZGZHYVdBTStkQlY5enVFN0JXbERFcVZxNTk4WG5hUjJaTVAz?=
 =?utf-8?B?a1NMRWhwSUN5U3hwcGtNRW5LQXpsUXZyWDhwbDJUS25rTEFJTUkxbFBmYzdM?=
 =?utf-8?B?blFlVXFhaS8yU0tpTWF1ZklXVEtHaGgzUGx0Y3dpREdyOTJUamJjN09TMlZl?=
 =?utf-8?B?aTRsbFZaMTZjdFBEbjdLcUhabWdCbHMvcGlycHI5eFhUOENVck9XclZKTG9M?=
 =?utf-8?B?aERSSjJMYnhNVHA0K1BSVzBUT2dyZVhmVGJBdWg0bEplVlJqdXphVHYxaEZQ?=
 =?utf-8?B?OUNiOWdlZjVOa1duOHlkRVFLVDBTRUZxeDBuSTZxYUpsZDhlaEJxY1R2ODNL?=
 =?utf-8?B?SGwzRE5VZUZoZVhNTmJ1M3hOWG9FbmJnUGtVUVFwRVR6eld6RWpGRElpQ0lx?=
 =?utf-8?B?RDhpcnZCbGJxekFUeE1JWC9BeGk4WjhSSEUxN0YrZXNRN29zdGUxa3V6N2Y0?=
 =?utf-8?B?dnNRSzdMRGJYa3c2N1RrYjU4TDA4MmRrT3djenpRNlFtTlpRakhMS1JIWjIv?=
 =?utf-8?B?M1Fjc0JVSkMzekRQc1p0OTJFb1ZmemFPVVNMQ2MyM1BUK296Z2ZoYVVlVzhu?=
 =?utf-8?B?djdDKy9LQXBQZU5PblNmSnp2ckt1WEgrMGl1Wk93WmMvN0V3UVBXZmhWY2Ja?=
 =?utf-8?B?UW1hUzdvcjRQdm9rUURCMjhsSW1MM0dpRkVBRUxwYTRaUWFtZmlrSTRvZmlq?=
 =?utf-8?B?NkpCYjFZSjhEU3NpMlFmdTYyUG43TTFsWHpqQzRicm9kbUdUd3VuZUtkT0ZM?=
 =?utf-8?B?TDZ1ZUoxK1Y5YVdrZTZ3SzNBVGRKQ0NobjZsUVBZWWs0a21nS0tiRDdvOGFr?=
 =?utf-8?B?VXVzcE42eXMzajRxZG4yb0kySi81TUovVDRNM3lQbWIzMXkzOWRVNlFEcWJl?=
 =?utf-8?B?V1dqbS83Mnk5N0paQm55aDI1VEY2SmdCZUV3K0FQcllHLy8rajJ4N2orcEJK?=
 =?utf-8?B?NmdjQUt1a1V1eG1hVC9CcS8rMTY4SGEwcEVuTW94S3JZNkdoTFRLWDZMUHlV?=
 =?utf-8?B?UFVuVVNrQjZBakp3d1E1d0FxU2xaeU5BWGY5VSt5NExRSW1WdjRKSHZacEFD?=
 =?utf-8?B?VHIzZkJKNVpTUnV0YmcvdzB5UXN2RFNNR2F1aGpFZ2tic0w3K1hRYktZbUxF?=
 =?utf-8?B?QW45YzZkeGJ0c0tHa051V29FakdRTXg0d3lyM0I1Tko1S0NnTUVqejc1UW9v?=
 =?utf-8?B?RmYrWkJjS29GNVUwMWdSTEpqMjhKdkY3ZUFBRjB0aHJCZHl4UzhaTzR1UGx5?=
 =?utf-8?B?RU9MK3h0NTYvbkxoam53ZkVZclFEWUM0c01SbC8zUkUwUkhLeFNCZTFudElE?=
 =?utf-8?B?dktWbllDS0UxYng0aWJRdVRxL0NGSW9iMmNRZXhRWmhQdXkzamlhZVJ6dnRK?=
 =?utf-8?B?ejA0aVB5ZTVVREdBWE9ySVNMVlg4QXBhWDhWWHVjc3crVkpHekI0YzJ4RjVD?=
 =?utf-8?B?MW9vRm16cWtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97A86860C718ED46B7EDC76FF7D24640@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e376e5-f891-4655-95db-08da0544eec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 22:58:04.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9s/XbO4+d8H84i7ef15wEnq/KvzuDNEjhWLeiPshVExBGLAkFTbNabdX6HiyeJo2FV4NMpb9mQ3HQsB6G0nrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTE0IGF0IDA5OjAzICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gT24g
U3VuLCAxMyBNYXIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gT24gVHVlLCAyMDIy
LTAzLTA4IGF0IDEzOjQyICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiA+IAo+ID4gPiB4cHJ0
X2Rlc3RvcnkoKSBjbGFpbXMgWFBSVF9MT0NLRUQgYW5kIHRoZW4gY2FsbHMKPiA+ID4gZGVsX3Rp
bWVyX3N5bmMoKS4KPiA+ID4gQm90aCB4cHJ0X3VubG9ja19jb25uZWN0KCkgYW5kIHhwcnRfcmVs
ZWFzZSgpIGNhbGwKPiA+ID4gwqAtPnJlbGVhc2VfeHBydCgpCj4gPiA+IHdoaWNoIGRyb3BzIFhQ
UlRfTE9DS0VEIGFuZCAqdGhlbiogeHBydF9zY2hlZHVsZV9hdXRvZGlzY29ubmVjdCgpCj4gPiA+
IHdoaWNoIGNhbGxzIG1vZF90aW1lcigpLgo+ID4gPiAKPiA+ID4gVGhpcyBtYXkgcmVzdWx0IGlu
IG1vZF90aW1lcigpIGJlaW5nIGNhbGxlZCAqYWZ0ZXIqCj4gPiA+IGRlbF90aW1lcl9zeW5jKCku
Cj4gPiA+IFdoZW4gdGhpcyBoYXBwZW5zLCB0aGUgdGltZXIgbWF5IGZpcmUgbG9uZyBhZnRlciB0
aGUgeHBydCBoYXMKPiA+ID4gYmVlbgo+ID4gPiBmcmVlZCwKPiA+ID4gYW5kIHJ1bl90aW1lcl9z
b2Z0aXJxKCkgd2lsbCBwcm9iYWJseSBjcmFzaC4KPiA+ID4gCj4gPiA+IFRoZSBwYWlyaW5nIG9m
IC0+cmVsZWFzZV94cHJ0KCkgYW5kCj4gPiA+IHhwcnRfc2NoZWR1bGVfYXV0b2Rpc2Nvbm5lY3Qo
KSBpcwo+ID4gPiBhbHdheXMgY2FsbGVkIHVuZGVyIC0+dHJhbnNwb3J0X2xvY2suwqAgU28gaWYg
d2UgdGFrZSAtCj4gPiA+ID50cmFuc3BvcnRfbG9jawo+ID4gPiB0bwo+ID4gPiBjYWxsIGRlbF90
aW1lcl9zeW5jKCksIHdlIGNhbiBiZSBzdXJlIHRoYXQgbW9kX3RpbWVyKCkgd2lsbCBydW4KPiA+
ID4gZmlyc3QKPiA+ID4gKGlmIGl0IHJ1bnMgYXQgYWxsKS4KPiA+IAo+ID4geHBydF9kZXN0cm95
KCkgbmV2ZXIgcmVsZWFzZXMgWFBSVF9MT0NLRUQsIHNvIGhvdyBjb3VsZCB0aGUgYWJvdmUKPiA+
IHJhY2UKPiA+IGhhcHBlbj8KPiAKPiB0aGUgcmFjZSB3b3VsZCBoYXBwZW4gYXMgeHBydF9kZXN0
cm95KCkgaXMgdGFraW5nIHRoZSBsb2NrLgo+IE9uZSBjb3JlIGlzIGluIHhwcnRfZGVzdHJveSgp
LCB0aGUgb3RoZXIgaW4geHBydF91bmxvY2tfY29ubmVjdCgpCj4gCj4gwqDCoCBDb3JlIDHCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENvcmUgMgo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKHRyYW5zcG9ydF9sb2NrKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
eHBydC0+b3BzLT5yZWxlYXNlX3hwcnQoKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFrYSB4
cHJ0X3JlbGVhc2VfeHBydCgpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVGhpcyBjbGVhcnMg
WFBSVF9MT0NLRUQKPiDCoCB3YWl0X29uX2JpdF9sb2NrKFhQUlRfTE9DS0VEKQo+IMKgwqDCoMKg
wqDCoCBUaGlzIGRvZXNuJ3QgbmVlZCB0byB3YWl0Cj4gwqAgZGVsX3RpbWVyX3N5bmMoLT50aW1l
cikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHhwcnRfc2NoZWR1bGVfYXV0b2Rpc2Nvbm5lY3QoKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNhbGxzIG1vZF90aW1lcigtPnRpbWVyKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bp
bl91bmxvY2sodHJhbnNwb3J0X2xvY2spCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3YWtlX3VwX2JpdChYUFJU
X0xPQ0tFRCkKPiAKPiBUaGUgbW9kX3RpbWVyKCkgY2FsbCBiZWluZyBhZnRlciBkZWxfdGltZXJf
c3luYygpIGlzIHRoZSBwcm9ibGVtLgo+IAo+IElmIHRoZSB3YWl0X29uX2JpdF9sb2NrKCkgd2Fz
IGp1c3QgYSBsaXR0bGUgZWFybGllciBhbmQgaGFkIHRvIHdhaXQsCj4gaXQKPiB3b3VsZG4ndCBi
ZSB3b2tlbiB1bnRpbCBpdCB3YXMgc2FmZSwgc28gaXQgaXMgYSBzbWFsbCByYWNlIHdpbmRvdyB0
bwo+IGhpdC4KPiAKPiBBbiBhbHRlcm5hdGUgZml4IG1pZ2h0IGJlIHRvIG1vdmUgdGhlIHhwcnRf
c2NoZWR1bGVfYXV0b2Rpc2Nvbm5lY3QoKQo+IGNhbGwgYmVmb3JlIHhwcnQtPm9wcy0+cmVsZWFz
ZV94cHJ0KCksIGJ1dCBhcyBhIHNwaW5sb2NrIHdhcyBhbHJlYWR5Cj4gdXNlZCB0byBncm91cCB0
aGVzZSBvcGVyYXRpb25zLCBJIHRob3VnaHQgaXQgc2ltcGxlciB0byB1c2UgdGhlCj4gc3Bpbmxv
Y2sKPiB0byByZW1vdmUgdGhlIHJhY2UuCj4gCj4gVGhlIG9ubHkgZXZpZGVuY2UgSSBoYXZlIHRo
YXQgaXQgaXMgcG9zc2libGUgYXQgYWxsIGlzIHR3byBjcmFzaAo+IGR1bXBzCj4gd2l0aCBydW5f
dGltZXJfc29mdGlycSgpIHRyaXBwaW5nIG92ZXIgYSBjb3JydXB0IHRpbWVyLgo+IFRoZSB0aW1l
ciBmdW5jdGlvbiBpcyB4cHJ0X2luaXRfYXV0b2Rpc2Nvbm5lY3QoKQo+IFRoZSAtPm5leHQgcG9p
bnRlciBpcyBMSVNUX1BPSVNPTjIsIHNvIGRldGFjaF90aW1lcigpIG11c3QgaGF2ZSBiZWVuCj4g
Y2FsbGVkIG9uIHRoZSB0aW1lciwgYnV0IGl0IHdhcyBzdGlsbCBmb3VuZCBpbiB0aGUgbGlzdCBv
ZiBwZW5kaW5nCj4gdGltZXJzLgo+IAo+IEl0IGxvb2tzIGxpa2UgdGhlIHhwcnQgd2FzIGZyZWVk
IGp1c3QgYWZ0ZXIgYWJvdmUgcmFjZSwgc28gdGltZXIgd2FzCj4gc3RpbGwgYWN0aXZlLCB0aGVu
IGFsbG9jYXRlZCBhZ2FpbiBzbyB0aW1lciB3YXMgcmVpbml0aWFsaXNlZCwgdGhlbgo+IGZyZWVk
IGFnYWluLCBzbyBkZWxfdGltZXJfc3luYygpIGFzIGNhbGxlZCBhbmQgLT5uZXh0IGJlY2FtZQo+
IExJU1RfUE9JU09OMi4gQXQgdGhlIHRpbWUgb2YgdGhlIGNyYXNoLCB0aGUgbWVtb3J5IHdhcyB1
bmFsbG9jYXRlZC4KPiAKPiBJIGNhbm5vdCBiZSAxMDAlIGNlcnRhaW4gdGhpcyByYWNlIGlzIGhh
cHBlbmluZywgYnV0IEkgY2Fubm90IGZpbmQKPiBhbnkKPiBvdGhlciBwYXRoIGJ5IHdoaWNoIGl0
IGlzIGV2ZW4gdmFndWVseSBwb3NzaWJsZS4KClRoZSBhYm92ZSBsb29rcyBwbGF1c2libGUsIGFu
ZCBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgdGhlIGNvcnJlY3Qgb25lLsKgCgpUaGUgb25lIGFkZGl0
aW9uYWwgY2hhbmdlIEkgc3VnZ2VzdCBpcyB0aGF0IHdlIGFsc28gbW92ZSB0aGUKd2FrZV91cF9i
aXQoKSBpbiB4cHJ0X2Nvbm5lY3RfdW5sb2NrKCkgaW5zaWRlIHRoZSBzcGlubG9jaywgc28gdGhh
dCB3ZQphdm9pZCBhIHBvdGVudGlhbCB1c2UtYWZ0ZXItZnJlZS4KCi0tIApUcm9uZCBNeWtsZWJ1
c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tCgoK
