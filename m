Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448C528CBC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiEPSQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbiEPSQ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 14:16:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB13EE1C
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 11:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs8VGmmJ+3wg6caMmy6iBOhxgxEhfeV5dQggd2uGERMrVL6Rsb1TvQ667FdRH4PEoucwmDJNiQSh9iCGxP4s1HfZXXxKJbVLCY/3LLkx3egF6woIRGHDF5GP6PT4wNkx9uoJHN4JlCGDkLNqJrZl2roCQa8gkuiI7EBkBgZOBGxeYFaYna9FzEkx2mglrmDu6ODlVbgT71pJCA9y8Jhv2ouoVAf2ieXBbTeSHvRgFJnjwsRTUsgamjEERg2Hs01GTlQvhfTsvCJFY6LwUkGyB3r5iif9SuhEg+Pt+B3DReiHyF4resQAmxWywFkn81IfGqaHEnhoduZnGggCeqctEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZSdCnwEQLfC70K9IO/G+5Ct945qh40t3E1AlJ80QLE=;
 b=nTUN0Q4PGPndLfdZmjKjvFmUFR67vJesxctx+m6skuwZV49soJncJkZhxJJX4BUYoeAUCbL1GJ0zZ3YIg4yBCeDLeSIPp3DgmGJunqEJGJLpbbEDGSFYVnT/MHwLXvodIx/NXHox9Re36Od1RqL2qjeQFng/+gmSNhK7DrEeXVgE5hNWApDceH5IbPeer9IftL9WSnNFIUVbwxCNef9UBwp+kPrELgwBI8ezGkjvyeGaMQ54xfa14fXHkzdPtkg4ZErYGb2J8AMueKDgmZq2flXLC+LcnPgZvWbEEMcS8HUR59+jXVazIPGN7/YJWkbJBi6+oEvsEgFWQ5ZmM0c87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZSdCnwEQLfC70K9IO/G+5Ct945qh40t3E1AlJ80QLE=;
 b=ZCENn/lk6HYe7Qu2dcwwsx7ehy55SfyITl299IDMgiEHnhuZNSO9PlSCRcyS5/zr8SbCes8Iq2VdDsL5BrjFSrDBbIuIRUH/dyZ96qpQLMzuKRcXem9ywse+j0VouyMohyQuLhl9YU2Kw7OtE3K7YGVfJiX65f4qZkHo5wHtwA0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2876.namprd13.prod.outlook.com (2603:10b6:5:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 16 May
 2022 18:16:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.013; Mon, 16 May 2022
 18:16:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1 mark qualified async operations as MOVEABLE
 tasks
Thread-Topic: [PATCH 1/1] NFSv4.1 mark qualified async operations as MOVEABLE
 tasks
Thread-Index: AQHYTzl9PY7GM4ygGUaMqzivNhOCwK0h506AgAAcdQA=
Date:   Mon, 16 May 2022 18:16:50 +0000
Message-ID: <317febc7f8a3264c78b34bc6e022f2b373b6aaa4.camel@hammerspace.com>
References: <20220413132207.52825-1-olga.kornievskaia@gmail.com>
         <CAN-5tyFJeLWi5UYYSvaYspwOn3VhGMQkKx-QQkXSX1ZR+guD8g@mail.gmail.com>
In-Reply-To: <CAN-5tyFJeLWi5UYYSvaYspwOn3VhGMQkKx-QQkXSX1ZR+guD8g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ff18eb-a634-4852-dba0-08da37683fa6
x-ms-traffictypediagnostic: DM6PR13MB2876:EE_
x-microsoft-antispam-prvs: <DM6PR13MB28764EA51B4713E7D4D646F6B8CF9@DM6PR13MB2876.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaK6/ZY4VS8WSwvg9mqADKmi6HzfllUiZeHfEF32dwCDs3mXg6bmOA2UjT4LJjATsQCKJp5Ce9JrzUGDmc59QUx/HKhawJB1y13jKqepL4RWbHD94U2m9+attaA9Hfy92uGPADKLnALRuR01MjvRQ4uSId9d8PTkZVU6ZPAbbVZrDMRJAdhGF74sSshj59/K5L/KGqzUhgi8zcf/uKsAsXgMUk1+MIYCtXqL834h6kG0oRn9lPlHzGf2nbU3LRwAJdPI7bpE1lnPtQBDR1cH1Kv2RliJsABo7rsCDSghX5xv04u8JLcSbX2mc/buLfz/wmwIIuDmlpmHrxLsDRAXnt5JqM/ZqYv/PHsdxD/ytCk2wsPetr+npio3LK8uF65x043ipO5NDN0nnr16pZjnUfhp7QDjIWCmrzpxFvjZNQAOVZKg055i96NEu7rmXRSBHWtqg7vm7L4KwPwKDqmPSeK3OJwiOCy8gDeh0vD5GVqI6WbUmuQ1gzj2WpJGaiiDLvezyZsLDTG+tTfSWsdVcUo4ZkvvlJJL2L7Wqay3EtoBYi5PQFHcAAk8kHzhB5z/vkhAD2+Hp9oxzjAwmo55yjmQxh/FAAHtHZ38FBoR/S03TU4OXaKPxhP3VUPhgAUAeolAeIyBGnoRE7/K7dOxRzkHG3ZiM4OqY1W3lKV5J1OrbIq8kW7ryCz2bv6v5k0lFPxRE8NIfpKoKThnt3NRWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(186003)(110136005)(2906002)(316002)(83380400001)(76116006)(4326008)(66556008)(66476007)(64756008)(8676002)(66946007)(36756003)(66446008)(38070700005)(38100700002)(71200400001)(6486002)(508600001)(8936002)(26005)(86362001)(6512007)(2616005)(122000001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmlDdGpPUzQzelZURG5OK0JpTS9Qby9kTTFaSTFSbkgxVDJ0K1BFeEFTYlg3?=
 =?utf-8?B?emRLdllEWkg4RFppWnpkMlhOc1RUSkhleEUzMnd4bEU5bHJnbUtLN1YrQXo4?=
 =?utf-8?B?NXZOUkhVczN1amlTVXk4MEhmb2txUFNSRG9GU0N1TURSWXdlS3FUMktLZ29a?=
 =?utf-8?B?b0haS2RWME1rZTEyc091cGlidGNGa1RISUhzbGdIbW10WmNFU3JHZW9rZW9P?=
 =?utf-8?B?RjFZa2M5V2xpeityNEhWVE10WEtKcmw2b0g3dWtnMXRFQ1BHQVRGQ0RsQVUr?=
 =?utf-8?B?SThpNEdieGgrOHZ1cEZKdCtMUU1nMkJwQ1BoZTFwcjVkd1ZxbjhVQ1JENEtX?=
 =?utf-8?B?ODgxb01lZm56SGllSjk3S0g3RDQ4d0UvR2dwTmpWYzR3UGw3NUhlcmM3c3I3?=
 =?utf-8?B?Sk1COGpUQ0orWkJFOGoxZVY2NWZUakhsYTdYeGp5WjAvZVhob3JoZzNHbEZL?=
 =?utf-8?B?UFNmREI3aE41eXA0MXNMZjhpR2RYRTk0eHA1elVyWC9zWGJXTVhFU0luaWZG?=
 =?utf-8?B?aTNGeDg3S09TM0lNbXhWaEt4b2pPL3FDV2RLSXZLU29VV2tha2pnQnIyMU9X?=
 =?utf-8?B?cmZwaVFSd3NaZlFOVHV0NUZQZ3MwekVJTHBiUUxYSW9DUnNBTEx5Z05SRzcr?=
 =?utf-8?B?WkM1bzlDZWJxZ01Sa3ZtTU1QSmsyVXNib2k2WldHWW10Z0FkL29WbGxWNkgv?=
 =?utf-8?B?eWpaQWtnTFNpV1BRWVc1aTlQT0FaNjF6MGY3QUMwdjRZbDJ3MU5FMDlVLzFZ?=
 =?utf-8?B?U2xIaE5TbVVNWHh1N3VQSW5CcTJzVytXaVhhcHBBVTBGL0l5cUxjS2tQY3Rh?=
 =?utf-8?B?eVkyT1ZjOFdPaURNQmRKcTZBSmU0L0tiODdDKzh6MG8xLzl0WHN4TTh0Mm9x?=
 =?utf-8?B?Y0dJV2lFTFp5Y3lvNjlaZEZubkYySld0eUFjWFJ3SjI4Z3hpNUUzNENIZ0VG?=
 =?utf-8?B?OTM3S0tqQmVKQk1jQTdRMG5FK1VoUU5ENmVBU2dvejZBWisraGN3elRaeXFh?=
 =?utf-8?B?S2UrL1M5UVh4MzdYc0M1SVk4Zzc5ekEwU1pqZG1jRmZCZEdBcHJwMVN6cit6?=
 =?utf-8?B?dU5BVEFtLzkxeGcwNEdGVzgwUVVDN2FxbGUzcjhMT3BjRE9tTzNGV2oxRStX?=
 =?utf-8?B?K2J0ZE1xODQ3TCtFRGlDTXdiTXhZcXcrYlg5Z2w2N0s2cW1lTUpxZHAvbjk0?=
 =?utf-8?B?ZDVGTXRROHJiOERRbFpOTXk3WHNsV0dFY0xSN3lqNk9JbXpYY1M0YkRNMjBR?=
 =?utf-8?B?ZEg0RUFqTjRtUmlIQkVqQVR0Um84YnAvdDhDc3QrRXZSQUZIK1VwUGpEUXVu?=
 =?utf-8?B?SXh3dnE3YlJya0E2Y0FxblJIbnFkSVhHTG9TaTFlMUMyWFFhVEVwU21DcUlk?=
 =?utf-8?B?YXVJOC9jTHhaWnpKUXIrTzg5eXVwY2dSemlyR0phSGFudHpnUHB2THFVN00x?=
 =?utf-8?B?YUhIaHpTUUdHOVZ5MWdnR1l5SC9SR1NoRWp1RUxEemZrcElPVE1ZZjNUSGxV?=
 =?utf-8?B?L1kyWG9Bdzd3bEsvOFJ5NVVOWnBHc0xpZy9jU1VvNFBuWFhOT2dQTHpTUFkv?=
 =?utf-8?B?UWY0ZmlXdkg3bEtONFJQcEpwdTY2Z0srK0RwVUtONjF4b3ZhVFB0OFBWZTN6?=
 =?utf-8?B?a2MrakxFbU55WHoxQlUrT2RUcHRvRER3NzI4MW96L1h1YVNLSjlOdUVkakZY?=
 =?utf-8?B?VDROOHlIbHRRZG9PZ1dEZkZJZEdmWEhSb1RlajNydnB6ZEZZcHZCVzhkRDkw?=
 =?utf-8?B?amJLUjJFVXZWdFVLUk41a2pURjFobUFXMTIwUU1YaTVyKzRIS1RLYklPbmR6?=
 =?utf-8?B?b3ZZV1libTFoMlc1RFV6UmdTek9LVGdFeS91ZHNxV3NydjNIR2NFUGpyZDFM?=
 =?utf-8?B?b1hIOHg3aW93bU9BV1V5cFV1bExyZmEyNVBjR2tYTWlYUmRtS2Vua3pIcjQ0?=
 =?utf-8?B?cFc2K0ZRKzhUWHMvaDEyaE91ZkpVaytreHJKd1M3clFPSWhuMVR4Q3FycFYr?=
 =?utf-8?B?Y2FuMXZTVkFQR3J2a2NmY2FlYzBPbzgrREJiMFYzMHdBOG1IVjhDQy8vMThi?=
 =?utf-8?B?N2gvcThIMDQxT214MFhTVWJiODh1NlowRVljQ0VyY3lBUmFzODAzWVRsWnVw?=
 =?utf-8?B?ZDlmcXh6aThqamFwN3EwMEFvSjZNSGVsTFJUUHAySWZMQ0hVTlM5UFhmUzVw?=
 =?utf-8?B?NVE0ZURCY2hqU1JmZzJwU2RSa0tYbDEwLzZYVm5NTG1TRkd0SEExZ0hrRmNW?=
 =?utf-8?B?ZFdkY3k2ay9UMWRmTmVycW9PeHpXclphUkU5WXc0VTJxZ1VzbmVLY3BnSE81?=
 =?utf-8?B?cHFaUE94bWVQRjBaeVg3azR6SDVyUnpxMnVKdnFaR3BicHJ3clNnbE1ENEU0?=
 =?utf-8?Q?rRHk6uQjz9tjAs3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFA979E87B2264B8E76199EA037F1BF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ff18eb-a634-4852-dba0-08da37683fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 18:16:50.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgFEvGHK+Iks++U6hEkBA3Db/EbU8kk0aRn5KlQyoVcBDlntzhPuktEd9ock5NPcqJSzHUzeqzDjxGS8/+qdZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTE2IGF0IDEyOjM0IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBIaSBUcm9uZCBhbmQgQW5uYSwKPiAKPiBBbnkgdXBkYXRlIG9uIHRha2luZyB0aGlzIHBh
dGNoPyBUaGFuayB5b3UuCgpDYW4gd2UgcGxlYXNlIHJld3JpdGUgdGhpcyB0byBub3QgdXNlIGNs
cC0+Y2xfbWlub3J2ZXJzaW9uPyBUaGUgcHJvYmxlbQp3aXRoIGFzc2lnbmluZyBmdW5jdGlvbmFs
aXR5IHRvIHRoZSB2YWx1ZSBvZiB0aGUgbWlub3IgdmVyc2lvbiBmaWVsZCBpcwp0aGF0IHlvdSBo
YXZlIG5vIGd1YXJhbnRlZXMgdGhhdCBmdXR1cmUgbWlub3IgdmVyc2lvbiB1cGRhdGVzIHdpbGwK
c3VwcG9ydCB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5LgoKSSdkIHRoZXJlZm9yZSBtdWNoIHByZWZl
ciB0byBzZWUgYSBjYXBhYmlsaXR5IGFzc2lnbmVkIHRvIHRoZSAnUlBDIHRhc2sKaXMgbW92YWJs
ZScgZnVuY3Rpb25hbGl0eSwgYW5kIHRoYXQgYW55IHRlc3RzIHRha2UgdGhlaXIgY3VlIGZyb20g
dGhlCnZhbHVlIG9mIHRoYXQgZmxhZyAoanVzdCBzZXQgdGhhdCBmbGFnIGluIHRoZSAnaW5pdF9j
YXBzJyBmaWVsZCBpbgpuZnNfdjRfMV9taW5vcl9vcHMgYW5kIG5mc192NF8xX21pbm9yX29wcyku
IFBsZWFzZSBhbHNvIGNoYW5nZSB0aGUKZXhpc3RpbmcgdGVzdHMgaW4gdGhlIGNvZGUgdG8gdXNl
IHRoZSBuZXcgZmxhZy4KClRoZSBzZWNvbmQgc3VnZ2VzdGlvbiBpcyB0aGF0IHdlIG1vdmUgdGhl
c2UgdGVzdHMgdGhlbXNlbHZlcyB0byB0aGUKZnVuY3Rpb25zIHRoYXQgc2V0IHVwIHRoZSBSUEMg
Y2FsbC4gSU9XOiBuZnNfaW5pdGlhdGVfcGdpbygpLApuZnNfaW5pdGlhdGVfY29tbWl0KCksIG5m
c19kb19jYWxsX3VubGluaygpLCBuZnNfYXN5bmNfcmVuYW1lKCksIGV0Yy4KVGhleSBkb24ndCBu
ZWVkIHRvIGJlIGluIHRoZSBycGNfY2FsbF9wcmVwYXJlKCkgY2FsbGJhY2ssIHNpbmNlIHRoZXJl
CmlzIG5vIGNvbmRpdGlvbiB0aGF0IG1pZ2h0IGNoYW5nZSB0aGUgb3V0Y29tZSBvZiB0aGUgdGVz
dCBvbmNlIHRoZSBSUEMKY2FsbCBoYXMgYmVlbiBzZXQgdXAuCgo+IAo+IE9uIFdlZCwgQXByIDEz
LCAyMDIyIGF0IDk6MjIgQU0gT2xnYSBLb3JuaWV2c2thaWEKPiA8b2xnYS5rb3JuaWV2c2thaWFA
Z21haWwuY29tPiB3cm90ZToKPiA+IAo+ID4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdh
QG5ldGFwcC5jb20+Cj4gPiAKPiA+IE1hcmsgYXN5bmMgb3BlcmF0aW9ucyBzdWNoIGFzIFJFTkFN
RSwgUkVNT1ZFLCBDT01NSVQgTU9WRUFCTEUKPiA+IGZvciB0aGUgbmZzdjQuMSsgc2Vzc2lvbnMu
Cj4gPiAKPiA+IEZpeGVzOiA4NWUzOWZlZWFkOTQ4ICgiTkZTdjQuMSBpZGVudGlmeSBhbmQgbWFy
ayBSUEMgdGFza3MgdGhhdCBjYW4KPiA+IG1vdmUgYmV0d2VlbiB0cmFuc3BvcnRzIikKPiA+IFNp
Z25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPgo+ID4gLS0t
Cj4gPiDCoGZzL25mcy9uZnM0cHJvYy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKystLS0tCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYwo+
ID4gaW5kZXggMTYxMDZmODA1ZmZhLi5mNTkzYmFkOTk2YWYgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9u
ZnMvbmZzNHByb2MuYwo+ID4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMKPiA+IEBAIC00NzgwLDcg
KzQ3ODAsMTEgQEAgc3RhdGljIHZvaWQgbmZzNF9wcm9jX3VubGlua19zZXR1cChzdHJ1Y3QKPiA+
IHJwY19tZXNzYWdlICptc2csCj4gPiAKPiA+IMKgc3RhdGljIHZvaWQgbmZzNF9wcm9jX3VubGlu
a19ycGNfcHJlcGFyZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssCj4gPiBzdHJ1Y3QgbmZzX3VubGlu
a2RhdGEgKmRhdGEpCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqAgbmZzNF9zZXR1cF9zZXF1ZW5j
ZShORlNfU0IoZGF0YS0+ZGVudHJ5LT5kX3NiKS0+bmZzX2NsaWVudCwKPiA+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IG5mc19jbGllbnQgKmNscCA9IE5GU19TQihkYXRhLT5kZW50cnktPmRfc2IpLQo+
ID4gPm5mc19jbGllbnQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGlmIChjbHAtPmNsX21pbm9y
dmVyc2lvbikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhc2stPnRrX2ZsYWdz
IHw9IFJQQ19UQVNLX01PVkVBQkxFOwo+ID4gK8KgwqDCoMKgwqDCoCBuZnM0X3NldHVwX3NlcXVl
bmNlKGNscCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJmRhdGEtPmFyZ3Muc2VxX2FyZ3MsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZkYXRhLT5yZXMuc2VxX3JlcywKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzayk7Cj4gPiBAQCAtNDgyMyw3ICs0
ODI3LDExIEBAIHN0YXRpYyB2b2lkIG5mczRfcHJvY19yZW5hbWVfc2V0dXAoc3RydWN0Cj4gPiBy
cGNfbWVzc2FnZSAqbXNnLAo+ID4gCj4gPiDCoHN0YXRpYyB2b2lkIG5mczRfcHJvY19yZW5hbWVf
cnBjX3ByZXBhcmUoc3RydWN0IHJwY190YXNrICp0YXNrLAo+ID4gc3RydWN0IG5mc19yZW5hbWVk
YXRhICpkYXRhKQo+ID4gwqB7Cj4gPiAtwqDCoMKgwqDCoMKgIG5mczRfc2V0dXBfc2VxdWVuY2Uo
TkZTX1NFUlZFUihkYXRhLT5vbGRfZGlyKS0+bmZzX2NsaWVudCwKPiA+ICvCoMKgwqDCoMKgwqAg
c3RydWN0IG5mc19jbGllbnQgKmNscCA9IE5GU19TRVJWRVIoZGF0YS0+b2xkX2RpciktCj4gPiA+
bmZzX2NsaWVudDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGNscC0+Y2xfbWlub3J2ZXJz
aW9uKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzay0+dGtfZmxhZ3MgfD0g
UlBDX1RBU0tfTU9WRUFCTEU7Cj4gPiArwqDCoMKgwqDCoMKgIG5mczRfc2V0dXBfc2VxdWVuY2Uo
Y2xwLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
ZGF0YS0+YXJncy5zZXFfYXJncywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgJmRhdGEtPnJlcy5zZXFfcmVzLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXNrKTsKPiA+IEBAIC01NDU3LDcgKzU0NjUs
MTEgQEAgc3RhdGljIHZvaWQgbmZzNF9wcm9jX3JlYWRfc2V0dXAoc3RydWN0Cj4gPiBuZnNfcGdp
b19oZWFkZXIgKmhkciwKPiA+IMKgc3RhdGljIGludCBuZnM0X3Byb2NfcGdpb19ycGNfcHJlcGFy
ZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmZz
X3BnaW9faGVhZGVyICpoZHIpCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqAgaWYgKG5mczRfc2V0
dXBfc2VxdWVuY2UoTkZTX1NFUlZFUihoZHItPmlub2RlKS0+bmZzX2NsaWVudCwKPiA+ICvCoMKg
wqDCoMKgwqAgc3RydWN0IG5mc19jbGllbnQgKmNscCA9IE5GU19TRVJWRVIoaGRyLT5pbm9kZSkt
Cj4gPiA+bmZzX2NsaWVudDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGNscC0+Y2xfbWlu
b3J2ZXJzaW9uKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzay0+dGtfZmxh
Z3MgfD0gUlBDX1RBU0tfTU9WRUFCTEU7Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChuZnM0X3NldHVw
X3NlcXVlbmNlKGNscCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgJmhkci0+YXJncy5zZXFfYXJncywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmhkci0+cmVzLnNlcV9yZXMsCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhc2spKQo+ID4gQEAgLTU1OTUs
NyArNTYwNywxMSBAQCBzdGF0aWMgdm9pZCBuZnM0X3Byb2Nfd3JpdGVfc2V0dXAoc3RydWN0Cj4g
PiBuZnNfcGdpb19oZWFkZXIgKmhkciwKPiA+IAo+ID4gwqBzdGF0aWMgdm9pZCBuZnM0X3Byb2Nf
Y29tbWl0X3JwY19wcmVwYXJlKHN0cnVjdCBycGNfdGFzayAqdGFzaywKPiA+IHN0cnVjdCBuZnNf
Y29tbWl0X2RhdGEgKmRhdGEpCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqAgbmZzNF9zZXR1cF9z
ZXF1ZW5jZShORlNfU0VSVkVSKGRhdGEtPmlub2RlKS0+bmZzX2NsaWVudCwKPiA+ICvCoMKgwqDC
oMKgwqAgc3RydWN0IG5mc19jbGllbnQgKmNscCA9IE5GU19TRVJWRVIoZGF0YS0+aW5vZGUpLQo+
ID4gPm5mc19jbGllbnQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGlmIChjbHAtPmNsX21pbm9y
dmVyc2lvbikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhc2stPnRrX2ZsYWdz
IHw9IFJQQ19UQVNLX01PVkVBQkxFOwo+ID4gK8KgwqDCoMKgwqDCoCBuZnM0X3NldHVwX3NlcXVl
bmNlKGNscCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJmRhdGEtPmFyZ3Muc2VxX2FyZ3MsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZkYXRhLT5yZXMuc2VxX3JlcywKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzayk7Cj4gPiAtLQo+ID4gMi4yNy4w
Cj4gPiAKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
