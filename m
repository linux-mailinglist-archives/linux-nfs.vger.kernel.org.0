Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778D67AB9CA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjIVTF3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIVTF1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 15:05:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12EFAC
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 12:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzrJoTOFM31cC/SJJj7UFZx/Y1VYKHIuahGQE1RBXAUYjnrWxIXvrnb1mqRiPgt8bAYPGr7dXF4cOmGDfCm48whz7e8DqCXefOnZeLrJ14Vrd5lxDz36cMuJCuY6oVVdlvv5huOkc6Z7IphDKDSOaBnKDhriQSAclNC1Ok3y9QEdY7hhfNs59qFegfwa/EDJkJgZePhvB/SNy52G9deSCziuybWJ//j6GbbN1C3lKUb7Ld44O8AjBx2N8KAegdBhpxc58S3msZ4v8haX8hI0GEL3WteKbvufGHK7DWfh8y4csJGabysGO3JjqccOJNeGs7qim7ponCwZBLycasR5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7MHugaHZ2oI+zrvn/ffhKA9ZxHL59PQ88KR8KFt93I=;
 b=hhoGMwxrJwEFFmQliBXsOqgXvtGWDG9eWYE6lewWDkXhgmyqARbzuRC/dkWfItk6UTswfoSJlMFZzqed0NSgs9Ccq+Prmc8PWXT3/4MYdalIFlSfyN7S4FIOZB9RzaUWvArzUb1R0X5aZqveWHl37SUp6LN04GRaKbIOTb3pF0jQ2VJCZMyRCCpgDF8xxIEt+MDUdXd1m/Uv81jzV4venBzZxGj8TIihFdZYbWQw4AJ54llOFQ7M/FnLJm52bK2VbUBsd2WhTdFEwaqNYvOgl8ZnhpiGKUeCxFThlSA4aGYSfyySJ05B3Vof5HacV/V3bktveoSaSV5BEwS+yuBehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7MHugaHZ2oI+zrvn/ffhKA9ZxHL59PQ88KR8KFt93I=;
 b=PL/eOKX4As+GCgp+HqQ0xdxTYsCxRxhfLut3k8xh6WbKAcgQZy9lKFK/ZFfuFqGOBMGMa6SDJFB2cRUY+0cZQuPuGdS6C7H20u1WcfmWgK9Ml8kGraXOQmrxlo44UVEiQWX7XlsYj6x0SE01TKd57TRgzL2iOwE5qXoJRHmvBE8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA3PR13MB6515.namprd13.prod.outlook.com (2603:10b6:806:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 22 Sep
 2023 19:05:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 19:05:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Thread-Topic: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock
 regression
Thread-Index: AQHZ6bx01N78VobVYEyXXSG5Nx3/F7AkIK8AgABNMACAArF1gIAAHKIA
Date:   Fri, 22 Sep 2023 19:05:16 +0000
Message-ID: <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org>
         <20230917230551.30483-2-trondmy@kernel.org>
         <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
         <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
         <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
In-Reply-To: <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA3PR13MB6515:EE_
x-ms-office365-filtering-correlation-id: 5d9d5831-9ad2-4279-e278-08dbbb9edbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyQW5ne6qpxbm1+8momss+cF9a0jp7aMMBJrPD5FwSa4UTCBqj1e3AzvRWROax5Cs3lYJUQvTOmeiJZsu4215AeAcRilsakH0b2PvHVRSzb2lMUPP21UZLTFdgK6eCT3Zjcf8MaBnvzyMp2YhEdM6qUck36dBPahA4Pl9/nFLgMfOIZIz4EmuZDMIVVkArdKI/XDvHuMvCytQNndzuKUdf2S4KdSkba2+C/B5glNfeu21efePMJH4Pf6m2+9fUftani+4N6kOjMtHMHhHPc8qNnnCNS3+zYdr6XflRH0UxsTeMi8I8LyVPs3xd3xLtak5afm5inuByMWPE4Nu8OyKHJNW2YZt+8Ox3ZPdlHjQUDyEbJG5S9QYlA7HPlA1yZlY+z26fmE/2z9nZFbYnv3jHz+1Sycc1+yAHlY25WB8bnoDZYBTTzLPgcCrR9aPeI4owV/AYl7/6AwQmEQpy7ggizjsVRWD3prc7HLC9iiKckhdvlVYHH3G1S165EOfyjmqmdBYUggUjyA7iCafCeSuOnu5kE5LIES3vh1MnFfKslNQjU3J0sXa6mbQLW79RocqqQoMlHRC9FOTBx+NV3tX65v6PyuHlMOcwdU9xKBtStHwmtUsKs+EOHkguJ2QKBNsdX64VPMNKPZe33102f/jEhpZj9ZSAkYYBpPpVsFUdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39830400003)(346002)(1800799009)(186009)(451199024)(36756003)(26005)(38070700005)(5660300002)(8676002)(8936002)(2906002)(86362001)(38100700002)(99936003)(83380400001)(4326008)(122000001)(2616005)(66556008)(53546011)(6506007)(91956017)(54906003)(64756008)(66946007)(66446008)(76116006)(6512007)(71200400001)(6486002)(478600001)(66476007)(41300700001)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hCS3ltWGNKbjRhWkZBeHJKQSt4VVdLeW1YWHVaZmFnNnVuYzBmeC80M2NU?=
 =?utf-8?B?c3N1NmNHN3dXeUJYaWgvczJJdU5zUElkajJTbUlXbUUvZEJ4UHB1NndDdkhr?=
 =?utf-8?B?a09lZER3VFhzQnhWS0VsNDIwYnliMThvSkJEMk93M2w1T2drMFZyVnBoR0lC?=
 =?utf-8?B?Vk8yUkZqS0tHYlBrT1FydkRxcis2aHM5b1d4bUUyL0toYmZpTWJPZWs4alVZ?=
 =?utf-8?B?L0lWLzdHUytQNFhZOHU2SWtvZjVURU1LbVVTeTN2bDRjYkhTN1RtV2d2Si9q?=
 =?utf-8?B?QnJ4WFZjV0lSbkFVMm9jdElKYSsyVHNNelpxMktSQXdEcmtqK2pERkdDaElk?=
 =?utf-8?B?OUU2bHJPUEVBcVREejYydTUrTUNUaHJqNTZSbmZyMHkwYThQWGJQd1B0cmpj?=
 =?utf-8?B?VHhQRzd4T2tXcmdkZWpWMXhwQnpSK0RkK212QVoxdXkyV1plMkRqaUxOeVpk?=
 =?utf-8?B?anRzclNSSklvRExaenZIaEtydnh0SElaVG0xYXQ3MUtQdTB3dHVVaGFCUCtV?=
 =?utf-8?B?aTdUK3BoNStjSjlTd2d3SEVRT1Y1cVgxcG5MMkplUHFXS0l2OXY2aS80WDhJ?=
 =?utf-8?B?cXJxZEJxM0Qva08rOWJBWUYwUVRZUDF5QTJRbzZoa0czZGQ2Y05yc002Wnlu?=
 =?utf-8?B?RXJocVZNb1EzaU5Vc2ZZZ3JNNEJrR3ZvdkhVcFFxK3FFNWZ6NUd0aGhibTRk?=
 =?utf-8?B?SXd4Sm96bDg2ZzV3Mzd6T3BVZDZlYWMzK1prdjJtSWUrTFRySy96UkhkNS9k?=
 =?utf-8?B?RWxQczJ2eFRLVmljWitrUlRjSnE1dnZydno0cGRITEsrSjNOTXc5NkxTVS9t?=
 =?utf-8?B?OXd1WmE0ek9mQXlnOUE5VzJkaHdzK0dsOEJsMVBScG5lL2MyaEJFQ3Izb041?=
 =?utf-8?B?RUsrYy91c3dsK1FkczF4N1U4eUIvZmYzZ1VCSExwenhRSnlGbGJ6cnRLc2Fx?=
 =?utf-8?B?VkpGdlorRUdNVzN6aHBINkorZDhpL0l5UnZ2NXZwd2hsR25uWG9TRUthL0lD?=
 =?utf-8?B?L3BsTEFTNzNBdFhJQTlMRTRtN3Z6eU1TZTFsSFV6aEszdFdzWEJpTHNGOUNu?=
 =?utf-8?B?akhhU0hqN1pvM1pXeXR1ajAzYmF5YUJWUzhoU04zN283UEY3bU9PaFNZY2Vj?=
 =?utf-8?B?Z2U1NFFoNlZHVHdlTFhqQmhOYWMwbUhhSFdPMkxKVWxCaDlIUUVwQ0RGaG9S?=
 =?utf-8?B?WWdwODRpcDl6RWd5RFkvVVl1cGVtRFViWVlsOFdNZll1VWVXRDREUDhnWWw4?=
 =?utf-8?B?b3FaRlBxVnY2NDN3RXdNcXRYeW9GczhtakswRWVINi93TFlCTlA3MUE1SnE2?=
 =?utf-8?B?RnZSVXNSQmJqMTVoRXVtNU8zcUttTmFzT3ZkM1JnOXJjVGNFSllVVklNbFhW?=
 =?utf-8?B?SFUySE91UVNvRS96RGw4K0JnbG1mVlFyNWxaREg1Y2ZSeHpXVHZLWTZsM29V?=
 =?utf-8?B?dDQyWjBHS1FLbHFBR1dkUkRvWnVzYXFlMnJuS2diYXAwczEra3BOV1M5RTEr?=
 =?utf-8?B?UnlvUnc2Qm42QllPMXdDYTRyamE5VXIwK2ZLYUpiSmlnVzg0MWVWSko0czNi?=
 =?utf-8?B?U1IwVUxCNVMwZENTYThUUy9NTHZOQ01qeS9uYXNyS0xqWE5QU1pFS0xwdUlL?=
 =?utf-8?B?cUZpWlBqTEpxakNGVCtRa0VWbm1HQVgyZ0NQZXp3WUM4NFhzRVJMU3BidVNj?=
 =?utf-8?B?ZC9HL2VDRE4xQi9rYURBUTZ2OVAwL0JBaGhYMm1DSnpYNXFZNTU4bjhYUEcy?=
 =?utf-8?B?dlA2R28vYmVqN25QYkFHNFRuUHBodzZDb1lHOGlHR3o1SFJvOHQ0ZWk3cXJ5?=
 =?utf-8?B?OGxWb08yeklURG00YzJUdVBxMGtvY240eGs1bEJxcTU2NG5zNDNzSmtqcXRR?=
 =?utf-8?B?a0s2QnpHT0ZPQ01lVm9iTWV1QTFqM1B0MEo1eUlyVzdGWTkram13MDNRRUR2?=
 =?utf-8?B?cFR2RHpGajdXZVFGUlp6S3hTdjFkYzl5SGNDMzNWQTJDcitKWDd5YWE3VjAx?=
 =?utf-8?B?Kzgva3VWV1FtK1kvNFYzeDA1L1B2WlpDYmVzTklzZUl5RU4rdVd0UEE4MUMv?=
 =?utf-8?B?MlEwWWlWQm1QNEJnVHc2OXhWejk5QU1LOWNRajhhZERSN2NpRXF4eWVEQXdI?=
 =?utf-8?B?cWxBOFRDS1BEOUZwdC9VRmVhWHZwT0x0Rjhha0ZNSmVvL2h0TndDWDNNdEJK?=
 =?utf-8?B?clE9PQ==?=
Content-Type: multipart/mixed;
        boundary="_002_077cb75b44afd2404629c1388a92ca61da5092b1camelhammerspac_"
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d5831-9ad2-4279-e278-08dbbb9edbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 19:05:16.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZViRVWJUSWn9ZGFpElb6hWeTUJPv8HO8YLzI/NsqTHvMa0605qogwgTcd7xvtvoP2+z3ir7tKTXYK2B3fbwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_002_077cb75b44afd2404629c1388a92ca61da5092b1camelhammerspac_
Content-Type: text/plain; charset="utf-8"
Content-ID: <87B8232D62334F45B6ADDE3466A66710@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDEzOjIyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBTZXAgMjAsIDIwMjMgYXQgODoyN+KAr1BNIFRyb25kIE15a2xlYnVzdA0K
PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAy
My0wOS0yMCBhdCAxNTozOCAtMDQwMCwgQW5uYSBTY2h1bWFrZXIgd3JvdGU6DQo+ID4gPiBIaSBU
cm9uZCwNCj4gPiA+IA0KPiA+ID4gT24gU3VuLCBTZXAgMTcsIDIwMjMgYXQgNzoxMuKAr1BNIDx0
cm9uZG15QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gRnJvbTogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4g
PiA+ID4gQ29tbWl0IDRkYzczYzY3OTExNCByZWludHJvZHVjZXMgdGhlIGRlYWRsb2NrIHRoYXQg
d2FzIGZpeGVkIGJ5DQo+ID4gPiA+IGNvbW1pdA0KPiA+ID4gPiBhZWFiYjNjOTYxODYgKCJORlN2
NDogRml4IGEgTkZTdjQgc3RhdGUgbWFuYWdlciBkZWFkbG9jayIpDQo+ID4gPiA+IGJlY2F1c2UN
Cj4gPiA+ID4gaXQNCj4gPiA+ID4gcHJldmVudHMgdGhlIHNldHVwIG9mIG5ldyB0aHJlYWRzIHRv
IGhhbmRsZSByZWJvb3QgcmVjb3ZlcnksDQo+ID4gPiA+IHdoaWxlDQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBvbGRlciByZWNvdmVyeSB0aHJlYWQgaXMgc3R1Y2sgcmV0dXJuaW5nIGRlbGVnYXRpb25z
Lg0KPiA+ID4gDQo+ID4gPiBJJ20gc2VlaW5nIGEgcG9zc2libGUgZGVhZGxvY2sgd2l0aCB4ZnN0
ZXN0cyBnZW5lcmljLzQ3MiBvbiBORlMNCj4gPiA+IHY0LngNCj4gPiA+IGFmdGVyIGFwcGx5aW5n
IHRoaXMgcGF0Y2guIFRoZSB0ZXN0IGl0c2VsZiBjaGVja3MgZm9yIHZhcmlvdXMNCj4gPiA+IHN3
YXBmaWxlDQo+ID4gPiBlZGdlIGNhc2VzLCBzbyBpdCBzZWVtcyBsaWtlbHkgc29tZXRoaW5nIGlz
IGdvaW5nIG9uIHRoZXJlLg0KPiA+ID4gDQo+ID4gPiBMZXQgbWUga25vdyBpZiB5b3UgbmVlZCBt
b3JlIGluZm8NCj4gPiA+IEFubmENCj4gPiA+IA0KPiA+IA0KPiA+IERpZCB5b3UgdHVybiBvZmYg
ZGVsZWdhdGlvbnMgb24geW91ciBzZXJ2ZXI/IElmIHlvdSBkb24ndCwgdGhlbg0KPiA+IHN3YXAN
Cj4gPiB3aWxsIGRlYWRsb2NrIGl0c2VsZiB1bmRlciB2YXJpb3VzIHNjZW5hcmlvcy4NCj4gDQo+
IElzIHRoZXJlIGRvY3VtZW50YXRpb24gc29tZXdoZXJlIHRoYXQgc2F5cyB0aGF0IGRlbGVnYXRp
b25zIG11c3QgYmUNCj4gdHVybmVkIG9mZiBvbiB0aGUgc2VydmVyIGlmIE5GUyBvdmVyIHN3YXAg
aXMgZW5hYmxlZD8NCg0KSSB0aGluayB0aGUgcXVlc3Rpb24gaXMgbW9yZSBnZW5lcmFsbHkgIklz
IHRoZXJlIGRvY3VtZW50YXRpb24gZm9yIE5GUw0Kc3dhcD8iDQoNCj4gDQo+IElmIHRoZSBjbGll
bnQgY2FuJ3QgaGFuZGxlIGRlbGVnYXRpb25zICsgc3dhcCwgdGhlbiBzaG91bGRuJ3QgdGhpcyBi
ZQ0KPiBzb2x2ZWQgYnkgKDEpIGNoZWNraW5nIGlmIHdlIGFyZSBpbiBORlMgb3ZlciBzd2FwIGFu
ZCB0aGVuDQo+IHByb2FjdGl2ZWx5DQo+IHNldHRpbmcgJ2RvbnQgd2FudCBkZWxlZ2F0aW9uJyBv
biBvcGVuIGFuZC9vciAoMikgcHJvYWN0aXZlbHkgcmV0dXJuDQo+IHRoZSBkZWxlZ2F0aW9uIGlm
IHJlY2VpdmVkIHNvIHRoYXQgd2UgZG9uJ3QgZ2V0IGludG8gdGhlIGRlYWRsb2NrPw0KDQpXZSBj
b3VsZCBkbyB0aGF0IGZvciBORlN2NC4xIGFuZCBORlN2NC4yLCBidXQgdGhlIHByb3RvY29sIHdp
bGwgbm90DQphbGxvdyB1cyB0byBkbyB0aGF0IGZvciBORlN2NC4wLg0KDQo+IA0KPiBJIHRoaW5r
IHRoaXMgaXMgc2ltaWxhciB0byBBbm5hJ3MuIFdpdGggdGhpcyBwYXRjaCwgSSdtIHJ1bm5pbmcg
aW50bw0KPiBhDQo+IHByb2JsZW0gcnVubmluZyBhZ2FpbnN0IGFuIE9OVEFQIHNlcnZlciB1c2lu
ZyB4ZnN0ZXN0cyAobm8gcHJvYmxlbXMNCj4gd2l0aG91dCB0aGUgcGF0Y2gpLiBEdXJpbmcgdGhl
IHJ1biB0d28gc3R1Y2sgdGhyZWFkcyBhcmU6DQo+IFtyb290QHVua25vd24wMDBjMjkxYmU4YWEg
YWdsb10jIGNhdCAvcHJvYy8zNzI0L3N0YWNrDQo+IFs8MD5dIG5mczRfcnVuX3N0YXRlX21hbmFn
ZXIrMHgxYzAvMHgxZjggW25mc3Y0XQ0KPiBbPDA+XSBrdGhyZWFkKzB4MTAwLzB4MTEwDQo+IFs8
MD5dIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+IFtyb290QHVua25vd24wMDBjMjkxYmU4YWEg
YWdsb10jIGNhdCAvcHJvYy8zNzI1L3N0YWNrDQo+IFs8MD5dIG5mc193YWl0X2JpdF9raWxsYWJs
ZSsweDFjLzB4ODggW25mc10NCj4gWzwwPl0gbmZzNF93YWl0X2NsbnRfcmVjb3ZlcisweGI0LzB4
ZjAgW25mc3Y0XQ0KPiBbPDA+XSBuZnM0X2NsaWVudF9yZWNvdmVyX2V4cGlyZWRfbGVhc2UrMHgz
NC8weDg4IFtuZnN2NF0NCj4gWzwwPl0gX25mczRfZG9fb3Blbi5pc3JhLjArMHg5NC8weDQwOCBb
bmZzdjRdDQo+IFs8MD5dIG5mczRfZG9fb3BlbisweDljLzB4MjM4IFtuZnN2NF0NCj4gWzwwPl0g
bmZzNF9hdG9taWNfb3BlbisweDEwMC8weDExOCBbbmZzdjRdDQo+IFs8MD5dIG5mczRfZmlsZV9v
cGVuKzB4MTFjLzB4MjQwIFtuZnN2NF0NCj4gWzwwPl0gZG9fZGVudHJ5X29wZW4rMHgxNDAvMHg1
MjgNCj4gWzwwPl0gdmZzX29wZW4rMHgzMC8weDM4DQo+IFs8MD5dIGRvX29wZW4rMHgxNGMvMHgz
NjANCj4gWzwwPl0gcGF0aF9vcGVuYXQrMHgxMDQvMHgyNTANCj4gWzwwPl0gZG9fZmlscF9vcGVu
KzB4ODQvMHgxMzgNCj4gWzwwPl0gZmlsZV9vcGVuX25hbWUrMHgxMzQvMHgxOTANCj4gWzwwPl0g
X19kb19zeXNfc3dhcG9mZisweDU4LzB4NmU4DQo+IFs8MD5dIF9fYXJtNjRfc3lzX3N3YXBvZmYr
MHgxOC8weDI4DQo+IFs8MD5dIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4N2MvMHhkMA0K
PiBbPDA+XSBkb19lbDBfc3ZjKzB4YjQvMHhkMA0KPiBbPDA+XSBlbDBfc3ZjKzB4NTAvMHgyMjgN
Cj4gWzwwPl0gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHgxMzQvMHgxNTANCj4gWzwwPl0gZWwwdF82
NF9zeW5jKzB4MTdjLzB4MTgwDQoNCk9oIGNyYXAuLi4gWWVzLCB0aGF0IGlzIGEgYnVnLiBDYW4g
eW91IHBsZWFzZSBhcHBseSB0aGUgYXR0YWNoZWQgcGF0Y2gNCm9uIHRvcCBvZiB0aGUgb3JpZ2lu
YWwsIGFuZCBzZWUgaWYgdGhhdCBmaXhlcyB0aGUgcHJvYmxlbT8NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

--_002_077cb75b44afd2404629c1388a92ca61da5092b1camelhammerspac_
Content-Type: text/x-patch;
	name="0001-fixup-NFSv4-Fix-a-state-manager-thread-deadlock-regr.patch"
Content-Description:
 0001-fixup-NFSv4-Fix-a-state-manager-thread-deadlock-regr.patch
Content-Disposition: attachment;
	filename="0001-fixup-NFSv4-Fix-a-state-manager-thread-deadlock-regr.patch";
	size=1475; creation-date="Fri, 22 Sep 2023 19:05:16 GMT";
	modification-date="Fri, 22 Sep 2023 19:05:16 GMT"
Content-ID: <991B347DE0A7F84CBF1106C37547B370@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBlYzg5YTgzN2I3MTc3MmZlZWI1NWNkOWVjZTRlOTE5MDBkNGFmYTc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+CkRhdGU6IEZyaSwgMjIgU2VwIDIwMjMgMTU6MDA6MDggLTA0MDAKU3ViamVj
dDogW1BBVENIXSBmaXh1cCEgTkZTdjQ6IEZpeCBhIHN0YXRlIG1hbmFnZXIgdGhyZWFkIGRlYWRs
b2NrIHJlZ3Jlc3Npb24KClNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbT4KLS0tCiBmcy9uZnMvbmZzNHN0YXRlLmMgfCA2ICsrKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMKaW5kZXggNTc1
MWE2ODg2ZGE0Li45YTVkOTExYTdlZGMgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9uZnM0c3RhdGUuYwor
KysgYi9mcy9uZnMvbmZzNHN0YXRlLmMKQEAgLTI3NjIsMTcgKzI3NjIsMTcgQEAgc3RhdGljIGlu
dCBuZnM0X3J1bl9zdGF0ZV9tYW5hZ2VyKHZvaWQgKnB0cikKIAluZnM0X3N0YXRlX21hbmFnZXIo
Y2xwKTsKIAogCWlmICh0ZXN0X2JpdChORlM0Q0xOVF9NQU5BR0VSX0FWQUlMQUJMRSwgJmNscC0+
Y2xfc3RhdGUpICYmCi0JICAgICF0ZXN0X2FuZF9zZXRfYml0KE5GUzRDTE5UX01BTkFHRVJfUlVO
TklORywgJmNscC0+Y2xfc3RhdGUpKSB7CisJICAgICF0ZXN0X2JpdChORlM0Q0xOVF9NQU5BR0VS
X1JVTk5JTkcsICZjbHAtPmNsX3N0YXRlKSkgewogCQl3YWl0X3Zhcl9ldmVudF9pbnRlcnJ1cHRp
YmxlKCZjbHAtPmNsX3N0YXRlLAogCQkJCQkgICAgIHRlc3RfYml0KE5GUzRDTE5UX1JVTl9NQU5B
R0VSLAogCQkJCQkJICAgICAgJmNscC0+Y2xfc3RhdGUpKTsKIAkJaWYgKCFhdG9taWNfcmVhZCgm
Y2wtPmNsX3N3YXBwZXIpKQogCQkJY2xlYXJfYml0KE5GUzRDTE5UX01BTkFHRVJfQVZBSUxBQkxF
LCAmY2xwLT5jbF9zdGF0ZSk7Ci0JCWlmIChyZWZjb3VudF9yZWFkKCZjbHAtPmNsX2NvdW50KSA+
IDEgJiYgIXNpZ25hbGxlZCgpKQorCQlpZiAocmVmY291bnRfcmVhZCgmY2xwLT5jbF9jb3VudCkg
PiAxICYmICFzaWduYWxsZWQoKSAmJgorCQkgICAgIXRlc3RfYW5kX3NldF9iaXQoTkZTNENMTlRf
TUFOQUdFUl9SVU5OSU5HLCAmY2xwLT5jbF9zdGF0ZSkpCiAJCQlnb3RvIGFnYWluOwogCQkvKiBF
aXRoZXIgbm8gbG9uZ2VyIGEgc3dhcHBlciwgb3Igd2VyZSBzaWduYWxsZWQgKi8KIAkJY2xlYXJf
Yml0KE5GUzRDTE5UX01BTkFHRVJfQVZBSUxBQkxFLCAmY2xwLT5jbF9zdGF0ZSk7Ci0JCW5mczRf
Y2xlYXJfc3RhdGVfbWFuYWdlcl9iaXQoY2xwKTsKIAl9CiAKIAlpZiAocmVmY291bnRfcmVhZCgm
Y2xwLT5jbF9jb3VudCkgPiAxICYmICFzaWduYWxsZWQoKSAmJgotLSAKMi40MS4wCgo=

--_002_077cb75b44afd2404629c1388a92ca61da5092b1camelhammerspac_--
