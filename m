Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1197727A3
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjHGOZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjHGOZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 10:25:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899F10F1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 07:25:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377BZ2I0011821;
        Mon, 7 Aug 2023 14:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=AdwDwyBuDZ82E1nAcJhgK/4R8cdfYfjZoG7qj83anLE=;
 b=sJw8nApCzKI2RkSVzedYyR2iFdoTzizv/tESig6DC6sm1lNJtkyryJ9eCigy78IPJvoE
 1RBg42sheMvHXq7QyLrRK3zXp6bDSH0CJs4faxdXrw/te7PbUolSztvBQAqgrMwb5kto
 u4oUgbbDgTtA98EYVzYsFyf1t3LlQ9mt9ayGbwqwTll87pZ4toRj8vsHPsHS96aeSJ5m
 GnUlVDNJO4RUg7w71b9somNtpL/il6K4DEIrl4Wyz8XrTEQ3lEzQFXSNmgeDxw2CH/zt
 VdEyRhbPH21/+7RF2IwyVPbf71gQMcN8YCnGGDS6FvXNAtZylFYUbgSatYxRrhsz2f98 vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaaju76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:25:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377E2Z5R023047;
        Mon, 7 Aug 2023 14:25:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv4mvtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEFACnXepqMdAfq66rpfxnUpC3CfOt35XbCB/t1BSVajCo+WleEhqNoAqbS2FG4G8kPNhPDBUzzQ7GXsmpFC09fbmD4zbZDFbTxXsUntxESY+QfP6EDJS3sfDWZfasp+7YdubxkSSv0mwDF5Yn4kcIfCBN+9f4mzXQPjT7b6VlLx46AsC/u4nJXrLHPzXwhyBrgzPpqSS+Fz6rcPzkzV+RGp/v8FvepppbWFZvWQ6jgmVK1lQZt7pvWPi1S3YvyPNX6k/D7pJH9p/O3wbmZc09lJyDuPARna5gtVTzjUc2LQiHrOUd5swsE9648F53WOmNLLtXfdGlMsxxCWmrg8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdwDwyBuDZ82E1nAcJhgK/4R8cdfYfjZoG7qj83anLE=;
 b=UVHYdADG//KtLWwJiuypvnC60PMuScXX1Cm5XotwR44L45PX4mjb3eNeCQv7C2Bx7fHvZWIp0hCu8xrj+3X4tVT2AqnW5Rr0ojJScjrgbh9Z+/pXXPBHhLl6qqUQsBxzcCWvsljtefHmf8bRwcKqG9ojuTc5OEY/X6S3f8oWShPqPl9AyVe94YQiCeL2vUVc8pmt3wJzN1pAzcF3KsGEDmKu3jBgQ/WdT3RJXnWqDMhO7d+6/03vlZbIlTS7qGDTp3wP7CG+8f3K+XHmOhJvwpcSH74qtvFHLovq1lTdm7qx9w/k1Q/F5y78+8TXFzBJCxtmz7Nmqylqz2vsRMQbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdwDwyBuDZ82E1nAcJhgK/4R8cdfYfjZoG7qj83anLE=;
 b=xuE6KagBEqK4SwifnjxkGPSAS5+8XmZ5ntXdNIzh8dob42g8BieOvZKDu2q8Juou1lZesnBsD5tBHxO5xrJbdeijSd0O0gx0GxaDphk2qcFF9tl9xyiFue8GWo6FBoEwcBjjsTqwd0j0qtZWkpNZLtjMEdcOqVCQnkrN6gb/Yuo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Mon, 7 Aug
 2023 14:25:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:25:12 +0000
Date:   Mon, 7 Aug 2023 10:25:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v5 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZND+wBp3l5NzZR7R@tissot.1015granger.net>
References: <cover.1691169103.git.lorenzo@kernel.org>
 <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:610:e4::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6b7fed-997c-48e1-a4c0-08db97521c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjifU3MgwXZT8i09vX8eLwdezv7hpFa3epQSqmhYIi0LBjfuxoa56cj2Vqxc8dI3mVbizysNPvsEQcGwp5V5QMAp2lW7BkxLk+HqmuS46+psjtdQHaai9BFJceONqvGWRGA2dQz6MyHIGzCs7Es/OJzKJ6FuESyRX/huh0LlqTrW7dRjcsj6foIXRJdp59TQ58UXQ0EeYtU6Zj1ANvvAiMI8+lb/qJRKZr/CE2VSPui0oub+IEME5Ov43E1uCcdxcEZdQXXo835fBBWjEiDoCnA5KT5+tRiZSElrC3yECjMJNWxbN1mkK3N6i7VVnGPk1DdAOSm+0iT1c1TQf3mtvTFlkqQFrss6Sdt/lGVBbCWyIHgZ7ozQpCdVMNQFf8e9IH3YvveLqFtMR9OPyyLtDF97F47CKKe/k8WvfQi/epWf64vKn8dv/F6iu+4x5FvaMjUm3lcpZ1tcomuXiExwhSdrcN5ejjYCsYOK0AcJshQ+7tC5Y32G32CVxhRTpHjV1XMeHJOcVfXJnX09pIuR/vv1seDb7eHpotw+ePG7L/U2tMQv4j+oyfVOuyRs1aroTIxs2b0VnB7foZdyz/vBR6RByrMKkDRa38f15IJZdPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(1800799003)(186006)(316002)(41300700001)(6486002)(86362001)(4326008)(38100700002)(66476007)(66556008)(6916009)(66946007)(5660300002)(8676002)(8936002)(966005)(478600001)(9686003)(6512007)(6666004)(2906002)(44832011)(26005)(6506007)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGXMt1/3NV5J7wZea3svZvq0XRH1aJcHq3dCcn0rKAWCsh/BDBE0D1qI9w5Y?=
 =?us-ascii?Q?xhzIvvU+Blg8NPBGgZRPcTbDK1t9JxiiMoI4gy82lKJgYqvkNs9/RWNgWxy0?=
 =?us-ascii?Q?UnEY3Nreok3lErV2WytfUbgCbXHIhanqYUXRbzrLIHADGOdA03lYWJfSGyz6?=
 =?us-ascii?Q?Ou402OQUaOm5SZeXvxmS560nebguDJmHudJ8UXqPfGw/VmIEJ6Hy1/QF/9o4?=
 =?us-ascii?Q?XdRfooV8s6/ycbXZxNgfDZTCyShjnnds7i5tga2QZeCs+Bk0rAaGgtmRNJCG?=
 =?us-ascii?Q?bbB8urbYM6kp2tupqA4DJuLYnXvhVEewps80TsCsHroy9o0rl3etI6TRVw/K?=
 =?us-ascii?Q?RO5Cdsiiw1uL4RKyHy81DZHXaX//Op3q0I4YQrsX7LO4/vysI/jmEEnoRnjL?=
 =?us-ascii?Q?LculUuuTB5JBdldaznssDqUy5y9r71VDrjhq20Tk05qBU1Cf8kigjJaTSzGZ?=
 =?us-ascii?Q?9/l/yfTTpDQ1MnHImTE5f0nrqp9kgoyse37t4B78uPp7PHpGy0fd4Q44DiyH?=
 =?us-ascii?Q?KYXZXIvOEQHcvYDGbgDU8h4pqagHqZy3hwmty5kXIfBXv9Ikdu8xoulm972j?=
 =?us-ascii?Q?m4Qe43WjCcyk4TIyRU9um0fKzfV+FW7IsQuEkNsyg+rVb6KHg4Z4dVwzQYX5?=
 =?us-ascii?Q?4eEC3+y9AQvzK1FTW/f6DiExVj7iwzWuhWIWNoa+jM1S+QODxS8/oXUaF3A9?=
 =?us-ascii?Q?tFIwNv1inkq/aWFCFVJMyfBYpg/+PqEqrgsA0XDWD18B0qXEp2pzNI1ObB7s?=
 =?us-ascii?Q?PSN4LNKnw8vBQ0ibUlaJ6cKwEwM0ZoNjC5zk0PmM1pHebp/v3QssInWxCQAs?=
 =?us-ascii?Q?fNsh/0db9Yw9Yjx6QeiHbA5ulvLWAR04Kbxd1iBPa2iHbMxk/rHl/6d+4yvZ?=
 =?us-ascii?Q?y/ri6KJnrmCy4A47faag3/mp3tAujjguc9bZ5j0sTFXocGzl3ad6G61IiFzQ?=
 =?us-ascii?Q?1zgsETn77A64oZdRFRqiAc7rBio52M+UAN2lLfrsD14trr0Xnm0hoMIxrB9S?=
 =?us-ascii?Q?3KtfoPhxSS9FX3CODPAZYk8b6p1Uf5jKTxY71XX0RVipTY/RO51H1kQAv+8P?=
 =?us-ascii?Q?OMcUqKJTGFtXJzBwcC3H/6kEb6XtavHhskkjpgAvwEAcn/K33od3Do+Un3yR?=
 =?us-ascii?Q?uvzCOl1DT7epws1bAkjd0JvwQ7uKuD1bn8jNr8fnSii1/j5og9QcECjiiYuN?=
 =?us-ascii?Q?odNLbRitgcZ+NkdsBugMmCZy9cvk9ZsaxTxf4RWGupOS8v83jAilKJd1tSvM?=
 =?us-ascii?Q?PahK9oybrbMIZY8hBMXYHYtfJOckQAqqGG92pPYJnO84lCEqdtJFJhC9ayWy?=
 =?us-ascii?Q?2lJmf3oNMYrWd1xf41joEeMgZjFVPUSm0m54+dlNUkFIL9ESxZXK6fjidpg3?=
 =?us-ascii?Q?Hvhhx+myPhmSVtEK9cmqVoffyKq4+uOK46XrugZhgC9YTIe+UjKtNUkVRLEg?=
 =?us-ascii?Q?DFfE/mYO/aqLmF/4XkY4z+vJtLSXy169TkkMPsnDJ59fkSaLIWybsbzO8lVU?=
 =?us-ascii?Q?zL71/iqkaRfKPHNFAJmvrdNs1Sby1o5vBV2q4j6b0sWD/nTGO5wFI0DOBHyS?=
 =?us-ascii?Q?ku3bTJujJQpCmxt5ictyzfc2Ls6MwzOqw5Ish+C0ltCWVsympujvbGCxOrgk?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GlEZ1MRlOc4omfHAAwCcD/RTO4jlCyVBpKjAAfWF//BBB+T2qXB2wrSCLddb+PkonNt5zYh2XdHY/J6lxmBRM7Y5HxatJvHQYmh8ntlMZWD1Dp4WaASLaYw9W+vRibuDPoIac69cq87urBhhRq/qxhGbx+qCw5cTjb2AW6jx8baDqd70BWza5HxzrHm6ZN+jkjK2yP4aRpx7WSU480omPCN1ksoX2kLgiwKrmSx7MhK3O6UpzO/TGHjPYvXJdcyuwTC7xG4owpZcYpTTRvOKuNGYAYCEXsD7POJEEj9TnKvc9bsWK7cDR0rivkS+jsM/2B0XvlmZVBLgWiTUjvByabC1cKXfDPb2Z0svoDIz7PGN7qB/0cdzS1XCMgh7k8StX4bRe656W3KPeqAUNVLT7WLhFKBFp8z2tXx5xEX8oOAtcCznsaIS1+EQLlY9Ecqj+cyIMS0QYfiLElXnN+4nqwdwM5xiZaU46aMrF1zvg8IFBUmgLqYcJrcyF9mVsvkn0FGL4dIg6M8A/rKX6QNewKgk9mD10krLQwQdjZZoCu6Vi5ixOt/pI+WNBEpcS8+9t+iyHT1zA4jfKowOoTNACxDVMlFUQQWB0Lx+/rflprZ1bHo4mFJutfu8zD6uxjUi+Yxiupxd8SGML25BIT13xnwfg/2KbeiyGxBbWE4WG9qXZc+Bn1MFrlo+vjOhD8/VKwNWBnriAQs1uILQJIG5QMTC8Fo71x1APUTvCX8RzBgLzOcJN3RQB8QKynMQ0+WmXSsMUpQO5D1UdteqTZ+g887zglwXGqWPm06wG7crvkegakJaMd23aVH3MxAxkwMGROkvUaKFHNVaYB31pZvHIA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6b7fed-997c-48e1-a4c0-08db97521c7b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:25:12.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15QdnAbPuTnI9iRGvZE7Q6iYBOiYwL8E4iVwEJKRfsDD9PeZ2whRBRBPAxiYRfljk/Yl2BBrI+yYDjXbq34GHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070133
X-Proofpoint-ORIG-GUID: rI31e5K5iTWWrQ4bQvjDOQ1uoOqZiUzB
X-Proofpoint-GUID: rI31e5K5iTWWrQ4bQvjDOQ1uoOqZiUzB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 04, 2023 at 07:16:08PM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
> 
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo, thanks for this new feature. It's been applied to the
nfsd-next branch (for v6.6). I've played with it a little using:

  # watch cat /proc/fs/nfsd/rpc_status

And it works a lot like a simple "top" command for RPCs. Nice!

Until this work is merged upstream in a few weeks, there is still an
easy opportunity to refine the information and format of the new
file, if anyone sees the need. The only thing I might think of
adding is a comment in line one like this:

 # version 1

to make extending the file format easier.

Thinking aloud, it occurs to me a similar status file for NFSv4
callback operations would be great to have.


> ---
>  fs/nfsd/nfs4proc.c         |   4 +-
>  fs/nfsd/nfsctl.c           |   9 +++
>  fs/nfsd/nfsd.h             |   7 ++
>  fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h |   1 +
>  net/sunrpc/svc.c           |   2 +-
>  6 files changed, 159 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f0f318e78630..b7ad3081bc36 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
>  
>  static const struct nfsd4_operation nfsd4_ops[];
>  
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
>  
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 35d2e2cde1eb..d47b98bad96e 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -47,6 +47,7 @@ enum {
>  	NFSD_MaxBlkSize,
>  	NFSD_MaxConnections,
>  	NFSD_Filecache,
> +	NFSD_Rpc_Status,
>  	/*
>  	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
>  	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
>  
> +static const struct file_operations nfsd_rpc_status_operations = {
> +	.open		= nfsd_rpc_status_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= nfsd_pool_stats_release,
> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1400,6 +1408,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
>  #endif
> +		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
>  		/* last one */ {""}
>  	};
>  
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..50c82bb42e88 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
> +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
>  
>  void		nfsd_put(struct net *net);
> @@ -506,12 +507,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>  
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>  
> +const char *nfsd4_op_name(unsigned opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> +static inline const char *nfsd4_op_name(unsigned opnum)
> +{
> +	return "unknown_operation";
> +}
> +
>  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>  
>  #define register_cld_notifier() 0
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..5e115dbbe9dc 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1057,6 +1057,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an odd value after the rpc
> +	 * request has been properly parsed. rq_status_counter is used to
> +	 * notify the consumers if the rqstp fields are stable
> +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> +	 * is even).
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
> +
>  	rp = NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1074,6 +1083,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> @@ -1149,3 +1164,128 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode = file_inode(m->file);
> +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> +	int i;
> +
> +	rcu_read_lock();
> +
> +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct {
> +				struct sockaddr daddr;
> +				struct sockaddr saddr;
> +				unsigned long rq_flags;
> +				const char *pc_name;
> +				ktime_t rq_stime;
> +				__be32 rq_xid;
> +				u32 rq_prog;
> +				u32 rq_vers;
> +				/* NFSv4 compund */
> +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +				u8 opcnt;
> +			} rqstp_info;
> +			unsigned int status_counter;
> +			char buf[RPC_MAX_ADDRBUFLEN];
> +			int j;
> +
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter = smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			rqstp_info.rq_xid = rqstp->rq_xid;
> +			rqstp_info.rq_flags = rqstp->rq_flags;
> +			rqstp_info.rq_prog = rqstp->rq_prog;
> +			rqstp_info.rq_vers = rqstp->rq_vers;
> +			rqstp_info.pc_name = svc_proc_name(rqstp);
> +			rqstp_info.rq_stime = rqstp->rq_stime;
> +			rqstp_info.opcnt = 0;
> +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers == NFS4_VERSION &&
> +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> +
> +				rqstp_info.opcnt = args->opcnt;
> +				for (j = 0; j < rqstp_info.opcnt; j++) {
> +					struct nfsd4_op *op = &args->ops[j];
> +
> +					rqstp_info.opnum[j] = op->opnum;
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) != status_counter)
> +				continue;
> +
> +			seq_printf(m,
> +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp_info.rq_xid),
> +				   rqstp_info.rq_flags,
> +				   rqstp_info.rq_prog,
> +				   rqstp_info.rq_vers,
> +				   rqstp_info.pc_name,
> +				   ktime_to_us(rqstp_info.rq_stime));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.saddr, buf,
> +						    sizeof(buf), false));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.daddr, buf,
> +						    sizeof(buf), false));
> +			for (j = 0; j < rqstp_info.opcnt; j++)
> +				seq_printf(m, " %s",
> +					   nfsd4_op_name(rqstp_info.opnum[j]));
> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> + * @inode: entry inode pointer.
> + * @file: entry file pointer.
> + *
> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs handler.
> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs server.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (!nn->nfsd_serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return -ENODEV;
> +	}
> +
> +	svc_get(nn->nfsd_serv);
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> +}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index fe1394cc1371..542a60b78bab 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -270,6 +270,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..44eac83b35a1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
>  
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload
> -- 
> 2.41.0
> 

-- 
Chuck Lever
