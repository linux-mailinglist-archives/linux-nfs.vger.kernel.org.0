Return-Path: <linux-nfs+bounces-11850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58198ABF677
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 15:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A976C3A4D52
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CB270ED8;
	Wed, 21 May 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJJLY9MY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QDqFaB3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A52609E7
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835047; cv=fail; b=sb+o0ipZm7VD8TomcQbbf+yUxlVKoTqck03WtWkaXASgdUN1Mo7Ml/mp2FjFmH68oDNBPNSNDv3mPa/Q5r5Fo3YYaUFXcW47m/MXWFO3Craorm1Qou2FhOWwKcUkaYxNb5lC30aOpW/koOELcawdhqeBUL82BsPE7xWns78EW20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835047; c=relaxed/simple;
	bh=Bcn1IXLsEbqCf9b25fejfxWfEi9JQVdEGmDGNoKdOxE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWO7EHS5RAjup5IzPPofoX164gqPBGrmL3UdggGlOVDWZHPVoVNYAZLSImgV4x4mzryxtiGdcnflxPKIYkPbC8TOqnxMS7W9eebB/6afpfePDwP0uXMQCchG8bbyykPbAcKy8GnvHi0/9zujXlW/MBQRt8OGqD7aFoYxm/FlxYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJJLY9MY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QDqFaB3k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCqKku017747;
	Wed, 21 May 2025 13:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lSiKp7X//0u9xWtulkXyIVe7MYzZiqZibhBn2F1hllw=; b=
	JJJLY9MYED+Vwy2hIn+R5sJmdZvlzWBQGEJiBjo0sCwjae9LVgvJUgdLUE4DdgGp
	9OOChcPpHPOyO5j32mJi5IAX4clCdgAvBd61uUSXmqRVDvieFJ3scZge6Ok8kNAA
	EtMqGuItw4XiFy+h5HyfL2cqbXVnGE7BeE9wW5L1K9US1oQvyUa6mVwDBHAe9oDq
	AVgEY+IidbvaDapEU/Fc36aRWTMvqdXuYxhgJTi15rKoAq4v/kYp7XXWdEG2Kt/u
	kFm/XkYjyl5mQi9Ge3lu7SoN1DvheBUhi1GYx56Qr7NAJ2gNoB745jLvyop/d4P+
	adpmJ1y2aR34emp6EAfAog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sf7c851e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:44:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCMEuq032128;
	Wed, 21 May 2025 13:44:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwemcftm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yr6U8mcEhso72lYASoYvrs5PqymElRdDO91c+IDav+859D8/NvWdEibr+7ZEseavOlCDsN4OeU0PYTbbiFAIOct6J/juZJIdyLM2gbeQbdGZy5d4lp0KjqwqMhBID9ib/x1Jb5d6Ci02J+Ft1nhbov3XC7VVOPUIRjJj4fazi1ZVUPmi85VWkRsEHWaL44JAGWV19mWIVQAFNZm4+KBNEQGnzFIxJrjt6yb/9DdLHMENSxU0hmVfOfnDulCp8gEZIEd1x3i+86iuyuJJOSj5Vi4EhI2GSv7968CsCW2juz/dVcnYeRZevgOOWyaiadxIaJTO/YhXltJvICZa/VvSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSiKp7X//0u9xWtulkXyIVe7MYzZiqZibhBn2F1hllw=;
 b=l23ASePDnOEgQkMEWZl3j8ZCnRdOc7IWKSvkzRo/DpwGHLhx3PRqz/6PFRJmPV+081RhrgEyiR9/Z8kk3NK9opNJCWfT3sCMKqRqwf00lZLoFjLwFssA2ePX0gNnlxWDqZ3+B8uaLUa5utF9G4SNxBuk9t8hzkdQxRuyIZxiA9eAH+mtCRasxURnuap5cEocOJFr2a/DfcVPiGYo2/APuSAEBMH21GBDs0iXtm6/F9JBRxXAThOsLyt5blPFHY7vxXDVGd6NFq0KMWgtibTwN8icZbNbSAMFWLGYuzSVcNEtsiClztwdkPk6PI6a5Pg880zNlI6oV1Q4Ve74AuleeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSiKp7X//0u9xWtulkXyIVe7MYzZiqZibhBn2F1hllw=;
 b=QDqFaB3kxn4+GDL0e7EQYoTK9583+dbTAU7EfWZwxrvmkeUBIwh/XbMra7MJaedmRNuVsy8g3m/6lldwfiNxVaSv4QkwBTqppakoIuLYTQ7pLHqZlXXLBq26zou5FURT/w59UYhcVCqzY6KT8wZU2AWPEW4tDxqmGFGGBn5kc6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF40B0653BC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 13:43:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 13:43:57 +0000
Message-ID: <32ade44d-78ef-48b6-9222-57422a944af9@oracle.com>
Date: Wed, 21 May 2025 09:43:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
From: Chuck Lever <chuck.lever@oracle.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <CAHnbEGJJ0YJzyd525e4q6viwXXntz58C5iAGE-RQ2m87175CmQ@mail.gmail.com>
 <377b9fc2-98f2-4a00-97ea-e1eb4b4d8723@oracle.com>
Content-Language: en-US
In-Reply-To: <377b9fc2-98f2-4a00-97ea-e1eb4b4d8723@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:610:4f::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF40B0653BC:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a106d1-0323-44d0-a77f-08dd986d88a6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MERBRjJKTTRsY1pnTWdlM0R2aURmemkrbW5Sb1Qyb29NeGRDbFF2MDhqdmZT?=
 =?utf-8?B?T0pCdmpLQUx1aGtsMlBFZE5WNkZnak1uaWUrRVFOU3g1K2hROHd5NWJZakVj?=
 =?utf-8?B?YzBrci9IV3p3M2FZT0FOSEtKcm1JK2t3aC9hY3Y1Vkh5aUIxRm9hN3ZzYnU5?=
 =?utf-8?B?aUNVZmhmYUhleUZJbGdacUFsWFZ6dlRkQUNWNkdtVUgxampXVHpGVCtxakU5?=
 =?utf-8?B?Y1BsUllIbHZYRUZSL0JNYWF5eE1HT1JJL2dUaXpCRG5vUVoyeTVnUEowM1dk?=
 =?utf-8?B?b1VDS3FTSnNxOEd3Um81YnZDclA2N2xxRDJXVlVDNVUzY2xOb0hPdnZoRTVq?=
 =?utf-8?B?S0ZpRHZkc2ZpdDQvbVVteEtnOVo3bEU4YVVtNlpuT013RVA4UkRxSXVGLzh2?=
 =?utf-8?B?SWJsWkx1Smo5THRiMFRMQy9tRzQ1VVdUS3N6VjlMV0Q3UDVFamtjc0kxd3o2?=
 =?utf-8?B?SGw3UVlMZTlKdXJpQWN5VnZ0Q2tjR2tVZ2N1dHdrS3N4bGdzMmVpZncvNS9C?=
 =?utf-8?B?ZFpzM0tqTWw2WWZLTXdzZFNITUk3S0x4c2hibkdKN1RHd0QyU3Z1bi9uRmZX?=
 =?utf-8?B?b0pUWW4zYm9tRTB5SUNpV3ZwM05FOExXWnF0SjBvYldCdDBjQTRGVW5hWnlJ?=
 =?utf-8?B?TmlmcllyVXdzSUdrQy9GcWFFaWN4UVYzbFpLT0FoVVc1RURkYjROUTY2S3Ru?=
 =?utf-8?B?QUpYdlhsWXkzY1RxQnJkUE9UZlp0cmdicUlKOGtVUzUyVnA1WVVTcTBveUZT?=
 =?utf-8?B?bVhyd0JYMUFYNjExdnFWOFFiNG5rbnFIaFd2ampIVGpMT2tmL08wbzV4a3Bk?=
 =?utf-8?B?RFh4Zmd4ekZlOTJCMFBGRHhhVTJjRWhRQ1JaM2NiaEFXOVJTK3NJTWtjdVgz?=
 =?utf-8?B?K3gwaldwSjRwTVBqRUpUbTJBVDYzWXBwT1BGSTA4d0EzcmxQN0dYM2UySFlQ?=
 =?utf-8?B?VWpZQ0pLVy9RdnB3NWd5amdpUitmYjdkOVVzaG9GWWhJbUcxMk9PcEg4QXhY?=
 =?utf-8?B?WlY5MHM4Qlo2V1lDMFZ0ZHcySVJSSm84UXlIRkF1N0JGaUpDVDFhTk94TThk?=
 =?utf-8?B?enZiRFJlWkdLcXc2NUZ6eW41YklkNTQyYi9VUjdsT3ZPbWJJdU43b1BFanlm?=
 =?utf-8?B?aDduWU9MWkJUbm9FZlEza1JyTWZPVEY4MjJGSEEvQlZCYXpqZGUyR2pycTEz?=
 =?utf-8?B?a0Nac0RsNUZQZGlGUG1FMWRlMVRGQnVvcGhJcE1SSktLZll3bjlHZVlFUzVN?=
 =?utf-8?B?eDJHZTdRS2FWalhZd01RdFVwNXY0T0xCRjllUzc2WjcxWVc0MTlJWGt1OEkx?=
 =?utf-8?B?REFVMHZoazhLVU12K1BXN2ZNcGRkalhZdGlJajdNdlk0N2VmaFlwYXVjd1Jm?=
 =?utf-8?B?UUdqWkRZTDJQRzRpMm1SMkpDdksvcmIrOENRSDJKSzJOL21nOU5YcVJqUktR?=
 =?utf-8?B?RHBkanBlcmtBYy9kVmcySk5yeUI5b00rRkNRdDhoNGlETTlNMmJOb2h5MlVO?=
 =?utf-8?B?d3l1TE43Z3pzYVZyNE4xN0NSanpYbWZKTUdXU0NlSWtvbWR6clNGZEtiVUNo?=
 =?utf-8?B?QW1Ca2Q4ZnpYY1JtWHZ3RVljQ2ExVTVXRHpMNDJBUmV4ZjFsRG1iU0VPL2kw?=
 =?utf-8?B?RmZodEN2am1tQ2hLM2JPVmpFNzhBcFhhR2VNc3BycHNwMVlBRGJ4dkNFYVQz?=
 =?utf-8?B?dkF1SDVqZzR0bk1QcEZ4bk5FTW9HNTZxR0M1QjJTV0kzdzNBUFd2Q2Jac2k5?=
 =?utf-8?B?YkkvZDI4UVRhMHU1UkhibGpGWnhPYjI1K0dLMEh2UkVUOEc3R1ZuWG5yK0I5?=
 =?utf-8?B?VysxOG1lSVVCU1hDTnBBV2JqY3dCTTdEV2YxU2diZHE1MVI1QXJQcE15bVlw?=
 =?utf-8?B?QzF2eDNpaXlRcTZVaTFDMVRsWFRMY2FYeFZWZFVHU3lpZ0JMeVlwOGxVZ2pq?=
 =?utf-8?Q?RaDZ64OGxXY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?LzFJaG5acTNSR29nekxCSDRtTTVWSldPUlM0alFqTWhMSjQ5WTc3UmZCQUhF?=
 =?utf-8?B?RkZnLzRVVmdGZUZEVVl2QTl5WHJUdWJ3SVZ6UW8wQVQrL1VOZkordVY1Zzh2?=
 =?utf-8?B?U0RKQzFEMkZFYnNOdHdaS1Z6cllOemprcElQZ1ZtVjZjTGVCTWh1c2hlQkda?=
 =?utf-8?B?eFZyWjVKQjVBb1p1M3VrR09RYmRCMXRkSUxXQUJ5L3Z4TTFKRy9YNWJGWlRD?=
 =?utf-8?B?dkxFTXNHaEk1U1BUa0hlSjMxOGpnQkRWdkVpRXNoSUNQZW51SE11cFlrVUJK?=
 =?utf-8?B?a1lVRWFuUTlWOEJhcjBydnI2T0RvS29PQnZKQVJpR0ZoUHJKZWFPVUV5NHJm?=
 =?utf-8?B?K2ljNW00NlR2bUljSUpkQlJ2Smc5MERhZGc1MG8wU2wyem9sT1NlcW1vV3da?=
 =?utf-8?B?a1Jvbnp4ZExmV1BhaGo3cXRvUTFpbkRjVmUwYnRSU3dFVHU5Vmt1Z05ybEFQ?=
 =?utf-8?B?dEMwV29iMUZieXBXaXNDVWdiUUdFN1VieExta3NIRXRqWDdaSXRPODNOSERh?=
 =?utf-8?B?VG8vNE1yYlhqYlhhZDBzYnpQbGh2RFZrVW41dm5IaFF3RVpGaWU5SkszQTVI?=
 =?utf-8?B?VUxtbFYyTjBMeFZvTFFvbDRDRmgwbnRuc3VtQldBYVZiUEM3dmQvUnl3dk01?=
 =?utf-8?B?YXlodUhSREhuT1R6ZjhsUlBscElRQ3NYeUpJdlpNQVlGa0JxZzBPb2pzVHF3?=
 =?utf-8?B?TTlaMnhsQ3puZXRsQURHaloraUJmbnE3bTNqK1YxUkR5WEx6RHdsdHJ5OXRL?=
 =?utf-8?B?eC80TFBTVldibERIa2lrL3BJV1VoR2RBMi9zWGg3Y2xXZ2lkNmtIdTFMMjBI?=
 =?utf-8?B?WUtCOWx1VmhaWHIyZHdpVTJNMGR2RzlmZWVFbUJ3VnA0dDZFLzFJMlhIL3VL?=
 =?utf-8?B?ZDJRb0pGd1dnbWhYTGdodGI2a1RtckNQSWs2NnJYTSs4ZEV6UzZRUFRtWC9q?=
 =?utf-8?B?cTlVQ3dWWWN0aUtDeHozcEtQM1F4Y1hoVEdVMC9UU01leVI2R1NyaU4yQkQz?=
 =?utf-8?B?VGlwWDd6UC9XUktYM1FxWmhuRU0xTWpRSFpVckZ1bDhVMlExU0ZiRVh5aUVu?=
 =?utf-8?B?SGlaQys0aDdlQVZZc2hUcUx1YkpuR2JJWGJyTzR4ZnRiT0hNZ001dmh4OXUr?=
 =?utf-8?B?VFVFNWhpWlJadHVIa1JlTmNzb2xrVElvZlc4aGRFMHFmbVNpOG1OTlpmRFBs?=
 =?utf-8?B?dUMwNlFBZzJLdVNxWlR2c2RVcEp1Zy9zcHNCMXpnYUpPbk13Q1o5TGpCNGpZ?=
 =?utf-8?B?aG0zczBlTXEwQWd1SVlXalEraEQ3NVVZMTZhRWJMYTVqa29TOFBqdHNyMWNL?=
 =?utf-8?B?SjVrcGJsK04zVjh6a2pDS1ptUXdjckJHOC9sckpRZWVHZklrSHpLL3dQRk1x?=
 =?utf-8?B?Q2xTeGZXZFVsdW9BejhCaUJNME5oTXBKQTUwaWhtTTZBTHc1MjVaM3hDdEFO?=
 =?utf-8?B?MThlK1FvTjNjV1RhKzErUU91S04xbG1WaFU1ZG9pbVBNaWkvTnBMWUZRTEJF?=
 =?utf-8?B?MUl3UzAxbk9tZnBoZXliZVJLVmpHMmMycVhxM0FlWWhOMG5PTkJLVTd2Z2Jm?=
 =?utf-8?B?M0NPemFNOHNWNGZIazVYM1R4N2JYQ0FjOTBMQlFaMWh1cEJ1MWtXaGFvSVBo?=
 =?utf-8?B?dG1JQXJpNkxXRWZtcGc3WmxUc3MrU1dwdm5Ya0dTY2JHenFNT3JtUXlvK1Js?=
 =?utf-8?B?cGRqdjB5MkdSQVNLTzFEcE5IdU9ZbkF2S3doMWJwL200VnNPcm1NVCtXclBL?=
 =?utf-8?B?OEtEckx5WG8rWWc0ZUhtQjZsdzBETHZyRmRQSXFjOTdWOWtPemNPb3A5RW1n?=
 =?utf-8?B?NFZHaUFVcGw5SCsxYTdDeDJZUWQ2dUtQeFMxbnV3TnQ0anJMWi9PaWtIWDhz?=
 =?utf-8?B?WmpnY3lwbHpSM3BNWVFUbDhTL2hHWjZDaEU0WGtQVXJ0Q0Q2VkNLYXR5b2xy?=
 =?utf-8?B?TU9YQ0VnelpiQUpGVHd3TFV3SkJCaDRxVmVJa005L2FrK3lobXp0bUNuMDQw?=
 =?utf-8?B?cjZhVjU4bE1pakh4cEk3U09XWjBJMElyVGFDQkp5MERtOC82MXk3MUFNYUV0?=
 =?utf-8?B?WjZHdjhKM3R6eXU2bTQ5eDUxNVdQM21teFpWS1UrQVNUTnJ0eC9kdzkwSkRq?=
 =?utf-8?Q?6oeAgtfd1SHj4pda6lF0ERdxH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B3RuZdQ1cGGDUeHbdyaIQ83ujVVipS/1s7/lr3d2sC74QCLyx/X1HKtlr6toUyiCcX2ufW/nKUTdsWr1PR2+Ia/v2zkEY2Dq20N1FMD2MZhijx+mqBUPCtBx7RUIEqbSmgKEvvh4xSuCFiPmLt8ficJQZY5+hR+jQ43GkNYD92oNiJKFMW5xHCF69snV9Q8i7IM90NKMDdozSPrL/6Dy3h4NAc95ugPhmLwWhen7ilhc+IlmeQIfWBrLU1s7CJGtYdZOBl20Dd8MexYy94Pa7QffChhx8IsrXVtnC4d8y6g+gwStWsvuj1s0ucMlnZSQdt/TC6UVqhyFDw47qh44K56r46Pcm6lW4qlINvuO4MiOlTXlivMeiNa6sd/aB4VR79dCY+EWOjiEGJgdEFB/zW5W20BUBiWDBRCkUN/qCAhfVQxxvTR66YICBizG7fkhidldiJdUVGkEb4yxLPDyaV8+2fHD3+vgiYrZU09bAAksqbcfWPRrp+ktQkxMr7XOmP38HiyNxsX3B/+5dFiIkiQp2j0xwHvXmjbKEXw9LNPVF1hrM5KcmuodVRZIztDSSrvLs1vNOsUHfgsoSEvN7Jn5eMrL6+7EPqXglswGpIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a106d1-0323-44d0-a77f-08dd986d88a6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:43:56.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FkP4sRL56kW9cZqWIIb7sD9yhK27b+UqsY6ALVuHpQVmJbx6JxyPDtCiXuufY4bWHw+Xqk6wRACC2UfQxFt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF40B0653BC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=841
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210133
X-Proofpoint-GUID: ZsaNaY3WW62cHn4wJXeS_ruXHbk5rZH3
X-Proofpoint-ORIG-GUID: ZsaNaY3WW62cHn4wJXeS_ruXHbk5rZH3
X-Authority-Analysis: v=2.4 cv=OZ2YDgTY c=1 sm=1 tr=0 ts=682dd8a2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vMwy5_3xJvVog5Hav9UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzMyBTYWx0ZWRfX8JVqJJYp4YJa G6oXzP8dhvvzV6ZqpmTGLxuOLRHOITieU4T1GTyMPRgSA1pYSGD+shUlRHvlZXuo3QCCJf2ohKZ nn1o4mL3GJI4oYwyQQs2lNCO28Vnm8aN2l0ch11/FXAXsYkMjsqiKpiZTdaPIjvK/titC+K146i
 Mwg+15et+Pt2vj2k24qQ09NT9DsHRNHx96zrDFnON7tlANs9PJ2C/cdb7V49PTsTa2T1YmNWYOI Qjf1Sr5SQLLn4qZyRGLGiljLc6PeYZWWUJ9r3MRnc8GS24E+lwo0/zy795OwXQK1hn2YieDpv+7 JU23i+c/o9dt9xFM3nD7WipXdnVCUZnmZ2suzIz1hUnYMiT3gJrT3dWjtvnDfobHWd7RaBO13lo
 ayhUbk2lqbR0BqBhBF7SZ9pIqkmXY1IpG3JRR2Y1r0mFGE2Rl8QIFmjF0IBWPX7SMZBbgSlC

On 5/21/25 9:14 AM, Chuck Lever wrote:
> On 5/21/25 5:06 AM, Sebastian Feld wrote:
>> On Tue, May 13, 2025 at 3:50 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> Back in the 80's someone thought it was a good idea to carve out a set
>>> of ports that only privileged users could use. When NFS was originally
>>> conceived, Sun made its server require that clients use low ports.
>>> Since Linux was following suit with Sun in those days, exportfs has
>>> always defaulted to requiring connections from low ports.
>>>
>>> These days, anyone can be root on their laptop, so limiting connections
>>> to low source ports is of little value.
>>>
>>> Make the default be "insecure" when creating exports.
>>
>> I made a poll webpage for our sysadmins about what they think about this change.
> 
> Who are "our sysadmins" and what did you do to compensate for various
> cognitive biases?
> 
> 
>> Out of 26 people allowed to vote 24 voted "BAD idea, keep the secure
>> option the default", and two didn't vote.
>>
>> So this is a change which is virtually 100% hated by the people
>> primarily affected by such a change.
> 
> I'm interested in understanding why changing the default behavior is a
> problem. Is explicitly adding the "secure" export option on the exports
> where it matters a heavy lift? If so, why?

To be clear: asking around is a sensible thing to do. However I'd like
to see more nuanced feedback than "BAD idea".


-- 
Chuck Lever

