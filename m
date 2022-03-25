Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB74E7550
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 15:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358066AbiCYOrY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiCYOrX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 10:47:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A59D7639
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 07:45:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PEU2FL031953;
        Fri, 25 Mar 2022 14:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EdjYV6LX6kcyW0kWoVVqHtvfK/CmAH4nnjbQm41kwWM=;
 b=SKExNJclLEG/rYaU3A91hbwfdcgj7T+zaLSdXALE2xL76uu0bi0ZT3YYai7hk9lMvbN8
 jgFfkY0fDmQwXGTdxZCbF0+keEGJvpQawYcbhY5Q+rP04Ncu0TkygouoazXprxPuElX3
 TYN3lQinKnaIqWAKgoRtoDJklCIwBhJHXrjR9ia8PIjHtDD+RyBEdqFfVD3LMdyYe+lX
 1nhopghXEvU8d8UfgJWti9Zkg9R96lGwYwfPNAWxYqUv8hXeGLWQ8VKEVzdr1XX3y9ez
 M+pd0TlNQZo7/GUYLEzHx1ikXhx+XQI9DNnUKtvPNTEEz7bm+KIJN8v9BUUobWL4IVkq 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y27jxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 14:45:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22PEgY04112787;
        Fri, 25 Mar 2022 14:45:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3exawjh9xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 14:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dowsSAqnQHrvvcL1i8W2jZDAXjtW1+vUWIE6CGXekVqaC8BsXehlv9Ys8FVJ/0y0wKdlvoFLP0MXl3tr912b479BMLNinEub1HHBNMTAgDaCZqaqMtKRs9LQvhsLywNh2J8BHmELvF+o3bwn9W+6iylCau3QUttf9457H00TtlWLNYHkjGbxszumUKIBVrGH2TO7JCpvutZ9YUJID0l4ygZCcKDX/7r3iJ2/UiNoyQ0vX2TI9IZybpxi2rJBhyzrYMaMGmouGW13carCafhPp10sZOQtyCg55yYY1B5ypXIYu956gfvaam75xLxWtYoyZ8UWNzVqqZKvH855pJ9rdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdjYV6LX6kcyW0kWoVVqHtvfK/CmAH4nnjbQm41kwWM=;
 b=ZJqbq3a2vCy/5bUwuIQooyeTMgB3L3HDddtPJu0xQQ/SHy4BQfDIWO6R0yScMFbHUAEtISiOuBKfU9xoSnEdyWv78qPz5sV6ovSwvbJQzxO8tvSNN7Bi7RRMLYOhUHADCHAdYGV3J/jfkl195tZ9Ghuja8u2Y7/OUneAIGMmDm6zk7XufSv7vukFEYT04QKuNmkBKC52YzuA7ruT59zA800i3TeOOBeDdHLXWBbwznpSfWKPdEYh6lz+/uSzZSpox1YUMQlkvpF74RXF+em1L1nhqfthZvQG8IJJIakaKcrc0huH+W0TjVoGldTajm1d57BLNuCr43IlYelK7/Nw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjYV6LX6kcyW0kWoVVqHtvfK/CmAH4nnjbQm41kwWM=;
 b=rQO7zlmtTdqHqFO7ncVbNcn7nzZjfvRwTGaeSWnK+JKOHHp9geWs7S+SHqF90ky46kEJNwoNC4dxntz43fPD7t2lUz7OfTSEbABRZ4CEdEknQrkVCvEkCwAt12B/eGirCMTxXsIht8hQhxbJnrN7uhCa25a/stgqr8qVGv58uuA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 14:45:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 14:45:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Topic: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Index: AQHYP8uq2f68inC7SkKq9UfIdDsXqKzPI6sAgAAdL4CAADcRAIAAtnAA
Date:   Fri, 25 Mar 2022 14:45:31 +0000
Message-ID: <667BDBE6-1C69-421E-94B4-D6381DBA3416@oracle.com>
References: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
 <83b0b0292bda06ffa56487ea1a019ea142107fa3.camel@hammerspace.com>
 <E31250AB-636B-4AE6-8A31-69A3C26223EF@oracle.com>
 <6921be3a442479678c83199f1d42600b24f2b62e.camel@hammerspace.com>
In-Reply-To: <6921be3a442479678c83199f1d42600b24f2b62e.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bcfd6a4-b450-480a-85d2-08da0e6e1ccf
x-ms-traffictypediagnostic: SA2PR10MB4667:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4667902A3EB071662A9BF90F931A9@SA2PR10MB4667.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /g2sfFc29Uc+bri/Ehs24DmlTy39na4F5vU6I15dWiCX0mCtm9AyY5G/LOAA88UG3uGlSa9bH9Oez6lq3/9FIBazLmEX2ew2Y9pxfL72IGep3bRNdnx8f8Wydg5vykwnRBy7hcSK2/6r06zizU/GeRfCXR/QuLp89TZ3bdbERs4Im+yiXiJ5g94Sgw+1xeOT9WgdcJOlFNvevM6wRnUOo7776IWRoWNTVVEJH6m0XxUEx/XDrH9wQb8bTJEHlhZUlUVptb0mrhQe3M7Vm/uBI/8RRJ0sqg8Pj81a1Cw9UMzqzKkipdt5RtI6CxZhQQtRFMc0zXgR7cOPD+ov0T+QTbhdTapHUl56PzrKXU4Ha3Gdc+n+2a5/wUGt5igOu/ntJo9vptG0YuqLaIh1b7J5AxHW6uqLynCwtyhTIg4Iu5cwARymBVvvPBMS4gsCIxeMaCL9ELGVSoDVEZh237NjXrjVzj5F58aH6inKmoEufx2FLJcRlcidToiZAQ8qCH64KXWm4SwnSttr4/1oR6QN6fbnQXXk27fOJER93bzhzUFcNeQe9anpxWcZehEEXjSef2hqvFtt0X/kURCADQJ8TM42rMttA7U0G3YXEaW0UV1NkHFpVsClcGHn9ll2I2MK4xDoerXFdBD/r+HRrLDzRiL9gVid2xs8mSbjAzDTczan0ZRUkDkhRpjXYtkPMSCTayxRAIlPCwqHvn+33uSmv38cBSSoNHz/mJb0zf17DQgFEsrYlO5uh+j7rJr9g6ElK2VI4QdCkSw/8Z/JaCQfsHCNwn5I8GeRCv0SDEg2OT7qzUSTj1wFMVvjD3Pv5lYkQ1TEL9evHtqv81TqYQuudjBw4F8nCuqEm8Bpx6Eo5dU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6506007)(33656002)(66446008)(4326008)(83380400001)(66476007)(64756008)(6512007)(66946007)(66556008)(76116006)(53546011)(966005)(6486002)(26005)(508600001)(186003)(122000001)(71200400001)(8676002)(36756003)(2616005)(8936002)(316002)(91956017)(6916009)(38070700005)(2906002)(54906003)(5660300002)(86362001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zP4N5id9i3mfZgbgMW4C1kTR3N3kGitMeILpdZIaGCdXA0fysGN87Kp8q2J4?=
 =?us-ascii?Q?a8O/bDcgfmvoaJ04k//9gadiObazp/PjTD25aoJ4njPxQFQZN/7E7mPqbXSv?=
 =?us-ascii?Q?Sn82nSvAy6+CBlQkrbVVyMe45Tht1b1xmR0w1UwPSUDHQRShebI6MrN+JPQ8?=
 =?us-ascii?Q?R4B2iw1xfw2dDcP7jAFxE+G28Hj9lueD7ZBUcAqOJmjlXTgikz0jvUpnbx+O?=
 =?us-ascii?Q?TI7YHw6Hys2vGSZPeICWe8rChtqDNSwhRVduE7REukZXx/SnwLYFOEIwNrSx?=
 =?us-ascii?Q?P9KxjJdO0HlvtRyC8rL6yrhEDGQNIhLFJnxGZNAOJzaqNjawGdYqLlYwd6rH?=
 =?us-ascii?Q?NVIM6eZWz2V0enXb8hGERFOj+rJSFo5I+OowZNZ6KAJRKTqsCxwMZh89iKAD?=
 =?us-ascii?Q?UBL2LwSqRoqcoO7bRMFGgdQb/1KC3w8fMFRhuyq2M+1pcaTLkjn6Y55jHt/f?=
 =?us-ascii?Q?c5oxaifzWN2ksgG2I6kfDcgh81uP1cyU6M2lxEBOdRJPEe9hpvVmp58UTHWz?=
 =?us-ascii?Q?/AkwRv+DNoWlbYMbkSZoyOsAmYAJZWN6/OM+7dIdRKd1GLXO+b00vYoE4wle?=
 =?us-ascii?Q?5jTTT+0KHI7RredIEVunwXGg+EjCg01DNJCRAzx6It1bv+5P5s3vx28mDB8B?=
 =?us-ascii?Q?h9EXXBGQxH3awmKTek8kpNb3ISlV5PQMpFwUbBOydRdfJ/5vxM2AoKSBkyFO?=
 =?us-ascii?Q?zHer9Ecaq/Pz0sN3N45dOaDspaomF8leek67UmZcj/EgqSsRg/E9CSde/R11?=
 =?us-ascii?Q?zqwJN4sxZ8h16LSvtW+83hbWEecHqd0j8DDybzDIcSlA2OGHNTvAOJfqJYTc?=
 =?us-ascii?Q?0zwvn/5KIj8czCS2gYfypZ4s8YAPzGRHF6cUpPH8baNEkYX4G9Rre3IWlZsM?=
 =?us-ascii?Q?tWHWB79+lmwOG3pIjXQuBK0POswtH7oiWdhq0Ur+8fRyG/+Yr61JNKCdOeT9?=
 =?us-ascii?Q?VEdTT572iZrRSb3awSrC1r/W2rXiZ4T/aWJAF7IiGE9w3WCbeQk0vbUZdl83?=
 =?us-ascii?Q?PmnFnhJ2DTld2lKyrpBqCtk5odmxPozITLGpK/kZM8XFx4XjSgz8m2j4SXB0?=
 =?us-ascii?Q?JYME32SE7x2FDOHu+lLas/Sw8EvZmAtW1sPp36jnvQwdy0M2jh6aWPp3sCiS?=
 =?us-ascii?Q?K05V4IDlfcKsEeQl/MXlK6gNkYmCWuPovk0jUo7PkJY8X4gRB6T9s7ZuUOaq?=
 =?us-ascii?Q?NTTB4kbTg8qraM+M+2AmgvHNrssT8isBmnO/mHE5XspEsszeKPhZvftHIPf9?=
 =?us-ascii?Q?E9Gyx8cQbWx3U9ADVlqVwfwn0lO3JaB9P90/Io9o3+HPeMJLd9oCu4kgN3Vd?=
 =?us-ascii?Q?GfHpEuFUmiOc7TIxfDbqo+yUV2iCF8kmy9bJYqtuIb7pGMHttpeXN2P71OzR?=
 =?us-ascii?Q?YcfZJSW5hyKRhwVmW2kTjUWMrnWyHwnhkI/pAcSWShIcZnJ/IrSlcIJMCS1N?=
 =?us-ascii?Q?CETIF5dkKf4O8XqmppNps+2s7O+XfDULTI7S3lu7T7crRT8GpqVA8ysW3/uw?=
 =?us-ascii?Q?A/AqaRg8HD0st8g2nUt2/IUU8H3VpadecjBurIkkQKyJAVmC6UosRNj8Bep7?=
 =?us-ascii?Q?NbAPWZoJ0GO7B616m8K/pdtCVSiX0Z7Y8Rh1boT0zOsKxcVVN5H0Ieos35Y1?=
 =?us-ascii?Q?oQpzfUzLALHD0t6hgXzi1DdPuhBmvVewb3lfmeytRX5h412vGGEdsvkxSSm+?=
 =?us-ascii?Q?+GNaepfgD4vkCaoZ5HGRxtXV5Q7geatHuk9rWXudrMoJ/b5/uQ+a82WuizsF?=
 =?us-ascii?Q?Vhy43qnh6i1gA7XXvHP5vVMFvYBMmdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BCAB07BDBB902429481311C0E89939D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcfd6a4-b450-480a-85d2-08da0e6e1ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 14:45:31.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+RWla5JpYha/kIMzn+JbI9PvijIg4CAvazK0AFQrSa3JXbQCL2Bs+o1yT8AM2XY4YgX/pLdjlF/ySfPp71wAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250082
X-Proofpoint-GUID: wrx_DFETj4HvLGBcMnAn_T-txDmIUx-G
X-Proofpoint-ORIG-GUID: wrx_DFETj4HvLGBcMnAn_T-txDmIUx-G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2022, at 11:52 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Fri, 2022-03-25 at 00:35 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Mar 24, 2022, at 6:51 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2022-03-24 at 18:08 -0400, Chuck Lever wrote:
>>>> There have been reports of races that cause NFSv4 OPEN(CREATE) to
>>>> return an error even though the requested file was created. NFSv4
>>>> does not seem to provide a status code for this case.
>>>>=20
>>>> There are plenty of things that can go wrong between the
>>>> vfs_create() call in do_nfsd_create() and nfs4_vfs_get_file(),
>>>> but
>>>> one of them is another client looking up and modifying the file's
>>>> mode bits in that window. If that happens, the creator might lose
>>>> access to the file before it can be opened.
>>>>=20
>>>> Instead of opening the newly created file in
>>>> nfsd4_process_open2(),
>>>> open it as soon as the file is created, and leave it sitting in
>>>> the
>>>> file cache.
>>>>=20
>>>> This patch is not optimal, of course - we should replace the
>>>> vfs_create() call in do_nfsd_create() with a call that creates
>>>> the
>>>> file and returns a "struct file *" that can be planted
>>>> immediately
>>>> in nf->nf_file.
>>>>=20
>>>> But first, I would like to hear opinions about the approach
>>>> suggested above.
>>>>=20
>>>> BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D382
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/vfs.c |    9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>=20
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index 02a544645b52..80b568fa12f1 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -1410,6 +1410,7 @@ do_nfsd_create(struct svc_rqst *rqstp,
>>>> struct
>>>> svc_fh *fhp,
>>>>         __be32          err;
>>>>         int             host_err;
>>>>         __u32           v_mtime=3D0, v_atime=3D0;
>>>> +       struct nfsd_file *nf;
>>>> =20
>>>>         /* XXX: Shouldn't this be nfserr_inval? */
>>>>         err =3D nfserr_perm;
>>>> @@ -1535,6 +1536,14 @@ do_nfsd_create(struct svc_rqst *rqstp,
>>>> struct
>>>> svc_fh *fhp,
>>>>                 iap->ia_atime.tv_nsec =3D 0;
>>>>         }
>>>> =20
>>>> +       /* Attempt to instantiate a filecache entry while we
>>>> still
>>>> hold
>>>> +        * the parent's inode mutex. */
>>>> +       err =3D nfsd_file_acquire(rqstp, resfhp, NFSD_MAY_WRITE,
>>>> &nf);
>>>> +       if (err)
>>>> +               /* This would be bad */
>>>> +               goto out;
>>>> +       nfsd_file_put(nf);
>>>=20
>>> Why rely on the file cache to carry the nfsd_file? Isn't it much
>>> easier
>>> just to pass it back directly to the caller?
>>=20
>> My thought was that the "struct file *" has to end up in the
>> filecache anyway, even in the NFSv3 case. If I do this right,
>> I can avoid the subsequent call to nfsd_open_verified(), which
>> seems to be the source of the racy chmod behavior I mentioned
>> above. That might help NFSv3 too, which would need to recreate
>> the "struct file *" in nfsd_read() or nfsd_write() anyway.
>>=20
>>> There are only 2 callers of do_nfsd_create(), so you'd have
>>> nfsd3_proc_create() that will just call nfsd_file_put() as per
>>> above,
>>> whereas the NFSv4 specific do_open_lookup() could just stash it in
>>> the
>>> struct nfsd4_open so that it can get passed into
>>> do_open_permission()
>>> and eventually nfsd4_process_open2().
>>=20
>> Neither nfsd4_process_open2() or do_open_permission() seem
>> directly interested in the nfsd_file --- it's all under the
>> covers, in nfs4_get_vfs_file(). But yes, a "struct nfsd4_open"
>> is passed to and visible in nfs4_get_vfs_file(), as is the
>> open->op_created boolean.
>=20
> Having a nfsd_file in the file cache doesn't prevent anyone from
> changing the mode, owner and share access locks on the file before you
> can do the next set of permissions checks after dropping locks,

It's not meant to prevent those changes, but merely to ensure
that the open "struct file *" that was initially created is
the one used eventually in nfsd4_process_open2(). We don't
want to have to open one there -- it could be too late.


> nor
> does it even guarantee that you will still have an open descriptor when
> the call to nfsd4_process_open2() occurs.

Agreed, that's the rub. If there's no way to get the filecache
to always preserve that "struct file *", then explicitly
returning it from do_nfsd_create() seems like the only choice.

So now the problem is which VFS API should do_nfsd_create() use
instead of vfs_create() ? I haven't yet found a "create a file"
API that is EXPORTed and takes a dentry and returns a "struct
file *". At this point I'm not sure one currently exists.


--
Chuck Lever



