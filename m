Return-Path: <linux-nfs+bounces-12367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13446AD7142
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF863AF269
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D4230BDF;
	Thu, 12 Jun 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjQc6AMq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NNErOQ+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06D1B0F0A;
	Thu, 12 Jun 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733831; cv=fail; b=IYDTtq3LFiFRPNIFx4iciltlX1UVT47iwJd6k4hflf03cZJ9icsiRsuHJIXk6sa4AKRoV1n1Bk17OtPtLP0NQbUNuk+uQ8Tw2gEMTGPa2UCcpdGVTJzQYKRLOIm9bu5HyfhGv8PbO4D+T38jofoSAcBfeabANTNKhb5Z0wK1+8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733831; c=relaxed/simple;
	bh=d0rh5mWYwyQHzcCOFEvPjAAc0Z9wNoT60dJ8tusEZDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HimQhWvzBFf3nYeOyQbPR8UYoNQ+bp3AUApBV6wYBcC0rSi9PuHh4FvHA0LOoplvngLTp0UoSmDzCuhgIeDzaphksLAkN6ZD8iHNXwq1hRRsuf9WoWMG3nxMWPQ2NNMguA7KHxuaJf/c6F2H5pH+XCiIV+6lWGP3l8qL0vbhEMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjQc6AMq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NNErOQ+v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fq2b032035;
	Thu, 12 Jun 2025 13:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RuU/ij31QMP9uWbZVN45jgrmZpRxAKvWEJxzHMd5lnQ=; b=
	AjQc6AMqz+g/IAWYwtUIaC+2MieJzv+d4KPS3BsR6HUjc7d0IAiEnBk30soSFPsc
	Mt5ZtcjK8qKTxGEwSDlNV68KJXBCLjhElIQfPvYrQAhFYO4OgKHGiXb9wAu37SaK
	6NEv+a7pE8BHgE9d7j7itXMUHZeM7jlF4yG9i2BJvac30B2KV/1QccA3VSnNpnXd
	Roj8NnJa206r0LrhJ9wRLG2I+UlVGHvwywEwxNA2FjAR4G51QSrHvDtEv6ts6Hdn
	1/tUJH/1ShJ4MK4SBg55YKDngGfGO2EaHRO0/+kc9WV2Z7VPmTYSxKdz06UQ8ale
	oGcemVuG3WgyJs9er3YuPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbehnps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:10:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCR9vw013330;
	Thu, 12 Jun 2025 13:10:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbas1a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLD7K9lQ7IuS+5AtCnhzNwR8qu1VWdVTXczWZ2lzB7l/5/fs/FWehc/lKTUM4A8bxKlaHVbz/WS0082TJKUlfK+IFvbY+hb6Pjt5mHa0VKsbDbCvuwZ9OdkmUTeCQiVuvG2uKC13EoGPj0VMZR8bjd19hPtNXoWbUtA3SlYcibtr0+SOGWiEt6W1q4RzYkEv5g2hkUfxX02YKVJdqx5agEm6C/6ueHhPjFot2uxtNgobXo1uAqVpLz5UEpfdr9IIZTWhGbdtUqOYbLjhFNoIipVncKeknKXjHbUCWy1NZ5WH8cg/0O3WHyfvLupB19d8VBJfKqRbJC5e2FQjGNnIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuU/ij31QMP9uWbZVN45jgrmZpRxAKvWEJxzHMd5lnQ=;
 b=cN+FXCKXi5iFU6Fvb+ggCfUJ9ZMzPW9Np/s21ngaola1lnlh0gGzfWINr2ig92P5hsqruGlUen5z9Qcz3QR6D2dGy9I8XU0TPkcmZ141Cz9kOy0vzv3DV1A+Nt1b4xXRCZsTx08cmLzMWIwKepqaqwHgdL99PsEKMRLMygL5VoKQ4LmrchBq8zx5cX17hDTHABsS592ufANN5d+kbegEawuVJAvP1oQztnv/Iiw+1chipv//7UmZFdYAXjIGFo9liMdACNwu/4EioNrrf9vw8+g5C6ayQsAaWYIWK31xBQvXf0q8gqu+wtq0Dc1SOoK1toTzlou4jNWTL95QJJWCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuU/ij31QMP9uWbZVN45jgrmZpRxAKvWEJxzHMd5lnQ=;
 b=NNErOQ+vVinRZsJiOhV2QgaXlx09vRvjqdp9fa9bJZBAfGJMNNheVySc8cJuwRIeu1b4bnS/YEkhMr5YNM7gDMTRnI3K/TYcKuEsZT1C7/b8qWme9wTPbQWb8vyfEQFIPVHo3SpvBUu5BGpYfyxIHotRtgHrkBkGkNbp0etgLos=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7085.namprd10.prod.outlook.com (2603:10b6:510:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 13:10:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:10:13 +0000
Message-ID: <1951a618-a35d-4515-b4b7-131880a780c6@oracle.com>
Date: Thu, 12 Jun 2025 09:10:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Use correct error code when decoding extents
To: Christoph Hellwig <hch@infradead.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250611205504.19276-1-sergeybashirov@gmail.com>
 <aEp6-T8Oqe2dI7of@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEp6-T8Oqe2dI7of@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac85b3-f365-4b8e-68f7-08dda9b277da
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WS9Nc1JibWswQnZHRzFmQjZIWjdoejVqeGxqTUFvbTFEVDZFSVdJR0pvU3RN?=
 =?utf-8?B?cXg4VFJka1Fjclp4cVc3b09vYm44WWQwemxnVVhaaXdQNFZuMkdsWm1xYWU2?=
 =?utf-8?B?TXpRRzcycDhYUFRNZkpibHNweFBiZ25JdWRoVEtUU0N0d2RHejdvb0xaQ0o2?=
 =?utf-8?B?YlFNTzMxNVNCK1FXd3oyNG4rTk5PK0hHM0ZzbXd2RzVNdW5Oc1JIMFNITWFT?=
 =?utf-8?B?dWhiOWlzOEpzcUYvL1pRSUZmamFDc2RuVUEwa2p4R1N2OFhwNFlMTFlqQzc3?=
 =?utf-8?B?cnJLY3hKeEsvaXdFekRKSzhvamFLV3ZlYk81R0YzZ29heCt4NzNKaXY2Z25t?=
 =?utf-8?B?bUE0TTJDemxjbWtxSlozN3ZyS1dZY2hTclNOVHJldWMwTTRJTDhTbHhEbUVm?=
 =?utf-8?B?c3grVklBR2xSOGw2Y0NFSUxOelVIVDhpZm5Sd3IyckZ5QllYMlhMTUlGamYx?=
 =?utf-8?B?Ui9IR1MwaytES3RjTUVmYm52WjYvd00vdnhvb0tuVG5xcXNnQVNPamdESldq?=
 =?utf-8?B?WEQzUkF3dmV0c0lIMlJkb1c4cVdwVW9URG9FUFVOeVpvTlV4U015K0ZKSDJ5?=
 =?utf-8?B?VUVlQ1g2UTlIcmtXZVh0Ym9PdzB0K1FuVHRsTUhyQjJLS1VMeXR4aklSUlZz?=
 =?utf-8?B?Zk5mMTJxOWQzaUZ0MzArLzZOYkg3R2paV2NydTVSNi9WbmJWWTdMQXVFc1l2?=
 =?utf-8?B?aFNONG51Ky9FL2NpYmhFVTlZQ0sxZjVNblpSVzFmWWdpVmxZYVcrMjVXYk9n?=
 =?utf-8?B?a0hrekNRakxuYWFEQ1JTOWtjZ1FmamFPWXNwMG5VczlFU2VEVUR3dGZOTWhF?=
 =?utf-8?B?VEpJcHdvQ2xPc1R4U1JyYm50dGwrcXIyaFpVb3RKUUJONTBacFlQVW15MU84?=
 =?utf-8?B?dkZtUmdkM3FmcGJpazBNazdvNUl5Vk9tQnJUNStZcjZaeGVvUE5WU3dBWmlo?=
 =?utf-8?B?eE9ZZE1LVW5QWjU1L0l0MHlJcFowRVhTY3E0Yno4Y2ZvUHY3VC9qRXY3b3dI?=
 =?utf-8?B?eURsS0FlZFpaTXZOSWk2QWZ4N0R3UjFIM3V3eE9XcUQvU0Z3TjBuczRsVHlS?=
 =?utf-8?B?TlhMcG9qaXp0eTU5WFZ1U1RtZktzYzU5eHFsaWsrSEdLMkJXZzk4eUNCNnNv?=
 =?utf-8?B?VkRxVlc2ZFh5TkVocWFBbUxZZkhpWWF5UkFYVzd2M0tjS09oZmFWR3RjMk5p?=
 =?utf-8?B?UmgycHpQdGdCczUzeDBIZUZwNmdXdHFSQUxyUVViZ3Rna1MyR1Q4UHhsNlQv?=
 =?utf-8?B?dWdpYWZ0YnRBM0JsRzk1dDVQaXIrV1lwY1BTMmxiRFRzU3NVSXVwWHE1ODJm?=
 =?utf-8?B?TVppSTJHRi9vWDhlNFM2SkNxVER2Q2JEd0wrTU9jeWM3QnY1bXZyeDV5TGo0?=
 =?utf-8?B?ZHdZMDVuV25lajlPSklFTG45d0V0a210SW80TGpBd2Y4cXplN05TMVZQeEts?=
 =?utf-8?B?UU9jcTlMNXFlNnYyMkFabWJNZGxKRXVud1RyOHhSaFYrZ2tET3VoZjZnS05T?=
 =?utf-8?B?YlJkRnRQNHJNTDV4aERhV09uSWczMDdDNU9hZm5oUERBdVA4dHVjV1hza2py?=
 =?utf-8?B?L3lnRlp1eG5OcXB4V0Y0WCtpem41V2R6dTNnOVNPVC81OUVUY09sR3JkMWF2?=
 =?utf-8?B?L2p3Y2M1STBtWEtFOE4vVi85VHJjMHZ3NW9sR1d6SEZ1VCtwcmc3U3MrenA3?=
 =?utf-8?B?TUlKMSs4SjBIUUxNWkFRTExIbjliZVYyT2U5MGh1eXdMZ05nNHdTVDRVYitR?=
 =?utf-8?B?dnJnMlZqdDQ3SnVhdVRObS8wNXFVaWNYTmtxQWpBZTZlMGlZeE93NXNBTlVj?=
 =?utf-8?B?dFdmdCt3d2JKQUc4L3dRMGFqLzJ4TDF4cGZzN2J6M2VNanBxd3NiZlRQZWdl?=
 =?utf-8?B?eElZbXJCekcxY0pLeVVHTzhHM0N6dE9OOGtQdFJjNk1LZnpDc0FEUGNXdnA1?=
 =?utf-8?Q?eIFe+O0j2JQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?azJOd3NPZFJYcFlHeWdFWmdKM1dlQjA4RVZ2b0taZkpmaTl4WlVGSE1rUXBH?=
 =?utf-8?B?dGlZak5NRk9LUmdnUzFvUG1OZi9BSWZNYkE1eWFPMmxLZVFsd203OTZRajFN?=
 =?utf-8?B?MW5raDc1MitDUThEWkxqcTFzVXlSWXBCbkhGRDdmanYvV1pPZnRIMzVEYyt1?=
 =?utf-8?B?VDc1Y1Z0U0ZONGV2L0xWSExjZlBCYmNUaVdNaHdnYnRwUld0UFRLaXE3VW9B?=
 =?utf-8?B?NFY3VWlFOW5wV2tPRWJlWVVJRThubjlYOWNQeHc1WFNjNkllWlUyYWlrdWlB?=
 =?utf-8?B?R2QxUEdmSXdaOTlzaUVaWE1JaHhIOTgwQlY0WnJWME9BZVgvb3p6bWlQTFUx?=
 =?utf-8?B?b0JlNFFKOEg5N1VkU3dJUWpzTmdiRCsraDNLaVdCanA5amhuM0NkcTdOVTRQ?=
 =?utf-8?B?a0RRZjlxbnBoL2dES0I2YngvNUxWVlZIVFh6YndocG1pUkFxVnBNcU4zRmw2?=
 =?utf-8?B?NHd6MUtqU3Q0ZFhVNHA5M3V1N2F5OUUxditzcXZCZ2hSUG1hWkxTZzljSklQ?=
 =?utf-8?B?NHNUUEQ5RTV6b1g4akY0djhKWi9lbERVZmtmZzJLOEFEVWxhcVRpMi9uRjNF?=
 =?utf-8?B?TjRQei9QV3dHMjlSZ05PUVBHbldxQWhtM2wxTGxaSFgyZUo1dFJESkpnU3JJ?=
 =?utf-8?B?cXBHa1hhR0IzWWxkN1NKWGFtR21DRUlVU01Oei9SQ002OURRUnd1TjJBcVpu?=
 =?utf-8?B?Q29yQ1MrU3V4cDRHSW5yZGJLblVLNTlFOTcyRzFYSE1Hck16Z3dFNFVYWFhh?=
 =?utf-8?B?WXNsS3ovVVE3UEVqRkllb25xNXY3eEY0bUwrZ1hPVlZreVhCUVNGN1kwNXMz?=
 =?utf-8?B?ZnM3N0Z1YzkrL29RV0pUWUsrZEVQbk1LQVpqb2RkRXpyMmxYNFFOeVljaElU?=
 =?utf-8?B?YXdjL1IvVi9OSGR6Zzc0NVJMUlViVkpOL0RtY0UwLzk4azFNNEY3amd3eGl0?=
 =?utf-8?B?KzdOTzRHbDRBTlE4Q1FBNk1EVng4TW1Ec25jdzNaa0RicWhKZkVzWXBRYW9Z?=
 =?utf-8?B?OCtocVFrWFhzalFiN1lpM0JBTG52RTVLdmRkVVhhKzJ5dEtzejhDc0xJNitX?=
 =?utf-8?B?UTgzUHlkMHArUjY0RHRGOGlMUzVHb01zSlkvdGFlRmlTWm9KV2Uxd29uQUZ5?=
 =?utf-8?B?UTFKRkxtcXRwbFhpaGU3R3NtdlFETEVQSG12S3dmU2V6ejBUUjlDWi82Qzhp?=
 =?utf-8?B?MHlIaE9WcEIxU3ZvVXBLMWIwNnhMY1lqR2dBUjRKeHJydWRtd0ZOV29CV3Qr?=
 =?utf-8?B?UVR0T25oVUd3WUVTT2I3cFp3VDNjZFYraHpPZ2hGTlBHSDdUeGsycjg4a3pj?=
 =?utf-8?B?QWlTV2NyZlJ6WTdxbG5iSVdBcDltYkw3Y1dpdTdxa1FjczZCcW9XSk9KdUtC?=
 =?utf-8?B?UURWMUxKbGkrSnFleUNGa1dXNGtrbnpRTlJMak9IcmRPTTh6bSs4SnhUcWkw?=
 =?utf-8?B?Z2hxYU1IQno5aWVHWDBKSnZ3YWZjTk9QbDBPWDNSVDJ5bHV1VW5WV2daMW9u?=
 =?utf-8?B?T01VMmxOajRmNFZDMTBYSHlBRjlBcVRhWnA2elFnRVd0UnVtbEdCbDd2OE1Z?=
 =?utf-8?B?anpsMmtkbjYxWFMyczlvOHU2bE1vUHlLd0Z5RXN3bStpK2F2QUpiZE5IcUdv?=
 =?utf-8?B?OVBmSlpLUXJMRzZvMnlxZjZRdU5SRThpaVdncnVhUVJnUXJORTAzZmNBYmJh?=
 =?utf-8?B?YXl1QWxwUTFOQXcvZ1dLb0h0Q1pqUUhxMDduWXhBcCtIZjJXOHJtOGI0aHJS?=
 =?utf-8?B?R2pPc2M1N2pzOU5mOWxjRHJtK0duVllGVDBoUjB6RnFyTnIwTkgzcGt5cEJ5?=
 =?utf-8?B?a2wvNFhwWFMwVnpwYzFYK21Hc2VUZHErR2JMUFQ5ejNiZnZTUTFNYVNhc1ZC?=
 =?utf-8?B?Unczd1BScW8zdTg5NlIzckxIMlpNd29yVjlITENVRlZQWlVXZWt6VnA1RFcz?=
 =?utf-8?B?TnZBK2ZMKzJDUGtkOUpIWm9TNVFVc2VMUktkVGUybEJJOGpzdkMrdG9UUXU1?=
 =?utf-8?B?T29EajNxaU1GL0kwQ08rOVVVR29rZDF1U1QzYkFXUlFUUisvUTJiU1BsKy84?=
 =?utf-8?B?dUF0R0N3aHNoRElVUlBGeWZmQzlnYmpYb1I3TGhVMEo3a1ZDMGU0d3NibkVL?=
 =?utf-8?B?THdrUlE0dXdiZ1pTZWlXbmhGOFBLTUhSODRBMmh0SWxKMExwSVNBUlpkMW9W?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jcNL1r6kQ3jUsH7tfEopZVBs7K4+6koZ+92E7VarrrD1q1vMV59CVpddstbvom74IUjWKXj/9ytwPSWkIWs4fHrQ9KjyWspgP24d0NvRJdCDSgMPPh6PF6gk2epKqzdxueoadiDDK2VI73iJUif1zeaRV2F2dFaKUoQpuQN1y1iDpdQ6/3U5a4qUEocXFgvQm0OSyB9Iz+aXJv6OINVrBVLW6AEUcfku8TcJBYVx+jQoOnKWzstl6APvO46XlqPjGmbn4sK+wQ1i7H/0M0Lz+2D80OaeRMPGxKOSNUpRvYLK7t1OLm3kpJHF82MVXz6YN3MmH87l8H3czdL8ElfcOi0VoYUYBNQoX4rESKcsNzAW6uUTFDgcjm8COiCj77Kn60ClfB+gTilsH/gnBqT3QfuYIeKdvkTjTB8Nn+S+pm7uVkrmCBwyAaq2m2EI87kh0p1A13OiFmfyaJLIrSq3denPB9iPnn9jexIRixOa04dhGHpBNJ2DMasX0bsXpgp062I+dOUIfAgoE1MpA66e/EHTVCNDvNQABzRpUZ8vfozJgjKmUhvr723bLMES6SBwkFcneYwnFbPJLM68H36sRPw79IVdk532YFD60nfaujc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac85b3-f365-4b8e-68f7-08dda9b277da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:10:13.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTP3A74i7ilULbICA0NluUb9R5wKCYaKyPl6TW3hl/9hVprop+vrzfzs70XH8Ohg4w2CekRUNoW5oiAQcQEMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=825 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506120101
X-Proofpoint-GUID: x3R6sqUcarBRpwgR5qOFvuefs6erublf
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684ad1b9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VdELoU_khlXGC6I73L4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x3R6sqUcarBRpwgR5qOFvuefs6erublf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwMSBTYWx0ZWRfX/ms2FdjKTEIG a6/4Mu6HfhiN2wqlVCHK1GgYmcbqj5TIz0RvtjMNKgt9dPMOytjrIYfeSBX4Ysa0IfX8IYGJlnG d9s77RYNeIzIYLSw31jvmWiRuuj7qeEpGwu5/2QVWXGu0CD6FONKqJELIljlJQp9yX14xuZH8ts
 Gzwq7tyvGLTEs5gXk/8klKj22awW0fNxUJP6YnlylYE7c5Vzs9QfowVkCjcBMYZj4G/b8hNJlr4 82NzSLgkWmUemyESMszSXo6yo4ivcmIoUWJOOBN9KZF8XY28mIy46IforVtZ2Ax1l7PuQrWuxi9 ir+/kQ3jmIun5jin8vb448VYqOtaL5X+tZOo91GgCNwcaEqwn6rii+naDxw9jzH6+gsk7R7ItNK
 Y2jMkZpITSq9EFneMgZDJJPq3v8Cg8UFGYxzkZB/WwniLKe7eddBxsCgb+I5R5H9LQunyGNt

On 6/12/25 3:00 AM, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 11:55:02PM +0300, Sergey Bashirov wrote:
>>  	if (nr_iomaps < 0)
>> -		return nfserrno(nr_iomaps);
>> +		return cpu_to_be32(-nr_iomaps);
> 
> This still feels like an odd calling convention.  Maybe we should just
> change the calling convention to return the __be32 encoded nfs errno
> and have a separate output argument for the number of iomaps?
> 
> Chuck, any preference?
> 

I thought of using an output argument. This calling convention is not
uncommon in NFS code, and I recall that Linus might prefer avoiding
output arguments?

If I were writing fresh code, I think I would use an output argument
instead of folding results of two different types into a function's
return value.

-- 
Chuck Lever

