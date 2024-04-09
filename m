Return-Path: <linux-nfs+bounces-2737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37C89E1A5
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967C31F23569
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B7156245;
	Tue,  9 Apr 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TrkdoiT1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QnZ691IN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B54C85;
	Tue,  9 Apr 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684072; cv=fail; b=B70Cxha8cVkU7iqSdVuFajb9niFWPuTOOtKgISRgmq/W1eOuADIxomk1b+aGZ8e4QVOKqtNXqm6cZZB6WHdffcigoK+Zj8O9Fi1+YpXZFD/mP/z+Uc3yKM3PJMJElDK5ZKQp2gLxfmQ4XDAuaJ4lik0Po1ta+rPkeondI148kKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684072; c=relaxed/simple;
	bh=5vrhKIe9ClqCyuIjAgp0m6xtifE+hktHCei7uOnWQ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FvK+97s/LxyMCq4tEd8/dH4xkItnkdu/mTKWLQ8B1lbM6h1Jo0bwWNo1kwLcSmG4EfBgiitxW2nK1dG3BkGba6tqrupspyV4EgJMg9g+NNSC62Wf5I1dvDPbJOJsoQMWip3Aql0LZRzDlme/3dpu8F4Cq4JvFnAyzUToJG/+o7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TrkdoiT1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QnZ691IN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYIFN031316;
	Tue, 9 Apr 2024 17:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=xg1hqIukon4gYzG3FuNP9Sl4JDQxO+WvvWdfzMnpq5U=;
 b=TrkdoiT1CG2vbjI8/FlEObC16fMbDbgO/3S0I4p6ynuD2gMpP11tDGY7qmEbOFbRCzc1
 UkIDtOzbusSyUMQvasugMw5cPwaQC0uy4KoFm4vsn3g3El11FaF5p5An9wLcY9c7tGE2
 dAA2JXPKJlGl1Tzwl0azTqrnVQO1W1XrgIB1Ssy61eNfhswRbUUTwiftPv0uHSzAJiIC
 u76OW6dEo9nzcTHJYBQZGic3h+a0W4XGaYC3dj0kSye6EzsQRa0TMRtEbP48QyTAl0U0
 KU+w51OcX4HMt6I3/IrFGJiWMfiztaI2bAOL/lEDT1n0yEugXJPMfUIxhXQ2g7QH812q +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b5hvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 17:32:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439H4cAG007875;
	Tue, 9 Apr 2024 17:32:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu71shh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 17:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZyjxaemw19CgGEVMg4pagcGeu4W1ALbZxv5sy/wbIcO0s73chq7vUX9flUbjhhkzIim+uknBV7iweYHVbnt5nuqQAOx73O17RdyVA33h1CZY0drMXLs5lOs6TM+QuKlr1R334iPEffGpG2k+3UxIr7Y7BI/r2Rf4srxRUE9nXAbWRescBw23L2hnhQoG/pI8KeETda8SLZQBUGU7M4EUbetQw1dRN+5vALIDB4fiKappjhQIMHkqDcD0zzA1vboKQvPqEfNuVYhvi9suV0MlmADP3P61IyaitC4aCmzJbyqp69vJSsRUvoOdDQRGB1cn4VuzkSbDLqFRhi0gpNI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg1hqIukon4gYzG3FuNP9Sl4JDQxO+WvvWdfzMnpq5U=;
 b=Mymvp2fS9EETF8JEq/gtiGlchprG3j7oqL7YN0SV+mZyRrlfJeh+BADydF7E/vwPkFego3WSVqBPg67Qvh9ncuKHYSrGdcfxWejIkrnw4WbtT7JwKjm3gfb/fP5NhVA3msbRTMaNza6+vyBOB5hI0AiFJLW4K61KifG9bMUkP54VKm3MjrLkTuyCrt25xh82bqa3k8U6tq+NeDtZ7bF9viaemXNr6La616ez4mqYjT9JopAIkr+2clXX1jlxxCIiyCsPfDaWgZgEZtpXjtF/fNYYSyTAUlTEEubXxbXTa2UKIKQTUFXNXiYaE470yqxE7/oaf9ve8ENCwc1f3ItfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg1hqIukon4gYzG3FuNP9Sl4JDQxO+WvvWdfzMnpq5U=;
 b=QnZ691INRHKiMQ7OR/ir7fdQFWxVS0BDlZS9Tlu30eTNHwb6cr8fFGDMroKI9gI+ESYw8LKXvMZPxbcG+fIcwmKfkuqbYs8xq5X+LCFSGjZWm033I4mGh4262UJSB6vZk2zibfKVCHQCfiM0zOUw015K+6WAiai21U0HYJhfn0c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6151.namprd10.prod.outlook.com (2603:10b6:8:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 17:32:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 17:32:10 +0000
Date: Tue, 9 Apr 2024 13:32:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Vladimir Benes <vbenes@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: hold a lighter-weight client reference over
 CB_RECALL_ANY
Message-ID: <ZhV7l5oPjoJAm8Jx@tissot.1015granger.net>
References: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org>
 <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
 <d661b740-a431-4099-ae41-39a69bbc67b7@esat.kuleuven.be>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d661b740-a431-4099-ae41-39a69bbc67b7@esat.kuleuven.be>
X-ClientProxiedBy: CH2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:610::40)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tTDrJDauXa1874JAuKVr1qD6ybPXi+FX6RVfgGHyEwz99I2w47IIAGJY7zcOzvvgK5nJvN5FlWSiiRiGxonnFwdI3/kz9RYiveyZoFhL3+myvuQ+Qy9ELXeeTns4+Em0sC7haFzrUHNTzi8gykrplxniPBP2eTbdcXBI/fX5LDQs/o76DrQKjG2Vff5lOFXuilEWe0oFcASHdBoLtNY3JWDNP3pYH7zhnHMOnxmevjteKdM9FUBO4tpjhb1g2zhGDSur7c15kp1edyM6ppGGSoBrHyAo58GwumKUwPh7Sg0jPQe53uexdqlUEIpMhrKF4PcVC1DmIssWh3QKHSQcmEsO5/GsSVymKlMPFF9/cx47Ugxp1oN+DkIT9jPlqiRuzoKfZDhqwlK2J+V1+lphLO6hcWrkZoTMlJj5prQB08Wkx78nQv1UwP1JelBU9AJJ2Mg+G6BZCqOb9oMHvqj+LTnqF/Pblb8iT62Rx+yxf0FxtDXM7PpUqedGcIU1GI1+iyYaonqbCyefw+ZbNiGJV6tnsCpoH3ZHpGckCc3vmL8J0/ojCGhpZaJqDyzh8hKDQENSCpIJa4Z20NST94D4pfUpOgOCSqncqodEcXAcrp/hx8QfEIxID87ACpUZ0DOxKb2sLovBbfz7kwNjWj2GT6GxJi5W0GaFj3IfoDR5X8A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cFOqEEN3UmuCXQSd1TuCNPBNX36awNVw8dUvpKuPipqukpZxM0XjaHjaoC36?=
 =?us-ascii?Q?L8dKNqlPkOg+fR+7U3FCCbSMAOtKk11Ub6gVzhI7XwT5IyMG1CWAPQiLzu4H?=
 =?us-ascii?Q?tS4aD46BzG/xwUhZJW2Bj1CZjKB7mJGbR1tICiPsoHTKKvkcYVpOd7AQ5FqN?=
 =?us-ascii?Q?qLGIV3oe3N6M5avnPlLftjPjM9iMYbhASeihgtj3j/J2FcLTDEL0joGw0VHT?=
 =?us-ascii?Q?lOLPFyWcTNNX8RABFLyura1LkE9MNij1ppwrLLA+gXg5As/L4lTWZSMJiBst?=
 =?us-ascii?Q?sLM6kskANNaAlBIsRkKNe43XMDEGvUtirsqmSDjF+nbP/rCvMvkdRb+wTnvr?=
 =?us-ascii?Q?xgINRngZkr6lwV5NiZ/oK4H+BWzVBix+Q5u3hhppRex8uOMgufcBam76G/Ki?=
 =?us-ascii?Q?57JAXdav68YpcfivNMgnO675oYiiPRJ2ZmYUgljLjxUBR+MJy/2NgscXL5HQ?=
 =?us-ascii?Q?a6h7kteZLeqj7g+ZKBjOunwpKJgDCYNfbbd93q8tlXjccUISzHMq7Kj7EVDy?=
 =?us-ascii?Q?n10Ir/pJ3wVvN8d7RbjSok4tvEjdBItdbSLguy8jJgeAKwYPrb2BF3tggpp0?=
 =?us-ascii?Q?qDeK+og+TlTXIGY8J6trStsrI0ABD0ShGOB3vo/TcytycHcXAFQR+0UE1e3/?=
 =?us-ascii?Q?HCbkGd+NP+2rYiS/h55t+NykfomYUVBzMkVimyMYPo2TrPWaulAaiBQXwxoD?=
 =?us-ascii?Q?7zuvHk5oq+RfpE6d6lPMW6jbJDY3hvO0rm9ilr3mBsE/yfuvePUQoFq/E7SC?=
 =?us-ascii?Q?e7kAqEw1Zy4vxfZu/ycjSwqhLSFXZ9TQbKA8ciaQjKt/ISwiVufjKl2Tu6B7?=
 =?us-ascii?Q?BqX9m/Eil6eTUxatpl/sr3+H20MxnO5l7eTchzEexY9vOx/ti7pNhu+RApZ8?=
 =?us-ascii?Q?UvYhr8I0d4VT3YXQr3mek+vnGm5k8IRqvb/+SF9ap2CErHtzasEgV0vAx7Hl?=
 =?us-ascii?Q?P2lmCwvFnOhpCfzu6QEW5L/WcCD4krJCy6zektp3YkAc6zkjAY5EzXlLviFS?=
 =?us-ascii?Q?kwm5tGQFdO+dvo4xDEW6c/lkTtcrkLBZYkoxK8dNmqPCowH9rF56lNfQ9FY2?=
 =?us-ascii?Q?pmVsohB0ameAM2sbnRQHmHqyXwL2Z0fDsXS9ssj7F1Tlfwf8HMD5WaLikk4C?=
 =?us-ascii?Q?3UYxWPBjD79hjakryBaIy/qcqkVsJjHC745ySuIcDRDLGGfVe7UXEIoGpxE8?=
 =?us-ascii?Q?zfemPA+TwIQwUICIQZFWFrWBpv8NyCHF74kKX4mxqpAKQ96KcSHNK+EiZ0+n?=
 =?us-ascii?Q?aDlm+A3geN4itH7HnfBEyOMbu3MJuVjnw4cmHFL0S+RoAvtNI10WDLaLUwTR?=
 =?us-ascii?Q?ImwGKwBAxT1esQtcAxTWJMVHaw3IRBrhK+IJFOMXJDciTw3Ek/1Cupc03SpY?=
 =?us-ascii?Q?XUCBoH9tvHwEbdXVT/CxlH91Da1pLmoWq3s+8q0n/BOAoIULcsaGK7TE/ZwV?=
 =?us-ascii?Q?qc8TVFauJ9zAeOTMRyk7uy0YzIJEUz6O+jQZacqRnaeVToqgv2UiHLN5QmZ7?=
 =?us-ascii?Q?j2M9zOVgJbVN+clmz3RQJ3W6OClAkq10ivjI0/NRdxQIXtsZMSUp6xVNQLmM?=
 =?us-ascii?Q?P7Wc75F7hjODvxdOFy3ORZg+TLtkSWP+WrJEbTphogDEnzF96DGF+oBFvOa2?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	59uHpIUDa8qHVWx1g0qTcfHd0zD2/IkbxQ6HZXNgu1XKhJNJrbfanLP4FVGLxwapcjObse8wiEm4KNlD/ye8D/WyT7Sn3d+2rJAjh0Msbpw7PXpzh+aPv6bIj+DbqbhsknxKrZgl5ld1qoAFqfJomrt30GSEYGOyR6PaX4BaPmtkazdg9YZqKeV05c3rH92KJYBudW4nVXSm8m/rz71J9gFrWMVjZtNQ2m4HZIie591AxK/FU3TstKoxb//NzcPoZcwUmcjFNicmw487QmTWls1Zy2NfeMWZOgcQ7WG4w7mPKhowSdlYtjd3ZhwagSsy1rzdPo2QhaYMgmQRR7oZqqKN2vAFN3OyYg6WviP1rKZwE33Gh9U1jG4FjjNb5HFGzsmaBNGuNNdv0nyEvWX1gHClTRE3z0qKtB4Z4/2lgRjMKagglIi6H1rJNrTjoG2DCi56uMWiJOistyYF5sm71bWI6PBXz7n/lYht6rWYOKPg3UAOOUP7KXcJiOjGAGaX4cAn0Ep2FcYbYYJ8LP+vVAmvkHKSeevJAW+RZpDV6dJAT16b45vALdS/4yPFnxy1NLqzBoV7PKd55VI54KF5RNVujmQAsnF+FII4fksKeZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ace2a91-20cf-4285-e948-08dc58bafcbb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:32:10.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUCSDOheDlHozo2j0BtscrdxtuADHH3ypT52RT49WcyDMG5LJv6HnVcS8q4HJzPyveCGnuIr3UjHNHMX14voog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090114
X-Proofpoint-GUID: T1Q1Ofla-o2hUbxy3lVLSd6UFn5PLWjf
X-Proofpoint-ORIG-GUID: T1Q1Ofla-o2hUbxy3lVLSd6UFn5PLWjf

On Tue, Apr 09, 2024 at 07:24:17PM +0200, Rik Theys wrote:
> Hi,
> 
> On 4/5/24 20:07, Chuck Lever wrote:
> > On Fri, Apr 05, 2024 at 01:56:18PM -0400, Jeff Layton wrote:
> > > Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
> > > client. While a callback job is technically an RPC that counter is
> > > really more for client-driven RPCs, and this has the effect of
> > > preventing the client from being unhashed until the callback completes.
> > > 
> > > If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
> > > can end up in a situation where the callback can't complete on the (now
> > > dead) callback channel, but the new client can't connect because the old
> > > client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
> > > return on the CREATE_SESSION operation.
> > > 
> > > The job is only holding a reference to the client so it can clear a flag
> > > in the after the RPC completes. Fix this by having CB_RECALL_ANY instead
> > > hold a reference to the cl_nfsdfs.cl_ref. Typically we only take that
> > > sort of reference when dealing with the nfsdfs info files, but it should
> > > work appropriately here to ensure that the nfs4_client doesn't
> > > disappear.
> > > 
> > > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
> > > Reported-by: Vladimir Benes<vbenes@redhat.com>
> > > Signed-off-by: Jeff Layton<jlayton@kernel.org>
> > Applied to nfsd-fixes while waiting for review and testing. Thanks!
> > 
> Can this fix also be included in the 6.1.x LTS kernel? Given that "NFSD: add
> delegation reaper to react to low memory condition" was added to 6.1.81, it
> would be nice to have this fix in the 6.1 series.
> 
> This way it will also be picked up by Debian at some point (it seems they
> are upgrading to 6.1.82 for their next stable point release).

Thanks to the Fixes: tag in the commit's description, it will
probably appear in a later release of linux-6.1.y automatically.

If we don't see it the next few weeks, I will ping the stable
maintainers.


-- 
Chuck Lever

