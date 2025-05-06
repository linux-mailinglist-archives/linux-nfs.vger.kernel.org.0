Return-Path: <linux-nfs+bounces-11503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CFAAAC758
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD81C23791
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C84280333;
	Tue,  6 May 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kFxjG4US";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GtU2A5cL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77844262D1D;
	Tue,  6 May 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540192; cv=fail; b=Bzt+oOdDz2v7DsKGyr7+0lks5g7/lhn13qKpia5vKfcz+N590QEuWFQoONGyKnMR67TPK9Mtu+dwimI7ZEknoyR6E2SG4wVCkV3lWEMbUrVRcAFsvp5jNhMCX2Ghgohr4rKU6fJ5HkMhWlTUs1V/vVLxAJzYxAPAg4B+M6XtIck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540192; c=relaxed/simple;
	bh=Xi7Hu5hcLcgSWKwifGP9txnVdX0gbqtWT/d5jfVA4YU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=diK7YDDqT+5H3vIrPxldno08/E0fpzi8xo5VWTqU9NOXNpYvXZH++6A1iaKxM7UFbcoVMyHAY63VUXVF/sttOPzKsIJVJsZUb6a2Z5u0SiBcvjT0uqU5W3q2QYAsVzIlsbqJL52B/eVllmiPRb1/Ef3SI+iLSaf75HIEYsMST5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kFxjG4US; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GtU2A5cL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546DqBVX003813;
	Tue, 6 May 2025 14:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oKmRLc/hG/9w2kVw3ZUwrGRE5UROU635qK4cUd/IM7I=; b=
	kFxjG4US0fm/iE5vZxoZHlSH8pgvbgBN5GRsohFQVbQCCL33PSwxs4GTxuzxiyoD
	gYv+JCfGTTBIkuODju6mjxYFbYGGMdDdAWh5fuXKX3gnJzVpvHIAPTkJRG9fwOp2
	aBDO32UxQbsACjlywnZ2a4jPX987MpOX7HRXa47rl7wqaEuYnhP7jzEmmb6UX/Qb
	wODfEDVm5nAlmkuqtf1DWWwmMKS0JF7ZB1XHI0YKoivMkJaeCOUeEMhyBScW97jl
	jNh80QVU7d/uiL5jPYvkI28xeEeUeVfSyLGM2yFwG2UwLd33vhFUrvAfjp2s8z4e
	m+dPSy722kh9hMhg6sUsKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fkpe8132-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:02:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546CmKqf036018;
	Tue, 6 May 2025 13:42:39 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k91hkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 13:42:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdNzbNCiHsxOxwXfj26pmkCWT5+6MChVNoaS4jvV2NmoMBllQcxPRBHfdrMDXlTRGjg4tYU9Gl+amjknsq1/s0RiXhkmWG4C6YurEFQqTjh//G8zqzhT2gZEHZceMtZbD6XbFkatdbzx2Zo0VKzS4rTVRJY+0kjsr6ZpC0TIkiaHq7ipUC5ROstLM4TxOiy2WbDzDvz5atI9kf1Kf0UZecF7lEOaifhkon7B4f/47ONqnM2AH2VKXWYay03MkxFe7jKAEUSumJBHP5eBOADnCLpeufPAKNXUs1VYHsVzUWBoKNtg2kFaoYD5pH9vVpNlJ7IzhG+AbpkSg9cNH9K6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKmRLc/hG/9w2kVw3ZUwrGRE5UROU635qK4cUd/IM7I=;
 b=eAQK263EXZEkWiih43Y7/YMTXTGQS89zQCvCdH0tyddmoXPgyZElajU2OSGR7A1YZQ6MUIyX/2abgWTTkIVvC2MOeWqcvKIIQZvex8NtGmDVz2Y9lVlmbeNyhAbV5/PgD9Ff3mI81LiXMe5f1DX1jbw3pANWZleCGp2ldChvwsKVUB0WFAVbYpKdQ0JvSMeuBNdwJwxUcc1T5VAZaS/pwfXDvRlzYKVDiphpcsqKY5lRDKcmYc+P3jjMAiR7Grqya5x8KHTM5u/Xzo5/0YytPty4ba0M8Q8Ezg6CHAtBbrc/Ozcb6UmLyDOYgxxJsmN/KYnt6LLtBDeikhvvuRwNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKmRLc/hG/9w2kVw3ZUwrGRE5UROU635qK4cUd/IM7I=;
 b=GtU2A5cLz1mFBw4eiQviloM9edD+bmEFgKV6DZ8qfEqPXoI3uKeAlpTCYi2EeMFbTeGcIn0jdJSrEH9W21EAS0la1pFBtBKF2b/8i1TJbf5XungOdyVFunLt/Li2CWxx0t+obEKXGNfdLpsZTppEq2fbH10K7x2qh/hzUiDWXNo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5130.namprd10.prod.outlook.com (2603:10b6:610:cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 13:42:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 13:42:30 +0000
Message-ID: <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
Date: Tue, 6 May 2025 09:42:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBoCELZ_x-C4talt@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:59::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c8f5b9-19eb-4045-f207-08dd8ca3d915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjZaY2x6ajlZbzZENUVwWFNSTGtGTWhKMmtTZnBvdFpxUGpsUkJqaVdMNEJE?=
 =?utf-8?B?S25xUWVFVU5JVG53WmlkVWxBZWNmTmpUbWpwaCtsMXRLazJyajdkRUtUV01y?=
 =?utf-8?B?elF1b0hKTHVVK2k2NnRDNzNUOGw5Q01ib2ozWmUrdExseGIvSTFJUks3K28r?=
 =?utf-8?B?MndZRW5ZQm1YWUhFbE9vb1ZSUURCa0wzYlB3a0RUMFVqSlhZcXduR2hZclRU?=
 =?utf-8?B?czRONG5DdnNTYTBnZEpRQ1RqclFqZFN0U3drb2NwVHhUZmYvK25FOG9tOWYr?=
 =?utf-8?B?Q2Q4V1F4K1JZY3drdnRUQkNCaVlMU2RyUHVZdjMxQXlwdlFKL3dxWjVTdGVV?=
 =?utf-8?B?MEF5MHNLV2lHUmVVeXUrQzA4bWxtVnhPL0FwdVZTbnJVQUgzNXRBY0xGeTlv?=
 =?utf-8?B?RTM0Z1FLS2hVUGZtUXNNQWZXdW45bEc5MWd1L3dDNzh0M1NBMXFSSlJUSkhK?=
 =?utf-8?B?blRwT2loMXFDMHdDdHRlOWJZS290VEFrREc3Wk81NVRISmxUVG5SWjN3eVNL?=
 =?utf-8?B?S2l1VVZOMVBzbHIzUmNzZmQ5a3hwVCtuRUhQcm00dUNuMWJYUDRONWxEa0lp?=
 =?utf-8?B?dkhSY2hkU09ONXhFMk1ZQkZSZ3duaXRYb0lVNzBFQTE3VkxxUlJab2o2djJ4?=
 =?utf-8?B?UFFHVXNERTZYckJZVXYySDdieUsxdHZFM0RmTko4UmJPVDArR0dxaHVaeHI1?=
 =?utf-8?B?MVlOM1FmeThrdkJIN1FjNnA4WGZoK2RvYXJjb09FZ25QaTFGNVVGMTRtOXEr?=
 =?utf-8?B?Y3ZIbnQ4bWx5OVFHV0ZVWlJsQVdVTmk1RHB5YWtGSFZYeFlJaHlxeHkraTJO?=
 =?utf-8?B?T2NObjVCa1VBaWpzSjZvSk9PK2oxeFVjSnVnc1BFWHJGV2RuSGhxOXFFbHBu?=
 =?utf-8?B?T3lYbEJSTUhMVmJrRjZNMm5acGNDQkxHTCtwYlNqc041OGxqS3RnTDFjeXZh?=
 =?utf-8?B?cm16UG5YVmpwZjNSQlVGN2xTdXA3ZlByMEd2dkpMb00xZXNvc0Zoak1tckpr?=
 =?utf-8?B?NFNsVU1XVTd6QW1UOXpnVXJqWU1mSXhVSy9aRlRsSGVRRUtKTWFVOFl2cXJS?=
 =?utf-8?B?UzEwaGNLSHBiL1ZkNFZGUi9OS1p6RFlhRWlQSFlndG9STjg1SHFMaEpJWDBQ?=
 =?utf-8?B?bFdPSEhKRitkVXhDQzZDRFUybVNzeENaMzdiMS83dGR3bHo3THQ4M05HSEN4?=
 =?utf-8?B?UGZPZ1Nad1N6QzJCWW50UkJ4akpKU3Q2VTJBbnpBMnlRNmRiYVAyaDkrQnUz?=
 =?utf-8?B?c2hSeEYxUUJ3MTRLQlBlMDByS09uLzlNOTJuWi8rTXhOMWlvTFlEVWZRS1c2?=
 =?utf-8?B?SUtEV21yRGM3OXNBZkFaK09FYUo2U1hJMjJOTlhrbGpTMWwyM3J1Y0dGdnVv?=
 =?utf-8?B?Qk5LUjZ4VnlJeVhrMm1HZ0dFOG9wN0pFU2g5QXpSWDlLclkyeXM3WFdOY3hS?=
 =?utf-8?B?L1ZqbnRXSG5ySEg5RDByaGpuTElZRmNkNWc5RUM0ei9Md2pEbi9Wem1lak1T?=
 =?utf-8?B?RTZrZTMrZStUWDdRU0U5clp4K0N1djZ1R0QwQWR4TldraFVxOXhQdlpHWkta?=
 =?utf-8?B?N2VhRlNSellZa2U1Y2FRNFcxZXl0T1BXTThBQ3ROUTVZODcrUklURzFmeXpR?=
 =?utf-8?B?ZGllQ1hwdHd4djRBek1SdGZ3alJoWk0vRUJuTmpTRXcwV1RJY1pCblZoalVE?=
 =?utf-8?B?N2R4WThNdGZVcDhmRGcwN0h0Ulg1dWxIMUlHSjMxei84RkNWMFFPbWFTS2lZ?=
 =?utf-8?B?M1oxdWJRVEI1VUFVREw4cC9UTTI3RGdMQzZueG9yTE9JQmxFZVM3dXdxMWMw?=
 =?utf-8?B?TDNnSi96SHB6MlZSNkhCYkZ2Z0NhdXA0VWVDbXVsL3R1TGxWbTlORTh4dUU5?=
 =?utf-8?B?ZGR5MFhhSVh6VEdTczltS2tpV1dDTTVRYTJwZ1ZVTmJLNjIxNDBJT2xvU2NY?=
 =?utf-8?Q?Pruk50KUdzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlY2REV2WGV5NUI3OFp5SDhVOVdkN0ZWTzFKdGZKVm9NNXYwbVYvWFE4VTh5?=
 =?utf-8?B?dndTam5jU2pwYWpHK0UrdFFJVXNjK3IxYUVTdEMwTHdiZk93dDhBYWJkZ0FJ?=
 =?utf-8?B?YjJ4eFU1ZU0zNFJ0VTRMYXg1d0dSRFFFU2MxS2RIQncyZTFBQnhyNmphdGQ0?=
 =?utf-8?B?c2tEK0lNWlZ1Wnp0bUhpK0cvQ2FNWHN1MEdGT1lXNW9ReVgvNTQwbHdvaUhG?=
 =?utf-8?B?MmlVQkVlS2dnaUtGeWttbWVsNFNXSDJjalBrTmFSVEZEZ3o5QVFyRUFMWHdr?=
 =?utf-8?B?N09kYzB0Mlk1YmllaGhIZHN3UE8rajErdVQ5NWkwMXZuQWpteWdzb1ZqSTRy?=
 =?utf-8?B?ZVFzSlhGcHdDRWV6Nk94NFhiQkFielErT2tYb1JlMHUyZHFnSGdUeUpqQXUr?=
 =?utf-8?B?eVRsNDIzdWYyTnN5Q2xvUGtBSU84WFJvZVJNZFVQT1FZUDlwQlUvRnhPOUVp?=
 =?utf-8?B?V3lRZkkrWnFEQ1VzcGJqdXJVVFF6cFo4TWxvcEp3ZE5rRVBGU0FoQ3djcDlK?=
 =?utf-8?B?QnBXeGZFNXFhUjlubWY0ZG1yREdrZmV0TE5Yc3F5cldvck9FckdoQlVBZGlC?=
 =?utf-8?B?eDNURWhzOXg5dFlrL2ZmSHNNTG0rWTY5eVlpbDdWVjR5Q01jc3RXOHFNS1R2?=
 =?utf-8?B?OTBncGx5aFVxVHFkUmZCT214SkpsSXowZTFWZmd3NUZRa2VhKzZyOC8zeEVJ?=
 =?utf-8?B?a2FNblBMbFdrb1ZaQ0RBZDNPYTZXeEdVQTRMU2ZjM2tvTmxLcDNzUnVvK0Q3?=
 =?utf-8?B?YVplTzU1UHBtdThIWlU5N1pINVVxSGRqRXRXM0JLYUZMSnNidnc4TDhPNUlX?=
 =?utf-8?B?andWcWpVU2JGdkVabUQvMURMbC9Lc0o2WDdYa2pScVA4NkY2cnVmbnlkQ1Rl?=
 =?utf-8?B?R0RETE54bks2Vmp6aVgyU1EvZTBvbDh3WTFmUmdrUHJGYTlrd3cvNFBRUTJm?=
 =?utf-8?B?Z2JoZTNZQnlwaStBSHNwUXJuKzdTL3N2ZGFmd2ZPTEh2WFR6MUQxN3JZN3Ux?=
 =?utf-8?B?VmFtZXBjdDY0V0RPVVBjUi8xQ0JYSE82NUhBVks0bnpSYWMyWlYyaTlQOGM5?=
 =?utf-8?B?K1d6dk4remd4ZEN0VGdwNlczaTdqblZJT2dOcldPclBKZzdGcHdZd3lXT2dN?=
 =?utf-8?B?SkxuTFFaUjQ3ZGJOcWtpT2RpY3ZBWjlWcmFoamNBZDJVb05lTmVQdm1QbXEx?=
 =?utf-8?B?K1NyYnRnK3F3V05zQ3c4V1JzN3FybFRqQzAyRTgvVVd4S1ltZXBwZDFCdTk5?=
 =?utf-8?B?SGpQekRkOGE0cWhwYU54dU91enAwVFlPclZDREN5anVjMUNXVS91cU55dlNU?=
 =?utf-8?B?SUlidVI0VG9mL2Q1NzIrMVdoYWNFOWZpdnZWd29jbjFrYmlSNEZ0L2h4UzE2?=
 =?utf-8?B?QTd2MDJ5NGloS3NzNmJsTlFMaXMwY0ljYmtSTG9CNE9NOGU1TFc4QTAvVWty?=
 =?utf-8?B?aEFoMXYyNGl6WmFIa3NHdkJrc2VZYTV0TnZuNGwvOXFKZndmWktsa0ZxM2ho?=
 =?utf-8?B?QWFPMDNxUzV3Yzh5N1U2NUJiL3BrOW1EMnpQbGxGRTVURmU5YUZjZDlnV3Fy?=
 =?utf-8?B?NGcxYlhVLys3TXZ3WWpkZG05ejdpc2J6d3owaTU1SkxsSS9tSXZHSjQ0Unhl?=
 =?utf-8?B?SDBkUmNsazA2Zmgxcm1PZ0RvelViNVAxZ2wyd1BnbnNpc2QrczlXRUZWZWth?=
 =?utf-8?B?cjZaRWt5dlZPc2c3NnBmRUlENmJqNVpMK1k1QTlERkpCNDBLaHRxZGIxUkJD?=
 =?utf-8?B?bzNCT1E0YjFMUUc2NUpESGNUTWhtamwyRld6aTNCSHdXbm1UUW05dVZYYVBs?=
 =?utf-8?B?djJGcmhQL3lXRWw5c1lEWDIzOUxSYVViMkd1MWg0SXZxWXVMR3dUbExqVWJ3?=
 =?utf-8?B?WkRoRThvUmo2aVBvS0RMT2daQW10d08wTXB6UzFGd2xBMWMxMTBYWCt6cWJJ?=
 =?utf-8?B?RTlzZ1NjSHBtZ0xHR2VqVE00VTlWWGw4di8yWnV6c2V6d05GL0dJdWhpR2lU?=
 =?utf-8?B?QitPcGo0VXdYaEJlV2ZhQXA2d3U5M3VWZDFXWWpLU1ZWVDZYVSsvU0w5K3Mr?=
 =?utf-8?B?VzR0SDVLdzNJaW9wUHptUHNFTFZhdSs4VFM2SjUwK0xVdm54TEswc0ErRlE1?=
 =?utf-8?Q?0O/zC7PTDDiK0m1v+6t9I0kBC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XRPHef++QIf1A/mr9LW7nIjCb5se+ymf8Ji1PAUpiNQfANy4EendSAxI3CF2RtfQu2/KVSpCVJd5jnxK+m0R7WT2Zbx257KIAr0gqhL9KoxH4os3AfKp5SjgwMpSx7YvHuFXwFZHQX8IvH6ZRoxOadP/+1WsRFocIrQIG3kZMoNFHfMLoQ5PphjLjbQfiKKAWRT3mX5pEUvtFJtx+f1dak5kWAkIFwyWA9HTjs/yHGcmWX0S825bYLPcMXhkl50sdbx4130eXmnX88TIQfKtbs9fcXWwgEgwginIouaKxYfW5UuALjDtL/gtpb1ebesKky6tmZfTBIvjJQ0nQyxyC47OpVl8knE0IinU5NUGxbjdeCGQ3SFvM7jvWjufOtxRuK+l8aw+NgEXocKJpa3/hvb/7pdfYWs3PtdFc1gIPLLtA0Y9+2ADrO6QCtFWVBlt1dDCkoYlsLkU9fDLDll6zlq62TF+P0UfpGN2fw/LLkcWMZKj5z3gCd25HZ2H9tgthhef7TxMkkZMjt1mTZKTtF9lkYP6xDpiSbagUIopDdPIgGHOq1pW7kJyzffbligL6j/sRbU+QfdH++S0Yj58P1Nnn+3Wl4KsrwGPGkExF7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c8f5b9-19eb-4045-f207-08dd8ca3d915
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:42:30.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaATK10iTGrET5Vr9liJObAh4vqROKSYbMrbmKJx6AEin0hXLbFMVW8LMljbRbfcx2rYYU49+mNThJ8wlskUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060131
X-Authority-Analysis: v=2.4 cv=IPMCChvG c=1 sm=1 tr=0 ts=681a167a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=z6CLVcBK2l8s0AY9wPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: y-PqOHGQgiojYoFfHsObFHrA34c_oSRD
X-Proofpoint-ORIG-GUID: y-PqOHGQgiojYoFfHsObFHrA34c_oSRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzNSBTYWx0ZWRfXwBZNDoZJOC8y yXszcKhaNwO/eIKpAdFman6hDlJITLrAp7cxuhFAx8AZAEz/S6MDSH1RF7QCwhvyX4nVU2elZFS HwuQkFo4MnwzuFIx1wPsTnR0yusFGx1fE/IPV9Ox3uEcHZV4pgGJwQiOrF81gX0tO99oCD1/f63
 XD0qPS+VK7j/cUyGZtibb0p93Xr7HbrlIj+jqa0eBOZ33yVQHdH+Y4R7VESZzdfgOYMaOb0WhOi FS19tAVK3B17MqCA67E1bUm3INw9Y995x1MZ/nEAqVgF/gGqwdAbf4WjaERrfUtqfonDd2BFukh z1nNuy7VnCHyug8ofSftGEmrC50dsWbzPCiRFhi718IezDGt1ozgB1oJOx18c6g64xJBu15GZtn
 33bDv65ZKHDSRhNPKg0csTEIClMwm2lekUoudQ0thumet2jj1qSA5pDxBurQj4NTlELPYOf4

On 5/6/25 8:35 AM, Christoph Hellwig wrote:
> Hi Chuck,
> 
> let me use this as a vehicle to rant^H^H^H^Hprovide constructive
> feedback about configuration of the tls upcalls now that I finally
> got around playing with both NVMe and TCP over TLS.
> 
> For modular systems configuations the amount of monolithic state
> in tlshd.conf is a bit unfortunate.
> 
> For NVMe it isn't all that bad, but having to hardcode the .nvme
> keyring still means that:
> 
>  - we need userspace configuration past just enabling tlshd to enable
>    any kernel subsystem using TLS upcalls.
>  - hard code the keyring used in the userspace configuration
> 
> Can't we ensure the upcall passes the keyring to use and avoid
> this issue entirely?

As Hannes mentioned in another email, that is the ultimate goal, and
there may already be some code to do that.


> For NFS hardcoding the keys and certs in tlshd.conf is even more anoying,
> because it limits to a single client key and cert for the entire system.

IIRC the keyring mechanism will work with NFS too.


> I have a hacky little patch for the NFS client to pass keyids for the
> client key and the certificate as mount options, which seems to work
> nicely, but it still requires adding another keyring (see above) or
> giving the user read permissions for the keys while it would prefer
> that it would just work and we would not need to give any root login
> session a way to read the keys.

No-one has claimed that the current implementation is complete. I've
just sort of petered out on significant new changes. But it's
definitely still open to contribution. Patches on kernel-tls-handshake@
are very welcome. (But you do have to sign the Oracle Contributor's
Agreement, unfortunately, to get the patches into ktls-utils).

-- 
Chuck Lever

