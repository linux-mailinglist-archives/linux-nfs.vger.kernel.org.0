Return-Path: <linux-nfs+bounces-11753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369EAB8A4D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5C3A658D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08820A5D8;
	Thu, 15 May 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2TBVOEa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0BwCNn5g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450313E41A;
	Thu, 15 May 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321543; cv=fail; b=gXtNbapeUknRUD44QLsxLGKZ0RVqt7Jp0cFG2tVexBYjcQCcqYpv3Lj4HQEnZQs2cZBbgUVOK7kBJMX13e5lc+j47aoAAuTD8Bho/lgBwxbNlxTReKgG6myhhFP0bmYffPz0Eb/LbYVUqktXnk4YyEentNpuoZ4rpiYFZbaVBVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321543; c=relaxed/simple;
	bh=sEfHoOAabZhLLZczQpgaOr4hsbQPuBTw2yp4ydKgd70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvURMBiBrkj5KAqYuLF5Gd2eyW8C9zi9F3GmUAAfXA+y5vCyorEiSfaRj7wGM8L9O7zOSzowk/3gYva6/g9fYZFsKU01TCWp636CzgiuC4LXe97yVco75uoPHfYGARjzDX1mj+rj0aB9XL2ZiRVfdaVxSFZOQa4gr1WzfIt63Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2TBVOEa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0BwCNn5g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1vux006578;
	Thu, 15 May 2025 15:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C0X4R9ydekC7An45HLf4wMIoZrrpwt7FYf1E4vkbJt0=; b=
	W2TBVOEaWYFsOLimSKRcmK2qJ2ZfNzsvUBwrxrzA6b2yT0aqBg8B2smwjx8iSKU1
	5pSEjDp4HqpzBK2fKAHfw/os1pBdg82lZLHwI8Vd04v6y1a63JeonpftC0HPhKo3
	iHLTQa9/57+Lg6tj5SRLg2lmR5LiMP2N1iJ3swek3Bh7a9y0AD+UixxPlVI45KuM
	OoCjKLJvwT9PxbtxnIf5V7esgb92t71bDKCEnU20fILvaPI1o7uy3lH79LdrQuyp
	vkwnHkNCviqrVGuY3usWamHkXFeL132dLGoh9ucxAAHR3WygtBpBIvobGKmPBzF2
	/LB24Y+NDKzg2B+qA9b2pg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgv9c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:05:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEkVIT004060;
	Thu, 15 May 2025 15:05:26 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrme7bj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEzeMsHTAXDE+8i7UsmGDvmdRdwP5JX0HmsNoReyplRgQxDM3hmGtp2YpZcnWvNmfYEcLiq5mVUu8FB7BYNV0Bpr+MZiUb3gTg47ZUVkDJSYgG3Ig1IVcCKCGvm5jSvOJhmT3ki9GacEMsWCIV4UUN3yU9Skkw3vIo+5gq9aeg8CgB1jPB0bP2Y4kEIUrlkuvKH5Sp0oAfLys67jAA+Q7u75lOiky38RB7yjVAlrFksm0T8nd242PACnpmnUsLW5S+qfpFaZu5A3ad4itZjD0yOb+EJM2wjnGK3vSZVonLkiXpg1uHH8J6vHW/nBrDy0EVTP0ostT6MZj9DKkQ1MtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0X4R9ydekC7An45HLf4wMIoZrrpwt7FYf1E4vkbJt0=;
 b=YsmaZCyy7RnpN5t/wb60PlC8Y6ZNpUZOn62OFpEsfHmpOFFOuT2pKQHDwrRp4I1IkzLNnOCnuYAWqX/MHDvU/hbvytFGz9HlmfJbChM6oabMwyQTLz60f145PFc+387kuJRSBpxv7azBwUOFoYQUk6plzi68v709dEY4xJEpfWsvSX3nJyQLJ8OpYem1fGOCZjWjQt4k/xvWMLrnTIRoLTrOEzBTj9qj+eeO7vulchRe50WvV0NVPRWqsGSzsAZHMRpLRKK5nZZvR2+gLmH/I6X1OjGcE6uAM/Q8syeijp0Pfc74wDRf+xVWcyRLVKbRWxmNmtsr4mcHi6C5MHoNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0X4R9ydekC7An45HLf4wMIoZrrpwt7FYf1E4vkbJt0=;
 b=0BwCNn5g/mES80/5dk58AvxGsjRYbKPU2VdemglieKfQwt/CHv81+5i/pc31dLOD2eT/8IWtT5VUbzecu2QOryjpUkOMmzWc3Zyh6gsUp3ebF9mRTPzR+Da2tDukhASPHiOWhv9f3pwRo5XzDhpusQ87+i0hIx6Z5x8Mgys5sOo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6508.namprd10.prod.outlook.com (2603:10b6:510:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 15:05:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 15:05:23 +0000
Message-ID: <7014c4fa-fa99-45d4-9c3b-8bf3ff3f7b38@oracle.com>
Date: Thu, 15 May 2025 11:05:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: RPC-with-TLS client does not receive traffic
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
 <20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
 <62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1c9ad5-1d11-4d12-5708-08dd93c1eadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3RjZWJLdWRJcm1tZXVrSUR1TjI5aGp2UXpNdG41bWxHMjdpSk1BeEdEeGZq?=
 =?utf-8?B?NmI5aVlBL3VZWnNMeWs4MjlZdEVYOFZjclhsMVo3TkZlSUdWMHJvTkNWL21t?=
 =?utf-8?B?c1lTdlluMmFGK2s2MFdkeHNoY3FGMnp4c24wdmd3NWpCOSswLzRmbnV1TENl?=
 =?utf-8?B?WWNRMFo1L2lJd1Y2cVhmb055RjdtQkNydTFaL2kzMXd2bnh0VHlHSTQ4dWxQ?=
 =?utf-8?B?ZWpaZG9PNFhDRnd1ZHQxOW1tMlczRlNsQm5yMlBydE1yRzF6NXUrU0RGL20v?=
 =?utf-8?B?eTN2N29EUGJKMEc5bFA2MU9PNXRpamxYUDBpR0lQa0VSb0l4R2pTR2kxMWxO?=
 =?utf-8?B?dmtXMURZZ0pwako4OEZheTk2QWZLa1M3ZngvcEcrWlZVdnZNYVJPUXMveVRU?=
 =?utf-8?B?L3Ara0JnQTlSa2RFN25vQmdqQUVid1hPZXgwRVRJYnV5ZGVQY2t5Q2JGdnkz?=
 =?utf-8?B?VURIYnlVV3NVZG5wRzNLemhBbHk4eWxLb3FlWW1mRldXeWI4cG1RQW1FbnJM?=
 =?utf-8?B?MWlObGxUUTJBSWhRSjF4Njd5RERueWVqSEFHbkxMdjBvdE40WE13a1c3bEpK?=
 =?utf-8?B?aDlXWHJqSmdCU0c4cGhhcnFvUjFGL1dCM0E0a0pHblQyNEZUMUFFRjI4dy83?=
 =?utf-8?B?MGhiRG9Hb3FXTUQyV1h1QTJSbnZrL1UwR1dCaHoyWVNSWGNvc21IQVdRUk4z?=
 =?utf-8?B?eFgvTGFsNTdOUHM5ajNQc3Y0VFRiQ2tjU1RYcVk5REdDaUZ2N3NMcUY0SHVv?=
 =?utf-8?B?clpzcDlzQ3Z1Rm9scjR6VkI5bjcwbGFhWXQwZlM0bGtacHpVK2tidXN0YkdH?=
 =?utf-8?B?bms5L2x4ZmlCeFFBbTNOZGRBeGp1djBqckVpeExzMVQrZUJPODdzOFF4WXpp?=
 =?utf-8?B?dmZSNjlZaVVyVFZoWEE5RU9qUFJEU0pzMkxOMEVXZUtZcUNINVBNYlduK25u?=
 =?utf-8?B?MUx2OGR6enptTGx2eVo0akJMYlZZOUJlY3RCMmYzMjFnNFNHZm1jb2N2dzE3?=
 =?utf-8?B?c2FVN2xKUndPazBiVU56UFBXaDJ6LzdhM3NTNU81Y0xvbXpSV2ZSbWk5Y0dv?=
 =?utf-8?B?ZHJpdytuckZXQk0wbUxHSHNOWUg4SjcxTG5tTzQzODlXbG1MeFlOOGxkMVVa?=
 =?utf-8?B?K0t5QU9MT0o5NmJ4dHFkdTUyU1BNczJaSDR3elJYQUtCNXcwNHhHOXp6VmEw?=
 =?utf-8?B?UGdFTHNNeVZRSHM4a1ZDUXhSOUk0Qnd5c1Jrd2lJbDIrdld0TDdaS1h2V0lB?=
 =?utf-8?B?QUN2VFZqdXpFSU9XeGRVMXA2bStZb3UzcFd5QUFlRlhXZjgwb1ZVbTR1Mmhw?=
 =?utf-8?B?YnR1YWYxcHJ3TDJ2aE5WbS9rSDJwTm5iSWE4b0lvdDk2YS9QL1NuNXBDSVNE?=
 =?utf-8?B?RHQ1NHg1Nk9JbXozUnRvMFdzWHBKNjBmVEJ4V2JVbU9aZjJOSGVBRGFsejBx?=
 =?utf-8?B?UEwvWjRpOGt0QUdwMWdYVWQxUStmTFRKWFNZbklBNUlodHhzWmRHcmpsUS9O?=
 =?utf-8?B?ZDlPV1J3WTZ6MGwxRVNlTnYrTWRQREM1TWg0VDRtQmtHTGt1bmlXNHlmYkJv?=
 =?utf-8?B?UksySjV2ZXZvcHRTVkUyT0NKR21aUHZiaWp6aUJuY1k4blpYVkx4NTRHR254?=
 =?utf-8?B?aE5MN0k0M1dDTTBDTUEwdTR3TGJXaXBVMXVqUURVbWNkbmhQbmdGWDVrODh4?=
 =?utf-8?B?bE1nZDQvSTlEby9hTlhIQkFuT0RFamc3RWVxdXhMSEt4U2ZGRlRGbDdHLy96?=
 =?utf-8?B?c3lFekhjbXNpLzV0V2E1VE44NHkyK2wxSEo5VzJPUFJ6NzVGWTQzaEFIdHRC?=
 =?utf-8?B?MUgzaUZlNlpBS0o0SkR1MHhVYlBzK1VBck8wenB3OHJiTHV3c0txODZIWTcw?=
 =?utf-8?B?U3ltZnE1b1NiV3RLTEpjK2NtaFlhZkd4Y2FCTmMvb0lvNk4zUTErMG1YM25z?=
 =?utf-8?Q?T80CtX7wEM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE9IQTNEbmZJV0JjZVpMVXBzUEl6QUY0R0VmSW1DSlY2VDJncXdnZHVCS2Nw?=
 =?utf-8?B?aVVpYUhnZStkQTBUYXVnblpLSkZJMG9TRVBhRWpPRW5SaFZJeW5OdmtmbVdK?=
 =?utf-8?B?TmRUaEVDSFNUM0p4VHQveXVzQk5aUFFvNWVxaUdDbHdKS1ZGZE9jMHZ5V3FI?=
 =?utf-8?B?YUs0OUFMOUxoOE9zdEI0MEJmUTQwWmxHQ3BtallOMHF4ZDFCaW5scFBSVzFQ?=
 =?utf-8?B?N1ZCWnpIR010QkxpWXlJUXRmekxONHVnVDdrQmt3UUZwaEduVUEwWlV4SitW?=
 =?utf-8?B?eUpPRVhVZDk4c05teDEybVF6Mlc2QTBVenRnY09XVHZSTVN2T3JOTkFiWHhE?=
 =?utf-8?B?MndvbXRnbjNyODl6SVh6NCtmdUhoU0dsTTV2YXZwdHI3amc5aXplVjl3UHcy?=
 =?utf-8?B?UUMyL3Eyc3NXZ2JrUVdzOXplS1NTQkNNbUd6alRCZkRleDBJdm4xaStEUVJq?=
 =?utf-8?B?Y3FUKzlRb1FjbmVud1VMY3pDTGhRY3orRUZsVGJZV3dpSExUZkNvcStpUTY2?=
 =?utf-8?B?dGZiQjRCL09NZHZKQ1l5b2xLWTYyRVViS2ZoS3B4aHNYY0NSU0d6QzZ4dkpu?=
 =?utf-8?B?QzgyK2FmU040US9hWmdYdTBHamhEcjN1aFk3TFlsWmZYdFNzREx6NHlhdWpw?=
 =?utf-8?B?QjJZWEJoampXODBnYmFGYnBpczhpYVBvNlRDQ0pKK3NuTW04ZlNlSkRyWU5l?=
 =?utf-8?B?N054QVAxY0hpQWNqYXVNdGRUL2dUWDBzNW96b2pnaW9RWjBPNTRwZnM1b2RW?=
 =?utf-8?B?TEQvYVRNelhWQTFCQ1dmaGVxY0ZwMUpvb253NlBWWjBtSGtrelJQMmZ6Q1hJ?=
 =?utf-8?B?UmhDSzVQUEx0YTJYeWNzL1VEekdvd21Wbm1ERFJ4Z2VLblJBczBGY2ZwM1Bh?=
 =?utf-8?B?NTA0RzRKTTNNQzVTQUhPOXdNSlQ3NXREVVNiTG4xWjZicTVYb0Z2MTh1ckF3?=
 =?utf-8?B?bUY2QU40Sm9yZHJLUm0zVHVyUHU3VTFYYk1aVlBhMHhxWnZPQmVJaTF5cWl5?=
 =?utf-8?B?VTgzNFp3TFZ6ZkFZSVR1SVZuOTFEWnRPVlo4cVkvOG9QSzNHWElKc05hTlNL?=
 =?utf-8?B?ZmRSUXlmTUpZWlVxWjAzSFFCMzBkOTlVYUFIOGFIZk1OQWFxbVJoM29Eejds?=
 =?utf-8?B?ZFFhb2JyMmhrK0VyMDdPei9PSmlXM1Y4Rno0K0JPODdIdHZYeUpkM1c3ZWNy?=
 =?utf-8?B?cnpkcjdMQjZTdVo1VnVnYk0yd3F2aitleFFVdFh4ZDZUZzZZcEg2WHlzZmRN?=
 =?utf-8?B?VTQzemFyeGIwM1ErTmJrYkExUjhDLzZGR3JQdUR3cU9jUFhQSDkwRVpqNW9X?=
 =?utf-8?B?a1g5ZXk3c0dJTmlVVWdOekxMVExCdTR6NklmNDU0aURiajRkenBpdERCaTgz?=
 =?utf-8?B?azVWYXY3RmlkcmZ5dlF1aHpaVnBVcmdnOG90ajRSSk9XOUh4ODdIQWxlNzJo?=
 =?utf-8?B?NjVOVzN3M00rVnEzKzIrNVd3c2hXek4zcE13U0k1WVd2d3hVNW9aUTBtSFpx?=
 =?utf-8?B?Y2RnbmtrdDVGMmVqZ1Q4QmZubzFuZFNNSlpLMjBuUk5DdFg0NEM2WjlIdWg5?=
 =?utf-8?B?ODNNTzAvTGNoUzhjK3h1VDBZc1pHVldlV2FoR0c3REl2WHBGR0lhQ08yMkZm?=
 =?utf-8?B?OGE3MUhuNU1wdWVlWU9qMUdpMkFVaW4wTUFTT1RMeDNoVkZHMnRMV0EwUVFi?=
 =?utf-8?B?TXljL2xVbTQ3OHJMTDkvTG5qcmd0WmNTeFpKSTY0WXZQMzI2NEhvcUlOeGw1?=
 =?utf-8?B?ZWlvTVRFK1lTMHovZ0ptYnJ3VXJwYlVFVW9MdDRERWthTWY4blZ4VkpselQ4?=
 =?utf-8?B?N3Q2c09DZFZwdEN1S2Q5dEk2elpaNXlFS2dxTkppRU5aUVNSak9pL1JQV1FE?=
 =?utf-8?B?WGkyd0xvb2FhMktFVi8rYUQ0a2FJUFduWFY2WGhCYnVlbGVud0FZSlVTOER0?=
 =?utf-8?B?Rk5wME9udWlYZUd0cUlROXBvb1ZwMDRFUU5KOWNyRVFseXpLbXBzd1djZnVz?=
 =?utf-8?B?N1ZHNzF6cnhQWUI4bzZ3aHMzUTVoeFJZbU5hVDJPVzcxTDFDeXpJQU5FSWNN?=
 =?utf-8?B?K2pOY2x4V1FnK0ZlcVF4K2loVXJiazNLbk9pd3BDNVFoUzVWVzd0NmJuSURT?=
 =?utf-8?B?OElWQ0JEb2NsYTQwWVltQitwMFZ0L1pUNlEzL1BYL3dhbVhlTEVGcDBSNEk1?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uNDLJMTGHWaQdcy+qnVDas39Q6Ck4C96KDXWctEX7VVr6x4mbx+yQq763DIn+bMGbql3liTNWJL/895LjgZqPZzjEVqDwXq7WVTO54fN1P3pISuq3bEXKXOenTI57mag2CsHTMNB6lKi0hT+KLWqyJK6kq7VsGn3apgdlM8FZDdipZdQ6I4KBFvG08eFWRTRuNhDXVFoBAz5hi8K2u6s1C4kkMy/GBSiug4b2sICcN9mwGfvM4bqMLYssRyP9ezUF6pCIjXMntNnS/tMYL8Nm79nNqciV0QuOPcy7VAY7c0psCYSwdi0Q1zAOgyExPz8y0PZ9VMyG5lP5nfGNoRGjapfAJynpUTQyXskDoujwAUWaP51OjalyEHgG7BG2sVXSFlGTnBJ/M2rBoqB0GqY+crzl1bfPLBpRnvGZSy5vbHpJebA+NdD1nLWoQ2rzBmgKdpp7cAYq11R4XSZNwmdGUc/DskAjdGW1b0dwQLUz9fIlmszYUcWfTAhEhly1mLH8xJA3W4CHS0tDmhTDE866FnJYxbmDS2OVBG2yDt2CeR6b66Pg+NcU+K8vimDNmgSCnGemcTo0stdPoPSdMo4e3SfDNwKbO77PW8oLZ8jqSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1c9ad5-1d11-4d12-5708-08dd93c1eadb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:05:23.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrx6dcJji5+fj3kTQHcmwMND6w2Vv5X5RLDUPPRkEViddKVJIh4NT3uoYzeEmJo5frCxHt2WXcnpT0KqPXlQgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0OSBTYWx0ZWRfXzdDR0oaCaC66 OqgfZANn2LuFQnfflAcdFz6ASP3n0GziVeV6ww+78W3RH2lT/LiAE41TVCkg0m9NDq9JjFuIfhW 9o8ikkNNBmECKecQnoLx9iO1puma4tM0Yq308sBXwrKheG1o/r579q5xcUqtEePhEm9MdsVe5/d
 l50Gg+yY0MvOip/OBoiuUAkxRXSr2+0KDU5VQGLIWq3OSbpv04zofihxgk8oJUtsjmhMG5FfT2x aXquZGDung1T7rCkt1Up3W1liL4UYtKTZv/xpGEtUMko65zC5MHv2oerF0TjpQPD0kQmbZ3uAtO pBWkwPDPtbL1oPFvd7auwiFxOPkg6kFtXNmcxMYJbkqAI0YZA00Lu/HGrppgXFF0p09ExpOrdfi
 nyHau7mMK9m/udbtnaxRrNsRoU40LnTR3SsS7pgGnmkSUCKBpkfaA44BabnURpfFdIK3i2Xl
X-Proofpoint-GUID: wJ6U4xMp1ICQlEWy2n51IX7nCxxn3vu-
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=682602b7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=eri4iMpfuOfFdkAngLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wJ6U4xMp1ICQlEWy2n51IX7nCxxn3vu-

On 5/15/25 11:02 AM, Hannes Reinecke wrote:
> On 5/15/25 16:44, Chuck Lever wrote:
>> Resending with linux-nfs and kernel-tls-handshake on Cc
>>
>>
>> On 5/15/25 10:35 AM, Chuck Lever wrote:
>>> Hi -
>>>
>>> I'm troubleshooting an issue where, after a successful handshake, the
>>> kernel TLS socket's data_ready callback is never invoked. I'm able to
>>> reproduce this 100% on an Atom-based system with a Realtek Ethernet
>>> device. But on many other systems, the problem is intermittent or not
>>> reproducible.
>>>
>>> The problem seems to be that strp->msg_ready is already set when
>>> tls_data_ready is called, and that prevents any further processing. I
>>> see that msg_ready is set when the handshake daemon sets the ktls
>>> security parameters, and is then never cleared.
>>>
>>> function:             tls_setsockopt
>>> function:                do_tls_setsockopt_conf
>>> function:                   tls_set_device_offload_rx
>>> function:                   tls_set_sw_offload
>>> function:                      init_prot_info
>>> function:                      tls_strp_init
>>> function:                   tls_sw_strparser_arm
>>> function:                   tls_strp_check_rcv
>>> function:                      tls_strp_read_sock
>>> function:                         tls_strp_load_anchor_with_queue
>>> function:                         tls_rx_msg_size
>>> function:                            tls_device_rx_resync_new_rec
>>> function:                         tls_rx_msg_ready
>>>
>>> For a working system (a VMware guest using a VMXNet device), setsockopt
>>> leaves msg_ready set to zero:
>>>
>>> function:             tls_setsockopt
>>> function:                do_tls_setsockopt_conf
>>> function:                   tls_set_device_offload_rx
>>> function:                   tls_set_sw_offload
>>> function:                      init_prot_info
>>> function:                      tls_strp_init
>>> function:                   tls_sw_strparser_arm
>>> function:                   tls_strp_check_rcv
>>>
>>> The first tls_data_ready call then handles the waiting ingress data as
>>> expected.
>>>
>>> Any advice is appreciated.
>>>
>>
> I _think_ you are expected to set the callbacks prior to do the tls
> handshake upcall (at least, that's what I'm doing).
> It's not that you can (nor should) receive anything on the socket
> while the handshake is active.
> If it fails you can always reset them to the original callbacks.

It looks to me like the socket callbacks are set up correctly. If I
apply a patch to remove the msg_ready optimization from tls_data_ready,
everything works as expected.

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 77e33e1e340e..0440391dc476 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -537,7 +537,7 @@ static int tls_strp_read_sock(struct tls_strparser
*strp)

 void tls_strp_check_rcv(struct tls_strparser *strp)
 {
-       if (unlikely(strp->stopped) || strp->msg_ready)
+       if (unlikely(strp->stopped))
                return;

        if (tls_strp_read_sock(strp) == -ENOMEM)


-- 
Chuck Lever

