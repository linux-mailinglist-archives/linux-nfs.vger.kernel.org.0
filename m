Return-Path: <linux-nfs+bounces-18586-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEwjMWZgemkc5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18586-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 20:15:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B0A8194
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 20:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E7330401BC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BA1D5CC9;
	Wed, 28 Jan 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TnpoSFeY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07142D0C98
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627722; cv=fail; b=E9OTM874KCNsQIO+kmIqcf1oxGzOtyuV1J1VUpc1hyjD0GH9gfY7XLtWEbQEVd58JaXpG0Ei0gdf73hRX/OxrcaevZFe9pkOUx3BuZjwOQceaH0c8QtUmw202qDktXMsdvuC/EL0NDYGz3kgEklLZ2Bi7sMpTBqxDJINg2Bs8HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627722; c=relaxed/simple;
	bh=D+8vm1GXgdC7fhnzDvgiBC19YsUkogdRjzgi3alesTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxowMtNDvaPDcVfdj3VvzrEpp9GWC559+VxkFidzxU/386nVNheQqgmxXCEM43MgkIxW648voOapPv3TStM9cxfKo33D+NL1jxFstoviryndcJgl0zitCgysT7Eh1CCgMntVQogUS/GbVDavB7DCQqx77BL2gfH6PBrVWAXIbHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TnpoSFeY; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SJF9uv1031872;
	Wed, 28 Jan 2026 11:15:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=TWcedb+rmRChS/aMrhnSVMuuIdUJ1womA+d1HzTbi90=; b=TnpoSFeYCG/F
	R2oGLaXJGifIHkdZupa7FpI5ZZG7MyepdW3Xf7AH8rVr6D5QcFh5Zwfe1t8V9THP
	/11lwOh8bexOFyMtBk4qNi6j+NefksWnMZxVPJ1T9pmGqmQG8ZMH5Vec6lixE2+v
	zyxOeZqSZhRLPNFu/2+wW/+qJUoIpJyE96mFOzDS4TWF/RUkvQCKEqZhY2EzsS8D
	O9GVnUo5i20f/vyITrB6jFGb3QhF+NaG8lhnAoupfX0svJzu1iI5s7u4v3FVaxVa
	Ul1xB5+ZAfsp8UKzFdHE3F2c/pJCVd3PM+o4kEdm7eNBIfsFZHRQqh9hkX0huFuo
	U6O9Xs6jCw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4byn372w2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 11:15:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAeX4I+2h8bFhdWs8qSoBB4L96VBsrnHF/Zoxufp1tvwTGvVTm+0qhEbi2jBHieW3sl5YH+YupQqDRX3CrTg7ukY0dXtDd5yzaElujUoRj7fZFrM6VjhX0+FftAtTpjNcc7B5aVt4RuTKBJhpbZ0C7Z8txv5p2R28qhQq99iI66ZjB41WBgY1mD4O+/qMlsgZ4KLFgbN9+1onl17+OA/h4epJBnFhOVTQrENX+UA4gpWYrV8IXP3JfMUPrFW6Oc9krxHI+qKxDGnwP1VC8tTtQclF5RJ+k5xzjlcXYjp5YqHxJi6ewAiyMPcEIYhZmEEHVJnP44iit94bI42eohBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWcedb+rmRChS/aMrhnSVMuuIdUJ1womA+d1HzTbi90=;
 b=RClpdsy8pr9XRvBzEu2vXRlzj7EjSrzGmnVz4GjxAbk1fvNv870vySqf4CNdRcJTDRp2nepy/cwlWRJ0/sEBCP1jA7bySipDN2Xp78w8P8oHJkC5wtklHNvcQ+kJXdm33R4t1GFuvBU8GLKueQV3r6T2OaOL95c7aKKW6ruSA5Kuu8x6XUP6NcJ4MSZo2Kpr6b7E3KaA9yG3mt2oafOthoyXkpTNA66Bi75UYY7vTOOVMrzDRU/4Lwuuqs40AchJwU/BAyoMKsq+v9CSHN8suljzw5SFUSsLt14WiLVbuzY+4FSbDQc/acx64ojEX8Egfjarcr9b6PMas4dXcTKurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4337.namprd15.prod.outlook.com (2603:10b6:806:1ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 19:15:12 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 19:15:11 +0000
Message-ID: <d002c245-e002-4eec-88dd-4203c34b1289@meta.com>
Date: Wed, 28 Jan 2026 14:15:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: delayed delegation return handling fix
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20260128044706.556046-1-hch@lst.de>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20260128044706.556046-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d0e4ea-9bd1-4ff0-7ab4-08de5ea18f12
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTh0R05waWVIREJZNUVhU1ZaN3JnUmJiendTOHljMU00Slp3L05HTEtmMnFu?=
 =?utf-8?B?SS9vK1FHSm9wcldoaVJnVmk1WWFPbGdLL2F4YTJQMER1TktyOXNldml6c1lT?=
 =?utf-8?B?MTlZMndHYmhPWGVpUWNib0JBeGNyTy9GaUdQMnhuVEVMN3A5MXNnT2tLZDA1?=
 =?utf-8?B?Q1ZUNUFiaFRDZDBmZUVrWGtPTEQxN2xwZkJGRmRXMmJDZGllWENRSFoyeDVU?=
 =?utf-8?B?czgxSHp1S3IxUHV6dHVwb2hkaDVZdjJjSmRobkZNSXo3bk0rRHpId2NnQVlY?=
 =?utf-8?B?ZW9hQUdUcEZNNGpQcVoxb0xhR0JzM0NoRW45Y3hobkNvRC9RSll5Tml6WURP?=
 =?utf-8?B?UTV1TGc1VHBxczBkaDBVekxKd1NIdk5CVkFWUE16NHA1QVhhbzA0b25BSk9T?=
 =?utf-8?B?c25zWnI2OHFaaG9WOE1EeHhSaTRNRERWVWFURXp0Z05jVHp2L3B4N1UzTWUy?=
 =?utf-8?B?NGtsNmxRK3hTTEFmTFhtQkNkMXNqRlZaTE0rNzlsWXYzVlRpeW5acHo0MXZP?=
 =?utf-8?B?NWpja2wvODVCVktzVlJpWVhjZG5HUkwzaUU5d1BCNUxTSy9aQks1OWt6bEhH?=
 =?utf-8?B?QUpBK2w4K0o4NWNOK3JRTUtPb0tNQjlWNEZIdXdsM3hoUHJYSG5iOCtPcUg3?=
 =?utf-8?B?b25YR0NuNHZlSng0MnRRV2xwajBHYmtOYjRaMnJ3NnkxY2wybEhQb0VBcVdj?=
 =?utf-8?B?bVVOZGFZSy9OL3pSYUh0YjdJSG5vaEpaM0p4K0JKb3NOWGJwMTVBZnhGOXha?=
 =?utf-8?B?dk9NcXdWWnNVRWRSZ3lJU3Y3WFJvVVJaOEtQNjRFT1FKY2QrZnpFaWpmdnd0?=
 =?utf-8?B?SVM3SmtkVmhxRDA3MVdzOFpUQmpXWkkyclRhR0Raa2dhZnIwVmh6eGRraVN2?=
 =?utf-8?B?aTBJT2lHN2V6ZnpTL29ONHNuS0RJdFRDYldyRVNya3FDd1RqbDBwcTF4aVJF?=
 =?utf-8?B?ZGpXWVdid3E0ZEpPT0ZzUDlhV25aZjB2LzFlZWIyTmJhRndOTWRGT2ErVEZ4?=
 =?utf-8?B?WDVUbVVsVFptTXhjTmt3WEROMWZSajhoNHkweERJQUNseCswRVcwSjR3bFRy?=
 =?utf-8?B?YVFmRVNTMGh4MG1aMThwYXM1bVBoVVl4UzNYelFCOGpZRHpJMlNIblZCNFZC?=
 =?utf-8?B?amcvUXJsYjlHT3FoU09heko4Sm0reERLd2tabU0zbUNNY2hXSnhISFdVOW9E?=
 =?utf-8?B?cnVsNlFFYjdtWTk4WlBVVGlvN2tkTmRwSXJIOVZTWlBSRkxIRC95N2VFQmV1?=
 =?utf-8?B?QVZjaVp5My9yblVLVnpFUlUwVFVhNHlEZXlmTGNreWkra3FuRGF4QjlUMndr?=
 =?utf-8?B?ZW9RS2lFWjBHektOMU9uNEFkbktMWUFIVms3QkptM3N2emtVUENtNi9RTEpU?=
 =?utf-8?B?OHcxTVZndHcyb0NEZzVYTW4wd0ZEb0puSmNZZ3c4S1NmU0NMbDAvTmR3NXZk?=
 =?utf-8?B?andmdDNnejlhMEdva0pyZS9zZXRMUHhjbXRtVCtRRjJmVU83dTZyU3lmL1Iy?=
 =?utf-8?B?RWJ4RndZZWk1VEZVVTR3Y1VoN3FoQ0h0eS8xZUo5TUdhZ0FnV0pKOGhRNFU0?=
 =?utf-8?B?WkJMQTI3U09Dd3hKenNnSXpNZFMvRGFiSnFGY1RGYXVKc2t0dFM3Y0RhRFd4?=
 =?utf-8?B?Zi8rL25xMXNXTFY0SFBhclhxWnJ1dnFTNVVERDlmaitMVFZNMkw4cWpOOG9Q?=
 =?utf-8?B?TjFWK01teVlUSGxiNy9lM2NqamFuQThWc3prMkg2OEUyMHFYSldNUzNPSXRj?=
 =?utf-8?B?ZUdReGczZUxiaFRQQU51d3J3YU9DL0x4ZXk1aHlsVVhCNHVuRkRXYm5acCt4?=
 =?utf-8?B?Smd2WTAxa0xubVQ0bWZRN1ZsOEs5QS92UUdPanovaTVtWTNpejlGUFJtd0Za?=
 =?utf-8?B?dmRVOTV0dU0rSFZFN052WkZncldLbHJESU0zd2xnUXk3U2VyUStxdDg2SG1J?=
 =?utf-8?B?R1ZYTjZnSHZhRkUwc1h1TVZVelR0SXNjSG5CS1ViY2EwTTdKdW8xUU1xUkg3?=
 =?utf-8?B?ZlgrY0IrTW5Pbi91WmowcHgwbndlbDIrTVJDNVNUd2kwdjVvVEdlbmZibnJS?=
 =?utf-8?B?YzRzaWhpMDA4Vm1tQkZERWZDUjNEKzR5U3l5NHVpQXRoeWwvcGR6dEJWL1lX?=
 =?utf-8?Q?bwI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBCUUNlQWFKMjVxUjRIMFRYT1d2amIwMGhoOTVnQ2htRUk3Qm5XMFJWQWxp?=
 =?utf-8?B?aVdEOGlJMkZhLzQ2WDVZM0NiRWZyUGZBcEc4NS9lWk9OcTVtblZvNHlqOC9T?=
 =?utf-8?B?MHlxS2VZemNZK3hRTEJWbXhybW8yTHRwN0E1NWNOVzZ2M2tDVnhsSGI5L2dp?=
 =?utf-8?B?N29xQ2JCMVJUajgyeFdVQ25Ta1AyYUlTbFZuVk1Fc3JzUlhVLy84R2JST1JP?=
 =?utf-8?B?TlFSWXovNnZzck9WRGZZbUJLYUovZ0FSUE9tUXY1OEphSWhIdmFmODNsYUVD?=
 =?utf-8?B?eU5PdjJETmdxQnptR1Z3MUk5RW04TmhLS2w0eFoydDh2RzZvWFppQkpFT2NH?=
 =?utf-8?B?VUFCSnBTbmhXZkczREVpRk1ocGdOR05BdzBvVkJGbHdRTndTN0pScWU0UGVY?=
 =?utf-8?B?WEZOK1lYa1pzeThUcUc3b0FvQ3Q1MTZFTXJON0pMU3hTenZIalZ6TjZpUVJH?=
 =?utf-8?B?YmZhdWx2VHcxZC9VZTVWaEtqYmJYRGZwU0dQLzJSdU0ydmJxQ2JHSktIVTFh?=
 =?utf-8?B?WCtzNEVmUkxDS1BDS3JkZzlnUnVJMXZCNFdFaVdhZjdOK1lCSUxoRUx1aTJX?=
 =?utf-8?B?b2k3bkFnNm1jaGExdThNZUVLOFg4YU9FVjhtN0taYnhuaWhYTlo2YkVJTG53?=
 =?utf-8?B?VlJWTEVlUUViZ29ER0Z1WWJ3OVRPVGdjaERuVUMvTzNycDcyNVg1L0NXa3lt?=
 =?utf-8?B?SU8zamZlUFYzSW12MVkrUzJMNWwrUjZsQVIzYWJRYU13ZUJ5WmszZXp0ejJ3?=
 =?utf-8?B?N2tuL3ZSZVd6RjhHRzByVzRHVElPdUl1a25qaitKTGI5Q3NCN1VENGduYXlY?=
 =?utf-8?B?Wk9PVVBzdHFCMjRSc1RzWU1iTnBMMnl6WHcwNUd4RVZQK0ZtbDdINm1LWkp5?=
 =?utf-8?B?SjF4eFBlZ0tXcXNsbzJoUFBlMTRnYmJEOGdmOG80VHh6M2crY3RFUEloL3ZB?=
 =?utf-8?B?VGR1TTkxaThhSE1DYVJtOGZBb3NiQWdJdUVmemlLbllkb3ZwZDZHYlNKN0pV?=
 =?utf-8?B?WkxEM2szRWMxRVN2bWU3dk1IZDJUTUQzdGsyakkxeW12cXVPdjltOTIwOC9T?=
 =?utf-8?B?eVEvRncxQ3FEcjVpZ25wLytpZVFOblhBZG5hWHI1bU0xb2xoWVl3QUYvVXRQ?=
 =?utf-8?B?M1lsT1ZNU1RQWEVpUmJFa25TaGFqRXVuK1dRL0E4QW9VL3ViYVNDNTcxNTV5?=
 =?utf-8?B?Rmw3d04wdnVTcklSWnhXbk1sVnhGaDVVeFlDRjJ1aWxqTjVkWXpJVU9xMTN4?=
 =?utf-8?B?YnZXYlpkMFU3SUdJQmI1czVudWV4VmZXUzRzYkxEblAzdENuWGFjck1TZHgy?=
 =?utf-8?B?amxSTVlLZTNVRkQ1ZFpQUVNBaGJnRVBzMm9ITHhOVmdXOWYzV0t6dUkvUE5j?=
 =?utf-8?B?Z3Jkd2IxaFlLT0ZEbWk5U1lEdTdlck9HZC9KSUw2V0ZuSXBEclRjRldYT3ls?=
 =?utf-8?B?LzFHb2taV3M1M0Vyc3FXenNCUi9tZW9OM0drNy9pdXVOR0h4czk2VngwM3Rz?=
 =?utf-8?B?ZFBNU1BrTitzS0tXMkk0alJib1Uzcm9qVEJMM3lHRWx3Vk9kZ0JXNnh6aHRS?=
 =?utf-8?B?Q09VOWp5c3FsOGFrOHR4bk1pdlV0aWM2TEZyUDFYMmxDVGNPdVdselhGOExN?=
 =?utf-8?B?a2s2ZjdvV3BtZzROL0llZWRodlhla2Y3WUE1dk5PRjJTMnFDWFNySTdiTGVk?=
 =?utf-8?B?bXdkZDZmaDk1MXVpTHNRZFpna3k3akQ0UzdLYzRJenV3eTdCbTZnZlNFTmNV?=
 =?utf-8?B?L2Q1YWUwN1luZEJ3MlZ6WGxJTG53R3JUREpUTlEvT0FxSERORGl1eHRzejRs?=
 =?utf-8?B?ZnhhQmVFdkpPaXl1TnpyOHBmZFNmUlRFOUhtcmgwRUZwL3FraDI2a2JZUmo2?=
 =?utf-8?B?dStvWlZFcDBsTmtiRkU3MkE2ZWlOc3BxeGl2TFh4dG5IN0FvTFladWlwY2Y0?=
 =?utf-8?B?ODdNN3lMb0U2ME9TQlRrcVhpR3JkYlRLSnVuNVFKSUxDT3dvaVB6bG1nMXho?=
 =?utf-8?B?TVgvUXREeHI2eHp3ZXZ6M3U4Wi9hSWZvWjdYN0ZuUzloV29WWHJhRDZXd3E2?=
 =?utf-8?B?anhRY0JqZ1liQ0lRLzhjYnVkS2hZeGFGamZZaWc2cW1COFF2TXR3QjF0WTRX?=
 =?utf-8?B?V213MW9MRmxVaXpNVXJmcndzUUNPUVZ6MGM2YlIvRnl4ZU9JZS9WVVhKd0ZJ?=
 =?utf-8?B?aUNsanBSNkdvY2ZkWUR5RExZMTRBTS9hSUM5TWtsS2pOaDdLQm9BZjJnc0ky?=
 =?utf-8?B?c0oyQ2N3YVJUaysrbVZpWW9md0UvT3FCd3B2OWxGRm8rYjFrdkVhaEdwNFZi?=
 =?utf-8?Q?OhVjmQiXAGN2J0qy5D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d0e4ea-9bd1-4ff0-7ab4-08de5ea18f12
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 19:15:11.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg3nagVzMBDltCsbS3jk4VDWeyq8ckx1m99Og0ctWAv2EKEzHRtUM1prmWeRDOp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4337
X-Proofpoint-GUID: 123B-OGxSOge0ePdHJz78yd062yUkfE9
X-Proofpoint-ORIG-GUID: 123B-OGxSOge0ePdHJz78yd062yUkfE9
X-Authority-Analysis: v=2.4 cv=LbwxKzfi c=1 sm=1 tr=0 ts=697a6043 cx=c_pps
 a=yHj7y5KTVbbUXXBv8k4PkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IHo-5sJEW5nE-0hCNewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE1OCBTYWx0ZWRfXz+vsRktp2LMh
 Wdb1GCxuVYUxu3Y+/2OGZmJ4mf2sMPZDoVA5dr6cEM02owwO7BLb6L7VJxKQHcOKPPIYSXRPMv5
 0ZlnoU4EERsGUmuxzV9ZTMroNvUyBJekfDwSRNTm2WpfMZzR/gOSCymgt0UkEAasNCsQE1JJI+O
 YypuSTnTxQSU1ZopKRmNQKUHyNsfWKj/ktlT9mDs7r3OU38PsrHMVNvaxGlCQW5jVBr5fnqPf7X
 rRiiiWUAIAIqaOr18HFJBz/nsUKXy/u7GjzC6icZ86jmDP0QJEQRARHHOCxCn1r3w0SQfBOhqA4
 muADQ6ILBgyAWlWQBqHizmgfOhkbeHq2lb8UFdZWTrMa5mpXQPSPrUlimDT3gl4T4zDkGDUVK4f
 hn73dLvyu1zMCDeclopkKuyWF/Rj10a+2IA9D4aKq8ntW/tifEtPOTc1ybwurqxW6oSvdHO/V57
 sYbWdd4GgN/LuW32f0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_04,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18586-lists,linux-nfs=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[meta.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 182B0A8194
X-Rspamd-Action: no action



On 1/27/26 11:46 PM, Christoph Hellwig wrote:
> Hi all,
> 
> Chris Mason reported issues with the handling of delayed delegation
> returns in the resent "add a LRU for delegations" series.
> 
> This series fixes that by not only doing the proper unlock, but also
> by adding a new list dedicated to the delayed returned delegations.
> 
> Note that I could not trigger the delayed delegation handling naturally
> and had to add crude error injection to force it.
> 

Thanks Christoph, I reran this through the prompts and didn't find any
new issues.

-chris


