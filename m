Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C814C02E4
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Feb 2022 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiBVULn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Feb 2022 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiBVULn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Feb 2022 15:11:43 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2100.outbound.protection.outlook.com [40.107.100.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5310DA4E
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 12:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh8kjOrLShLpB3JHhDnMWnCQ+764NCCHqTsj4W05j34m0bz3b6gHaO4PL1NUu4zonsCSl+96aIChMCXJn28KJGntXOTluY09TCBesdgokHUB0Ko1N5TwrpecQPw5gBLjoEZao5ZVtDBf7iMujHa2eX772oka6DwplGwsCLJgsuZ3hPa0n9DDPKcLht3pDyTPaQmbXY5qw3PoUmr84cGZhNtQfZO7GSz/Y2kV0ao3jaWm+fTh+IU/BZsvXG3qdUT89DjZTN2Pxul9bafCtyVVsGdDPeD8n/vM7qd8zXXgKHDydk89PKA6+NA7aef7XH1NIxhIv2inbNviMiAkj1hw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIxiFOLI6NJjyj7jb17CWFWq9hlVbyTFpQrDhjKP7zE=;
 b=Pq1c7Rw+2JBcoykg3a+e/1tlXVB1z/auqJp/X95bT/yxX18+gsyhn3l2cz4TVlkQTn4qvorOo0qKhD8auJzqqyIt3m06bippOF12aIPYZ3Xwqx1DPObYzkE5ZJBFSjPVlh1clk04jLZvoBXo/d/n5QJkXmGihO9hPQhaX0d/wepUtKf64zCya94qYqWtMhrkPhwbxtQjwpQECNqjQdscrnV/iSPoIjqUntLW72kitCJ4u8ppy8/OTDIgYZ3o5cLFUl+ibz9wnWGyIo/Hsb6MoYNjulapipwj8YvmMCkXsS9VsIYPHsUJns86vzQGz8cweH7Nm0K0mGYog7vFMRNvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIxiFOLI6NJjyj7jb17CWFWq9hlVbyTFpQrDhjKP7zE=;
 b=fxbVn8kF4pyXnEHuyt+wcSyZ5FiPQv4qNh5Md0d0BfP3tgddZ78Mp7abY/oLQQWBqLUJJN7qCGn2XzvMJz+4i8SQ9gLqSCfZ4/ylT1vtkMmJyagSiAF2mBAyHn4aPtPi9wYFQSeVF3bpD+d1p4nKozBHAJyFLroUvBu0zQ8YyTw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4592.namprd13.prod.outlook.com (2603:10b6:5:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9; Tue, 22 Feb
 2022 20:11:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 20:11:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQCAAAazAIAACUeAgAAEHICAACQ5AIAA4liAgAB7MoA=
Date:   Tue, 22 Feb 2022 20:11:13 +0000
Message-ID: <4f1963e80028d6c162512465cee403c10fa2ab77.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
         <20220221160851.15508-2-trondmy@kernel.org>
         <20220221160851.15508-3-trondmy@kernel.org>
         <20220221160851.15508-4-trondmy@kernel.org>
         <20220221160851.15508-5-trondmy@kernel.org>
         <20220221160851.15508-6-trondmy@kernel.org>
         <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
         <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
         <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
         <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
         <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
         <79a2c935bd5b9044c216c90ebfac3dc2e8e6b888.camel@hammerspace.com>
         <17D70218-EECB-456B-9BCA-E7FC128A4864@redhat.com>
In-Reply-To: <17D70218-EECB-456B-9BCA-E7FC128A4864@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b3b1adb-702b-4b9c-c975-08d9f63f79a8
x-ms-traffictypediagnostic: DS7PR13MB4592:EE_
x-microsoft-antispam-prvs: <DS7PR13MB45927B3CC1AB34E7230AE985B83B9@DS7PR13MB4592.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sp70L6nJ7nUxEHIUcqt+HJ4Y7kaGz0b4eGG/31AeC746sG3ByeovJ3h3NeOfjspTleCh6JF2H+PDu+qzy2AcLVfnXHUeywS24uATJDGSK19mfSAdOfJXTnXi6a+yNk1OLws+49Kh0yJuHWCz/EGHJowq4rdd68hKEe5EKEzG1bMVy/U+r0+mOr3o9lGACG6tQ42TpqZRfNWLp/hRp6uf/HsnUAHEgQU878Qb55rgifg2mQhBOq8xZNS4kV9blgK5qZMCPT+/HZctDWGensmkc5ND9eSzMZefPBN3OaDnhdX+QV3MA54ZCN0nsipOll2ijmyTJdpBXQH7LsuPo60ohx+82eGxuSI7enVIT8bQ1Iq1xZoAKYAEE20J3ZyuFLsWb0hR6sKl0e+rxlSY3L2c8Fg3ESpfXg5R102t1Xvb69p94ce3KTurUJWH8npSa3kuADtLZHoB2VV1+3UX0FG/i+EcG10gwrWGXEXtlvv/DggQ1wDhQW6djnJOd1CHG/YFc/GX2GlpGGeJ9LG71oKEg+kDaJRjWbyjzV/s+aEoOiBKDdvCs5MW4ASnStVUqLb3mcmJeTsFvuz+So2zVLde48Jl+wiTNH/+4OwTqpMaAIIOhYlUB0hKAJtun+bhw1GRduxq26hlCs5IA4xGepM/Aq3B565S6MTj1sRJBWMATJh8txQxs9DkqIRInKIGb5rJIIH7exvEF/2D6dOBYq1n0Xul6MOsDHRFBPpjes6m+QiG/2McGI9HncnjarimCTl+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(66476007)(66556008)(26005)(6506007)(6512007)(76116006)(122000001)(66946007)(66446008)(38070700005)(508600001)(64756008)(71200400001)(8676002)(4326008)(36756003)(53546011)(6916009)(83380400001)(38100700002)(5660300002)(6486002)(316002)(86362001)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elk2WDNWYlZGWnNTTWhHK01ONW01QmQrMnV1bGN2c3E2Mk1UU2tYZnM3WTY3?=
 =?utf-8?B?QzZLcVN4SW9Sb1A4WlYzbjd3bXYyYktxVFdJdE5PcTFEcTBDcXJ1aTV6eHU3?=
 =?utf-8?B?VTUyQjRlaDFVZGtFNzRLdDNSQWZIb2FIN00rL3hwN2dNOTNjZkwzSlgyWXZ3?=
 =?utf-8?B?YmZuNnJwbTRsY0p4TStIK2VZNlMxTG8rTzIzQWdjWE1KQTh5RnhRcUJtRElM?=
 =?utf-8?B?b3draHc4UWNrcFZHdnlFTGVZZHFkaXRrRHRkMnRiS2tuUGRFRVJtQm45YUdj?=
 =?utf-8?B?N3FvdkhUcWdHQUh0Mk8rTncvZFdoaFJ2Zk8yUjFDM1A4L3JwRVd6VG51TTVv?=
 =?utf-8?B?cjBKa0R5QWNvZU1GUHBCUWtlOXhlTm95MzhvU0JaL1NJTE5rd2kzMmlTSDR0?=
 =?utf-8?B?RnNtT2lOcS94WEtNcVlvbXJHU2tZT3BoVnhkTXNWaUFQZVFWNHJuNFlORkZR?=
 =?utf-8?B?MW5Gb2VDSXg1eCszU2JRb3U5ZVpFODA1ZXRjUFRTeU9GYXdhNjNBWGt5WXdt?=
 =?utf-8?B?UjIvK2RYYkJtQUNuaWxYU1VSaWl6QllmcUZ0UkorMmY3N0NPZzYyczVBWjhM?=
 =?utf-8?B?YzNuUzR2Um1ZamphVUNuYm04Sk5lVGFGUFl1UnZvM0E1aExUZUlwMGducUJW?=
 =?utf-8?B?SU5iaFpvd0hGcmgydjhITytKclVqc3V1a21NQk1xTFVMY20yK2RDSExaTGd4?=
 =?utf-8?B?NlZUVzhtYzNZWTlxQWwzY3Q1VDVRT1p3M1YvZTE3dHRaWEJTazY1TWVDVXhw?=
 =?utf-8?B?QlRadm1FVnhLYmlPWDFLVG8ybkdNUzNxOXpicVExUVg0NW5WdEZOTkw4VUcx?=
 =?utf-8?B?dEVVM2I1ZDJPYkFONlBMS2tLNVVGcHZycFJBZVQzSTBScG1lTXJHZmVDVWJR?=
 =?utf-8?B?TFZ6TlZkSHhEVmFJT0lreEliMnRlK0F3YjFSd1o1d0E5WGdEOVV0M0lqS1Bv?=
 =?utf-8?B?bHRSc0krNjNJWXd4MExpSVNRNlFXdHZTRmpoUXBzNmZveWx3WjcrSWVIRzJB?=
 =?utf-8?B?QnpaeXZ2ZTF6OHdNQmZrZnpDVHo3b2QwL2VZcWJEekVhK01oTzZOZ1I5dU1S?=
 =?utf-8?B?NndodHBCbzV1L2lmVmd5ODlXVWlDVkdIV0xyQ0V6Lyt0NS8rR2VwMjBMUnBu?=
 =?utf-8?B?Q09FNFRlVXZNaGsvSnRTNUNGL1hFd0VWUzUrNTd6TmY1V2Vad0N4K3lqNExX?=
 =?utf-8?B?WE4yck9YV0tjTGJpOFRnNXcxb2RlUlhBM1V6YjVZcUpDSEEzNGo1M05FUnUw?=
 =?utf-8?B?YVBMZkpJU1VwMUlxWW5STHpDUmdraDdpQlVETmxRWmYvSGZ4V3FSemJGVFNO?=
 =?utf-8?B?NDdhUVJnT3U4dDNHY0JXbU51SS9iM2VxeWVEODJlVldLNURhSURCTmpEb0FS?=
 =?utf-8?B?K0Y0YXhYeGpSM0ZzQW1WdmY2M1Y0TDZsV0NyK0s1Zk9lNkE5akxlc1FpSUxM?=
 =?utf-8?B?MTRsK1VIcXA5THlEZW94TFJQV1Q0NlRFMFAxdEI5T2xhd0RMRDRKc29SQytJ?=
 =?utf-8?B?dEJONW9pa0RLaGdJWTJ4UExMaWVPV1Qrb3NmN2RrS3NOb2VGVDFxTDRVcWt1?=
 =?utf-8?B?UjhtaHJFUmI3eDNERzJmSE03U0p2N3VENXpCY1hwWCtBUmRwVUFNZFVyNHZQ?=
 =?utf-8?B?QjdlYkIvMmhPb2pyOTRSWEQ5QU9ZNVU0QnpvYmhNZGc5WGhGUGR2S0xTVE56?=
 =?utf-8?B?aTcvZU1IV0VZc0ZpNmFiZGpORmJDTmZEY2h0UWZoTnJzT0ZwT0lndU9Ya0dZ?=
 =?utf-8?B?UDRRMzJ1ZFZuQU9aVCtqazNGNlpiVlJoQ2VXcEZMZ0d4QWZCem5nZ05mQTNZ?=
 =?utf-8?B?QVpYcWYwMVk1MzhNNEdpNGJtZ2xVQy8wTldKNXMwTWI1eVJWVmh5U1czUUpq?=
 =?utf-8?B?amFHSE5KSTBzRE1ra2FrcjZDTUY0Vk9sbXNrOVFHUDlHMEZ4UWp1TmpSSkVk?=
 =?utf-8?B?VytJMGMweGoyWHJPcVhqZHlaZzl2NVczRENySGhaOWJBNEJvU2NSazRRaFNt?=
 =?utf-8?B?bDhPcmJYWWl5SXBUMDFkdlp3Rm9CUWtnUVlDaFdFeklOVFNiNWxPaVArM2t0?=
 =?utf-8?B?MDVqR0lFbExZMnpuNHVaVFM5endqMmxDOTJkcmwvMDE4Tmo3a3pNVmptYTBH?=
 =?utf-8?B?M1RHVTk1T3VwTGhQUVhWKzQyV0VWdzZUdnNWL09PcHVjc0sxNVFQUUsvSk4w?=
 =?utf-8?Q?PqQeQnQkhLW7F+UnU+lcTUE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C6A1DEF0AFF724791FE6F15ADBDCC5A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3b1adb-702b-4b9c-c975-08d9f63f79a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 20:11:13.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2A/NoPzPIhFcpLwcLPLL787QZtTg9l/xckJdD5/xqFb/+x0aKeQCM9evJx6MgQKEEaPCw4mtwMBSqcElj5rVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTIyIGF0IDA3OjUwIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMSBGZWIgMjAyMiwgYXQgMTg6MjAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gTW9uLCAyMDIyLTAyLTIxIGF0IDE2OjEwIC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjEgRmViIDIwMjIsIGF0IDE1OjU1LCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBXZSB3aWxsIGFsd2F5cyBuZWVkIHRoZSBh
YmlsaXR5IHRvIGN1dCBvdmVyIHRvIHVuY2FjaGVkDQo+ID4gPiA+IHJlYWRkaXIuDQo+ID4gPiAN
Cj4gPiA+IFllcy4NCj4gPiA+IA0KPiA+ID4gPiBJZiB0aGUgY29va2llIGlzIG5vIGxvbmdlciBy
ZXR1cm5lZCBieSB0aGUgc2VydmVyIGJlY2F1c2Ugb25lDQo+ID4gPiA+IG9yIG1vcmUNCj4gPiA+
ID4gZmlsZXMgd2VyZSBkZWxldGVkIHRoZW4gd2UgbmVlZCB0byByZXNvbHZlIHRoZSBzaXR1YXRp
b24NCj4gPiA+ID4gc29tZWhvdyAoSU9XOg0KPiA+ID4gPiB0aGUgJ3JtIConIGNhc2UpLiBUaGUg
bmV3IGFsZ29yaXRobSBfZG9lc18gaW1wcm92ZSBwZXJmb3JtYW5jZQ0KPiA+ID4gPiBvbiB0aG9z
ZQ0KPiA+ID4gPiBzaXR1YXRpb25zLCBiZWNhdXNlIGl0IG5vIGxvbmdlciByZXF1aXJlcyB1cyB0
byByZWFkIHRoZSBlbnRpcmUNCj4gPiA+ID4gZGlyZWN0b3J5IGJlZm9yZSBzd2l0Y2hpbmcgb3Zl
cjogd2UgdHJ5IDUgdGltZXMsIHRoZW4gZmFpbA0KPiA+ID4gPiBvdmVyLg0KPiA+ID4gDQo+ID4g
PiBZZXMsIHVzaW5nIHBlci1wYWdlIHZhbGlkYXRpb24gZG9lc24ndCByZW1vdmUgdGhlIG5lZWQg
Zm9yDQo+ID4gPiB1bmNhY2hlZA0KPiA+ID4gcmVhZGRpci7CoCBJdCBkb2VzIGFsbG93IGEgcmVh
ZGVyIHRvIHNpbXBseSByZXN1bWUgZmlsbGluZyB0aGUNCj4gPiA+IGNhY2hlIHdoZXJlDQo+ID4g
PiBpdCBsZWZ0IG9mZi7CoCBUaGVyZSdzIG5vIG5lZWQgdG8gdHJ5IDUgdGltZXMgYW5kIGZhaWwg
b3Zlci7CoCBBbmQNCj4gPiA+IHRoZXJlJ3MNCj4gPiA+IG5vIG5lZWQgdG8gbWFrZSBhIHRyYWRl
LW9mZiBhbmQgbWFrZSB0aGUgc2l0dWF0aW9uIHdvcnNlIGluDQo+ID4gPiBjZXJ0YWluDQo+ID4g
PiBzY2VuYXJpb3MuDQo+ID4gPiANCj4gPiA+IEkgdGhvdWdodCBJJ2QgcG9pbnQgdGhhdCBvdXQg
YW5kIG1ha2UgYW4gb2ZmZXIgdG8gcmUtc3VibWl0IGl0LsKgDQo+ID4gPiBBbnkNCj4gPiA+IGlu
dGVyZXN0Pw0KPiA+ID4gDQo+ID4gDQo+ID4gQXMgSSByZWNhbGwsIEkgaGFkIGNvbmNlcm5zIGFi
b3V0IHRoYXQgYXBwcm9hY2guIENhbiB5b3UgZXhwbGFpbg0KPiA+IGFnYWluDQo+ID4gaG93IGl0
IHdpbGwgd29yaz8NCj4gDQo+IEV2ZXJ5IHBhZ2Ugb2YgcmVhZGRpciByZXN1bHRzIGhhcyB0aGUg
ZGlyZWN0b3J5J3MgY2hhbmdlIGF0dHIgc3RvcmVkDQo+IG9uIHRoZQ0KPiBwYWdlLsKgIFRoYXQs
IGFsb25nIHdpdGggdGhlIHBhZ2UncyBpbmRleCBhbmQgdGhlIGZpcnN0IGNvb2tpZSBpcw0KPiBl
bm91Z2gNCj4gaW5mb3JtYXRpb24gdG8gZGV0ZXJtaW5lIGlmIHRoZSBwYWdlJ3MgZGF0YSBjYW4g
YmUgdXNlZCBieSBhbm90aGVyDQo+IHByb2Nlc3MuDQo+IA0KPiBXaGljaCBtZWFucyB0aGF0IHdo
ZW4gdGhlIHBhZ2VjYWNoZSBpcyBkcm9wcGVkLCBmaWxsZXJzIGRvbid0IGhhdmUgdG8NCj4gcmVz
dGFydA0KPiBmaWxsaW5nIHRoZSBjYWNoZSBhdCBwYWdlIGluZGV4IDAsIHRoZXkgY2FuIGNvbnRp
bnVlIHRvIGZpbGwgYXQNCj4gd2hhdGV2ZXINCj4gaW5kZXggdGhleSB3ZXJlIGF0IHByZXZpb3Vz
bHkuwqAgSWYgYW5vdGhlciBwcm9jZXNzIGZpbmRzIGEgcGFnZSB0aGF0DQo+IGRvZXNuJ3QNCj4g
bWF0Y2ggaXRzIHBhZ2UgaW5kZXgsIGNvb2tpZSwgYW5kIHRoZSBjdXJyZW50IGRpcmVjdG9yeSdz
IGNoYW5nZQ0KPiBhdHRyLCB0aGUNCj4gcGFnZSBpcyBkcm9wcGVkIGFuZCByZWZpbGxlZCBmcm9t
IHRoYXQgcHJvY2VzcycgaW5kZXhpbmcuDQo+IA0KPiA+IEEgZmV3IG9mIHRoZSBjb25jZXJucyBJ
IGhhdmUgcmV2b2x2ZSBhcm91bmQgdGVsbGRpcigpL3NlZWtkaXIoKS4gSWYNCj4gPiB0aGUNCj4g
PiBwbGF0Zm9ybSBpcyAzMi1iaXQsIHRoZW4gd2UgY2Fubm90IHVzZSBjb29raWVzIGFzIHRoZSB0
ZWxsZGlyKCkNCj4gPiBvdXRwdXQsDQo+ID4gYW5kIHNvIG91ciBvbmx5IG9wdGlvbiBpcyB0byB1
c2Ugb2Zmc2V0cyBpbnRvIHRoZSBwYWdlIGNhY2hlICh0aGlzDQo+ID4gaXMNCj4gPiB3aHkgdGhp
cyBwYXRjaCBjYXJ2ZXMgb3V0IGFuIGV4Y2VwdGlvbiBpZiBkZXNjLT5kaXJfY29va2llID09IDAp
Lg0KPiA+IEhvdw0KPiA+IHdvdWxkIHRoYXQgd29yayB3aXRoIHlvdSBzY2hlbWU/DQo+IA0KPiBG
b3IgMzItYml0IHNlZWtkaXIsIHBhZ2VzIGFyZSBmaWxsZWQgc3RhcnRpbmcgYXQgaW5kZXggMC7C
oCBUaGlzIGlzDQo+IHZlcnkNCj4gdW5saWtlbHkgdG8gbWF0Y2ggb3RoZXIgcmVhZGVycyAodW5s
ZXNzIHRoZXkgYWxzbyBkbyB0aGUgX3NhbWVfDQo+IHNlZWtkaXIpLg0KPiANCj4gPiBFdmVuIGlu
IHRoZSA2NC1iaXQgY2FzZSB3aGVyZSBhcmUgYWJsZSB0byB1c2UgY29va2llcyBmb3INCj4gPiB0
ZWxsZGlyKCkvc2Vla2RpcigpLCBob3cgZG8gd2UgZGV0ZXJtaW5lIGFuIGFwcHJvcHJpYXRlIHBh
Z2UgaW5kZXgNCj4gPiBhZnRlciBhIHNlZWtkaXIoKT8NCj4gDQo+IFdlIGRvbid0LsKgIEluc3Rl
YWQgd2Ugc3RhcnQgZmlsbGluZyBhdCBpbmRleCAwLsKgIEFnYWluLCB0aGUgcGFnZWNhY2hlDQo+
IHdpbGwNCj4gb25seSBiZSB1c2VmdWwgdG8gb3RoZXIgcHJvY2Vzc2VzIHRoYXQgaGF2ZSBkb25l
IHRoZSBzYW1lIGxsc2Vlay4NCj4gDQo+IFRoaXMgYXBwcm9hY2ggb3B0aW1pemVzIHRoZSBwYWdl
Y2FjaGUgZm9yIHByb2Nlc3NlcyB0aGF0IGFyZSBkb2luZw0KPiBzaW1pbGFyDQo+IHdvcmssIGFu
ZCBoYXMgdGhlIGFkZGVkIGJlbmVmaXQgb2Ygc2NhbGluZyB3ZWxsIGZvciBsYXJnZSBkaXJlY3Rv
cnkNCj4gbGlzdGluZ3MNCj4gdW5kZXIgbWVtb3J5IHByZXNzdXJlLsKgIEFsc28gYSBudW1iZXIg
b2YgY2xhc3NlcyBvZiBkaXJlY3RvcnkNCj4gbW9kaWZpY2F0aW9ucw0KPiAoc3VjaCBhcyByZW5h
bWVzLCBvciBpbnNlcnRpb25zL2RlbGV0aW9ucyBhdCBsb2NhdGlvbnMgYSByZWFkZXIgaGFzDQo+
IG1vdmVkDQo+IGJleW9uZCkgYXJlIG5vIGxvbmdlciBhIHJlYXNvbiB0byByZS1maWxsIHRoZSBw
YWdlY2FjaGUgZnJvbSBzY3JhdGNoLg0KPiANCg0KT0ssIHlvdSd2ZSBnb3QgbWUgbW9yZSBvciBs
ZXNzIHNvbGQgb24gaXQuDQoNCkknZCBzdGlsbCBsaWtlIHRvIGZpZ3VyZSBvdXQgaG93IHRvIGlt
cHJvdmUgdGhlIHBlcmZvcm1hbmNlIGZvciBzZWVrZGlyDQooc2luY2UgSSBkbyBoYXZlIGFuIGlu
dGVyZXN0IGluIHJlLWV4cG9ydGluZyBORlMpIGJ1dCBJJ3ZlIGJlZW4gcGxheWluZw0KYXJvdW5k
IHdpdGggYSBjb3VwbGUgb2YgcGF0Y2hlcyB0aGF0IGltcGxlbWVudCB5b3VyIGNvbmNlcHQgYW5k
IHRoZXkgZG8NCnNlZW0gdG8gd29yayB3ZWxsIGZvciB0aGUgY29tbW9uIGNhc2Ugb2YgYSBsaW5l
YXIgcmVhZCB0aHJvdWdoIHRoZQ0KZGlyZWN0b3J5Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
