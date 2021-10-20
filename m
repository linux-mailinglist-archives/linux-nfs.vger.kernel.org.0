Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951154353C7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhJTT3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 15:29:12 -0400
Received: from mail-dm6nam12on2124.outbound.protection.outlook.com ([40.107.243.124]:16097
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhJTT3I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 Oct 2021 15:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt2npw9+KaPgL0Q/5qqy25IsWRqqQ4+8GThdOEVPm2eoDnMH0zCGHsS0CZW7eqjrf89WW+l/wpu1IGJ30T4Kb3VrqlzqgH6U3rX+s1h8Lk37qWQ7O2+1MxNdOUn8WQW8Dk3hCx9xxGrvJBNhIOesoFQ/ykANZ/Q2Xg8B91H7+cLFag7OM/MkjFsaKrABlzXKHC/nFVIsiZkd+9eHH203xtZSp1h7hB7v9TI9w39aLq1mWSUyEZiDfLNvCegVXH5OOTOpn1D8Cs8dwNmruwA+l7eig/GsXBpzeRSpbZcojiXYmRUieDcPp1oXe5mu7bQs0g7+PBonNGZ+PCOHQ2l5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlGva2guaWlgULbNVQeCRIC9YpTH109vLnp8mkMt5MM=;
 b=fWMFRe0CKufg+Abd53sIzwlpPw0pnOAJATUjfD1Cycpr8WNET+C9v/qANFRbwd5DXfLBdA+/3RyZwyvKAmfiZco2L+yy+PIlFkLw+PldD/CMIlUZk4oywkt6KRYIP83piGxFMh4+8ReFSRnZ5yxG3uN4sm6SafoM+ivF7eALvZ+9keV5Fi7BJGiF01nu6/dIAG59tHpkXwxGmN6Rw//Ts4R2ATmFidJRSKLlcUoCgkMjTX3cuIGq7xJF5vkfBJDNznnqHr9yYCp1OpmkKhOGL+phs+rMnvZ30ZDSp5cMSBX7RInK7D4YamLv9j4EHXTTYqvkl0Pqsu01AMYuwCvZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlGva2guaWlgULbNVQeCRIC9YpTH109vLnp8mkMt5MM=;
 b=YmMugUYRrYNtxGPlwd21bZlEvz993IOiwlRFWODVVfN1y2JXcXx6/6rXfWI7m36d4myanFlAMVTv065H0UXnyVGzWJviaOTTjtBfW9Sum8nm7XaUQWKhbR3CNgZic9xC09+bAMusBWMP4wAyyCjhVk1h3/JNshepGL5kcpGFXeM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3736.namprd13.prod.outlook.com (2603:10b6:610:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13; Wed, 20 Oct
 2021 19:26:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 19:26:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/1] NFS: Convert from readpages() to readahead()
Thread-Topic: [PATCH v2 1/1] NFS: Convert from readpages() to readahead()
Thread-Index: AQHXvQpIjlx9eeE6ekuN7w5ErJfSK6vcVscA
Date:   Wed, 20 Oct 2021 19:26:51 +0000
Message-ID: <33f3ce883c7f874e2aa684f3ad83882bf7c38acb.camel@hammerspace.com>
References: <1633782962-18335-1-git-send-email-dwysocha@redhat.com>
         <1633782962-18335-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633782962-18335-2-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afcdbab1-3022-4a12-d7f9-08d993ff9170
x-ms-traffictypediagnostic: CH2PR13MB3736:
x-microsoft-antispam-prvs: <CH2PR13MB3736C0A92A871863F500D7ACB8BE9@CH2PR13MB3736.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qRXwRYy+Z0nucBkaqKB1WfC6CFzrOEK3pBr3hForr1ZDiWdxWhIhwqRKeCmbHWImXQR/36YgtadMV1sC8MZQW18lBTwOwSU4/nPcP1XdLRLd7lCyGoqPzkYrX2o7LWkyrVPtdIu8El9UwiiZFJlUdMJbpvYRol5P6cOYbI+XSy9bQOeEga4GFOuk1NLOjnGRwnKhtoirC2GYBoDV3TWgt9xESDFDTSjK2hjumnqOKA2pOnq2+FysBtqmt162+7mVH7vlZNj87kJiPENmKK5SGBq5Hd8mggaAhYbFTavfPlIotC3gS4yA/r35EaLAOOeSxxnTg2kSPc0Vo7lRcTvxjr3zRNH4owhZn2l+9EW3//Ud3NHnhUsvRWMSY6W0ONVFs+YyROLqDwIf0EPHHGS5gBVQgzujAcFdFQLZje/rUGWmftbQYlWAjWgJ8zLwWkMb7+tdtx4ODqUgzQtMGyFGpFcX1YTPskBzAA8CDhADwyBbKXYlz8ocOwtQLznbxESZaNd6+BPLRU7RAIzRN2HX6+tY7P9jQ7hilrDP6koASGCsUhc+nwGEc7RJXZY2GjvaD2vFPH7Z6oGcVq6Fcbufmog3a2w3rv4UzFCgKGorKXJ2BwU+d7x6j0QGw9YlXg6Da/xGnA77FZodfPTA6LdwYQwMvKfGAdYYe2oTPwyP0Pl3TZ/+iXLg/v3DUxKQTDsARJFMWx2SW8FW4cGZM3bBRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6512007)(26005)(6506007)(122000001)(186003)(66476007)(64756008)(66556008)(66446008)(86362001)(76116006)(66946007)(8936002)(54906003)(316002)(71200400001)(110136005)(2906002)(508600001)(38070700005)(36756003)(5660300002)(6486002)(83380400001)(38100700002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRDUUdPRVViN2REbnhzTk83MVJUNHZJRGNDTUJKeDVNMWFPUTRMMEVNYXpN?=
 =?utf-8?B?eDQxbnJlL2kxNXcvbWQ0UmtHSzUvRVhzMjVQVDc4OWw4NFNFRVVmS09GQ05E?=
 =?utf-8?B?a1dDb0tLekJHSG0wUTMwRVA5V2xrZE50SzlQK1Mzb01TeEVNdlBYTkxDUVM5?=
 =?utf-8?B?aEJvYUdjMGJtaXRvbmloREJxQmtWWFIxNTBrUEJyY21sWXVpdHpKa1VIUjZt?=
 =?utf-8?B?blBSVTBxcVQ0RGR1VVp1d0l3YzZhekxkbU0xVW1RbDk2TnhmbmJ0S2ZhdFlN?=
 =?utf-8?B?bGJzbDdHM0VoNDZObk1SSkRZU1ArazUwemNrankxSlVKMmc0QVlGOG96ekxO?=
 =?utf-8?B?dlFqQklCTzIzdVcwcnkrNk50SnVyalFmR1VEN0FGRE1vbVJBUTZXYVVqNmlO?=
 =?utf-8?B?YWk0N0U1blpTUmlPbFUxOEtwY3Jjdy9HQmI5Nk1KNmlVRHEzVWJhcTlsSjIy?=
 =?utf-8?B?UC9hUjBIcTFNZkNWZXJNQkVCY2QzbmlwQXh4KyttbjNOTDBhdXVmbWNxRnRP?=
 =?utf-8?B?bzA3NFdiSGVyOVJZb0F2d2JEc3JqVDZldDRnbng1VGZ4czROVWMrbVdVOCtv?=
 =?utf-8?B?aEJ3TmxVSnRsbFI4eVNHYlMycDM5UU5kRHVMZUt1ekVNSC9FaUFta2lDczRp?=
 =?utf-8?B?SThLbjBJVmM1V2Exa2U0YWtFYkV4NzlucW1oRlNXbWtOSFFGekY5aThCNVdk?=
 =?utf-8?B?MVNPRWY2T3ROaWlnT1d5dG1ielBkVDYxKzg5d3pKblZsVzBORVhoNzlPNmlI?=
 =?utf-8?B?WUFZT2JkSStuMmZKVjJqeFRJZjFWQkJ6czhBNHJNQzdTakdteTE1L0JTSFMx?=
 =?utf-8?B?bVU3SFBvRmtFZ2xGNHNBaDNPMTNOL3pmNUQ1cVM3NkxGT2lXZ2NEZTUwVWla?=
 =?utf-8?B?L3AvSTh3SG1rSXl3VDBSaGRYdUpCWHhRTzI3UWlYWEhPeUorVVVUVGlvcllt?=
 =?utf-8?B?NmNVT29UZTFPUDdCQXJKcEFSakhPcG5JOEMwNHIvbkdkdjk3TzI4dHNSNzg1?=
 =?utf-8?B?ZDJ0cmtMSXVKNExwRHFXdmhWZnJ0V3JlNkNEbHZ5Z2cyY2RhV2gxekFIQUtD?=
 =?utf-8?B?MzUxOUpKSGFKMHcweHJETmx6TmJCTXF0R3k1azY1R1JDbW5NUTJqT2Q1SUlw?=
 =?utf-8?B?Zi8zSEgvSXovR0k2SGg1bkl6L2xvNnhQek9SZGVRZWhhQkdmRERQTmpIQ2g4?=
 =?utf-8?B?V2dYd09uOGtmZndDY3dGNHhJcXhFRVAzMGN6eE96QytLU3R3cHovVjRDdnpz?=
 =?utf-8?B?Q1BSSnNmK3ZBeTQzSmJZVnp5SjBsdDFzWE9WcHI1Sklkbmt6RUlJMkZpeVBP?=
 =?utf-8?B?dWUvcHhMTjlQeHNyL2kxSGtqMFIzWkc0WXpVWTRCL2dWZFNEdFVpbktGaXZS?=
 =?utf-8?B?aFpjYmpvY1RwTzJJRDBYWllVVFBKc0JNVkt5a2xUSnpKeXRydEQxL1ZIeWhp?=
 =?utf-8?B?TVd1U1A0MUF5TzE2VllOb2lTZE5nNkFEbkNzNU1tUmZWYis3ejF5RVEwR0FF?=
 =?utf-8?B?enNnMlBIcExTMnZsMjVKTzU1OHJsd2RJejNkOWF0MWREWXF5bjVEd2JnS0Za?=
 =?utf-8?B?MStpd09FWlJ1bThMTHo5OE45eitYNTlrbC91VzZnT1BCM2JkUzEvT1FlVnBl?=
 =?utf-8?B?amwvbm44THFWYW9kbXpBbDlsSDY5VEp4ZTBlQkpBb1dYQURRREpIcTkzT0J2?=
 =?utf-8?B?YzFJYXhlK1dkbXcrQUErVWZsbkR4QVQ0TEJsL213N3ZQcGpLdG5MSlNJd2Vl?=
 =?utf-8?B?UHBOdmFGNjd2OUl0cVVIV3Q5UTY4Z1RXVS9PY3BEWml5aXhFVzh4ZjJ0Umo3?=
 =?utf-8?B?V0ROSzBLRU5nTnBYWVRuNGFDcDc1VmRsK2dibkcvVCt2L1QzNkRoT21pcER6?=
 =?utf-8?B?OC84SzJvRkp5clpobzN1dWNXNmc3RWhyL2FPTGM2alFpUzRLdlI0NTREbXpM?=
 =?utf-8?Q?xHnpKpPyGH+9cKJlcFSLZcUf+B7mO4kN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <149A12C0BB0F8049985B53A362AA3522@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcdbab1-3022-4a12-d7f9-08d993ff9170
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 19:26:51.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3736
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIxLTEwLTA5IGF0IDA4OjM2IC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Ogo+IENvbnZlcnQgdG8gdGhlIG5ldyBWTSByZWFkYWhlYWQoKSBBUEkgd2hpY2ggaXMgdGhlIHBy
ZWZlcnJlZCBBUEkKPiB0byByZWFkIG11bHRpcGxlIHBhZ2VzLCBhbmQgcmVuYW1lIHRoZSBORlNJ
T1NfKiBjb3VudGVycyBhbmQgdGhlCj4gdHJhY2Vwb2ludCBhcyBuZWVkZWQuCj4gCj4gU2lnbmVk
LW9mZi1ieTogRGF2ZSBXeXNvY2hhbnNraSA8ZHd5c29jaGFAcmVkaGF0LmNvbT4KPiAtLS0KPiDC
oGZzL25mcy9maWxlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgZnMv
bmZzL3JlYWQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTggKysrKysrKysrKysrKy0t
LS0tCj4gwqBpbmNsdWRlL2xpbnV4L25mc19mcy5owqDCoMKgwqAgfMKgIDMgKy0tCj4gwqBpbmNs
dWRlL2xpbnV4L25mc19pb3N0YXQuaCB8wqAgNiArKystLS0KPiDCoDQgZmlsZXMgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9maWxlLmMgYi9mcy9uZnMvZmlsZS5jCj4gaW5kZXggMjA5ZGFjMjA4NDc3Li5jYzc2ZDE3ZmE5
N2YgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL2ZpbGUuYwo+ICsrKyBiL2ZzL25mcy9maWxlLmMKPiBA
QCAtNTE5LDcgKzUxOSw3IEBAIHN0YXRpYyB2b2lkIG5mc19zd2FwX2RlYWN0aXZhdGUoc3RydWN0
IGZpbGUKPiAqZmlsZSkKPiDCoAo+IMKgY29uc3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0
aW9ucyBuZnNfZmlsZV9hb3BzID0gewo+IMKgwqDCoMKgwqDCoMKgwqAucmVhZHBhZ2UgPSBuZnNf
cmVhZHBhZ2UsCj4gLcKgwqDCoMKgwqDCoMKgLnJlYWRwYWdlcyA9IG5mc19yZWFkcGFnZXMsCj4g
K8KgwqDCoMKgwqDCoMKgLnJlYWRhaGVhZCA9IG5mc19yZWFkYWhlYWQsCj4gwqDCoMKgwqDCoMKg
wqDCoC5zZXRfcGFnZV9kaXJ0eSA9IF9fc2V0X3BhZ2VfZGlydHlfbm9idWZmZXJzLAo+IMKgwqDC
oMKgwqDCoMKgwqAud3JpdGVwYWdlID0gbmZzX3dyaXRlcGFnZSwKPiDCoMKgwqDCoMKgwqDCoMKg
LndyaXRlcGFnZXMgPSBuZnNfd3JpdGVwYWdlcywKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3JlYWQu
YyBiL2ZzL25mcy9yZWFkLmMKPiBpbmRleCBkMDZiOTFhMTAxZDIuLjI5NmVhOWE5YjZjZSAxMDA2
NDQKPiAtLS0gYS9mcy9uZnMvcmVhZC5jCj4gKysrIGIvZnMvbmZzL3JlYWQuYwo+IEBAIC0zOTcs
MTUgKzM5NywxOSBAQCBpbnQgbmZzX3JlYWRwYWdlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qg
cGFnZQo+ICpwYWdlKQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+IMKgCj4g
LWludCBuZnNfcmVhZHBhZ2VzKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgYWRkcmVzc19zcGFj
ZSAqbWFwcGluZywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGxpc3Rf
aGVhZCAqcGFnZXMsIHVuc2lnbmVkIG5yX3BhZ2VzKQo+ICt2b2lkIG5mc19yZWFkYWhlYWQoc3Ry
dWN0IHJlYWRhaGVhZF9jb250cm9sICpyYWN0bCkKPiDCoHsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgZmlsZSAqZmlsZSA9IHJhY3RsLT5maWxlOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZGRy
ZXNzX3NwYWNlICptYXBwaW5nID0gcmFjdGwtPm1hcHBpbmc7Cj4gK8KgwqDCoMKgwqDCoMKgc3Ry
dWN0IHBhZ2UgKnBhZ2U7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG5yX3BhZ2VzID0g
cmVhZGFoZWFkX2NvdW50KHJhY3RsKTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNf
cmVhZGRlc2MgZGVzYzsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlub2RlICppbm9kZSA9IG1h
cHBpbmctPmhvc3Q7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgdHJhY2VfbmZzX2FvcF9yZWFkYWhlYWQoaW5vZGUsIG5yX3BhZ2VzKTsKPiAtwqDCoMKg
wqDCoMKgwqBuZnNfaW5jX3N0YXRzKGlub2RlLCBORlNJT1NfVkZTUkVBRFBBR0VTKTsKPiArwqDC
oMKgwqDCoMKgwqBuZnNfaW5jX3N0YXRzKGlub2RlLCBORlNJT1NfVkZTUkVBREFIRUFEKTsKPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtRVNUQUxFOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
TkZTX1NUQUxFKGlub2RlKSkKPiBAQCAtNDIyLDE0ICs0MjYsMTggQEAgaW50IG5mc19yZWFkcGFn
ZXMoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdAo+IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCgoK
VGhpcyBmdW5jdGlvbiBmYWlscyB0byBjb21waWxlIGR1ZSB0byB0aGUgY2FsbCB0bwpuZnNfcmVh
ZHBhZ2VzX2Zyb21fZnNjYWNoZSgpIHRha2luZyBhICdwYWdlcycgYXJndW1lbnQuCgo+IMKgwqDC
oMKgwqDCoMKgwqBuZnNfcGFnZWlvX2luaXRfcmVhZCgmZGVzYy5wZ2lvLCBpbm9kZSwgZmFsc2Us
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJm5mc19hc3luY19yZWFkX2NvbXBsZXRpb25fb3BzKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oHJldCA9IHJlYWRfY2FjaGVfcGFnZXMobWFwcGluZywgcGFnZXMsIHJlYWRwYWdlX2FzeW5jX2Zp
bGxlciwKPiAmZGVzYyk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gMDsKPiArwqDCoMKgwqDCoMKg
wqB3aGlsZSAoIXJldCAmJiAocGFnZSA9IHJlYWRhaGVhZF9wYWdlKHJhY3RsKSkpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJlZmV0Y2h3KCZwYWdlLT5mbGFncyk7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJlYWRwYWdlX2FzeW5jX2ZpbGxlcigm
ZGVzYywgcGFnZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHB1dF9wYWdlKHBh
Z2UpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBuZnNfcGFnZWlv
X2NvbXBsZXRlX3JlYWQoJmRlc2MucGdpbyk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcHV0X25m
c19vcGVuX2NvbnRleHQoZGVzYy5jdHgpOwo+IMKgb3V0Ogo+IMKgwqDCoMKgwqDCoMKgwqB0cmFj
ZV9uZnNfYW9wX3JlYWRhaGVhZF9kb25lKGlub2RlLCBucl9wYWdlcywgcmV0KTsKPiAtwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+IMKgCj4gwqBpbnQgX19pbml0IG5mc19pbml0X3Jl
YWRwYWdlY2FjaGUodm9pZCkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZnNfZnMuaCBi
L2luY2x1ZGUvbGludXgvbmZzX2ZzLmgKPiBpbmRleCAxNDAxODdiNTdkYjguLmE1YWVmMmNiZTRl
ZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oCj4gKysrIGIvaW5jbHVkZS9s
aW51eC9uZnNfZnMuaAo+IEBAIC01ODYsOCArNTg2LDcgQEAgZXh0ZXJuIGludCBuZnNfYWNjZXNz
X2dldF9jYWNoZWQoc3RydWN0IGlub2RlCj4gKmlub2RlLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3Jl
ZCwgcwo+IMKgICogbGludXgvZnMvbmZzL3JlYWQuYwo+IMKgICovCj4gwqBleHRlcm4gaW50wqAg
bmZzX3JlYWRwYWdlKHN0cnVjdCBmaWxlICosIHN0cnVjdCBwYWdlICopOwo+IC1leHRlcm4gaW50
wqAgbmZzX3JlYWRwYWdlcyhzdHJ1Y3QgZmlsZSAqLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqLAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkICosIHVuc2ln
bmVkKTsKPiArZXh0ZXJuIHZvaWQgbmZzX3JlYWRhaGVhZChzdHJ1Y3QgcmVhZGFoZWFkX2NvbnRy
b2wgKik7Cj4gwqAKPiDCoC8qCj4gwqAgKiBpbmxpbmUgZnVuY3Rpb25zCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvbmZzX2lvc3RhdC5oIGIvaW5jbHVkZS9saW51eC9uZnNfaW9zdGF0LmgK
PiBpbmRleCAwMjc4NzRjMzZjODguLjQxODE0NWYyMzcwMCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L25mc19pb3N0YXQuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvbmZzX2lvc3RhdC5oCj4g
QEAgLTIyLDcgKzIyLDcgQEAKPiDCoCNpZm5kZWYgX0xJTlVYX05GU19JT1NUQVQKPiDCoCNkZWZp
bmUgX0xJTlVYX05GU19JT1NUQVQKPiDCoAo+IC0jZGVmaW5lIE5GU19JT1NUQVRfVkVSU8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIjEuMSIKPiArI2RlZmluZSBORlNfSU9TVEFUX1ZF
UlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIxLjIiCj4gwqAKPiDCoC8qCj4gwqAg
KiBORlMgYnl0ZSBjb3VudGVycwo+IEBAIC01Myw3ICs1Myw3IEBACj4gwqAgKiBORlMgcGFnZSBj
b3VudGVycwo+IMKgICoKPiDCoCAqIFRoZXNlIGNvdW50IHRoZSBudW1iZXIgb2YgcGFnZXMgcmVh
ZCBvciB3cml0dGVuIHZpYQo+IG5mc19yZWFkcGFnZSgpLAo+IC0gKiBuZnNfcmVhZHBhZ2VzKCks
IG9yIHRoZWlyIHdyaXRlIGVxdWl2YWxlbnRzLgo+ICsgKiBuZnNfcmVhZGFoZWFkKCksIG9yIHRo
ZWlyIHdyaXRlIGVxdWl2YWxlbnRzLgo+IMKgICoKPiDCoCAqIE5COiBXaGVuIGFkZGluZyBuZXcg
Ynl0ZSBjb3VudGVycywgcGxlYXNlIGluY2x1ZGUgdGhlIG1lYXN1cmVkCj4gwqAgKiB1bml0cyBp
biB0aGUgbmFtZSBvZiBlYWNoIGJ5dGUgY291bnRlciB0byBoZWxwIHVzZXJzIG9mIHRoaXMKPiBA
QCAtOTgsNyArOTgsNyBAQCBlbnVtIG5mc19zdGF0X2V2ZW50Y291bnRlcnMgewo+IMKgwqDCoMKg
wqDCoMKgwqBORlNJT1NfVkZTQUNDRVNTLAo+IMKgwqDCoMKgwqDCoMKgwqBORlNJT1NfVkZTVVBE
QVRFUEFHRSwKPiDCoMKgwqDCoMKgwqDCoMKgTkZTSU9TX1ZGU1JFQURQQUdFLAo+IC3CoMKgwqDC
oMKgwqDCoE5GU0lPU19WRlNSRUFEUEFHRVMsCj4gK8KgwqDCoMKgwqDCoMKgTkZTSU9TX1ZGU1JF
QURBSEVBRCwKPiDCoMKgwqDCoMKgwqDCoMKgTkZTSU9TX1ZGU1dSSVRFUEFHRSwKPiDCoMKgwqDC
oMKgwqDCoMKgTkZTSU9TX1ZGU1dSSVRFUEFHRVMsCj4gwqDCoMKgwqDCoMKgwqDCoE5GU0lPU19W
RlNHRVRERU5UUywKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
