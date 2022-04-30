Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF6515975
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Apr 2022 02:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381950AbiD3BAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiD3BAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 21:00:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374959AE55
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 17:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH3gI6ATKTcn/vOTVu3cwQgL/0nc7waeMUMn+M8B9+Z7Y6jgyx/46I/o7I44b+/5/oKrzPAvyHFbUw8qCNte5hnlWSyYeAHlzEwSXDrFBcBLR4fCPgId3WT94eipZmNCs5q6OYTIEulcGqifWCuhd/RTVGXlXQ6a7EvFYJ+0c1CpuOkix/4qeefSTBPbsyEcY2m+CV/iykxlYoiy7JIuFRhZzv4k+SEDBA2YPOZECnoTHEAqk8gZwDWOMQZN7oHLHmYrLuJFh1lY4OPF8ZOqoI/8qV3vGQDsmNfO+JFuQxBkIh2aVCCnIh57jkDouGAqNTDDi8MOzcBb3XbldGHwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCpxAvVm1ce89gIuVcZXC2LhND7UK4frtRNu4xyiew4=;
 b=YAPRMaXlRiq56Qy4qWo4Q28wrvqiU9y31N2WrAfUiT9J41mGYDrvoOrzQeJAUi43KDS+nouvfWwRWlj1JmlQak/+pGPKnnEHNtKV6/8JrYx38UPnhfbyuovRFNFTr6/9biI105Ra5F1kM/SCyPtDKU9XuBdUeCrpkNnhqaN7Wq9GbUeb5R8ATo6/talw1+wty/aU0l2g3YEd5yrb2aIOH2BWW2HLEFRobaNbOsn4EWz0uwNv9kizO4D3X8dkIFJVkUh7sMcnBKuJfv93dmVDjRlAp9/69sCYHIdCGgKWXYI++X+0f9dijwSdroiKSxZM9TBWUvWNUpPlfgUHI3UJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCpxAvVm1ce89gIuVcZXC2LhND7UK4frtRNu4xyiew4=;
 b=GWGlB0UAQLS56BIKfdDHhUZ9Dj7o/GiAN3Jw75+7lmcDrZfiyUs8mhgcOrUWkMszAs2ssbRBaBQD9lL31zIi0C3EaNatDSSryIGqAu4k1jACtSviO8Q0xsqZLKnVY9UC6h9RZXM9YK7wt60WhQj/qgLNXz6v5hYD3/BPdaEA/eI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5451.namprd13.prod.outlook.com (2603:10b6:a03:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Sat, 30 Apr
 2022 00:56:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%5]) with mapi id 15.20.5206.014; Sat, 30 Apr 2022
 00:56:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "wanghai38@huawei.com" <wanghai38@huawei.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 4/4] Revert "SUNRPC: attempt AF_LOCAL connect on setup"
Thread-Topic: [PATCH v2 4/4] Revert "SUNRPC: attempt AF_LOCAL connect on
 setup"
Thread-Index: AQHYW/CONs/cqIQZU0+fAIcRVJV8G60Hom2A
Date:   Sat, 30 Apr 2022 00:56:43 +0000
Message-ID: <e10869294d391c9521f35c8564c73a45c21131b5.camel@hammerspace.com>
References: <20220429173629.621418-1-trondmy@kernel.org>
         <20220429173629.621418-2-trondmy@kernel.org>
         <20220429173629.621418-3-trondmy@kernel.org>
         <20220429173629.621418-4-trondmy@kernel.org>
In-Reply-To: <20220429173629.621418-4-trondmy@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ad00e80-de71-4a22-c5cb-08da2a444b1b
x-ms-traffictypediagnostic: SJ0PR13MB5451:EE_
x-microsoft-antispam-prvs: <SJ0PR13MB5451CE63674CCEBE5B22FB63B8FF9@SJ0PR13MB5451.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAH0bRWohHNvjSg7OUlopEv/7PU+T6wc5yhTlBuwLbFuItiQXec0C8xzdO/zporKmAwiEspp0ZTvJQgPNRfrFt52BUbx5jWdmRMkZ0fxrkUcL+G1imyCjv7/vsA+4MAx5iTU9CZlFxmJVgOkRNgNM2Ny4wHmzAsMRiQIBWrCMKPsqR4TbePPBTwcDxQxaUNmpgXmXtqWuEehBZ+rpGgApnc2xBEAqEvqjsNQZBM/hUe6wyIp5H7/BUt/JJlkvnUMsEPazzVPRZOMdbg/FgiF4PhIwdBnoH7LbN14FTG97KB7OWLgM04aCVMYcVKqW4zWOayi92FXaCyfDTPDTnfhl/jj8UrZO25wTxdihG31P8yfuI3Cqcule65a2B7UcpOhM8WSFhDWR6gKCzKly5XFF3f+vTZQdaqecl4hOqyi4JX4aXpMAIB/+xQwj9dHtx5PwQCf8MKKXr8HOqL0N1+55inZGlMucrEnUnofrr1iBsgLrYyckeWuMdw+oRJYDmdHqoKPdJ5wYg0N1dvTBOmdUeewrxgBbefYJQKSv9+yYKdLd6uLRmiNVm1R+ZJ3IxtC4m/dcLZ25kh4+39N5rz+NSy8hneZ2UD/16r0Hox3GukZOUOy1sNygLC5FwKeMPNpocO7h8NviodmrmxlQIPINj0fnxb2fOglHbRyNvVAAP026O62h0elqv2WIKwnEhsQu5BtrSvzQAEECTPQjH5wmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(54906003)(8936002)(2906002)(122000001)(316002)(38070700005)(2616005)(4744005)(6512007)(76116006)(66946007)(66556008)(71200400001)(8676002)(4326008)(66446008)(26005)(64756008)(86362001)(186003)(36756003)(6506007)(508600001)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkpvNmF3QjJOMVR6L0kza3B5Ui9wd2hqZEtHenNhOFdUYU94eXpkMGI1bjEz?=
 =?utf-8?B?WDNlSnFrYldLcHFxQ0ZlangvQ0I2UTFQb2tNYTU5azVqdTFlZUxodGowaExU?=
 =?utf-8?B?RmdFVkhYUm5hUllnRUVJSzhNMmtleDhWZTI5MFc5NCtEQ01nY3FKaUdMd1V6?=
 =?utf-8?B?R3VuSk42cmYvdS9hVE5FMmFlOHREbVpXMlBYWXVqTXlJN1l6Mk96dGVoSi82?=
 =?utf-8?B?cy8weGt3L1RDU1MvTklDUXJ0RExKOU9VOWxXQ1ZYZEs3S3F5V1R5MExLcld2?=
 =?utf-8?B?NXkrbXVjZzZQRC82N2VFbTJBcGs1TklNR24zNUdtRTBSYnRDelZ4R0JrZVVl?=
 =?utf-8?B?S1hTckpLcVE1eFdkYnZadzREZWhmaDJBQlI5TXVzWkp2S2EwOVRFSlBVa1BT?=
 =?utf-8?B?UHB3UE1ibEZwUmtxcWRSeE5VLzdnb2hydThiRUlYUGVucmd1K0RWcGdxTHdk?=
 =?utf-8?B?ck1jMjcyS3AyZFM3aW80T28vckNMaW1TT25HSTFaZ2kzZzNHMnR6d3pQL1p1?=
 =?utf-8?B?VDZVcjlaZnVESU96MEVaVU9tZEZRVncySDcybm1rSUVDUFFtcGdtT0U4NlNN?=
 =?utf-8?B?T210SUZTQXJWSyt1cnBDSUxPRHlJMDdiQzFYbVJYQTQ2RGpSTEFTU0lzeTJU?=
 =?utf-8?B?bUZQcUpPa0FtcTRRb3NZMWpCT2ZQNERWdW90Y3paU2Z1cHdabTFYQWtlc3B6?=
 =?utf-8?B?U3lUaVJpY0p1K1RZY0tPM2JzVjZxTkxDb0VqN0xJdTJBcDdZT0ZSdmdaSWlG?=
 =?utf-8?B?cmVneGhvM29iVmhpejJkWW9pR2VwTXB5MVJGQXJGWDVOVkNYMXpZdmIyTUJ4?=
 =?utf-8?B?T05PODFpa1AzTE11aGRJc1F6dHh3SzIrcGE3MzFkRUJJVGswYXJNdERmbUNE?=
 =?utf-8?B?OHltTU1LK21XVTdlQ1Rib3FGRHA1UDROei9OYUlCbXFNYTF3SWtnZlljUWZh?=
 =?utf-8?B?bXh3Tk8zc2ZkK2tIT0R5LzV6WmhodVI5cGgrWXBVak92ZW9ybW9vOG5oVUF2?=
 =?utf-8?B?NTdzQUVyYkNmekVwdHFUdkQxdFNzNWpNVUVCR3Z0S3VvL3pvQjk0dFBXakZ1?=
 =?utf-8?B?VXpnL1doYVFGS2pPTVBtM0N3aDRPMHljczRmYkNYeldSL0J0cDhlRUJPZlE1?=
 =?utf-8?B?SjN3Vy9sRXg4ZHA4NG9uQVlNbEdhQitVcG4zSkZFRnVsenFlSk5qUmUvb0dy?=
 =?utf-8?B?Wk9uSWYxNGtGVUk3b3VIU0txTXNMYVh0TVVQQ3cycExlVWdtTVNiOUZGZ3FO?=
 =?utf-8?B?YlJ5N1R4Rm9yaHJWZGozNTJobW1iTzg5eEJTcWppMkRiWlBVRjRzR2gzdW9p?=
 =?utf-8?B?M01mTFV4aks1cS9TcDBjbEQ4dFFGU0d5NFlaNnhqTWRYMkpVOHBRUkdsVnBI?=
 =?utf-8?B?QmpUQ2NCak40cFJFQVF6ODFmUWRhOFR0Ynl2aTM0cVF4UnNuM2tLc3B0cm1q?=
 =?utf-8?B?dTBPSEltZmduaS9OVFkzM2czb0R6MERjNE92Q1dDL0N1ZlkwdC9WYTdwSk1R?=
 =?utf-8?B?NkN2cUJ5Wmc1bk5Mc0hiNnVXYThWeXRkTmc4Mm93K2FHcFBsTVlFZFB1Nms4?=
 =?utf-8?B?QjRTbVllODQ0bWZva2JSMEwzUG5tbjE4OGE4WWozdk45ZjVpR3V5ZXp5QVZW?=
 =?utf-8?B?eGYyR2QyVTlmdkdFYjBPVkx0cHpDWXNzWmViK2puZWZIeXBQSGg3UXJadkNV?=
 =?utf-8?B?ZkZxZ1pBQTAyTWxGbVNzVXpuSHdFSytwNUl0dDRVWGd2b0tPcnNXaUQ1NEhk?=
 =?utf-8?B?b2EzSXdNdmtpakxia2xQV1NRV1RnUzdyZEV6S2VyQ2ovOGNaaVJ4bTgvNVNU?=
 =?utf-8?B?a01LV1pPclU1b1lHK0xISFFUYlNaK01IZDBIWnd2S09DcEdxTkEybDJLbVdt?=
 =?utf-8?B?bFJKOUExRlhoNXg1RGdGS214SkRObmhJU2ZlaWxHR2ZzTk1qSmkrREtFSVcr?=
 =?utf-8?B?U3BDRzFVVm9FclhqUmJlMnUrODIvL29tT3ZaZ0RDeE1pdkhFOHFLbE82TUZ4?=
 =?utf-8?B?Y0VFUCtRaVZaOFVoekxmR3BiRlpZZUxmckgrUUJ3NHRTdHNGYUg2Szh2dkRq?=
 =?utf-8?B?V09RSjZDV1J4Q0sxbHhkK0JnNU16azZFQ0xlQ2N2UEFrTWMzcTJqbDJvUlI3?=
 =?utf-8?B?T09SaGlrK0hkVHVQS3JpOHlxYU95TjJxK3JXNHYzcjZjRnh3amVJWVF6TXhi?=
 =?utf-8?B?R0NSS0NxK09ZYnVoYytDQTBDeTY2QTNiUE1pbERQaFl1UHluUWZMbE42V2tt?=
 =?utf-8?B?bTlrZzA3SGFBVlJrZlUzK0lZTVdYQXdXNGlYSStMSmZmOTJXMmtkYk9CVzBh?=
 =?utf-8?B?SlZjWGt2NU9XOFM3aUtTY1lvN2x1c0RKSHZuMXZWY2J1czVJaWVHclFEdzha?=
 =?utf-8?Q?xSQ+TWsQUw962s4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7058CD38729CF47AA15C0D9A1115EB6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad00e80-de71-4a22-c5cb-08da2a444b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2022 00:56:43.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA5LibR9q2uSOQDMpwVwLaDMZ8FQc5pAtq095vpUTxlBf2RB3Oq75XgdX2Tk4j6aCWhaO/rI9LuIwX+6bNndXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTI5IGF0IDEzOjM2IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gDQo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgNzA3M2VhODc5OWE4Y2Y3M2RiNjAyNzA5
ODZmMTRlNGFhZTIwZmE4MC4NCj4gDQo+IFdlIG11c3Qgbm90IHRyeSB0byBjb25uZWN0IHRoZSBz
b2NrZXQgd2hpbGUgdGhlIHRyYW5zcG9ydCBpcyB1bmRlcg0KPiBjb25zdHJ1Y3Rpb24sIGJlY2F1
c2UgdGhlIG1lY2hhbmlzbXMgdG8gc2FmZWx5IHRlYXIgaXQgZG93biBhcmUgbm90DQo+IGluDQo+
IHBsYWNlLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KDQpT
b3JyeS4gSSBpbnRlbmRlZCB0byBhZGQgYQ0KDQoiUmVwb3J0ZWQtYnk6IHdhbmdoYWkgKE0pIDx3
YW5naGFpMzhAaHVhd2VpLmNvbT4iDQoNClRoYXQgaGFzIGJlZW4gYWRkZWQgdG8gdGhlIHZlcnNp
b24gaW4gbXkgInRlc3RpbmciIGJyYW5jaC4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
