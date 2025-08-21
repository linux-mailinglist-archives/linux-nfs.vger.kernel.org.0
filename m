Return-Path: <linux-nfs+bounces-13852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77758B302BE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D32A5E5AB7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889262797AE;
	Thu, 21 Aug 2025 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8unfuBv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GUxNFdOv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7046E56A
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803923; cv=fail; b=rkaE5su5EC6nrYYF9iF32VikWaXyHJgxSRw128cr5y7RQDbqp3XO+QkfwgRgi2Pe/jNGJkH5ghjpSHr1FezJIJlO58wQZ0E8SBJjQdINCyKTqeKF6CFLzat9DwhgjYXEcc5UhnVUtr/zJeDY6N97hTXzS7QYM8IvdfdXJTNJQSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803923; c=relaxed/simple;
	bh=Sk3yyd2iqs/gaTAwBGaU7to2qb9cTLu6xyXQgKrLYyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBKq1LUSRr5WgOwF9WzksPKnqHFZCpaQat2gXxyX5isq1cnb6M1PU0CplQ827+ywYyGAdskDCPlaFyF18VJZUARztjFt9n9ntGxzF2jqN92ZXmz1Q7rZJp5t8wpLhD3T3eJs4g+g4q2BPJQHOQhbP3SKZU96Z5eJ/9NMCULfClI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8unfuBv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GUxNFdOv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIdwLH029367;
	Thu, 21 Aug 2025 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xKArWyKjzYQh4utGh5WWGlZ8NbYsoiWAsITr82+LQV0=; b=
	Q8unfuBvUiwZ/f1xrlQBr+Ne2GfoP7OCuog8tO4ipx0lMQDp8eDOuCtcUkzGoatk
	dKHXoIjpYEepbFjX7hbc4V25G6xWwlM7beCl29gP6E/HUZuSJdo5XqCjlFByHd0o
	LBYeLiBQM6QbirTVxjb+ahp8lpoYXlhbD2t2yr8Z3hwIL1sETnblwG6g0MmsJEay
	XkQrcOtSvWmcDG1rvbVtQHIb3446wvsLGehT/u6t5e+mtfeXuTQFO1RirqVx15si
	ax6wpLEnq6yUzpc5NSvpKxZ/oGb0HcVr3yU/P5vkhn9Mm31DjsTO1u+WXb9maYdz
	I29IWjO2QlsffXkG13sjEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2c8m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:18:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIAp2I025390;
	Thu, 21 Aug 2025 19:18:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my431be2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG1LfgTlRiTBbwdof6/2ItGn9M0PrZoI04KHU6EhHg4ZVvpcBL2i56kx1NHYd6RjZW83Cv8i+CRJts7u95usH7oBIKOWY6kPeDvZf34JFi4lAyKnRqy6TgMls2mVD8gNVIX5P6E+qH0bsZ+zkReH3/z/lavnmyBz37gr8PeQ3S0p344BMt11eFZFmBkbY1gbKRcEAX41BirKuWGNL52rIxiZn4o6bKFKxnxD7in7R8veDOTOQI+PaAIlwRzF1MjpbwhWuCWE5K5A5SX4mm+QC96sihnJx/LRP59U08HbiRbPAtfFtSmcKrzbn7F7obpJ1+WQz7j1Amjr92I5pF+jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKArWyKjzYQh4utGh5WWGlZ8NbYsoiWAsITr82+LQV0=;
 b=NjOKG07gMnCGW8mx+zwhVaG+hkmUMwrmzV2dzeJZiJmXUgrgencRICh6PiBXjvltJ+xRGw+gYSzieglmYBawdRMefAjecbL9GCQ5YswbBCspGM/aSOginQM74vejLowUY9EwA2XTG4+WvMzh2r5G2m9ieVf7tzjFjt19xnc729vt7pcS1E7WsmzUPQ+MB4O18LsGoDUjyN5kDPfuPm2ZTd9iQbZecRhMO+a/3s8vA3XWIRKu9ENGi8xzgKdC6IL74JL5/XqpS43SK/VcIES4D4u85RqKMuclUhy8u5ciW42KcNV8HfCshmfuuYVZLe03xYmIrGr5KbmmTwqeI7tdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKArWyKjzYQh4utGh5WWGlZ8NbYsoiWAsITr82+LQV0=;
 b=GUxNFdOvuNlrmR9TzyAJU4LaIdBf+sChG0XCqEKvXGOacLwRFOugzyyFoTDBw+uoZOdCfeaFDlFCxNlpbAgv3XcBvqLA36qH4wh95+aPC9PCWr2Cond0dXfi4Lrox7hk+uOxvYlfbH/cGxt/LYuY/iKbGtGBFrPo0aLQIhqC2dA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 19:18:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 19:18:03 +0000
Message-ID: <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
Date: Thu, 21 Aug 2025 15:18:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a
 retry
To: Olga Kornievskaia <okorniev@redhat.com>, neil@brown.name
Cc: linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com,
        jlayton@kernel.org
References: <20250812160317.25363-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250812160317.25363-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:610:11a::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab121b8-db4f-4da9-ed86-08dde0e77355
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L2ZIQ1Q2VUpQUkFzMlJPK0hYVmJlb0dqMVkrenpyODBpRExWWDlTR1RocXQ0?=
 =?utf-8?B?WmZOT1NxU3hNaFdocWtZWGNDWXB1Y0dqcmsvZEx4c2pwNjhhSEZwN1RWaGg0?=
 =?utf-8?B?VWhRQU92UnlnM21aM0g1SHpmcWo3bTd1SWZmT2VDc2QyTEJNNjBHNDB6UTRv?=
 =?utf-8?B?cG5zOFpQdlBmYWpmQVRQVTYzc09yVnV0aUZZRkJLcWxkbm94WXRxMWw4OFJE?=
 =?utf-8?B?MXBBREtaVVNKYVY2NjhKVDVGazNKOGFWOTdOcGY4OXljdFZDRE4yRUlMODVY?=
 =?utf-8?B?c2ZXbUc2Z3M2eFIzTU5WZGdXZTZ3SlRlYmxzdnhYNTJTVlBYVnJaZGEvVTF2?=
 =?utf-8?B?b0szWWpla1pZMzZ3OWd3cEs5bW5MRjhOL0YwRnpCSWVuZ2JObndqYjd3TGFC?=
 =?utf-8?B?YWxvdXA5UzB6eVZTSzNFa0lLVysrSE1SVlMrNXFLSkpMVEphNEFaUmtBcVN2?=
 =?utf-8?B?ZTV1c1R6VldpWGw5YW92VVZyVW9hSDBsbWk3Q0Z1YjduL3VXMUZmSkIyeElp?=
 =?utf-8?B?RW9sWEp0L2ZVMzk1TWtMNUNyUzRyNGppMnlVbS9wK0NlbVBVZ1d0MGg0SytF?=
 =?utf-8?B?TnZocWxqL1NtYnF5c25LTVVHQU0rM09meGtFREhZYUxvL2pQQXpmZzhUazEy?=
 =?utf-8?B?R0NDZEE1bmNGOHVhMDd2M2g2eGhzSUdRWTR5b3M5M2NZVWgwSUFRejEvNVll?=
 =?utf-8?B?cTQxZFNLdEJWRVNtU0cySCtJdlBCM1ltUlA0R2Y2K3FyS3dzaGVlMXNUSk01?=
 =?utf-8?B?Zk1POGIrQUtINzJKd2VSdUJZcFNEZWxacUFSc0tlVXVYQkQwNVRkU09rbWpG?=
 =?utf-8?B?cFJhWFlBVkpNd2Z5MDVSNmg2Skh0OVArZVB5WjcrU2FtTURhMUhFc1lwMDVz?=
 =?utf-8?B?dG9EVUEvK2lvVlQxMFhwYzJORm4zdFJFYW5UQUNuMHVxRGVlZ0JjcFozUHd6?=
 =?utf-8?B?akJUeTNhT1UrV3c0R2VrZUdZMHI3OUxiSFRmSkFpakhsaEdNVnJHK09qd2JD?=
 =?utf-8?B?SHhFVER6ODZZU0htcWc1QmU0a1hJTU1qZm9jVDlQSDdhcTgyMGpnbkREeko0?=
 =?utf-8?B?T2RnV1k5a1Y0ZlR4ZERCVGk3cmZwOHRCTlE5S29GbVlKbW9KNFkwNExwMExF?=
 =?utf-8?B?NnBOL1dxK04xQ0hma0N2alRNdVVZNnAwcWdwYzVZKzlVZTlvMkJBVXR1Rlh6?=
 =?utf-8?B?M1NxQ0gra05ncmFucTNDOGFFdjFVc01KMGJHSEF3KzFKVDl2SlhhenlXTzQ3?=
 =?utf-8?B?TnhtaStSWTRkN3k5TXlwa1Q0N05rTldhK2pCa1hUWTNGS0RTTDNUM1c3ZHUx?=
 =?utf-8?B?TmZHME0rOHNkOEpCRmZVMjhrN05BKzlCMmkzdTlpQ0tRWnZzc2kzZW9VYm5F?=
 =?utf-8?B?ZkZKNVdOKzlZU25kWGYwVmNxNGhZYVo1dVd6MUtYTUxiWHBFWnkyZXo2Qlcz?=
 =?utf-8?B?eGNzekkxaW1SRHZCTUVuWm9ja3gxLzJaVU0xK3A5Y1crdGM0b0dtU2k0V0lI?=
 =?utf-8?B?QmRWb0FmcVV6OGZYYS9CZDZWeUQ3d0s4SFJ6bmN6SU5HNDRNbDUwQVhod2VD?=
 =?utf-8?B?ZitTT0FiSlZMWVJiZGFZWVYwZjNVU2x5U3N5aUpYVUJzZmtZQllGZHQwYVZm?=
 =?utf-8?B?STlXY0p2SmxkVnlRQ0MzQSt2OEl0d3pGczY0ZVorTE5IUkFZRXpHK2J1QkhS?=
 =?utf-8?B?ZmVORU9qTko4RHRUd1VNMmpiam42ZGtTMW9uODc2cG1CbjBhSWdBSE9oSDFK?=
 =?utf-8?B?Q2w3V2thdXoxQW56VGpjZUlQRGhQMlN6cVU0d0xLcXVIT2w4V3pzYkkwNkVE?=
 =?utf-8?B?VUx0SkljU3MyK0hEVm5Oa3hMUDhTNEtRTE1uSlp5RG1YVXcrYkxablBKN2xP?=
 =?utf-8?B?UGVQa2JKaUxXYjE1NytuN1Uzcm1TdCs3ZVZ0aVJBWWVQc3BIbWQzckJwa3ph?=
 =?utf-8?Q?g7DCDcw58lg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VE5ZRGpuaWlVYTcwWHp2WWhtVzAxNUhHODY4SWpaMmFZZ2laUmNobnlkYWt2?=
 =?utf-8?B?L0h1VGhuNkpzZVhpYnFVRmpGdjhCVk4wRTI4bkxoOEgyZUFXaHJGU1ZjUEpr?=
 =?utf-8?B?SGVBOE1PUGpWLzdhWURFaWJzVjAyVDVaV1psSUhsNnM2eDNjSk9zaEdzZEFo?=
 =?utf-8?B?NDh1Wm9ZVWNwRUpmUDY0NGxwUFZ1aWgvY3NTdzFrTHNhRTFhMk96SjIyZFRZ?=
 =?utf-8?B?LzByaitzaHFRZTR4U0M3cGVwdk5XRTBReFJUWHlBK2NteVJ0cWxaa0lXVmdv?=
 =?utf-8?B?b1BERU9TZ2kxNjdDc0VwSVJSdWpPK2o2SnFiVk1zVkZDWHJCWFRXN1BzR2ln?=
 =?utf-8?B?MjQ4R3A5WHR0Zk9WSlRJMFpuQ1hxVXZyOVI1QU9ZQUp3cnNzZkRDZ3Ftclla?=
 =?utf-8?B?c210VGFLZnRBSnNCYmlhM1ZzOEcxeVdVeFR5SEVCM1JWR0cxWFpReE1JeVp4?=
 =?utf-8?B?MWxhU0EvaHlEWXIrSjBjTFl3TDltZE5JVEpCRzMxMndYQi9YcUY3VXlQcnZk?=
 =?utf-8?B?aVQ4NGM3Rnh2dnRHelhMU05FWTF4S3dTZ2x1Q1dlMXJKSWh2UGtvUmVwcXE0?=
 =?utf-8?B?NnBBcUk1S2tDY3Q0RVNRVUNBdk5VRnhweXlTY2NYdCt2U2NWc2VnN1NiNzdt?=
 =?utf-8?B?V1Z5SjQ5Z2paOTdDWjZTQkFNLytaMWIxb1laRGIwdHN6K0d0dE5DZWpuRkdO?=
 =?utf-8?B?NDlBSFgrVStxWGc2YzNIbVg4S05KVmNGMVppOGpFVE5wMU15eXR4SVdic3lD?=
 =?utf-8?B?eWxGWjhoeGlETE9MQytkMnp6dWJCNEFZTld3UkpKQk9BMGFCRS9sdS9veXdV?=
 =?utf-8?B?SEJqYTFUcWU0elJhNTE3VjFSbjRpWXVzM0NZZGlOaFIyeGQxTlJwN3B5bi90?=
 =?utf-8?B?L1ExWndoVS8yM1FnTDhwWWNIMCsxeXhNcXZNT1NMcGtIaU5kQkVtTmVvWXpD?=
 =?utf-8?B?QUphZm1OeHVpakV3Ri8zbVFNTmg3emZRTnVYRWNOUjJ2Vm1YZ29LWHRWbzVs?=
 =?utf-8?B?ZThRNFdDWEZSaTk0Mjd2Rm9vRnMwRDB4aXNFYTVSQjljODVQZkZJS3lTTENJ?=
 =?utf-8?B?Q3VkYkRLRmdtZ1htNHpRLzc0TldjUlAwakV6T3J2RG1WTktNMi82anJpMWEz?=
 =?utf-8?B?VmZqdUdBemFqNGwyZTdzam9BVmZLNitBZjhWcjdJRzB4YUFuRWNFdkk0bW9Y?=
 =?utf-8?B?My9wa3gwZHFPcCt0STZuRjVqYk9yMFE2OE5ic1FNajJyenhVbGo1c2RSc2NR?=
 =?utf-8?B?Y0FMZU9TUlBybm1mSTczTDc4MGFCd0FyQTYvWEV0dnpFOVJCZUhZN3RsWElT?=
 =?utf-8?B?MEFua0lzTG01VjF6ZWlJZWZaTEc3TWVZaXJPM2VzVGNNYWlpTFg2U29SYVV6?=
 =?utf-8?B?aFBaZWdLVmpkUStrbjArbk53bUdwZEtvMk1IZ1lVSlRQaTYzOUZRcFdPcWpz?=
 =?utf-8?B?djJGNXBWekVxOWMwVnovTVkyNmRnRVRzZmlXWnlwNTdHQlIwUzJEWU16eFF4?=
 =?utf-8?B?MVZOVEtnOUhHS2p5Uk1xUHVOQVRxaCtIUUYwQ3dKSnlVSVFhZHh3VG9VVXBU?=
 =?utf-8?B?MlR0eE9uZjNTemRHakluSHNxM3M5UHhoUDNtajdjQmxxWVZOa3B2S1pIdzh6?=
 =?utf-8?B?MUZBOTE5cVRmL0wxSVlROXBzb2Y4R3pVeUxHcCtyOXZMY0c2b3Roc3BxaXQy?=
 =?utf-8?B?bDBmSjAxZjVqSk9nV0pCZlRaQW5JMzdTaUtSU3dYcWFhWGFHQmdZSWZIZm85?=
 =?utf-8?B?Snh1YWxWbzRCaGpUWk9RSzM3VXRVZlQwS1Q0N0YrOC9KTGpkcTZmUEVHTW5Y?=
 =?utf-8?B?a0psVlpGMFZOZkp2VkhlQm13N2t0ajF1alBQdUdmd0N2QVF6RkpER1RzMVJQ?=
 =?utf-8?B?UmRNZ21yRkVYdC80Qi85Y0Fhd3dOdjJwWCtPakppSFFsdGdjTnRKU09NRlNQ?=
 =?utf-8?B?WTRuZ0Q3bzlUeGNISUg3dm1vU2RmQkFQRndSL2wxWHArQVJSOW5ha2NFWjkv?=
 =?utf-8?B?OTNjNTBWREkwSzhPRHl3U2pLLzI3ZjhjRE1STGVhRnFHZUJyL1c4N2VpQ3pF?=
 =?utf-8?B?cHhMcDdTS1krL0xiSnByQ1VSUXRwUlk3cFczU09zMXhjTWo5TkZtU255ZTI0?=
 =?utf-8?Q?FZgWGscu/b+Nwsirev3+yOAmM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zp7877hO7ww+2IWWRhcVLG/LpqAUHSriiUNydYMppgeo0mVT0N/s/RUo3J6+uDHnv/45a9gDMxnBxbdjUVCS/QV2kZ/Xl3ThFqSbVdJ7nUCQqDZ7daWPAZUWimz73hU1gNXXbtMWRdpKXBdyEYpDgHmGGU6ZxEOImFgciGyd4xIJ/ht8k0OUSB/kptiiTKDWGmMaDAx/5yJz5qMFz+F71P2+G6CQsUqH1vS9MjOou1K1mwBPOzrzPUYHUhC9gaBxHco4FTjtj6v0k6AEsFNVxJzCqiN6lwPFjkAyINPXq/TNXb/R6qN30sNFVmFZwxjnmoeD1fZ/XHanX7cF12WtZ7MPRnRu11mPhrxpB/XU+1kYLR17cC4stBmIiQ6ijfG8/4LOe0ykAoiETJ941vh/Mx96cEecHFZufAwecBhSzffdh8Fn+iauqJchYKYqTKGmo2aoq1KzC8PR5hOV2QcgeIa+SN7GLU7JSk9fF9qVPpEerXkj2OxCZl5d7aCFyCl2lhi1nwq4EThaBu9FOlqnQy0smzbZ8sKtVocAOFdfl/+TVS932vtJZcp3QG46yKNBB0EpwSSq+BcUuMasiiaiJDg+Zy5t3bquiMGihE4h9gA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab121b8-db4f-4da9-ed86-08dde0e77355
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 19:18:03.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1/5vFjP/SOVP7lEwMcew+Dx9AiL+wTP8UU0TXBRpGUDQs6PyLuFG18KqusIIQggbudukEFzna+P6dpbUdMIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX+L495cf0hsri
 mk77IYEKMzHRBcEW+DhePOPgSZqnqqjEf4+VNpjHKtS9I9q26WiGIqdQD6ZvpCN60R+3K6eHwMI
 nABfjyeBZItg14APFcSNQ1y8O4Ir/T7EXvKZOaDiGIui4891+FWGom35VeakZuKUYgvb77bb9FH
 m1XjtiGNHLKNwd5cidaa+fbscoKEFE+Sw7kP2xCxDAiOHHOhYWSiYAvZIPMQ8JlWF9W336QJrAa
 dTCJcoWjTLBblnMeDVZzT2rXudIF3+Cab1Rs60Az9sGpGnqE+H02/LKjUBE/8FIyplVFF2Ez7B+
 5BW75iaRsUtpWdgnwNPH4QeokC69pPjlpqroDywKYd1HeiEOZAokuVsghObiRvBSLDzsHqL64ad
 6M5xrhCTWBWzhQFkuD8+9vIs8iLdq8oHn79BetRH7uS0OChD1P0=
X-Proofpoint-ORIG-GUID: WpRhnTqXOHsjTSnDjz9yZ0aaLhDFKlcH
X-Proofpoint-GUID: WpRhnTqXOHsjTSnDjz9yZ0aaLhDFKlcH
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a7710c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=vCMczVyDTemmvrXAg2UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070

OK, let's reset this discussion.


On 8/12/25 12:03 PM, Olga Kornievskaia wrote:
> When v3 NLM request finds a conflicting delegation, it triggers
> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> of returning nlm_failed for when there is a conflicting delegation,
> drop this NLM request so that the client retries. Once delegation
> is recalled and if a local lock is claimed, a retry would lead to
> nfsd returning a nlm_lck_blocked error or a successful nlm lock.

If this patch "... solves a problem and a fix is needed" then we need a
Fixes: tag so the patch is prioritized and considered for LTS.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/lockd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index edc9f75dc75c..8fdc769d392e 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>  	switch (nfserr) {
>  	case nfs_ok:
>  		return 0;
> +	case nfserr_jukebox:
> +		/* this error can indicate a presence of a conflicting
> +		 * delegation to an NLM lock request. Options are:
> +		 * (1) For now, drop this request and make the client
> +		 * retry. When delegation is returned, client's retry will
> +		 * complete.
> +		 * (2) NLM4_DENIED as per "spec" signals to the client
> +		 * that the lock is unavaiable now but client can retry.
> +		 * Linux client implementation does not. It treats
> +		 * NLM4_DENIED same as NLM4_FAILED and errors the request.
> +		 * (3) For the future, treat this as blocked lock and try
> +		 * to callback when the delegation is returned but might
> +		 * not have a proper lock request to block on.
> +		 */

s/unavaiable/unavailable

Since 2020, kernel coding style uses the "fallthrough;" keyword for
switch cases with no "break;".

Although, instead of "fallthrough;", you could simply remove the
nfserr_dropit case in this patch. That would remove the conflict with
Neil's patch (if it were to be postponed until after this one).


>  	case nfserr_dropit:
>  		return nlm_drop_reply;
>  	case nfserr_stale:



-- 
Chuck Lever

