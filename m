Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873C4C3CE2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 05:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiBYEHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 23:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBYEHt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 23:07:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD319148651
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 20:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STOIHFjJIP8YJQP47S11+roRNWqe2iGGoRWw5iMdvF9W9J11rMOJ6QY9+UZ1UNOhmTYYOgVw/SlBUZXJ5zl23R2sJ3tze5xObycnczPesXRAKG7jl/yaXCHIy8FbcyLElz6oWkNBsU8lulRSS3ogSHwWbabJWRDCTJeT4S7YiG/FzYH0EByU+gZNUqlr4ZiOKdZuRRTqD9rbY2TA2WxhGUt6QUFyPid99jRfmjW139Q3VBNXQt195NF3hFobyfVik98UCM5Vrev+hbxtQabygJTyEdKdoXuBuUx7cqSwYRfMv1xBrO32LzRzjmOVJSAi9IqXWHyF6CZTKhM7ofgcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hx7KHH0mxxdWjI0rteZOXlEAJXTksSM0a7/+DJOV3I=;
 b=KW/5UxcceqK8Xqrj5EzduO1wbw2m9VaZ+3sw8298Zp1WIb3mt36J70pJShLDNlVOFqrqEHJ23kCSFV3BQzptIptGZjGLb+ti38BpxkyBkdWWb1YUP/TLs48CMNXi8QxdxzGov9qFhVcmeXZ+e+vjw3X86EQKWzAh4Z0uIH3R3vqq2of/bSJhlJ7O1o2BDxEVDGc0WOOXYMZ9CNtFYnlphBzH85hnWqZVFZl59n+e4HPxSFbUkGKb909vibmTooaiK7nvtytJfWOQLTZMph2ezvOX6yU1UuoeZPv90Xpj1h2jHEdng0tywZLKr0zGgKTJ3v8bTNmajM7vMm0iR7PJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hx7KHH0mxxdWjI0rteZOXlEAJXTksSM0a7/+DJOV3I=;
 b=AbdaKFDK9xUM6KwDtrMJIkpvmJGFG+2u/hTzxxQ+U9IwXnZltXz2AwxGW23J5sFBPIwqsGIVs50ITpqE5tSWkaYanKduIQ6MVYe2j9twTdmZ7UwoXzs7S1nfCLo/8FtKP8tWFkXhQt6MxFoPbeH6GDoflqbCpzwkcSGJDp+qkNc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4985.namprd13.prod.outlook.com (2603:10b6:510:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 04:07:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 04:07:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 10/21] NFS: Reduce use of uncached readdir
Thread-Topic: [PATCH v7 10/21] NFS: Reduce use of uncached readdir
Thread-Index: AQHYKPthyXO1hLyo2ki1W0iJBCo6m6yi7MOAgAC7noA=
Date:   Fri, 25 Feb 2022 04:07:16 +0000
Message-ID: <189fe459d0ab3ed851790c2cdd86a9c71d3bedee.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <20220223211305.296816-7-trondmy@kernel.org>
         <20220223211305.296816-8-trondmy@kernel.org>
         <20220223211305.296816-9-trondmy@kernel.org>
         <20220223211305.296816-10-trondmy@kernel.org>
         <20220223211305.296816-11-trondmy@kernel.org>
         <CAFX2JfmLvuh2KROa_tP=_RBXbUg68E--JHutgh1xKPV9en5sfg@mail.gmail.com>
In-Reply-To: <CAFX2JfmLvuh2KROa_tP=_RBXbUg68E--JHutgh1xKPV9en5sfg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b7cd2cf-492c-4813-2091-08d9f8144f55
x-ms-traffictypediagnostic: PH0PR13MB4985:EE_
x-microsoft-antispam-prvs: <PH0PR13MB49856AB737292B72E3374B0FB83E9@PH0PR13MB4985.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /t6quCuLWuqM+K/YZUyIMcfHgLxnpgXho/xJs9Pj8SiSoLVj5VzARas7BYTOC+9yV0wBvabdhko32ytpo+6pBS6B4bn78boodqUvg4LiyXq0IAgqdwgIj9PiJAVL8biAgLJGr6JAaPPkHMbMILzeJ3va1/6aa/ga0p4iCb4awUT+ucDjPxLw2KHiYupRoqY/w5xvWgIj+awQpdiLygV9v54KNkfVewtu4TYfJkQMN1uHE/VnilFUO5EFLuSHX69Bwwk2OJLye50HPWmZ/V6IrhxQoBG/wpzVVrFFemEt1DwqyNTXsvRBFw5jMYuxuor35YvaGENOlM9EATEQGVsR/bQPSWG2pTinIsw5YD872SmfRxQfyO4tS8DlJF0wGqHSAHc68dfxAajhIfnKbr9/PJxb3av0t7uMJIOxxgaqyh7pPBRac3yYqGUBvOuQ8AxZDKNqrUCHI72xUjFn2sZ2CZDsZY20X54afjgGDYZ6uDqp3ccwi1z72uJmD1DCbFHyW9aaLCK/eTVVdKCydkvCPqNmY3l9Lts1sklcHx2UytCXZxZ+V6V25kLxRZ21+vCgVaNYD2xveSlRvqnuREpXQSzVggNFpuntw+mg3V4fhvFUUd784nNA2Wuph7jH8Mjhj/F9OOJ9b2zX0HyPvxGH2/DK5miQ3XvYgBs8XSFgqLntRvQkxm3+VEotppLFrAgOfRI3m90+8WcE7VVEHUMwgqD+x/47zfdmcrLQrrdNTnW6E7Yts1lh6g6QSVAuh6L6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(376002)(39830400003)(346002)(366004)(64756008)(122000001)(6506007)(66446008)(53546011)(66476007)(66946007)(6512007)(26005)(186003)(316002)(76116006)(38100700002)(5660300002)(110136005)(38070700005)(83380400001)(66556008)(36756003)(508600001)(71200400001)(8936002)(6486002)(2906002)(2616005)(4326008)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlhnNGt2UUFkaW9vTFF4R2RhRG52aDIvWnlGYkpBby8yTlVmUTBJcXVta0Y1?=
 =?utf-8?B?TkFDQm9XU0tWdkNlaVA5eC96RzZmOTg0bUNYZzYzWjQzaUw1OXB4UFNBRnhF?=
 =?utf-8?B?U21ZSFZ3dlI3b1RmQkRCMjR3VGNSNmFxeWNNTHcyZjIvNmFPZk5xekFSWkZQ?=
 =?utf-8?B?ZGZpamw5SnQvbFl6TUlaUlE1cGFZbjlGNmVXNWxIVnRvV3BEbXFrd3lRcXdx?=
 =?utf-8?B?RWc1cGZPdGNxb1RrVVBXaUlzOThNUGduOGhuM1V6S1Uya29VYUZSK3ArMzJm?=
 =?utf-8?B?TjJ5OHFwUDI3b3pnbW1Yd1JkZDN4ZEh2bjdUYVNoZFl6NExJaDYweU5yT2tL?=
 =?utf-8?B?QjZmdkQ2bmsyNndxK1lpd0pvcHRqVkxXcUQ1dXRmS3I3WHUya2RaUm1TTnVB?=
 =?utf-8?B?dGlEWGpQTGJOeTlmendZQnBqVEVHVjhCOXJ0NlRFRGFERHFQS1duelZLSDlS?=
 =?utf-8?B?UUhQbVFyZWoyd0xick4xOTBxaWlsYXpNdDhEbnh2ZDZGdUJHZnJZNldrTjVJ?=
 =?utf-8?B?WlFzaVZjV1RSNDFyd0dNbjlxM09IRFo3YlR3T1JwVXZLOFByYWZ5VDNMdS9T?=
 =?utf-8?B?NUx3N3c2Ukl0VGdROXpMbjhFSDltTzViZXB4em1TbTZsMlhaVFpKWmo3cmx0?=
 =?utf-8?B?RTdJSUtoV29MK05hNVlLSkY0Y2pxcUhkLzdKakJPZTNoQjA0bkxrekxKZTIr?=
 =?utf-8?B?TVlvaWRHZWRpS3oyeEZEcFIySFlPMTdXbVAzZ3FLN3krWlI4VzRUdis5SjdJ?=
 =?utf-8?B?dXo1cVVuVEUyZ0dNM3orcFRDaElhMWZtSS9Cb0lsU3lEcTBNYStiMWl4N2Mx?=
 =?utf-8?B?bHBpSngyQ290OW9LNkZMOEdaWUZmU1pqZ0hwYW45ZXpRaDF4QjVIWXJtNTdW?=
 =?utf-8?B?VHBFbDhRWDhvanVLcFN4STdHYlB4aXdxcklWT1V4RnZMVUpYTTdiM2d5RHZn?=
 =?utf-8?B?cFgvU25obEZrNy85QW5VRzlYd1p5TmVUSG1SSnJSMWMvR1ROdjZmNis1c2Jp?=
 =?utf-8?B?SnZrdHdqQzlQT09wdldxRk56aDFFcG1UakJtc0JUdzhlNkJHakQzREEzeVVI?=
 =?utf-8?B?Q1ZRMjJGVUwxUmhOVnBWNUZZVnlYWC96cTNTNXc4WHFHY0dlN1JrMDdkVnBy?=
 =?utf-8?B?cnN6S2RJU29tUVNSMVFxVG5oQVVHcnYxU09jbnlkcSs4KzNqTUxLYngwY3Fv?=
 =?utf-8?B?b2daT2pDQkZicjlKV244bFRrVURXSXgxa1kxNjltdlVXbFlKT1RzOG9Sa3hR?=
 =?utf-8?B?bFlCN1lzWXNTRFFlM2R0K1FRQTBWc2l3SEZOOCtoVHNCZ3ZFT2hzZ1lKakhE?=
 =?utf-8?B?WFVVLzBDS0VkREN4WnNhZEdvN3JxQmRiSjh4MllXSWN0dlFGS1V1YWJsOUho?=
 =?utf-8?B?MFlnc3M1ODdveG5FcE1kQlN1eDdZbnhHeHI5bitkZU45THNVbnZWUkdhRkRQ?=
 =?utf-8?B?b3FFbmlNMWxPanZlcFMwMkhaeDZBcGd2SWlPRFBDaFRKK1hIdDhtdW85dlla?=
 =?utf-8?B?V2RnZXBNa3lkVmJ3bS84dko0c096SFlQSGE0bGZTY2VlN3Bmd0k1aVo3VmtD?=
 =?utf-8?B?MkIwUFZTUk1lZjlQeTJrLzJnSFk4TVFRRXloK1k5eHFZaGc1aXRBa2JQbXhy?=
 =?utf-8?B?NmpOMjF2UnM0QlZ1MldlZmFKUU5KU25uMS9IZFlPdmRBZVVKazJpaGZ0OFZT?=
 =?utf-8?B?TlI2UG81cnJtWEkrMEdXN0F4eWxULzVhc05iZzg2T0lFbllic1lLQ2FicUZq?=
 =?utf-8?B?VTkzaTlJNklQYnhRWWoybXQxWVBwTmdiYVZnb21FcFpUd0U4aUJUR000Qk1h?=
 =?utf-8?B?ak9IeEErbXhFbWliVHpDZWlHZDZVQzZKRk15NDBWbUZvRVQwK25IQkExeVg2?=
 =?utf-8?B?VzJFOENFMnJGcm5JVU5UcXMwT3pia1V4YmdHdFY1b3d0dWFPZitjNzZQNzhI?=
 =?utf-8?B?SS9jV1VNdENPdTMwdDJBSzBTYW1uN29teUlxSEszUVNkbE15MTN3TmFIdVhJ?=
 =?utf-8?B?S3NJK296V1hQK1QzYUZjU0VCeG5JZDdEcG9iVzVOL3VLVXFUMTJyS0YzOEN4?=
 =?utf-8?B?QUpJb3V3VUR4c2IyYSt1QkplYnFHSXF5TjR0VWV4WWcyYVlUbXlZbGJMZmpz?=
 =?utf-8?B?NWJXVlZiYmswOXZiZjhLRjc3cGR3ZWdFSFk3WlZkVzROYXBtVC9Wd08zRnU1?=
 =?utf-8?Q?+opZkf8hJZ1ERgPHc0o74kA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90080495A799EB4BA0E0422AA206C68D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7cd2cf-492c-4813-2091-08d9f8144f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 04:07:16.2711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyhIa8eObgYgCKLERGW8I2q0LKqBjbJ+eCaotKEyFLF/yD8V+lG1Se6qu0lwgNxGFOAeulLqTY6U8P8O85MEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDExOjU1IC0wNTAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToN
Cj4gSGkgVHJvbmQsDQo+IA0KPiBPbiBXZWQsIEZlYiAyMywgMjAyMiBhdCA4OjI1IFBNIDx0cm9u
ZG15QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBXaGVuIHJlYWRpbmcg
YSB2ZXJ5IGxhcmdlIGRpcmVjdG9yeSwgd2Ugd2FudCB0byB0cnkgdG8ga2VlcCB0aGUNCj4gPiBw
YWdlDQo+ID4gY2FjaGUgdXAgdG8gZGF0ZSBpZiBkb2luZyBzbyBpcyBpbmV4cGVuc2l2ZS4gV2l0
aCB0aGUgY2hhbmdlIHRvDQo+ID4gYWxsb3cNCj4gPiByZWFkZGlyIHRvIGNvbnRpbnVlIHJlYWRp
bmcgZXZlbiB3aGVuIHRoZSBjYWNoZSBpcyBpbmNvbXBsZXRlLCB3ZQ0KPiA+IG5vDQo+ID4gbG9u
Z2VyIG5lZWQgdG8gZmFsbCBiYWNrIHRvIHVuY2FjaGVkIHJlYWRkaXIgaW4gb3JkZXIgdG8gc2Nh
bGUgdG8NCj4gPiBsYXJnZQ0KPiA+IGRpcmVjdG9yaWVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4g
DQo+IEFzIG9mIHRoaXMgcGF0Y2gsIGN0aG9uIHRlc3RzIGFyZSBwYXNzaW5nIGFnYWluLg0KPiAN
Cg0KSSdtIGdvaW5nIHRvIHB1c2ggb3V0IGEgdjggcGF0Y2hzZXQuIEknbSBqdXN0IHdhaXRpbmcg
Zm9yIGEgZmV3IG1vcmUNCmNvbW1lbnRzLCBldGMuDQoNCkFueWhvdywgSSB3b25kZXIgaWYgdGhl
IGZhY3QgdGhhdCB3ZSdyZSBub3QgaW5pdGlhbGlzaW5nIHRoZSB2ZXJpZmllcg0KaW4gbmZzX29w
ZW5kaXIoKSBpcyBwYXJ0IG9mIHRoZSBwcm9ibGVtIGhlcmUuIEkndmUgYWRkZWQgYSBwYXRjaCB0
byBkbw0KdGhpcy4NCg0KSSBhbHNvIGZvdW5kIGFuIGlzc3VlIHdpdGggdGhlIG5mczIvbmZzM19k
ZWNvZGVfZGlyZW50KCkgcmV0dXJuIHZhbHVlcw0KKGFuZCBoYXZlIGEgZml4IGZvciB0aGF0KSwg
aG93ZXZlciBJJ20gYXNzdW1pbmcgdGhhdCBpcyBub3QgdGhlIHByb2JsZW0NCnlvdSdyZSBzZWVp
bmcsIHNpbmNlIHlvdSB3ZXJlIHJlcG9ydGluZyBpc3N1ZXMgd2l0aCBORlN2NCwgd2hpY2ggaXMN
CnVuYWZmZWN0ZWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
