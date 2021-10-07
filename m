Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA8425B7D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJGT1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 15:27:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241176AbhJGT13 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 15:27:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197J2ug5028817;
        Thu, 7 Oct 2021 19:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fHPY+SQ7cuLKbWksEbpkaQ0Lf8AUYFkwSgA5iKUPI3w=;
 b=KCw/vh6Oz44pqcm5N/RmAAtrl7KJG/TMz//xruL8youCwIAqV0e6zyuV8BbFUFY490KE
 SCb8NzRcTDF/pz0NJaMuRvheVV/gkx8/Jt+LhuFcgN7DOihcynoICLCEdb/cAVYCzvfd
 5j1hIj3UM+Mtw0FnTEnr8cIkgDnPPwM2hnVw1xCydSpHF5xcxfijwJ1b7ZRSZfYjRA/5
 uqWL9OmjWlmVS6IO99cemZcsP4x3rQ+Z7SkH6VTf2sZ/g1Oex9wuL2Zv6jh8kqEsU12s
 0XPS2O6nlHMEqFjeLDbjqI21VEMmWDM558t9jU5hQ7LFtHB8Z9NQn/l6MwrApIy6bDzo KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj1eck2s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 19:25:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197JEoUY072869;
        Thu, 7 Oct 2021 19:25:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3bf16xbxmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 19:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4IfUqjuTtE4CaEcFkwkQgVM8NmVwQiRfR2t9864udN+1RyCwSrUUnaEJyddc5Vq6JEjIAm8BSsFzKhSbgeBwvnEo8l2EJ9uT1dY7V/A0IQyCZxJWmkLqxKvD++5ZAOMk+1szaiwBCoJJQHWc4GYqdM2EV9hXM7+7wdfJtMl0NpDQ3IGXHiDGbI6Kt6vMOQmNMHN6cRlaeDDHBbnsbaq7R2Q2p/sWw+CRrXAkVboZNBICrE+egXiuUcPWs1tRxB0P97p48+ezroN0odC+ccGltjZczUP5tnf2KRI6vKuajld782JBYxg11l5GzvmRdLENikF1SIcdECsp6hbsg4o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHPY+SQ7cuLKbWksEbpkaQ0Lf8AUYFkwSgA5iKUPI3w=;
 b=kNG5xgc/cLbQ63QMn/urzdWzRfcZAQVgEVOnyjY6Ub1t6hf+Jy4HyZl4S1tbq00BEdjpLv7DyHjEW5e2bdxXyGcCpdxK0qi5iNxnxGI2Wlb9W68pByYWUfUWS4a8quBiii3AiLtrsYa32gZOvTq9tre2NNOOdNOaICGApPuPYZ3kEXUkJ/I/+Rn4pljdfpEFXzm58cKdOzv9HyRWv9e3W9GyzkNeV8If+Rf+K7mV1sQ5eSK8qxMacR/zHavi2y7ckoWq06eTupOTwrTJhsEsjxmLzBy4B3EaGVq6dTpmLYSZbpngikMmVj7M1gI48phYz+m9BVmdDQWOihv2qtfKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHPY+SQ7cuLKbWksEbpkaQ0Lf8AUYFkwSgA5iKUPI3w=;
 b=Hlvz0c4ks3cnhikR83/0fwC9Wg8QSJ2ucOHXUTzxXnXlPCKJKo9S7Wu8ncrAIeNpoivOcV4zqooLp9986JKyynDYOKLwZ8+LSs6hKAotOBZTu5QQ4Ytfl5CZ79rOjPZSbZ8tiiwVNOZdU1k0ZEZBkrZuM1gc7Z8c+WAU3CY9RHc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5471.namprd10.prod.outlook.com (2603:10b6:a03:302::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 19:25:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:25:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Index: AQHXu5bQymWcB92tXEKQGjb5V/zVIKvHt8wAgAAwpYCAAAKMAA==
Date:   Thu, 7 Oct 2021 19:25:29 +0000
Message-ID: <F269CA7E-BBBD-4CBB-8C82-25B945D8C4BE@oracle.com>
References: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
 <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com>
 <CALF+zOm0Ey3iRyziN3TFHRZdXfDJwF1x3YuZuksLdvPdF8b0cQ@mail.gmail.com>
In-Reply-To: <CALF+zOm0Ey3iRyziN3TFHRZdXfDJwF1x3YuZuksLdvPdF8b0cQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e3b69c-8928-44c2-1ab1-08d989c83945
x-ms-traffictypediagnostic: SJ0PR10MB5471:
x-microsoft-antispam-prvs: <SJ0PR10MB54718A23469C7A3CDB60DDCA93B19@SJ0PR10MB5471.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:274;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RVaDnP8DW08DhHOXd++pTrs+KLKMvEhT1CaUbY59JTp/W8pkQaMY/wNAcKb8ScHzV6Khfo+voHevTrE/533Sb4XY9W98kx/wcnSqa6+avKjz+UOifZ+HUZ+k0vyxODJ0cSSXN/v12fBILNMmAj3PfsGAXn0AWYEWOdfOn8lopGMOjx9LlkGcFCwakJErfCkYyqXU8CenVLzXYmREV9KPtcVVMmAf51HOmhCp+kGQ7q0vsS3jo79wj9czQLMIY+Fv7HQ+Zf46mk9fl0fUhJydnEzHmhd5e9VVqUK0FMa9mmlVtkkAnOS4xUSRu3GBvowiLP7T2AXWasavqzqSeTBSp33+i9OqewjpyU5w8C5MhdDSdZKL4pLVSsqDI82Pui2NlWGpC1W6jdN+5AUlrnHxAe4+0U5BuPqNNuvWzI8y4OnxC/YgYU3SPK80K30SCE0df5z4SXlFQA1JjPX7pMseVbiUvbJHN5iMXnLGWeM4Nk3V5U44jQkAHa97mpWRrA8M2SqTIL3gdEQNC/C5dBJ9WALvdWUn8ofCD277RbmD0cCkiTCyjHFAjGi5wjdbHQ0KOHTbTChXAqOUdvtcK49PK6yXGLORnmTkMu6VSTdvIGL/no0d00qbMxPEuSlKGLO0qLyhuwGnVXVjWKcl3w3ixBIUrKtS1SFBZVn4sa6CUR5f2G6lI3e5TNAVgbR2qQKbUtAD4worZV9U8Ylj7mbhmdUsR0rEprYU91YHuexGwyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(5660300002)(38100700002)(26005)(186003)(86362001)(66476007)(8936002)(33656002)(64756008)(66556008)(66446008)(66946007)(6486002)(36756003)(71200400001)(2906002)(6512007)(83380400001)(2616005)(316002)(508600001)(8676002)(76116006)(38070700005)(4326008)(6916009)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i8dL98Bl5wugag7F3mUuW4l+8CfigvWWicVjdpkYFOUM729e1M/zcRtXrkWO?=
 =?us-ascii?Q?g2A6lM74YRUIf2wL1lubhWFiVwQv7dCOnVwu/tO97XHFXNYHvF6zQSVhhure?=
 =?us-ascii?Q?CXs1Ftg8htrcpjak5ZhfAo1pjvI2Ion1kvKuABmkEt9pahThreff/Ltwpa2j?=
 =?us-ascii?Q?IgEf7pH6lN46OwSo+S6WeZCndHhkVf/Hn5+AGv/Mjf9Eu+dY1p4/5zAssJON?=
 =?us-ascii?Q?yLXaTc6JLMN/Aiqhr9wwqwJAb8pkvI6GgMtE8XIrjL0EdkxqYUvE3rSkl2uN?=
 =?us-ascii?Q?m9rBj76A4xYOFXXxKfJkAmUbYnwUIQaEVugP/OuW499kMHVTEwKqjacovpx4?=
 =?us-ascii?Q?tgglYNJaaRZ3f0bd5UPgv/ZdaDdNiqIJ5vDu+QQ2fCMrQI92eebbM33iV6c4?=
 =?us-ascii?Q?E8TYfzsQPbc7m1wAOCXaZiU2GLvIRfSFNE6NZy07OgK8daO4OF5ID40QS5/D?=
 =?us-ascii?Q?3sDO7pe07jrd+prnPBJ1bSv5DN0QBk6WXgDZMiMqNkYsow62EyjkUJausucS?=
 =?us-ascii?Q?DTd7eTT3kl5erCCfYs65p3afeecMgK/wQrVUHgXBxtF6ejal+PpwKrSJSqqr?=
 =?us-ascii?Q?bPapteVdclRtPRlZAPC4Fu+L2iXRjYzs+DO+lQlXwe9yUnCZWbGlk1pxiZtT?=
 =?us-ascii?Q?5IIvkR6vyN5blg8o88rPmEutjeUBngUDmJ5FeWmrfcMMXLMSi64GA/B2L3Fh?=
 =?us-ascii?Q?+WAh059xCBUU2i5z++jcpsG7+MV4hlYJR951yJ4KoIQKZxEVnPuXPVsTOnsQ?=
 =?us-ascii?Q?8jGiNGcxunp+r16o6UTKu52/b5aes0arI3GvvOJr1RU8ncNEqNnmF5QhlmWE?=
 =?us-ascii?Q?4lmB9E0HwSwkQIWCvM+qJTS60GZo1gBnnJDc6UqvNoN5Xol4kPlbz/HZV37k?=
 =?us-ascii?Q?0m8PY1BHDXS+Fz/H5NzqByC1Vi40yb+y8MsU/pFMyvsT99LVQhunsFZYN60i?=
 =?us-ascii?Q?Pw50ZAJgkLMUAyu99bOiKdEsPIHwNIAA8U93ZgpNPHa9XVz+/uUterJZKhqa?=
 =?us-ascii?Q?K/tkZd8h1MoE0H6P6kZ5OCJdWcTbLjbcOCDrH5ijY2czR1DrQb2OgpL2kVhy?=
 =?us-ascii?Q?tCqvxe2+RLTQ9Z2+lZhfuZnGKK79TjB50/tilbtZkgDBuUAjWTI+L44mkE/V?=
 =?us-ascii?Q?cpxow4SsUnoGd3umyqB563hSBb3ZVnpIfud+qIAeibIWCM3zYONfbKdJPSkw?=
 =?us-ascii?Q?JlWV7Z/gjETbL05HHdbSnuAbT354nerx1WRJ3Enf5fL+USh4Df3OuvpDjKNo?=
 =?us-ascii?Q?3HjJQwHstEq6v/k6I8vqI361aBOQT2S/jEdQWIpy5P8/agUcG2IR7U7OhZ3Q?=
 =?us-ascii?Q?z9NPp+kv77iJbiJXT/0aO5ky?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2CA84CAB8C7314DBD26EAE3FCEEA01D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e3b69c-8928-44c2-1ab1-08d989c83945
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 19:25:29.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYQ9qiwLmPyIxi9Zy68ZdKDLX8dHebiPl34CGYsjmBi6/DlLUaHhpWjtAlTZP9beq+FM3cL7WWeKmC3XOt8c9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5471
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070125
X-Proofpoint-GUID: SH0a3yFWazu4I-M-ael2lhjR-jAuUeOH
X-Proofpoint-ORIG-GUID: SH0a3yFWazu4I-M-ael2lhjR-jAuUeOH
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2021, at 3:16 PM, David Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> On Thu, Oct 7, 2021 at 12:22 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Oct 7, 2021, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>> There are two new events that report slightly different information
>>> for readpage and readpages.
>>>=20
>>> For readpage:
>>>            fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 page_index=3D=
32
>>>=20
>>> The index of a synchronous single-page read is reported.
>>>=20
>>> For readpages:
>>>=20
>>>            fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
>>>=20
>>> The count of pages requested is reported. readpages does not wait
>>> for the READ requests to complete.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Well obviously I forgot to update the patch description.
>> I can send a v3 later to do that.
>>=20
>>=20
>=20
> Why not just call the tracepoints nfs_readpage and nfs_readpages?

Because there is already an nfs_readpage_done() tracepoint.


>>> ---
>>> fs/nfs/nfstrace.h |  146 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>> fs/nfs/read.c     |   11 ++--
>>> 2 files changed, 151 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>>> index e9be65b52bfe..85e67b326bcd 100644
>>> --- a/fs/nfs/nfstrace.h
>>> +++ b/fs/nfs/nfstrace.h
>>> @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
>>>              )
>>> );
>>>=20
>>> +TRACE_EVENT(nfs_aop_readpage,
>>> +             TP_PROTO(
>>> +                     const struct inode *inode,
>>> +                     struct page *page
>>> +             ),
>>> +
>>> +             TP_ARGS(inode, page),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(dev_t, dev)
>>> +                     __field(u32, fhandle)
>>> +                     __field(u64, fileid)
>>> +                     __field(u64, version)
>>> +                     __field(pgoff_t, index)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     const struct nfs_inode *nfsi =3D NFS_I(inode);
>>> +
>>> +                     __entry->dev =3D inode->i_sb->s_dev;
>>> +                     __entry->fileid =3D nfsi->fileid;
>>> +                     __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
>>> +                     __entry->version =3D inode_peek_iversion_raw(inod=
e);
>>> +                     __entry->index =3D page_index(page);
>>> +             ),
>>> +
>>> +             TP_printk(
>>> +                     "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=
=3D%llu page_index=3D%lu",
>>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
>>> +                     (unsigned long long)__entry->fileid,
>>> +                     __entry->fhandle, __entry->version,
>>> +                     __entry->index
>>> +             )
>>> +);
>>> +
>>> +TRACE_EVENT(nfs_aop_readpage_done,
>>> +             TP_PROTO(
>>> +                     const struct inode *inode,
>>> +                     struct page *page,
>>> +                     int ret
>>> +             ),
>>> +
>>> +             TP_ARGS(inode, page, ret),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(dev_t, dev)
>>> +                     __field(u32, fhandle)
>>> +                     __field(int, ret)
>>> +                     __field(u64, fileid)
>>> +                     __field(u64, version)
>>> +                     __field(pgoff_t, index)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     const struct nfs_inode *nfsi =3D NFS_I(inode);
>>> +
>>> +                     __entry->dev =3D inode->i_sb->s_dev;
>>> +                     __entry->fileid =3D nfsi->fileid;
>>> +                     __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
>>> +                     __entry->version =3D inode_peek_iversion_raw(inod=
e);
>>> +                     __entry->index =3D page_index(page);
>>> +                     __entry->ret =3D ret;
>>> +             ),
>>> +
>>> +             TP_printk(
>>> +                     "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=
=3D%llu page_index=3D%lu ret=3D%d",
>>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
>>> +                     (unsigned long long)__entry->fileid,
>>> +                     __entry->fhandle, __entry->version,
>>> +                     __entry->index, __entry->ret
>>> +             )
>>> +);
>>> +
>>> +TRACE_EVENT(nfs_aop_readahead,
>>> +             TP_PROTO(
>>> +                     const struct inode *inode,
>>> +                     unsigned int nr_pages
>>> +             ),
>>> +
>>> +             TP_ARGS(inode, nr_pages),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(dev_t, dev)
>>> +                     __field(u32, fhandle)
>>> +                     __field(u64, fileid)
>>> +                     __field(u64, version)
>>> +                     __field(unsigned int, nr_pages)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     const struct nfs_inode *nfsi =3D NFS_I(inode);
>>> +
>>> +                     __entry->dev =3D inode->i_sb->s_dev;
>>> +                     __entry->fileid =3D nfsi->fileid;
>>> +                     __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
>>> +                     __entry->version =3D inode_peek_iversion_raw(inod=
e);
>>> +                     __entry->nr_pages =3D nr_pages;
>>> +             ),
>>> +
>>> +             TP_printk(
>>> +                     "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=
=3D%llu nr_pages=3D%u",
>>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
>>> +                     (unsigned long long)__entry->fileid,
>>> +                     __entry->fhandle, __entry->version,
>>> +                     __entry->nr_pages
>>> +             )
>>> +);
>>> +
>>> +TRACE_EVENT(nfs_aop_readahead_done,
>>> +             TP_PROTO(
>>> +                     const struct inode *inode,
>>> +                     unsigned int nr_pages,
>>> +                     int ret
>>> +             ),
>>> +
>>> +             TP_ARGS(inode, nr_pages, ret),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(dev_t, dev)
>>> +                     __field(u32, fhandle)
>>> +                     __field(int, ret)
>>> +                     __field(u64, fileid)
>>> +                     __field(u64, version)
>>> +                     __field(unsigned int, nr_pages)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     const struct nfs_inode *nfsi =3D NFS_I(inode);
>>> +
>>> +                     __entry->dev =3D inode->i_sb->s_dev;
>>> +                     __entry->fileid =3D nfsi->fileid;
>>> +                     __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
>>> +                     __entry->version =3D inode_peek_iversion_raw(inod=
e);
>>> +                     __entry->nr_pages =3D nr_pages;
>>> +                     __entry->ret =3D ret;
>>> +             ),
>>> +
>>> +             TP_printk(
>>> +                     "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=
=3D%llu nr_pages=3D%u ret=3D%d",
>>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
>>> +                     (unsigned long long)__entry->fileid,
>>> +                     __entry->fhandle, __entry->version,
>>> +                     __entry->nr_pages, __entry->ret
>>> +             )
>>> +);
>>> +
>>> TRACE_EVENT(nfs_initiate_read,
>>>              TP_PROTO(
>>>                      const struct nfs_pgio_header *hdr
>>> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
>>> index 08d6cc57cbc3..c8273d4b12ad 100644
>>> --- a/fs/nfs/read.c
>>> +++ b/fs/nfs/read.c
>>> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *pa=
ge)
>>>      struct inode *inode =3D page_file_mapping(page)->host;
>>>      int ret;
>>>=20
>>> -     dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
>>> -             page, PAGE_SIZE, page_index(page));
>>> +     trace_nfs_aop_readpage(inode, page);
>>>      nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>>>=20
>>>      /*
>>> @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *p=
age)
>>>      }
>>> out:
>>>      put_nfs_open_context(desc.ctx);
>>> +     trace_nfs_aop_readpage_done(inode, page, ret);
>>>      return ret;
>>> out_unlock:
>>>      unlock_page(page);
>>> +     trace_nfs_aop_readpage_done(inode, page, ret);
>>>      return ret;
>>> }
>>>=20
>>> @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct addres=
s_space *mapping,
>>>      struct inode *inode =3D mapping->host;
>>>      int ret;
>>>=20
>>> -     dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
>>> -                     inode->i_sb->s_id,
>>> -                     (unsigned long long)NFS_FILEID(inode),
>>> -                     nr_pages);
>>> +     trace_nfs_aop_readahead(inode, nr_pages);
>>>      nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>>>=20
>>>      ret =3D -ESTALE;
>>> @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address=
_space *mapping,
>>> read_complete:
>>>      put_nfs_open_context(desc.ctx);
>>> out:
>>> +     trace_nfs_aop_readahead_done(inode, nr_pages, ret);
>>>      return ret;
>>> }
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



