Return-Path: <linux-nfs+bounces-6680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27307988BA6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 23:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E42C1F21C4A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC28169397;
	Fri, 27 Sep 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYTxWFi5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vEBorYji"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5E1514C6
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470841; cv=fail; b=q5Xi5bn4NkT3lM7ZUdxlWdZpr3tlm+VoNvA35p+6UDOPUUWPUvajkvqlWqQo6ryxOCmFuqgjKZOh2Rr+2eLDOdSCAmHwV711iB9f1lf55gbwDGNiOBrUQqB1aouS2IRNnPJ/pYS7PY4oP9hc08OgdirK67xMnw2qKggIUjFK4rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470841; c=relaxed/simple;
	bh=WcZLYkMczvsMAgt+HTLJEnF9SDuG3FYHjyeYnwh7SLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjlCzr/7uytZ7SkmqAsgv+6AxDLZNFgI9fMapXtIdJfeJNELm5e9zr4Pg51Qbxp6Jh9zw+i3sTa67415ImxXQhsKXfXBG/KRtFTmRddpghG+EgZCXKrceXp1j2Yqh1hAHATK/d/o3tmZmkhxQIjs12CNAab2sY56FAf0kbh2QMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYTxWFi5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vEBorYji; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RKVna1031251;
	Fri, 27 Sep 2024 20:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xZW6PhfM4hO+KxeruuPErwKLSGeBgjeHi0iGhXzsfdw=; b=
	nYTxWFi5ve7pVwXtBPedmRYZdnEleePbvHNTZeFDhOK/BznZ6L+8r53wUr58q36Z
	naUyL6hsMWUHUAf6AvqOESarva77+dQOWHBRx0rjM6YROhLLW69zzidiFc92/X6N
	s8OHHZSbZucB/EiilxYQTxVK6h49oGvtKeSYEwrDO8seEHpwpWj0Gp2sW8Tyi6D2
	WrEuU2rGXqiM01JM96CcYmYAsU8NvrygTn90DUuNr+4i3VWEFeayR50g85Ahn23n
	shc8ZxXzEPCLEHEsB3cpMjVTmJZsFQAtVT64/cHRLI97n/etq3Q9aBH+tN10LNTL
	WdFHDL+vSxnfN6eBpe/t0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2d0u3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 20:58:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RJDtIa009868;
	Fri, 27 Sep 2024 20:58:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdrhxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 20:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA+PoWkntnGhGBjBr4MA1iVmyo1PcLfKgrQj9Yt+Wb9ejhL3Byydtk5SfZWEpV6Td1xDekbORe1oIT7CAV1GQiIBLuBzEBVo7TdnYQpMekCiRmPM6phJbFGi3N+/IA/tWG/7lQEaYq/kySDRFmsDpl93Qf944Ff655joyiiYAq6daUmq4wbLL4RoLIQ7EQjl5qgeVXaq8lKrlMhhbF1AdACl5CyEYaoVmGzGkpYHx9icJIDgWNj9iOjmg2a2b/yQ8ftYktPD+oFnEghIKemo2H4zdt5EF2TUY2IEeZ2LfMI6Iss3Ve++QB5+n1DcChHs5lXNluSvmUOpgjERxjE/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZW6PhfM4hO+KxeruuPErwKLSGeBgjeHi0iGhXzsfdw=;
 b=UJrS8LpX/db7i0dvuTbqspOR3uaqdrv4KhxWqHzV9FMObOHp1h31q5GxGoh2QABnAD8AyReRANpcJiCm6DStLjO/ASLRIettHrbMfKtKpG6x+TC24umGc1r/2uFhLizFA1HEEWufZIwm6lcRssIPmsJc8Ok6n+nyARP0ZJBpDOHKCK4lLsQokSSvEeJOEEkEPfBGpciUhk0FhOazBf6+BlmYkrTu9amG0Yitlyid2wTPNkt0FdOMsxXWJhbZrf1X45FJTrECQ/4/Cog8YF8lINGdTUMDy7S6jEW6OUj1t14FyKcScEWUk1HAFoJqD0DxLzOoPPJBwZ3DJh9W1WKn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZW6PhfM4hO+KxeruuPErwKLSGeBgjeHi0iGhXzsfdw=;
 b=vEBorYjiDm21Qo/ccbeOUe7gKMIZQL8mdQRZVgXkF+vp4DkJY5Yjk63SY+iB+jkWvH50T+hCoN6o8ArCDaBhxpSC/PeXpSQyl4eIwUKkUWbjx6YON400aSKXurT3Oznl1CJtKN2l/hhDQ8XCafdXRJ0DMTfXo+bR8/xAXauIIiM=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 20:58:12 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 20:58:12 +0000
Message-ID: <929c8087-e28b-43e9-8973-71d9f1b821d6@oracle.com>
Date: Fri, 27 Sep 2024 16:58:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSV4: fix rpc_task use-after-free when open concurrently
To: Yang Erkun <yangerkun@huaweicloud.com>, trondmy@kernel.org,
        anna@kernel.org
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:610:53::11) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af424f2-5e1e-4017-2ef9-08dcdf37199d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eS9vbjJINVRpcEdrTjlHeEI0WnBzaTZnay9FZW9iYmM4bHdGQ0tNYW1qaHhZ?=
 =?utf-8?B?VSszTlkyY2lWTWVxMkIxeG44YUthLzVvS2lPNWh2aGEzalJlb0tkdFNUV1Js?=
 =?utf-8?B?aGRHYzZDNER4ZVZHQndmcGF4MWFFaGgxY3FIUWZLVzRMbVZrZFdjbUtMS3p5?=
 =?utf-8?B?U0hqYUttZ29HUTg0a0hvUlNCTU0yQW9WL2FzSFp3bGpjMDZmcWg2WkhPbVJE?=
 =?utf-8?B?Z2pJS1A3Qi9UUU1RRERIb2QrK2F6R3Z2bzZIaVptc0pKbVg5MURzTXRaN050?=
 =?utf-8?B?ZEtyY1JjZmZ6enV3ckhPSWtMV3dKQjFoQjhnd0lrcjZrS2dObWtKSlNYY0pq?=
 =?utf-8?B?cnlaTTJiM21KTjU2eVdTYTlPNzU1Z0FPL21GVDl0U1JKRlVKTVlWTzZvZmEv?=
 =?utf-8?B?QkltcGR1K3EyVnZ1clpTOS8wdkpzd1gxb3J6VUc4SVFka1gwSzFDNUN3dU1x?=
 =?utf-8?B?cWEvZDRCdFhhRUM2ZHJGWTN1UWZyV2xEaXFJSGFlV3pPMlI5ZnRnOElTUlJU?=
 =?utf-8?B?NzFBbXgrb0VIZXVROEN3a0lPVmtNMGZ3SlFzYzFwRmhqY0RNbmV6YUp6NENk?=
 =?utf-8?B?UTJwanZkSEovTGJwdjQ0SVl4eXpWc2g4SGp1aWJJZFBmd05NU0JVV0dybHNU?=
 =?utf-8?B?cGlQRmxTdmI3K2x4cUJQbnlUK2Z4c1d3c2hSdEdVNTRnWjFKMk85T09lTncy?=
 =?utf-8?B?MEtPV2thR3RXdlBNQ3pKTE43dnhyYUN3QmVOZHZuWVdRVkNsSWxVVFRIUXN1?=
 =?utf-8?B?blJ6R3JLM0s5VjBnSDRQNmNHQnN3NXBUUHpVMTV5VzZNSzN2emJSSkkrSjBT?=
 =?utf-8?B?UFFuVTFUUVYycFlpTjN5ei85Q2IyZ05lanZ1dW1QUE1SaGgzR1hDZWJzYVNP?=
 =?utf-8?B?blBkUGYrOWFSU2JaNFdrRlE4WFBQd0VER3Q2N01pU3RFSFZzdGxmTTZ1eWxX?=
 =?utf-8?B?QUF6ZmRjU2l4VnpBa1dMYWZIQVR0Q25tK2JtWDdUUHBKRUtLU0l1ckJydjNU?=
 =?utf-8?B?cHdUSkJua0UyVkY4VWoxbkwrM1VaNlpVTFEwUTMyODdkdHJaYzdvVStkOW13?=
 =?utf-8?B?cWtaOUR0bW1ybkV4M3JLcnRNR3YxOUU5blJ4d08xalg1WjFPcEhKUnJyYWlE?=
 =?utf-8?B?dzJTSmsrSVl2Vk41Y01LTzUxbTYyUnAxYnhlS0FxRWxPc0R4M0c3YUtyUVJ1?=
 =?utf-8?B?RG9tK3ZONGoxMWJVa1Z1SElJU2hncUFRaHFacEgvcUY5MW5WV1VKOUpwOStG?=
 =?utf-8?B?d0FtVy9BSUdland6MHBlaVlCb0M2R25JY2E3OVZtT3FLTFhvOHpPWGJCNDRz?=
 =?utf-8?B?Umd6NFBkS1lQWnZjdk4xS3RtY0Y0LzRNamREVU5OT0pObzdZVExsNll5M2RD?=
 =?utf-8?B?ZmJwZC9qYlNWWDhzN0JPN2g5L3JJQVg5czluMFRSZFpnN3RBVWtONnZCb2tE?=
 =?utf-8?B?cFhLUkVVL3RzaTlaWnM2OHpPeUlVSGV5K1U3UC8yWUg5L2tWZno2bTNqVFBk?=
 =?utf-8?B?SmlUUUk5c0plVDB6bzdTREU4S3h5UGxVK05UQmZHSlBhVUwyWjJwMTZlcEIx?=
 =?utf-8?B?SDBXOGhFOU81Um1INTg4UmZNdUVNcDJmYXJtV1B2ZGpodFRzL1R0UFBVQWpG?=
 =?utf-8?B?cHNianFVSW13K2l0VFN3eFpuWWhuVUhNK3NSRW5GcGEzQW1nejZvVXM1ejl6?=
 =?utf-8?B?QzQ0WUpTT1ZoQnhlbVhzQTNWMFczWHJpM1ZQUUxoTDRmbDBhTVFCTmZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkdxclE3WDRGamFKRzVYbTZwSmRPeXZEVWFmOHZiUEJkenhaUDlFOWtkenRv?=
 =?utf-8?B?dHZRbFNYdTkyUE03SkdyNk8vNkNqR0tucllMRlUzcmRmTExVOFhDaHZpOXVC?=
 =?utf-8?B?ZmdyWldqRUlqZkgvN21wOExFTGNJaVBaQzhmTWk2MG1odHQ2dkJXV05EY1JD?=
 =?utf-8?B?RDBSV3FqSGszaTNJRUZSWnFYayt5cGZYUWhaazNGNjgwUUF5elNseWpZbHQw?=
 =?utf-8?B?YWpLdVl4TVJOclVEelZscXFLSE83SXdUQVV5WDdpSUdyWm95M0N4Y0k5elZG?=
 =?utf-8?B?Y256ajhOaDVYdlNLQWRyZUhWNUx4N0xDR1JnRjNzaldtZmtoU0NsbW5LcG9s?=
 =?utf-8?B?blJ4SlNiZy9VOUF1dGt3U3luNWovN1VzeHVXQlNPZldJbE0xdU4rdUNEek4y?=
 =?utf-8?B?MVg4dXN2ekNGTVFCR0N2alJpTlEzTGJtdThFcWhycE9JR3M5THZRZGVvMzlE?=
 =?utf-8?B?WmlCWjRDZ29vRTB5d002T21rYlhzRlJza0QzMjZMRy9ySmVlQURnelI3djRG?=
 =?utf-8?B?QUlkYzQvME4rUW5GazhsNjVteHE4anlOM0FiM1ZTUUdYVTh3dDVrMjBZc3Jr?=
 =?utf-8?B?SVErc2JaNmpzMHhHY1lTOXBOekhTaTJCVlpFblNhdkhjMnpRZFNUYXFvK0xI?=
 =?utf-8?B?dDRqS2h6VlVLWnFqUC9QQ1M5NDhHTW42UTEyRWJIUmZHMDExSDRQbDRWdHRW?=
 =?utf-8?B?ZjgwVFlyT2E1ZHdqM2tNd2JjTkZtMXZFdWIzRDlsb3Fwb3hlL3g3dktiNFRH?=
 =?utf-8?B?Zzc3a1Zsc3NUcW1WRjlVZmlrbUdSblgzSUZYemlSUlQvTEY3S2psakVpZUEy?=
 =?utf-8?B?ZDJkZFpna05aMGdJdjlYZGo3MjJLMExyWWFzMGVlZkhwZmxDZGE2amN4b3hZ?=
 =?utf-8?B?ZmFqSHVsbmd2aTRVM0VqMDJVWnB5ZlhUK05odFpBQmNhVFFlK3VnQ0swUGlv?=
 =?utf-8?B?Njd3U3pSYTdEdXMvb3ZneHRWcGFqS1RCVW4vOXFmSlF5d3BSVVBadkJQbEh4?=
 =?utf-8?B?VTZnNWN5am1mNEFyUXNxOGM2bStaZ1drM0tVR05weUVEa0d0U1VHbHdtaGl2?=
 =?utf-8?B?Vk9MU3FIWDZhTG94cXpHd0h2alBONXZCS21NMmZMdm1Ha09kQU5JMnJPTjhI?=
 =?utf-8?B?Q1pFaG0reXJjZDR3MjYrUzVUbnhYdDRrOVZQZnYyc2h2Q0xZSVFwdmRaeFV1?=
 =?utf-8?B?d2tBZGFLS0cxbDluUTF2V0RDL3JSZ2ZwYU9vdWFOSVZNeFM5QS8veFpGNVFz?=
 =?utf-8?B?TWxadXlxaVJpRTRiM2RBZGdFSlQxdEk3VWtVQmtkdzR3b3ZpLzhVKzRvd25N?=
 =?utf-8?B?Y2lWbFYzZEVaRmx4aHZTcy83V0ZhczJEQnZZbE0rQlRZL0NwMzl4dm5TWGJK?=
 =?utf-8?B?LzhJZlpPM0pKRUZkc1VPcEdBdVgyUXhBclM3TkVCYlg1WnR2aVFIKzh1UWMy?=
 =?utf-8?B?UTgzZlpSL2hyK0NvRkQvdGtKb0hOVE9FNXdjdkpuek1mcitZcWZ3SDI1allr?=
 =?utf-8?B?SlFaN0wwdW1TcDlPdDJ0bDIxOFJMdzNQSWsvQmlLdVZkeWhSTXpIcGFHUVhK?=
 =?utf-8?B?Qnd2TEdKNkRYT0pNbUZPd2RVYndiQWZqY2ZzR2FNWk1rOVExelBaeVlWN011?=
 =?utf-8?B?TUs2dU5xandsOEJ3a0toVldYZFdTSmdUMlV5MzRtdUxYTk5RMkRKbjEwUEoz?=
 =?utf-8?B?SUtPY0hUSGE4SnFHOGwyVE56aUFtQS9NUlh5M0pOMDlSTVIrSWRnRllxNmNM?=
 =?utf-8?B?RThrZC9rTzJWNjRqMTZzT0hNanlYd1Q0YTlpT1FHN1FvajRybm04d3N5MlpJ?=
 =?utf-8?B?QkZnTkNGQk9mcDBDeGUwSWw4dVpSeStqRmdQYzdvR2VzeTR1SWh5NUJib1F6?=
 =?utf-8?B?U0ZmQ2xOakpmZ1J6ZllTdGVNa3VjRHZaMnFKb1hFT0l1VkdqVjEwM0gxOFA0?=
 =?utf-8?B?YWdEbW43aS9UNGlxU2V5bTUrYWtYNWVRNWp0dG9zRmFOSnVUaDhPZE1HL0k3?=
 =?utf-8?B?VFlRcnBjSENQY2VWYTNmQS9sVEZreXBKaG9SUkRuNnAyMjJXRk55ZXZUMWU4?=
 =?utf-8?B?bjlNL3Ard0dnTkprbVZCMUlHWTBUcno0NTcwMFhzek9ZNHBVRSs5WVptbUth?=
 =?utf-8?B?M3JJK254QnZUVHBoTUg3WXNZUWJVY2IwUEN3MDR4eUQzeE5JTE9sbk4ybC9l?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zgEyDiJPSuXyka4fzaeyPJ3HhKPKgdI66yEYrCwVmH61/Teu+CNK94IClWxC1FZMNT2F5khtixj/qTMstswP21X+Wd5edpWE9P9OdglPKkLTYWKzZRub+8VtH81Q0YmsqEOlw9pNojB+iD6Pn+HK0wIsju190Xn/t9uqKMjLup7yGRmbB9hS+M/mmIzZ1NhVbPVMecIkXwL7NiFFrCr3NXT4wt+TmfwHMcV5xXhx7jlQo+5DNyEhETVnfrKV+sEALrM1r2UcgkpYw0wGTQrvGue6vQnoqckh/Th01RhCICys5DODoya8X4VrqD4IZfUQRDN76xFVSVMzSv2KI887fRD10P4Y2OF1z2wdFb8bJApkB8PBotg28/kjSxrqUrKl0GzpWSI97/46+IXt6ezuhI3oni5wKcpyWkVf/4z+uoBZp48IdDLxrUlHgb48xfF9M7xPXcPwWFG8wuz28x51KbFOXEmrZTh71zbP4mUYZrc1YoRtzrhRAuyLS4FhtQd5YdThDnJCeM7VdxKZGLEtxu7y86tMFxkUToPvZYM2wkpr4EJj1ug9jzwJQoM8onAsRYMjZBgQiFtkjLcyMgB3VOYJYOStiGpYArPwr2YaTSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af424f2-5e1e-4017-2ef9-08dcdf37199d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:58:12.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiSmpG0hNbzn87N9N/wh4ghjEFi822abjve4gQHI65pRqOfpEWdqlHBuFHF4kCMK48N9Fak4gD2/1c2J6CtfpdNs8VLJ/gQNkMdu9qvUC5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270153
X-Proofpoint-GUID: m7BB-803PRCmNfUuWlp37lFNNEQWI0OF
X-Proofpoint-ORIG-GUID: m7BB-803PRCmNfUuWlp37lFNNEQWI0OF

Hi Yang,

On 9/26/24 2:12 AM, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> Two threads that work with the same cred try to open different files
> concurrently, they will utilize the same nfs4_state_owner. And in order
> to sequential open request send to server, the second task will fall
> into RPC_TASK_QUEUED in nfs_wait_on_sequence since there is already one
> work doing the open operation. Furthermore, the second task will wait
> until the first task completes its work, call rpc_wake_up_queued_task in
> nfs_release_seqid to wake up the second task, allowing it to complete
> the remaining open operation.
> 
> The preceding logic does not cause any problems under normal
> circumstances. However, when once we force an unmount using `umount -f`,
> the function nfs_umount_begin attempts to kill all tasks by calling
> rpc_signal_task. This help wake up the second task, but it sets the
> status to -ERESTARTSYS. This status prevents `nfs4_open_release` from
> calling `nfs4_opendata_to_nfs4_state`. Consequently, while the second
> task will be freed, the original tasks will still exist in
> sequence->list(see nfs_release_seqid). Latter, when the first thread
> calls nfs_release_seqid and attempts to wake up the second task, it will
> trigger the uaf.
> 
> To resolve this issue, ensure rpc_task will remove it from
> sequence->list by adding nfs_release_seqid in nfs4_open_release.
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in rpc_wake_up_queued_task+0xbb/0xc0
> Read of size 8 at addr ff11000007639930 by task bash/792
> 
> CPU: 0 UID: 0 PID: 792 Comm: bash Tainted: G    B   W
> 6.11.0-09960-gd10b58fe53dc-dirty #10
> Tainted: [B]=BAD_PAGE, [W]=WARN
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xa3/0x120
>  print_address_description.constprop.0+0x63/0x510
>  print_report+0xf5/0x360
>  kasan_report+0xd9/0x140
>  __asan_report_load8_noabort+0x24/0x40
>  rpc_wake_up_queued_task+0xbb/0xc0
>  nfs_release_seqid+0x1e1/0x2f0
>  nfs_free_seqid+0x1a/0x40
>  nfs4_opendata_free+0xc6/0x3e0
>  _nfs4_do_open.isra.0+0xbe3/0x1380
>  nfs4_do_open+0x28b/0x620
>  nfs4_atomic_open+0x2c6/0x3a0
>  nfs_atomic_open+0x4f8/0x1180
>  atomic_open+0x186/0x4e0
>  lookup_open.isra.0+0x3e7/0x15b0
>  open_last_lookups+0x85d/0x1260
>  path_openat+0x151/0x7b0
>  do_filp_open+0x1e0/0x310
>  do_sys_openat2+0x178/0x1f0
>  do_sys_open+0xa2/0x100
>  __x64_sys_openat+0xa8/0x120
>  x64_sys_call+0x2507/0x4540
>  do_syscall_64+0xa7/0x240
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> ...
> 
> Allocated by task 767:
>  kasan_save_stack+0x3b/0x70
>  kasan_save_track+0x1c/0x40
>  kasan_save_alloc_info+0x44/0x70
>  __kasan_slab_alloc+0xaf/0xc0
>  kmem_cache_alloc_noprof+0x1e0/0x4f0
>  rpc_new_task+0xe7/0x220
>  rpc_run_task+0x27/0x7d0
>  nfs4_run_open_task+0x477/0x810
>  _nfs4_proc_open+0xc0/0x6d0
>  _nfs4_open_and_get_state+0x178/0xc50
>  _nfs4_do_open.isra.0+0x47f/0x1380
>  nfs4_do_open+0x28b/0x620
>  nfs4_atomic_open+0x2c6/0x3a0
>  nfs_atomic_open+0x4f8/0x1180
>  atomic_open+0x186/0x4e0
>  lookup_open.isra.0+0x3e7/0x15b0
>  open_last_lookups+0x85d/0x1260
>  path_openat+0x151/0x7b0
>  do_filp_open+0x1e0/0x310
>  do_sys_openat2+0x178/0x1f0
>  do_sys_open+0xa2/0x100
>  __x64_sys_openat+0xa8/0x120
>  x64_sys_call+0x2507/0x4540
>  do_syscall_64+0xa7/0x240
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Freed by task 767:
>  kasan_save_stack+0x3b/0x70
>  kasan_save_track+0x1c/0x40
>  kasan_save_free_info+0x43/0x80
>  __kasan_slab_free+0x4f/0x90
>  kmem_cache_free+0x199/0x4f0
>  mempool_free_slab+0x1f/0x30
>  mempool_free+0xdf/0x3d0
>  rpc_free_task+0x12d/0x180
>  rpc_final_put_task+0x10e/0x150
>  rpc_do_put_task+0x63/0x80
>  rpc_put_task+0x18/0x30
>  nfs4_run_open_task+0x4f4/0x810
>  _nfs4_proc_open+0xc0/0x6d0
>  _nfs4_open_and_get_state+0x178/0xc50
>  _nfs4_do_open.isra.0+0x47f/0x1380
>  nfs4_do_open+0x28b/0x620
>  nfs4_atomic_open+0x2c6/0x3a0
>  nfs_atomic_open+0x4f8/0x1180
>  atomic_open+0x186/0x4e0
>  lookup_open.isra.0+0x3e7/0x15b0
>  open_last_lookups+0x85d/0x1260
>  path_openat+0x151/0x7b0
>  do_filp_open+0x1e0/0x310
>  do_sys_openat2+0x178/0x1f0
>  do_sys_open+0xa2/0x100
>  __x64_sys_openat+0xa8/0x120
>  x64_sys_call+0x2507/0x4540
>  do_syscall_64+0xa7/0x240
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Once I apply this patch I'm seeing my client hang when running xfstests generic/451 with NFS v4.0. I was wondering if you could check if you see the same hang, and please fix it if so?

Thanks,
Anna

> 
> Fixes: 24ac23ab88df ("NFSv4: Convert open() into an asynchronous RPC call")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfs/nfs4proc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index b8ffbe52ba15..4685621ba469 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -2603,6 +2603,7 @@ static void nfs4_open_release(void *calldata)
>  	struct nfs4_opendata *data = calldata;
>  	struct nfs4_state *state = NULL;
>  
> +	nfs_release_seqid(data->o_arg.seqid);
>  	/* If this request hasn't been cancelled, do nothing */
>  	if (!data->cancelled)
>  		goto out_free;


