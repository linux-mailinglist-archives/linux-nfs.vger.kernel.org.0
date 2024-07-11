Return-Path: <linux-nfs+bounces-4839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A059A92EEE7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7352813F9
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A112C7FD;
	Thu, 11 Jul 2024 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XxpARyBO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X0viiTty"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384C77119
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722729; cv=fail; b=qNiqHUNMGThXtVRBGp6DIJq8S2r8O9sZdyq3DJlU2XANDh74gJq0wHQyl3QqbT2tewGa4k6Lh2SeMrsUa4K+lb0ZeQbsleYuXJIUVc+tQJXhwad3BkNBjuNQ0Y2L/sFwFlP6BnH7BTpV0+zYzJwlYVuXsbfh1p8WUw6E/t6N8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722729; c=relaxed/simple;
	bh=pWQoOvyk3JXMwpu65ueYWiuamydzAVMnHmQivHtjnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U83dYia/c89IRll24NpyalFv9tq3uJ4/tW/1R2/pn+UfE+SgEE/UhP+z0of3xHqzcNQMi2mxQsWnq5/eC5e35q4dCcLTiVUOTJc9Te0LOXBAvUOxHwNpKo4BP5mDrc+UYhBhuJcaKAp/oDl6RFP9rDUfKPiurd7SBa5B5oUYq3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XxpARyBO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X0viiTty; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBaIj027117;
	Thu, 11 Jul 2024 18:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SeHhzIgIDeMOg6p
	Z3V1gAEKKDfxkgGGpDkn6/t4RRIM=; b=XxpARyBOz7XZUr7kvNSfHCeWuEXNx7A
	jTnfioUCisdRMy2NYMuS/Qnt2BuvEsayq5PGMxfedfWqop7VOXz04xvBIcxBQg0i
	YRZh0g67NxHfXukQJQCTLQdtuTEmszxZE9ZX1+3BfgTOjYLTrRgauh1Yq6sShmlD
	LmNPB463jhkHHRDckdZyLzb0K1be7f55queve+xCyJRZKu3nBk30y5cBG1jk42CQ
	4b6h2GBbuu6HJFclJ8Ta6sZcOS6AXeLKN8rtzLUAw8Q+yqsy++u8BpznU6f8fJGw
	YN6U8tem7YSz7IaGhfoWoe4tlw6j9Tqrl0AOnSQeC3vuk5aj0BpFc5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq2b0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:32:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHVMDh029895;
	Thu, 11 Jul 2024 18:32:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbng5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd1zposj+AhnuDQLXVhpep/IqtNmLK2kS401FweyhW3tHGWN/cfdL1fuCBAQ3L3DwVyaRbzIyd+T+I2drt6eKoNb/rmzJyNBZ6v6VUtsL2U+ZTwkqoDeLr0y5z5C2RP1vFwEuOZupjzvQoXVuK5Ps5LuTqTFFlSdbiovXz6bMZb8MqTi+6PHmI6adiPGi8yxuEQzjAQILNvPGn8vccM86pOCa1k97w3RT1OktS2UiGMjlf5/aE62nAsx/Jcp18RJ4lERnclUs4oWEX6R7ji4nVOECVvCifPEPMlBDv/0mBkbt2cvpeAci99pLR3Y7TzmuxxfP2GgjVbNSocghaRT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeHhzIgIDeMOg6pZ3V1gAEKKDfxkgGGpDkn6/t4RRIM=;
 b=FhGMleElMltqi1aUbBDmWuttq7Gl8IKeON0IRZ13gLy49lteMiLwhEM6xo7BVdUmEVni0J/4Em5VLbdwnrI5YuATR+x+t1ROk4pA/ZrPE9XPSDafbedX/QWocCYg7InCOImivy5Rn5zvpi84IKRnUgxGcjIumAqpvjBq90fJz7D9CUqwu4XHq3XozUCiWxELU+HEsNJtma21Q9Oa/LNjwNavvKpbcl+XBfHZkbU+eNxLBrQ+hyo4www8tPvMpsoIwc+WzEmKFHS7IfKcbGh7bZZnejtNlijPSSqBIBdPx4a4vRHUYokS1Rh2tuNysQwKy1TSpxvTvEJahdlAMu7oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeHhzIgIDeMOg6pZ3V1gAEKKDfxkgGGpDkn6/t4RRIM=;
 b=X0viiTtyYL13w8gJi/SFFNbz6mE5CWvHmZP4KJy/7T8gW62heeyZIGXY84i7CQu1+mtZoKJcwI2J4nX6zh+QgqqEXvqbAzrEUZXnzJX/qHzeLUq9CCKYrVoI6yj/KtvDpRHve9kr1sYWc4HxhZE1JQS9wSSi2cmHz3kj+1zFGoE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 18:32:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 18:32:02 +0000
Date: Thu, 11 Jul 2024 14:32:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Youzhong Yang <youzhong@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: use system_unbound_wq for nfsd_file_gc_worker()
Message-ID: <ZpAlIM/vhlrgtc41@tissot.1015granger.net>
References: <20240711155215.84162-1-youzhong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711155215.84162-1-youzhong@gmail.com>
X-ClientProxiedBy: CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c21222-45ce-484f-9de0-08dca1d7c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ci+XzQKYqZLBOelmbB8EMawodAcdCWrCj/kTFH9b+L4w+waQh4tR6wbhMmOF?=
 =?us-ascii?Q?tDuUTUvXstd7qGRZ8A/ujqsgNpre7zs3u/ydpzCXfCd0Q4W3gytyVaJBtkH4?=
 =?us-ascii?Q?8yTBjDJbb3p/admB6X5szgfwcjPZ9mdOqMleMmGXkrg/QVgpgEGENB61Ukia?=
 =?us-ascii?Q?V6YMc6u5uMFW3+D9yx/EdYb8FOczZBvFsC1Ts9Kt4dLOWAixryPWn6i7MLqX?=
 =?us-ascii?Q?go3TPvPnNogsGDcZ0iDyH0SR8DSS2CtmhhzB0pRZyQ2WHwAji7Rn7lvPyqpA?=
 =?us-ascii?Q?s0Y/5mhiFY4g+eQMX6/c1L2kCsxtTxj231GJFTP/udBIebsaSRVruk8Ra/j3?=
 =?us-ascii?Q?B3dkB48WsH4VPn13RynAKSHtSkvld/JddAYJWZURxITOJXYkpYVhnkH+99gv?=
 =?us-ascii?Q?dw46I+5ahAu0v96pOPecUY95jv27R1d8brtLZBzUDA1kckjYzcN8JVUHk1FN?=
 =?us-ascii?Q?SgGIEcBzlRlQ1Ka8zCXwOWAoqPt6UbxsqPawEOxVTqXFgS1h9vWdpFbK5db1?=
 =?us-ascii?Q?EANaf915F6AELWj9lu/NtshTOwiORTnkpbBOlS0HlSJHNcn3dbWQ7B4JEKFd?=
 =?us-ascii?Q?St/O5az69dwkYvNRGtc0/I7ZetSZspFyHNlt/3xg5bbZx0AGwfjOFs8Lznxm?=
 =?us-ascii?Q?pPoUYVxIG0ycyAuP9K2VzFb8dnB1LS7Y1QgKBJPtFs9/Wzar7dV6PvThDaQk?=
 =?us-ascii?Q?gM1fQ1Q0gH0mgXcjfoDkGp7lmk/g14Rl33nwjKCxRkx2C/WDlOWosN1ZoR2R?=
 =?us-ascii?Q?bloTUu4simmNPXry1wPTzmlWAetHllC9qc7j/WBpk/JpJiyTuirNu9deQ9lz?=
 =?us-ascii?Q?W89TN+5QVvDR/hGShImAz0UCfmnxqRpPJHDrqR+f3TqJbsI0GMPcxT95vbgJ?=
 =?us-ascii?Q?EfQhZSUtdk4PgYF7IFuNWCLPhDXHEEi1z+TpudjjtO61QlJ6uMmAquvG0K1X?=
 =?us-ascii?Q?spm9pFe00RgsJG+Yimkv1/umenwXMoo36SMCgqCkjA6g0/mXfoTbng88uoPq?=
 =?us-ascii?Q?ozycgMiuvi2eIGqi34zfI4RoFTpdtc9KGugZ0odnSD9tkbxqmxO1t+Dv1Sjc?=
 =?us-ascii?Q?/2m/h7W8G034pq1/0T55TP4SBL23Za16JrhprffiR/Gu0h/MLHY6gE+kUh2P?=
 =?us-ascii?Q?mw1ITyi8I/iOfE2POfnQeA73o4tZmwLFkQnVlsK7p9eNgX2R10faN5QYYiQv?=
 =?us-ascii?Q?CUBTTX0KuKhTAmSX9Uv5C9h4OScHdDM7KpHt9coL+KPH0aDy87+T4okHH6qx?=
 =?us-ascii?Q?CGGXjvjSsyVb7EV2+CHapa5jIvkV5m4SrUJaOznsog8ehxCEUZ/JzNtParr9?=
 =?us-ascii?Q?G3gHi5u3AEyHTX42DNf0LRKc93Xbn50YyePfWcJ4bZutQA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KAmQZ/mSWWlQQ19ZRq7XFpQP68HfLjrk8KyGti4by8Esc0EiM1cGWPFCRVQM?=
 =?us-ascii?Q?d3PDKpmGoEhoRAHrwuYtbDXYoEUPGSwhnqSWLwiwYnqEDtJU6r4+a8Yn+W1l?=
 =?us-ascii?Q?jtmdDvSw3iBGq/HBvmv6eB1dFtBYNm2EvZvV8v6dwQB07ju0P/a01gljuMX6?=
 =?us-ascii?Q?b3YhsSXSb/jSPlLKW7HZd6AUB0ML5D9Jg16C6Jf2qk2lTe9xM8uG/lFRDeyD?=
 =?us-ascii?Q?EO+PR+7oMJvSi8P5v4P2y0nArHWWPA2g8FVHEA0DpejsRgrgjg6CBBtchffT?=
 =?us-ascii?Q?XghJsuqfHsr/ibfAulC1QTUcBzCP7jiG9qrGfrYCUHh2Brw2u4Ud2n5Z/rG6?=
 =?us-ascii?Q?/aszKqntNxws4xqJvCUn/yqEOfh6k2r+XoAGa38K36xgq+X5ksrWG5MsmeU8?=
 =?us-ascii?Q?1xdpqGXjhypkpYr2mBIWLfatTssy3FMsHM0M2P02rCl3Czps3T951zCEywuN?=
 =?us-ascii?Q?WRP/hBYlkzkkD2siWgnmoHrTrLj+TWBwfQ9p8vav8Xu/2ng8f/g8E4ZqCLup?=
 =?us-ascii?Q?lClJ8G3p5LhjcbE/JZiJZf/GUwBNicTR7WhfP3E1DDXe1iG9sDUlYf2vqAnK?=
 =?us-ascii?Q?RPobmiMN5Fkj/WqkmqEEf9qRe9lC8GLmZVAoUB7vErpTyRoqr9ehKzSfPFQI?=
 =?us-ascii?Q?N9ymO4v9A36idIJi4SxePWRBdXHOfje3/FoLKOnLUSt6tinuT1ttYfe6UXl3?=
 =?us-ascii?Q?at96nCIX02jDXdB53u8uELpIZH8/WVmzIu/58/I/Jd4Fu1+TNZBVKu01UdJ4?=
 =?us-ascii?Q?kdWpWxAQI9soyBlQdQrq/E1NyYKJvKaJBVLd3NYY7AF+vEgJBkzB2KDHBa3S?=
 =?us-ascii?Q?Y6ZROQMK55AGwK0MGZzVHLFgxDdhNDD8pKbYC4juFRqjsYbbxjEvs9gfbNeN?=
 =?us-ascii?Q?2Ey4BwsUE1sOL7dy4G56rm/ETfvlcBHRRK1SF+lMdkZXXbsF6FRvmHIWeVKv?=
 =?us-ascii?Q?jD1Mzgzk0m4fYszlVKIWBElkmYVre+4z2yoFLlFERRobv4ngLSmgv1WoNjff?=
 =?us-ascii?Q?yxSPtiEA/N+9/10Qy22ASTxczvpRR9VbuqrnlhHNzEor7h0crbxY/S4nC4IA?=
 =?us-ascii?Q?awcweX2ZUgEdVGc0MYd3+tje292Lqco5Ek8F1ip6lZS7tqSI8uE7fz6HIIUS?=
 =?us-ascii?Q?tml0iOrYtGe75OWwYxpyqAf715TmYOh6qxAJiAUjDnSsY2WWoT0lVEHvj4es?=
 =?us-ascii?Q?4Ibs4BFYQO1hbY9rmViXyCiDhtLL1JdXl89f8JRzQFSip/JNf4CwG+hQW/Wh?=
 =?us-ascii?Q?L9A3hfRyH2YIKp97ihWJsRFN/juYueWDTLrs0Jng34dhSqtzFTxjJNYtuETY?=
 =?us-ascii?Q?rxRITTTze8YBIvKbe4CFtahEIOZCumN4LBlI1es0ZZg/4w7/fUrPVpJ51m4b?=
 =?us-ascii?Q?poswS/ENIIPOGyZd2wWwl5zSE3MtcmCLCviybDcs9H5aiGwj0PwIBXWtN7xH?=
 =?us-ascii?Q?r5x1D86FuZTD30sXXy2aCu8QPQmZTCXIlednUA23Io4WxTC4LBKE3g7+m2Ul?=
 =?us-ascii?Q?BGhq/iNael9O4xtf6EJ0lFz8SOUyiqTw1vNgYQVsI6IUg0JUFp7PRiOLlzOA?=
 =?us-ascii?Q?WSPJFGrC8MC5AF1Kb6F96HsB95ejKQBczBvSg8UCsgXzkJ6JY+wTJhbjxBL1?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Q3ueVEpgUX3qIaua6NCvc4j5rWcZ1xGRQqS7a7vcilKOlMiggMPdA7eECwNY6ryXbuVp0dE++owsjBad1Oe7GbJHAz7wvmrQ9ig9QNIypP37MdKWczRWEIILPhzRPXlLhZ0GuaiQ4CVE2hHSBBadDIki/WNsUQy5hqZag6VPL4uT8Jw2T2v9n9Wx8rIpQl94lhBYnLCyDnwQWdFh9dSO7aE1AJT6Dk8a8afQ2DbnLzj7z1BGicjIYoetHdooJHjv9u+ysg/cBdeq9uK0yt61DbJEHb+a1EhzthM8xnfmUskalvDWTWd4ftlUuOShMynQPUVeunS+8N8zSjGmK2aUuSoR8yD68HinWaQIdqR/D152Ul60ST2cuHftFaMTZ8PWeCX++UFeRcrbdcaQ8Dor49okI3fNLXchCShSVxhXPZzPsSJXCSWgel3in4NrrWWRz7N/SAft/kbbdZ5+Sv2bBSG0PjkWIIKjhqCSwmU5f2fdH6qfu8GYW+uuAI1kcN0uZog7RUqDOXXmb3d5vVM1BMSc4KmQQD2PqyLTrbC3JPbCOYXG70Vhq31s55qDZvsTHfO7t5Mj8ljrOYsOAF7bxaOW0DsK2NKsgGkY33RCXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c21222-45ce-484f-9de0-08dca1d7c21a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:32:02.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkBFvvyv4/KnAmVasqgVFJv90xglpzfjD6ybMvtNFBsfeIxzrlZLy5kLjWqnahtO0E/R6PN/jMUWtPd2AGRxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110128
X-Proofpoint-ORIG-GUID: 4VTqguE0ZMcVgC2vl8ZSICUaNstEW8eC
X-Proofpoint-GUID: 4VTqguE0ZMcVgC2vl8ZSICUaNstEW8eC

On Thu, Jul 11, 2024 at 11:51:33AM -0400, Youzhong Yang wrote:
> After many rounds of changes in filecache.c, the fix by commit
> ce7df055(NFSD: Make the file_delayed_close workqueue UNBOUND)
> is gone, now we are getting syslog messages like these:
> 
> [ 1618.186688] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 4 times, consider switching to WQ_UNBOUND
> [ 1638.661616] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 8 times, consider switching to WQ_UNBOUND
> [ 1665.284542] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 16 times, consider switching to WQ_UNBOUND
> [ 1759.491342] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 32 times, consider switching to WQ_UNBOUND
> [ 3013.012308] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 64 times, consider switching to WQ_UNBOUND
> [ 3154.172827] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 128 times, consider switching to WQ_UNBOUND
> [ 3422.461924] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 256 times, consider switching to WQ_UNBOUND
> [ 3963.152054] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 512 times, consider switching to WQ_UNBOUND
> 
> Consider use system_unbound_wq instead of system_wq for
> nfsd_file_gc_worker().

Seems sensible. I will let Neil have the last word.


> Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> ---
>  fs/nfsd/filecache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..e7faa373d45e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -111,7 +111,7 @@ static void
>  nfsd_file_schedule_laundrette(void)
>  {
>  	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> +		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
>  				   NFSD_LAUNDRETTE_DELAY);
>  }
>  
> -- 
> 2.45.2
> 

-- 
Chuck Lever

