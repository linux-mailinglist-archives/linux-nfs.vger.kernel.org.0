Return-Path: <linux-nfs+bounces-15958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B7C2DF77
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 21:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE8B934B995
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA12BDC16;
	Mon,  3 Nov 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXNh8UFb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h3EmtBkX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF72BD5B3
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200206; cv=fail; b=jvK8nr8HFKXlAHoDr83K1SapRWTP49xfDl5SMBMDueF4z/k4LZ6qPbrF70rlU2GaBKJ8103x4rcY57cX/4RTi1UMt77ItRCOAai0O9mhz63eut1BisEc+UX1oxqEZ1VGSRc4aD8S9hHJjGDIaZncxcOP8MxN+K4AYM/XnwAJY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200206; c=relaxed/simple;
	bh=5Rbi3R9A/Szkzn2OSOzN3L1NlKMc4SEmqYhY+yRHkrU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sE2fkD4R7hxoRtPnOEhY0YfGnI1g1+rOPAWS6UtCn0D7SPTJsjQW4P9NDg6YssnIVgJ0A+toyerr/4AWn+SMH0GVaHEnL5E7CdClVSpAr9HZEQELhpGZmUim5qTphQ4i1zCaPA0RduvrArK42VMeC7h02xk7y62Sf2kOyFVcI64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXNh8UFb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h3EmtBkX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Jvb1s006934;
	Mon, 3 Nov 2025 20:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=99zgOLZQUzvwh+1e4hQfqyuOQjhsqcNiyIx3ED2eXx0=; b=
	aXNh8UFbuWVSl+uHo3fDjwvRPMXWY9gbhLfqe68jhhPQ0Zg239gjzpU2Ql3Gz8zr
	E9VaOOo5XyGET2QrSiilGXS7VvKmJr9D/3Uao8aZcQllXW6shMpkw3EmhJbaFI9T
	VWPEAVZKFgWyguS9YF79baqy6W6hSd49abvCouwRNA6t5joWHjWQQvSB3DTVU/dR
	G4KOe8ItHz8OSXH6M1o92PGZ9Nc7O0kYE6LQ1sBV1yEsTaTbqqmXemc8yamNBY7q
	zJg0d83V8K2qGDTLFUcf/xbQqKHcYYhzlL/gyCc2Y93xR/V5Gi56ODPTMr8Ru2EI
	LtVEBK69vwlmvLd1K+UGPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a72tj81qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:03:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3ILc9J020944;
	Mon, 3 Nov 2025 20:03:14 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8mw7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwa+pIxP4hmaoS3JB4YgNW0prSwWoZe8FZkBEQjgfpobaGgpllQppfMnThm1lL31uP+XE9Nodg/ZkxialElkl63XyCXh1YkMrCz6NIsbQHz0SU7j1HxGc+I4TK9OvJtkjt8tzvtY4rf1IyVP21gwweXAGTz9AqwxvRoYjDX9ujL7tj8G7Vj8eTKg2SuzhEL27rYqzA56m0x60TJErZerLRKVe08DqiGj7WpUfY1gzwPPHd3CWk4cl7nBhQ18JcX51AJjcWCydO1X4GxBtnSmg8Jm0s9O28l3GHm1LtGYFoKLGDadd33tA7ZUMnguB83/Ch89MiSOSpL3wnU+tKMtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99zgOLZQUzvwh+1e4hQfqyuOQjhsqcNiyIx3ED2eXx0=;
 b=V7SGF3ALJrVriVYr2S/i5JprAaNqv38hIoNGHFSA3cYGSFtBEc0n4whFCcR57DVkaTIy8KTGIKAIxDPGfySOlD90JJSFVH9CRb7dyS2r0UGj5oHEHrPVqT6V4LTRPATOA2HDirPG8SL5cUI0+QhBUyjj2fve5BBtXBTl49m1eY3uRopTCKj2dEAaxA4M2G/LRqRVG5wwZSDk81k8bcX2aKacb47jGphH42ORphf2Xk/CVpfDIG6W/H5MSw4BISoKWK7JTQ1M39Jk+PEWzUPHomgPM5EY9WS/nM/9njj1sSU681msPmLbr09HA4nPCHIVymv70U9M+Z3KODp9H78Q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99zgOLZQUzvwh+1e4hQfqyuOQjhsqcNiyIx3ED2eXx0=;
 b=h3EmtBkX6olfePc7Hx69WxK+4hhccgnkyqL73MEWz44QusYPqOTY20RuCfyyxu5CdXnSliKAKTHIF9Nu95akFc4Y6lKvElGosb6hQdZn2rvLcQtytdO7VP/IW3ad5E7r9KA2dphyc4PIwAR0HsXOZO2rjnbR7gwp9tSSZSK4X/g=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA1PR10MB6446.namprd10.prod.outlook.com (2603:10b6:806:29f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Mon, 3 Nov
 2025 20:03:11 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:03:10 +0000
Message-ID: <0ccaa75a-9e7d-478d-b33c-1c777eb29dd6@oracle.com>
Date: Mon, 3 Nov 2025 12:03:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
 <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
 <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
Content-Language: en-US
In-Reply-To: <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA1PR10MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 716598d8-0f89-40cb-f2b8-08de1b140388
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WnZnWWYzbFU4TmNJdHBCWjUxUXFkM0NlS0xEaTVsb0s3c0NlWWZCcURLekg4?=
 =?utf-8?B?MWxoQUVjVjlXT3dJVmZiQXhjby83TjV0L1hWaHg3WGRzVXNma2Z6bTRRSFVl?=
 =?utf-8?B?a1FBS3lORlQ4bnEyMVBIZ1ZlQXkya1pZTVBESUV1c3dNalppQk1SWE9LZmdB?=
 =?utf-8?B?dURBQU9KczdOM0FoSnhhTFBSejVxZnR3QmthdUlIT0hOeWt0bzJiSFlEa2tk?=
 =?utf-8?B?V3ZKTUhYTzNrTHRtN3lXd0xUSDdhL2NaRURBcVM0aVQ1dmthVGRvTEhLTCtO?=
 =?utf-8?B?Smg2OWRmczd5TVBhUFR3L21xYUJhekpQNmpXN2dJclZBNmlLNkJJcEppVUdJ?=
 =?utf-8?B?alZ4M2dxQ2tjNW1id0JKSDR2cVp6RWtQN0ppcGUzS0owazF4ZzlQUVltZW4v?=
 =?utf-8?B?UnFUZDR5SkRab0VtZU5Ha0dJSGVEclVLcFA2RTJrTGhBaXFOaXV0Ym1sSFV2?=
 =?utf-8?B?TFROTmNmblpXQ2JraGprL1ZvLy9qSXIrVzQyMlQ3bmc0NDZKM0t4UkJzSE9X?=
 =?utf-8?B?aXA3TFJ4UjBLYUpHZkNVOHFHSmFNdDdKVjNVT1Q1eXZKWFRiU3lkY0dGdEhu?=
 =?utf-8?B?bmxRSlZFYllueTl5NWo4UE41aUM4WWFnOUNvWGRPWnVXNTJvM0Z5bFNFRVFX?=
 =?utf-8?B?dkFESjZPTHBrM2FBTjN1UkFzZjcrb2YvV0xnRlZrY0R4azdQTEIxM2QzeVBs?=
 =?utf-8?B?Z3l2ZS9FSDhQMDZoWi9tWVFGQ3l4aGNVa2p5MHV1VkVGMVVxd3Vqa1pDR0li?=
 =?utf-8?B?Qk5hNm1abGhWUy83NW9BQWtMbkdTcmRoR1VQNmZaZ09US0dVUy95ZkwzVWV6?=
 =?utf-8?B?a0QyQ3RzTVRMa3NvVUY2Z2dkdTBDbzRycC85RnN4aW41c0p1eUtKTmxORXBl?=
 =?utf-8?B?b1lIa2lSTGJqdGxOVDc4ZVR5aUhYVkg0a1I3ckpZbUJjQzRLUkM3UFMyQnpt?=
 =?utf-8?B?NkN0MkR2ODJ6dHZoWDNZNk5FYUJMbnMraTlRdFhzYUs3b3h1aloxN2t4SWU4?=
 =?utf-8?B?UENkYkxIYTZIUVNYckJ3dW1sQWVxSjhPYkFnMURqeTlvb1lwQWROZU5iM3Bu?=
 =?utf-8?B?MTJwNWUyS0hzTnRRcFF1Y2E3TVl0WHZMOS8xdjZSdzRDSTJ4WjAweUU1NWo4?=
 =?utf-8?B?akQ2MS9pYjhjTVhHcmkybDYrUlFUK1g0dHlQcWI5MDMyMkMzMHlSTXZWSEl6?=
 =?utf-8?B?bHdUNlEwY2VGZDYreC82RjdaNy9TYUZ4cERPeWpVbGtVSEdsZmVxMCs4Vld1?=
 =?utf-8?B?SStaZEpNNjBCTDlrdk1zdWk4K2pwcGpjSmd3bWtESGJEeloxS1ZYQU9HRFIy?=
 =?utf-8?B?WnpuVXdaU1VJaEZqaGdueXNrRDI0a0Iyb2FNK2ZoNzZkL0gzYWpEUDdNUXRl?=
 =?utf-8?B?U01HdEorQTVVNW5IcGE5YmM4blFJdUN1byt5ckdjbWFGakVjSVdGbGF4K3dY?=
 =?utf-8?B?N1ozVnRKTzVWNzJuR3JBaEV3aFlXTit2eUUxMDBGMGRxMndsMEI5WG5wYnVm?=
 =?utf-8?B?VnEySnVGVld4SHFkS2dLTml5eXhzS3ZHb2xianFndUhIWjFWc010VzVoQVRQ?=
 =?utf-8?B?K29kRThMWVd2dVRjYmF3UWI3d1Z3ZGgrNVJCMEVzMXNRbUM5c3FtUnNsdURp?=
 =?utf-8?B?aFJGUXVuamF5eHEvS2pqYmdrakdBNWRGNSs2NVR0Qno0SzN2bVJsZ3RoZjZW?=
 =?utf-8?B?NVd0b2ZlNUtHMmFBQUFhOVRKcWdJOHRyUUJvenFhcFdraVFIYldnUjlOZlIx?=
 =?utf-8?B?aFRxVlVqSkIvK1g1MHdzWDk4K1lxS0lHcEdZNTRiaGk0R3J2bGlHV1NPMlp1?=
 =?utf-8?B?RGlLWVJuOUNqU25KREI1TmNjeXBjeFJQbjdaQVdadUhJbzJPWlo3Y25iOUp5?=
 =?utf-8?B?K2FhVGpFZTh5OXJpbHNZTXdOQnRvRVNIbWl3ZjhTQ0J6M3VxZkZLanRwNzVs?=
 =?utf-8?Q?yhV45iMNftpsxAyfYUWOdzZuyrsCQSqB?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2F6dEpDM1RUMnkwWlRsai82QXljN2ZheEw0Y0dvMWNINjZ4ejBvTnE3cEtD?=
 =?utf-8?B?ckJ1TjI1L0Q5RnFkVFFSSFlmeFRzRGU4ZTVzZWJEMUkwbGN4bzN2OXRRQVhq?=
 =?utf-8?B?Qjh2R0FVUXRmRWFMclZzU2JJYzIxQVp1bmQ5czhrRTFFVTFGbkQyZkpCS0Ju?=
 =?utf-8?B?SjdzNFJVOXR3WFVYWkozcUdJYzFTNUZWMU10eEhNTHE5ZjAzaWh1ay9jMHpw?=
 =?utf-8?B?anZsRlZiakcxcVQxYkFjTFZsUWZnWjVCcEFzSkdEQ2I5QWJxN1pRcURHRjRP?=
 =?utf-8?B?UkZyWlFJc1pMM1RyME5BR0Q1amxuclZ2eG1lUlNUS0lFNmJmaTBsc1BKVG9q?=
 =?utf-8?B?UVZtajZJb0JnT2x3NHlHRmxyYWQzb2I2NEQrbEx1ekJ2bnhwZTBQMHVQYUZy?=
 =?utf-8?B?UnBVbXRoTjgwc2lpNkNYNytZc05IV0ZPQ0FwU0lYZStMVis4SWpDNk5ZNzI4?=
 =?utf-8?B?NS82anZiNzBZaVVrVUM0SmRzcTF3d1Q3ZnBldWh2VTZQYmxqTVRJeW5PTTJo?=
 =?utf-8?B?WUMwcFN1VE9LNy8vdjhNOW9sNnk2VmlpeHBid3Y2NGFBZzFwakUzaEhaV0E2?=
 =?utf-8?B?VGRyOC9Qd1drMnpwTlB3Wis2bmxaTlM4a3QwQzR5cmVzZUpxU2kyd3Zmb1V6?=
 =?utf-8?B?ZTB5QkY3aTVsMWs2Y2lrYkZHVmc4dVFlSXFsNEhxMG5mUDJRSWxwb1JBb3l3?=
 =?utf-8?B?azNkZVo5NXpYcEZaOGVzOWdPNmE2alYrWWFTd2pUTERkekpQdHBCcUlyVUxP?=
 =?utf-8?B?UVFzYUU1RS8vVm1tOEVaZUNzQ0dzMUU0ZmwzNTJlYnNZbHZVZHpxQmQ1S3FZ?=
 =?utf-8?B?OC9EbjdJSkwwZXdHQXZuWnlKVlhzMUI5VjhPQWFNZXduYjBRMFhmQ1ZmTUVN?=
 =?utf-8?B?YjZXdVlndWhYRXNyVTRHajBlQ21aMm1rMUZxM1hMbDdoS0pqS1ZQVFA5VWJt?=
 =?utf-8?B?bFdUSDd0cUw5Yzk0NUhjNWpTTDBDcjVCUitNWEZFSStDbjdnR3JEeFJoa3po?=
 =?utf-8?B?L1MyS0F6ZnVScG9vNzVnT0hBUWxOS0xRYkVtbkZVRFpRTGc3clJTdlQzSHlQ?=
 =?utf-8?B?YmVoTHBxY2p5eHV0dEFFZlJjS0ZxZUZZdko2SXRQMXhydmpVcHpjQkRZZjY5?=
 =?utf-8?B?NURLQVM0aTh1OXlMcjBTSnN1RGE2c2UvLzd6aEdRVGRNeWRKM2xRam53dWVC?=
 =?utf-8?B?cFFIYWVwTEdwZ2FDUG9sM2Nvb1Z4ZklzMzEyVjN0UkhlM0ROU0t5NlNzNGhu?=
 =?utf-8?B?dlh2V0t3SHhhczNvNUdUM3p2Tko3TG9KR3lpRjZjZjdsMVpGTmkwUlFEWmtn?=
 =?utf-8?B?S04zZ2ZOa1RwUDVja0NWLzMwUlRVZlgyWkJDYm1naFp4NVNLS3NDWFd2SnBu?=
 =?utf-8?B?Z1c4M09GQ3d3anFsaEk1Mk52ODFHVlgzRFFEV2laZXVPTWlpMzJ2Z1BQeVpy?=
 =?utf-8?B?eElvUVF5VFRkNlVYNTAwRnZLYXhEeGFHTnRlSENhbmtHNXBMc1pxckY1b3Qz?=
 =?utf-8?B?dXhKeGIrZGhsS0tudys0YmRoWHN1RGpZNGNSZmhMSWdxZ0FhcjI0RnQ1bk50?=
 =?utf-8?B?ZFpBRFdzaUdZZEI1Q1ZHOGxxMVRuRTgzM2ZKWTVvZThrSWI2dU8xTG95aGVS?=
 =?utf-8?B?TlJPLzRrOEtBZTEyWnpzOFdScTFaV2VmaVU4eFkwTW44RkZocHhtTVBPckwx?=
 =?utf-8?B?aFpteDRrNTc4L09waU1WZW82dFZ6b0xUdzcrbzV3TStXVTl0dmtBS2xPa2sz?=
 =?utf-8?B?RzNEZDliZ3g4RlZ5Z0lJZlUzRVpuTkFVVDBDSGJUcVRoVTd0bVJEWm1zYWtW?=
 =?utf-8?B?VWZSMUZWTUJKNzQ3QkpPaVUwNVRnbUt6Z04vQzlWOEVSK1BxUUVTTWdyZElJ?=
 =?utf-8?B?b2VKNVdVUWxZWUIvaEN3UjFZczNvZFFkWWZac2ZoZU1xVmVvZEZ5WWp0Y242?=
 =?utf-8?B?eE9YMzJ0NHd2UU96dlBiU05ZdTBpKzZBMHl0cUdPVGlmVWlGUFp5UnFwSnZu?=
 =?utf-8?B?RW13NXpSdEFXdWFGS2oydURXRFFYTjRMTkwvTzYwSzkyb0VYbG5CRUk5eUx4?=
 =?utf-8?B?UitDbHlTTHlsZ2JkNDRJbFZmek9KanlaSlZyZnMxK3hrUDBmdEgwT1dyejFJ?=
 =?utf-8?Q?CGPknxx0/JAiwfFhWGJ1KMfnK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fCS2aQeB0a8c1daAr5qBwv3PuBPCqZZ75hkehSdgWrHHpBPXXcvK+pel+DUKPKKdObO1Y7dnKzUKE4IgHI6gYMDTC1BLh0vMc74XkFjwUNCKBWqvYwiTFLMuOoOiOCrfMxCEpVkdgeBvRI/tvtZlx0+5+EjCBgS+fBiPFr/LHp9FHx7JuRWyPAwtvtblC6sOWov16tncn5pjXI8SPKz1wETsg0do1UVUhReLHKvJYLsHtkNiajEI+FpTeG8hEJeYZ0/Gx47A+CMuVuJ4YSdFG9zxAcsD9mmnLPxnhDpBpkmxzpAGBffZF50Mj9zD7KntlXmjpqSp5LTlu55vLHuyI2lcpcdzQTzo0oE04uW8JiDX9xIu21fwejsOVfyYg1KRT0TaDRSP+dSKFUjbtJPD+GE5D1KrVZnFYANqwFtVNr3SRGwADcCGEHGg2IOEhTSGHrEHj+1N/uRmm4c5dQtS8iB+AxYo8/j8fscC8Sb7LVVYZb3pzBYNOngB9tAHfw1tiR24F0HXjeUnHPxedVFam4N3hmAgn4GytvzZER5MP7rCMraVDc21kXtWGFuVqHVgAXHWDiUY8zhWSzUFunzppoSarrxABNX7HeTo2YVCN8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716598d8-0f89-40cb-f2b8-08de1b140388
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:03:10.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhiKXFD1z3mDIZklgctNdOmU9LdWH3vNbHDzQZEP4HkG+qPNDj22TG6NUrtM7pGjuawG4CFL/UN8pZ/mzbbBKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3NyBTYWx0ZWRfX/s3myvDGaOOB
 Y7xvq/nqW4ISKUxHE+WSZF2lVRoRNqLqKe3C83X0Ny1tVM7oQ5JkGr5fTIOf/33j8+OGSC3ysfV
 WJeMY5IqB14J/nsBRiIqXgACKJdFI7kQ4xrWZIy5U3mSYJdvSZ5pg+43zjgNEZW7M+k7l50ZWt3
 DQ+hAhcM2btcKFS8XQyx6YlSb60AlNpofeEaGNDQ8SlmLHwK9y7o6kG5OBf8+EZbl0nRndr0hiO
 5QIpUAeyvffn22PHx/s97gXPjmvStN9p/JPZ+NhxFJcgbVcWVP5b6oZ4dRb3VZOeGd9Ryo5BhD0
 aKEXwcoqwuRCUfbLfYLNOOvqAY7w97ZmZ2G3hei6ydXF8A90xvUiB1sDePQwKLTx/owXF0iVe1q
 ttKTaXUm8dYtYzAQG42IECmenK8UAA==
X-Authority-Analysis: v=2.4 cv=KJ5XzVFo c=1 sm=1 tr=0 ts=69090a83 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xGpqqjgziIH5yjan3qMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: x8KHj1kLUhIt_8ZoEQHEJ0f4PNTkYTQ1
X-Proofpoint-GUID: x8KHj1kLUhIt_8ZoEQHEJ0f4PNTkYTQ1


On 11/3/25 11:14 AM, Dai Ngo wrote:
>
> On 11/3/25 10:57 AM, Chuck Lever wrote:
>> On 11/3/25 1:50 PM, Dai Ngo wrote:
>>> On 11/3/25 6:16 AM, Chuck Lever wrote:
>>>> On 11/3/25 6:45 AM, Christoph Hellwig wrote:
>>>>> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>>>>>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>>>>>> to the layout recall, no fencing is needed.
>>>>> RFC 5661 specifies that error as:
>>>>>
>>>>>     The requester has attempted a retry of a Compound that it 
>>>>> previously
>>>>>     requested not be placed in the reply cache.
>>>>>
>>>>> which to me doesn't imply a positive action here.
>>>> Agreed, this status code seems like a loss of synchronization of 
>>>> session
>>>> state between the client and server, or an implementation bug. Ie, it
>>>> seems to mean that at the very least, session re-negotiation is 
>>>> needed,
>>>> at first blush. Should the server mark a callback channel FAULT, for
>>>> instance?
>>>>
>>>>
>>>>> But I'm not an
>>>>> expert at reply cache semantics, so I'll leave others to correct me.
>>>>> But please add a more detailed comment and commit log as this is
>>>>> completely unintuitive.
>>>> The session state and the state of the layout are at two different
>>>> and separate layers. Connect the dots to show that not fencing is
>>>> the correct action and will result in recovery of full backchannel
>>>> operation while maintaining the integrity of the file's content.
>>>>
>>>> So IMHO reviewers need this patch description to provide:
>>>>
>>>> - How this came up during your testing (and maybe a small reproducer)
>>>>
>>>> - An explanation of why leaving the client unfenced is appropriate
>>>>
>>>> - A discussion of what will happen when the server subsequently sends
>>>>     another operation on this session slot
>>> Here is the sequence of events that leads to 
>>> NFS4ERR_RETRY_UNCACHED_REP:
>>>
>>> 1. Server sends CB_LAYOUTRECALL with stateID seqid 2
>>> 2. Client replies NFS4ERR_NOMATCHING_LAYOUT
>>> 3. Server does not receive the reply due to hard hang - no server 
>>> thread
>>>     available to service the reply (I will post a fix for this problem)
>>> 4. Server RPC times out waiting for the reply, nfsd4_cb_sequence_done
>>>     is called with cb_seq_status == 1, nfsd4_mark_cb_fault is called
>>>     and the request is re-queued.
>>> 5. Client receives the same CB_LAYOUTRECALL with stateID seqid 2
>>>     again and this time client replies with NFS4ERR_RETRY_UNCACHED_REP.
>>>
>>> This process repeats forever from step 4.
>>>
>>> In this scenario, the server does not have a chance to service the 
>>> reply
>>> therefor nfsd4_cb_layout_done was not called so no fencing happens.
>>> However,
>>> if somehow a server thread becomes available and 
>>> nfsd4_cb_layout_done is
>>> called with NFS4ERR_RETRY_UNCACHED_REP error then the client is fenced.
>>> This stops the client from accessing the SCSI target for all layouts 
>>> which
>>> I think it's a bit harsh and unnecessary.
>>>
>>> This problem can be easily reproduced by running the git test.
>> The problem is step 3, above. NFS4ERR_RETRY_UNCACHED_REP is not a
>> fix for that,
>
> Agreed, as I said, I will post a separate fix for the hang.
>
>>   and I disagree that fencing is harsh, because
>> NFS4ERR_RETRY_UNCACHED_REP is supposed to be quite rare, and of course
>> there are other ways this error can happen.
>
> Yes, this error should be rare. But is fencing the client is a correct
> solution for it? IMHO, NFS4ERR_RETRY_UNCACHED_REP means the client has
> received and replied to the server, it just somehow the server did not
> see the reply due to many reasons. I think in this case we should just
> mark the back channel down and let the client recover it, instead of
> fencing the client.
>
>>
>> I don't understand the assessment that "the server does not have a
>> chance to service the reply". The server /sends/ replies. For the
>> backchannel, there should be an nfsd thread waiting for the reply...
>> unless I've misunderstood something.
>
> If all the server threads are waiting in __break_Lease then there is
> no available server thread to service the replies, or any incoming
> requests from the client. That's the hard hang problem that I mentioned
> above.

I can either (1) drop this patch and keep the existing behavior or
(2) mark the back channel down and let the recovery takes place.

What do you think?

-Dai


