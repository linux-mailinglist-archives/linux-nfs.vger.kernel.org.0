Return-Path: <linux-nfs+bounces-381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693F808A77
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A862728142D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A341C94;
	Thu,  7 Dec 2023 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fW4i6jHh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pmm0WoEU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77726D59
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 06:26:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EFFeW030034;
	Thu, 7 Dec 2023 14:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=eTOioN3U7Xl4nUmNVlgRCv/xMHoGUOjJNSV4j3iPhl0=;
 b=fW4i6jHhmxr53wc+SsLrH1Vp23+DTbl+mzLwjfhlhXRUiHiObqocS69mQmMWd7nnSssj
 2B4SY3p4MO9/lfP0CJoezOE1TbTCH0iVCVGoZHtuCCytd5VBm+QQAzjiyHP9yPo1kb/O
 3tHaz0MhF/Chi8YlwRGVTdWNQ5lRjXUArm/rR546ejpZrq0u4jbB4DX80w/znyWtWboY
 IOV+Q0JqUcf8e06Zwmu1JF9buoS4ExToM09+E/1FSCDBZNqBNUbLA1DPpQ6APuR73IJy
 l9aXfkDzxiCqEcnrXZ3ZHK0uIGHvQkVrVeSC7oUSLCTvMMEdK2TH60lXXE0XFi3lP3xk uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hkuj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:26:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7D167a039466;
	Thu, 7 Dec 2023 14:26:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan7gt30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:26:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CURPV5ycyyzJc2KjWmbuXao0NyR9RrC1uQDfYoz+ZnDG24aR8EQgA5Vjd5FhwfF6ZYJhdh6kdlOf40Z3I9b9gOPLGWEU8p2+F9Zg8eHo8wMV6ZtuI3x+1yq6S7RnX3fTMu7vMtWATpYrxJytl74T3mq40DCsli0spc3RhAUb5Jh++WG4mufZN95sOJNzTKArqiLBqBYtoKLFiI2EhKHcMDsPBx0FJ37Xc6mhGfH+7TnlG1bCoSGIA16wB5w244v4dmUTdbjEdnpGVx3WnPaQN82ozcJk06FbbxsNqZ+mA7D2vXr4BMIXXj53Fa6BydiUwQW+Amr9wfUMQNQRNhm1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTOioN3U7Xl4nUmNVlgRCv/xMHoGUOjJNSV4j3iPhl0=;
 b=JPBs8UiLAdS76SVCpfI7oApVCGq1+wwS0rUct4EqhrTXkFLNJkGuMiGxnAV/x6yPoe5w5+U+S1nSWb40o25kfA+ZmlTBUByoPZVd7CNVxYoc6npnlnMWvVm3BFenqVAGNOSiUIPxOBHZdf2AN2lKwZbqdEdSlahfuc/Xx50NN7dicBqUcXOfjD534xrBOMOkaARZdoneNfSw+WZIfAQPTJ1UMpP6GmhHrtNqEMtMPP7teya/3uVS1sM6ngDv0r/qnIDhKR2mRjQ8T/gtcK5TNRzu5mNJU96WJ/3p/58lldlM3HeY4dHzf/qPo+Uvdn3+Um+T8ChVd5PBL7Lv3TdDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTOioN3U7Xl4nUmNVlgRCv/xMHoGUOjJNSV4j3iPhl0=;
 b=Pmm0WoEUwnV9igAHFQl1YyyBp57QurUSDui4ZFCy/uBRDlSDtxy9krhuyyrVThQVOss5moyIXTnmAWR9wcbJV+locK96clmlduftg8mLaTTzu25pBw96EaSi+x3hAggF2IzkwGjtkhMf+QzfonAkHi4cb/iuBZMI4Yy3Cv5v9nY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 14:26:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:26:11 +0000
Date: Thu, 7 Dec 2023 09:26:08 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] gssapi: revert commit f5b6e6fdb1e6
Message-ID: <ZXHWAKswQo9Y5kez@tissot.1015granger.net>
References: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
X-ClientProxiedBy: CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3624cf4a-a01c-4528-3984-08dbf73075d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4dByQw4yItWXc4cepe4JdEIq5UcjnxmQIMfMyhQG10taitMpKuOAKSr3d7OS3K74A9eK9PtjJ4EriUOMs7yZ7PlArmaN3QoW6JQEAOE6jsZi2ooRVZTbhX72GSuwkORJcolf5QwTXMQk7Hm40zbqh9ztAKT7BPq/imgOXa519eqQTor7xmFnqbup0RtZiMYaMxzkz4IisSqSg6xtGMfAMJ36ZEm9GQdMVE/DfklB8HMu0PEA1lyOpxzLmjWcXr3RldWsD+bG6OCx35vX65I7o6NPK7ak3Lq7YQAGAIHKHn5HdSkmp021S98dwpwzOCf3+m6S2F9iYHUW/BeIj37+lD1OZTdjpk+5580NsQWYYbGRv8Hlh6w43fTrWYPbsHrMSkKH3mKUmk+U75p5ROW8HxfzjWSCd8868ix7H98K7e7ZmRGyQzVbrc9CWLM6AYFtIjlYJYhZ10kLlS8OSN0CPJkKwBSCvxuTCfUC6wolXeUqp4DqmvLNnVohHQp+Nd58OEcklNec3DhM6NYeaaAaQ/ujjefhZ+eenVizQr983Vyv7YySW5DypqthT84h38gEeikz69oRBUff/219nbgvg2k6wp0hvQE50NkYdKqIAso=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(6512007)(26005)(6666004)(6506007)(83380400001)(41300700001)(5660300002)(8936002)(4326008)(44832011)(8676002)(66556008)(6486002)(2906002)(478600001)(66476007)(316002)(66946007)(6916009)(86362001)(38100700002)(98903001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+37LkcvW+5sV7BOjMJHg87kQ+Yk26fsk6YbqdZKsv0OpLpXrCLw3IGJk7w2b?=
 =?us-ascii?Q?chVO5OI9GsTgsoL1UY002kZvGw0hmO4bI5B5l8MoQNGF8kOo7fGl3V/fTx4U?=
 =?us-ascii?Q?uH8uZVFkCyCI51glwOXPZjPDd0JyV0yIgEvYC+xWGNtrfsJx3y1U+BTRa5S9?=
 =?us-ascii?Q?t9FBRXY88UFuUcu/9Sd8f2NR8dlmQlWsCH3kTWt0s+wbThuiPO0WnAfUMI1S?=
 =?us-ascii?Q?Z8/GlHJ+TFsH6c1AcsCluxOgymxvmu8ota+xVFh5Ra2pmjQ0T4XlPn8DkKFT?=
 =?us-ascii?Q?vxkyxrfzryJOs06pCUenj1+8gdG6v6IMjw6saivN9sYSnwvewUT+bA9q8hJ3?=
 =?us-ascii?Q?9s7PS0MfBDEffZ4zD0jQP/s8jFcJaE70MSNOXTgKx6GPgPfyJagfmhYH8Q0g?=
 =?us-ascii?Q?FBhxbxIctDYbjVEzBy2sYvj7hEEn+b5mS2lIBbtwE8l2fyZOJ7vjfxx6YE4H?=
 =?us-ascii?Q?z152uRu/Du5NxN64NMhWBHunk3+eQsDb8Fq5v9VqmrM08Bi3I6NoW6vemHlo?=
 =?us-ascii?Q?UE4ADZi2GKZLQ1Wu5lwzMtTn7OvT11aifRdoDXUzKrx9XkRurjXJSTqnxCRT?=
 =?us-ascii?Q?+dOPMXt8NtzeDq9DAn4Dxyj3dCXpCqFPAVri6cGmIkyuOIGcRs6m7W+9wVsU?=
 =?us-ascii?Q?/8G/hKVRxM0+Xv+hwjcDcrch2nUcR0fMHSVjhlOcNafB3G6GeX0pPCc/4j2+?=
 =?us-ascii?Q?WxQdfi8DIA1EjqjtcNgAdf+QNM7s+calWDGsCQcqaydS71oydKTJYwMcKiE1?=
 =?us-ascii?Q?c+nx1nGOaGV8KudjBLKoLN+WQcj83x05eMeINwOTuvMBvoEiVAoURpCAoc51?=
 =?us-ascii?Q?RdBwrdFzWbKbHhcp+vSnULsiyM9qZTltSC6dbQx2IBAuWTbjAeIdWIOKXUvF?=
 =?us-ascii?Q?KIsGOTtOlnFfeKhh+mUdaXftYdAfMMUFNmRuFldsAbGVQ7wm5SxYimgpFpxQ?=
 =?us-ascii?Q?qPyaP+0V7wi3emAj2GF8s0gmAI0+7tT/MB6UgPnwWPrch413335C+vtN2CCO?=
 =?us-ascii?Q?XjYPFGepyIlEUsSx13XHbqDTYimcnXZ+IQ5qMrqgOkOxVNnEoq3EHk7e8Jrp?=
 =?us-ascii?Q?7l2DrEcGm++ax91l305ntkVCeT3Uy3Jh/6g8dgv7rzadWTrWdNnEmn+eJRNp?=
 =?us-ascii?Q?wXsUwAyi30NIpM1fKUkZ4QGZw4HPmLAgcB7OQgjwBIQhAWpzCtPEQk3wlg8f?=
 =?us-ascii?Q?po+Tvc7U4jNViXUPk9SyDBOJhiPnIm7M72D2lSsNQOHL3duhW86YVntJaIzy?=
 =?us-ascii?Q?0Ki/E4zp45Bpbo4ndPBmeSIGWRIC2xc/yvGuWVfKgswbT1s8PpxwE2x4MzIt?=
 =?us-ascii?Q?IW29CiiC1nOZPfcNopioZgfK3ofF3V5Jl+uqVP6sSuoYU8OC7IlswE41vTny?=
 =?us-ascii?Q?QM49DeXCvG7hFM3ZpGQba0+QSjlglRoBpbpKgYwebJmBEj+P5DBNCV6knnoe?=
 =?us-ascii?Q?0UE6fZEO5xx55dfkyLpxU+fckN7fGZERoMsbc9o8svUlfS5sNom1UCDdpekn?=
 =?us-ascii?Q?9JeKX3uK98z2t6D+u9xpRDnq0C4gIuYPwedOKZ3C6Oh7HZOwU8Dmd45GkJvT?=
 =?us-ascii?Q?46azrPa8398qXHVofL1iMZwcRVekPaNpoORZ8rH5Eg43oFnYRViUjV2xzH8y?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TpM34GSrUW0UjwYJ9BmI53DCgqhPIPvKlNEiw6SqCJWSgSTGMiO/WQndwmHiCYVODKmtpnD8XE3RoJ75PC9M/g1nifcuaWPIQgiL8dIjo4pca0z9sHNAa1jMBsM4oieLqE3+l3xC6Gj5MXZ2FK72zq45xGV6VYj+ERW7xbW/fRwS/jGKD2ak68A7aX0CtxwzvYLW7qGRFquEzUhcXoMTUmvAULcvhGrpfapmFpbH9fFVm5LfkyCCgye7dr0MlKg4PD2dtq9dTzoAnSJaJmxTYdmK9ahuKCysFXgs7XXh/uR/U8NWvqCZm7eGFv8dTKXfZ3XqSyZkU0Wo7GcQciZfU04+RH1vdhKNH8Z8mzbufgbRv9MC0byA2PlnLKxeQ88tow14Q/Z1Xs7go9mlVyr0a7YUa1D+SrDXD2Yw5XbemUQMKRuTxms2pbZm037RV9LtEBOx0oMN2dKMI6qNRXNlRf97lqe7xZicZAmjLCcGlzmKEdp7617DTXun98q3nmonafo9qa5NgAdb5f6Au7BR820Q9ZQhZaQnuqY3tQ2FC86NJAWCuPNLDXUl/i3anfQRTbRbTXWOqw/BPYZRbA69ckXVy3IQTwPaML8oAMRkwPJZnotb9c496NuL+ml5+GYeD9ttodM68GLdib9lzc7VwpmHGRj13DsV5Y7rW6T2pCludWyiKhmMRAPe0/x9Bi4CWLoATTts7HVBu55GJswxNcsi6vqz4XpSLygEUEt0HESTu24DXnFMWAxmc0zQXjw7W3CYShJVlkoSUM9LmmPIYM2dIC7pcaI3cxUv98YSRDaW2SeNq5RNjsgTOqI/V8Qv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3624cf4a-a01c-4528-3984-08dbf73075d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:26:11.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmcLMgr8OGabt90revq5rI8W9rMk6fz3UAm8x+o4hWIj1gKTPsF3Aat30/fcaNPwFdEW21LBnP1haFBeRMfYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070118
X-Proofpoint-GUID: AwjPCw_XrsSA9iG7ifnjxSlXZg6PoeYm
X-Proofpoint-ORIG-GUID: AwjPCw_XrsSA9iG7ifnjxSlXZg6PoeYm

On Wed, Dec 06, 2023 at 04:31:26PM -0500, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Revert commit f5b6e6fdb1e6 "gss-api: expose gss major/minor error in
> authgss_refresh()".
> 
> Instead of modifying existing api, use rpc_gss_seccreate() which exposes
> the error values.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.umich>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  src/auth_gss.c       | 14 ++++++--------
>  tirpc/rpc/auth_gss.h |  2 --
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index 3127b92..e317664 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -184,7 +184,6 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>  	AUTH			*auth, *save_auth;
>  	struct rpc_gss_data	*gd;
>  	OM_uint32		min_stat = 0;
> -	rpc_gss_options_ret_t	ret;
>  
>  	gss_log_debug("in authgss_create()");
>  
> @@ -230,12 +229,8 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>  	save_auth = clnt->cl_auth;
>  	clnt->cl_auth = auth;
>  
> -	memset(&ret, 0, sizeof(rpc_gss_options_ret_t));
> -	if (!authgss_refresh(auth, &ret)) {
> +	if (!authgss_refresh(auth, NULL))
>  		auth = NULL;
> -		sec->major_status = ret.major_status;
> -		sec->minor_status = ret.minor_status;
> -	}
>  	else
>  		authgss_auth_get(auth); /* Reference for caller */
>  
> @@ -624,9 +619,12 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
>  }
>  
>  static bool_t
> -authgss_refresh(AUTH *auth, void *ret)
> +authgss_refresh(AUTH *auth, void *dummy)
>  {
> -	return _rpc_gss_refresh(auth, (rpc_gss_options_ret_t *)ret);
> +	rpc_gss_options_ret_t ret;
> +
> +	memset(&ret, 0, sizeof(ret));
> +	return _rpc_gss_refresh(auth, &ret);
>  }
>  
>  bool_t
> diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
> index a530d42..f2af6e9 100644
> --- a/tirpc/rpc/auth_gss.h
> +++ b/tirpc/rpc/auth_gss.h
> @@ -64,8 +64,6 @@ struct rpc_gss_sec {
>  	rpc_gss_svc_t	svc;		/* service */
>  	gss_cred_id_t	cred;		/* cred handle */
>  	u_int		req_flags;	/* req flags for init_sec_context */
> -	int		major_status;
> -	int		minor_status;
>  };
>  
>  /* Private data required for kernel implementation */
> -- 
> 2.39.1
> 

-- 
Chuck Lever

