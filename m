Return-Path: <linux-nfs+bounces-9474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0E9A19559
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D419E16271B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD62135C4;
	Wed, 22 Jan 2025 15:35:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002716BE3A;
	Wed, 22 Jan 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560142; cv=fail; b=O2MEvm25i9WW+0UL4QPCpsZE9T/hlm/pz4uwDBwGvUGm9PMXD/pRFFoEKutss3iCIaEiAO71yWOQ9F7IuqZR6wg6V41r8RdcY5W9lajhrnPd6+KXe9o37LF1dyyHacdauiSds6ZItzxTkvlHC6ZVs4yjuqenT+9CkIXyVGPSx4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560142; c=relaxed/simple;
	bh=DIOmd0IAUwB1oeJhl0w0UsBSujBSIdlZ+rFfhyxB4Yk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtJkA54LvhyVs7sp3It0G9lDKaPW3YDzBExuW4QmUGsGEo8U3q6oL0eio91SgB5/ZO+Qjv4AymKDRcYTz7HvF1V80XIkxN2TI3suw/wguwwZIYgKsMgOEHwS2FeZCX/uWPw3O1g8UkUqe/rogAOuQIU2xmh60w28Q0TxKrtguNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.93.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY7PjfYRhw1Z4ryYLeBCrxmapoXRgKPdtXu3GS7ZuZSDNoyzbDys2gHUIqzqb9NIWK9t/4rIv6vyBYSBiOk1PWZIP0NZI66suWZJEiHdWvzHqeAB5TK4DHZEJiie7n6WbcRe3MeMH1+AMbgsJUTBkKVj0xEdKi9damU6ucnBnulBLFs1ri0gB5oMlZypbON0u443nBVTBHChxPJ6e49PRlnMXqK1Mt2Dl/yVyP7E5zs8ALbVQgBGvfMccTZWV7Ao6ZFUDGNhxLdi0YE1FklQisl/mo0YQ+8Fwo4PPk1Im3tETG+w4GucfCJK8zNKuUbfR3rA4Nit575bEhFTYMILjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeUkSQHANOLqvk9g3Ufl0OWgPVsxiMDU546Vf42LcnM=;
 b=evKhRmtuU7RBaLSuTqpwudMt4XyF7O4TdFCm+Vs7HWEPQ0RnvBEyW2+B60+fhH+eGJE3ZasFF4W+AUIOkxm1dQttcaUo3OKK2Txy4RiB7IQvZj5odC4K8mK095WLcbAgLSlc9Ee9p2aBWEI8hfMzT2w9TaEjw/bz0IHUaVASf+NXsU9v2SwxpRvEjGT9DaoFeKBNuuq9G1akxuEyFENiQvSccA4fji91ggpy5LzhEHY7bxV8XrgYG089Mw0Xy3bW+1e1ChbMnfQ4bBfxNcZXLI7Qqm2kL/vyCqpvOon1EUR3vL1P2BvGFIRUHK2jWK346I1fL6Cfjhk9PW3cGiHqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 BL3PR01MB7116.prod.exchangelabs.com (2603:10b6:208:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Wed, 22 Jan 2025 15:35:34 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:35:34 +0000
Message-ID: <ec156ccf-9d6c-44be-bd1d-5f3e9b166e77@talpey.com>
Date: Wed, 22 Jan 2025 10:35:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: always handle RPC_SIGNALLED earlier in
 nfsd4_cb_sequence_done()
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
 <e85a0515-7972-4428-9270-a982073adcb4@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <e85a0515-7972-4428-9270-a982073adcb4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|BL3PR01MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 45207d4f-4e95-4a87-3b71-08dd3afa6985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkNQR1ZVRGg4WkUxaEszSzNGM0tuMzNhZjZOMWNXU1cyaGIxV3RBOHdRK0xz?=
 =?utf-8?B?WUR0a3J2cS83WVlVeU1oK01BSEFlZ2xBTjdjMHR0dUkxcjhhZnRaWHp2T2lh?=
 =?utf-8?B?R0lQTjFOZzNSYjV4aTd2U3J5bURZT2owNTd1SkdJOWhHVHR6blR2MEdFZ3JZ?=
 =?utf-8?B?UmxmMldHS3ZFWE1peXhGdlRtQUVoRnpPVnVtU3dLV0hBRmExUGZwOFhIUjd3?=
 =?utf-8?B?YzZ2MEY4WE5Jd1RBeXpRbEduS3ZjN29Dd01PaTBRTTc3VFBSR2tJcUs0WDl5?=
 =?utf-8?B?TndaWmRFc1RpZk9nQkpiSHlob1NEUzF0WGdKNHlxSWU5WnFoTUk0RTdpV2lU?=
 =?utf-8?B?T1VLTGtqL3NzZlVhcXEwWVJ5SmhHU0s2OFZJVllPQjBaaFpaSjZkQnhYWlJP?=
 =?utf-8?B?bTJMTmQybnd0bFJDb1lsTnZQdTVqK1pwbzA2RU9PSDc2VHhxa3dHK0wrenFt?=
 =?utf-8?B?bk5JUG41S1JoVkk0VVh0TWd1V3A4ZUtDR1NlbkRuYjhIdDVtZDlMZFMydXVp?=
 =?utf-8?B?d0FvWUxlNlRmREVRMlp6Zk5FUDFISlF6QWhWN3VSdjdmRUJMNTNKM0hZbUda?=
 =?utf-8?B?LzA2eFNGZ3RFdWg3TFZ3MGdJK3IwS09MaHBEakJ4Z0U4ZjNTem4vU1JRY3BG?=
 =?utf-8?B?KzZZTDFyZVpxQ1Q3cVlyZWhycjZQa2l3Si9rSkt1RGJEZWtjcHYrMjZrY1Vq?=
 =?utf-8?B?Qm1ZdkdjTWRhWEw3d0pVb1JrN1lWNlZ3MTVDdGhNeWtpdDR0WjFOWFd5bE4y?=
 =?utf-8?B?dFVsRllzODliV2ZRbStreXV5TlJmVSsrMk4yZlBCakNnMDlBWnhmcFliTDNU?=
 =?utf-8?B?bHlyQXR3WFkzYmVLNG1yVE1CaWRNYUwzc1ZnNWNhd2ViejJhQWlyTmdLa1JJ?=
 =?utf-8?B?cUxaMWhEd3N2bGVaSFlCSFRneklnczlQTXFMakFKbUdpVUk3L1RUd01rOC94?=
 =?utf-8?B?K0RKNDQxeExCenRlVVU5VHZkanEyQlZMWkRSTjFMQitRV0o2bG9GOE15cVBC?=
 =?utf-8?B?U0ZZOXFTWk5YZnFGOEQ5YzhPcDZWWjZFcTVFYnB2Y1l6NlRvL0YrOVFEVlg4?=
 =?utf-8?B?SmFsWnFzWDhwSjh1L09tTExsOFJubkFQRUNiaDBwdVB6ZW1rUEF3cXp0Ri8w?=
 =?utf-8?B?MkZnTGtWUnVjZkFubnI0MUpSN1pNZ1g5VXByTk5oSFl0UGhqd0dSV1ArT2lZ?=
 =?utf-8?B?eDYzUGNTY3l0YndiSjgxVGV0Q1MxY213UEkzVjJTT25ZaldrakJsdVE0bk8r?=
 =?utf-8?B?L25oMVBaM1QwS3Rsb2thQnp5Skl2NEk5TGlheGdSc09NQXY2d25aa2lRYXE5?=
 =?utf-8?B?cmo3cy9seU4yTk9pb3N0Vm9LTUZNVUNWUitWUVRzem1TWTZhZGZVbTJjV1Zs?=
 =?utf-8?B?enNBZUh3TThZd0llMkNOOXI5eEE1TzlaMlNSb2l2TXBxc2ZQSEVCSjl4ZjNo?=
 =?utf-8?B?NHllcXZGU1JKQklJTDZhbnQ2VXNIVll1OWwvYVBUQ3pQR1lsUGpjQ0RDa3oy?=
 =?utf-8?B?WklscHZ3OEtvNGdwQXl3TFBLM0g5Vk0xVDN5b1RHWDNxVFJjWW9aOG52WWNU?=
 =?utf-8?B?dyt3Tkd5YkowYmFOOGNFVnROdlJhM3k2eDdZQVVLZjJXM0pwV0c2VVJSUnph?=
 =?utf-8?B?Y3UzMHNLdGtkUExyOVJ6WlJIc2hRM1Bhc2RPa0tpcGZ0OER6THJ6MWR6RjVs?=
 =?utf-8?B?YzIzOFdZTHVLTkJ5clNaUlpnSmMzckI1MVRrNGRiTkNSamRFU2U3emI0NTZn?=
 =?utf-8?B?ck91R0ViVTUrSys5S1kzV2V1SGFKZWp5TVo1YnBYemZTVnh5M1pwc0RXeEZ5?=
 =?utf-8?B?L2VLZVN4SEY4aUpYL1hqcmJQbG9uY1RMMlBSMTdEMmZkZXZ0ekZrS0lvWG5r?=
 =?utf-8?Q?iIY5wxIoYCe2y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVg2aHY2VjFTazlsd3A5L1pONHFocFMvZTV0dGZpbmxiWnVCNm95RVp0RzBL?=
 =?utf-8?B?cTZMMytYZ3lON3JHMHF1TFNuUUxLWXpZOTB4eUFLUmlrUVV5R2ZlMWE3anRx?=
 =?utf-8?B?S2tubG93L0ZEMUNkdmRwd3I4Q0luRlcxM0FDc3o1SkR3QzgxRzRNQ3pCRm5P?=
 =?utf-8?B?Nm9YaGwzTzFNakhaaHNFbzBDazRVRTFNbHpqdkh5TDZaQXpCYklORGw1TWEx?=
 =?utf-8?B?UStiRWhNSDFOdG9aWkhYSWx2c2hISWN0VXNaRFRPRzdjTFNHTEFneXg1blRQ?=
 =?utf-8?B?YlkrNjVMU3N0MzUrSXhXV1d4U3dZSFRodkIzRFduWmlMbHhISnk0OG8zNmhy?=
 =?utf-8?B?dEJJYVlUdWdRSnpUcHlabnNuWnhDbUUwYzF0Z0VQSStQdVc0czM3WnhjOE43?=
 =?utf-8?B?WkNUNjNkeWxsUnhtaGxuWXN0ZWlpajlRaG9JQUxOOEJ2MEhPQ1JDYW02dS9Q?=
 =?utf-8?B?MnlYZUlXdzhzRC9kaEV0RUlyQ3Z3OWxlNTRNT2ZqYmRIMTJacWtnYXZMNzZL?=
 =?utf-8?B?R3R6cVpjdGxOY001Q3ZXRktOUFROSmpmbGYvTEszTFhHT2ZHaVY1bUx4UmR4?=
 =?utf-8?B?SWtEamgxWG4yYU12SE5FV3JGdjIrcVliNzVvY0JuYUtBYXduTC9VSVA1bE9o?=
 =?utf-8?B?bWhlZDJSTWlKOXR5eFNhaXJGcUcxRkw4TTdBSTcwYzFMb2czVkVyV25kbHdp?=
 =?utf-8?B?dGN5TE9EMC9MVjU0eEZrMk5COWNERDZGV2FjQlg0d0xEa1NvOHVuTVVMV3R1?=
 =?utf-8?B?K24vcmp0cnFWekwwNTJFUVdnNGVyRkdYZFZ5ZlRIUmUzT2x1VDJCTmRaQmJh?=
 =?utf-8?B?ODJmMVFnbmNWdTU5YlR4U0VlcEI2eWljVzg4eFdYWlduaW9mNmpIQXA5S09Q?=
 =?utf-8?B?TWNZenI5ZVp2VjZEdlowYng4d3U1ZVpYaUl5RnZPSDViRExjVHdwMERYVTJS?=
 =?utf-8?B?eUFJTmIyZVBhcGxjanRzTFBrNzJNcmpqZExTenBQaWt3RGpMYVpyZzlBNCtq?=
 =?utf-8?B?QlpOUjJyWFFGSU1OczZLS2phK1dINTAzYlZBS3JzWkJUSVNZNVVDbW4wa0xH?=
 =?utf-8?B?TVdYSnY0V2tKS05uVXZhenExQWU4T1ZzVDJWMUc0Q0xqa1p5eFhHcy9IQUJp?=
 =?utf-8?B?UnZlcjNrcDZ2aGhLUUt1Z1h2YitkOStUc2lSS1lKdXN2V2Nwdk5wNjc2angw?=
 =?utf-8?B?eWxDTFZ6WGhjZ2c1Rmh1RGZTWXB6dFJTS3YzZEJOSWxwaUZiMjUxMzBzdE8y?=
 =?utf-8?B?eXhIWWY2STJhZnN5UW51ZHJnUXdhczludURnbUgzWFZqWkxQMXZTZS9PZU1V?=
 =?utf-8?B?YTZVK1F6WHNoV01zS1I0N1BBZDJsVnFCeDBYaEFNUjhBcTJEenVmZW9kalRQ?=
 =?utf-8?B?S1UrekdtTEo0c1NwOWhiWWhJbmhMMlh1ODF1Vnl1cGJTTEhSTFlISkdUUUVF?=
 =?utf-8?B?eGplTjZYcWkrZkd2Y0NQNlVTcGNJQWFjdnY2TDg3RjBFY29UcTJ6ZjVxeEdC?=
 =?utf-8?B?cWMweTl0QTBNMUV4TDF4Zy9Kai9NZzNuNGJtTWFrbUdKQVRmT2gzazdDb2Nt?=
 =?utf-8?B?MnFMd2c4L2p0anVqL1JYUmFvanUrOXQ2dklMU1Nhc0hpRzYyRUd3dG5VRUIy?=
 =?utf-8?B?K0xiUzczRUJ2c1BFWFFXSWtQR2lwdUIrVGFVRHltTXZzUHRNcHVxeGNXM2Nw?=
 =?utf-8?B?STRpQUNOYnRFNDErNzRFcUVTRnVpVlA2bGs1SkZnY01tYmV6OUpJck95YVhB?=
 =?utf-8?B?U1Z3TW1ySy9taTduWlBxQ2ZGdW1qZnFpM0RnWDFuRlpmWk1OOW1tZUNiK2N4?=
 =?utf-8?B?MHJacWt4aFhHa294QmlSeUl6UTJDTnRvL3VPZTJ1N2t3b1dCVEw5azhzZEpR?=
 =?utf-8?B?Z29jOHRaVU84WkZxSVF3RVdiYjZMRHNKY1Z1MjZVa3JKc0hCU2RRWm51NzIw?=
 =?utf-8?B?V1F6V1ZjS0FiYm5HOGZwTjVLOUZTcG5FWSszSmJSZmZnTE1DWEVFclVwVHhF?=
 =?utf-8?B?OW1qUTV6Y1dqM1R5NUJUVG4vcmI5R1Z2OEtSbzdSaWhDM0dMaDEyTFR6MlhS?=
 =?utf-8?B?dUJ6RUlWV2t5Q0l3YlRSYXByMkhYZXV4Sy9uK29PQWh2ZGRPL0d3QTROVFYy?=
 =?utf-8?Q?96Ul8xK0F6ENIH7RJXYs/Cern?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45207d4f-4e95-4a87-3b71-08dd3afa6985
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:35:34.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1AoPgNrhyQ+UTtQV8fP0c3yHWeBSuPJKBhXXHUwAfxjGln4AIJkcy50Bh4am5Hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7116

On 1/22/2025 10:20 AM, Chuck Lever wrote:
> On 1/22/25 10:10 AM, Jeff Layton wrote:
>> The v4.0 client always restarts the callback when the connection is shut
>> down (which is indicated by RPC_SIGNALLED()). The RPC is then requeued
>> and the result eventually should complete (or be aborted).
>>
>> The v4.1 code instead processes the result and only later decides to
>> restart the call. Even more problematic is the fact that it releases the
>> slot beforehand. The restarted call may get a new slot, which would
>> could break DRC handling.
> 
> "break DRC handling" -- I'd like to understand this.
> 
> NFSD always sets cachethis to false in CB_SEQUENCE, so there is no DRC
> for these operations. The only thing the client saves is the slot
> sequence number IIUC.
> 
> Is retrying an uncached operation via a different slot a problem?

The server would ignore any in-progress status and therefore might
cause two requests to be processed in parallel. It might also
rearrange the order of replies. Other than those, maybe not!

I do think it's safest to not reallocate the slot in the 4.1 case.
The slot sequence number is only meaningful in the context of the
original slot.

Tom.

>> Change nfsd4_cb_sequence_done() such that RPC_SIGNALLED() is handled the
>> same way irrespective of the minorversion. Check it early, before
>> processing the CB_SEQUENCE result, and immediately restart the call.
> 
> It would be lovely to have some test cases that exercise the server's
> backchannel retry logic.
> 
> 
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/nfsd/nfs4callback.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 
>> 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..05afdf94c6478c7d698b059fa33dd9e7af49b91e 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -1334,21 +1334,24 @@ static bool nfsd4_cb_sequence_done(struct 
>> rpc_task *task, struct nfsd4_callback
>>       struct nfsd4_session *session = clp->cl_cb_session;
>>       bool ret = true;
>> -    if (!clp->cl_minorversion) {
>> -        /*
>> -         * If the backchannel connection was shut down while this
>> -         * task was queued, we need to resubmit it after setting up
>> -         * a new backchannel connection.
>> -         *
>> -         * Note that if we lost our callback connection permanently
>> -         * the submission code will error out, so we don't need to
>> -         * handle that case here.
>> -         */
>> -        if (RPC_SIGNALLED(task))
>> -            goto need_restart;
>> +    /*
>> +     * If the backchannel connection was shut down while this
>> +     * task was queued, resubmit it after setting up a new backchannel
>> +     * connection.
>> +     *
>> +     * If the backchannel connection is permanently lost, the submission
>> +     * code will error out, so there is no need to handle that case 
>> here.
>> +     *
>> +     * For the v4.1+ case, do this without releasing the slot or doing
>> +     * any further processing. It's possible that the restarted call 
>> will
>> +     * be a retransmission of an earlier call to the server and that 
>> will
>> +     * help ensure that the DRC works correctly.
>> +     */
>> +    if (RPC_SIGNALLED(task))
>> +        goto need_restart;
>> +    if (!clp->cl_minorversion)
>>           return true;
>> -    }
>>       if (cb->cb_held_slot < 0)
>>           goto need_restart;
>> @@ -1403,9 +1406,6 @@ static bool nfsd4_cb_sequence_done(struct 
>> rpc_task *task, struct nfsd4_callback
>>       }
>>       trace_nfsd_cb_free_slot(task, cb);
>>       nfsd41_cb_release_slot(cb);
>> -
>> -    if (RPC_SIGNALLED(task))
>> -        goto need_restart;
>>   out:
>>       return ret;
>>   retry_nowait:
>>
>> ---
>> base-commit: a8acd0de47f22619d62d548b86bcfc9a4de2b2c6
>> change-id: 20250122-nfsd-6-14-77c1ad5d9f01
>>
>> Best regards,
> 
> 


