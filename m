Return-Path: <linux-nfs+bounces-9902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA67A2AB2F
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925E67A4953
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A512B824A3;
	Thu,  6 Feb 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXdLWeQ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sjCkUSnS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672D610C
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851915; cv=fail; b=KdODJ3xerfH3UqAB0BY2a6dqqBaodrMObHfskMcoxwEgN3kKpXuqMYR2RWXwryZkj0ggpgP3noJW8mINMZuLMmesyIqDbAeGdghTRr4WP96hwgg0oZvR6lB9VenYYAYtHq7EQr3pVuJMIrZv07JAixod4gBXS2I8uY4U0DTyDrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851915; c=relaxed/simple;
	bh=p8mR4OTz8bdyvCZmMqRrPxuizLsWkmWKecil7QqTfAs=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=s57B7bAT+eHHJu3VvR2+qv9bb481kz288jdA8+GpeRM45e517tBaJO1QTnrBipht20kNYKhAxSsaoep7irJ5hkcKr4NoZkSeXZQ0bBamGs2DjIzqtN7iA5ggIWBWeeo801NjhJt5i+4Z2bKfmobwCeclE46g0Gb+nPISOC/TGus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXdLWeQ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sjCkUSnS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516EHYfN004876;
	Thu, 6 Feb 2025 14:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dRWDdCcdipuyrRG6R1bC8+u2yIxgT2+arkabk7Mn3Us=; b=
	TXdLWeQ3OJruZ0LJ81IH8fiiFW8EvCIRPEbfd/9wJaVCEfXy9cjCN1ra7dpSLhSp
	a56urVfqZH44LG5KBDjidUGQDXmqSGRTrL76/YdKH/p95Ys+qYupCwGEgw6QTFNs
	+1mPaiJpoUmT7WYRQopvt2q12TR1qH2gQ7HbAy3xuzdVFJ568ZunaO7/7zq5KTGH
	OowgZgV0z0F0zdY+RXAGoGhOcO+W6VDfQ0CGgbiKy+6ZJ8sLx63fu7id+GuwDiHZ
	6GizCkhZEbMs/HHis5tF9bHq13p5lpx7HAQOf/at6YjMlG+HHSWUMfUIjS0ZLTZs
	G1Bn8i3TP8//425qa++QxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxnbbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 14:25:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516EHeUU027114;
	Thu, 6 Feb 2025 14:25:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fq1sd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 14:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzvjIFj75IJe2zycmm7QrNurvKuuCmeIRb0Itg46/QqQZgAIF4Irattd8eUJmcsjqg48quKPLDoc22RPO49nYypdhThWm135jg/S/bclK/THr+xy9Gt+Otdpt3XPfNrBL+9MdF3xzvlOXnib6+83HhOg5y1ZIv7ECQPQCZkywHDcz+thxPyPdHHUk6NFJthXxDjuKacAfCvJi/7yN8FEcZMTStZ9x0h/SPqKrICtZfP7xm5IivQZBAAb3vKyBefA72DjNzQmGKg/QHSg0tye8gXwqbR4UJ3gBEEM1j+6xfM3SkZ4RWH/qYaZJrtqDmcnEYMWOjAhCkq4WgL5M8kTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRWDdCcdipuyrRG6R1bC8+u2yIxgT2+arkabk7Mn3Us=;
 b=NR4cfMLvcF0SYhe9UeEuhi/ZXI/0AjAZcXpKmCJ3gcAYjCd7jVAkEzhHtOnzAw66OM8qPTtOCRCLAeJ0TTVB5YXuXQWqEjHIqO/pqrikoe2dLkpk1wRdiwFjop96sseK/uXQ4CW22ggzjR6gX9OFapeH6EWfNHvRGNtjUw8s5ssaB32ZB1wooAr78rE96rpytpPLhji6mIzMsc6dBV7OztDERfO5jUL85jaQ4fkXPeo8weLdJ23UWQVW1NXBSF4eL+UTjWqVzUVmhZVCTdXVFtVXyVYUEMXZSB49KWpjPR0hfeGD1f9npgHua5q+PdE4zaSbGGrbJQ0sf5uRObpD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRWDdCcdipuyrRG6R1bC8+u2yIxgT2+arkabk7Mn3Us=;
 b=sjCkUSnSrou7He3OhyhVa1W67e2kk6dKl2FtSTUbCjHA4FuX1tZtl5kF43anycdHELE8QGet67mbTrsqUsQCeTrZ9c6lDuKzgFIg9Qi2rJZrkc10PkZ8SbM6kFM4o5QbRrb16X4XhWIyhsufpYlhubJKO3Sqt+504feoMEhSLac=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 14:25:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 14:25:07 +0000
Message-ID: <db677cf9-6979-4247-a195-5761c27ef2ab@oracle.com>
Date: Thu, 6 Feb 2025 09:25:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
 <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com>
 <CALXu0Uew5qUxvH7wum7xC1TBaP43tmrYAbU6iS6yuwJVF6rBrg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CALXu0Uew5qUxvH7wum7xC1TBaP43tmrYAbU6iS6yuwJVF6rBrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 062f7baf-d297-4764-5f89-08dd46ba0dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGR1UnFHdmZvV1FpWDZ0bTdCWHBWWHNpMFltUlgyaHdwVUhKUGtaUDMzTDRy?=
 =?utf-8?B?U3lhWnowdkZyZi9hcHZIOTJIeW1NclQ2OEFwRWJoWDRUVWZROEd6ZWkrQURk?=
 =?utf-8?B?ekJpVlJYbythZ09iS2R5ZjJSUWNobVZtOUxCT1NVQ2FtOFJ5ZDJiS3lVYkRn?=
 =?utf-8?B?Z2tVbHpwV0plOWdGbGJ4ZU05QzY2YVpuZlp1ZzlkYTlQSXgwZ2ozelZmMFBR?=
 =?utf-8?B?QUJybmNlcmVNMkV0cVVNT0dIQnZ3WXdKcHZ6MFdoK1kwcDBCa3FDNzhoamVT?=
 =?utf-8?B?M3MyQzNkYmNoTlA5MXBHbVF0QVBBNDIvSlprRFZRRm94VEJWbnB1TFFiVXJN?=
 =?utf-8?B?SzVEV1o1eTlYZ3JRTlI4amlWQVZLZ3lrVnNmR1lGQVgvdTBReXN3WnU5eWNL?=
 =?utf-8?B?ZHIrLzc0aDdVZ3UrUmp5SWY5blNKT2ZwWlpuM05mcGRtV3RNVm9mZGM0cW1G?=
 =?utf-8?B?L05lZVNJNERWOGY1MytqWmxDd1UyTVVscCtoRVJ5RFNJTlByRVkzWStuaXBJ?=
 =?utf-8?B?MkVXQ1JpbzBZUFZoZVkzRjdRWVBBUDM3bU5MeGF5VlF4RDNFWVVOcUhrNlBt?=
 =?utf-8?B?ZVFLcWt4ODR1VmRZVDV0MEgrLzdsSWJIc2lmT1lsNFBkZDV1VFVENUI4c1Bm?=
 =?utf-8?B?OG92ZzM0RkdsZ0pwN2xPZi9jV2VTVG8yZUZQMVk3ODVCK083cFZ1dFVNbUNz?=
 =?utf-8?B?UktuQVJBYXpnbWhSRGNjMkZpelJ3UEQ0UzlXbTRaSHhtOW01ZGJySWNOY1BF?=
 =?utf-8?B?WW91UWIwaE5mQTJxVXN1d3pXaDFYYnBkMFh6dXl5dlQvNGVLY3lTcnFOSFQ2?=
 =?utf-8?B?RlZHU21BdVhMRmp4b1VXbElUdSttRGZnUVlIK2dHS0RWNHVzZ1NJYWNBT3N0?=
 =?utf-8?B?a0tpdVdYV0dIb1ZqR3hTZ0JZaXFUVEpxYzdxTmptK2dDRHdDOHpWc1NUVURG?=
 =?utf-8?B?VzNxcDlMSFhWV3IwTUJjNHFYeUJKK3JuL2JXOStEcjlxaVcwbHNWbHpyaGh5?=
 =?utf-8?B?UmNNY2hxTzFvR2RZc1pWM2U3T2trU3h2TU4xeVpicW1FNmswWTluQkRuOGF1?=
 =?utf-8?B?Tm02ZEpLOGRmb1VRdXJaM1ZtZlp5dkZoRTRJTlVhQkJlQWdlS1FKODluNGtF?=
 =?utf-8?B?cWVUVnJobUdIeUlMUkR4b1FaeWRsSEZoekNJRmExMnJsc0FUZXpZQlJqZk10?=
 =?utf-8?B?WjVDOEtPZk5yNFZQSUNKUkt2eG5DUjM5aUJFMVREMTF4Sm1QKzJMSW1WT1M2?=
 =?utf-8?B?dGlkc3FGV01YTXlMRlBQUHVNYTJvLzE3c3NCTnhEM28wdE15RXg2aFgvVXNC?=
 =?utf-8?B?bElJb2lkODhFTExqUXF6RjN0UzRMVkRjdnFFeG91ZjJYY0V1dVFPRjluVVNW?=
 =?utf-8?B?andacGpBZXp1ZVZDV2tmRWZnRUR0RTRvUldnS0owSUk0aW4xdUhWNFhGT3NI?=
 =?utf-8?B?SW84aFVDN1F6VGRtcWZBd0tNZjVNMTY3VVZhZTVCU1dqaVB3VUFBSloyZFgz?=
 =?utf-8?B?TklkUkpCbEUwckFJVnNBaWR3VVlZZENFVW5pOHE0UUtxTDJQN3FsNElhQzJV?=
 =?utf-8?B?SlQyaWFLTnJmeFd0Tm5BZ2FjV1F1MFA4RnJEYXh4ZTFEZ1ZadkwrWDk1QWFa?=
 =?utf-8?B?WG5yZnhmWXNIZnB3d0JmWTVyRGNEYjJpQWgxdm4rSy9DL2dGb1dNVkhUeThP?=
 =?utf-8?B?dFQ1a3I1U3RpaWd4WDFISzVIdnZpY3k0aFo3L3hCcWFYbFluL1d0QmE0Ky9E?=
 =?utf-8?B?UE1jMW1BS2dneVdkOUhlUWo5ZWFaQTVvRGVLSUdSdG9IZHNobGR6M2xsRGhn?=
 =?utf-8?B?WEwxSmQrSFRpaG0xcDlncWROR094TXNqT3c1RGNSK0pMcDRJMmdOeTNHRGtQ?=
 =?utf-8?Q?Bbjxv/c18kgmZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVIxdUJ6NXpMdzhkK1FpbUovNTFVRVcxbDJvWERWTFhsY0dhRWFGYmpPSmho?=
 =?utf-8?B?VnlxWkozeVNHZWRIRG9yMms0enlRWXVOb3FFdkVNMlY0WW1pb1k2a003ck02?=
 =?utf-8?B?NXkvcmdlcGhsVk1SM2ppNyt5b2ZoblVCRzh6R3JhUGlyVTV4U3lXVGFrak9s?=
 =?utf-8?B?anV3anZNRlV1VjNoVmk5dHRwd0ZLRkcvR0RQOG1yMDRhUkVhZnZQODR5ZDRh?=
 =?utf-8?B?S3dUSi9sRlM4WEczbWJkbFVDalBRc2VFVnRuNUM2bmcyK0wyejRhaHlVY0pS?=
 =?utf-8?B?RTMyWHl0ZnE3SlA3d0NFNVlyMERwUStFU0w1b2tUVWhwUXAyclZOQ0ZnaURW?=
 =?utf-8?B?OXo5eW0vNFBFc2p4VTFXYzNxRS9tUFBaL0xvem5JTmM5U3pHMVkyWnJUSlR5?=
 =?utf-8?B?bEpmSlB0ZVNTWDVKeWUzSmVmV21HK3YxWVppVWprOFNPSVROdnp2MW8vblk4?=
 =?utf-8?B?M3htd1pnQzRPUDlkZEJjREZtVTVnbnNqb1dkMW83L1RGV2RnYUtsU3EvRXpa?=
 =?utf-8?B?TnFtWlcvK1VrcnQ4cGN3aXg4TVNscEUza0dlVmNWbTRiNWc1VEtOREJCeXhl?=
 =?utf-8?B?ZDQrejJFNUpVOWNuVTVZL3VaVys1R2RQUDlLZFB3SmJ1MUE1TmFoWnZ5M3A3?=
 =?utf-8?B?V09lY3JQTXhzUzFNb3FQYVFVMFpETWtSMXdZOTUvR1JzVEdiYUZiUFZEdGJP?=
 =?utf-8?B?YnRIOFpvUlZ4ZVJlYW56dXNCQkxLUUJlNHJBaXNsVUthRERkNEVrRzVMY01C?=
 =?utf-8?B?ZmpXTnVueFI1UmJEMWtWTXQyenhjQUt6YWdsZC82VEtBMnFDd0RiVGJNTXVj?=
 =?utf-8?B?UGxLUDFaNkV4ZXdYbkJpM0V2T1pNclhRUXlLS2ltTzdVcTQ0ZXpuWGlPWnEv?=
 =?utf-8?B?N3pNZlpYeXNaMmdWL0hFeDFldmRSWGtOU3IxeGYwOHkyblEyYndyZzN6N0x5?=
 =?utf-8?B?MXVBL1lGTzU1aGM2YkFLT25zU1pRdTJaVFQ1QkhRVVNDekQrd1hTRGt3RDVz?=
 =?utf-8?B?RjlueHRyZC9QMTJJejN0RGZFd3N4b2lXcEpWc3hpSjlKUDdyMWFTcmFBZmhK?=
 =?utf-8?B?STM4cTZyVktrRGMvTjNSZ2JZOS93aWZBdDN6b3pCMG53cWpGeDNGTytmR0Zr?=
 =?utf-8?B?MTIyN2FjVnIyUkpWOVNPVzZITG0za1JMd2RRZFlzQUhVa21jQml5OVpjK3J5?=
 =?utf-8?B?czZ3Y0l0QktOVFBLT0pkRFhrS0lCMkZqYmtnR29Xb3E3bVZVdWhaMjdML0Rn?=
 =?utf-8?B?ekZsVmlMOWtobmFmUTNKK0NMQmlCVGU3VFBQRGFQT3U3VFhBR3B0T1RVSmRI?=
 =?utf-8?B?Y1RpbHp5bkQyYWc4a2I5S3R2Ym15MldSK253aU5YZFVkZWg3YlR2eTFjM2wr?=
 =?utf-8?B?ZHZZY3RBQkU2L0VuZkU1aDNpQ3BicmJIUGtLNzlmSEFIbWIwekpXbVNaZ0lG?=
 =?utf-8?B?UG9yZE1sb0RmZ2tDSkVIQXppa29wNldlbEVlRHA5NG0relorT1hpa2MwdzQ0?=
 =?utf-8?B?clVrTzBLc1FmUlNjV1F6MHVpUnljN2RadDh6elNqMUUvdU4zZ09WMHRqK1Jh?=
 =?utf-8?B?OEx4Y2dwNGFrYm1oRmI5OUdGNEVac1EzNUZhVzR6a2Irc1ZoY0lSS0Y1dnJB?=
 =?utf-8?B?dWtCemdnZEVMTVZkdFdqcWMzZzJYYXUyaUZmQ20vcHRsTXNUemMranordVJq?=
 =?utf-8?B?NWlMRXhmZ2FINWVZR01UbG54Szh4MnMvSXdnNkZXRjNabTFrVVJaRHJ3VVRV?=
 =?utf-8?B?RldVMWVld2RKbVNZL1k5R1h1Qk8wU2dtZHlORGd6VWx0U2xjaDNPNXNNRStr?=
 =?utf-8?B?RHl2SG5oZFloa1pscHBSQXRJbEFaL3Q5aWtwcjhqci9nZ2EwZjhFS0RhcXFB?=
 =?utf-8?B?aVp0djYyZjFydUc3QWtsNTMvNUdsa2dQK09yNUdZOFMxaWpGbjFtWHZ0dFVm?=
 =?utf-8?B?dUxNRnJCZW94b2dRMSs4aEdlVU9Rd1ZWZkhPNTEyMGE1eU1xdklWRVFzKzgw?=
 =?utf-8?B?MFFHUmtURGlzWUQzQklOYlBlTkoxakJFVG01bXJVV2dqWUpGVEs1M1IwdDQv?=
 =?utf-8?B?WUgvRVhJMUFUYnNWOHc2bnFpYjdSSjRGM1F1K2lVdFppWVduV2wwdHFIcFZH?=
 =?utf-8?Q?BlRlI9fv7+UzA03i6dko4F6xX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UqtKtMifuo9oMGMoxfkT3tZBKxEj/1sQqPvKoQV6ttz+d+Uf4xmt8qgMRVE8rwF9F1Ig/ToIT9h2o+9n35sjZ0njEUCkN3Ielmas2HCeD5Twq+SuCzzcT3TaYjeisG/Pgv94EF/VPaV/7dkengo3iBWWfTB05I58q+g+bsmYrZ82g8hBZjv7GAlx4w9yE/bdSQtSf507m/sQx/Q0XyQoh8a6XxktHJ1JItKgnUrOqPIrUwKA63QmAxqg2wYj2l4F3dsdZAKS2xAG9Ez+g4jUTCWFqVaQ6HYaDN+1hhYZ9y6jU3PW41C8L4OGz9EtwTRX04uTz23qN/db1zFVd4IZGH/ZpAPFaMCgiCW4Se9AEm0mdNeDAVlQa7yMbFuWYen9yLtrKKG8ksTDhJ3VzbRCjbrzbVhYLrM8bb7bQIeRBx7YWZn615lM17xbki2oPHXGCZu2rnnW+miSnu9LERQ5kMi9nabiuOU05wB6Eu6u/wv/5v6qXHA2wF1dX3e7JYtv4J+nwXWcETWUTX3OdRlMCXUlwhSrwOCN5zyHnE/cJf73Ckdzwf3zHvS9T2CrXo5xTQEpZi9bo8sxGe9cjXuWPYC8MMEW0CBtYGL0jU+EICw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062f7baf-d297-4764-5f89-08dd46ba0dfa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:25:07.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTxPzW2hhWksPuw9dHzuIJPlopwj3DY2hDaNBr7aTfi6pDoOQsZjOoS3JVqgKLkJ9nu5m+rpS3E1NTMaC2cmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060118
X-Proofpoint-GUID: Kw0aYWoFMqrUly2lO6alGfvs0CHS6D7e
X-Proofpoint-ORIG-GUID: Kw0aYWoFMqrUly2lO6alGfvs0CHS6D7e

On 2/6/25 3:45 AM, Cedric Blancher wrote:
> On Wed, 29 Jan 2025 at 16:02, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/29/25 2:32 AM, Cedric Blancher wrote:
>>> On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>>>
>>>> Good morning!
>>>>
>>>> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
>>>> giving the NFSv4.1 session mechanism some headroom for negotiation.
>>>> For over a decade the default value is 1M (1*1024*1024u), which IMO
>>>> causes problems with anything faster than 2500baseT.
>>>
>>> The 1MB limit was defined when 10base5/10baseT was the norm, and
>>> 100baseT (100mbit) was "fast".
>>>
>>> Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
>>> 10000baseT is fast.
>>> Just the 1MB limit is now in the way of EVERYTHING, including "large
>>> send offload" and other acceleration features.
>>>
>>> So my suggestion is to increase the buffer to 4MB by default (2*2MB
>>> hugepages on x86), and allow a tuneable to select up to 16MB.
>>
>> TL;DR: This has been on the long-term to-do list for NFSD for quite some
>> time.
>>
>> We certainly want to support larger COMPOUNDs, but increasing
>> RPCSVC_MAXPAYLOAD is only the first step.
>>
>> The biggest obstacle is the rq_pages[] array in struct svc_rqst. Today
>> it has 259 entries. Quadrupling that would make the array itself
>> multiple pages in size, and there's one of these for each nfsd thread.
>>
>> We are working on replacing the use of page arrays with folios, which
>> would make this infrastructure significantly smaller and faster, but it
>> depends on folio support in all the kernel APIs that NFSD makes use of.
>> That situation continues to evolve.
>>
>> An equivalent issue exists in the Linux NFS client.
>>
>> Increasing this capability on the server without having a client that
>> can make use of it doesn't seem wise.
>>
>> You can try increasing the value of RPCSVC_MAXPAYLOAD yourself and try
>> some measurements to help make the case (and analyze the operational
>> costs). I think we need some confidence that increasing the maximum
>> payload size will not unduly impact small I/O.
>>
>> Re: a tunable: I'm not sure why someone would want to tune this number
>> down from the maximum. You can control how much total memory the server
>> consumes by reducing the number of nfsd threads.
>>
> 
> I want a tuneable for TESTING, i.e. lower default (for now), but allow
> people to grab a stock Linux kernel, increase tunable, and do testing.
> Not everyone is happy with doing the voodoo of self-build testing,
> even more so in the (dark) "Age Of SecureBoot", where a signed kernel
> is mandatory. Therefore: Tuneable.

That's appropriate for experimentation, but not a good long-term
solution that should go into the upstream source code.

A tuneable in the upstream source base means the upstream community and
distributors have to support it for a very long time, and these are hard
to get rid of once they become irrelevant.

We have to provide documentation. That documentation might contain
recommended values, and those change over time. They spread out over
the internet and the stale recommended values become a liability.

Admins and users frequently set tuneables incorrectly and that results
in bugs and support calls.

It increases the size of test matrices.

Adding only one of these might not result in a significant increase in
maintenance cost, but if we allow one tuneable, then we have to allow
all of them, and that becomes a living nightmare.

So, not as simple and low-cost as you might think to just "add a
tuneable" in upstream. And not a sensible choice when all you need is a
temporary adjustment for testing.

Do you have a reason why, after we agree on an increase, this should
be a setting that admins will need to lower the value from a default of,
say, 4MB or more? If so, then it makes sense to consider a tuneable (or
better, a self-tuning mechanism). For a temporary setting for the
purpose of experimentation, writing your own patch is the better and
less costly approach.


-- 
Chuck Lever

