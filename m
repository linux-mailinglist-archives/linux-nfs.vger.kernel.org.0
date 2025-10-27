Return-Path: <linux-nfs+bounces-15677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00FC0E38D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1CDA4FD39F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEC306B1B;
	Mon, 27 Oct 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7gUdZlr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xa5bm4PM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2D2874FB;
	Mon, 27 Oct 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573276; cv=fail; b=nFLtl8ANxQVUlwH0AQPU3nGLXnASuRasXXiQrFoWtuQEmNih00kbNgjYOpX92ARe5YBjEkyl+iBSUXNqKFRFjz8SZbDAakhbHhhUp7sHfMysuHWVGEFmRWJmQREAAfHNMMjnDaCmvEVAl8Scf7U4R8oLeEKHB4HlwPanphDpigA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573276; c=relaxed/simple;
	bh=Thrl2DpVeIqHqsVChw+Gv/uuEIi9+rChHbbqiHojVtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOvxJwVzzcC8o03Pvi11K2ELfDp31lXPpeVUCQTLspQQEtQDj410QB/BhEVFft2HFxkxsPXLU44xj1VnS4ZddzA2oVZMHEmPCs4iiVqp4iuVY9bwuxQQoA10rVGWPCbi4t+ttrWHVXd63sGblqmbHE+irCOksO58ZwPZaQP54tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7gUdZlr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xa5bm4PM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYAq8013863;
	Mon, 27 Oct 2025 13:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GiSDjCMKKR1AyRFxEbvBLPfCcMLVimNBX1aPDNgleko=; b=
	i7gUdZlrlZu2UJZtfirND3POyaJPFY1WUIdwSyvkNdFQwRh89tLvup9YCWnCq6XS
	+jgJsilobegS4rNuTzI6x51IKBXdBkLea7zu5Z+3QRiDG+nOU/o7zL98RaRc6K1w
	iGeUQzJF+V72/Ui4dOBL8g1EwESA49j0gRo8xLn0CBR9IEDMrkFKbWAbMEKA/Im7
	ux7HEpeoH4SNs1YgBIzkc2SzNXBTqiuhJuY7fSiu4+C1keSOUzINIlyWJk3Z7ZrN
	WevojZ2rLd7gZYD7Pdd6c3x+nSbirCvzWEWG+5H8DDZuDfLsg3najp8/8jbIY89U
	Hqjiu6FB+RVwKMxY8HuBFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s3emu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 13:54:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RD2EGO035587;
	Mon, 27 Oct 2025 13:54:14 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pe7f4m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 13:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIjDB3OHdVYuLRpMtYO8sSmjcLW4WvdrhAfvauZrw6yH+e1Z9qZih1mlUHTFtMXQvv346Riy/MxlTD3SKLwPqO8jT0TUn1yUnRZuyjiGBjUhoVqgVs0SYRx2nA3hNFiv/5wzI7RlvextztPZ2iKo+oMk9wk45m0fzRUb7msHwa7Zuo/pv5UHpua4kMMadymafxrSyzyWPI5DkN7ELDGuWjx+q23MDUredOAyRqL0avVDi5Uu+sMJdxqCi8RFAQKY+vJzxaiit0nMrnqaNVKB4fMRQnc1O+VhnnEp7pNUJkH8OSSLWz4a6jltgpCmW1jNttjuvUsoD7g+7aII47CXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiSDjCMKKR1AyRFxEbvBLPfCcMLVimNBX1aPDNgleko=;
 b=Gl+Uo2TtQrnaQNm2KJVagkBqqLlzB6SF9/ManGYOKUcUFrrGWFuN7XOLlAUkANb9pQZxbuac5fCPyGkNiwMb/kBbRbb30F9V29eQH6/mgGxSD/5ws05+HxgWIdP3+6orcrz7aNY6YqrLKExO4Myt4dBfgONiwzjjqUHPkQ8NYgy10FPBr3XFQZBQ14iUtibLV9BN1GL0UfW0jAhmMMN70ZdHlChfTSKxZi3vC+7VwTERuIazkYjbvDXfNJUGuBnX4gZG8ojocxf8+o10oFXwCykDuiH6C58Sodr4h6xMfKELB1HGFoU+iQ2xLDxZ3LKsyoe8/jath1ptBkA0dCv6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiSDjCMKKR1AyRFxEbvBLPfCcMLVimNBX1aPDNgleko=;
 b=xa5bm4PMHPDO8EvJZ2PNrD58kW183v+BhES5K+2PYi8h1cZt7c6hg6nS/ee2dQyrQQUpa3fQZZHSMLt+q1cOwVpN1qmCoUoqnbj4Ul0UK87eC7/x6Ue1e0QCqZhPv35uoA/p8ukHKWOABJhRT4Z5uBqg13ZLMiFLC/qlL/1yMkg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 13:53:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:53:59 +0000
Message-ID: <fc196a91-4cc3-4fc3-a728-567399cc8185@oracle.com>
Date: Mon, 27 Oct 2025 09:53:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdrgen: handle _XdrString in union encoder/decoder
To: Khushal Chitturi <kc9282016@gmail.com>, linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khushal Chitturi <kc928206@gmail.com>
References: <20251026180018.9248-1-kc9282016@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251026180018.9248-1-kc9282016@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:610:b3::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aecaa38-2d3f-4082-d9ed-08de156047ac
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?REs0RFJOZWtHRVZzbHVwRjJ6dWtmbC9sclZ1V0IrY3c5MzBJRmh0dG4ycHpZ?=
 =?utf-8?B?U0ZORWI4TC9kM3RobjFsVitOc2hROXNHQnppdER3eWRmOXlGSDVYTHJCRG1p?=
 =?utf-8?B?a1ZTNHRVenJwbG8zMWcrZW5tRjZjbDlqMU1uQzB3NHFGQmVJRUF0M1dhL2p4?=
 =?utf-8?B?U2tPaUllSm5CQzJBYkIzZ1dycTdyL00rYndGMzdWVHNzMHNMUkc2VlNaaVdu?=
 =?utf-8?B?c2M5dmozUStWVC9BQ3ZMRTFTQThOUU1iYTJBZjZITGphMVk1ZzMyNXNnZDk3?=
 =?utf-8?B?MmdIdUdLUHNJRmhBalplMnhHVGRYdnlpUHVyZWJQeXRmak5Id3NLY3dESlhU?=
 =?utf-8?B?Q0xKMXVqU05BUk1SK1ZaN2xiRWppWkp3SStJdE56bWZFT1NtS1lPVEVaNzdM?=
 =?utf-8?B?azFJdkVmc2NWS2dyRXlrZDRTN2k5SUdyQ0FlMUdiay90ZjNOcloyVzMrT29z?=
 =?utf-8?B?d1RGa2VRWWkwa3BmN205a3VsNnNzWGErcE83UTlaZHcyQkRsTGVEelVPTFVJ?=
 =?utf-8?B?YTljbjhMRWdSL1BKMTFEeTZ5M2N5eUt3d1hxSG1KSUtYaXpJMktjSEpOYnBH?=
 =?utf-8?B?RjJiWkpqc2pLcjV3L0Z2RC9BVGtBb2F1VTZHN3U5dWlmKzNpaEpVcUwxNXJQ?=
 =?utf-8?B?enRyNUY3ci9mVmpBRUFhKy9yNXorZHRiVUx3b3FHaGlFRFc3U2NISzk4bzh3?=
 =?utf-8?B?QUVZQ2l6a01wZm1wd00vY2ZkSzUrbTN6bUd2N05WRFZEMEpCaTlLTUtPT1Z3?=
 =?utf-8?B?a2Z1QzdsQVFOTnFxZERXNXRJeGJDMUJROVZCZ2R0Z0xrZjlDd0VRUkdQNitB?=
 =?utf-8?B?YkprS29nT0k2R2FRQjZraW1UalNOQTNPcFM0cEVOcWRicm5HUEEzM1kwdlN2?=
 =?utf-8?B?ampzajJ6dkNlMFhKQjhPUWI3Z1F1V1NzdVhFSkNTWjhLTzBXOFltS3h6K3VK?=
 =?utf-8?B?VlFGZlpvMXRBNlo5N2s4UG1wRlp3MCtCN2FmQXZnMldzVWIwdy9rTTI1VkJL?=
 =?utf-8?B?cXA0T3JJcjExbUxUWE9NbHJZVkZ6dkgvVkQycGduZU1PK3I1dUhoMDNha21Y?=
 =?utf-8?B?TWhaeUJETXFuUlJRL25qMWNmTGp3L3RzTGpSRGdLb1Y1RThUUmF2K1oyNHVh?=
 =?utf-8?B?V3B5TVRuWmtpQXpxeWltRmdxSGtZTkY2SWR2TlpMSE9xZWU1cFIrQlJqRHZO?=
 =?utf-8?B?cU1hMEdRMmpsQkl6clRaanpjMzR4TU5rSkxrSHpUcjE5ODgySGpLaTVMWk1i?=
 =?utf-8?B?ZXNOMkxRYWVEM2htaGtDTm5jT3RHY2pOQ211NEtLN0cwQmh1ZFRQRWpaT1M2?=
 =?utf-8?B?b3p4VW1PenRKQi9Ka1JPMXpTMWF4bXROZFJVMytIRmtJWnRranVrVkZiY2Uy?=
 =?utf-8?B?Vk9DTzBRTUhXRGFxVHZXdld0Z2hpdHJtQmp0NFJOL05URWhrazlxNHZMRjY4?=
 =?utf-8?B?NFU5VGYyby9NZ1N3L3lla2I5NEJwNmZoMWVqVnlrUGI1SzlPYWl1aHRpLzRh?=
 =?utf-8?B?Nmt5Z1JYWEpqb25IY3lBcXhtSWdmQklHS3JsRS8rS1d6ZWl1WVJXUlN1T1Bt?=
 =?utf-8?B?MzVXdy9wbmFzWTROa3ovTGZsSTdyRDZzdmFmbVo5bWFHRUhHdzZCVkI3Vlhz?=
 =?utf-8?B?UUVYekRTdHVrS1JRaE5YbkFVVVZZZEQreXhUTlV5ZURFTmNlaVZkWFZUaVlx?=
 =?utf-8?B?akZvMmtYRzM2cDJOVEFmTzZKa2N1ZHBNNHQxY3hhL0FSaFB1Nm1nWjZCU0M5?=
 =?utf-8?B?OG5oaGRqZkVxZWNtUWdTZGxjczFkS2hXWjQ3bUJPeXU5RnFnWFRhMkVFc1Qz?=
 =?utf-8?B?THF5MG8vRFladmV1eTBLRHF6Mm5kOW5wT1BpUEkzbnE2NFhobEpmZzVyMjlu?=
 =?utf-8?B?Z1NOWTJOSUJtNDhRL1JUMEdKRlFnWXBIU2s5QlRxYlg2eDlibUkwVjBDUkhV?=
 =?utf-8?Q?39Wpm5JHbIq2gv9jfL4h5zDrZi+aXNRS?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bitKbXdRWjltYW5KR3pLMkFmaTZSZkhSTzhlUHFmSS9mR0Y4L1l3MHRncExK?=
 =?utf-8?B?OFVGci9WOWlScGhUNjNNZ0d4bFZPOHFVQ3NxTkJUNHI3TEFVYlk5QWV6MExC?=
 =?utf-8?B?aTM4eC9KaCtSb3ExczRuZTBHTTliMmEwYXRMQnJweEU0QWdrbjFmaUFzdUhh?=
 =?utf-8?B?ck0yK2p5dllLc1ZXNFFRRyt3RFRnbCtkekl5R3prNVJZaGZkakNQcU92TktW?=
 =?utf-8?B?Y3BnUWFkUzYvY3FyVnh1RTR3QkJQaXcyVUVMR3JHQXpPSUM0dDZ6QUpnVFZr?=
 =?utf-8?B?eUwxL1ZwOWFWdGlKbW9QZlFTM2s1OWZ2N0t1SjVZR0FEOCtGT0JsdTFmeWt3?=
 =?utf-8?B?TW04SXNEUFc1YUdPeTF6NktraFBJZzFLaVNwOXRCRFh3c0xWS3FpWVU0OVlE?=
 =?utf-8?B?VTVuSE9jeFp1aC9XQWl3djV5ckVvekgyZ0syMGFtV1pyRWt4V1F2c3ZiMW52?=
 =?utf-8?B?Qm1FZm16K1JvZ29hNVZGM2lWUlNmMmtrd0lKOWhaWWVFelhtaDk4QW8wTU1q?=
 =?utf-8?B?WHFBOEVuU3QzWWxDVWdES3Jmc2NxbFV4aHNiZVlVMytUbnE4UDNidHF5TXVl?=
 =?utf-8?B?Y1RvNHBxTTRHSW5iMDhyL1ZVS0pCUWczTm4zd3ZNdFJkSUpLOStRR3IzTFBM?=
 =?utf-8?B?SmVJcHNKYmM3ZFRrT09TbWJaSjdYUVowTzFxdXh0eTJPcHFta3F3S2FVaVZL?=
 =?utf-8?B?VFZ3SzNjRHZVK0ZGeG14Wk1YeE9XQ1FSQlYrNVRpclRZVUZTdDNQWVJmWEJU?=
 =?utf-8?B?bDhWYWUwYXpsK0Z5dGkyVkhrWDhLVjVONDRxR01ueDZ5YW4raHlaWERLTkU2?=
 =?utf-8?B?MjJ2cjhDdWlwRndXSHJpTmtnN3J4NWFRc2UvcWNka2dzMWJ6b1lybmVTSnVN?=
 =?utf-8?B?OWlLSENMeEtYU3BZZjNZbUF5REVpTlRkTGY3cGxkVlltWnpVbnV1M012VzJ0?=
 =?utf-8?B?ZWJ0VExDSU9BQlNTbEg3Yk9YejZSKytlUXZwN0tDLzkrMkhRa0VINTVwc21D?=
 =?utf-8?B?MUJpaTEzeXlNdS95UmNJVkxVcW9HemhMYTFUU1lUcmJTZzRBV0pMRDd3WmZJ?=
 =?utf-8?B?elF1WDlMSS82QTM1RXhJOXQ3VWxvNDAycWxQRmJLTmZYNGo5VFZRYWVTWVJv?=
 =?utf-8?B?R0dqS3lESFlpcjB2NWxEb3I5eU0yV3dESEFoWEVYQzVxT0ozUXBpWW96NnJw?=
 =?utf-8?B?YWVGaHk3R2s1UGttY2lpTjRmYzFPak1TR2VUd1JUZjB0MWplMWYxVlJCUmp5?=
 =?utf-8?B?RE9JUEhtK2R0dkVudkZWZEFHNnMrbkExWGVOV2lSREZOOXc3bklhRklZRUJD?=
 =?utf-8?B?S3FOck1WS2tYRkFVeWxzYUZzUnNNTmd6RXd0eE9TR0hURW9RdlV6NjNnaWJi?=
 =?utf-8?B?RGxYUDNuOTV6dGYralExN2xvcnQ0ZFFhcUpmNzgwWko3RCtGQTZ0OFhxdVJz?=
 =?utf-8?B?ME9qUmZKNURJdWZ2OUZibTMyeVR5OE5JaXlKTkFOaDNyWkx6ci83NXI0WGN1?=
 =?utf-8?B?TXhtekZYRGNvVzd6Z0lSRUx4QWQ0UVBjWVdYc1lISjJSeGZ3WVUzVm5kQW5K?=
 =?utf-8?B?NnlGNnorMzB4NEl1ZEp5eXNxQUFJVExNSkRTVm1HY2VCL2x6N2VQRzJTR09X?=
 =?utf-8?B?cVV3TUNwQlZrZkFLclJTdjVpTklhV3dvazZIejNkM3Ztd0JCYmdHazhWc1Fj?=
 =?utf-8?B?enVUTE9LbFU5d3hGZTl0aUNLWDNXUUQxbnpHV2xxYmNoamNja2hoOFdjMS9W?=
 =?utf-8?B?YkJBd2wxWEtWaTluQitkL1BlV0RrSnlDaXFPK3JqUVBleUNVRmpXeTdXNkNh?=
 =?utf-8?B?S2drTWRRczRjYkhKeFdVdHoyTzgyLzM1c2tpVFd2NFY2SFBPR2sySkJNeTR6?=
 =?utf-8?B?RDNndVJqWjdZRnJTOHB2SDZUZUFZejY4Mzg1bmlqV3dxQzlZVkNUS21qektt?=
 =?utf-8?B?bzdBUm92KzVQMEYrUUJtR2xKVFN3eGtGelJOZWZzUHZCUUZ0TkdEc3RaR29n?=
 =?utf-8?B?bzhYVXVrMzNqaUtyVUdqVHpqMTNEVXp3NGhsUjRoQkJ1VzFwM3pqYVQ3NkFh?=
 =?utf-8?B?MlZseDA4bW1IeUhkNjEwRTc5R3RFdkRhbHkydTZhOCt1K2VXSFRLN2U1OFd3?=
 =?utf-8?B?eW83RGZxUmRPa3VhUkVQR2lZSUFTYzFrei9TdWhhRGJmVVJkWEp2cXlTaXVP?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	50xek/uaalgW7KzjQ523Uu9zi1I93amHHlfOQI6aWRiVmC3Q+crLgCGOswc1B3xZRkQOtLrxW5My1XYu3L67Ouyq0LBbrwXOkw6Fk6XS77D/ywWvn5EqjJkxfO0uaM82ZlEk8HbfIJwTOvOx9pYdIAbq0hoW87SQal1CVab64fvTQ4fwzY9urF4bfeFyjWqEKCF+lltMnJcZTTgoIQzssQbSjZGdCXFa/pJTFp430+Uh36NVUXb9cbLuzmm7Y+OkOdseLL6DqV/OhwWvIpz70UF5b9kZApA8RpefQ40VMjX2UlLRIFsVu+n+S1CMaYZrkl0CjGJ/HGSylw8GPYG1KxdQlBfYJJ1LIiWXtxKZ0I+1fndzGO0SbAs7vIL5pcw0ufURtd2Y54NCAxMd6R/HZ7JsCCiAkjo1qf7MyffnM9bumXRLXU3ljxk69ciT7PMicJxKM90L0wqRzRCpidfPkapzLyvDuq8KztNn8P0ZjucXOgiEjUq84Xi8mL4lfZx9WzIqmjHbxYdRN3BfE9Yt2YjxxL3MelcuGcTV/9e4mjFtWlcIhP2WAMArgrdcJ2kLkoj0Uu1dYskmxYQb6vwNEAqnf8NOnXvwdsenskqwZK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aecaa38-2d3f-4082-d9ed-08de156047ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:53:59.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FpZtBoqs86BKs1acDL0fNaLjirh5fuaTB+xJd5tVRcVF6HZ0jWQNvKjZyDzU+Og8fPNqVUn6uffsQEGlhzbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270129
X-Proofpoint-ORIG-GUID: OT_CNT7_v0jyqbsdBr4rpxNT2bwdEY6m
X-Proofpoint-GUID: OT_CNT7_v0jyqbsdBr4rpxNT2bwdEY6m
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=68ff798d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=ccYws7Et1ft-umAtUhYA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX4u4LngTCcQzT
 qPvYrJ1Jqdlxx1YPUW8ZOeF01AmZs1MkNdnBY5lcF7/5vkBIFILnZF7XbzezOk8T/qyxPzinORG
 AaMmgksw+dXQoDW6vTwpdrZ1HOePfunS1vdCrTJTM0/gtk1/ka7bpBuUW3zI2yM0k2xuqKYYzq0
 gH6pf6bFcRmBdn4NRJortqBfLgxJv1w5tvZFx3o9GZkpKsRfqvucatnuYTWqLykBQPfN9K8Xb93
 oJt/v2D0D0bAgy0K42dgubz/1tmeH/MBAK1IIN6HRPbAvxdRXsCTOFujJ+lXPPgWYIsRTyG4yBB
 nuy/M15JruYbMEhS9D6bAtJipNY42mKU7t/UI2kAT7kNTPxXcqgbLaw5jvMJQ/nQ2hENnoY5N2v
 vANQ+oacr7jvE9wN37vmr69Hik5hkFJp8Evh+0i+iHhnDhJ2AqU=

On 10/26/25 2:00 PM, Khushal Chitturi wrote:
> Running xdrgen on xdrgen/tests/test.x fails when
> generating encoder or decoder functions for union members
> of type _XdrString. It was because _XdrString
> does not have a spec attribute like _XdrBasic,
> leading to AttributeError.
> 
> This patch updates emit_union_case_spec_definition
> and emit_union_case_spec_decoder/encoder
> to handle _XdrString by assigning
> type_name = "char *" and  avoiding referencing to spec.
> 
> Testing: Fixed xdrgen tool was ran on originally failing
> test file (tools/net/sunrpc/xdrgen/tests/test.x) and now completes without AttributeError.
> Modified xdrgen tool was also run against nfs4_1.x (Documentation/sunrpc/xdr/nfs4_1.x).
> The output header file matches with nfs4_1.h (include/linux/sunrpc/xdrgen/nfs4_1.h).
> This validates the patch for all XDR input files currently within the kernel.
> 
> Signed-off-by: Khushal Chitturi <kc928206@gmail.com>

Hello Kushal -

Fix looks OK, but there are a couple of nits: The email address in your
Signed-off-by does not match your From: address, and I prefer if you
would keep the lines in the patch description shorter than 72
characters. Can you send a v2?


> ---
>  tools/net/sunrpc/xdrgen/generators/union.py   | 35 ++++++++++++++-----
>  .../templates/C/union/encoder/string.j2       |  6 ++++
>  2 files changed, 32 insertions(+), 9 deletions(-)
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
> 
> diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
> index 2cca00e279cd..3118dfdddcc4 100644
> --- a/tools/net/sunrpc/xdrgen/generators/union.py
> +++ b/tools/net/sunrpc/xdrgen/generators/union.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #!/usr/bin/env python3
>  # ex: set filetype=python:
>  
> @@ -8,7 +9,7 @@ from jinja2 import Environment
>  from generators import SourceGenerator
>  from generators import create_jinja2_environment, get_jinja2_template
>  
> -from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
> +from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, _XdrString, get_header_name
>  from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
>  
>  
> @@ -40,13 +41,20 @@ def emit_union_case_spec_definition(
>      """Emit a definition for an XDR union's case arm"""
>      if isinstance(node.arm, _XdrVoid):
>          return
> -    assert isinstance(node.arm, _XdrBasic)
> +    if isinstance(node.arm, _XdrString):
> +        type_name = "char *"
> +        classifier = ""
> +    else:
> +        type_name = node.arm.spec.type_name
> +        classifier = node.arm.spec.c_classifier
> +
> +    assert isinstance(node.arm, (_XdrBasic, _XdrString))
>      template = get_jinja2_template(environment, "definition", "case_spec")
>      print(
>          template.render(
>              name=node.arm.name,
> -            type=node.arm.spec.type_name,
> -            classifier=node.arm.spec.c_classifier,
> +            type=type_name,
> +            classifier=classifier,
>          )
>      )
>  
> @@ -84,6 +92,12 @@ def emit_union_case_spec_decoder(
>  
>      if isinstance(node.arm, _XdrVoid):
>          return
> +    if isinstance(node.arm, _XdrString):
> +        type_name = "char *"
> +        classifier = ""
> +    else:
> +        type_name = node.arm.spec.type_name
> +        classifier = node.arm.spec.c_classifier
>  
>      if big_endian_discriminant:
>          template = get_jinja2_template(environment, "decoder", "case_spec_be")
> @@ -92,13 +106,13 @@ def emit_union_case_spec_decoder(
>      for case in node.values:
>          print(template.render(case=case))
>  
> -    assert isinstance(node.arm, _XdrBasic)
> +    assert isinstance(node.arm, (_XdrBasic, _XdrString))
>      template = get_jinja2_template(environment, "decoder", node.arm.template)
>      print(
>          template.render(
>              name=node.arm.name,
> -            type=node.arm.spec.type_name,
> -            classifier=node.arm.spec.c_classifier,
> +            type=type_name,
> +            classifier=classifier,
>          )
>      )
>  
> @@ -169,7 +183,10 @@ def emit_union_case_spec_encoder(
>  
>      if isinstance(node.arm, _XdrVoid):
>          return
> -
> +    if isinstance(node.arm, _XdrString):
> +        type_name = "char *"
> +    else:
> +        type_name = node.arm.spec.type_name
>      if big_endian_discriminant:
>          template = get_jinja2_template(environment, "encoder", "case_spec_be")
>      else:
> @@ -181,7 +198,7 @@ def emit_union_case_spec_encoder(
>      print(
>          template.render(
>              name=node.arm.name,
> -            type=node.arm.spec.type_name,
> +            type=type_name,
>          )
>      )
>  
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
> new file mode 100644
> index 000000000000..2f035a64f1f4
> --- /dev/null
> +++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
> @@ -0,0 +1,6 @@
> +{# SPDX-License-Identifier: GPL-2.0 #}
> +{% if annotate %}
> +		/* member {{ name }} (variable-length string) */
> +{% endif %}
> +		if (!xdrgen_encode_string(xdr, ptr->u.{{ name }}, {{ maxsize }}))
> +			return false;


-- 
Chuck Lever

