Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62156524C9
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 17:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiLTQip (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 11:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiLTQiA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 11:38:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2104.outbound.protection.outlook.com [40.107.96.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AA1DDE3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 08:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmo3k0FF7DC3ZTwVFID/fGOlS4ZC1HSmgzBvGuKz1Z/Z4Q85WB0IfyBdM4pvKTTC5h8WCprsSNr5jZQWNRN9aCsSG9Gk6xwHsm+jHRCzWYPFVupagC6syEU3tow9JKANJ9KRu9/moZ9/iOS6xdQpHQW3kam9EG1IU5S0DPBykSd6tx8/Gid5BBy7yO/toBIT1XC09+5mU4CZ+3Kf+5jGL3W8igJ3h7DNsRfz3/CMNHpyXlpJGlv1Mn8RA79T0t+btvL1S8iIDK5fyV4BqaB6ulrEgtwcbfdvIVe/wJByTEfyGqRI3qLVChlehRdnyLskIwORIM2XZSnwoPyvZ6f+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsogdCF7dU/NfhBr5a/SFlfvlGtmNW1tgVLR+IZNO4Q=;
 b=BUoXQqn4ARVSX1y/uQ+MyWS7kufeZBLHix6yplCmX6uiYWi4+qyuAomtL0q6fjiLNIqEAVO8cJGT7FFtkMcHfYARvDOReeS7jeAAWIrljvI91ExflMd3Z8pQrMS9tuJDXhz8H8UoF/TC5foVV2p8JX0kRUBg9ah0s6xa8WRXoSqLpS6Ha2sGhXTT0FFjhpJBBaGGLc+jcdd+G2QBNX111FBvD0G5gwsUjAEWDpFwuFKCywTyquRRxDQnR6MbtdhPjnR7Va2o3gAMOiY4DMwwUZYX1hfDnFY0rDS38DqolQdXTYYDNodbFd7OPYhWCA4cmIe4fwT+ncWJWh+Auremaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsogdCF7dU/NfhBr5a/SFlfvlGtmNW1tgVLR+IZNO4Q=;
 b=MaRaOcywo/1WgR91a7Ha1pRihiZQcPLWLMvvyxWA0zW4HvmvZycwwd4m5+gjvGFf45cIKCo2kM6swHVItaK3UJQQ94ebO5BaKvUkJiINRj6bH2NRU/3xn1CS6BEeSco4/o1Q490ozzLGsVkNp6icQoGtymGcrbi2CiZD/9PA4PY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5996.namprd13.prod.outlook.com (2603:10b6:303:1cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:37:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 16:37:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] pNFS/filelayout: Fix coalescing test for single DS
Thread-Topic: [PATCH 1/1] pNFS/filelayout: Fix coalescing test for single DS
Thread-Index: AQHZFJA2M4u+G2GBrkiRiWna90kRTq52+XqA
Date:   Tue, 20 Dec 2022 16:37:19 +0000
Message-ID: <F9BC16CC-E33F-4C1C-8A41-BD451CAE795E@hammerspace.com>
References: <20221220162912.95886-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20221220162912.95886-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5996:EE_
x-ms-office365-filtering-correlation-id: d7192e1a-0a18-4421-c093-08dae2a87679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VxTxCdHpwU2D5kOY3h6gaW9bbGNz8nHfzCxzmTSm35hQUPuRG2qCDIujrsMcYgDwJ1W4sJZ75eNLdpIAjaqV7FPoSEtsyBcS3ufXWazcwUUBvTqHk6xxvbxoxdD3EkchYRUGSoW89bqrF2jssFLFxbUGqu5Pev6gQyIDA1GCpZI43NsdfrsWpgfKBp6xAxXSrhOTEsWEIQuM56fUj5rYborZIvQC3MRWdG1DN4ykA5PFjYTodIUVxpB5412GTZtcoTWEyygm4KC5SckxMu7uxxjaepKCPPFwnnM9X65KJgQ5WkgUyBTKvLdW7sI6leoIODkEpGumkxDWrpXTxRK8PEXsa0uQ+7rZ8RONg02r/1iqRebtnJ/V0RHVPFC3i2GObCBLVmgU8oxECD2OgOUXh3yhiTq9F68//CWk8wbVuIHTpYx7NVr/+KhtKUJP2SIiKiE587hGHVYSaGagxhUFZQTJy+K6+0m0GtZV3uTKKtyWpRCcEjcBogwSDumiX4K7PTjAlThZIB1qRrkr+MbmXWAQKevb3Olnrc/kDde6CJtB/KGX1LtIHUHbu2BYpp1BeO6v3pCIU9PMgIXdVQ/T3Z5YzC4hB30owq0oXiqV54tpbRj2SYmz4oQJvl5Dk0vfmUHKM7v2bKcWI+pSVwRUPKZnkI8Qd3A+LnABEztVKs/L3WOhyKF1LplJGFCdt3j6NQv0SLkLNiYolOmxOn979ZeemYbNaObNJmmrpD/Q1As=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199015)(2906002)(8936002)(38070700005)(38100700002)(122000001)(5660300002)(186003)(64756008)(8676002)(66946007)(66446008)(4326008)(71200400001)(6512007)(36756003)(76116006)(66556008)(66476007)(83380400001)(41300700001)(86362001)(2616005)(53546011)(6486002)(33656002)(316002)(6506007)(478600001)(54906003)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWFlRTJqby9RVlpLTSsvSm5PS3VkalJnTzNYK2gxeVJrQ21RaTdTTFNhd0p2?=
 =?utf-8?B?ajhDaUFPcjRhMnIyWUVqTVUrcm5PblJxK1dZN2FKK0tJbE9jSy9LTU9TVUtp?=
 =?utf-8?B?NTJ2djgwNlo3Sko2R0tDOGlEa1hoVTEvV2JsVEU1aHZsRnVuWm1zZnJNUE41?=
 =?utf-8?B?bVNHODdxaFd1RVB1OWFZaXFNUVRKS3Z0dUhKVnAwNFJ0ZnN6VHpWWS9tb3hC?=
 =?utf-8?B?VjRpNTJGS3NLTE9Xa1F0U3UyV1FFRDFDT09hTjVvUzN1aVVuU01tM2FEZWR1?=
 =?utf-8?B?WWgxTkY0dzNEYXdqSE5YY2l2bUcybFBSMHFSR1ZkYnlNSXRmQWRGMGtZS1hq?=
 =?utf-8?B?Y3BwMllxN2pVbTZSQklDYnF3OGk2MEdNTlNvaldaanVNOEdjekFKUTM1L2Nr?=
 =?utf-8?B?Vmc3M2pZck02WFIyUWR2dkw3bDRCSmdhSE5XN2lyanIzQVVVNHFkT2hMSkkx?=
 =?utf-8?B?R3QrVkJTZHoxQzMwMFl3R2lYRDBkMW5RNmN4c1pVS0Y0a2xhRkp0UlkxUjla?=
 =?utf-8?B?OVBaQ3U5cmFsNUc4R0g1V0R1ZnpaVUwzeTFMdUIzTkZWYUxCTmx2UmpFL3Z4?=
 =?utf-8?B?YUQwMXBBdGYvbHlJNjI5V3lNR1A4WkNZLzd1MUlzdXdaZzBVTzVqTTFtZE0z?=
 =?utf-8?B?aTJZWE1MZStwc1RIRUh5QTFNL0lSSisrSkszQmszM2RoRTFmcWJQMlhCcGJY?=
 =?utf-8?B?a2ZiL2oyZmN6bHR2YllQbFZMOFJ5bmZmYTEwcWtQWWtLR2wrZ1FOWlRBV0l3?=
 =?utf-8?B?bFh4ZUR6bmlWVkdnWFBHTDZNMVM2azREZDZGSHZQM0VWc2xmMUxWMlphN1VC?=
 =?utf-8?B?MXpHckNlS3VSejFpQVZHREV1eGxHSTFPQ2ZQaHhzSnk4Ylo3SjRsUGRVUktI?=
 =?utf-8?B?dVhGM1YwVXJWeVE4SjFRUWo5ekZtRW9lRmhsMThJc1ExejVPVXFpaE5lek5t?=
 =?utf-8?B?S1FkRzc4OThvM3cvSkV4UDNDc2I2UjQ2M1piWkV1U1FtNHNZMSsyakQvdmNv?=
 =?utf-8?B?U0FEb2x5STRMWjZaTzYxM1dhOG1mdm1URnlKcCs0cFN2OXExNWg4bmdtbzN3?=
 =?utf-8?B?WkZ4UmJFY3QvYVFnNUZMRnd3TXNXR0ZFWWZuNzdVWnF0SkdZVDRUSHhJbWJk?=
 =?utf-8?B?ancyNC9FUVZkYnNUUmJFR3A5THRYcmxhTEtxU3hsakwxSWZIZVo0ME9Cb1Uy?=
 =?utf-8?B?N096MHY1QndUbzFjeUhOMmFCTDd4a0lNM1ZjR3AzNmM1Yi85T2U0RWxXV083?=
 =?utf-8?B?RXlNOEhYNTAxb3lZSFYySm9XSDBCb0s5M2JqL21HN1MyeHF5cTJFVVV5Ym5N?=
 =?utf-8?B?aGpwSDRtSmhyV3hXUE95STZZQ01oV0NaV0lpOW9nazQyd0NiQmZmN2lDY2RG?=
 =?utf-8?B?QTJRdk5WZmJURERWVzVjRlV5N21qZHVTMUZoaXhEZnE2TUdTWFRCZHgxT3c2?=
 =?utf-8?B?V1cwVm5INVNDYi9UaUVGOC83QUFaZVdUSGxLQVZ3eU55VXVEa0g5S0pQUkcv?=
 =?utf-8?B?VDhsOVBlYWhsSENCY3p0Ri8zUGZDOGdzWGpSU256MUFjR2xpaEErcVJTd2Fn?=
 =?utf-8?B?VXZzRXd1NVcxTWJTYkJFNzk1ZHhkNVZ3UjZoUlh2NkFFTzdFVy8raE50WEhU?=
 =?utf-8?B?cE16ZlV6MmUxQlBiNWhNS25RK3RLTUhsVkFlaUdwN3hhcVVjSHk2NzY2dlBZ?=
 =?utf-8?B?MEF0dElITTVFVGI1a1NySzk5NmVXbkozV3RuaG9iSmdBZ3hxOGtBTVk5TmMr?=
 =?utf-8?B?YWhBQndEdmtkbmRDRDhjdnVZRzhaelArdWtZSDM1ZnUyTjl3V2xYbkpXR3Zk?=
 =?utf-8?B?aFZMMXlZZHQzN052ZXNSczdjeDdqb0UycmE1Zy9QVnJkcm5MaHh5ODhYVFpy?=
 =?utf-8?B?V2VhbldGd1cxclRrRzg2SC9wVTZsczNnQzEzVDJPTUJJQ1UvQ2x3VnllWGJo?=
 =?utf-8?B?TTl3NHF2NGJFdXptY1BaRzcwcXozYmtqZXpkSHEzYmpFMnA0WExtTk9WODJO?=
 =?utf-8?B?Z3hpQWxWYThSaHI4ajlZQ1JiNThMdXBBZnRTNDFpSkFjdEIwcmVaNjJ5WDl2?=
 =?utf-8?B?ODg4bEp6MnRpTmR3Q09veFRFWFRjaU16dis0elRBTEw1N2x6azlUZ2pEOC9L?=
 =?utf-8?B?NUxCVENxSW9TUFFvNkdlTmxXb00vVVBPYld5SEppcWpkbUJrelpib21aSkxq?=
 =?utf-8?B?S1lKTEVqOElWelJrNEtaZGNVdTUvOXEzQWZKOVJmeVpqTHkvTnNma05zV291?=
 =?utf-8?B?bE1hMlVJem9TSVFZTXZvdGlqM09BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C41FDB702384C34BBC6D1EAF22582527@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7192e1a-0a18-4421-c093-08dae2a87679
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 16:37:19.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5ccGqXGftStPh8/ZMIXZPzOGYgsxtFsy0BvhU+93pOJ4gDmrmB+KAWmJlzDZO8FqzBpfJIWpbHKwe07qRuvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDIwLCAyMDIyLCBhdCAxMToyOSwgT2xnYSBLb3JuaWV2c2thaWEgPG9sZ2Eu
a29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBXaGVuIHRoZXJlIGlzIGEgc2lu
Z2xlIERTIG5vIHN0cmlwaW5nIGNvbnN0cmFpbnRzIG5lZWQgdG8gYmUgcGxhY2VkIG9uDQo+IHRo
ZSBJTy4gV2hlbiBzdWNoIGNvbnN0cmFpbnQgaXMgYXBwbGllZCB0aGVuIGJ1ZmZlcmVkIHJlYWRz
IGRvbid0DQo+IGNvYWxlc2NlIHRvIHRoZSBEUydzIHJzaXplLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IC0tLQ0KPiBmcy9uZnMv
ZmlsZWxheW91dC9maWxlbGF5b3V0LmMgICAgfCAyICsrDQo+IGZzL25mcy9maWxlbGF5b3V0L2Zp
bGVsYXlvdXQuaCAgICB8IDEgKw0KPiBmcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0ZGV2LmMg
fCA0ICsrKy0NCj4gMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmMgYi9m
cy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmMNCj4gaW5kZXggYWQzNGEzM2IwNzM3Li5jZDgx
OWI3OTU5MzUgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYw0K
PiArKysgYi9mcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmMNCj4gQEAgLTgwMyw2ICs4MDMs
OCBAQCBmaWxlbGF5b3V0X3BnX3Rlc3Qoc3RydWN0IG5mc19wYWdlaW9fZGVzY3JpcHRvciAqcGdp
bywgc3RydWN0IG5mc19wYWdlICpwcmV2LA0KPiBzaXplID0gcG5mc19nZW5lcmljX3BnX3Rlc3Qo
cGdpbywgcHJldiwgcmVxKTsNCj4gaWYgKCFzaXplKQ0KPiByZXR1cm4gMDsNCj4gKyBlbHNlIGlm
IChGSUxFTEFZT1VUX0xTRUcocGdpby0+cGdfbHNlZyktPnNpbmdsZV9kcykNCj4gKyByZXR1cm4g
c2l6ZTsNCg0KSG1t4oCmIEluc3RlYWQgb2YgYWRkaW5nIHRoZSBib29sZWFuLCBwZXJoYXBzIGp1
c3QgYWRkIGEgaGVscGVyIGZ1bmN0aW9uDQoNCnN0YXRpYyBib29sIGZpbGVsYXlvdXRfbHNlZ19p
c19zdHJpcGVkKGNvbnN0IHN0cnVjdCBuZnM0X2ZpbGVsYXlvdXRfc2VnbWVudCAqZmxzZWcpDQp7
DQoJcmV0dXJuIGZsc2VnLT5udW1fZmggPiAxOw0KfQ0KDQp0aGF0IGNhbiBiZSBjYWxsZWQgaGVy
ZT8NCg0KPiANCj4gLyogc2VlIGlmIHJlcSBhbmQgcHJldiBhcmUgaW4gdGhlIHNhbWUgc3RyaXBl
ICovDQo+IGlmIChwcmV2KSB7DQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZmlsZWxheW91dC9maWxl
bGF5b3V0LmggYi9mcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmgNCj4gaW5kZXggYWVkMDc0
OGZkNmVjLi41MjQ5MjBjMmNiZjggMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9maWxlbGF5b3V0L2Zp
bGVsYXlvdXQuaA0KPiArKysgYi9mcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmgNCj4gQEAg
LTY1LDYgKzY1LDcgQEAgc3RydWN0IG5mczRfZmlsZWxheW91dF9zZWdtZW50IHsNCj4gc3RydWN0
IG5mczRfZmlsZV9sYXlvdXRfZHNhZGRyICpkc2FkZHI7IC8qIFBvaW50IHRvIEdFVERFVklORk8g
ZGF0YSAqLw0KPiB1bnNpZ25lZCBpbnQgbnVtX2ZoOw0KPiBzdHJ1Y3QgbmZzX2ZoICoqZmhfYXJy
YXk7DQo+ICsgYm9vbCBzaW5nbGVfZHM7DQo+IH07DQo+IA0KPiBzdHJ1Y3QgbmZzNF9maWxlbGF5
b3V0IHsNCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXRkZXYuYyBi
L2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXRkZXYuYw0KPiBpbmRleCBhY2Y0Yjg4ODg5ZGMu
Ljk1ZWJiZTllN2VkNCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2ZpbGVsYXlvdXQvZmlsZWxheW91
dGRldi5jDQo+ICsrKyBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXRkZXYuYw0KPiBAQCAt
MjQzLDggKzI0MywxMCBAQCBuZnM0X2ZsX3NlbGVjdF9kc19maChzdHJ1Y3QgcG5mc19sYXlvdXRf
c2VnbWVudCAqbHNlZywgdTMyIGopDQo+IHUzMiBpOw0KPiANCj4gaWYgKGZsc2VnLT5zdHJpcGVf
dHlwZSA9PSBTVFJJUEVfU1BBUlNFKSB7DQo+IC0gaWYgKGZsc2VnLT5udW1fZmggPT0gMSkNCj4g
KyBpZiAoZmxzZWctPm51bV9maCA9PSAxKSB7DQo+ICsgZmxzZWctPnNpbmdsZV9kcyA9IHRydWU7
DQo+IGkgPSAwOw0KPiArIH0NCj4gZWxzZSBpZiAoZmxzZWctPm51bV9maCA9PSAwKQ0KPiAvKiBV
c2UgdGhlIE1EUyBPUEVOIGZoIHNldCBpbiBuZnNfcmVhZF9ycGNzZXR1cCAqLw0KPiByZXR1cm4g
TlVMTDsNCj4gLS0gDQo+IDIuMzEuMQ0KPiANCg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
