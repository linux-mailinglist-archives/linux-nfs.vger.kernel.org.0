Return-Path: <linux-nfs+bounces-12576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0477AE084A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473E33AB912
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F72278E40;
	Thu, 19 Jun 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMH3sHUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RtHCfJad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86126A08F
	for <linux-nfs@vger.kernel.org>; Thu, 19 Jun 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341992; cv=fail; b=HEi00z4eOQZMjyPVUoy4VkruQYmAa7PwyPyEw0aeoNQRH8fOKkucixzw0c6f3M9MPMdbn9a+Kv4Xs42SH9A5ubK+JNc4cTt8QI+0zbmBN9MTY27VeebokZthqdCNiHaD7flOPs8+eaM75O5oO3pEN8TknPXVP8c1x8IndVugcFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341992; c=relaxed/simple;
	bh=mtrU/YQ+x/KNmANycmT+QqeVjSXeHJGDV4MaXb2SeT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKzZ3J5R5pylxTrQewXyHvSOQeY56VsGxnjt8V/b/NAKqO5nv8WxeUulmbKoNzmFzCo6B8OBDR/jcFJEPURQvY7qJhycV5HfYljlWN5O1Peiy6qa7WEazs0Inj1XISLrmx3+z58P+OmiRsPsHMBwVgHNklhck78AtgZdcWfkVaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMH3sHUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RtHCfJad; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JDmF9U017417;
	Thu, 19 Jun 2025 14:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6LwUMEu+doA8FUX7DaHFD4/Dg3HRRqOxvHdRH/zBBFY=; b=
	CMH3sHUxTvejKS2JUZJklKyVn0g/w2/Uct+b1HIFB13BtC7Tdi5RDSBALfA9ysIM
	wX0Tf3stCoxeXz2vb50j8SrR0hw3p3XxrdEMUq2awktYWa506xx+o7K1fNPlZq4I
	IBVZoAOrwavnJ2eZjsPGcpAvBL71JQAImO8JucEVdg+c5MqBf6TMlAoGLEvAFgMP
	mfyVrLkewSlVUc57hcG5JM6V42yElajyJnM23QV/6j2D3P93Ftt1+VN5os6a7s2w
	jqhPMyG8sky4jb6Zh3yRa2CNfA+7fpMW0NZacwhkzaSfF7TtUXcAL9kbHV0XH6in
	PgeSO4AAZeiYKheTeoPm7A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r906e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 14:06:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JDPSGI022739;
	Thu, 19 Jun 2025 14:06:12 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012065.outbound.protection.outlook.com [40.93.200.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhj70s3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 14:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUs/OiFWvy5hlAkdLvUtTV0DK/rTYu9Z/b6dTORoJlxOgFP8x//HFqLTHfktjzMiU8lOAdDjZ8MTduJvZQU/FdyHqIz2Th0pQ+HIi4Znc20O2GcKI5LZvqdil4MlK8tKHlBkOzXszi+KGPnxPjq3RmjKhXYP6xbD1KkngAlfWkoKAAJNY/36vIFaNDiICfqin8nLQAaxoYFiYPiYMMfovjbaK/NTkl9ZzAse/jaV/7hAkrMo4ehvAQAsGSiRygwDwviiRIj7IGx9xNZHcSBMFTqjg9z7bEUtFnaEp8g/hjb2/WF4kpWEMKgYLtADHKaUTXdNcNsc6KOWmHxP8xA8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LwUMEu+doA8FUX7DaHFD4/Dg3HRRqOxvHdRH/zBBFY=;
 b=zE5nXPtvwk00qQAttT8kwdnpBW4WgmxGwwMcqbgZ0VPUPQuubeNCQSIrUdZqfwhMTtEqhx9NBKA4noT/npSAa0QWTu2YQETtQY1NIeXlpS4YdmZw4Qyk8VQIzWsxI0zMtbtlrnKJ3QbJK3y/3F13qtPAnPBzuyf7wFEXGb29VwhY5oYrEYtzWCVHp4HJXwsf5XJalmXm2PpMQ9bzrgVqzz3tebg+VEjnFWHEnBCohntMuZ0qwZMIcmvS8EAk9W1qViXrF3lB3OmF5BSTm/A9SEd51dSbK8wCixasdF5xr/NYWoemPbPKOYf4FFinKaxYX8Tc5H4QhQnfH0Eh7TFoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LwUMEu+doA8FUX7DaHFD4/Dg3HRRqOxvHdRH/zBBFY=;
 b=RtHCfJado5Zd9Oc9atFL2+7Fn2bhX7a8xhcgb4e/Se1TG0Z5e8E/ctyeUi2+eE6nF3rEQOjknYCRGwpLqB6BO97XNRScR2lnLLwsfDBoNVDbvk31ctGxik+IbNe/aQLAeFSlxrU4BYdC4vJq9Ehp5EZTxadAHRS9JW+ZiHSx0oU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 14:06:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 14:06:07 +0000
Message-ID: <00bac421-cef6-451d-b868-592ed34c15af@oracle.com>
Date: Thu, 19 Jun 2025 10:06:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nfsd: use kref and new mutex for global config
 management
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Li Lingfeng <lilingfeng3@huawei.com>, chenxiaosong@chenxiaosong.com
References: <20250618213347.425503-1-neil@brown.name>
 <20250618213347.425503-3-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250618213347.425503-3-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:610:11a::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2229fe60-b287-454e-e69c-08ddaf3a6f89
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NXNDeFdKbWFUWXQzWEJ2UGszNFhTcndaQXlZSm5tSGJTS3ZMUGZGdDRsRjhk?=
 =?utf-8?B?RXVRam45ZUh5TFN3TERqMUJPcDJXam5icmt3aTRRMFRNOWZPODhWU0VYY1RQ?=
 =?utf-8?B?L0tiOHVMV2RaMEtXbkFyNGRJU2RLS3RuU1U4UDlaY01pTDBMVERrN0hMNm1C?=
 =?utf-8?B?b0dkVVNNVWlTaS95cUNzNGNvak02aEM1VlFaMlFBSGVGUHJQeUFhbVFvaEow?=
 =?utf-8?B?djh2bVdnbHZFZGxLLzhZUWQ0K1NldEtnK3MwTTlwQmw3dlBWaVpBWHkvMU0v?=
 =?utf-8?B?elhNaG5BUDZsT2l2NGxsQys1bXY1M2NRVUh4MWlzd0YwOHJVRUJnd095N1hP?=
 =?utf-8?B?NkVPWER0R3I0MEpWZjk0UFQ1OEdUaTBJYjBwemFZUGRzSmVnTDlKN1pzc2dG?=
 =?utf-8?B?RHBQL0lHQmRDNWR2Y25HVTNGdjIzQXdGZHg4TnlzVGJXSGFMbE92WmM5Tk9L?=
 =?utf-8?B?Yi92K3pRSW4yQTlDUVhSdDByNDRWSmFPQ2FmUGVLVGVCNnhBb1FEb2dlVG1N?=
 =?utf-8?B?Ymt0Nlo3Mm9FNU93Zmt0ZHp0SE1NOTA1S3NsMkdRKzcxeE8xZmM1NFMrNVI5?=
 =?utf-8?B?MDVzcURZMXU2ekdzRXROYlNoMzdpSFBIZlo1TExCZy9tem5zcVRMM3ZQaWRj?=
 =?utf-8?B?WGF0anBudGc4R3BKamo4RnA4ODEzZ3NuTW1ZTkZTR3BWQmZIdzZOZzBJblR4?=
 =?utf-8?B?OE9aMnJscDVqdUJoMUtDOW9mS3JvSldCZ1BQeUZHMzBFTzdpMFRRdnNjdVh3?=
 =?utf-8?B?WDdjT29KZDdKWlNydzE1VTI5L3NUZG9iQWZFbE1xQkZHRzh0NkU0elZ6dnha?=
 =?utf-8?B?NG9ZajJ6TUhTM3pFVFpBR2FDTUpXcEgzR1hOdUZESHB4VG1PK05CTFY0TkIv?=
 =?utf-8?B?VFIyZnQ3U2llZVV3NDAzOWppbzhWUklwUGpSclVxcU5uRFN5U09tek9QTkQ0?=
 =?utf-8?B?SWIvVWIwL3JNaXlnTmtlM05iZGNLcWFHUFdudlhKRWZUY0FHMDBtcDNWVHlF?=
 =?utf-8?B?VXplNGRORDRJNFRSZUY3MDdKM1FnV2RQcnRza1V3L0pyUmlTdkZpU0o0c09Y?=
 =?utf-8?B?K0hDYnNmc3dIWWFBS3dJNlB4Tk4wcWhJdlg3dUROd0lyMExTU1hpZis2OFpy?=
 =?utf-8?B?OFp3NGFVcHRhbkUvTmRrUHVXRUZoRkFXM0JyalJDR2p6RkYxTU8vNCt6Z3Zq?=
 =?utf-8?B?Q2NocS9EeUZGelVoeWUwbEdZQXR6R1BlZjc4aDVYT1J0dmJqSXRRTkRHUndy?=
 =?utf-8?B?dFNsRUxVakplSjJyMy90Nkl4ejNSTUZwMjhWTlZtR0FlaVlsblZmSnZLODhH?=
 =?utf-8?B?cTI3SCsvNVlONkhtYUxFb2g4enoxcmkwdjZQVXpuQkdtdk05alU0VHY2MEZC?=
 =?utf-8?B?eDc4MVNubUJyVm1FV1dOWERTS2JtNFdzOGYvVmFkU1BDN003ck9WRGhiTkVZ?=
 =?utf-8?B?TkdIKzZ6dWVUYm1hOExyekduQWtWaHQxV3d6bGJWaWMyc1BiWklJbHVCRmdQ?=
 =?utf-8?B?VzFkMmpIcWdPNVNQZFFUVjRXK2FUR2pPdWw3Tm5oQ1pJaStwbVgwdkJmRStl?=
 =?utf-8?B?U1VHS2NZanVQemI3a0traXA3dkZHQmY0ditHcktDY0UvODFGd3hXdXZoV3pS?=
 =?utf-8?B?cGJObjFlTzVsQjh6UHNCMi9oZ1RFZkp3NmdsUWlUZ2dEamQ3dHY1RGJ5bCtB?=
 =?utf-8?B?RXliMkZNSWQ2QVlyVEJaU0JLb3BYYjZWajR2REtlV3FVU0ZVd3hpYmNIQVhi?=
 =?utf-8?B?Zmp3YVpnbnlGeUlPREQwbS9xcWtPNmM4Mks3QUx0STNqM0dVbk1FNmdRNGw2?=
 =?utf-8?B?MTFaUWlzYW9vOFlmNUs5ZTFDcUdtR0ZwWlg2ZVhqQjMrUFZWSkljU2d5cTJC?=
 =?utf-8?B?MW9WNFptMTVXZWxFVStNa2Y3aEFXamdGd1JUMlFQYzU4L0FkNWhPQXhrZGJE?=
 =?utf-8?Q?B5bYe+uMpqg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WWFMTkVlM2JPeFUxTDR5NU05eXIzNENlRW9LOUxaOUNYME93anBvRVc0MjhZ?=
 =?utf-8?B?b0c0WTg3TkVDTnFvWmx1ODNON1ByUWxGREtEclZNa0M3OXJJSUE5TmF4Mm1S?=
 =?utf-8?B?YmpRUE9zRXZMTnN0UWduQVJ6Z0Y5VGwxbkxkSWtxRzF3UHVLUVhGcFFHK3Bu?=
 =?utf-8?B?ZmJlMVJLekllcmZ4ai9VVzJvSkh6Z1M3RGEyMTZaNEp0YzhJbWwxWnBoeXZv?=
 =?utf-8?B?SjJpSC9id1paZXRuTm9mWHMyd0ZxRldUdk8vUnhTanlpQlU5Mzk3MWZ3N01o?=
 =?utf-8?B?ZDRVSG85WGtxcnVaK1I1MExZRWZkeGNEU1VGSnkvbGNhQnMxTEpOd2J0UnpY?=
 =?utf-8?B?S0JHRE9vblNVdE16dmQ2YUhZMTUzYTJBcC9xTDRXVjJDVXBKMHFSV0kxUGY5?=
 =?utf-8?B?VytNcmpwWEJ0azlaRkhZTG40cDgzcitkSk40aGlVTHpJV0EyUERhS1FTWGp5?=
 =?utf-8?B?eHlEMnRhL2I1Y00zdWJYbkpmMEU4cktBTk83c0E0NFlzc3dBS0tJV3RzSHJJ?=
 =?utf-8?B?SUthNWJHZE9PeTAxWVNSR3VEMkVMUGxTaUlFMEtRZFRNSzB6MUordmZFMFhM?=
 =?utf-8?B?VEdRazVEdU94UThLMVRxNjFBZTNGS2xOb2hhUUdOVW9OaXluanp5STZqdzNM?=
 =?utf-8?B?eWQ5MkxFdmR1LzdlSkZCbUJyeFlwaDNRby9TcHFiZjg5dU1wRnNsRXM1K0pR?=
 =?utf-8?B?M0xBUlBFbEx6SjdiY1RzcUp4bmovUnlsODYrWHBwTDk0cUVTUEExSjMzckZO?=
 =?utf-8?B?UVB3UXFzWDNOUEdpWUNTYVRmT25xYktueUNrVFV3dnFzckR0RGUyZmNvYmNp?=
 =?utf-8?B?U2l1VXM2eG1WOStOYUNsQ2ptYzl2MXJCcThRZFF3cTVtK2cvZkR5M0tMcWls?=
 =?utf-8?B?MjIxWm8wUFpwWDd2ZFZCUm9jRE5BdDRHRlFsOWp3SHU5ZU1oZDEvQmQ2SEZK?=
 =?utf-8?B?TnRiUGwrRE1EUUdNUkVTVjUwMmp1Tk5xY3prTzVEcWd1dldySVhSSjBnbHN0?=
 =?utf-8?B?VG9tYXZlUjNRSzJxOXIydkpBcWJCWStNNVJQeE1NbUNLcWgvcGVLbFJ1VHVt?=
 =?utf-8?B?NllETExPZzZid0I5eGRLKy9HRlNkRjZBNDJqLzZ6RnVSS0pJR1d2RmZjY3NQ?=
 =?utf-8?B?d2U2M1BKZC9vK3RaTGNrcEdGeGsrWHQ1UVl6UFQ3YVJIOFJxeUtwSFZmSUlG?=
 =?utf-8?B?eFhLV0tQM1NuS0JUNnp2c1krR1FpN3BiMVo2ZUtUcDVMS0RoMEI1VjU3Vkpn?=
 =?utf-8?B?Y0dtRTcwS1NiRnUxVjU5aFl1bVFRcmx4em1WS3ZyZHUvUmNDQTA1aWhBdFdn?=
 =?utf-8?B?MTlmL2JoNzhLUUV0SzJrQkFuUmNSSFVtRVVEeUlWMnB4UytpU2U3M2Nmci8r?=
 =?utf-8?B?UHVqV1JiSkpmTXlBOTFWMXlmVk1ySmc4bkJ0ZHc0ekN3VXZMUGljMWJlV3Zy?=
 =?utf-8?B?WUdGNTRGVVlyU1dkMTFtbmQ2cXpjSTRwRHVQK01WRmh4bUIrTjE1V1VVRGlC?=
 =?utf-8?B?QzRSa0xCcWJhT29VcnhQVnE0cStlMTgvS1RYUU52QTZTQ0RPeHF3a0VhbFVx?=
 =?utf-8?B?QUNvcC85MmhjZUhidWFHbUVrbDdqSnpzMk9lTm9DdkRtREhHZFZkUHlEaTVW?=
 =?utf-8?B?TEpEdVdTc0FMU0dPUENqT3RONnNBVFUzbFVpdFVYRk9RekdJWG9SQUVFR2po?=
 =?utf-8?B?UEkyQjZaTGtrU2taalBCM096dXpLd0RCejRUZ1RXb1poUkwvaFlHK2FxSHFG?=
 =?utf-8?B?YjhHMUdxbWxRS1lvUVpjTExDYkw4ZDdmVXk0UmFubzZ2QzFzUE5FUVFEYkl1?=
 =?utf-8?B?UUlMb0lnQzdkY0p1WTUxVUJRZUxTTllNZUNLNjcxajdlRXhFNFA2ZG9mYTZa?=
 =?utf-8?B?cSt6Rk9pVm1XMnpCNWxlSUI1a0hiUEtONUdrVkRXc1dyaExvbzh5TzY0U0sr?=
 =?utf-8?B?cHRlbE52dUdyM0wvZEpKRTBHbWJ6TjdXcnRKWUxWUEZNaW5Ha2VkdTF5Umtq?=
 =?utf-8?B?T1RkdkRmdGU1dnZwLzgxVFJ0MGY0Si9MWDcxS1I1ZVhUYjZxS2wxZ1lTQmda?=
 =?utf-8?B?T2NYTGEzQUpScXFFcm1ySzcwV0FBVS9McTBvT203d01UVk9PV0JlR0cyYlI1?=
 =?utf-8?Q?dls6I4cEzRmsZiXcxeQGRvEcZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r4L3bsTRJ8OrfWEmvxDMAiEg9LuQyBVgncqvn/7GEiS+MXLZyZMXi/gSb68Vis9VPRcPIspGllrlEd1Pxq6kSAJArYmxbwcilK/NUaFzXCJZCDjDvyRqqIh/FAmfl5oItMn1dX/IbobWkY6xw1LnCVoSziER/A1v9grz4SLXdasvTp1tpY0tyrTPOzJcQ9cZ17iSFhy0vkcYF5RcIcy6YHKveW2ne8gn5iBmHUZqrooABfa4mnEPNLOrXhAmTBi1/WSK5DzUbws3NYEb/oDEkCbrgp0sFKbCnZtwbz3xiF3n9ytCnkseRc59rilusOiBL5bAEf0MgCf3fwbWHJGYNUGPObqtDqDQfO2X5NdxCmMSeQTEQ1CzJpwvSfQIPJ9ZOye6rcbMnFa3jFtF35f2tILFKW/4T4MAKdzCTkTEpihWyNvQEiBQG6NHr1xo4eGGRU6zz44U4rG38BgUgRhfP8nx6+woGL5ivYtyxjWXjD/s/pQlXk48bCkHkfw2nYkN4DALI7kcXc/FgoFVVocAA8fZIVapa1PST2/gu2WP5otiXvXhun3VYckxYhhMGetRqDqVMNUEuWp8rGqZltFBZGVXQjK1Ow2NodQINgqUQo0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229fe60-b287-454e-e69c-08ddaf3a6f89
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:06:07.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA71+n7DQzVcDV/HaObpLtBlREDuL17SWnHieXfqE5NfFAF13mIY8bI6rlWt/tDJD5kIByhNUJuAWyS3PhlKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExNyBTYWx0ZWRfX0QNY1VgX/a65 /riiEWLldIp0zHG6S3GdgdHPhfakqsIVwzI8BOPsVmtaC8h212yTuq/Z8lmP1g36h1qBOFxGffu fs7cIKy+O29k5FAskMPtqo1ixCVIs8O9AFAPyNYRQJjzb+svjl7DsjKnlS7ekUAZ0Sk6BwFJW8N
 ofRQ9qavTx1Af5LqK+buu5BBnNvelInyG3789UALTgFPFTGi4oASucp86C4k2CNq414WuYPAbC/ RlfqQg3bXfr8Q6YRbk3jlVnhjfZt55s+W5/Vyt3ImyPt/kXmgXsgqR1AuGEpdroj1pjF1CqxeFD HRQ0xbYX8n8slT+R4HxG1RknCrZV6M9TL0toy4ebufU2PLGcvwLRtoy2s8V+CXxYEQL8K+5p+ah
 LM+QFgGgOhgafaQQcSXVTQ6bFSLuCIpjMGP9e8Czy8M+MwiiEqF6cTG8fgufIHiW1GY8dGgc
X-Proofpoint-GUID: ok-OlGTOtDFDSHj8lEWbm5PNV7P5_GUh
X-Proofpoint-ORIG-GUID: ok-OlGTOtDFDSHj8lEWbm5PNV7P5_GUh
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=68541955 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=k4SxcLeuAAAA:8 a=qXSSAHiPE3QvTMHO3b0A:9 a=QEXdDO2ut3YA:10 a=HDvJC8b_tuWYVUZ_Gfx_:22 cc=ntf awl=host:13207

On 6/18/25 5:31 PM, NeilBrown wrote:
> nfsd_mutex is used for two quite different things:
> 1/ it prevents races when start/stoping global resources:
>    the filecache and the v4 state table
> 2/ it prevents races for per-netns config, typically
>    ensure config changes are synchronised w.r.t. server
>    startup/shutdown.
> 
> This patch splits out the first used.  A subsequent patch improves the
> second.
> 
> "nfsd_users" is changed to a kref which is can be taken to delay
> the shutdown of global services.  nfsd_startup_get(), it is succeeds,
> ensure the global services will remain until nfsd_startup_put().
> 
> The new mutex, nfsd_startup_mutex, is only take for startup and
> shutdown.  It is not needed to protect the kref.
> 
> The locking needed by nfsd_file_cache_purge() is now provided internally
> by that function so calls don't need to be concerned.
> 
> This replaces NFSD_FILE_CACHE_UP which is effective just a flag which
> says nfsd_users is non-zero.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/export.c    |  6 ------
>  fs/nfsd/filecache.c | 31 +++++++++++--------------------
>  fs/nfsd/nfsd.h      |  3 +++
>  fs/nfsd/nfssvc.c    | 41 +++++++++++++++++++++++++++--------------
>  4 files changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..1ea3d72ef5c9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -243,13 +243,7 @@ static struct cache_head *expkey_alloc(void)
>  
>  static void expkey_flush(void)
>  {
> -	/*
> -	 * Take the nfsd_mutex here to ensure that the file cache is not
> -	 * destroyed while we're in the middle of flushing.
> -	 */
> -	mutex_lock(&nfsd_mutex);
>  	nfsd_file_cache_purge(current->nsproxy->net_ns);
> -	mutex_unlock(&nfsd_mutex);
>  }
>  
>  static const struct cache_detail svc_expkey_cache_template = {
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e108b6c705b4..0a9116b7530c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -50,8 +50,6 @@
>  
>  #define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
>  
> -#define NFSD_FILE_CACHE_UP		     (0)
> -
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
>  #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
> @@ -70,7 +68,6 @@ struct nfsd_fcache_disposal {
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
>  static struct list_lru			nfsd_file_lru;
> -static unsigned long			nfsd_file_flags;
>  static struct fsnotify_group		*nfsd_file_fsnotify_group;
>  static struct delayed_work		nfsd_filecache_laundrette;
>  static struct rhltable			nfsd_file_rhltable
> @@ -112,9 +109,12 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
>  static void
>  nfsd_file_schedule_laundrette(void)
>  {
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> +	if (nfsd_startup_get()) {
> +		queue_delayed_work(system_unbound_wq,
> +				   &nfsd_filecache_laundrette,
>  				   NFSD_LAUNDRETTE_DELAY);
> +		nfsd_startup_put();
> +	}
>  }
>  
>  static void
> @@ -795,10 +795,6 @@ nfsd_file_cache_init(void)
>  {
>  	int ret;
>  
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
> -		return 0;
> -
>  	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
>  	if (ret)
>  		goto out;
> @@ -853,8 +849,6 @@ nfsd_file_cache_init(void)
>  
>  	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>  out:
> -	if (ret)
> -		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>  	return ret;
>  out_notifier:
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> @@ -958,9 +952,10 @@ nfsd_file_cache_start_net(struct net *net)
>  void
>  nfsd_file_cache_purge(struct net *net)
>  {
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
> +	if (nfsd_startup_get()) {
>  		__nfsd_file_cache_purge(net);
> +		nfsd_startup_put();
> +	}
>  }
>  
>  void
> @@ -975,10 +970,6 @@ nfsd_file_cache_shutdown(void)
>  {
>  	int i;
>  
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_and_clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
> -		return;
> -
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
>  	shrinker_free(nfsd_file_shrinker);
>  	/*
> @@ -1347,8 +1338,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
>  	unsigned long lru = 0, total_age = 0;
>  
>  	/* Serialize with server shutdown */
> -	mutex_lock(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1) {
> +	if (nfsd_startup_get()) {
>  		struct bucket_table *tbl;
>  		struct rhashtable *ht;
>  
> @@ -1360,8 +1350,9 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
>  		tbl = rht_dereference_rcu(ht->tbl, ht);
>  		buckets = tbl->size;
>  		rcu_read_unlock();
> +
> +		nfsd_startup_put();
>  	}
> -	mutex_unlock(&nfsd_mutex);
>  
>  	for_each_possible_cpu(i) {
>  		hits += per_cpu(nfsd_file_cache_hits, i);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1bfd0b4e9af7..8ad9fcc23789 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -80,6 +80,9 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
>  
> +bool nfsd_startup_get(void);
> +void nfsd_startup_put(void);
> +
>  extern const struct seq_operations nfs_exports_op;
>  
>  /*
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 82b0111ac469..b2080e5a71e6 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -270,38 +270,51 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
>  	return 0;
>  }
>  
> -static int nfsd_users = 0;
> +static struct kref nfsd_users = KREF_INIT(0);
> +static DEFINE_MUTEX(nfsd_startup_mutex);
>  
>  static int nfsd_startup_generic(void)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	if (nfsd_users++)
> +	if (kref_get_unless_zero(&nfsd_users))
>  		return 0;
> +	mutex_lock(&nfsd_startup_mutex);
> +	if (kref_get_unless_zero(&nfsd_users))
> +		goto out_unlock;
>  
>  	ret = nfsd_file_cache_init();
>  	if (ret)
> -		goto dec_users;
> +		goto out_unlock;
>  
>  	ret = nfs4_state_start();
>  	if (ret)
>  		goto out_file_cache;
> -	return 0;
> +	kref_init(&nfsd_users);
> +out_unlock:
> +	mutex_unlock(&nfsd_startup_mutex);
> +	return ret;
>  
>  out_file_cache:
>  	nfsd_file_cache_shutdown();
> -dec_users:
> -	nfsd_users--;
> -	return ret;
> +	goto out_unlock;
>  }
>  
> -static void nfsd_shutdown_generic(void)
> +static void nfsd_shutdown_cb(struct kref *kref)
>  {
> -	if (--nfsd_users)
> -		return;
> -
>  	nfs4_state_shutdown();
>  	nfsd_file_cache_shutdown();
> +	mutex_unlock(&nfsd_startup_mutex);
> +}
> +
> +bool nfsd_startup_get(void)
> +{
> +	return kref_get_unless_zero(&nfsd_users);
> +}
> +
> +void nfsd_startup_put(void)
> +{
> +	kref_put_mutex(&nfsd_users, nfsd_shutdown_cb, &nfsd_startup_mutex);
>  }
>  
>  static bool nfsd_needs_lockd(struct nfsd_net *nn)
> @@ -416,7 +429,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  		nn->lockd_up = false;
>  	}
>  out_socks:
> -	nfsd_shutdown_generic();
> +	nfsd_startup_put();
>  	return ret;
>  }
>  
> @@ -443,7 +456,7 @@ static void nfsd_shutdown_net(struct net *net)
>  	percpu_ref_exit(&nn->nfsd_net_ref);
>  
>  	nn->nfsd_net_up = false;
> -	nfsd_shutdown_generic();
> +	nfsd_startup_put();
>  }
>  
>  static DEFINE_SPINLOCK(nfsd_notifier_lock);

[ Adding Cc: chenxiaosong@chenxiaosong.com who seems to be working on a
crasher related to nfsd_users. ]

I like where this is going.

- I'm struggling a little with the names of nfsd_startup_get/put. But I
  don't have a better suggestion. I think we're marking a critical
  section of sorts. pin/unpin maybe?

- Maybe someone has a way to exercise NFSD service startup and shutdown.
  We don't have much testing in this area, upstream. A CI-style "do this
  thing 1000 times while the server is under load" might be good.

-- 
Chuck Lever

