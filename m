Return-Path: <linux-nfs+bounces-698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A31817D2F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BB1283B70
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C65D746;
	Mon, 18 Dec 2023 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXEqzYsY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+uYR9SY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002374E3F
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXbjM012124;
	Mon, 18 Dec 2023 22:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=sOP/i/0iXa1pA7YOkhdT1CjIB6Aoa5PbWPAoSz9ri5Q=;
 b=HXEqzYsYysKJW2/QswrGI51DID3descLwzvneuq0Fv8Qx2HO+rrbwromk+uZL7p7xyPZ
 KAJV0Nvrwso7p+BEs9415epbwDh6NsGAN9Lvl/w3FZ0WwuydyaWtZLS3wuKPypyvdJZJ
 TRLSUBSHWQH+RZX4nyLqYvPneqYYkC2QfQOQ4XcxbFq4bghApWjICA2YiQSqVjvZaLd7
 YASeEKpVgu8ZFTy1FE81HnwbJ3NPSPKB7IGbzwVK/iVoAl++ZQDEDTK4PSTcGjitkHvJ
 fh0Z0gPqdRwCj+jA51MfcWGSnj5T4kUaISLcoavHQ1vT268Q45euFRAcbSq3ZlPYVX0n Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2cdh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 22:18:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BILXPL5020079;
	Mon, 18 Dec 2023 22:18:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bbykrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 22:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfPVACgr2pBG+Fx+S1eZt60IV0hjDvtV2+8B4rf2VsizIzS93kk6dTuPWTSHiIFRE1dcUJ0holW/6lfGB4hd8WQkBu+eMM/Q8hVRTrJMucjCdDygpahvxfXRHDaD8SYMwEDm+YyGwDh5PGPmzsjXe1h9SyVPGS2De84VxcBe5GWyojMUA7w6whI0xpzoOiD3VO2gQK5d+VQTZ4r7ADX2xb4Qspw9VZGOQGsdoXfxKPA/IqT9Wp1QBPg6Zwv2vwLa20C4GqdTE9VVMRWWSNMz5wmYIeeYVCIZe7LuftopJBFja4lroSgo0o7pS14O7tU53zm9wKBHowKMOLYwbf7ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOP/i/0iXa1pA7YOkhdT1CjIB6Aoa5PbWPAoSz9ri5Q=;
 b=g8A6BHKVwj4QqmzythVMv/MAdTUJ6Tgv89KcdXQ8t7wKcnbV4nBvridSHbXY75e+TntgcgA6luAGh4FOy11rFBUNxJI4lyB5RTc+o2evTha/lhdudFojj0GJGfwPs3px8J857DkZP8hPRSikjM2gE7XHjtiFubOWqgh6QyJpnnZgH8Fe9kMI8ZvvVF7DPXzKVUVemuBHJ+fCaT2ui4sgfXZFAo9LkeSjOP2tqzhdFqtfDmx9TtAc5fhrAv07xCInR6zfjVeWLRmtxPi0UuxljodW8sNNf3mXNcEvjPKuG+1YHXQKGIeROljGKG9RmD1hAZUd+H0t3W2OPuh3wyUf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOP/i/0iXa1pA7YOkhdT1CjIB6Aoa5PbWPAoSz9ri5Q=;
 b=G+uYR9SYpLKq5yfoEeCu0byXUYFOVG8o9D9UDHh6DcZEFgWF2khtMIJrfxNf9BzZZR1cr4ugEwrzRTgy9fJeOzuk+nxFcj+FmCQkv0QFE2b6/9dJkuZIwI1yZsBpknYs8x7l9wG8x98/AfDM+Ri4w0pkPPUJBzzfbTUjGpiRumk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 22:18:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 22:18:04 +0000
Date: Mon, 18 Dec 2023 17:18:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: SUNRPC: crash from svc_alloc_arg()
Message-ID: <ZYDFGQR9HbbjdaoQ@tissot.1015granger.net>
References: <ZYC9rsno8qYggVt9@bender.morinfr.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYC9rsno8qYggVt9@bender.morinfr.org>
X-ClientProxiedBy: CH2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:610:4e::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fb5be0-bef0-48b1-2941-08dc0017343f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F/QwfciZbAtrpFkNxTl2xohBWyPH46/O07gkMn8PXRJ4VeE48uXvMIfea//8igRVOeVbb79fJmwHEcjgdEMigwi9OhetfFLnYOGvyxlGp60XVPG1Mt3q1h1krH0gfFG4K5jt59no4dqGOoTN+HPKugfbHgbZdGR4Im9qMgV8gn9GMhAqLRzv0NPNrErDWbqgFJ8LOTD0Thjn86wzeU1GP9HWgzjONyXgKiwT9HsGn4+U8j8PzLPUohSC3G3HQtTZD3KU2zg4tVpJb20XIIgGbcroGdJSsOP8MgdS5Z0X5iHiWroviQxndd97BvEjlMK4/BErVXhbVJaMFeFD+qjBp+R24Pz5tgrMFaJuhN7DkRjMPyc5B7XxZS0YluxIZANJqfWSS1nXGQ31b1DOYPVccvdLArZ1XJ/E6HbT+AJwvJOQMT+SyADdIjmmlV1OR+Wkz6eICWJ2+13nhuWF8ESRfbUkgmz/6we0CVRCFMP+20HMX54bF3GnDA7RhB7hIidaM8z94E3R2kJ3/cI1iWEpkZHkGzY6OWL0EGmCj9Iz1ecWSqAjbPqHckoSAGFHZt04
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(38100700002)(86362001)(66556008)(44832011)(83380400001)(5660300002)(9686003)(6512007)(6506007)(8936002)(4326008)(66946007)(6486002)(316002)(6916009)(66476007)(8676002)(2906002)(41300700001)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2BEyx7ToV3064BLgoqfbTm0KqKpu5UQJtxi/cJQAsMspn8mL+SaswMjEWLlR?=
 =?us-ascii?Q?5o5ChxiCLwvBOR5ILoQC7GcfNkEeFTWM1ixJzPeN4Ma1n9DqEzVcvm+Irc8O?=
 =?us-ascii?Q?H9sqCQb85vc04SJ0C56600DcfWH5eZDKMl7o7sTbnlHq7P8tbU9xTjgDuAs3?=
 =?us-ascii?Q?9nX3fCTmYe4t1yMBxK0+IkmqrM7szZfFU/wj4b54sinOVFr7tSknyOd7XwCk?=
 =?us-ascii?Q?W2//s3m6gDoqkI4HK0ffspee09/u8j9yIWEkCi1u5nLra6Jt72nAfsAp1O7c?=
 =?us-ascii?Q?AU3wCfPCbKe01mLXJbJxbLS1Ks9M+Gx00svShX2j7LhxWa/EMBlySUion+fn?=
 =?us-ascii?Q?DSlleNRl+ryYeyrAHF9qknaKcif65JbRlksV6UirFQegJACRC3q4VXUavWUA?=
 =?us-ascii?Q?Iu2mgUZ5hXiElvd9LeyTX4aVnr7fs/Q9RUnauoVweWpOK00yv3DkFbuK53fc?=
 =?us-ascii?Q?50x3SEeMMHW+Cc3IdgeA+JxFULNZ3juxMd8danG3T2kM0hY20h2MognACeo/?=
 =?us-ascii?Q?38+IygAkKd3k1bo70/JJbZYnHFWtpAkKhCZhlrZSsSdjEVyuPfnzxJEP2imT?=
 =?us-ascii?Q?QCgtze2f9xlPbMOB0rcTBr8Tahctd6w4/mDxpuQUloIK0WqnwvBd0bfB1dyi?=
 =?us-ascii?Q?EDMCwOskzjX0Np85sSDWFXCANkGMa4wxYhzXst19+7dpJHRBB4TtTrM/5E5E?=
 =?us-ascii?Q?UkMSS4ocJYILsP7rlibvDAWlLTsFPSf6i9U5hxqI3BZm8Bqdl4WICq0SpvgB?=
 =?us-ascii?Q?qaim3vBO4kr0qR893sTbNMJo9TXeWddqWbiBTR++qHLTHQgsXknQTfwW58Iu?=
 =?us-ascii?Q?JrhrM1qtVzMBzDAHFeCgbQWSf1D4iZmNmoYNwk2oRPNFpdiD3cRTHpS3Ykdl?=
 =?us-ascii?Q?1Kj37ZFMhIObRUtp6HOPD4ByEJPjDFcWafi2CInoMHGn/XbwDBXKTv6SF4Yl?=
 =?us-ascii?Q?k/NkSnhCMV6y670tHc1gmsRfqkq0a9ZPybCIv3IR+PBeH6zcbIz6lkyo17rL?=
 =?us-ascii?Q?7qpfu+Wpadl8RHmQn6TFVt6N478iWvqHCtXLCbnB5mrYpUTFn7OdDOhsfmD8?=
 =?us-ascii?Q?Jfpb6BiOC4M4qRMCnhOWOeTxD3hAFKXFUClkAYeQd+i6zPw5TTDqLpaXj+tC?=
 =?us-ascii?Q?BfjYhAlwJmuO5whn/oafjRhsQ8iflL5zj/Hg1MGnCINmwlgoFtkAnKperIwH?=
 =?us-ascii?Q?uSLP4GAIx2RW/8efjrR4EVMGmO4ZjZFSOh3KHc2RCE2lXiGZt2axG0JRumXn?=
 =?us-ascii?Q?0UH2ZV3gzftNhgoVYT6pCjjFVvd2f/eiApQ/l1dPbs2HFJWuZwqj0KNw7D27?=
 =?us-ascii?Q?fuSriCJhUi9zyr5IyBjgp3K9LQ7K07apODyqoKwjzWZYVI9fspeNxkJ2zMiV?=
 =?us-ascii?Q?NPhtPAzV5LMeZQG+ZN4ThnevUNiRW3eEXjBGSxt2Yr7F1OmQumSA0PWkEzRB?=
 =?us-ascii?Q?u4ljFX/zXONbRNUcYQdb2Q1LIGvEuj+jA0CWQqMDKoInL0cphQsUH2bM2Gll?=
 =?us-ascii?Q?6uvr6skH0FMPcvLj5qPGqic37Qwf1OlGeyEeqbZppeHR+pejs6IEDd/Vq90V?=
 =?us-ascii?Q?Q35yDD0GIyEiS8tSbVkbYuUZtQaA0BbPi0sAWI/jy9rFKjCKsX1/oq/usD17?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rfplGFs64OHALIL9FtXEDZd4d4JRCTGXDCfJlEXFWawuOWsdnBvktBvm9nRmowpVDU9RjSUVtGLtDLtV/qMqlJLRmaJY9QnLWo8XtPgLw5NyT/S02oFf5vHYQ2PQcsIB3Tlf1fKp18Kb0jwlWz5OYakyollJf0A0GhnPaVL/X9hyHJplTJBbLnMBU0gA5Z7xH/9X+qrnemkKtZTGL4KQirVN7ynwX/3N6MVVtSWY9ixlxAScHS8EmmYLASC9ZuWEOZAb5gKHyVm1r6X1ccE7vFGqD8feZTdldX39ISsNllZ/3dSmtGFSKjxyNhqnGKEmSid39g37vdgm9Yn81NLtdapSXxxpkzaeyk13VXd5gnd+/aYOshGvq48OGaux6BJVWTnCFqtuaqaWThJGpCylr2QBObvdNFHL/3oOHj7YOIEZKNiPfunF00lzlSXQDurYDcVorFla4XYG7zyiJhdVu37M3jp10f7JINRDqzZK1XQRe/nXQgZtHwLFZ4vxddk/vRq6GUuIiLQ/zdDb1Gh1wNEKqMUMHuJi83weYFPgihX0FTESkax6YA9lOrH7vYrk4ZxAyMYDBiUaAJTCw+xaFnOshBH6b62DehTXqDv5K8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fb5be0-bef0-48b1-2941-08dc0017343f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 22:18:04.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z+YsIrfK52W7jdRKZS1+KGcm+ESXRULOedh0LDfofe46/pqNxdyMnrKQXGZxQBEcirTmyZcr5U259p13s1bng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180167
X-Proofpoint-GUID: L5FN6yyVLHR8VJDIa94TBHzPoZky9jlV
X-Proofpoint-ORIG-GUID: L5FN6yyVLHR8VJDIa94TBHzPoZky9jlV

On Mon, Dec 18, 2023 at 10:46:22PM +0100, Guillaume Morin wrote:
> Hello Chuck,
> 
> I believe commit 5f7fc5d "SUNRPC: Resupply rq_pages from node-local memory" in
> Linux 6.5+ is incorrect. It passes unconditionnaly rq_pool->sp_id as the NUMA
> node.
> 
> While the comment in the svc_pool declaration in sunrpc/svc.h says that
> sp_id is also the NUMA node id, it might not be the case if the svc is
> created using svc_create_pooled(). svc_created_pooled() can use the
> per-cpu pool mode therefore in this case sp_id would be the cpu id.
> 
> from __svc_create:
> 	for (i = 0; i < serv->sv_nrpools; i++) {
> 		struct svc_pool *pool = &serv->sv_pools[i];
> 
> 		dprintk("svc: initialising pool %u for %s\n",
> 				i, serv->sv_name);
> 
> 		pool->sp_id = i;
> 
> When using the cpu-mode, this triggers a BUG on my machine:
> BUG: unable to handle page fault for address: 0000000000002088
> 
>  #7 [ffffafa3dc42fc90] asm_exc_page_fault at ffffffffa3e00bc7
>     [exception RIP: __next_zones_zonelist+9]
>     RIP: ffffffffa32fbbc9  RSP: ffffafa3dc42fd48  RFLAGS: 00010286
>     RAX: 0000000000002080  RBX: 0000000000000000  RCX: ffff8ba5f22bafc0
>     RDX: ffff8ba5f22bafc0  RSI: 0000000000000002  RDI: 0000000000002080
>     RBP: ffffafa3dc42fdc0   R8: 0000000000002080   R9: ffff8ba62138c2d8
>     R10: 0000000000000001  R11: 0000000000000000  R12: 0000000000000cc0
>     R13: 0000000000000002  R14: 0000000000000000  R15: 0000000000000001
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffafa3dc42fd50] __alloc_pages at ffffffffa334c122
>  #9 [ffffafa3dc42fdc8] __alloc_pages_bulk at ffffffffa334c519
> #10 [ffffafa3dc42fe58] svc_alloc_arg at ffffffffc0afc0d7 [sunrpc]
> #11 [ffffafa3dc42fea0] svc_recv at ffffffffc0afe08d [sunrpc]
> #12 [ffffafa3dc42fec8] nfsd at ffffffffc0dec469 [nfsd]
> #13 [ffffafa3dc42fee8] kthread at ffffffffa30e4826
> 
> I believe the fix is to expose svc_pool_map_get_node() and use that in
> the alloc_pages_bulk_array_node() call in svx_xprt.c. Reverting 5f7fc5d
> would obviously work as well.
> 
> The comment in svc.h should probably be updated as well since it's misleading.
> 
> I didn't provide a patch because I wasn't quite sure which approach you would
> prefer but could provide one if that's helpful.

Reverted and applied for v6.7-rc (see my nfsd-fixes branch). Thanks
for the report and analysis!


-- 
Chuck Lever

