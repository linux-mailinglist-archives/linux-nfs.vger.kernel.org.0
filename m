Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4496611CC9
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ1V5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJ1V5W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 17:57:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841124CC83;
        Fri, 28 Oct 2022 14:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqQAqGQwMCWxtDMlDdtZjYuwsoKvnmiGmBh7dGePPFf+gLQ/AQAcHS4SF5+bPBxyPnSX7eo2GwujunSrjGyBmSRl1DVnUrpXUdGVhSIn/lW8MgbaU10u3oNs/hYqYxIsSyA8lA4M8NpZ1a0XMrTSjFJfd7ma6FC0+GrV8Cny64EZN5UA12TFPuKOr7xhsRuKOaJ0VS/yF/bax+yiZGe7WmqxIMgxrcprjTsW2LRlww1vk1Tk3j+5ZZSaE31KwFQswky46VzpmgWn1feexEEobjRSf/Jhm27asnNRlufaU7MFNRp2bn6Dshrun5RTwq1Gdvxg9QDIJbpgXOULrPSwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b67413MiIw6Azj9zRtN0D/cz0+bT2Knb8AE10aKxj+0=;
 b=em0tBWij9ik7DziJ3lPXi/cSn3JET5/FYqh0ALbXxXtTqAY1RaXZnORP2jHQiIMrhsOl3pw7op0n1Ua5ZTGeML4DgLrPksus9wsdfFP+AFqqslgM8rj5+PzvFPKQlQvBGWhsUkNrglQ/eStlbKEl7BX/OyH3net5GjpPIRL35Sb1b7EvsBCoSZqOlpnEgIIuotho5+e6GZTbqlV4fw9RLmeAmlAVE7Gx/AYYXjcuEGneDx5wCOADhUrPWHxeo1MMsNBcdgdM5CvqBM1Yer/zhgi5JXR/xy4/m0gpvU0bD2dPfAuU06DsevCJcyT2D2SfSW/Lybwnkj9O/xzHhCB+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b67413MiIw6Azj9zRtN0D/cz0+bT2Knb8AE10aKxj+0=;
 b=SYpJNoVXUzeIHUw6Y7MzDCnLFgJVfss99uuuHXrjm2aXZ9I4yCN5wnlKsUT7o27fRsF3/QLt2jT3TD2kmL5qWa+dZ8d4Yw35BQ6uU50tj5an78rXWDzMxaJTduvDzwIoYQlttwq4edoY1pYoaMfe6ZS1kcT6qDJ4Gv5/vk4GtFM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5301.namprd13.prod.outlook.com (2603:10b6:a03:3d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Fri, 28 Oct
 2022 21:57:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.009; Fri, 28 Oct 2022
 21:57:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna Schumaker <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Thread-Topic: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Thread-Index: AQHY6v4TOWSLEQmUbESsXe/9l99ZN64kPS2AgAAKTACAABL4AA==
Date:   Fri, 28 Oct 2022 21:57:14 +0000
Message-ID: <4E1D385D-2116-495C-80A3-9EB02FECA786@hammerspace.com>
References: <20221027150525.753064657@goodmis.org>
 <20221028145005.28bc324d@gandalf.local.home>
 <A016D74D-CDFC-4CAB-9AE4-C1688C9A49A1@hammerspace.com>
 <20221028164910.6804a855@gandalf.local.home>
In-Reply-To: <20221028164910.6804a855@gandalf.local.home>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5301:EE_
x-ms-office365-filtering-correlation-id: fd6f37be-ea64-4f5d-b681-08dab92f5fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0hv/rD+VO7zkiuE4ccftkdmBYbG45fscL74y+W4hgEh/KGuhznkg1B4YvXfIIlM5PiPGSOL6X7qyHxrwkq0vyNlvjeEw/gNrjj2rvRZtToyoVvG0ztDbp9vm49KpulY3/os9/+hTCSzpGel3FDSULs2qnlyaxc5qNYW3J3SWmPdmOpKIiFEt1/5EheBYlBhpO2RFRpggn1RM1Rl3PULPqcELp0fh8FiDJUwLfOEUe1vGzjzaqXYfljFZiNiHFf5w2PD1no36ZagZCSVAxxRCDg/orIHt/u7BJe+sZHToAiGGhRD4JI2v+x1RMUjI4Xj/E5MpWVWgDPY/nXW8fU4URH28++9WC6JyCLC2PPzvybIeRFNzNnRvMENo4hegoQ0pwtGcVokO5Xl+uXJpxKn+xnlaP8u5Jb8+q8F3XYo/hEelv+xHYPkDQTLOenC0Tj08d1n5n7sL7DoZvZ9D75dwaL9wyjnbaVorViSZw2q3Ar7GUi01QZrwnvuGmwzMDH6vKk6+BEKZ7bOuuJM0BaGEYSDSmjjcRCgUCcTlEPlt+4Ci2cSIRUgZseu6X2iYL8AqvIObUyMzD3HgvVWMcusa8Vh91D9PXfVQA/044kZO7L0BGR3cSX14g8T3djh1QjKQO+CBLAptfbFC+rmwbKWr88UCCwHHYlWPzW9WcpLOGvNb2Ljm7TaAWkR1ThhIXrnTq1hbThi2G7Cbbw8s8EMI1T9OPBZCjYLE5aocwQtVxyq0tjLkAbpwtQvotxwMGdaDdzAG/l8p/OjnFU8FnLhu0J5cJ0ElJDSHOyzeMRsbtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39840400004)(346002)(136003)(376002)(366004)(451199015)(38070700005)(2616005)(33656002)(26005)(6512007)(5660300002)(6486002)(478600001)(38100700002)(36756003)(71200400001)(6506007)(53546011)(122000001)(8676002)(66556008)(8936002)(41300700001)(4326008)(76116006)(66946007)(66476007)(66446008)(64756008)(6916009)(54906003)(86362001)(316002)(186003)(2906002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFFlaFo1aHh4eEpiQlM0NXdodGYwTzZmMWxkbk0rSjgyWTNXN05SZUxJcGxF?=
 =?utf-8?B?S3c1MSt3ZWRlc0xVMnlhdXM1RGppWmFha1FrUDhlbXF1QWJuaVJyL2N2QkNO?=
 =?utf-8?B?akJRYmlzZTJtSzhCdU14M1lMSDI3Wkk3Tk0rSGdhVnNXS2xHam1NeEdqRUZ2?=
 =?utf-8?B?NTZ0NWYxaTRLd2dTak5TWnZ3Znh2YzdNUU82TlFXcEpmTXZCeGdnanNaNDll?=
 =?utf-8?B?eTJMSWkvZ05KZ2RGUmZlZDNsR0JmZkM3dXpQcm55MmNUQnpOU0F1bGU5VzVC?=
 =?utf-8?B?VWs1WXRGTXMvQ0hNYTYyZFRIWWxMOW5kQzF1RUVoaURQbDhaRVh6TkRnRHkr?=
 =?utf-8?B?MHRuMzlOaDNnTDZxeWtCdzNkZXVnbkdJb2orUFA2clQxZWh1dlRodXZSMzJS?=
 =?utf-8?B?aUIzejRWR1ViN213N3dud2xrWTBIWE9SQ3hBakFyU3RmS2Fpc25UZzZHd3c0?=
 =?utf-8?B?Y3BXOWRTcDNTZzNJbUp4bSsrbmxGeVhEalQzNkJUNGdlOHVGc0ljcW9BTSty?=
 =?utf-8?B?eVd4bFp1dmx5RVVySGgyUGgvRnpIUHpMNERwU0ZPS0N4enJJSVpIOUFVVE01?=
 =?utf-8?B?eG1nbG55cE84N1ZrWm8wUm5IU3gvMlU3VStkT0Q5ZUt6dU1NOWRKNXFoR0JT?=
 =?utf-8?B?K3RRRTAycXF0QzA1QVpTRlY0bmgwb2xVYjlhbXRxTGVHbUJCM1Bza1A3b3JJ?=
 =?utf-8?B?QUk0TFNjSEFLczdaditQUFMwS1JYaHNtNld1Q0RoOHRleW1rVU9RR2YxL2d1?=
 =?utf-8?B?ejE0dGZXWXAycDVGSHErLytkd1YxVTAvd29UTUtoVTNoaWxmbjNGcTJwbnRR?=
 =?utf-8?B?Vng1dXFVc2NQazRWRnQ4Z2pES2dVZE15ODgveWFOek96UVBFRXJMMHkyTmJM?=
 =?utf-8?B?NTJxV2ErVEZiby95aEd4TVF2Unh0N1U4VXk4dHFzM1hXNnViK3pyWmRoN3oy?=
 =?utf-8?B?dlR0dTJrak02akZjUXhvT3ZMdmQ3MndPL3kxRE5nRUlHdGNEdkVwTVhETlV0?=
 =?utf-8?B?Ym9lRUF3SlFBWkc0aGlyWjJNZDh4ZTBEQVhXeVMvaTRpRlBjTXZBM1dDRlAy?=
 =?utf-8?B?MjJqN2J3bXoxeHBQdzBBbm9aWW9IU2pWZHdKTFIvZERzSVlIcStEK1lHdmJm?=
 =?utf-8?B?TmdrYVVRenpyVlJ3K2ZKMkRnSURiQUFxcld3cUFwRnljVXVocE1yTmZEZkVV?=
 =?utf-8?B?b1JDQzY4ZmpBUE5oL2R6NVdUK29Sdzc0Szh2eFZmOVZSU05qRU5KUlUxemJP?=
 =?utf-8?B?emhmMU1IWDAyNldhUU1aNVowTVZGS1hUODNVd1ZYZkVOakllakV0dk5vSEht?=
 =?utf-8?B?Zk5DU2dhK2F6Q091MVhJSHFkL3IrY0ZWTXlQQkVDaEl0V1psWFdJeXdjZ0kz?=
 =?utf-8?B?Rm5mV2RKd3Z3OWxGRS8ybGJYYk1aOWt2Y2JlN2JVWllvTFd2eXMrOUZYV0xh?=
 =?utf-8?B?eDkzTlZLZVBYZUt6VUdLQWM4eTh2cDM5WSs5NThzenNRZ0FYdS9iV0M2UGhn?=
 =?utf-8?B?b01GS0hLL3FhcE5RK2MxOER0M0JvYjdSY2hEd205TmFOV2xNdFlPcWU5S1Jv?=
 =?utf-8?B?WlVyRlh3YTMwRkxFd25nZklBYnBlaEZZLzJuWmFYUmJuOHNMYjBGTFRiblZt?=
 =?utf-8?B?TXZTTHFKYyt5OXBtWlRQRnhzaElvdFpmWWxKK09DcEFsSXRkWVFIcTlydUdU?=
 =?utf-8?B?bXkzVEFEcUg4VlNOZS96UEM3WCt4aVV3Tk5MVGJCN0FZb0RwNmllaUlRVER4?=
 =?utf-8?B?Q3BaU0l4cmJUTExBdjJtQWFjYnV3UkFOckoyaDcrSk9odE9Pdk95Z0JsRWZz?=
 =?utf-8?B?dEtjZUVOYXFtMVZ6d0FJZ1djNjU3UFBKUE1US2dzTU15MUVmOHZRN1ExZjUv?=
 =?utf-8?B?T1ByTjVOdTBBMUFiTEVnbFVVYTM3NEhXT1h6QzhHWjBuOXpIdTNTbktBSzlw?=
 =?utf-8?B?RTh2WXRnajFPMWxBTmNkZnRzTmM5Mlo5SEx4REttOUd1THhTRjYvbmRIVE15?=
 =?utf-8?B?ODBUdDdWTXBCa3FwdUgvRVpmQ0lHV2M0SEFKTnE5c0JUOUJRQXpDZ1dlcUNh?=
 =?utf-8?B?cStFVm5ISWkzNnZuM2dJV0RQb3F0c2tFWGhaemgzdEMwdG5XQ3pySVpWTGMz?=
 =?utf-8?B?MGNKQ0FvVzZxZk9hL2ZKZ3FZdVhVblovTlZ5dnFoWjQwRnhQZXBMNXlMR0pp?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <224E131A46EEB64AB0B295F48466ACFA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6f37be-ea64-4f5d-b681-08dab92f5fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 21:57:14.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oreqa8VMY64BpXhid2V84htXDTVHp5JsFeHs5/WEZ1uXLKWvAKvNQgzHje+jlQxjvFV5d9KWmAG/g1hvJPS8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gT2N0IDI4LCAyMDIyLCBhdCAxNjo0OSwgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyOCBPY3QgMjAyMiAyMDoxMjozMCAr
MDAwMA0KPiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToN
Cj4gDQo+PiBJIHNlZW0gdG8gdmFndWVseSByZW1lbWJlciB0aGF0IGF0IHRoZSB0aW1lLCBkZWxf
dGltZXJfc3luYygpIHdvdWxkIGxvb3ANCj4+IGluIG9yZGVyIHRvIGNhdGNoIHJlLWFybWluZyB0
aW1lcnMsIHdoZXJlYXMgZGVsX3NpbmdsZXNob3RfdGltZXJfc3luYygpDQo+PiB3b3VsZCBub3Qs
IGhlbmNlIHRoZSBjb21taXQgbWVzc2FnZS4gVGhlIGV4cGVjdGF0aW9uIGZvcg0KPj4gZGVsX3Np
bmdsZXNob3RfdGltZXJfc3luYygpIHdhcyBzaW1wbHkgdGhhdCB0aGUgY2FsbGVyIHdvdWxkIGVu
c3VyZQ0KPj4gc2FmZXR5IGFnYWluc3QgcmUtYXJtaW5nLCB3aGljaCB3YXMgaW5kZWVkIHRoZSBj
YXNlIGZvciB0aGlzIGNvZGUuDQo+IA0KPiBXZWxsLCB0aGF0IGV4cGVjdGF0aW9uIGRpZG4ndCBs
YXN0IGxvbmcuIFlvdXIgY29tbWl0IHdhcyBhZGRlZCBvbiBKdW5lIDIyLA0KPiAyMDA1LiBUaGVu
IG9uIEp1bmUgMjMsIDIwMDUgKHRoZSBuZXh0IGRheSEpIHRoaXMgaGFwcGVuZWQ6DQo+IA0KPiAN
Cj4gNTVjODg4ZDZkMDlhMCAoInRpbWVycyBmaXhlcy9pbXByb3ZlbWVudHMiKQ0KPiANCj4gV2hp
Y2ggaGFzOg0KPiANCj4gQEAgLTg5LDEyICs3NywxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYWRk
X3RpbWVyKHN0cnVjdCB0aW1lcl9saXN0ICogdGltZXIpDQo+IA0KPiAjaWZkZWYgQ09ORklHX1NN
UA0KPiAgIGV4dGVybiBpbnQgZGVsX3RpbWVyX3N5bmMoc3RydWN0IHRpbWVyX2xpc3QgKnRpbWVy
KTsNCj4gLSAgZXh0ZXJuIGludCBkZWxfc2luZ2xlc2hvdF90aW1lcl9zeW5jKHN0cnVjdCB0aW1l
cl9saXN0ICp0aW1lcik7DQo+ICNlbHNlDQo+ICMgZGVmaW5lIGRlbF90aW1lcl9zeW5jKHQpIGRl
bF90aW1lcih0KQ0KPiAtIyBkZWZpbmUgZGVsX3NpbmdsZXNob3RfdGltZXJfc3luYyh0KSBkZWxf
dGltZXIodCkNCj4gI2VuZGlmDQo+IA0KPiArI2RlZmluZSBkZWxfc2luZ2xlc2hvdF90aW1lcl9z
eW5jKHQpIGRlbF90aW1lcl9zeW5jKHQpDQo+ICsNCj4gDQo+IA0KPiBTbyBtdWNoIG9yIGVmZmlj
aWVuY3khIDotKQ0KPiANCj4gSSBndWVzcyBjb252ZXJ0aW5nIGl0IGJhY2sgdG8gZGVsX3RpbWVy
X3N5bmMoKSBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8NCj4gcmVnYXJkbGVzcyBvZiB0aGlzIHBh
dGNoIHNlcmllcy4gSSdsbCBzZW5kIHlvdSBhIHBhdGNoLg0KPiANCj4gLS0gU3RldmUNCg0KV2Xi
gJlyZSBhbGwgbW92aW5nIGEgbG90IHNsb3dlciBub3csIDE3IHllYXJzIGxhdGVyLi4uDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg==
