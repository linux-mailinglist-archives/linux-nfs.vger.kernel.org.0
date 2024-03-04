Return-Path: <linux-nfs+bounces-2199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244BA87110C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F67CB21D9B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F987D08F;
	Mon,  4 Mar 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NMxTRaYp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oyDhFKh3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B477CF2B
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595073; cv=fail; b=FTP50Jeb0bMeQzIApiKgmACZf1tg6Ky1gCZLmF3uTK0B7ydgbD0aG2EB1U/OVWfGO27C6IK+hUTu2w1b5cBB6ba2Hu9wICqNOLaNKG0ATxSWtPotcFTXyEevV9xCrMzjifxc/ajpQgY5jgttAouA1q8OYpDJTtUkSo+iFaEuV6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595073; c=relaxed/simple;
	bh=3yNAgOZead1CgnPcvYZBIz5+uFrEikX6MdUD+ZHaoUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnSD3Pi4qazxsn0afGy0bzhCBnGIsNWYb0oSEZAYC1Hb1AK3H+A8FkOOdGXSjYRnKVgaqX+919WRsiJHWFsSHO43ncfASLNXQ1TzQXAsdN8dc4sflzn3JgD3oOhiXe8o8sKHGr4O4wqX5gL1KNJlXFwnJEauNLg2Xiopaqew0G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NMxTRaYp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oyDhFKh3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424IxNIx031724;
	Mon, 4 Mar 2024 23:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=1R77sE3Jv6sMnwCb22FpUZeYKvI6kkQtD3yiPrYhXLI=;
 b=NMxTRaYpxSlferKgeyhxRbL29n+tRP7/VJcwZJS1KBDUr1OPeLuP3IifvytLU7rfrGMC
 cd9IlyPl8XMrzxSFe9BkzpCM3HoPcWXl7JV106FDfPMf3efjbw8niBFdXN6W9NC/OuVw
 IRGDlOeWKF/4XUl8A7074JN+9GJTr2Iq58GsWdbvSSxYmOBQEVE+6ouWElVmWruAQAN+
 crWTQ+9p32ZQWVeOzqViRJAN+5hxmHCLgk7b0yCYWq8fIzxLcPt7txPaqNEBBUlTe7NS
 6To/oq2WC1ADHQA6sduISqbLiOm76ynXbS8dPVGXLIkEn2l5II6iwUy3YncrkfV3qMvt BA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthed0th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 23:31:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424MwCAN017048;
	Mon, 4 Mar 2024 23:30:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj6kjba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 23:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki7VRXsEkEaXPSm6tBU66MCLQpSk33mzrvC3CGAbqyeq0MrLogdTjyIGVVofZEzwa00HLssNRwgRb/9B/6HAmy5peqgZ5chqJ7agINP11ipFxhUG5emTGPxVNShNDydhe5JQsJOGLyxapSAJkMxyn1NYYPfAmYDMAeyHlHYo8Uk0dFGMRwobmWG/6bV5JHgFOnaVIm2LiFRlmwvwbnT0b5f6IRVmo5046yFfxp+FGoxwkjQR7P4eOSxrLQagHIxiSt1H6Or804RSk1ELpOt/uDE0RO6Mt1PnF0xR3f4aaHcaHFs60+bD6YYFD8JJVlT0cAVm70FegaRLPYp/RghhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R77sE3Jv6sMnwCb22FpUZeYKvI6kkQtD3yiPrYhXLI=;
 b=Nyu2NxRqSyNDVgxytNuKEQzpFKC6tuWfVH5TmiS1liEv1I04TwGWwL3IGJeYmRj/KK2z+jA7Wu5Sf6RKF3ay46i8ivfy9L03tDgmZMe9pDRGI1phgWydQFhJLC/UZdfzYZG+dt7u2byHVAoGBylQxAqpzF6Dp/ahRuzFQ8k/QQ8hICH3+RRHEo4R89wHnMb9GtVT3P1Lq1P6GOtk/+ddAKOUlRXvYFwIjbxGVVrZNv8vSJ0OMyMhP96nuq/EBMupexnstTYlb254CA6FklervFeNL44fN5hD5SGzaPo/fwRQIrpp1kVzaeGBtTY1QmP6RcJQeREBtHTcpGml7Q7VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R77sE3Jv6sMnwCb22FpUZeYKvI6kkQtD3yiPrYhXLI=;
 b=oyDhFKh3zMA4NH5hhE25iuNjPha0SaG8ViqjS9GUxPZePOWLagP0R9ZGsqLQ5VBu3Rz9b/mvYNlHWl0GL7IOKnpVWP6pq7HLm41JdDgXL6RO32CLXRC87Uz8WQ88rBL8bT6dst+tEesgXhpy0g+kJW0vnUz/FHsNr8KuCKPCgOQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 23:30:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 23:30:57 +0000
Date: Mon, 4 Mar 2024 18:30:54 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
Message-ID: <ZeZZru5hL_77IRP_@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>
 <20240304044304.3657-4-neilb@suse.de>
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>
 <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>
 <170959178935.24797.7531672348129457687@noble.neil.brown.name>
 <ZeZRC21DdOkuKroo@manet.1015granger.net>
 <477e896777379d9b060a735a3873e2ea3096f76f.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477e896777379d9b060a735a3873e2ea3096f76f.camel@kernel.org>
X-ClientProxiedBy: CH2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:610:58::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eef044-e3d4-438b-c764-08dc3ca324d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bXzMUOVlRVOfl9htpoboOnKgAKVLVsGMTq2UVRKvm4xWMfWIoKZqRB86IpTNZr0KfUD2NOkcw35XxgQjB90vrlSJGEoA0Kn9P80GtEPt/x9nbvSPsLo0GKTKBZP7GT154FBokoRZRH9dVze4w1C03VYxh8C+P90vrbWkzBCiBx7p+cjDOwgSDHCbwxON3TLYi1Ux9VVqYKp91L0SDlVPnaOSUjzri1fhRoCL/oNfeUj7Tj0tfGtjwwL4e0gjlZvH2C6+BJ4SIjR4RM/k3pGev7/4F6zjN9VX5qqbrJCaac6THLPCs2lqy5uco4QGDtmEDwSL9sDnbJ0yZDr4Dh0+UuFPGAR/L3qi8bsJ9yv5UaJ8RUMaYTvhAitsOLzyuA39p48Icjf+j5NMjOjPPBLo87S0fDi7EKB/OfPQQv3q2g/eF4i1TRoWk2L4P4dnzZHZ32FwBzw9/ipnFrylHUty8fqY+tpqzOB9T7srQrIfhVtmRewyLbgT7Imoei+Xv8o8FcrCQeV0wEVnOszm9OpsxYqh+pzRcbMSHkyHPY1ZhKoiB5WI0+ymg2hLRG2mZyuKi6NsLzwaOynArqG9wJoYnhBnGU8R2Z4N8Ycbi7YoXM149qmkrng3X6tmw4jXbAGdrZxNNseIPTQpMPK1uKI7LOLjzFPeh9AT74ydoSr2SgI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FHA8oyuzEHzKuhDBj5JboMHekGZeu9XMJpcuKgmUW7VvdHZiHLp1Yzasjxii?=
 =?us-ascii?Q?p9Cox/qE+6qGHmcDSinseVDSfWc0IYEvHsGleJABSdvRNZ0Myn1vcA6txTvn?=
 =?us-ascii?Q?smVqr4+0mqfian1454k/sOJ1D1+zsU6Z05QE7AcIR4DqoDq+VIFN+EqJJ4kn?=
 =?us-ascii?Q?CpUOAvhMkW9LLWwUzYim4aliQCdD+Z40X/gPSuIm0maG1fqdIQzEdR6E0oCM?=
 =?us-ascii?Q?JIFRB5sLCuQzIT8oIWgv9XoATTnCxaL3SuLLfRAhxlXUeSEcNiJGTNFrptML?=
 =?us-ascii?Q?xzqYNA5eGt1LhRHjlYBe6Dlfm3TNoL2J2MVppRdwcHtnGuSz5XMBxSrxmOL1?=
 =?us-ascii?Q?9nE0Zdz/yOjZAJmC0GSO30yDNiB59csB7ok8e2A7j9zXeQQIRV6jzlgxxXcI?=
 =?us-ascii?Q?SqkSZqa9r4Q17UlFRWuilTZV/XprxUMJOVOS/riXZmxeEczrKYl2hQR84pJA?=
 =?us-ascii?Q?5Mwac5ip4bdCDE433eu5c00svxVVxWyYguSHRAwbBt3wk+o4SEwiYzzdT0Wl?=
 =?us-ascii?Q?guu9xwIjLAlo2b3Hfs0owv3JFizhCm3pdjR3WFJtSg2v+Z7msQbtWJL7gkXY?=
 =?us-ascii?Q?DwnCk5WVHmgISy8Yt8hqVH1pO/z9B6sBu+YDf1GKpnjmnKpFCtfGyJXJFV4G?=
 =?us-ascii?Q?jpBQm44ILB++Sl+sI4KdFM9eS2CdPFxoHTzTbQWVsqAxL7Zgm2MSOtlVXNMX?=
 =?us-ascii?Q?25oSXT0eNQ7tLuTsfvyBDt0AhG+FKfcZEXSheyl+/dutf+aM7gzjrZabzdCV?=
 =?us-ascii?Q?pJ20Zf+KZJQkB3ptJ5XTvkd2gBtoiko2f3WUbo+mRkAuKKx8yw4VjIzgA07C?=
 =?us-ascii?Q?IqrcJ8HHJXBWJ3AWgLdZevwvuQLkcNihB4SysCj5uBRinmEYtUXSSpsg8cwk?=
 =?us-ascii?Q?Lo5KEgp0V1sVWiEhAd/5LnBL1+WAJ3Ah358O8+lfe6vVHZ0Fqwye+ZBToBjQ?=
 =?us-ascii?Q?Xlp/pg27YSKt4rQP7s8DcwEl/afZe4xn2ocbDNL1+nn8Q6QJ7aB+c/Lwf7RY?=
 =?us-ascii?Q?gvqUwbKKvkT/ISC1oempdynD7ZAE4/FpN0uCtH7EnRJW27WF/kM3D3EjfdGM?=
 =?us-ascii?Q?PSLRnNwKZKJKGfsCuowcsDTwBseIndMz45diJfR1HHhpDdM8BFOjWteZn0QJ?=
 =?us-ascii?Q?RSFtGjfh6oGAmpVfx/MCkVJ0/RoPMxKkjmQkOS6ZJzPg2t8XjAzHvW5ZfusD?=
 =?us-ascii?Q?PmTTKK2+OEyABKpOm/54Hlg24i5tPSlA+h5IgdrptJK0XbpBAmAS5kWdhorB?=
 =?us-ascii?Q?jYbTtuut2hNelfjLejiSzAY5hZ9abWv8KBhwPot1tFfGGVJKSd1J1HHaZ9xJ?=
 =?us-ascii?Q?FwS1Uz7gQnRY+aSl//+DEMUUIB2vQNIR8+mFDTkeA9+b2GA2ulgse89eg3F+?=
 =?us-ascii?Q?4nt9hlIezWUZsT4x5jLfqbj9Je+MOezu3X7hJsmzAR6METx10u+2PMZABg4Z?=
 =?us-ascii?Q?ud70ZiyhKkHiabGT4RwBWOI3yJ8GCLoubzWNwr3vN/j21EOHDxyP5YzIAPSU?=
 =?us-ascii?Q?AF3J/BkRyJUjY0xl1iyuzLY0huddcXWzlWnGoBaxi0Ian/U9M9dPkHbq2AHZ?=
 =?us-ascii?Q?eMVZILLRFl0FkxULrrMVvixTVDX+pz+dQEy1NwacWQRceRRHDRm0o7onjtAN?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nmpd9Jpkub6mto+vH/7x3vzCHoJyv+8dfVVSjwOqsJ6orGaLlIez2saGJmG/qp967O709BgKy7UNlNp8unXD8ZGHh0TSyBwfOHQ8+7vdETWj0f4cxc9CXIPz9LB+Q0dFiSIYwZ1Gfr1ZY2thjB212oia3xD99DUow30sMu4p//ZI75jjuqpc4j7A3FWId9Cjg3M/mHKSaIAMUNrnWZxsfWHrvftIsY0mD+Cnu1+4WhtFNnMT51avXKMTp1HuDfIYgZndoH88+WT0N/YvTKCMu+Fd3RvdkhAahwLD4fOZTo2Iz/iuU0vti7l3gar3Xgy9zNYdW8/V6C5s76BQGElM2av0rBof+nzwqbzEjyXxyQ/dvcCksmf0cLdqRRzD9UdCR2ZJZMv5V+CO1sz6TXJMGcbdmLUlvF8pmbo+ETYgXMsXI83ZxxJK+cyEfoDc332Gfd30/Z1nRM+sONwKckxXXUELCIFljlKMrxUvPMkmmaTAjn0UP0iF4XFak2K8jUf9U1UBzuxvq2Ovsu1LM+0zen1nx/ed/tE1o/ArRnjqFSWlnKy1cE7H9S5PsHyZViyTQMqMQF/6ISoXl2/pje7OtFiR8PJ36FgmRWA97Ga1dhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eef044-e3d4-438b-c764-08dc3ca324d7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:30:57.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltm9sJifQ5Cs2//bwj+4s2fr2yy/cF26SIEms1juWHihSglBVGtaK5y7+GRravpagsClSPTIcQoQydTCjMLYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040181
X-Proofpoint-ORIG-GUID: Y2r5fXhI3D_tf74ZDYDTAdIdjvjDMceU
X-Proofpoint-GUID: Y2r5fXhI3D_tf74ZDYDTAdIdjvjDMceU

On Mon, Mar 04, 2024 at 06:11:24PM -0500, Jeff Layton wrote:
> On Mon, 2024-03-04 at 17:54 -0500, Chuck Lever wrote:
> > On Tue, Mar 05, 2024 at 09:36:29AM +1100, NeilBrown wrote:
> > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> > > > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > > > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > > > > > move_to_close_lru() waits for sc_count to become zero while holding
> > > > > > > rp_mutex.  This can deadlock if another thread holds a reference and is
> > > > > > > waiting for rp_mutex.
> > > > > > > 
> > > > > > > By the time we get to move_to_close_lru() the openowner is unhashed and
> > > > > > > cannot be found any more.  So code waiting for the mutex can safely
> > > > > > > retry the lookup if move_to_close_lru() has started.
> > > > > > > 
> > > > > > > So change rp_mutex to an atomic_t with three states:
> > > > > > > 
> > > > > > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > > > > > >  RP_LOCKED   - state is still hashed, is locked for reply
> > > > > > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > > > > > 
> > > > > > > Use wait_var_event() to wait for either a lock, or for the owner to be
> > > > > > > unhashed.  In the latter case, retry the lookup.
> > > > > > > 
> > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > > ---
> > > > > > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> > > > > > >  fs/nfsd/state.h     |  2 +-
> > > > > > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > index 690d0e697320..47e879d5d68a 100644
> > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > > > > > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > > > > > >  }
> > > > > > >  
> > > > > > > +enum rp_lock {
> > > > > > > +	RP_UNLOCKED,
> > > > > > > +	RP_LOCKED,
> > > > > > > +	RP_UNHASHED,
> > > > > > > +};
> > > > > > > +
> > > > > > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > > > > > >  {
> > > > > > >  	rp->rp_status = nfserr_serverfault;
> > > > > > >  	rp->rp_buflen = 0;
> > > > > > >  	rp->rp_buf = rp->rp_ibuf;
> > > > > > > -	mutex_init(&rp->rp_mutex);
> > > > > > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > > > > > >  }
> > > > > > >  
> > > > > > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > > > > > -		struct nfs4_stateowner *so)
> > > > > > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > > > > > +				      struct nfs4_stateowner *so)
> > > > > > >  {
> > > > > > >  	if (!nfsd4_has_session(cstate)) {
> > > > > > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > > > > > +		wait_var_event(&so->so_replay.rp_locked,
> > > > > > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > > > > > +					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
> > > > > > 
> > > > > > What reliably prevents this from being a "wait forever" ?
> > > > > 
> > > > > That same thing that reliably prevented the original mutex_lock from
> > > > > waiting forever.

Note that this patch fixes a deadlock here. So clearly, there /were/
situations where "waiting forever" was possible with the mutex version
of this code.


> > > > > It waits until rp_locked is set to RP_UNLOCKED, which is precisely when
> > > > > we previously called mutex_unlock.  But it *also* aborts the wait if
> > > > > rp_locked is set to RP_UNHASHED - so it is now more reliable.
> > > > > 
> > > > > Does that answer the question?
> > > > 
> > > > Hm. I guess then we are no worse off with wait_var_event().
> > > > 
> > > > I'm not as familiar with this logic as perhaps I should be. How long
> > > > does it take for the wake-up to occur, typically?
> > > 
> > > wait_var_event() is paired with wake_up_var().
> > > The wake up happens when wake_up_var() is called, which in this code is
> > > always immediately after atomic_set() updates the variable.
> > 
> > I'm trying to ascertain the actual wall-clock time that the nfsd thread
> > is sleeping, at most. Is this going to be a possible DoS vector? Can
> > it impact the ability for the server to shut down without hanging?
> 
> Prior to this patch, there was a mutex in play here and we just released
> it to wake up the waiters. This is more or less doing the same thing, it
> just indicates the resulting state better.

Well, it adds a third state so that a recovery action can be taken
on wake-up in some cases. That avoids a deadlock, so this does count
as a bug fix.


> I doubt this will materially change how long the tasks are waiting.

It might not be a longer wait, but it still seems difficult to prove
that the wait_var_event() will /always/ be awoken somehow.

Applying for now.


-- 
Chuck Lever

