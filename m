Return-Path: <linux-nfs+bounces-20286-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF6eJp1MvGn0wgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20286-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:21:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01292D19F5
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CEB301A3B9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF635839A;
	Thu, 19 Mar 2026 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kq1/UBCG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qjpQ8iw/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D92459E5;
	Thu, 19 Mar 2026 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948058; cv=fail; b=uFULLkb+fFH++wEL0j3Ye7ppl3/HksgA4GvsPTsiUPYzaPGyU1gI5kVj9yvB1gKH6w2IdjCcU4Ds+CHMTm8qlzyfGLGeNNTA78PjO/h7bwyXcnex6j1ay1kcQT5Eo50BB59Bs+/ML0XshNb6MF6RhacgpIZlGaf5GYYxKRjv4Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948058; c=relaxed/simple;
	bh=NhincFOldGX6hhcKq/wa8qNzZybY5vv4CDHxLYR8Q+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paIXwVQx0+SlvUsBk9qm8mGdJPAceIbfkHCRyVA5Wg3yyUJYm6S5BhFW/YKENFA77Hy3Fcji21xWxrPmtzm000AN0Aj/uOBqBCSba1len2uRxZ9ZWVnHwcBON2fkX+rnYg0OWlDgiw1Y+SUAcWGN13w03elR+oea0H6WNgJsemU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kq1/UBCG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qjpQ8iw/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFkGNZ1711359;
	Thu, 19 Mar 2026 19:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KdGYt2GuOdk8+GIoB86GmScvAtWyI/89lM1nCZzwDCU=; b=
	Kq1/UBCGKq+ahZr3g9ZG+Lhy7b1EM5HfzPOSOjoozMrDYM101xBZMG4xtymWjZSS
	mmEQlXzVXeZ9qI/l//bwZ4Y5qrUwv+ZpnZHPSk+5ynB+kfnmYPv692jbrfe/kkaa
	thW66Q4s9QM5aZclaIlLMoMJZ8l/+t9lAtFDDvTThMEzgw8I4HS26FdDOI48m+mo
	bRLzCnaKTkjGk3grrQchBmk2C0MQL1f/Iw+6vCnbabbDJ0eaCph8rQbb9Q+LENUO
	GNuC8MHWTG89TFdaVaamCuWRYgZbsSQybXwhgSiP+B3rVMY6yp7VI1zbM1VP7fPi
	JxIxhFyLng4IhVuIgB9Frw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj68h3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:20:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JHXG8A002815;
	Thu, 19 Mar 2026 19:20:47 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qkf1x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF3WNOEx1dt3Bz+nnXc9PdIZVyB2gQTBBJB9QP0GaACQoyjrTD1qTPPtcFYcSLwHMdaZxHv5B/SrlRDDRk+2Viz7DZ78shtH5oEBNV9YxBy59Crnlmv7GZ3/t1+c5e+sB5YZtom9K/mpzBglfSOrvuYa97HMy+aQp+WQTEihGWu8M/K5MvlcaobaCNX3/nT7zGLZW+AeNQ0tmjnOIiRFh1hsSPNfaDJnuObxt0wW0OBjcpVboONqjEFUpYPjb/8xyCnAms0LayODgR0aEE9Rnp6quI6fqNuZv18bhC68hwbGiIQecC+/CYllPACMyKBqB236MYkXtWKeEU9HXsIf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdGYt2GuOdk8+GIoB86GmScvAtWyI/89lM1nCZzwDCU=;
 b=i/qGzQmT8d+cUtJw9SLwKyDXaiGipogL+7R7UtsNEUhBEuWbtsqhWZarQNOy8RQsLpuNKvENjLE4xhaNN8YwQiDF2+it3Ms5jYL7z17t/MeyBTtTBfxRq2Q3kHJTlruKeq+imWCLTW5HUKO0P602Yw8uSJmej/bfcnkhAyxZz1pQUffwvQUlkfudGCP8cKraH9rIvnd4hmwUU0r8XL1OMnQ8JPzTu61n5F1owh5JRVFCEl6FAswKrfAgosLjm1iFhoRkxRHbioHR1vAwxxwDO0F1eME74pVBeh3sAOZgYPbrAdtV1fNj0xGRsYDzKRloJd+p/542Df7QMb2C3TJhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdGYt2GuOdk8+GIoB86GmScvAtWyI/89lM1nCZzwDCU=;
 b=qjpQ8iw/EiEpRiZ3LuKH99iuU/5GgkvmR6IX18qG8rK/HgVMA+tIIKz7dK0R99t4t9A6oKUi6e5IC52iKwxZHcQbyLldOiUxmg2WeN4bTYspSVhGtsaFhKAPtTkzskxp5STVMNA5lGdQcMBS07t+Cvivx3bDCcfDz7vbzTLlERA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8729.namprd10.prod.outlook.com (2603:10b6:208:56b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 19:20:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 19:20:42 +0000
Message-ID: <d1cc129a-fb8a-469e-a7c0-16209df0ebde@oracle.com>
Date: Thu, 19 Mar 2026 15:20:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] sunrpc: add a generic netlink family for cache
 upcalls
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
 <0fb26335-058a-464f-ab9f-c109658d4358@oracle.com>
 <c314bb03ebcde4ed58c856a91d895570bd37f05e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c314bb03ebcde4ed58c856a91d895570bd37f05e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b269c9-84f6-4d89-b7a3-08de85ec9c9a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 JLRSWGBsy4KdELweWH6nZsusUDv0Fg9/eaCfklxzTRKDh9ZH4JVaj7A8kSuRNjT5HF5Ca8yF+tyfT9QCT033VLAyZ1tWzb4nP+9TKhF0ftNW1/jJlwnmr5+ULmtac8zq1SL8jc05uPiFzyAchmkURYPyIwXcssEjAeQ26K6EfY8t153mkxKc/1LKPswGbsrC0FCXT96YV0nZQG0JbTZjqD7xLdCWG+zqcJ5JNPxJHLUymbvfyhtR398NQ41vdazpYsB7ZF/oVdWdIiHWNgNxx7Wix27j7DWjZuBmIo6ZL2dag5p7/rBhGCJVirvRsrS51dHhakrCCSoGSu42thUXjXTJCVQXB8aUy5QLuD08+3+RomNwPSrSTRKaR+Bnaj+NRgYCwz7xRTxq9ORppWsbnN0KWQ+J+Ve4CgD5/D/KZO8WCxstpgvwYA0v6zX5IHTXk9sF2Re060HspR2yxExC/DGaHgLbhDiFoNTXcS4BCbtowBFrGGfko1spGcIWK+JyPvgXovH6rmIRVGK7A58bRqJmaXF/ovj7ngggwZOK5IIiwmIwFW5ztreWqlEAmwNUDFVHUja+t+DrwXDPcmoITk9Ev0zMFD4T72pVnn9pdYf2XiUuxdv2L8yRw/6RvZfNU3YPF1CkZiRVHous1VF6DgPjUSqFPPDo9o4kpUA38JiFxq0eMfe5+wGjOdScGEW8V5xm7d8/XNTEHPfyYymK5q29iiN3d+vNhSBqQYBV/nw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d2ZGL2dObzIwSFZzK1BLdndWTHpGVFYzWlhCRFhxOEZQUzNPMVl6Nk5ybGFZ?=
 =?utf-8?B?RVpxSzQxNWF2QmVUbXY3YVJOQkc2QXJsWW5EUnpoU2toSjArSW9VanZFMkhK?=
 =?utf-8?B?YjgxUFFxMmZjT3pKcEdGR2N1N2xrZEJjdEJnL3dhQUlub1ltVE42NTVsaE95?=
 =?utf-8?B?bndDMkVpWWZiZWhjYU5FTWRDM3Y1UUVFalBnZzJ2V29RNUFpZzhjcERjUzJT?=
 =?utf-8?B?NzNOZ2RXTVdhV1cyeXdTZVVXOUJMK2JEYVhCbHdYOHFlZjdGQWcyd1VIa2V6?=
 =?utf-8?B?TEJ3S05xbEJvZVkrVGdiTmdjeW5hM1dTMDZTUW1INmRPMXNZSFEvWWZFelJ2?=
 =?utf-8?B?eStmREx5SVl3a05INzJZWGpJTklSYmhDV1VCQ1loYU1ucER4R1NpZDVHK1hL?=
 =?utf-8?B?T3Z3NVgwTVhlUW8vQlEvYnRJMTZiR2RWNUoxSlJEd2IxNjlodlRDdWU5U21t?=
 =?utf-8?B?TDd0bDZrUEFBVGJHVk56anI2cWRsUHJ0ZWVFWTdBSjN2NitpVnZCYnpQZlJp?=
 =?utf-8?B?Tm9wRkdEaU9kMHJIbTN2ODJWeUlTS25TbTh3RzVweFlQS09ib2lyVDY0Ymt5?=
 =?utf-8?B?RDFyYldqN1p3b0hzODl4VDRHai9hUG5hU0ljZkhXREtLVjJ6RUFNakk2aGNK?=
 =?utf-8?B?WmtFWDVyanR0NVYrZjlQSjJmRUx2U0I4bE1vTUI0dFYrQklMeGpBWm81blhr?=
 =?utf-8?B?cVNBQjJxRkptTEhza1dRODVLcTJLMHdMYk9ScC8zYmR4QWFKcitOc0xFU1F4?=
 =?utf-8?B?UlEyeWp3OVRHT0dxeDdDRklhc2pVRm12SEh6SjJhcUNTL09ScmdRVGJaVEJ6?=
 =?utf-8?B?TlY5R1pka2NoOC8yUElZaXo2VTlKbVJYK3BNYXBibVA3Um9PS0ViQmNaajVI?=
 =?utf-8?B?UGhwaE5sTFQ2QW1Kd2Jmd2Y0M3d4UlRnQkk5WVJJLzlXcGlTbEZvL1A3R2Ft?=
 =?utf-8?B?NE9Zd2dhRS9HMjFTL2wrR00zOU4rU3lHaTM5c1VpNkhFUk02K01aaGlaWTI5?=
 =?utf-8?B?L2J6Qm1jdHp0eFp4dkxTYVhRS2UydUFXdW1ubk9QNm4rTWNldzZsa0JGUXRV?=
 =?utf-8?B?RmpDRTV2VUFDUmNHbUFlNWlMckxqYXh4U3FPMkJ0NGVlODhwbGNSZzRjVEJv?=
 =?utf-8?B?NzAxT3hocGtLcitPUVNPaGk3NEx3b2lPQWlBbmduVlBtbGtxSzg5dlYyeGFZ?=
 =?utf-8?B?SjM3Ky9IY051YkwxMDh6bFh4ei82QVNGSUpxZUtQSXBNbElGVDhNajY0bjJw?=
 =?utf-8?B?NEZuRTFKZDNHTzV5OUwrcHJMRXpTNDlsTlFQL251S1B5YzZyUVdnMXFIZ1Rx?=
 =?utf-8?B?a2RiTHUzb01vUWxuWlNHN2VVYnRWSGVrVXJSN1cyWk9oUG0wa3BSeWg5MXhw?=
 =?utf-8?B?dEVjM1NBSXYzYmltQzUrazBKU0pKN0ZkaGw4Ukk0UjBnNk9SSkgzdjd0S25k?=
 =?utf-8?B?VmdjcFJ5cExPNWF2cFBHVkRxZlBwVkFnVGNOck5QVUtvV3hiVmczSjhkdVJq?=
 =?utf-8?B?UkpxRmY5dlhRaUwzN2NaUWVnOGdGT3VYTWhwMDRoZG5QdHRKTExpcUlkTFUx?=
 =?utf-8?B?aE5OTlRlNWJzWE9uaXI5YTFwRjFoN21OYUZpV2NNZ3dKdFNTL2diWnFxcExs?=
 =?utf-8?B?OGdlZkZHYlRqa0VIUzE0aXVHUSswbE1VTElIUXZmdllycUFiN0hqaVU1MVhV?=
 =?utf-8?B?ZTdpYjdVM0RyNFFsK0E5WjBSWXpFbXlHNjJEL2NjQ3oxZ0xlcDlpdHVnVVdQ?=
 =?utf-8?B?QUVEYnNyMk9waHVqN3g0VkdLWmZ5aExoSHBNRnFXZnZLNnFkZjlGZ0M2WVg2?=
 =?utf-8?B?aWtxYUVxZHZUMXRiZDdVemhSMDhxMzh4N0dBYURXYy92VUE5UXNpSFNrbG5X?=
 =?utf-8?B?em1mMWIxOCtlY0hPMHE5TmVNakswQUNUOVhQZU8rYy85MzVCVFJkcSs4VFp4?=
 =?utf-8?B?WThQSmF4eHNjS0paTDBGd1J0SXV3NXB5U1BzS1FjbmFBOUVEbkxrM2thclA2?=
 =?utf-8?B?VzVpYUYvVGRVU1lhMjlJM0wzMlJ0SHNvdHNmaEU1ZEhCaHIwN0kvMXJKMVpo?=
 =?utf-8?B?MS91MUtPamI5N2N5M2pwcGdZRmorS2YzcmpkcEpsWVZUbVFQTXhYWHlQZVhv?=
 =?utf-8?B?Zkd1Q1dqL3ZZRysrMlg4MXhkNzkwYmsvcml3NGo2R2NsdU02dGI4aTIzUm5J?=
 =?utf-8?B?WnppY3JtUlQvbHhBMTRHZUlpY0ZyeVI4YUYxckFyU3NPdmV4Ui9JY0NaNHVs?=
 =?utf-8?B?VzVIOHBPeWdmcnl5YmIvTWlyWWYzZUhqenYzRjN1cDdyWUd0TVhUT2xGczJ3?=
 =?utf-8?B?Kzg1UVhiZVNHcXcrdGtWak5VZURPTVkvbGlxb3ZvZk9BZGRvL3NzUT09?=
X-Exchange-RoutingPolicyChecked:
	usFCYkv2DpFRTLBHBrQ8nP4+n94fW1kP/y4Kr8HR2WsUM974olmj57MeVW9bkFPylIZZRPJk0jLsNavK2Is7+zTZR2cGTvfYG78/qCRh91v0fYKpfC8+TnS1xq8G1lc0JFq0Sw2sJIeDyWLa2GlycL5pAqqCB1W4NfSen5ARjHXXqdozHffT+Wi9bQF2jOLHTrXgEkUc5QQZ9nI7/Tqv9p8Icf4zu/3cjm8A9UBYDK+5l1Ce3KTlyejBWTUXcwd0/nFloYfOgY9bTuJ+09HCwQs9aoG8Ppt0JDcoJ7aMsAfhSRQduexriCMIX/upivqxnsTWnQFqpew8EruJl/q2rw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tK4NnLL0ycaEdgeIQVZ/0O9gfqutFQz94FpeIA6fDILctcQXbt1d16evjkcIEMw8Zr6O81mBbdjXAAgl9hgczr7rrCcC6PymFXrhdDEKMZJ/RwteKhkwXa7drS8F0vAiksZGpFYExtXRwMkAvjZ/GtIcXdXPw+cnvNbCXlt2J4640d3R8rUmKQwZfS2zDdbgdrefOQmK7NMxepKfSBbHHMbxZ8CR1fQfSUEeQmF+0RtOHpk86Q9TV+9ZIA/OvDFrAq7fMVAP7PIgf7Qh0pFEjrCSqOqZyc32kgpv/iEi4Dk7fD/FG+R1bNJHQBwyuvhpDeRum1HMjjzjRRRtipWQm8RKZggsrjnTeAePZYvJhqyRCMyXomzBO3DEKgBelgo07G4E0CqSY82xS3WG8bZi70Rxmuj1OTq2bO4R4GfyVY0p0cTLDbrQCEmhVfo0oAkGNgXn6UNeCN1R9T6yHi1TgVZQ+nYVJp44Mlndp5l0OOoerDglqFO3In03HAxGo/P4YB0eN6hMmuBgcB19vcjKt0h6fubdsDUtAKBOissSOd1B1/Q7+HUlo76tG1XmW7tiqSZI3fjGhih39Vt/aUb+sxmvuEisT7hWc81uZBwwIZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b269c9-84f6-4d89-b7a3-08de85ec9c9a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:20:42.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2whB3UtVQmwc/MtrWye9WcaEnq4iBfBSq8zS31lNDwjD+hzWNbgO+XTAs6bNEWh6VfTWG1P0a3sgddUL+RgWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190154
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69bc4c91 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=V8oWjfqAujvOwpsJNqgA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1NSBTYWx0ZWRfXzvZYGDkPkzP+
 oCRR1jjmTnTnZizmNJcn09U23LcGMJeqWvKod0Yqec7CuvNQgG8BYWLhBEXBcf/U6vWzkZDWhm9
 aIcqjMY1RjHf6PXU0zlnqZ3Zq89D8NZ+5fGpL4t5W35Yh27Vup5gvCN3e7uOkSetTosu5Dh9Awv
 RytGS0puIHsBIHIaKFK/amBboHipclus7NDM0bNt7Oc9JJICPgbC4UhnBXVu0ETYdfi271pijY/
 PrBFhxJMj2UQrweG+XQxZ+GE0+vjQptkvxOYVlYSzTaSo3pD2b2bo76UStGPvGEmLR5ayG+6gzZ
 bVmHKWeP8vNkc6AaDgwbCUGgmeP7MqHns7b52wV4xbxKLaIIiCrSNjyG6ghRDkrJMFVDmSVtTyN
 7/NDMRoevz/22Q306KQJPXZxOLDkaUe1+h1XX1cXMz2/td3X34gejXPNQDM2OcJPMFAbRF1YFmZ
 ad5PtAUi5cgAYeL7B7SIznZ2BzZQJSAMdpQyX86A=
X-Proofpoint-GUID: 4cVd8dqGzb7KA7Dp1vZoCS4E8670DP1w
X-Proofpoint-ORIG-GUID: 4cVd8dqGzb7KA7Dp1vZoCS4E8670DP1w
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20286-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F01292D19F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 3:19 PM, Jeff Layton wrote:
> On Thu, 2026-03-19 at 15:14 -0400, Chuck Lever wrote:
>> On 3/16/26 11:14 AM, Jeff Layton wrote:
>>
>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>> index 4e08c1a6b3943cda5b44c2b64bcf3a00173a08db..81c943345d13db849483bf0d6773458115ff0134 100644
>>> --- a/fs/nfsd/netlink.c
>>> +++ b/fs/nfsd/netlink.c
>>> @@ -59,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>>>  		.cmd		= NFSD_CMD_THREADS_SET,
>>>  		.doit		= nfsd_nl_threads_set_doit,
>>>  		.policy		= nfsd_threads_set_nl_policy,
>>> -		.maxattr	= NFSD_A_SERVER_MAX,
>>> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>>>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>  	},
>>>  	{
>>
>> This hunk is clearly not related to adding "a generic netlink family for
>> cache upcalls". Should I apply it instead to the appropriate FH-signing
>> patch, which is still in my nfsd-testing branch?
>>
> 
> I noticed that too. I think this is due to a change in the ynl tool.
> The new way seems more correct since the "*_MAX" value is fluid.
> 
> If you wanted, we could just regenerate the files with the new tool and
> commit those changes first and then layer the new stuff on top.

I checked the tool, it hasn't changed.


-- 
Chuck Lever

