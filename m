Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049AA562235
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiF3SkX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiF3SkW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 14:40:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE13C70E
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ilon/CdPyBZPcwwBxTGdt4Z5Os2h2Fau/NcIY1cXFe0ZLeAuqpUnT/cSp+yLciOX+LrYf7I3TSJbi6iICIuZI/XZJHGGUxWnNmHFuwO9Y4TCZQl/JmDc/GBDQI6PZl5PMkaomniLGqpLdsOd3W1l+/aCaeHhlLhQx4OXr29gpXPpUFZYbnY6gstispG5upMG7+3IdnFP6JBJ/La70zbahgSH7n87toMwsLnPiLpjaGgqT/1xkzm6HhR68pexLkix2f9a7gL8JE9Y6QB4fuGI6HTiO8JpcTUsJKM17LS5kttr4ZIZcQOa3jJaSESA99pDgGotIX0sftfdJfuhRtr8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/tTJTwVKN3E8xiOxSlo0FbftYNITz0RQ8OuVJrDvCs=;
 b=K49tVt7Nnk7FLT2hjzCdL4BBvmuCQY3w73cxwnxsQHzqg8ggbisJdkdWL+L2dhLXlhz+X3sE81sBoRiMBIJy/Ap/nA3NJfxQKfik6zBv3jhyEGl7iMh73tvXNoqcTRNx77NrZ8rWuo2IQwwj13ece1ztisA+n8yGyRfTTdllsnQLZqagFD/Z4pR7XvTMl1KmoXA3hmvfr5Fn7SAivlPD0+tqr3zwNxSAHHBpNQbgyF1V6i53jqJVS1QEBMz0sl9BGRYewb9quiWnV5OMHfYRQX3KaWLSKnKGdoQ0IYXv4pp+1NuSmEbcXX1n0GGd1gOcaAuRKFQWqIKdXF7/Ukj/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/tTJTwVKN3E8xiOxSlo0FbftYNITz0RQ8OuVJrDvCs=;
 b=Q19hoXHbx8BTNjCHiOGtoa2xRi43wdtTZnzVRiGQDaAz+s7HZ9zLRCWSMdRcos7OCGVl2SRR1V9v5IuGXqsTl7jTUhdFfL9ugce0VQm74pPbI9ReOKaHY78w+R+PP31Rs/Xh0QOPSc93SYQI06rkZ+lnKGZM9Xm9VCESxUZSPe8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL0PR13MB4211.namprd13.prod.outlook.com (2603:10b6:207:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.13; Thu, 30 Jun
 2022 18:40:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:40:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "zlang@redhat.com" <zlang@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Topic: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Index: AQHYjKZ6PsElrHdOF0ieC+6YHQBvjq1oPUcAgAACYACAAAi8AA==
Date:   Thu, 30 Jun 2022 18:40:19 +0000
Message-ID: <0d8d0de92b9f7deeab0fa8ab6a0205b32fc5b301.camel@hammerspace.com>
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
         <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com>
         <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
In-Reply-To: <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b554164b-62e5-4197-7c72-08da5ac7fbf3
x-ms-traffictypediagnostic: BL0PR13MB4211:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Hq2DpqM9VTGC2OTr/machVEsfEztUJfbEFopTJmSphtQIqMHInoMlnk5MiCCZhkDpWwIlFhm5o57zZRnNYlcO64U4iQT8YDePonPNj7slM5wDhg9RJChKSsPGRtolWCVbkrpVccx7sG24ZprKLmKXaTEAw4nD+aTsQTcCKbMRlIt6wIT1TXDcm0v/gMHXnH1ujVyqhd88doPJnDiy7bDBpk1Hso/KnQCeAJSSXVtLR1rPF0H1j4MDsiFvsD6sSAaM+9Aem5tZrACD62mJwZM8UO61RR0QGqAauGR+iBadu9oNwKKewfZKUp/o+lb6oQ/Gh/zuuTnknD/FJiduw2pDO9rLXh2t0SoRihnNss8bQTNvcQ6oR1y+WW1jgEARJpBuLSY41LjLMCb9FIlwbuL80jyw0mmPJSTE1F2E5cVaJtM48GHiloV2NPddiARiMLKwz9QYGvASxCdt8EW2v8JgZkwzY8vBFDYzhbbnIovIpOsttHESR3UVFaDXshFmtSt620szuokuRiNLJwmfN1ieXT6pYeSJ3xp6wo8MiXlIjX4MN6rZDH7bSHhj8i7/stIYZKj6YO73PZ0l637CQBMQwURaFn2IP+GaiWXOgtPziGxIP9y8LzSWroXGsYywNd5Oi7xq3vaqB54wCx3XOgwOKT3Van6+ZW3Fiyc0a/X4MknLO13ivkJxPmekVX6caeoW9Kgo+QxqxjlklewAgRnjMHUZ0vohn+rG0x+f8COUYHmyqeHIzXY5yWUJrPgDSWYWS62DFlhSerOQ5XGVtGYFCm6ck2DnyIM9MGb1HZBuXOi/mC13DbPKBV9pJqIoZmx8dFGd8AvQFjaeAHB/T82WSpO62Wd7Jo90r6jSOz32bQA1hfV+u+7Y39ZDvm9PYh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(39840400004)(376002)(66446008)(41300700001)(66476007)(66556008)(86362001)(2616005)(53546011)(316002)(478600001)(66946007)(64756008)(6486002)(122000001)(966005)(4326008)(26005)(76116006)(38100700002)(8676002)(6512007)(6506007)(38070700005)(71200400001)(54906003)(6916009)(5660300002)(186003)(8936002)(2906002)(83380400001)(36756003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5RcGJ0d0VnNk4vMnhZdmZiNzdnRTMzOGdyVXJKSW9PMldwVWVqeHlEdFRB?=
 =?utf-8?B?cDRkQy85VXVDT3MxeEtXWGNialdyeVQ0emlvSHc2SWRKYnZUaCs1bG5zdU0r?=
 =?utf-8?B?M3pDWFdQa3FzUUhwVml1TEVCeklhS28ydGI0dE8zUVVaOTNhR0h2R2k4WTEx?=
 =?utf-8?B?enJFOWFyeUlZK3dKdzVia2RwWTMwSWVNM2I1UkVhcEVyWlZENlF1RXFqbzBs?=
 =?utf-8?B?T0M1cE5HRDNtRTdISkV6RENESUZsK1BrWXNmbWNuMzhBTkUyemxudEk4RUU5?=
 =?utf-8?B?aDZUWHZQOXh5eUlWVUd3OWlnZ25QQVBwTE1rdnhrSEliN0xrUEI3THRVMXlG?=
 =?utf-8?B?cUtmK1UwN2VYZG9tQ0xIaUhJL0RoTzhOYVBxNENwd0FpWUVNNGFldzNEaXAz?=
 =?utf-8?B?MEZIRnBudUdPRCtxLzZ5ZFIveWt3UEJaTGNwUzlzaXVxM3BCN29Pb29uT2Ew?=
 =?utf-8?B?SW55RUZzUU4wZ0Z5Z1Jkakh6bW1VOU00SUw0UDdDL0FvZVBXNnpQVGVXbTNT?=
 =?utf-8?B?cm9YK0M4aGlsV1VpY2ZtVXBGMUYxYXVUN1VxSXFlVHBpVFN4MndlMGNOZkRx?=
 =?utf-8?B?MW0yQ3NTamVTK3BoNEJZUHMveVNCZTlnQ3BKdGhJRXJKV1ZpS2diSjhpdjlu?=
 =?utf-8?B?S0dSNHJUR2cwM1lLOE1WQXQ2K1kzUmZYcWF0WGNXa3NTODFRWTFYQVI2WFlD?=
 =?utf-8?B?VzJTSWZMMjVBZExkbVJUZDVXV1NjOXdtMStGSXV2MGM4aWtRNXRPd1dGRGFV?=
 =?utf-8?B?dFV1MmdCdmtsajEwQVhyRnNFSGJNRnl5d0VHU2VnY3drdkpSalA5emdoeW04?=
 =?utf-8?B?M3Q4T1liOWJoV3BtVGg1cnVpUVJIY00xY1BSbWdBR243bWhXZm82dU4ydlhU?=
 =?utf-8?B?N1BDamN3azNFdk5wMXhOSkJjR0FkOFNEdEpKV0JVWDBUakJxakNPQUFNUmxE?=
 =?utf-8?B?aHU5YVNqekE0eDc1NzdlbnJpRHVCZUpiWjd0SVRaOFV5UG85VU40NDlubFBD?=
 =?utf-8?B?OENqVmtvZUh3WjVmdVZMaUlrUjhHWjlRR1dkUi9QbTQ5YWk2VUdxMGxpSkhW?=
 =?utf-8?B?RjA0NlVVZzhjamthWHNFL2hFVTZGQzl5K2VmcGtYRHZlc3hnQklhaDcybzI4?=
 =?utf-8?B?Sko4YllrN1BXbHlKWmxweEZLZ3VxYzlEZjkzZTk0NGtqNlc1aUNvY0VWWExN?=
 =?utf-8?B?MUlvRzRQRDdwWUZHUlB1a0ZiVzNIempCNDdVTlRwckx0UVFRakVCMDI0clkr?=
 =?utf-8?B?RU1EVGxDa29yQ0NvdHdQV2tlWFRZWHhYYU5GNjdreitGVnl0V3dQMXpqSHZw?=
 =?utf-8?B?WlUvckFrc1d6OW9JVWpPTERSemJJenRZMlFuNy9ac1psbC9rQzJNbVNNcWtZ?=
 =?utf-8?B?MmFMQ0lwSVRBTkRZZWhsOHQ2aFJVQ05HdU84ZFF1TXR6azE0d2tpQUYwbE94?=
 =?utf-8?B?M3dxZTFmcGxmeU1QZk5UcHBRUGtmNW9wNlZDa2NTa1FvWi9oVlhoaVJDd2Rr?=
 =?utf-8?B?NytzTkI4Y3J6dmVwS0hRVnZ2WVFFS2Q4dFRWNEF3ZUNqRmhLQ282a2haU1pm?=
 =?utf-8?B?bUMrdVVuYnR2U0ZFZ2IwZFVRS09nczRkSUpGR09sOHdDV0kxdVJQVWhHTHYw?=
 =?utf-8?B?NUN1bDZha1k2elZNQ1hrOWtvc09PV0ZRNGF3V3doSUdDVnJiSjZUVDJUSDkv?=
 =?utf-8?B?MkV0VGp0Z2p6a2R5WHF0ay9Ib0VWaFRyeXVsUVNoY3ZCU2h6ZlV1MFdzQmRB?=
 =?utf-8?B?d1Z4YUZycWhBV1FPUkRTdGRjUDRlajA3TVduY012NmtFY1hIYXVvenBKWW9v?=
 =?utf-8?B?NEZlNEV6Z1FlYmdwYTBPaTZzd3d0d2ltcGZMLyswZ1Z3SmVIMldpYjlUNjNN?=
 =?utf-8?B?emVpVnloaENNZytMRjdFWS9JZm9NYTYvdndtVU5jNzN1NHJCVWZOVFlOTnFi?=
 =?utf-8?B?Qm90TXZvYWtxdDBmVXNSdDFuQ3hqVzFDbWt2YThwbFA0Q2VMMC9QQWRqU1dW?=
 =?utf-8?B?WmRsMFRpOG44NEdqNXQwNVNTSnJoa0w3M0drazFaSnFQVnN5aUVhcThkS3pq?=
 =?utf-8?B?YXNYZDU2QkRRYXdkRWlzQ1JWN05wcGRUU25wY1YwVmhSS2pNai9sV2RHRHF5?=
 =?utf-8?B?SG96Zisya1RtK3p6aWEwdm4rZ2JMWE9KVVFrZ3lRSlRjS2pkR2dDL2Vmd3U3?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63F5FCBDD117D4C9C03BAC717AA79B1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b554164b-62e5-4197-7c72-08da5ac7fbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:40:19.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGUmpXtTZlwpDk4D4s1S3XOPxFAUj5tIIXdGDhIE4FOsE8oAeuE8KO6NjAJLaI/OELgkSj3Y/kgbX/YhXLpQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTMwIGF0IDE0OjA5IC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToN
Cj4gT24gVGh1LCBKdW4gMzAsIDIwMjIgYXQgMjowMyBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjItMDYt
MzAgYXQgMTM6MjQgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gTG9va3MgbGlrZSB0
aGVyZSBhcmUgc3RpbGwgY2FzZXMgd2hlbiAic3BhY2VfbGVmdCAtIGZyYWcxYnl0ZXMiDQo+ID4g
PiBjYW4NCj4gPiA+IGxlZ2l0aW1hdGVseSBleGNlZWQgUEFHRV9TSVpFLiBFbnN1cmUgdGhhdCB4
ZHItPmVuZCBhbHdheXMNCj4gPiA+IHJlbWFpbnMNCj4gPiA+IHdpdGhpbiB0aGUgY3VycmVudCBl
bmNvZGUgYnVmZmVyLg0KPiA+ID4gDQo+ID4gPiBSZXBvcnRlZC1ieTogQnJ1Y2UgRmllbGRzIDxi
ZmllbGRzQGZpZWxkc2VzLm9yZz4NCj4gPiA+IFJlcG9ydGVkLWJ5OiBab3JybyBMYW5nIDx6bGFu
Z0ByZWRoYXQuY29tPg0KPiA+ID4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMTYxNTENCj4gPiA+IEZpeGVzOiA2YzI1NGJmM2I2MzcgKCJTVU5SUEM6
IEZpeCB0aGUgY2FsY3VsYXRpb24gb2YgeGRyLT5lbmQgaW4NCj4gPiA+IHhkcl9nZXRfbmV4dF9l
bmNvZGVfYnVmZmVyKCkiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgbmV0L3N1bnJwYy94ZHIuYyB8
wqDCoMKgIDIgKy0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IEhpLQ0KPiA+ID4gDQo+ID4gPiBJIGhhZCBhIGZldyBt
aW51dGVzIHllc3RlcmRheSBhZnRlcm5vb24gdG8gbG9vayBpbnRvIHRoaXMgb25lLg0KPiA+ID4g
VGhlDQo+ID4gPiBmb2xsb3dpbmcgb25lLWxpbmVyIHNlZW1zIHRvIGFkZHJlc3MgdGhlIGlzc3Vl
IGFuZCBwYXNzZXMgbXkNCj4gPiA+IHNtb2tlDQo+ID4gPiB0ZXN0cyB3aXRoIE5GU3Y0LjEvVENQ
IGFuZCBORlN2My9SRE1BLiBBbnkgdGhvdWdodHM/DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL25ldC9zdW5ycGMveGRyLmMgYi9uZXQvc3VucnBjL3hkci5jDQo+ID4gPiBpbmRl
eCBmODdhMmQ4ZjIzYTcuLjkxNjY1OWJlMjc3NCAxMDA2NDQNCj4gPiA+IC0tLSBhL25ldC9zdW5y
cGMveGRyLmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMveGRyLmMNCj4gPiA+IEBAIC05ODcsNyAr
OTg3LDcgQEAgc3RhdGljIG5vaW5saW5lIF9fYmUzMg0KPiA+ID4gKnhkcl9nZXRfbmV4dF9lbmNv
ZGVfYnVmZmVyKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBp
ZiAoc3BhY2VfbGVmdCAtIG5ieXRlcyA+PSBQQUdFX1NJWkUpDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgeGRyLT5lbmQgPSBwICsgUEFHRV9TSVpFOw0KPiA+ID4gwqDCoMKg
wqDCoMKgwqAgZWxzZQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGRyLT5l
bmQgPSBwICsgc3BhY2VfbGVmdCAtIGZyYWcxYnl0ZXM7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB4ZHItPmVuZCA9IHAgKyBtaW5fdChpbnQsIHNwYWNlX2xlZnQgLQ0KPiA+
ID4gZnJhZzFieXRlcywNCj4gPiA+IFBBR0VfU0laRSk7DQo+ID4gDQo+ID4gU2luY2Ugd2Uga25v
dyB0aGF0IGZyYWcxYnl0ZXMgPD0gbmJ5dGVzICh0aGF0IGlzIGRldGVybWluZWQgaW4NCj4gPiB4
ZHJfcmVzZXJ2ZV9zcGFjZSgpKSwgaXNuJ3QgdGhpcyBlZmZlY3RpdmVseSB0aGUgc2FtZSB0aGlu
ZyBhcw0KPiA+IGNoYW5naW5nDQo+ID4gdGhlIGNvbmRpdGlvbiB0bw0KPiA+IA0KPiA+IMKgwqDC
oMKgwqDCoMKgIGlmIChzcGFjZV9sZWZ0IC0gZnJhZzFieXRlcyA+PSBQQUdFX1NJWkUpDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhkci0+ZW5kID0gcCArIFBBR0VfU0laRTsN
Cj4gPiDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhkci0+ZW5kID0gcCArIHNwYWNlX2xlZnQgLSBmcmFnMWJ5dGVzOw0KPiANCj4gSSBhZGRl
ZCBzb21lIHByaW50aydzIHdpdGhvdXQgdGhpcyBwYXRjaCwgYW5kIEknbSBzZWVpbmcgc3BhY2Vf
bGVmdA0KPiBsYXJnZXIgdGhhbiBQQUdFX1NJWkUgYW5kIGZyYWcxYnl0ZXMgc2V0IHRvIDAgaW4g
dGhhdCBicmFuY2ggcmlnaHQNCj4gYmVmb3JlIHRoZSBjcmFzaC4gU28gdGhlIG1pbl90KCkgd2ls
bCBjaG9vc2UgdGhlIFBBR0VfU0laRSBvcHRpb24NCj4gc29tZXRpbWVzLg0KPiANCg0KU3VyZS4g
TXkgcG9pbnQgaXMgdGhhdCBpdCBtYWtlcyB0aGUgdGVzdCBmb3Igc3BhY2VfbGVmdCAtIG5ieXRl
cw0KcmVkdW5kYW50IChhbmQgY29uZnVzaW5nKS4NCg0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
