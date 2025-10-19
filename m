Return-Path: <linux-nfs+bounces-15388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C15BEE800
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A49B4E40E9
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D82E7BCF;
	Sun, 19 Oct 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2TTSGu4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q3L2WWpj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FA1DF270
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886097; cv=fail; b=Q5WwwAeFWhOWmQZC8zaTdCwOZo9zldMcqB6VSolesnSiUB+wJs4ovY46pcwUrvbZOzfepXEc09qxbh2vt2GaIDAvdJxTtkfuXek/LiJ+zP95uKmcVtULZxwcoRDeW7SgCCX8I97Vc4BoelWSvAv1TrIOFG35yioHlL+uWkSvKLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886097; c=relaxed/simple;
	bh=xfQ/4s7AVjZOqYaAgN9kckQzBz1E8B6DT508gj9fOm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RORGHxvyYZLMToQ6Pp7unkGPV9j1bI8ze4IThjPuXXtcxf3j+fdsJjFyj5t9qlNRxQyFRdsWBQeme/AnlG6rcYO0b7aeycadf9XOkoOob4yx2bzaSPQ7H1yusRsoesRnrxmz9VGK3wa9LVc7AaurM5TgKVobyBgKZtthzZ6v+38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R2TTSGu4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q3L2WWpj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J5GLsg025978;
	Sun, 19 Oct 2025 15:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OftYuR0vo0d3sTn4N+jMaCsDIdYGSrjzrw2RGqK9PAY=; b=
	R2TTSGu4RlZLwsfBWQhbl+yWnSUkz7tDfbQFm2RyNxQJSV+2pg/d4S7yZ47tMoe5
	a9Sa3Oo86/ehNvLB4/fglhS13FZr4gqfSKS4z+xGQu+t/QNWMsF3fxZbVfKDBYjC
	Wb2hyWiSh30XikXezhf6aiBQcyuJrOI0IH5fi5rYaAswntuyU2Kmi5IbaVvv6gax
	bnnAt9K4gM9AYi2llupEEL55S525Iae2oSIdrCDcFERZqxzVYN0TsmgGAegGGUbu
	hJqgrWiyqZATAmlvvDLolqHBqwp/aZKNEByxFBpYzZ2otYgrvJZmCLlotbN+FFNz
	yPBc6Yqxf+goDwikUrAp3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yps2e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 15:01:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59J97hIw013665;
	Sun, 19 Oct 2025 15:01:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9xdq5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 15:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZEmJrinn4Q4VI9owbJkoY6CYkmpCovdI5SS2C3GlPFyrafqwtGmaBpLNSdlzb/GOJPVGncS49quw7dY6kcVS1HQWrlCveLA1ekPIrq5jJMykvwgyH6NR/3Y4YqUQv327V1pO9W9q/QVMcPCbI+t2eGRCpJ2dSIJHxmdbCtd5MjJVMnRgoQbvfWO8FykBBV6iX11O5xr6PEXNyhq6Si9QC57MgxVSXzU/k9nmcP06WEDWiMvBRLwy9ZuCTrIbaFMclCVK8NtVMEmFfYDE36094UyhHiK0+26LkPa709PHEYvA2sFn3OtStyha5wU9rQfXL7k7eqDUvQ3xrVrjY+HTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OftYuR0vo0d3sTn4N+jMaCsDIdYGSrjzrw2RGqK9PAY=;
 b=FmeBpej5bZApce/k3ocagnS7hYIBI+Vl14yngkzIq1EOl9RSEDVFWOwNMwKOkrn/bGJrZL5QccE4gEp1hGNllCgxOlmmuLk+jbYLxFMhlGHDfKa83thJZ4dA6enE0FwM6/1nd7KTjz4RZYnnqYRYEnjjp8c4F42pg8K7Gq62jR7IMD+Xy8yCKHJBENE6tH1HAiNrl+YsTwoGcjqGBNN/THYiSsE46+pTo+YN4KEGKtcMrmbo0EK2xEcFkOQaKYHYNBGLLuZ4MFFQ4DqIP9IWoaM8U5XiiWefcA97Erd42OquOzl8xofWU0cfjyRlExyGrPdHWfA4aSJ9ZSiVrXps8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OftYuR0vo0d3sTn4N+jMaCsDIdYGSrjzrw2RGqK9PAY=;
 b=q3L2WWpjKFnDTps7cZYgcLKLrC2MR5SMDteVHS26wPPPjz7NWOv0nQtFyoIWMTOJaIy3Ku/w4Y53dLbOe6GkcEMNuyxaaHZhChjWUl4DttbXz1SJzMOT5YvJHml42k94KKRdKF/S43w5b6WJJcVB9lQzCU3M47NPo+nJ8np+oVc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 15:01:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sun, 19 Oct 2025
 15:01:21 +0000
Message-ID: <e33efa39-2a6f-4724-8fa0-bf881dca01a7@oracle.com>
Date: Sun, 19 Oct 2025 11:01:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
 <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>
 <176082518104.1793333.5226398922398910122@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176082518104.1793333.5226398922398910122@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:610:77::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: c17af03a-4517-4d81-6c4c-08de0f205d84
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aEU4WTV6NVowUHZkTUd1V0U3RWpMOG95dGNpRmg5SjBVTUF2OFBJN2N5S0dC?=
 =?utf-8?B?aTlaRDhRMTIxS0VUNzZreUJxb0NCTENkUUZEd1FRM3lNZ3dZcGhsQU80dEYy?=
 =?utf-8?B?eFphL0pvMERyN1VvcWl5LzlFOWZkd1NnSjZXS3hnaGI3Zk8zS1gwMUx6Nnhx?=
 =?utf-8?B?S3NaSmszQSt6RDAxU2VRdU9CRW1JUlkzREwzS2taNm1WQWFWWmFLZithaUow?=
 =?utf-8?B?a2s1V296SUF4WDZsNHhqYXdPTkEydTFtMlRjdTBDcWxDNHJ3RmtEODBTMlgr?=
 =?utf-8?B?M1VQcmVqZWU0WmRaenJuUWtKaHlDZEcrZnFpbW4xZ3hSTmVBSTl4QmlqOFYz?=
 =?utf-8?B?bDlOUmpEQ1VLbnBBb3E4ckhlLzFRTHNablF2V0sxU29lYndLdXBIUUhlMjdm?=
 =?utf-8?B?TzFJWWI3SU0xOHZOUCtYYXlJd2tJVmVIeHFNNUFWbWZVN0Z1L0x3RkZlM0dH?=
 =?utf-8?B?ekRGUkk3dHJDSnNFclBUOW04dmdJN01ZeE5KYlhlM2Q4bnNJbUkzNm50d1Vu?=
 =?utf-8?B?Q1FwOXBXZ296andDTVhueWR1TVhmckVZNXZ4SnNWUVg2OHhsaHI3bnp5TzRN?=
 =?utf-8?B?MjhQU2tvRVdSMzY5ZmorOVJmTloyT0h2Nkh5SlBMVkR2cTJQQ1dEQ2RYeFVh?=
 =?utf-8?B?STk3Qm81OElodHBkQThLS09GTnVyVmZJcXhSRCtiM0dlbDVMWkF5TEV2TGwr?=
 =?utf-8?B?Q05OK1c4YjVoWlNkRkFUeGxiQW5iYkFLWkRrdUhFVCtOMWd6OS9TeGVKaE9F?=
 =?utf-8?B?MHo4eG9PaWs2SFZ4Y3FYajBjWkVWVTBaa0pqTTJvaTlhK2t2VzcyWGVRbDFS?=
 =?utf-8?B?ek9vU1NXVkJtOTNxR09nNGtQMWZQcHhqcG9OeGJhUVdJRzhzaDBwVTNEYXZh?=
 =?utf-8?B?dlo2dGJBWFY3VGpqUDlrSHJXS2g0YS82bXlpOWZPK0tjbGt4UHNra0tlekRP?=
 =?utf-8?B?aFBuSjg5RWZqMTBrZDFMRWF3Y2tSdk15em5SdmZsWTBOUHhYNzBraklFd3c3?=
 =?utf-8?B?cG4yOFJvcUo4QmZkUnJsdEQ5UjhVYUpSSDdjM1NmaEJiNmZaTnhjSDcweVVY?=
 =?utf-8?B?cmhRZUdDQUltUExEREM2V1FtZW1WV3lxc05aR3dXaTFNSmJCTnJudE5IdFpD?=
 =?utf-8?B?Rk5nZTVnRWRBMFRyek5mYXZOTFFPdDhaSldrWXZ5RTMxSWpVWStLc0RHSnRV?=
 =?utf-8?B?M1hiOFl1bnFNcWFnQXJRMUJmblMzd05PSjV6YWs3N0szREthZER6TWY4OEVO?=
 =?utf-8?B?dE10MmhTMWdMNVAzT1pKdUJCam9NUVZJS05CZk03akFaQXJnazZRUWkrYlJO?=
 =?utf-8?B?RFBhd0hSNE50Tjk2NWoyZmpqS25MRVlMNWpTblRraTVWaC80VndCYnd5anBX?=
 =?utf-8?B?bG9SZk5aY01ERXF5eTdrUXBTaVAybTVmL2tRTUlETm45QUhsNEVISnVBQXVp?=
 =?utf-8?B?cGdIOGg0VTlScEdyZDh6SmJzd2gyVTlhSWFjYzFNb0JNNEhZcFVOOWh6VXdR?=
 =?utf-8?B?V1hEWlVTT09CWEoveDc3QXMxcWFIZ1JJVHNYQjRZUzVOb1ArT01aMk5oVE1o?=
 =?utf-8?B?SEtrYVVoTmJSNlV5NHFKdWYrZjUrQ1dCLzVsaHB6ZUFQM0ZteDF2d3dGWFNy?=
 =?utf-8?B?MnJGZmhKQjJLTkE2aHdkZkVFM0lxclB4dEc1LzdiOGRKVHBwSEN6WFQ5Z1lp?=
 =?utf-8?B?NGd6cU9XV2RTZk5XME9udE8zVVMycC9LdXBZdkpvYXlDMjZpKzRMUTI1clM4?=
 =?utf-8?B?alpTUmsxbmNyV1NRQ1FDYi84Z0U2K3UrcUdtd3UwSkZnT1MrV0FxWE9CRVAz?=
 =?utf-8?B?dGdNMGpMbWtEWWMyaEhFZGpja1htb29teGV4eVFZTFFUWFc2OThNUG8ydnU0?=
 =?utf-8?B?QU9JV2ovWkZRZHIrYURVZlA3eVZocWFpRmJuR1RidllVemh3NEtUUmJpSDA2?=
 =?utf-8?Q?FVU/ENFNFQokgSrQY3rzHOPAyc6wzn/Q?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MlNhTmMxbVV4Y1N3dDV4T05jdmlPOWVMRE1yNmh2MjhGY2JjcmwzU2poRGNP?=
 =?utf-8?B?dEZmck9Jd0xuamdiMW05MVpvd3dEcFNNbE1Cam1tcWg2SHpFZHNBSnJjbXQv?=
 =?utf-8?B?cTN4VkNnbkNrcHpTYXF6UDJoY3QxbFRzVnRMWEZSQ3lLeHRDTHBROVR1YnJz?=
 =?utf-8?B?Mkd2UFdrZWUxMGtnNWpjRmc1ZmJjZHpLNUdJYVhqbDJNY2owVm9lUm1GN3NZ?=
 =?utf-8?B?Sm9SMmd3YUJlcmVSU1RSNzZnRG5SbE5RVXhoaXhRbUc0Zy80azYyTlFQdkUy?=
 =?utf-8?B?VGRQUkhqc1lKbDU1QjRaQXJ3ek9JMDJvMjEwQmJVU0ZsajZ3RklSVjVCOC9j?=
 =?utf-8?B?eXZEM1hLc1pjbElzTGNHb09HejdhSVcyTkJUMWNhVUdOdUw2WmVWYUF1QzBy?=
 =?utf-8?B?T29qTTM5V0pYOG55Rmc0VjFPckUvN2F4QUphODJxcUh3OHl0Szg4RUFiSWs4?=
 =?utf-8?B?Zy85bmJzNnpWODdSTHNQZG1JdHVRV1VsNWljK0ZNcFRKcUVmRERISmpYR3h3?=
 =?utf-8?B?TGxqVlVmYXhqczJHeDBCdkZkRGlJSlZnSDR1OEUyak1WZE1MNjNlZG9qYy9w?=
 =?utf-8?B?dWhwZFdQK2ttbVhTZnYwNFowdDV0SzhKUUw0SEU0QmNkdGpsUlh3WXZ3bnV5?=
 =?utf-8?B?TWd5alRBcDFiWDZDMXpJTVlvN0x5L1Z4cDRuQUJ0dUE4cFNMSmVKZE9UUFIv?=
 =?utf-8?B?OWY2R1J1WVpUT1pKdmFKUWZ4RjRESDdqbjcxMmk0anB2TVl0d1ovNndjek05?=
 =?utf-8?B?U1pPeXVNKzJKY1NGNUhXUFp3UFpUT20vTGsvQ3JjQTVERDBoeVY1WnAzeG0y?=
 =?utf-8?B?OFVHR2lLMlQxTGQ2ZGJGN2xMM0d5QVZmdXFCck9Cdjc0MWdtdGlTaEtpNDFv?=
 =?utf-8?B?R1BLVVNweEFRNVpFQ0hCazhRWUkwMWJPMGhGdW4xVE1DLzhLVlFHR0lEMWI0?=
 =?utf-8?B?S2VkY25wNVVER2pBKytQRW15VFRDTzllWG9qNE9xckhYT2FnS1FvMGhjQmh6?=
 =?utf-8?B?cHJHT1NsTVl1Ky96N2pnRnQzYWNEN2JWZ25oTWEvZEU5M2p2M3JYNnpIZkRS?=
 =?utf-8?B?YmZSK3VnNlgvWjZoNUFZTzFCQ3hXOExKOGhxOWNPcXBvdW53SFNockFMU1BJ?=
 =?utf-8?B?M1o0SlZ5c3BUbEdzM3Y0Z3FmanlJbXNtNHJWZHltNDBXZXVIT010OHArMG1O?=
 =?utf-8?B?d0xaL0pQV0dWVWRlY2FKN0JWa3Z6SnJVRnFZYitUOHRiSThwbEpIZTVZWDBT?=
 =?utf-8?B?c25tVDRZbG9SUFAyUUJPL1lOei9lTStyczlRRFIzMFU4Y294R3g5R3NtSDFs?=
 =?utf-8?B?Z2ZoWFllWEV1aVNyTFgwYnBpWHVrenZvdTBjdmhwTis0VUZwcVlHNmxmVXF1?=
 =?utf-8?B?ZGxsRnpIRFk3WnRhQy9RWWpBR0ZaYmViQ3RKSEJCbmkxUDNWTFZZNEtHdkMy?=
 =?utf-8?B?aDlTWXRnS0RERFJPM0NCV2pydXNkenZ6RU53K2dreFBucndDSml0SDhpL0o4?=
 =?utf-8?B?eWJVUGRnb1Z4b3Z1bUJmK0piSTBOSVpVNW1wSEl6SndHa1RSa3lMOUV3ZU5m?=
 =?utf-8?B?VUNHWEFEcTY0Y1pKcmJRZWlZNm1EdVRIQnJmZWVLb0I1NGxoemMzbHBTcTdF?=
 =?utf-8?B?RlVwNHBsVGhHeEhEQ25aYmJ0MXNhTnY2bVAveThINU5LekNNd0FPZXQ4OVkr?=
 =?utf-8?B?bXFsR3ZQcnRQbEtpamdCRCszYUVKS080UEVCNE9ZYlV5NjZOVVQ3RG5JQ2hD?=
 =?utf-8?B?c0NFV2VPZUVmNTZISHpGWldqYThzRkpKeHAvNUFja3FSbU56ZnZNMmhQdjBZ?=
 =?utf-8?B?Qzh6cXNMZlpMOERpbW9INStBUkEzMkxCbm93ZHl6aGJuRDVRQmtTdEIxV3Jh?=
 =?utf-8?B?cnVvRjUwcmtFMTFtVURWZURIdFZrb3RrNXJLc1YvajZpaGZMWi9kZk5lSzJM?=
 =?utf-8?B?ME8xUnc1M1VrQ2JZSkk4Q1crWUpOOFFoalRxTzMzN2x0dlROQ05OV2c4dG9W?=
 =?utf-8?B?L0JQbUhWUkUyRk1oc1BVY0EyUkIxcG4rYXlqM09jQUZlSlhyMWFZLy8xbFcw?=
 =?utf-8?B?WDdjaUlCalJNRERtV2hNK29NZUE4OGRPNGE2eFJFU1pDVEZzNVowUzJ4UnRm?=
 =?utf-8?B?QWxoclBxaU10djh6Wm10N252WVNlVFlkOVFFeERRaGh0QVhzM1EvVXFFS3Zt?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ie95tIA679J5KW8NKmLuWPfGhPK3dLfK4tqlrHCEGMz12xE3Dh8pprHIY55QcAuQeJ6qkKLmCgjSHz/fMiKBocZgO9lBVJSPVSSd1WjXb5LdeOb3uqbLoV0g6MnYKP90tda0Y38IZPO37xkNPSvZ550GEbcTA5byrXChzkpGsLPmF2p9MsKxxoDBQyet0aZKA8VnxvCcpde3NGB0vhUX45rpSkxm8mnd9+9r40FRkhgqARKNS0sE4/fEhYc24VQaJrecJVcRrPMoo3EKA7KGxK4eu6cNzLFIDEwHXLgZ7oqaovfZeCDYQ58oltvzp+ZAF15jhk1477ZNFkE9TEZ5QIZieTYkMHfcnefUvMM6WqykbdVA0uph2ArDX7vspli0D4twuN4RlshQy507YsWHr0V5Z7AORzEr6+3llccSRdSVsI0ak5GWqvz+tpqGEzHe9uladIKVcIwf8pgu+mjqpeRwsnTWuHcJ+AuB3uiGAeWGPLZ4wZNBEm/NITxhiur39wesMNfyYK6Tj7n/Xyl23e1hyGFIMSoF0AyQZ5cjb0oL3d9yQaKr+I6qSq8Bj6uCO6myiQmZfoQcfl6Qgxmk7NUknI5cIb+gu8HdtF/TAoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17af03a-4517-4d81-6c4c-08de0f205d84
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 15:01:21.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYHiZUWQO6xSOPA3khUy5/iEkBM7s3cLfPB2gSCPNN7ov5vg5K+HBYZXq0YLJ+aLYRWuiv/Urw+VMbSzQwfWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=946 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510190107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8N3P34WX2hqH
 h1qEJZN1NFkBztOL3lDKLT5YkIxn+ICVQDrPCK8CZebF+6cNQHaQ7edGRdfCgbpzwuL8DP04zLZ
 r4gMVE5T85UrGAyfYq+nlO1Z7+BlkDEm6sw3jAnHpwVMlxJ3vnMJwPaPfKJHOQUrpY89GtGcjSW
 wgVnE9kY/dokAWShUzrWvksIn2tCf9Do+pCg+8B6lot+fsu01IWDUzTvt/Uu9ll/z31xDDGMWiM
 +cMSUwi2+vjKedRAtNojs2M1MtWDxhE3SgCwf79ZBUvnnGsIp6V5QU5DqtElYJnIhY7GcGBOZ8j
 BADDAH5zj5KOXiW0PQT1A90bmG9ft4dxcA6VgeEwpht3QiWTHvE/+NldyzyHwynBE10/Kc9+82L
 fWvC2dYjIbmOhkgroxqM0BbhCVagwg==
X-Proofpoint-GUID: BnvjK1WBoWp7r0TYdN76SspIXqtbMldm
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f4fd47 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8xFZBpnyYfZWzDYAnM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BnvjK1WBoWp7r0TYdN76SspIXqtbMldm

On 10/18/25 6:06 PM, NeilBrown wrote:
>>> I was looking at this code a while back while hunting for a bug that
>>> turned out to be somewhere else.
>>> I notice point 1 and 2 above and thought that while of little
>>> significance, I may as well fix them.  While examining the code more
>>> closely as part of preparing the patch I noticed point 3 which is a
>>> little more significant - clearly a bug but not particularly serious (I
>>> think).
>>>
>>> NeilBrown
>> I wonder if this patch should be split for better bisectability.
>> Are the changes to the *ppos calculations dependent on the RCU changes?
> There is no dependency between the various changes.
> Did you just want the *ppos split out, or did you want the 1, 2, 3 also
> split apart.  I considered that but wasn't convinced it was worth it.

Ideally, since you had listed three items in the patch description,
there should be three independent patches. But if you think that isn't
worth it, I'd be happy with the *ppos changes in a separate patch.


-- 
Chuck Lever

