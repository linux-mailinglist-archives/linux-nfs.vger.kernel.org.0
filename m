Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537DE788F62
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjHYTui (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHYTuM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 15:50:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2097.outbound.protection.outlook.com [40.107.212.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDD26A6
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 12:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHpGjnRKAlSdsou3kEGzgaT9mFYO+HmJZqyQajfbVeaa1X25v1KFdtuzFhFMa2TmmXiEnpTqSKl9MY0NU5V6hrOAL4eMhaWZgnyJTbdJf2b1aVQtnZtMGQ5iEtQfC3MNw5M7E7gv2c6OsRRhz8K5ReygmE3ERfDqYcM1f8Ueno0MAGcwXTJl89ANy+Kw3+nkZ+0JF2JJ++8UtBlRGM+tEqGCxaGyhpTfs+ADpyldlaiSWEW5fK8/cLQm3fTigK7UwbCvBD4Gau29WsyT+404IA05ZjKRnC0IiLiwu1dGkXHjNwDQQF2+scf+1traI9rYG0VD6aGDTn3PmBl2lsMtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISn7b4Ocmr57cHv+GA+cVHbG+uKUPjahZ1zktum64uY=;
 b=YBSWh57LXtkFq3SSa60qc8lp1AR3LXCEveLY9VJFzitcOlY+MfbnB6nlTLYQHioX9M1JEs7v8KxoqebvppDfqlREBTydCwd9wZ8q5zuDrb3WLXfU7TPdral3vVzFwNyCk3pC2Bwr8cFWNTMCRLOoghtjVRBZbLAB/NAnwxJNGnyHWy7Skay3v07XxjpyZ+P4orY2c5JuCCIMCVnOJYLXp18gPvWoGwSN+ILDFNpF7sIegux1AhJV8L+2ocw6abzckJKRtX6Fr3B2430deiHmSrMyXC1V0lclJ9n1hB97WBcaV8JqXTL3Ia3YXQFzmqhRa33s6ASCcC1up9y+FTLaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISn7b4Ocmr57cHv+GA+cVHbG+uKUPjahZ1zktum64uY=;
 b=Z3ra1YXt+5iRtjpl8JlUJaSs0ojhxhKIFNAEJ/hZINJzow5DFLd47HP3EwQMVlbvdoRKmvpjdbJzpItSd2sEeYB4ZmTLPvTnHbEE0IyWklAOW0MUeJrVTEE2jStJ0ta3XnaKNqKlvk8c4uEOBZEbsLMp+M4Yx9MWnhCXqG+JesU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5619.namprd13.prod.outlook.com (2603:10b6:510:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:49:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 19:49:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cattelan@thebarn.com" <cattelan@thebarn.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Topic: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Index: AQHZ1hDQ1xwLiwfK/kC2UFfMPJTnDq/7Mc0AgAA8mQA=
Date:   Fri, 25 Aug 2023 19:49:34 +0000
Message-ID: <cb402253376f2939761169acce1b730bae0e9628.camel@hammerspace.com>
References: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
         <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
In-Reply-To: <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB5619:EE_
x-ms-office365-filtering-correlation-id: e0882c9b-4425-48df-09bf-08dba5a4685e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0ALx9SCtKCTuhhATnWPmC4A3wVd5q2CyWlkFpG/pAcxEJsE7vKTxMswcOAwI2zLyMAz0JwxJnYqYyYEmQLu+nYR0OHOswFQhtpzy2ucqf9InEXNGLvR/sLBpL1LcuYWm2N/bOEN4BoCGsX4T79tFwXzKzb/A1iRMnFbW+2VPYuUTH8pbbPfj+8Q9Em8o8UASyR9TquFlqZZ70386U3PhxcWEUl4oHANC4g7a3l3J3lBkyis/ttaNok2NlGwmkN140n/PZOWwDbMpphPo7tr9jI98A5V2Nud351mbS9T6niQ06t3duY042VL8ZAoUSLigr3nO+X01qGqZM/NCdAoIkbVxyAGoPosba+j3hZf/CX+OmlX4XXnvduBXrKCKcMMNy/zwFZBeQ5KLOGAbOp5eUWXuD4ws4l2U3NayWAF6ho9aR8aAi+G+C6u8qaK6l5Fhm2w/ktnxBz3tJYFFAvdRx8XJ5K2a6GQGhUtSzxJ1EV09dlRXB1rq0qgwA4Buuw7PHmITKhfB8TBv/ehw2gBOcClgYFF1Ai3G1ixz7srQ+3+BMkBNznBUZAs3QHJoImoy+oz7YOFuyOu9JGUQQhMIiBL6pMHxPxTT+Gzob5mQjUBx7kTdaUXUJQX+4SlrxcuyNdpplyD+cV5JQivDNXSs1zKa1rysT46fY32yUWijEv4yHvf7a2eDHNxld1N83KkLgkL72Q0p/0YHPjyqRfO4UUx5chxpvilzMOPOe7yM30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(66946007)(76116006)(66556008)(66446008)(66476007)(66899024)(110136005)(26005)(2616005)(86362001)(71200400001)(478600001)(966005)(6486002)(6506007)(36756003)(6512007)(38070700005)(38100700002)(122000001)(83380400001)(12101799020)(8936002)(8676002)(5660300002)(316002)(2906002)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTB1Z2dYazVJSWNIRVRiVWloeWwzUVYzUjRNS3NFTjlQMTJaTUhDNHRpZ2NM?=
 =?utf-8?B?eFBqejVjVEFGb2UzcFFHQWYzYUlzejNyNVlqRmNVQ0p3VEJ0UEFFTTJVWEw1?=
 =?utf-8?B?R3ZGSW8zdCt0NFF2eloyNi83Y2NVdi9NMHUxOWxLVER1RW4rUExIVnFYbCtx?=
 =?utf-8?B?WGZua2E1MFg4UCtTTGtVZ0l2SlFKdkhWcVovWXNqY0UwZWhQcjNleElPSnYx?=
 =?utf-8?B?SzNOMlNMcElpQjhvYzFZMmV5R2tCeS84d2lzNXBjVFJqYXdzNFV5Y3ZJZXpH?=
 =?utf-8?B?RzMrNmRSYTEwZlU0TFdtMTIvMFdEeDBkdHhJU1BXVjNrT3ByQ0xuOFNycmUr?=
 =?utf-8?B?VUxBblpYeGxrS0ZZdmRlalBQWjYwdkZZcmg3K1hCVkZMWEkzb2dHWS9TYyt5?=
 =?utf-8?B?SXhMKzdwclcwbGtieHVDQ2hRRExZRGw1cGRxKzhJMlMyODlwQjhDb0xkcDNE?=
 =?utf-8?B?TEpJWWxjaVpaMlZqZnYxS0Mzb2hYTE9xakpibGlzSzRZbXVHQWFFY0RiWERR?=
 =?utf-8?B?RHp1TUJLR2pkYm1wWnBrMGRsOUpVK3BSMm4zLzk2T1lFVlpBZ2VrbGszQVBB?=
 =?utf-8?B?QkFqbThNaG0vK2ZaREZFd1Fpcms5aHdld05xNFpJVDIyd0tEYUVYTFB5M09L?=
 =?utf-8?B?eUtIcHc2QUQ4R2djSzNWaHR4T21MZm04QnR3TkdVcGVxMENXUEFsSk1TZ2d6?=
 =?utf-8?B?emQvRUJDQTdPMGVQcEEzM203Y1pva3VyL05mQi9hYTQ4QmxVT29mZGR2bXlW?=
 =?utf-8?B?U2o3cGNjUUJ1Z3lyb0NrdVZFS2gwclhFNTRNNytHZ2tONjR4U2RHc21iYk9F?=
 =?utf-8?B?STBUMnYwNzV3Um1XRmNMRUhtb3JmenRpU3o0ZUNmLzBXTzZKUk4rejg1WVJs?=
 =?utf-8?B?N2FKUUNXK0dlTjMvVnJRNTEyMldWejBzL3VTUEtQMm41YmJCbmtFRmpaUWNp?=
 =?utf-8?B?MUxoS21PZnNrdHJiSHBFWW5SUk5Sa29hVUJlTEVDeGJiNUpzdTBPOVI4SmM2?=
 =?utf-8?B?REVSQzQzY3Y1NW9pTTF5WllyWXNKMytzMXRBQ0ZIdGdkRFlXeE5ubGhGM0dP?=
 =?utf-8?B?aDdlamlNeHZDNU94T2hJSTh6M2NJN0Uzc1plRm92aVQxZjV0RlJ5dm9pZVJy?=
 =?utf-8?B?dU85bzdSR1l6Z3c5VlRSMUtXZjNMN0xESytOV3NRSnRvK1VGMHljdnUrVjlQ?=
 =?utf-8?B?V1dHMEpsWEh5YUtrakZHNDYyNVBQMlVLTjh5LzZpQzBla2tiMTh3dnRlMXZ0?=
 =?utf-8?B?aCtqUURPb2d6OU9IVWEvN1pWYjByQkMwNHhxQjhUYVR0YVdnNjJ1NHdsaWtI?=
 =?utf-8?B?UktST1BYK2tEcTNrQ2g4SW1YS1NOdlp2Mnk3SS9zYWw4NzhaVXFxazhqbEQ2?=
 =?utf-8?B?ajdyY1pRNXRkYlVBYU56Vi84UjBKNVNMTlhjaUYxUSsyR2FZaVJSSG5JaFU5?=
 =?utf-8?B?TnIxcHMvTmtZOHA2RzhXWS9QYVdmSmE1NUlKckkvNURoR0g0VUxyamVpcmdH?=
 =?utf-8?B?dy9Wc29zZkttN09hN01IdWxtcXFIOGo3MVBxcSsxU3BzMXJFMXBxVy9RRStH?=
 =?utf-8?B?b2IvSC93R1NmRXFHaHdCQU8vYTVEN2dJOFZ4MkJPTm40V3daWVhvT2lSN1dZ?=
 =?utf-8?B?MVM1cDdKQ0pFTnUrY1I1UEV1Zlh3SVdkakN0clJyQzVnK3ExVmlIVzkwM2d5?=
 =?utf-8?B?QXFFWTVHRnM4N2c5MytrRDYvSXM1VE1acVYyTmsya1MrZnljUW9EWXVrNmFz?=
 =?utf-8?B?VmxkbkpTYllJbjU2SzVTVVpVaGpJUEV0Vjg3OWs3OG9ocVBnZGJ0ZExOUkJB?=
 =?utf-8?B?cXJLWkxUejRLWVpYNSt0TGhWRkl6ZTZpT1lwcWsreEU4eExESWlBcUVZZVEy?=
 =?utf-8?B?MzNYNjdYZmFMUUpITWZIZ0RENFFPMWpkeEFXdlpKeFB2MHAwa0JPQWdJWWlT?=
 =?utf-8?B?TGxaVndKZDVURVZGTDVJajc0WGF0K1U2YWkzRkNtRzBaOGdSMWNFblU3Z1Y3?=
 =?utf-8?B?SXMwcTlXVHkvWHY1ZVg1RGVwR2dFSWNrcXowQ2NBNTVRR0ZaaVBZZUZvK1Fn?=
 =?utf-8?B?NWVnUUVvbzdWWHJlWXZodjJCY3hJQmJya00vbEZVTEFuS2JiN2czSkJNY3hT?=
 =?utf-8?B?VWhqaXpEb3oyT2NzTTQrdXgvcm5QM3JnRVd0N1lvTHJabTM3ekdBOVZEakNE?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF69EA4527751A46B1656D2D24AAB302@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0882c9b-4425-48df-09bf-08dba5a4685e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 19:49:34.6799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYeBvpoj+uw56fJbfv1Zvqs9SLZ8f+dbqSIEawzOGsC18JeUov8pC12y8+iDLPRmUB6QqAvCbatQWQw/RjwGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDExOjEyIC0wNTAwLCBSdXNzZWxsIENhdHRlbGFuIHdyb3Rl
Og0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGNhdHRlbGFuQHRoZWJhcm4uY29t
LiBMZWFybiB3aHkgdGhpcw0KPiBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiA+ID4gSGksIHRoZXJlIQ0KPiA+ID4g
DQo+ID4gPiBXZSBoYXZlIHNvbWUgc2hhcmVzIHRoYXQgdXNlIE5GU3YzIHdpdGggVENQIGFuZCBL
ZXJiZXJvcyBhbmQgaGF2ZQ0KPiA+ID4gYmVlbg0KPiA+ID4gaGl0dGluZyBhbiBpbnRyaWd1aW5n
IGlzc3VlIHdpdGggdGhvc2UuIFdlIGhhdmUgbm90aWNlZCB0aGF0DQo+ID4gPiBuZXR3b3JrDQo+
ID4gPiBpbnN0YWJpbGl0aWVzIGhhdmUgYmVlbiBjYXVzaW5nIHNvbWUgJ1Blcm1pc3Npb24gZGVu
aWVkJyBlcnJvcnMNCj4gPiA+IG9uDQo+ID4gPiBmaWxlcy4NCj4gPiA+IA0KPiA+ID4gVGhlIGN1
cnJlbnQgc2NlbmFyaW8gd2UgaGF2ZSBpcyBiYXNlZCBvbiBORlN2MyBvdmVyIFRDUCBjbGllbnRz
LA0KPiA+ID4gY29uZmlndXJlZCB3aXRoIEtlcmJlcm9zIChrcmI1cCkgYXV0aGVudGljYXRpb24g
YWdhaW5zdCBhIE5ldEFwcA0KPiA+ID4gTkZTDQo+ID4gPiBTZXJ2ZXIgKE9OVEFQKS7CoCBUaGlz
IGlzIGhhcHBlbmluZyByZWdhcmRsZXNzIG9mIHRoZSBLZXJuZWwgd2UNCj4gPiA+IHVzZQ0KPiA+
ID4gKG91ciBtYWluIHRlc3RzIGJlYXIgNC4xNSBhbmQgNS4xNSBnZW5lcmljIFVidW50dSBLZXJu
ZWxzIC0gZnJvbQ0KPiA+ID4gQmlvbmljIGFuZCBKYW1teSksIGFuZCB3ZSBoYXZlIG5vdCBmb3Vu
ZCBhbnkgaW50ZXJlc3RpbmcgY29tbWl0cw0KPiA+ID4gaW4NCj4gPiA+IGVpdGhlciBjb21wb25l
bnRzIHVwc3RyZWFtIHRoYXQgd291bGQgY2hhbmdlIHRoZSBiZWhhdmlvdXIgaW4NCj4gPiA+IGhh
bmQuDQo+ID4gPiANCj4gPiA+IFdlIHRyYWNrZWQgdGhvc2UgaXNzdWVzIGRvd24gYW5kIGZvdW5k
IG91dCB0aGF0IHRoZSAnUGVybWlzc2lvbg0KPiA+ID4gZGVuaWVkJyBoYXBwZW5zIGJlY2F1c2Ug
b3VyIHBhY2tldHMgYXJlIGZhaWxpbmcgdGhlIEdTUyBjaGVja3N1bS4NCj4gPiA+IFdlIGtlcHQg
aW52ZXN0aWdhdGluZyBhbmQgZGlzY292ZXJlZCwgYWZ0ZXIgc29tZSB0Y3BkdW1wLCB0aGF0DQo+
ID4gPiB0aGlzDQo+ID4gPiBoYXBwZW5zIGJlY2F1c2UgdGhlIGNsaWVudCByZXRyYW5zbWl0cyBS
UEMgcGFja2V0cywgd2hpY2gNCj4gPiA+IGluY3JlYXNlcw0KPiA+ID4gdGhlIEdTUyBzZXF1ZW5j
ZSBudW1iZXIuIE1lYW53aGlsZSwgdGhlIHJlc3BvbnNlIHRvIHRoZSBvcmlnaW5hbA0KPiA+ID4g
cGFja2V0IGdldHMgcmVjZWl2ZWQsIGJ1dCB0aGUgY2hlY2tzdW0gZmFpbHMgYmVjYXVzZSB0aGUg
Y2xpZW50DQo+ID4gPiBpcw0KPiA+ID4gZXhwZWN0aW5nIGEgZGlmZmVyZW50IEdTUyBzZXF1ZW5j
ZSBudW1iZXIuDQo+ID4gPiANCj4gPiA+IFRoaXMgY2FuIGJlIGF2b2lkZWQgd2l0aCBORlN2NCBi
ZWNhdXNlIHRoZSBSUEMgY2xpZW50IGlzIGNyZWF0ZWQNCj4gPiA+IHdpdGgNCj4gPiA+IGEgIm5v
IHJldHJhbnMgdGltZW91dCIgZmxhZy4gU3VjaCBhIGZsYWcgaXMgbm90IHNldCBhbmQgaXMNCj4g
PiA+IGltcG9zc2libGUgdG8gc2V0IG9uIE5GU3YzLiBXZSBkaWQgc29tZSBpbnZlc3RpZ2F0aW9u
IGFuZCB0aG91Z2h0DQo+ID4gPiB0aGF0DQo+ID4gPiBzZXR0aW5nIHRoaXMgZmxhZyB3b3VsZCBm
aXggb3VyIHByb2JsZW1zIHdpdGhvdXQgdGhlIG5lZWQgdG8gbW92ZQ0KPiA+ID4gdG8NCj4gPiA+
IE5GU3Y0Lg0KPiA+ID4gDQo+ID4gPiBPdXIgcXVlc3Rpb24gaXM6IGlzIHRoZXJlIGEgcmVhc29u
IHRoaXMgZmxhZyBpcyBub3QgYmVpbmcgc2V0IG5vcg0KPiA+ID4gaXMNCj4gPiA+IGl0IHBvc3Np
YmxlIHRvIHNldCBpdCBmb3IgTkZTdjM/IElzIHRoZXJlIHNvbWV0aGluZyBvbiBORlN2MyB0aGF0
DQo+ID4gPiBkZW1hbmRzIFJQQyByZXRyYW5zbWlzc2lvbnMgZXZlbiB3aXRoIFRDUD/CoCBPbmUg
ImhpbnQiIHdlIGhhdmUNCj4gPiA+IGNvbWUNCj4gPiA+IGFjcm9zcyBpcyB0aGF0IGl0IGlzICpl
eHBsaWNpdGx5IG1lbnRpb25lZCogaW4gTkZTdjQncyBSRkMsIGFuZA0KPiA+ID4gdGhlcmUgaXMg
bm90aGluZyBpbiBORlN2MyBhdCBhbGwgLSBtb3N0IGxpa2VseSBkdWUgdG8gdGhlIGZhY3QNCj4g
PiA+IHdlJ3JlDQo+ID4gPiBkZWFsaW5nIHdpdGggYSBzdGF0ZWxlc3MgcHJvdG9jb2wuDQo+ID4g
PiANCj4gPiA+IEFueSBjb21tZW50cyB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkIGhlcmUh
DQo+ID4gPiANCj4gPiA+IFRoYW5rIHlvdSwNCj4gPiA+IA0KPiA+ID4gWzFdDQo+ID4gPiBodHRw
czovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi92NS4xNS9uZXQvc3VucnBjL2F1dGhf
Z3NzL2dzc19rcmI1X3Vuc2VhbC5jI0wxOTQNCj4gPiA+IFsyXQ0KPiA+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjUuMTUvZnMvbmZzL2NsaWVudC5jI0w1MjENCj4g
PiA+IFszXSBodHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzc1MzAjc2Vj
dGlvbi0zLjEuMQ0KPiA+IA0KPiA+IE5GU3YzIHNlcnZlcnMgYXJlIGFsbG93ZWQgdG8gZHJvcCBy
ZXF1ZXN0cywgYW5kIE5GU3YzIGNsaWVudHMgYXJlDQo+ID4gZXhwZWN0ZWQgdG8gcmV0cmFuc21p
dCB0aGVtIHdoZW4gdGhpcyBoYXBwZW5zLiBORlN2NCBzZXJ2ZXJzIG1heQ0KPiA+IG5vdA0KPiA+
IGRyb3AgcmVxdWVzdHMsIGFuZCBORlN2NCBjbGllbnRzIGFyZSBleHBlY3RlZCBuZXZlciB0byBy
ZXRyYW5zbWl0DQo+ID4gKHVubGVzcyB0aGUgY29ubmVjdGlvbiBicmVha3MpLiBGb3IgdGhhdCBy
ZWFzb24gd2UgZG8gc2V0DQo+ID4gUlBDX1RBU0tfTk9fUkVUUkFOU19USU1FT1VUIG9uIE5GU3Y0
IGFuZCBkbyBub3Qgb24gTkZTdjMuDQo+ID4gDQo+IFdlIGhhdmUgYmVlbiBkb2luZyBhIGJ1bmNo
IG9mIGRlYnVnZ2luZyBvbiB0aGlzIGlzc3VlIGFuZCB0aGUga2V5DQo+IHBvaW50IC8gcHJvYmxl
bSB3ZSBhcmUNCj4gcnVubmluZyBpbnRvIGlzIHRoYXQgYmVjYXVzZSB0aGlzIGlzIGEga2VyYmVy
b3MgZW5hYmxlZCBtb3VudCB3aGVuDQo+IHRoZSBjbGllbnQgZG9lcyBhDQo+IHJlLXRyYW5zbWl0
IGl0IGVuZHMgdXAgZ2VuZXJhdGluZyBhIG5ldyBNSUMgaGVhZGVyIC8gY2hlY2tzdW0gc2luY2UN
Cj4gdGhlIGtyYjUgY29udGV4dA0KPiBzZXF1ZW5jZSBudW1iZXIgaGFzIG1vdmVkIG9uLg0KPiAN
Cj4gSWYgdGhhdCByZXRyYW5zIGhhcHBlbnMgYmVmb3JlIHRoZSBvcmlnaW5hbCByZXNwb25zZSBp
cyByZWNlaXZlZCB0aGVuDQo+IHRoZSBtaWMgdmVyaWZpY2F0aW9uDQo+IGZhaWxzIHNpbmNlIHRo
ZSBjbGllbnQgaXMgbm93IGV4cGVjdGluZyBhIHJlc3BvbnNlIHRvIHRoZSBzZWNvbmQNCj4gcGFj
a2V0IGFuZCBub3QgdGhlIGZpcnN0Lg0KPiBtaWMgaGVhZGVyIHZlcmlmaWNhdGlvbiBmYWlscyB3
aGljaCB0aGVuIHJlc3VsdHMgaW4gYW4gRUFDQ0VTIGVycm9yDQo+IHdoaWNoIGVuZHMgdXAgYXMg
YW4gSU8NCj4gZXJyb3IgYXQgdGhlIGFwcGxpY2F0aW9uLg0KPiANCj4gV2hhdCB3ZSBoYXZlIGZv
dW5kIHRoYXQgaXMgaXQgZWFzeSB0byByZXBybyBpbiBvdXIgZW52aXJvbm1lbnQgYWRkaW5nDQo+
IGFuIGlwdGFibGVzDQo+IHJ1bGUgdG8gZHJvcCByZXNwb25zZXMgZnJvbSB0aGUgbmZzIHNlcnZl
ciBmb3IgNTUtNjMgc2Vjb25kcy4NCj4gTGVzcyB0aGFuIDU1IHNlYyBhbmQgdGhlIHJldHJhbnMg
ZG9lcyBub3QgaGFwcGVuIHRoaW5ncyByZWNvdmVyDQo+IE1vcmUgdGhhbiA2MyBzZWMgYW5kIHRo
ZSBycGMgY29kZSBnb2VzIGRvd24gdGhlIHJlY29ubmVjdCBwYXRoIGJlZm9yZQ0KPiBkb2luZyB0
aGUgcmV0cmFucyBhbmQNCj4gdGhpbmdzIHJlY292ZXIuDQo+IA0KPiBJdCBzZWVtcyBsaWtlIGtl
cmJlcm9zIGVuYWJsZWQgbW91bnRzIHNob3VsZCBiZSB1c2luZw0KPiBSUENfVEFTS19OT19SRVRS
QU5TX1RJTUVPVVQgc2luY2UgZG9pbmcNCj4gYSByZXRyYW5zIGNoYW5nZXMgdGhlIEdTUyBjaGVj
a3N1bSBmcm9tIHRoZSBvcmlnaW5hbCBjaGVja3N1bS4NCj4gDQoNCk5vLCB0aGF0IGlzIG5vdCBh
biBvcHRpb24uIE5GU3YzIHNlcnZlcnMgYXJlIGFsbG93ZWQgdG8gZHJvcCBhbnkNCmluY29taW5n
IFJQQyByZXF1ZXN0IHdpdGhvdXQgbmVlZGluZyBhIHJlYXNvbiwgc28gdHVybmluZyBvbg0KUlBD
X1RBU0tfTk9fUkVUUkFOU19USU1FT1VUIHdvdWxkIGp1c3QgbGVhZCB0byBjbGllbnQgaGFuZ3Mu
DQoNClRoZSByaWdodCB0aGluZyB0byBkbyBpcyB0byBqdXN0IGZpeCB1cCBycGNfZGVjb2RlX2hl
YWRlcigpIHRvIHJldHJ5DQppbnN0ZWFkIG9mIGZpcmluZyBvZmYgYW4gZXJyb3IgaW4gdGhpcyBj
YXNlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
