Return-Path: <linux-nfs+bounces-9576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B4A1B7A1
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D116C7EC
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE083CD2;
	Fri, 24 Jan 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LTzCMaYI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NvMwX04c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F37C6E6
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727903; cv=fail; b=RbMK8rJWJCdt6cL3KBlSvorph1/o/n4v61rZ3Ip0KPOXtGgPRQ2VL4yC6VEItdGHNgm/Hdac1MGeuvl+1j30AsHw7Jsaw0Rs8uaeJrO4b7/3MIhoGLEBJ7hzELLQb1ehScwksihCnMYVSgjVAdIKWNhz08sNx2DIPBIEqCwTcs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727903; c=relaxed/simple;
	bh=xFGgrpGWMq/zGGIMZSVW2sT/ymiVejA6cTI8rcheYW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ht8MvHy5d/4t3ePGlE/qI1Tcb1wDw01I5Jlm88/5zBLJRhuhwlCAe/1gb/OgiNZCo6H78aQsZm3DDAr9fSSowYKtuOxoUD0D6OyaQ+25y4xkzI0fj4plhMfbBVSzjLz58jNl6qj99YC2/fGS1yVT+i/BJMhfssqBVJvkEB0LA44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LTzCMaYI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NvMwX04c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8g17Z032554;
	Fri, 24 Jan 2025 14:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vfZCQhDeGNumS3HJiV4tuZM6/HzzJWk2FJn+Sm1W5fc=; b=
	LTzCMaYIp+yoSqnUdJLN2JbjPZKH+W9yp8FEy3T11QvzAIpG5VKi3YhSuczxd+7f
	3dcSIBb7YUZ8v9qFC5d4wUDFkMY4vkBXAcYvtxECEIFqGAMxM6F0igBrzKfckjY8
	3SANz0mwOCh1clFKLfaMX8S9kJhqHjihU2lT/lOvltHsR5rJBNmCwacEUGpWh8dg
	LQgHBvKzyct4Wu07sM4uNlxUbasj+9QbZ6EWD9RMo4D7kb1vStv5lLJgOKz3fMlf
	94VyURe/CFDXVVAGRyBDGEnnyUc/MXDDHgu611DBnCzf1fD6kqL1E/0RiKmF0LHM
	c5sZ5IKPml0VwAGIntYAqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b06j4hy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:11:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OCNMPK019522;
	Fri, 24 Jan 2025 14:11:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c6c5f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlaY96KXcHWu5tgtKC5F+abHFDUhs8VyWISavjgstv97A0Mwjn3gs2lFc9OYrK5I57sLcz8g/CZP+eZ2pxMiN/AfWkWHM7dpQOGuf8sxBVPeKK4NGEfGYydgDSClWaqdduXP/3SoebvZ1DOySOiIsAxYFF4YWnL9r84rH3Ry6UjoCTwORlhNdZKeLggulk7UxmmuBzBXwtk5FfNfhgyJCEqpDKDYRoRK1/0jkVBmKOk2tnbATkeRbAegLCFcTWUlhBXQS6y/TtEkR/zW6nDgaM99/6FbPSHjlXiNw6AMcauasc1qa3yoU61/ujjB7AkQGmTkkHNKq8ruFPiR4jGs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfZCQhDeGNumS3HJiV4tuZM6/HzzJWk2FJn+Sm1W5fc=;
 b=XtdOeKWKh8IICefzdcsknbyHusHWRcYW5Ez9bIVCKLzx38aXIiKl82JIu+RMYSzyrQ8EKEqjYavtmlIMz6g11lQOeqsW58g4O/lhlJmTxGLcZMfcn98EdbnagiPA4Xz6bH1p3GU3CpXVyrGC3HEyYgWLC/wAakuaA5wzvLKIPXviBIFgZ6W3PQ4N6fwGAqUdgMjTaBK40Fv5smuwb0QyTMnRa7HJCrDl1XEtTeUdVpw+91kdLLm0lUipx5grjQsWuT5xSAhR4sL/Cn0hxygzUr/f+TA1lGwYNsTTBoKFqU+yIOUZJLubxhW/UlVvjyPy/m+zNXKwiDTnKKcSqgXNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfZCQhDeGNumS3HJiV4tuZM6/HzzJWk2FJn+Sm1W5fc=;
 b=NvMwX04c0iOMRnMey0dCFfdtxD/BDjkIQeWTm8oDs/RHh1+qsEKMqVa9oUTJG11RrYYFxbRD2KQrnEM0VTnU4n3nT0ISaC1dESJtQXqjoNyPL9CD4T/jM+pdkZQ5JxkCfxPMCZvgV48w2OMG94YQag8HX1HnGIpGEJD6KnYsQjU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 14:11:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:11:23 +0000
Message-ID: <3d80c59b-0546-4eb2-84c8-12c9179da90b@oracle.com>
Date: Fri, 24 Jan 2025 09:11:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when
 removing a directory
To: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20250123195242.1378601-1-cel@kernel.org>
 <20250123195242.1378601-3-cel@kernel.org>
 <8565d8e45073f76705a23e00eedd4d911f24a360.camel@kernel.org>
 <2a55bf53-dc35-49bf-bcd0-b76999e1ef34@oracle.com>
 <CAOQ4uxhZByoddDLqFnSfSri7wBLFnVORjh+8t6FfekHh8d4MOA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxhZByoddDLqFnSfSri7wBLFnVORjh+8t6FfekHh8d4MOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:610:51::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e743fa6-247a-4165-c4a8-08dd3c80fba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ppYlhwR3pCQUVGMG8zTFdsa2ZEMnMxb0MwQUU3MytYVWJLWUZtUDBEUGVr?=
 =?utf-8?B?NEZ5c096UWhlRjlZaFdMSnlUMXNnMEs3ekNpbFk4a3lQOG5VWEhSUHlLNmsv?=
 =?utf-8?B?dk9OMUxqTHVjdlQwQ01DemhwdEdpYko1QWRNSlloU3AxamdYTjlCMUk4dWg2?=
 =?utf-8?B?NE44bUhkYXR5VlRCcGI3VlpkSzJ3clZtMlFVanRKL1U2WFdwVjBIbVdwRlQy?=
 =?utf-8?B?Wmc0cWFNMFdGaHpIUVlzVCtMQUJoRnk0QlBkNUJuQmtVdnBQZkdkd3BRVlU2?=
 =?utf-8?B?Q3ZNTzd4V0loSTdHZjE0Ukh0V0JvQVFWZ3ZTYlR6VVZLejRObWgwZmFNemtY?=
 =?utf-8?B?aUFsYkhMdVZwSVhNY0srejVuMk1nbWtVWnJMbm0zODlheTlBeGdHU1RWNjZW?=
 =?utf-8?B?TWN0c25rWTNMN3hLUElNZ1RVY0tuUlM2MGZMSk5nUmFOOHg5S1RiWnQyclpV?=
 =?utf-8?B?Wk56U0JtcHN0NTVMR0k1SXhsNDNjQlY0bE9NT3NDUDBFNWxnbG8wT2xLbTBr?=
 =?utf-8?B?SVd3VVR0S2ZBblh0eG5manAyclVQbzNSWE4wSUJFSGF4Mm5uMHhPNkdHYzNF?=
 =?utf-8?B?ZmQ3TFJNSWhsaEpsNm41NWVHcGJoTmVzenM0a2E0MkpkVHB0bXBsbHZRMWxy?=
 =?utf-8?B?UHRzRDc1dnRMNk0xU0ZvKzFReVE4a0hIMmdERkVGYlhIV01rODdtWXMySEU4?=
 =?utf-8?B?YTQxaEJtQjA4amNENjVtdkJUVXQwYlhwQzdhN0hwdDA4V2w5MjdjUzh5ZUx6?=
 =?utf-8?B?Rlk5RkY4WWNoM2JOSjh5dWt4UUYwK0FYQjNhbmRpWnlHMDFWZkVMWVZqN3c2?=
 =?utf-8?B?Y2NUdXdzYSt4eVNwYlNNcWRLMzk3Q29PNWR5ZzluSzNmMUxaR3NLaWdlTXR2?=
 =?utf-8?B?M005QnRkQjlSZWZyajl2TFhBY244cTloQy9oRUU3VVFFbTJPR25GcjhhckJl?=
 =?utf-8?B?d21vNEtVSmlCM0hPWlozNnlTRHlRSmUxR0h4ZFlxUFA0UXpqRVk1dWF6cE1k?=
 =?utf-8?B?VTdIRjN5cGthRkt1MFJsNVNzVUxLU1VpMnU2aVJlNUg1OW91UXA1M2I2eWdv?=
 =?utf-8?B?K2JnUkFBU1lzUnFCTFVXNWNoaXh5Qk8rdjlMRHAydlZDN2w3aEdVWFpJVkxG?=
 =?utf-8?B?aEJndnBvZnhhajNPZC9BMFM1V3h5VVNZTExrRjY4UlJId0QvbTA4Mk9EQ1pz?=
 =?utf-8?B?Qml4WllTUUJFSHRuRnBNMjE2VldIcWcyUHdJRmJMd1QyVzhaTjlnanZKdzRq?=
 =?utf-8?B?N3JoMndoZzB1bndzUTNHUkhpdDdNV2NsVjY1YThiQ3pSU2c3alg5bHE0cWNv?=
 =?utf-8?B?emgrQlNVREdZVWN1WHdPeXBHc08wWExSVmxzODVraHFsNG9RQWFTb2Jua0xT?=
 =?utf-8?B?UU15Z3lnVEllRmNUbzIxUWdCdGhUSUtUQ25KYXk1a2lIM3Q5ajBWTDEwZytt?=
 =?utf-8?B?elZhak9DNDg1UDVkQk1ZSGtRMncrejRPRFVCNWIzek1JQ0xwamhiRm12K0to?=
 =?utf-8?B?SEhRWXBqZkZpVGlNc01tTituZUZPSFlVNW11OHBXUnNjNmplQWNuQTFaRk5V?=
 =?utf-8?B?U2lNMjZXeWdKZWxNdG53Qi96NlZHdUQ2RkRGQWRVemFkYVE1S2VGYW9xaVZC?=
 =?utf-8?B?Vmg4TTYvL210djJwUTAxV1lyZnBVaURWcGFuMDdZUWl4cmN0WDFlRFNZUUVT?=
 =?utf-8?B?S0x4eXRaYlV3REZ6bHZ1MWoxRitQamt6L2tQc09QUUkwa1pHQ0lhN0hacEZ4?=
 =?utf-8?B?Zk8vWTV6WlBVdXB2RVNQTCt0YzZQZ3Y0RDVWT1BPbmNJamt0bVBzS2ZFSUxp?=
 =?utf-8?B?R3NHMFY5aW1rWUlOUWh3VGV6aUNTTS80SHVKR1VZYm45dWJhNWgrVlRsdG9y?=
 =?utf-8?Q?AeoPyfIUz2k/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnRTUjZNOEUzaWtKWWNkU2VndUZoWWdoaVJnNDN5eW03OUdTaEF5MHM5MEda?=
 =?utf-8?B?UENQc2MwbkZRY2h3OVlLZEx4dnM2YlFMNWtzR3lQbkJKeEN5SlZBcytZdit1?=
 =?utf-8?B?ZXNsS0M1ZmVqbUMvVjRtaUhaVlZqZFQxeE9BL2JmMjNsZ0RMRnVMMFBkWW90?=
 =?utf-8?B?U1dIdWpBQ214SDMyQ0JuOFI1dlMxK1cyY1htd0lpOVR2aGhTbUw5a3krQTY2?=
 =?utf-8?B?ajJXdGVsSFNSRWs4Vm52VnNueTVmVzVWQWFrM0lPNFJqYjM3Y1gzUWYzdU1Z?=
 =?utf-8?B?dFRETyttQ0NRa0d1aytJOGM3Q3Jjc2o1c3Jkd3lRWFdMcW9qYjlyazNOS0s2?=
 =?utf-8?B?RVFhTnBFSlVhQmZORTZHV3pJSEh2bmFodG85cHN0R0ZNRlVMZTE2TDhENGtK?=
 =?utf-8?B?eDlQSGQ4VnFmeDZoNzMxSWU4cmVBQUkwSi9qZlp0dlJXQlZzOHdMSVg3WmJF?=
 =?utf-8?B?cjdxemFuRzE4OTh6Z3VERTI3QVRpa24rZG5EYUkvd0hIclpvL3E1MHU1NFVi?=
 =?utf-8?B?VFpaVVloYU93ZDRiWHRIQ2lXRlMxYjZzeTB1WEhDVzNVWktHYlBHK0xMcmxv?=
 =?utf-8?B?SXBGdTRzaXc1NFdYYmd1SEJoVDhaZzUwaGRlZjBUNW1yWXVwSnRHbHQrM0tG?=
 =?utf-8?B?YkliUUN4OVBOUENtQlRnTUdJOFRmTkkyTlZxNmZpaHR3Syt5aUxCNHo3eWVN?=
 =?utf-8?B?a0RYQ3gvOXNpVkJSN0J0VWZlNnk0VnNUK21MSnlPdWJwQXVzdllhN3Rwa2N1?=
 =?utf-8?B?UXpYVHBoQ2Y3TzVMRzAvNmowZnFFaERNUmQva2g1K3QyZXhMaVluOVhjaDh0?=
 =?utf-8?B?Qy84WXB1OFl1cko0ZTJwYTJoQjZCMnVuNXhBT0xjeThnWEc3dXVHQ2VOcFF1?=
 =?utf-8?B?R24zL1MwbWpaeDNXQnllTGlES1FCTTA0ZTRFRTluWEZDZ1VBM21JQXFTa1U2?=
 =?utf-8?B?dGJhSUJnNTdRMDB6aU1Cd3N6aU5xYmhUaVNFcGE5c01yNFVnNmdTdlh4Mk1H?=
 =?utf-8?B?VllySFVsWnB6eXdGNUN6a203Um9RKzJ6NHdkZnBnTzlCSk9zMW84Sk9lZDRa?=
 =?utf-8?B?bWMwc2tOaUwzSTRUUDhaTVNOMlhCQmNsQkZCeWxoaGQyUjQyR3JWV3F4MXRu?=
 =?utf-8?B?VnlGRXNHN252OE5mZUNXZmFHZFVNVTVMdENwMitnMURUb0Z1dnp1RU5pMjJK?=
 =?utf-8?B?TjhtSTVGRkp6SXk1N1U2RjB5RGhOeUJST1dJYmVVUTVwZElOWk1aNDk2VXNK?=
 =?utf-8?B?eDdVQVhyckI1bjkyQXVEaU5abDlyQi9IV2xVbXphYjcvQ25YUXN1ZFVDcFZy?=
 =?utf-8?B?WlB2TEQ4RytoZ1puRkpPcEQ5ZFA2YW8xQmNiMW5DRDJ1ZzVXR0JGWnMrbm1k?=
 =?utf-8?B?bmVVVWpPYndiczRhZ054QVhEMGdwYWNGR1hXQzlJcU1BNmZyOGxHZTNnRWFV?=
 =?utf-8?B?WklvNy9FTW5LNjdVWGd6RWxiVzgwdkJpWUt3RXk4VEEzczVxVy9SSXpwTlNn?=
 =?utf-8?B?MGdmcTk2cHRseWpPOVFRN1RpOXQ1clZwNDBiTlk0NVRWamVaVFBISHphRy9s?=
 =?utf-8?B?b3VUUnkxT2s2dnc2SW8vdXRxeS9jUlI3MlhkSzZCaHd2cDFLYll6aTk0SUgr?=
 =?utf-8?B?MWVQYlFVMmlGMnZKemVuTmVyakhaQ3RrZFdJNG9yVVpNNHZKeEtPQ3IyR3F3?=
 =?utf-8?B?d1ZwVEZTMkpHUkNzS1Q2SUtXbDJvOXVJV01HN0N4Tm1zZ0FXMXNxQm96Q2Nv?=
 =?utf-8?B?bUdSbmVwVEIzUWV0cll6VUhhRkd0aklOTk9yQzhydVJUeng1QXNYUFZUSXdL?=
 =?utf-8?B?OFpLV0xDRFlmQW9OSDB2VWY3MmFJbEZTRktOZ0dEU2g3ejJWSWYwZkVncXBk?=
 =?utf-8?B?bXRTN2ZvSFlUZmhSczAyWE1lczVpbjhkRlRxUG1uYlRURHdNYzRia2drNzdP?=
 =?utf-8?B?NjhrdVR2U2pQT1crbmpUWXdERENLMlBkT2QzYlVMUHJFZHZyZ3NKa0lrR1Np?=
 =?utf-8?B?bUllaU9aT2VSRDFaSGVzdnByZ1BxWGE2SVd2R2g5QTMweXUwNU9hTzFmYUx6?=
 =?utf-8?B?dVlwdFFoMnZjTTFmeTZVMk1ieWlqMjA5QnFhdUs2N0xCNlR4THJXWlJrSzZX?=
 =?utf-8?B?N3Zpc2ovVUN4dERqbUpzNlIxbGdyK2NEQlVXVGFhd1p6OE5ZbWg4YnBWSzl2?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OSq3vV3SZiM8dKDUq2EA06lrgv32K3yBvlB+abT7Ftib4ByWCJkoccMSGFZpLI6I5yHiD/G5ykZhf8K9DJUReuUNk3coh8ZyLKnq6D2oOuePCF7JVO5bj/3/5UySP6Wmm0psLSw9jmamGBeMVDWXjXF9QUuuCqcG5gI+vHH0BY7soEn1fhHT6HIX7cjFffWmTHQpb0mOJg7dziNbwVoWPauNLlszMXhYNMr762Op1lIT7vxPA9+LVUE1Y3QYSIDxVaWJhZHPNkar4179GWF80GmEljhujpjcbmy6nYjWvjocb7KxVcjiVEfauZlhzbHnCUQIos/z2m6PhXFy9EVu6vcR9Af0TAgbMxglOfrbuTbADRKJ2K4ohPIz1l8B8YlYmJe3BycZ+LIpyLS9cRsGklug5TVe/qVIGPOzZj9+lsKfXMUZ8V+I/lVFySAumu+RX+9fRWnICU4ZxEH9bBlPsRy445J9ZhN4unpCYN54gOb37pGWJoBFMXFUSGjQVWjDcK3HUJukouv/oRZ8ts8APcVn5aY1709vjN5tA2Ho7gRHvVj6Y7G0kDHyHc9CganhfvI411bDH19e/gWV590rxcxf+nYMSZUJvuAKp5my9J0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e743fa6-247a-4165-c4a8-08dd3c80fba0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 14:11:23.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP4Gts/hADtIXZynDdIpQGVOku7xEtfc4OESu9q1P8BJdiTRXLm6If4ufkReFzlGlIA+uXud0A4ddHwaxLPhyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240102
X-Proofpoint-ORIG-GUID: GX7VzV6SeoPRK16Evan67al5y5DQAJkM
X-Proofpoint-GUID: GX7VzV6SeoPRK16Evan67al5y5DQAJkM

On 1/24/25 5:42 AM, Amir Goldstein wrote:
> On Thu, Jan 23, 2025 at 10:07 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/23/25 3:43 PM, Jeff Layton wrote:
>>> On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> RFC 8881 Section 18.25.4 paragraph 5 tells us that the server
>>>> should return NFS4ERR_FILE_OPEN only if the target object is an
>>>> opened file. This suggests that returning this status when removing
>>>> a directory will confuse NFS clients.
>>>>
>>>> This is a version-specific issue; nfsd_proc_remove/rmdir() and
>>>> nfsd3_proc_remove/rmdir() already return nfserr_access as
>>>> appropriate.
>>>>
>>>> Unfortunately there is no quick way for nfsd4_remove() to determine
>>>> whether the target object is a file or not, so the check is done in
>>>> to nfsd_unlink() for now.
>>>>
>>>> Reported-by: Trond Myklebust <trondmy@hammerspace.com>
>>>> Fixes: 466e16f0920f ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>    fs/nfsd/vfs.c | 24 ++++++++++++++++++------
>>>>    1 file changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index 2d8e27c225f9..3ead7fb3bf04 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -1931,9 +1931,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>>>>       return err;
>>>>    }
>>>>
>>>> -/*
>>>> - * Unlink a file or directory
>>>> - * N.B. After this call fhp needs an fh_put
>>>> +/**
>>>> + * nfsd_unlink - remove a directory entry
>>>> + * @rqstp: RPC transaction context
>>>> + * @fhp: the file handle of the parent directory to be modified
>>>> + * @type: enforced file type of the object to be removed
>>>> + * @fname: the name of directory entry to be removed
>>>> + * @flen: length of @fname in octets
>>>> + *
>>>> + * After this call fhp needs an fh_put.
>>>> + *
>>>> + * Returns a generic NFS status code in network byte-order.
>>>>     */
>>>>    __be32
>>>>    nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>>>> @@ -2007,10 +2015,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>>>>       fh_drop_write(fhp);
>>>>    out_nfserr:
>>>>       if (host_err == -EBUSY) {
>>>> -            /* name is mounted-on. There is no perfect
>>>> -             * error status.
>>>> +            /*
>>>> +             * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
>>>> +             * distinguishes between reg file and dir.
>>>>                */
>>>> -            err = nfserr_file_open;
>>>> +            if (type != S_IFDIR)
>>>
>>> Should that be "if (type == S_ISREG)" instead? What if the inode is a
>>> named pipe or device file? I'm not sure you can ever get EBUSY with
>>> those, but in case you can, what's the right error in those cases?

Another way to put this:

If a client can acquire an OPEN state ID for those types of objects,
then NFS4ERR_FILE_OPEN is the correct status code in those cases.

But in practice, it depends on what existing client implementations
expect.


>> Check out nfsd_unlink()'s callers to see what they pass as the type
>> parameter. Unfortunately we have to compare against S_IFDIR here.
>>
> 
> Not exactly. nfsd4_remove() is the only caller that needs to get
> nfserr_file_open and this caller calls with type = 0, so type here
> is going to be the actual type of the inode and (type == S_ISREG)
> would be correct. No?


-- 
Chuck Lever

