Return-Path: <linux-nfs+bounces-945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A11824878
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 19:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C238CB24BAE
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8082C1A3;
	Thu,  4 Jan 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xes+9ML6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I4lP7Q64"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488C2C199
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404IvQ1G028458;
	Thu, 4 Jan 2024 18:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=rIPKCcpAHVW4R2GZqK6N+4163ufQq8R1dmmIJklx9M4=;
 b=Xes+9ML65f2RMqxv5emDMDJE1AMFbfn6GVxmvWCEeD/DIz0c1G1b0JT5pa+W9NQrrHsk
 c4yeGDQoHLsCKFl0AJpWlX4mp9rVa8/gmfwG+aB/2zWNrXwc43cuS619gL+JKPd7jOzj
 vtfRkTOl22KMESFu+D0tthcUqj7r7iDfvmLs8OECObXdoEnTwwHnvhwdPMNc9ImD8UBw
 2IDmOW7dNSsikDdu7KJyN2CfFZZS+uXRV/iweyJ86MEJoAusckB69udB2/CaGF7b8zsI
 TXYnstb4ymFgvsOcFStiHblhPXMHf2PrfJjjMs4Qq6Bim23hO1tLWEBeF6BtLo3xTUHO Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ve2dc80jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 18:59:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404HZLKS039477;
	Thu, 4 Jan 2024 18:59:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve174ce52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 18:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/lDvnwPwiYGWp/Q3/DPfPfBm4P072uQelfWX5I9tRGPThMRn4dqjMJgHl2MkmbswKmoFZt2jx+LZ9d3ndcElT1mdR8mE0Qp5leA18SIN9JEc0vcavOkz2HE5Os9qf9wWWqVsuV0xxNPEQdqBQ89ZpkgEJwSO4sBtPEEI/DvDCFbBAZsSbGkL0vUFCspH2cXiylhnQZkeJY+lwE6ld2gmMwI62uDuH5z07QhETUsJDg5TgX0kBbMExO7u2NHyIpF4rkaIgrYNdQYgB8nuZ0tB4k+R7B2uodgeLOhb07Jh4a9cBBghDoKRa/4LILdPTi/ojAQrGPLE1JdP/OvQddFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIPKCcpAHVW4R2GZqK6N+4163ufQq8R1dmmIJklx9M4=;
 b=ZS5zTl80gnXtkdGz6GJqQNKLVwZ6Y4wb8rJV2OSqulWO0yHDiNN/eYvPS/xRuhVVCSVq1ygWYqFn06c75gLuspNQ2516Ipnzck7soBSOT9K/lIIAWSKaaV/DOK1oJnbtP3p5zwT7AtGLmIvzijxQuKOLpeNfKYKhwgyKVEn9JbBetwowN/ShnvHq/uHnSirtOCPZGYRbO4zNn/iZZGjrymy88A01TSNITKf8NSgucdkumzbrAqWic2yfOdiY/U+160fYSUQ4Y76VHrIRl9dbgXFSeGUg4snaWhFE2xNVbmioX2zKYtJYPcBj9hmYz929eSi78QERdA+YHy/9G3RNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIPKCcpAHVW4R2GZqK6N+4163ufQq8R1dmmIJklx9M4=;
 b=I4lP7Q647gcmGcBZ8tIcgmq8b5qWBMj/656rqoqKwZ9ykkCDT9WdMYP8L/4egunhn8PPubnvEUb/hYH2HKKoXpywyNSclXAnmUtnlABDBXwwokvsG69S6EikFAWR6VRMO5R4yIKCpfDherpWimaDAdQtfWoC9jQBILWf9IHruO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 18:59:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 18:59:21 +0000
Date: Thu, 4 Jan 2024 13:59:19 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] SUNRPC: Fixup v4.1 backchannel request timeouts
Message-ID: <ZZcAByPi8EAoT88T@tissot.1015granger.net>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:610:4c::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fc369c-4c25-4b59-f41f-08dc0d5742ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DdXBI/XxMOwb3XbyzmTyE7slFhviIK3pfdbzlN1XGwAY6D0qYAqFUyDtPLZ5aqzP6212W4mhNyhyjxFG5usZ+4FRSpKZJ7i4GVlg06MRc+ReTrHFyMrQGfK9OSZXNXgZNCjzMWyNYXWHzNfjCgLj/Qb6dgI0pduTDoLRbn5PENl5O0VwdlOfH6MUyEFztdgPxiaQv8UAgPTz9jgd1XhSxCDIlse1b7uGC9kcuIfVySK2kchadTr8qZ2yiv+KYtF2NFqEeNRyLwe1iLoosjiO5VhvSoQZHIxF2AbNuwZWKgmWajNCHSIZUvK+VMgF8nblWaIhzJUyAnWPKCeT70b4eyGFebLCZPSSSQP/WVKJtUwArSIHipt492BTjsIlf3qt71RfU1W02cRe02trkihn/GGpVl9Fr2066thKX4KmNlD8XjgkhW22s1u4KMAreT2TWIgMecSq3gQPr1vQwU/VgSAGTo73RuKpu26HCxl+BAOUnkNS4byWWGT6SbVa2IviwItpNjgEVg7C6xbXNpdQ+rDot9RVlAh+zXlPKbX3DVZRE3ukvYwPl77HQrx8fGlx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(6506007)(38100700002)(9686003)(6486002)(478600001)(26005)(83380400001)(4326008)(41300700001)(5660300002)(44832011)(66476007)(66556008)(66946007)(8676002)(6916009)(316002)(8936002)(2906002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5BV+p9XmHGgHxtCINxH2sb7fWbGKueHM30FiIP1glEelZn75UtNPK6kkKaG3?=
 =?us-ascii?Q?RhNiG+yGP4Bq6rSB22g9unT4L8hoI6LyVFlFG4I5q1vTruWWhmXKQ9zmr7C6?=
 =?us-ascii?Q?EZfpfxdFhx5+73FMLhAt/CAv6lwD/ZoVkBCrqnU4Kf99gllj4EC9lScN0zT6?=
 =?us-ascii?Q?y8plsbKfbrr/nUaZvHBOjAsgktDNCHosR+YubMHEH6AX8NujMi8jV75JJCJi?=
 =?us-ascii?Q?KSwaNtDYPZAIkIBkdES00ZrmzzMPB3e3JM9iYCnRWSj2WYQVSWY1Pu5Py0d1?=
 =?us-ascii?Q?25gzS0Xa4MYGJWT+ema3Lcbl5bKZUPrYdvzOMgl6aRNeJkQODbTHvisi+iWq?=
 =?us-ascii?Q?oEy8/+O0YsAjatdi40Qur6Izwu0OPm4tokXGokfwR6H9VuUtF7kXw8sd5FX3?=
 =?us-ascii?Q?ATqF5kSllA4xMzW5gs1S9cWN13e1wRhk7YNVS6FMHc20aGi7JonG4u0YIhcm?=
 =?us-ascii?Q?C2jb+9pfnUfpCZicfh43QknVxX1Nv9tgl0ZMpWiZ5+u63UiIPitwvfMlhI3Q?=
 =?us-ascii?Q?V3vCkuEhLHA4F/dE8h4LW4TZqDSz1rACSY0Cu6KkPOKIwGKvBUxR2YyDMFn/?=
 =?us-ascii?Q?2npnmB96tc8ZlT++aMs2ZM/xol+kylLzJVM1fYbzINvpYqfa/Zf6QoH/BMu4?=
 =?us-ascii?Q?LqOjVQbLyfpePpwo2Bpplk1Wytyxpo9BSr0SsDNmodvnkKDjPZ2Dk+GQoSYA?=
 =?us-ascii?Q?hqE0gdHOY9ZI4yW67UHOzE+tVSY4+VJbILzBwLC2O3uy8YVBr9gVJW5Y1A2R?=
 =?us-ascii?Q?vyypXX3XPHr2PmS7RS2q2uczABTHSF3w63MbH8lsVk/+nxXpsgjOoycjDPdE?=
 =?us-ascii?Q?fLxuIpojnUeH/88y2pdMX2T8ehuo8DOlHia5DMiaMgtCCDnRiUpA568lSvZ3?=
 =?us-ascii?Q?9H4ItroXisBvPGVdbW7Ut7CN8Iz4wLppDBL9YQuIfHueXpRvuo0reKik3Tk8?=
 =?us-ascii?Q?8NdubYx6vtA376guFV3PUM0vHTM5e9OUeh9ozQ8tlVqANjtLneTZC5Pisj/R?=
 =?us-ascii?Q?0xNGivBoOO1iFChwV7tcMtCfBoHBI2BlUydg4rf+L0PdnqXhSsr7x9vUB0No?=
 =?us-ascii?Q?PcqIG+TuuIyYpqLWSnJrD6AAV9guHI3W/bCyFHWLGto1Oto8ETrX+0gt5GV8?=
 =?us-ascii?Q?GDU2GTkqLCn2HwW4Dgik2b0fq2Kr4vn/5cFSOLmMdRUJAHqZwd8HzRLiNYru?=
 =?us-ascii?Q?5BHe6KV9+wW2z/VlyKMiljY6cVsPCMU40CpF+b9LMH1VrUzDBtu9NUnX112f?=
 =?us-ascii?Q?KKRdG/d+l17XtrrQ5uwztv0dzj+4VxSChupTZb9IIZDkKcr8lXf+HisL7Nlc?=
 =?us-ascii?Q?KNy+Lp9wd1Qs/DdmIRQlt2wvy/LP7Yf003Jby2aWOGJjTkqSa5pWcWhYqJ/S?=
 =?us-ascii?Q?3TBkIM5isZX/0/1z+PYuumg1oCQE9rWs6vSe1nVwsgqNrVtfWhSwDsXp8JX0?=
 =?us-ascii?Q?09OobOYGX5+gia7rZbnOsOcvkgCfG8R58yu6JHK0FKJ216jUMN0815PxScQL?=
 =?us-ascii?Q?MInix+FtIqFLNK1NM3rS3zVXdldXvWR91+YB3WSUYaiqFtXncuWKEMf4gQ31?=
 =?us-ascii?Q?WVSe76JKhWSPiDXTDqV9pXZwV7DvCJQJZGdriAC+hxoJ3hQquWatoxNk9qMv?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8+wezqwxsiCIviBHtqVwUHS38nNZvAbwe3YlU5NVWu1GN/H0ac1RYzDQP0pwx34fa20288T9sMjp2njNL8x66BbN8w1rqolGgqWMhhi32W6k5S/3AcINTFDCAGUTF65/LefVgY9cu/YUANO5zYRpM7Kq2JBgbkJI94YYzq3aZxze1VH9x6I4f3LOqxFl3BiPSaNGbb1AGoCwFtSzbI+8FDzLMNMne8vkpGLTRIeOMqThcYXuUL42RA6O5rgIISUIY+GPM1BNJffcQQcG94iU58JNm4BoUCgYpV1Zwfy+INlHAbMc/4UQy9m++blwPvF2t9+ITzCh/5VLH3fk3bBwWW2hiXenyIZcQ+cRgZZd33B0fvafSCNmScpSOXILb2VsdY0LtJLXSo2QhA8VI7rTHSQFedAp6SyyzbCA3P9+ImGlchKxAcDuB2ean2a90fPm65LaP4QymmtTOKRX0UYdzkDXV16KvbXg/fwc0dT5xGx3Fw0wwJyMvkub3x6PUJWPpGeH4Jo8m5SU8BUMzZTe9lRw9NitP91+iS7OrVy/pIZ2FBMmlcSbzYro1gHsfwHtkxSinsZRS8ExDbYy0+y01pXZKclnoQC8U5/0dOiPVc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fc369c-4c25-4b59-f41f-08dc0d5742ea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:59:21.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfBZ7cORj+nA0Mv39d1GjB5L96aSZtqQM+uO73q614owPRAkIvupAQeCeB7idm5qYxVU8NNqbeTBrYst3pJW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040148
X-Proofpoint-ORIG-GUID: u3UITyHLtnA_cOdZpWUeRThzhVjKq512
X-Proofpoint-GUID: u3UITyHLtnA_cOdZpWUeRThzhVjKq512

On Thu, Jan 04, 2024 at 09:58:45AM -0500, Benjamin Coddington wrote:
> After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
> the sending list"), any 4.1 backchannel tasks placed on the sending queue
> would immediately return with -ETIMEDOUT since their req timers are zero.
> 
> Initialize the backchannel's rpc_rqst timeout parameters from the xprt's
> default timeout settings.
> 
> Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on the sending list")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

For both 1/2 and 2/2:

Tested-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  net/sunrpc/xprt.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 2364c485540c..6cc9ffac962d 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -651,9 +651,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
>  		jiffies + nsecs_to_jiffies(-delta);
>  }
>  
> -static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
> +static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
> -	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
>  	unsigned long majortimeo = req->rq_timeout;
>  
>  	if (to->to_exponential)
> @@ -665,9 +665,10 @@ static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
>  	return majortimeo;
>  }
>  
> -static void xprt_reset_majortimeo(struct rpc_rqst *req)
> +static void xprt_reset_majortimeo(struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
> -	req->rq_majortimeo += xprt_calc_majortimeo(req);
> +	req->rq_majortimeo += xprt_calc_majortimeo(req, to);
>  }
>  
>  static void xprt_reset_minortimeo(struct rpc_rqst *req)
> @@ -675,7 +676,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst *req)
>  	req->rq_minortimeo += req->rq_timeout;
>  }
>  
> -static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
> +static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
>  	unsigned long time_init;
>  	struct rpc_xprt *xprt = req->rq_xprt;
> @@ -684,8 +686,9 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
>  		time_init = jiffies;
>  	else
>  		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
> -	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
> -	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
> +
> +	req->rq_timeout = to->to_initval;
> +	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req, to);
>  	req->rq_minortimeo = time_init + req->rq_timeout;
>  }
>  
> @@ -713,7 +716,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
>  	} else {
>  		req->rq_timeout = to->to_initval;
>  		req->rq_retries = 0;
> -		xprt_reset_majortimeo(req);
> +		xprt_reset_majortimeo(req, to);
>  		/* Reset the RTT counters == "slow start" */
>  		spin_lock(&xprt->transport_lock);
>  		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
> @@ -1886,7 +1889,7 @@ xprt_request_init(struct rpc_task *task)
>  	req->rq_snd_buf.bvec = NULL;
>  	req->rq_rcv_buf.bvec = NULL;
>  	req->rq_release_snd_buf = NULL;
> -	xprt_init_majortimeo(task, req);
> +	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
>  
>  	trace_xprt_reserve(req);
>  }
> @@ -1996,6 +1999,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
>  	 */
>  	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
>  		xbufp->tail[0].iov_len;
> +
> +	xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
>  }
>  #endif
>  
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

