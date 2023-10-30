Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BED7DBC2F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjJ3O4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjJ3O4r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 10:56:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0FC6;
        Mon, 30 Oct 2023 07:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4jT13NcuEmtxRNpa3NigdYKpa6VZL9aFGF5jJmA+mJr80QwXD6U42uYKQnanHpAln7hLQ7GVnTURggY+/O+T3V6UMD3vYM6r73pTgNqWKA7On1hummmvQNmI8jE6DwiryBzZAxcz5ic12L7Zx2B+Ofzd4P4DBAIWtsHqUw1w/Zth7zHybS1zCgWeM4ujEK4nHbvzwZw073yuCesGJuQBpATOuZJUqBdi6oh682QO3HF0+M/bgLdW4ucOWzLUuB+KSx/j2hfqY1SgbTzAnV8EAlUWBdyEb0QqCBpwOeRK5d4sbpCkzA7OQydTijFoLaKEMcAVtf+zEpjq2gXwLzzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpYSJ3TCyM2ObpGPsh9+YBosQGHJw3nMjcG76fAZRRs=;
 b=Xmst52szWMIzf7SF0us+xuvkv955T2ywKIYVEDIzQa/htnYDBwc/g0y+pAmpjbpx6TVIT4TQLDjMp1YEU6MT9VL9DZ/x4oyg/CbCCesdyoTRy/rF1HV6Q2wsmq6dSind2yuFonT6prWap+jUbF/qyeYAQ7iS5x6dcWP0XA57dEDKjjywZa1LCpNj3hSSSGqJQGLJ5Xk/AlX/EykIjMtcui9ehsXll02WVANS3nZyMVNORvfpjd4w+Kj7vbWFIxyG+w60DEWRqXfSElBkWtsbX/G6Er/gf9KtHZEA4YxaL1T0JPwj/0rr63V9DTImn8ghdsh64L71hY8hPSa4a8SbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpYSJ3TCyM2ObpGPsh9+YBosQGHJw3nMjcG76fAZRRs=;
 b=bkHlH7C1KRFIAQ+TrLsxIu9wpi+RarDAgOnbzh00hHcjfyNCkshjlDIYpRIyNdY389hiVV8BO7Hsg1p5bc6FsAEKkP0HawY7/VX9bUQsXjtApwrAQ84Ug+Gt6ZBwLlZwbyh1Dy0wk5bW+OaCqmiS6NhzDJ/ZB5cEZ/SQmxM0pZ0=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 LV3PR13MB6453.namprd13.prod.outlook.com (2603:10b6:408:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Mon, 30 Oct 2023 14:56:41 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%4]) with mapi id 15.20.6907.030; Mon, 30 Oct 2023
 14:56:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chenxiaosongemail@foxmail.com" <chenxiaosongemail@foxmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "huangjinhui@kylinos.cn" <huangjinhui@kylinos.cn>,
        "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
        "liuyun01@kylinos.cn" <liuyun01@kylinos.cn>,
        "huhai@kylinos.cn" <huhai@kylinos.cn>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Thread-Topic: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Thread-Index: AQHaCwyXnnPd11Fd+0az6pmICUNKXLBiBCCAgAADCACAAAFNgIAAAaaAgABiXoA=
Date:   Mon, 30 Oct 2023 14:56:40 +0000
Message-ID: <3b8caab5918d06f436a889bc1dba09686fc0fad5.camel@hammerspace.com>
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
         <2023103055-anaerobic-childhood-c1f1@gregkh>
         <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
         <2023103055-saddled-payer-bd26@gregkh>
         <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
In-Reply-To: <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|LV3PR13MB6453:EE_
x-ms-office365-filtering-correlation-id: 1afa4b94-250c-4e6a-c374-08dbd9586ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTR2dHJjiyWPn7q1lQB9fT+zXuu5XzyvQFB00nTL6OB+Sz3GglNWwpmp0q+kU0ZVJhxD4tirRbf95wyqjezIjIpS6s1ZDtl7UnF4UkMfjwmXW1XkKA+EdyyowipPsB2zmEOO0Va4hyR3w2Ir0cpZ+iaq6/U827jQfhBtL8OAJZOqFklBAz7rW43YH3Tqqf4WPSEpY/f4phrL2A0nbER6JwcfhF0LEeM/KS3LPHNVvdhPdlCFoc9HjSE/Xdo6hI3kOp+x19TWWY28QfeK5VhvPePsYnzAaUwohfwY4b7cQuHY/4frlE0t6MEohx9471/angw91E97q67Ak2ChuKIxkA4dU/jZpyIjErvX8fiO/hcAfPxJPsPaBR7QfHcaPrAw+jcu70fOgTERqNjw4N6DvuCt4CHKmu2JmvX5nvaBQ9PqXEtKd0bwizLIr+av7HeR4DggXHWw8INbzQzWWq6lnXoQzmjjgCZkaqAX6p8iJ2a0u1sHFnHDmyB2lRjidPsJxyI9BBQ4fuLosCRn4H+lErr51P9wM4P1bsAinek7HdzkHMcIyL2FAdnU8pSfF/PJuR8NXy9Zl0K3vex8fta6A9QE6oRJnFLBF9/5Nafdbgbp2/rIPvdGR6ULsFmC8HwHzA8ody+WK97lVhSmwX13MCGrAQpZOJxfQS/BGeawLW8kKo5tSslgygGZC14qlk8xveN8Ch0RqYWU2HffPweUAHzQaHy8b+7Z+tfNVAeuV4ZiZPk5kTsLcaTTfD23uWhC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230173577357003)(230273577357003)(230373577357003)(230922051799003)(230473577357003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(316002)(64756008)(54906003)(83380400001)(7416002)(71200400001)(2906002)(478600001)(966005)(6486002)(8936002)(66946007)(76116006)(66556008)(66476007)(66446008)(91956017)(5660300002)(110136005)(8676002)(4326008)(4001150100001)(6506007)(53546011)(2616005)(26005)(38070700009)(6512007)(36756003)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWJqRmpETkVYbzhzeTRYcVA4Z0FVVytsNUJZTjFOSHoxRkxKa0tSZ1h2Vm9O?=
 =?utf-8?B?RG9sVndIMy9PVnI2Ky9iNkJ1NmJrNUhzSVJDQjlQTGFpRFVNM0QybGVBYUFM?=
 =?utf-8?B?aVpxTEw0QWMyRHViWGxLMmlNNzArVy8zNEZNZnMvT3RMY21xSldyaDRzcUZk?=
 =?utf-8?B?NkM4RWNLTklhbit0QkxJeE1LbVkzaVRMcFVqd0UvYi9EeWpOWUZUZnp4VGdV?=
 =?utf-8?B?N3pQN1gzbHdCQUd3VUFaWkpBemRWUlNZUjVYN1dwcDFrRjJCdjFYU3N3NnBV?=
 =?utf-8?B?SWliZU9ROU1aVTJOVHd0Y1M4M0NLdkswREdXcWpuVUxqWVlSZ202elFZaExk?=
 =?utf-8?B?a2djY2xtcFdkYTR6bjgzL2lsYTB5YXYzYTMvWGxjOE0yZE1BckxQTU1DUDNL?=
 =?utf-8?B?azRzTGRSRUo5cFBNeTJmU1FmSCtJL3cwWXlXNVh6RVZWQndhaXJxTFk1bXg5?=
 =?utf-8?B?UVY0b0VQS3RSWmlOQVRNMnFrVTlLM1FVTEd0aWxxbXh1eDdqNG9HTHhDOGpl?=
 =?utf-8?B?LzBvZnNsOExoWjcrK1JSTGdnb1RqM2dXMzBxeFBzbnNueERtWEhmanFnTEdJ?=
 =?utf-8?B?V1B6K3VsenZYSjBpdWVncHJMYnJaKzRlVlE3c3NRWnRqM0cyYW16V2FZVWxG?=
 =?utf-8?B?cVhFek4rRHViUGRlMGllT1ZKN0R6T1gyZUFlUnRWS0NIOHlyRWs1QmFRTmpp?=
 =?utf-8?B?ZXdpM3g0WmFka0ZLLzRaU1pONCsxa01Xc2pvTFV3eEg5ZWo4V1lrQWVJVmRa?=
 =?utf-8?B?UlpBaTl3UE1OQkxWcS9IbmlackppR0p6dUd1YUxxcElYSGNKYjlVTC9RYzEx?=
 =?utf-8?B?c25WU1J5TlNzWnAwS2FnbUdHSk40Z3premRHWHFmaElCeXhhd0ZTYkdQM3Zl?=
 =?utf-8?B?N0lubXBMQVFCaHIxY3E5UEhoL1c3MFRxRCtWU1M2VVU2Vy9LL0VIV2hlQzZQ?=
 =?utf-8?B?UEZISzJZdThqOEo3c2NUakU3TFhMS09WS1lmL0E0cVljR2YzeWFrWHNsaWZp?=
 =?utf-8?B?QzZrMkxHeklFbEhuWDNIeEdYMVN6dkp4WmNFYjloSWgxc1oycVNQRlltbXND?=
 =?utf-8?B?VlBpNFRKeXFDRWNnWVczWHVFczdIalc4MWVMR3VmSlZEMnBJR2V2aVluOG9v?=
 =?utf-8?B?OE45N0hCNE1zREM0MkVGTnpuNFJjakVNbkhKY1JGaHp0dkJSbWR5MUkwQlI3?=
 =?utf-8?B?K09vaTVnYW81QWhmb3dnWmRQR3JrT3RVV1U1cEM0Qng0QUlzYWlLSTR5bFN5?=
 =?utf-8?B?Yk1JWUVQTWFDOFpXOWZTN0plV0pXeHZLNXFCWFlOZm1qbUZ3dmVWVm5lQ05Z?=
 =?utf-8?B?Y2xLbXRvMTBRNU5ubFhNanhJZlk3ZU85Ymc4UmFQUVM3WU8yUFp3UVZpZ3Br?=
 =?utf-8?B?enA4T29nbmxjekVJUERLMHVjbWFBQzUxU1pwa0srQ0pJSFZDUkMxN09UTEhu?=
 =?utf-8?B?TXJrTkc4c0tvVlkvK1ZpY1F3c1pTQzZsQUZpWXhtUzROQjYzcVNvbWk3dzVC?=
 =?utf-8?B?VzNHZmhtcTJzdjl3Mm9za2dENGRSOXZtQURiMzNLL0tHa1pXZzV0K2Q1d2xm?=
 =?utf-8?B?elpOUDVHN25ZWkhuRDAxVW1GaDZIWENNWkZidERzeWxSWmxWdDJDemI1bElo?=
 =?utf-8?B?YUtWOEk0UHZGY3lEUy9uaGttMjFnYy9ZaXAwZGhxTnRadHJkYkU4VXpYeUt6?=
 =?utf-8?B?RTJCd2ZDL1NuL3J6NzFIYmdzZUNaTFRjdVdJSkJweXN2S2ZZM0cyL1ZablNa?=
 =?utf-8?B?cEswTnBaZ1Y5aTNWNmpvWGl0OGs4bnhWWi8xbEFXM0hQSGdBajJCS21QelpP?=
 =?utf-8?B?bjR4cUxTeFVOS282Q1JMdHZhb3lEVzVLd3hXZ0RsM0RZbXFjcXpwcENmcFRl?=
 =?utf-8?B?UmRkZ1dIM3E3WkYwckFRaGE4NlljcjZDOCs1RTdvSkF4cjdBQis1V1RSdzNJ?=
 =?utf-8?B?L1RsRDJOcFNNblhEd1NoK3E4WFhOaXhBbmsrOXYrMUwrVmp0S3FDOEhyM3NR?=
 =?utf-8?B?TW9wNnpEN0NTTXhSZm1qUXpoOWR1cXpVSU5DcUZHSWZic3ZLOWpFNlN5R0xz?=
 =?utf-8?B?bkJiR1hQUnU2TW1kTEw1azh3a1N6UlRtNUpaK294R0FwTWVJUDR5S1cvYWJB?=
 =?utf-8?B?WUFuUXpxaDZLdXJvak5RYTJmS09BRzZnaTk4T2FBd3k5NEZEazFtMmVIMFl6?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B068753EB722584B84772E60007B7192@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afa4b94-250c-4e6a-c374-08dbd9586ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 14:56:41.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejEWjZqvUh9M3JbRYIgUD4GKCbtfKqwsYrSB/zcHBCKLm7ysaqvvhmWe1o4IycVPy7DtkfjNrfgh/cbXIopAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDE3OjA0ICswODAwLCBDaGVuWGlhb1Nvbmcgd3JvdGU6DQo+
IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gY2hlbnhpYW9zb25nZW1haWxAZm94bWFp
bC5jb20uIExlYXJuDQo+IHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gDQo+IE9uIDIwMjMvMTAvMzAg
MTY6NTgsIEdyZWcgS0ggd3JvdGU6DQo+ID4gSWYgeW91IGp1c3QgcmV2ZXJ0IHRoYXQgb25lIHBh
dGNoLCBpcyB0aGUgaXNzdWUgcmVzb2x2ZWQ/wqAgQW5kIHdoYXQNCj4gPiBhYm91dCBvdGhlciBz
dGFibGUgcmVsZWFzZXMgdGhhdCBoYXZlIHRoYXQgY2hhbmdlIGluIGl0Pw0KPiA+IA0KPiA+IElm
IHRoaXMgZG9lcyBuZWVkIHRvIGJlIHJldmVydGVkLCBwbGVhc2Ugc3VibWl0IGEgcGF0Y2ggdGhh
dCBkb2VzDQo+ID4gc28gYW5kDQo+ID4gd2UgY2FuIHJldmlldyBpdCB0aGF0IHdheS4NCj4gPiAN
Cj4gPiB0aGFua3MsDQo+ID4gDQo+ID4gZ3JlZyBrLWgNCj4gDQo+IA0KPiBJbiBteSBvcGluaW9u
LCB0aGlzIHBhdGNoIGlzIG5vdCBmb3IgZml4aW5nIGEgYnVnLCBidXQgaXMgcGFydCBvZiBhDQo+
IHJlZmFjdG9yaW5nIHBhdGNoc2V0LiBUaGUgJ0ZpeGVzOicgdGFnIHNob3VsZCBub3QgYmUgYWRk
ZWQuDQo+IA0KPiANCg0KQSByZWZhY3RvcmluZyBpcyBieSBkZWZpbml0aW9uIGEgY2hhbmdlIHRo
YXQgZG9lcyBub3QgYWZmZWN0IGNvZGUNCmJlaGF2aW91ci4gSXQgaXMgb2J2aW91cyB0aGF0IHRo
aXMgd2FzIG5ldmVyIGludGVuZGVkIHRvIGJlIHN1Y2ggYQ0KcGF0Y2guDQoNClRoZSByZWFzb24g
dGhhdCB0aGUgYnVnIGlzIG9jY3VycmluZyBpbiA0LjE5LngsIGFuZCBub3QgaW4gdGhlIGxhdGVz
dA0Ka2VybmVscywgaXMgYmVjYXVzZSB0aGUgZm9ybWVyIGlzIG1pc3NpbmcgYW5vdGhlciBidWdm
aXggKG9uZSB3aGljaA0KYWN0dWFsbHkgaXMgbWlzc2luZyBhICJGaXhlczoiIHRhZykuDQoNCkNh
biB5b3UgdGhlcmVmb3JlIHBsZWFzZSBjaGVjayBpZiBhcHBseWluZyBjb21taXQgMjI4NzZmNTQw
YmRmICgiTkZTOg0KRG9uJ3QgY2FsbCBnZW5lcmljX2Vycm9yX3JlbW92ZV9wYWdlKCkgd2hpbGUg
aG9sZGluZyBsb2NrcyIpIGZpeGVzIHRoZQ0KaXNzdWUuDQoNCk5vdGUgdGhhdCB0aGUgbGF0dGVy
IHBhdGNoIGlzIG5lZWRlZCBpbiBhbnkgY2FzZSBpbiBvcmRlciB0byBmaXggYSByZWFkDQpkZWFk
bG9jayAoYXMgaW5kaWNhdGVkIG9uIHRoZSBsYWJlbCkuDQoNClRoYW5rcywNCiAgVHJvbmQNCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
