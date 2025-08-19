Return-Path: <linux-nfs+bounces-13778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CBB2CA3A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 19:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FE95A26AD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE52C3276;
	Tue, 19 Aug 2025 16:59:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2091.outbound.protection.outlook.com [40.107.96.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040862C3256;
	Tue, 19 Aug 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622747; cv=fail; b=S3xWgTUHzKyDlSKrV8TH8aOpm1y9LYdcKQy1kZjaWmAilnwJEMIZVXWOiG2R3lXxWBe1pmX0htjRwVBnXOQr7+DhSuMultgnHzhiUkHnDT5sm85MocIMyOTfq5sBPtnGQFAPGtDOs0yB6PuOOk++uh9srBxl92NdxlY768UqP8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622747; c=relaxed/simple;
	bh=T4CBV2Phij4M4Q4sK7n1oX/ztUVV1dqjbPCrfTj0BOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ac6/j3Zijds/Nsn0DCjDC6Yp7uteVhVUVRorTEEtxUjxfyEUDKJ+94u3O4PPutDnAiN9425xhUsePYE/qunhDX5Aip5Cw0G38c/VRQkexJOPT0b0JCGDk2eK/p2U8+5LGMhYBffFHkEwssEYQWnHb8FUaFkRQGPuyN4XvM5yhS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.96.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaYwxvMLonJ1bixgp0FCFer5oIVVoVkatiDSrZYtrLzHg/d6sU366n+c+V8xsKk+YZsjtGN9fpGFLczdRcW0BDKboFYnI8vaS1gBcUK+y/WFz8FZknpq2xY8gRsNMX8yuFjaP+iWtfkMVZkjIkEE6uxR+c7Y1RbdGbcmn6Iji5ngn0xNPlWY2SVdLslkovRLVqXlo46SN7iHlPXdcUEtJROJgUvB48ITmzcz2zzCb04v233aFtZuQCEBk9lSCVcb5OpN3LO+UbX294N5zVBTV44fSh0pUWKsvlx0Cr1OY3QkIYfivkI9DZKza7KUZnqE1F3ssGwYF/F9mEBsp68btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOoXBTOZ0ulzQt7GqyF9RhfuRs2aHtHSLMjzad7N96U=;
 b=KJBGNSg2Qms89HyoQ1Mrc4Y3WKN+laE8hbUr999o324MJ51eVSSUpq4TODk64gKf5KUo5+Q7YfXjpnOrvkEAzyq9czhNXyTmiYrSIWGkycEP3o+jy9nzOEMIpyl6Wjom5kahLIo+g/Je9T2rbjPYHN1nSL2Lp1p5D+EoCgeIWFPBHp4VqvU3u5wfYNQvE8cVor3JXU0H3ZPMt7y5tnU5U2P7A585Wx8ZvJA9CwoziLkKklQnndz6ILhGLc6Hygsvp3808wQzDPDpizbBdoK9AO+alEDqoSBi1S5j0KSdsoXm/Oz+5Ocj6KcKaGw9EuOWJBUoEJ+l6npA1d6QokAzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 SA1PR01MB9107.prod.exchangelabs.com (2603:10b6:806:458::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Tue, 19 Aug 2025 16:59:02 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.9031.021; Tue, 19 Aug 2025
 16:59:02 +0000
Message-ID: <383ea66a-8b0e-4b90-98c7-69a737c23f82@talpey.com>
Date: Tue, 19 Aug 2025 12:58:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] svcrdma: Introduce Receive buffer arenas
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20250811203539.1702-1-cel@kernel.org>
 <a1ce98e1-83b6-45c4-bde0-c4b71be67868@talpey.com>
 <1cea814e-8be3-4bf9-ae3b-5bf21eae0a3c@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <1cea814e-8be3-4bf9-ae3b-5bf21eae0a3c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|SA1PR01MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ea692f-7718-4eec-3e12-08dddf41b295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJBL0xMTVJoV0Q3STFPWGNsVkRXNkxhTFAxZTl0SVh3VTVKMDQxZm5yQy9Y?=
 =?utf-8?B?ZHJaeVI5SXUwNml6Mnk2SGJmWU8rY21HT1VZc2xzYU5DQmxkTU1UUSttV3dP?=
 =?utf-8?B?aTY5MlMzSmdBWjU1aDF4TUpjZ2hEN01udHd3SlBzWmVVMWhiYVhkUUFBSjBH?=
 =?utf-8?B?VTJPckpIZFdDd3psUFRvQTVBNU54ZE5Ia0Z3d1JuMHRSRUtOdjBUT213Wko2?=
 =?utf-8?B?Y3BkMnVBUzVzUmpyQnVXako1V3ltZGJqbGJSejNSZGFldTZHZ1FPMFhUK1NC?=
 =?utf-8?B?VkY2c3hSS0ZUL05wcjRRVzRuM3ZLRFRGTWdJK280Skk4WmdSWXR6ZGZrOSt0?=
 =?utf-8?B?YjNrZm5YaG1jQUNaU010ejhrWkQ3SVU1YzlkVngvdHRXWGdyS2VpaytUYytJ?=
 =?utf-8?B?QkxPWjVyYWJiWm8renhaOWtCcDRLQ0g3SFN0QTdkMVZUZ2xkb3Q2S1RmR1BW?=
 =?utf-8?B?YnhVSjI3dmJFV0JhYlRJdXFhL3pLOXFxekVoRWlucDl1TkhuZk45QnRqVUx2?=
 =?utf-8?B?SElJVUpaZVF1cnVXamlFbkxubm1Bd3RVK3hEWTBLT1ZkbVdaTmxhcy9VdkJX?=
 =?utf-8?B?VjZKR3NGb0FGWU9wZndhano5YkxIMStRS3JXNm5mZTkrcWdqZ3NrQ0FMWWFH?=
 =?utf-8?B?NkFhVmJpZmdBVzdubC9aNjR6YzEwdWw4N1Zuak1IM1NvS2JLODR4UzJsQi9M?=
 =?utf-8?B?MVRzdmU5VzdTVG85TDJxSlhIYlM2VzZvR2FzNWJ2T0I1empveE4reWVwaVNF?=
 =?utf-8?B?Nys0dkxJL21VcG4xNituTDY4N3BDSHdRRFF6OG9VK3JGS3c3c25qM0VnVVJR?=
 =?utf-8?B?Rkc0aHA1MWZpZ05yUERBL2hwTjNIaEdFaVN2SExNdDZ1WDhDRkNJZ3hmWnV1?=
 =?utf-8?B?Q3Y3WURQMzhWZ0FZWjNPL2lTNVl3Rm9uQkZJV0czU0hvMXNFZ3RpZDRaUjNF?=
 =?utf-8?B?T3ppOXlid21ZenJKNGxlZSs4aFNack9UUjFIV0pvMm1MVUI0L0pXU3MyWGJ3?=
 =?utf-8?B?K2xkUjBabDlhZWdCTEM1VHAxK0hEQThHOVFQbU5hK0dBakg3MEtnUmdzZnhz?=
 =?utf-8?B?T3YyTnhJWkprcUVQL2Mza3pRaTBXdkhJekZJajkrTCtNY3Nma1dHY2NDTlBo?=
 =?utf-8?B?cGVDajhvVGh3NmFoUHV2ZnZYd1Bnb1BxbTZLam9TeFpKT0luaEFNajFHM0dP?=
 =?utf-8?B?S2NncnIvVjlKUFNwbXU5UHRROWpUNGFwRHVvUENhUExOdVRlY25rL3pFV1Vi?=
 =?utf-8?B?ZElic2dUdkxUbUE0aUlmYTdkbFlhTURzU29aTmE2aTRVUW1zL1VZSjQ4MHZP?=
 =?utf-8?B?VWd1TDRweU43ekorM1FFSVdteFlTMmN1eDg2Mi83UG9Xdkp5dHhIVXBzN2pK?=
 =?utf-8?B?aDY4MGZmZnJWV3pZM0Z5YVc0RnBwM1V3cWFRa2hueEpOODdrWE5MV2dlL1Fp?=
 =?utf-8?B?ek5LSzcxS2xBZ0FHS2hWUU5hTEZuWlVYbjB0ZTExWC9iUFU4TU9RNVBaTGhJ?=
 =?utf-8?B?VVNmcUNPc0FQRzdMRWM2TzNlZnZTenpFUzhIcnpJc2FWNG5lam1VQnljcWFX?=
 =?utf-8?B?U09pWit4UW5wOS93UUdNdUJwZWZ5bEhRMW9Hd1dkeURZYytSYjE1UEdBU2w2?=
 =?utf-8?B?QTRIQ1VNUlY0ZnBDeXBJcnpTOHdPK3E0akxBTG5pb0V5SjRYV1hOL24yU3dr?=
 =?utf-8?B?VUNUQ3ZMbWxnbklyWUlLODlYQnJHTGZ6bWxwQTdqdW9qODJ3N3UwbDhUR1dM?=
 =?utf-8?B?bENsdlFQaThidGFUaS9Zbm9IZmRub1pVNUZQWER4dDdjTnVKN0pMcWJLRTFr?=
 =?utf-8?B?MkZJUkd6c2hrSUp5Mlp0VjkxQXd3eWZDOGRJNVBEWEpjbHYrZWZQNU56WmZ3?=
 =?utf-8?B?dEpBMnovODNnYXc1NmZLWkthd204ZndjeFpXRWtJd0hVcnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTJGSXBQa3MwamtNUWNISGdhdUVOemZVWktwQkFDek1KWklSOXFhUGthemNG?=
 =?utf-8?B?RXIya0Q3dTlzMnRUVmYyemU5a1VkdFVPQVcrVTZNbHQ5em9HSHJsckE5ZHZm?=
 =?utf-8?B?NzJHQm5iYWwwRVJPblVSUHY2RjB0RE1OZ1ZGVUFmMUVtWGNialIzZ3BBV0c2?=
 =?utf-8?B?YzZya0crblZnZnlDRHdQMFkrUS9QT0NGZTExZnBNbTg1dWtMTEZMVGpvdEwx?=
 =?utf-8?B?ZWcxc0lnamt0dVRreFdWdnVPK0xEQ0kxMmN2OVYwL0lNRDcvUitmR2R2VkF6?=
 =?utf-8?B?aUFOTXBIVjdWSndjalhBMXNWT1RJYXBzS2I0MHJ6eHRjTVVlcXE5WmVsMGZJ?=
 =?utf-8?B?bWRCOFpoZzg1N21DZFMvVWRNK1ZRdFNmVlF2Q0JDNzBQTklNUzF3WmVOVzNM?=
 =?utf-8?B?UGJFMndQdllIWDBBcjV4eS9OY3g2K0hSa3hmekxERlowQTRqTVVmUHBLdmlh?=
 =?utf-8?B?RkFWZFV4N0VuYmtSdDRPRmtIS0ZuMUtGZ3JhTW1nMHFJU01lSzdNdElpZm5i?=
 =?utf-8?B?UExSdGV1RXI1MEhBcGtOT0RJTzNpc2xxMkppeC9sK1FmSk80OWhvbW9qUkU2?=
 =?utf-8?B?Vmhsc21oM0RmRkdsZWd4djNHdmwrOURVOXh5UDdGNk8rQ3ZnUExJMEJuRzVk?=
 =?utf-8?B?RXFheFROQmYwVUlKTGRXV2hrYTRJdEFyTm5nbndFNmpkdlN2VWlra21qcHZM?=
 =?utf-8?B?VzVDbVhIYTVtbUwzMGdvVDlUWEhuNEZYd1VGazZibU9tQUV3d3R6cnZvUkpo?=
 =?utf-8?B?MVhISC9FbWU5UGo2RG51T051TzZaQk5LUGo1akFNRW5XbmN2STlaRUxsZVE5?=
 =?utf-8?B?VWtzYk5yTytadFh2VmxrY25OakQ2cHpyd0FLWlpCSjZPOG1nUHNIbFFnMDV3?=
 =?utf-8?B?SWtkM01qRlM4akhaMy94UE1waTJITjhtY1NnTnpEbUhtcXp0TEcvNTBSSklW?=
 =?utf-8?B?UE0yVXlEZ29wd3psOEQ0Zm8zd0ZRY1lkMU5HcTY3REtlbUtqMEswMGx6VjdY?=
 =?utf-8?B?OXo4MkJpS1BvR0dqeW5OUFZFdVNpZGVTdUlOTndzbXM5dGludjZBSmlOdG5Y?=
 =?utf-8?B?bkl6aVR3aC8wZGRqTDVlNVd2eS9KUUkvc252WVRyMW94aVJjWVFhRkxWckhy?=
 =?utf-8?B?TlN3WXhES3ZOUzZwdyt3c28ySkNIUkc2MisxS2p6WFFyNlFzeE5rTjZSNjlU?=
 =?utf-8?B?SXFZUVdEalNGYUlMaVp6Z3MyT2hydDgxeENDd21wWUhZOTdaRk1zdTRjcElW?=
 =?utf-8?B?ckE0VzVHWkpwa1BjTmt5WjdKZ3BMVGx2RG9nckZoT08xRDVOVG9jZHJJbWtG?=
 =?utf-8?B?UCtBa2xKd2JwdkpQbkNmWXlCRTk2blY1ZVArazI2S2U4ZTg3S2wvdXNzNmFo?=
 =?utf-8?B?elFlT1Z3Q3FzMXFSaFJPd0pJMVN1OFZrNWNIV3RKS2xhbkFEV1JWQm4rL29i?=
 =?utf-8?B?RkR3Q2VrZjU0ZEdSSWJJL0NkeWxLVUJ5STJYR0t1ZS8rdmk2WVBZSHJYc2JS?=
 =?utf-8?B?aWduUUdvR0xyTzhCbDlOd1IzRUtHOVhmQkhTcEttZ2RRYmxiRDBzMWcvTE9K?=
 =?utf-8?B?NENITWY2OEFUMFYzeWhzc21RQ2JJTkRrWVVBQ01ZL3JhN0RXUUEwK0dNblN2?=
 =?utf-8?B?TmMzMnJTaW1rTlNGSHllNzZZQUVZS2pLOUt0aW56ZEFxWDMzcnV3U1IzanAr?=
 =?utf-8?B?TlgyK29VSU5FOUl5RWptY3h1VXpFVGo5UDk2VVMyQWVHZmdsY0pqMUo3U0dI?=
 =?utf-8?B?UnBZSVZFSHZjMXZ2SDRyZkk2d204ZFJjdytucG9GTis0NGVqSG5CYkJQNUhY?=
 =?utf-8?B?d3Z3VXUvSFBYc2hYWFZGNkx3YUZKVUhrY3NMSUVTM0RSMkZNSmVyMTZ2S1Jn?=
 =?utf-8?B?Y0pWcEhkZWJNdHVodmhCNDYybW5LSDhhSC9wbjhhR0IwVDl3dWlzcytxVTh5?=
 =?utf-8?B?VUE2QkpuK3A0V2FrV2MwRnJRZEZHQ0ExTFhwQjNQSDA4RldWenhyenh0Qk5O?=
 =?utf-8?B?UWlPZDVocUMzbkJQY3BTd1ZTc3J5QUJ6ZE90V0lWazBxek94SHpuYWpWRlZF?=
 =?utf-8?B?L2g0a0VHYlBBeFdtY0NwakQxbDhtZG5nR2xGcjJJV3Nxc3l3YjEyUW1qaTh1?=
 =?utf-8?Q?R/1+oAAeyFTi5oFTodkG7RHsC?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ea692f-7718-4eec-3e12-08dddf41b295
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:59:02.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09nqK4Pz0qEVK8O9cP1XNYWjlUeTf4mdy4K54zbtXz+02oTMkdNbP0MwhAvyK9v+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB9107

On 8/19/2025 12:08 PM, Chuck Lever wrote:
> On 8/19/25 12:03 PM, Tom Talpey wrote:
>> On 8/11/2025 4:35 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Reduce the per-connection footprint in the host's and RNIC's memory
>>> management TLBs by combining groups of a connection's Receive
>>> buffers into fewer IOVAs.
>>
>> This is an interesting and potentially useful approach. Keeping
>> the iova count (==1) reduces the size of work requests and greatly
>> simplifies processing.
>>
>> But how large are the iova's currently? RPCRDMA_DEF_INLINE_THRESH
>> is just 4096, which would mean typically <= 2 iova's. The max is
>> arbitrarily but consistently 64KB, is this complexity worth it?
> 
> The pool's shard size is RPCRDMA_MAX_INLINE_THRESH, or 64KB. That's the
> largest inline threshold this implementation allows.
> 
> The default inline threshold is 4KB, so one shared can hold up to
> sixteen 4KB Receive buffers. The default credit limit is 64, plus 8
> batch overflow, so 72 Receive buffers total per connection.
> 
> 
>> And, allocating large contiguous buffers would seem to shift the
>> burden to kmalloc and/or the IOMMU, so it's not free, right?
> 
> Can you elaborate on what you mean by "burden" ?

Sure, it's that somebody has to manage the iova scatter/gather
segments.

Using kmalloc or its moral equivalent offers a contract that the
memory returned is physically contiguous, 1 segment. That's
gonna scale badly.

Using the IOMMU, when available, stuffs the s/g list into its
hardware. Simple at the verb layer (again 1 segment) but uses
the shared hardware resource to provide it.

Another approach might be to use fast-register for the receive
buffers, instead of ib_register_mr on the privileged lmr. This
would be a page list with first-byte-offset and length, which
would put it the adapter's TPT instead of the PCI-facing IOMMU.
The fmr's would registerd only once, unlike the fmr's used for
remote transfers, so the cost would remain low. And fmr's typically
support 16 segments minimum, so no restriction there.

My point is that it seems unnecessary somehow in the RPCRDMA
layer. But, that's just my intuition. Finding some way to measure
any benefit (performance, setup overhead, scalbility, ...) would
be certainly be useful.

Tom.


>>> I don't have a good way to measure whether this approach is
>>> effective.
>>
>> I guess I'd need to see this data to be more convinced. But it does
>> seem potentially promising, at least on some RDMA provider hardware.
>>
>> Tom.
>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    include/linux/sunrpc/svc_rdma.h         |   3 +
>>>    include/trace/events/rpcrdma.h          |  99 +++++++++++
>>>    net/sunrpc/xprtrdma/Makefile            |   2 +-
>>>    net/sunrpc/xprtrdma/pool.c              | 223 ++++++++++++++++++++++++
>>>    net/sunrpc/xprtrdma/pool.h              |  25 +++
>>>    net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  43 ++---
>>>    6 files changed, 370 insertions(+), 25 deletions(-)
>>>    create mode 100644 net/sunrpc/xprtrdma/pool.c
>>>    create mode 100644 net/sunrpc/xprtrdma/pool.h
>>>
>>> Changes since v1:
>>> - Rename "chunks" to "shards" -- RPC/RDMA already has chunks
>>> - Replace pool's list of shards with an xarray
>>> - Implement bitmap-based shard free space management
>>> - Implement some naive observability
>>>
>>> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/
>>> svc_rdma.h
>>> index 22704c2e5b9b..b4f3c01f1b94 100644
>>> --- a/include/linux/sunrpc/svc_rdma.h
>>> +++ b/include/linux/sunrpc/svc_rdma.h
>>> @@ -73,6 +73,8 @@ extern struct percpu_counter svcrdma_stat_recv;
>>>    extern struct percpu_counter svcrdma_stat_sq_starve;
>>>    extern struct percpu_counter svcrdma_stat_write;
>>>    +struct rpcrdma_pool;
>>> +
>>>    struct svcxprt_rdma {
>>>        struct svc_xprt      sc_xprt;        /* SVC transport structure */
>>>        struct rdma_cm_id    *sc_cm_id;        /* RDMA connection id */
>>> @@ -112,6 +114,7 @@ struct svcxprt_rdma {
>>>        unsigned long         sc_flags;
>>>        struct work_struct   sc_work;
>>>    +    struct rpcrdma_pool  *sc_recv_pool;
>>>        struct llist_head    sc_recv_ctxts;
>>>          atomic_t         sc_completion_ids;
>>> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/
>>> rpcrdma.h
>>> index e6a72646c507..8bc713082c1a 100644
>>> --- a/include/trace/events/rpcrdma.h
>>> +++ b/include/trace/events/rpcrdma.h
>>> @@ -2336,6 +2336,105 @@
>>> DECLARE_EVENT_CLASS(rpcrdma_client_register_class,
>>>    DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_register);
>>>    DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_unregister);
>>>    +TRACE_EVENT(rpcrdma_pool_create,
>>> +    TP_PROTO(
>>> +        unsigned int poolid,
>>> +        size_t bufsize
>>> +    ),
>>> +
>>> +    TP_ARGS(poolid, bufsize),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(unsigned int, poolid)
>>> +        __field(size_t, bufsize)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->poolid = poolid;
>>> +        __entry->bufsize = bufsize;
>>> +    ),
>>> +
>>> +    TP_printk("poolid=%u bufsize=%zu bytes",
>>> +        __entry->poolid, __entry->bufsize
>>> +    )
>>> +);
>>> +
>>> +TRACE_EVENT(rpcrdma_pool_destroy,
>>> +    TP_PROTO(
>>> +        unsigned int poolid
>>> +    ),
>>> +
>>> +    TP_ARGS(poolid),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(unsigned int, poolid)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->poolid = poolid;),
>>> +
>>> +    TP_printk("poolid=%u",
>>> +        __entry->poolid
>>> +    )
>>> +);
>>> +
>>> +DECLARE_EVENT_CLASS(rpcrdma_pool_shard_class,
>>> +    TP_PROTO(
>>> +        unsigned int poolid,
>>> +        u32 shardid
>>> +    ),
>>> +
>>> +    TP_ARGS(poolid, shardid),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(unsigned int, poolid)
>>> +        __field(u32, shardid)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->poolid = poolid;
>>> +        __entry->shardid = shardid;
>>> +    ),
>>> +
>>> +    TP_printk("poolid=%u shardid=%u",
>>> +        __entry->poolid, __entry->shardid
>>> +    )
>>> +);
>>> +
>>> +#define DEFINE_RPCRDMA_POOL_SHARD_EVENT(name)                \
>>> +    DEFINE_EVENT(rpcrdma_pool_shard_class, name,            \
>>> +    TP_PROTO(                            \
>>> +        unsigned int poolid,                    \
>>> +        u32 shardid                        \
>>> +    ),                                \
>>> +    TP_ARGS(poolid, shardid))
>>> +
>>> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_new);
>>> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_free);
>>> +
>>> +TRACE_EVENT(rpcrdma_pool_buffer,
>>> +    TP_PROTO(
>>> +        unsigned int poolid,
>>> +        const void *buffer
>>> +    ),
>>> +
>>> +    TP_ARGS(poolid, buffer),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(unsigned int, poolid)
>>> +        __field(const void *, buffer)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->poolid = poolid;
>>> +        __entry->buffer = buffer;
>>> +    ),
>>> +
>>> +    TP_printk("poolid=%u buffer=%p",
>>> +        __entry->poolid, __entry->buffer
>>> +    )
>>> +);
>>> +
>>>    #endif /* _TRACE_RPCRDMA_H */
>>>      #include <trace/define_trace.h>
>>> diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
>>> index 3232aa23cdb4..f69456dffe87 100644
>>> --- a/net/sunrpc/xprtrdma/Makefile
>>> +++ b/net/sunrpc/xprtrdma/Makefile
>>> @@ -1,7 +1,7 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>>    obj-$(CONFIG_SUNRPC_XPRT_RDMA) += rpcrdma.o
>>>    -rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o \
>>> +rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o
>>> pool.o \
>>>        svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
>>>        svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
>>>        svc_rdma_pcl.o module.o
>>> diff --git a/net/sunrpc/xprtrdma/pool.c b/net/sunrpc/xprtrdma/pool.c
>>> new file mode 100644
>>> index 000000000000..e285c3e9c38e
>>> --- /dev/null
>>> +++ b/net/sunrpc/xprtrdma/pool.c
>>> @@ -0,0 +1,223 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>>> + *
>>> + * Pools for RPC-over-RDMA Receive buffers.
>>> + *
>>> + * A buffer pool attempts to conserve both the number of DMA mappings
>>> + * and the device's IOVA space by collecting small buffers together
>>> + * into a shard that has a single DMA mapping.
>>> + *
>>> + * API Contract:
>>> + *  - Buffers contained in one rpcrdma_pool instance are the same
>>> + *    size (rp_bufsize), no larger than RPCRDMA_MAX_INLINE_THRESH
>>> + *  - Buffers in one rpcrdma_pool instance are mapped using the same
>>> + *    DMA direction
>>> + *  - Buffers in one rpcrdma_pool instance are automatically released
>>> + *    when the instance is destroyed
>>> + *
>>> + * Future work:
>>> + *   - Manage pool resources by reference count
>>> + */
>>> +
>>> +#include <linux/list.h>
>>> +#include <linux/xarray.h>
>>> +#include <linux/sunrpc/svc_rdma.h>
>>> +
>>> +#include <rdma/ib_verbs.h>
>>> +
>>> +#include "xprt_rdma.h"
>>> +#include "pool.h"
>>> +
>>> +#include <trace/events/rpcrdma.h>
>>> +
>>> +/*
>>> + * An idr would give near perfect pool ID uniqueness, but for
>>> + * the moment the pool ID is used only for observability, not
>>> + * correctness.
>>> + */
>>> +static atomic_t rpcrdma_pool_id;
>>> +
>>> +struct rpcrdma_pool {
>>> +    struct xarray        rp_xa;
>>> +    struct ib_device    *rp_device;
>>> +    size_t            rp_shardsize;    // in bytes
>>> +    size_t            rp_bufsize;    // in bytes
>>> +    enum dma_data_direction    rp_direction;
>>> +    unsigned int        rp_bufs_per_shard;
>>> +    unsigned int        rp_pool_id;
>>> +};
>>> +
>>> +struct rpcrdma_pool_shard {
>>> +    u8            *pc_cpu_addr;
>>> +    u64            pc_mapped_addr;
>>> +    unsigned long        *pc_bitmap;
>>> +};
>>> +
>>> +static struct rpcrdma_pool_shard *
>>> +rpcrdma_pool_shard_alloc(struct rpcrdma_pool *pool, gfp_t flags)
>>> +{
>>> +    struct rpcrdma_pool_shard *shard;
>>> +    size_t bmap_size;
>>> +
>>> +    shard = kmalloc(sizeof(*shard), flags);
>>> +    if (!shard)
>>> +        goto fail;
>>> +
>>> +    bmap_size = BITS_TO_LONGS(pool->rp_bufs_per_shard) *
>>> sizeof(unsigned long);
>>> +    shard->pc_bitmap = kzalloc(bmap_size, flags);
>>> +    if (!shard->pc_bitmap)
>>> +        goto free_shard;
>>> +
>>> +    /*
>>> +     * For good NUMA awareness, allocate the shard's I/O buffer
>>> +     * on the NUMA node that the underlying device is affined to.
>>> +     */
>>> +    shard->pc_cpu_addr = kmalloc_node(pool->rp_shardsize, flags,
>>> +                      ibdev_to_node(pool->rp_device));
>>> +    if (!shard->pc_cpu_addr)
>>> +        goto free_bitmap;
>>> +    shard->pc_mapped_addr = ib_dma_map_single(pool->rp_device,
>>> +                          shard->pc_cpu_addr,
>>> +                          pool->rp_shardsize,
>>> +                          pool->rp_direction);
>>> +    if (ib_dma_mapping_error(pool->rp_device, shard->pc_mapped_addr))
>>> +        goto free_iobuf;
>>> +
>>> +    return shard;
>>> +
>>> +free_iobuf:
>>> +    kfree(shard->pc_cpu_addr);
>>> +free_bitmap:
>>> +    kfree(shard->pc_bitmap);
>>> +free_shard:
>>> +    kfree(shard);
>>> +fail:
>>> +    return NULL;
>>> +}
>>> +
>>> +static void
>>> +rpcrdma_pool_shard_free(struct rpcrdma_pool *pool,
>>> +            struct rpcrdma_pool_shard *shard)
>>> +{
>>> +    ib_dma_unmap_single(pool->rp_device, shard->pc_mapped_addr,
>>> +                pool->rp_shardsize, pool->rp_direction);
>>> +    kfree(shard->pc_cpu_addr);
>>> +    kfree(shard->pc_bitmap);
>>> +    kfree(shard);
>>> +}
>>> +
>>> +/**
>>> + * rpcrdma_pool_create - Allocate and initialize an rpcrdma_pool
>>> instance
>>> + * @args: pool creation arguments
>>> + * @flags: GFP flags used during pool creation
>>> + *
>>> + * Returns a pointer to an opaque rpcrdma_pool instance or
>>> + * NULL. If a pool instance is returned, caller must free the
>>> + * returned instance using rpcrdma_pool_destroy().
>>> + */
>>> +struct rpcrdma_pool *
>>> +rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags)
>>> +{
>>> +    struct rpcrdma_pool *pool;
>>> +
>>> +    pool = kmalloc(sizeof(*pool), flags);
>>> +    if (!pool)
>>> +        return NULL;
>>> +
>>> +    xa_init_flags(&pool->rp_xa, XA_FLAGS_ALLOC);
>>> +    pool->rp_device = args->pa_device;
>>> +    pool->rp_shardsize = RPCRDMA_MAX_INLINE_THRESH;
>>> +    pool->rp_bufsize = args->pa_bufsize;
>>> +    pool->rp_direction = args->pa_direction;
>>> +    pool->rp_bufs_per_shard = pool->rp_shardsize / pool->rp_bufsize;
>>> +    pool->rp_pool_id = atomic_inc_return(&rpcrdma_pool_id);
>>> +
>>> +    trace_rpcrdma_pool_create(pool->rp_pool_id, pool->rp_bufsize);
>>> +    return pool;
>>> +}
>>> +
>>> +/**
>>> + * rpcrdma_pool_destroy - Release resources owned by @pool
>>> + * @pool: buffer pool instance that will no longer be used
>>> + *
>>> + * This call releases all buffers in @pool that were allocated
>>> + * via rpcrdma_pool_buffer_alloc().
>>> + */
>>> +void
>>> +rpcrdma_pool_destroy(struct rpcrdma_pool *pool)
>>> +{
>>> +    struct rpcrdma_pool_shard *shard;
>>> +    unsigned long index;
>>> +
>>> +    trace_rpcrdma_pool_destroy(pool->rp_pool_id);
>>> +
>>> +    xa_for_each(&pool->rp_xa, index, shard) {
>>> +        trace_rpcrdma_pool_shard_free(pool->rp_pool_id, index);
>>> +        xa_erase(&pool->rp_xa, index);
>>> +        rpcrdma_pool_shard_free(pool, shard);
>>> +    }
>>> +
>>> +    xa_destroy(&pool->rp_xa);
>>> +    kfree(pool);
>>> +}
>>> +
>>> +/**
>>> + * rpcrdma_pool_buffer_alloc - Allocate a buffer from @pool
>>> + * @pool: buffer pool from which to allocate the buffer
>>> + * @flags: GFP flags used during this allocation
>>> + * @cpu_addr: CPU address of the buffer
>>> + * @mapped_addr: mapped address of the buffer
>>> + *
>>> + * Return values:
>>> + *   %true: @cpu_addr and @mapped_addr are filled in with a DMA-
>>> mapped buffer
>>> + *   %false: No buffer is available
>>> + *
>>> + * When rpcrdma_pool_buffer_alloc() is successful, the returned
>>> + * buffer is freed automatically when the buffer pool is released
>>> + * by rpcrdma_pool_destroy().
>>> + */
>>> +bool
>>> +rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
>>> +              void **cpu_addr, u64 *mapped_addr)
>>> +{
>>> +    struct rpcrdma_pool_shard *shard;
>>> +    u64 returned_mapped_addr;
>>> +    void *returned_cpu_addr;
>>> +    unsigned long index;
>>> +    u32 id;
>>> +
>>> +    xa_for_each(&pool->rp_xa, index, shard) {
>>> +        unsigned int i;
>>> +
>>> +        returned_cpu_addr = shard->pc_cpu_addr;
>>> +        returned_mapped_addr = shard->pc_mapped_addr;
>>> +        for (i = 0; i < pool->rp_bufs_per_shard; i++) {
>>> +            if (!test_and_set_bit(i, shard->pc_bitmap)) {
>>> +                returned_cpu_addr += i * pool->rp_bufsize;
>>> +                returned_mapped_addr += i * pool->rp_bufsize;
>>> +                goto out;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    shard = rpcrdma_pool_shard_alloc(pool, flags);
>>> +    if (!shard)
>>> +        return false;
>>> +    set_bit(0, shard->pc_bitmap);
>>> +    returned_cpu_addr = shard->pc_cpu_addr;
>>> +    returned_mapped_addr = shard->pc_mapped_addr;
>>> +
>>> +    if (xa_alloc(&pool->rp_xa, &id, shard, xa_limit_16b, flags) != 0) {
>>> +        rpcrdma_pool_shard_free(pool, shard);
>>> +        return false;
>>> +    }
>>> +    trace_rpcrdma_pool_shard_new(pool->rp_pool_id, id);
>>> +
>>> +out:
>>> +    *cpu_addr = returned_cpu_addr;
>>> +    *mapped_addr = returned_mapped_addr;
>>> +
>>> +    trace_rpcrdma_pool_buffer(pool->rp_pool_id, returned_cpu_addr);
>>> +    return true;
>>> +}
>>> diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
>>> new file mode 100644
>>> index 000000000000..214f8fe78b9a
>>> --- /dev/null
>>> +++ b/net/sunrpc/xprtrdma/pool.h
>>> @@ -0,0 +1,25 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>>> + *
>>> + * Pools for Send and Receive buffers.
>>> + */
>>> +
>>> +#ifndef RPCRDMA_POOL_H
>>> +#define RPCRDMA_POOL_H
>>> +
>>> +struct rpcrdma_pool_args {
>>> +    struct ib_device    *pa_device;
>>> +    size_t            pa_bufsize;
>>> +    enum dma_data_direction    pa_direction;
>>> +};
>>> +
>>> +struct rpcrdma_pool;
>>> +
>>> +struct rpcrdma_pool *
>>> +rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags);
>>> +void rpcrdma_pool_destroy(struct rpcrdma_pool *pool);
>>> +bool rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
>>> +                   void **cpu_addr, u64 *mapped_addr);
>>> +
>>> +#endif /* RPCRDMA_POOL_H */
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/
>>> xprtrdma/svc_rdma_recvfrom.c
>>> index e7e4a39ca6c6..f625f1ede434 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>>> @@ -104,9 +104,9 @@
>>>    #include <linux/sunrpc/svc_rdma.h>
>>>      #include "xprt_rdma.h"
>>> -#include <trace/events/rpcrdma.h>
>>> +#include "pool.h"
>>>    -static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
>>> +#include <trace/events/rpcrdma.h>
>>>      static inline struct svc_rdma_recv_ctxt *
>>>    svc_rdma_next_recv_ctxt(struct list_head *list)
>>> @@ -115,14 +115,14 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
>>>                        rc_list);
>>>    }
>>>    +static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
>>> +
>>>    static struct svc_rdma_recv_ctxt *
>>>    svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>>>    {
>>>        int node = ibdev_to_node(rdma->sc_cm_id->device);
>>>        struct svc_rdma_recv_ctxt *ctxt;
>>>        unsigned long pages;
>>> -    dma_addr_t addr;
>>> -    void *buffer;
>>>          pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
>>>        ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
>>> @@ -130,13 +130,11 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>>>        if (!ctxt)
>>>            goto fail0;
>>>        ctxt->rc_maxpages = pages;
>>> -    buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
>>> -    if (!buffer)
>>> +
>>> +    if (!rpcrdma_pool_buffer_alloc(rdma->sc_recv_pool, GFP_KERNEL,
>>> +                       &ctxt->rc_recv_buf,
>>> +                       &ctxt->rc_recv_sge.addr))
>>>            goto fail1;
>>> -    addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
>>> -                 rdma->sc_max_req_size, DMA_FROM_DEVICE);
>>> -    if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
>>> -        goto fail2;
>>>          svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
>>>        pcl_init(&ctxt->rc_call_pcl);
>>> @@ -149,30 +147,17 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>>>        ctxt->rc_recv_wr.sg_list = &ctxt->rc_recv_sge;
>>>        ctxt->rc_recv_wr.num_sge = 1;
>>>        ctxt->rc_cqe.done = svc_rdma_wc_receive;
>>> -    ctxt->rc_recv_sge.addr = addr;
>>>        ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
>>>        ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
>>> -    ctxt->rc_recv_buf = buffer;
>>>        svc_rdma_cc_init(rdma, &ctxt->rc_cc);
>>>        return ctxt;
>>>    -fail2:
>>> -    kfree(buffer);
>>>    fail1:
>>>        kfree(ctxt);
>>>    fail0:
>>>        return NULL;
>>>    }
>>>    -static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
>>> -                       struct svc_rdma_recv_ctxt *ctxt)
>>> -{
>>> -    ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
>>> -                ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
>>> -    kfree(ctxt->rc_recv_buf);
>>> -    kfree(ctxt);
>>> -}
>>> -
>>>    /**
>>>     * svc_rdma_recv_ctxts_destroy - Release all recv_ctxt's for an xprt
>>>     * @rdma: svcxprt_rdma being torn down
>>> @@ -185,8 +170,9 @@ void svc_rdma_recv_ctxts_destroy(struct
>>> svcxprt_rdma *rdma)
>>>          while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
>>>            ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
>>> -        svc_rdma_recv_ctxt_destroy(rdma, ctxt);
>>> +        kfree(ctxt);
>>>        }
>>> +    rpcrdma_pool_destroy(rdma->sc_recv_pool);
>>>    }
>>>      /**
>>> @@ -305,8 +291,17 @@ static bool svc_rdma_refresh_recvs(struct
>>> svcxprt_rdma *rdma,
>>>     */
>>>    bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
>>>    {
>>> +    struct rpcrdma_pool_args args = {
>>> +        .pa_device    = rdma->sc_cm_id->device,
>>> +        .pa_bufsize    = rdma->sc_max_req_size,
>>> +        .pa_direction    = DMA_FROM_DEVICE,
>>> +    };
>>>        unsigned int total;
>>>    +    rdma->sc_recv_pool = rpcrdma_pool_create(&args, GFP_KERNEL);
>>> +    if (!rdma->sc_recv_pool)
>>> +        return false;
>>> +
>>>        /* For each credit, allocate enough recv_ctxts for one
>>>         * posted Receive and one RPC in process.
>>>         */
>>
> 
> 


