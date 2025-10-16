Return-Path: <linux-nfs+bounces-15303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1231BE501E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BED084E107D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5948223DD1;
	Thu, 16 Oct 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdFP2apV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1CG7LUv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57243346AA;
	Thu, 16 Oct 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638368; cv=fail; b=G83NanYXwE/YyP51fkyX+N8XqiFnsJ/myDMRt0lhr+A+/qaLzmBgJoiQI/bet0ehCSVpgucFwB6DVhYpzJYDbo1DlVCA12DNe2AOwu6xKvFGs8WrHPegX9SHPQxkVkAw0DgP9pmEeiL3FrBeZ3we0w2jMQZQxm3zDX0menHlbOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638368; c=relaxed/simple;
	bh=l3hReo9SjcsZOn4NkSjbmO4tOpgh4hvdQhBQdBqJtbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lS8VlgvfZhnqu7x+AoFITk5E7oynjNFv4i/N1EACZ4Z96BvZLravowIgWNH4ROoa3nBCM5Xkmawq52a/uvi5IdC66XbeaH6pE2JFvXIJVOs91+g3CEi66wiHZYq8OcI5/NYjPCUz2njIS4jW138ChiEG8G2x1WMqhE98UjlLRHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdFP2apV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1CG7LUv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GH6ABn002454;
	Thu, 16 Oct 2025 18:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rpBTFoiav9cybwZYpNHl08aex47mD4BUExQdb4vp2MM=; b=
	kdFP2apVVxQ66HgxqQEUFTJvudCwB7Uv3Vt9hskwhKdF/Daiakyv0Xswl0z6VbDu
	Us7jZP2eeJyETO519jqQ6RsOUBtLm4e6V0eSwIl27R/n+o1w61E9Fp37nKC2+3+r
	5o3Tk6pHzGbLHgLu9aC5DPbPvw4lvDgDDVG5siLI4RQx4EhTFzzFK4M7QtTpLTbM
	Ok0n68JAM7ozZOBWffLU3+a/VVCKFmjCot4+3pndiJqvsfiFhiDKwfKQYSk3wzOj
	AlDGsazaJeLbLEsI09nJ9y/iZnK/dsCtpnxPPJXR0w7CGtiObPS5b4ivIee9h3cH
	1WWZOr+enqt6b6puzuHFVA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59hhx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 18:12:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHMha4017926;
	Thu, 16 Oct 2025 18:12:38 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbt8ah-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 18:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB2w8ncz/9Q6LmAvhVmH2R3eSwSx2+K4bQG8HHgUfWCaEIy8g0WC/vEwd0LxHIH8ezIMgPPYTP7lfxJspXul5z14Dt8Me1AzuX35R+0cVrF67YvrbAVNYvAMXRnHne/dMMA4MP9IqrO/6xdreFWOS2R8qZho0Rdgm1KJ8SqFwNqTc/8K8RgrV35sm+dbXlgnf1WOBU+dgn7v8dR8hTfqEk+/vG7BVLrcfnn6j/5k98r/L21ROGc0aDUgy1PSorzBvu2a424OjnbWzjIhB8eJsuF4dlSuI21K2+NgyJYkjlEVZHUpvz7hmDqnwOIvz2D5QaPQ7yPT/Defag5FJqL1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpBTFoiav9cybwZYpNHl08aex47mD4BUExQdb4vp2MM=;
 b=JLuPKTcupeDBe2BcmS76V5qfCZWzY70KnIiuIZkhHzr9JRdG4+XzjZ/ohzSDBuNqfCe2h0CpZiTAaaeck6u8YnxnbYSjKyvI5Ew1iYzX/8v1VWLU1dkIBN5V/y5Kf2N60IVnM/MtkFNcCZxrQD6cWDTUygDUzgdACqqGMQmgGgWu/zEnH4NOpgF+lPC9vaPeDYZoSmPhRxFJoQXPRHKtpWB17kI8mXwZBMGKxZ4X9t2kCpmfn228mdPJfW/X/2bui2B5bPJI1vouH5uX1Soc4SB6OgztBEf3feUah29k7Z5vtVbresv5nCUU1Em3XESDLgSbsdpzcPSEeUCEua0mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpBTFoiav9cybwZYpNHl08aex47mD4BUExQdb4vp2MM=;
 b=Y1CG7LUv6/L8o1A8NLVMeNiN7zXssfzyCm1u7nbF7oQPwjT/DQvEIhnwtpn5ndVA6Sl40ZQPhGwwl54Q1BAt+8eFXBMvITjI0OKDqtAAGuBFt3FqWQ9eVW17p/VcplgOY5CjnnCatRjyyPkTpbE0SKwoIR0Vnzh56gHrHb9aU4E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 18:12:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 18:12:34 +0000
Message-ID: <3d9a347d-4929-4d78-936b-30f55fe65d18@oracle.com>
Date: Thu, 16 Oct 2025 14:12:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
 <20251012170018.GA1609@sol> <d85b364d-b7d6-4893-b0eb-3df58ef45ce0@oracle.com>
 <20251016180702.GD1575@sol>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251016180702.GD1575@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 510b12ca-d5de-4347-b716-08de0cdf9486
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UnhxeDlIMmc2b1hubU9jN3I5cXdNMDFXMzBCREtOaXVKaU9XMGNjNm1wdG9K?=
 =?utf-8?B?cWhORUN6enllMGlJSFNiTFhjMU1iWWVFYjVmSHhsWTRtTk1Za2tXQys4Wkc0?=
 =?utf-8?B?ckhuWDF0SkJHa0NUaEJ2VXdYQzRwV1BZZnBJWjRsbXdOSGxFODNWbTFwS25m?=
 =?utf-8?B?TmppZjg4YWFhZUNBaGxzbStKM2tiejZNMmpHZnkvUDNZdWVoVWovZ2RvYml4?=
 =?utf-8?B?RVhGOXEycHBCMTlqUzhDMlFpbHFNUGhIMnZqTlFEdGFHcWZFWk9reUU4Z1U1?=
 =?utf-8?B?UU1QZlBHellGdWRreEtlVFFEOTJUNFoybmJiRlpmbFNtRTRnRTlJOFp3U0Nq?=
 =?utf-8?B?bGN4ekJneE9tUEw0RDFnM3dUbG1yaFhad1RRRzNiOGhRUkJjRy9aWlRSbXZP?=
 =?utf-8?B?TjFlL2NMQ0xablUrc1IwRGdydkxLUDR4bEc5UytPN01OamtTemRac0lDM2ZI?=
 =?utf-8?B?cHVBc1ZNbHVzaFZDWkxXZHMzYi9HN1M3WXBWWERuU2pBZUR6K2hjUnR2WU5W?=
 =?utf-8?B?UEJlWFlGVzk5WDFtby9Nck9EczFFN056MnRQSTJIOWk0Ui81WnJhRUdLbGI2?=
 =?utf-8?B?bFZGa2lVMDA4YnVBb1BpTjhsd3BqZW04YUMraTBRaXFlSC9CeDlZM21lYTJq?=
 =?utf-8?B?dE9QYmFpRll6MDA1Wjd2cWEvdVFlZ2NJaGZTU0dVRkk0aWgvN1hldnBHOWdO?=
 =?utf-8?B?Mjg0NjQ4M2JPbkZjVzlsWWNMdFFNQks3S2ZhbitjZ0RBenBjKzVJYVhDbHdo?=
 =?utf-8?B?c0VkRGFERERxdTMzZXU2T0xLYXQwdFZHaEwrbUFjZUUzeERMZTRzWnNvY0tk?=
 =?utf-8?B?dlZuZkVEYWRFK1hLamQrcXlPaDB3bllpVnRYaEV4MWpKLzZLbE52WENCcmZS?=
 =?utf-8?B?Qkw2K2ZPRlB2RGdjYThlUk40OUxTcmM2eHpQUFZONkVGYWkraFVZSUNJbzdw?=
 =?utf-8?B?Y0xMTzloUEJVczV0SjV2YmRzdGlkVitQRlViVE1tdTNhZEJrcHVmTXpVVndI?=
 =?utf-8?B?WGZOY0doQzFybGpJWVJOR0tVbHYybVVJMUtDdVY4TFFrY2FHY2Erbnc0ZWFW?=
 =?utf-8?B?cDFoZjVCcy9GM05EUlVmNmdRYllYbi9vQnQrWmNIM3VRVHBrWlVrNnhJL1JC?=
 =?utf-8?B?bmhDbFB0a3BKT2owWHM2Wm5ONmJtU2JMT0VDbEpkMUo4Q25vckxtdWNZWnZm?=
 =?utf-8?B?MTJ4b2gwSkhuWkpWQnAyNVJLY1I4RnJhQ2hkWGloN1RhNXdJYW9rN0dvYkNy?=
 =?utf-8?B?V3V2WHlNUFg1UlhGVlNUYlU3a1pxSGFjR3pYV3RzSjVoTEpsWkFjaDVaeWc2?=
 =?utf-8?B?cDgzWVR0QjZTR2pSeVQwa05BTU1qWjM1bzFKdGE2ZkpURlB6YXFISGdLZFgr?=
 =?utf-8?B?b0RVVlJNMEJlOHNXK0hPTjZVaGlNaGRlbUZ6M1NFSXdONW9ycDkrZnE0SVcx?=
 =?utf-8?B?aGp1QUNLTHJoeGdoUlJEcWlucGV6bjVnSWJEQzBLbzJuRm1tZXV1WjhDQjhQ?=
 =?utf-8?B?dVBXamd4Q0taanNIeFlpeG9zemFXNGFsSWpDOTZubjRYSTFYQWp4eTRGQU9O?=
 =?utf-8?B?dFlSbXNzTW5jQ2gzOWRJQzRiV1k4ZUorOUlQSkIyaHR4cGJ5dnE3RmhsUUtO?=
 =?utf-8?B?NGdDYzdCZ1F2MFhiVFdPb1Vpa2d1UXZPT09vTWNkVGRlS3kvVzZxcmFWRDMz?=
 =?utf-8?B?KzZOV1l0WlVhTmE5ZS9Oa0xCVk9VNTgvSzJHenZITVU5N1g0L2hMN2Iyb1Ji?=
 =?utf-8?B?WEtlWFMvMUJMd01qTlA5UW9SOGllTWFwdU04V2U3clZFMGJrUDhRY0hKWkUx?=
 =?utf-8?B?WnJNRXB6czJuQ2NHK21YckE2SERZdDNUblZOMXBKNCtBd1VwWlN4d1FhTm8w?=
 =?utf-8?B?aHVyRW14TWNPSTBCV05LaWV2VmFsd2xBak81a0pkcWg1NUhMSCt0cWFNOFRN?=
 =?utf-8?Q?Mc71HHhjy8/Di02iVPYKg9smmfZ+a1UA?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cFVUMURqSjRWS3VxUi9tNFRueGlzY3pEcTdsOEljQURucVhYbzJheldYVHg4?=
 =?utf-8?B?aEhyaFJ5OUxDSUVzOGpDOG5lUDhnUWJBLzJRak00OVJWOUxCdTFwMEsrdTVm?=
 =?utf-8?B?MDZFUlpxYWo2T3JLWS9aWGlGbHdPbThFbWVScHVmdXFCYWN0OGRNMUtPRExa?=
 =?utf-8?B?TGlacGVJdXJiN0xHWDdFYWd2cXc0ZG1WOXhIcUdSbk9zQytCVWtVak1saTdT?=
 =?utf-8?B?QUw1N2lvTGdOZU8vMU1pdmdYRkVJVmFONkVtMUs1NFAvTTY4b1lGdU1OREU1?=
 =?utf-8?B?VDdodHhIcG5tbHpTMVBvMnowWXJMZHdnanZyOEJXUWZMbTIyaEtyTHVmalRz?=
 =?utf-8?B?eS9kOXJlZlA4cTdKdFJVQW9STHJETG5yY1k4RloxVTVvMXhZdGVVTzVLSlUx?=
 =?utf-8?B?d04rWFBNUlBHWVc2WE8za1dCeitWZXROckJXUWtBTjNBSmJkbHhRaTZtaVNW?=
 =?utf-8?B?S3QyVlIxcFdyMUNSL0VXYTIyNnI5TEJKWjdTUHV0RWZHK1hYcUJ3SGw3ODVl?=
 =?utf-8?B?bDFZanhDTjg2dXZaNUpnOE9uN3N6Ni94YS9aVGxVaFRON1ROajlPaS81ZEZD?=
 =?utf-8?B?dlB4MVBpRU1BZngxb0VsZXZtdUVJcjZ3ckNVZVpBVG1zV1liWkJoMDdNQzdS?=
 =?utf-8?B?QXpNY2Jjck9GNExlUE9adDZOWkp0ZjRlMWNESHdTcDREaTVuQ0lRYkNxNkNZ?=
 =?utf-8?B?eVVsNFhLQzIreitXVHNtZ2NHZmFZMWdkLytQd1dxTStGMnlXWDJiS0k4cE9B?=
 =?utf-8?B?TUhsTVkxRmZ5WmlIc0JRcEZJcXJ5dENjRHVIWGpXb1FQNWhZdEJwdjl4MklQ?=
 =?utf-8?B?Q1YvNXR5aTFUMUJsMWQ3UHFRcXRkdDVPUkxUNVNpaG1odVJHNFhBVlFHN09y?=
 =?utf-8?B?ekozelEwTzZRZmhJVmVMNmdyM1o3Y2FNbmt3bnExbWZlbnFYRmlxL2NmODBZ?=
 =?utf-8?B?TERNUkMydFNwNlA2VDluckdMNDE2azdocGFnT1NEOERrenNPRHU4UEtydDVS?=
 =?utf-8?B?WU9sdmEwc0dFVDVTMjdvOUlzc3k2K3NFWk5JSUhHODdGT29oVWlNUndMZmdh?=
 =?utf-8?B?TXk2MlZBZUlpaDRSN3hPL0pqbkNYdmFFNVBjVllmbjdWS1BsWUFDelBWbEJN?=
 =?utf-8?B?R1hNTUNQampPbHErZndETUN5VjdEdUZwd0dOWWdaK1NySkR5QXkrUDJCV3pT?=
 =?utf-8?B?eXdNQ0VOT0M3WVlnblpxcDJvcGdxR3FXdWZLNHJqaTR6dVBZT0FZQ2dJRUR0?=
 =?utf-8?B?ZWxsZGg3UUljUjFPTExCVnNvTm13Y01SOW5SL3hBeFBrcVpIcytFNmRHTTg1?=
 =?utf-8?B?RjYyd2xFUmJoNmMyeGpDdVl6QUVXaWtnLytkbWtMVEtVbHVRdnRFZkZVQVpL?=
 =?utf-8?B?dWVnRkx1MnpzUHFabjY3MGpxS2JWNzdmSXRJMnkzQVdrank5YWJLVUVUWHNU?=
 =?utf-8?B?dWo4ekNpc2M5NWxWNzc1dVdiOXdiREt3UHAwY2VocmZYZ1NxTmlaUXhZMncr?=
 =?utf-8?B?YWdwQWNWN21xaSthY1pLbkJCdHRsbzc2K2VOSUZaOHJwMmpiMjF4NVRjWTFa?=
 =?utf-8?B?YVV4U3NxRW9ZanEwNlQ1RUxLMTBudXhFTXczcHJqejNHMk44VU9lcFFIdWRW?=
 =?utf-8?B?bXdWQ3E5N2FaUVNkTmRzUExsM2lyOWFtVGhGZlVQVXdGcFhNUmtEOXRYNmUr?=
 =?utf-8?B?WDliUlU4SzBGeFA5c1ZoUFR3WXRCMkVPaXo4RHdJaGJVV3NsUG96VEtTYjhv?=
 =?utf-8?B?NlorTXcvUlUvNW0zMmpMQWpqM0JIWGZ0ZFMxVFN6K2VQNUQxNVJSMzNtY1lm?=
 =?utf-8?B?akhsWkliVFBEbVpKU2dneUF1cUFISUhPSmk2WEhkUjByMDkzc1NzeVdhZ3FX?=
 =?utf-8?B?L0xmemozZ2QzWjRLOExqdVF5NUUyWXNudTdiTjh4WVJzbHBsTHJ1cndscVFj?=
 =?utf-8?B?MkJmWG5MQVFXTE1WeWdTYXE4OWNLa0tJUnFXbzhmUk1EaHF6UU5sRzcyWE1D?=
 =?utf-8?B?dUVibWw1ajhQaXF5Z29sbU1jTjYwak9ERVM5MFhMejQyUDJpYnF4aUI0Yks2?=
 =?utf-8?B?NGVjUW1VclFBeDVkWkFjMEluSFdpUmpxbEY4KzhNQTl4YW8wWityRysvcmFH?=
 =?utf-8?Q?x1DMFl+OjdeTVz+W3vQH6xTSo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B5x9ZtALcmWdeVDk7v2No4m6Agz5A1okCXMfbl5BrWtiaKHOBVK2UJH6E5yigrBD3Ewn72x2ZCn1UzFkPxhWWZTzo5mCloBXpRe78aLWBYTGZ7W5qqqXfxB1lZNhjZ9XoddOn5ISwaW1vWHYggWzlvPzrKi1hIk45YQOx2EuvR/zuC4RG3iPeAGmccXMiR1MJMlKF3eoamqp0BkAmruzT84wJNjrVL0ua4Bzn/qWdvpbPBn4TgVPMT1koKVyXvTFwXvFjNpm5rdNyt4ejUbptEEggIlsXtlX/BHXzlDRvH1kP8mOxYUDlh3wWjVQcCDQ+6RStHzkzBTt28XkrMD1OYkBYZdnj+UNW0/FzkNL02b3OCByVXjt8fVOFuLltKfYaxWxxJYU+pd6o31qOYOWjcmoLs136+c8shD4AeKBmzTWuVrmDVYWzPRSBvaBWP/YZQPtV29ObPKxUE1EgLbZI9R1p7JIsut50HWyMNCxbMxNA2uinC8Tb/Z0enTziRyvgjxGsh0EcLKRx+MAS/CdYMVaGbey986pXUHDDmOF0z+Dqhmly34PpBD9uoMR3qyuSzLJpLjvGq2/O3QNJO2nkGFgHQusf/x0fCtlqW648zI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b12ca-d5de-4347-b716-08de0cdf9486
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:12:34.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyBf3yhnIP5e1wlhaW4tFbi1i3YMYEko0vdbEr1kylwtcMHPJ723fyONhCHOodfiqiQqomKFYpv5UmIvESjg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX63EEowMOEIve
 3KII2MXoj5g0fVRYSyMh3YerMDi1it9jD6zDSHRMvc2Sqhgli5qJPLAFjJgU49JLMr9OOTMFXor
 GDN6NiDvQepehSF57Nmm2mWvfORcVFbNG3W4haOkJV6l5LnEH4j7hBBk3D9A4lVReTCFa9qz0Yb
 HGtuDKd9xDT/HLzR0LavsDEzcNrwdVfMdRSuxXOViXOam0yeBoNGqeyjS4O26JfmvC4MYeVSrg/
 FaUe3XtuqJHQu6PtBxcj3Kidok79yBv7ifADjPbJ+PZXdj5bC8PA2H6Ya44Cj1mp2hyW3Rg4l8o
 wACzjDvaYW5zHOAqDK9objUhIofVggxDCotQ4arOyA6tbYdtTSCEZBegzUmmcTSu2G2aneoLs09
 c6tEvWw2wPsoFQzxz2ajSHxmSEYfrw==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f13597 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=keIxxntxFQUln70V-mcA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: v3OYXJAv-lj-8U_COjRc-r509qjyAT_v
X-Proofpoint-GUID: v3OYXJAv-lj-8U_COjRc-r509qjyAT_v

On 10/16/25 2:07 PM, Eric Biggers wrote:
> On Thu, Oct 16, 2025 at 09:41:27AM -0400, Chuck Lever wrote:
>> On 10/12/25 1:00 PM, Eric Biggers wrote:
>>> On Sun, Oct 12, 2025 at 07:12:26AM -0400, Jeff Layton wrote:
>>>> On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
>>>>> Update NFSD's support for "legacy client tracking" (which uses MD5) to
>>>>> use the MD5 library instead of crypto_shash.  This has several benefits:
>>>>>
>>>>> - Simpler code.  Notably, much of the error-handling code is no longer
>>>>>   needed, since the library functions can't fail.
>>>>>
>>>>> - Improved performance due to reduced overhead.  A microbenchmark of
>>>>>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>>>>>
>>>>> - The MD5 code can now safely be built as a loadable module when nfsd is
>>>>>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>>>>>   built-in, presumably to work around the unreliablity of the name-based
>>>>>   loading.)  Thus, select MD5 from the tristate option NFSD if
>>>>>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
>>>>>
>>>>> To preserve the existing behavior of legacy client tracking support
>>>>> being disabled when the kernel is booted with "fips=1", make
>>>>> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
>>>>> know if this is truly needed, but it preserves the existing behavior.
>>>>>
>>>>
>>>> FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
>>>> a cryptographically significant way here, but the FIPS gods won't bless
>>>> a kernel that uses MD5 at all, so I think it is needed.
>>>
>>> If it's not being used for a security purpose, then I think you can just
>>> drop the fips_enabled check.  People are used to the old API where MD5
>>> was always forbidden when fips_enabled, but it doesn't actually need to
>>> be that strict.  For this patch I wasn't certain about the use case
>>> though, so I just opted to preserve the existing behavior for now.  A
>>> follow-on patch to remove the check could make sense.
>> Eric, were you going to follow up with a fresh revision that drops the
>> fips_enabled check?
> 
> Sure, if you want.  I see you're also planning to revert my prerequisite
> patch "SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending
> on it".  So I also need to work around that by keeping the
> 'select CRYPTO' in NFSD_V4.

Or we can wait until either that patch is merged again, or the legacy
NFS client tracking implementation is finally removed. Let me know your
timing requirements.


-- 
Chuck Lever

