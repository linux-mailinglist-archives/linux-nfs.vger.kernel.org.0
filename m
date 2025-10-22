Return-Path: <linux-nfs+bounces-15529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30028BFDD19
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 20:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5D3A89B4
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAD2D47E1;
	Wed, 22 Oct 2025 18:25:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020093.outbound.protection.outlook.com [52.101.61.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01932C3745
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157553; cv=fail; b=c8cJria8And+1ojzLauv3OX7PkSO/ocyZhh+ZPlpb7Ev5P80d2FHIh4F3d0rQSTmGSwqDhsQBIT7v3vOUQwegw7MuWJS7DcVV4QjBne/SLi6+PHM29I1mocnJkpwNJ41kQBTF98VBV5C+ZTPBPSYssgutU8RN4Xk/2zbFEXFacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157553; c=relaxed/simple;
	bh=emmXqHCar2EFyHnp/84ZHCV++rZLZxP405QenASB/Tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMatL3OUtSghkPMCivtede/WDbEzEMZ1WutksRbf4OISWgyeB2iZzQkJoSM2dnnwqdV/hev51G4GnU6+m7lhEMOqXCYp5xLeQLy7Hui1WHX7YoPoPmwg9oOCvhTfvaZTCflhD50thCQCrVQb7KZaKsO2tcscm45a5hcUxOS1odE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.61.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0zpsZqyBnbXVLTDNdPb18r0MvHaLv43jLQ2MYRnG1mK0YnYoM+Ovm/a9IUB0wAAzn5xqIB7KD9YvShezTAI8v2L5uhYQy4s+MYR/HIS9xZ5hcO5FlM4yoCGyjB7VtaSwmyCGg0WF2pN/Vtd4yu+rLxz5jbNpZP653L8BhCC3fI5qE0U4CeEElgCmrBDkO8fJQaawwpShUTXdXLaAoDvKGnCEKmAdqf2ZurOHkRrHz/T9m+gltAFB383hl7j733c/MEMlx1pA7fdNAu/qQ8r1a5ipyDWgsT5zmGqhS8RGN4DTYH+3G8TaN8ArNr2BS/M4bnfV6mm/Ytx9ivTSzLRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzju2VrYg0mJZJkK4hoju15JMdfUdY+OE9ofLMj2iWE=;
 b=BWMtVxvrgB+5h4aN7lVD5rA4kFY2jNG1JrW37ymI5W+T1Xg9DPD2qqVfFZAv90dl8jATIGq1qrIgpEFOvI1HIKTXArt/vajvNgCQktj2tpY/un38n3Vs5N4FoCaQ8EFEdgs03sTZ9RnUlm0XiUuH3enxYIT64neSbFO0jb8pt8pZQkllS0z6wOSgjTAh45GNdPlA7VlzpMVbiR1MkO2cm5xbQ5irRXsHLXrk3HhLnvzH6canjEk3YSqkxO/NlkDcNaxA8PQ3WHFRlvym0s/mMhD537OiF01I0AckHWzHxq2bu6TQaajKzTv4LoTnbcGqfFI9o72nuCnikiWwxmfY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CY3PR01MB9193.prod.exchangelabs.com (2603:10b6:930:109::5) by
 CO1PR01MB6616.prod.exchangelabs.com (2603:10b6:303:da::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Wed, 22 Oct 2025 18:25:48 +0000
Received: from CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5c00:ecc1:1c8c:15cc]) by CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5c00:ecc1:1c8c:15cc%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 18:25:48 +0000
Message-ID: <2d204966-abd4-4aa2-90ed-ffd69f059384@talpey.com>
Date: Wed, 22 Oct 2025 14:25:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251022162237.26727-1-cel@kernel.org>
 <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
 <aPkYedLyruWyCO0o@kernel.org>
From: Tom Talpey <tom@talpey.com>
Content-Language: en-US
In-Reply-To: <aPkYedLyruWyCO0o@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00016414.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:c) To CY3PR01MB9193.prod.exchangelabs.com
 (2603:10b6:930:109::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR01MB9193:EE_|CO1PR01MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0d40c5-7dc1-45f9-1140-08de11986bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjIzVnRpQVd5dUdqRXZsdGNKUXc2OHhXUjEzTXZTeEJSM0JFVTBFUUNmUEJH?=
 =?utf-8?B?RDBaSmpuVXZZd1hob3A1eWlqczJCNU8rN1pucXFEdTliOGpQTnNab0Q1SFFM?=
 =?utf-8?B?SWxQMkEzRkNKQTdudFMxeTZMTW5KcWtzZGxpRm5POVZveTlEWndCWXdsUkFo?=
 =?utf-8?B?RnNHMmQ4VXQwZk1hc0k0WUovNHZQeXpLbllXakNmZTNONGorMVZQdTNWaEs2?=
 =?utf-8?B?ZTZuN2FGNzRWbWZQY0xpYVJIK2ZvdE5tdXJ6aGswQnZUNE84Q3JieHc0akw3?=
 =?utf-8?B?cnc1YmNpbTNpdGhaSlBHTkZid1FiVFZIRkFLcEhzMjFhc3VjdkQ5ajdTQUZK?=
 =?utf-8?B?K3FuN1hULzlnR0lIMlJ2bFJHYmszc25Zc0h1SVBmd2xLYVFhVlpMcjkzNlNZ?=
 =?utf-8?B?c2JKWGthcURGNG44alhQNXpvMUxQK3dTQ0xmL1RVVVpVYUNwa2V1dUJkVXRR?=
 =?utf-8?B?NzNhN213eXVmN3VPS2tzaTcxQUNveUJtTndJK0t4M2FFZEpxaWVVbkNGYzd0?=
 =?utf-8?B?eVJ2TG9KZXUzUjl6MzMvVzVDMFprQWxzellkSytOaEg3NGlBWWFCMFhOZDc0?=
 =?utf-8?B?SEJBOEd3cEQ3QTQzZUg1SzgzY0tvVXFLcXcwNUdiU3B6MEFVSy96b3Q1b0xN?=
 =?utf-8?B?Vk1qdHU4OEd3eFI0NjZUQkwrL1JvUmR0TWVmai9vallFSlNYcU9PdmpEcW1t?=
 =?utf-8?B?cFFBdFB4RHAvN3p3d1FoeTBqRXJGbHpSbEQ5bUFsZ0RlVW1CaFdaRjZKZUxP?=
 =?utf-8?B?aUlZcjJzZmlDZEtlZTBpN0VKaTk0YVU0SndlVkpENFFtR2pVbDVUK2l5Z1dv?=
 =?utf-8?B?RmxCTWNrNDhMbHAvdlh3U2VKMFNKMC85R2hPakl2cnBMaW9rMXYyQWpNSU9P?=
 =?utf-8?B?R3NEUDhTOWxVSkVadDB4eCtWUXViazg0TnExTjdrRGFXMFA0L3psbFAxTnBE?=
 =?utf-8?B?dzlUS2RUMENnM2JJQjdTNzU0VUg2azIxWTloNmRBQTRTdUhHanJlNU5oVHYx?=
 =?utf-8?B?YkRRQkRwbWFGRmp2b2loU1ZsYit2N0tsbHdQbGVaeVBXdVpSR0NlZ1RxK3dm?=
 =?utf-8?B?M0FhWk5aRU9VcExpOTJZdGJyS1hGNXFyK1B4UGIzaFFOd3NTQmhmcDZrcW9y?=
 =?utf-8?B?RnJLTTFrdEJ0OHAzQ2hqUnA4N2lVNW9iQmNkc05NdzhmT1JLd2V4YndqUlJo?=
 =?utf-8?B?TC9yc1dObkVTU0xCYjhhVysvNW1XQXB6MFl1cTcwR1JKdVZTcDJSa2JVdWxp?=
 =?utf-8?B?Z294NXVLZHI4UXRHQmhnZWtVU01WTktFNUg5ZkhTbG1ET3I3N0FFZDVIRFRZ?=
 =?utf-8?B?amVnaFlGM2VGcHVISzV0RGhrekJVRCswRjN4dlNaNEdJYVVGVFhOWU9rdHpS?=
 =?utf-8?B?bWdLUnFWSGVvVjQzWHRSaTRLTTE4V1QxOER4L1kwSlJLQ2dOV0dUYnU3Uks2?=
 =?utf-8?B?WDZkc1VjVVhYaUFxN3M1RkkwblJORVJrdmlTVThqMHlJK0R6MHdKQ1gvUkQv?=
 =?utf-8?B?SHpMSnd6UGNFVVovUTlpeWltQU5ZMXJsZ2lMMXRIcVlWbTY2bitndTVBS21w?=
 =?utf-8?B?ekdoUkVvZmJGWmw1dWlVa2xuUWFKSERrWXcveVVpa1VEY295VU1EKzBmMUJj?=
 =?utf-8?B?ejYwZXp5dy9FQzVaVGFFNk9FYVk3MHpvbG5KNXVrSHdGbHRyM0o4T00rRGh4?=
 =?utf-8?B?QkluNHovbk9xeTE4Y3Q4bVkyNmFLdlBXcWhhZDNwKzlSS0htZTdIeE1URStD?=
 =?utf-8?B?TXJlbHA5aTc4L1NPMlE1a1N0eGtQaldhMWllY0VSYVpxRjRSSHhkTEZPaGNa?=
 =?utf-8?B?S29icmFFczdkQTVVL0hWY2dBNUhEc1VYM0t6Y1NETVk4b0N4YjJIMFdRUFVh?=
 =?utf-8?B?MVpSUnBJRTk2U2ZmWWUvYiszUDkxeUlQN2tCOWRvazRBREp4cWJyQzhTMkhu?=
 =?utf-8?Q?qtF0WMYIt1P65s3BYR5n0SIdnJyT2orX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR01MB9193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NExmanNEK2JwT1pFZ1NSeXNlcjJUWGI1bGpIblBPU1NsSlJIUFFUUTFJVHJT?=
 =?utf-8?B?Ni9ETjdBdnU4cDhSdWE2YS9QQzk5aUVUckpGeXl5aXZ6MlAyMklnaWtPME96?=
 =?utf-8?B?NHhkazRqenA5bFllaVRoNUUwWHdQZFpscERMOGxHWWEwTE5GNmtLRW53MVlX?=
 =?utf-8?B?Q2QydkxiMlFvZTFQTXFtRlFoa1ArSlZINVNyTjl4ZTFCOGJCUGY2eER4MTdG?=
 =?utf-8?B?Rm9DUTdWZ2ttSzJablN0Ym1KbDBqejZ6WU01NmdCNjVuditGd3hzVm9maEh2?=
 =?utf-8?B?eS9PcDdSYWtHVzRjSzFpVWowdUx4a0tuUXRUVHJEY3ZBdmFvc1R0UmxTM1hp?=
 =?utf-8?B?OUZVWEI4RVdLcVVUZ1g5eHQxcmNueGN3Mkt6UHhTUEJlSm9uMDNCazFTZG11?=
 =?utf-8?B?ckJiRndaM1FsQkcvSy9TT3dkRGorRW1LSGRoQlN0ZTRqeTE5ckp3eklYbVQr?=
 =?utf-8?B?K2pWTDM3Q2VvUFMvUERKVjRGSmc3YUJtZ2tUVnNZazdYcENhSnJjd1VCRzRJ?=
 =?utf-8?B?MWtiWDFqazZSdXBTMzBKREtnSUpMcjhGWUpRNGUwa1hsT0pBYUk0OHR2ZHVz?=
 =?utf-8?B?ZHBqT3RlS3NibzJreExVRFlVczFhSWsvRlYrQjYvU2JlTGJnNUVkTU5nTmJy?=
 =?utf-8?B?TUJtbXRiZFh4cXR0cGJEYUp1MEs4QXYxcmZoNHhsYkNkSE4wa2g1WkJJVXBu?=
 =?utf-8?B?WWpYdnBPMTgvRm9FRDlWSlYyWWZrd21BaXk5UGxqK201a3p2WXdFVXpXd1VX?=
 =?utf-8?B?eU1MN3ZUbWlESXA0TmN3bHFEWGw4dC9mZ0VLa1hmbEtXTFRXSFEzNU0zd1k5?=
 =?utf-8?B?SHRMK2RiQm5ScFVrVnF4djhFN0ZvWlFRL2hnZC9oMzFDUHoyTnhkcWc4S0Uv?=
 =?utf-8?B?V0xQNmRBWjg2dDgvYkliUVZTbnpNaGp1cVBRdU5GbHg0a0VTeGpYMWtOYThD?=
 =?utf-8?B?blJCRnNyMm0rWnVOSllQT3ZvMFUxVVRvYlVDWlBiTUdQZTY4ZDMzT2ZWZzRL?=
 =?utf-8?B?MFNSZ21SZWNnd2ZIM01PVk9hdjcxcUlXUXFCZ0FQQ1BwaGdTd1U0TnptUkQ1?=
 =?utf-8?B?RFVzSmo2aDY4Zkp4VXpEOEdkNDBJejBnN09PWUJVWDJScm9ZaTlwY0Z6YTAy?=
 =?utf-8?B?ZXp1NUdMQWhsaUJMVUxzNzM5eklzK05ETjh0M2F0czZtRXlqSWxib1hTMG9k?=
 =?utf-8?B?NjJVWm9lTEhJNlFzYmV2dXZUYlZIaUV6MFlMOVhpZG5Na0t6REtYVlVOc0Fk?=
 =?utf-8?B?V2ZmQXUvSkwwdERVS3BOQ0JwbjFYTXZhY3ppN2NTcGdLQzJHOHJnQUVuUUdO?=
 =?utf-8?B?dzd4bVEzd3h0YmZ0eHZNSzNEeXI2UkxSY281SkhzaHo1ZmpDK2ZtZENYckZ6?=
 =?utf-8?B?QndUNGlLSHhvSElFclNtanZQQktHMk8zUnE1U2pGVGZrWDdEYitzanVuOW95?=
 =?utf-8?B?SW5UQTc4SGdkVHBMZElBMmd4UEFERC9tNDc0dll2WGdNR0JTdWVqU1U0RXN3?=
 =?utf-8?B?TDVDMUNINTZoOHNZZWt6VURubXJoanc4VmVLa2tMV28xSE44clh6ZU1yWG1m?=
 =?utf-8?B?ZWZncjdTUTFxZGxOU3QxUWJtTE5xTG9kZmFWVXpPOG84QzVGdjBVR1FiMkw0?=
 =?utf-8?B?UFQvM1YwY1c4K1loNUdIM1JiM3A2dk14cnR4L0JXcGdYdFRQQUdJcW41SmRx?=
 =?utf-8?B?L09NajRSdWErUDdvMTNtMXNCd3N5NVFIZ1FlQlJjZHhxWkcxTlZ4ak0rMk5a?=
 =?utf-8?B?RmRRSkNFZThHQ0JPMHRlT2RLRnJRMVdWYmhMUVNoL3JmeHdFNm0yMXZmT3hp?=
 =?utf-8?B?bFo4L1lkVGIwQVcxYzgzWTJjSmdGQXlWS2c1WkV5OG1ocStTNFNRZm1oeTNq?=
 =?utf-8?B?U2N0TzhCazBxeDJWWng5THhoNHlYcmRQQXNYSm1WSFQwdzMrYmo0bU9yb3R0?=
 =?utf-8?B?c0RSaDdGS1RPMmpBcHZpTWpHaS9JRE5zN1ltakIvVWhySXQrdzE3dWhjajR2?=
 =?utf-8?B?TVUyR0ZuMzByeHEwTG5tYkRDNG9LTXJmUHI2ckQxU3lJTTErbmhHOGN0MUg5?=
 =?utf-8?B?Sm5sQmlZeHNMK29ydThlUUNPYTVqOWNVRUFNOGQxcXZVTERXalJsR2tWWVI4?=
 =?utf-8?Q?zt9k/8tcA/4SESMjSn/W6E6tk?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d40c5-7dc1-45f9-1140-08de11986bfd
X-MS-Exchange-CrossTenant-AuthSource: CY3PR01MB9193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 18:25:48.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1JZO/SLckaU8Xdm9wiJcHJcHV+/w5/Dm2QL10DnhmRj+OfCil69wwUb5JIEI31I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6616

On 10/22/2025 1:46 PM, Mike Snitzer wrote:
> On Wed, Oct 22, 2025 at 01:22:52PM -0400, Tom Talpey wrote:
>> There needs to be some statement of the performance consequences of
>> removing this "optimization". I'm going to predict it's significant
>> on rotating media, and should not go unmeasured.
> 
> I agree that rotational storage will likely see an impact.  But
> Linux's more recent (now like 14 years ago) FLUSH+FUA rework really
> helped improve things -- that was a major undertaking where Christoph,
> Jens and others really did a fantastic job of breathing new life into
> Linux performance on modern rotational storage.

I agree, but I think honesty requires it to be measured. Writing
the metadata has to wait for the data to make it to the same storage,
this can roughly double the total latency. If it's small (NVMe), great.

This kind of "optimization" was tried by pretty much every server
vendor in the early NFSv3 days, I recall many amusing scenes at
old Connectathons where the schemes, or completely unaware servers
were exposed. There was no place to hide when operation latencies
were measured in tens of milliseconds. Same game today, just shifted.

> Related blast from the past: https://lwn.net/Articles/457667/
> 
> My point: may not be as grim as we think...
> but there is a difference between SATA rotational storage and
> "enterprise" rotational storage (e.g. NetApp or EMC fronted by
> elaborate caching that is configured to report wbc=0 because they have
> battery backed cache)

Yep. But this is upstream, right? It can't assume.

To be clear - I totally agree with the change. Only concern is
stating why it's so important, in the face of performance.

Tom.

> 
> Mike
> 
> ps: I don't have any rotational storage to test, not it!
> 
>> The commit message needs to more bluntly state the fact that the
>> server has been violating the quoted MUST. See previous paragraph.
>>
>> Tom.
>>
>> On 10/22/2025 12:22 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
>>> does not also persist file time stamps. To wit, Section 18.32.3
>>> of RFC 8881 mandates:
>>>
>>>> The client specifies with the stable parameter the method of how
>>>> the data is to be processed by the server. If stable is
>>>> FILE_SYNC4, the server MUST commit the data written plus all file
>>>> system metadata to stable storage before returning results. This
>>>> corresponds to the NFSv2 protocol semantics. Any other behavior
>>>> constitutes a protocol violation. If stable is DATA_SYNC4, then
>>>> the server MUST commit all of the data to stable storage and
>>>> enough of the metadata to retrieve the data before returning.
>>>
>>> For many years, NFSD has used a "data sync only" optimization for
>>> FILE_SYNC WRITEs, so file time stamps haven't been persisted as the
>>> mandate above requires.
>>>
>>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>>> Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    fs/nfsd/vfs.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> This would need to be applied to nfsd-testing before the DIRECT
>>> WRITE patches. I'm guessing a Cc: stable would be needed as well.
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index f537a7b4ee01..2c5d38f38454 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>    	init_sync_kiocb(&kiocb, file);
>>>    	kiocb.ki_pos = offset;
>>>    	if (stable && !fhp->fh_use_wgather)
>>> -		kiocb.ki_flags |= IOCB_DSYNC;
>>> +		kiocb.ki_flags |=
>>> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
>>>    	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>>>    	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>>
> 


