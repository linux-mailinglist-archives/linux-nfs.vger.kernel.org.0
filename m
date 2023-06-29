Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5D742BEC
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjF2Sde (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:33:34 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com ([40.107.92.131]:43488
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234195AbjF2SdU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 29 Jun 2023 14:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5SPuZbNvfp6VjbW/KaGhgmVCXOv+yail1sytl4NbuCEHs6LhRWAApeuRAf5t48j68fnuhoTNSNascE3tJN8E2Ah2DZlhVZ9FVpuCRucx0V46IJXbYJb0h6HMwawUBWF15PMDCpkPJsDm4NySvPLJnuEIP7FrtxUYMR1ZWUhP3eI/dUiTM0IqQcp8foovtnRTo7/0qvBVzib+qC7sP+3dKHp3yv+cTQ791eJvZ3656gyTqGXIjtmWhg650J/o3pckv0sdwDFRK0RCnmDAiRo/lhKy7zHa/VwuTcvPbLnDO9AGul5PhQTY+/vUDmzu2fTesUjVvMa1TLAigD6h9gOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTF6XFZRXpNlHOfDkc+5EJ0m8lCT65CngF6tvo+lj08=;
 b=g0TWPcPv0ar62iX00HkAB/xj6K6/SxxJXV1Xu3jp1WbkKYl2VgGjWVLwlzVUOc/cGxpQdKa/QrIGQBXvmRfyT2gIvIkFueC/dQA1vHAVFPOoRYIXNcs5YqxvsdYMvzZ7N+iFuGt9wQh207IvWtzkD8tNrSHrzC50pAIU2rtQ3mgHDh4l4mgE7iPxDAiUihyzmfSIVWsu1ug/8cJJY38d5Uk27ZwDD7PZ7eASOYIaCXMOv5Op1gKo3h4VIDK46JsqRnflup6K4FjTnXxdh8SjMDjB2CClqUn8dKu28oC/0niOEjz3KKia9H4g3EnvM1KsUzVfZgov0pgFb1ptJ/MRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTF6XFZRXpNlHOfDkc+5EJ0m8lCT65CngF6tvo+lj08=;
 b=ClyNbVXCjzoMyMMTmoXC5zT8ZnHR7hL2sOXAuzqDMQGFBvfjYTqC4l5E1DD/sKLrbINjHbjEfFycKLLMpgjhj2RGca7B2vGjfSKwfUDI16qkN5YGr2YdgejOTwn1IDrI6xF7imECKX3DKjVOTg66z2k1+NECWTpC7tDuKjK7tes=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB6151.namprd13.prod.outlook.com (2603:10b6:a03:4e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 18:33:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 18:33:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix dropped lock for racing OPEN and
 delegation return
Thread-Topic: [PATCH 2/2] NFSv4: Fix dropped lock for racing OPEN and
 delegation return
Thread-Index: AQHZqSWqSUTTkBvEOkmG9iuas3eYo6+iHgeA
Date:   Thu, 29 Jun 2023 18:33:14 +0000
Message-ID: <c7db01fb8e1dae2148c3d3fe4e61d8a74f92522e.camel@hammerspace.com>
References: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
         <01047e4baa85ca541a5a43f88f588b15163292dc.1687890438.git.bcodding@redhat.com>
In-Reply-To: <01047e4baa85ca541a5a43f88f588b15163292dc.1687890438.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB6151:EE_
x-ms-office365-filtering-correlation-id: d825e45b-8e85-4acf-19ab-08db78cf4ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtMT8R18izCnVG2PlaCsGDvQYcYByiGDctxk0dQN9OnoH77Mm36s9ZPVM27r7S98xNlmkrR2bfu/5Vf9me3PqEZuGG8z8+eK4B4dZpqJdp9+DJH4DD37F6f9sCFi99FDmXbi8eE+gtUX4frGy8fBfbNdy52FgfxjTvtACSWFUrCx71MW6juTBWSWxXv9G/VScK35FOPahi++uYqmDg7B34WzWAO37+NBaNUkb8ZDfYfburR4Ew+nSwti2/Q1xI5/Ng2hSXIqEhXA7yVWTZe1HgRAoNEtFRuvED7pN5VN1rbSH2XAw4HQIpclosgdtKaSG/OV8M//cUgJULZ+kBPlerrSNzX2zoq+hdOzz3S0R4Rnrl1dnPUowuYWnS6aRpu+zLSZjusPwsLxY97a1kiipvo2/FUFyFv9IrS2vDHgWVU3qHc9P0yqdM1wB3Q9y8mGU2eOlHCswIeFb37uy6/4diqPd/tY4LJyUC/bSJIT5ipSfnqfG8GAepjaI9K/yy1Kxq2pdI+g1kMisDa1nTMEM7tRcE1zhUqTnvRlwZrjtssDLk8iNFveojM6+4Ri8hzxC94iuUAtXKFbuPaF5JeKQaf7D5QDHouk6PceGnBcBfyimbtzxr4qyBSdVMxRm9X1FBDXA5py268Tf5QXP3zRUj2fvjeanZzOYsir2GeeihA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39850400004)(396003)(376002)(451199021)(6512007)(66476007)(66556008)(66446008)(4326008)(316002)(76116006)(38070700005)(64756008)(478600001)(66946007)(8936002)(36756003)(5660300002)(8676002)(2906002)(110136005)(54906003)(86362001)(41300700001)(6486002)(6506007)(71200400001)(122000001)(2616005)(186003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y20vQXFzZjJlMjl6RTRvVGRUZUM4dVV6ME5KS1lCTXZMYUtNYmpMMVY4VkVK?=
 =?utf-8?B?dHpuMnU2U0hIY2pxYXJUOFdpN1JwMk5QcUwrRkllV1NoUUhLbEJtc3Z3YjNE?=
 =?utf-8?B?ODdqRmx6cjNrVFk4SHFrT1J5eGNudkViRUc5TjdZNlluZ1AzSW9QN1pSUEhr?=
 =?utf-8?B?QUE0WWVBZWIrOElKV1RnQ3hzd2pVY3NTeDdxeHNvR09xL1F4a0FIRC9WSkhk?=
 =?utf-8?B?WmtNV1ZCaExKN0swU0ZLWTF4eCtmdmV1aXBGcVRmK0kxR1NaQ3BkUHUzOSt2?=
 =?utf-8?B?ak5DZjBrNkprdXM3N3RHOVhjM3I4QmJzTEJDWWQ2L2VLNlc3MWJFUU5DdVh5?=
 =?utf-8?B?RHN1ZWVlY2JsOTIzWmg1L1krYndYaVFZNXl4QVg3dWYwQlNuNjVRcTZRdlE4?=
 =?utf-8?B?ekNTcThUTFNPclRsanZ5eUJNUExuTG5WZmo5VzRWclJ0bU14YnMvY0IxSW5x?=
 =?utf-8?B?Y0prRjBDWm5oRHJKajRhL2NiRE1PS3g5a2xWbk9kQXBjQWorNjROMGRzYmVK?=
 =?utf-8?B?RGNIZHA3ZklzVGlodGhDRmlnbm9tTnJ3OWhjYTBGTFJuNU96Qnh2SW4zWWRq?=
 =?utf-8?B?ZXJNeGk0bnJsRnIvQnJtVEQ2aDdNaVFpS1UxTWgvZ00yeFROY0RKR3VuenRr?=
 =?utf-8?B?NEZQSk9IUTBic05OdDFlREhnRlNSQjJVTWsyRXNJR3BqWk9SYkJrSjdVV1BN?=
 =?utf-8?B?ekZhS0cza3ZnbnlRdGpqZ29acmlySHRLd0FyQ0xXZDZYM3dlb3BnQVQ5QWFr?=
 =?utf-8?B?aDRkK2s4eHMyMUhpK0FEcVRUMkF3aGlqRG94ZENLaFNuZTVuaXlxYi92cENF?=
 =?utf-8?B?TktHM1lzcmRKRHhNV3BYK2RDUjJ3UFQyVGRnc1oyRVFCeGtFMHpMTDZDcUM5?=
 =?utf-8?B?d0tWajdUS2FmYnlRWXVpY1Z6dlcxRE1JMnpkZWR6WVJ5RTBrczFMZjJYUXNI?=
 =?utf-8?B?cXRYakx4UHZ4aEVKaXJveU1rWE9BbUU4OFlTc283MGFzdmhPVG9yeERLQU50?=
 =?utf-8?B?OHZiQTRRVnpKYnFDQlhYQ1RxVlphb2puajRSZVlZekZ0OHBJY2FRMXpFOEhM?=
 =?utf-8?B?dGRZeWFDRWQ1c0NHeHFmVThSRjlFeHFZYzFlTEwzK08rbExpZWpERldkR0FF?=
 =?utf-8?B?R0Rlc3ZneWNHUm9ER3RBVWl5TUE1OEZiNTJkSlpYbTBQQ2l6SDg0THNkUklM?=
 =?utf-8?B?ZzlyNS9VM0VVMDNYVStsQ0dhTmU5SCsyeE9mWjlPK2daWUFObUZ5RlVUbkh5?=
 =?utf-8?B?bUY3QytlcnVGY3JBT1I1SmJ3MHhjSnRsYWR6N1NkNGVOSVI4RmVrNmY3SUY2?=
 =?utf-8?B?NVJSbGU0OUNiRGMwdlFuelBNL1hITTZ1Tnh5S0RvOUZXMGtSUGlnd0Z1STIv?=
 =?utf-8?B?aFpadUhZOE12b2xFbnhjTmYxU3QwNHpsNjk0MXhvOVFqcVVzZ3pHQWZyUWdN?=
 =?utf-8?B?NG9RUjhyRndEaFFtOVZNcStwdDEzZHN3TCtaYUhhVnN1ZjFFWTZIUVJMRUFR?=
 =?utf-8?B?UldUVk9ySGpKM1ZHdjJCNE1zQUd4NjFrTnQyOGNvL1QwaXU5Q3doS3k3TlpW?=
 =?utf-8?B?RzBpRG1pak95aFZ1bVNNUHNBRzJrZGxkQUZvZFZPR2prNWNvaWdUVk9peTJM?=
 =?utf-8?B?SVp5Y1IvandpalM4MjlEbWQzYkxEdjNidzZ2SnptZWU1Y29sRFdETml6L1d3?=
 =?utf-8?B?dURDMFMvaUxtTVN0eEFTa1p4Qi9vRVd0NndzMlVNN09WS2VHa0x3aEhrT3du?=
 =?utf-8?B?Q1NaNVo4VG9ucHdOT2hnT0JVRGN1RGZEM2JpSzkzOUI5Qm5pbTE1Y1FBNldB?=
 =?utf-8?B?MnRvc2NWSGlWWklDV0srRFpycjJxYnBPNHlNSzI4eDFqcUVLV0M2YTkrR0VT?=
 =?utf-8?B?WE52VnBjQ3VBR2hwT1k4SksyaTdkcjdEV1UwNWlMb3Znck9vUjl0eURZT0o3?=
 =?utf-8?B?c0RGNldBZkJPa3dnTWxYYi82TkxjL3pQN3Y4VjR0ekExOE92U3g3ekNHUUw3?=
 =?utf-8?B?KzBMWi9rVklJc29JcVM5T1diemd2VGx3ME4zV3VHcm1UMjJ2endqVEQ4R2hK?=
 =?utf-8?B?Rm13dXJHN2tkdUlVTkhMeEd4NkN3T1JHeWN3ZER3M1A2WmxlMlVMeEZjM2Rw?=
 =?utf-8?B?ME81OURHWG9uazRJeXhEWnE4aDR3N1FlL0hZVVRQYy9ISWFrS1gzWkZnNUd3?=
 =?utf-8?B?cWxqaWF6ZHJUcXloc0VXb0RTbkJsLzVkRy9SSC9Wc013MFlUVWZFUkh4ODR6?=
 =?utf-8?B?aWhlankrSStHVkp0bVRjSlJXajV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE0568934C0AF41A6D81A22E7E3AEA4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d825e45b-8e85-4acf-19ab-08db78cf4ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 18:33:14.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHjN00Nq7CRRZvTys/p8Fi975lDtdJWwHxa7nhP9LlFMhQcRgFac5taYyKCVzK/4bU7dXqTHOdzY5Y91MIx48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6151
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTI3IGF0IDE0OjMxIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IENvbW1taXQgZjVlYTE2MTM3YTNmICgiTkZTdjQ6IFJldHJ5IExPQ0sgb24gT0xEX1NU
QVRFSUQgZHVyaW5nCj4gZGVsZWdhdGlvbgo+IHJldHVybiIpIGF0dGVtcHRlZCB0byBzb2x2ZSB0
aGlzIHByb2JsZW0gYnkgdXNpbmcgbmZzNCdzIGdlbmVyaWMKPiBhc3luYyBlcnJvcgo+IGhhbmRs
aW5nLCBidXQgaW50cm9kdWNlZCBhIHJlZ3Jlc3Npb24gd2hlcmUgdjQuMCBsb2NrIHJlY292ZXJ5
IHdvdWxkCj4gaGFuZy4KPiBUaGUgYWRkaXRpb25hbCBjb21wbGV4aXR5IGludHJvZHVjZWQgYnkg
b3ZlcmxvYWRpbmcgdGhhdCBlcnJvcgo+IGhhbmRsaW5nIGlzCj4gbm90IG5lY2Vzc2FyeSBmb3Ig
dGhpcyBjYXNlLgo+IAo+IFRoZSBwcm9ibGVtIGFzIG9yaWdpbmFsbHkgZXhwbGFpbmVkIGluIHRo
ZSBhYm92ZSBjb21taXQgaXM6Cj4gCj4gwqDCoMKgIFRoZXJlJ3MgYSBzbWFsbCB3aW5kb3cgd2hl
cmUgYSBMT0NLIHNlbnQgZHVyaW5nIGEgZGVsZWdhdGlvbgo+IHJldHVybiBjYW4KPiDCoMKgwqAg
cmFjZSB3aXRoIGFub3RoZXIgT1BFTiBvbiBjbGllbnQsIGJ1dCB0aGUgb3BlbiBzdGF0ZWlkIGhh
cyBub3QKPiB5ZXQgYmVlbgo+IMKgwqDCoCB1cGRhdGVkLsKgIEluIHRoaXMgY2FzZSwgdGhlIGNs
aWVudCBkb2Vzbid0IGhhbmRsZSB0aGUgT0xEX1NUQVRFSUQKPiBlcnJvcgo+IMKgwqDCoCBmcm9t
IHRoZSBzZXJ2ZXIgYW5kIHdpbGwgbG9zZSB0aGlzIGxvY2ssIGVtaXR0aW5nOgo+IMKgwqDCoCAi
TkZTOiBuZnM0X2hhbmRsZV9kZWxlZ2F0aW9uX3JlY2FsbF9lcnJvcjogdW5oYW5kbGVkIGVycm9y
IC0KPiAxMDAyNCIuCj4gCj4gV2Ugd2FudCBhIGZpeCB0aGF0IGlzIG11Y2ggbW9yZSBmb2N1c2Vk
IHRvIHRoZSBvcmlnaW5hbCBwcm9ibGVtLsKgIEZpeAo+IHRoaXMKPiBpc3N1ZSBieSByZXR1cm5p
bmcgLUVBR0FJTiBmcm9tIHRoZQo+IG5mczRfaGFuZGxlX2RlbGVnYXRpb25fcmVjYWxsX2Vycm9y
KCkgb24KPiBPTERfU1RBVEVJRCwgYW5kIHVzZSB0aGF0IGFzIGEgc2lnbmFsIGZvciB0aGUgZGVs
ZWdhdGlvbiByZXR1cm4gY29kZQo+IHRvCj4gcmV0cnkgdGhlIExPQ0sgb3BlcmF0aW9uLsKgIFdl
IHNob3VsZCBhdCB0aGlzIHBvaW50IGJlIGFibGUgdG8gc2VuZAo+IGFsb25nCj4gdGhlIHVwZGF0
ZWQgc3RhdGVpZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29k
ZGluZ0ByZWRoYXQuY29tPgo+IC0tLQo+IMKgZnMvbmZzL2RlbGVnYXRpb24uYyB8IDQgKysrLQo+
IMKgZnMvbmZzL25mczRwcm9jLmPCoMKgIHwgMSArCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGVsZWdh
dGlvbi5jIGIvZnMvbmZzL2RlbGVnYXRpb24uYwo+IGluZGV4IGNmNzM2NTU4MTAzMS4uMjNhZWIw
MjMxOWE1IDEwMDY0NAo+IC0tLSBhL2ZzL25mcy9kZWxlZ2F0aW9uLmMKPiArKysgYi9mcy9uZnMv
ZGVsZWdhdGlvbi5jCj4gQEAgLTE2MCw3ICsxNjAsOSBAQCBzdGF0aWMgaW50IG5mc19kZWxlZ2F0
aW9uX2NsYWltX2xvY2tzKHN0cnVjdAo+IG5mczRfc3RhdGUgKnN0YXRlLCBjb25zdCBuZnM0X3N0
YXRlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobmZzX2ZpbGVfb3Blbl9j
b250ZXh0KGZsLT5mbF9maWxlKS0+c3RhdGUgIT0KPiBzdGF0ZSkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrKCZmbGN0eC0+ZmxjX2xvY2spOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBuZnM0X2xvY2tfZGVsZWdhdGlvbl9y
ZWNhbGwoZmwsIHN0YXRlLAo+IHN0YXRlaWQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBkbyB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBzdGF0dXMgPSBuZnM0X2xvY2tfZGVsZWdhdGlvbl9yZWNhbGwoZmwsCj4gc3RhdGUsIHN0YXRl
aWQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IHdoaWxlIChzdGF0dXMgPT0g
LUVBR0FJTik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoc3RhdHVzIDwg
MCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IG91dDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9jaygmZmxjdHgt
PmZsY19sb2NrKTsKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZz
NHByb2MuYwo+IGluZGV4IDZiYjE0ZjZjZmJjMC4uMzk5ZGI3M2E1N2Y0IDEwMDY0NAo+IC0tLSBh
L2ZzL25mcy9uZnM0cHJvYy5jCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMKPiBAQCAtMjI2Miw2
ICsyMjYyLDcgQEAgc3RhdGljIGludAo+IG5mczRfaGFuZGxlX2RlbGVnYXRpb25fcmVjYWxsX2Vy
cm9yKHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIsIHN0cnVjdAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9CQURfSElHSF9TTE9UOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9DT05OX05PVF9CT1VORF9UT19TRVNT
SU9OOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9ERUFE
U0VTU0lPTjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9P
TERfU1RBVEVJRDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVBR0FJTjsKCkhtbS4uLiBSYXRoZXIgdGhhbiBpc3N1aW5nIGEgYmxhbmtl
dCBFQUdBSU4sIHdlIHJlYWxseSBzaG91bGQgYmUKbG9va2luZyBhdCB1c2luZyBlaXRoZXIgbmZz
NF9yZWZyZXNoX2xvY2tfb2xkX3N0YXRlaWQoKSBvcgpuZnM0X3JlZnJlc2hfb3Blbl9vbGRfc3Rh
dGVpZCgpLCBkZXBlbmRpbmcgb24gd2hldGhlciB0aGUgc3RhdGVpZCB0aGF0CnNhdyB0aGUgTkZT
NEVSUl9PTERfU1RBVEVJRCB3YXMgYSBsb2NrIHN0YXRlaWQgb3IgYW4gb3BlbiBzdGF0ZWlkLgoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfU1RBTEVfQ0xJ
RU5USUQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJSX1NU
QUxFX1NUQVRFSUQ6CgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
