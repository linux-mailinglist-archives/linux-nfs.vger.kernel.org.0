Return-Path: <linux-nfs+bounces-850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB98212D2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 03:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91F01C21CA8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B7803;
	Mon,  1 Jan 2024 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGZ+SOk/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nLLJZqwD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275B7EE;
	Mon,  1 Jan 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4011E07H003693;
	Mon, 1 Jan 2024 02:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=63GfOjrgkR45+Yt+NSMvZ7waQhX9jRa9h2JQ9rzAcSc=;
 b=EGZ+SOk/2GQBZDpqM/tQDyrCTsBN7yvzjkhPHh9giN2UH3P7vzV4EmB3z1w68ZZXgb4R
 SP3lPuN5pcuq1avoYStPqfv1yiPIH4yunwW5Yat79GQmNwkIs2Ev6NmJledqT9GiJVxH
 BSgToDZR7wnHtaBDWRT0mXarYrWO2heGqMUnH0KjtccSIurYgb6NxwEu+71ASmlaabci
 DccPpWi6BP6mO2Y0a8HrvDG04rz1cnCPUYXy4iUnUMpy16WI1Sz3Je/2u0cLRwXmtNjl
 q8ZrHDYPdsW1shYlqHNj81ehXrXFUFaNE/J3aNtP61vvI04CPmBQMtQd5ar7YNxKCQiy wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa03sdxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 02:19:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4010Tlh5036025;
	Mon, 1 Jan 2024 02:19:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3va9n59qn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 02:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy+OMLBgPr+ptoQfFyGKLKRS9Xja3G/ho9yPHl/IO79XXPr3QDiCGIP5Ya9ccBGdPmXWShXDg6pw+FeykwS8Ig76moAnzcDryKxZhABNH5rO+7gPpEdANyWepCbAAsLPHIIWSPQsvnkE5mpoHllbvQelr1LXX9HMxCH1OwGG1U5c7OrdVvi6+9GTah5tdZrhdqZVLKbiDLUv0hRc2hPUJZkWuSjrR0TaoETm+HWdftkJ9fcmJILW1+Q4tU7EoARwA8eD54XELBabLscSTAS0Um3Ke/6lnEHzsdlCGgq+rU1SATRgBEr/DaUT2NpbocKKJPZiaDgAx9zIC1CnxB71XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63GfOjrgkR45+Yt+NSMvZ7waQhX9jRa9h2JQ9rzAcSc=;
 b=fkBNF3cXwXq2k26UO0fe8ZSgMzJO/wBi5ZplJChePxscg6p4+3sy0aG0kFSaQEv2QGh7pgH6ZrwQmDd2bojDzVdo+EovQr6gefmZ0M6lJs9XbW/zZHWoxrAWxTeBvv6M50AieUrTyZ0SsmXr+F/Pf+SaHcq5axxw6P+RqWITjLfQLOxP+N5/yHY4mcP8++MTXhJrGJpQWX1T2VrwZSs639kFz8ycZyP839oQ8vIpa3izlOXvCaf4nik6IVIta/4I9dJLZ7n0aVkKsEWLBTfF814UBFufQl/JWUMU7KtAZVuF9tA6sgZdNy24PePnqK05OkeW/+LvrLuhA2Sh8yHiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63GfOjrgkR45+Yt+NSMvZ7waQhX9jRa9h2JQ9rzAcSc=;
 b=nLLJZqwDnlAtZ63qtUdtG627A3yMAU/v7jFwwJIoZCooPOaru63/H0RCHifzd3r98VYlfm2MH73yuskGjIDTs7NIFoGQsnkY/1M90Sr0wtop/lYGWf99rF730IHiVMv7wzHj1EoN1MPnnoDyA5TReYCNaPZlcGRTSUmOE7u81yc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5317.namprd10.prod.outlook.com (2603:10b6:408:127::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 02:19:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 02:19:00 +0000
Date: Sun, 31 Dec 2023 21:18:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Paolo Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>,
        Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: Improve exception handling in krb5_etm_checksum()
Message-ID: <ZZIhEJK68Sapos2t@tissot.1015granger.net>
References: <9561c78e-49a2-430c-a611-52806c0cdf25@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9561c78e-49a2-430c-a611-52806c0cdf25@web.de>
X-ClientProxiedBy: CH5PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 500ca21d-e7de-42d1-88b1-08dc0a7003cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v356WPMbyhXXUBZ6f1PJIhfQBhj4SBftrrClWPNtQaBrm+9mifsllkv9YDr+kiXasYMWZkptG2HBotMPwibwNerF6H0ukW1pG+o0j2QxOsRCWmB257/3+iZPDPHNxxbz50o00/ao7KOpLsDmZazullvuG67xppU3no3RbinUW4ZNyeKrifGlITKs9T7y+F0ZYeNOuSASyCQ5yih7gqmLtVdguq8nw/5LPXMaS3IhjtjUSVWsUeripDL09GzUJssmiA/W37LgmSmPdNugexI4P4/gqtxEp0wZoXG7PzTVvmRhkmdtyqMkd0HFa2x4QkP7Ita+nIh/9KSsEhGoSRDnhxx2JziVSHgtsAoh+YuPIZLZY+HVBJ1Hf+ZY4pTo67877oMRezk9hpEIZIdOXgdRQ8ztTMFli5S94thP8TdqJbBQ6W8Y2fFrAngXAqspOfBa23eNtN1742GUdOWANeR8CLmx/ozHeF1RtaHqoTFf+3zz3yvtm63SHF9F+hVGvWRpC4olga0qaJNY4B7rxfXobCLMOBjpF5gpo9FAuny+/JnNr0m2+gjVX8ocn4oVfA0g
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(83380400001)(86362001)(38100700002)(4326008)(44832011)(5660300002)(7416002)(9686003)(6512007)(6506007)(6666004)(54906003)(8936002)(8676002)(66946007)(316002)(66556008)(66476007)(6916009)(2906002)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0uBi6HuLbWF4BQiEMZsw5DwT5gC1+NXlnWCYr0BPH+Fp4bzH2T/AxQE8jrPq?=
 =?us-ascii?Q?oISFJtmtF4//3gbkSQMbjhDfz+uVYOz6rVnWEDIHx4tjuTj6+WJQ0nJUdWZp?=
 =?us-ascii?Q?9amQJvWIM2fXDLjt405Z1nhdmpBB4Z2nkF0PjvnCJcFpXKTlT6JWAez03zJb?=
 =?us-ascii?Q?Pyhak6S16WNmOxwS8gy/75Dr07PyZla0quzfIRJGIcSBJPiHUgbTy4TeToG1?=
 =?us-ascii?Q?fMTcwF6NBz3Oa4tfr84VC8BvjU6H5fuQd0UX3BlCWQzaSdCFN3MZvq/ckPY7?=
 =?us-ascii?Q?73XuSdNyZBApVMkpsPr+lu72S6sm3AfY0n40ITlYrAvcBCF/CfbQ5vMN/vEk?=
 =?us-ascii?Q?kKLWko5N2OzRJUq0HOyq8Z9Bu/fyBmL93Ib1A2BwloOxNUi4eKGuyJ9iiv5P?=
 =?us-ascii?Q?r4kAGa53G831xmGNoTSxLDLmMIdjLUN/rAh9ayheggbUNccQK2FnUoYeLTSl?=
 =?us-ascii?Q?ywRl/8JJam+gc7moXUTOpF4Dyd0wdXfXuPU5ruiw4Qw4qYvbAwh80rJ8kAf1?=
 =?us-ascii?Q?0p8i8zIG5lJzN9zr8KYyxPjIx435XV2p8Xhn7S+ALr/sYd9syeT++cWtPIoz?=
 =?us-ascii?Q?1fbq9b9AhnHSNN8iCmEoqbF6Glx2ZMaCwcYIdzU5CVNf6m5ESOdORGf6vaYM?=
 =?us-ascii?Q?kdTzw+ygl7NPk7HvRduf5FEz2+pLlSW5wELMYWi/F+kC/4yGmpQ2yylWr0xp?=
 =?us-ascii?Q?OxF1/OGOM2QMRzylDzOLAMmSjTWeJcgqZbHHiwtE1wiCFEQJzXNTpug1HtzK?=
 =?us-ascii?Q?rz+Yh2zVBAn44NlEdomQSmBdbCD6VZ7AoW1Oc0E5RAHq++qzF6g5n/VRXioo?=
 =?us-ascii?Q?NdOc+KH1WhbmqM2iVgNk0b5gbTLwfalZ7UapVcJO6DU0/HZl3DJ2iTJPQcvN?=
 =?us-ascii?Q?3iDCg37xFpdIoYhmzF7BjhOLkHSC+zsKdoMvJspCnhtdSR1uzwI71Ibb8pOJ?=
 =?us-ascii?Q?LDKak6izhqWAM+MXk8SAs21k1P3n0KvGbGTfUQSW+UJ2MdPwippDQXsBo9cx?=
 =?us-ascii?Q?Bbb7Ph2DSFVIT30XoT0JHBXc2odDLFzQWabGsYQapc0Y449eijo8hT9ESbUx?=
 =?us-ascii?Q?RD6hb6K0oGlU7pJxV9iF3bVle3v0sisbGNtzJQFTgpBjGuH2wcgWIuyoqHM7?=
 =?us-ascii?Q?aGc3Ol0hqjW6H+/ClaU98IlOl6qauHKALKAL6v5dv3ZVQNOQGBS0YogrZcXz?=
 =?us-ascii?Q?tWpZ684hDZTRU1d4n/f6townn7MZquUHBAXzmMj4k8acEjjQpbgaTjxAq1mx?=
 =?us-ascii?Q?tGuLOLyapucRKcjFoz0mZ8o+qILz44uL4UEgjjUypwDHQwCIaESwT3QUWYjh?=
 =?us-ascii?Q?bg0nhbkXLLtQ7joywK73mRaaWTkapepGknzAqEbTbeCvXNo604ZMLPlb0oRt?=
 =?us-ascii?Q?0Fj1pfex1FanG1nXA+OWNXuBLLia11ryqyJVuNQN86+VsjIyUXq2t4Jdp0BR?=
 =?us-ascii?Q?nRel7ax1b4hDVbHS+iWKEzhF2q+AUe0+WWYPN0pCT/1aMYzeD8NWuRQ4d0+B?=
 =?us-ascii?Q?TkgFiGBaEuzeqz+eFmFBgjotU+38XcHbHMlcIi/M7Fucy5cX3F9C3R1xjMSn?=
 =?us-ascii?Q?c5jafQ0qvL+7GE9+dQAEG3/Gsbk547SQ36X0VFE/RCBj1xysvXGsbgjQTkj3?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lfHumtJihjp6Oft8qzcNIbK/jtQHlP1H7iGPDads6s1+GiCO0/8hJU+MezPPhlte2GGFmslHcoWCAVgsdFcluI5A2g/kJ4QJv0+h7U8lcYGOk329s5HPF0meYuPf7CtlED+wG5UI+OUvSMdUkaOzr/Kz896pRO21MIJl5JO89b9imVqJuUfSSqiEpu+U3jNos7v18CP6fwiptxIB8icufZK+yF/UnehPJT1k2S3uBMQhSys8QQiRqgvA0ks6owhvyXgqE+PSQ6KT5qToD+H+kri8A2YjBNC45xLMgRTINgyL/8swEbFvlMN6M8JYOHrAeubiUGch4/4cQvB0LwzxUPjsWeJcdODOELoApxzIu3tcFMJN0EQwydaojN9p0QXOEnFLI677BIDHLbsMKz5RQc24VBrOM2PFte3vVrj7Hysf6TYnY1TvvMtUEAuZKS18r4DmxoM1zIbeI4OzZtKBIvxoiCZohIc5stWrMrU2eUOz8A+zvwuPlKuuuQmtYpFfSCpFxOHb3ZguTSsfqIFE05i10vWxDpk9d1GplGASJxq/IzeRFTb1O5UErAg1nSbofgbb4LLA539GQLgg3FP+8tZm0uFTjfY8kEKCl/UaZtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500ca21d-e7de-42d1-88b1-08dc0a7003cc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 02:19:00.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3j4ha1GnebQNKlbIj8Gkym0+eS1OsmxkO10QOkAeANDWiQ16mRan+XfEQRfuBcK73vn+B2X8rP4MlaEf/ITfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-31_14,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401010017
X-Proofpoint-ORIG-GUID: 8QGyZk5fQ0DJwFryjpquKcnx_SP2HgoN
X-Proofpoint-GUID: 8QGyZk5fQ0DJwFryjpquKcnx_SP2HgoN

On Sun, Dec 31, 2023 at 02:56:11PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 14:43:05 +0100
> 
> The kfree() function was called in one case by
> the krb5_etm_checksum() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  net/sunrpc/auth_gss/gss_krb5_crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> index d2b02710ab07..5e2dc3eb8545 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -942,7 +942,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
>  	/* For RPCSEC, the "initial cipher state" is always all zeroes. */
>  	iv = kzalloc(ivsize, GFP_KERNEL);
>  	if (!iv)
> -		goto out_free_mem;
> +		goto out_free_checksum;
> 
>  	req = ahash_request_alloc(tfm, GFP_KERNEL);
>  	if (!req)
> @@ -972,6 +972,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
>  	ahash_request_free(req);
>  out_free_mem:
>  	kfree(iv);
> +out_free_checksum:
>  	kfree_sensitive(checksumdata);
>  	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
>  }
> --
> 2.43.0
> 

As has undoubtedly been pointed out in other forums, calling kfree()
with a NULL argument is perfectly valid. Since this small GFP_KERNEL
allocation almost never fails, it's unlikely this change is going to
make any difference except for readability.

Now if we want to clean up the error flows in here to look more
idiomatic, how about this:

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index d2b02710ab07..6f3d3b3f7413 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -942,11 +942,11 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 	/* For RPCSEC, the "initial cipher state" is always all zeroes. */
 	iv = kzalloc(ivsize, GFP_KERNEL);
 	if (!iv)
-		goto out_free_mem;
+		goto out_free_cksumdata;
 
 	req = ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
-		goto out_free_mem;
+		goto out_free_iv;
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 	err = crypto_ahash_init(req);
 	if (err)
@@ -970,8 +970,9 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 
 out_free_ahash:
 	ahash_request_free(req);
-out_free_mem:
+out_free_iv:
 	kfree(iv);
+out_free_cksumdata:
 	kfree_sensitive(checksumdata);
 	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
 }

Although, if we could guarantee the maximum size of the iv across
all encryption types, then a static constant array could be used
instead, I think.


-- 
Chuck Lever

