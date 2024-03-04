Return-Path: <linux-nfs+bounces-2187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7A870FB3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C2E280C68
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE011C6AB;
	Mon,  4 Mar 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDrBecic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k8f0gQwl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D297B3C3
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589837; cv=fail; b=NqmDPpXSKkKsd1fW+RG8ZGHyjB3I4qKN0ZK5W0iX3IhjHkCbyXm4zqxdLrKEULBvB03fUllS1hyiVmdd9RTO2dQT7ya1CjTXuZi+eaQpVtekpR+rAI4Vo5HZGX5Jl+WOyVFVlDeKBnRPJ6youdh1JkxZqR4rI5hh+q/EjvMh4mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589837; c=relaxed/simple;
	bh=GgoLy/6vfBCN1oM8JIsIU8tGS3CWtJlD3IY+ggeR3II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=itsdfNEOMO8fs93W9XxVPfSONr1p4lWXqp+pZDWuUS7Tu16vMUzvlpvUKy+mQCCkBzNAelH7BU4kuWnycYBtL0Kr5jjEJmW8/KAv4lzEGlZxNyQOGaDIxzSQZZx8MV4ozv7hJMCzhVLEmVWQ7yy725/R9WcBgF3ASSrJgJD4eww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDrBecic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k8f0gQwl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424IxQra030921;
	Mon, 4 Mar 2024 22:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=uFV9EY3mrem4vHNpfFgLXFQ3qxBIrQfomLddijPnCNM=;
 b=XDrBecic+o9MwgfGHTiEOBmRT4ziCkXuWBxyAnBhDOTKImBRSTLZ3llU9nL85mKuhpZ4
 lPsJ9NZ2AHJ9NrWexU8fbdLPVRQ4AHR242WRDaVHbf579NhMMDGE6lHvMWA/ki5SwmGo
 pg+JdG1LOwASv7nMiV0q6a7sE82da2JjEeHZbmbZ5Y9c/SqBQGvN+DFe6HqQOBBmGAI3
 HeIpdKpWg+7kLWE0MCoU+MmOgmL3eateiQGlulbhkeu5NdDZHlYX99RZoAiEAw5X1Szf
 PYMDjVsToifmuIRklBcnzSQ1c1wT41WT+CLCbjXavccy0S3bempMA26pq2dih7OsGlES Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw44pxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 22:03:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424KjFOW033256;
	Mon, 4 Mar 2024 22:03:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj6wrsw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 22:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWfqGxFPcKeCK1Kz3oYGLZKWCOGMpsiT5hUf/ARH8KobyXCB5mQdbGvIstp2gyjYnPUWUlf1jL4VTRH2DLiMZf+yasWJfOzn6g0UIe+KtqH9soFwSRz1thzM6R8nBogFnbR+nwWZraSo6uuRYP0AxyNH5bi1WmIb/wMF5fF76WNeXCqTGPbipLJiIlonl/fwPVwgFecTKtQrMyQ5o4Bnv51n4a3ngQHHe+G1ppJeLGFRTCuAYebfOaY3jaWSPcDp9lljCHzGMV3xti1pMuOd+VndNN3zWlFcavZDhutWGWDvRZqw1rXHGFPpMJ5PmFjXb41FBJofNX2BEM8Ma2pj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFV9EY3mrem4vHNpfFgLXFQ3qxBIrQfomLddijPnCNM=;
 b=ErStgQYEqdEs0XWkB2GsIheIx6pAmCB7ivqwGk5gWwjB6ZPDsyRF7awEL0bxR4RA1sBqfHoj4X5vVpSxUeQgfWk1cceZEvVRjiviNs3Khy3QblC1F1OLVgNXg/sFIktM/SriV7BXT9VYLITMerpzhDwHO/zMVDC/oZtx3P8wwYkNsHRbANIGlA0437eozquznhPVY+TUXh4U8NfkMoXltm4/yZTOsFM6zhAMoP5BD+Ug24EKTUP9DJ2Z/j969S/a5+WW+6m01ZMNXP5wTWIeUdDRmB/0iO58fJPZnp/cOuXgRn1LQ/K2CRpP0HhisdK3vRtOjFxtVku/TUFhO2bErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFV9EY3mrem4vHNpfFgLXFQ3qxBIrQfomLddijPnCNM=;
 b=k8f0gQwlxmMc82vc3PJRefzGRSh/H4Y81kxUHL9V1u8gcvkO+MtwlZDRX0AvEfW0PTOcKasGpYq9MfLKS56OJ4POvSMq9uIzNqPciCarLU03Dc+TZC5dyupNc3eyNIsOMEO09sSseew051HMMMLixK4Tq7bt1GZUFLbH2VqcNSk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 22:03:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 22:03:15 +0000
Date: Mon, 4 Mar 2024 17:03:05 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
Message-ID: <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>
 <20240304044304.3657-4-neilb@suse.de>
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170958874536.24797.2684794071853900422@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:610:119::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d648c1-36ac-483c-5405-08dc3c96e451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QdWlqctpRUK8Y3OvxS1zgObXajblpsVm3UrGzit8sMbfH8ugrprOXtW2MtNufxfSrRsuz5CpdL88wJz8mXSNW1riRQHIQzWd7F7BkpEsFI/2aAzjfi7wndWD1VPpNnxeCvu6PTpgFGaFyYUgZKOj+iM9c+8/ctgMjqguJufY9slCBjGEAgCAJ33mCvIXcW8orQ0te+woE4eZ/XXIzLESwiLRsEMuEniX6ikr2fJ3SOEVF2qbKisxPg6jvzxet/SP11F5P0xG1iD0Ck7tvPH9hBOEdERwFcgR/oMnx/At8V08Rc0d0gdBEtNdAVr8pzbsQIWNk+iJ9mCVZgbKaEtcRXwO4AeS2FK7sb9Bi3Nc5GJrpvn7xndIzEtegD+jwQOSjVb9EDxE/PJThGohblMHnXTaMs1Npk2mTAk9xWS0cEF77k98U8yT5JR8a3yTq+QB+wcYdOW3MJN8bW5MVcwK+HHAfvUwu7++g0bbomdQ0RGXLQp/qkfhn94EazU2EkSGmuvkh8fNwKNeP1Zq4YjcZZD4Iq4Qx6qHQysCZioI7gJVKluTbtPw5aOcKOxmALdz1yP86ZESaVx8iNrSBeeeyeksJQbpxSPOudVLbjvgSRohiXA3Gyy5aPJr62GF1ga4zcHsw9dk047pPKyFssEevLEMDkPFgWOsywtMvNcEskI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hESgDy4cNCP69vDWxf491V28uEhveEZQTTyTp0++nJd/GMHXQ8fOsOVwJzRK?=
 =?us-ascii?Q?nTngQT/xeiaWOOGHCnoRZZY4XQR9/bY8vyA6glNtzjSecr8ydu+uh89zJD+l?=
 =?us-ascii?Q?Q7P3mdsiqI2cAzdw6Ym/GDzk84IFaObbgPveGL6olfhv1qlsL3szIQlPy0xW?=
 =?us-ascii?Q?XFP/wiw1GcHNkJqAjIRuqNgz2RNQXxamB6O/yz4ihI8Qt8625SnVwLHdtQMf?=
 =?us-ascii?Q?HzwERhv++yAf/rhrirpr1hOZIwC5ydULN7p1jmgrQL57qRqWshrvetKTe6Ub?=
 =?us-ascii?Q?91ECZFTine8lizwhN16gHhRWL9+GZIByd83aA7//q+zI/KK70d0VuuNZlkTN?=
 =?us-ascii?Q?z78ZN7E8gjWIOxwsPeAn5ma4h/9RNZX/Qo3LPaiDk1Y7eX1ULHKsFC3FeDDO?=
 =?us-ascii?Q?2W3exUW3fE8h/uuWZvo9ZS6oxehlHGbER7x4ZnbjIdJPW18Fp/VjJ3NYVX0f?=
 =?us-ascii?Q?SUq0ddju/yH0jENMBhDnOp/JjCexTUqv5SMi3DnmRcCMx/hdYnI8F8yTXiW7?=
 =?us-ascii?Q?L4LhpuF2WRbjngGJen9Z7J0T/OvXZievgeo/9d2alsa0whIOii0QPd5jLHmA?=
 =?us-ascii?Q?ToV3xm5Gj7Nny7AMY4agBmFcOH6F/1S/iPmpf24iH2Pw34b45dvSXGcNUL6l?=
 =?us-ascii?Q?Enw8Swp/+R9QETP5cn3j7G8lD5BOKuGnGezr9y2lSgpEg+wNcU3DHTC1fCMv?=
 =?us-ascii?Q?PenFzBm7kc59wKYC1eRMu/qcxYDbO8lW6nR+XWhhhuxNjAEgzqq49qx4FZPS?=
 =?us-ascii?Q?rSesSwywhVVIqZ8jrgug21Af7OuXLB9uVZmkfAn0iyXqXJZhoFjl5dUrrNFK?=
 =?us-ascii?Q?zcIvz/lbpVPF3Aglss5YmudizZcD3ss4gcTlGW4tuEPkQY5yWmpcsj7ifukH?=
 =?us-ascii?Q?XIOXbsENG2TJ0bI1H3/aYVgmixG/VbRj+H59hro3VMy/XfsJLUZnIMJC/Q3J?=
 =?us-ascii?Q?JOosHtxES2Xzr7+wEjkb76y9TCbodR28OtkfkOQik/PvDmciNzep06Ec/cO3?=
 =?us-ascii?Q?Nz7i5h04GmbsB+nYRpiNdSlEj5EKFQP0xtq8rm1HZlj/EDllxQ0Qrl0u73AV?=
 =?us-ascii?Q?8zKf5IijkPAzvGGpSzOACAaFQ54aXaUe3djfVabz1efhaAdU7MK2sKIltJBd?=
 =?us-ascii?Q?0TjbgeMIeXfm/7b6gM4KC9NHDrMrHg5g/NRHZZpoFVzT7VE8pvC2d06M7SIk?=
 =?us-ascii?Q?RMLX8IBsh++slJAYwlwdp8SoBUPL4i1yaoWlMAuMqy9AAHejdSi9cyEujWPz?=
 =?us-ascii?Q?4cNE2sym9BCbVJQrmETaIU4FZyvXFsne+VbJnEIxAg0A01AxQo9SOPDdqQOY?=
 =?us-ascii?Q?YOk9kOMEzfSe/yNwhJtDJiiztyPzRNB7kk2TbGwlpGuK3U1Uz8XotDmI/X1D?=
 =?us-ascii?Q?RnbUoN0L4vpCDNikVdW1UC8s81E7AiC0Pf70ep0v9DHvx7FDk9FawZ+tMYRh?=
 =?us-ascii?Q?IAsJr9mJr2CYkbhpgPKDg6B06VEo0G5O95b5OWFZcB5g+BcTLp6AZSbxsz2t?=
 =?us-ascii?Q?Lgo0uWyqrdD7eOeTVITRcGOS5yVw9fc0AmddLva2LYKpvwemmw10xKBBjN/z?=
 =?us-ascii?Q?FH44TICm4TB+6g6W1MyFE3j1CTke5M//TCMzb6lzYvGhk83oBKDUWbO0yf1W?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7elnGcK8RZ9+QY838rC0dgmJBuoDq9ySmw2C5bWxEDKtAqaoLWfvK18j/zt/6IZQCGTElcd4Ag1ne5MAo6ruxX9wVbrcobW94FL0uvAkX7tN0ocePejkwcO51ShYtHHSObfidY/dmGkIV7W/YhcaHvkkUSNYeIITigjVpOgLPUdpekiDFsF7FeqAd6ehHWsubJbrmjRx5edzfCYkpx7/TvKELKYuyARlaGApimIEAYBa7l2yTkCpheLjVLmf/bWkz74Li+tR+Fj1V0RiZDvCp2pRRi9Q6oOzgLR4QELLNP1dkq9zCbmpU8soSswW4JiC6kb25//OSJxHDWH4NxVzh06ZyrC0yuAvUPeTvwC/AWb72nEU67dx9OuJE6S/adyvwa89soq2cZv6AhPzBJJfFnrswaJupoAoBFUcECAoR9lmVgdvrWpM6BGI2ZLunhyFwzi5OREsyIKWIGhPggti0GzBKoPWoKb9+X+rOz9We5w39iXd8oNZuO3RUgc47/IgLSyAi472wq5H+UtqrSkUdZMy1zDze9u1j7syDweLanGGphHu7yTgehD9YbMu+51C+ZZ6bEDDER5HBZUwCsDn1NIRZHMw50KSLoziyZhDrhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d648c1-36ac-483c-5405-08dc3c96e451
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:03:15.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vj5yvvtdg46lybzClP3nWZWxrU0RfeqWSH+gJFcqaPwGml6dIoUPM1X0XcRawYqklb7aK7T3Mr9KHnrXGpXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040172
X-Proofpoint-ORIG-GUID: uFDE79WAdOX1WeVgKBHo0ds_ayp9XDBu
X-Proofpoint-GUID: uFDE79WAdOX1WeVgKBHo0ds_ayp9XDBu

On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> On Tue, 05 Mar 2024, Chuck Lever wrote:
> > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > move_to_close_lru() waits for sc_count to become zero while holding
> > > rp_mutex.  This can deadlock if another thread holds a reference and is
> > > waiting for rp_mutex.
> > > 
> > > By the time we get to move_to_close_lru() the openowner is unhashed and
> > > cannot be found any more.  So code waiting for the mutex can safely
> > > retry the lookup if move_to_close_lru() has started.
> > > 
> > > So change rp_mutex to an atomic_t with three states:
> > > 
> > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > >  RP_LOCKED   - state is still hashed, is locked for reply
> > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > 
> > > Use wait_var_event() to wait for either a lock, or for the owner to be
> > > unhashed.  In the latter case, retry the lookup.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> > >  fs/nfsd/state.h     |  2 +-
> > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 690d0e697320..47e879d5d68a 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > >  }
> > >  
> > > +enum rp_lock {
> > > +	RP_UNLOCKED,
> > > +	RP_LOCKED,
> > > +	RP_UNHASHED,
> > > +};
> > > +
> > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > >  {
> > >  	rp->rp_status = nfserr_serverfault;
> > >  	rp->rp_buflen = 0;
> > >  	rp->rp_buf = rp->rp_ibuf;
> > > -	mutex_init(&rp->rp_mutex);
> > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > >  }
> > >  
> > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > -		struct nfs4_stateowner *so)
> > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > +				      struct nfs4_stateowner *so)
> > >  {
> > >  	if (!nfsd4_has_session(cstate)) {
> > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > +		wait_var_event(&so->so_replay.rp_locked,
> > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > +					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
> > 
> > What reliably prevents this from being a "wait forever" ?
> 
> That same thing that reliably prevented the original mutex_lock from
> waiting forever.
> It waits until rp_locked is set to RP_UNLOCKED, which is precisely when
> we previously called mutex_unlock.  But it *also* aborts the wait if
> rp_locked is set to RP_UNHASHED - so it is now more reliable.
> 
> Does that answer the question?

Hm. I guess then we are no worse off with wait_var_event().

I'm not as familiar with this logic as perhaps I should be. How long
does it take for the wake-up to occur, typically?


> > > +		if (atomic_read(&so->so_replay.rp_locked) == RP_UNHASHED)
> > > +			return -EAGAIN;
> > >  		cstate->replay_owner = nfs4_get_stateowner(so);
> > >  	}
> > > +	return 0;
> > >  }
> > >  
> > >  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> > > @@ -4453,7 +4464,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> > >  
> > >  	if (so != NULL) {
> > >  		cstate->replay_owner = NULL;
> > > -		mutex_unlock(&so->so_replay.rp_mutex);
> > > +		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> > > +		wake_up_var(&so->so_replay.rp_locked);
> > >  		nfs4_put_stateowner(so);
> > >  	}
> > >  }
> > > @@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
> > >  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
> > >  	 * there should be no danger of the refcount going back up again at
> > >  	 * this point.
> > > +	 * Some threads with a reference might be waiting for rp_locked,
> > > +	 * so tell them to stop waiting.
> > >  	 */
> > > +	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> > > +	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
> > >  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
> > >  
> > >  	release_all_access(s);
> > > @@ -5064,11 +5080,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
> > >  	clp = cstate->clp;
> > >  
> > >  	strhashval = ownerstr_hashval(&open->op_owner);
> > > +retry:
> > >  	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
> > >  	open->op_openowner = oo;
> > >  	if (!oo)
> > >  		return nfserr_jukebox;
> > > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > > +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) == -EAGAIN) {
> > > +		nfs4_put_stateowner(&oo->oo_owner);
> > > +		goto retry;
> > > +	}
> > >  	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> > >  	if (status)
> > >  		return status;
> > > @@ -6828,11 +6848,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> > >  	trace_nfsd_preprocess(seqid, stateid);
> > >  
> > >  	*stpp = NULL;
> > > +retry:
> > >  	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> > >  	if (status)
> > >  		return status;
> > >  	stp = openlockstateid(s);
> > > -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> > > +	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) == -EAGAIN) {
> > > +		nfs4_put_stateowner(stp->st_stateowner);
> > > +		goto retry;
> > > +	}
> > >  
> > >  	status = nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
> > >  	if (!status)
> > 
> > My tool chain reports that this hunk won't apply to nfsd-next.
> 
> You need better tools :-)

<shrug> Essentially it is git, importing an mbox. That kind of thing
is generally the weakest aspect of all these tools.  Do you know of
something more robust?


> > In my copy of fs/nfsd/nfs4state.c, nfs4_preprocess_seqid_op() starts
> > at line 7180, so something is whack-a-doodle.
> 
> I have been working against master because the old version of the fix
> was in nfsd-next.  I should have rebased when you removed it from
> nfsd-next.  I have now and will repost once you confirm you are
> comfortable with the answer about waiting above.  Would adding a comment
> there help?

The mechanism is clear from the code, so a new comment, if you add
one, should spell out what condition(s) mark rp_locked as UNLOCKED.

But I might be missing something that should be obvious, in which
case no comment is necessary.


> Thanks,
> NeilBrown
> 
> 
> > 
> > 
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index 41bdc913fa71..6a3becd86112 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -446,7 +446,7 @@ struct nfs4_replay {
> > >  	unsigned int		rp_buflen;
> > >  	char			*rp_buf;
> > >  	struct knfsd_fh		rp_openfh;
> > > -	struct mutex		rp_mutex;
> > > +	atomic_t		rp_locked;
> > >  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
> > >  };
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever

