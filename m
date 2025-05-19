Return-Path: <linux-nfs+bounces-11816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949FABC05F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021FA176317
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDA26A1C9;
	Mon, 19 May 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DyuPKRhu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QkPSlyKb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444CF1A83F8
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664197; cv=fail; b=AO2d0i7tETwlWlhmwa/9AOS5bf6CRg6fXdkkI0CagbXbHANKTsp36cyD4+LX3RlZ0KGY+gp0ZN266Sn6FfomQiOb91CmArQOItHF4elO6Vredtn6te0saFn1ciblsp8Kk+rIXCcs4dgokznYDyCrKcreYg2oufP2ta+GzI3nDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664197; c=relaxed/simple;
	bh=M0GM4YpP+i7uzgzm57IAAzvQpsoEYHTZcY7M8pZBKi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S9X7oTeNI8SwydRU9PWLPdURFySv2UoQ365dnu2e+i8j9zc+ERrevN6OWinnwZyRBcGCAgqItH8iZAsTtNQv7H3GgB+bqizCQwY6CFGTY34w03x72yMlVFFLrmts2IHSLPq3zzph5MtspU0JMBI5fqsc6Qr9gTJxTX/fwqGsaT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DyuPKRhu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QkPSlyKb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ij5A013002;
	Mon, 19 May 2025 14:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j/JiC5G4IU2AygJPFu4Icu7d+2L/B7/yN3qMKQPgebc=; b=
	DyuPKRhu97pdEG/JblPDI1SSypQfX8BxU95X/FwYmIG+nhYWzl0MLHrfVXlZh/Ef
	pTI0t4EU+/Nk2TuQ2ZQQoZb4wijs9/YwmYctWyiuRXvCboAbzQ2pqyo71+hIPv+X
	YT/iYXotwHtTeVBffTGnO80fspr4K3r2n6r1QSJj6mW7pJ2p1wTDsL/GloaKgTaZ
	+uYLnm8sleX9mpbUfG0s1gAu9xhVRxqXyFZFaHdc/i9/M4dmL9tBpqvZ+J1UAMH6
	oqXOOtP/1dT28JtEtE+gbeWWeIyMKSwcddsbltO4e1YGwmw54PMoC6jmN810QV7N
	dwCA+xxxPDiNlj8EFfLZtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pj2ub2k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 14:16:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDV43p037159;
	Mon, 19 May 2025 14:16:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7gf15-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 14:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2/T1103Y4mOWDP6V3+v8b9I7R8pPXtQPkzYi4zXfeigkIZW+c27Y1fRDyGYn9N0kz1oIK14oB0UngAS+2qPXrs0warz0f+YLB2OW+twqKqGq7vxBbxuwGKKvFVFKXuIsRa+2FlE6pz2+CrKC3EhRAjniSV/r8tBnKptzCMKZ/r8pllYrM7bMA7Cbu8EdAiRPcF9wNEi6tgANzj+TaMP0VgsHcSeIHwpxy3mnoUYV515/awcrV/jhg01dFWna8uaPd4CLno5RIQ9mEyZ0eq3LATUPwkG4viNv6HEitfGvUVc0JodYros+8j2xVVERvtYwzT6XOPv0hdM+QHobBvyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/JiC5G4IU2AygJPFu4Icu7d+2L/B7/yN3qMKQPgebc=;
 b=bxR7HKn+cI8nptRL1yWblGiMVvpW6Sl8uPS5EBeTfbI70z7COm2bd5BoRBoBIP1C7qnnRpOOnTkc1Nz24ZC5h4V66zkrfvH/NeP2uOr6UaOP1SccDliBEFzqJHuEvc7WTV8hBOWmUNsKlBOAtSvrcwFzSxECIiiRwTfLsQrru9aGLp0LNsQi/Ay6ckr8SdpsnBfJjHQjp0Q53XYOzSTW9ZhKbl/Wusv+2NpZ8FomHDjQBbQWyZwestKsjjfagzF2vWsl4husj3Qc3n6J3l9QOqzeDteToEGKXhOlUTjBg17/x7qjMCsD5z1p3dFCYkPHpzr37rzStssR5NOPOiQ+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/JiC5G4IU2AygJPFu4Icu7d+2L/B7/yN3qMKQPgebc=;
 b=QkPSlyKb5w4nzzM5Yb4itdde2kdit/y55wZjPHmzYVHDe7s4Tax6HMfcd5B7PwGlu1gYMU5rfBGtLjJXBmzbM8eUZDXpyIyLxgClMW3XdMP3JKDrlImvO3q0tHCsmNgzTZZRm5RyKIzGHrVD10Hx0JV1atQF1ijBB4Mhi7ZAIjY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 14:16:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 14:16:27 +0000
Message-ID: <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
Date: Mon, 19 May 2025 10:16:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
 <174763456358.62796.11640858259978429069@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174763456358.62796.11640858259978429069@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 51852ddd-749a-4711-272c-08dd96dfbe28
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eE14cHVXVU9LVzFENk5leE9Jc0ZCNEhBUW43eGs5Ukh1eldUalNUQm81UXE2?=
 =?utf-8?B?WEsyUmZUdXVXMEFQUEJJbmxwdk4reGg1S0VsWU5NZ3dxdFloOFVXcmdTaFk1?=
 =?utf-8?B?a0c3QzBrRjZESW5DZXR6aEFSZ21sODRqcWMzZU5PQ201ZzQ0WjBLaDB2RzNV?=
 =?utf-8?B?TkdaenRtTUV6YnRQdUl4N0RJTk42dUlQLzRwdEloeGRMK1RNYTRhcmN2V3FJ?=
 =?utf-8?B?RXR1dDB2NmhFRjdVYUhhVHBZS1VlUUl4MmVuNDdON1cvNjNRdFozSUJyeS9D?=
 =?utf-8?B?UGdGUFRRcHkvVWtVd3dEZ3hTVldYeGZWLzdiSGlCZE1ZTSsxczJlWG1jSkd1?=
 =?utf-8?B?WDZwRnRiSk0ybldxVXFMSUphZ1BLamxORFFDb3hKYlFKSk1JSU5hWDl6WVdD?=
 =?utf-8?B?U2JKYWk1V1ZNRUZrakRpZGxDTU1rdENqNzN1TWlUU3hMcmtSdTFrWUtiVWlW?=
 =?utf-8?B?aGR6bUV6b09zcU1VOGZiYi9sc0JCeDlHMFVWeVMyTE9Rb0c5c3UrMGE1TnNV?=
 =?utf-8?B?NHhPckI1SGV5elNBdUpsWjhiQ0VJQzJacWJ4OEVDdWJEQXNCS1F3U3VwazM0?=
 =?utf-8?B?Z3dXZ0VWK3YyNzB6S2ZhTlFNd2lnVVZURGV5LzZjWTk2NlFUMkRuZW9ka3Er?=
 =?utf-8?B?SlJLb3lpS3JpZlRmVlBOS3I1WUZDenRPT0MyeERQZjluWFZqNVhaV3M2NDl4?=
 =?utf-8?B?aEp0REtBK2Y3Z1gxTE9DRHpuaHJEb0JVaEV2N2FSTC83RktWaDc4UWxzOWdR?=
 =?utf-8?B?Z1hBZjdPRTkwNmJxbmtkWkVnWU56SllZa1lNeXphV2RRMG12c1QzaGd6MTJK?=
 =?utf-8?B?Z2tFR0x0TXZNaFd2VDZSa2lIMDRsZ2lrMURrUG5CSndvS2s0WDZkL2ZEOFNu?=
 =?utf-8?B?S2xUL2pxbzVXTUYvTGJneDY4TWIvY3kyeG4xUHQrMTVTdE1YU1d4bFlWQmVM?=
 =?utf-8?B?dURNOFNpQVhURGFVR2FITU1rSittQTlKZkRBaUg1VG44K3FKditKYzF1cGQ5?=
 =?utf-8?B?YkNuRG16bzUrQm9ieEtpZFgzRkM3Um5jdmJ0WUtlTHltSVFGZ1ljaExnd1Vt?=
 =?utf-8?B?TWFFUzY4N1Q4YnROellxTHJXekVFSmV1Z05MU1UxZVlzUjFTRlQrb1laL2tO?=
 =?utf-8?B?cTVWQno5bnJUL2tmQlZCZytEUzE4MHhsYk1uTzZ6VUhaT0xpd1hSL0FYRytP?=
 =?utf-8?B?UGNjbFFKa0d5b0JFRmZ1MTZ2dkE4bld6Q0RYNnFTbU5rN0djeUhDNVZwY3dI?=
 =?utf-8?B?T09mZWVyT0pmVlhaZStTNktVcElSRFBsUHlZbWUyYmFXeUFraUFHWE1rN21F?=
 =?utf-8?B?a0RUU3BWcU5pZUZEL0dHQ2V1Nkc3b0FpT3NtcWpKK0NqUG9QcFFxSFNyZ2pY?=
 =?utf-8?B?dDNkdWFIVWx4U08vb2FZbWFKNmlmWjhyU2hydmZTWFY4YzkxRXorbjY0Wkhr?=
 =?utf-8?B?TlJzWHlRYXE3dkhhR2hEOUFjbEVHUk9saHpva1NKYll0bFRRWUxub1dPMjVH?=
 =?utf-8?B?OGg2Rk16R2gvdVZQelNzc0JIRTgvT2xRSjdjVkJDWnhDMDBvaUJITkpvcFIy?=
 =?utf-8?B?R0txNDlrOU5vVmVHMFIxcE4xRUlmZHVzWnFTR2pyL0hyc0xlU0pwN1Nvc3pB?=
 =?utf-8?B?ZnRUVzg1cEJ4QXFCcTZocnZTMUxkUkFrUHJuL0lDSkprQVBBTDJWY2lNb1NB?=
 =?utf-8?B?R2J6QnFpYWh2czJIeGFMNy9lN0pPT1JwQ3o3Zitwa0ZJT3VjNTN2Q3VyTC9y?=
 =?utf-8?B?UWRjSFdaWTJtY2RlZ2NHV3FUZGF4ZXpadkNJSXFQSHZJbGkvL2txZ1g3ajJT?=
 =?utf-8?B?RUVoNlB1WldjWDRMTURDaC91MGZNd3poY1dGS3Z1eDRzT0xQRnFaek5BOU1M?=
 =?utf-8?B?RS9CR2d1S3l4QVJjZk51MzQ0NS93aFIzMjgzbkx0VzhLeWdiSmVnWVJ6dzdB?=
 =?utf-8?Q?iwid9j6DyXs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWxGc09acmpERThDMHd3RXRta2ttWWMvRjRzNWZaa0NETExCQ005c1YyTUZa?=
 =?utf-8?B?d3BPaWdUOGxROXZmdmxGc0xTc3VDczIwSlByYlJxWmJMM2RnZnVyWms5WTdl?=
 =?utf-8?B?NHpMZzg5bHRVK0JDMkJ1MGhyYzVBSFliNzZkd21lVXdURGRWTkFVcWN1WGxT?=
 =?utf-8?B?N1ZjeXFnSDF1bzVkTk9HRUZPSVRpeHlhWkkvdFNNUWdhMVJHTC8xQXlIZk1J?=
 =?utf-8?B?enNuYVZDNjYvakxEMG1tT29NVnJJM3VZMlI3L3N2bWRIdGdSaTJXRzRiSytW?=
 =?utf-8?B?czdZTnBNZnRPVjBmSFBndnhjMzNiZ3M2WmhsaEtNWHFQRFZNaHhQT3VhQm5u?=
 =?utf-8?B?YVczcTQ3d2pkUXdWaTFISHJjZStNMFA5VkVPK2lxTHJGR2xzWW1TdGZudGZC?=
 =?utf-8?B?ZytPSUhPVWpFY3VGQ3JiZkFMbklwazRydUFIY2l2c0dHeXAwQTVBamFLMUNI?=
 =?utf-8?B?VTBXYWJPQkZEZ2NxcE1rTXN4RzJHS3A5TTB3U3RLSWlicWtsSnJNQ0ZzNmo3?=
 =?utf-8?B?RnlBQkRCZW4yRFdlZmJNSU05S2JCZWRIdTF5QzY4OFlCenlwdlhDcmxRL2Ux?=
 =?utf-8?B?OVVWM1VDaDRyeFdNRHFvN1FjV0Y5NjlnejEzOEtuL3JLYU1lMllpTVlkY0F4?=
 =?utf-8?B?S2VteHl0RnI3a3dicFJZLzJLN0FLZ3djTGh2elUzTEF4ZFZiT0pqMndUcnVY?=
 =?utf-8?B?d1ZDMU1DbEt2YWd6bFltNUFlUVJ2di96SHFldGZwMFdnTVZYcWxzNllMZS9Y?=
 =?utf-8?B?RFJlOEV2SG5iTWJzYVNOcThYaFl6VU9VU3NOelVzRGprNEZ1L1hYOU1jWHEv?=
 =?utf-8?B?ZGh5bWxLWXQzOHRpeGxSUXhpMFVXR1ZZRm1OWitBNkZTaExFT3phVTVQUXYx?=
 =?utf-8?B?YkZ5WWZoMzFCZE45RWlVdUZMc0xOTVhyRTJ5VnVMUXY4RmZxdFl3RksveURa?=
 =?utf-8?B?eGhCRVN0WTByK3FOS29oZE9Uc0J3V2d3eEtJWlZDckpJZTZDRFdYT0pFRUda?=
 =?utf-8?B?dWxoSnByQlloTStyMTRmenE5Y3pIR2xsUzI3ajlQaE9LcnMyek1Hb3RRcnpL?=
 =?utf-8?B?SGUwM0QwcnJlNmY4N3VYblZ3TENRcGk1Wmd4ZTBVZ3U3N3BQYnJzUVRoNkp6?=
 =?utf-8?B?T0t6ZGN3YjBZWlRmMGxPRXVOaWZhMHhtMmpJWFNMNGZ6cWcxNFM0QUt5Y29V?=
 =?utf-8?B?ZGUydVE2VjBKdGxuL3pSWXFKVnArL3NXR244VFV2SWNCSHFBdEZIRXlxYXoy?=
 =?utf-8?B?aXloTDFrUmJjcCtLcER0T2ZHNmF6VkQrSFhUUzBhb3hoWG5QSW1yMnNZU1FR?=
 =?utf-8?B?TnVybk5SODduc1RqRm1adHE5aGdKWUF5VTlDMEtFZktyRGkrRFlRRkQ5Z0s2?=
 =?utf-8?B?Z1R0QlNzZ04zU1kzV2x3SEdIdUplc1FjcFlGby95akg5TjRzOHJ1Wk9TNkU4?=
 =?utf-8?B?L0lDT3liQTljM0ZXOTc2eUQxbGJVbkE2UlBCUUZRanBFN1NOTmdSRFUzMVJl?=
 =?utf-8?B?YkVyWVF0SlYwTEZ4Q1ZyUmFZa3hWVnVSMmorbVhJZnRqUkZicFhEQTJYWU85?=
 =?utf-8?B?WC9rTk5rcFNMZm1Wbm5sek5mTUZ1SDg1RTdxbHNqeng2aGtSaElyNkIySmFU?=
 =?utf-8?B?c1d5OUo5NFNPUkZsTitlbFVhWmJjV0tCRHZrR0FqWXBkWTBzTzRVRE5Sekhh?=
 =?utf-8?B?SCtPQ3JyUWFTem5nUFMyMDduQ3QxQ2ozdzk3by9pTnVySzNIeVF6cDlPQUVy?=
 =?utf-8?B?eHNlcjAwVnZuZ1dGRkNnazdDWFgvVFU5VnFDVmJicjZOeU1Nb0VGc1h1YkZD?=
 =?utf-8?B?bjVuZiszZGREMWFvd0ZRMGZYR0U3YUMyL0ZRVXQ4QXU3UURJWVRkTjAwN2xj?=
 =?utf-8?B?M0RNTUZxQlJEYWYyc0V0TjFuME1HWGM5bFRxRERRRkl1WFNPSWgvczIyeUE2?=
 =?utf-8?B?RFVMSTA3UExzWVN3T013dldEUm5HdG5DZlhvUWZ0WFI1UHVHdUZIVzBCVmVN?=
 =?utf-8?B?RFlHVFVEOGZoQml0Zmt0T3dtbFNqUklTYzJTTkRlQXNKNjh4RGNWNmZ0WEJX?=
 =?utf-8?B?UEhITEl5UGVHRzM5S3h3VFhpZk1zR2hFajFTeWxPNThQN0lHdnVKNlY3cHZ1?=
 =?utf-8?Q?RJC3H3bQGUs/j96NUD1HkmC8h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FaO7HPZOQAXATybLGlw+Rmp97HCLieeyZj3hQcyBQexgdsw4HJJCUjB13/RwVgkvcoWWbvxpeUZttKiWveSMcuuDVOVKUVsFHEMp4BdiYNVrcpLImmbgYdZuD1kRKaIqwHPgpt/mXpSbCJJM8sxcHTNq925dq3KjvgYZyHlp0YKyBowMIX+nL2yCD+J8lOAqDaFDLGjNbx/AHYFRQ0VsyC6Dcw5Gn9o93omDW+r1/A8NhbAAazYBKQdpwDwha/50tqS/O6RoUV360jUB/uH0woMKNvWApq2SH48tw8WLENPXhHJb0u64szXu6xKcx67QrQDEOc4Pp76k4NT27AGsZ9DPX7qfQZiHM/E1EEbwxsErDuDZzBYAARkEfNho68U5HkB8hGCDqzaMVaOfc0oi5eRAgHC42yFvVS8BUXIKDWeNe3dCSGYqedC9TyAJbhbbTz1vnWYRlffiFXIAUT1qf8ktd4+OuATMv47AFGflCQksu4T4RDw1Uq/R5x2y0ECvsKwCWK+NBAdnJISOL4fgQmxAbBjg4bAE+QawvtG8uhiDcc4GEP0IFF7ETtb2mT7swWYabmgjHaofbsORPkp0sFITGWVF5C962TL8EFY0Fzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51852ddd-749a-4711-272c-08dd96dfbe28
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 14:16:27.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxADDaa1eKY/82jQornpC6kBi8ZLS5H8jH/utOT4onCw7xSkcbafXGdfKDi38+wyPna/Pl+DfGQHDeZwGmluYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190132
X-Authority-Analysis: v=2.4 cv=UKndHDfy c=1 sm=1 tr=0 ts=682b3d3e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=KWDhXm24ZRIIJgdCPo0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: 2GGczkW3Zx00HO3qYCrX0fS1xB4dtwks
X-Proofpoint-ORIG-GUID: 2GGczkW3Zx00HO3qYCrX0fS1xB4dtwks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMiBTYWx0ZWRfX03sj/qMMr7Bp kNXwdtUR1JRORl525UY+v7M+3IbQ2vAOZsWXcBFamV5ujAFKBcptwgORtNn1fOeEBY+6NmPmVGt 66qSq4HV+aqOJdGmFOeEDm+bAIDVJst7qNA31HTIb+VRLXl5IOdHH5oqgZF8GDQce3Z5y+SiZcJ
 7Cf1RDlBLMxfme+cEgPnFddvkteudlczOdLxYARitZAOWuckXZf7oI++KAuLI8Mg6DnmJI8rPVz 1/Agglul3EVAI12eKN6v2nv06oQLTw+oRnMjOENfBd6jrKNUAebCbdEGvHFtZWoQTR9zWPuZioj vlFhGqGGknm5cl7tLpAc976jtx0xTl1o/eU/Q/jErhoPwb/LmxVElnOjKdi7JSsMrIq5CwYwqK+
 C1HmLOcsU+fsNVTu66qxr3vn6aOJPWD8SBbQ6iFxoOPEkb92CjvfRa8Gz7OdX5LhefC5aNO4

On 5/19/25 2:02 AM, NeilBrown wrote:
> On Fri, 16 May 2025, Chuck Lever wrote:
>>
>> Fair enough. We'll focus on improving the man page text for now.
>>
> 
> Has anyone volunteered to do that?

Jeff has, but thank you for the text!


> I haven't added anything about mtls as I couldn't find out how nfsd
> interprets the identity presented in the client-side certificate.  If
> the identity is a "machine identity" then sec=sys would make sense on
> that connection.  If the identity is for a specific user and can map to
> a uid, the all_squash,anon=UID should be imposed on that connection.
> 
> Can you point me to any documentation about how the client certificate
> is interpreted by nfsd?

A TLS handshake is rejected if the server does not recognize the client
certificate's trust chain, as is standard practice for TLS with other
upper layer protocols. Therefore, when an export requires mtls, the
client must present a certificate and the server must recognize the
granting CA for that cert. In recent nfs-utils, there is a "Transport
layer security" section in exports(5) that might be updated to include
that information.

According to RFC 9289, client certificates are machine identities. To
identify a squash user, we plan to adopt the FreeBSD mechanism where
user squashing instructions can be included in the client certificate as
part of the Subject Alternate Name. This is not documented because it is
not yet implemented in Linux (but FreeBSD client and server do currently
implement this mechanism).


-- 
Chuck Lever

