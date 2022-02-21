Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17364BEE4C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Feb 2022 00:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiBUXV2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 18:21:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiBUXVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 18:21:16 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2104.outbound.protection.outlook.com [40.107.100.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FE25C7F
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 15:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjVrStunznp0romUTzGxMWn9ex8+e5db9BpMmdRGUlrj1VGWEJ3JWVI0aK3Br1KilmbKlN+VdLGD8+qhwq54BrcUoFlhHEXwY07lxFNT8x6M1h32riyCebzBjh2sB6JTiUvY/r7R4T/C7e91Ej+MEdbHbuiqZoiav98ZjQkn6Ku/Lqpp0eS+px57GYb4jSM92lCwHIAF7D1tyjV6TJACZph04xm+uPRNyut+Ial1O6zYR/9PD9j1bBazfVTgpBZrw8Zbbt747ShWg/FVR8NwaNwOjkSqpjM4CTQWZJDpC0Eyy7IvMCABxuKD0LDk+zWYVEGTTgWrJSQ9vLaPuKt1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffgvT/g+DGxhKqhPc0TZepfWAuFLEHefjQFU8MPGGh0=;
 b=ZtC6H+4Vzjohwu5iLBnGkmuIIrQOBWaqRvBkAcH7fm+IGA85pzZhel0IUgeWTtyh/ytp2BTvezJQekeun75MOv3/rgruV7E2XgFQqFvaFh7VoFX0bqoShzp3G+1ZFUHBtZPNbAPInzgjz51H/FeRrY0Bqpz1o6lZ3qHLQCNmmppgJ4G4UocXCbDEr+v29CFO9zDcz/X/3q8hsWzlx2XBbvLO/mqEn2Z/vsg/VVaxzO4iLjeAL8e5g2ZWXgFU8kXEqFi9QefINk1ceiHSCsQ8D/hoccyI274Q0SDZhKjGUDOBRI/0y9QjQ+GV93NKncvDucD071PUDgfYaln4jsn5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffgvT/g+DGxhKqhPc0TZepfWAuFLEHefjQFU8MPGGh0=;
 b=ZyfYJ/TGKjGulGWOSYwKKVsIaRYjqJ3gA+WPc0k2kb0u0UXT8tRv9Hof7yFd19l7oJRF8Lo2f22qFong2zztJmyeDkKglh+vFBsqOcdzO/uw5oNpmGEJvj2VGSbHVQe72YebridqU/Gz0C5EeeOk9sUOK2Z8HPMhqzVZ6AbJEHM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3162.namprd13.prod.outlook.com (2603:10b6:5:197::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 21 Feb
 2022 23:20:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.021; Mon, 21 Feb 2022
 23:20:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQCAAAazAIAACUeAgAAEHICAACQ5AA==
Date:   Mon, 21 Feb 2022 23:20:10 +0000
Message-ID: <79a2c935bd5b9044c216c90ebfac3dc2e8e6b888.camel@hammerspace.com>
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
In-Reply-To: <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daf6db38-f14b-4711-6956-08d9f590b487
x-ms-traffictypediagnostic: DM6PR13MB3162:EE_
x-microsoft-antispam-prvs: <DM6PR13MB31624C3A5DB23C6D5CEF6B2EB83A9@DM6PR13MB3162.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7aNSiSCdH5L4O6jxsfJE/GKiB2vbuL4VVaYEMy3VidLreSYqzy/c4AnQRTOqu9hKZUeIwkzvjQDOuw52dAzqMSLSeaoZe6IvcnAGqo8kGYS/NtYfy4eBgiWcDwZeRPvBAHhmKLjp2EiaZoZ8iAAqp28UHlyYXaFZoD74CjjGTyT3TqNgzO9RdlyqOytoQSQX/3wV6hvAiQItydAX+MImHhxzFNNcO+NxXVrOv3FjDr272CPzkJ+V+IuIX1+SM2ZZQuqIKDTRaqcYTyEqkT5CD4jSnELNDVM89NaCeZgk63ISZF00typszwq8/Ddds7dBwokkmfjkOicMfTUAURYJYgTTqMBEH53rFGtkaJdgUxgupxxlxPGooCi8R1U26Az9NSffsEENI5tu/OuV1STv2m8X77xMtPZGASHqSxyYB4NDpTrrl8mssEDNarIJTFrMWWacpPlJbFb35DSeREcGAyPPfhSSOMGrjNINmGOFfxa868f44s3aldXtbzwvuqrsFrm/rqXPlOplTiyPjQ7freSqLj0Lw2QTxfa5WAF7arzUFAthWqGSey2SLu2PYnuy8vGDAaSS2j1BbRC/qEUh3TsBQcgutVI1msZNUiDOVxkXO2P0K3LQqGHC6/nt1vYRG9tJZC4K0KbE5OfJXa8KmXC77BMr8anm/E1GtRvs0Sg9RVWY7xAXSkTq40k+2bKcw8Lf+/OLjKU8KjTScn2Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(2616005)(26005)(36756003)(53546011)(71200400001)(5660300002)(122000001)(6486002)(8676002)(508600001)(8936002)(4326008)(6916009)(316002)(38070700005)(66556008)(38100700002)(66446008)(76116006)(64756008)(66946007)(86362001)(2906002)(6512007)(6506007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzdyZzBJeTZGc0pUM3dqUzFsRVFFV29lNmUyQUNyVVU3NXh3MGluMlFtZ2Rk?=
 =?utf-8?B?T1lNaUVacDA4WkduR2xVWmMwMnBUcEZhbFBKRFZzSk54SjdWaVZNdFVvUGJK?=
 =?utf-8?B?Wkh1S3pkSEZCcHI2YjJKM3Y5RnZLR2FmcmdNeGh0MUsyNERRN1VRVHFMYnlB?=
 =?utf-8?B?K3N5cW1xTzBxQ1hjbVk4bVJUMVNadXVFWXc2eWZLT0JVTnV5VDE2RzhBQ0M1?=
 =?utf-8?B?ayt1RlFMZTd1Z0hBMEcwZnpRMEpmVGNkUGlZS0xSQ2Z2cENSWGErWjFGRlQz?=
 =?utf-8?B?MnJ4aHRyUjk5TEV6YkJ6M3lWL2xyOG9SSGVLczZVVk1ZTlU1dEtpeTdhaHFI?=
 =?utf-8?B?eVR4ODZBM0o5cGxqVjJCTUNORjlRQ2x0MVVRUld5dXhxbXJGNnZjOUdCQVFw?=
 =?utf-8?B?VnFERFNmZ1pWdGovSnNGbTRPOFd0dXVpRk1QTUhkNUtEWG53NnErdmExb0Fh?=
 =?utf-8?B?cTZSL2V0ZEdKSmRWYlI5SFZQYkg3dHRjSnk4SS91cnkwdWRrdGFCUkd5UlFG?=
 =?utf-8?B?MVRweW12ZWF4ZVZkRkd4TlF6eTNscXN2YkQzeWNHWndXa1lIbnRFcWZnZmJs?=
 =?utf-8?B?ZXB3azJ3N3lxeHJQYXpJdHJJNWdnSDdMQzl6QURpenlmcGhnb3FGOHdUQmlj?=
 =?utf-8?B?bm83R1ZGTHkyUWtMVDFabmNJYWMxWWh6VzVKeFFpT3JZZUhxTk04VG15REgv?=
 =?utf-8?B?d1gvK3JYcWdtdmlXbFZjdTU2QTY4NzFJMk8vY0FpUTFjWkFEbmJ5RVMzcmx6?=
 =?utf-8?B?ZUJHVy9HYUR5QVVOQmtJQzlGR2pRUmtoQlVyVFlwUEVqWE0vZEFtUDJiTGZZ?=
 =?utf-8?B?TEFzUUl5bjZ3NnlBMjc3S21KRmR1YUpEbWVOdG1GeVR2SW95KzF0c1NvSW9o?=
 =?utf-8?B?OVIxcXRxR0ZuTWpuM3VKYTJZeU9TRXVuOGZBZ001S0tNdmhGa09NcklZN3Iz?=
 =?utf-8?B?cHYyYnFCYTIwK0V5dEhHeFQ2d3RFcnJ0Q291YWVSZllTNjNucE8rSVBNb0Iy?=
 =?utf-8?B?eWJYUzIvNkd5c2hLeEJnS1ZkRXI5WHF4SGVMTklOUFhITDRSSkpOVElIZ3NO?=
 =?utf-8?B?ZlhtQjJ4S0dJVXk4ZGc3TjJLWGpSZjcvWHIxWjcweXVxZVRJaTcvbkFUTUJU?=
 =?utf-8?B?cm56MnVrWHNNWTVTUktidUFRQU5jTkRYZjEyZXdXK1hpMXNlSFdzeFlxUG10?=
 =?utf-8?B?eXlPQUdONEt1MlIwYXlpRVhXWUl1eVRGOC84SU9ydmhKVklZV3RRSUl3aFJa?=
 =?utf-8?B?UnFrK2h4THV4aWdmYUZQanMzYlNvU2toY21mYUZaYlBwZHd4YWJ0Y3pocGcz?=
 =?utf-8?B?QitVL1pZQkxBWXBwV3liWkcwRElVeG1vTlpPUm1zVEZEazJxZ1h3K3ovQkky?=
 =?utf-8?B?YTEzaVZlR2cxSmhNQ1RQbXo2OG5Kd3B4c2NiL29EdUg1dVNZTE51aGwzdkU4?=
 =?utf-8?B?THNUVGtqUFF1ZmhJMkd3YUJnYXZhQWZMUVRnaXQzRHZITDRJUUFWZitONGFn?=
 =?utf-8?B?ckdPK01TUWNKbGNreStkK1NmNjFNdW1qOVNwZWRjK2EyZ2E4eWRNL3dUdldi?=
 =?utf-8?B?T2dwVHVZdGpHOXo4RWx3RUhReXpmR21uUDQ2T3dQcTdEQ0VGTC9rZSsyREFy?=
 =?utf-8?B?elF1UTZvMTI0QlpVVzVzZW1RZTAyRkZwUGk2QjFpSXFFSlNMTzhYK2JHRHky?=
 =?utf-8?B?YTZ1NlpobUpKVnJTSnYyRGRuK1hSSmRKRjFEenFUSCtyWVhod0RPZkpEMlk4?=
 =?utf-8?B?WmF5MllqZGM5OU1Lbi9pRVhtSGE5UFlxVWYvbGt0TmNoMEVrQWV6ajBEZmJx?=
 =?utf-8?B?YUQwRDhQS1ROVWNkdzVKbldwZUN3MGY3R0FBR1NDSVVuay9BeGlLSUFNL2dT?=
 =?utf-8?B?cUNOVGQ4ampvZDllOWlKenhtZDMwTzdRSXhJaFk2NnpsamVyMlF4RWhVOFJL?=
 =?utf-8?B?SEhmSVo5djgxM1pic0JxSkoxZEp2Ny9MRWpWZU4vblpZOXdzQzZGa0IwVEw3?=
 =?utf-8?B?cmFKM3dNdHdiMVNPRnFFQ0VsejR2TUdXQlFNd3FnczNqVUpxekZwNzJVSWJt?=
 =?utf-8?B?RFoyQTkwS0xNbGlpa3BXeGVKRUkzcnQyZk9nakg4ZGNQbUVFWDZ4eVFocFFH?=
 =?utf-8?B?RzlzOUEwVkN0dGlEeDdZY0JpWkdLNHNyTzVuNVV5dHE5ZzJHTFRXcklEWHlw?=
 =?utf-8?Q?/n9D0ABz26lU9ke6ark30G0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A17733048B0D5C40A07B36FFE939F4C8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf6db38-f14b-4711-6956-08d9f590b487
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 23:20:10.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWxXuCppkYfOffALoAfUEX9P9cg/wch4GrdyKD++3YuBEh73NObP0QodCetFyTsNA1lu5cC6ZtCKJS9u/6hlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTIxIGF0IDE2OjEwIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMSBGZWIgMjAyMiwgYXQgMTU6NTUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiANCj4gPiBXZSB3aWxsIGFsd2F5cyBuZWVkIHRoZSBhYmlsaXR5IHRvIGN1dCBvdmVyIHRv
IHVuY2FjaGVkIHJlYWRkaXIuDQo+IA0KPiBZZXMuDQo+IA0KPiA+IElmIHRoZSBjb29raWUgaXMg
bm8gbG9uZ2VyIHJldHVybmVkIGJ5IHRoZSBzZXJ2ZXIgYmVjYXVzZSBvbmUgb3INCj4gPiBtb3Jl
DQo+ID4gZmlsZXMgd2VyZSBkZWxldGVkIHRoZW4gd2UgbmVlZCB0byByZXNvbHZlIHRoZSBzaXR1
YXRpb24gc29tZWhvdw0KPiA+IChJT1c6DQo+ID4gdGhlICdybSAqJyBjYXNlKS4gVGhlIG5ldyBh
bGdvcml0aG0gX2RvZXNfIGltcHJvdmUgcGVyZm9ybWFuY2Ugb24NCj4gPiB0aG9zZQ0KPiA+IHNp
dHVhdGlvbnMsIGJlY2F1c2UgaXQgbm8gbG9uZ2VyIHJlcXVpcmVzIHVzIHRvIHJlYWQgdGhlIGVu
dGlyZQ0KPiA+IGRpcmVjdG9yeSBiZWZvcmUgc3dpdGNoaW5nIG92ZXI6IHdlIHRyeSA1IHRpbWVz
LCB0aGVuIGZhaWwgb3Zlci4NCj4gDQo+IFllcywgdXNpbmcgcGVyLXBhZ2UgdmFsaWRhdGlvbiBk
b2Vzbid0IHJlbW92ZSB0aGUgbmVlZCBmb3IgdW5jYWNoZWQNCj4gcmVhZGRpci4NCj4gSXQgZG9l
cyBhbGxvdyBhIHJlYWRlciB0byBzaW1wbHkgcmVzdW1lIGZpbGxpbmcgdGhlIGNhY2hlIHdoZXJl
IGl0DQo+IGxlZnQNCj4gb2ZmLsKgIFRoZXJlJ3Mgbm8gbmVlZCB0byB0cnkgNSB0aW1lcyBhbmQg
ZmFpbCBvdmVyLsKgIEFuZCB0aGVyZSdzIG5vDQo+IG5lZWQgdG8NCj4gbWFrZSBhIHRyYWRlLW9m
ZiBhbmQgbWFrZSB0aGUgc2l0dWF0aW9uIHdvcnNlIGluIGNlcnRhaW4gc2NlbmFyaW9zLg0KPiAN
Cj4gSSB0aG91Z2h0IEknZCBwb2ludCB0aGF0IG91dCBhbmQgbWFrZSBhbiBvZmZlciB0byByZS1z
dWJtaXQgaXQuwqAgQW55DQo+IGludGVyZXN0Pw0KPiANCg0KQXMgSSByZWNhbGwsIEkgaGFkIGNv
bmNlcm5zIGFib3V0IHRoYXQgYXBwcm9hY2guIENhbiB5b3UgZXhwbGFpbiBhZ2Fpbg0KaG93IGl0
IHdpbGwgd29yaz8NCg0KQSBmZXcgb2YgdGhlIGNvbmNlcm5zIEkgaGF2ZSByZXZvbHZlIGFyb3Vu
ZCB0ZWxsZGlyKCkvc2Vla2RpcigpLiBJZiB0aGUNCnBsYXRmb3JtIGlzIDMyLWJpdCwgdGhlbiB3
ZSBjYW5ub3QgdXNlIGNvb2tpZXMgYXMgdGhlIHRlbGxkaXIoKSBvdXRwdXQsDQphbmQgc28gb3Vy
IG9ubHkgb3B0aW9uIGlzIHRvIHVzZSBvZmZzZXRzIGludG8gdGhlIHBhZ2UgY2FjaGUgKHRoaXMg
aXMNCndoeSB0aGlzIHBhdGNoIGNhcnZlcyBvdXQgYW4gZXhjZXB0aW9uIGlmIGRlc2MtPmRpcl9j
b29raWUgPT0gMCkuIEhvdw0Kd291bGQgdGhhdCB3b3JrIHdpdGggeW91IHNjaGVtZT8NCkV2ZW4g
aW4gdGhlIDY0LWJpdCBjYXNlIHdoZXJlIGFyZSBhYmxlIHRvIHVzZSBjb29raWVzIGZvcg0KdGVs
bGRpcigpL3NlZWtkaXIoKSwgaG93IGRvIHdlIGRldGVybWluZSBhbiBhcHByb3ByaWF0ZSBwYWdl
IGluZGV4DQphZnRlciBhIHNlZWtkaXIoKT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
