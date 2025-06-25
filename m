Return-Path: <linux-nfs+bounces-12786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C1AE8C9F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384E37B1942
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D538634A;
	Wed, 25 Jun 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m/w/Q5VW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="izrT4MCc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D62DA755
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876636; cv=fail; b=qecU/fva1bgiaBlVjM4EF+l6pwTyQxnWJ2Gfa8Fd02ebx3pPjup4cH/zpWldzRf3nZgqywfHUraFs9z+3JMPzwLt1MfDtOGTWWyY21w8LciId64kQjdHjkU6BJZnEWt1pMiOrN77Vn7Hfi2cPXpWuwld334KB5MvuwRmR51o0LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876636; c=relaxed/simple;
	bh=mBwV2k+q1hPORHvgFegf/PJrwK8/SP5vT+6jTC8VqmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTj2nvQ3p4DuS7kcMDoY9HQa53e5ZBymqHau3NqlnDxz7cXpbgpyZncuV88Q+hyXuuLHDC9BsyKzM0WyLSgA/Q1lIZYq7AfnbG8f3iu3ORlS3KJ7rCsStdnD2PrL0b7BBoQlLNWpfjoMcfaBquTP2GaTbR8CdG2ed6NSeYnbmu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m/w/Q5VW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=izrT4MCc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFtdFw016387;
	Wed, 25 Jun 2025 18:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bLIwGG36ZppjMTo4f4BCI74Zjye7VSGGBi2KqqGYE/o=; b=
	m/w/Q5VWz0VNpy0QqXFeRSTtby/2O/OQ44LriVCw8Y2k9VrpJpMvTlmQsHlW8gud
	5ABHcYI4jPAHvOvcvy6UGPlAlmnjbc/AQ8WsODseuEUzimTsG1cHOStz+K1Gy5MV
	PE1ZyHbD4M1vYtKzBGmDFHilVGMPFBu7LZdaPLD+VqW0+UAp3bvRQEtxBfj9YWxl
	LCA14orYMnwtgJSZdY5XyqXPcHhSGgKeAwnTQbGSNOoumrJxhlLna0XHKqAEbdVO
	40GHASvutAw/M2VSkpT82I7F2XPX6UcftHx8edqSnQNGBTGitjdOplBSDasxjpzQ
	2RXcwK+eaXaq1hOsnFpKjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumq6ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 18:37:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHedsK001837;
	Wed, 25 Jun 2025 18:36:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr6ehtc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 18:36:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATlDqIQnlUW1zeafa0PyrSN6OvDwK6EBvVZrJvaZgVUOh37M4iLpOVcaQjaor7gnxU/XmhGWbk4mWZIJaTU74XX7mpZI+5W9Tf63Kih2PWgeVCnSORXNvgc6+2P7vp3nkTCPUgtasqyl9QC+zijsR8EQx4ESHepO0r3VXvElBn/4nQHnJwxDoxiWbyVGyWbpJvZKbMNBi/8jvyvvv6yNqzkeu/j1Fjl7UvfqD9PVADaZC1Ith0fu//2SESmFBaXUL3FDi5yIl6YG81lvE2wLQ/6DhNmrqd0arAPBTtQzDyOZ4fwVs9Itsg8xwkP0He7dfTCC6Kb/rB5GqQ/IwBFLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLIwGG36ZppjMTo4f4BCI74Zjye7VSGGBi2KqqGYE/o=;
 b=lyUT9InTQfe1S48j/cfZyYtZrI1PwYyYi4X9Mqa4c4yKUmAsB/A5f4H5SZMkZPExqBoCwzSFs4f1yofocFj4/yly9O5EzmQ4fMmHEUHtYQe+njuLHCvIehUrU4+vZ08d2dVd/g8syHrH2CJa5ht5fnKNdSuZ1jeb78C88Z4gYPn5DOxAhjnfPpWd9pxVdCb2Tv9YxJ4rGzpNSfEKLlH7CyVpV5viITIxw1WBZ3OAY+TCG1N7rYriQYYZC2FwlUKUxlxMc1kWBkh73FV/da3CLavewCB7vjd7MmbcDvgP+zdLIBTKtJps1PHDME1Fx/bg6oPkUf0PUYlumKi+TK7OSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLIwGG36ZppjMTo4f4BCI74Zjye7VSGGBi2KqqGYE/o=;
 b=izrT4MCcPeJhc+ivEfZ5mNl991DRmb5d7cEYoNF7kOFmMP4XhUYrstYDug9vDfsYNDVR+cyokVFxROpO6nbdZewd5TL8LQqxElPmJNMXer6H4cIvuU1jqHmqDFMS01gt5e7Idm3aEUnoOyhI/UPDTS62UK8eL3cp50Jd5VqwdwI=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 18:36:51 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 18:36:51 +0000
Message-ID: <af096255-8676-4290-a0a5-6edc95472daa@oracle.com>
Date: Wed, 25 Jun 2025 14:36:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs:check for user input filehandle size
To: zhangjian <zhangjian496@huawei.com>, steved@redhat.com,
        joannelkoong@gmail.com, chuck.lever@oracle.com, djwong@kernel.org,
        jlayton@kernel.org, okorniev@redhat.com, kernel-team@meta.com
Cc: linux-nfs@vger.kernel.org
References: <20250626002026.110999-1-zhangjian496@huawei.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250626002026.110999-1-zhangjian496@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::12) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ0PR10MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: b72e114d-a7bc-43b4-58d0-08ddb4174013
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Umtpd1JMM2R6TGN6byt2dnI1VVV3SnBQbEl6VnIvendUUFo0WnduY3p2eitn?=
 =?utf-8?B?RlVUdVVPdWRVWlVLdXhWNnNYME5Mek5zQmU5YkpSMGZLZmgwYVJtWWNnbHpo?=
 =?utf-8?B?OTJ5V1BJcE9VdFhUR2VMbWhnZ1JOWTF5WnlkUFZRNTJlbzRJRGoraW1Ja1Ro?=
 =?utf-8?B?bG5aWUR2ZkFvOEV4VnZlV1VmdmdNZmpoZTdtNm1ROFFXY25RVHV0NHlxQ3A2?=
 =?utf-8?B?L1p3cUExbGtPL0pVVzY1dVBKTlBWbURpUXc4SUUzSnlwd3E5aHluK0kwSUZP?=
 =?utf-8?B?VzNwNU1LS3lUdU9uTFpUL0ZRdGc1ajBuaFhLT05mblpDajVhcDhEYUNBZ2kw?=
 =?utf-8?B?NGVUUVRxOFl3ejBVanlueGVldmg1OHc3aHZBdWdVR0VoL3dHMjF1VThRd08r?=
 =?utf-8?B?RWZCRVR4dDVrRjdydnJKUFFwdXE5K3JaSEl6RDVVTmgya2FFY0FZUDFNQlli?=
 =?utf-8?B?MmNBSWRtdEU1b3M2SklodXVKdzFsL2JMeUFGTVpFWW1FcXhwMW0vS0JINDMw?=
 =?utf-8?B?eXdNakJFandobmNEWHB3b1FBcG9ZaWRycUo5cVVvVmovVEFqdExmMExXbUo5?=
 =?utf-8?B?UUk5Z2hGQktSaHR3UGxlUGM0eDZKSjNaMHYzcDNucFRldFNOWlJwWndvL0xK?=
 =?utf-8?B?T3B1RHRvdy9LdGpnTnNMZFdKdE5EN2RrLzNMTWlHMWxXeWh5cCtzYnRRbVVV?=
 =?utf-8?B?U3c4aHY0VDZBbTZlTVQrR1VaeldyekFjRkJybVlhaDZ1THR2MUFaaDdsSkxO?=
 =?utf-8?B?emJoOVVzZXB3dzJjcnpmTjFyUGRrZy9NLy9tcTBwKzRIb2xUUmhSMllER3Fn?=
 =?utf-8?B?UmlRQlRKYTN0dGxUWllEOEMxNzlUMXlRbkYrelNPOWREeDhYNUJqRGRvL1Vu?=
 =?utf-8?B?Ukk3WGtzeGlOM0dSWWJjamh5bWhacUFqOW9RSmg1aGJSYlZKV1RSZTN5Y2xE?=
 =?utf-8?B?eE1aNkxET1ZhNDVtZkVUMEVQWEl4TlJpbm5TMFYybU54U09WVDJVQWhhVWdW?=
 =?utf-8?B?Sjg3b0tqY2FyOVFhR1dNNmVQcy9tdWpENzFqRVhQTUdPMzFSWnBpMUNONWxj?=
 =?utf-8?B?ZXM0K3FydXZUTEdhNGNxTXNpTEdOOG1lUzRBZGJIY1VPMHBSR1VsdzJuKy9a?=
 =?utf-8?B?dVRkSkxxTG1UMTdTalgrL0VnVnZ5ZkZTdTB3S2Nzbm5idDRvUFpqekZtaTBL?=
 =?utf-8?B?bytFN3Zod3V1amdmL2pZYTJiMVdwNHJtYjJva3RkWThtWlhGUFBIaXFTL3pF?=
 =?utf-8?B?bW5oMVJhN2tQTXVpaTh1R1Fla1JYWi8rYis4ZGcvWForL05aNXlieXBGK0NV?=
 =?utf-8?B?Y1pLR3RZby94M09nQ3hKRU5keUhBRWdsOG5uaVdHQVppRHF6bGF6d0Vtei9a?=
 =?utf-8?B?bW1SVFl0SnJnU0VpckJZN1JxWXovR2hMSHZHSDUyY2E3c21zV0FSODJZbXdy?=
 =?utf-8?B?Y251eStjY1pwVXNucWhiTDhGaWZEdkRqZFFzY0pQVW1zOTMySnYxUU9yNTdM?=
 =?utf-8?B?TkNScU1ld1NCb1NsdGxKbDVtZ1YxOGNEYitrTjBuZG5LZWVlV2tab3RoSkRa?=
 =?utf-8?B?WWFJYkhwdjk2R3NCbS91TSt3bHQwUGVsQVlOdVZYSVpEV2I4a0F5eVgvUHdC?=
 =?utf-8?B?U0U4RTBFUldWcnhTZ3JjUW9CZzRRZytZcUEvVTJUV3RsZG04VWcyaExSVVlq?=
 =?utf-8?B?UEYyYWJsQWpWZGRZT0t4OU4vUHZ3ZTZXdk04L3ZXNFFFMlAyWmFjNVZCb1Bl?=
 =?utf-8?B?VGxtdUYya0pGN1JwNDkxL2h6eXJkVklRcExvbnQycTg1aTE4QXJZUXkzcmxD?=
 =?utf-8?B?SGxnUDFJL0RWdXZJekp5eXptZlhiQ1RaVUJtN1lGS0prRnFOR05Ec3lJZ1F5?=
 =?utf-8?B?OXBlRGdjZ1hOUVpFYWtkY2NjSjEyd01zWmZFL0hobEQ0bDg1UElhSWptREVi?=
 =?utf-8?Q?kODoFPrX8IE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?clorVkFUaytFM0FDQmZFOGFyMk9vQkpBWG16RnBlakI2bkVNRUZGek8waGda?=
 =?utf-8?B?QVVzYVBhVXdKT2hzQXJIQU5hQmFnZWtwbnFGRWJqYjEzTGkxVzc4aGdMeWhC?=
 =?utf-8?B?NEl1SFJQTzNOY0NYV1F4bDhZTUtxRThuSE83LzM1aGVCMCtiUXVrMXh4am13?=
 =?utf-8?B?VXowNk5VMDZobmxXVkFGa3NGeUJiWnFCNGFvNE1QNW80UHpTaWJ1VHNrNGpo?=
 =?utf-8?B?c25EY0g2cXNVWS9yMGp5VlZMVEE3WENwQ3hBOCtrbHJqRVFPSnlZSlRDQ3V4?=
 =?utf-8?B?TmRNeFp3bGdpMGlEU0FqcVU5Umg5NEZERHdDWEg4Wml5WUhCakJCV3JlbG1t?=
 =?utf-8?B?S3RiYmhaSUVySWtoS2tha1Y5RG4ySVVPOFdNVjNUcmhnYlZIMkYwZzhHNzJZ?=
 =?utf-8?B?K0QwQTRvTGVHQnV0L0lrdlZPTmtKci9mSStVUms3K2xabzQrQk5NSFNhUW1r?=
 =?utf-8?B?ZGNqRFk1YTBWK284dGQ3SEFYaEJLODdoS2htWmdGVVlVdGFOZ3RqcisvREJQ?=
 =?utf-8?B?RDRZYnJHMHRtQWtEOEw2OFVxRnByL2NnUWVLNEhVdW9XUVl2cHZ1NVlRSk1U?=
 =?utf-8?B?cTRBQ2g1SEc0RlBCTFo5bnZoYnhJODVHR2dBK0lwbUNGajlrS3NmMGNhTnk0?=
 =?utf-8?B?TmhTejQ0WGFnYnJnTjFmU0ZZL29LZ0FWNjY3VDJaS1hWQ1hlLzlNVFlEUnd2?=
 =?utf-8?B?Q25tVmVQOEtXSVRWT2pTYUtTbmhZVjBpVDZhMU4vbU81a2JaMDhPVkVRMWFy?=
 =?utf-8?B?T2hQZVBQUW1KSndKa0l0aW5FbHNVSStqaDhaZ2R5bGY4VXZvMjBicHhBcXNo?=
 =?utf-8?B?Uk5ESHE0bkpHdWRlVlNBKzlzamRPY3JYZTFmdzQyN3l3bEVDalR2d2FPSGRI?=
 =?utf-8?B?Mm9oQUd4Nzd1ZnlkemRyTzBjeSticUMwdXB1cDhGY1ZISTZoWTkvOGtva1ha?=
 =?utf-8?B?UG5qM2RyK2JTVUc0R21KN0orZ09FT09uY2xpQ0YyVFJtd0h4d29SaUxIZW51?=
 =?utf-8?B?Vmx1b0kxdFZpUEYyN0RCVmlxakwwVlhXTTZTZFU0eW5NVkg2eWNoTWF3ay82?=
 =?utf-8?B?OTRFNklHdzZqUTg5T0Z4TXZ4amlpeFB6WkJuaVhScWd6b05Na2E1Wm85UmpO?=
 =?utf-8?B?WU4xYllLY0NTWFNjN1JlL0RxdlNVcjNsckJsN2g5NkMzY3hTMFJEYlVmTnBU?=
 =?utf-8?B?YUp4YXdsN2JWblhDRlcyRmNTV2RzNWZVR01JUVFoQkRMUFJkSkVtaS9GNUZQ?=
 =?utf-8?B?YnFYRUZ1MEJFUStCQkswSWhKRG4xYXpyNnd1dnVTaHdXZ2ZNZnNMVDlLOWg2?=
 =?utf-8?B?NnIzelVPMzZ2N2JiVTJ4V05MWCt6NWkxb2dmajUzbjVCZzlKbGtKeVpqUFJS?=
 =?utf-8?B?dzc4dnNKSGJVa09iUGJ1TE1VWTJIYkdRbHZBNzUxbU5uMm9KS3pZc1V3My9T?=
 =?utf-8?B?cnFwRm1tMWx4RmowZTF1dFRQYll4VGR3dGZjNkQrbTQ1dEI2UGxwQVdpNFRl?=
 =?utf-8?B?ME1qeTZyYkFpeDFsQ2xUNzRxWUo3WmtEbmFueDZYdkQrMWRWbXNjVTRNMHp5?=
 =?utf-8?B?bGd6cWowbHQvYmdsbHlNa2dzOTV4K09BdUxZNzFvQ1BseDgzcVI3SnFBckNY?=
 =?utf-8?B?MWV0cXR5c3NiTTNWc3dCOFM4UC8rajJnQlBBOTNoUXRhM3M0bXV2MzdFbXZt?=
 =?utf-8?B?NjNQeExVdUg3Ui84UGNOR3FKQzlwTkVHRXAyR1VqVUpkUyt6VEQzSERPaGJi?=
 =?utf-8?B?akZ0OHVXMzNySVc0aUE1NldDODJLWFNFVVkrTkNKVm9wR0Vzek5zMHNxczF6?=
 =?utf-8?B?cEpvSy82QWEyRW1JT1dmQlZSRGVRdnZBWlpDd3VvMUxzQ3VESU5sOVNGY0Ft?=
 =?utf-8?B?NXhrenhOc3p2SUNGclhMTGtkdjZXbDVhL1FVTkdGa2lDSUpNR1hsME83YkMr?=
 =?utf-8?B?cmRUMnU1czVrR1VSa0Yvd0VieFIxbWZEOUFaQmozUVUwM01HQ25jaXVvNFZl?=
 =?utf-8?B?dWpGT3J2TU9QN2oyZ2VzbUl1clFBWE9EbVB2TnczdkhmY21jTXlvRTJLMExG?=
 =?utf-8?B?MU9Kb3J1cXFzVnovSTJyM0owOVdiUTYvNzI4SzNSWGx2UFExTjRnRzByRVVj?=
 =?utf-8?B?d2p1V3BvL1d0NHRPeHN0OTF4elF1R3JVU292UGVlZjc0eWVzbVdKMGxJNHM1?=
 =?utf-8?B?V1VHeWpSc0FocFNlVUpycE94WU1yQkFXNEMyWHN0MUFzK1Zpam0wVkZ2TlJn?=
 =?utf-8?B?cjJDY040UHgrNHh1ZWZzVzBOelpRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23xyue/vrspHaQ0JA4EFUqEgYtUpc51Zw+eYVo7af8rQm0pR/u6H5IYwDzdzoWM9KuMGsaKENY6FzVl69m7iul19VGnwGY6WvEhEYSiieLstuFgDhK0j6X+VEQN5w5OqnUPnvgAZaWZlVCZoc+ubrKO6LjDWSoVrMz2+cL3GYirGt8TASbyDUQZVHSFc8rByEygJyyqaYmsqb1ywzauiedQJ8VLeZGndMMEYG6TjJEEJJ9QX/TTZ5vMVMX6dES50X7m8PrIMHF1vn4sGGoJKvP4sedQ8Y5OGu15h+3ZmCoo5OAoPih/8w20dzg4RbYjm2WeFpnKvskigZC+/naPvJfJXyXuwXc2z8DGoov97siMglSohoDfEWhIlHDUJbmjHpZQsCePt4H95DDkb6/Ez4ZhDYyVmLeaKGK1yTeMd4FgUkrAuIdwi9HLWVbpCOy5x2Pei41Fa6KEDgE7Yo6sbGQ3c+FTkP1jUEeOiLTDpoV6xlxh/6vvEfLhMecTw0kYmYxQ6KtkTB7s69yICBlMgkKXRJKHY4PtzVgti+mQOpyFEbi0pSZJnwX4JQm/TNjzn6Q16atj2d4DnX7Otv6NhQaSWZsmDTSk4tCBpQiBeFgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72e114d-a7bc-43b4-58d0-08ddb4174013
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:36:51.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeMaTb0dfZLeeBMHwEZV9H576UDEOMqIkWf4QBQgIZkoltRxpCWODLn1F/7tZUQZ54eRoSoma+4EaG/aactKTJmXYkwSmuky9yymBvgR4AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250139
X-Proofpoint-ORIG-GUID: tfy7oaW-ZEecQzvms4tEyOZr6s_1BeKY
X-Proofpoint-GUID: tfy7oaW-ZEecQzvms4tEyOZr6s_1BeKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MCBTYWx0ZWRfX6USJyi7ifXou UiDlgE3vak1Skwh41YMNbgDABfsuDaSztxuZnN07Zmu+GaRMbySsrvBOyqxKJcnPYzZBLqE88p5 SPozuIRIqU/f57Ip4eJo9JcT4ooQYnIYV+u2SBt5/a4lUQ84hhrD52HtEml0NbSGqn8PajYMOrj
 LcTEyPWJjqILFKKzZK/xJxC5l7+u62DRcG08a6Hv9h8kGhFR3CQ0KZA2bz2tXymnlVadw5MLO54 0XluGkNilAeqp3cymB5DAkY+LMktmkJfCC03+7oMN8WrhSm6wRome2zo0DzESOKEll2lUMfQ0Sf e3ZLXKYlwT5S3sHsvrKvqpevemRy5nX2Kwvc9MTo9qXMQg1DFIpLlzXzBJ5HL2VGtyMIX84NBjv
 RaLq5jOtU8XkdURAhnzphZITFU5omKlqWON1ZdEzMTCpsrs/TSX10KnlbP8OgMevTjRCNcn3
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685c41cc b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=rXwCkeNdJSY-7hNXGK4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215

Hi,

Thanks for the patch! A few comments below.

On 6/25/25 8:20 PM, zhangjian wrote:
> Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memory
> of server_fh is not passed from user space. So I add a check for input size.

No signed-off-by?

> ---
>  fs/nfs/export.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index e9c233b6f..e0e77f8ca 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -65,8 +65,8 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
>  		 int fh_len, int fh_type)
>  {
>  	struct nfs_fattr *fattr = NULL;
> -	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);

I think we still need to call nfs_exp_embedfh() here, otherwise this pointer
will be unset during your "check for user input size" check down below.

> -	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
> +	struct nfs_fh *server_fh;
> +	size_t fh_size;
>  	const struct nfs_rpc_ops *rpc_ops;
>  	struct dentry *dentry;
>  	struct inode *inode;

We also have "int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);" being initialized
here. You should probably also remove this initialization since you're doing it
again down below.

> @@ -74,6 +74,14 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
>  	u32 *p = fid->raw;
>  	int ret;
>  
> +	/* check for user input size */
> +	if ((char*)server_fh <= (char*)p 
                                        ^ Trailing whitespace> +	    || (int)((u32*)server_fh - (u32*)p + 1) < fh_len)
> +		return ERR_PTR(-EINVAL);	
                                        ^^^^^^^^ Trailing whitespace

Thanks,
Anna

> +
> +	fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
> +	len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
> +
>  	/* NULL translates to ESTALE */
>  	if (fh_len < len || fh_type != len)
>  		return NULL;


