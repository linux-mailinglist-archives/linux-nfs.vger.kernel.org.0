Return-Path: <linux-nfs+bounces-3155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B138BBCAB
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D424B2096D
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408A3D57E;
	Sat,  4 May 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IF5jDpQ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oY3wmuYv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F13D54B
	for <linux-nfs@vger.kernel.org>; Sat,  4 May 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714835931; cv=fail; b=KV+Z8a5atN3FJ/U9qWhi3G4rfY6WzTsDhgSGtP29Cd51uggkVkpBzijFHCJ9ZfV3hPVRVg5DtCmEHBzEeu27/XcMD+9AwXIv3bHGdYu1C8RwC/nn4b1RWEpbGvo5csm/gqXT478gwHPyLA/x0wiIPeL2BjiWiFLqNXivWf82SkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714835931; c=relaxed/simple;
	bh=wCkayzFSOAC+lQJk6BihDJ71I1QV8Zw3ZXSFCzK0EXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ojjGVikRHNipvUWEDI7Lea6WFE3bazhEj/0dbMqwCEZZYT0F2IxeYPguxgetXx+sAgXLkbMAblQ2A9aSjJib27chreulWAE3U+yxY974bmxEKkgEMVVAFl5VHgCR85m5mnYu7NVRzoWO1tg++F4/WJ/dw8p2pGnlXUFp/h19oiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IF5jDpQ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oY3wmuYv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4447DWMe030374;
	Sat, 4 May 2024 15:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=HYYkvAtQUNx1C28NV0WPjhXjVdYAezYZPUQkOVJOZzc=;
 b=IF5jDpQ8zl8n2qv/2sOAKENb50uCDlrfTzwiRfecPdPxuaw1FvGALlhk3gpJFHvUK5oY
 f0LtXowQkCGLlD+1HfKKVQMeDjzd+yE0b0IiHFKxAkuiT9fe0LAxT3nIrpSGWKN2Bsbu
 iznLlkLsI458+BmsDNkOA7gRhHVAC3HWNzM2DE4yYypiL/oEzzV2rb6fUd/Khkkfrw+b
 VmNZkq97Zk9co/lPq4uW7Y1T5FozEpdzEmOZdaq5jkkfVuMJ/QPmZdPAtazsGEiK9qSn
 9qSkH7Q816fqhz9jd0vPK8XajTCNf3+q19/YoCXjlAbr0MGPatWrcRIXEao7R3SDNm6R wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5gf9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 15:18:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 444ChIB6039371;
	Sat, 4 May 2024 15:18:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf44aka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 15:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoBjWFoSj3BeDFeerIZNhcGuwgclbhskVMJ9jzwdVeYii30JaHjIn7v6El9+fDxi21meCM5oLN4wR9P+HPLmVeeAeFb73EHl1iCY2LNh2m5jlB7A++MGyw9QwYU8uuantYOT6F/1Z5K55K61s934a4rM4ueobTWkDeIBfthdQnL2ykmKrNfrvdxiWYF2mH+CdzsvJWEi0qRwehcIML+WHA3BuGSRzdM+8UdBhrhuNICAZBqBswAVyxJOl8/1cVUPvTJWNyC43eCXig/G+08RpOqcONZr3uHudACgG69+RofDT+XyIW1Sta1qM+hSdwzTQV33VDi+Fba2+TjItu+p2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYYkvAtQUNx1C28NV0WPjhXjVdYAezYZPUQkOVJOZzc=;
 b=m46BIztxiYaL9bfvcu1TZjvpYzQ8WAyEBl8lt5dmDmjKTHSFOOCivcjNe2jPx9hZzPgIsXzLGPPcuQ0KZZKplrRIiMr2sXG9O1eldj6YhSUUsE3Wl7DAH0RBzAejoIecdAPzzYgh4l9JciPSosuxESQeOlb5wlpXqcEHn/TdE/oKKkNvkGwOFWWuLOh/pYPMvZMTTk5yEB+QJ0UCX+O94hwQqLth30UIOjzzIu6r/IRyK81rVRLQh8QqeHIKeg+Y2h1K5fQ3aEFizQq+Gr2KWtTTrKUeGjPgYQQasGPIMkOPGismXrAO4bdCHDVOXUURzlw9fvxsQrCPtercZtLwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYYkvAtQUNx1C28NV0WPjhXjVdYAezYZPUQkOVJOZzc=;
 b=oY3wmuYvyv74L3c5oEfOByG/WjKgsx8TxPvysmN/IHqfHbXCsfTRgRVzo7TiQfuS8+gpAxWRmcQa7Ij1FECtoZ3QQQSB7N06l3I1hPOawB3+vNYIvrd3ELiOx+JvToW/AOpUnHGwg797VPxEfWGrAv3+pF6hEyohjuK5bYsSNZQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5628.namprd10.prod.outlook.com (2603:10b6:510:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Sat, 4 May
 2024 15:18:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 15:18:42 +0000
Date: Sat, 4 May 2024 11:18:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] SUNRPC: Fix svcauth_gss_proxy_init()
Message-ID: <ZjZRz3JuXPAvt3mb@tissot.1015granger.net>
References: <4d92f9a7-a278-4d61-9804-f6bc7cd7963a@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d92f9a7-a278-4d61-9804-f6bc7cd7963a@moroto.mountain>
X-ClientProxiedBy: CH0PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:33::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd00cb-7b92-4cdc-fbd3-08dc6c4d7bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fNOmJqWwJMXPtz7rXUKTdRsJirpMq993Sc3zA0zSscNh/r/GT+yyo9Z4xLD4?=
 =?us-ascii?Q?ZvNsF9HrQS4wfynmHeU0uAJ/+EoOSE/WH1DXpQb5pXs0bAP5lHVVSGSRJiik?=
 =?us-ascii?Q?BvH/zA3dJ3oKCEx/g1STV6JZX1MShOrJIm/Fx051je6sArJvAsmfPrGl5DQc?=
 =?us-ascii?Q?D9gslINnCE2c0VHg3nHN+8grEDFK2gUMOeHfbH4SO5H0lTDfEPnw3R1V4/qJ?=
 =?us-ascii?Q?bv137MS0XhSooa49KaT0lVWvlXNxciNgDE2RvFYBxctCo+zwskG14NjSsR9N?=
 =?us-ascii?Q?PSul4is+1I0//rZ2c29utBjMzkXFbphCDMi4cV+YOE/ddRyZOntyjKzfdVf0?=
 =?us-ascii?Q?ecNm7ffrmFui7J/N4/zVnkpdjsUP7npHj0SH1GNzSTBpr1j2VQOY1JfdR2R9?=
 =?us-ascii?Q?kuHHanzzqof95v5tz8uNJti/Jd+YlquOEvgDfRecDlTyqOfMYP8ljPfSUcKK?=
 =?us-ascii?Q?7iX9dl3i9M+o9ZYpTq5YFcQR9/DGnAdtJGtWUwsfdN9ukQy+cEHfJUgBvtoo?=
 =?us-ascii?Q?MdUd+Z6+1ClTrXdUJCnJN70GKf/ZYq4Voem70/uaWcnNaGTLJCWkMiYj2d2L?=
 =?us-ascii?Q?HjAsL99tpFmMXoYq3ePjK2X/C+qfLgBgO/61WR6Uuw87HpacXooyxYeYu+NO?=
 =?us-ascii?Q?ZNF71eIeagt1CSyA8ysM1NQl+02/1a1fhE+ymyY6NzhlxG4Blj085/RMDNia?=
 =?us-ascii?Q?n734YaaCwRqmivu+MhMAoooFDCqZIO1ywIsldUpvxrA4v8Qcbwp1Ns+MtGtJ?=
 =?us-ascii?Q?ZLax2xPZYQWQ9J+nYTgvTWEQahaZag3qjiqqT6vNCeGYlikMMmg471uHMjvb?=
 =?us-ascii?Q?SMNovladpaGSfgHhlRVq69c5G1PLK+GgqovcQVsQbeut130O/fyxWIrBcDpn?=
 =?us-ascii?Q?bKFhvYCP2JvKqfUJueOyLG2mC6JsKBMLVrtbvUASeibCT1AfhkgDIsb201vs?=
 =?us-ascii?Q?amz6jeeUcOPBgShDRhIaYSzbdimdPNM3YLn/1maIZnaFq+KHpmujplumJROi?=
 =?us-ascii?Q?rDsOj8tz3ZtMgGN7DI8Ch1bq/jeo3ip0teRrGjDN1dP0tesUJO8wPzp4r+Zx?=
 =?us-ascii?Q?NsgYWTei5086QbSaCGFxPJ1NMr3W97BfjT3pAcQBVHjJkeLGl42KCwxS8gRp?=
 =?us-ascii?Q?NVg0TYfd3/HsGd42f24L4C5M4UUtVHYOF/1i0HNbr3Shp4TlvOgFJFXtp+b0?=
 =?us-ascii?Q?E7/P90IwpKspUgeRyHQzsmdIOHty7e1IavETGzTvhtp/59/EeJzRdRbjmxtC?=
 =?us-ascii?Q?e2uEVAneVXDHGYh4CxfqWxdObgcYP2mYkG3H3fFZYQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZcQMJy1yFrD5O57piRO8kFwTyTdVhdAPRTV+/J9HJyv4hSGf1Trw9I8ruxGu?=
 =?us-ascii?Q?5iYAIJK9vbpK9ZImX95bSjY3fCEsXfZZxOAx2MPdP3ymfyozf5h2XLu6VJ/X?=
 =?us-ascii?Q?hUGgZR+qBNqlay/MyqCCXfgnyDNvMroW62sDACP5rBvGqfXw/Y8PXWvA72Gp?=
 =?us-ascii?Q?kVo8CYqxwVP0GFH2erMqQinWY0Qv9XpqF7Ume22peJYtG1IGkN/cCaIbBoOV?=
 =?us-ascii?Q?3R11dLJ/bb4XIrRn+3Py9CoDTz7iN7qVM5DNv7/zyGlU9AG0jAnAXeYw8nmT?=
 =?us-ascii?Q?nU5/Lpkht6yY5RarZID39ALm6wUIXEyBttQMyulTSsCHED8NyKlfMfZAYX25?=
 =?us-ascii?Q?kIIvbydbpd/ILMTadSdAQJLpby3FKoXm+U5XguN2f2Kgipt89QsTxZQDnDhK?=
 =?us-ascii?Q?pxScmW7FV+HNVzJ7uFHq6g0O9xD9vtmTpw3h8xsnaSWahXjSjxFTFhagA3UI?=
 =?us-ascii?Q?3qVxITcoQsZNARFMZLEVLSjhLQjVdGyzef2FHj6pQRXJ0xq3mH2yKfyMIe4n?=
 =?us-ascii?Q?ITOVWdsJwETmcTtOABRBXE+nMNgPZgyjaJ9livKAwTD7nIQq5VX+R6LYBy88?=
 =?us-ascii?Q?d9FyWfZdlOkIsULCAuFo5O3lewRoBJxwiTFHmdXSapTFNpRUNOJZp+yXAoc8?=
 =?us-ascii?Q?aW2gGrj2Z0xKalDGCyVzDFFKuI18p6xNUnb/KB1l7HWlpvrSsFi28g3shxCf?=
 =?us-ascii?Q?Bif4RrxFitzQ4zkziguZJ6XF1ZqvhW0tSo5AG1HNghCnuaaK8vpBdoHd2ZuJ?=
 =?us-ascii?Q?V9oZCc3hKcVC9p8umYCKLXvAxkK1rraFVuL1cNyGEtO191+CM+vRdrrr+g+2?=
 =?us-ascii?Q?Hki8QSQ11tO8oNltyUpnRzjIFPAMXvM46lJy73qYT5gc0iZ7LM9rX+lyjs+E?=
 =?us-ascii?Q?2veC6xCtKfNpuwqwLQ9d7YiSjb6D2utYKqqzSV1+Tg3wDL2S9aaH2TxdZSBi?=
 =?us-ascii?Q?wvl2t63Q6ntMTR0/IlFI3jXL7a2LyCmI2sgCqu14KtNyNzJbDUnaehmYcB1/?=
 =?us-ascii?Q?n045TA03UWzAkge84inbId+R9XL5FzlGHgoMmrAv8rC2noy5OKeoCTkhsoO8?=
 =?us-ascii?Q?p5if7c5/Md3OS63TndIdySSFLvJ95ktmGnBVJfEr+isrM16YeiIL742q8rEi?=
 =?us-ascii?Q?eXVHYIG11/V4SAqKWHYhiACtF09wyf4m1Dq9sd32ZyEb0TUxjK+8L4zZFBdy?=
 =?us-ascii?Q?Cn/mhTdi4+keXCVJncv2uAnAWew6oG1MFTUjrC9OP7L0Ejd1+6qtm0fFkMGF?=
 =?us-ascii?Q?TAKUJkp2biosK9cg/rGEB3XuhJwB/8jKbCIv/LB7EAysCl3xAIf/z/LApFKB?=
 =?us-ascii?Q?KdfKqFR9Eah2VnWaBkqzYnT+JgxtL7HIl3Sy/qlRpFUFiLhlajdqW3oJqovL?=
 =?us-ascii?Q?UxrIY2Q42x4xnD+7MLCnVFb1+JH/kk2JtIbwr+M0rD8l43LbWZq65dmVp91V?=
 =?us-ascii?Q?zu+5KdgPh9O0bwm0+o+SjIiHw4K7Tgp+KxjYsTdIZ99Oh9y+cIje8N/AzPSx?=
 =?us-ascii?Q?knskt0uSz1tYs4g9rkKUVDPt3XgzXXUkHUZiQ3iNSRC4mQ+6KM+qegwaCwfc?=
 =?us-ascii?Q?bxNkJgWE3G3sqFUPAbFOT02PTOkhAXl+TCqbKjxC3f8G7fuwOUhN8U8vQc9L?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c/d4u4SmbRAgfLUYGP54RNOhXyeT5gNcO1bA7MCKDufqxmw/OcWZbe182DLOLAkaG209+fJSAkTx6oZrw9b2mQhCTWn3++7VMoCg+dH2qDEKWeye61C/zWsNNqbiTapB2F+BMEcuRR7oEgoxLk2in1Lb8yfL+CZ0yTKVuSgBCT1q+GMZ7f6wvs+OuwDPDhtbMzEu0Qny0A6xKxZJHsW07Sez5L6Jg33Mcf4okbNKzgwPfKMbGARMp2+t/qOWl9g3wMCWgVL5zzcm2oLqtWyUUk276+kcx2nrx5bQBH+j25hvHID5gee406AcygzZ2RaBIeVLidfb9CC+H0rUPCGvdLqCPWYnRnvbEAUXEGxFpuC8vWyVP6ZCOBU+D4Meb7hMe1tdgqa4BKede7Zh9k4twaC7YwCYi/4ukFmmMFuSSM1GfcS7tzyGfTYc5rjyefDMTvb4NMWJgJ/pHNPyRo/xUfbGJMC6/RQHqEVe6bzk1gQDegXolIMZiXrnfSduBW5lE26MSzs9hPH9bKe5YbquALBgHWukuTmWSg3v0M9nG7BcbvQx8ufGZB/uMzVm+dEqi6yFf9ZIsoSqBRBG8uib6AviIH7m9nCu6K9yzKvm7mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd00cb-7b92-4cdc-fbd3-08dc6c4d7bab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:18:42.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LVzOA5WBHiuGYhyxroop+rHrAcH3VdEPcZpj6niJHGQcdgn7KhLfCA56M366SKwzXH9KUWaIS4b1i2cHHbWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_11,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405040108
X-Proofpoint-GUID: LDNxUCqeV6saOxT_p1jj0XpuwGcS5hGE
X-Proofpoint-ORIG-GUID: LDNxUCqeV6saOxT_p1jj0XpuwGcS5hGE

On Sat, May 04, 2024 at 02:23:23PM +0300, Dan Carpenter wrote:
> Hello Chuck Lever,
> 
> Commit 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()") from Oct
> 24, 2019 (linux-next), leads to the following Smatch static checker
> warning:
> 
> 	net/sunrpc/auth_gss/svcauth_gss.c:1039 gss_free_in_token_pages()
> 	warn: iterator 'i' not incremented

We haven't seen a problem in practice, thus it's likely that
->page_len is rarely if ever larger than a page. I will post a fix
in a day or two. Thanks, Dan!


> net/sunrpc/auth_gss/svcauth_gss.c
>     1034 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
>     1035 {
>     1036         u32 inlen;
>     1037         int i;
>     1038 
> --> 1039         i = 0;
>     1040         inlen = in_token->page_len;
>     1041         while (inlen) {
>     1042                 if (in_token->pages[i])
>     1043                         put_page(in_token->pages[i]);
>                                                           ^
> This puts page zero over and over.
> 
>     1044                 inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
>     1045         }
>     1046 
>     1047         kfree(in_token->pages);
>     1048         in_token->pages = NULL;
>     1049 }
> 
> regards,
> dan carpenter
> 

-- 
Chuck Lever

