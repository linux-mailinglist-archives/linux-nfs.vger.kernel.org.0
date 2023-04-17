Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD006E5418
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 23:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDQVsJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVsI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 17:48:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032F1BDA
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 14:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXEMKKRc46Jx3WtCTahwxCFg1EWvMoTTLjbWa/NjJAJCveMSHnHKrl9wRNc3dg/IdHt/s7LujDlOfaOi0YPpueD4gTw3skxYO8t0JJVljqkFmV0Kluahrsu72lcIxZujZ+/+YUx1kpTeUVv44najNQLJV4vWKDgahT4LPCQGBf3wS6EhI34uqezinftdqH10Kkmg/nJK+F9KdeGBAZJSc4llPptCota4R6qTjXnWOEHHnLH6ZmylRp3nygMFZlQECzj4lVFgXqaZtd5bX8Ob6l+K9XG78X8E4W/udkq25QczXxCnBfEpYNc2QmRSrYl3QUuMnuEoBsU0RT5ohVmO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYPjvpXd937+wONQatZW7TijpTy2ErbReN9mO22HiHo=;
 b=B84MPMHMUk4GUeW5EYe18YQY4VWC63eucZJbTzQ+u25JVWspSzEbHK0CW/F26h/aiwoHetDWQuCcFKmqiX4HVEuH9d+Mtha+cNlDuc4v1Bszjk5CYKKSrZh3Hu/w0Y0XI5uwUfy+52ZyUMV2RlIPqXaJSMVKtMaySf97/B7F934d3KS70ZbfjGUSh6Y3Ifkx7Sd3nfd0jO25A9MBM8SnUxgg4beAabKtguwUHAJwPt1WuaF8l7XANFe+o3Eb+N2aHpsmfXlOBbQXeDL6X6Opxt0+J70f9quIUNzebXQAtDVefweKvuM2LTZXrF4yTbESQRi8MeKrRBdIdjFSgeRXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYPjvpXd937+wONQatZW7TijpTy2ErbReN9mO22HiHo=;
 b=O6VrVIjAe/h6HUufzlwUWKBKjcfIMjbVmGPL/yksiXd5dQy+rd53FDhPEwLRwl6u26votEs7uU5SYehpcA0mX6dB/A3cniUs8zLFwhl2vKk66QQsoP4Y6F1f5WDV6ShTLfGCMlTjUpYUD4LuuXN+8nsJBuy0wPZQR/mDTXLW6Hc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3709.namprd13.prod.outlook.com (2603:10b6:208:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 21:48:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:48:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp/6QlIRljOckmeDtcvLmj9Dq8wCLWAgAAOegCAAAHKAA==
Date:   Mon, 17 Apr 2023 21:48:01 +0000
Message-ID: <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
         <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
         <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
In-Reply-To: <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3709:EE_
x-ms-office365-filtering-correlation-id: 0cc771b3-723e-4bf0-a43a-08db3f8d6abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a24BLnYo2db39q2OkFs9/RW/LcgDqe8zW/tZUUSrRxLc/imTg5F5TL0EA1EhqArxR31cJBBmlxeKw1zxNfJQceJQ0rpZln9btR3tEP1SyruSQxcoLAhd+KzfRREwqbbtX3FO2OCQf/61thpcP3pT6jbY9Ht26j6JboDKVFTw+YG69B1owxr2mQ/Pjw5SF3B49Gs37YxVy8U1HlsbbDc31S5dYEdLKI2dzPwG1gjlzV/EpkT1M4smWnQYYbiXq+m7T5/zy74iggkqXCvRZSSx2V+Ex3tGUq3nkipzACvNv3yYoeauvDzygsXcefIIMsJRU4md+XDmPtOGnZbSb2rk9XWkUzVCeQbqJJNBUI7r4pa8LQ8WRoKScrdqnKgSNyf1K30WaNtH69h/nk2CKm4IlcCnqmdDQgp1p3oe2LxCp3L9BnLwun4E5WOTdN62OABL2LP3ph6P57xcvYj6eYoq4zJrfflnttKdoYCBVR796e+Hn7wXchSuj37gzkRhEO9WGMParjLZOV3SDHczug9nq/MxfLJTJpuA+9jfLgqC7tkiw8WRbiFqbfVNsW1syobCvL8Zc8YRjSnuHDWU5SgEEeyj4AAgqKWWkpyIdbPqzJSQkF5y+dxiSOJNvD0NWaXt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39840400004)(136003)(396003)(346002)(451199021)(36756003)(38100700002)(6916009)(5660300002)(38070700005)(2906002)(8936002)(86362001)(76116006)(66556008)(4326008)(64756008)(41300700001)(66476007)(66446008)(122000001)(8676002)(66946007)(6486002)(83380400001)(54906003)(6506007)(478600001)(6512007)(53546011)(316002)(71200400001)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VuNGlScnh4ZnlFUS9FUDN1KzNQaTFKRnBwOEw0QkhNajVGeitMVEpBYk52?=
 =?utf-8?B?N0l2bHJ6QzBpT3ZRT1RFQkhoelVnSGZONU9Ua1BnMERVL1A1Sy90VHVVN29V?=
 =?utf-8?B?YzJNMEVva3ZEdGViUlJxd2RHUURFWldNaWUybkE3RXVtOWFhMlhWZUFDRXhm?=
 =?utf-8?B?UkFqWktZTWFpT0doVHZTMUp2UWdTdTBzZzJTazdxazdaQ0NmTVJGVTZUbUpo?=
 =?utf-8?B?bXlubXhjRVRhSnYvRStmY3Zwd0luYWIrQjIveWlZZVdZUjBFTkliWEhXdHJS?=
 =?utf-8?B?eUFLMFk3UUZZNDRIK0thTnhYNittaHZTdXk4UEtBeFkwUTY4Nm9wZ3JaZXNC?=
 =?utf-8?B?VHZhZldOd0V6NHQ0N21GWmNWQnB2TGZnTlNaSVRlTWVmWjB0cldiUXNQNVBp?=
 =?utf-8?B?YWJtMU9FeEpFR1AwbzQwUHd5SkxJV0ZDOEdvOXBaQ3lZa2RSRERLcFR1VTg1?=
 =?utf-8?B?UlFLUzlOZVR1Y0dhYmZrZzRqcHpxWEJ3Z2xsSVdGdTNVb3hVS2drSDZUdCtx?=
 =?utf-8?B?Y3ExMDNwMStmTFhpamY5Z0oxMk5xNXpzTnQrRTNYUVBrSEttTjFaUWwrRDZy?=
 =?utf-8?B?N3d2T0VrbC9Db0U3dE96eEZnSlUwemtxWUdiTFg4ZWpURHBYYWRndzFrUmN2?=
 =?utf-8?B?ZFAyZUE1THcydEt3dzAzK1dMeWdScXh3U0xsTFRMWGhKQVliTGNETDRTZXVx?=
 =?utf-8?B?YVI4SHhrMGd5ektGV0xVM3V5aWJCM1lLelVUMmM5NGlTVS9wODd0RnRrQXB1?=
 =?utf-8?B?Q1ovdlhWWUZkYTJRYWEzMkFJTCtYYWZuVFd5VGVxbWVuVm5NazlWS2JuYlBo?=
 =?utf-8?B?UTRLRzEyNXE4TjZxb1ZrNUNXNTRTdEE0MFlEQXZ5cnJIUTEzVmlSTnFwL0pi?=
 =?utf-8?B?NGM4dm9HcUxlVVJROTNneUNJbzNyV2N1SjBvSlh3bzAxdXhjQTJFWWIvS0V6?=
 =?utf-8?B?TUpKQTQ0dGxOcFRaNzAxNXlTMThVTUNvc1dwZFVmNnAxcnl6UENVb21qZ1ZN?=
 =?utf-8?B?ZExKMmd4QUpqMnI3bHd4cFBMaEE2SnpzZERsSGZnYUQvL3YyM1Y1Mm5FSXBG?=
 =?utf-8?B?NlFSTGFYVkRnRzZoU0I5TlAwZkF4UU01b3FTN3NqUG8wNDJTamxFc2tpWHE3?=
 =?utf-8?B?OEhTaHc5NWo5bWk3ek1uMVVRN09mRTR2SnBwdDFqSHVuYlplWUxHb2diMk1V?=
 =?utf-8?B?a0pVQmtlV2t1NjVvZGRQbC9BOWxkU01Dc3BrTmFyK0FDV1lnR2d0VWh4SUIy?=
 =?utf-8?B?VVdWQWF5MGFxYnNkY2QxNlVYNmJUbFNLOWtXbzNlTU1KSW01bTZCSklPbXpQ?=
 =?utf-8?B?WDFENmI1Y3MrdHFRQm93b1NQK2k4eWRQSkw3UEUzQmFCM3luTHVha2lYR3NX?=
 =?utf-8?B?MG5mQTRmeUJkdmkyc2xVR3BVbWZuUTVEODBwcEo4SzJmRUxPc1QyVlE4QkdB?=
 =?utf-8?B?czg1YUNLYldBSk9PeHVtbWI3SXVtMU9hZ2p2S3F0ZVZldWptQWVvK2NKb1Zl?=
 =?utf-8?B?SmtzMVcySW5KOEZ1dFl2VzFxK1ZHR242M3NFR1FxYVlTeGhXOW9yaWg0eThl?=
 =?utf-8?B?dzRKM3JVY1FwVTUxbXRQODcxQk9yUUJ6MEMrUEFvVmpndStKM2dyVVhRcmlv?=
 =?utf-8?B?T00waHFHRk9MS3lvM3VIUk5VTXIwK0pJVG1GdUIydk0zZFRDUktJMnEyM0Ns?=
 =?utf-8?B?V0Uvc1pRWnZ3ODVIbUQwN2pCTm5GdGwxQWJVcVBDV0ZJNFFuU1lSWlhzZlFi?=
 =?utf-8?B?Ym1sWStEZGZBQWVBME9ldXBNWk51OUhEVlVVTGNUckNDemY3WU00UDhRVUZD?=
 =?utf-8?B?NkxvWTV1T2RpUWs2L05scnpuOUl2RlRWOUx2bVh1ZVhaQkowNUswNWQ0K0t0?=
 =?utf-8?B?MXRvYlVycUQyOFFma25WM1pPSHJjeTJ1cGlZakY3Z2Z0MHV1blZsRWRZcGMx?=
 =?utf-8?B?TFNQMDB3RFE4NUVrSG1RVVJHL0FwS3RqWHhDQWRiZ1pyTndEam9wM3pvMTNn?=
 =?utf-8?B?b3FWdHUrdXQ5eTZFR3JacmJtRFhVaWFVd2RYOFIvcmRRR0pGVUNxcHp2aWRL?=
 =?utf-8?B?bWRYSnROMXZxZjliOUdoS1orSEEvUXN0L0s5SUpueVp5b1FpR3pmWXF2U3R5?=
 =?utf-8?B?K29zZE9mM1pyOGxLVFJqZk81dFpvOC94a1JHYlJ0R2Y0WEpORW5IK0RjeElZ?=
 =?utf-8?B?cXE4UG8wN21aQjUyTmNnMHg2Z092RzJTTmdQN1cxODVib1ZpdjRpL2ZkL29I?=
 =?utf-8?B?QmpwZEtRVlMxVWJJaXBmM1hadEFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41B3F5EECD2F7447A731CEAF3919D8AB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc771b3-723e-4bf0-a43a-08db3f8d6abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 21:48:01.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP6PabLdmGklxCfh0SlMmYyltYwJGwwCYKGL80d59XTG9Wpah8rhvle83GvvVjnyqCFVt4P0qzF/JPoT25lSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTE3IGF0IDIxOjQxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBcHIgMTcsIDIwMjMsIGF0IDQ6NDkgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJp
LCAyMDIzLTA0LTA3IGF0IDIwOjMwIC0wNzAwLCBEYWkgTmdvIHdyb3RlOg0KPiA+ID4gQ3VycmVu
dGx5IGNhbGxfYmluZF9zdGF0dXMgcGxhY2VzIGEgaGFyZCBsaW1pdCBvZiA5IHNlY29uZHMgZm9y
DQo+ID4gPiByZXRyaWVzDQo+ID4gPiBvbiBFQUNDRVMgZXJyb3IuIFRoaXMgbGltaXQgd2FzIGRv
bmUgdG8gcHJldmVudCB0aGUgUlBDIHJlcXVlc3QNCj4gPiA+IGZyb20NCj4gPiA+IGJlaW5nIHJl
dHJpZWQgZm9yZXZlciBpZiB0aGUgcmVtb3RlIHNlcnZlciBoYXMgcHJvYmxlbSBhbmQgbmV2ZXIN
Cj4gPiA+IGNvbWVzDQo+ID4gPiB1cA0KPiA+ID4gDQo+ID4gPiBIb3dldmVyIHRoaXMgOSBzZWNv
bmRzIHRpbWVvdXQgaXMgdG9vIHNob3J0LCBjb21wYXJpbmcgdG8gb3RoZXINCj4gPiA+IFJQQw0K
PiA+ID4gdGltZW91dHMgd2hpY2ggYXJlIGdlbmVyYWxseSBpbiBtaW51dGVzLiBUaGlzIGNhdXNl
cyBpbnRlcm1pdHRlbnQNCj4gPiA+IGZhaWx1cmUNCj4gPiA+IHdpdGggRUlPIG9uIHRoZSBjbGll
bnQgc2lkZSB3aGVuIHRoZXJlIGFyZSBsb3RzIG9mIE5MTSBhY3Rpdml0eQ0KPiA+ID4gYW5kDQo+
ID4gPiB0aGUNCj4gPiA+IE5GUyBzZXJ2ZXIgaXMgcmVzdGFydGVkLg0KPiA+ID4gDQo+ID4gPiBJ
bnN0ZWFkIG9mIHJlbW92aW5nIHRoZSBtYXggdGltZW91dCBmb3IgcmV0cnkgYW5kIHJlbHlpbmcg
b24gdGhlDQo+ID4gPiBSUEMNCj4gPiA+IHRpbWVvdXQgbWVjaGFuaXNtIHRvIGhhbmRsZSB0aGUg
cmV0cnksIHdoaWNoIGNhbiBsZWFkIHRvIHRoZSBSUEMNCj4gPiA+IGJlaW5nDQo+ID4gPiByZXRy
aWVkIGZvcmV2ZXIgaWYgdGhlIHJlbW90ZSBOTE0gc2VydmljZSBmYWlscyB0byBjb21lIHVwLiBU
aGlzDQo+ID4gPiBwYXRjaA0KPiA+ID4gc2ltcGx5IGluY3JlYXNlcyB0aGUgbWF4IHRpbWVvdXQg
b2YgY2FsbF9iaW5kX3N0YXR1cyBmcm9tIDkgdG8gOTANCj4gPiA+IHNlY29uZHMNCj4gPiA+IHdo
aWNoIHNob3VsZCBhbGxvdyBlbm91Z2ggdGltZSBmb3IgTkxNIHRvIHJlZ2lzdGVyIGFmdGVyIGEN
Cj4gPiA+IHJlc3RhcnQsDQo+ID4gPiBhbmQNCj4gPiA+IG5vdCByZXRyeWluZyBmb3JldmVyIGlm
IHRoZXJlIGlzIHJlYWwgcHJvYmxlbSB3aXRoIHRoZSByZW1vdGUNCj4gPiA+IHN5c3RlbS4NCj4g
PiA+IA0KPiA+ID4gRml4ZXM6IDBiNzYwMTEzYTNhMSAoIk5MTTogRG9uJ3QgaGFuZyBmb3JldmVy
IG9uIE5MTSB1bmxvY2sNCj4gPiA+IHJlcXVlc3RzIikNCj4gPiA+IFJlcG9ydGVkLWJ5OiBIZWxl
biBDaGFvIDxoZWxlbi5jaGFvQG9yYWNsZS5jb20+DQo+ID4gPiBUZXN0ZWQtYnk6IEhlbGVuIENo
YW8gPGhlbGVuLmNoYW9Ab3JhY2xlLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28g
PGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBpbmNsdWRlL2xpbnV4L3N1
bnJwYy9jbG50LmjCoCB8IDMgKysrDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvc3VucnBjL3NjaGVk
LmggfCA0ICsrLS0NCj4gPiA+IMKgbmV0L3N1bnJwYy9jbG50LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMiArLQ0KPiA+ID4gwqBuZXQvc3VucnBjL3NjaGVkLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDMgKystDQo+ID4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5y
cGMvY2xudC5oDQo+ID4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaA0KPiA+ID4gaW5k
ZXggNzcwZWYyY2I1Nzc1Li44MWFmYzVlYTI2NjUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3N1bnJwYy9jbG50LmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL2Ns
bnQuaA0KPiA+ID4gQEAgLTE2Miw2ICsxNjIsOSBAQCBzdHJ1Y3QgcnBjX2FkZF94cHJ0X3Rlc3Qg
ew0KPiA+ID4gwqAjZGVmaW5lIFJQQ19DTE5UX0NSRUFURV9SRVVTRVBPUlTCoMKgwqDCoMKgICgx
VUwgPDwgMTEpDQo+ID4gPiDCoCNkZWZpbmUgUlBDX0NMTlRfQ1JFQVRFX0NPTk5FQ1RFRMKgwqDC
oMKgwqAgKDFVTCA8PCAxMikNCj4gPiA+IMKgDQo+ID4gPiArI2RlZmluZcKgwqDCoMKgwqDCoMKg
IFJQQ19DTE5UX1JFQklORF9ERUxBWcKgwqDCoMKgwqDCoMKgwqDCoMKgIDMNCj4gPiA+ICsjZGVm
aW5lwqDCoMKgwqDCoMKgwqAgUlBDX0NMTlRfUkVCSU5EX01BWF9USU1FT1VUwqDCoMKgwqAgOTAN
Cj4gPiA+ICsNCj4gPiA+IMKgc3RydWN0IHJwY19jbG50ICpycGNfY3JlYXRlKHN0cnVjdCBycGNf
Y3JlYXRlX2FyZ3MgKmFyZ3MpOw0KPiA+ID4gwqBzdHJ1Y3QgcnBjX2NsbnTCoMKgwqDCoMKgwqDC
oCAqcnBjX2JpbmRfbmV3X3Byb2dyYW0oc3RydWN0IHJwY19jbG50ICosDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCBzdHJ1Y3QgcnBjX3Byb2dyYW0gKiwgdTMyKTsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5oDQo+ID4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3Nj
aGVkLmgNCj4gPiA+IGluZGV4IGI4Y2EzZWNhZjhkNy4uZTlkYzE0MmYxMGJiIDEwMDY0NA0KPiA+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zdW5ycGMvc2NoZWQuaA0KPiA+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9zdW5ycGMvc2NoZWQuaA0KPiA+ID4gQEAgLTkwLDggKzkwLDggQEAgc3RydWN0IHJw
Y190YXNrIHsNCj4gPiA+IMKgI2VuZGlmDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBj
aGFywqDCoMKgwqDCoMKgwqDCoMKgwqAgdGtfcHJpb3JpdHkgOiAyLC8qIFRhc2sgcHJpb3JpdHkN
Cj4gPiA+ICovDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0a19nYXJiX3JldHJ5IDogMiwNCj4gPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGtf
Y3JlZF9yZXRyeSA6IDIsDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRrX3JlYmluZF9yZXRyeSA6IDI7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRrX2NyZWRfcmV0cnkgOiAyOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBjaGFy
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGtfcmViaW5kX3JldHJ5Ow0KPiA+ID4gwqB9Ow0KPiA+ID4g
wqANCj4gPiA+IMKgdHlwZWRlZiB2b2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICgqcnBjX2FjdGlvbikoc3RydWN0IHJwY190YXNrICopOw0KPiA+ID4gZGlmZiAtLWdpdCBh
L25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiA+IGluZGV4IGZkN2Ux
YzYzMDQ5My4uMjIyNTc4YWY2YjAxIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L3N1bnJwYy9jbG50
LmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gPiBAQCAtMjA1Myw3ICsyMDUz
LDcgQEAgY2FsbF9iaW5kX3N0YXR1cyhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spDQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHRhc2stPnRrX3JlYmluZF9yZXRyeSA9PSAw
KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXNrLT50a19yZWJp
bmRfcmV0cnktLTsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19kZWxh
eSh0YXNrLCAzKkhaKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19k
ZWxheSh0YXNrLCBSUENfQ0xOVF9SRUJJTkRfREVMQVkgKiBIWik7DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byByZXRyeV90aW1lb3V0Ow0KPiA+ID4gwqDCoMKgwqDC
oMKgwqAgY2FzZSAtRU5PQlVGUzoNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBycGNfZGVsYXkodGFzaywgSFogPj4gMik7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJw
Yy9zY2hlZC5jIGIvbmV0L3N1bnJwYy9zY2hlZC5jDQo+ID4gPiBpbmRleCBiZTU4N2EzMDhlMDUu
LjVjMThhMzU3NTJhYSAxMDA2NDQNCj4gPiA+IC0tLSBhL25ldC9zdW5ycGMvc2NoZWQuYw0KPiA+
ID4gKysrIGIvbmV0L3N1bnJwYy9zY2hlZC5jDQo+ID4gPiBAQCAtODE3LDcgKzgxNyw4IEBAIHJw
Y19pbml0X3Rhc2tfc3RhdGlzdGljcyhzdHJ1Y3QgcnBjX3Rhc2sNCj4gPiA+ICp0YXNrKQ0KPiA+
ID4gwqDCoMKgwqDCoMKgwqAgLyogSW5pdGlhbGl6ZSByZXRyeSBjb3VudGVycyAqLw0KPiA+ID4g
wqDCoMKgwqDCoMKgwqAgdGFzay0+dGtfZ2FyYl9yZXRyeSA9IDI7DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoCB0YXNrLT50a19jcmVkX3JldHJ5ID0gMjsNCj4gPiA+IC3CoMKgwqDCoMKgwqAgdGFzay0+
dGtfcmViaW5kX3JldHJ5ID0gMjsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgdGFzay0+dGtfcmViaW5k
X3JldHJ5ID0gUlBDX0NMTlRfUkVCSU5EX01BWF9USU1FT1VUIC8NCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFJQQ19DTE5UX1JFQklORF9ERUxBWTsNCj4gPiANCj4gPiBXaHkgbm90IGp1c3Qg
aW1wbGVtZW50IGFuIGV4cG9uZW50aWFsIGJhY2sgb2ZmPyBJZiB0aGUgc2VydmVyIGlzDQo+ID4g
c2xvdw0KPiA+IHRvIGNvbWUgdXAsIHRoZW4gcG91bmRpbmcgdGhlIHJwY2JpbmQgc2VydmljZSBl
dmVyeSAzIHNlY29uZHMgaXNuJ3QNCj4gPiBnb2luZyB0byBoZWxwLg0KPiANCj4gRXhwb25lbnRp
YWwgYmFja29mZiBoYXMgdGhlIGRpc2FkdmFudGFnZSB0aGF0IG9uY2Ugd2UndmUgZ290dGVuDQo+
IHRvIHRoZSBsb25nZXIgcmV0cnkgdGltZXMsIGl0J3MgZWFzeSBmb3IgYSBjbGllbnQgdG8gd2Fp
dCBxdWl0ZQ0KPiBzb21lIHRpbWUgYmVmb3JlIGl0IG5vdGljZXMgdGhlIHJlYmluZCBzZXJ2aWNl
IGlzIGF2YWlsYWJsZS4NCj4gDQo+IEJ1dCBJIGhhdmUgdG8gd29uZGVyIGlmIHJldHJ5aW5nIGV2
ZXJ5IDMgc2Vjb25kcyBpcyB1c2VmdWwgaWYNCj4gdGhlIHJlcXVlc3QgaXMgZ29pbmcgb3ZlciBU
Q1AuDQo+IA0KDQpUaGUgcHJvYmxlbSBpc24ndCByZWxpYWJpbGl0eTogdGhpcyBpcyBoYW5kbGlu
ZyBhIGNhc2Ugd2hlcmUgd2UgX2FyZV8NCmdldHRpbmcgYSByZXBseSBmcm9tIHRoZSBzZXJ2ZXIs
IGp1c3Qgbm90IG9uZSB3ZSB3YW50ZWQuIEVBQ0NFUyBoZXJlDQptZWFucyB0aGF0IHRoZSBycGNi
aW5kIHNlcnZlciBkaWRuJ3QgcmV0dXJuIGEgdmFsaWQgZW50cnkgZm9yIHRoZQ0Kc2VydmljZSB3
ZSByZXF1ZXN0ZWQsIHByZXN1bWFibHkgYmVjYXVzZSB0aGUgc2VydmljZSBoYXNuJ3QgYmVlbg0K
cmVnaXN0ZXJlZCB5ZXQuDQoNClNvIHllcywgYW4gZXhwb25lbnRpYWwgYmFjayBvZmYgaXMgYXBw
cm9wcmlhdGUgaGVyZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
