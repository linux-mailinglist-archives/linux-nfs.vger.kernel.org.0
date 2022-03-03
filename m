Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085324CC01B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Mar 2022 15:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiCCOis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 09:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCCOiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 09:38:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7ADEA05
        for <linux-nfs@vger.kernel.org>; Thu,  3 Mar 2022 06:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/2Lc9GcdMUgFfakcUewWw4NpVCIboTPAcahXssdphHnaN62RiWRqDdfXmSMfU1OUfzwcsVkibVLk9sdX/hh5xlPeklTx5YR6H+gWwpxSFgvtUTBg6RXszjeSJtubvQWk+8mygcc8UmoETGM5ZK67xwqBiLpR+/bee5miw4gbP/PQcsqISgr6hBmEOSwmFX36PJgpwWWqqSiwwZ7KhrAtkm2qLim87H3QsqbBC3v09Z2H/NOBK+SFhRL0RPDVPNJyLwbiIJenW6vqC0eDGVvqccDDYf/mIMV7LEZjW1YSmIYMfRbK791XyZteCemTPQQkrS/7Z7UO/UOawAr85PoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELKWhUOmDB7lwlHYxggkI9l7J0syMwAjg2Tv3fjFbn0=;
 b=oL7xzlJxccmtdUqED7z0EjxMCed7hviwjEvaVxIX6tmCgNRzdUEEuqmSablXnnIDeb3Fm29WO6hbHntVewJlMQfm32qvikoWYKabxHdPmqzV38ZwxSsxcyVJCAPyYBLO1k4Mb5zYSW8FMLmCP96HJZT20MA+DXmlEVXqqhXPnZ+623hRDcd7Gu/L/TsWhGY72q1szDrzWQLdxhCM3QTPCn0G0tBT8l6Z5iWlEGelf6WqIc7A/+QV1EWTIJA26D6fe8B5J+U0j9tkC7tIH22NBeprXWwjNG5U5wJc/KPdz49pWO5VLq8uq5ZvNGSC4BAoACM5Uu752rSNRnHBVDoJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELKWhUOmDB7lwlHYxggkI9l7J0syMwAjg2Tv3fjFbn0=;
 b=GrsFIl93dI5VnCAUcUfNPbdf2flGUnOfR/nXgZwAIPTlht8Wke6uHwhRsH1XKa3E2ZPfQ+cScgOZljzCvRcP71vFwySNw1OX6slI/nVESP1FTUKGuL0noYpudozZ6L4xqM1/TEmo5/2e8nrKQU+mP2U3/99q/lG+AJX65elSRdg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2838.namprd13.prod.outlook.com (2603:10b6:a03:fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10; Thu, 3 Mar
 2022 14:37:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 14:37:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6asMyMUU/24UmxPIHB1+YUTayqohqAgAJglgCAALubAA==
Date:   Thu, 3 Mar 2022 14:37:55 +0000
Message-ID: <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>
References: <cover.1644515977.git.bcodding@redhat.com>  ,
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>      ,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>      ,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>      ,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>      ,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>      ,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>      ,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>      ,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>      ,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>      ,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>      ,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>        ,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>      ,
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>      ,
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>      ,
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>      ,
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>      ,
 <164505339057.10228.4638327664904213534@noble.neil.brown.name> ,
 <164610623626.24921.6124450559951707560@noble.neil.brown.name> ,
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
         <164627798608.17899.14049799069550646947@noble.neil.brown.name>
In-Reply-To: <164627798608.17899.14049799069550646947@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f67e5a-3dfc-4b4f-eb48-08d9fd236806
x-ms-traffictypediagnostic: BYAPR13MB2838:EE_
x-microsoft-antispam-prvs: <BYAPR13MB2838B2A47DF708E805A61574B8049@BYAPR13MB2838.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Duap0RAEMuP3vgEFEi9gqCn5+vXpd9LHNX7qZ8nxkep1OG+xrPQ3okeN7mrOGmefFIQROxUefOTGdHIIY6paX3u4cQDJUXfAIWdb5cvgEdWNbgr+LzEShf76ap2HNkmYiOEfNdw0CtN/HAcpY12/2Yi0QJJUzbgQ3x1zQXBUgRK00rIMSduj/1olNhTWJ71NhdOF2GMagLMSW+HRMu/KsL+ESHddgZjVAUctsLqIn8DPHX3Te+67HIDJwQ8SKHvyRfBInuBwDfNCzM5K5jd3gCvDZODwomI2aRgoV2RQevf/Tm4l33xty2taZuNPb8I1X4MGu70vh3SQDjhCrWnXbKuYelXiiD+MK5iGA50glop21tSL9xrdRoDAW1CK0y/eaaap3SimFEol23VBeDy4UEIrbgXSlqK2Bxv6z0WrHt0YybNOH4GoqVe6tk4zE5SkBbh1R9ywQZGAQofsVLlyz8KioQigJCYXWHlpOAsJOU4XJQ2O7f7QVl8OfT0oh8GGrfyHZ/DXdiC7AhY9yHUJ8i+v2KRiOMI2OgBiFTXxq+om91Bkz+PturuI6kmT/NZVWA5IyP09+G0X/rMJPYWcDFtCfcdJuKJMeI1Woc9gtK4pzTKTS236mwZES4/h3+1K3dY/e1Dt7eeNw7DEhL4NV6ZAs2N2ESxAJTxqodOmGylJRsBj/W2qPwkJC/vmmdR5eBdHoriKdBoVCzc0+p6Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(122000001)(38070700005)(66556008)(71200400001)(508600001)(2906002)(86362001)(8936002)(5660300002)(64756008)(6486002)(76116006)(6506007)(6512007)(4326008)(66946007)(316002)(8676002)(110136005)(66476007)(26005)(186003)(66446008)(2616005)(54906003)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajV2WEwrdXo1bjcwY2hQQXYvZmR2dkVlclA0S3pSblNJVFlyT0dNa0Q1RXc2?=
 =?utf-8?B?UEVBZGJBYTc2UmtzMmE2OGY5Y1lKbDZNQmR0bnlEVU9DdVF5d1o3YUZJeU9F?=
 =?utf-8?B?ZSs5NUdXeUVHTmMvTU15aGI5TFdVMlFha1hxU2FqZ2I4VGc5S0o3MVFzbTZU?=
 =?utf-8?B?UVFUOVhPTmlZYU1XUUVtQS93WlFXQUNFZlNIWkNrY0k0T0JUcTFNdmI0Wk5I?=
 =?utf-8?B?SUdRQzUzYzJzMXNudTJoV2h0RUZmQWdhRjRGYXd2eCtaRTN1cGdsZjVpeUla?=
 =?utf-8?B?Ti9iSHNFYzB6QUpVRE1KMjRqeENxWng1aUQ0T0trQUZzU2x4THl5dTRyWXNK?=
 =?utf-8?B?Qlhrajl6OXNwZnZtcm50WUgxK2NUQ25NQmE2ayt6OXBWTHFtQXRLZ0dtVW5E?=
 =?utf-8?B?WnhMYVFUZXlkbXZrMDN6aFVnZmdKN3Jaa3Y5UkRhbG1nSVZRZGVpcDdFaFVU?=
 =?utf-8?B?d2FnTlZ6NE5CNU84UkxJWG5vVVJ1YVFxbGJGeGQ2MklleU9vb2xhZXhWVjht?=
 =?utf-8?B?ODMwNjhLVi9iNDVkN0NjZTViNzFpeWlxTXRRaU43cys1cURobDRaUEFJcVYy?=
 =?utf-8?B?QTU3cGl6ZlVzLzhDc3ZxV3ZvaWM0cCtlK2x2ZTR6NnM1Wml5WHI5WTJlYXpM?=
 =?utf-8?B?THU0MHFiUUxwaFFJcnZPd21BQnRQSWVjUzNYN1l6ZVl2dGhOM05Vb3k1UUpy?=
 =?utf-8?B?OFZ3TUhXWDQ3ejVKZnJzTTZLVkFIZUxhOWtoUlRDZ28yUHBDblU5dkxGYWg2?=
 =?utf-8?B?ODhDL2hKWTRVQU1oajNoVlNVTTJERmxOSk1RZWV2WlFBdmVoQ1VyV0pJNjdk?=
 =?utf-8?B?SzluR2xuazRDbHQ0d3AwM1h5dGIvdVFFejM1OWMyTGNHTFpDZHR2VFhjcDhs?=
 =?utf-8?B?RGZ4RHFkWENLR1JxSzRRR3ZERngydEFNbW9rWGtvVk1Cbk5HdldMUGZDdlgr?=
 =?utf-8?B?WnBhZGp3WVMvOEo5Uk9FV2VBb2pDdng5eHIwc1pUODFpb2w1V3UxK0JTNXJR?=
 =?utf-8?B?TVhKR3FuSUN0TnVUVjBPcHI3YnNvaWpQQk1LeHhvYktHOFhEZUdqa0pTSTNv?=
 =?utf-8?B?YnNTamhBR0Z2TGtvREYwWHBMQTZoNXhvaUxTaXBKRXd5NHdOTE54L1F1UUo4?=
 =?utf-8?B?aEcvWVhKMXhFNzJPU1VXMXVEY1FvR3EydkxaOXRuVnFjV2JMNHpuTS8rYlRm?=
 =?utf-8?B?YytjUkNiaGp0N1FGMm1ET3FveXN1Yjd5VDFEQzRsNFpjbmVJNXphRkRraG4w?=
 =?utf-8?B?R0ZkN21BMFRRWEZ1VVVHNTV6b2ZKTDdkWk5wRFd1M1FQZkF3UDc0eE94TTVQ?=
 =?utf-8?B?MXp5OTNCVWV5eDlGU2k4ZDZtb1Bmc2RzMlVRMDFkVnJLVHRaNmFUaDY5SThQ?=
 =?utf-8?B?eUowRXVUVEk5MVVyWVhDczVYcWExc2JOV3ZKSXQ5YVJta3MyNHRSMFBpdnRD?=
 =?utf-8?B?RG1NWThnR0FuY0VWd2FSakdqTS8xY1YxU0xNQmMyRitRNVJjK2Zta2RaRWlr?=
 =?utf-8?B?d1FMZFhWU2ZUVHJVc3BpcEFQZklnL1BiN3ZCeklLQTk5ajdmanBjZEpwYkRm?=
 =?utf-8?B?TklxdkFtVXZyS1NMdWxOTWxEUXJzQ0dZcTJSL2YxdjRxU0tZMEd3aFloYU9l?=
 =?utf-8?B?YUptcXBzdlBsTlhkUWh0WWtuc3FzdVlLTExIWDdxbnN2bW0rSDMxMytvSnNG?=
 =?utf-8?B?bG1RNm5kMXJHZC9FZ0plWDZuRVYydHNGWFZCMkVubGpyUHVqSkJqUzE0ODk4?=
 =?utf-8?B?eUtoZXA5Si90Y2VzL2JRM2RpQ0tEazFXOFJJVkZHbmduK1R0OGRodnordWZt?=
 =?utf-8?B?aVlFSzF0MjBLWXFzeE1YRVUyRkgwU1l2VktVaWhETEhNdVMyWTh2djh2ZGh1?=
 =?utf-8?B?WDB0aTRGUXJJZUVkOGxsYVBVcEdQVGlFQSsxekZ6V1pvRlpTSDRjKzFGbHpN?=
 =?utf-8?B?N2ZWdzY3N1ZqQ2ZtV2NXdWc3VEVyZHgySWRNR3FnMEk5YkhFOTNzTzd1cDFY?=
 =?utf-8?B?RWY1cGlIMytSaXNQTlF6S25Rbm9wVnhQMHY2YTFnSU1lT3BQQnRMRlZON20v?=
 =?utf-8?B?M1N3bTVRS05McFo0cVM5WlpWZFpiWlpDdzMwS0VyYXdoTzdqU2Z2eGlRaUI1?=
 =?utf-8?B?SUZsSnM5cGdTNXNEMWJoSElSSWJrRWNOK1poaFVlMmJCQnlocFc4LytYeTlD?=
 =?utf-8?Q?+9S9Y8ZVOeh7bKVqzkXEB8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4769B1E3850A324FAE8A145A53A20C0B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f67e5a-3dfc-4b4f-eb48-08d9fd236806
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 14:37:55.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUWVKFpiI96Nif4EGgNGEelvp/qwDVIihHu8TKitxw+TaqHO1LwKA7LYxbAywObID0Cw2smplwYHtt1/mIgd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTAzIGF0IDE0OjI2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDIgTWFyIDIwMjIsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gDQo+IA0KPiA+IA0K
PiA+IA0KPiA+IFRoZSByZW1haW5pbmcgcGFydCBvZiB0aGlzIHRleHQgcHJvYmFibHkgc2hvdWxk
IGJlDQo+ID4gcGFydCBvZiB0aGUgbWFuIHBhZ2UgZm9yIEJlbidzIHRvb2wsIG9yIHdoYXRldmVy
IGlzDQo+ID4gY29taW5nIG5leHQuDQo+IA0KPiBNeSBwb3NpdGlvbiBpcyB0aGF0IHRoZXJlIGlz
IG5vIG5lZWQgZm9yIGFueSB0b29sLsKgIFRoZSB0b3RhbCBhbW91bnQNCj4gb2YNCj4gY29kZSBu
ZWVkZWQgaXMgYSBjb3VwbGUgb2YgbGluZXMgYXMgcHJlc2VudGVkIGluIHRoZSB0ZXh0IGJlbG93
LsKgIFdoeQ0KPiBwcm92aWRlIGEgd3JhcHBlciBqdXN0IGZvciB0aGF0Pw0KPiBXZSAqY2Fubm90
KiBhdXRvbWF0aWNhbGx5IGRlY2lkZSBob3cgdG8gZmluZCBhIG5hbWUgb3Igd2hlcmUgdG8gc3Rv
cmUNCj4gYQ0KPiBnZW5lcmF0ZWQgdXVpZCwgc28gdGhlcmUgaXMgbm8gYWRkZWQgdmFsdWUgdGhh
dCBhIHRvb2wgY291bGQgcHJvdmlkZS4NCj4gDQo+IFdlIGNhbm5vdCB1bmlsYXRlcmFsbHkgZml4
IGNvbnRhaW5lciBzeXN0ZW1zLsKgIFdlIGNhbiBvbmx5IHRlbGwNCj4gcGVvcGxlDQo+IHdobyBi
dWlsZCB0aGVzZSBzeXN0ZW1zIG9mIHRoZSByZXF1aXJlbWVudHMgZm9yIE5GUy4NCj4gDQoNCkkg
ZGlzYWdyZWUgd2l0aCB0aGlzIHBvc2l0aW9uLiBUaGUgdmFsdWUgb2YgaGF2aW5nIGEgc3RhbmRh
cmQgdG9vbCBpcw0KdGhhdCBpdCBhbHNvIGNyZWF0ZXMgYSBzdGFuZGFyZCBmb3IgaG93IGFuZCB3
aGVyZSB0aGUgdW5pcXVpZmllciBpcw0KZ2VuZXJhdGVkIGFuZCBwZXJzaXN0ZWQuDQoNCk90aGVy
d2lzZSB5b3UgaGF2ZSB0byBkZWFsIHdpdGggdGhlIGZhY3QgdGhhdCB5b3UgbWF5IGhhdmUgYSBz
eXN0ZW1kDQpzY3JpcHQgdGhhdCBwZXJzaXN0cyBzb21ldGhpbmcgaW4gb25lIGZpbGUsIGEgRG9j
a2VyZmlsZSByZWNpcGUgdGhhdA0KZ2VuZXJhdGVzIHNvbWV0aGluZyBhdCBjb250YWluZXIgYnVp
bGQgdGltZSwgYW5kIHRoZW4gYSBob21lLW1hZGUNCnNjcmlwdCB0aGF0IGxvb2tzIGZvciBzb21l
dGhpbmcgaW4gYSBkaWZmZXJlbnQgbG9jYXRpb24uIElmIHlvdSdyZQ0KdHJ5aW5nIHRvIGRlYnVn
IHdoeSB5b3VyIGNvbnRhaW5lcnMgYXJlIGFsbCBnZW5lcmF0aW5nIHRoZSBzYW1lDQp1bmlxdWlm
aWVyLCB0aGVuIHRoYXQgY2FuIGJlIGEgcHJvYmxlbS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
