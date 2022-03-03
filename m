Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B064CC201
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Mar 2022 16:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiCCP4K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 10:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCCP4J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 10:56:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2116.outbound.protection.outlook.com [40.107.223.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06215679F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Mar 2022 07:55:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctXrdf4/buEuVC/BU/GAKRwgr07GDMBWPaj4Lxrex1N+60hcM/1k6Yj0TBzFKeFNzGMyJcAUtod9pUJejSGsfwkVoAprnFVS8BzRGzPmKABnpCKoPoFsnBaV0Izr0BZYx2Os0QxQaJpsudaxpFlfBDHtUKsTsp+k95JCJm1z6k0JVUL9A1wUaL3ym7fkGuldPMfs+LSrbVCEE3FejU7+OwwrcioT3BP9v0zjgBOrC2TkT+NPqkg6cz8Ye+kxx2ftvdUjA0/IDgju5rxcerBgKqM6E6NUUW3uUr+jdmhHx4nWyIWyKmFMGhDMVjPqT95yXLAmGQUFLByOEA6dLA2gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKm7HFWeRYdHvWJmrQGPzbroSmqbrPBYn9IclMsFwH0=;
 b=E2/Vv7AuLrbTNkxPMpiKBdAYAt4vzlqQFxRbmtZL28hBl21qthSuTVbGKfzHfoHtwLtjKA/qipwZmhpWFM3NA3JMGnVoJvpPP2/KHgCtb6cevJOvhy+Pe9a45Nbv6Ww34NCqYTpoLBNMtX2mH05L316j9PDuHlTHRdMUMfpgC9Y0ZxmpSezHDJ4VCwnpcPFFiAYdskiswMm1OgF46toqtkl3uViNN0LMCtpzrItzWCSlSzwwyw6vO0Wstncw0CbYc5B6kELVOuc0qbA2zk3fwfzkC0FuLCXqn/b0DpK512G+PsLoSiLvcIly4cpaTN7eIVhOn4XBM3FBuN2UJCeUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKm7HFWeRYdHvWJmrQGPzbroSmqbrPBYn9IclMsFwH0=;
 b=fFc421My+f+5P5a4ALy7bgkUTViDkPcaiooVMn3yEXcb1o4ArZXtskvxdjiaJQrdI9KCmulTW2CfBYaOGXtMd8mGLiVpTSWdJuc82xn+dUqUJMLW1lQu8csGzrteFt/ayMMZJsX1GVwrkRZqK3QI2XOGY6k9jtFh/YBLe22b2js=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3216.namprd13.prod.outlook.com (2603:10b6:208:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6; Thu, 3 Mar
 2022 15:55:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 15:55:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS access problems when group membership changes on server
Thread-Topic: NFS access problems when group membership changes on server
Thread-Index: AQHYLr+3CeZUt7iAdUWYTyXSboQv6ayt0KQA
Date:   Thu, 3 Mar 2022 15:55:15 +0000
Message-ID: <c834d47c685d2c6a227846f31ba259b893fcbf73.camel@hammerspace.com>
References: <164628537738.17899.2312723585718867242@noble.neil.brown.name>
In-Reply-To: <164628537738.17899.2312723585718867242@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fd5480c-7701-4ada-d8d3-08d9fd2e35a0
x-ms-traffictypediagnostic: MN2PR13MB3216:EE_
x-microsoft-antispam-prvs: <MN2PR13MB321695AF9899B72BDF09537CB8049@MN2PR13MB3216.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zfU032JRKlnTbWvT6Qqbxlm3qiMIyBBgA5w3YK2YfaBZ5x6PO0ReRWaqnX/FwosaAxi6cbzNZ3wf7I+aRM0fwb16kRHL5XqN1asaL2uAKTvgLU+u65t/c+sos0vf1J92UFiBpgscchxJZuCPTkKUD16ks1FeLDmMN5tS1kFNUMkkvHSzlkmUDictjhronWYK107XukTfznyojxboX/4A4rU0AmP7qJ6UIdFy3Qy29SxBtJEgerNMKs7x+jk++KrtXV+Xxmao8B+wwi9vqOBmbsuxAeamhMce1jCKY6vtO3bewBBESctyCy4kNbuaTkXOriPubnYXwmqvERgkQmQ7+S6izfgeTmuCt/CN6A02PKuu52cMZOs+8NM958PE6GxNGWybkN9ukPLHJXiIUOGM5buuoJR+4YdUMDPfAhTnA7f0Sa+LvwliP3o2nN2kthJxCnEgzmX5sZplbCA3CyR3vgfRbbPyJSHzPADh+is9e8ghC8ebzU1wi9nFXUNtEz//iL66BrF1IbpGjzVxIq9yEeA7u0Hh6ZXONp7KFiTP47kscI8hfNWnC6SXuPpufYSpN8KD/Cw0H+hdTOuIf1PXCClVrfwNtLRZiPZ299bXFf81Cbb1x9mR8P2QScUFFM+fGBiHcNJ+dtDvVbqFtegJcb/LvbNXzbLgqZQwaJr5FXf9hnN70Q6R4OMgWi9o8jPulQP+4TA1RtH8wYefxICYqQCYZ2wGw78RTKeBNIj+r1FJ3RkmZZxCQdXKIf1AF31
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(2906002)(8936002)(36756003)(38070700005)(2616005)(38100700002)(6916009)(122000001)(26005)(86362001)(186003)(76116006)(66556008)(66946007)(66476007)(508600001)(66446008)(8676002)(64756008)(4326008)(6506007)(83380400001)(5660300002)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUt0SC8vSWJQeVUxdkh0clhCczhaTk5sQU5iODFjU0x1SEYwdWsrZ1pHN0hQ?=
 =?utf-8?B?TXdMMkRVTm9oYzVUWVBLYzA2N2ZtOWxGc2xJa1pBUW5lUjJ5T0FsaVFydW02?=
 =?utf-8?B?V09uc3lidHFRbGorWjNaaE1aVzdoYXdILzEwUUdMSHBQZHFyK2ZqeWxTME5L?=
 =?utf-8?B?Q2xmRGRSMjdzNkg4T1RwRTRSZ0doUjRNeFh6cjkrYWhyYWU5eW1nd00zT2dN?=
 =?utf-8?B?cmswOHJzWENYbVlRZjlrcWcrUXlRTCt6eTZSejRmMGVSNkMyQ01DUlhGUWFE?=
 =?utf-8?B?S1lYcnF2UzBUY1NFNnoyOEpoUzgxZk56cDhCODYxMHZQL3VWZEI1ZjZQMzI2?=
 =?utf-8?B?QWR1Rkx2T3E0cTZzQkZRRGdhZ3A4b3JISkE2dHYyRjlMZXdOMlc2S0RIc3g0?=
 =?utf-8?B?V3o5blJ5eVFtdGVFMk5BV3JCOHE2SW9DNElrYmtpMnlSeWhmVFRYVll4NlR6?=
 =?utf-8?B?emhqVXZ2T1o3M2lIZHVPRXFVZVJxcG04QVJiNGpMQWc3cUdyb2wvaFcvWHg5?=
 =?utf-8?B?R0JPNEkvS0c2UC9ncUE5YmlYczQyR3R3MWg1Vk5JT3R5T2d4M29jM2RhNUZF?=
 =?utf-8?B?ZWhmdERGMTZlUzI5SnB3dlFucG91ckx2UExmWjZVbXRqMUVURWpGZTRhNE9H?=
 =?utf-8?B?cG1hUitObE5XcUpkVlp4L3dVRit6YjlnbFllS1VwcEYwVWE4WUQzSW9icXRI?=
 =?utf-8?B?TVo1N25vV1hVbmVCNU5jdkZpK2s1K2pWZFZ1L3ViaWpFREdmUWt5b1U2NWNK?=
 =?utf-8?B?ZnNmQkF6TU1mVDNpRXV4QXdWUEQzYS82bmVla3RON0MwY2FmTjVHN2VxMU5D?=
 =?utf-8?B?Z0Joa1Z2c3ZxWFVGWW1YMDlMaXFkcVI2K3l2ZUtEbCtyVTBIZTB0L2NXVzY5?=
 =?utf-8?B?NkxEVXpHVUdiNTRuRHU0UVJxdk5JM3pvZng3UkJtRGtRUkxyQ2xOOEpMT2M1?=
 =?utf-8?B?Mk43MnhIVmlMU3J6dEFuU242bHdxdWNSOGszRkxDcTZ3UlQydm50N294VlV6?=
 =?utf-8?B?d1p5MURNUTNkRmJJWjNnY25jMEpHSHhzNS9nc3FtZnRaU0QvNFZMTTBpV0dv?=
 =?utf-8?B?eFhPand5MWtiUXl1N3lranFTRFo5RW1YbmJnOUN3cjlGcU9LRGRUWkt6ZHEw?=
 =?utf-8?B?QXlVdVpnUzJxNU15aXlzQm9paVpzM25kT3ZjRnBxK1llWjdLd3dST1IxRzh6?=
 =?utf-8?B?TEtQS2pwYnNyUHNMWityUFV5R3psdkZBOXg4ek1wT1ZxZU52OEwwQzdCMEJE?=
 =?utf-8?B?MWdvSXQ4d2tjNGhWSi9TcnNkZzlWZWcwSnRiaC9KcDlDeS9TdEptc1NYajY5?=
 =?utf-8?B?OXJ2cHJ4UE5telpRSWVpNlNxVThOblhDSVBrZ0ZFbmM2WVhTNTZ3ZnpKRmx3?=
 =?utf-8?B?MXA1aW4zczdEUzVUSC83Q0srQmN6SHNld2hXVHVDRDZZbGNjMzQzZzlDeFZG?=
 =?utf-8?B?RTBHN0RVTTdrazdzY0JRd29XZS9aNm5DUGtucUpBaDhKM0kyVDZGdGpLU0Mv?=
 =?utf-8?B?ZFdWL1E3dmp3UUxhMFRmVVQxRVFJR2lsbFUrdnN2ZkdtOG9EQ0hNTGdWMUxZ?=
 =?utf-8?B?YW5WdS9wTy9XaFZIWis0YUh6S2hsMGlhNm00c2ZEamxDTDdJWEY3S2ZhMFhH?=
 =?utf-8?B?SlJnaWdTU3pQMVVXR3Z5eFVxRjRSNHo1RDZQYlczNnBzWk1hWHdENVBlYTlO?=
 =?utf-8?B?azZ6eGpkUmptWEgyL1VvN1d0U21xT2FwNGdKOGNiUVNjcEhtbEc1Nm5Cc1R6?=
 =?utf-8?B?eHRBYzgwY2kvRzIxUjlqbHdINEpNNjlTRHRyWUJsSGltZVM5RXNhZGFCaWp0?=
 =?utf-8?B?K0t2UllnMUZRdHBrdXltajh0a3BmSTc3dGtKYW5sV1gwVnpOT09NVFdDQzZH?=
 =?utf-8?B?R3RTS282Mkl3ZWJPU09YQXIveFltT0tpdEtHYnVIclhkVFZXRCtWZ2hsYVFM?=
 =?utf-8?B?NUdVVlRNdHpEN1l2RjFxWWR4amVlMHpkdWQwSW9LRjYrdnpTZVExeW4rMHND?=
 =?utf-8?B?SHd0TmsyWDVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47528735131D994FA536C4D29910A5EE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd5480c-7701-4ada-d8d3-08d9fd2e35a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:55:15.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3FeyZpZugBLux/XN9FyyZvijd+YWrVs6Jm+6Q569EoVydFVtQE3IRiMxgfA0Oz+Rn7rciSFbXH46cIyXlm4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTAzIGF0IDE2OjI5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBTaW5jZQ0KPiDCoENvbW1pdCA1N2I2OTE4MTllZTIgKCJORlM6IENhY2hlIGFjY2VzcyBjaGVj
a3MgbW9yZSBhZ2dyZXNzaXZlbHkiKQ0KPiB3ZSBkbyBub3QgcmVjaGVjayAiQUNDRVNTIiB0ZXN0
cyB1bmxlc3MgdGhlIGlub2RlIGNoYW5nZXMgKG9yIGZhbGxzDQo+IG91dA0KPiBvZiBjYWNoZSku
wqAgSSByZWNlbnRseSBkaXNjb3ZlcmVkIHRoYXQgdGhpcyBjYW4gYmUgcHJvYmxlbWF0aWMuDQo+
IA0KPiBUaGUgQUNDRVNTIHRlc3QgY2hlY2tzIGlmIGEgZ2l2ZW4gdXNlciBoYXMgYWNjZXNzIHRv
IGEgZ2l2ZW4gZmlsZS4NCj4gVGhhdCBpcyBtb3N0IGxpa2VseSB0byBjaGFuZ2UgaWYgdGhlIGZp
bGUgY2hhbmdlcywgYnV0IGl0IGNhbiBjaGFuZ2UNCj4gaWYNCj4gdGhlIHVzZXJzIGNhcGFiaWxp
dGllcyBjaGFuZ2XCoCAtIGUuZy4gdGhlaXIgZ3JvdXAgbWVtYmVyc2hpcHMgY2hhbmdlLg0KPiBX
aXRoIEFVVEhfU1lTIHRoZSBncm91cCBtZW1iZXJzaGlwIGFzIHNlZW4gb24gdGhlIGNsaWVudCBp
cyB1c2VkDQo+ICh0aG91Z2gNCj4gd2l0aCB0aGUgTGludXggTkZTIHNlcnZlciwgYWRkaW5nIHRo
ZSAtZyBvcHRpb24gdG8gbW91bnRkIGNhbiBjaGFuZ2UNCj4gdGhpcykuDQo+IFdpdGggQVVUSF9H
U1MsIHRoZSBtYXBwaW5nIGZyb20gdXNlciB0byBncm91cHMgbXVzdCBoYXBwZW4gb24gdGhlDQo+
IHNlcnZlci7CoCBJRiB0aGlzIG1hcHBpbmcgY2hhbmdlcyBpdCBtaWdodCBiZSBpbnZpc2libGUg
dG8gdGhlIGNsaWVudA0KPiBmb3IgYW4gYXJiaXRyYXJ5IGxvbmcgdGltZS4NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgdGhpcyBhZmZlY3RzIGZpbGVzIHdpdGggTkZTdjQgYXMgdGhlcmUgd2lsbCBiZSBh
IE9QRU4NCj4gcmVxdWVzdCB0byB0aGUgc2VydmVyLCBidXQgaXQgZG9lcyBhZmZlY3QgZGlyZWN0
b3JpZXMuDQo+IA0KPiBJZiBhIHVzZXIgZG9lcyAibHMgLWwgc29tZS1kaXJlY3RvcnkiLCB0aGlz
IGZhaWxzLCBhbmQgdGhleSBnbyBhc2sNCj4gdGhlDQo+IHNlcnZlciBhZG1pbiAicGxlYXNlIGFk
ZCBtZSB0byB0aGUgZ3JvdXAgdG8gYWNjZXNzIHRoZSBkaXJlY3RvcnkiLA0KPiB0aGVuDQo+IHRo
ZXkgZ28gYmFjayBhbmQgdHJ5IGFnYWluLCBpdCBtYXkgd2VsbCBzdGlsbCBub3Qgd29yay4NCj4g
DQo+IFdpdGggYSBsb2NhbCBmaWxlc3lzdGVtLCBsb2dnaW5nIG9mZiBhbmQgYmFjayBvbiBhZ2Fp
biBtaWdodCBiZQ0KPiByZXF1aXJlZCB0byByZWZyZXNoIHRoZSBncm91cHMgbGlzdCwgYnV0IGV2
ZW4gdGhpcyBpc24ndCBzdWZmaWNpZW50DQo+IGZvcg0KPiBORlMuIA0KPiANCj4gV2hhdCB0byBk
bz8gDQo+IA0KPiBXZSBjb3VsZCBzaW1wbHkgcmV2ZXJ0IHRoYXQgcGF0Y2ggYW5kIHJlZnJlc2gg
dGhlIGFjY2VzcyBjYWNoZQ0KPiBzaW1pbGFyDQo+IHRvIHJlZnJlc2hpbmcgb2Ygb3RoZXIgYXR0
cmlidXRlcy7CoCBXZSBjb3VsZCBwb3NzaWJseSBkbyBpdCB3aXRoIGENCj4gbG9uZ2VyIHRpbWVv
dXQgb3Igb25seSB3aXRoIGEgbW91bnQgb3B0aW9uLCBidXQgSSBkb24ndCByZWFsbHkgbGlrZQ0K
PiB0aG9zZSBvcHRpb25zLg0KPiANCj4gTWF5YmUgd2UgY291bGQgYWRkIGEgJ3N0cnVjdCBwaWQg
KicgdG8gdGhlIGFjY2VzcyBlbnRyeSB3aGljaA0KPiByZWZlcmVuY2VzDQo+IHRoZSBQSURUWVBF
X1NJRCBvZiB0aGUgY2FsbGluZyBwcm9jZXNzLsKgIFRoaXMgd291bGQgYmUgZGlmZmVyZW50IGZv
cg0KPiBkaWZmZXJlbnQgbG9naW4gc2Vzc2lvbnMsIGJ1dCBjb21tb24gdGhyb3VnaG91dCBvbmUg
bG9naW4uDQo+IElmIHdlIGRpZCB0aGlzLCB0aGVuIGxvZ2dpbmcgb3V0IGFuZCBiYWNrIGluIGFn
YWluIHdvdWxkIHJlc29sdmUgdGhlDQo+IGFjY2VzcyBwcm9ibGVtLCB3aGljaCBtYXRjaGVzIHRo
YXQgaXMgbmVlZGVkIGZvciBsb2NhbCBhY2Nlc3MuDQo+IEknbSBub3Qgc3VyZSBpZiBJIGxpa2Ug
dGhpcyBpZGVhIG9yIG5vdCwgYnV0IEkgdGhvdWdodCBpdCB3b3J0aA0KPiBtZW50aW9uaW5nLg0K
PiANCg0KQWN0dWFsbHksIG1vc3Qgb2YgdGhlIG5ld2VyIGNvbW1vbiBpZGVudGl0eSBtYXBwaW5n
IHNjaGVtZXMsIGluY2x1ZGluZw0KQWN0aXZlIERpcmVjdG9yeSBhbmQgRnJlZUlQQSB3aWxsIHN0
b3JlIHRoZSBncm91cCBtZW1iZXJzaGlwIGluIGEgUEFDLA0Kd2hpY2ggaXMgYXR0YWNoZWQgdG8g
dGhlIHRpY2tldCBvbiB0aGUgY2xpZW50LiBTbyB0aGUgbWFwcGluZyBzdGlsbA0KaGFwcGVucyBv
biB0aGUgc2VydmVyLCBidXQgaXQgdXNlcyBpbmZvcm1hdGlvbiBmcm9tIHRoZSBHU1Mgc2Vzc2lv
bg0KaW5zdGVhZCBvZiBkb2luZyBhbm90aGVyIHJvdW5kIHRyaXAgdG8gdGhlIGlkZW50aXR5IHNl
cnZlci4NCg0KVGhhdCBtZWFucyB0aGUgZ3JvdXAgbWVtYmVyc2hpcCBhcyB1bmRlcnN0b29kIGJ5
IHRoZSBzZXJ2ZXIgaXMgdGllZCB0bw0KeW91ciBBVVRIX0dTUyBzZXNzaW9uIGFuZCB0aGUgdGlj
a2V0IHRoYXQgY3JlYXRlZCBpdC4gVG8gY2hhbmdlIGl0LCB5b3UNCm1heSBuZWVkIHRvIGludmFs
aWRhdGUgdGhlIEFVVEhfR1NTIHNlc3Npb24sIGFuZCBjaGFuZ2UgeW91ciBrZXJiZXJvcw0KdGlj
a2V0IHRocm91Z2ggYSBuZXcgImtpbml0Ii4NCg0KPiANCg0KPiBBbnkgb3RoZXIgaWRlYXM/DQo+
IA0KDQpBcyBJIHNlZSBpdCwgdGhlIGNhY2hlIG5lZWRzIHRvIGJlIHRpZWQgdG8gdGhlIEdTUyB0
aWNrZXQgc28gdGhhdCBhbnkNCmdpdmVuIGVudHJ5IGNhbiBiZSBpbnZhbGlkYXRlZCB3aGVuIHRo
ZSB0aWNrZXQgaXMuIFRoYXQncyBhIHNjaGVtZSB0aGF0DQphbHNvIHdvcmtzIGp1c3QgZmluZSBm
b3IgQVVUSF9TWVMsIGFuZCB3b3VsZCBleGFjdGx5IHByZXNlcnZlIHRoZSBQT1NJWA0Kc2VtYW50
aWNzIHdoZXJlYnkgd2UgdXBkYXRlIHRoZSBncm91cCBtZW1iZXJzaGlwIG9uIGxvZ2luLg0KDQpP
bmUgc3VnZ2VzdGlvbiBmb3IgZG9pbmcgc28gbWlnaHQgYmUgdG8gYWxsb3cgdGhlIGNhY2hlIGVu
dHJpZXMgdG8NCnN1YnNjcmliZSB0byB0aGUgUlBDIGNyZWQgdGhhdCB3YXMgdXNlZCB0byBjcmVh
dGUgdGhlbSBpbiBhIHdheSB0aGF0DQpkb2Vzbid0IHByZXZlbnQgdGhlICBjcmVkIGZyb20gYmVp
bmcga2lja2VkIG91dCBvZiB0aGUgY2FjaGUgKGkuZS4gd2UNCmRvbid0IHRha2UgYSByZWZlcmVu
Y2UpLiBJZiB0aGUgY3JlZCBpcyBubyBsb25nZXIgaW4gdGhlIGNyZWQgY2FjaGUNCndoZW4gd2Ug
Y2hlY2sgdGhlIGFjY2VzcyBjYWNoZSwgdGhlbiBjb25zaWRlciB0aGUgYWNjZXNzIGVudHJ5IHRv
IG5lZWQNCnJlZnJlc2hpbmcvcmV2YWxpZGF0aW9uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
