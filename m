Return-Path: <linux-nfs+bounces-383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F1808AEB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4304CB213AB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F539AD7;
	Thu,  7 Dec 2023 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLleM/1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JxVoVjlL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACDC3
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 06:44:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EKatE024099;
	Thu, 7 Dec 2023 14:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=fhyePhIrGVjyLEtzfOQPAqDFYrqNHQxVtRx3EAmgHy4=;
 b=fLleM/1MQ0eapm4H/i9IsncyCDA/7FE4asUcc5Lq5wrkM3a2huw1q1sj1XvN8wjb/igV
 vl7V0Oeocb34oJ6MLL56SsUGRz+raDIuMULC+Gjq87UyQ98VqzB68DLRcSD1ichD+2Ve
 /QIICA3ptu5R0mk+J5pdp2MwmM6KRZpUXZyKW5F+ptmAKUSIQD09T6iDjNhAoRjfqJvY
 KLqxZlhcRyLP4CVL7T6O0wgCvz51km460XqX3jN2cNeGjemz8eWXZhnxBOvydcLzhsu6
 wnXyw3reh6U3/R7e6wSljgjGRVdAOPnHjQWdDSmZaFsNu6qDChPQcN15Vxhdxy+mmkLY NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda3try-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7D9chX019792;
	Thu, 7 Dec 2023 14:44:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan693ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWyflsR1o//YaWuRpoEKqkvShOcXO9Ckrz9NQ2xYWMUcUTmTwjKVfkvXCvvvoP7lZD0CmyHXxQO73ge6Zulx2kZYdb6+ybNFoSrf8yU8UhG1xwT5Ldj4nVecMJJOun9R+hQP6ZptlHMCaX/OTLcQoQZJzX/gpkZZhkbJmJ5yS5D0NLb40i2svVZBf3jvBCnWmtLPAVL6wMX2YMC3Ki7ABubiDESLmpqWeR8jLcvc/Zsh5s8QK19qm8XyLIJrUhHB19Rm4kA110IxvfyAFJx23tyRG50tysOiNeP8CxQX2/v0Y3yYVPPviVBp8h4yTEpnOpx2UXDnYo4Jjznfr3nolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhyePhIrGVjyLEtzfOQPAqDFYrqNHQxVtRx3EAmgHy4=;
 b=h/cdj7lv/b1QwHLhzw2T3OcgGG8pbPtyAbXLVe1gKFaT0Tnwm+q94m0w2rpap+6eghlQnx2/jsdRd4v4NjUJAoqNGstvYZpl9UiX5lY/SN50o2n0wX7JkMJJRGoaF2idaUUMk/iNyqgys1zORa96UNazczXRKbS7lb5h27CI4zKw8PLyhztfCzjuqIxO2a1wGUY/XCN9v0+hKrJtQam3ttNTDXQPF/UlyGvFrxDQWCFNFMYKaeJy+mSmJXRlJMwo15jViMqP/EPt6UCtznkPJDhDUvGeWdfZJyfYWW/obEeOTNjJbIvWmj7baj1PkLDEPE5iFSqz0VrWr/rd2dzvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhyePhIrGVjyLEtzfOQPAqDFYrqNHQxVtRx3EAmgHy4=;
 b=JxVoVjlLaorelkz6XHvlEgAZdAig1v4AAEdriJB1PYqTBtwFVsRGUeQLzZc4bcexPsThn3Fm6b89/CtGiJwAseihRBUTLImsVQSoct14NYiK9Q2sJbVnD3hMBAfFAXj3vZXZLcPVtZBNSpk/pTfKG0EM/0OcxZKsRqortYXzwTc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5000.namprd10.prod.outlook.com (2603:10b6:408:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:44:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:44:31 +0000
Date: Thu, 7 Dec 2023 09:44:28 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
Message-ID: <ZXHaTIvFruYfycsm@tissot.1015granger.net>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213332.55565-7-olga.kornievskaia@gmail.com>
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ab50b6-57ce-45f4-2892-08dbf73305b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WlzPpsqAExKLWfHlgdLa7e4nVcGKvW1J58KS5fZJ4CecdFmpvZVGSeA9sboc8/j02+OPlGcKyHWYWXL1sbbM4b+R/E7MpkB7ijLPSAOy+03w1JJTB1F5XDCzseD42bVIySrPOURX0iMA5yw2TG7Qb3yqBkpMPH4uTpKPulHsefrhFPKlU7ov99NrR0TBK4bnOIBlbvxIW+Ne4DJEygTckJJABgMZgZ6+5ZB4xC2vcctq6QdNOF6EYWAVD+vw8+z25YQ29HfSRSt0xfRvx1fRvcFG2e+auVtYeaB+G+8abdhbE58sydhLNcmKXT+gch0NhsKUh28wZ0vBmilaEPLxt8oshfqGnl8Gn+7Ip48N0dUbg/s99mb9I1v3HVl18w+U1gPLqk4xtARiA+j77TiNc4iDhkFKUs9Qw7yXset6DroklXosP9quSK/rcCcG1jB83YWvXR3BVjez7YacogZmULSk0N0VdAVnpMrdFDjU95M7B+IE9QwZaIMjVCSbZttzswyGbXiqVhEetSyJE4l4bVz8IV03VQrSHtOqsdsg7QAoH/0rCKOHEF/2NVrDbSVE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(9686003)(6512007)(6506007)(26005)(41300700001)(6666004)(6916009)(316002)(478600001)(6486002)(66946007)(38100700002)(66476007)(66556008)(86362001)(44832011)(5660300002)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hHX+zixxBI29u+tZTSwpn9pJyoBdlC2pFJbfuUpNd1BCy0f4QKnlzSXUXrDd?=
 =?us-ascii?Q?9LbJYYTVc1BVMuyMR8npcO2KlbqqkRVtfI2kwQJzPJkBEffyymYPJhmIOzLP?=
 =?us-ascii?Q?Bvc1YDjzBXOlnHNoTfFGpF7awCPWZqVPBfNzzs3bMPLEfNsgTlB+CzUJwUN0?=
 =?us-ascii?Q?t7vx8Q24O2AwqEhB+F5AMMImGFf0bSz1isZlsctSj7LTfSDerXc8AlpBU/Hm?=
 =?us-ascii?Q?1AtYkqJ9WlxNKCIxcRB3oJtS7hgH6XNjCnMfCZDgbyehlp1lopijsa+dMZbi?=
 =?us-ascii?Q?7Bbtke2r3nt6rvzQtzz1WUBg48aXjbMtJnkvRGPK6+rihE6Oa24HeOKW5sSp?=
 =?us-ascii?Q?SNSBAZRIV++piIVXD5tTcvsVkprQcoqMHFcEerrNTAlv7JYADY3320edW4DU?=
 =?us-ascii?Q?PTKkL3HGqiB7PPD1tPKERX4zslhn+SPQX8J+Sca0UDusN/P6a0r63W9sshp3?=
 =?us-ascii?Q?lQ6883+4C/aSgHMW7CriS9axyVskzrtYblKGWNCX0m25S8pYCw0/k9fMYyKr?=
 =?us-ascii?Q?8FFG1d+mnUnbU76337ae3mzcHmL4CAB4Wd/QsEk/SayCG3zHUKygzIStCtFC?=
 =?us-ascii?Q?xsY4RvTD6YL+vRVSiPopqE5EUxxpRDwx0T8XgTMchJx3SLSiJ8jCNT0SGjHB?=
 =?us-ascii?Q?b/BDa23gl2/69x0eSt7n1KBaZNUdcwpkmjCmUJrCPB2UYrTO4yNXFTGUJN+p?=
 =?us-ascii?Q?Y2kzLBmDc+Vb+lN/k6hI6vkbrGfxquBvk0g61Fcw55Sj10/UuCHhiixtilnb?=
 =?us-ascii?Q?eL7EGrfLO7SpGV65SmHaZo8EqRT/X5Xg+gjo8Q7bWfjNpLdtO73Jwby5FUyc?=
 =?us-ascii?Q?AO/Xt9NEyJba00unqfJe+pkapcegYLrUCTkS66CL7ol3YIeYoam+ZoU3m1sH?=
 =?us-ascii?Q?ee/dm0Q0x4Pgzme58YIIJ4dkXsq1bY/9tI78UiBfvDUU7im6VTaUgv6PATmd?=
 =?us-ascii?Q?8HH94ZSrAdtQnr9hjr8wXCeI1pkgVmEICR8chVRnIMWbuqWB+2FMVlPuBgQQ?=
 =?us-ascii?Q?X1cRW/6Cts62SFhwG5x6SFsa6SrnXABKF0G21TYAlNflyEhmpuflsScenK+e?=
 =?us-ascii?Q?bdcaSS3aQDnVrpfrRS8Ua9IZYLClP3s6CYxHQw3aeQfbAAadXi9yQpNwWHSg?=
 =?us-ascii?Q?c/Q36XcOIBRof5zxdv5NmQd1TcH2y3CBZUosbclNZMvUgVFRJnpXaCYAtT+c?=
 =?us-ascii?Q?HoYgCYUcCAoIaVTPrdqdy4vOK5y8t7kvsqvA5TyZtujSm4DET3RBlCIAuzmm?=
 =?us-ascii?Q?L2s9V/QShLcukSpMgsm2Vo3SN3mn3ExqlikY+SzkhFdU9hwGYTUub0E9+ILw?=
 =?us-ascii?Q?M2JokqJpg8MPWcNNDL8Lr4Zie7oVqjxHvhBp278sZNP1YYQvRviY+XAADK9z?=
 =?us-ascii?Q?ILBo8TOjdB0NOpW9g6/Ek7iA2otXKtXE+vMibQSaxrBhu44oa3Tsz8rEqDHQ?=
 =?us-ascii?Q?PZ+2q8ZPHZag7CVBtcDBxn4q5WJ+kB7/gv379XBGITNfDDjLttu7NG8ZAwcc?=
 =?us-ascii?Q?L/alH0O8h56lQ4M695+18ZYCOvXqmXIAynSAHK+JeaRSDLgQW73m0j/75O8V?=
 =?us-ascii?Q?tR/fnaEKpcZ2MfUuoSg3Y+3QHyAdlHcxLYtPkqWd7/EiS20tigoLijvqi8n7?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IqPwiYHhbLx4vamIfo1P9/ID9cyCxPJ2ebzkV54fUceYuFDwUYo1uo+pcpVSdfjAnR6P+1HgwOWQvy6+Y3cpRpsF7jCndku4PDMuyY6lQvgKMOjOAdsFzx+4rzrO4XHtsr3MH9yPOI9Y1dkIGA0OdAZ00gk/Dus9BI+NUgdsnx7CnrkvMwgQidwV7dEhXMP3arj7jKz4Q1wSRMbOFGhN+iD2Owh9GquJ2GOpoRSCS4HOXNpBCNaXpe7qPJUa89Ba2NNdR1PkDth8mlaBTgnzg7RUSrs0tG16rWDYK+Ttm9w91NNJNM5PNbPlOcF/gP4Rbo09RRm0oPvfzmWSS/SEJA6dvrdcxeyaYyTVM7ttR2I9HcdRtnExGkzdUDrMuPORdzyp3euNNQ8fttWBc9rn0wyvx1itRDrvJ0j5TsebRjS4Ge+scUqytExVFUffggANgVUCeIEKdKS4jUtShQqAxukN4iaeTCYxXB0GOxh0/EhPTSV9UZxwbFc6fKGsE7m+XATCXqQ4KArVhj7XEwW0UvGxk1dtgXqJU+rkaHfyB3h7luVKMsNDGuCXnxpzs6v4VEsMkih1yEdBd58hHWZlSxrvhMLIsfxXbqfeuZu/JRJI0HxxyexzTTTJLXwNf1Ifr3pbS98SIqfqhUUNLo6+WKqNquBj+6flefC5h4FQweWiNYP0RfR6QF1z8w371hfRNYKpieFW9bQZwOah/9vn8ckjg/TCcP8NTl6gtseDOYXW1VTZcabfRbtLnQZHLuqgxg7vIMbwAleuT5BXz1nd0Mma7sr8uJQI1sUhyk8lmxSiYXhXZnmFrI5OVTLOMUDo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ab50b6-57ce-45f4-2892-08dbf73305b8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:44:31.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNgGs1VTfnmUqFxJa21xIG21q60hcTsET5XRTA3HimspWlJ9kQuzYoPgrZY8BIhGYtn7qhjL/9gOGuMmbGQbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070121
X-Proofpoint-GUID: cGRWe_I-IKEffypP-PNkosN549_aFQtE
X-Proofpoint-ORIG-GUID: cGRWe_I-IKEffypP-PNkosN549_aFQtE

On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> If we have rpc_gss_sccreate in tirpc library define
> HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
> errors.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  aclocal/libtirpc.m4 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> index bddae022..ef48a2ae 100644
> --- a/aclocal/libtirpc.m4
> +++ b/aclocal/libtirpc.m4
> @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
>                                      [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
>                           [${LIBS}])])
>  
> +     AS_IF([test -n "${LIBTIRPC}"],
> +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
> +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
> +                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
> +                         [${LIBS}])])
>    AC_SUBST([AM_CPPFLAGS])
>    AC_SUBST(LIBTIRPC)

It would be better for distributors if this checked that the local
version of libtirpc has the rpc_gss_seccreate fix that you sent.
The PKG_CHECK_MODULES macro should work for that, once you know the
version number of libtirpc that will have that fix.

Also, this patch should come either before "gssd: switch to using
rpc_gss_seccreate()" or this change should be squashed into that
patch, IMO.


-- 
Chuck Lever

