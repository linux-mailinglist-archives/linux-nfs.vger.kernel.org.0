Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF059EE76
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiHWVwh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiHWVwf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 17:52:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698689926
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 14:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAPO/0II4zlTbZZ9/TQMnLn0uLWQjmDpdixP6BhCN5KVB8u9oU45xyS5z+ZfoUWLqzI+seWJCQn5yrgkpxJUK6RwpziK2raBc+aL1WaGmyJMR7mFrmZ/6K9ry6q1W3mLGFakFiOg2vORFhqsyqLBWooGSkugHyjJVhiLzav81oa09cuEBbv06AKOZZo59Vr+sgKU8W+KqCMCfjCZoMWzTJRNfmGzM76Iqi/S257r4oqDbNLltz9IJTCjvJJ0EO8BfLP9Gu3tCxShIsXg0DMMuhvjuONHQa3MTuMi6Ec4b9bchHUl67U9xfn817SY/c0IW+JOE+UTBARjNr1rLxPDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dINJUHyIFwYg4Il4dGnCxZ3wZqrfRYc01K1qyY6H6Q=;
 b=fMkaTCO5ZnzL2LcEmufZFfcJEyZWz4jsbBVy5gJ6dM53SBGvHESkvlA79tiUAWxy3cUnBrtm/GOqpvndxY7bk9GGq0yq/hPBdJYgAFZTM/3vyaa1llEIEkcC7LuoDLb8XMpM76ZquiLGNbOGKtxlwBeuN1agUQVIC3RpTex3bJR8NLuTKZJ86JLdVHxvWpFAOMRBzQe2A/OkRwALME8j5IWlkFWWEfBVdFECVkeGP9JLQBtLL9wxG9evKUQiDDXxkUSjKfTxCIw+u7wtxd29STOb1VbO8E/R+OvXAc5yqTLkGx5MhvlxeHXcTpiM8txgkeweuBLiZn9srouXhA/tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dINJUHyIFwYg4Il4dGnCxZ3wZqrfRYc01K1qyY6H6Q=;
 b=eLQHn060M+YT9xzR2ApG4Osf27gW2MZnHi07VX/n6550eX6m/b6IgTQwCzqk9Nrb/aZnYWtdx9tpXzkQHgREI+TcKl6SW/jLe8zmiLm0NvTPTuSlWQKZY9psVs5iOEZ10hRX+Q0n6/JGZuD3xkF53UaLoW6ZRd1iXgvKdHIlYlI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3513.namprd13.prod.outlook.com (2603:10b6:5:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 21:52:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Tue, 23 Aug 2022
 21:52:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/7] SUNRPC: Fix end-of-buffer calculation
Thread-Topic: [PATCH v1 1/7] SUNRPC: Fix end-of-buffer calculation
Thread-Index: AQHYtzNyFfoXIoy7ZEywnnGCAmNvda29BtwA
Date:   Tue, 23 Aug 2022 21:52:28 +0000
Message-ID: <78191e118727c12796fa1256d4e093877f4fca09.camel@hammerspace.com>
References: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
In-Reply-To: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23590a57-2c6c-43b0-5a2b-08da8551c626
x-ms-traffictypediagnostic: DM6PR13MB3513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxckzbL9wlh2jjYwaNaWJ+T0vqkaXauJn/arSVGFzjmOBvgF/O83wnvAfRb6OB9NspddwQoHjvItzUNe0yptIbAna8u2xg1hy2sNqU90/lqlt8BE1ek+yVloR1mBWK0VPhNgCOpwlnL+d0PBvi/WwX604+szwRo3BmNog4r+zNXeBdzU/eWFjtckHl17thM7dPpZg+D/apqWGVgOPXbrryNDfF899N9Jhu3nZgHakMRq6E6hfiheIn/LRweEn5OyJ9HdsneMgt6KuztysrU2jWCWy4mplzuUV5EulvLLPdMa89BVhkcb8z6Nxsex7yP1YCYK4jIDN+Cv+htP00H4N7ekzRZl9l3X2uM3QOSPnPTh544B/BLrV3vEhBMD4YUXQ8h3G81fCAb71tNZiFUZQbIa8x8TA/PWcvbhdraRhk6Hmg/p01IvqdlK2N6oIWJ7zQnCS0IPVlCELHOgAJo8orSLVYxuDnZ4JwYvFuHvcI8pCNlu6nOm0bWbVnTh2rqfwKuFvAuAP5xU+7UyLYJB7glrQdjCNhmRZOV5BuKENMs0bMTLHsFXN9aGVFvMjl6AKSfAeFef0PvzCfADc4hnrteV3uVP3uZhBabtt6QTMRlMrQVjVZ5m7A+jUPuuon4I9j9/zCxnm+fIJA7DPA6Aea4qqdbWM2Sew6eFH3FLFDq5z2QbijtIA1+cpnjnBwF86RjzYXZoCV0sd6Iogg8NVvYA/nEPivTw6lzqYCE15dmDnzhZsHEo8VbnR/YjDZTleecHiWTRXmk0pTLfiboGFLzBFKbQWHESIBFNEQ1HOC7397BOXj/2E7UfhGIllFwK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39840400004)(346002)(396003)(366004)(136003)(83380400001)(76116006)(38070700005)(86362001)(110136005)(316002)(6506007)(6512007)(26005)(186003)(66946007)(6486002)(38100700002)(8936002)(5660300002)(2616005)(122000001)(71200400001)(66556008)(478600001)(66476007)(8676002)(2906002)(36756003)(66446008)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjQrcERONFFaYmNWWkt1UHFyY2E2Z1JuUGsxclZuZ0YvNzdRajNRVmxiamJM?=
 =?utf-8?B?SVA4SnJsZEFkbi9nT0hrakErcDJ4a0J6RHBkTXRsbEZkb05iN1hDN05ta0ZM?=
 =?utf-8?B?blMrTTJaMjRTYW92NEF3ejY4WDlZbzFBSXlHQnVCLzdkdTV6STZoUEk4Y3J1?=
 =?utf-8?B?eFJDbGpMUEdVUC9YY0JDZEZ6Zm1XTDNuRlVqYTBQQ3NlZ1lPdXkvbEJCVTVZ?=
 =?utf-8?B?Sy9kN3pmb292OTh3ajgrbWJtN2NyZ0hsOTkwRG9Da0dXNzNpUUdkMDlkR2NB?=
 =?utf-8?B?TEdYRHcyZnZaWTlRNWVmQTA0UVdLRmdJUFA1UGp0UmdFQm8rbTQ5YnhxUnFB?=
 =?utf-8?B?YVltdWliOEo4RjRHMS9UYU9qd3crc3A3dWUrSXhBV1NoOGFsQmlndG12cmk0?=
 =?utf-8?B?N2lUUDlEd1Zta0pqYWEvamJYY3VUR0xmci96YjdqVExmUDRHSHJhenVpU0JX?=
 =?utf-8?B?dWZXNENSdklIcGFYd1JYK1c3SWZiU21hUVByUFpNdG5pMk8xR25wZGc1cHdC?=
 =?utf-8?B?eElZK3ZGTjg0N1B4cFNzdTdSSEkwN0F2cWdFMkJGQ2d0cEEyOWRUOEJxRmhJ?=
 =?utf-8?B?TG0xSTd0Znh0YmU1eE43Y2VPVWFPalF0TVpQVXNFU1MxWDQ0blVJQ0h0K2Ev?=
 =?utf-8?B?TGozaW5FUWw1d21JNGtESXRLS1o0VkZQaFhmVmV1VzVQMFVtb054Slo3dmIx?=
 =?utf-8?B?QndLTncyUVUvcVlvMDcwVkpsZU83ejdvTDBxMWlwTzlCWGRqa2d1OWdDVFVo?=
 =?utf-8?B?SjUrVHVkdERtWDVFNFNTVU13ejNwbExiazZiT2c4cGY0OFJENVZ5NDJweEJJ?=
 =?utf-8?B?ZUt6bjRkSThkOEtyczhpMHB5SXFESnlFSCtmSkJDTytNd0hUWHJTbmFKS3Jh?=
 =?utf-8?B?a09MaWhRb1VVUTdtTnV1TjZiWGFRRDc2N2lzd0xyY2FrQXo2RHFqU1hBSXBQ?=
 =?utf-8?B?TVd0bnVZelBuUnVxTGlGN1Qvc3MxckxFV2txNU5tL1RsYlZvdGxWNzFlT2Nz?=
 =?utf-8?B?MFg4dTUrV2hVeVNNSjhrelpPS2NOVWFiMEFEQTJwSU9oNis0Z20vNlpXbWll?=
 =?utf-8?B?eVpsYnkxTlFuaUd6REx6U3F0Q1YvK2FhSTJNYnFXZnUyUlRqa2FoRDVoNjlC?=
 =?utf-8?B?dUZ6VmNhTHJHL01RdjE1VzIzdTlqL1pMQno3eVhreHBERUdkSUtRYjRveTlj?=
 =?utf-8?B?VlpTalVlTW1xd3JrTU4yNjc1QjYrR1BwbmdCNDExUi9aQzduMnpxd3ZBY0lJ?=
 =?utf-8?B?N0tSUEcwa2tqMWg0amRQK012aUN1dTdHOXczK1NtZllFbEtMT3gwbjBWM0dx?=
 =?utf-8?B?MS9SOXdPcU02eDNraUlMUmxPZTIwVlRXaEp6Q2pOYXM5OWppdTVoQ2RRNHF4?=
 =?utf-8?B?all4V3RYUVJWVUYyNjF0azI2NVN2WWtQcnEwdCtOeGlrOWFRalFQK0F3YzdX?=
 =?utf-8?B?YXJkSVdldDFVMHozblROSU9YT1pSZ2VrVTBNWEJPeHhXZTUyaktnanBXcUtx?=
 =?utf-8?B?RHN1dmY0RmhZaDkrNU9LK01CaEt5VWc5MU43K0M0bGI0S0haQ21NNG9ORXlM?=
 =?utf-8?B?K2VJV1RhWFpUME5OOUZXTjJGZnh5eWtHOEhwdDMvV254aXdSSGlrUG1hT2Ix?=
 =?utf-8?B?cWlTMXdnOTBhL3l5ZlBKWlJHNXRNeFU1eTJNRVF1Rk9VY0YwRUx1L3VzZ05I?=
 =?utf-8?B?Zk5sbEhUZGxubDVJVkFQWFR2Mm5uZTllY0NGa2VsaGdPN2hJZS9RREhXdTZS?=
 =?utf-8?B?amQzMFFWTXNSRWliS1k2YVVrZEJSaE1SNW9TcU5ZS3k0R1N0U1BUdTU5MzJq?=
 =?utf-8?B?YTBvZE4ya05ES1B3K3BNMHdjaU80WUlJUWgxQiticWV4d3Q5Z3RSK3cwWS84?=
 =?utf-8?B?UEhYQ3lhMEJjblU3OW12WU02U0dVblBUems5cmlxbC9RTjZQK0hBQUdESnJt?=
 =?utf-8?B?MUNRYmRvQ21hck5RaHZUSWo2ekdMMDYwcTBGWXdwdGhpRjNJRFczYTNLRHpq?=
 =?utf-8?B?ZFZvTUU5b2EyaHNFbTgxWlhBYWtiVVpMZkVpVmk0Tjd6NzNqWFUzZ0dicGVH?=
 =?utf-8?B?TkJsY2JZU3NnV1FCZStWWlhSSEh0NElLSkVOM2NDa05rVzdsWG5mNVlyeUgz?=
 =?utf-8?B?S0VRdkxnWnNhQ1FpVFEzL1k5bnZxcng2S253OE1rSkJFTTI0ZmY0MWZNVVVl?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15D17C10B9C504E857449B47FD8504C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23590a57-2c6c-43b0-5a2b-08da8551c626
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 21:52:28.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHftioLRb3vBd2pqlWLLcHzDomxLPsyzfqnba98Sc6TNK7tKxU4ksLQQbkD2rlN5K8/SUKjlVWinPq5a1rLMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTIzIGF0IDE3OjAwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
RW5zdXJlIHRoYXQgc3RyZWFtLWJhc2VkIGFyZ3VtZW50IGRlY29kaW5nIGNhbid0IGdvIHBhc3Qg
dGhlIGFjdHVhbA0KPiBlbmQgb2YgdGhlIHJlY2VpdmUgYnVmZmVyLiB4ZHJfaW5pdF9kZWNvZGUn
cyBjYWxjdWxhdGlvbiBvZiB0aGUNCj4gdmFsdWUgb2YgeGRyLT5lbmQgb3Zlci1lc3RpbWF0ZXMg
dGhlIGVuZCBvZiB0aGUgYnVmZmVyIGJlY2F1c2UgdGhlDQo+IExpbnV4IGtlcm5lbCBSUEMgc2Vy
dmVyIGNvZGUgZG9lcyBub3QgcmVtb3ZlIHRoZSBzaXplIG9mIHRoZSBSUEMNCj4gaGVhZGVyIGZy
b20gcnFzdHAtPnJxX2FyZyBiZWZvcmUgY2FsbGluZyB0aGUgdXBwZXIgbGF5ZXIncw0KPiBkaXNw
YXRjaGVyLg0KPiANCj4gVGhlIHNlcnZlci1zaWRlIHN0aWxsIHVzZXMgdGhlIHN2Y19nZXRubCgp
IG1hY3JvcyB0byBkZWNvZGUgdGhlDQo+IFJQQyBjYWxsIGhlYWRlci4gVGhlc2UgbWFjcm9zIHJl
ZHVjZSB0aGUgbGVuZ3RoIG9mIHRoZSBoZWFkIGlvdg0KPiBidXQgZG8gbm90IHVwZGF0ZSB0aGUg
dG90YWwgbGVuZ3RoIG9mIHRoZSBtZXNzYWdlIGluIHRoZSBidWZmZXINCj4gKGJ1Zi0+bGVuKS4N
Cj4gDQo+IEEgcHJvcGVyIGZpeCBmb3IgdGhpcyB3b3VsZCBiZSB0byByZXBsYWNlIHRoZSB1c2Ug
b2Ygc3ZjX2dldG5sKCkgYW5kDQo+IGZyaWVuZHMgaW4gdGhlIFJQQyBoZWFkZXIgZGVjb2Rlciwg
YnV0IHRoYXQgd291bGQgYmUgYSBsYXJnZSBhbmQNCj4gaW52YXNpdmUgY2hhbmdlIHRoYXQgd291
bGQgYmUgZGlmZmljdWx0IHRvIGJhY2twb3J0Lg0KPiANCj4gRml4ZXM6IDUxOTE5NTVkNmZjNiAo
IlNVTlJQQzogUHJlcGFyZSBmb3IgeGRyX3N0cmVhbS1zdHlsZSBkZWNvZGluZw0KPiBvbiB0aGUg
c2VydmVyLXNpZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJA
b3JhY2xlLmNvbT4NCj4gLS0tDQo+IMKgaW5jbHVkZS9saW51eC9zdW5ycGMvc3ZjLmggfMKgwqAg
MTQgKysrKysrKysrKystLS0NCj4gwqBpbmNsdWRlL2xpbnV4L3N1bnJwYy94ZHIuaCB8wqDCoCAx
MiArKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMvc3Zj
LmggYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmMuaA0KPiBpbmRleCBkYWVjYjAwOWMwNWIuLjQ5
NDM3NTMxM2E2ZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zdW5ycGMvc3ZjLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMvc3ZjLmgNCj4gQEAgLTU0NCwxNiArNTQ0LDI0IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBzdmNfcmVzZXJ2ZV9hdXRoKHN0cnVjdA0KPiBzdmNfcnFzdCAq
cnFzdHAsIGludCBzcGFjZSkNCj4gwqB9DQo+IMKgDQo+IMKgLyoqDQo+IC0gKiBzdmN4ZHJfaW5p
dF9kZWNvZGUgLSBQcmVwYXJlIGFuIHhkcl9zdHJlYW0gZm9yIHN2YyBDYWxsIGRlY29kaW5nDQo+
ICsgKiBzdmN4ZHJfaW5pdF9kZWNvZGUgLSBQcmVwYXJlIGFuIHhkcl9zdHJlYW0gZm9yIENhbGwg
ZGVjb2RpbmcNCj4gwqAgKiBAcnFzdHA6IGNvbnRyb2xsaW5nIHNlcnZlciBSUEMgdHJhbnNhY3Rp
b24gY29udGV4dA0KPiDCoCAqDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIGN1cnJlbnRseSBhc3N1bWVz
IHRoZSBSUEMgaGVhZGVyIGluIHJxX2FyZyBoYXMNCj4gKyAqIGFscmVhZHkgYmVlbiBkZWNvZGVk
LiBVcG9uIHJldHVybiwgeGRyLT5wIHBvaW50cyB0byB0aGUNCj4gKyAqIGxvY2F0aW9uIG9mIHRo
ZSB1cHBlciBsYXllciBoZWFkZXIuDQo+IMKgICovDQo+IMKgc3RhdGljIGlubGluZSB2b2lkIHN2
Y3hkcl9pbml0X2RlY29kZShzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQ0KPiDCoHsNCj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIgPSAmcnFzdHAtPnJxX2FyZ19zdHJlYW07
DQo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBrdmVjICphcmd2ID0gcnFzdHAtPnJxX2FyZy5oZWFk
Ow0KPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgeGRyX2J1ZiAqYnVmID0gJnJxc3RwLT5ycV9hcmc7
DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBrdmVjICphcmd2ID0gYnVmLT5oZWFkOw0KPiDCoA0K
PiAtwqDCoMKgwqDCoMKgwqB4ZHJfaW5pdF9kZWNvZGUoeGRyLCAmcnFzdHAtPnJxX2FyZywgYXJn
di0+aW92X2Jhc2UsIE5VTEwpOw0KPiArwqDCoMKgwqDCoMKgwqAvKiBSZXNldCB0aGUgYXJndW1l
bnQgYnVmZmVyJ3MgbGVuZ3RoLCBub3cgdGhhdCB0aGUgUlBDDQo+IGhlYWRlcg0KPiArwqDCoMKg
wqDCoMKgwqAgKiBoYXMgYmVlbiBkZWNvZGVkLiAqLw0KPiArwqDCoMKgwqDCoMKgwqBidWYtPmxl
biA9IHhkcl9idWZfbGVuZ3RoKGJ1Zik7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgeGRyX2luaXRf
ZGVjb2RlKHhkciwgYnVmLCBhcmd2LT5pb3ZfYmFzZSwgTlVMTCk7DQo+IMKgwqDCoMKgwqDCoMKg
wqB4ZHJfc2V0X3NjcmF0Y2hfcGFnZSh4ZHIsIHJxc3RwLT5ycV9zY3JhdGNoX3BhZ2UpOw0KPiDC
oH0NCj4gwqANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIGIvaW5j
bHVkZS9saW51eC9zdW5ycGMveGRyLmgNCj4gaW5kZXggNjkxNzUwMjlhYmJiLi5mNmJiMjE1ZDQw
MjkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvc3VucnBjL3hkci5oDQo+IEBAIC04Myw2ICs4MywxOCBAQCB4ZHJfYnVmX2lu
aXQoc3RydWN0IHhkcl9idWYgKmJ1Ziwgdm9pZCAqc3RhcnQsDQo+IHNpemVfdCBsZW4pDQo+IMKg
wqDCoMKgwqDCoMKgwqBidWYtPmJ1ZmxlbiA9IGxlbjsNCj4gwqB9DQo+IMKgDQo+ICsvKioNCj4g
KyAqIHhkcl9idWZfbGVuZ3RoIC0gUmV0dXJuIHRoZSBzdW1tZWQgbGVuZ3RoIG9mIEBidWYncyBz
dWItYnVmZmVycw0KPiArICogQGJ1ZjogYW4gaW5zdGFudGlhdGVkIHhkcl9idWYNCj4gKyAqDQo+
ICsgKiBSZXR1cm5zIHRoZSBzdW0gb2YgdGhlIGxlbmd0aHMgb2YgdGhlIGhlYWQga3ZlYywgdGhl
IHRhaWwga3ZlYywNCj4gKyAqIGFuZCB0aGUgcGFnZSBhcnJheS4NCj4gKyAqLw0KPiArc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBpbnQgeGRyX2J1Zl9sZW5ndGgoY29uc3Qgc3RydWN0IHhkcl9idWYg
KmJ1ZikNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGJ1Zi0+aGVhZC0+aW92X2xlbiAr
IGJ1Zi0+cGFnZV9sZW4gKyBidWYtPnRhaWwtDQo+ID5pb3ZfbGVuOw0KPiArfQ0KPiArDQoNCk5B
Q0suIFRoaXMgZnVuY3Rpb24gaXMgbmVpdGhlciBuZWVkZWQgbm9yIHdhbnRlZCBmb3IgdGhlIGNs
aWVudCBjb2RlLA0Kd2hpY2ggYWxyZWFkeSBkb2VzIHRoZSByaWdodCB0aGluZyB3LnIudC4gbWFp
bnRhaW5pbmcgYW4gYXV0aG9yaXRhdGl2ZQ0KYnVmLT5sZW4uDQoNCklmIHlvdSBuZWVkIHRoaXMg
aGVscGVyLCB0aGVuIHN0dWZmIHVuZGVyIGEgc2VydmVyLXNwZWNpZmljIG1hdHRyZXNzDQp3aGVy
ZSBkZXZlbG9wZXJzIGxvb2tpbmcgZm9yIGNsaWVudCBmdW5jdGlvbmFsaXR5IGNhbid0IGZpbmQg
aXQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
