Return-Path: <linux-nfs+bounces-879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A34822FD8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC471C237B3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54931B291;
	Wed,  3 Jan 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="At6gkaOt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fWFEZezN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC141B279;
	Wed,  3 Jan 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403E5jB5007205;
	Wed, 3 Jan 2024 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=jGiIBbPaRb8x89kUrjtOfYLkNyVVsFLWzownkGNaRBU=;
 b=At6gkaOtpZcs/B6X83pJ5HqlPJiZr82VL6hXb6qB7KPZ3gDHQAgKHr4xfxE+NwOmxtsf
 SnVPIUvLRUrQ8Sdnn/Ft/5JzmBlknoINAm8aEBYBnVChF9qtMG5t7eA/zs4uwGmMjit+
 KiHdRA3TMH3Ghib31zSITLfkYYdhF7hvOClTG7EWkWvT2SWjRa+7XLj8ka3jXq92UKJP
 PRBc1At6WI09y6CLOml/17MadqDT+ZluS6Q3q25HmHfBEWq/Y3vwjNx1efK56FuaB95g
 jO2aYiTrzer9dNL9R0jEq9W5vFbqawEIgD8cMKtEiDCujkD8GhCgdDVcxgRmtK1imhFz aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t256a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 14:49:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 403Ea9Cn007163;
	Wed, 3 Jan 2024 14:49:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vd9g4s746-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 14:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZihxl4qP1qajtclWdp63G1FUT39Yo0y0juOy9StQCebl8efpoOutjfRS4wEXftz08h+S2W9psQoC4pxomPQ1YavY9B0LEFV4udfKqbcLGIKwfWnQgJeHuIS6foAtuNPlnSRUZ7lMNvlsRJj5flLoPjBV6dW3/IMOoqzH4ahJNtEB1sZQ/iFtxoJpTG8tQSwN5zgc6cU9ifgGGZuTcKw2slf/ewAFHnC3ZLAEKPTT4M7b7hHn+8KjpdnzexZbivo2Xz3xBcP3qMzl2ocjiwVY9W1J1LtCfnWpRh9DjwhQP4Ag0zt46vzOK2juW0S6WV9a8unKNAkdSGWlXnAiAnr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGiIBbPaRb8x89kUrjtOfYLkNyVVsFLWzownkGNaRBU=;
 b=H4LKfen65XhRZwyXlELA4d/+1eelAGtxGLIjTlOy13MwFIjS5NVr9E6dydbQt7GsVTOgfF+pXsjnM9Q4H01h/IrAS0ZE3plBHGRgO87mL0RligfiHBR/eCdtIzE+c7oVoNJY+dOWHJ94tqLSpdN3ASixxBnjX1wcIsMd5Nc6EWpYFVKnKjvNLfHWIrqsRGFOrNB/kjQJphoGFw6OH5Lh227n7tUMGRUNiwsQEAKkLR97b8DOect+61zk4bLvcsxtT7YlhymlI90baVejQ8bZPd4Fmz8ISuYxlpDS6dRnI+zqHy/a1DvgV75YWsEG2GLSM34ek5njdW5ZeBTrDiX6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGiIBbPaRb8x89kUrjtOfYLkNyVVsFLWzownkGNaRBU=;
 b=fWFEZezNgo2idCFRcBBo/tyVBuLkScL+b5EerbBvZ+czHwod2pjuFCfQCbld2BUG3cGiuw1SH2X51KfkCwJ0c1mIfMamfotYmuCGQRa4G+3tPIEanLgXAlJZv7bDM2ttvIkINoG26s3Ll6Ps9ESeD8PhBrbaa3JY+WlgqMKeLeg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4483.namprd10.prod.outlook.com (2603:10b6:303:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 14:48:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 14:48:57 +0000
Date: Wed, 3 Jan 2024 09:48:55 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: drop the nfsd_put helper
Message-ID: <ZZVz1wd/oTvBk3dU@tissot.1015granger.net>
References: <20240103-nfsd-fixes-v1-1-4f4f9d7edd0d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-nfsd-fixes-v1-1-4f4f9d7edd0d@kernel.org>
X-ClientProxiedBy: CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: fe48c016-d89c-4482-9df5-08dc0c6b1d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pylqCijGwWzENaukbzIlFwMPfa2x8yco98L8bHn2RA4j8cgXNHc0cbAXg8UAd+gHXFA0rIiUyDkmUxVkFoXvldQzHli9HxmYp01BROYZ0LFjb4GrBSmV59zpUnXroIELQrw3uQs8fA45IE52sbxT4erSGCy+u9WF/EKWUT6GFr2d2h4C7rgERkmrVd1w+jZ9Lhz77u6Oc08cPYp8nVXBun2jVboDS5W8WzPcc6JmZ9NoTQm9SVQl33KFcgLuBN14JAWSIb6zdwRlY0jtbU9WQ9cNrL0V6GDfRWyNdv319cyPsJxGAWQmc/8rf5oqoJgyhoLP1PKnhKL43+ZOYW2tsB67CHV1bLJUR4BeCs9tYud9+GX/op0p4gasEArh+PeFoUK3CY9hq4ZEHZcUI07J4jqo9JT+EQYHOZ5uptqNNyY5Er9zUpApehInCeWa2TfXEEWc0g/xY0n5RkCieh34smgTN0GhnGdqm4JofGLJfwxZAL8yLEEAS3Kporr3zEyUVaHe43l8I9VpvpCLNSPoWiH40zyICeNj6yItCVlWJcl92umnr6mTx9R/l5h0xDcj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(8676002)(8936002)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(44832011)(6512007)(9686003)(26005)(83380400001)(41300700001)(38100700002)(86362001)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GGhM4AtheoxMiX7t6RA8SLGQBZmF2Pb70CNBDaDovJsXNa/NSfBV5Xcrj0WB?=
 =?us-ascii?Q?FDZb14f60OMRdq0Ss8h2qQO/gxYNz+vSeHXuaBqH6jvhDethRYQoui2WM4Km?=
 =?us-ascii?Q?2zzr0/8deQQm8WaAVZvabAGJ7cYeQ7vhKgIC9IPvU71hBUUYKLACTYLObf/I?=
 =?us-ascii?Q?XZxYGaAD2url2pewG58lda1Tyhl99tigKjdtTmB6XuzjK6lyugE0KZ2uY9uU?=
 =?us-ascii?Q?SqMAfSvLSR4/EcCQg7qgY43Rg3049gMscC9rHC2nIOrAifL4wpHbxs3iNYCM?=
 =?us-ascii?Q?doxUC5WjTD59ZdhKVfit1P3nmsHB3HfZBlq3ShoKzawSggqCXqGcLdeLkTEr?=
 =?us-ascii?Q?CRi1CBsW7m/3jYjF22U5mtZo3ae0bD2cP07wFEfg/u6DDrtjCBPW9BfDNk41?=
 =?us-ascii?Q?pmZtxYomgdgeghcU9R03ykp6R/vkKFTi77+lagdlBc5kzQFaIQEFZtmKWOtI?=
 =?us-ascii?Q?+5tRTG/QJ61c7d+xtKtXgYbf9uo3+SqsMKqss+cPOADmXz+lmDDkI+yZtpXZ?=
 =?us-ascii?Q?F9AOkzx7bH9rVXacco8UltIhSA5Z8KiGi4hYmcJxcQNZyecRiEZECxfCso+o?=
 =?us-ascii?Q?Ab+M2WjfQDcD7hwTvRmol80BFwGApBOPFXuq8SJoKSv7/LlQT4mWryRf0nSS?=
 =?us-ascii?Q?0bK/z7x0VCBpnT19ZHkOQ8efvtI14AjSh04DadrpWfkr2ZgOk+PEXtPumaAL?=
 =?us-ascii?Q?mp8uORKD8MkO0f8Mdj8XCJKQ7CgK4yKw2tHlTMP4BRSYelPaHeVrZ3P2AY+Z?=
 =?us-ascii?Q?NSrEmIJE2VNdjyUzUcmDR0wvblkx9h0CHkUxOTOqmk/Hbk88uOElTqxYg2Ea?=
 =?us-ascii?Q?/cxUNPop0OFusuBijpFYbLcArx9/WiFHurDJbpNlgPPO3VgtL1MRo14lTJQg?=
 =?us-ascii?Q?nJuWSxUP9Gv/NW8NrwQN4In+okF6iHQJS8u7xUpeC0ra6TSHkhiueJhYK/Gv?=
 =?us-ascii?Q?kiLPq3yj9R7eUxkcZ8kMrbkTU689uKagubIat2IWTX5YhF27SF4kykC6i7JY?=
 =?us-ascii?Q?TTCNcJI5aaC4D+42skV+s8YB+AMqUOrPo7YHqyMcfJDSJr6S/vDHh6q5yW7U?=
 =?us-ascii?Q?pYbXS9odGHV2RVlzC8IqRnml3J0NFkh5pxTpNsh/MRineAYO7YyfpiUeQplx?=
 =?us-ascii?Q?4xa2uBiGNT8XzE8KPX9suQ5I+z+Usl8NSyv2QajoES61lFD01uHVEr0niHm+?=
 =?us-ascii?Q?tYFaU9c7sEINIVFqx82SGA9Qt8o3OlyO5EGqsFw5fGZGmf4iiWrz6GBBt6Dd?=
 =?us-ascii?Q?lBMV+Q7/PskefqnhCkB2xyY3mZYCZ9yo5Kg4qqDLtgUubaWZCF7wAewi5h5f?=
 =?us-ascii?Q?O7pub/MsKbEAlJQ1cfwO3pFgEhWGNH3SJs3xuifXdPopvbuGj3vb65tppGPW?=
 =?us-ascii?Q?3PGaEX/fiP+JhIE8QGMGAk4BbSieC3MHPk/ATUzEGGsa1mVCmgsPMbMZH8Kg?=
 =?us-ascii?Q?PqKE1z2hT1llSnxdU3xDcXJrie5z47R44fSiZ76tImSJcvj2XOGRLGEfb5Hv?=
 =?us-ascii?Q?0e1K84MG66wKuI6kzjEhuZv+0pJTrwWJ5mEz/oeFe/TA6RXo+bLlckdlHk90?=
 =?us-ascii?Q?PeF0yHFPFSNiFqasKeZ1Vn9A1zprhMfwtaFs7aEo4iWUuFThAdtksG/fysjg?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eTZoqh0dwqmqCinqwe5Erk/EKb1beZsAdO9S5VFb16mfd8i/S2GWCkFMQqbhjc5VYJR2L9x7C4Ug0CALvRKwcNuCr0wAu95uSIHyEWvHBhaVcPhDc7gQDef+j+102wRvzUKapP3roGHOxA0Rd01p70SBUmU+jPNmi5RcrDexG+1ZQH1EfWOmjp9mZ5vEjuL3NX+RaRYJr5xCsh+qV1R8VlIu5hcIWVNNvkCF6IJJXgHZpMIr6gjnSrZO3zO8wL0NR7YNhwvEB18ytibAc2Lu3/lgwgF8suf+QeRTeGXTQ7JhoocEbIhARolo6KhlRDEq591GQa7P9DgPUsC0EikadaXfOdZqiBeH7lrZH0J8GTZXFBx1AouKTvWhKEo4a0lwtq6kdcL703Q0WhtzD+IhVIpJqKyxGJMbd7Ucqbgs9DG3kTFhRafMqkwNAbSy87QJdvQEUOLbxmXefvtXwniarkFoBk0Bri5Reb3DCc2YKk7RiClqubVc2OnW/wIdHm0JVfyy2Qf2rIh5iBYJ1Qqf2NP/sZcStRvzZ+cvxACCLpIOTv7Nm4PZ/Y6vjVQiiZTCDYfl/U7cbl31q3q8t9MbWlKlPXUN2hOGC8e4Z3iIEV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe48c016-d89c-4482-9df5-08dc0c6b1d89
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:48:57.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Vp0oMXwT8cm6Y2+ImOJljc88Q4gRRMn7ojCiWaPOZct0benGLEiKzEq6+e33sRjC7MKriZzw2WtwCW/VAfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=794 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401030121
X-Proofpoint-GUID: pUwzJTnlwEucC9xzvqLlFEzOdDy7wnml
X-Proofpoint-ORIG-GUID: pUwzJTnlwEucC9xzvqLlFEzOdDy7wnml

On Wed, Jan 03, 2024 at 08:36:52AM -0500, Jeff Layton wrote:
> It's not safe to call nfsd_put once nfsd_last_thread has been called, as
> that function will zero out the nn->nfsd_serv pointer.
> 
> Drop the nfsd_put helper altogether and open-code the svc_put in its
> callers instead. That allows us to not be reliant on the value of that
> pointer when handling an error.
> 
> Fixes: 2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> Reported-by: Zhi Li <yieli@redhat.com>
> Cc: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
> ---
> I know it's late, but it would be good to get this into v6.7 if
> possible. I think it's fairly straightforward.

How is Zhi finding these? Are there administrative API tests that
can be shared with the community (say, by adding them to kdevops)?


> ---
>  fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
>  fs/nfsd/nfsd.h   |  7 -------
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7cd513e59305..87fed75808ff 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -693,6 +693,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
>  	char *mesg = buf;
>  	int fd, err;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv;
>  
>  	err = get_int(&mesg, &fd);
>  	if (err != 0 || fd < 0)
> @@ -703,15 +704,15 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
>  	if (err != 0)
>  		return err;
>  
> -	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
> +	serv = nn->nfsd_serv;
> +	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
>  
> -	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> +	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
>  		nfsd_last_thread(net);
> -	else if (err >= 0 &&
> -		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> +		svc_get(serv);
>  
> -	nfsd_put(net);
> +	svc_put(serv);
>  	return err;
>  }
>  
> @@ -725,6 +726,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
>  	struct svc_xprt *xprt;
>  	int port, err;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv;
>  
>  	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
>  		return -EINVAL;
> @@ -737,32 +739,33 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
>  	if (err != 0)
>  		return err;
>  
> -	err = svc_xprt_create(nn->nfsd_serv, transport, net,
> +	serv = nn->nfsd_serv;
> +	err = svc_xprt_create(serv, transport, net,
>  			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
>  	if (err < 0)
>  		goto out_err;
>  
> -	err = svc_xprt_create(nn->nfsd_serv, transport, net,
> +	err = svc_xprt_create(serv, transport, net,
>  			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
>  	if (err < 0 && err != -EAFNOSUPPORT)
>  		goto out_close;
>  
> -	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> +		svc_get(serv);
>  
> -	nfsd_put(net);
> +	svc_put(serv);
>  	return 0;
>  out_close:
> -	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
> +	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
>  	if (xprt != NULL) {
>  		svc_xprt_close(xprt);
>  		svc_xprt_put(xprt);
>  	}
>  out_err:
> -	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> +	if (!serv->sv_nrthreads && !nn->keep_active)
>  		nfsd_last_thread(net);
>  
> -	nfsd_put(net);
> +	svc_put(serv);
>  	return err;
>  }
>  
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 3286ffacbc56..9ed0e08d16c2 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
>  void		nfsd_shutdown_threads(struct net *net);
>  
> -static inline void nfsd_put(struct net *net)
> -{
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	svc_put(nn->nfsd_serv);
> -}
> -
>  bool		i_am_nfsd(void);
>  
>  struct nfsdfs_client {
> 
> ---
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> change-id: 20240103-nfsd-fixes-1f1196134a11
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

