Return-Path: <linux-nfs+bounces-10987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C42A79047
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 15:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BBB171C99
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739B20D4E4;
	Wed,  2 Apr 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HmtQ56hb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v0dmwGOt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD021B9C4;
	Wed,  2 Apr 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601870; cv=fail; b=kMNDaJrPuwZmqv1OKr0Wt9XDO6czWAkrx4w1FWMpxzvDaGgZb+2DnStpPSB/rm7cIgQ9zU/py+2OANOYy2f2a37+LvVfzjdS4iknzVPDCy6aO36D5wWU4+kMRW/Tw0DMUlWnbT65D3XK65vP1Vuu2I5YYy1m+T35XccUXGyXvMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601870; c=relaxed/simple;
	bh=3lVK+MGTzCVHdKdg1LVTid3sJ51yNAoPMU4FduhFAGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AHmxHbO0aZj/wNTiZSEMh961Wszz7bfo3LIOyR2Nara0LV9ctjXgQcJPAZHxZU3VggkubmgxYG+83d1gb3DySTEXVjqRoCyAGqvUmUccfZ78EIc0+23ZnNoeyJY11B+IPjhDyG4pPturt86qi22M/sC1rjNsvgygXDZjcBIgUqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HmtQ56hb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v0dmwGOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN1m6023583;
	Wed, 2 Apr 2025 13:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Aeipt01dofEfQIWpIKN2Jhgj2NJ03ML5gGqZIppJNMo=; b=
	HmtQ56hbMeNwPxtkEvK3WE8WEmowCtJcWv4DjhLZ9uSeye2rT6FM1gJJ0kJArD+W
	hnCeNsNN5zSTmi0NPI41CLwC1oumfqclr/HRB7uAEJr8vkIZhsQWeSqgiZjG2ZeZ
	buxJE5VTgoz//iExnXflmYhR6pnFjd0oftBLF4I4JOgqOz7N8rxmeRxz4aaSVNc/
	yvNVflg7P35RcZFgq3/0fyaglGgiQ7+5V9Tzt9DTbESmvzwTXGN0gPW2w0P3xSdr
	2srVxrABfjtd+7Zu5xh2zue6+mMt/YFJZ4uAKBVWsS9VWAK+92lYkmOySoxJRETg
	aoMsPOEgiELu1yUkBqwkjQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2as99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 13:51:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 532Cl0IB002748;
	Wed, 2 Apr 2025 13:50:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45pr8rthq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 13:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDyRmhEOjor/NxDamKjoj+j57DsNg1WMIcw0TrYKdRse9myzGupsJYnZ6Xm0omOpifFM1Kw7IC6x3jCVVcKPPSANgA7HkZWnk27U9MiK+/h8zErj4FEljU+OLkE5ba02pzISn/PFvIMRkzSXDkQFRgeeJkpBxw9zPTAHWGuSSf7hIRER1RAfGQpdvZzOZ/g4p9Qw31Mv5ssIzljjO5P7+lCmGdbUbicmbwLKUv7Ef4kkp/bG6Z3F0XuAWUoHepyf3yZeXrZ/oCb5HGsFR8nkEuH/fqXAx3u2zqAMpFZG9o4hOQuTMmFBoeK8s67mnPeIuyPYM0XjBbGc3OuwiKZtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aeipt01dofEfQIWpIKN2Jhgj2NJ03ML5gGqZIppJNMo=;
 b=ghrcaxzPFkpK5jBm8qV9RkU7mYli2TCXmCgsNuLgH/4a3hTne1HYkYaoOomFXI3PHByfeZUUxTTdw33I6rNyvp+JSzIIUpTJMkYPcMLm81kgsMaUADvs9+nBIQGZyasXhZg7P1+deDtDDgDhQGq5QH73BCKFMciqiNK1x5ADWoobLJb4Tut5oexpgdUwuN5NuRm5dQrfewxVV0mnkoe1Y5CaOLeIrG+jBWGweZBJBmjioYZPdie1qSZeEMhzROTuROsy5JNxWNHLo+3LBGSZgSEpxGM90Xt9Gr9f4mpnWA+XQowvqFB5SBsBMi6IKzBhN7OClEOSNiPqtST1WKcE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeipt01dofEfQIWpIKN2Jhgj2NJ03ML5gGqZIppJNMo=;
 b=v0dmwGOtmw+fcZvtNhXQLRmf9jPLqE2H9oO3mhc7SFXM7I/QBNt+EJyu4KLlzllehqwJKqXiYO0LlAHpamt0VAYTabrXeKfv/H0c43InKbj809853hrtEolOUeiTQ4JDnwDZ+DkLfCNHMvNiC5SfH0t20+ab0qD2nbinibZ+Eh8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:50:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 13:50:56 +0000
Message-ID: <35874d6a-d5bc-4f5f-a62c-c03a6e877588@oracle.com>
Date: Wed, 2 Apr 2025 09:51:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
To: Eric Biggers <ebiggers@kernel.org>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20250401220221.22040-1-ebiggers@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250401220221.22040-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:610:57::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: bdebb670-fec5-465b-078e-08dd71ed6441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3dEU1dXUFoxVitEZU53Q2p3UmVhRHRkcEdQMFZlV0Ftd3l3MWNQOHN2RWlM?=
 =?utf-8?B?U0NzWUxQblpEYVJBbTBnaGZhWnY3QmNuZDcxWURkRDBlY0IzTFgxVzhnU211?=
 =?utf-8?B?bjJhMUZQc1Fmc2pjT1ZQMlpST0NpYk5hTGwxM3RGWGFOWHBNdkVlemRSY3RS?=
 =?utf-8?B?aTJzQWlWemRGYVR1WTV2WnZrN1J3Rndpb3JOa1BNRi9QVzZ0UkhGNng5VEJM?=
 =?utf-8?B?Y0V1RWJ2KzJNV1htS1VjTFVHbTEvdGdlUksydzRhZUEvV2ZXVmh3elgxTjdJ?=
 =?utf-8?B?bnJDL0FESkk0bG8wdXpQallydE9XcG5mU25FQ1VnMExsaEx6VlNOWGtrMUo3?=
 =?utf-8?B?RktobC9XeW5salE2K0trSFc4UnNVN0M1SjNPdldneDA2bGlmclRyQzFCbVdi?=
 =?utf-8?B?OHRMWStSajkzSWhOaHdURXJJT0tNaGIwdWtSRC9oK0VmeUpvL1hVU2UyVlR5?=
 =?utf-8?B?eXNuWDNoRDBGYlV5UjhRem9SS1J6ZTRQQTJHM056akNMVDRmUTZVRW9KZkln?=
 =?utf-8?B?NnZ4OUpGYlNlaEdpc1A1OEhrNVVsUmYzdk5VNm5BOEhxVSt5bSs3MkF2NXhF?=
 =?utf-8?B?a2dwa1orZUcwWjV5d1lVblRtSmJIQVBIZlRDd0tLQldCaDRwYXFMSU1Rc1pt?=
 =?utf-8?B?TnZ4ck55bGhQQVhZV2RQOTVzanJvb2ltMWxQYlg4S0VURTVUSFVlbVQzNEUy?=
 =?utf-8?B?cHJWOWtBc0tDS3dDVnVORDE5bS9KWVB2cVN4Z3NCbHJNc3cvbVJNMm9sVjFI?=
 =?utf-8?B?SDJTR0ZJUWNQblVORWVuTGVLYXFSQ2lBV1JUS1N6YVpKdmwzQ0xqdGVrWTBj?=
 =?utf-8?B?ZnFQVmVXa2hjWVBWajJPUGl1VGh4eGltYmlIMUJmdlJsU3V4dmx3d09sRWZP?=
 =?utf-8?B?dEZyWkF1Zkg1MXBNK0EyNEozaEdsQUxGOHNHUXhQZ1owaGdFQy8yc1NkY3Uv?=
 =?utf-8?B?TEVkQ1dUK2VHOTEyeFhzRlZZNmhwZkE5ZDI5ZndzTkR6RFBVY1BzdUFkLzRh?=
 =?utf-8?B?TDlsaXZ6WHRLWi9iUFEwMFg0YXRvNFc3LzJ4UFQ3enFFWUkzekQvNFBIZDM5?=
 =?utf-8?B?OHM0WVB3dTdMUFVjczUxemk1dThBTm16ZVJ3b2grMlFoVFJkRGpSVjk4SHhB?=
 =?utf-8?B?dzRxU202aGJzUDlMeG9PYlE4WlIybnpveWt3UWRMMlhyejczM09VWjFTT25t?=
 =?utf-8?B?dWtadUdsbHpLNDNXY1Z5eWx1cUMwTE1MWExFQTNvTXhBV2pnOE9vbmMvK05o?=
 =?utf-8?B?Kytva3NkM0Y3b1NCQ3l5TEpMWmhjZ3FzeExTWHpRZk9SeFNqK2twNWFVZjcr?=
 =?utf-8?B?L0Iyb1R4T0Z3Z05xanJUWi9BMVVZR3U4L0c3bjF6WU10TmpIOC85am9HYkVp?=
 =?utf-8?B?UTFFU0ZxK2VkMEY0UnVFWEV3WnV3d055UTNNKzlYMzlpa2NOZXd4dkxLdEZJ?=
 =?utf-8?B?cWtpZFBoQjEvYmh1Vk1HS21CellHUG1ua1IxK2NkN2JJMC9zVFI1S2x3d21Q?=
 =?utf-8?B?L2RtcGR3Ly83NUhnM0htODI4SXN3TFM0YXRjeXZuMHhYbTQxbHFNQkRtUE14?=
 =?utf-8?B?Y3dReGpOZW5YRFludVI2UmZZRStlSnV4MDNIZGVoZms2Z1hFNVNzTHhDa2o5?=
 =?utf-8?B?Nm83SmdJZTFqbHA1RzIrZnJyWVRiVkZtcHViay9XUWNpOUExaVNWaDQ4S2Y5?=
 =?utf-8?B?N00yU0VMQmdjZVRQYUp0elpUY3FPWkZrTS9lRDRHM0J5cFhaaE9mbld2V0oy?=
 =?utf-8?B?Ly9NUHljblorQk5qczdqWjdQcjVLd2FCdUFNSDBsV1U2MmlkNHFTV3RDUEFP?=
 =?utf-8?B?OHZnR2lMaEMzSVZrL2FRbnNHMWhrdkRKWXBVZUlBcTVTMUZIRFlScVoyakF5?=
 =?utf-8?Q?wvD0JrumF/Pof?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVQ2U2FtenB2NHRMTHZmY1pURStOdGFvV1R5SmlkL1RRWVJNTzYzRFNVNnk3?=
 =?utf-8?B?UU9EZ3lRRzhGQmNobWlBYVZxckdxQWNGUVVsVFNlcDZJZjBPclA2anRJSW1q?=
 =?utf-8?B?d0lYaW5VVFRUekx1OG5JZjk4aHJtT1EwUFdCZ0RLQXM0VGkzVGxhSmtUazdS?=
 =?utf-8?B?Um9YZlQ3WUdNRW54NDErYkI1aTlMai9tVUNpRlBUUWNPbDZreEtlSlVhcGhI?=
 =?utf-8?B?cUw0aG00SkN6QWwwRDlBZ0s3Ykh2dksrZThsdFFST3AySGpXTWx5WGFrQXJQ?=
 =?utf-8?B?TUR3RnNPbnlSczFzY3lBeXhWeG1LZk4yOVhEb1E0QkJFT3c0QVpHUGxrQy9L?=
 =?utf-8?B?dEpncms3V29CVXNMMHZ3WTRVNFF5aUN3aFVjbDJrR2lHNUJBSXYzRHBrcTla?=
 =?utf-8?B?a0ZTYVcyOXk2aVdVVE8vbmM3UmlPcWM2aDJIZmExZ3RmLzlGcEVYZ3drSHpI?=
 =?utf-8?B?cGdBUkhlamdramFsMjJhbVUrMkd5WEFxM3BRZTQzZ3lVMTJGemNGM1czNnY0?=
 =?utf-8?B?QjF5UGd3R3ZYZHJQNVVyMFBBOVViNWlDTEV1alg0ZUx1V0VhVEgvSlEzeGVX?=
 =?utf-8?B?WWo2TC9jeDRqR2tZOW9KaE01TTVUSVcxRk1ibjAzVVVGSUUrVGxnRmpDKytI?=
 =?utf-8?B?dmpYRDlsL0l1azlxUTkxVUZnRWlIS2pqdmlaQllvMjdFTTV1VVFlNGkxYVgr?=
 =?utf-8?B?U1dNYmlDMmExcG5DQTVQZlZwZlIyOUt5UlhmVG4vLzNhdGE5VkFHOGkzemtZ?=
 =?utf-8?B?NTlxK3FqSTAvOXRLKzFTTmhUSGxZdW1jYU83VGpwa05USlp1a0ZHeUpGRnI0?=
 =?utf-8?B?TFFFRkxUZmVDNjNWTGZuZTFKd210MERBa0xEMVMwRWRVK0IxblpkN2pzaHRG?=
 =?utf-8?B?UW8zalNhWEZmbVdnUlFTYjJkYkNCTFBOMlFUVndmOVhERDk2ejVOTEM1Y0RC?=
 =?utf-8?B?OGxaMUlValJnbncrMERLUDR3Tjd2YzIwYUZ0WkYyQXRVa0h2VTJjalY3ZW1D?=
 =?utf-8?B?NWgySFEvYzdaQUQ4Q2oremEwUjJURnMzelp1RnpZNXhrWWNnRSt4Vzg1bFkw?=
 =?utf-8?B?T2d3L2ZqVHZKMUJXS1JHWlhuUGlyd1ZzSnpYSFFPQ3NIcjVqYmFDaHFPSmlw?=
 =?utf-8?B?MncwcWw4VlBrNGVTNHdabnl1SWZQNHNJMkdmLzY5cmViSFJJNzdiZHJQRVFJ?=
 =?utf-8?B?bDlhQzZRM3R2eTNXcHhyalY4VWY1MHBTbGoycWxLMDc5NGE0eUFnVnUrV1p6?=
 =?utf-8?B?UWJWdE1BcHYxVnhyc05RT3hkQ0pydTROWVlFK1NLZkJTTzRETm03RkdGL0Rl?=
 =?utf-8?B?Q01sV0NOcjhuZDFoOC95aitnRC9rTUwwQTUrbzZtRlgvWnYydlQvT1ZvN2tr?=
 =?utf-8?B?TURxbS92RWJsc1ZOdC9Ca3FYUnNQamoxWDRUaUorMi9QZmUrbGxKMFdMVUNt?=
 =?utf-8?B?UWZBOE1mWlpoSk5xRDlGc1JOajhWNjdKaHJmdVFOSm5yZ0JPeGQzM2pudy9U?=
 =?utf-8?B?bC9lYTRENmdieVlBZWFEd3J2d0xxcmpxODIxc1BFRFRxNG4xYnFGSDhXRXFY?=
 =?utf-8?B?MWZ2Q0ZrTHJUU280RlRkUUZYa0twUzgxZFFrbWFJTVFxZlp2dTMvUC9kSHQv?=
 =?utf-8?B?R1E0U2lSdTgzcTdBeHVNWElXRUxHdlhGSXFuRzR4NjlaSWFLbHFIOG16YWFy?=
 =?utf-8?B?T205TVg0b2x2c3hKSnFkbVQ4TFhMSkVQdDR5QmZCWTFSZHJyelVRbUpXWTRr?=
 =?utf-8?B?NnV6MHc5aFlLV2hYbDE2aEsyTjlTcm85dnR0dnNtTEpHRy93eHplMGlBK0hG?=
 =?utf-8?B?ZkUzRE01RS8vbDBwaFJuaFNkRER6eGFiZzJhdGhzNkJ3Vkk5R05KMHB4UWw3?=
 =?utf-8?B?elE2WGdQdTN6NUpIK0ZmMmRhM1dFZlc1ZEdPS3hsWlh6bVpkZ3hTNjNIVktQ?=
 =?utf-8?B?Wk9ValA0MUVBZ3dFWW1CZkh5dTYvR1B3WVgvNlhlSzRlRk5FWGFFWS9sT3Nh?=
 =?utf-8?B?c0FvQkkxclZDRTBTTStZZHkxM29HWGFPUURlbldqeWJoamZianIxMENtSlhl?=
 =?utf-8?B?Z1hNRjVZZThLSGxLYm5PblZ3SDR1Q21KbmdXZDNQMzFQZFVVYTR6b0twNXd4?=
 =?utf-8?Q?Xzt8aVQ08MbEvxmsVsea/QVfS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J8lvL4tVLEmjDll1XO99sT8RBVrcnYv/4diiercHdIfSwCFnRhsC3cEH6YspE8oFHgg0NtfMwjBHNy9YWhIjyf8mndEhg2IvmC9ESbrERVpmXcbFyRM+lnwuRJxSy18Hi3Mon2inL9RCOvrTaxYUqV1j7jTlJc81NkdbjWYNIaAuiqsYMN96bPJgQsvru4IeX6zhgX4NdF44ldS/3jA1ueIsn6mUAwDJgqYkhJH1pNLHIsm8jL4+E76Mu9D7nqVRmDBZKGL9Kd41G+VIDSBDmy6YY9d+kdfgewYwTpm8/dSqGn1d5KriZmXwYo0i7BikqD+y0ZPkOWxOd1D5GGUZAOp0cATOjhm1QYUfQnx5G5lg2oSbhsi1xmdHf7B7dFMnpW/cB7X8Rp8ZsqCfUyeoxfMYa2Vk6SGN6hI7AKUjEeoTgsA1aI+h3n9+fJJncW/XSvA3DqHk9OvwxACCHCuB6kQs7z/ZjzSWT9d7tEvKIVQeaKVjf8bTAlHOai8AE5CpLnrcB878Zg6Kpi5emp7vhmzrVIN41ppNhZQoWOpni5Inl7lgHG0B71CWbuyyuorKMLVWKYoPEgWa1LoeNs3QVc/62MasrTxDfyLrGFpcQ5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdebb670-fec5-465b-078e-08dd71ed6441
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:50:56.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+JZPfQMhqywpDJRFItxC5VomniqdY6OSnwWTzFbZpS/+cvrXOB73P9RknpMvIn27mWynVeTK27hppUr54r3aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504020087
X-Proofpoint-ORIG-GUID: 1Ua953-gp1wXvQMfA2_jGF3No2FnTkAt
X-Proofpoint-GUID: 1Ua953-gp1wXvQMfA2_jGF3No2FnTkAt

On 4/1/25 6:02 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
> only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
> selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
> did not actually guard the use of crc32_le() even on the client.
> 
> The code worked around this bug by only actually calling crc32_le() when
> CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
> avoided randconfig build errors, and in real kernels the fallback code
> was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
> really needs to just be done properly, especially now that I'm planning
> to update CONFIG_CRC32 to not be 'default y'.

It's interesting that no-one has noticed this before. dprintk is not the
only consumer of the FH hash function: NFS/NFSD trace points also use
it.

Eric, assuming you would like to carry this patch forward instead of us
taking it through one of the NFS client or server trees:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

for the hunks related to nfsd and lockd.


> Therefore, make CONFIG_NFS_FS, CONFIG_NFSD, and CONFIG_LOCKD select
> CONFIG_CRC32.  Then remove the fallback code that becomes unnecessary,
> as well as the selection of CONFIG_CRC32 from CONFIG_NFS_DEBUG.
> 
> Fixes: 1264a2f053a3 ("NFS: refactor code for calculating the crc32 hash of a filehandle")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/Kconfig           | 1 +
>  fs/nfs/Kconfig       | 2 +-
>  fs/nfs/internal.h    | 7 -------
>  fs/nfs/nfs4session.h | 4 ----
>  fs/nfsd/Kconfig      | 1 +
>  fs/nfsd/nfsfh.h      | 7 -------
>  include/linux/nfs.h  | 7 -------
>  7 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index c718b2e2de0e..5b4847bd2fbb 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -366,10 +366,11 @@ config GRACE_PERIOD
>  	tristate
>  
>  config LOCKD
>  	tristate
>  	depends on FILE_LOCKING
> +	select CRC32
>  	select GRACE_PERIOD
>  
>  config LOCKD_V4
>  	bool
>  	depends on NFSD || NFS_V3
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index d3f76101ad4b..07932ce9246c 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NFS_FS
>  	tristate "NFS client support"
>  	depends on INET && FILE_LOCKING && MULTIUSER
> +	select CRC32
>  	select LOCKD
>  	select SUNRPC
>  	select NFS_COMMON
>  	select NFS_ACL_SUPPORT if NFS_V3_ACL
>  	help
> @@ -194,11 +195,10 @@ config NFS_USE_KERNEL_DNS
>  	default y
>  
>  config NFS_DEBUG
>  	bool
>  	depends on NFS_FS && SUNRPC_DEBUG
> -	select CRC32
>  	default y
>  
>  config NFS_DISABLE_UDP_SUPPORT
>         bool "NFS: Disable NFS UDP protocol support"
>         depends on NFS_FS
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 1ac1d3eec517..0d6eb632dfcf 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -897,22 +897,15 @@ static inline
>  u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
>  {
>  	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
>  }
>  
> -#ifdef CONFIG_CRC32
>  static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
>  {
>  	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
>  				NFS4_STATEID_OTHER_SIZE);
>  }
> -#else
> -static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
> -{
> -	return 0;
> -}
> -#endif
>  
>  static inline bool nfs_error_is_fatal(int err)
>  {
>  	switch (err) {
>  	case -ERESTARTSYS:
> diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
> index 351616c61df5..f9c291e2165c 100644
> --- a/fs/nfs/nfs4session.h
> +++ b/fs/nfs/nfs4session.h
> @@ -146,20 +146,16 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
>  		const struct nfs4_sessionid *src)
>  {
>  	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
>  }
>  
> -#ifdef CONFIG_CRC32
>  /*
>   * nfs_session_id_hash - calculate the crc32 hash for the session id
>   * @session - pointer to session
>   */
>  #define nfs_session_id_hash(sess_id) \
>  	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
> -#else
> -#define nfs_session_id_hash(session) (0)
> -#endif
>  #else /* defined(CONFIG_NFS_V4_1) */
>  
>  static inline int nfs4_init_session(struct nfs_client *clp)
>  {
>  	return 0;
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 792d3fed1b45..731a88f6313e 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -2,10 +2,11 @@
>  config NFSD
>  	tristate "NFS server support"
>  	depends on INET
>  	depends on FILE_LOCKING
>  	depends on FSNOTIFY
> +	select CRC32
>  	select LOCKD
>  	select SUNRPC
>  	select EXPORTFS
>  	select NFS_COMMON
>  	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 876152a91f12..5103c2f4d225 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -265,11 +265,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>  	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
>  		return false;
>  	return true;
>  }
>  
> -#ifdef CONFIG_CRC32
>  /**
>   * knfsd_fh_hash - calculate the crc32 hash for the filehandle
>   * @fh - pointer to filehandle
>   *
>   * returns a crc32 hash for the filehandle that is compatible with
> @@ -277,16 +276,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>   */
>  static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
>  {
>  	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
>  }
> -#else
> -static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
> -{
> -	return 0;
> -}
> -#endif
>  
>  /**
>   * fh_clear_pre_post_attrs - Reset pre/post attributes
>   * @fhp: file handle to be updated
>   *
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 9ad727ddfedb..0906a0b40c6a 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -53,11 +53,10 @@ enum nfs3_stable_how {
>  
>  	/* used by direct.c to mark verf as invalid */
>  	NFS_INVALID_STABLE_HOW = -1
>  };
>  
> -#ifdef CONFIG_CRC32
>  /**
>   * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
>   * @fh - pointer to filehandle
>   *
>   * returns a crc32 hash for the filehandle that is compatible with
> @@ -65,12 +64,6 @@ enum nfs3_stable_how {
>   */
>  static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
>  {
>  	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
>  }
> -#else /* CONFIG_CRC32 */
> -static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_CRC32 */
>  #endif /* _LINUX_NFS_H */
> 
> base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516


-- 
Chuck Lever

