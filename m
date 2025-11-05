Return-Path: <linux-nfs+bounces-16080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70669C375EF
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 19:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCB51A21474
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9052836A0;
	Wed,  5 Nov 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fvotjZ90";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eKvtpXJ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A2258CED
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368506; cv=fail; b=HqWjNyP3vvMH61NMycW7cyiOBi2yvl94bvKflVc84ggH4++c2RZTHRtknrDmWznm8e4SbYpwYNXqwKP2eFhYU5RIwM/4eMRprSKraDgHMOkz6KUUL1ZYoR2w+YTKqyVPd8B6l9/TYnMg99fqVgvYsgaCEneBHZytwd3sGd0DRAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368506; c=relaxed/simple;
	bh=5T/HNoc2INLFQP3ruq0L9AlEWsoAZ3Ns1Mt/1DaXKzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eXwWfOojF3O/NnorEgBwdsJ7qHSNfu0wRKUcnLI82XG+RAMK8gPHCvPUe+bwa8J1QHT2zHUTEw1yWnDD5F9231xSBeeM26Mf71+tPquzxceNHAhj0ZyKpyxA0r1E4y0IQII4ZjbgllsLYlMgVC6tZrI47iDNM54Wm8igBs1kmS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fvotjZ90; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eKvtpXJ1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Hdm5Z017480;
	Wed, 5 Nov 2025 18:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HnS2LPHRGV+DHNEPcWbfFvwWzndM6grJML0JzO9vhCM=; b=
	fvotjZ90dBj5EXJd/vLnsgMIkdfIz8BJdmd5kVdLmt0GxU1DpBWF/YDAO9r0sFb/
	RNmte0bv6ozdt4H9HC1DonoLPOua71i7obRnMQA4HoPJqhfsEYhs/Jnq7gvQwaRr
	iZwPpl/K38S+GNreJkYjoRPtJhnVzvVUD5xiyeU9cbXgYz59ColrQU3iyiQPOQr1
	6OnaCvERu52mq7T/KZLyIeSVOh6KQHQHfheYU+Xrqbou/SDrz/LKPGUPmWT8Xqpu
	sFpfJ3vNWNcyoXbFjRax+TEPtjWuLzH7a63vWGSakx4P3eZBP8GAYUy0NqPwK3rI
	r5fBx6N26DQ4ce3gBUTnaw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8b5yr4vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:48:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IA4Nx023032;
	Wed, 5 Nov 2025 18:48:20 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58new8tj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj+t6WPsFbHZg+Fo5/VOmzq7f8l+mayuZJKdE//bCkvf7aDqSRmTU+9w46aKnHmDn/5ykUj1mkvHsM6mCzKpfbbbGe1cjgk4/nS425BOqDzj/xlkaw68S3qeTsJXdoKeqbaBIguDdsNlO7yY5A9HrGoqgoaPM+jp/GuRY4CFdwUVkrxMBzt1QWwCiZUeF66hDjVQ2GxcEA/0VnvazQoWrytmKoLoOV1p3xGtiP2hP5I1kjQJB6ZCzQTq2GuO/iTxidxDlOUO47/nU0Oa5dGEoYOMUWbeR/j51WHHUwL5+Zn7WXO41yGCmESO8Yi0o7c5xWPrFoBDesc7B9XTLU+Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnS2LPHRGV+DHNEPcWbfFvwWzndM6grJML0JzO9vhCM=;
 b=ihPY1/JEr7ipWzM6asUujvdfgX4IYklBcRmsBwvuZUCdhT56tvEtLb6Wov6A4941SF24/wQc5MgkQNzN89hiC7nWs8RzLmOyo2KZq1GiKV19XrsYgPgEtjLEL8xLdTCFtImC0mExTCjEK//FpX21l7kmBUJdi85GshfnO1NqeEriq913e+XDsd8izX32XiQPH4Vo70DLoOnha//cTWrUX7572IvG1oxVvB1QjWtwLJw6VTo3853I0motWgEgPA7m6qzqD+pLfYBH2sLqEYwRWhKT4pyNaW7tVYhfNty4XEwTalo34rH835f9c3hZHCN1FrK8h7SoQ8dEFTzYyJnfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnS2LPHRGV+DHNEPcWbfFvwWzndM6grJML0JzO9vhCM=;
 b=eKvtpXJ1t6cDeOBXFww+tN+ohNdppc0twMCwRTPIG8v8VsQfi9w0df5VsraNt9nq3HZSOVG0EEajv4npgYMSOJnDre3b7AJfdpWJ3oXQLBrUiEzvt+povQ588Wb2WnoST7JLVD6AAgkOOhHZcdMd1HQLhqTxvO3UGkRtUgDi5ws=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 18:47:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Wed, 5 Nov 2025
 18:47:56 +0000
Message-ID: <7b4aae90-cdfb-4e0c-9e4a-ba680cb1ac5e@oracle.com>
Date: Wed, 5 Nov 2025 13:47:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] NFSD: avoid DONTCACHE for misaligned ends of
 misaligned DIO WRITE
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251105174210.54023-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 16faffc9-9cba-4a8a-2742-08de1c9bd5aa
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?LzZnbmUySTlBWTZieUFEdTExcWJOYUdoUW43VFN4N3NwbVFpZW14WU1SK3FY?=
 =?utf-8?B?amxYbmdGL3hoUE9vQjh0ODkrNGxaQWhKT3RKWE0rajRmQUZSSEQ0T0tjVWov?=
 =?utf-8?B?U3JMY2pDWVpFZHlIS1hkMERxaThkOWRXOU9GZCtpNmtWUUdUSjRRZS9NWHRF?=
 =?utf-8?B?K29RbXNTUmdNS0NiVkE2VUZ3TG1ndGk1amVubzEzbGtyNGsvSTFjT0RIQTFH?=
 =?utf-8?B?ZVBZNEtLZG5XUTdjUHRwUklaUnRBanIwUWx2THRHNlVBczdnTGVXQWpTd21C?=
 =?utf-8?B?cDRyVU5ydUJiYXJHUWt6UysyZ1RMdzlSbllkYWc3d09keFNPL1hacWc0VzhL?=
 =?utf-8?B?Vzd6cmU5MHBCZnpDVFhDeUE0eXR4aGhFWmZLanI4bWR0WDdBQi9Kc01TODlJ?=
 =?utf-8?B?NHpPNVlOS3ljc0tJSzdPVE55WWpSNGYzckcvUVpHanRWVDR1dk55SUNmc0N4?=
 =?utf-8?B?eGpSdG5heThvT2JtU3dIQmVWYlJZL0NRVWlJS1lSOWNncExyVnV2OEozU0Ny?=
 =?utf-8?B?Mk9vcDlXZ0tmT21CaFgyM3RpUGJseGNWOEc2c3drZnlkUGs1Vk9xQkJ5YWxI?=
 =?utf-8?B?V0ovUHVBWnFYRFRheXZ1a29IVVNXSmY5dnNJQ1NDRjFTcVNpQ0NXMjZkaDYw?=
 =?utf-8?B?eEw3dkxYZWdrdzNNOVNhMzhXWE8wdlZoV1EweGJHcytGVE1SdlBWUlBFaUFR?=
 =?utf-8?B?N0MzSERPOUdBSHpENUZzVmV4VmFERHJ0RXJnWGw1MUJobWhkNG1FQjJ1N1VU?=
 =?utf-8?B?WEd0bGdoWnRlcnVlWEJEa0hMM3RaWHpjUDlVelZ3L2NiZGNoZWdhTTdOR1Rx?=
 =?utf-8?B?N2FJR3d6cjJuVDFPUWk0Tm1GZjNRRWQwS3hWd1hhOGRGUzR6Qmt6cVovSVdP?=
 =?utf-8?B?SzFJWjNhSDdDWEdOOGRhcnlpQms0Y3NnV0J6Y2crUzI4WXVMMnUrdWVMYXVB?=
 =?utf-8?B?MDluQmNKTkk1em8yY0dVQkZGYnQzZmNMZUhmRHhCaUVTWk83aWdlVTNQakdE?=
 =?utf-8?B?blBPa3ZMTi9tVFVCWUI0bnlaOVlHaUpad3BLMnk0R1VnQVAxcWJkN3RENkV6?=
 =?utf-8?B?TmNEbldpZjZEVGlEaXZWYk1xT3ZSTkNWSzN5cTdFWHpTeFQ1N1JZdlRwbTZJ?=
 =?utf-8?B?cmFJWDE0M3ZERE4xc0VaMWRuV21vMGdkSnVFSTc4VHRlRFJQUVdPOEsxc1pZ?=
 =?utf-8?B?V3ZmSkplN2psemh0QWplK3lOWnNneU11QWxpYVRYNUZRdWE3SWozTHFCN0Fv?=
 =?utf-8?B?VWJEbXBTMlY3UXlpR0dCVFJBTm1oY1R5ZDFKQ0o1SitBS1dHQ2RSaGQ3YW01?=
 =?utf-8?B?VFB0TytWem5vbUwyaVY0SWFoSUN5cUVKNXk3MlV2bkhhUm5aaHQrNk1FRjhD?=
 =?utf-8?B?VCtybU1KRENKWnVJeTlTQ01NQTlLV2x1OExCendzbWRRZlFjVmRhZ1I5dWZG?=
 =?utf-8?B?NzV1TmZTWDZwNzc0dW1KajRVMzc2R1llaHVQcy92STJaamE2LzJUN1p0d2Iw?=
 =?utf-8?B?UjZrZzJDY3pSRjBieWVmYVFrSzZUS0RNak9nRG4venlnOGdxQ3NMN1B2U2F5?=
 =?utf-8?B?M3QzUFJoWjZOcmdQT1pQZFNpcUNNMWJEUHFMT0VmY2ZBV1RoU3gxck9CdThX?=
 =?utf-8?B?M3M1a0lnbHMrV0ZtOWQrNjAzdWhtMEQ1YW5YKzZxc2kxV2d5OXd6cXRaQXVR?=
 =?utf-8?B?aHJmbTg5QjRPNjh3cHg4RjV5d1RoRFlkNEZvRUx6NjFyc200cHkwZDkvRWFm?=
 =?utf-8?B?VGY2UmFmRXJFOW9sd0JLK3BSRFZJeThvZ05xQlJaalFKdHR2cGFQRTRDcGVR?=
 =?utf-8?B?dW9jeCttNDMzYnVJVXBiZlVKUVlFanIxcllBTkVkSktXS3o2NWtNSjhvdk1D?=
 =?utf-8?B?dGRQeTYrVHZRL3VlNjhJbWhsdFVtczBJNWV4dGJCaE5XYTZDUS9nYmU2L3dE?=
 =?utf-8?Q?z+3Pk1+1nUUmmaAyzQs4nM7+YEmXF8Bz?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YytEWHJSSEhPbVptNXdrZU1ydFc3QlkxWnpQRHlRN1pVSEZ6VmYxRGxnODlu?=
 =?utf-8?B?VzNUY2w0dW5TL1pCMEFpblYrWDFoMytEZkZxQ2Jpb1N3SVZzNWw0Sk51bDg3?=
 =?utf-8?B?c21jMndmZ0krY0wvMTdvOFMvVWFGOEtiUjMwZmc3OEs2NzByN2k5OG1jZUV1?=
 =?utf-8?B?SzVjWDlhVXpoQkg5RzJZU2hJTHZpZlJxZWs0cVFwUHpFZ0loTUZtcW9vcFR1?=
 =?utf-8?B?VHpGWXA3ZDJVL2RNR3UyTHVTblprTXhBaEp2RWlBb0M2MTVBYzhMVHp1enBP?=
 =?utf-8?B?NTM4TTVnZUFkcUVpZVhvS0thdS8wZWtQejg3TmV0MHRsTEdJdjJyYUQ4cFBS?=
 =?utf-8?B?YzkwOXU2UnFOUDJGYlJGc3kweUNFQVVrMWdsWWhxSlJUdkR1OFRCaWMvK1Vr?=
 =?utf-8?B?K2x6QWlrSXMvdkFHdmtZT29qSHVIYlZJTTJhRGljS0RpSkMvSzJjZUUwbDJS?=
 =?utf-8?B?Nmc5Y2FJMUI2ZkFValhtQU9ub2YxZUJ6U0IzT0FsNFlFS3RVK1ZIM0ZNajdz?=
 =?utf-8?B?THkyaGFPSzVsUWxuY0R1eWdIYWgxT0owbzU2enc3ckp5dmhrRytnbnZxUHBx?=
 =?utf-8?B?WVQ1cUlZKzZpamN5d2NOZXZGKzlkNlVWOHhkT2RXYVJIUXdXb0tJYjlwVSt2?=
 =?utf-8?B?OXlzQXFFT2k0bUw0dWFWR1JpU2R3MDcxYTJqS0QwSW1OWmxLeXlFenQ5MVBE?=
 =?utf-8?B?Y3RKVGZ3WHd6K3cxSWNtakR1cUp2WCtsK1VJVXBJZEVTOStJNE9hSHI4T3A1?=
 =?utf-8?B?cmRTd2puK3U5MlZFS3ZoYjMybllFYmZkdGdMNTlPaEJFWURxby9wWVlmZDds?=
 =?utf-8?B?a0NQdDlmeUlaWllBTCs5dDR3c1FMNnprNXlaODFjMzVSNWplSjJBajFpdlpE?=
 =?utf-8?B?QThqelZyemNmZWk3Q0dIbjY0bGhoYk41S1Jaa2p6UHV2UkhrS0dyR3lmbjBp?=
 =?utf-8?B?R3gzYUFlQzMvaTJYby8wbWV0aUJ0d2tGUVYvZ2R0a3ErUXJxeVlhSi9ibk0r?=
 =?utf-8?B?dXpjNVQ2dGM3cnJDK2lKMnNNUVplU2J1OWtST3hXM0UzSGs4b2xIaFNlTTNr?=
 =?utf-8?B?ZmVLQjZ2SGVBcjJUcmE4K3RBaTFGZWxjSTYxQmFjV2Z6aDNhbnhYUGtCa1Z4?=
 =?utf-8?B?UUk2UWJDUDM5NlprWWdIc1YxQnVRZ0ZwN0FHNFlaTkkvVDVQMGh4b3M1WVZn?=
 =?utf-8?B?bGpVNTdLNEhwNTdnOWwxUERoVzNSdndKUDRlVmZ3aitKN21Bd3I0UTVJVU9l?=
 =?utf-8?B?cW5rYXVWdzFZRVcwanhqWVJrNXZQY24rTFQ1YS9PbXJmdnF0Rk9NY0hhQVZz?=
 =?utf-8?B?K1NQMCtBK2lIYWlBWk80YmhsNUVUZ0lqWDhXTFRpSjRtcDBCd0hKSkxZSWF1?=
 =?utf-8?B?bmRCbStOMTVkZ1pPKzRTQmY5T1gvSkZ1aUpxaDFIVFl4TGZGV0JPYkVXMWFU?=
 =?utf-8?B?SXhwMEtXSVNpd1NadndZZHovTVBQYTRMcmlZeTlPaW1DV04vQ2VMbEpuQUp2?=
 =?utf-8?B?b3VQSGdoKzQ3Znh3TFRkT09aM1V2L20zMkJtc0hSaUQrR3ZETGwyUW5KOGRw?=
 =?utf-8?B?VXRQenM0T0F5Y1BUTmtoWVRtS3ZtcmRpVmloYnRRdVFZODhvaFFvTEFTd1lU?=
 =?utf-8?B?ZjUxM2tob3VVeGFraHZNTEZ6b2Ric3pVN0hkNkJSbUVQRitkeWVWcmN0MU05?=
 =?utf-8?B?WUZIMktHSkV2SFhheWxMM1NSbDVsT3F0Y281UWdUY0cwa0VvTjdYa1F2ZUhR?=
 =?utf-8?B?Mzh5bzBqK3JHaEJlMHFIaFE3dnJYYXZ2eDBkVmp3THhEU2x5QU9uYXZYR0VK?=
 =?utf-8?B?SlNhTnc4U3BJWkh2dklYWGZpRFhxUmtvaUN6SzFieWlKb1A5VEdoRmhkYm4r?=
 =?utf-8?B?dk00YzlCUGVxdjBkWTc0SDIzRzFzZ1dYYnI2UmR0NkZUL3htMzd6VUVGOW81?=
 =?utf-8?B?aEhQVzQ1a29KTWZxQXQ2cnltcXB0VHBhaXQwWkVKaDdXbUNsOTc5czRaN2tn?=
 =?utf-8?B?cjFRaWYwbVY4SjFoQmk0Nk1PYml6U3Vpb1o2alpBdFJOL2U0YkdSWmNiNWN4?=
 =?utf-8?B?eVpWWlNpNUl0ZVBCNVN2M0RDSG9uREF3ZHhZZEVxY2lZMWk4Z01CWC93S3c5?=
 =?utf-8?Q?qvMKtLLT5aQmWIfBJwCZVGLLn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfYDiblNFE0J0WRkzH5OAaTVrLEO2czir83QFFZuaR6yls7W+vEMUrLFTdoibQdsurr+a8wFrYMtlzPW2uoYMk+JcyMRhEGGDQm5qAhpYaLBDe0wD+Y1f24pt0/bBVcXcXS6ktbk4i1e6Oc8wdSo1GBUbs2PN60yAK5FdTfnGL+zauDOiXsXF2aLtWxaH7Z9NTg9l/GpeVIf3bc8p2EMJJFnF60yYfYKTkcAnUChSwdHOcYXraDsNnFbzyzqWnGZQrr2KVKVGtaw1J8MYJLfpEXREkRGphV/fZ8FEhkR5sO1bcJCaN4rX1VjyKIKssCGfa6Vr+0LLzOlSdgwnoVa58xpGSVri8qcPUWI9RwsT0FgXm3d9ebYfutgPTUmyzE3slLl7bTSXHcEGBGlWPyLR790+JP9kZYHH+71rVgIOCXx3y0FaekejO7qDVjCj+qBKPBbOuS37vh92ekXq+nT5aJRNJmROUgbnRSfygZz8wLP/v1GanVDCKezr+IKSUeHvltOx/tt1ezP5myVJbnDjKwTi5j4HEwzSZHBDnGL6CrbqXWz2pJG1mSZlxF/8zrI4/xGFmPKSFpYQ4XbcDepfrHE9ER+wimizXX/rt8VU5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16faffc9-9cba-4a8a-2742-08de1c9bd5aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:47:56.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvDEmGJMYG4qkRoTxbtiysXhuP+szdjb8RK8NaV7vfuWJjjYfET3l/DHCzUpyy5Ow0Oy6Ln9U3/KzQTBuTy9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511050146
X-Authority-Analysis: v=2.4 cv=IcKKmGqa c=1 sm=1 tr=0 ts=690b9bf4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=6TFt5HZNrqBHn5dVgnQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-ORIG-GUID: aNy2HDl_LqhTQ4TZhCIVh9Kh0eilKfG1
X-Proofpoint-GUID: aNy2HDl_LqhTQ4TZhCIVh9Kh0eilKfG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzOCBTYWx0ZWRfX5/l0ElolAc/g
 3yUSYO4fxuMDSGDVwwxO+wKBzcXI12USFs/z+ZdtIRP+H6AxUR3L3LA7X3iE6pPPn5/9ZwlgV8g
 TEPgCghTZ3aM2FI59ugbX0t24MDim4Bkv1QDyLLg/gWwA5S2t2h52oC5dJ1EjC05b/K/pq8FhgC
 kD7Gbou2vtW9WME01B4gxz6t+BuhG5RjSsWFZdD7ZRCnt70siYRhhqqgdg1+c7+O+pq4xLXaBpt
 n5okYci8VUpBK8/6thW28KYg36L+PhccN4R/hr4m6NKtnQUsSgEbzkdbfRNjy7/S1uJHzMirJsP
 z+yf/epbPauV7TdfXfkDSpVZ8pDbiX7E3+okhsDjUsGcasTHrGTCENjNxSXnnUC7m+pW7YsGDX5
 ZCeBf97Az3n6+8EPungM/ZuU09dNK0Jx0dSOqWWS9IdmSMgWQR4=

On 11/5/25 12:42 PM, Mike Snitzer wrote:
> NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
> performance if it uses buffered IO (without DONTCACHE) for the
> misaligned end segment(s) and O_DIRECT for the aligned middle
> segment's IO.
> 
> On one capable testbed, this commit improved streaming 47008 byte
> write performance from 0.3433 GB/s to 1.26 GB/s.
> 
> This commit also merges nfsd_issue_dio_write into its only caller
> (nfsd_direct_write).
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/vfs.c | 73 ++++++++++++++++++++++-----------------------------
>  1 file changed, 31 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 701dd261c252..a4700c917c72 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1296,12 +1296,13 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>  
>  static void
>  nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> -			  loff_t offset, unsigned long total,
> +			  struct kiocb *kiocb, unsigned long total,
>  			  struct nfsd_write_dio_args *args)
>  {
>  	u32 offset_align = args->nf->nf_dio_offset_align;
>  	u32 mem_align = args->nf->nf_dio_mem_align;
>  	loff_t prefix_end, orig_end, middle_end;
> +	loff_t offset = kiocb->ki_pos;
>  	size_t prefix, middle, suffix;
>  
>  	args->nsegs = 0;
> @@ -1347,6 +1348,8 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  		++args->nsegs;
>  	}
>  
> +	args->flags_buffered = kiocb->ki_flags;
> +	args->flags_direct = kiocb->ki_flags | IOCB_DIRECT;
>  	return;
>  
>  no_dio:
> @@ -1354,39 +1357,14 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
>  				0, total);
>  	args->nsegs = 1;
> -}
>  
> -static int
> -nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     struct kiocb *kiocb, unsigned int nvecs,
> -		     unsigned long *cnt, struct nfsd_write_dio_args *args)
> -{
> -	struct file *file = args->nf->nf_file;
> -	ssize_t host_err;
> -	unsigned int i;
> -
> -	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> -				  *cnt, args);
> -
> -	*cnt = 0;
> -	for (i = 0; i < args->nsegs; i++) {
> -		if (args->segment[i].use_dio) {
> -			kiocb->ki_flags = args->flags_direct;
> -			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> -						args->segment[i].iter.count);
> -		} else
> -			kiocb->ki_flags = args->flags_buffered;
> -
> -		host_err = vfs_iocb_iter_write(file, kiocb,
> -					       &args->segment[i].iter);
> -		if (host_err < 0)
> -			return host_err;
> -		*cnt += host_err;
> -		if (host_err < args->segment[i].iter.count)
> -			break;	/* partial write */
> -	}
> -
> -	return 0;
> +	/*
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> +	 * falling back to buffered IO if the entire WRITE is unaligned.
> +	 */
> +	args->flags_buffered = kiocb->ki_flags;
> +	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		args->flags_buffered |= IOCB_DONTCACHE;
>  }
>  
>  static noinline_for_stack int
> @@ -1395,20 +1373,31 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned long *cnt, struct kiocb *kiocb)
>  {
>  	struct nfsd_write_dio_args args;
> +	ssize_t host_err;
> +	unsigned int i;
>  
>  	args.nf = nf;
> +	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb, *cnt, &args);
>  
> -	/*
> -	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> -	 * writing unaligned segments or handling fallback I/O.
> -	 */
> -	args.flags_buffered = kiocb->ki_flags;
> -	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> -		args.flags_buffered |= IOCB_DONTCACHE;
> +	*cnt = 0;
> +	for (i = 0; i < args.nsegs; i++) {
> +		if (args.segment[i].use_dio) {
> +			kiocb->ki_flags = args.flags_direct;
> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> +						args.segment[i].iter.count);
> +		} else
> +			kiocb->ki_flags = args.flags_buffered;
>  
> -	args.flags_direct = kiocb->ki_flags | IOCB_DIRECT;
> +		host_err = vfs_iocb_iter_write(nf->nf_file, kiocb,
> +					       &args.segment[i].iter);
> +		if (host_err < 0)
> +			return host_err;
> +		*cnt += host_err;
> +		if (host_err < args.segment[i].iter.count)
> +			break;	/* partial write */
> +	}
>  
> -	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
> +	return 0;
>  }
>  
>  /**


This is not at all what I had in mind. I'll fold something into the
jumbo patch roll up for v10.


-- 
Chuck Lever

