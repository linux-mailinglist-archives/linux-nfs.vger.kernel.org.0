Return-Path: <linux-nfs+bounces-10962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C0A7668C
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B895916677E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E205211283;
	Mon, 31 Mar 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dwnQtOEb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d7XDvFEl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED012AE8D
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426433; cv=fail; b=NtvafHWM0rp2iFlCOQdTuNMNcdDYZqqVia99tIXR7BVnwoAB55m6vV0Ipc9Yz+by057IqBAHiqCjpe+hXsyc5b6y3N+VrGQqWh3tbWq5GgOcvIrEELzciQSga1LVn3dtinYjdFm8J0srQdRCpu0rOopDtMWjKdP8S2d/AvzME8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426433; c=relaxed/simple;
	bh=NYHS+xwqOrHUU4CYiflTby4vbrzGxci0F1/h4wme3Qw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUTitq4TG6V3rHIW/oqEXkQ4FRILYdUayCEx2wd0L/b/VUMyP3YyD8QfD12VTAo/2ZtEyhaXW/CnRFtngBXIuHcIUWDlwZqFokeikZ0ojI6U67mFEG+kxVRnnL52RN+OWhd4vy6B75M6jHxXy6mpx0FoH1126M0VRZzOf8wrVK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dwnQtOEb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d7XDvFEl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBu3jT008028;
	Mon, 31 Mar 2025 13:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h0+71XZRpHt+Wri/7c+jY3IyL0hYgawSWHq6o9UcB6A=; b=
	dwnQtOEb1yTR8hnsw0aKsSll6fiq1UcEH1/KJ4QTyDFe8guQ1fGa86p52YaRjJ7J
	zsKfMZSH+XPd9o9L39STOkt40OWdZz4VwxGdGEDEbMGXsxtPWtjnmSKwtjbBooJf
	/K1TJqe1Xeu5RyqpPsaDa32gjyHb3SNikSW90qiFkLh+fyQ3BG0NG2YWWqk/aNZo
	FMmCJpRRcVb9lbFXKq/K+Vx3/ftRQorV5qsXNtoL4YOevrtyOUEZbvHf9abe0MgD
	z1JuH/u85BTVNuPA0d7woqLJvf5KZWa9R1DQrSAeRvI+3fYxGytqMgaj9nIF2FzK
	vVNpYVHddCJSm5B565HKtQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c35m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:07:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VCUaTr032747;
	Mon, 31 Mar 2025 13:07:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a7vh84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFsvbQJx3ZyWQ19sH7hrKovu12IhPRL78k8gyd3iuJfqvvvHXvYBWeqEHndxcJoT40Nx/iPgrpEe8gTR2UBU/RTOsnoU+odE1BJGaqMjKciJfgNPdKwbfA+R19AvHHvTKWnhclq9fVKmC7wgDii5Pb5bHCEhXWBYy/Spl372usu/kOtaOAKXbnTO103mUSqDhlDbK4FFnFPRXojWlzsulRMExhi+8EiLJ8mA+Y2IlJIITWD9VemCiE0N+bO6gst3fxiBGntN644DNHelZnrISq4YaPEs2Q7vfEb6c1D1rVlKeRRQXXdVxMtXxdoHtTNCAcHjGuA0FPQ61YViMsmKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0+71XZRpHt+Wri/7c+jY3IyL0hYgawSWHq6o9UcB6A=;
 b=y6E02QqFSSft/08Vdz5cO4HxaS4ZdHkLXgVr1TSmfcwVQLySaq8dUMARqW9vRW+xzwh5FqnT6TBHlX0jzuGeFCD7nH41Lh+nh20e4ZvcwzvHN4oulupJ0E/XERNAuY2W498iI1YI+SLJYbtRWcb0pgIguHyz3ev1qjVH8ywCELAsrMqe/wvkWata/elXTetg5/zncf3/xWlz13tD4HJYw+KfE8wJ48NMPUn25zuAiMDq02M3lTRSzi8AOv06RGfqRC8tmONeJ6ftZC0xzi+FyQO+36dmNZ6BLQFKQISbqxEoBVyFa/ZXlzg5Bp8TzvdSGW6bEpcaEN5qSxoa8tI5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0+71XZRpHt+Wri/7c+jY3IyL0hYgawSWHq6o9UcB6A=;
 b=d7XDvFEljrdgz8b5T8ASg4Ha1rdPj9llODpsHFR7MDNni1OJwYirjLRV7C5Cm5phqRInOgkKhqagCRs8EIJ+YjtKsqJHDcbpx0P9gAt02ml3PM+jvFr+EOn+m+KtFdtyiNE7w1jlcUzXG59JI1ewv/HcurpYMwCzNq544DyBomk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 13:07:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 13:07:05 +0000
Message-ID: <d7934f30-12de-4b85-88db-19c877172375@oracle.com>
Date: Mon, 31 Mar 2025 09:07:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Using Linux NFSv4.1 RDMA with normal network card?
To: Lionel Cons <lionelcons1972@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
 <5c458e04-4be1-4b0b-af99-41d258da5d7b@oracle.com>
 <92a56d9a-b773-46ac-8a72-a20c7dcf41bd@talpey.com>
 <CAPJSo4VHiHGDB7YpqzNVUaKf6bxYh5e2RQesd1hwvCjTax7eqw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPJSo4VHiHGDB7YpqzNVUaKf6bxYh5e2RQesd1hwvCjTax7eqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf3c736-da5c-4be3-9ffd-08dd7054ef31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTZGb2JqaDVibUJWOWVLYnZKb0dYSUJtcXFZbGpCSURjbE45M2hhaHRRWnA3?=
 =?utf-8?B?YVJQUjNHVEhVUkdaRDZGTWY5cWMzQUZ0aitEZlVhNERzeXh3Rldvb3RVZTg3?=
 =?utf-8?B?TzNQaXIvaE13L1hoZk5vVEFZejZ3N2MybkVGcDJLUXl3L2oxZlltbEtKaE5p?=
 =?utf-8?B?N2VGQzZUemhHZlZMMTFDckttYmR1RmFnOTBWVGUyN0N4SEJEbXlTVmVOSzYz?=
 =?utf-8?B?SSt4aE1mSnBCbGpxajhyamhsQ2NVenNjbmlKdVMydW5KZCtLR1d2MGpkL3By?=
 =?utf-8?B?WlQvWm1UVXZ1bGhVS1FEdldkd3JkTitNbzlaeWYySDJuZzQ5elNQVVVneFFT?=
 =?utf-8?B?YVpYMlhqZDA1R0hGcnMyTlIxdkRkKysvaEdqNjdKZjdOeHVXVTZGeDNlQXhK?=
 =?utf-8?B?cDRGakg0a1RmYklaNStjcFg4VVpJTmFSeTlIcTR2NHBlOTZWdTBFY0FHNTBi?=
 =?utf-8?B?dENhc3lWSHkrclYyQnFkY3NoNFIrd2lFWWFCcG9JbE52eDRVcTRxT0c5QmRh?=
 =?utf-8?B?OGpOTVpYMHFNN2I2dmM2MDJCMzkrQWg5QjRZVFBkNm0vbkpSMGt5WnI3am56?=
 =?utf-8?B?V2Q4S2ErY3NhS3p6dkprR1YxbCtqT09RVXpWWElzcEZCQk91dHNnSHh2VEVq?=
 =?utf-8?B?QTBmZTBIZGVqTnJJcFNxclUwSFliM0kyQlYrQjVlU096THpUb0VJNU1vWnpR?=
 =?utf-8?B?ZHFQTmFnVm1MVmRYODVqNjVUdWpxNk55eC9GbVpuTlU1MG1lQk1hdDRoR2l2?=
 =?utf-8?B?WWNFSFhsNUdLRnJrL21CaGNhUFdPWjVySGs5emY2VU1qbzJiS016SGdJZ0FS?=
 =?utf-8?B?UHAvVkZWMWJEN0VaeDJuNkRQWHhRM0hSd3lWd2dUeFhOc0JqbzdhT2V0SDRv?=
 =?utf-8?B?ZWJnMmpOL1l0L1dnSzI5cVZlTWduejQ4Nnk2c3JwZ2ZmTDU4V3g5VXNkSFkr?=
 =?utf-8?B?UzR4M1RxWUdFS2pMdnJwK0RRMWE2YlZ6clh4T1BUYmNrUUk5OXBqK3BRMzdE?=
 =?utf-8?B?QmVlVlR1ZW5idTc5bDJqLzRlR1VBMnpNV0RURmNCVGNDNDlrZjZKNWlpaFln?=
 =?utf-8?B?SHdJbHB3dUZxdkdnc1lidC9tQ2hMRXdubkViYkgxSVA2SWN1TkU1Q0wwTW96?=
 =?utf-8?B?QWFwdDR5V09EdGhxc3ViYkN2WCtSMk9kUUpTVkxuNE4xbjVkeWhiMzZjSUNs?=
 =?utf-8?B?YWVTUkp6L051U2M3N1ZKWGo2ems3WFdya0lhZW8wWEh1RDRSQjdTUjk5TFRD?=
 =?utf-8?B?OGNyeGlJaTBxK3p0S0ZlcktZdEh6SktmZmJKQTA0MldOUmxyL2hFZXREOE0y?=
 =?utf-8?B?K2ZDUVBBUDBFYzNUTGhGbk5lWGcrTVBhSVFNY1JHYVprWW9xMW1WSlJDaXg2?=
 =?utf-8?B?UGd1Q3JDb1lyQVJyUVZqc3ppMFhWTXIxUjYvZWUrTmZ5T0MyenNTajlYWGxU?=
 =?utf-8?B?dWNUTTljUjZJazRxWkk3UHZBQ0k3djFndVdKRnQ4N0duNkdLd1J2ZllJKytG?=
 =?utf-8?B?QjZQdjNYbGNKc0JRNWlLZjAzYk1GaGt3NEJkSzF2TmlibWhLL2xONS94M0dP?=
 =?utf-8?B?eGFCM3lNeXcwREk5c0hEcWFTRTc1Y3dJb1k4ZzljeCtKdnN6MDR5WWhrdDJK?=
 =?utf-8?B?d3N3Wi9kVW1aN1FWNTE1SDJGKytLRHNGa0RKblV3SXU5ZDNTdkZ4dXorQlRx?=
 =?utf-8?B?NXAxdmZmUDVsTjhaOExCUGRVRnNrQUhOZEVYa2xDYjgxVUtLYXNodDM4SDQ3?=
 =?utf-8?B?eUNPTjU3K001MDB1QmM0LzA4N2VrTUVYbTJOeHZnb3lVa0dmMDgzMDJFVHNa?=
 =?utf-8?B?L3RrdjZJQkxFR2pLK0lyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlEwNnZKMW9QZjVkdjVnUC80S2c1eDdaa0c3QnAzLzNraitWcUlWcnN0T1V0?=
 =?utf-8?B?cGxVQzFaWWUyTWltV202MTRRZGJNSW9tblA5VDJsKzU0WThjY25OcTJkOVli?=
 =?utf-8?B?WXpnMXE1OUpaRXdseGhHTjBTM1ZmL3pScnd6RDQ1WDQ4bXppdFdjUm9iZzUr?=
 =?utf-8?B?akllLzhPZ0drdldqTmFjQ2NwVXhPSDVXN1FLdUpCeEFPQjBITjVEL21DNU0y?=
 =?utf-8?B?S1M3dmowNTRTai9SZW9mWWxvaDBJUHFHazJUT0Z2YW02b3RxZytXSmlOY0d2?=
 =?utf-8?B?Qy9LVVcvS1g4SU1EZ25WekxoS0EyS0FhRmJqZ0ZUNHRVcUxXa3F1bTZpRjZ4?=
 =?utf-8?B?bzNUSThwUXZBRGdsN1JxenMyM3VsWURaOC9KUndhVTQwUmwrbW5GU202ZjFY?=
 =?utf-8?B?YUpRZ1F0ZnQ5dnpGWXI3dEl0clNobmZVUEJKbUlsZ0ltOE9DYlFhcmtKSG1I?=
 =?utf-8?B?d3pBcGd4dUI1WlFrU1hFYW1BaWtaQzBvSWVQQVhIeXprRVNjZE8vVTVMTjhF?=
 =?utf-8?B?cmpHbGtadzJIQ05uRHV5WDVqZDNtNm5hZ1NXZWFIamNBTkpQbE9YVnBLSEhw?=
 =?utf-8?B?UEhMcXRHVC9LQmU2TitQdFN1VHZ3VDVHQUNrcjdRTDdIcFhkcjlpQVhBbENP?=
 =?utf-8?B?eU9vN1FUSkVMdGxLTm9UY3RxbjM2OVI3YmkwckhiTEw0dUUxaTBuVjhXM21v?=
 =?utf-8?B?MHJFUjI1azl6RFkwbnpZajR2aVp3VnpaR0NUY1BBT3JoK1F2ZEl4OHBwREg0?=
 =?utf-8?B?VVhwVkRxd3ZCSlEyYzZ5c3JZSEx4REI5Wkwvajl1UURpaHhzbmU4dkhvYm1p?=
 =?utf-8?B?Q2VsSHFDODBscVI1eGFrV2JyeGt5NWZSTmRBc3RpelJYLzVqQnZsTVBadkxz?=
 =?utf-8?B?QWRaU01oTXpuWXgvS1RFRjk0WkszVG8wMHZpZEdDU1NoQzNlNVVxZ2cyVXNO?=
 =?utf-8?B?SnQ2SldoRVVXUFU2U1pwTHpycVZNTitiV2ljZ0puT1lqT25Hd0pSKzlESXl4?=
 =?utf-8?B?ZkcvUENmeC9Wd09WekhvTkFoVU9aZzlBcmk3ckhZc2ZRU1ZuTUttcEQvbmpM?=
 =?utf-8?B?OC9rTkdYV2hlZlVQSVlDYWo3a1BFZHNqQ3lJUXNVL0FCRjJHZDMxY3REbHFI?=
 =?utf-8?B?ekxGM1VwdWhVb3BOVkczc2o4dkZZQ0Rza3hsTnNJYjEyQ0trWXE0SWtBYXFW?=
 =?utf-8?B?U2hKQklxd1h1NzFsR0hGVzVSQ2hudVpVMExpYmdXbWJlR25BVldYVElLZXZp?=
 =?utf-8?B?M2FtYVFPYXFQQWF2YWN4NS9UYkFLUHpqanlGTnorQUt4VUlQMWlGbTVXd2tK?=
 =?utf-8?B?YmpiTCs4Y2Y2bHVBeEdlYlVzekFuWkVDZDdnais1SnlTVW1mZUhIaURrVjRz?=
 =?utf-8?B?U3BVMmxCM0R1bUo1MUpYVXg0dGVPaWF3T0VEWGFCVGpjRGpzaTBjbTZwOVQv?=
 =?utf-8?B?Mitzcm4vQmVOWk1WWHlERkxPU0hkVkgzWDhDVG9MbFNUNDc3Q29Kb3hoR2o5?=
 =?utf-8?B?b0NUK3U2YTBYQi9TbUk5Tksxb1ZXcTVNeXR4ZkxWZitjSkdxTDEzUWRkRWVY?=
 =?utf-8?B?b2YwSXhTTWJ4eVZUNFlXeFpzQlBkbUxydkUxM1hFU0I4M01ZRTlXM0hGSW5W?=
 =?utf-8?B?eDlpUDQ1NXF5YVIzc0FESHZRNXowMjdUSWNYQ2hrMFFrZU4ydVkxYk8zLzJO?=
 =?utf-8?B?TGJRZXJZcUtNYThkYTdZY2NOL0FJNzV2bkk4QTg3a3JQZmMvRDg0RkdJNVZO?=
 =?utf-8?B?UmVYcHJ1SklsUFdGS3ZJcy9hTXc2MmdsRkxHV2Z4YjdSa01pWGlFbFVQSldY?=
 =?utf-8?B?Z0NXK0RwNzRvcGlOOS9wWVdkd2dsaTFudTFlcWJPaGtFVXhtOFNyelREaTFh?=
 =?utf-8?B?TmlOZDZJLzZUejFCT09uc3VRS2lmRGZ3emtlTldGVE5pNVJYY2k2YUxld2cz?=
 =?utf-8?B?NSt5a3hmTFNtV1dmN3NtdERGL3ozMUVxQWZ2dGFGR2VVejNwbnNlWE5KWnA5?=
 =?utf-8?B?QU84TnBDVUVCSHA1bEg0UnV2OXJLZDZ0Ny9rb01PMG5iRXlrVnh0Y1ozZmtC?=
 =?utf-8?B?V2t2SXZKK2xsRFJRVmVKNk9kQnpGQmxWT2tETEExTWhxZzhDVGJ2LzViaElj?=
 =?utf-8?B?UG5EZXJuT25oOTNOSG4vYlpBY2hOQk9qdGVvNnAzOUdEbG1BU1FTRlFNWUQx?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViafmpIs7N3mRoz5g91+SI0gRNl5DJvDtQ75yPPbK1SilnJf1BeqsekVkzLhxLdz9roWuUs0DJYWvJcZxKvYuUeLcirxQIfjcT/k7cUKk/JWG7uPX+RRQeYrEw7Qks62iECJYStZnUgu1iqZvU3PXaV5mR5gJNYtR4H1oYsPlddOKeqqEwdEBPgpQLnKhVU2uRv8Vr1gx6fZCQkpui9Xge2re0jj786LZuvjo3tgpKp0WUkHpP9RnNrYmRfrhNOB5Qq6LE347/xMrst65imrus2Q//zf4kZ58uOqYaeh7fLYIFukbVS0kA3ZztDh4I1YiRp7aOtEKlecbLe8cvt+QBeDBjeY1MyX2SxlHUtmE4YDAAOwrh4W8Lm34eiQvVLyNdKgPphhzqkOx1lq9kK6zqm+vliBdj2woXHnFirtP9vLJ47zCQ5woVeNIJsCAZxEoetW72FrloAuewVdTW7/nIkFtbVyIBI8TTY/vse1XVjxCvQoKg7LcAOkp3l3BqtvqrqWYSCOlyNBLR+05YP2+5FJlGXRPi8c6t1ZlioIqpqhRuMIcf0vXNniRjmbYJ7GCo/LTTZaPHp2zW6j4uz7+Fsy8I7Uf59Jea+I4vRpdqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf3c736-da5c-4be3-9ffd-08dd7054ef31
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 13:07:05.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpMgE7oX+v9A5xKBpUmXMuHHIXZoVFkhXreKLSvRz+AlduyS+nTQ7ei9Y5mOmfmc6pO7v1OGQ9tzq8PTLGJ6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310093
X-Proofpoint-GUID: eShiUuREMU0N2pj-XvFOKoWcsCwzFcCw
X-Proofpoint-ORIG-GUID: eShiUuREMU0N2pj-XvFOKoWcsCwzFcCw

On 3/31/25 8:55 AM, Lionel Cons wrote:
> On Wed, 26 Mar 2025 at 17:59, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 3/25/2025 3:12 PM, Chuck Lever wrote:
>>> On 3/25/25 2:53 PM, Lionel Cons wrote:
>>>> Does Linux have some kind of RDMA emulation for "normal" network cards
>>>> (e.. not IB, not 10000baseT) which could be used for Linux
>>>> NFSv4.1/RDMA testing?
>>>
>>> Linux has a software iWARP emulation that works with standard Ethernet
>>> devices. I use this with NFS/RDMA in test scenarios all the time. The
>>> driver name is "siw".
>>>
>>> Linux also has a software RoCE emulation, same deal, but I don't use it.
>>> The driver name is "rxe".
>>
>> For the record, both siw and rxe are not emulations, they're the
>> real thing and they interoperate with either software and hardware
>> implementations across the wire. They actually work well!

Both a full-fledged verbs providers, true. But the RDMA itself is an
emulation -- host data copy, not offloaded.


> 1. Do they work in QEMU *and* VMware Workstation?

I use siw with VMware Fusion (the MacOS equivalent to VMware
Workstation) and in my nightly QA runs, which is with a virtio net
device under qemu.


> 2. Are there setup instructions?

The only snag here might be that your distribution doesn't enable and
build the kernel drivers. I use it under CentOS Stream 9 and recent
Fedora.

Here is some sample documentation:

https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_infiniband_and_rdma_networks/configuring-soft-iwarp_configuring-infiniband-and-rdma-networks#overview-of-iwarp-and-soft-iwarp_configuring-soft-iwarp

-- 
Chuck Lever

