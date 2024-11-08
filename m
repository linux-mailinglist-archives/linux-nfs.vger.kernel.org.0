Return-Path: <linux-nfs+bounces-7791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE29C2807
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D889283B6C
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D91C1F26;
	Fri,  8 Nov 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ekz0ZqJ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kPEVaikF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC51A9B3E
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108057; cv=fail; b=iHtJPd5Wa5DOP6fU2LjhhRSr5kmMppcM7DUa1+GI6hNMRQ/dHB1IHJl7VrpmOk2DOFqFZl4vBL29QNmT0fqKZeOjcBggc9TkKJtv3/yyuLIVbuv4EviGDWbglsgLhI9wIMv5/VNlJ96cirqM3oI0kmfzL/0suMl5hK/VQGGTWN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108057; c=relaxed/simple;
	bh=ejJlYqFpUl01J+an0uJ/jiyx3TuQcpUy6BSL3/JtyeI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=jC6wGpIm9ps2yM+YtnOVle6FJxy44JY/gxu8XIdd+7WIHtUtdLq27s0lTrvyzFOFJKWBaQEKaXiPfp81ncRHuFRrzwr8ymMaHIOI18+ZckS3dbaA4lKczEHrRMyfAWtBSgvFFSh1at/LlYr/5CBA5ZPJSueZVkEYjKhNerC9pG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ekz0ZqJ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kPEVaikF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8NBZ4R005028;
	Fri, 8 Nov 2024 23:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=SLNBG160N5ZoW4nf
	Y6wDzpCt/LhBE+L0xhzVR3TVbd4=; b=ekz0ZqJ14tCbpYxVyISWm5FvwrOzGcKW
	koV9oBXrOMaUFlNTmsouPEFWQfGPQXDHsb77s21ENRcShzP8316fYiQGif1jJzr3
	JGBtQQ5nV2ZVrvv/wO4wmIBnP1I5RIF/V/u1iU3IXCY6Jxi3WD1OZA/99xoYGA2k
	k2fA2zhXB1UyLUZq4Gov5UjWoKTSWnezHDJXpy0Ia2jMJs6kTqLaYLO+B7agEFsW
	vM3l+kVlasX8c0Ij8KY/McKjYkeNvR6J3pMUI4H4iG2w/N1N0OWSqA2syU8ib2Ow
	y8XtdPMGYnGaOYHSE6htZfClgWEtqavaJHwP0A96BN0ZqI7bOWC0sA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjjnpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 23:20:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8Kw4V4026971;
	Fri, 8 Nov 2024 23:20:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbr4x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 23:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdwNUrZ+NbQ5PFUMbQ1YI5Nw/skGgBYB/Ya1IUOeba0oS88FLeKknTMVHyxaHr4vYThBb6IDNEfUTHh+6RsAm5zqv7dJXXOAf1GiakWOsrGq7oyneUmAJSCPmVJBq7BLElGYnRI+erc4ACepzFfvnXdOPTWPw6ezUGtSVULqBXXO8TTKz4B2A/OWiBkLlc6F07NUPIsgLEHWPtc9FCJpIihcxpm53rmXAhungw165wFt3rqq+VSkeSeyiX/DaTbo+GyQaUroSsaGIyTMqv7YPu7NkHX32vBqYUhVWJLkUbp3/DhuzJQfrtpQM7iPhrTR3nycSCqnwK1HIAz3wMcxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLNBG160N5ZoW4nfY6wDzpCt/LhBE+L0xhzVR3TVbd4=;
 b=w1UwC/HF9wTkIaZoCw1a1frO0MrN+ZF9wFNOXwUjqHpiXuqQ+KWYYkJhim9rAINqsChLtIGuzgFLANhQN1REGC5chmolEwzN/0Fk+jni4heCmrcfUo0bdxg2BJ01qLp2fcIOpIpoi0lLBWTVf7C45MZbD841vYkubJ54L0krRbVCOm7rWqza8gvL1Dwyxl+Tn87Aj8dowI1fkWrN438R2k0/KVhdZEMJ/SHBkv+dyjk9h66sz/jErRd4S+IX31OYRqWpkZarq/EQ9xHlqm2pv0NYra8losvin5s5aFfNtpc7XiEjNScHk91Wb3dAZEf6A+hnVUCz6KNC/hbyxU2MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLNBG160N5ZoW4nfY6wDzpCt/LhBE+L0xhzVR3TVbd4=;
 b=kPEVaikFLi56EA/iziEz0LnfSvjNTyeS5eX1mhSgCQzOefRBn8D/bxTMR4iXqPZQEwRHuJFICWWP9BcUJxkJvj59aEipfMujjKnjxAQuIVm0NyAqQa7iDNZzLQuXzDtRl9MU5id28DMKMNLQrN0mQdr60K2zWP5xzLLIWVSiTlU=
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 23:20:46 +0000
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::ae92:7136:c7ac:74e6]) by SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::ae92:7136:c7ac:74e6%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 23:20:46 +0000
Message-ID: <7536acf7-da4d-45c9-8e29-f72300bfd098@oracle.com>
Date: Fri, 8 Nov 2024 15:20:44 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>, linux-nfs@vger.kernel.org
From: Dai Ngo <dai.ngo@oracle.com>
Subject: extremely long cl_tasks list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To SJ2PR10MB7618.namprd10.prod.outlook.com
 (2603:10b6:a03:548::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7618:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: ef17b5ba-8dc8-411b-205d-08dd004bf922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHczbHMvSUhwbjhka3MzTFZzQmJGZUFCdGVzdFlCSVNvV3FySkJIU01pQTdW?=
 =?utf-8?B?ZWZoTWsxamVqem9rQ05nVWpzQXZXQVNncjVPamZDR3JVWXFuNDZya0ZvL2sv?=
 =?utf-8?B?TGZ0VHcvNUVJUlBhY3Z2d20raTVpVmNVaTZwaXpUaU1aYnUwbm44QjBVMlNw?=
 =?utf-8?B?QTRYZkpXZDJYZU93QVdHdDhUd3lZTnYvSU1JUXIrL0FYZTFLcFFzN3JVQ0JF?=
 =?utf-8?B?QXhSK0dnS3dYTi9TMEs5QzBESWU1V2draFJ0dGJlWTE4aHZXQ1N1cS8wSS9L?=
 =?utf-8?B?aC84SWZueWM0ZWxEWlJabkxncmpnOUhvOGtFaDgvSSsyWkdXSVZCSWRwUDlF?=
 =?utf-8?B?V1pxdDZNSUVicSt3YzNpcHpqWkZtOTFXSDFGNXF5dm9IV0xHTkh0a3VzK2Na?=
 =?utf-8?B?RVFUTzF4dXp5YzQ2RGNncm9zOGhtTDhpYVRVOFVwVTNPK3dJdG5TVjAza0hR?=
 =?utf-8?B?T2pwM3U3N2dHeWJZWUNmQW5KdGptYWRYQVp5bCtES2pNZU5CR3BIK29IY1da?=
 =?utf-8?B?ZngrUEl3dTFPZTFZd1ptZVpReDdpaDl0bG4vN2llZWN0WVJCbkx1cExkUGF6?=
 =?utf-8?B?WmJTTCtsQ1Y5V1k0a0M0QzVFbVhFbjZmUG5SU0tKRkxOTjZmeG9hMFVOZFdI?=
 =?utf-8?B?aldvRW5ZVnorTVRuT3k5MUd5YU5GNG0wN3IwSWdZUGFVeU9xcEhTZE50cUMz?=
 =?utf-8?B?eUxid2w2cENMSWhETlMzMk1ybjU0MnBNZGNjSi9pcFZ6VndTMkpLRlQ2bVdS?=
 =?utf-8?B?TjVQTmxmbENjMnJ3QzNTY0xJV0NPMDZPMXVFQjVKZnIvN25kRjQxYjRiNUwx?=
 =?utf-8?B?TGVZb0N4K1A4SEtjNG4xNVFHQ3MvVG1qR0JiM2x6SFR1Ylp6WTFMVzgwbFky?=
 =?utf-8?B?VUxDRlBpZW5PSWxqRXYyTXhaTVF5ZWpCTDdFNjc0akwrb1pTWmp1bU1JcmpH?=
 =?utf-8?B?RjdZSGhYVGtRcVIvWkQzeVhnV1JlbTVDWTh3ZHJhcUY0d3hGbSthUWZESis2?=
 =?utf-8?B?U1ZPRi9QYnFSa2hLaUQ0VXJseFNqaVpySXBlbXRZRFQranMwekZaMWtZVWds?=
 =?utf-8?B?U0hsWTdjSUMrZmxNZEdRZVJySzJFaWpmMzJlWXM0d0FDejFCTCt1M2FHb0ln?=
 =?utf-8?B?d29OeGEybW9qWWx2cmh4Q1gvNytPM1hJd1Y4aG92UWpqcmRuZHdRTVUwZWxu?=
 =?utf-8?B?a2lyZHhrMjY3YXVHMEFGQm10U004eVRjcG1JTVdZWlptSFhXN092MWFtWUtL?=
 =?utf-8?B?RjhReXJPLzBxQWUxVkg4TS9GUm9DUG8xVTZrZ2gxNjdoYXhRQjhxTUptTjZN?=
 =?utf-8?B?ZG0raGFqYUpyTjlwY2dWZnBxUUVldnh6VUNOLzFGaktBZWJCQWttZ2Q5bHBa?=
 =?utf-8?B?VDQ0cSsxT0dHY21PeEdRcG82OGxFd3hKK1FLOVNMcGthL3F6WnNEM243aVpL?=
 =?utf-8?B?Q1dmV1d0SFBobW1BVXFTUVBvUWo5U3ZUSGQ2QS8zY1VSTlUxaXNUU0VRRTBt?=
 =?utf-8?B?TituUFQyeXBRSEovZGxnNi9XRXg5eWthMk9lZnRPMUJrVGFsSVFoRVdIT0NX?=
 =?utf-8?B?MXcrMEtTNzE2c3VNSlJzdCtremo2bVRpNURFWXFiM2NQM3VUMmxvM3p3QTRP?=
 =?utf-8?B?dElRNlJ6elBIRVBRdUZUSkNvWFVUU3ZFdk44SzZKQWRZTk4wbm05SE5HaExt?=
 =?utf-8?B?YVNhREF5MFZGUDVwU0wwbVM4SlNvZEhEb3FGSVVNNGJiaHF0ZkphOWp4Zks4?=
 =?utf-8?Q?TpvkZiNVGzpzueaLQAbKLfSeoNNSW08mYwNMGYT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7618.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTNjb3lBQ3hia3YvMjlmNWxhWFVoZkRWZVFJV3NGUVRhbUdqOTR2cFU2eTF2?=
 =?utf-8?B?SFJsZkFqN3lZcndrTDNib3ppNGpTZnZJejI0VUtkOFdzWFBTNFltMFRNN3Vh?=
 =?utf-8?B?OFIzWklhZGtmV3Y5WEpxc0o2Q2ZyOHNWL0J6d3lGVFpBU29oTzZybGJnZm5x?=
 =?utf-8?B?bmJYZU5QNHNQaFRHMXIwL0JpWExwY2xleDJ2R0xYdHdjNjI0eTZhb0Q2dG10?=
 =?utf-8?B?L1hRbTFndTFJZ2EzV1JEMUxkWmJYVllmSHBJU2o2OWF3VXkvM25INlpZZ1BK?=
 =?utf-8?B?VElqSWVSUTNhdkJXdGttUGFzOGpqbUZSWGYrNFpQTy9EZGRndENhWVZ5bTAx?=
 =?utf-8?B?TENRY1dIUGZQSTRYTkJpOTVRbm5VVjBwYk1wQVJtTXF4cDRNaEpUSHZ3SHBE?=
 =?utf-8?B?Wm9xY2xCWjlWQkpzOWRhN2VMSUs0UFVzdWFJbzdQT2VpTkVCbXJncGwxK1ow?=
 =?utf-8?B?SXE3QzcydWVRcEhXVUVXYTc1eHY3V0RLUnB3VThzTnlyWFQ3aWVGUnJDR21s?=
 =?utf-8?B?aUFtZ2Yzelozblo0RmY0TUJ0NzZEZ2w0MmlXdG9oL0x1bnBhOFlMOThnelUv?=
 =?utf-8?B?SHFDeFlkZm5CSklQa3JEbkRPZjJUb0tBbUVwVUkySU1CcTkvMEM0NjVVaXYv?=
 =?utf-8?B?K2orSHJ0NHE2MTFOQjg2UFEwWHFMMkI0dlNIc1p1RlFkZ1YvTklvU3pRQTU0?=
 =?utf-8?B?blA4REJEdlBET2NiOVZMTHpMNUgwL2JjdGRSMVcwa0xtWkZqTnpEYjZoN1dG?=
 =?utf-8?B?SFBGak1yeTF6QitENUYwczZDM1NKczYyL1VqT3hyWDB3Y0FOTU0wUGdDT1dY?=
 =?utf-8?B?Z1lFd0R1MGJxVm1TVDhaY213S09INWR5T09CTUljaWNoYlhDS3AwWHpwS0Fn?=
 =?utf-8?B?c1BOMHNDY0JsMHlJa1U2eTJyTXFJbjIxOFJGRTJmWnBBZGtraE9DVklhSE5F?=
 =?utf-8?B?KzN0MXNicUVHRzRRelZCcE5RVzN1UVRWOGdkYWtLcVRqbzNURHFrOC9ONmVT?=
 =?utf-8?B?UG1wUGtRZ3lvWXhjSWVmaU1HaUJUN0FkRmlTKzhwU1phSXc5YjBDblBqbHFa?=
 =?utf-8?B?dGtDZmhiamZ4cHpYVTlEdnU2UkFYeEFtbTZrTy83SGNyVVR1NDlDYjF3ME92?=
 =?utf-8?B?VWZCOUZTMDRSeVRRRXA0TkZMcDg5NlFMZ2oreU9ubkk3dzRpazBwcnpPQlNj?=
 =?utf-8?B?S3J1TTBFVy9peitjSGd6SzA0eHhVUVZDZDNGdC9TOFdqV0FTc2JkbG5XYUNW?=
 =?utf-8?B?SzN0NjNZTkV1eEt0cVIvZmQrZEVrc3JLUzVSenNrWXQyNGlHeVA3Q1RxRmFw?=
 =?utf-8?B?R3FWVktGWHJjNDVBQjJDYitJdjZIUGY1V3VWbkx6Q3NUSEVMZmRTcnJNZ05n?=
 =?utf-8?B?V3EwNjIwUG9FeFllZ21QQXUxL24xcWdqRk5IemFIc0t6NEhjbU9TYjlhcit4?=
 =?utf-8?B?aWQwQUp6R3krQ0lNTjRpdU50OFZEalpFd3F0K294RDBjSFJ2VzB6ejlRb2lK?=
 =?utf-8?B?WURUTkFrMjErTXFWR2JsTGNsL1UyMjd5SUxoaXI3R1hJUG56cmxIa09NRitV?=
 =?utf-8?B?eUhOYXZkUExTaTBjbGU5V2hQOFBwV1hlaFZGNDlCUEZKT3duU09GQ3VBbkN4?=
 =?utf-8?B?MHp5UlkwM1ZmK01HeFNLRkNNckN4VHNIOGVESER6dHpGVW5FM0ZHQWh4UlVm?=
 =?utf-8?B?c2FmMUgzSzkwejFRanpKRUwxOGZSMFVmbXBYQUZHK01IZ2JFdU1ndjA5WW42?=
 =?utf-8?B?WitsalE3WjNoWGxTQWwwdW1uYTRJSDExZ0FRTlFXa3J0UkE0THZnRkovYzRj?=
 =?utf-8?B?RWVIazVuZGRvUVNUVGJ0N2FHR3hYQml0aURFeGdkNVRuUXpLZ0xHS3JPUStI?=
 =?utf-8?B?Mmhmb1hWM095akVsaHpsMlVqckZUSWdUemVaVkFBQWs1cVNqa2JGL0pwelE4?=
 =?utf-8?B?anJKd2U2VVp6dnA4YXRKeEZlR1dYRC8wdjdnc3dEampKdFJUakZQNEFPQ25X?=
 =?utf-8?B?ZWlGNi9DajU3aDBkSlZpS3A0c2VJWFBZQnUyVFVzcUFkTU9nQjdLN3ZPZ3hN?=
 =?utf-8?B?dy91bEZveGNVOVVOMDBaZTViN2dIRmloRlBmY2Jwd3k4akVodW82MHEvTkgy?=
 =?utf-8?B?ZWJGS0RYMTUrdnlXcU9uTFZXN0lsTTRaRTA1NHNZUEF1d0c4dU4wZUJ1NzBP?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Wxa3k2rtsGmifl/rlkeS1eRN37NCKERBPpIqKgHDmBcm3mMCgoXncEu4OPn6ubhq1T3Cnwk8mcEveFDBEUyPMgoG3OSCmHlwUhS8ZuQCcbu8d5mpM3EdN448JKhs8Y8STLtcL5auHYOdvTocStwE3wYncWRx7Tcp1UZIylFoxJTU5tfCIbVjByJA8r3ENkzWhbh3n0ZO/lTNi8a5rG9RtklZ5Ok80muUuqq99MzsYvTbKqQLLcESk/dYl36b0u6ZpLylZzoVB2SEgu9smcYluQGG2pg9//tanngED4wFRJDlH2uIF3jNfQAog5ab0XCFeHzAXiN6Kihi7SM6H3SZCQNywGblIX7I+hh/eLvkNyppVPb7DXU0v1cwrO1cCOhIgMfi6fl1X2c+13WrfL6EK/tY6FXQJeLBshkSwMLAIdhoseR4w2PFRbgjY9qtDKOVfIBtuL0UblFqA7I8fKl7V3f70Dp7Kb+fa6s9DmqVuY2+Y9+iRYQz5CytoeF92kXxPtddWuCKKlZ9A3fP8LPuAKjOUG+1DelbIpjMC1VhYAfwur94qXgn/Y9ycHmKnqc4UIxAP7S6looqgQP/jhPmTNczqX5vo7hWMcS6BUeaMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef17b5ba-8dc8-411b-205d-08dd004bf922
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7618.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 23:20:46.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jFkDxYnLRTvX8oTSyFxRJGBymk8s98xCmTqR6G+axCfFAkQUNbABebfXy9IZIRQYFAAHp6NwUXYrTUsfioygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_19,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080191
X-Proofpoint-GUID: Lc8pCNggywItASUAJLrZByKLAruCIcSO
X-Proofpoint-ORIG-GUID: Lc8pCNggywItASUAJLrZByKLAruCIcSO

Hi Trond,

Currently cl_tasks is used to maintain the list of all rpc_task's
for each rpc_clnt.

Under heavy write load, we've seen this list grows to millions
of entries. Even though the list is extremely long, the system
still runs fine until the user wants to get the information of
all active RPC tasks by doing:

#  cat /sys/kernel/debug/sunrpc/rpc_clnt/N/tasks

When this happens, tasks_start() is called and it acquires the
rpc_clnt.cl_lock to walk the cl_tasks list, returning one entry
at a time to the caller. The cl_lock is held until all tasks on
this list have been processed.
      
While the cl_lock is held, completed RPC tasks have to spin wait
in rpc_task_release_client for the cl_lock. If there are millions
of entries in the cl_tasks list it will take a long time before
tasks_stop is called and the cl_lock is released.

Under heavy load condition the rpc_task_release_client threads
will use up all the available CPUs in the system, preventing other
jobs to run and this causes the system to temporarily lock up.
  
I'm looking for suggestions on how to address this issue. I think
one option is to convert the cl_tasks list to use xarray to eliminate
the contention on the cl_lock and would like to get the opinion
from the community.

Thanks,
-Dai


