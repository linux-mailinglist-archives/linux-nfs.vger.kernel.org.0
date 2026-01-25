Return-Path: <linux-nfs+bounces-18451-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A+rBtiEdmkORgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18451-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 22:02:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166B8275B
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A093004202
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B5220698;
	Sun, 25 Jan 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVDxjZ7o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rtFmWuI3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94F3EBF09
	for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769374887; cv=fail; b=EepMhnfp09w19uvGw6ooSE0QZxq7RWkrESvu2SxKkvQuCMXSSZ4HtwtF8/FAE2T1JFxpCZyRAfgt2Jdr5MBerONlMva/8y7VznfgBSLmbGZdB4ZlN3u/MInichZVoObyp+BXmuf6u/tvZ+/ft4rBX9tP8uJsusyCdmC1kpl4vpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769374887; c=relaxed/simple;
	bh=aH6GL1lUumxJcklSuyFMypPn7dTQrCR4SWJ+jSBxsGg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4GzUSvGTaj2tYrZZhAVPsm8g8OYnRNRTNRElZkmZXX5wXV5EtptyvRVB5ABxOlaCws7y6w2BRzOAGJSd+fJbHinTgNQmwBJ7oxY7ci52BcZ1bp8EyHea+9tH8H7Vexmk5uV55tR6hdoluYfI2X9qm8agJcuF4aH8gp/QT0G8tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gVDxjZ7o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rtFmWuI3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PKMtPO3699907;
	Sun, 25 Jan 2026 21:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4T7q7caB5yBfwCUvCx3iSVCMxM4bkn/cesJE98Mpi5M=; b=
	gVDxjZ7of6UA1unhN88YFFzL1jIsSgsFoQ6+LbeOaMz7ez8wTH7X54HZiQWClZI3
	zLd0bya72KISYR4UlEN2IcTeIIysuBJ7MrV0tF9+YNIfVtBb/MULmu2Jjy/GOLzw
	ZB3RkN463WOSG0p9NySpyCcl2d/3bouszNmNsuEMCFij0R6iqqcVf6+8K5GoPpNL
	H3FRRlQ/2pWYegEKrcK//Wg6uPCw1c8KxNYBxcnt3zNwkcL/iWK93XVBIZvthS+i
	Nsw2wCLEHgDIy/0NPVmhwVPzLgKYlNP1TDFtAZXNCmejA617i3P2hRgyg8KWIbwX
	tGRDS/LwTGBRyVxA988xdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny15vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 21:01:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60PFftfk033142;
	Sun, 25 Jan 2026 21:01:17 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7b54s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 21:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSN1SiWsGST5SSeZils0jhDN0LcboU5SlrPG8zIrjyDZY0iFMzqUyz88MvgSYrtLooSHYIYi9YAvjv0s7SD59UlH9a9s5CEw/F+j2z/TckHibDiXhBndp8SFsTIfxZIbSdEMI2JQc6KXK+EpcEuhligrsO4TpNNEEBreC3yBob8mFUckb6UTPIrrbQG0nRtGsVra9Kh/KIK3Xb8yAYpf/kam1Bk48mgZokPCEu2TWcFU5kHzqEeULnCVVD6RwKZtvvSuWT5tZSxMuxGqOfQ0WG4dGqft4zc3/4uPRlxaXgeh6DK03aqH4TBIV3qKUVw3gg2yfabdIZKXWU1FfFTRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T7q7caB5yBfwCUvCx3iSVCMxM4bkn/cesJE98Mpi5M=;
 b=Qsdfd2sh9BJ/BWGw9VhYh4FKuKg4l0XmpsWsXfpQn5a7pVGw2lUbLmK5eeoJ203KjmNn4X7EMF2ytoAzEFWzZn8LKX5ka639L6tg020pMtf6Kc7YbKHJdTIT6K/HHhf7w/CoolSgj7ZE1ztUaj2JvZYFJ1pNDgpZtTVAfrNjV/PAJOgELBF6p9JfRdJ8cJutIZtxqbJTyfwiie5QC2Wq3yT4KKtrdZpVFN+LtjLVIM4wflUr92I9CBkeUkr6X9tr8P+Y+eolALWsIwn3JMiM6dlTxPOzO+QQxx8Z0AXYvzsmu0XSMytrR/fWQHNgecg7sBR0b0UZkj/OblUizhDGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T7q7caB5yBfwCUvCx3iSVCMxM4bkn/cesJE98Mpi5M=;
 b=rtFmWuI3xHp5BoYW5DiMXzvcuGaQBI2uwDvLrVjY7W28xLEVWboj23NI12HiqH5f8I9zlcZy01ek8bFZlYDBfRzunLhc2irEWBla0WFnxhvQdbH2xExHeeHfUTZXodZFcgAm3rYGzwWqryP7hmjZlf5lgM0h63v6bUfYqSyfEV0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 21:01:10 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 21:01:11 +0000
Message-ID: <dd2ac9c1-5656-499f-b97c-4c5155523330@oracle.com>
Date: Sun, 25 Jan 2026 13:01:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: knfsd read iops limits?
To: Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:a03:100::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6617d059-786f-4c33-78ce-08de5c54de47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzZjUFNaM0FBTy9KMDFtbVZhdldBTitadCtvcmlxdWx2Ykpxa3lxV0xPYUVL?=
 =?utf-8?B?Q0VFVTdZZkNUWW50WFpFWjFsZGs3SzFna3JFUm1lT1Nlc01JcDhSV2lPZlRL?=
 =?utf-8?B?cEcrTitBTFYxN3kwTThPNXlZSjdzTmk4WE5acHpqazFmVi9QbE9Jc05DT2lj?=
 =?utf-8?B?cm41SEhhQjA4RzRydmNVY0VVcTdndzVpMDdpTVJVQTdNMittcXp0c0FOMjVl?=
 =?utf-8?B?OVpaQXRIN0d6VUQvejRCRUdxeTN6ck5rVVljYzd1TkNIajlPcjJ3RG92WlV4?=
 =?utf-8?B?S1NaUWhJS1RaQVA1ZjhZZE03ODRTOURqVFhpY3ZERnZWZTVpVmFFbzdmOUx0?=
 =?utf-8?B?RTRudm1haHRsMEczWXcxQW1ZZk4xeW9oWnE1N083L1cvM0xqNm5IUXQyK1Ny?=
 =?utf-8?B?b1pFUnVxeW0vUm95UXVpWC90WWZmYUI3aWkwUm5XdHhrTzFUbU00ZUVuSjlK?=
 =?utf-8?B?bjNuVmVaL0JsMXFibmkybm5YNjkxVzVBd1B1THU2MXo4Wlpic21Yc2FHTnBV?=
 =?utf-8?B?d2lPeFppVEIyN2ZRMlFPRlhCcFc3bXB0K3NqTldvSFgzSElscC9XWjhLNDFs?=
 =?utf-8?B?UGZOU0NSMWVFTytNbmplYXM4ZGJsRVVyaEt5YmZBT3FuTGNsWGluTzBueXFi?=
 =?utf-8?B?bEpNRWJVajkyamRWaXp5d2hianNHdXR3QytJM2xkeVk3RjA3aWF2ZVpNTTdt?=
 =?utf-8?B?MlZSUzNLbEY3UGxETG9jcjcwTkl1SkNFeVI1dzlsT3ZJa2x3OEh5VklhSTQy?=
 =?utf-8?B?QWFWWVZRaCtEeUw3eDR3Y1pNVmk3d3VKditXZGtQZmZWeDVwSTFrNHYwcm95?=
 =?utf-8?B?d1BaNC9XL0M4NTFYcjlXcmpJeldwWEJBTFordTFpYW1HZ240dzRxbCtpd2dn?=
 =?utf-8?B?WnlDZzk5QUFTT2cwb3E4LzVCdGkwZ3RLdEpBNVg0UkZYUzg4aS82dFZ6UTAr?=
 =?utf-8?B?Mm95Mnk5ckgvcjM1YVJlR2xiZW9WUVl6U0k1Vy9hTGlSZ3Vvc01TSUtXamFP?=
 =?utf-8?B?cExBcGhuVVlHWDhqT1h4alN6N1ZYQlNuSWFkenBVUnkzUWt3YUZodHVpMDVH?=
 =?utf-8?B?aks4cXE0akg3OXhMaGordTYybVVWNWZwdDJsWW9lZW5TUWMzV25rYmVMT1ZY?=
 =?utf-8?B?TSs0R1ZSaG42aEJySHlKZUNEZFg4bXJzeXNqWmJacjVqZFdSQXpuZTZKREgw?=
 =?utf-8?B?V05UaGt5c1U1MDhyVy9xN29HZURucGFuMkFadGxJYTJkNkx5YjFDM2psc0NC?=
 =?utf-8?B?TkZ3Y0F5V0wvLzl0eXFZK2ZwbE1rbUN2dG9iSjZWNWpVNDZJMGplcnhQOE95?=
 =?utf-8?B?ZmNDVFNUekQ3bDMxNCtIaWtOTUE1enZrMElSL2p4N214RXAwd3hLR1hzL3Jj?=
 =?utf-8?B?TCtjbkNhMUN3d3BJWFpKTGxtYmVwaHIvdVoxUGlKQkQvcmtJR1FJaVlTaDBw?=
 =?utf-8?B?N1NRRUE1NG5kcXpuR0lYZGVnWC9ub09Xbk94ZElZSjBxUVlTOEdIR1dsY3hU?=
 =?utf-8?B?OG4vTG50dG5mSTlYd3ZOOTV4WXk5L2s0eVJQVU1md3paQXNHYXl6VUluQ1JX?=
 =?utf-8?B?c3ljV0REZVRIdURISWlQNTF5TTRyL3pnMUhIQjNVQ1JPTFdQSVlUS1lYZGJP?=
 =?utf-8?B?a3B4UmJPVWY5TnhCc201VjViTXhrS21xSWJBMWkxclQ5ck4xYUR5TzZ5b2tp?=
 =?utf-8?B?Z1c2UXMyeGFmOGtBRmh1RkxtOUo5c2tnUTlxTkxYcFE2eHM2YlQwbGtTQ05o?=
 =?utf-8?B?RnRtTE0wSCtUNzcwaFFlM3dyS1RTbGM1Y2N1MmhVbUdTc0ZNVE16YzB1SlIx?=
 =?utf-8?B?NjkxalpUM1poeDFlUmpLZWpaRGN4bXRhM3l1cm11dmZvVUYyR05aYzQ5bi91?=
 =?utf-8?B?ZXBDWFI1eFpaQWlGMk1EVHVHQ1dRNW1KM3RjR2dLc2xFMXRrY0tHT1VrM21r?=
 =?utf-8?B?ODcyTk1uSk9kWUhWZXVsMXNYTUN2YkcyNFZGUnRGanlJTjIvTUIvemlsWHhw?=
 =?utf-8?B?K1BwZ3JIYjlBQk9xcjY2RWhoM05lcFpsSlU4MXQwRzAxU1FpMmMzMzU5U0E2?=
 =?utf-8?B?dU53bDlHYk1JUjJiWDV1Vkw3c1JTcFlIQjZsUnBJSDdEcUJRMkJqaGw3dUtq?=
 =?utf-8?Q?1Dig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q202L0JlcXVLcHZMY3dWRWtJcHQ3eXJSMnlqemp2d0thOXRCUFJrVkI4S0ZZ?=
 =?utf-8?B?VUgzb2N0NVZyNUplSEF4MFhtVXZHc3FxbnFoUUZOYkc0UCtqMGJEcnJSNTVW?=
 =?utf-8?B?bWVudGUzTnhLTTJ5eUJSVmdEVjU2WjZCbnl6bG0vY2Y0Y2MyaEdNWFVzMnpV?=
 =?utf-8?B?eU5nV0hHYkV1UllWcHgvcTYvSmRiYWUwcEIvSmMzUVQ4aG5tb2NEMEpoVDR5?=
 =?utf-8?B?Zkh6Tmk2cDczVGUyNFFOeHp5QkJJSEpkRVB3MjhxcDM5dkp5blN2aU1BRVJv?=
 =?utf-8?B?K0YwQU1UWC9vYWVkSlhKTGkvSFJKcWhyMWpLMkFSUWdCaUdXcEllQUcwWW1S?=
 =?utf-8?B?eEdlcDNDVFhFcGxGeFEzdnJDTS9IYWhvbVdhSzA3TlhURmVtdkI5TGwvK21X?=
 =?utf-8?B?OFZXSGRyYUFZMXdjd1NlQk84aVlqRXVVZXJaNWFyQzdaTW9nV1Q0R2VXQnl4?=
 =?utf-8?B?Uk1qU3dLVUZJclE2OFJCcmdzMCtYVW5HQnYrY3B3OEJBUkRwRTlpQ1RacW9M?=
 =?utf-8?B?UCtETFdmekpkaTdXYWRkcVNNQmpiczdGQXJ0SlJoUXpzNjNSbnVDWkR0TDZv?=
 =?utf-8?B?L1l2blh2WnFYakpxTkE0Vm94cEM4alpZMmtEcWNBcENtRHBXUm1BMVVQTnpm?=
 =?utf-8?B?M0RQVFlUb3ZxRzkyV1pkUFh6V3BXWGMxRk1SaFVFS053akRpbkVrQUVGbHVv?=
 =?utf-8?B?cFlvTFBrdkFHYVAwN1FleFYxV1pvVkpmTGV5T3R1cjVjZGNwSU82aU5XK2sw?=
 =?utf-8?B?SFBMQTFIaUtOSUpPZXhNWmpnQXlkYXdrRkNzK3pCb3NEWHE2UlhKNWplQXRB?=
 =?utf-8?B?a0xXeDIzVDF2ZGNmU240bGFYcm94UzVkemlCb2VpY1h6dWpENTVyMjV2MXNh?=
 =?utf-8?B?RXVxK1NHTE0yZmROZDNkNm5IYk1jTDZuRUhaZ3pWVytBRVFkaThaNWNWeGh0?=
 =?utf-8?B?YXJkYUM5VElPK2NlWnQwQmtzZ2p1UEUyQnZJY1ZwN0JabTdNa2pUa2dvR0I0?=
 =?utf-8?B?UEdDd0hnRWdxbzBMT3VDU2pUMVM3SWVodzlOd2FEQWRnNld3MjlYSnUvc3BG?=
 =?utf-8?B?ejRnSnEvRXBZQ2xCZ2NjNmlBdjNIU25UOWo4N1FRY0dWWDJURXdNbEFJQ0dP?=
 =?utf-8?B?Wm5ZNzFsS01LKzgrMzE3L01OUUllazlKU1dsRDVYNDBuazRkL0hYQTFqQmpn?=
 =?utf-8?B?UGtiVUxWZm55aFZ0Yy9xTW0wdkhFMFJCRjBvVGxNUUxnYUl5Y2h5czU2Tisx?=
 =?utf-8?B?SnJuZGpMc05YV0t5cndPK1lNejc0ZjdacmlaUG9pYmlOT2cvSUFVclJLYTRk?=
 =?utf-8?B?aUlxRE1RS2g1UGZKYmFzTVNUdFlQSW10TThSUkJOVVZrMFFIaVBVV005TGJ6?=
 =?utf-8?B?R20vdkx1VEVYdXhuRUQwbkpMZE9KLzJJN1VoZVp0QTY1NStZeXY5SUlJTmhZ?=
 =?utf-8?B?RWVlcFV2RXR1a3RyUXR0QWcyK2tkTlFvK2dNVElXZ0l1M2JEd1RsZWFPRWZ6?=
 =?utf-8?B?K3NUbUQzMGxPQ3BtNG44SFFXck01Q0FqSTlGUW9QeVhEVHRQbFBISzJyUi96?=
 =?utf-8?B?ZUkxYnB5NGxYSElwSG5yUDNxM2g5MHlscGVLcFk0QzN1KzI0bU9JQkJjbHRT?=
 =?utf-8?B?QnV3SnRGRTlENitsSHR4eCttK3ZqKzAyNi81TXlBSkVSUEc4L3JVTnNnSVYx?=
 =?utf-8?B?czE0Z1VpNDN4L0ovT1lpb3lObmhod1d6cWF4QThRNksxTHJpbzYyU3YyTHBM?=
 =?utf-8?B?US9LbXkzM1p3ak5NL09GbzJRNStsS2ZRTUduOHk4d3hOeHM1QUwrYklsSEt3?=
 =?utf-8?B?NjMxMm5JNGt1WTVvR0lTM0doUC9FSE5rTElSYUlJc2QxQ092WDlsekdIOXdu?=
 =?utf-8?B?WXFKeS9ZSUF1UGhpdVM3VUxVMVVmOERTQmFLZkVVZEZRTkVURW84YjVhaGF3?=
 =?utf-8?B?SThQTGlPMWI2dTlBb1hGQnVhSzN0RTNvb1Vpa2ZPd2VxWS9SRzRJVmR6QktQ?=
 =?utf-8?B?elNvOWxBT0k4YXdqVnBhL0lGbDNMWTFFNlVHSnVIUFRMTmNDbEJMNExZVDJN?=
 =?utf-8?B?b3dSY3ZrRkpUbjJSNjQ4M3RadmI1RU1yMURYcnhaUUZjYi9TOXpvWm5DSkI2?=
 =?utf-8?B?WklIRnZjTlFuS3lBZUZzdE9RcUhMb2c2SDAvWlhKTDBqbWJ5cGtTNnpHMVFW?=
 =?utf-8?B?MTBrc0w4SnBKeWhiczUrWkNYeFJZQUpEbHR1Mm1KSjVtand3azFlVnFuQ0p0?=
 =?utf-8?B?d1ZDWG1yTjB3cmxyQkhneXg4eWFReGZ2Z1p2blRLdVcyM1FmQk44M0laVzBN?=
 =?utf-8?B?Qi9nTFBzMHdYQ1MvWUl5RjVJRlNIRjcvQVJIeHpuRGtuSVpOMWdTdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ewhyQ5SHVn011OkU+P6D5V1/zoYmwoXxkqXbZLeMYElXrWl3/sjVP8rDE+l899Oqv/Dosl+kkL4t0tD8FkXlhFZaf0U1Pfh+AiJE9RDReBGitdkdCVdKMC2j7RfhpsITWVZHUdwq3LTtgnxCG0XH9TflbBgPtF8Kd+tmSM0Qd6IaEn8AI15/8jaKKTEXLWUMuUby4Zn9x7mGaB5MqcJ3Y234IzLMruRiHXEaGpceJGMvCAmd7OMmMF3AjrDKOIfvhgV36f8GaryTzEpbXzvQdCpdqRhIyXMsy1inwmanCmVk29TeE4bb+hSiavQTTCPYrFoZ86pb8DR2YJkh75DizDuTsinNeN4S2v2BQ3hXwuT2KRo3OyzpVD0Wn43rk+E+Dk3yEnN9HiXVKt3Ua8pvV1sOmbfT3NRafqOzvG6j1Ba/NYdifhd94767eMuOH1ScQnByANrUXQljNwSgco7SSbRawgGWUQQJYm+ONPb5ckG3IfP14+5df7tGayg532qqlFb/O9iSSyMCH60sVRybaf5JA1zykrIfZnP9XMlAfgywz5jtlLfoekiA6QHtOqjTKV0ch9Bfe5HESwx3BPOrAJCtS25YR1aZPdxrG6WNYN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6617d059-786f-4c33-78ce-08de5c54de47
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 21:01:11.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC0iaODcqfdKIdEdyqcE62dwdEf9rQHShXVa2W6SEt1xsdOJ6T+xxFp5OpEHKMNlC3bmCnQD60IrY1rQCZTv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_05,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601250176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDE3NyBTYWx0ZWRfX7B+3p7I91LuS
 BECpeqTNM5ecSe4XeDGvKqyvkheFcd7bS4Dse2AI0MopjOoxr7ifXjeaGm3sgWvzlNKMiI7M7mA
 DniFCfGhY3Hp458SBS/4pz2tQ6Qwsm55xso6PfEtwicnsx0PmIYEYrAo0zea4jNP7JPoowYotAj
 s1+Yc91uDModIRbeR8chwUiDZWhkL8f9W+A/hSNwGHyRvWSYffj5zw6CCq97OI8ZDFKtb0ppjE5
 LTw4TpEE7wPpNvwp6nvNnB+3I7T5NzpAgJsuEvI79Et5A+R9dWnXGw6weVqbEgzXCC/Y85Ip+Kw
 djY2Rhxp4GokjHnbuSH9deH9mqSXvIlQw3tJLPg9WI6SAWeXBXK23TjivWyC2fYqLyZ7WHAlcU8
 yfAUdpp824sDKxCG/daLARQLXRpmbKaxb6AQ/buZQNYiz4tG/QQTy3Hg9tvoZox31CNey0rtS7+
 +mEvyvLWXyQKqyHUrhA==
X-Proofpoint-GUID: XHH6eMszaFUcRvIrzBKkk0NoD4KQ-2Pd
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6976849e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wyef9QmDdebx_xiAnTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XHH6eMszaFUcRvIrzBKkk0NoD4KQ-2Pd
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18451-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7166B8275B
X-Rspamd-Action: no action


On 1/25/26 4:26 AM, Daire Byrne wrote:
> Hi,
>
> We recently came across a workload that consisted of 100s of clients
> under (cgroup) memory pressure and so their page cache was all but
> exhausted. This resulted in lots of repeat small 4k-8k random reads
> hitting our NFS servers which maxed out their CPUs and flatlined
> performance.
>
> Uniquely, the data being read easily fit in the server's page cache so
> there was no backend IO to limit throughput.
>
> The fix was to put in place a system to kill workloads under such
> memory pressure. But it piqued my curiosity, so I decided to do some
> simple benchmarks to see where the server limits are.
>
> I ran something like this across 200 client hosts simultaneously using
> NFSv3 to reproduce:
>
>   fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
> --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
> --rw=randread --numjobs=2
>
> By reading the same small file from many hosts, we are essentially
> serving from server page cache so can rule out disk IO (I even tried
> files on /dev/shm)
>
> The main things I found:
> * across a wide range of server hardware, we top out around 300k-400k
> read iops/s.
> * whether the server has 24/48/96 cores, the results were pretty much the same.
> * 24 knfsd threads is the optimal with more threads reducing
> performance until threads=ncores
> * multiple nics (bonded) or single socket (no numa) makes little or no
> difference
> * different nic hardware make little difference (2x100g, 4x25g,
> broadcom, mellanox etc).
> * various network tuning (queues, txqueuelen, qdisc, etc) makes little
> difference.
> * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
> pufh ops too (+ 2x160k/s).
> * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
>
> It feels like there is some thread locking contention limitation such
> that the number of CPUs and/or knfsd threads reaches some plateau and
> throwing more cores/threads at the workload just results in more CPU
> time spent spinning but you get no more performance out.
>
> The top level perf report looks something like the attached (for v6.18).
>
> Like I said, we can work around this pretty rare workload (random
> small reads from server page cache), but it just piqued my interest as
> to what the underlying (knfsd) server limit is (it doesn't seem to be
> hardware).

Have you tried to increase the slot table on the NFS client side?
By default it has 64 entries:

# cat /sys/module/nfs/parameters/max_session_slots
64
#

Try to double it to see if that makes any different:

# echo 128 > /sys/module/nfs/parameters/max_session_slots

Maximum number of slots per session on the NFS server is 2048
on the newer kernel, so that should be sufficient.

-Dai


