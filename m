Return-Path: <linux-nfs+bounces-14031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E4B43E35
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F11892343
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC7307AF7;
	Thu,  4 Sep 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMZ5hLld";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qL+5BY9l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBF30AAB0;
	Thu,  4 Sep 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994970; cv=fail; b=nZ+sRSmrx1+bfJiUb8JUQebDvSLE4oBa2LHrLDU3b3fkNY3jqmgLvgie2k5LmOZtB0DPdfTTG221es7bAhJl0XogZ9qGG9qfXul2N+T2qxy3xPb6ALYC51zs5i25UkDVTxSwsw+L7Y188/3ZUcG63Cafjrv0Ydsn13bB15nREVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994970; c=relaxed/simple;
	bh=aOF0gth2wxXXiN+9dSXSUEHMIhZpdCuxaUOv+MI/PVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YEat+dv9RG6KqI6WXLwMuLztxE+/twrwtw3u1xrLjTxbs4EaWYHkAzjJXcc9CIyFOYZ4F/NLoYnLhJY0tSBHZu7JjZ3i9CjjzOSI4OBBwiYy1PeAZpzIC7KljuZbuLKTYy2mwznBnrtz6nEaLv1dzhIIs1jadEgoRzkb3R0mnkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMZ5hLld; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qL+5BY9l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584D4moY031418;
	Thu, 4 Sep 2025 14:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SSqFGOWCfQv+8CeAemkMZDflerRsuLlPCV3hcUHSQqk=; b=
	QMZ5hLldvzjxldvJv6DgT6dY6h7QMK/eJoGT0wEHsWoWIPbdIqTTZiWPh+bUlEOo
	DvlLcU8VLGX6g2+x5yDtrxKkmmZ7rAXtzM+FaUGcFQiymN43Y28JzjV5MMttbzvP
	u32181o5iSjCoP7pfdvKBebdZrJ1QhhQR/7ghy8qowyUG0jLXfqNKKYinN7s1N8u
	NGTjkQCKx0aQ776aRNMq46+4DVtG11EAUHj7EFtwTsciNVtF8RrXPSwchLSULKIG
	HqCmCzS3NfX521h3jeK2hU4aeqLY64/av/I9t+zlPdV/cDLewjKlfpjrLkevP26b
	jiM9wPeN48UAHylP8y9KSg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ybb4g5we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:09:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584CmGug015808;
	Thu, 4 Sep 2025 14:08:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01qvw39-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miG51g96KF0J4EtM4XSnHHLP1suWwN8EN7uUtadopgelMB9HehUM7DSLAkfyZstiiHl59vP8odevZ7mkVUdlM6ixrb/5vSa1eniy5ABDrKN170ODqXX++In3QrQYm7ngNMIvaYp44wRDELnBTwfvLc1I4lSsZq/rqx84dH/SfKXRaWtr7LyibXbCZ8b/FENdMcjbkgwgTh1rs8ur1JvrUHDFb2CRuksTzI+rlmP0KsBDSUuWX6kg5e2dgLsG7w/EC7TlWLJkaLB8iG74Wfm3++fHcFZ3ZyUuEKms8VmGmiplSK28s3w9nC9Wto4EW6EjDdixZQcZF1xPGX5lnBBabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSqFGOWCfQv+8CeAemkMZDflerRsuLlPCV3hcUHSQqk=;
 b=svkZt7TPtQcUVmyA3buf9sfeikNhc1P6rBLk+DJd0aDyxz5CpeF/+QxABapKQO0FYFPynVTeOQEZ74xiN6E+8XblsOuTN5qDwbak5Z+vQv9IojKczI6fADhze3k4rj//YP6w0jLJFHSvJ+MtJQIEY73TtUiL8/DVmwQOhvM7AJtP5bwR8JG5BWMtsnwXiAOBVkAC6H21k2C2LERW++VnELYlS5ccCRtAOh7ydU01mSkuh3kuO3EXCBRETsB9Dk8EH1mxwpaOfMYlzYO54hTwkK7DBjouWp+c4RtAO+Lpbnw0wCt5r4SfYIWv82m5iZ+Y+8cKnxkmqOQr5BzWQ4o4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSqFGOWCfQv+8CeAemkMZDflerRsuLlPCV3hcUHSQqk=;
 b=qL+5BY9lsodCE5tmhryR8ZNWRmrbe3nH+Ns++hralsdBfhlYnNcFe8rqYpKBrqsJ6xlYy8ga9QbjobDgvk8Co9iX6SGxqfHb+1QZ5Ci0mm6RPLGu4nugMvrXINud+GmKk5q1o/sTzESDYTO//9iA6FnfTcElmvfSznm9cj+4spc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8419.namprd10.prod.outlook.com (2603:10b6:208:57f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 14:08:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:08:54 +0000
Message-ID: <ce18bf9b-889c-4746-902c-4f9077b22a32@oracle.com>
Date: Thu, 4 Sep 2025 10:08:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: remove long-standing revoked delegations by
 force
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
        neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        zhangjian496@huawei.com, bcodding@redhat.com
References: <20250903115918.788159-1-lilingfeng3@huawei.com>
 <837da22b428e5a7cbda1f56868cbfe23e89dccf7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <837da22b428e5a7cbda1f56868cbfe23e89dccf7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:610:53::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccd4e78-eeca-49ca-fc11-08ddebbc949f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V0ZRaTFiVDBmRE5xVlEvdXczKzQvT3gzSTFCNlBDT213aGppVzRFUzBnUmVY?=
 =?utf-8?B?WG15bjd6Z2swY0JHckhsN3BZYm5iM1NjYVIyRDh1eW1QMWNWTlV4MGlZNE9X?=
 =?utf-8?B?R2VKWXFHNFNFcUpERnVxVDNQdUVZRHFxOGFzYzlvU0Q3RHoyZUNFZ2VlVHYx?=
 =?utf-8?B?eUdGMUdXMTEvQWhnWjZiblRsVzlNUFNUVEtFYTM0UjVkNXFob1A3eC82eHky?=
 =?utf-8?B?ZWpBTUEvTGFjUEcvcVBRZVRNUzM4cm53MzhJMnUyK0pWVnRkR29HSXU0VjVn?=
 =?utf-8?B?Z3Mxb2ZKWU92RXV5MXJVTFNuQlhaKzBmeEJsNzE5UEJmb25UTGVwbUo0bFFo?=
 =?utf-8?B?b3Y3VHpOSVcwMzVzRlY4V3Q4ZWx0VGVTME5pcDljMXdFM0lsRmcwNEkvVTdn?=
 =?utf-8?B?Kzk1ZkhiWG9OdnZqN0Y0RVViQ29VNXpjdWsxcWlyUVowZU5zOVBobmc5TG96?=
 =?utf-8?B?Wjlkb21mdXNTeUZsUTJyR1U2S2tyczIwZE12U3JqWU9hU1NkWnJweHJZeUs0?=
 =?utf-8?B?bkFTNnl3T0NFUEtDZmgzekhOUnArWGEyekFGRm53dE1CdzVnT0pKVjdJcWE5?=
 =?utf-8?B?VUNVczBrcmtHMExpZm8vMklTbU9QVHRLUGdmT1hIS3AvZVA5STk0QlBqSG1y?=
 =?utf-8?B?WXFlZTdLYnhoUkhIckZIYVdZNDIrWmlpWXFqc2pzSEhKcWVZVlZtRkttellY?=
 =?utf-8?B?TGJ5dXMzWVZPcTlPT0JmVWxRY0RXNkpRV3o4Qzl6RG5hSVpoRXRJWHhscStw?=
 =?utf-8?B?TTlrZEh2VlMyeFRDQnpOcUJoVk9LMnRSL2h4TGF5S296RG5DM2R5c2tESUpp?=
 =?utf-8?B?M0ltanNyMm16d1lYbk53WFVXNmlvdWFISDh2SUhYaFVDd0gzUE1ydG9lREM1?=
 =?utf-8?B?N1ZxdFFJeUlLRlp2akoyK2w4aVFvd0dPVTYwTUhQbHRFLzNBNnBDbzcxZncz?=
 =?utf-8?B?OUtpMFFhZnNpUUM0Ty9uempDRkw3L2lQbWQxTmVQZUxyMkNGSWRlZTN2ZW1q?=
 =?utf-8?B?NE9vUnZ3R3FMVkhKQjI1RlJXNnZtNnp5TnJZczlOYnEweU1oNVNMS01qc2xu?=
 =?utf-8?B?M3FINUJxOVFsVno4YXM0RmM3NTNweEhLM3JwSUVLZEhxV2hWRE1PRzZoRVhO?=
 =?utf-8?B?L3pPL29mK21JMUk0R05DNmowNEpLMmxiZmY5MDRXa3pFc2RMVDhWUDlTZGlI?=
 =?utf-8?B?Tlp2enk4aGZNQXpMYjJtOWlnMzZnaUl1L3V6cFZIMkFkUG9oTEZVREV4czNo?=
 =?utf-8?B?V2NQVzBSWkFFcEROR3laL3ZxWmcrdEVtRFprYy8yakpEM3ZyZzEwUnA0K2VJ?=
 =?utf-8?B?NkZGaFRPa2tXNE9PRWJ1M0JVOXFvWDdDcXN2ckNJTmdxUVJodEQyOWE1a0dr?=
 =?utf-8?B?Qi9EUk1wV3B4dHZ0cEIwWWdOT01idlVJODhlZVJOc1h2MkttdXh4UzljRTdZ?=
 =?utf-8?B?N3d5S2RobGovSUtWQ0J4MjlvbnBpalRCVm1xWTMrTTNtY0dveC9LM2wxV2Z0?=
 =?utf-8?B?cXA0dERtVWhXWVg3MVRRTkNHaXBkQ1dPWVBzUDV1Sk1IM2VUOXVGSlN4SndV?=
 =?utf-8?B?d1AySTFqc1BRMS9kd0dFdEt2bFo4TmxPOG4yZDFha1VDcDl2V0tEN3R3UGJJ?=
 =?utf-8?B?RXRLNWN5WE9ua2sybVczMDIwS1hGaG5iRmZIOWJlbVM4OHY4ODY3OTd5R3Q3?=
 =?utf-8?B?czFsSTErTWs2cVI2L1F3a3dGYUZJZ1VhK1hyZVkwRXJDRXlZV3VWdWZQamVu?=
 =?utf-8?B?SlZNa2UzOHA0Nko2ZzBCYWtSNlJUclg3b3NnbVV5WEYrMURHU0pPT05VK3Zz?=
 =?utf-8?Q?simKKgBWjkO4wYBeK9k/ZpBCWs/ngI09EZrL8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aUlIbGlMdEQwUi9zd0M0S0lMMCtkc2JFMTk1dmtDMzBKWXRsMWtFQkxpT3lo?=
 =?utf-8?B?bnBmU05MTXpBSnNDemJ1M0dEeHNjcURSMGQ0bjAzdFIxTGRPQmE1REJWN3NB?=
 =?utf-8?B?cFhZTUdXdUk2Y3V3UHlpRXVBaDR1TGFQd2drM01jMVVQblRpUStINkZGM2RW?=
 =?utf-8?B?aTdlMlAzM1ZCd2VRQlhuMHh4MnFGNVRmYUJLOTdkNTRGM0pGVzFUNjlPdDlq?=
 =?utf-8?B?T0s0a0p6UlZrMG44RnV6dVVLRDcwN0hNUkRBZzA3K1pHYVQ5ek5rWk03aVR6?=
 =?utf-8?B?ckkvQ1dkUkdmUnVHVUQ3cnZyZ0dYZVQvUWZ5Qm1iZzA0Z0JKMGIxWm1weTBP?=
 =?utf-8?B?d2haelRxK0pjdllrUENUT0twNHpLZzRqVUF5eVNRTGU4all3Um9VMVNsbVQ2?=
 =?utf-8?B?cU1WWjlDWHRjTDZQUjJ3NTBQbUFaekdZWVNHR2hTa2xTOVpaUDB2enUxVldI?=
 =?utf-8?B?RDNiSnJQblF1SGxDZVpuR0RTanlZZHBMT2hiU0M0ejhTaG9pTzNiUXJodWJN?=
 =?utf-8?B?T3A0c0tjeEd5elVUa1lMUUNPUGpUeFJpNG9IRUdPc0YraWcrSm05RmJ1QkZi?=
 =?utf-8?B?YkZlbUdHekNpRHdNUFMwdXZmU0owMlhGbFNIeXNRMjJubmExeW1jTkg2ekd1?=
 =?utf-8?B?cGxrR3NrNTQ4V2crV0swTCtyRmxrTkN0UjhOT1VqekhSMFZ4S0NhNng5K0lv?=
 =?utf-8?B?VGNGUlRnclFmYkFMNkVOQjhRdHZoUHJzRDVmY1BvVWxzT1prczA3YzMySFdi?=
 =?utf-8?B?QW1FeTVjclM4SU55OUdGeFRoc01sb3FvZFNCT3B2cUNvQnczVjMraUp2VCtG?=
 =?utf-8?B?REN4SGR1aURaekRqVEcxdm5IVmRKYW5hYWE0K3dIUk1DSjdPNXpjNDkycWRu?=
 =?utf-8?B?b3hrdVltSnRuRVJnRWJxbGJaZW1wY3NsRkRKQTlLN2VuTis1QWxrUjVrVEow?=
 =?utf-8?B?MTVKdEtwTExjanArRHp3YXFDWDNESWRVbU5jMThRTC9yOEt0RHREcVZxblNh?=
 =?utf-8?B?SHF6bzl3d3A1UHY3TjVqaDNNWVUwZ2tYQzNaZ0QxY0tTZ05zYUxKMjVTVkJD?=
 =?utf-8?B?bWJpek5sa09vK1JzakY2Z0o3OVoxVlg2SDdhNSsvOHBwT3Z4YTBld3JJc3hv?=
 =?utf-8?B?cWZzVUtSazF4TitYdVdPcTdCeGlwUG1MdHRQZWprVHNiOGIxMTh5OC96Tm1X?=
 =?utf-8?B?c0R3VHlaZ1VDam1FeDhPMzk3aFBkWTdQTnp4ajExVjBlSzFuVS9xWFk4aW9J?=
 =?utf-8?B?MjdQbnpZQlRXNHFOMVIxYnlNeWNoc2tyeitmclNPUUtCR0o4ajY2WHdhZ05h?=
 =?utf-8?B?NG8xaWg0ZnlNbjR2cVZGYUZtd2hFR1RtOU9nQnBOc0xhQ0VNNjJJR040bXha?=
 =?utf-8?B?U1RjUXpIZGVyTWJ3RTlXT3BWR3QwbnYweitSK1YybzhDK2VibVRwY3BKTFA3?=
 =?utf-8?B?QnQrK3dyQnBLZERPRzZHSzg4Z2xGaEViYlppZWRYZWJvdzFhbXhnVkIvWFFT?=
 =?utf-8?B?cnk1TnpHbjVYUDdCY2hFTXpmOVZ0YzhRQ3IrWWhYV3MySE1jb2oyZjB5eE9a?=
 =?utf-8?B?cXM3bjQweGlmWWFLWGtJQjZ1a0Y0dExTR243SytvUDNPOC9wT0UzRFlTSHB2?=
 =?utf-8?B?Ti9qamt6RFJOY1ZEK1BJUlhIVnI0S2Z3bUtsYlhGVlhDQmVHanVBOEZaeG9K?=
 =?utf-8?B?UEtkVDgxVzAzQmxtREIzYTRTRWhrQ0NjbTlzWlA5anFsQ3loQ0p3NVBGbndW?=
 =?utf-8?B?N2I3ZVNJZkZOWWM0UDJFRXF3ZEI5VzhGVW5aV2JXQVJxT1ZtQUpNamtrV0Ix?=
 =?utf-8?B?Wkh0VW9Eb2wvU3Job0hWMlBQcVBaRlhoaUJmRHZlMEs3RE5OTmZGOGt1U1hQ?=
 =?utf-8?B?ZUpjSE1FNnBTSTdIelBpdlJRd0d3WENRdlRjR3JiOGZxTnhabTVGb1NyTk5Z?=
 =?utf-8?B?bTRlYlh1cWJ0eDQzYTMxc1dDYWVSOXlJcCtJRGhGejlZcExGaTFHVERMSExQ?=
 =?utf-8?B?aFNDWXZuWDQ0NEdVYzdmenQzY2xSbzY1MmcyMjNuTnh2bGgrd1FKOGdaNmdk?=
 =?utf-8?B?YkVZYnVMRnppbCtMdHNXb3A4Ym1yd1VUMXg2YjV2b1JadndGblBhQk5qWUNI?=
 =?utf-8?Q?DpJLJWO68QY9x34Q4aO2PtdVL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c0KiOpbAIHmnluodF76ytkvjx23z1jQhXqqJQBg7OvpvC7US1I3aM6EtBm+5a3SGAfKWwvDSqb4roNma7/hR1IMUIZKzABKwO9EpLXmku0WKgguK8HydvyEvRvIW2wDWqgvRqg58jYZbcsIMkWSvmSlcUJPyCgdxNlr/PthJCEe8hutvINaoOTUGPMaO96N0vUUCSmABpliB/7Yt98o8wHTAZ85cKJ1zlQuBey3XTBzHN/JAt0AmHkPUrqxyw9z0dH+bzPwxTt+jZkgUjWqinktOsyqEHgGNP0v9d1oXwPXmGfT3JSBzYpSrP936qWpGlyWmolDr4b2wClBALc80TCwgHHKKq0KJ2yTnML5kDaiYyeXmPbTTztM9ZOwlotQbr4XySiNFZCUsr9y5DiumuyxPIm7QtrsCBP7weUxJMXsK7ArMJUL1GIqYn+NHvcIgZEH7AsRg/YtL5Huqm5z2jonMT0NNSY0JcyiGmvlahhfUZmJ3P51DyQPWBw8WWvCh6tU7z47M5GtxO/YPeQR3QNDP61ZbWGq3a7VPRSuRjIaE5fiwaPABnO6GrtbYb4+GX933lHpxV2r9H9t1ilGNvckgMPMqliFlfmYbpTBVfe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd4e78-eeca-49ca-fc11-08ddebbc949f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:08:53.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQKc+wxEgIeSD8m0NfAaIdD0WrWa8YXnLS7RdOxUIp2E1bbEihob1RcIR2mIp6L26d0ZSohpq8NrSdMAEZBevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040140
X-Proofpoint-GUID: 020PB0KjUWFQLjTzcx4Z4OdkxLe_9VNh
X-Authority-Analysis: v=2.4 cv=Cq+/cm4D c=1 sm=1 tr=0 ts=68b99d7c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=5GrmH5YNw51GogRVBgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 020PB0KjUWFQLjTzcx4Z4OdkxLe_9VNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEyOSBTYWx0ZWRfX23DHuERZh9E0
 bkc8KAjm2K1hHI4Q9NiJq2J3Sl8KJA8tvZdD6jmHb5aX1+/IlR5IROjh4jJF34qX/oV1o8P/bdn
 59m+M01MEokviPPgzu46ormkw74HgYQY+Q4LuiykX6Tan5pz2xLgYVj5ROmfRQhNGm65cAf3ZQ3
 1cAt94bf+mYCWVBRGl0WcIRMgwQ3eICvmcfLjuzSueXv8R/zd7iUHo7AuQ4i+/dSr+OjkuWxDzZ
 tynIbIGm7qeWnRMu1EDVYdLlrwDSknkmOI0aL/CXI/MTGFJz3unx2+gdefqA32sY+IckAVdVXPb
 j4O/zkH2/5HROqlwlxD/zLoR6SgCSZ2K4JRT1JtQls9NgIT2nYB/bFAByozk+fSGjtNYND4+ovg
 WK3XNct7

On 9/3/25 8:15 AM, Jeff Layton wrote:
> On Wed, 2025-09-03 at 19:59 +0800, Li Lingfeng wrote:
>> When file access conflicts occur between clients, the server recalls
>> delegations. If the client holding delegation fails to return it after
>> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
>> This causes subsequent SEQUENCE operations to set the
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
>> validate all delegations and return the revoked one.
>>
>> However, if the client fails to return the delegation like this:
>> nfs4_laundromat                       nfsd4_delegreturn
>>  unhash_delegation_locked
>>  list_add // add dp to reaplist
>>           // by dl_recall_lru
>>  list_del_init // delete dp from
>>                // reaplist
>>                                        destroy_delegation
>>                                         unhash_delegation_locked
>>                                          // do nothing but return false
>>  revoke_delegation
>>  list_add // add dp to cl_revoked
>>           // by dl_recall_lru
>>
>> The delegation will remain in the server's cl_revoked list while the
>> client marks it revoked and won't find it upon detecting
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
>> This leads to a loop:
>> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
>> client repeatedly tests all delegations, severely impacting performance
>> when numerous delegations exist.
>>
>> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
>> --> revoke_delegation --> destroy_unhashed_deleg -->
>> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
>> requests indefinitely, retaining such a delegation on the server is
>> unnecessary.
>>
>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   Changes in v2:
>>   1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>>   2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>>      rather than by timeout;
>>   3) Modify the commit message.
>>  fs/nfsd/nfs4state.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 88c347957da5..bb9e1df4e41f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1336,6 +1336,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>>  
>>  	spin_lock(&state_lock);
>>  	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>> +	/*
>> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
>> +	 * delegation is hashed, to mark the current delegation as invalid.
>> +	 */
>> +	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
>>  	spin_unlock(&state_lock);
>>  	if (unhashed)
>>  		destroy_unhashed_deleg(dp);
>> @@ -4326,6 +4331,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	int buflen;
>>  	struct net *net = SVC_NET(rqstp);
>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct list_head *pos, *next;
>> +	struct nfs4_delegation *dp;
>>  
> 
> nit: These could be moved inside the if statement below.
> 
>>  	if (resp->opcnt != 1)
>>  		return nfserr_sequence_pos;
>> @@ -4470,6 +4477,19 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	default:
>>  		seq->status_flags = 0;
>>  	}
> 
> I wouldn't mind a comment here that explains why we have to do this.
> This is the sort of thing that will have us all scratching our heads in
> a few years.
> 
>> +	if (!list_empty(&clp->cl_revoked)) {
>> +		spin_lock(&clp->cl_lock);
>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
>> +				list_del_init(&dp->dl_recall_lru);
>> +				spin_unlock(&clp->cl_lock);
>> +				nfs4_put_stid(&dp->dl_stid);
>> +				spin_lock(&clp->cl_lock);
>> +			}
>> +		}
>> +		spin_unlock(&clp->cl_lock);
>> +	}
> 
> nit: I'd move the if statement below inside the above if statement. No
> need to check list_empty() twice if it was empty the first time. Maybe
> the compiler papers over this and only does it once?
> 
>>  	if (!list_empty(&clp->cl_revoked))
>>  		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>  	if (atomic_read(&clp->cl_admin_revoked))
> 
> Otherwise, this looks great. Thanks for the patch!
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Li, I'm assuming you are going to address Jeff's additional comments
here and send another revision of this patch. So I'm waiting for
another version... let me know if you plan not to send one.


-- 
Chuck Lever

