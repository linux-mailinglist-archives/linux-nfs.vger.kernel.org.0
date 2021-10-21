Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB1436403
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJUOYc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 10:24:32 -0400
Received: from mail-bn7nam10on2120.outbound.protection.outlook.com ([40.107.92.120]:5633
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230072AbhJUOYc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Oct 2021 10:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA2bzgts/KrzB3v42U1HZA8IaegMiIPBbs657zZQgY4Hf2QeJG8NtqADzNYl5DtGL+b9UlzLqeQlImIFkDiHQCR2tURke/LIvc4kAuwOIeY2rK0ud5PM/016BL37Z3FuVObfERCrrRgT4GwHvEL/6A/bNeKQLZV3FcdMy7sJN8q0ccEHRp9dt8VYECC5Wpl2ELhvgYoA0cxE9p9VKw8gx0OOamEdr5GfdWvtmzoiMM8eHycj0NT1w46Tx3TlfNPxAxcgQVtdgQT62GbnhM4E5bzHoNC5MKxqwjVFeziTMEX2oinAeEpicJrkuBagyNQgG97c62G7cxlObW3SMggodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhkHhJSt890zTEVSSU3kAQDoSXaw7ekvUEFL/3l6ha0=;
 b=KW8DXudvQSM/gzxx2ghCES9n7opr7mbQ6pTAMZ2gvJd+cTAZSlZU28CoY9qHfJgnLwdEYr33Gl5FVqGFJSiAxxBcW7R37nj+TiSYtNSIcwc/lliZFcXxGnhLOPfMOt6ybeiCuczxXHu/kvVea9XRNPdNZX8/tSSIvOU1Mtg1g52hO3ukXvVz5ENNK1bcDrMXfE3YT2ufzlDxd7TmwwGsMGTykF4rrkFBzkjNGJu9q55Efxuz3fXsz3I83WgtYL6aFvSysjR/Sz2VJBrzaz/VLpRdvz9wJaCCP6YtbLnuVnUdjHvt1lENAnqEXTQbzOMCTeyF5b2JmW3dWbte00cVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhkHhJSt890zTEVSSU3kAQDoSXaw7ekvUEFL/3l6ha0=;
 b=GBoeItvkckucHxnci4fWxR3WetHHr0cyvNugISsBQ9eIP+Ez0dw13EYcSQTFGfpWg7zo8s2fmncq6hY63zzsl0FHULSM7es/i9On66+SibLVR8ZYwh3W1hBQeJ9wABWdEb18RTPtf6kjYSXvl1E66B9rI8NS0mXbIApFbHDgi+0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13; Thu, 21 Oct
 2021 14:22:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4628.016; Thu, 21 Oct 2021
 14:22:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "steved@redhat.com" <steved@redhat.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Thread-Topic: server-to-server copy by default
Thread-Index: AQHXxcrCIt2JBpJfIUKt74RKGQmgIqvcFdwAgAATPACAAAgqAIAADeKAgAFA6oCAAAJwAA==
Date:   Thu, 21 Oct 2021 14:22:13 +0000
Message-ID: <aec219339d8296b7e9b114d9d247a71fd47423c5.camel@hammerspace.com>
References: <20211020155421.GC597@fieldses.org>
         <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
         <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
         <20211020181512.GE597@fieldses.org>
         <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
         <20211021141329.GC25711@fieldses.org>
In-Reply-To: <20211021141329.GC25711@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26dc91d5-f690-4aa3-917b-08d9949e2da0
x-ms-traffictypediagnostic: CH2PR13MB4411:
x-microsoft-antispam-prvs: <CH2PR13MB4411733471EB3DA5F6C03AB3B8BF9@CH2PR13MB4411.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLKK2pbGvjb5szvGtto3sWJzn7epYoiKup4EC9x7eWXfXVeFyd28akrGbh9/YcCFxZ5v+BqXahT8QmXI7wMEwYtH6gFnmlixagFZmdEDOpzQYMj1EH+KP6XqcX3ceSCGdE4XDY5XH+IO4iazwdNpQVH9+3UlGHvakoIh/CpYtfFNhakaZAjipTcdUQX4vxaaVn8xzdBAEh92MP8+wrIeTCjPtMC08EumUPWFYU3tWLtrTtQUdu7QaDeBG4dV7T8vA18cwpi/rRIWxmXMQz9MYz8VeynEgri7/VY2Sc9yy8Q7mA/yZyEV3tywO56GL5H9Zwk4iEsyE/m0gzytcDwkLqayqnXDpQyYBmuMU3HgbSvLNzlSwYMRVyriHZOJ1OqzkSqBZFr3kWlPQa5V33U/2YAFZ5doynDcJ6UuWz92QXsghWVGTlt+T6ISwp8PVrFBJp+gYbcCRvQwGhhtiuYh3yFRYQ/XFcvNa7h+ywf6CPQ9A1e11mizld++PISz6FiMURE4k8j6j9ndeM/XxMAsYrIRMxOth/JmuR/fMuOlNLyvqrJCef29IkvQh/YMpr79UJ5rKPQfwgfUws/bgB7qppkSWMivnwlnag5OYkbjLms7OSg/XhrUlyxirn+x9ftsKeE/VvKUJLC4hSPXSDK3PTWC6LE7OKdofQHa2lJuJ9Wg7HOfxlBU2VCu1wjeeL41MiJrgujYQpgNQE6mKQzaDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(66446008)(76116006)(4001150100001)(8676002)(8936002)(64756008)(66946007)(66476007)(4326008)(38070700005)(71200400001)(2616005)(54906003)(186003)(66556008)(110136005)(5660300002)(2906002)(6512007)(36756003)(508600001)(6506007)(26005)(122000001)(6486002)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWs3V1pHOEsyS3ZKSWNzcENyT1Q4ZEdZTHdIS2RyVjlXUVpxNHFnckl3TmdC?=
 =?utf-8?B?UWhFb1pqM1A5WnJVblo0aUlzRUVvM3dTc0U3RERvRDRnbCtxS05IMUFYYzl1?=
 =?utf-8?B?QWZBeGJ4eW90cjgrV1NudjVlM0lEMGFlc3psNFlIV2hJbmRCRHlCc1RwRTlO?=
 =?utf-8?B?WGVWMTRxNDhLQzVHYUlPV3JUUEFWdWUyWDM4bnFkWFJFajJpdDc2dzE5N3p0?=
 =?utf-8?B?WkhNcjI2dTh3MTRrT3c0ZnFuWjhCMEFBUlBRendCdjZBN09GYzYvWnhDNHZR?=
 =?utf-8?B?SXBTQnlzQWdUWEE2WCtkRVo5SjBFMFlaUEhmY0RsZHVadW9kU05ZUHptMTdZ?=
 =?utf-8?B?ZzZrMUdQNzJsZjBxd0I0djIwcDFBV1U4NVlZWHUraDFjZXhuYk82TytteDJr?=
 =?utf-8?B?SHdiVzY5OW90bDVIdnVXRkovVGNFL05RcUpESTY1aFU2YXFRUlczVGt4SC9H?=
 =?utf-8?B?OGhwR3hGMmZOWGkxSStEWHdydmZYTzd5a2F4ZGRoSy9reGJ4TDNmZzhVV1dw?=
 =?utf-8?B?NGdMekkrMk50Y0Z5VEFuSW9SU09sYUpBVEJ1cDFWNkxIb1J6aE9TaVZnc2xw?=
 =?utf-8?B?dWg4Ynh0bXB0WUcwTHFhRk5NSkJFeC95Wm82bjYrRkQ3WmZCWHhYSE5JU2Yx?=
 =?utf-8?B?QzJxWHpDZzRFc2pINjVaWjUyYWs3eXl4RVc5K0xzL1E4TWkzeUFlQWVTOEor?=
 =?utf-8?B?WU5XK3JaV0N3QkQwdmRwaGd6VVY5RVhibXVaZ0ljVFVzZzFjMWh2QmhUNjFM?=
 =?utf-8?B?N05xN2ovSW5XQnQrbEpBZFlZYVdSMDcxNDVnSEF0SFM2VmRMVHIwMG5Wamhi?=
 =?utf-8?B?NzlJUlY1S1ZOM0Q3bkxSUXpIQ0JhdWlQMVh2NGFPM3Y2RDhLYldWUC9tcUE3?=
 =?utf-8?B?UlZWNmZoeDN2TEhHZ0x3clY1RDVjUmZnWE1pUmVXV2d3OHBTeS9nNTBwN0d3?=
 =?utf-8?B?OUpYeE5hL25XMzRxYmRwUkkvZ0MyVUlrYkpPd2Q5TCtGdTlJVmJjWjNuUnhJ?=
 =?utf-8?B?TTFuNFd5MTNKZFZCRDcyUG82TDRXcERuSEJ5bXpqeE16TU5hc08vVm5VK3Zy?=
 =?utf-8?B?NlplMGI0bWl1d1lEaUFmMUZXajJsTlA2SUlZYnlycWREUTBHaHh3ZFNwZXpW?=
 =?utf-8?B?YnJCdFVQNkUxRzgrZUlZam11bDdQM0U3ZzRFSW03MzUva3NxaVB3TFRFd0kr?=
 =?utf-8?B?K3BuL2pIWFpQclYyaXVFcmpTVmRtVGQ4a1hiSTRqMmpGUnQwZWtRb3cyNStj?=
 =?utf-8?B?dGJUM1paSWhOalhmelJHOE9hdnJZMHA4L2hBcFQrN0FGS2NtdCsrcFplelVy?=
 =?utf-8?B?QTIrRVlxRUJ6emwvVU1EUDFZQmFDYWxYeTlwSFBpekY1dE9ocnJua0NzS3Bq?=
 =?utf-8?B?OFhGdHFiRGU4VE1WSXdZT29wZ0VYTTYwWE54VjJYQ3l1OTRURWoxRTd4bFM2?=
 =?utf-8?B?V2Y2ZDU2NGk4TWp1dFduTmxPYXN4Ky9sT1B5UUJVb3VVNitqazFPanRyYU9k?=
 =?utf-8?B?RGZjVzFaNkJwWDJkckpEUmI5QUtMTnlqNURHcFh2WVVqT1llWjc1ZkcrNllx?=
 =?utf-8?B?N2FDcC9YTHplQzA1K0d5dm1aWUxWSGpzTGhsQUxlQWErQjIxOExKZGJrZWhM?=
 =?utf-8?B?MUdoV1M4MXBURE9EMGdNR29rZ2xrQWVTT3Zkazc0UE1mSlMwMGxDMXBjb3lw?=
 =?utf-8?B?b0pKTnZWOG8vN3BLK0JOQXJtQUZXUUlzRmdQd2VGTXRwbldySlo5VHJ6d0Ur?=
 =?utf-8?B?Vmw3THhFaDRKbW5nRzZLTE5JNkFhOEtRdm9nbEZEeFlDQ05vVlVhUUJSbmc5?=
 =?utf-8?B?b3oycWpiUVIwME9jSlczaDR6NVFTOHYrcWx0NGpBdUFPS1IwNnRGWlNZb2I4?=
 =?utf-8?B?SUw3VGNLb2VFNmFWeFp2amUzWXBtVUJuc2ZjYW05UGtVZTVjWXgwcHN2cnZM?=
 =?utf-8?Q?Lt+a9H8RD0U79ZlPC67T6n34mTFeniGE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4160391C41C8A540A1A9DF7C3BDE41F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dc91d5-f690-4aa3-917b-08d9949e2da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 14:22:13.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4411
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTIxIGF0IDEwOjEzIC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFdlZCwgT2N0IDIwLCAyMDIxIGF0IDA3OjA0OjUzUE0gKzAwMDAsIENodWNrIExldmVyIElJ
SSB3cm90ZToNCj4gPiBVbnByaXZpbGVnZWQgbW91bnRpbmcgc2VlbXMgbGlrZSBhIGRpZmZlcmVu
dCBxdWVzdGlvbiB0byBtZS4NCj4gPiBSZWxhdGVkLCBwb3NzaWJseSwgYnV0IG5vdCB0aGUgc2Ft
ZS4gSSdkIHJhdGhlciBsZWF2ZSB0aGF0DQo+ID4gZGlzY3Vzc2lvbiB0byBhbm90aGVyIHRocmVh
ZC4NCj4gDQo+IFdlbGwsIEknZCBiZSBjdXJpb3VzIGlmIGNsaWVudCBtYWludGFpbmVycyBoYXZl
IGFueSB0aG91Z2h0cy4NCj4gDQo+IFRoZSBORlMgY2xpZW50IHN0aWxsIGRpc2FsbG93cyB1bnBy
aXZpbGVnZWQgbW91bnRzLCByaWdodD/CoCBJcyBpdA0KPiBzb21ldGhpbmcgeW91IHRoaW5rIGNv
dWxkIGJlIHN1cHBvcnRlZCwgYW5kIGlmIHNvLCBkbyB5b3UgaGF2ZSBhbg0KPiBpZGVhDQo+IHdo
YXQncyBsZWZ0IHRvIGRvPw0KPiANCj4gVHJvbmQsIEkgcmVtZW1iZXIgYXNraW5nIHlvdSBhYm91
dCB1bnByaXZpbGVnZWQgbW91bnRzIGF0IGEgYmFrZWF0aG9uDQo+IGENCj4gZmV3IHllYXJzIGFn
bywgYW5kIGF0IHRoZSB0aW1lIHlvdSBzZWVtZWQgdG8gdGhpbmsgaXQnZCBiZSBhDQo+IHJlYXNv
bmFibGUNCj4gdGhpbmcgdG8gZG8gZXZlbnR1YWxseSwgYW5kIHRoZSBvbmUgb2JzdGFjbGUgeW91
IG1lbnRpb25lZCB3YXMgdGhhdA0KPiB0aGUNCj4gY2xpZW50IHdhc24ndCBjYXBhYmxlIG9mIG1h
aW50YWluaW5nIHNlcGFyYXRlIHN0YXRlIGluIGRpZmZlcmVudA0KPiBuYW1lc3BhY2VzLsKgIFRo
YXQncyBmaXhlZCwgaXNuJ3QgaXQ/DQo+IA0KDQpZZXMsIHRoYXQncyBtb3N0bHkgZml4ZWQuIEFz
IGZhciBhcyBJJ20gY29uY2VybmVkLCB0aGVyZSBzaG91bGQgYmUgbm8NCm1ham9yIG9ic3RhY2xl
cyB0byBhbGxvd2luZyB1bnByaXZpbGVnZWQgbW91bnRzIGluIHRoZWlyIG93biBwcml2YXRlDQpu
ZXQgbmFtZXNwYWNlLg0KVGhlIG9uZSB0aGluZyB0byBub3RlLCB0aG91Z2gsIGlzIHRoYXQgQVVU
SF9TWVMgc3RpbGwgcmVxdWlyZWQgdGhhdCB0aGUNCmNvbnRhaW5lciBiZSBnaXZlbiBhIENBUF9O
RVRfQklORF9TRVJWSUNFIHByaXZpbGVnZSB0byBhbGxvdyBiaW5kaW5nIHRvDQphIHByaXZpbGVn
ZWQgcG9ydC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
