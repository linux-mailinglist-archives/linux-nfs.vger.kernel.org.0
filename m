Return-Path: <linux-nfs+bounces-642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6181506F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1DF1C203A9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4A45BE1;
	Fri, 15 Dec 2023 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z19GTseh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkTUQu7k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F445BE0
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFI48Ux004535;
	Fri, 15 Dec 2023 19:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pqDEm0ncR0aUzDi0bixrhzlgcG/PlFp2jD5tEDYK5Wc=;
 b=Z19GTsehAL0C9mVVE26zf9n4fiJtljipzesvkcfkvZT6uXTygPBCEvNQa3y7esAr0L7/
 PTkTtRFPXMbJ7JSBRZXL7BfB7okbg6mLJlOvp/kPeEQp1q4ys9uJg/9S71WiP7BOXY0I
 avxWMx7TrxWc7Jh+g4U8aLzUUb73KXGf9+/HCSuxgVa3tnp3wRxyLJEQRkTmpVA06It0
 N+YxRARMlZYhi0wZdzwvMQEYSGBTrRSp7z3khh8/4MXeFIpZV4cIDW4ttLB/oikQ/7GY
 QYhi6XvyQg8RPmGOGE8nbU8CRAGrmsMLa+IlDBk+z+0msVsTubK22qN977jpPYAc2XkT pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuue65b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:54:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFIDjFS039644;
	Fri, 15 Dec 2023 19:54:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepc9w3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcr5etkI4w9UoYGuELa3C4brHGf1peD2evO3qfEAZJjqV+0dTcQ1lw+52ryy53uVm1tru5PG2GEFrViqMfrwv0NB84Zgonpk8qktilh58KRurM7sFd7ACscz9N4fafIAg7Qu4zK1E23mc3XNOd0/Bk8T6hDfM1fl70EnRKTAhINa03G8jD9OGyipzsl71vUofug/7GcaIgjF4NZE1J9PllDmr5LxjGnGtoGRKWMVXH9c9PogKFBJyDXVzn2vmSOn7pXCKXSjpid6cyLEmdp4HnN3bERXJ9BXzjziwjXonwCrU+5rmhLHJOeLnj9hzy5GrFgvRoX2IpGy+KRaxShMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqDEm0ncR0aUzDi0bixrhzlgcG/PlFp2jD5tEDYK5Wc=;
 b=Q3GX+Iuo6QiBC26voCqjkwoqkPBc0+XLhRHfrGmdT06ukEBIfqwDkYYaiR9//jUH7LoVjTrrCeQmo6OJGjprse+0fggU2rcnomI5lwtS9CW9pWtwER/yyKxE3cTlPKDP0mQvep6x9BPWqa/zk4MEcPpyjyxNsA4m4JeOKTtA2QqICGcGON7+YTcqtNm59Z9bdejEUzz720LP6tdBTQegWuo/vWWTtD+KA79VmsWuZ972lmOT4An84pVWl2arjDWd5gjDrRy2mf314OJeWKNqeZrH0p56yvv4AE7TX3WGaMPvXXcgg8asCB114DpNsYAi2BrgtPOUr/JlXr3nYfORFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqDEm0ncR0aUzDi0bixrhzlgcG/PlFp2jD5tEDYK5Wc=;
 b=wkTUQu7kFfisres19iPMGnCL7yLUylojEy8Wf2jXVZCtdpVQsiD8omwpIjyi8dWNt6l6g3+v0DWHi2gvnoGVtzHp6QHx2Jj6sTT3YZM5z13utFJVSmW7BBVDBDTa4eMHhqFYnPzInlbdY9PqBU56/ASBsMEeUvcmzWRi7eaQYoc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 19:54:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 19:54:53 +0000
Date: Fri, 15 Dec 2023 14:54:50 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH5PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaa7cb9-5172-4506-6f04-08dbfda7b44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lW1daOJqUGPiQoOUiqdifZ7ke3a19Fg/wM2u3GB1t/wTUGvVpKZZAoYZA4aWwhNhpmpLro5FoAvreOi9nAiY7UL3GG0+4NbTD4X/BqqH1+U5uT+OjJFDurXCEoGSiLKXrPbDYecd2/e4zI5Zc7le7SEQmyTfDqa2gJoguulxuX/pW45UixEVFJrlHlA0yhCbHAR+y4Ugy8qiKOM1m6d/1mfPXJBjB3W1caHDWwLKO6PUCHyfSbKTXrWf3Nab5dKrgAetwSn4QHY3r0yzEUptB89QgxDthbIm7OT7h4Sizh6zLKtdCLOWMcbM7trdL+vvSo1sgxsIqTFNldMrlo/UqHlsMfgG5m4/M63Foqx77VIlR+6QvUeM0y0zlDSse+XvzzkU9eHk3yWo7MekVkdeipx/4I5Rez0znRFYfrH4MJNKSBjfnWzM2KD8QM37/sbUjslG+l8mgZZQIof89Eg282Ly1g9ftDogEQ0G5ZWdS6VC1dezSmh0ya9Mw2rVLArOKaY9uEmKdITq06YcyUE43AiB3GvFyyKsCjHR7Fct2lNzpSehj6OWeUDIb3lCScib
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(5660300002)(2906002)(41300700001)(86362001)(6506007)(66946007)(26005)(66556008)(66476007)(83380400001)(316002)(6636002)(6486002)(478600001)(6512007)(9686003)(4326008)(6862004)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nGob9SsIQN/eZvjgGKMRnuGMTFV1qUE5fJv7GgREDivm6CHcQdd8GnVDU0sX?=
 =?us-ascii?Q?NvbPaaXGNI/Ta/OANWdQ3fWksJ69jJ467wXRT+Y21wKy8jUI9c8AM95xgWqz?=
 =?us-ascii?Q?Qgef1Jf1QZBjbHp+Nn11N4FW+ZfJ+WSZ1+WEyeQotAkTDHveGAogu9EbeCeg?=
 =?us-ascii?Q?AMpEAWwEaLJkvPDEbC3bhThEbfEuPZplvoE7v6kadVBYW+hzBjhy2WuqGOI/?=
 =?us-ascii?Q?+ob6M1/B1soO3Rb3i/Ajm9pyYzRIy0NIdioUXhv1QehN/JdvtZ3O7KEBAjYk?=
 =?us-ascii?Q?bRltTV0IIzm972AVPUXv5JbCE2UEiJaGDIzI86VyghLuCPuwWTvOq1bltpnW?=
 =?us-ascii?Q?8v2dnJQbXRBTvW8ULqHVOwOdMeZABZVgww6z8+woxaUNzWlCGAZrzvaZb5d+?=
 =?us-ascii?Q?LJujiZi/nuyxp3pTkEgWw+8ZNK1XGY8rs2TW5JP3Pq+sJcBtX61MBK36Yb8o?=
 =?us-ascii?Q?zNdJqyIyBY9PrhtyovY68eOIB/1rZwjCjIP597+iuuaO534KLwvlIt8b88M8?=
 =?us-ascii?Q?4x52nfXRpdLho4dJN1QhgxMpKmqNtGsKLWTqudzCARXydhm2kTs53zhg+p7c?=
 =?us-ascii?Q?pTwfXEzLHXGKz37xlPdkpsCVW+pXAI78oQHxpJEF404YrzDxEDrGAVRvQUI+?=
 =?us-ascii?Q?wsxpYnlRjaI/RkmjN9xHqKVkcwc19UlNXeF5LRQ0cKEhDSS4Qia9NQT9K8qN?=
 =?us-ascii?Q?Lk+ANX1Kgmf8l4xAA5i4sIvXcLzUOZ/YLTBbjtc75dfNCuYe8/OoJj65wwpG?=
 =?us-ascii?Q?5FP5cmfpmsDO9OQvmTD66pHSj/Hk6A3t94t39VTXXzbox7dpqmht/rpokYwG?=
 =?us-ascii?Q?VNcXrR0JdnVY3plbvydBdITRaKQaBUR2KUCUhYi/4EtJuuiHls+eOXlPeN9N?=
 =?us-ascii?Q?sZD9xY36+s/ODcvYGPy4kDrpvgNnEPtWQLvQnpa5eKQlOe3hqAaedlGo8P8X?=
 =?us-ascii?Q?lBbjpbIdBXcAzklzTNKPp9E3QHyKD/9JmRfpNJC+HFOXGi2vSYGjGUCDyQMq?=
 =?us-ascii?Q?lW9MSzYa2yRLR2BI8XYGyip+7rYu5Y3CEWo/4H/U/t539FGP93nwOae2uQwC?=
 =?us-ascii?Q?l6rKS113qzCzrI1RD8puoebgFiahO7agixbTcq715dYN/lxUtlbB7JYX0wb5?=
 =?us-ascii?Q?QIGU9b2w+gNRPJ4QwXEMATOM2L5h3iVchQlnPjlLd1sK69tHkADExMeKHWuZ?=
 =?us-ascii?Q?lbGkqP9E7F9N4hY/xbpDpIczrlWhh0qj8t43Hy7TGDCevgySG0RNSF+4nmQK?=
 =?us-ascii?Q?xukhdzrfH8reXhYCUS8rSBkMss1J6LnMqWL9xZnDGTLLfrhCv77q68aREWk6?=
 =?us-ascii?Q?hC5kZAXNDj519YyKoylMgyABxlZhZ7sT6bky5mhXmVsvjlkiJKQq986IAq+e?=
 =?us-ascii?Q?Fg6et0qg25gw/htAfkDnEJ3EUOJiM5GowDHEFyvMob9Cxa94D2owzGoy2SOF?=
 =?us-ascii?Q?rOg3rV8ARCP3B08qYwoXQzL/Py9upaZm64MzE732SqCUojJQIgeHS12Y38si?=
 =?us-ascii?Q?mLuxBubBclZOHc+jcS+XyRTP4NAW6HAFvdIBP89zFVVs/phwyJvQKxS/mPij?=
 =?us-ascii?Q?QZk8vOiIRChqkNjDt8I1EV22//o8HgRvdA4x408sgOJN82W4ioP+z4c8T+cm?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Oi2J5bW7s4tQC9mrmyvjpfH6sMH3plGR4b1ij1oDOHvveuplfHgS9/a27DIj7jBD0efo5gzwbl1mYT8p/1UZfMotjLgg0fIjpsDVyAoUbiKBqXeGe4jLPNtapLZZITvciSixNS1mJaN2m6Qu7yq9WF1AM5ZGOm3Qzr9sH23NoLwNGn1422xPIjiv23V04RCRqh5CPutf4r1SG+pQohgFtBhVl8npytjxAGPCHeHRR6C8buPGqeRfIdUjAftBtciEtDy27eyjYSOtgvm0I6O1VpmB1c5DX3CsnSxReciwTVPy8XDuVboKhWVtxph7yd1rozspptAg2oObH82AzHuAk+fPEQ7NFGDFBeukAKFcpnKK9wUwPFcD3IQsFWhPcZzYDmGEa0XpqkDIt4hW5ib8prS2VOyFRm/yTIdBWEVKbsIQyYD4gGHj7CcjQ80PdGV7sUjM2G6R1rHF5TcRg5kOTYOfVvQADiHtBB8B/gsNira8pKO1791t2d7cQaftqO+0hN+6Xw/GDqrDH2qvdaD2E4VGCotGviPd8PPMT1IZ/NZtluyqhL/fO8ovF5Pz1mXXG+vdh/5Jn58wDY9wb0IlHc/RMdSSq4fRhaHvGGZkeuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaa7cb9-5172-4506-6f04-08dbfda7b44a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:54:53.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC4njOVqJsQ3qyWOVH1k6/qK2UhIy6TDv6MacmqRzSD81XiP4OSJIUMiF5vlnEMKRgu02GBVZENQyJHhXDSXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150138
X-Proofpoint-GUID: Tszncdf9pgSFr0qLJqWpjNvAJDK2diSv
X-Proofpoint-ORIG-GUID: Tszncdf9pgSFr0qLJqWpjNvAJDK2diSv

On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
> If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
> also stuck waiting for the callback request to be executed. This causes
> the client to hang waiting for the reply of the GETATTR and also causes
> the reboot of the NFS server to hang due to the pending NFS request.
> 
> Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
> time out.
> 
> Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
> Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 6 +++++-
>  fs/nfsd/state.h     | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 175f3e9f5822..0cc7d4953807 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>  	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>  		return;
>  
> +	/* set to proper status when nfsd4_cb_getattr_done runs */
> +	ncf->ncf_cb_status = NFS4ERR_IO;
> +
>  	refcount_inc(&dp->dl_stid.sc_count);
>  	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>  		refcount_dec(&dp->dl_stid.sc_count);
> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  			nfs4_cb_getattr(&dp->dl_cb_fattr);
>  			spin_unlock(&ctx->flc_lock);
>  
> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);

I'm still thinking the timeout here should be the same (or slightly
longer than) the RPC retransmit timeout, rather than adding a new
NFSD_CB_GETATTR_TIMEOUT macro.


>  			if (ncf->ncf_cb_status) {
>  				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>  				if (status != nfserr_jukebox ||
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..94563a6813a6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
>  /* bits for ncf_cb_flags */
>  #define	CB_GETATTR_BUSY		0
>  
> +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
> +
>  /*
>   * Represents a delegation stateid. The nfs4_client holds references to these
>   * and they are put when it is being destroyed or when the delegation is
> -- 
> 2.39.3
> 

-- 
Chuck Lever

