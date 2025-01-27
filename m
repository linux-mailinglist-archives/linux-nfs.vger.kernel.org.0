Return-Path: <linux-nfs+bounces-9667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11FA1D7B9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F6E165BE1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F33FC7;
	Mon, 27 Jan 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKvWmfpF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t3E5g58k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053AC5672
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986787; cv=fail; b=aviE6e1FkFBUMyh+SDsXTLQiGB1JOUvFjBiRHsrAEkSTlHHAw+z/DYaR2fLYq1XJwlLLAt4kTmq0Tk8VJnH0AiT65/etyVdOnwxDPbKJQGidjOVx86brzmviTqlihotkoTcMqRq0W2oKHv7HkVJaflPP5L7mNU/HMDdgFAXig24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986787; c=relaxed/simple;
	bh=aTBSCGGREnhr2m/0rnc0UGSk5nwcHBSf/4I0mUvTJRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MG8e8UjsQr7OFVCs1T4ifGM6uy2nFMT+YdZ9q+kycvY3v+SZX+3ylGMfmtGo/BdCIEK+Kev5MgQBpX3s2QQxWBB5QpF3CJpfkHPoHhhaYRSKvEmKmZlDwk9vgqty0xWys09lR4cBq5h3X8rkN8GTtvBV5V5ilFRBc5S4bSbaciA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKvWmfpF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t3E5g58k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RCc0nW030092;
	Mon, 27 Jan 2025 14:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vs1+NyVjB5x8JIkTScf6nVZnUkoSzkgcuBr9kj90TUs=; b=
	gKvWmfpFHQyccW3qnuBl7mt2RkC9nNZgPJcA8qoVe9csUOrVuZlcu2DjzQseFgnV
	zVe3h1talR4ch2Eiv4gweppLa1RK0kLK/oSRjmC+3ir8awHtaMnyf9KYBNzm7WFg
	YASs46ia4ehbZhkuNfKusYXTdkM0HyF/0x5YbqPEj+rgpnEzc+JonDK8S/ZeeljM
	vWkdgjarwRw+l6xg/eHnmLtOdBvMaLZmZTPlcjyWIpeWfA88SLwJhR1LgpXVrguL
	FLpU2NYb1oGh5ejnAxehXoFl3wDI6uLqIdB2XvFbI0sCgoqOSyqYYRztJgdrz06r
	NxRPUZU3vu9r4EuRdURcdw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44eaa4r4t5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:06:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDXghh034174;
	Mon, 27 Jan 2025 13:57:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6ynn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0HRzBL/R0Ncpb2tfhYfkw4LZs4iM6r+AUZh8R2m6osqDVw2Kd8ckKs25DGUUnz+f2tA/0o7XqTJ49Vh9QGg7iOrVJ9v1mxI2lUbM8dSzJOgSA4Ew3LFfA1jQnBSxSKxam0tAFrVJ9PFNrpjX7seqKSsjj4cO+4U3Su8R4kLgy1aTWSU92Rgb1Ws0Uvs2SHbJ/Sx8yiaP0JepO/+ZKTRlSdQ/t6w5z7n/MCfLKW+w80tKYFP5TjZ/q9HdoxJRSdWTK9pBuF4vDD8yDMiWPeRhtVSj/b77t9fNdZXJD9BOOskD76Dp9DhYA+yyl1MVD0vE396O3x8XIthRjS6tCPWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs1+NyVjB5x8JIkTScf6nVZnUkoSzkgcuBr9kj90TUs=;
 b=hH2NIMsNdAyByKbYpf7mJI0R5Z5lyHr/+TluMnSvEtBgruHM5sF9U66JQA8875l/ZAJX6y6PxIOvrHbEbuJe4yORYuwp2u9apRMkzaajknO8zBoX9YXcAam2hkwcHxeIRTzcjrr0l9L0bSFb464YtUaWWfG4lnPSEMCFbPX43hj80iRlGKmhdd7J/6Ra1+PLYgXz8KwoNBxOy2s9+qw5g5To82+cdw7oo6CfA7kQ1NXRcwztXWusnn53dHzQkEEquDdE2SqKvfMgKcEFV/YEKWRU98DLGog3LfMJtuI6K1+dSl7VV1tGAMUiwSEWWt3LahErRCZcA+idzvP1Gk85Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs1+NyVjB5x8JIkTScf6nVZnUkoSzkgcuBr9kj90TUs=;
 b=t3E5g58kl4WpHawTQd/adCVDqeyALTFM5dgGgr+Jl+2sU1NMx07VDKtCKedINHqY/R5xXE4CLOvT3QE8XwnE+K4DiayrATF89hfot6N8rsvVQGsWaTR1dG7l1jY+k/cigPt5cpW/q+TKiELjv5ux5NRkPy76XISlbGY68CIql5s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8177.namprd10.prod.outlook.com (2603:10b6:408:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 13:57:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:57:54 +0000
Message-ID: <8f8b6c70-b920-456a-adbc-7a5f54046a50@oracle.com>
Date: Mon, 27 Jan 2025 08:57:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <> <a961b220-75be-4ada-b548-a87f24566f92@oracle.com>
 <173795089343.22054.10342559407773805390@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173795089343.22054.10342559407773805390@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:610:77::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7efeb3-1e0f-4e21-abe5-08dd3eda98bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUVQeGpWMnBnaHdFVGtPVDhtVCt3ZFkwNmxFZjBLU1cxS0wxRkVjU0VTMVBC?=
 =?utf-8?B?NC95MW5TbSthSWFnd2g5V083ZWVCVlhGZDFCWUxzV2UyRFArT2dlK0JJZnhi?=
 =?utf-8?B?MG9CaFZUSVBjbWFydVRLaHNLMEhVNDZMODFKa1Rtc0FoOGYxaGhlN0N2VWNw?=
 =?utf-8?B?cFdidHpJa3dKVGxXU0FYWDVTWkZBNmVLUDhrem4wSFp2RS9YdzU3UTY4NHFh?=
 =?utf-8?B?SGJpV3NxTjlyUS8zc2ZybkY1MjhMS01yKytDL05UN3FEQWlodzZUbzNaTTZC?=
 =?utf-8?B?VkFObzAzOGhLdnlHVDZCN0tTeUhkV2V1YllsVEdFNmo3ZG9GaHRHSTdRdlBW?=
 =?utf-8?B?OWZ0c2l0d01JNFp6a1ZLL2VMeW43SXdtVEVkbHNpV1RtdmRhcGdKVTRPeTU5?=
 =?utf-8?B?Q0RTS1NycHFOTmJicG1yNXhMa05vcUQyVS9oVi8reDBud3grMkhzMm00WmJp?=
 =?utf-8?B?bzFZVmNpNHhaSVRTbERKMzVJYlczVFI1TVQ3OFp3L054QXVGY1I2Vm1rVGc0?=
 =?utf-8?B?cnRHcHNxMzY0ZXBmeDg3NXJYRGxwQ2hSQ2NFVFZvNkZTQUFkZWVaTXZpRUtE?=
 =?utf-8?B?UW1uMEdwQUVIU3lvNmhib21tRlBsa1hoU09kZEd4WkxjVmZVWDRSL3BEenAz?=
 =?utf-8?B?NDJRT1M0ZUdnMDZ0REdobUd1WEJ5VjNyVkdKVG95dUs5UjN5QWlTY25nM1dF?=
 =?utf-8?B?b1lRajhlWVNDa1RFenBwUnZnRkFyN0wxTjdOSmJpM3FQYVYvZ2pIdU1xZTRH?=
 =?utf-8?B?end3KzV2d2FBeUliOWUrdmJMWGw2S3pEdHhyREJ3cjkwM3ZqSC9GZUk1Uzlu?=
 =?utf-8?B?eGQrSmxLYmVxQ2xiYkIyYit1dnpUMlhrOWQyVzlwUTN3Y0ppYXpZQ1Q5ek5m?=
 =?utf-8?B?QzZhK3VJYVlQc0lLYzRaVWN1T0RwaFNJWW9UYVZRZWhyYWh5OCs0THEyUXpM?=
 =?utf-8?B?K1FiaWJGWFlxenhZNmVrVmVtOGtFM1E1VnVZbFpYUFJsQTVqdG1ZRWtDeCtG?=
 =?utf-8?B?bENQbjB5QUQvbVBvWWN3VTdMbG1zWW1vS1ZNa3MvZjdnWFczUTNnZVZMNjFG?=
 =?utf-8?B?WU56RGUvVkR6NVhwV2tYdDRQdGlGOEVvWnA3Q25mYnVEeGJMYXI3Z2t0aEww?=
 =?utf-8?B?QWc3enJoa0ZuMWFVR0RZMTg0UjdYa0syQ2ZmWDhDRmpvUXZUaHdpS2QxWWgr?=
 =?utf-8?B?T2E3anhMb1pFZGN4cTdEZHlPcnV2eVM5d2NxOVlKbCt5UXpFVDdCQ2VmREdZ?=
 =?utf-8?B?Tm5pa3c2OCtqbHJ4YjdJSjdTek13ak4xR0dKU1NjWHBnN3didG5BRmtkNHgz?=
 =?utf-8?B?dWFjeERHSXVuOGx3NENacVMzRkVIcURWSHlKaUtRVXpLYlF5Y201ZkxVa3h3?=
 =?utf-8?B?OTVKOXI0UnM3dFFReW55akZsTTdBY2dtZEhlZVFtSmdWMmE2VGtRbXh5TDk0?=
 =?utf-8?B?K3RNbzhRUXNYQ28vNnNGL3FjdkUyL3dxcDFGS3N2ODNyV2N2VDU1a0VvSDhN?=
 =?utf-8?B?a3c5TmxlYW91UlhyMit3ZmdpeER6U2VBMGRpbFJubWdXaHlOL2ZpbC9EdzNt?=
 =?utf-8?B?UVBINDhsZFFpWTdua2U0ayt1UEtPVWUxeElJaWt4UFNOMjlmQ0tBS0MxN3dP?=
 =?utf-8?B?UjVBaDhjTEx3U3pneHo4ZVdsUlc2RHgrbUFtcU1WOTU0bXFxWGU2bWdKMWdO?=
 =?utf-8?B?VS9oZG92VVJjMkZmcHJNYk9sajkvZTBDWWRZZGh1dlhVaThRQTZHd3RDWW5C?=
 =?utf-8?B?T3ZPcGNaVCtJYzVVVy9BK3hRYmo3eGdlRFY3Y0plMXhRZmV4ekxGa3crRmRm?=
 =?utf-8?B?UWhWdkdhWDJkODU2SXU0Y1Zwc3AwQzl0VFEwTklKWThkMXd2VmhLdmVqUDhZ?=
 =?utf-8?Q?Vr7SfZOBXniwX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXVOamtIMkM5SGs2VEtpbUxKdmJWYUNhVkM3QjVvdDh5Y1VBcHduSm1wQ05P?=
 =?utf-8?B?N2RjbVdhT0FldGZmV1JIWVVaWmxxUHg5a1ZvcHpUTTJ4dnZrbU50cjV3azlO?=
 =?utf-8?B?R1lZN2tuQWJxdkdKc3d6dFdVcktNaldRNmtzQkY2eGptcVdOaXU4dXZuZXVB?=
 =?utf-8?B?Sm13OG93clZDMlQrVGpyNk9lOGtJNU9KTmlLN0FhdTJPZldpQklydUM0ZWZS?=
 =?utf-8?B?NGw1UWlEZTR3cDVpcHYxcE0ybmJ5UElXaUpHTVFFejR1djRxSE43M1pma3ht?=
 =?utf-8?B?Z2RORzFVRytlOTlqTGtyczV2QTl1cG5ZQjNqeVozNTMxZU1aRHdseG5aUmF5?=
 =?utf-8?B?eGlHdXdUbE1VUDc5ck5VcGh6eS9tcVd1MUFOZFczbUZkb2MxR0ZrYm9IdW5S?=
 =?utf-8?B?d2dqZ1JUaDcycXl2SnF0bXkwU0wzV3FRYTJnWTdGeTltSUJZWEd2ZVRhL1dR?=
 =?utf-8?B?akNEakpZS1V2cWtGc1lCUWw5YURKb1hqK0g0WTlPZjVNT21uYnVCTWkzaVQx?=
 =?utf-8?B?ZXIzRGFwQ2N1TC9MUFhFNERtMkhSbW1YNEh0Y3FYbjZsZ29SMUh5QTJuOHkv?=
 =?utf-8?B?cFZHTEYxcG5jclBCWW1RZ2pvNFB0a1lTSnB6QlM1cGtaSGxNbWRkVVduMFZj?=
 =?utf-8?B?N1UxWjJ1TVcxYW9YOHdyQ0dTbEtMT2NNS0xaY0QwZCtMSXZzd0VoeWtsdVQv?=
 =?utf-8?B?bkVjMHN5S2luUGE4YWVqcUR3N2RJb29rVmVIeFJKdE9yVzN1WEJvcytITjZB?=
 =?utf-8?B?cDdYQWEwV3p5dlRabzc5TUZ5RTk3eEJtd3BLTXdhTUViMTFCcWlHTU5FdnJv?=
 =?utf-8?B?SzZ2aWtSUTg2SGxaNEZDWmttL2JZVGcxT2NDclptaENoUzZhWjNIWlIyUE5D?=
 =?utf-8?B?YWptL2J5bHpxb1l4MDZkSnlzVkVCV1R0R2loNnhMYWVDNHprWktFMWFJTkRT?=
 =?utf-8?B?bDhzeFMwYUE5OEZESlo5ZGdEajk2NG9OZWI2cEpyTjZzQXczZmExZDdhbUNF?=
 =?utf-8?B?RGtuQkREQTB6WU04NjB4S0FtbnhsK1hxMFBGdzV2elRkYWRMOGFzWWhxTzUw?=
 =?utf-8?B?TGNQYUtyQm9DQ2c4aytwbVlXeVUwdGY0U3BZUC9Nd09YU09rNUM3YzRBcm40?=
 =?utf-8?B?VzVyZVQ1Y3pnSVI2S0o2MWhzamdpbmR5UlRsaXNpSFhtWVAvNURwSWFCVWRB?=
 =?utf-8?B?eTdyRVUzMXVhMC9oOEVTazRuanpiekhpd2haZ3A2cSt3ZzEzTklCYlpiZWZD?=
 =?utf-8?B?MlBGSk9HNDBKd051d21maTloeXFWNjFOci9HSDkvbnNiaisrOG5vNHZ0QVJj?=
 =?utf-8?B?MGdpVDhCRVJqQy92Z1RPaDc3ZmUvNW1ZV0JkaTNOZFlqUmhCVGZGTWhIZ1pD?=
 =?utf-8?B?Vmd5b210NmdnMzREOWN4MTVhY1hQSnQ0eXhQZytVL1N3d1FKZlZiVDIycklN?=
 =?utf-8?B?TmZFSXFRMjU2RWYzaGU5S0ZNSFJDVXZtdVRqRWQrdEVMelBIUE4raGlBVUFl?=
 =?utf-8?B?Yi93cWpJRUNETERIbjUxeDd6VHFJQW91RWRRWHRpbHRxS0NHd1dKZElQU25w?=
 =?utf-8?B?N05SUG40SnhnNEMxcndKQ2lmM2dreTBVcktzRHUzelFlNXFYY2l4VjNrWW4r?=
 =?utf-8?B?YkMraFd5SWlCQWxqOC9YblBvSUUzdlJwYjZ5VUVxbEVrU0lodENhRlI2Mmgw?=
 =?utf-8?B?alFzUVUwSWlyV1Qra1ZHZVVXUTkzalpsdDJmMmJEeE5hazY0UjVsUnMzdzJX?=
 =?utf-8?B?Mk9qQjM4eFcreWhSbjY2SGdKT0w0azdwUEl0TjBGT1doNDl4M2JNOGo2TUVU?=
 =?utf-8?B?L045dVpodzBId3FLTEZYYmEyRFRwQWF6UHdVNGZsQW1ReEVuamwrM0xQZ0c0?=
 =?utf-8?B?cWFJbHhHeFBKU1dUZ3k1ZE5ZeFdpOWVIcWczYkUwa3ZiYlhrTGxuZFpEZDQ3?=
 =?utf-8?B?Mlg1Ri9ZdXdLZGQvQm9vWk5GSE9wNnJaVGxoRkxjNTZaS0dLdEVnVmZSa2xK?=
 =?utf-8?B?ZVQyYzdHd1o3V1ZlTE1ZRFZUM1JQSjlSQm1lY0FacWkrZmNOTCtJVFNMYng5?=
 =?utf-8?B?VmVoanZIL3h2T0owQlBaS2V0K1lLczEwMVVXaVROY1Z0c090NjBXREFHa3dC?=
 =?utf-8?B?VFVVQ2pESTBkVUFMcFM0MlhqSGQwY2hQclVvSDYwZGpHcVRDV0xHSWU5aXha?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	70skmQkyNLYgBPbTKlUWZaaHyVzgYz71Ou1eTVp3e1SleRxgnKjguSpNdklKHnMZoZtOQ52D4r2Ds2kiKEwAclDsw88oTmMdbXq/pbg6lm5gWh80kZasBM+f37lkCVcI3bUKefpwc+o/KE3zToAmnRJ8HCi1oz+ZCsdTMfm6X/lyLwocTjc+e5QY+e7nmnPq03Fn1nUjb+99O9FzEOi99eEIbQbyMxwCBuw104tg57QLqstAr5QS8xglW8TuXZzKuZi32aCf2THRzny01Ai0X715yUpGnEc56OCYe63SVsD6fDSxgL3a/Qaiz7Hvc+GxB5NHKhFHDrpgHD6xdMAHvCNFraSMwkeZCTOdUmTdsuU8LlMWj+VbVHWATY7tdca/6FFL9ukHo7Ju44R1sXYU2xUhbOvTh9lDVqaVTZhI/2/d7rqKwnRhsD5T704o4lVb9FlnWOpRG4tUhzgyJCq7syiFV+ZQg1VfijZupt70axz1LiFi379DPtEvDH3qnp7W3W/f48X+n11vFvm2aAzuENldVpy+BBZgzMzzd6c1GohmilqdvsC/YeBAmdyqWMGyK0VFFCZbz0ob8l+B4OTM/iZmxLtPH2ffaAN4JqwKLsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7efeb3-1e0f-4e21-abe5-08dd3eda98bd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:57:54.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHwxF08oHxNu5F9U3vSu/DHazUlYf/E/wcZ1g/8CXB/x/W0kFiBPg77GDaG/is8a6H824b1e9ndYfp5xMyBOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270112
X-Proofpoint-GUID: QKOvdt5FSP_JVXC7OuFNy_UWstqHApbE
X-Proofpoint-ORIG-GUID: QKOvdt5FSP_JVXC7OuFNy_UWstqHApbE

On 1/26/25 11:08 PM, NeilBrown wrote:
> On Sun, 19 Jan 2025, Chuck Lever wrote:
>> On 12/11/24 4:47 PM, NeilBrown wrote:
>>> Reducing the number of slots in the session slot table requires
>>> confirmation from the client.  This patch adds reduce_session_slots()
>>> which starts the process of getting confirmation, but never calls it.
>>> That will come in a later patch.
>>>
>>> Before we can free a slot we need to confirm that the client won't try
>>> to use it again.  This involves returning a lower cr_maxrequests in a
>>> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
>>> is not larger than we limit we are trying to impose.  So for each slot
>>> we need to remember that we have sent a reduced cr_maxrequests.
>>>
>>> To achieve this we introduce a concept of request "generations".  Each
>>> time we decide to reduce cr_maxrequests we increment the generation
>>> number, and record this when we return the lower cr_maxrequests to the
>>> client.  When a slot with the current generation reports a low
>>> ca_maxrequests, we commit to that level and free extra slots.
>>>
>>> We use an 16 bit generation number (64 seems wasteful) and if it cycles
>>> we iterate all slots and reset the generation number to avoid false matches.
>>>
>>> When we free a slot we store the seqid in the slot pointer so that it can
>>> be restored when we reactivate the slot.  The RFC can be read as
>>> suggesting that the slot number could restart from one after a slot is
>>> retired and reactivated, but also suggests that retiring slots is not
>>> required.  So when we reactive a slot we accept with the next seqid in
>>> sequence, or 1.
>>>
>>> When decoding sa_highest_slotid into maxslots we need to add 1 - this
>>> matches how it is encoded for the reply.
>>>
>>> se_dead is moved in struct nfsd4_session to remove a hole.
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>    fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++-----
>>>    fs/nfsd/nfs4xdr.c   |  5 ++-
>>>    fs/nfsd/state.h     |  6 ++-
>>>    fs/nfsd/xdr4.h      |  2 -
>>>    4 files changed, 92 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index fd9473d487f3..a2d1f97b8a0e 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1910,17 +1910,69 @@ gen_sessionid(struct nfsd4_session *ses)
>>>    #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>>>    
>>>    static void
>>> -free_session_slots(struct nfsd4_session *ses)
>>> +free_session_slots(struct nfsd4_session *ses, int from)
>>>    {
>>>    	int i;
>>>    
>>> -	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
>>> +	if (from >= ses->se_fchannel.maxreqs)
>>> +		return;
>>> +
>>> +	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
>>>    		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>>>    
>>> -		xa_erase(&ses->se_slots, i);
>>> +		/*
>>> +		 * Save the seqid in case we reactivate this slot.
>>> +		 * This will never require a memory allocation so GFP
>>> +		 * flag is irrelevant
>>> +		 */
>>> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
>>>    		free_svc_cred(&slot->sl_cred);
>>>    		kfree(slot);
>>>    	}
>>> +	ses->se_fchannel.maxreqs = from;
>>> +	if (ses->se_target_maxslots > from)
>>> +		ses->se_target_maxslots = from;
>>> +}
>>> +
>>> +/**
>>> + * reduce_session_slots - reduce the target max-slots of a session if possible
>>> + * @ses:  The session to affect
>>> + * @dec:  how much to decrease the target by
>>> + *
>>> + * This interface can be used by a shrinker to reduce the target max-slots
>>> + * for a session so that some slots can eventually be freed.
>>> + * It uses spin_trylock() as it may be called in a context where another
>>> + * spinlock is held that has a dependency on client_lock.  As shrinkers are
>>> + * best-effort, skiping a session is client_lock is already held has no
>>> + * great coast
>>> + *
>>> + * Return value:
>>> + *   The number of slots that the target was reduced by.
>>> + */
>>> +static int __maybe_unused
>>> +reduce_session_slots(struct nfsd4_session *ses, int dec)
>>> +{
>>> +	struct nfsd_net *nn = net_generic(ses->se_client->net,
>>> +					  nfsd_net_id);
>>> +	int ret = 0;
>>> +
>>> +	if (ses->se_target_maxslots <= 1)
>>> +		return ret;
>>> +	if (!spin_trylock(&nn->client_lock))
>>> +		return ret;
>>> +	ret = min(dec, ses->se_target_maxslots-1);
>>> +	ses->se_target_maxslots -= ret;
>>> +	ses->se_slot_gen += 1;
>>> +	if (ses->se_slot_gen == 0) {
>>> +		int i;
>>> +		ses->se_slot_gen = 1;
>>> +		for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
>>> +			struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>>> +			slot->sl_generation = 0;
>>> +		}
>>> +	}
>>> +	spin_unlock(&nn->client_lock);
>>> +	return ret;
>>>    }
>>>    
>>>    /*
>>> @@ -1968,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>>>    	}
>>>    	fattrs->maxreqs = i;
>>>    	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>>> +	new->se_target_maxslots = i;
>>>    	new->se_cb_slot_avail = ~0U;
>>>    	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>>>    				      NFSD_BC_SLOT_TABLE_SIZE - 1);
>>> @@ -2081,7 +2134,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
>>>    
>>>    static void __free_session(struct nfsd4_session *ses)
>>>    {
>>> -	free_session_slots(ses);
>>> +	free_session_slots(ses, 0);
>>>    	xa_destroy(&ses->se_slots);
>>>    	kfree(ses);
>>>    }
>>> @@ -2684,6 +2737,9 @@ static int client_info_show(struct seq_file *m, void *v)
>>>    	seq_printf(m, "session slots:");
>>>    	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>>>    		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
>>> +	seq_printf(m, "\nsession target slots:");
>>> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>>> +		seq_printf(m, " %u", ses->se_target_maxslots);
>>>    	spin_unlock(&clp->cl_lock);
>>>    	seq_puts(m, "\n");
>>>    
>>> @@ -3674,10 +3730,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
>>>    	kfree(exid->server_impl_name);
>>>    }
>>>    
>>> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>>> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
>>>    {
>>>    	/* The slot is in use, and no response has been sent. */
>>> -	if (slot_inuse) {
>>> +	if (flags & NFSD4_SLOT_INUSE) {
>>>    		if (seqid == slot_seqid)
>>>    			return nfserr_jukebox;
>>>    		else
>>> @@ -3686,6 +3742,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>>>    	/* Note unsigned 32-bit arithmetic handles wraparound: */
>>>    	if (likely(seqid == slot_seqid + 1))
>>>    		return nfs_ok;
>>> +	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
>>> +		return nfs_ok;
>>>    	if (seqid == slot_seqid)
>>>    		return nfserr_replay_cache;
>>>    	return nfserr_seq_misordered;
>>> @@ -4236,8 +4294,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>>>    
>>>    	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>>> -	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
>>> -					slot->sl_flags & NFSD4_SLOT_INUSE);
>>> +	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>>>    	if (status == nfserr_replay_cache) {
>>>    		status = nfserr_seq_misordered;
>>>    		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
>>> @@ -4262,6 +4319,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	if (status)
>>>    		goto out_put_session;
>>>    
>>> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
>>> +	    slot->sl_generation == session->se_slot_gen &&
>>> +	    seq->maxslots <= session->se_target_maxslots)
>>> +		/* Client acknowledged our reduce maxreqs */
>>> +		free_session_slots(session, session->se_target_maxslots);
>>> +
>>>    	buflen = (seq->cachethis) ?
>>>    			session->se_fchannel.maxresp_cached :
>>>    			session->se_fchannel.maxresp_sz;
>>> @@ -4272,9 +4335,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	svc_reserve(rqstp, buflen);
>>>    
>>>    	status = nfs_ok;
>>> -	/* Success! bump slot seqid */
>>> +	/* Success! accept new slot seqid */
>>>    	slot->sl_seqid = seq->seqid;
>>> +	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
>>>    	slot->sl_flags |= NFSD4_SLOT_INUSE;
>>> +	slot->sl_generation = session->se_slot_gen;
>>>    	if (seq->cachethis)
>>>    		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
>>>    	else
>>> @@ -4291,9 +4356,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	 * the client might use.
>>>    	 */
>>>    	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
>>> +	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
>>>    	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
>>>    		int s = session->se_fchannel.maxreqs;
>>>    		int cnt = DIV_ROUND_UP(s, 5);
>>> +		void *prev_slot;
>>>    
>>>    		do {
>>>    			/*
>>> @@ -4303,18 +4370,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    			 */
>>>    			slot = kzalloc(slot_bytes(&session->se_fchannel),
>>>    				       GFP_NOWAIT);
>>> +			prev_slot = xa_load(&session->se_slots, s);
>>> +			if (xa_is_value(prev_slot) && slot) {
>>> +				slot->sl_seqid = xa_to_value(prev_slot);
>>> +				slot->sl_flags |= NFSD4_SLOT_REUSED;
>>> +			}
>>>    			if (slot &&
>>>    			    !xa_is_err(xa_store(&session->se_slots, s, slot,
>>>    						GFP_NOWAIT))) {
>>>    				s += 1;
>>>    				session->se_fchannel.maxreqs = s;
>>> +				session->se_target_maxslots = s;
>>>    			} else {
>>>    				kfree(slot);
>>>    				slot = NULL;
>>>    			}
>>>    		} while (slot && --cnt > 0);
>>>    	}
>>> -	seq->maxslots = session->se_fchannel.maxreqs;
>>> +	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
>>> +	seq->target_maxslots = session->se_target_maxslots;
>>>    
>>>    out:
>>>    	switch (clp->cl_cb_state) {
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 53fac037611c..4dcb03cd9292 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
>>>    		return nfserr_bad_xdr;
>>>    	seq->seqid = be32_to_cpup(p++);
>>>    	seq->slotid = be32_to_cpup(p++);
>>> -	seq->maxslots = be32_to_cpup(p++);
>>> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
>>> +	seq->maxslots = be32_to_cpup(p++) + 1;
>>>    	seq->cachethis = be32_to_cpup(p);
>>>    
>>>    	seq->status_flags = 0;
>>> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>    	if (nfserr != nfs_ok)
>>>    		return nfserr;
>>>    	/* sr_target_highest_slotid */
>>> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
>>> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>>>    	if (nfserr != nfs_ok)
>>>    		return nfserr;
>>>    	/* sr_status_flags */
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index aad547d3ad8b..4251ff3c5ad1 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -245,10 +245,12 @@ struct nfsd4_slot {
>>>    	struct svc_cred sl_cred;
>>>    	u32	sl_datalen;
>>>    	u16	sl_opcnt;
>>> +	u16	sl_generation;
>>>    #define NFSD4_SLOT_INUSE	(1 << 0)
>>>    #define NFSD4_SLOT_CACHETHIS	(1 << 1)
>>>    #define NFSD4_SLOT_INITIALIZED	(1 << 2)
>>>    #define NFSD4_SLOT_CACHED	(1 << 3)
>>> +#define NFSD4_SLOT_REUSED	(1 << 4)
>>>    	u8	sl_flags;
>>>    	char	sl_data[];
>>>    };
>>> @@ -321,7 +323,6 @@ struct nfsd4_session {
>>>    	u32			se_cb_slot_avail; /* bitmap of available slots */
>>>    	u32			se_cb_highest_slot;	/* highest slot client wants */
>>>    	u32			se_cb_prog;
>>> -	bool			se_dead;
>>>    	struct list_head	se_hash;	/* hash by sessionid */
>>>    	struct list_head	se_perclnt;
>>>    	struct nfs4_client	*se_client;
>>> @@ -331,6 +332,9 @@ struct nfsd4_session {
>>>    	struct list_head	se_conns;
>>>    	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
>>>    	struct xarray		se_slots;	/* forward channel slots */
>>> +	u16			se_slot_gen;
>>> +	bool			se_dead;
>>> +	u32			se_target_maxslots;
>>>    };
>>>    
>>>    /* formatted contents of nfs4_sessionid */
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index 382cc1389396..c26ba86dbdfd 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
>>>    	u32			slotid;			/* request/response */
>>>    	u32			maxslots;		/* request/response */
>>>    	u32			cachethis;		/* request */
>>> -#if 0
>>>    	u32			target_maxslots;	/* response */
>>> -#endif /* not yet */
>>>    	u32			status_flags;		/* response */
>>>    };
>>>    
>>
>> Hi Neil -
>>
>> I've found some misbehavior which I've bisected to this commit.
> 
> Hi Chuck,
>   could you please confirm that it really was this commit that you
>   bisected to?  Not the next one?

It's this one. I included the hunk that introduces the misbehavior
below. It's when the server starts returning a different value for
target_highest_slotid in the SEQUENCE result. The target_highest
is 63 -- the number the server has in its slot table. The maxslots
value is smaller.

In the working case, these two values never differ.


>   Because this commit never reduces ->se_target_maxslots, so the
>   patch which you say removed the symptom should be a no-op.

It's not the reducing of target_highest that's the problem. Rather
it's that the target_highest and max in-use slot IDs are different
values for a brief period after a reconnect.

That triggers the client to think that the server has reduced its
slot table size, so the client shrinks its slot table. The server has
not actually shrunken it, however, so it continues to expect the client
to use the large slot sequence numbers for those slots.

When the client starts to use one of those slots again, it uses a
sequence number of 1, and that fails.


>   Even if it was the next commit I'm struggling to pin down the
>   problem.  Here is my current analysis - partly to ensure I can present
>   it clearly.
> 
>   The evidence suggests that the client has retired a slot that the
>   server hasn't.  This happens when nfs41_set_server_slotid_locked()
>   calls nfsd4_shrink_slot_table(), and nothing will happen if any slots
>   before the new limit are still in use.  If the server reduces
>   its idea of the target when the client isn't even using that many,
>   the slots can be freed immediately that the client gets a reply
>   indicating the new highest_slot number from the server.
> 
>   The server will not free these slots immediately but will wait to get a
>   confirmation from the client that it has accepted the new limit.  But,
>   importantly, the server will not increase the limit that it sends to
>   the client until after it has has a chance to free the retired slots.
>   If the server doesn't increase the limit, then the client won't try to
>   use the retired slots...
> 
>   Do you still have the network trace which chows the error?  Would I be
>   able to look at it?

Sending via WeTransfer.

But also, it's easy enough to reproduce.

Build your server with CONFIG_FAIL_SUNRPC set. Reboot into the new
kernel.

Before each test, run this script on the server:

#!/usr/bin/bash

cd /sys/kernel/debug/fail_sunrpc/

echo Y > ignore-cache-wait
echo Y > ignore-client-disconnect
echo 24847 > interval
echo 97 > times
echo 100 > probability

exit 0

On the client, run fstests with an NFSv4.1 mount. It will usually hang
within the first 15 tests.


>> If disconnect injection is set up to break the connection every 25,000
>> RPCs or so, xfstests running on an NFSv4.1 mount will eventually stall
>> after this commit is applied.
>>
>> Network capture shows that the server eventually starts returning
>> SEQ_MISORDERED because the client has forgotten an retired slot after a
>> disconnect, and tries to use sequence number 1 for that slot with a new
>> operation.
>>
>> I've narrowed the issue down to nfs41_is_outlier_target_slotid() on the
>> client. This function uses a bit of calculus to decide when to bump the
>> slot table's generation number. In the failing case, it never bumps the
>> generation, and that results in the client freeing slots it shouldn't.
>> The server's reported { highest, target_highest } slot numbers don't
>> appear to change correctly after the client has reconnected.
>>
>> If I revert this hunk from 5/6:
>>
>> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres
>> *resp, __be32 nfserr,
>>    	if (nfserr != nfs_ok)
>>    		return nfserr;
>>    	/* sr_target_highest_slotid */
>> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
>> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>>    	if (nfserr != nfs_ok)
>>    		return nfserr;
>>    	/* sr_status_flags */
>>
>> the reproducer above runs to completion in the expected amount of time.
>>
>>
>> The high order bit here is whether I should drop these patches for
>> v6.14, or whether you believe you can come up with a narrow solution
>> during the early part of v6.14-rc that I can include in an -rc update
>> for NFSD. I can't really tell if a significant amount of surgery will
>> be necessary.
>>
>> What do you think?
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

