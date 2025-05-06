Return-Path: <linux-nfs+bounces-11525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867DAAC899
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814294A7CD6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862E280CF1;
	Tue,  6 May 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBkEK/Rc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NBvmBDQu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABA8F7D;
	Tue,  6 May 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542989; cv=fail; b=JHBLoeGUF+cjIhKMdpo+3P2EcU3Wv5a7C+T63vMkZ4NC3f3YPKnSb0m8rJfzKQX4jOlR3o4SmCwzt5JCgbd6wakl+o4d/72fRfIEFTzrOxDo1FI34b1rDWVlbaZHqS8rhs/3+6sYYrNon+O8ct/0x4a5TwTaJ5hNnjsO0ZIz8FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542989; c=relaxed/simple;
	bh=Kfp9+kInc7WSFyFilyho8/bCk2648qUhHB8lXbp6jDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/x6VUu45EfSN8Oknsp6hz4ljyQ/NKVH0w6x7bnwZj9H/+WnJaaya7RvOsmTwO6l0GbAkjEvulDros/SRwhJ53NI+JJUbdDfyFboxX1IhRI4Mc4NTnXX34PFONEeWy1gEI0IiZFrKC28mcKSIDKBRBZzZEU+Otg9VtcGIhcrUeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBkEK/Rc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NBvmBDQu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546ElAhg022166;
	Tue, 6 May 2025 14:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tpUsPVSwgfUGiC2YSmZ+LvpUXG2BZ4RaJBeG/FTfLBc=; b=
	HBkEK/RcEIi+awxMLXYtm9iQRqIVnUekmZirPn/YUw2ThDlC5zDsNSD0Dw0eFfsV
	PPMvD3dwkPnBAI91a3421xt07YBwfgSm7QTT9TBWHuj/df5Y0kzNYGU2SwlagLAV
	U7tFqPf96jQ2yfveao9a64xdLvGo5/95eTsGbjeUxfIl8lo5GUqwk45hizvNjNQY
	9dyr6Z4suMLWhXAzAjr5UrB5vuxq17l2dBrCBD8Blc7xl+aHEJ/Gip/J7ekCDaaf
	cO2cOaqN4gHPajnnQBkXxo5DZDS0NSDmbiWMJnq3eq8Dkp1vc4R9xgZCLfY7cIXl
	Z+jhDxds+E0Cppst0OT13Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fmg4805v-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:49:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546Dkkoq036036;
	Tue, 6 May 2025 14:42:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9uybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cabq/mIx7QSPypisSxYduPM3Ltw92JR6DKEuY9El2gnxbQ5/Z+PwgonOc7jrtm+aP89+l4SCdJSqk0C4XQcOPptduZ9GWAk+xuLZj1Z6wQZSwT2iC4GTLJiliALHghUwQ5/E38gekzxx5tDAjVUjW/SGtCS0lEmpdjFyOrxqz3KBHK+bwEflWeb91XjWyr2bVXAwmdRPpWOcGyZXqckFoiNn3z43KJ92NXE1sv2jQcQRPNWpU1k3oiiwNG2np9Oy1GUeWZfVZtvLLlb0Xngv9uaXYB39ggTlQopmyNh3IJv8gSw8XFEZK3g5J+EpPVAfUZbUAU14TGJ51eMo9qow2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpUsPVSwgfUGiC2YSmZ+LvpUXG2BZ4RaJBeG/FTfLBc=;
 b=HK541HaUram2cI2VSZ1KNEyqyFM/qcq3JXRhCZeyMSILrYjHjdvAvQ+VjSD/tNi10xpoYrxZwyGd4sxu69UVbbgOkOUdiLhRKo47qF7y+yTcHquqiXAIqtCz/tJCmqKG7wcrXbXJmZtOGD9Dl6ZN6OcLSzUyH9XWyvVlYNVi0oSe9c4YRSjvmBumTe+XNtx5LNlFb7vHEF/LxsckBSK7J0UORGIyv4sseZVlAYbkx3RPzFKUdCJ/li/SfgonjcJY4a1K8ZAFz7NdiIKF7ErxaOVyF2PTbUn2QhbZlQFL9cyaSmL34jEh8pB6poslC1k3DKkwPnQsMZicjA7vmowINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpUsPVSwgfUGiC2YSmZ+LvpUXG2BZ4RaJBeG/FTfLBc=;
 b=NBvmBDQuJMgesOCIorr5W6sre6WbM7Fsr1REWnDpPL+Z99Uc0pD8lNzNn5bciivhe+c8UHoRlJJ1cPCND+P8MR1TTQo0JAutA/6bXFMoweRBndmnW38aW9QbiObN8dZZ5AhEAH5Tq9A8JUSpgfXZLgPNcCp/r/2LCjXhF1F07hE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:42:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:42:07 +0000
Message-ID: <189f6b88-4660-45b4-8830-8a98b1e145c2@oracle.com>
Date: Tue, 6 May 2025 10:42:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
 <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
 <aBoddkwEbyqGllOh@infradead.org>
 <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
 <aBofRwc5u-sqFgPY@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBofRwc5u-sqFgPY@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8ad259-021f-449f-a198-08dd8cac2ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SndjOFZjcjM0Z3Qvdk5CMXlrSndST2pwK0pZdGF5NDl0MUFQam1RY1VMaEhq?=
 =?utf-8?B?R1h3aXpxMTlKN0pYV1p5R2ZrMXI5YWdLenJINEQ5UjFSTGM2ejVaS0ZRS09Y?=
 =?utf-8?B?djd3ZldvOCtNeUhNaFJkZ3V4TUFFWU4vTzlDZUNIWXNKMmZLNzJSd1JrOWxE?=
 =?utf-8?B?eWlqYU9pakFDNTlQbUFSMzZ5aU14NWNmaERmaHd4THhTYXlxdnFpeXBiWWNR?=
 =?utf-8?B?Wkdiak1uZmVxMTZENjJUUEJra2NoWFJQTEtaNWVmWVorOElaQTllYUo3TXcy?=
 =?utf-8?B?L1BWR1VmaCs5aFJTVC8xMHhBdHh5cmJCT1hDemJWZkV5WkNWek5YbzI4Mm5E?=
 =?utf-8?B?bVRhRitOOWhZZFZPTmYxWHNOMVFoUVNnRkY0M3JJY3JheDdadXpQZFV0UTlK?=
 =?utf-8?B?c0RzUnFRWERhZ3pIZnJzVnV3czRQb0pnMUVyd3ZVNVIwUTgrVlJxVFZnaTZF?=
 =?utf-8?B?WGU3K1BobEFsdWNKWUhxUVF6emtzbCsrZFRGZ0JNU0h0VVQzcWpmWGI2ZFcy?=
 =?utf-8?B?bFZxWUNDckNsRWsvRlE5V1hrTjVqNTd5cG82cmM4NHNyTzRVdEE2cGdJYnBj?=
 =?utf-8?B?YXZSU2QxdGt5eHg4azNhLzJoVHFCaXkzN0FvM1h3NWxzOVA2UitFZW9yNHJj?=
 =?utf-8?B?Mk5xbnJFZkVMVDJZSVhpWVpxRGlRSFQ2OVMzc3AzVkFLSHA0TVVpWVpZZFky?=
 =?utf-8?B?THJabjhBaGNKMVhOZWhVWGRnWU4rVy9VUUdYRWJoMHFHUnpSeGFtU2FBU1Fh?=
 =?utf-8?B?dXFnVEhFK09VdEF5YXNaYWtFZy8xRk54WjZ5c0hYbTJaS096V25SSnpNSXpQ?=
 =?utf-8?B?VzF3YUYyUTJ5T21qZk1KcVFpdkRGMnBULzJLcngxRjlpOFE5V0QvbVRBalZU?=
 =?utf-8?B?U0VibUxqSkVXNXRmVmcrV2NMc0xrNkpDc0JnM2IyUm45emxsY2R5NjE1ZkdS?=
 =?utf-8?B?OW9abWVHWUswM2t3ZjdRcEJobFJ1OWRtb1dyUmNyWFpBYVRMRWdvQklSM0g3?=
 =?utf-8?B?amJCWU5Pckl2cjd6UDZzQUxGOFhEa0R0RHdvZGdZckpKMGdZeldyTWc3eWtk?=
 =?utf-8?B?UmVnaFRnRncrL3UxMk5ESDdPU01oNXhMMVBPTzc0TGNGclZEOFVuNnZRSGsz?=
 =?utf-8?B?NVRjSkdrWDM5N2Y3eG5JdTJyNVdBckhMdUJPN1RIWlZCZjIwNnUwNi93YXp1?=
 =?utf-8?B?WXVURGhkWWxNdmNNc0MwL3ZwU243V0p2YnM1UzEwcEpnZy9BSXp5aXNIT0Zh?=
 =?utf-8?B?MTdINll1ZzJjY21BS2JHSllCaHlydU5VSU9qekEySTBzdWxKL2NFVEJON2tt?=
 =?utf-8?B?ZWhNdWNRUE5ZRHd5ZDZjODRyamV3MjRGVHVXRG16N21ZRHk1RE5sZTVpZ1Jj?=
 =?utf-8?B?UWptZjJHNjkvTzllWmd5OGxHRnRXVjBlNUFtU2QrUk9jZjhER2RDam9xRHRO?=
 =?utf-8?B?bllNRGNIRGRydURONFFNaGZvUWxmMVZTZlFpbDVNY1V6aFNHaDF2bFZXRjBn?=
 =?utf-8?B?L3ZUNmorTEJiMVJXU1NjN3oweG1NdmRVUFNBNnkzRjNPc3JNeHBLcDIxY1c4?=
 =?utf-8?B?VFpnSmhSR1JaMWVaMFk1VEh4UlJOZGZpRXE0RU5DQnA4NGtJc2h3TytuQUhx?=
 =?utf-8?B?djZKdUh6cnNvUHJ5V3NNUTZWcldyRG5ObE5LdFA2U09vOXZxcUJKdnRjWUpL?=
 =?utf-8?B?SmN0UkQ4QlBUTWhLSjBrdVdwWXRmWWlYK2s0VnRKUTkyTE1GOGRmc3d0K2wv?=
 =?utf-8?B?N3hJclFlbWNwOVQwcTA4em5QbFVpdldtK1U2RnZwWG1meldZUzg3eTJpUG1t?=
 =?utf-8?B?V2Uvc3l4NG5KcFMxOGNTdHpUWlBTQXdVMjlneElSQ2ljUGN6QU1CR0xhbmEw?=
 =?utf-8?B?VGliZThxakx6OFhkZWlTajNiSlM4cTRqeDVyejdhWS9RVk1vdmFrWncxa0E0?=
 =?utf-8?Q?S4d2Z0sGoV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWMwMTg4M1UxL2hQYi8xSGIwbndZbzJrMXBBSHhKTEUyb2M5amFIT3J0ZGYz?=
 =?utf-8?B?eUhOdERkRmJvVnFWNlZSSncvMVJtb1o2ejZyQXlERzVpaHNGMVhIamZIbFVZ?=
 =?utf-8?B?YzFCaStKR2IzbFlRU1M3eVBhRU8xZEZrUWttM3lidXF3UHFaclFnVDJ2aHdr?=
 =?utf-8?B?VXU2V3Z2NXBHWEN3SFBURXZvcEwyOUtZL3ZnVExJZlJpQzFLZzQ4YkJRdGIr?=
 =?utf-8?B?K2RGWE4yajlRMzR5NUlnRXd4b2YxeG5TL3h4bWc1dkNFZG9lUnpaZXlIUzRS?=
 =?utf-8?B?Mld6dHViVmVnREQ3eXc0bCs3MDdXSGVKbitlOHlhSVcrcnYrNWQzdkV0ck50?=
 =?utf-8?B?MVdrWEpkVEJUNGxUZllKSExHSjI4TEg5SHZIbG56OFVtRXVBQ1ZNaVRDZkxR?=
 =?utf-8?B?YlNIQUhOTldNQ2xydlp3Z0Z2eUZUc25GcDN2MlpGeUlRQ0tONnNwUS8xT2RZ?=
 =?utf-8?B?M0RQT1N0V2ZyYzcvd0U4SVlJbGdaNTdvc0NsdU44ak5JL2dGRU95bDRvam9H?=
 =?utf-8?B?aEZTcjBKdU9ZS1Zhanl4SDdBMDFwSnZyQ2wzWDIvTC84VkRRTnFKa3kyaG5i?=
 =?utf-8?B?SmdYRnpSQnc3eDNPRVZkT1liU0UxazVnNFo0ZGx4cTAxTWxSMUtJU3djRFZI?=
 =?utf-8?B?Sm1XYlJWOUU3L3hQUmV5aUdJV1h2eG9tL2hWVEE2WmNGeUZVZmJwcW1YY1d1?=
 =?utf-8?B?Mm90NHYzNWNwRXJMTkxkZ3ZMczVVM1ExaFF5VGc3VDIwYUp3OWUwYTgyTXI2?=
 =?utf-8?B?YXB0WENxVmU3N2gwRWJ1VEp3Vk1mQ3VrVGpWLzJGNTJpOVpRRmVsdXdyNHZn?=
 =?utf-8?B?VFZzNFU4c1hQQXoraExmQ2xyN081d3h3UlBkR0FUbVNoMS9BTm5XRVBoVjBN?=
 =?utf-8?B?elQrbHlzVFFSRmVLTm5tVzNkdkZ5UzNWNy9DcFllcGhCM0l1aGVTMTZVK2dp?=
 =?utf-8?B?RWJySWd2UjUxRVFvSVFuUmpNSmREWE1qRndPUmhTT0FybE4vSEhibUJBbVRp?=
 =?utf-8?B?Wm05ZzZjWXFOMGRQN3NnemlXM3RvYXhGMmxxTUJ6ZzZKUWsyb3JSMlJmVEZG?=
 =?utf-8?B?QWJMUXRMdlJWZ0x0T3FXMVFnaXNLcHhsOXFrUHNmL1ZhMy96enBJd2hyamx3?=
 =?utf-8?B?U2hBNTFGYzhaNTgwZ0RGek5xdzcwWTByV0xmVDJkV0Z2RHkvaTZKTnRLODdy?=
 =?utf-8?B?K1VtN0J0U1Bab25MdEdEd2JSSUZWaFB4amFUS2pHN0p0YTRTNWV4WktZd2RD?=
 =?utf-8?B?K2cvUC9FWCtkeDVSNUxueVhSZE1UM1dZa0U0by8wWUhVR09BUXBjc2k1Wlk4?=
 =?utf-8?B?NHNENUZpWmVobnZZTTlGdHdtbzljbWNSUXhzZFBiWjNNdFQyQlExY1VESzhn?=
 =?utf-8?B?UkpZVElXOHdCRHdVSG5KZU1WR2hJcU5VcnVlTEZKMHV4SEpqcWVoYWlDMXlJ?=
 =?utf-8?B?T2MzdVIvSTJGcGZVZjBDTWR2VjQwYW9RaTZGU3RwZVZlcW1Wd2lHd0VEMmEv?=
 =?utf-8?B?bTFEL1VaSzdKY2U2aTM5ZkdWdmNpUEl3bDkxYjM5T3BENE1ESUkwRnhXdE90?=
 =?utf-8?B?Q0Z1ZjNVSmNLUUFsQytTS0taRDc5aHpLdDMxMUN5YTZjeUFyeXF0MFM4Y1B1?=
 =?utf-8?B?anlSY2F6RGUzSDdyT2xuSlJkdWYxSU0vUWFJeUY1TDkzK2Iyai9yalJCc01v?=
 =?utf-8?B?OW1BM1dmZ3ZyRTByYk8rQ29UM3ZyQ0o1OU8xa3dQS2NXUFJaVFVxWEhocTF0?=
 =?utf-8?B?cSswV1ZhcE82K3dhcEN1Y3hMaXRMM1BuQTk2YjJFZFNkbVJJbW8raXVQL3Jz?=
 =?utf-8?B?eHE0d1liZzdPNGRRU2JURVlaaGFKL2ViOFo4VGx1bHpHUDVvYUVHYkh3UTRD?=
 =?utf-8?B?NkkzbW00ekEwUnJici9HcXRYWWJ4SDRMdlgxZHdIY1lGcWllQ2s3d3M5blh1?=
 =?utf-8?B?dW5vM0ozM1NvaUgxWGpOU3EvVUZ6bkQwWjk0SkJBVGt5eEFndVNVUFNFeE9B?=
 =?utf-8?B?VFRkSTFLQk1JNVp3SThnajVKeEJiV0JUaDUvamhRMzRqVmFSSGxUcndkWlN3?=
 =?utf-8?B?WlR5cEVnZTVyRERZK2oxa2JmczhCcFUxMEFINGRLbW5zejZ3cmRFUUIxOHlt?=
 =?utf-8?B?TjVvQnY3MVBTb2VJOHVIdldhMFVXUGttNDVUZVJOU1R6cUtlbFd6c21tZ0M0?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1nkbFSsBquc0UnR5W/D2gHssZ5CGiesOweN6utydPCqrS7KOwKr/ISRHQUqwn6n80/zcvS5ST2NC/OJ2km9MbhDAu3pDVdVmKj0TOjAVf/0JgPlrOYDiEdOC8X6qAbLHsygFDU3QRacPqdxJb+dcdBq5WMOAQEHE2p5Sx9yqC1DbgMLHyA7lQ3n0uVVq8RumptBgzbSRFHEJQss4Od57Sg0U4ujE9D20vcONp3nepNgh/z0pOwX205j2QDcg/nHnkZlXLrzYrt+uzrdITn/Y/ieLL7SakylAlhAWzJsY6zle08uQICzYExPj/Dz1S5z3jN26IiABDyo2y5H2pnX4eUp7N3wZ7fwmccIwb9CAT3ubbt8bwzbQNQFc3PeIwPZ9CsQMbv3OBMx4pzSh4eraXtdLPS7hMQz6n1A90Rzj71EMuxEKKKkn9SEhPdVR2n6z0fR/E+7MtYJxvyHIg1sfRDKt07CHZVYu+ZOfUZkmAJHQqIJRuHpugMBC/+2pixqSHWStMBs64BdkyoAWdf40Dj7NweQtvkL4kBs7bp0X9miRp4EXlReH2PD8VDhnSza/+j7Iu6odupJ/smQz6Pwk4RyQ9BOv/Z9/ZLX5tyKzlBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8ad259-021f-449f-a198-08dd8cac2ccf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:42:07.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7MY49lUQCosvmpNcxxaDxylKdYk6/56rBx3G2yItUxM59cr7kO+ORKLDtP/oR3js/lXukFryjOl/hqp8hcHFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060141
X-Proofpoint-ORIG-GUID: 1eNW8PsFrE1IrxYepqeaIs3LoKnpzman
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MyBTYWx0ZWRfX9srvBbrkeYG2 ovL0U8wLFjQf4yfW2qR8KB6A2GP+8nx7vplJbOiF3mLKhqajYBdK9y4hDHtR7Oh44C6OfEqOInb cB3A3nRrHbxHCSpR8T7TDNxXwbpeC6WdcFyCwYJwFolZpu9mjeMniap04Tkwuz4QWlpbpqrglaG
 wajsWqP5ZzX+OiI7+PSE1GDwU+m3dtzY8zgAUNubGGKCINjQgKtI+gNEPIMM3np67t/QFtc39Ue aXn3TZM3aCLrjkSRrbPfE+kN+J3Py4H3e+3HyqE0jx9Iifex6nFmh7A3bqagJcvO17CUW6odplj k+ASD1eToJ3D4tUirlp5XmmpUaTX3wKgVUfSa5Tl77FtODbDWpQ4ZtZF4cfwSQ1hJ1vSZHHUy7q
 BGRo6wrlItwuo8Q0zuP5ZuSS1nvonLlliOHD5yfsxi9iVGLcfGlknhDfMT8BQ6m4AK9Lh8BP
X-Proofpoint-GUID: 1eNW8PsFrE1IrxYepqeaIs3LoKnpzman
X-Authority-Analysis: v=2.4 cv=Au3u3P9P c=1 sm=1 tr=0 ts=681a2187 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=OcuG1dj5w8oJBjjaVYsA:9 a=QEXdDO2ut3YA:10

On 5/6/25 10:40 AM, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:39:00AM -0400, Chuck Lever wrote:
>> On 5/6/25 10:32 AM, Christoph Hellwig wrote:
>>> On Tue, May 06, 2025 at 10:31:04AM -0400, Chuck Lever wrote:
>>>> I do. I can't burn that bridge and stay employed. So calm yourself,
>>>> sir. Let me ask around.
>>>
>>> No one expects you to support this.
>>
>> That's just the kind of detail we need to decide before we can "just
>> fork it" -- who will be the maintainer going forward?
>>
>>
>>> But you should also not expect
>>> much support for a project with a silly CLA.
>>
>> I respect my employer enough that I think they deserve your feedback
>> first before the rug is yanked. The best outcome would be that we have
>> their permission to move this project somewhere more open.
> 
> That would be extremely helpful.  In the meantime I'm happy to host a
> development branch freed from the CLA pains.
> 

For the record, even I do that:

https://github.com/chucklever/ktls-utils


-- 
Chuck Lever

