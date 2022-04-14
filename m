Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49085016CF
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Apr 2022 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiDNPMS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354362AbiDNOmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 10:42:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE4D3AD0
        for <linux-nfs@vger.kernel.org>; Thu, 14 Apr 2022 07:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObnKJFI2s4l9fO7cLMPL1LOf+wQIXqkWgMuTtejalpbRPfmzbgT6DC8WAaWVphg/xyw3xgDorjj38CKB0Djr18dbTkxu7rEl/j5/GOm0zYPULd5AOSz7YEcTQsWxxYrToG+5tx76SBKEdtXWhOXqeOXTgGsOGD5wSarHGNYxPp9/42ymObLVnhypKDAg4nfGMaAml1r67mujJU6A56nyZQi+2s+IlGyOAq7EVzHKAhKUsZVju3T6FAtWvtMoY53hQTxP0RZLjZE9koqrsipswHpfnVoHIHzhjRf7lIYGrcxotrAXuO1WvOtUes3KcXMWyNjOl+3N+nkALlYpEJf5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3Hu1PzMvM4T0nyCZaZOJTfEE0g63tFI4Mqt/W4AKTU=;
 b=RnKzHSeyxpOioNBPE9YiJElwFb+Og+wCU1xHuG1F+9CvkxeQju/tBnNG2JmBhWjClNgMFjtipm7RzPid46LkgyevfIiRoj/OL0aRgF0aJxEfoAtDbaHpdA5u3QJeSpvP7xB+6nIo3xVcS/NctpSVHCZyCBHmTvZW2qJ/ghPFfzdJwUY7GpoEdh6Dx2dwqYVvyHnZG77R3AXasYnWxivXG4dmvbHF3ooqhjvo1zb4C98g/HH9yeSQw0L613qm/+ND9RjCAUiA+ZUdKyLjucMlmcoVGnnOX2Brjj1Ao4I7gqNhM+WqV4n4MXbGkmFOpUwfloQ6rZzRZPyQRuMDTxbugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3Hu1PzMvM4T0nyCZaZOJTfEE0g63tFI4Mqt/W4AKTU=;
 b=cuKSCHst8Akkha32sHQr9S0T0ZquQVrS/3z3QqyE2JPCCzNZ3vOJzwWzg8IlmD1ZwX02WUTrAr5IRh+uB+cJ9zcDxsgoJW2AtCbknKw+Yg+5SEK8ivu8bWEpstFpeJ90pviDmmUOf8sRSeQxAKMhi6vR8jW5LA1MFLCj8SAymSA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4590.namprd13.prod.outlook.com (2603:10b6:5:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.17; Thu, 14 Apr
 2022 14:34:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5186.006; Thu, 14 Apr 2022
 14:34:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Topic: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Index: AQHYTeNGiM/oA9hFA0+RaWui6u++96zr2+yAgACIFICAAmwogIAABh+AgAAE7ACAAKKmgA==
Date:   Thu, 14 Apr 2022 14:34:59 +0000
Message-ID: <82b19ce58b6a7a101b2f8eb269965b4f78e9cb67.camel@hammerspace.com>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>      ,
 <164974719723.11576.583440068909686735@noble.neil.brown.name>  ,
 <4918188E-9271-47F2-8F5A-D6D5BEB85F36@oracle.com>      ,
 <164990959799.11576.7740616159032491033@noble.neil.brown.name> ,
 <64807ea6a8d169e426cff4fa75a6de9b16d3ae35.camel@hammerspace.com>
         <164991196867.11576.15674607042113472005@noble.neil.brown.name>
In-Reply-To: <164991196867.11576.15674607042113472005@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0f2e00c-ffea-48e6-119f-08da1e23f3f0
x-ms-traffictypediagnostic: DS7PR13MB4590:EE_
x-microsoft-antispam-prvs: <DS7PR13MB4590DAB80D2067501F4804DDB8EF9@DS7PR13MB4590.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zozFoiBXU04SM2m5D4fpXDA0zyZPCm5wCZ9WdaKS0MH6i65ASxrJ1dWo0QMOuY8D3P38JKiKUaLsUvuOTBFFY2WRdwpLL1FcIaRBII+nBOvZ4jln/twVZJFA4d8T1gAxZZYtntSQD3rXwGYeGW36aRTDuQ0GXW3/gNOfF3AjV+SeQF2A/3ZgMRe3arekiDaG6Rac+RHkZTT9oEmZkXpZyZfHj6AmhEsX+b8ZcMehgzTNSEb6mUY/8EaXbzosHzhSqx5lzD4t/hf7k1UD68ldvkjxRTfPmb3tx8llc2n4/yb+CLtV1RQE4SUcW1Gda31DNXh1hq8tTse/bn5LFYKGE88CMcjHORP5IQO7PVrc5wfPbtNGxtq3dkg0yYinB3skxqwfy9Esicxt4YMApxNL7qO7RhNlT6WNmok3Z1Ty3f5NrBQatbbX4iOAmsDB2fASgcoXkqwZavzVSKMv2Ec4hjyk+DNhxI9NjtmaNKyJyBwxyadu9B7JbsEFfSGqv0NWMXMCqOLEZA/FkbPGgxVkwh6DQ8Qn77aAtNMZLmlUKnkgOeVrvqwyVvNE+H9J+C1a+INTIHSpvcy8z27IORYV2jLrtiYS2ip2rpMbnXDI31sV2qnkNy0T64NjVIaRGhIE+sZNyY4cEU3o3NhE17aBHrXdDMtmORgGI2ncWWdTR/znFF+CPDrozIFVwGSDlPPdD5G8Bxn4+ceJp0+hSdPoSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(76116006)(66946007)(66556008)(86362001)(64756008)(66446008)(38100700002)(8676002)(83380400001)(66476007)(5660300002)(38070700005)(8936002)(71200400001)(6486002)(508600001)(2906002)(122000001)(26005)(186003)(53546011)(2616005)(6512007)(316002)(6916009)(36756003)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlpoMm92Z0lMbzlJUjRVYVp6dzM5cWVNWE9jOXRoODA5cWJLOXVwVjRFUGtK?=
 =?utf-8?B?SFFma2VlS1BHUjcwcVhZNUJOb1hhVXlrL2IvbkRjTjZuMUpGNno0cXEwT05i?=
 =?utf-8?B?Znp4djJEWVlZUjFVR09qZU1yYzV5QzJZdVFPNHpMRGljaS9uMkk0QW0rbC9o?=
 =?utf-8?B?QXFHMnV0aUpSRVd0YThGNzk1QWVsOGhyUU00SDQ1WVE2VXFKRTk4aTZadUIv?=
 =?utf-8?B?UVZFQmp5clhpa2hTVG9pSk1YcitLVENEZ29keFcwOGdjYlhuSnJlZ1BFU29P?=
 =?utf-8?B?YmlVTEpMcUhrSExma2M4SXRIOVQzZS9rdzZENlIvcktrazdFSis1azhQWndE?=
 =?utf-8?B?dDdIMzlrY3gvQmRVZ3ZkMlltR2hJSHpLSDVCcnFNYW5SWW5JZDFtNTMrN3dn?=
 =?utf-8?B?MUtaWjFwczlveEJwZEo1ZlNINSt1dzFkOENJTjJTZnZNNDhEc08wVnJ6N1BN?=
 =?utf-8?B?RE5BLytHRERTbmdzZXFsU0dxUU5sMWRaem5PWUJIVFMyVGRETXVLSGtBS1pN?=
 =?utf-8?B?MnBkdTBEVU5aWDNPT0xKS1dxcEx4UzdEVEhhU01jY1FqK1h6c3dzeXJHRHpw?=
 =?utf-8?B?blVldjlCdEhpY0RqL2JSQUEzOFh4ZFJIRWc1WmZUL2dYb3pHOXdOWktWZEVX?=
 =?utf-8?B?L0pUNnhXZkk0b1VpRjgwQjZEL3B5em8veFhxbGJpRTY0MWtRRFFUS2Y5SjNr?=
 =?utf-8?B?bjZFT3JkWHQ5ajErVW9BNUo4NXE1eEZJTGpwNkhmK2ozdDVXVlVSWElPVnFT?=
 =?utf-8?B?blhQeFd1SERxQlhiYzVhR1ZxR0liMzc5Qmp3cSs4RGhXZUNRMlNhQ3RSQ0Fy?=
 =?utf-8?B?Rzk1VmdzL1o4Z2YveGV4UERqYTlGZ3ZXVUgyMklJRzFuUndPaWhXaEFHTnNF?=
 =?utf-8?B?WmxHY2YwbE51MWkzbXl1cXFFeDBZM205VW9TbEU2Nzl0Sjk1NTl6ZFJJT3Q3?=
 =?utf-8?B?UWVibzlJOFVZY3oxOHhnVER3WWRNdGY0TmZVL0dJUHVjYm9rWmx3eW1sU25t?=
 =?utf-8?B?VG9mZ08zT0Yrb3NRNGF4dHg0QnZibUR0WUtqUkpaVVI3SVdad21WNGxLZnAr?=
 =?utf-8?B?c3BQSG9sbHVwNGdBL0Mzb0hsRThqR1lzYW9sSHNGRzFlV25xQnA5aDU3Z0tl?=
 =?utf-8?B?bmRMSEFDR3NqOUxmYTB1R0NFTFQ2QTN2STRaMWlXMDFrbCsra0Y2NGtaTnFx?=
 =?utf-8?B?b0N5TjZUNTNoYk93OG44N0ZDV24rcUpZNCtybjdDRG42dWd2ZjYzNzFIKzhw?=
 =?utf-8?B?b0JFTS9oSXdrYXg1QW1tY2h0dzlUN3g2bUxVOW9oYWpQTDBXVjF6L0owbXhV?=
 =?utf-8?B?WEFlUW9YeUhOZzREdWIrK2FXYUJERzdYRWFaYU1Ea3Z4NTNTZGRtODVDT1Er?=
 =?utf-8?B?NmVVdC9BTVpEYWs4cXN0R2g1VTZza1VvajhJd2E3ZjNjZ2d5R3NwUjR2bmNv?=
 =?utf-8?B?Mk90aHBrN0RiVkd4TlVPK2t0eFBBRkJVaHNhVjY5VU1lcTdIT25jTGIyMW5D?=
 =?utf-8?B?SDVBU3BHQ0x1MmxJWWpJYlJWMlpDVjdWQTMrcitYVGo3bmcvUk5zc0pvWW92?=
 =?utf-8?B?Q1V3REVuS2djM3k5dlFHa3I2Qkh4MmlLUmhya3h5aUxlR1E3OW1JN1NNWGZv?=
 =?utf-8?B?dU9GTzRuYlhnbFNKVnFQZk9KVHU2ZkJuM29tQlF4YWxjcllIQml3QnRMRmdh?=
 =?utf-8?B?U2c4eXZla2g3QjIxblFWRVJEenJ1SFQ1ckw1SU9VeUR0ZVBSMWtLL0twUkVv?=
 =?utf-8?B?aG1venNuYXNXUW5YdFBlWUVhWkpsTXNWeDArbzA5L2NBRHM1YVRpQzB3S3Fx?=
 =?utf-8?B?K0Y1THhHK212d1pQeDdzSzhhUi9JTkhoY0o4TWwrdjlQME1GbGx6ejhuVjRr?=
 =?utf-8?B?SFhGQ3lzc2tLbTRtcWtDY1Zsd2FiekZ5UW53aTQ1UmIwRlFtQ0FnMnJmdENZ?=
 =?utf-8?B?QkhaSHRjekM4OU5IVG5TT0VkZWtlVEpsV2xUZm5lTmpkRDE2SjMrN0cyWmti?=
 =?utf-8?B?RTFvR2YyVXNFeDlUNHZ3TkluNVlxcXdlNVZod1pXUkxlMzRiTUFHZ3cyV3BJ?=
 =?utf-8?B?YUJldTdiODVrRitQQXIxM0V1RUhycFNvc0wvckUwL0t3aWFuQmQ1VDdSVTdJ?=
 =?utf-8?B?eTdHWDIySnZ6dnF4dEhZTEx3MzBmYkR0dkJod3F1aHdidzNHenZ0eGZDL0xN?=
 =?utf-8?B?cXZMY2NaVWZWaG5IVVhOdGVQWlV0SnllV2p6T2NuendhVEZjcHcyNGJ4bTJa?=
 =?utf-8?B?SlZqVVVWTDFNbHdQNjY5ZmVKRU1ueXBVSVhMQWpnZWMzWlN1N2FMQktVcnUr?=
 =?utf-8?B?RkZ2US9IVEViYlNiUHFVdnlhdDZKZkFteUVGN243dEZERFZEY3BDaGVCb1Mr?=
 =?utf-8?Q?wqXq61gFSNhTfuC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13A4D4A1554BD24A8627B57DCF1A17CE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f2e00c-ffea-48e6-119f-08da1e23f3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 14:34:59.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvD/oM2zYqUEA1+vo2NErDFfSOptWNO5yTh8JT9Cut1hljM7pO3A7Sj9EZ9KMNQhwGZXlMH/UOcyK0JOkPE3vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTE0IGF0IDE0OjUyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMTQgQXByIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjItMDQtMTQgYXQgMTQ6MTMgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
MTMgQXByIDIwMjIsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4g
T24gQXByIDEyLCAyMDIyLCBhdCAzOjA2IEFNLCBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+IHdy
b3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFR1ZSwgMTIgQXByIDIwMjIsIENodWNrIExl
dmVyIHdyb3RlOg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK0lmIGEgY2xpZW50J3MgImNv
X293bmVyaWQiIHN0cmluZyBvciBwcmluY2lwYWwgYXJlIG5vdA0KPiA+ID4gPiA+ID4gc3RhYmxl
LA0KPiA+ID4gPiA+ID4gK3N0YXRlIHJlY292ZXJ5IGFmdGVyIGEgc2VydmVyIG9yIGNsaWVudCBy
ZWJvb3QgaXMgbm90DQo+ID4gPiA+ID4gPiBndWFyYW50ZWVkLg0KPiA+ID4gPiA+ID4gK0lmIGEg
Y2xpZW50IHVuZXhwZWN0ZWRseSByZXN0YXJ0cyBidXQgcHJlc2VudHMgYSBkaWZmZXJlbnQNCj4g
PiA+ID4gPiA+ICsiY29fb3duZXJpZCIgc3RyaW5nIG9yIHByaW5jaXBhbCB0byB0aGUgc2VydmVy
LCB0aGUgc2VydmVyDQo+ID4gPiA+ID4gPiBvcnBoYW5zDQo+ID4gPiA+ID4gPiArdGhlIGNsaWVu
dCdzIHByZXZpb3VzIG9wZW4gYW5kIGxvY2sgc3RhdGUuIFRoaXMgYmxvY2tzDQo+ID4gPiA+ID4g
PiBhY2Nlc3MNCj4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiArbG9ja2VkIGZpbGVzIHVudGls
IHRoZSBzZXJ2ZXIgcmVtb3ZlcyB0aGUgb3JwaGFuZWQgc3RhdGUuDQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiArSWYgdGhlIHNlcnZlciByZXN0YXJ0cyBhbmQgYSBjbGllbnQgcHJlc2VudHMg
YSBjaGFuZ2VkDQo+ID4gPiA+ID4gPiAiY29fb3duZXJpZCINCj4gPiA+ID4gPiA+ICtzdHJpbmcg
b3IgcHJpbmNpcGFsIHRvIHRoZSBzZXJ2ZXIsIHRoZSBzZXJ2ZXIgd2lsbCBub3QNCj4gPiA+ID4g
PiA+IGFsbG93DQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ICtjbGllbnQgdG8gcmVjbGFp
bSBpdHMgb3BlbiBhbmQgbG9jayBzdGF0ZSwgYW5kIG1heSBnaXZlDQo+ID4gPiA+ID4gPiB0aG9z
ZQ0KPiA+ID4gPiA+ID4gbG9ja3MNCj4gPiA+ID4gPiA+ICt0byBvdGhlciBjbGllbnRzIGluIHRo
ZSBtZWFuIHRpbWUuIFRoaXMgaXMgcmVmZXJyZWQgdG8gYXMNCj4gPiA+ID4gPiA+ICJsb2NrDQo+
ID4gPiA+ID4gPiArc3RlYWxpbmciLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgaXMgbm90
IGEgcG9zc2libGUgc2NlbmFyaW8gd2l0aCBMaW51eCBORlMgY2xpZW50LsKgIFRoZQ0KPiA+ID4g
PiA+IGNsaWVudA0KPiA+ID4gPiA+IGFzc2VtYmxlcyB0aGUgc3RyaW5nIG9uY2UgZnJvbSB2YXJp
b3VzIHNvdXJjZXMsIHRoZW4gdXNlcyBpdA0KPiA+ID4gPiA+IGNvbnNpc3RlbnRseSBhdCBsZWFz
dCB1bnRpbCB1bm1vdW50IG9yIHJlYm9vdC7CoCBJcyBpdCB3b3J0aA0KPiA+ID4gPiA+IG1lbnRp
b25pbmc/DQo+ID4gPiA+IA0KPiA+ID4gPiBOZWlsLCB0aGFua3MgZm9yIHRoZSBleWVzLW9uLiBJ
J3ZlIGludGVncmF0ZWQgdGhlIG90aGVyDQo+ID4gPiA+IHN1Z2dlc3Rpb25zDQo+ID4gPiA+IGlu
IHlvdXIgcmVwbHkuIEhvd2V2ZXIgdGhlcmUgYXJlIHNvbWUgY29ybmVyIGNhc2VzIGhlcmUgdGhh
dA0KPiA+ID4gPiBJJ2QNCj4gPiA+ID4gbGlrZSB0byBjb25zaWRlciBiZWZvcmUgcHJvY2VlZGlu
Zy4NCj4gPiA+ID4gDQo+ID4gPiA+IEdlbmVyYWxseSwgcHJlc2VydmluZyB0aGUgY2xfb3duZXJf
aWQgc3RyaW5nIGlzIGdvb2QgZGVmZW5zZQ0KPiA+ID4gPiBhZ2FpbnN0DQo+ID4gPiA+IGxvY2sg
c3RlYWxpbmcuIExvb2tzIGxpa2UgdGhlIExpbnV4IE5GUyBjbGllbnQgZGlkbid0IGRvIHRoYXQN
Cj4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+IGNlYjNhMTZjMDcwYyAoIk5GU3Y0OiBDYWNoZSB0aGUg
TkZTdjQvdjQuMSBjbGllbnQgb3duZXJfaWQgaW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHN0cnVj
dCBuZnNfY2xpZW50IikuDQo+ID4gPiA+IA0KPiA+ID4gPiBJZiBhIHNlcnZlciBmaWxlc3lzdGVt
IGlzIG1pZ3JhdGVkIHRvIGEgc2VydmVyIHRoYXQgdGhlIGNsaWVudA0KPiA+ID4gPiBoYXNuJ3QN
Cj4gPiA+ID4gY29udGFjdGVkIGJlZm9yZSwgYW5kIHRoZSBjbGllbnQncyB1bmlxdWlmaWVyIG9y
IGhvc3RuYW1lIGhhcw0KPiA+ID4gPiBjaGFuZ2VkDQo+ID4gPiA+IHNpbmNlIHRoZSBjbGllbnQg
ZXN0YWJsaXNoZWQgaXRzIGxlYXNlIHdpdGggdGhlIGZpcnN0IHNlcnZlciwNCj4gPiA+ID4gdGhl
cmUNCj4gPiA+ID4gaXMgdGhlIHBvc3NpYmlsaXR5IG9mIGxvY2sgc3RlYWxpbmcgZHVyaW5nIHRy
YW5zcGFyZW50IHN0YXRlDQo+ID4gPiA+IG1pZ3JhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IEkn
bSBhbHNvIG5vdCBjZXJ0YWluIGhvdyB0aGUgTGludXggTkZTIGNsaWVudCBwcmVzZXJ2ZXMgdGhl
DQo+ID4gPiA+IHByaW5jaXBhbA0KPiA+ID4gPiB0aGF0IHdhcyB1c2VkIHdoZW4gYSBsZWFzZSBp
cyBmaXJzdCBlc3RhYmxpc2hlZC4gSXQncyBnb2luZyB0bw0KPiA+ID4gPiB1c2UNCj4gPiA+ID4g
S2VyYmVyb3MgaWYgcG9zc2libGUsIGJ1dCB3aGF0IGlmIHRoZSBrZXJuZWwncyBjcmVkIGNhY2hl
DQo+ID4gPiA+IGV4cGlyZXMNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IHRoZSBrZXl0YWIgaGFzIGJl
ZW4gYWx0ZXJlZCBpbiB0aGUgbWVhbnRpbWU/IEkgaGF2ZW4ndCB3YWxrZWQNCj4gPiA+ID4gdGhy
b3VnaA0KPiA+ID4gPiB0aGF0IGNvZGUgY2FyZWZ1bGx5IGVub3VnaCB0byB1bmRlcnN0YW5kIHdo
ZXRoZXIgdGhlcmUgaXMgc3RpbGwNCj4gPiA+ID4gYQ0KPiA+ID4gPiB2dWxuZXJhYmlsaXR5Lg0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB0aGluayBpZCBzdGFiaWxpdHkgcmVsYXRl
cyB0byBsb2NrIHN0ZWFsaW5nLg0KPiA+ID4gDQo+ID4gPiAtIGdsb2JhbCB1bmlxdWVuZXNzIGd1
YXJkcyBhZ2FpbnN0IHN0ZWFsaW5nDQo+ID4gPiAtIHN0YWJpbGl0eSBndWFyZHMgYWdhaW5zdCBt
aXNwbGFjaW5nIGxvY2tzIGR1cmluZyBtaWdyYXRpb24NCj4gPiA+ICgic3RvbGVuIg0KPiA+ID4g
LSBzZWVtcyBhbiBpbmFwcHJvcHJpYXRlIHRlcm0gYXMgbm8gZW50aXR5IGFuIGJlIGJsYW1lZCBm
b3INCj4gPiA+IHN0ZWFsaW5nKS4NCj4gPiA+IA0KPiA+ID4gQ2VydGFpbmx5IHN0YWJpbGl0eSBv
ZiBib3RoIHRoZSBpZGVudGl0eSBhbmQgdGhlIGNyZWRlbnRpYWwgYXJlDQo+ID4gPiBpbXBvcnRh
bnQuwqAgSWYgdGhhdCBzdGFiaWxpdHkgaXMgbm90IHByb3ZpZGVkIHRoZW4gdGhhdCBpcyBhDQo+
ID4gPiBrZXJuZWwNCj4gPiA+IGJ1Zy4NCj4gPiA+IEFzIHlvdSBzYXksIGNlYjNhMTZjMDcwYyBm
aXhlZCBhIGJ1ZyBpbiB0aGlzIGFyZWEuDQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoaXMgZG9jdW1l
bnQgaXMgYW4gYXBwcm9wcmlhdGUgcGxhY2UgdG8gd2Fybg0KPiA+ID4gYWdhaW5zdA0KPiA+ID4g
a2VybmVsIGJ1Z3MgLSB0aGF0IGRvZXNuJ3QgZml0IHdpdGggdGhlIHB1cnBvc2UgZ2l2ZW4gaW4g
dGhlDQo+ID4gPiBpbnRyby4NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCBrbm93IGtub3cgaWYgdGhl
IGNyZWRlbnRpYWwgY2FuIGNoYW5nZSBlaXRoZXIgLSBJIGhvcGUNCj4gPiA+IG5vdC4NCj4gPiA+
IElGIHRoZSBjcmVkZW50aWFsIGNhbiBhY3R1YWxseSBjaGFuZ2UsIHRoYXQgd291bGQgYmUgYSBr
ZXJuZWwNCj4gPiA+IGJ1Zy4NCj4gPiA+IElGIHRoZSBzYW1lIGNyZWRlbnRpYWwgY2Fubm90IGJl
IHJlbmV3ZWQsIHRoYXQgaXMgYSBzZXBhcmF0ZQ0KPiA+ID4gcHJvYmxlbSwNCj4gPiA+IGJ1dCBz
aG91bGQgYmUgdHJlYXRlZCBsaWtlIGFueSBvdGhlciBjcmVkZW50aWFsIHRoYXQgY2Fubm90IGJl
DQo+ID4gPiByZW5ld2VkLg0KPiA+ID4gDQo+ID4gPiBJIHdvbid0IGFyZ3VlIHN0cm9uZ2x5IGFn
YWluc3QgdGhpcyB0ZXh0IC0gSSBqdXN0IGRvbid0IHNlZSBob3cNCj4gPiA+IGl0IGlzDQo+ID4g
PiBhcHByb3ByaWF0ZSBhbmQgdGhpbmsgaXQgY291bGQgYmUgY29uZnVzaW5nLg0KPiA+ID4gDQo+
ID4gDQo+ID4gU2VlIFJGQyA1NjYxLCBTZWN0aW9uIDIuNC4zLg0KPiA+IA0KPiA+IEl0IGlzIHVw
IHRvIHRoZSBzZXJ2ZXIgdG8gZW5mb3JjZSB0aGUgY29ycmVzcG9uZGVuY2UgYmV0d2VlbiB0aGUN
Cj4gPiBsZWFzZQ0KPiA+IGFuZCB0aGUgcHJpbmNpcGFsIHRoYXQgb3ducyB0aGF0IGxlYXNlLg0K
PiA+IA0KPiANCj4gSSdtIHNvcnJ5IGJ1dCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHJlbGV2YW5j
ZSBvZiB0aGF0IHN0YXRlbWVudC4NCj4gDQo+IEkgdGhpbmsgd2UgYXJlIHRhbGtpbmcgYWJvdXQg
dGhlIGNsaWVudCwgYW5kIHRoZSBpbXBvcnRhbmNlIG9mIHVzaW5nDQo+IGENCj4gc3RhYmxlIGlk
ZW50aXR5IGFuZCBwcmluY2lwYWwuwqAgT2J2aW91cyBpZiB0aGUgY2xpZW50IGNoYW5nZXMgZWl0
aGVyDQo+IHRoZW4gdGhlIGNvcnJlY3QgYWN0aW9uIG9mIHRoZSBzZXJ2ZXIgd2lsbCBjYXVzZSBw
cm9ibGVtcyBmb3IgdGhlDQo+IGNsaWVudC4NCj4gSSdtIHNheWluZyB0aGF0IHRoZSBzeXMgYWRt
aW4gc2hvdWxkbid0IG5lZWQgdG8gd29ycnkgYWJvdXQgdGhpcyBhcw0KPiB0aGUNCj4gTkZTIGtl
cm5lbCBtb2R1bGUgc2hvdWxkIGVuc3VyZSB0aGVzZSB0aGluZ3MgZG9uJ3QgY2hhbmdlIC0gYW5k
IEkNCj4gdGhpbmsNCj4gdGhhdCBpdCBkb2VzLCB0aG91Z2ggSSdtIG5vdCBjZXJ0YWluIGFib3V0
IHRoZSBwcmluY2lwYWwgYXMgSSBoYXZlbid0DQo+IGNoZWNrZWQuDQoNClRoZSB1c2Ugb2YgdGhl
IHBocmFzZSAibG9jayBzdGVhbGluZyIgaW1wbGllcyB0aGF0IHRoZXJlIGlzIGEgc2VjdXJpdHkN
CmFzcGVjdC4gSSdtIHNheWluZyB0aGF0IHRoZSBsZWFzZSBpcyBhc3NvY2lhdGVkIHdpdGggYSBw
cmluY2lwYWwgdGhhdA0KaXMgc3VwcG9zZWQgdG8gYmUgdW5pcXVlIHRvIHRoZSBjbGllbnQgaW4g
dGhlIGlkZWFsIHdvcmxkIG9mIHN0cm9uZw0KYXV0aGVudGljYXRpb24uIFRoZSBzZXJ2ZXIgZW5m
b3JjZXMgdGhhdCBhc3NvY2lhdGlvbi4NCg0KT24gaXRzIHNpZGUsIHRoZSBrZXJuZWwgY2xpZW50
IGRvZXNuJ3Qga25vdyBvciBjYXJlIGFib3V0IHByaW5jaXBhbHMuDQpJdCBkb2Vzbid0IGtub3cg
b3IgY2FyZSBhYm91dCBrZXl0YWJzIGFuZCB0aGVpciBjb250ZW50cy4gSXQganVzdCBrbm93cw0K
dGhhdCBpdCBwcmVzZW50cyB0aGUgc2FtZSBjcmVkZW50aWFsIHRvIHRoZSBSUEMgbGF5ZXIsIGFu
ZCB0aGVuDQp3aGF0ZXZlciBoYXBwZW5zLCBoYXBwZW5zLiBJZiB0aGUgdXNlciB3YW50cyB0byBz
aG9vdCB0aGVtc2VsdmVzIGluIHRoZQ0KZm9vdCBieSBjaGFuZ2luZyB0aGUgcHJpbmNpcGFsIGFz
c29jaWF0ZWQgd2l0aCB0aGUgY3JlZGVudGlhbCwgdGhlbiB0aGUNCmtlcm5lbCBjbGllbnQgd2ls
bCBoYXBwaWx5IHB1bGwgdGhhdCB0cmlnZ2VyIGFuZCB3YXRjaCB0aGUNCk5GUzRFUlJfQ0xJRF9J
TlVTRSBidWxsZXRzIGNvbWUgcmFpbmluZyBkb3duIHVudGlsIHRoYXQgbGVhc2UgZXhwaXJlcy4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
