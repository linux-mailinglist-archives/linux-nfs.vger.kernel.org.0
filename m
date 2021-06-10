Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258343A2EA4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJOxe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:53:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhFJOxd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:53:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15AEkmQt030194;
        Thu, 10 Jun 2021 14:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=r5fPvMESuD8R8jKiNeU7jygEq5tdct/U8ucvjELp/ao=;
 b=dSok/hXTQeIGzl5o2mVJibAfIUoJRlQ0cDheYYg+tjA46SorJ7mf8lpkXFQXNuVzpkF/
 u5emyIwkHuZZ1kjbMN41nWv683FpNf6tiSJZTdx8TOQvEek97srFYrt+Q55V1A8kaFU2
 9oN9G71fjlH53c8DrB7+zusroHP5vvE5/eaQxU+ncxmHvZMEGCHPqikERrl2LCEPWYt0
 C7RblxqYFTMu9QY+rvKNG8rMXFiigJXtBncpWa4dSGQOaTNFhF5tP9zZJ11afHcryusp
 /1X4CPHlnaKEY9ylMypQOljTzuN18OUQ1JaAZLQ5I3K8jI8qPfs2SGUk9fK4jvT0HiP4 bg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3930d50dkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:51:28 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15AEnBIL002081;
        Thu, 10 Jun 2021 14:51:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3030.oracle.com with ESMTP id 38yxcwpvkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E94bYgTJHpjMrpZjpKdndr1jVi03CyUmH6zZeVclPZdhVmWGkW1LA4PO3BucMCzz3UR2kNCPpcn93sbA7AaT98xfe/kH/5SE3hm8aNunYOyyTvHrRQQaKHvzvNzwYHYIpRjgQpPSmpWifhl5QCBhCW3mPoBMzqEA1VCz/rghmjLdM8jSPyDUE9/dU+lPZoxNchnPCKX05x+2aMr3wdjUWTjPDmDJy3tz7lgcLggPBj/9gGTWlrAkGRjsubxZk0H4NR+tSAjnEP1wHVlg3W8nHlo59TCPfG6dQ//xlpmIuVLo7Lh0uQFo+sP0HrMphg9j36KkGy4X2SCPgLyGzv31OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5fPvMESuD8R8jKiNeU7jygEq5tdct/U8ucvjELp/ao=;
 b=Vo5rVaNDclKFzvFcPuPGOnlZ3hCZ2EXwGFfnytsz0b3z1VL2Z7pFyZa22ZdEQx4QdEn2KUvNIjMsaxjZLIwRC7LhfjkrHJ+K52/TExKewvJaTYmiX8xwKbsIYFR2+oJGh9fVIRlAeab35Hbbe+OdA0IoWefi2wEhaZEpRYuO61LzXfP9shJx33jbWM27jcQCy9dtVVy7c1I5e968doiYXM8HdA6//LzOCtJR6csLpj5YyHWM1CRTNyXDzSpZjxg1TbUoxIFDFTna+2NAzHD7xx6XU4q6vTRnJoaPezkPyfFsaIHhtglLYjp82LJL60ts9W+Y78c1rlwoNT5tAFYvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5fPvMESuD8R8jKiNeU7jygEq5tdct/U8ucvjELp/ao=;
 b=n9ndEY0e7iy4k6RO9TKtMceXO0gXW+FUEj1K0fVHB0wNpIC7hmKRqvG6XJ3sIa25qyXj73Gu0Slt1hHjFn6SiexzdPmR1935Ap2Fl7tGWa2A3x3JNAVX2PW6Bciz0q4sMBTTcXwyeFW5js/4ixMUF8LuxDRDGmnp3dizzEtPL94=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1837.namprd10.prod.outlook.com (2603:10b6:300:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 14:51:25 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 14:51:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXoN9xSEM+vT7E6aMlyo/90m26sNPoWAgAABLICAAAY6AIAACRaAgAAGNQA=
Date:   Thu, 10 Jun 2021 14:51:25 +0000
Message-ID: <1902AFD9-76B8-44F2-928C-C830CDFAA33B@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com>
 <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
 <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
 <CAN-5tyGKiT9NESQUq_PxUonf565jw7ENJUa=KmQDDiNGVB1ekg@mail.gmail.com>
In-Reply-To: <CAN-5tyGKiT9NESQUq_PxUonf565jw7ENJUa=KmQDDiNGVB1ekg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d01dda-6874-4e12-14ca-08d92c1f3874
x-ms-traffictypediagnostic: MWHPR10MB1837:
x-microsoft-antispam-prvs: <MWHPR10MB1837E23E158085DDD4B723B293359@MWHPR10MB1837.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1ReIYw5xe2LLCVcIbGErO2XRHgDdLgCUW2sjX5QoZYNahMkNIC+oN3cghTyl5ASNd+++zeveh+z9bbU2hdMGG0Gi1/WPIkhuezmN/FQAqVlunGua6q43G2/xhtbsawLlYNnok2ebNVepaJ3jPTER2Aqzd4+p99lPEer6AGyzfCCgMxeK3MaN221M9yZANP6NeP3bmMsDFpzZGFOSdkQyQSOV9OxGclLsxzu4x69TxhbMrrWSDHIQUX8Yg3ZY5usGoaLi99ddH4jogeS7eU+u4mZfuQMpQtCI/53EQnAe26CnV9zgdt//g1AmhhlR6EJAXPa82ZpMWuKcJt9C01DKAvAhBv+WqKeRsemUQVLQRG5nMY74cHo/0Q9mDjiah2YhLHpvXzE/yIysCaZHguP19ggMvei5a0wmtHiEJDtmG4et5gxdblzGy1388waBOPNM84lkH8YziXSsL2GgX91qF9zl3cFCPkFfVHHQbUcj5UPdrRtIx7/W9OlCrTC/U4/2EZm7jHq8bTb+C+yvHo/f19/tgIZm65+LudDFaq9XbqWbzsUUZfbqf/kPFSM2TqCzi6pNGARI7RJlaHmeTpa4LBLTd71WTg3Wfpusfm1YObhOzvtRblp2ucK+NlxaDRriTu4foRveWPk0FOF7TrKd8+kD7Z43cHi1XMcj7eqHMU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(36756003)(6512007)(4326008)(6486002)(316002)(2906002)(91956017)(6916009)(71200400001)(33656002)(76116006)(66446008)(66556008)(66476007)(66946007)(2616005)(8676002)(478600001)(64756008)(86362001)(6506007)(122000001)(38100700002)(54906003)(83380400001)(26005)(5660300002)(53546011)(186003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ORat/CsVH4apxnJ+/sI0vhC3Bmb/v2RqZNLedc5LRlPylCjhTdbur5RznrtO?=
 =?us-ascii?Q?DnL3CcuA3TesESYboOR0NHB8CZ+g3E8z4J/1n20H9gI54U4miznCblBcjE70?=
 =?us-ascii?Q?9tXGasjXwuy9tz6IxmvW2lcL3lqvApJFnDGixIw+dsBmUaBAW+539c892nAw?=
 =?us-ascii?Q?52ebKLbJjEuAs2wgLIOJSXZv+xlzKN1tkfhWrmTr7CjrqXQ/DI6vYChzG3ts?=
 =?us-ascii?Q?HuPSdDdvb2E/mMo1vfohGsIamfv5+cOfkpJl8e8+F4/SGVkEs+mPyeG/yh8R?=
 =?us-ascii?Q?04m0/sN1koCqt0NeMfafMHzTjImVgcOicSufO4DNqnpT4VOaBia9YPzwx/q9?=
 =?us-ascii?Q?fGtCyttnK44zDUvsMHW6jqcfp+MdJX788if/D0vKv8hBm9517U1Yi4tmI3ob?=
 =?us-ascii?Q?A+grGRuZ/6Ics4TOMCnzRZ+tS0jt3sNBzh3BwjtTW5LcYuwILtZQXI2Fd9wD?=
 =?us-ascii?Q?XUC57BkOgS31SWoRhSfrDBdktfE+SEM/HXQc9hEQZusjUio9v4kHzDzMeK5Q?=
 =?us-ascii?Q?SyIgtN39V551C7SR2FEp0C1SRPLJ9uqwpd54+3yRVTxWuIB9C9UKzna5CR9P?=
 =?us-ascii?Q?QSFSe1Lgp441Rycf49PFt8Z7V7+8KDK6eU5UZCAo4+seEESQDzmkSl0mG6Rx?=
 =?us-ascii?Q?WZ65Yli+PVms7vAUfDdLcQ+lHn1uxCxuIW8L6pj2o6GAbCwS34Tr5E43+gup?=
 =?us-ascii?Q?mdCGZjyba6583etJp4aOPyPlBQ/AhPepy9hwq6ez1h1E/A63Gtr4lmZZ64e1?=
 =?us-ascii?Q?TZJhljM5j38VRlknQZ6vJwxDPWYhkdUSDmCR52eMICVEInuxU/UXVsoRqZ5b?=
 =?us-ascii?Q?60JaeQRUEfXWPKY2hjeFo4ZwGDaGhxEXLUiOaggASb0WvtzkckK2HM/pom6j?=
 =?us-ascii?Q?TbDDSuoqfF/3jdJ8ONi+xrF60xi4XPUouyFdsoQKoY+bqV2OTX3TwLmEAUMx?=
 =?us-ascii?Q?zD/HjjwzTJWPy+CJqmF1LuFWqxNZ0+Awl3dwy6GVVmK+gr3kvKBgi9/j8haD?=
 =?us-ascii?Q?tVfYigAjNGFpHVFPbw13xhBfZTbMA3Wvp1KPO4O8SA6G++xyh3BpxrDW3Is9?=
 =?us-ascii?Q?Yu3fMpRSjIvkRKcPXXxi1YsrlUQhQupji6VXZyjH/Te1Lfhp67Th+uX0Nsht?=
 =?us-ascii?Q?UohJSYaAjTAyoHni5NFUsghKYmTo67ZzaU/8kfw3PfKwEDFXppChpeKt4P1f?=
 =?us-ascii?Q?aU4bwHbwk7pQo7s/KqZCwkWfcOwWJQ/8dhe1WZs94E90olkIidKgaxATQBfN?=
 =?us-ascii?Q?ZnMuvF/f5gzFfI1Q6e6wHBs6+uXBjdxQQKyNCU0CPTF5++YJHUTk8E7mrHcb?=
 =?us-ascii?Q?AkwjTixaS2XNdJXNtMHhR3Wf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C44882FF5F7C3940B03BC3FF5B06936A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d01dda-6874-4e12-14ca-08d92c1f3874
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 14:51:25.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpnS4V9PRNzsxu3SWFCuG/vtcDvPxpOdyUNDynFqXzQQB2X+6QS80QFK7gfxNcp7Ts4/erh3XYUUuYkNkR38uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100095
X-Proofpoint-ORIG-GUID: 1RVQGnuxeYgJDMBPfxwd_vH_XQ2LPlWT
X-Proofpoint-GUID: 1RVQGnuxeYgJDMBPfxwd_vH_XQ2LPlWT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 10, 2021, at 10:29 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Thu, Jun 10, 2021 at 9:56 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 10, 2021, at 9:34 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>>=20
>>> On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <
>>>>> olga.kornievskaia@gmail.com> wrote:
>>>>>=20
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>=20
>>>>> This option will control up to how many xprts can the client
>>>>> establish to the server. This patch parses the value and sets
>>>>> up structures that keep track of max_connect.
>>>>>=20
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>> fs/nfs/client.c           |  1 +
>>>>> fs/nfs/fs_context.c       |  8 ++++++++
>>>>> fs/nfs/internal.h         |  2 ++
>>>>> fs/nfs/nfs4client.c       | 12 ++++++++++--
>>>>> fs/nfs/super.c            |  2 ++
>>>>> include/linux/nfs_fs_sb.h |  1 +
>>>>> 6 files changed, 24 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>>>>> index 330f65727c45..486dec59972b 100644
>>>>> --- a/fs/nfs/client.c
>>>>> +++ b/fs/nfs/client.c
>>>>> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
>>>>> struct nfs_client_initdata *cl_init)
>>>>>=20
>>>>>        clp->cl_proto =3D cl_init->proto;
>>>>>        clp->cl_nconnect =3D cl_init->nconnect;
>>>>> +       clp->cl_max_connect =3D cl_init->max_connect ? cl_init-
>>>>>> max_connect : 1;
>>>>=20
>>>> So, 1 is the default setting, meaning the "add another transport"
>>>> facility is disabled by default. Would it be less surprising for
>>>> an admin to allow some extra connections by default?
>>>>=20
>>>>=20
>>>>>        clp->cl_net =3D get_net(cl_init->net);
>>>>>=20
>>>>>        clp->cl_principal =3D "*";
>>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>>> index d95c9a39bc70..cfbff7098f8e 100644
>>>>> --- a/fs/nfs/fs_context.c
>>>>> +++ b/fs/nfs/fs_context.c
>>>>> @@ -29,6 +29,7 @@
>>>>> #endif
>>>>>=20
>>>>> #define NFS_MAX_CONNECTIONS 16
>>>>> +#define NFS_MAX_TRANSPORTS 128
>>>>=20
>>>> This maximum seems excessive... again, there are diminishing
>>>> returns to adding more connections to the same server. what's
>>>> wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
>>>>=20
>>>> As always, I'm a little queasy about adding yet another mount
>>>> option. Are there real use cases where a whole-client setting
>>>> (like a sysfs attribute) would be inadequate? Is there a way
>>>> the client could figure out a reasonable maximum without a
>>>> human intervention, say, by counting the number of NICs on
>>>> the system?
>>>=20
>>> Oh, hell no! We're not tying anything to the number of NICs...
>>=20
>> That's a bit of an over-reaction. :-) A little more explanation
>> would be welcome. I mean, don't you expect someone to ask "How
>> do I pick a good value?" and someone might reasonably answer
>> "Well, start with the number of NICs on your client times 3" or
>> something like that.
>=20
> That's what I was thinking and thank you for at least considering that
> it's a reasonable answer.
>=20
>> IMO we're about to add another admin setting without understanding
>> how it will be used, how to select a good maximum value, or even
>> whether this maximum needs to be adjustable. In a previous e-mail
>> Olga has already demonstrated that it will be difficult to explain
>> how to use this setting with nconnect=3D.
>=20
> I agree that understanding on how it will be used is unknown or
> understood but I think nconnect and max_connect represent different
> capabilities. I agree that adding nconnect transports leads to
> diminishing returns after a certain (relatively low) number. However,
> I don't believe the same holds for when xprts are going over different
> NICs. Therefore I didn't think max_connect should have been bound by
> the same numbers as nconnect.

Thanks for reminding me, I had forgotten the distinction between
the two mount options.

I think there's more going on than just the NIC -- lock contention
on the client will also be a somewhat limiting factor, as will the
number of local CPUs and memory bandwidth. And as Trond points out,
the network topology between the client and server will also have
some impact.

And I'm trying to understand why an admin would want to turn off
the "add another xprt" mechanism -- ie, the lower bound. Why is
the default setting 1?


> Perhaps 128 is too high of a value (for
> reference I did 8 *nconnect_max).
>=20
>> Thus I would favor a (moderate) soldered-in maximum to start with,
>> and then as real world use cases arise, consider adding a tuning
>> mechanism based on actual requirements.
>=20
> Can you suggest a moderate number between 16 and 128?

16 is conservative, and there's nothing preventing us from changing
that maximum over time as we learn more.

An in-code comment explaining how the final maximum value was arrived
at would be good to add. Even "This is just a guess" would be valuable
to anyone in the future trying to figure out a new value, IMO.

--
Chuck Lever



