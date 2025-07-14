Return-Path: <linux-nfs+bounces-13047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60ABB03FE3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0E74A7190
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57A2550AD;
	Mon, 14 Jul 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G63p3yzN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AaHTB3WH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E1255F4C
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499482; cv=fail; b=rUqUVlrvA4igMKhSyj3L2WxqqSZp6tGoBIP03y+sJsKxcACORZgj/F3BP6472gInFNUQThxRHiCMMq91yU2L90MeVN2Jdu8AfKumlHJaCLdxIWoPUu+Q1TseZNijbUncWdnAyQm8Wu4rYgFXjZS8Y8dB+5CbdjTFllIbfzPZmrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499482; c=relaxed/simple;
	bh=55wQW7TFTnPXA53kv69n2eFsE+igCxVBmm3no9YoMYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8LJaA6ixN+/UJfv07gPHhD0VGgTLzE5TWtUqdPnGVc9PRWPfQFxrL9iPwS7zBr7NSr4WkkpbdoiBlHIqrryZp4Epg0Sro0dXTSD1akaQXH8RlehJkSOBUFBmC3J7S7TR4X3Vg1Vd2Oeimv+HIa0m3YpkeFK+Hk/M80nXs78/GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G63p3yzN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AaHTB3WH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z58m031188;
	Mon, 14 Jul 2025 13:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t5G1SOkASmWVCFHiWRdAE8Fw18XXwohHw4QzgB32CRQ=; b=
	G63p3yzN3Xd2aUNPhOewZBG2SWF3RcMrtQ62Nf9bt1AFxqK54xhjQYYwJhw3ybZo
	9mNZVO+4Ns9IblXNTiM+YUg5x76DAdtsw4PRm0o8BmI1eicEjmEBBB3Ho+DveeyD
	OjGnNLqYieVXH2I36f38uGBJAA9G92Kh4TlAUhDVsPlN+ubq2iywz+FMWDb11BxF
	KdDKjWHS1it3Bbs5J+wDpVuXHVaOag6do7IOkEORJFVBDf7isnXGwVrmvh0RMNR3
	8ZuMRbGg2Tjb03lzPvnmCxyfcVYxXUaD+4/a0bGBLDH/+B+bCkCPkWqKT4c5UKWC
	DJIBv6jGP6m7g/Hofues8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v38c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:24:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDEgR2029770;
	Mon, 14 Jul 2025 13:24:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58a4cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7p/EFnxwhcmYbF/lwQ0HDum4dpaYnVTi+LAlGch5i0ZgXH4OUAzoso4YSBlEbGXzafvEXTqDFVCCkwXE+PBOIOz2ADq9uUchn8otlasFpnfg8clEFFKvr7jZK28Rk15VyKFW3LKSXMeIJGQCvaHhMd00/MYtBrmV9nGJe1WX80cCwBZQkowF0uAyE0QH9vuCfs4E74O1QRGpwUVFhJYg7bG9d4h+A0E4kAA1zu1gcwQeEG7YG1nhVvF/8lPOgD3YPReOyAIG4btxcDXGbzwjFlHyqk1RFGvLELId6nlq+HUb3IphbZM2E2qO3FbLt0Y+SJwDqyXHy4PkCoxfY3X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5G1SOkASmWVCFHiWRdAE8Fw18XXwohHw4QzgB32CRQ=;
 b=wrcUYBHdI7/HFB/rNmPi/8GVTW9SpMxXrGx/TLvG+QKjk8kOPMip1lQp6SPODSjux+RxjAofMzxIkyhhA+tH8aLj5RTKyzxY1v+AdN3yVQ0Ov9PmXv87Q55za2NYj5M+ziZ63Mib15rSEfx4vS2/LX/msSjwrypa4SF+ndL5Y2Sm0iGXGKYwUU7FOnJsC3XCsIGInfn3astRSdU63xH/GPMOI/MT89TWGS9lbRkevlGYTs2nNlJMqXqEIXrDLlfk8HfM+ZADP9RKa5Hzo/g1Kpiw+ad06YnQ2pEdVmHPIav1DK5WziHPRrld0mlr2kUXrsCkMBMy/dJLF69QiIPEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5G1SOkASmWVCFHiWRdAE8Fw18XXwohHw4QzgB32CRQ=;
 b=AaHTB3WHPUMf4Bt28wuX8OjMwuesWl2whQ6AI4N/8UOgXzKwhbNFJyqnpLMfcKVI6zrndm4biW4KDQ52mZ9T+P2fgx8CK/M4VTr/FfYQRS/zzwg2F4TViC5V+TWW7ksQirA81Lav46FWWPC1EoGmfJcZlqjEk7zzHNnkeRfyZzY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6655.namprd10.prod.outlook.com (2603:10b6:303:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 14 Jul
 2025 13:24:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Mon, 14 Jul 2025
 13:24:22 +0000
Message-ID: <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com>
Date: Mon, 14 Jul 2025 09:24:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250714063053.1487761-1-hch@lst.de>
 <20250714063053.1487761-3-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250714063053.1487761-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b35b37e-3008-4cf9-1c85-08ddc2d9beda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW0rZXVDWTkxc0xZcmE4WjJtNU9OUm40RnRucit4UzNGKzVmR25uMzBOY0RK?=
 =?utf-8?B?MTU4U0cwR3hFcUloTVA2RDR4UUlzMlJjRU5iVzNWQUV3Q1RWVEFYekJMWWNH?=
 =?utf-8?B?eVJqRnk0M3NyRHZZQWRzMTRTa002WUNQOE5LNVZxR3hiakY3WEtmYXlUK2k3?=
 =?utf-8?B?dWdzMFY4MDB4KzYwMWtsOWhQa2dCN01kcERFek1pYldoLyt0eU1ISDB4YWVS?=
 =?utf-8?B?Z2phQmVDK1RQbTRNTjRKMDM3Ukk4Q2VSanVYa05hQW1wR0d1WUdmbnZOR1pK?=
 =?utf-8?B?M3pTeEFpUEdXb0dZUkVXSHIybFRsWUZiRHFBbWgvaW0vU3lJcTM2Z3B0Y1RU?=
 =?utf-8?B?SDBEQ1dMSXlXQmtVcWt6ZnROSWc3ZTRETFdJSXpaVmlXMlBreGFtekIyRm5x?=
 =?utf-8?B?azNGSStzNHhOMzRNbFFaZWo1U2RRNGk1cENjeTFGQno5TVF4SURBcndaSnlP?=
 =?utf-8?B?d0VaTDdHeUJ2UlEyTzVsREIvNmNxQkwvTHFwL1p1ck4vSC9URXNHbUUyMjVE?=
 =?utf-8?B?Rk9SSXEzeGYyZDVRY24zb1l4UG1DdkRpRlB2U0ZQNlRCZGRtMDEybk9VbGEx?=
 =?utf-8?B?MU5SVDNWVnNTbHJ5ZDdxcit4QUlpRlNCNUM2RXNKaFZtVWJYM3ZEbkVTTmVW?=
 =?utf-8?B?T05kcWFnQ2JtQS9QOFkvMlVXcVFpMDY1UnVndi9YQU1iaDgwZzJlSDdERUhK?=
 =?utf-8?B?Y3lqc21Jb1hPTkRVV3dUVUpQYmEyUUlsVkFML1BGaUlubjRCL2NhMGtWNlFI?=
 =?utf-8?B?R1lMUEErNHU4azlrenBKZ2xLQ1REcUg4aG1wQ243Qjh3dW5TZmkrYjMzV01E?=
 =?utf-8?B?VkxQTHd0Znk1VFVRMjhFd00vR2R0a1V0UVlPY1lZSDlCOUpRazd4MFNldmpO?=
 =?utf-8?B?TWVGNTFKYmlFckFWc1cxRFJub1d5MVBHN0tMcm9WdFZORURZNDhKTVpYYURm?=
 =?utf-8?B?QXBzbFBvbFdEeDE4bHdlWEhHNFg0WFpnaXBUcGQwdUJxdFJ3QXYydmhGMGZP?=
 =?utf-8?B?VkNTUWZJT09Hd0ltaXBMS3JWTTNWNUtidVl2VzNhbVl0anVqK0h4dnlmKzI5?=
 =?utf-8?B?aWpDNkJuMlowcld6OGExVStvRTd3SHJOWVJ4VzZXcXljTTRVRHpkK2Q5c2lz?=
 =?utf-8?B?MHhLUXY2aVR3Sy95SXFMYjl6aU1TM0ZHNjNYcUR4dXFQUER6MVhFKzdMd3Vw?=
 =?utf-8?B?MlVmd3Ava3VOZWQyaW1mWVpodjlNMERiM2pseTJhc1Y5WmZsdmM1NlZ5WFpa?=
 =?utf-8?B?RXFJSlZMdlVteEJQZDBCUmo3WmRUNjFWSUlCNTVkWE8zRUorcjNIRmtkd1Fv?=
 =?utf-8?B?OG9TVGMyUjdLcGJSczltRm82eWswWUVBZXFzSXpvRGhoQlJqTGpaL2xValZm?=
 =?utf-8?B?eGxhUS9jQkwxa1NsbGdtK21QdDBhRTJBQVJ5b2ZQM3RDTldWeWkyeHBBbG41?=
 =?utf-8?B?MkVBK3haL3luS2c2Y0YxcEh2QjBITStOaTVEQ2RlaklaU2QrNEg3WE1wdEZM?=
 =?utf-8?B?Nndxdkp2MEdEck9rcTV0VE8xVXNwTHF2eTZxVXZQcloxc1NYRUNma2NGa1p3?=
 =?utf-8?B?NG53RG5SeEgrdWJxMkNzWG5hUGplR3h5akhXVTd3bGtlZGNRSHVucEZHMjZl?=
 =?utf-8?B?MkliSTN3VDMyOXdwekJNZUxMc1dpb2lFMjdVTElibjhQY3hPdUlsQTJ3STd2?=
 =?utf-8?B?MDFKMVh1WlpQaXVvb1VGL2Y2cEI5eWNwMzN4cnRwRWRqQVVmcmw0U3piVkFR?=
 =?utf-8?B?ZXVRQ0YxazgzcjY2azFZVWVLQ0tzelVOczEvTU8vTVdKV3BNR256S2JoaGNq?=
 =?utf-8?B?ajRnd1NIYWdLdXR3VXYvSUJIMjgzSWpTNll4d3RuN000V0JYa0dNVEdoYXRX?=
 =?utf-8?B?QWJ3UnFEMk5tUWZCY2ltZXlobngrcHlNYmZFYU14TWpoOU1hMHBTNHlQTDhC?=
 =?utf-8?Q?lH71/98nowM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFkSkV6Y2VyVG12WHNvaFpEa3JKNUJhaTkxNG82VFRwdG5PYk1aOU1XclBl?=
 =?utf-8?B?VmZNcS9iRitxT3p0Qy9oeVBrWFZsNFFPYWhSZldsN1BQN0IvUTFnVWtxVDlN?=
 =?utf-8?B?bXZIQzUzZjdqYm1qQS9USGd1ZGVhOGNla1E0RlBkNTJrNXNoV3oxRGRwcTRl?=
 =?utf-8?B?Vm4yekJHL1FMdnJTOWl0OU1RZWN2bzlMTDRLL3dzUWZDNmUyY2crYlh3Q3kz?=
 =?utf-8?B?OFgyL1NKWlhBamgvUU1la3RaUWtYNlFaeHV1Q01XaE9mWk1WSlhUVGJSQUNL?=
 =?utf-8?B?bzU5TVVKZEN1aGFnZGVJTjlkQlFibk1BUVpuZUxnUGU2MXRKR0FIZ3pkMkMz?=
 =?utf-8?B?dmpQektTc2RneFpWYS9Hb1o3VUxweStpdVZ6a3ljSTBsNDJQOVpJWWZaWm1y?=
 =?utf-8?B?VDkrMWlZa3VCY1kybFd1Wm5KMWhxSWRRNUN1S1QwTk1SbStMUis1Zkx6emE5?=
 =?utf-8?B?dXlTL0pvaUJiZmdpR3U0OE1xR0ZqVXFOTC9STm1pNlEzRXYzdXdwNTVJcndJ?=
 =?utf-8?B?SXRxdzQxRFVZMHNINnd1Mktwb0lTK1UwTklpSUlPeVpTYitLT1VVVzNsZThI?=
 =?utf-8?B?N1d1d2JWRXBGUTJOWnh2aW1Cejl0cU1WL0ZEMVora2VxanZ1L2kraThwWmwr?=
 =?utf-8?B?Wno3eGlxMzBJU2pDdG1FYWUvRjJBNEFrcTB0QktXQ1VyWHZrYmNiMThndmNl?=
 =?utf-8?B?OVR4SzlseW15eDVBVG9rYUZJSVBBcW8yWU1IajZ4VE5Bd0o1ZXNsRW5ScTd5?=
 =?utf-8?B?NU9KeDF1bUd4Tm5mTkxOUzRaZHo1bGhmRThkTjBxTS9jdWl6RzlxaDFsTExy?=
 =?utf-8?B?MEsyamVJY29KZ1FlWjloK3BmaUl5eDZkMXprSGNBN2hYLzhNYUZ1TUNEc05l?=
 =?utf-8?B?OEtNT1NYb1g4dnhrQ1lJVlRwMnN1ejF6eE9pVFUwbnJoUXQxRFRGckd5Zk1h?=
 =?utf-8?B?RFYyRTdzVXpBSjhoREE0NXgvVTUvUDRkdTFQVGZtTTduTUVLV2JoWmlLdWp6?=
 =?utf-8?B?WHF1cWZDWklMTDJEcnp2NVpXMXVFbUZ5YWZwcFIyYW5YT25KaDhUMFI1cFRx?=
 =?utf-8?B?RytWTCtGTUp0TXNEL3FzdFYyeU5XV1V4Y1JyMG16dnU2Rk4yWnBaKzl5Ym5s?=
 =?utf-8?B?aTdlYVpFdHJkeDVnejRKY2M3L1JnWTFoOXNyZzVzSWt4NzJBbm1GeGIybUQ2?=
 =?utf-8?B?VlJyTVhSOGRzcVFCMkNqOGl4aXFxK3Rmb1pvcHhmcmozVnA3WGcxSm9TS010?=
 =?utf-8?B?TmxoZlRoVnFZcTRLakV4RzlIUkQxUGN1Z2g3clNSSlkzSFA3dW8wYmJ5d0lv?=
 =?utf-8?B?ZWN2MjMwU0dsMnZCb2QwRXBBc3k2YTFtek5TQzBsT0RuV290TTJwQjRLUnhy?=
 =?utf-8?B?Wmc3RURLTWo4NlZwQUpMWWFCVUh1VXgycEZXNFd0YWRYeXRManhZWlhBUFZp?=
 =?utf-8?B?Yk1acGh6UTBMUDBhUmtSeGtBb3ZGdDRWWkZLZ2xMWnZDQ0VaNWpCK0FwOFJE?=
 =?utf-8?B?VzNZUDhVam5neXhucW93UXVkeWVIVnZWVHlhdlNTOVdQUE1kRWFSUnMrS1Jl?=
 =?utf-8?B?WjkzT3pia0xybkp5b3FIT3dnT0xEOEMvWjRwWExzdXVuUTZQUjNmSGw0Vjgy?=
 =?utf-8?B?dW85MlRrcGtTNWxGRm1YdlUrVTQwRTF4b0dURDBiSWVpNk1TNE9OSkFneGxI?=
 =?utf-8?B?eUh6R2lBR1YwbFcza1VINitJQlV0dUtQRVNPOFo1QWJzQnhFNnRVZHhvMGRs?=
 =?utf-8?B?Q3VuMmszdFVXdVFkaXdzNjZmekY1N3hVOWVhbVpPbTh6ZUtENW1XNUdZbjBW?=
 =?utf-8?B?SmNWVlhZT3ZNRVZhbDkvSER0ZkVIOUxjbEY5VUhqV1dWL01pVVZYTWlKa0Ny?=
 =?utf-8?B?aDVCOVZpY3VwV0p1S2pUVDBINndsd0tEU3NiR1ZVeklPbFM1VWpHTXBHUS9H?=
 =?utf-8?B?VjFLUU5MSWV1TXB1aDRvWkdVdnI4UDE2ZFQ3SWtTaU9pSkFtcVRhYmZsZjIx?=
 =?utf-8?B?WWRSV1FVV1Joc1N1NkRNRWF0Nm9IZnhSN0kxV080ZGR6RFNlL2NQbDRlUEEz?=
 =?utf-8?B?RGthQkNTY2FqTUp6K01UZWtnUjBqeWJlTEFYSUo3dy9PMk1ZRTR2bm9VanU5?=
 =?utf-8?Q?JxAMtOqaZTsJfCm90hHiP2TPM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SBESM3HaptobFy6rWlvass+tAWXEDd5dYbI2GAu3BS9vGhaawS5CdGGt3m1y9QMWOlRpItJV77bk9qrRNVXPcKuwbGZelsBvM1eWEIqJRIBvX+g5a1DNc/22Pgg4wBp7bJxu0tptD66jRONVBtr1PCxLo7WQgCsnmYIaBBslJpcPUpOVnNUFzcAiCe/Sd+/Mn3ZILpt08AMFbkCnya2nDyQmvC9kcHYDreLYNkCmGXS7A7AJmqyD0++DeXHaySRpn6LkG3p1Mde0fNun4922Dlx6UDCN8NFBL/U0OaHSnzhw35n0tRwhd16GZh6nsBLjJzBnotiCNRbNyLfP5tc2Cm/MOuQWKTagTMzvvh3sTbPTjXO2xON0WFNJKOUEoHPpQuGiGv75nbTvGaY7FLkxhm5fU0rLOsO5rUVlYaQb+h9GN5lhFAQU+lwhh4on5OzoHR/NZwvl76owDbikg1ppj5eylFBS1m48Xzks2DPWCC92adWL/CmfCBj/LRQN+TliE7FCCbkyQLGF/UQR7qxm237K3WngmkU3rBOV0NtQFfEgzOgCdxcGIJagRlsZjkGFSu1CjeUaeiNMU5oh09R49MfwhaIqQdK306R1SWol2dA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b35b37e-3008-4cf9-1c85-08ddc2d9beda
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:24:22.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6tDiOBizTAbQXS/ShHXfDRhC6cPjIfSpJ5EAl7uKkmlfoaEP6sL/2KFZM3yv4v/zO7orAM9kMwVwyvvKhxzpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140079
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6875050b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=mtLONepLSAKKzMgfLKoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: puO39aV99CX6_ePAejt9zAi6pX26YBk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3OCBTYWx0ZWRfX3myLgfLzyWzQ TxikUI7+VQbQnHtUBR6zLm+8HxxJlAvdkMH1HduT9Tpjsj/PHfZjgYkCnCEtGdF6s0m7jlb03EI Uz+Rk9Vy5C8AsszZCW06PSps+Drr/I7YLrgbJ8kxDlsCzhhHjQAoHSKqZIMmlxWQl/DzW8v/vfn
 ioBY2Uv22ieZ8darUpzve2dHy5ekd5iHyjqCS0QgL8eabUiXh3msrg43qdfgcowyRRdlvh1VWaN B4H7VXNf8waeKLU/s3IZGGApeuKDvcZfLAIM23ae/7igUiD58+ySQiVq8rbGW98zJ5QAWNMZo6C Gv4kvb2AzKs6X1ulXM1KivyPHKPNuVGB7M/YPXl3to+Z55ZyJlcRYql3cIiKu+eXg9fnlTcqB9t
 jK4QaT7hmtjkjaxZxE2PE7CV0Q1iOIlFrn2dIaA9WIuE01tU9XqvaXs19npKqNQQb260GOfp
X-Proofpoint-GUID: puO39aV99CX6_ePAejt9zAi6pX26YBk6

On 7/14/25 2:30 AM, Christoph Hellwig wrote:
> Add a mount option to set a clientid, similarly to how it can be
> configured through the per-netfs sysfs file.  This allows for easy
> testing of behavior that relies on the client ID likes locks or
> delegations with having to resort to separate VMs or containers.

The problem with approaches like this is that it becomes difficult
to manage multiple mounts of the same server. Each of those mounts
really cannot have a different clientid.

For testing, why can't you use the per-container clientid setting?


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/client.c           | 12 ++++++++++++
>  fs/nfs/fs_context.c       | 12 ++++++++++++
>  fs/nfs/internal.h         |  2 ++
>  fs/nfs/nfs4client.c       |  1 +
>  fs/nfs/nfs4proc.c         |  7 ++++++-
>  include/linux/nfs_fs_sb.h |  1 +
>  6 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 47258dc3af70..1a55debab6e5 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -181,6 +181,12 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>  	clp->cl_nconnect = cl_init->nconnect;
>  	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
>  	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
> +	if (cl_init->clientid) {
> +		err = -ENOMEM;
> +		clp->clientid = kstrdup(cl_init->clientid, GFP_KERNEL);
> +		if (!clp->clientid)
> +			goto error_free_host;
> +	}
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	seqlock_init(&clp->cl_boot_lock);
> @@ -193,6 +199,8 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>  	clp->cl_xprtsec = cl_init->xprtsec;
>  	return clp;
>  
> +error_free_host:
> +	kfree(clp->cl_hostname);
>  error_cleanup:
>  	put_nfs_version(clp->cl_nfs_mod);
>  error_dealloc:
> @@ -254,6 +262,7 @@ void nfs_free_client(struct nfs_client *clp)
>  	put_nfs_version(clp->cl_nfs_mod);
>  	kfree(clp->cl_hostname);
>  	kfree(clp->cl_acceptor);
> +	kfree(clp->clientid);
>  	kfree_rcu(clp, rcu);
>  }
>  EXPORT_SYMBOL_GPL(nfs_free_client);
> @@ -339,6 +348,9 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
>  		if (clp->cl_xprtsec.policy != data->xprtsec.policy)
>  			continue;
>  
> +		if (data->clientid && data->clientid != clp->clientid)
> +			continue;
> +
>  		refcount_inc(&clp->cl_count);
>  		return clp;
>  	}
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 9e94d18448ff..fe9ecdc8db3c 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -98,6 +98,7 @@ enum nfs_param {
>  	Opt_xprtsec,
>  	Opt_cert_serial,
>  	Opt_privkey_serial,
> +	Opt_clientid,
>  };
>  
>  enum {
> @@ -225,6 +226,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>  	fsparam_string("xprtsec",	Opt_xprtsec),
>  	fsparam_s32("cert_serial",	Opt_cert_serial),
>  	fsparam_s32("privkey_serial",	Opt_privkey_serial),
> +	fsparam_string("clientid",	Opt_clientid),
>  	{}
>  };
>  
> @@ -1031,6 +1033,14 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>  			goto out_invalid_value;
>  		}
>  		break;
> +	case Opt_clientid:
> +		if (!param->string || strlen(param->string) == 0 ||
> +		    strlen(param->string) > NFS4_CLIENT_ID_UNIQ_LEN - 1)
> +			goto out_of_bounds;
> +		kfree(ctx->clientid);
> +		ctx->clientid = param->string;
> +		param->string = NULL;
> +		break;
>  
>  		/*
>  		 * Special options
> @@ -1650,6 +1660,7 @@ static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>  	ctx->nfs_server.hostname	= NULL;
>  	ctx->fscache_uniq		= NULL;
>  	ctx->clone_data.fattr		= NULL;
> +	ctx->clientid			= NULL;
>  	fc->fs_private = ctx;
>  	return 0;
>  }
> @@ -1670,6 +1681,7 @@ static void nfs_fs_context_free(struct fs_context *fc)
>  		kfree(ctx->fscache_uniq);
>  		nfs_free_fhandle(ctx->mntfh);
>  		nfs_free_fattr(ctx->clone_data.fattr);
> +		kfree(ctx->clientid);
>  		kfree(ctx);
>  	}
>  }
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 69c2c10ee658..1a392676d27c 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -86,6 +86,7 @@ struct nfs_client_initdata {
>  	struct xprtsec_parms xprtsec;
>  	unsigned long connect_timeout;
>  	unsigned long reconnect_timeout;
> +	const char *clientid;
>  };
>  
>  /*
> @@ -115,6 +116,7 @@ struct nfs_fs_context {
>  	unsigned short		mountfamily;
>  	bool			has_sec_mnt_opts;
>  	int			lock_status;
> +	char			*clientid;
>  
>  	struct {
>  		union {
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 2e623da1a787..3ab5cc985224 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1153,6 +1153,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
>  		.xprtsec = ctx->xprtsec,
>  		.nconnect = ctx->nfs_server.nconnect,
>  		.max_connect = ctx->nfs_server.max_connect,
> +		.clientid = ctx->clientid,
>  	};
>  	int error;
>  
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index ef2077e185b6..ad53bc4ef50c 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6487,6 +6487,11 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
>  
>  	buf[0] = '\0';
>  
> +	if (clp->clientid) {
> +		strscpy(buf, clp->clientid, buflen);
> +		goto out;
> +	}
> +
>  	if (nn_clp) {
>  		rcu_read_lock();
>  		id = rcu_dereference(nn_clp->identifier);
> @@ -6497,7 +6502,7 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
>  
>  	if (nfs4_client_id_uniquifier[0] != '\0' && buf[0] == '\0')
>  		strscpy(buf, nfs4_client_id_uniquifier, buflen);
> -
> +out:
>  	return strlen(buf);
>  }
>  
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index d2d36711a119..73bed04529a7 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -128,6 +128,7 @@ struct nfs_client {
>  	netns_tracker		cl_ns_tracker;
>  	struct list_head	pending_cb_stateids;
>  	struct rcu_head		rcu;
> +	const char		*clientid;
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	struct timespec64	cl_nfssvc_boot;


-- 
Chuck Lever

