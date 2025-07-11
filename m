Return-Path: <linux-nfs+bounces-12999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F6B02279
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF06CA45565
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A072ED160;
	Fri, 11 Jul 2025 17:21:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2098.outbound.protection.outlook.com [40.107.236.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406081AF0AF;
	Fri, 11 Jul 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254469; cv=fail; b=Za7LgZKIPqFEtIHVhp0xw9r4J4xWwiNt2hd0JOrLR7ubXqrHnq2mfEY/lCTTsmVt5kGcvoHWNEfopbvTILsM6R41Evf/kOw5OfPR1c7mEJ3GZaKruhluljofY/35GUCHRNxb4A0SY4wBKQWUI6HBVLXetCcWshbM3MjOgG0LrsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254469; c=relaxed/simple;
	bh=dfa8UV9KhX4MVvQ+KlGURAz1bcy20tUAOs02SPyJxrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3T1WgdToVPxSSiLLf+pmlBDZTYWa9Jhf3G6cEh8JBrjG/ZSC1/gu+8KBcyyFzWETeIlKfWeU+iTAT0qqfWqcSVJvw9CaALytFEj8RAxptoWcsxtjJf20tM8WZPVTt9oQTycYciRt1Zu/9XDx1y262fxvevRrkRQJ5HIqQm4Y/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.236.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJIm6Ee9v/r5xptdRbylQkoJunIStyXPgcKw8nn7wZ6j82xw0I78F4sInc0MDH0Um4jhFviwbp0R0dQaNv1T2VO3AeMrLLkFr/Llq7Yt8oSNhO1vOZwOtzoChwog1l1gnRaTrLhtJl8v2SEPERW441/kuG0TYt4Xi37o01c7tN4KRDySwF0Cw+Tz7R3Ib9ndxRwljdiS3jETjeWcc5MzvKxpCOp7A9z4ZmoiV7lbu2d/iFaZFlMFCwfYFSZw15SJePIXSzQ3H4BZjr8b2YcmLeX+m3aX+n8phZpb7eiqUmRk0DKLPmvxGR71LldEYZSNjYFXGIHr5wVMcHAziIhsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bgUxSBcIyhnty6MLvCoUEXJTOjdh4kuKK+5TBOSFp4=;
 b=tDkCvkfeosxcqq9wX4PcyBG07kBzdObkKFx8CCK7H285Q1Dn+blxmty33t3SJd6NXanrK+LFgjh/zqCyr2KSAfNl+w4+m7eq2sKR4uKt0/Tl7XLql0z4w1XeUXKvp7hzzsNqPd7LX4pbEW66vKKy/M/vGhT7HI0tvu6ggPmAhBvBXZ3hJ7OvIQ7k+HxWqxSG0kRNyeApGLJyEY9CBGs26at7jkA77odUJU3Rv6Cu/pdArW5YFYrPs+ZIXOphsi4M2Uksh3iq7pwUMz34aT1+CqNKvRqKYvgAPiqwjsprHkzMIB8SS19nEJyjr+9sKw1aZvJIZGV0A8ZJIRDIKK7loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL3PR01MB7099.prod.exchangelabs.com (2603:10b6:208:33a::10) by
 DS4PR01MB9434.prod.exchangelabs.com (2603:10b6:8:29b::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 17:21:02 +0000
Received: from BL3PR01MB7099.prod.exchangelabs.com
 ([fe80::e81a:4618:5784:7106]) by BL3PR01MB7099.prod.exchangelabs.com
 ([fe80::e81a:4618:5784:7106%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 17:21:02 +0000
Message-ID: <ea472081-a522-4c5a-8658-909793f460c8@talpey.com>
Date: Fri, 11 Jul 2025 13:20:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>
Cc: Su Hui <suhui@nfschina.com>, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <> <cecf4793-d737-4501-a306-0c5a74daaf30@oracle.com>
 <175080335129.2280845.12285110458405652015@noble.neil.brown.name>
 <39ef1522-9fad-45f8-9c73-ffba7b1f04d0@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <39ef1522-9fad-45f8-9c73-ffba7b1f04d0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To BL3PR01MB7099.prod.exchangelabs.com
 (2603:10b6:208:33a::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7099:EE_|DS4PR01MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb45df9-4d69-466e-7c58-08ddc09f4f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXgwb2Z2bnVadkh3Z05sakVQUmswQnoyc1RjWUJydUZoNkU4RmNIRURVdHFy?=
 =?utf-8?B?STYxRGVyYVppMG1SZEs2b0FIRzd0bnpvQlJLL1RJWmFEaUR0a0FHTmhGOFFB?=
 =?utf-8?B?aW5vRWo5M3M2b05WcmxIcU5yaksrbXM0dUhUYUI5RVFYOThvQ3VBZVZvcWEx?=
 =?utf-8?B?T3lCTStuSGgraGVlZXZkcytCSFA4SjNESjA5NWlzS3c5ZmRCajIxeFRiS016?=
 =?utf-8?B?TWZ1T2tKWGpPMDdXYmhhMTg4YTBxQnBIQnk3a3BwNE1jV3cwOHRBbjBsb2RF?=
 =?utf-8?B?RGltaHRJTXdjV0tvT1U3ZGpWOHFVTW9WWjNJTGtyUjMrUmM1Ky9lZmtFTmx1?=
 =?utf-8?B?dTJ1YzFmbHNDTlNKTU1uM1FzeU9udXVaQzJ0bnRYWHZueUoxc1U5aEMwMDZD?=
 =?utf-8?B?QVdpaEpJT1dYaER3STgybFdkUlNMUC9rbTdPN0VnREkyV2hzcEZnUm1SOEgx?=
 =?utf-8?B?YndrazB2Q1NuVHFJdDNsSGZ3VXZ3RWZLRy9ralhTdG9tb2NzbE9za1ZWSTAy?=
 =?utf-8?B?UlFnVFVVdU42R0hCbnNJb1doR2JRMUlBTTZyNnhwQUlsMWdYUXJRL2ZQRXk3?=
 =?utf-8?B?Q0RHdzRya2RQZnhHTXNQVURKRFc5cGR1Sk4zL0tad21pM2J3TlNmeEZaRkRt?=
 =?utf-8?B?SU1oNHNsa1JhclJCYVAzYTNMQjNlaVlEaUVhWkhKSzc2dms0SVQvdUNBWjEv?=
 =?utf-8?B?ZVNSZGIwNFNwcmpuR1cxRWl4WkZWSjJ2eHczVHVnSXQ3VTBud0tPSUdxZytj?=
 =?utf-8?B?a3ZCVytmclNXa0lFUGtRc3Y1QjF4aUhuOXQ3SHZ1RkhzWm80R1lZc0ZZdDdh?=
 =?utf-8?B?TGdILzhJMUtyVnNEWm5JZnFUd0FjYVA0THM5R2NVK3B6YllMWU4wamxkazNR?=
 =?utf-8?B?aW9pbU4zdlg5Wkp2OXkwbVg1L1cvQ0o1TDdITWZSZ243S0o5ckcyZkpFZWxx?=
 =?utf-8?B?dkVJNlgrRGVtRUNBZ2l0UXhuU2U2UFhYTGpDa1czQjlPUFRKUnhyYnpzTjho?=
 =?utf-8?B?SUxLRHhaYkNVY0RvamxqU1ZnYTVKQlZjSlhac3pwNTg4d05ERmtEWVBrM29P?=
 =?utf-8?B?TzEycVpqZWJpY1VMODk2SEd2bXdtSmdUcWxyUEY5Nk1DNlp0eXhlcUpzWklj?=
 =?utf-8?B?S1pRdTF0NWJLNElHK2s4ekViQWRzdGd2RFA0UllUN0xZOUhDUmJBMk5EV1NM?=
 =?utf-8?B?UXFGSklUWEtYWnpjSTQ3b3J3bkNVNDVFRm5WVHlPbVVWbU4wNGZ5TEhXTVFK?=
 =?utf-8?B?L1kvNDBaS0VLU2tMZmxkSWprRUVYd25vR09WRDBFVTFDSndiUVloTUZrWmF1?=
 =?utf-8?B?ZTRZcVJsU3NpSUw0bDNlQlVwa1ZHVnhTRjJxNXRsaE0yN0dtQTV4MXdiWm41?=
 =?utf-8?B?ditQN2lpUE52Nkg3b0ROa3k2WG5rMTBUMFV5TXFqQUFuaHRFaFRFdFgyMWRE?=
 =?utf-8?B?OW5IR0V4Z2t0aGdyWVExNG1DTFJrckJNbXBNQjZiTzB4Y0ZyYXppUm5pMkht?=
 =?utf-8?B?VnpqVjBRWGs5bzdJTTV4cCtvUUljZzllMUk3LzQ3RTJwK3QrbW9ZNG4yZnFU?=
 =?utf-8?B?OTd2QmhHeVg3WFIyYUdhOGcrZ1JQUGYvWHpmWWkzWWpYVloyUm5zMzBqNk1U?=
 =?utf-8?B?NDBTeS9PcGZtREVBK0IrTTd6VDFBTU9kbXB5WDFWQ2dvb2xSM3JnVldpQVMz?=
 =?utf-8?B?amo3K0UxQlhrTkJ5NE9xdHpDci96RWhUaFFUaHNWVGxMamw0QjhBSkNUZjZN?=
 =?utf-8?B?ek9DNmxZcHlHcUt6dFFLRjRlUlBHSVluWDY4Nm5iVS82ME5ocmkvYkZYc2hm?=
 =?utf-8?B?K0ZIVUs4eDdrckI4MjhhaXZLYXRyVkV0OG9KeU8wNmxpa0hiRE9BOHZncGw2?=
 =?utf-8?B?aW52cXBpWFo5VHh3cXpFY2Z4b2tNZnlpbGVqMFFqTENIVlRzMDlkTXhDb05U?=
 =?utf-8?Q?vNGU4RXvwl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmdndlYyRjJLUk96RUZTeHhZZVU2NXpWNDdFcEY4TGFqbDNZdUlHSEtSdVRs?=
 =?utf-8?B?QUZXbkVEalBTczRlL2tzV0ZjV0ZBM2ZWemRHZXRjc1BFWDBYd3JtZFRXMWc0?=
 =?utf-8?B?M0srVUMzbERkblBiWlpWakpuazNxS0J0cFMrdkpselZsSGE3bEVOS0dDRFU5?=
 =?utf-8?B?cy8wUVFoaXAwakczT3JwSWpVMExTUGxrZmQzQi9zZDlnbkxXRU40YS9LekVC?=
 =?utf-8?B?VzVvZmlQektTOWl6YnZKaGlmZ0Z1UVFWeUttNkRZa1BRbFpSY1pxT1FxMDNZ?=
 =?utf-8?B?amUzbm8yUFUrNnhYRWM5bHkzU052T2x4WXEydFJ6NGhVYUxWZEhnZGFNcG85?=
 =?utf-8?B?aWNlRzJjb29yT2lWY1dLMnQ1RzNKUGdtNGo5Z0Uxd2xKMnphR291Q1NVTi9r?=
 =?utf-8?B?aFFqdmpZTndaM0FkVHJ1bDh1V3g4SzMzWXVzVytrbGNQYkR3N29tUzRyaXdF?=
 =?utf-8?B?ZzJFTVpxVVRFbmx6RkdmZmlxZm4rZ1AySUdWdEJPS3F3TnppWEdGTkF5L05C?=
 =?utf-8?B?c3o1SGM3WHoxdTdoNFdOaHMvcFVzMWpuODE5NjBnWElmYk95RFNyQ3F0NXgr?=
 =?utf-8?B?b2QyT29yRlpLc3BBK1MvdHFJQlNmbkJqdUpQVjRVOVVUbEwwSVI0aHhJaXd2?=
 =?utf-8?B?MTlNcUNYaFZJaW9Gc0VYYmNpTVpORDl5MzlHY1dsOTJ2VDZnMlBlLzVSVUZz?=
 =?utf-8?B?bGxOeUszMnNZeTdMS0RFTnA3V0RSWUtIcDk3cUk0alptdGpqYlBNV1ZzcE5J?=
 =?utf-8?B?MHQxRDNwZStsNUpaREVqQ0JLUmpKdWRhTWdjTk54VmorVUovQkpXYytvZS8r?=
 =?utf-8?B?cmo0T2FOL0dkZEQ1WERSNXc2THZxOVV5SDROTFFGcitxTi9oQTRKVUdiYysy?=
 =?utf-8?B?SGhZRjNxTERoV0xaSTlMUGh6V0hYV3ZXY2p4OGFaUHpGNWdLemV5YzdNYlg4?=
 =?utf-8?B?RmJZOE1xWEI2Qks2U2Z0NysvRkxodStwbkNnSmJtS255YXdVZFcvQTcvVWRv?=
 =?utf-8?B?WDhGaHJhNEtMcVRzNkp5cUtMM3VOQmpEbktzRFE3VFZFNmtrdWljTDFwZnVE?=
 =?utf-8?B?TmtTdDZXNU1JVmFRV2dud0RxQW1DVERRVGJjcE84ajd0a2VHWVQyUXZuLzBB?=
 =?utf-8?B?Yi9uSGQ2RFpoazlwYm40WmNmcXEyN1lyTVpGZnVhcjZPdWx0Q1AvekNmd0dJ?=
 =?utf-8?B?aVd0bENMV1NNL0lEWTgvVlBBZHVHLzdVRG5VWW0vWFZzcFBkMm0zK3VDM2hK?=
 =?utf-8?B?bnhrVkNteGF1cllBbGxQanNKaHdBL2JBNXpnRFJmUWFwbjltUFFPMVNFSDls?=
 =?utf-8?B?T3lwSlN3OFRuN25zYld4WGVpTmNQQWtjdFFRUk55bWZ0YzZENitOQTJOZXll?=
 =?utf-8?B?RFkybWhWVXlOaG5ZK2VTcXlGR2xjUjc3MWJMMzdMYmxPaU1EcERNNFRGeTRr?=
 =?utf-8?B?bXk3eUpkNWlBREEwUnpZL05OOG9nQzQwN2M2WWJMWWFRVndiUmpER0dsVm0w?=
 =?utf-8?B?Y1NjRzFLdy9HeC9pU0kwL0Q2MWlDdDlsL1NLQzBRWWh4bFhxaUJ2Nm1RU01r?=
 =?utf-8?B?Y0o4V1lYbklRN1lkMGhoYmdHUXVQaGhodFBsZXBOMlJxV0ZMbTN6d2ZtaWoz?=
 =?utf-8?B?a0Z1MW4vRlVmSUR3WmpzYTd6U3hRdDA4LzZ6QWdLSUVtcGJIMU5lTmlPQy81?=
 =?utf-8?B?RE1hblorcFRoZUFPVW0xaWVvbkd5YnN1Y01nb0RQalNxRUZiVUExRndkQ0R5?=
 =?utf-8?B?dkJZdUp0Z2I3b1M3RWJRUWhqQ0tsZlNXOGdPNGhtaWpodG1RcktNTUZTTm9W?=
 =?utf-8?B?ZXVBc0xFTEhaU1BKV3hiZnJSb1JYZCsvQ2NJbENwTTJTUzc5RWRYRTZiSGMr?=
 =?utf-8?B?dlpRWDgyY1lHQUszQUl1d1BwM0tCWHhzT3VHVVU0eUJMYno0M3FabzdzQWlU?=
 =?utf-8?B?STMxcGVUN3JyU3IvUC9Bckg5NlF3WTg0bWE0WCsxYnJHMEg2WGUrblVMR1gv?=
 =?utf-8?B?a251N3VGK1lRam5LdnlRcGFna3Z3bmFzS3dBdUtPSFBhZ05HV2VSUlNtakRV?=
 =?utf-8?B?U1h6ZUtpeXhRYlVTbEJSLzBNUmM4N3l6Z0ZYR2w1MllYeXVhQXJwZnQrWXUr?=
 =?utf-8?Q?ieZw3thI6rqXVJDs2EDzOaQf3?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb45df9-4d69-466e-7c58-08ddc09f4f69
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:21:02.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R10RasaFaXx4bMpvCfeYtYPE2r5mzHK5xO8JrOhfLzE/y7UbJ5h3ooOyOOpKTQ8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9434

On 7/11/2025 10:22 AM, Chuck Lever wrote:
> On 6/24/25 6:15 PM, NeilBrown wrote:
>> On Wed, 25 Jun 2025, Chuck Lever wrote:
> 
>>> What is more interesting to me is trying out more sophisticated abstract
>>> data types for the DRC hashtable. rhashtable is one alternative; so is
>>> Maple tree, which is supposed to handle lookups with more memory
>>> bandwidth efficiency than walking a linked list.
>>>
>>
>> While I generally like rhashtable there is an awkwardness.  It doesn't
>> guarantee that an insert will always succeed.  If you get lots of new
>> records that hash to the same value, it will start failing insert
>> requests until is hash re-hashed the table with a new seed.
> 
> Hm. I hadn't thought of that.
> 
> 
>> This is
>> intended to defeat collision attacks.  That means we would need to drop
>> requests sometimes.  Maybe that is OK.  The DRC could be the target of
>> collision attacks so maybe we really do want to drop requests if
>> rhashtable refuses to store them.
> 
> Well I can imagine, in a large cohort of clients, there is a pretty good
> probability of non-malicious XID collisions due to the birthday paradox.
> 
> 
>> I think the other area that could use improvement is pruning old entries.
>> I would not include RC_INPROG entries in the lru at all - they are
>> always ignored, and will be added when they are switched to RCU_DONE.
> 
> That sounds intriguing.
> 
> 
>> I'd generally like to prune less often in larger batches, but removing
>> each of the batch from the rbtree could hold the lock for longer than we
>> would like.
> 
> Have a look at 8847ecc9274a ("NFSD: Optimize DRC bucket pruning").
> Pruning frequently by small amounts seems to have the greatest benefit.
> 
> It certainly does keep request latency jitter down, since NFSD prunes
> while the client is waiting. If we can move some management of the cache
> until after the reply is sent, that might offer opportunities to prune
> more aggressively without impacting server responsiveness.
> 
> 
>> I wonder if we could have an 'old' and a 'new' rbtree and
>> when the 'old' gets too old or the 'new' get too full, we extract 'old',
>> move 'new' to 'old', and outside the spinlock we free all of the moved
>> 'old'.
> 
> One observation I've had is that nearly every DRC lookup will fail to
> find an entry that matches the XID, because when things are operating
> smoothly, every incoming RPC contains an XID that hasn't been seen
> before.
> 
> That means DRC lookups are walking the entire bucket in the common
> case. Pointer chasing of any kind is a well-known ADT performance
> killer. My experience with the kernel's r-b tree is that is does not
> perform well due to the number of memory accesses needed for lookups.
> 
> This is why I suggested using rhashtable -- it makes an effort to keep
> bucket sizes small by widening the table frequently. The downside is
> that this will definitely introduce some latency when an insertion
> triggers a table-size change.
> 
> What might be helpful is a per-bucket Bloom filter that would make
> checking if an XID is in the hashed bucket an O(1) operation -- and
> in particular, would require few, if any, pointer dereferences.
> 
> 
>> But if we switched to rhashtable, we probably wouldn't need an lru -
>> just walk the entire table occasionally - there would be little conflict
>> with concurrent lookups.
> When the DRC is at capacity, pruning needs to find something to evict
> on every insertion. My thought is that a pruning walk would need to be
> done quite frequently to ensure clients don't overrun the cache. Thus
> attention needs to be paid to keep pruning efficient (although perhaps
> an LRU isn't the only choice here).

As a matter of fact, LRU is a *bad* choice for DRC eviction. It will
evict the very entries that are most important! The newest ones are
coming from clients that are working properly. The oldest ones were
from the ones still attempting to retry.

This is pretty subtle, and it may not be a simple thing to implement.
But at a high level, evicting entries from a client that is regularly
issuing new requests is a much safer strategy. Looking at the age of
the requests themselves, without considering their source, is much more
risky.

Tom.

