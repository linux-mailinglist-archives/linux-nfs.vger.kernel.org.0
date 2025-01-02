Return-Path: <linux-nfs+bounces-8886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364CEA0013E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 23:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0613A3217
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB219CC0A;
	Thu,  2 Jan 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PpyFk3sj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lI7zTlAU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D11957FF
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857782; cv=fail; b=IdozJ2QicsmEpQ44mwASWjIgXYoiHlVJbXPudMnZ2iyfektarHhzlSWrWSet9pb6LzDafNqKEc+V/oL7HgmcOQjTCV7MwvScJk63TPsZuIloqUU/VlIyAPuz20yinXrGsvFxAz7rZ6+jCBKMR8rf0Y7izclOMDryxlmtvW+Qc7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857782; c=relaxed/simple;
	bh=/M4o/7mMLUnQBzYrbBWFow87QBgrvz10hPIjDvWJT1o=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jjg4yZnU/HCtJ+1fvRETzeg+XkFPAH3Bvl2G8j92YypNOelx9YKEaWkyLZE/uxPmO/mcLGu2TrQSNIQHk5EeYnhJ/OVZv6eoScscqI2qY/G5Fj44YDehC37YzDncfR9BZOLNt4kOvft/GxvrgyAvvtiEv36zhozjVzfdjEFsRsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PpyFk3sj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lI7zTlAU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502KgNJF031223;
	Thu, 2 Jan 2025 22:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1gXFLl59Dku9j83L/2I8KNDMhHEqgns+Yv0NesDgXk8=; b=
	PpyFk3sjpR5H9XCMLkvgrjmkbprp28SrJlwSCvSaMPiLWoxZ1o78IP3/xsFoaONW
	hALH2OAFc/E8rdHB8xAAfaR1R2WzP9spcKdXY7FicuUahb8og8iAiwUhS8Q9nAKg
	3EJDbhuz+4zQFCQ1dnFdgrdM6tNhyGNTl5oegrQK48L12BdwUiede2RSN04KkQ6r
	dkCbmxFLyGefbRkBtaTIDzr9Xc5jVcsUOJla+LqHD5e2wTw6YjXtqhIHOg0/Zg7m
	7UuqP3yXRrKWO+yMLYReNhv6BjB64aJv89UCeRcCp2eriY74XWJhHRJR8KrdEm/w
	A+9Pp9hK4TNjCqe2pYD1Fg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt7b4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 22:42:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502K25l8034084;
	Thu, 2 Jan 2025 22:42:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8vpjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 22:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZW8FuA+REAK/P0OqPpGx4vPf3GHQnbydmZZ39Nj8/i5EV62kWGMEozuSeNwGzEpspW0SicowQNGkyhmTQDVRcmpzLQ7tmHQ1q2crTlS2KgwlwqlMzQhfZrZN5uYEdoXrUIwksAv+nSth0UnF2zWG4fg4NnO1DllgfNZG0rNjNkXkNbxoZIot10E+kSLY3CiQKuTqAC61wHtY3USBMhG8OjqrRM4Kx0YsAZ2jU6Z/za58PuBufMl37JCoTaM5ZnlesHiG1GmM8c197YG4ySpmzXEz7p/GiUnmLR0KLRF1t0r+8AFoE2Vd2s6ESKN/YPGJv0oCSKwfqoOgCLBh5IFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gXFLl59Dku9j83L/2I8KNDMhHEqgns+Yv0NesDgXk8=;
 b=T9AYKtub38N9DS2nisYpJqEe7nsAPS5Tst+msHv0EnIt0zuZzLAV5DpGeKVPocxGsSoNNffE7kVne9svqANZpdKNawa4TTm5OMCZcp3AOPkHsSMBxhtoQuhSJ6MUpnVyz84qaTvRml9/0/QLrYkE3963Rjq27mlPh2qnyNKR5LUc1h4mKobu3/zf0cOrFl16SjnLRk06aKVr881GRG0uitrAkYqfC2jycCcZOimMvSE9Cf160VzMzqDTKA3Nbfx5sFTuQQvKa0LvFxcXrokdUzqYWUc4xitH54h01uL1u5ghjDY4kQ376mn8jTWTWX7B5Zr97GQmd1CU2tL8vD/ZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gXFLl59Dku9j83L/2I8KNDMhHEqgns+Yv0NesDgXk8=;
 b=lI7zTlAUnlZaLf5/HIv/0rhSaiwx1QLwcptuVmIV40aUEvHXDI+YN3ki3Ko8xZ9Ll2nikbdB0bPLJyvp0fhRcyUmNqOdCD1RFkJgZ+4nv3bflwrdJs8UraMlCH2pVLr3a2GMUX2nxSF2p1Q4+qN+qE/TcuhNVQpVOOng3cU+Axs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 22:42:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 22:42:43 +0000
Message-ID: <c497a2c1-9bdd-4ccd-91e5-769f4708d9e7@oracle.com>
Date: Thu, 2 Jan 2025 17:42:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Write delegation stateid permission checks
To: Sagi Grimberg <sagi@grimberg.me>, Jeff Layton <jlayton@kernel.org>
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
 <3ee21c03-83a5-4ad8-a54f-5c076125e924@grimberg.me>
Content-Language: en-US
Cc: Shaul Tamari <shaul.tamari@vastdata.com>, linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3ee21c03-83a5-4ad8-a54f-5c076125e924@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:610:11a::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 675db3c3-4835-4b6e-1814-08dd2b7ec591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjhkNzNlVEVwT0tybERYc25BN2VIWjVLMHd6bFZYWWYxZUJqQ29ZRjZheXc0?=
 =?utf-8?B?T0pPQkJOejJHT2p2NWZyRnlFRjZLQVZ3b1NZN3dlNnh3b255WUZxT0xZQjFk?=
 =?utf-8?B?UDBkRUpRWlRWVWVBa2hCbU4ydzdnSXZaVDdEaGZ1UmtVNW1PaHFLUFdobzZh?=
 =?utf-8?B?UURLY29IaFJ2Yk5RVzFyNmlpTGZxWUQ1aGd3YTJIMzVVRGt6eVlOWDdsZVZZ?=
 =?utf-8?B?N3F2cXo1bVE5K1JvVG5Fa0xIMmhMVHZ0emZlZDJRenBFZjQrMHBWTVEwSlZh?=
 =?utf-8?B?akZpaUowdllIN3VZc1R0N2VYZVZvZDl3K3RyK0lseks1V1pNS3ZyV3F2SytS?=
 =?utf-8?B?Ny80cW5RN004ei9UQ3Z0VTV6ZVNnUVNuNmtobmRNdW0xeHZqaGd6ZzUwQ1dF?=
 =?utf-8?B?MEZsdDlkaThNaXU5WXU4c2xPVEpUaU0zMEFtUlE2K2xoUVpZZ005RndvdEpH?=
 =?utf-8?B?RWdYYWJrWk1HZ0xNdkxkRlhlZXNqTEwrclNIQzJwUnA2NUNhMWhCZGRWUE12?=
 =?utf-8?B?ZUVvS2VNMzNqK3B4enErR2NVbFB4V1NySGZFOGRiWklWZm1KaUEvZnQyQW9I?=
 =?utf-8?B?d3N1UDlCM2hLZ3EzbnhxUzlyNmEwaUwzWENaV1JXNkdjZUpQRTJ5VHlUY1hl?=
 =?utf-8?B?SGxBakNIdk1sUklRMzBod3JhZzRQTHVMdzdwRGh3SjVkeEhhR3R1TVVDNjln?=
 =?utf-8?B?TGpIelFpYlZzL0NkWE9iZWljWVdOVWdsQkx2NFp2cnFVQnU4UDZkamlsdFFv?=
 =?utf-8?B?eDFFSGF1UlFVMXdMNWNIOTQvZG1ZWDJaVE80cXJsWG9HRU5sdG56RWs0bE1N?=
 =?utf-8?B?L1IreHRlS014T01zTFRXeUJHMmhYcFlKN0paTEdrMWF2TnFsem1VSm9EZkd4?=
 =?utf-8?B?VmxLTSt6RG83WUUvUmRpeDY5aGVTdmJVUFV0TElQTUFJT1hZNUJ5Q3JHa1ZR?=
 =?utf-8?B?MzhJRHFiUXJ4WXZuajVCUzZlcHd4Smd1ZExuYlVXQ1pSKzRiT2hPT2kyc0lN?=
 =?utf-8?B?S2xqV2NIR0JPa01RMTl6amhGR3ZLL3JJRU41UXRWcWNZMUptalpLWVhxK2E3?=
 =?utf-8?B?Z1phYWlEYnhwVlhvR0JOZVhlRXR5eXNxZ0JWQy9pTWkwMGJzeGpOZkYyVUdV?=
 =?utf-8?B?K0l6UWkrMkhYblpqbElrdmJXMHk1dkFWNjBKZHJDNzZsUTlJZ29tVGk5K0hC?=
 =?utf-8?B?cWJEVWFZVFRxVndzWlM5VU1kaUNuUnJZYUJHMExQUzRtUU5sT0xzZEswdC9u?=
 =?utf-8?B?UG8zUTJ4VTF5aDFuZG9Rb3pCM2pqVW9tMGVvd1VidTd6L1B0dUh0UzVhUEtv?=
 =?utf-8?B?WmNnSC9ORXU2M2dzbDJWZlNKV2RlMG9NUldZZjZqZlB3M25RTU5RckowelFO?=
 =?utf-8?B?dzZzNzlLSGVvUXB1ekdDNzFHYjMrYmkwYjBPSUpwL2xIWjhqK3FHMlR3L2pa?=
 =?utf-8?B?cHVCQnpzR2tlcjFSZU1zMS9pR0hhbFAralBiMGNYYVZsN0RjdWwvaDRpMlVk?=
 =?utf-8?B?a2Voa0VqbjVVdmtZZXR3UmpMeWhHUGs3a2NrYmt4dCtLWkFYd3A1ajA1SkRw?=
 =?utf-8?B?TDdkdmNJRlB0UEczUXZrNzB6YkVudUcya29BdGJMdkE0aDU3S3Fnc0ttcVh4?=
 =?utf-8?B?ZURSMG8vMGx1ZEVkc0dBMDhBNmF4V2Fyd0FUYVJKR01pYjYybDhOYllNVnBF?=
 =?utf-8?B?dzRKRUpyRW5QQjFjQVdQMDZwZmw3N1hyb1VkcXMyaTV4YWhZWWhCaXQxbmkz?=
 =?utf-8?B?TzJ0ZkpjYnV6a1g1T01SZU5zSjM0NDN0aG1ZR3hMSk1nOVh2R1Jsc2xCM25a?=
 =?utf-8?B?TEs2ZG52a2tzVjhmSVhGTFdQZlZYWGtoU1ppN1AyTFg4TGtXZDVaRS9JeTha?=
 =?utf-8?Q?jSbraxs/bhcxg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURDdDV4RThSMWl0ajdMczZ0TEdvTW9obUp2TEFENW1jQlVMaVExdW5ZMVhj?=
 =?utf-8?B?TTY2aVNzUDU3UnZuenEzL1UvRm5wdkJRdFBQUFNoY2dYejdhZDFoaUtYWUNS?=
 =?utf-8?B?dkhsWldxUW9TZ08ybXVvUmpiejV6SlpzNXRoUFBKalBQUU91YmZzR3NaTjRR?=
 =?utf-8?B?YjVybVFGQ2tBYVhkWGpMbkJKYzd3OHJEVE9Hay9lSDZ0cUV3OUhmbkpUODJj?=
 =?utf-8?B?OURkdjIxVUNtWmtsUHJyRkhpVGJwMms5Q05JSm4wQnhoN0ozUzE5Q1BUcTZt?=
 =?utf-8?B?OG0wMGQ5b2VsRUFXUHZaNldrZ2M1K2hQeTg1VU5rQ0xpN1lHUEphOXM1eEZQ?=
 =?utf-8?B?SWJMRnhXV3U2bmQvakxjYzVZd3B3TWVyNTFYT2NQRHBVUCt2Mm1iZG9JbDZk?=
 =?utf-8?B?Uk9wYlNDZyt5RzVrQ1QzSVhtZytTN2RuemlIWHRQUkhPWEgvYjFac3pWeXZ2?=
 =?utf-8?B?dXozSUFtbzVES0xuN3h2WldQTWg4SHdRTlBSRDFrazlrRUpDTmxBeUpxOERx?=
 =?utf-8?B?WUcvVHpKL3FzcHNzekkxanFaSzZjTzIzdXk4YThXby9BVnVHUWFJSXliZ3dU?=
 =?utf-8?B?c2t0T2YvbnlFbDlZUjVCTDc1YzdRNEM4Q2lyVVlFM1hzeEJ0SmdpS2lYNWJC?=
 =?utf-8?B?WElzeHM4UDVxNXhWNzhiRUw3RWl5dDREa0p2bHNsaWxoeWJydGNxakpocWox?=
 =?utf-8?B?Z0RXTXdpOFNGOFZKMTYyUGRBY0piaUhDQjdRWmNHcUEvek04aUZka3dOdU9y?=
 =?utf-8?B?QmdXQy9RVEZwTUdVdTc4b0V3VjBINVNYOS9jV01BdGtlbWlub3J1Yi9VNE1r?=
 =?utf-8?B?cmN3ZVNjeElQOFRDY1A1cjlUd2ZlQkRzUzl2N0Npd3RWS3FFRS9CbnFuVmto?=
 =?utf-8?B?RFBtMDdMcEVxM05IMVlHM1lQTHpsUGdONmRGRkNlZnlJc1JGVTNPaWt0a05q?=
 =?utf-8?B?b0w3NFcvVzlhSGpYMHAyT21iMzV5b0E0RnVBQlZQK0EydXkxM0dyR0IxaVpF?=
 =?utf-8?B?Y3kvT29PMThTQVlZbzIyM2FVbnBTYnJEbDd1WWYrVU14NE9ZT2JuNDBFU2R3?=
 =?utf-8?B?VWFrZ0hNclpEY01yTWdTdzZhTS9yVElGRE9ESFF3WTVPeTRuQU9TNUo0b1Ir?=
 =?utf-8?B?ZXpCR1VoWDM5V2tCL3Q3TVpHeHV0UzhENFhxWVVnRE1pbDNaUEhPbCtjSVJD?=
 =?utf-8?B?bXRacjlYbmhKd0JrQVpYUk9lNlZTK2xPWUh3TmRsQVU5NFJneXhJUDJGd093?=
 =?utf-8?B?aFRhblg0cVErTU1TcnNCNVlDN0w5dFVlQWdlTi9GeFpVZTBNOU1hTGpMalNm?=
 =?utf-8?B?THkzTE5jZHB2cUM1azMzcGdaWFpiQUpvdW12UTVFRmJ5RXBnajVOQVlSTCtT?=
 =?utf-8?B?QWxtVThQK3lQRDFkSXlLMnhhZ2U3NzN2L0dSaCsrN3Ivc1VGVVlrZGFQWTUy?=
 =?utf-8?B?Sy91SHN5TzBndjdqT0N3emdWOCtpeXZmS3djTElkMVBLcWRheG54NHBubGg1?=
 =?utf-8?B?d1M1cDdvNytxVEtSd1QrSHpRZ2c0SjlCMHFSRnRwYXlvdmVaUUhWVWZwNVNF?=
 =?utf-8?B?MytJcE1IU1lFRTdVYTdvSk1xM29MVjBIOEhIK3RZU0NScWFuam5SbUs1TW5G?=
 =?utf-8?B?aTR6WkZxbEYwWkVhcjIzb21SSnRwSC9VYWtvREdKWUxnSFZHS3lnS0lJeFJJ?=
 =?utf-8?B?Mjl5ajJybU43eGJGY0FmRERsOEc3VlJmakk1YUlHbTArWUltamV3akgvUENa?=
 =?utf-8?B?NGp2MEtTY2xHN2cxNzhqRDM0Slhsc2pOdE5rYnRhd0VuWGVMU0paUDZNbDZ3?=
 =?utf-8?B?WlNZQWxTaWd0OXZQaEoxVmdhUnVpSHFEUm94VnZpNDZiUjlGWllYQS80QVkz?=
 =?utf-8?B?MExRc090bVI2cDhoLy8wZjgxOW9KR3lMblR4US8zL1NMRVhsY0VMTHZJcG1M?=
 =?utf-8?B?NHkzUWFES214bmRlWHBScDVHWGl5U1pON01QY1BUZDBsSVRUV25Eb1g5bTg2?=
 =?utf-8?B?TGpXYUFjeVowL3p3T1M2RTVKWFBQNGY3bzI1Q2FjK3lKc1RsWk96MmJ6SEJL?=
 =?utf-8?B?UUZ5Umd5S1V2aHNwbEhndmJzbXhGTjlsWmgrc2F6cEVzdVJnZGpsT2VncVRK?=
 =?utf-8?Q?dU6vYGxKMH3UI9bdz8cbinUgK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GzPyIdB7P2D7oW/lcE4PmdyUoAyrToRO1SSYHFpfRBHc7h53zcPd+vczFmYXFHGTW67M0r04yU6qZ4d9g6lRKXsTyyYzRu76Aq9dZIxwntFIJDz/m3qzTqF16YumyOwbdNKtlWLZ0E2HNa+E9KqGW6QDkKcGIGB56hHHRy2kRQkGX0v/jWUVR5imPP39tDEAMEFkpKsawGWmz6jloPLO+OYkF02knmSjgPxy5hc/RpXAjOIGq5aU/QNTi8uE1MZyelycxrN1HcC78tDdirIold5wqQ/hKBTPnz3stXyqNAC2UrPIpeagJajY73ye5BsEBZZK6vZMYTd1+5R9hPpzsJHSpA0uF4pPd+ReJ+ueLaLwRTlWle72Koeuwz+R6chzdp+/Y3STzFGGWs2UyuaONHpw5Ut0gnM2nqmr9da78zAp/7oGnkEs2K8njHDemmOp5467fJojmz7A5/IK/TetCjl+iPUlrr6dxCMqiTbt/yQ8Ew8ayu6qyPh8rC61JKRB4GtV1a/Xi5FzbS+TtuV4XuTWQf0ifpA5ce7Ue8xISKsBBpgKSX+BvC12NbwftLg+W5EYzB7tgWul9oJMb/RNdT4gE1WWdAt3LoTYIke6sfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675db3c3-4835-4b6e-1814-08dd2b7ec591
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 22:42:43.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cun308N2v9bfLbF/hgy0riN4DVY1LPQzxzS5+s5Bm1gRDv724NDfrakKJpLfTMOSDlkzaZIZhOcSD9qXXYObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020198
X-Proofpoint-GUID: lXRXvI6K78iNtMG64iOIeykNykMihBfR
X-Proofpoint-ORIG-GUID: lXRXvI6K78iNtMG64iOIeykNykMihBfR

On 1/2/25 5:07 PM, Sagi Grimberg wrote:
> 
> 
> 
> On 02/01/2025 15:41, Jeff Layton wrote:
>> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
>>> Should the server check permissions for read access as well when
>>> OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
>>> ?
>>>
>> Possibly? When trying to grant a write delegation, the server should
>> probably also do an opportunistic permission check for read as well,
>> and only grant the delegation if that passes. If it fails, you could
>> still allow the open and just not grant the delegation.
> 
> Yes, that is what Chuck suggested at the time.
> 
>>
>> ISTR that Sagi may have tried this approach though and there was a
>> problem with it?
> 
> Not a problem per se, IIRC the thread left off that we need to sort out
> access reference accounting for nfsd_file for both reads and writes for
> a single write deleg...

I've been pondering this recently.

The desired outcome would be to deal with a OPEN(SHARE_ACCESS_WRITE)
by opening the file twice: once, WR_ONLY, for the OPEN state ID, and
once RW, for the write delegation.

Will that work? won't the two opens conflict with each other and
trigger a delegation recall?

Seems like NFSD will need a lot more logic to make this approach
work right.


-- 
Chuck Lever

