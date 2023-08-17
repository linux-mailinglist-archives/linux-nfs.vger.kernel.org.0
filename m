Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FE77EEF2
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 04:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHQCKE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 22:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347640AbjHQCJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 22:09:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63402D71
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 19:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu88XU6D/NJOfMVn8qDm9P9vJMadS4jiq6Cn/vcXrGzT0EWkodPOoqrDdzWEnGLlFaxGKSnl7ZFVvwPe7Y2Exwq0ZEO36eZaDN16Uw/CRXFd1FyKXjvmWX1g130Jah5EJUa3iKF3U3Kikh860xYicWKKt1FYf2G4GFKKVWPCfGg6VSfsw3Owu4QhCPIqpWxcIO952AToxNpWkq7qciiCOXTFSN45mCmeKMn6P86r+5/b0BIqDeRrriPLwglhMxLEDwXc4cOHgKrZ89MTDEx9u3q76H/YZP0qAtrSsWZ3jcTt5xk8Lp/+ghYNXY4ydRqjzgdOaIGw06hTHgMKCiMCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/PdiL7aLuGh2Y0PnRQASn3UgoMnirqUkzLHCJWVsPo=;
 b=eurSVu5GaOozDtE6COn6I1bLeT9w4J2lc4Dik0wKEi4yZCDV3bCC7Y+IxvwVnV8ecNGGjPGOPs2zBzDIhqXpWYhxhHbCP1Ou1TstuaxeYgYXFkaDls+9cwYFzoBBs5I6l1JhGNMlRkguVm+WeWFQJ3IzDizUg37EL+KgLHF2YwJg6GLfT45JolO5Io1iZH5GBmuFvc8Q5kEZYK7pvMFp8EJgGbbz3117Nujlyq5fvisyhwnZ6T8hzWWdAcwXW0HHdjtyETq/wUmpSL64Hgru0b6Zq3DVkKpuEFDkBMyFd0Kw4hSKulgF8nHl9p6xGtLWGVaqYNLVigfFU67sFy2zZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/PdiL7aLuGh2Y0PnRQASn3UgoMnirqUkzLHCJWVsPo=;
 b=HyF4heuz9nJjw3XfjOh2SPabNpZVA9xlJJ7qiD7kcR1aBOAGaNexDhBgDXPLfirWc0IxaUkV3WEr7l2OxJw73ij3jhHDdzX7tRAzjiTq/cA6PQHpHx5akj8lF+rdu6RxJtmgVI5/ckUdwSFLBcWXpVreRODam87rThfhx60/3uE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM8PR13MB5190.namprd13.prod.outlook.com (2603:10b6:8:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 02:09:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 02:09:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "jrife@google.com" <jrife@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Topic: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Index: AQHZ0K0ihqQBjpr9f0S0sDLmPXicF6/tvlaA
Date:   Thu, 17 Aug 2023 02:09:27 +0000
Message-ID: <96353f2cafa6e06cac240aeaab47a1eac177b07a.camel@hammerspace.com>
References: <20230817014808.3494465-2-jrife@google.com>
In-Reply-To: <20230817014808.3494465-2-jrife@google.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM8PR13MB5190:EE_
x-ms-office365-filtering-correlation-id: 8730ae92-bab1-41a4-83b8-08db9ec6fc38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bCMHmSIQQANztJXnvQTbbHJ0iF5JA9Qr6KwNANuY2nX2LoKutbTYc0KwTUuoKFhkzybQ3De4MkSFZmoXn6xSsHFjLP/0HdYdxxsaNUwct4qA8lIHSb/1gWqtO0zVqqitktyeJElqZEbzgjxuSJNTnAFPUadUYJrcwTLFvYPU5V9Q+o+e/cUtg4KMOD/TIsfIIbRTYDSGgnQz9pUGVWOd7fAQs+YbjiaV5S3cAPuOKgXzQd3QI0b5QON5LeLUFln2HCrwv0oUooV4VnY7Z1TX0Wf0T3F/Lup86ATv9RhmoR2LZp8iAZQcIepIxSyXqIGhMyZZHWZ7IN9USQEj1K8HWHudUDbNN0pQmMrdDDPxA2VePzhR0DwFZMhhYX4Zd5ljlS8UBQIL9fKDFE9UGRXhh6EwZ1XkAH/T0u0ybCdN6NkuqqgtMHDhGtvz6/0NomaWzoaQplfzIOFCT3FEmEPhhT1UDl7jDCS0tuAAExkn61Fy67WeX9itqolsfQSzwINOBhiSZDfRqlBcnhivnJ8QVsj8s9DxeaR08OdgwYBAUKLXDBxL1uHPSzOtTjAGfFLpjNL0xzt8EtqYAFudHY3Q5pA7BlgeWrdvh7tvZ4orr9/Z1rfu92GAAimWS2W4pVtYQ8Gg3zSHtVbopGp7jqUA72pJDl4EVYW4WPtFbffsmoLpC8VJW7K+DSYqkU3qdF31Co9vca+JGI41ZFVH/kW4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39850400004)(396003)(451199024)(186009)(1800799009)(38070700005)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(110136005)(76116006)(478600001)(966005)(122000001)(4744005)(2906002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(6512007)(6486002)(71200400001)(6506007)(26005)(2616005)(86362001)(36756003)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3kyYUQ1RTNKK245akY4cGV2ZGdVOUlpYkZ3OVlWa0ZkV3A0ODREd0xOdWQ5?=
 =?utf-8?B?YVI3b2tlejEwb1Z0UzNQYk1ubE4zTGJZZEd3V0xpSElLOStFa1pkTDJGYjdV?=
 =?utf-8?B?dXYxSWs0bHVoTm80RlE3N0tWRWRNYmMzbmhwc2VkN2RSZUZJVUt2Y3hLLzlX?=
 =?utf-8?B?US9lV0wveVFabzRrVmIrTHNKWDdLN1p1NUh4M3ZlenpJcnNBMDhsSDhKRjAy?=
 =?utf-8?B?OFc0NlhiMk9yaTVFWlUrT0s2M0NuczE5WnhRQnVTRmI0NldBZEluSDZTQjM0?=
 =?utf-8?B?OGpnc1BvT24zTGJXOFo0NHhRbWc1WGsrQjB3ZEI3dUtrOEVLdVlYdFhJY01Z?=
 =?utf-8?B?eXpsRGlWZlovcHlhbEJ6K0NTa1l5MlRrdVBUVGY5NHVCL0ZFcFR3VytHNzVQ?=
 =?utf-8?B?YWxRNWUrU2prbkFoSDloNS9sL3gwR1VMNmJzNWhhSmlILzNzTnVEMjI1OG9C?=
 =?utf-8?B?Rk1SMDRUb2Z4UDl6aWF2dmxnMmZuMUN1T093d3NWbC9xZHNVTUs5c01MQVNo?=
 =?utf-8?B?aGhDMGZ6S2c1dTY4Y1FxSVFSaGNsVVJodXd1QVlVWXpyWTMrUEM2Umthd05G?=
 =?utf-8?B?OVMyL0phYTN1MnhZVk5QU3g5cXRuSDFHQ0pkTlNWdXlyRFZwMWU2NVdQdGJ0?=
 =?utf-8?B?Vkh6clA4SHFLS2Jwb0NnNGpiWWljV3hqMjJOLy9ZaC80QUdPaE9rVm5RdHBB?=
 =?utf-8?B?cnNnYkdUWFBxbG51MlpCaEx2VTZtVHZwZFVVdDBsS0lGU2pCejBvNmFZTnpm?=
 =?utf-8?B?OFZGRnE1ZXVzMTN2dWdNQkxYY2JGYVozVUQ5THZwZVF4M3pyYy9KNzF0MEhB?=
 =?utf-8?B?ZVFGSDFZMVI2eHlRYlVuOWVSRzh1c3l0OW56THJraWdaZWZZRkJ0cWJMSmRC?=
 =?utf-8?B?S2Y5YjNRNTljRHJ0ZE42dFRLWml2bGgzdzFNcGRITVJ1emYvbkhZbUVmTkJa?=
 =?utf-8?B?eHpiSk9RU1RaT3Z1bllSS3I1RG8yOGd6Qm5jN1FIV2M2VjU4bDJRZS9xV0Ro?=
 =?utf-8?B?NTIzVi9iUmgvQ0RkYld0bUZ6N2ZqSHp3b3VHZkI3VUVURnR4TFZLZW1Hd1BZ?=
 =?utf-8?B?TDBSd0tFQWtjZjZqMGpTZWtYQk9hUVFhc043dkg0OE95K3JTaGhBU1QvWFA1?=
 =?utf-8?B?c2EyVm9HQllNdHJ1VDZtZ2huSDJHN1BGVHM1V3dXU3Q0eGFQakhVS0dxNkxX?=
 =?utf-8?B?ZEI2dC9RSXNEY3FtMldpYzA2eFU5UmFvOEZ6WmVDcEZEOXZOTHBhbEROdkdI?=
 =?utf-8?B?Sm9ZblNzZUVVZUttNWI4MFBUckpqemU5b096UUk5Y1lEZkV3RmxEb0IwWEFl?=
 =?utf-8?B?SXpETDdNYlpVRTVvOFNMU0Rrem9QOTdCOXcwKzhydXdHcUxMS0ovdVhVSWNQ?=
 =?utf-8?B?YUpoY3Z2MVNXN25LdnNDOGdBbi93TUR2TFdJQWxLUTA1eUdMM1VyaUpJdWx4?=
 =?utf-8?B?a1JFeUdKRldRK0Zxem9HNThHUk9UNzFibHpFWTlCRzJablBIdjdGOE1Cd0lm?=
 =?utf-8?B?Wlpabk41bHU4YTNQNUo1T0M1VVptTWs1S1BnRmFhZTQ3Skx3Zml6citmSUh0?=
 =?utf-8?B?Zmh3ZDZ0UFFrMWJDWERUTDd6RUluSUZKdnE2YWwveXNqRDNNMzhtM09YVzE2?=
 =?utf-8?B?SzAvM2lFUmFsQzVsTDFnK3NEZ0szSVVWaEs5czltb0dRbis0RDBNOGkrOHZE?=
 =?utf-8?B?djFFSy9FY2tqU0VqQW9hZHZGU2hQQ2Z3VE94azZjZWZqWlZoMnhHOVpNSkVs?=
 =?utf-8?B?aVA0ZmtVVE5weFJhbE55aE1FYXM1RS80SmV0cEJTOXRiM3lrakpOYXFMYTU4?=
 =?utf-8?B?NTFqVGpsaWF6V3FrOXViQmEzdGJQbmtGWTkzeHBMWU9YTms5dDVkeXVkZFBt?=
 =?utf-8?B?a09KR0s3RjkrR0Njc0xnc2I3MEtUd0c4SWZZcUhpVVB1MUp4Z1U5SzFOTEI0?=
 =?utf-8?B?clNEQU5JVjBmNk9rMnY2WlpLeDdEL2ppWGtkWXBGcmx6NjN4dnVLeUczUVh6?=
 =?utf-8?B?R2VCbU1hL0dSa1J0aU1TVW5IamZjYTZkZEVFUmkvUFEwVEdXU0F3bkdQdUVj?=
 =?utf-8?B?SGo4cTF2UlU5MUkwQ2xZb0k4L3R5eWZHQTZzNUF2ZURHeFM2M1FaWDkvcGsy?=
 =?utf-8?B?RERzb0lEWXU2ZWJuM3NWNGhNamZSOTNRTW8wRkFlWEkwSWk1VzNTbDJSM1Nm?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4CA9164DE0B1B4D8828D0B0D1E2BF1B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8730ae92-bab1-41a4-83b8-08db9ec6fc38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 02:09:27.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKPYIpIWgQk3c7dzzXaQ97a2OvPDRqu9JEEe8LsoJ25g7UprBGDd+uEHin2lM0U5veRxyz/uyGB2Zryp86qdFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTE2IGF0IDIwOjQ4IC0wNTAwLCBKb3JkYW4gUmlmZSB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqcmlmZUBnb29nbGUuY29tLiBMZWFybiB3
aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBrZXJuZWxfY29ubmVjdCgpIHdpbGwgbW9kaWZ5IHRo
ZSBycGNfeHBydCBzb2NrZXQgYWRkcmVzcyBpbiBjb250ZXh0cw0KPiB3aGVyZSBlQlBGIHByb2dy
YW1zIHBlcmZvcm0gTkFUIGluc3RlYWQgb2YgaXB0YWJsZXMuIEluIHRoZXNlDQo+IGNvbnRleHRz
LA0KPiBpdCBpcyBjb21tb24gZm9yIGFuIE5GUyBtb3VudCB0byBiZSBtb3VudGVkIHRvIGJlIGEg
c3RhdGljIHZpcnR1YWwgSVANCj4gd2hpbGUgdGhlIHNlcnZlciBoYXMgYW4gZXBoZW1lcmFsIElQ
IGxlYWRpbmcgdG8gYSBwcm9ibGVtIHdoZXJlIHRoZQ0KPiB2aXJ0dWFsIElQIGdldHMgb3Zlcndy
aXR0ZW4gYW5kIGZvcmdvdHRlbi4gV2hlbiB0aGUgZW5kcG9pbnQgSVANCj4gY2hhbmdlcywNCj4g
cmVjb25uZWN0IGF0dGVtcHRzIGZhaWwgYW5kIHRoZSBtb3VudCBuZXZlciByZWNvdmVycy4NCj4g
DQo+IFRoaXMgcGF0Y2ggcHJvdGVjdHMgYWRkciBmcm9tIGJlaW5nIG1vZGlmaWVkIGluIHRoZXNl
IHNjZW5hcmlvcywNCj4gYWxsb3dpbmcNCj4gTkZTIHJlY29ubmVjdHMgdG8gd29yayBhcyBpbnRl
bmRlZC4NCg0KV2hhdD8gTm8hIEEgY29ubmVjdCgpIGNhbGwgc2hvdWxkIG5vdCBiZSBhbGxvd2Vk
IHRvIG1vZGlmeSBpdHMgb3duIGNhbGwNCnBhcmFtZXRlcnMuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
