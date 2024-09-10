Return-Path: <linux-nfs+bounces-6365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FA97376A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6624B25B85
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFAC1862B8;
	Tue, 10 Sep 2024 12:32:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF218FDAF
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971539; cv=fail; b=YhkOnrlfhMCrHYGtaJaaSgXS+6Z97YAzv4WXOoDprK2Q2XVRoE6HgATE6oK4Z0VrCYl3n4Uz4jjmCpaO8ie92XLLgBzcMrwJY/grqrSsHW4Lson2pHn4wMBHnMIM9rCFHLDUbzVhY6KeYE0l+I8LamnW71rRcjwAJxznR53jHO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971539; c=relaxed/simple;
	bh=LWUl4elE5KqwUmP0AvlJTSRQ48LS1wcPKCmcZU735H8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcVu7c1DczpbhVJkAZZwiULcp8J1PvptCISILsqxj3BYvuq2U5+Dm+/Ir/B4EbSdEkvBlXNhkvKO9cc9tDjWNnBZrpZf5nZMltCmCmdM0qHRrjV/0ZNt/fqxYvOFhfKXGvzCGGg0EVUziRkpiqy/hjHOwJRFQyKMOFsBRSu5lUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.220.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxS1Olt19sLnZEIrSB8ntTLdrlTOm4vaqS2kLptlZ3xET83d/RH7n4JTLrRF1udv3bRb6sPFjUm1UT/ia6lBMFSKQaUDvOG02GQ/ET3OiBSYyFSBi37+jCXI1Oq0l0Ndo/NxseUjgzCJBSo4DJWnYUeHuftv4F5iLMFg91XPP/huwNY9cmXXC12h0rmhXQvSk6hw7J9OuQqqMwrvyM6o5eTh7WU9gJz2GFCzntMUdGOEV0a7HLPqsZbRPek1mUzT543bxJxZlZweD2pDRFLMH/K2jTExBtNQzCplJoD/FgoCOhLGNbm1/JJ8GoRWyBgPg5gYwvGDRsxV737PzSza2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FplrkW6h1Y+EuwTMR47FoK9IkwVkncDCQMamuuv2DiA=;
 b=DoVi5ShbOCL/7V/TlKYqYsW03yhSMEWuGy/yyPjt6DaAEc9efwai+fTVhlGmhHVWdMj2KojMjBAnN7ljnpUfpuqBNp86bP39tlEdRb13eRR1wq37jt5gVMGRCudHhE64pmneklbcl+8kqP2IsNQvDmtJSM+sGzZSMNbEeJoi7ZBoCXKaB8SP8f8TIs6DlqmfiXxiU2hiw5VMu6tM5B/SX2dZQH+jxr1qsh8s0VrpADBpdmb8NoAWD/bBmty+S66jAXArnir56mBepE+UzGS8rwdxhKK7hIdNhoxGvYhH4YCQuVjVICWHMocz72KRON/+7FzZ1pkWgNhGvs15eAZf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL1PR01MB7721.prod.exchangelabs.com (2603:10b6:208:395::9) by
 SA6PR01MB8701.prod.exchangelabs.com (2603:10b6:806:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Tue, 10 Sep 2024 12:32:15 +0000
Received: from BL1PR01MB7721.prod.exchangelabs.com
 ([fe80::d33d:8437:f7d:568e]) by BL1PR01MB7721.prod.exchangelabs.com
 ([fe80::d33d:8437:f7d:568e%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 12:32:15 +0000
Message-ID: <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
Date: Tue, 10 Sep 2024 08:32:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
To: Olga Kornievskaia <okorniev@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 Dai Ngo <Dai.Ngo@oracle.com>, linux-nfs@vger.kernel.org
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
 <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To BL1PR01MB7721.prod.exchangelabs.com
 (2603:10b6:208:395::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR01MB7721:EE_|SA6PR01MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c24f56-9293-4b38-36ea-08dcd1949a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEU2aVJJUmdXVjEzM0tJRTIzQUJUZFhmQlFrZEZRWTA3dHBaMFRreGhxcTZl?=
 =?utf-8?B?YXBqcnorWmlhejBqSTE3YmtSbE9DejhoK0dCZmtpZEpPaS9IVnlxQ1lUVHFE?=
 =?utf-8?B?eXZld1ZVejkzclpNdXRtdjZUY1ZZRFR5V256THlqdmVYeUxIRCtSSitYdmNs?=
 =?utf-8?B?ZW9ZSnhheVlUWW5NNFVXN1ZDbFJ6MkpwdVUwZUNBR1FjUStnSmc5WWhlQUk2?=
 =?utf-8?B?S3NLbzJtbGsxSGlqaFVkY21OVVFiOTk4djhJMGlYOXhIRy93Q3hMcXFRdnhj?=
 =?utf-8?B?cGlvVGRhVm1vZ1dVcllPZ1RlR1VGR09hTTlvNmQxekhMeEF6UlNHVllaUUVT?=
 =?utf-8?B?eUx6N2t3WUoydndTbnBHWWZHUk9FSmx6dzdIYm56MnVOM0ZxWU5XcTBKYmJS?=
 =?utf-8?B?d0l0WDdBbmdTT3Y3S21uQXBVTkpueE1SS2ZReGlrR1Npc0FObUZnaVZGZlRa?=
 =?utf-8?B?RGNtbCtrZEk2aEdUZnNkSFBSSFdvOUtBc3VNY2lON0trSHBEejF1SU1lbEs0?=
 =?utf-8?B?Z1RaZFRkTm1QTlVCa1V4TFpNY2pZUk1vc0xlVEpkelF6bGJwckJoRkhvYWxx?=
 =?utf-8?B?RlA3Nk1xZXMvTUhPd1RqUHk3WWpxMkY2R3hCV0FJWFQ1RlZqZTVWV3JZWTFj?=
 =?utf-8?B?eW5Lc1I5d2V3eElscThUWVBBWTB2NjdDL0pZdFdhbWVSUWNNZU9TU3lNQ0F6?=
 =?utf-8?B?YzZIQzVkUnlzdFVwWHVGbzUzYzFLclVSSVkxcnBGRWZsUjZWK0lKdlEybGNi?=
 =?utf-8?B?c1RTbnBmMWxzSjhLZFNvZFBmemh3SGtMZmc2WTNzZTNxd2tvOU9PNlJpT2cr?=
 =?utf-8?B?eUkxUkhiaEZHVFlBZlk3bXdHeXgrTTVZL3VXRzd4L3FFOE9Pa1pTVXgzU2FH?=
 =?utf-8?B?VVhGc1lBTk9aZDJkYVFCd3k0c3ZWd0tiVUdObGwrOWVmTmNWeDZ2bkNsSldp?=
 =?utf-8?B?ejBOdnRTVFZad01YQVJqQjhBVzA1cXlYbU5xQlI3eTdCSEtGdUxINzBlRjhW?=
 =?utf-8?B?clZHMy9Wc0lpdVFjaCthVWVFeTVSc0prNHloNStSdW5ySnoyalJRYkhhcE5N?=
 =?utf-8?B?Ti9HRXVJbHVDTUg0elpnRXJaQTBrYmhYM0VSMjI3MFNaclQ2V2NRdzgvVVJo?=
 =?utf-8?B?UE52OW1HOVcxWVUwVVNxU2YvUzlPQWREeFNiNXgyYjZ4L2lWUURPOTJOd3pa?=
 =?utf-8?B?Q2FtYmlBaW1OdTlBK3FjWkNFbVZidWJLUXJRQTRXNzdzNTFDQVhNTmdGaDE4?=
 =?utf-8?B?Y1ZacXZSVVRnTU1haFp1VkhXOE1nY3RBNWN1OXN2NFdDWDBpdUZ4RHd4R1Rl?=
 =?utf-8?B?bzduWDhjbzZ3RG5QRG45b2tZdkhrOTZLT3orSUNJdytnUFFSMHZzbjdmMHFt?=
 =?utf-8?B?QmNBWWhsUU5idmNNeUlyVWxZYlpraHBTUS9FR2xTNXlsYzFobEFBL0hjZFlX?=
 =?utf-8?B?a2JNbDVKRk5OTXJMRjc5bmFzbkN4RGloSm5rS0t6VTNaODROOEpPZXB4em11?=
 =?utf-8?B?WGVtMDNiTmY1UXJNSnhoNUozamJYZW90Q3hQOHhsdHl5TFNaeVNldHh0WjNq?=
 =?utf-8?B?RUFUQTU2ZkdUbmJQZWZWL2pIdTgyT2Eydm12b09jK0lXNVp5bEVxZTVkQzdq?=
 =?utf-8?B?RG9pN1c3bmZDYzBrdDZBZEZ1U2N5eFM0ci9SS29VUDd0ZGtUTE8raEpCSVRl?=
 =?utf-8?B?cS9TQjNrUnNBUjkyWWR2eFRLdXVlMFFQSjZyUWNYeWtialEybjBBWmlHVnZn?=
 =?utf-8?B?d3JuV3p4TmEwandLTjdaUWJ6RFRCUjEzZ29JbHlBMVJmSmdpaGpnM1FhdDds?=
 =?utf-8?B?a0hlR3NudnFsSXE2SHlrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7721.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTMyNGNQNmwwN3ZUMmhXOExLMWxURGNQWFVMbWNPV05YOVhUS2Rhd3pqZjZj?=
 =?utf-8?B?OVFnYUg1RXFNMnYreWRjUzhZWUhQa09UOEU2elc1dHY4S3VhaU5iVyt0elpz?=
 =?utf-8?B?ZzJJN0g2ejN3eVJiMG82UEVFdGNSd281YTY0c2xFaHFDbE1EWDQ1YUI4VHRV?=
 =?utf-8?B?RWYzNFN3VnNoaEhaYkZKcFNjeEUxUDlLNWFsNUtHMXAxcGZQQkttc1JvQytB?=
 =?utf-8?B?eVJtNFEzRGhJa1lPRlhtK3Y1aS8zdEdVV21Yajltdy9VU2tiOVZIT2hzbjhj?=
 =?utf-8?B?b2w5NklodkdWa2RQUlpRZGVtbGw2ZEJjQWlEYkFOK29TNnZnQlM5eXk4MDRv?=
 =?utf-8?B?SU9OdUZteVh6MURwQjc5SHVJQzFWZDBURnhlWjhUWlRBakZmZmsvWVZ1Mith?=
 =?utf-8?B?d2dZMzBETWpoR2hwRnVhYkNLSjJDS1hzaFI3VDF5VlFSVk1aZlcyQi9kTk0w?=
 =?utf-8?B?TTlzM1NOeTRVWWlwOCs3OWIyNjhrTlJVZjZ1blhlcTcxd1lHbUtQbGpvOTM4?=
 =?utf-8?B?Z1UxL2M2WGFaQVRWV2RtZFFRb2YrYU9GR2RraUdnZWt4S2loT08rOGwxNFJX?=
 =?utf-8?B?RFN5bkRSanZIOFBEYnFSbWQxS0s0Q1pYZXllOTFRUDVtY3ZxcFVXYUhQV0Jq?=
 =?utf-8?B?dWdBcDdtZUVtbVdzMGFpa2FMVmh2MVdJTDlDcjh5YXdXZ3djdGtIU3pxOVNG?=
 =?utf-8?B?NlNuc0RUaUlXOEE1MGRwZUFnWmlISnl6MWF5dmZiKzA3N2FXaVcvbit0OG4y?=
 =?utf-8?B?Q1VTQ3pWVmZJSEZtTTRuOFdhSWFWZDBjZW94d2Q4eGJSSEJrcGdpUVgwbUc3?=
 =?utf-8?B?RzQ0UVZtWmpwZERReWZ0eEYyU2Zja1FQVnkrK0JPc1M4THd4c0xmam9vc2Vz?=
 =?utf-8?B?QXlibDRLYlBwa2JVS3B2OGtyc3owK3RCejlvYndYYUpwbDJ1WGF2N2VXZGw3?=
 =?utf-8?B?WEFBTXZxWlpoOUwyaTJQUGpSQ09oTDlPWGJ1YTlNYVRsMWN6azJkNzhiT1ls?=
 =?utf-8?B?OUhyMVdNSFRTTk83ZlRsUEZ2aEMvaWxYT2MxYW0rRmUzM2ZNaS92RDNRK2RO?=
 =?utf-8?B?dUVVQkU1Rm9QeEFETVdudkNFTUs4TEptRkZlU2pMZFBLS0dFdmFPMlhOaUdR?=
 =?utf-8?B?eUU5dXdwbXUwWlNJdVV4S3FCN2FVNTFscFJzdGJYMWJaN0wrT0xzNFZrWDM2?=
 =?utf-8?B?YkFwOWV2OERxbU9QK3c1c2p2UUdEc0tQOWt3b3JxUDR2VWFYSE1VSERZVUlE?=
 =?utf-8?B?bElzbUZJVVpmYjE4KzM2a3RnZ3UvUlVDUXZqQXA1Y1Y3Y2x5RlkzUjBjY1V2?=
 =?utf-8?B?NjFOcmxLekIwR1lscnN2N3JrRjNRa0F1RWpqVmtNL2VPZ2o2SWp1eVZweTNp?=
 =?utf-8?B?WDhiOHlKQWZHK2lqcWdMTTlMTTI5SU5CLzRwQTBxQ0tlRXlCVldwaG9obklh?=
 =?utf-8?B?ZTVNZXJ4Z1FPUk1pM0lTcnUvOExhb2xKMnVnWHg1YWxnT2QzSGxhSGE4aS8v?=
 =?utf-8?B?RitNR3EvMUxnRnFZZWtJdlUvdHg2MWpXRWZObzFFYi9YMG1tMFloZHR1c1Q4?=
 =?utf-8?B?WFc5SzNka1ZMc3JacnM3Z2hVOXlMSkM1ZjBWQ0hZRlhJT2pmSFpqdFFJVFFZ?=
 =?utf-8?B?OVZDWE53ZDFLY0J4RkNQYjRtQlhzcVdxU253c2F5SE14SjBZbmIyTzRjTXhE?=
 =?utf-8?B?VllVZURKbmRic3dwVGplQzYrT0s3dVhqMnJwNUk4ZDMrV1JVdXhwc01xamJK?=
 =?utf-8?B?cGVtK2RZc3FjMWRTWHpCNDZkNENSTHgzQXltdlZrVHk2TWo2MlZuODJtaG5w?=
 =?utf-8?B?emcrUVBCN0NvSE5va014TEtDdUhWeUtNalUwU2tOUFI3WE5YZzhFV3lwRTEy?=
 =?utf-8?B?WTl1WFUrVG5SMEE0a0V1Y1YrcFdkVk1pcmdDcUxVTmhWK25aZ2hkalhqY3ds?=
 =?utf-8?B?SGZWeEZvL29kNmh5M2gwWkxMcmx0ZnMyZFQ4aXpuZ2Zrc0s0RWRqS2NFRmhM?=
 =?utf-8?B?TTA5R0RNSzczYUZ5T1dOTngwWXYramkrTWtLNm1vN1lFRFcyWEdhQ2ZoVzkz?=
 =?utf-8?B?SnFyTWkvSElLQS9CazZndDdaQ0l1SkNPMmVrWGV6NTZPdXpMSm9PR3JSa256?=
 =?utf-8?Q?fW4Y=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c24f56-9293-4b38-36ea-08dcd1949a0c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7721.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 12:32:15.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHvRiBzLArgK39ca8HyO5mV+PuGiDcmNE4s2uHTDyB0b1JScoyKjOjDNCKh5g1JA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8701

On 9/9/2024 11:02 AM, Olga Kornievskaia wrote:
> On Mon, Sep 9, 2024 at 10:38 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On Mon, Sep 09, 2024 at 10:17:42AM -0400, Olga Kornievskaia wrote:
>>> On Mon, Sep 9, 2024 at 8:24 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
>>>>> The pair of bloom filtered used by delegation_blocked() was intended to
>>>>> block delegations on given filehandles for between 30 and 60 seconds.  A
>>>>> new filehandle would be recorded in the "new" bit set.  That would then
>>>>> be switch to the "old" bit set between 0 and 30 seconds later, and it
>>>>> would remain as the "old" bit set for 30 seconds.
>>>>>
>>>>
>>>> Since we're on the subject...
>>>>
>>>> 60s seems like an awfully long time to block delegations on an inode.
>>>> Recalls generally don't take more than a few seconds when things are
>>>> functioning properly.
>>>>
>>>> Should we swap the bloom filters more often?
>>>
>>> I was also thinking that perhaps we can do 15-30s perhaps? Another
>>> thought was should this be a configurable value (with some
>>> non-negotiable min and max)?
>>
>> If it needs to be configurable, then we haven't done our jobs as
>> system architects. Temporarily blocking delegation ought to be
>> effective without human intervention IMHO.
>>
>> At least let's get some specific usage scenarios that demonstrate a
>> palpable need for enabling an admin to adjust this behavior (ie, a
>> need that is not simply an implementation bug), then design for
>> those specific cases.
>>
>> Does NFSD have metrics in this area, for example?
>>
>> Generally speaking, though, I'm not opposed to finessing the behavior
>> of the Bloom filter. I'd like to apply the patch below for v6.12,
> 
> 100% agreed that we need this patch to go in now. The configuration
> was just a thought for after which I should have stated explicitly. I
> guess I'm not a big fan of hard coded numbers in the code and naively
> thinking that it's always better to have a config over a hardcoded
> value.

No constant is ever correct in networking, especially timeouts. So yes,
it should be adjustable. But even then, choosing a number here is
fundamentally difficult.

Delegations can block for perfectly valid long periods, right? Say it
takes a long time to flush a write delegation, or if the network is
partitioned to the (other) client being recalled. 30 seconds to data
corruption is quite the guillotine.

Tom.

>> preserving the Cc: stable, but handle the behavioral finessing via
>> a subsequent patch targeting v6.13 so that can be appropriately
>> reviewed and tested. Ja?
>>
>> BTW, nice catch!
>>
>>
>>>>> Unfortunately the code intended to clear the old bit set once it reached
>>>>> 30 seconds old, preparing it to be the next new bit set, instead cleared
>>>>> the *new* bit set before switching it to be the old bit set.  This means
>>>>> that the "old" bit set is always empty and delegations are blocked
>>>>> between 0 and 30 seconds.
>>>>>
>>>>> This patch updates bd->new before clearing the set with that index,
>>>>> instead of afterwards.
>>>>>
>>>>> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after recalling them.")
>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>> ---
>>>>>   fs/nfsd/nfs4state.c | 5 +++--
>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 4313addbe756..6f18c1a7af2e 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
>>>>>    * When a delegation is recalled, the filehandle is stored in the "new"
>>>>>    * filter.
>>>>>    * Every 30 seconds we swap the filters and clear the "new" one,
>>>>> - * unless both are empty of course.
>>>>> + * unless both are empty of course.  This results in delegations for a
>>>>> + * given filehandle being blocked for between 30 and 60 seconds.
>>>>>    *
>>>>>    * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
>>>>>    * low 3 bytes as hash-table indices.
>>>>> @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
>>>>>                if (ktime_get_seconds() - bd->swap_time > 30) {
>>>>>                        bd->entries -= bd->old_entries;
>>>>>                        bd->old_entries = bd->entries;
>>>>> +                     bd->new = 1-bd->new;
>>>>>                        memset(bd->set[bd->new], 0,
>>>>>                               sizeof(bd->set[0]));
>>>>> -                     bd->new = 1-bd->new;
>>>>>                        bd->swap_time = ktime_get_seconds();
>>>>>                }
>>>>>                spin_unlock(&blocked_delegations_lock);
>>>>
>>>> --
>>>> Jeff Layton <jlayton@kernel.org>
>>>>
>>>
>>
>> --
>> Chuck Lever
>>
> 
> 


