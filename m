Return-Path: <linux-nfs+bounces-13388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E8B1885A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 22:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5350316AAB9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205891DE4DC;
	Fri,  1 Aug 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Foor7/EV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EfiuQXyc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77703248873
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081570; cv=fail; b=BIO7RdFTlSJ0++/c9UUcmo8MUsS3pXz0pYGWiIAty6V6VPoBDLSNbT8oukSvF1CU0LKTNn7yX9TuiqTeGsZstV8H6Ytom+xqt6qVH8umLSPA8vTU1yoE+pr6nvCRqYKamqxrhHPHeWRV/JSRsIjhov7v6ywU0lzXAZrw9WsFXpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081570; c=relaxed/simple;
	bh=ZSU5njNZ9WoljoIYhYV4RzG11cLImmTDIjSvumyLWMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERgK6tib5UKBgKFI8CdMMK87asNyUxVDgJsc5uSXh7UdNx1XbwqmPUP+Txndxx3MHrf/jlaen2REBn2A7KNcdy739TzCwehF0WDok8Yx0mcU8TRj/63aPxmeYuihQdBz1jyFCyl0DWR6bE5wUQIISz7ys2A+f6s+D0i4RonqMoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Foor7/EV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EfiuQXyc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HtqvZ009344;
	Fri, 1 Aug 2025 20:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bKkue8XuXE+XFPyJRs0frGBXGXvncW/cnvbT8Dwbue0=; b=
	Foor7/EVXVgGJlqHoP7+ZhnDTDSkSDyJa9VQpx73yAwBIX5Ik6K866WjaaXQv9Kj
	azRkMwat97uddcEXcPjI0iqLTOvBf86FmI9hvyspO4q5+4IkrzA8sNe6DVv/xr98
	aRGV8DvCmcxXYBx7HZOv4186OSzrd8Lz3pCmDbmeYoiimf0rzUdfHZ8xSsdT12Ml
	7YAiOZVXma9CKYdUwlM4vxEBO/ECDU7SmiGeYodOj6R6mBCkrjicxZmZ8TGBdf+l
	KaLctgU/wJ/8KouzFr8cPpyG21VedpFheKAncHem4rJTI12IRsTl7bqxX33cI47c
	X7hDzovViEY2Fx1/cfCIKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x6u31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 20:52:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571JuJvt002428;
	Fri, 1 Aug 2025 20:52:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfe8kge-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 20:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5BeFQeGo4QmCZSA5SVBR2+ZoJAM+PonSy+GlzN6p4Mze0xei4uF7d4j8vcnYnp4f/qM3pf3Owxc6rtsEAxnx9qf8N6767dMhoLvjKFkcJ/T03UqfzJiwmKbAx1YYjqIEazLqEVtv5FyVOQ/da1LaUhkIi66ePbwxYlqtNTtq8DKyYeiu5omxWKLXcrmmZNkHM1HH9G/gLtsknf/momHHjiERzLNA1bZ6RbOB59kFL5fafmKhTJ42Se5UJjI6xBTaW3KPiEQmVoquqocWwtx6iKfvE4Q5anYBvXmRXOEY+c6pdD9+pi2k/gO7vuFgSEmnlk9BHvnWpchnRoGdB1Dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKkue8XuXE+XFPyJRs0frGBXGXvncW/cnvbT8Dwbue0=;
 b=qrhPJQ6lu9+hCj0VW1XVeaYyKBiHvkkcWrdDZndOjxLxsFsrVAhtFhq5uxLkvL9SepyxAdm14YjKkJ3Kj5EnFgcI6G6HcaICL3nOKdhnWXaKlSeVFBeuRf9QC6Es/40ustbhPJ8RQwN8uO0VqMrfPYCmIlPKfngeuKGIslMju7sMmRqve4P6Q90DL0OUJNzlt72/RDlKoRHCkkUZFnW2U1p5lB/5mgRcAez88y7oxWlAzEKWqIp65RZtn92uXGubhXzk6SkhKOhXCOab2EKExAWcBdYKlQoBbtZgNGV0KGToOJxBXNO5oaUolMHbLpgoBNp+H4AGxqeN2bp0+AjUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKkue8XuXE+XFPyJRs0frGBXGXvncW/cnvbT8Dwbue0=;
 b=EfiuQXyco78xHNKTMAGdP70X4VY800cVq0923COgv/livehlGH9oOW7qSele21/BNiSYCGD7Z3h3tItPm6dlRTtNGii3Sw8h6QyJHIcv4PfiADsHUhZZTATMxt5vwHYv8O3dcdOrKf4uDia8+DLiI+Smezu8jMAhPYgpAD8+2cc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 20:52:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 20:52:40 +0000
Message-ID: <27aecf85-059f-4789-bcfc-b518a2643e19@oracle.com>
Date: Fri, 1 Aug 2025 16:52:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on
 misaligned WRITEs
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
 <20250731230633.89983-3-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250731230633.89983-3-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:610:e6::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ded07ea-73f4-46a9-42cc-08ddd13d5aa3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cldVMFg1elZ1TzlFY3lkd2pRSDcxeVg5azQyMm5pSVEvSGxLcnNJUGpCY2VY?=
 =?utf-8?B?K3pHQ3VDZ3U3NjdUSjkxWjBmTjZFTG9jNzljMzJxVk1CTXJUSlRpSHJURnRI?=
 =?utf-8?B?VGNFenFBV3o1RjNveWpHbXBEeXdXZDRKd2hGVHlSdGpld3JVTDhiNldwOURq?=
 =?utf-8?B?eW04d3grc1RML1J5MkdpL2VZSG1vdVQvQ2VvN2dIeDNJZFl2V0N1Z0FzOEdt?=
 =?utf-8?B?UWlVTUxMejRZVUo4cGJiVWx3RERnZEo2ZzVpZFVYaVFrb0ZIZDQrM2FsNG9w?=
 =?utf-8?B?OFdRbWVwRjBVbVdYWklGa3B5eW1YOUxuWEVTVjFBVm50NUwyTzl2R2VrVU5W?=
 =?utf-8?B?SEdlaGlnMko5TFR3bDBGQmJJM2tTUHV4c2labDNTTk8vcFZjVUowVUYrcTBi?=
 =?utf-8?B?RC93bUlxZzZuWXQybjdvekE5VmJCZ21vQ1QraHUwWmdHS1lXRWkvZVp0N2VH?=
 =?utf-8?B?em5HYmJGZ0Y2NWJVRkhrVWs3RVd4ZFRSUTQ5WmdlU2hoQ1hoZ0hhdVhFa0JD?=
 =?utf-8?B?R3I2Zlhybmczc3BTSXR5OXhKSVc2KzltQW1YeW1pcTh4c3lxdTJqdjZxTkNF?=
 =?utf-8?B?bytWdHovR1hjTll0K2ZnY1hReDZKYU1sU3NUUENIUHRrbmsrWnBXQ2duM0hM?=
 =?utf-8?B?cjFjcjFIRUs1MzhPMCt1REFaTWI5b3BCazhmL0g2T0ZSVWdGODlpcVJYTDB4?=
 =?utf-8?B?dUphZk04MGhtbmJsb3NIalZmK0pWUWQvOVJLRnZNNVJKNlhiWmZLdGJsbURi?=
 =?utf-8?B?SGJ3VDBSZytwSGZtQ3Q3R0I4OTJDWVlDdVE1cmxyZ3dPSmpkVXd0WnVTZHFM?=
 =?utf-8?B?L0FiNTFtcThKdzZmTFozN1B0YThTbTJQcWg2NktCSDY2eDFYYlhCUmtYb1hz?=
 =?utf-8?B?OUVrYUFGNU1MWmpmTHREcW45ZDIyMG1HSTExVTlCcU9WbFVFYy8vSXNscXFy?=
 =?utf-8?B?ZUxoRnpVUXpBVUl5R0Z1bEVVU3p3bXRYUjI1NEtMdFdYMEtycVJrK0RwRU1u?=
 =?utf-8?B?U2VPTG9zTTA1TUdiU0krTEJkZXJlRnJkclVnL3lGUUNaYklyTjNFelM3WlVE?=
 =?utf-8?B?dEU3WitXaUhtK1BoaWRQaVpYSWxHWTAyWW1XYXZnMjVEenBOajE0ZGxsV1VB?=
 =?utf-8?B?aC9FUWVtOTRiZ204YllGRk1VdE9jZlJlWTBiUEFKdFBjS0VGTTRmVHhXRWZ0?=
 =?utf-8?B?WUtIdmJIQVp4UU1wMFMyQzdsenFrOCtGdm9sQW4xTUM1Q25VUUg4WlJFUzMr?=
 =?utf-8?B?NmV2T1NuVWV3K2NYY2N5OFZhVXM4Ujh0bzdDM04zOFZ4VGUwS2VWQ21oY3Qz?=
 =?utf-8?B?Z2grTjd3cjgvVXlNSTMvMDNXaTRnaUM2NGZDME5tUlNDSW1NUWprOHhYVWtn?=
 =?utf-8?B?VTFEWmRIM0tMLzFHVjJ4TEJGam8xdHoyR2VFWmwwZ3FyOXE3dURUUVFzcFVX?=
 =?utf-8?B?UTF5TDEvRmt6K0NVNVNjd3hIUlZCSXgzejRXcFlkckQ1Y3VLNGhEdHpUekV3?=
 =?utf-8?B?OHI3N3lXUmcwVlEzd0dGV09QVGxTMzQ0NzlLU1BTOGFUODlTQ0FEK0t2bUZl?=
 =?utf-8?B?K2xsTFhiQmNYT1Ivc1BjN2RyUzlMV1lwVi9wT1N6S0ROR1ladmJ3bU1lc2M2?=
 =?utf-8?B?cUU2WFZ4WnBNUjZLYVkzZ0haTDVybXFleHVpNFpBWTZjOFhjVFdBam01bUli?=
 =?utf-8?B?R1FvM2tCMWNBaEpMR2hhSUwxVFBTaHplYUM0YXBYbFl4VE9LNGdXVndRS1Bv?=
 =?utf-8?B?SkVCVlR1KzJRZXN0RTVSNHlwMzhhcElUQXZGcHR1Zld2MERTRy93WlJSeXhl?=
 =?utf-8?B?ZjNXTWlpVUVPNE1LU0lSTjhKWXV3a1FFNS9qOHp3ZkluYkNxaTl1SEx3L0p3?=
 =?utf-8?B?NHZyQXV5WkdGNnZoaEZqbkhHTFJOcStCTGhyTmRVVzl6M21XbnBDSC9leFFX?=
 =?utf-8?Q?MT7RvAhV7ts=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VkNhekRoNlNmamhwK1ZobExQa3pQK2VqN2JCdTZyaDY0SzhXUmFtWWlmdHZL?=
 =?utf-8?B?NG1acTlVNHlZTy9SeHlBSGNqRmxWWndzcEx3VjhGamY1a2Q0L1dmT2tvNUxL?=
 =?utf-8?B?aG5FaDZ4OUtHL01yUTZ3Vk05NHUzS2xxdUdyZDNWL1dFazRlK3h5OXlBQUIv?=
 =?utf-8?B?SC95QXVKc1A1bjRtWFJNYUF1UWZrOFRQc0JGd1dNYVNwQ0lPL2J3Y3hmQlIz?=
 =?utf-8?B?TENuaUc4NW80ZG9MU05jbmJWbllEV2EzTDlRQVEwZjFsOFREcytHajZRZXZH?=
 =?utf-8?B?NHpKQUNBenVSTDRSa1hqRkVxcnFzNlEwb2V2RktHcTFXL0dqWGp0aUZUSzVx?=
 =?utf-8?B?UWRRa2dBZloxWE5KRDQwc2FQd1BJeVhLaG5GT0ozR2hVdFlTa1RFdy92SnZN?=
 =?utf-8?B?N2Q1WUpqWEpWVU54OXAxRTFjZ3BhVkZJRDhKU1c5K2pDbDZYTk5jLzNuUlNh?=
 =?utf-8?B?MWpUSkNrMzZhQ3JadVk5UjluTTdMdDZkdmRwSFVUUHc1a3lTalFYdytudzFt?=
 =?utf-8?B?ZHk0RVE3c3VyUGg4Nm9URHZkUEV5TXZmUDNnMUVYUEtWOVB4eDB4U0VYbkg2?=
 =?utf-8?B?bk5OeS8rRG9UUkJWcERCV1ZKQXRFSVh1L0ZrNnlpZGgycEUvNlJ5ajRNMW1k?=
 =?utf-8?B?YmhxOUlqN1VlVUxSN2F0dzEvZUkxNFZXcUI4UnplMlNlTzZ6VmFDbGVNUEpm?=
 =?utf-8?B?UFNRc2Y5OGppUnV4SkFWRUc5dmovNHNSd2VhNjVvUmRNdWVhZHE0M3l4dGVL?=
 =?utf-8?B?MjViZFY4VnFvOHZ6aUZhblRnTVZGNWRpUUhiSXAyZE91cXF3dFZ4NVdUenhm?=
 =?utf-8?B?dXRINE9oRWl6aHAzUVVkNjgxNGtFK3l3SnVyYXNrTHBMczUwcC96SS9adkZm?=
 =?utf-8?B?ZHZzRVJObG5wYk9Ob0EwTC9NNFQ0dDZqaCtZYTRnZUlsMmJaSkMrNVl4RDgz?=
 =?utf-8?B?aGIveGRCTWZwWHd0WDcyWWNidit6bkJ2MWRjcytrOE9XMWx6SG1jckduQUdv?=
 =?utf-8?B?SWNkVlNnMjRmb0w4U3M4aWZOTjVCRWZrWThSNUdST3BoVllLS04vSVpIYWs0?=
 =?utf-8?B?VWp5K1BQZ202bTJYamU0d0N1WEJYdjlZV1VUNHpUeFNGc2lRQXRXSVhwczNj?=
 =?utf-8?B?N3ZNcHJ1aU9yYnEyS0tIQmhHWUt1YmlJNWRwUGhaNG5IalBNbzBaT0tlb2dT?=
 =?utf-8?B?Q05HblM0S2p1SnJTK3lXUDI5ME5aZUVBZzB5RHBVRHdiY29VbUFHRVUrN0F2?=
 =?utf-8?B?WUJCeW11aUxOVXZwTFM4NFFUQjZYaUwvVW5OeSszdml3MDFkWG8zOTJtelhP?=
 =?utf-8?B?RVBCUVVaOUVvQkpsTWJNT2VrQzNDWkpiRmt0aUs5TFZSLzZILzR3WkRQMElh?=
 =?utf-8?B?NWFISkJtbVVhQUpEWXplbUlHa0hQQk5IQXlodHJVSTR3c2c5bG5DWERzakM0?=
 =?utf-8?B?Y3NIbklIR2x4VWJoSXNnQXJpZ2Nwd1FRSXptUWJremFWQllNNDZFeFlHeFo1?=
 =?utf-8?B?Rlg2YnBDOXlZVWhGa1FJU0RDVUZmN0l0TzNkSkNsOG9oeVhTZTF0eGV4Yk1Y?=
 =?utf-8?B?VkcwN0t0RzlRQSt3ZHIwUTRoc0FMN0p1ZzVUaS9NQ2trQWdqa2tsZnRsOE5q?=
 =?utf-8?B?bkMwd1BNdjd2Q2kvV1FSK2lGTUNOaUNJVnlYTWZNZ1Y2RGttTU00Z2lZNWNI?=
 =?utf-8?B?eUxadXpoWUlNUkV1RDNzTHI2OVlvSmFDaUtmTkNhd3pTOGptaE5XdmJISEN2?=
 =?utf-8?B?Q1A3Zlhzb0IwbXZBUTQvM05lT3dSeEZlaGN2eXZKMlowcTkrblZPNW9YbEE1?=
 =?utf-8?B?YlgxUmQrOEljdTNwUm1SS05nb3NnU1p3MnJvamtXc0JZcXdjY3lHd3dIWGM2?=
 =?utf-8?B?dm05WSs0ZjFrQ1Uvc1pNZUZMSnpQWnhaMUZJVUdCaERSNmZUSit2Z0k5SUts?=
 =?utf-8?B?bjcyRHA3QXFFVW5Da0RHUE5SajgxRllWbkoza3lBbmFxNjdZKzJtUmlZN0g4?=
 =?utf-8?B?WktkVGZZTnRyVi9HRVpZY09xMk9HSGRsYjNicVFuczhsejZLQ09XYUszOGdy?=
 =?utf-8?B?bEJqeDU0QXlvQXI0cmFKRDk5M0h0YnpwYzdQODhZbU9EVC9NNVhrMTc0eitU?=
 =?utf-8?Q?/bai4gKteNwwdX3EfrtSUbELE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iGGaTUhi3XrzRDmoq1QTigPWiWof4KqvRgqbN+Q2FZZL0k8mMn7CZ3c5Mbxb3+A5/yp/XDG2O6jfaf6kYw1SK9gJwgDxp10Sz465gVALt7z0BgyvXfTjhezHV00HAtCoNIsc6xW80vWYQcZ8m8D9OraRZmLywg66wY61GtUKlQJdLn9pO7g82Z0z+KrIqhYYBcvbeyd5e9bzYGvybKbzxKjlafOsnsrs25Hk3q73H2d1iWI410CXaVQvgds0KCyhjIftoB9XTMjgT/oTvjgmnBX9Mdg/ITozAtkc4cVYlIuTwXoJ1Nd+MC2VrTUxtUcs+lUQQuotgcQfi7aGV+6llp+8aY546v1eF0M0tH9VV3j9LKJ5BV1v2ueEumSOByCGslhVx/dEc606Y/+DuIg4QCmI3R+1zY0ggd3Bisdf0/QueObnRBWzb4eeEGUr3+8D3dQ02AtYeEYpHcNmQcFk+QMxdYn14dLAQ+LCiskZ8dQ3yyGjgfPUAe0Kd0eMqvCgfqssrLlZM/9tiFm7Nbn9avMi1vogV9ysGx441p6WcNEuN7JphVy4X8op77hxAtDJxptC8fWZLB1C2Rl7/OxxUgvaUyUqZruUtp/7Uo9XqxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ded07ea-73f4-46a9-42cc-08ddd13d5aa3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 20:52:40.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdVPqURucz02KGzNukTVAdVugDdF0jIcKm8CmCtgT5hSH9bEiFLMRx4OC01sdM1FBY32XLQB9gZFpaprSGue7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010166
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688d291d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=0eZ10gKNtp0vlpWCN-MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0PiRQb9xDPxouT2fZCzba_YIeKeDyzLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE2NiBTYWx0ZWRfX6nk8B/iOqP+V
 SavvxhTjmaRiBjyYGMukSpx5+Uw51SO14vgeEYEd5oz5zkWZBfuR3vW4JVx4S6bvsalNAY1Niob
 8oJPPoFtQUSTUqjXt6xtG/DVPVmYQA2VRT7UQRD+e4J/GY1FkCFtFancHgDXBxt7jjL1sT7Va7J
 PLRVNLDwkmzlTyOiZFpEJ91DAkCMZg631WNn5y96Y7D0FB1ufLzdyGzHNDgxgh5s/1p7xcIS4uh
 GIGNWkBPWjlboaKyGpXEIV3cJFB10cX9ShNGQSSNpMLX9zZlWnoHsJYQT1njxHx8anhBB2rrDpU
 Vv0t5jzD6EDaFdrPEi2TO0xe9gvuX1hPKg5RejCjV5cJ3oVAbeK3Yog3PSOKBQ7vSZKwwvxUwWT
 r8yGTESxYHAdfBLXQEhSpO9qHauNnEumT+xMbxVuK1SxG67Zv2W2NebPbmfk3cypalp4Fx3N
X-Proofpoint-ORIG-GUID: 0PiRQb9xDPxouT2fZCzba_YIeKeDyzLN

On 7/31/25 7:06 PM, Mike Snitzer wrote:
> Refactor nfsd_vfs_write() to support splitting a WRITE into parts
> (which will be either misaligned or DIO-aligned).  Doing so in a
> preliminary commit just allows for indentation and slight
> transformation to be more easily understood and reviewed.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 45 +++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 35c29b8ade9c3..edac73349da0f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1341,7 +1341,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct super_block	*sb = file_inode(file)->i_sb;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
> -	struct iov_iter		iter;
>  	errseq_t		since;
>  	__be32			nfserr;
>  	int			host_err;
> @@ -1349,6 +1348,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	unsigned int		pflags = current->flags;
>  	bool			restore_flags = false;
>  	unsigned int		nvecs;
> +	struct iov_iter		iter_stack[1];
> +	struct iov_iter		*iter = iter_stack;
> +	unsigned int		n_iters = 0;
>  
>  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>  
> @@ -1378,14 +1380,15 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +	n_iters++;
>  
>  	switch (nfsd_io_cache_write) {
>  	case NFSD_IO_DIRECT:
>  		/* direct I/O must be aligned to device logical sector size */
>  		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
>  		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
> -		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
> +		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
>  					nf->nf_dio_offset_align - 1))
>  			kiocb.ki_flags = IOCB_DIRECT;
>  		break;
> @@ -1399,22 +1402,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> -	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
> -	if (host_err < 0) {
> -		commit_reset_write_verifier(nn, rqstp, host_err);
> -		goto out_nfserr;
> -	}
> -	*cnt = host_err;
> -	nfsd_stats_io_write_add(nn, exp, *cnt);
> -	fsnotify_modify(file);
> -	host_err = filemap_check_wb_err(file->f_mapping, since);
> -	if (host_err < 0)
> -		goto out_nfserr;
> -
> -	if (stable && fhp->fh_use_wgather) {
> -		host_err = wait_for_concurrent_writes(file);
> -		if (host_err < 0)
> +	*cnt = 0;
> +	for (int i = 0; i < n_iters; i++) {
> +		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
> +		if (host_err < 0) {
>  			commit_reset_write_verifier(nn, rqstp, host_err);
> +			goto out_nfserr;
> +		}

Does this loop wait after each iter is written? Would it be better to
wait once after all the iters have been written?


> +		*cnt += host_err;
> +		nfsd_stats_io_write_add(nn, exp, host_err);
> +
> +		fsnotify_modify(file);
> +		host_err = filemap_check_wb_err(file->f_mapping, since);
> +		if (host_err < 0)
> +			goto out_nfserr;
> +
> +		if (stable && fhp->fh_use_wgather) {
> +			host_err = wait_for_concurrent_writes(file);
> +			if (host_err < 0) {
> +				commit_reset_write_verifier(nn, rqstp, host_err);
> +				goto out_nfserr;
> +			}
> +		}
>  	}
>  
>  out_nfserr:



-- 
Chuck Lever

