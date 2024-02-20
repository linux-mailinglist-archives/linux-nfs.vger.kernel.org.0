Return-Path: <linux-nfs+bounces-2036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DA85BFD9
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249401F23D8A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B573165;
	Tue, 20 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XWleQwbP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sl4KK1qP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A946BB3C
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442938; cv=fail; b=RHT8rg75ZTHe52TINg23kVXG8osmbApTqFtzAsQDvaDqVIN908mB+XBLP/+XuzdA34cGtfk1+NDF6YU9HzDJwhqMDytfWzjwH5OVj2xvI4DnCTAX2+fgTWxGdYrf3AjuSjc6HbNQk8+hUQOz+nIq/54RFNmvYPlMLh17rkuKU0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442938; c=relaxed/simple;
	bh=vz9Y3hZ2RpcPj5NTwiZDVJI5OrH40RV62X20R+gu9eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GLaK1PsSPN5TykcRQNkFJQ2Bn7597JUBCma6288aOVaaRYVYCYd1netlAaduDHV/cKxZNtGvnJl9nkRFLKcu17SVZGRmv59o1bENs517Oy3HM3aJ9xflOfy3DMURUyJO8mHeJD0dy6HZHk7CuSBzbk62tmvtsty5cwFoB4+fLz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XWleQwbP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sl4KK1qP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEeKQn004445;
	Tue, 20 Feb 2024 15:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=R0V1yD8bRZxfrKUSl8JUsjlTqLDkvP9xVxmNMfsOUkU=;
 b=XWleQwbPzM2ZVyqRdsX6kNvxUA2uOY2ed3AZCfHav10vnfGlCSGVEBOHX8dPZX32AZop
 dJAZf9nj7GnN4qlqDRzbKP9y/sAYMtuJQwTdcHJE4oY07ALPMuvrEzBZ1ONCdvhWTqAZ
 jXBO7b1mY9EC8VLpNGh5L98PYgIiPSTyq2i1ynWreKeQp0swqyXBbbyHKYBPsS6lzqD4
 NpPnNpMXhRuxDJsRVZKV5Juha6VSzZcmkh1mbWySNnVl815B0hGiOQoSE3Zmv2Q2xSgp
 f4wfIu05Q4G5wcBw7/0p85V10WUv91ygnNa7namJCK02Quay3qqSiMN3a0a4Hlu9+rFy jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc72yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 15:28:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KFFac1020995;
	Tue, 20 Feb 2024 15:28:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87mq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 15:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImZ/RP7uJsoA656MvaZPMweAuywUatc6VFCkmykiI1TgNir5dGWn5jn4KSJYej7zMGx5bBXwWEm703k4eyBkr0Z4kxSYF506UPOsFtNbwX+0AKTt7DroVWkhwJwRDl3WUdw1Neb1o9DUnEuJ3PmpBpIy1ZKZFGYXyYTsNLWXN5tLhNe3LKf1bxumwhMUXFPMixjZXyD/+Ft0nFbJy7TDtUYAU26hTyKFOkcMhWytGVZLFboSaWlCH5hu7++WprqwXLuh7N7ORqPUIMt7XqwbMKPc+oxxtW2HRajnUeKbRXAhXiEH2fYgZxxowa0H2QBTRWegfdDzHhL92WnLdY3/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0V1yD8bRZxfrKUSl8JUsjlTqLDkvP9xVxmNMfsOUkU=;
 b=oasJ5+AyefZDJFiageYRTzmYUE6TQECkfEJJ/JM+YpR/JbfwqiUVVGQLespP/rVyopjhkS3Px2j8qWuXvBf+3CWSU7qG2NNGksl6ogWil25qYBnrBlOFWKu7DbN+9KZRG6LmlK/FBczUGVHzhShjhSZnTpemoKMkro8AKJ7Nk/vMoo/h/FRQv3UOYB8n9FU1/80NjMM9wQ74RO6Qc8i1rAxEH6INE9pEwu/pcjKIG4glqOtGfN3outSifkGfM29oaeSKh7wqMsnaHsI8DKB7Zk1izKTGNnIq4BuaWX4P/9WMx0ZZZpO5yW++S4sVD6wVD12UlzcNBlXqsgMeYir4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0V1yD8bRZxfrKUSl8JUsjlTqLDkvP9xVxmNMfsOUkU=;
 b=sl4KK1qPh0qXTDVex/Wz6RybVIPGlexsHzu/Y9ETrcUOtT5+02MA1WdBydvlm/suwP3I6osMMS2It5/7tteuhyyh5OgqrxYXYm1zdNgvqwKvNbVuny5tMKjM8XVhkFzR4froSo3XZBFEqRZ5/z3/0fRfOFzBYUFG0E+oQ48dZTE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6952.namprd10.prod.outlook.com (2603:10b6:806:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 15:28:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 15:28:45 +0000
Date: Tue, 20 Feb 2024 10:28:42 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "trondmy@kernel.org" <trondmy@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix NFSv3 SETATTR behaviours
Message-ID: <ZdTFKg2IB5woA7ql@manet.1015granger.net>
References: <20240216012451.22725-1-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216012451.22725-1-trondmy@kernel.org>
X-ClientProxiedBy: CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eca987-2b20-4fad-0518-08dc3228a046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Z9zLRCOSdsbCCB1K2U7flLNSojxSVzpGWB7UuhZzC4LynrYZ8UvGNBuCpZn1ZQWiUMNsRrzF7sshJrghn9GJZ4YvHLpm33ubTnS+1adtMVjkWHg/j7LCOWE6aW3IuA/DqWQpKkeNNqf8AUSMO6+JwEtQ/+v4H1WAJTE95gDes67lybKCK9hmfRl1aKyzzy36/lhkEuSYAr0O/1iLZcUe7UG/hyWsPda7WC6eR6tZLfdKrGP9aHSetnjRrveoSuW9FM02hMkLtLR8d7/LgQXau/Qxwp7D4DKPKfhXhEnyg2gLzZwyBrFGe7FLMG942o4WASgg4BaupFSKW03PELZ3pQid5/tL+k7Ovg0i9zARiynjIvaQR6XKK9nRjBcSFiPnOlq8UMxOyYIenYWDDivlrfrmte6n1O2kx0QDNMIYEeI0JvV46plfK5l1YVjcJZHWw0bwi/H/jPfIgTn6FQhEj3Fg7OxwzAmgmDRxzWIOWra9MhMkrY5bPwYes5NkmHXDbG5TBM/jZ+pvLhDd3JdZg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qDY3H9uw1M5D2PY58jGhPKr+/fabaGfxETTFfs/bXTqig5kx4db0X52vH9zy?=
 =?us-ascii?Q?0JYh+zTnhIGOUF6/rVWdPtGAfXUcEFXCIa5w6QnajfSrKArMzWC549ZVX2iR?=
 =?us-ascii?Q?wSNKnewhCCH2HqTGRRaq3MHcCeqHZpinA1iDe3MDUKJyena2BXNN3NdXkJTb?=
 =?us-ascii?Q?SaWhxndSvH2V/PEOBejHRAFMfXpb5Q9LuuoEAJeJdOExjzv8w9yl1eqPFIvO?=
 =?us-ascii?Q?f6BLwY9yTVFiZKx4i3l0ItCpSym973JJsYxVF2CKbLtMNgT37CGLYg+O5Auc?=
 =?us-ascii?Q?/BBDfyBeJYdGzWh/dU9Jn8WUfT7zzHpexMo8iMvXjvE2a57/ohJXnxftjG/O?=
 =?us-ascii?Q?a+M/S0laO0qRKD5n8CEanjT7SF70v7kf3ujkKYhE2n3t6OSqM8vWUBdnnEEQ?=
 =?us-ascii?Q?NwUO8QcsQXkpekgKB2ZIz58EW8S++9ztvo6p3EkfrpNA8ZjMK24nkY9rV8Yt?=
 =?us-ascii?Q?oDWtl4tgDlzng015qUk08rtYXwzY2Fjh37tlL7ODfAM7ud6EjFUhPt/H+2YF?=
 =?us-ascii?Q?7pY+fFaoalMu/TTRz4gVGOpH3s0jybnr4uERDcwQ2qp1K/yN2JwN6kHk3nHd?=
 =?us-ascii?Q?hRv7bGSyrl3bbY4lllP77Gs9hzoM4SiwFmqF83K4BI74VjI/bC6t2SUoV15P?=
 =?us-ascii?Q?KTJkGURO41+k4OjG/OMLlwBCcGbRN2i9AjxcZ0xTEy1Q3HiUjRCMVfwRDLK1?=
 =?us-ascii?Q?2WzlnLDsjsRrd1TGnd0IV66VCI1j1uJB6GwBHVRoa1wnyUVFxwIPLQDa1r47?=
 =?us-ascii?Q?WcZKzP2zbfwyb9ADIZiKYH7oqcW+juj/SSe5K136hNegYptvW+AOedzlYImt?=
 =?us-ascii?Q?v7WeWeCukKgxPMA8GzdQBRGOZSJwTw7JUQuSgPcCG2l1KE3M/FrFnCh40V/g?=
 =?us-ascii?Q?LiXHltgwrOhl/HBfapmvwWxtOxZOwVyHiTf+JvRdDnntONmVTNc/HQstgI9A?=
 =?us-ascii?Q?NELXY/WC98AoiwrGDKQqHTpwFm7AG3nufKnlifDq3fMzy1Pb5zj/XzIvzij5?=
 =?us-ascii?Q?sItcQF9mRPTtCf7nnd19mnsYRqCGYwWstY21sjzU4TPwfTBNuUY2X4OyHwub?=
 =?us-ascii?Q?EiB0LpBE3BRwLDeXPlcAIuMEC3sAf54nMLT7y2dnGizsUmqd7bpWdKLCFHJU?=
 =?us-ascii?Q?8aWvflaI7C8HJogIZ43Fup9zrU4hg9+9L/VBGPO3u6y3jbPPrjjVUeZVhnbS?=
 =?us-ascii?Q?CbNVke3wdmw/kM3IUcwH4vi31Ya0U0UKr1rWqPTo7gZt1rnKcGNTcB+D/gcP?=
 =?us-ascii?Q?x2nrPzNTXuPBMHHLTbxXUXInTu0JsBc62A9o73ez2zMdfeW/wYRsn3zaZBES?=
 =?us-ascii?Q?uSy0Cze0OFWGz+WtXJwZ+mVQ65jkme9AzKrO39HLSmnYZY7D+hXcj8DXT+jB?=
 =?us-ascii?Q?8mvUqoGaeU0eX5+lD6Gg+FfqWDTUPW7Q00l63rrG8f+DRX9lqAugehq0PFBe?=
 =?us-ascii?Q?t8UzyZRPZfod7N1YRkTs1biCfLIPwS5PEnIYPyjBGpJIhZGpGm/XwuN9M7xe?=
 =?us-ascii?Q?cjLGoiooZThv+vkOvKjAw4cTrxSXxgL/Cp39+kMjtrYjDdxFu/2hUCaAK6YZ?=
 =?us-ascii?Q?+hWBUipTsCnF+yTyAwF8xW5vVKnALhLfKc+tGAqNJQqailqWse3hiSLfT+lk?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9EJN+SEoO3rNCNTgIXNJXpC7C7/OH/HQFPtkfs+ro15SF0ucC2EVHJVP9efOhizt4CVm2sRKPY5sHyeXsv9tHbgF+qFG4O6F/0BrKbRMI9obC19+NL7XxLL4cdQBXf43Lmw6zZI0PindecJHyCIF+vFp/atUvU2QSvMAMDZlIPyWBllAL4ntRkBUaso5QsKnp7IDcBtajiZi2UJktecLztWG+e7JmPdga5DmUuF1J+l81/r5FsUWseGqCvxjQSXuGDsxE3R3IH5k8F1+LoZrDKKeNoGlM9d31FSh+hqeaKRZ+XmAqm9kBKO0CElxcU+huBmvlBCXMdRYq/iFHF+lOz0NOyar1x8cDhjQAwOsiX2HSJRhzDrRj+bFl8+mthiVtj71aDqxMIXRZahPnWVjTK9NYpoi2bFEk5WH6RmSekMNVt4hMQmHjnp/8JqOKzzxNxRLDjNSRGQku7Mv/uZWskTg66woCHvJUyioUjMWWdUe69WbrjORv9+S+nxvpUfVOErXVWTyiX66Yma9jjfqKt0+Lrh4lhljw1zmVHco0Wi+hoYNVgYhPlv6MHMcsb6obEZpgeFYvNIP62F9jKYruMTAOo3m0E4cyQqvh7vr7IM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eca987-2b20-4fad-0518-08dc3228a046
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 15:28:45.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AokmBeqnCAdmFiKEJYt4bDsYlGHGP/9GA0TD9sbnqtEYhVKTI7tAThUuQpRQvi+sV7OfIYXB7s5ntGgpjyjsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=726 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200110
X-Proofpoint-GUID: FsSdxxWwQsaCabKW3mX9j4NgpX8a0E3t
X-Proofpoint-ORIG-GUID: FsSdxxWwQsaCabKW3mX9j4NgpX8a0E3t

On Thu, Feb 15, 2024 at 08:24:49PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Fix recent regressions in nfsd_setattr(), and fix the "guarded SETATTR"
> behaviour for NFSv3.
> 
> Trond Myklebust (2):
>   nfsd: Fix a regression in nfsd_setattr()
>   nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
> 
>  fs/nfsd/nfs3proc.c  |  6 ++++--
>  fs/nfsd/nfs3xdr.c   |  5 +----
>  fs/nfsd/nfs4proc.c  |  7 +++++--
>  fs/nfsd/nfs4state.c |  2 +-
>  fs/nfsd/nfsproc.c   |  6 +++---
>  fs/nfsd/vfs.c       | 29 ++++++++++++++++++++---------
>  fs/nfsd/vfs.h       |  2 +-
>  fs/nfsd/xdr3.h      |  2 +-
>  8 files changed, 36 insertions(+), 23 deletions(-)
> 
> -- 
> 2.43.1
> 

Both applied to nfsd-next. Thanks gents!

-- 
Chuck Lever

