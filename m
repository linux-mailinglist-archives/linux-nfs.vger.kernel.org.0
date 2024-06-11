Return-Path: <linux-nfs+bounces-3647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89070903D6D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 15:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CA3288DBE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1717D344;
	Tue, 11 Jun 2024 13:32:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD417D341
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112756; cv=fail; b=NxEnhiLvAiCHLjuTogiRfJNZdo+/3kwbhRjno/o+9o/eH8Nea7/Aad8fAehOeqZOGD7hCEOpQlFGD8qWe0rGPZkuT4UmP6UZyZ24iXdiIDO8lfuE7JqFIsIsUQmtIsVmfShfkAQFanWWO0wtAGNuuUWL8VH/G/o0T4+94KI3E54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112756; c=relaxed/simple;
	bh=XKukmBjw1Y2MoSwxsT7f9sscfZeYqCLD2Qgj7Ryef6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ch8TT5P5N/YvHVh6Fq1f5NQIstYZQVWYjsL3aXz4Hm6t725P0lQqz0SMedXBPsGgu6runsDF27ojII7sJdLF6jlNSEFwuzlvbmn+8itH4lIMLNvseIZts89qdxPbkS6ZFdReJYQNish9XNA2n+yjfVcve2RjH8waRSMnAe58yvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.94.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1pwkuufkwWqL3zudKCQzk2ZgPSCs4PknmCGgiu87RweGcFLXzbfvrREBoKmIWQv6ZJTJaVo3ofsGz0ZLKHQ3cQSu5Jio2TTb0keks5FLXi/fjylQvoyY86+VGhh3URajeD7Tof/0vZ8RW2XYmDsJ0bVYePtQhVrYN8RomfwQp0Pad/+SkrH+IKeKkQW1C2ueqjMBwvmFOdI9BeiQhc4PDKwMw8yid2y1s8+lZbwh08h/ZdKixYJf278eb1pHqk8Q8oKQA2PQUxkkF+8+uH0cxxdmhq7TeDKjXzeuMaA72YaYJPTOYasIfaxDDIGiP2Q+XC2hGPqA1jRYZy0ZdNYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzK5lBVc+NtjP9i8HAxQUMt5Z5Lzx+l56D5fBIj9fSg=;
 b=BFgAyPdbLqtkn75GM8ZLVDKK1Vs+38yuLtRTn6QGN27/yOGTijp2ccdenOSc5nyhbTMdogcJOy2CJnvYH4mCpJqkeuujsphC99foMURgzblZtAnRSLf2ozk3cuw46nmV2Pjmev/9sMyUgu6ntBH1ue+ACrc9pelQCm/OQsMaBXc5DV41cvjq3Bw6KOvS9KbTEPR0uJRGlaw8PnZgeXve912fuY4M9lwpPmphHO3SMC7RTj2YIS4gBpUU9w6OrlOPPFcui8mNJGRWaqltRf7JpBKoIxFLRa4pnPkKG7dXF+nzzJad5usxvRxMDY7W9kgQfToF7GYep/MLObm0a9eNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 PH7PR01MB7999.prod.exchangelabs.com (2603:10b6:510:277::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Tue, 11 Jun 2024 13:32:30 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 13:32:30 +0000
Message-ID: <8b882658-da3f-47ba-abd0-08656153fddd@talpey.com>
Date: Tue, 11 Jun 2024 09:32:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
To: Trond Myklebust <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>, "cel@kernel.org" <cel@kernel.org>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "neilb@suse.de" <neilb@suse.de>, "dai.ngo@oracle.com" <dai.ngo@oracle.com>
References: <20240610150448.2377-2-cel@kernel.org>
 <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
 <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
 <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|PH7PR01MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 453c64cc-a18d-4775-0c6e-08dc8a1af0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUJyQmpQWjU0MEE4Qng3YXRPQnhHNjlIckpyL0xOcndwaU9iL0xPeVg5L245?=
 =?utf-8?B?UURDU2tDQk1ndS9VMTROQ1M5TkR3K0ZkTU1WSmt1TWdiRGV0S1hNNGNpNlBL?=
 =?utf-8?B?MFZIUGtzRWo2QkoxYWRBNmJwSlA4bXgydE9QSkdjRTAwV1piMzlFc09jK0ha?=
 =?utf-8?B?NkxQdTdGY1YxeEtOVy9sV3VMVHZXSU9wRVlmU1RpOFNxWUN6ZVRhNXplVnJj?=
 =?utf-8?B?eUhQYXYvN0ErM25pcVN3bzB0RENtZ050UE1UcmFCSGdEc0diME96K1NTZVpE?=
 =?utf-8?B?QVdPOVQxZHNZOFFkK3pqMDB2SmY4aUlFQkJOQlBkMHBaaGxVbGtaWTNNL0dT?=
 =?utf-8?B?dHFRT09tTHJzdkhLVTg3ZlFCVHp1amxQU1JCVWx2WFVkK3B0amYxaS9zZ3Vu?=
 =?utf-8?B?bmZDWTJzaGw3NE94U1YwZlRJa3U1TlZjM1N0V25YVzhHMnJHclNXWm9BWHky?=
 =?utf-8?B?ZFZUZHFJTFVVTjRWdzEwbTRyQllySDhJQXZVTzAvR3VTbS9ZVklnYjl6YlBX?=
 =?utf-8?B?SG5hNG1tTmJBcWg2TEwzRWwya2I3Njd4M1BhSFo5by8zVUV4UmdhVmIybGJn?=
 =?utf-8?B?M3JaOXZDa05taFRZQlJQNXFxM0lBcG5UNmQ1a2dTUkFFWkhscmpxalAvbU9x?=
 =?utf-8?B?UVg5a1EvOXpTeHpYdGJ4QVlKUEVOVUZtSmNZbE9KK1hXdzlrVWNvZExuYTl5?=
 =?utf-8?B?aStVb2tpc0lkc1Vaejd3ZFlrWDhnVld1YkcxaCtCUU11b05kYzVDc1ZpY3Vv?=
 =?utf-8?B?Y09kcG1KUk1RVHBCUlJPQ0x2VUtlWjIwanNOZ29laFBHMHE0Q3ZZU0ZxWHNQ?=
 =?utf-8?B?dnFsRnlUQ2c3ZEJjNE9NeXd6NmRqZUo5UFZZdDJieE5SRTBzbEprejJ1ZDVj?=
 =?utf-8?B?dkQ3SzZjTzN6NXBKUkpNQ3pYN2I3SStYT1lzWU9hNjFjaVRnSFY0dU1MbWZ1?=
 =?utf-8?B?YVJKRW5pM1R3R1FDWTRJWUVtdjNBaGpDTTZ5Q20vVXZLaUpVVFMvTEovZ3VI?=
 =?utf-8?B?bEJuSEZkZklrbmJUekE5ak9xckRtcWgvTFRyUWNyMFFNcmNHL3BSMklmS3BM?=
 =?utf-8?B?NGFPby9sOCs2VXgyY0FVaE5uZkw3M0J6aTkyU1NBQmVZM0daYXd1MFJheHI3?=
 =?utf-8?B?MWpnYnA3Y2VuOTBzWjJIb082MUdickFGRTF3K3gwSUljZ2ZiL1RvOThSOGJE?=
 =?utf-8?B?Rm01YnBjZmJ3VUpwYWJTU3lSSDJlZGJQUmFoSjlLYlB1aXcwUUhqMkVhcFFY?=
 =?utf-8?B?cmFrdVVocFJJZkdnQjA3cHl5OGNCU0JuNmY5VFp3NDAzL0JKcktVMDZBVFJW?=
 =?utf-8?B?R25rZGFEengxUisrYmsvd0VoY1VMVFNldVYrSWwrZjEzd1UvRm1HUk5hemUy?=
 =?utf-8?B?VHRZSWg2R2Q1WE50TUJBN21Sc0JySWNGMU9teitDZnJCOUdaV0Q4cjFOUTBi?=
 =?utf-8?B?QmV2WGxpUStQalF5VUZrdDlRQXc1SVU0UVdXNFp6VERMdXZJcEM0SnBNdi9O?=
 =?utf-8?B?bXByd0lVNEhraUlpd0hjZXRzTERjM3dGKy91Sk1tR1VkZ0c2OXhLWVZhaEQw?=
 =?utf-8?B?aUdWNlhtaVpHcEFmR21JNDNOWGRpQXhxcDM4TWx0Vm92aWlhajRHcGJwVkND?=
 =?utf-8?B?dVUwSHM0ZmcxUWdoelZOeWdlVmZnZVI4WnVidjVDaDIxUWtBbWhzejUycnhu?=
 =?utf-8?B?Ly9SV0FLRnYzM2JhQ2J4eks3SHJOTVBFdGQwdTdEUEN6b2lHcEZHMDg3ek1B?=
 =?utf-8?Q?wVpO8D9L9T3ouuYttbL8wYrTkAsIP/vuezX+jK1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZZbGt1ODgrV0ZWREpFQ0d1YXhsbHJoRlVmdDUwTFlySWR3SWxjZG05UVlH?=
 =?utf-8?B?RmRiNzlDMUlSU2lLSklTKzhzWTZtUDV1MVlIc0VJYTVXeDlMSGg1ZVQySmRl?=
 =?utf-8?B?Q1BhZjA1aUdLTnpjSCtkRld4VjZNdmxUUjIyenlCRUFKSjFjOUp6cElwa3Zm?=
 =?utf-8?B?R2d5SGl0a1JGejNucXduRDRzL1lZdmtvZTVvZDBqbG5mWTNpUGNoZjRSWjJV?=
 =?utf-8?B?RFRDNUZYc01BSGRYc3NYTklrMEwrQldKQ2prcTZuRWUyUzczMEdQQkJhekdy?=
 =?utf-8?B?SUo4YW9hV0VuaEEvd2N2TWs2UjNsOWF6Z0VLT2Z1ZHFRN2RSY1VTckNPWjJa?=
 =?utf-8?B?dC9qdGxNbEpQNlhMYjBvekdsWXVjNU02TmgxclJ2RkFnNkd5aEtHV2NUb3pZ?=
 =?utf-8?B?SC9xSlpmbXlFeWFzMURXYXlhUHg1bTJSamVDK21ZR2NLOEpwUFJlT3ZsQTZT?=
 =?utf-8?B?c2dabnRQekFGVHA3SjlSUUJ0NGdTc0lnY1JxZHpieUszT2hHZmovcFJESlIr?=
 =?utf-8?B?K2RKTjk0dUJ6VTlqeVNURGY2Q1BRdnZXeE1MTTVocWFjMURpb01GYUR4L1dU?=
 =?utf-8?B?U3NPNVc2NmpjR3JXNXhCNDgwOU5oVjR1SmMwSkFwWm50SEpONEZzN0JEaUFS?=
 =?utf-8?B?dWcwaE9Sa3hvNXdESi96bUVsa0dhSTVXZ2xUY3RZWlMvZDNmQkd6NStBU2dq?=
 =?utf-8?B?SktQaTYzYUVqSVB0NFEvVmZNMENNaXRvVGw0NTRzeHg4NFFNNEowKytiWktw?=
 =?utf-8?B?R01NK3NMb21WQW1GbThKRnBpOEF1MjdPQ2YzQU44NXFBWlRvQ2k1ZEdlNTY2?=
 =?utf-8?B?TjV0ZUVlc0Uyd2Q0SURoWERFMjBPS0pCL243RFlOYjJOaE0yYmlNWWdwT3hB?=
 =?utf-8?B?SFdtcnltellXYmsxUndMTGpVZ1htZlV3YTFkd0VJWGNlOHdkdnlyZTVScTJY?=
 =?utf-8?B?RVRzbVZ5VkZzd3ZvZFh0Q1J1R1NtZ2VwcXNYSUlTKzRJbENSM2hQRldUcjZq?=
 =?utf-8?B?ME9Vb2RjdGRkTEp1Nmp4ek9iZ0Zvc3JYL1N3cFBWM25uR1RaZTJaa0NnWWtv?=
 =?utf-8?B?MksyUEhnQjBvbnhvTGJUNEdtdlE5Q2daRWhHZFBJOW02MlV2QThyU2NWSHVS?=
 =?utf-8?B?d1oyYnZRZFc2bktQOWRQb1BrL1FGelc3YlBCbmJJWUlCbGYvUGxkbTFKWEZX?=
 =?utf-8?B?TVJLdXdzcTZTVko3NmdZSUluSXNhRS9rT0wwbDJjZjZCT0JwcEUxdkJVN2ox?=
 =?utf-8?B?UGZEWG5SM21qVE5yWFd5aUdhWWM1c3d4Nnk3M2gyRjZpeWpEbHJuWkkwaHpk?=
 =?utf-8?B?WE5ydGgrcE1IaDNoS2JScWtVZ3preE5mS2xzRXB1ZE1FaG5tSitzcURxS25S?=
 =?utf-8?B?ZFNYWmViRnFLdUZvNnhiVlRxU3VSQ2xUV1hLQ205RXliT0dqd1dpeWYxOE9h?=
 =?utf-8?B?LzJWclRyeUlzdWF2aTR0QUI3ZTd0MEk4WmFCK0Q2VXR3TzRVUzlNdWtORFlk?=
 =?utf-8?B?dVpYWVp1K01WWHJmNjFtMG1HOWtpWCtISDJPVXJ6MndLRFRoZ2pwY1hIbDN2?=
 =?utf-8?B?Vi84bnVYVy9KVGdmZWVMaVkrenpJMGdFRnQ1QjBuODhTdlI1Z3JvUi9YUTlk?=
 =?utf-8?B?YXBiWHJTckQyMVRUMzVxSElxNGZKcXN4UENSTVBKSm1pV1l1b1FLT20yQVB5?=
 =?utf-8?B?b0h3REhXYmljT0hQU0hvbkpUbVlGbEZBYzhSN1p2L2RkOEhCMzVTUXR5WkZr?=
 =?utf-8?B?UkNGbFk5WE1SdVZ3T0RrakpIZ2h5RGMrb3NQV01HMFRrbjVvQklSOFVFeENX?=
 =?utf-8?B?cGk2bmI3ZkYwanBUbHVGY1ZJajJtUWJ4ODFvS2poQXh1MGpQa1VhVnV3MExS?=
 =?utf-8?B?K201Qjd6KytBeTh0bTY1WUs5OE44aElOa1hkQXlUK0pwUkMxUzBnamFjL3R6?=
 =?utf-8?B?b3MzZFZzYmk5eHM2STFveTdwdTQrSlRodjRsNFVUMytlRThpUUFSRlFuVWNM?=
 =?utf-8?B?VU5LUUYwMTg0dXhhZXoyQUIyMGVWR0xOWUhFbURWSXZWRWUyVE9tMW56OGZa?=
 =?utf-8?B?dEdBWi80aHI4WFdwZzhUSExZWTV1dWhQZDZ6emNObUNFTDh6d3JZeW9kc0xV?=
 =?utf-8?Q?Xim9L/TDktheF9V3NEwLIdMu+?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c64cc-a18d-4775-0c6e-08dc8a1af0fc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:32:29.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EI2vtlDYHD5nnMmPMleTz1Gsyr54XrCxRzeuEmRjhDT7UxYDVSBBAJo+d5AeJWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7999

On 6/10/2024 7:54 PM, Trond Myklebust wrote:
> On Mon, 2024-06-10 at 13:43 -0400, Chuck Lever wrote:
>> On Mon, Jun 10, 2024 at 04:21:33PM +0000, Trond Myklebust wrote:
>>> On Mon, 2024-06-10 at 11:04 -0400, cel@kernel.org wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
>>>> unexpectedly. The NFS client had created a file with mode 0444,
>>>> and
>>>> the server had returned a write delegation on the OPEN(CREATE).
>>>> The
>>>> client was requesting a RW layout using the write delegation
>>>> stateid
>>>> so that it could flush file modifications.
>>>>
>>>> This client behavior was permitted for NFSv4.1 without pNFS, so I
>>>> began looking at NFSD's implementation of LAYOUTGET.
>>>>
>>>> The failure was because fh_verify() was doing a permission check
>>>> as
>>>> part of verifying the FH. It uses the loga_iomode value to
>>>> specify
>>>> the @accmode argument. fh_verify(MAY_WRITE) on a file whose mode
>>>> is
>>>> 0444 fails with -EACCES.
>>>>
>>>> RFC 8881 Section 18.43.3 states:
>>>>> The use of the loga_iomode field depends upon the layout type,
>>>>> but
>>>>> should reflect the client's data access intent.
>>>>
>>>> Further discussion of iomode values focuses on how the server is
>>>> permitted to change returned the iomode when coalescing layouts.
>>>> It says nothing about mandating the denial of LAYOUTGET requests
>>>> due to file permission settings.
>>>>
>>>> Appropriate permission checking is done when the client acquires
>>>> the
>>>> stateid used in the LAYOUTGET operation, so remove the permission
>>>> check from LAYOUTGET and LAYOUTCOMMIT, and rely on layout stateid
>>>> checking instead.
>>>
>>> Hmm... I'm not seeing any checking or enforcement of the
>>> EXCHGID4_FLAG_BIND_PRINC_STATEID flag in knfsd.
>>
>> I appreciate your review!
>>
>> I see that BIND_PRINC_STATEID is not set by NFSD. RFC 8881 Section
>> 18.16.4 says:
>>> Note that if the client ID was not created with the
>>> EXCHGID4_FLAG_BIND_PRINC_STATEID capability set in the reply to
>>> EXCHANGE_ID, then the server MUST NOT impose any requirement that
>>> READs and WRITEs sent for an open file have the same credentials
>>> as the OPEN itself, and the server is REQUIRED to perform access
>>> checking on the READs and WRITEs themselves.
>>
>>
>> Trond:
>>> Doesn't that mean that
>>> READ and WRITE are required to check access permissions, as per
>>> RFC8881, section 13.9.2.3?
>>
>> Every NFSv4 READ and WRITE calls nfs4_preprocess_stateid_op(), and
>> nfs4_preprocess_stateid_op() calls nfsd_permission() (in
>> nfs4_check_file()). Seems like we're covered.
>>
>>
>> Trond:
>>> I'm not saying that the return of an ACCESS error is correct here,
>>> since the file was created using this credential, and so the caller
>>> should benefit from having owner privileges.
>>
>> The alternative is to preserve the accmode logic but instead add the
>> NFSD_MAY_OWNER_OVERRIDE flag, me thinks, which is not objectionable.
>>
>>
>> Trond:
>>> However the issue is that knfsd should be either checking that the
>>> credential is correct w.r.t. the stateid (if
>>> EXCHGID4_FLAG_BIND_PRINC_STATEID is set and the stateid is not a
>>> special stateid) or that it is correct w.r.t. the file permissions
>>> (if
>>> EXCHGID4_FLAG_BIND_PRINC_STATEID is not set or the stateid is a
>>> special
>>> stateid).
>>
>> But LAYOUTGET is not a READ or WRITE. I don't see language that
>> requires stateid / credential checking for it, but it's always
>> possible I might have missed something.
>>
>> Also, RFC 5663 has nothing to say about BIND_PRINC_STATEID. Further,
>> I'm not sure how a SCSI READ or WRITE can check credentials as NFS
>> stateids are not presented to SCSI/iSCSI targets.
>>
>> Likewise, how would this impact a flexfile layout that targets
>> an NFSv3 DS?
>>
>> I think NFSD is checking stateids used for NFSv4 READ and WRITE as
>> needed, but help me understand how BIND_PRINC_STATEID is applicable
>> to pNFS block layouts...?
>>
>>
> 
> If you look at Section 15.2, then NFS4ERR_ACCESS is definitely listed
> as a valid error for LAYOUTGET (in fact, the very first in the list).
> 
> Furthermore, please see the following blanket statement in RFC8881,
> section 12.5.1.:
> 
>     "Layouts are provided to NFSv4.1 clients, and user access still
>     follows the rules of the protocol as if they did not exist."
> 
> While you can argue that the above language is not normative, because
> it doesn't use the official IETF "MUST" / "MUST NOT" /..., it clearly
> does declare an intention to ensure that pNFS not be allowed to weaken
> the protocol.
> 
> So my point would be that if LAYOUTGET is the only time where a proper
> credential check can occur, then it needs to happen there. Otherwise,
> your implementation is responsible for ensuring that it happens at some
> other time, in order to ensure that user access follows the rules of
> the protocol.

Absolutely agreed. The MDS needs to verify access before returning
the layout, for no other reason that the DS can't perform the same
verification.

Tom.

