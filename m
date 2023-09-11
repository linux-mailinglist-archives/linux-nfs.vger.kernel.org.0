Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDB79B727
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbjIKWAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbjIKTzp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 15:55:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE5D1A2;
        Mon, 11 Sep 2023 12:55:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJbKP0011523;
        Mon, 11 Sep 2023 19:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=XBiktDB/UeFcLMa7/MnoBO6rSSblHYo3DM5hOBQ/b3U=;
 b=YzS3EpdrFiZhULaEYYh9zi0Z0slXoijYpG1pT1HAKQCE7TYbdKjDIcOS4Dz8zhfK8isX
 qgHhITx+3JLd7FJN6/hBsvJlhFq53SKrBfs4onRRYZcBbr4ox+odzHs5avpylJMZLe+R
 w9zOh8GYOWczPmcn7TzmRoPd+tjdykmz/BaHT5GGyz9LCkTyKrHOQIEy916cAUl3npye
 Vznn+VYnbiHoP9r/6F1RMrizQLfuJF3lptLxWzdZfFkzDnPE9GPerXTadkh1WjPnleRn
 a4V7ZTFW3nWsZvmY06JYSG/U+AQOjg9c2lj7kH50bYQ5gg9ig2ac774w6X0442f8JHNh wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqacrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 19:55:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJl6DQ002305;
        Mon, 11 Sep 2023 19:55:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5ayec3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 19:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWfyK2ns5jgoJgq1Eesqww5Jr6Hr4xDGQ71mPLJC/5yKUk6qEQNBKxL8Qm2+Awe4MggZMZPcVcP8x6SBoj5FetaRbEzuCV69S8X5u9jlCAjnJfu5/n2o+RN+TNkP+Xe/msgtcWTMqG9RRmgvlI0R++Zad4IxnntLHQysOQflsmfoltJksIn8icf7XEEYZTg5LdYAUdFsnQjY7+fqJXFhU1jQhh4ofC8SP+MlYGuq9RO0GRi/srAeiD5Io5O6ZoV9XP47DafFQeLPsNyte/6vRNDE+/i1XqTQZF4FAI6ytYrk+qEPHjpCPxNrwpVWV6KQr8MFJbEhUu0V3ROuhR8H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBiktDB/UeFcLMa7/MnoBO6rSSblHYo3DM5hOBQ/b3U=;
 b=imN5paN8L8kJqbSzadgJdbSqQHsrnsyENwlaZg6SSRBYT1x9f9zBCOjaZrpWh4ignHEWeubhVSAGmeltvivHWqZREc0whs7LEJFL6t46rT2t9ARrKqXnknI/vW4hnf02pm1CdlpEkMW1xWi6y7yxy60Z0s2tmoWth4b8OWw+Qnvs/Y7qSrG7IWbL62VQeL+ppHd1v78rQWi6X/6K4MHfK0FM4IlxNfC5R9O7WVTjhKbVDrAdFN7Cs5qWGrco6coY/OIDSm/wYnE17+G923PBeh0q1SwoyqK8rax608m/Z0dFN4PoNfmfKaolskiFIVQO7p4Jr9/TYK2dm6ykQrMf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBiktDB/UeFcLMa7/MnoBO6rSSblHYo3DM5hOBQ/b3U=;
 b=cdd+yFNxxCjieHgPwm1EY+2usw4wDO5XsqF0WNayeCG2UV4Ir7EJyh4/gfCiFz35avk6Rv3BE99T3Cr2CxPC1NdF6py6ml0THUtPewdsRPpUA+v63MvrL/jKqYTpa2znyS6Tf+wJK0Y11Jb06R5CKpR9jkX4xybYhmVO+58mtd4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6857.namprd10.prod.outlook.com (2603:10b6:610:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 19:55:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 19:55:27 +0000
Date:   Mon, 11 Sep 2023 15:55:24 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Message-ID: <ZP9wrLXKWtvMt4mZ@tissot.1015granger.net>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 541f01d0-abee-46d9-1063-08dbb3010bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/1s+UZ1e/+SJPRjUBihRjArJb1hSOgvyzErMA0jW3woYmIwF5yqSv8bjpGC/yTIr/AnSjhtxGPWNehJtft1MHiIxedk40PZEOWlUMgVuCfIDdSfAmINBsqO7UYMxeerGzZUqe/GDMZ8psN1Sr6UOPmOXByVnSl5fvCeSBqxxe/nZKD+r5prt5s1kWlIM+c2USrKRoDTuURF6qAQSj0nhiQb1wn7y6pbj+ekuo+2V1egkc7V2awE2+ID2KKYXIZBAE8u4Pe2CPTCpPTm/IvczwLE3qkMqRw0gXU5x3MUhGAejKDcedBcVv2EE1gBiXolB8OCAf5v8Cg4GFVbpp2ViK/9tKRv5tLrbUbb6ruixqTJfgtKDmrehFst+hYOlJN5U0CsijuTtH94BY/YV90NV4D7iFaTy1aqb0tKt60bL0cr4w871Hx1K9UWCHLTWj+UMtOu8je4l3R0z+eyocQKJ025QwrfLSwi/Yr6uKYvro/qr4yOveCSFsi5hp1CmLoja2Pi/kVB94UQS8STwAUI6dak9naKzO6Q8JrszWqeyZRtN8GIQctT8MEH9T3u55bw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(6666004)(6506007)(6486002)(9686003)(6512007)(41300700001)(478600001)(83380400001)(66476007)(44832011)(66946007)(66556008)(6916009)(8936002)(316002)(4326008)(8676002)(5660300002)(2906002)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nn8rxk6lB5LsBHE8JLpINLRbJp0EXItHkqvKYvLk6vFbPHxwGs/s/q1lYGLl?=
 =?us-ascii?Q?zesJ5JerkiCeWO8nFRq1wu2xMOgNhEhcXfMmfvqcYyL4UwDV9IkfPYx4b8AH?=
 =?us-ascii?Q?Dc0tCErAc3Bwyg+VRsDHRKvnSSTpG5PNfKcVJ+tPhlEhnU0rLAPigtFtHTx7?=
 =?us-ascii?Q?aDPzMaCGMvJ4u44hIEGTBB9WlhcjVTosgvkPFzHq272yLpmA2/7ICt+3gK62?=
 =?us-ascii?Q?zJbGhv8NBDBga0ds9vfkvBLVcXWVUPO4btK5EuEF8GWQYxZflvXh+fuczh5k?=
 =?us-ascii?Q?Nsk3lB+/4F4XnrWxp/xdRmaU5XKX1CB2Pgef61tdlTT9JCtOSbzoce3YrvrL?=
 =?us-ascii?Q?WvGpWp9nMMRZ4JgSETjnaVuqdCKgHuH7QgPss8DtHwL2sX3z5fFkccyVitcg?=
 =?us-ascii?Q?PmCBhousaY8uhwX2yO3+OUSwY+fak314PWUI0PmAKf2YZGhPhghzT7NuAP58?=
 =?us-ascii?Q?2UeOhJcNFCIwMIFvAedjm0zi3emoraw2R45Bswj7xn2adtz9zdc2mgpJCYeJ?=
 =?us-ascii?Q?R2Z7Bb+l9d1Wm1RPhjhDu2z/iAVqtPhkyX7m1S+ikMi8N38JI50ckXV7wp/7?=
 =?us-ascii?Q?xuM8z3RunQOZWknH/4JATINk/5TYPJbKqZ9D9XiDUfsxd30wXpR/WCHB3R54?=
 =?us-ascii?Q?nTk9ZLWVdepIt/jYOQEnaDIL8AO05N8Ry3rzOtL0BibfyrWkYiw3PJdj3m2P?=
 =?us-ascii?Q?X/R6/Y0hO52DRKF95FipGxTS7zF337tkJmR6Q4q+bNTuUpXne6bou5FjRrd1?=
 =?us-ascii?Q?BEO/ngM6EYUIKgBRrBFYFG2nMfLH3a61FBDE/hG0t9ZyZd6l5zJQpwKztjFZ?=
 =?us-ascii?Q?xCN2NbSUsWYOgOXvdDBJYudQ9do8E/cQVcRCfSwhv+P7jScw/EnmwsdGeE74?=
 =?us-ascii?Q?A5TocaBOFW68mBZKdvBG6CyMKZ3Nd6xgATvVauiEEMaPmZ1ULWw7AXX1gQkm?=
 =?us-ascii?Q?aVpCfiWRLvc0SIsEiUf2YcSRhIG+EZyFCibnFv4R3tUSvy+OTPuwzYwLbUE1?=
 =?us-ascii?Q?bQTwUQRcZYbN3jopVy7HFASfTvLmIfQVVPjJHtvpGCkvfrX1W930IDMU1N6v?=
 =?us-ascii?Q?6P5N2IZc4ENBw+1wB5NC1LrqjJyckw2kakCmNtLjFTwF7H6UEaiHfTUh0Nri?=
 =?us-ascii?Q?jta/pUF/EujWSPnzadUjmtapVyVCC6e56/YYvJkhsjjk/KTyOOnG+GnWF9gC?=
 =?us-ascii?Q?+pvAAV84gvF2brYRSmKnSEPNx7LRWhY2xRux1HNSG8bA8NTi3AhHHex16wdj?=
 =?us-ascii?Q?sUWTryD7q6fxIFJHa3lHJKszVL8WyvXcAFlU8gYvC9nn67vvY+8hSLZYbniu?=
 =?us-ascii?Q?CIsvv8d71qbgE/oJEhybaLmcpfnmVBuovrxOxBDhDZYagaQbAZY7U6j5OcTn?=
 =?us-ascii?Q?8ZumoAYGaUmr+AVthJIwm97wEwEm1kzGM4YD2uDDuKOoZCTu5dY398SZ9DpO?=
 =?us-ascii?Q?NYwRne8uGJblLplw2MBEBAhFv5ktZnCiabOryvfh+3ksAaGiMBipUKG8O+EC?=
 =?us-ascii?Q?8yiXdwuwavwFy1xF9q1vfz+7YmrWwFFPgqnkpUDBl4WCj0N/3Q9xB8hQMfw6?=
 =?us-ascii?Q?yenHCAOQAxJlzeSOngPnVeEkX35PjhQtGwi/1lDh+cmmjmS8XZM5ri/SJZz9?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KahNqjwOdgIFxAYxW4lsS34C73EABcf7Aqjzjo5MNggdh8MwvTg3dvPvLjWyNwvv+QVjnSusiifj7+FGPpmZWYZW6E9Qmajk0QcJ1Cr4PpZvPkJyFZLSHr3K/rcWpwYrwWKgdzsHyXHDaUIOwZdwVjWlYgOPlZjwUA2s9a8hxY6wHOwDoFzFYa6wuPrcmgyVgTl9WsWk8+di38BgCVQpvVPvJJ0tgsqHlDo6tXs+jGuW54M9idcTBSawtJ/MEA4KMW2J7BfGidsYX4JpV7iBCuFdDT8IOLb5sEQnRS1PaBorF53NOl+xwZ3B7ET8DrajvZrlXRb/GSTsyZvqaJwY+Hoj59mnkvpuQ0scENP9qkJKo5hzg5634UgekDAcjmVVcGWfhTC2g3d8QQeXRqTcAnYFSXHFu+sdVRMfo96apIbXczCIqtLQOwI8/YKz/BAreLG8EM3QLc6bJEVT6D8K3RdSFkhxjLF44sijevE+j5FU/Q1h06Nj4nP00EqehMvsmKqNNqZuLGpmluVc6Ae3DuMaGDfliIUlP7t/50iAgPrb8aiVI8U8kPneHmjmtcMOTK/w0XV/iB4wFdQRJlJFbPhReHvMJEbuXx/2Nm2F4kMus7nVrFzDJBtwVKERfVCZ/XC+EEUXy7kLrOe/9GT5zMZfM4dcv6xy+HyIke54dRg6x/8NbFgX07b+/EFC41mbV6EYClLGy4i53PrRqk3DJOSdmka95+wz0TxiWyiWDewkx9MyybINxB+l7rVpvVSQtLI9ouIbITUdv6a1L1wxlYptI6IXd6sUuEqjA+nDP2CqubipX3oEnnvRKVz0CjsPPLIJO8kdXDqfmBQWtY32jg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541f01d0-abee-46d9-1063-08dbb3010bab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:55:27.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VT1YMIM62fRTz7aLOrns37w6fF3GldoKGF03hpf5DcZQP5zIp5Ww2uW1Hm9BOIECiAmrPp1wozN0CPHcPqEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110183
X-Proofpoint-ORIG-GUID: h5F8SbSenSc7eRtPJjpAkS_CR6xJm9aJ
X-Proofpoint-GUID: h5F8SbSenSc7eRtPJjpAkS_CR6xJm9aJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:45PM +0200, Lorenzo Bianconi wrote:
> Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
> 
> $./tools/net/ynl/ynl-gen-c.py --mode uapi \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o include/uapi/linux/nfsd_server.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o fs/nfsd/nfs_netlink_gen.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --source -o fs/nfsd/nfs_netlink_gen.c

Actually there's a tool that walks the whole kernel source tree
and handles any files that contain the YNL-GEN tag:

$ tools/net/ynl/ynl-regen.sh


> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/Makefile                 |  3 +-
>  fs/nfsd/nfs_netlink_gen.c        | 32 +++++++++++++++++++++
>  fs/nfsd/nfs_netlink_gen.h        | 22 ++++++++++++++
>  fs/nfsd/nfsctl.c                 | 16 +++++++++++
>  include/uapi/linux/nfsd_server.h | 49 ++++++++++++++++++++++++++++++++
>  5 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 fs/nfsd/nfs_netlink_gen.c
>  create mode 100644 fs/nfsd/nfs_netlink_gen.h
>  create mode 100644 include/uapi/linux/nfsd_server.h
> 
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 6fffc8f03f74..6ae1d5450bf6 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -12,7 +12,8 @@ nfsd-y			+= trace.o
>  
>  nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
>  			   export.o auth.o lockd.o nfscache.o \
> -			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
> +			   nfs_netlink_gen.o
>  nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
>  nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
>  nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
> diff --git a/fs/nfsd/nfs_netlink_gen.c b/fs/nfsd/nfs_netlink_gen.c
> new file mode 100644
> index 000000000000..4d71b80bf4a7
> --- /dev/null
> +++ b/fs/nfsd/nfs_netlink_gen.c

I'd like a shorter file name. How about fs/nfsd/netlink.c
(and below, netlink.h) ?


> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN kernel source */
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include "nfs_netlink_gen.h"
> +
> +#include <uapi/linux/nfsd_server.h>
> +
> +/* Ops table for nfsd_server */
> +static const struct genl_split_ops nfsd_server_nl_ops[] = {
> +	{
> +		.cmd	= NFSD_CMD_RPC_STATUS_GET,
> +		.start	= nfsd_server_nl_rpc_status_get_start,
> +		.dumpit	= nfsd_server_nl_rpc_status_get_dumpit,
> +		.done	= nfsd_server_nl_rpc_status_get_done,
> +		.flags	= GENL_CMD_CAP_DUMP,
> +	},
> +};
> +
> +struct genl_family nfsd_server_nl_family __ro_after_init = {
> +	.name		= NFSD_SERVER_FAMILY_NAME,
> +	.version	= NFSD_SERVER_FAMILY_VERSION,
> +	.netnsok	= true,
> +	.parallel_ops	= true,
> +	.module		= THIS_MODULE,
> +	.split_ops	= nfsd_server_nl_ops,
> +	.n_split_ops	= ARRAY_SIZE(nfsd_server_nl_ops),
> +};
> diff --git a/fs/nfsd/nfs_netlink_gen.h b/fs/nfsd/nfs_netlink_gen.h
> new file mode 100644
> index 000000000000..f66b29e528c1
> --- /dev/null
> +++ b/fs/nfsd/nfs_netlink_gen.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN kernel header */
> +
> +#ifndef _LINUX_NFSD_SERVER_GEN_H
> +#define _LINUX_NFSD_SERVER_GEN_H
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include <uapi/linux/nfsd_server.h>
> +
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb);
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb);
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb);
> +
> +extern struct genl_family nfsd_server_nl_family;
> +
> +#endif /* _LINUX_NFSD_SERVER_GEN_H */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 33f80d289d63..1be66088849c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_server.h b/include/uapi/linux/nfsd_server.h
> new file mode 100644
> index 000000000000..c9ee00ceca3b
> --- /dev/null
> +++ b/include/uapi/linux/nfsd_server.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN uapi header */
> +
> +#ifndef _UAPI_LINUX_NFSD_SERVER_H
> +#define _UAPI_LINUX_NFSD_SERVER_H
> +
> +#define NFSD_SERVER_FAMILY_NAME		"nfsd_server"
> +#define NFSD_SERVER_FAMILY_VERSION	1
> +
> +enum nfsd_rpc_status_comp_attr {
> +	NFSD_ATTR_RPC_STATUS_COMP_UNSPEC,
> +	NFSD_ATTR_RPC_STATUS_COMP_OP,
> +
> +	__NFSD_ATTR_RPC_STATUS_COMP_MAX,
> +	NFSD_ATTR_RPC_STATUS_COMP_MAX = (__NFSD_ATTR_RPC_STATUS_COMP_MAX - 1)
> +};
> +
> +enum nfsd_rpc_status_attr {
> +	NFSD_ATTR_RPC_STATUS_UNSPEC,
> +	NFSD_ATTR_RPC_STATUS_XID,
> +	NFSD_ATTR_RPC_STATUS_FLAGS,
> +	NFSD_ATTR_RPC_STATUS_PROG,
> +	NFSD_ATTR_RPC_STATUS_VERSION,
> +	NFSD_ATTR_RPC_STATUS_PROC,
> +	NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
> +	NFSD_ATTR_RPC_STATUS_PAD,
> +	NFSD_ATTR_RPC_STATUS_SADDR4,
> +	NFSD_ATTR_RPC_STATUS_DADDR4,
> +	NFSD_ATTR_RPC_STATUS_SADDR6,
> +	NFSD_ATTR_RPC_STATUS_DADDR6,
> +	NFSD_ATTR_RPC_STATUS_SPORT,
> +	NFSD_ATTR_RPC_STATUS_DPORT,
> +	NFSD_ATTR_RPC_STATUS_COMPOND_OP,
> +
> +	__NFSD_ATTR_RPC_STATUS_MAX,
> +	NFSD_ATTR_RPC_STATUS_MAX = (__NFSD_ATTR_RPC_STATUS_MAX - 1)
> +};
> +
> +enum nfsd_commands {
> +	NFSD_CMD_UNSPEC,
> +	NFSD_CMD_RPC_STATUS_GET,
> +
> +	__NFSD_CMD_MAX,
> +	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> +};
> +
> +#endif /* _UAPI_LINUX_NFSD_SERVER_H */
> -- 
> 2.41.0
> 

-- 
Chuck Lever
