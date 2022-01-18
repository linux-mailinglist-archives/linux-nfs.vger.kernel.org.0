Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C27492EA2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiARToP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 14:44:15 -0500
Received: from mail-bn8nam11on2092.outbound.protection.outlook.com ([40.107.236.92]:65124
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348915AbiARTnu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 Jan 2022 14:43:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg+YiWfklHC6uqc9o3KgO17V3VFyuxqYVrIpa/HaDG7PFPxNbpp2MitxvTG+k2VPYYBsctTNjXHaJAkTRCaaQ7vKDJagPdD10oe/4wyInaGWTxzKWBUTCqvy9w8cQfO63wUQbny0/3P9M09kOLAhSrdUKX7ZG2YwBnlfxfxYOtrhIIQVos/CqBa2biB94eeJQgy3ChGE2sADqwaNYyEjVUnsvD1bSFcViW7RMA4keGH8waMw+dBVTeee0MuCqGLYYTO9tfLTZt0uZkUG/74AcEaPr6YFC8PrUcL/OC8TpGNbr1FdtwZ5sxjgg82OOuguBhT/Q31Vy1sIzwmcOeJX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H05YnFvsZiJS70FFck+M+IhhfuL3RAsjJsqByT13S6g=;
 b=e95UrBcDa8j5hNeJ/2jkbm40mTxdJK+Gwqb28Z6arhRk0C7rnb35T9WwHVqcl1rOc7JKqI3zbfKEMrYegNi3rtdrL+1nuJ9xGgLHTosR8YBXT7XOlfguDyS0jLvy6JOxYHFwbz5C/cgz2nOfnw1DPIgiUFra66dJt9WnsxDOKY0WfFQeAqElQu7Sid1zGObC0S0BYyCQ+Vy0ubGWaSMYNv1N4tJjJsn5XIDUj8UrtZ2oeWBUDGaA2bbfEHkierwcWaPYJoMTWvWGvGlHA/+YRrJybiS1tvu5aOtECvAXo5TTWQnY6JDeWJZxRVPyGAvJhg1DllLdq9TbVRU8OgbEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H05YnFvsZiJS70FFck+M+IhhfuL3RAsjJsqByT13S6g=;
 b=LvkyFyi3PPVBDxl6TAjRu4KwWhJVeHv8S/WaU6Ks+JryBlRJoYUU+VmYUKoeJ8IelZ4D26rF1qI0Udvp8DohyLMW7TR45omwqNnq87Z7j3Yk+TSJfmGzeFbQ5QCyYK8XLf4tzg5zLITIxOKWNOXRBCbdpdFyx+FvwN6SFtWxRpo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3279.namprd13.prod.outlook.com (2603:10b6:208:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 19:43:44 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 19:43:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH] NFS: fix an infinite request retry in an off-by-one last
 page read
Thread-Topic: [PATCH] NFS: fix an infinite request retry in an off-by-one last
 page read
Thread-Index: AQHYDKJX+2ieMMLfykKxZVwO0cZPD6xpLiAA
Date:   Tue, 18 Jan 2022 19:43:44 +0000
Message-ID: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
References: <20220118192627.tg4myc77nmbqm2np@gmail.com>
         <20220118193341.2684379-1-dan.aloni@vastdata.com>
In-Reply-To: <20220118193341.2684379-1-dan.aloni@vastdata.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb1cf532-312b-47c6-c764-08d9dabad67b
x-ms-traffictypediagnostic: MN2PR13MB3279:EE_
x-microsoft-antispam-prvs: <MN2PR13MB3279F5AA6A10D7D184F6DA8BB8589@MN2PR13MB3279.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3s5c0v+fj9K3wnaX2s9TUvknYaLufcUd5zhNizqRsldJFrStnjywTB3CpciW3kHRBoPXYRxP/Zcu1m8zHhay7/VfmkcAGWaNZM8FSwE1P0RRmp0Jwtnhz5neRCN5JN+CHtsV2vNYXMYcPzK/Z26o2K2DCUMoSzsQy4PAuG9MnIAh8GC1vqGfGq+XLUZ33HyqoHPZb5Gdy0cMr8mbwZbFZh/R77jNZ5w6E2gbJLCqgQi1Mayl/l1/pEk/svUtcJLWBctuyKBdPR7oruAHQmHNZKNyHtI0TZRnzz5m1QuiWNWFv1SHdi9AkqLl3Jjq4JlM7nC94pFNeMzxGA1zRhd+nPyL1p7pTS8p0btvOKO9jiMBH1s4hbRLjUxh8TXzlFjtVeyKmXPLQWUSlLT1Gu1CXwob5TMCB1k10NfSs9smrY2O6ub/mdm1GZ2BuhQK4B7sdi4VhOX6yVZO/vcXFzoXno8tEdiJ5S003hUDXqO0gl8JoTtYSzrh5lTZwSPJgVPfZWZ8qqQUAl+2Jlm057gvUhUz0QKKVN6XxHmMClvNOI+WSgKqp2A7h7dRqX0kMg63xibhXSbvm27hVlxoQDa0ug1h38DN3hGT8FEEahy9Vttfd4Cprx4Zyyd2azGvbsC71w22NDvmpKSuTPuu6C5j1Y6qIVlW69GicV2WCqxTajbzCN4l3+h8D4g9uIvIuGFVIE0iPjFaWEU6A5UanM2xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(376002)(396003)(39840400004)(366004)(346002)(8676002)(8936002)(122000001)(4326008)(316002)(54906003)(66946007)(83380400001)(76116006)(110136005)(64756008)(36756003)(66446008)(66556008)(66476007)(38100700002)(86362001)(5660300002)(508600001)(38070700005)(4744005)(2616005)(186003)(26005)(71200400001)(6512007)(2906002)(6486002)(6506007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rms4NDJlUURIaE5PdTNDT2h3eWdBQ3Zic2pBWWpGOE53OUtEYnl3VjJMWjB5?=
 =?utf-8?B?bUU1VGJEUEg3Y0V0VjV0a0YyVUZTQ0VSTnVEY2pEVHdYMnIvdGxKamEzNU5r?=
 =?utf-8?B?ckorTmRSNmpJTXdhYTUxZEVjWmEydlBPYldqL05pMlR0WGs0a0pJdUZRNUQv?=
 =?utf-8?B?bE9WZjBzZFB1WjV6SUdQc01NWUgxTmltR3l2RGQ0aitMdlYrRnJPSlJwRndI?=
 =?utf-8?B?QkY2WURvcXMzSUl0Y0RaNnU3NTF0NFp3djBnZGtvQVJZaVB3UmFtSkc2cmRD?=
 =?utf-8?B?YzFwUG9PUXNNTU5oa0pkZENOMU51VElzTjI0TEdVYjJUTVFEcXArZ2c4SVlK?=
 =?utf-8?B?UWFHTWZLWk8yQk1sWTNBd3A4cWFYUGV5SzBvWGtsTzZuQUh6aFhVc2o4cDNN?=
 =?utf-8?B?cnFNMVJyUUxtZzI5OStYN1MvQ1RVb005cit4ayswZVl1U2tKWGJOOW13V0Vr?=
 =?utf-8?B?NjhER2dhZzRTdVRzNUdJd1QxNU94UkdnY2YzcHNZYlN5ZzBPV0dNeTErMnUx?=
 =?utf-8?B?OEQ0YW91Qzg5akRFSlpDcldCOTdybWFQRCtiT1NjYXlDUkNnVEh4NTFMZ1l1?=
 =?utf-8?B?L2Z4a2tCS0RoR3RkMmY3eloram5Ra0VlZFBhdmQwZTVMUk1hWTBwUXVJa3hU?=
 =?utf-8?B?ZElwNlZpajJvZ2RhNEZtbFBXTjEzbFR1K0RTK0MrYkdoaytmZERrbDJObURE?=
 =?utf-8?B?L0h1QVE4Y2RNYkdpd0xUbWZUTmhWQU5DZUtkRUFOQXRWUitLU2x0dGxkdG9h?=
 =?utf-8?B?aXdhNi85RXY0eHR4eTRsUkxhbXNvaW95TVBJeUM5UmJqR21SK2F6bGFiQUxO?=
 =?utf-8?B?VS9LMU0vQzNSMjh0bTZZZ3REL3YvRTN0clVhanFhN29ndWc3SXRSaFU4UnVV?=
 =?utf-8?B?VTJrcE9aQXZ4ZVZwMk52Y0RPZlNyNFlhM0ZoQ2IyNFpOczVMaVIwQUxhcy9O?=
 =?utf-8?B?V2Zwak1FYXpJL25RRWFrTG1QSE1jYkdtbEk2M05CNnJrZjUzalRRcFUxOUVW?=
 =?utf-8?B?VnF5V0x1SUR0YVQzVmFmYVdhdWhYWFRmRzFoSlJvbGNPMUNMbGVOVG92cDRO?=
 =?utf-8?B?bC9TRG02Sit0QlR4dU9BOEw0REN6VlJOYVVXVEppVEp5RHErSFZaaldVYUd6?=
 =?utf-8?B?a3o2bzUvSWpnQ0Fyamo0UU5TaDcyWTQrTnBxam0xcHNUZFlHWWpVd3EvZm5w?=
 =?utf-8?B?UTYxRHFOUGxtVjdVK0o2cFBFWXlpTUpodmNyZlhJRHE2V1JVVkhPUm5QdHRT?=
 =?utf-8?B?TXRNanM3UHZmM3lwdm5KMDJMcXJKMXBpcWFEZGlDY0QyQUxabFZndm12R0hW?=
 =?utf-8?B?Qk9vRXN0UTcxdXVFNWg1Rlhub3BnUU5PbmpnSUk1NmZRaDZ2aVFRMHRiQnlI?=
 =?utf-8?B?OEVSb3NFV2UrSlVOeVEvQnlIV3F6UWwraSszWXZwS2FjTXNHdVFMa1dhWWxJ?=
 =?utf-8?B?SDJVWUR3RmMrVUMwdFJKVXFJVUZRK3AvNy9OUEVCajZvYTd0S0tML3NIVWNo?=
 =?utf-8?B?UHZRVVJpZS9uOEtrOGlkZVpUZTNzWWhYSjVCSldncDlQOHBzZjJtQ2dnd25Q?=
 =?utf-8?B?WjQ4K1hxRGJKY0V2dDdDOEtCNlBLR1VOR1N6NElxaFZnM2loS1lIdWhWa2ZH?=
 =?utf-8?B?WnFQLzJsUGhXVXJEOFppQ1FNVW5oTFhIczJsd21oVHQva2hSUjdnLzdnbTRS?=
 =?utf-8?B?aUZYNll5NEdiL2pOZ3lrRDgxQ05lSFl6NXhSd00veVVhcHQ2cld2czN4ZThO?=
 =?utf-8?B?eXpxQW9ReS9wZUY1TVZobnZBN0E4bGNZVHg5Vm8yVGJ4NUVWRXpMS1hCZ1V0?=
 =?utf-8?B?QllDanpqdzhnalgzUTdxYTVKK25rRE01d0FycXZHR096aFJrajRJbTdhM0o2?=
 =?utf-8?B?TzRkMVJMdFhPVVo1WEhoMm92SUU4ckV4QVdYbHVBeGpMcTY2RmR4MERvMmpN?=
 =?utf-8?B?aG9wZFRuZWZka0FoQWd2Sk8wVXpEZUdFOU1hU0ZmQXRXQVdxSysvU2cxKzQ0?=
 =?utf-8?B?bUhNUmhNZGJ0djRkWWdaOFlwM013bnpndmFXUWwxdjlWOS8vZnZ0ckpZejVa?=
 =?utf-8?B?N3YxQnhZS0F5b1JZckM2dlhxcmQ3OTBFMGdEMkJCQkVRRVFpWWFiZWtkZHBU?=
 =?utf-8?B?a1dqNjhHOGlPNmxhRzBLSmxNcDVVWGt2YmsvMWdSSFhyeHVWb3hsVllxZ1Jj?=
 =?utf-8?Q?Nb5pQXeinzujcFc0YMn5TkY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A4A00AFBD2CAE4E9A63929B2D7B1D0B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1cf532-312b-47c6-c764-08d9dabad67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 19:43:44.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J82UeiEhhX8x56dPdJ79M//4F+IQIbqwTWmO3DH0X8Wl36I00JPqWkR+mi5DzMIy9Lrugg9jNV5rMqNc5lKY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3279
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDIxOjMzICswMjAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IER1
ZSB0byBjaGFuZ2UgOGNmYjkwMTUyODBkICgiTkZTOiBBbHdheXMgcHJvdmlkZSBhbGlnbmVkIGJ1
ZmZlcnMgdG8NCj4gdGhlDQo+IFJQQyByZWFkIGxheWVycyIpLCBhIHJlYWQgb2YgMHhmZmYgaXMg
YWxpZ25lZCB1cCB0byBzZXJ2ZXIgcnNpemUgb2YNCj4gMHgxMDAwLg0KPiANCj4gQXMgYSByZXN1
bHQsIGluIGEgdGVzdCB3aGVyZSB0aGUgc2VydmVyIGhhcyBhIGZpbGUgb2Ygc2l6ZQ0KPiAweDdm
ZmZmZmZmZmZmZmZmZmYsIGFuZCB0aGUgY2xpZW50IHRyaWVzIHRvIHJlYWQgZnJvbSB0aGUgb2Zm
c2V0DQo+IDB4N2ZmZmZmZmZmZmZmZjAwMCwgdGhlIHJlYWQgY2F1c2VzIGxvZmZfdCBvdmVyZmxv
dyBpbiB0aGUgc2VydmVyIGFuZA0KPiBpdA0KPiByZXR1cm5zIGFuIE5GUyBjb2RlIG9mIEVJTlZB
TCB0byB0aGUgY2xpZW50LiBUaGUgY2xpZW50IGFzIGEgcmVzdWx0DQo+IGluZGVmaW5pdGVseSBy
ZXRyaWVzIHRoZSByZXF1ZXN0Lg0KPiANCj4gVGhpcyBmaXhlcyB0aGUgaXNzdWUgYnkgY2FuY2Vs
bGluZyB0aGUgYWxpZ25tZW50IGZvciB0aGF0IGNhc2UuDQo+IA0KDQoNCk5BQ0suIFRoaXMgd291
bGQgYmUgYSBzZXJ2ZXIgYnVnLCBub3QgYSBjbGllbnQgYnVnLiBUaGUgTkZTIHByb3RvY29sDQpo
YXMgbm8gbm90aW9uIG9mIHNpZ25lZCBvZmZzZXRzLCBhbmQgZG9lc24ndCB1c2UgbG9mZl90Lg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
