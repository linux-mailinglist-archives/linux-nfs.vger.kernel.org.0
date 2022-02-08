Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84E4ADD5F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiBHPrv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 10:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381836AbiBHPrv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 10:47:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCAFC061578
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 07:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5rFi1cezJqP9XiRmHKMjTZiwH0aggeLgvnvooAfd9HcAQKOeQZIlaQNWAi47D1J3J5TlvuYs+pqTPw/xsX7aqXijgsrADWVveOedmQckbwnTxx3QEuyEt6XuTpn6ZGNLr00SeH1iDtH5Pf3mgVgC6+734FxN58MTtYMIsIxJp1K78IQHu/bzsJ4wcQiWwYqmegp44BATzZXraHasRIrz4gf3uCwr7HjFqEwR22ukeSjW4zGOT34z6kOBDkBzQZ8S4WVH/+DpNQ7R1senNTWevIxr1l6tWw3IY2xaA5uU6hD8OqY3+0lHgf9Q5kA2fTkcrl6DnS8cvqMCxJfo9vmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsyH8dWV2Jo7IdOKi/obbsca8yYNgany7MMF9xVRZyI=;
 b=ja5IaB35AjLzeDXkZBKr1LJV83Zgx/l3PT6tW5ST2dI+6+PwescwUR4dQT8hhTu4TJ8znRFnZDMZw7isq607m9AZovZsbhWsktFUAGEXcr8IDaMCcv1OVE7fl/LmS46Am7E77cRY+MI/AvSD7LakKe20zsiywjwU2GwtFxMU+13HY2CN4H6kOqRfSxW1icpM3k/OXutmN4ZyBBj0/jEclWc8EQg8w8NTrv+VZTCh1LYgQiueQ8c0QkyZOoCz2sCLl4X+sshPdE2PCD8McU7wnPrEQ1eBDbhgQBINagA+8pe6rhB29++AKY6mvuulNpKUgoGfu9Ai2Iv2zmk5+bDxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsyH8dWV2Jo7IdOKi/obbsca8yYNgany7MMF9xVRZyI=;
 b=UH8DyL1QA83u036w7sadFHni84dIMQH5yvqIz+pVWkbwt0lW1wI94yau1nm1JUmLwtlzMrSKrSiDsJL/kfflAnLMuD/Zd6bfu7HWibpD2C1n7Iwnwp/2lUhRY0aZda/Nk5zja8HyceeZArBgdppA5JP9HPFXZaBNB/0LX0NIT44=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB2804.namprd13.prod.outlook.com (2603:10b6:408:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 15:47:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 15:47:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGAgAAYO4CAAsQQAIAAHRgAgAA//4CAAEjXgIAAwaaAgAAlW4CAAAwngIAAA42AgAALioCAAAXCAIAAAQ4A
Date:   Tue, 8 Feb 2022 15:47:46 +0000
Message-ID: <6c34f6721a11c426ac6f732aba37eb67c5b9dae1.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
         <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
         <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
         <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
         <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
         <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
         <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
         <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
         <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
         <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
         <6211BF2A-2A00-4E00-8647-57D829D41E8D@oracle.com>
         <6AB99AB0-A9A5-4000-BABD-8EFC34FC31D5@redhat.com>
         <50d04869ff78e2f59b78804f100f9127e3352496.camel@hammerspace.com>
In-Reply-To: <50d04869ff78e2f59b78804f100f9127e3352496.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93c58ad-9645-41db-0742-08d9eb1a59fb
x-ms-traffictypediagnostic: BN8PR13MB2804:EE_
x-microsoft-antispam-prvs: <BN8PR13MB2804DAB57887311552F9E451B82D9@BN8PR13MB2804.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Khn0kyF+nIxgLzQWkuUrKrE+a5SuX2i1MmvgPEj6nNWTiYiXySS4EkkBvUKZoCw7IlIDkhNd/j4Sd9fOknvnP6ZF/jKYmWLpvzVJcnAxIifuXtA4zvmuxOo8DvUGtA5pChc313et7OEgIAxyxChGs4Akb2bD0O+YC9L3zNRs8b6IOhHEqQP9kQvpuizIznn/rz+CEEMWKblUGacyQk0egFcFr8doHeBRTv/GG+RkDVMkp4b8VekTc6G39rRiOTA0IsLmqgLdPmExFHSY3vLZtbzIORcgefdUXwt/tzEKsEtpZY12oKuQQCTkPHJQF7NagX27/OuJV+jP6eYccbptP7QOT2Znu3WWMM4MrDpXZwdp+RKy2PzdoHXAzK6KDtUFOcwftdReBz9jxc/BqsRaaDGm3zttdKVM4dmG2+WIcbMXu9ufe3vgs8GWqot3maPXdue52Sl/Srxstyfm7VK92xKsIppBLLxBCn5HdKQeASkm5d3wWvPAjjyS8JfMnCVBeSNuPcYur1di0KIm5fUhGUrX3iYMly/47/HNOTcSccJcWBMddYq71I65KLSH1ct9ii8rhO+P25H31loPFAyamESlfucdkUd4M9Yk3Y48bRPXW0jXlRHCcOA7tKsZxfNXbkcGvJq1VckKVmBPfBvb/T02vsyDCDwlRTKoOgGtJJixrEhJ7qf/x/wW/3/nYVwDjSf2VE6uCKv7pKyIPFa91jiSGS/ntoWZtSD7LJB0vsCL8qoSTpTfFYaz3ZAuQGTS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(66476007)(66446008)(36756003)(122000001)(66556008)(8676002)(6486002)(53546011)(71200400001)(186003)(2616005)(110136005)(86362001)(76116006)(6506007)(2906002)(64756008)(5660300002)(4326008)(8936002)(66946007)(26005)(316002)(38070700005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2d0SkJYYVJmdklMK1AvTjE4TkFFa0NSazMxNWoyK0hYcjVsYjFlaU1Jd2c4?=
 =?utf-8?B?MjRjSUgvREFEbUZHL2RpYms3c0orM0ZqMWpob0xJWTVNM2dCb0ZLaDh4QkZ4?=
 =?utf-8?B?LzkyRzk1WnU1N3BrSHhOc1V6YmQvclk1UGl5RnhqY1phc3JudXNpaU5wRXpK?=
 =?utf-8?B?VUpFMVAvclJhcDJKUUJlejhBeG93Uk04M3NFT09hbUdlODh0dERoYkd0Qk8x?=
 =?utf-8?B?dFdIbjZyQmNpb25VeU1OcWcwTGU5aUlxa0pJZlM5ZEFBQ3dtQ1BIL3poczQy?=
 =?utf-8?B?cDNvakVIN0RyM09URGFsNGR6K2pnek5XY0ZVd3laVXcvM1VNRHRjbDFzUENP?=
 =?utf-8?B?ZTRHM24yTGFtbXdwUzJKRU0vSmUvQk1GOFZaYVVoSzBOUVRMbnFtV1dBM1Ry?=
 =?utf-8?B?RGFtcXF4VEpHVTVhSCtBSk1aYjI5S0xKTG5OQlNONGczZURkZ0dPb1dLeGJW?=
 =?utf-8?B?VXZyN2I4Uy8xbjZ4L0s0ejBpOHQzMlJyYVJyYzV0SVdXTXljOWUzdlF4Q0k1?=
 =?utf-8?B?eTBHWW5va2tibEEzVitTUGpPTVEzVmNNeHc1NERIVU41MHRmL0tSWWVBTFIx?=
 =?utf-8?B?ZTdpU3BOV2svVXJqNHRDRGN3dExwMHdSbnI4WWlzK0hrVDhLTmxNUUlTVUhk?=
 =?utf-8?B?eHZsWEJjOUd4WE1ZbFFSak1Zci84K0VHWUNQYzdkV09lRVZGUCtvSjF6b296?=
 =?utf-8?B?UWtlbXZqODVZVFRLOVlkbE5mNC9mWVpnRW10UUlCbTlYK0QxcW5qVzNPdFo2?=
 =?utf-8?B?VTZoSkJmSkpSZXVpYkpSOWgvdy84Y3Jnbzg5blJSd1hSeFlROVBkenhKL0xq?=
 =?utf-8?B?MGMrbnh5aW5ENjVacURqTHV5WE1ZRWJwWVFVdGNkMTZiQTlLdXRzMXVIaUFS?=
 =?utf-8?B?bnVFcW1NWTBZWGlRNHZiaC84Z1Jja2htVGN5ZGRyaW5yQ2RKMzRaQ01tYmND?=
 =?utf-8?B?dTlQTGw5OXNJUXoyVFVwQWtwanlSTlJwb3dWQzVVdFVOT2xiemQxQzJoRGZk?=
 =?utf-8?B?cG5qc2xHR3NhRkpDQkY5Y25VL1JMQVlUY1ZWaGZCU3p0NkQ5cGlzM1R3UUFP?=
 =?utf-8?B?RUhJaEdBYWsyQnZtVkFwSDB2U0JyN015d3gxT0xPK2w5QVI2NTczM3B6N1Bi?=
 =?utf-8?B?M3pFK080RXNqeXJkSEgxTEhHNlFWa09QUE81cWVmTU02MWN5VGwrVDNOR2Rp?=
 =?utf-8?B?UXBUUklzNlJmUWtlV285RE9WVjY3YkRCVFFpbTl5MTRaMUFvN1V4WmpZMDNS?=
 =?utf-8?B?STJXOHBjVGl4WjZlNit6T2dPOW9xQXk5a1VmQ001dXIwcXRLUlNQditUS055?=
 =?utf-8?B?RkJmWThlYmQwUnMyUGtKaDlkendEVzEwTit2QVpqbmgvVU5RenFkY1FaODBQ?=
 =?utf-8?B?ZzJQTjVHdUMyYlNCSnJidmlXczI5THFndFc2NENHRHRXUG5sQnNpTDNaRVB3?=
 =?utf-8?B?aGlZRFA0RWpsSlZWd1Y1MFovMFhXZG50RXZQWi9oeDk3UEFhZTdXcXo4cWZF?=
 =?utf-8?B?Wis3Q3RCNGI3L0VOaFhIbjkwbVBJMkxtSUV6bDVBL0xjWDUzMVdYanU2UElD?=
 =?utf-8?B?eGlpdjlkQ0xHc2VYS081NnQ4MzQwUVJxaUtUeko3VmNyWEMza1R3MkdzaUFB?=
 =?utf-8?B?ZmhTRUV3S1F1TFdaVmRmVG83SHhRWU9KNGlWcklFM0hCaGp6UlpmNmpFK1or?=
 =?utf-8?B?aCtGbnBPS3hTV0FEQVBQNWRBeHFZUjZ1U2FqQVI0ZUJvOU5ueCtxNnhSZkdH?=
 =?utf-8?B?WXhkUndnc3JBNnpMWFBneFhmZ3NIWjdtc2gxblBIL0wzL2hNZGE3MXRpRFZ4?=
 =?utf-8?B?L2NxclA2dUZaMThlYWJ1TmlMQ1lKbzQ2b2ZOMmZpc1MxREZaaE4xZWxmaHBh?=
 =?utf-8?B?LzVoL1JuQmZGVks2amVzek40NGs1QjJsUEdzRlU1d0RQQVkreURDeUhFb3Bp?=
 =?utf-8?B?K3ZFbzZtYmpwRTlJeEY2WWRiQnUyWDI0VE90eUVjaStZbGt1RUJPeVllc3Y4?=
 =?utf-8?B?SmczRThnaWpEV2hZc2dXNHJ3KzNmaU1YVDdWVXpLREhkWXNVeFJxQW1OVXlO?=
 =?utf-8?B?SXlsNGh2TDIzNXp5enhXVGJHaHVZeDRjU05EV1BHZDhYSGNUUkxGSW1UVTdi?=
 =?utf-8?B?SmphWEh4M2JEamQ3N0x0NlJ3UmV6S0JmdHFpQlI3eTBjdlVlVDRjWnlwYStx?=
 =?utf-8?Q?ZG6PsPzFlS2O/joWcUw9dkU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26824E09A995774090F6F2C3FC0CCEE3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93c58ad-9645-41db-0742-08d9eb1a59fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 15:47:46.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXCic5T8ceycBs7yYduVHIhkFYpljBgjmpJEjIA5G+zotJoceNVCIrRyxMVxu1d/USt3qzCWYXJxWg82j8wKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDE1OjQzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMi0wMi0wOCBhdCAxMDoyMyAtMDUwMCwgQmVuamFtaW4gQ29kZGluZ3Rv
biB3cm90ZToNCj4gPiBPbiA4IEZlYiAyMDIyLCBhdCA5OjQyLCBDaHVjayBMZXZlciBJSUkgd3Jv
dGU6DQo+ID4gDQo+ID4gPiA+IE9uIEZlYiA4LCAyMDIyLCBhdCA5OjI5IEFNLCBCZW5qYW1pbiBD
b2RkaW5ndG9uDQo+ID4gPiA+IDxiY29kZGluZ0ByZWRoYXQuY29tPiANCj4gPiA+ID4gd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiA4IEZlYiAyMDIyLCBhdCA4OjQ1LCBUcm9uZCBNeWtsZWJ1
c3Qgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ2FuJ3Qgd2UganVzdCB1bmlxdWlmeSB0
aGUgbmFtZXNwYWNlZCBORlMgY2xpZW50IG91cnNlbHZlcywNCj4gPiA+ID4gPiA+IHdoaWxlDQo+
ID4gPiA+ID4gPiBzdGlsbA0KPiA+ID4gPiA+ID4gZXhwb3NpbmcgL3N5cy9mcy9uZnMvbmV0L25m
c19jbGllbnQvaWRlbnRpZmllciB3aXRoaW4gdGhlIA0KPiA+ID4gPiA+ID4gbmFtZXNwYWNlPw0K
PiA+ID4gPiA+ID4gVGhhdA0KPiA+ID4gPiA+ID4gd2F5IGlmIHNvbWVvbmUgd2FudCB0byBydW4g
dWRldiBvciB1c2UgdGhlaXIgb3duIG1ldGhvZCBvZiANCj4gPiA+ID4gPiA+IHBlcnNpc3RlbnQN
Cj4gPiA+ID4gPiA+IGlkDQo+ID4gPiA+ID4gPiBpdHMgYXZhaWxhYmxlIHRvIHRoZW0gd2l0aGlu
IHRoZSBjb250YWluZXIgc28gdGhleSBjYW4uwqANCj4gPiA+ID4gPiA+IFRoZW4NCj4gPiA+ID4g
PiA+IHdlIA0KPiA+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gPiBtb3ZlDQo+ID4gPiA+ID4gPiBm
b3J3YXJkIGJlY2F1c2UgdGhlIHByb2JsZW0gb2YgZGlzdGluZ3Vpc2hpbmcgY2xpZW50cw0KPiA+
ID4gPiA+ID4gYmV0d2Vlbg0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBob3N0DQo+ID4g
PiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+IG5ldG5zIGlzIGF1dG9tYWdpY2FsbHkgc29sdmVkLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYXQgY291bGQgYmUgZG9uZS4NCj4gPiA+ID4gDQo+ID4g
PiA+IE9rLCBJJ20gZXllYmFsbGluZyBhIHNoYTEgb2YgdGhlIGluaXQgbmFtZXNwYWNlIHVuaXF1
aWZpZXIgYW5kDQo+ID4gPiA+IHBlZXJuZXQyaWRfYWxsb2MobmV3X25ldCwgaW5pdF9uZXQpLi4g
YnV0IG1lYW5zIHRoZSBORlMgY2xpZW50DQo+ID4gPiA+IHdvdWxkIA0KPiA+ID4gPiBncm93IGEN
Cj4gPiA+ID4gZGVwZW5kZW5jeSBvbiBDUllQVE8gYW5kIENSWVBUT19TSEExLg0KPiA+ID4gDQo+
ID4gPiBPciB5b3UgY291bGQgdXNlIHNpcGhhc2ggaW5zdGVhZCBvZiBTSEEtMS4NCj4gPiA+IA0K
PiA+ID4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgYmUgYWRkaW5nIGFueSBtb3JlIFNIQS0xIHRv
IHRoZSBrZXJuZWwgLS0NCj4gPiA+IGl0J3MgZGVwcmVjYXRlZCBmb3IgZ29vZCByZWFzb25zLg0K
PiA+IA0KPiA+IFRoYW5rcyEgU2lwaGFzaCBpcyBuaWNlciB0b28uwqAgOikNCj4gPiANCj4gPiAN
Cj4gDQo+IHBlZXJuZXQyaWRfYWxsb2MoKSBpcyBub3QgZGVzaWduZWQgZm9yIHRoaXMuIEl0IGFw
cGVhcnMgdG8gdXNlDQo+IGlkcl9hbGxvYygpLCB3aGljaCBtZWFucyBpdCB3aWxsIHJldXNlIHZh
bHVlcyBmcmVxdWVudGx5Lg0KPiANCg0KRnVydGhlcm1vcmUsIHRoYXQgd291bGQgaW50cm9kdWNl
IGEgZGVwZW5kZW5jeSBvbiB0aGUgaW5pdCBuYW1lc3BhY2UNCmlkZW50aWZpZXIgYmVpbmcgdW5p
cXVlLCB3aGljaCBwcmVjbHVkZXMgaXRzIHVzZSBmb3IgaW5pdGlhbGlzaW5nIHNhaWQNCmluaXQg
bmFtZXNwYWNlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
