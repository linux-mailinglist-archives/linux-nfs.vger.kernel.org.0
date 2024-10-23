Return-Path: <linux-nfs+bounces-7395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6309ACFA8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3B41C20BEC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345481CBEBA;
	Wed, 23 Oct 2024 16:02:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F61CBE8F;
	Wed, 23 Oct 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699379; cv=fail; b=koWT2oxJVTtFCTntzmyw7EAq8+aJ632R4I2mj/7dLSl62ID1tT2AxTYDfkaYtggopofxbJXL06+uRCwVTsFekHe/FOB7FfCtZAAWNgGLKzOaA9nBVUCr1wf1mnSEELvFXhEIeNDtMhkGhr8Y2ZYA3027At6uAsYIXsz52l3GTD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699379; c=relaxed/simple;
	bh=WzUuarTnH9iTGoGzZYf5qR82291JGrazJTU3o6+v8JM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FeAX8oCm3Cf3u2py4lL30qwglPFSc1QyhlnAhuYfRbU8wUs7hBrQqnqB7xK5oj0vha0YYjMgcNl9Kk17bZRyQg1rKrSS7jc00HXpTKcN3AsbWZMBiJG55tu577rMkqFwLRecsy5tPOWEXrN+KnvgsZeVdWzs6R4HxoxC7Xii8zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.85.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOlSOOXCTDZS7SRneW6azIektqX3FJWl3aP4fsSYmTGF1l2JQR2yVaMl764uyBforKk6VdXWxxZgSWMyynaFLXnh6R9/5e7pD2XXN4NEYr1BxcZ/ifTWCNOmyqJOMtabeCS3J8bBH3kKUdNIJWGKy2yVrlZJ4/ryZ3BWxxzqy5ljCKwzusIe5N/PhHRZoqGxEBAKOekNWS8Qh4OlIuxXSHGBgMtyz9woh0YRxNvL2tXUeojwbti3QlHaWIKUWoE/8wuOdNcWU99UoztUZfV+TYS1mT1E7CCrT/he+6erxLnZDcr0rzdxD/LnEJF94QyO/P6lL4car5Opfa9OPOEdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e71v7Qrmd4B/z5z9TeWMRR9UooVYZIVS+BT6iRg7bH8=;
 b=oyubgd03sTfPSk+91uDIXmH2pDETzfy/rw5V9ydn0RGBuwk9X3kf6RAgmMxmpLuRJWtvA/zzHWiR88xstS1DfvZDR96ETbZ3dHjHwUIRXmExAdvXbGVO38UaykfiTEaC5KEiIHd3FxzqDkdy5FgbuPS4Al/L7+t2Tttpx44b1U6Os2hAh2pR399QCshLY0YVHT51JMf82gdOsI8LtQo3iLu79ejzrL0+dUFblJ3vhYMH2DJ1Xys2YQ/T+i9rjvSNkgYI1vNDQPt5YPXIFQXrUS3w8I6QXhWXE9Hy4Oij+iNSISBaF6P76ahGTbyL8gJgjD3tlgRWRh7UER1Dw8+U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 LV3PR01MB8486.prod.exchangelabs.com (2603:10b6:408:19d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Wed, 23 Oct 2024 16:02:53 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Wed, 23 Oct 2024
 16:02:52 +0000
Message-ID: <6eb46c99-d410-4090-8832-394e7aa69adc@talpey.com>
Date: Wed, 23 Oct 2024 12:02:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
To: Chuck Lever III <chuck.lever@oracle.com>,
 Kinglong Mee <kinglongmee@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
 <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
 <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
 <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
 <290d18f3-befe-44b4-b79b-983983f1418f@gmail.com>
 <3225E57B-40A4-4CF6-BDF1-3A90BC313D22@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <3225E57B-40A4-4CF6-BDF1-3A90BC313D22@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:207:3d::34) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|LV3PR01MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: f8304d10-f142-4707-41f6-08dcf37c2572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVI4NmVnZjhzT1NvWFQrbXd2USthSkpoMHE5NnZtTytHSktOMEY0WmVEYW5u?=
 =?utf-8?B?M3JTaG56SkZPZUZ0amZqaHcwYVdPOGlsLzJVNmpaaVVsWHpxR0NTeHArekFZ?=
 =?utf-8?B?b0I0YVVVSHY0M1ZmRnJzUThSRjYvK214ZEk4NGNRUlltSDFzRm5sNGxvQS9B?=
 =?utf-8?B?VFQ2UFJxUDNzOTV4cXVSN3RFY3JuNUJpYk15R21mTjR4QXJrQmt3TXI1M2dm?=
 =?utf-8?B?SENMWVg2UzRtaDAzYTJUc0tRZjYzQ3F6MGhJb0tKaEFyclpnQjRFQjZreFVS?=
 =?utf-8?B?SDB6eWxLcy9rOU93eWRVald6bUJtU1NaQ3lWQ0dncDlmUTFjY0F3SEhualdx?=
 =?utf-8?B?UE5IMkYwakdBaFgydVNBRkhNRVdoMUxyTnBhczFZaDd4T1NVOTNZZE1zNnF5?=
 =?utf-8?B?T3RjVWtnYnE0a2JWbG5lRFprUU42N3RyQkt5NjlVT3VjN0pSck1XaWd6N1o5?=
 =?utf-8?B?SWNwVWZvOGVxMXM5NFMyL0tpaGxIQ2pHL29xdUdTYkgxSVcvS01kTXEybTJh?=
 =?utf-8?B?WUZORDdOTnRVVXRHL3lLKzB0bzBhc2tJalUzYjNMTDhYcVNndGdkV3ZQWnRX?=
 =?utf-8?B?bEorcEVITitMNTAxSWNMUkMzUGgxMUZhWUlWNVRNMk1GcmFXMXFYZGpIaWVV?=
 =?utf-8?B?VEk1TG9OSkgyUHArWnVnZVEveTdnWU5nejRaemcvcjhzcThlZTlhV013L3JF?=
 =?utf-8?B?cmRpa0NKVCtSSGZuTDNhRGZPcHZheWRXbmtaY3pOMjRkczltZTczWmNsUlRs?=
 =?utf-8?B?c3I2aDlWOTQ0a0tCeHRiLzNISktqZHBkZVFLUVdHUSt3QjU2ZzM1M3FLTnZJ?=
 =?utf-8?B?bGN5YWJKNWswZXdhNXdOT0lGN2RRWHN1eHAyWERGM2ttQ1MzNEtYNDBjc3pi?=
 =?utf-8?B?UXRraG9LamJOM1NuUkUrdEVZai9NRDdOQmtiV1JYT0QwNytpQUpMK3lEdTRP?=
 =?utf-8?B?NDJycFV2UUVZV0U0aUpWeDdxWVdwaDAyaG5jTHBPSkh3cTE0dEtUMCt5VHBq?=
 =?utf-8?B?SnlFQ0ZOQ3dGcjNIcUc2SUpxUUhxemh2eUkxdnVjbzVwNXQxNzRvVTJ2T04r?=
 =?utf-8?B?alYyWU9KdGh2dFREajdUVkNmNmZydTNnVWZ3bEdVdVcvY3ZrZmNoS1BVRDVS?=
 =?utf-8?B?WWY3akFORHpGTUFGdkNRVG1IaHVQcUE3VkMyckxTa0tmWXY1c2V6ZlpBOUNp?=
 =?utf-8?B?b3NWQ0toNWZKK3NxZVc2bENqK2FmZ3VMOWplNURISk5lMXZkUzFjRXNSOTg1?=
 =?utf-8?B?WlplbkpzQys4QnFYWGp4aFg3WXE4Y3FOL1ZKOFhKaE5mR1o0QjluYUwwc01W?=
 =?utf-8?B?L2ZVQjV0UzkwbWtyTzdDVjl0a2N4UEZFbFNua3ZXelUrdmtXVjk5djArcUJM?=
 =?utf-8?B?OG5nTEN0NTdLZU85K2dOdlhDNW5sYnJucXIvNWRmaGZZY0hmWjJLVk9CNFVx?=
 =?utf-8?B?RWMxZzJBUTBDWnRHZXBzWWN3MlYxNVBMYmhNcEppL3RSVURoQW1RK2RzY1BL?=
 =?utf-8?B?dXNNUm5Zb2lwN2JBQzJsVWt0a1FUYWlRRHRjTkNwREFvaE5EZjZJeHMyZHdn?=
 =?utf-8?B?dUxJeFd6clFWbmM4cTFPNkN6UlFIaVFTMlNqNHNpWWpWMGg5R04zaEExMTJ5?=
 =?utf-8?B?dGM3ZllIcFZtVHg0dkN4WDVCS1drbUJIRmRTNVdYdURFZG1rZStYMUZVcm1M?=
 =?utf-8?B?eUhHazFnVEF2enhPSkJrRkNWeWJxQW02aVN5NlZxOU9DbXcwYjhOK0FEOG1Q?=
 =?utf-8?Q?tUmn68xbVUUCM3IoAWafu+Mc9KC0dSvlkRtalip?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2hLS0xyZnJuRnhTelBBbHdrY2tQaGRjcG1qbnZhUHpnOGR0TjNUYVhKY1hV?=
 =?utf-8?B?ZnFYUko4QVhxZjF0OHFtTzZVWXg4WU00WlBqTmtrSVVLNEVHcy8rM1NEdjE2?=
 =?utf-8?B?TjEwSlNZaXBVc01tMlhpNERZU09kMk5LSFVuRmt5UWQ2Q3VuVEFldzRib1hl?=
 =?utf-8?B?dGYrM3l1NzJDYU4zcjVQeUdGc3ljeG9Gcy9JamVUaFFkanJlR3p3M2tMb3BJ?=
 =?utf-8?B?cCtCYnVodjdaUVNEMDUycTRacDlCa0FsdjhnOGV2dDV5TWJsbGJuZVZpNHln?=
 =?utf-8?B?Mm1xWUh0S3lSZ1BvU0JkWjk3YXVVcWFhcWI5bElQYzJCdE1zdHlpTXJkSXUz?=
 =?utf-8?B?bzlvVDh0OFV0MjVCYzVCMmNiWVplME9FWFdNUzdKSGwvUjFWdll6N3NKRUlO?=
 =?utf-8?B?RStHZHdpb093K3hKeFBiaElpd2owamZ5UkQ4NEY1WWNrYWVJZ0lIaWpZY2pj?=
 =?utf-8?B?RUZzeS96MjBWWXdnL3l4RTZRN2tnS0NzVFVzbnFCWmI4d2pTYi9vVjd3eHht?=
 =?utf-8?B?UTBvdjZEczBCdWdlSkV6MXJzcmN0WmozajBNaXdaVzB6UWF1SEtqd0l6Z1dF?=
 =?utf-8?B?cWM2QXFxUno1ZG44a1pCaUMxWXpGYkNIVDRoV3J5Qm9oZ3ZxVm1EYVE4WHp5?=
 =?utf-8?B?dWo3RkN0OW02YUdjVGY5cU5jK1BLMm9yNmRiS0FwSkp0RVpJRWd5SGpZWVBC?=
 =?utf-8?B?Q1BiMkpUREV2QmpBbG1XdGZMWk1UYmdTdkVaOHlHWTR3OUpTcE1IMStXQzlo?=
 =?utf-8?B?dmg2U21FNHJnYzg1OGEzd1I2VlJldDV2RlJPakl5K05FakJMdU51Y1FHMUNZ?=
 =?utf-8?B?Q0YzUFN2ZVhuYXloYjY1eEdlcG1OSHFGclVwSDhiQnRUUDByN1ZCQVFGbVVi?=
 =?utf-8?B?bTNXYkxRWlYzMDVFM2VpcklEcXB6RForQ2h3WndvUlc0MVQvbVMvQStSY1pL?=
 =?utf-8?B?RjNkUTJ6dFlja2hYZUJjRU1PVHV1SXhiVU5RbU0vbHRZNmdGYzRkeEM4N3Rh?=
 =?utf-8?B?aEVBdlE5NXRiZkhRZUJBNlh1alBMUjd5OEltbTRBVmhYT1p2d0pvNG02d2V4?=
 =?utf-8?B?a0VycnluQlc5cWZ0cHhnMHdYV3RYY1lnaSs0Qk50WDArb1FYMXZrSGRBM2NY?=
 =?utf-8?B?Y05kNk1wUkJ4Tm14bERQblNDT1dtM3hpZGxkQjlFQnlLZldielUydE1VcEV6?=
 =?utf-8?B?VWVHUFh2ZmNGb090L2pBeVg3ajJLOXh1OXE4RFNDZ2t3bExyNVJGTjdrK1B6?=
 =?utf-8?B?bUZWdlA3T0JXY0xBZlZIOUJhM20vdk1XMG1JWnc0bGtaSG11ZkNNYmRFdkNX?=
 =?utf-8?B?WnJjcUtZOWFDV0E0WnFJcnNyV01ONEp2Qm9KMlVROTVld2Q2UlBFN2ZFY0pm?=
 =?utf-8?B?TTU1NUFhSDRQMUlpanhLRFk0aHQxdTdva0ZYdkdTbXFxRTMyMHpQUnFiWm1i?=
 =?utf-8?B?MUNSU0dVakpUTVJKb2J2RDNwZEdBaUxUYklrbnZPdS85L1htc1cvRjZKbmxw?=
 =?utf-8?B?dUw4MkhHUndQY2Z0eEM2UmczVlMrckhRdmV5RG5LVys2bm5WTWxFOWREVlZ1?=
 =?utf-8?B?TVp6T3BXZlljaVNqZXRqdkNLZmcxT1JRckhaa1hFR3oxTVI2dUtncWFSQlJ1?=
 =?utf-8?B?NXVCanYxOU9MaWxsQUxQOEVJc1p4VHYxZ3liUnN2b0MwempmSlR3bllXZzE4?=
 =?utf-8?B?ODlrQlNxalU0WUh5ZE1KOFBVVmtuWmE1VVNBMXlINTgzSTVzbmxTVmxiUGFZ?=
 =?utf-8?B?cFVwOU5JSmI1Y2ZLMXJFUzBzdmNSdEc5VThRN2pXcWNZQ3Nzang5aTYwMVJm?=
 =?utf-8?B?RjhkZTdPRzJpV1VkK2JqOXBNSlRHZGlpOGxUT0tGaVA1bVUwT21yMUJlRUZX?=
 =?utf-8?B?MzVXTXpPelF0M0VuRmV6aGtpQzl4UkFMR3FkRWlNRHdTTjlKNDQ2SUNaeXlP?=
 =?utf-8?B?R3JRc3ZuYXg1YUNpeFdZQUZmYkV5V0gwMmJHM1FHa3lnZ0VkT3E1MlgwQ1h4?=
 =?utf-8?B?VktMVHEyZWJ0dWVaSXNrSDJEVzlaRW00b0dTU090d21lTndxOUFpQjZkbVRU?=
 =?utf-8?B?a3ZJUGgrWHBQeDF5OGRJSGVBek1OL05OdTdsbnlSNDdDK1ZEdHZsNlhhMXNK?=
 =?utf-8?Q?UKk0=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8304d10-f142-4707-41f6-08dcf37c2572
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:02:52.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd0bMB6lYEbZZLDfHozL5qT0s+d6An8XmGLa0KmAACOLwEw0SO/xhP7R3FR/ecQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8486



On 10/19/2024 2:51 PM, Chuck Lever III wrote:
> 
> 
>> On Oct 19, 2024, at 6:21 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>
>> Hi Chuck,
>>
>> On 2024/10/18 10:23 PM, Chuck Lever wrote:
>>> On Fri, Oct 18, 2024 at 05:23:29PM +0800, Kinglong Mee wrote:
>>>> Hi Chuck,
>>>>
>>>> On 2024/10/17 9:24 PM, Chuck Lever wrote:
>>>>> On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
>>>>>> Hi Chuck,
>>>>>>
>>>>>> On 2024/10/16 9:57 PM, Chuck Lever wrote:
>>>>>>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>>>>>>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>>>>>>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
>>>>>>>
>>>>>>> An RDMA consumer is not in control of the "source port" in an RDMA
>>>>>>> connection, thus the port number is meaningless. This is why the
>>>>>>> Linux NFS client does not already support setting the source port on
>>>>>>> RDMA mounts, and why NFSD sets the source port value to zero on
>>>>>>> incoming connections; the DRC then always sees a zero port value in
>>>>>>> its lookup key tuple.
>>>>>>>
>>>>>>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
>>>>>>>
>>>>>>> 259         /* The remote port is arbitrary and not under the control of the
>>>>>>> 260          * client ULP. Set it to a fixed value so that the DRC continues
>>>>>>> 261          * to be effective after a reconnect.
>>>>>>> 262          */
>>>>>>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>>>>>
>>>>>>>
>>>>>>> As a general comment, your patch descriptions need to explain /why/
>>>>>>> each change is being made. For example, the initial patches in this
>>>>>>> series, although they properly split the changes into clean easily
>>>>>>> digestible hunks, are somewhat baffling until the reader gets to
>>>>>>> this one. This patch jumps right to announcing a solution.
>>>>>>
>>>>>> Thanks for your comment.
>>>>>>
>>>>>>>
>>>>>>> There's no cover letter tying these changes together with a problem
>>>>>>> statement. What problematic behavior did you see that motivated this
>>>>>>> approach?
>>>>>>
>>>>>> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
>>>>>> support resueport now, so we try to add it as tcp/udp.
>>>>>
>>>>> Thank you for clarifying!
>>>>>
>>>>> It's common for a DRC to key on the source port. Unfortunately,
>>>>> IIRC, the Linux RDMA Connection Manager does not provide an API for
>>>>> an RDMA consumer (such as the Linux NFS client) to set an arbitrary
>>>>> source port value on the active side. rdma_bind_addr() works on the
>>>>> listen side only.
>>>>
>>>> rdma_bind_addr() also works on client before rdma_resolve_addr.
>>>>  From man rdma_bind_addr,
>>>> "
>>>>    NOTES
>>>>        Typically,  this routine is called before calling rdma_listen to bind to
>>>>        a specific port number, but it may also be called on the active side of
>>>>        a connection before calling rdma_resolve_addr to bind to a specific address.
>>>> "
>>>> And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().
>>>>
>>>> Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
>>>> rdma_get_dst_port() at userspace.
>>>> So if needed, it's easy to support them in linux kernel.
>>>>
>>>> Rpcrdma and nvme use the src_addr/dst_addr directly as
>>>> (struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
>>>> (struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
>>>> Call helpers may be better then directly access.
>>>>
>>>> I think, there is a key question for rpcrdma.
>>>> Is the port in rpcrdma connect the same meaning as tcp/udp port?
>>>
>>> My recollection is they aren't the same. I can check into the
>>> semantic equivalency a little more.
>>>
>>> However, on RDMA connections, NFSD ignores the source port value for
>>> the purposes of evaluating the "secure" export option. Solaris, the
>>> other reference implementation of RPC/RDMA, does not even bother
>>> with this check on any transport.
>>>
>>> Reusing the source port is very fraught (ie, it has been the source
>>> of many TCP bugs) and privileged ports offer little real security.
>>> I'd rather not add this behavior for RDMA if we can get away with
>>> it. It's an antique.
>>>
>>>> If it is, we need support the reuseport.
>>>
>>> I'm not following you. If an NFS server ignores the source port
>>> value for the DRC and the secure port setting, why does the client
>>> need to reuse the port value when reconnecting?
>>
>> Yes, that's unnecessary.
>>
>>>
>>> Or, are you saying that you are not able to alter the behavior of
>>> your private NFS server implementation to ignore the client's source
>>> port?
>>
>> No, if the rdma port at client side is indeed meaningless,
>> I will modify our private NFS server.
>>
>> I just wanna known the meaning of port in rdma connection.
>> When mounting nfs export with rpcrdma, it connects an ip with port 20049 implicitly,
>> if the port in client side is meaningless, why is the server side meaningful?
>>
>> As I known, rdma_cm designs those APIs based on sockets,
>> initially, I think the rdma port is the same as tcp/udp port.
> 
> IIRC the 20049 port is needed for NFS/RDMA on iWARP. On
> IB and RoCE, it's actually unnecessary.

Right, the _destination_ port 20049 is IANA-registered because iWARP
uses TCP and the server is already listening for NFS/TCP on port 2049.
The NFSv4.1 spec allows dynamic negotiation over a single port, but
to my knowledge no client or server implements that. And of course,
NFSv3 and v4.0 are naive so they require an rdma-specific port.

IB and RoCE use the "port" number to create a service ID and have no
conflict, so while it's technically unnecessary they have to listen
on something, and the server defaults to 20049 anyway for consistency.

OTOH the _source_ port is a relic of the NFS/UDP days, where the
UDP socket was kept over the life of the mountpoint and its source
port never changed. The NFS DRC took advantage of this, in, like, 1989.

For TCP, SO_REUSEPORT was used to retain the semantic, but it's not
guaranteed to work (the port could be claimed by another socket, and
even if not, the network might still deliver old packets and cause
it to fail). Because the DRC is attempting to provide correctness,
it's IMO very unwise for a new server implementation to require
the source port to match.

So, even if rdmacm now supports it, I don't think it's advisable to
implement port reuse for NFS/RDMA.

Tom.

> I'll continue to sniff around and see if there's more to
> find out.
> 
> 
>> Thanks,
>> Kinglong Mee
>>
>>>>
>>>>>
>>>>> But perhaps my recollection is stale.
>>>>>
>>>>>
>>>>>> Maybe someone needs the src port at rpcrdma connect, I made those patches.
>>>>>>
>>>>>> For the knfsd and nfs client, I don't meet any problem.
>>>>>>
>>>>>> Thanks,
>>>>>> Kinglong Mee
>>>>>>>
>>>>>>>
>>>>>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>>>>>> ---
>>>>>>>> net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>>>>>>> net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>>>>>>> net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>>>>>>> 3 files changed, 141 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>>>>>>>> index 9a8ce5df83ca..fee3b562932b 100644
>>>>>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>>>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>>>>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>>>>>>> unsigned int xprt_rdma_memreg_strategy = RPCRDMA_FRWR;
>>>>>>>> int xprt_rdma_pad_optimize;
>>>>>>>> static struct xprt_class xprt_rdma;
>>>>>>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>>>>>>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>>>>>>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>>>>>>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>>>>>>>
>>>>>>>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>>>>>>
>>>>>>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>>>>>>> .mode = 0644,
>>>>>>>> .proc_handler = proc_dointvec,
>>>>>>>> },
>>>>>>>> + {
>>>>>>>> + .procname = "rdma_min_resvport",
>>>>>>>> + .data = &xprt_rdma_min_resvport,
>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>> + .mode = 0644,
>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>> + },
>>>>>>>> + {
>>>>>>>> + .procname = "rdma_max_resvport",
>>>>>>>> + .data = &xprt_rdma_max_resvport,
>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>> + .mode = 0644,
>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>> + },
>>>>>>>> };
>>>>>>>>
>>>>>>>> #endif
>>>>>>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>>>>>>> xprt_rdma_format_addresses(xprt, sap);
>>>>>>>>
>>>>>>>> new_xprt = rpcx_to_rdmax(xprt);
>>>>>>>> +
>>>>>>>> + if (args->srcaddr)
>>>>>>>> + memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>>>>>>>> + else {
>>>>>>>> + rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>>>>>>>> + (struct sockaddr *)&new_xprt->rx_srcaddr);
>>>>>>>> + if (rc != 0) {
>>>>>>>> + xprt_rdma_free_addresses(xprt);
>>>>>>>> + xprt_free(xprt);
>>>>>>>> + module_put(THIS_MODULE);
>>>>>>>> + return ERR_PTR(rc);
>>>>>>>> + }
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> rc = rpcrdma_buffer_create(new_xprt);
>>>>>>>> if (rc) {
>>>>>>>> xprt_rdma_free_addresses(xprt);
>>>>>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>> index 63262ef0c2e3..0ce5123d799b 100644
>>>>>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>>>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>>>>>>> xprt_force_disconnect(ep->re_xprt);
>>>>>>>> }
>>>>>>>>
>>>>>>>> +static int rpcrdma_get_random_port(void)
>>>>>>>> +{
>>>>>>>> + unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>>>>>>>> + unsigned short range;
>>>>>>>> + unsigned short rand;
>>>>>>>> +
>>>>>>>> + if (max < min)
>>>>>>>> + return -EADDRINUSE;
>>>>>>>> + range = max - min + 1;
>>>>>>>> + rand = get_random_u32_below(range);
>>>>>>>> + return rand + min;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>> +{
>>>>>>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>>>>>>>> +
>>>>>>>> + if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>>>>>>>> + switch (sap->sa_family) {
>>>>>>>> + case AF_INET6:
>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>>>>>>>> + break;
>>>>>>>> + case AF_INET:
>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>>>>>>>> + break;
>>>>>>>> + }
>>>>>>>> + }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>>>>>>>> +{
>>>>>>>> + int port = r_xprt->rx_srcport;
>>>>>>>> +
>>>>>>>> + if (port == 0 && r_xprt->rx_xprt.resvport)
>>>>>>>> + port = rpcrdma_get_random_port();
>>>>>>>> + return port;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>>>>>>>> +{
>>>>>>>> + if (r_xprt->rx_srcport != 0)
>>>>>>>> + r_xprt->rx_srcport = 0;
>>>>>>>> + if (!r_xprt->rx_xprt.resvport)
>>>>>>>> + return 0;
>>>>>>>> + if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>>>>>>>> + return xprt_rdma_max_resvport;
>>>>>>>> + return --port;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>> +{
>>>>>>>> + struct sockaddr_storage myaddr;
>>>>>>>> + int err, nloop = 0;
>>>>>>>> + int port = rpcrdma_get_srcport(r_xprt);
>>>>>>>> + unsigned short last;
>>>>>>>> +
>>>>>>>> + /*
>>>>>>>> +  * If we are asking for any ephemeral port (i.e. port == 0 &&
>>>>>>>> +  * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>>>>>>>> +  * port selection happen implicitly when the socket is used
>>>>>>>> +  * (for example at connect time).
>>>>>>>> +  *
>>>>>>>> +  * This ensures that we can continue to establish TCP
>>>>>>>> +  * connections even when all local ephemeral ports are already
>>>>>>>> +  * a part of some TCP connection.  This makes no difference
>>>>>>>> +  * for UDP sockets, but also doesn't harm them.
>>>>>>>> +  *
>>>>>>>> +  * If we're asking for any reserved port (i.e. port == 0 &&
>>>>>>>> +  * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>>>>>>>> +  * ensure that port is non-zero and we will bind as needed.
>>>>>>>> +  */
>>>>>>>> + if (port <= 0)
>>>>>>>> + return port;
>>>>>>>> +
>>>>>>>> + memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>>>>>>>> + do {
>>>>>>>> + rpc_set_port((struct sockaddr *)&myaddr, port);
>>>>>>>> + err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>>>>>>>> + if (err == 0) {
>>>>>>>> + if (r_xprt->rx_xprt.reuseport)
>>>>>>>> + r_xprt->rx_srcport = port;
>>>>>>>> + break;
>>>>>>>> + }
>>>>>>>> + last = port;
>>>>>>>> + port = rpcrdma_next_srcport(r_xprt, port);
>>>>>>>> + if (port > last)
>>>>>>>> + nloop++;
>>>>>>>> + } while (err == -EADDRINUSE && nloop != 2);
>>>>>>>> +
>>>>>>>> + return err;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>      struct rpcrdma_ep *ep)
>>>>>>>> {
>>>>>>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>> if (IS_ERR(id))
>>>>>>>> return id;
>>>>>>>>
>>>>>>>> + rc = rpcrdma_bind(r_xprt, id);
>>>>>>>> + if (rc) {
>>>>>>>> + rc = -ENOTCONN;
>>>>>>>> + goto out;
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> ep->re_async_rc = -ETIMEDOUT;
>>>>>>>> rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>>>>>>>         RDMA_RESOLVE_TIMEOUT);
>>>>>>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>> if (rc)
>>>>>>>> goto out;
>>>>>>>>
>>>>>>>> + rpcrdma_set_srcport(r_xprt, id);
>>>>>>>> +
>>>>>>>> return id;
>>>>>>>>
>>>>>>>> out:
>>>>>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>> index 8147d2b41494..9c7bcb541267 100644
>>>>>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>>>>>>> struct delayed_work rx_connect_worker;
>>>>>>>> struct rpc_timeout rx_timeout;
>>>>>>>> struct rpcrdma_stats rx_stats;
>>>>>>>> +
>>>>>>>> + struct sockaddr_storage rx_srcaddr;
>>>>>>>> + unsigned short rx_srcport;
>>>>>>>> };
>>>>>>>>
>>>>>>>> #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>>>>>>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>>>>>>>   */
>>>>>>>> extern unsigned int xprt_rdma_max_inline_read;
>>>>>>>> extern unsigned int xprt_rdma_max_inline_write;
>>>>>>>> +extern unsigned int xprt_rdma_min_resvport;
>>>>>>>> +extern unsigned int xprt_rdma_max_resvport;
>>>>>>>> void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>>>>>>> void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>>>>>>> void xprt_rdma_close(struct rpc_xprt *xprt);
>>>>>>>> -- 
>>>>>>>> 2.47.0
> 
> 
> --
> Chuck Lever
> 
> 


