Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70534EAE1E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiC2NHn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiC2NHm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 09:07:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2130.outbound.protection.outlook.com [40.107.94.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D42B193;
        Tue, 29 Mar 2022 06:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNCa1zHdKwMW9dc/87UqBuYjgo91J2A/sNidy6n593D40/8lO0xovURXVr/a+MJ35jYK51mvQAIYyifQf6zHV4+/qsUpemmZ3Et9NfiqyKK0FQzfKe/8b3TcTaEsPNKyIEyLGU96JlUIlJpABHZoVX29iiAOoE9q0GRoGRIo42JskoQ9yFZTqGjK/bls/3SMzW2urkYLueDm6PUnfC0b72gTY5OndJiOKbJP+wZwfI8lo+N4EQJHyMQZA35FEzut4kQBco0oUzHwL1VJmJmYbXFW7kb7+i6nvfiAfbgEu/XB9+U4Yql7JmUBlxIOyshyte157pDhlv2tzpdnoS1BSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5lrmHmqOyJ+A+qs9/YYDDHcJpXRTbsltBLht3X/lQI=;
 b=Cl8cd9kzyZ/XgTYBNJlpOLc6rp4IPC938vsZMI4IVYkPRaseoCJL1cocgWxFlFlcSGHx9gNknuNYfnurcDf0bS8KzhU+wUZxrZn4S0MpkamhrAfeZyksjqkOSaCh6yZbGGO485uJCIhS0HR3xbVfp3kwLT0RM7OZl04MXn0nkURvqJ6+1UzWjqwPQ7Yq3xS5Zy7Jx83LfPfWbAGL9yi6BdVUnpvzW09U7JI0Ry+UiIe2fXW0ltWShtq6JnZaA8Lu3SQX95jd4YHiSFaVuPRTJ31HEi9LZpCk/rrm4fd6UFqgkA2qGMyruaKHCz1CQk4P+7aJBREFXpuewT/Ldld9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5lrmHmqOyJ+A+qs9/YYDDHcJpXRTbsltBLht3X/lQI=;
 b=Uo6/uluJVye7U3sELRncBhAqvs3dyn5Vyqx/GN6g6finVAKTqd6UmBgToeD57e/kn5vCGKMTCOygirEHK6RLxh6hf2bK0YVLvF3L2axeRo4bp7cZ3+V4w879gW6RyIXBJAV36ZBsm+CA5g0VvGRyIutUAQaugUFDjoItGqFegFs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB4045.namprd13.prod.outlook.com (2603:10b6:806:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Tue, 29 Mar
 2022 13:05:55 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.016; Tue, 29 Mar 2022
 13:05:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>
CC:     "tao.lyu@epfl.ch" <tao.lyu@epfl.ch>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
Thread-Topic: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
Thread-Index: AQHYQ16YRR1l4u4rz0W8Al1taOBdIazWVLQA
Date:   Tue, 29 Mar 2022 13:05:55 +0000
Message-ID: <4b0d16161fab58dcfba912eb0266a6cd1f83d47e.camel@hammerspace.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
         <20220329113208.2466000-3-chenxiaosong2@huawei.com>
In-Reply-To: <20220329113208.2466000-3-chenxiaosong2@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588f7bf8-a926-4152-aedd-08da1184dc5f
x-ms-traffictypediagnostic: SA0PR13MB4045:EE_
x-microsoft-antispam-prvs: <SA0PR13MB4045AAD1EABA487335DB394EB81E9@SA0PR13MB4045.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbUlO+tZQhAytLFCc3RJtTZ2wavJ6CBm0ydu5XTTShFDhs/N/K5RJFKzvtWg9K5AVpaX+V2H0fl039V5yRGomU+Pn4ol7unvcpUXDjnV5z4bsXREG5h3c/19Xqm2boourwKil2kt0i+eQq98HHbSBcd0zOIqxgZPTf0z97QW5agqQVGICez4B1I2q0QhWK7W3hu2B3FqDOWu/xhX7Vc12H0WnT8SegMKemAeeSnZAPA+tahnnYg8nisUSTawK+ZZs8sx2H7tdIc9GdC07pwKd7GQyqzLHqyErECesfNWF52mzhyOy+JSt/mGijdejai/MScK7ifMfN5pboa3mVhveSCzx7GCAO4gfnSnGviVTXVqhfjnsPFlaPrc5DinKZhzwChFMhcj3M6gxkTStm779KykvjRWLcKNyeTkXPOqQ0DOZHh15JL2hRNh+0Figku223C7/rwKzCEL0MFnc+7QSF5kZNibgCvZ9O82MpPjQjjdC7YC97ISROW56cOkbZdZoZbJ8MHH9INGmtlVafaVjDrdu7tnQK87cUytafKh9LNig64yckMhTKgUoZYZ/ef8weY+ALTVuAGgtdJ6p6rL17T4dfjMzSGZFkwWYtOw4JGPFo341et7INX3CpMEfxxjPTuTebTkuLbJkSxBtuoJO0bffGEc7d4z9B4obJsRMYaEv0up+i1LjE3Z0+CBbqlYkHf3D3yfiqHajyzMVRKAb363fDHjk2NLQL8vz60/sv+cDdb4M+Ex/ZGBiCG4dRiQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(54906003)(6486002)(86362001)(122000001)(8936002)(186003)(26005)(38100700002)(2616005)(76116006)(6512007)(316002)(38070700005)(71200400001)(66446008)(508600001)(64756008)(83380400001)(66556008)(66946007)(66476007)(36756003)(5660300002)(2906002)(8676002)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUFhTWtxSm9EYzFCMVQvS2R3RFBMUTh1ZzEyUmoxVWlxZ1pkU1hkaUR0bkVG?=
 =?utf-8?B?Q2JiYWMyWkpScmp0ejB0NFFVTU5iQmlxOFRwbXd0aGdwMDFIWHJ6blFxTmhG?=
 =?utf-8?B?NTFBaUZPTkt4ZWsrL3FMbmFaYXpkeGFlcVJwNmRsNHdxNjVvMUVKV2RPbE5B?=
 =?utf-8?B?NkF6YzNsYXZ6N1l4OGVwbjFQLzlIVzNabk5FT2VoVjZxc1kyaHYxdDJ2MjNM?=
 =?utf-8?B?aWZpWWlEVUNRSHpFZlFsditoUnV0L3FMVzhkQTIxdDZnMEdrenFhbnlVeTB5?=
 =?utf-8?B?RGU0MmhpaEU1U2d6VUdGZkNGWFNyTjhvU2dTQlhOSFZQUnYwVVRsTXZXTlRW?=
 =?utf-8?B?M1lBeDdKZ0o5SitJTEVoYkM0aFRXRkVScitrNThCZ1JXTjRnT0h3c1NDN0pj?=
 =?utf-8?B?cG56SDVvZjhzUmJ3VXdXRXJINWJDMnlLNFU2VVdERUM0cmpvK1BvK2RFcmJk?=
 =?utf-8?B?dWNTNnFiVEZKVGttbTRwRnNIUXRXUzR4SUJpSVcvWHM5M2xwWkRjZkQrWFVr?=
 =?utf-8?B?eHJrd25FcHVMVnZ0RHpUZ2hCSHVmTmdwZ1NRb3YzQmwyQk4wWGoxc2NMZ0dH?=
 =?utf-8?B?V0tPY2dFajNzNnFMWERwd3Q5ZWZVaXY3Z3ErVGFHcCtmRnZyWXAyZXV0bFdz?=
 =?utf-8?B?TkhsR1Y5VTBzOXRoM1BRRHVnSEc5SU81dkQyR2dFc3Y0RHA3M05hK2pMTDZM?=
 =?utf-8?B?aytGTnh2OWdOcW5oTzVpZWhTTVQ5b3p5MXQ5WFFxMDBRM0FqV0syTDg0K3Bi?=
 =?utf-8?B?UWlPYVRPdW9VTTZqYXRpYVk1NlFIOXBVYkozcEZ5VlB5SHEvaERIcUhpaFlw?=
 =?utf-8?B?cTUrWlJ5UW5CSk5yMkl4L2duTTJxQWIySEJNMzUvZnltWU1XamNpbnB2QXhB?=
 =?utf-8?B?aFhiOW9WOWRMS3JKVUNya3BXVU85WDFiQ2MvRENSUWppeGdhNzdNYmhrVi9N?=
 =?utf-8?B?NG0rVDdkSVJkbWFBLzNYMmZhYkp5aXE0cytDRG83ZnF2U0pYVWdsNzFiZFdt?=
 =?utf-8?B?ZmdVbXBOMjh6VzQzRUYxYVV4enpJeFc5eWJ1RUNlTFoydno0TkVZZmFYQWFs?=
 =?utf-8?B?UlFSS0libUtoMTlOZVNLbFdCNURZQmJsRy9rM2RmQVlFb1VBQmxZdmtMSEZl?=
 =?utf-8?B?Tkh2TERGWEFCMlFXZVZDeUkwZ0xXOGJDSHdnRjZGeWhjTnVjVnIrdExtenVE?=
 =?utf-8?B?RlZmMzFxTlB5N3Rsb2JsWWZxY2NYVVAzdWNIZ3ljRHY5ZTFqSEc3dVBVdy8r?=
 =?utf-8?B?T1R5Q2EwYm1XWmcza0ttUnFMaVRNZkd1NVNudTRrTHBpcEVLVWZid1BVa0kx?=
 =?utf-8?B?THE3NmJuNnBmd0QxZnFnUDM3RjN3TENTekJhaS9KTUJWWnlBWUd5Z0FkMzFD?=
 =?utf-8?B?cFBwZE5Cc0JHWlFPbGM4TCs0aWY4eVBucWtJOHM0NlNDbklFTitib1l3aHN6?=
 =?utf-8?B?UUNFanN5ajROVWNDK2hRZE5oQjF2R051QjRVeHRBeVFJa2MyemNNMlhYRUk3?=
 =?utf-8?B?alVFY28xMlBGbmw3TEZYTW8waUs4ckRpaUl4VXRQUkQvekFHQ3NDR1psWlpT?=
 =?utf-8?B?WVcwRUNxVTdLOXNTaGRHbjFYNGJmK0ZERXAxdnorNG9KQzRMNmxDTm1SWTJ2?=
 =?utf-8?B?RnF2dnY4Ym13M1I2YmNpakZ2NXpaME5zeDBHNGhHZmJxWG95Nm5IMDRpV0xm?=
 =?utf-8?B?cVJJOHRvMTAwMy93NVlMc1ByUmdEK3p2KzhvajNjTXRFQ2NubUxDRG9GZHFw?=
 =?utf-8?B?OUtXWWI1ZFhIZXNSVi9yNUpQeEt4TlY0aElra24yS3E0S3RGYklDUU13bGhE?=
 =?utf-8?B?eFVoclRKRVNWTUNRQ3JWZExHOGRDcEY0eU5lWkp0cW9pYm9EME8rZEZOY3BM?=
 =?utf-8?B?TDFqK2prc0RORHZVbjdINGYzaE42Vk9RdzZLYlU1ck8vK3BjU24zSFlEc3dw?=
 =?utf-8?B?aVB6ck5hbExKWGc4ejJES3ZSbnhUSVB6VFVsTlcrTXBVY0tQUER1NWJkdUlp?=
 =?utf-8?B?RTJzNHliTi82Zi95VW55NjdiZ1lCYjVuQUw5dkRHbFY3NFZDV3NnNDMyM2N4?=
 =?utf-8?B?amRFOFVaZ0c1VHhBdDZVQm5OVGZtRkZybmRBR05MY2JxQ1pWR1UvVm5KSTZu?=
 =?utf-8?B?L094THQrVldzUDVvZGpXY2pvUE9hMm10VTRSRjluSmN1U0lvajYzamFxRDY5?=
 =?utf-8?B?SzZFQmVvMXFOSVprLzkvdDJsNUx1R045aTRNQk83aDV6ekpQc2ZCWEVpbW5Z?=
 =?utf-8?B?clJKSll2MjVHOE9tSXdzODRPVHZWUmUwZzZKLzl2UUYrQmZrTzd2TE9vNzdr?=
 =?utf-8?B?S1EzdkFjVTB3MGo4QnBETFZHdDNObm9LeW1ZSlBSNW9ZSDJLV0tBTDVGN2hl?=
 =?utf-8?Q?jIo7XfvMl0Sa0iHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40F5DD9AF11D634C8B73F2125C1F698B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588f7bf8-a926-4152-aedd-08da1184dc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 13:05:55.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDTKn3205SlOOHi8zaO5H+WzYqk0EXWkAqsgKVYFH2zxSQKDw86cNBltlBzXwaWH4k4mmcpWcHWu/pgvX5gUbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTI5IGF0IDE5OjMyICswODAwLCBDaGVuWGlhb1Nvbmcgd3JvdGU6DQo+
IG9wZW4oKSB3aXRoIE9fQUNDTU9ERXxPX0RJUkVDVCBmbGFncyBzZWNvbmRseSB3aWxsIGZhaWwu
DQo+IA0KPiBSZXByb2R1Y2VyOg0KPiDCoCAxLiBtb3VudCAtdCBuZnMgLW8gdmVycz00LjIgJHNl
cnZlcl9pcDovIC9tbnQvDQo+IMKgIDIuIGZkID0gb3BlbigiL21udC9maWxlIiwgT19BQ0NNT0RF
fE9fRElSRUNUfE9fQ1JFQVQpDQo+IMKgIDMuIGNsb3NlKGZkKQ0KPiDCoCA0LiBmZCA9IG9wZW4o
Ii9tbnQvZmlsZSIsIE9fQUNDTU9ERXxPX0RJUkVDVCkNCj4gDQo+IFNlcnZlciBuZnNkNF9kZWNv
ZGVfc2hhcmVfYWNjZXNzKCkgd2lsbCBmYWlsIHdpdGggZXJyb3INCj4gbmZzZXJyX2JhZF94ZHIg
d2hlbg0KPiBjbGllbnQgdXNlIGluY29ycmVjdCBzaGFyZSBhY2Nlc3MgbW9kZSBvZiAwLg0KPiAN
Cj4gRml4IHRoaXMgYnkgdXNpbmcgTkZTNF9TSEFSRV9BQ0NFU1NfQk9USCBzaGFyZSBhY2Nlc3Mg
bW9kZSBpbiBjbGllbnQsDQo+IGp1c3QgbGlrZSBmaXJzdGx5IG9wZW5pbmcuDQo+IA0KPiBGaXhl
czogY2U0ZWY3YzBhOGEwNSAoIk5GUzogU3BsaXQgb3V0IE5GUyB2NCBmaWxlIG9wZXJhdGlvbnMi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuWGlhb1NvbmcgPGNoZW54aWFvc29uZzJAaHVhd2VpLmNv
bT4NCj4gLS0tDQo+IMKgZnMvbmZzL2Rpci5jwqDCoMKgwqDCoCB8IDEwIC0tLS0tLS0tLS0NCj4g
wqBmcy9uZnMvaW50ZXJuYWwuaCB8IDEwICsrKysrKysrKysNCj4gwqBmcy9uZnMvbmZzNGZpbGUu
YyB8wqAgNiArKysrLS0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9k
aXIuYw0KPiBpbmRleCA3NWNiMWNiZTRjZGUuLjkxMWJkYjM1ZWIwOCAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmZzL2Rpci5jDQo+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiBAQCAtMTg1MywxNiArMTg1Myw2
IEBAIGNvbnN0IHN0cnVjdCBkZW50cnlfb3BlcmF0aW9ucw0KPiBuZnM0X2RlbnRyeV9vcGVyYXRp
b25zID0gew0KPiDCoH07DQo+IMKgRVhQT1JUX1NZTUJPTF9HUEwobmZzNF9kZW50cnlfb3BlcmF0
aW9ucyk7DQo+IMKgDQo+IC1zdGF0aWMgZm1vZGVfdCBmbGFnc190b19tb2RlKGludCBmbGFncykN
Cj4gLXsNCj4gLcKgwqDCoMKgwqDCoMKgZm1vZGVfdCByZXMgPSAoX19mb3JjZSBmbW9kZV90KWZs
YWdzICYgRk1PREVfRVhFQzsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKChmbGFncyAmIE9fQUNDTU9E
RSkgIT0gT19XUk9OTFkpDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgfD0g
Rk1PREVfUkVBRDsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKChmbGFncyAmIE9fQUNDTU9ERSkgIT0g
T19SRE9OTFkpDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgfD0gRk1PREVf
V1JJVEU7DQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiByZXM7DQo+IC19DQo+IC0NCj4gwqBzdGF0
aWMgc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKmNyZWF0ZV9uZnNfb3Blbl9jb250ZXh0KHN0cnVj
dA0KPiBkZW50cnkgKmRlbnRyeSwgaW50IG9wZW5fZmxhZ3MsIHN0cnVjdCBmaWxlICpmaWxwKQ0K
PiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBhbGxvY19uZnNfb3Blbl9jb250ZXh0KGRl
bnRyeSwNCj4gZmxhZ3NfdG9fbW9kZShvcGVuX2ZsYWdzKSwgZmlscCk7DQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvaW50ZXJuYWwuaCBiL2ZzL25mcy9pbnRlcm5hbC5oDQo+IGluZGV4IDJkZTdjNTZh
MWZiZS4uNThlNjE4YTVkODhlIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvaW50ZXJuYWwuaA0KPiAr
KysgYi9mcy9uZnMvaW50ZXJuYWwuaA0KPiBAQCAtNDIsNiArNDIsMTYgQEAgc3RhdGljIGlubGlu
ZSBib29sDQo+IG5mc19sb29rdXBfaXNfc29mdF9yZXZhbGlkYXRlKGNvbnN0IHN0cnVjdCBkZW50
cnkgKmRlbnRyeSkNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOw0KPiDCoH0NCj4gwqAN
Cj4gK3N0YXRpYyBpbmxpbmUgZm1vZGVfdCBmbGFnc190b19tb2RlKGludCBmbGFncykNCj4gK3sN
Cj4gK8KgwqDCoMKgwqDCoMKgZm1vZGVfdCByZXMgPSAoX19mb3JjZSBmbW9kZV90KWZsYWdzICYg
Rk1PREVfRVhFQzsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKChmbGFncyAmIE9fQUNDTU9ERSkgIT0g
T19XUk9OTFkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgfD0gRk1PREVf
UkVBRDsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKChmbGFncyAmIE9fQUNDTU9ERSkgIT0gT19SRE9O
TFkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgfD0gRk1PREVfV1JJVEU7
DQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiByZXM7DQo+ICt9DQo+ICsNCj4gwqAvKg0KPiDCoCAq
IE5vdGU6IFJGQyAxODEzIGRvZXNuJ3QgbGltaXQgdGhlIG51bWJlciBvZiBhdXRoIGZsYXZvcnMg
dGhhdA0KPiDCoCAqIGEgc2VydmVyIGNhbiByZXR1cm4sIHNvIG1ha2Ugc29tZXRoaW5nIHVwLg0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRmaWxlLmMgYi9mcy9uZnMvbmZzNGZpbGUuYw0KPiBp
bmRleCBjMTc4ZGI4NmE2ZTguLmUzNGFmNDhmYjRmNCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25m
czRmaWxlLmMNCj4gKysrIGIvZnMvbmZzL25mczRmaWxlLmMNCj4gQEAgLTMyLDYgKzMyLDcgQEAg
bmZzNF9maWxlX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUNCj4gKmZpbHAp
DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQgPSBOVUxMOw0KPiDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGlub2RlICpkaXI7DQo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25l
ZCBvcGVuZmxhZ3MgPSBmaWxwLT5mX2ZsYWdzOw0KPiArwqDCoMKgwqDCoMKgwqBmbW9kZV90IGZf
bW9kZTsNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpYXR0ciBhdHRyOw0KPiDCoMKgwqDCoMKg
wqDCoMKgaW50IGVycjsNCj4gwqANCj4gQEAgLTUwLDggKzUxLDkgQEAgbmZzNF9maWxlX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUNCj4gKmZpbHApDQo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAoZXJyKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBl
cnI7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGZfbW9kZSA9IGZpbHAtPmZfbW9kZTsNCj4gwqDC
oMKgwqDCoMKgwqDCoGlmICgob3BlbmZsYWdzICYgT19BQ0NNT0RFKSA9PSAzKQ0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3BlbmZsYWdzLS07DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBmX21vZGUgfD0gZmxhZ3NfdG9fbW9kZShvcGVuZmxhZ3MpOw0KPiDCoA0K
DQpOby4gVGhpcyB3aWxsIG5vdCBmaXQgdGhlIGRlZmluaXRpb24gb2Ygb3BlbigyKSBpbiB0aGUg
bWFucGFnZS4NCg0KICAgICAgIExpbnV4IHJlc2VydmVzIHRoZSBzcGVjaWFsLCBub25zdGFuZGFy
ZCBhY2Nlc3MgbW9kZSAzICAoYmluYXJ5ICAxMSkgIGluDQogICAgICAgZmxhZ3MgIHRvIG1lYW46
IGNoZWNrIGZvciByZWFkIGFuZCB3cml0ZSBwZXJtaXNzaW9uIG9uIHRoZSBmaWxlIGFuZCByZeKA
kA0KICAgICAgIHR1cm4gYSBmaWxlIGRlc2NyaXB0b3IgdGhhdCBjYW4ndCBiZSB1c2VkIGZvciBy
ZWFkaW5nIG9yIHdyaXRpbmcuICBUaGlzDQogICAgICAgbm9uc3RhbmRhcmQgIGFjY2VzcyBtb2Rl
IGlzIHVzZWQgYnkgc29tZSBMaW51eCBkcml2ZXJzIHRvIHJldHVybiBhIGZpbGUNCiAgICAgICBk
ZXNjcmlwdG9yIHRoYXQgaXMgdG8gYmUgdXNlZCBvbmx5IGZvciBkZXZpY2Utc3BlY2lmaWMgaW9j
dGwoMikgIG9wZXJh4oCQDQogICAgICAgdGlvbnMuDQoNCllvdXIgcGF0Y2ggd2lsbCBub3cgY2F1
c2UgRk1PREVfUkVBRCBhbmQgRk1PREVfV1JJVEUgdG8gYmUgc2V0IG9uIHRoZQ0KZmlsZSwgYWxs
b3dpbmcgdGhlIGZpbGUgZGVzY3JpcHRvciB0byBiZSB1c2FibGUgZm9yIEkvTy4NCg0KPiDCoMKg
wqDCoMKgwqDCoMKgLyogV2UgY2FuJ3QgY3JlYXRlIG5ldyBmaWxlcyBoZXJlICovDQo+IMKgwqDC
oMKgwqDCoMKgwqBvcGVuZmxhZ3MgJj0gfihPX0NSRUFUfE9fRVhDTCk7DQo+IEBAIC01OSw3ICs2
MSw3IEBAIG5mczRfZmlsZV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlDQo+
ICpmaWxwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgcGFyZW50ID0gZGdldF9wYXJlbnQoZGVudHJ5KTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoGRpciA9IGRfaW5vZGUocGFyZW50KTsNCj4gwqANCj4gLcKgwqDC
oMKgwqDCoMKgY3R4ID0gYWxsb2NfbmZzX29wZW5fY29udGV4dChmaWxlX2RlbnRyeShmaWxwKSwg
ZmlscC0+Zl9tb2RlLA0KPiBmaWxwKTsNCj4gK8KgwqDCoMKgwqDCoMKgY3R4ID0gYWxsb2NfbmZz
X29wZW5fY29udGV4dChmaWxlX2RlbnRyeShmaWxwKSwgZl9tb2RlLA0KPiBmaWxwKTsNCj4gwqDC
oMKgwqDCoMKgwqDCoGVyciA9IFBUUl9FUlIoY3R4KTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChJ
U19FUlIoY3R4KSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
