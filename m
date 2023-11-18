Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D37F013A
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKRQtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 11:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQtT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 11:49:19 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2111.outbound.protection.outlook.com [40.107.96.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195BFE5
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 08:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+o9x7tZprQjh7hS5b9D0mSrzjFSJrhJqJhOnuz5C9ArRqhaAuEFv9jw5eIfr3DdTNAnxpba6YNtCs9eKEOYY1O6Bh1kcn/W5oGz8VG/q1gpLQenuEYp1LFwI7g1/cmwBL9OsxFfeFUhIXZd9kpImc6JZDWGkHXq3wTEE47fSnhHRn7eLdbLVTBoMIU+UqN4zcAfWFfdGMz6+D2oVOvVaXnNMGrZPI2dL+bQSQ75PVsL2LCBQJ+JSpZYdOCkUKibAs40SjNKiGnuZyItihc+gvwuVcuJpnhhvwNHbZQ3TvlQB9P59tT7MFVOHWmjCv32uqyYvXOf04DOQG10An8CoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKVAoW+dXtDSizUVzTGIoYfEJyySahtKF65jCm2bsV4=;
 b=di4Ug9J1FGc4YQ6jriVYpEFtD7EOSwRduyY1AlMJR1qnjVSUFBlG0s2NUngaX1RqQ3PjSx8tap9NG8Scv+KXQW7OIJhPaPA4DszdPOB36LJiJCtxLVXZVIYoZ91EZmopPW84bTEtzDso3NnV1uOtex2xu2UtkdJiI2JcoPeaM1Wt4hlhhzBHfUYQDJfdcfe1wVemBWZ0P4jCYkT3kH0VMr9boLa/pqAydBJZAf+l1cB8o9QXt5SpHf2eSeUs761cQoSqh8ji5fyXkUsblJH/Q1+ExFXErTqC0XmjpFG3oqEg/uMkqPsFeAwUm/lCw7F3Diywxs2y+gB6ALc9BEOgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKVAoW+dXtDSizUVzTGIoYfEJyySahtKF65jCm2bsV4=;
 b=Y3Qsxpf7N2Jjw7/t8VZ0Regd88hc04XWke9V3YyI78YjZbSdLNtMDuaGe51rmmThC4Qi2v4wgQxSVBnJBfv/iN76FW0+M9/cIzjnLGkW3dpMFEEIUlOL4oG3hpAYok3FGryx+kySBKgBmZfIwWD8Z23AbH5FsxvI5W6j65O6vXo=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SA1PR13MB4941.namprd13.prod.outlook.com (2603:10b6:806:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 16:49:11 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 16:49:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cedric.blancher@gmail.com" <cedric.blancher@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSm5IPgy8h3QmEuPQMOdkvJBtLB/omOAgACnlYCAAAIBgA==
Date:   Sat, 18 Nov 2023 16:49:10 +0000
Message-ID: <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
         <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
         <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
         <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
         <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
In-Reply-To: <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SA1PR13MB4941:EE_
x-ms-office365-filtering-correlation-id: 45da53bf-be2f-4cf0-dd5e-08dbe85649d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lvEx31ORWNQJCU6t4mwd57G5sdiChDdoBT1RSfhAl2C/YxXVeVlQVYo/NrTmnkt2MuYppk14kyxAF0AHXvh83dPI4id7wulgl5bHfDYbyETxyteCN9R3Ulmm6MiXxGa6dQ2+CH156tNMMswqfip4yQK8EbD3+/2WMVTK9z+pfbRDyH6kskuALQhCbDzZwK4XrNC1mFhoPkWeQYObj38np+/BnN14IH1bOMthYzIjqNUKZpbE9KYdjWbMJQ3fFvSk64J/cN3Tu8RncgLa7bcZSvGGHcLZmLPIffGuG5jcoGyH9+FQ9RTEqaVvbHozi/qXJ1G0yOcqybdTvV8oMMQZjF9fN+slpYyqWs4c4RUbfDPCIadAPtfOqp5I/MYZs3R5s1yU5I992Xba1W67AGOZHM9gbhqxaeqtWpMKwYk6HF0hrXf3p1mUf2O2/Kflp63G0Oh8ZG/7Pe6Zh/cSm/e3l5guDITLpW09eeIxaaTd43+NZsWK0eIaCbwe84/Ku7LBc6uxUQ+gJTzicp552iV2ZnrXOR2x7YOXjjwGeeBdUrHGf6uxpFQpA0DE4boUPeCmHdtgmLxxIKOxXCIM7NsLHivqiElvUTCh4yDUymGAYAUOmAE8+oo6D0UcwwXJAujMkdJuY/sRRnXGKQK0hqq2XaXpSElK2/ogCBW9gDjFVNbAE5M6UjnPski2TAmSpZ0mKEf0z4IrrM3jvUKgeI9cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(15650500001)(41300700001)(2906002)(15974865002)(4001150100001)(4326008)(8676002)(8936002)(316002)(5660300002)(86362001)(38070700009)(36756003)(2616005)(83380400001)(26005)(122000001)(71200400001)(6512007)(6506007)(53546011)(38100700002)(478600001)(966005)(6486002)(66476007)(66556008)(110136005)(66946007)(91956017)(76116006)(66446008)(64756008)(43043002)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2xqK0s0Rng3UVgwRDdqN1NzdC9yc0lJMkpOSVFoeVhER3RXNWx3czR3Sk5k?=
 =?utf-8?B?cDd6dVk1SzA5VDdYTVhRZmhtcWpnZU1maUk4dFBYUFRtaWdLc0JLZ3p3Y2lJ?=
 =?utf-8?B?UVJNTlJVNlRwdDZNeGNJcE1qZnM2RjVES2ZucXhOcmRGMXRYZ2VqNjZLMEJB?=
 =?utf-8?B?aUxoTW1MT2VFQWg4VWZIYmRGTlVtcVZDV2hteGRMOFhieUcxOHA0VnZia2tE?=
 =?utf-8?B?WDN5a0FLOXl0dWVDTDEwamd1T24xKzFZQVNsaEs3K0NGYS84TmdPQW5taStQ?=
 =?utf-8?B?T05PeHRXNENIWWRYNnRGbTNoeHBzc2htdHViN2pyaVgvOEpHWmp4VG82NGZh?=
 =?utf-8?B?NTZ6UXR2UjZ3NU11UkMzM0xZTDBiQmlRbzRiR3J4Qk5td2VjN2oxV25xSkVr?=
 =?utf-8?B?N2M5eDllR2JZVnFIK1dKN1dmMGpicHdVSTRSVnhjdERoa3l2NnJCNmUwNjB2?=
 =?utf-8?B?bFZ6eFBramh4WE1IRjFSS0hqOXBweDhLbGNFSUJuNGpjWlZhdXczMmh4alEw?=
 =?utf-8?B?L05OM00wTlVHQmEyUTV6bkZuN2pvRGE1YzVZd2NDQVJmNC9aeXJzMnp1WXk1?=
 =?utf-8?B?R3NWQnlheEFUdlFWK1BPN1EvejBRRGVVd1FwSXRmbGtKNVJOVG1QOTZneStt?=
 =?utf-8?B?T09vbEVhNEFBK01mMXVZWGRBMDZrWWduZnJtY0w0MENvK3BmMG9GR3MwSTVM?=
 =?utf-8?B?dUJyQWRTeGQ1bVVmWERjUVpVdHA4Y0R4TmVXOGZyOEdXdzZ2MHNhQmdEQ0F2?=
 =?utf-8?B?OEM0Uy9vU25yNDZoNDhlK0FWdC9Lck9ScDRveDRMRC9GUVVtbW14d1c4MjEz?=
 =?utf-8?B?SDNYdmwwUUdYcjBBdEk3YkM0YitVWHJvekZVeWxhNHk4UWt2RFRRT2lzMCtD?=
 =?utf-8?B?RFVmQWY2QVZvNktqM3Z2disyQ2F2a2F1KzdiY0UxT2d6eEtab3FidzVkRW1K?=
 =?utf-8?B?QXhTaSs4ZHpvS2lWU25BVFBlYnd4YU5xSXBZQnV5UERpcEdLVE95enJBY1V0?=
 =?utf-8?B?b0I5L3Nta0NNdi9HVENVTVhPaXNyZG14NS9NMmp4SVRXU055cnhQcTFWQW9a?=
 =?utf-8?B?dTBKM09sa2lxTHhRYTcyZUM1WjQxa05xNlkwNEg5dmFVU0NaTDYzdi9GVXZw?=
 =?utf-8?B?MzJvVjBDd20yNUtSYk5yRkZaQ25nbTcxYWlqK3plbURSdFhGSUZQaDdRZHJh?=
 =?utf-8?B?RzZwTWZnb3N5RkRKNVNkSlQreHcwSXJkTEwvUVV5R1ZucjFBcFZCMmJMWFBr?=
 =?utf-8?B?MW9PNmhPVnZHNlk0cnlma1hncTlTMkNIc29FcVVGYU9QSk56ZVlOZENZMHFk?=
 =?utf-8?B?SVdrN0NFcVBVdHlsKzREOHhwd1RMSkxvR3hiNkhMbUdVUkFLaXE0WjZaWXN5?=
 =?utf-8?B?M2pXT0FEaUxEbTJvOXZHRHVHUFh2SGl5QTlsUzNlcHlOenAzUG03MXBaVWZ5?=
 =?utf-8?B?T2g4Vko5RythNFMwNTBmNldLZEVOaFBndnJ4KzRnM3J0Wi9vczhEa0ZZdDF5?=
 =?utf-8?B?TnpOM2JFL01EeE84NXArUUxLQ2FMYkhvMmRtZS9tdmZHZ3pkaEZzUEhIVys4?=
 =?utf-8?B?OHdEZHJMMGkzcEpKRTUwY2FPb0NZTU84cXF0SWdPMkpYS2NLai9DdEJCRkIz?=
 =?utf-8?B?NDRCWDNlV3M3eTF0Q0ZIejY0eFUxbDZOb3gra1VxQXQ1OHFNWDVMSGsxbGN3?=
 =?utf-8?B?SGs4cXZWY2hJVEwvbUQ2L0s5MHY2c1M1MlF4M3hUaGprN2xDOWxJRXNMVjZw?=
 =?utf-8?B?dVh6dFpra003K3FuNGpVTGtPbE9tc21jVEZhUTdXSzJEVCt4dkxhL1ZkbW5Q?=
 =?utf-8?B?Tk9zRkFqaTAvejdETlhxOHlYWFZoRE1PMUkrY1BPMmNNZUQvWE1XUU84YUlJ?=
 =?utf-8?B?eE1RSDZscUM0amkxSjYrYjh5SmtNdXVpRkdOOTRzRFBqTWlHVDl6amY2R1la?=
 =?utf-8?B?N2lJL3NSM3lKeUlRa3BPM2VSUUZIYno1SURtSkh1VUoxS3VNUmZIczVpYUlM?=
 =?utf-8?B?R3hCMHEyaVFybjdqQUpVdDZSc2YwV294TjVRMTlVRlNqaTQ4TUhFdHIzT2t6?=
 =?utf-8?B?aWUvbHNNZG1IWGYxNWoxcjZrUVJ3VEFySHZaVXdQQndVUUZpUXV5VHNWN1ln?=
 =?utf-8?B?aUl1cnN2emZFd3FNT1RhMkhlR05PWHdTVFBua2VEckJheVhpaFoxdDU4NDdo?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AED6B11E888E1747A63806553F69507C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45da53bf-be2f-4cf0-dd5e-08dbe85649d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 16:49:10.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWEGMteI53YkWOMBhdC2+6CMs8tXhAK7sApJk+Lz6ilmvDTneyKjVQQQNq4CMCYIZ6FZ4fLpK4q9avBh+GRzkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIzLTExLTE4IGF0IDE2OjQxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBOb3YgMTgsIDIwMjMsIGF0IDE6NDLigK9BTSwgQ2VkcmljIEJsYW5j
aGVyDQo+ID4gPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9u
IEZyaSwgMTcgTm92IDIwMjMgYXQgMDg6NDIsIENlZHJpYyBCbGFuY2hlcg0KPiA+IDxjZWRyaWMu
YmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSG93IG93bnMgYnVnemls
bGEubGludXgtbmZzLm9yZz8NCj4gPiANCj4gPiBBcG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBpdCBz
aG91bGQgYmUgIndobyIsIG5vdCAiaG93Ii4NCj4gPiANCj4gPiBCdXQgdGhlIHByb2JsZW0gcmVt
YWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBhbiBhY2NvdW50IGNyZWF0aW9uDQo+ID4gdG9rZW4N
Cj4gPiB2aWEgZW1haWwgZm9yICpBTlkqIG9mIG15IGVtYWlsIGFkZHJlc3Nlcy4gSXQgYXBwZWFy
cyBhY2NvdW50DQo+ID4gY3JlYXRpb24NCj4gPiBpcyBicm9rZW4uDQo+IA0KPiBUcm9uZCBvd25z
IGl0LiBCdXQgaGUncyBhbHJlYWR5IHNob3dlZCBtZSB0aGUgU01UUCBsb2cgZnJvbQ0KPiBTdW5k
YXkgbmlnaHQ6IGEgdG9rZW4gd2FzIHNlbnQgb3V0LiBIYXZlIHlvdSBjaGVja2VkIHlvdXINCj4g
c3BhbSBmb2xkZXJzPw0KPiANCj4gDQoNCkknbSBjbG9zaW5nIGl0IGRvd24uIEl0IGhhcyBiZWVu
IHJ1biBhbmQgcGFpZCBmb3IgYnkgbWUsIGJ1dCBJIGRvbid0DQpoYXZlIHRpbWUgb3IgcmVzb3Vy
Y2VzIHRvIGtlZXAgZG9pbmcgc28uDQoNCj4gDQo+ID4gPiAtLS0tLS0tLS0tIEZvcndhcmRlZCBt
ZXNzYWdlIC0tLS0tLS0tLQ0KPiA+ID4gRnJvbTogPGJ1Z3ppbGxhLWRhZW1vbkBrZXJuZWwub3Jn
Pg0KPiA+ID4gRGF0ZTogRnJpLCAxNyBOb3YgMjAyMyBhdCAwODo0MQ0KPiA+ID4gU3ViamVjdDog
W0J1ZyAyMTgxMzhdIE5GU3Y0IHJlZmVycmFscyAtIG5vIHdheSB0byBkZWZpbmUgY3VzdG9tDQo+
ID4gPiAobm9uLTIwNDkpIHBvcnQgbnVtYmVycyBmb3IgcmVmZXJyYWxzDQo+ID4gPiBUbzogPGNl
ZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9i
dWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTgxMzgNCj4gPiA+IA0KPiA+ID4g
LS0tIENvbW1lbnQgIzIgZnJvbSBDZWRyaWMgQmxhbmNoZXIgKGNlZHJpYy5ibGFuY2hlckBnbWFp
bC5jb20pIC0NCj4gPiA+IC0tDQo+ID4gPiBJIGNhbm5vdCBhY2Nlc3MgYnVnemlsbGEubGludXgt
bmZzLm9yZywgaXQgaXQgZG9lcyBub3Qgc2VuZCBhDQo+ID4gPiAiYWNjb3VudA0KPiA+ID4gdmVy
aWZpY2F0aW9uIHRva2VuIGVtYWlsIiB0byBtZS4NCj4gPiA+IA0KPiA+ID4gLS0NCj4gPiA+IFlv
dSBtYXkgcmVwbHkgdG8gdGhpcyBlbWFpbCB0byBhZGQgYSBjb21tZW50Lg0KPiA+ID4gDQo+ID4g
PiBZb3UgYXJlIHJlY2VpdmluZyB0aGlzIG1haWwgYmVjYXVzZToNCj4gPiA+IFlvdSBhcmUgb24g
dGhlIENDIGxpc3QgZm9yIHRoZSBidWcuDQo+ID4gPiBZb3UgcmVwb3J0ZWQgdGhlIGJ1Zy4NCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiAtLQ0KPiA+ID4gQ2VkcmljIEJsYW5jaGVyIDxjZWRyaWMuYmxh
bmNoZXJAZ21haWwuY29tPg0KPiA+ID4gW2h0dHBzOi8vcGx1cy5nb29nbGUuY29tL3UvMC8rQ2Vk
cmljQmxhbmNoZXIvXQ0KPiA+ID4gSW5zdGl0dXRlIFBhc3RldXINCj4gPiANCj4gPiANCj4gPiAN
Cj4gPiAtLSANCj4gPiBDZWRyaWMgQmxhbmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+
DQo+ID4gW2h0dHBzOi8vcGx1cy5nb29nbGUuY29tL3UvMC8rQ2VkcmljQmxhbmNoZXIvXQ0KPiA+
IEluc3RpdHV0ZSBQYXN0ZXVyDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiANCj4gDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0IA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMgDQoxOTAwIFMgTm9yZm9s
ayBTdCwgU3VpdGUgMzUwIC0gIzQ1IA0KU2FuIE1hdGVvLCBDQSA5NDQwMyANCuKAiw0Kd3d3Lmhh
bW1lcnNwYWNlLmNvbQ0K
