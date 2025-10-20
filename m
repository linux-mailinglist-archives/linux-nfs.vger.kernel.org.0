Return-Path: <linux-nfs+bounces-15420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B28BF2E92
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB943AEC2C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C321EDA0B;
	Mon, 20 Oct 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llL3rPc3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YqJfPabo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390B2D061F
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984445; cv=fail; b=FZKOur5bvjSqSc979divMslXfZn0wfBA3npQ2KYXsPPI5eJIzoxOb8ANn3B/dKzSrI5FPaodupWrfoO3OMR3W98Lkc13SWa5BtjUFYcN3NfiNuaNJTKf1TlKzSUddE03QUvFF/ilDHOqJ5Vb5osWGEQkhD6k7AD6fVUF2j1tOVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984445; c=relaxed/simple;
	bh=ZH5PDjO0jX/qkLRaWk/ETA+YF539T9mSoa4w8Ps7zTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOyAfUcfJeKn8VzVr/DBlaPGRsREA3KU3tmETGy/tFZFRA8SkHRtCra52IN5hFRl/BEMcPi8RcsVrn96lDvAADcvF9zGHnmC1HZdA8/BGPZ0nLa3rcHJqk/xNrIa15xaoy8YH2AnrVvPqGz9dQUmA/jQjnUoCjlS5ckpXgFNBOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llL3rPc3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YqJfPabo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFk8lU031898;
	Mon, 20 Oct 2025 18:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lgwzL++XsgYuCd5QeyA8KPBeln+oRISMqtlH3j/M89U=; b=
	llL3rPc3MEyqFYgahIdDAWMdSAJWbe09tbDEguJT929GUs3jDnYtYV6ZP6C6dN3k
	RgSbghZU8lGvAryaDxFSW1uIcug0765BxzwCH7JJB2detVvp8z9tZMrxuTqcQa6l
	2sZOHrJL0/sdK+y7L3Pg0Y3xb/n9DU3lV/o6vT8IIPjN5QbPmLd13zZ7tCC6UCKT
	MmZsRBW52uDPzScngPqW5Y6U/3oSOHYV7+BcOTyWjimuzmyzWYv1XVOv712ZAil1
	9DHiXtm85RITMDs7sKfXEkXhKk09YQYXTEDp/hw8Z8A2Y0aiM89a74KrwObN4amx
	u+MEqxJx2aXez8gtNze0ZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdhsnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 18:20:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KHesoI034892;
	Mon, 20 Oct 2025 18:20:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc0hfd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 18:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8fAKSKkv0ZQaEQAAPZCS0OXVDrsIcQpPP2dueVyjL7FHhr7xxpzPyr+qMH/keeaecuBvPHbg75IW3DFqLtTtuYJDqDlUlRRPT2Q3vch3LLxBa7yd0x/SNIQXsKziecmNc7ztwbiHwcVpMb4jQsN/Oe5lhOfpaDl2xIGTjXJiEpbmWLdPBdpLzV5edp8CVL0h+dGZMzTcNF9QWTs66EpXn0SmoDRD7hLRhFoyEJc/hQqyXHS2nkODU06QCgUJxQ6f5sz1TL0yNa1YnMY17OF4USCE0NO08GlA6uvXQEViqXke4ZPGa04pRgEqD2V3LPwZCUP9MlJkisbQDN+1t1Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgwzL++XsgYuCd5QeyA8KPBeln+oRISMqtlH3j/M89U=;
 b=o1En7rkhM0A9GN931kuGaZhwZXIsoJk72+itYLH3mrbH238oWtU5YarQ2mOrj1XT5b1AoQFR628WEasn0yigELjlbh3BM0Hq5/BZ7n1ONAvlrv8k7DsDjgOjOTyvA6PVvW7upoLW82K7dAmy4Si0oXLa4Xv2zCkm/8cMIE7D9qOfzJHaNe9Q5TeeXyCzp5ibu64qW+xd0w9JpoNsuG6awyuwAFvVoIbgyY4WSD3BDDphNoUQdD5xDqmWtyrmczHWHCqQ8g/EqU1LDRhvzr2dwN7YFLtODiada7nP4nsNYtmq9QG/EnmYx8H5SznciHDJfBctCcf8pbVeDxmzxdMJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgwzL++XsgYuCd5QeyA8KPBeln+oRISMqtlH3j/M89U=;
 b=YqJfPaboYaW1PRjJLUnTEfH0YVGkO7+7oCXNfpQhNhgNLBDeg3/NkKITz5UGnBJj15gnf5JNmj5FW9rosWJ40Qbn/tnBV/vlF3c0aMyDpr9ztHNA5sNoxnMcd/Ix1tzgUe+snD2Q3UQTRKcCEkt1RNRa4XFnekC9pys9lJLlo5E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6407.namprd10.prod.outlook.com (2603:10b6:806:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 18:20:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Mon, 20 Oct 2025
 18:20:23 +0000
Message-ID: <52147e72-fc5f-49e6-af2b-fa8a39224546@oracle.com>
Date: Mon, 20 Oct 2025 14:20:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
 <aPZkYqyFZ4SGnMbF@kernel.org>
 <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:610:57::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e29f5c-6641-42a3-f183-08de100555a7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UnZ1bGd0eDd3eTFSYSt4aFpGT0lmdm5ZbTZvQlNQMytoQjAzbmJFNjVFMSsw?=
 =?utf-8?B?NVFiU096cVd2QmVud1p5U2YvcXNZaHVrNGtlNXYxQUtJdTk5N1RGZEJ5b3Fx?=
 =?utf-8?B?RngzUnYrdjhmSjJjd3NhTU1UUHRGaU1kUlEzMTlOMnVtTVplRlRXTU5JVDZh?=
 =?utf-8?B?ckNKd041bXdqRlNpang5U25GakNVdWJkOTlDT0pkNlFBT0xqMHNoV2ZkZXNz?=
 =?utf-8?B?OFR3ZElrS3g4TERoSXhqYzdYSlRKMGRhckMwWTArbGVyY2FkQWhLZW1NeUN1?=
 =?utf-8?B?Q2ZTUnJEcnJWZFpQdE9FdkpxUEJPYlNxdlNpd2Fvdm92UUhrNU5MQkFYc25m?=
 =?utf-8?B?SHcwZS8rUzhXZDRuOTlNYVdlNWYrMXA0dWpXMFlVbWMwQVdmaWE4Y0ZnckN1?=
 =?utf-8?B?U1k2UWUySEt4eElQR0VTOXcyYks2Wjkwem11YWJKdDNSaTltWnk5YXMyb3ow?=
 =?utf-8?B?cmVuemdiVkxJTTdYMzRORHVMQ1dYZmkrdEk0TWZXbVRYeHcxeHo0eDA1MHc2?=
 =?utf-8?B?blpDb0JpanNjZWZoRlNZSFdtSElINU1lSlpWQ1pxa1M5VkdYQTVpMzVHUlI2?=
 =?utf-8?B?dWZFbk9kOHRoNkt1eHBuUi9BUi9SZ1ZiL0lLOS9LUDhTb1hSSlF2aWdlTkFx?=
 =?utf-8?B?bGUwajFvSTk5UGlQdWZxNnphUExZQzBSZExvb2hNNmE5KzZPYTV3RGw4RDBz?=
 =?utf-8?B?TjJBc0NwOVl4M3dtRk1iUG9qRmJGRTRJZlR6OXpiMkszeU9sN2R1aXBUR2xm?=
 =?utf-8?B?bi9GR2VtS3VZNUJZa1pxaXJqQ1IzNGRLSXFHSWpoMmlBVk5HLzBoVGpXWEYx?=
 =?utf-8?B?czBJNEtaVWJJZnh6eGJveElYOHRWSmRpaWg2UUFndzNWSURSRUU1YUtYMlNn?=
 =?utf-8?B?eGVvaXJiaXh5V0lJQ3krZlVtRmYxT3dWQWl6R1FOYmk4WURucEdGak9NTGo3?=
 =?utf-8?B?YndFM1VIVkltN0Q0R1pGaSt4YkVXdnkrcW1COThEM3BKOUo4RTFsR3hXcGND?=
 =?utf-8?B?dG5zU05iSHBQUGxLYVBvbUJkYUtqU3I2c1ZwQXI4NHJGR1lDYzd4aHdBSUs1?=
 =?utf-8?B?RDhCMVBoTVNTbGlUYkZWa0U3UHZISnI2ekRLTTJlQWRyVThqcmI4YllEejJQ?=
 =?utf-8?B?c1VPR2V2SHo1Mnh5THF2ZUVqdStkcktTZTl5UjZNQVdheGV6NTlnZHdkbUxo?=
 =?utf-8?B?WU96Y2VIZTYyQzdNTUF4eVFuU2Fxd0xISGtBdXNoYzlNeFhZc2ZZUXRlbDll?=
 =?utf-8?B?c0xkQk5mM1VHYUM4TnB3aXUvWUgvVkZqL1JUakxpNHpib2ZnTENHekxZb25Y?=
 =?utf-8?B?bGlKS3BodHBmV2w0WGN4Qks0amtucmdVSlBxbmpEYjdBVHNJUlFLMG1QY1h5?=
 =?utf-8?B?OU0wVk1KV1lZMXpuL1F0bjhTZ3F3b0N6T1FKdzNmWmpOZGpqTXRxMVJ5ZEd3?=
 =?utf-8?B?UHp3dzZSckRZbDlCbjBLQzB0V0tldEdnK0g5SEFLVWRmNUNkZEt0ZVh4eThL?=
 =?utf-8?B?T3RRNFZNR1BSRUdONUZpci95TGpURXJvaWpuY3hnSUVxdFdXeTBvUGQ4Mmxm?=
 =?utf-8?B?MXpPWUlrVHA2L01XUlQ1QXJSNGtncGh6cFY0b0xYUG5MNUNZYkhaMkNIWmxz?=
 =?utf-8?B?TXd0RGpFZ0ZxaXh6SnFwVktIZ3V3RUxvZU4xT2VtdHRQS0VmTXgyWE52ZW9j?=
 =?utf-8?B?UWxoajZWUEF1blFWcHpBbDI1eVZzWnRlM2liTmdXYncxQ0dreUxnd3c0bi9D?=
 =?utf-8?B?YU10RUREODZtYk94VmFVcUM2ZE1mQ2hwQ1IxMUpyd1ZiOHF4QWluVXpSNyt4?=
 =?utf-8?B?MGZCMmg2TGMrcjhYMVhQMW53MjY1NDVpekxxalRZMFFKZUZSd2VldnhKK3da?=
 =?utf-8?B?cy9xRTAzYitWNGVTYmZFMlY4dmloQjNremxRQmhWWHNNRmUzMWRiRVBZcjlu?=
 =?utf-8?Q?jsjp7h9NAemM4MLvO5qN4sIMQ+MIwEM8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?djRtVFJpM0VLNG9lWDJ3c1NVUlVoZW93dzNtR2Z6eWJRNm1VYzJLbU1uY0pz?=
 =?utf-8?B?ZGUwb3l3b2MrUWZKNHUvdXhMb2FYSU8rTzc0ZWNEQTNkdVdKVXdQVmFTZXIr?=
 =?utf-8?B?UndXcG9WRTVRaUtpVHgwM2dNOC9hNDk1NkVTWGpmc0RwbXFrZXdMWVpDU2dK?=
 =?utf-8?B?azRmN2o4TlNRVkk0dFFKbDhkeS9Xd0QwdTRHT0d1aUdvWENuYlhFUWFxcGU1?=
 =?utf-8?B?ODZLSDA4Q045VVpBNU9CMTBQbXEzeWRKWVNMeWFxWXF0NjFycWlXU041NWpW?=
 =?utf-8?B?SXp2S1lwV2ZwZktZaXY2eCtMald2c2Y4WHJ2N0RVMmdLckxKbFh2R1JvQndN?=
 =?utf-8?B?TzMwckxRbENZUjBlWTV3d1NBVS9ic1RSU0c2YmZHK1M5S0VjaC8zeHMxaUQ3?=
 =?utf-8?B?Nzl0N3RSalpQcXhuNEZoZ0ZiQnFHMDI1NkJ0Yy9nZmdJOC8zeXE3V0psUktn?=
 =?utf-8?B?RVdxQitlUjVTdEZsYTZDSUorL1lSRi8zTk1JWk9RNW1UcUo0ZGlmMENCK1pK?=
 =?utf-8?B?SEl5cFVXbnRwZkRoWTZ3VXdMODQ3NzVjWVpVVDRHMnhiY3R6Zkx6ZTNWUS9j?=
 =?utf-8?B?VnpCZHdXQjNoQXVqdFFETWUvK3Y0MmF0UTZuTUM5Lzd0Mk15VHZVcXJJZGdv?=
 =?utf-8?B?TVJEZWJxc21jbU8vOFd6YlRHaW5TZHlrU0E3VG9SN2tnbHlQUktSTXY5UW42?=
 =?utf-8?B?ZjVxWG91Z3lYV0tLNXhhaXY0TytYOXdKWVMvaWljcnM1WE9ETkRMWEwxTWV6?=
 =?utf-8?B?eCtQWTlESVAwZ1c1cXF2VFZMRlpEalBWd05iVEVwVXBXK2s1amplWkZTSlJw?=
 =?utf-8?B?TGF5UTJxRC91MGkxMUh1VlRsRGhINXVZU1R3Z25QaG5qUjUxTzRSeWxJRmJF?=
 =?utf-8?B?Q0w0S1lITE1kdkRLYVI1TkRIdFhXVWI2NXhYVnpZTERHalBTNThleWJmbTFv?=
 =?utf-8?B?eW1HL1pIZ290MHVXZGdoNko4R3BCMUxLWk4zQ2Rpdi81WFN1SnlYVElwb3JZ?=
 =?utf-8?B?dlVEcjEyMS9iWDlmek52TGZTNkNPYnBUVzNFMmVFVjJMOEcvYTNBS280SjZu?=
 =?utf-8?B?dUhIU0paeS9KNGxlZzVPR3lxSDdIK3hzYkdzRHNGOFdOSmx6dGw2NnZNb3N3?=
 =?utf-8?B?NFN1Y1FjdmFORHJGUUdCTmNOa2ZuL3BCQnArN09BMGM3WWdZbWtqUWw3Z1FL?=
 =?utf-8?B?NmFucExVWnNpRnNrNW1xMFhUUTRTTFNvWlFTWXkxamNJYXRhWnMxV0ovanNz?=
 =?utf-8?B?TUFWZWd1RGU4OHVSMUQ4eEsrMjB5c2VzSzdNMTlDMnd2UkpYMEI1ZUJjRmFC?=
 =?utf-8?B?Qk1UVUQ2NjJBR1dzSm9nYjRHZXg4ZktTOEl2ektJb0xpcUhUam1zeEtxWVN6?=
 =?utf-8?B?RGhBdjJXcFZ1M1RaT255WW9vWkFHbHJmM1QrKzRodytPd240VmxKWDZKWDFo?=
 =?utf-8?B?RXpBY0xncldYdXovSDVlaGhEOVdaMnNvZWx5WVVubHAyRWN1Q1lrbnhRazgx?=
 =?utf-8?B?L2toRUlNaWlUcm00VUFUZG1wTVh5Wis2Tzg0NTVuL3pKT0drdVZDRTQySk10?=
 =?utf-8?B?YnVrUUJiRUNzeEptVEpBb1RQVTZybnpXcUxBNlFWaFlFditFVFVPOVBuTnlR?=
 =?utf-8?B?QiswaHh4dUdRT2dNUEtxTXpWeEkrUk5FYzh4aks2SkdlZm9KM0drU3M3eDcw?=
 =?utf-8?B?eDZlVWVNdUp0ZnhkcDdsVE1CcEYvaTROVE5yNmhvTmtMcHJUM1Rpcjh0L1dm?=
 =?utf-8?B?UUZmU1BFMldJaFZhbFZZTnIvVStnQkk5SWNqazZSa2d3NklvZmdsMnlmdlY2?=
 =?utf-8?B?RVNUR1lHRVhIcHppdkZXc1ZKbjdRVjA3eDFoQnA5aU83UTltblh6ZVQybjVE?=
 =?utf-8?B?NVdhalc2ZENwZnd1ZzZmODJna1BMT2dCSnU4aS9iaXdQRTZIMWRRUTdBc3BO?=
 =?utf-8?B?RDB5aGs4WStIdEdvdTR1NWY0aXA5ZnJOM0xMRzNXTER3YXlzL3FlUUV3Z0VI?=
 =?utf-8?B?UmFtMlM4TlAyQllmRjhzS3J5R2dzeXdoTkdia0Q1dkx0YzIvQ0ZZdlRKN252?=
 =?utf-8?B?NHFhcUxwTkxFYStydWc4ZEd1cklJOWhXQWhpYm00dW5xMkw1aGc4VHBDc2hz?=
 =?utf-8?B?Rk80M0J1U05GU1NvUVJQR1RUL09TelFQbHljKzRZcjQyeWszUUN0ZUxxSkRU?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sm3eW9fkdPr+J9G6FHdf3KF0agq5Ar7lHpLyfuJq4N1U+ovEWGuEvLF7OHfRlLIfkc+M/UJT44CS2MIYG8BBHkdgKs7CXvIgl6Yrv/B5C8XzSaFQRQmRLeyXP6PfKWBydj7IidhD5PAVln5iywpYV8j9Uvt03P7+Bug4reKquaW3L3jMcu6eeK8f3f83nqraKHjbTs7ZqyJeS2zuCHJgJHS4TitGcSz9BRBJMfM+vhSGiO7UD/zDN/b+SWBA3BuMulNASYlYu8ooNrsl6ow9I/AjbPRVICDr3vl/WZB1Xq3F7TnuDqnS/I0TUd8nZF0ELXvYtpl27QHw9YnW/3PKTHKi8sMwFmO0OWRmTrsqOonMlP5ByFAqUr48o38o169sZUa/HnszEoUUWKwfgWWfakYjjSO2es1vMRxNtqn/Ifo3EccgPdV8ZNLx+FOGepPb0D/DVHvyiFce0NFkgA0Ut0EOdyzImjJuKIFxCMRqbd0bDMlZXaoKFCvAMplAmak4aFgrE/slk8deDEI9ZZmGLFeoDjX+YT20ZzUd0eSYAga/+WoqqYUSY3KDDEkyoVSpjjaO5dlSva/ehfNW7KKpYMbpE6cYgMj4lxLSwU/wSZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e29f5c-6641-42a3-f183-08de100555a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:20:23.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQXLhzgKsV4m4al2ixYokuTHxzUTUR4tTYaEFPH4DfyiTiTimvmPLTjV6Oz1gC36Kz7RdtG6VfiTzsvYQYxZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6407
X-Proofpoint-ORIG-GUID: mhzhKwWNetvb-FinShl7dUcmUH3IbRDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MiBTYWx0ZWRfX7gohdN8QzGTk j5Nt74DOWr4ktphMu8mj39+9BzownQUUbrIB9tpIuR/O2PRSh0dko7Gs6AXrlo2OCvOF9FjYb1o 7FrUohSIGzOVHeKTwCLdGwOjMk0iaYbzl/+lx8VOzQafm4rk7nNwrlpR5J/TW2R8T4Hv/YhjVj+
 lsRaRzulvQFKmtrJcIzknTO7s5TGSylFZ5dRyUveK6kjR4EnHk1CuaBKa0dro0neq3JrSSEUB/6 NjYfK830DrcrWGzWt1GcW/cIyIlfcDg1jhbedWPeXUDez0V1IaBA==
X-Proofpoint-GUID: mhzhKwWNetvb-FinShl7dUcmUH3IbRDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=558 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200152

On 10/20/25 12:44 PM, Chuck Lever wrote:
> On 10/20/25 12:33 PM, Mike Snitzer wrote:
>> On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
>> Just a bit concerned about removing IOCB_SYNC in that
>> we're altering stable_how to be NFS_FILE_SYNC.
> Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
> the first use of IOCB_ flags in NFSD's write path, and it uses
> IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
> Jeff.
> 
> Should we be concerned that IOCB_DSYNC does not persist time stamp
> changes that might be lost during an unplanned server boot?

One reason to mention 3f3503adb332 is that if we decide IOCB_SYNC is
necessary to correctly implement NFS_FILE_SYNC, then a separate,
backport-able, patch will be needed to replace the flag that was used in
that patch.

-- 
Chuck Lever

