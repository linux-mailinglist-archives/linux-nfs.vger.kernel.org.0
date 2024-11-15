Return-Path: <linux-nfs+bounces-8013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A539CF44F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB85B315A4
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690C1D5CD4;
	Fri, 15 Nov 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BPvp+PXH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kUVW/FL/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0016A956;
	Fri, 15 Nov 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694820; cv=fail; b=PufdJzftHAfiOwvczQez7zO91zp0nwVMV3NH0YUPEDnsXOhotwmCBnOTJWmH/yem5b05/mESLUdtxeQZmHvHnAFm0cre4t26MDzPOAzNQantcQ5Jd6BEfKbh27Lq01YYVW/CpQDps26OB9/h8YeWOv7SBjlZ0PYfsyaZ/VkYQUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694820; c=relaxed/simple;
	bh=C8nwHCasttJUPQHc8R3QpQUx5DxNSwWRKweXNqHi/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V85FA+W12O5/2ZMq3r9tt/exNcRi9bp/z27+na7Lt7YLNTOJacz5JvVhbx4mZmJIVKTJHi/wddo8v68+F3EP5sBvwY2B/DUK/AqNUMF6qMoHUWzvFAC1TMY4wVATAIs8tGEFvIXZoi/9D9dEQRv0JlgDMyKeMdanKCPboCcfLdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BPvp+PXH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kUVW/FL/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMaN2023923;
	Fri, 15 Nov 2024 18:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RTLb56TZamc96eIkdanz0RDI/+E2ACdP5KoOgov8tIs=; b=
	BPvp+PXHKKmqvVehaE5b4Om23YK2pnjqvIgN93iHJPIt1CxxQzaYk/9l1unk85zs
	FtLvYSdeAIG1HahDpEEHlDljl7Av9B6pSqkRv10v4Q6YS7A0XfSKL/ojjp4Tu67k
	hWy64pOZPqonrqASf1O5z7zY9ZAPmZ2pTbUBblPrw+XS79ImYaV0rvE/t6kcCe81
	W2/5RsKWbqOJV4FzVl6TK4OCi0QCMt6d3eI3RE6+0bHxNbI1qp5O2DeZ7WMqlAoA
	5oA01EkOjbpJcfs5T2nQq3a7yv/o7aJ/Ykbu4uQvJzJFrCFdGIKYXD21C3EAtTNZ
	K7vg6hLo/ZAWEzesUNBsbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n53xnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:20:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHZYRe005701;
	Fri, 15 Nov 2024 18:20:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6d0gvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:20:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paVKqqktk/DXC1aWFXLYG7EzsMk4NWuxFB6GNKdaUjj+R/8FbYRW2OE1sBcl60qEIESQJB5fqZcRFltz05nejf5vzLJKnK5P2jFmFvcBeebrAURC5ouDlOKULGhzwTKhoGpbcMBASL9q2ggXZt6xUk+mGZ514v4UyGTLwSXjKgApOku2jIYrd3asfNP4hAwA51RymP66pVn9HXTljjnpSuLj9WcXQJ91SOpm3kFM7FsDPAI+8Zmhugnb7G9RZ463wQ/WnbZNfaAwG2AVoIwwA5O+VogHaC0B7RLwTIV5iIb0I8czJvoyO5vxqf6T3NIAjG+JFU8dr84RvzVw+41uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTLb56TZamc96eIkdanz0RDI/+E2ACdP5KoOgov8tIs=;
 b=K7RUCKUYi3XwtybIesoACFbfWMnSbg3p48zP6NpWAIaKDLg9ur6+LwAkFWo6b1jO+B+K9cBniT0DB1K2n97m6wsfoKz7lu0SkGEq5VX4+r1pRUoUU80dTjaxXlEGgCXpdntmFZ1FVxfJZKeGtz9jRnC+Eg3Sviqhj0XKuGq+yn9VXKEJSb1dXN5IVHSzY2uXsWHs00fi0Rz9nsXjaRtXDNG9XNgKJBYswQw2ZCbHFzdhi9ISwjcW5Sa5M+ItgHsbUqYtwZ9Q9+Yuw1Q/S7fNtgnDfeCD9jcxylbieBDVV3YkWecmkqu5aOfA8RCJPIVYt9SfqK1B+TaZLyyy6qrU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTLb56TZamc96eIkdanz0RDI/+E2ACdP5KoOgov8tIs=;
 b=kUVW/FL/MOAaV5Vqf9YEYeqNY5PfduPFxhejR6gqT7wkSkB7D19Ii5yvDSVtKSCm615kxkcFzPEGAeLZ/Kt9koBfYYUR4vGSQC5kmYrm+zlF0Lh4RRbOwo0t+dFBKYi3piD/ppybgXc0gfb4tSlbrdRWi+NJsht3tbwXRtL4Vbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4585.namprd10.prod.outlook.com (2603:10b6:806:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 18:20:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 18:20:09 +0000
Date: Fri, 15 Nov 2024 13:20:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, linux-nfs@vger.kernel.org,
        hughd@google.com, yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
Message-ID: <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
 <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
 <Zzd5YaI99+hieQV+@tissot.1015granger.net>
 <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:610:75::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 112aa214-6b81-4392-a9ca-08dd05a22394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0QrOFlTeEtxTk42bWsxV2szc29sQ0c5MG9ZWWExeHRrK3lydDQyZVBGQmR5?=
 =?utf-8?B?REd0UUszUExnKytMLzlsSDNWSHVrSUpKTmZhTlpIcndYRzhzYXJ4SXZmN2d5?=
 =?utf-8?B?SGpoRnZCcEM4eUJPOGRseE10aEVHMDY3R1Bqb1lxSUFEVU1NY0xxT1FXSlU2?=
 =?utf-8?B?MzZwUnk4K3hVR1ZpU21zRnczbWxMdHE5dm9RZUROSXpNVjNJTkN6MXB5Ly9Z?=
 =?utf-8?B?SUZFWjdBQXYvdk5uajVSall3ZFB2bnViWEpvODIrWWUvZmlPZHNMNkIyVTFD?=
 =?utf-8?B?UVlwaXJkRFkxMjhNK1JPYXI3cTRLam1Ham9xbnBRNUhqWTlsaWxWVFNiKzdU?=
 =?utf-8?B?eE9tanlqamhLOWVjWDJtR3ZjWWVKdzE0aFZTMUxpb09aclFnVDNOKzgxQ2tV?=
 =?utf-8?B?UThQSHpIUWxzZWJrTkhOb0dQbGFVQUkwWFJGeDNkUFdkRmhpWlllQ2NBYzZW?=
 =?utf-8?B?cXk5Y1pCdjhsb1RMN3NZN3dhTUJjOHFKc3V2d0lHOFJIY3N4ekVWSkJVV2dl?=
 =?utf-8?B?UnU3ZkttM2JXZ3lYbTIvZFh4QTFtbDZ3WkEraDdJN0M1d2k1MXNNdUY1TTJT?=
 =?utf-8?B?Z2NFM0wvcDZlMW5vbUVIMmw1NklYcU9pRVkwMTdMekw4TGo4RHNHK2FmdzlZ?=
 =?utf-8?B?b1hVekJyU2hWdEFYbFV0V2prVWEwZXliSEhZNWdBU2RnK25XKzEyYzYvcUYr?=
 =?utf-8?B?VkhhcFVaQUVld2IwMUxtbHRiYWlydHR6bUtrWmo0NHRRR3gwd1U1MkJjUGhH?=
 =?utf-8?B?bnNzWFFPdC9TdFRWSW5wSHppSFYwOWRLVGFWaXVvU2VpQSs0TkV2VzE5bFZ6?=
 =?utf-8?B?WUhzdmNZeXFjd1lPb3JWbmladW9HcGFvRUdIWWdVSTcveE9weUI0ZWl5dFF4?=
 =?utf-8?B?SVNmSXpTcjNPLzk3U3hOWWpPOUlyVnY3WUJhclk2REtsYTJkYWV2QlB5b1Nm?=
 =?utf-8?B?S085M0dKS1hUUE82Y2hlL0tyenpGZzFjeThuTFM4ZkdhSE1uQTFVazhabHN1?=
 =?utf-8?B?dXYwallRT1FNcmdycnVWc3NuME41ekdPYndiMFhHbEJCNFFkaGJ6eWNBdGth?=
 =?utf-8?B?Qko4SmxPcEJFQmhxd0NBdUlGWlFmTUN2WGhYK0VnSUZrbml4bExobUswblRt?=
 =?utf-8?B?dEhPRzkrRUE1VU9nMTRBbkFQWW5oamdKdzR5Mi9BNWQrNkRJRVhsTXlMbXdD?=
 =?utf-8?B?eTV0SmQybHZ3L0M3aTJMMXA1MnlTd1QxUUZ6c3NpNE1CbEpiaktxcTFHVDJt?=
 =?utf-8?B?TmhqNXp0Z0V2VTk5MUxmZmxCeW5Wc0NRTy9IUVRiQThLUXMzdmdOeDdQNnBI?=
 =?utf-8?B?ZkJnUEtxN0NFYzFaR0lJbVViMVE1N0JEQUtEWmpMajdUVDA1ajRIOWNjOGI3?=
 =?utf-8?B?TXRkby95YmE0bURzTHlieGZ2RCs0WFN0dlg5blRobGJqZlJVRkZ2ZGptSW1u?=
 =?utf-8?B?eUQ4dHJMMjNBRStuRWZiZG5RUkpjbFJmSnBvbDFDdTcxei9GaTY3NW9RdE5y?=
 =?utf-8?B?bk9UcXp3OVdNMVBTYXpmdDJTd0Z0R3c4UWw3alpnR1l0VFBsWWpWVnJHdW9U?=
 =?utf-8?B?MVRtOERoZHVvU09FK3V3L2piWVFINnRsRHZYelZreml2aWlpdVFWNFBtMWkz?=
 =?utf-8?B?RkNRZ0V1aTRTVEYrNVhzSEQ4VDhIZTlENktSMCt3MnhsTlNaaW5ZUS9RQUNp?=
 =?utf-8?B?UjhjKzB0bWJ2d3g2SHc4RXdBU0NuQTBUZTlUY2c0RURGL3BCaVA5YTVuTlRt?=
 =?utf-8?Q?bQS5b8cakrsCIGyFnUFjso8r5CmTSdyulziyMK8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJiNnNvWTZMWUpTTWFWTmlPNkZTRStjZnhBRklRQzBOUVR3dkxBY3VxbzM1?=
 =?utf-8?B?U2lwZEZJWW9aTnNYT2syUjJ5NU5LRSt4UGlzM0pRR1h2WXhtbmhMaEhyVnp4?=
 =?utf-8?B?V2FYYTV1TmR2VFZFQ0VqaXZhSnF5dFJJV2lzRDZGc3l0UGRyV1dXL2FtK253?=
 =?utf-8?B?YmE5OUx2TjhFdU8xaURCQTZ6T2VmdXNudnA1TDZwTWZtNm91NzZnTkppNXBR?=
 =?utf-8?B?bHVXLzNmTDJiSitFSm1FR0tsRTNMT3BXT29oR2pmWW13ZWc0clk3Wk5yWThR?=
 =?utf-8?B?d1ZHRHVzdVMyZFVONStzVUhIM0w3RU43WlphbDh2b0VzbzhFMmJtWG9Bb2Vy?=
 =?utf-8?B?K0IzZUNzWWE0V2R2TjRNSndMblhJa3NLQ2ZVVjR0MlhKQUV1T0p6d0FvdzE4?=
 =?utf-8?B?Rncrd2M0VHBwNW5Za0YvLytua1lNWlZISk8vbjdJMVFpQVhqT3E2QUlpa2pT?=
 =?utf-8?B?dDVZRXlLMU1kZUQ1Uyt0eHd2VnBRRklaRHlrUVMwbVB4TEs4bUhvc1VNdHM5?=
 =?utf-8?B?dDNobi9TTzJUVW95bG1lMmRVcFlMVjgwYkNzZ09qVFMrcjZrUDg3NEtCRnlQ?=
 =?utf-8?B?U3hoRGhKVUtlc21VbFFoV3B4ZnBHNG1hSG1tc1Jmb2FuUVRRR3RTNHdFVURQ?=
 =?utf-8?B?S3JFSTJFN2lBMlA4KzdQcjhjeEw5S3A0THdUeGtsTHh5aEY3aFRhWE1QMTdQ?=
 =?utf-8?B?c2FQZDNjRWtEZ3FsWXFWUkRlMjVXaVJtZjh4K0lSVnVKWVIwb3NjVjZVbHZD?=
 =?utf-8?B?RnluT2Q3U2xmL01CSHhQL3FmSVYwZlgrQ3hQZ1dqNkhFbGU5alZ4UnpjY2N4?=
 =?utf-8?B?bkRIN1h4bVljaERYZExlMlA1RzM1K0hCNllKZDF0aXl6OGs2WndoQ2FmQnFn?=
 =?utf-8?B?TVN3ai9RWG9HWjVZVXRqclJyQ0F2aVh5VG5RcVlhWFRaRi9JVERMZFZNTGJX?=
 =?utf-8?B?QzBaUWN1eHFJRlp1QWx1NENzMWN4TUNVdlFXQnpFZ0p1TDNwMHF0MHB1M09w?=
 =?utf-8?B?K3g1YmFPelVLY2tYbHBnWVVsdjc4dXVPNnhMeGN1Rk45dnF6RnNSK2o3UldM?=
 =?utf-8?B?UDFNRmR3dXFpUGx4QkdGQXNSeGw2NUltbXREYlRoU2NtWjRqVWdPQkM5MzM2?=
 =?utf-8?B?czcyWDYwR0lLNHZBcnN6L2NEaXBYY1BYVUUvbWRTQ2o1aDNreU80WTNwOXZ3?=
 =?utf-8?B?VHlNWGZJSUdsK1djRXRIK3c0QXBaSjkwQTFJQjJGM3hlU2tRc3cxMkZUZnRY?=
 =?utf-8?B?TFpQc1A5T1g4R29SY1p1Wmpkbk94dkRWMy9ObTg4YzNMUWlqZVdaTTJTVysv?=
 =?utf-8?B?YUhJcmlCNWYrZ2xCYWR5THVYRlQrM2tydTZEblBKSytrTGhMMW1rREFZNkVT?=
 =?utf-8?B?eHhMNnFDSkR3eEpLRy8wTzZ4M3BUVFAxVG9DK0lUeW5FNGxnZWhpNmRuZEZH?=
 =?utf-8?B?N0kwc24rRVdwc1lKOVlhdHlYUE5TZTF6SnFtV0lVTmdndHNNYkhNdGxsc09M?=
 =?utf-8?B?NzdyNlVyWkZrMzgxdGV5SzJRbXVXYjY5TkR5bGg3Ym8rNHptUWllM0RYWXZS?=
 =?utf-8?B?WTBCYjFnMkRkTlBkd1hWUXdHWmV2bUYxdTRZVVRyQkVWbHB4Y25qbjdVb2RT?=
 =?utf-8?B?SklRdnhUbHV0bndRV0Uxa21lWlRuZWlsSjlObFVmVXQyOFhJeU9PMVJNZEFG?=
 =?utf-8?B?UkcvL2tZV3VEdEVQdjd5RzJqN3FROGJUaDV5UUpiVENKdEdPOGNKNjhhbXRu?=
 =?utf-8?B?SW94TGRuVkZHb25FL3Q0dkdhZDhLUkdiRXBVNGk2dkJ6aG93azVSRmRpcE5v?=
 =?utf-8?B?ZEdEY3FwMmx5U1lrMDB4YzNnaGVkN3VkYmd0RHBycFlLNzdQSmV1clIzSTZB?=
 =?utf-8?B?czAyWmJYSjlKYlBCQ29lak12ZUJNY2F5Q2JUam5ZVmF5RVAySHI3QmdFZWhB?=
 =?utf-8?B?Wm1qLzZXVFJod0FNU0dsMHVZOFA2dnJJNFd4elNYZzhpTXJNSEZvUElyQVlE?=
 =?utf-8?B?YnFwVmg0ejV4NjdqWXBrMTJ1Q3pmNllCR3R5V01Ib0hFSW5sUjdqSjF4M2JC?=
 =?utf-8?B?Z3V1R0kwME9CUFZ6czNEWUJvQzdtNUNkUC85aURaRkxPOWdlRDN6QUN0Z3Fu?=
 =?utf-8?Q?lTzN4C9UT3+j6NK4aATDMzK8M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vw51PT2jWzgu5IWhw591Izvbb+JOodIZM11wCScoOEUQj5jUJ4qOGwqkUPCcM+PEfm4R9yQEF6UvbAPuSEXXFvJ3zT6Lpg6+ehfaKNbLdCDOAxIHMkm//74I3plUtpgb2fSJIv2YkfpKrj2I3904eBFbe0uex25s7UL4dp7DpP9nMiYt95fdqv8+Ov2NRCiTrExEEFPJjDeH4c9gWpTqBxbeMlXks+iBBvMagrq0C8EiwmoES7Qe6RyHrJwOOvPnxkik7A5EybFJnw3W+W40ROZMcdVA+DxlIUfu7D1+vhyn9pNtG5cREDpQ+/nddOiHpA0Z85JUeI66CWdNQMid/wXS1wbhgsGL6X6ruLMX4Y88pjTL4klVJdmMecYx6m3Pew62cdZ3U2G88pe6NtnoWs6i4NlPT7xN2ry+9N7hgDgPj3fJq4Gx09S6u/wLumb4bP5+4gMD7xsUx1wu6DtRdvCC1pMVtBBk+KbDM/7Joq3lYyaR7UhHjXTHRcKsknmxJ4/Tgl3QBuONEJQxJsuPwK47zyPVrYXW4eMLewB6PSq2Tdsb+hk6El8JYCKN/d2mdETnzOlvv2FTCod/mAOYAf9HBpM//fDSt7oGHRupSMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112aa214-6b81-4392-a9ca-08dd05a22394
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:20:09.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU1HBiaegU5xZhxxzEspSypFQ6B1VwEUe0EBEDOnSCgY29f0OpHN+olcSrkzsHFJ6fpuifwAry4yKEr0sIFuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150154
X-Proofpoint-ORIG-GUID: Jq-9MKAF3erPO5V2Lbql7yo-IciSrcxv
X-Proofpoint-GUID: Jq-9MKAF3erPO5V2Lbql7yo-IciSrcxv

On Sat, Nov 16, 2024 at 01:58:17AM +0900, Jeongjun Park wrote:
> Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Sat, Nov 16, 2024 at 01:33:19AM +0900, Jeongjun Park wrote:
> > > 2024년 11월 16일 (토) 오전 1:25, Chuck Lever <chuck.lever@oracle.com>님이 작성:
> > > >
> > > > On Fri, Nov 15, 2024 at 11:04:56AM -0500, Chuck Lever wrote:
> > > > > I've found that NFS access to an exported tmpfs file system hangs
> > > > > indefinitely when the client first performs a GETATTR. The hanging
> > > > > nfsd thread is waiting for the inode lock in shmem_getattr():
> > > > >
> > > > > task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:2      flags:0x00004000
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __schedule+0x770/0x7b0
> > > > >  schedule+0x33/0x50
> > > > >  schedule_preempt_disabled+0x19/0x30
> > > > >  rwsem_down_read_slowpath+0x206/0x230
> > > > >  down_read+0x3f/0x60
> > > > >  shmem_getattr+0x84/0xf0
> > > > >  vfs_getattr_nosec+0x9e/0xc0
> > > > >  vfs_getattr+0x49/0x50
> > > > >  fh_getattr+0x43/0x50 [nfsd]
> > > > >  fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
> > > > >  nfsd4_open+0x51f/0x910 [nfsd]
> > > > >  nfsd4_proc_compound+0x492/0x5d0 [nfsd]
> > > > >  nfsd_dispatch+0x117/0x1f0 [nfsd]
> > > > >  svc_process_common+0x3b2/0x5e0 [sunrpc]
> > > > >  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > >  svc_process+0xcf/0x130 [sunrpc]
> > > > >  svc_recv+0x64e/0x750 [sunrpc]
> > > > >  ? __wake_up_bit+0x4b/0x60
> > > > >  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > > >  nfsd+0xc6/0xf0 [nfsd]
> > > > >  kthread+0xed/0x100
> > > > >  ? __pfx_kthread+0x10/0x10
> > > > >  ret_from_fork+0x2e/0x50
> > > > >  ? __pfx_kthread+0x10/0x10
> > > > >  ret_from_fork_asm+0x1a/0x30
> > > > >  </TASK>
> > > > >
> > > > > I bisected the problem to:
> > > > >
> > > > > d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
> > > > > commit d949d1d14fa281ace388b1de978e8f2cd52875cf
> > > > > Author:     Jeongjun Park <aha310510@gmail.com>
> > > > > AuthorDate: Mon Sep 9 21:35:58 2024 +0900
> > > > > Commit:     Andrew Morton <akpm@linux-foundation.org>
> > > > > CommitDate: Mon Oct 28 21:40:39 2024 -0700
> > > > >
> > > > >     mm: shmem: fix data-race in shmem_getattr()
> > > > >
> > > > > ...
> > > > >
> > > > >     Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
> > > > >     Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
> > > > >     Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > > >     Reported-by: syzbot <syzkaller@googlegroup.com>
> > > > >     Cc: Hugh Dickins <hughd@google.com>
> > > > >     Cc: Yu Zhao <yuzhao@google.com>
> > > > >     Cc: <stable@vger.kernel.org>
> > > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > >
> > > > > which first appeared in v6.12-rc6, and adds the line that is waiting
> > > > > on the inode lock when my NFS server hangs.
> > > > >
> > > > > I haven't yet found the process that is holding the inode lock for
> > > > > this inode.
> > > >
> > > > It is likely that the caller (nfsd4_open()-> fh_fill_pre_attrs()) is
> > > > already holding the inode semaphore in this case.
> > >
> > > Thanks for letting me know!
> > >
> > > It seems that the previous patch I wrote was wrong in how to prevent data-race.
> > > It seems that the problem occurs in nfsd because nfsd4_create_file() already
> > > holds the inode_lock.
> > >
> > > After further analysis, I found that this data-race mainly occurs when
> > > vfs_statx_path does not acquire the inode_lock, and in other filesystems,
> > > it is confirmed that inode_lock is acquired in many cases, so I will send a
> > > new patch that fixes this problem right away.
> >
> > Thanks for your quick response!
> >
> > My brief sample of file system ->getattr methods shows that these
> > functions do not grab the inode semaphore at all when calling
> > generic_fillattr(). Likely they expect the method's caller to take
> > it.
> >
> > I strongly prefer to see this commit reverted for v6.12-rc first,
> > and then the new fix should be merged via a normal merge window to
> > permit a lengthy period of testing.
> >
> 
> Hmm... Of course, revert this patch is not a bad idea, but I think that
> patching it like below can effectively prevent data-race without causing
> recursive locking:
> 
> ---
>  mm/shmem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e87f5d6799a7..d061f8b34d49 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1153,6 +1153,12 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>  {
>     struct inode *inode = path->dentry->d_inode;
>     struct shmem_inode_info *info = SHMEM_I(inode);
> +   bool inode_locked = NULL;
> +
> +   if (!inode_is_locked(inode)) {
> +       inode_lock_shared(inode);
> +       inode_locked = true;
> +   }
> 
>     if (info->alloced - info->swapped != inode->i_mapping->nrpages)
>         shmem_recalc_inode(inode, 0, 0);
> @@ -1166,9 +1172,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>     stat->attributes_mask |= (STATX_ATTR_APPEND |
>             STATX_ATTR_IMMUTABLE |
>             STATX_ATTR_NODUMP);
> -   inode_lock_shared(inode);
>     generic_fillattr(idmap, request_mask, inode, stat);
> -   inode_unlock_shared(inode);
> 
>     if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>         stat->blksize = HPAGE_PMD_SIZE;
> @@ -1179,6 +1183,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>         stat->btime.tv_nsec = info->i_crtime.tv_nsec;
>     }
> 
> +   if (inode_locked)
> +       inode_unlock_shared(inode);
> +
>     return 0;
>  }
> 
> --
> 
> What do you think?

As I said before, I've failed to find any file system getattr method
that explicitly takes the inode's semaphore around a
generic_fillattr() call. My understanding is that these methods
assume that their caller handles appropriate serialization.
Therefore, taking the inode semaphore at all in shmem_getattr()
seems to me to be the wrong approach entirely.

The point of reverting immediately is that any fix can't possibly
get the review and testing it deserves three days before v6.12
becomes final. Also, it's not clear what the rush to fix the
KCSAN splat is; according to the Fixes: tag, this issue has been
present for years without causing overt problems. It doesn't feel
like this change belongs in an -rc in the first place.

Please revert d949d1d14fa2, then let's discuss a proper fix in a
separate thread. Thanks!


> Regards,
> 
> Jeongjun Park
> 
> >
> > > > > Because this commit addresses only a KCSAN splat that has been
> > > > > present since v4.3, and does not address a reported behavioral
> > > > > issue, I respectfully request that this commit be reverted
> > > > > immediately so that it does not appear in v6.12 final.
> > > > > Troubleshooting and testing should continue until a fix to the KCSAN
> > > > > issue can be found that does not deadlock NFS exports of tmpfs.
> > > > >
> > > > >
> > > > > --
> > > > > Chuck Lever
> > > > >
> > > >
> > > > --
> > > > Chuck Lever
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

