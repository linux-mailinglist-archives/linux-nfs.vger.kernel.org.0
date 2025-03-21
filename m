Return-Path: <linux-nfs+bounces-10744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A10A6BE34
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E697A7754
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76CF1D6DDD;
	Fri, 21 Mar 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyBwdpFq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZVLNiUcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E11DB12D
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570335; cv=fail; b=MRwsy+y7qo6JZcFZFmtECVm+UH+gONdrClraZJnZJJ488b7g5D/aBC3BSHjRGqG//O66Nrj38YHU6pwOiFPOb+bZtgXLYgaqnuGtdD+lt4OC7OpyHDbYIgI5xILXD3Y61xfyZUAiWLsgNU5f+Dm+iMZAfqpXWAc17xQBxlA+8zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570335; c=relaxed/simple;
	bh=Bp6eLhj0QfmZXcjqh7PSxVWbvlEK38aQNfBjGCsUnsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDbV05HSs6N+Pc1ZidUF9arBw5im3AVZRg2EefNgxmYnh4X5OVQ/3mWXeSutb1Lw51pJW84Tzbz1g7Avi2xEoL8ulV67maMeRnOb4BUhSxFB/wPDfCHFyZeevkRVVEvx43nf6lyGSTleLBz+lNZfpMGsQhs02nFJdPX/WR46PlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FyBwdpFq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZVLNiUcS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEC7cc024878;
	Fri, 21 Mar 2025 15:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tnw4iT89/E/PimliruOzR1EtjHBUc2t8YJ/0JHT4tvo=; b=
	FyBwdpFqvtc5wqlgbX0o1n6KEpg7TMUADU0KljuDcYnPYcLhHCo1gHerzSaTtBgQ
	HmsUzMXC3zaRa5Q4qz0ppbY5F7iVZQl6Pa43RDtgMdwRa0jRiDnD8Iw7r0byVi6u
	KyEnabMtx5FNxRSkZEfxOmVlVsW6MfCXnB8FGkP0Ae1KlUN7NUJcCDNw5BQI3nB+
	u6S0BMzjf9hsGnKQh77XjQWukdZ8Zy9CYzGC/WVez8bbA6byezWDigir0g6JYzOf
	Rd3mhhEd5toR1akjJtyMprlXMnAHNiz03oR/AwHNIxvuvl5io8rD4UG/Yx8sCZjB
	Ha6hVmkOujHCee9D5mEOzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbguju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:18:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LDmjsV009929;
	Fri, 21 Mar 2025 15:18:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm47q5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLN0T1ZM4DIQap6Y9jFF0scpfv5NTIWqwHZCBQltypIS0R9LFQ1Sw1rbpEKaQ88NB81vzUNN41zVPP8REHXT5/1/criGWPs9YFRuN0ICQQVI8Euk6sAHvb/WzW4o22oYaycGiCw442fY+XZF6gXoUH8qSCWUmqmWgpA1hqF4c8lMxwc9sxf0BX1iMJnZmnk3k5Y/k92yRRyNEZGqQOG0JNp02/iopAWE8UX2+sP03uoFscuo6M48gdkHznFRioUIT9FgHEkck0MsVxlo28o9ET4uc+iFg0YgkdAYrQxsSOhlr+UMvKkrKEtN+ftb0/t3fZh5N+fnvIIAz7goDdm4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnw4iT89/E/PimliruOzR1EtjHBUc2t8YJ/0JHT4tvo=;
 b=iPo69tVVUD/BFsZRy5zuX3iHRhk4hPDfqcNcJw7xwSDbItpUCvsGeefeNzQ9xlc8h7KooDaJ1540508AIgq5oUMNji+ybReOnqujGoe7tqhFZK4Wk3UlViBrPc0exFFw8hqlggBavEo4+zAe5csMgx/O2wZ+vHMZznOu3pyzQHMmouJxi01DYLE76C6tBLg1VDL2QOJJzEGpDvWqCvnMsUYynKgR+yeQsPNf1mUhkIrROJ0PbUEILoBl5JeO6FrvlWl0RKeSYlZo7wMD+Ve2yS62OFm6pFHGaEI4GsSfhMuNElI1pGS8qLLvo6/nM06ROfnmRFkt3k5oRIV+3Zob2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnw4iT89/E/PimliruOzR1EtjHBUc2t8YJ/0JHT4tvo=;
 b=ZVLNiUcSDXaM+gtdJaOkvPfmgYfFtxuwUz6TQyEJNgQNdLgyhNaaKVWVWrdTxugiu6bGY1aMKkHE1usIU/49QfjdkhiZp3k+bb38BAMVZvR5OfxrqHA+TK6p6g2k1d2SCZVRJIkGtZ0YV38Qweg7iMG3Y4wasRwrdnfEAM/ypWk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 15:18:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 15:18:41 +0000
Message-ID: <508ab008-866b-49b1-83cb-31d25de96f8c@oracle.com>
Date: Fri, 21 Mar 2025 11:18:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
 <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
 <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
 <4afafdfd5f7148cf8c9e0c9a65946726f29719e5.camel@kernel.org>
 <5ACD599A-44FA-41B0-AFDB-B8D352044387@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5ACD599A-44FA-41B0-AFDB-B8D352044387@redhat.com>
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
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: b20cc156-d920-42c4-4c03-08dd688ba9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmkxOTVZQjFlQWppL1dQeFoxQlJLaGc2VXdZOUJHL3JaYnhjRUFwdXo5Y0Fi?=
 =?utf-8?B?T09QR013SjViS29uNDlwV25yd1kzajh6UXFTNEd5aDB0MnBRbEttMHV4TTdk?=
 =?utf-8?B?eStMeCtBQUhTbFlaTThOV000RlVZZWZsUDhPaXRWbFJNbXoya0tNTzczcE9p?=
 =?utf-8?B?cHlLOGxPdzVhdTc0RitMbzI0Y2d6NFQzTm5FYWxPMHpwejRlOGUrdHFYRHUx?=
 =?utf-8?B?NVZOam5ZVVNtVEZBanNTUWxxRmFhbHBlSlZPYWZGWDMxK1EvcUhJZlBFUmVa?=
 =?utf-8?B?Y2hkZFI0ak9vZi9oREZEM2w3VXkxNmdNN1RhMGtFN0hvTjQyd0NLZ1RsV0dB?=
 =?utf-8?B?c1ZTRWF2WUhDZ0FnaFR6b3BQdE9LRW9mckZublB6dWtYdG8wNzhtbWE0YTJE?=
 =?utf-8?B?N3I1NzZvWklvcFdnc2M0a1BRTCs1U0JidTlIRGwzSm15YVRyQ012ZTdUQ0R5?=
 =?utf-8?B?WFoyUDdxNlVQYzNsaDk1UkxXbHF6ODJJQmo0YmlLRnFFSndIZEhUbU5uRXk5?=
 =?utf-8?B?aXhBZlRQZ0oyV3hPNld1ZjZYVGNMaHp1NEV6ci9ueTkyK1NKNzFiMUlVb2w0?=
 =?utf-8?B?MkZvSXVTVVNtVG5kTzVTdVRnVW9GVW45a1piZnZSTzdnZzJ3L2tZNUZIWGlx?=
 =?utf-8?B?VWRqalJFM0JYWFN4RGNVSDV5MkxMTFltTlNmQWJuS3FpRXZXMGpucnk5UnV5?=
 =?utf-8?B?QlV4L3FkWjA4dk5IOG5JSFN0Z2d1UktqaHhSYnhCNEsxcnFMdTFoMXVQM0Q5?=
 =?utf-8?B?aStDLy9NdWZ4QlJxRG8xKzNsTGxvSVg4OGhmUVd6R0l4WXFFRFQ4QllTR3Mw?=
 =?utf-8?B?QTZ6NkhBYm1CQm1FV2I4dWxzRWdmbVpESUdJSFlkbnVWNUE4MXhHT2dlQ3lY?=
 =?utf-8?B?Uk84M0dVc2tqV0lVaExTUVdxSGdIUEh4T3Z0dkFYVnpUT0xoWmJlOGdNQ0M3?=
 =?utf-8?B?N251QjhPZkJPYXNNdklBOURPaFFSbDM1ZDZ1M0M2WEVjdUFJM0JtS1MxL0ZZ?=
 =?utf-8?B?UUV1SHNKMkFycEVkdmY5OFpiZFlFZlJCM3pXcmdxckFQVlNiNERhK2hVWlI3?=
 =?utf-8?B?bldsYkt3RVdqMjM1eUtKaXIyTFBraWQ1YmhRL3daUW5iWHNoSlVjT2RSZjI0?=
 =?utf-8?B?Sm5TK3pKalVVMyszS05xczYvUEFqbUtVOVlUYzdBbWZNVXk5QnR5OU9wMmps?=
 =?utf-8?B?eDk1WEVTbWd3ZTJYKzh6THoyYlJvSkVqY2oycTNnc0g0QTlrbC9tY1BrZmo0?=
 =?utf-8?B?RXUyZFJ4clZmblhJREZmYy9JZ3daN241UGptWlhIQ3h6V004RzF2TWRxVVM5?=
 =?utf-8?B?a1VTRXdZdEZPeUE2ZXNSRXFFV0R3U0lPelU0TVBzbzhKbG1lWW91a0Z0Vy9j?=
 =?utf-8?B?WUNtV0NSRjhJbm1LMnNSendKUUhBWjFQVUJ6MmVWUVVvQTZ2VXRULzMwM2s0?=
 =?utf-8?B?a3NtcEt3SGp1THBpRlhmc1Y4Mk5JWnRFNDViM1RHZmVEU0k1clNGeGRIcXBY?=
 =?utf-8?B?eHFURGNTWk5mR29PdzUxMktyeEVuOExyaTZHOEQ0b1dBWVpOOTJzWXc3WlQw?=
 =?utf-8?B?NmdNTXdNYThKM21KM2tVUmJjZEJtOVpFT2h4Y1JGTE1jeUFvYnBKaGJXcTgw?=
 =?utf-8?B?N0ZoRGlhaU9SWDdFZjdteS84YzBOYmdWZ3Z3TFNOS0ZTb3E4RXhuR0tPc3Vy?=
 =?utf-8?B?L0QzbWtwdmtXMDE0UWpwdmJzWkdUVW1QYllsL2JVSXZRVmtrcHd5LzI3SzZI?=
 =?utf-8?B?d21lRHc5Y1NxVFIyZUQyWkxuTlg4TjJSWE4yNVVSb2paekk3Q29ZZEVNVlg5?=
 =?utf-8?B?eFQxWlRnRStZajdQRVJuK3ZKa1c4bXdiRXc1M215U3pqcUVISEU4TC9TUFVY?=
 =?utf-8?Q?kTPxvfa/R/YQO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdBaXJxMzBkRjVXeUg3NHRlSklvYU9JYVNpTEJBaHIvd1h4OG5PUDZzb1Bv?=
 =?utf-8?B?amRUdVFUd3VWS1M2SmVQUm1pZGpBTEp3YndCbGNkMEFJNHlYQ0hzTFprWnln?=
 =?utf-8?B?QmlUU3liblErOUVvZDB4Mk9zVzgrRDM4a0xtNGs3Z0tyVXBnNjdmdURDYjlZ?=
 =?utf-8?B?eWRGc3ZKNHZDTEdlU2dvRmhkemZ2Y3Voa3M2MkRCOGJxYjF3QVJnTmJtU2Fz?=
 =?utf-8?B?UE10amlRK0FjQ2l2Mk1EQlc3Q3RDa1A4NWZ3cGY4Z1F3NDBkK2Z6YTFqeHc4?=
 =?utf-8?B?eGkzTnZ6S3hLNjBheEM1YUR6WEhFM1o4UGYzczBWcVFOQ3VKM0VyMU9ZWGhq?=
 =?utf-8?B?dlc3b2NDb3djemFBSHBGbXlvVTRtVXJYMGNlaWl5L1NGSnpZOWFSRTZaUFJH?=
 =?utf-8?B?RXJLUktGODA4WEVueEZwR1NETU5lTTQzUVhiRkhpVzY4cmg1dnNybGdzYzRT?=
 =?utf-8?B?Z1JzdjEyQkN2cC9DSTI5L1ZzTytFNHQrblUrV2g3THEweVBLOXFXV0VjQWla?=
 =?utf-8?B?SGJCSCs3a1Z4dnhVN1hXRWtaaDIxYkJMTTVGVE5jenlwWEh0KzFpZFJ5TVow?=
 =?utf-8?B?U1JsZ1dKblpLd1p4TlJXcTJmS2ZFSm9FdE5lb05HT0R5OVEvUXBzUWs1bzVi?=
 =?utf-8?B?UlVhMzVLeXdONHF2aSt6RHh4RlNaZTVVUVMwVnVaUHYyWTIwYmFnbFppUk4y?=
 =?utf-8?B?SWI4Z0Zyc01iT3hQNDVmdUdFaWRLQzZ2VE5RNXNOUHJqWHhIZEtUMEVMTFlt?=
 =?utf-8?B?dzQxb0JZeEdkNmNqYi9DYldiN29SOUprWDMxbnZQL0ZYRWROVEtCc01Pd2Uv?=
 =?utf-8?B?Qm42T3FRWkVLRjlETGludjdkeSthdUlybnJheVJsR0Q0TnJKbFIrNEJ3SHBS?=
 =?utf-8?B?Q0pVTWlQQUs2NVJ0UlNvRG43Ymp3UXBDZDFVV2s4S1QrQy9kYklHU09ySy9S?=
 =?utf-8?B?S0pDY3oxK3NYTjErRG1xQUVkZW1KN0RlVWV5QUVQd0YwK3l6Y2FyM3VQNHlM?=
 =?utf-8?B?dUx4eXNnV2huSVBqaEtxQUhodENhNzBITjRCc2VMdWg1MkxCYU9vcWFnWlh5?=
 =?utf-8?B?TUlFOVBIcVFOY1N2UFhYZGNubllHZTI5c01RdE5oNEFXMTR1L2dDUWRvTmhz?=
 =?utf-8?B?djBsdnZrcmhQalNsMDIyQzhUSHNCZFFHaXZNaGRCS0xXMXRuUkt1M3FsR3ZY?=
 =?utf-8?B?cmlObWZtT0J6Z25FLzVqNDRBNDhySWdXSGdkNUFJVHJoM2E5eXBydlMzbUlp?=
 =?utf-8?B?VWlXVWV3UEQ1WGlYSzFxYkNEdm1nWHBNRWZ6ZHF5cXYwRkhoeG1UV2NyWkx0?=
 =?utf-8?B?NXZhcTdGUFhSa2ROQVUxZnBBT2daRWRyTlRQSGRwdzJBcXNCTHh1V3QwQ1l0?=
 =?utf-8?B?YmZLVEhoR1pUb2xjQXU3UGdIVzkvdzgwRzg1RVgyTVFPZlFpcGZVY1F3bU56?=
 =?utf-8?B?R0h4TS8yVnYzaXVQNVAxUkV0TjQyZWd0aEFRWWNnWTZ0Qk1BbnlCWmgvY0dM?=
 =?utf-8?B?YWtpTC9GMFZTcURzMit1ZlRaeHc3emdqM0JERlBoUUFFaHh2VlJZMFc3eDlO?=
 =?utf-8?B?bmdqdzZuRmpyb2VoWWRqZTZsTXhxcXZuY0Nra3BucnFkNEJmcVNsL0Nwd0Uw?=
 =?utf-8?B?TWlIMzR0VGYvY0x3Yyt2QXZWV2NwcXFPd0VzMVc4VWZISXFFbVJWdytsM2xR?=
 =?utf-8?B?QUZxSjN5NndXSzBGSGNxeW13UXFVOVJkblp2Z1ZYa1RHbjVTdUpTdFhoNjlI?=
 =?utf-8?B?S1hzeEphT29HV2M1b3dkVVhqYnNTdjNsSXJ4cEtJQ0sxbUFCYnBRK0xsYUxr?=
 =?utf-8?B?M3lVMzdPS01kREtqWm03Qlpjay95UndiUlFhUTYxeHY1QXdBMmd3WXNCZXd0?=
 =?utf-8?B?TXdpNFpKOXM2ZG5od0cwQlY4em8wakdpSDgvQmd0VzRtbTJOY0xlVTNpTjZD?=
 =?utf-8?B?ZU4zVmQrWTJCT3pkNjd3R2w5ZnJDQlN3WER0c3prSXYxSlJQZkRNemNjQS9N?=
 =?utf-8?B?bU5lU2hoODJzRDFIM0JCVk5ycWxjREdNT2Rva2dYSVpSSnZ0Y08xVW9pUEdX?=
 =?utf-8?B?SlFTMXV4WlNPSVZERENoa0RnOGVTSE14Zm5Yc21WdDJBbnhqLzZPNDVzUElP?=
 =?utf-8?Q?ri9OQwHfaQ1XdjQbJ63Cu0gAO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yt2xUtKx3/NVvV0ui6yebtFNGIb4zXuwligvo4b+9jeI2+SLKIWpHRESljLu4fWXeO/MdPpc/hnY/Az5KoRB52qoL5GgmKxa2U0iXyK3ddaWh0nqRe+TZUb4YGAeajxalVXchDnCDPfo+FQUJuKCQUSiY2Wz/QGuMdcdxWGiL2Revu7z0CM0bfgwNeIeO393+scUCHn4+B83kiwF1hYotCWxw2zV8JwJ3IhF2WeX4khzZraq778noXTh+fNkr4oultZjJUGlWi/8tPH4whgJxnjl7coWzmTKtvV7rwODuEiW+WiNX6+FqCIk2/TskzN/KifOHsuq3quI7XT43kDEku3A3/B3OqW4kU7Icl/rkDomxyD4G50mvkXyeCF96LGZQjDhj9bowyJ5raylcjca579K90SniRYGsw5qM1UZHoDMbkWi7qQBkaavhbN8jVskBOLe76tUMifRfuZM4C7XfwxoVwa//rPA0jTfNlKQ++BXkyYGVm50gQ2y2CAfo7D6DG5mOtKAPyfMibJuGStrJDaoDupsyDPtDldLkRc0txQEI7A4pSHOzwKqA1KCd0OEgBhPNnfy0ozHOKhUxHqCvqO+4QlhZ44Whp7I1HXJzPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20cc156-d920-42c4-4c03-08dd688ba9e5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:18:41.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29x47FVbxAdDASRIflorg1ICBH1eSdF4xQSJ0l4CE1Jxd15MSkmWJCPRmUALt9nvWX3Sl1sXuo7gKRNxtSNznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210111
X-Proofpoint-GUID: 6qLMk8wg71jZeqDlwaKNeOgG9OQWA2YD
X-Proofpoint-ORIG-GUID: 6qLMk8wg71jZeqDlwaKNeOgG9OQWA2YD

On 3/21/25 11:07 AM, Benjamin Coddington wrote:
> On 21 Mar 2025, at 10:43, Jeff Layton wrote:
> 
>> On Fri, 2025-03-21 at 10:36 -0400, Benjamin Coddington wrote:
>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>>
>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>>> on the NFS shares before the umount(8) can succeed.
>>>>>
>>>>> This is easily achieved with
>>>>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>>
>>>>> Do this after unexporting and before unmounting.
>>>>
>>>> Seems like administrators would expect that a filesystem can be
>>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>>> to handle this extra step under the covers? Doesn't seem like it would
>>>> be hard to do, and I can't think of a use case where it would be
>>>> harmful.
>>>
>>> No. I think that admins don't expect to lose all their NFS client's state if
>>> they're managing the exports.  That would be a really big and invisible change
>>> to existing behavior.
>>>
>>
>> If we're unexporting the filesystem though, then ISTM like we ought to
>> cancel any state that was held on it. Are you concerned the admin
>> inadvertently unexporting something or is there another use-case you're
>> worried about?
> 
> I'm worried about changing existing behavior and the fallout, today I can
> un-export and re-export all day long, and as long as I re-export the
> filesystem the applications on those clients are unaffected.
> 
> I'm an old sysadmin that knows that I can un-export and re-export stuff and
> not have to worry about state loss.

Is it documented that you can rely on that? If not, then I'd say old
sysadmins should expect that behavior can be changed. 2-cents.

Also, as a sysadmin, I would never unexport and expect there to be no
consequences. Running apps that try to open a file on a recently
unexported share /will/ get ESTALE -- NFSv3 holds no open state at
all, so the next NFS READ on that share will fail with EIO.

So unexport is already not without some consequences. IMO it's not
sensible to expect an unexport / re-export cycle will be safe under all
circumstances.


> There have to be existing systems and
> people that also have that knowledge built in by now.  If we change this, we
> break things.

No lies detected. ;-)

Another reality test is to audit other server implementations. I can ask
around.


-- 
Chuck Lever

