Return-Path: <linux-nfs+bounces-7469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E79B059B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FAE284896
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3461FB89E;
	Fri, 25 Oct 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iKx0e0p+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBajJpeX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846F7083B;
	Fri, 25 Oct 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866073; cv=fail; b=M92CSKPR9lPPn/krIHblsheEW/DyJf63e7QjaVknUwC9GwaUHjBQmn6lwGv2dSjlOQdbHeTywXwqVzy99V8tp/Z58fvduzj0ZXic5YWTHFZWIVK0/UsDFDQ9OpO3IBpQRi/EgI65t5Yml8WQJFg1wShvyX3w41W17Oy+IXEePQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866073; c=relaxed/simple;
	bh=Br4HwfvZtbY96hP4JxuE5T+5kmVqZC3jcsKLpMSYs78=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QvbX6P2Q/0tgZdd3fVmLKFF1+AUPT+Fld2PbiB6PEDpXTb7MdBfpI+y1lN3aOmAx7X5HqocTy8nqxxc/spnQA9xQzLHSj/Q3psYAzGgtONuZplpNndhCzNaulRjiZTRzCTCVo7riggixJYZI709p7gKLw0+vWlBytSGfWkq6WRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iKx0e0p+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBajJpeX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDhVea031606;
	Fri, 25 Oct 2024 14:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=9ZMgJseAcZuE8UhSTI6LzuoHd8lzLUgxUiinRQEWJbQ=; b=
	iKx0e0p+cjCmUjo5MtlI3xJC4Shy9smvYa7mo5h5Xi2+HKvWy7Ch/vQOagiAS4bx
	FST4uEsYY9FnSFCy0nvufOSybzUCXp0ZYoIoW6ZGfiChhxlUBGG578hdaBjDrMlB
	QpYNhVxg0BtgmpXfn5EHaMJEO5Sy/DYma/OAuCLrxbss+YFQMZOD8q8pSZMG8IY4
	jYt6ooGNZ6g1qU5vVuzxAZ8LLUyE0Tu9bh2nWrBkyBErVF7yJG9R9aKG/+2qGR8D
	yOAulT0WKQolvidDNRP+0YWnKmQLikT+p/m122VZeXGQuezrUevVSLcZJ3DUc0CS
	hsLc0vOIUh1eq3xEfDxWeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr4a4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 14:21:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDwYB5039100;
	Fri, 25 Oct 2024 14:21:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5t2tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 14:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYOy3Da/WYOLRTqyHOp8rhI1FvdDvRgpCP3OOREYwrwNuVHa0u17xaWHKmbeXAfrDUXWAyE7q3yG6RsSvJY7XLEtqS5Di03mrNsoLooHOrIXJvqkuPooV22wsWDQMnELLz0HFw5ZFyFKHQNZz5CpTwT5F6uCUt3+qduNcXKUk/+Vp+GCksYGaoJ2TVoaFa2sZFR897UgUAGwOiTqg/jOVL9qw0hW0yK/3jcw8SXnTognGE9zCUmFNjFS1r9zMm1EYjgBSZnJbLkaXIBz0ogKqV99qBBoiIw8qnbn9m+nmoRN67AKJA8B3oD+F0rzKbwHDsX6OqL8pQuSN1IFEUxNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZMgJseAcZuE8UhSTI6LzuoHd8lzLUgxUiinRQEWJbQ=;
 b=FT9b9b3QsRwmVOlbluTGbyr8k/u6V+1hGBSCFJBsMYnrTxj2+jo1M9ebdfolEGmVM46B2YLrXBlkaRYmnnEFaPPu/T5n4daITxyPT9pWXZOiu7b/A05gdneNBZFR8m7o4nRz6kGwOsJZfEwbwPIFRIHjyVGqNEobTV7R34rm0kK/Lje7TDnmOb+Zk6EmuOCY7N2DcTQgx56vR+B4fd2VY9FWVOeQcCL1WKdhnHebn86rxJRcSRvQp7Q9lIU0xH7WhxPLQ8E9pv3r+w2dt/2MUUZpInaNEa/oxyVY5TU0/qVFGsh1tU6qWEhU8Syg1qaSejgjiRD9bc9OFBoLvmHxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZMgJseAcZuE8UhSTI6LzuoHd8lzLUgxUiinRQEWJbQ=;
 b=vBajJpeXqJz/WkLWnZBbodDex1xXmFVKrGu6o1RbmYKa6LRROMa3MPtXbMvwkifFQFWkVmN5nJhGSFpH/qe6lEQotM+VovJxIfzfpM0X38iGDPYJlPueN6305t7avKFzhSjIGGfhGj2D22j+cUQsBQaNB2QB3oayflSg9JFTm2Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6721.namprd10.prod.outlook.com (2603:10b6:208:441::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 14:20:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:20:58 +0000
Date: Fri, 25 Oct 2024 10:20:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] additional NFSD fixes for v6.12-rc
Message-ID: <ZxupRdOKLeNUKTyJ@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a49322-a012-446e-9b9d-08dcf5003ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gdwe2t/K+4LMvhO+Bj9hLWNGzJT0hK1gA4b/IgbDI8ail0jaPJGFE3szle5T?=
 =?us-ascii?Q?uU/9NefWYZsEQ1ceFkuInpqYrSmQcZabgBZXMm773D6upRLhLL/3S+38XCda?=
 =?us-ascii?Q?dDZbgVqQd30Hc8auej6tyyovbMxVBosSMZFEa/ICpV7jvOP3SQ9UbI/opulJ?=
 =?us-ascii?Q?FHQkJFTSc1vHaTm/YLZxxRhaQRAbkk7AUNTSh6TH8H+DRYEpSSOEiZqk7fbh?=
 =?us-ascii?Q?86i8TioZfV86Fx9Q5LuiLSckIOYsQwoYLJOS73mg0K71A8L+bVimzvXGlb26?=
 =?us-ascii?Q?9fSpWarPyCJ2jguCCNpSfRfyufr3X3Dx/HLJT+mFJUt5WgTuHnnf2tiGWwQA?=
 =?us-ascii?Q?mQ+P/gW56FZcrWTGAgfciri3X5WYNsWQI+/YwYgcxO2BtGrTACOWnXJGOSSv?=
 =?us-ascii?Q?i3mJN3RBdHoeooZfNrKZKB7FfWDjqaBMjADLWwnIFdv6T7zlgwurORCtHpHq?=
 =?us-ascii?Q?BxiQFf33m1rRzfgiVPlxRl1pIdM9owILSvRbubbuj3bsajbCAsUIpJZCupP2?=
 =?us-ascii?Q?sYrY2/pGYB5/zDOTdKpbvj9p3E4EMmguyI7gbdHIByqoY/aKBltWxAVXPFGj?=
 =?us-ascii?Q?Z1nZ28l9xZ5NlD1JnTelYfV/QXupuNoqG0xH0obaMIy/SxkJnA29M9K5OAIo?=
 =?us-ascii?Q?k717R3prFgLYLaXruhFSbxUbqKKlWnt0YSzHi8k5TNbjP8khXjl90oWDJJIq?=
 =?us-ascii?Q?HTMZ6h1Jmwf5jzn91slcY9tkdy5xjA8s+409ybCh3VTMC7yTXwPEDvWYRcuL?=
 =?us-ascii?Q?EC144JXWv64qld21kF8mVhkWs+CFfUHXFcjsHiU7NnLsQ/MKatDpEMqSoafg?=
 =?us-ascii?Q?R8AaY1xOI0HoZ5g5Y3MZMVONkxpMEZ8ZebF7XjEQYaADPXejQgSQvRR7oS6U?=
 =?us-ascii?Q?aqWAqzO9GNsOOr4b6QQ4MhYAzYZw7qsJ5ng9uQIDkVK5VB63NfKUHdB4AKQZ?=
 =?us-ascii?Q?VZ6g/nP44q6t+M8ruT3yVmWa6tuxXaXCaUCcw265PauvUM7dO7EQYWBMzIZb?=
 =?us-ascii?Q?VPJ9feP3CpnE7JzSB5Jrs4PAq8Jx5Iq6EkY9k4clXC+Vj+9yWuKqqEIyS/Rx?=
 =?us-ascii?Q?WO7yUqAN+eRA+En0d98AgIAhRiI5wn+1CXFm5MIiRN3kzzKdXI1D5AycIIQq?=
 =?us-ascii?Q?v7Q+gUgUQKjWcRRPJ43WHuRWSkSyu0WtFK4OSGWykORHJ3VkSHAOvn0eRjIs?=
 =?us-ascii?Q?rUtxQSkKArNZh98ECxZV84vDpkoLX65hCdCOIKw3wAtNJ4wX2grrsxOaB0i8?=
 =?us-ascii?Q?mSz5f5LJvN2AJuiHXMelvgzyZ2Xz8ZfM/vfKZop7zlsNTg8XecXNrHHfUC6X?=
 =?us-ascii?Q?Y3mDS0mxSp/YNfDvuTJ2fGW8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3TOQ3Cl7KGXIO9TgkPcDFsEJlB08//UeoZeQ3nzmQ6QipOC4e/FYBHeU+BSW?=
 =?us-ascii?Q?0E8f0om+9Smuq/LLsGeAb7POefcJbfGlSgh9IcWTVrjCNayFfFJOqvCEScpq?=
 =?us-ascii?Q?05x+zH5gttYH2RPxhM12cRH5pxb/qMl2pT3tKH+tK30kVhCRVovZ4EG9tUMi?=
 =?us-ascii?Q?KbLZ/4ZdMkhyqC5moTC/uhPjCs2Tfp4zyMe6JzhqmmJoJvQhM/23ODEuJrbV?=
 =?us-ascii?Q?X3YgxFfHzUZJgu5U0IAus6VC7yLzmk3puwTeuG/UWOYpXWNiBvBBksTBNwq9?=
 =?us-ascii?Q?rrVLh0OIvFOopx+OXHHnkbVBlXkzxlhddlDkinD9znByOOdfT85kBSORqyFu?=
 =?us-ascii?Q?qWJNNQWNIvtG3VYd6JxS4WtG7bPY7uTxjCnhkIZIcap9uUqC97B3hFFMdJJ9?=
 =?us-ascii?Q?8Brf/UFsW7Yq9AhktMyLxzO1Et3fmcn04B/oNeGS1H4CjCQ4Tf7HzVHwusPI?=
 =?us-ascii?Q?pwJVxOQWvQU/9/ie+Ns/OtoqTy9kS7cW55e8F49nZX/+LKgcxgD/gzerfMI9?=
 =?us-ascii?Q?ekQMpBTPbO6+C4yKn7o02p9S6p/DSlaS5ew/OeuNVuLX5vGi7OZz/+GtW0Lk?=
 =?us-ascii?Q?fjZl3fY0i75scwzk2Y4TqZTsxHNnPU6dKHMVsR99IP/qO2KKVC8iWxgOJ5hr?=
 =?us-ascii?Q?T7sMPs5ktiJ3Z+e81Imu+TKeghq5TK1wrAA/f2uOITTtNjDZ4M5CpoQClTcQ?=
 =?us-ascii?Q?3x8CfrLXDYATlzbvx38eQaGoTqkhcJz+ZU3z0FCts8i/lMT1GzhCNOF3uQ/6?=
 =?us-ascii?Q?N0LzZlo/cnLJeqSJbvGxPE9jO81YbuY6dpiBy/YIiEB/sbUAmW4VspYCjYuR?=
 =?us-ascii?Q?AHFRsRksP9zrw5lpSwE36UFQGQZ32Og9E6lHrLqqQ8sfhebdAZ+EqI/o6bJq?=
 =?us-ascii?Q?HkST94Gg1hc1Zf8aRGpZW4e/7+udFX8ZzCOR5I0NSj5eYl9HJ+OEOK11PkSc?=
 =?us-ascii?Q?5P93G0R80L31EDEiogV9oxJRwVjZfYFe7q8LKINFEd5hr1ToQU/GqThRo9ha?=
 =?us-ascii?Q?VJYI2lR46Ivji/YhAw5HcT27eXcEa4yE9FbglZVwE5hA8pqOU+1cEumkpLMz?=
 =?us-ascii?Q?zJsb8Nsks/vNQ1ktZxVVkuQRJWZdmaTrX7gEIQYjFM5L7aQraupHvSqyOLGo?=
 =?us-ascii?Q?TErSXk+xmQfoJOj0/Y0+mnDeBiz7q4ly5HLUL4HGVnLR1igQ0U/TEIKD2T8b?=
 =?us-ascii?Q?rEzaxfVW0zl6QDUNpzBBkWDiCrQj7ofPulszr9jLFHn7PaF/+6LWv1VwRW1z?=
 =?us-ascii?Q?wcZk54DxqQy9oYsZGdPtu8aKLfMkeh6CHIYzj/7YViEfAEDdfDLOrykBZ3en?=
 =?us-ascii?Q?YvzlA8Wn906bPaqz19OMAvjbypNWn6lrWU/5cBVAIYCI2VVHBFBgm5bW+E2Q?=
 =?us-ascii?Q?6I29zznpqA9ljLPjTgdPLzGljgm+CBOHNAiiQG2VQ7YqXuAb9ieVlOIDNKuD?=
 =?us-ascii?Q?5AGzqutlR4tLEYN57mFgWZLYwsKbGLE+BHjsFr54qBBWYzf81AZjERRJLFnT?=
 =?us-ascii?Q?xLmKvkybKXgbuCuiOyXFfEQTFTtl64EQ3PvyzZzUz7M0jCNUCIvyYycoIJFS?=
 =?us-ascii?Q?ujnFYFHlNeM2pJtntj5pHRsgLEZlj/yw7zoz72QXycZwgk1/HfmDH46Esq6N?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LqwS12QG19dccDZrtUZOF4d+wATMTDnku2tLYYOX91Yiu+zkjiOkzfc9SkvEJJiDkkO2deKvWsV+BeHe7l7Hzgh5j7kkcnm/3+nNOIevR0KeEDla+InuMJsgNBRf10LiIgQ39XYk+fj818SuJwJtDVEHH0H0thtoPI7XkAvTwPQqyr0H8dsNUWe8R2CYdZBdC9kWtMTrtjRdcjDPUav14YIPNI6phgBeAb9/gNChV5Ks+25Vco+ag/7VzPUizYI+HAyRKkL3jQ4JMfw8t5RHYNR/CYlTDrVyCm7r6mgrpjg59y8VvGgjvMtwWxbbq9BhQIfbkasLQz2ytmP1a5n6yGfRCwKQV1lh4f0cFRkUigdAMBDOZPVNS6gx+hJUKFtviJG+u2+N0gLkoScreSKGS9TUc6y1moyHvbk2aMyvdVURX4znr68sHPn3GEdzRiw7ScgmrRdK6001ElpTYIWVzEz473bDJl752fNJZpfcjkscbSskkmNI4+sMUyuYAqgThjssCTjOub8Hgr/RGQ6YmWEt1kN5GyFQlTlreT6NI2AAJL1YWaS6AyWY0RRqPe7MFxZi59fvRPDYzTqbNIj/Q3DviZEY2SeP/nmutImw84M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a49322-a012-446e-9b9d-08dcf5003ed8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:20:58.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMxD7emYW4t9GvjiQOrw/pCCRJyAj1M2Mnj+JRZsDlyn8xT01jYuMJmTDXOqS+itcBr/x2cc8+5n4k+JLPfD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_13,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=832 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250111
X-Proofpoint-GUID: nCr4L-r8uMiIiZbsh9bieqw2CgnzxsRj
X-Proofpoint-ORIG-GUID: nCr4L-r8uMiIiZbsh9bieqw2CgnzxsRj

The following changes since commit c88c150a467fcb670a1608e2272beeee3e86df6e:

  nfsd: fix possible badness in FREE_STATEID (2024-10-05 15:44:25 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-2

for you to fetch changes up to d5ff2fb2e7167e9483846e34148e60c0c016a1f6:

  nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net (2024-10-21 10:27:36 -0400)

----------------------------------------------------------------
nfsd-6.12 fixes:

- Fix a couple of use-after-free bugs

----------------------------------------------------------------
Olga Kornievskaia (1):
      nfsd: fix race between laundromat and free_stateid

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

 fs/nfsd/nfs4state.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/state.h     |  2 ++
 2 files changed, 43 insertions(+), 9 deletions(-)

-- 
Chuck Lever

