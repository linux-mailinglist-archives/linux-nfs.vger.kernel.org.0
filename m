Return-Path: <linux-nfs+bounces-13849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2CB30239
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9EF7B4B86
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B024677C;
	Thu, 21 Aug 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yk0Azsld";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D9rhshuq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036A25A352
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801559; cv=fail; b=F0Ozdp9rFG68pK8ZDUpiHIWhxQsygXbIeSEDo3Ib7rtzomuRg8YFCtu74xUgfwnO55rO524nLkZOVsOxsil9FSyqa1zSYxuXLh7NzvsQ1MZvNfn+mdeDGpYWz8VIzvvJPhFAJ/i7Dp+RKva/fykJ3WF7I7/JxeOz1c5ceFFveLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801559; c=relaxed/simple;
	bh=TJ5OB7qPns9VPc06+m6PIq4V4eip1y2NGTj4tI7aeow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cUQVrCZ2HeWImpijlRBKlqRLQ/r5WWFS5z96buVoUjLmSsAnZo6+8QnFTLh5gVd2CGcPsMkiPvc5EAWh9bZoC4ezwMM5wFGlFjjWhVgOk1JUOLzL2r0fkL+U0w/SxSDTKTkGexqLa5Zod0os/dC6v7AOMUBdwsZkT6bKxHCgTiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yk0Azsld; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D9rhshuq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIVAfn015098;
	Thu, 21 Aug 2025 18:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PvjfqrcCPjYS6XY8YVxXp52r+FAIWjv/kxC/roNCOcM=; b=
	Yk0AzsldS1of31Qxt4YqBGJfyktoWmX007p9QzkWKysvI9G+Avf1J1lf4tGUxKOy
	6rSMRM9cnQbapcfWgqrI4twymqIUKt2KOJ+0pEV8xNzMsPppmuDVdlp9xFKOBx2z
	rJh/XtewV+jEHY+WLzqGmHYU8E+hP1zyA9EQcfAQP+Gl6WH+nZ5XIAuOnIAjQIeq
	o/BiZuoR7Am9J1xVmrRxkEGJ6QHNhy7Duu5cmib45wPcvNK4K7K/oBigyEdkr7Xn
	5lqdhZjeZwlU8WPsMcC6QKxAe521/4XyH3zoCj54ojhGyt1mD6Wn9ROI0SSn/omv
	DolLON1pQlH17JklXmWc9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2c64f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:39:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LH5lH9039447;
	Thu, 21 Aug 2025 18:39:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3sevxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvwnvZHHbCPv+vTUfxHsZIgrG8EWTZL3Tm1+tKgUG2gjOIQ/sqYEe/mbSwVBuc6zMNDL3TPqEMyYj7NUXhskEGIlIYf9gZel3yBUsQL2nEVDpQO6ZTaWTXEJpzj/0WBL+YG/AiW2eO30K8rQkDTytoiXvB1bYNEQqkdk6dMMkE3rYroQDRYo/6RDvwrrIxt0pAL9RahfqfI8mGJlm/QdheHkuJybGSxzYCI+oPJgyY2RLmagOhfPgn5s+7YVP6aQ1ZVEeHt4KiX/3tWjV+FlzSDx6n/zONIq/c1RWwLOodEZrhrxGfvbFaPldADROf5sbYq6A0e4HFC8vSdcf8rChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvjfqrcCPjYS6XY8YVxXp52r+FAIWjv/kxC/roNCOcM=;
 b=x1G5JPcAZaazEpFTpQ8glc+xdw8rUSyP6ozUVrhyJdjZG+48fITLc5PVB7IFY8UxEu44Po8UDAzm8+gU/JoaJ8I5gxxeZMfOoSVINO8HuKSggbTry6IIR/zK/Jl9Pn7Z05b219gN6Zxv9+gTGEiEMaY8i/QkZRh/lzNov1gz9zjH0zWeoQhv2eHyZNGKjsHBCs2LNoB9x+H8hfQqIgz3uRfZAoRxYhauXRVwjGMsyi9JN7fQJrsgx/tmI0BC+YxYm7m93Y9nNahOfGBTacHajlMgKaV5ON5PqxS3R0XIq9q/nLcgDJncmHI92rj3t//S87Dcs4N3hLOGjaH/tsEZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvjfqrcCPjYS6XY8YVxXp52r+FAIWjv/kxC/roNCOcM=;
 b=D9rhshuqhBiDcn4G2gojO4OQZX4bH+DFc1IDEPLO8GGgKAfZJgWkIAMmmv4c1jlKZFcoQcKpg7LyuF0xXTbifSqO8wKot2tvKpuqNBcRDWhsxa4pQH99im73h3gTIEFkTa4PuKcHgjxilTZPuZvbHQzSrT/YQzgnzZHyF3Xj8PA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 18:39:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 18:39:02 +0000
Message-ID: <fc97f4d3-6f0d-4ead-adb5-68cea81bd38f@oracle.com>
Date: Thu, 21 Aug 2025 14:39:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
To: Olga Kornievskaia <aglo@umich.edu>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
 <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com>
 <CAN-5tyH4qbcxLDaEnnFABHSC3DPpHmMk8O+GEOX1BubfLS5cww@mail.gmail.com>
 <f54c0edf-18b3-4432-af0b-7caac995fe01@oracle.com>
 <CAN-5tyF7wqG6_n_x4rNCKeLmkChGDA74TWduun8HahVuHfHbZw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyF7wqG6_n_x4rNCKeLmkChGDA74TWduun8HahVuHfHbZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:610:e5::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef99c62-4b99-4a29-c22e-08dde0e1ffa1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z1dHV2VlZVIzV3V6bFY1a0R4K0RrM09CaDIraVFycUE1YnpzM2hRQnBiU2Fu?=
 =?utf-8?B?azVYMXRXWHJoeUZmdENCbGw0WEsxZ0grRkFNRDdtZW9UMXlhMzNTQnpIZVQz?=
 =?utf-8?B?MS95VXQ5bDgyT2pRODlEcmNVUmc2WkVNRUp1dG5sb243NERrZnNOUCtaNm9l?=
 =?utf-8?B?M2xOQUN6bTk0TVpOb3UzMGRseWJhMHJCbllDRVhYUWZJdkczZkVsYTQrRThx?=
 =?utf-8?B?bUdDbTMzZXVCM2xwUTFkRUVON0xBb1FxWjc1d05waDBvQ0hicFhZbXBUaStl?=
 =?utf-8?B?NVN2ZkhKLzFadU1ENVNDRFlKQzdoL040YjB5OWJqTkFIeDNRTUhKeFYvR2ll?=
 =?utf-8?B?TmZKZ2EvRXI0TVY0dmpJVjZ1RDQwNU45eHRBVGpOY1ZsNkMvbHZGWnFHM0JE?=
 =?utf-8?B?ejFpRzc3Z29tRUtzc012bHdTOUVpNmxaWVVWSURod3Y1UVN3V21BV25nalVv?=
 =?utf-8?B?WDk1VWwxTzNYYnVPeWxzUzd3WTh2bHI5SGFXaDRSZi9ETnpVNmh1d01NWjFH?=
 =?utf-8?B?cDFLRGk4amVweHZ3dzZsOHYya2V3MW51d1JQSHhqL3dLcWl6Lzhia3ZXcng0?=
 =?utf-8?B?T2ZMOW9Pb2xzMFBtQlYzRnlGNHhNYUFucXJxWmhrazY4ZjUzVk5TZWpkeDZw?=
 =?utf-8?B?Uys2Wnh1aTZTaXpUVHhnZnk5NElUcXQwTXk4ZnhDb281clJjN1l4aWZXNTN4?=
 =?utf-8?B?S1YrS1l2TFI5UFNMODdWZ1ViRUdiSVMzOTJVMm96UkJaZmtLSzl6V2M0RnNu?=
 =?utf-8?B?Vk9LbzROWmxud2tmRzNsMjZmOHlnTFYyekNOOVI2OHFRTWNucDlwWWZlYkpG?=
 =?utf-8?B?RWlWS3ZFcElkV2tSTXc4dUVtdi93d1puREI4QzlMdFdkVCs1Ly9YazVrOU5h?=
 =?utf-8?B?cEk5VC9WUXZtck1hNnBiTEFKa1BVOGJ2T1FQWDJhcFFtMkF5Ylg3R1U1TUVB?=
 =?utf-8?B?S0ZiMy90VUV1aVFFRExMWHNDRFQ5SzZhd0pLZys2ZEM5TDJ4emo3NW9SeUNW?=
 =?utf-8?B?cUQ3cGpXbXYrdmFwbHZuNlBBTUQ3NEx4aGl3T0JPbzlHVVhKS0JBbHBwQXVm?=
 =?utf-8?B?bzV3bWQvUzJMbWZpVlo5K25uREZzNk9zMVpEVVN1ekJGV2FXRmdiYWQ0S1Ru?=
 =?utf-8?B?dndSSkZUT21kMVRyZzRMZ21wVnY3ZFFTVzNmcWdqOWF3YVhTcVQzZjNQZENW?=
 =?utf-8?B?aVpreFkxMW5RTWJBbDBuNTRIM3JHTXVDNHdVOUk3bW9JNlpicWRybndjMHBn?=
 =?utf-8?B?bEdsZENaa0VJMTBERGhIK2lYeVFraTZzeU41YTJMWHk3L0xWdDVrODhNRUNQ?=
 =?utf-8?B?cXZSUEFnL0pSS2pWbnkvL09ZKzlKd2FHVk5oOFo2UnhLYktyQ2R5bXM5QXcr?=
 =?utf-8?B?b051QzhTZmpDcjhiNjk3SzFGOEp6SnljYXVNeFgwVnNTM00xVEFSei94VmIv?=
 =?utf-8?B?WU84TGJrY1JXZWVPaDVyQXl4NDZ1cGp4ZzByZDZmbVVBSDFPRWZ5RVBhZEFQ?=
 =?utf-8?B?YXVnSjlUdU1ZR2h0ODR0QzFsU3AxbDRuL296VHpWTW92WmdUUzNheFl0T2dw?=
 =?utf-8?B?b3NHTHR1VDZvczZVOGJyV0NUYm4vQ1BVcWh4NmxaNUxXaWljUDhzandyM1VI?=
 =?utf-8?B?VUxoUXdsK3JtU0IyTVI2aXo5bUlTQXl4NEFVb1Zrd09KcmdZbldITUZ4MVNa?=
 =?utf-8?B?WkkrbFhSc3BCS01Ja2pwcXFLcWR1aE51a0NuT1MydFhVNGduVVMyUFVzb21S?=
 =?utf-8?B?S3FMT3ZjQ0p4NE5rL3M2aDJEVjRJVEU1VHlaRG1pSzNmeWdWRS8vaDQ4cUlY?=
 =?utf-8?B?Y293dnV4VDhSU1dLd1h1d2VPUmNQM3R2WlNjNHY1RTlvSVFINTFENDZEZjV1?=
 =?utf-8?B?UmM4Rkd5YzZ3Yzgxb2lJK0hJT3hvRHFYSGxxWlJVN2lwUW8xQTMzdGJhWUhX?=
 =?utf-8?Q?DO9fxEt2SkQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RnlEc1A1amw4OHFxczJ5QzdVNVNHV25QSEtaU3dWUzNYSTBJUmcvUjFqQnhn?=
 =?utf-8?B?U0lEaUN2Zzg5UGtScmpuVk52cU9LcWM3cSt0TDl0MWRXcGlnd0dHMFFRaTNS?=
 =?utf-8?B?NVc2RlhYQ2luMStFMTVMQm0vRVNDenl3NkMrZHNBaWFqdEtRZHEzOXZKSE91?=
 =?utf-8?B?djZTM2drbU5JVTJqbXBMWDdEdVo3T3lJVmE2QlJ6WDdYa0crUjhGSU1obWFN?=
 =?utf-8?B?bW9sNUtGR0t5VFJGZUlRTXVySUV0QlMvOXJMVm1ZejZObkdSSXErZjhNM1Vo?=
 =?utf-8?B?aVhFcDNDM0hoczVWVWFQdEt6UFpRL2hiR0hyd0JwbjVxVnlhV1FUQXVvRWdo?=
 =?utf-8?B?a3BKeGk2SWZwMGZ5dmpRMjFvbHFJdW5udU9vNDR4dkZ6OE1nTnR2U2liQnB0?=
 =?utf-8?B?OUZ2UGoyUkdWUmVxRld6a2hDSzNoaHVtVE82QXA2ZTZBalpVVEE3ZWxHWm55?=
 =?utf-8?B?VkI4Qks5Vjk3STRUNHY4RVM1WThSSldmcFY1RUF0eGpEWVUwcjRNU0hSVTR1?=
 =?utf-8?B?dFpydWs4U25XVmhuOGhmVy9KL3cvZEtlV3BaUkdEdHVEbm9CK0djSWdZRytO?=
 =?utf-8?B?TmhmOWR4MFlxRXJCVXo3RU5CS0c2cjhmTVhiejl1Nllha0ZOVmo5SVMrV3Nu?=
 =?utf-8?B?N0VIVXQySTN6a0NtMUlCMUVCL0h2SUhEYjdSdW9xbEJBc0NqUmNTSzdnRVB6?=
 =?utf-8?B?elVsc0c5WXR1MTQ3bHNEL21mNmNkbk5uNE9MZXoydXRPTExpTkFVZ2lkekds?=
 =?utf-8?B?c054WCtFc3Y1YTdJZmRUOWRiUWd1MnZ4NE9sbHhrM3hsRyt6RFZ2Nm0wYS9P?=
 =?utf-8?B?SnJYVFZ2ZTFScjhScXNJbmZ5TzJtTmIxeldqS1ZVaGVDd1lwYUY5MjRiVHNi?=
 =?utf-8?B?RDFWRm93R0h1ZFdhQzJ2QXVyZzF0RlA2TE1ISGlDOVpTTTJuODIrK0plS3U5?=
 =?utf-8?B?N2RjeUFyay9yV2tCcHgrZUlYNit6MU5SSnFqMm1sdFAxL0FadXpXYVJEK3dW?=
 =?utf-8?B?alNUQnVEUDBWN0ZyaXNWalp5MDU4aUdRUGZKckdJTkRzeXRrY0dIU2NZTG9n?=
 =?utf-8?B?ZjFKaUxCalNtVXljeU5RU0szQWRkMi80U1A4dWluQ2lYWENKOUpNVHdLMXZX?=
 =?utf-8?B?UmZwWnlLdDFuVG4vb013QnpsSnp3TDRGMkdvQkdqMFRXZm0yZmF3MWRvK2RR?=
 =?utf-8?B?Z2svYTZHZFc0K283T0c5V25aNDlLUmozQmlNOGg1VlhvWlorM2RVRGg2L2Jx?=
 =?utf-8?B?ZEdwUnErUlArbnE1WkVRcG85M1c3RHlEeXN6WFAxS2gzYktXS0x1NWtLV2hX?=
 =?utf-8?B?RGl1K2FvSXovanM3c2FBb2c4NmdFekNEN1F2WE9ZMzRpZWh1eE5rYWZJVW56?=
 =?utf-8?B?OGJQWDlDcnRsRndLQm8xTVhYRE9rUWhMR1FaQjlBT0RuVkpDcndZWWRPYWRT?=
 =?utf-8?B?VU9kdk5sVTd1ekswZVNCbjVaZUJBZnM1TE1YWnRKUkw0T1RtNlhUK0FpSHRj?=
 =?utf-8?B?V01SY2VRWUpJc0xyakpxTnBuS0pHYWhKY1JFRnRzVEhucXdsWUVXQTRSK2d4?=
 =?utf-8?B?aGNkMU5VVHhQWmxPa0M2M0ZCOUpGNkVhWmtGVm9Tam5uRG1PWGl4d0hnUlI5?=
 =?utf-8?B?SGhRdXN6aThIcUhUQlA2NGJMLzRFeERkZ0NGdk13YUVxNGhmNWJTS3M3dVk0?=
 =?utf-8?B?eU8zdjVaeXhMcWlTRWpxL1ROOVRWNTYyTlEvdFpuYlY1WE1iWXN0V2plV3hL?=
 =?utf-8?B?NG4xMjNQWWp4NlIyOTBmTks4NUQyUk13cGJ5SWwxbHROa24yenllUTB1dG9K?=
 =?utf-8?B?LzdBaEE2QTdtZ1pLbktTc0hRRHhiZy9ydWVSdFlIZWRSby9yRk5BWnNUUzQv?=
 =?utf-8?B?aDIrUVdVdlhjY3B4OHlZTnc3QUx6RUNMTEhIeTNzeUs5WDJWUEJabG8yYkNT?=
 =?utf-8?B?NlpwRWlnL3F4M3BKdEJnN3gzV3YzdWVzOVg1U1FuTWkwR3NtOTZsdVBPUGF3?=
 =?utf-8?B?T2d0VFRadlN3QVBlZnF5U3F1YVY0dXVIZW4yZlJvT3ZNR2NkT0xHS0ZLQWNS?=
 =?utf-8?B?MytNNDlLMmkvQ2ljSUxUTXZPbEhyV0JBK2FEVUZNd0pRRHAzV0UrV1VqOGlU?=
 =?utf-8?Q?VqsOAhVOPNrPn3kXKGET0WyIE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y9cB99kxWKKbMIbzrslDPD+ddS9j2t1BAGj1tgOQ35tKThNz++QBrkUfoPl02TMi/wlXvrW8osCkC8ReMIAmzvXFwBkohvyAD8U2IncDThL6pBbWgJMH+3jPRTFB9LUTByx2qXzS8IVRXIZIUnEqAouhJaRy+4NKrsbOKzmtpCY647ZVhH5lH1MTGy94Y8P11tBnPjodkRYYW4IXxNNz9+jF+HZFE1YbEApQeJtACMFn1+p7xh4dAGWPLEZAUpzAJF064hfXE22ZXHq2ODbSkdFEAlJU3Ys9KmG3p2I1zXKQY3wtulKNfnLO+wPMXe69mJweUCuWvdJeL2cmK6rSOlQv7BXiUDOVSJMw3DwWSly6GvewEbE775wxI3151omChTD/DEAH/a22JEJWI5xuklxvjW1I9RFIYdZNQlK0eHlIfMheUV/g9ZIii6SVaMfzqQirVab1LmBszsp2eA7wnn6maG0I/KGCTpn2sqLExX2Xh9NJkvx3nquXK53wKjwQyLCisn2YPl2NvIHfdQnc1pI2ZWZZeo13ulfpE1aL7P+4cEP07e/EKWgbdij9hP02Sm70AZapLinNPTPY4lXs63B7UeLPDlR7/kzSVYbrYhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef99c62-4b99-4a29-c22e-08dde0e1ffa1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:39:01.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRX+sNFXglxwwMq1AVgMUn+7pfiBf8FTecSkuu/gnSSEnHf5Ls2jqXRj+RLq35Dnba5jh1UAlVNNK8uSkb8ajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX0iDxRfNkVllO
 fKrjn9OUtjfzrqvuuwM4W08Hk+H7qooZI2n+UDMAibxOxWj5yR7Xj68VSZWsAqva/jF7Ni0Due6
 CSQTi/gC7LLr21WEy7VEAYmnFcAbe5mY3l2LIlyROxPq7lULpemB0ulW639wT8aG4Q7A6mDjXfw
 sBSG6zFnlz8gDt/Dg+6ZV7sxWMjc7PTXQNhE3Ucs4Xs3AurciR8w4jt0wV7wT2qQi8p8kgwrdOi
 hPBhdX6Yoh8Nwygw5BxJDAsthvBfIEwkvpXJmVz5X58NWk7abiTBzGkJB4XpOZ+dE9QP6PDTHiW
 JTlkOG1LlCBVanIYCzZVCM/q8m2nfltKNGbTZ16EA6IJq+YZUnHpUHOY8jtubZAX05cPr/PH9rp
 WcO/ZE96jgpeN9nYuJqo4Zeg3o4a6w==
X-Proofpoint-ORIG-GUID: nrapE1LzhcWGfpHQ8wf1qvph4MuZjQgN
X-Proofpoint-GUID: nrapE1LzhcWGfpHQ8wf1qvph4MuZjQgN
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a767cd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=mJjC6ScEAAAA:8 a=bptA5gRWvt6BbVuIOGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22

On 8/21/25 2:33 PM, Olga Kornievskaia wrote:
> On Thu, Aug 21, 2025 at 2:24 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 8/21/25 2:20 PM, Olga Kornievskaia wrote:
>>> On Thu, Aug 21, 2025 at 11:09 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
>>>>> On Wed, Aug 20, 2025 at 7:15 PM NeilBrown <neil@brown.name> wrote:
>>>>>>
>>>>>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
>>>>>>> On Tue, Aug 12, 2025 at 8:05 PM NeilBrown <neil@brown.name> wrote:
>>>>>>>>
>>>>>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
>>>>>>>>> When nfsd is in grace and receives an NLM LOCK request which turns
>>>>>>>>> out to have a conflicting delegation, return that the server is in
>>>>>>>>> grace.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>>>> ---
>>>>>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
>>>>>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>>>>>>>> index 109e5caae8c7..7ac4af5c9875 100644
>>>>>>>>> --- a/fs/lockd/svc4proc.c
>>>>>>>>> +++ b/fs/lockd/svc4proc.c
>>>>>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
>>>>>>>>>       resp->cookie = argp->cookie;
>>>>>>>>>
>>>>>>>>>       /* Obtain client and file */
>>>>>>>>> -     if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>>>>>>>>> -             return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>>>>>>>>> +     resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
>>>>>>>>> +     switch (resp->status) {
>>>>>>>>> +     case 0:
>>>>>>>>> +             break;
>>>>>>>>> +     case nlm_drop_reply:
>>>>>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
>>>>>>>>> +                     resp->status = nlm_lck_denied_grace_period;
>>>>>>>>
>>>>>>>> I think this is wrong.  If the lock request has the "reclaim" flag set,
>>>>>>>> then nlm_lck_denied_grace_period is not a meaningful error.
>>>>>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
>>>>>>>> getting a response to an upcall to mountd.  For NLM the request really
>>>>>>>> must be dropped.
>>>>>>>
>>>>>>> Thank you for pointing out this case so we are suggesting to.
>>>>>>>
>>>>>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
>>>>>>>
>>>>>>> However, I've been looking and looking but I cannot figure out how
>>>>>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
>>>>>>> happen during the upcall to mountd. So that happens within nfsd_open()
>>>>>>> call and a part of fh_verify().
>>>>>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
>>>>>>> from the nfsd_open().  I have searched and searched but I don't see
>>>>>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
>>>>>>>
>>>>>>> I searched the logs and nfserr_dropit was an error that was EAGAIN
>>>>>>> translated into but then removed by the following patch.
>>>>>>
>>>>>> Oh.  I didn't know that.
>>>>>> We now use RQ_DROPME instead.
>>>>>> I guess we should remove NFSERR_DROPIT completely as it not used at all
>>>>>> any more.
>>>>>>
>>>>>> Though returning nfserr_jukebox to an v2 client isn't a good idea....
>>>>>
>>>>> I'll take your word for you.
>>>>>
>>>>>> So I guess my main complaint isn't valid, but I still don't like this
>>>>>> patch.  It seems an untidy place to put the locks_in_grace test.
>>>>>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
>>>>>> making that call.  __nlm4svc_proc_lock probably should too.  Or is there
>>>>>> a reason that it is delayed until the middle of nlmsvc_lock()..
>>>>>
>>>>> I thought the same about why not adding the in_grace check and decided
>>>>> that it was probably because you dont want to deny a lock if there are
>>>>> no conflicts. If we add it, somebody might notice and will complain
>>>>> that they can't get their lock when there are no conflicts.
>>>>>
>>>>>> The patch is not needed and isn't clearly an improvement, so I would
>>>>>> rather it were dropped.
>>>>>
>>>>> I'm not against dropping this patch if the conclusion is that dropping
>>>>> the packet is no worse than returning in_grace error.
>>>>
>>>> I dropped both of these from nfsd-testing. If a fix is still needed,
>>>> let's start again with fresh patches.
>>>
>>> Can you clarify when you said "both"?
>>>
>>> What objections are there for the 1st patch in the series. It solves a
>>> problem and a fix is needed.
>>
>> There are two reasons to drop the first patch.
>>
>> 1. Neil's "remove nfserr_dropit" patch doesn't apply unless both patches
>> are reverted.
>>
>> 2. As I said above, NFSv2 does not have a mechanism like NFS3ERR_JUKEBOX
>> to request that the client wait a bit and resend.
> 
> ERR_JUKEBOX is not returned to another v2 or v3.
> 
> Patch1 (nfsd: nfserr_jukebox in nlm_fopen should lead to a retry)
> translates err_jukebox into the nlm_drop_reply and returns to lockd.
> As the result, no error is returned to the client but the reply is
> dropped all together.

If you want NLM to drop the response, then set RQ_DROPME. Using
nfserr_jukebox here is confusing -- it means "return a response to the
client that requests a resend". You want NLM to /not send a response/,
and we have a specific mechanism for that.


>> So, if 1/2 has been tested with NFSv2 and does not cause NFSD to leak
>> nfserr_jukebox to NFSv2 clients, then please rebase that one on the
>> current nfsd-testing branch and post it again.
>>
>>
>>> This one I agree is not needed but I
>>> thought was an improvement.
>>>
>>>>
>>>>
>>>>>> Thanks,
>>>>>> NeilBrown
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
>>>>>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>>>>>> Date:   Sun Jan 2 22:05:33 2011 -0500
>>>>>>>
>>>>>>>     nfsd: stop translating EAGAIN to nfserr_dropit
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>>>>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
>>>>>>> --- a/fs/nfsd/nfsproc.c
>>>>>>> +++ b/fs/nfsd/nfsproc.c
>>>>>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
>>>>>>>                 { nfserr_stale, -ESTALE },
>>>>>>>                 { nfserr_jukebox, -ETIMEDOUT },
>>>>>>>                 { nfserr_jukebox, -ERESTARTSYS },
>>>>>>> -               { nfserr_dropit, -EAGAIN },
>>>>>>> +               { nfserr_jukebox, -EAGAIN },
>>>>>>> +               { nfserr_jukebox, -EWOULDBLOCK },
>>>>>>>                 { nfserr_jukebox, -ENOMEM },
>>>>>>>                 { nfserr_badname, -ESRCH },
>>>>>>>                 { nfserr_io, -ETXTBSY },
>>>>>>>
>>>>>>> so if fh_verify is failing whatever it is returning, it is not
>>>>>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
>>>>>>> translate it to nlm_failed which with my patch would not trigger
>>>>>>> nlm_lck_denied_grace_period error but resp->status would be set to
>>>>>>> nlm_failed.
>>>>>>>
>>>>>>> So I circle back to I hope that convinces you that we don't need a
>>>>>>> check for the reclaim lock.
>>>>>>>
>>>>>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
>>>>>>> delegation recall. it can be a memory failure. But I'm sure when
>>>>>>> EWOULDBLOCK occurs.
>>>>>>>
>>>>>>>> At the very least we need to guard against the reclaim flag being set in
>>>>>>>> the above test.  But I would much rather a more clear distinction were
>>>>>>>> made between "drop because of a conflicting delegation" and "drop
>>>>>>>> because of a delay getting upcall response".
>>>>>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
>>>>>>>> (and ideally nlm2) handles appropriately.
>>>>>>>
>>>>>>>
>>>>>>>> NeilBrown
>>>>>>>>
>>>>>>>>
>>>>>>>>> +                     return rpc_success;
>>>>>>>>> +             }
>>>>>>>>> +             return nlm_drop_reply;
>>>>>>>>> +     default:
>>>>>>>>> +             return rpc_success;
>>>>>>>>> +     }
>>>>>>>>>
>>>>>>>>>       /* Now try to lock the file */
>>>>>>>>>       resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
>>>>>>>>> --
>>>>>>>>> 2.47.1
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>
>>
>>
>> --
>> Chuck Lever


-- 
Chuck Lever

