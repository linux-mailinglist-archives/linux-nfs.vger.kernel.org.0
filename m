Return-Path: <linux-nfs+bounces-8865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6C9FF52E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 00:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402361881E50
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFF45023;
	Wed,  1 Jan 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYY6IL9c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZCC1gF4W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DFDF49
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735772967; cv=fail; b=rH5e1hgfF4IDaeSQLvZruLnPL1XFZ10ykYfsnRH6js+0HwtH0P45/uF2npIf3jGV3vP/HZ4ArHXEljl7PXBAo9W+2W4wfsLTXk62u+zQFBKImdTYvWk43kWftm2fKeArWZMJoAOXUGHhVVMobEH12f8E/FPO61fLbZd3UtMvp/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735772967; c=relaxed/simple;
	bh=v7TaupRonFvVGZ7fI7xrdnegjwEM7/9nLL2r34Z4xj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSMeFq/zGdriwFJAe4FoShmPENdzUFZEMfzCdSEMxz4HdVZKPOQd94Q8/CbVHE1MAJfKAJUwlNZpXuAomZ1JOlLdZCBvjJeROxqoxGUjCd5iHmCUhaoLh2/NZtnvb7H85vdAB3DUalo84NJpp7YdBTuWEKB5guskAoKz0boyxEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AYY6IL9c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZCC1gF4W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501KZJJN010525;
	Wed, 1 Jan 2025 23:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yPav40rJ31R26O/p5Drqdz9ZqDZEize/NE8mE54MBAk=; b=
	AYY6IL9cSHQQOKfYe4Kv/DDCrgU8ZFdQqejjzz6bpliuqX3DojLZdxibYm4p5S3l
	lG3rZ4rMGqplfD1Tw5WqqKQ/S1np2jDh7wgBjdO2a9JMX7K/dNSDLFRS4sKSVaY/
	spY9pvFECa7AAIMIoEivRJs1R1ecuLl0E6SF1UceNxIlpCEovdzuffv5y2vc1lEK
	0mUAAjGxZhnnwrx9kcknXthvc0b7VXwiNLHjM2lHzhWY89vKKlM3borRvfOBGkBt
	z1mdmgpNPdZfOGbikj8PCgRKKerM6IiU7K8Ip01/OdO1QANuEIHk+2qxx5A6vH1A
	REtu0adqsUOTIeX8TYdUYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt4j7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 23:09:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501MddJu012360;
	Wed, 1 Jan 2025 23:09:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s81b0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 23:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyOLmp7EoVLABhU4JzJm5QEBxCCQCyNh25Rdh8/+DR83ZwHeXQ4QU7xmXnuoFYA3+iJ3Ta3oKKxcAWSzoA2ci4I+Cc0xas8KqO8TtbjLJpAyboODBJ6KPImI40hysF3RwjF1SWKBC6RAic/J2u4DRji9gPbz3wiPn76aKyb8NOT3ZD5Bk01td5SXW9lEe46gLF9gwbMBWPelzuy2MhRRuylCyjUPE+hBIhvDH+8axAJj+lpuF+dcTetND59AGhVldBce7LZIwzGPxhDs68J28sZOn/PmGYdYAeThw7XkXaP2hzmOaf+Dea6HmhyBJc6PLXYbhfEQTSj5z3i6MGIxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPav40rJ31R26O/p5Drqdz9ZqDZEize/NE8mE54MBAk=;
 b=otKOrW78vmiaomcM1Lrr8MqnZm5sx+4WP2D1plRLXViD926cK/vstqovgSKVZJuAfvR5hYVhMnL9FDHJ4cB5LNUa31+hEIDkwTQ0Ztw+JI7kHc8Y7YDTfKSNmM0/amQzBT473UMAukNE5HfqRsvqfOZu9lns9Il2mBJHlGdEujhMOidAO6NtPOyJUV3+MZW4zQD40PTS1zJqoIU7vVAgiRa5b0dMMA1IjBDMnKWHGgJXy93KwtREXfg0vJ/iTDYdH7TxWj6bsaY4fjHh/H2c4rrPLGqXOEy/nhbotrR15u5BUwnhi9Y8rfoDKwctVpDV2vKloqbR0xQG2KjN8+pPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPav40rJ31R26O/p5Drqdz9ZqDZEize/NE8mE54MBAk=;
 b=ZCC1gF4WE52ne0B5hn+KZ5FOVs3H/vWg7V8OSEiTwS3AFHzaK9Jnd+RCJghPmjdVejlfG8kaqA76lWQ3Rm3bawT9yLC16JFEFS05DXula/3D+yi0kRQlLBLQo0IcAs4tg0nrMKf5qVNH+xABFchlmuxkUAOOiQXXs+MX5rjoX8U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 23:09:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 23:09:02 +0000
Message-ID: <b483d011-f003-4920-ab7d-adc3afe3b538@oracle.com>
Date: Wed, 1 Jan 2025 18:09:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] SUNRPC: Document validity guarantees of the
 pointer returned by reserve_space
To: NeilBrown <neilb@suse.de>, cel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Rick Macklem <rick.macklem@gmail.com>,
        j.david.lists@gmail.com
References: <20241231002901.12725-1-cel@kernel.org>
 <20241231002901.12725-10-cel@kernel.org>
 <173576815212.22054.16464131258444633667@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173576815212.22054.16464131258444633667@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:610:11a::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 40624d11-d5af-44f2-47bc-08dd2ab9480c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlU5YllkUEQrKzlKbk9DeWhJazltWXQxTGNrNGc4SFk0RmRBeFQ3bDl6WXRn?=
 =?utf-8?B?dXZRQVNteDUzMXl3TDdTdHVWQjl4cUpJZ3RvQ3FuWXkyZ3lDMzBuemNBNjI5?=
 =?utf-8?B?Q2NNRHNreERlOWczTk5tRzd5YVY1ak85MC9KdnF3NlovWWcxSFZ3UDRBVy9P?=
 =?utf-8?B?Z1cxcktOdytoR2MxVU9VYWYrdDZjV0k1N09CdTU3b2lyL21halV0RndWbkhG?=
 =?utf-8?B?bzVpV3VhV0xZblo5ZzVweUFkZmpoYU1MNENicXA1VTlobXl4SkUzSmt6ZzVq?=
 =?utf-8?B?V3VmRTBVR2ZYU2JvekJQTi8wZytxRWRiNkRpOHB3NER4THluSGFaZVYvYzI0?=
 =?utf-8?B?MGxlZlJIUVhJTFdsNENycFpFSTZoSVpHOTJyTndZZXFBMkwvei90cllZQUxO?=
 =?utf-8?B?RVRKSWFncmg5UTdiT3dGQThXa3g4bUVuK3Z2R3NHaHRqMHlaWXZ3Mm5KY2Ju?=
 =?utf-8?B?K2Q3b3prUTJYZUhudi9uMURHdGJDU0hqQXgyMTY0ME9kZS9teWkvL3BjUmZo?=
 =?utf-8?B?TmozVVVIYTJwSXc0SHNOMWIzZVVKOVRJRG0reWpaYWJhYUo2R0lnQjF6eitt?=
 =?utf-8?B?NCticlBEQ25QUXVTMkpvdHhPWXBtRW5zVlB6RzhQVWY5ekFqZGJBdGJMM0dz?=
 =?utf-8?B?ZTdNUm1jVklITW5mWHA2RWFVNS9PSUlJZzlKNXltRFZuK1g3RTJ4NnVEeUZ6?=
 =?utf-8?B?NjJXL3V0SWsvekc5ZjFEZkxldEZIK3I4OE8zSE1VNGQ3alRkNGZwKzVkQ3Ru?=
 =?utf-8?B?NFZHQUxnUWR5YklySktyRk9iSjRSNlFGZmhPMVN5RjI4ZEpPdTZZWXJNajNo?=
 =?utf-8?B?UTJ5SU13S2JDYWdsZ3h4Tmg2Z2RVdUtobkxSSmZnSDVpR1NacW53M0d3RXZS?=
 =?utf-8?B?TElLTUUvVm1oWW9QL25BYXcyWEF0MjN6R0FyVFlDQlBHUDB3VkR6OFptZytl?=
 =?utf-8?B?dDdPNGMxN2tIK1JMc2VPZzJuU2c3NjNNNWJLV0hZam42WU50bU5NUUZjNDlF?=
 =?utf-8?B?MTk1VjdvREpFNlRTRFpkTnd0OVlYQ0ZnTGZNL0lLOTJRYW8wRW5ZMmh4ZGtT?=
 =?utf-8?B?dmpTSk9VZTdTNVRuejZqUkpqNGovTHRoaGgzcUQ4ZExiWVBDdE9YY3BIeVN2?=
 =?utf-8?B?ZFB4K3hRYm5SUUswcVcwZU0xNDc1Uzk5N1ZkTzllTlFvRGpqT3YxMTdKYytT?=
 =?utf-8?B?QUNjS052ZkRneVZieUNLTURSMHJVRVFJTURrdGRGN0F4NnovR09lMUJtL2s4?=
 =?utf-8?B?NnlGNXJMdWxGZm1YT2Z3NExoMExGTGR6NURCVThMVzVGWUpwVjNLc1gxVmND?=
 =?utf-8?B?UThwRDdyc0poVjFUQzQ4OWxmRTZqWllrOTJSYWdOTnJBN0ROOEVxZmxMTGpY?=
 =?utf-8?B?WWpSM1pMbzlmNnBJMDZuTmh3QUc4SjF2NWxBT2d0SnlhbHhwdjFjM1hYZ2t4?=
 =?utf-8?B?SEV5SU0vL0FDaEpOOVh0Y2xLYjFBU0VrVEVON000VnY2L2tETndERUhsTzhP?=
 =?utf-8?B?VkZ2NThMaS9vdGNlSkhicCsvM09hMHAxUGJwVTk5YnN6UUt3V0wzRmttQmN3?=
 =?utf-8?B?bE9NMytubk40bWdkSEk4ZXpab1Y0M041ejBVYklDYmFvMnhydHM3Mzk1ZXE2?=
 =?utf-8?B?aUo0QXN5QlliUWR6YzJCVzNycklFaEtNOGExR3d0eXJGK0RWd2pyZytTLzd5?=
 =?utf-8?B?K1hobnIzMmNRZHE4dHJ2d2ZBNno0QzFBeVQ4Sllac2tlYjRsdE5BQTQwakhH?=
 =?utf-8?B?cU9oSm96bFYxS3pza2VsMy8xbmM1a0R6ck9xcFNFdXlTSGJKV2RwY2VmZkx3?=
 =?utf-8?B?SUdsTDlLYmZmd21MN2RHbXBWYVVnaTNtdW15bGE0OWdHTmdrQ1pVcG5Pam1k?=
 =?utf-8?Q?ADWY291v4p15+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG9rUVFFNGRxcUhQRDVKdXF4cW8vRkwzTE4wRjJDQU94WDRET3ZlbjR4ZFdY?=
 =?utf-8?B?aVRLUDhET0JxUHRSaDUyb0xXMXZZLzBjS2taU3JBSDdaa0dHVXBYYWxHaXFP?=
 =?utf-8?B?QU9RL0VrRGdIMkF5aHZKb05JcU9lcFJPT05NWEtxYWdyOTFESkdaVVlDdm9l?=
 =?utf-8?B?VXA3eUtCTlE5SUpjemxLVUliTFlHNU9TOFJPRkpUejE5MWlkaExYaFJ2Wi9k?=
 =?utf-8?B?OUpkNGlLMnJrVzJwdGhGT2lkazJmc29KbXppbERSWm5jeDlUZ0VnaEVxRnZv?=
 =?utf-8?B?L2RhNCsvWWQxYUFKanhPS2NFaGZEeTNJVlM5TTNLQnozTmd1TTQ0M24wZzNN?=
 =?utf-8?B?eHBOd2ZiL2szZ2Nkd1pUMkJqSWdpZ2Q0QXZ1a1F4Qm9ERm5vTzgrVjMzTG5M?=
 =?utf-8?B?cFl2S3AxR1pCaEJYbzJ3MTczRnlwbEw1RVBtd04vU2Z2OXd5OU5VYU9SbkRF?=
 =?utf-8?B?VUNJV1FnUC9KM1loZk9haDIvejE0Z0lDSEVmd0ErRWJzM082OHFBVyt0WHds?=
 =?utf-8?B?VzVKbDdJT28xYVdtNTB1eE9ZUG1ORDBaTHppZGwzb29uTmFGZENoSzBxZDNr?=
 =?utf-8?B?Y2MrTGdGMk1FSHBlUWxLcDJ6T2VZYW4wRHlUUkhCRWV3eU1LeGppNVRMU1pa?=
 =?utf-8?B?c3Z5My85Z1NuT3JGVHJsaEVJbHIzZ1d4ZjYyTmhCZ2w2WjY4Skd3WHE0MVY3?=
 =?utf-8?B?dEJWRXNzTVQzRjQrak5WdkV2QWkvNEY1eFd1akVvZTlUUFlGQmZKQ2w1bVBP?=
 =?utf-8?B?SnhkWndmOVNsbS9OUUltSVNrMStobDRYWDBwTW9PQ1BmUHR5NTN3L09VVkxW?=
 =?utf-8?B?cjROZ1RxSWJkaTRiQWVxd2VZZW00Rjg2NXhHK0IyeTJicHRNYm9zbURjaDBD?=
 =?utf-8?B?eVhtRHl6alBzTDhQM1Ryc0U2Skk2SzE3ak1oQy9NUlFQMkhqQThFb3hRb29w?=
 =?utf-8?B?eDVpSFBWRXA5SFRHQTViUG85SGFNYmpsRlRkNVhmc0UvR1BvdDVIaHVmZnhX?=
 =?utf-8?B?ajVaL1hPQVZBSXhSWTdaaDJ2NWZZOUlqYjg4Z055Mkp4KzJPZFpJOElKNFl6?=
 =?utf-8?B?dE5NTHBhRS9oN3JGN0RURlozQ3NvbGdRVVFKTG85VXlabDR1b3RiQkxyNEU0?=
 =?utf-8?B?bGU3TU90dzBEWmxGWVpXeGZxMUpxWnc4WEsxblloWVNCTDNWellwUDRSQjZq?=
 =?utf-8?B?b1VNTUo4c2tPcGhXUGI3T082UER1MU4rSlFxMDFUeVVSVm41SjhXZjZETmti?=
 =?utf-8?B?N3hlSUVpM1dNZkVDZk9jNUwxM2tMcEpleVo1Y3RFWWRQRFIvbkJqbVRTamtl?=
 =?utf-8?B?MHZMMmJRRS8wU1RBbWY0NFlMQnRTck1uL016WHdNL0hydG9hWHBMYS94UlQz?=
 =?utf-8?B?cHd5MnluZnNwOFhzbThxclhlN3h2ZHk2Wm81c21Ob1gwNWl2clBib3lNWlRu?=
 =?utf-8?B?Q242Y29nOUg5TjV2dk93Mjh4a2NjcDM0UzZhbTJRT09LdnlVQk9uSWQvN3Q2?=
 =?utf-8?B?SkkwbFVmVVo1cUJORGR2S1ZqV3VlOTRLcEZUM3BDWmszSTJ4MUNiVllLQllx?=
 =?utf-8?B?OFZVcWl1K3RWTDNOSFV3Q2hwQk9ERFJjRi9EKzVQa1hzWDdFRVJvaHZPOC9Y?=
 =?utf-8?B?SlFFeEVYVytSbjIrNW8yVUhNZEN2M01KeTl1b2txK0hMZjFwZHdIRU1pUGxi?=
 =?utf-8?B?d1pJajVIUFdLeUpWZEVkTWRzQmE5OEx5NW9NU2tZWlh0VllibDY1cmpkK3k5?=
 =?utf-8?B?NGQyWkR1bVVHdGFDVGQyck03eDZtNzZPek1JRGkyT2V2c0ZsRXVUNExJemRJ?=
 =?utf-8?B?ZGVwYjhpYlM4RERxL0NCUkFWU0huR2JkYU8waGRyWmJEek9IMXBOVEpZWERp?=
 =?utf-8?B?N3R1ejJocStid1IzU2VZZEU5LzBIQmd4QTZ3ZllrT1EyMFQxR1JhdnMwdFo2?=
 =?utf-8?B?c0o5Zk91OFlDbUE5cVVyM2lmU282TTBuTENqNURWNlJ1VGY3RkIzbUVCMk10?=
 =?utf-8?B?ZUNOeFh1ZkU2R1BBSDZsSjRxeUU4V01jcWg4QlBNcXI3UFJDa3hjNlRoWHdt?=
 =?utf-8?B?bVJiT0dLMUdHY2ZjK3laSXVJMGlvYlFGS0ZYVTA0ZW5KeXplUzY2b0lOQVlI?=
 =?utf-8?B?SFA3TGEvUUJoR3FlcW15NFZWWTZLZE1NR3REbXptNFhjYlZQNXVMbEdkWWFv?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jBJ6O7zNCHdYUvKIPGmNlRPJtPFC70CfjrdJ9qSqU5qnEUCm5xJplj67wBf2FbY8bsQCk0xcScqg4FvIV1QIifODX322MPSBp/3o+ZeAAVp5w4g7LzKvZ2w8ODK6USyqiCbxH+CWtKYhVxMdprdeXaGQ3KIfyFWaFGaBliHILlw6C5WTR2Vv2DZ7kHaFlzjeTW7nQeS+JTg6NDt6MZpwR/cmMOIUyLHEoLqq8hykxwJteDRICxjYpVywrI48c1gUSzhx+MdeZxE+tvxvwX0Qjo+JxEW1euN6e+EQCoNlortg0vJnGsNzYlE8sIyfqM5uTcbhzI/5YFDNzl9Ns/r0fvRoCMJfSiqFzID2ZNpE4D+Q+aYOI8heyyjeLVPTgJES+9wjxGbdf/wzK0uSrBVFF7RfbiSNi91CnnoVlwWvqwnmNqZLEwcJ6c9OIePM6fAQbpPahMo+DKfVQ9wMy0MPpuLRi5+OkhiH02wOtrx+KVTkM/QyXWkZje56GB1ucWsj4j9GOx8mkyuCZzHNbe6KQwLJDuXSzr0JG08UADrXnTvBbKxzGXJ8UEgJWYDS1GbHAj6cm0aTT4Qnlh4LZK4RC3g5LsgHPok2zZsT7RoU1M4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40624d11-d5af-44f2-47bc-08dd2ab9480c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 23:09:02.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7+SNr9AeeotOcGjlKfrCQMcqFQJHEjtNYQkmq11Og+xjYUtTQM0LaTr9iXULJ0TDRy1PjCHL62V/y1OO5VrJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_10,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010207
X-Proofpoint-GUID: m7SG2XMy87KCY_YjDs330cBFtFgmoJhZ
X-Proofpoint-ORIG-GUID: m7SG2XMy87KCY_YjDs330cBFtFgmoJhZ

On 1/1/25 4:49 PM, NeilBrown wrote:
> On Tue, 31 Dec 2024, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> A subtlety of this API is that if the @nbytes region traverses a
>> page boundary, the next __xdr_commit_encode will shift the data item
>> in the XDR encode buffer. This makes the returned pointer point to
>> something else, leading to unexpected behavior.
>>
>> There are a few cases where the caller saves the returned pointer
>> and then later uses it to insert a computed value into an earlier
>> part of the stream. This can be safe only if either:
>>
>>   - the data item is guaranteed to be in the XDR buffer's head, and
>>     thus is not ever going to be near a page boundary, or
>>   - the data item is no larger than 4 octets, since XDR alignment
>>     rules require all data items to start on 4-octet boundaries
>>
>> But that safety is only an artifact of the current implementation.
>> It would be less brittle if these "safe" uses were eventually
>> replaced.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   net/sunrpc/xdr.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 62e07c330a66..4e003cb516fe 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1097,6 +1097,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>>    * Checks that we have enough buffer space to encode 'nbytes' more
>>    * bytes of data. If so, update the total xdr_buf length, and
>>    * adjust the length of the current kvec.
>> + *
>> + * The returned pointer is valid only until the next call to
>> + * xdr_reserve_space() or xdr_commit_encode() on @xdr. The current
>> + * implementation of this API guarantees that space reserved for a
>> + * four-byte data item remains valid until @xdr is destroyed, but
>> + * that might not always be true in the future.
>>    */
>>   __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
>>   {
>> -- 
> 
> This series all looks good to me
> Reviewed-by: NeilBrown <neilb@suse.de>

Thanks!


> though I do wonder if it would be better make the "four-byte" behaviour
> a guaranteed part of the API rather than working around a problem that
> doesn't currently exist and quite possibly never will.

It might be better, but I would like to fix the known problem and
document this expectation for the moment. I'm not closing the book
on this by any means.


-- 
Chuck Lever

