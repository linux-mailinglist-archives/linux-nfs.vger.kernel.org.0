Return-Path: <linux-nfs+bounces-8944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A0A043CA
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0113A1758
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D781F1905;
	Tue,  7 Jan 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAinJ31A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dIunKDks"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BA1F2C5F
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262655; cv=fail; b=tyWYbX828I9MIBiDkXOAb5ityI+o6ZrA4tWeZBOkGxIDaW3S8TdPVYewJUsr+hagA9D4x//03ttsUs9ieWsgjJxniJ6s9zlwyQwIHpqY6IN3bLSmNbwZ1j6CAcHjwn5I1AmJTDHZsNrHMC3AcI89tlRmpu4ClLELuYZ6iZgQp1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262655; c=relaxed/simple;
	bh=UAVHRygF41ZRV5jRdCSh3gIHM9rB8dHh1bm20P/oXQ4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tncqcw49r25yH+P2yZUf/FmA40ePXYvkoMlO6prVPL3iiQsMBbvls69S14yaouOVqKTyJgm2LUQq9rKeL2zAwyHzh+6EcSPM4SX5A0K91aq2R9HlmGXhQw/ej4JZDlNwsWsA8kdlugrLDgsbAm9UIFecGzTsxQq2OLIzyFNrvOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAinJ31A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dIunKDks; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EtsTY026725;
	Tue, 7 Jan 2025 15:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l16zize8DRBNtEIpbYF86T6KIbTGLlvi0jmNTPQM390=; b=
	VAinJ31AKae7J7vp88lcFMtgXq1Hvojs2DrwtsrT5XQd4A3JukwLwsmUyo/AlhiG
	ckKJ1Hnh6iXXueEHj5y83kQnHc3Dm07S4+1VC3yj6sA7QUrQ4aJxjDLipzMePlts
	FojxiOzZ+g0BTmLT6mR+tItz9VaEJLwI4QBM2PucRJ9GnyiF/1P0Cn/gFQGPm6vy
	9pvS7f9QIJqwNQRQRvfkmHGQ8E0RaeMGsjWuIHQzbcZam2kBds+5R2L45PPV/WYL
	SjoUj+/NrIJ+FdOIddxuQXxfVw0ZbCr81wuhYXQ0CaJ1lZOydu84tPpRGsQNhteV
	1ckpjAcKYyvsAHeRlGb4dQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvv94msf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 15:10:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507EfmMq022684;
	Tue, 7 Jan 2025 15:10:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue8kfr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 15:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyXxPQVK2YE0yLyP5Dq0IFFXeJ3h1uferui7Daz2rAjy61g73u+2EagvJrD1cGopU4fIzeo/dsO3rzaNYNmEA9NWZVU0v45ZGK/YruVIYf8yGmMS9tyq3zs1TKg0Z0vWn1PwNnUU6wASKPgFnKSo09ZHFIYO5rQbmxylmfgFXnpSQXD/SATnjaA7JG5d9J4HMhVqYxMmICevRZIx5xjRW1fyIoU4OvezU0HDafE1NZryftQK89W5cbb9Mscp4BwswiwACm1TQ4Q+u/xbP75p/zdXxaIW9AScGoeOhqXCZ0vNcRBNWo/69/j9xCdSk9yOe1lo/NdFCl4pUkxs30xE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l16zize8DRBNtEIpbYF86T6KIbTGLlvi0jmNTPQM390=;
 b=EwIWCPQQR2RjhebWC/L3/cNeTUbWD3tZwU48UWvWjo1m2RbBEN+5ya+yltS798QJhDpzQmBp00ahRF6+vGaRCxCvalINq3cupwrRt6l/52nkifdESvDgv8RRyBcTw8tde+KlHqSloAhQgK6xdbx1g1tKNODxulu3YTCxb7QyF65cGSmuE8+Syj0agCozleGLmwiKp6WpMy7f1HGpnFkQR1JQZZO+Lq3xmyiuS7up34BxOvZ8iAWPlle4Mt6/gjzUdBqsbJLrMq7zaPMpMG0EZS3rNcMYqChJcsnwk7slJAvI2P5NIMJvsXxpFnNVKZY+XKp1LCU+Zw3+/aEkaM0//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l16zize8DRBNtEIpbYF86T6KIbTGLlvi0jmNTPQM390=;
 b=dIunKDksm040m0z9uzHvfi5Ayk+uBD+WGUfHbQe48H9A6caN/Z0LB3Fg2CTeMZAeuQ6+8vsXDA1A40TVhUm702TyubbnCdvR6+5OeZDF4xcTy9US/IgTVjmeeXKuCn546gYJ3X09qQ49LIdN7e94bmYS81qS32YmpqpqhZ5l2Jw=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 15:10:40 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 15:10:40 +0000
Message-ID: <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
Date: Tue, 7 Jan 2025 10:10:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:610:119::28) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ecc13b-fefa-4ae5-fecd-08dd2f2d729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmRCcFRmRC9abTdQVkUxWVVHdm0wazYxZm5Pd1hvRE9YRHpDejA2eTZNb0Nx?=
 =?utf-8?B?VE8xUG01akNKMEpsUUplSTlYWmlzeGVqSGVYQ3VWU0RmSEF3L3JSd0pkNDZC?=
 =?utf-8?B?L2VUcnZtekluc0VWOG9sVkpXNEo0UnozTDROT3FuVVNQVkVYRG1jbnkvaEM5?=
 =?utf-8?B?NVoyMXlTL3FyUHc5alMvZXZnajBocVBYN0gwUjRyVHFjSWhaWGZlMGdDTW5l?=
 =?utf-8?B?dmlSQWVPTi84WlFtTTBXSU1pbU5hL25FMThCZFVKTkQ0QmtkWFJFY2t3bTdh?=
 =?utf-8?B?Mm1yRmt0ZlRqMlplUkFqemxla2VCUm1IaUtUcG52VDhFYUVhNXNLakpUdUd1?=
 =?utf-8?B?U09VUVo1NzVCUkUvWmZEbTJXYS9yaGFhNm9WNzAzK212aldZU3ZLL3BYT3dx?=
 =?utf-8?B?ZHJxL0h5L01jUndwYXM2Zis0ZExSb1ExZis5cDlnOTRJSWo5YjRWZ1VGU0Nz?=
 =?utf-8?B?cSs0WHZ5eXY2ZnBucFAyUzFFWTBHc1BFV3g0UGJFcDQrUkFLZDVRZjlqaGxI?=
 =?utf-8?B?clNnZWNKWE5lczFYYTBTaStLK3IycDBuUDdGdkF6eHU4SkM5YWNZaDdSdkk0?=
 =?utf-8?B?S2c5WGpMaHBMYm1RcEI2bEFhNG1JYVc0OUFRaWhEQU03S2ZnK0NzczA5eWVB?=
 =?utf-8?B?bHlVRUFJMEhYMTdqeVJ0eGhBZUtMYWRZaUhUS1lYZzM4amRGc1JTa213U0Vo?=
 =?utf-8?B?M2dUaDUydHVWd0p5clV0Q24vMG1wV0M1ZVRxZllqanJZaGltWHdIcWtoOVNC?=
 =?utf-8?B?d0xUcVdFdGY5RjZrVWNSSGdVS25UMWhvUGNGNzUvQ3Y4ZmtZbmFpbmxacXNB?=
 =?utf-8?B?QjR5Rm5RSmFaRUZGRDZKd0JOTkQ1SFdPZTBsdmphS0pGMVc3bEc3andzRjJP?=
 =?utf-8?B?WG84UFNONnJRKzNLN3ZCYkpxMG95enp1TVZzT1l3a3AzV2pzWWczR2k2ZHZZ?=
 =?utf-8?B?UE1iaHEydFNCQ3hEbDlKV3lNYUt6c0M5WEtIeTM3bTlvRStrUE1INEJVTzJo?=
 =?utf-8?B?UnN6M0ZPdlNsSGhuVldSMHNabjZ0b0ZCZGxvU2VGVGx2VksyV04zbkdVcG5t?=
 =?utf-8?B?ZzYyQnZSSlRTMkc1dS9RRHVQcEExVm9RYlRLUXBmN1JUak9URTQ2bDZlNGxV?=
 =?utf-8?B?UndKRzVlQWtoME5LNzVLT0h4YmQwdEtoMzUzZ1E3bmNWbUtVVWVkUWxDcmlQ?=
 =?utf-8?B?Q2QwWEc1SWJiOU5QVUYwTkt4eDNvOUpIQTZicldHQU1CajQybTQyNG96Vk5p?=
 =?utf-8?B?K21xazREdzJ3MDlMaDN5b3hFY1F2ZDhBdUNEOHJJQWxTbDdudkhEdkg0RGVa?=
 =?utf-8?B?U3dlMDVxOUk4STRTTzMybWNoSUFSM1dsdUk4TTQ5YmhRa3NYR2lYRkMyNHRF?=
 =?utf-8?B?ZjRMb0p6dnpqVGdhMHh3SDRUeENMMjZHVUR6ZHVjMVJoRUgrWmZiZUcwMXlB?=
 =?utf-8?B?WHg3RHNKa0NRMWhldFhiOFVUNGJWTWhrZHBqaVgwTUF0Qmd1S21lMjBvZXY5?=
 =?utf-8?B?U2VZelMzZEMvRzduOVdsRDd5b2trSHRxb0RjcWp5M0Z4YVc4ZmNwSGRnUHZC?=
 =?utf-8?B?SDVXd1ptcElqaWJCYkRjTWFETnVKNWh6UkRPdzEwRnpVTVJDdnllS2JuZnF0?=
 =?utf-8?B?ZE1aWjR2YzVHV1JrVGsvNXpENnZoMEhFMmdzblRzVzlDK2x0N2NjK0lNeFZh?=
 =?utf-8?B?SXJhbWdOUHhZSFEyUzhFbGphTWxuVmxwV1piTXZWUnQ5azlrOTJzMVU1amVX?=
 =?utf-8?B?ZG5uM3Q5UU0vV3pIYVRDNnVSMFgyODd5cGVNemlPL1dFK3cycE4yN29sbGR4?=
 =?utf-8?B?ZUtiNy9Jb0s2YWF5YjltNzVUYlhxWVI2d1h6M0xmSEJLdXM1cTRWZU90bi9H?=
 =?utf-8?Q?CIzerHRxefSXA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjB5cFV3SUZLSk1TU1pqZ01SN2RGNE9rUzN2dDd0di9LcElYdHRwcE5oWkRn?=
 =?utf-8?B?amw3Z0RpSDNzcEdqcnFLNEJWaGVxWHJXSXpTZE5LbWt5SlR4eHNNbFFPTnFh?=
 =?utf-8?B?L0NRN3ZlT2JJaVNSc2ZPd1E4bUpiSlNTUllzazZiRmN6eCs0dTI3Nk5JZjJP?=
 =?utf-8?B?RUI5M2hsc3JMY3lzWmFoRU1kVFFoMWJwaGJkdXJ1UVJ4cWQ4akRQNks5T281?=
 =?utf-8?B?dllzdjltaDc5OUdMKzQwM2xJNzVCNktTSHNwOGRJamNFcVI3UzVzL1o3dTlW?=
 =?utf-8?B?LzJJMmFVdWZRVllsTTZ0NU1XeHpwSXJQU3lPTDhuY3gyNlZlajRNQ1pxQi84?=
 =?utf-8?B?TkEwb0prVGtLa2dub1hWOTkwL3JGejBWUWp3OGVpMGMzbWdQRmx5WWhHclha?=
 =?utf-8?B?WXQ2cXJRRVoyOGEzOUI2ZUpUM2ZERzljNzduL1ZnbWxJZkw1cjg2WmVKTUhP?=
 =?utf-8?B?M1dLcXJ0OGh4eFE3U1dKYUtHSk5LQVk4MU9GS1FKNHE5WFl0engwN1pRcG9D?=
 =?utf-8?B?eU5XY29NYUxCVDNUbSsxZ29LcHdHVHhhcmsxdWhQSGtYK0s0ZmVBVXRjKytL?=
 =?utf-8?B?ZWdDRDczWVMxVjFoYlpib1ZnT0ExaTlxZVB0cjlmM1pVbU5KQkVPeFlNY2ZC?=
 =?utf-8?B?UlFlVXNuNlpKZ0ZjbU11MEdqejJUNWRTREZ0d1I1Ry9GTDdHRFZzV0NDWkFz?=
 =?utf-8?B?M3F4NzhkNDY0WkJMNTRLNEpsOC9YL0VJOTQzMU1Nd05qemFQNUMyUnBvbFFk?=
 =?utf-8?B?OWRrSjJadXNaTHRFbGtON291a3loZ2dRM1F4WTA3dnJFZWxKb1FqUE5MNWpN?=
 =?utf-8?B?VUhzVGMyL2lLd0MyNm1qOXpVb2tEUTRvNjMrSHVnT2pqdWJBMm1ubDJVUUNI?=
 =?utf-8?B?Q2RGZG1OMXdVZzFzZlBPUEtUZmpIb0loWFcxVzNvbmRHYzBkUis5QVloanRk?=
 =?utf-8?B?LzdHY0N0d280bUpmdC9aUjZTSjlPYkdWM0ZHU1phNUlPZ3VYRU5EQ09lc1Av?=
 =?utf-8?B?RUU2Qk0zaEp6TDB4eXV4dlkreUUvUU1TbVpIalZ1Qi9wQUtmeHpDNHdQMmlo?=
 =?utf-8?B?MFFjMmZPblNNTHhDWHFiaUxCUTcwc1ZEUVl1WjJYQ2VwVXRFNVg3bmJ2Wjdq?=
 =?utf-8?B?UzNDY01iODZFNWFIK2MvNU5ycEhUMkNmSlhEWXdHYjhKTGhyd3FUODFEcDBh?=
 =?utf-8?B?YThycTIwNEJIZEcrcjhXTVQxVXg4RC8zbFprc2dDb09ValI4SzVBM0hnS0Zw?=
 =?utf-8?B?Zy90LzhQSmxXU0JldzAwRmwwNS9HcFFxV3ZBMkZDZ3prQW1vVHFaZDJpSTln?=
 =?utf-8?B?NjVLdnFINTB2c0FjbkxYY3J3WElYcS9Id1NWaG91djZ4NE5ZQVVOZ2VrRDB1?=
 =?utf-8?B?eUs1K1NBSytkRjloajVjcmpDU2Z0b0FTMHo3ZlpCdlFmY2p6UHVBN2FqakYy?=
 =?utf-8?B?T0NCL1BVK3pQV2tIWm5hT2FraFR4S0xIdTFZMmtKVC9uTmI1Njl0WXhYU2Np?=
 =?utf-8?B?N3BKQm5ac29nbHQvOGVFNTVVQ3pseFZEVEZQZnFiLzdoSllyS0hMNmxFWGJq?=
 =?utf-8?B?Y1ZVdVNPNHdnL0JzY0wvdEg1ZmF0UkpxeFRISVpTcU5FOExhVDNmK1dtbzc1?=
 =?utf-8?B?ZmlleGtOc2I3Mm9JbE9pRE16Mk55TzdhWmE3cS9wM1ZWaVBUSUVUcXoyTnI1?=
 =?utf-8?B?T3Z0dklXWlNQeXFRTElCMThjcllnWG5zemRGcTZoN0trSDlpNDcxeW03NzM0?=
 =?utf-8?B?ZklWQ0g2ajdNODdrejRUV09YTGhYekRITTEyVUxDZWlzcEl6WUxLdTlRZi9L?=
 =?utf-8?B?cWwwL1NHYjZyaEg2MkorVFJ5RXViWS9EaGx3QUptMDgwTVpFb1BSL3BTT01K?=
 =?utf-8?B?Mk1sODd5MGgyVVZkdGZTbEtRUklxd3ZWcVhKWlVqVjR5VzR3b2Vtb3gxYnpP?=
 =?utf-8?B?TEFWMEJKR2FPTm8rT25OMHQrS0Q2TkhiUGVZU2d3SVNTZ2wwbnIyWXIyUWN4?=
 =?utf-8?B?aTA4SzI3VWsrSitrejFrYmlWSjZXNGpRM3BEam1KYkkvVm9mcUZ6c2x1bWYw?=
 =?utf-8?B?S0xGMnRFSHNOc0NEak4xL1pqOUVwTjJMQjRWL1JORFg4eGtWK0k4cXpyOHB2?=
 =?utf-8?B?eTBKb1NGcERyU2d4R2UyYUhaeE5HdXMrNzU4S2NpQmZGZkVnMHd0ZkRnK1BW?=
 =?utf-8?B?WStRZVJMUlU0eWJVcERqcnBrQlNEeXk0bDNheENtV21jNmpzeit1Umd4NTZ5?=
 =?utf-8?B?UUJVekcwVGpGR3BiT2N5cDUwaTVnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PRwGOLyM5B5pvsNTmMlhn8KfQj4DRjikXEr+P6bYbt2dpSwh0X0+zb+zld0GfdFP+qYyOu54aQQZkopeo74TaR8eON7o26P+Pn7iayfWQpKNJxO0BcTXqHjokZMmYxfssXGsvx9PFCJ3xCBcZPTj4vjOws2d0A0QqujKTZebwZ5qEw/mtghzDvHp+rshuUjBsRTNFmjESlTiNY2ikvEZ1qf2xSrDAgEGLg5dTZV07dh+QfH4POXVG2TW70S+/RaPQckgULt4DayaJTswIwDsbm5FemHYfN71GPOK3NvREgh4c21yL+ZWb+HBbABdCOT40qvpjIHRjXnpHQ/fot2/BRBsvbtqMs5ZyTPww9ds42iIiJildcJuNbjkVjsPv4VCSgCducRXmA1keTEmpSllrOieBK05XTzVLA3wM+rut+H/qWztE4QLP0+xVqhLOeGU6kw4WjEXsxJ+5SVFvdchSfg7CaF8AEmxyVCK+J/PRPhppvWJnoEIXXJXTBeijrrnuV5DzA3BQ+0QRC29IaXUoXGYX3ij1ynbTcopaQEBy9o2pAUTuGvu2lHsM5m9ByaTzxev6Xs168Qsgl/agttMzZgR2gShuLEPrPesN/oAt+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ecc13b-fefa-4ae5-fecd-08dd2f2d729a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:10:40.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sYSKFED+OPwG9hVHQJsfOdJo6f+1byiA2QRRQ58ELB4u096Sz/jcNfU3R9LJc21sLbPL0GUPieLqrJmVS9+47eTGT3Gl972Cqaw6xttphw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070127
X-Proofpoint-GUID: w9tpSs0a2_BFftrXAdMf0WjwWtCmXXi1
X-Proofpoint-ORIG-GUID: w9tpSs0a2_BFftrXAdMf0WjwWtCmXXi1

Hi Takeshi,

On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
> Dear list,
> 
> how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
> ioct() in Linux nfsd client to use it?

Thanks for the request! Just so you're aware of the process, this email list is for upstream Linux kernel development. If we decide to go ahead with adding WRITE_SAME support it'll be up to Debian later to enable it (that part is out of our hands, and isn't up to us).

> 
> We have a set of custom "big data" applications which could greatly
> benefit from such an acceleration ABI, both for implementing "zero
> data" (fill blocks with 0 bytes), and fill blocks with identical data
> patterns, without sending the same pattern over and over again over
> the network wire.

Having said that, I'm not opposed to implementing WRITE_SAME. I wonder if we could somehow use it to build support for fallocate's FALLOC_FL_ZERO_RANGE flag at the same time.

I'm also wondering if there would be any advantage to local filesystems if this were to be implemented as a generic system call, rather than as an NFS-specific ioctl(), since some storage devices have a WRITE_SAME operation that could be used for acceleration. But I haven't convinced myself either way yet.

Thanks,
Anna

