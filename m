Return-Path: <linux-nfs+bounces-10267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D487A3F92A
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B01A188BBEB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD91A23B7;
	Fri, 21 Feb 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0wbxL9O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ciENiwDl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1018632E
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152417; cv=fail; b=nNLEYIipkzsj7bT6CfiW75pEgyE6hPjS3QgSzFTNEoZZTouxIgPTIGXEF8sSHYVyNz4XfbMgiWCflXGmtpy/xw3cbUbRhVC5Z16HUt5Ubib34AWoeujm3tKw7tAwrBfB1icqjJwsxq2kYNeDNO9lbKyPMXJaik4WGCVB120LOyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152417; c=relaxed/simple;
	bh=15VK80LKUaO0wZN9WfQ47f15FBe8dblOyCoWusCdkoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jvynr7qI2btruCEq28KZ13AJSAphGASUaGDiogtkpTnYYqTslb2iVWR7fhmTHlhWJpj00h2g9gBwDwZJ0UfxVLloFGFHWZ0bU/19LvzvKyvrNwb+ZEH5Mz9fi1FSMereQ4Yd409xC3RIKAvV+QiilUFndmqpe0AKJZlLGDJYDkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j0wbxL9O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ciENiwDl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fa5O029766;
	Fri, 21 Feb 2025 15:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3CweHlLiw7JXM1oU9z2VaYFbwLG2v25cxKO4ax6Fdis=; b=
	j0wbxL9O4zrVtJ9so/MfpOkyABC535Q2d+BZ+PzircphG7SDhNw96NlHAAf+hiAt
	xCGz4uRoAZZyNfHAanQ7DQgtDwOX+NEzGXgoY2rlJTN3/8U6PtjXeS9crUVgH1u2
	gNacPzNVfeudniJai1pCG719K75GmrP5u6qJK1mLwE0LlaBz6jswBEtSIEgqxPNY
	1LAkQvUcPtenJZSf1FI0/M7HckEJ8Wj2W2U4PI9Y8Xz187FGBgq6hL7zPOg8jqt7
	6SLxW7a+rsRdkwfJPh8+gLNoEWcaUz1CcbRuNKzgJMVAVkdn6z2D4fsvoRM34kPW
	qDMm/aQAsFMTz3pYAVo+fQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n6ff2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:39:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LF5BnP009760;
	Fri, 21 Feb 2025 15:39:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09fsngu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmdsWzcUnajLplU3wrzrv+73AIAUAIhEH7dxZMArnEv1meyW8ntNRBYyKguM3ccsgcnlfJQXk2fV5+jWxWfrI0VfaOcUzJD3N4GbY7H9BKj/pBBVUVKcghK+99oaeGnOOdkWAmi+hsFurY7BnfSjdxZkS/jSR6LmyuOHFY4GbXWnGnGjR4k5k6LqiytLwWOq7vEmKUdGVl887tKclpTIZ03tuGXy0tAfEHlUmsKefHRpcgBi3uP0F6kTiNFGRdhqtkPzr/hHgjdaFLWA0tuM5me6QDR1JUYCj63cNeS+Do/GKqc5H8fAEcG/YmZhL03NMKtbbsydBTZbBKiCtnNsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CweHlLiw7JXM1oU9z2VaYFbwLG2v25cxKO4ax6Fdis=;
 b=GJDH2s0+fcMkgAurEriv/AAgZBvYyjKDWYsyOjFAoCYLGuhPKKUSfVHV6Ac7aZSkyIbYv57WWExZ6498fGs1TzKjS61HVmie7aDieMiHP+efBaT9v9C6KffM7nEfjBYyAbKDyHDTlAnXiwcB+a0rhImi76C8l8B3vvUW5ciMtQzDb3OQ67fCG4jkEtZiMdoncc+/Db5CyM4s794pi3PA+S9tIOc/df/40yBcgZS0uFq+qXMqEyd53qqUuIA91egCJZUvQeO1RS0Zdxb0AGKx5hx5n8yi5u0v11BbsJYc97tryNVsz9L1Tg3a/l5c6rMK+mPrgqDfLyPWroUxd8oahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CweHlLiw7JXM1oU9z2VaYFbwLG2v25cxKO4ax6Fdis=;
 b=ciENiwDlAJEz/29Lwxlkocs9A2AohVsef2Liex+H8O6raYNI/HNeRCawNrSidkTi3YP1w2KYNIqkRrh+NJb8ybnEHnINtiDMwe3LIzuEe3p0WC8l1iDkQ1GgOdSqPvCT0YlsZnsUHsywSgke0nSJaKv7JpU07EpOiG0xjk6f+vI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:39:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 15:39:54 +0000
Message-ID: <64d7e00d-e025-481a-9145-7038e9ee7fdf@oracle.com>
Date: Fri, 21 Feb 2025 10:39:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd
 IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, axboe@kernel.dk
References: <20250220171205.12092-1-snitzer@kernel.org>
 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
 <Z7iVdHcnGveg-gbg@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z7iVdHcnGveg-gbg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:610:4c::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: aace18ad-803b-407a-12ff-08dd528dfcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1ZVQ281dzNIZVlaRmYyS3p1OTh2U3RtVFdQVjI3b0wvaEJhSFFTWk9UdEVL?=
 =?utf-8?B?cHdMQVRPdmdtaXVTcDhwMTRvUGRaL05XRS9lWkNyVFFYZ0FJTCtMNkF6OWJH?=
 =?utf-8?B?RlhkTWdRYzlxV2xiQUc4WlZMbzFqWHp6T2xWNE5NQmtLZFhILy9rSktnNWlp?=
 =?utf-8?B?dnZBOENQcnVmVnVWdGxzb1R5VzhGZjBsWDFiLzd1aHV5M200bXR6clFYeWFN?=
 =?utf-8?B?dkN1NWNLSy81UjdRTzFlTHBRTDBzWW5QdEhXVHFHR2NOL2xZeVFEQ2JZWlkr?=
 =?utf-8?B?RDk1bittUGNEbCt1dis5Nm1YdFloQmQ0NXpxeXQrdEVCM1IrUmwyd2VPMWpo?=
 =?utf-8?B?WkhTT3pCMXVYMTVmcVoxNG9icUlUZEw3OHh3VnpkVEE0NTV3YUdCRmxzUE1F?=
 =?utf-8?B?TFRZa1JBYUJhQksza054WW5ybURRRTNRYmUrUWxldWpzMnl0ZytpNDFxMVBY?=
 =?utf-8?B?U1NsL2dlTVR2QUQ4S0cyMUdkelVJd2ZpTURKZXlzamlxeVB4N3FPam1WcEpH?=
 =?utf-8?B?NWdaS0VjQ3cvWVJ2a2tsTDRndit3T3JvRmdYZWxKaWpTUlRPTHNVbCtCVHN3?=
 =?utf-8?B?dEt2RFhjY2tZL0g5aDZDZ1Q2eXMyeUtKSVFkYytTRGFIRVY0bGhnVElXUjhE?=
 =?utf-8?B?R0p6SkhRSlNXL1ZKWXU3YmdPLzVsYVhLdXU1WVE0cGo0S0ZuaTRnWTNMVStI?=
 =?utf-8?B?RDh1b29NVTV5a1M3U1ZPRzVabSs5eS8vOXZvSEdtOUJZcy9JcW9UbU1TWXlB?=
 =?utf-8?B?TFkya3NXQmlCSjdieGtNNFZFMzRuY24yaURxUkNHK1MrcGhMMmtodXo5Y0py?=
 =?utf-8?B?bVQ1cTFTeG95VGN6VmtZemdlSkFFUmswMG1MY1ZwY0NqQnFITzhiWTQ3a3cy?=
 =?utf-8?B?Sll1cVNyTFlZZVpvVkpvYnE2eFdNa3VEdjBiT0ZJUnZBU2VIRHFNQzJialVB?=
 =?utf-8?B?dEhpc0taUW1ZZngxMjFPVjUyVTFzZWNtbVZ2L1lJaDJWUStCaGZmcldmcjdZ?=
 =?utf-8?B?MUNKOTVFSkZrYkt0bTB0QzhxOWNKZmdWSXlWbjJEUWNVNU02K0lIellCTTVn?=
 =?utf-8?B?dHdqYmpUQS9VaGhQMnAyaVZhVWhKRy9aL0RRTk1qN0N6cThnYnJEMDlDczlx?=
 =?utf-8?B?OUh0R2pGUFhCU1JmOXh1OTVHMHc1U3RNNlBRSjFnV281dTVNeW9pb2tHR3E0?=
 =?utf-8?B?SlM5aVVsM1BtaXFXNGVVTFNyOWdzNlg4eEpNSW5uK2tuaUxrN1g4em9HYWxt?=
 =?utf-8?B?MUszTGRIbFJWekt3QWRaTEhoSW5ieDlIWHY0U0lSY3pGMEV1TzJOcGErdm1N?=
 =?utf-8?B?bTBobUlFUXpwQnY3cGJ2Rm5qMEpGVyt0aUFuQjdmVVhZZ0QvU0RZZzAvQ3F6?=
 =?utf-8?B?SHE4NGx5TnoyS0ZDbkZqd25oU3pxUDZNZUJwdW1nU3ZwVGl0OXBkdFUvelZK?=
 =?utf-8?B?Mk5ZZmxmMDVyelowUzdFNXpJSnhOa09uTy9BOGtFNjZ3aFFmWTUwUWdFUy85?=
 =?utf-8?B?aWJaVThrZGx4RTA4Y0dJNWJhZm93NWdFOVhsN0RtWmlEQ3NodkxZeUlPV0Fa?=
 =?utf-8?B?d3BxeTNpUjR5NXlSa3JaM1NWdkNIQk5iMjR4S2JPRGQzUjVRSHhyWkZmMG9a?=
 =?utf-8?B?TjVNdnVuZWxHOXlLY0V4N2k4bHVpd0NvNW1BSGZkaThuZytvS2VXVk11ek94?=
 =?utf-8?B?RENwSkRGbmZ0dDhqM1BlSTlxcG5RSFFreS9xM3dDY3hxcTZZNWx4K3dTajR5?=
 =?utf-8?B?UEROVkN1R1hZWUJxV1crdGViOFJlaW9MTlhNVU1iVVNDMFdJKzZFSDZHQXBI?=
 =?utf-8?B?WjJtYm02RFRaVC9ibit0TE9Pd1psbVZJa05hVXRZdFdQUXd2YThmangxRFM2?=
 =?utf-8?Q?aPziokLOMlbDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXhySDBMdkdhS2tOYnBRd2NBOXlzcFR1bDcxaHcxUURSZFp2OFdFMDh3dkV4?=
 =?utf-8?B?Z0VZUXVKQkxnUlN4UnhBNklSblNsRjlVTkJ3SjBzSW5yRXFuRTROd1pKdnRD?=
 =?utf-8?B?UnlKQkNYVWg3OHpoTkowTkJNaTNBR1JYV2xuRjgwWmMrQTVhRFIwdVM4UE9K?=
 =?utf-8?B?MlNJd2tyRUYxMU9uMU5PNTg1VW0wTGpzQU1UU0Rjc0k1cG9ERS9WejNiQ1Y1?=
 =?utf-8?B?cFNPZDByZ2xaZTNQYVRGd0tvUkJPcnBmZVJXaFZUVjhaZWFiT1hqRzUrOG1B?=
 =?utf-8?B?dE95SExiZ1AxQ3Q5Wi81cTJINHBlanIya25KRUZEU0Vkd3BGaDlyVWpZMmF1?=
 =?utf-8?B?eHhJTzZKQkRiREJlZE80d1Zkcm93bXJ1ZkI4SVdaVzl3U2dHOGluQ2UrMHBD?=
 =?utf-8?B?MzVFQXUyM2t4amNZZjRvbnViK3lJd2xrLzVqQ3ZhVG5lNU1JMG1MclkzRUZO?=
 =?utf-8?B?d2pkbTNoRTYrL1U1R3NZQWJ2ejhWMDZYQlVXaFNhOTRhN2F0cEpEUFdZR2Uw?=
 =?utf-8?B?a0RvRDdPNDRoYkVEbndWMXh6YWtTVWJ2bHFHOGFMMlV1TmV1WmlCT0tFOVgx?=
 =?utf-8?B?MzdoMGc0SmM4cm9wd2JpbVdOeXJxdHBWWjltRi9Ib3crMEdOZGpYMXZDSHM2?=
 =?utf-8?B?YjNsYjMreWxYR3RUYzhEekEwalJHN1ZKMkNDS1RmQmVLMHNraHpxSnNpb3Zt?=
 =?utf-8?B?OHlBRmF4aUlPRzBaTmFjT21WNG5DN2RaeXRnY2p2bjFTZVZwSG5JM0hZckVT?=
 =?utf-8?B?U3dpWWp3dkdKUXdpc3djZEd0aXpQUUJRc0xFeE1IYTdFWnFzOUd6VXAvSjFx?=
 =?utf-8?B?K1FLTWUrV3EvRE04bitzUFZGeEx5d2ZWbEgyWExUZjNKcmM0MGZqeklVdU1Y?=
 =?utf-8?B?OVJoa1lEdmo4cm9pV0MwRWZUbkdGSmM4L2VvYWNWd0dSckpLZGdHSVNvOEpB?=
 =?utf-8?B?a2h0Z25taGE1aWVkbWs3ZUorS2h5Q0pKb0hCVzliRUxlaEpqWWhxVWMwa1Rs?=
 =?utf-8?B?TVQ1ZzhKZkQ3N3kwQ1R6VUZ1d1FhYXVjZm1mZXBsVXdNRDc0RlBSVzVjZFBz?=
 =?utf-8?B?ZWhEOXhXRDdqdytYMndEYkFEMG9sQ2l1emdBVmZCelFHeE5GNUpsMnJtcXJ0?=
 =?utf-8?B?ODRxZG1kVXZhNzRXcVFYc3I3V3drZmdnQlBBYnNQc2RjVmVUM21XVkRBUkdq?=
 =?utf-8?B?cys4dDdYVmI3L1g3TjlWcEFTZ2NqclV6eDM0QktYVFFYTzZXSlIvdXlBOElX?=
 =?utf-8?B?aEJ1bHNpblI0bCtTdUNUdk5nbHR4cDU2SFJWS2R0cTBZdm5YcXJZdVYyZmc3?=
 =?utf-8?B?Sm1TUjg0eTgzeVR1aGxmZFBaMThldGIwWGpUYzRyNVU5dmE5Y2dQS2J4WU03?=
 =?utf-8?B?NzR4amNTYjhUbm9xLzhVeDZmOWVwbE9FOXV4WDZxZEROQ296U1M5Y3hLQ3I0?=
 =?utf-8?B?blU2VVIrMnovK1EvWkxxenExVHNlbHF0dklRb1VwZ21hWG8xdEtzMkVNU3dm?=
 =?utf-8?B?eVk5b3A5bksvNHZZRy9DQStyUWJSVFFtaDBiY3V0TnVQb0ZSczdkVjJIWnhF?=
 =?utf-8?B?RjI1MnpYcWFFcFlVUGJIQ0xlcXpzd2laTmd1R0J5eGxLMy9uMXpNaGoySGhk?=
 =?utf-8?B?ZlFta1JrajVqUmpwMjRjY0VlVjVnUk1Qc3hDWHc5K1lndGQ2eFJiaG9lUFRh?=
 =?utf-8?B?ZWlabEdJck9ZSTMvU0hBVU04ZldiRUdpRENqTUszK25nOWh2cVgwNXlRalJn?=
 =?utf-8?B?STczNmNsVkVLOG5EQ2t0Z2pVaFgrMkpQNzZnTkFUUit2a2ozNVRLVHhtS29X?=
 =?utf-8?B?MndVQVNtVHZqdlRqUjBNd3NBNE9DSGIwZTRuRU1jbVZTTS9HZHhISzU2a1ZL?=
 =?utf-8?B?UEEvVVBwK2tVQTlZMnl5NjFxMExCd1FIQi9hS2k2aDNIMzVUeTNIdm5JQzM3?=
 =?utf-8?B?a3kvNUVkR2hhbmdOYjRlbTIzWTUvZDNpVmYxZ0gzRXB6dVZZclN2b052aXJi?=
 =?utf-8?B?LzNUb0tKRExiRVBQY1V5akM5WEN0SnBqMERpaFFoSTRlWDJzaGR5aXV1Skgr?=
 =?utf-8?B?RXdQamFRNEgxOVVXaFNoVDYxcW9BVm9UZTJMc2FNN2dOTnBMeWRrSE1HVkhl?=
 =?utf-8?Q?lCClegoQ64CWeqZZPIGtT1wqu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xnXWPw1Om20x8t8/LA8aOxdwAr1DhFWu0et1kiVAzNOqZD/fEQZaCCXyZ1Fhv3DKnWXcq3X+BshIIZOei5Y9xX/Wi1ELx/5EQAPV/G6PJu+0SgsEcIhq+EOdMqnV7fzKkJNY2GddTL/KbwdtP7pGFLqFgJWYJXNKhJ3JxPwnd+ZqkPH+I7R5vJFy/Dr8EPYu/CTNfz9kl31EsJ5jkpIsXMf9rn54m2vdjY13FhZYu0Hfyg7elW+bN04+m3o0e4vuD+XRPHmBUiDES3//PINkDaUFyuzyvTsLVg5+fgAEsSKnX9IXs63ge1YuuRwaZ8WGb/FGqp9rLwU+lwuSihGyZYX5bCyWZl3bUo4/z4cK57SdyZt6kXGhI3GGu+Y/s8vZtYRkAHZVk3wdnCQy0PXiKd0n7nnj2k13KSRKcXH0vo5bCNa6vYN3WxgOq1xbJ3Qp1IeVrBsGXN13K9mrgfWihe52MSkI5pbKwqg0NXHXaRIq6OYg/6gLMd4E9Tuf7Qnb9AWx1JgDsPsHc1JJkJR3tEZ4AQRLIYcerRKiH/tGkPr+dgdwt+pNMAB9uI3QRqs+4vBaDfu+yzwbD14ofjXrkDe248e0e8t0yL42fDQhZ9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aace18ad-803b-407a-12ff-08dd528dfcfb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:39:54.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eq+m+/yL/GqsXdhCNUleKL96aVxg6TAfooRVeBjm3qePrKTXMxM6G677nSv6ef+eb7mszPeS730F9pl2Y8yjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=273 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210112
X-Proofpoint-ORIG-GUID: w8VILoWckXyuKcNgI-lNedm9rKDz-7Qj
X-Proofpoint-GUID: w8VILoWckXyuKcNgI-lNedm9rKDz-7Qj

On 2/21/25 10:02 AM, Mike Snitzer wrote:
> On Thu, Feb 20, 2025 at 01:17:42PM -0500, Chuck Lever wrote:
>> * It might be argued that putting these experimental tunables under /sys
>>   eliminates the support longevity question, since there aren't strict
>>   rules about removing files under /sys.
> 
> Right, I do think a sysfs knob (that defaults to disabled, requires
> user opt-in) is a pretty useful and benign means to expose
> experimental functionality.

Seems like we want to figure out a blessed way to add this kind of
experimental "hidden" tunable in a way that can be easily removed
once we have the answers we need.

I'd really like to keep the documented administrative interface as
straightforward as possible, but I agree that having a way to
experiment is valuable.


-- 
Chuck Lever

