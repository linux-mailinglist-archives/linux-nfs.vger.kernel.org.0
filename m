Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11CE4C3BC4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 03:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiBYCgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 21:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 21:36:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2108.outbound.protection.outlook.com [40.107.244.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7322614A8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 18:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaOnVaJLft2AAyfdwEB8a2XSym7c6pYTUxRhRfxLtXySpjX4Mng1+UShbkFfh/1RPiKGmfYbr1lJypUZP54xgs/0lgqj9DE3uPvOl1pFhbWmLcmezuLLj9tGz5XSAM5hAx/d6PiFfvveT9EPs+rBa9GcAlojaFxe1F2hsSQ3+T/OCfmVD068UNOqiY5oy9eLEdsz4rHEu+HIE2oMXsfFdNdYXoEQ0WSk4cdhywElDx2LbXhsYWQtrwAF8UaAyEt/DIrwZ1bK4muVkhDR5JYLilQb6IzwK4N4vwaAWxNAyhrrRfWmWCGMejVIQdoiEYmb4t9AXuqY160Y43xK5EcNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TxNE6fEHfKKFuZvX2X1U+ZyY+5d/2+ndzwFjwTi1g4=;
 b=a3fFzKr6H5sFs9WhxVl4ltodf/eRWlQOT6ktg4HWgLcDHzKThcMaDyD9udH7wF5Brij47FHFdf8+xUWBUWlJwIg/G7blDZfWvJVKaD6VgZ/AUVkjB8MLo9c+Eaml6Gg/L3pleelxVk65E9qnM3yXbXfiBA15YTAzXkFneWIeYY0Vs1/DAyAcpvdS5TkDg4aJbeg/s0url3bS8Y6YTTmcLW1CfcN9r+puShxpkdrCi9Gtx59DDDxnVrMpaSjVdlyJHDJlNOHE1OtDlW+F1ZagCxuLvUL+1XdUDBGAHOQicBjYi5U/qUUpZ8jEIxhfgjSIoeist29+DYXf8/Ss+I+AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TxNE6fEHfKKFuZvX2X1U+ZyY+5d/2+ndzwFjwTi1g4=;
 b=X0Fs0g3oO3nGxh1I7S/saJZfwH2JpkOcUc+uWDIr4Rk+YWWVmFC2Lh1k56hhx1SefSI0KO9g41yU4YV56DP8hGBmfphN/jTdEs832839mziACPayb/KEoDrfjrpgdDsnYt14WnBJNUBIQqKlsP1kv8VJYdo/1bR17he0WgmGS+I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5245.namprd13.prod.outlook.com (2603:10b6:408:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 02:35:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 02:35:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 16/21] NFS: Add basic readdir tracing
Thread-Topic: [PATCH v7 16/21] NFS: Add basic readdir tracing
Thread-Index: AQHYKPu2KlP1Xg7rb0CQ+jYrgO2dV6yi22gAgACzWAA=
Date:   Fri, 25 Feb 2022 02:35:34 +0000
Message-ID: <6ba701cd2974ae58d585eb58af06709aa1256276.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <20220223211305.296816-7-trondmy@kernel.org>
         <20220223211305.296816-8-trondmy@kernel.org>
         <20220223211305.296816-9-trondmy@kernel.org>
         <20220223211305.296816-10-trondmy@kernel.org>
         <20220223211305.296816-11-trondmy@kernel.org>
         <20220223211305.296816-12-trondmy@kernel.org>
         <20220223211305.296816-13-trondmy@kernel.org>
         <20220223211305.296816-14-trondmy@kernel.org>
         <20220223211305.296816-15-trondmy@kernel.org>
         <20220223211305.296816-16-trondmy@kernel.org>
         <20220223211305.296816-17-trondmy@kernel.org>
         <27661489-682E-427D-8644-6F768AC6C4E0@redhat.com>
In-Reply-To: <27661489-682E-427D-8644-6F768AC6C4E0@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecc3d914-263d-4c1f-bc3b-08d9f8077fed
x-ms-traffictypediagnostic: BN0PR13MB5245:EE_
x-microsoft-antispam-prvs: <BN0PR13MB52459310DE403848BC309D93B83E9@BN0PR13MB5245.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLR1lIiNMgPGAQyuz1emKCzsjIVQveebR85J+gcNGF15BWpd+4AdkZhDCBNC0wybsqGFAR1hoE/kxDMsW32MiawjMTZWKIBH783dxr15h7pLIx+JA3myjpemEKgkcr3P+qCFE8sGN/J66Gki97/fyaq4OK0SUFDruUVVKmIjDA/hWGzOXIjfZGD9G3AKU/CvvUmXqFw1e/SWl8LElk4XD+Hv29Wkjj1LdZyf2qybXcTwwaK0EfhlZoKkzwE/aEJM2E+OQJuUNohzmsD6+g/bWIDdgUg74/0rFUrKb9Sf4MmHvdNN0yVFwIhkOXMevF/Xzhs41m22tCvZ+eaXSHTd4bt2kYOzMDXfYZoJa3CeGNwGWWlwGymcJvX4rcig4ls9sbrVhUjvwn/bQf7B0Gz92+HOmhhsgQUdgpvUt+aSvhqWvmk2BMtr2QbulLuzmRqHS5O2PLUhBqRdrem3DOajVXUjS44yjBoMcL+nmhkfopyRmaxxU8XOJeH/axrSH/y3sgQHw3SG7+MNVqrRLTfromdfThjn0tCSACeCb/7F1gC4a5kUNMkU8xKl3xYbzTZgtp/K1rfuPxkdaqfKlaLCVO+2ANV960bCqH5vG6CJbDOLiqwxOc2/c+qMzBVVDoD1+FQhdNVuUm9jraFkXDuyuNwpB+vgo3P42g2GQ9gvhD7QkejFeEvrrwQirBxQSuwshLqD5xEOBtfLZ85EoCI/Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(396003)(136003)(366004)(346002)(376002)(66556008)(4326008)(71200400001)(2616005)(76116006)(8676002)(64756008)(66476007)(2906002)(66946007)(66446008)(6486002)(508600001)(5660300002)(122000001)(38100700002)(6916009)(316002)(38070700005)(86362001)(36756003)(6506007)(6512007)(83380400001)(53546011)(8936002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b25ZeXQ1ODNnOThoZTYyRlFkdUJNSVBrSG52RUJzbzd6SWx5Rld2d3NMMHR4?=
 =?utf-8?B?QjR2ampyQk5jdHhNbUpONTIxa1JkUXBabmFTNWlQQWNsbkxjdDJlMGdzWnNr?=
 =?utf-8?B?TU4rbVZRZm0zdURkTXpMY08yQUpSTkFHdThNK080UmxXZ1dEQ3o5QnYzTklM?=
 =?utf-8?B?S3F6Ukw3dTR4emRNRG5xbVIwelNZNnl0bHliQmF0M2E1SFdlaVdwK0I2ZExZ?=
 =?utf-8?B?TkxRdktTdFY5QVFQMWNxQUFiRXpBL2RpeDhiZjJ3WjBrWWdOTWtYNFNLbjhK?=
 =?utf-8?B?eVEyRFRyVjdtSEdKaGFBZUx1ZEthWVd2cHFkR1g3ZFpKajFwdmlSTzhzVEh2?=
 =?utf-8?B?Q0RnVlhFKzhDc1hkY3RjUUo0eDdkZmFqVkIrc21GQTBkOTVkaHE2SnJFbFFQ?=
 =?utf-8?B?aFc0TEpTbTBmUWtkQ2FVekZSbVZGT1NZYUNqdjNoUzJUbVFsR2IzR0U0Qmx3?=
 =?utf-8?B?b3dBOGdiTEt5bjhvWkFpQzRZdDJ0YU52OU8rck1JTDExSTNjN1E1NTdGL1V5?=
 =?utf-8?B?Q3RTQ3lyMERTZVphSnFBdXVkSU4vZ3ZqbmZEeDNXcFEzamRjeS9Lekhvb0pK?=
 =?utf-8?B?QmZnSTBsYUowUkQwQWRCcThzTWhhV0lZcEhidm9SazNtdTRJQ3NpalJqTjJk?=
 =?utf-8?B?dVRCMWRYelZmb1FxWGs3MUpJTE5nVjE4WXY2c3ExSzdLMUVyTHFNQlpaY1Rk?=
 =?utf-8?B?VWppOGs1S2ZDSXpyQi9JTGdodDZtUEM3cFQ0L1Q2R2NvMEh1N0daVm9JV2Zw?=
 =?utf-8?B?V0p0Sm1PK0pYQlYrTlZzSkY2cEViQmd2VTZZbXJ1T2lidGFnaGNRNjBSbUkx?=
 =?utf-8?B?WlM0N1NPZUlHeUljeDhnQ2p6WUVLWEViN3gycmR3VVRDQzl1VzczZlRBNFNN?=
 =?utf-8?B?NW5sUVBTbmdYMm9XbzhJazNUOXdaSjdQYzNrNzJFQ1RlOW42dVA4SWNKVU9Y?=
 =?utf-8?B?amRvWitkTXU3TVd3S2hvdElQN1pvajlmc2EwaENwRUx1aGR2ZkFmR3NMYWFZ?=
 =?utf-8?B?MkNQU0hUVlRQeDBuVjI5QXZrU3ZjTXI1VVRSaFE3U1pNYllITHRKc1F0R3d0?=
 =?utf-8?B?MnJWUDdkVy9sUzVxQjhTelljRzNaM0d0UGJQUWZqYkYzTWp2cHdWd0lhd25R?=
 =?utf-8?B?c1ZZM0ZHYWVZNkVWeTJBZWtZYjVmZk5PVjFBQWxQWGxmR0czZGJ2SUlxS3hj?=
 =?utf-8?B?a3p1ZGhhemZFa3FsaW5ZZTZnQkdCWFl4ZStpRzc1ajlYZnREUWhwUm9Oczk0?=
 =?utf-8?B?TnRFVlA5bjlnRlQwS0E5VUlmcS9MRnVPSHcrQ3dKZHlycjZhQm4vY1M5MWFN?=
 =?utf-8?B?WGlLVHN6cGc4SjAxYjBVdGwyQUdTbE05dWI0cnA0WGpxK1N0OTllbDhWcWJ3?=
 =?utf-8?B?TlV3ZDVPeFMvcmdBcFlrZWNDOXI5UnR5ZUpIanE0bllRSlY4ZVErbWJwaTdP?=
 =?utf-8?B?RXhWRWp6MzJWRFRId3VZaGs1OW01R1BrUm51Q3dOcGs0Qll1NDdFSm5wZE80?=
 =?utf-8?B?M0k5bG9BeTRBNDNqQTlmRHlLemhFa1grT1d5Ykcwdlc2THpjTWpObi9Cengw?=
 =?utf-8?B?R2N5WG9aVmlaTDJaWmdnRFJYVDFWVzA5OW9MV21Md1J0WmNsaGVvNTlSV2tk?=
 =?utf-8?B?N1J5YXJZcldtbjVsbEwwMnhiS0w2R1R5MGdNS2ZOUWJUMkNvN0FwVGxjejVN?=
 =?utf-8?B?KzF6V0dpQnh1MVV5RWlrczZNMGU4bko1bDlTVmdLbVg0M3JSY2dHWUVEek1B?=
 =?utf-8?B?QzIrWTFmTUxkcUxBcmlETEtYUEp3V0xibm16ek9NcXg3NElrZXVWS3ZnejZT?=
 =?utf-8?B?MWt5TnR3YWVCS21zeHRyd3d1TVRIOVBUMXR3UmNwblIvczJaT25aOWtiamM4?=
 =?utf-8?B?eVNNQUw0OXFBSDZIM0ViaVFqSm91R2ZXVkVzMFVIcm5YcVFKYjdJZHRZdkRX?=
 =?utf-8?B?eExKVFVOb1BSSjBPQXd1UnhRLzNzc3hibk9HRWtoTXFtcVRRY2RSayt6Nnc3?=
 =?utf-8?B?YmN1WUFldTVHSG8yZFdLbnBKQmFTaGJlT1VhMjZGTnlsRHJwSDQ5M1NPV1JY?=
 =?utf-8?B?REVJODk1YS85d25VTHMwU2hkYnlmZzZma2FlTXl5NHRxdGp4c2lGS3ZXSmNC?=
 =?utf-8?B?dGRRZHdYa3laNkd0RFlXeW1yS0lkUHpUOTM2K1dGN0dIaVlQeFRDN3BuR0hW?=
 =?utf-8?Q?HML7wM5V2ZUm9rAJ+cm8VX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C8BF77C8960341A02939897A646944@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc3d914-263d-4c1f-bc3b-08d9f8077fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:35:34.3757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb3GaRDJuGcRNixzNAfWFR3FzcOSHRe1DiLZd7WMFrglVlnDfOO69CLJRU7hUL8rkqxYMvc0zoJcllrAuipMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDEwOjUzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IE9uIDIzIEZlYiAyMDIyLCBhdCAxNjoxMywgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90
ZToKPiAKPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4KPiA+IAo+ID4gQWRkIHRyYWNpbmcgdG8gdHJhY2sgaG93IG9mdGVuIHRoZSBjbGll
bnQgZ29lcyB0byB0aGUgc2VydmVyIGZvciAKPiA+IHVwZGF0ZWQKPiA+IHJlYWRkaXIgaW5mb3Jt
YXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbT4KPiA+IC0tLQo+ID4gwqBmcy9uZnMvZGlyLmPCoMKgwqDC
oMKgIHwgMTMgKysrKysrKystCj4gPiDCoGZzL25mcy9uZnN0cmFjZS5oIHwgNjggCj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqAyIGZpbGVz
IGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYwo+ID4gaW5kZXggNTRmMGQzNzQ4NWQ1
Li40MWUyZDAyZDg2MTEgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9uZnMvZGlyLmMKPiA+ICsrKyBiL2Zz
L25mcy9kaXIuYwo+ID4gQEAgLTk2OSwxMCArOTY5LDE0IEBAIHN0YXRpYyBpbnQgZmluZF9hbmRf
bG9ja19jYWNoZV9wYWdlKHN0cnVjdCAKPiA+IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2Mp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoGlmIChuZnNfcmVhZGRpcl9wYWdlX25lZWRzX2ZpbGxpbmcoZGVzYy0+
cGFnZSkpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+cGFnZV9p
bmRleF9tYXggPSBkZXNjLT5wYWdlX2luZGV4Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHRyYWNlX25mc19yZWFkZGlyX2NhY2hlX2ZpbGwoZGVzYy0+ZmlsZSwgbmZzaS0KPiA+
ID5jb29raWV2ZXJmLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2MtPmxh
c3RfY29va2llLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2MtPnBhZ2Vf
aW5kZXgsCj4gPiBkZXNjLT5kdHNpemUpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXMgPSBuZnNfcmVhZGRpcl94ZHJfdG9fYXJyYXkoZGVzYywgbmZzaS0KPiA+ID5jb29r
aWV2ZXJmLCB2ZXJmLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmRl
c2MtPnBhZ2UsIDEpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVz
IDwgMCkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbmZzX3JlYWRkaXJfcGFnZV91bmxvY2tfYW5kX3B1dF9jYWNoZWQoZGVzYwo+ID4gKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdHJhY2VfbmZz
X3JlYWRkaXJfY2FjaGVfZmlsbF9kb25lKGlub2RlLAo+ID4gcmVzKTsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXMgPT0gLUVCQURDT09L
SUUgfHwgcmVzID09IC1FTk9UU1lOQykKPiA+IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnZhbGlkYXRlX2lub2Rl
X3BhZ2VzMihkZXNjLT5maWxlLQo+ID4gPmZfbWFwcGluZyk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+cGFn
ZV9pbmRleCA9IDA7Cj4gPiBAQCAtMTA5MCw3ICsxMDk0LDE0IEBAIHN0YXRpYyBpbnQgdW5jYWNo
ZWRfcmVhZGRpcihzdHJ1Y3QgCj4gPiBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yICpkZXNjKQo+ID4g
wqDCoMKgwqDCoMKgwqDCoGRlc2MtPmR1cGVkID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBkZXNj
LT5wYWdlX2luZGV4X21heCA9IDA7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqDCoHRyYWNlX25mc19y
ZWFkZGlyX3VuY2FjaGVkKGRlc2MtPmZpbGUsIGRlc2MtPnZlcmYsIAo+ID4gZGVzYy0+bGFzdF9j
b29raWUsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0xLCBkZXNjLT5kdHNpemUpOwo+ID4gKwo+ID4gwqDCoMKg
wqDCoMKgwqDCoHN0YXR1cyA9IG5mc19yZWFkZGlyX3hkcl90b19hcnJheShkZXNjLCBkZXNjLT52
ZXJmLCB2ZXJmLAo+ID4gYXJyYXlzLCAKPiA+IHN6KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChz
dGF0dXMgPCAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdHJhY2VfbmZz
X3JlYWRkaXJfdW5jYWNoZWRfZG9uZShmaWxlX2lub2RlKGRlc2MtCj4gPiA+ZmlsZSksIHN0YXR1
cyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZnJlZTsKPiA+
ICvCoMKgwqDCoMKgwqDCoH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7ICFk
ZXNjLT5lb2IgJiYgaSA8IHN6ICYmIGFycmF5c1tpXTsgaSsrKSB7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRlc2MtPnBhZ2UgPSBhcnJheXNbaV07Cj4gPiBAQCAtMTEwOSw3
ICsxMTIwLDcgQEAgc3RhdGljIGludCB1bmNhY2hlZF9yZWFkZGlyKHN0cnVjdCAKPiA+IG5mc19y
ZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2MpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaSA8IChkZXNjLT5wYWdlX2luZGV4X21heCA+PiAxKSkKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19zaHJp
bmtfZHRzaXplKGRlc2MpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IC0KPiA+ICtvdXRfZnJl
ZToKPiA+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgc3ogJiYgYXJyYXlzW2ldOyBp
KyspCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWFkZGlyX3BhZ2Vf
YXJyYXlfZnJlZShhcnJheXNbaV0pOwo+ID4gwqBvdXQ6Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L25mc3RyYWNlLmggYi9mcy9uZnMvbmZzdHJhY2UuaAo+ID4gaW5kZXggMzY3MmY2NzAzZWU3Li5j
MmQwNTQzZWNiMmQgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9uZnMvbmZzdHJhY2UuaAo+ID4gKysrIGIv
ZnMvbmZzL25mc3RyYWNlLmgKPiA+IEBAIC0xNjAsNiArMTYwLDggQEAgREVGSU5FX05GU19JTk9E
RV9FVkVOVChuZnNfZnN5bmNfZW50ZXIpOwo+ID4gwqBERUZJTkVfTkZTX0lOT0RFX0VWRU5UX0RP
TkUobmZzX2ZzeW5jX2V4aXQpOwo+ID4gwqBERUZJTkVfTkZTX0lOT0RFX0VWRU5UKG5mc19hY2Nl
c3NfZW50ZXIpOwo+ID4gwqBERUZJTkVfTkZTX0lOT0RFX0VWRU5UX0RPTkUobmZzX3NldF9jYWNo
ZV9pbnZhbGlkKTsKPiA+ICtERUZJTkVfTkZTX0lOT0RFX0VWRU5UX0RPTkUobmZzX3JlYWRkaXJf
Y2FjaGVfZmlsbF9kb25lKTsKPiA+ICtERUZJTkVfTkZTX0lOT0RFX0VWRU5UX0RPTkUobmZzX3Jl
YWRkaXJfdW5jYWNoZWRfZG9uZSk7Cj4gPiAKPiA+IMKgVFJBQ0VfRVZFTlQobmZzX2FjY2Vzc19l
eGl0LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUUF9QUk9UTygKPiA+IEBA
IC0yNzEsNiArMjczLDcyIEBAIERFRklORV9ORlNfVVBEQVRFX1NJWkVfRVZFTlQod2NjKTsKPiA+
IMKgREVGSU5FX05GU19VUERBVEVfU0laRV9FVkVOVCh1cGRhdGUpOwo+ID4gwqBERUZJTkVfTkZT
X1VQREFURV9TSVpFX0VWRU5UKGdyb3cpOwo+ID4gCj4gPiArREVDTEFSRV9FVkVOVF9DTEFTUyhu
ZnNfcmVhZGRpcl9ldmVudCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUUF9Q
Uk9UTygKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29uc3Qgc3RydWN0IGZpbGUgKmZpbGUsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IF9fYmUzMiAqdmVyaWZpZXIsCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU2NCBjb29raWUsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBnb2ZmX3QgcGFnZV9p
bmRleCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
dW5zaWduZWQgaW50IGR0c2l6ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCks
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgVFBfQVJHUyhmaWxlLCB2
ZXJpZmllciwgY29va2llLCBwYWdlX2luZGV4LAo+ID4gZHRzaXplKSwKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUUF9TVFJVQ1RfX2VudHJ5KAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKGRldl90LCBkZXYp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZmll
bGQodTMyLCBmaGFuZGxlKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBfX2ZpZWxkKHU2NCwgZmlsZWlkKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKHU2NCwgdmVyc2lvbikKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19hcnJheShjaGFyLCB2
ZXJpZmllciwgTkZTNF9WRVJJRklFUl9TSVpFKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKHU2NCwgY29va2llKQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKHBnb2ZmX3QsIGlu
ZGV4KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBf
X2ZpZWxkKHVuc2lnbmVkIGludCwgZHRzaXplKQo+IAo+IAo+IEknZCBsaWtlIHRvIGJlIGFibGUg
dG8gc2VlIHRoZSBjaGFuZ2VfYXR0ciB0b28sIHdoZXRoZXIgb3Igbm90IGl0J3MKPiB0aGUKPiBj
YWNoZV9jaGFuZ2VfYXR0cmlidXRlIG9yIGlfdmVyc2lvbi4KPiAKCkl0IGlzIHJlcG9ydGVkIGJ5
IHRoZSBfX2VudHJ5LT52ZXJzaW9uLgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20KCgo=
