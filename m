Return-Path: <linux-nfs+bounces-10940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61AA74A07
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 13:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA09C3BE0F1
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254ADC2F2;
	Fri, 28 Mar 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RbY7mthe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VtBqyvoo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757542048
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165835; cv=fail; b=jYqnBqFBlGKGlBUyFVGKgiYgB9gSjLrWKoOGfDX+u8tk7I+gdoqGZAazuYgZZ27Yc1VSJ+jNuue+SdmU0+BoNdIGNztTAvBDt7nO9oVUVDqOyrZHViSGrvYC2Ay7xPQIUbOIeytUKiLo4YrJs04wf0iwZcvA/h5B91Dyb4C6hm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165835; c=relaxed/simple;
	bh=WtNHuu2Gxeimf0+p/4vPtMtylCH8IRnkeqrIjn+XNdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyhfKezIQ7z6qCaHHoz2REodP5PZSge6WAIfNL0mfMPus5NvJFYsinELPJ0BwMVTEsQ64S/oO4+rG7RndJrvWN+VCOzJUWZBi202cbeBc+f+FEo4NZ7ytFE7knZL5HE912mDVYHopnwhGzclcQZY5d1HCTtVlbS+RGwKtaps93E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RbY7mthe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VtBqyvoo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0v3sU015255;
	Fri, 28 Mar 2025 12:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oZbmkT2M5oXqi50r2uOAX51hI3sQm/Fc1zfTzxTE534=; b=
	RbY7mtheCSui/YDQR1EC6NnMQ1vbC9BAxBXQl5cDSVFkLn7A1Z7aeWz194KsTk3M
	cowxwUyYIVnLaeIDy6YOXII4X30qx7h6N0g7zgzZs70H2hPHsaEDmE/g30ZfT5jJ
	8ktR7mmy9dIh9Xbx1gzyJRMfNEfU5c1z6EV7K7d1vrt5v5dE09f78lDBfEWxBPrV
	+N5wFTBRs06/0dUy3rv4NG/IYn0EYz+uWYvA84aWgVPUOdx6A1/e7/aZqhcGBL+N
	k4HSurC1u3MKZaEteJQbJpYV7RdlSCMVPXZufJRnvQhE6uWJqnSh8fRCX4o6iyh1
	VpjfKaI8wNb8KS5TKnJ37g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45mqftc93t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 12:43:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SAgvtD015174;
	Fri, 28 Mar 2025 12:43:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj9686tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 12:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/ldL2HVGxDoHL40o7Gclf8bVkDRgRWvkCEx4k+CbL3MBSu1b8DXOf4JUPxgoTXU4QCrlq7hGXIFfE3HnCX0LXhd2GPP608Hz3YpbiTAVn4C8GYQxnnYmjcX7SydElxUjkQVPGIBXlPY++Xm9irXtOLSn2VJ3EAE20Ku9gwt7XPAWeP7SQ5n32VTH5gXLCFJfahUk+R9cPQhVC+RLsKSUPSACYSwGgZ+dgPSqLp0pKzVDLmnMXmjhOI25bXXiXrCEtGh6pbSIBcVaCF8lKrylXvjdZnvcEf0lqtUausVakO0VH8+5fIl1xASkPQnkdsaIuWTo6r4jX/CXVurkYWReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZbmkT2M5oXqi50r2uOAX51hI3sQm/Fc1zfTzxTE534=;
 b=GM+7aS6puHPu7CtM37mREgmubk7HER6BBH+wy/xLc5GCzCsO+FNN5Ia2MiZxD1uzXBxTrBMtpr7j7UdN7d3CYB4Y/74WIb5t50NVH+D211wvkZ5/J9ovb5K6iMtsXH0yD08GrzkHk6AtOtlQ7Jf53GBtvsv6KOAkz16pTuk25codM36mv6o0pWGR6GSoZBgt7Jgy4dl2LbErM7T/0Bv3BhIl9M0i8CPF/fyenl662eZ7uoOmFxvOeQcal0+w336Pi7HGuhw32EbjnC02Z9oFRQJ1CQtq29rjq97KqMg1sZ/vHBhIWiVVFVxM4Vilzd9lSTmcZoFASm2p5+QJI0kRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZbmkT2M5oXqi50r2uOAX51hI3sQm/Fc1zfTzxTE534=;
 b=VtBqyvooFOKH2JIuhO/5hp+3X3xrk51ZAaogyce+UrrPP2R1FiY+HZTqkWN+N4gobQl9hfOWKP45E2aq34XkGHlx72wHlGxJGhkwYAW09FXzS7GYBOcMfdzg/zLBououS5uoWRljoFCUXC7/ag2exW6fGnmZnZkLGjZiGrMa8Ao=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7816.namprd10.prod.outlook.com (2603:10b6:806:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 12:43:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8583.027; Fri, 28 Mar 2025
 12:43:09 +0000
Message-ID: <569682f5-f93b-423a-b87a-2879e269b2cb@oracle.com>
Date: Fri, 28 Mar 2025 08:43:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
To: NeilBrown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <>
 <CACSpFtAj1TxzsMfxuSttA0_tqAZ2FZR69DuL5i-xK6bvMbtc_w@mail.gmail.com>
 <174312619109.9342.16173648063480052169@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174312619109.9342.16173648063480052169@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:610:e6::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c6316e-5671-4a58-32d0-08dd6df61805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFMvQWVXRlp0cHRUWUxTMmtSN2QrMFVvTGRJb0RSdHFQVk9hZlVKa0VRZkF5?=
 =?utf-8?B?d3M5NVhFVkdrcXdnd0VnamZsUkJnMWlhUE9tUFEzV25WN3FNYjlDQWlJcCth?=
 =?utf-8?B?UCtBMGJJR3dtQ3VnbEpoRlNjeVZMNUhpN0dvV1pKS3NabWJUaHl5S3hoRTRs?=
 =?utf-8?B?VEY0SHp1bnpnWkZ0TE5EeU53OHNERUJRWW5zY1paSFBWY0ZicTdSbEs4MFJ2?=
 =?utf-8?B?dmFXUDlmUTJrU1lHNDBzUy9wTUQ0c1E3OVFNUzM4RzdORnZUendWdTFoNFd5?=
 =?utf-8?B?bFcxYU9zZUN6dUU1S2FpcGxxZFp2TlYzOEYrTzFmV2Q5VFpZdGJyUVprQUpD?=
 =?utf-8?B?TzNjVjRtcEJ4VExYc2Exc0pnRHdHcHAyQjV2TzMxeTRWMTN2dFIvUVp1QkZ2?=
 =?utf-8?B?bmc4anQwcjdEOEhlYUZqUjU1bjM4akYzUGRLRHcwU0pCeWhhZy8xcXMwazFR?=
 =?utf-8?B?UVZWek5XdnF3OU1jWkNyMVExZmhiR1I4dE9YcXZRZEduRE1IcVhablczOWQy?=
 =?utf-8?B?RUZuRVYxanlsMHhkaDlmeHRnOGF2R1E5T2lJM29XWUtJSFhkck5JM3ZWWDMz?=
 =?utf-8?B?Z3pMaTVZZ2dYVDZ4b1hOQyticDFZNFpTWkQxWCtScE5KZUpKb09haERIREtZ?=
 =?utf-8?B?d0I0NkdvL0tSRzdSM0JsUXl5S3VtdmxGdzdQbTNSaEZaSll3dm83TkQrS0U4?=
 =?utf-8?B?NE1NNHNhVEl5YzRSbkw5MUl1eUFpZFM0MzBRVzFnT01LWW1oNzg2MnpyRExS?=
 =?utf-8?B?RENkbEZIbE5DYWVxMG56RlBsR2tISEdSWitWdkFwSGFtbjdRV0hoQlZlYUxL?=
 =?utf-8?B?a2w4aWl1R3hYQ05HNE9NM0lpckpyRGlPb0xFdlFZNFJTSjQyNlljckFXYTZU?=
 =?utf-8?B?Yjhla2M1WHYrRTdTMEhDNFRoSmlOVW5CenFmcVgrcTV6Y2pqT3BTNVRXYXB0?=
 =?utf-8?B?dzJlL0k2NVBHaXFGZEx0d0N0VXYwUk1CeHNTN01VZldCdlBnWGdkaXdLZEJW?=
 =?utf-8?B?VyszWXV3Um55OGZmWEF3U3hRdENjaUhKd3V5SVpPaTVqQmtBL1ZWYjY3SU0v?=
 =?utf-8?B?RE1Dc1dFbGlzOWZ4RWltM1VnUTZkaEtPNVpobXRYYjN6Sm5kUUhFMTMvNFNE?=
 =?utf-8?B?dDBtWklZL1ZNUnZ6dzNYYVcyc0hGTlY1eGR2VEhJckFZRGFmYmkvTVRjd0cx?=
 =?utf-8?B?UGFNSmlRQkp5MFFwN1YvaUdDQnUxM1VWNkJPOTBNVUJLSmhkYUtBZVJUMlpE?=
 =?utf-8?B?YTcyd0VtNngvZUR2dHc2bjA5ek80d21McmRsQmdhS2FBbHJoZmxmamFIMDhk?=
 =?utf-8?B?NkhiTjN0dUduMGJDUHNtZjREUXVGZ2FsV3IrdTltNEV0d3gycmlGZ0hOTUg1?=
 =?utf-8?B?cHkrZTdHcUN1cC8yYmt0em1CeUVuVVdzTzVYT3ZUSzNvVVI3NFJ1R3MrS0ZC?=
 =?utf-8?B?TWIzSXBTMHZoQUhtSS9UNy94T2YrQlBYVENlVWFWMklSOXNicHcyeXhUbzN6?=
 =?utf-8?B?RjJCUzdvMTZKcHM5VzdrOENpOTgxMkFCY1dlOXRrRFNUQ0pHU2tNdjgwaHI2?=
 =?utf-8?B?OFN3ckNmbXFyamFyT2lDWG0wVytEOEl5eitHNStmQWdWcFRMamdLRUQ4WllQ?=
 =?utf-8?B?K21ldVNtWTdtaC9aZWtOZDhtcnU3SVVJeTdOYUhqbEcrdTBsUGF6YnVidzJm?=
 =?utf-8?B?cUVqT0x1YUxPMDNmQkFmZHN6RWhWVE8wREY0SUFoM2pFK3EvMFZtNDFEMDM4?=
 =?utf-8?B?RFhsNDZ2dDZSbWRPb3dFSTNzTjJrL0d4TUJXY2tPVE8yajJGS2xWaGtQZkZx?=
 =?utf-8?B?Y3lmWjdOcHZ5ZlQyVEV4TEk2RW9FeWNvbm53dnBBTURJcTVmZlZDOFBHRWVY?=
 =?utf-8?Q?lRdEIHbCcpNv+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVl4WUVERlF1VThWeXIzNWRiMERkYVF5NkZ0NkhyMDdBTVVRZkdyYTdMVFRM?=
 =?utf-8?B?emNVQUdiOUFEaFBYM1k5Ukl2U3B3QjdCOHBzZ0FWbmh4ejNZcSt5VmhaZ0dw?=
 =?utf-8?B?ME52Ulp3MW9DZjQvb2lZNXRRQnE0cjdIbWJuaG1jdTdzVkZqYStVdzVGSCtj?=
 =?utf-8?B?UHF1anU1SXZoM1FscS9VZVI0Z04reVFGMTBqRlBZRDdNQnNGQjlHSjUwbUpn?=
 =?utf-8?B?TUQ0VzkzdmlQeHJ2UFRLWk5JR0Yrb3VUMzlmdGR2NFpqOSthbnNyUDRuQktn?=
 =?utf-8?B?RjhtR1JFSVpzV1pUdWV0RkV2eDN6ajkwSlVDWU94aWRCdHNqWndRbkNEOFFo?=
 =?utf-8?B?dGliZXhEQlpqOXkzSDhuK2VDZGNwRmw2bDduZ2pVemZpTkZENHByandUcFVh?=
 =?utf-8?B?blBCNGtGWHRiVGNiMyt0V2dZWEZ3SzE4cEk5d3owVEFqMElFemlmOVZhTjk4?=
 =?utf-8?B?NVAyOU1aa29PeHdpWk9nK2lvQ1YwNWVNbHc1eUQ0dFVUWWVhRy9Xc3BqMXUx?=
 =?utf-8?B?NWRKZFFrOXV6YWR1NndaRk9tYTRidnNTY3c3TFU2Smxnb3V1dFVXZVJaWmFl?=
 =?utf-8?B?S0g3ZkM3RGtGL3RFUzAycjZNWXJLazh5SEVuOTBzRUZQNERUVU1wdHRVSmh4?=
 =?utf-8?B?dDNxc05mTGxvSWZMNkxaekg0Z2pzSlc4QnRmZTlTNU1MWjRzUXp2ZjVqd01I?=
 =?utf-8?B?eUVwMjRJTkFXS3dBdkZOZ05ZZlRHQmIweGd0TU9xNUFvdG5UeDUrTWZRZUJH?=
 =?utf-8?B?SUNwNG1BcTZ6TE9uOHhyaEdiR2xNS2VkQWNia3U0N3BYaVpyM3k5MncwV1Zn?=
 =?utf-8?B?Q3h2c3ZZc29Fc1ovWFV3WktiRTlPOGlpNEVZR1VRbmlETW1vYXY4a0M1ejBJ?=
 =?utf-8?B?VEpUNENyL0svWU9Dd0dtZGZCZFRXbk01QlI4UmFzdnZiUGFSVkFPMGJOTE00?=
 =?utf-8?B?T1ZvTWI1U0V2SlI4UkVBRHhYOXlTdkQvUW5XaXNLUUtmRmJLNlg4Rmx5SklO?=
 =?utf-8?B?K0ZFRE5LeWtqY3VicXZ1RG92cnNMZUJGSU53UEtQWlJEK2twRkRQVG9jQ2Fh?=
 =?utf-8?B?SU1WQmpjSG4wUHoyOE11andwNFdjUXNVZHpWajlnK0h2L0lCTEYyRW1GMUVh?=
 =?utf-8?B?L0FmcVpWRmJURUxGYmdpRU1DTFdnaUsvMm82bjU0TEVjSGdaeW90VTh1S2J4?=
 =?utf-8?B?YWdwTjlzdUN3c09ZdUxzT3dGVm1yUUpqZkY0eTNya2xXQUV1L1AxNXl6MTdj?=
 =?utf-8?B?Z2ZoTzZmVDc2TG1zTzAxZ09oSDVaZ0lhd2JvZFZQN0dUclpGd29PY0hNYTY0?=
 =?utf-8?B?RmJxU2tiVjYrZUx4RVlNcGFKenFhRUpUM0xiUGVVOFhhVTZCcUgxQnVpZDBO?=
 =?utf-8?B?WmlGc01WQ3lqWVNXT2ZvSWRlNXJRU09rODdPNVh4S0JrWTdiSmY5OGh5ZHBZ?=
 =?utf-8?B?d2pBd1VNemR0RG9aZzZVVHdPc1NhdlcyYXg1cEdCMGI3UG5jWEM4YmNCUjIy?=
 =?utf-8?B?ckhKcWR3K25iVXNISitJNkpPODQ2WHFBUUhwNW16Wjg0QkF0MzdWeERkRDgy?=
 =?utf-8?B?UDA3MlFhamFJc2kvNUFsTnBkby9LbHV6RWtGRTBQb3hiUTB3Vm5uOWdzUXZU?=
 =?utf-8?B?bjB6SzlRTDVRN0RZOTdsY0NqUlZZRlp4c2c4NmoxeVRQY09zeTIydnZnMGFW?=
 =?utf-8?B?MHJhM0tNUVFOOGdIMEp2VEVoL0RwMkdmK1BKT09ZMnBMZGViZlNPK2E0bnFh?=
 =?utf-8?B?SjFzVlhuVVgzY1M2Z3laRVh6c1BZck5QZGNDV0tobGhKT1pIQzAvSGRxcXlr?=
 =?utf-8?B?dTVFd1F5UmpTU0R0UG1GaVA2UmtvbU1zNGtpMVhRVXJFOEVSTEQxQ3RiT25y?=
 =?utf-8?B?SHVVV0ZreHIramsvbGdlTHJBcE1jWEtRZVh6UU9HWHEwVXlVNWwzRWFMcFd0?=
 =?utf-8?B?Z2ZHTzhvbkpKUGJDYjhVNUN3UUxCTWdoeGU2bDlsSHZkNjdZdFZUQW9rM1ZQ?=
 =?utf-8?B?MEN6VmRzTmJxUW5Gc1ovMUl4cEh3NXE2SE9HRmhHOU5MYzFvMlBVNXdvbW0x?=
 =?utf-8?B?Uk1aU1JFTW54b1B4elhydjNzZ2xnVzEzeVEzdkU5YmR1Tld1Z3lJQlVneE9Y?=
 =?utf-8?Q?65e/0GNXdT44V2jn/Nrh5IP2y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iwsrGNbRaPt8d7Bg1eRXp8OLK/NcB1PheKSZWVbQ++PLXEOKwFP1LAugJnh5MbK+JSItMO2DxOXEuJD7nsiXUtnx6nlOu+TeRH0BKsvVU5a7jr6dW84IOxzvBD5uQTLJOjC3DOL7IwTcmSpHdOsVLxxAl/8y6n9W6YCumZ18vyYakY4erQK4Hi4uYqwLp7EURd5zHqrPdrXfJcdIEn6GFgAeA6aX5+sMANjREkNZCMolZsCI/Vk19BwkS318zu51jj5s0vV9YU7EZ6+af5KhoCLdkjNIorAYmP3aFZNoekPkgnFUxKmJAN3+Mx4LF1DRZ+FfGV/iIB/U3ZNdID33fReHSxaGsfNwoNIhkWs7/0281qa2a+Kgoc/Ht79c+OQf1Ns1D0REjpzL5lu86wV3P4R/G4gzHpv5eBp0y1QGNBsY0njiCqPZ+4u899ezZxmRLayzQc+FcOKCVBf9/tfR8TpvyakHRLi8xcg2i8NnAeBdo2lmEflUsih+9SUk9M7wd6clwGTdhhWU7eJKWRTxTZZZbQM8Iv7tGMdIOrOfcKpoXTl7c8I6EPkIC+zad4KGE9AiRJv+iCaxJ2l7wWCedWSSmBzoYSihMxY7miiTnd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6316e-5671-4a58-32d0-08dd6df61805
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 12:43:09.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhCTLpUr2NDFMZiVKikA6odGbqa7ARxrEgiaQ39XnU8vernsgr0350HhN70Gg42vu6pq69aZxJSNF7JY1YPsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280088
X-Proofpoint-GUID: IaQO6Ze_gJSL-Ab35rRPF9zoX8dmaPFm
X-Proofpoint-ORIG-GUID: IaQO6Ze_gJSL-Ab35rRPF9zoX8dmaPFm

On 3/27/25 9:43 PM, NeilBrown wrote:
> On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
>> On Thu, Mar 27, 2025 at 7:54 PM NeilBrown <neilb@suse.de> wrote:
>>>
>>> On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
>>>> NLM locking calls need to pass thru file permission checking
>>>> and for that prior to calling inode_permission() we need
>>>> to set appropriate access mask.
>>>>
>>>> Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>  fs/nfsd/vfs.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index 4021b047eb18..7928ae21509f 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>>>       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>>>>               return nfserr_perm;
>>>>
>>>> +     /*
>>>> +      * For the purpose of permission checking of NLM requests,
>>>> +      * the locker must have READ access or own the file
>>>> +      */
>>>> +     if (acc & NFSD_MAY_NLM)
>>>> +             acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>>> +
>>>
>>> I don't agree with this change.
>>> The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is also
>>> set.  So that part of the change adds no value.
>>>
>>> This change only affects the case where a write lock is being requested.
>>> In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
>>> This change will set NFSD_MAY_READ.  Is that really needed?
>>>
>>> Can you please describe the particular problem you saw that is fixed by
>>> this patch?  If there is a problem and we do need to add NFSD_MAY_READ,
>>> then I would rather it were done in nlm_fopen().
>>
>> set export policy with (sec=krb5:...) then mount with sec=krb5,vers=3,
>> then ask for an exclusive flock(), it would fail.
>>
>> The reason it fails is because nlm_fopen() translates lock to open
>> with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
>> acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
>> inode_permission(). The patch changed it and lead to lock no longer
>> being given out with sec=krb5 policy.
> 
> And do you have WRITE access to the file?
> 
> check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
> granted the file must be open for FMODE_WRITE.
> So when an exclusive lock request arrives via NLM, nlm_lookup_file()
> calls nlm_do_fopen() with a mode of O_WRONLY and that causes
> nfsd_permission() to check that the caller has write access to the file.
> 
> So if you are trying to get an exclusive lock to a file that you don't
> have write access to, then it should fail.
> If, however, you do have write access to the file - I cannot see why
> asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.

A little context:

3/3 partially reverts 4cc9b9f2bf4d. Setting exactly READ / OVERRIDE for
NLM requests is what nfsd_permission() had done for many years before
4cc9b9f2bf4d. Thus I regard this as a safe thing to do at the moment.

I agree, however, that it is mysterious why that should work at all, and
I'm fine with holding off on 3/3 until we have a clearer RCA.

Initially I thought changing nlm_fopen() would be a better approach,
but I think there are other consumers of the MAY flags set by
nlm_fopen() that could be impacted by such a change.


> NeilBrown
> 
> 
>>
>>
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>>       /*
>>>>        * The file owner always gets access permission for accesses that
>>>>        * would normally be checked at open time. This is to make
>>>> --
>>>> 2.47.1
>>>>
>>>>
>>>
>>
>>
> 


-- 
Chuck Lever

