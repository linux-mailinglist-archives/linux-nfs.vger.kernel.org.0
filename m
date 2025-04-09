Return-Path: <linux-nfs+bounces-11067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52620A82A0F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305301BC708F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE932673A4;
	Wed,  9 Apr 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWdzTI4d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GJo3Pa8j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB11262801;
	Wed,  9 Apr 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211761; cv=fail; b=YTF2wJ1/+gLVQCyjcRY2WDHq+dVvtWtMUKZOcWgCGzOUdBQSQjuAzCH/c5JAk2XY3XrmDN++BqhFgdwfmvk/0CzwYMCoS4xPJkTWNtEKgQW3U1fskbtuiRRipPH9wWj8S/hHxiE2jcX7KuYs7G3PEmve1VwseSAwImvHSdtWie8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211761; c=relaxed/simple;
	bh=JbkJdXCl5kHDnj3suV1l23Uh+CiXFXoFPaC9qz57PPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nosGeGYMmc81gHh+eFhJ2WDQ9FkatFM+tORDMIg8nbi6fm3T4ZC2I1d2FLJxJtpAacuTp84OGbxEFvEyYG+rBhz2vq18aciydEqNQCj80cSwrajLKAvIYLhnm5RcYD9KbvH2281yVbUJGgakLOsDePk/vJUPY1IiT2ihHPM0hZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWdzTI4d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GJo3Pa8j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539EuR7k013739;
	Wed, 9 Apr 2025 15:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m5x9DvppOQUmBoeO1AqEbPfxFlmydksAOQx8oU7owIc=; b=
	jWdzTI4dckNQ+M1nssvl02A8S76Afxq92guL1zZiyS8KfDbxqCiZGHF9hD49iAW+
	8otsYFNyR9tMbrm/jGoiNNLrgicy9d611Au9m6/iOdJiUmTV39VtMf2L2gVNSaMN
	5AbZPNETPETf4FiZrDgoJW0Wvj+jXseA31qXsG8wVHRRHJ9mtKrgDxNSklHulQNL
	1SWZcK8K5BX1BK1Kcqa9cU2t80gvu+KvQ+YQ76Y9lWLkReEdsuAVUNqZbegFb2ZX
	tOfbj9UKjI2l1n8/f4QTYhS++kdwlsRzhSTiy3+XUBvoYW2GTTDIggleA9RVCZj0
	PE1rOYbvjl5w2GKk/W80Nw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2yeab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:15:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539EgjPB016144;
	Wed, 9 Apr 2025 15:15:49 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyawtp1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioU9QLuTWyerldqacWlAVUvYQLY+pacfGOTBIxi1Cf73QlHHjzwEA0lZK8Xp0RJ3vgBTsjBkVjABJZLfVAEPNbqPCk5EKYTI0kwOCy3XjMtBN5+YBNgFpWYStDae8L/W/+JS9Uq9ZCGQeqZpb3GUeSHy9ZCZPJcyMAnPODzwFw+2bNV87h1yWXuzixHmdXmXcflM+WhS+KdAhfHnQo7QKZ5NQMDS+CeWlXDZ/U1MlPAVK+bRedG8aKbRIzvHhGIYAQOpPS+oadT5D2auVlMT2EAwiQSBr+1/MlxFRqwwvXHNmF7GHOT+4QUfTSUmzjaOU1HGHoN+Tf9tG54MpjNaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5x9DvppOQUmBoeO1AqEbPfxFlmydksAOQx8oU7owIc=;
 b=y7cJnUus7+oh3gJUKee29inrMblLCwv6qSYMANrcP+udlAjFKEHZ+b1RFAMlsalO2bYT96MuPnPLpg/ice5xFKIwZErmEE9i9I2plQqQrTTmCk769Mlz2B1PrjGp5oP7wrzhIa8Ndiph+7M4CC0wfhFQE+AtpaNj6wRx2xdf0sU1qAfqDZt2dDGRu2f6B1LgJ8JI6ERIzV/JEF2Z/AxQJLyN098Yaypj8IFIrWsTMfDcL+dcRYya0TxXUVhQDucChvM/saN2M/sZczq0Y5VW2+oqrBhSMfGUlm+437Ms1neYRBaBWeHqS6N00myk4lu5kr7WMtsac7QEJSh8s/Jd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5x9DvppOQUmBoeO1AqEbPfxFlmydksAOQx8oU7owIc=;
 b=GJo3Pa8jbZIXJ4k8uXeQvPYXwlRUNLZxdAsrRUoYbpscPs744ztCID7cXz/EDQ08ehnIqFczm0Aaxh2n0vSw1Pypm3GqLvl/lo3soOGjf1vUgWGGdbuJpUbo8kup3Q24Qmk4A0VUUSEWOv+u5S/IeVdNiYcW2X/DSovMApqb9R0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF4F9D69ECB.namprd10.prod.outlook.com (2603:10b6:518:1::79c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:15:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:15:46 +0000
Message-ID: <f38712c5-b2b1-48d8-915b-a0c9f9e72984@oracle.com>
Date: Wed, 9 Apr 2025 11:15:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] nfsd: add tracepoints for symlink events
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-7-cf4e084fdd9c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250409-nfsd-tracepoints-v2-7-cf4e084fdd9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:610:4e::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF4F9D69ECB:EE_
X-MS-Office365-Filtering-Correlation-Id: 7766c7b3-d6eb-4e56-ac20-08dd77796713
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UTlZSURUZWNLeWhWdTIzRlZNSkJnZWd1MEpVQ05IZExqNjZBSWh0dlVuTnpN?=
 =?utf-8?B?ZTNKRGZmankvZ0RZYzdKL0xtUEhzWHR5YWJNNlpwaXlUclVWcFIwWXBoNDAx?=
 =?utf-8?B?ODFnZWd0TFMxcjFadjlyV01Nb1BzOG45ZHZydS95UHIxTnl0RVltSmZyaHcw?=
 =?utf-8?B?blMzdGpQd1RWL0NabktFb2lwRjNUdDcxTlFzc3BXMC9sWVphQTJ6WGk1S1B6?=
 =?utf-8?B?VnN4Zk5VTGxuN1FQbGNrNVR4a0dMTXl1ZnZzdGZUWVVBSFU0OENWRnF2VUhZ?=
 =?utf-8?B?YjljUm1scys0dXF6NzU1REtiTHloTHhSZjZuSnM2UldkQzhwSk1WbGFBMm4w?=
 =?utf-8?B?aSs4VFZEamUySXNUUXZxL3ZlMjliTGZxWUUvUVVFeE1vV0RKVGxPVVJJbVRC?=
 =?utf-8?B?d0pnZ1Ura2J4azhXenBUUi9zSzdPM1c1RlIzY01mZ3VkMUV2THhFTVFyU3J1?=
 =?utf-8?B?REpwcnFyOEd2YlV6S1NreForL0VXL2RiMjdZbTRQNnVhSUgra0pBb21jdEpG?=
 =?utf-8?B?M0paT2JLeDloTCthVzBBeEhPa2xEZXV6cFhxeEV5b29EY2RLYUFSOHZWa0xB?=
 =?utf-8?B?c3JaQjBodUFNeVF2c3dJclJZaW5aYkpiL1JDWUJlK0dFSUN3RmR6ckdJN2hm?=
 =?utf-8?B?Z2w0Y2JPSlZvSU5QaFNhekV3bmJidGIwU1NQcU9JVEliaHlYayszeEtRQ1dl?=
 =?utf-8?B?QzNFaXV4dkJSZFRzVi83c1JsbzdzbnZMSWRvUmpYY0hDb3hCNWtUNmJ2eWJy?=
 =?utf-8?B?aEZGR1BqYlUvTWpxMTREOUNtY3JXK0syajZtNTlJNmVnMHdISHordkxscXVt?=
 =?utf-8?B?OXMySnMzQkhIelBGdTFIU2VLWVY1SXNiVEIyTkpuOE0yUEJPM1Q0QUV3UVFu?=
 =?utf-8?B?RURyWWhlYk1xYWFjd1FaY2ovTWQ3UDh0WHQ2QmtWQ2x0ZUIxaFp2Z1VNWFRU?=
 =?utf-8?B?aGVlay8yQmlRVG44S0ZjSk5qODJZVlZMR1ZvS3dOblJMa3pncHVqQS9DNzgz?=
 =?utf-8?B?OElWTXFIeFM5dUZoWVhsSUM5b1NOOENYdGJTRVhPN0ptQzRnTjBMVTk1bnM3?=
 =?utf-8?B?QXpGYVo1eGsvQTgwZTRkL01vV25mcHd5RXFCYWFrWDZTL0E5SWZGcGRSL2lU?=
 =?utf-8?B?Mm5CT21Xa2NiVkh2ei9wNlc1emRiRnNERzJIMHZmTGg0UEJQUHB6cnN4U28r?=
 =?utf-8?B?TjdPUnYzOGsrdWtQOHNwUm9UK1d3ckFGKzlTalVqajNKSnhhS0lXbTdMS2Zq?=
 =?utf-8?B?YWNyUEpMaHZpL21rUVFmZElWeDd1RzM4QjIzNXphbWo2SXQ2ZVpwZVB1WlNN?=
 =?utf-8?B?NURSajRPaytaV0FwN3FOWU9oWml2UlZQKzE0Tnp2T2Q4WDU2VVlZVHlpVUs1?=
 =?utf-8?B?R3RBUjZCRlZDMkdGSEd0azh0MThOWmFBWjBaTW10Tk9WeUZvb1RnSER2UElF?=
 =?utf-8?B?UHNyVmFsLzdaaVI0UmJ6TXZQcm5qWFJmcDNjdTF2N0tPbWtNaFhXK2JoeEI3?=
 =?utf-8?B?bzdiQW9VR2MvS1RIOGMzT1B1UkFmVTZFcWN2MVFOdURkWENpV2t0SmdkS2d3?=
 =?utf-8?B?K2ZjUEJvODh6Zm5ZUUtBTkIyYURRWnQwcW5mRWltYk5IYjg2b0NpMGEyeGNr?=
 =?utf-8?B?ZGpGUjdXWjZuYnZ0SlExaWIyc1d4MXRVRUh1bWR0aXgxcHFucGp6d0xNUmFQ?=
 =?utf-8?B?cGlKVVRXN05GbHZqSG1rZnJ1T1BjOWhvME41OWtRR0F1a0RHTmd5cWVaVlhw?=
 =?utf-8?B?TWRsMHROeFB3MDVlUHpDaEFzU29ERXV2aHJqVDNVS1VQTlVWSVphSHNld3lW?=
 =?utf-8?B?elBNc2ExdmZleld6czZ4SHpiRkJmbzBvaFcrZzJsaXlsL0NDbDdPOTZhQjJl?=
 =?utf-8?Q?GoJM57XMus64d?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QVhYdXc4L29aWXR3N0RsSzZjbkdVK3B5YkdEMVhtNGdiampYUVVKQVBGMXlt?=
 =?utf-8?B?bi9GaEtnb3FFbytmUlpWUTIrYk9zSVBuMDZ0dFNhdEh3QVJmQXR3UHRvWStw?=
 =?utf-8?B?QzYreGVCQTJtaHZSejI4RlNEOVo1UjE0ODhKaWtxdGJCcTR2Qlo4em9hZnFM?=
 =?utf-8?B?R1JBWjNaWGhITVo5NjRZNjZSWk81b2JiR2pPa0NUcjhZY3RaTnpzQUxob1VS?=
 =?utf-8?B?QjlOSHYxTnc2K2NLODJHUWFCbjBMSiszSDhzR3kxV3laN25wN25Zb1RodzNN?=
 =?utf-8?B?MWtnQ1A2M0FVVDk4UjNDcHN0M2tTS2ZjVVRmdVQyR2J1SUNHb1lUcTBNWnZQ?=
 =?utf-8?B?djZPRitQUWJRblp4UU9wNjI0RHJ6WkhtemlWSnBUQ2FFeHplaml4U1gxOUVH?=
 =?utf-8?B?dkE3QlRzQ1hBakFxalNZTVlUTWZtRkVmUmRwVmN6MWJ0cU50T2VSTE9TWlQ5?=
 =?utf-8?B?b2tjaU5ac3ppUXdISlN5alFZL1dESFk0SDVkWWxzSngvTGRrVE12ay9yVTFr?=
 =?utf-8?B?cVlZT1J3U0d0Q3BVNkJObWxoRUIvQlRCZHp5bExxYTNXUitOVDQydHdQQzA1?=
 =?utf-8?B?dFBjYWd3Wk1Mc2RJYTNiVmo4d29EbzhGQU5vZ212UnVRSlM4bVc3SXFxNTE1?=
 =?utf-8?B?NUlRbnBZTDZidHJzYVZZdkd3Tmg4cFE4clJmaDVldkVvb1RQZkNCaFFoQTJS?=
 =?utf-8?B?VXF5SGE5SUE3bm51QXFlNEJsY2hpcDlFdk9ZNUFNRHBxa0lxaXlRSGNsY2hy?=
 =?utf-8?B?bENtNG11aWh3ZytRYlVrYWtscXNVWEdRWWJIVityTDg1dks1ZGNpMXBRVW43?=
 =?utf-8?B?aXl6SUdHYzl3TnpuYnpDYlZUZXpwN3BCT0c2SmpyVjRaZDV6MFdJRXFiOVdU?=
 =?utf-8?B?ZFdFZUZtcE5XRkxUandyM3h4NDB6M1AraFlTclY4d2tHN0ZUZHFTbXVMRnRp?=
 =?utf-8?B?TDd4d1lQa2d1WFp6b0hSTkZNdDM3U1VKT2xTQ2UyeXZRNFQxMkRUTVU2VTIr?=
 =?utf-8?B?Q01QdnFXakIwbWpYY3pzWU54OFdEcWN3WjVPcWZqL1BFRzdwcVdyWnpZemVz?=
 =?utf-8?B?TEs0dnVtaXFrbEE3YnJXUUY2ZFRoQmw5b2xmWVpoV1Vqd0x5VUJ3bkdpUytj?=
 =?utf-8?B?Q0NmM0hvcDdyaGtXVVVaT1E1VjdUckNTZXIvYmROUFBwL1RYMXFFYyt2WDFo?=
 =?utf-8?B?ZnBhaGdtdmlENTV5eHJhQW95M3FYQVZzbk1DUXNpWVZwRjRJbE9hbENDSnlR?=
 =?utf-8?B?Mys4UURPZWU0blB6VTFwRTJJU01pWHdRYkVkR0FuNzl1bktpUU0xZTVHamlD?=
 =?utf-8?B?UytIM2RYVGpOeWorV3N2YmxHNXAybGwvUTliM3J6a2JjU295Y1JXMGZJS2FF?=
 =?utf-8?B?MUo3K3pBaS8ybDRvaTI1c0YxNGdTZC9DR0ZkYjBVZUREVDNleTJFM0YzQnRB?=
 =?utf-8?B?SUllK0NzUXhuYXlXeDFaT2VRaXpGMkovWXRJUGJOUnpFN1YvejFzY05mdndH?=
 =?utf-8?B?c3JWelpRQW5UcmE5UkFpUlZsZkgxTXhZLy9NY1lTQnd6dDIydFMzNlo0bVU2?=
 =?utf-8?B?NlM4cEZ1WnlpYXVSNHBXcTlCZlZseFpkNXFLbGRxVE9NQTh5T2tnY2lVZGVz?=
 =?utf-8?B?VjQvS0tuTmFJNzRtTUZUZ2w5d0k4ODFoSDdpTEFlUzZlUXpZeEx4bnBBV3pY?=
 =?utf-8?B?ZXdHZFlaUUlab0VPWDJONUZPRmlJbHVjM0RScUZyelVZWkZ2SWpWMVp5MlhN?=
 =?utf-8?B?V2lvbllBV1B1clZNakJ1VHBaTUZoUFBRQ3l6NVBudFJiZXNRTnVhcE50d0hx?=
 =?utf-8?B?aDJ4V3lDZk14TzZYbWdJMkhNWnFOaktUbmlPQ3pXRXF2VC8zRDFTL2Y1SmM5?=
 =?utf-8?B?SHNNTVFzMlVtRzhHam9oU2FLZkhuUEFNMEJTdERncy8wTWdQSm5PeEpPZU9M?=
 =?utf-8?B?UTVxUUd5UlJxTkdXV3RtNkR3VDEzQngzUU1aR0w2QkdMRUVrbjJqTFpkZGdQ?=
 =?utf-8?B?VjBlSURrakh1MHphUTh3NzYvVyt3Ukk2MWFpR0xOQ2VqTWpubmwzblBMNHVr?=
 =?utf-8?B?cmR0bFk0WEdBdDRxMEw4ODhFaEFURWdwVHlkTDlmSW9uYUVkS2taeWhsUEtQ?=
 =?utf-8?B?bVppM0VSZjVCNTJiUHBKU3dIWThUdU02TnFucmZyTm1FbStwWTJhQnVQdXVo?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3PVmyfnBDyxUrhH/FMVK8wsz/P7dQ2rHPD6MzKpFVWw4RrNEL+w6hKXcvhcjWRSWc/+igk/VrcReANnk/AzC5EUfmGJSqyhGg6b5w58q/oysfWcQPF0+ag7T9iY18X4/bX9RPrZhqLWSS9oVXKZw3ae2PmTR1WE3U1ove5hJ8P2xRNZmm7jQUyyosuM7pLgVXJfVfdfqks7rxJ+FZj2W5NbSTM48B8+gJnXxW4uZf/UGqszknJh5ejXLd8m+zP3ZoqEm0nhFM5DXo4Pc4eFUtfo4dhSzYmfnMEUxiYuoPbgfyASDKLbHUc1HPhaI0At5jnlxg10XIDWQ+izDsEo3MwUjPsS3nk9N3Grvs+DlvbkhuKSAc6aAgd04qqqpt7mqiX4BU3jWCj+4b0FN9nu6AUY2nxNCzmowP96sw4jzAuGbdInIWWTvsf5cUSL5LdrNog1OczSn/oG+n7O/yB7AZ2nk4RXwU4IdAtDx83FI9lCmimLIzu2MYNQRT9vzM8z+YuD8/F2Ynd4SCSc8I+OSjUXRGWQnSi+HXt2GE+TaaKvbEjwxUn1klyxtxMEzl+VN7GmBcgmXvSdq3ZuwpQ+wRUawzRNA/2qSPR0AjqjowbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7766c7b3-d6eb-4e56-ac20-08dd77796713
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:15:46.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbu5pesJO9jMr0oa+oaF51IXemZvJ5wENbybqBVnVNTqcQteV6E9rhLnwFBMPzKpCfFMbOg7kyx7cEOZGZfQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4F9D69ECB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090096
X-Proofpoint-GUID: 3AOhBnvi0Ap9VpzXrNbo85oq5Lecip4z
X-Proofpoint-ORIG-GUID: 3AOhBnvi0Ap9VpzXrNbo85oq5Lecip4z

On 4/9/25 10:32 AM, Jeff Layton wrote:
> ...and remove the legacy dprintks.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs3proc.c |  8 +++-----
>  fs/nfsd/nfs4proc.c |  3 +++
>  fs/nfsd/nfsproc.c  |  7 +++----
>  fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index ea1280970ea11b2a82f0de88ad0422eef7063d6d..587fc92597e7c77d078e871b8d12684c6b5efa2d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -423,6 +423,9 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>  		.na_iattr	= &argp->attrs,
>  	};
>  
> +	trace_nfsd3_proc_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
> +				 argp->tname, argp->tlen);
> +
>  	if (argp->tlen == 0) {
>  		resp->status = nfserr_inval;
>  		goto out;
> @@ -440,11 +443,6 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>  		goto out;
>  	}
>  
> -	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
> -				SVCFH_fmt(&argp->ffh),
> -				argp->flen, argp->fname,
> -				argp->tlen, argp->tname);
> -
>  	fh_copy(&resp->dirfh, &argp->ffh);
>  	fh_init(&resp->fh, NFS3_FHSIZE);
>  	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2c795103deaa4044596bd07d90db788169a32a0c..e22596a2e311861be1e4f595d77547be04634ce7 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -873,6 +873,9 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	current->fs->umask = create->cr_umask;
>  	switch (create->cr_type) {
>  	case NF4LNK:
> +		trace_nfsd4_symlink(rqstp, &cstate->current_fh,
> +				    create->cr_name, create->cr_namelen,
> +				    create->cr_data, create->cr_datalen);
>  		status = nfsd_symlink(rqstp, &cstate->current_fh,
>  				      create->cr_name, create->cr_namelen,
>  				      create->cr_data, &attrs, &resfh);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 33d8cbf8785588d38d4ec5efd769c1d1d06c6a91..0674ed6b978f6caa1325a9271f2fde9b3ef60945 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -506,6 +506,9 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>  	};
>  	struct svc_fh	newfh;
>  
> +	trace_nfsd_proc_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
> +				argp->tname, argp->tlen);
> +
>  	if (argp->tlen > NFS_MAXPATHLEN) {
>  		resp->status = nfserr_nametoolong;
>  		goto out;
> @@ -519,10 +522,6 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>  		goto out;
>  	}
>  
> -	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
> -		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
> -		argp->tlen, argp->tname);
> -
>  	fh_init(&newfh, NFS_FHSIZE);
>  	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
>  				    argp->tname, &attrs, &newfh);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c6aff23a845f06c87e701d57ec577c2c5c5a743c..850dbf1240b234b67dd7d75d6903c0f49dc01261 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2430,6 +2430,41 @@ DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
>  DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
>  DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
>  
> +DECLARE_EVENT_CLASS(nfsd_vfs_symlink_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh *fhp,
> +		 const char *name,
> +		 unsigned int namelen,
> +		 const char *tgt,
> +		 unsigned int tgtlen),
> +	TP_ARGS(rqstp, fhp, name, namelen, tgt, tgtlen),
> +	TP_STRUCT__entry(
> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
> +		__field(u32, fh_hash)
> +		__string_len(name, name, namelen)
> +		__string_len(tgt, tgt, tgtlen)
> +	),
> +	TP_fast_assign(
> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__assign_str(name);
> +		__assign_str(tgt);
> +	),
> +	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s target=%s",
> +		  __entry->xid, __entry->fh_hash,
> +		  __get_str(name), __get_str(tgt))
> +);
> +
> +#define DEFINE_NFSD_VFS_SYMLINK_EVENT(__name)					\
> +	DEFINE_EVENT(nfsd_vfs_symlink_class, __name,				\
> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,	\
> +			      const char *name, unsigned int namelen,		\
> +			      const char *tgt, unsigned int tgtlen),		\
> +		     TP_ARGS(rqstp, fhp, name, namelen, tgt, tgtlen))
> +
> +DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd_proc_symlink);
> +DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd3_proc_symlink);
> +DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd4_symlink);

Likewise, maybe one tracepoint in nfsd_symlink() would be better? This
comment also applies to the remaining patches in this series.

If you're trying to capture the NFS version too, perhaps
SVC_RQST_ENDPOINT can be expanded to record the RPC program and version.

Also, name these new tracepoints "nfsd_vfs_yada" and then you can use a
glob to enable the VFS tracepoints in one go, like so:

  # trace-cmd record -e nfsd:nfsd_vfs_\*


>  #endif /* _NFSD_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> 


-- 
Chuck Lever

