Return-Path: <linux-nfs+bounces-15364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97EBED7E8
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D673319C0797
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657623F42D;
	Sat, 18 Oct 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDBkT4da";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lJUZXKdD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A037DA66
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813116; cv=fail; b=D/6y5u8qSeN+P1qYDOkFCxbPu/sPtPpXEHhZJ1BprrPRALQZVXDZgqPqpHmKe5TiMvk05CTJivdMaLvgwMoUAn0yfbgu3xET/FA2XJIUQuNXMnW4/S0BewFFoF5CjQT0gWtKjFnw+l3yp3PE04dzn08bmIVMa/PD+TNMUaSySVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813116; c=relaxed/simple;
	bh=vOpUkjSf+7kuuahz9DmUHvNAiVykQ/2jUfZduthXSAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLnLuHM74FVRFIlLMjtRz+D8cRdUJOlwnv748Lsry4nkoG9+u0zDC9t7wFyatVHULiDMO3IiEwYowcaLa34iqG1SgtwHmMzJSKssGRchKTWyFv33+wusKozsd/tLJCeObkwPCw7bhwOES30A5wNej2fE1tNaNFAaLhv2ykAPUgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDBkT4da; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lJUZXKdD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IBfwGM015122;
	Sat, 18 Oct 2025 18:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ypRwEIH1Pcc8mb7s9/xFRwH8idXX+o2+/M0IPUvkuxE=; b=
	eDBkT4da/T133FB1zeTU4HtyzR80KE8+YdD2WdbXFZyJX/7Klyhs9HAlyprtJR/4
	w7k+JZoP5mF7XtN+JuV6MFnbwv9r6ZNwYn4rwD95Vb/aw+UdM6k6MZCG0P7cI1Zp
	tuIrigS4ESULS4+tUGrRUflHA3RXT2tF2GJuyu0rDLah7pA6R1nMlXvKIV4ls09P
	RaGQX0IYuN+kL61E21Wpe6+tjv0KFNgg29MQqsy6iA7JzewNK9sJ1w6DC6n0Zy0r
	GH27kguwkJaITIrfjoMsjPAtx565nNUt/AFvqe8GnT6geCLB/Xop76GQUqiDZfMa
	M5WK/qZWR0Bcobb+oVNR+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d0fbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:45:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDY8cg009770;
	Sat, 18 Oct 2025 18:45:00 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1baq1bn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izMlLJtt+J/Oxd5WAT+uBBvw0MldU/RGy3w2/KCsyBvTsRFTfDNtNT/5biw6DgphZkR5SXgofXBJLNU1E6livxRKamQyJT5MN22ib6D/x1dQOl8gjs5MlO7jTLYJHBpa+MeQWLU7dN8r9HBW3vSnd/s7A+CxUblArNbtmyt/+2G963OB6EiQ/G+7ukE3+tQN+2ZLySibk3V1/es7qOlZ/OrKmmQPrNtUlPVHB7UREZG/VdlS9B7DtG+9mgiPwJsxPjj54dNO/dz2ga9NJkn5MMeTZE4ILqeUSCrG7lNSd55eJCX8Y/zH4F6ITOpH38P2DNETScUNn5RYmlRUscQ1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypRwEIH1Pcc8mb7s9/xFRwH8idXX+o2+/M0IPUvkuxE=;
 b=JrPPK3dn7fUiTOnQKY6bSE5gu47MfcJjDfr4Pc6ySPnzQS95HwJDV+4WNEn0t9YPz7FbIA1myuB4GF0eoA/tA7udvGSlm2mXsAmkq6t6zLgq2ccEeaqFLPJMT0gDH1t2Fo4TDMPTztC2a0MtU28Tf+o4AAu7zUqAv/ZC9CjcUxQNMBQfUV6jeZzKeg5UFXAuFiACAgR7v+9CYcUHEqyA+Zi0Q6InKb3mUWMiWN32S1ASiWuTVLexG4ZS6RYG8QDAw2gGGV/V9D3m+kroaHwPsbEOO/qv7pQ7bdjxcgJcbSJsB7My2y9UzJ+x/75gO8PPivVgNRLtlX/4Q06BofHHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypRwEIH1Pcc8mb7s9/xFRwH8idXX+o2+/M0IPUvkuxE=;
 b=lJUZXKdDGpUERxIDiBvvOiAzXqLR7dQc1NDr2ZIqSFQcRFZZuR3ZrIl1Vw0JKL4zRWwGN5jMP1PiQlwo+ye4cX0g6Hr6BCwF9qbtLhqZ1lzk5RsIVb7An7IzEP+wQzxM8SGcXCEV7g37s7MB6NLSjdA1UNiKbHGVnn0U3vNucQk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 18:44:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 18:44:57 +0000
Message-ID: <3c41883e-dac0-4b80-8ec3-d627936cd574@oracle.com>
Date: Sat, 18 Oct 2025 14:44:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] nfsd: discard ->op_release() for v4 operations
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-2-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-2-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:610:51::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 84da3e00-caa7-4930-2ae7-08de0e766f7f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWhyT1hoZmZyMStwNDhJQ2ZFMHZaZjVqVjFsQWhLallJMVhMS0NFTm9SV1lz?=
 =?utf-8?B?VWE5ZU4xWEFZTmpGVWRFUi81bTVUbkorRkpPemV3OUlwZ2JaTVhFMWp2aitI?=
 =?utf-8?B?RTl0Q2pZU2RZalRUUHZ4MFRuYVBDYnNZTjg5MGp2UDdzNmNacStuN1QyVzky?=
 =?utf-8?B?OVM0NlIyYlZHUFRxRHQ0NS8xa2xhby9tWEZZZ1NqUXhHZDFZYUJ4bWtwYXhq?=
 =?utf-8?B?SkV4VjgycC80S1d2OHlTNU0vbWxJdnlTaFpGQlhTSjl0Z1YwbmM4NzdzYWJv?=
 =?utf-8?B?N25DQS9VTnR0WGZDS3BlSHAyeG9tcEFGWUlHSzQyZVNmSnZsZUxnOHVRVldt?=
 =?utf-8?B?bUgvVzYrWXY5STcrTGhyYm9PNkNxRUNwZkFjVzZZVndxNUR1Y0lBZGZrKzlr?=
 =?utf-8?B?RmljcWlUMTlCVW9QYnJ4OUVVOVdrZG1GRTNEUnhrWTRWQ2dpVHNacENiU0Nm?=
 =?utf-8?B?SjZZUzUwdjlFQk5DWDB4c2hMS1Y5eHlIM0kxV2pBdk1tNE9EK2NsN1p5M1Ur?=
 =?utf-8?B?MERhY0QyZkZtM2I3NnpOQktyNG92OUJYaUdTSUdOejJ2RFo5dVhBNHMzNFZ1?=
 =?utf-8?B?RFlSRFNHUDA1OGNlSDN6MUYzclc0dE4zVWdtUWVQa3QyUTdOdHkycFNBblI0?=
 =?utf-8?B?bzRkanphYmpTNTNBdkl3VGhqRTJlTEpwazZEWDE4cVJEYW5XWVRGOGl3bndI?=
 =?utf-8?B?Q0NkcEhyNEM1YmRJRVR6ZS9nT2twUVhmMEZoOWRIbUxaRFZnY1VaZG9yREJK?=
 =?utf-8?B?cjkzd1JPVCs2L1k2Nk9UbEp0ODlYdTh1MnlHTU5MQ2FMQmdOYVVKbUdOS2tH?=
 =?utf-8?B?d2Zub3o1UU1TaDc3bmhUY2NObG5vbURFSmF3WUNySlhzbGl3ODZsem5uU05s?=
 =?utf-8?B?dGNmU2tuTDEydmlZTkFVS05Da1BnQXE2WHQzK3dMdGdNZnBFMmtpVzY1eVZE?=
 =?utf-8?B?WFU1NDJ3UUFmSHNTZ1VNRkpNOHZSMGp6WG40WHIrcTh1R2NMK1l1Sy94U2dY?=
 =?utf-8?B?eS9nMzhwZFRMUVhjQXJvN044ZWRlOWxnMmE3eG9RSkVsK0pPK1cyNWcvSDJC?=
 =?utf-8?B?NCtqd0hGVGNiRkN1QUhXaFEyTGJ1RGlmcmxRbzFRaEhIbldzMzhteWp6eVgw?=
 =?utf-8?B?c09LRmtnMG5GbjRISkpvKzVLaWQrUzRkRzBjQmt3ejZ2YllKL2ZpNGV4elZH?=
 =?utf-8?B?TzdZSlNQaFVKT2w5cEJYQkZNbU9NQy9DL21xcjNQNnhwQmdXWTBQVWVJVE9L?=
 =?utf-8?B?MjdSTCtXUCs1T2VlZTZ1Z0w4cCtJTi90eDVzLzhCTmQxbENRYUFuaDFMMEJs?=
 =?utf-8?B?UGRlRC83djFtZkNIbXV6RDl6V2NscDNCd0pWMFFIcU03Z0d1Y1hZTEJkVjNu?=
 =?utf-8?B?VUVYRHIrdnRkZnp0MHNNTU1haDZyNVM5c0tsclN0cEhZb3ZudjFrQkZyR05K?=
 =?utf-8?B?VzVLbmNONnE2TW9oZFFMa0dlL2tvZ0c5R3ZyUk9YTy9naFZDbHBUMExwT2FB?=
 =?utf-8?B?YUovZ05TR09HbkJBaFZMTUdsU2czWWRBVzZramo2RHR4MHJBS29nQ1VqSGI2?=
 =?utf-8?B?RWwzNlVnTEFRTFVYNnM1VDd4aXJJUnVpNjllNmdNVms4VUxnUXJBWnlhWjd6?=
 =?utf-8?B?N3QzMlpyTWlCL0JWeEp6RVBqS1NjazdzNEFaMEJnNjRLTncwU0ZEYnZBV0Er?=
 =?utf-8?B?OHZCOE10WE9KZ21FMFpMbW56eXhFYUN6VTg0emIrdXpNbzF2RFRXcXV6ZTRu?=
 =?utf-8?B?OTFSSjVzV0NiR2k5MlU0MWlZSjZ5czlkd3luTGdlWnFUYlZnclJObDlQb01C?=
 =?utf-8?B?cTd0eWJnNmlVdWQyREY2Z0RVVUNCZUpMYURpSjM4VHA3TnVwMUVJTll0ZUZT?=
 =?utf-8?B?bG01NzdrRHhCeVRmL3lQcXpRanUwQlEzTWs1RG4wTnY4cEZrT0tlV3ROY0t2?=
 =?utf-8?Q?vkTTysEEWihChF3P4OBgZL2Bft6bXgeX?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M250N2tkVlJjU2Zsdmh0RmcvNlpQMnZxTDQzSyt1Wm1HOUlXNkRlQ1Z6UDYx?=
 =?utf-8?B?SzhTckhxRkE5VVlIQXRkSS9zVFhzSG0rZjNOYnZiSElvZDRkc25EcHlkWHdk?=
 =?utf-8?B?dS94aWRFM2NmYWFZZjBEWDgrMXFqRHZsUjFmVEo1SlhYVWVZYjBOZ1pVVGhQ?=
 =?utf-8?B?MksyZlQzVmdPZVJQMmhXZ1RUOTdvSzF5b1B0UklzUDROeHZ5ZkI5RVRtVEg3?=
 =?utf-8?B?WE9nVTUzcHZhcHFOSnJBKy9UTnN1RGplcCtRSTZXcG9VcW1YU2JzVW1yNFZR?=
 =?utf-8?B?VkFLQkVtWHFrT20yZ29VZDFpZENBQ2wxUHBRaWRudjBnc280dWI1OUlXUnA3?=
 =?utf-8?B?OGJFU2ZTR1UzbnNLbEZ2dHJIT1pOL2JaYm5DaE1vMXd6RDhWME5DVVJXZXJL?=
 =?utf-8?B?bmJzbkZsSXFHelp5bFNLY0t3M2pYVG80Q3RJYjErbFFPYTgwSlZMTzlqazU3?=
 =?utf-8?B?U0xnL25la0hyeVJLUnZ6ZVJrT1JqdjJDeGM2NXgvL0JXNEpOMFRrN0RoL1lG?=
 =?utf-8?B?dk4zc2tsUGVIUjFjdEJjUnQxMDB2Uy9od1RmWmVXV1VZZ3RXL0tPMVdHQ1g2?=
 =?utf-8?B?ODRxYkJLK0x3R2RLMVJsWDlFWXF6cGJka2RzVyt4ZjJJdFl4WmVUM094YWx2?=
 =?utf-8?B?anlyYkxTT2xTeHdXZXBBbWwrR1V5eTZUUWRMWmRFT2lLWG1kT28vREhSZG9G?=
 =?utf-8?B?d2F5OUZqS1FhTG1rNWdtTC9tcDNnZnZLOXlWMkF2QzI4amxtZGE3cU9DWjh2?=
 =?utf-8?B?TG8rVll5ZUk3enRhNk5lNFMxdTV3TC8xSVdaYlZuZXU3MWdRY1liRzFNeWJE?=
 =?utf-8?B?NEJqY3BhRTBjOUJ4YmxWczYxSXFQaysyV2pRODZ1bUZZNTlGSCsvOS9rOFZM?=
 =?utf-8?B?YzJyMUlNeEZrSzd3dUtBdDdvd0ZrYkVFVFR4UWphWjFLUzdtSHVqdDI4OEdL?=
 =?utf-8?B?ODl5NUI5eDBDU1oyU3A4VktpUEdLNnlhRjlOUVJzcU4wZ21zRXFyakpuSzNE?=
 =?utf-8?B?ZGcvRFBlSlQ3cEg1eS9ha0luT20rM2k3ZnFqMG1vSWZuN1NwcHVkNlgvU1JG?=
 =?utf-8?B?Sm9BZ3F5cDlMQktwWmNLV010bEQ0VElLUnFxd0lvalB1TWZteTZXakJ6TXU3?=
 =?utf-8?B?NmpvNlZlVmhvd21wK24wRmIwazhKWFJoNzF1UTQ1MlNPZTA3MGZhWGFXN0ln?=
 =?utf-8?B?d2JJV3VRMWVha2d5amhUeVk0UGFxZ2JwcE13d3FtbG9IUGlnRFpTSW4wRkxE?=
 =?utf-8?B?RWZQeDJHNVJKWEhiRFFvVmU4ZmVtZVRtaWU1QTFjaGhrQ1ZuYjVsQkRWR0ZJ?=
 =?utf-8?B?UStCcDN0OVdZdDV4Q3p2c0tGdFFLNk00QkswZ2lVUDltZWxSenVoMUJiRlJy?=
 =?utf-8?B?dDIxMmExU3VGd0d0WW1XaENSQWhCME83ZGo2M0JJRlMvZjE1b0JYQ25MRUZi?=
 =?utf-8?B?Mm8zRVZRRzZMNUVEZ0lQNkdNN3FtWFdoUFczZG53MTBicEJQUWNBSDh0aHIr?=
 =?utf-8?B?eDZDMXNhZHlwK3J1YUtvdm5xU3daUUZOZUtRMklWYml2ejJXK1FhZlhzdjdw?=
 =?utf-8?B?aVA5YW1UWUx6aGlQQ2lab1JvT0NYZUdsR3l5Yll2TVN0ODlwNWhTVDRRMDZD?=
 =?utf-8?B?MGppTGpzRGM4TG9TNlU4ckZkVmhjaDIzdS9vV28rRzBPT21HNGF2SmRjNllY?=
 =?utf-8?B?OURGcGVzanRkcXR3NzhPZmxaVXhwTk44ZjNhM29OSW5rV1YwcVRhS1lOYWRR?=
 =?utf-8?B?SXYrak0vQjhHVVgxMWFWRVU2WEZncjJFODgxSlFKcEJkZ2R0UFRsV2xsTjRC?=
 =?utf-8?B?dTduV1Ixc3dFeDd4NzdCL3ZpU0Z5d1BJUHdqSUZSZkUxd292aFN3blhvN1Vy?=
 =?utf-8?B?OUl6cGlMZnd5bitlVHNjYnBGL1ROcGl2TmVlYVF4cmQzdDFIcnQxcFhDcmpX?=
 =?utf-8?B?V1plTjdaMzFXM25sdHdyNkFlTTFIS3FkajMzVWtJajByZ0J3VHcwRXNNMFhW?=
 =?utf-8?B?N1UzSUF5M3F2Z2J0clNvSnFzaDB4dEVHNUpWQ2xJdzREd2FlaElRNjgwZVhW?=
 =?utf-8?B?bElTYUNNMlN2U1lub0dZWnZteUc5VkErWTR1bmFtQ3IvdFVEMTN4NkxnS3Jl?=
 =?utf-8?Q?Sxawa1SE+hc280qq8wFcGzFGS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CnQkGldFM8h89lmVc0RM1Do/zS8okZEcFDUNB/VjXKYdkZ7Vx9Ts+FSsU4zLziWHCOrhMOBsEqkmfnY/LWqubyoZxyjnBxUYmy6tjGAxwlcIJXojlBov3Vegy0JMohGbccuFBHCEHviPvSvkcZMLXxEVs0zOJ5ozAqbhaCXEBFdZVWPQi8AYVAXwaFsk7dzVOtooZZeUMdAZ9Vd+TNJmcXw4LeAEl6M1IhCnSJWFmJIi7HuGvNaeaka8Dcmfq61wrIVZTywqo6SvqMpocwpGQd9LpIMC258adwm3iqspZKVd86UGWumoLIUJvJet+YkMVC5MlGpovEdntu8xPira6Uyv0p3eRxHL9mqrWxWvwqEaR0WwEcffCtZW/d8hz4x29LFRu3UYwnaeYnqpgnA483j4/b1VEKjr3ekUJVU4qJZzDSJOi/c3t1yJhRDsD5e9jTTO4Ex9bN5pdRmKfxI3AwdL43/jKaVL4NnjCx9H1NF6lUsv5fTGBwI0z5uAVvoVEnW+2qvL5TGRwVHz5vhi6a7nsGkV3fQpWlOUnTczXTLY9/mR1FZxeQYl6O6MyIZdSITyrg3RiRQlWT0T9qs+u4XJReEMoT92Wk3aVw12Pag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84da3e00-caa7-4930-2ae7-08de0e766f7f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 18:44:57.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uo1T/JJh3UGovxGGWBL/NFZGPGfBM0S3WAUne6mhlqUjIGewc9oVl1Dw6RNJ9qbUWFocA70v6EOY3udwOJnmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX/Knq4i22aJXh
 KHMIYL3TPxsOZQrjYHlw4jh9DKxjCcMnEMG8lMdyMXeGShCNx0F6TjnJvHF7SKHuIcXPGjcHMIQ
 uwygjGmwDKuWMZLQVysus7Gl60wa0GsbjmQoqNaX1qCyrKDBwvMncvkamMxin5pEWgRQnR5gti0
 1I/Q4IYrTOZubTbpkDxulP9AKfZb1qwy9Smp62s3lmlpygI/FrZNxEYsoeNo6uuzpYPoiSobV3m
 FEAjzgzLQ5JLOX2aA8ulcTf4pKbdWcqblt0oki/AvnC4UFuuB7B7SXaAWhPRRSDWmrrqAHQ4TJJ
 stW+498MBSllL2huHC/4M7De1jqUJZObeyjq8zTREtTE1q9skoAK+Z/r99ygjAED+Xviu+B8Lrb
 /XsSeEccSUedSoP8IHjPcno9PvHtX/sQ/gF0Z62+eq7vkJCK+ws=
X-Proofpoint-GUID: __Z3QmmRV3B2JuVnq6hM9BhteitcbzPS
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f3e02e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Sw8EjBeDRSPCqO2ek1QA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: __Z3QmmRV3B2JuVnq6hM9BhteitcbzPS

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Instead of having a separate ->op_release() function, change to
> releasing any resources immediately after they have been encoded into
> the reply or, in one case, if processing the op resulted in an error.
> 
> There have been two bugs recently which were (arguably) caused by having
> the ->op_release code quite separate from the other code.  I think it
> makes more sense to keep it all together.  Any resources that ->op_func()
> allocates are now freed after the op reply has been encoded.  The encode
> function easily knows when the resource is present and so needs to be
> freed.
> 
> One effect of this is that the trace_nfsd_read_done() tracepoint is no
> longer considered to be part of "releasing" anything, and is now only
> called when the read is done successfully.  It is also now *before*
> generic errors are traced, rather than after.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/blocklayout.c | 10 ++++++++--
>  fs/nfsd/nfs4proc.c    | 46 -------------------------------------------
>  fs/nfsd/nfs4state.c   | 16 ---------------
>  fs/nfsd/nfs4xdr.c     | 28 ++++++++++++++++++++------
>  fs/nfsd/xdr4.h        |  3 ---
>  5 files changed, 30 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 101cccbee4a3..cd38c7f9d806 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -206,6 +206,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
>  {
>  	struct pnfs_block_deviceaddr *dev;
>  	struct pnfs_block_volume *b;
> +	int status;
>  
>  	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>  	if (!dev)
> @@ -217,8 +218,13 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
>  
>  	b->type = PNFS_BLOCK_VOLUME_SIMPLE;
>  	b->simple.sig_len = PNFS_BLOCK_UUID_LEN;
> -	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
> -			&b->simple.offset);
> +	status = sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
> +					   &b->simple.offset);
> +	if (status) {
> +		kfree(dev);
> +		gdp->gd_device = NULL;
> +	}
> +	return status;
>  }
>  
>  static __be32
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2222bb283baf..9d53ea289bf3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -984,17 +984,6 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return status;
>  }
>  
> -
> -static void
> -nfsd4_read_release(union nfsd4_op_u *u)
> -{
> -	if (u->read.rd_nf) {
> -		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> -				     u->read.rd_offset, u->read.rd_length);
> -		nfsd_file_put(u->read.rd_nf);
> -	}
> -}
> -
>  static __be32
>  nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	      union nfsd4_op_u *u)
> @@ -1120,20 +1109,6 @@ nfsd4_secinfo_no_name(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat
>  	return nfs_ok;
>  }
>  
> -static void
> -nfsd4_secinfo_release(union nfsd4_op_u *u)
> -{
> -	if (u->secinfo.si_exp)
> -		exp_put(u->secinfo.si_exp);
> -}
> -
> -static void
> -nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
> -{
> -	if (u->secinfo_no_name.sin_exp)
> -		exp_put(u->secinfo_no_name.sin_exp);
> -}
> -
>  /*
>   * Validate that the requested timestamps are within the acceptable range. If
>   * timestamp appears to be in the future, then it will be clamped to
> @@ -2426,12 +2401,6 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
>  	return nfserr;
>  }
>  
> -static void
> -nfsd4_getdeviceinfo_release(union nfsd4_op_u *u)
> -{
> -	kfree(u->getdeviceinfo.gd_device);
> -}
> -
>  static __be32
>  nfsd4_layoutget(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> @@ -2512,12 +2481,6 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
>  	return nfserr;
>  }
>  
> -static void
> -nfsd4_layoutget_release(union nfsd4_op_u *u)
> -{
> -	kfree(u->layoutget.lg_content);
> -}
> -
>  static __be32
>  nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> @@ -3444,7 +3407,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_LOCK] = {
>  		.op_func = nfsd4_lock,
> -		.op_release = nfsd4_lock_release,
>  		.op_flags = OP_MODIFIES_SOMETHING |
>  				OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name = "OP_LOCK",
> @@ -3453,7 +3415,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_LOCKT] = {
>  		.op_func = nfsd4_lockt,
> -		.op_release = nfsd4_lockt_release,
>  		.op_flags = OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name = "OP_LOCKT",
>  		.op_rsize_bop = nfsd4_lock_rsize,
> @@ -3526,7 +3487,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_READ] = {
>  		.op_func = nfsd4_read,
> -		.op_release = nfsd4_read_release,
>  		.op_name = "OP_READ",
>  		.op_rsize_bop = nfsd4_read_rsize,
>  		.op_get_currentstateid = nfsd4_get_readstateid,
> @@ -3576,7 +3536,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SECINFO] = {
>  		.op_func = nfsd4_secinfo,
> -		.op_release = nfsd4_secinfo_release,
>  		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_SECINFO",
>  		.op_rsize_bop = nfsd4_secinfo_rsize,
> @@ -3627,7 +3586,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	/* NFSv4.1 operations */
>  	[OP_EXCHANGE_ID] = {
>  		.op_func = nfsd4_exchange_id,
> -		.op_release = nfsd4_exchange_id_release,
>  		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_EXCHANGE_ID",
> @@ -3681,7 +3639,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SECINFO_NO_NAME] = {
>  		.op_func = nfsd4_secinfo_no_name,
> -		.op_release = nfsd4_secinfo_no_name_release,
>  		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_SECINFO_NO_NAME",
>  		.op_rsize_bop = nfsd4_secinfo_rsize,
> @@ -3708,14 +3665,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO] = {
>  		.op_func = nfsd4_getdeviceinfo,
> -		.op_release = nfsd4_getdeviceinfo_release,
>  		.op_flags = ALLOWED_WITHOUT_FH,
>  		.op_name = "OP_GETDEVICEINFO",
>  		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
>  	},
>  	[OP_LAYOUTGET] = {
>  		.op_func = nfsd4_layoutget,
> -		.op_release = nfsd4_layoutget_release,
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_LAYOUTGET",
>  		.op_rsize_bop = nfsd4_layoutget_rsize,
> @@ -3761,7 +3716,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_READ_PLUS] = {
>  		.op_func = nfsd4_read,
> -		.op_release = nfsd4_read_release,
>  		.op_name = "OP_READ_PLUS",
>  		.op_rsize_bop = nfsd4_read_plus_rsize,
>  		.op_get_currentstateid = nfsd4_get_readstateid,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..1e821f5d09a3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8454,14 +8454,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return status;
>  }
>  
> -void nfsd4_lock_release(union nfsd4_op_u *u)
> -{
> -	struct nfsd4_lock *lock = &u->lock;
> -	struct nfsd4_lock_denied *deny = &lock->lk_denied;
> -
> -	kfree(deny->ld_owner.data);
> -}
> -
>  /*
>   * The NFSv4 spec allows a client to do a LOCKT without holding an OPEN,
>   * so we do a temporary open here just to get an open file to pass to
> @@ -8567,14 +8559,6 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return status;
>  }
>  
> -void nfsd4_lockt_release(union nfsd4_op_u *u)
> -{
> -	struct nfsd4_lockt *lockt = &u->lockt;
> -	struct nfsd4_lock_denied *deny = &lockt->lt_denied;
> -
> -	kfree(deny->ld_owner.data);
> -}
> -
>  __be32
>  nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	    union nfsd4_op_u *u)
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 30ce5851fe4c..1ffe8ddc1215 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4174,6 +4174,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	case nfserr_denied:
>  		/* denied */
>  		status = nfsd4_encode_lock4denied(xdr, &lock->lk_denied);
> +		kfree(lock->lk_denied.ld_owner.data);
>  		break;
>  	default:
>  		return nfserr;
> @@ -4192,6 +4193,7 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr == nfserr_denied) {
>  		/* denied */
>  		status = nfsd4_encode_lock4denied(xdr, &lockt->lt_denied);
> +		kfree(lockt->lt_denied.ld_owner.data);
>  		if (status != nfs_ok)
>  			return status;
>  	}
> @@ -4532,6 +4534,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	/* Reserve space for the eof flag and byte count */
>  	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
>  		WARN_ON_ONCE(splice_ok);
> +		nfsd_file_put(read->rd_nf);
>  		return nfserr_resource;
>  	}
>  	xdr_commit_encode(xdr);
> @@ -4543,6 +4546,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
>  		nfserr = nfsd4_encode_readv(resp, read, maxcount);
> +	nfsd_file_put(read->rd_nf);
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, eof_offset);
>  		return nfserr;
> @@ -4551,6 +4555,8 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	wire_data[0] = read->rd_eof ? xdr_one : xdr_zero;
>  	wire_data[1] = cpu_to_be32(read->rd_length);
>  	write_bytes_to_xdr_buf(xdr->buf, eof_offset, &wire_data, XDR_UNIT * 2);
> +	trace_nfsd_read_done(read->rd_rqstp, read->rd_fhp,
> +			     read->rd_offset, read->rd_length);
>  	return nfs_ok;
>  }
>  
> @@ -4803,8 +4809,11 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
>  {
>  	struct nfsd4_secinfo *secinfo = &u->secinfo;
>  	struct xdr_stream *xdr = resp->xdr;
> +	__be32 status;
>  
> -	return nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
> +	status = nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
> +	exp_put(secinfo->si_exp);
> +	return status;
>  }

Unfortunately this goes in exactly the opposite direction that xdrgen
is taking us. I don't want to add anything not related to XDR to the
encoder functions. The encoder functions for individual operations
will someday be all machine generated.


>  static __be32
> @@ -4813,8 +4822,11 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
>  {
>  	struct nfsd4_secinfo_no_name *secinfo = &u->secinfo_no_name;
>  	struct xdr_stream *xdr = resp->xdr;
> +	__be32 status;
>  
> -	return nfsd4_encode_SECINFO4resok(xdr, secinfo->sin_exp);
> +	status = nfsd4_encode_SECINFO4resok(xdr, secinfo->sin_exp);
> +	exp_put(secinfo->sin_exp);
> +	return status;
>  }

Ditto.


>  static __be32
> @@ -4963,6 +4975,8 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
>  	struct nfsd4_exchange_id *exid = &u->exchange_id;
>  	struct xdr_stream *xdr = resp->xdr;
> +	/* impl_name is encoded in nii_name.data */
> +	char *impl_name __free(kfree) = exid->server_impl_name;

Ditto.


>  	/* eir_clientid */
>  	nfserr = nfsd4_encode_clientid4(xdr, &exid->clientid);
> @@ -5210,6 +5224,7 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
>  
>  	/* gdir_device_addr */
>  	nfserr = nfsd4_encode_device_addr4(xdr, gdev);
> +	kfree(gdev->gd_device);

Ditto.


>  	if (nfserr)
>  		return nfserr;
>  	/* gdir_notification */
> @@ -5245,6 +5260,7 @@ nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
>  {
>  	struct nfsd4_layoutget *lgp = &u->layoutget;
>  	struct xdr_stream *xdr = resp->xdr;
> +	const struct pnfs_ff_layout *fl __free(kfree) = lgp->lg_content;

Ditto.


>  	/* logr_return_on_close */
>  	nfserr = nfsd4_encode_bool(xdr, true);
> @@ -5468,8 +5484,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	eof_offset = xdr->buf->len;
>  
>  	/* Reserve space for the eof flag and segment count */
> -	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2)))
> +	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
> +		nfsd_file_put(read->rd_nf);

Ditto.


>  		return nfserr_io;
> +	}
>  	xdr_commit_encode(xdr);
>  
>  	read->rd_eof = read->rd_offset >= i_size_read(file_inode(file));
> @@ -5477,6 +5495,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		goto out;
>  
>  	nfserr = nfsd4_encode_read_plus_data(resp, read);
> +	nfsd_file_put(read->rd_nf);

Ditto.


>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, eof_offset);
>  		return nfserr;
> @@ -5951,9 +5970,6 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  	write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
>  			       &op->status, XDR_UNIT);
>  release:
> -	if (opdesc && opdesc->op_release)
> -		opdesc->op_release(&op->u);
> -
>  	/*
>  	 * Account for pages consumed while encoding this operation.
>  	 * The xdr_stream primitives don't manage rq_next_page.
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ae75846b3cd7..2a347c1bc3e7 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -985,10 +985,8 @@ extern __be32 nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *, union nfsd4_op_u *u);
>  extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
>  		union nfsd4_op_u *u);
> -extern void nfsd4_lock_release(union nfsd4_op_u *u);
>  extern __be32 nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
>  		union nfsd4_op_u *u);
> -extern void nfsd4_lockt_release(union nfsd4_op_u *u);
>  extern __be32 nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
>  		union nfsd4_op_u *u);
>  extern __be32
> @@ -1040,7 +1038,6 @@ enum nfsd4_op_flags {
>  struct nfsd4_operation {
>  	__be32 (*op_func)(struct svc_rqst *, struct nfsd4_compound_state *,
>  			union nfsd4_op_u *);
> -	void (*op_release)(union nfsd4_op_u *);
>  	u32 op_flags;
>  	char *op_name;
>  	/* Try to get response size before operation */


-- 
Chuck Lever

