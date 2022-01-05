Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7804857A0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiAERte (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 12:49:34 -0500
Received: from mail-mw2nam10on2127.outbound.protection.outlook.com ([40.107.94.127]:37473
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242509AbiAERtd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 12:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWURW4gP94UmAhAJeHFJgTIiKNEufnmyU20eUGq4joQJ2WQ3XoQIYcJA7GgeyGzKkHYG4MvjYu9otSD1quXLzEa03uvV+PciI7GbtIZQJDwjw9wYPd4cNyEWDO4rKfa0oZxSmlTW34MGpcsrPLhLlGYa9R4hn4DJH7oFt50kdZDWz8bAEKnTihwbCCD2Jm35uT5NX6r0HIw2jE+biOJ1MuS7eJtLUvIcmFytB4WA+2fzbuJyOQ57Z3bttwYetkjGnKDQrSyaO0KFkv7xzf4P2a8SdPL5UUKI792aJK128nAu6GtNq5qiLPniQQxhmROFwEPAmkO+bLndYR4Zxv4g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+guZqBAQCqseGcRMHIyrXreGAehb+/XJCKiRUySAQPU=;
 b=M4X2IYd7wMPmKxDX0Peh4j9KGufm/5Nya1pil114vrQUnXhEpkTLIQNlRHzZBW8ugbBEQcXkuSJRM9PjYrGbTenuPZ5UPxxKZPqpv7Q2zUfZPg9udlCK1Y2TTH4qEYEsp3w22iv4+3eNhuUbZiTOdgUDBcSsN/bfxjnPvgd2aiLTWkIUkEQwEqbKUfvwP+sABaA8rVzFb3Pn+w/3vZj3/SkIpNfIhwJ2T7IPRXIHZDUE+7cCNTVyraa2DSHzljMvA96DMgtFuAWkTDElnwJ7M1NExX1ZhipPbYKc9SIpyARF7wAdZ+s42kMUG35FcTn7tvfjuTqFYto06yxkkBhMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+guZqBAQCqseGcRMHIyrXreGAehb+/XJCKiRUySAQPU=;
 b=VuNY2wVJo0zukyHUR8e730a+1EAM6tOrIji0hVbsueKhySUV40Y5MEzw/RZtp5/1Nql+dW1OZcbZvFddIQ5vP/ByEysosZttPAEoJtLrOxrn5KNL8Izb14SI8W02NqcWRjYitfBc9Aft87YKz7q2kQVHnMYbiKqwhK9DWLlKQuI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4763.namprd13.prod.outlook.com (2603:10b6:610:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.5; Wed, 5 Jan
 2022 17:49:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 17:49:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Thread-Topic: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Thread-Index: AQHYAkVETpS/mIA74kSyVJLZ8d1qQ6xUmKIAgAASqgCAAAfHgIAAAY+A
Date:   Wed, 5 Jan 2022 17:49:30 +0000
Message-ID: <363bb79044e91caa5aa49eb22d10edfb751a8449.camel@hammerspace.com>
References: <20220105141841.411197-1-trondmy@kernel.org>
         <20220105143705.GS2328285@nvidia.com>
         <3b74b8f4481ec27debad500e53facc56f9b388cd.camel@hammerspace.com>
         <20220105160916.GT2328285@nvidia.com>
         <f6480329a7d86e5eb10f11b5bc5049868981dd3d.camel@hammerspace.com>
         <20220105174355.GU2328285@nvidia.com>
In-Reply-To: <20220105174355.GU2328285@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c7b4c24-50eb-406a-d59d-08d9d073b9f8
x-ms-traffictypediagnostic: CH0PR13MB4763:EE_
x-microsoft-antispam-prvs: <CH0PR13MB476335269763D64E217AA72DB84B9@CH0PR13MB4763.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1M8lUjm1aCOXsQA/KeyFhHo0FfmkKsnjLW7HD0rYOl16UI1Cxe3A1hA4z75WBKNbTUqFMIhY68irxP60MVL883eQsNF6vmV2ojCO19u0g4bln94EYzdjDXe1yHDgGZZNb99PSB8gLBCfBoA41IaV3UEoLoVke2aiJqIhiVfySgD8lWwC6MeCqEVuxm2GGQjXyQ7rPuKGbDs5p26GpXWOoV3OPEh/DbPgigqk1XKhUeP4qyFeh4QE72LDC11V4J9DcPdZtaIGEeT1Q37rE+X2JoHWtHW6/sZwA7HZp44uIpusOCNei619fl3/t2+5bt+2A8UOXeNWBb68DkC389CGfrX36U2y11v3Zt+DXs6HTdScgNDRBkaPPbMbhMctPgt3SKhLyqwEvr4+2HATxIo6M/txvVc203gs4dvQ9WNw/EvjtMPpgaD93Lbu4VdOqA8YvDUOzTXGBPjqDUWnaloWtP/k6ZyOLEF1GbTdwDPw0uBdQx26d/77EtWjBNUdAq2/1Dtz1qek5atN1kRQC6C++2VJj/SfxmSGESGJzPv3XJKtE2ThGbQ3P9qvMxO9NjZE2WR+y99V7RxsimpofGLRxFtBcmIFTOxwkEJB6/6ca6SbFLdNCCIENydNslekLPJRfcpwip9FMRVIEEAK81DgM9fqe+t/fw1dMspG2Tqrfev+JV98ZV9kx05pYWlkgnUTbbKyxzvE/+Owad7oa5ViI4U4EJXTGo/r21/KmwG19/8ezL/LxOFv9on3D5uB0oUVLi7o8sLaD33eEdJXeULpxSKWlkW0TbLJlAv9SDxHQL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(136003)(39840400004)(366004)(376002)(396003)(8936002)(26005)(8676002)(186003)(4326008)(64756008)(38070700005)(5660300002)(2616005)(6512007)(54906003)(66476007)(66446008)(66556008)(76116006)(36756003)(508600001)(6486002)(2906002)(66946007)(38100700002)(122000001)(6506007)(86362001)(6916009)(4744005)(316002)(966005)(71200400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlNLy9haE12K0dPT2o4MFNRQ1hxaE5VeTU5WUYxNHZCdkNMU0dUd3MrOGZY?=
 =?utf-8?B?SnB0R2RtcnFVT0VEZUJLK1hiNjN1U092eU9WK1NxbDh3dFRpZ1VVbm5QNm9D?=
 =?utf-8?B?TVVUNWlxSVF3S2hvbFdjM1FQcFozWUwxdG5kUG9wTVhOTm5UUWEzcjZjNFNB?=
 =?utf-8?B?RVEyNGFXeTduT1B1S1JyRDB2TUJnb01FaURFRlJJeTQwR0s0aFhHUFBIanhq?=
 =?utf-8?B?dHFUdlZlcFZ6aTdiY29hWTBNWGI4Q05wOGc2emJDNWRmUVUzQlBuSTQva2pY?=
 =?utf-8?B?MDJEaHo3MlRrSU5YcUhPM1g5Z3d4QnE3RWMrQzdxRjh0LytydUhFOVA0Z3Uy?=
 =?utf-8?B?aGVRTnRCbnRJbkZUSjlPRWJPL2p5TDdIdE8wNE5saE5TcjJBeHljQW1lZko5?=
 =?utf-8?B?bTlSMURITnNWT1RQeHhHOFA1ZVZtZG1lUmduQmhwelhxUGdQQ2tjTllVK21o?=
 =?utf-8?B?anNKaUJXTUFLK3RQQUMvbXZOalhPSDdBdG9hY1d1WDV5amR5N3hLdW9JbHJQ?=
 =?utf-8?B?OTJJejJQV1VsOUUxTzdzdnVhWVpmQmVPV2ZsV28wOURsMFVrZHJkZUlRVUM3?=
 =?utf-8?B?VzVFTE52aUd1N1J5K1dKTW1qVTRhWWEzKzYvTGNDMW1iOEgwMnNtZ3RHajJo?=
 =?utf-8?B?L2NWcnJTc1AzdkdZYjI1WUxGWTVjWmFCZE1pU1EwclUwWksvcDRteW81bEh6?=
 =?utf-8?B?TVdxZ1ZDY09zdVV1YjhtVlhqVkc5bU1MaGlNM1JvZUFFZEtJT29tN2xlT01J?=
 =?utf-8?B?d1c5WTVWR0Fkb2ZkNklpY0s3Yksya2ZiYiswSncyVnU1RUR5c0FjcVFHc2Yy?=
 =?utf-8?B?SkxzVUpCUFhzNUZCaHFBYkFnVFU5Ym0xc2I0TmllRHp2MWhwaE9KWWhMdHRO?=
 =?utf-8?B?QUlDTStzcXYybm9oMmRMTDVuTFhTNW5JY0JlRFRBRWwvZ21HR0cyNmlzTHY3?=
 =?utf-8?B?WnVSYjZiUUZOK1FHL0twdVAveGp1U054VXhBTlJHcHFkRUVsbDZRZ2pUalNP?=
 =?utf-8?B?QUdwNDR2Ui9SZ3N4RExjcWZmVHJPVUxKU1BxeUY3R2ozRU9BRUd0ZUJIOGpu?=
 =?utf-8?B?UEJ1bDNQY3NNZ0dpODloaWV4NWZubDkzNDVuazF6cFhSQnhFejZwQnE0cmZw?=
 =?utf-8?B?Y0RCcWFKSVg0RGtpRGNWZnVGRHBwMGdNT3ZIdkoxR21KalNmbzA4S1BIVXlr?=
 =?utf-8?B?MldFdGQxekdRcVJTZzVicWk3aGRxTTN3YXZTT21Mb1FWTmlUWDBCQ093cUdH?=
 =?utf-8?B?dVErSy85R0x1bWVCRmFJbDlpcjFBenBMcTQzTmtkVUZrNkJIdWV1ZzdKTjZQ?=
 =?utf-8?B?WktyTStBSmRSdDQ2d05GVnJmN0lPVjZWYnNwV1FzUURyZHN1c2Z4Q0tETC9G?=
 =?utf-8?B?R1haWFFkd1Z3eFVhWkIrbjJMUU1wSW1PTERnTHFMYlVUM1poVFExYW10NmVR?=
 =?utf-8?B?M05Xck5Iby9KV3FRODFxMEJtZktCRHFKbmMvYXBjL2tpSWprM2YrcHM4aXFZ?=
 =?utf-8?B?eE9WN1MrbTdwMlVYdWRuYlIrSm9TS2FRUWlLdHlFK0hPaFA5TmgzaXp3ZHhL?=
 =?utf-8?B?TDExdE1GaEtPSytBQmRwVElvOUZZODEwZ2JLQWEzWWlhZERkVXVPU2E5S2h5?=
 =?utf-8?B?ajR1VE1xUUVnU0VyUVJreHRmZEZMWTJsSHd5MVF4M2Zqb0lMVkJIUXdqSmZp?=
 =?utf-8?B?NFBTQjA1Z3ZDemdxdW4vRG9PTktTTWQxMVkxYkcrd0FyYTFmNktHZTZCWkZP?=
 =?utf-8?B?K0dlN0lDMVk3ZE00enFNTUNscUJoNGM4R005djdTZG5vaGxVNkxjR3M4aWth?=
 =?utf-8?B?SldRNVJ3M0lmRjJJK2tRTjJGcjhIVDdpb3NvQlNvWWhaMFc3Sm42cDUwdG1t?=
 =?utf-8?B?VWc0VlBPbU1XSWZOUXd2TVo2THU0YXpDcjJhV1lMT3o3b0U1SitpWUhENVBZ?=
 =?utf-8?B?QjBSakV0TkhBRkpQaWljRXI5S3JxYnVLUzg5Y3lKUUN2bk4zT0ZsRnRXVDBF?=
 =?utf-8?B?Szh2d3lkRU5uWFhKVEYrcklreDVxWjIvNW1vSURWLzJnbC9CNHdyanVlWTFX?=
 =?utf-8?B?K2dTcVJ3KzlCQUpMaHgyWEJqaDdpWDhjOTdGYjJ4b2h1eStMY1FhZjY4STYx?=
 =?utf-8?B?R3hORGI1RGZrYlBieW5jb0UzbWRUUlVTYWJ5Z3FiU1c4RXUyZmhTQlRDU1ov?=
 =?utf-8?Q?GjWHUitjvDqJsGpR5XAUJc8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F7A61504B16894584AC7325BA84F276@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7b4c24-50eb-406a-d59d-08d9d073b9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 17:49:30.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJNkX2fw+wC1hbm5zk4GF8qmTcn7IkMi1Ufce83SQ0t7kI18kyzW+QS0Z5bxEnW84YYsWJQLpIjE3iR8snam5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4763
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDEzOjQzIC0wNDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDA1LCAyMDIyIGF0IDA1OjE2OjA2UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiA+IEknbSBjb25mdXNlZCwgUlBDL1JETUEgc2hvdWxkIG5ldmVyIHRv
dWNoIGEgdW1lbSBhdCBhbGwuDQo+ID4gPiANCj4gPiA+IElzIHRoaXMgcmVhbGx5IHRoZSBvdGhl
ciBidWcgd2hlcmUgdXNlciBhbmQga2VybmVsIE1SIGFyZSBnZXR0aW5nDQo+ID4gPiBjb25mdXNl
ZD8NCj4gPiA+IA0KPiA+IA0KPiA+IEFzIGZhciBhcyBJIGtub3csIFJQQy9SRE1BIGlzIGp1c3Qg
dXNpbmcgdGhlIFJETUEgYXBpIHRvIHJlZ2lzdGVyDQo+ID4gYW5kDQo+ID4gdW5yZWdpc3RlciBj
aHVua3Mgb2YgbWVtb3J5LCBzbyBpdCBpcyBkZWZpbml0ZWx5IG5vdCBkaXJlY3RseQ0KPiA+IHRv
dWNoaW5nDQo+ID4gdGhlIHVtZW0uIA0KPiANCj4gSSBtZWFuLCBSUEMvUkRNQSBkb2Vzbid0IGhh
dmUgYSB1bWVtIGF0IGFsbCwgc28gc2VlaW5nIGl0IGFueSBzdGFjaw0KPiB0cmFjZSBzYXlzIHNv
bWV0aGluZyBpcyBjb3JydXB0ZWQNCj4gDQo+IEkgc3VwcG9zZSBpdCBpcyB0aGlzOg0KPiANCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMTIyMjEwMTMxMi4xMzU4NjE2LTEtbWFvcmdA
bnZpZGlhLmNvbQ0KPiANCj4gSmFzb24NCj4gDQoNCkFoLi4uIFRoYW5rcyEgSSdsbCB0cnkgdGhh
dCBvdXQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
