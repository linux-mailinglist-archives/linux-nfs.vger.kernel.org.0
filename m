Return-Path: <linux-nfs+bounces-14794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B9BAAA0A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 23:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9883AD900
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947E254B18;
	Mon, 29 Sep 2025 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1TXckHZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QW9YZ0ZG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF60226CF1
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180503; cv=fail; b=O4YJFyWgUdtHEfW+UWL+YCMi7IXw+3YRcqBXL6g91OK+Z5zPWF/a/3PlIlNiHRzoJgfX50EPP5LrSGkKMMX3MlEEsDWKZ9P64zDnCWbThQSzeDhn8riL6Ab8vXzMIOeSOs3uupYCMjpPplF6DoU8gOI3j7mplyD53QXJwGsIWuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180503; c=relaxed/simple;
	bh=ZbPnAfYqX5sI6+1WbZJOlnWn77/WgaB4AAYPHOpbLbU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUhNTR24kFHSnra66ExRQot8ogJruGN/NZqlGPwsC0x1DWGdX3uI3oNoiT3d0uoySPZFSwiw1PVzlsz3HeIcOlPMkpZGPnWvq9y1FiycP8weBGpTx3g4PQuR9XJ5cLcRGzAk3nuYO7b1lvDlPZfZaLIt1sutulNuCLIo0bCjx30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1TXckHZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QW9YZ0ZG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TL9aJt014359;
	Mon, 29 Sep 2025 21:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ltyCawtWnr5Y8c4KiVYzPTMEwT0s7Gtbx0YLLDLzCWQ=; b=
	Z1TXckHZWF63A7Jt3SmbKTSgmkkRNdw6SRKQuOzhjyfr+adk8CeOUP+ejrR7W9ai
	NNorjK554IqnWLlMrEFGUM6N2fX8FS83z6QniT/Uka+kbKmhcqw8tcswcwo08bfM
	yds4Q/IyfcoU0V9KZg+BjUWv682t3gXN43LE2v2XPIl33ytF0GddC1h2Gbo6d36C
	P6prY10Md+V1fJx0BMVn8LbD29Tet6UOGqweUULuzPyeJaVQslxpBDtyAKZGwcVM
	7YiVR5XSHsDdojm9NMiBnDJaZVmy2+d4fGdhf7ol2G9K7tAsSKto1Q1qRl7G5bOd
	8zPsh9CKmJMD766o/lfnWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g1se006h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 21:14:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TK7XKl011828;
	Mon, 29 Sep 2025 21:14:57 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7fwdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 21:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxHHR/kaoMzYN17wjhsm0lBrNeNzkvM/PzIDN8eoVkRtQWUCsDNPL37rfC79FiDITj6Q0gMUYSwpyI7Iwvr+0ZJIfz8sMrImOC00pvNnrfLYkGBqpm+vg/z3GCOTq22wGtQmdQSCRwrRGNg9Ce4uPRXOINeumP2bpE2uyzx+9rUpTF/zwoXY3Gb+HZwkAiwPeaF/7SXc9hOkCphNwJb2OWjkc4ht0sQM3WbKf2R67kDsuFtLBCovq6u492QQkdmeaKrOpp5Xo7Znr/y63zTQ0VWalCcUBM3W8xbwLz7gw0LIfMxBUJ5f8YFsarvJj+gO4MDwzGwOEAAjsnmoledZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltyCawtWnr5Y8c4KiVYzPTMEwT0s7Gtbx0YLLDLzCWQ=;
 b=BAZKs3xKL5Whnw9oDObh2n4g4PLmUqrl+XzCBdMFlQVCOueBi0y5m1mqgboL/ahAQaZO875OBrPb2ak+F+mB0ydiha1XY7ga65M+RHhuJG9aNArlMf759a/s7ACHYWZbYBGLiZAMkfoO+/HOSGWvG1J04wD8RybaR0tIpwBgnmorm+28/sJLicQ0Zyhfw/nVy124TtbVp6GNlcS2YlGWhD30Dx9WFoa9Xs8oi3z2cWG1+5IMWROjxTV7K9tQEh4+5jD7JgwXtSNbhgZBvrDG2pg0HvYQIQzE+5+NX+Ug/4BKDeIFtzF+kJ85f+diC7lPWqeRSSJZ8z436Vc0mjsCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltyCawtWnr5Y8c4KiVYzPTMEwT0s7Gtbx0YLLDLzCWQ=;
 b=QW9YZ0ZGmO7iHeVl7F8aaZkkj4iMVdiff1EKhLsuHy5y8lOejrvcBPWkSKbfBsJdo8+P+34Z04I6+kJBrn+EoP5U2jtFoe7+e6rG6APiWmHS84AqINYI26BG0pYo4BJOi3g5Z+01E/0xypJlRe7WULVKTL6hKj29kegdAog+kUg=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 21:14:55 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 21:14:55 +0000
Message-ID: <d195b486-a351-4ff7-838e-47d97f9ac0a1@oracle.com>
Date: Mon, 29 Sep 2025 22:14:44 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] Add some tests for unsupported fattr4 attributes
To: Chuck Lever <cel@kernel.org>
References: <20250929201622.37884-1-cel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <20250929201622.37884-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SA2PR10MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb4e716-a32a-48c1-b211-08ddff9d3c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGk1UndjSEFadVByUktSblBHRitVS1I4NHFpME9Wa0tZdHh1WHdlUFNCLzQ4?=
 =?utf-8?B?c29PNUlKWVo1ck9PQVVCeFJTNUpJMU9aWHlqK3R1bHFNakduaUhCaE9BelRE?=
 =?utf-8?B?V1U1Q0xvQy9BUndpbFNoYi9XTmFkVWNtSklnb1JzelFWQ3NNaHd0VUVHd3Y2?=
 =?utf-8?B?VVdwVk5ISTNTRnlROUN4WElXc1hLVzZVclBSTmErUGp4MURJM3RCMHVxTGQ2?=
 =?utf-8?B?YmxMQy9zOWRUZi9DVloxMlM0QVIvOCtvWjBQRUFId3pWc3ZRZ1RaZDFUZjYr?=
 =?utf-8?B?SFBqTmdwVVNhZkMxZEc0ZFFtZHo4UGVna3hkaDA2QjhGZUhRRTAzRHRRcC81?=
 =?utf-8?B?Qi9RQzVZcndHeFZjQ1B2Mjg2RVZ5Q1pTbTI2R2lLWFRoK3RIWDViMk9vb2xL?=
 =?utf-8?B?NFR3RCthNy9EZkpTeWdUR0hLVXdYUk5FcVJqNHJjTGhEK3VkOFFVS0JKTGhU?=
 =?utf-8?B?d0RPVGNxbFN6M2RJYXQzT01Xc0pMSnJ2VXEzUFZYZnJWSSs2Z2lGT1V3SjlC?=
 =?utf-8?B?MXVaQ2dSYW1xcEtqYWIraC8zQTRuK1BXWFoxWTc3TWxQQkEyZlZaakZnb2F5?=
 =?utf-8?B?TGsza2JkaUtLZFpwa3B2cXFqTVIrMlB0VjlRbVVBTXVxaUhFVnBjYTc0ekZY?=
 =?utf-8?B?WVlSMzdpbDZCK3NDQkt2bDdseExEYUZUTDZwQ3NSNjZyZ1pFK1ROY2dnK2Qv?=
 =?utf-8?B?TTVjT000bEZkWUVzUHhQd0V2WmF1TFF1cXMzekc5bUplSlU3LzJiVjhUMlg1?=
 =?utf-8?B?RTFiZjZCdy9adm9xWkZGcXdkamVKcVVvYkIrdUVYWFYvMjU5dDUyQVhYVm9W?=
 =?utf-8?B?Y1YrNklyUG5OU09ZUkhZcU1XZnBPRDVjb1NQdlFqUXJPdWRucHlLNUhsODVx?=
 =?utf-8?B?S0J6MGtNYkJnVjJuTnFIVFhCWjJyMFFCV3lrTHBZWlUrTTZWdlk2WTlNdWNp?=
 =?utf-8?B?WE5QWGJzY1ZZYXV5NHppL1BjUElkZnpJcjkvdjZ5V0hya1NSSTFmL0FsMGMz?=
 =?utf-8?B?R2lmQzJtVzYxU0oxamRzT0lHQWxWcFJ5aXNxeDFPSUdOKzdmemY4YVh6a2Vn?=
 =?utf-8?B?Tk5SRkcyQkt6OUs2OVg4S09NZ1psRnlwdkFRYmEyZm9PU08xMWtSNGNzTmxP?=
 =?utf-8?B?WTVUcFJHd2RvV2t3a3k4aUlqNEl6aWFxL0liaVNMVVJJNnlNT3lPcEo0V1kv?=
 =?utf-8?B?QzFRVTJGQm02UnZZNDNkVml0U0w2SUNDZmhrbWE5TlptRU0vYmNwcU1nTGhl?=
 =?utf-8?B?VjBVUk95a1dSclR5NWRzdlArSHp3NWJOK1VsSlZRVGFRZGkreVNHM2taZXcv?=
 =?utf-8?B?c2lQL1JmMG9TemlKUytuNDZkTU5URi82Q1AxMzZ5a2ZiWGVHbWdDd0tXNnYv?=
 =?utf-8?B?TlBXSzlpKy96dHBRaXd1L1YrUXJHMXgrUWdjVzB0MUc3RFIyNVdYQy9mNDZU?=
 =?utf-8?B?ZUp0WkFnUjEza3R1M0VuZW5ndnV0Njg0UXIyajhySHFBT3NSa255WlNjSTBx?=
 =?utf-8?B?czVabWdkUXlteHRvTytFVEI1ckUzejdJRHVDQWNSM2NBdVdpZzFKSTQ4Umkx?=
 =?utf-8?B?RXR2cEJveGRsNEdhdE51WElaRC9nY1dHUlFxdlR5SXM3R3FKYlV1eGpnZ2Va?=
 =?utf-8?B?L2cwdFV3S1pjMHcxUWkyY1h4Yk5ZS2ZFeGFub2RVU0I0U29FS2VDLzVLVTRB?=
 =?utf-8?B?SWxRVUFhelFPQjNuSzhNbitUa2NXVng2VDhmYTdybG40UDN4RXYvYkpZMC82?=
 =?utf-8?B?ZFphMDlmYm5rYkRiam1TWWNFZU8rWWxiN2NJRGRDaWRlQitWU1dsT21pU1Vj?=
 =?utf-8?B?WUM4MFdrOThpcWxjckZLK3ZMd1NOYzMwWTBnaDVQVjQ2Qk1TUHY2eE9zQlRT?=
 =?utf-8?B?ekJoLzVkNWZ5aXZvTm1pR0xRalVVbzNVaDFDTjMxZHdvMVB3NUlrcUYxYVln?=
 =?utf-8?Q?fh1i0lvdJ+qJnxguXOFCnHGYuaIVvD5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eURxZnl5RW16UzJ4a3c3bytUYUtoMzMrZGpxNFRBSnV2Z1dudGNZNTdFUCtU?=
 =?utf-8?B?UEhtRTlqWXFnenJMdWNXUUlqWW9tNFZrTTZRalFKUGxWVlN3MmtIc3NvcEts?=
 =?utf-8?B?SCtSdGowcnUvVEZ1dUp1dmxMVE5FbjZUVEZmb0V4UEtodTdvc0F0NVlBR1BZ?=
 =?utf-8?B?N3ZqTEpZanl4Ri9nT3BZTG5XbzI3WXNQWit0bnI0S24wWXQwVmdXcE05a0po?=
 =?utf-8?B?ZkM1czQvbUxvR2dCb2NNV254aGFleHZlaE1GN2NXYVY5bENoZkppQXMyb21z?=
 =?utf-8?B?Z0lIZkNoWWhGeTVBZkdRTXFiVUpQZTNCNThTNVQwYi9QWXdTUlpsbHRFU2Rt?=
 =?utf-8?B?SThhd0x1VnhPQ3MrWTBxR0dhbHVQT2lLVUJoUHh5MzZwNFRqUUNuZkZRK0hB?=
 =?utf-8?B?N0FsMHlhUVA3TXE4STYxNTBTTE9LOCtnVDFWMDIreDBLRFhwWGNOdWJhOHZ6?=
 =?utf-8?B?TU5jRzFUdDduOHhESzRKbUR5cFY5Z21jWTkzc1VRWXhiSE5zbWVWZEx3NmRE?=
 =?utf-8?B?a2JXNmtXR0x0ZmIxRUJRRkZpUW51Q01TSjMzcThTQi9Ib0VsNlRnTVBFV0lm?=
 =?utf-8?B?NkxjelpqclhoUkp2ZUh3OXlqYlRkSDRUdDZmUDZQMmF6aGRGb0h2V2NuMzdC?=
 =?utf-8?B?WUFXekZBM2FCZVFpbG5neTNZRmpYQ1V6bHkwQWZsM0Zkdm82R1BSSHBUQldk?=
 =?utf-8?B?RlpieUdPLy9ud291Z2hlem5mU2VzTFVFdmU3R1QvSXU2RkM4WWh0bUwvRGI3?=
 =?utf-8?B?clJjN1dPRnU5YTVMa0FHK0Y3QkVMWmlheXYrRkx6V2E4OCtiMTV0d21oZXhl?=
 =?utf-8?B?Mjh6dnBTbUh2R0F0ZDcrWTZwYWZCTDJIRTdDaXE4VkVPY3dFQmJUR05iWlg4?=
 =?utf-8?B?dXFVYzVjOFBrSkVLUFl1bWp0ekhDdUhLU0trRjdscVlGclBha1JDSmtkaFVN?=
 =?utf-8?B?N2FVQXlDNDFzQndRWWNQaThxV2hxWVJyM0xrbUt0VVY5NkpuaWhCWlpWczBL?=
 =?utf-8?B?UXJsSkplYWEvOWZ0Ulc0T0tRTDNPdURUd2pZRWR1RUJOQUtTYXg5bGRBVzEx?=
 =?utf-8?B?Qy9SdFl1T1NjMFFYUlRlTXJ2N1pCOHAxSHk0bmczK2FNa0xrWlU3ZjUzdFhw?=
 =?utf-8?B?a1FvMUdOU01KM0EyMWJoeXdoWGtjUGVDQi9tMTluVmw4dlljNUdCaXhWMlJa?=
 =?utf-8?B?NUFoTTZnTTBFdyt6V2w5TkJwa3VWaDVzU1pwSmMxa2RJbDlxeno2SG40VGU0?=
 =?utf-8?B?YVBpekZqbkVMRGFabzNOeDBNTEV1aGFNaUg5NFgrTUozTlZsb0plUEpvOTVN?=
 =?utf-8?B?QlhHelVHVDd6MEZEZGJlNmxqZ0p5T2NPb2cwZ2ttSFVpY3o0Vm5OS09NRnNF?=
 =?utf-8?B?NURYQlRMS2c4OVNkU1JlSE1Cajg2RXYweDNLVy9iaDduY3I2cEQ1K1VpR2Zk?=
 =?utf-8?B?eGs4K2VTb3Q0V3dlSXR0MGlqTEdYcld3dlZ1aTE5VkhFYVNMV0xMRzJ2eW5n?=
 =?utf-8?B?ak8zem0vZktKeFNmZmJ2REQyK05uWDdKajhHNjBBSzQ2NzVJbzVBQ0d2TTdj?=
 =?utf-8?B?R3FDQVVlVmJDVFRSVXlXZGJ2dUpyODgzOE9La2VMSDg5ajVnWVFzeHhkOWh3?=
 =?utf-8?B?azh6bWdzVCtJdFJLYmxSeXZmOXZtZzl2V2dpdnE4QU4rWGkwZ0hkZWZUcGRE?=
 =?utf-8?B?REdHSXJ0RHRlVmNhbFdKOG93Z1orVUVyR05iekg2WTVMTS9VQ1JFU1g4Ymts?=
 =?utf-8?B?S0pvYmdaZENFTG5VNEwyVXg3d1hHWmNic1FpSEhnNW95a0U5NGN1c3NaTmJ1?=
 =?utf-8?B?S3h6RmUyeXArcHRvcXJXYlR2dUR6azJjRTVKVURWRHgvUXFXNnFUYnVhSzRM?=
 =?utf-8?B?N3pyTk1HNTRhN1hsUTJQK0tUWDgwNDM3b2JYa3UzWVhxb0R0cnUrRkFrMUZH?=
 =?utf-8?B?eGZ6RDY5NFZZbzRiZ2UxR0JkMTNBcEtoczJTYVdrUGozVFcwY3JPVXQ4OE1H?=
 =?utf-8?B?VkF6a0lFL0NLZGZZMmJDc2cxRktWRHdJSVNzWlJXR29Mc3pUeFltU0VWOERz?=
 =?utf-8?B?NjlXQ1gzZmxXWmJPNlZQT1kwNUpHMWNtTUg0Nmd5WksxYnpIVlpOZm5aT2tZ?=
 =?utf-8?B?Mi80VmxLZkxpekZoTUNSQkNrSFBRLzc2cFRScFJFWjJRNlNZTHFNMUNwYytw?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CCkJiUQj/O0Fjw2ytNGZTmBlG3GdMMz7V8EDTYtH13maC9EXFCLlgyd57IdLwkGzFy9gggSW0nxChzMlduhQPnT9Jti1NbR29xPowPxv58PT5DAb/sdtFJds2hS1f4q5KEhXLP98d0BKvKF1fXz1R7Q+Uft9tN+OXTNs0wuUHKauusflcBG4tOCwBW3RanKJgWcYsUnmrvYt5c/jYfdobEBjqdtEe9n7tPk15vA+FEMH51o7qtcmWP5yqdW/sqpnJluHVSMOjpnRtYOtNEWbmHec2zwicPTpQoNrx+pp8Ac1rIefOuFBZ1ICKGkyyQZeA8W2qplAFGh4JoTn/Q6bXno6ZJ/S0WVzVsCLOlo79VhoHpJ1kVrM/dMQO2JCOradbGCNDYotoDvm1jtbnk0dfMIwwbg6pX/hHYB92VIgAa7HmC2aghg/PbiZbfK4s/U0RZV9aOgS+yRTovULxJV5eWVHc83J+6l/j6EE96EBf3ev+ihoKvo2l1isnfq8kivahzd7pp+NNhXFVrSIbQSg/vBG6Q7FdbnqpzAQUXvkJaSfoQ5Bb7a787TWvn9Sb1vw025H6dHQOOPZW6Ho0VdQQFw3zrhUHHSTYcQgHAUfQ8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb4e716-a32a-48c1-b211-08ddff9d3c87
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 21:14:55.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TvMm0ZyYfSY12vsvkHi7dvkgtiivvozwNWiFgMW0POMIPL06jOkBnR28DlwBM/b677/F+QiD2VtasXcQ2rgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE5NyBTYWx0ZWRfX07AudH/y0gQ1
 2RkGU89bdEp33SXow7AqUEzJcvOU/lg8xdypw7Uq25Et47teUR0yxC7HdXLU47J1FKkPDTPM2v4
 8TaJk8L+PSroxR1mw/DHG+51gSV9Genp256rrODDjucPM8I3EL1eCPHusns9hs1GfXCPOYQplU2
 sZD8wkmzR3yJ2ktM+MRmcVwmDE3MFIo3/R9elT3l+/hJQoxr/1zOZUWaFe5/N/+rPCFi3u7MyOY
 c9T08SI2pp9fcbniPZeIZBeoG/SC/TM7a4+RNICIGIlbo1WT5kMeLxaeNkWNliq/1/6l2YSyohv
 RYmTRRNABiddV+YgE2Y1wyyy7ISttvN90w9CE6H/SSHvVDFEh5p46z2+Ah2BXvPkoZHFMYdB262
 lgwbvgkOkoBKBHDu757lMm+vAM3/zZ4pP0uG3NaSsJMhDDLeTOg=
X-Authority-Analysis: v=2.4 cv=Y8X1cxeN c=1 sm=1 tr=0 ts=68daf6d3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jLb8mNFs8flsJ_l_6W4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13622
X-Proofpoint-GUID: uSZHjxjTK_BZS8yP_qFk3J5UyLo03Bqe
X-Proofpoint-ORIG-GUID: uSZHjxjTK_BZS8yP_qFk3J5UyLo03Bqe

thanks Chuck,

I'm still catching up with pynfs patches; I'll get this (and the others 
queued up) in asap.

cheers,
c.


On 29/09/2025 9:16 pm, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Linux NFSD does not implement a handful of these NFSv4.0 fattr4
> attributes. Ensure that NFSD's fattr4 result encoder is correctly
> clearing the result mask and returning NFS4_OK.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   nfs4.0/servertests/st_getattr.py | 149 +++++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
> 
> diff --git a/nfs4.0/servertests/st_getattr.py b/nfs4.0/servertests/st_getattr.py
> index 1c47ebf60571..d423aa1df46d 100644
> --- a/nfs4.0/servertests/st_getattr.py
> +++ b/nfs4.0/servertests/st_getattr.py
> @@ -521,6 +521,155 @@ def testOwnerName(t, env):
>           t.fail_support("owner not a supported attribute")
>       # print(res.resarray[-1].obj_attributes)
>   
> +def testArchive(t, env):
> +    """GETATTR on "archive" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11a
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_ARCHIVE])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(archive)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("archive not a supported attribute")
> +
> +def testHidden(t, env):
> +    """GETATTR on "hidden" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11b
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_HIDDEN])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(hidden)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("hidden not a supported attribute")
> +
> +def testMimetype(t, env):
> +    """GETATTR on "mimetype" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11c
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_MIMETYPE])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(mimetype)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("mimetype not a supported attribute")
> +
> +def testQuotaAvailHard(t, env):
> +    """GETATTR on "quota avail hard" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11d
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_HARD])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_hard)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_avail_hard not a supported attribute")
> +
> +def testQuotaAvailSoft(t, env):
> +    """GETATTR on "quota avail soft" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11e
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_SOFT])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_soft)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_avail_soft not a supported attribute")
> +
> +def testQuotaUsed(t, env):
> +    """GETATTR on "quota used" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11f
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_QUOTA_USED])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_used)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_used not a supported attribute")
> +
> +def testSystem(t, env):
> +    """GETATTR on "system" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11g
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_SYSTEM])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(system)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("system not a supported attribute")
> +
> +def testTimeBackup(t, env):
> +    """GETATTR on "time backup" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11h
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_TIME_BACKUP])]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_backup)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_backup not a supported attribute")
> +
> +def testTimeAccessSet(t, env):
> +    """GETATTR on "time access set" attribute (write-only)
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11i
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_TIME_ACCESS_SET])]
> +    res = c.compound(ops)
> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_access_set)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_access_set not a supported attribute")
> +
> +def testTimeModifySet(t, env):
> +    """GETATTR on "time modify set" attribute (write-only)
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11j
> +    """
> +    c = env.c1
> +    ops = c.use_obj(env.opts.usefile)
> +    ops += [c.getattr([FATTR4_TIME_MODIFY_SET])]
> +    res = c.compound(ops)
> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_modify_set)")
> +    if res.status == NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_modify_set not a supported attribute")
>   
>   ####################################################
>   

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


