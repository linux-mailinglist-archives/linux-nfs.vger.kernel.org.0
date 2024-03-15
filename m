Return-Path: <linux-nfs+bounces-2305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE187CEE9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F691C225A0
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7093FB32;
	Fri, 15 Mar 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+kDmqa4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zy2jOjp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77463F9E9;
	Fri, 15 Mar 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512999; cv=fail; b=dEilvTmZt0qx3dyGFuGtiPOsNUL09n6UxNIy6yBqotJ1RTivFfS5kRe8SKkqgj9OrYYqe2oj6cVPX0Flu3NbsXxMjgD9orxcNDKD+aYhb5+dAh1BRICZGlnuWnXWAJb5KfbMN0QA2mVeS1LVRNWlSq4z5LGjze2ygQbot60/Hy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512999; c=relaxed/simple;
	bh=WLsiKgN72sP96JDFfj3nA20RDl6pRN/Z2QOzyK/EIcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+YrMnXarueC2jDZy2yEnGNv8shR+68YylFL2nluyna8JtP3V2LhXvjfsy3QGrvp3jNXxn1v0jvtcReZa+UwrblWluMXRdCPxheaoA8kc7G1S8RtT0ntdSUBbwZK+Gm5rUCwNQvuPdzjgNFC00a90gdoampSeaB0yp90dARTJzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+kDmqa4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zy2jOjp1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FC9XmH026327;
	Fri, 15 Mar 2024 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VoCfZRJC6MGQmdS3JwAFaQy676yulTzmCjt/6fwzqMY=;
 b=l+kDmqa4ojkXa8nI4NOZAxP2PjywaeuCD9yFQJpah07Wcs4vYosi6XnKIE3hYw/UDjI/
 wrxb1asyXO9P+xCNE7VzLHCyUFuyPnMcHMLi/djXvszLw41xS1GSVlRP3M/UwEM3zou5
 j/7OM8xZQ1E1nr0qf8t8ZYihbkLOYq6wZWkM5bXs9yjyJ+nOReBOPo8q4q0nrJJ25/us
 ixDvDhTnL6YdG2+8UlFw9gAxQ0etT0M2XoeZ0LD9sgVSRitPBEXpGgQ2pOqw2/RvbQkr
 AK+TPamf05FNT2DP1FERK6AV3949DBUF9YsVMgCCuWCfSo00JKlvDbwKzqlL9uclGaNh 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0adasw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:29:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FDTi6D019743;
	Fri, 15 Mar 2024 14:29:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7bx7kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwEoJppIQsysFcNtDJbn92VL1TzSOo9eD6rLcZTjxQPSSqGznUKxc73g54R7zW6Ba/UtCNthafGlcA3k5Uf2uKGuEdH+qS/KCE99ayFd4wGs3pV0lycppsFHsEPL5M434IlhbSNHGXE04qcttcl4Zc4psd0AvgZaSLDWBZTaPQRplzj0vRIER/jw38+R9kKPupGzmFYvS6slnfMBCUZftLQGeHhNAatq5wRoYjx6feY5IIrayKy5n19POHHnEa0Pf/q9UWf8kJycYOqKN5A0xUU8hLgF1yZakaoNwGmPz5ebwJVOrAKINpxo1p84zZsTH7ON5/ZbVNJlCcg1jAh0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoCfZRJC6MGQmdS3JwAFaQy676yulTzmCjt/6fwzqMY=;
 b=Desf2MTHZK87CEXQ68y8jIq5HPV76jJZ0Q0vOIGsGBUp4ibAAOrXD5yWgTgtwMON//oU94As+2Nsl978e8iWiKI2XH+2BwROqbw0xfdW6etiJGBPNZOa0MdPSP9Q/Lwq/pNPEuHCAEpC5P3IksR7SF4e1fOgexAL2W8XI/rlLkZa/9ew7T0w6egKA/x40w6b5KY8j3Al2vDnYCAMkndTXrgx8Ga0Lhmz9Gb8sRJjLDFriNHhvSEeT13JANQSdjUyY7zPdaJcBujX/iQXwqAt/aiUewQxrCjLrrA+zSeh8vKwOOYpQt3UkHzpcV0lgIB5HkQ2AdhIMfrxk6WqlDYZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoCfZRJC6MGQmdS3JwAFaQy676yulTzmCjt/6fwzqMY=;
 b=Zy2jOjp1WiBjU48FcrbJd4uy6iAT/1qFS2OSLq4AJ3I0EoQCwPqtRY788hWcJIxyTErF4EZnSprXwejsgKuGvU2dkqXNo+XKTsiZ7nG+cG0gbAuGHbffWR4+7LacdjvHg/B/qhTHvAcbs8xW4kCsgfIN9PtwOzDI6ShgJNj1lRg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 14:29:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 14:29:50 +0000
Date: Fri, 15 Mar 2024 10:29:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Muhammad Asim Zahid <muhammad.zahid@nokia.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Make NFS client_id increment atomic to avoid race
 condition
Message-ID: <ZfRbWx8L9WJGKa_k@manet.1015granger.net>
References: <20240315124053.24116-1-muhammad.zahid@nokia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315124053.24116-1-muhammad.zahid@nokia.com>
X-ClientProxiedBy: CH2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:610:4e::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: f59a08b9-e47c-481e-a770-08dc44fc5f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rmRFPCmQzYWwBISDkjmmC3G5tg3s1t7WkWOuqmv0bUgrLqdsjLHpS5OtDOdbCuP40gMeAxzhQrcbXsQ4PcXf85jYKyMFILhxBVf8hiHfD5gQkpAFsPlow5xBT4v2iQw07nUUBeT3fPZoQYnVuWys4YuQK6pj3FgvI+0ORf5ZgDvA/Trgbug8hZprjkEZ8oo+FFbMT53ALBREJbmztlBOvi3u8mUfea06ZsChw4ZaU0oVcZPbAF5Rlxwx8aBH/viQmZ+x1GHBohEWjjdjRKjJx78013PiYFb81QbHq4PPz9e9+yyFEokzbbmm+cduE001iqJVuMPSxQ2uCFotEDeR4UJhVXeSO3PU6oQnpQ1mJYuT7ZozwH4YCkelKNNOVJyu7sPuiF52fjvRVm9fLs9myOev5Aoj/DeiTR7Ofw9BzzJBpWY2hshkhDUkcEU6cZ7wFawAoTvGgJnF3I7Bso4rcN2YDVHcmLBYiSPI10TG7O4d9zvAXQtUvUZQlqvbTTFg+FW3OyK6vrXeqeabGTfC7mp9hDC/NoItOdWov1C9KVHz1Gz32NoYExoLZPK8ECXPvSQEIf1yBI1pIPsiNN1kGo0SfhqkbZbIQzCIjqiGFqg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bV0YODpRHrJwXilhWIYNXXiQ4qtE8ps4IJ9V3dbekd0v5vmipsN9cMPxpJGr?=
 =?us-ascii?Q?EQXcbogMq9RDutyajWum0N3v+K907u7T7rF1HRki5gpY/+VKH2BOWIhitZaW?=
 =?us-ascii?Q?rkW4YaPv4eH9thzWjPJlL6w8WUc8h7VSeQMiqCCz68OUerhcJg2izWiA61sY?=
 =?us-ascii?Q?0/yNfDjFzXJBS02Ens3EJJM5OFAYSYhtwX9UCTNMmw25Vci0o4rwpyfM0l6I?=
 =?us-ascii?Q?Miei6e09aXBQygkMYPuE32eUYnWeBRWD5Gb+80d9k88+ODKpX0RFuGszfh42?=
 =?us-ascii?Q?0nEiSUJD15MVoDHOa8cD2AJnBBLU4yyCHIe+OCmo0q9edfBaprSVjY7ATU8m?=
 =?us-ascii?Q?NLLaVbQmucvmGtNiC1kLTWSgJnBxHpumQ/5tUK4z7YyGveUqjxCH5RJYUWUg?=
 =?us-ascii?Q?JR8EXESASFhwa7Q98oxUlbCTu1k2cSaYAEp3tPvFPUUCnbKtqv7SONyl9eT5?=
 =?us-ascii?Q?r6Q5WXBwTkToycoyWA8LodziOle+n+Y4coD4pNlrAEN0bjjC191Ne+RfmJRE?=
 =?us-ascii?Q?E0aAf22vwj2mKuSk+VuoWcJ+b2Xy+nCceb+1yVNXAaGD7JA7bBGD+afG+p0C?=
 =?us-ascii?Q?6ImYVc8RapUfrCse3SkIA65uHSrjh3FAynkGirQzrB6uf3x6WAxWrVJ+e7x1?=
 =?us-ascii?Q?TYV3pOIhJ/2sBYUmXOBDoXSTJy6J4AVtTbGLnzHRpaM51J3My5QnDIyTWWOh?=
 =?us-ascii?Q?uD4ZQovP+txkGSpjqz3rqFj5WKLsdy+Kn3LZKk2GA9ltrO/dnEveNbC8Ab13?=
 =?us-ascii?Q?Z2lGDPrBC2uuqtWDomBAeOd/WmJkE5LCYAjXt9RsFkLUizVCGPkDI8X+PlGe?=
 =?us-ascii?Q?tVgIWBjFUF7US0JfxXNCoK7kkhbNiypJcDVWw+1Et3zZAhB02G6k0B+X5Tqp?=
 =?us-ascii?Q?embZGEqMSs3fMTjd9NLcOPr4XQbXFlG12vPyX+Y+TIyMo6Y+tQDyXWUZX9Qe?=
 =?us-ascii?Q?8n+KulOkAuBHmutwc6E5z/VmOhCQk1DxpL4wChjcwItEqXQ/bTHLTZ3jtJvb?=
 =?us-ascii?Q?cQ31Usn83M0rql3zKVC8w03E5R6OeDfMIFGOuKlW6FtHdKx3wOoVLew9o9E7?=
 =?us-ascii?Q?keQ+gKmkgMrz4/hlvXOgQOZ21/d3aMjABv1Mt/tauoMbW6kVckd6eKL6KVBy?=
 =?us-ascii?Q?h4NT3JmbKA987cYFtpG7V91qzuNCv++uc8ImJW5+KCgfj+Pj78YW6yW7krLD?=
 =?us-ascii?Q?URjR50jdfUGJp/KV70GBhlPRR27BOaNwY14XOnFziBGgxbUSpuXuBe8oavcW?=
 =?us-ascii?Q?LCRIIVW5euw2Mwx/58zIcy4dpQVSpLIfe6Y24R487N+JWYJ8z2YvVCcjyUVL?=
 =?us-ascii?Q?DPF1+15psSLYVytOj1uhIVqsaLoVVFaqpvCD91TlY2mYHG+cLMSXkWWKW+zV?=
 =?us-ascii?Q?MCsMalRGinEOB0GRDDAqWlv6cAITwGhkP1JDlDmCk61D1LfOsfKnpgpGJi/K?=
 =?us-ascii?Q?Q0A6rKXw1PIgGzUzkQGd0jBYL0JMVgmG08OCbcZQtRxiQVviutrsyP5udKBt?=
 =?us-ascii?Q?kSNUlT85B8fhCdBMHr+Vj7/0igpo1ll5qDz0aBf6nTOdnxn0XBbvFDjgasCk?=
 =?us-ascii?Q?3aSfkL0mmtPUtTDUXvCMYl5Zdbav2OkGHWmBulcsn3c3hFv6nJnxjj17Qr+Y?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XLcOgzi1fgaEezlN1r18I7oqXjndlH18Eocysn1X6dScTJRlkNTP0kaSYhscX04klrlNyiJmR4C92x3+O3BWww81Ob9rxVEV6a24MphhDl0MozD9z8eb4y+UkUoHL6P+1X9gmJAwYttdlMs1nyBS8paX6vvh9pPmdN6+M+G2nfeVXbT68ll2FsBSHEEZ+JVQNd/SD+1q/MdbqHjxBmB2Pb1gC0Sxxb5rEv5/DE+w+WI1I/Q4bT4eThwM7eeeas/Dsfqbm0aJDhHFYnQ/4YAprrgeqAljw65Dh2Ax1Myed5ECQ+sbxwjVzgJW7vOvnn1Oe9NW5c7emu0dv5HmKPAUOz3OVu4ErXxo+l8s6NpJssBwPeV0krnV1A3fd61vlwwoWkOotO+XuEWTuaXViJJE3xcs6PiJBuShulzgH54GNLTmlksqkp/h2xcaCq342oIURahhUZ6qhmhp8STy8sOBKk5/Y81qb6+IpgHhJ2xPk5HAQS+bjsx8paFbLpQiSeaM7+3YR8xJ/1SWTU+zN5xseSvZWCekx6rLmmH9bM+N+5C8Tr9cQZkbaXcNSsu612CCs1Mrxtblb+tXlQk6VUIV87i0GFnqhVtARbb0I2dR+tI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59a08b9-e47c-481e-a770-08dc44fc5f68
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 14:29:50.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg6etQBLaCllO3C3X/eriHIiDgn+mjCQiEAPriqZJXJFzNUNsroCAgiQV+HnFrWnb8djiPdL5vpLicEtLoHl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_02,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403150117
X-Proofpoint-ORIG-GUID: 08T1DevPXfVGwpl6aw4OiuwDvzTqiXGf
X-Proofpoint-GUID: 08T1DevPXfVGwpl6aw4OiuwDvzTqiXGf

On Fri, Mar 15, 2024 at 01:39:57PM +0100, Muhammad Asim Zahid wrote:
> The following log messages show conflict in clientid
>        [err] kernel: [   16.228090] NFS: Server fct reports our clientid is in use
>        [warning] kernel: [   16.228102] NFS: state manager: lease expired failed on NFSv4 server fct with error 1
>        [warning] kernel: [   16.228102] NFS: state manager: lease expired failed on NFSv4 server fct with error 1
> 
> The increment to client_verifier counter and client_id counter is
> set to atomic so as to avoid race condition which causes the
> aforementioned error.

These client messages are in response to NFS4ERR_CLID_INUSE. This
condition is not because the server did not increment the client ID.
It's because there actually is another client (possibly more than
one) using the same clientid string and authentication principal.

Refer to:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/nfs/client-identifier.rst


> Change-Id: Ic0fa8c14a8bba043ae8882f6750f512bb5f3aac1
> ---
>  fs/nfsd/netns.h     | 4 ++--
>  fs/nfsd/nfs4state.c | 4 ++--
>  fs/nfsd/nfsctl.c    | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 935c1028c217..67b5aa1516e2 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -119,8 +119,8 @@ struct nfsd_net {
>  	unsigned int max_connections;
>  
>  	u32 clientid_base;
> -	u32 clientid_counter;
> -	u32 clverifier_counter;
> +	atomic_t clientid_counter;
> +	atomic_t clverifier_counter;
>  
>  	struct svc_serv *nfsd_serv;
>  
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9b660491f393..d67a6a593f59 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2321,14 +2321,14 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
>  	 * __force to keep sparse happy
>  	 */
>  	verf[0] = (__force __be32)(u32)ktime_get_real_seconds();
> -	verf[1] = (__force __be32)nn->clverifier_counter++;
> +	verf[1] = (__force __be32)atomic_inc_return(&(nn->clverifier_counter));
>  	memcpy(clp->cl_confirm.data, verf, sizeof(clp->cl_confirm.data));
>  }
>  
>  static void gen_clid(struct nfs4_client *clp, struct nfsd_net *nn)
>  {
>  	clp->cl_clientid.cl_boot = (u32)nn->boot_time;
> -	clp->cl_clientid.cl_id = nn->clientid_counter++;
> +	clp->cl_clientid.cl_id = atomic_inc_return(&(nn->clientid_counter));
>  	gen_confirm(clp, nn);
>  }
>  
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index cb73c1292562..a9ef86ee7250 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1481,10 +1481,10 @@ static __net_init int nfsd_init_net(struct net *net)
>  	nn->nfsd4_grace = 90;
>  	nn->somebody_reclaimed = false;
>  	nn->track_reclaim_completes = false;
> -	nn->clverifier_counter = prandom_u32();
> +	atomic_set(&(nn->clverifier_counter), prandom_u32());
>  	nn->clientid_base = prandom_u32();
> -	nn->clientid_counter = nn->clientid_base + 1;
> -	nn->s2s_cp_cl_id = nn->clientid_counter++;
> +	atomic_set(&(nn->clientid_counter), nn->clientid_base + 1);
> +	nn->s2s_cp_cl_id = atomic_inc_return(&(nn->clientid_counter));
>  
>  	atomic_set(&nn->ntf_refcnt, 0);
>  	init_waitqueue_head(&nn->ntf_wq);
> -- 
> 2.42.0
> 

-- 
Chuck Lever

