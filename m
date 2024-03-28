Return-Path: <linux-nfs+bounces-2545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C396890813
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 19:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939401F2209D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2652F62;
	Thu, 28 Mar 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMej1rDW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ha6u+6nU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC951879
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649700; cv=fail; b=qyOjvxCNk53z3U+buFb/1XECjnxF++9zTHEQzqGVThwoW29KG9XDrCIgPttNRpoP1lJVGir8oT31lsBZldbP3kKAeeqQVoARs2wEY4p1BguvHqTVikDC5aNP7A61k4DersrKmx12UEjjs/7g+HAdySinMiAwklOEcK2oVSHpulc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649700; c=relaxed/simple;
	bh=bQ0ec7wcopZ3zkK/fop55ttuGjyDAxaJ9oQBSqbsinM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSzEFjnwzTK2dqVUXcG0Vh09bcFweMCZPEB1ZAf6dY9rO4Vp7Vq+/PRIn/eJNgPxsdHbOjfOYRNjFmIwevlFxoic9nEjpwIqDxlPY5zW0MayDaPIgQA3f69SB3lPA9sXPEYxdjyMJ+a1DzqBdaNUxJGrSN27k0MYzxA+gisuTOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UMej1rDW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ha6u+6nU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SHx2Uf017084;
	Thu, 28 Mar 2024 18:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZiLCiF3UhGIdg7E9e+/qE9ujWlL1HniqMwHBgXg8t08=;
 b=UMej1rDWwIKk268V/K7hNVTlVI/3bXIGyGrrlPp2RmCzXASiHRUwGh4hlcLDMhRNK6QC
 OdclhBI8XC2Od0NONmONFtxEZDewE+zjpcrKwlewC4k3amXl2LH7CCVhbuh7dhlaOc96
 wrXwXMhx3gmgkzi4P0ibV/lJjEPiZMqp3SnfNJDGRNCfWmI1RFvFufO3IpPO656MZ4ls
 IXHfzM1WsR6TZcgVFBN+1O7yD52kRhfkmdONIC7+EDYWr0GUskHxXfw/uSwsDHTsxK/H
 W0j4FItvHaCxSXR1gJnvLqtcR2Du6i9Sp5IiOIIkCbP5n5Rk4snV+5CNOBjk8f3VS30Q Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybt7nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 18:14:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SI0HII013274;
	Thu, 28 Mar 2024 18:14:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhaa3sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 18:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPdxLmLYYT7KDbEuWuFyrDMQ62kvfUnmwk+1TkdOGkSLVGrHVNwShsM6QAArdDVsLWogYrbVcoxuyhaqwpr9BZG15eF0CgMZrypJhv9F1742rYSh+XV/o9tEJRa1+BgNhTLyiCHPVo6dDvlm2NUgVw67kNQNIAdYIgmxD6fiuR2I8KDJFQCjLsZ+li1iiCuUgpdNT+H6/HgGg9pIpG+jFqgy7nQb9h9yHAbzh0bAOqAdS0aPwtgpQcif5BXJFHK9CDfNau+zpaY34g19kSF/gQ5e/lrjOO/4pBktPXZm5jvg7JkN6vcoYAWYu4rDetxlLVPPA1Mwfn8SmnE9heUDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiLCiF3UhGIdg7E9e+/qE9ujWlL1HniqMwHBgXg8t08=;
 b=E7V1CWyiMV1TNFS+Lo50tXSHFqP7x8n18TtVY4gWosIfvDREtOsEDb0asO/F2DobLAnax8Vdx9JltB7HGJIwM8Au3BtiHDsY7dpN2gaOZlMwWFquMupzkt0Yd9bgWb4QO0ANvK6vYA/VqkKm32f8Xkz3Lq0szxALqsb5FUcqN7weFWz3H8LvZ3DCwhcJiSnqkekOehOexvjec0V/etTh0LuRxwBPaNcp5kuXKioaQ7Zpc+ENjSVfNzsrT3Y6yDmlQUCzPkxrqrpU1124TRbt7JAyWdD3Rl+Ok68a8gPJmoV7w7eB7PKc5ovfu911DTPGimExc3mfOv47MiT70+HIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiLCiF3UhGIdg7E9e+/qE9ujWlL1HniqMwHBgXg8t08=;
 b=ha6u+6nU7/tZS+nceyCYz6jCQxgWGNbmr7bGmQ5TLphcU9VQORsj7ahuo1cGyt+cjpMbbo8lVREDy5/mElH1BSJc6jjMiCTZ27WiRD5xubRGQN1+uOTaNNDI7mi9LzVa39HBPtqEcWPgJLloTGYaQd5D8vl2h/mbnLK5Bcl5hAU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5766.namprd10.prod.outlook.com (2603:10b6:a03:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 18:14:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.038; Thu, 28 Mar 2024
 18:14:45 +0000
Message-ID: <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
Date: Thu, 28 Mar 2024 11:14:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b337a49-e4f0-449a-4b0f-08dc4f52f270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p5KZ0xUPQv+Ef4reX4l51C4Cjlox41p12vRWFQLhIPuqUUZLeo1g4Q0wRLHWaHKhJ6cPDMoDAX/kymBgoyBG3Ie2fNl43AE8TE6kwX9U9yulP2kGbHpbBeC6QLm6ZhVQb6iA0UuDE0Uz3Df3pkWgUQjwp0M75ngv/dGTE2LAUIPtuba4O+dknybM0nRxm1Y6AJcwwFQmANOqshyQQTY2HS34FPhNUuG4lBDZR42DEi5eTvu74w93zqIIWWycgA+HdOmBDs6Y98gi31mGm3vsj3iMUBIfbsyZeP4fCEmi4EHITDT6llXp2RQkV1rrVOcRM9IKWznd/jSKnEo2n6G8UMiI5WRsCg92VYap5zzekI0BEeyO5yrph8JNcXKSWut3mVQN7KfRk1ht+RtTLq7uLNjmnoIBtaQiZyuu733FRqupcaLcm6YGPKLTjjXiGbZLeq3KqnjZCGE0ceuIXmZfPxbrcsUdWsLoB0L9/XrQ97x8PBzcwes/HS0FdaULA1LyT3M3jd9nCKWhzG6ca6dFpb3HPAlsjwJe9odw4vuk6lQCDIerd4e5Bp5eKibSHL324xm62JEIW+M7lS6Zhr8P4MIdYd+/FgtrxIxJF3y/6E5lAOMxGnOZMrbFUlHSwwkITPwTj+2G/NEn9j4m6BAUCmqq7Zlb5yNu8HPzqm075cg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnpkaFJLL2JCZzhuNHFNc0s2ZXBXUnBkL3hRempHUXhUSHVxb0FQbEU3aHl0?=
 =?utf-8?B?T1BkL1B6S1p1bk5kN2ZKVkxLbyt1RU0vbEcwcTNaZmJ2MVF0Szc5UGQyY1A1?=
 =?utf-8?B?SklRM1c2NGRrSTh4L1JiZWhBbTVqTUhhRExQT093dXo3OTFDQ25mcW9OQlh3?=
 =?utf-8?B?L0xMMW1BcmdPeVZtZHU4SGErK0Y4R2dTQ09aRmpETXJiVHRneHNZSmRZV0Er?=
 =?utf-8?B?QTFmakhKYXU5d3BMcndYdjVNd3JxK3hER3QwQURvUWVWNVppK3BxYzIrTXN2?=
 =?utf-8?B?Z2p3MmJsaXlpeERGczhEUDBwQ0lrZjg5K1RiK1p1VGNvTE1vTFErSTJvN1FX?=
 =?utf-8?B?K28xdVhxazM0VVYzbURJYW02SlhSRTg0ajJ6eGFjUXBlVmpWU3JVTHoxV3NX?=
 =?utf-8?B?TGtuT0hoWmdVUmJXVk1ZNW11OHFrQU1XUDVZaGtrSjBrU3NxaktoalpTU2NQ?=
 =?utf-8?B?MnBCak1PaUJveFE5YXFwclF6dStJZStEaXZwMW1URFNOMWVKMmZ4bjdFSmMv?=
 =?utf-8?B?d2FTTFNxd2pTTytzM2dLc0JzVXVXM25ncHZlUElpNnk5cmZoRERndjNrSERm?=
 =?utf-8?B?KzFoNW5zSk9seE5KRWVUcU5BNEl1VUNrT0dERkhMRmRRVTBDckpEOEM1U1c1?=
 =?utf-8?B?eW1aRGVaNXdxT3JTdGRtRHZzajB5M0U4TlZXeCtBdE4zbm4vZmY3TGtrYmhp?=
 =?utf-8?B?SDMyRWxFaThqL2FZUWJSZjVicHd3TUpSdTNLWjNlajF5ek1hL3BVdFF3MHpD?=
 =?utf-8?B?VlJEQnFWU1JSQUQ1UzN3dUwrMURiVUtwRUNyZkhIM2lCQURYb2l6WjVTVDV3?=
 =?utf-8?B?dmg3OG5FWFFxRTdMbEZLMjFZTDZwS1VrQXpQYVpFbU43OUV2Q3piSm5GcUJE?=
 =?utf-8?B?MUtBTDRlSWJBQkNFb0xTSUphdFZ2bGwrd0l1MEg4T2lhdUF5Y2xYdWV6Y2lZ?=
 =?utf-8?B?WE9zV0hPTGswdFJRVWhyVVpHOGttOUROaGtGSUg5SWNYUDdRZldBTEQ0eEZa?=
 =?utf-8?B?N3lqYXZ5WENWTWszVVdiamFsN1JhWjdsL09wN2pkU3RWYmFYLzFHOE1PajR1?=
 =?utf-8?B?QnVQRElMVUJaT1dVMC80RndNSlFLVDZIM0dzVDQ4bEhrVXJjNVk5TXpjSFNi?=
 =?utf-8?B?YkdvOTBPaFgvSlR5YStuTkRvcS9QcHFWdEhNZ2JPVFh2Y0xiYVl1czRZOXg5?=
 =?utf-8?B?S2I0M3dia1kzZzZkQmtYcW90RE51MEUwMHlFNUR2eUZPb2Z6QUJSbHZ1SVZR?=
 =?utf-8?B?VU5HdytkVUs2eWJ0MEpUYlNLTzVBdW1ObDY2OE9mS010SXMzMjlvemRBYkdh?=
 =?utf-8?B?V0tRdUhwK2NySUtTMkxBQjJWTkpWOTVhQUZpdFpkdGhPQWExNyt4Umh1V1FI?=
 =?utf-8?B?MFVrdDRPMThFcWRrTDExTFpyUEFrQlQ5dXM4Z1FrTEwxcytkTTNLV3p1Ymti?=
 =?utf-8?B?NVpyTGRETVBjOW1Yd0tMT3RVcjFDZkJqMERWR2tFcXhDNG0vRW9MY0lROVIy?=
 =?utf-8?B?U0lLWW1CUzRtc3ZQWTZEdVBCaHZRRVdMTE9xTS9pZWNsTGZabXBwM2F3L0M3?=
 =?utf-8?B?UWFBOGVDYURLOFhkbHpmRU90aWo3VWtmbkFhWklqUjlCM2g3WW1XcndIMHAv?=
 =?utf-8?B?SnNKbG9rZWNSZWFScnlaVXd0ZkdJakJENHJOdlErQ3c4T09IMy9MRTNZdjBI?=
 =?utf-8?B?Z1pmYjN5Ti9UWkQzMHJwa1VqTmIyUW84Z2JEUzRPSjZXODh3Nm5pNHdwREFn?=
 =?utf-8?B?UWtOSGFRUFluSkN3b2ZNTUVDNElGZ3huY1V0YzNQZzhLZVRZY1g1V1NtQVFT?=
 =?utf-8?B?c0ZJVWpJdE5KeWpYREFISGFKL0lDYlpHWGpTQmlPNVhRU3h0N2paWEh0aFMr?=
 =?utf-8?B?cnhmSElxRzYxNWJPODNoL3R5aG1CclZ4L0JWTTV2eTF5WExaR3R1bkphQXdt?=
 =?utf-8?B?U202d0ZqakZVZzNLMGVzcmhOakVpeUZva09xQTBzMXBvWmlLeVpQMlFETXQv?=
 =?utf-8?B?YWI3NUc3c1l1bXp6UFNXa3pwYXlGK2hhL2N4dysvVHVKbDBVVFlvaGRkZjR6?=
 =?utf-8?B?cUo3blozK2hBNitwRGpwbkxRMnBaMlRlMUFDU1d6SGd6WVh2dGtpU291OEtG?=
 =?utf-8?Q?oeIbKDtzlXXQgy3B8yn1I3Dpf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lUMBLJy7oAevEGwrLrF5O3aya73+N5US0SZF3Q8L5JQSznAb66I+I7hy4a8Ct34gWp36UKEyc46Go+66kNUdRShdkaMKjvxFjc9mrh6OvqF4be5t1tuRyuWGFtjFfesZAAsuyJSzSQ9uzfs+Ed9B07Zj5M8VJ16lTxp7XQ5s0p1n/WQ+2CMNfmX6V5YIvJRadznIcMbNFOPmnqUHvch2nf/909sDpC9X9I7kJ+dj7rSqaNOT6PJjxJoWNZzXUfFnMcC7+dmss/gjPQIHrWz5+zYVYYvNWAgZhvTmMr7xfmZkHDSZ3pG0odhr6Enr/30uyd1/9OKfV9IJ9fR76K9TkQ/BLUkM4r0NVPJlSuQkirzeLaTHChGfRHVqWxRHL4CS8nL8aMzmoKlaJf2dI/Q5YklHF55yQpwzxMDXUiDkPq3CDkvZ+duIZ1oN8djB8x5B2Z/77SllTwVpvehBtBWTGvF9Ek6Ymh4J17ScWjPKSUuTN337+njvViYY3mnk72Ca4QpvwFatutRiS9AEtc54ZePTXfqfl9mb9HIV8kXyv9p0pbn64qZq30Hf8TUPiJD4UwmR3FRAYpWR0UHwwwvI/i7JFb+5RL/U3K8/UFdkrnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b337a49-e4f0-449a-4b0f-08dc4f52f270
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:14:45.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CznZoJySQWqin4zBtCyil5F27LKfUDgYu3EUOcbbOcYQhNQutuqU7AqYAcTor5gCVCKaQ/zj1KCL0CH5CMJVEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280127
X-Proofpoint-GUID: H9MMsVbuaYMCbp4jAY_U1Y-vJxhaAe5G
X-Proofpoint-ORIG-GUID: H9MMsVbuaYMCbp4jAY_U1Y-vJxhaAe5G


On 3/28/24 7:08 AM, Chuck Lever wrote:
> On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
>> On 3/26/24 11:27 AM, Chuck Lever wrote:
>>> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>>>> Currently when a nfs4_client is destroyed we wait for the cb_recall_any
>>>> callback to complete before proceed. This adds unnecessary delay to the
>>>> __destroy_client call if there is problem communicating with the client.
>>> By "unnecessary delay" do you mean only the seven-second RPC
>>> retransmit timeout, or is there something else?
>> when the client network interface is down, the RPC task takes ~9s to
>> send the callback, waits for the reply and gets ETIMEDOUT. This process
>> repeats in a loop with the same RPC task before being stopped by
>> rpc_shutdown_client after client lease expires.
> I'll have to review this code again, but rpc_shutdown_client
> should cause these RPCs to terminate immediately and safely. Can't
> we use that?

rpc_shutdown_client works, it terminated the RPC call to stop the loop.

>
>
>> It takes a total of about 1m20s before the CB_RECALL is terminated.
>> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
>> loop since there is no delegation conflict and the client is allowed
>> to stay in courtesy state.
>>
>> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
>> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
>> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
>> When nfsd4_cb_release is called, it checks cb_need_restart bit and
>> re-queues the work again.
> Something in the sequence_done path should check if the server is
> tearing down this callback connection. If it doesn't, that is a bug
> IMO.

I will check to see if TCP eventually closes the connection and
notifies the RPC layer. From network traces, I see TCP stopped
retrying after about 7 minutes. But even 7 minutes it's a long
time we should not be hanging around waiting for it.

>
> Btw, have you checked NFSv4.0 behavior?

Not yet.

>
>
>>> I can see that a server shutdown might want to cancel these, but why
>>> is this a problem when destroying an nfs4_client?
>> Destroying an nfs4_client is called when the export is unmounted.
> Ah, agreed. Thanks for reminding me.
>
>
>> Cancelling these calls just make the process a bit quicker when there
>> is problem with the client connection, or preventing the unmount to
>> hang if there is problem at the workqueue and a callback work is
>> pending there.
>>
>> For CB_RECALL, even if we wait for the call to complete the client
>> won't be able to return any delegations since the nfs4_client is
>> already been destroyed. It just serves as a notice to the client that
>> there is a delegation conflict so it can take appropriate actions.
>>
>>>> This patch addresses this issue by cancelling the CB_RECALL_ANY call from
>>>> the workqueue when the nfs4_client is about to be destroyed.
>>> Does CB_OFFLOAD need similar treatment?
>> Probably. The copy is already done anyway, this is just a notification.
> It would be a nicer design if all outstanding callback RPCs could
> be handled with one mechanism instead of building a separate
> shutdown method for each operation type.

cb_recall ties to the individual delegation and cb_recall_any ties
to the nfs4_client. We can check the delegation and the client to
see if there are pending callbacks. Currently cb_offload is stand-alone
and not tied to anything, kzalloc the callback on the fly and send
it out so there is no way to find out if there is pending callback.

-Dai

>
>
>> -Dai
>>
>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4callback.c | 10 ++++++++++
>>>>    fs/nfsd/nfs4state.c    | 10 +++++++++-
>>>>    fs/nfsd/state.h        |  1 +
>>>>    3 files changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>> index 87c9547989f6..e5b50c96be6a 100644
>>>> --- a/fs/nfsd/nfs4callback.c
>>>> +++ b/fs/nfsd/nfs4callback.c
>>>> @@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>>>    		nfsd41_cb_inflight_end(clp);
>>>>    	return queued;
>>>>    }
>>>> +
>>>> +void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
>>>> +{
>>>> +	if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
>>>> +			cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
>>>> +		clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>>>> +		atomic_add_unless(&clp->cl_rpc_users, -1, 0);
>>>> +		nfsd41_cb_inflight_end(clp);
>>>> +	}
>>>> +}
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 1a93c7fcf76c..0e1db57c9a19 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
>>>>    	}
>>>>    	nfsd4_return_all_client_layouts(clp);
>>>>    	nfsd4_shutdown_copy(clp);
>>>> +	nfsd41_cb_recall_any_cancel(clp);
>>>>    	nfsd4_shutdown_callback(clp);
>>>>    	if (clp->cl_cb_conn.cb_xprt)
>>>>    		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>>> @@ -2980,6 +2981,12 @@ static void force_expire_client(struct nfs4_client *clp)
>>>>    	clp->cl_time = 0;
>>>>    	spin_unlock(&nn->client_lock);
>>>> +	/*
>>>> +	 * no need to send and wait for CB_RECALL_ANY
>>>> +	 * when client is about to be destroyed
>>>> +	 */
>>>> +	nfsd41_cb_recall_any_cancel(clp);
>>>> +
>>>>    	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
>>>>    	spin_lock(&nn->client_lock);
>>>>    	already_expired = list_empty(&clp->cl_lru);
>>>> @@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
>>>>    		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>>>>    						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>>>>    		trace_nfsd_cb_recall_any(clp->cl_ra);
>>>> -		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>>>> +		if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
>>>> +			clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>>>>    	}
>>>>    }
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 01c6f3445646..259b4af7d226 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
>>>>    extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>>>>    		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>>>>    extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
>>>> +extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
>>>>    extern int nfsd4_create_callback_queue(void);
>>>>    extern void nfsd4_destroy_callback_queue(void);
>>>>    extern void nfsd4_shutdown_callback(struct nfs4_client *);
>>>> -- 
>>>> 2.39.3
>>>>

