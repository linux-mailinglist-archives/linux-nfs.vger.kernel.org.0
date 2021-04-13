Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D041F35E4F5
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhDMRY1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 13:24:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDMRY0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 13:24:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHMOFI038037;
        Tue, 13 Apr 2021 17:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ziSevKstDcA+af+tWC6vdYYSrFAHsW5XL+AMbQefAY4=;
 b=w43UUWY4BM81eyEGpDVSxIdeRMXpRYWDrjlxXAhPrbglynfAJRYUY9q8i4cy/9G99xj1
 SrTAaB3t4qdZ+QUanfqwK/tfsMcYNsyxaQeVOAThX2wMYpmSflLbyvFVdm63o5BTWod2
 Xk2cKvE6KKyezJbA+ecV3eZw3+KUc6bl3CIoyAgpXz6zRf+/oIbnw0DaSYHoZA3XScRx
 IAsqt2V31zEfX4Ki/g2crllaCjkqQinQ4RNTQ+Bf7r5qhJLDCOTsXvA3APuyiQzmOa/3
 Y1B0jlOGaZmHbV0UnrGdRq/VK5eBVozFka9Pp+F1EH16S85V0G0LQ8tcMxhIscP+QU27 DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymfukq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:24:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHKaTg043735;
        Tue, 13 Apr 2021 17:24:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 37unkptes2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqj1XoKAAJMnLKg8ttPHixHF6JpCCUpTzxwN3WnQEa7+AB69fRvSOUkpd9PUBIXmoGzvdLao5qScIwafkegFA2qjv+Fefds9gDhFX4O4LYKTLDoTzwWVLzp2FOmBJzl6E1hDq5gGnqmAIjTVJxehJid8ebNGD4vP/21AQSlpPDnntJTm8Tvfh3CqcYW1C4cJ0AueiziVP6BUCM7YgRu3jdWNqcJ8f1tt/XowY4xdabTddQNBsK67TVMl4BFeHe6T67M+uMPlRuyaZGeHIroLydhBV5uyDVLPL1lIvpuSDJuFMsV8tZ9o+9Fk/IrlUdVsK6glPxB9p/v7GZcWNDTimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziSevKstDcA+af+tWC6vdYYSrFAHsW5XL+AMbQefAY4=;
 b=duFuXPpKjU8SgmiRC2IwZTB7eJnwwPrUoxihSCBnf5+8u4dzrxyG3xt/rtDEege4gJPCdQCqXdn60Ab23tjshEaHJZ93fzFwD1WJkybPolE7Vbjc6oC+2cwByQzmf5hpUMYOZGRR0Uw91gF8NrCKKv2RCVCnfkXY7qQ+p63mXLJBnZMtfHPd2vbOMCWkk0qiDA+HS3w3FzEkxmOdzQLlBS4LmjInXqC6MJSs1Udmm3SsESl7bTbSImQtl9cYphx+SP509f1+vr2PyTJBHq+848lsdaucYNhWrgvpwgOtHU8NVg8DUz353LnCvGSLD+DDnzQoO4utB564laLODpf2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziSevKstDcA+af+tWC6vdYYSrFAHsW5XL+AMbQefAY4=;
 b=dMui6qdW7VG5utJyXcqS3ui4xbJSWThnk0Yh/wgmG4wFdzVSgYSJjHX0620n6MjBIptev38LFz8DRcOtuedXGcT2OmsbfEcyqeCSWPMBlVd6+gychwhgEn9OCvpALT51qiPRn+OBygr2UAKQkYvs8uLMyQP1Q4e4JmVqgsk068A=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4052.namprd10.prod.outlook.com (2603:10b6:a03:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 17:24:00 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:24:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Charles Hedrick <hedrick@rutgers.edu>
CC:     Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: safe versions of NFS
Thread-Topic: safe versions of NFS
Thread-Index: AQHXMHJJXHC7qBNomUi1NoAwF804MqqyiHYAgAAG1ACAAAUuAIAADaZ5gAAQkgA=
Date:   Tue, 13 Apr 2021 17:24:00 +0000
Message-ID: <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
In-Reply-To: <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c51375e4-bee6-4b09-d195-08d8fea0edb3
x-ms-traffictypediagnostic: BY5PR10MB4052:
x-microsoft-antispam-prvs: <BY5PR10MB40529E1A4F60C6C75D61CB6F934F9@BY5PR10MB4052.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykdbI0sPn3uAa7yJE4h29D+S8OM1xX3RMdT3RsxViXS5R03P6xIWUR43ZbLFvBYLJWVclfxdHAn7/DyJAposr6jT5muUqP4Apnd+IHCbKghkpPIx74iNOEXBlS4NR4Ud4WGRahR4z85nHx0uiPhq+//hb6aiRlR2/mZ2CvbajyVsj4IrbxECpL8TjrrL9CWuW54UVlPlKYXeXvkPQ/vIZOBVi8c2ll3BXPSeCLm65JLt3y1Xb15xEZHaoIgu3593LmrUdeVHdtsg3nmbbkNOMukHrVCR08x4NfvvgsoqeFgwL0QdTnFYlWEWvhUP45dhitksxbFyckN33/Best+EzAWvu4N9sGGNau/RY74qGfyV1yQbR16ubnNRwvyMxOmuojtZyyFID3kGZNeOt41K7ZT3Pahq/JSYYYzd/JzW3Sms+5MZ1vXdJZiujc5Kgt28vTfcqx/MMYkgEE3p3popL+OyaI87QXyxagslPimsykTVqKJZVncdiPXalID9R6e8S3sNIA8BVCPgWi3T1iO7RaELXK6jsVEcRiGWZhKpxs3b0mC5vaRD/pHX96LXNp3w6AKReU9hGSD2o3PXDxXJUGKV9dBKEKq9SsGlivA/R6q2lawZk/B9AGrY7cFPbwwWAqQtAzGz7kz93PXEfZdDuxeSV4eizd3R1K6xK+1gT4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(2906002)(6512007)(71200400001)(53546011)(3480700007)(38100700002)(2616005)(186003)(316002)(4326008)(6506007)(36756003)(122000001)(86362001)(26005)(5660300002)(8936002)(83380400001)(66556008)(66446008)(76116006)(33656002)(64756008)(54906003)(8676002)(6486002)(478600001)(110136005)(66946007)(66476007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UERDZmZGY2d1RmhGZVc0RGxPb1RTRktnQzlxajZBZkJHMDc0bzlLVlZMOVVG?=
 =?utf-8?B?TC9WOXZqMk05SllkSzRwUGphYWVJN2lIcTRWOGJ0WUFRT2ZSWjl5N1hRbnBy?=
 =?utf-8?B?aXc5RU9PUis5TFBOTWZFZVp6NytVSy8vMHlRQ1V1TTQ2V0NmVDFyeU9VMmdp?=
 =?utf-8?B?R2NMYzF2OWxXb3d2TVd5aUU2RHBQYlVMYUZvVGZNVnYzbEZJV0VzS2NuN0lN?=
 =?utf-8?B?ajB5NXYvVW9xVVpNSTRFRW0zeTgySmpweDlQL0NlV1pmem1vZkU3VnowUW9Z?=
 =?utf-8?B?V00yaEZQRW9XQW9QaVF4bjhGMjg0VDZ0T1g4RzZVOEpRcHg2SFpzSEhqUXJL?=
 =?utf-8?B?NHA0SkplcDBGWjJraDEwa3pwbVJCRWxOSXgrOThhOEVncmJJbWJpUmUrMzE1?=
 =?utf-8?B?OUU3TW9wTnFMelpoQ2JMSmY3YjhQR1p3OEJaUE5icWJLZDBCM2hRWXRsaEd0?=
 =?utf-8?B?UURqS2prR29pR29TS1J0Ly9yRmRkK0JsRHAyVXEwYWxiUkdCRk1VYTh5aFZK?=
 =?utf-8?B?WXR2MzVJRHZLVnNOejJmRWxYM1lJZmJ2NS9xTUI2ZkhORE4vQmRzY1lyK0k0?=
 =?utf-8?B?RC9BRUw5LzRQME0xSy9OeEtWNVBTRVNkR1dEaU1lZ09jVkI3RVkxdFQwZ0M2?=
 =?utf-8?B?UTB1U1h3ZmF0N2FRd3YrZTg1WXgwZVRhT25qQUVBY2x2WnZhU25waFAydVJ0?=
 =?utf-8?B?TUFpRjBvTHJQWGJzU09JTUY3NUg3UmtmTlR6Q3BPVlgvZW1vRzVsZmduV1Vt?=
 =?utf-8?B?aE5JZkp0YkM5QXA4Yk93dEZ3KzBJQjZ0aGZVNk1vcEgrZzNuSTZLUnlVcFgx?=
 =?utf-8?B?MmVqcTVMWlpGdktJSVduakJNZ1p3M3l2ZVBETXBTNXFtSldCMVIxVEpXUExs?=
 =?utf-8?B?dE5NUjRiUGFBbzBwTElwMDNWNU5uT3FoRkEzTnJGcXl0aFhnSFgzZ0RKNWEz?=
 =?utf-8?B?N0lGTm9VZ3crZmV4MURiNkxsRHN1amJSNEFaamU2ck41Q0kwTVkydHVvcEhy?=
 =?utf-8?B?SkovSStGOWoyQmdKc01PcW9oaUMvbGFJaC9yc2RwdXZBMEFxZmVCTDQ1ajJu?=
 =?utf-8?B?emtROGg3eVM4WUlEdmVuR0RYV0p3ZnZaWkFKendQUlRsRmtFdWIwYlFzMUZG?=
 =?utf-8?B?dTFVK2VINFl5M1JDL3RFdnRsTGVYRjRXdEVud1dsVVppbmN0dVNOVFJHK01Y?=
 =?utf-8?B?YmNPZjREMkZuUFUvb3RHR2QxWktCaEI2VDBLY0hPMDh4SVhkRTJCTkJLdUNI?=
 =?utf-8?B?TDBCUVJqUUxCeHBmVVhuREJqWDdKSHRrZGtVbEs5dWZpLzNFWGVQNTV4WFF2?=
 =?utf-8?B?V1dZV21PMnl6M2ZEZ2I3WU45MUtVam9JWEhjajc5dHYvcjQrcWdKdnd2VDhU?=
 =?utf-8?B?QmY2TlZNa3N6VDcrQmdiSmtmSkJhUmcyV0xMWmsyMEZwcDJvMEdsbFp6bjhw?=
 =?utf-8?B?QjRadm1ocjBPYUx0dGU0dU5OZkdwMkJ0bng4V1AxTk1PNXowR1VyT0FmdnAz?=
 =?utf-8?B?YUdmZTNnTU1hYzgzMExwNmxNZkFGT3BMd2dycE5kc2M3MXBoR2ZmcHFmaUZ0?=
 =?utf-8?B?bnpOVjJRUVEyeUg0ZXFDaWxvKy9iQ3IzOTFFQVVwcG9mWU9TaldWemRiSWRm?=
 =?utf-8?B?NTcvQjJydGUvQzdnZDBZMlFFdXZXNXRLdGJHSk92MW8raHVnTlV2Nnh6U0xU?=
 =?utf-8?B?L09lcGtNbHU3TE4rT0Ryd3c5ZytsNTBJZS9EY3VvekJSd09VL2lyT0xkN283?=
 =?utf-8?Q?+FMBFK1/U0/eH5zzOWVZe4Oj/jImRvefT3JjMqK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <03730BDDF064714181B81ED7A589D995@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51375e4-bee6-4b09-d195-08d8fea0edb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 17:24:00.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ5M3jL+QLSDnpBN6Udo2MRs1CRxdt9jxQ0bO4SszDxvHYdJkhiIFkfvSjZRubi8D0A3yv3PRYIKbbeMfBfijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4052
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130118
X-Proofpoint-GUID: V-6GO61Pv61xBGjIHXEZrDZLKk04X2mJ
X-Proofpoint-ORIG-GUID: V-6GO61Pv61xBGjIHXEZrDZLKk04X2mJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXByIDEzLCAyMDIxLCBhdCAxMjoyMyBQTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAocmVzZW5kaW5nIHRoaXMgYXMgaXQg
Ym91bmNlZCBvZmYgdGhlIGxpc3QgLSBJIGFjY2lkZW50YWxseSBlbWJlZGRlZCBIVE1MKQ0KPiAN
Cj4gWWVzLCBpZiB5b3UncmUgcHJldHR5IHN1cmUgeW91ciBob3N0bmFtZXMgYXJlIGFsbCBkaWZm
ZXJlbnQsIHRoZSBjbGllbnRfaWRzDQo+IHNob3VsZCBiZSBkaWZmZXJlbnQuICBGb3IgdjQuMCB5
b3UgY2FuIHR1cm4gb24gZGVidWdnaW5nIChycGNkZWJ1ZyAtbSBuZnMgLXMNCj4gcHJvYykgYW5k
IHNlZSB0aGUgY2xpZW50X2lkIGluIHRoZSBrZXJuZWwgbG9nIGluIGxpbmVzIHRoYXQgbG9vayBs
aWtlOiAiTkZTDQo+IGNhbGwgc2V0Y2xpZW50aWQgYXV0aD0lcywgJyVzJ1xuIiwgd2hpY2ggd2ls
bCBoYXBwZW4gYXQgbW91bnQgdGltZSwgYnV0IGl0DQo+IGRvZXNuJ3QgbG9vayBsaWtlIHdlIGhh
dmUgYW55IGRlYnVnZ2luZyBmb3IgdjQuMSBhbmQgdjQuMiBmb3IgRVhDSEFOR0VfSUQuDQo+IA0K
PiBZb3UgY2FuIGV4dHJhY3QgaXQgdmlhIHRoZSBjcmFzaCB1dGlsaXR5LCBvciB2aWEgc3lzdGVt
dGFwLCBvciBieSBkb2luZyBhDQo+IHdpcmUgY2FwdHVyZSwgYnV0IG5vdGhpbmcgdGhhdCdzIGVh
c2lseSB0cmFuc2xhdGVkIHRvIHJ1bm5pbmcgYWNyb3NzIGEgbGFyZ2UNCj4gbnVtYmVyIG9mIG1h
Y2hpbmVzLiAgVGhlcmUncyBwcm9iYWJseSBvdGhlciB3YXlzLCBwZXJoYXBzIHdlIHNob3VsZCB0
YWNrDQo+IHRoYXQgc3RyaW5nIGludG8gdGhlIHRyYWNlcG9pbnRzIGZvciBleGNoYW5nZV9pZCBh
bmQgc2V0Y2xpZW50aWQuDQo+IA0KPiBJZiB5b3UncmUgaW50ZXJlc3RlZCBpbiB0cm91Ymxlc2hv
b3RpbmcsIHdpcmUgY2FwdHVyZSdzIHVzdWFsbHkgdGhlIG1vc3QNCj4gaW5mb3JtYXRpdmUuICBJ
ZiB0aGUgbG9ja3VwIGV2ZW50cyBhbGwgaGFwcGVuIGF0IHRoZSBzYW1lIHRpbWUsIHRoZXJlDQo+
IG1pZ2h0IGJlIHNvbWUgbmV0d29yayBldmVudCB0aGF0IGlzIHRyaWdnZXJpbmcgdGhlIGlzc3Vl
Lg0KPiANCj4gWW91IHNob3VsZCBleHBlY3QgTkZTdjQuMSB0byBiZSByb2NrLXNvbGlkLiAgSXRz
IHJhcmUgd2UgaGF2ZSByZXBvcnRzDQo+IHRoYXQgaXQgaXNuJ3QsIGFuZCBJJ2QgbG92ZSB0byBr
bm93IHdoeSB5b3UncmUgaGF2aW5nIHRoZXNlIHByb2JsZW1zLg0KDQpJIGVjaG8gdGhhdDogTkZT
djQuMSBwcm90b2NvbCBhbmQgaW1wbGVtZW50YXRpb24gYXJlIG1hdHVyZSwgc28gaWYNCnRoZXJl
IGFyZSBvcGVyYXRpb25hbCBwcm9ibGVtcywgaXQgc2hvdWxkIGJlIHJvb3QtY2F1c2VkLg0KDQpO
RlN2NC4xIHVzZXMgYSB1bmlmb3JtIGNsaWVudCBJRC4gVGhhdCBzaG91bGQgYmUgdGhlICJnb29k
IiBvbmUsDQpub3QgdGhlIE5GU3Y0LjAgb25lIHRoYXQgaGFzIGEgbm9uLXplcm8gcHJvYmFiaWxp
dHkgb2YgY29sbGlzaW9uLg0KDQpDaGFybGVzLCBwbGVhc2UgbGV0IHVzIGtub3cgaWYgdGhlcmUg
YXJlIHBhcnRpY3VsYXIgd29ya2xvYWRzIHRoYXQNCnRyaWdnZXIgdGhlIGxvY2sgcmVjbGFpbSBm
YWlsdXJlLiBBIG5hcnJvdyByZXByb2R1Y2VyIHdvdWxkIGhlbHANCmdldCB0byB0aGUgcm9vdCBp
c3N1ZSBxdWlja2x5Lg0KDQoNCj4gQmVuDQo+IA0KPiBPbiAxMyBBcHIgMjAyMSwgYXQgMTE6Mzgs
IGhlZHJpY2tAcnV0Z2Vycy5lZHUgd3JvdGU6DQo+IA0KPj4gVGhlIHNlcnZlciBpcyB1YnVudHUg
MjAsIHdpdGggYSBaRlMgZmlsZSBzeXN0ZW0uDQo+PiANCj4+IEkgZG9u4oCZdCBzZXQgdGhlIHVu
aXF1ZSBJRC4gRG9jdW1lbnRhdGlvbiBjbGFpbXMgdGhhdCBpdCBpcyBzZXQgZnJvbSB0aGUgaG9z
dG5hbWUuIFRoZXkgd2lsbCBzdXJlbHkgYmUgdW5pcXVlLCBvciB0aGUgd2hvbGUgd29ybGQgd291
bGQgYmxvdyB1cC4gSG93IGNhbiBJIGNoZWNrIHRoZSBhY3R1YWwgdW5pcXVlIElEIGJlaW5nIHVz
ZWQ/IFRoZSBrZXJuZWwgcmVwb3J0cyBhIGJsYW5rIG9uZSwgYnV0IEkgdGhpbmsgdGhhdCBqdXN0
IG1lYW5zIHRvIHVzZSB0aGUgaG9zdG5hbWUuIFdlIGNvdWxkIG9idmlvdXNseSBzZXQgYSB1bmlx
dWUgb25lIGlmIHRoYXQgd291bGQgYmUgdXNlZnVsLg0KPj4gDQo+Pj4gT24gQXByIDEzLCAyMDIx
LCBhdCAxMTozNSBBTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4gSXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8ga25vdyB3aHkgeW91
ciBjbGllbnRzIGFyZSBmYWlsaW5nIHRvIHJlY2xhaW0gdGhlaXIgbG9ja3MuICBTb21ldGhpbmcg
aXMgbWlzY29uZmlndXJlZC4gIFdoYXQgc2VydmVyIGFyZSB5b3UgdXNpbmcsIGFuZCBpcyB0aGVy
ZSBhbnl0aGluZyBmYW5jeSBvbiB0aGUgc2VydmVyLXNpZGUgKGxpa2UgSEEpPyAgSXMgaXQgcG9z
c2libGUgdGhhdCB5b3UgaGF2ZSBjbGllbnRzIHdpdGggdGhlIHNhbWUgbmZzNF91bmlxdWVfaWQ/
DQo+Pj4gDQo+Pj4gQmVuDQo+Pj4gDQo+Pj4gT24gMTMgQXByIDIwMjEsIGF0IDExOjE3LCBoZWRy
aWNrQHJ1dGdlcnMuZWR1IHdyb3RlOg0KPj4+IA0KPj4+PiBtYW55LCB0aG91Z2ggbm90IGFsbCwg
b2YgdGhlIHByb2JsZW1zIGFyZSDigJxsb2NrIHJlY2xhaW0gZmFpbGVk4oCdLg0KPj4+PiANCj4+
Pj4+IE9uIEFwciAxMywgMjAyMSwgYXQgMTA6NTIgQU0sIFBhdHJpY2sgR29ldHogPHBnb2V0ekBt
YXRoLnV0ZXhhcy5lZHU+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJIHVzZSBORlMgNC4yIHdpdGgg
VWJ1bnR1IDE4LzIwIHdvcmtzdGF0aW9ucyBhbmQgVWJ1bnR1IDE4LzIwIHNlcnZlcnMgYW5kIGhh
dmVuJ3QgaGFkIGFueSBwcm9ibGVtcy4NCj4+Pj4+IA0KPj4+Pj4gQ2hlY2sgeW91ciBjb25maWd1
cmF0aW9uIGZpbGVzOyB0aGUgbGFzdCB0aW1lIEkgZXhwZXJpZW5jZWQgc29tZXRoaW5nIGxpa2Ug
dGhpcyBpdCdzIGJlY2F1c2UgSSBpbmFkdmVydGVudGx5IHVzZWQgdGhlIHNhbWUgZnNpZCBvbiB0
d28gZGlmZmVyZW50IGV4cG9ydHMuIEFsc28gcmVjb21tZW5kIGV4cG9ydGluZyB0b3AgbGV2ZWwg
ZGlyZWN0b3JpZXMgb25seS4gIEJpbmQgbW91bnQgZXZlcnl0aGluZyB5b3Ugd2FudCB0byBleHBv
cnQgaW50byAvc3J2L25mcyBhbmQgb25seSBleHBvcnQgdGhvc2UgZGlyZWN0b3JpZXMuIEFjY29y
ZGluZyB0byBCcnVjZSBGLiB0aGlzIGRvZXNuJ3QgYnV5IHlvdSBhbnkgc2VjdXJpdHkgKEkgc3Rp
bGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkpLCBidXQgaXQgbWFrZXMgZm9yIGEgY2xlYW5lciBzeXN0
ZW0gY29uZmlndXJhdGlvbi4NCj4+Pj4+IA0KPj4+Pj4gT24gNC8xMy8yMSA5OjMzIEFNLCBoZWRy
aWNrQHJ1dGdlcnMuZWR1IHdyb3RlOg0KPj4+Pj4+IEkgYW0gaW4gY2hhcmdlIG9mIGEgbGFyZ2Ug
Y29tcHV0ZXIgc2NpZW5jZSBkZXB0IGNvbXB1dGluZyBpbmZyYXN0cnVjdHVyZS4gV2UgaGF2ZSBh
IHZhcmlldHkgb2Ygc3R1ZGVudCBhbmQgZGV2ZWxvOXBtZW50IHVzZXJzLiBJZiB0aGVyZSBhcmUg
cHJvYmxlbXMgd2XigJlsbCBzZWUgdGhlbS4NCj4+Pj4+PiBXZSB1c2UgYW4gVWJ1bnR1IDIwIHNl
cnZlciwgd2l0aCBOVk1lIHN0b3JhZ2UuDQo+Pj4+Pj4gSeKAmXZlIGp1c3QgaGFkIHRvIG1vdmUg
Q2VudG9zIDcgYW5kIFVidW50dSAxOCB0byB1c2UgTkZTIDQuMC4gV2UgaGFkIGhhbmdzIHdpdGgg
TkZTIDQuMSBhbmQgNC4yLiBGaWxlcyB3b3VsZCBhcHBlYXIgdG8gYmUgbG9ja2VkLCBhbHRob3Vn
aCBldmVudHVhbGx5IHRoZSBsb2NrIHdvdWxkIHRpbWUgb3V0LiBJdOKAmXMgdG9vIHNvb24gdG8g
YmUgc3VyZSB0aGF0IG1vdmluZyBiYWNrIHRvIE5GUyA0LjAgd2lsbCBmaXggaXQuIE5leHQgaXMg
ZWl0aGVyIE5GUyAzIG9yIGRpc2FibGluZyBkZWxlZ2F0aW9ucyBvbiB0aGUgc2VydmVyLg0KPj4+
Pj4+IEFyZSB0aGVyZSBrbm93biB2ZXJzaW9ucyBvZiBORlMgdGhhdCBhcmUgc2FmZSB0byB1c2Ug
aW4gcHJvZHVjdGlvbiBmb3IgdmFyaW91cyBrZXJuZWwgdmVyc2lvbnM/IFRoZSBvbmUgd2XigJly
ZSBtb3N0IGludGVyZXN0ZWQgaW4gaXMgVWJ1bnR1IDIwLCB3aGljaCBjYW4gYmUgYW55dGhpbmcg
ZnJvbSA1LjQgdG8gNS44Lg0KPj4+IA0KPiANCj4gDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQoNCg==
