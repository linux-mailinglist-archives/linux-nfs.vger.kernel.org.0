Return-Path: <linux-nfs+bounces-15012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF3BC165F
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73ADA4E6850
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A71B4257;
	Tue,  7 Oct 2025 12:45:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021130.outbound.protection.outlook.com [40.93.194.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E031E5B82
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841153; cv=fail; b=svx3UkHgcFBTgoOEDcSpS4ESYlLIQg7Czxq9a67NBBhEjY2iMxYkBg2tOUN5stWSRIXv5udcg50KwhUs4/5DrHzSEzRHyfIZhbqoje/j5JZDqGpLZp/JnyJJtOlCSd2UNiqGNVakrv0D7agBPgkgRGwJ7Fdr8egArcI1UZ6taHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841153; c=relaxed/simple;
	bh=/BTGO5Wol10JUZf3exKnXCTpcn0qoaAlR6xz9CyHhgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tOtEvPMbrp1HlqMq2NdlCODB9dlgEsNzhK5dfTbpCz53Y672v323VR2n2HtHdAMeBiEdPetp7HFjP6yI00Pc5qWEi5e8kDoPhVop/JofmiF/eJdZ/FwuGHuu7cIoJa1kOShmRa92sAaz5CJl6YVGfKhjLNqEcOpK/h+tp5rBOjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.194.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfYr6d5KwXfSpb4VAjr8KgWsrBihR5d52UXFDx7d50OO6M+EPrP8WO68mZ9zrlQ1fyR8auJpkCtf7bbqgRXP9rvQEXvPMnnEef6MoO7p+uHVSxXVNKfrd38RXnrhyG4Y6gmlVEaYsP2H2i9XxiTeXe8pQ00BA1aSXChzPpEuWw6mAAbzRbxsk50By3VtkJnF3dpSr+h1pDcV+2xhhjUCR4x+GtiJXrSVXlv28JYhJsVCMm8FRWOFKdVFIYIuV7h+flGuK0w+IkxrNJTSxUsFPUNQN6zbL+CQt7MAYw8MvAEO9Sk/DqQ9ZpajTNpNwR9eVLtw1HTPcTCGai6wLsm0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2W64okarl+byB+X/VpclEw4jcA99l9NRmOnf2jAqcs=;
 b=JT7k28TMMAv3Cj4PMdN9Rv/lgh/hDIyEOPZsPFVDdOKyH5Agb0+/J8xbgxPFniDh2wodpp6JpMAjgHvSWwb7SeXEh1eycpT+9CUs5S8Fy7Wz0j8+nz6CF8mPCyBHa/NnkfVWxGCOXfzybkUWGLeWHRD45ecjD8bpTQmlpij7OJHj90EFHlZsX9M6nArI3kiCP36DBzkWN17ii8XbGc7wtumyP2IC+LHnyct6dam94d4yp3lr1Cm7D4IXaBlxyHZoF7IwLew9klhPXsR3/TPMzMUuQ650uRBKFeFPi4eQsPCAagVJaY8VpQoi8XTWyh9rB+nwATDzYob07ea8Paw6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CY3PR01MB9193.prod.exchangelabs.com (2603:10b6:930:109::5) by
 SJ0PR01MB6269.prod.exchangelabs.com (2603:10b6:a03:298::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 12:45:44 +0000
Received: from CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5818:cc62:988f:8908]) by CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5818:cc62:988f:8908%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 12:45:44 +0000
Message-ID: <f0b5acc6-0e67-4736-833c-4af16c05ef74@talpey.com>
Date: Tue, 7 Oct 2025 08:45:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Fix unwanted memory overwrites
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251006184502.1414-1-cel@kernel.org>
From: Tom Talpey <tom@talpey.com>
Content-Language: en-US
In-Reply-To: <20251006184502.1414-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To CY3PR01MB9193.prod.exchangelabs.com
 (2603:10b6:930:109::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR01MB9193:EE_|SJ0PR01MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a8a112-37ef-4da9-890b-08de059f6e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRCWEdvTnlhbmxxVjRUdysyODdsZ1BPUVpOd0swekNrREFlTWw4WHRxeWMx?=
 =?utf-8?B?Z1hjNStDVWtSOElHNDRnWmxpays3TU9WQVkvNUplUGl4aVhnMHkvL0dqYnVY?=
 =?utf-8?B?bVlFb2tHQ0FqcitSdjd3SUdKbE5pK2JsYVNiaUNiWitXNlZ6S1dZa2NqYmpo?=
 =?utf-8?B?ZGhrclpkWWhjeG42Q0ZwN0FGVERzcTRlNUUwbENTTElSRFRKWE9Rc1JLZTJL?=
 =?utf-8?B?cGRkbU1uMjZUOVpoRVBWRDBhUFhESjhVL3RUUlZqOVlETjdoMGVmYnE1M3BI?=
 =?utf-8?B?MEN4bGZ0K0lpaTdKU2lzTHdSRFBTbmdDc01INFkyK1F0WGhDT3dDNWVQUFVP?=
 =?utf-8?B?Zm9hMFlQMk0zK016dUNSeEF2c2VxSi9oWWpFdGxERFlqZkZ3Vm1XOFd5RHgv?=
 =?utf-8?B?OTFDVkswSTArN2JNTUk1OVVhaFFEakE5YzJJS3ozWHAyRXVWS25MQnpMTWsr?=
 =?utf-8?B?RnNDcDhON2F5aHFzQW15OWtYdW5Qand2cmJpNmhtc1hjZE12YkpQaTY1Njgz?=
 =?utf-8?B?VndDQ3ZPeGtKL3h0dWV2TEk1VGM5a05VTk1XMGgraHpKcTVpcFZPQnNxdFJh?=
 =?utf-8?B?TTRZeE1uczVHZHA0NzBxbXJRcmVlM1MxdG1YQnFJUzlSM1dZQ2s1RTBMRmp5?=
 =?utf-8?B?Z2ZRWVljUjhVdTA4Nm83SWkzUGpET3pTTWRPUVNKUUZDNE9zVWZLZHZTQWdG?=
 =?utf-8?B?VHJuWFZiMHBOajAyQWRVSGJteVQvTVloZUtaY2trcmI1WGQ2eVRudjBRNkZN?=
 =?utf-8?B?cDhUMHFJeExxWStxTjdvUmZ2alAyNVZQYkxOV3RQZ2p3QVRyamJSVjJETkFp?=
 =?utf-8?B?Vi9lS3ZBb0F0U2NPeldwKzFIbytRK3U4U3Y3K1JXZkk2SUpoVGNyYWcrbEhv?=
 =?utf-8?B?aGxLMEtwQ2hZTDVZbzB5K0xLeUwwS2d3MVpLeURvTnQ5ZnVmUXc5T0NHTnBh?=
 =?utf-8?B?cE4vRFNrK2ZLZlZqTUJ3ZTdwUVNnaDZ1Q2dXVnFUWXRJQ25MWDdHOFVmWUNh?=
 =?utf-8?B?cWhyeWtib3hVZDQ2KzFOcDRjQTNoK0sxcHVsbzdkaGxNWmhhMWhyMVlEK0Ns?=
 =?utf-8?B?ejJJM2lMNkYzNW1ESy9TcUpXbVhsV2RrUTJPSDRqRFBZamxYRmYvVkdFWTI0?=
 =?utf-8?B?RjB6NG9kc3ZuYUVRTmNuQ0JCeXZRWU9xUXJBMWowcWxheHVqNnJPdXduUmFN?=
 =?utf-8?B?eUdTNnhDMTUydi9CQ1Nram41M2VzTUxQNjdlVW9JWFRWNTZ5RFhhNmJ5MjBn?=
 =?utf-8?B?MnNJMkZMZDB1K3lLci94bkVNaS9menRNRjZvQWNQUnhhRlc5NDNNZ0o3YzM2?=
 =?utf-8?B?RnF4RE93NWhrdThvZnVySG9Ec0hQVE1jTHlZSkdnRVlBdG1qZWhZN2l2TWRP?=
 =?utf-8?B?ajdUSkZXUlZxL3ZVSHJBUmJyampOY0ROcmpoUkxzbUwzTkoxc2EyRHZCTnRP?=
 =?utf-8?B?QlB0ekFXb3hReHNBWWc4dW9JZXBld0hoQlBtQ3BzQUkvSVFlY1VZWlRGaFJk?=
 =?utf-8?B?WkFleEJLWWRzdVhvdTRudWR0Z1dDVUtTVzF5Q0Y3cjlPZURrOVlrZ3R4RmFT?=
 =?utf-8?B?dzFoNTdQekY0ZTRiRWJ5TVphL0M4U1ovTVNtYzZFdTJSUW1nOFpqVmlodnA5?=
 =?utf-8?B?T3VMU1NMNUp2TmwwVnVVYVJRdkNJK1dKMnVyNHlRb3JUeTFhMm9BbmdDQ0xv?=
 =?utf-8?B?VnYyN3l2Y0sxa3BmK0t0WkJ5N3VZcGdyTkNpVVEyeHg0Y2xQaUdJTWFIR2dj?=
 =?utf-8?B?VlpIUjFVMklCTjNJVjVSVmRERkJJZVF0K09JRUNXdnRLa0taQXp1VHlWdzdZ?=
 =?utf-8?B?WGs1MytXRm5WU1JQWHI3dEFrNk85WDRoMFF6Rjl5alJNSkFrZzl3bnVyUytn?=
 =?utf-8?B?VlQ5b0ZXMnJvZE1VRGRCemVqaWlpNVI3a0lwUERwRFpSWHA2YkZRcjJTaFpU?=
 =?utf-8?Q?jYlQg1cIFIWRvQ9U3176FkWHyLeUJSB8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR01MB9193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRiQktVRVNLb2dZcEdDMlhCcDJPMk9rMzFhS3BnZjVRTzR0cmhTVHFxZUx1?=
 =?utf-8?B?cnI5dkNBWXpLN0g0LzVMOXhFd2RCM0NpN29lZ3NlZVRsc0tGKzY5MjBXU2Ju?=
 =?utf-8?B?VXBOZzllc3pJQldaRG1hOWEvZGMzUWdyeFl6VzRvaTFEK3NyZDRyTDV1Q2Vo?=
 =?utf-8?B?UkpiQ3o1Slc5UHpxQnJUMmxiSDdTZ2puRTNrd1JRR25qWkp6dU5kSkRyNEdY?=
 =?utf-8?B?NXdSUlhYbVlSUzJqK3U4bDAzU3BVL01idXNZZmtkS0NMUGZFQWxkQ2J3cDFZ?=
 =?utf-8?B?TGVScnpTeFJ4ejNURWNVandidXVUc0taODlDdEp6WUR0d2dZKzFva3FNWUNr?=
 =?utf-8?B?VGphUTFVR0VLeVZYUVluWjQwSTdoUEJvditibHRZelBMQmttQ3RnUVZjSE9I?=
 =?utf-8?B?S1NVRkViMlIyY1VoV1dkSW1UUURQZHpyZElzdUVGTlFMTFlHaVZMOFhObDFI?=
 =?utf-8?B?YXN6SzVFVE1FWEd1YkNUcWxpSXkveUp2RnZBb0VzYTc1ZFNha0wvajBFN01i?=
 =?utf-8?B?dW1Pbk5hKzZMeG4rU3Mvc0x3R3h0eXZDK0VrUUZCVTRQNzY5c080R085aW56?=
 =?utf-8?B?OVF1RnNWbHgwRmRmQitkQURwV2RGYnBiaDlHbXREMTVPVTZhL2JuZnBkRVBq?=
 =?utf-8?B?UXJudFQ5bTArblB0MWZHTGhCL052anVjcUZxbmJNUmJ6dHVtckhLTTREMlJD?=
 =?utf-8?B?TjlOL2Qya0JUK2Q3amVjc09vdWxmd0xiV1hWOHlieFhkQkx4TkpYQlpSUktJ?=
 =?utf-8?B?dXBzcEtUaTQzTDhLYUdsQUw4SkZJamNHMlFUYlZtdlp6bFVEM0U4anVLN3BZ?=
 =?utf-8?B?aGMvVjQ2WGlhTFpSN2doK0JiaVJsUnIxMldhNnJTdHZpZi9KbXQxRXBMc3lT?=
 =?utf-8?B?dGlaSTQyNk5lNnptQUZoNG9VdkRqY2JLSnNNRnBZQ2tCbXRUek5VTTRzMVp3?=
 =?utf-8?B?MmJ4ZUJZNVhUaDJkY1FKUDdlTXlCYmwwTkRDdURjSHRnZzlRSDBqY242NzdP?=
 =?utf-8?B?MmpQL2tzeld6ZGVwZk5vd09IM2lQakMrSy9XeGxVMmpHOG5zUEpJVVhZOXlV?=
 =?utf-8?B?L0taUDVBbElDOHVOdWp4NFR5QXltby9mTGdWNEcyMndoMzA4RkozdS9MRC9r?=
 =?utf-8?B?b0hWUTkxNmQxNjlEcGVBUjFaQkhJN0RhNVhId2p0NEFGVG1qdFVpd3hEQU9n?=
 =?utf-8?B?RHduZmpxcDhhQSt3ekJKdnk0ZjlVMjhOenVyMzYzUmRodFYzdTA1dlRlV3Yy?=
 =?utf-8?B?U2E4WTJBVmZUdFVJYVd1QUxvZGZkVzBvYUFZZTFHb29CalNvbkdmcFc3TTRC?=
 =?utf-8?B?bkZkT2d4UU1sbWt1ZFlHOEk1SjhodkpNcnFvS2NJUlNiTFdmclFVWG9BaUpN?=
 =?utf-8?B?VWlKSHNRcjZQWHg4R09teDRxWk1rbzUrb0cvcG81UHhweUNqM2lvTXI3a3Zk?=
 =?utf-8?B?Sm1va1NNNjNDVjNEazJ4WnQwcFhHbXoyWndGbXBwUmVrYUFuTUdRamlNcWYx?=
 =?utf-8?B?QjN4dVc5Y0JDQUk5Y2FrS1g5ZzBwNzhwQTE5T2JVVnNVUWcreUpBMkgwa1Fi?=
 =?utf-8?B?QU05MFB4ODlQTEk0RS9qeFRHSGRIeGFFSTJxRE9EdTFBTkFRMjlsK2V3TnlU?=
 =?utf-8?B?TVZxRTBxSEZZOUs4ZmJRL2FoMzZIVkdmV0tpSHhQTkpWNnlXYXQzSTRHMndV?=
 =?utf-8?B?Q25nYmFrUGd6QkpjUVVhblV6M2NSOE9GNGNDZ2VMY1VpQ05TRnI1azRFc1dI?=
 =?utf-8?B?bWFnamU1aFE5ck9Fd09JTW05UG1HY0hkTUI3N21PVER2UUVoZFB6aXl3SlNz?=
 =?utf-8?B?Yk52dm93NkhndEFsalh3dndid29IUHpCNHRGd2dRKzRVcVFOZS9UNnNOTXJC?=
 =?utf-8?B?alByK1ZubCtwc1BVNEFEK2JXMGl1c3FiSWtWekxlVkliaFQvcDJNbXBRKzJF?=
 =?utf-8?B?cExIV0liSGFjcTdiV0FzZmdIOXNxcWdiWURuYnlmR1ZaVnBMeFphcitHeGZp?=
 =?utf-8?B?TUMrektZOFo1YVc1SXZUdnR5QVd3R3djbUxBV0dIRzhQV05NeTd0QXlYb2NT?=
 =?utf-8?B?ZHlZWHlsZmdPRG9BZVp6dFZvQ0w5cGVZOGltOGo2MHNGOWdCVmk5RW52cDdB?=
 =?utf-8?Q?ZlJ8FUJzsy1pUac5byBN3gPqZ?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a8a112-37ef-4da9-890b-08de059f6e05
X-MS-Exchange-CrossTenant-AuthSource: CY3PR01MB9193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:45:44.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AftNCUMN42oph+KZ4cAzbv7JJ0iAXbcx1GpDr1iWrPuMtsgSOOyb0txUTlaO3wb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6269

On 10/6/2025 2:45 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> <rtm@csail.mit.edu> reported some memory overwrites that can be
> triggered by NFS client input. I was able to observe overwrites
> by enabling KASAN and running his reproducer [1].
> 
> NFSD caches COMPOUNDs containing only a single SEQUENCE operation
> whether the client requests it to or not, in order to work around a
> deficiency in the NFSv4.1 protocol. However, the predicate that
> identifies solo SEQUENCE operations was incorrect.

I'm not sure why a SEQUENCE should be ever be cached, apart from
recognizing it as one of the operations in a prior request. The
idea from a protocol perspective is that the sequence is just a
ind of clock that ticks once per time it's executed, and it only
ticks when the sender sends something new.

IOW from a responder (server) perspective, caching it seems wrong.
Can you elaborate on your interpretation of RFC8881?

Tom.

> (Based on my reading of RFC 8881, I'm not sure NFSD should cache
> solo SEQUENCE operations that fail, but that is perhaps for a
> different day).
> 
> Chuck Lever (2):
>    NFSD: Do not cache failed SEQUENCE operations
>    NFSD: Skip close replay processing if XDR encoding fails
> 
>   fs/nfsd/nfs4xdr.c | 3 +--
>   fs/nfsd/xdr4.h    | 3 ++-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 


