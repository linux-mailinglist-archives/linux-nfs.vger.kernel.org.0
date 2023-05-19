Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF57097F6
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjESNIK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESNIJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 09:08:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290DC132
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 06:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THUksoXK/+yPHCPG8XjAUlur+8PoRx+a6H8o5a+Nt/31KVJdRA7zRrDWzPPnN/YUufIjh3kUeh/EGfG9i+g39FL2/UKwLuqFQ5PzkIkcgyQCEd4l4JT4Thz2bpX01Nn0huDjLd/xCjefnWQ5423VGEV0phJQ12AtDGQ1JgR9l35QuuqZhXtzkhf90LvMVPDPUJxZn/dGf82Xn3J03ct14h1aqNZzzjkq0xaimmt5gVw1gRXIb2tGLxILIdgqP0d7plvCbL3f2vq6/j6xotl3oL4/3hSqrA+31U0IFpXGIailE7CCkO2pkufGKxOfRdOXvEmXn372s8/na4ZQhAdcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGNLgiVQ1qkcKLnIjU2idpm6X/f0fqIUhvb03mFqf0A=;
 b=AYfU/Xxs3e/Xh2wxUi43h/wy4t3dPqz8sW6X4Dn3w0MmHom9wlMgxaO1gEb4HHY+lBKpY5HKcQhZloP5Gtzx/8VVE21hDgKT0UOoP4R8XSfhL/GhqH0SeabFBS7j+YHdILPNi5mu1mG3nWEvKx3D5vnBeq9+WEvRUtwg8rCkyZHaP7oVxpEz3s/xsnmxISqlLEdvs0TgZhLaUJmhwwxbEgfKQDyuzS78LvZEMthPBUPLVOs/ohVYk7u4rlak2EodNM8hQpnwhHBchuIDb0bHwu/HltaJKqnkEy8dDmh8PcxdxSFpcF+hGGe9Txb/LA8sSeLCqqp2cvUxT3Cj3JJffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGNLgiVQ1qkcKLnIjU2idpm6X/f0fqIUhvb03mFqf0A=;
 b=KD9OlcqgO+ntBE+JYJjTOp2kZ2TjtduRlmdYHCauprR3hg3GCS32B4HL2TNogKZVMwZkTTeV0d2LZyo+KIE9ifhpgGHzMR8NLDRTLKmSIvnQ2AFhKC90SWQQSJa1wHan+jcLrevwMHOlHfQ1NJxgyXWopRCp7rkRPHl9IQFs+wA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6131.namprd13.prod.outlook.com (2603:10b6:806:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 13:08:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 13:08:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Thread-Topic: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr
 fails
Thread-Index: AQHZikObAh7DxvffIEaIfli6BRFIU69hkVyA
Date:   Fri, 19 May 2023 13:08:04 +0000
Message-ID: <e0c64e6c69552872925312ca012946acc308b71c.camel@hammerspace.com>
References: <20230519111723.20612-1-jlayton@kernel.org>
In-Reply-To: <20230519111723.20612-1-jlayton@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6131:EE_
x-ms-office365-filtering-correlation-id: 341b25d0-eca0-43ed-e4ce-08db586a152f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdKT/RwThPWY+5+RmI386zYwnDQGk1BFPZ0iUv2dQLRaIMg+EZEeqiG6sTyhO92qgvTtdmfHAKGzMUyC5RFz77fZmzJtd0Ewm7VKKH+HvkTjALthD72zkc62iNTMg1RyIosKaUy0qwwZ0TBlHLjQWRWfogtKwFP28a90CRC++8Yxx9dyZZy0qYHZ7VSUm2MmkRGharTyPuy826CfszjwQv6LNyXtAqPd/bRSzNDDino6SlIXurA231y/YaFG8xy2PdhdjB/ea+gtTDXQPvDH+jXn8dEA/Ts3uIJAGfKVJu9ye0a+t1AeAGlGds2VSjSEcNBul+Ex4B9plrvZCqWOSBCcmo9+RSWg/obveMvbN8YjrmtdpMikVICRYI05cmOlpLBxDk4Cf+AI4VhMQZsDeDGK7n5GfDLzDqjM5L61wzEzC4CM0nIts9+NyD5ktI85p1M2u8WXY0vphKgRIE8w2jLzXCpGSwSLfTAd5C9l+g2ax/OHnO4bGM69fzfRKzYu9RDnorsI/7+OovGn+plv5U/JaUkQ7+mTD3bHw9d3Ttn4iGQ3D2QEbUiIiWx/Q+ojALTm3mRl/9yIo+1IUwy74/bZDdRDmnNUzOZglTJ9NAtrg4Os4jgnzjGmRl6W8LKh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(366004)(346002)(396003)(136003)(451199021)(4326008)(2906002)(478600001)(41300700001)(8676002)(8936002)(316002)(110136005)(6486002)(71200400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(6506007)(6512007)(186003)(83380400001)(36756003)(38070700005)(86362001)(38100700002)(2616005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktNQlZwaFZpRDJqckU0bm1IRnRtQ1grdVg1RitzMlF1TFg1RGR3dThLUEpm?=
 =?utf-8?B?ZDNScUxRbHkwYi9ldkJKckNwckxZMDYzaGQrdjY5bFdnUGYyc0F4cHNnazZC?=
 =?utf-8?B?R3JkZzZxZmM0eGdEdFdOcDE3RVpzSHJFYkhyb21QVkVpS0VNajB3ODNHZFF5?=
 =?utf-8?B?YkRkOEMxS0xSM2FPVFFqa1ZpVXZoNjlFWU1ma015Zmx4WktZQUphRmpnemMr?=
 =?utf-8?B?VEt6M0lENm40aTJGYnlOdFhoZVlNUCt5aHVOVGI5LzQrWHlzRXFzSlBmWll5?=
 =?utf-8?B?UnRFNWxoOFFWdXNlWHppV3lDVXZOYi9icnl6eE1wUWJ3aGxGVTBqZGkrYm1P?=
 =?utf-8?B?UVN4dUEwYVlYM2xIOGZETnhrbjUxc3pFWjFHeE5ISGZ1T2NQSE9ZS2xsY0g0?=
 =?utf-8?B?SEt3SVJCMmtVMzdZRlZtdVlSSVUxTU5Mak9DK3B4eTF5ZFFOdGNFdFNOclQx?=
 =?utf-8?B?eDhSbGEwanp1UDUrRWtTZVE4Z2VXcWxDS2dBMEVUNFBWQ3dEM2xMb1Zuc1lv?=
 =?utf-8?B?ME1zeWNGK09vSEI5VUZVdkVEdHN2UUJGNEExaUNETVAyS29OdCtYdlRabTE1?=
 =?utf-8?B?NXBHZ1NwSml1SnhPTWNrVmkrUmFuZU8wR3daUWU2TENmYWxONkhIVWZSRG10?=
 =?utf-8?B?WENRVy9XcU5WUFNtZlZ1c2lNTUFFVFd1M0ZWQzFOeDl1TVVmb0ZTa0Nxa2xl?=
 =?utf-8?B?TlBrZFFqOFVsODNaZUdOWjdGYmxFbWxJQnV6RzdDWFZGampOamcxMUQ2Mk1P?=
 =?utf-8?B?L290RVJMNTBYRUJJaWNreHo2dmN0L1dnQ1VWVUN0Y2JZSXE5WVNTTGtzNFFv?=
 =?utf-8?B?VWd5bWE4ZWRuTjBKeDdhWnBXQ3QrMVIxQktGbTVIMFZGSzNrNGs1bUx0c2cy?=
 =?utf-8?B?RER6NWNKeUtNb2poL2tIL3QrQTdoQUxLRGF5dysyU0kwRTJ3eFBBZ1U0Njk3?=
 =?utf-8?B?UXRPZklGTnJubFRCSXptSFY0VHpIbnIrZko4RFR3ZFppZjNqcnJlS3QyVGtS?=
 =?utf-8?B?R1hwWVFLanlKYjhuU1ZKRk8zS2tvYmk5U1Y1WW1rTXlxTk8zR2U0ZEpQL1ox?=
 =?utf-8?B?MFI2VjZFR1o0RzVJTFRNM3FZdGVTRE12aDgrWnhNUmJSUVV0eCtYVlpjMURG?=
 =?utf-8?B?M2xvRnZpcTNKVUVDWkZLTTNZeXFMV2tnNHBmaHZBbGwyZ3ZHRjkyL1psbndG?=
 =?utf-8?B?enFJLzN2MWJMdTREcGdZL215aFgxb043bTdmV2xMNlUxOG9qcjNudGl4YUQ4?=
 =?utf-8?B?M3lQYjZOTm5hSTg5MC9Ta1BJNUdoWmVwQ1ZxMmpkMDBrWmNKc1ZTM3hhL1Jj?=
 =?utf-8?B?RWJ3RHVkdVREQWpoQ0ZnelZpN1hjTFc1V0pQOXVkL0pWeUNxd3pUbEE4d1ov?=
 =?utf-8?B?bGtsMXMvTVYwa2MzNGxlcTBPOUlKcnZsaWVNOXpjZXVLR2xQR3lkaDBhZEpF?=
 =?utf-8?B?L0ZBZ3ZLaC8rNm5BWlRROG1IR0ZBKzgzR2FqMWNKbUFBa0hlK0grZEFVdVNH?=
 =?utf-8?B?V3NTeFZ1SEJ2aWpJeENIUkVjYVdmNS9oTFN1TXNlVGhIdDV2NENZUG5qS1ll?=
 =?utf-8?B?U1JGTHppWjBYSmpyM2EwSzgralZBQk5Nb2tMTTk1YXczNkxkUWdrdkpwWjFn?=
 =?utf-8?B?cWN5OHc0WDltOXdNSUd0N3A2djgveFZmNHo3c3VqN0FWQ0hTbHBzaDljVUxk?=
 =?utf-8?B?TVBGczlTS0pWOWVlcnl4MVNaZFgyVVBPYXczREQ0cXdLSTlCdXcvMjczTFJI?=
 =?utf-8?B?WGV0WWZKRmR2UFo3M0tXK3BOL2ZjVjB1NnYxQmV4OWkxclpTK3JIYzk1enhz?=
 =?utf-8?B?dzdmbDl1NVFNVHV6ODA4cHRRT1lPTEZUUUVRQTd1MmF6dXpteWp1VFFjakZJ?=
 =?utf-8?B?T09rM0l4T051V2hoM2hNdkwwOVRvejdMOWZZYzBDNlIrNEIvK1FKa0lEb2Rh?=
 =?utf-8?B?eXFQdXZPNUN3MitjVkpaNDhZWjJsUmpCclFTTkxPalE1MEJhSXZmbW4ycll2?=
 =?utf-8?B?dXpHZFBRdUJhWm5HU0lGNDVScFRrYjBidi96VGpuTzdNWFVwOWNaU1Nab1Bk?=
 =?utf-8?B?N2xlY1pOVzEyTTFLWnBIaURZdTk3Y0p5dmJUSXhwYmd2cVdaQUlRaFdKbGIx?=
 =?utf-8?B?YkhwbmVWQkM2V1d0L3ZseG5EWjVZRjh4cVJYY2xTRUQvNWVHc2JzemhITVNP?=
 =?utf-8?B?blpsNU1YaENVL2p2eVF6L0xITk9NdGlTbHNxcWhQUm91VEJJaFJ3SExLc0tD?=
 =?utf-8?B?MzFVclNiU2RmQXlidmxmOWNKZnJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7854716AD58C94DA0CFDB7759157B37@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341b25d0-eca0-43ed-e4ce-08db586a152f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:08:04.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKGjgRY+igjRV3UEdQFl0RxNLQeK9dFU/d6cm6I6d7Yvv4cvEEd/9etMQCeqtUoz4U7a4oDoDqb/9GC2XUjY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTE5IGF0IDA3OjE3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToKPiBu
ZnNkIGNhbGxzIGZoX2dldGF0dHIgdG8gZ2V0IHRoZSBsYXRlc3QgaW5vZGUgYXR0cnMgZm9yIHBy
ZS9wb3N0LW9wCj4gaW5mby4gSW4gdGhlIGV2ZW50IHRoYXQgZmhfZ2V0YXR0ciBmYWlscywgaXQg
cmVzb3J0cyB0byBzY3JhcGluZwo+IGNhY2hlZAo+IHZhbHVlcyBvdXQgb2YgdGhlIGlub2RlIGRp
cmVjdGx5Lgo+IAo+IFNpbmNlIHRoZXNlIGF0dHJpYnV0ZXMgYXJlIG9wdGlvbmFsLCB3ZSBjYW4g
anVzdCBza2lwIHByb3ZpZGluZyB0aGVtCj4gYWx0b2dldGhlciB3aGVuIHRoaXMgaGFwcGVucy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgo+IC0t
LQo+IMKgZnMvbmZzZC9uZnNmaC5jIHwgMjYgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9mcy9uZnNkL25mc2ZoLmMgYi9mcy9uZnNkL25mc2ZoLmMKPiBpbmRleCBjY2Q4
NDg1ZmVlMDQuLmU4ZTEzYWU3MmUzYyAxMDA2NDQKPiAtLS0gYS9mcy9uZnNkL25mc2ZoLmMKPiAr
KysgYi9mcy9uZnNkL25mc2ZoLmMKPiBAQCAtNjIzLDE2ICs2MjMsOSBAQCB2b2lkIGZoX2ZpbGxf
cHJlX2F0dHJzKHN0cnVjdCBzdmNfZmggKmZocCkKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpbm9k
ZSA9IGRfaW5vZGUoZmhwLT5maF9kZW50cnkpOwo+IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBmaF9n
ZXRhdHRyKGZocCwgJnN0YXQpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChlcnIpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogR3JhYiB0aGUgdGltZXMgZnJvbSBpbm9kZSBhbnl3
YXkgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdC5tdGltZSA9IGlub2Rl
LT5pX210aW1lOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0LmN0aW1lID0g
aW5vZGUtPmlfY3RpbWU7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXQuc2l6
ZcKgID0gaW5vZGUtPmlfc2l6ZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHY0ICYmIElTX0lfVkVSU0lPTihpbm9kZSkpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXQuY2hhbmdlX2Nvb2tpZSA9Cj4gaW5vZGVfcXVlcnlf
aXZlcnNpb24oaW5vZGUpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3RhdC5yZXN1bHRfbWFzayB8PSBTVEFUWF9DSEFOR0VfQ09PS0lFOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDC
oMKgwqDCoGlmIChlcnIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsK
PiArCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh2NCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGZocC0+ZmhfcHJlX2NoYW5nZSA9IG5mc2Q0X2NoYW5nZV9hdHRyaWJ1dGUoJnN0YXQs
Cj4gaW5vZGUpOwo+IMKgCj4gQEAgLTY2MCwxNSArNjUzLDEwIEBAIHZvaWQgZmhfZmlsbF9wb3N0
X2F0dHJzKHN0cnVjdCBzdmNfZmggKmZocCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHByaW50aygibmZzZDogaW5vZGUgbG9ja2VkIHR3aWNlIGR1cmluZwo+IG9wZXJhdGlvbi5c
biIpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGVyciA9IGZoX2dldGF0dHIoZmhwLCAmZmhwLT5m
aF9wb3N0X2F0dHIpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChlcnIpIHsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZmhwLT5maF9wb3N0X3NhdmVkID0gZmFsc2U7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZocC0+ZmhfcG9zdF9hdHRyLmN0aW1lID0gaW5vZGUtPmlf
Y3RpbWU7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2NCAmJiBJU19JX1ZF
UlNJT04oaW5vZGUpKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBmaHAtPmZoX3Bvc3RfYXR0ci5jaGFuZ2VfY29va2llID0KPiBpbm9kZV9xdWVyeV9p
dmVyc2lvbihpbm9kZSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBmaHAtPmZoX3Bvc3RfYXR0ci5yZXN1bHRfbWFzayB8PQo+IFNUQVRYX0NIQU5HRV9D
T09LSUU7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiAtwqDCoMKgwqDCoMKg
wqB9IGVsc2UKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmhwLT5maF9wb3N0X3Nh
dmVkID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGZocC0+ZmhfcG9zdF9z
YXZlZCA9IHRydWU7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICh2NCkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGZocC0+ZmhfcG9zdF9jaGFuZ2UgPQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc2Q0X2NoYW5nZV9hdHRyaWJ1dGUoJmZo
cC0+ZmhfcG9zdF9hdHRyLAo+IGlub2RlKTsKClVuZm9ydHVuYXRlbHksIEkgZGlkIHJlY2VudGx5
IGZpbmQgYSBjb3JuZXIgY2FzZSB3aGVyZSB0aGlzIGJlaGF2aW91cgp3aWxsIGJyZWFrIHRoZSBM
aW51eCBORlN2MyBjbGllbnQuIEluIHRoZSBjYXNlIHdoZXJlIFJFQUQgc29tZXRpbWVzCnJldHVy
bnMgcG9zdC1vcCBhdHRyaWJ1dGVzLCBhbmQgc29tZXRpbWVzIG5vdCwgd2UgY2FuIGVuZCB1cCB0
cmlnZ2VyaW5nCnRoZSAnb3V0X292ZXJmbG93JyBpbiB4ZHJfZ2V0X25leHRfZW5jb2RlX2J1ZmZl
cigpLCByZXN1bHRpbmcgaW4gYW4gRUlPCmVycm9yLgoKVGhlIHByb2JsZW0gaXMgdWx0aW1hdGVs
eSBkdWUgdG8gdGhlIGF0dGVtcHQgYnkgdGhlIGNsaWVudCB0byBhbGlnbiB0aGUKcGFnZXMgdG8g
d2hlcmUgaXQgZXhwZWN0cyB0aGUgUkVBRCByZXBseSB0byBvY2N1ci4gV2hlbiB0aGUgYmVoYXZp
b3VyCmlzIHVucHJlZGljdGFibGUsIHRoZW4gaXQgc29tZXRpbWVzIGVuZHMgdXAgYWxsb2NhdGlu
ZyB0b28gbGl0dGxlCm1lbW9yeSBmb3IgdGhlIGF0dHJpYnV0ZXMsIGFuZCBlbmRzIHVwIGdldHRp
bmcgY29uZnVzZWQuCgpUaGlzIGJ1ZyBkb2VzIG5lZWQgdG8gYmUgZml4ZWQgaW4gdGhlIGNsaWVu
dCwgYnV0IGp1c3QgYSB3YXJuaW5nIHRoYXQKdGhlIGFib3ZlIHNlcnZlciBwYXRjaCB3b3VsZCBi
ZSBjYXBhYmxlIG9mIHRyaWdnZXJpbmcgaXQuCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQoKCg==
