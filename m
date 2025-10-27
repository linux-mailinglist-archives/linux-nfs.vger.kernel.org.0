Return-Path: <linux-nfs+bounces-15712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFCC101FD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 19:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89BB4FE6FD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA931B836;
	Mon, 27 Oct 2025 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hou2Wr2K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RbvVKbuY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D192BD033
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590622; cv=fail; b=CtShGJFfVyJIU7HqzKf8+pRWak/MbtfALCN2kxSwgxEzTe5N1Eib3dV50jHKj7O68GOsa2SN8XlVS2eLjMV+GFHAvinxjGZAqTqSKta3mIoQL0bp+hdh1W+lGCuhHfWY+M+rmmXkubycm3IYUicM+5LAEgj3vfQzib34pZomBAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590622; c=relaxed/simple;
	bh=b4zTO+3OegkdKcFu6lNguwBS9YGZo5rMDhSXLHzW/Es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNMidk4YxGWKsLEIGl2jjAx4jXd0pLGCkfuSlA3d/K6b+ASTlAclyWVpFIef0AxPUc3VB0J7IYTOeGwEIV8SIgzyHnm7ri8nAheaA+Uz1CuBYI4k6L+/u6i7EtkzARrZRZ/libS980ODfsBs0XbEcNEakTvvpB+zfKsZMpHALsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hou2Wr2K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RbvVKbuY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYCsx005619;
	Mon, 27 Oct 2025 18:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NcEnZ2zzecisvP8UNfv8lLu2/cnT12SP06mmBnHP5bA=; b=
	hou2Wr2KlB6kbC1addJ/AJjZzMzvjJPiw3jaQOoYTyAxqnZB/7rD/Zp5UGjd9OjX
	kRXLZltqXD2zAhGIswZ6+iJ6XTXIVMB5EhBjdPJnk+ad+J6kQAp5k9T9UGn5qmMG
	U418RcXIw5jpgsKJz1I3EPiphgOm/pj2a0OqaCXvfIqwY7m11D9h6BFdZwNdHNlh
	IcIa2+kN41n81RbkqfPh/tFnekuSqj0S44h66iQIDZV8GyR9R69UtTe+oPTd+iKd
	NEWq4xCeBbknLPksrqQJw3pH3iE4+o3dFWxyAYVFzHdqgm2ChcggwXS1P6I8p7VL
	4999/aYd1Dfr0NnPaATA7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwhp9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:43:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RIU8UA037529;
	Mon, 27 Oct 2025 18:43:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n076bbw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4O5uOySTrdwhLJz/OaS/M/Z9O/OwH70Uk2YfTGRfIB49hY6z6lCnjJtXoelP1P7VGDH65Qznd62wJ+KiKmL06CUMNOYljFJ8iD/q8WvAKfFAY7rrw7UadYvMYKAseG+FKemD9XzknpX9YjdCn6RSnqn7h0ehYzqV2Md2pxLQlfRVAx6Jnk30V2NZ/dspTMg6Y6iF9N8CXfblKyx/ReBvra9l5SjbE+eUSVNikK5Fq5b8nFwIcPurWF1/Zgx53/JPb6DIvujwUO5Kl/5jEaX5kGpkLhl0AjYunpUwBfguV5dL/a+iITDpTgIK0kk+zmAlBi858E3ZWqQB/M37UsUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcEnZ2zzecisvP8UNfv8lLu2/cnT12SP06mmBnHP5bA=;
 b=kaEpJt4Nu4Zz4zJ2+y8M7J+ogu1Xp6xY1dm+wjfTCx+DRdfIhMVyvamD98ZGZM9AvIaUR3x5KLHKU27THWD46h5lrekWIvETVdg+K9woKIZQ/Qd09LnMh3/F4a697GGAbtAsYPT5GN67Fxg6Nz4ISG05eukKq/HDUHMTk4x3Tx4Zad0TLVTeWm1z3/ayhGAW31CAI1Y04vFKbhQc8tkbVDG71icyvRvPrOwDuQLZLS1n5fhPD2OM1DxvOjKhLQhldmko2/aHMUeA4g7WWSWfjiiEPM5nUGjJwMhojkLXlazZ7gBn7yut1qJkswyYVCw2vsyMl1iNUh/fov++hIYPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcEnZ2zzecisvP8UNfv8lLu2/cnT12SP06mmBnHP5bA=;
 b=RbvVKbuYqcxuCZ4d4MICyLkHeVd4g6g+LOi0v0V4q4AHeVnEvVLTDvQ1tmfwfKq0Nm2ckmYYceb3oIf8JcRpj2g63wmfq7UV0HrWFGOOjd78oC/evXk1hoE0UoiWp5Y7I7OZ+KU9BuiegdPCEgR06IF8AHn20B+R13AanHJLwLI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 18:43:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:43:12 +0000
Message-ID: <37433325-0bc4-449f-93c5-fa747af7f7f0@oracle.com>
Date: Mon, 27 Oct 2025 14:43:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] nfsd: prepare XXX_current_stateid() functions to
 be non-static
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251026222655.3617028-1-neilb@ownmail.net>
 <20251026222655.3617028-5-neilb@ownmail.net>
 <e7d0dcf25d578c64634ec841a551b6463954a29b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e7d0dcf25d578c64634ec841a551b6463954a29b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:610:51::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV0PR10MB997614:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dfcf9a-b4b5-49a3-e2b6-08de1588ae67
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VWxOeDNYRXhyaUFhTFJQTExvRU9OQitiNnd2M1FHQTFpcHBxYzFqNThETUMz?=
 =?utf-8?B?M1hnT00zSkl2N0NpN3Z6UVp1VTBpK3U5Y1NVcXBUMFVWMUVTY0ZpRzJoMHJT?=
 =?utf-8?B?aC9IaGlPbURYYTBqTDhweGd5a1dpMng2R0psYlh4Y0U2NEJZUWZZU2VidWlS?=
 =?utf-8?B?b0NiVXZWOEJEOFZqeWpRT0tsZHpnVnZ4TmlLb2RTM2hub1pjZlk3aXUzQXhm?=
 =?utf-8?B?b2tzc2l5VUxpdER6cm51a202K0xvbWJhVGphbUpUdUpCSWhGWHJrMy9sUjIy?=
 =?utf-8?B?dVdFZDdTRkt6OFFQSGVnVkZybXBxL2E0SGdvVzJIMzJvK2crbG8xQTBxeklt?=
 =?utf-8?B?Sy9nQlFTNUJxSG5KM2VJOG9ITlhsTXpib0ViSUY5YW5YUDdzN0NqZ3Z1blcy?=
 =?utf-8?B?RGpzSStSRjZnQWR2REtrVjlTSCtUTU9yTnNSZk81VWpndCtwcFZja2RIcGtJ?=
 =?utf-8?B?dXFsUkdpa25Mci96d2ZtQW5aYnphRHI1QUFHWFJNUkVNQkVVTlhoQjdYQk9X?=
 =?utf-8?B?K0RkeWdaWVk1aTd0Yk5CUHZwd0w1L0s4M3Ywd015UGZvbWJJaXU5SU5TNngw?=
 =?utf-8?B?QnY5bFZpMUJQOUllaXF0alJBL1pXb0RHQ2NhSkZPL0FFbzNKK055blFxMW1j?=
 =?utf-8?B?eWVMaTlRdU1zcUN2MGQvak52SDdLTmlHcEw2cml4a0k0ekcyN3ZxU1ZqTGhy?=
 =?utf-8?B?dlA0SlcvVmxpa2VPOWUxRmlwbUZyTUtSUjgxQ0NDUVJqQXRaRWQ1ekJqQXhX?=
 =?utf-8?B?Sm52NlZpakttazJnWUhqaUtILzQvREcyT1pwSS9PTVZQZFVnRTVYZUZzOHp5?=
 =?utf-8?B?RTM3SWlBR3lZcHNVanc3eEVnTTY3MWRWNTdKZWM1V2hiNCtNYmhWdHhqbE02?=
 =?utf-8?B?VUFVWHR3cjR4WVRDY3krWE56Qnk2YlZkWU40eVJNaVBHVGlISjdSOVlZdEp5?=
 =?utf-8?B?RGlnMkV4bGc5a21vVXp0WGVTbHFTVE0xOXFsaUNDQWxKc2ZFSlFvWXEwQkZL?=
 =?utf-8?B?bks4cjVBTlkzM3diUDZxeWNYNTRQaVUzbkU1MFJkMUpqbm1rNWJKK0xmZEdr?=
 =?utf-8?B?YmFxWGNWRGNqaEdIYzhKR2RWamd6RFU0SUhJZzNCS3NxQjRLekd4QkVEWi91?=
 =?utf-8?B?aHF6azEwdXd3Z3hyQ1pkS1ZXamRzcTZWYzdLTlNLMllESjlxam1tVVg1cGEr?=
 =?utf-8?B?T2RLM213bWVlWkRwSGllSkFLekF0c1FmSEF1dENybnRqT1p3RkFHdldoL1o5?=
 =?utf-8?B?dmtDQUdadW4yeWxMTkpYVjhhQVk5UkpvcldhMEtyT1RJa1ZiZE9RbHMxY01B?=
 =?utf-8?B?T0ZtbXEwam8wYnp2bEVnblB4ZEVmK0hhV2dhamk0Wmx6OVdOUFJsaVNSMEV1?=
 =?utf-8?B?TUExUjVzd0ZSeWJiUytqdU1OV1M2THFSNG9WYStJNDJyK242bzRIcU9zc2tF?=
 =?utf-8?B?RllxQWFYOG5EVnRRdnk2SlRKRVpuSHM2VWJPUU96YkV1TVJRNkFUSExDY25h?=
 =?utf-8?B?SS9zdHVDQThDUUcrZ0NiTTVJaVNMVXdOdFRIZ2FNazhKeGZNMU44R3FJZFkr?=
 =?utf-8?B?akJzTHg1YW1EZzJnUGk2UmhSVktCcnNLMFJEbnU1RkN5UFB5WElydXJtK3Ny?=
 =?utf-8?B?THJSUUZoTmZ4WlI0UmMzemNPemF4eGpTRkdRTk8wZHh1QmM4eGcyeEJYeTRX?=
 =?utf-8?B?Vko3NnRQeUovOWVaQlNuVlQzUDlENUNDL3NhbFFPRzBHUXF1SHY2Y1B3VU1n?=
 =?utf-8?B?OWF5ZlZuV2Z5ZlNyV1VWdG1CWS9IWFNibG16NVpLMVdsUXVISjNFbzJrNjNX?=
 =?utf-8?B?aEFRc09kYk9Ybkd4dXBPRXVzZlR0a05NVUJLVDZmRFNnQUZxaVYrV1N0dGhC?=
 =?utf-8?B?cExqT1l2cUdpTFJnb0F0RkZaODZKcWlrbjVoWHZLY3AwaUwyNFo0TzR6dFB3?=
 =?utf-8?Q?WnMGuV4bnHR6XavUoyoueGfnP4JIDZ6a?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YU84ZEtCcGp2Mlc2VUVmTWhYcHNsbXRpa1prajZscXEyTnVKWUhycnhNU3NR?=
 =?utf-8?B?a0VOazdGMngvQVlzRTRvY0ZEVXpBQlMxT0N2dFBBVTJOOEpSdnpzYnNGSUFX?=
 =?utf-8?B?S0hBcGRacFh3dXo0THMwdlRHcXhyR2dxL0o1elQ5cUFVUURMQlp1TGVVZi9G?=
 =?utf-8?B?RFhzbUt5S1JTV1UxOWxUM0lLZVd0TlBoVEVuUHQ4anZiSnpyUS9OVUFVTGQ4?=
 =?utf-8?B?NXZ2TlJzSzBmcTFqTE9wc3dRLy9kZmRXYS84azBZazBjem9lT3FlZWNGNytH?=
 =?utf-8?B?L2lTNEJiRnhSMHVIYVVCYnFvOThTckVuSHRycCtRalVpSHh0aEFVTzNNTVpl?=
 =?utf-8?B?YU1heCsrMTJRbGVHbFZWc0xCUjhNV3NXVjVTYklhL0VkOXN2ZG9PZVVDL1hR?=
 =?utf-8?B?b2hxVDA3amdxdjlnVHkrRFBBOXhDK2djY2tNOW81akVYb0tJZXFpNmQwelBv?=
 =?utf-8?B?MWF4TTN0REtlK0c2ZUcrVXZ6VXNzK1dwNTZvSENxZmRwNmhzZGdoUitibXlB?=
 =?utf-8?B?R3VIaStMWmJsMHZ5RGxWcllYdkNsalZlMkNkTVk5SDJFdDUzMXZaSTNZcUxN?=
 =?utf-8?B?TEJyZjVObWJUQmNLYXdyL3dHUFF6OGRZbUFscExRcEZuOGJCZUY5dFR1VVlY?=
 =?utf-8?B?cGJoL2F2SlE1Mnh0N2hQZmV2eHNwVWRSQnBkenFtYTJRY0IvUmRRaVpRWDZC?=
 =?utf-8?B?NDhEMW4zTW5uaU5EbGVlandzMVl3Tk1RVjJLeHBvbW5idmFzM21Ra0VXTnlS?=
 =?utf-8?B?b001S3gweU50ZVk0bmt5OXdRcS9QdDlSclJxcHNnWTdCbVZ4azhBTWRqSmNG?=
 =?utf-8?B?Ly9MMXNxbnVjZTJGc04vZ2xSTEhYRUx0U1g1M1ljbkoxSXdjd2RxUmhZTS9y?=
 =?utf-8?B?eDcvN1FWVkNBWGJ0QTBjMUFiLytnUlFCRTVpS01DSVhzNDlUbzY4UHc3aSt2?=
 =?utf-8?B?cHdkc1h0bEpta1VNV2VYNXVsNlhmR3hYTEQ4SWZEVDRaNkEvMzk2d0J6Szg5?=
 =?utf-8?B?V3llNTJvVzY4WE1DeGJieGxjZk1oQmFVdnhZaTNWQ0ZXYlBuN3R1Vnl2eXdy?=
 =?utf-8?B?QURob0pDdWkvWUYwc2o2UzJQV3p5T083TkNSVEhYTGNnU2h5Q1k2cTdEN3My?=
 =?utf-8?B?QWs5K0RYa2tFbEE0Q2Roa1VPR3VTbVRod01pZEZzcnRCWnhMM21wZHgvVGpW?=
 =?utf-8?B?RDJkb2lUK3hYc0c2bEk1TFFQTjB1Nlc0VmE0dGE0MS9CNGUwUzRZdVVVVG5J?=
 =?utf-8?B?dklOUW01YUluZXN0Skhsemo4U0NEcHNlbHNTWmtHeVlkdUpnOXBsZno5VmRS?=
 =?utf-8?B?NHBLNkJLODdHTEdMZGNzM3ZBem96bzZIY0gyK0tvdWdDc1N6VXZ6S0l3YTJq?=
 =?utf-8?B?WExUa1pia2Jjc3JUWm1qSVVvOGw2UEYyNDhsdnZKNm5PRTJqbWVSUkJnMjVW?=
 =?utf-8?B?aG1neHRYUENOZm9VVmttUGl2UTluenhBMXZpZkVrN3l5cHhpeUtwOFhnbWdF?=
 =?utf-8?B?N2RTTTZYbzIvZzhUemU0b2dISlhJS0tuWHpHQnJlZzRkd0dvUmsxRk8zMVFF?=
 =?utf-8?B?VFcwQTZzYTBlazBLdmI0Q2RnelI0aVJBSTJmcnVkS1k5TmtXVWZjVTBDZzA5?=
 =?utf-8?B?QXZBeDg4SUExU3BhR1hnNmlzWm9oR2VCd3pBcXB5WC9DSVJJT1FtWG1xTkMy?=
 =?utf-8?B?SElwWUNaUzk0ZzdzM0o5LzRESmFjTzZzbWNzK0I3NGtTKzNCL25rc0tXY0pr?=
 =?utf-8?B?RFFTbll5ZXdSQ1dIMEhaelhIVHdxbVFlcGNEcFFmb3FSRG8ycFVkZnVkdDdz?=
 =?utf-8?B?U0k5Zng5SmRkT3pZSkpIeFlmRzNhUEp3R3R3S25qQ0U5cEdLYlhpYTNZU1FS?=
 =?utf-8?B?UER2STUwdTdUVjE0Q2pPTVc5VWpERlozRTUzUnFnTURwcmIrR0xGS3AvZ2tG?=
 =?utf-8?B?YmpPazN5NGRRM0ZOUjlxWUhLTTVQZXd4V3RMOGlhcElNZTB5Y0FjNUJSSHk2?=
 =?utf-8?B?QU0ySXRnRkJucTdwaDA1cSs2MG4yUld5MlJSdXpQQjlEdlVlb251RUN0Zkoz?=
 =?utf-8?B?a2p6aHFsZXRkN0kzMGhLK2hib0ZHL0RkcTg4Mm0vUzFTZDM2RU1DY3doVkRT?=
 =?utf-8?Q?wAsgLFDKm0tbbqhCPPTIJ/rOV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CKjwAnhNaW8RHcZafljruo6ZLupn4LwmtIvqzbdvlNDDFkPj7INWGhD+ZVWbm2+e9z3wUiD2bdvXb7DwKSKBsQPL0PYTGkSEZC+T25yWf9g695/AG4Ng8X35q+VP4e7zkNauyKQsv4M32iEa0Oge2e6Wah3uqc3OlIAPWLrgDmXNIVcPTfYzB/V0VxTf2QSIYfphRqCoS/E9r5XrXqaE5DkzmBkWRFMwnzRoGR3j3HZCdOxzIt8PjSFp4AQiuH8bwUC4pxaiW9sk2u1qPRuOUvgtPviWhCmRxnYFG16H6lfH3JkDRaDNNto03TyWV//A6ntp/HJqg0A4o4/1iQkL24YpBMzBrn+MkgGM9beaXPlLxftjWnpYzML0UoI0KOV8jDx2kPe3YeNhCPd5Nh+RfyDbn2PoYBsOBQY1X+N8UPiY6EMuz8jFy993nRF75CGDW5++mAWWrlHXJgpTiJWMoxGvc1dHUCb+dr2lHUqh1vGlIzmeIJx8251a9owL9tAqNCzz1/FeB0B4VFgxuBsLfw+5iXmyC7n3+L+IqTo0YdFinnjt5tSk17Nq1b8AREckey2Y5hcEdEu5TJFN55uWuaCJKR6dKeXuao2i/FMz+UQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dfcf9a-b4b5-49a3-e2b6-08de1588ae67
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:43:12.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnkXVMMTXFPYZ1P6sxD6BsV3SLdbwbSkINuRcAJ6OwyPrae3adAgiuQsPNdpsNTJD5e+3iohM3Vj5wm8whxsyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270172
X-Proofpoint-GUID: TgLazfUJbblF-_oIYssYzCppxc5riTQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX4fi0ovWIaWVX
 ZIEN1CRbuxnyQ+WbcseV+ngHg90aKb8aP/6YwR2G0rxHAIEUWDKO+IbB1r+WyvRnrcmjrAbreTu
 pxRIy+TczPGeBdebek3m5T7jcqShYmUWcXbpkd+IL9VbvCcJzdvmrPhLFd77jm3kIkr+tQyJepZ
 1p9G4IDarMC5Gj2cm29T1jvJqbxKTtiIMmNOs0C3zGVCfNW6eZVebFg+BFvHATtR00uX/PctTWI
 +JVcbC9ey/9Oz5OMFgQ3W7K7N2XeJRoK1j1WzawtwHfKizsyjhn9t5xp6bbbD+WZEAhNyiuXkt1
 98EpcsUkQp6PrxV9rwEVoQFTOoTKKOLSNo2cAYttIgmYutSaEpAQPuLNjBPNR/N2bt++yWE5RAF
 7/PV+ZCOtM/P9qSE0NxTh2EZrMdk+w==
X-Proofpoint-ORIG-GUID: TgLazfUJbblF-_oIYssYzCppxc5riTQL
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=68ffbd57 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=d9KI7wlLu7nlAsOjf6oA:9 a=QEXdDO2ut3YA:10

On 10/27/25 8:48 AM, Jeff Layton wrote:
> On Mon, 2025-10-27 at 09:23 +1100, NeilBrown wrote:
>> From: NeilBrown <neil@brown.name>
>>
>> A future patch will call the current_stateid accessor from both
>> nfs4state.c and nfs4proc.c.  To prepare for that some cleanup and
>> documentation is in order:
>>
>> - rename to have a nfs4v1_ prefix, to mention "_current_stateid"
>>   consisently, and change "put" to "save" as that seems more meaningful.
>>
>> - provide kernel doc for the three functions
>>
>> - move the "v4.1 only" test from put_stateid to get_stateid as it seems
>>   to make more sense there: it is only reasonable to test
>>   IS_CURRENT_STATE() when we know that session are in use.
>>
>> - place the extern declaration in nfs4xdr.h rather than
>>   current_stateid.h as future patch will remove the latter file.
>>
>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
>>  fs/nfsd/current_stateid.h |  1 -
>>  fs/nfsd/nfs4proc.c        |  2 +-
>>  fs/nfsd/nfs4state.c       | 75 ++++++++++++++++++++++++++-------------
>>  fs/nfsd/xdr4.h            |  6 ++++
>>  4 files changed, 58 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
>> index c28540d86742..24d769043207 100644
>> --- a/fs/nfsd/current_stateid.h
>> +++ b/fs/nfsd/current_stateid.h
>> @@ -5,7 +5,6 @@
>>  #include "state.h"
>>  #include "xdr4.h"
>>  
>> -extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
>>  /*
>>   * functions to set current state id
>>   */
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 2222bb283baf..a2b78577ddb2 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -2967,7 +2967,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>>  				op->opdesc->op_set_currentstateid(cstate, &op->u);
>>  
>>  			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
>> -				clear_current_stateid(cstate);
>> +				nfsd41_clear_current_stateid(cstate);
>>  
>>  			if (current_fh->fh_export &&
>>  					need_wrongsec_check(rqstp))
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index cd8214a53145..83f05dec2bf0 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -9083,27 +9083,54 @@ nfs4_state_shutdown(void)
>>  	shrinker_free(nfsd_slot_shrinker);
>>  }
>>  
>> -static void
>> -get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>> +/**
>> + * nfsd41_get_current_stated - use the saved v4.1 stateid if appropriate
>> + * @cstate - the state of the current COMPOUND procedure
>> + * @stateid - the stateid field of the current operation
>> + *
>> + * If the current operation requests use of the v4.1 "current_stateid" and
>> + * if a stateid has been saved by a previous operation in this COMPOUND,
>> + * then copy that saved stateid into the current op so it will be available
>> + * for use.
>> + */
>> +void
>> +nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
> 
> nit: consider a different verb from "get" here. Maybe "fetch" or even
> "restore"?
> 
> We have a lot of get/put functions in nfsd that refer to refcounting,
> so this looks like it's going to take a reference to something even
> when it doesn't.

How about:

 - "copy current stateid"

 - "change current stateid" or "update current stateid"

 - "clear current stateid"

Roughly, this is the terminology used by Section 16.2.3.1.2.


>>  {
>> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
>> +	if (nfsd4_has_session(cstate) &&
>> +	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
>>  	    IS_CURRENT_STATEID(stateid))
>>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>>  }
>>  
>> -static void
>> -put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
>> +/**
>> + * nfsd41_save_current_stated - const saved a v4.1 stateid for future operations
>> + * @cstate - the state of the current COMPOUND procedure
>> + * @stateid - the stateid field of the current operation
>> + *
>> + * This should be called from operations which create or update a stateid
>> + * that should be available for future v4.1 ops in the same COMPOUND.
>> + * It saves the stateid and records that there is a saved stateid.
>> + * It is safe to call this with any states including v4.0.  v4.0 states
>> + * will simply be ignored.
>> + */
>> +void
>> +nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
>>  {
>> -	if (cstate->minorversion) {
>> -		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
>> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>> -	}
>> +	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
>> +	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>>  }
>>  
>> -void
>> -clear_current_stateid(struct nfsd4_compound_state *cstate)
>> +/**
>> + * nfsd41_clear_current_stated - clear the saved v4.1 stateid
>> + * @cstate - the state of the current COMPOUND procedure
>> + *
>> + * Store the anon_stateid in the current_stateid as required by
>> + * RFC 8881 section 16.2.3.1.2 when the current filehandle changes
>> + * without a regular stateid being available.
>> + */
>> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
>>  {
>> -	put_stateid(cstate, &anon_stateid);
>> +	nfsd41_save_current_stateid(cstate, &anon_stateid);
>>  }
>>  
>>  /*
>> @@ -9113,28 +9140,28 @@ void
>>  nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	put_stateid(cstate, &u->open_downgrade.od_stateid);
>> +	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
>>  }
>>  
>>  void
>>  nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	put_stateid(cstate, &u->open.op_stateid);
>> +	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
>>  }
>>  
>>  void
>>  nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	put_stateid(cstate, &u->close.cl_stateid);
>> +	nfsd41_save_current_stateid(cstate, &u->close.cl_stateid);
>>  }
>>  
>>  void
>>  nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	put_stateid(cstate, &u->lock.lk_resp_stateid);
>> +	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
>>  }
>>  
>>  /*
>> @@ -9145,56 +9172,56 @@ void
>>  nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->open_downgrade.od_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->open_downgrade.od_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->delegreturn.dr_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->delegreturn.dr_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->free_stateid.fr_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->free_stateid.fr_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->setattr.sa_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->setattr.sa_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->close.cl_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->close.cl_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->locku.lu_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->locku.lu_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->read.rd_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->read.rd_stateid);
>>  }
>>  
>>  void
>>  nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>>  {
>> -	get_stateid(cstate, &u->write.wr_stateid);
>> +	nfsd41_get_current_stateid(cstate, &u->write.wr_stateid);
>>  }
>>  
>>  /**
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index ae75846b3cd7..e2a5fb926848 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -202,6 +202,12 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
>>  	return cs->slot != NULL;
>>  }
>>  
>> +void nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate,
>> +				stateid_t *stateid);
>> +void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
>> +				 const stateid_t *stateid);
>> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate);
>> +
>>  struct nfsd4_change_info {
>>  	u32		atomic;
>>  	u64		before_change;
> 
> Otherwise the patch is fine though.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

