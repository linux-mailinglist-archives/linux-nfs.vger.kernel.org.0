Return-Path: <linux-nfs+bounces-667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA3815725
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3531C23F6C
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16343107B3;
	Sat, 16 Dec 2023 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oUtxmO+F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FTxqxQOH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2323107B2
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BG3C0Kp018136;
	Sat, 16 Dec 2023 03:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Nb4BnZrivl17FGLjdi410toW0W3GWePrR9F9bwTgv0o=;
 b=oUtxmO+F6VEaeMiKY9+KA/8/EFIPI5aBL9XbqhRBlKFQhPbw5FvfRYQZ6TZB7O1p6XfX
 npQftkVedJNw/8C1XIql9oI8vB0k4U/Jr0yrNlKTtL/bxiAVIBYyBslimQStmFAi+XQe
 n7lJA2sz92KXG6Q1RdyQH6ux4Y6OpNaOTIjlEaiiUQeTBnOYiN5zrZItZj2NI0ojBeUs
 7qpxcNnkIHY/PqpDCpLWJa+oDTqElE3Yfy1NCQpMvNE4fAS3av9EU1cEMEeLeIMAlLtv
 f32Tsy3Yg2klVcJNwRVY8KtkDTyvV8bM2dJ5ucYuztE40APJMtQvcYYhsLntVKYeVceR Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb00wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 03:57:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BG1XN4Q028994;
	Sat, 16 Dec 2023 03:57:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b2ujer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 03:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6cZZjhCMb2eE0De1hXG2I+dZtQkRwdaA0wXjxI725og4eSp8gBpf0rdObsjNwx0rfzqGf/5+2X4Xp6cRmvWm02rvV4q7fC6qnVObk/3SPz0TY0XwynPYoTNYZ46+wnnRFQmS4+bbLGDKrOvJbOYD6aWQ7ZNLaxaYrYxdIEAIN5BRgssqUB36VS9R4aiRNINKjJ5QsVd4XrtsUInrplxnF5AaBeDrZfgO8YrEc7L+yX8C5FtZeTztdmbvnkaVAOI0SEeFopfl/BdYg4irigQU6Y6mlv8BZDqpuX1CmANkF/jcegijGA7O+Fbb8v7g/zQEf+TaZ2jkKkcWzRBfMMA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb4BnZrivl17FGLjdi410toW0W3GWePrR9F9bwTgv0o=;
 b=I8jQoPYgt41hKFJ1qNpwGHsiBCRYsAs+sq7iwtUgYVMhp6GKTYHJLpWfpZIzGqyZAdC9m051Jke8/KgCRtkePdEee0c+W54OieM417YyUT7FxAsMfscaMVKDrXJs6D9CZGShEnc94LMaEzHVOb/WubJGL0AAVxDZ3PLY0oxcPLo5mgZm1qa+C2VN1DkdUrupjj6FGZQmCQLk39ibkPtzstkwxQhAX1EJay7gjzCpo3a32U5w42W3tCiUhQLYzsO5VGUjsVbO587KtRlnQhObuwyGmw0Jc+CxMFd0GVMV/GIDagUxNMQ9LQqM+nYWQI2c6+FX0Aim0XcjmfQZEpDbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb4BnZrivl17FGLjdi410toW0W3GWePrR9F9bwTgv0o=;
 b=FTxqxQOHkvsHtwx9iicF5h5whdClAtJzZkCSbWnBOR5420LDWIl1ulggUHlvhibAkjBeiwl/Wa0wMfQ6P1/nWO2Z/Z4aempPtpBJwrYGYJMKNASHJQGDKS0n+n39GKCQzVz4TIiI5P3f8i5E7yxcNbdvPvQQH7AwOH4OQyc7yb8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5389.namprd10.prod.outlook.com (2603:10b6:5:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 03:57:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Sat, 16 Dec 2023
 03:57:48 +0000
Date: Fri, 15 Dec 2023 22:57:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c19ca2-47b1-494d-d869-08dbfdeb2b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cwh4HEix7c5aiFbNMFBIaSOFqNtU/uXqkkgvCSxI+FNuKEcuvE8XxX+SGmxKKRI8fMf2yiy9t7eVbz8GebcwGJkRuf40KJTWw+PfoSHEbFeo7CG+sxMZ7EhIQxb6pC+nEu4VZ8VRoIEDP3hivTA1rQg65NWX4rF9oeailB0Ew1gTlWv92/rgD3av57QiNQsLNKIeOx+MgT+x08N/6vhIwcVQag2RUh+n2sU44x4Hzn+RLTIyjBgZ18/PQoxcv9kdd/sgmaJtUydtRFb2bOHQD3k9Na/61UIccPkTisrxWtDhgul1e5pvft90dHAovk4rClcrm6fDauQEtvDBVLcYuYZjUECmDo7aw57j5lKTgFRAP2V3fkSzL3+kFUQenBhRQ6X4Jm6Li7ueYs3RZO6vkQxX7RpXYjqumTtR685lOrZZDTeL5z3aWF3WPMi0zQrdZ3O8OLVKZ0EwGgyA7QpCiL2hUcmGbCR2Tq2mCfbddPMrJdeqTpvSeMyQUvQPkjtJ/adMnwRC63+aeqiITRXrchovrZ3XppSEFCApKPviMbj1u+t9uYxO1TM4SJu9tgIK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(6512007)(9686003)(6506007)(53546011)(83380400001)(5660300002)(44832011)(41300700001)(2906002)(478600001)(6486002)(316002)(4326008)(8676002)(8936002)(34206002)(66946007)(66556008)(66476007)(6636002)(86362001)(38100700002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uxtn4PRFPPN16itNKVcurUEyiS0ZY/d7b+XWKTqc71BwagJXF9/BK3jmRzny?=
 =?us-ascii?Q?vPhqgqX+2PpVjbLNQvK5Lo+U0X3W21Zxe7Vt3nWfeueM3dlwhGwHb5LdkRu2?=
 =?us-ascii?Q?0vxoujiyIDPIb3hREOORSgbhalXKz6hWZJgWMGQeLA69BZs3S7dlqAbtEe/P?=
 =?us-ascii?Q?3yPWicg11UediPZO4o4VGV+WHA9IiSEfvE7aFJqyzlHOhEgZ9tLt+g1cZwMz?=
 =?us-ascii?Q?DJ1gFeIovB9yP72FkTs4+RspqAa6ehlSpKhxzBHcPsLOc9aCj2lbZDrT+u0y?=
 =?us-ascii?Q?N6fZ3sRUjfpcOHS6N91kRHlfMM+jUVk0A3ysSFZyJEpua9jpPXqiXQ2FTvWc?=
 =?us-ascii?Q?VYzr8Wd8mQT4tyXQcQrg3STmSdGZfu9JW5gSJiIWZKKQsLIqIKEsQ7yFghll?=
 =?us-ascii?Q?X/oyRvhl8+e3Qk/2fL9sWwMLPnYGNId2aEG5xneFRqWSSZ3AKUjTdgB/AQiQ?=
 =?us-ascii?Q?6z+stK6SwsAcccPXBc7dFlLH/FKO9cZtOa6ndZsSP7v5sUKSGoc3U1RsY56x?=
 =?us-ascii?Q?gx6ubwjY+RV03ddLOfOrvWGxoFfEWom5jS/NpZ7owDimTS6aqpiLeyY8FWPG?=
 =?us-ascii?Q?MlRNk+DEXIM8W+GOnw87+H0Fmq9KoLxLFFqQ+frIunh/9I7NVAeDRGZ8H2yT?=
 =?us-ascii?Q?FWpoknTgY265QoI9WnAO5mNB0PrcxlTocFmGe8tpvh11rZ/oZmcHPStVwN8p?=
 =?us-ascii?Q?ALcP6rtMVTrLHqmz3+LBBhIzpsIAB4xzajZc2XOJDMWqbNliu0Cimu4W5mFQ?=
 =?us-ascii?Q?zlWVRCP3TcEUHM95yaEwu4bOmuoAi0GgY4O3x+LsEOFeXOpO0PXamqAr5f+T?=
 =?us-ascii?Q?OxrFpMhMGI8pbHYbtmzVf+cH3vOim+mJEQGyprJmm7ddQpj/wd1uu8Ad8Q9w?=
 =?us-ascii?Q?BkuUJa3b3ZLpXUYyxxODC+3jI6Jl5AzlgLA//h7bTJVmz1uFS4eP6Enk49s6?=
 =?us-ascii?Q?y+M4qzeSHlOG55I8GRL6poFRllbbPLWB+FuVM0ne/seIVmjxhZWci6MKiIwP?=
 =?us-ascii?Q?9YsIqCT457AAB++pkRKwUHXmFxoaP5xP2cPkcGh+XpfdYcnerVvgN933qlJb?=
 =?us-ascii?Q?vefoDZqpaViLuvlAbjfof/7ylN9wv1ZPHoAH4cRjcCHcEjoxpyUU3pyM/k2C?=
 =?us-ascii?Q?uGf/y3p+6IEUEGe3AQguNR9YZG7gM+NwbZeu4irR7dKLb8HvVRxWnMV5dBpB?=
 =?us-ascii?Q?EiBi/8bVF6uDsARwSV1vrp+aTCtejmpGm+pzQuYOqyY9S8DR3G1/9EMwCWaO?=
 =?us-ascii?Q?EJomw99HuQwQ2YSDl/RPyQpPLK1rLl8w6Tbpa1iVpvRqJ6Bv2bQJh0rJfTlH?=
 =?us-ascii?Q?kBKiWdXZ7JTMYMR3x5C3J4Sc3Jfq5hXugaXae+d3cnLdV6HrY3mo6ThHKZmo?=
 =?us-ascii?Q?Dj/xAN0xMyJS6++HE/qJfjkvtS5dHnAJpngOdOCNXBrDVA5rkDExMfUt3FNT?=
 =?us-ascii?Q?vCb66XcUfD0086+GSr2BmHqxApjgG/5fpEYFzxqJduvgS4iwlBX2K7PA2oSm?=
 =?us-ascii?Q?cVqjbDQAVBsBPzD9R0POkGTrXQOwdXgzh5cGFCmIiyKPzgV142G7I6GLnde4?=
 =?us-ascii?Q?GVrqouRNsoQPaYkccNfyFRCWhtKRAIcj/KhSt4vKXKoK7VTWOKo196mxA7Dr?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	avzU0xOSyjdLqH++XjuLNCiPG8OCoNIY6iJVKe39gM+2MXVuu0yL2Y6ZRRQp/E86eet4m/3yXIl+WVVIqqzLjmRP6NyWsb7vJ3EQpWg4k1GRKLAOlQ+EO9Ppv/SUVbRcoyf0vCozmX+Tm+7CAZE8wHBe+TIc9wnHOUkvJtunzCw6qinJ3hr3KNOJvFzXOsAks6J92Mt0PLp81tYWS4IgcVuQrtudLVrZRv2ntp01IVT/u2tWE+tEfZA5pMT4LrnVazeucOrfbxI3tfm3RkPi+ViMqr4j20/RreqIg3PH4pBRTq6V7NPoepkd2VxGkGG2j9+A+5zm5+xyeh5BnJ9u8D4y7o4UdoLGPEHMLLUZrwCJC2+23G6mUguRGmEzxaEX4ZeJP8BeonnM1hPWXBHDjaSQhZx2hknZXqZVLUN6otS3kiuYnNsnpnTtCJs9yRyD3zdY8LJVeBjve+FAY6lz1pI0ZXBzJ/hOeEK5C6ZUykz8Qiwddvrcr1FAqLpuJ9IMYpPKmAVJCDYfSlrzwLqCLhXoe1BbPRAsPer2ujkkKx1virAgOEjhqHuBUHmxqPBRlrmK+am1x9wWNP0ZNg4XTvRQ+Q5kyvfenCfpERLTVTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c19ca2-47b1-494d-d869-08dbfdeb2b1e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 03:57:48.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siQdefLUG51NdMlTiwPx3CzBBAzDJbwi+VB421J0g0e7Bf8QIC72KmXLjIwBGUfBW6pRbNEvXI/ATT83VDrefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_03,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160027
X-Proofpoint-ORIG-GUID: AYDExBKJ6AJK3jDtpOXLRYPqJo7x3nM4
X-Proofpoint-GUID: AYDExBKJ6AJK3jDtpOXLRYPqJo7x3nM4

On Fri, Dec 15, 2023 at 07:18:29PM -0800, dai.ngo@oracle.com wrote:
> 
> On 12/15/23 5:21 PM, Chuck Lever wrote:
> > On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
> > > Sorry Chuck, I didn't see this before sending v2.
> > > 
> > > On 12/15/23 1:41 PM, Chuck Lever wrote:
> > > > On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
> > > > > On 12/15/23 11:54 AM, Chuck Lever wrote:
> > > > > > On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
> > > > > > > @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> > > > > > >     			nfs4_cb_getattr(&dp->dl_cb_fattr);
> > > > > > >     			spin_unlock(&ctx->flc_lock);
> > > > > > > -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
> > > > > > > +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > > > > > > +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > > > > > I'm still thinking the timeout here should be the same (or slightly
> > > > > > longer than) the RPC retransmit timeout, rather than adding a new
> > > > > > NFSD_CB_GETATTR_TIMEOUT macro.
> > > > > The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
> > > > > work item to the workqueue so RPC is not involved here.
> > > > In the "RPC was sent successfully" case, there is an implicit
> > > > assumption here that wait_on_bit_timeout() won't time out before the
> > > > actual RPC CB_GETATTR timeout.
> > > > 
> > > > You've chosen timeout values that happen to work, but there's
> > > > nothing in this patch that ties the two timeout values together or
> > > > in any other way documents this implicit assumption.
> > > The timeout value was chosen to be greater then RPC callback receive
> > > timeout. I can add this to the commit message.
> > nfsd needs to handle this case properly. A commit message will not
> > be sufficient.
> > 
> > The rpc_timeout setting that is used for callbacks is not always
> > 9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
> > maximum of 360 seconds, if I'm reading the code correctly (see
> > max_cb_time).
> > 
> > It would be simple enough for a server admin to set a long lease
> > expiry while individual CB_GETATTRs are still terminating with
> > EIO after just 20 seconds because of this new timeout.
> 
> To handle case where server admin sets longer lease, we can set
> callback timeout to be (nfsd4_lease)/10 + 5) and add a comment
> in the code to indicate the dependency to max_cb_time.

Which was my initial suggestion, but now I think the only proper fix
is to replace the wait_on_bit() entirely.


> > Actually, a bit wait in an nfsd thread should be a no-no. Even a
> > wait of tens of milliseconds is bad. Enough nfsd threads go into a
> > wait like this and that's a denial-of-service. That's why NFSv4
> > callbacks are handled on a work queue and not in an nfsd thread.
> 
> That sounds reasonable. However I see in the current code there
> are multiple places the nfsd thread sleeps/waits for certain events:
> nfsd_file_do_acquire, nfsd41_cb_get_slot, nfsd4_cld_tracking_init,
> wait_for_concurrent_writes, etc.

Yep, each of those needs to be replaced if there is a danger of the
wait becoming indefinite. We found another one recently with the
pNFS block layout type waiting for a lease breaker. So an nfsd
thread does wait on occasion, but it's almost never the right thing
to do.

Let's not add another one, especially one that can be manipulated by
(bad) client behavior.


> > Is there some way the operation that triggered the CB_GETATTR can be
> > deferred properly and picked up by another nfsd thread when the
> > CB_GETATTR completes?
> 
> We can send the CB_GETATTR as an async RPC and return NFS4ERR_DELAY
> to the conflict client. When the reply of the CB_GETATTR arrives,
> nfsd4_cb_getattr_done can mark the delegation to indicate the
> corresponding file's attributes were updated so when the conflict
> client retries the GETATTR we can return the updated attributes.
> 
> We still have to have a way to detect that the client never, or
> take too long, to reply to the CB_GETATTR so that we can break
> the lease.

As long as the RPC is SOFT, the RPC client is supposed to guarantee
that the upper layer gets a completion of some kind. If it's HARD
then it should fully interruptible by a signal or shutdown.

Either way, if NFSD can manage to reliably detect when the CB RPC
has not even been scheduled, then that gives us a fully dependable
guarantee.


> Also, the intention of the wait_on_bit is to avoid sending the
> conflict client the NFS4ERR_DELAY if everything works properly
> which is the normal case.
> 
> So I think this can be done but it would make the code a bit
> complicate and we loose the optimization of avoiding the
> NFS4ERR_DELAY.

I'm not excited about handling this via DELAY either. There's a
good chance there is another way to deal with this sanely.

I'm inclined to revert CB_GETATTR support until it is demonstrated
to be working reliably. The current mechanism has already shown to
be prone to a hard hang that blocks server shutdown, and it's not
even in the wild yet.

I can add patches to nfsd-fixes to revert CB_GETATTR and let that
sit for a few days while we decide how to move forward.


-- 
Chuck Lever

