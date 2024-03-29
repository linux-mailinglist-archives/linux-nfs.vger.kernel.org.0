Return-Path: <linux-nfs+bounces-2564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D88927E0
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A6D1C20B39
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD031241E7;
	Fri, 29 Mar 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V/Mb/P8n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t8i75VQV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FF1119F
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755764; cv=fail; b=uC34JQY6Nf+48XhDe0UEiPrA9Vi8NptqSKlrLQq8WeOxTAisBht3XvGgVXE3lwn818ijH0wTdRqc1qMF+i2r5cXKHTwxnmfQv1gKaBjDCrJpfJx1Q+HX4bmN2TBBjm1gEenULUlYFPdNIxjkXxq3A+52VmWVGzwNx+fMILsqjzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755764; c=relaxed/simple;
	bh=WwQ3BfP6xJ5AmuVCjtPnInsc1culrgk8XUztvAIsfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rk2u9jw6jB/Ma7FCs1vr9sPqAvHOEpo1u5QHXkHheQ34KJIm7VcKsPhPdb9IEuBAsN1dqllUyYh1C7F5bBdn2akp2iuaOCfs5mINhfGA0STnyhkMPkK38ClHww+f8+euUhErv0zY2RPX81tz9OIhf6NToL7p3DKCDhnAmPoIdMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V/Mb/P8n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t8i75VQV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TJeItq003552;
	Fri, 29 Mar 2024 23:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=XuP/8KNFagOpgnn+qpXfEUiyHN0lKylaoqZEhXPbKh0=;
 b=V/Mb/P8nvQwsbPe/ntMw9a0+n6knZrl9pBoU3vUNn2nidF+U8ODznnfPZDR9fPCfYiXK
 vh3yGNuCSmXqevjA6GbECzbG8vhQNdAZxOTl0fAFoyEkMgpAuBqavyHSdC81t08QPGdj
 H7Lqes/OG+Zhi4pAuDMdl2tk2Ja0vE3bEZ8mhWEyS++JYKFHjZkTBOFZeTPp/+Rrfif3
 E0wpn6gj4U3BkyGmgBi4IRnJwoNFyXY+7zWMnq2covQtdK3viHMSRVktl03LNU3DuFBj
 6pZ6SFfBQGFSt77Ql5UZCN5ewLC5AI9Dv/ojbpJqh69wOcMundMyzO20oCvnnd04bNks 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybv8xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 23:42:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42TMoIdt012905;
	Fri, 29 Mar 2024 23:42:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbs5xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 23:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM3psB/PWh0KK5OP6bhJS7fGAOwP+VHAPKWiLabZbPC+67hjIvflASEhw48XwsIVcPYgbw1FkLNWqHrsBKAyho/JbiJygILdzchy+MrSMRVuXT5zFInjKiaFmZKaMK98higtCKWtiydDJwSlF41pUyPf3IZncei/qActWewnCPgkcLhgZcoxhjpRDsCjjEPaIKHlJZ45i89tkmEX/al8vNw6ivaWSKG8yX9ir+SFya903oUHrf+K/Frdt8BgM9DPp4TRmfD1vheJpsX8HfnzqpuDAL240Abw9cJeLq1pKwmDAnSPX4prsOlo2/5qAn00i03/R9UqyY/hejwOiFdZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuP/8KNFagOpgnn+qpXfEUiyHN0lKylaoqZEhXPbKh0=;
 b=NxYFAs1aiWKuzsGWm2QI2VAJcnbFjY8K3LgHzeoDZykQhTjbucnUVxiTaSbmu6sTy1G0yE5OgdFsZa+GICedVbsI22H9qv+ReQDe6G1DHNar+V6Aa8lfumuXSezdHD/DrCYAx6FUcj06nWGzglnGst1AqprKmElWUSWmJ2jEmI1dy5ikEogh5+I1wS/rRfjT8u/pqwcbCL2p7mPJVulLkuPiWT/e+LkDhSipXHkWORvsv5RzWaKJuqIvO3oj+RqKgn7/DuzJNxO/sAWejTOIk3/+uKB0w1yekLDZQeZu4ULm9Pumqt2UmIbuzvPK0+iBeoX/3FbEUxMVHKFPvGYLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuP/8KNFagOpgnn+qpXfEUiyHN0lKylaoqZEhXPbKh0=;
 b=t8i75VQVloBGvjpCRrVXTLKfv8e7FonJI8zxmxIZI7h0Gk7GyTpdVyx5l5cuMPNTyB9V5qTtEX5GhKzIZgBI0vd2Syis0lxqAQAvTz7yTZh5bUfiJDwRwM5DGJzs/XY7ApePsfBFIOP4tdNAu4bIqLQiLGVAqoiViyjSfFG4qgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 23:42:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 23:42:30 +0000
Date: Fri, 29 Mar 2024 19:42:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
X-ClientProxiedBy: CH0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:610:b2::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gQXCJUZt56Dn0aVvU+f2Un6+B3DFRsLB/wSgNsec8FUjtk0uSoJG90Ls6c3U4WIXnjmfe0TY+9AbL9rhTu52H+/Gir7PJyf3ou7cr0Uqh9fJdqEgmwBIVxVEte+XPlwzaYDN0MsbbdFrt9Z0cmCX+M//zqOKTG+5bxMKoY3MjRN0ZKNK7+el0TimYX2styKvep3+jkfUZNFdmw+M4MZitPLVchBu7isNOJTAIFS0QqwAvh/O78PsevJur0fjhrsR7mAub+XOb4SE3pY771IYWn1IGmOmeN8jZ0Ei+dDv9nUPj7QAsN3tcSpOCDFJk4VV5sJCDIAjHMojBvBsGnWPvBC+2hRWnACgErz0gEdVH44eTnkAk085JV32GuMr/sznvNhC5Ddem8ZGkbqI5D6RNwqe6HsowLIMah67wjTimNK7fmCHEMOoSnrtXzjtCrfh05VpWfs0ehZ4lYhepxdBeBTbpHaXLQs/9cFQP7BoH/8MogP7u74M0bteDFhvwo3ndrBM3qgSAQBZdf7Lbp7FvbP+mVU6ZZnfkgp3qegLN560VHh2FY1Ri0r5wsJS4bCMnp8G3pYY/vhxT0BOZ0WlLogBkFya5NlPYM6gcoMR+GQCS4CDnUDnooKwqX23xYo3HkuvpGECLA+yp+0F+nXmxuZ8g99+69uqUwNNjAsrMYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PTDYWUoC5Npkgsz9W/Z54UqNW7joD7ATfRjNeXUK/qL5ftXB+31vt7Gkeuyn?=
 =?us-ascii?Q?v0B7ndOY1OG9AM28n3pql8//5KnxudCp+tOi5S6EVvxukl37X8sZugKAtCDD?=
 =?us-ascii?Q?CKlroCyLRHLRFVhzmQDbJ722iEYv3FNHgXhzNczJ6EZktd1viistZfO59/Mh?=
 =?us-ascii?Q?PjfH9yPeSLuP8yQEXAVCEmawX+Pr/5wcvLjTkjUIsAsELx0NRNrrtcot5ML8?=
 =?us-ascii?Q?QIVfQrZdcl49N/gsDEHefzFzLsHhev8dHBm1CetmJmnaKNBYGGYZq6w8LmbM?=
 =?us-ascii?Q?mu5L9jl82tlyNaf/vTNWH56iDlQNVK4tHVSX0q9CzZQoddsFMVT+wNwuJ5Uu?=
 =?us-ascii?Q?GVQC333DJPZhL3Lsnek9UtHyB+eraxIsi6XscLm0TgSiEUHGUdQLoEC6d1ei?=
 =?us-ascii?Q?+fUBUGBFKBIxtrYk5Epc7Wn+x5LqgmwOrVXyhj8tyZkwLL2cBL5iJuHp9h9B?=
 =?us-ascii?Q?udYSsaSwF115aDTnDNm6+JVIh2c/ZwVtvXXj0DryQJWvifdzjGgxB7WWJCOR?=
 =?us-ascii?Q?ED7ZqvYijyFLMWjOB6+N9WEg2sbW0zcYweEGylLt6l6poRWpSQ52AbKTk1Cv?=
 =?us-ascii?Q?dL8gpNU3pa+ril4hKtPgGnKKR96TlA1VGVXGEYxT0YtLY8pOC4BgZefdnFEG?=
 =?us-ascii?Q?kMacBY2ky5IR2VMqVnw9cwRLjsv+LcaFjDQq2BYquKrhpUAtDd9hza3GNILf?=
 =?us-ascii?Q?7KkpevDUDIJBprYttjso1+o3XJpPQjkKX7MXoidE/TeHFNLKAfJiXmzPF7LR?=
 =?us-ascii?Q?9tbd0fkhVSUxJQvvkUzw6MTAtc16IdPaQ2UDFYmEMCHAGUD/0xgsSNxxLFu5?=
 =?us-ascii?Q?Xo4ISLGB8XeQD5GX2mK686krR2ef4yS0JWmUQ0Y7qqlb9cdaDPgkZns+R6gp?=
 =?us-ascii?Q?Dv3+T3ur/mqQCf1sqKsANazMB7vCDoCh1BTcLc8MKnaTxbXiRDI8M4Z6poWr?=
 =?us-ascii?Q?gnYB9o/4eB5+26BZiIJIHmbh4Iszza9wUTD99TKu2u0CMs2xmxJeUCatyNyC?=
 =?us-ascii?Q?cFv11oTNpUsd9iqoDPZXMRPGsmsVMLPuK3iUCLOxy+9Fcfy5Br68NX/ogGjG?=
 =?us-ascii?Q?GTFXyYQ0D9p9f3h98MM1jP5gbvQm9ycMEcGVj4lq/8TFmt/ibNtQn6GW/4YJ?=
 =?us-ascii?Q?OEE4Ub3DJu5+zpqOvoxjHX9IpwvNUb0Id7v0Kf6qDpLngKZn/qU0A3ElvS7b?=
 =?us-ascii?Q?nOvV48b1QcwS89nnHtYIFRM6Ooi/b39BTUEazsssZCItgZlN/uypKECUdXXK?=
 =?us-ascii?Q?KN4xH0uYhibFcqWXf2VzHUAUliPFzQmisLs9H6rU0GNyOKmRWhWd4+5F6UQc?=
 =?us-ascii?Q?GxxRsNMiwV4c1jKfOjiwvIijyCYn4CD36BgR6ymuJGJwH1piuc24jOTx+Eum?=
 =?us-ascii?Q?4RZcXpq8doaOzteq539Zffy9K2QzlE9aeAJ1N1AJu4dw+V9c1K1U3d2rL12E?=
 =?us-ascii?Q?fOxLjvh/++SjatLRtIxIZ3RUAxBjPEiIRQHAl/gIAlDaqzP/NvLc+jmFafEp?=
 =?us-ascii?Q?wjwYxkIlLZHa/fpWe4PSyaVPv4tKwo24Pa2IB+U29MXD+JR4qM58uV3z2GrF?=
 =?us-ascii?Q?+snfRUiocoxHUDM42Q5SaAu4om1pv0i4N3/BOoMnoXS7rKai6fN+B3gZfbUJ?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WpTl8ROJGYzZ9fiWZtWKf5SyFKxn8muqEL6eYFOSzpRyLRf3vraxMoxOHnHhokf/DkRJpyXnx7891pcKM1wBT89sM5l1JOICJXGTDeqeNMroATgj69iaU4gTlj2VTairxXpOWmGnWjDkG47XwCNICduUqTyiG6/RWOCXMMdcPfWNG09qQW9lBWjjGXZmA6vex9/rPyFmlDdfTfeCtwYan9DjwUPAfVo0ktKTON/VaupY6dTGNaQIadGhwn/a8gtQmRuTBEE+iImPeSsqH/jumperE9b4wSVYaxnyNXZMbC6BdAbEG3XGbhWlJDvpRvbQct91kYB29DMA4PApaAV/j9NOvrPKB8y8tsdP6XMXAjkUXHd/D42DUJZKLXGdQ8850bYz2MsKeUkGwpihXqaxd0uEi7kOaz5PZZQ4+lumGjnpg0MDNs5mFKQEoCgKGkWyLMDJRovbiLNJMweTzT525cCKSKT16BpY6w1c4qYxR35Kn6CbgHSjrf0+ii0a195qnW/vT/68E/+e3MB4g8hMrbaExspwYOy5uYw9aWTrKTinCg8bKFahXY9fI0Tqiv3vpebRzJRYaKQFmoL5B6du6N8IrFULOlYP1MUUC/Xsnl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7119db11-bb42-4764-9699-08dc5049e5fd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 23:42:30.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXeW9ZYlfxatnF2ariBUT1Any0gBqKnozHLd9dbhXkcgKCPHliJzXsD+CQmB7FlZJXhDZtkm6WMBEvUQi89G+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290209
X-Proofpoint-GUID: AUI_d-L3CRLUN4-2K33dYNZP4uu_6jRW
X-Proofpoint-ORIG-GUID: AUI_d-L3CRLUN4-2K33dYNZP4uu_6jRW

On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
> 
> On 3/29/24 7:55 AM, Chuck Lever wrote:
> > On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
> > > On 3/28/24 11:14 AM, Dai Ngo wrote:
> > > > On 3/28/24 7:08 AM, Chuck Lever wrote:
> > > > > On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
> > > > > > On 3/26/24 11:27 AM, Chuck Lever wrote:
> > > > > > > On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
> > > > > > > > Currently when a nfs4_client is destroyed we wait for
> > > > > > > > the cb_recall_any
> > > > > > > > callback to complete before proceed. This adds
> > > > > > > > unnecessary delay to the
> > > > > > > > __destroy_client call if there is problem communicating
> > > > > > > > with the client.
> > > > > > > By "unnecessary delay" do you mean only the seven-second RPC
> > > > > > > retransmit timeout, or is there something else?
> > > > > > when the client network interface is down, the RPC task takes ~9s to
> > > > > > send the callback, waits for the reply and gets ETIMEDOUT. This process
> > > > > > repeats in a loop with the same RPC task before being stopped by
> > > > > > rpc_shutdown_client after client lease expires.
> > > > > I'll have to review this code again, but rpc_shutdown_client
> > > > > should cause these RPCs to terminate immediately and safely. Can't
> > > > > we use that?
> > > > rpc_shutdown_client works, it terminated the RPC call to stop the loop.
> > > > 
> > > > > 
> > > > > > It takes a total of about 1m20s before the CB_RECALL is terminated.
> > > > > > For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
> > > > > > loop since there is no delegation conflict and the client is allowed
> > > > > > to stay in courtesy state.
> > > > > > 
> > > > > > The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
> > > > > > is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
> > > > > > to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
> > > > > > When nfsd4_cb_release is called, it checks cb_need_restart bit and
> > > > > > re-queues the work again.
> > > > > Something in the sequence_done path should check if the server is
> > > > > tearing down this callback connection. If it doesn't, that is a bug
> > > > > IMO.
> > > TCP terminated the connection after retrying for 16 minutes and
> > > notified the RPC layer which deleted the nfsd4_conn.
> > The server should have closed this connection already.
> 
> Since there is no delegation conflict, the client remains in courtesy
> state.
> 
> >   Is it stuck
> > waiting for the client to respond to a FIN or something?
> 
> No, in this case since the client network interface was down server
> TCP did not even receive ACK for the transmit so the server TCP
> kept retrying.

It sounds like the server attempts to maintain the client's
transport while the client is in courtesy state? I thought the
purpose of courteous server was to more gracefully handle network
partitions, in which case, the transport is not reliable.

If a courtesy client hasn't re-established a connection with a
backchannel by the time a conflicting open/lock request arrives,
the server has no choice but to expire that client's courtesy
state immediately. Right?

But maybe that's a side-bar.


> > > But when nfsd4_run_cb_work ran again, it got into the infinite
> > > loop caused by:
> > >       /*
> > >        * XXX: Ideally, we could wait for the client to
> > >        *      reconnect, but I haven't figured out how
> > >        *      to do that yet.
> > >        */
> > >        nfsd4_queue_cb_delayed(cb, 25);
> > > 
> > > which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.
> > The whole paragraph is:
> > 
> > 1503         clnt = clp->cl_cb_client;
> > 1504         if (!clnt) {
> > 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> > 1506                         nfsd41_destroy_cb(cb);
> > 1507                 else {
> > 1508                         /*
> > 1509                          * XXX: Ideally, we could wait for the client to
> > 1510                          *      reconnect, but I haven't figured out how
> > 1511                          *      to do that yet.
> > 1512                          */
> > 1513                         nfsd4_queue_cb_delayed(cb, 25);
> > 1514                 }
> > 1515                 return;
> > 1516         }
> > 
> > When there's no rpc_clnt and CB_KILL is set, the callback
> > operation should be destroyed immediately. CB_KILL is set by
> > nfsd4_shutdown_callback. It's only caller is
> > __destroy_client().
> > 
> > Why isn't NFSD4_CLIENT_CB_KILL set?
> 
> Since __destroy_client was not called, for the reason mentioned above,
> nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL was not
> set.

Well, then I'm missing something. You said, above:

> Currently when a nfs4_client is destroyed we wait for

And __destroy_client() invokes nfsd4_shutdown_callback(). Can you
explain the usage scenario(s) to me again?


> Since the nfsd callback_wq was created with alloc_ordered_workqueue,
> once this loop happens the nfsd callback_wq is stuck since this workqueue
> executes at most one work item at any given time.
> 
> This means that if a nfs client is shutdown and the server is in this
> state then all other clients are effected; all callbacks to other
> clients are stuck in the workqueue. And if a callback for a client is
> stuck in the workqueue then that client can not unmount its shares.
> 
> This is the symptom that was reported recently on this list. I think
> the nfsd callback_wq should be created as a normal workqueue that allows
> multiple work items to be executed at the same time so a problem with
> one client does not effect other clients.

My impression is that the callback_wq is single-threaded to avoid
locking complexity. I'm not yet convinced it would be safe to simply
change that workqueue to permit multiple concurrent work items.

It could be straightforward, however, to move the callback_wq into
struct nfs4_client so that each client can have its own workqueue.
Then we can take some time and design something less brittle and
more scalable (and maybe come up with some test infrastructure so
this stuff doesn't break as often).


-- 
Chuck Lever

