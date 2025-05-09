Return-Path: <linux-nfs+bounces-11647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60641AB1F51
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 23:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836A3A26D22
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1892609DF;
	Fri,  9 May 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4oarfSo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZhF3PPm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15A262FD8
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827305; cv=fail; b=UXRAqY6qr6Iv+b5nKCqIjmUmZR7EEHVSQAMxAZKbtapAKzHUdpgpNvP8xtrB0RQKTuwHhSCdL0H+y5IBOkmGIRo3qwPze7Me/oQjfUTda+NYo6zLrRoqzFlor/51/4cnmPmYyzGRFpwloMCeWFpca4Hu9oJMk76fGjkRDFNaBCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827305; c=relaxed/simple;
	bh=RforsVWG8C+X3vMAHWNWA+BTXNndoqelF3aUn4HHKQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHYgUwrK/TpcXFUpTNuUpQmBx9OK90pMcHKpsulgiWuR+pc730nQfNvNajbzGUx425aSbC/+mswb2Kv31tsCOUas5U2dhqMe2sMvXWc/o83zWHC3yMlLnBKBRBAzCilKuoTvkLBMK4Xh38JzSswxYynBA3dTcs01hDj+Eyc5ELw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p4oarfSo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZhF3PPm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Ljj7w002258;
	Fri, 9 May 2025 21:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LoAtRRYhU0QRnsk+JF0Fnae8JmpaaJrC2TkvDBoQ/2s=; b=
	p4oarfSoVolX4ZHcX+xg08U4sy+kOGo1FQgQ2e697ns5WjfXfJZMGeCyjOSkOsyq
	543XJ9g3K0m9fEcFtU1jv9NOxOPuBV7uzze/wgLmrxiMe+HwJHdrrzFrOfwVjGon
	ueK7TqPCEM6mAiQduffPGEATvg8K+jGw2bXTYrrUAckcMZCvnMKqs5UBEzDz1a0h
	my7gxgr8zFF43RkVBGtAWQ0WcE6XP2rYOjHKliGGclybk3d4zS/Kadyvge+vtpNg
	XkgSYmHqnFuImY3t1Ah5Ky3GMs0bzi54d7ECO9USQyCEwGKrgfDIvXer0ykGKqL1
	sZ/MloJdB9/SQZ9YIP8uag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hsvt802c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 21:48:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549KFAA2022230;
	Fri, 9 May 2025 21:48:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmcdgy6y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 21:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWYbvbXgqoQGLzO5zTZB6G+qlssls2486am1KgA8On47OcM85V7SAax+VW/IoqFZQqIVShRq0Bd9W7K5NFlbLeo1swLrWMRVirX11mMC7QOdyB/eqXNXKfmbKu5JAbEQiitvfbxiYpRrCQBLZQqCrcS1i/nEu6HNnILGYaR5tijlKkmze/jyk7SDPbdI3TJ7dKanr9pwBtoxyMw+loLzgC+LX3A+uOTa8E7ed/HcEcfFv0N/RPJnEs3crGy7nVjJ/p1svZxUN9/in6PVPhfn9PYZgGZvJCBTqCtZetCUmGW4H3v8Frxc1Xmvp2YtGXM5V5I13ca+ikhtwBKj/l7Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoAtRRYhU0QRnsk+JF0Fnae8JmpaaJrC2TkvDBoQ/2s=;
 b=EpW5iaF20qCxphkF7x2595faHwqTAKtSef3lzLrtSkWjnemqkRkrUnfuZP6WDNfsS9VKjL36e1msSNU860ByGh8MHIHNOJPtMekPIa89vIsfzAPySy7ka90YJqvp6D+jCe1OpiQiHf8y2KRS+6ZTE/QGCcGvyYh5/wc3dCHl6nExwkbqEMctB456XjF2Y9k3nV0kTURBRVhRq/UdyniOF22chltty1svuMKGwC+s1B0XJ422AJdoOrjXm340covSo92tqFUTqqSyTbkQDQFU3VdPZP2QwSuCCZlYdNcpMcxmg7pCfszuQ6AQnaZhEJj+iMQKybK6jjUVosplal6Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoAtRRYhU0QRnsk+JF0Fnae8JmpaaJrC2TkvDBoQ/2s=;
 b=GZhF3PPmVpY6CgR4xleOKltc+Itx2G7VwE0nXeJpG/KGQ8VgIHtjf0GptEx+/mWlA8YVyLAhUfu6Qp0mEGL/RjaEoNrJRl/5P0rbwpeOutolWOXv4hLwnxGdDoZ/4e55RZv7tpnpFmVCF+Z+bJSLTq5DjY5PjW7AuSqQ0uEnnqA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Fri, 9 May
 2025 21:48:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 21:48:05 +0000
Message-ID: <0314dd65-f7ed-47be-b39e-813e6b334ec9@oracle.com>
Date: Fri, 9 May 2025 17:48:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f23c1bf-7334-428f-9b71-08dd8f432db6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bjRnZlRtRmJXUU1YeUlMU2pHSGhsWU9TUXRCb1hjb3c4VzltbTREcUV2SW9U?=
 =?utf-8?B?MnFMM0FJdEpOS3hmODY5ZFBCd0NZQVlEVFc5Ukc3TEcxd0hkQmhHOW9vaHhS?=
 =?utf-8?B?N2MxR01vY2ZGaGRGanRHTlZiYXVZTEllMmJtcG9hTHUrTFZxV1ZVN2txM2Yw?=
 =?utf-8?B?U1loaW9oY2FBK2h3Y2RDNlBTQVJFc1dEa3lrOGh1WjR3RzA4ZlpoQUVIWFlt?=
 =?utf-8?B?ZmRtSlhzZ0ZZT0Q0S1ZCODRMNVFoNW80RTYzc1hmQlpOLzQwMWs5WWtsUmJ5?=
 =?utf-8?B?blpRM3AxdmkxYWdDU1NSUkZCeThLeENIVUhTRGh1bm9YMVNZbmNEYXMyalRE?=
 =?utf-8?B?VHN2MmxXSjRIQld2cmZvTk5qMjVRSGwwR082SElTT0R6ajl5SDlUZ2xmcTg1?=
 =?utf-8?B?UEFzSXZHQVE4OSsva2xJM0JkT0JiZE1WcTZzaTRIdXNTSHdjQitTNk5QVFE0?=
 =?utf-8?B?b0ZJZHErN2hRRXdwZUJ3RVFPOFdCNUNvZkNkZS9qaWFxOGU2blZ2MzQybjRV?=
 =?utf-8?B?WWZOTmdLMmRlZ2w0Q2R1SWVRVnBGWmlmbzVVanlyUHBCSG9ITUozZ2NCVmw2?=
 =?utf-8?B?V3Mxdzcvdm4vcEhUTEtraWNUZFJYVjJZT0lTNXc2UTN5VVJ5WnBvVmxaMjlm?=
 =?utf-8?B?UGFndERURlVnWUpjQmVHc0hwTVc4Y0pEdmt6MlFTNmpWV2VXdlRueUx3amdZ?=
 =?utf-8?B?S05iOTRrR1AyNmNGVXlZSUhsTCsyTllzNGZQdlZxbTdqU3IxUGVNWVFXSjll?=
 =?utf-8?B?cFpnRkxLZjAyZ1NBVGxMN09HcSs1NnhBOHVRdTJ6a0YvaGdKU1c1bDFEdnpi?=
 =?utf-8?B?SmVCYzFKNjZTY24vdzhBd3BiaU1qV2t6SEd2bTJjOHltTGYzd2JTMENIbllp?=
 =?utf-8?B?L3A0dUgvSHAxYStsUEhHaHFnWFdwSGpYdGM5KzkvN3lKRmhaZjhrT2J1NHpB?=
 =?utf-8?B?WjZFM0xqczFJVmxVbDNJRUNlR25mN25zWVYrSUd6VnFENHBlTWg4di84Zmpm?=
 =?utf-8?B?SEpYY0VELzYwT0RZV3RhMFZqaVFIZ1N4V1A2Q2s3d0pGblZwWWsyZDFpZkRw?=
 =?utf-8?B?NklhcHhyb3gwQS9oNmJyTlhtMTZPaDdZMFNKazJYVkNrejl5c0JKTXFDQkds?=
 =?utf-8?B?bVpBSEgrSWMxa0FUdTNMV0d4MzZ3NGdPSVhIcWpTdlVrN2UwMFNWYmgzdXpD?=
 =?utf-8?B?bWV5UU1oaW1LVWpCSUVmM1pzYzJ3T1gzMW5POTNYTEd6NWd6S1NEa3RoWlVx?=
 =?utf-8?B?anlBYVRaUzVoS1JMd0t2a1ZZRWcxQnh1M29waVNVcHQzcEM2aDF3WkpzbXF6?=
 =?utf-8?B?RTg3bC8zbUxlbUo3aWMyUTQ1V2Y1ZHJrTWFpenppa0NZRElmUlNjTUIvcHhG?=
 =?utf-8?B?a0tiV3JWRzlzZ3R5aWU3eUlmYVpXLzUxZENJZGJlTkpabVh5bzR4VkN6YkU1?=
 =?utf-8?B?NGE5Ump6bmNsNDRlWE8zM2pHMFBJbW4wT3RxZTNIcnl4azc0czY1c25XcXRk?=
 =?utf-8?B?R2RIZm9UZndOK2dDenRaSEZhaW9zR2hDc3NhRkt4WmUxa3VLUlB4UmFRV3hk?=
 =?utf-8?B?QjArcjlqUUR1L1V4YU4xdDZSQW51M2ZUMHRYMHRZVDFGN1dKRjF5OFNKd0xk?=
 =?utf-8?B?SHY1Qy9OQ29YbHVpaVp6RHhzT3ZmQ0xzVENEcUVQS2FYdGVrc2xsczNKRTNk?=
 =?utf-8?B?S3BGWkxWUHVJOGE1VEpCWUJCK1EvU0w4Q2ZQNytFcU9TZkxDQ0pKZUIxYUox?=
 =?utf-8?B?cFlhMkxIS0MrTU5VeWgyUFRrRGhyQXBOd24zOGVtNDlZWDRtdWZyVlRDc2Zy?=
 =?utf-8?B?YzhILzRsNXRyS3YzVDA3OSs5TlNqVVhsbHprL015MGk2dWVCRjJDb1hXa2M1?=
 =?utf-8?B?RWlsZUV3RzNxZVFQdjQ5QVRDSjJTTit2VWsza1pNbFVJV0VDcTc2RFFTcGZw?=
 =?utf-8?Q?alv5UtawTtQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bzE3czJ3UXBIdVU5aHdUOHZqYWs2QUt2ODhHU3oyckhnM1ZMTThpaFU4RGo5?=
 =?utf-8?B?dkhoT3plUis1MktYWEdhSXlZamdCdStyZXJGZCt5c3QzRmZXM251QjFwSFJv?=
 =?utf-8?B?Qk9tWjNMWnl4emo0ektPd3lCOVNHREh4ZUE1bVJsbVkxN3BraVdHSWtza1Fo?=
 =?utf-8?B?Y1RuWWxyZmNybnRNZW9wdHRaUnRvQjdnVDR0YU9mQmx0WUUvcVh1WFh0Mkww?=
 =?utf-8?B?UTBsMFBnTStvclhpNmRHV2NuRlR4S0VoVjFmUU5Jd3c4UXRMTjd3V3lmT0Fm?=
 =?utf-8?B?RlFnV1hyVGh1bkkxYmU2RDNDVWc1Szk3VzY3eHdRcWpETURvbVBSZTdSWTNo?=
 =?utf-8?B?dVNkOE5MWkREeFB3QlVaN0hMMExEblBtRDhtTlVWeEFsakJaQWZhcC93UGdI?=
 =?utf-8?B?cTRvOU9XR3JXSVhKaEE2UUJORHQwVzcvUmpSQkVRL0h6UmN3Z1pTSmRkVFJD?=
 =?utf-8?B?Uy9XZ0JyTHdiS3EyMTBvWDdyakFUa3BYZmxSSHJ6RmpJeC93ZmREdzVQZGg2?=
 =?utf-8?B?T2E3RE92SUE1WWhXa2lYNFYyRUpYc0p5eTFRc2luM09DUGc5Qmd5TnhLcG16?=
 =?utf-8?B?L2xCRDhCN0dMZThZTk5xeGJ0TnYybGU3OG54MkJvS01sNlkzQXFnZmY3OUYw?=
 =?utf-8?B?OUptRytocDg1NUxmMVFrSmliRUhGb09lVmxnUWJ1QTc1SEx3SDdMeXRsWU8w?=
 =?utf-8?B?emJNZy9pVmw2aGI3dGpLRjRKVUVRWWt6dnFjUGUzZVpPVGhiVVdGOVpwcmdn?=
 =?utf-8?B?TlhoS1ZyWlpDSkg2QUp4K3dOZXh4cXRQRnY1NWpPZXNBWmxMVktpSGtCN3ls?=
 =?utf-8?B?a3RRWitYTGVmcG9PNDkyaWNTRHVjR2hJVkl6RCt6OTQ5NGcxYTBoQXVKWGlR?=
 =?utf-8?B?NW05VXFydHRMelFTbzRHTXc4ZWhkb0h2NEx6Q2U3QUh3M1JSemNQZ0tTTzlX?=
 =?utf-8?B?eVNmbytYS3JsL3oxbkxCVklveWZDUStaSFJMWG02aURmSTZTVTNPck5tNFU5?=
 =?utf-8?B?WDYrZlZNNmxFMlY3d3BDVENVanBDcEdGajQxbmZnbU9xMnlyUXhTK2QrV2NO?=
 =?utf-8?B?UjQ1Y0xHWnorOFB2UDF5TXJRRW85SDRjNDYrNWlZQzJ5NHN2NFBVVENHTlg3?=
 =?utf-8?B?dDB1Wkg0Rnhyd2lNYkZpNUplNStVNXBwL2xHaTU0dHhBUTZ3b2NuNHVGMktC?=
 =?utf-8?B?bDhVMFNQTVN1NUlxTHZpSklQazJIdG1uY0ZvVGJtbVZQMW5KWUVrSGlCSVVE?=
 =?utf-8?B?akJnalNSaGJ6aWRaVmR6b1B0ZWVqRDZrcHN3YVVoU2NLeFkxeGVkYm9LTWhF?=
 =?utf-8?B?QUF2QmNGRTg5WGhKNXptVjM1ME9QR0taYk96dDVPVGF0bU5nMWlMQWQvUkdV?=
 =?utf-8?B?eU1KK3pEMUdYUTZxblAxQUZJS1ZVZ3g3SitpbzRsNWlINTh2Ylc1QjE0WjR1?=
 =?utf-8?B?OW5ZY2JmUTd1aG9NMHdtVE5EYVdMK081NmNzaUhuMEVoMEEwUWNmTU9CRE4w?=
 =?utf-8?B?TzRWOG1GdG1PY0MyMTU1RVNEQldqTFRvbHJqdlBMSnh5NFdreEN6aG5YWnNU?=
 =?utf-8?B?c0sweXdoSEJEV2FJU0lhYStmU2xYL0hiMlhrYUZKcVlVUGVQa28xSUc0ZWlC?=
 =?utf-8?B?YnF5ekFpS0NScFcxbWtiN1UzZnpmdDR1QkxZcmZETUtWMW5uMzd6d0RsK0c3?=
 =?utf-8?B?V2V4K0dHajdoYjdGT3dFY2NlaUJ3dUpVcXI5dDdtVks4d0lmc004Tm5hNDRT?=
 =?utf-8?B?ekUxeW5iQ0NLOGNjUlVQWnAvTXIxdG5yQlF2aHRtMzVNajUzMHpCZDdkQ0M4?=
 =?utf-8?B?ckJTajh4ZFpHeXFNM0htUUozY3RBSWlEWUlSWVdiZnhkb21XVzF6V1BjZFQw?=
 =?utf-8?B?T2lzL3BTdTByck43ZWRFejgyUEQ3ajBKcWp1Sk5YWDcwenNyT0llblNFUHVL?=
 =?utf-8?B?NXBjdTUzVHgxRWYzemZ3ejNESzRRMFAxendNeGFWc2FMSU9kc1AzZlg1RkQz?=
 =?utf-8?B?MzFZM01vdm82TFBaUW9VNU1icUt0WXA5dXdDOWt5cXZCZERYcTRRYjdJWjBZ?=
 =?utf-8?B?K0VQZDVuL3k4YVFmU2hqUFE1Nnk3K1JtZ1RnODFTZHR4K1JHR1I0dTVraFda?=
 =?utf-8?Q?eZn1QUd6Uvt8ot7gKeKTT5NFd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vlo+BZZrZfqPPziwnctK0Xrlj8+fo8ajWXfHguRCHZHUf1ZG4Zm0Trn8UzHr6BzXthxfsNyvrdGIb+iEjE63nqJjIBcHvBKQiL8qTJ3smEl7Rnnv/QihBJAdoHMnM4UoML4YN/89N1hchFQ7Ur7TDMGgClzfzGwoNWYoTfTV8KGvSHNdDHGw809Vpzbr4rZhy6OqTt/rYdIqSQYlQmPAZFCbtDw7Z7XeAfSSIUW+su/IM6+DpWxjn1t7u2rjik+4ECrgfX8XU3vKtc7YTqEmCIviRV575bG2qBfEtMs1S6hYGOS6W5X5t92MBQ8jDXFtbtgXt6sYrYoSnZluuMqD1AI34F8bqbRNu9iznscWoY24zSj5T9AlfeVmmldB/5xMsye3iYH+xUWGUInAFkCCtx8OXOM6Y95CXCp9x2n8Tp6zbhGf41OAeUYicqDVRIwDlpqL8N7viDVbhx5ebm//iOm9hJjMUsimx76vfBqOTGcld/xW+8QRIF72aME/OxumcCF14nW5YeTgyYzVg1klxAOkZkjd8UZVj8e0GW6X8V+ra8QriorQb/2Ql7l6BEoGzp7OVW16IZ6nXueRGI7YoXB0iuFzfxVZR2FGoGhA1Nk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f23c1bf-7334-428f-9b71-08dd8f432db6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:48:05.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lokxfUrXzxdJEm4pPO26B3E5n4vY812bWvLWrxZNnJWjgtH0PEU0pAB0XCcHotu+A8jLg2+WrjC//bJRJRspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_08,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505090219
X-Authority-Analysis: v=2.4 cv=CPcqXQrD c=1 sm=1 tr=0 ts=681e781a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=3-kwICGER4M4OlQNuMgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDIyMCBTYWx0ZWRfX7ddoXW2ptpzd kOiveOEbOjnqrJfDCk04WDCZjAB9AnkiolPNHcM6T8h3oldZ6IU0O+IoQMMv/yn0A2x1nhKd6W5 5W1yRojayyN2O5r1CQUTQMwy1F02/Wm04naGRMX0/Q3YtPtai0nNruXINA0KkOEn5ftvgr2/ovi
 VENQHNuL4q5MS1H6gh2eBCvU0eEeg7bV/esE32+xUkItyz76Zjwi5Yqs+rBkQqj+Yrz3gn+z9Go yXmWw4JqDdpa6zxBwwDunLjulVsLGaMaClOQWEBu1/55ZxDJd+XU2hy71foS9ad72gBgC8BfZDh 1HFCWERbSzlCtwIRtuZwTF0Mn2kqFWjUF4Wjb6RwItPBL4BISl5S35cU+3eel4M5by4rE6hEc4p
 eSZ4+EmUSvPhcFvSVjW21Ut+dSJ8XOfhhsmzgDM0nk1f9A1XRR8WrDUqndCjOOKwtBXx7fpI
X-Proofpoint-GUID: 6E9Sic23iq_yU5nRs-mCOc_1kqoZXtMV
X-Proofpoint-ORIG-GUID: 6E9Sic23iq_yU5nRs-mCOc_1kqoZXtMV

On 5/9/25 3:32 PM, Jeff Layton wrote:
> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>> RFC8881, section 9.1.2 says:
>>
>>   "In the case of READ, the server may perform the corresponding
>>    check on the access mode, or it may choose to allow READ for
>>    OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>    implementation may unavoidably do reads (e.g., due to buffer cache
>>    constraints)."
>>
>> and in section 10.4.1:
>>    "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>>    OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>    is in effect"
>>
>> This patch allow READ using write delegation stateid granted on OPENs
>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>> a new nfsd_file and a struct file are allocated to use for reads.
>> The nfsd_file is freed when the file is closed by release_all_access.
>>
>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
>>  1 file changed, 47 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 0f97f2c62b3a..295415fda985 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>  	return ret;
>>  }
>>  
>> -static struct nfsd_file *
>> -find_rw_file(struct nfs4_file *f)
>> -{
>> -	struct nfsd_file *ret;
>> -
>> -	spin_lock(&f->fi_lock);
>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>> -	spin_unlock(&f->fi_lock);
>> -
>> -	return ret;
>> -}
>> -
>>  struct nfsd_file *
>>  find_any_file(struct nfs4_file *f)
>>  {
>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>  	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>  	 *   on its own, all opens."
>>  	 *
>> -	 * Furthermore the client can use a write delegation for most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> +	 * Furthermore, section 9.1.2 says:
>> +	 *
>> +	 *  "In the case of READ, the server may perform the corresponding
>> +	 *  check on the access mode, or it may choose to allow READ for
>> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>> +	 *  implementation may unavoidably do reads (e.g., due to buffer
>> +	 *  cache constraints)."
>>  	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 *  We choose to offer a write delegation for OPEN with the
>> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>>  	 */
>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>> -		nf = find_rw_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>>  		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
>>  	}
>>  
>> @@ -6116,7 +6109,7 @@ static bool
>>  nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>  		     struct kstat *stat)
>>  {
>> -	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>> +	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>  	struct path path;
>>  	int rc;
>>  
>> @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>  	return rc == 0;
>>  }
>>  
>> +/*
>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>> + * struct file to be used for read with delegation stateid.
>> + *
>> + */
>> +static bool
>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp;
>> +	struct nfsd_file *nf = NULL;
>> +
>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>> +			NFS4_SHARE_ACCESS_WRITE) {
>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>> +			return (false);
>> +		fp = stp->st_stid.sc_file;
>> +		spin_lock(&fp->fi_lock);
>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> +		fp = stp->st_stid.sc_file;
>> +		fp->fi_fds[O_RDONLY] = nf;
>> +		spin_unlock(&fp->fi_lock);
>> +	}
>> +	return true;
>> +}
>> +
>>  /*
>>   * The Linux NFS server does not offer write delegations to NFSv4.0
>>   * clients in order to avoid conflicts between write delegations and
>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   * open or lock state.
>>   */
>>  static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>> +		     struct svc_fh *fh)
>>  {
>>  	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>  
>>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>> +		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>  			nfs4_put_stid(&dp->dl_stid);
>>  			destroy_delegation(dp);
>>  			goto out_no_deleg;
>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>  	* Attempt to hand out a delegation. No error return, because the
>>  	* OPEN succeeds even if we fail.
>>  	*/
>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>> +	nfs4_open_delegation(rqstp, open, stp,
>> +		&resp->cstate.current_fh, current_fh);
>>  
>>  	/*
>>  	 * If there is an existing open stateid, it must be updated and
>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>  		return_revoked = true;
>>  	if (typemask & SC_TYPE_DELEG)
>>  		/* Always allow REVOKED for DELEG so we can
>> -		 * retturn the appropriate error.
>> +		 * return the appropriate error.
>>  		 */
>>  		statusmask |= SC_STATUS_REVOKED;
>>  
>> @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>  
>>  	switch (s->sc_type) {
>>  	case SC_TYPE_DELEG:
>> -		spin_lock(&s->sc_file->fi_lock);
>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>> -		spin_unlock(&s->sc_file->fi_lock);
>> -		break;
>>  	case SC_TYPE_OPEN:
>>  	case SC_TYPE_LOCK:
>>  		if (flags & RD_STATE)
> 
> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
> landed on this patch. The reproducer is:
> 
> 1/ set up an exported fs on a server (I used xfs, but it probably
> doesn't matter).
> 
> 2/ mount up the export on a client using v4.2
> 
> 3/ Run this fio script in the directory:
> 
> ----------------8<---------------------
> [global]
> name=fio-seq-write
> filename=fio-seq-write
> rw=write
> bs=1M
> direct=0
> numjobs=1
> time_based
> runtime=60
> 
> [file1]
> size=50G
> ioengine=io_uring
> iodepth=16
> ----------------8<---------------------
> 
> When it completes, shut down the nfs server. You'll see warnings like
> this:
> 
>     BUG nfsd_file (Tainted: G    B   W          ): Objects remaining on __kmem_cache_shutdown()
> 
> Dai, can you take a look?

After any substantial NFSv4 workload on my nfsd-testing server followed
by a clean unmount from the client, /proc/fs/nfsd/filecache still has
junk in it:

total inodes:  281105
hash buckets:  524288
lru entries:   0
cache hits:    307264
acquisitions:  2092346
allocations:   1785084
releases:      1503979
evictions:     0
mean age (ms): 400

Looks like a leak to me.


-- 
Chuck Lever

