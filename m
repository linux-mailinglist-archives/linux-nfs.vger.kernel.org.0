Return-Path: <linux-nfs+bounces-17774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFFD1561C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 22:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9883019B7D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B73340D84;
	Mon, 12 Jan 2026 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TO4yP6Ej";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e97II/nz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4175310620;
	Mon, 12 Jan 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252015; cv=fail; b=kY5X4c4aciZWQhpVy11vlS2KOyoPiU2KzGVzpZh7YY86SqTyDSAivcRF4UPYE7NVdaVRFR0uzlwRFLlICaho/h//QBzZdJfQt2NNwUTr/mZBC2Y0472+WcBHWuUDu8HJdgow7EYe3xuIT4KKNz+j5tyszdj/I03KtZtCTMKhPmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252015; c=relaxed/simple;
	bh=1SByS121ibVD2FbMo/r9ut4wHaOsEqPVONGIgEMMs78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4YzhXnq0dZvQKlDBFGuet4A/V1HEPXIVEnR/KbvnZhGjW/oows9Oinb+ANDQMp//mMN4daRfcosUGn6gn7RgTW5rGU5DZMweuRZl6ggmFOYIzlYs7HYDG7n2CSlnccIOSfsQrRl/xpefa2fVZW3S8yFEJN9d0jCf4sDELIyt1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TO4yP6Ej; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e97II/nz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CJJHPX2046405;
	Mon, 12 Jan 2026 21:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=av1z33lP/jNOOBxzF6oZjorG3baEylCg4VcZEEpEW0w=; b=
	TO4yP6Ejj94u1aD8qI2/pXSHCuI5MQNMbhkmrNPXrlAHnA3Jkm/Np1+p40HlQRdb
	q5TIs0sZLbX4D+blzu64rF3LKrwtdF9/zFPYWRFLgAh0TkM+HPgUJaLAO688i8wu
	t0KLGja9nS959yc2toUKmXMm6IwWvArkxG1PiQzq6k0D4OtiVyR8mJoiubVzBp5k
	jxPzwNU6siGxbs/MrthsBfP73TqTwOEathNtYfvWgpoUuwSFet2Nm3av0c1zpjND
	/M71QaLYIL5rRB++u8THsEdoNxKKnavlr+15QcNx+2JIxe8SzaXthTLGvJ6W/Vii
	rsugLE3UjuHmBRm5hPyM2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrgntd31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 21:06:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CL0PKm029120;
	Mon, 12 Jan 2026 21:06:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7hne2y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 21:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bInlSM9AR5JfKe5XvRsEmH1hkAXsDLZPuJIQzmmS2mv9f/o1JysGiUOMDsUMW2vIB9g9P77jDCzO5ZgFVFbYmMy986U04pOle8rgyLT/fkNEET4fkDFmuBeWeOQXMYmEuJTMBeLawDuuoLTbEOEFszeEE9qWHpbRip/3HSszIbzjUrd8YlS2BmjH1dcjY3x2s6mnfXGt5BwhyQV184LS8axDCdL2iEcriNgptvcoSvOs+yONf3lJDzKZRyjZzC24X+3wtTYX00C0UQjTG6/96eZiA1SI3BsOZv/O1bDfJ7USMgvN2nbQgo/C28IZ10h+6Jp6NvqCUQlxK5Jw3k0D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av1z33lP/jNOOBxzF6oZjorG3baEylCg4VcZEEpEW0w=;
 b=erbP41HihCqqnagHOkCrasZ9svocisGx9GeDS5iORRAmf0iZMAiNyMi4dueAhX7ZBwYhK+aN52cxc9fHlFw1GilOtDJlhxKmlZKzx++fTKpT3RPpFZiWKHQyU9xYa/DggmV/syQYvt4Oz31qVuvY0V5FvcK1ZdHbDXSpTuiGtpHQ5qXrMwS2NtlEGLskQ6K1SiaPugZyt3DRDv6epYsciSwcQiISuVdDhxIVPzhB4BdQTf1bDIO/7c794uo+lEq20qkcPmiNWYjV1v1RbINdYEztZsznYV3zyO8jpVB+4VEuVXa3vFWyaFywanMBqSl3KlRn+fKWO486WRzq42U/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av1z33lP/jNOOBxzF6oZjorG3baEylCg4VcZEEpEW0w=;
 b=e97II/nzam9sOxpsrlFt2juo5DP7Kpz7BkbAq5NR85H6A4OP627oGlZzWYDBO1q1BtTb4j2IU3blbv4sUl7VwwlZuBAdfflHYMcBrYK9hJ22Fb7qzYs5Mi2G/jxhv6GRioXTDUvAkcbn4rjrqbzANUQGtyVl07wEv15DzzdqJK8=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SJ0PR10MB4719.namprd10.prod.outlook.com (2603:10b6:a03:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 21:06:27 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 21:06:27 +0000
Message-ID: <53e8ff9c-9c40-48b7-a110-c0bdea3fb149@oracle.com>
Date: Tue, 13 Jan 2026 02:36:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] NFSD: net ref data still needs to be freed even if
 net hasn't startup
To: Jay Wang <wanjay@amazon.com>, chuck.lever@oracle.com, jlayton@kernel.org
Cc: eadavis@qq.com, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, snitzer@kernel.org, anna.schumaker@oracle.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20260112185813.34595-1-wanjay@amazon.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260112185813.34595-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SJ0PR10MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a66df4-621c-48f2-f2f5-08de521e736b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YkczdXFGMkVaK1lmYVJoai85YTVDWE1zR0lNM1Y2aGVKU2YvNnUxc1JJUXNM?=
 =?utf-8?B?ZTlObkZpOTJhS0huVnNqdW9pQ3E5YUdDM2dBMWNGY21YYUtKZlJENEFJR0RO?=
 =?utf-8?B?bWZVekFGdXIyanRqK3pWUS9vOHpwbWdweGhFbVJLWFVVRkxuM2o4eWxXNjhv?=
 =?utf-8?B?ZXBMUEtUTkpEcmJvOUVia1RoNXlUQ2c3RUNucEh6M3JuNHNzTFpwZnNtWlg2?=
 =?utf-8?B?eWx1VkM4MDZITlBhMng5SkhQK0pCVFJZVVVjZUtHeElra3lsa1kvUjlvTWxN?=
 =?utf-8?B?VzhGYjV2N0RnTkRSSWU0VGxkWlg5RGVXdlcwOFVwbXRTd21YbHRqeHpReDhp?=
 =?utf-8?B?QW9OQkx4dEdRWUQ4K1NDQVU4RHdhTHRqS1FxWG1KcEhOdHZlSlBlM2V3UGhH?=
 =?utf-8?B?TndaWDRlV2dIbmxSUDZuWi9GNjNYMyt5TjRGeDhpZDZoZS9LYzg4OVRHL2d5?=
 =?utf-8?B?ZGhqWXRKcTFDdmE4TnRuVlRzSUNmWXVMVHFScVdNTysrZnRsdUlsd0QraXVj?=
 =?utf-8?B?d0lGWklTUUMyVHRWNVI1UHJxY29hQzV0YVVLS3VHWHRUejFrMThkOXR2NDc1?=
 =?utf-8?B?M0xiSVlGNHFzWFpOSy9hMDVHWHhuMjdvMXdVeWpjaDBucTVTQkcyVmdOOGpZ?=
 =?utf-8?B?LzZaMWFjLzRLcTBpUDNsU3hySUtXOHNoWk1VWGtNbHgvRUJ6bEtHVm9GOUsw?=
 =?utf-8?B?dW5EM0QrbzJDdDhNVEFGeUxhRHYyUlRpbWs0YVM2Y1ZCODhLK3ZKTlc1cDFy?=
 =?utf-8?B?bFBwcDJmQ3BkbmE4RE1vQ05lVko5Q04xZHlWeVUxUlBISjF2K0hUREgvdjNy?=
 =?utf-8?B?ZVZJdnRraE1YWVVDNEhidU1CRTJFRjBJRlVUU0Z5RFpWOXZLdEQ4bk5FMmIr?=
 =?utf-8?B?RzRwUENlZDNvcVBDUFpIVU5haDgrWUtTMDVQVHZWMmVMYnNVdE11aWlZVmZk?=
 =?utf-8?B?K3ZMZGN3QkZVdE5qVUlwdW5wSG02bDJ5R21qcEVCYzhlcWdHUS9kenIyVXA2?=
 =?utf-8?B?dWRwUG9JSXpHUnhCbXc0THR0MnlQQ0N0S25GRVgzbWZlb0Zka2tFUWh2VG9s?=
 =?utf-8?B?VjB2VWVqQWxMSFJFK1J0OVZmNUdLL2pxSW56Sy9sVVh3azArOWQyNlRDT1lY?=
 =?utf-8?B?NlIrRGk4UHRPMHNTcEhnQmJlaXV6NitCdU5DUnNIV1RaR1B2T2R1ZlE4VGhO?=
 =?utf-8?B?MXZXVkZsQzd4M2hlRTlDaEwwVkRST0VBT1RmOU9wRVZsZjNTVzJteGNGUlRm?=
 =?utf-8?B?Wk1pT3BkZGxPSnphZDc2UlBaTmlWcUxvTFhKcEN0b0x6VnlKVE45ZWtqQnJK?=
 =?utf-8?B?dDJyd3lMTDVLaFpMcjV5MkdjOXBtcWJ1ZE5BbWZ0T3RqQWNkaUlVYkZxQ01D?=
 =?utf-8?B?TXllbm9wMDcvMkJXN0pzNXVlS0NEZWlYWUZqU3did0lYWlorSzlSeWZKTnFq?=
 =?utf-8?B?UGp5Q0htUEF0ekErcDg4NUhTelExbm1oUXkrMWZ6MFJ3eEZtVVV5QUxWS2pt?=
 =?utf-8?B?enpZMmJzNVdZUFAyeWs4eHQ1QVFITEUwWjNtK1QxZElqMnBpOEIrWXRzblE0?=
 =?utf-8?B?N05PaUtCbWpMTjVSbi9vSG5PcnVzUzYzSU5acjlwbCs5NWt4WHI0RnA2VGNo?=
 =?utf-8?B?Mm9rV1Z5cE80ZkRFWUhvVVY3YVExc1FaQW1DZ05NQVhOWUV3a2tIQTdmOGpE?=
 =?utf-8?B?VXJNUVZ5ZHlUUkV6dmtsay9GNmVtSGhuRHBYNkFrMWpTbnI3eUJ5QXo2dklv?=
 =?utf-8?B?WUZCWk0xamc2cUtkUkNsbkJ4dmMxb01tQXFkNDYvVWZMaVpYa3JLUGZ1a2Nx?=
 =?utf-8?B?Y21MWUVZY3RRemJ4RTBCUGprSWdpcWdla0pTcXp3amppRzVBMTc3ZXlqUnln?=
 =?utf-8?B?ZTVNR2J0VmJiWHVncWxOdjMyWTlyZElYaGNEdFpOcmUzUHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emlURWU2c3dPa094UDgwT1hqSkZIODBoSElDUzBreGJQck9udVd1dnJMTElx?=
 =?utf-8?B?aTNhbFg4RExpeXgyd0QzNXowUWFya09UVmo2NmN3TEZhWm8yTy8xZ1RDbUFJ?=
 =?utf-8?B?ZkpBMExOcXppZytjWWtNSjVGcm01empXWEJTcUN5UkVZTjdOZDRJeEJDbjV6?=
 =?utf-8?B?ZVUyT05hQ0RWQmFpWEl1YmV4ZldFemhLMnJzQk1hVENGUEpIWWEwRGp3RDIr?=
 =?utf-8?B?UWVXcW5XU0h1UXVwVHRIZ3VvZ2tUWUY3Ty9kMHk4T05aZG9BQWlWMWE3aG1y?=
 =?utf-8?B?UlNsdVY1VXVkVllCVzVyS3BuSXNqR2lOelZhTVZBcjExcnIyVGU3NHA3Y2Nx?=
 =?utf-8?B?ZjJQbVZIU1hRdXZDeCtTVkk2d21ZeTRDaUJPVWNSZmg4Z1BBRk5Cb1Y1SzRi?=
 =?utf-8?B?NHBXZUovTWQwQkROK1ptRE9wUXNlK1FoS0VLeW5QODhnbkQ3K2MzYXM1c0RF?=
 =?utf-8?B?cXBCQmJjRVgrZU8xeHRLR0F5dk1LdXp1d0xVRm55bk9DYlQySHpQczlkZVdm?=
 =?utf-8?B?RkRJNWVBRVo2TytkcVFZVU1uRDVDYU92ZHBIWUhzWVNTTW9EM1NzZ0F1QXBh?=
 =?utf-8?B?aGtTL2RJWHhWSlZaUFc3TTloL01PNUtabWpOaEc1VFZmUksrQWNmbnpmTjUw?=
 =?utf-8?B?MG9EYVdFeDRhQ0xuRCtYMmEwYTZqemR6T01rcDU5a3JXMzVQMkNWMXJpR0xp?=
 =?utf-8?B?anJVTU0zNFM5VkpPa2dJb3dFWnc3ZWd6VGkyS1ZWT2J0alFHMHU5NEZRTE9I?=
 =?utf-8?B?RHBFd21MemZlWXhIUk1OVk4vOHpDN1dQd1VpUFkwSHpHQndXbkY3WkZ0M3Bt?=
 =?utf-8?B?enZGbU1nVzRjS2o3eWN2d2hEUzVrSmNUeWJoMkpmNDFTbFg1eENPckVFV1Zs?=
 =?utf-8?B?VndsdDg5RTVvMk1ZSkRrL2JLTzJaemRCeTRqZllWMXRuWDBsNFdZa0xLR2hr?=
 =?utf-8?B?ellzTnUzVytKUDB6cEFaczBSTUI3S0JoZjhyU3YwNE1pNGVvMUxVb3orQUlW?=
 =?utf-8?B?RFQ1MSt1V2N6MnpLbFhWditscXJIbk5jei91cUd6Ky9ic2ZDeTlVdCtmTWh3?=
 =?utf-8?B?VU5NcmhDVWl5alZtNlNDN211STVlQVBRRlhVSk5oTzdFajE4aEFkR3JGdjFa?=
 =?utf-8?B?R3lnY29sNTVtSU1oUEJDSk80VG1iK1BISU9OL3FuQW93T0lVUFMvbXludDJH?=
 =?utf-8?B?bko5RzUzdHpVenhnNE5qVDZwSStDNjU2TnFYVStVR0xhZ3cvUnhvSk95ZXJW?=
 =?utf-8?B?OVNBOWRPbk4zZTB4V0Q3NHhGT21XMHdCR2RoWXNkdEFSZzMwWjBMMlJyVXEw?=
 =?utf-8?B?OWdPZjFxb0I5UlEzN29BWWwzOWNMUTVMS2QwUmZsbTFlN01ETG53bGFkcVQy?=
 =?utf-8?B?T2hNZmhGSVBNSlJNSkNxZWJiMkNsdVl5U0pHVG1MMmwyUG1zamRjV1Axa243?=
 =?utf-8?B?bGNzTE1BRUVuMS93eFhiOURPc2hmbHJaU1RVNFRGelNFR3llUTVyNi91MXVs?=
 =?utf-8?B?K0Q4Snd3azZvY1o1cGcvMnFJL0FGUG5ma0syRThNVjY4WkJiazNkOHJpTjhY?=
 =?utf-8?B?L1c5VzRSZjlJVXVHR0Q0dVY2b2dBR1BjSzltWXcycGFQejVTQXN4YzBsZFlw?=
 =?utf-8?B?ZnFMajdXUW9NSlNBTU1uWGdPcGtHdElZREhxaEZSNFdSUitBelNBWE9FOTlm?=
 =?utf-8?B?ZXZRWlJIOWROMU1IWUJMNnhGMWIyMU5GWGtHT1RrT2hZRDFkblJ0b0pkOTlo?=
 =?utf-8?B?UW5admJPNk5yTnVOV2JSUzNEWENCU0dRMEFFaWhUZ2ZacFlWd0RLK3o3Q3l2?=
 =?utf-8?B?UGVjR0xGYVVyMEtpMGVyUGtTbFNrQnBCT0hwNTRKVHFHTExPajdsajdISWZ6?=
 =?utf-8?B?UVRxMGc5K2lIUmk0RG1ENEwzZmp0dmlob3o0NmliK2RRWUZqZjQxK0hDdTRN?=
 =?utf-8?B?UUV3VC9laXVPb0pWREl6aXNsMWpkY3ArZVB4TjVBbU5tNnBmVlBGU1dlMm1S?=
 =?utf-8?B?emtBeE5sSnRTREVqektMS3BlVnNwT3lHNzdYQy91cjJXSG1YN3BNbDcrYTYz?=
 =?utf-8?B?TWxWd1YvaFliaXRnRVlWZUhVVkx2MGNwN1VJM21haUpXSUpHcUFVdzQ0b1dL?=
 =?utf-8?B?ME03R2hVSUsvQ2JhdXhmQWltMFJSdENDWW95SFcrbGFnTnBlOWFaVGp2OVUv?=
 =?utf-8?B?YTRsV2NmM1BPM1hnM2c5ZjNMd29jZVJ2a2EvQWV2Q1hncU1nd1IwMjFsWW8z?=
 =?utf-8?B?VEZIZzFZbVJML2QwWlhFOFUwQ3pPendrRGk0cjc5TStEVDYrMDdVUGZEYlNa?=
 =?utf-8?B?WGtMUnd3VXI5RmgyNEdFWXBiLzMvOUZLY2NBMWVsbDBFTVgySGRIRi9ESGRE?=
 =?utf-8?Q?9aFhJ952/lYZ8HDD0q8wLEtYR4K3+jdjr1HOL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5j/14LIwmHlEMqnjB2eU8d4BgjizoSTZb2Pe6KbCwH7ze8GO1+LPt1oBmuizQkbSjMsMA9BW3KN4iR9WgsyuZ1BE2zTIxzaK00TCK2H+FyNXvfbgM+SemViNTUk1kR+umcL1NQlBNdBWO2xA1S2YCHMD65nbhl6hPiSxsax/jjPeOuTOh/GmTXD2kBzOv6DUUROdREgXxVBrHXAa63/rxZD0Y5tSjgy+PoHPfu/WwuQiAHLsuX/4ELQz4Lh+8uqVkIjW4XwGqxNJmboLJsr7ssR9TyKBWyWjZQcRrBTy4LqPnQqycvxZsdiPlZNSnVBxaGm5Tma7GKAoc8+xqxHOFDrf1caB0UNC/7pLjF3Oarj1F7Iil4lgsaEWvdb2BWjshjruvqcYesPVNHz6gt3RlN6I8Ros6ElB4f4iYtkXZJmXJO+pzYdcR5WTGMi05ZDwMgkdTvhyAYdAwo3JxdW/eYAl0MwYKJRFdHJaRTZMoSyBoRzJauG/5PzBjA7XFfh/9/kL4encElbd3tv0RRace/5hAcQUbhDNndsM86m74G1Gv/U3xuDTzkrSrKIKaoLhKzRE7xxhHOnrmJTXj3glvRoVhglVf8K/QzjW6O/DMdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a66df4-621c-48f2-f2f5-08de521e736b
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:06:27.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YioZ1j52kqOQo2MovV5nIdueuYtEI9dvjbRwBkEMHiTqjMcHU29re2dJM1lTNN54BwwEnJeo9BOfd6CQSwHyQr5NTmiCUqXClftXQGxE5q8yqcaYwvgr+yBFx0+4ejU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120175
X-Authority-Analysis: v=2.4 cv=B/G0EetM c=1 sm=1 tr=0 ts=69656259 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=MVYr2jlKrxVruwM6:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=dZbOZ2KzAAAA:8
 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8 a=EX3LST-2qDVoVIZrEmUA:9
 a=QEXdDO2ut3YA:10 a=Kbgs4b6izP0A:10 a=f3wDyV9fTsEA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:12109
X-Proofpoint-GUID: L7jPwVcHiXMHekbx9BrOdHTLDbafk3SI
X-Proofpoint-ORIG-GUID: L7jPwVcHiXMHekbx9BrOdHTLDbafk3SI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE3NSBTYWx0ZWRfXyob+ZlVTEhTH
 5hK8ycds0IqC33qwn7PpgfJB37AHfNSGSjrw3PMsCnjeob90HBbnSHJumWDTPN1hJ4g9L/V8ecg
 cDICrrZeK8k4fdFosyO9zzfAzPS/pg2ph3l1HzSv9swsmZMbpAu6XwPMxhUjHWG1QAZbUX6Gmgw
 FULszhqaQkzJfvQ30EGhtncp8rpbx9TCKkLAUyy5F3uccm91mGINmFLXTmZ7VsfXSTphhOQBnIo
 QgUCiq6ryM/3vpvSstqo9bf+M/g1cM8rdGAxjwl2jABhWdFstNyvQ7NUS5ODszk3/EIl1Xt3vrE
 CRdBLBdD05EcVYNaMTp4D7Mc5ydh16l2JL8/iXvwiuWpSOrhtpNs94AE82tqtGIullz7tm4m15I
 tZjiK87IJLYpYR065bY4xIzB/dSIMsN65DRVxY9VzDKcbbnmlSyJysyt/LfRliu7qr6b+RRpnCj
 bVAPLavGNzXqHtrYiEpwVhzw2KMTXC0UAW8zE6TM=

Hi Jay,

On 13/01/26 00:28, Jay Wang wrote:
> From: Edward Adam Davis <eadavis@qq.com>
> 
> When the NFSD instance doesn't to startup, the net ref data memory is
> not properly reclaimed, which triggers the memory leak issue reported
> by syzbot [1].
> 
> To avoid the problem reported in [1], the net ref data memory reclamation
> action is moved outside of nfsd_net_up when the net is shutdown.
> 
> [1]
> unreferenced object 0xffff88812a39dfc0 (size 64):
>    backtrace (crc a2262fc6):
>      percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
>      nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
>      nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
>      genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
>      genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>      genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
> 
> BUG: memory leak
> 
> Reported-by: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6ee3b889bdeada0a6226
> Fixes: 39972494e318 ("nfsd: update percpu_ref to manage references on nfsd_net")
> Cc: stable@vger.kernel.org
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jay Wang <wanjay@amazon.com>

You need to mention the upstream commit while cherry-picking/backporting 
a commit to stable/lts kernels.

it could either be of format:

[Upstream commit 0b88bfa42e5468baff71909c2f324a495318532b]

or

commit 0b88bfa42e5468baff71909c2f324a495318532b upstream.

on the first line of the backport. [1]


Looks like this is this commit in mainline : v6.19-rc5 - 0b88bfa42e54 
NFSD: net ref data still needs to be freed even if net hasn't startup

Also, while backporting to a long-term-stable kernel also please ensure 
the backport is present in all higher/newer stable/LTS version, so we 
don't let our stable tree consumers run into regressions when they 
update to newer releases. So in this case, 6.18.y also needs to be patched.

[1] https://www.kernel.org/doc/html/v6.18/process/stable-kernel-rules.html

Thanks,
Harshit
> ---
>   fs/nfsd/nfssvc.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index cc185c00e309..88c15b49e4bd 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -434,26 +434,26 @@ static void nfsd_shutdown_net(struct net *net)
>   {
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>   
> -	if (!nn->nfsd_net_up)
> -		return;
> -
> -	percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
> -	wait_for_completion(&nn->nfsd_net_confirm_done);
> -
> -	nfsd_export_flush(net);
> -	nfs4_state_shutdown_net(net);
> -	nfsd_reply_cache_shutdown(nn);
> -	nfsd_file_cache_shutdown_net(net);
> -	if (nn->lockd_up) {
> -		lockd_down(net);
> -		nn->lockd_up = false;
> +	if (nn->nfsd_net_up) {
> +		percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
> +		wait_for_completion(&nn->nfsd_net_confirm_done);
> +
> +		nfsd_export_flush(net);
> +		nfs4_state_shutdown_net(net);
> +		nfsd_reply_cache_shutdown(nn);
> +		nfsd_file_cache_shutdown_net(net);
> +		if (nn->lockd_up) {
> +			lockd_down(net);
> +			nn->lockd_up = false;
> +		}
> +		wait_for_completion(&nn->nfsd_net_free_done);
>   	}
>   
> -	wait_for_completion(&nn->nfsd_net_free_done);
>   	percpu_ref_exit(&nn->nfsd_net_ref);
>   
> +	if (nn->nfsd_net_up)
> +		nfsd_shutdown_generic();
>   	nn->nfsd_net_up = false;
> -	nfsd_shutdown_generic();
>   }
>   
>   static DEFINE_SPINLOCK(nfsd_notifier_lock);


