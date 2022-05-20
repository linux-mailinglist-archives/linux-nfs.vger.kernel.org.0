Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D367752EF06
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350725AbiETPXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350750AbiETPXK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 11:23:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E3A1778B7
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 08:23:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KDTAti023717;
        Fri, 20 May 2022 15:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MkqYX1DuUoDQCvfLsZN33lwHvUVNmoLTz9JZpHW8t1w=;
 b=T/TlRVELDr0jSr2LqZXuhYWn/uyZvcFY+t/LIfKGY4G7yh8RxHmXYdigqSdZFbR5ZvgJ
 o3TAFu5uy1P6U6LJPgPOcAWe4LukKYsT8Rn1kF2icIaW6HXUc06SS1NV5NgCcomDy8ti
 CfUsPn3JCVFf78aYTKzjzCINUYP3ikBRwaZvU5lcM2WlTIdGC3AEPf2NmT+ZWy95MihC
 hTDDvWIMNQUyP+Z0Oj/tGWEYNgyjl6v8zzEiaF55DxVtichZYN8aFztcrTnhpGiAp2oQ
 1syNA/H+jS1Ssgcgo0ANw2TNimcQjIf7YvGarGmblCEsxypvnnIWrLix8fNCQSYepyF1 Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucew6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:22:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KF1U6c018748;
        Fri, 20 May 2022 15:22:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v6d7yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIhLAgmjCVBeTIW/jU+OhXy8f06TnUMrvot4tBiceDkzI0/J9lXK1Tlv/wj1QulHypUOjzmF3SRWYMGjTz9CBbJ0nFls1pQcgqjPkw9WeqMzG9K2P+1zVG0PI2ouRKfb/A+UNCzAhzBUxJe9irOVeK4TwpxoVe0Ub9oDwHPbxt89rbj4C4lXj7V7SrCqZSGzxUT19qLj2Gb0r/Zv4ZoETCXRvbXtNrDpHFwZhF3UqbUMHpep8K5HH7TORle5ZmT7aHlAecijyHLNgZ5Jq2xa5AlF1uAIYm7CD79RGO7Dh66ebXLRo1/QmMomJUma2tg3vyv5uQmywISs5P3875VFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkqYX1DuUoDQCvfLsZN33lwHvUVNmoLTz9JZpHW8t1w=;
 b=PejME6yp74+QgAyx45h3fgAd8kMp1R8Quv05ahQIM62wfiwak8SjGqu0c5E093zUKK6/EYzuoIUOZ/KC5nRINKBj+IKHZaKaXjmyfrspwiwMtrMChPUMZJd26lCKLQAOlNH5oFld+htHzAzkf67eEEzrIXSEQtZBXkAYXhGK2kApr82fn9S8ZOfYbJKvp91YqZ1z6jG/beq2qkyl4VTQJCDHzXkbEZFQsiNsvGNlxQHiOxuY6Hghxm6tfxIHdbCEp2p/daQZOFTLnLRMMFdZxAGELjOkKWrdbyj1YHgITgz66uPRMMUDaE44ZwQRDp7jiDguXZjj7LoetaDAFDex6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkqYX1DuUoDQCvfLsZN33lwHvUVNmoLTz9JZpHW8t1w=;
 b=WwpIOKVRCOltsJuhBMa/x/4S1i5Sssb5nz9ne3ufXXZh4K89lFunYbpPvod2hBAoDGz1+ghrjGJgC0gzaBW13sCVNVtgrNlACrCeUzFNtzk7nHbNij9DY1GP+YIpLKy1zaevskWzlkVBcEpBoJOdWNLq++O4e6jQq6ZfhkvbGrE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Fri, 20 May 2022 15:22:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 15:22:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "luomeng12@huawei.com" <luomeng12@huawei.com>
Subject: Re: [PATCH] nfsd: Fix null-ptr-deref in nfsd_fill_super()
Thread-Topic: [PATCH] nfsd: Fix null-ptr-deref in nfsd_fill_super()
Thread-Index: AQHYa+t1veW/n8zz1U6eDJiqYomDp60n4xgA
Date:   Fri, 20 May 2022 15:22:51 +0000
Message-ID: <EB2E6FAD-AEC6-48B4-AC02-634941D80687@oracle.com>
References: <20220520023106.6651-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20220520023106.6651-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d14a3c39-2ffd-421d-c83e-08da3a749b1d
x-ms-traffictypediagnostic: DM4PR10MB6016:EE_
x-microsoft-antispam-prvs: <DM4PR10MB601633A9B49FE496F31BBBE693D39@DM4PR10MB6016.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/q2Y7Sp3Y5eQPqFBsAaYeMXklhOuqi4bh+bbfF9GTclIxvsabPLm6prd6TMRg/EHpOn5S2TX60T8JQwp+gbFn4Mnc3EVmz+zc2ITr1kLqx1rewqPYe+apT0jN03PhrqgcvKv7G+CfZVsAUHOfatOoHxjIOt3GcMUeQlcbSw/ui0I42QPqGpvrcgh3D5x25CwwvOtS+roDV7YChRl0kp5HUYM2jJyq4ZmgdgnWDvfu+LeqoyiBd8pfH/PnX032z8zeFmrkoPXA0RbU7re1V1HlHWlWhBxj3PeRHX53Yab9s0HmqsbFoGBdrZPTEdMGD+P+o3akGCiXN0jN2ho8jP0AFqJUKinzi76g4e2IkS9yUPGsbcn94IAalQTDCo45p2DjYMJFY1AJ1RpO34tsnGON/evViFHz30fiqpK8jydgOcp76avdglQT3in73gi7zpvjCfdi/+c5rMrueWhnSG20a/ulWBuG0HGV1ihY4GR4fwmp4ribT2dWGxdVAw4uERn05zdyedkZdEE+gFkRANA6i2EryovpY9lryL65zL1H0Iw1xc32RVKMxqiNU9gAWgf7QKbWKtli+tHjwaNqHaXOn2IsWkCbZaHR5K03TGoyeyHU0vWCSyUzO2foE95LdEuVkSrJiI9SaddGtdlfFiIKthljPO9YQEXTUr40x+J6TLgUvODnhYU2xZVpjIk+A5b6nO3WIThlUuBPbjKslpW2fs1p452wjoOWLGBSvi4x7gUO1I83fCO3Dcm1TPwUZ9+wsFgI+gG16ZuredsbC3S6TSf19N/9vsWofwiIcmumy2ah6nzQSxNNwKSYnccUgO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(64756008)(2906002)(54906003)(76116006)(186003)(2616005)(36756003)(91956017)(110136005)(316002)(66446008)(4326008)(8676002)(38100700002)(8936002)(5660300002)(33656002)(122000001)(6486002)(53546011)(84970400001)(6512007)(26005)(508600001)(6506007)(966005)(38070700005)(83380400001)(71200400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sGp+GLkU3k8t6/Aj6gy2Ixu8lWjdRyTK5WIq3TtCeKR7vKC+f55nvHYtXOOU?=
 =?us-ascii?Q?UfwY3gXeIyWkIirXP/sVfWzleHccMI3H6fh/ZhbC24IIvmaMgPWGQOVkfEEo?=
 =?us-ascii?Q?0mmo2kc/49dBcsHHUNj5cl/G3tE4DDyFxI/ZYW4+hSkl+jjY8vm0T+x/ONAa?=
 =?us-ascii?Q?Bk6dDQYwKIzkGsklmsWGuWbCL/R56VoktUGjLvXpIPOoDO97t/3M60fS/yZZ?=
 =?us-ascii?Q?q0bQaXpStQT9vp50h1ZBIySHguIHuvgUywqRZ+BquY5XtV8ALbEeLkiiDBlz?=
 =?us-ascii?Q?lM610F3nL2uvvSlsm2h9Tq6Cg1vo+884UOpPjJQdSs4RQUrzTGOCeI/n8Nyd?=
 =?us-ascii?Q?D7BNsILw17fS3UXBaVLGSosJxIlveTLGCC+37Ib8tVPw2p65WCKq4ruFKiCP?=
 =?us-ascii?Q?CVDpw8KWZRD3l4+OBBwV0SqqQOjfxSExtJvkrdxx9w1JCQJmRtcwVtLnpyn2?=
 =?us-ascii?Q?lDX7e/CL2M8WZtHycYMBgUIS8Hvhn0zpSNxhiPMHXmh/u+mXEPhKUXy45f3j?=
 =?us-ascii?Q?uV5zT/gePNjiPuS1fO9dhdqRnoJkCyutUu8luHa3c8eN1psf42wSEZTufCdM?=
 =?us-ascii?Q?g9Lo6Jwe5tGuiB9XifNoz0SWHzcfwOpxSjuoc8fXqvbMNufH1sbRnCUrTMQa?=
 =?us-ascii?Q?0N453Uos0TolWkUH13d2nbWkUT8/ZSXtgIfG7Vxj4TTL3pK52jmInxxiE/07?=
 =?us-ascii?Q?3XzBsqcYfDg67rD4716oG2wb3pI1stQi4eOiO3wPw2DNhFwuYI+OWhDxh2sN?=
 =?us-ascii?Q?JcUL5kqlyQyFKLnmYnmvOCRZ65lNJcBBXOEiC+VrjjtrQhpG4hVFOid0y5/5?=
 =?us-ascii?Q?+Df0DLBZ+S+28zbXINqKioTyTbd3Z1D35j58ehi4mBc2xTJzVvSpdK36MYQ7?=
 =?us-ascii?Q?IDUnA++pD96fFvGYnJxUvqrc1GEAi/br8bmCAoKyz1szlNEw2SpDxPEQU7aa?=
 =?us-ascii?Q?83L0FXhcqEJmfyI17+G2WYXeauJo8QmJyFDWKtDgk6fll8LtyNvJyOFShYfS?=
 =?us-ascii?Q?K7HJRwYSpLh83GCL8EYSZwNOjYltJ5RikU5pfuqfTzwnqXcLbwekqk/VOBet?=
 =?us-ascii?Q?8RdltANup0qFpEoIxNH+JjKsSJ/E5U1ORgBTbWHq3NnYhEo+xbZuedQHJrCJ?=
 =?us-ascii?Q?HYQwbiSEXIZgMTog+km70DdsXYidrocCKATv5WJT3ZdHhUalnMGpldTV+ne9?=
 =?us-ascii?Q?xxwI4qp2gVdtS/amjaw72Y3+/VcRl9ftT3Db79V6trPybaT8vuJV/JllsMR0?=
 =?us-ascii?Q?C0M7OHMAs2gDmdb/TMXH2F3kXGDDcdwfy0MceSNo6mwqjC9GE92DxVOiqdFo?=
 =?us-ascii?Q?hD9xuM3O0r/qbRVTv6AYC4ujV7+SUrcNfoWR2rIsX7oFhBHdqVnGfXQqrUuj?=
 =?us-ascii?Q?7VIQkY5ofYGLBGmp34yFvbJGC8Ux1/2Ame4hwTY7DOhCu3kOxbSDCMXX3hNk?=
 =?us-ascii?Q?C7qjlX+318u9EZveMVEgk1qUBVOn+/7CSae+v0a5FyISStCJf2I8CDnZ23dX?=
 =?us-ascii?Q?TDIVP9VZStIR+Ug3fmYr1Nm0PRHhzEvg6UNxjY3HEFiKrEp365wEs+tRrcTW?=
 =?us-ascii?Q?R+bnor0nX7uvrjCuEIi9yqYfkfsNG0i/xSN5fhoUD/1ePgtOEfV4OJa1bAzF?=
 =?us-ascii?Q?mqad3JgiX89BXuzMXutHPnU+JgxT2sCy8O/djQYO9yYIMcfHsu1/WH5ST4w3?=
 =?us-ascii?Q?iZq5rFAT4/7U9m4oaF84y7XnccdSbl1DjWxmIjCJ2o9c/iQSW5prTXJdvEkl?=
 =?us-ascii?Q?wRfQgI8bG5wFAI7cySiiUGKidMM0IHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95C355B334464F41BEE4189191233287@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a3c39-2ffd-421d-c83e-08da3a749b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 15:22:51.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp2lLW7+fzGMSCsEesg3e1GyyeCKrE+eRM74ShSWlDV/OsY5DhQfNiYQq+yjB+TwHbTQ7OMmdyAmidshWujJIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_04:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200104
X-Proofpoint-GUID: ZPsm-wRigchkSi8QLDU_vg5waYzped8E
X-Proofpoint-ORIG-GUID: ZPsm-wRigchkSi8QLDU_vg5waYzped8E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[ Note well: Updated Bruce's email address. ]


> On May 19, 2022, at 10:31 PM, Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrot=
e:
>=20
> KASAN report null-ptr-deref as follows:
>=20
>  BUG: KASAN: null-ptr-deref in nfsd_fill_super+0xc6/0xe0 [nfsd]
>  Write of size 8 at addr 000000000000005d by task a.out/852
>=20
>  CPU: 7 PID: 852 Comm: a.out Not tainted 5.18.0-rc7-dirty #66
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc3=
3 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x34/0x44
>   kasan_report+0xab/0x120
>   ? nfsd_mkdir+0x71/0x1c0 [nfsd]
>   ? nfsd_fill_super+0xc6/0xe0 [nfsd]
>   nfsd_fill_super+0xc6/0xe0 [nfsd]
>   ? nfsd_mkdir+0x1c0/0x1c0 [nfsd]
>   get_tree_keyed+0x8e/0x100
>   vfs_get_tree+0x41/0xf0
>   __do_sys_fsconfig+0x590/0x670
>   ? fscontext_read+0x180/0x180
>   ? anon_inode_getfd+0x4f/0x70
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> This can be reproduce by concurrent operations:
> 	1. fsopen(nfsd)/fsconfig
> 	2. insmod/rmmod nfsd
>=20
> Since the nfsd file system is registered before than nfsd_net allocated,
> the caller may get the file_system_type and use the nfsd_net before it
> allocated, then null-ptr-deref occured.
>=20
> So should allocate the nfsd_net firstly, other than register file system.

IIUC, I suggest: "So init_nfsd() should call register_filesystem() last."


> Fixes: bd5ae9288d64 ("nfsd: register pernet ops last, unregister first")
> Cc: stable@kernel.org
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

I think this looks right. Bruce, as author of bd5ae9288d64, any
thoughts?

I need a v2 of this, though. The current version conflicts with the
courteous server patches already in my for-next branch. See:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dfor-=
next


> ---
> fs/nfsd/nfsctl.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 16920e4512bd..e17100e90e19 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1535,20 +1535,20 @@ static int __init init_nfsd(void)
> 	retval =3D create_proc_exports_entry();
> 	if (retval)
> 		goto out_free_lockd;
> -	retval =3D register_filesystem(&nfsd_fs_type);
> -	if (retval)
> -		goto out_free_exports;
> 	retval =3D register_pernet_subsys(&nfsd_net_ops);
> 	if (retval < 0)
> -		goto out_free_filesystem;
> +		goto out_free_exports;
> 	retval =3D register_cld_notifier();
> +	if (retval)
> +		goto out_free_subsys;
> +	retval =3D register_filesystem(&nfsd_fs_type);
> 	if (retval)
> 		goto out_free_all;
> 	return 0;
> out_free_all:
> +	unregister_cld_notifier();
> +out_free_subsys:
> 	unregister_pernet_subsys(&nfsd_net_ops);
> -out_free_filesystem:
> -	unregister_filesystem(&nfsd_fs_type);
> out_free_exports:
> 	remove_proc_entry("fs/nfs/exports", NULL);
> 	remove_proc_entry("fs/nfs", NULL);
> @@ -1566,6 +1566,7 @@ static int __init init_nfsd(void)
>=20
> static void __exit exit_nfsd(void)
> {
> +	unregister_filesystem(&nfsd_fs_type);
> 	unregister_cld_notifier();
> 	unregister_pernet_subsys(&nfsd_net_ops);
> 	nfsd_drc_slab_free();
> @@ -1575,7 +1576,6 @@ static void __exit exit_nfsd(void)
> 	nfsd_lockd_shutdown();
> 	nfsd4_free_slabs();
> 	nfsd4_exit_pnfs();
> -	unregister_filesystem(&nfsd_fs_type);
> }
>=20
> MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> --=20
> 2.31.1
>=20

--
Chuck Lever



