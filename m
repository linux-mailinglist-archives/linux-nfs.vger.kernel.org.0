Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BADF599122
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiHRXXa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiHRXX2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 19:23:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2129.outbound.protection.outlook.com [40.107.100.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791453D2C
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 16:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQa/z6L14mEJZeX5AuW0GbjyBeLt/HpfOZcJxrN8rnmasp/lX0VcdBWo8FkVSOJSd+Wg7PUsllfrZPYr0JLc88f41l9uzofNmnKlIhzXfqpJNdMwUQ+SfMjmuCvGFvmHD4+uP9WN9NJ6N+WijqMTkjoE799RSevMBZ+KICwQSnbnribeHJqaSbRGLE2hDgRf0kgUp7mOQQLTPtXLU6WLGXg6d0l9MH+xHmj9CuGiXMx4GBlnKkfF5ANTUJXcQoGRmbTRSemVcCkYTROyzJYdZRd1pfbYyO2kY106ddj/lTJGq8Hth8blksHCmRNClHUi5fi8B8ZUKM18SrqLxM2Bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29mWgrMw084PsKHuWfWTcivB40/UVYtDZm2Q3H0IWpw=;
 b=NJKLOtPLoU1DGgtQ4Izx8JPKAOWeMvUUNfGIYgkZ3srvK0CZGIYEY6Ak4jYj5OTX1Q/ewQKIT/8yW9vFspmoyeSi1eXzdCWX+EFSiF17YndD7Ab/InRLBGjSsY8ynEH3pfaVCzlMhePU1Xe4xqEWUosIcgACGJj6BK/kDXociFpQJtaU1wOOmfoIetPGaVWgJ3gIlTmYBHfx8m2mWp5EbMwl835rZv7C1nUBsLYsj+41pcpf2WSLE0TNsFWW6RMQgp8bTpp0WQWJ0MMA7pCUiLFXFk9TRQFQv/PREZ7M8NifbYySrsDTFqBzCy3wkMs3Mu58HArqEpZeUkKFXQaWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29mWgrMw084PsKHuWfWTcivB40/UVYtDZm2Q3H0IWpw=;
 b=NZAQNFovZrWSC5MOvBf3KDOe2vZoZzj91GHWQnzM28o0SLmSPsUdokSNJG816pyu6BO9GwVnZAZ/Bu6U6l+gyGolmPIeTr8mvdTV9qhBFZ5UNmYfay4cNaJk+GbQOmHIbscXR7SNoS6rLt29ONzcItg3mr9Dnn1Pn/4gNtDAAVA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5957.namprd13.prod.outlook.com (2603:10b6:510:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Thu, 18 Aug
 2022 23:23:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Thu, 18 Aug 2022
 23:23:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hooanon05g@gmail.com" <hooanon05g@gmail.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS, two d_delete() calls in nfs_unlink()
Thread-Topic: NFS, two d_delete() calls in nfs_unlink()
Thread-Index: AQHYshvbYcoYlDGy/0SXRJ1YOW/UAa2z972AgAAKD4CAAUgXAIAABOkA
Date:   Thu, 18 Aug 2022 23:23:24 +0000
Message-ID: <d5aac52a15c3f8fff1bc730c4a1abea4d9ce8252.camel@hammerspace.com>
References: <7634.1660728564@jrobl>     ,
 <166079133167.5425.16635199337074058478@noble.neil.brown.name> ,
 <9451.1660793491@jrobl>
         <166086394829.5425.9699631920964605772@noble.neil.brown.name>
In-Reply-To: <166086394829.5425.9699631920964605772@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b12bd905-cc84-448c-2c74-08da8170a5dc
x-ms-traffictypediagnostic: PH7PR13MB5957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DPdJKAmezcwTeL4IH1JURIlldFoxUK1GHSuE5hOb28wTFhVkhEAblyi1U9OJoZijIDacTML/g9IcqXi9HgEij3fgy0OdDCvnhe6u/94//vsRaT6e4ykn1qyMrp4ew42pngqWUNGesf0A0q4SyZ7p6Hrh2fV/Ee1Rsf3oTqV8BZ486coRtRJ4GAyKwWbiD0Inb1kIlhkwdh82MRLjJBLbmH7KRB706kFSc/g+4fWibkNPoea7yHiC7J0rzNkx4RJLPk25CI2OizQhbQlt75fiYoBqMzLu/SJwfsYqG9dYCHlGNqT+7gIupTAjDyxm4Sspx9+98v5eMMyFtf2eihNIQ+c+mzvvZLD/pssiIK/QS1bTOsPn5WY94TPCLLtYwh0BTvBRurEfFY4smOvmUmKZF1AvmqvapyRuJvH5U1JACwduv+W5bX2Qk1ngIEGYJjyVzhdOgFvEL/uaG6r+ublwUtFa8GNovV9DqVTpnEnIOmycfKVQBuW6nI0/I8QjbEyrWssx+9qBtJOmRIr8GFnDF3I0caOntmgL1mx98mGENdq9egTWp1o+y0aE+vKcxwi0FvIEYs1IZx2OGfaYItDI2B+p6SHg61mxxaiaPCqRHVgjbxHC3KmlxrWyDmjDKTniWyjbuVakbyin2ZkZg6s5/1d5xv6cwO+7rNhTfy0CS+nln+a6Kdd5Xhh023mwcweSwrpOSgEnV83knpnJWJfy6ss47pK3UPNxBGOytiAUwHD4NSyF3QAI2XGp1D6C5Z9uQUx5A94E98U2Cb4DMp27A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39840400004)(376002)(396003)(136003)(346002)(2616005)(8936002)(83380400001)(2906002)(5660300002)(186003)(26005)(36756003)(41300700001)(6486002)(6512007)(6506007)(71200400001)(478600001)(4326008)(38070700005)(86362001)(122000001)(66556008)(66476007)(64756008)(66446008)(110136005)(8676002)(316002)(76116006)(66946007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjZ5MVI0MkQ4bDJHNFpUdVB3WTRhSThyM2JBSXNtK1g4ODh6enYzTUphSmZN?=
 =?utf-8?B?NGUxR05jdXc3L1lndkhaejlFdHNBZVFsUVJrYnFwMTB6OGFDT0tFOCt1cTQr?=
 =?utf-8?B?MDd2RGpyNXV5Qm1Na0M2ZTN5T3NRbGhGeVE4WkM0WVVlSGtJUGJ0RTJjc1JX?=
 =?utf-8?B?dVJQS1E5cHZmQlZ1VDhDaS95Ymh0dXJ5OWFwV2paT3ZtdTFESzczOTRKZVo3?=
 =?utf-8?B?WFpRU2tLZkc3dmt1U0U1K1ZEWkJacldNOFRBWGFDNndUQ0dBMVVCc2szaUNK?=
 =?utf-8?B?Wk94QnQrQU9RdWhBMnF4TkZYdEMwM3NXcW8zRHppTGhzR1lzdlgxZkN0Ymor?=
 =?utf-8?B?NkxKQXFoL052RWFIditlcVVMOGpIbi9jaUNoMXJPa1k3TEFwUEwxVUcvWFBt?=
 =?utf-8?B?anNkRnF2U2g3UjRZYzdPWThUeWQ4anZRWklRcUloVUVnT2NjVUVuWHgzZkRz?=
 =?utf-8?B?aUlLcGdjeEhXdW9VNDlJVVFaYVVmRUtYMnhoQ3BCMjk4VmwrVStlelIrN1Uv?=
 =?utf-8?B?cnVIQ2R4KzBpS2VjU2luVkRZNTJwR1RpUDhIOFJnWHNpSkhwOEhRc0IwK0pI?=
 =?utf-8?B?N2hRbWNNbVFlakcweG9JR1pGM3lYYWtHQ3B0S2pMbVAyZlZ6MzVMa255cmpZ?=
 =?utf-8?B?WGVpWG5YY24yZFZ1SW5lU2tyZkdreUhLTThNS1JTN3BGUFNLbFNKSjNWaUtn?=
 =?utf-8?B?ZzlWV0l0VDNXbGNtcU93Q1lKVmN6UnM0b054UlIwOFBFcmZ3eUJVM0VqOTRE?=
 =?utf-8?B?N3ZmRHFvM1lmQ0ZtWDFTMkxPUUw1MFF0L0p6Und1SDVianhKTnpxcjI4QjQy?=
 =?utf-8?B?MFBjcUN1c3lSWFc5RFAzUUNzaGp5VERtVXlCM2pYS3ZPRXpuVTFBRmtyZzJ2?=
 =?utf-8?B?eDhLSXM5blVvcGZxTkcyODVuUTBGZnpuTlVobTZNZ1B5REtlMmt0QmwraHN0?=
 =?utf-8?B?NWNwSk1BQzV3cUJBZDFSdytyLzhVWktjRlZDVjdLRnBrajJUTDgwcVcvMXFP?=
 =?utf-8?B?Qkc2N2c5NGVCeWxCY3crUkxub3htTnFtUm1aQXJJNWJ6amU4dWFCQ1RrdGJ2?=
 =?utf-8?B?K3pkZ2NvbjRWKytzV09uUUQ0RmN0UE41VHhKVEc5MDNISzNZYkV4VHpYS3BB?=
 =?utf-8?B?dnFtWTU5blM5N3lsUU4zUzQ3NDRvR05YbFRsRm4wWFF1aGtDNlp2OGdNN1Jm?=
 =?utf-8?B?VUZpNFl1UGJYOTkvS3BUaTBKWWJZZWFsMnpDZlZ5Y3UxSi9hM25JeldBQWc3?=
 =?utf-8?B?SEVUVkhYdllXdFIyT3o5K2JFRDVGVUg2MXZXZUpIMWF5MHZKMlJCZGZvTGdO?=
 =?utf-8?B?RlVRaGlIZXV1RnN4SndHWXgySzhNcW9PaTlBWTlkUXR4K2hmdjU0V1hiRkZh?=
 =?utf-8?B?NXd5U2pwNE1wU1lOaXkxaXNVOVIvUjhuM21BbTQ4MnlHRE9DNGdXVHg0WkxO?=
 =?utf-8?B?MEYxbkFGUzhYSFVZUXpsN3dmOXM0YUE3S0l2M29PWU9wUitVWWxtQnl6THg2?=
 =?utf-8?B?ZG1DVEhaOEIzSjBjOEt4U2w5ME80RW1TcnFrdXJhNW9WcU1saUhGemU5V1NW?=
 =?utf-8?B?MHZyOTA4Mk02eG1LTFJQelZyWXRjRVhLMmRKUGR0M2tNQmZGcDdlWkh5ZXd1?=
 =?utf-8?B?akZ1MkJCVjVFRHhVeEdBamR1YVIxb0JWZDhON3VZdjNFU0NERVlyL1BCZlZ4?=
 =?utf-8?B?R3h6bHcyTW56am92Vkw2RDM2ai9LY21BbENzTm04bmdCYldIZU84TlRDVzdK?=
 =?utf-8?B?V0hQL25TbUtyRmxvd3RtbTEvMWh6aVEzRlp3dlJNdWhpVlFlcG95YzFQdWdn?=
 =?utf-8?B?Rmc2dnEyTEdOMUpZWEl3eFBLWm1tRlBPaXNHZWRqSDI4MWE2K0ZPOUtaeW5Z?=
 =?utf-8?B?eCtTakVYTG5VS1dpZFdwcnlBOWE3VkJTNXppekJYT2ZvUUVuN3ozZ0ZHSEl4?=
 =?utf-8?B?L0c3VFA5cTdGc0VJQVB5MWR0Zi9tRmRadHFIZncrYzZ6R1pmTUwvNnB0YmtJ?=
 =?utf-8?B?MUgrYktJQVcvUHA0MDc1dG1UUHpYcWxiQVhySWlPNUpjdW9GY25tY21mWkJU?=
 =?utf-8?B?L3EyTXhsMXZkRTM3UWRWMVc4K3NRVkdPRncxRlR6WWdUMnZhUGgwbTFhTVJ3?=
 =?utf-8?B?d1pBbVp2d05WdHg5aitVbDJuMDc0NktSMEJhcGtrRmt5MmQ4Um84V3RnaWhq?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCC54B0F2C2640458B95CEF6822A131B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12bd905-cc84-448c-2c74-08da8170a5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 23:23:24.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WE7cH8C5J7e46rOd0wABMhlMAoog7Xuo/L/NTI61S5BzxekDQBgQQN3GLRD5oGid1Fht7tlQ+4COYeg2g/k91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTE5IGF0IDA5OjA1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMTggQXVnIDIwMjIsIGhvb2Fub24wNWdAZ21haWwuY29twqB3cm90ZToNCj4gPiAiTmVp
bEJyb3duIjoNCj4gPiA+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCj4gPiA+IFRoaXMgcG9zc2li
aWxpdHkgb2YgY2FsbGluZyBkX2RlbGV0ZSgpIHR3aWNlIGhhcyBiZWVuIHByZXNlbnQNCj4gPiA+
IHNpbmNlwqAgOTAxOWZiMzkxZGUwIGluIHY1LjE2Lg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsg
OTAxOWZiMzkxZGUwIGlzIGEgcHJvYmxlbS4NCj4gPiBCZWZvcmUgdjYuMC1yYzEsIHRoZSB0YXJn
ZXQgZGVudHJ5IHdhcyB1bmhhc2hlZCBieSBfX2RfZHJvcCgpIGNhbGwNCj4gPiBpbg0KPiA+IG5m
c191bmxpbmsoKSwgYW5kIG5mc19kZW50cnlfaGFuZGxlX2Vub2VudCgpIHNraXBwZWQgY2FsbGlu
Zw0KPiA+IGRfZGVsZXRlKCkNCj4gPiBieSBzaW1wbGVfcG9zaXRpdmUoKS4gZF9kZWxldGUoKSB3
YXMgY2FsbGVkIG9ubHkgb25jZSB2aWENCj4gPiBuZnNfZGVudHJ5X3JlbW92ZV9oYW5kbGVfZXJy
b3IoKS4NCj4gDQo+IEFoaGggLSBzaW1wbGVfcG9zaXRpdmUoKSBjaGVja3MgZF91bmhhc2hlZCgp
IC0gSSBkaWRuJ3QgY29ubmVjdCB0aGF0Lg0KPiANCj4gU28gYmVmb3JlIG15IHJlY2VudCBwYXRj
aCB3ZSBuZWVkZWQgdGhlIHNlY29uZCBjYWxsIHRvIGRfZGVsZXRlKCkgaW4NCj4gbmZzX3VubGlu
aygpIGJlY2F1c2UgdGhlIGZpcnN0IHdhc24ndCBlZmZlY3RpdmUuwqAgSG93ZXZlciB0aGUgc2Vj
b25kDQo+IGNhbGwgaW4gbmZzX3JtZGlyKCkgd2FzIHN0aWxsIGEgcHJvYmxlbS4NCj4gDQo+IFNv
IGlmIHRoZSBjdXJyZW50IGZpeCAoOWEzMWFiYjFjMDA5KSBnZXRzIHBvcnRlZCBiYWNrIGJlZm9y
ZSB0aGUNCj4gcGF0Y2gNCj4gdGhhdCByZW1vdmVkIHVuaGFzaCAoM2M1OTM2NmMyMDdlKSB0aGVu
IGl0IHdvbid0IGRvIHRoZSByaWdodCB0aGluZw0KPiBmb3IgbmZzX3VubGluaygpLsKgIEFzIGl0
IGhhcyBhIEZpeGVzOiB0YWcsIHRoYXQgaXMgbGlrZWx5Lg0KPiANCj4gSXQgd291bGQgYmUgYmV0
dGVyIHRvIHByb3RlY3QgdGhlIGRfZGVsZXRlKCkgd2l0aA0KPiBkX3JlYWxseV9pc19wb3NpdGl2
ZSgpLg0KPiANCj4gVHJvbmQ6IGNhbiB3ZSBkcm9wIHRoYXQgcGF0Y2ggYW5kIHJlcGxhY2UgaXQs
IG9yIHNob3VsZCBJIGFkZCB0aGUNCj4gZF9yZWFsbHlfaXNfcG9zaXRpdmUoKSBjaGVjayB3aXRo
IGEgbmV3IHBhdGNoPw0KDQpJdCBpcyB0aGUgdmVyeSBsYXN0IHBhdGNoIGluIHRoZSBsaW51eC1u
ZXh0IGJyYW5jaCwgc28gcmVwbGFjaW5nIGl0IGlzDQpub3QgYSBodWdlIHByb2JsZW0uDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
