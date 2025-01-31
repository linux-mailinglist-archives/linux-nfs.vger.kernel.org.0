Return-Path: <linux-nfs+bounces-9808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E8A23F52
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB031692D9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048C1C5F1E;
	Fri, 31 Jan 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PEmIjLch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h6iki1+V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDF1C4A16
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335588; cv=fail; b=MVS8QeBgSz7WSQgWgSFWMJIFA851vxCeydPh7sBuVrcNSqdBkZgIc5w71H2cI7V0R7r3eLmDX+TgEQ1QtmDZIj4jHAuSziLzIb5tP+43T0HGWKx9upxpKdcR4htcC6YC0YqYsKgUmZvhxTYBzkR3IrcwZ5nAClyFkjhd0HMdKmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335588; c=relaxed/simple;
	bh=rvNhWwK9mXLIei+yrka1+28Vw8An9MXHqHKEuv7U7xQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l2gzUeu7y94s7NTJUmQG1oHcT+eXhonpEV8Yd9Vj/838oX2ZNlUXJP3l8PUIqJ5GGV/phevjMnNgvBwDK+l7nr+kmYnZD0HjSndc1Jix3Dw+453WuMw4nSzWnFSsLtQyrGq8YjiXvEbkAfUU/fGYTIhqgKmOp/M2nYp14La4J+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PEmIjLch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h6iki1+V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VCtx4E020893;
	Fri, 31 Jan 2025 14:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IaQjDBCFc/e5ZQFawBASEMOfFf6qhRtv5Jq+VUhb5eA=; b=
	PEmIjLchrz/sFUVm9JsNJiH6HDeNqALhBD9RRDOchW/ntOHLFLPE027ySZsjqwp3
	x2wnpMVYoshS7zPUiLIraYCuo/2VS50XMeUzKum1OpLpg7YISV0rVAJQCuQE/bkV
	gaUTwA6Y8xJqoS1wmrH+I9mzGrd07fxOiNyJ1llUboJ9cu+MZdTqgL0nWZc8vAsh
	+9WOHBlnQli5DTVzJyeQv8uStcx+U3UR+S9G4fqNo5yZzCsqDWt7fM1a1TBPREg7
	yGPuI2K5jJ2tgNjOlCEeNylkhYkFUyhu0ZqYPCfdGkIwsw5ye5+/bO7iXDCh7y8O
	zUgGqJdNcIkU0tYp7smSGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gx1289t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 14:59:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50VESLjD016648;
	Fri, 31 Jan 2025 14:59:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44ggvkd5b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 14:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRcNVhPa7OBfp8TWHzQIxuwD/JLAsnJb+ahuwBwNBCSl7INVKf6xL6YNCIy7FwrT1S7FlX3IjPkZxnxHH4/D7g+FXX1joPSVmH50TOaRC2jdUck8rSIXB0O+hGovT8BW+aBWDZQtKcc6rt5yultY77TvkIObnPYQQ2sfmZfExAhcmT2/a8ttJGkQrnd7xo4wU+ufXg27P6G9Dj5fy+CyrYtzvicbIPjou28iaBIuXrlqH/GwzuVbsr8VPfNoV1ZT/IzzCqj9jgFw7cJR1d3xaqOLA+wuAohlV4C96E4NQqsyZxgPJuMYkIc3ZvcuxGzhJJzlWgmt5IfeLlt8fQgITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaQjDBCFc/e5ZQFawBASEMOfFf6qhRtv5Jq+VUhb5eA=;
 b=SmxWh+LNiHPRA1XuC2WfT3OSRd/0jKlqoM9ds6nkPCeuAUc0cdYKFZamCFy6gO0Sex47/WzkkZHbCY37vfbWXm3iMLCqk44D+YZ0ueoR3ZBKSXu9MSVxznqtyxRLM+f/IxOLBcQbp9p3Vgq2U+NrKFzf3m6elovxRb1KSff0sja9xOUPlqWrAbZjeiDzXByu0S9sk7UmZ5ljsakEaitTV7+KKKszASXJq9Mx5w/TmCaRYBdh+T8wvLGdBZDenk4Y1Be2c0izddFD7Gpgf08wKjAx+xSSFZW/mJpTShizq1GHd8R/zPr0ot6HgM1u+3xQTM9VPyZikXXWgPWhLdp5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaQjDBCFc/e5ZQFawBASEMOfFf6qhRtv5Jq+VUhb5eA=;
 b=h6iki1+VO6gK9zh28M/FmuQQXMCA8y8OXjVVRPPePzUFUA2V4pBtyFdjtrVNZGDOB88AAbAGD8K8J8WvgXTGu4gE+fPEJnBNhF6AyqXDqjTyjG6MYqP13IK05gRoJWca7+mHTfnVqg4Fm6oKnjCj/0GnLSsMA97/4D65GSi+GDc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 14:59:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 14:59:29 +0000
Message-ID: <7c6d3503-f67f-4ae3-ad11-f6776c5441dc@oracle.com>
Date: Fri, 31 Jan 2025 09:59:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Thomas Haynes <loghyr@hammerspace.com>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
 <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
 <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
 <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com>
 <afb9f3f0-0fd5-4b8c-b407-7676a9267e8b@oracle.com>
 <b6e28487-ac25-4835-a052-c084db309648@oracle.com>
 <CAN-5tyGEHkdmXnepzfx7cxmjRcM6b7zou7ooyo=i0VfOPmZNFA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGEHkdmXnepzfx7cxmjRcM6b7zou7ooyo=i0VfOPmZNFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:610:57::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 084dfc80-9156-4229-01e2-08dd4207dcae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODhYN01heUZtdTN5aWg3RkE1YStZMUlzNlRMTUl5bmsxdjhOczRUZ0IrdXN5?=
 =?utf-8?B?RnBLMEJoc3oyMDlNV3RhaENRR3Rmb1BVcUtDQnovWVVxS3BXUkhyb2V6Z3Fu?=
 =?utf-8?B?OVI0TXY0Y0dXSFdMM2VDL3M3U1BPbUF6eVY1MTNWdXB4VUhKR09QZ0JZNklC?=
 =?utf-8?B?WksyMjhacXF4Q1h2ZHFUa0VKSkdSeGN0VzhZVzN6aHpnc29zZHE4d0JsQ2ZX?=
 =?utf-8?B?MUQ4aERUSlBtN05rNkFJeUwxbkRDaUpkMWhvRi85VW5mM0c3TWJ5aW1Ob1Jy?=
 =?utf-8?B?RnJwWGhIM2dWZkttU2twa2RsWHdZalVEOUg3WkQ5SkI0VkRBbWpRUHc2MHAr?=
 =?utf-8?B?L2hEWk9pMW1Ocm9BWU05dHJnS1ZjZWM5U05zVkFPbUQ0azFNbS94UVhnNCsy?=
 =?utf-8?B?MGhzaFhxbFR5Y3lsVlBIOWJIeExtd0ppRjd4d0FhSHpyOTdnb0I5TlZUUWhs?=
 =?utf-8?B?bUxMbnNuMGVEMVloVDQ2R2NLN3g2QUZ4bThwWU4rUnhCTkJIY05LU0dEMEEy?=
 =?utf-8?B?T2Z5dFIzTWZkZWNlcGt4eEN1LzRyemNTRGpCcEYwWFJuU2R6T2VOTmJIc0ly?=
 =?utf-8?B?Nkg4cElDY2o2UHJoRnI5aVZJYW1YNGRlVEM2ME1KQVJSRm4xMlc0ZW9nQXN1?=
 =?utf-8?B?ZDd2R01SckZsdUx4M29BWWJWdDZ6czRoRExCVDlGWUJnQUd3bHQwMFZBbjFB?=
 =?utf-8?B?SVBjWENpaXRiazZJRnI4ZU1FalNjMTJMek5kTk1OYUlGMEltUzdWcXpyRWt4?=
 =?utf-8?B?VlpFdkFUeW9mck1WdGxtUXBXT0ZpQzFKN1oxL1piMWJkYTdPQ1pBSGt4SjY1?=
 =?utf-8?B?aFBWVlIvVXp2UzRWL0xmZndyb254SHkxM05HdStXbDZGU2VPMmszVVJWNkY4?=
 =?utf-8?B?L0tUYzFSRTlUaHNobUowcXA0d21wU2RqWCtYLysvZElpaStMZ0xOV2RMbUdp?=
 =?utf-8?B?NysyazU4SUhvOGl5RWxYR2dlTjhobXlTdzFmN3h4bHd3TmVYcytzL3RyTk50?=
 =?utf-8?B?bTFCSGtDdURKVE9TeStGMDNoTHpVUlBNWG5QUDBzUm1VcGYydWthRVU1Ymo2?=
 =?utf-8?B?VHk0ODkwcWd3dUxpSFErcjlmcXN1ZnFNbFpGQ0UyQ3ZDaXZVcG9RQ0VHclBV?=
 =?utf-8?B?Zi91WmNqNllxKzBOL1ZNYWxMazUwRktLQWV0eGx1TStZTHgwSnRkRDQ0d0Zq?=
 =?utf-8?B?NE1zTUlUTDVYMXQrRzhGbFNaWS9rR1orWmN3YkpSblladXBmQ3dGdGVrcWxa?=
 =?utf-8?B?Y0tSS1dxZVlTRE13aTdzUGM2MWtEb2RLSVRwQ3BmdUtoUWVpQ21hZEwxMjRR?=
 =?utf-8?B?MjBzMlRjaThBQ0hteEczT0srM1AyT3JwekxaUnBDbXRreWdwYlN6K29STk9P?=
 =?utf-8?B?SStyYjJhYnRWL1hycllPby9ZWkIxSVk4M2x4eW9ydlRuRnpnTlVIVEI3MGp0?=
 =?utf-8?B?azVJd1IrTU9hb2loLzQ4ejE2ZG5NbGZwQkNpM3VBajFxMFhvay9hTTdObkNs?=
 =?utf-8?B?YXg1QWNFUys3ZExqM25uR0V4MVRXNDZ6K2trTnAzMElhbGw0NFdpdmVEK1hO?=
 =?utf-8?B?QmNDZGhXVjBGL2lpTk4zeFZKa1Z6ZVJSNHNQdjhobzhUaVZ2Rzg1NjRkbWc2?=
 =?utf-8?B?cjFDL3M1Qm5PeGhWbDNpRy9rSXpxSGdJSlFSVGU2RzEvSGUvSGYwYnFqTUZ3?=
 =?utf-8?B?MUdCeHh2NG5tQWIyWVRTWWZHOXc1S3BxZTZMaExzTHZUc1BFSFpnTUtITExa?=
 =?utf-8?Q?K/S/3kHdJqdf/G5mdMnbglYs0kAz7HhMiC0x18h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0p5R2ZjSmo1VFA2QmtHakdyL2hOUWQ1QmtneGYvVUw0SUZ0eTFFR2ZVWTA1?=
 =?utf-8?B?YmtuLzNMaXlWQ1NGRWY5dXZRSlo3eHY2K0Ywc2lnN2hKWGNQMTRtcmQxRlB2?=
 =?utf-8?B?NlFmeUNIQkRZUW56U0hTR1AzZWo2enNNa3NVMVhXZFRhc0wvN24zZ0ZsV2Vp?=
 =?utf-8?B?NGxGNFBCTlRpVkEzMjQ1a2JyTzlkNnNYeWw5blJVZWZyR0NINzNIRkZPUWN6?=
 =?utf-8?B?eFlvb01EelVaUzFDeU5ZM0JncmJXQXQ5WGp5VTV4Mm9XZURvTG05dUtXNGdD?=
 =?utf-8?B?cUt6M0ttT1BGKzMvUGFBVFhwVDF2VDBCN01NQTBUS21mWXZhY1hHWE1iL0k0?=
 =?utf-8?B?VHduQnhoZE1VWXo0cGxiTVZ4Sk1hZmw1ZHhJS0MzOEpvN0s5aDI2WFZ5UU5s?=
 =?utf-8?B?OGpWU2lZampPM0cyL1d4OUZ0RmZUZHVpTTdzTWVyZ2Rmdk5RVFVlcmZ5MWx4?=
 =?utf-8?B?NFN2TGJzTEUvc0FrbUF2ODRMRFVoZXZsL2VaR3lhM3RwK3dhVXlvVTlXUDFx?=
 =?utf-8?B?RWpJUkJVMkFTcUZuRVJxSTRDeGpTVFNjYjhINDdsaThETllmNmFhbWsvVzJY?=
 =?utf-8?B?cU43ZWJqa25qai9Eby9senlUWWsrL2dRN012RWdhUmVuZGFnV21xYlNZSHVT?=
 =?utf-8?B?cUVQOUJyeHVSbnBGaEF5b1B2NlZtWWVFaS9nWTdHc1ZJQ3E3RUJNRUYwbkc2?=
 =?utf-8?B?aU9BbnVUdmpJZjdXQnU1dng4M3V0YzE3cnkvMkVXOUF4SFZrK0loM0JaYWhZ?=
 =?utf-8?B?a1NTZGhacE1xQnFERW1QNmFWbTYvWmlWczUxc3QwbWp1YjZURm43aHJXNjYz?=
 =?utf-8?B?RzJlQWNzUmE3a2plaEpUbUNrcWhTdEN4aVplL1RPR0JKNU5nWHI1eDRjRjBi?=
 =?utf-8?B?SXdRMDVUVGRMY2JVbXJqQXlneG4weWtyQkxEcHVkVGhhNEtwVm5mZ2NmY3E4?=
 =?utf-8?B?aVppRStIcUJoOVB5MmowdjBUU3RkRVd0dHdINjJGK1g1V1VORk5mRVg4Rm96?=
 =?utf-8?B?Y2gwZnlHL2thbG45RDVzTm1vYTZPaWx2Tk5kYWVMWWV6N2poYVdITlBNWEpQ?=
 =?utf-8?B?TWptQmRjRzBnWTI0QU12Z1hyVzNycGNOYWh6MzQwL2F0eFFmd1VmZHp2VFN4?=
 =?utf-8?B?NVpiUFlDT0FhcXl5VUg5T01iRThMbGhkZWlhNzBLQWxVejhjN1dEWURWU2lZ?=
 =?utf-8?B?RlhsMkRQaTBSRGFoempsWkhTNjJWMFNoN3hsd1JQdHBXWGRlSUNkSkxPVUh0?=
 =?utf-8?B?RGhIN1NvZ2ZkUktOdXdYOGRQWjFHdzlWR0FiM2wrWEVDM2dMUTRTZnB2ZC95?=
 =?utf-8?B?STNsd2xGYWl0QVQwanBLaUF6Y2ZQb3JuNXpFSmhmdzVpN1BENjE2WlA0cUpl?=
 =?utf-8?B?UWdrODJCdGwwM1AweVl0dE9Uczkvek5qWmViU2lBVHJ5VnZEMWhRRVV0Q1BF?=
 =?utf-8?B?dEg0dnJ2VkltRk5YdllDL1Nnd3lTSzh2S0VMYWxsK21UeStCRU94VVJSVUpz?=
 =?utf-8?B?VnlXOWJGcGtUcE5LWk9JL1JmVzBNNklicGF2SDRZR1YvbGQ1ZXRWWEZGekR6?=
 =?utf-8?B?TENscm05NUx2UGtPcFRkQ1hxcjFzY0I3dTBjS1AxS296b3RLeVJLNHhPVDZu?=
 =?utf-8?B?cGtBVHlGS2hxcmhNSzZaOEZ1RVFNdVVETGtidlhWbUVJV0oyOFVqNjMxRFlB?=
 =?utf-8?B?cHNkTUQwM1BFaHZNWE1RbmtmQmUwczZIYWp4Y1BrQkkwQ0tFdEJ6R3gwMjFM?=
 =?utf-8?B?T3BzS01tTDVvS1Y1TWMwNnM2L3REYVd2c3k3VFc3YUw3NmtCdjEyanpENUVl?=
 =?utf-8?B?TXdrbFpDUzdFTGEyVHpkclJoUnVFem8yS2owbjgxYnFZVlJyY3RWVGVXZUxv?=
 =?utf-8?B?cnZFNmtFVkxUcWNwQXA4c2JYZ3l1MUQ5QkV6WXRWdGVSN2VVL0hSbGt0b04z?=
 =?utf-8?B?WVo0OTdVK2hsVHFjTXNPRnRMSTI5bUNsUDR3ekZtaDZmZDAvNTN4ai82eTBi?=
 =?utf-8?B?ZmgxNk9CaG9FdXpwcHR2TkcyZ08zTFpQTURZMWRqTlgwNytwMVFBSTd0OEMy?=
 =?utf-8?B?TkdRK3NaOGFubDhmc1RMeW5GMy9Uanlzd0NubzJPN2tLVEthaDQzWDkxNHpW?=
 =?utf-8?B?Rm1XYUlIM3UzUTRxSkZHSHNpblVWNE5pU25vZ0lNYTZVM1ZiaDNRSG9nMWsw?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bK5bMJZuUZx04AcahEKa1gSKxi9j6uYwWwvTf35TOX3UOr4ls1J54yjrC3f+S0D8uSKSSptuP4mwGEqTqRcUNQppBzGfFaela5fDuRwus6YEHj+ipDpGgIOFg/xvj9VA4CCrQhQej+ZBQiwqswVGoscQvQP9mRAg4B09HJ20uKc1tWtJzUE6WS3lHYBl8p60mHfUE4UEwBAAWI2f68eaDRzd1ixyh5MwGJ8OC4v/Yhnabetu6zKXhceNlXOG172D89qo6dgE8RIPAEFpSaHhV3Voztj5RTHdXYoaZJJ/C0g+xxQmTlTKkmKlbzOoS/TDCERqpHvL29+uXES5LrQd0ZnYvy4HBL8+8nwQov15bwRy6qdQzzXq6CBBpipI+mYeSbv6Dc1hCPZ/L+NjzfUjeQxgCoPphk7w9+jKvZBUZKgReIEg8RhFEGMjpiEZPazrFQ2Qi0RPtHYkcH68eu9ejhPRC5gG4IDT3n+iZdtX1vyRzUuHcrllu+8fdOOWH/v6dqfRx9nsYZXpoEffdAW6c50FR0mgeRb26ZpupyeUSZCD1l1T+3pyXUDOL2tGkp1FFYrdpSEUtidYgH98xGpups/R5l8bmGowyqEJ+z0t+ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084dfc80-9156-4229-01e2-08dd4207dcae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 14:59:29.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQeTiMkc7m9kdzJj4GYjIxWyOwXyRrVA0/nxjz6w6w1ExDNgufQG1IItbUtxRBIM2CvtxdpqRhC87pv2ydCz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501310115
X-Proofpoint-ORIG-GUID: dUaSKPbd3LeUYxJpmGfcKlzzvv0pzpTO
X-Proofpoint-GUID: dUaSKPbd3LeUYxJpmGfcKlzzvv0pzpTO

On 1/30/25 3:43 PM, Olga Kornievskaia wrote:
> On Mon, Jan 13, 2025 at 9:50 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/4/25 5:00 PM, Chuck Lever wrote:
>>> On 12/30/24 10:33 AM, Chuck Lever wrote:
>>>> On 12/29/24 8:52 PM, Trond Myklebust wrote:
>>>>> On Sun, 2024-12-29 at 17:37 -0500, Chuck Lever wrote:
>>>>>> On 12/19/24 3:15 PM, Chuck Lever wrote:
>>>>>>> On 12/18/24 4:02 PM, Chuck Lever wrote:
>>>>>>>> Hi -
>>>>>>>>
>>>>>>>> I'm testing the NFSD support for attribute delegation, and seeing
>>>>>>>> these
>>>>>>>> two new fstests failures: generic/647 and generic/729. Both tests
>>>>>>>> emit
>>>>>>>> this error message:
>>>>>>>>
>>>>>>>>     mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT):
>>>>>>>> 0 !=
>>>>>>>> 4096: Bad address
>>>>>>>>
>>>>>>>> This is 100% reproducible with the new patches applied to the
>>>>>>>> server,
>>>>>>>> and 100% not reproducible when they are not applied on the
>>>>>>>> server.
>>>>>>>>
>>>>>>>> The failure is due to pread64() (on the client) returning EFAULT.
>>>>>>>> On
>>>>>>>> the wire, the passing test does:
>>>>>>>>
>>>>>>>> SETATTR (size = 0)
>>>>>>>> WRITE (offset = 4096, len = 4096)
>>>>>>>> READ (offset = 0, len = 8192)
>>>>>>>> READ (offset = 4096, len = 4096)
>>>>>>>> SETATTR (size = 0)
>>>>>>>>    [ continues until test passes ]
>>>>>>>>
>>>>>>>> The failing test does:
>>>>>>>>
>>>>>>>> SETATTR (size = 0)
>>>>>>>> WRITE (offset = 4096, len = 4096)
>>>>>>>>    [ the failed pread64 seems to occur here ]
>>>>>>>> CLOSE
>>>>>>>>
>>>>>>>> In other words, in the failing case, the client does not emit
>>>>>>>> READs
>>>>>>>> to pull in the changed file content.
>>>>>>>>
>>>>>>>> The test is using O_DIRECT so I function-traced
>>>>>>>> nfs_direct_read_schedule_iovec(). In the passing case, this
>>>>>>>> function
>>>>>>>> generates the usual set of NFS READs on the wire and returns
>>>>>>>> successfully.
>>>>>>>>
>>>>>>>> In the failing case, iov_iter_get_pages_alloc2() invokes
>>>>>>>> get_user_pages_fast(), and that appears to fail immediately:
>>>>>>>>
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310394:
>>>>>>>> funcgraph_entry:
>>>>>>>>>         get_user_pages_fast() {
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310395:
>>>>>>>> funcgraph_entry:
>>>>>>>>>           gup_fast_fallback() {
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>>>>> 0.262
>>>>>>>> us   |          __pte_offset_map();
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>>>>> 0.142
>>>>>>>> us   |          __rcu_read_unlock();
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry:
>>>>>>>> 7.824
>>>>>>>> us   |          __gup_longterm_locked();
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>>>>> 8.967 us
>>>>>>>>>          }
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>>>>> 9.224 us
>>>>>>>>>        }
>>>>>>>>      mmap-rw-fault-623256 [016] 175303.310404:
>>>>>>>> funcgraph_entry:
>>>>>>>>>         kvfree() {
>>>>>>>>
>>>>>>>> My guess is the cached inode file size is still zero.
>>>>>>>
>>>>>>> Confirmed: in the failing case, the read fails because the cached
>>>>>>> file size is still zero. In the passing case, the cached file size
>>>>>>> is
>>>>>>> 8192 before the read.
>>>>>>>
>>>>>>> During the test, the client truncates the file, then performs an
>>>>>>> NFS
>>>>>>> WRITE to the server, extending the size of the file. When an
>>>>>>> attribute
>>>>>>> delegation is in effect, that size extension isn't reflected in the
>>>>>>> cached value of i_size -- the client ensures that INVALID_SIZE is
>>>>>>> always clear.
>>>>>>>
>>>>>>> But perhaps the NFS client is relying on the client's VFS to
>>>>>>> maintain
>>>>>>> i_size...? The NFS client has its own direct I/O implementation, so
>>>>>>> perhaps an i_size update is missing there.
>>>>>>
>>>>>> Because the client never retrieves the file's size from the server
>>>>>> during either the passing or failing cases, this appears to be a
>>>>>> client
>>>>>> bug.
>>>>>>
>>>>>> The bug is in nfs_writeback_update_inode() -- if mtime is delegated,
>>>>>> it
>>>>>> skips the file extension check, and the file size cached on the
>>>>>> client
>>>>>> remains zero after the WRITE completes.
>>>>>>
>>>>>> The culprit is commit e12912d94137 ("NFSv4: Add support for delegated
>>>>>> atime and mtime attributes"). If I remove the hunk that this commit
>>>>>> adds to nfs_writeback_update_inode(), both generic/647 and
>>>>>> generic/729
>>>>>> pass.
>>>>>>
>>>>>>
>>>>>
>>>>> I'm confused... If O_DIRECT is set on open(), then the NFSv4.x (x>0)
>>>>> client will set NFS4_SHARE_WANT_NO_DELEG. Furthermore, it should not
>>>>> set either NFS4_SHARE_WANT_DELEG_TIMESTAMPS or
>>>>> NFS4_SHARE_WANT_OPEN_XOR_DELEGATION.
>>>>
>>>> Examining wire captures...
>>>>
>>>>
>>>> In the passing test (done with NFSv4.1 to the same server), there is
>>>> indeed an OPEN with OPEN4_SHARE_ACCESS_WANT_NO_DELEG followed by the
>>>> WRITE to offset 4096 for 4096 bytes. The client returns this OPEN state
>>>> ID immediately (via CLOSE).
>>>>
>>>> Then an OPEN that returns both an OPEN state ID and a WRITE delegation.
>>>> The client uses the delegation state ID for reading, enabling the test
>>>> to pass.
>>>
>>> The above is not correct. Upon closer examination, the delegation state
>>> ID is used for the direct WRITE in this case, even though an OPEN state
>>> ID is available.
>>>
>>> But since nfs_have_delegated_mtime() returns false,
>>> nfs_writeback_update_inode() proceeds to update the cached file size.
>>>
>>>
>>>> There are three OPENs on the wire during the failing test.
>>>>
>>>> The first two set OPEN4_SHARE_ACCESS_WANT_NO_DELEG. For those, the
>>>> server returns an OPEN stateid, delegation type OPEN_DELEGATE_NONE_EXT,
>>>> and WND4_NOT_WANTED is set.
>>>>
>>>> The third OPEN appears to request any kind of open. The share_access
>>>> field contains the raw value 00300003. The rightmost "3" is SHARE_BOTH.
>>>> I assume the leftmost "3" means WANT_DELEG_TIMESTAMPS and OPEN_XOR;
>>>> wireshark doesn't currently recognize those bits.
>>>>
>>>> NFSD returns an OPEN_DELEGATE_WRITE_ATTRS_DELEG in response to this
>>>> request, with a delegation state ID and no OPEN state ID.
>>>>
>>>> The client uses this delegation state ID for subsequent write
>>>> operations. The write completions fail to extend the cached file
>>>> size due to the presence of the delegation.
>>>
>>> Here again the client presents the delegation state ID during the WRITE.
>>> But since the write delegation also permits delegated time stamps,
>>> nfs_writeback_update_inode() skips the file size update.
>>>
>>> In both cases, nfs4_select_rw_stateid() is choosing a delegation
>>> state ID for a direct WRITE. In the this case, it's choosing the
>>> delegation state ID because it has no OPEN state ID (due to
>>> OPEN_XOR_DELEG being set).
>>>
>>> nfs4_map_atomic_open_share() seems to be selecting the wrong
>>> bits to enable for this test... ?
>>>
>>
>> The test application opens the target file without O_DIRECT, performs
>> one or two chores, then closes the file. It then opens the same file
>> with O_DIRECT.
>>
>> The problem arises because, on close(2), the client caches the open
>> state acquired by the first (non-O_DIRECT) open(2). It emits neither a
>> CLOSE nor a DELEGRETURN.
>>
>> For the subsequent O_DIRECT open(2), a fresh OPEN is not emitted. The
>> client uses the cached open state for direct WRITEs -- in fact, it uses
>> the delegation state ID from that cached open state.
> 
> The use of a delegation stateid doesn't seem to be a problem for when
> this test is run on 4.1.
> 
> I think you had to correct before when the problem was with how the
> client deals with updating the attributes (now that it got a delegated
> attribute ability).
> 
> The problematic chunk in the mentioned patch is the following:
> 
> @@ -1514,6 +1516,13 @@ void nfs_writeback_update_inode(struct
> nfs_pgio_header *hdr)
>         struct nfs_fattr *fattr = &hdr->fattr;
>         struct inode *inode = hdr->inode;
> 
> +       if (nfs_have_delegated_mtime(inode)) {
> +               spin_lock(&inode->i_lock);
> +               nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> +               spin_unlock(&inode->i_lock);
> +               return;
> +       }
> +
>         spin_lock(&inode->i_lock);
>         nfs_writeback_check_extend(hdr, fattr);
>         nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
> 
> 
> I'm not sure if reverting this chuck is the correct solution but it
> does fix the problem.

I also observed resolution when that logic was removed, but I'm sure
that removal has undesirable side-effects.

As Trond states above:

> If O_DIRECT is set on open(), then the NFSv4.x (x>0)
> client will set NFS4_SHARE_WANT_NO_DELEG.

nfs_writeback_update_inode() assumes that a direct write will be using
an open state ID, not a delegation state ID.

Thus IMO the NFS client selects a delegation state ID for direct I/O in
error. The application has closed the original file descriptor, but the
client has cached the open and delegation state IDs. The client's open
logic chooses to use the cached delegation state ID.

I've opened https://bugzilla.kernel.org/show_bug.cgi?id=219738 to
document this issue.


>> Note that this happens independent of the minor version. For attribute
>> delegation, the client's write completion logic sees the active
>> delegation and skips updating the local file size.
>>
>> Seems like nfs4_opendata_find_nfs4_state() needs to recognize that an
>> O_DIRECT OPEN cannot use cached open state that was created by a non
>> O_DIRECT_OPEN ?? Or nfs4_set_rw_stateid() needs to recognize that an
>> I/O is direct, and choose only an open state ID. But that means there
>> needs to be a guarantee that an open state ID is available.
>>
>> Guidance would be appreciated.
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

