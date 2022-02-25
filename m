Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672624C3B6F
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 03:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiBYCJz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 21:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiBYCJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 21:09:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7261DF853
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 18:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRUnGFhXlkQjA0vngquvI2OkFqNcftBWBV/0VpDBNWODSSniGk1sLjoqmQNmDbz3xMprxZWcgs04RBftVk+qpYUDNon+VQWL1bUL1AYWqkx4wMJvm1Xa06aPj3AkhQGAV1U7ORelgL/GY+4mYdYZMjogPlMesENt3lDdTI9gyO7KqmWtR0DqZxnAmvN6TnPS2oJYMDQt0uumIdrLHtugG9K1couJ8y19053XBHP1x0SGH+b+B4MXV9A/FtJ1b23FgYNAjbggG0dub3UK1Gcfmyxk993Wj8dAdKXrmEiQEUPaJWOxYZpUBIENoYouOkIhdvcSCK7wslFNW+XCOsYFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBFkgEnzyrBrDqa3BFy0QiJ5hrsyyZ/VRh+mq3M6O9o=;
 b=XsoRPU348nWvjLAlKufAhQEGaj2vgQ2DyMljIrJ8d4QPvVMq8UEtXzp7+I+vGbkVaGCyc3w8ud1e3y6Mqp3cV7iNdpNO5vA1nzgjMOXI4U1zsxsTxlTKIafosmOxLvJJPHG3LeCDuGIkU0q/I1AWP5jzBrzkfXCqTaYMtcZcwD9sTR7PCoNWg/Rm2USnSQsWKQmBDwKs2zvgrrMxzurc8sT6iXPIVjGrs0J5ljTnW0CF8eG7fLhzAKZSKZLhtWiK/amQL92YbVOwdBTVvM4O3OuGwLK7SB/aA59+Ll7u5dDjnaLg1LLKyv74/gVs928mLrClFg50lOhQixd/FpSpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBFkgEnzyrBrDqa3BFy0QiJ5hrsyyZ/VRh+mq3M6O9o=;
 b=OsdjdXtRIx3OeI4YzpF3FxmYRkD6upSQBMhseNu4b4G/7zCTfA83HtOv3Gk4XRDLgabB+4ILakP2+1Jdl6jJX6kQimyczkx5JNKjBVtLXPx6kNH28I04hzLMh8awRptP9b8pqsfDEKgjXLtGSTNsj5m/GBdgHA4eJekwFniZs4o=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1093.namprd13.prod.outlook.com (2603:10b6:903:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 02:09:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 02:09:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 02/21] NFS: Trace lookup revalidation failure
Thread-Topic: [PATCH v7 02/21] NFS: Trace lookup revalidation failure
Thread-Index: AQHYKPs3gv4x1Xi/mkuxemHMfzoFNqyiv8kAgADHo4A=
Date:   Fri, 25 Feb 2022 02:09:18 +0000
Message-ID: <7de08229c02f1c729afeb5a1885fd9d593bf4d99.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <43364F7C-BEED-4C35-8745-9181AD2D9F57@redhat.com>
In-Reply-To: <43364F7C-BEED-4C35-8745-9181AD2D9F57@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66e202b5-007a-4dae-1f61-08d9f803d4ec
x-ms-traffictypediagnostic: CY4PR13MB1093:EE_
x-microsoft-antispam-prvs: <CY4PR13MB10931F9B133E4FF6BE008DE5B83E9@CY4PR13MB1093.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfITGUiATpyT+rK+qRF/qx58Os11KjlqNf/dQHFN9Lshz1WtmtMsBYK7DllrOHZFoYrSZzC/hY5D30M2bSNxYVijEMRjUpESEUZM6lZg4WRD4X4IUiFnFcTHhBpk6tqy8RGGeEnIg5U+wE15Ddcnun38D9r1ciieEIHbMAAnwrar/gxoQT0wRl+tzh6y53y7PogGH9tj5tAl6RPOiYGcvGg+VIzmcFgYwy+ZTVy76yvM+oxEPzGPu1jJqfyT2sh+mM1xy3qWvqPsn6XRJ7Pk94y4KeEijdSLQPv33gDdGkOoGqONrNsq3R6m/Pn+xPPe79PmGzvpt0UdBj1o5QuByYvsCOedEBkFvLbTRgPSK8o+UeEDaahXIpr8Ao0nCo+7f3L5WRVyjy4mOJQOz7WQgqz8QssFyFwPhRvLiA5fiUjvd2FW1Qwjgaa4+pKvOrZuQuUZb/BWV65YROwQhuKOwT2ENNyYQRq3trwHZ2ezPIFNah0DWJUameGw9BOQMh/UMn1FQoC8ZO6IMg5v7c6VmwVwtYu3XdNRFHntDmvKbUZjz1sS1l/uM7jEC+ACZo7K5gqHtIVjhIaZhGcv43pSSwguwFrcUomK3FgGa3kAJ5+61eijd3uL1INXMDDRwpAB8Pj7m+TlgXRGEnhGNQqT9P0DK0uluPbmwQa7JVGyoKMnAwFgJcCU8BfnJ4DBI1yanjJwzfdvH+0YI+q3YYrJLspx8kbTj0CZiVKkbZZBzm+lAhnHLRwXq6OahvA5FkXC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(136003)(39840400004)(366004)(376002)(186003)(36756003)(76116006)(8676002)(66946007)(6512007)(110136005)(508600001)(66446008)(86362001)(66556008)(66476007)(83380400001)(64756008)(26005)(4326008)(2616005)(71200400001)(53546011)(6506007)(316002)(38100700002)(2906002)(38070700005)(8936002)(5660300002)(122000001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHRSelFDUmN0V2pCSnh5RVNvRmtVMm9QNWFYaUdtWTdSQWM2bExwa3NNUW1r?=
 =?utf-8?B?VU9JK05wQy9CakVRZmlCSFhFYzExc0FvcVQ3bWRlMlhGeXNNRXB4VG5xdnRP?=
 =?utf-8?B?UzRZOERrbytzV3NHcU9xVGtKRzZHNlIzelFwTDRKVnVLMUI4dzVUUjdkM2s0?=
 =?utf-8?B?RHNJNjg4b1d1VWZUYW8rUmVsUkcvc3dGNDhOdk5vaTQrMnZTSWtLRXltUVdL?=
 =?utf-8?B?VG5hRitHWk5Na0lNYjV4TEYyZlFXMitDL2Y1TGtQeUZqTlFkbEl2czlpZm5o?=
 =?utf-8?B?WGM3S054ay9CZXFmWENHSjcrdjM3R2JHVkVmTThUNmtWV3FhUlBsVWdBT0d4?=
 =?utf-8?B?NWRJM2ZucDJZcDlVNnQ2SkJIRjJ3dGN2MXZnYmRsRXI1VVlzN0VaeS9qUE1y?=
 =?utf-8?B?WFhMdDdGVXRYN2p1RXlqR1NCajdKWTVEMW43bzVwalB3YWd0dGNsK1N5WmtZ?=
 =?utf-8?B?cFdFKzcvODZ2WDJ6YnZkQi9TeE9rZW15dC9WbFhGVnllelNIcVFQYjJ0TFAx?=
 =?utf-8?B?blZiNVNFUGxOdVBjbnJJZ25LaUtOSElpdjNiL0pJdHNWTW9hM214NjNzQTY5?=
 =?utf-8?B?OEFzVGt0bGJxS09CMTdRUytDWTNFVnpadFVpaWdXUTRDM1RhZU5ETTRnWFlz?=
 =?utf-8?B?TnFLbmduU3dmeGFQTFdORXhlSnIxVDR4WWphYzNtL01rdEhXVFRIOGFMQU5w?=
 =?utf-8?B?ZUtZYkZaOXRiRTVESTdDRld4MWtIZEhzYXlSblcwNG10bzBxNE92eExXeFpY?=
 =?utf-8?B?cFIxODYyeGxkenU4WWtZRSsvOXpOTkhibGRTSExSTUEvZ2hnUFNzWERKeFRU?=
 =?utf-8?B?Um44empodHlwWG5UYU5XeGpXKzNNSDJFS1RTMWN2bHhwcGhjT01abmJ1dVB5?=
 =?utf-8?B?KytUR0QwSjhsbFhVOUJCOUIvVFNNbWNUaFdadVZQenljc1piOUVBS2hISFZS?=
 =?utf-8?B?WGJYR3k3d05aOHlLRFpwdUlOMUJJWE1wdi92VUZQS1JFVUZUZW1rUC8xK2Rk?=
 =?utf-8?B?WTJ2QkpPMnpuaW1OME1GZHNMUjF3aEtKZFdYQ3lOZ2RhaVB3OTNhMkVLOFpz?=
 =?utf-8?B?ZSsvcXhCSEFlL2RrUFc0Rkl5Qy9wcUlRK2svWXVVWi81WG0wV0M3Q3dYaFBC?=
 =?utf-8?B?dWpWMS80bnNjajdUbGxFV1Vwa0MxU0V4Vmp5U0QrTmI1NTQvdkVCdEIvaVIx?=
 =?utf-8?B?dFo2Qi9pUHJUSGczMlRyRStNN0dqTms0bUhTZWg1cDZBVEF0akxNYlFlK3VD?=
 =?utf-8?B?aEIvQjJHU2NUa2dhOTkzQ05Sam01ck9xcjF6NU83NHRyT1c0WnlqcTVlRWpi?=
 =?utf-8?B?ZHZZNVJLUkxJK25ySkQxencwbUN3ZWFvN3hoeDVEV0NxdEtYRlNRSElMVVJ4?=
 =?utf-8?B?eUt0bmtFQVZrTUoxZGlpdXRjYjJSNHZwdkc2RUwyUDhGVTA3YkxhN2NuaUJE?=
 =?utf-8?B?enlVRFpyTDY3V2h6RW5EY05zU2ZYSDczSm1ZR3FuZVhlYWpvQlp3czZHa05k?=
 =?utf-8?B?bDkxeXUxN2NmOHpNcFRYYTlwR2RMUFVScTRuWlhGSHpXbjAvVlc2WXUrcXk1?=
 =?utf-8?B?RzZMRzRGYXh5M01nTm13a3UxdUdlTzVrZ3lpMGFyKys4dCtIeGY3dHpOU3l2?=
 =?utf-8?B?OFhXMENqdHFVdXk2aWt2K2J4alljL3I3WUFNU1Urcjhld3hRNnZDTlVmcGdr?=
 =?utf-8?B?d0FoRlhQR1BvNFdMQ2R0R1dxNmlQSHpwTUswU0NCa0NGeHpyUnh3SUVuRExT?=
 =?utf-8?B?cVhpZkVJby9yUEFQZERuZmg2VnVVQTVjaklKK1lwbm55bXJacVZUUkRnTTRE?=
 =?utf-8?B?QXRCeUl1UnBqODFrazQwUmJEZlQzRExwK0RVUzcxamMrUlA3eWpWRGxuNzdE?=
 =?utf-8?B?SzRXT0ZVdnkxdFI2cVlQOEZxZ25hL3RFeUl3NE9OeEt0QVpzZENYOGpVL2dw?=
 =?utf-8?B?SlZ4ME1UUmdVbDkvWnBqOUl3ZWxkeEVDNDVsd0lNWS9kV3NpWGxCWmM2b0RB?=
 =?utf-8?B?eVlQT1J6WGl1S0dNc1M2bWlkMFBudzBiRXJyelYxTVV3V25uelFtOFlNa0VC?=
 =?utf-8?B?cy84RTF6OEc3VGczSk8vWUJGaUtsK2Jqc1N6ZTdHUlhvZTB1QW52bjZUTWhB?=
 =?utf-8?B?TnhhbUdYVncwWWlrNHRydG4yWG1keWZkVmVCWkdXZGFhYkxiYXVPQU12a3VX?=
 =?utf-8?Q?ak+XntsuUjDc82+Ll1jm8oA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C7838FF858B3D48A5F18C404C79984C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e202b5-007a-4dae-1f61-08d9f803d4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:09:18.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DelbtGIQR38yirsvU54blcV4Jg+Ta9tGU3WXgIwFY6j0P1C5MSpUnHht6Le5Kks/FeghFyt0w/pjXV2+94b4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDA5OjE0IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IE9uIDIzIEZlYiAyMDIyLCBhdCAxNjoxMiwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90
ZToKPiAKPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4KPiA+IAo+ID4gRW5hYmxlIHRyYWNpbmcgb2YgbG9va3VwIHJldmFsaWRhdGlvbiBm
YWlsdXJlcy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPgo+ID4gLS0tCj4gPiDCoGZzL25mcy9kaXIuYyB8IDE3
ICsrKysrLS0tLS0tLS0tLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMv
bmZzL2Rpci5jCj4gPiBpbmRleCBlYmRkYzczNmVhYzIuLjFhYTU1Y2FjOWQ5YSAxMDA2NDQKPiA+
IC0tLSBhL2ZzL25mcy9kaXIuYwo+ID4gKysrIGIvZnMvbmZzL2Rpci5jCj4gPiBAQCAtMTQ3NCw5
ICsxNDc0LDcgQEAgbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RvbmUoc3RydWN0IGlub2RlICpkaXIs
Cj4gPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBz
d2l0Y2ggKGVycm9yKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAxOgo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRmcHJpbnRrKExPT0tVUENBQ0hFLCAiTkZTOiAlcyglcGQy
KSBpcyB2YWxpZFxuIiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgX19mdW5jX18sIGRlbnRyeSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIDE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAwOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSBjYW4n
dCBkX2Ryb3AgdGhlIHJvb3Qgb2YgYSBkaXNjb25uZWN0ZWQgdHJlZToKPiA+IEBAIC0xNDg1LDEz
ICsxNDgzLDEwIEBAIG5mc19sb29rdXBfcmV2YWxpZGF0ZV9kb25lKHN0cnVjdCBpbm9kZQo+ID4g
KmRpciwgCj4gPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIGlub2RlcyBvbiB1bm1vdW50IGFuZCBmdXJ0aGVyIG9vcHNlcy4KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChpbm9kZSAmJiBJU19ST09UKGRlbnRyeSkpCj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRmcHJpbnRrKExPT0tVUENBQ0hFLCAiTkZTOiAl
cyglcGQyKSBpcyBpbnZhbGlkXG4iLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19mdW5jX18sIGRlbnRyeSk7Cj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVycm9yID0gMTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAt
wqDCoMKgwqDCoMKgwqBkZnByaW50ayhMT09LVVBDQUNIRSwgIk5GUzogJXMoJXBkMikgbG9va3Vw
IHJldHVybmVkIGVycm9yCj4gPiAlZFxuIiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZnVuY19fLCBkZW50cnksIGVy
cm9yKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHRyYWNlX25mc19sb29rdXBfcmV2YWxpZGF0ZV9leGl0
KGRpciwgZGVudHJ5LCAwLCBlcnJvcik7Cj4gCj4gCj4gVGhlcmUncyBhIHBhdGggdGhyb3VnaCBu
ZnM0X2xvb2t1cF9yZXZhbGlkYXRlIHRoYXQgd2lsbCBub3cgb25seQo+IHByb2R1Y2UKPiB0aGlz
IGV4aXQgdHJhY2Vwb2ludC7CoCBEb2VzIGl0IG5lZWQgdGhlIF9lbnRlciB0cmFjZXBvaW50IGFk
ZGVkPwoKCllvdSdyZSB0aGlua2luZyBhYm91dCB0aGUgbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2Rl
bGVnYXRlZCgpIHBhdGg/IFRoZQpfZW50ZXIoKSB0cmFjZXBvaW50IGRvZXNuJ3QgcHJvdmlkZSBh
bnkgdXNlZnVsIGluZm9ybWF0aW9uIHRoYXQgaXNuJ3QKYWxyZWFkeSBwcm92aWRlZCBieSB0aGUg
X2V4aXQoKSwgQUZBSUNTLgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
