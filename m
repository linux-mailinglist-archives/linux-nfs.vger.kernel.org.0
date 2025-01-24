Return-Path: <linux-nfs+bounces-9590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D55A1B956
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F418886B6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53569155759;
	Fri, 24 Jan 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M3EDXmRb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ACLY9s40"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C98130A73;
	Fri, 24 Jan 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732769; cv=fail; b=EjDxiQps2gP+20Q9blQJKnEg9zDqiX9ChXaPLWi/l09q2qEoEK5OhwoXOTA590e6LUpxg1nt6BF2eOTTFomBUNtC/7rj2s7c51+fb+BmOwfS+s1MrqVJ9eBP0vYOVRQFFz7rDdw9LSY6WZCTU5CwgB7tU/LaGOZPXZd4VqEI4BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732769; c=relaxed/simple;
	bh=XXOzfODh6FSeS6wu2IArjxz35ZiemqnsaddmH3kW0mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCQgaR4xUF0l89t10t7dyU+E2aHZGa0rkxx6PI25QSaMQSehwo4QhLZvvVko6jENi3NUiD42CpTNJUru2qKtCchtJkqX6Y3fZ5YXPTgb15BRWSzv5Hf8INkW/4rO8g7gcaelNkqukHKIIk6XYCUvU3Db0/IWD0PcAtyp2aR69b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M3EDXmRb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ACLY9s40; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8gMD4000799;
	Fri, 24 Jan 2025 15:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HTcnT7RX/Gv0evmlLrE8Jbq/4m7g+U2jEKcsV/O9mHk=; b=
	M3EDXmRb9Jqs951Vkr4FNEdsxjyxKdLLordv2bGWYdYL+GkkHKbT3rRuAaQBrhZr
	UgAVZTQ4BQCrptyUXqj0wMhooF3+ABvxGcOqkRhLrUy3rdF5rROwFOun5v2/e5aL
	TE41TO9o8E/v9wzgn0BJXkIHVC4mi5cpNPJjEr1l1+gXd7HYjrOMLKx20Ndxw5nM
	0qEc4M6Y7Zqm22YvkPeRiJputDGkF5PZniXRQJGizOoB6eSdA2fzIwCH2c+LDRlJ
	NqxJ6iVhB5NrQbpGLmS+MgRpSDWhcpl02FOB7Gn7D+ycZiUsyV8ZgW4wxozijxqI
	ZYX7aGnXvNlkXUvvXVcTQw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh4w9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:32:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OF77xI036429;
	Fri, 24 Jan 2025 15:32:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917tm5sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt1wzirtVAeJcEPjNdwlSTO6xkIX1Y+YSEqyTD00XiHujic7ODJYicw/xdQMmR8xIUNYl4KWZvDNmm/e6ganS9Jzg5BgAVtCAfeS6Kia8r8iUJrt75iSJuXFQH8+xfYbWCVQ5pmFDejp7Q4J7tEZ3cUaSJ3XNaGtLfL8/Bbv1uBe8yU2XaJA98/9VluruxiG3NdQvE/FYlRahqlZQrAgxLRvousyxVNOS1RGf2L+Zd+guOomDb2OTBZanc9wCp4gQHp06vssJQUNQBPkLJIC2FOrvdJ3xExloR8vS/7GqH8IfX+7BPhfe3eqmZgpa6tDXyogJsD2RK8bUR9Wckv9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTcnT7RX/Gv0evmlLrE8Jbq/4m7g+U2jEKcsV/O9mHk=;
 b=pbuWG2WfmH+uwexz1YZHuLgAlQtb4vtfOYUFSjDlMFnlq7eq+PqgA6RZWoFE2RgfVmtUTSPM4jJd3YMwq2VsBhD+uowRF95d77gL5xan5WkFqOW5YNkknQSRs9QzDKiAGkEVDqCu9JJuk/9A5F69azTHy/iKv4DyePHNROEZqNDru/vIiUm+x1+u6OM4rWVZkAKDTBiQi3BuJTRMsB9SMTahtPZuoJbb58tGNvVRdtweUN5t+ysijHQLWqj0K10YKdCjtpf0v344d/ocBtBWFJVgE21M/lZAoqrfv1ZbsoXZ7D5Cb14f7uf9tiJ3XCQYiajazzx7KPsTVFNKjFi1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTcnT7RX/Gv0evmlLrE8Jbq/4m7g+U2jEKcsV/O9mHk=;
 b=ACLY9s40YMjkWBjnhdc4EHQ3ivCaKGO6RIS3SkRAFQMrzcN7q9LV75dIqn020am06Hit2UApm9zttTiqEgMa4NVww5ODqb6I6OV9dZkWSCewC9wxaevhmCQgMMvjn+IjP0pbPqYmL+JY1n9/zuegC/B57u4KK71/yZMKNKjYSwI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 15:31:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 15:31:58 +0000
Message-ID: <e8b4f46a-2c4b-43b3-bf82-dc5d8f6af171@oracle.com>
Date: Fri, 24 Jan 2025 10:31:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nfsd: fix CB_SEQUENCE error handling of
 NFS4ERR_{BADSLOT,BADSESSION,SEQ_MISORDERED}
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-2-c1137a4fa2ae@kernel.org>
 <c87e5353-d933-47fa-a4e2-9153d243d61c@oracle.com>
 <66e5e5e74487a274a069539dc14fb10d7832044f.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <66e5e5e74487a274a069539dc14fb10d7832044f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:610:4d::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: ff90638d-072e-45cb-dc79-08dd3c8c3d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUt2THFpK1AvanU4Rm1yRzVMK0lTZllmOWtYUitCNGZ5emRZUC8ySjNVdTFN?=
 =?utf-8?B?c0pHVm9xdEJoOEoreEpXUmRYMGEyVlAvSjhWdEt3Y3lwVDcwWnF4MC8zMmlL?=
 =?utf-8?B?cStEV3VTV1EyOFlUc1BYd3prbTlEczJpTTdwUU9lNHZoVHdsTEs3aDVkQUtP?=
 =?utf-8?B?eDhKZDMwT3VHMzAxb28rcEJhSmpKT2ZzSjB3LytRK29STEliSnE1Y0JqSENT?=
 =?utf-8?B?ek1QL3BRWGJNQ2xVdCtLRW44dklzTndwMnc1d0k5bzNGakhmeStKSFZndUVM?=
 =?utf-8?B?VXRIQzFuVVVxMjdyN1cvcHZhRVBIMWhFbDAxVDdrQTIvSUl1TUZ5ZzBiOUxl?=
 =?utf-8?B?UU53MDRIaWROY0ZWY3pNVm1CT1FqUnZIOWF6RXBVU0l2UmRkRm5nVWRIYi8r?=
 =?utf-8?B?dGpzaGdOM0Q0RllEejYzcXQrdjk3WHJFMlEwaTVBb09jdktmbm5xSk5BMXkw?=
 =?utf-8?B?UUp2WmFjd1FQeDlQOWw1N243b0k5U3YvNFhocUl5aDRzbGV4VFN6eko1T1lI?=
 =?utf-8?B?NTBWTVJ6K3ZPM2d4dDZuZ3I0RVVKZFNKaktvQjBoUHpkdWRhQ1FDbG5QaVM3?=
 =?utf-8?B?aEFWcUlZMXRQZEpLOWovUktUZG16NmhpaGlTYlptU1U4WW5vTzBQNHlUQWFa?=
 =?utf-8?B?SWxCY3MvZXgzNUdJbmFYelU4NjE2UXBRVGkzZm05STZkZDl1b0dCWGZRcVZk?=
 =?utf-8?B?SjFIZWlFYmxRWTd4RkhKcTNJd1NWL0tmaVZsV0VLNlY2dnU1UldxWmFOdElo?=
 =?utf-8?B?NHdTai9lUXl3UDVUTytFOGpwUHZpSDFEQUFMWlFvcXFzVHNzc1ZEQ24rdXdv?=
 =?utf-8?B?OWpuMW1rc1dOUWljaE5yK3pKV0R6aDE4U1lqS3RBUytvU24vZnVicFBSRHN2?=
 =?utf-8?B?RVVKd0tUQ1FXejFOaitIVnhBUDZoRXdGTjlGS05KZUMwaGpzYkNNQlhmdmdL?=
 =?utf-8?B?UFNSSXZRVGtNdGNZcFo3OWZ4Q29rUlIyTTd5MUFQd3hUS0lGSDhEdEQwY2V0?=
 =?utf-8?B?L0RBRnc5OHZ1ZlpUYkFmWDdzTWE3ZzZWczkxRmxFWndMYXdhY09oaUk4NTF3?=
 =?utf-8?B?dHpRUkZRcTBJUlFjWVNXWmVhTENFTFBzdUpEWnY3MElFd0dyR2ZKdW0vRW1K?=
 =?utf-8?B?WG5UcTRMWENJRVQ2SUhYVjgvZzNmWEYrUUlLcC93Q2l5b0QvMTZXL3RzWVhU?=
 =?utf-8?B?M3hMeUNhTGd0U0xkTGNUUmY1TndxOERRMllRcVJyc2Y4UWg1djluUzZwMnQ1?=
 =?utf-8?B?U0NpMnpPUnNncDlyWlNoL2VVeEJWbEZxNTVJejJFS1JvUXp0bjdFdjlZMmFv?=
 =?utf-8?B?akQ5dWMybDBIeW5hbGEyRmVhbEl1Qk1EdkN5VStualBpVHdFQ2FzbHJwRVM0?=
 =?utf-8?B?ajM4WG81VjM3OXlOVU5MQlprUFczekxycDN4YXdYc0d0WmI5OHZNT2h1OThZ?=
 =?utf-8?B?NVVrejUycUFZeVFVSVVVWTkxRnJlSkpJUytUNTFJelRIOHlKMkwwQVg1akU2?=
 =?utf-8?B?NzRKU2gyVzZYYTgzUlpGLzJXUUlQZ1VYNFFtaitiZHVVdmtxSUFiUzBvQnZL?=
 =?utf-8?B?SjUxbkhSOTZmMHhpOXJ6dEYyVmJEajdKOGZjdk1Hb1NoMXhhNEUwVStOeHly?=
 =?utf-8?B?OWlET2h6d1lQTnlOcUZjUG5kUkVmWldKRGZrNjVqMEE0bWxiMGxiSFZxZDZH?=
 =?utf-8?B?WWRsZGw4amhKZnJjNnlsZ0pRV0t3cVhlL0FaQ2pZY0kxQWNtODZFVVRpL3Yz?=
 =?utf-8?B?VC9OcTBhc05yeFczaGhIbkRDVTFQWit1ZDIvZ3VneVNJdXIxVjAvcHJ2K0hD?=
 =?utf-8?B?b0RsTWpjRmRCYytOcStwSXhmWEVmbytobThCZXNLMFpGdVFpMFBaVHgwamZB?=
 =?utf-8?B?cUlMc0RROW5PNEZzMndLUCtITDNhVlJSQTh2bkFFTjRGdUw4bWovNzY3SHhl?=
 =?utf-8?Q?F0y1a9RcYM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnovQlhzUlpTdWcrRWhhU1Q5YVJjSW54RzRIdVhScnE3em1ZeXJobHFHZUVK?=
 =?utf-8?B?SlFBcnJkRCtYUXRXVm56eXYvM0ZhZ05lZHU0bE8yUE5VN3ZNZU9vRUlsdXVC?=
 =?utf-8?B?d21oVjVOWVVZWGlxK1hIY1BFWlA2YkV2eThRM0owV1hyT0RQcnZaSk5abEtY?=
 =?utf-8?B?R2lTdUJ5L1dQUVJNTHV2L2NNSHdOdkg2cGtucDF1WDRNdHRVMmNhRC9YTXps?=
 =?utf-8?B?UW8zcWlYODlGbU8wN0xYNmJ5S29EdG9CMGpjY0FlanFiL2J5M2Rlbk1neDFI?=
 =?utf-8?B?NWZubUVaUWcvQzlVVEQ0Q1hBZXAwc3VDdkZLRmpCZGR5d0lXR0JlMVdxMlp3?=
 =?utf-8?B?T3JjazVVL2VXK0d5V3k3S1pZS1pLWkxCVnNWSXFZdk0zRTJidDRPMDJVVzg2?=
 =?utf-8?B?d3RkZ0N2K3NUWmZGWUZXb3dXZGNHcDNHbVZhV2MzRVdITmM4d3YvbExsTzFt?=
 =?utf-8?B?RDlVeWxGUkdSWUk0NTgvaVczdWFIV1p3ZU9XRkVibTcrQ3RsMWhBU3pHMHNj?=
 =?utf-8?B?ZnNra0FJWjBiUW1aQSt5K1NyQ1VKZ0hPQmhRRUlUTTdCSWFXUTRORDVVQ0Za?=
 =?utf-8?B?MjNRS1Y4R2UxS29kL2x0di85K2dURnVMOTJTc1pyaG1pTjE2dGdwU0dXa1JU?=
 =?utf-8?B?M1dJaTY4alZZck5NZWFQY3BzTVlJOHdSWDVDLzFHMzRpVHZ4cGZHU0Z6Kys3?=
 =?utf-8?B?VWc5eXdQWXcyOXhMZVYxbzUxeWJyZkhsQkdzdHIvTDlhTE1DV1V0VjZGeXk5?=
 =?utf-8?B?eFFKd21KT0M3U1V0STh6eW0vaU44THJuT1VZY3dibk52TFcxQUdwRUF2OWNQ?=
 =?utf-8?B?QVRtaVEwNU1pcENobUhla05uWTA4Z1ZkL1ZENUtMVWo3RWJVSnlLYndhTDVS?=
 =?utf-8?B?SVpEYzU1RHNPcmM0V3lOb05XdXlMaERQUTdWd2dvNFNrcWRQbW95azE1OVVO?=
 =?utf-8?B?S1prU1ViSkpPSTd5ZjBNTHdlTU9oL2FJa3JuWkVLb0NDdW9XNXRCc3hzZ2lX?=
 =?utf-8?B?SURQMEl5dEhGRXZiQ0F0cVlBblBmTGY5VENhZHVMKytBN2JSWlNvV3VJaytx?=
 =?utf-8?B?QkI0Wm1FSGt6K0tjamk0OUtBZU9VQ0cyMTFPK2RlakQrYVYxczY4dnE4QVAv?=
 =?utf-8?B?U1J2Sjk2L01aY1ZKcTZDU3dzZ2lZOUFWbWRZak1JV3ZGR0c5UmMzdEhaTlNr?=
 =?utf-8?B?dmdLYW83a1dQN1ZKemdwTzFsVjJ1bTRNeXZYU1ZvM0p5OFhtWU9ZNzBJYVRL?=
 =?utf-8?B?cVlRMmsxV3pWa2xwclZRbjNGRDR0MnJxYlhKdXRYeWg3c3hqMWdJaktsOFZ0?=
 =?utf-8?B?aHZNTitKZzhRRlpHQkxUTXB3WU5idE5PdGVRNEd1ZUN4WjQrNG9JLy9Mb3gv?=
 =?utf-8?B?OENMajhqSFhSVVpsZXB0Kzd5aVRWWWRsMmU4TGk2RysrVG9UZHZzZWlvaW4x?=
 =?utf-8?B?SFpwZ3pzWThVNENmSVpEb1RDUDcvTGxIMGROUzZ3Q0pTZ0xFbEF0akRZYWE4?=
 =?utf-8?B?ZXpIT1JUYUgrTUx6Qi9QYm5qbSs4K1ZCVktBMkZQYkZncjNYaXgyc1FIcXpu?=
 =?utf-8?B?eTlqSzdnM0FoN3daSVZYR2xtZ2hlNytGTGdMVEk0a3l0dlBHZEVxbDlhOXZX?=
 =?utf-8?B?aG1GR211bWJ3U0k0Vi9NWU9CMGJqTzNCRmR3OTkzbmphU3l6UkdSSHpnK2ZV?=
 =?utf-8?B?SjdQNm1aS2dKZ2F1RHVobmRrd2RNUUhLaTdrcERUTXVqdDhtVElpSUZBT3lr?=
 =?utf-8?B?c3V4bXVtZnJkajFPa2tjYUErL0tJSVl5L3c1a2s3a1Y2bWtKYkNSc2I0NEFz?=
 =?utf-8?B?Zzc5TC8vQjFFNkxERWVXNFhsbVl4aDhhV08rckYyTnM2R1I2bjFPYUtQWEpK?=
 =?utf-8?B?SEw5M0NETklhb2doWFFITXRiWXFUKzdEazlNREFDOVNGNFdjR1hiVWJqWWVW?=
 =?utf-8?B?Y21pUUhCUXIrUkwzdVpHMURYZkIwUm1ZSlp0SHJrQ2lXSHBUbGpmanJjN1ly?=
 =?utf-8?B?QmZmNWwvU3gzdmFBS3IzdDNqTGpJOFB6WVg5WFVpOTlKVTBzdDJzaUNSRDhh?=
 =?utf-8?B?WXZIaTI5aXZvOFcvdHBZTUp1NXc0QStDSW13RjBna3YrZDJEWmVmOWFMYWJW?=
 =?utf-8?B?S0JrTGFxaGNvRFMyT3RPeHZHNUtNWjcrTjRRU0NpOFY4Umt3aVNya3pnL0F2?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	erW4feR5ROPA0gy2m9ik1NbUOahjcM5n8Y4NI2OdE7m6mj+i7dxKoOExc8w4pdF4BUyHZ9sI26uGCs6SYfFfBIBUJB+3TNSW+2dTxHqEO1xsu7CBHxJbCEi3+xmgzkrUW/4YRVebeHQLIIgJH1BSl7TM6JCsRkYiLzO10vcjtdiLxznnxLqxmeKjFYz8tLrwH+pvxksJQ7S3nDalZkCl9q7r8v5XW1W5G0Q9vPoCFBHr9LBpdae9n+RSjwk7R/p1Ah2vGfLp0wK1s8WoqQZVxPnRwobKyh07iGbI4Q9597q6ZVSj6hX6oKTiyMP3VUwlTs7q8oZdCwOfpmfZYQ8OFpKVz3EMpEMp+JLSMtT0T4smaV9dRPgF4AhmVAdCFKw+aCCJJTcJdeuQCOM6UWueXF6b6HzUlYD04z4Bc52+juoaeBcr6QBAYybGaO1vv2ta5Jmk9FmvC8nhi1Co6ZKQ4zBWFMKjdfNZWmjOxtYVf7zmywB5QxS3SEsVkuLGvIdow29RzKJMGWXhJ+AWkyPPfsyxvTiTtM0OusA39zEHW89CnTcpiF3M7UAlWDenhpTlXoxPOKsTrLcTHEm2eHJXAkOsEKOdfg14sE5ErCl0+Rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff90638d-072e-45cb-dc79-08dd3c8c3d5c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 15:31:58.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9sLPhiPS5bT5aT+CrLpc5O7HmQLCyq6H4oLRrciQf11qvkEJ5FYi4E1xCzvbiEseMKNM15yr6IELSscLYi26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240109
X-Proofpoint-ORIG-GUID: XgdkeSA-0yQxJ5SKuHHmDzYrGlPASKrp
X-Proofpoint-GUID: XgdkeSA-0yQxJ5SKuHHmDzYrGlPASKrp

On 1/24/25 9:46 AM, Jeff Layton wrote:
> On Fri, 2025-01-24 at 09:32 -0500, Chuck Lever wrote:
>> On 1/23/25 3:25 PM, Jeff Layton wrote:
>>> The current error handling has some problems:
>>>
>>> BADSLOT and BADSESSION: don't release the slot before retrying the call
>>>
>>> SEQ_MISORDERED: does some sketchy resetting of the seqid? I can't find any
>>> recommendation about doing that in the spec, and it seems wrong.
>>
>> Random thought: You might use the Linux NFS client's forechannel session
>> implementation as a code reference.
>>
>>
>>> Handle all three errors the same way: release the slot, but then handle
>>> it just like we would as if we hadn't gotten a reply; mark the session
>>> as faulty, and retry the call.
>>
>> Some questions:
>>
>> Why does it matter whether NFSD keeps the slot if both sides plan to
>> destroy the session?
>>
> 
> It may not be required, but there is no reason to hold onto the slot in
> these cases.

In the BADSLOT case, if the slot is released, then another session
consumer on the NFS server can use it and will encounter the same error.
Best to keep it in the penalty box, IMO.

If there are other slots, they are likely still usable. An
implementation can choose to continue using the session rather than
scuttling it immediately. In the past, with a single backchannel slot,
NFSD had no choice but to replace the session. But now it can be more
conservative.


> Also, at this point, only nfsd has declared that it needs
> a new session (see below).

If the client's backchannel service has returned BADSESSION, then the
client already knows this session is unusable.


>> Also, AFAICT marking CB_FAULT does not destroy the session, it simply
>> tries to recreate backchannel's rpc_clnt. Perhaps NFSD's callback code
>> should actively destroy the session and let the client drive a fresh
>> CREATE_SESSION to recover?
>>
> 
> Marking it with a fault just sets the cl_cb_state to NFSD4_CB_FAULT.
> Then, on the next SEQUENCE call, that makes nfsd set
> SEQ4_STATUS_BACKCHANNEL_FAULT, which should make the client recreate
> the session. Obviously, there is some delay involved there since we
> might have to wait for the client to do a lease renewal before this
> happens.
> 
>>
>>> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4callback.c | 27 +++++++++++----------------
>>>    1 file changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index e12205ef16ca932ffbcc86d67b0817aec2436c89..bfc9de1fcb67b4f05ed2f7a28038cd8290809c17 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1371,17 +1371,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>    		ret = false;
>>>    		break;
>>> +	case -NFS4ERR_BADSESSION:
>>> +	case -NFS4ERR_BADSLOT:
>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>> +		/*
>>> +		 * These errors indicate that something has gone wrong
>>> +		 * with the server and client's synchronization. Release
>>> +		 * the slot, but handle it as if we hadn't gotten a reply.
>>> +		 */
>>> +		nfsd41_cb_release_slot(cb);
>>> +		fallthrough;
>>>    	case 1:
>>>    		/*
>>>    		 * cb_seq_status remains 1 if an RPC Reply was never
>>>    		 * received. NFSD can't know if the client processed
>>>    		 * the CB_SEQUENCE operation. Ask the client to send a
>>> -		 * DESTROY_SESSION to recover.
>>> +		 * DESTROY_SESSION to recover, but keep the slot.
>>>    		 */
>>> -		fallthrough;
>>> -	case -NFS4ERR_BADSESSION:
>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>> -		ret = false;
>>>    		goto need_restart;
>>>    	case -NFS4ERR_DELAY:
>>>    		cb->cb_seq_status = 1;
>>> @@ -1390,14 +1397,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    
>>>    		rpc_delay(task, 2 * HZ);
>>>    		return false;
>>> -	case -NFS4ERR_BADSLOT:
>>> -		goto retry_nowait;
>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>> -			goto retry_nowait;
>>> -		}
>>> -		break;
>>>    	default:
>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>    	}
>>> @@ -1405,10 +1404,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    	nfsd41_cb_release_slot(cb);
>>>    out:
>>>    	return ret;
>>> -retry_nowait:
>>> -	if (rpc_restart_call_prepare(task))
>>> -		ret = false;
>>> -	goto out;
>>>    need_restart:
>>>    	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>>>    		trace_nfsd_cb_restart(clp, cb);
>>>
>>
>>
> 


-- 
Chuck Lever

