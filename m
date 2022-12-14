Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C464D028
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiLNTmD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Dec 2022 14:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLNTmC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Dec 2022 14:42:02 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2138.outbound.protection.outlook.com [40.107.102.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BD319021;
        Wed, 14 Dec 2022 11:42:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9R75tN0A59oXPV6iMZnw1tIc/gyG2nD1Btp4+xEXoPnI2Skf2smOe6QYDgrHMVA7GaSk+Z24R2DDAtkgp8UTDaN9uLG3qUEEefZX94rpDNBPmyx64XBK90xHM0XHVV73KM4c0Prx8P3rAEFROXzYR492+TCXwxnfQODXQUJau6MGl/xxirIVsbBRBzNp0spknKr1t6UQTYs/nC0lo69asy9zdutNFYeB3y5eE5x0IFj8Dzr12AIRtLzGUMW1azThirbMcvc8YL37VOFMvT4R11gPOCwBMtFu1N8bWva2GSg7Q65UgWljluLlaFfdha6T7/GmEpAa80mrAWSMpSaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlNOVW55DWGHwIVxFOR8K+7jag6aUgPqN0g8e28+8XQ=;
 b=ODpEn99uaTMNHEbXW3Oo0YCfNRmroW0XxyKtEZCrtQlK+agvFgcQqaPsTuo8n56uanI7fwoMjyKAxxGX9mcXqo6Dzgdkhn7wIK3YjcswRnG+EtDLRFaRDOIkIAr/czTiIatuxG+1F10cib0+D9zXtawFy7I9V6+5tNLJ5y9tdgIoCr5gzn+PEEGDrZSkDeXly2RiHHWfZEDbixsaGeLiayqXMrd2IY+xb3EESX/MBh9vnjA68Hi19jFvMMg1Rx/rldRL/XScP23KN4IjMFp9iofV1CzwDyCayfJ2tsb4pBDcrLEumDU+2wExDsTEHU4K3WuGIn/AxgO/AzmNMKMNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlNOVW55DWGHwIVxFOR8K+7jag6aUgPqN0g8e28+8XQ=;
 b=BJTOkfcLo1oQ7jvTodu/jZj8DGR8ZFk9/FlPAmnbwUnWvGRMrqVnUrKrcqRvSl1Y6K5cmWnszDbu+WW6uYOS5mbK/Xa8JlbYe60R1wV8V4Pi6dsqTPlkK/64V1VyptgUuzVfZS/lNrTRtbSfgjR4WLuE2yqbpBsePQQzz5gViiw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO1PR13MB4936.namprd13.prod.outlook.com (2603:10b6:303:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 19:41:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 19:41:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Chengen Du <chengen.du@canonical.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Jeffrey Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: fix client permission error after adding user to
 permissible group
Thread-Topic: [PATCH] NFS: fix client permission error after adding user to
 permissible group
Thread-Index: AQHZD5jJeMugTfCRPk+a4NVsB5/YfK5tyP6A
Date:   Wed, 14 Dec 2022 19:41:54 +0000
Message-ID: <2B6CD9C5-EE21-4275-9F6E-AF1C1C5E164F@hammerspace.com>
References: <20221214084730.296936-1-chengen.du@canonical.com>
In-Reply-To: <20221214084730.296936-1-chengen.du@canonical.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO1PR13MB4936:EE_
x-ms-office365-filtering-correlation-id: 26627764-96cb-4416-21ba-08dade0b40ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N27h8Ed7bcyI0d4qe3glDuwjb5JC5XeSxvpee+tHIkftNGbETp86pCxNlXutoaSThvyBobIhtexeLzj8W19Q1DVGhK//nabqKN76AfPHVkTzb1jRTglZvUAN04vHxfiBf7+boH59QnyWneXUNup38IyH6xrzqTz2Cd/H1z30Q5Xc/NkYgpNt2j5sBSg3sUvyIneo+BBw8Q1i8SYqNja3CoWo8gxHBeikm6eZESGc/Hl/X3msaHw/uaVMihG1mahWBvzsqAlyV9tqwyD8uh1T6zmSDRXAkIRFTrkFYFbcUJ0GlKlAhjgBwgiOra+/PexaB+oug4pwgVduaf6pLD6ebka491+hwlNSUi/swulFHh1MqtlwbSGMfnbDZVquIO/ZbSsc7L2/1zpzm6FTIKiAG5FDOz6cifT6l5PlnwYtGdDf8uhQ7RSRVZaJGfgyrJdOJKlkRxoaswo9MPYvaabDdSWmYvRn/OLZYkHMrYySynBXoqHrH5ffdcFUyPy0xluR2MlJdfjfDvFCiYBP/wVVDB6sllLX+h2SK2qVjf563wczKjpWYfE47byhYXb4CsOGU5hXL/R9g5V+TxQMNucGC1tBYD7xLRbKpflf0IJvT6G2bQsgoByuJuZ+PebYIX4NRZdnPAL326y3uFqzKsij2qtpiBDcL3BtoROv+kHWiVjGteNFdQNkVAeDBoisVqJmLI8+OvTA32VlQlMvZUHdGlIeYDIP28IfdeTENaaz0gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39840400004)(136003)(396003)(346002)(451199015)(71200400001)(478600001)(26005)(6486002)(66899015)(6916009)(66446008)(41300700001)(4326008)(6512007)(66476007)(54906003)(66556008)(36756003)(5660300002)(6506007)(64756008)(53546011)(8676002)(8936002)(2616005)(33656002)(86362001)(2906002)(38100700002)(83380400001)(76116006)(186003)(316002)(66946007)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmM3cVdpdjBZR1h6U1JVeFFtcHRyOVlIditEQTRRaHdQRmpMNW1Qb2ZoSHBD?=
 =?utf-8?B?aG5nRHM5RWs0UDdPOUZZaHFFbkNhWUQvZHlEMjRXL21tVTA2U0dFYWkveVRk?=
 =?utf-8?B?RjRzaHYrUGh1U3lkVzluTExvS1JDNmx6OWp6ekgvNVA3NUxPSCtOYWc2UFVQ?=
 =?utf-8?B?SVRZMVozby8zbTJHZFN0K3R3Q2xiSGh4djJ6c21aTDgwN3NHcE9hQkJRaGtv?=
 =?utf-8?B?c3J4ckdVZTFHOGNoeitIZ3R2ODkvOUlnaFZwTS9HeFdWVncrUXBxZmgrdTk5?=
 =?utf-8?B?Q3JFdjQ4b2pkaDE4WDBjWm9vMVUyNEw0UWJDYzlkTytMOXcrWkNhODBKZWNF?=
 =?utf-8?B?QmppWk9zeEk5M2dPcklmN1RyblB0UTF1NFBwdFc4ZHNLRnErYTdoV1FEYTlp?=
 =?utf-8?B?Q0FQaURFUVJHNlduTWFxT3FQVXZkUy8rSzdQVEMvLzF0b0ZQN0hsSnlkbmdJ?=
 =?utf-8?B?QW1maXpsbHl3QkF4UHNzaWcxWENhaUJ6ZmZpL0Q4TUJDVHlySHcvaER5QWpo?=
 =?utf-8?B?RWxZRUxiVnYvZmRkNjJ4cktsMUpMUWRVTHcxTjlYMS9BWGRacWNCdy9ObXFP?=
 =?utf-8?B?SkM2dVBncHRuREVCeHczQjAxaHFtcm9GRjg0Z0JIUWsrU2ZtUDNsc3NJTlRO?=
 =?utf-8?B?Y0JwczV2WWtpVHc5TkJremJETm80NTNWUy9DZnpWckVjaGZhL2JmN25rRnRw?=
 =?utf-8?B?UWxrYkpncUZmZlYrM21LR25wck0vRG02cWNDMWptTkErMFRkSkFNbEdERFlm?=
 =?utf-8?B?OURlVFdDSkVLRkxLSUFZZnZ4RDNOZG1oOTNJQVBoUWpwemNBdjU1ZHluczJQ?=
 =?utf-8?B?bHQwQWpEbFVqUFVpSDhDVFp3SmxPV0VSbXJWRFJKMW9pZGtaNHEwWGcvR0RD?=
 =?utf-8?B?UEMyOG55WUdzTWJzWUJQR2NXMWdnVXpXN2RJME1rVXlua0w0RXdsdzZ2Ymh4?=
 =?utf-8?B?bVZYalJRYTkzYU9ubUxsZHlRamNDT3B2RTZXcGdiUmNDOFJxWEdvdFZIUVVw?=
 =?utf-8?B?dFl5MTlXY3RFWXU4MFBjZmJQUGZiL29zVlhtaDIySVhwS0w1Y2xTWHBMbm1T?=
 =?utf-8?B?MVF1UFNZSy81Rzk5Y3hXTTgzKytSb2RqMUo3N005NWNqNEExTFF2WkZnemdn?=
 =?utf-8?B?ZmZyR1gxWk8zaFArS29oMFFmYWE0SVNXYU9lRVdPT2gxUnc3Y1cwVXVZZktL?=
 =?utf-8?B?N0lyWjdvRzVkNklveVdJNGc2T211UE1ObDBHUytuMTErNjA1RDQvT3dhRDRh?=
 =?utf-8?B?eEtZTjRtZUdLblVFZHJXcmlxZ1dEUnJVZFRmc3pjcXlLNW1KbmdiK1dFUm1y?=
 =?utf-8?B?Tkg3RG1WMTBNamUzS3ZiRUovV0VFRHVTaUNHeW40VXBiRXg2ekxqb1pBYzF6?=
 =?utf-8?B?ajQ1YUEyMmFJdzNwZ1NQaGMvOU1STXJ1czUwK1dVeFVQemFoempWeGtYcEdH?=
 =?utf-8?B?bytjOWw3Ynk2TmxhamdJK0x5UEI0eXBBb25kSnVrMWtwUE43TzdHOHdmU0E0?=
 =?utf-8?B?dUc4RzRtdE5lQ1JMdUhMWDQrRzZZMXR5ZFdTcjNGNFQ3VVNjSm96L0w1aVNv?=
 =?utf-8?B?NEtRUCt3VGFVQ1BMRXBQY0E3K0tuMmd3aTR0c1J1dUV6cXlxZzZVdDZ3Uklo?=
 =?utf-8?B?R3Btby9jUjZjU21PcEpPeWFwU3d4R2ZyU3BpRjJEdFBMbjlacW9RSEE0QVAr?=
 =?utf-8?B?WmpaKy9uOThob1hJYmQ0bjJGZ1Z1ZFNUQnJvTzZxZ2xqZGJUN016TzA1d1N3?=
 =?utf-8?B?SXBRY1dLdjRFeWRBNkthcHdmbHZtZEhxTzh6N2NiNHZGRDh0R2Q5T1lWby9h?=
 =?utf-8?B?cUo4WEZjcVUySVNBcTNXaUtrdnp1WnIxL1Y4SjMxSFI3czByMkY1ZW5aNFVm?=
 =?utf-8?B?aHd4Z0xqS0NoSDNlMGpkcTIzOVBnakRTZnJDL1ptOFZsWHJKUE9obGc4SFlo?=
 =?utf-8?B?ZnNRVVQzOTJxcXJzQ1dNeVhpUkpZVm5IYTBzZ1FySTVPMHBnUlFYVmdtQjlH?=
 =?utf-8?B?OVkrTDBDdURhSDh2VFdubTh4OGUxVkRldDB6M3JOSGJJU0JyUWRidC84RnlQ?=
 =?utf-8?B?YUd3b3BydEtac2dlaDZRL2tiSlNySEEwL1V1QTNSL00wK2dJWUF5RlZ6Mk8w?=
 =?utf-8?B?NlBaaUwrY1Q4ZndQbkYvUjZxTzhIcWMyM2N1c244MXJ3UXNEbGhPcEtBakR6?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B56C1BB5006CFA4A8AE34B014DF4D259@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26627764-96cb-4416-21ba-08dade0b40ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 19:41:54.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqKinwuDnOdtZvZsNca9my9UVxbrI+XPb3fG4PNvTz+aara6xSQAJskIDsBHeE8tZFRLK3rx916aXf0mH5BqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDE0LCAyMDIyLCBhdCAwMzo0NywgQ2hlbmdlbiBEdSA8Y2hlbmdlbi5kdUBj
YW5vbmljYWwuY29tPiB3cm90ZToNCj4gDQo+IFRoZSBhY2Nlc3MgY2FjaGUgb25seSBleHBpcmVz
IGlmIGVpdGhlciBORlNfSU5PX0lOVkFMSURfQUNDRVNTIGZsYWcgaXMgb24NCj4gb3IgdGltZW91
dCAod2l0aG91dCBkZWxlZ2F0aW9uKS4NCj4gQWRkaW5nIGEgdXNlciB0byBhIGdyb3VwIGluIHRo
ZSBORlMgc2VydmVyIHdpbGwgbm90IGNhdXNlIGFueSBmaWxlDQo+IGF0dHJpYnV0ZXMgdG8gY2hh
bmdlLg0KPiBUaGUgY2xpZW50IHdpbGwgZW5jb3VudGVyIHBlcm1pc3Npb24gZXJyb3JzIHVudGls
IG90aGVyIGZpbGUgYXR0cmlidXRlcw0KPiBhcmUgY2hhbmdlZCBvciB0aGUgbWVtb3J5IGNhY2hl
IGlzIGRyb3BwZWQuDQo+IA0KPiBTdGVwcyB0byByZXByb2R1Y2UgdGhlIGlzc3VlOg0KPiAxLltj
bGllbnQgc2lkZV0gdGVzdHVzZXIgaXMgbm90IHBhcnQgb2YgdGVzdGdyb3VwDQo+ICB0ZXN0dXNl
ckBraW5ldGljOn4kIGxzIC1sZCAvbW50L3ByaXZhdGUvDQo+ICBkcnd4cnd4LS0tIDIgcm9vdCB0
ZXN0Z3JvdXAgNDA5NiBOb3YgMjQgMDg6MjMgL21udC9wcml2YXRlLw0KPiAgdGVzdHVzZXJAa2lu
ZXRpYzp+JCBta3RlbXAgLXAgL21udC9wcml2YXRlLw0KPiAgbWt0ZW1wOiBmYWlsZWQgdG8gY3Jl
YXRlIGZpbGUgdmlhIHRlbXBsYXRlDQo+ICDigJgvbW50L3ByaXZhdGUvdG1wLlhYWFhYWFhYWFji
gJk6IFBlcm1pc3Npb24gZGVuaWVkDQo+IDIuW3NlcnZlciBzaWRlXSBhZGQgdGVzdHVzZXIgaW50
byB0ZXN0Z3JvdXAsIHdoaWNoIGhhcyBhY2Nlc3MgdG8gZm9sZGVyDQo+ICByb290QGtpbmV0aWM6
fiQgdXNlcm1vZCAtYUcgdGVzdGdyb3VwIHRlc3R1c2VyICYmDQo+ICBlY2hvIGBkYXRlICsnJXMn
YCA+IC9wcm9jL25ldC9ycGMvYXV0aC51bml4LmdpZC9mbHVzaA0KPiAzLltjbGllbnQgc2lkZV0g
Y3JlYXRlIGEgZmlsZSBhZ2FpbiBidXQgc3RpbGwgZmFpbA0KPiAgdGVzdHVzZXJAa2luZXRpYzp+
JCBta3RlbXAgLXAgL21udC9wcml2YXRlLw0KPiAgbWt0ZW1wOiBmYWlsZWQgdG8gY3JlYXRlIGZp
bGUgdmlhIHRlbXBsYXRlDQo+ICDigJgvbW50L3ByaXZhdGUvdG1wLlhYWFhYWFhYWFjigJk6IFBl
cm1pc3Npb24gZGVuaWVkDQo+IA0KDQpUaGFua3MsIGJ1dCB0aGUgY29ycmVjdCB3YXkgdG8gZGVh
bCB3aXRoIHRoaXMgaXMgdG8gbG9nIG91dCBhbmQgbG9nIGJhY2sgaW4gYWdhaW4sIHRoZSB3YXkg
dGhlIFBPU0lYIGdvZHMgaW50ZW5kZWQuIFNlZSBjb21taXQgMGViNDM4MTJjMDI3ICgiTkZTOiBD
bGVhciB0aGUgZmlsZSBhY2Nlc3MgY2FjaGUgdXBvbiBsb2dpbuKAnSkuDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg==
