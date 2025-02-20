Return-Path: <linux-nfs+bounces-10224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3FA3E3A9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAD017FCB4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA9192B86;
	Thu, 20 Feb 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqW48xem";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DbPcO2mJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F10190072
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075485; cv=fail; b=O0fDlppHPlr4XeFu/oVbrIcrvj+XkMoDVPa5b12MwseZXet2n/JCfsaatISP/6Trs7sIc8vME0T0j3eAP+ytr8nGfzUKX052L+y9LdndCZP/HVvg/3m+gCoOh+evWk9iixMR7jMi7GdRN/oyoJsPIv/vXtx9VM4xaSlORvUcQIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075485; c=relaxed/simple;
	bh=Xe/feTkeKUvduUA3SzDzc51EOdckfTbWM+9WR2GqBiw=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSn+GjSsjIZYpXMiGRPRYZRxmQxWjPVGWNs2GKCuHqT8qJSj1308GNVZGMfZuTeiMi6PhhB5B8462XGgwErfjNN+Zs2XpKg/JtlkBY75X+Xj327i1HYmBPBrVMBjxzeXXSqiGz9+t+kTUsr6Hf2U/OXEHQWC09LnKl10aFACq1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqW48xem; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DbPcO2mJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMqAZ007578;
	Thu, 20 Feb 2025 18:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2JOOXZi5WxrdPj9PEyX9q8fajoVEL4lRjLnOdmZnX9M=; b=
	lqW48xemoL4Fmb/SC+iZ1wr3yH3ar4AWTh/kCZLvDzR65jy8r8mdnS58XP1E6B7U
	1IIZXK6ZmlVbplc+7OkFtQ2owVSVcm+1YibR0qrEeWOqZGUA5J05QCiN7si2jU64
	XFILN6vaqig2lDZEXSLMN9mNa5WT2QkZWYmJuUXzOUobUyh9OLpYLRzIVHPDx2z9
	DF7CpMeG5Hc8X7D6V027xr6jcPrjWwCkaw452EnrX7jUPewaClp8iHL+fLg+GZ50
	Hb01RQDbVk9x8M/yPxTJBD4uUcxapsBUAAXJPyGZKBULzyRu3amHYdg3IXDiZn1s
	gdQRaT7iPzBkrbJ8eGiA+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n4rnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:17:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KHK857012038;
	Thu, 20 Feb 2025 18:17:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b49aad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUNtlfki5qEPIaNlkPtvqxmZErPNjA/PBw/5kp/bnyu75iKtmUnqAdrqHWeh+aZDdm+4nU/e0y+kQeEShXQugpCqxY841ugUObmCgsSoueQB2wVJ8FijZM9/lt13QoYQMbOaG6NtI8SDuwBZ9HQCXyGcN/JABVxnxH8G4tcTMYrncbcCGApo5RhDgzWlDdaMBjTXQRYQ0S3cSDELXMjOEKaiOYX2KQb+862DMVoVIdPZ/yi0MGDyTI/2PdCeN5alkdxg8Z73NCkrkC4ZMZM6FvHlT27Rd1hGHnD7d9YTHsv8WRP+lcfGt7SiXNXwZpNdKQdUKoo1lUFMZrqY2yNW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JOOXZi5WxrdPj9PEyX9q8fajoVEL4lRjLnOdmZnX9M=;
 b=eF4qiWF1QZlHq5Apn4ixdLLKj/zUEMwxDFes22286tB5tWrJvzBNobMegGo6PqPpkKe0mhM+vzBKhqCUT6rGQMpTwn1BYQK2ifESFa+IFfgPUXa+FXQ2ftWWCa8VvMgO76Q9HhMpURrNScnIOONwIdmU8cEejdbWHDo/isx87eyDVFexBXIDC6aKRe96XS//ik082boR3mxzsFPcB3g3lUavZhWbTzl17Zm8rfOuLJc/gp9swBh0e8F2ztWs43mfPJYPiAguE6j3f7CjFj/j9w561BLJ07yLd7y4tOBoJyvEFtrgvKNcWztFieudxgH51Z3gCIdb9Imhi8gR66GfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JOOXZi5WxrdPj9PEyX9q8fajoVEL4lRjLnOdmZnX9M=;
 b=DbPcO2mJyMgwvlUjtTGgaqCG3+UZoPLkrm/M3kUmlWYNLbpawNk7ApKTJcUBjTLxx30HG8Kv3P+EHAkxtjCatSjf/19+xckxkkPvxdOnv48rjoh2pWLOlgYhBwlgPJQQ7J85mMp13Cl5Is+sXlbP9GVcjQoDNTXd6CTt3k5XaqE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:17:44 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:17:44 +0000
Message-ID: <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
Date: Thu, 20 Feb 2025 13:17:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add the ability to enable use of RWF_DONTCACHE for
 all nfsd IO
To: Mike Snitzer <snitzer@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250220171205.12092-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 341abc5f-c739-4692-4e17-08dd51dadee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGFWK0lKQWFnOXhNYlR0QnVBTTBMU2s1emg3bTNJSEhsZ3FIZW1CQVNadG5W?=
 =?utf-8?B?UEltYkpqUXBIYXNIWlVSY1AyalZ4L0M0RzZ6Y2ZzOUtkMVRJeGxHaFV6RjNl?=
 =?utf-8?B?eE05Rm5YN1lPUkZ4bmozc3dOd1FSWWpCTkZsUk12ZDlKUGtuR3ROTG5XUEYr?=
 =?utf-8?B?dlBCUHN6MGNZQUxzQmF3SytXU0d0TlFaUCtHS3hPTDJCdXhkQ3M2M29TTElH?=
 =?utf-8?B?NzhiWWZVY3dQeDJRQlZvZ0dwa3hESjA0MkxFUGt6OS94TDNOUW1EdjlaUE94?=
 =?utf-8?B?T3VVamQ5dXZIdEIxQXJwbkUrUmlyQUtSOVZmQXk2WHdqZ1B6enFRYzJhOTJV?=
 =?utf-8?B?ZURzaE9hKytRcVNLUmh6UVcxZ0RaY3ozbWJYbDVGbEVaZFA1Q3JtbG5KY0lO?=
 =?utf-8?B?TTkxUUpuQ2toMm1aMnROd3JIUEttc0R4ckNPTTR2c2NVdjltaEY2T1hSTXRI?=
 =?utf-8?B?cFRLZWxqNW9pNDl6b25wS1V0eDBTQURWS2c3aks2a3ZkbEVVaXYyMjF2ejl0?=
 =?utf-8?B?T1F6OHoyczEwQzBobzdWZ0taOG42SDhQVi9NYnZhL1pxdHN0c2hGcnlpU1hr?=
 =?utf-8?B?VDFpRVVtRXU1bkF1OXVSRWc2MnRVT0NiMS9TbThrYWxMc3Zmem5pY05FMndk?=
 =?utf-8?B?QlZnYlN1cDd3SmVkNjVzNStCRmNCRk5BUHc1S0dQN2ZYdjhOQldkWUhEQVJR?=
 =?utf-8?B?YTNlYmNYSVdHYWhja3VmVDMvRWtvUEZFc2xsR01xZ25EdG9zSGgxUkhsVXRV?=
 =?utf-8?B?VnJLa0pkV3N1L3BXdkJOT0pQaVpVZWpJVjZaenlIZm8vTXVoMnZValRrWGVG?=
 =?utf-8?B?RitoSkU4Z0JJWTZVN2dWQnZVMm92c0IwSmx3QUNhNmpDM0hFREtJR0VhV0lK?=
 =?utf-8?B?cHJ3dFMyL25hVlFhc0dTM2RtcUFrNlJteTZ6TXFzekROd2Ywdk5DNjdRUytr?=
 =?utf-8?B?YWZSUXBLNGhDZWE0anE2Y2VzSWFWWmI3Q2lNZFlzVnJPUmFrWG1jME44Y1Zp?=
 =?utf-8?B?Yk1WUWEzWmF6bzl4cUtkUHJBN1BFRE1oSlNMWWhPa2hxdjUxMTVoSFVPZkxN?=
 =?utf-8?B?dWZwQmU2ZGpFSlUxemFGMllvNitBaWo2OFA1M3hLYjF4K3RUUGw4NU9acktC?=
 =?utf-8?B?bDh2YS9IbGxQdTdnWVV5WUliMktuUDliQ0F3bUZxaldYVExNNUFYc0ZzTER5?=
 =?utf-8?B?YU1Lb3laMmVYQnY2RVN5V1ZtQzJWMnFFZFBHZzdtTDRxNStyMlZhajdNVzFw?=
 =?utf-8?B?Z0lqdU9EQjhkbWx0Q1NnSXgrcE5IM1RTMURha0xwRzd1L05IS1NhcTI2bWhq?=
 =?utf-8?B?V3Faa3JGNjluVjFWR1EzTmNwOFJJL3EyK2RHRURCM2hzRlU5MXozTjg3YXBs?=
 =?utf-8?B?VEk0SU1oM0Vzc0xBR1RrVndQWFJURERYSVZXbGcvMXF3eUpBdXU1NUo5RHNN?=
 =?utf-8?B?QlJRMnNPUUw5UlM4S281YzZ4eVhNNGdpNlMrSWpEUHlBcE1rY2JFaDBNUGk5?=
 =?utf-8?B?eGxFZ2NlR3E2SGU4M2J2TERLQTlwK2wzU2tta2ZQRUcwRUFPM3hSZ1l1UG9q?=
 =?utf-8?B?bS96ZlF1Y0syVlcvL0pCa2xBOVdESVl5REp5cUZCZFFKUnlqR2NqamE2MXV3?=
 =?utf-8?B?aXpQT2J4eUZrU3Z3cmNNUkttT2g4NmdRWHdQTGRoWHVqRDU0Tnd4Z2lWejgv?=
 =?utf-8?B?RWg2U290OFllVWRTcXhiMVlYcThRUGxNODJiVUJUVGRacXBWck02YURFWS81?=
 =?utf-8?B?dXNXbHEzSEo1UU9ReDVvRUhjZGtHaUpDWG55Vm9rTjlmUWNQaUpwUHFWdmtj?=
 =?utf-8?B?Y2FQQitFUWNJQi82TmJDT1d5VmM1NFdhcS90bFJBVXZUWDYxK1J0dlo2dWps?=
 =?utf-8?Q?d/YXDwFjBm2P0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmJLUXZyS01YRzNBam9wUkFRL3BhdEtsNzJQQTRiaFlFcjE0WFpGT3JkYWt3?=
 =?utf-8?B?YzVVdDJkU3NwL202UlJBekppUTJFMExCY1ErMEF6ektncDBrQU9DN2FQYWow?=
 =?utf-8?B?UXoxODArOVpxeTlTL3RWMGpocHlwU2t1UjNRTmdnMFRGUzdsK0wyZFU3a1dP?=
 =?utf-8?B?K1RDQzl3NlBLLytTSWNJb3pYd3BYOW5JU01aM2lTMkphbzR3dWUzTmNmMjVI?=
 =?utf-8?B?WEVHblV4WkRzeXNpRWY1dDlheVlPbnMzVlpCR2ZEN05IbFVTVEkxTlpnZjZz?=
 =?utf-8?B?S2phcGVTcXMybHBCWWRkQ3BMbU5wK044MVJGUHJQVWw1SE5zT08wWlMxKzRB?=
 =?utf-8?B?R1U4MDZPZ09uMkV5dzhhNzJEd1VVS1haYTF5anEvOFJxcE1UclRqcHF5Lzcr?=
 =?utf-8?B?ZkFjOUY2QlNnR2ljNVg4R0ZMQSsxOU5JbG1NZ1l3NzVQZWFGdzNiQjhCRzQw?=
 =?utf-8?B?ZjRjQTJhbGlZc3ZuRWFWY2g5NmluLzZLMVVIU2tLU1YrK3V1bnltd0pYbkE2?=
 =?utf-8?B?dHEzd3dIcEhKRjJMenR5dS9YS2lPRk5xYnRPZXBBZWN5WlBjb1JqYTFzWVZ6?=
 =?utf-8?B?Y3pLdUZBcktoMU1HZHJtTDYwOGdEM0ExdW5FSEZ4M3dVUTFYT0swaUpPdGVp?=
 =?utf-8?B?MjdLV285R0U0dWNRVkJaMEJmaHlTT3E5K043dlBIUzlJSW1jQlJod1BhR29w?=
 =?utf-8?B?NHp6eDFia0VYcE00VVk2SDZwTHBQMGtjZ2lhMXEvUmQwQ1JUdmtsTHJSdGRh?=
 =?utf-8?B?YXVsQ3VwRjg5Y3drWG1xQWxrZGJXeXNTSVR0QndYbi9jdnpRRXRyMm9iSDQw?=
 =?utf-8?B?V1drU2ljUEJ2Mzc1bFZXUnUzeTkzbzRUaXJ3bFduQUh4QUVnODEzRUlBaVBk?=
 =?utf-8?B?RkZqSVBpTjZySFc0dHhEWFNCOGgrQ09aT09zOVhkS0wyU01aTnFjYngweUdt?=
 =?utf-8?B?ZmdZUnBISFluM09URVVXbm5xNE1lM2lYWVBJR0ZPLzFFbHVtdUFTajVvdHhP?=
 =?utf-8?B?ZTVsWXFyLzhoQzNHWWsxMzA4eUVDZFlzOVZjSklVd1hjZXZqUGdPUXY0Vnkw?=
 =?utf-8?B?SEF0cVpmSExkTTFYTm96Z0R5S2FUWHc2MUd4eENNd1NRSGswWnBRbWxEV09t?=
 =?utf-8?B?K3FUV0puK3psL1RFY1QzY3hQTVJ2S0dsb3V1Q2RuNHBvclREL1RubUZvS2JQ?=
 =?utf-8?B?S2tvT2hKNzkyaXFqbnczc2tobXdOYUFEVE1yRXdiNXF6Y2pvMSt3N2VoUDRK?=
 =?utf-8?B?ajhPZkNwcE5HZ2dVSHJMR3h4cTNQd2RsMDU2ZGZyRWxlOVQ3SEV3TFZWMHVt?=
 =?utf-8?B?TGZCMVZoamllaDZvNHNpeWJDSk1WUkRrdlNpanROZGVyMDJ5TVVhQjNPMnFZ?=
 =?utf-8?B?U1N3dnZQdGh3emVDU2JBeVJKc0hVM0R1YUNwUGVuYWJKOUV6QncxdGRjNjcv?=
 =?utf-8?B?MThidHFjVkI0Zlp1MThjNkFtbThWeUs5cUZ6K3NZTzhKazRuZnkzcWJHcldF?=
 =?utf-8?B?RUEvQ21UU0MzM0U5UDh0NXl3bjBmc2RTMytJcXc1WTdZc2M0c1czQXFQc3Zx?=
 =?utf-8?B?ckZCclNoczhvcDNNd28zOUd6dXJlVTRvdUxWYVpoRThIM2dSekdSN0dQTGZ3?=
 =?utf-8?B?QVErVHRNR3JrV29Eb25UWmc0VkgzVlo0T0FaNW1Ua21Hb0x1TkR2MEpmWEVu?=
 =?utf-8?B?UmQ2c2F4R1Rick96eFBCSExzNWJ4cnpUOE1EWVVUWmFXSG1LMzV1bVFuN3BU?=
 =?utf-8?B?dm9ZTTc3dHRvdjd3Tjh0eS9KUjY4K0RMRXJXYXJtdGNlY1BYZlVjdFU3MHlo?=
 =?utf-8?B?TzIzQzhhVXFzS3BGUldGeTBlWTg0RFNHMC8xT01MWTh2Tko2bENvVEhQL2NV?=
 =?utf-8?B?Um9RVlZ1TExvM1grejZqT1dzZmVKaVRDY0FjYUlsZUpHZGV0YnRMSkpyRUV1?=
 =?utf-8?B?SWl4WHZkZ25NRDBLT1RuZ2hkMmF4VzBjcjZ2SzZza25KdGxycEVtRjB3VC9h?=
 =?utf-8?B?ZUZUUHF4RXFQVHRpdGg4YjBYdUw3ZlpXdW91VTVVV0lUUWhQTC8zSzljU0lC?=
 =?utf-8?B?SEQwdURubVN4S3V0cjN2N29ROURINXJmQXNLVEZEeTB1SzFJeWZQSDRwUkF2?=
 =?utf-8?B?b2NUdk5qYXRacEluRW9QbFJxQTFDMllJTGcwMFVqbGtlVUxCRnJpL2Zwc3NZ?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppGQyRUmHUe/pxVslQt+st9Sm4g6VeGTvXIjfSPW85iR6H3+5NWmt3GNzs+GDGXjHKC/SsNhVRVt05KdBdZGeLaNGCdKrH7mFDWDtH005wMSCy0fTaIuBmI8QbFmur0ns6yGrAnpfQpgXeKnTllfXlVDDf+QKAza4J5II3STK1s+dh2gobmMdgrxRWHKf+5I+q04ersg9TB/lpm+amduh8YZxx3PIcl/gZsu6dpKk0zY1O/65IqvaDakmuzXH2tS9VGuANqTAUMKNM8TF9TQzx8HJupbvbmZ4THr9fRc//LxvEk54okZ5xIcQ3hxqtdun9elSg28/9RSt0i5bCJCDmoAFKEC2lCjS0c/soqKNFPYZlmrhNfjwSxK7VSZa1V+hpRVSD1Q4zDss91X7b30yFU50scqDqGGtBgboZBptuUAcol1c+emSaS6UE9mDsvCGGEw2BuaStgQNvb0YBvOzgZ/Pit1mJr4WG5eTap3TaNTbdDNiD3Zw+m+HUeDvHchCmYfyXaes3rBivg5x4zHUffQnBaQS0tFPp8WL/8JM2ye5kTBhYMZO/hlxII+67JdL3DNaNkRP0sVtY6FyVoEgtK35J8tRm2X4F0Y/m3AOuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341abc5f-c739-4692-4e17-08dd51dadee2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:17:44.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3gZGdcok9r7d++OZcgaXJnOiyGZq/bBaz7+UCK/TLawkfJ3hGnKCHOjSMJun83X6PHDsAfih1Fe0PPsdvgF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200127
X-Proofpoint-ORIG-GUID: f6em5e7mgVUKDtQsg3WzNeW-h7qBSsTL
X-Proofpoint-GUID: f6em5e7mgVUKDtQsg3WzNeW-h7qBSsTL

[ Adding NFSD reviewers ... ]

On 2/20/25 12:12 PM, Mike Snitzer wrote:
> Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
> by nfsd will be removed from the page cache upon completion."
> 
> nfsd_dontcache is disabled by default.  It may be enabled with:
>   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache

A per-export setting like an export option would be nicer. Also, does
it make sense to make it a separate control for READ and one for WRITE?
My trick knee suggests caching read results is still going to add
significant value, but write, not so much.

However, to add any such administrative control, I'd like to see some
performance numbers. I think we need to enumerate the cases (I/O types)
that are most interesting to examine: small memory NFS servers; lots of
small unaligned I/O; server-side CPU per byte; storage interrupt rates;
any others?

And let's see some user/admin documentation (eg when should this setting
be enabled? when would it be contra-indicated?)

The same arguments that applied to Cedric's request to make maximum RPC
size a tunable setting apply here. Do we want to carry a manual setting
for this mechanism for a long time, or do we expect that the setting can
become automatic/uninteresting after a period of experimentation?

* It might be argued that putting these experimental tunables under /sys
  eliminates the support longevity question, since there aren't strict
  rules about removing files under /sys.


> FOP_DONTCACHE must be advertised as supported by the underlying
> filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
> all IO will fail with -EOPNOTSUPP.

It would be better all around if NFSD simply ignored the setting in the
cases where the underlying file system doesn't implement DONTCACHE.


> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/vfs.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..d7e49004e93d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
>  	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
>  }
>  
> +static bool nfsd_dontcache __read_mostly = false;
> +module_param(nfsd_dontcache, bool, 0644);
> +MODULE_PARM_DESC(nfsd_dontcache,
> +		 "Any data read or written by nfsd will be removed from the page cache upon completion.");
> +
>  /*
>   * Grab and keep cached pages associated with a file in the svc_rqst
>   * so that they can be passed to the network sendmsg routines
> @@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	loff_t ppos = offset;
>  	struct page *page;
>  	ssize_t host_err;
> +	rwf_t flags = 0;
>  
>  	v = 0;
>  	total = *count;
> @@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	}
>  	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
>  
> +	if (nfsd_dontcache)
> +		flags |= RWF_DONTCACHE;
> +
>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
> -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
> +	host_err = vfs_iter_read(file, &iter, &ppos, flags);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> @@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  	if (stable && !fhp->fh_use_wgather)
>  		flags |= RWF_SYNC;
>  
> +	if (nfsd_dontcache)
> +		flags |= RWF_DONTCACHE;
> +
>  	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
> @@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>   */
>  bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
>  {
> +	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
> +		return false;
> +

Urgh.

So I've been mulling over simply removing the splice read path.

 - Less code, less complexity, smaller test matrix

 - How much of a performance loss would result?

 - Would such a change make it easier to pass whole folios from
   the file system directly to the network layer?


>  	switch (svc_auth_flavor(rqstp)) {
>  	case RPC_AUTH_GSS_KRB5I:
>  	case RPC_AUTH_GSS_KRB5P:


-- 
Chuck Lever

