Return-Path: <linux-nfs+bounces-8517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91949EBB7A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 22:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AD41683C9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A000230256;
	Tue, 10 Dec 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AVBbwImC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bRUgYERQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC923025A
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864723; cv=fail; b=ZKszbFEnTJ5Bvk2U6UNNcsj5FwFm08QH+KBWUPpgk1yhqzMyXewGi4AWWhWhM6CyRv+3jnxGBYuBZySVVNNmR18unLmixL12q6IbrpG8NRWb1VQKd9kjzX8mGvSvXq5IbzuKOHJQSIrzG+wWwCS2KNyI3Z7h9B2jACbjswsQSrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864723; c=relaxed/simple;
	bh=hFDiiiqKgEdYd8+bxdcKUAE4lNMq+PRvbUavZBoI5eQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dB38MWG6iWaa5ZsbDVNNRZgm0An+LLiTZGoyA4MVXOg6NDJZxfaOCkZyzF+iObn1CrCBzvJnbCXSgxfR1a8AeSmV/9Crhy1ebiwAUmRVDxBjVDhJeSHwcbR1LyBMqljdDSkHkqZbk8Pi0XC4/gt/+nAoMg7TjrYRolY1ykPT2N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AVBbwImC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bRUgYERQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJJG2Y000720;
	Tue, 10 Dec 2024 21:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G6B09aYPZoFcMN1Sx2xwb5WJdasQYdebx0t/dFV3XJ0=; b=
	AVBbwImCOCqiC98Sc7rQGDjkyQtWYfmR2ctSM44KRNFFda2VCbEyKoUuODCAdnt1
	A6BOQpxupKRN8fIUpWPmZjFDVYZTtKLzDNZvlIldTkjFmk73ELFV2K4sPVCshZ0B
	TEOVEc1H7OUyBHY9Ox9zIydb2lZkQhPdJS7yqzSe6yZmHrFulkhm/GnLmH0TjGIm
	pZzkGuVdLBKwS6lV+ewSZoxq5dbCznC78+KVGmJEVUGXHPUJFsvqYP00sC93rQ/q
	5oWq5an+JwtjcS/QAGbIEMQIut+QJvNn3fXlGCvE1jTu/lYyvUeV4Iw4GMIrknhc
	9eAKSiSeb1mQwefYGg+5UA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s43tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 21:05:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJALIJ008623;
	Tue, 10 Dec 2024 21:05:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8wm2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 21:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUVNXkJajy6x+zBUlZgxRiv/JZvfGG/JCzLHGGTcxcLYzAp0gQvCEAIFYuDrA0aiv8wLtYFVNJR8QkHEdl3O1/ipF0yDYhop/L45KIK4yUy6111VbR4Sdez0HEPOX4aRU0+5hOKXoqPZFMyJmEgkXUAaQxKdlw2DC9dFJozie4nALCRWhNerqAzbGGP23jksjxG/kHtHGaHYuQfqw4zhaWuqOhQl/kj0PAVyk9Ruwl9WqjB9703ps1XCLil2DgexIJXZrtR/AaRgV849fZouDVvxsjxQY37+1cwPd+fKI0tsi4RUa0WN/g37ghLmjvW0iGqPYQUkdi5f/1WWfO61rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6B09aYPZoFcMN1Sx2xwb5WJdasQYdebx0t/dFV3XJ0=;
 b=nsuwoNYW27mUPjwB5nneBv+Jv1UpKncoqZuzoLLoiizkcGwTy9tnHZ23tmk0pCnHiUI4Tv7Er+kvQn8Sm9c1/Qs/+HFPBG5SpmNn5pjfFSv04FL74qPGGyFlg4ytqd5bH3FsACmfkRrfIxDcTMo3Dg1a8d6OxgSDigidD2k0/CarWDfuhRdPjYXiz46d5jQTb74VZhFWiig7Ayz7QM3VGUjQFh5Ph36+hZaNPl4ccG0u3R+gUE5Tlyups6KasO4cxNOrkEZ7PKqvcUwxg0Z9XB8IlqNYU27wCqVqb1VbgOvvK/WKe9E7zS6jwxOH0CaCe//Wl+gTSXwVHue7c7t+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6B09aYPZoFcMN1Sx2xwb5WJdasQYdebx0t/dFV3XJ0=;
 b=bRUgYERQSBQN6DAXCzkInQ2vhsCNj/Npthj5yMGLRXTYZYhNGZTGCaVeUxao2HQ8F1SftKarepkGHO4V6gH9dQ9qMz6RGjxcYr91KglQdokCK2vyg+HueH/1u2Roox6dhee2Dgb2c5Svsk4nIWCuKl78VFEmAA39F0nM8iEbZCY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7964.namprd10.prod.outlook.com (2603:10b6:408:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 21:05:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 21:05:02 +0000
Message-ID: <526f9a90-6515-4208-a40d-10c5c38a5a11@oracle.com>
Date: Tue, 10 Dec 2024 16:05:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20241208224629.697448-1-neilb@suse.de>
 <20241208224629.697448-7-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241208224629.697448-7-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: cc41dd1b-9898-4e03-b390-08dd195e501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHBDOVZ3Q0FwYVBPeDFJNkxXK2t4djlkL1RhZVM2alhtenNJaUZpYmRweUZn?=
 =?utf-8?B?T25UMm9Hb2lQNWR5V0M1dFlaMlVvWFdHeklkZTg4STZJbzhvMUpoL0VPRTlF?=
 =?utf-8?B?cURpL2xEK1kzSXl1dkROclpya0laQ2hEOFNKMFhnWE51WU0zZFp2bHVmL1VR?=
 =?utf-8?B?eUowL29nakI0bkhiL0hRQVVTRXdLM1plOExoeFhrV0JMVGRuY1FqMTJmd0NS?=
 =?utf-8?B?bUkxZnFLVFl5UlJDc040WFVQY05DZDZDa2EvSUtad0pJV1dBUkRxU1dxWUJI?=
 =?utf-8?B?c0t5bjQvMmNwRFI0MUxNUlJKeVFEUkVHa3lLR293cE8rbmozU2ZxTC9GRmdn?=
 =?utf-8?B?UUVKUlA4SjVpVWJLbzJZaGhnSEQvL3VtdGNxSnNoMHVMVlIwV210b01aaDll?=
 =?utf-8?B?RUQrSFBiSlNYaVFvcE91aFA5dE53ZkE0bDNNdmN6TjM5TlFnSCt6MGpBdWhq?=
 =?utf-8?B?NHZEb3FvQzE1UmdaT21lbTZ6Mzg1Znl0V2NwVHNVVzlNeFQ0c1JlcHlOWmV4?=
 =?utf-8?B?SVZUeEhJSEhtcDRXMEJxTExvTnZ5bGdHbjcrZE9paGpHVjZWUVpCKzlsRmtL?=
 =?utf-8?B?SFFRT2NyTXlPeHlueWNEMy9kd3BHVVJOWGptb1cvdGxYS20zS2JWd0c5QlF0?=
 =?utf-8?B?VjlPTHo5Tks4QnkrY1F5UGFWMXNFbTRLckdEekJrOGZianhGejhvZFRnOHY4?=
 =?utf-8?B?dFBzZWRTL21qSWhZa0xlTUdXbytKWVRLektpbW5iQjZlNlJLLzNaUkZXNnc5?=
 =?utf-8?B?eFJZZU5ma2lROTBvaXFET0FlSThBWmR2QXVkakQ0NkRjQ1I1bnZrTVR3VTJP?=
 =?utf-8?B?UlpUbGVwQUJ5ZkZCY1NBRlo0U0RNQ2l1WDNXQUljNzZ6WEpKRzh4UlJhem5s?=
 =?utf-8?B?R09mYVNRUU5RN3pDUkVqd2JXUzVlcmxuRHhJU0FHS3F3RnJrRENhc2FIOEI3?=
 =?utf-8?B?cTVWQzJiQVgveE9vMkNMcFlpNFRDbnJXRUJNNG5Pbm9kMElFN2QwbFhONnRX?=
 =?utf-8?B?SGE2RlBlaGd0RUltUWlFQVVYMk1HMnNmcFh1bjQ5TlBTalRJZ0FzVVd3RjRy?=
 =?utf-8?B?OHYrbDd0Skd5ZkNtbjFpSnZkZFNwdlc3Q1pYa0NoOUNPSVVxYzdiK0lxTDFC?=
 =?utf-8?B?Y0dvZDRnMi9rbllsL2dMRWIxZ2tHKy96b2paRW5ROUsybVJDS0ZLQ3lJNm15?=
 =?utf-8?B?bTVLL0MvWXhacWI1b2tFa0lRam5xanh3ZitZN2pPL2JRVWxrSTlqVDhRdzB4?=
 =?utf-8?B?TDdXN01qN0FnSnVWMkF3T0R3anpjZFNTVHNZdm5wQ0lxQ0tlQnozazVPbzlX?=
 =?utf-8?B?QTNsSElxZmgzTVhNNnZ2VkswY25xSlFHcEdhODlHMzlCK3pIa29MYVFLSUdX?=
 =?utf-8?B?SGxvQzJCdEtvc0FBUGs4RnZzaUpCSVl5NGlBYlBtRUp6TVQxMWxhTmFvTjBP?=
 =?utf-8?B?VkxTeWE2K29WWUlza2dxUVpTQmxhTmphQU9rejduUTlBL1FPYWRKZ01zZDh4?=
 =?utf-8?B?YVE2T1ZCK21MdzZxZUk0N01mRGlHazlUUHJNZ0VoKzZpSFh6QXVqNEVDNjZ2?=
 =?utf-8?B?RW9pM1VtdnVwZm1PeXpyYmJ0aUpudk9kaGplZHdzK21JYVNzajZucFBpS21z?=
 =?utf-8?B?MFh1cFBjQlZPRk5QNDJjMGpRRE1zZktvRkM1Rmd1UVVpcUMxQnhrM1VHN3M3?=
 =?utf-8?B?UjFLT0ttSStvWUluUTVSNVdwMi9ORmpLTGFBSFo4UFlkRU5COVFaS29RVlFM?=
 =?utf-8?B?N2xwRWlzbE5LTFRadkt5RUtFeS90MEwvMzc1UGlIem1sclkwZkg0VWZQcFZu?=
 =?utf-8?B?VkVNSTZTczdWTGxOMTJNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTNjb0RMLzF2RWp5Z09NTGs4NWpVMlNUaFlLMTFlRnNaOENLNDBrRXc5YU1W?=
 =?utf-8?B?ZlQ3b0RsdkV6UWJYeHo1WUV2TEo5QXNZd2lrQkpiUFRHQ1k2cEtSWk5uUDdm?=
 =?utf-8?B?YnlTZDg1SCtDS3NxK3VTZW9obzBLUHZ6dWFvYWFOdElrMXU1MXo0M2ZnbEVG?=
 =?utf-8?B?VWdJR2ZpamxTcGxyT29NZnZYQ2JXVjZrc3Q5V0Qrb0FTTXpFWnl3NjArbkNr?=
 =?utf-8?B?SWVlVyttM3ZNWXRJZjhONlh4WVBVMVAvUittV2dVZWJLYlpDQW5reUdKYXdu?=
 =?utf-8?B?V1FMcVV0Q3piM3MwVExsaldONnNwYTZRcmdXM3BWdXcxRU1WWVNGN0pJcTcr?=
 =?utf-8?B?elM4Vzkvb3Jxd3ppV25taFl3WFJGUDBxUFpkU0xRb3JkMjBTdDd5Y2lEV040?=
 =?utf-8?B?Q3Vzd3g1a3NXTmtiRXdMY29keVk3VGVHZm5qREovbE1CTjl1MzdDallXWDBk?=
 =?utf-8?B?RTIySUVjM3kwdkVOb05pbkQ4YkNCY05wa2Z1K3RMdmloTTFzOHU1OWg3TmlW?=
 =?utf-8?B?VnRWbmM1TkI1cWJJVmQ1amVOazRVM0lhM2FPUW02ZHdaTEJaOWxWSzdGazh3?=
 =?utf-8?B?b1RWNU4yMEd3N1Zwd1Juc2t6bEF6MnVPbkR4aWVpWm1aMzJEVDJ3YkZ2V3l4?=
 =?utf-8?B?QndEekIyc0lNWFZkT0k4T1FqTjdKeEdERW5CbzlsRHVvd242YnFhWGFrTWp5?=
 =?utf-8?B?bE1JeGR3MjAvMVFVWUdCbVFVb25CbzJJZWJWN21zdDRRbTV4UllxNE9XS0NJ?=
 =?utf-8?B?Q2Z2QUdlVXAzaDkzY3VFclJLaENXQjUva21pZTdnNk5yaU5UNEsyTlJNcXZW?=
 =?utf-8?B?OUNVSVNsUWJxNmdqWTRnTGRodHFDSDlGTGx4MWQ3U1JseFo2TTFNaVljb0Ns?=
 =?utf-8?B?WmZkZnkrbG9BbjNtQk1NTmRxV1FDN1d6ZUdqd3RKejBkUVFraFlyNVF0Sm5h?=
 =?utf-8?B?d1oxMTJnRHZ4dWJMZDk3Q04yVXVYdmFrV09ndjExK1B6U2ZvQStoU2tEb1Uz?=
 =?utf-8?B?VVJWMEMvcjM5eHNjV2NOdlIyMXdNWllHOGtVNzZSWHo5NVo4elJKYW9xL1FP?=
 =?utf-8?B?YzdCcVhtc2hFYm5KZG5VT1ZBQ1RvZVY4UExLZHllUDhKR1BxdlY4eG11c1d5?=
 =?utf-8?B?eVpESFJtdFlFVUtqcS90TGVpYnI1ZSt0NCt1R3IrZi9Za1FnYlFQckw3YmY3?=
 =?utf-8?B?QXE2Tm0rQUR6Ym53WjFzT0E4TDlWTUZ0cVNUaUdmeUhVdy92MVNIWG1mWXkw?=
 =?utf-8?B?NnFFQUVQRHNyZzBtOFJMLzZDUVQvZC9aR3ZGYUNncEx4RnZLRHVGa0hkWVk3?=
 =?utf-8?B?N0wrOVB2SXJFaDhNVG96MWtyeUFZNzJLdzZDN1dWN3FoSnlCQVhWdEU5Nks2?=
 =?utf-8?B?VURPb1E5OUpkcGx1MGVoZlNVb29jdnYyejVudGIwYXo3amdpRnBWaDVZdHl4?=
 =?utf-8?B?UUQxc3Q3alpWWFpyZXd2MHhkSzRNUjNuWDNJdDRvNEtLTDNCUWFXSU1wQ0gz?=
 =?utf-8?B?QytLZHBVOGNVOFJoT0N0akpBNmtaQW1sS1htbXpPNW5HZkhHUHRsRFRSbkJp?=
 =?utf-8?B?d21KT25jNkJLa3BwWldvWHk5OHdEYWU1OXl4TGpybmd2NWVDalhYVlZuQUNn?=
 =?utf-8?B?TWhmNjRsTlFFRVhmeGhwRFNCLzJKMHU4V1N4NEQxRmpmbjhPUUhKU0ovbU9O?=
 =?utf-8?B?U1VPZGZxSXhVaHh1Vk8vZ2F3bzVQb2dPSkdjRCsyQXZIU0gwVlltMCthMTRN?=
 =?utf-8?B?VVNRT0J4SzhEQ2k5N01Cc0J1anNuSlNENk9tSnNMY09UY1JvVjEyMHZ6MjZG?=
 =?utf-8?B?Q1pQdUw0OXhxSEwycUE3SmFQdGYxR2dBVXdlT0NJTm1XM01YNG5wTGltL2Qx?=
 =?utf-8?B?S1g5UWU1MEJMTGtnMnpMMU9ITERWK0RNSWlGU3pCK1FYZHlQdHR5UjN5WG5I?=
 =?utf-8?B?Q2VhODBaNFpZMnQ0ZlF0MjBYTnRMc1dtcnFlR1ZIbExjZHY1Y1VNTHRyalg4?=
 =?utf-8?B?Yko2L29sei93SWFSN1U2N3JiZzNGK2dUQXg5TFRQRWI3bHF6cjkwUG5RSm5v?=
 =?utf-8?B?cTF0MXc1LzEyalJCanhSM05odThLc2hINVVESitVS1lsUVBEZjI5K213TnYx?=
 =?utf-8?Q?Qw4aj5cK4JtZU7HdYEWnuXmua?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OC0FDnbRtWsGnQ3A1dWvQMFaEooSTpNYdSH4xI2Su3DmBtER/sdpnTTwkj+m/njqJNjwQkd0+VPOuM6qngHita/cgaRPRNPMkfpENV/BFAaqYdZlzpqhWFKMUr6eyW2GnmT7e/Yq6N4nhOewzaMOYsQ1oIzBenmEj6VJIL7hPUqm8Q/RHpLVLfvcQGAyDB0qLN6XaqMf26yqTiD1Vd/zgFGReiM+raeUmrJaUXLJyGJDvKtOqpwf+qshOBcjOWuj/Dr97gSoTPRLjhM00XQ+BXKCUwqQYoBuAgVe2YZAxncrtKxzT+GFMo1bh1AaPW59RsM3TUlLWleP++cd7kORw/Biv7tIAszs6Yps8OJBLOjMzXsIsQf5I6zoBa85sCTrm6VxF2M3F5WkJSStJV0AwR3hnIL+tflTAkhcnMieQBW6y3bkxjCd6i5DZhPCu6VKSPB3JC2tgmnec2Eb92lkNPE8YF67mQxeIs3G/RkBgKN472IQxOJK1HnSHZAYpskR1LhczJR1g2hgTfvsTlj1730/6ao+fLBkWv/buBr3h5rsCzmnOr+WLm4KCem712bG4s2Dzg8Nae0D9FwMd0R2Q8qY/dieWPMCPIyJpE6JETM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc41dd1b-9898-4e03-b390-08dd195e501c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:05:02.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6OYIXewNKb3a6xMqtu9J6ttQP56th6eW5+TiRusTyNUBzpbcBVvfIwGzZIjYCUTAhZf1UjIUnMAthzta+l4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100152
X-Proofpoint-ORIG-GUID: Ll7AH1sPRMDBdBEdsuFMyrknumPSsNcs
X-Proofpoint-GUID: Ll7AH1sPRMDBdBEdsuFMyrknumPSsNcs

On 12/8/24 5:43 PM, NeilBrown wrote:
> Add a shrinker which frees unused slots and may ask the clients to use
> fewer slots on each session.
> 
> We keep a global count of the number of freeable slots, which is the sum
> of one less than the current "target" slots in all sessions in all
> clients in all net-namespaces. This number is reported by the shrinker.
> 
> When the shrinker is asked to free some, we call xxx on each session in
> a round-robin asking each to reduce the slot count by 1.  This will
> reduce the "target" so the number reported by the shrinker will reduce
> immediately.  The memory will only be freed later when the client
> confirmed that it is no longer needed.
> 
> We use a global list of sessions and move the "head" to after the last
> session that we asked to reduce, so the next callback from the shrinker
> will move on to the next session.  This pressure should be applied
> "evenly" across all sessions over time.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/nfs4state.c | 71 ++++++++++++++++++++++++++++++++++++++++++---
>   fs/nfsd/state.h     |  1 +
>   2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a2d1f97b8a0e..311f67418759 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,6 +1909,16 @@ gen_sessionid(struct nfsd4_session *ses)
>    */
>   #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>   
> +static struct shrinker *nfsd_slot_shrinker;
> +static DEFINE_SPINLOCK(nfsd_session_list_lock);
> +static LIST_HEAD(nfsd_session_list);
> +/* The sum of "target_slots-1" on every session.  The shrinker can push this
> + * down, though it can take a little while for the memory to actually
> + * be freed.  The "-1" is because we can never free slot 0 while the
> + * session is active.
> + */
> +static atomic_t nfsd_total_target_slots = ATOMIC_INIT(0);
> +
>   static void
>   free_session_slots(struct nfsd4_session *ses, int from)
>   {
> @@ -1930,8 +1940,11 @@ free_session_slots(struct nfsd4_session *ses, int from)
>   		kfree(slot);
>   	}
>   	ses->se_fchannel.maxreqs = from;
> -	if (ses->se_target_maxslots > from)
> -		ses->se_target_maxslots = from;
> +	if (ses->se_target_maxslots > from) {
> +		int new_target = from ?: 1;
> +		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_slots);
> +		ses->se_target_maxslots = new_target;
> +	}
>   }
>   
>   /**
> @@ -1949,7 +1962,7 @@ free_session_slots(struct nfsd4_session *ses, int from)
>    * Return value:
>    *   The number of slots that the target was reduced by.
>    */
> -static int __maybe_unused
> +static int
>   reduce_session_slots(struct nfsd4_session *ses, int dec)
>   {
>   	struct nfsd_net *nn = net_generic(ses->se_client->net,
> @@ -1962,6 +1975,7 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
>   		return ret;
>   	ret = min(dec, ses->se_target_maxslots-1);
>   	ses->se_target_maxslots -= ret;
> +	atomic_sub(ret, &nfsd_total_target_slots);
>   	ses->se_slot_gen += 1;
>   	if (ses->se_slot_gen == 0) {
>   		int i;
> @@ -2021,6 +2035,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>   	fattrs->maxreqs = i;
>   	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>   	new->se_target_maxslots = i;
> +	atomic_add(i - 1, &nfsd_total_target_slots);
>   	new->se_cb_slot_avail = ~0U;
>   	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>   				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2145,6 +2160,36 @@ static void free_session(struct nfsd4_session *ses)
>   	__free_session(ses);
>   }
>   
> +static unsigned long
> +nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
> +{
> +	unsigned long cnt = atomic_read(&nfsd_total_target_slots);
> +
> +	return cnt ? cnt : SHRINK_EMPTY;
> +}
> +
> +static unsigned long
> +nfsd_slot_scan(struct shrinker *s, struct shrink_control *sc)
> +{
> +	struct nfsd4_session *ses;
> +	unsigned long scanned = 0;
> +	unsigned long freed = 0;
> +
> +	spin_lock(&nfsd_session_list_lock);
> +	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions) {
> +		freed += reduce_session_slots(ses, 1);
> +		scanned += 1;
> +		if (scanned >= sc->nr_to_scan) {
> +			/* Move starting point for next scan */
> +			list_move(&nfsd_session_list, &ses->se_all_sessions);
> +			break;
> +		}
> +	}
> +	spin_unlock(&nfsd_session_list_lock);
> +	sc->nr_scanned = scanned;
> +	return freed;
> +}
> +
>   static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, struct nfs4_client *clp, struct nfsd4_create_session *cses)
>   {
>   	int idx;
> @@ -2169,6 +2214,10 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
>   	list_add(&new->se_perclnt, &clp->cl_sessions);
>   	spin_unlock(&clp->cl_lock);
>   
> +	spin_lock(&nfsd_session_list_lock);
> +	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
> +	spin_unlock(&nfsd_session_list_lock);
> +
>   	{
>   		struct sockaddr *sa = svc_addr(rqstp);
>   		/*
> @@ -2238,6 +2287,9 @@ unhash_session(struct nfsd4_session *ses)
>   	spin_lock(&ses->se_client->cl_lock);
>   	list_del(&ses->se_perclnt);
>   	spin_unlock(&ses->se_client->cl_lock);
> +	spin_lock(&nfsd_session_list_lock);
> +	list_del(&ses->se_all_sessions);
> +	spin_unlock(&nfsd_session_list_lock);
>   }
>   
>   /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
> @@ -4380,6 +4432,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   						GFP_NOWAIT))) {
>   				s += 1;
>   				session->se_fchannel.maxreqs = s;
> +				atomic_add(s - session->se_target_maxslots,
> +					   &nfsd_total_target_slots);
>   				session->se_target_maxslots = s;
>   			} else {
>   				kfree(slot);
> @@ -8776,7 +8830,6 @@ nfs4_state_start_net(struct net *net)
>   }
>   
>   /* initialization to perform when the nfsd service is started: */
> -
>   int
>   nfs4_state_start(void)
>   {
> @@ -8786,6 +8839,15 @@ nfs4_state_start(void)
>   	if (ret)
>   		return ret;
>   
> +	nfsd_slot_shrinker = shrinker_alloc(0, "nfsd-DRC-slot");
> +	if (!nfsd_slot_shrinker) {
> +		rhltable_destroy(&nfs4_file_rhltable);
> +		return -ENOMEM;
> +	}
> +	nfsd_slot_shrinker->count_objects = nfsd_slot_count;
> +	nfsd_slot_shrinker->scan_objects = nfsd_slot_scan;
> +	shrinker_register(nfsd_slot_shrinker);
> +
>   	set_max_delegations();
>   	return 0;
>   }
> @@ -8827,6 +8889,7 @@ void
>   nfs4_state_shutdown(void)
>   {
>   	rhltable_destroy(&nfs4_file_rhltable);
> +	shrinker_free(nfsd_slot_shrinker);
>   }
>   
>   static void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 4251ff3c5ad1..f45aee751a10 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -325,6 +325,7 @@ struct nfsd4_session {
>   	u32			se_cb_prog;
>   	struct list_head	se_hash;	/* hash by sessionid */
>   	struct list_head	se_perclnt;
> +	struct list_head	se_all_sessions;/* global list of sessions */
>   	struct nfs4_client	*se_client;
>   	struct nfs4_sessionid	se_sessionid;
>   	struct nfsd4_channel_attrs se_fchannel;

Bisected to this patch. Sometime during the pynfs NFSv4.1 server tests,
this list_del corruption splat is triggered:

[   87.768277] list_del corruption. prev->next should be 
ff388b4606369638, but was 0000000000000000. (prev=ff388b4606368038)
[   87.771492] ------------[ cut here ]------------
[   87.772862] kernel BUG at lib/list_debug.c:62!
[   87.775029] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   87.777179] CPU: 2 UID: 0 PID: 940 Comm: nfsd Not tainted 
6.13.0-rc2-g6139eb164177 #1
[   87.780065] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.3-2.fc40 04/01/2014
[   87.783143] RIP: 0010:__list_del_entry_valid_or_report.cold+0x4f/0x9f
[   87.785336] Code: c2 48 83 05 43 a7 13 04 01 e8 5e ba f9 ff 0f 0b 48 
89 f2 48 89 fe 48 c7 c7 00 07 84 ae 48 83 05 0f a7 13 04 01 e8 42 ba f9 
ff <0f> 0b 48 89 fe 48 89 ca 48 c7 c7 c8 06 84 ae 48 83 05 db a6 13 04
[   87.791467] RSP: 0018:ff4e1b1302de3d08 EFLAGS: 00010246
[   87.793251] RAX: 000000000000006d RBX: ff388b4606369600 RCX: 
0000000000000000
[   87.795660] RDX: 0000000000000000 RSI: ff388b496fd21900 RDI: 
ff388b496fd21900
[   87.798066] RBP: ff4e1b1302de3d08 R08: 0000000000000000 R09: 
656e3e2d76657270
[   87.800485] R10: 0000000000000029 R11: ff4e1b1302de3aa0 R12: 
ffffffffb0495580
[   87.802884] R13: ff388b460dcee128 R14: 0000000000000001 R15: 
ffffffffb0495580
[   87.805301] FS:  0000000000000000(0000) GS:ff388b496fd00000(0000) 
knlGS:0000000000000000
[   87.807992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.809952] CR2: 00007f7424c42008 CR3: 0000000100f30001 CR4: 
0000000000771ef0
[   87.811961] PKRU: 55555554
[   87.812699] Call Trace:
[   87.813380]  <TASK>
[   87.813966]  ? show_regs.cold+0x21/0x36
[   87.814990]  ? __die_body+0x2b/0xa0
[   87.815934]  ? __die+0x3c/0x4e
[   87.816669]  ? die+0x43/0x80
[   87.817297]  ? do_trap+0x11c/0x150
[   87.818008]  ? do_error_trap+0xbc/0x110
[   87.818797]  ? __list_del_entry_valid_or_report.cold+0x4f/0x9f
[   87.819955]  ? exc_invalid_op+0x6e/0x90
[   87.820747]  ? __list_del_entry_valid_or_report.cold+0x4f/0x9f
[   87.821904]  ? asm_exc_invalid_op+0x1f/0x30
[   87.822761]  ? __list_del_entry_valid_or_report.cold+0x4f/0x9f
[   87.823915]  ? __list_del_entry_valid_or_report.cold+0x4f/0x9f
[   87.825069]  nfsd4_destroy_session+0x280/0x430 [nfsd]
[   87.826230]  nfsd4_proc_compound+0x64d/0xcf0 [nfsd]
[   87.827141]  ? nfs4svc_decode_compoundargs+0x367/0x6c0 [nfsd]
[   87.827989]  nfsd_dispatch+0x16b/0x3d0 [nfsd]
[   87.828671]  svc_process_common+0x903/0xc80 [sunrpc]
[   87.829440]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[   87.830178]  svc_process+0x166/0x2e0 [sunrpc]
[   87.830868]  svc_recv+0xd65/0x12c0 [sunrpc]
[   87.831529]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[   87.832160]  nfsd+0x10a/0x1b0 [nfsd]
[   87.832734]  kthread+0x149/0x1c0
[   87.833201]  ? __pfx_kthread+0x10/0x10
[   87.833737]  ret_from_fork+0x5e/0x80
[   87.834248]  ? __pfx_kthread+0x10/0x10
[   87.834786]  ret_from_fork_asm+0x1a/0x30
[   87.835349]  </TASK>


-- 
Chuck Lever

