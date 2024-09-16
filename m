Return-Path: <linux-nfs+bounces-6521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84B97A7E6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE141C22825
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72191607B2;
	Mon, 16 Sep 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OEut4PUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IbliAAau"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFC15DBB6
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515914; cv=fail; b=nmc27+1i0XDeCVDupFa/hY3KSMOPsDvc4QCRBUI9X9Zovrne0vjMVgY9ZOdBwR1U+S3eIqP1gn9h/2gXIL30U4azknvE7/VWcGmVSULxZMNZLGpqiLzOzwStHQcJLPwvSnpfAoIFqcpEMi9c0x+GYV+jiCz2C8Qg3sMiaJ8lt7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515914; c=relaxed/simple;
	bh=PSMaeUcXfHRbzO6cJgLD81nIW5ffPpYXYj0LTvWW2e4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XIBRTPvkWqmhLsZgCJzWepJ6oI+a/lerjhdSEzHAgfX8Yi6/VOgzMU/t3JUdXhzXqhN6IDwmaI48H1pmUbjBI67u1jlgKhhamGI8mjdYcKJZbaj2b7XyaNpUjRyeA6ByjVBUxzs+Ux3BKkkPEt6Lp9Ieln729o0/nZPE/MiwMwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEut4PUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IbliAAau; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GJM623006643;
	Mon, 16 Sep 2024 19:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=e+UJLJ3ZOl4MA5J/MHW0BqSmkcU3iu6pIaXcJZNJjg4=; b=
	OEut4PUCZZ2jilWaeifGYTwTrdVH9GdYipaI5WtCje1koJCPKu9miT601PEDDkxm
	972JVRbNi4dVg1KRF6SMafmtldtuAoEbgjc7KtoD7WQA0eohY+LaMDAUsARaEGLC
	XGZt4jG6arM0XhRVNZTtvO7pd++zg070e24hab0WEY6aby8SxWUibxUDR0F+jPu4
	/nComeOrPbFWb/ORrY5x9YRIDLZQ/IOQxeiD9kEy2nmn9YoiA7msg53WobmLSazC
	apVNUuPj7xfoLDZAQ9aNYcV6krqOk/E976H0cL2kkS1jxzwpmXK0JDK/BKp08AIs
	oHhgNook2e29A7+GYyKrKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rwva9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 19:44:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIhRG0010450;
	Mon, 16 Sep 2024 19:44:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb61kap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 19:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzSVBWoCqhpIG3f/Lr+3omyAg9mg+dbdhFQkfu9hUNt2OwayUAUQMW/rMT8SugqYqXLQpElN3/X/6RQM1+kbNYh3jvnVaDPNs/1/mmjx6zJJrUtNAHShlDxsRYsz2B00BF0uZmPaFCW9PckhnGn7lky5/7YCLfK1yuvVfxlyR/In8JyyAHofGTj8lJ7JgZO3FHBrcZWW5m+Df/6e2ta/7w8MXLWrQ8ow7QwZRduCxiGKpemg/cPLoclUJFK/wZKMnL4NNV1F4c2bvlmu0aLsYR9HPD7djxTQY5x2sa7u9OvxQmWWeCQdVAKvsdDBrc2VfmbFAhFViX07QClr/xqT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+UJLJ3ZOl4MA5J/MHW0BqSmkcU3iu6pIaXcJZNJjg4=;
 b=waa/fImkCCGlGyFMzlRb+C00RWGjiTaNf44wYNe2IkWjy6CK+5qUAG6YQQbnOaJHnYt6FgYvcde7eTHuost1VQ+S++1kG8WLB0UM4f04a1rYmyR/J2BFcDkzmz4Y6QsjDl/oXxpc14EsVEYxEg53vUb4l6oJf9VCMovuBmQbHaiCjwHGeqOz4m8cWsaRlo4qpE8+AfT5DPMMAubXOHTVC0qSK1zbtmNisl6Cp/z6Ktndxa/f9GxZhO9e4ZhJKn4irS7sqe5lFbOLefdK86uSR/UlxQZY281cZbZlhn2+MR2AR94gLG5LoIrICQKtIQ4i24dgJ3K5rVBLzQhCQk87PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+UJLJ3ZOl4MA5J/MHW0BqSmkcU3iu6pIaXcJZNJjg4=;
 b=IbliAAauM5QTW8jWcHzMWnLaGASGciAnFee9mWEelV9JroqkoETOzty5Bt3p7sMqRf2BmbbF56Ucifv8G8AM1DUPij1A/+oFB7yYsiEt/f96OaiFEklzF2twxhsTBcwx7N6zCo9hJZEgmkXe86t4QhEFsQGPWFJxMGSXhqnNxEw=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by SJ0PR10MB5616.namprd10.prod.outlook.com (2603:10b6:a03:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 19:44:55 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.7982.011; Mon, 16 Sep 2024
 19:44:55 +0000
Message-ID: <7206ed18-0e5b-4306-b451-e7eecde71d9f@oracle.com>
Date: Mon, 16 Sep 2024 15:44:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:610:e4::8) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|SJ0PR10MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: ef567362-2d52-40a7-e2b8-08dcd6880a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WThja28xSGRGMkVPRDJtSlhmV245V1dyaVRPRFptQnllZDJiQm13MFZFQXM3?=
 =?utf-8?B?YVN5R2V5cGp5N0ova0Y2UHQ4MGZ4c3NWRXdJVWJqZ0RsZHNINmY2QWs2MVgv?=
 =?utf-8?B?eG5Ea3N3Y25OUEt0UiswSWRnaXNpODB5MlF6M0F5Y1Jjc2o5MmJSenhORC9s?=
 =?utf-8?B?ZDFNenQ4cncrN0JZWG9XWkx5Nk9UYmd3Vlpla2RQRFJtSnBEUjBadHUwL3pP?=
 =?utf-8?B?VFFha1NjYnhYNldra0N4U1pWaUZmUHFDOHBiNUdhdDR1OTMwTGYrSXNDM3lR?=
 =?utf-8?B?K09sNU14UWlrU2x0QWdOUVZ6WlF5K3ozSEdMcXZ1bmNzbEtDQUt6S1dFd1lW?=
 =?utf-8?B?bEkwSC9lNE03ckNqQzFuUzlGaUFsbENLRW83VDJBdmNSZTRhYXZFNUhOOHNq?=
 =?utf-8?B?aGk0WEVWUHNtUjZWaHdMODZ0V3lpVlNiTjA3WFJaWE80Yk1vRHg5WklxQzMr?=
 =?utf-8?B?YTlXVi96Q3JlZm9tM1FmZ3Q1Z3d3ajg3bnJOSENCSG1jL001bkxQcXQ4TkQ4?=
 =?utf-8?B?bjgyT0pJNytiUEZDRUw1UGg0OGVnY1pLeG1zN2F2YXFYRE9zYlJOVWl1a09G?=
 =?utf-8?B?bFdMa3dCMXJsMUlVbW1zSEhuTng4N0d4ZWZPQ2ViRHEwYzJRWWIxcU1vUXBR?=
 =?utf-8?B?a1R4YmlzeEtHVU00bTg3NUw3QWt2b0xrZ1FwUkd3Z1FvY1l2MDV3Si9MY01i?=
 =?utf-8?B?Q3Q0RjAwbG81aGxYdC83c1ozNVpCbXlQTHB6cFNZOXY1czFmVjl3WFJYZDhF?=
 =?utf-8?B?ZVpBYW5jM3lOdmtwV1BNdnhsbVV3Sjg1dXQ2RkMyMVJrSmxjdFNmSXdFb3dY?=
 =?utf-8?B?bFhPeXUzR2M4b09jYkVXVitxTGtrckdzVmJRZ1BYVnpONk0wKzhJb2Nrb1dt?=
 =?utf-8?B?YjJZWGlwUnVrTmRSNlBsNDU2eWEzVWdBcXdvSHJTd1RMNkNsWVAyU3E2aWNw?=
 =?utf-8?B?SzNWMDFyZStEb2M1WThIWVMxVWxia2RuNUZzZ1dERzNEaFNRZ3JJMkpwdVFX?=
 =?utf-8?B?UmZtZkk4T3Fkb3M1U2dkcXdSV2I0UjhvMFBnWkJycThyc3djcEgwZjFhWFNS?=
 =?utf-8?B?c01HRjd4NmtMdFdqN3ZYN0dlaThjakMxdUxPMjY2V21YQ2oxRFhpZmMvOGJv?=
 =?utf-8?B?NUlyMW11K3d1eUNEOXk5Q1NodE1VbDMwNnJGbHBBOHM5M2EwU2dUSk9rZzdy?=
 =?utf-8?B?YzF2TlJqL2NETXpTdjNWRExEZ0kvOGNwZ3BMcFBMSCtPWWM3dklPV2RFQWFY?=
 =?utf-8?B?dUdub1Z1Ky9LOFJZWjZZcC9udzI1eUorczRJcDNQWnJpRzlnUzFTZk90Q2J1?=
 =?utf-8?B?VzNQODdobHFURHlOTS9HcHBEai8zWjBHY2lNU1dsOXZpTFBLZCtvaDNOQXd2?=
 =?utf-8?B?MW80R3RBN04yWHZWOGdlZCsydTRzMHE1aDJMdkxjWXh2c3dqVlJRK1B2STlp?=
 =?utf-8?B?R3BwaVRWalNxek9ieFRUNnBsenJ0Tll0eFd3dG8yRTh2dHkzMlZIRW1LeFdM?=
 =?utf-8?B?Y1huV0d4dk1nL2MrR3lGNDZlVmhRMEZHYm40RjZ5WVNML09seVpUZWVJMVhp?=
 =?utf-8?B?U2ZWUjVVdEFrNXpmNUc2eHZ3Y0ZsR0VzTFR3N2pGK2dLemt1cXRwb2xMU3Bh?=
 =?utf-8?B?MXFHQTQ0NDNNNXJkS1N2Ni96TDJwWDFUUEdmNnkxSmpLTmg3TFlVcVdFSktE?=
 =?utf-8?B?KzQ4VCtNdE50Zm1EbkNUaU5LS2owZzBNWUU3K1kyK1V5OGpsSHk1L1NTWVA2?=
 =?utf-8?Q?+2ctSLKihPLboBiKUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkFuSGNVNkZVZkFlYVBvU2pyZC9GcTkxallBTUp1WjJaNDVMeU15ZTZ1VlA1?=
 =?utf-8?B?cGZ5eUl5cVFMYzlLdzJOYXFaYm4rdWF0M0grY29qZzJRaktwazVESlhLZzRo?=
 =?utf-8?B?TEhpelBLNzB0VnNFelhJbmtQZUE3TlpTY1pweVNNOFhIa2ZXN004a2FBY2Zo?=
 =?utf-8?B?MjgvSVNaaHJ6bk9BZ0k4ZEUxb2dyR0VBQVNnMDdFQm80Vm9vaTUwdzdmWENG?=
 =?utf-8?B?cjRzOHpNWDFiY0hkZUpUOEpEVnZVTGFCVEhsdHg0TkxjYnBGZnNvdmJ5MzhC?=
 =?utf-8?B?Zk5oRXlzWnRXTWd2SWdXcGpqN0xtZ0lvTWpudldiMDJ0b3NTUzFIZWRuMDcy?=
 =?utf-8?B?QUM2VFYrcVBEOEpLUkVoekJZV0RUbmkxM2tOTlJrTWp4ejRIREgwQkZkS2lz?=
 =?utf-8?B?UzAyc1J4M2YzRk5FT1lrS1FqaVFLYnZKeE4wbWo1OWFQTXBFUjdLV3llT2Ix?=
 =?utf-8?B?RlpyWGhOMmNDSUgvdURid3pVM2ZaRytUT2svcDEyNVE4SlNmdGcyZ0hkU1BE?=
 =?utf-8?B?OERueFdKK1ZFSmg2N2VRRkQ2ejFYa0VRR2lOTDNJbko4V0FuTnVhcHgyamtv?=
 =?utf-8?B?bUVEVExhNFB6UkU0UEFWRGxESXBacklHRVlmaFo0ZDZDQ2RQaUJwWVdaNFVz?=
 =?utf-8?B?V1FEQ3R4K3UvbjMwM1A3bWNYVjFmOGcrRVB0NGpjMUttYklwTjdzQzFnRW9y?=
 =?utf-8?B?L1QvVjhuNC8welJZY2ZvK3dwME5xN0puaGNoeHA4TUQrMWFVNnpkU3ZPT01T?=
 =?utf-8?B?RHRlNTMrckJyWDQzQ3UrUXU5S0VRVjFSUEVDM1h6ZmZ1WUZYS2d2MXBUYlFP?=
 =?utf-8?B?d0FkcHF5azJqRHR4dklTK2xCck9ab2pVTGJyNUMzWG5qZmpFMFVFOUZWMGtV?=
 =?utf-8?B?NGRlQVpjOHVIcUM5Y2xaR3l0L2RQcWw2R3ZRK1pvUndJQldDVVBSQTRzbHlu?=
 =?utf-8?B?WjJ3WmVtZHFnbHBDemhuaUlEUTlxc0ttZEg1Q3R0UjlFUFhxV3pKbjhkUmdD?=
 =?utf-8?B?di9vaGp3dGQ4bkMxc0hKRmtyWXdkN0xaWFdBRUk5b215WkhLYmpLOTNKb3dq?=
 =?utf-8?B?SWM0K2FheE0xWjNEK3BKRUlpbjZ4dmFYcWo1K1ZkdDFnRVIwVDVsVnp3SXEx?=
 =?utf-8?B?eWZQaDhRbVpEYkczZEJnYnZnNWRBTGJ2YzFSU0IrTGh1ekZPWTNjM2gvd21a?=
 =?utf-8?B?QzFzaFVQL3VSUVd4bkNDQTVyeXVicmppM1dxeFlqTlZZWjNEM2lwYkdTU3I3?=
 =?utf-8?B?Q09YZ1dOWkc3TTc0K0QxSEZsdjk1a3ZHWk9OQ3N5QWQvcVBRWTBXcEpWcG5B?=
 =?utf-8?B?K09uOGdlUGUrbE1nRU9INDNuRkVjdXArU2pXaHNGd3FlZDlYSWtSdksxaXY1?=
 =?utf-8?B?OER0SXNPSWFwdlh0cStnaEMxZk1ZV3VCeVV2UHN4Nkk0aWJBZmFVL3pHTEJl?=
 =?utf-8?B?eEUwWHdoR1dxMzJSZSttVXNQSkdveUpQbi9WcXNXcGkzdHdQYVl0UnlSWVRY?=
 =?utf-8?B?N0NXazVVLzVXZnlFQVZNZDhjY25CclpUcDg2TGVNMmZjNDlNNDNNL3pjNXhN?=
 =?utf-8?B?VkEyemcwYjloWVlIV1JzRCtmV3g2VFBpVHQ0cVdZYkhqVm0wRk5jYlJFcDVJ?=
 =?utf-8?B?c1VEaVRneEk1T2Y2MmNwZDBqSkYwVTJuSEQxSjdWZkE0ODlzWFNDeHJWbGlM?=
 =?utf-8?B?RGx1YktSeDg0R1F1RGM2VDZ1eDlDYTM2VVVRWCt6V3hSOXptUWJWZStKQnlN?=
 =?utf-8?B?YXI2RzduZ2M3WHp3Q2oxaVVtTm8yRllXVnliT3doejQvNEphc01UVmgwYjRB?=
 =?utf-8?B?ZVJNai9uQVIyMnUvL3RKc3kva1hEak5Pa0h3S3d1aUh1ZE1rV3plYVVoY1hE?=
 =?utf-8?B?NHJaZnNUWnFMSTRLa1Q4Zm9ER2FRMlY0VC8ySWRkMnI3QjdSMFkrRllFVzZy?=
 =?utf-8?B?allTbFQzUzVsQ1krU3Q4WktBQzRLLy8yZENYaUIySTJSRGROMlBlQVpVQlhX?=
 =?utf-8?B?clhOS1FuRXVSTVRMTkowWS85MmNJUXJRMXFYNERWSS9JT2Y5ZHVIUGJPNlpj?=
 =?utf-8?B?NVVZT3h1TlpCR3U3Q2loKzJ0VSswQU9HOTNsc1YrOXRLRFFleGpBc3BjWDdP?=
 =?utf-8?B?VVdKSWtZQmtGcTgrbVdUOWNYbzFSc2NwUTFiUTFnZDJSNk5TYTEvTW8xd1pk?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mWWtaOOwfF+K6pRx6YGzueIuHyE8M4fG0rYI8vhaerpgWPOQrzQ+BLdNyNuzOyaXh7Qr7uK3Kl/42FIC28za5yOPXaMKjpe57fMXoJSctPy+zMhld7LWXmk6F/uQC1kDt+1HlL9uFzn7QlFQgbh5PX3LXQi5rScp/xBa4URC4blviRiwp5/bv4hLphZN1vveT7DtNxr5bWaJHxcSVRXNlvh8H/FdPh3cnaJUeUFKdemLMKjtK9dEGNyuBR3Nwez5lTboO/IAHTSOyoXi4+iDbsIico4SuniRDR2DxslMWWC03zP13NNIoksxs06R70S2capAT2sZaBFx2INofhMp4fph7nJIsWNVLBU6jtHdZ60t5uhoJVi4HZCpkQCS5TBSdQ+24e4r/l0/FdWnEmp17nohVIkabXBheqOOHKaXl2VBzyyi2OBaof1vsnzZKitGV0W1fgVOnL5c3zRvIAk7iGW6vm2gpaPScYkDEPRbx1QsPwDwbkHsnA31FjuY2lq3/MKSy8tXC3UlAlnFevoVf5uB0lkzSf5QeqTk2wficjZLjLpBh6iFlwT6IS2whANgmYg9rfi/CYkRnXI3vl9COL1YuonIMBKWS+WPrwgEySY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef567362-2d52-40a7-e2b8-08dcd6880a1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 19:44:55.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhQv/4ryymoNaHmh+tHIJyPAhmHzh5Dj2YtGwKw18OuGDfxSmlAxaqk5fPCGUybBDA444t2+JIH5UyrIwDoev833LPD4u+RGXo8zjtR2CoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_14,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160134
X-Proofpoint-GUID: DnNNHW65JU9otz_VxeLmorkFsk3lVVIB
X-Proofpoint-ORIG-GUID: DnNNHW65JU9otz_VxeLmorkFsk3lVVIB

Hi Sergey,

On 8/23/24 4:32 PM, Sergey Shtylyov wrote:
> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
> field is multiplied by HZ -- that might overflow *unsigned long* on 32-bit
> arches.  Actually, there's no need to multiply by HZ at all the call sites
> of nfs4_set_lease_period() -- it makes more sense to do that once, inside
> that function (using mul_u32_u32(), as it produces a better code on 32-bit
> x86 arch), also checking for an overflow there and returning -ERANGE if it
> does happen (we're also making that function *int* instead of *void* and
> adding the result checks to its callers)...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> 
> ---
> This patch is against the master branch of Trond Myklebust's linux-nfs.git repo.
> 
>  fs/nfs/nfs4_fs.h    |    3 +--
>  fs/nfs/nfs4proc.c   |    3 ++-
>  fs/nfs/nfs4renewd.c |   13 ++++++++++---
>  fs/nfs/nfs4state.c  |    4 +++-
>  4 files changed, 16 insertions(+), 7 deletions(-)
> 
> Index: linux-nfs/fs/nfs/nfs4_fs.h
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4_fs.h
> +++ linux-nfs/fs/nfs/nfs4_fs.h
> @@ -464,8 +464,7 @@ struct nfs_client *nfs4_alloc_client(con
>  extern void nfs4_schedule_state_renewal(struct nfs_client *);
>  extern void nfs4_kill_renewd(struct nfs_client *);
>  extern void nfs4_renew_state(struct work_struct *);
> -extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long lease);
> -
> +extern int nfs4_set_lease_period(struct nfs_client *clp, u32 period);
>  
>  /* nfs4state.c */
>  extern const nfs4_stateid current_stateid;
> Index: linux-nfs/fs/nfs/nfs4proc.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4proc.c
> +++ linux-nfs/fs/nfs/nfs4proc.c
> @@ -5403,7 +5403,8 @@ static int nfs4_do_fsinfo(struct nfs_ser
>  		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
>  		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
>  		if (err == 0) {
> -			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
> +			err = nfs4_set_lease_period(server->nfs_client,
> +						    fsinfo->lease_time);
>  			break;
>  		}
>  		err = nfs4_handle_exception(server, err, &exception);
> Index: linux-nfs/fs/nfs/nfs4renewd.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
> +++ linux-nfs/fs/nfs/nfs4renewd.c
> @@ -137,15 +137,22 @@ nfs4_kill_renewd(struct nfs_client *clp)
>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>   *
>   * @clp: pointer to nfs_client
> - * @lease: new value for lease period
> + * @period: new value for lease period (in seconds)
>   */
> -void nfs4_set_lease_period(struct nfs_client *clp,
> -		unsigned long lease)
> +int nfs4_set_lease_period(struct nfs_client *clp, u32 period)
>  {
> +	u64 result = mul_u32_u32(period, HZ);

Thanks for the patch! Sorry it took a couple of weeks for me to look at. I do like this change for doing the calculation in a single place, rather than relying on callers to do it first.

> +	unsigned long lease = result;
> +
> +	/* First see if period * HZ actually fits into unsigned long... */
> +	if (result > ULONG_MAX)
> +		return -ERANGE;

However, I'm not sold that this should be an error condition. I wonder if it would be better to change the clp->cl_lease_time field to a u64 so it has the same size on 32bit and 64bit architectures?

Thanks,
Anna

> +
>  	spin_lock(&clp->cl_lock);
>  	clp->cl_lease_time = lease;
>  	spin_unlock(&clp->cl_lock);
>  
>  	/* Cap maximum reconnect timeout at 1/2 lease period */
>  	rpc_set_connect_timeout(clp->cl_rpcclient, lease, lease >> 1);
> +	return 0;
>  }
> Index: linux-nfs/fs/nfs/nfs4state.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4state.c
> +++ linux-nfs/fs/nfs/nfs4state.c
> @@ -103,7 +103,9 @@ static int nfs4_setup_state_renewal(stru
>  
>  	status = nfs4_proc_get_lease_time(clp, &fsinfo);
>  	if (status == 0) {
> -		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
> +		status = nfs4_set_lease_period(clp, fsinfo.lease_time);
> +		if (status)
> +			return status;
>  		nfs4_schedule_state_renewal(clp);
>  	}
>  


