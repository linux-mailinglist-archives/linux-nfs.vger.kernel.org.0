Return-Path: <linux-nfs+bounces-9439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2DBA185AE
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 20:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C231883612
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C01EEA56;
	Tue, 21 Jan 2025 19:38:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4B1537D4
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488330; cv=fail; b=NtDBcx3MutIa12fKDcWBdiW//LfSk2AR2XH5C47MKYYjuiHXv+vE3A4rPortLCRcdsdGQojR9qIFeWIGh5nneBwwUvW13EnMLw3TQDBmCcXQKEnHwbWS0yO20GY8y1Lkdhix5bmcGYzA6maaB208GMejV6ae7PaoQ+wKVz0yRwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488330; c=relaxed/simple;
	bh=NEwsEDM+7Emhbrr0dNJGFixCoyVFY5wh4SF2s/OuiOs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaluSQmgmFQNWxoP5vLjLPTpGApPC2Vg0iW5nnITGEObwDdfhvtY+l/M9K9nzKhNnlyVy3gzYxIe3csSla2VDZwtSzkAQq8tERrQA4hPLJsg648kcwEtwa14OYl7juZrfvhH2Vtffcp+Azh24wXqsOoMsFTa9/wUyp+dqoM6vUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.57.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K85smnOOFNE8VOLagrNQOUJUz2Col5K47i/SL2An3h38R22Jxhl5n4LS/HrjPSzxXrjFzczdMl0gaGW2qbf4F0Umq111pHDwXXgelBYjkmZqzEXbkQvblEPqn5DFySwG7QvrY0dNu59uVlHSigG/pcwFm1DsnoKlWnVwtoRhMNOdh4/pb8mgwIIsN5gGAAqL8odLLNGad4zimA/dfEo+XkHyp6ezb9rQ0CAIOr28dkjvfMT5IO64iyPXMql8Dr3BjgsmoQUivZ0oU2w04D798vMGAW0xq8DDrVd0Lfz66GNIqatPDnHF1QQlHleDXZpt4G3SBx/zZzTmZsEfTsnVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ryAyltPmBxkHiJ1sob6Z+/Tuq543cXGR+xeZJohN+w=;
 b=lLEDLHu/dhyYwLJ2nvzCuBnP82e91MhMWmK/hQCZ/kBPbPoQKpgadFIro0XQn5HWhd98PnB2l8hur+pPfiPbhi61LJ9c1hTUjPqXwJ/cqogLzTLYTPRTHsQtMYhRi5uRbfFFUCaAx8wxuzxtrrvYC/poWcu4jJ6IEy2Df0rPzMaTR/mEGAflS1gSs6fglf0oc3meCvEj5EGA43kDbzFwKRshjieNfysRoJr2o6u4AKQ1QB0wgpwLmxupcjuVFdAdDZ8qP2xSAVn2mHvpTNov8WSiDtRUvF5Ub7uolYzt65VbwBYz72Voa5tNHQb2ls7Nq/Ns4JpmiM0gN7VKrU6s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SA0PR01MB6121.prod.exchangelabs.com (2603:10b6:806:ef::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Tue, 21 Jan 2025 19:38:44 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 19:38:44 +0000
Message-ID: <cf8650cb-1d2e-4771-981a-d66d2c455637@talpey.com>
Date: Tue, 21 Jan 2025 14:38:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD threads hang when destroying a session or client ID
To: Jeff Layton via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
 trondmy@kernel.org, carnil@debian.org, anna@kernel.org,
 linux-nfs@vger.kernel.org, herzog@phys.ethz.ch, harald.dunkel@aixigo.com,
 chuck.lever@oracle.com, jlayton@kernel.org,
 baptiste.pellegrin@ac-grenoble.fr, benoit.gschwind@minesparis.psl.eu
References: <20250121-b219710c7-773af1987926@bugzilla.kernel.org>
 <20250121-b219710c10-7af78b1a3afc@bugzilla.kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20250121-b219710c10-7af78b1a3afc@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:408:f8::7) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SA0PR01MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f471885-4545-4038-521d-08dd3a5336e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDd5KzF6djYvU012MnBWYmtLdUxkRzFYV0tualZXc2RRaUx0b2JTRjJOZjli?=
 =?utf-8?B?WHhuZ2w2Z280K1ZtdFQ3VFNRTVQ0WmZsQ0dxQ1ZQOFJFM2dsWWw3ODJUWUhD?=
 =?utf-8?B?ZlFoNGw2WjdRNytCUmtzWjByQ1l0aG0wNGpzTjU4MUtWbXFGZzlZTE5aMlNx?=
 =?utf-8?B?SXFNc0cxdWVZR1o1VFp5T01wSHMzOHpYeG56VHA5VzZRcFNuQ0QzVitkTDRz?=
 =?utf-8?B?blIrbC9pVndQRzJjc21WWGxnQVRkNTBhSmlXZ2oxTlFjVEhzSjNXQk5qY0gy?=
 =?utf-8?B?L1ZzTXEvbzlPN25OYmJvRldhNDNGNVJvQ0s0TWJsQUZXM0dQVUFKRWpkdmlk?=
 =?utf-8?B?aGtGVjdnb0FZNDdxTWtqNDRSODdsNWlreFZVV1JqY0hYbEVKcFFLME9LQ2Zy?=
 =?utf-8?B?Nm5pTWhiaW55MWxtV2xYckpEU2s0d1lKU3hqTEpjNWRVUWlKMkV2OUo5d1N2?=
 =?utf-8?B?eVZlZkpxVW1Va0d3ODJ2OVZwdVF0T25PQ2RBTGFIZFpaUHRkZGExOEttdjVk?=
 =?utf-8?B?QThwcjlsc3liM0E0R0pZTWNsdHZMY0tUdVR6SCtvUVN2VkZOQitDZVl1WVpD?=
 =?utf-8?B?cDdUQ0tBK1NrYkNlVitlTkE3dFM3a0sxNDNNQjA4QlNLV01BZ2xRRUtHTE9r?=
 =?utf-8?B?YVpEYmVBZWdwSGFLR1VIb3lWK1l1ZUVoODVqVVY5QmtRckttYUR4T0JWdEpo?=
 =?utf-8?B?Ni9YWjlDcXVaL3I3Y2wzOExDcGtaUUwyUmJEdUhPb2Z4dWw1Y1NxNzVQekF0?=
 =?utf-8?B?WUJBTUdDdThTenZQUGdPK0pvM2ljaUFEZ2xRSk10MnhzUHRYNnZLQ241bXAr?=
 =?utf-8?B?eVFhTFYxVFhFZnEyTGtmMS9yZzVWUFB6bnhJTjA1bG52LzFJa0lCbTgwOTJj?=
 =?utf-8?B?NDZmT0VCTnBkcm5mN0Nwazk5T2plcDVMNHpLVzU3TXc2azNvWkhVdkNZeG4y?=
 =?utf-8?B?dlpacWhlVVEzTjNhRWZ4YmFkYlgwWjJxL2NjY0JFRS9pOGxqRW5TdlBwV2ZC?=
 =?utf-8?B?OHBwZWhEcWlBTDJCZXRkTGgyenc4MGwrTFpLRFV3OFVYTzBwOU5jUTRRVHpu?=
 =?utf-8?B?c0R3cG04eElWdlhYNUs5VFYrT2xBREpyQUp4WHBQcjU1cGlEYzhPYVI2SkZx?=
 =?utf-8?B?S3RMV0JQdTdXSE9wdDlpYjZYSm5DMVpiZUxvWWlaNmw3K1hmdDcyMnd5MmdT?=
 =?utf-8?B?Z1pDdTZiSjQycFZIUUVxYThXWXN2SWZvUzdpL2FodE1iZ200b01MSG1aMHVy?=
 =?utf-8?B?QUJLSWpKcEc1MGxwUlZEcnFuOVV2a2w2dUF6QWE5S2xDa2ZVc1ZsbU5JcWJJ?=
 =?utf-8?B?Z2FpUWhWbXNBM3ZQTktVeU1OcUhlaFZNamJqTFJNT2hwSXRPNytTdnZqOG8y?=
 =?utf-8?B?ZGpFSURxcll0N3RhcEZWZ3ZhSHphM1p5VkRPWUk4WUhrVGtIcENWbUdveEVZ?=
 =?utf-8?B?V1ZHQWlSZm1GdUxDOVh2L0xnaFdCbUJVSEFzcWJxdXIxaDZobHN5bEZoVitN?=
 =?utf-8?B?V004aytncHhvMVdkcU03SmdRNXRnWFhUR0EveTBKd09kYTJ4bzR6NmwwSEdh?=
 =?utf-8?B?NHdDclFPRTVtVFd2MWxUZmNFUFNUVWc2bzhDekRBa3Exc2tGRTdCclhlU2pM?=
 =?utf-8?B?TW5nT2M1RTJkbEtDeDFnZ254eHNxdmxkM3FjdnQ3eVMvYXRiY1RpODA5UUFt?=
 =?utf-8?B?dkZjbTJsVlFaSkZqZlhMUjRpWU9zc0FyekVsVk1VbFhwN0R5MEhmY2I2a3A3?=
 =?utf-8?B?YXBKdmdCYkdxNERKcnh0bnhkbHZYZUpFUzU0VVJ4dlJYN1ZCU2JUdjFWTy9w?=
 =?utf-8?B?cmRiR1NSVFcxYWFlWHlxQlVnbHBLZFI0YlV4N1R6MWdhR0hKQzQxUnpyV3RW?=
 =?utf-8?Q?1mcFSVCUQxuMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3pMWGxJUnl4SkxZSjJyS3ZqeFVONXh3VFAwM01JZGNVVzFpQjJQblRZd0xq?=
 =?utf-8?B?M2tCY2I3S20yb0VWNVVxZHFTdU9tSnRmU3VwK0hoemg3a3M4Z1h0MjhJOWxI?=
 =?utf-8?B?NFlSNGNBM2h5ZzdBa1ZXTENYUzJHcmdkVGxwZnJoVnJBdEdpakJrWFU3WVl4?=
 =?utf-8?B?blVuM2doeWlTUHFYZTEyWlNsQ1NkWFYxQ0pwbEFiRXo0TzRzSzgrZjFKTVA0?=
 =?utf-8?B?MERUbVJUb3hXSFZZVTNHUzd6QnBrZWprL2NMMkJXb2FZdXcyUit1K01RRWhN?=
 =?utf-8?B?QXpuVVM2d04xRjliMXpwa1pIVHphcTZscG55NHUwSm1UUjlXYnBkazBzT1l0?=
 =?utf-8?B?ZG5nTzdFWTkwQm1qclFHN2VyUXBKbTBHVmNpVEc2aXBTdHdTVCs5eTVSbFJW?=
 =?utf-8?B?Q2M0b3Y0a2tJK0tTR0UvcXBmblBzci80aDZ4L3RQajVlclFEV2FlRHdYY29z?=
 =?utf-8?B?UGlISjA5bzZxZkFKa2JLdnNVL2V4bHlZVmE3VVVFQXNCUjJMZkhQYm1mWW50?=
 =?utf-8?B?WkdvaEZwTm4zUlJva3orajJ1WlJCczNuaitYOTRpcUlERVdlWjA1eDFnK3RO?=
 =?utf-8?B?RXhyU0Nnd1VNTzdwbEFtZlZxeS9ZeTl2Y0tUYXJMM3JmLzZQUjFKK0E0WDB4?=
 =?utf-8?B?R2VOcVFMRlJ5NklaTFd3OEM0YzBGN3E5YWwxdFZ4MFhUTjJhOUs5eEtRNC9F?=
 =?utf-8?B?N29PNGthZ0cvMWQzbDZYUXJ2WUY1cWMrV2xFTTNhcTRwL1pzbi9IMVUrQUF0?=
 =?utf-8?B?UWlMcVdjM0lZTm83Z2F1VjE2Mm9kL2J3bHF6WVhRbE9nNW5IbkpvTCtCV1JD?=
 =?utf-8?B?a3NLcXhjV0tVeGNLbWQweGoyVncwNTJURnFqUUhyOU1yWnMwTlFqV1FOTnFJ?=
 =?utf-8?B?ek45ajdSajlrNU9wUlh2VkdVOFFMYS8rbUZSMlIxZm5TVnRjN3ZOZ0dkTVE3?=
 =?utf-8?B?RWh5SXQ2MnBVN3hpTm1KUEo2WmVCbkcvUWx5Z2dOL2dQbUNDU3VzbTBVRjlw?=
 =?utf-8?B?dUhjY1ZpdnF2QkNOTFU3b2pLaHZXdnNNdXNzSmJIVmZwY2o5bEJGU21ldTV5?=
 =?utf-8?B?Uk1JclJoT1daUzBQWXdoS1ZSb25RbjlTYkFKYVM4YUVzU1hhV1ZQSktic3po?=
 =?utf-8?B?dS9qbDIxQW15MEhDZmJUUXloM1UwVDZyWjY4amxXM3psTG9sbm1kREhwUktP?=
 =?utf-8?B?MTZvbUpOTW9QMEV0Q3Z6TDdNK2F1VnFGNC9xZWxPUWdOREZRcVhjRGxyMU5T?=
 =?utf-8?B?U05OSHFyY3BIL3Z0Vnpocll5Y2o4OTZvcjZvZ0FiNkRvb0Z6eGQwQ2cxUERD?=
 =?utf-8?B?b3ZBUkVNZk1sZTAzRmFhekFHMHNldmRrejNhKzRtTk1UTXBmcWR0V0dDdFp5?=
 =?utf-8?B?WFg4TG1lMjVoNmZib1gwZml2MDhJZ294MUU4c25CczFXZVYySE1TTDdhQlJk?=
 =?utf-8?B?Vm1wYjdlaUJkRFB0dFpBQ0h4Q3hYd25pbFcrcnZXei9wR0dweHQ3blZ5YWEy?=
 =?utf-8?B?ZklCeTE4QzBWNU1VS1BHNmtNYUxMYU42OTV0NGt4SzgxZk9aei83dVV5bkN4?=
 =?utf-8?B?NUFRQjRzZno4RXA1cmFiS3ZtZnFmSVNJckpTdWIyc2VXbVdNMUhEMHp1aVFT?=
 =?utf-8?B?YzdkcmdIUFFjQkVWTm1YTlk3S2JGajVzbWcvVUJRWEhSbXp5ZTh5R1pEd3ND?=
 =?utf-8?B?aklYRS9QbFMrMVkzeTl6d1FNWUtRT0JpZlBMZE9iQ21iTDJyVjYzNDZZdEhB?=
 =?utf-8?B?UGk2RldmVmMwVUNZazVFakVIWWNZQkYrY2Z6MXRzclROMkYvNTNaOERrV0Ny?=
 =?utf-8?B?NFlCU0xPZ1dhWVlBZURiVkNHa1pHZlNWRmVHRFh4MENJYjFFbzZOb0d2bHR3?=
 =?utf-8?B?QThoVzRaRnl4b1E2YTNjazRwNzhEK1lza0ZiWFpkMXV2RE52bDJRalA2WkVw?=
 =?utf-8?B?T3Jkekt4UkNCWVhDZW9BRHVjMDhvd3pLTUhWeThOcVorNWhQN2djYlJuWlAx?=
 =?utf-8?B?a25NMnA2Q05LQk4rYnpjZFE5dE5DWFJuUFQ1RDJ0aERCcTJ4ZXE4ajloUWVV?=
 =?utf-8?B?bUd6dER2YUNxVHdVeFZuejFwck5aVmhMWW5iMmFUQkVYTGdrWVVzeU1xNXZj?=
 =?utf-8?Q?3E38=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f471885-4545-4038-521d-08dd3a5336e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:38:44.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGQRRuJbFkmGYRzDI6tTNsMJaYmHBe+fqdiZrc5z3UKO/NornZsFpAgam6ra+moi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6121

On 1/21/2025 12:35 PM, Jeff Layton via Bugspray Bot wrote:
> Jeff Layton writes via Kernel.org Bugzilla:
> 
> (In reply to Chuck Lever from comment #7)
>> The trace captures I've reviewed suggest that a callback session is in use,
>> so I would say the NFS minor version is 1 or higher. Perhaps it's not the
>> RPC_SIGNALLED test above that is the problem, but the one later in
>> nfsd4_cb_sequence_done().
> 
> 
> Ok, good. Knowing that it's not v4.0 allows us to rule out some codepaths.
> There are a couple of other cases where we goto need_restart:
> 
> The NFS4ERR_BADSESSION case does this, and also if it doesn't get a reply at all (case 1).

Note that one thread in Benoît's recent logs is stuck in
nfsd4_bind_conn_to_session(), and three threads also in
nfsd4_destroy_session(), so there is certainly some
session/connection dance going on. Combining an invalid
replay cache entry could easily make things worse.

There's also one thread in nfsd4_destroy_clientid(), which
seems important, but odd. And finally, the laundromat is
running. No shortage of races!

Tom.


> There is also this that looks a little sketchy:
> 
> ------------8<-------------------
>          trace_nfsd_cb_free_slot(task, cb);
>          nfsd41_cb_release_slot(cb);
> 
>          if (RPC_SIGNALLED(task))
>                  goto need_restart;
> out:
>          return ret;
> retry_nowait:
>          if (rpc_restart_call_prepare(task))
>                  ret = false;
>          goto out;
> need_restart:
>          if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>                  trace_nfsd_cb_restart(clp, cb);
>                  task->tk_status = 0;
>                  cb->cb_need_restart = true;
>          }
>          return false;
> ------------8<-------------------
> 
> Probably now the same bug, but it looks like if RPC_SIGNALLED returns true, then it'll restart the RPC after releasing the slot. It seems like that could break the reply cache handling, as the restarted call could be on a different slot. I'll look at patching that, at least, though I'm not sure it's related to the hang.
> 
> More notes. The only way RPC_TASK_SIGNALLED gets set is:
> 
>     nfsd4_process_cb_update()
>        rpc_shutdown_client()
>            rpc_killall_tasks()
> 
> That gets called if:
> 
>          if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
>                  nfsd4_process_cb_update(cb);
> 
> Which means that NFSD4_CLIENT_CB_UPDATE was probably set? NFSD4_CLIENT_CB_KILL seems less likely since that would nerf the cb_need_restart handling.
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c10
> You can reply to this message to join the discussion.


