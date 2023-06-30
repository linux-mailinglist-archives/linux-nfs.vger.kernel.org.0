Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E97443C8
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjF3VM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3VM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 17:12:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799701BC2
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 14:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSyW/uFFfeohg275enypIhQHQM9w2uhBFCYQ01Gu0d7AL5DpIdsWeVdMR2h/z+EkhuvuuRlrR7OB5WFMWNWIHJm/Eta0MAK8b6mhD9YyrjXQdhe08QCarvfBS6fd4XnNwh0I4C7z28ncFOXj/pNseW54v7K+HnmrzSSvKIe4BTSlKCtBCSNnfHg3hunz5wSVncrXZHsMBDQZD42JewFL4g5bFLw0QuntXwUeKmaAz2SwLlWsjC1LOp72LZ/xqQtk5z0zUigmTOzDZFr1tWZXs+RqII0Cny7RgVMeJcesdPQ084b0oysmAweRL1BPQ/GFd3ul9F7+/dRPTdbEqIjeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfhOi9FJqr8UDBLhPnsAkYsjLs8Z0/CgojJOYx+o8TA=;
 b=RT55WN3MfN/uwQy5Rkql6WtanOQg0NByTnScE3O9csAl1KHq98dXZev5dlNoqc36ziG62PQwxJTZLsZwEaZa7um9YBCB6VH5HOG5RQWF8PIhRly6teZDxI4is/zYCwKGNp2hgz6lwIFORFF2fXv2nzsZcAVHU8aP8wmpA9ERY3H6aRc795NcZzdalSMztJs1iivuh09eOe2NFCL3D6sbJweg6UlpmfomZFbQYv9OwRkGqcBiIZpFKA2NY7t9kKpUmGQAFhHROLgd7YsZn/gm6v/QYjNkGrjwk2OEER1+V8PLEvJr9tSrF7lnVof2xU9Dxhax19aezgV//tfTVF34dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfhOi9FJqr8UDBLhPnsAkYsjLs8Z0/CgojJOYx+o8TA=;
 b=agoAAA0XQ2tSNV7b6+/jZBmjkPySiScZD/dcCiC+pgDbFh3uIfap6f67QbeEqheBnvBmKoquqtXpF56JTNiMIJl7VfJQMrRRQ9r67Ryoerz5MMl0lNkvVlNSEYswECyzi9sFOH5oSHCSrnUS9m8hEDnCwIvrMt9Sp7836P+wRkk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4569.namprd13.prod.outlook.com (2603:10b6:610:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 21:12:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%7]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 21:12:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>
Subject: Re: [PATCH v2] NFSv4: Fix dropped lock for racing OPEN and delegation
 return
Thread-Topic: [PATCH v2] NFSv4: Fix dropped lock for racing OPEN and
 delegation return
Thread-Index: AQHZq1VYdXnYvwrUB0eGy4eUhiIP6q+j2G6A
Date:   Fri, 30 Jun 2023 21:12:18 +0000
Message-ID: <9509e1ef426d899389bc3fd9c62e54a40390c105.camel@hammerspace.com>
References: <50f5a8389be39630e9babeb9caba8377773c1cf2.1688131022.git.bcodding@redhat.com>
In-Reply-To: <50f5a8389be39630e9babeb9caba8377773c1cf2.1688131022.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4569:EE_
x-ms-office365-filtering-correlation-id: 0fabe36e-a26d-4734-48ac-08db79aeaff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHUjOSoTlIf6oVHMMPIEePnf+uTo99Dpaa/xlH9pEM6Q0MFiQs6c2t/2jPQmXAFvdHAKjiVd3CKD7CXiGN7VfCzGDn6qBaoIZcTX2otViYa7tUqlxZ4AriDMerM19qn5w1xePGyKcY3xNZRcFAyxqrLpLsWWDLBNf1QvlduXBKgqPxsqcLYTBucIfwkg8KxEc8c9t59AWHMsboSYhKp16uNNjWKPuHvRPhPOqYy610Bb1/RXDX1mDnrEdc0Bs9Y1dav7qYr/0nRJVehI1VawZEjuw6OraAJ0G/KSraLe5Zn+VVzkPHsiBL03GH0UsVh9Unjzr3zd4Rir0IeaPxjcrEBcciI3e+DVpMRpl9v2fL7F66kZk2RoLb4M3EfZwm8kPXMIPOkC58BvA9mvGxm79Jr8F4eOsvikfoFZKBOGIVEf8a7inxuAS8PXXLbKeiyjsFAVBXMZ5RrfkEcWxnyMDTZuOAmqIOQOCtnnTkoyWw+jVMQeud6UkqyJOfPU+Uf/xh2OMhR56LC7vzayTQ6ecBwUUUOGn6V/h1EfMD12Pa7ZgeqDYdVF4Xv9qcU8r0DFp8xfbk0jtkRNNpcX/mL7poCWODiT2TP29uBQ1MyZ5sobly7qzTKs9s/hjcT5i/jzT5vhh2+2516lQsXa/Dhk1T4N1/fqROh/LCyCIs6dI80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(396003)(366004)(136003)(346002)(451199021)(86362001)(54906003)(71200400001)(8936002)(8676002)(5660300002)(110136005)(6506007)(6486002)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(6512007)(41300700001)(76116006)(316002)(186003)(38070700005)(2616005)(2906002)(83380400001)(36756003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklGRjdoQVVSSVhQVERvbkd6T1dSRW9ReHFvTmRMbXVIeC84T0FiQmtlVTBF?=
 =?utf-8?B?b1J4NkdaYlNBVUtXdUxFVW9lVHNvdWMxekxnMHE2ZzVoWDlLdHVXaS9EN0Fj?=
 =?utf-8?B?aDAzMW93R2NLTTlVMGFJYzJiU2xvdTdJWkdmc0xYWm5xSlRvUk14OTFjM0Vz?=
 =?utf-8?B?c0g2NnA0dUFDTHRpYW9lNThlRXQyWjByZklrNC8zalRmc2RINEo2OHNBWXhR?=
 =?utf-8?B?WkhJekEwcWxMR2Mzb0xhUzB3Wk5UZEhaczIwUk1HWC9FK1BHcmJHblJxNTE5?=
 =?utf-8?B?NUtRQ0VtdzNnMjd0ZzhZcDZQK0pEWTVKSThyWG1TN3ZZOXY3ZTFKTU9OclRw?=
 =?utf-8?B?bHR1cUtqcXJHQnhKblpJSzJkaXRrL0VVRG5SOUZPQkRRYWJ5ZkNDc1hDblhI?=
 =?utf-8?B?cCtlNnNYdWlyNVBCZVF6UHJIeks4cU5XZFJTUjF3dC9BdjdRMTVpTWZhRTIz?=
 =?utf-8?B?NWZ4eG53blk5bHZ2QmxkL0NBWWppMjRndk16dEM3YTZKcUk2Rk85dXVIRkRk?=
 =?utf-8?B?ZE51amYrZ3RsRWlJRUppZ1hSQ1dlRWQ3UWtGVFdNKzcyaGx0L0Z1Y1B5WTYr?=
 =?utf-8?B?eFlPYXVVTE1UcFVzK1hZL3NKdzhCeFI5QjU3a3J2ZjlVWkFVSXRsZGtmOFhH?=
 =?utf-8?B?NU5oUk5YdXdHQ2taQyt0d3VKejVpeTJFOVN5WkhOOXFkQ2xlR1p2MFJ6c2Zr?=
 =?utf-8?B?QnZWVHg2TU1JV0psQzZqOWtkU3E3bFVUS2lGQnJjMmk4Sm92SERjKzd0V2hr?=
 =?utf-8?B?ZWx2bCtEaEE4d1AyTUVPeDNKT3dtVjRGNlZjSFAwYUNGRWIrWGhOOUFqT1F6?=
 =?utf-8?B?OXNHbWxnVWRZSU5Ja2w1YnNrdzFKaFl0NXRuOW52ZGVDZm0wSGtxUFlRcG02?=
 =?utf-8?B?YTNMTzhlalRzNlE1SmhhYzFJZGU4MGpJeW93Si9MZkZmeDZPc1R4Nm5ybTdv?=
 =?utf-8?B?V3c3QkRYRE9ZTUJVR0lZTE1aY0tJWW9XVmV2em5DOHF0dDd3Qkc0OVkrV0Qw?=
 =?utf-8?B?M1BFVXNxdDI3Vmt4YS9qb1F6QzRnSTcybTJPK0llMVRHT21LZmlIVGE2MVNN?=
 =?utf-8?B?NGo4NGE1a2J0Z3p5QmlFaXd1N1MxbS9DdEhxU0wyYUhHVUdaWXd4QzJxK0hC?=
 =?utf-8?B?dG1SRXVwWW5lYTlBNGhsZXR5c1owWk1GK3VWU2VWRzBBUXNteEYyZ0FUZURI?=
 =?utf-8?B?NVNDeG4rSXFWOW1EWW5hTnd4MXBRb0RSaFMyWUFFUlJQYXFsanNmai8wUTY5?=
 =?utf-8?B?Z2tSMW1VRGFVSkQwT2x0aWFFN0tMU0hvWXlIZXVtem00ZHAxaE5OMjdONUVE?=
 =?utf-8?B?Vm5ibUxJMmxMU2xIRzEvRG96R3FWSG92a01HczFXMUJLY1M2Y29MVlREdEdk?=
 =?utf-8?B?NGhaUkhaOHBKSGt4UWN4UnY4Y0FlelhCamVhNU9nYk13TTVITENzZlVXOXQy?=
 =?utf-8?B?eW9wblR6SklqamRNaHFlWDJxaFFUeUhEdWhnS0pubjBvVlhlNS8xa1VUVlhm?=
 =?utf-8?B?bEh4T0NZdVRJZkkyZE5FajFhYnY1TUM2SnlHVzZjUzk2NzB3ZDYrK3hTcUlD?=
 =?utf-8?B?S2dyT2JORGpPOFl2OFdJbmJRQWNmTTdQTXZ3VjZvQzhWenZ3UWI0VXhnTHFJ?=
 =?utf-8?B?RlhHOXJlUU82bVpuUUl5VnRvSlorM1k1UXdGWmVKcXVLMEYxeTlxNmJ6RUlw?=
 =?utf-8?B?d0xxUUMrZmM1ZWY2b25KdTNuZ0ZyZUR0Q0k4S2VVaTYxb0NJbVk1Yit3WUVZ?=
 =?utf-8?B?Y0VaNlpxOUxKSGlwMThrYUxwMXczL2NReDNiMFk0eUpib1ZDK0lkcTJpcG03?=
 =?utf-8?B?cXozRDBXYTBOcU5YK2tIdEhJb0swMkRNSy9YRFI2K1ZPRUo5Z0E4MWRFbk9l?=
 =?utf-8?B?dDJ4WXl2RERyOXpRQ2w4REt1eUJIL3BQdDF5dXNWeXowa1hvMkN4UjlQME1y?=
 =?utf-8?B?cmJNWlhZUHVPZllQRmZOOWpNdXdRbDExUGNpcmFnc0h4MTdTdHFHNkkyaEJL?=
 =?utf-8?B?bjFaWUhYcmphNTloR0hEZUl0Nndxd21JSjJES0hZbU5JakhlRThaQTJZQ3RS?=
 =?utf-8?B?Ly9wVVIvS1JCbkJQM0JaVnRBVngrOFhHcWFOM2czSnlkMG9qVzNEMDlRVHAv?=
 =?utf-8?B?bDQ2UmNLNlJ5Q0ltUGdDVUpHMENJdjVXZGRmcm1KN3pVeHBHeUtSRkc2UGho?=
 =?utf-8?B?S2ptUU4wRlZaZjhUdkNwMjVYRzZEb2U4aVRmb1l4UVJSbVdhdTM0V202UDJK?=
 =?utf-8?B?bVl4YkxGK21GejlrUU81TzBkL293PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20C0B159013C0B4B82BC204907580BC3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fabe36e-a26d-4734-48ac-08db79aeaff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 21:12:18.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoI+UqRMDWtAvz9dffxe0KrhdMPKClMAKVH/Sq0aRzWOmyuCcC8ENXKkZuz3vsJHPWVbnthXy7V/hvRmyBh4tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDA5OjE4IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IENvbW1taXQgZjVlYTE2MTM3YTNmICgiTkZTdjQ6IFJldHJ5IExPQ0sgb24gT0xEX1NU
QVRFSUQgZHVyaW5nCj4gZGVsZWdhdGlvbgo+IHJldHVybiIpIGF0dGVtcHRlZCB0byBzb2x2ZSB0
aGlzIHByb2JsZW0gYnkgdXNpbmcgbmZzNCdzIGdlbmVyaWMKPiBhc3luYyBlcnJvcgo+IGhhbmRs
aW5nLCBidXQgaW50cm9kdWNlZCBhIHJlZ3Jlc3Npb24gd2hlcmUgdjQuMCBsb2NrIHJlY292ZXJ5
IHdvdWxkCj4gaGFuZy4KPiBUaGUgYWRkaXRpb25hbCBjb21wbGV4aXR5IGludHJvZHVjZWQgYnkg
b3ZlcmxvYWRpbmcgdGhhdCBlcnJvcgo+IGhhbmRsaW5nIGlzCj4gbm90IG5lY2Vzc2FyeSBmb3Ig
dGhpcyBjYXNlLsKgIFRoaXMgcGF0Y2ggZXhwZWN0cyB0aGF0IGNvbW1pdCB0byBiZQo+IHJldmVy
dGVkLgo+IAo+IFRoZSBwcm9ibGVtIGFzIG9yaWdpbmFsbHkgZXhwbGFpbmVkIGluIHRoZSBhYm92
ZSBjb21taXQgaXM6Cj4gCj4gwqDCoMKgIFRoZXJlJ3MgYSBzbWFsbCB3aW5kb3cgd2hlcmUgYSBM
T0NLIHNlbnQgZHVyaW5nIGEgZGVsZWdhdGlvbgo+IHJldHVybiBjYW4KPiDCoMKgwqAgcmFjZSB3
aXRoIGFub3RoZXIgT1BFTiBvbiBjbGllbnQsIGJ1dCB0aGUgb3BlbiBzdGF0ZWlkIGhhcyBub3QK
PiB5ZXQgYmVlbgo+IMKgwqDCoCB1cGRhdGVkLsKgIEluIHRoaXMgY2FzZSwgdGhlIGNsaWVudCBk
b2Vzbid0IGhhbmRsZSB0aGUgT0xEX1NUQVRFSUQKPiBlcnJvcgo+IMKgwqDCoCBmcm9tIHRoZSBz
ZXJ2ZXIgYW5kIHdpbGwgbG9zZSB0aGlzIGxvY2ssIGVtaXR0aW5nOgo+IMKgwqDCoCAiTkZTOiBu
ZnM0X2hhbmRsZV9kZWxlZ2F0aW9uX3JlY2FsbF9lcnJvcjogdW5oYW5kbGVkIGVycm9yIC0KPiAx
MDAyNCIuCj4gCj4gRml4IHRoaXMgYnkgdXNpbmcgdGhlIG9sZF9zdGF0ZWlkIHJlZnJlc2ggaGVs
cGVycyBpZiB0aGUgc2VydmVyCj4gcmVwbGllcwo+IHdpdGggT0xEX1NUQVRFSUQuCj4gCj4gU3Vn
Z2VzdGVkLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+Cj4g
LS0tCj4gwqBmcy9uZnMvbmZzNHByb2MuYyB8IDkgKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMKPiBpbmRleCA2YmIxNGY2Y2ZiYzAuLmJk
ZmI0YWMxNDRkMiAxMDA2NDQKPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYwo+ICsrKyBiL2ZzL25m
cy9uZnM0cHJvYy5jCj4gQEAgLTcxODAsOCArNzE4MCwxNSBAQCBzdGF0aWMgdm9pZCBuZnM0X2xv
Y2tfZG9uZShzdHJ1Y3QgcnBjX3Rhc2sKPiAqdGFzaywgdm9pZCAqY2FsbGRhdGEpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2UgaWYgKCFuZnM0X3VwZGF0ZV9sb2NrX3N0
YXRlaWQobHNwLCAmZGF0YS0KPiA+cmVzLnN0YXRlaWQpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3Jlc3RhcnQ7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0
RVJSX0JBRF9TVEFURUlEOgo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJSX09MRF9TVEFU
RUlEOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZGF0YS0+YXJnLm5ld19s
b2NrX293bmVyICE9IDAgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoG5mczRfcmVmcmVzaF9vcGVuX29sZF9zdGF0ZWlkKCZkYXRhLQo+ID5hcmcub3Bl
bl9zdGF0ZWlkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsc3AtPmxzX3N0YXRlKSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3Jlc3Rh
cnQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChuZnM0X3JlZnJlc2hfbG9j
a19vbGRfc3RhdGVpZCgmZGF0YS0KPiA+YXJnLmxvY2tfc3RhdGVpZCwgbHNwKSkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3Jlc3RhcnQ7
CgpFcnIuLi4gWW91IG9ubHkgd2FudCB0byBjYWxsIG5mczRfcmVmcmVzaF9sb2NrX29sZF9zdGF0
ZWlkKCkgaWYgZGF0YS0KPmFyZy5uZXdfbG9ja19vd25lciBpcyAwLiBUaGF0J3Mgbm90IGd1YXJh
bnRlZWQgdG8gYmUgdGhlIGNhc2UgaGVyZS4KCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGZhbGx0aHJvdWdoOwo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfQkFEX1NUQVRF
SUQ6Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfU1RBTEVfU1RBVEVJRDoKPiDCoMKg
wqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9FWFBJUkVEOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKGRhdGEtPmFyZy5uZXdfbG9ja19vd25lciAhPSAwKSB7CgotLSAKVHJv
bmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
