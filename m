Return-Path: <linux-nfs+bounces-13398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96214B19CE1
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 09:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F3417767F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41669B672;
	Mon,  4 Aug 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpULk5wJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uUQJMhmn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F491FC104
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293585; cv=fail; b=Loe1WQq03grOoGNa3rVoaHXp1MDetApt8MX1urDACc3iBeY4htf2M0nM9Cm5TbhCrh4lqW5pyBjYXRXt7jS87RsspBw3vN4GWj/FeymplJmVMSmSeNPxc47l5Zj/Ltfd5ZPumzVWROEudvFWQrjK05mCWkLEia4FA/+mXzjc+u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293585; c=relaxed/simple;
	bh=6WG6tXzyqN8RNwl+qvGWw27uFOMEtPVD2hZnBm7uezc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5QGwdl0MPC0M8I7vHpBQ8KCAH8S177rx0vgBD1dxE3NpU3WMobzXVCFox5Km+v+k5ZJ1z5+LRaII7UJgIx3EmV8JCth4osVTjBT1siqwLJpmqS3G96EsOE8JfJYRO2l9YTxtL07ufCzdkTo0mJHbyiIGlLRg0QZBRkGJKktdss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hpULk5wJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uUQJMhmn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5747g7Pc025817;
	Mon, 4 Aug 2025 07:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=puK/WKLqpIadKsPaBIZMbdSCNKNr+khLEfyMARPisU4=; b=
	hpULk5wJhoRwZjR2i/oUR2YK5XealuTHw1opM3f5UANjup2n0e5xFoktTJJdYmvL
	uBv7/g6z39SuYRyIuNLKeN9jaMaGVAv24HvsK9Hba8WCrrQ7RVc3mlNiIydtS7Lv
	fPFMedlwkeN8Sxq/y/TTRD/FcXjSEf+QWcHv//pGPb9Wyfm4d8MKB6vaRibszMBK
	H1d9bSl9dNV9rd2G6KkiN7wRbjE3lQkPgIzNIov0bfmfFxXlTuF92mlw5zq0Q4fz
	c6YbELzZ1HJKfAbJe07dxbOZmrtWyGkw60KWNM2nSoDwE4NP/MSAfOCpGvX7YlO0
	RLzJ2s833e5MsGV0SymBww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899f4t26g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:46:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5746exWY014826;
	Mon, 4 Aug 2025 07:46:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q0b7vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpPa5mKT8WEf4AqPErxv7eXYJuWlv6zttB5n8Z/Ot/Y2wGhU28erSr7nCGJIy9uagYLDowRyFXAIyya8od/A7nsE+84RrDOeXHi6aK8TyceHRox4N771auG4HkmeSjrpz0JDtM1ZSwBWTy923aUXpEqKrTnMDFIfljJpxPmuUp0hs6Cfn2lY9iPhAMHLcKmFhgP9RUiqx7uAEKv158P16aJLPyp4AqBxDIWBDT9Jv8/qjXsHzb5C6HdjhEbEIxOgNMIMlejrTldkChNg+VEkzPNuPM5vhaiETiNgnKBrniNtXPs2sxxU2uRT7sNd5t1hTABRNPqpBFOPJbE6hH+Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puK/WKLqpIadKsPaBIZMbdSCNKNr+khLEfyMARPisU4=;
 b=FiTyyjKn93S7Y4FJst1y8q+cYMDQBEuSFWaoByOFPjknpJjY0cm0qwfRhOaF5nKTyZvbYcPdsWrFs8UB0HOVoeWcJ4Wfjm2WarU1wBw4P8+m2LFLng78pAnYDwLmNgG5ZbmXXss2FvU6fLyH7WQHoC64fNSnXnoMA49MXllYtB4ApMy2fSF1hTjSqGGvOJC+zHwKny8oFHhcx+h16gcEC15NhEPnjWxKk0oeC2y3ebKJjSB0+gHtMPzv2g2XzNcCZZlimBHypkYqE34uZg8M0IAgmy2FqwxFD1iyrLO8vIptsLRcbhNo0n+1sxsjEE9i5iOezRwLSQHXtc/nxj72Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puK/WKLqpIadKsPaBIZMbdSCNKNr+khLEfyMARPisU4=;
 b=uUQJMhmnMaX3/aJbH5MpyRCEn+lKmMa0gwTGdABbXqekZAmIu7iIXPcn4OAMjlFTiyYQ5gCX3U59+BBmH9wz5p95Ae3xMf3mwuXFznyMmwGe1XnO8Rd3uvswK3szKZcb1Ik9Pa4N6mWaelfYoaxGMBe5gKqwhcHZlXTYdMZsR/Y=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 07:46:01 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 07:46:01 +0000
Message-ID: <d0dbfba5-a323-4227-858e-94ecb364a0ea@oracle.com>
Date: Mon, 4 Aug 2025 13:15:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
To: NeilBrown <neil@brown.name>
Cc: Mark Brown <broonie@kernel.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
References: <> <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
 <175369525960.2234665.4427615634985880450@noble.neil.brown.name>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <175369525960.2234665.4427615634985880450@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fa1aa4-c7a2-4559-bbef-08ddd32af4a7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SnJjbUIzT2lOaFRWYzhRTzFLL0lnMGR4aU55NWhQUkZDN09TNmhYTVNZZ29K?=
 =?utf-8?B?bHF5UTd3T1NZVkV3SVNJeWZIVHhna1MvUFBsVlV3anRmd21NMlVsYm1mVm5P?=
 =?utf-8?B?Zk5tbFZ6R0F3MkZlNGpnZk5OVjFHWTFzZTNYemxwZGVJaTZZa3ZGSmFwTiti?=
 =?utf-8?B?WGIzZVVDZEdrZVo4Um1MYktLdnhFU0g0YnhmTXRBeVJhN0tsS243T0hzSjMr?=
 =?utf-8?B?aHVON24vMTAzU0xHZURCak54SnVIT0ZPaXNydWlWYUMvK2l0MTBwYTVGODBV?=
 =?utf-8?B?WlRpemhQMHhqckxXSjZWczZ3SnBsMXl1L0wvdWR6UXNUMFI1T25JYzMvZktZ?=
 =?utf-8?B?bU1Sd0V0OTJYYUM2VHY4SFhJM3NERU5zZHRtdEJKcUpnRHUrRUszSUFGYXQ3?=
 =?utf-8?B?ZWJ4N082TFlqbGphVnA1ZlZLb0l1bUdiTVZmVG5jOUc0ZW16MkxGVE1lYzNo?=
 =?utf-8?B?VTAvMS9aR3N3SmZXMHpvTUVsZDM3YklnQ0c2bTNXdi8rQ3BmOVF1enh5dnVM?=
 =?utf-8?B?cWlRWEVSeEhTSldFa0FUTWRCL1hiWlUzUkRadzNueXVibUhib3RIdXU3VFV1?=
 =?utf-8?B?ZURkSW5BZy9Yemk4Ty9FUkRER3BLYnkwWUtZY29XMUFNUWlaekRLaWdqY2Rj?=
 =?utf-8?B?Q1I3YkozblZCTk4vTyttL2J5U090TEVRcGNnRWk1cExFak1tR29YcHY2bVRv?=
 =?utf-8?B?UVEwZmsxcFVHZEJNZUhUcmtyUHBWNlNVSk4vVXllbnpHTGUzdjR4YUJvc1hB?=
 =?utf-8?B?Qlk1VktUa243UFlWbTE0c3JvOUlVb1dMV2JITEE3Wis5SHgrdjVqczBUWlZw?=
 =?utf-8?B?Zk5PemluUUg4aTY5bmVkbzdPYmxkeFA3REYrSnBzSTkyc3RvOUJyZVBVNWdr?=
 =?utf-8?B?VmswZzRJbE43U3VydEppS0NpUXNSUWk3NGpJSXNCclVReUo1MHZRQmRzUk56?=
 =?utf-8?B?MmJCU1RMWWpPWkphTkhVYk5CZWJ4VGpaY0ZEeHVyZlh0M3JtUmhpR1kvZHhY?=
 =?utf-8?B?N2wyNWM4VnVpdkJRV3htQlJGUmFhLzBxRUJLYkVoeWViTW5vRlJNNTJyRzVR?=
 =?utf-8?B?akZxbjZHQW1oc0JvZjZuVUhoaVhQdnJESEZlZGhKT012WW5ORDlwQVAyVkZ4?=
 =?utf-8?B?TmZwSnZEYllGbFBzbEFvZXdTT0ZyVkpEUWtiTGNwZ1VMSDlhUUJ0Z2JhZEJL?=
 =?utf-8?B?N0ZaZC9LdTYvVjQveThUU2lzNFVKOTIxVWJDU29GM3l1OXFDaklQQmRucnBo?=
 =?utf-8?B?VzdKWDFGWU04RlB3MmdYSllseERrRUQvVksrOStKVitOUHp1OXRPWnlBNXk3?=
 =?utf-8?B?VVBVc0dHNDh4dmxQVnIwbVpLcisvZXJOckhWZjJMbktrQ1NYenpFYzNkMUND?=
 =?utf-8?B?RHhDNlNsTEJzOFVlZWU1TEJidlBVeGYvWjM4RVd6S29aWUhEQldjN0F1SzFR?=
 =?utf-8?B?aGk3ekVhZDE1SnJTZlpIdVRtU1FtZWV1QUFmVHlNSFdTU2l4TjB0UUNJYkxt?=
 =?utf-8?B?Q1NFQldlWjIrVTk2N0xBUVN1ck5qQVEwM05aYUdSZXIyMzZ1NjByTEpMV3M4?=
 =?utf-8?B?cWw2L0JTdzAxZXJiTVdCNmp5YUw5NVhYTm14NlhCNzRYQUF3RkFnQkMzZDBQ?=
 =?utf-8?B?M1MvY201V2t6RGgvUGJONFZVM08zYWFpTU00Nk9ZSFpCUGtwTFNsbEttdjAr?=
 =?utf-8?B?cVp5QWxzdHBvZzhDSVNOR1lrbE9RNVZtVnJWWDdrZitKemZFcXJaUVErUklP?=
 =?utf-8?B?VmdtZTY5b3lXcC9MSjJ3azRVaDZjaFVTczRXUHVZcEtZU0VFUWx3NUU2YW1v?=
 =?utf-8?B?S0ZYU1lFOTNNMnNKSWVORWpkem9YblJHbFQxMXpzd2MyOG9wbCtUcE1lVmhw?=
 =?utf-8?B?bzRodlN4OER3Q1lneTB1b0hIZW1IRGdHTmJJVTR4Z0JlUU5WMlpIenQ3TFZ6?=
 =?utf-8?Q?DN/p16IBJ6s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RzdmQUYwdFFEN1ZoNng3WlNhbW0wenpqcUdVaGdhQkRNaVJ2UEgvQWRYTnJE?=
 =?utf-8?B?SldEQ1V6V3loaXpQaVZuMzMrWGo1UWRycDlBQ0tBYjYwWjBkZGE1L1AwTHVB?=
 =?utf-8?B?UFhWR1pNVlBSQ2xLRXd2N3hhOWNWR2Ewa0w1cElUblhueEZCaExVUnBmN1FT?=
 =?utf-8?B?cjY0UE13S0hpUHRjQU0vVGlmRHcrV3RTaXpjNndUNGs2RG9pdmM5aysvS3Vy?=
 =?utf-8?B?RkFTenJNd0VmMGdiaEl2bVhIUWtaOHJTb2pwbTBqS2VLbkdZWTdjNms1bEdT?=
 =?utf-8?B?Q0czek5iSTNhQWhDSkpOUThVTFdJOUlMVTZQZmtaWGlBK1BKWGZYZVFkT2E0?=
 =?utf-8?B?RlowUU4rbUVHOG9YekZUZHdaWDl0OS9QZm9KYW9tbHNrcHhTN09xRVhwb3I1?=
 =?utf-8?B?cGpHRHcrK2E0SENIMEloNHBaOEptRUY0bXd1L0p6QW5EYktBK1ZTem5xRXFo?=
 =?utf-8?B?bUFJcHB1dnlkdGtSeG5ZaXRNYldVZWJQTGZoV3lQV3hTNC95N3hJemtGZVQr?=
 =?utf-8?B?NWxYdHBUSDVLUzl4ZGpoak5aN1lTblRSam5jenVHWmNYb2oyVTBoL043eU1D?=
 =?utf-8?B?UnNNaXBERTZmTkVhOFdKenM0dVNoMUFZL1p6UVFEZUxjOHdLZW1CUGR4NzNY?=
 =?utf-8?B?RzBnc251dkpFT2lHMXE0Q0pNcklmSkFFZzNJSXNPc0ZBNWp2eWdkazhjaXlq?=
 =?utf-8?B?cmhoT1hmMEpnZmV3VkUvdVJaUkUyMXltYUcrbmZuY240SHZ0WWFDbVF4MmpK?=
 =?utf-8?B?T2UwMU1PdVZiNHlzcTNnZzZqbGp3UnFPK2lpaTFaTEJ0UThESTlVTm5MOHVs?=
 =?utf-8?B?U1o1L2s1TE5IYk5teE9MWXh3RFByd0pHMmxvMFN6dTQxK3htZXVhUU1wQnVo?=
 =?utf-8?B?dml5Q1V2R05Yd2QvbEl6dHdEZjJFNXQreUdrVVFxRHM0SFRmS3RsWnZLaWlo?=
 =?utf-8?B?QURheVFzcEpabldwS1p1TE84RDlrL0V4UmRxNTczQ09OOWZQNHZkZjF0bkY2?=
 =?utf-8?B?c295ckJTaDl4ZUxzMUlTeVl4NnR2RlpCRFQwaE9SMGhlYmtBanBPM0VGSm1Q?=
 =?utf-8?B?Q0ZPMEJMaCtYWGU3RDNYOHNMbUhqcS94dGVLOURwS3d5QWJwYXZwZVdLM1pn?=
 =?utf-8?B?a2JPTjhtdmF5ZUczYXJrdTQvVTBITE1hcHNQYUxPTlVKUm5NV3RJdXZZbkoz?=
 =?utf-8?B?N2UvQS9jWUJFMGM5azB0V1RKTjBTNlVUSWcybEhWakVJQS9MdmRLbklaeHov?=
 =?utf-8?B?YXRWK2hUajhjbExRYkxlcmk2bE5GTXJ5N2RPYlNxOExFYnNXU05HdXp3VGpv?=
 =?utf-8?B?K09VUHVXSFlIV0gxTjFzcHJhL1RIYWFFRDlZT2Vsc0c2M25pL3k4UDFtVTZF?=
 =?utf-8?B?ZTUxYnJuWjRZNVVzWDljSURBUGlYZTc5a0xId0JaNzNEZDRoc2pVRzQrUThv?=
 =?utf-8?B?dERRU1pZR2pjMk1GZUQweFo2VTd0VGI2MlRJMjQ2bGNENkFlRkJ2R0lLNWs2?=
 =?utf-8?B?YmtGK2p3bmpuV2ZqdFg2czZTUDh2QldZRHFKOHBQMmNndjMwdFMzcW9SY3hZ?=
 =?utf-8?B?ZmwxZEEvZnNReitDelhRcllXbm50L001M2kzTXh0ZitkRURJY1lVVmNGT2tV?=
 =?utf-8?B?VE9KWFNLR0pyTUtMNlNLODJuMzhtQVc5enNZZlFNdVdEaHVnZDlQK2lMYWxt?=
 =?utf-8?B?OFBQVlVYN1BUTkdhRVk5TnhsdjBKZll1cEFVZGhKS0FzaFBIdmsweTR0MHdp?=
 =?utf-8?B?SWc3VU55Ny9IS1NYSTlqWFZ2TDlFY0llZ1l0NUwrcGY2UDA4WXVIKzVzZnkx?=
 =?utf-8?B?cVhCSFFqOFNBTkhkbFV2YlpJdXZUUXJ5UkdYQVMwQ29Pd25wUUVLWGxDTnlQ?=
 =?utf-8?B?L3FGV1RRck9UbjFSME16MEo0RHlzZ1B2dFo5WHN6SFBGUjRIYnBGem1HVG1j?=
 =?utf-8?B?TUtVY1RxWDB4YXRNRmJRZm1mUXJxTk5IMFhPc2x5bnUxUnZsSGZuSzZtd0Rh?=
 =?utf-8?B?alpZMzZlbDFGN2xnZk5ITGo0L2c0N2N3UmlBUVExN1RwUitCWjZyVm1QVmJ5?=
 =?utf-8?B?d0l5L2NwK1phbjhQNWZ5VmpMSG5DdWRwT0hhQ1Z6WGtReDlaWHBRU1loRmts?=
 =?utf-8?B?MmJxVTNXNVQrVWoyWWNVYjZnMERLaG9TcUF2NE9RcTRyZllBVkQzTk1ZaGY5?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D8D5ubEdJGtHZ0toJ8Nndr0PSis1xmlRWhKdYMylTA2ey25DHhJajfcmX8fk1GxHYgooyhHa4IY84XMh9CvBSi8SvXeTWV7JW9APAt94h5QZBolaNoAtDONi4l+/oZdoXTittVK7nwB+ccpoD30ztX0AaGjqZVXYtGTmKGOCSgsz1xFJ06V04rGo9KrakFbejytZLEUiCSYI8LakGkr+r8jKZQItMdKPzoGT0r3RWNwqIWPsnFTveef7ZU6UssOl3ULbr7Ag0mKpbkpT6C/m54d4ypsuCXaPdGUYJTmVuS6X6U5HEDGWz5gVp8K2GRTqomJQXqnPrfkmkVd2/qLJSVLzlMbewfqT5a3s6041nN5ufWDQArKoh7ANW/9sgjM4nFMx2qS//PvD14VMVdarwDoXFm/WYNnV2bwNHSIPRs1jYzpPBzW0Qfw/kv2Q5UhJIrjrbtogDw1ZF5w6Mc0L7whJvjNZQtMQq3S1oz6kvx86wrFoCZYJq6taYPWarwLLzJCVbb6mvHZC2s1wmBgB6PbrGpDGEb1Lw4O25n+OFpKc4ibG1B9Xwcc5qGBWSMm6EPNl65aa96s0s6zvEDDVTHuhw7xw7tMlIQKh7XCGowE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fa1aa4-c7a2-4559-bbef-08ddd32af4a7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 07:46:01.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRMONWBK3DxC+GNPF7hXifeSEuN4FMBmKkfqwh08h/mLWYWS/ShPFwB4nsPuu/BP1DelHT6gCphxeAgB0h8PFGxSU8WHG7cY1VSwWlSLt+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040040
X-Proofpoint-ORIG-GUID: jiOBPi6C-yOpFqoYW392pnVM2X4WDomq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0MSBTYWx0ZWRfX86Mm94muJzE+
 L5yhvKwKdb3bwKrUvH4643qVj5atStI17xNv7UjvUWXiHGb7GTATpKC6jclquyk13ma9VI1tKVz
 bRae1Akc3Dmo0QFHtiW+yanTx72pjDD3Z295Ln2hvN2wGKqGG1bh6Y3eTtjWQ9QqqjeqKnce41T
 eosy4zm1MPC1tPADzulWA0rZYxnMne0oIRJclAm0omyJiHlbDOBSU+gvSeWqpjkTzxE4IqTuSMf
 4K6U/eEtWVbawOHNqLZY2qjNF41fDmfU8CFh2n43wYe6Nvj/ioE6DdET6Hqa0HaQ616OnxZ5ezp
 WEoHk5su44VJiI3peiyUp9EoL7m8pUDKz14iNLZzxT0jgqFu8Fup6YnUqP/5V8nl09yGfvFaf5U
 qP8WClt3AArxOR6sTGt+h5SSzGkaSe3CxxQHttVpy5v2cTxvng713OJRVvZSBQi8g04mXoq4
X-Proofpoint-GUID: jiOBPi6C-yOpFqoYW392pnVM2X4WDomq
X-Authority-Analysis: v=2.4 cv=daaA3WXe c=1 sm=1 tr=0 ts=6890653f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8
 a=d20udnw3IuhoANM5FS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12066


On 28/07/25 3:04 PM, NeilBrown wrote:
> On Mon, 28 Jul 2025, Harshvardhan Jha wrote:
>> On 27/07/25 10:20 AM, NeilBrown wrote:
>>> On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
>>>> On 23/07/25 1:37 PM, NeilBrown wrote:
>>>>> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
>>>>>> On 08/04/25 4:01 PM, Mark Brown wrote:
>>>>>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>
>>>>>>>> Once a task calls exit_signals() it can no longer be signalled. So do
>>>>>>>> not allow it to do killable waits.
>>>>>>> We're seeing the LTP acct02 test failing in kernels with this patch
>>>>>>> applied, testing on systems with NFS root filesystems:
>>>>>>>
>>>>>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>>>>>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
>>>>>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>>>>>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
>>>>>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
>>>>>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
>>>>>>> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
>>>>>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
>>>>>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
>>>>> It seems that the acct02 process got logged..
>>>>> Maybe the vfork attempt (trying to run acct02_helper) got half way an
>>>>> aborted.
>>>>> It got far enough that accounting got interested.
>>>>> It didn't get far enough to update the ppid.
>>>>> I'd be surprised if that were even possible....
>>>>>
>>>>> If you would like to help debug this, changing the
>>>>>
>>>>> +       if (unlikely(current->flags & PF_EXITING))
>>>>>
>>>>> to
>>>>>
>>>>> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
>>>>>
>>>>> would provide stack traces so we can wee where -EINTR is actually being
>>>>> returned.  That should provide some hints.
>>>>>
>>>>> NeilBrown
>>>> Hi Neil,
>>>>
>>>> Upon this addition I got this in the logs
>>> Thanks for testing.  Was there anything new in the kernel logs?  I was
>>> expecting a WARNING message followed by a "Call Trace".
>>>
>>> If there wasn't, then this patch cannot have caused the problem.
>>> If there was, then I need to see it.
>>>
>>> Thanks,
>>> NeilBrown
>> This is what the dmesg contains:
>>
>> [  678.814887] LTP: starting acct02
>> [  679.831232] ------------[ cut here ]------------
>> [  679.833500] WARNING: CPU: 6 PID: 88930 at net/sunrpc/sched.c:279
>> rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>> [  679.837308] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs
>> netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
>> grace loop nft_redir ipt_REJECT xt_comment xt_owner nft_compat
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib rfkill nft_reject_inet
>> nf_reject_
>> ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 ip_set cuse vfat fat intel_rapl_msr
>> intel_rapl_common kvm_amd ccp kvm drm_shmem_helper irqbypass i2c_piix4
>> drm_kms_helper pcspkr pvpanic_mmio i2c_smbus pvpanic drm fuse xfs
>> crc32c_generic
>>  nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth sd_mod
>> virtio_net sg net_failover virtio_scsi failover ata_generic pata_acpi
>> ata_piix ghash_clmulni_intel libata sha512_ssse3 virtio_pci sha256_ssse3
>> virtio_pci_legacy_dev sha1_ssse3 virtio_pci_modern_dev serio_raw
>> dm_multipath btrfs
>>  blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror
>> dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls
>> cxgb3i cxgb3 mdio libcxgbi libcxgb
>> [  679.837524]  qla4xxx iscsi_tcp libiscsi_tcp libiscsi
>> scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs qemu_fw_cfg aesni_intel
>> crypto_simd cryptd [last unloaded: kheaders]
>> [  679.873316] CPU: 6 UID: 0 PID: 88930 Comm: acct02_helper Kdump:
>> loaded Not tainted 6.15.8-1.el9.rc2.x86_64 #1 PREEMPT(voluntary)
>> [  679.877769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.6.4 02/27/2023
>> [  679.880782] RIP: 0010:rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>> [  679.883189] Code: 01 b8 00 fe ff ff 75 d5 48 8b 85 48 0d 00 00 5b 5d
>> 48 c1 e8 08 83 e0 01 f7 d8 19 c0 25 00 fe ff ff 31 d2 31 f6 e9 8a e6 c4
>> d4 <0f> 0b b8 fc ff ff ff 5b 5d 31 d2 31 f6 e9 78 e6 c4 d4 0f 1f 84 00
>> [  679.889976] RSP: 0018:ffffaf47811a7770 EFLAGS: 00010202
>> [  679.892196] RAX: ffff97be48e00330 RBX: ffffaf47811a77c0 RCX:
>> 0000000000000000
>> [  679.894978] RDX: 0000000000000001 RSI: 0000000000002102 RDI:
>> ffffaf47811a77c0
>> [  679.897786] RBP: ffff97be61588000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [  679.900600] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000002102
>> [  679.903432] R13: ffffffff96408ea0 R14: ffffaf47811a77d8 R15:
>> ffffffffc07568e0
>> [  679.906233] FS:  00007fc2563f8600(0000) GS:ffff97c5c890f000(0000)
>> knlGS:0000000000000000
>> [  679.909289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  679.911736] CR2: 00007fc2561fba70 CR3: 00000003bce3a000 CR4:
>> 00000000003506f0
>> [  679.914555] Call Trace:
>> [  679.915918]  <TASK>
>> [  679.917215]  __wait_on_bit+0x31/0xa0
>> [  679.918932]  out_of_line_wait_on_bit+0x93/0xc0
>> [  679.920914]  ? __pfx_wake_bit_function+0x10/0x10
>> [  679.922944]  __rpc_execute+0x109/0x310 [sunrpc]
>> [  679.925024]  rpc_execute+0x137/0x160 [sunrpc]
>> [  679.927020]  rpc_run_task+0x107/0x170 [sunrpc]
>> [  679.929032]  nfs4_call_sync_sequence+0x74/0xc0 [nfsv4]
>> [  679.931319]  _nfs4_proc_statfs+0xc7/0x100 [nfsv4]
>> [  679.933520]  ? srso_return_thunk+0x5/0x5f
>> [  679.935391]  nfs4_proc_statfs+0x6b/0xb0 [nfsv4]
>> [  679.937367]  nfs_statfs+0x7e/0x1e0 [nfs]
>> [  679.939138]  statfs_by_dentry+0x67/0xa0
>> [  679.940887]  vfs_statfs+0x1c/0x40
>> [  679.942596]  check_free_space+0x71/0x110
> Thanks.  I'm not sure why this causes a problem as if vfs_statfs() fail,
> check_free_space() assumes there is still free space.
> However it does strongly suggest that we still need to NFS to work in
> processes where signals have been shutdown.
>
> Could you change rpc_wait_bit_killable() to be the following and retest?
> I intention is that when the process is exiting, we wait up to 5 seconds
> for each request and then fail.  It's a bit ugly, but it is a rather
> strange situation.  It blocking forever that we really want to avoid
> here, not blocking at all.
>
> Thanks,
> NeilBrown
>
>
> static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
> {
> 	if (unlikely(current->flags & PF_EXITING)) {
> 		if (schedule_timeout(5*HZ) > 0)
> 			/* timed out */
> 			return 0;
> 		return -EINTR;
> 	}
> 	schedule();
> 	if (signal_pending_state(mode, current))
> 		return -ERESTARTSYS;
> 	return 0;
> }

Adding this change makes the test pass:

<<<test_start>>>
tag=acct02 stime=1754066481
cmdline="acct02"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-lNzAk1qhuX/LTP_accZ75zl1 as tmpdir (nfs filesystem)
tst_test.c:2004: TINFO: LTP version: 20250530-128-g6505f9e29
tst_test.c:2007: TINFO: Tested kernel: 6.15.8-master.sunrpc.el9.rc3.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Jul 29 05:06:28 PDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
acct02.c:238: TINFO: Verifying using 'struct acct_v3'
acct02.c:191: TINFO: == entry 1 ==
acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('iscsiadm')
acct02.c:131: TINFO: ac_exitcode != 32768 (5376)
acct02.c:139: TINFO: ac_ppid != 52326 (2475)
acct02.c:191: TINFO: == entry 2 ==
acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd')
acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1065/100: 10.00)
acct02.c:131: TINFO: ac_exitcode != 32768 (0)
acct02.c:139: TINFO: ac_ppid != 52326 (1)
acct02.c:191: TINFO: == entry 3 ==
acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('(sd-pam)')
acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1062/100: 10.00)
acct02.c:131: TINFO: ac_exitcode != 32768 (9)
acct02.c:139: TINFO: ac_ppid != 52326 (1)
acct02.c:191: TINFO: == entry 4 ==
acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd-user-ru')
acct02.c:131: TINFO: ac_exitcode != 32768 (0)
acct02.c:139: TINFO: ac_ppid != 52326 (1)
acct02.c:191: TINFO: == entry 5 ==
acct02.c:202: TINFO: Number of accounting file entries tested: 5
acct02.c:208: TPASS: acct() wrote correct file contents!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Thanks & Regards,
Harshvardhan


>
>> [  679.944433]  acct_write_process+0x45/0x180
>> [  679.946313]  acct_process+0xff/0x180
>> [  679.948003]  do_exit+0x216/0x480
>> [  679.949799]  ? srso_return_thunk+0x5/0x5f
>> [  679.951621]  do_group_exit+0x30/0x80
>> [  679.953329]  __x64_sys_exit_group+0x18/0x20
>> [  679.955217]  x64_sys_call+0xfdb/0x14f0
>> [  679.956971]  do_syscall_64+0x82/0x7a0
>> [  679.958717]  ? srso_return_thunk+0x5/0x5f
>> [  679.960550]  ? ___pte_offset_map+0x1b/0x1a0
>> [  679.962434]  ? srso_return_thunk+0x5/0x5f
>> [  679.964261]  ? __alloc_frozen_pages_noprof+0x18d/0x340
>> [  679.966389]  ? srso_return_thunk+0x5/0x5f
>> [  679.968183]  ? srso_return_thunk+0x5/0x5f
>> [  679.969945]  ? __mod_memcg_lruvec_state+0xb6/0x1b0
>> [  679.971977]  ? srso_return_thunk+0x5/0x5f
>> [  679.973690]  ? __lruvec_stat_mod_folio+0x83/0xd0
>> [  679.975671]  ? srso_return_thunk+0x5/0x5f
>> [  679.977392]  ? srso_return_thunk+0x5/0x5f
>> [  679.979079]  ? set_ptes.isra.0+0x36/0x90
>> [  679.980771]  ? srso_return_thunk+0x5/0x5f
>> [  679.982375]  ? srso_return_thunk+0x5/0x5f
>> [  679.984052]  ? wp_page_copy+0x333/0x730
>> [  679.985648]  ? srso_return_thunk+0x5/0x5f
>> [  679.987220]  ? __handle_mm_fault+0x397/0x6f0
>> [  679.988818]  ? srso_return_thunk+0x5/0x5f
>> [  679.990411]  ? __count_memcg_events+0xbb/0x150
>> [  679.992111]  ? srso_return_thunk+0x5/0x5f
>> [  679.993689]  ? count_memcg_events.constprop.0+0x26/0x50
>> [  679.995590]  ? srso_return_thunk+0x5/0x5f
>> [  679.997177]  ? handle_mm_fault+0x245/0x350
>> [  679.998807]  ? srso_return_thunk+0x5/0x5f
>> [  680.000339]  ? do_user_addr_fault+0x221/0x690
>> [  680.002042]  ? srso_return_thunk+0x5/0x5f
>> [  680.003553]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xd0
>> [  680.005643]  ? srso_return_thunk+0x5/0x5f
>> [  680.007202]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  680.009025] RIP: 0033:0x7fc2560d985d
>> [  680.010510] Code: Unable to access opcode bytes at 0x7fc2560d9833.
>> [  680.012660] RSP: 002b:00007ffde591df68 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000e7
>> [  680.015355] RAX: ffffffffffffffda RBX: 00007fc2561f59e0 RCX:
>> 00007fc2560d985d
>> [  680.017749] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
>> 0000000000000080
>> [  680.020292] RBP: 0000000000000080 R08: 0000000000000000 R09:
>> 0000000000000020
>> [  680.022729] R10: 00007ffde591de10 R11: 0000000000000246 R12:
>> 00007fc2561f59e0
>> [  680.025174] R13: 00007fc2561faf20 R14: 0000000000000001 R15:
>> 00007fc2561faf08
>> [  680.027593]  </TASK>
>> [  680.028661] ---[ end trace 0000000000000000 ]---
>>
>>
>> Thanks & Regards,
>> Harshvardhan
>>
>>>> <<<test_start>>>
>>>> tag=acct02 stime=1753444172
>>>> cmdline="acct02"
>>>> contacts=""
>>>> analysis=exit
>>>> <<<test_output>>>
>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
>>>> tmpdir (nfs filesystem)
>>>> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
>>>> tst_test.c:2007: TINFO: Tested kernel:
>>>> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
>>>> 02:03:04 PDT 2025 x86_64
>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
>>>> acct02.c:191: TINFO: == entry 1 ==
>>>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>>>> acct02.c:139: TINFO: ac_ppid != 88929 (88928)
>>>> acct02.c:181: TFAIL: end of file reached
>>>>
>>>> HINT: You _MAY_ be missing kernel fixes:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
>>>>
>>>> Summary:
>>>> passed   0
>>>> failed   1
>>>> broken   0
>>>> skipped  0
>>>> warnings 0
>>>> incrementing stop
>>>> <<<execution_status>>>
>>>> initiation_status="ok"
>>>> duration=1 termination_type=exited termination_id=1 corefile=no
>>>> cutime=0 cstime=20
>>>>
>>>> <<<test_end>>>
>>>>
>>>>
>>>> Thanks & Regards,
>>>>
>>>> Harshvardhan

