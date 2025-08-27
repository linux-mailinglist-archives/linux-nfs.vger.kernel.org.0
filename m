Return-Path: <linux-nfs+bounces-13914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553DB386B6
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE61868105F
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC31DF268;
	Wed, 27 Aug 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GRrc5kIv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OmDXteuM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AE156C6A
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308854; cv=fail; b=rR98kqTGdQQ1VCSaMxteKZv/jEck5FVJa2wMyetV1w/Zhlp4ltTEQiq6uECY6/Ox0Kt5R/zuQmShQCKzM8IIMMKkYnf7VVrick2d1tCc+5oc6nunZc7MPOA4mkKWfiKxP5hPDVNuHGpydVzSJDXK0oeOLEsUvft+vxMSejtjJas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308854; c=relaxed/simple;
	bh=w/dbEntxqEeklzJLIKaEsc/WBKG2iVMAaNf+E1saXKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZQlu9p7Z52Ng1CtNQUN+jqiAQRGB9qotwGSMNk/cpfzo2FZJf9KJFb+Lc6wIxQl70RFxgkTPLxvG+BPACfm0sjtYJ8Zw7YsHyovvG6hrUxfCeaaAG0Pr7YoqkmkM31QmThJtdn+isILWGFssjG/sJF9BacsIVZDdrC6Ir+HVSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GRrc5kIv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OmDXteuM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7trlP027679;
	Wed, 27 Aug 2025 15:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uE+jNH36uBGTgP8RgXjreJLmmHyw2I1XYhzYy5+T/dM=; b=
	GRrc5kIvdJz5BnS8uubGjV9ffxtiVsSb/2CzAHWCgsh1KSHgNHiOea7zprqX4ojV
	5Ct+ORyqmQMx9yQWLPNQFtc9uWG/Dg6XwTrzMfrrgS1UQ4DumrIw4p/TP/L4jQj6
	L+xwD3MkQe60wE8uqvaJ3/CZVbSE7rTv291X0ZM2l6nlAdVbPf5K/v3BwRrW1rzS
	+GjNK9ch5NZ7CKQk5sCw88AOvwVc3eWblV3ilY1hIH9jyTe4mdFg4MFLeq2uqtUN
	tAgatdH4oOMhCFGhGXSLWzsaBwipur4OBIGTQ2G6KpCeYCKYfAHlB4PdVi4Lw6/t
	6K8/BJp+ICq9FctAH0E8dQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678xqsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:34:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RElOTJ004977;
	Wed, 27 Aug 2025 15:34:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43axy33-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq29zs5hyCHPLs8qpx0/dmJO2Gf1uRlj1oYn2cnvgOa0F4M7uYhoFT/90DJeJrT9HjDc4rPOLZY6cVFJfN//MvExzS18xGfJ6gBI97aGkzCyTW9qd2BrfwRkUUjzs6Q4GwHGm7gceZBAdoMUdBYG6qhLvISc0gx/uUnkpymgA8XPXw1CgWW7e8P8e1UQQYXCcndFmn6JHtcO+rXPotPdCxya5cUXTCtK+CfMiJFFUIS2eZx6au8A0oY7GRb3RFunekxz/fs5zX0Qj23yz/qDRT5NTeGxn9HnRUfmYVzvi54uN4crC8figNwn5IDXIYCTRQkby2Ep/m4MrA9um5nKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE+jNH36uBGTgP8RgXjreJLmmHyw2I1XYhzYy5+T/dM=;
 b=mjWImAi1DLt3Qx+M04s0dlUC14l1Wt7OFQjescB43DTEkIWoxMs0UFb2V+zWy/aPiMPgG7dq+KIG1VzNiAWYwiw2f8zAZa/8DK5QxD1EUkXSo+wmnnBlgdjlqaGWfwjKfX1+ZMOPnmz2YFBDquS47t1P5FyYDjVlUPyhb4TQGnDa73FZSfPNILHk5JE/dQTP8Zg1QlenqV0+PZ11q89/zSu9eAs+wf3iIa8F4fYciKRinyKNbfHmba3cZJqwxHVjVaEf+C/XgsSGNNlEH8OlpwIYUdGwUJCOqsstou3ANC8fJdnT4vAnEKUx5BcvtAIcbeir8aAkKAxBQpB8exphKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE+jNH36uBGTgP8RgXjreJLmmHyw2I1XYhzYy5+T/dM=;
 b=OmDXteuMulTO/n1EeuQnkEJ4HDnAL9yQzXXbWKNQEv6cCfHy66dYjh7JxEFjRT6V4Z6WipuAmwxaw4x45V6UjKvWMux+KCVH+EM5lC/T9b+YXVzDh5b/kXVvOA60dxYxcmO0LaxyP6xfOHIh0Oy/hUVxQx2qoLmPwzZANeIY7D8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 15:34:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:34:05 +0000
Message-ID: <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
Date: Wed, 27 Aug 2025 11:34:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250826185718.5593-6-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a20c11-092a-427a-c27c-08dde57f2824
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SkFZRFF1SmZmZDFjSmFtZGlHM0gyTGlqM1MzakVnYktWT1FsSkNCWGU1dnZV?=
 =?utf-8?B?M1k5NkdYaW5zOHFvMWpkYmVsMDd1QVYrWlNxYUhBVS91cCtydG1jcWRpS0dq?=
 =?utf-8?B?dUcwMmhkRUVZekpUMU16VHFEU0ZtbmdaT2xacThHWkhPUThKNUY1aW81d0to?=
 =?utf-8?B?SGhvRkFPQTU3VXoxaDJyQkVQQlpJVzliL210THFZV0JCeU5ndWRTRUlSUXY5?=
 =?utf-8?B?YkNYbEtOMWJqaGxZQytjMTlZWTRpT01yejBIVlRQa0NqL0xSeHIxU2ltN3Js?=
 =?utf-8?B?S2gzQy9KSXVSTkFmcG9zU3dKT0xNSm1ML0xhV2dKbDl5RVNuMXV4UU9MWlNG?=
 =?utf-8?B?SkxDRGVuTGV1LzNNSXVPV2tONXgvd3hrR0pwRjBLLzFwSWlBSkpPVmZjdW0x?=
 =?utf-8?B?Y0pKTzl6QlNmRE90djdzWFV1TVg4a1g0aXV4V2E1SUtNMGcrL3Fpa0VNSWV4?=
 =?utf-8?B?T0dyRjBTOUlCU0pyMTBicm93NG1BcFVkTVlYZjRhL1RHTW9UNlloY3JiTlF6?=
 =?utf-8?B?dDJWbE5QeC9ONUFJWkdyTVhpUVllUDBZYnFnbkk0dXN2R3RwMHd0ZGk2bGs5?=
 =?utf-8?B?SVBDVi9mRlhGRXM4SXBYNnJ6Tzk1NWdUUFg5ZlpTVzNhejkyRXUyVWJXZUVt?=
 =?utf-8?B?b3l6ZFRkQmxpM2xtOGljTmgxUnd6eEw4ZlN3eHllNnM3VHNwQURQVHFKcVFr?=
 =?utf-8?B?bDUvQ2tzRTlycStEWEt5RE8zd3RVclc3WVJhRjkveUxUMWJCWVdZQkdBLzFX?=
 =?utf-8?B?RGxjLzgrYUhwMjhBN21SWVkxR011ODVob1BLcDB6a0JvU3Q2a0ZIaG1pYTRM?=
 =?utf-8?B?S1N2VVpScW1ObVY1Q0dXRDdOeE52anVhdDlyc0RlWjcxUFBvYlQwbjZRZ3V2?=
 =?utf-8?B?VmRGbzVMdGF1ZDA3anFtT0dIeTF1cktWT25nZzN4SmZFNGV3MzcwUVBSVEc3?=
 =?utf-8?B?MUVKTFduQnFiTmdUbmhMckFVR2o1U3h0WVhHNU0xYmNtZVZEZXZ4cW1BTkh0?=
 =?utf-8?B?YjJVOGZ6ZXgvTUppL1Y2dUlJV3cyYWh0ZlIwcVJGWjNlMU1ISlc4ZTBqaXJy?=
 =?utf-8?B?WlpVbXVONkVpUTVsWGpRaEZWSTVvTmFoMEFsYzFVT3c1R3FLRGh0OXBiZC9J?=
 =?utf-8?B?Q0VLWFo1T1Z0dk4zbFY3VHhHK1cyMENFdUhnMCtUQ3lieThHOHpXMXVabGxK?=
 =?utf-8?B?UytCcytubkJ5Vm81WGV5bCs5aVh6L3VQVHE1VHhEVDRBc2dNeU1Yc0JFR2Nl?=
 =?utf-8?B?SDlzemZBNUVLS25OK0Q5UFN2Q05lekZCL1ZqdEcrUi9aYWNRVEZwRjYyclZ2?=
 =?utf-8?B?K3E5VzRISjdDK0hqcW9KL003bGFVVFYzeUdFYk9NQlEyUWFudlJnMm0wMkJZ?=
 =?utf-8?B?aGtEUUtpOHp4VjY5UkNFd0J2dkVtMzA2a2NLT3R3ODRrLy8yS251TVZ6Q1F6?=
 =?utf-8?B?ZUwrcllSRTl0SjRGTEM3NlJpamQzTWl4SDg4K2NZbUkzUlVYc2haK1Q5d2Na?=
 =?utf-8?B?QjU5ZC9wd1dhQ0RnK21pc2ZDeVh6RlNOYy9zMUZRWDlHN2pLNVlxa0tRL0ZX?=
 =?utf-8?B?bko3blM2bmN2aU0zYzNIQjRnYTZ6b1R5bk1la0dMMWhnc3V6aVZWZyszakxI?=
 =?utf-8?B?K0VWTWEzM1Y5eklCOXBZa1RvdVQvbFZ4US9zbUNhendPRkt0VmtXUVIwTGtH?=
 =?utf-8?B?NkI3akFPOG1IcnZOWWNOSW9RSXBPRUZMTGtKcTg3S3dTM2NTb2tBd2FNYlhx?=
 =?utf-8?B?MU11di9ZYXp2TVpONTVGamdZRnZTVzNjVFBMYXlEREI2TWdyTUdIVENIblYw?=
 =?utf-8?B?cnhGaFV5Wk5RMU9hTTJQZXJGRjJheWQrRmpPMFhzVkVZK3lQaitwSlJReGw3?=
 =?utf-8?B?c2EvNm1qVENmVnhnTFlFSzdibnJDZlFrTUdZUEZMY1o5dmdoZjdaV0NxcWtF?=
 =?utf-8?Q?UpWL/Hx0Zjs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SGRyb2lkM3NUa0wrS1FISlJ4cENKVGJGOURiWmFyZThjcnJMNWVyQ04zMnJQ?=
 =?utf-8?B?NFJwSVVrV3duUzl6cFdGWTkyMmRRWDQ2cHpoNkIyMVRqc1NkbzQrcFpOcko3?=
 =?utf-8?B?L0tJek5YTThvOW9YN2RoQkhjc1lZa2FqNkFSLzBPR1JnMnJTdWpvMjhUTmZs?=
 =?utf-8?B?TmFCbWhaQ1RyS0xKUHVpaC9KUi9oMEZZdE1naVNJVGlhOGZTOG1oZXR1RXF0?=
 =?utf-8?B?UjZuWkREb2VQZHI0ZldGbXhDc1V3cDErWXFZSHozVUM0NVo2aG04bGh6RWpx?=
 =?utf-8?B?THZsZmFMNC9KU05oUGhsb0d0b2ZjZUZTaWIwOWpiZEg3aUhnRFprK083WHpy?=
 =?utf-8?B?L2Z5a3ZCSXZ1eHNHNFNObVlsWFRxRzlNMzBwQWNBZjNleS9lb2t0Y1B4cExZ?=
 =?utf-8?B?dm5rYTdkZGlTOElyZUVqekhSdXk2MU1aaExJU2VZNVkxdi9JOVlJOVhjTTA1?=
 =?utf-8?B?RUQ4b2N6dk4vdDAzMWtLUzBzNUhLV1NjK1NFWjFhWitFdTBrWlBlZ0ZnaFRj?=
 =?utf-8?B?cXhPSm5WK2FEUzBlT2hyN3pmb1ZMVlo3aTBPU1BnVjZ5MDhWSTJGRVJZSXY1?=
 =?utf-8?B?L2cwckFNUFp4OWxqVXJNaHJIZ1ZiTlZwa1JjNmxscnRNSHdSNmM5Q3p5Ulow?=
 =?utf-8?B?UXJON0hkZmpzSTM0QUpuQUl2ZFY0bmI5U2tOdGNSUmV3OVk4ZjJGMklYUWRk?=
 =?utf-8?B?aFZ1OVMyU3BsdnRvbExlLzM0S29PY3hZb2t2dWcvQnlPS1pxTVNGdUYzWlk3?=
 =?utf-8?B?Y2FJVHIxV0tWZ2pTTEFuT3YxUGpPckd0azlhNkM2bDc3OWVYSzB6VEdoMlhq?=
 =?utf-8?B?N3FVdGVFMTB0NFM0eW0zdDNDSzRMd2x0U2dYVjNBZGE5VCtPaExseTBab0Fm?=
 =?utf-8?B?TUJwL1gwOFR5WWxIS2pNSGdRVFY1dTc1OWRXaEFPMGNjbEhZZjVDUER2SFRF?=
 =?utf-8?B?TnBvYS81VHNadkdnWDkyUForR201SktuUlhFRi9SbHJDdTdQWXdLN3FmNFpO?=
 =?utf-8?B?YVl4eXRia2hUaExQWVNFZko0d0pncXBZYkxiTGFLRVAyS2RESDlhbmgzTys0?=
 =?utf-8?B?V3JIK0JuVTlFK2FrS0hqQk4vaWJWWTNQUDVnQnJiOFZyMzUvVEUwQjNmZUlJ?=
 =?utf-8?B?dmFRREpwVHMxR0xkUDZPMzhkMk5iM1d2T0tFdzZZcGF3TmJ3YzZNRUpIVCsv?=
 =?utf-8?B?RG9KeXo4WFg3bGY5dDJGRkxUaU9Oc1dqcGY2S0VwdC9mZ2N2ZS9jNXpyUkRF?=
 =?utf-8?B?UXNHWFFnR1hhcUdsT3VQRnRyN281L0RGeDBBa2d1dVFOQ2JJbnNxUG1na3Fk?=
 =?utf-8?B?SmNZNlY1YWdBajZhT2JlVDZWcUR2RFY1ZFBFdkdqbWVudk04Q3liUjR0Ykh5?=
 =?utf-8?B?MFVnbEVwTUdUbWV6SHBnSGZPT2hzTEpWOWlsQXRPNjdZL2kxV0l6azNJbmxG?=
 =?utf-8?B?N3RhNkxtS3ZCeUxZWE9QRWVjSWRQVW9GK0phNmdOKzhNU0dQSTE2WWN6RHdz?=
 =?utf-8?B?SHBIOERCVHBaWkxUOS9lK1pZWm41aE9KSXdrNW5MU1FacGtUekFBRDZ1K2VL?=
 =?utf-8?B?WTQyeTZSTXV3aG1qamh4K2JOTjQ5YWU2T1p3amlzVEI3QmVRd2x5NWlPcjd0?=
 =?utf-8?B?T1l0Z25IV3R6azRoVldoZUw2LzEzY1R1SDFwdjhBVkl3UHFoTlZDRE1ueW5M?=
 =?utf-8?B?T1crVHZ4UlU2M01VV3hqRFlIV094am9QaXQrZWx5MzlpbFpLRjF5eDNLSXRG?=
 =?utf-8?B?YmFVMXNyTFNmcFpUZWs1MjRpNzkwbDF4Sy9VT2RkaVNOVjN3LzFZQndJNVFt?=
 =?utf-8?B?K3pQVkdsVGtObTV6cVc4UUtjZ3g1ZHptVWRMVGswZjUvbWpOb2JraWtiNWVY?=
 =?utf-8?B?RUt6Rkl1QmtjdEM4QzVkdUE4OFhOTjdUanBPSVYzRTZic05xSjNlbWk3TjRw?=
 =?utf-8?B?MHI5Ylh4VXVxYWdONXFCTUJMMlhwV3dvU0FDMU05ZlhjWVYvbmkrL2owTkpK?=
 =?utf-8?B?Y0srN2tiZ3U5cys5dlJFbkFCY3MxMm1aSzRqUDVwZHFQYVhhV0xmMjV6VVh5?=
 =?utf-8?B?SVVZUGJ4N245TkhYVy9LUkVvMHBrelhhZE1LZzNwREVPa1NRVWlXOGhPOUxS?=
 =?utf-8?Q?vYUs7EzdLP6hrEYaFmJagFtPX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o7StbmFtiV3UbecmYM9KAcFsWq6PD+Nypp/3nzznWzyI9+ZDIn1Y5z/CohtFbd/ZQ1iI3p8C1CbMxJc54Xw4xGzwAuYhNwibBCRO0BccWk43U2+v/noCGChQ9nAgflPq+amc6EfVHYc5bqMf60Wy4XN0rnefgcXSgxUe2M5oYCEVqfhkyiD6puzk06PQwspdC2FZtWK2AaH9u0S/RGHhLzvbmK3kHUlHJXr9+oxQj/jYQx5+baO2LOcxekSYl9Asjm7ryKgc0//jymMknrF8yg4Pybxbhd5EDbOorhuW+3U8mPAT8ZzD6TkFAUYwXhl3Raa+/BkgMdDLpSmHfo3hpE1A+IPHtZASHM4I3ZnPKz8EXGMLplr06qSugXzJDZLqNuEsu+c6VU6vCn2eF73QTVTpKyTghOyCdC02b6ZHUNloIpUaKAHC6nY26bix7F7nmXwzphEZ+OjB22WWKo0wVMqPFn8hGTw0dYzJ3rRgSN57Ng2eIsZYkygL0tUPAPA1m2104N3X340Ttk4YFTfsDLB+9cxCwh7Eaw656zoo6a1isTpZTfv6CZ1OryhXpPyMZyeMf8KH4OnyeWBVzIxS1Yt1GtXUoHZnS8900ZYp1OM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a20c11-092a-427a-c27c-08dde57f2824
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:34:05.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuQ6/yHcIoUbj/9lzTxB+Shlwf2Rs8jcfYTyPP2UTGACaPnIHSqe8xY4O5Z8qZrvFMFZoAeRvHFB5LSwITa53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270133
X-Proofpoint-GUID: _sXXhGrx5u_5bAldxsUQo8OkFKp2UPRx
X-Proofpoint-ORIG-GUID: _sXXhGrx5u_5bAldxsUQo8OkFKp2UPRx
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68af2571 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=TIAeFO2s_eHvrYuS8kAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXzzTqIRqqa4Ay
 Qp30hdsMj1zFxs8ioEfbl8HwqJ/mfShIiN+gipXAhbq5eJPcbyDJS/TdT4C8Sf+/kxDKpulf015
 D0l6/2pl0/GPPc4HyZUmWLUG/BNmV+s2+yaKZqqL5Zr/6fFsJsr267LbzpzCvbb2KFaOPRFxnFz
 AcAtdPZbpkwZhMhnn5jegOqHARJ7gX8BoOjMQr4gp+k+qdjddfxWb4NccQmeb8f+6Lns+ur+wf3
 7BCTb0cUbWcgUVLT8/LqkVghfXeoyZQOi6X56OXr+PRGiKs6uD/ENZcITniscR8tvS3ybRzrhWa
 H4j1SlicbxOXB6e3CRMD9q1jnQvsIrHFIR/ZY2NznmJHcAQg6bBOjhCWiU0Wm2pJptF80RAPxpH
 A9tAez/Q

On 8/26/25 2:57 PM, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> DIO-aligned block (on either end of the READ). The expanded READ is
> verified to have proper offset/len (logical_block_size) and
> dma_alignment checking.
> 
> Must allocate and use a bounce-buffer page (called 'start_extra_page')
> if/when expanding the misaligned READ requires reading extra partial
> page at the start of the READ so that its DIO-aligned. Otherwise that
> extra page at the start will make its way back to the NFS client and
> corruption will occur. As found, and then this fix of using an extra
> page verified, using the 'dt' utility:
>   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
>      iotype=sequential pattern=iot onerr=abort oncerr=abort
> see: https://github.com/RobinTMiller/dt.git
> 
> Any misaligned READ that is less than 32K won't be expanded to be
> DIO-aligned (this heuristic just avoids excess work, like allocating
> start_extra_page, for smaller IO that can generally already perform
> well using buffered IO).
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c              | 200 +++++++++++++++++++++++++++++++++++--
>  include/linux/sunrpc/svc.h |   5 +-
>  2 files changed, 194 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c340708fbab4d..64732dc8985d6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/splice.h>
>  #include <linux/falloc.h>
>  #include <linux/fcntl.h>
> +#include <linux/math.h>
>  #include <linux/namei.h>
>  #include <linux/delay.h>
>  #include <linux/fsnotify.h>
> @@ -1073,6 +1074,153 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> +struct nfsd_read_dio {
> +	loff_t start;
> +	loff_t end;
> +	unsigned long start_extra;
> +	unsigned long end_extra;
> +	struct page *start_extra_page;
> +};
> +
> +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> +{
> +	memset(read_dio, 0, sizeof(*read_dio));
> +	read_dio->start_extra_page = NULL;
> +}
> +
> +#define NFSD_READ_DIO_MIN_KB (32 << 10)
> +
> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				  struct nfsd_file *nf, loff_t offset,
> +				  unsigned long len, unsigned int base,
> +				  struct nfsd_read_dio *read_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
> +	loff_t middle_end, orig_end = offset + len;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> +		      __func__))
> +		return false;
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;

IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?


> +
> +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
> +	 * or base not aligned).
> +	 * Ondisk alignment is implied by the following code that expands
> +	 * misaligned IO to have a DIO-aligned offset and len.
> +	 */
> +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
> +		return false;
> +
> +	init_nfsd_read_dio(read_dio);
> +
> +	read_dio->start = round_down(offset, dio_blocksize);
> +	read_dio->end = round_up(orig_end, dio_blocksize);
> +	read_dio->start_extra = offset - read_dio->start;
> +	read_dio->end_extra = read_dio->end - orig_end;
> +
> +	/*
> +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
> +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
> +	 * start_extra_page, for smaller IO that can generally already perform
> +	 * well using buffered IO).
> +	 */
> +	if ((read_dio->start_extra || read_dio->end_extra) &&
> +	    (len < NFSD_READ_DIO_MIN_KB)) {
> +		init_nfsd_read_dio(read_dio);
> +		return false;
> +	}
> +
> +	if (read_dio->start_extra) {
> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);

This introduces a page allocation where there weren't any before. For
NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
like this is not needed on an I/O path.

So I think the answer to this is that I want you to implement reading
an entire aligned range from the file and then forming the NFS READ
response with only the range of bytes that the client requested, as we
discussed before. The use of xdr_buf and bvec should make that quite
straightforward.

This should make the aligned and unaligned cases nearly identical and
much less fraught.


> +		if (WARN_ONCE(read_dio->start_extra_page == NULL,
> +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> +			init_nfsd_read_dio(read_dio);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> +						 struct nfsd_read_dio *read_dio,
> +						 ssize_t bytes_read,
> +						 unsigned long bytes_expected,
> +						 loff_t *offset,
> +						 unsigned long *rq_bvec_numpages)
> +{
> +	ssize_t host_err = bytes_read;
> +	loff_t v;
> +
> +	if (!read_dio->start_extra && !read_dio->end_extra)
> +		return host_err;
> +
> +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> +	 */
> +	if (read_dio->start_extra_page) {
> +		__free_page(read_dio->start_extra_page);
> +		*rq_bvec_numpages -= 1;
> +		v = *rq_bvec_numpages;
> +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> +			v * sizeof(struct bio_vec));
> +	}
> +	/* Eliminate any end_extra bytes from the last page */
> +	v = *rq_bvec_numpages;
> +	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
> +
> +	if (host_err < 0) {
> +		/* Underlying FS will return -EINVAL if misaligned
> +		 * DIO is attempted because it shouldn't be.
> +		 */
> +		WARN_ON_ONCE(host_err == -EINVAL);
> +		return host_err;
> +	}
> +
> +	/* nfsd_analyze_read_dio() may have expanded the start and end,
> +	 * if so adjust returned read size to reflect original extent.
> +	 */
> +	*offset += read_dio->start_extra;
> +	if (likely(host_err >= read_dio->start_extra)) {
> +		host_err -= read_dio->start_extra;
> +		if (host_err > bytes_expected)
> +			host_err = bytes_expected;
> +	} else {
> +		/* Short read that didn't read any of requested data */
> +		host_err = 0;
> +	}
> +
> +	return host_err;
> +}
> +
> +static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
> +		unsigned addr_mask, unsigned len_mask)
> +{
> +	const struct bio_vec *bvec = i->bvec;
> +	unsigned skip = i->iov_offset;
> +	size_t size = i->count;

checkpatch.pl is complaining about the use of "unsigned" rather than
"unsigned int".


> +
> +	if (size & len_mask)
> +		return false;
> +	do {
> +		size_t len = bvec->bv_len;
> +
> +		if (len > size)
> +			len = size;
> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> +			return false;
> +		bvec++;
> +		size -= len;
> +		skip = 0;
> +	} while (size);
> +
> +	return true;
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1094,7 +1242,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		      unsigned int base, u32 *eof)
>  {
>  	struct file *file = nf->nf_file;
> -	unsigned long v, total;
> +	unsigned long v, total, in_count = *count;
> +	struct nfsd_read_dio read_dio;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
>  	ssize_t host_err;
> @@ -1102,13 +1251,34 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	init_sync_kiocb(&kiocb, file);
>  
> +	v = 0;
> +	total = in_count;
> +
>  	switch (nfsd_io_cache_read) {
>  	case NFSD_IO_DIRECT:
> -		/* Verify ondisk and memory DIO alignment */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> -		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
> -		    (base & (nf->nf_dio_mem_align - 1)) == 0)
> -			kiocb.ki_flags = IOCB_DIRECT;
> +		/*
> +		 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
> +		 * the next DIO-aligned block (on either end of the READ).
> +		 */
> +		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
> +					  in_count, base, &read_dio)) {
> +			/* trace_nfsd_read_vector() will reflect larger
> +			 * DIO-aligned READ.
> +			 */
> +			offset = read_dio.start;
> +			in_count = read_dio.end - offset;
> +			total = in_count;
> +
> +			kiocb.ki_flags |= IOCB_DIRECT;
> +			if (read_dio.start_extra) {
> +				len = read_dio.start_extra;
> +				bvec_set_page(&rqstp->rq_bvec[v],
> +					      read_dio.start_extra_page,
> +					      len, PAGE_SIZE - len);
> +				total -= len;
> +				++v;
> +			}
> +		}
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags = IOCB_DONTCACHE;
> @@ -1120,8 +1290,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	kiocb.ki_pos = offset;
>  
> -	v = 0;
> -	total = *count;
>  	while (total) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> @@ -1132,9 +1300,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	}
>  	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>  
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> +	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> +
> +	if ((kiocb.ki_flags & IOCB_DIRECT) &&
> +	    !nfsd_iov_iter_aligned_bvec(&iter, nf->nf_dio_mem_align-1,
> +					nf->nf_dio_read_offset_align-1))
> +		kiocb.ki_flags &= ~IOCB_DIRECT;
> +
>  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
> +
> +	if (in_count != *count) {
> +		/* misaligned DIO expanded read to be DIO-aligned */
> +		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
> +					host_err, *count, &offset, &v);
> +	}
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e64ab444e0a7f..190c2667500e2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   * pages, one for the request, and one for the reply.
>   * nfsd_splice_actor() might need an extra page when a READ payload
>   * is not page-aligned.
> + * nfsd_iter_read() might need two extra pages when a READ payload
> + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
> + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>  {
> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>  }
>  
>  /*

To properly evaluate the impact of using direct I/O for reads with real
world user workloads, we will want to identify (or construct) some
metrics (and this is future work, but near-term future).

Seems like allocating memory becomes difficult only when too many pages
are dirty. I am skeptical that the issue is due to read caching, since
clean pages in the page cache are pretty easy to evict quickly, AIUI. If
that's incorrect, I'd like to understand why.


-- 
Chuck Lever

