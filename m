Return-Path: <linux-nfs+bounces-4150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5E91086E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A631C2248F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3921AD3F5;
	Thu, 20 Jun 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCL7/ZML";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aS6kgv7z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D651ABCD3
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893865; cv=fail; b=KXS4FLQu7t6mQ9GXsNn+5OSsf5mGtWRztbwWMZeHQvBAOfXx8ENnl2EPEcIImGofH0F/UiWjbun4/BniVgjTkf8NoYQyE6Yo6uBJphRaj+bp1sM2eTDxR44ryOL1nmleYQASHekXZp1Nrw/+soY0nf9Wc+FDVuCygvrzYHf31+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893865; c=relaxed/simple;
	bh=xbGMPhytQ6/lcmCuEQKy5uxTVmw+iUgwoNrYG95A7yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbL6ZhBgYSG8PRH/87grxYgLVpkArHRjy6Lv40P1A94G1uUVas4gdEPCwas4ggpdgfe8WatmR1IYTOzAoCJWd2BNtBZ+mWKkv47dEbAOLj3UAa0jRy2Xk5zjb/mP6iLv7a4B7gWEMg0Dtpv5zlo7k2YH6rPrkrLjqk8crwCyo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iCL7/ZML; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aS6kgv7z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEG5BG025969;
	Thu, 20 Jun 2024 14:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=9DID6bk1/4ItTPp
	VLPDvVuNI4fXwy+1YaMl0M2S3Kks=; b=iCL7/ZMLVIiCcowUwn+zP4jrxhaU2K0
	hF0nMB8bYr0WuLsLUO4WIx4twF7HpHsUltlBBWb5+YoMGhXFBfUfN6vT8oBEFneO
	8PeRW7B6FHz1Id4pf1VNX5aifnocGjYwTXuqHkac7CmNOAPBYd00DV4Ii6zUqyqI
	b1PSPxOQhN/oBkg5qUsRhfliYsfZsKD61HBswnZp4vyLXXPhOFaE4CB8qkVAMl7r
	zzLhJZrTzeMYHWo0SIxgTXUmlt7P6lOvnZOJEjh9fyb3NJ6mb3KBkcjlUy9jcHsT
	I8ievPFvtkUIcjEwqs3Ke82pj5HaR2svTg/m2wg56Hklp11Khkgb3ZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja03ar6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:30:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDtf0p034503;
	Thu, 20 Jun 2024 14:30:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh4a13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsFx8B8BHVa0ZYR+FWUvojCbILV3u8/3eCd27qeyoz4+8Ldp0rLRZhafgxvuOb71Rnacxs+YoZjSn5cSoWSqZ+KVK2WIBJ5alSXllOWq0IDUFh8iUJP3CW9mWQz487+NdUYbKHKyBPdKPBWJ+vnFo0Ghg4czew8/JFgGi42ynxFd3CLp/KgTlkGQ6RnRJ0m62c0wfsA432gn6SHrvDQi4+1rs/qDuu0xKYm5L0P8WETKJTIQ9cLtjfVFokc+SfjZtRTDn1GJWqnSL+vHT+u2++vf4Z9HMYC09P7LdELxgy1iezkwVwDZzcc8ofMeQTfl8uFIewzqnvWNBxCesDK+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DID6bk1/4ItTPpVLPDvVuNI4fXwy+1YaMl0M2S3Kks=;
 b=Ncf1mY1QCWz7KoWoFVCTaPfB2+vXeOQ2NP+km0GM8b8k4ee057+tZVd18oi3wo4SYt7kXPDQixkEBGDqcXbaTyl2VojG+D/ZO1fS0bxStYtapBLxl9ocaquACUxlvkbQIhO70eesnhfApy1kvE52AH0CimZDsIZBXT+UDYgBl8smUiXQNpDBOgfalpBQoEG681AVaXYKBYkQIM0Y2JXwbzpvfnsZAZwTZcsckIwwShJhS5XOHQK9VoxEP/lab703kAnJwLmocSVEh/NKFrelpZaPgVuUsNXy4bOF+oqkx2ZonaXpjzdJazmPtPDVyTB3E0Ei63kp+w+bw0A3T+kp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DID6bk1/4ItTPpVLPDvVuNI4fXwy+1YaMl0M2S3Kks=;
 b=aS6kgv7zXa5SlFM0Ri4kUbAXUuHPNOEdPpwTKzvmy02xQaRSml3sblW6lclqeWiI4lSImp4X2xhjm2GIIZjgpiFlLDYGa4hoZAPkXCWLgJ78tJ14nwk86ov+s8hUFAGq2cdFvCr5ZycHxddjFmXk+LYBBDI0c4QszEVj0l5lcsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 14:30:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:30:48 +0000
Date: Thu, 20 Jun 2024 10:30:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] nfs/blocklayout: SCSI layout trace points for
 reservation key reg/unreg
Message-ID: <ZnQ9FOyCB4SsHweX@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-7-cel@kernel.org>
 <20240620045046.GC19613@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620045046.GC19613@lst.de>
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 450d721e-3699-47e2-1d03-08dc9135940f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9wEqEBJ+Sicoy1j86k8/Wx4AUVDtkue1CkdEITD0DdrixDESu7HODkGW/Iqo?=
 =?us-ascii?Q?EmJfKqJfcIR5Ix+3hRlNSZTKD3uSTgAPShj/py4/Dqi87eE6brWXFG0FMg/W?=
 =?us-ascii?Q?R3GQudGNDJwU3iLrGT4IoqxZ+cC/wBXDxPhawzDnudFefYJDF2rvdL0Bf/m9?=
 =?us-ascii?Q?iAd5RnsGRZHd1x2bZaCCActFEPHrqO2VvY2x6dMiizDQHG0udOzi97T46pTe?=
 =?us-ascii?Q?d4QXpEcJeR4zRsJtf1umumKmjh/i0g6HAnBbkaPJXo1RRXfZRq/5+j2f/LIl?=
 =?us-ascii?Q?skch5Z3Ki8GsalkTJPp1ZiWWHGBl4af/Qnnb/w2uy6tzEKIwgL215o/gF6uP?=
 =?us-ascii?Q?oiWdO1/pFfywsxdYEu/vAUv2Z3e43ikqkv1uhjnlehh6l/eNWfhMc23aARnn?=
 =?us-ascii?Q?CntG0YOpuhwFeNl5ZY1G8w4Q+Gqxfg6mGIREtI4F1pxUPif8RM1uKZuqomDM?=
 =?us-ascii?Q?rE/zf28RXgpewJ+KTxmimVtjm5NmZJQuWHBb52ZRulobOE0ZFr95GYzHup0I?=
 =?us-ascii?Q?Fxx6CS4HaFccfmzJaZFW73ROciHx1MAa/HmUcl7reLDdcNb8mzXcFXO0sJWn?=
 =?us-ascii?Q?1W9ZDtWEKyw4vJOUWaQmFoMaWO334XrZWWbrhNoLqxT/Aj8wIcZPR62R81kR?=
 =?us-ascii?Q?ff1WkuaU8J4aUZh1rTAt+xku9FLesd5x1p6NAmCO0xRM1FYe+UvzN+zAgwgu?=
 =?us-ascii?Q?5OoEq2tmmsv2HsWamAGkXzBGKUD+rVTmM/xz3aElV4eaU2DjZMGHwNGHUqFZ?=
 =?us-ascii?Q?mqsE5Se2eZCGWLkRIMs8/bsBOPMJhcVKoVMsyUCCAVEVINIJCodiGuf9/s7Q?=
 =?us-ascii?Q?jZiDBLXNLKUoU9NSh5eq6FcAO+fQgK9oq/8F07qYxvZSsxWqcfvhCTLcQkQB?=
 =?us-ascii?Q?WcMX4OxSGWYNCKEXesxpgGKTiYSUXnfGtnzjU/UeG0AVhca/qZeaQAMqtEsp?=
 =?us-ascii?Q?OJRSRX1RxOrcwXyuvwBq9toQ48d6yBhE6YgM9ndxLNrljbxFVRlroxPuyum0?=
 =?us-ascii?Q?yAAM7HXn7vtZOvZX/Mmy4BwZddZvLcjCmsC7KO64qmV19QvUBLDVZpPHebTv?=
 =?us-ascii?Q?XWmrSzchHrTPrkyBy5mCYxel2ghahdlYd0REJ9V8C1Af8GVR/SGmiHLYRNxD?=
 =?us-ascii?Q?fXJvU0wIc+4VlmaxvtAPa3UBxviNmMTaTLJXBvKgo8++kUMadomTRL/CHyRr?=
 =?us-ascii?Q?XxzRID+S4+64bFyF17Aj6NHsITz0xlqXYiFUN1+qd9dRMdgzHw7o4yOkR3jx?=
 =?us-ascii?Q?HM7oeVZDnB6lyEzVMcg/cZqFsx5TciY9I3I3N/LXh6Ls77RByg7jeJGnXMoE?=
 =?us-ascii?Q?LI4Aa80CGi+uawkb9rqNIm5B?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CZnaY2c2C77LyOrA4eODgoxpnVpfSZoglebrgs1lhRGb5ZBCL7GsIYn5zXo4?=
 =?us-ascii?Q?1xG7Tl8K/3MPPSBNNpzVAjCybxNvC1WcnV1cbr7NRNVzLyqggAdfb0HYqM+g?=
 =?us-ascii?Q?fsCIt4tJNoBgMtfh/WFBR4H04VzRGpQdS/zW2Xrj6Q46dlkvVn2dDZ+cVLem?=
 =?us-ascii?Q?ix2VGfCf67TgV4O6RePtGhQprIp7+wVnXunXXJNZ9EhPGlAe4+bQzCgywgMl?=
 =?us-ascii?Q?0X+bQywGuYz2blhxLJvsn6doU5U3xIdFZg0wgiW/5xG57Ab9d26VEj7OnHj0?=
 =?us-ascii?Q?C2o2hgs1ZAj0bDEh8E2VRr3A+9b0um4m7JF1CarwSOBA7p3ftEAsvxyOUDle?=
 =?us-ascii?Q?JQvZzXzjjzq3nkN2fgHyKBOPjbHpb5xKz6xDMYyKkHLcwMujKYpOkacnj3UL?=
 =?us-ascii?Q?eZsGSUffo2/J3YYb/C9UWhUTApQs+EQFFJKX78Bm+ik2XWil4m/ItX3d4PWS?=
 =?us-ascii?Q?eggeu3Y/oMLUdIgWk2I46LPFdM25+NnvhsIEhRxlNAyTPUtYgcdWLwQgYv1k?=
 =?us-ascii?Q?smz0zeXy69uAMSrSb4Tq1M70oaIDaxfucVJHdZeM7HEjgxAyCzdHqaawpGPc?=
 =?us-ascii?Q?oP0Q/iB8sq9FbaBQj4HQdaYJ0v8aGMDBY7wpvuhwZ3FIhkHJpw/Ts6a6tamc?=
 =?us-ascii?Q?KIwIgbpZdgmX93cuMPt4obLxHIoS030wNmxqymR0v9EFra79TLBmHPu0vknb?=
 =?us-ascii?Q?1TjMsL+ku9Pw7kQemf6uJSyXGu/bIIWhumwdU+ONoYI3Uy+HqtUI+XWqChrv?=
 =?us-ascii?Q?lTRNWAppE7ELGWt1inHEChGMM7OFoT8PGoL0lhQMM+ZTEv6lR/NYraqUAYk2?=
 =?us-ascii?Q?Tm5zmY2TK9DclQiwjERweQaA2EkmsGaO7Av3tqWY4W39SvLNXvHOCS+CRU/A?=
 =?us-ascii?Q?sR+TRw/Jzp4M9QwRWx8IG+DEyPcEvnmzOc/GiuS8Ic6K1OWW/syKEfvOiDwT?=
 =?us-ascii?Q?VZEcKsbYQhJcpDH8pjg7dF90wmxWyimjP9EumjxLbs0ShfrthcBPTcI9AesC?=
 =?us-ascii?Q?mTwWOjHsVFf2aix1AHgcKaN6yb11f0XSmphOmfhpzp/WqnL2sf033nWLp27S?=
 =?us-ascii?Q?+dXds94IbkNWgsN4Mf9fNV9fbQ4/4vNtmv1LiqcMHQcV+rLdflWM6NXxJbVz?=
 =?us-ascii?Q?rIdZIwhfzAS+sEpERn7oFSUakFTL+rV12X0n76XoFbQKiLw6XGxzCBbPkz6k?=
 =?us-ascii?Q?QJT65yht5MQas/H+/NwPjkPDqFqo3q52bODg30a0srZasfgIfzjPWAd07xcW?=
 =?us-ascii?Q?nPBkh/8IgKKTot/YBTbtGbk7QG74oBZjDRrBsssq1ZUTJNa5k3+fCGT+o5fE?=
 =?us-ascii?Q?v+1+PnZTSWmoKipUL0VQN3dtL6q6sQKk9mLcZaanrIQZEKAmMxt0HJLFj4yG?=
 =?us-ascii?Q?gVXsFGYq5zWrW5xVwVGIeUI3nEjrzaDqBFTyPEd+StkbK5s2XMC88akouzqt?=
 =?us-ascii?Q?GF9xZow1oiB3ks5IfZMGOuYKl898Pz7QSG443HeLZLGSAhoZE028hbvPcH/X?=
 =?us-ascii?Q?AhMPi3bkOlF2Y4a3a65KnqKR0ahyb5isA3fdDKx3xpUgajyHQOrI1fXUNMXt?=
 =?us-ascii?Q?WXniV8tP9vovvQp4AoP7A75OsiEHo0bVmQb/sqBB6R5rwcOF/s0prudFaZRX?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7VlW5azhnGYFAcHbG97mHmZF5dmao+AWQqo3sPykOWtCowVQ8my92B25DJMdaFTpjg0mOnhVuqrSU0xJVUJgxizqX2Yk6iqb/fVhpk6kMSDHI7flEa6HYvTWnkSz0+py9FzwleBjvkpUW5ALlfuu7pi8SsQWCbn6wE1MXIbNaiHTZ/GohmD11yERDqKII0K5sXh9dlVsOOE7y6tST54hEbapUq1ytktNe1u7WqEAywv6vsmzCpCYQvevsSYzwUBXuYFDsHaso/9unzlaOPaoGMk3av+Zw/xPD5OVjlUzGRVVu/uHXS2DK3h6CmLG5rUktHT10skHhlruJD80ihxxp1uvXkkcjyTQGNmAEj4HkUj4d0NCmz08fJwnC0UYEiwfNpSaq0WpnoJt+8hlgUXEgbBVqllTDFmn6HxAAT/w2itpx9Aw1DHRhm2Fsl0ts/o+oNUL5NoK/BzfPAyNJouGBoXq2aEoX3Nz6OAyagZG07oappfwQLvAc9pCFwzVWkI2j6KqKw431NvjI6ltkn4ahLvGfZmB7ZHfqP6zDQybKe7hB70RkL+uX7gwrWiGNhITn2RiWXArtVI1E1olbcqfOIurGrn5Rjg0rSMq1p+6osY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450d721e-3699-47e2-1d03-08dc9135940f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:30:48.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAQxsPG3EHJyWbOKow0r9NILZKRnzb2M9L8TmwEaljKn5U1Nonmsn+WCUf6PBFCDepwQ197auMOIlVg8wTk7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200104
X-Proofpoint-ORIG-GUID: 3le342KF_HxNdGbQlP_Gr_XZG8JaPv8L
X-Proofpoint-GUID: 3le342KF_HxNdGbQlP_Gr_XZG8JaPv8L

On Thu, Jun 20, 2024 at 06:50:46AM +0200, Christoph Hellwig wrote:
> >  #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
> >  
> > @@ -24,14 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
> >  		kfree(dev->children);
> >  	} else {
> >  		if (dev->pr_registered) {
> > -			const struct pr_ops *ops =
> > -				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
> 
> If you touch this it might be worth returnin early before the else
> above to reduce the indentation here a bit.
> 
> >  			if (error)
> > -				pr_err("failed to unregister PR key.\n");
> > +				trace_bl_pr_key_unreg_err(bdev->bd_disk->disk_name,
> > +							  dev->pr_key, error);
> > +			else
> > +				trace_bl_pr_key_unreg(bdev->bd_disk->disk_name,
> > +						      dev->pr_key);
> 
> I'd just pass the bdev to the tracepoint and derefence it there only
> when tracing is enabled.

I usually take that approach in hot paths, though this didn't seem
that performance critical and I assumed we didn't want to pull the
block device includes into everything that includes nfs4trace.h. But
I will look into that, it might not be that bad.


> Note that the disk_name isn't really what
> we'd want to trace anyway, as it misses the partition information.

Right, that part I was actually not sure about.


> The normal way to print the device name is the %pg printk specifier,
> but I'm not sure how to correctly use that for tracing which wants
> a string in the entry for binary tracing.

I'll see what can be done.


> > +++ b/fs/nfs/nfs4trace.c
> > @@ -29,5 +29,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
> >  
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg_err);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg_err);
> 
> This is weird.  The trace points for nfsd really should be in
> fs/nfsd/trace.h and not in fs/nfs/ as that would then pull in
> the client code into the server.
> 

-- 
Chuck Lever

