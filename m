Return-Path: <linux-nfs+bounces-8411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D219E8066
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7218840E2
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62A22C6C5;
	Sat,  7 Dec 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3WVRKWd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TgvPAtHM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7666322E
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733584865; cv=fail; b=d848tP+qgD8LXioY3UOh9oZvqbQ7ThaUbZaLIkEKBLp92VJhrtTKvZOAMwc5tInTSdNyZrzVZcrFqOoWoZrSjRlqJ10rnxRtpQtQTsagOAC4BR9/2oDWfMs3vA0l5es9hgyvdLOojfET/PfSBF1PiYpVM4/rOKA96kA4V3mEy5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733584865; c=relaxed/simple;
	bh=BzOopw+Fs0yLQqlTBmfRTMcbEINu0Kvp18jEdVq4Vgk=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=tAvBy3mbBjqFlOn/x73iTSA2kTl5HpM9pOtlkzJbiWZa/A9JCssD5YtDG6FONAwrok+GHj5fj2WBzT0ltifVFZZV8ACUQK6UBNAPWADnmUbl+DSpw2fFfJwGlgctMErTVuLjxcZH1Rmo0tDwb2aTasX8B4Pxggn4EyLzBL/bOLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B3WVRKWd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TgvPAtHM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7BSBAr030183;
	Sat, 7 Dec 2024 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GMId+/mGx8gOZH8uISs1McZSuzhMTC381X76ctkqVlY=; b=
	B3WVRKWd+cdGxwJ9FBgheUUMoOcBUDYFw9XinmVbJCKaeq2nTHLfUP58yrFMBa2Y
	m6fUHKvxlZ0rAwigubRhJ/Le3xjI7gsysut/2jbnnWuIf6p5f+8tCC4EDVW+6kMM
	lh495i9xidE31DljyE2UBe1m962H07nOms3FyUufH9WTXUj62OlyHIiyHuCVocLI
	chuzJ3TPpzVwDoBJvGh1S+uwrHrJeLmLEymGhjLbsaCHwEBvK3hN6e5lPBKIiO6d
	TnVNkdWT1Iu/+YjQPHSrjnUYuTtDzMVok6/kFgQUoW+P86eqFMUxihuq7bTF37P2
	IAu0F196gCsGLhoOYYKG6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9agn9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 15:20:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7BPBSp008585;
	Sat, 7 Dec 2024 15:20:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct5kfc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 15:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhbykG9ZPKf6ctN9cSD8h29I26o41Os2lBg46ZaNUm3gVBpuN/b7PVHoIbMg/6fh9g0VKV+etUDcbJl0INSpuj1j0gS/4SezgMj+oKpVoqD1T5BU24CD0o6Ay9NgVrtuI0hk3GuVyujEFsEgk9tVPTLqAM0TDrA5WpT5TyKc2JYdUWQPLLosLsHHiwvr06hcQWtkcSEhf3Uyqv4oqX/fK54IQh8Ar2eK/e3uP3XrXE0lRuEP5rKOwP3cXig60rTHDxdw+uTHvFDZle+tbUppoQGXsXUtzwflSyLnh/A5DG3g/lRLDWM+nwUzbURo9DXD0IytxPIytFqw6+9CQEPCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMId+/mGx8gOZH8uISs1McZSuzhMTC381X76ctkqVlY=;
 b=X7G8uU6IrIPbyUyeqadx984q0z+bC1ACcx7aZgnVM91ptQeH13lq2J/Y8skD51cMX+PYOhZt+WdGT1AeSu4rPUlhxFW+BYa1ruOo8v4ojUjRWxcuN1EaBryld2k5DSQU0ewYQ+IcrSwnpvec6NRRtkD1MhDs/3CvApKj+gYxT3p7DakbfsAtjQ0ZfLTaRJptQpzRDU7T6Nk+yGi252m5jpe9ZFCofFp83JynNHjqpWfNZLzI+64OeoYRZfABcamExg1mzIQVS0Zr82gTGSSK1MNmxqchZtkwb+7fYhn8FjhSV7HFwSnEw7l5efz/C7DRB3UfNBav98ImVEPVLZKxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMId+/mGx8gOZH8uISs1McZSuzhMTC381X76ctkqVlY=;
 b=TgvPAtHMSqaOBAqjeIdIpdTrMlpTEZeYow9NA44vrsLPVd0L36ZpQrZq6t7cB72WVtdoXPEgMkug9pB14hGqUsowffw+bdDxbH4gkeWz5n2RPRzuSJyOwPI5Icy2pnYE14fQoFfXUaD24xblTLxLIJtYPp7d/H18yZflS2YVRjM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sat, 7 Dec
 2024 15:20:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 15:20:53 +0000
Message-ID: <699d3e51-49b5-4bcd-8c13-5714311f8629@oracle.com>
Date: Sat, 7 Dec 2024 10:20:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Roland Mainz <roland.mainz@nrubsig.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: ee11b14d-0ddc-43b4-27a5-08dd16d2bd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHd3NlhsZkNpOWNDRS9sdTk1bDlRSU1oOTFxQVcvNWVya2tlNjhId3ZpZWVP?=
 =?utf-8?B?dTZsNnFvbVdQRThpdVI1dEtUd1h6eDdxL1VzTWFUWmFqOGMzMFpDUDBGS2xX?=
 =?utf-8?B?RzFOM0lsUEgySmZEUElUOHRnaVNVb1I5L3VvaGRXVWlxT2RtYVZBOWJUbDBn?=
 =?utf-8?B?bGRlNFRCT1NvYnN1bXRsWVJHNnEvZVo4L2ZyaXIwWGJYUURYUnNOK0N1WGVQ?=
 =?utf-8?B?ejdqZGtudUY4czV6RERQQkxyTGxHMVZjOW1Wc2ovSW5Zd3RTeU9HNlhuNlA2?=
 =?utf-8?B?Ky8rTWhNNHEwbzZyOUhwRHR3b1RkUEk4eFJsNWVzNlQzR1l1NHN5S3VGTzA1?=
 =?utf-8?B?Wm1nSURUcVlweW5YTkdYeVA2bExUNkJaYU9IZlB5Zk94RXQwdjhkUlNOVVZD?=
 =?utf-8?B?ejczNVdnUlF0ei9CSnRGQUlXN1hCSThyczBXbUMrczMrUkF2ckhPMWd2YitI?=
 =?utf-8?B?L3cvNDVYeEhRZzVXVHJJUWdjbnQ0Zm1UbUM1andyUk13Z3dGdFllQWhCK3pB?=
 =?utf-8?B?cTJvM3doOVJXcnJ6VDRpNHVndEFZOXU1aW14K084aUxuTU5paWh0dEovMzF4?=
 =?utf-8?B?enBBdXViNVFPdVpVejdTZm5aak84SmdJZXRpUENwWGcwUTlEaE5mdzBRaS9v?=
 =?utf-8?B?QmNCRitSTkE1S0NtTXI5RVdLaFMzYzZvNFFIRFhXaUoxNkVYc1c4V1VIRlRn?=
 =?utf-8?B?VmVjb2dXbTdoazJ5dW1pcEhSblBwVDBwUmxsZ2RzVVhRUlYyTHkzWlBNaDZs?=
 =?utf-8?B?RXV2Z29vUnRLNEZJM2o4cTV0MGdBTy9FQlpmbVpURUNKZHEwVmN4VXQ4RThw?=
 =?utf-8?B?cHFqTUJ4dmtjQzV4RWdUZ3RzMlhwejZDbFcyK1QvcXR1ZVI1VmRMODBIdk9m?=
 =?utf-8?B?d0lVU0kvcXh2VWlQQnh2RWx4a1VEL0pqV283K1pCb0J5OWs3WlhVemsxMDhD?=
 =?utf-8?B?cjR3TXZuemh3SmV6ZzVhVGNWUytXMjBkNkNrMit1RTdBVUZKQzNLQm9EQTBE?=
 =?utf-8?B?bjRCTllTdnVFSkxwU0JzUUJlY083dk5JWklEV1RWYnprTmR5Y3REelZwRkZ5?=
 =?utf-8?B?bUVhL09NdE5BcWxOQk1aYStXS3JkdkxGS1YrdDZ5UlJzanlWVEFtME5tSnZy?=
 =?utf-8?B?eVdwV3ZtSUhsNEtGUGE3dU83cWpPNnlpT3E2MTZpMXN3TTlObXJvQS9aZVMw?=
 =?utf-8?B?cE5ieG14TkJMSyt3RDdpaW5WVnJvTTZJNjRUNUI1c2tGdGdaUUVDazQ3cnFS?=
 =?utf-8?B?N0ZnSkJIYjY3d2pEaGMvY2NtSUgwaE4vYkNTZE1sS1BZUDFSangzc1ZMazVq?=
 =?utf-8?B?K2pwZVlrbytMbHRJRkxCcktZR1BOb1ZleTR1cXFSY29jSm1kQzJEVlZoNmdM?=
 =?utf-8?B?OHE0cGVNeEtnMUsyU3ZkYzk5a3hMM3p3Q1piVko5WDJRaXpoQTkwaDlLK29T?=
 =?utf-8?B?QXd4bFIvdE1hSXBQSUVyNVRQNVZSUmZHS3JqeU9Mb0FacFIyOVliWEdVaW8y?=
 =?utf-8?B?Z1RmQlNDSnNJeFZ2RVVwMEhBdlI3K0NUZkZyb212NnN1OVIyUEJ1SytjdGRP?=
 =?utf-8?B?RFdUVWxiNXZWN0pCcHVrdjFtcERQczllRW9OYjJyQmphTTcvWExYNC9PV084?=
 =?utf-8?B?Mm5pc2dtMWprcEo1Z1hudGM4UHFub2F6dHBOVjJyQUtCWG9qUlYzdy80d0w1?=
 =?utf-8?B?dUtpVGY2K3NNYnMwc1dPVkhvTHg4OC8zd2tIdkhtbDViWDBEckpsTTZ1UCtJ?=
 =?utf-8?Q?LKtijWNg0Y0oKn4rVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNOODU1Wm9raXIzbEpVQnp1ZWdYZnZ6d1hUWjY5cTkycUs3VksyYTAzZ2py?=
 =?utf-8?B?TkpKWnZLMVdhc29qVjlHdHJtZ1kweE1wUFdkenk5NmxKYkZLQWNraGdLTUky?=
 =?utf-8?B?cy9TMXJxRnJJOHJjV0Z5d0QrUnY4U1lyNmhodys2NDZ5bnJlR05QQVMyWTdt?=
 =?utf-8?B?eUNseVBqcDFUQ0w1YXhueWZBWjFrVXczYkdhczk3ZXY5cjdpWHRXOFgyM3lq?=
 =?utf-8?B?TzBrU3dvTVdtcElqRVFsclFwTjVEOTFMSnhrMG0vaDQ3dXVqNERqeXByUndO?=
 =?utf-8?B?VjhLVDdUSE5qT2szU29MU3BFK041Ukt2N3plTnBNNW5YYUFscE1VOE12Vko2?=
 =?utf-8?B?dS9CTmVXTUFWL09DdWhuQXVGWEF0a2w2cGVUQkZ4ZFlJVmtVdTBJZFZPOFY2?=
 =?utf-8?B?SndNTEZZczVkTWNXc1dDYm4zam40NHdmV0ppK0RsV0VjQnlkY3Btclo2aDVz?=
 =?utf-8?B?RDFOYVprTmg2MW9xNkkreVZFTGFHR2JVZDFDRmpLUGZsYlNabzRjcU95NEMy?=
 =?utf-8?B?UUtUcGF0c0JwR0ZEY2h4NHEzOTFPQzNsL3luSXdOYi9tS2ZiQjZTS3hma1h5?=
 =?utf-8?B?U1NMdjQ0TFFnYktLeTZVWmkyQ0hhVnJTdmVWUWd3aHBPWFNCbXhtZjhlK0VG?=
 =?utf-8?B?dmM0UGU2S21SQUloYUxvdW9FYi9aSUxKQitPU2NKSTQ1YkRZT1dlNjNRRmUy?=
 =?utf-8?B?MjBuemcxRmVTalRCQk1oMDJsOE9XbGZDRlVxUmltajN0bElaK1E4dVlWeXFq?=
 =?utf-8?B?OVJXcVBZdVJMc2tMaUZoenJveExndUdkUUNqRzl4QUNLcEFPZkwxK2lPRFQ3?=
 =?utf-8?B?WTltblpvTDBMR2RJNm4rZXdCVVV0RDVjNTUvQlZlNkFOTEtJSjdWQnVJNWpS?=
 =?utf-8?B?Z293dlNJUUl3Y1BjQmZoMG1qOUUzVEdqclNvMnJSb3ltZ0tCVkdDbW9sN3Rn?=
 =?utf-8?B?N3JzcTgxTndOOEVoejNHMHN4WVY0d3czOWh2RnlWSWZYQnRrMitBTWZoV0lE?=
 =?utf-8?B?SE1BVStoc1Noc1VOQXpvb2RhTlp3c1hpSFArUCswZEUya21NOGxOSXo1dS9Q?=
 =?utf-8?B?UklQNjdCeEpYak8zc1BKaURWaFkrNGpySkZvVTkzN2R2VmFLS2lRQ01XcU0y?=
 =?utf-8?B?cjEzTmtBaklSajJzYkJoc2hvSC84V1JnZlpnRm00QVZWbUUwQVdSWFlrZjB5?=
 =?utf-8?B?NTRMeVpoOHFkaUNIUkRzcHNTYXM4d2hCZWJIYTlPRk5NMWpBZlNoRmZ0UUVK?=
 =?utf-8?B?QkVqYWRxUTFVTnlveHYrMGpERE1VUENpb0lUSXQrNnRwY1lscU91Q2xpZWpW?=
 =?utf-8?B?cE8zN05jSWg0eTlNNVoveEdGalhuZzFpY2VuMUt4MWFoUXJMaC9Vd3BqK2Vq?=
 =?utf-8?B?R0V0eUU5SjNkbHdFbTNyWDdCTjNPZ1d0QnRDWnNYVUVjS3ZkZFNjYU1pcExX?=
 =?utf-8?B?YUh1QlY3TkNKYVZBSllXeXp6Y2tPVmFleW5zaXkzRUV6UEZwQXFTSnhUVXkr?=
 =?utf-8?B?VGhsRHNKa1dSTmZaK1ZwSThoOTRkeFdiYWlTOU8xZTB4YXZZbDdKT3VWVFZw?=
 =?utf-8?B?ZWpDbC96Z2pUMVZlREZZZDIvK1krdHBBVHh2Q2tjRjhENzNVaERhaTUvdE44?=
 =?utf-8?B?ZXppbURLVlhBZmNPRDVBekNEbk0vMDBNdUNUYWt4VFJUS2pDU05lQ2dlVWdY?=
 =?utf-8?B?amF3ZlRhRTA2aFRMMzZxOG1ibVBmV1ZUWDlDNHlJbFpDUExrcmd3dW1VVWRi?=
 =?utf-8?B?R2ZjdEw4SFpiS1hhOWJzaTF5YUlpUGZtelBjUDRibGozWjhpamZTR0J2TDhu?=
 =?utf-8?B?eS9oWDlLMTU1VTFxZGVEeDd1UkFWbkllMU5NMTd2dFFBYVJZc3cwaG5lM0Rr?=
 =?utf-8?B?dW9PTUQ4V3NRNVlkV09HL25zOFJtTGs3dVZ1VkFEUXlXTUQ1SkVTTytzYzJ5?=
 =?utf-8?B?TllOeDQvMmxnaUtFWkxDU0tldGxUTmdsaGZ6U3NHTGtiZjBzTlRWMnFScjVH?=
 =?utf-8?B?dEpOVjlEdFJCNS92SnBaQ3FkYXV6RlVVZ1B4M2F0U3VQSUROVlNJaWhOcVVR?=
 =?utf-8?B?R1lTS0V4WkExT0xvUEhURVFZQmNFL2VtRFVJVjNPdGZmS2NBaG5CRHlEMC95?=
 =?utf-8?Q?WNNVeb4sFFl3IqI/DcLeKipWH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OFvTbgUw142eexZ0BTmha90dUj3fiY1NNXaeuD9MmUZ8Rv10E8FXD9DjHD3z0h6lFpapfoCGoPpOPLY0PEEm4y05BhfFvTuP5xhPM9Fb3YZaeWeDWrUgy9TEzMuGkCYUJNMshhSRseg9tZJ9JiBe15xtpoR+c6v2llmekSmLUYXoMnQLgB3Ocp0GfFhMV52w5WYIahIZoGdt7YrngUXpeI7vKOFTwm3J6h8N4z+jXikA81H8sM4apWzi2dEk9OnlPmqvJLBobtn2wXzPrQyYAs3BUHz01/TL8MX4Bkvd5ZahsiCwpptubuGSsN8YtDLZwA+ZtMXSqfEy9jiKW4WpHwkg2ZrLEKcIIOJEZLXJVm2OSa8SeZwOMD45dKrBDubWXLDI5Fph0u0o40rPiXyf4Xr/hqE6pLx1EC9KUla8m3nIvDNRJiAJb3kvM1zSKCgHdKD5luCoC8yFacdDe/3k/gKx/8zLjpRnnS35tSdYmEy+iugoA1xO0ebv6PaXr4NNNDc5IrGaS383LXtUATZNMm5YR2YLlIkgWmkvVJD9emw9iK7ROsKNcFYgkPaEoHG1js3tapjdMAqTDjrUQAh9/FUs7Q8+WE69F0nZ1zMArDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee11b14d-0ddc-43b4-27a5-08dd16d2bd28
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 15:20:53.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqhwQ5mT8/qv/No3BL3h9Sy6Qecb8FjMEQWfCQYYT3V7sV+Y7/Exd3HXgr9OHMhzprG4rPsIrgXG9IT0AHx9VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_02,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412070128
X-Proofpoint-GUID: _grMHWC1B-xzVBa0K-j9-SlENQ8vzNpZ
X-Proofpoint-ORIG-GUID: _grMHWC1B-xzVBa0K-j9-SlENQ8vzNpZ

On 12/6/24 6:33 PM, Roland Mainz wrote:
> On Fri, Dec 6, 2024 at 4:54 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> Here are some initial review comments to get the ball rolling.
>> On 12/6/24 5:54 AM, Roland Mainz wrote:
>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
>>> to the traditional hostname:/path+-o port=<tcp-port> notation.
>>>
>>> * Main advantages are:
>>> - Single-line notation with the familiar URL syntax, which includes
>>> hostname, path *AND* TCP port number (last one is a common generator
>>> of *PAIN* with ISPs) in ONE string
>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>
>> s/mount points/export paths
> 
> OK
> 
>> (When/if you need to repost, you should move this introductory text into
>> a cover letter.)
> 
> What is a "cover letter" in this context ? git feature, or something else ?

Have a look at git-send-email(1), and search for "cover". A cover
letter is an introductory email, followed by the patches themselves
in separate email items (usually organized as replies to the cover
letter, but that depends on the email sending tool).


>>> Japanese, ...) characters, which is typically a big problem if you try
>>> to transfer such mount point information across email/chat/clipboard
>>> etc., which tends to mangle such characters to death (e.g.
>>> transliteration, adding of ZWSP or just '?').
>>> - URL parameters are supported, providing support for future extensions
>>
>> IMO, any support for URL parameters should be dropped from this
>> patch and then added later when we know what the parameters look
>> like. Generally, we avoid adding extra code until we have actual
>> use cases. Keeps things simple and reduces technical debt and dead
>> code.
> 
> Originally we had much more URL parameters in the patch.
> 
> After lots of debate I've cut that part down to the set (i.e. { "rw",
> "ro" } * { "0", "1" }, e.g. "ro=1", "ro=0" etc,) which is supported by
> ALL nfs://-URL implementations right now - which means if we revise
> the nfs://-URL RFC to make nfs://-URLs independent then we have to
> cover the existing "ro"/"rw" URL parameters anyway.

NFS URLs are specified by RFC 2224, but extended by RFC 7532
Section 2.8.1:

    https://www.rfc-editor.org/rfc/rfc7532.html#section-2.8.1

Note this language:

    An NFS URI MUST contain both an authority and a path component.  It
    MUST NOT contain a query component or a fragment component.  Use of
    the familiar "nfs" scheme name is retained.

IMHO this part of your implementation needs to be postponed until the
standards are worked out.


> Technically I can rip it out for now, but per URL RFC *any* unexpected
> URL parameter must be fatal, which in this case will break stuff.

Fatal? What does "break stuff" mean, precisely?


> That's why I would prefer to keep this code, and it's also intended to
> demonstrate how to implement URL parameters correctly.
> 
> Maybe split this off into a 2nd patch ?

That would be good.


>>> * Notes:
>>> - Similar support for nfs://-URLs exists in other NFSv4.*
>>> implementations, including Illumos, Windows ms-nfs41-client,
>>> sahlberg/libnfs, ...
>>
>> The key here is that this proposal is implementing a /standard/
>> (RFC 2224).
> 
> Right, I wasn't sure whether to quote it or not, because section 2 of
> that RFC quotes WebNFS, and some people are afraid of
> "WebNFS-will-come-back-from-the-grave-to-have-it's-revenge"... :-)
> ... but yes, I'll quote that.
> 
>>> - This is NOT about WebNFS, this is only to use an URL representation
>>> to make the life of admins a LOT easier
>>> - Only absolute paths are supported
>>
>> This is actually a critical part of this proposal, IMO.
>>
>> RFC 2224 specifies two types of NFS URL: one that specifies an
>> absolute path, which is relative to the server's root FH, and
>> one that specifies a relative path, which is relative to the
>> server's PUB FH.
>>
>> You are adding support for only the absolute path style. This
>> means the URL is converted to string mount options by mount.nfs
>> and no code changes are needed in the kernel. There is no new
>> requirement for support of PUBFH.
> 
> Right, I know.

Some reviewers like to paraphrase to show their understanding --
basically if what I've repeated back to you doesn't reflect your
understanding, here your opportunity to say "No, it works this
way instead".


> And the code will reject any relative URLs ($ grep -r
> -F 'Relative nfs://-URLs are not supported.' #) ...

That is right and proper ;-)


>> I wonder how distributions will test the ability to mount
>> percent-escaped path names, though. Maybe not upstream's problem.
> 
> It's more an issue to generate the URLs, but any URL-encoding-web page
> can do that.
> I also have http://svn.nrubsig.org/svn/people/gisburn/scripts/nfsurlconv/nfsurlconv.ksh
> and other utilities, but that would be a seperate patch series.
> 
> DISCLAIMER: Yes, it's a ksh(93) script (because it needs multiline
> extended regular expressions, which bash does not have in that form),
> and putting that into nfs-utils will NOT cause a runtime dependency to
> /sbin/mount.nfs4 or somehow break DRACUT/initramfs. It's just a
> utility *script*.

That's fine. Testing components like this are generally packaged
so that they are not installed in resource-constrained environments
such as initramfs.


>>> - This feature will not be provided for NFSv3
>>
>> Why shouldn't mount.nfs also support using an NFS URL to mount an
>> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
>> negotiate down to NFSv3 if needed?
> 
> Two issues:
> 1. I consider NFSv2/NFSv3/NFSv4.0 as obsolete

NFSv2 is obsolete, yes.

The NFSv3 standard is not being updated, but NFSv3 is broadly
deployed and implementations are actively maintained. It's not
obsolete.

NFSv4.0 is on its way out, but is not obsolete yet. I don't
think it would be challenging to include support here.


> 2. It would be much more complex because we need to think about how to
> encode rpcbind&transport parameters, e.g. in cases of issues like
> custom rpcbind+mountd ports, and/or UDP.

This is much more than is needed, IMO. NFSv3 can stick with the
standard rpcbind port, an rpcbind query for MNT. My reading of
the RFCs suggests that for NFSv3, the transport protocol is
selected based on what both sides support.

I think we want to avoid trying to build every bell and whistle
into the mount.nfs NFS URL implementation. Just cover the basics,
at least in the initial implementation.


> That will quickly escalate
> and require lots of debates. We had that debate already in ~~2006 when
> I was at SUN Microsystems, and there was never a consensus on how to
> do nfs://-URLs for NFSv3 outside WebNFS.
> 
> I think it can be done, IMHO but this is way outside of the scope of
> this patch, which is mainly intended to fix some *URGENT* issues like
> paths with non-ASCII characters for the CJKV people and implement
> "hostport" notation (e.g. keep hostname+port in one string together).
> 
>> General comments:
>>
>> The white space below looks mangled. That needs to be fixed before
>> this patch can be applied.
> 
> Yes, I know, that is a problem that I only have the choice between
> GoogleMail or MS Outlook at work. That's why I provided kpaste.net
> links (https://nrubsig.kpaste.net/e8c5cb?raw and
> https://nrubsig.kpaste.net/e8c5cb). I'll try to set up git-imap-send
> in the future, but that needs time to convince our IT.
> 
> This should work for the v2 patch:
> ---- snip ----
> git clone git://git.linux-nfs.org/projects/steved/nfs-utils.git
> cd nfs-utils/
> wget 'https://nrubsig.kpaste.net/e8c5cb?raw'
> dos2unix e8c5cb\@raw
> patch -p1 --dry-run <e8c5cb\@raw
> patch -p1 <e8c5cb\@raw

Er. Well maybe. It's up to the nfs-utils maintainer whether he
wants to take a patch like that.

However, our email-based review workflow means that the actual
patch that every one has reviewed and signed off on is preserved
in a public mail archive (along with the Acks, Tested-bys and
Reviewed-bys).

We don't have that when someone posts a link to a temporary
paste bin.

Paste bin submissions are not scalable for the maintainer because
our tool chain is designed around taking an email submission and
applying it directly. Pulling from a paste bin is a lot of manual
work.

We all have the same struggles with our corporate IT departments.


> ---- snip ----
> 
>> IMO, man page updates are needed along with this code change.
> 
> Could we please move this to a separate patch set ?

That's up to the maintainer, but he usually requires adequate
documentation along with new features. It's too easy to submit
code changes and then put off the documentation for ever.


>> IMO, using a URL parser library might be better for us in the
>> long run (eg, more secure) than adding our own little
>> implementation. FedFS used liburiparser.
> 
> The liburiparser is a bit of an overkill, but I can look into it.

Here's the point of using a library:

A popular library implementation has been very well reviewed and is
used by a number of applications. That gives a high degree of confidence
that there are fewer bugs (in particular, security-related bugs). The
library might be actively maintained, and so we don't have to do that
work.

Something like liburiparser might be more than we need for this
particular job, but code re-use is pretty foundational. If liburiparser
isn't a good fit, look for something that is a better fit.


> I
> tried to keep it simple for ms-nfs41-client (see below), because
> otherwise I would've to deal with another DLL (which are far worse
> than any *.so issue I've seen on Solaris/Linux).
> 
> The current urlparser1.[ch] was written for OpenSolaris long ago, and
> then updated for the Windows ms-nfs41-client project (see
> https://github.com/kofemann/ms-nfs41-client/tree/master/mount ; almost
> the same code, except there are additions for wide-char streams and MS
> Visual Studio) and is being maintained for that and several in-house
> projects, so maintenance is guaranteed (that's why my manager (Marvin
> Wenzel) signed it off, too).

OK, but you're /copying/ this into nfs-utils. How will our copy get
updated over time? With an external library, bug fixes go to the library
and nfs-utils gets them automatically when it is re-linked.


> [snip]
>>> ---- snip ----
>>>   From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
>>> From: Roland Mainz <roland.mainz@nrubsig.org>
>>> Date: Fri, 6 Dec 2024 10:58:48 +0100
>>> Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs
>>>
>>> Add support for RFC 2224-style nfs://-URLs as alternative to the
>>> traditional hostname:/path+-o port=<tcp-port> notation,
>>> providing standardised, extensible, single-string, crossplatform,
>>> portable, Character-Encoding independent (e.g. mount point with
>>
>> As above: s/mount point/export path
> 
> OK
> 
> Anything else ?

You should expect review comments from others as well.


-- 
Chuck Lever

