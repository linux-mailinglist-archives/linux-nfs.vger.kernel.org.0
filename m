Return-Path: <linux-nfs+bounces-10993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD7A7952F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 20:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5893AF537
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66D1DE896;
	Wed,  2 Apr 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5oDy0ae";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iVwX9+SC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85419F461;
	Wed,  2 Apr 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619019; cv=fail; b=sSMQ3cG49C6Zk25VkgS78Su1jTOd+Z4ITywQkgYkmJ52tkGItborOwPL6obRYHkxEJpxEjtpZy37NyhpF53y622vNg/APM+uYc6J3qDqpTI93DV+7rfW5W9togq5Hqso5KVBEZKvOaaXYPWVRMl4YTIBIhSNtKyGJ98gvbJpTIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619019; c=relaxed/simple;
	bh=0nsJqQ7lS8Se4uPIVRS2wxeHhV18WfhK79/T4wbZ8gY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQDYJjCjM+jITlvZz0mT2hCNEWk8xNp7jV2X7JDhDOFW4/NExp0oG/x23KLgdFRxkcS2jHzMsTUE2Y5tTxuTZ5prU1Ae8rlc2TAV2ybevhkcTg5KIDeZ2Fuj1mEeVrUHZt5DQ3oA9q4iYqQTX3uYoN1lTiKNmfsRQCepp4IdWVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J5oDy0ae; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iVwX9+SC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532Gu04L007068;
	Wed, 2 Apr 2025 18:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2wrtpRsOaRXbTDQxHglnMTyK1iKRH+PO9F0OASP15V4=; b=
	J5oDy0aeg1WQFSA4YH1PFx3XNZq6T7EJWai4o0Tcf7gA9S4VTzJadZd6KCooZ0Pd
	SLwjldfROtvIWtnQGZZz9LNfCIj6QS2NSdTvh4BfPPVGHa9TlymN60AHiqDK0nHW
	cRrivd+VtuJlNSXW7l/MFK1gUOA+69ta7F9jKZvz39lGrM/subLlnMmP5en2R2QY
	rjQiUOcEKp0i5IZGnAoJ1gokqj1JOhNLmzH6Ddl4jFGbrrwTj25kqlrhBJH+yXYQ
	QIKMjOl056C6dPL1r8mIBCWa2m8MO8QFJ/Zw5Tfta8vhjwjUb1SVo8VevGenEgEP
	yH77T4Cra0seFp/0Lc6zaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsbfnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 18:36:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 532Hlpec004288;
	Wed, 2 Apr 2025 18:36:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7abagdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 18:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+wJ5xfzAmO2akdFaK4B4PKqAXVJaziBqhyjSMSSwV0TVXWZkQcdZG26tSkKawGbhBit6qjLe5JQYgOLDc5M7jCslHfzkV4gTSd8K9DpJpR6mAb1Yiw6e2a7ZMKYdxJzmIui1kL6UBIQaQS+KX74ObrdmTVXFbJukofL95pIEAMTookswXN7CN1acnLwSDBrzuufq2oZywQtl6RhowQ0Gvms671eL7O/mf+LnQGBfpzNXQckmdlRy8eBu02uz2sLgkHsrLeuu49NA24oGPNhba2IhHHfwnHz+TL7kuYTk9S10S9uO1/xY77nkz0yda88iOCEpC0kwczPETxpXMekuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wrtpRsOaRXbTDQxHglnMTyK1iKRH+PO9F0OASP15V4=;
 b=ypIVO2Lt4DaciB3PTRIGvGAAmC6gBsm8cA+tRxl4rn6BiWGWUQQeLDv861GUtYHeWHVBtb6l38Cjg76ut2x0+uL+rmItZoc+W2oZYoiOSuqC4iat9r3230JEqDdyZZAp6t11oafOPw66v/4IxN7X5N0X/dW4hm8ICGbmMMqsH9s0SL8Z27MyIChTHfEsKSFCS2uVdluufPjni/TZkrAdNiGfDU+xLvuFIza8naPYIpYnresBDGF2Cp7rp5elxs5nugaJOKuwFZD5viXIC70gghhQNx2RTS9Pq+JDu1R5HBGpo352yDPB4E8oMOhgTLIUwERsj21pOUL+AQPEHPrOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wrtpRsOaRXbTDQxHglnMTyK1iKRH+PO9F0OASP15V4=;
 b=iVwX9+SCKMwfrI0eHufrR+5dorZMUcFYdHIKe3477ikzzRE2JHbiLOJMoVoG1sZm9XZG1pN7DB8v1qqzNEOzWCSpaF4jOYv5yV03X56sgoLTwd8r7blvIQmk0p2EMhPgxesMDEWA3S+7iJa38Kv8WF39slv5La7azHYu31sb2cQ=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.42; Wed, 2 Apr 2025 18:36:44 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 18:36:44 +0000
Message-ID: <01909c87-46bc-4ce1-8572-1c883962252b@oracle.com>
Date: Wed, 2 Apr 2025 14:36:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
To: Eric Biggers <ebiggers@kernel.org>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20250401220221.22040-1-ebiggers@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250401220221.22040-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:610:77::12) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b05bb0-342e-4ecb-fee2-08dd7215518e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RCN3V2NDBvMWNjQ2F1ajRIaGZEbTZhUVdXUGpzcWRNbk1mSmxEL0xpYm01?=
 =?utf-8?B?M20rc1lxdktQWmRDeXhKaVNQOS80RTQwdXVPYlN5RkZjWDRJUnRMQ1lCOGwz?=
 =?utf-8?B?NlFrdzRkL1BiVUE0UktXemNBQkgzQWF1aUdnVFl5U011SlJ0NHlJRmlQd3Nw?=
 =?utf-8?B?cmJrT3RWaVUwNFk4WE0rU0UxWkhiYWZCb0FFVWxGTGcvMVgzWUI0amsrMjVv?=
 =?utf-8?B?NnJJUElxcXRMREpUVzgyOWRPN2tTRXVzY2hjK29YU0E0b1Y5ZFYzaEhWeUlB?=
 =?utf-8?B?aFJDa3BaMWdGbG4yR210bU5pU09OYytUUG4vUDR6RmJjcUFwaWt3QjZmdFZU?=
 =?utf-8?B?cE5VR3ZEd3JaTXdmbkdQTVFlRVJtczdUZjZlenVMQjM4UW1pSGhyTjdOMjht?=
 =?utf-8?B?VWZ0S2ROU1pudWhpSGlxa21Oa3dWSDNPcmh4RHRGc3JsTnA5cW5ocldZcE4r?=
 =?utf-8?B?NjFvVy81SVJ6KzJDaUl5TW82QXZuL2swdEpEWVJkRWFlMjNCbmtWQVVnb1pR?=
 =?utf-8?B?Smd2ZzVRem1QbGkzaExqMlhMTTYvbXc0V3VKcFJocDVHK1FFTGhCNnNnTVV4?=
 =?utf-8?B?K0YrZ254MHY0ZEI3emJlV2JTMkZnTENPVmZhRVc5LzFBQXlZdDNWVUtKSE90?=
 =?utf-8?B?Q2UyalczZnRCSEJLM1hNSU9QWjlSVW1kdm5VdlNkYzZQYnlmNmhVYjJkZCsy?=
 =?utf-8?B?Kzc4ZXkvUXU1ME1EbHNGVlNnbXFzYmxLUm5aQ2hPc3BNdHMzSkM4TFgwaWVO?=
 =?utf-8?B?YVFJdnNzOWNkN0s1a2JlazJqQ1BETXJ3V05NbFBGQkFpR2Z0OUVFVlc2cFZn?=
 =?utf-8?B?YUd4U20xM0k4eWQzclYrS2YzNW1JbXJHbXlCMmFKUHJZOUhJL2ZPajlwM05H?=
 =?utf-8?B?cFAycmZucTVtNisrUUZEN2c5QlFoV21XSm9lSURKV2wvZmlqT0U0UXZQbWxI?=
 =?utf-8?B?SW9ESFZVcjRjdFBuZVIwY2IvZjFwdEw4eEF3NlNVaExRMkJHcDRuM05MYjdB?=
 =?utf-8?B?cG01dG1JeVlrNFpBNjFQL0xPODJYMmNPb0g5V3ppMzQxTS9DUGVKMkpWczdt?=
 =?utf-8?B?TDZSM2x6THl5MFo1U25ObFdHUFBoOGNZdEhzTndjRUFxSnpkS1hsaEFpMkdB?=
 =?utf-8?B?WU4vUnErTGprMEMvVGJ6UjF4eGhUQmlTSVdhR3dYZG1zaExTQnl5ZUJvcS81?=
 =?utf-8?B?RHdDUkpQb2J3K2lOL3ArSW1JVEl4S3E3L1pCcWNwbEpaM29xSVRwa2FCQjR1?=
 =?utf-8?B?MEI5Wk1sTW9rNklMaFRkOUNlaXoxZ3BOTEJUV1Y5T0RsTWhINk9idG1GMmgy?=
 =?utf-8?B?WkZ1bjFKL0ZmYkRVZkQvbGYwcHVud09iL1hVa01CS1dseWxVcnRsNzR3SkF4?=
 =?utf-8?B?Mk5wKzRsTUxBYXMwTTR2N3BFM2xRQWZZWHdNVGRVMWdiU1hyMVYrWU1UalJJ?=
 =?utf-8?B?RVdaeWR5SlF2Q3ErR3ZKWGZONG5vYXQ1Z1J1Ti9mRFR5OUVXYS9MZUxnQ0wz?=
 =?utf-8?B?SFFNNTIvNk5jSGJnaHNyMjNuKzR4VzNPSTEveXdHS2d1N0trSGNPcUo0bXd1?=
 =?utf-8?B?Ukgxd2dsVUV0WmtOckZTWTFZbVIxQUlMQ2JYOVNrZktkSmNEOVVIQnlMdGw3?=
 =?utf-8?B?UWJEMkU2dlR2YythR011TWNnL3RKaXltbjdqK0Q3cXNOSWM5VHVoaHRTdGJ5?=
 =?utf-8?B?MVZURUNLMUJBa05nVEI2S2hFa3RKaU92K2pZQzBCZWJqNHF6VlZLQ3lMN2ls?=
 =?utf-8?B?ZGZKdHBNUkZlaHVYdlZzdGwxS0oyZXBpaG1RVVNTU1huZWJ1Qk01N3RYRGFK?=
 =?utf-8?B?RkJwYUlVMEttMVZOQ05LYUpRZk0weXhYM3JFOVVIOE80VWthOFFIUXFheEFU?=
 =?utf-8?Q?YYzzZo7ol6Jt1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE05aW83VjhTTGxMRmNhcXZjeTNEdFRlYnRUNkNBa08rYmx0N3JWTDJ2TDZJ?=
 =?utf-8?B?L1JlMnJuY3BwOTIvQmxlMDdKSUx5ajUyVXcvTm1tZVBDeUI2QmVRVHhxaWsv?=
 =?utf-8?B?aFp5KzdGQVFwUkcrak1NdTBYUXJtbGltaVEwR25sWURGV0luR2Z2dC9OblAx?=
 =?utf-8?B?RmV4ZGx5Zm5id1g3cjN3bzJGRm93L1BTMHdNOEpSWTV1dVI3eDdRbmRjeHVy?=
 =?utf-8?B?WElkVC9GSXliL0o0TzNTb3NkNjNjdjVZWXV0clpzRkhmNXJZU0pnRE9JWWhy?=
 =?utf-8?B?dEYrdjBHeWZDVStmT3NndkdZN0ZPeW8zVlNhYzRYMklXaUZqS1RrN1RJOGc5?=
 =?utf-8?B?Mi9yNDUrWWJ2WktRZGcvbDR6OGV3WlRBZlFJZW94K3RUS0RhUHlnc0Uyb2VC?=
 =?utf-8?B?d3RaMmhGUW1aTThpNUxmMWpVR1orMktZUHYwSE1ZM0xWNXAyeTBUWk9tSGdW?=
 =?utf-8?B?SWVidTUweXU0c2JFMVV0OTVFTlBqRGNiZHdHaUR5b3Y5YVREYk5qSndnM2Vw?=
 =?utf-8?B?cVVwSWNwT2lmK0d3NGl5aHRuUkFpSjZvZ1FaMXRZeXdFZ0tSQXIrdXF0K3Z5?=
 =?utf-8?B?NlVtQzJVY1Z0SVlJQmxPWGVSWHNUdDZKbHZPYjNqL2ZvSDVTSjJhd1hEKzNR?=
 =?utf-8?B?YTRRclArRUZUSmw0RlFIWG93djBJOUZoMkg0QjhOKzE3TDlkeU9jZVVEQ0pW?=
 =?utf-8?B?SXorczBzKzYyVitPbDlKbi9RQThud3VOcDlXUDlLekxmQ3ZkeGtrTndpOEls?=
 =?utf-8?B?bzczSld4aXgrWXVIYVFoQkcxZ3cyMTdEM3ZtT3NFUnBveHc0aWFyS0tNOThG?=
 =?utf-8?B?NktKbVg3NDBlS2pVQWhjMjBIVTUwTW5zM05wV0Z0aTBteCtwMzExRnUxOVFP?=
 =?utf-8?B?RFdLZ2d2alU0VmE3V0h5V2t4REdtYlZIa2lyTFlTWENjc2VXN0JHekF1YUZ5?=
 =?utf-8?B?VmFXczJ1cGd2SXcyOTlUUHhBV2tUaGpyT0YrZmVLN0tnbDhQQjFuUkNtcHhw?=
 =?utf-8?B?MlE4WGNXaklOZGRiQVJ2ZUNJWlY4WklEZTZSR2pZaDVyZ2ErU1VpQjVQUEhZ?=
 =?utf-8?B?WGU1czhZZ1NHS0ZpWTVYd3dzNlRDN3RYVHBKT0tpNG9NMVJVWjc1TWhKMWcv?=
 =?utf-8?B?dHA1eWlFblN4eWk0dUdacUNlL0ZqU05CWXA4T01ZTzkxUjIyTElWM0l4elBi?=
 =?utf-8?B?Y0drWXJuc0N0OEkwa0JiK2VGYlhRcDd6ZjJWbU03SDlhenRQWWE2KzdRSXE0?=
 =?utf-8?B?dGF3OTluTmE1V0tYY1hveXdiYUx2SGlFU3ZUTmxvcFNCcFJUYkFIc2FIcHFr?=
 =?utf-8?B?ZURZSFNWellKcWgyZHJuNHlpOHpGQjF4a0dFYUFFUmk5ZDZMc3JFUXI3a05a?=
 =?utf-8?B?TTR0aW1zczc1UmxjQ1dxV2xIRVlsVVpoTk91UllEMEQwMys3K2lUV0VRSk1y?=
 =?utf-8?B?VGh2SVZaTGV0TWdmRHRYcTB4VXdZYjZzZW9oTWUwZXlzcmFhOUlKdTN1czRj?=
 =?utf-8?B?MW5zK0FabUQvdmJvTEkxbldTdm1yMktRaCt1MmJhVkQxTitKTlFaa3FmMlZL?=
 =?utf-8?B?amNsU1ZSYzg4blB2bG0rTk9EK1VWUWJwd085MTRyQjBBdUxHV1JNVWFoTjlM?=
 =?utf-8?B?OE9KWmc5bG5CTWhWY0ZjbmdQUS9QcGdzWWZGOGRKWk5udWFVOGZsTTAvS1NV?=
 =?utf-8?B?S2hHOEVDbVBKSm1rTGtzaUNuUFdaQm1wSXZTZEJZVUNJS01tbVVscitUeS9F?=
 =?utf-8?B?UUZZNDdRZnl2YkdoSGdQSzIwdFhISEs5Z3pBOElQY2VobGptVDNWOFNqbm05?=
 =?utf-8?B?WEU3NktXRFBkcGx5eVhiQlVHeXlhTCtFMVNyUm5MTzZYNXltZTVqUkR5ZlJv?=
 =?utf-8?B?UEhWLzBVR1NvNjhMRWtjUGx5MDlhKy9WcEc1SFZ3WEYyY2NPdzJySkwwb1I5?=
 =?utf-8?B?NXEwdEdEOElHRHhmS2VMVVlZaHR1eEo5T3ZEVi9PM0FXTllEdDdvZE5ZbnpW?=
 =?utf-8?B?OVExdHpkNnMyRlV0dVZCVTFRbi8vMjlmRHdNVmRBalo1YW0wTkIwV1g1ay9h?=
 =?utf-8?B?Q2d4TFVRM1YvV2hLZDRELzFIVzFQMTdvV2JMYkdzL01XakxUL0xHZndsaDc5?=
 =?utf-8?B?OGpZRnU2UW9TbnJPQVlINFZoR2JjdXEzUkJqYzNqakkyNk14OWRPbGlCYjNY?=
 =?utf-8?B?SFdsL0dNM29hVy9EN1R6ZzRoYmFSYlZlTU5MZlEzYjZCMng1bERmcnh1dTlk?=
 =?utf-8?B?bHNlTHdEUEZPeERibGVxNlR2alJ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AdISe+l5ODBusEwS5ROUsiXLlo2jgPH8q7n4WjhuscnOKbkMc1PwH0iJkm1GGcLqWTLdcyiqRPv8JQfuaOMvHdoCuQyHJjlyA50DIpjUcBHhw1Wk9BeCvvWaIobh/QdJ61YAb34ST949XI2kb5o1gNJHF4laVWqHjMBnnrnb7wSMb0cEZpfe/5/IAMUdSb93gHv8GSR8JYlvbEw8iyiuc1QhQ7AqbW47VI03hRHr2Q5rpyEcj02cE+LPhZrqRvUyOUX4rosbczbd/cUAhuLXGZ9Xs6KeD6kq6bknJDeaZ3pLNUkCCtNnBsEH5afYX5lIfUWmXN+QO9RnRQR1mzKXgWAKdj2gpvp/qH64NWbBWM00ehbwHjV06xkuMM18NdiotQQIPKiV5R8qA4ncbOxe5CbjTQvOmE41ot89c+kabAA1rqIhHgLW/MZo2YHtyEr3ovlKkPSCzp46gMk9vOl09psecbzDnzlm8424+zmXUBUMpRKhEfzsPWFKVDzbZLwGzXmWEYXMd5p5w16a8d77dP2PRhtOXMsYxbQaYhaLkrkzcOWOOSpNiGOxBPQKlsJZPsNVIzqw9pqiWJVdSIb8F/UPpZvWetdApFdRiCVP/6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b05bb0-342e-4ecb-fee2-08dd7215518e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 18:36:44.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEEKLIr31Dd/OF+I8Cqvh9UVxhN78o32Y8kKfu2IkrPPReQ/fe0PwXLCI/g5Dmf4l7QskklGTBTypyg0ph/WjcHoqpCPYENYKoTkfG4Kngs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020118
X-Proofpoint-ORIG-GUID: 8QHmxsZkQgEZ4jWvCAk4lfaCM_czO04G
X-Proofpoint-GUID: 8QHmxsZkQgEZ4jWvCAk4lfaCM_czO04G



On 4/1/25 6:02 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
> only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
> selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
> did not actually guard the use of crc32_le() even on the client.
> 
> The code worked around this bug by only actually calling crc32_le() when
> CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
> avoided randconfig build errors, and in real kernels the fallback code
> was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
> really needs to just be done properly, especially now that I'm planning
> to update CONFIG_CRC32 to not be 'default y'.
> 
> Therefore, make CONFIG_NFS_FS, CONFIG_NFSD, and CONFIG_LOCKD select
> CONFIG_CRC32.  Then remove the fallback code that becomes unnecessary,
> as well as the selection of CONFIG_CRC32 from CONFIG_NFS_DEBUG.
> 
> Fixes: 1264a2f053a3 ("NFS: refactor code for calculating the crc32 hash of a filehandle")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

For the NFS client bits:

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

Thanks for looking at this!
Anna

> ---
>  fs/Kconfig           | 1 +
>  fs/nfs/Kconfig       | 2 +-
>  fs/nfs/internal.h    | 7 -------
>  fs/nfs/nfs4session.h | 4 ----
>  fs/nfsd/Kconfig      | 1 +
>  fs/nfsd/nfsfh.h      | 7 -------
>  include/linux/nfs.h  | 7 -------
>  7 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index c718b2e2de0e..5b4847bd2fbb 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -366,10 +366,11 @@ config GRACE_PERIOD
>  	tristate
>  
>  config LOCKD
>  	tristate
>  	depends on FILE_LOCKING
> +	select CRC32
>  	select GRACE_PERIOD
>  
>  config LOCKD_V4
>  	bool
>  	depends on NFSD || NFS_V3
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index d3f76101ad4b..07932ce9246c 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NFS_FS
>  	tristate "NFS client support"
>  	depends on INET && FILE_LOCKING && MULTIUSER
> +	select CRC32
>  	select LOCKD
>  	select SUNRPC
>  	select NFS_COMMON
>  	select NFS_ACL_SUPPORT if NFS_V3_ACL
>  	help
> @@ -194,11 +195,10 @@ config NFS_USE_KERNEL_DNS
>  	default y
>  
>  config NFS_DEBUG
>  	bool
>  	depends on NFS_FS && SUNRPC_DEBUG
> -	select CRC32
>  	default y
>  
>  config NFS_DISABLE_UDP_SUPPORT
>         bool "NFS: Disable NFS UDP protocol support"
>         depends on NFS_FS
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 1ac1d3eec517..0d6eb632dfcf 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -897,22 +897,15 @@ static inline
>  u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
>  {
>  	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
>  }
>  
> -#ifdef CONFIG_CRC32
>  static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
>  {
>  	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
>  				NFS4_STATEID_OTHER_SIZE);
>  }
> -#else
> -static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
> -{
> -	return 0;
> -}
> -#endif
>  
>  static inline bool nfs_error_is_fatal(int err)
>  {
>  	switch (err) {
>  	case -ERESTARTSYS:
> diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
> index 351616c61df5..f9c291e2165c 100644
> --- a/fs/nfs/nfs4session.h
> +++ b/fs/nfs/nfs4session.h
> @@ -146,20 +146,16 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
>  		const struct nfs4_sessionid *src)
>  {
>  	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
>  }
>  
> -#ifdef CONFIG_CRC32
>  /*
>   * nfs_session_id_hash - calculate the crc32 hash for the session id
>   * @session - pointer to session
>   */
>  #define nfs_session_id_hash(sess_id) \
>  	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
> -#else
> -#define nfs_session_id_hash(session) (0)
> -#endif
>  #else /* defined(CONFIG_NFS_V4_1) */
>  
>  static inline int nfs4_init_session(struct nfs_client *clp)
>  {
>  	return 0;
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 792d3fed1b45..731a88f6313e 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -2,10 +2,11 @@
>  config NFSD
>  	tristate "NFS server support"
>  	depends on INET
>  	depends on FILE_LOCKING
>  	depends on FSNOTIFY
> +	select CRC32
>  	select LOCKD
>  	select SUNRPC
>  	select EXPORTFS
>  	select NFS_COMMON
>  	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 876152a91f12..5103c2f4d225 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -265,11 +265,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>  	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
>  		return false;
>  	return true;
>  }
>  
> -#ifdef CONFIG_CRC32
>  /**
>   * knfsd_fh_hash - calculate the crc32 hash for the filehandle
>   * @fh - pointer to filehandle
>   *
>   * returns a crc32 hash for the filehandle that is compatible with
> @@ -277,16 +276,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>   */
>  static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
>  {
>  	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
>  }
> -#else
> -static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
> -{
> -	return 0;
> -}
> -#endif
>  
>  /**
>   * fh_clear_pre_post_attrs - Reset pre/post attributes
>   * @fhp: file handle to be updated
>   *
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 9ad727ddfedb..0906a0b40c6a 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -53,11 +53,10 @@ enum nfs3_stable_how {
>  
>  	/* used by direct.c to mark verf as invalid */
>  	NFS_INVALID_STABLE_HOW = -1
>  };
>  
> -#ifdef CONFIG_CRC32
>  /**
>   * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
>   * @fh - pointer to filehandle
>   *
>   * returns a crc32 hash for the filehandle that is compatible with
> @@ -65,12 +64,6 @@ enum nfs3_stable_how {
>   */
>  static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
>  {
>  	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
>  }
> -#else /* CONFIG_CRC32 */
> -static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_CRC32 */
>  #endif /* _LINUX_NFS_H */
> 
> base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516


