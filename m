Return-Path: <linux-nfs+bounces-13875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5521B32313
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845D7B08165
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484432C1786;
	Fri, 22 Aug 2025 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GV/nGGpG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SKVuqySO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023E26A1B9
	for <linux-nfs@vger.kernel.org>; Fri, 22 Aug 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891800; cv=fail; b=oyRKTdqmDuZmpVrpPr8RcvYBY+vmNzTgHBwNvx4Y+yJJvSCmzRKD3jBN+t9ZI8DmA4Y7MT9JdklMxW6nuu0K+6C5Ccfczji/rT2VcdN0A/aUYCctwkej/4Nw7lb646fyU8Rl/8f8q++lTfBXbswfi/WD8AFEcSPX6FK5Zy6cKx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891800; c=relaxed/simple;
	bh=NUhDAPbCcBQJ6wwaj+Z+MH3tenNZXChfghDnoPO+OWE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bC7A6LXfi5/sbDjMQq61rn+1/ATPbWAWkxlsTY9ofF5WHkBp4GGew1L2tQSTP4tK71HAnUvLTHMZc5wnwo4ZYyYTqaE32FfOGpjH6POXrnKw94CxLX7s6H+Ka/5qsqTmPj1kdLwudOKA+F/7Qus4wqV0RWbMATbjvXQ1l2ENW18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GV/nGGpG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SKVuqySO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MIX1OO022864;
	Fri, 22 Aug 2025 19:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7T1E0StdBKk/5x1d56HfkxZR/oBrP1xo3RnkWJPPztg=; b=
	GV/nGGpGZHwrCjSlDs/+0CI5lqGYSigTwIzBvfqJenPj0X6HOq+UyA1HQC3XQGe/
	80l0cEMatoUu4WZlywRhvQLiav3IytAzWdiW8C6Axe71hOflhr4WuHaWDD6LYG9D
	P2/4+3X/Uc1TqaLza0Syli6/GKroMeIGbCARrgq45V0oU7WHv+nLJ+/0tfxYL5G6
	17cB0kVVOAClmHvcWqB6eZrtUSOia6c7xcMPKpiUCZG2RxG26L6m84InKE1trOdQ
	x8xq5QGnodHbkLaXs6TdDE7vDqgJrsvo4YXlgEsLadZ1z/m7wPzkNfqDB9yevyry
	Jw2VZgPS26HbzmYo8n3qDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pw1dr85j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 19:43:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MIP5Du039665;
	Fri, 22 Aug 2025 19:43:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3trc7r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 19:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjQ+vg3sj9JxODZwlIu1num97rMTR8lmpyhMW+v1xEE+B17oVV74SNcqRcGwLrBa2FJqdGGSZ9lrKyZwjTMVloRHg97e533zvOjjcdL8AiNrHi6Iu/Etufmk5d32vAFyaocoTi45KW9rcD+rMMor28rOgWuLes8226Dop2M3cY10eSTIc3UcDmkQr8fzX1IOvTHlmSVomhEk1igWYc07tfKz0CVVzvt/JT9P+zcCI8x71koX2R2A+0kzE3bv9jqzlHecfgnhyTRWeiKKCkyIlRY2F1TpfBMK/MidULXQW5Y7iVYRmHMrUbDUZsvdq7PnEuUf3aa2RTzjvq1eLNUT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T1E0StdBKk/5x1d56HfkxZR/oBrP1xo3RnkWJPPztg=;
 b=rZ8nODwPyYESFxttKk9FzS+Axjdk/w8/ZwobCzNoGxcvB43txcT7WYt3AqFpN6P9hJIqeLuy12ACNrGF5D5BwT4iDJDcuyYxKVEb/nFLENJMTKUQqSND2Vuem3vwdVu24ofhsc+YWiVdJSrET/tnQ5BvbJY7LXr91NB7wgg7nwe6Ax2M7pRmH/Nr6LP92tAjnXqeBXpzw5IYCCZLngSCAasJbammWuGzNwOTIiIYprjDfzTlGg51at9k3Spl/IBrDN8RMLVN5golg7expidcteCXbtzpk5gh2cvPjLrex3gDb+GHj0cRLmQG8zLoXmhhfyn35wHkXQVhFqZ9YTutxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T1E0StdBKk/5x1d56HfkxZR/oBrP1xo3RnkWJPPztg=;
 b=SKVuqySOf/hX6nLp8Ywr+tkJInjCGz8l5sgyUNHHpuN2M4NPbYWxDUaw8Khiqkc8ay8O3aPhZEi8mUnzMAZHU6OIU/ayw/bsxOnPhuqeKeod1UJak1u3mMukVb/wP9Zkr8F9KH4Aiik9Kl3rQz3zLgcVdL2MIQctNJi1bKWmtbE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 19:43:06 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%2]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 19:43:06 +0000
Message-ID: <b06a4089-d29a-466b-8c3f-5d8a851276e2@oracle.com>
Date: Fri, 22 Aug 2025 15:43:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS4 "COPY" between exports on the same nfsd server?
To: Dan Shelton <dan.f.shelton@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcD3ncfvMnqeQMzQgE=qAD1JjwLYRHpN4mmGd+rS+czLJg@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAAvCNcD3ncfvMnqeQMzQgE=qAD1JjwLYRHpN4mmGd+rS+czLJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::11) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: cba9e14e-4802-42cb-d9e0-08dde1b41d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdRQ0w2Ky9ZY29GUVRHZmU4Uk9GMUJ0RHdSNDFGWS8yMFQ3NWxSVzgrbjZP?=
 =?utf-8?B?ZElpNTZzZWNmUVlLcUFKOWNsbDlXRVVzdWVrZUFCSEJhckpsbGRrZG5Ca3pp?=
 =?utf-8?B?LzR5QTloYjFrenlPSm1QcmJ5SXBSUFlXVHRNOWJWNEsvUlR6ZEV0U0d0WWd3?=
 =?utf-8?B?RVVCNWVqY0NqMXpjZzRHMUNZVXBVaDI2cVhScVpyQ1dVVTQrYURjS3A5WU1a?=
 =?utf-8?B?ZEFXMUNXcGFiOUUvQWZTc05kblM5K1ZWa2FJbHo1a0YxcUswSG1zNERUWW9L?=
 =?utf-8?B?ZjkvNzF5SXI5TVJxcjBPcW1kU2VxVVdTa016SWhtc1VtcGpLcXZwN1VBSHhu?=
 =?utf-8?B?Mld2ZnpVS28xTUdwZFllT0oxTVk2REV1ay9OTGVLdlBhSTh2T1M1SERpcmpT?=
 =?utf-8?B?TS9zb1B3NVFDZ1AwOUpoVW9zR2NrZ21xc0tMMlp3WmxQblp6QVhPc2x1ejFY?=
 =?utf-8?B?bis3S0U0dEkreFR4Zy94ODVrdXFoVCtLRkExYm9FMWtVVXNrUjZSQkJJbFdq?=
 =?utf-8?B?alhobU5JYitvK29ybTNLNUtHRjZZS0hZRjBDenlCWHlCVUNVS1Fiem9md20z?=
 =?utf-8?B?YXNtbkkzRjVBMkpGYTczbnd1ZlBzSzJBREhpN3BiVUcvT1VJaThPeHZhRXdu?=
 =?utf-8?B?VjZoY0o0SkhFeXNGRkhjV3RaZkNQdWozbGIrYUdDeHlZUTlDQUErcTYwb3Bu?=
 =?utf-8?B?RmtRR3BiNUZQZ0RVNzUwM05mdXhPbDJOcmIyOE1sSzk2bHZCMDg1VVBMUkph?=
 =?utf-8?B?dFpoeDFPMVN2VGZlMHNPNnkya0ZqVEJjcUdMSFByTnJsOTRUaVlzS3FMQk94?=
 =?utf-8?B?Nmd1Yk5EOWVxdUllOEJkc0tzbEhFRDUxS3RObTFILzJzODZpWE5Fa0wvTnZi?=
 =?utf-8?B?WWozNEFNNkR1TW50TFhnT0xCaFpTMklOL0l5ZTNKMjJzT0NqMFVsSXhFY0VN?=
 =?utf-8?B?TURGWTIybEVCSnpIQmdGcjhkak9NZFhqcys5RkxReXFMdWtpbE1FZGh3UGlk?=
 =?utf-8?B?U2JFckJjcFFFYjF5TW44Vy8xcTAvTnlOYmZ6MVRoNU5UL3h1ZlJ0b0NRaWND?=
 =?utf-8?B?N0QzdURzUUFzMm5XYnJVdU9ROERKNFlxSjEzZVViRWJiWjFNZHhOaVg2VzZq?=
 =?utf-8?B?bU9MY2NTNlhOYU02dFVEbEJ0NzQyMTNDZXBtWWZYbHlNNW1ZQ3BJRUNORlhY?=
 =?utf-8?B?S0lxOUtxMHJpd2Z2YlRSdHU0MlRDK0NRaTN2bkc2UFZ5Z0FBK1c3bjFROWVN?=
 =?utf-8?B?ZDlMdHJXdDRaL2VlYWdFUmxBTURqeGpUMC9nRzFYWnNNRVAzdGJEbGsyeE5x?=
 =?utf-8?B?NjdzcmhST3JiSWZrbGRpQnlvcjBXZTg4bnRiTzJuUkt4NEtBWjlNWDNLdGhF?=
 =?utf-8?B?NkRFQzl4TDNnb1k2bkwxQTFhZWgrVnRscndWZ21zVHZrWVBaTEtoMm56NmFR?=
 =?utf-8?B?Z0JuRU1BTFJzdnZobkE5S044ZTZIalkwNm9GN2grRmdqcVlyd1F0MTVFL05G?=
 =?utf-8?B?eEttdktVMUlRZjFraDFlb1NwZDNhK0RvNytLNWplOEhvQXZnNy9yYitxa2dl?=
 =?utf-8?B?WmMrWWJDWW1DNmN6UzRXbVhPa240WXpnRUV4S3VsQXJFSVRCVkR2bzRIRUVW?=
 =?utf-8?B?WXFOdjhETUFIM3N3d3AvbjhySzNkUy9IbzdRRS9QUWhZT3M4ZFE0RUs1SHd1?=
 =?utf-8?B?NjlIVnJxeGU1YTNTM21IVG5GV3B5SWVKNGxXbTg3Z2F3YkNjNENndGJnMlVD?=
 =?utf-8?B?RUR3d1dSK0E2bVFwYWkvMXhWc3hkWU83ZVpULzQzMXlOdHJaMHpYdnNqZm5K?=
 =?utf-8?B?Q0o3WjZLdnVucVFKM2xjOUtNQ1R2WHk5cmdGbkkzQU9QcnhsOE5pS2pFUjBy?=
 =?utf-8?B?THBPSUc4VTJzWXhlcllnaTVPSk5KbzFpcDV3QWcxZWtxTFpOTnlxMmxOK09Q?=
 =?utf-8?Q?FX7EYTFU4aE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy94SzNXdFNjR21MTTVHRk1jWmUzTklYTVEveGZmdTljeTdUb0dJQTNmTmpj?=
 =?utf-8?B?SXB1MFB1N000OGY4ekhSeW1Rem5KZzNjN0NPY2FYeGdYNVJDR0F0alh0djVm?=
 =?utf-8?B?VGdmNXpJQjgxY2h2MHREREhHL3JQQ2w2Sk1ENUN3VmprRGN5WmRQeUVKYjZN?=
 =?utf-8?B?S2VOaWphVm90d2ltaGRkVDhLaWpRL0xuUENNa0U0YTJTSEVxZkwxbUlWa21V?=
 =?utf-8?B?WFFCbmdTVFVTTzNqV3NtRENCdHFPaWp3MXdtR2FIY0pUY0FmZlZwV3NKOHoy?=
 =?utf-8?B?OG4zckVSL2lWMWU2ajFLWXo2bms5VDlOaHlPM2dleVA4YmVLM3hnNHpWVkJu?=
 =?utf-8?B?MGV0RCtQVkh3L21KcHJVaHZFVW0vVlpSMGk4RGQ2VFFROUYxQ2xVcW52d2VE?=
 =?utf-8?B?bHI0S241aGZ4RW5Fc0RPSTgvQmVWTWhIQzB1K2hUeFB6KzJNekxVVk10ZFh3?=
 =?utf-8?B?QUVERnozSXpCZEpiRUpVY2tSamtzV3Yzdnkvb3RpR3VCVzZzSWNLSExNQlNw?=
 =?utf-8?B?QWsya1F4VExrNVYxaXVZekxwWloyN3NiSFpBTnlIS0ppclpvaUhGRDVnMEdn?=
 =?utf-8?B?Tk16K0xnbVh2cW9seVhCK3VHM1kwTHduMlQrUElSOTE0a2pQSndDeUNPcTJX?=
 =?utf-8?B?M1owV2drSmQxTC9PR3JJSUtTZEgzZk9nOUd6L3dUQTFBOFpURmhxY3hLUFlQ?=
 =?utf-8?B?dlBjK09MVGdKbjlERGJwZWlHYmlZbU5CUWNBTDB0TG50N3VCWVM2Z2pKd0ts?=
 =?utf-8?B?VDI5bU9TUGN4TkRxV3gxaWZrZjBXV0tXUUFjdmZGVk8yTEFrK3V2aFUxZWpy?=
 =?utf-8?B?QVZmSiswdWdtN0Q3dmJBdW9SYjE5emJFeXNuWDRqbTlQTHh5T254SXZXdDcx?=
 =?utf-8?B?dWN4bUNndmRDUVE0YjlxclpMSGtMOE1RWUF4S2NUeGRRL2x2SHVEa1B5ZlYz?=
 =?utf-8?B?S2MvSTZlWE1hbGxFMHl6NFVTaWpGU29iZnkxR0NtUnNEajlvOWY2amZxekNZ?=
 =?utf-8?B?VHdDUjhPQjRPcXVGbzV5MVNoY1lKTTVRZ1dUWjNLR2hKVW4wYnYwSXY1ZndT?=
 =?utf-8?B?UWZXVThrdzU5UGc1OUt5RFhOaW10WXNjTU0yTkx0eTBFYi9mdFA3a2lGcWgx?=
 =?utf-8?B?Y1doUVNkd2hEZU9wUXZpa3ZWSGxKd2o0SWxaVW1TY2pwOWRyZ0lDT3FZazlH?=
 =?utf-8?B?SWJ1VXBwMDIzSFl0RWc0aEJsU05QRWdsQkxYUTVaQU1CWWZNRCtMdTZEQzBr?=
 =?utf-8?B?WlVLQzNxdUJycVRPa3ZGS3ZYeGQzMmViV1IycE5tVWdMQ1hDcnd6cmVScmhH?=
 =?utf-8?B?b2ZxYWlLeFB2NmFMNHhZR3dRaDRkN2lEaStvVitGazA4UjJzRjhmQjdicGo5?=
 =?utf-8?B?WnpEYzRCTmlaYmc5bFN3bEJqeUp1QTU0eTVaUVRPc2pIMmVlRlFOSXNsTTdU?=
 =?utf-8?B?OTdFdEN3b1VpT2lWNlk2RmlZQlNZRGFzcStxZUpOWWJVMjFqSVlRdUdNZkJR?=
 =?utf-8?B?NHNnOFoyeXk5dnlOS1ZOc2FSbEdJTittMFRmemc1eHZhdmN0Q3lwVzdxZjFj?=
 =?utf-8?B?dVFjQm01VEw2SjgzbkY1ZXBkOXRubjMzNlJjbVBZMEZ1U05oTzFTWitNdFU2?=
 =?utf-8?B?VDB3c1A0aHNkTG1mV2lPcnBNQmUwS25oK1p0NmQ4ZU95Z2g4cVRhaEVvVEti?=
 =?utf-8?B?M2lmYVhFbmR5Q0NKVTVuMCtOWlhZcHBvVklmVVIrS01CaU85RUowTjJEakJ1?=
 =?utf-8?B?S3FIenB1ZWxBMmhJeDUyc3pPaW5tN05lTDluV0d0eG9xSVFNZjh2bCtSK3Vq?=
 =?utf-8?B?MENxM1lna0cwSk1KekNQZVpUamM3VjRHd3lVVmh0dk5BblIzdy8wWFpTeXJZ?=
 =?utf-8?B?UG1SU08xZ3d2RDlubU5WblRTQ2FzZ3JRNWliNWd6NS80WENqd3l6QkN1ZGhh?=
 =?utf-8?B?Q2lLV1dwZWJBZ25RaXlGVWJoTUdFcGdROU9CZWRSTHN4L1oxZ2VKSDIvWUZP?=
 =?utf-8?B?QXBReW54TmgwVEdiazB2clhwbEl5by8zOE1Kc2pvcTJYeUtwdkVQNXQrOEhq?=
 =?utf-8?B?U0hjQW0xVUV5bDU1cm1nUnVhczdNaGk5MVVFVXIvKzJYWW9pSHF6RkgvbVRM?=
 =?utf-8?B?alRRVkpEdTUyWkJXN3JwQ1c5dXkwUDhtYVNsSyt4cENVRTNQb1F6MWlpcVNS?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E5KU+E5qGBYMdQxuu5XHtomkBFDv+pld+dIz+CoEMu79gVl9QbOAnOxQGxwi7DLFnYDOsHb9iHNGcp9+UMlKLBxvJWQC3ed6DuxG7Xpn35RLF2zSDdjc6muY06RY68fguUe6nuSmD2IKLEHULI1aeWJZf0h14zCcv2IqzUSyip5vfnxtWrSGYWX+kbvvrsc4S1vAnj1IUIJ+1CRUa1PAIPXFjWRAbab9kuS56NzS3zf+a7Khxc/9sV9W66BK367M+OCvNQZTziLorTAU4u58nHb9bOnmgUZudf21imf8DVo52OAVDwnybxfOtEFUlqJjoUN9dsaRGASE7YY8aAHoJVUETFRRkSWDruN3wu2tqs1Zzy1QVTug6ihObNdsq1X2xmHEHzhdX/fEVVqOBodGhzpuHjbtFSzqL9RMLNZmJWZ+suUf2AYYmlF4MdaRTZ1JIkntgsx2ERrHf+ofXVS3YPkKB8HDUnx+bbA1Ly57ZFiIAyJxYHWKAsi0O93+ol8f2bvvWqExn4lMruNoaRB0dYjf6+g3IzG/KxblDeG0dj4brPL1gQzMreabXXTHT7UniLrT6IM7XZ9ajT4t4fuuqoBg6pqAa1cMFOVSWjb/0iA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba9e14e-4802-42cb-d9e0-08dde1b41d3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:43:06.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47CVzj466Njcr7F9VQFII4hfu+213FORTwVpHgY5WP6TjGAtuzWLXurKTH2DPRImX+LS0fsXj3nkTbrlPJ8zGcadB4XuxNBF5rbw365AP5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220182
X-Authority-Analysis: v=2.4 cv=OIAn3TaB c=1 sm=1 tr=0 ts=68a8c853 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yxiRptK-3s10A_3dQh0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: D6qFhPpGG41sGdN8y-cHdgwP2Y2pQuwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX/xLur4X+MCFh
 cjiMDoCMYRWBSqE3ePnQwBtcqhNC+VaJ3ynJo/Ee9X76wS8PReHSRl3UQoVZlxe7IsRzr9EuJ5c
 GQ/iPet0AN/jcHSssbbrYkoKoe5XSrUn6j1hBdg4lh7gnTrgZXP8A1mYMBb1YneF+e9WET3aQti
 l8lxpgnp4gV4vXv8z4nhTMuAqgRHDTsgjYRbeHplk2rh3Kyy5LdwW46v3Gj10Bv9The5HeEHwFI
 6jT+5nvrcrbRxuhmZxCyaAM+e3cC+mvJEwIel6nGcar+N4AexIWdvG1FJBiOewgWbIWT/jdtLwN
 qkSMPjvya1PH5tYxArH2CelNhon9hT6C6E4E5YTL+veU3LAtk0pb0xJ9RDaibGTSrRHpnuuD4DK
 +iDlspAe
X-Proofpoint-GUID: D6qFhPpGG41sGdN8y-cHdgwP2Y2pQuwk

Hi Dan,

On 8/21/25 7:12 PM, Dan Shelton wrote:
> Hello!
> 
> 2 questions about NFS4 "COPY":
> 
> 1. Does the Linux nfsd require a special setup to allow NFS4 "COPY"
> between filesystem exports of the same nfsd, or will that "just work"
> out of the box?

This should just work out of the box.

> 
> 2. If a NFS4 client does a "COPY" between exports of the same nfsd, is
> it sufficient just to have the stateid of src file and dest file?

It should be, yes. I did a quick test using the Linux client to Linux server,
and see that's exactly what the client sends the server.

I hope this helps,
Anna

> 
> Dan


