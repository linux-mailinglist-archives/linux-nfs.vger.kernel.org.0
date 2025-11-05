Return-Path: <linux-nfs+bounces-16081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA5C37607
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E5A1A21B25
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E93287267;
	Wed,  5 Nov 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gp6NOaQm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qHpHvfSS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29F243376
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368586; cv=fail; b=WywkGUfewPEJYcQL4GBar5y5RCiqZuTbjVD/gA68IIL9MxmxbyGz/3mQqm4eIumaiLI/KwGwZz9thttI7gSwXUZtV6KqW367IbuIHACxl5/lOjeMQcYWO9hEy2A9m3InxfAmeo3CpBQcMOPx9XxyYgGL+SYAZ9H83K3iSQM6BLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368586; c=relaxed/simple;
	bh=Tzw3ZJGPQRWIu4C5Lc7Ud/tFpW/xGlZjugFke7RKwj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXpH9gIiPXpvwP6JQH4j+n4nsUYndAPYN6J1h2hai2S6aGhe/NqOLiYoAI/K/ZrdAoGaz+c5Glyisj3qHtbnfUZLLu/q6pyOUV0ybzdaZ2a9vQEoFLp6RuY92T2F3kBBkg7T/z9RFAuNMFjcZEEs8f2/NGsvcQasPq9zmgtDodg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gp6NOaQm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qHpHvfSS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HESe9030090;
	Wed, 5 Nov 2025 18:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lMwvF8VPGbhpURDG8+HRtoIAcpCGHJZjnHXFfHJakN0=; b=
	gp6NOaQmWzx7g2ySaLOhURNftp0uIRQ69dxtZnNhnJfi7H+PPURMp6I8AdQLxDBL
	+Nc9MCY3DiPfCcfRJiN7VY1fGnIsZGd45t6JBmlDzHv/pKaIMen435vx4fhjtFlD
	u/yy0eUxXH+HiutYAdiVoFDESVUeeFy8Oa4KMJZUI2nGLEGLcJchTsAjrA/PDS23
	Z2kadWh0VSd/t/zfSQPIL1FJ4nVsCidbCaOWyNRVhidreUJDNIIx9LIFVPI9Px+7
	i8nnRicfK8MlvUFvzVRimzFC9cZmjWEZ9jOHC+Pq7Z7c4FcSjH8zLmd6n1AqSmf2
	qtDNj6YR7NjAJg1cw8LW1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at906da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:49:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IB9w5002768;
	Wed, 5 Nov 2025 18:49:40 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nexa5b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNdGuYBtX14E+OMakxDfW7ss6xHJHeqRF10S+jeFLjWySpt3lJjhAy0gV7vtTz9iQHLITtHBefrL7grlAPMdLja+ri3O9sS6tECY4iiOx4YzJcX25ZuAHTlbPnZwt92DImi6MXWh71rk6B1b54jaONpdQzwqW9m1NnoeUKsFCBXR+YYKwW8uDn1znGC8ZbCFef2WfwqjWgtAoVQN8HhDaW4zHMTBhcj5JkmGkruhFUbsNtQQkEka5nzqZ/0HwBzG89FV/XBrYd9D+RbJFDZEWAYsfy5BA+XmlOU2QgfxTFgZ1+lJlLNLEbp1JtngwKlf53b30/6iPFsJoFUtrggI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMwvF8VPGbhpURDG8+HRtoIAcpCGHJZjnHXFfHJakN0=;
 b=xa1aBcF765tiPaPkAU7S2hYT8in9hn4vRtjMu+Vtb1mhKCDVyevTTFUpHWrk9ZuvyENs/gNqo5WLjt8yQ89JFxQg3mmFTZtoYCaAw3VVtdXLGr5snMfBECtIUNrEnWHqp+pFiJBgPePDnYyutRH8WTSklkW+ITSewzD/0EKbYJLfORgcFRioJcHKuwn5eaSZU3OZfL7+odayfwEI8bPCxkRRfclYElg5cc5FJRZTjNAMq0UMII6IGQqMI+en+7qMIjKePFy6tfGBCmP8xpTqripR8NVtG3JMsQfEK/1RcLT+r6B7ne1QANvxaABfWLu7t3635p8RtKk5Fzd2DHPngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMwvF8VPGbhpURDG8+HRtoIAcpCGHJZjnHXFfHJakN0=;
 b=qHpHvfSSbyM2z+KrdNQFh0XG6hUXFuPUB+wasMFTniLlDbDl83NUL8EZlIyiAOvHx4Ytc5I8PU+qZbRVkTXuSIjqx/ZwEVmAvRqjZzO+7Zsdsk+WxDKjH5fSAMDw3N8xSqWZtr5AQGWV9e8084Dba0XdrBhr5spNeJrqErZgFcw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 18:49:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Wed, 5 Nov 2025
 18:49:31 +0000
Message-ID: <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
Date: Wed, 5 Nov 2025 13:49:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251105174210.54023-3-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0391.namprd03.prod.outlook.com
 (2603:10b6:610:11b::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 540c12c8-c8fd-4b5f-b1c5-08de1c9c0e44
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eWcxWDl3SVhEd016ejc4eG4vWXo1NW95Mk5rTGpyZDZoRWZwbFRCQ1BGcmdI?=
 =?utf-8?B?NlJHTURIdmhCaHdXcEpEQWl1R2R5YlAzWW1waTJHblE2L0R3WVo2L3UwTFJu?=
 =?utf-8?B?R3hxaVo3Z3ZMZWtsR1dVVklhTGpYa2t0RkhPaklOU2wwOGppOWQrTHI4QXV2?=
 =?utf-8?B?TUNRRFBMQlJvV2xieHlTcjJqNXVnWm10YjBwVE13TWI4dWgrRkNBS0t1eVgx?=
 =?utf-8?B?M1NiRW9zQTYxQXQyaDZMeFVQakxyQWJhVzM2VkhoQkI5bE9MRkcyZ0xRS2N0?=
 =?utf-8?B?eXJVZE5FREQvbkVwemNlODJHcVdGdkg2dDdPZzh5ZkR3emI1bTlZbElVMzZK?=
 =?utf-8?B?ZTQvSFdpaFJ3LzZCV1JkNG5MSFE0RytCWHAweno0YWNmeU1BQWY0bEw3UllT?=
 =?utf-8?B?VWY4RVJJTGxaMEUwWndGdjR1ZlJWQzhkVjhSaXc2SkdJR3lydVJsbUl1SGh1?=
 =?utf-8?B?L2hxZGs3WVl1Qk1iZjhIL3RGa2JqcnpVUGZSTVpqaTJLN1JoTjJsem9Ra3Vm?=
 =?utf-8?B?NzJEYzlGZHNWcnhoWWRvN21UOE1adVpxeThnMGYzVlB6QXphQkZuMThzcUV5?=
 =?utf-8?B?VXArMFE5MmNSV3MzbjJUcnVIZUw0RlZuUXZsTFE5VVZpOW9Hdlg4eG1STU5m?=
 =?utf-8?B?T2xDV29ZT1RBWEx0UFpQeUpCYWtLTFUzcnRuMmJGMmhWZzlmTXl0M3M0U29T?=
 =?utf-8?B?M1dWckc1aXA4TkU1QUIweHRnRjNZR0RRNmRVNWgxMDVsQ2piNHN6aTJtN0h3?=
 =?utf-8?B?YXhFejJCcWQwSXh2WjBtSTJKd2RUblZ5M1B2M0Y5Y2phL1BHeUhhMDFFYnJz?=
 =?utf-8?B?TCtrYkxHS0dRTWJORWpVVUhPR3NjaWZXeDRqZ0RDaHJpdVhsT1BUVnMwQzYz?=
 =?utf-8?B?ZytNZWk0dVMvRkFYVms5QjJuZ3BhNTl6TkJJZE8yQlBjUkdSaVpTTWpJd0tU?=
 =?utf-8?B?dXBjUm1HRmUyaGlJS2k1Q0FZem1qL0ZjWWppSWh1OExzWEJFSnhzMG9WY2pa?=
 =?utf-8?B?TUZOM25MeGF4TDFvWFBiUldVYjVrMjhoYjZ0Wnhiek9FYUR2MjJ0UXJSWWFn?=
 =?utf-8?B?RTRTNVJIL1NFbVdHQ2tHb0dZbjNUU0svNFhYa0MweCtSOWF3eUQ0RmZhZWJ0?=
 =?utf-8?B?MTM0Qmt4Q0ZZVlRwTG5tZ0ZFb3ozNHlDaHNSVUtSejRhNWVkcEF0SFJLWUlQ?=
 =?utf-8?B?MnlJdWRaZmVnV1FWd3JHc0xEeUlwS0NJL0Rrb3V5R2FEbGVTa0l0MEtPdzJE?=
 =?utf-8?B?U29sbnBZc2FIMU5SQm5hWjlUQVN0eGQ5ZkFkOG5mMk00Mm5GaHlUM2dQTnQv?=
 =?utf-8?B?U1RoTkVBODNrYnpDQmFFVm9UdnExQTVrTXlHWDA0K3RLQjdITmQ5aUZyVVVD?=
 =?utf-8?B?bG5hUFVrTDhSY2hrT3RPL2xINU9EbVJPRkNyYXhMTHVmN0tHN1NJOFliTEV0?=
 =?utf-8?B?ck9CR0FIc0R2dGc0MmpranJhNDFPQ3J5UlduZ1k3Z2ZoU1JLM1FCRHpIL0J6?=
 =?utf-8?B?bjBKclg1enlxWWJSQUc3MW5wc2xPWDZpY29SVER3SWoybHByME13VXR6aGpG?=
 =?utf-8?B?M2dRcjV5eWUyR0N0T3NlMWs1K1k5NzU2emNRcVNELzdaNzJSYjI5QkVES3lh?=
 =?utf-8?B?RVNqUldoWlFPd0tEeFZDNmZGN1RuZnRnOTM3enNhbzMvTjhEZzl5Nit6Rk5j?=
 =?utf-8?B?WU4yMzVnTjgrejlpanFISjZqdzMzWlZZdzlkbXE1bCtmVGZJb0N6TDZSdE1G?=
 =?utf-8?B?TTh5NStFcmZ4VlI2d1ZndHo4MWVQOVB6NkpwcjR0c3NrTXVJd29HeGU3Rjd0?=
 =?utf-8?B?WDJNRXY2TW9CU3duSUo0eTl3YUc5UGp2YVNjUUhZa1U1bGR3VXVCSHdxQVc2?=
 =?utf-8?B?eWlZKy92OFFYRXVNdFJucXBLc2VwSEduSy9iV1BFUmhDenFZRUcvRlVDUWVm?=
 =?utf-8?Q?uYy1lxdA+61Af17FJ5yWseM9Ez6JGNeA?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RnFQdUNCZm1NdldLMmNBWkJpV3Y3SUhUUkVFcUt2ZVZQNmd5UXFKK1dDZ1FE?=
 =?utf-8?B?REpCL1NTNzNGVUxEUnE3cjRoajhLemkvd0VwbEtRN0M1TnpNSG4yTmduWm5v?=
 =?utf-8?B?Ykd0SG0xajFpQmNYT0Z4T2JSalpuQmxyRFBLZkJTaHZTZWplanpxd0c5bUxi?=
 =?utf-8?B?dUdWbHY2KzdJSXY2bHhVNmFod0JKMFJ5SDBOWkFXcXM0NlFUSy9CeEVXRkpz?=
 =?utf-8?B?Vm9DZTlGa0k2SkhVVmtNbENSY0xLUGV4Wk93Z2FNRUhFeU9GY3pUWkMybFE5?=
 =?utf-8?B?SE4yNldUbm9oTHFlYUFoNTRuZUx5MGMyeDFYb2lMak12b1ZOdXZ0ekFmM3Vh?=
 =?utf-8?B?dGpZRk1wWmdTc21oeG92K0hLK2x4RVFCT3k0ZnBRenRkckgvQkFBVmhnVTlL?=
 =?utf-8?B?RGwxQVBGeEZXYmIybXIzTWtodmFZdUo1RnI0bzVmN3oxRm1xVXRubmhRVTdq?=
 =?utf-8?B?YVRKaFZROWhtUkdxYjMxRGhSUEMzZjJJZlRtTkFUcWFXT0tCK3Q4eEFWV1ZX?=
 =?utf-8?B?bGVtUUZyN1daUi8rWllTeHpBZUdsYmdaM2JRSndpbkxqOG92UnBiWGd2ZXpQ?=
 =?utf-8?B?ZlhuQzJFZ25rVzVTUlJkb0NMYXZhSzJjMDhmbENmRUtIbFdvc25NTm9hTjBv?=
 =?utf-8?B?TlpaMHJDckpkOGJLeUhWTG5Ec0wybnZETWlFdlJWVTQxTlE2allVdGFScm5y?=
 =?utf-8?B?R2RlSzlZMStjNDl6bGdCS01JNDZxVjJZMGNlVnhXZ2dLRHpFWjdqSi9YQmFl?=
 =?utf-8?B?U0ZvT3pKS3pyczdIdWowa3ZTQk9jUTUwYXlqODdKWUp2Q3hYbGVEYTNaUVFr?=
 =?utf-8?B?aDdvRXVMcVhUMmZRZmxqd1ZnOVZxVjR6aEd4S0ZiZmM5MUdSckZUWmVuRTZI?=
 =?utf-8?B?blFFaG5DSGZlOEFCK0xGc2FJV0l5S3ZpRDcxNHZnNUhaWnZ4Y1gyWGJEcmJt?=
 =?utf-8?B?SlRXeUIwN21vam8wMTVJUmtUWGNmOEJodCs2RWhIajlJQjVzY3Z3U0EzUFh6?=
 =?utf-8?B?OEhuZStUWE9XYUlIQWdldjMvUnl1OUJUWFkyR3NrdWtzUnpZaFZGWFpFcUlq?=
 =?utf-8?B?VFB3Z0l3aEhlVDVtVzAwcjZ1cFM4QVF2V0Rybmk2OEp0UzU5NWh5VVB1bmp5?=
 =?utf-8?B?R1gyMUxsOUF4SnJqMlRNbmtmcC9GYnUycTRNdlQ0SnNwUTR2UHdTRkRQRmpY?=
 =?utf-8?B?QjJiZ0tLczhhemRqVHhIQjl5cEJESXJqQzBqamFwUW53NjZSdEZ5Vi9OaTgx?=
 =?utf-8?B?eTVST1FSbENpdm16clJFZDQxb2hXWFlXQmdKSW9JOG9aTjNsS09DQUFFWW1y?=
 =?utf-8?B?bkNoejVYWVlieGRhdTNZZ005bHpoWjM5bFZvUDY3S0Z2anVlOUh3dGdJZWhX?=
 =?utf-8?B?Q3h3SjVCbW1ubzRZUVlRYmFQdFpGSHRTQnNiZnJFVlZBZEJqYld5QjdmbDJL?=
 =?utf-8?B?Zk9hakJhVHJQREcyNG1CeFZmd3lhVFJDVVFrM25HL1NLamc0T3JHbGRIRW82?=
 =?utf-8?B?S211US9rdHZvVnAzNGYydSt2ODlqeUJwWHdxa21vU0cvbVQzSm1WblhISXc4?=
 =?utf-8?B?YjN3QzFqS0lpTGhuaWNLaVptMElzeWpEeFNiWHgrazB5Vis5Nnd6MWEzWTdL?=
 =?utf-8?B?RitkN1pVdGt3akRvZkFkN3FiZENEYlpiSE1BTzFaN054amVRUnM5TlQzcG9w?=
 =?utf-8?B?MGpzZ0lzbWRxamtRMTU2MDRhM205L2VtK05GNjZJZFAyY3NrdTlCVVBLeHVP?=
 =?utf-8?B?VjAxTHczY0xlSjZqbUZnMXZWNzU3VXNmS0s5U2J2dURkU3lhTGUvZzRJRzRp?=
 =?utf-8?B?TFNyM3Y2T2ZzWDRXNDl4b2ViQXBRbUczWVhPa1ZZRGJsNmd0LzJNZUR1M0Zi?=
 =?utf-8?B?dmdZOGVOK05yWnp5THRTSDhOellleXBJUkNpNzVJME5XNU9XU0NaRFA3ZUxo?=
 =?utf-8?B?QllnbGNjcFV0UHdXY3lQQkE1Vk5IV3RzcE1IVDcyUk92OTJ5SDBkQ1U4NHRo?=
 =?utf-8?B?Y2RhQWNsTTVnSmZocWE4NEFCZXl6V282V0hyVmZ3RzhVWVZZZnUvbWZTTitW?=
 =?utf-8?B?TFQrMzJXZktYb002alc4clF4Sk55NEo4SHdWbnVvUFF3VkR6U3ZTcmJ4UVJY?=
 =?utf-8?Q?Noa6l/El60gf0sPz0rdb49WR7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+fL2vkgB2Vpep1VLUKF7kv7SBT9Y6c1mapmOq1nnvXcth3NgyqqvuhEsydEjuyxQLeXmSgLQLhMqNLC9Qy4xbh7SXO5i+un+86JGRSjELQtrPHVcSEoC7bPwC+psgyhI37ft6fNJumoGh0rNEhd3M3jXykETOHINAZ0oSOA12B2Mz3aM3TMMGQOLBARXrHEzMCZ8tsb+UhxHV+9ROLTF9y6TI6UAgDaBQSNx6FxExUdxlLZIzc3ujnFGx+3X0GGlTT5QowNAGmAzELJVRkP+H+pHN1elfoIBSEU00lJUH5AtwDDwY7vd51kkd60P4QyDWAziz95ANvtz3uY99IAqLiizvO99B83SfCGnIb49u2IQA12VFva6mpTz3kn/aJ5tMGsfcD/mm0V2ZA52JCjwN2X0baO81SFSmhtZoP6PNk8eYeH7JJDUBFaHhVcgCi6SnaCpCaZllSSehJlXXqB677KA8EECj9ovBb+OEuFdJJpwQ7kp1qsV6d2skB1DYqk8AtzxpbCLbZlSpvthHhlvvLUib7bNqT13KRqAeJQULgpH4Mu7WLMrfKdnIhlXMx8qtHztsMGxrh+0RvhYXhD0LoYbMhp4IeWXFzVvwscxFN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540c12c8-c8fd-4b5f-b1c5-08de1c9c0e44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:49:31.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW0lkvkIVIg5e7VXjnZCZ+rEtNd6sXjHEGdXOT3bpa5VdwAc9GLT2Yak2u+wrOBFnwf8eMSqdMdXplpP6xvnNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050146
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690b9c45 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=fF_Q0fgFtSQEQlhJBI8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-GUID: jXmIppWx4LCVL70W0lL4OC0szbsDCc--
X-Proofpoint-ORIG-GUID: jXmIppWx4LCVL70W0lL4OC0szbsDCc--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfXwSBLdcFMzk3d
 Q6wndu7gbViP6ue1j8gIkz0kAXhcCWlgL8oodqgK+w3ZT0oy2coaI8ZmYcInb55okATa+GATmyX
 Aa3lCG1hKLqYczByx4jieW4bUhtW93eD46Is7BOcVQwAjVa2uCiodMAfuvzg62WgJ/cp5ATF5WC
 GManojytxVdf/zks7/5bQvXFcYvkhAsa2nsnNGN+n7FUyHv+MrscYU00KXGnmGRy0mzYxOmt9xL
 LZ5ULB7ZbzvQpUTZi9lRWbOxjfRd5dDeXrN0LuPQKdCMWfyLu7Nus82LuZ+cg6NteBOb+RG+NI4
 L2nbVZl/KCZyj5lI6TiKROfYDPy8haBqaKj9evJnRxi6D+8s/10kITsHHdYhgEVuDyeECjmHnEC
 s9qN9AXSZyBOyCOoDf4oUPP2ScLPIUJEroc4bg5WdlOm/vTT9mU=

On 11/5/25 12:42 PM, Mike Snitzer wrote:
> NFSD_IO_DIRECT_WRITE_FILE_SYNC is direct IO with stable_how=NFS_FILE_SYNC.
> NFSD_IO_DIRECT_WRITE_DATA_SYNC is direct IO with stable_how=NFS_DATA_SYNC.
> 
> The stable_how associated with each is a hint in the form of a "floor"
> value for stable_how.  Meaning if the client provided stable_how is
> already of higher value it will not be changed.
> 
> These permutations of NFSD_IO_DIRECT allow to experiment with also
> elevating stable_how and sending it back to the client.  Which for
> NFSD_IO_DIRECT_WRITE_FILE_SYNC will cause the client to elide its
> COMMIT.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/debugfs.c |  7 ++++++-
>  fs/nfsd/nfsd.h    |  2 ++
>  fs/nfsd/vfs.c     | 46 ++++++++++++++++++++++++++++++++++------------
>  3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 7f44689e0a53..8538e29ed2ab 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -68,7 +68,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
>  	case NFSD_IO_DIRECT:
>  		/*
>  		 * Must disable splice_read when enabling
> -		 * NFSD_IO_DONTCACHE.
> +		 * NFSD_IO_DONTCACHE and NFSD_IO_DIRECT.
>  		 */
>  		nfsd_disable_splice_read = true;
>  		nfsd_io_cache_read = val;
> @@ -90,6 +90,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
>   * Contents:
>   *   %0: NFS WRITE will use buffered IO
>   *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> + *   %2: NFS WRITE will use direct IO with stable_how=NFS_UNSTABLE
> + *   %3: NFS WRITE will use direct IO with stable_how=NFS_DATA_SYNC
> + *   %4: NFS WRITE will use direct IO with stable_how=NFS_FILE_SYNC
>   *
>   * This setting takes immediate effect for all NFS versions,
>   * all exports, and in all NFSD net namespaces.
> @@ -109,6 +112,8 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
>  	case NFSD_IO_BUFFERED:
>  	case NFSD_IO_DONTCACHE:
>  	case NFSD_IO_DIRECT:
> +	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
> +	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
>  		nfsd_io_cache_write = val;
>  		break;
>  	default:
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index e4263326ca4a..10eca169392b 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -161,6 +161,8 @@ enum {
>  	NFSD_IO_BUFFERED,
>  	NFSD_IO_DONTCACHE,
>  	NFSD_IO_DIRECT,
> +	NFSD_IO_DIRECT_WRITE_DATA_SYNC,
> +	NFSD_IO_DIRECT_WRITE_FILE_SYNC,
>  };
>  
>  extern u64 nfsd_io_cache_read __read_mostly;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a4700c917c72..1b61185e96a9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1367,15 +1367,45 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  		args->flags_buffered |= IOCB_DONTCACHE;
>  }
>  
> +static void
> +nfsd_init_write_kiocb_from_stable(u32 stable_floor,
> +				  struct kiocb *kiocb,
> +				  u32 *stable_how)
> +{
> +	if (stable_floor < *stable_how)
> +		return; /* stable_how already set higher */
> +
> +	*stable_how = stable_floor;
> +
> +	switch (stable_floor) {
> +	case NFS_FILE_SYNC:
> +		/* persist data and timestamps */
> +		kiocb->ki_flags |= IOCB_DSYNC | IOCB_SYNC;
> +		break;
> +	case NFS_DATA_SYNC:
> +		/* persist data only */
> +		kiocb->ki_flags |= IOCB_DSYNC;
> +		break;
> +	}
> +}
> +
>  static noinline_for_stack int
>  nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
>  		  unsigned long *cnt, struct kiocb *kiocb)
>  {
> +	u32 stable_floor = NFS_UNSTABLE;
>  	struct nfsd_write_dio_args args;
>  	ssize_t host_err;
>  	unsigned int i;
>  
> +	if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_FILE_SYNC)
> +		stable_floor = NFS_FILE_SYNC;
> +	else if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_DATA_SYNC)
> +		stable_floor = NFS_DATA_SYNC;
> +	if (stable_floor != NFS_UNSTABLE)
> +		nfsd_init_write_kiocb_from_stable(stable_floor, kiocb,
> +						  stable_how);
>  	args.nf = nf;
>  	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb, *cnt, &args);
>  
> @@ -1461,18 +1491,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		stable = NFS_UNSTABLE;
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = offset;
> -	if (likely(!fhp->fh_use_wgather)) {
> -		switch (stable) {
> -		case NFS_FILE_SYNC:
> -			/* persist data and timestamps */
> -			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
> -			break;
> -		case NFS_DATA_SYNC:
> -			/* persist data only */
> -			kiocb.ki_flags |= IOCB_DSYNC;
> -			break;
> -		}
> -	}
> +	if (likely(!fhp->fh_use_wgather))
> +		nfsd_init_write_kiocb_from_stable(stable, &kiocb, stable_how);
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  
> @@ -1482,6 +1502,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	switch (nfsd_io_cache_write) {
>  	case NFSD_IO_DIRECT:
> +	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
> +	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
>  		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
>  					     nvecs, cnt, &kiocb);
>  		stable = *stable_how;


I asked for the use of a file_sync export option because we need to test
the BUFFERED cache mode as well as DIRECT. So, continue to experiment
with this one, but I don't plan to merge it for now.


-- 
Chuck Lever

