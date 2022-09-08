Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A75B1DB9
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 14:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIHMzY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiIHMzW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 08:55:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE859259
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 05:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/xTyQHxbHXjI3wuC++Xks9qKow1shoSp2jiial2B7yvPBN/haYRZRWWHxghvcIj3UVN6J4k1Q3y0rS02dVuNmzVsq5i7Xu4n8480dwVjHu+qCN68V/2U9dvGhzc1L+7QUzGscvRL+n8EmDlH7E/LkuYjUOV1ootQje6MVjupSy6kDsRtAu+bo5o8wpvqosKrdLr9MHs+XE2StW49bNsdhY7bSIRof/ySynIp7hPcBNOeyM8j72cyr2nYUhQaAlnE9MNuxK7SwJsVtHp1IkBrdh8lLNKCO870lQEy8GcfYh7ws2klyOGPT1WKhENnSqcZ/fSts/M3sMwvUNtiCt6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWjysE2lIb4z3QNlB862hEOi1iuKbtY3AxJoPCsZeWs=;
 b=JDp7r3vWJwoT83eWF0FE5966U334txXqr2AE/F7Hf6AZTWvgxJ5SG9zPPiUUjtNGyFz4qN4tMg4QkhP7ukREcZyBAkPe1dES4ubgVNccIc9LBkAFoeN+eSGZbeKU4e1hif12qDzbtj2Euf8ClPRjc9juTts7+6uTofErBBET88tT/6zs53Kch8VvRIKhaHkfCC+pUTq/0vI+Qxn3/wJPp7DRPWe6OL7Fp8+QzStBqviUMFbP0hsj7gMUckEwX1C7hl/Q8m0Nj/eaRup6a6CX7ZprqIR/q921AmbzGQLC4Hv731bb8pFKZ63x6kLihA5nDhi2u2JPPI4GCBDB3qSoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWjysE2lIb4z3QNlB862hEOi1iuKbtY3AxJoPCsZeWs=;
 b=D0Pb6cy6xQc/NSvIEe6FHjGN5i1KmSr9nN5X7NY05UsPjoI/m4JS8MpWp6wIvFAM4/L6P+UeKYruVlitXoRJrpB1UWoINWP48fdci+2LqN2AZodc8nYOSnA2RTPb3qRcQHCzCpfLEjOJ5lhk3lk8DPG2KIp34Z0rToWt5QnocqY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB4125.namprd13.prod.outlook.com (2603:10b6:806:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4; Thu, 8 Sep
 2022 12:55:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 12:55:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chilversc@gmail.com" <chilversc@gmail.com>
CC:     "tscales@google.com" <tscales@google.com>,
        "brennandoyle@google.com" <brennandoyle@google.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [BUG] READDIR with 64 bit cookies
Thread-Topic: [BUG] READDIR with 64 bit cookies
Thread-Index: AQHYw2e9bfaTHoQAAkq81mCmhjuF763VfauA
Date:   Thu, 8 Sep 2022 12:55:17 +0000
Message-ID: <b62da6b349cd29e71a794ebf44f21bbd0a1cc792.camel@hammerspace.com>
References: <CAAmbk-fJ6Ks=xEyiiCPxr+La852ugBE9Tg32Weo9Og2BSRRm1g@mail.gmail.com>
         <CAAmbk-e-YQAPo6QyNB0aJyc9qzUShmEC+x5eTR7wqp1ABWADsg@mail.gmail.com>
In-Reply-To: <CAAmbk-e-YQAPo6QyNB0aJyc9qzUShmEC+x5eTR7wqp1ABWADsg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB4125:EE_
x-ms-office365-filtering-correlation-id: 8f237d52-3ca2-45d9-9d11-08da91996129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xI/wuakX6StUIkMnpnp0JmW+7W0mIxo5wq4qQ6Iefm6Id0oQlU+5eedRKPm+TYTz/B1yyquPq+1qiXgVPpmiV9gdsOPaBhF9Q16lLXLn4AXeF2gZ2zJlnKyBDwyE2MjKLz6mD1Xw3E+fi8dJ1J+pYxfz8gaR92sO3y5TV8XmiUa+dAtsS20SGMXgrZRrWjjSQwTTs4JnkC2i2/JiG9U59xzct+RItyL+Il/67TXOScWU6EOnuSASh2VQXFRYiksqhpJfbGg1Vp5MNm1j1IL7uTzAp90XWUVd0k/q1/GbOuMey38hBEbDZhyRPrxEIz94KqDYNxwQXEBgHBkF1SlmpYwtGnRv7EduffQzuqEfymuBdopgaOQ20k8gePd5o6FNLuxyybHLz7BMgYy1tbP/lLbDqAZPv5q1j+KCSiNZPpMF4yrSvDzaHWMWicISPIHhbYIsUNsZlkrcWbgFZIQFdz5ap9QZigerKcNHkp2UnK9QjNYw0m6Hzi9VGLqAD0mcxiggiBy5pVcJQNxDn4g2Tlis1CUJ82Hd3PMMHUmCoCCp6ns8On0hnJ7+hEVGctmRig7w9ejq1QZ1oN/XhLaTVCFR86wCEn3fk73XzOgO67BMpUVLMcln/QST5xMO4OhiOrEbLUZyAVIPOyZESMh2lLY9uQQ5DMAGHJM+lLVw601/G/hHaZFpigsfvEfLZPK6TKaTO3cff46tavjw14diScD9KxsP3/HdE9DfyAWAp3nT0Ra+M8f3WXq9OjIScdQusaJfWmD8XplrWqyYDhXAjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(366004)(396003)(136003)(346002)(376002)(6506007)(26005)(478600001)(6512007)(6486002)(71200400001)(41300700001)(186003)(2616005)(2906002)(4744005)(8936002)(5660300002)(54906003)(110136005)(316002)(4326008)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(38070700005)(66946007)(38100700002)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S085bmRndHV1NjNkRFJNekJ2UFIyeVJ2bmhnK1dKdkN1aGtsb0FISkxCUlFK?=
 =?utf-8?B?VWthNWdhbEZYT2VVZStxTTFDTUE3TGpZeElRUXloWlJPUkRlYko5clI2Rkts?=
 =?utf-8?B?NUFkR1lxNGtCU1cya0paL0dLTjV0aTU2ZVVkZnlsZUs1dkVObjViTkZvczla?=
 =?utf-8?B?eXhXUkN4MEo0Z3JrSjB4VVh6QUFVNjhNZm1sdmROOWxsSEFDUXlrSmF4TC9N?=
 =?utf-8?B?Wlp6OEhtMzJpaGlmNzVka1oxK1UvdXQzTlhvQUdHZHJkU01pZXRHYlFSSUVq?=
 =?utf-8?B?MDVWUUlLSi9VUnFYV0IvbFhvZHpzRXVaektNcDM1emI5T0dSTzVSN0swc2lX?=
 =?utf-8?B?c1c0bkxGM3dVbHdUVWVKMW5VeUpTWDNzM1pzbHJESUpISFJKQ3BsRDVkbkJC?=
 =?utf-8?B?OFpWTkk3c1NpZXBlaVFpdkQ5TGdmR1NUQWplTGhudWkrOVRCVFlHTndJaE0x?=
 =?utf-8?B?VDRKWnVUY2NuWVFBcStTNWo1bFg1aEhQTko2T3lEaVplZC80ZkhCdURqaGM4?=
 =?utf-8?B?WG9BTFA4UXkrRHRQL3hBQ1JoUzYwRURRdlF3NDlxN2JqancxbXJ0RGUySElr?=
 =?utf-8?B?YlhjclNkTEJjUWpPOFk3NVZ6ZERJYU1ZUDRYcHgzL1NEUzlnc3dJSkZhSFNl?=
 =?utf-8?B?UVBVNXRXSEFWd1ZzY0piMmxObHFRWWFaUzl4amZUVWxzejN0NkJ4WVpzMy9k?=
 =?utf-8?B?aFkraDY2eUdrcG1mMWY0eklBZzdnK2U4UUhTWkV0VU9kcE1oZFhIdG5GbXlm?=
 =?utf-8?B?QTNwTWZXQW01Z2JoMm83VmdEWm40WENSdy9TQWswWk1lZjVwMHFPQUNJM0ZE?=
 =?utf-8?B?N3hBbTQ5Q3NXRDNQVWRkNHFmSUtDdGpYbGlUOFJudUlqbm92eERZRkU3NVdu?=
 =?utf-8?B?SHJQbVpPQWN6Q2ZId2RYS1o4SXFWeFhLY2FwSVZ1blRvLzcxeWRHRWV2ZlU0?=
 =?utf-8?B?blBYUEI4c05FNmdlTmk5d3FnMExFWHZtWFpHZDRmOHgrcEs3TTVNUkxnYU1K?=
 =?utf-8?B?emNnR0FWY3BxeVdyeDNlNnBSV2pJUm5TRnpoYjJQUE1NYy9PVU8rVG9qNUZQ?=
 =?utf-8?B?NWY5N2UydmNsOStJaW1GYlhna1p6MUhIVVRuaGZhTi96WjhJYVB4SW1YaTBy?=
 =?utf-8?B?elBIVFR6WnRFQlVpdUVsTkx3cXdXazI3b2lSZldZb3VXRFJaUUtta2xoQ2sz?=
 =?utf-8?B?RVhlNjZHeU05YUJwc215eXJwZG02ZVlKeVpSRWR4VnlIMEw3NmJpMERvMzVv?=
 =?utf-8?B?M3JReDlnWEJjcm5sQ3I4QzNrZjhkRVFEbVdBaExYZGJVRVFuVHdhN0IrS3Ex?=
 =?utf-8?B?Q0RqdHYxTTIyU29JZWxNOWJONHU3UTMyNGpJZ1QvWEpRMFZ4QkVJRUpQcDM2?=
 =?utf-8?B?Z1FGREt3WUNWQm5mclliV0EwV0NYMnFGTE5xWlg3NW16Tm1QUVVtak5ZVldl?=
 =?utf-8?B?YUprb3lZOHc5VGllRlpJUTdSVFpSQ29xNzlCK2VuK0xSaTM3QVpodnIvc3d0?=
 =?utf-8?B?cFB2aDVPUUJkalVmVUxGSzhSU2Y5MHI0cEZyVGdGKzM0NUlxSFgrcXZHWlpI?=
 =?utf-8?B?cGROMU5WdHZYS0lsS0NkV1FFWmx5ZlFrN2JxYXlyclJ5eGxMN2tQRU9YN0dO?=
 =?utf-8?B?UGNxOFhJREVjTm5ZSEcybjNGYlJ5OHF3TmRsRGtjOHJnNUhYZnkzbzdSalhF?=
 =?utf-8?B?cGJJOGh1TGhZMHoveGhrQXg0ZXRPOU9WQ3krYy8xZE1OWEdoV1lDc0gyazgw?=
 =?utf-8?B?Sjd1dFZSRnkwQzUvaTR3K1orOXI0ZFZWaU14WVpYazUxaXNSNUd3dmhtblJj?=
 =?utf-8?B?UkVXU25HeHo1MGJzcEpPYWk2RDh2VUNHRklkbCswN3pCRlVSaFdLSG1wNXoy?=
 =?utf-8?B?ZXVtRi9uTVB1ZWZnZThROVZiY3FTVHVDRkMvdkMySmJpT25kdk5RSnJEUW9u?=
 =?utf-8?B?M0VHS2NYdjhvQ1paYm40SFhRWUVsVTFjeUJpcVhFWDBDaVJsOEgwUmZ6eVFU?=
 =?utf-8?B?aDdqK3EzZEV3TmZrQmw2V3BGUkpZc2RLZmxUVXJSb0xVRE9PV1Z4SUlOR2lB?=
 =?utf-8?B?RFphWjhlZXlpb2RLTUtHYXQ0SHB0aEd3Q25vK21qSXZVUkJGSVJuRmIxWGJu?=
 =?utf-8?B?NlRlbmNsQ0RGV1VMb3Z6TWcxajBaMWNvSjZCcHZJOUUyQWlxRWZVSklTUVFk?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38C2C9F6B17A84783BC9B77D7730A90@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTA4IGF0IDEwOjQ1ICswMTAwLCBDaHJpcyBDaGlsdmVycyB3cm90ZToN
Cj4gSSBzaG91bGQgaGF2ZSBmbGFnZ2VkIHRoaXMgYXMgYSBidWcgb24gdGhlIGZpcnN0IGVtYWls
Lg0KPiANCj4gSSd2ZSBydW4gaW50byBhbiBpbnRlcmVzdGluZyBpc3N1ZSB1c2luZyBWQVNUIGRh
dGEsIHRoZWlyIE5GUw0KPiBpbXBsZW1lbnRhdGlvbg0KPiBtYWtlcyB1c2Ugb2YgdGhlIGZ1bGwg
NjQgYml0IHVuc2lnbmVkIHJhbmdlIGFsbG93ZWQgYnkgTkZTIGNvb2tpZSBmb3INCj4gUkVBRERJ
Ug0KPiBhbmQgUkVBRERJUlBMVVMuDQo+IA0KPiBUaGUgaXNzdWUgaXMgdGhhdCB0aGlzIDY0IHVu
c2lnbmVkIHZhbHVlIGlzIHVzZWQgZm9yIHRoZSBkaXJlY3Rvcnkncw0KPiBmaWxlDQo+IHBvc2l0
aW9uIChkX29mZiksIHdoaWNoIGlzIGEgNjQgYml0IHNpZ25lZCB2YWx1ZS4gVGhpcyBjYW4gY2F1
c2UNCj4gcmVhZGRpciBhbmQNCj4gdGVsbGRpciB0byByZXR1cm4gbmVnYXRpdmUgdmFsdWVzLg0K
DQpLbm93biBpc3N1ZSB0aGF0IHdlIGhhZCB0byBkZWFsIHdpdGggMjUgeWVhcnMgYWdvIGZvciAz
MiBiaXQgc3lzdGVtcw0Kd2hlbiBnbGliYyBmaXJzdCBkZWNpZGVkIHRvIG1ha2UgbHNlZWsoKSBy
ZXR1cm4gc2lnbmVkIHZhbHVlcyAoc3RydWN0DQpvbGRfbGludXhfZGlyZWN0IHN0aWxsIGhhcyBp
dCBhcyBhbiB1bnNpZ25lZCB2YWx1ZSkuDQoNClNvIFZBU1QgaGF2ZSBoYWQgYSBsb25nIHRpbWUg
dG8gbGVhcm4gbm90IHRvIGRvIHRoaXMuLi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
