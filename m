Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AEB567181
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiGEOub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGEOu3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 10:50:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04613E10
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 07:50:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265CewuH002612
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 14:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VJ6kfNPPe6LG4f/lpo4AZfEpOuJTz/kdv5/mbHcHPJU=;
 b=vRUGqqrBiGYP0cYv3d24QvRzunpSELaDD200iXAxL6pR6IEuFHfnn1JYAVWL/AbxYUeu
 f6GnYchPbLhjqITLOKvGXW34saJKN9pWF3wwRHzfwbHwrW93KcdLPQd8IR4zXgPKiwwY
 s16nl3DgQ5GpshQ4PYtV6TUo/EyfdGv13rE5Ps6+/LrEg4ccwiwbjnVxPoEN7Jpuso6T
 FKeJFg5LQT4xZGTQvlGNrk8cLA95Fm2Kfd0AofH5KOnjqPUGQ1Q9oEU/AfY+RfehhrjP
 UTtjHFgjCsq42rER+lLcDxzCgm84sxkbn4zyHlF/d1cWXGBTsT9ChCOanyUzOvpGZEdI 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dwap666-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 14:50:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265EfG9D009990
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 14:50:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf2ewq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 14:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLznfNXo/buw0aSvbec699/s/n6JHfjxqgZYkkzO9ws3D/VTI3MRSOX83frmIN8DvFCOchUOkAtoueBjOvv2ru9XKHNrn0gYb0SGG0sSUCk3GEdIc5J7lkLisVe8SHevA1uFSegX4Og8b1q1iNnOCB9aBNxEy7bt7naEQtNt6siENZok+chiDq1XeiTUt+E/2IDnQpipTRhJheaO33UDvLr1Qr/4Fjhr/OZBCsD2SofIvzXgzDXA8Ew0P72C7TrgU6e+d2xVE3/r2P9qE5d/iDFSxCebJi1oTqJEYTgAFouYSBkXLR6tVa+fkibSA8k73GCtPwKJirxdVAyrXdDLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ6kfNPPe6LG4f/lpo4AZfEpOuJTz/kdv5/mbHcHPJU=;
 b=lkqMpKKAQpN7Hnk0Ho3lPpL2VsB3EYGIBQbRB7DsscuMtYTOmegObDg+2KflrHYDzBt6/XClN76k8BXlBfiKZ+c4MSuF5BZZLiImzZfMqdtxwi/rNLcE8/KRpSzUxL9rrSSG/El+QDS3W1n01VI1FossqbPGUa/T2pADuilKJng/ogYQSYtM3KUuTi0+HM1SFxua5hZIrj+OTl12CMSRTdUvhMAs4Jz+0syPEy9ynRMO11hWyVP/c566o2K0cd/Wy5W4rwnrDfFqXbyqXVkNHRVbQbfcSTvvBG8+WVjo9aQPrEvuA+XDcy8rGlropHUhHgnVZ+JOtZZByUPpdH29Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ6kfNPPe6LG4f/lpo4AZfEpOuJTz/kdv5/mbHcHPJU=;
 b=ICEvyd4s6CHrdWaTD2cwp76glEUxG59QNYKie4gsTdrqVBAmw8HYJK51EU29L8Y5evpFOq9EaRoAzO+Tg114sODwq06lI7v102naOQl/FvLNCShK+Uo1uoQC4ezQlh2W1O48BWr2WBEYvoCPf3LZqzud5aHuVx6QwHVi47lYVRw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 14:50:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 14:50:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Topic: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Index: AQHYj9kTr28oHI8WDEa3jt5++5AbZq1v3WyA
Date:   Tue, 5 Jul 2022 14:50:25 +0000
Message-ID: <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5ebd79-8479-470e-cf01-08da5e95b21c
x-ms-traffictypediagnostic: DM6PR10MB4266:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqFomLl2qhq6HTwYDTghHdna0PVC9bieAgqiehMYxYl/t3VAx+MqH4wGUAxGMf7zDhDx+FlZTCOLJcgwuRUcchOBEx+4kJwDiwcTFti1Lfw0K41jNHlzCIk0voUkQ8GrYpLFQSdSWjtWWtRNKKqv9Isp1f9nBRiZRj+R4Qxr7GvGE9HhHOgVfWROOAqTWUsO1TWV12JqRxTpGmuGH8K+kAJ8d/bk9GmFNcSv/0pq3dB8F3yRNeYe42KzjJS2QajKbUFao5pS4s687ST8dZO1cKWt+0JzIlM7WSZmqs2ahH0UGz/gKVeobN5mHr9h83g9BHb0HmHUXeBPWSSUTY7hUNS7ZC2WiuVDscEDYCTuZrQJyQ28RDStKAdbuAGUFaIt+adK/UET+tW4bl4c8CxhdWOENbxBf8UCZhCzOU+OuHsHBDltoPh4Gi1qnn5dZ9sd4q5OUtb/No0+QrbpwY4y2vv1aiLADL5u60WxSduDOMdAXdb2sNT1s7Krnt3gLKmK07GE3YwFRLwJr6SRL5nKjQs+HiMW0LYWDDmFgPwJSRIhhypk288CPui5DUG26eZhf8jlkOClQk71kRKEXp7T7h/YQcpT49HwUAnqPgGH/o/PiGqs3msu62wbdWdCvd111qQHTBAn946CxDiCMq6S/Zem8UIZDUxOIo0L2PmIZ9Z1SRxpkMu/nB35J6dfEOplTks17IAdSxZlsWWsDKPAw4C0APsEkqklrKq0l4Sz7rQxL/MNNiBRHrHvu9xnEaikD1tUgFnnXmPdnRQQtLs1dyFc3Iy8azbfA+Cef+Xdo31zOiMOwhN9S/nz7paKMH71p+gK9Zg+vIT9MVTZRPhoh0NwarwjwGGuYtYDxulsqvG/DBIHrnqgYE16NGoq+TXe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(6862004)(38100700002)(6486002)(86362001)(33656002)(478600001)(122000001)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(6512007)(66476007)(66556008)(5660300002)(2616005)(71200400001)(91956017)(26005)(186003)(53546011)(36756003)(316002)(37006003)(6636002)(2906002)(41300700001)(6506007)(83380400001)(38070700005)(87944003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?paZ8rfs7gvTB9RhDm/V3hK7SoPEs0+RizP1Hnrbq4dOtNtu/AomJgZjxGR43?=
 =?us-ascii?Q?7Q0sTa5czFsapZI+MgU7Vg+GNiIMw5GCa7YxwMawysuUlsU8vk7swmIMo9eU?=
 =?us-ascii?Q?6S4U3LS+TaTaW804/sC4KGzqEXbLP4CXZQG+o+FS5hOM+WP5VHoxLQWc/vl8?=
 =?us-ascii?Q?efMqXhIzbS+RnI7ozYBSyGQWz6RBj9N9eYWq/mR29wDvi95jvsy7PVvMsvn3?=
 =?us-ascii?Q?QjZXdeVIPBgGzIai10V17r6+LOgGigOfii4vsx42DqG7cx7qGR1AQagcqUNf?=
 =?us-ascii?Q?Gf/Ln1YrhecFQIUpouD99xCvz1UEkTv6PuI+NTSNIEXrd28TfVcKjkV+34/C?=
 =?us-ascii?Q?Av2BEMm1TzCPT6c3UM/B93IYlxLNGOAiQcMh3xBJtVdjKovIt8cxrGd7mTfs?=
 =?us-ascii?Q?ZDmklpLaKNzf7cuPwJ5rtpSpy9mTZAOutnAfqY9vCeAj+EgtM+rBv/PtxHH2?=
 =?us-ascii?Q?SXT3LIilOKyC/IUKooUbGMjhKw9aaugUgqxtADmdMKixRWb8E6bjFZgIpTOT?=
 =?us-ascii?Q?kkK+MK+8sfwQjkE8j6GghLSB4OHY1YngmBFly4UGZmvZHECww1gxV01piL9c?=
 =?us-ascii?Q?AcY2aCcuPja9ZIF7dac7PzHrvt+aiUFn+XmJHaJWZFDtY2s+RDAStSBpEyZ5?=
 =?us-ascii?Q?zx8UHPT8MsVvOkUMk9CWLDVZmCmrmzD3GggVxns36IjP40MQ4V/VpZJZ/Ohb?=
 =?us-ascii?Q?rKxnjjo8FIfFLylFIYvdFl3MEjMtmXVqrcJecIhWzsgT3KN8OeZZjygk+qmw?=
 =?us-ascii?Q?vcYczo5W7M/n9Eo6eNC7JvF4M7SCL3cYGxhWyEz3R9lJLa9Tgt7vlN6e2K4f?=
 =?us-ascii?Q?wkD8one7eYPfVKdegJNhcsBl+JI6VSRin+K/hGmMdIf0GahWflsHeLaEZKea?=
 =?us-ascii?Q?voBRsFqRt7iztJ67/T7AbdARwmrlFr4AkP4pV3R0AxJrxvzpMJRwHHv/pIzC?=
 =?us-ascii?Q?vIz2lau/pjfXSXN5otJoNahjkabwTu2q+YfV0H0io6S+3ci91eeEVswmR0Rx?=
 =?us-ascii?Q?oJK8czfbumT8m/CjEGHfVdjTVYA+MSLXiRcYbjw1Megg57gjYwRo93N6OVp4?=
 =?us-ascii?Q?OF0tG4EW3aOCRYU/LjQXtdIBdNtmCE2bI++Ni0Bt/CG32WCtJAB2x/6ppvv0?=
 =?us-ascii?Q?kBI45bNCiJIZJd3aQ5RM3DF/9MYIFzjsJWLKbAIbtyylChOPP44hc5EOU4tl?=
 =?us-ascii?Q?fwDW17H0E8qNLBNrGMPeDTLWiJSM8UU85C/jev4ibFO5JLahHK/PWkBDa8kP?=
 =?us-ascii?Q?K7cZhYt3q7fMgAOYCyyXvhGfS7BTGEbuanM0Xhqk+dEszBemHxZRER8atzSi?=
 =?us-ascii?Q?AdJbj/YBfsRn9tAbmryXyq11ZPv4NZKmbOAAC2k0DV8eyZaa6gZMXkvJWT7C?=
 =?us-ascii?Q?N3FpwqgsVefmY7jXr7zcNM0aOdMVo/DoCcn2ypQhLZXJLnRXSkd+GGMd/g8v?=
 =?us-ascii?Q?LActwHB0GWOqUk0WtcQYUqHV3uG7ne8KfpceHZV8ifAeDhfnp2vFOsvCAdj+?=
 =?us-ascii?Q?g99+fE+ABVDMYsbNmc9J/BReJyP19hVQ6bIVZPcb3fzF3q8o2912McVLjy1O?=
 =?us-ascii?Q?fW9lfu9AUOhgT3c3ILVNq640274TONf2M9loRwhRGrOI1lCZOEcKeYSNOodZ?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A69E2D59D741ED4D87365573C3E38B85@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5ebd79-8479-470e-cf01-08da5e95b21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 14:50:25.7248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BiL9EwbCfVQkmLnl88uhjLrgwXnCQGmQsCgXzK3z4BFL3IzSkjokZmhNEbWtxmCl06AerSWvxoHMthZ+F5irA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_11:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050063
X-Proofpoint-ORIG-GUID: XEC-w01w0ASnmWfKcWysvgaTOt5n5ByE
X-Proofpoint-GUID: XEC-w01w0ASnmWfKcWysvgaTOt5n5ByE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dai -

I agree that tackling resource management is indeed an appropriate
next step for courteous server. Thanks for tackling this!

More comments are inline.


> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently the idle timeout for courtesy client is fixed at 1 day. If
> there are lots of courtesy clients remain in the system it can cause
> memory resource shortage that effects the operations of other modules
> in the kernel. This problem can be observed by running pynfs nfs4.0
> CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
> fails to add new watch:
>=20
> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>                No space left on device
>=20
> and alloc_inode also fails with out of memory:
>=20
> Call Trace:
> <TASK>
>        dump_stack_lvl+0x33/0x42
>        dump_header+0x4a/0x1ed
>        oom_kill_process+0x80/0x10d
>        out_of_memory+0x237/0x25f
>        __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>        __alloc_pages+0x132/0x1e3
>        alloc_slab_page+0x15/0x33
>        allocate_slab+0x78/0x1ab
>        ? alloc_inode+0x38/0x8d
>        ___slab_alloc+0x2af/0x373
>        ? alloc_inode+0x38/0x8d
>        ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>        ? alloc_inode+0x38/0x8d
>        __slab_alloc.constprop.0+0x1c/0x24
>        kmem_cache_alloc_lru+0x8c/0x142
>        alloc_inode+0x38/0x8d
>        iget_locked+0x60/0x126
>        kernfs_get_inode+0x18/0x105
>        kernfs_iop_lookup+0x6d/0xbc
>        __lookup_slow+0xb7/0xf9
>        lookup_slow+0x3a/0x52
>        walk_component+0x90/0x100
>        ? inode_permission+0x87/0x128
>        link_path_walk.part.0.constprop.0+0x266/0x2ea
>        ? path_init+0x101/0x2f2
>        path_lookupat+0x4c/0xfa
>        filename_lookup+0x63/0xd7
>        ? getname_flags+0x32/0x17a
>        ? kmem_cache_alloc+0x11f/0x144
>        ? getname_flags+0x16c/0x17a
>        user_path_at_empty+0x37/0x4b
>        do_readlinkat+0x61/0x102
>        __x64_sys_readlinkat+0x18/0x1b
>        do_syscall_64+0x57/0x72
>        entry_SYSCALL_64_after_hwframe+0x46/0xb0

These details are a little distracting. IMO you can summarize
the above with just this:

>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>> there are lots of courtesy clients remain in the system it can cause
>> memory resource shortage. This problem can be observed by running
>> pynfs nfs4.0 CID5 test in a loop.



Now I'm going to comment in reverse order here. To add context
for others on-list, when we designed courteous server, we had
assumed that eventually a shrinker would be used to garbage
collect courtesy clients. Dai has found some issues with that
approach:


> The shrinker method was evaluated and found it's not suitable
> for this problem due to these reasons:=20
>=20
> . destroying the NFSv4 client on the shrinker context can cause
>  deadlock since nfsd_file_put calls into the underlying FS
>  code and we have no control what it will do as seen in this
>  stack trace:

[ ... stack trace snipped ... ]

I think I always had in mind that only the laundromat would be
responsible for harvesting courtesy clients. A shrinker might
trigger that activity, but as you point out, a deadlock is pretty
likely if the shrinker itself had to do the harvesting.


> . destroying the NFSv4 client has significant overhead due to
>  the upcall to user space to remove the client records which
>  might access storage device. There is potential deadlock
>  if the storage subsystem needs to allocate memory.

The issue is that harvesting a courtesy client will involve
an upcall to nfsdcltracker, and that will result in I/O that
updates the tracker's database. Very likely this will require
further allocation of memory and thus it could deadlock the
system.

Now this might also be all the demonstration that we need
that managing courtesy resources cannot be done using the
system's shrinker facility -- expiring a client can never
be done when there is a direct reclaim waiting on it. I'm
interested in other opinions on that. Neil? Bruce? Trond?


> . the shrinker kicks in only when memory drops really low, ~<5%.
>  By this time, some other components in the system already run
>  into issue with memory shortage. For example, rpc.gssd starts
>  failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
>  once the memory consumed by these watches reaches about 1% of
>  available system memory.

Your claim is that a courtesy client shrinker would be invoked
too late. That might be true on a server with 2GB of RAM, but
on a big system (say, a server with 64GB of RAM), 5% is still
more than 3GB -- wouldn't that be enough to harvest safely?

We can't optimize for tiny server systems because that almost
always hobbles the scalability of larger systems for no good
reason. Can you test with a large-memory server as well as a
small-memory server?

I think the central question here is why is 5% not enough on
all systems. I would like to understand that better. It seems
like a primary scalability question that needs an answer so
a good harvesting heuristic can be derived.

One question in my mind is what is the maximum rate at which
the server converts active clients to courtesy clients, and
can the current laundromat scheme keep up with harvesting them
at that rate? The destructive scenario seems to be when courtesy
clients are manufactured faster than they can be harvested and
expunged.

(Also I recall Bruce fixed a problem recently with nfsdcltracker
where it was doing three fsync's for every database update,
which significantly slowed it down. You should look for that
fix in nfs-utils and ensure the above rate measurement is done
with the fix applied).


> This patch addresses this problem by:
>=20
>   . removing the fixed 1-day idle time limit for courtesy client.
>     Courtesy client is now allowed to remain valid as long as the
>     available system memory is above 80%.
>=20
>   . when available system memory drops below 80%, laundromat starts
>     trimming older courtesy clients. The number of courtesy clients
>     to trim is a percentage of the total number of courtesy clients
>     exist in the system.  This percentage is computed based on
>     the current percentage of available system memory.
>=20
>   . the percentage of number of courtesy clients to be trimmed
>     is based on this table:
>=20
>     ----------------------------------
>     |  % memory | % courtesy clients |
>     | available |    to trim         |
>     ----------------------------------
>     |  > 80     |      0             |
>     |  > 70     |     10             |
>     |  > 60     |     20             |
>     |  > 50     |     40             |
>     |  > 40     |     60             |
>     |  > 30     |     80             |
>     |  < 30     |    100             |
>     ----------------------------------

"80% available memory" on a big system means there's still an
enormous amount of free memory on that system. It will be
surprising to administrators on those systems if the laundromat
is harvesting courtesy clients at that point.

Also, if a server is at 60-70% free memory all the time due to
non-NFSD-related memory consumption, would that mean that the
laundromat would always trim courtesy clients, even though doing
so would not be needed or beneficial?

I don't think we can use a fixed percentage ladder like this;
it might make sense for the CID5 test (or to stop other types of
inadvertent or malicious DoS attacks) but the common case
steady-state behavior doesn't seem very good.

I don't recall, are courtesy clients maintained on an LRU so
that the oldest ones would be harvested first? This mechanism
seems to harvest at random?


>   . due to the overhead associated with removing client record,
>     there is a limit of 128 clients to be trimmed for each
>     laundromat run. This is done to prevent the laundromat from
>     spending too long destroying the clients and misses performing
>     its other tasks in a timely manner.
>=20
>   . the laundromat is scheduled to run sooner if there are more
>     courtesy clients need to be destroyed.

Both of these last two changes seem sensible. Can they be
broken out so they can be applied immediately?


--
Chuck Lever



