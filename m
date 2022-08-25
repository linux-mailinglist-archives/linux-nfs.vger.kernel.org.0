Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575645A18BB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiHYSZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbiHYSZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 14:25:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E402AB858;
        Thu, 25 Aug 2022 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+1ASARRvvkP1oluf8NFPirAaGecxvFIv8e+90s0qC9+Lk1u2TUI4SG8gtS/3RflPCY5bIEd5kgrrySBdTA/Zefiubw+PJFHQ6rxlLOtR8BOoNbHlWlq7HhDszpdjW0L5TqaOC7QDANsI5iWXnKJtUy82uKERnGIzIk73PSxKupoUkFRnyBhmsNFTsN2zTCE3keriRmSqfAGfAR3LLUHWavzrdqmEJ9w30XFP9xnaSXGXskLgfr70S7ezXeeMlHsBj2H3fjSuGJE78Uz5C8SiB5K0Flmz0y57v2Wt3OlRuRBuwz7A+ZIXo6Jq+Hum+7aLeLod746zH1Sd3fFk3H9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3htncWWFIKyo/A6NlCeAARGFXAn5khGyLUz95Cdt13E=;
 b=jxIYU4R7Xpu6ACpDBnyJsTagpbCw680SiArbH8jGRTV0fVKtrTyqZa8Srb7EqhziiUYUZ2GY2b98paVNtf30rxvJwBGWaP0Lp29eIwOoVVJ+VDeKdab1hcfi9+NVmHur8EK/Ft0KJhhu4U4Fk9CcU8VUZYv0sjFItwwHu0gK0mGWQ0I2phKOW0k1YyiM0guRY9c0b2PNSs4PsT/m0vWA9HRDx0Q+F3zfezOWcuugEhxJ4t5fp7rKq7cNcRD4fGHx1AvkSRmt2yNIUFzBv2sOPLPnhxdo0L46yLT25/L4QfaDn0QR/uf2c6/yEWyXCUjOSzuqYFHATCK4bLy52IIwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3htncWWFIKyo/A6NlCeAARGFXAn5khGyLUz95Cdt13E=;
 b=VAIvtc18/Q6/kDdBsgcMyLqZbW306SJhrbj5wxouyb2SC1gUuYUDauahCfCYZYfLjHs+i0kx2+M7hNjUpAlhSN/sXH/1mODTEOvt4ZFkv+Dieugq11pvHI73r9CEgC4HCO9RcQMM1FgslM2TAw2cpRVQCwDV0DDYrdZbUCeDwu4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1173.namprd13.prod.outlook.com (2603:10b6:903:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Thu, 25 Aug
 2022 18:25:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Thu, 25 Aug 2022
 18:25:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: Is generic/426 failing on NFS for anyone else?
Thread-Topic: Is generic/426 failing on NFS for anyone else?
Thread-Index: AQHYuKuA2ydD+Urfr0WI0MTJyPLX3K2/7r2A
Date:   Thu, 25 Aug 2022 18:25:25 +0000
Message-ID: <54c101358be4693fa8c8593bfddeb40abeb638c5.camel@hammerspace.com>
References: <0A525E6D-8089-4EF5-8FED-506878FD8817@oracle.com>
In-Reply-To: <0A525E6D-8089-4EF5-8FED-506878FD8817@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9349149-a11d-41c2-8a2d-08da86c72e43
x-ms-traffictypediagnostic: CY4PR13MB1173:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79xZRaBeBXMZBwm5eV4FgVTZFlvILYsZgHuM3ppXIJM3NHvNRwSucZPVgC467c/2206lm89Vd1Kt6dgka4jRktaPpAEDO7QDzu45S1L0qHDDWz4jYZ+7jyUvs4TdYlJE0ynz0xRav6fCQg30nPOJisZH8gBzUSfkQ93JHO/MDWKiElqEIA1qnoOIirhRSg46LFa8VGEMjrJVygtb1iFS3psxsN2CZVBUaZSZfsgdCFk+8r5Qk+QNqPTR8p9HAmaFb9RqOZKLjvjmpwUJSZcGI8cWAtEG1q9RNWeDB0ve8B5FgxjMJ48qrpuICNeuHH50ZRwG5YX2fprJT+lLWyVVN1cJVIZHrnhhR014zYLWHfK2/XIQ1Rbl8nZy+1ajatTh/oyhXsOj7bqKelKjG33UyoIL5rkmAK3zgDePF1ArRGYmlNYTVYpOh9vKyVcieD90QhqmzaFQuymtDdVoodzR1NFlqVBXX2ZKlhNYx4iIBH7WthL+6UATzmlZ2M15IZQJwERMFHTuStAiRyg+iZ7WuABBB7JSQvpT+PJGZF5NmL6+kT6meHCvA4HrVFGE4eRJxUtZgDkgIUpoTzDLLra2X4x5t8ytpY+dz0UZeAwBztsvTI1GfiHcu3mN0Yd8LS9KfZcIIQaiFrw4YuMC/TdU6VWk5rOpZgrqnWm54e5lq8uSppUkxHONQKjqqXSvbXxPQVDg5gBzCITOMygSQeSp3eZI7XoN6/GXuqj6mL6z0oNSPoyXLIYX0fxLRINHGibG6ZAvMrXFDWz6m3QPaybfzgbZBT2E2z/DoGuRBDHFII8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39830400003)(366004)(136003)(5660300002)(36756003)(110136005)(8936002)(38100700002)(6506007)(83380400001)(316002)(186003)(76116006)(71200400001)(4326008)(66476007)(64756008)(66446008)(8676002)(2906002)(66946007)(6486002)(86362001)(478600001)(122000001)(41300700001)(2616005)(38070700005)(26005)(6512007)(66556008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lIRmFrTTZqME5va0NVams1RGJVd0dWMmM0ems3SEY0a29QbkJqdlV2Q0cr?=
 =?utf-8?B?MUM3R0FNY0hOS3QrMzMwbnNMbFBxZjNFTUc4K0JJSis4Y2czSFBnQWpsa2Ra?=
 =?utf-8?B?UUhTNnNVbnAyeDU1dEFFMHhFWU5uU3B2OFFFWmt0Y013SXRXWmZERHAxOUF5?=
 =?utf-8?B?SGl2TWJUbEppd1RhZFRhbm8rREdFZXhoQkNGWU5iTjRBMFpOb1RoM1Jib0Fi?=
 =?utf-8?B?N0dhdGozcGtET0ozT2hzV0loeDdONkN4OFB4eGtEOHFaTUhhU2lRY1oydEtY?=
 =?utf-8?B?OEFlNlpCRkxKMGFQeFluWklOMnk4U3Y1amRUdlRVNnNrdEEvbHJtYVRCQ0hI?=
 =?utf-8?B?V25qMFhETjZBbDUvSk9oUWFjdW80YTh6MEI2ZnlRaVcxWTRtc3ZOeEswbmhQ?=
 =?utf-8?B?QjhrVWhrbDBMMHpYTUZPOXE5czFpQlcvZWlJbnlhaTZydU1LWFY4Q0FJYVJH?=
 =?utf-8?B?QWVNR05TWkYwY2hqVktvOERjaUJWYXFQbURXaU9FR211V0I5eFZORlVIRUxK?=
 =?utf-8?B?M015WnROb21ESHZhNGV5L2JwV3l3MzRXTDJQK25BV1NNclBrcklhWXAweGV2?=
 =?utf-8?B?NVEwQkE5Rm9yRmNvZWhTSTlFMkk4VjYrVnl5U2NLS0xDazFxYm4xYlZaY2Qy?=
 =?utf-8?B?MTRReE80d0RIWmw3UXBHbndlN3Q5NXpFazgycllzbDhHb1FGS1oyYXYwbkJk?=
 =?utf-8?B?K3hweGZPcDZaOWltTXYzQTNuWXIzVmd2OGx5ZkdZbG9ZTFdBVUdIVk5EVWt3?=
 =?utf-8?B?RDUxVTJWMVhKYW1EN040elNKRHJGVHI0dldpUG1jc0EyUjJDYkg2eW5oY290?=
 =?utf-8?B?MmZrMW04VXAyVEEwcldOWlF4MXBIMFBGRDlNMk40Q2c4cDhWQ1dicDVNR2Ix?=
 =?utf-8?B?a2NKTUU4WTBDT0wzM1hlTlZpSXV5Y0U4YXlxNjM4NDhPZUZJVWZPRmNlUUlh?=
 =?utf-8?B?dy9DYmI5RGJ4dDVsZW5wQjRBczl6VFJGcHBwUTk2M0JiWlBzbWs3b3hyUHUz?=
 =?utf-8?B?c05qV3NlZHB1bHBKbzNxdUFvZlV6Unlubmw1SGIrV1VNZWdaVUE2T1BVSW5X?=
 =?utf-8?B?eUp4eUxhaDFTSU9PQ0Q5YTFSNEUydEZSNVBVY2NiVzYrczBQSThzUW5LUFNR?=
 =?utf-8?B?Z2dZZ29namYvSmlqQjQrOVRwcU1NSVlQVmYweXZDcGpCdGVCUTRtQUVSUzMv?=
 =?utf-8?B?d0RKcGl3TVkyUW82R0RTUjRXYWl5aHFyTnVNaHQ2dUhPSW11MkpDMzJMTC83?=
 =?utf-8?B?Zi9rOWVVZ2JFaWF0TDVQNk1jOHRYVEFXU3FLVVViQTUrcFcrTXEwMk5sNGdU?=
 =?utf-8?B?VHlCTEo1b1ovWm5YeS9CRlF6bGN2N1p0UEZWd0RyNDF4bGRsZlBYMENhbTAx?=
 =?utf-8?B?RC9JL2RSanpkbW1jRTNTREVTbE0ybE5KbnJkTlhhY1ZtaUlEVVhWSXVqbVpF?=
 =?utf-8?B?aFRZa2tpN01oemhzSmxIWXU5bXJjT2JCZGtheGU3MGFocm15OVJhaWZIVHlY?=
 =?utf-8?B?ZjUrRnhxMWQ1OVQveEdTZ3YvNThMNVg4MU9McGRIT3MvZnFCQkxGS3NzRHZj?=
 =?utf-8?B?cFA4dmU1RGxuMXU2RmYvaTY5V01HMnk4RzgyTUF3YWpCSUs1dDc1UWVlUUNO?=
 =?utf-8?B?d0JYVkZlQU5nRmJjUXVac1VrckJjbVlYOG8vS2pxendGUUxVeXlEU2VyaWxL?=
 =?utf-8?B?WDhQOGhpSlUyTnJITFZPU2ZhMUJIVFRYVTR6a3hRRDlqOWJaZEF6cWg4SG4w?=
 =?utf-8?B?K3F5TEpjK3pxMjk0akdNNkRiZkVWRkFWMmEydXVHcWtoQW44OFhSMHJURzZ3?=
 =?utf-8?B?Q01QVzArZVI0bkRsUC9sdWFCOGV1cFlkdmExQ1l4L05wUWlTZ2xPWUE5ejI0?=
 =?utf-8?B?eDNpVEpNZVdYcC9rSVQzN09MTHBRYUNzdm40TlJRdGM0eEdZN1BWSHIxc1A0?=
 =?utf-8?B?YTFyblYrOGhueDI1STR6bW9GSXJHOFV5OTRlMHZQWDJsclJXamdIWkJFVUJ4?=
 =?utf-8?B?cWZzL2E3TDNtZ2hxdmhUdytBd2JLUmtaY0VxWkZ5NjFCaGlWUEF6aVdIbS9R?=
 =?utf-8?B?RWRld1ZUcy8wTFFMNk0zWURGUExkZ0VTVXlyQnlrRkRqZzIzZzhNc0djbW1B?=
 =?utf-8?B?OFU2MXFvTStDYkdPVzR1ZTRVWEtsUUVrWWlOT1VUUzMwMWExTUkyZXhmTUF3?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6E0D2A08C2A2438F3D356B85549157@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9349149-a11d-41c2-8a2d-08da86c72e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 18:25:25.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0/vokciW+iWsO10xnybMRNYxpWPj6zU3hv9QmmMr0Fm+BJG/0vnPFdFk9fOIV9yF1Jz4FcArO+g/Vqilun4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDE3OjUyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEkgaGF2ZSBzdGFydGVkIHRvIHNlZSB0aGlzIGZhaWx1cmUgd2l0aCBzb21lIHJlZ3VsYXJp
dHk6DQo+IA0KPiBbY2VsQG1vcmlzb3QgeGZzdGVzdHNdJCBzdWRvIC4vY2hlY2sgLW5mcyBnZW5l
cmljLzQyNg0KPiBGU1RZUMKgwqDCoMKgwqDCoMKgwqAgLS0gbmZzDQo+IFBMQVRGT1JNwqDCoMKg
wqDCoCAtLSBMaW51eC94ODZfNjQgbW9yaXNvdCA2LjAuMC1yYzEtMDAwMDEtZzJkOGNkYWRhYzBk
Ng0KPiAjMTMyIFNNUCBQUkVFTVBUIFN1biBBdWcgMjEgMTk6MzA6MTIgRURUIDIwMjINCj4gDQo+
IGdlbmVyaWMvNDI2IDJzIC4uLiAtIG91dHB1dCBtaXNtYXRjaCAoc2VlDQo+IC9ob21lL2NlbC9z
cmMveGZzdGVzdHMvcmVzdWx0cy8vZ2VuZXJpYy80MjYub3V0LmJhZCkNCj4gwqDCoMKgIC0tLSB0
ZXN0cy9nZW5lcmljLzQyNi5vdXTCoMKgwqAyMDE4LTAzLTEwIDExOjExOjMzLjQ4MzY1NzkxOSAt
MDUwMA0KPiDCoMKgwqAgKysrIC9ob21lL2NlbC9zcmMveGZzdGVzdHMvcmVzdWx0cy8vZ2VuZXJp
Yy80MjYub3V0LmJhZMKgwqDCoMKgwqAyMDIyLQ0KPiAwOC0yNSAxMzo0MDowMS4xNzQ3Nzk0NzYg
LTA0MDANCj4gwqDCoMKgIEBAIC0xLDUgKzEsMzA3NyBAQA0KPiDCoMKgwqDCoCBRQSBvdXRwdXQg
Y3JlYXRlZCBieSA0MjYNCj4gwqDCoMKgwqAgdGVzdF9maWxlX2hhbmRsZXMgVEVTVF9ESVIvNDI2
LWRpciAtZA0KPiDCoMKgwqDCoCB0ZXN0X2ZpbGVfaGFuZGxlcyBURVNUX0RJUi80MjYtZGlyDQo+
IMKgwqDCoCArb3Blbl9ieV9oYW5kbGUoL21udC80MjYtZGlyL2ZpbGUwMDAwMDApIHJldHVybmVk
IDExNiBpbmNvcnJlY3RseQ0KPiBvbiBhIGxpbmtlZCBmaWxlIQ0KPiDCoMKgwqAgK29wZW5fYnlf
aGFuZGxlKC9tbnQvNDI2LWRpci9maWxlMDAwMDAxKSByZXR1cm5lZCAxMTYgaW5jb3JyZWN0bHkN
Cj4gb24gYSBsaW5rZWQgZmlsZSENCj4gwqDCoMKgICtvcGVuX2J5X2hhbmRsZSgvbW50LzQyNi1k
aXIvZmlsZTAwMDAwMikgcmV0dXJuZWQgMTE2IGluY29ycmVjdGx5DQo+IG9uIGEgbGlua2VkIGZp
bGUhDQo+IMKgwqDCoCArb3Blbl9ieV9oYW5kbGUoL21udC80MjYtZGlyL2ZpbGUwMDAwMDMpIHJl
dHVybmVkIDExNiBpbmNvcnJlY3RseQ0KPiBvbiBhIGxpbmtlZCBmaWxlIQ0KPiDCoMKgwqAgLi4u
DQo+IMKgwqDCoCAoUnVuICdkaWZmIC11IC9ob21lL2NlbC9zcmMveGZzdGVzdHMvdGVzdHMvZ2Vu
ZXJpYy80MjYub3V0DQo+IC9ob21lL2NlbC9zcmMveGZzdGVzdHMvcmVzdWx0cy8vZ2VuZXJpYy80
MjYub3V0LmJhZCfCoCB0byBzZWUgdGhlDQo+IGVudGlyZSBkaWZmKQ0KPiBSYW46IGdlbmVyaWMv
NDI2DQo+IEZhaWx1cmVzOiBnZW5lcmljLzQyNg0KPiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+IA0K
PiBbY2VsQG1vcmlzb3QgeGZzdGVzdHNdJCANCj4gDQo+IDExNiBpcyBFU1RBTEUuDQo+IA0KPiBE
dXJpbmcgdGhpcyB0ZXN0IChvbiBORlN2NC4wKSB0aGUgY2xpZW50IHNlbmRzIGFuIE9QRU4oQ0xB
SU1fTlVMTCkNCj4gd2l0aA0KPiBhIG5hbWUgb2YgIi8iIChjb25maXJtZWQgdmlhIG5ldHdvcmsg
Y2FwdHVyZSkuIFRoZSBMaW51eCBORlMgc2VydmVyDQo+IHJlamVjdHMgdGhpcyBPUEVOIHdpdGgg
TkZTNEVSUl9CQUROQU1FIGR1ZSB0byBhIGNoZWNrIGluDQo+IGZzL25mc2QvbmZzNHhkci5jOjpj
aGVja19maWxlbmFtZSgpLg0KPiANCg0KVGhlcmUgaXMgbm8gc2FuZSB3YXkgdG8gc3VwcG9ydCBv
cGVuX2J5X2hhbmRsZSgpIGluIE5GU3Y0LjAsIGR1ZSB0byB0aGUNCnByb3RvY29sIGxpbWl0YXRp
b25zIG9uIE9QX09QRU4gc28gd2Ugc2hvdWxkIGp1c3QgZml4IHRoZSBjbGllbnQgdG8NCnJldHVy
biBFTk9UU1VQIGlmIHNvbWVvbmUgdHJpZXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
