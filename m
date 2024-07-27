Return-Path: <linux-nfs+bounces-5102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89AA93E14A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 00:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E51C20AFF
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986361FB5;
	Sat, 27 Jul 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DhmDKhv0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HyqE54LQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE32D058
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722118414; cv=fail; b=gHaGsxCroMGr5120xbkSbIVcyI706tgdpf6Gk5+T08uLmyqtWcJ7YnWkqcN+tjxb+s6jk+46VdP4x3ChTzPsg4/p7BLOi4mRpADTgeFft3MSJLWPLMjBB3hAxDBDgCKD3T9u36QPh9T1foMCQCcyBlRb4gfwM2dPA09MTfx+gIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722118414; c=relaxed/simple;
	bh=73YMicw/Y2UWNTi8ze4FUKnPgcnsRawIzzoYV1uA6Gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+tqUCUzNR/WnVh+mcJ1NZUJ8wWFnvozxX08TFKe1w4uz9+b3fK9+I45zko91D02DIWXt9kNTUI0DBAt0TV1+VdcfA1XcbKERvVUjVzvYLaCQBdecnaMGvdj2r+jG2xXF7WmEc5SSsxBy6MxiF6To52JC4ba+jMy3f8QcRgCr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DhmDKhv0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HyqE54LQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RMDOAY029897;
	Sat, 27 Jul 2024 22:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HfnHzOh3mVkdPSRFOIeFvUgGEuzTYqcsxGr89b1l1fw=; b=
	DhmDKhv0WcL0AzTjnVV+isPtc/Q7kYrRe5/lzuX6VQKBK9Lf7olRSy3++VvOR99X
	4RTElqWDmCAyfN6svUpFNRFS4A/dnCvB/WW3NKO4lbJXrwQpgAf4TrR8QFAZysap
	NlNDASrgSZ/j0qx5e807fj8dpqxmZ0vhtCOh4BMBNBwCzv82fI57tUNC9HFYY/WE
	PTP69Gy5/s6AN3isUFaBdRxVlXFOT/CK1nVHNWN69QkqfpPUsjSFzuapu71YnPn1
	DSXagzesiVtJw898fWOx7FBHTV41Siu71KtsDHpJkm+DgaOAz2a0+afcYzchJynT
	gOcls563ZRObWn/cDi9PNA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8gjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 22:13:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RH0tMR037284;
	Sat, 27 Jul 2024 22:13:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5rdwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 22:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfGCt068mkR6/ic7Dyp0AHnFpVFjq/N5qFUjFppj1o2GD564Wd65JXeUra6VSuTtMhhOxcl0opqcoH4Ts7Ef/8e+bff4WH4j+ETVeqFIPlEoH2yyj2wf8QfM4LYBDeuaJ7xG0sXTTegz/r7EGiGjd4Hk24fHZGeDj32GVn4x7aeKQDK1PUdDrpwhIfZHqEmvG4FzuOt7t5qTGavVQxYu0vuQMjYZteN5FPqJfSjlDnBhB3TH/mSN/nGB38Dbq5ERNRDa5TZia/ZkG+sBZ/H3nMa4FxnDrhSOR1PJXoBktJVkVf2dAjn8LJrGht171k+Pl7IGjUs70jepNEZRCnfgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfnHzOh3mVkdPSRFOIeFvUgGEuzTYqcsxGr89b1l1fw=;
 b=qzqPOgiDHq+7Fc4YXB3Flmo1TynlG6bWoiSOMorZkMB0fC9F+yZC/W4n8hw5saqV4ZKmLXpQXrj5WIZCvy+eNMrsm0ovDf4DyL5SUY/ErV/1vkazj8Mnavpp9/nK8WFtFiwMOpPvmQ1ErgQwfwWV+QiMuXuTz/iBGac/anO+ib/LFrZUoPskXidDo4plj1qL9U3jWeHSUl5jevsxexqCG5fG9kE7Yl4uWK9uHFW037Xk+hZ59p2oxJUV4CmVxD7ghSfJuvD9KM/X7V3WoZ74CViuHMEwUPbmLacEmpvuBq+KZaahyH1kiLg8gwkDef7Xk6Iar4CL00wQdQSPLa1KnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfnHzOh3mVkdPSRFOIeFvUgGEuzTYqcsxGr89b1l1fw=;
 b=HyqE54LQUIlAsVFh4KvxrnhLAqQojBRnGzlOipS7bno32tL0Q6G1vOf/ObY5NrJADmPuVUk+sCjvgbMwA3VY9vD5MChKYsGkJMA2guYq1nMENd3XkrtvC99v/GPF0kAcuHDbyuMFfrcQgDifinl10T6CmFgdMEh3B+uBEvrK2Ww=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Sat, 27 Jul
 2024 22:13:10 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.7784.029; Sat, 27 Jul 2024
 22:13:10 +0000
Message-ID: <c0804a7d-6a74-4f46-872e-785b9cfd7410@oracle.com>
Date: Sat, 27 Jul 2024 15:13:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
 <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
 <c1463e37-ae0e-47d8-93d6-9787ff35c989@oracle.com>
 <ed10be52-2853-4cf3-8a8f-7adbc6dd865a@grimberg.me>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ed10be52-2853-4cf3-8a8f-7adbc6dd865a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA1PR10MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: aff8ca8e-7b0b-4a9c-af91-08dcae894cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDhDQ2JmeHRacWJMZWlGcElnODZCQUtqR3pUT28zTmRFcWdvT0NhREtaNWpH?=
 =?utf-8?B?anA1RWhpajRQcFp3Q2tZeW1jSW0vMlpKeUgxQkJvZ2tBbmljaTlVUUdycUNh?=
 =?utf-8?B?cWhZN2JEL092Qm8ya0VnVU1SRXFoVFBpR2lMdFF0ZWxoTXBrUWQvM0tmbXZx?=
 =?utf-8?B?cERzaC9xVHBSTGlteFdJYmFTNHpaMDd2bEREMVpQZG5IVmtCWjFMRFd0bWtS?=
 =?utf-8?B?Ym91cnFhVW95THFsOVd4bG1aZWJlV0ljcXdoVGc5OUxTR21Ya2VhN09TQmFE?=
 =?utf-8?B?RUs1Z2NXT2Nid3RKaVQ0VHdKb3MzRmhnbmZZeWxzSmw4MUJOaCtCTUFCaGZj?=
 =?utf-8?B?NHJOK1VDS28zK0owekkzNHlwWHZzS1hSLys5VWpnYTJPL0I2MGozaGlvMElu?=
 =?utf-8?B?RXpoaTRkSS81YlFKbmFoRzhCQ2YzQVg3WWlsQkJaR1RsQ0FHU3dkeCsvMlJR?=
 =?utf-8?B?eU1ZdEpwWUFYV3JFRzRJL1A1b2dHZ1BNZkFuSnJWdTVsVGxOdzFKbVVvS0FG?=
 =?utf-8?B?RE1EMnUwbUI0RVd3WHJMZ1ppVkhoTXROSEx5MkZHR1M3a2hjdXFYL09GMThW?=
 =?utf-8?B?Y3VpR1ZTelhybFpwUXVXNitOZlV1STNzS2JPTTg0TlI3MmlWV0Y5M1JVRENY?=
 =?utf-8?B?R1Y1ejZJL0hnbTEwdzJGUzNoWC9kV3BoTmxnY2RjQnNBOFpHa090UVVwN0l0?=
 =?utf-8?B?dzBoQ0d6RHp0SmtpZ0t2ZWhGOGV2bmRTSDVZeE9BLzNnL2pvbmQ4Q0lvSXlY?=
 =?utf-8?B?bnhvTGVUTUNWdFh1cnhTWGdzMlpHOXRNQzhVYjN0L2JzSCtoVUZqdytSSUtL?=
 =?utf-8?B?SnNxYVRhOWVEKzlLaDJiT1pPNEJTdlN4VWVjT2xlQ3VSM1dXLzEyWjh3U2M1?=
 =?utf-8?B?YWdyNmVpWEFXZGkxdng3T2dQTlRTanVRaE1FYVFLZStlSEE0cTlUSWhKeHNn?=
 =?utf-8?B?MGVNS1RjMG0yZEZ2Z0NkZlpNQWMyWmhXWWV1ZWYza2k3cUFKQU42bUlMd09S?=
 =?utf-8?B?WnplR3FTcEpEVnA3TUdaUUhEd1REdlVqQ2R5QlI2T3l3MmVCQmZjcnROQzBi?=
 =?utf-8?B?WEtEUkZEejZqS2hkdUtLNGxRay9jS3lIdzVwTUVSQlZySzFsVi9hWHluNkNj?=
 =?utf-8?B?eE9GZ09Wc2VuMUlPR2VvUW5VL0UzRzdPOElJbCsxcGs2MFFOdTczWWZnSWhB?=
 =?utf-8?B?SG9EWi9ObWErc0VIU2NKVElTNGI0OGoyUjVLeUIxM0xsNTlPTkNoSFFHOHFK?=
 =?utf-8?B?YVhWZnd0SEZGTC9EWUpnNjhjQVVhQW5OejNvVjBaZFJMRW1oNFptUCsrUzNE?=
 =?utf-8?B?VjUwSDZVd2VxbU1HcE5yQmNaV2ZGUEE1dmZXNlgvNEE0V3FLZVZpVkx1dXRT?=
 =?utf-8?B?R084d3FCcEJHNTZQcmxyK1Jtd0JrZ3dTYXFhT0RFUkw4elpNYlVLVGJwc3Jj?=
 =?utf-8?B?Y3ZQMlptcHhwVGVzcGpOcjVGYS80eVAyZkhQbzg2Ti83eEsvTEVveDk3Y2R3?=
 =?utf-8?B?MjVNcWJDYlUyMXh2NlEwcGZkbEdFVUt5MWdIZlBrd20vVVlVRDhFaWRDR1Zi?=
 =?utf-8?B?R1pNZVE3VGNRK25TNjZiUlRPOG91UXUvSmNRUHU3VHhheGlGZEx2bytmZTBp?=
 =?utf-8?B?aGozWXM5aWpOVzdEb3BEbktRVDFERjZuNXJTUFovS216MlBIRVl4U05SUC83?=
 =?utf-8?B?Q2NMOFZEWHdOUXY4MEJaeGxvYVdtNjJvVzBhZmJsTUswek1RTEhNMUt6RmVI?=
 =?utf-8?B?WXNBdFZRTzhDWWx1WlV3WndzQ1NpUTliOU9QTG1wbnZHakxISWlXaEF2Vm1Z?=
 =?utf-8?B?MDFxMjh3QVJQZElLNW9mQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGlYVVFhUDNJWnRvY3c1S2hBd2FUbzFuSWNtOW5WZG1hbnRIOGJJSUE3NkNG?=
 =?utf-8?B?dDRlMldDeHV3QW1aQWxLeFY5OUVVT2xkcUF1eE5zMXNuNUhCWmFwSWdlSWto?=
 =?utf-8?B?MGt0dlZvRmVpMHYrNVROZ1hoSnVmZXpYM2Q5dFYrTnpFNUNhVTdsNVZHdlMz?=
 =?utf-8?B?N2RrajV4RCt1T2pvZVF1ZS9NSzBnQ2Z2azUya0x1WWY4WTVWNlZPVXd1YlFE?=
 =?utf-8?B?TDE2bXF4MkJiR21YSVBtbmxYemMzNWppb2QvN3JhR2s3Z0Y3NnYvZWlUeGtL?=
 =?utf-8?B?NkxYakloZ2J4MnZBaFhlYnUrRUJDYTlUbXNzQ3l3Wmx4TmpBSDVCN0xrWjV6?=
 =?utf-8?B?bUcvanNXOFViOG8xUE5FbVNMODR0SlJDbm5hUmZtZ29KZStJVUpCMTFuK2Uz?=
 =?utf-8?B?NG03ajFFWjlFQzBnVFM4QWJ1K200RXlpZHp2enRyM21FbitqR3JNRnNaSFVk?=
 =?utf-8?B?ZG0rWUhpZ0pvNTNlWityY2F5dm9iaHJPL1BzckYzcUxLOVdhek8wR3ZzVVNI?=
 =?utf-8?B?K1lxZS8wejZjNm5rOUVMWUJ3RUx6emFVeWJ0a3E4OCtUSWgzVGF4KzNHb0R3?=
 =?utf-8?B?MW1GNnBIdWl5aVBXSHl6RFhHbHRTN3dRWkVkaUtCODNKSy9EQVBBZFg2eGx3?=
 =?utf-8?B?aXZtZUNySWl1RnVUUmNzSEZNbStwcG9GVk9ndFl5LzVGRDRrNUVENVBqOElM?=
 =?utf-8?B?NEZtVWpoa3V6bnV3Z2lJQ3VZUFg3L0V3ZTRab1gvZEpPbzM1QmZ3QVZ0NjBx?=
 =?utf-8?B?K2pscldBSnhpQUdQR1VjZ3piSTJDaiszZkpBNHEwYnNaa0J4N1JteERTZ2hT?=
 =?utf-8?B?S3lnMEtGTHc0cmRZa0Q2UzF5SmtmcUpSWkxvdHJUc0ZSUVduQmV3WEVtVUw2?=
 =?utf-8?B?UkdzamxaeFJBSlhDK25wZ3YvcXRqRGdLK3RXclhicjBnUTB2aGxGQTh1UjYy?=
 =?utf-8?B?ekVaRUdwTmVFTlpuOVBnbWJsNEI0WDZ5WTl6Q2VrOXYwK1JJYnBPOFhERmYw?=
 =?utf-8?B?aUhmL0F6cW5sSlhqUVAxajFHWHkxVGhTZ2luNkZrVUVqeXJZSmQyRnFjSzhx?=
 =?utf-8?B?SWVmVHBjdCs5dWZUQUxzdlBWNUNQcmljZkJZRXpTbVlSd21WV3BoSlVXU3dO?=
 =?utf-8?B?T0R5a2M4WEJXdHpUd3BvZVpaQ2dDOHJRKzRzSG5ibWxYY0JqOXdMZURpUDhC?=
 =?utf-8?B?aEYzRlJSTldXRTAxZHkweHE0Sno1ejEybkZwblpXQmEvWG9rUmtLdC9Wa1Iw?=
 =?utf-8?B?UkZCZnRsenZWc1RoUTI5aE8zclNyeG9VdHRieUxpbjVoTCtJbGsram56UTZy?=
 =?utf-8?B?WTdUT3kxZ1R3cXMvNVBvNElzcnZSTElReWZzNm16YUxIWk52a2dxdk9XbDBW?=
 =?utf-8?B?QkJyTG9uekZZMDA2TCtmY0pMcEtyYXdKS0V5bVBncUcwdGJJYk9VTVNDMDBB?=
 =?utf-8?B?RjNyUnIyY2s4YkZEdC9wVkd1UnRSWjdEeXF2L2U1OE5aNmFtZWd2amU1dTZX?=
 =?utf-8?B?eGJhT0RnRW55dVhDZkJlQ1c4aS9XS0JyTzZ5blFiNmk5YVdzdyt5TkNnd1Nr?=
 =?utf-8?B?WkNjbTFqa1BxTjg2QTF6Z2xaaEhTMkZjaUVKTHhkOTZBTXY5bys3b2ZnTTRS?=
 =?utf-8?B?bkZDOXNxWW1wSVdLSUQxSytHMyt2REt6OVNWaHVRaFNUQUhHaU9YSHF3TTZH?=
 =?utf-8?B?OW1hZ25CZ1lZTWRtUmlSY0NaMWd1QzVvcVQ2V1dZVVczVkMwY0NqOHNLSitG?=
 =?utf-8?B?M2xNcGJvbmpjNzFDNDVYMGgrTWcxa2pSUktOQ0RtbmVTczB0NnpwRU5iOGZR?=
 =?utf-8?B?VlN5T1RlbzN3bnRNcEd6TW9pS0llSklWS3dkVm5lYkVBWkRCRjJxalpUL2tS?=
 =?utf-8?B?ZVFEK3hBS2Q2K0krbzl6akNGMytZYmg4eGk2eklPWG9YbHpSZ1lia2RnYW5t?=
 =?utf-8?B?SGJYclpaTFZVcVpDdTg1aGkwYm43RUFZZ25heHBRVndaSHhiUG5xNUNYNzQ5?=
 =?utf-8?B?dzRkOHZxYkJ3K0YyeGkzMmVNS1FWdDM5K1MwSVAvaFgxSUN5QmVMWGFOaWVE?=
 =?utf-8?B?OUFERVFIdEQ3dmdzMUYvc2hCMlZNQS9Mc2xTaGcxUUdhL1pkZ0RjQlpaMmlO?=
 =?utf-8?B?cEpXYjZCUlAvcUUyS0RSWCtpeDJGbFFjTUZBcEhraU9Ob3pZNlhYU3lKa2ds?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oZcQc5K1JyzJs8TOMBqEEi79iGlh9+y9YopsArwDN7Lii0a/pzfrEktbF9NWu+KI/Woa9F+na3qZAbF4jyfbczuMj2AOCY/Nju+iJq3vEak7Ly1PeKCYedTWDKtC5nO/IuixzPFH7LDPVmKUEY8c/PH8Th6Dti3cL4We9ev8XIYSigIY/HASUbYVCBO+KDVpI+86Jii1I7AsdlgGh4h1NBrSpT/WJBVIxsiEnS2fLC5wCD2EbIJrYpTSQdB/jAkOudkqHvrDzxd6QiHJOqMupubcIaKLMqsKq7AVOWsVDkzEmFPV4EZ+VU1uxYASqBQ790NS3vueHSk+v2QuPYh/qGpagcm5apQtAEW+Tpg9W342yCwnUdwTN2u1L2ltz7g87KT3H6VSq5gHOufADBOCTK8OcKRNuIVZI9t9Kbh4+aIB87NDSdVZzKTZy/OI+/Tj+jxMakIQuC2gI/08JVz7Qsl451yHPXoUfAxaqEojOqBFXSM1e0OPsUEZcsgtQ+HGpmrh8KYYo2MbIJGQ6b49sGUG0Q3h+UJMjSsGXQKdyv1WrW6QNZAUtoLh+ZBfhyVyVu3ZMhhuEy80i+11ilag89Amu+/7gHo/dHQHHPk8gUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff8ca8e-7b0b-4a9c-af91-08dcae894cfe
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 22:13:10.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGw8MJ+e1KIF9jIzjPR/SMvKuNv6WNBEpiIeNrwFPbAEfD8ZiZ3vW+doNxtZDhHmIP9GoYEqPrvl4efkr9VWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407270155
X-Proofpoint-GUID: ahJzK8Djkvp_QNYmch5FFVN9ecreXdVR
X-Proofpoint-ORIG-GUID: ahJzK8Djkvp_QNYmch5FFVN9ecreXdVR


On 7/27/24 12:33 PM, Sagi Grimberg wrote:
>>>>> id(cstate, &u->write.wr_stateid);
>>>>>    }
>>>>> +/**
>>>>> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
>>>>> + * @rqstp: RPC transaction context
>>>>> + * @clp: nfs client
>>>>> + * @fhp: nfs file handle
>>>>> + * @inode: file to be checked for a conflict
>>>>> + * @modified: return true if file was modified
>>>>> + * @size: new size of file if modified is true
>>>>> + *
>>>>> + * This function is called when there is a conflict between a write
>>>>> + * delegation and a read that is using a special stateid where the
>>>>> + * we cannot derive the client stateid exsistence. The server
>>>>> + * must recall a conflicting delegation before allowing the read
>>>>> + * to continue.
>>>>> + *
>>>>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>>>>> + * code is returned.
>>>>> + */
>>>>> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>>>>> +        struct nfs4_client *clp, struct svc_fh *fhp)
>>>>> +{
>>>>> +    struct nfs4_file *fp;
>>>>> +    __be32 status = 0;
>>>>> +
>>>>> +    fp = nfsd4_file_hash_lookup(fhp);
>>>>> +    if (!fp)
>>>>> +        return nfs_ok;
>>>>> +
>>>>> +    spin_lock(&state_lock);
>>>>> +    spin_lock(&fp->fi_lock);
>>>>> +    if (!list_empty(&fp->fi_delegations) &&
>>>>> +        !nfs4_delegation_exists(clp, fp)) {
>>>>> +        /* conflict, recall deleg */
>>>> I don't see how we can have a delegation conflict here. If a client
>>>> has a write delegation then there should not be any delegations from
>>>> other clients.
>>> A delegation conflict is possible if the client is using an
>>> anonymous stateid to perform the READ.
>>
>> Then we should not detect any delegation conflict from this
>> function.
>
> Can you explain why?

It was my mistake. I missed the part that the nfsd4_deleg_read_conflict
was called only from the context of the client sending the read with the
special stateid.

It's probably clearer to separate this patch into 2 patches: one to allow
a write delegation (opened with wr-only) to read the file and the other
is to detect write delegation conflict, regardless of whether the delegation
was from an open with rw or wr-only, when a special stateid is used to
do the read.

-Dai

>
> If the client sent a raed with anon stateid, this function checks the 
> pending
> delegations (fi_delegations), and not from the same client 
> (!nfs4_delegation_exists),
> then it should detect a conflict.
>
>>
>>>
>>> One thing we could perhaps do is add support for the use of
>>> anonymous stateids as a separate patch.
>>
>> This would be a separate issue from allowing write delegation
>> stateid to read. This would be to detect the scenario where a
>> client using special stateid to read while another client has
>> a write delegation on the file.
>
> As mentioned, I can separate it, but this would make this patch
> break a pynfs test.

