Return-Path: <linux-nfs+bounces-7396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60B9AD112
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E61C20E4A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38E1C3306;
	Wed, 23 Oct 2024 16:34:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2109.outbound.protection.outlook.com [40.107.92.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02131CACEF
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701297; cv=fail; b=W3bY57jLvuMXBbh8GatOMyOH5Tw+GkPwxqS/fzYavrJimxKdiIwyERpPoaNiAblyLJtMTnTPHCY2Jfxgc0YVeDb2sEa2hkJX7Zan+/nsaIVrtNHI+x1PzLAMaAdpm+3JfW01IUIUzCQ1hCKlfmJqiGIO3/kmhITUxE0pgjnrsGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701297; c=relaxed/simple;
	bh=5ymisoFKsUOihCc4q7RqoTvJ0+KUIOz/LmXtehDbFmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZCVF+Si9P+/iP/VwaOUF+eyoqwqpC4Wt937aqfL6EXOJ1NWth4RX5Pb9baX4QZtzjTDaHlTkkcDMhainHQ5zVkTCt5YkyhShzQXRTJcV5/GJVpCBY8lo2onQgnGt+VhECwuivNpcqg7riBosB0k4AWo3nCX3LX5ctiMwiOKaRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.92.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxHUt43TaLrYbxgFKI2wbATtFXpGsDysKFy6qjy0iWKMsU2ydrSpaJrDdU+hVVt+GXBsN09hoDagZez5b1ptcRV1rOksORP5eYpybZCYrNEQO7zRkeM5K6VasUhK4vWOTNqdCpCrhCpXgke632L1ZPHy/dHycDrNzto/wslwFSIFiNwPbZqhHvBH1oEIFzQswYQflk0+WZFNtlNs0C5gKw2J5q3weNaGNeZ9crbWI93/DytaQYAGK/4HPuK98rapn7vcxcZAjCEvnOk/6qA6gF6XgwXEa44sychkvHG0Ge/XEgwJD+QYlBmHcVwCieV24lf2ku8ct2QhgzasGLH8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9X8jBhhjkWuFEDXTCjdU5uZncWG2+x9em1kZDI1hx4=;
 b=mh00znFyGH7/qMEznFm70C6GWXpSGcs3h8Ia1h0yH1gnTBpsD0hcbv4i+nPrWrPODbweTIoPZ5F+J4D14eYyC76/cuLetrb03280PrpCdBJgeWdTyE6ApeUDOTXv6M9CpKspxhQeHo/6KxxfvXsPqNPB8wbDF/sr30cB6wqu9wTY5/Nhg/XiNqYMjL8KEJlvxOVD3k9Es0YP95erOW1H+y4Xlv9y2Ft0V6QErdDbHvoMDPHXfG7qpx8dmnFgEI9M11aqCQAbmCPWZBD2ulebpqTPCg4tHR41nMpjoAbuKIoL11g1gL272xcoAjhqRk8zOjVG5mpJpW5M1kVdDaniDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SJ0PR01MB7396.prod.exchangelabs.com (2603:10b6:a03:3fb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 23 Oct 2024 16:34:51 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Wed, 23 Oct 2024
 16:34:50 +0000
Message-ID: <c020595b-82c6-4521-8ada-0220eb6aeaf0@talpey.com>
Date: Wed, 23 Oct 2024 12:34:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>
References: <20241023024222.691745-1-neilb@suse.de>
 <20241023024222.691745-4-neilb@suse.de>
 <ZxkARHvnShXOQM+/@tissot.1015granger.net>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <ZxkARHvnShXOQM+/@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0324.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::29) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SJ0PR01MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: a07c2e33-9075-4d32-b80f-08dcf3809d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZytKTUNHMllXbldRMStaVjlmZGFoUDdoRlVmb3crbWEyZWM5REtuU3gzK1F6?=
 =?utf-8?B?ZW9WNVE4RGZaM2hQSURIdUpuc2gyWjRUZjgzMnlORG9mUjNGRnFSS1ZNSVht?=
 =?utf-8?B?aFlHNnJZZTlaM1NGc0w1YUxLd0YwYlRHMXQzWHdSdmg3NEFsc21POXFpYmI5?=
 =?utf-8?B?QW9PRVZzbUtHeEZIbjJOUytTZGQzeTZxS2k5eGNRNEhKdGdPN2xIWWd4empm?=
 =?utf-8?B?aHhvanJMMWk5QUFjQmIwUVJKeXgzcnYvclQ4eVZUWndGMnR0SkFiU1EwMW9M?=
 =?utf-8?B?a2ZOMjhOWDF4cldLMHBQTkM0RjhvMWlEQWdpaTFUQ0ZVeFphZVdWTkJQYXBQ?=
 =?utf-8?B?YXU0Uk9wdGNGdElTelcrSHF2ZjRTRU9BTThwc1ZUemptUm9pRjk1UDQ5VmVw?=
 =?utf-8?B?bkJUc3M4WGl3cXBWUENwQUl0cnZENGI2clM4bU9IM1FZTVI2dGZoeW1zY2Uy?=
 =?utf-8?B?eS9ldGYyRnNWTGRqU0FKZXJ6TXprZFFrNkM5eXBlODl6RGxZZzhlYzJXU0VV?=
 =?utf-8?B?bVF4ay9zckc5djBPREFPbWozY1FpTUl1K1ltN042RlBXMDg2eVhVeWFwSCsw?=
 =?utf-8?B?TllVNlBCcDduM0MxdldyNnVQb3NRcFpsVXNlRWFyaDVZNktKMHVqN0ZLci90?=
 =?utf-8?B?ak5OMmdRbmF1NzRpYXF4eXcrWHdVWVlGOHlVTm9jOUZncWJSTlRLcEtFYWtI?=
 =?utf-8?B?aEI2S2ZBRXkwSkVJYVFSOVRkc0tlUVgvTXNqL2MwTXphQ0lhNGtpczRHR0Fu?=
 =?utf-8?B?clE0ckhkaEpSa3BSeW1seVl3Sm0ra0Vmb1drSUtVK01KZDA2b2QydmlJekw5?=
 =?utf-8?B?OEdFTFNENnVRYklqdWdYcGlTMkdmdlNCNjh0S3hhWit4Q0hid3NUdDA4N2R1?=
 =?utf-8?B?OWNCUXRSUExsYm5qaDNCcFNBUXZLb2R1RmEyTHpNL0F6Q2dqRjJLYkRpVmFj?=
 =?utf-8?B?d0QxeldnMld0Wml2dTEyQnFzZm40UWZMT2tzNk5qNW9PLzRtVUNsZ1g4RkVF?=
 =?utf-8?B?VkVteEdDSTNDUWVDTm1GYW90WE4wemxOMjNOYUN1Y3pWWG5qdG4rUlNIY25V?=
 =?utf-8?B?VytHcjRoV0M0Y051Q3ROeXV2ZDZZZlRxMHI4eWJUclYrWVEyRWV3ckozcG5Z?=
 =?utf-8?B?VWxGY2xscUs3d1h6TFBwVkkwYWdmdE44dG5lRlZRbHltQ1F2WjVXOG5NajhC?=
 =?utf-8?B?S1ZGVnVRcHB1RnBNYXZWQUZoczRQSWxOQ01BVkpwdW1ZY1MxeVVzdlhucXo0?=
 =?utf-8?B?ZHlNVWZyRVZOL2JldkQvTngyZG1IMUNYRFJGRXRad1RLY3c3SDZkc2NYTHZh?=
 =?utf-8?B?ZGMrK3F0MitSWSs5UGdYWnhET0tweUlHTkNFRk4zM3FwQ21UVWtHYTlGeVdP?=
 =?utf-8?B?am13ZGYyN1FtdGgvUk9RaWZEbklGRngwSkVKVDd2MHhQZFVydzdOTEJhMjd2?=
 =?utf-8?B?aXN3QUp5QkpCc3ltTExMN2dIUHI4dTM0UVBhTVF2OWM0bEQvSk9lYjRGaXNr?=
 =?utf-8?B?YmhqN05JUlVVYm5Xd3VWeDZLZktqRzVOalZLUTZ0WjltOWIxSU1QMFE4NzJY?=
 =?utf-8?B?NkpabURuM2EyM1IxM1VPSkQ3bmxDMC80N1pxWFMzVlp5Y25SSkVoY0FsdUNB?=
 =?utf-8?B?bkRtNkMwNThMeWRXY0V5RkxNYjFjNG5GdzJ1MndOUllzcGkrR2UxS0M4NVk2?=
 =?utf-8?B?TE9OWnFzNm5xOGo1SlphUFg1RTYzYll1ZzRKcXhuRkhYcE43VDRTRFVhSHZv?=
 =?utf-8?Q?Pc1Vz7R2lblJUlMh1r4lwmba0qWY6Kz4oKoqDWr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGdPSG9FNUlERnBkQmdKSDNTRVMvdVNubDFpcE5LVWUyQWRGbTBaaHI1QXVq?=
 =?utf-8?B?U3dyNHJxMHcyRi90OXdtNTVFemtzMmt1bmordmo4cHFNbk44QzUvbVBSb3lm?=
 =?utf-8?B?aG5kVTZ1bEdyanMyODhjbGtQVURMSlM0OXRqKzlpRzFod1ViRG5NUnAya2wx?=
 =?utf-8?B?UmFDVjVuYkpwalh3ZTdoREJmeFFFQlAydEdBWGZ2QVZxYlQ5OVV0bE11WEFn?=
 =?utf-8?B?cnhMN2c2KzBQQXFxVXNYYkVsQUFiU1MwWjgrSkxCbTdVYlNDeVdqK1ZEVFhP?=
 =?utf-8?B?aFlXV0JxWVpqc1Rud2p2MCs1K0M0TENOQnErc3NXZlBNWVlxaXFWYll2VE5U?=
 =?utf-8?B?STJNalhhSm5uNWJhNHpDS3pSZjVocnZkZitHN2FBRlkxZVRacGZkaVRobTRn?=
 =?utf-8?B?MHN6VlZoZGF1STE0dXdBbVRYOUxwemo4ckliU093UkVCT1pVbDhRMWJNTnJa?=
 =?utf-8?B?SGlsaDNZeXRtcndjMFF5ZHl3azdFaEpVSUQvWXlwN3YxVWhhNnZ3MlVqM2dO?=
 =?utf-8?B?UDllS3ZaV3dSQkhXMjF1UmMzTnhsL0QzdlhieUNtWnk2SCtSVTJCaWtvUllq?=
 =?utf-8?B?NExpNGhvcWg4bFJHdmVoYUdPaktMUnZuMHphaDI3YVNNbkREdmliUkVDV2ZI?=
 =?utf-8?B?TmJITkpubmV6cTVZWXM4SFB2bXJOY2RsT2xWaTBWQm9JeUxvUmtoaTlTV240?=
 =?utf-8?B?clV0UWRrYzRUS3oxNkp4b2xxYXc3VEZnOGpGQjBUTkFYb2grd3pwWGVrTm0w?=
 =?utf-8?B?V2RkNmI5UkRmVVFiL0tTRjIxS0FQUVhONTR6L1pLT0dFTnRWRi9icFoyUERX?=
 =?utf-8?B?NWJJV2g2TVhDalluL1ZpMnE0dzR3aS9HWi9HY1JKcTFEL2ZJZDlFRm01ZUh2?=
 =?utf-8?B?b2g2RU9tQ0xORkx0OGE2ODhuMnhFeTJxa3JjakhUSVJlSTNySWl0SDEwQjdI?=
 =?utf-8?B?Y0RzcUFwdE1ZaDljK0JsQm11YVNXMGhnNEJ2U1J3SFQ1d2lSL2RDL0hnd0Qw?=
 =?utf-8?B?aHVncTMvSGFYOWRSWVh6Z1Y2LzRMZlA3MnQza3hPdU96L0NPUUI5KzlEYndz?=
 =?utf-8?B?bTFDNlRzb0dCbC9ERTJKK0xuc0NuVVprVUpVc21VVHlzUUY0NklLT1RlWmhq?=
 =?utf-8?B?T3ZOTEJ0OUJOVk9YaUhKaUUvTXcrZXJLVktPRlJjNmxRTlViNkZOOTJBTXg5?=
 =?utf-8?B?RzNqVGFUNndaVzh0eThScDZNeVAwaklaalA3VEVzNXpkbStVZFlSVGJOa1N2?=
 =?utf-8?B?WkZZWWNGb1VUNW9kSDcrdm84bVY1azdaMXlkakkzQWJBeGlhdkd1Q3N5ZWtD?=
 =?utf-8?B?ZDd6cFRGa282MlBPWmIzTFRQa0QxeXRlb3NiRFVTbG5jV2hUQ0k3REcvWjVM?=
 =?utf-8?B?SHEvaktFVHlOanJ3clRtMkIyNmdmWmpucW9YNXlaeVZYSldLK0NZRXBjeC95?=
 =?utf-8?B?cjNYTkFQZ3F2VXBhWHRVWGRSYU15aXRld2FQcGRVVHZBSjVlUGZRbDAxSEph?=
 =?utf-8?B?YXphNm9SYy9OTEc1OXU3OTNrU2RUem1BcUZ2RmlodnRjZ3lEaEZIUllTeDNU?=
 =?utf-8?B?eDRYNCtJYmlxUkNyM0lVVEJka01qN2c1NmcwZUpUbWZ0UFpZY09WWkNUK0pr?=
 =?utf-8?B?V3IyTnJBZ2JoQXRZR2hPM0Y1NE1FZkl6TnNrRWY5QkxGeFNDdG5Md0h6NHAy?=
 =?utf-8?B?VldYVnV1WnVXbHVPVTZ5YjduZXNwbWJlNWNSRDBIeHVBOG93YUg3Mi9PMW5a?=
 =?utf-8?B?ZGNjZFV0YWJXWnI3UVY3bFR4bGgwSGFkaU52cjd4Q1JSVEg3cjZGNURBd3kv?=
 =?utf-8?B?c0g5RlRLMVhtZDhaRVd3ZE5YVFBFYkdZUUt3Rk9yTGJiWkVjTlBTZDNKU0R4?=
 =?utf-8?B?anArdnUybmF1bTRqY1craEphNStUOWhoYis5V05pWFY1eUhvUEoyWWxTQXBL?=
 =?utf-8?B?blE2c3VpMUVNRXVnTUFTZ0VtM2JsR04rNWRJYXlRWnE4TGJpTENwSjBybkV6?=
 =?utf-8?B?d3V3QzQxVmlJZFpUbXVlb0JBcHNUcXhCYlJlVE5mZnhTcFhEM0ZrcktFYUNh?=
 =?utf-8?B?MEpBOVVKTXA2U3VKekMvU1A4cUdnR3Z0a1BPU3hsZmJRV3MxMnc4RFI1RmFM?=
 =?utf-8?Q?FXJg=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07c2e33-9075-4d32-b80f-08dcf3809d8b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:34:50.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8whBLm9Kx1gTyzGDDf8qId8ALPLPPA2Bj3IS+UeZUQcLBldAkL5jl+FWMXsWVZuv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7396

On 10/23/2024 9:55 AM, Chuck Lever wrote:
> On Wed, Oct 23, 2024 at 01:37:03PM +1100, NeilBrown wrote:
>> Currently per-client DRC slot limits (for v4.1+) are calculated when the
>> client connects, and they are left unchanged.  So earlier clients can
>> get a larger share when memory is tight.
>>
>> The heuristic for choosing a number includes the number of configured
>> server threads.  This is problematic for 2 reasons.
>> 1/ sv_nrthreads is different in different net namespaces, but the
>>     memory allocation is global across all namespaces.  So different
>>     namespaces get treated differently without good reason.
>> 2/ a future patch will auto-configure number of threads based on
>>     load so that there will be no need to preconfigure a number.  This will
>>     make the current heuristic even more arbitrary.
>>
>> NFSv4.1 allows the number of slots to be varied dynamically - in the
>> reply to each SEQUENCE op.  With this patch we provide a provisional
>> upper limit in the EXCHANGE_ID reply which might end up being too big,
>> and adjust it with each SEQUENCE reply.
>>
>> The goal for when memory is tight is to allow each client to have a
>> similar number of slots.  So clients that ask for larger slots get more
>> memory.   This may not be ideal.  It could be changed later.
>>
>> So we track the sum of the slot sizes of all active clients, and share
>> memory out based on the ratio of the slot size for a given client with
>> the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
>> did in the EXCHANGE_ID reply.
>>
>> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Dynamic session slot table sizing is one of our major "to-do" items
> for NFSD, and it seems to have potential for breaking things if we
> don't get it right. I'd prefer to prioritize getting this one merged
> into nfsd-next first, it seems like an important change to have.

I agree but I do have one comment:

+ * Report the number of slots that we would like the client to limit
+ * itself to.  When the number of clients is large, we start sharing
+ * memory so all clients get the same number of slots.

That second sentence is a policy that is undoubtedly going to change
someday. Also, the "number of clients is large" is not exactly what's
being checked here, it's only looking at the current demand on whatever
the shared pool it. I'd just delete the second sentence.

Don't forget that the v4.1+ DRC doesn't have to be preallocated. By
design it's dynamic, for example if the client never performs any
non-idempotent operations, it can be completely null. Personally
I'd love to see that implemented someday.

Tom.

> 
> 
>> ---
>>   fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++---------------------
>>   fs/nfsd/nfs4xdr.c   |  2 +-
>>   fs/nfsd/nfsd.h      |  6 +++-
>>   fs/nfsd/nfssvc.c    |  7 ++--
>>   fs/nfsd/state.h     |  2 +-
>>   fs/nfsd/xdr4.h      |  2 --
>>   6 files changed, 56 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ca6b5b52f77d..834e9aa12b82 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
>>   }
>>   
>>   /*
>> - * XXX: If we run out of reserved DRC memory we could (up to a point)
>> - * re-negotiate active sessions and reduce their slot usage to make
>> - * room for new connections. For now we just fail the create session.
>> + * When a client connects it gets a max_requests number that would allow
>> + * it to use 1/8 of the memory we think can reasonably be used for the DRC.
>> + * Later in response to SEQUENCE operations we further limit that when there
>> + * are more than 8 concurrent clients.
>>    */
>> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
>> +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>>   {
>>   	u32 slotsize = slot_bytes(ca);
>>   	u32 num = ca->maxreqs;
>> -	unsigned long avail, total_avail;
>> -	unsigned int scale_factor;
>> +	unsigned long avail;
>>   
>>   	spin_lock(&nfsd_drc_lock);
>> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
>> -		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>> -	else
>> -		/* We have handed out more space than we chose in
>> -		 * set_max_drc() to allow.  That isn't really a
>> -		 * problem as long as that doesn't make us think we
>> -		 * have lots more due to integer overflow.
>> -		 */
>> -		total_avail = 0;
>> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>> -	/*
>> -	 * Never use more than a fraction of the remaining memory,
>> -	 * unless it's the only way to give this client a slot.
>> -	 * The chosen fraction is either 1/8 or 1/number of threads,
>> -	 * whichever is smaller.  This ensures there are adequate
>> -	 * slots to support multiple clients per thread.
>> -	 * Give the client one slot even if that would require
>> -	 * over-allocation--it is better than failure.
>> -	 */
>> -	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>>   
>> -	avail = clamp_t(unsigned long, avail, slotsize,
>> -			total_avail/scale_factor);
>> -	num = min_t(int, num, avail / slotsize);
>> -	num = max_t(int, num, 1);
>> -	nfsd_drc_mem_used += num * slotsize;
>> +	avail = min(NFSD_MAX_MEM_PER_SESSION,
>> +		    nfsd_drc_max_mem / 8);
>> +
>> +	num = clamp_t(int, num, 1, avail / slotsize);
>> +
>> +	nfsd_drc_slotsize_sum += slotsize;
>> +
>>   	spin_unlock(&nfsd_drc_lock);
>>   
>>   	return num;
>> @@ -1957,10 +1939,33 @@ static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
>>   	int slotsize = slot_bytes(ca);
>>   
>>   	spin_lock(&nfsd_drc_lock);
>> -	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
>> +	nfsd_drc_slotsize_sum -= slotsize;
>>   	spin_unlock(&nfsd_drc_lock);
>>   }
>>   
>> +/*
>> + * Report the number of slots that we would like the client to limit
>> + * itself to.  When the number of clients is large, we start sharing
>> + * memory so all clients get the same number of slots.
>> + */
>> +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
>> +{
>> +	u32 slotsize = slot_bytes(&session->se_fchannel);
>> +	unsigned long avail;
>> +	unsigned long slotsize_sum = READ_ONCE(nfsd_drc_slotsize_sum);
>> +
>> +	if (slotsize_sum < slotsize)
>> +		slotsize_sum = slotsize;
>> +
>> +	/* Find our share of avail mem across all active clients,
>> +	 * then limit to 1/8 of total, and configured max
>> +	 */
>> +	avail = min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
>> +		     nfsd_drc_max_mem / 8,
>> +		     NFSD_MAX_MEM_PER_SESSION);
>> +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
>> +}
>> +
>>   static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>>   					   struct nfsd4_channel_attrs *battrs)
>>   {
>> @@ -3735,7 +3740,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>>   	 * Note that we always allow at least one slot, because our
>>   	 * accounting is soft and provides no guarantees either way.
>>   	 */
>> -	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
>> +	ca->maxreqs = nfsd4_get_drc_mem(ca);
>>   
>>   	return nfs_ok;
>>   }
>> @@ -4229,10 +4234,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	slot = session->se_slots[seq->slotid];
>>   	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>>   
>> -	/* We do not negotiate the number of slots yet, so set the
>> -	 * maxslots to the session maxreqs which is used to encode
>> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
>> -	seq->maxslots = session->se_fchannel.maxreqs;
>> +	/* Negotiate number of slots: set the target, and use the
>> +	 * same for max as long as it doesn't decrease the max
>> +	 * (that isn't allowed).
>> +	 */
>> +	seq->target_maxslots = nfsd4_get_drc_slots(session);
>> +	seq->maxslots = max(seq->maxslots, seq->target_maxslots);
>>   
>>   	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>>   	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index f118921250c3..e4e706872e54 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	if (nfserr != nfs_ok)
>>   		return nfserr;
>>   	/* sr_target_highest_slotid */
>> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
>> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>>   	if (nfserr != nfs_ok)
>>   		return nfserr;
>>   	/* sr_status_flags */
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 4b56ba1e8e48..33c9db3ee8b6 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>>   extern struct mutex		nfsd_mutex;
>>   extern spinlock_t		nfsd_drc_lock;
>>   extern unsigned long		nfsd_drc_max_mem;
>> -extern unsigned long		nfsd_drc_mem_used;
>> +/* Storing the sum of the slot sizes for all active clients (across
>> + * all net-namespaces) allows a share of total available memory to
>> + * be allocaed to each client based on its slot size.
>> + */
>> +extern unsigned long		nfsd_drc_slotsize_sum;
>>   extern atomic_t			nfsd_th_cnt;		/* number of available threads */
>>   
>>   extern const struct seq_operations nfs_exports_op;
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index 49e2f32102ab..e596eb5d10db 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
>>    */
>>   DEFINE_SPINLOCK(nfsd_drc_lock);
>>   unsigned long	nfsd_drc_max_mem;
>> -unsigned long	nfsd_drc_mem_used;
>> +unsigned long	nfsd_drc_slotsize_sum;
>>   
>>   #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>   static const struct svc_version *localio_versions[] = {
>> @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>>    */
>>   static void set_max_drc(void)
>>   {
>> +	if (nfsd_drc_max_mem)
>> +		return;
>> +
>>   	#define NFSD_DRC_SIZE_SHIFT	7
>>   	nfsd_drc_max_mem = (nr_free_buffer_pages()
>>   					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
>> -	nfsd_drc_mem_used = 0;
>> +	nfsd_drc_slotsize_sum = 0;
>>   	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>>   }
>>   
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 79c743c01a47..fe71ae3c577b 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>>   /* Maximum number of slots per session. 160 is useful for long haul TCP */
>>   #define NFSD_MAX_SLOTS_PER_SESSION     160
>>   /* Maximum  session per slot cache size */
>> -#define NFSD_SLOT_CACHE_SIZE		2048
>> +#define NFSD_SLOT_CACHE_SIZE		2048UL
>>   /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>>   #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
>>   #define NFSD_MAX_MEM_PER_SESSION  \
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 2a21a7662e03..71b87190a4a6 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -575,9 +575,7 @@ struct nfsd4_sequence {
>>   	u32			slotid;			/* request/response */
>>   	u32			maxslots;		/* request/response */
>>   	u32			cachethis;		/* request */
>> -#if 0
>>   	u32			target_maxslots;	/* response */
>> -#endif /* not yet */
>>   	u32			status_flags;		/* response */
>>   };
>>   
>> -- 
>> 2.46.0
>>
> 


