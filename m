Return-Path: <linux-nfs+bounces-13927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2395B3914E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 03:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554B37B6F61
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 01:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362841D54C2;
	Thu, 28 Aug 2025 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rhuq0qYu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAtoAg6b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C21E7C27
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346269; cv=fail; b=TF/cWcY5DHRAx9s0kK3sWoSXM7SYXmHWyI3CbkJ0bhZmLW/4AxW5fSfwOABm7y/F+4ykT6VRfWay2Um12pVr3B0cL8Ao9JhGxoiWRuNEudX7FfWZdVRpE5K6UWJ74tOoh9haUbJV5VCdf93D+Ya/1YwgI0bCYcKfywjRpBxgTAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346269; c=relaxed/simple;
	bh=b/AMB1BC1AHCbI1AliUoZChOyVhUSypgFlALllSf+pQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxQ/EFsFaPLkXvJUgE/CrmJdfAsrDG4AqKjiZxh7iXM3KwROwp1hZ20U5MgjbluBu6a+BBAOysp6w4r6cTg3kbMVIImUigq0/Xu2qiZd2ZuYqWVSWKxUYcThHfFa+zU4DQ2JqcwYW+U3aG/EGuEWK+6jGbaqHtg5Z51KDSiNIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rhuq0qYu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAtoAg6b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH6HP007570;
	Thu, 28 Aug 2025 01:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DYg62lEHPy/SbAczrLjZ4jr8SHcfD8x7ZbS1qAic7gM=; b=
	Rhuq0qYu40DblvB0/UiZy6RZN6+H2PKMds0GjfT2lpwJksbjm5C+LyhE2ns5Cdoy
	mYT0bFVgIPuik+mTvQNti8xWftXUakmZNo0/XSdAzv1+m+AdPsWpnmlEYR6lygGc
	zAdNEV8LuYsRz6fHjJE7xnvEh4Y7gK4kCNxgysuUkPuDJH2dw8/yTTzLew4jRFz/
	I0qs94YWUQ0puACMLZmIyvHQgGV2kmUmz/DrdXPN3PehYbqY4qestvrhGkfs/wWo
	1x0M1TDgxg6zWZcPDeaSurd4EfZfjrqY9P3c+a6JGMEEmeEZ/i+b9HHgb4V3LhUy
	T/5b6ZM7ZFMLD69LKonZ5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678ym18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:57:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S1ALXt004951;
	Thu, 28 Aug 2025 01:57:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bemys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdxuqnjWNeWAqse0O1/GcO0myz/IA38IXptKZEhizpx/kgNUCzNn59zp7/ZHoGk/rUuPji+FmS3ITRbeR5hH1j7Z2EbDwGwGzNS8ai0f9Vp+GvBwV4t6lKOwWqrn5pG77/tRv46v2ToYmbA7hPBtzdAecLLiif7kQJ31tz3smWbB4wjBSxZDRe4nMzFPEiVjTG/zhvvPgSUnQNgGARQe6jFmB/szwSu3bOUhZEJtOn+PLfJYW0EBN1IEBlDYPmDlM4SkyE7VyCWIAUYlHGXOsNVooBiq69bAdYoLkfowrf247wJWUC4PHgFrgRm42johPz+GYTZOXgRZEprIw4+hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYg62lEHPy/SbAczrLjZ4jr8SHcfD8x7ZbS1qAic7gM=;
 b=KUYe6Pf+aEibw0WRMzwxYETbMVfjviPZUcyqYuJvdiUfvJRj4x+KBETqC0/tUbUWEkSnmzRaPnM0jtIVNsYS6dT6msnRuhD1B/2dKUqAuAmXkCgLNsjAdb1CN2MmZfpGKTCeI8xr4KNpV7dqEsYTEgVc5RBIHUL7QEEsVHGeytEjQyeLV7Zh5R8+txe3wq23AWisreyO++TUkzDbadCcERtq8jiUiSa1g4q0SlRKHBNsmj8a/BSGE0lbAHVGt7gZruXaXN9gea2ZpM5+nsUoxCh7pbTnj2CjMMBuarJyDFxmIazSx5lj6lnvJP2kvU3CRucUJtDoUr/to0Q/HwziJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYg62lEHPy/SbAczrLjZ4jr8SHcfD8x7ZbS1qAic7gM=;
 b=xAtoAg6ba4O17CRfAUDe4YNHBGYlvRojzSwv7N4H4J6OUSVacaTxe94Q9ZJ5SO/WGjCXc3BvMUY8SEC94929jUOayHACQMWipwkliqG+l0S83FTiSOcZDyCYedHqqVT+sIlKWVbpL/0VhMd57p0CCuXRH63pFC5KrvcLIvOqeC0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFA3184E4F2.namprd10.prod.outlook.com (2603:10b6:518:1::7bb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 01:57:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 01:57:40 +0000
Message-ID: <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>
Date: Wed, 27 Aug 2025 21:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
 <aK-Reg6g8ccscwMu@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aK-Reg6g8ccscwMu@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:610:58::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFA3184E4F2:EE_
X-MS-Office365-Filtering-Correlation-Id: eca70b75-12b0-4d95-b5f5-08dde5d6453f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z2dlb2VsVUJNaEQrYmdMblVKejBld2ozbDR3SnNuS0xaUHV6YjVWR0VGSTZs?=
 =?utf-8?B?Wm04eFVKOG0wcS9ZT0lidFFNdlhYSERKQXQrWlcxVWRCdVRCdFd2bDVVS0JT?=
 =?utf-8?B?Z3ZYQks1bDM4bC9CR0hDUUxHR0IzalpOdkxQcGRPT205WEJJRitOSllidkVn?=
 =?utf-8?B?NWc1OVd3YjBRUmZiNHBhRXFFSXV6Z21OV1Y0Rmt1Y3hGM3JHM28xb012R2F1?=
 =?utf-8?B?Mi9kczBCTzJEUE5tYnRRaXQ3U1RRZTJYQ3VtRDJkV0svMVhPL2dXRGdhSk5u?=
 =?utf-8?B?YjNRRVl1bC9RRXZTZllsQzZzNCsvdzBXTmF2WitjSUk5VW5ROVpRdFV0MFVQ?=
 =?utf-8?B?bFV6N2xCbi9tTTRORXlMOHlkN1MvbDkzM0NyVlAxNGpJbXlHdFQzLytURHhx?=
 =?utf-8?B?SHRvRHhueUE1bFdNTTNWa1htQzJTcTBFTjZTMHJlNjBpM2RtREVTMFR2ck14?=
 =?utf-8?B?QjZwUjBhME1OY1FsYTI5NWRYc25pUi9xUEdwUXlNTFJlYm5CckJpNDFqVjNT?=
 =?utf-8?B?eVhCeWk5MEpYMGlaZFVTaTZUcWFGUE1LTGhrMXpFQ3dacEs5Tm9LeXdWU0hH?=
 =?utf-8?B?RkpmVTZkWHpONFVNMmI5dkhSUVFUK1ZRZTNIbW01SGlKU1lLT01vK3FaR3Jz?=
 =?utf-8?B?ZWxlR1FSK2doeUE1eHlpMVJHMjBYZ3RtbkxnalRHZ1hxUkkrQ0o3d2tTdDUw?=
 =?utf-8?B?R0p1YWdQU3FKRE9JQ3hPWVFTZ2FMcVV0eVREakp1YXhpdlRBeXdtVHFuYUFt?=
 =?utf-8?B?V3kxNExjVzl1SnhESmduMkt2eVY4eW5nVjZVdmprZFJ2ei9kTHNUUzQweXow?=
 =?utf-8?B?OGlodzdKcnV2dzNzUVZFQ014WlBucnd0d1lDeEQwNm4wY2s2ZEVpY0FDZTZv?=
 =?utf-8?B?WnBMMzlPVWloNEZac3E3bHBwY0pqVWs4V2VRQU5EaUlwNC94OXlKUWNZN2h1?=
 =?utf-8?B?OVVhL2JESzJjdFlQZks4SjF6bFFsN0RuQys5ZzJOSDdmQ1ZRTEMrRmEycncz?=
 =?utf-8?B?YzZiRWpiZ2VXcVpQS2R1eEU4cGh1dTBBV1VRWlZIMzl1cVUxbC8xRHpTMzBr?=
 =?utf-8?B?MEd1WlJUUGh5Y3VibVNmRnhFVjNMbjdLZFZZL0FLa2ovcElRTHdMcHRNVnlE?=
 =?utf-8?B?TWt1cDBNMFVOVTJacmpkMUk3YlNZSTNySFVYN2RKcGUyeXF6TkY4cTFldzk1?=
 =?utf-8?B?NjAxUXpGNFcva0doWEdjYzZlemZJR1JBWlJzczJ4R1JKc2FTWDdhVjlLanBL?=
 =?utf-8?B?d2pvdnhld2c0OW1vNE1idVFtMmZqcG5tUFFybk41bTRjS20wenY1TTd2VnZx?=
 =?utf-8?B?d1VvNkFZc2ozZ1V1R0ZIeDQrcjQ3TXVmalJwUE1rUG0vcFJwdUZPbk4zamZr?=
 =?utf-8?B?MWRZWG1RcElyR0JQL2pGM2NjK1pYK0xXWGVlYlZDc0k1bkh6MlpjOW9JeFJL?=
 =?utf-8?B?aW1oNUJTSHhCSFN3enFTajdNekJ3MDROQlFxanVFeEczcTIvVm0rOWpGU2NQ?=
 =?utf-8?B?VGxaS0R1MXZUdjlIRHpsSElEYSs3NG9IWUc1OXhSVmlzK1B1NzFXS3YzaFRR?=
 =?utf-8?B?S3J6TEVqNlVmV1ZURmQwSUlNS3I0bFg5c0JLUkFhK1AwZGRjN05adGtqSDNK?=
 =?utf-8?B?V1dScUwyUi9WY0oreTl3NWRBUzZiNENIRkRmVlZmQ2pSMmd2bGRVMXkvOVdi?=
 =?utf-8?B?UmdmZk1lZjFwb0FmRmNnOWg0ZndkeWxpN1k0Y0dFQnJoaTRuVys2MVlKN085?=
 =?utf-8?B?WjBiZ3RjMktBaHFIZDh3c3RFQnFjdXgvSDVWcWtZc0p5dmNBRzRiMDRBZDRG?=
 =?utf-8?B?UDVBZGoxNVBnd3VKdWNsc2RXQS8rS2x5RDd0eUwyKzFMcVc1V3QzbFZKVlB0?=
 =?utf-8?B?L2RxZHNqS1kvd2w0ZlcrYnVZSGtLaUVURWVoVDdzaHdQcXhSTVhockFwa1Bo?=
 =?utf-8?Q?/iB7WAIj0+M=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UU4zMWtmVTQ5SDN1czZZNEx6bUtIbHE4MFFrZDBUbmVNNG9TSXQ5bnlweExI?=
 =?utf-8?B?R1dBV3hVYW5uSXhjeGo0RzRhVmZWZ3lvRTRJeFYwZmM1SmpaaVNYR3d2K1pI?=
 =?utf-8?B?TlJnYWtnaW9uZU95NmV1WXdnMTUvS0FNQkUvRkRuN2djb2tGNmd3a0tUQ3JB?=
 =?utf-8?B?QTZrMHBkVGdLWFhFcDRUMEFlOWZEMFJja1NVVDl4cXJlbHN3S24vOWUzQ2ZU?=
 =?utf-8?B?ejVOVVltdndScm5xWjZEejhYV2lwMURPNE9iQjBRWG9NMFpoanBKWnQ4V2Zk?=
 =?utf-8?B?aXpFUkNzVlprbThoTUltaDRMWXp0UzFVSU8wUmZadTgzUDBDblZySGk2Wk9J?=
 =?utf-8?B?SEpVb0QrWGlkWGdmYTBMTTFtUmlFU0kxSmdRb0NUaVVWbXNIRmRtYWYxZUdC?=
 =?utf-8?B?QWc2d2FPQ2JGcUkwZ0FqWjUrVGpCZDlBV0dRSlpYek9kZDB6S1BDVm0xaFp4?=
 =?utf-8?B?SW4xMDNhdkQwZTFWbklISlVoR3Ywd0d0NzRNcUtFRDRyRHIzdEZOdW5aM2Ew?=
 =?utf-8?B?Y2piYWxvMHhoRnlCRmtlZGpVUGR2TWlpWDhzQ2FqRmdVeXd0RzNHcDV2Wkw1?=
 =?utf-8?B?VmNnS2Izc05CN3ZSWUViWFkxNWJhOGlPVnpLcUpxOHRvSHI0QzVlWHY1SWtt?=
 =?utf-8?B?WGVXc0gvcWw5VkR1SCtUeVk5TkVQeS9tc2IzU3ZaUTFzNkExSEJaKy9PekVa?=
 =?utf-8?B?VlY3eXhWR3d2L2tQUkhYVXZ4bGlRYnNQQlFsWDlrSm9HWTBMNFc0SWQySVFE?=
 =?utf-8?B?Mi9ncXFFUzdkV0VlTjZ2L25UWVRpdjQvZWdnN1U3bTcwYXU3K1pEYVZBNUFw?=
 =?utf-8?B?WWxTM1pDWG01MEVjemkzRXcyZkRaaEQzV1hTZkJEU21MdG9wT01Ya3Z1cVpz?=
 =?utf-8?B?ZDF1a3hRaHBoYXhGSWw4U3djVXFjdFo1VHlQS1FoRWRteWtpOE00YmdRc0lC?=
 =?utf-8?B?VU4yYTJTcTZoN3AwZkFaM096ei91aFNrTkhrUEdpWUFyU2ltRExIcmxlWTdi?=
 =?utf-8?B?VlR1dmFVNHlaajVQcVBMcURuVEZvTVpjTGxGZDQ4OS9kMTBqemZtV3BVajVR?=
 =?utf-8?B?RTkwZFJtdC84Qm5WVDMxaXlXY1JjdXdQQ2VVU2pUNXNsMWNXdmZ5WUcyeXQv?=
 =?utf-8?B?RktZMlN4dmRjQjF4cHdhTWZOMUNNNUZYdnBORUxNVnJmeEhsMnY4WXFQc09W?=
 =?utf-8?B?OHNhZ3M5M0JjYTRSdnVONlhTUFVULzhRYkZ6RUlFQTlYbmFmTGdhMW1IV0xK?=
 =?utf-8?B?WDN5VWZaSVl6TWFYREFHQnplODZiSUtnK0VsOEVTclZPK2t1YW5BS0NnTVhU?=
 =?utf-8?B?c0VZdCtpdWdYU1Rpa3hJRUp6QkxjbFc5VFMyajFSaWxxOGFoTmRTa3dhS3pj?=
 =?utf-8?B?ZTQyTDcxZ3BFeVgrZmFFaStrZ1JCdlhCSGpUU0MwZElCdkt4MlFVckxtVmRx?=
 =?utf-8?B?RjFqK1llWjhaSFNDY1lLMk4zTTIvaXYrbHFVb2pSU2lmWHZqNk45bGRJRzlQ?=
 =?utf-8?B?QnJUZzhydzFOV2xkNW5QTWJxcXJoZmZIWHMyR2o5akZvRXoyMThhNUxTK0Vh?=
 =?utf-8?B?cmg3cklsWURLeGFEV0VWMmYrYVUvVzdOWFBML3NVbVBYSm1ZUG4zSzNQZk9s?=
 =?utf-8?B?aCt0eU9naDYyaFExZGtudHA2cFU1YUczTFdlTTkyOU1LdVVmOWF6N2ltQWNs?=
 =?utf-8?B?QmY5d0ZIQzdUWlpCM1d1VUxZbFE0RFE5T28zQnpJSHQ4bkRVd2VlQ0xsRWU3?=
 =?utf-8?B?d09vWk5ZbEZlSWZLelBxakNxdFo4TE9MbUsralpjTVl3SzUvNmV6ZGp4Y3Zn?=
 =?utf-8?B?Y1ZkZ1dodVJ4dFJYbG41WlY5VnN5L0s3MFgwd2NqS0VQQ1NjYmxkZ0xtTjdv?=
 =?utf-8?B?eGg0YzFTa1E3VFVYajNkM3krYU1remVNUGNremFheE84ak9pQldrSjg1K2ZM?=
 =?utf-8?B?Mkg4ZDN3dUtBaE01Wmw2Z3l2eGZaWXFWNWVXSVAxUjVNT1JhRlAwWUptYlRG?=
 =?utf-8?B?TTR3ZElsR09iRWVZTDh2SSt4eXNHRDYzZFc5akhzWnRVQ0kweGdiOEtxazJp?=
 =?utf-8?B?bWJXVFBiVmhSdG1lZ2M0Nk5WaFY0d3lSbk56eC8yNTBDMUNxTHAwU0YyTEJW?=
 =?utf-8?B?c3h4MGJHRS9MUmVOdmltODlMY1hBcVRYNjBJZUU2UFZrbmNwNjlnUytFRy8r?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4qft6qtT9vKx0KYgNkErrn6HQcMxoT5GyT5evmSWqQoqc3fgc3pf8/hnuCcgz71eOsx/zQGcJwpFmqMUwnDglCce3iPIMxvVDd6G7w0uIEySBp0HWe2cqnxw+L+aIfZKCrOxyorMb33VX3420qVpWQ8OWzYVIWJcuIR5ivow18jibax1VJuCo0UkzdpAOuDzkf1JJmKY3FeG8a2L6QFFaexM1cWOmPp8BSn68YB6sqyj67gk2AK6JRjd6nGtYbk73mL2QDM2UitkNb+3tS2eJc7CoREihZrTs2HCzMme4WG77X6aEvsKJnxG+O/6ND4FMWiA0MTKzJ69hY99zieEUpGgOVHktTcaxhTlJOJTNHG3VMbnDD0sVxCRu1X7eYqEG4qgphtbaLrRnd5iz/Vtgh/GD4DeLi9vcaYNrRc2Ud8EksONIUAwrXJ/nR60EcUZhygEW81RLvnsHhqvV7TRyBKFDCGNe1fjuPP4STxrjrij7dkcXtkkRKAH04TN3IjTdV3DZW0kzKvPDm1iHdcSKMiXrtDYYCHEtquV7wOAEcg6VL0cIUixo4BnXQedbaauSJoBG5O9VHApCFJLH8053yqGPR4WYo0tuIcxAiqbWAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca70b75-12b0-4d95-b5f5-08dde5d6453f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 01:57:40.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHtMZAmo/jvf72FZT4DHq9CAKFC9LijKczzLBhbfiS/bwM5cTEPRT9XBa8VDqlq2mG5GgZX3/q9aZpuDohJqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3184E4F2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280014
X-Proofpoint-GUID: lXR_cnA_mUzK0IcjmoOUPI8FpTvUndi-
X-Proofpoint-ORIG-GUID: lXR_cnA_mUzK0IcjmoOUPI8FpTvUndi-
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68afb798 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=TpuvFHp_A9yTE6twK3oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX9Zyji0Fmx35G
 Nl9mwBW+JpeJjN71/sKrMYjLTCSJS5sGdI9pgjw5CIBL/2Bl4yVlCP2C+Yft7HQccH9cTP8eK01
 LXvwug8Ynq4ihDbjpytlQNDzdE6VGU7zgheGtm30idI94SQCp46l42gKoW3eCegUBOUV9of78xw
 rvDhL7V71O7MSMxI4tUBzVzYeWfaSdy+hYUoRZeDrwf2gIl7k+QiKUMq5/z4Ql9dD8JMJP1MtuO
 /b85f3k7jpzdclXdESuhcehoDjUXVBtF9jH+TTavmSOcO47O3sOBeRGxsse0Qy9pJ7Rrcmm/vtK
 wJjmRKnFiGduYD50oR9rJekCn6mlh/W77513faZuWlxINMgcUGueGUmDS/vPrNkQ7TAQkEx3fMb
 Uihu0+rU

On 8/27/25 7:15 PM, Mike Snitzer wrote:
> On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
>> On 8/27/25 3:41 PM, Mike Snitzer wrote:
>>> On Wed, Aug 27, 2025 at 11:34:03AM -0400, Chuck Lever wrote:
>>>> On 8/26/25 2:57 PM, Mike Snitzer wrote:
>>
>>>>> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
>>>>> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
>>>>> +		      __func__))
>>>>> +		return false;
>>>>> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
>>>>> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
>>>>> +		      __func__, dio_blocksize, PAGE_SIZE))
>>>>> +		return false;
>>>>
>>>> IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?
>>>
>>> I won't die on this hill, I just don't see the risk of these given
>>> they are highly unlikely ("famous last words").
>>>
>>> But if they trigger we should surely be made aware immediately.  Not
>>> only if someone happens to have a trace event enabled (which would
>>> only happen with further support and engineering involvement to chase
>>> "why isn't O_DIRECT being used like NFSD was optionally configured
>>> to!?").
>> A. It seems particularly inefficient to make this check for every I/O
>>    rather than once per file system
>>
>> B. Once the warning has fired for one file, it won't fire again, making
>>    it pretty useless if there are multiple similar mismatches. You still
>>    end up with "No direct I/O even though I flipped the switch, and I
>>    can't tell why."
> 
> I've removed the WARN_ON_ONCEs for read and write.  These repeat
> per-IO negative checks aren't ideal but they certainly aren't costly.
> 
>>>>> +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
>>>>> +	 * or base not aligned).
>>>>> +	 * Ondisk alignment is implied by the following code that expands
>>>>> +	 * misaligned IO to have a DIO-aligned offset and len.
>>>>> +	 */
>>>>> +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
>>>>> +		return false;
>>>>> +
>>>>> +	init_nfsd_read_dio(read_dio);
>>>>> +
>>>>> +	read_dio->start = round_down(offset, dio_blocksize);
>>>>> +	read_dio->end = round_up(orig_end, dio_blocksize);
>>>>> +	read_dio->start_extra = offset - read_dio->start;
>>>>> +	read_dio->end_extra = read_dio->end - orig_end;
>>>>> +
>>>>> +	/*
>>>>> +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
>>>>> +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
>>>>> +	 * start_extra_page, for smaller IO that can generally already perform
>>>>> +	 * well using buffered IO).
>>>>> +	 */
>>>>> +	if ((read_dio->start_extra || read_dio->end_extra) &&
>>>>> +	    (len < NFSD_READ_DIO_MIN_KB)) {
>>>>> +		init_nfsd_read_dio(read_dio);
>>>>> +		return false;
>>>>> +	}
>>>>> +
>>>>> +	if (read_dio->start_extra) {
>>>>> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
>>>>
>>>> This introduces a page allocation where there weren't any before. For
>>>> NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
>>>> like this is not needed on an I/O path.
>>>
>>> NFSD never supported DIO before. Yes, with this patch there is
>>> a single page allocation in the misaligned DIO READ path (if it
>>> requires reading extra before the client requested data starts).
>>>
>>> I tried to succinctly explain the need for the extra page allocation
>>> for misaligned DIO READ in this patch's header (in 2nd paragraph
>>> of the above header).
>>>
>>> I cannot see how to read extra, not requested by the client, into the
>>> head of rq_pages without causing serious problems. So that cannot be
>>> what you're saying needed.
>>>
>>>> So I think the answer to this is that I want you to implement reading
>>>> an entire aligned range from the file and then forming the NFS READ
>>>> response with only the range of bytes that the client requested, as we
>>>> discussed before.
>>>
>>> That is what I'm doing. But you're taking issue with my implementation
>>> that uses a single extra page.
>>>
>>>> The use of xdr_buf and bvec should make that quite
>>>> straightforward.
>>>
>>> Is your suggestion to, rather than allocate a disjoint single page,
>>> borrow the extra page from the end of rq_pages? Just map it into the
>>> bvec instead of my extra page?
>>
>> Yes, the extra page needs to come from rq_pages. But I don't see why it
>> should come from the /end/ of rq_pages.
>>
>> - Extend the start of the byte range back to make it align with the
>>   file's DIO alignment constraint
>>
>> - Extend the end of the byte range forward to make it align with the
>>   file's DIO alignment constraint
> 
> nfsd_analyze_read_dio() does that (start_extra and end_extra).
> 
>> - Fill in the sink buffer's bvec using pages from rq_pages, as usual
>>
>> - When the I/O is complete, adjust the offset in the first bvec entry
>>   forward by setting a non-zero page offset, and adjust the returned
>>   count downward to match the requested byte count from the client
> 
> Tried it long ago, such bvec manipulation only works when not using
> RDMA.  When the memory is remote, twiddling a local bvec isn't going
> to ensure the correct pages have the correct data upon return to the
> client.
> 
> RDMA is why the pages must be used in-place, and RDMA is also why
> the extra page needed by this patch (for use as throwaway front-pad
> for expanded misaligned DIO READ) must either be allocated _or_
> hopefully it can be from rq_pages (after the end of the client
> requested READ payload).
> 
> Or am I wrong and simply need to keep learning about NFSD's IO path?

You're wrong, not to put a fine point on it.

There's nothing I can think of in the RDMA or RPC/RDMA protocols that
mandates that the first page offset must always be zero. Moving data
at one address on the server to an entirely different address and
alignment on the client is exactly what RDMA is supposed to do.

It sounds like an implementation omission because the server's upper
layers have never needed it before now. If TCP already handles it, I'm
guessing it's going to be straightforward to fix.


>>> NFSD using DIO is optional. I thought the point was to get it as an
>>> available option so that _others_ could experiment and help categorize
>>> the benefits/pitfalls further?
>>
>> Yes, that is the point. But such experiments lose value if there is no
>> data collection plan to go with them.
> 
> Each user runs something they care about performing well and they
> measure the result.

That assumes the user will continue to use the debug interfaces, and
the particular implementation you've proposed, for the rest of time.
And that's not my plan at all.

If we, in the community, cannot reproduce that result, or cannot
understand what has been measured, or the measurement misses part or
most of the picture, of what value is that for us to decide whether and
how to proceed with promoting the mechanism from debug feature to
something with a long-term support lifetime and a documented ABI-stable
user interface?


> Literally the same thing as has been done for anything in Linux since
> it all started.  Nothing unicorn or bespoke here.

So let me ask this another way: What do we need users to measure to give
us good quality information about the page cache behavior and system
thrashing behavior you reported?

If a user asked you today "What should I measure to determine if this
mechanism is beneficial for my workload and healthy for my server" what
would you recommend?

For example: I can enable direct I/O on NFSD, but my workload is mostly
one or two clients doing kernel builds. The latency of NFS READs goes
up, but since a kernel build is not I/O bound and the client page caches
hide most of the increase, there is very little to show a measured
change.

So how should I assess and report the impact of NFSD doing direct I/O?

See -- users are not the only ones who are involved in this experiment;
and they will need guidance because we're not providing any
documentation for this feature.


>> If you would rather make this drive-by, then you'll have to realize
>> that you are requesting more than simple review from us. You'll have
>> to be content with the pace at which us overloaded maintainers can get
>> to the work.
> 
> I think I just experienced the mailing-list equivalent of the Detroit
> definition of "drive-by".  Good/bad news: you're a terrible shot.

The term "drive-by contribution" has a well-understood meaning in the
kernel community. If you are unfamiliar with it, I invite you to review
the mailing list archives. As always, no-one is shooting at you. If
anything, the drive-by contribution is aimed at me.

This year, Neil is not available and Jeff is working on client issues.
I will try to find some time to look at the svcrdma sendto path.


-- 
Chuck Lever

