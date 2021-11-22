Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1745945E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhKVR5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 12:57:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57686 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239611AbhKVR52 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 12:57:28 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMHij0r024246;
        Mon, 22 Nov 2021 17:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aippVvS7X9HZ+qkYsGmKUYVxWb4WCWDDz4vP9OeS5IY=;
 b=uzVurpm0/tErve2cNGl4vjQ7SoXNA1FzsXH4+XvS833VQwNln/jWFYS9riy+0SCs9z+4
 a6HvrvoKTwguUenGsYkAkRLYNDyUzi6ravPH6kjII0OW2IgvWl/YJXyp+nDUAvcQqKo0
 W5RVdiUqtbz2tr+nHi5PZEz/+Hj7jzgkmmgOqUki0BQq/TCQjrUIUzMSvmmEMpyUuuA4
 wrPJaQmXO8z3fXXFC6fTV+DoKp8QbDEd37lyhg0uWSwvMemMeI/Pws0VvMtGSi75+xT0
 jsjXXh8z3NpbaFTppXk7tRChwYnHunj6tFRBRG15iWzooKlXaJCVE1wCl2udEmwgmjrd 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gj3ny0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 17:54:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMHkYdr147102;
        Mon, 22 Nov 2021 17:54:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 3cep4x2mfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 17:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbEnllftlmMBW50ijFxXphxohbT1ClJwEOcA/+PBYpukuVB+/P7q8DGuJ6rXqA898UiVOSA9OLRE3ObRTvWiw45IOeEH7womr5KXOp/U4tfNOSc/BkZ8upSuN+dzh73j92XcTZagmkeqyYIlznZ1cwcS2rLLUt8a6skOvrWZmRND5+PMjklVXyPvkSUkkpyvNZ8Yk8OdnNyeALtDlKaAUR0jvo4LeQuPqq7YWNiSbtHFwyFtLYhrWw3h5BaS5iBRbujGy7zR5dngH1AJC6cB7s//RwS3eyfcWyS4qfsVo4J5px46r6/7T81g57caOPUiO6mDge49dUfFSGH+EQM+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aippVvS7X9HZ+qkYsGmKUYVxWb4WCWDDz4vP9OeS5IY=;
 b=n9oTfOfwOShY7yvKrZ/pSjfJmkI9en6PYZ3b4RzGPq0fbGlOHkvBmPekRCVQfaufxnTXTm9u9rOTKn/DkVmoE2v7x2n+gAno7FTFMkLnDk4quWaNqh8hIiDsl8arD6x5f16t8j158Uuwx8yraLRwmatYLzvVGP17xkUuLkirMHnJpKSaeZfceaBOsQa5tak+uO512Yflgpx7dAW469iogECFEe2b1parYKXNYJ3g101DN4fHXeEApgKerS0QYokptoBGmb08kjWNspMd96gq6SHEgPbmhPtzWXUxXLJMDl74LJi/s/Zt+2pKCvs95KvvFpwkm5T1UAxIvh7sV1igXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aippVvS7X9HZ+qkYsGmKUYVxWb4WCWDDz4vP9OeS5IY=;
 b=KJNENdpD+mKlNZ03eC+HIKmthazo5UPw26BslkiQKWWYLqsDwnBIBIFEJId5aH0BJawR/27vc4D8WKir4ySW1Ic72/2hR3eHD5X91x+mm2gqWZE031kVFcna0oYN1rravRQHSZVdIP3ASx8GenDsamDi56aGhZzWrb2oQgKTU6U=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3048.namprd10.prod.outlook.com (2603:10b6:a03:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 17:54:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 17:54:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Thread-Topic: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Thread-Index: AQHX3xH+VHtNadGKjEGmHrkZAM4DQ6wOyukAgAARgj+AAPlaAA==
Date:   Mon, 22 Nov 2021 17:54:13 +0000
Message-ID: <EDD6CB80-B8FE-4D3A-A4A0-AA21E6FBB4FF@oracle.com>
References: <163752463469.1397.703567874113623042.stgit@bazille.1015granger.net>
 <20211122015904.GH641268@paulmck-ThinkPad-P17-Gen-1>
 <087F6190-00D5-429F-94FD-EB8459635728@oracle.com>
In-Reply-To: <087F6190-00D5-429F-94FD-EB8459635728@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da352627-c478-4c04-0183-08d9ade11893
x-ms-traffictypediagnostic: BYAPR10MB3048:
x-microsoft-antispam-prvs: <BYAPR10MB304856F84ABF7B7B08C267ED939F9@BYAPR10MB3048.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WEvDISfsCSpaedUIbpio13vmhd7jlrPCiWWaihjdNWesST/AHiprszgSp20jr5lt5HsPKnDEfYhs6w3+qcqbBWf4DY6W+boFITugxfdTgKedMmOBBSmfkrh9/tf+SGsafghpw3d6/kooh1FnhCgp/s+ghSOrIxYCsSY+5VkBNWyibcyaTzySYT8qXAAS5/UQta1bBUiSxDkg40oUL3FhrJ5faVMpEPq7mBAtKQafPXmvbygF1hjpWJYdu/7OkwN5qNcqTXWA2FbF4JTni4p/SSwrgputlMin2ZgYK08kkYXnnoP//yBKaz5Iidy2brpu20nRrIdpE1+JbnO6e3mWnTbX2zPYa8rO5x7DwtdQFA4eddqxvb1H+I7Er6DxyW/t/MHNYGU5bfhsaKD7JKWyi5AGrq9wJu0oj+/KQ79TErWmonb49dPO57bOu2RCMxVGdT28TrCZMjGyu+AUqzw3veuTZzoCyqzQrgkC0EXWAZtejc8U4q6R2roPfraFwv06+sKasKHYeKnKjkw3RXIP+wjpDNanhjI06F75fXt1w30XclqaFu/iFJ/CAErhb30KqO9F7Kg6TttqYL1rgISl7tGwyDqhh3HaRCdwu/3QC3twUHIABxcBVylt1o+uzIsRTf6xG8bxFQ5lpfWs60l1dP2mDduzmqQCo78vyGoEvwXrGSqftnr/wdVfcxtJKO8dNvLCqxtD2rPD7sN2mQfpcL6fi5OF59m8rA3HtYnM4SvzTY/mFGz7GFm5GrechUOR0/Fw/R9Sp6V2YIvlfzsvt0y+8WRVrr85qQXiCaCIJ4L0cKx5oDcUsMG5AZ+STEpQf1D+15hPNRzv87l8uEbSX0tZ1Svcz1HqpfjTof8mZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(54906003)(316002)(6512007)(4326008)(122000001)(36756003)(91956017)(38100700002)(76116006)(33656002)(26005)(38070700005)(966005)(71200400001)(83380400001)(186003)(508600001)(86362001)(2616005)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(8936002)(2906002)(53546011)(6916009)(6506007)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NWM0ZmZjhucFBEZmhvUGp2b2dpMHFMQzJQSDNXT1BwdFdLc2poOUVZSG04?=
 =?utf-8?B?L0l4UTZnRVduZWlSZzcwRGtmenE2SmphTFRsbm5nZG1HcmtDUEFodkZWVHdn?=
 =?utf-8?B?NXpGNkRwNFdGaER1N3RmLzY3YmN3cXJ6Y3hXU2NZcUxBMGxzUHZSRWx4Ynlx?=
 =?utf-8?B?aFAyVXZYa3RjcjVuWDJMeHQrK0hxdXFZQWJiZEtMNFdsOG5ZRUU4Zy94clZt?=
 =?utf-8?B?Vk1iNWV4SFZUeDRnZ3ppR0U5N2xOb1pydUU5Kzh6emIzajFtOWhPMkthSFZk?=
 =?utf-8?B?QStQUlJrWlJNdkdzdmxuSDZIL2Y1bi9VSjV3MlJOdS9PR1FWanMvWmxxYmlh?=
 =?utf-8?B?R0tUamZVb2VmaEcxcVZNWUVtSzVtZnFHVWV4NHdBL3JvaC9zRFZNd1dJdTcy?=
 =?utf-8?B?VldGWWF6NU83WGtRa3VNNnh6dDBnN2p5Vlhlclp4V0sxb1hDUVVnOHJubEdp?=
 =?utf-8?B?dEc5NE5MN2pMaC91eUVCblN4bkh6cUptV3ZtWkw1S21pQWpualRqY1h6MGtt?=
 =?utf-8?B?REhPN0hsakcwWktVS0ZkMFl5V0I1d2htMkhodUZ1Yy8yWnNkNi9ibU5hR1Y5?=
 =?utf-8?B?TGpob1E1alpQWk1HVitQYlMyeHhFTzh3Yy94UGNoM2JSTU56MTRHVWk5dnZE?=
 =?utf-8?B?ZHZRaWJBVWF0QW1xNlBTVm1UVGx6QnVUeG5ENGNPVmdMWktOZllrWlIzUFd1?=
 =?utf-8?B?M3Ryb01FUGl0ZlFBcHcvdk8razhoT1JQM054WkIrUHlkbm92WGxTYWZQMndZ?=
 =?utf-8?B?c21pTk00b3N4UnFEaDU4WFdlM3ZUczdKTVhQNWplZWtGR0VpUTdpeDAxT3ZT?=
 =?utf-8?B?N2FGNlFTZ09aTzBJdGlLNTRyZlBic093cmlPQXllRUhsM3ZzcEpHRy9hNFNV?=
 =?utf-8?B?R1lLOTgrNnJJZStjYk5DdDMzQTd1NWhOTUhGc0MrWnpIcVJiazdxTzdzNTU4?=
 =?utf-8?B?dytGeEJiSnhtdy9SMDF5K0cxYzF6QjB5K1hZenlxVGRaVkRMZldaNHh5cklm?=
 =?utf-8?B?ZFhwc1Z1WmZueTUrRTBieTE0VDhjdmoyUlRvTDJIbytpaWVMK2dsbU5qUXBB?=
 =?utf-8?B?STNwUG1zemdqV2tNek9zMUVXSGZFRjZNclh2dGVqMWNyaTFzZk53K0xlRzRv?=
 =?utf-8?B?QzdUMUhndklFOXcvNVhoQm9kL08vYUFGWkgzZEpmWnFKazd6eXJoaXhpUnpS?=
 =?utf-8?B?RG1SMlVKYTV0eDhkNzJzZmNPTEpSbkMyVTl2UDhRMmlXMlJNTFVJTjh3SkhN?=
 =?utf-8?B?YjZzeWloOVoxWjYyb3AyQncwc0Y5RnlsQXJrRStJZGVkOGhuN1R5dkwvNldE?=
 =?utf-8?B?NXV2ZGdhZGRlWENhU0VzZVQvNFVxUzFzN3JlNElURExuQUtYZmlaNUdZRTZ6?=
 =?utf-8?B?c081Y0Q1WjZORkZLMVg2VnBwVW9YMGRmNTNWZzNzVUZvSi85TEsyWUlTZkp4?=
 =?utf-8?B?YTYzVnpGYzBxOTExV1NSdFBObXpaeXhPRXo4ZGJ3SnVvMFNvSGx3R3ZLY1Zu?=
 =?utf-8?B?a1JrbUlwRzZ5bnM1RTFRdUZCWFJUQXFKOThTWlVaR3ErZTFVbWd3Qm1SNnM2?=
 =?utf-8?B?T1FOc1RYUTdVQzJkNmphV21JM3M3R2pjaUY3MGtieldIbytpWDdBRDlIdDFQ?=
 =?utf-8?B?d3E0OEdiM1MyZndJU213QlBrcjdsNUxpVWxUY01rUGovajlKRUZvWlRIalJp?=
 =?utf-8?B?T0YvUG5XL0h5ZGhpNHEwZ3dCMDdFcGNzZHl0eDl0NzJzRFhxUEQ0cE9BSEhr?=
 =?utf-8?B?Rmx1YTBXRnVQc1M5VjFIRXp0WGdhcCtBbTNQNEZ5SDNXQ3dEVEZmV1ExcW1O?=
 =?utf-8?B?QnVvZ291MldLbFRqRUIrQjBNUXc3Uk5JRnZrMUVCdEVnRzNVcU1ob1c3cHRQ?=
 =?utf-8?B?bURYMEY3emJNaWJNclRUR1dsOUtsUElPN0NwZk0wVzdYSklubUo2clBXcUZq?=
 =?utf-8?B?M1FlK3Exb2tjN1NkY1FDT3JsNVdJZGJ1S3N2MlgxKys5d0lNbW8wMDJTc0Fs?=
 =?utf-8?B?MHRmREI5RE1abVdHUlB0UjF5RldTNGlNRW5xYWhxSUJzMzNoanM4WDY4dVhE?=
 =?utf-8?B?UE9GTkJqaWQ3QmlCaWY3UDF1aHpmYnZBSXRLNTNuTDlIRHh3UWtJamx3Yjg4?=
 =?utf-8?B?enphVEFmTUR0RktTYWtRNjIvcHdMVHc3MDZDNzk4UkhJdXZPNTA1MXpSWVp2?=
 =?utf-8?Q?V1a8wjxkf8ScOG56+F0nKC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AAF13C22EAE0A4DA26C7DF421F4401D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da352627-c478-4c04-0183-08d9ade11893
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 17:54:13.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xr0BrmC9mtLwE5lZTW4O8IU2bZ+MRxwk185obVxJz/ddIa2JeCg40GHpr15BYbNEDlr2CzrafK8DgPzVT4RWSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3048
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220091
X-Proofpoint-GUID: v4ISj2HHCSzLxnqxK-HPZkjhegp12ozc
X-Proofpoint-ORIG-GUID: v4ISj2HHCSzLxnqxK-HPZkjhegp12ozc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDIxLCAyMDIxLCBhdCAxMDowMSBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiANCj4+IE9uIE5vdiAyMSwgMjAyMSwg
YXQgODo1OSBQTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPiB3cm90ZToN
Cj4+IA0KPj4g77u/T24gU3VuLCBOb3YgMjEsIDIwMjEgYXQgMDI6NTc6MTRQTSAtMDUwMCwgQ2h1
Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gVG8gYWRkcmVzcyB0aGlzIGVycm9yOg0KPj4+IA0KPj4+IEND
IFtNXSAgZnMvbmZzZC9maWxlY2FjaGUubw0KPj4+IENIRUNLICAgL2hvbWUvY2VsL3NyYy9saW51
eC9saW51eC9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+Pj4gL2hvbWUvY2VsL3NyYy9saW51eC9saW51
eC9mcy9uZnNkL2ZpbGVjYWNoZS5jOjc3Mjo5OiBlcnJvcjogaW5jb21wYXRpYmxlIHR5cGVzIGlu
IGNvbXBhcmlzb24gZXhwcmVzc2lvbiAoZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzKToNCj4+PiAv
aG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4L2ZzL25mc2QvZmlsZWNhY2hlLmM6NzcyOjk6ICAgIHN0
cnVjdCBuZXQgW25vZGVyZWZdIF9fcmN1ICoNCj4+PiAvaG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4
L2ZzL25mc2QvZmlsZWNhY2hlLmM6NzcyOjk6ICAgIHN0cnVjdCBuZXQgKg0KPj4+IA0KPj4+IFRo
ZSAibmV0IiBmaWVsZCBpbiBzdHJ1Y3QgbmZzZF9mY2FjaGVfZGlzcG9zYWwgaXMgbm90IGFubm90
YXRlZCBhcw0KPj4+IHJlcXVpcmluZyBhbiBSQ1UgYXNzaWdubWVudC4NCj4+IA0KPj4gSSBhbSBu
b3QgaW1tZWRpYXRlbHkgc2VlaW5nIHRoaXMgZmllbGQgaW5kaXJlY3RlZCB0aHJvdWdoIGJ5IFJD
VSByZWFkZXJzLA0KPj4gdGhvdWdoIG1heWJlIHRoYXQgaXMgaGFwcGVuaW5nIGluIHNvbWUgb3Ro
ZXIgZmlsZS4NCj4+IA0KPj4gSG93ZXZlciwgaXQgZG9lcyBsb29rIGxpa2UgdGhpcyBmaWVsZCBp
cyBiZWluZyBhY2Nlc3NlZCBsb2NrbGVzc2x5IGJ5DQo+PiByZWFkLXNpZGUgY29kZS4gIFdoYXQg
cHJldmVudHMgdGhlIGNvbXBpbGVyIGZyb20gYXBwbHlpbmcgdW5mb3J0dW5hdGUNCj4+IG9wdGlt
aXphdGlvbnM/DQo+PiANCj4+IFNlZSB0b29scy9tZW1vcnktbW9kZWwvRG9jdW1lbnRhdGlvbi9h
Y2Nlc3MtbWFya2luZy50eHQgaW4gYSByZWNlbnQNCj4+IGtlcm5lbCBvciB0aGVzZSBMV04gYXJ0
aWNsZXM6IGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy84MTY4NTQgYW5kDQo+PiBodHRwczovL2x3
bi5uZXQvQXJ0aWNsZXMvNzkzMjUzLg0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IFRoYW54LCBQYXVsDQo+IA0KPiBUaGFuayB5b3UsIFBhdWwuIEnigJlsbCBsb29rIGludG8gaXQu
DQo+IA0KPiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3Jh
Y2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBmcy9uZnNkL2ZpbGVjYWNoZS5jIHwgICAgMiArLQ0KPj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+
IGRpZmYgLS1naXQgYS9mcy9uZnNkL2ZpbGVjYWNoZS5jIGIvZnMvbmZzZC9maWxlY2FjaGUuYw0K
Pj4+IGluZGV4IGZkZjg5ZmNmMWEwYy4uM2ZhMTcyZjg2NDQxIDEwMDY0NA0KPj4+IC0tLSBhL2Zz
L25mc2QvZmlsZWNhY2hlLmMNCj4+PiArKysgYi9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+Pj4gQEAg
LTc3Miw3ICs3NzIsNyBAQCBuZnNkX2FsbG9jX2ZjYWNoZV9kaXNwb3NhbChzdHJ1Y3QgbmV0ICpu
ZXQpDQo+Pj4gc3RhdGljIHZvaWQNCj4+PiBuZnNkX2ZyZWVfZmNhY2hlX2Rpc3Bvc2FsKHN0cnVj
dCBuZnNkX2ZjYWNoZV9kaXNwb3NhbCAqbCkNCj4+PiB7DQo+Pj4gLSAgICByY3VfYXNzaWduX3Bv
aW50ZXIobC0+bmV0LCBOVUxMKTsNCg0KSGkgVHJvbmQsDQoNCjk1NDJlNmE2NDNmYyAoIm5mc2Q6
IENvbnRhaW5lcmlzZSBmaWxlY2FjaGUgbGF1bmRyZXR0ZSIpIGFkZGVkDQphbiByY3VfYXNzaWdu
X3BvaW50ZXIoKSBmb3IgYSBmaWVsZCB0aGF0IGlzIG5vdCBhbm5vdGF0ZWQgd2l0aA0KX19yY3Uu
DQoNCmwtPm5ldCBpcyBhc3NpZ25lZCBhbmQgY29tcGFyZWQgb25seSB0byBhIG5vbi1SQ1UgInN0
cnVjdCBuZXQgKiINCnZhbHVlLiBDYW4geW91IHNheSB3aHkgeW91IGJlbGlldmUgcmN1X2Fzc2ln
bl9wb2ludGVyKCkgaXMNCm5lY2Vzc2FyeSBoZXJlPw0KDQoNCj4+PiArICAgIGwtPm5ldCA9IE5V
TEw7DQo+Pj4gICBjYW5jZWxfd29ya19zeW5jKCZsLT53b3JrKTsNCj4+PiAgIG5mc2RfZmlsZV9k
aXNwb3NlX2xpc3QoJmwtPmZyZWVtZSk7DQo+Pj4gICBrZnJlZV9yY3UobCwgcmN1KTsNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0KDQo=
