Return-Path: <linux-nfs+bounces-13518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AC2B1EE20
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6447062801D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDDA1F8747;
	Fri,  8 Aug 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="decvepJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRqP8m6/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B515CDF1
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675999; cv=fail; b=Du9+cPRFplKJuWv3svF32D+J5vEQeaNVxipRzpehd7d7cpFeItpGnu7ti6Q+4a2bysjCvj1haIIJzTpvPkliB8e/fvC2mTPjbrJFSnX1toEo03eefOxdQ3YdRPtjBQ28k3AmJMRhgunbdfctNCBSn9X8zAY/c+eAdgGSVGNCR5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675999; c=relaxed/simple;
	bh=iRHWPIBu8cUQA/RTD7lAAmD0IAPQGzpYwCbiHpXA7FU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQ0p1gW7V5C5RjXGD1lsJBLtZRH9ZPl2ld7a0dfCR0zfhWMivFRIwjxqYn9GIDV6IX8TziAhWj/s4NIeIEbLhFE9q1PjzpdBBWrzSgpN3PYEeWNSHZcqLPizWfSqvT32hVwpECAeyF59PUUkboNWupi1krpDZyJRqncQd/jJCaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=decvepJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRqP8m6/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HvSPl028010;
	Fri, 8 Aug 2025 17:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SWfMBKJcDnA/VWo4s5hQQ5sil1A8xDciA0nHT/Ct5xk=; b=
	decvepJzJJCF/Z7yzMLtb4cTrO2mVxyzlLLW3PoqYO7b7QtYb1jGLaxWIiCahXSd
	4XZmqfSYn6fRDLhlO8yweVPc5hXNbihYxcp3qLnxuW/TavP3IgXvqnF5+UjuYMA+
	34I6NkASh7HutcY8vT8vxG2RpT5CxhazcZZa7SGA8wP+gJK6imxCfqk7SrmzkZ7S
	tkw3Jp2ytYdFYhxTR6FypIekhlhrYO8JG1xU0xjcnvGluwyWgC6mAix4fnKQltjH
	Y3QHuLv1JtKZ/WumQpYRiYIyEv0ZWZyKxSbi2Cy7JnO3ADM1tL9S81+n5Lp7jqSY
	n/uqad8gyjrFrjCW0irRVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh718k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:59:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578H8PoG032024;
	Fri, 8 Aug 2025 17:59:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwtkcu7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DomciGWCXdxYVjGSd2daBz/NgH6tLpULxxb5nbpVtWUe1IDt4RPl6dP/AkIrwUF2T/jscYD0w2ZgDzfC3EwZADbJxa/fjHElUHwCJJ7NrLEMUOBkj0i/8QOF8C4lfSXtLcmGWPJ9I+Iol8Dmg0Lucw/TNnM5cfQq+Lfd2JFOeqHuU8ySYB7ATZjJp00lWPgnhKCTSFXD6axl/IXmI4mzMQ5n6Fj7U1kpPuq0VJHNblCcujB5s8zI0R+4DLtcK46WZAWjD7KQVP3wG6dUc0pt+c9rZAJsdK8he4hdFXPCeaqLSK1TnpfRIlFdwfqlAIbabzelN/Ffy76NP6gc1v2QGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWfMBKJcDnA/VWo4s5hQQ5sil1A8xDciA0nHT/Ct5xk=;
 b=UvtNEMcNB9KgK7IY1OQPTyJObAOflWBsGV/0U9B81l/7ZYN593QxbKDrDD1nbO76sEO0ZdvfgA5cF0DZqScIGT8zVtzZdTwAnnNwvOn1E53GtPKmRpTHCyifgy5BeW0z+fdtopO14NOfvq/CBMAHOmI1CQbTF3JOC5F3bbBkO5d9/7wKcOHaD81CRRmTOm/yA5gG5SrLzO9Sr3tnbRuxKJF33qid83nt86EWaJ2Dw7aWwqsBop08lBv079zk8fvr1dovTJ9ia3PZsAztuK9xssX08vRXxJjN9lNaqfelADc9oq9yxJSi9AhIvPwQKK+ZKphT5VSsxquaONwSNz8pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWfMBKJcDnA/VWo4s5hQQ5sil1A8xDciA0nHT/Ct5xk=;
 b=LRqP8m6/NN3lVNwSE51EShMTdlAPYN7+cT4erAgxwEyGLCMgdI34A2n75W0Bghq/+g+EFEBeE2cXMxR3gFj0SUZyXlvv2Es8kZlOGe83glNqBXrO/Mx/7hkyrX2P9Lyxg0ibUuRyKEHwYrcs3dPAZnH2moAa95UZGLTwquzIaVI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFA634C6E92.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 17:59:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 17:59:48 +0000
Message-ID: <9df6001e-8930-4618-841a-14e1831b720d@oracle.com>
Date: Fri, 8 Aug 2025 13:59:47 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 6/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-7-snitzer@kernel.org>
Content-Language: en-US
In-Reply-To: <20250807162544.17191-7-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:610:57::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFA634C6E92:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4f0a2a-b192-44a1-cde6-08ddd6a55db9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aE9jNUl2NkZTRktISitTdmxMQU0rays5dUFiQmJldjloQ09Xa2pwa09QMDRn?=
 =?utf-8?B?SGxKYWFPRTdhdnlKeGFjOUNEQ1hjMTZCUXNRM1dPMFM3enA5d01CUlFXZ0dZ?=
 =?utf-8?B?clQ2K2k0dTJPYVlsZ3NNVXZKTEgvZnUwNWVESHdFb3NYZll0by85S3FDRGdM?=
 =?utf-8?B?VjZMMkhjTkxwejEweGZtUTN2K2x6YkhHVUk0dUJrckxqOVJ1cTJJUXIyOXUw?=
 =?utf-8?B?YWJMRE9sODhGU0poQWIzUllyTE83N2NQNGhWcHgyTWdJalpqTFRJWDR6azFi?=
 =?utf-8?B?cW9MNmJsRWptSDZjTUV1S1NIam0rbDlreTAzQ0txRkkvbmtrZGFJSkNYZTVk?=
 =?utf-8?B?U1hRbGd4NzA2b2s2aThKcFJNdFNmUFVlZyt6bVh5d21tTFJpTUpzQjRlOXZ5?=
 =?utf-8?B?ck1vd1U4NjA1MjNOa3ZKVEluYTBJYjZLSVZLUFFPbjRsZzVGbzhwM1JQZTFm?=
 =?utf-8?B?UHk3SEVPeWs1aHlkRUdmelZWMEM3d1RHTE14aDJENHFwelk3aFNXNjRDV2Fp?=
 =?utf-8?B?V2xDTnQ1SERteXhvY1lRNFZJQU5HaHl3Z2kwU09Kd0dGUHBkWElPQzYyTVFK?=
 =?utf-8?B?bVAwQjFZUGkrcWplLy83SmZqS29obC8vb1NnRGEzaEhkZ05WNm5pSGwyS3hO?=
 =?utf-8?B?WlZQMUVUVjMwVkJmc2pPNjRCV2VqMWpRNU9RMW8xd0xLNEdrL1kyMk5leFJv?=
 =?utf-8?B?T0pOWm9LaktDMjdwRFplbUlpTjdDMnV1YzZFOWtFeG5BQit2NG54SEFEaHRS?=
 =?utf-8?B?Q1MrM01GQWgxRlNNYmZ5YXpBdXZocDNwWk5qeUhXRStrbWVoSCtaZ0pCdlox?=
 =?utf-8?B?K25OMlYvNnNvMUN0V2NKa05YM1VCSXhISmpZclhZa29yT0pGazBxdis1Rkd5?=
 =?utf-8?B?YnJtYUtPN29oYzcxQ3FrOFUwaHBaWGdCcFBJYzh1Rm02SXhsa2JLVktDV2t1?=
 =?utf-8?B?TWMxNlJDQzFQTDF6TVliUy9DRTFnT2Z2ZzJNUk9XaGVwb3BpQUtmUXVPWXBz?=
 =?utf-8?B?UFY4b3pMelVKZnkva2ZnYkpON0tGMGRkdXVnMU5jQzl1bVpYQ1NucHZIcURu?=
 =?utf-8?B?MWt5UVFsNzloaXJ1ZERzMlptSWxaSzh3cDdUdSsrcHFMdVB0VklZK3pHb1pB?=
 =?utf-8?B?d1BPcmt1U3FNbVdvNi9ZdWRmN1ljM28zQkFXcTFDM25HR0p2Sjh4UnRsT1Y1?=
 =?utf-8?B?OVJ5TTlZQzVqcTA4WkNYTncwMXlpcHF4M2dQcXNWZWRBQ250a1NTb3ZtM3hj?=
 =?utf-8?B?d1J1QXEwc3BrUHlBVnJ0cG5CYXJCTzZYM0dJaHVvOExOTlI5dGlPRUdKSUU2?=
 =?utf-8?B?aTVXTXkwd2Q3SDMzVTVmRnpsTmtWYnhCdkxuQlRZSE1ieUxZbVRjMVV6ZEJa?=
 =?utf-8?B?SUNjaXZXcnN2eUcyQ0dwZ09Cclo5VjVuVDQ1dTlqS3AwdFNxTnBkbXFXaVpu?=
 =?utf-8?B?ZW1qenkzY0lZeHF4SFB0N1NQY010ZlJnYVVjTEIzQk9SdmJGQjZtQ1pCdE8z?=
 =?utf-8?B?UFQ4bHFQRVdsL2FSazhaSkx3ZGg5RDB6cGhMUGNxK1MzNGVqK3VoaWZCYWZa?=
 =?utf-8?B?L0FGcm1pUmpmZXl6bHFzMmttYi9MSStQZndmeXNYdGNkblk0NkhibVI2Q1pH?=
 =?utf-8?B?dnkwdGI1TTJ6L1o1RkQ5cmtpMU1rRm9TcVVZUUN3U1krNm5ybkN2eDdkaHZh?=
 =?utf-8?B?eDFKanVhSHNtamJPTnQvcUh5YUZkOHFkTVpDaU1wcmlSSU4rM3JibG9qZ042?=
 =?utf-8?B?Qi95UnpFSVN0b250Y01zQi8xRk1LaE9KM1Z3VEtTZkhzR0hISXFQUTJlODQ2?=
 =?utf-8?B?bHFjSW9lNHJRZElITjZvR3FmV2laNUY0VU5jd2I5U2lzb1RIVzVNbmRjSFl4?=
 =?utf-8?B?K0VDbjZxTWZYTW1acEVLazJqeCtFRUVZTGNLczRndSs1T3VXczJjb1RRNi96?=
 =?utf-8?Q?wDPKYuaOav8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dytBUkNQckw0c2JhbUdSNnAyMmszdTBWYUkwYXcxNW9hNmpSaFgxM3UyeE1S?=
 =?utf-8?B?S1NkZnBEd2VLSnMxd2JvWlF0UUlreUFQTWU1S1RHdlp1bk1XY3F4YlpsbzI3?=
 =?utf-8?B?SDkyRzVSL0NpREtRQXJiK1NncnhadFYyOUxFZlpQcExoSVpPVTE5SUpqcHNN?=
 =?utf-8?B?WlZsR2VEc0RSSURwaWQzalpFU3c2SFZ5YVM2cytKcnhPNkYrSWlhN0t5b0VE?=
 =?utf-8?B?cjl4YklpZm9uZ28rRFM1NU5PaTFaaGRmdEZqcGZJUUtWdnJDUUcwcERnMkgr?=
 =?utf-8?B?WFZ1QkcvQTlvRXJQNzA5MHF2bTZLS3ovSDh2MXUvRmw5SDN6bHpPeWJPRElU?=
 =?utf-8?B?UjdUaDQ0bFI5YWZPYlUrRVFybVZBUGtvTHV2NzNVVnVGNXhBSmNQMWh1dkQv?=
 =?utf-8?B?WnVHL0ExbE04Z3F3eDA1ays5dkhydDdGekVUY3NvbnZmNUQ3c001eW1BaDBS?=
 =?utf-8?B?bndPT1pHQkljalZra1p5Z0tkRXFRSFVPWklZV2c1NzNraDRPWW8rZ3NDcWUr?=
 =?utf-8?B?TUhUdkdsbW9HbTZOZ0REUlJxMXpJVlRsYmJDQUJPTUJlR09DQkh6eGVQZHdP?=
 =?utf-8?B?MTdleWhRVjhqT1NaRWhGOHZ6WkdmQ2lHTytHUkN3SEtud2ljM3lpbk1ncElM?=
 =?utf-8?B?eUZZbzdFVFIvdDhHTEt1SXU2cHBTYm1MM0kzajdwL2RrdTh6Z3dvVElDN1I5?=
 =?utf-8?B?S1B4cmhYZTM3dVp6Q0RTK2YvOGtnTWwrdGI5SFdXWTBpVkYyanNrQmczaXBv?=
 =?utf-8?B?U1VOd3Nnd083WUZYQ2FNbXd6NkF3MFRabkZqTlZXcnRBMjczSnl2Nys3Q0py?=
 =?utf-8?B?MTRjb1RDeDIveFgza2Q3bVU5c3ZGUExOMUJNTFYrWmQvSUdPMkpyeUpuV0Rj?=
 =?utf-8?B?SEMwMm9nOGhIc2toa2tOUUZ5dHVVU1hlU3NaaFNETlk2TW9CWEwxdm1SRjlw?=
 =?utf-8?B?cncxU2NudG50VUd6cHdTZytablk3UGVDSkVQZWlhWWVmakF6M0E0Q042ODdq?=
 =?utf-8?B?M0VwSnJ1bUlFMVpUNHJ1UDF6cE5FN2ZTWitKUjl5VEw1VmJNaVVDMmg3bGFD?=
 =?utf-8?B?T1IyNW1LdHBLYVpUcmhubk8wd0JubEc1c2dNU2ZZZlVHMWc2Y1hXTXc3SVJ1?=
 =?utf-8?B?aWZ6ZG0xWFRZZG51MDNoNEg3UlZvdS8xQnRqc1h0WVJmc2ZKbUVnaTJJY2hv?=
 =?utf-8?B?NnZjWVZVd0ozaFVOQVl5NVBXTm14QXc2cmJNNTlRc1NvZXc2WDRNK2svYVI4?=
 =?utf-8?B?NkJ3TGpPQVdBY1U2Q1c2eVpIRkVIbWtzZWhUU2Uxd3VnMzlaVXVPQW8xNkVJ?=
 =?utf-8?B?V2tXUzhjNjlYRGpGUmhVMFVRZ1JEL0s1bEx1TVdYVVNaYzdNc3pueTNjS0sy?=
 =?utf-8?B?NEhpcnUrM2g1ZEdTa2xkQ09YZEIxU0M2c0JHWnVhUTd4MjVwbzlmVlJKS1BL?=
 =?utf-8?B?dmZTOHlwejJwejRKMXJzMU1zY2t0NENlZVBQL0RGM1RoUXB6dWVnOGFOSWo1?=
 =?utf-8?B?MHNPM0FXUUtHdnpKQ1VJQVVFQ0ZrcWhBUTRBN0xQQ2hGcUZ5UzlWdHJ5RmNH?=
 =?utf-8?B?dklSNVdxN1RQajBMeUNBRlorN0xPT29mcWdrQ0J3N2dXKytTcEtZUkZ2ZENo?=
 =?utf-8?B?YUdkUmRzdUJwV0lKdXVBNnVMVmdRMnNFenNmUU5rdTJQTENKcGJJZ0lJaVlQ?=
 =?utf-8?B?TnVmVFQ2Ukx5cUhSZ2JBVjZDSGtSZ0FlcEF1M1p2TG0vSUhkSy9WS29tOS9q?=
 =?utf-8?B?cVVUZS9ON2hFa0x1VnlnUWlkdy9GbzVURVgyb1RqamNoMzdNSFJGV2tBMmF1?=
 =?utf-8?B?UDd1cCsxS2ZKUFBreHJxYjV6SWRJYThXZGdDcXJ0bFcybGplRDFWWXhkYWtW?=
 =?utf-8?B?bC9VU0x6ZWtZZmpwOGVzbUhpckJhMUt0UmtSQ3NEbW4vd1V0aGNNUXNjTXVm?=
 =?utf-8?B?c1ZHSkVsYzZBWExxbysyRURuV1BmdjljMHhJdnJLYXFNaDEzaFFtSnNGLyth?=
 =?utf-8?B?K0I3dEQzTzVlSHc4SUg0cWJNV2p4bStJNkpIQUZxMEM1V1FPWjRReUgxbWhK?=
 =?utf-8?B?NFNjQW4weHI5bkM5S1lLS2pJcVBLZmJDcWhOYTJ3ZXZZalZhWDVSd3J3aG4x?=
 =?utf-8?Q?jxvhl6mjE/bYJ9gIb1ChCYo+G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wF3vwuxZIbl7goQZQPyCPRrKw30LGT3FOBI01laqJazl/4hx2hWnC0N1LJUlgSYU+2rzIGV+56slE+ER1oQ43kd/rIxZc7GrNhoHIxB/BVelQ8GqU7zrv0D9isPcNChDe704zkxtaYjsoGiDWFh7OjUAAfu6VEMX/oLHEpbzeGQDBqM8Ne1jReenHEI9r9e5YqvZDlpsaTDn6eb0oJi8V3rSVSNmB94KlMnYXp5X6dzsUBKQ/gBy7+RNHbKj5JebyRZnDemsWW0Te5JDkTqUykAHEGBi4LgoBw8LnzHvT/8a3fYHAq7GRKtTuOORPWi89b03XsUVe8FHM/XMQSrsPNjkKyeZpmoB/aKINgNfuVw7m8WirnG9QAhqvaJay2kOEukdRBI5KAMNpy2zQQcBb1JqX6aizmCxtu/coHanD/PerMyyyLSN+rQ4U5wJZGU4HOQ8geELXvT2SPgFu95ALVu2y4x55ZO5yIufw0DvsUn9HQ8Ob/ybna2MXyntlZJyf4iHGdkHLqj09mowT0vEHBytWt6ASOfFtx6bK5ja9kwLrJpaUr0ZqSZYWXuLCl5PMUbYGCMOXnxC5xwCwybRk1hJ8YutsXovt9jpZ3bmoZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4f0a2a-b192-44a1-cde6-08ddd6a55db9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:59:48.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ojdhOroqL1BnXW1pULe2H1mHLsCV9qdVr7mnOinLsFENTxOOpDJsqJWj2XVWx7UdqnGeH1ZPfNXVAW05X8sGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA634C6E92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0NiBTYWx0ZWRfXx7qEpLWK5l+J
 ZR7ANIhJm3DFbCEhL/k8eLhcPldhVlLWwvPrcLpq0A5SHMC/dhDWSgiWUBEOJhUndmpehjz8gRF
 YMGeCgn3WlJhjzb+RQBl8FJfZ+rLoq4NKdONOGJGjzyQi3O25vkn+Tm8rUpkug9939FX+sXkGtY
 rTrvzFfm94m/fk6yxRD2OXtTCWhTcHbKn2DUxwf8ZkuncthqstaajsGFVaNrRPn93V+dQxH+hzK
 uWAeWt9QlMxfEEZjVPejxojC1tezMu2gpbU5MvJjA4UOdh0RMZG9x1P7vhpO4IsOF+C35M09I+8
 jZEtkt3wdVzzRZI0QHsvDMGc8cnZULAb8Y3oF0Cpodg7aZolNzKq+Jje6vOzMIWUEBlKZ250v/+
 wvex4oewyYHlqKww5lbdbDyRVBNbeXTRgQTGaxtn4JYAsGPHApD7qGmm6VL3tJdgMYBBG4U2
X-Proofpoint-ORIG-GUID: Erdy-fC38ynCKS5Hq6da0BKIb7-gAtfq
X-Proofpoint-GUID: Erdy-fC38ynCKS5Hq6da0BKIb7-gAtfq
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=68963b19 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vWcshIEI482FqcI7o4cA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600

On 8/7/25 12:25 PM, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> DIO-aligned block (on either end of the READ). The expanded READ is
> verified to have proper offset/len (logical_block_size) and
> dma_alignment checking.
> 
> Must allocate and use a bounce-buffer page (called 'start_extra_page')
> if/when expanding the misaligned READ requires reading extra partial
> page at the start of the READ so that its DIO-aligned. Otherwise that
> extra page at the start will make its way back to the NFS client and
> corruption will occur. As found, and then this fix of using an extra
> page verified, using the 'dt' utility:
>   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
>      iotype=sequential pattern=iot onerr=abort oncerr=abort
> see: https://github.com/RobinTMiller/dt.git
> 
> Any misaligned READ that is less than 32K won't be expanded to be
> DIO-aligned (this heuristic just avoids excess work, like allocating
> start_extra_page, for smaller IO that can generally already perform
> well using buffered IO).
> 
> Also add EVENT_CLASS nfsd_analyze_dio_class and use it to create
> nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events. This
> prepares for nfsd_vfs_write() to also make use of it when handling
> misaligned WRITEs.
> 
> This combination of trace events is useful:
> 
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> 
> Which for this dd command:
> 
>  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct
> 
> Results in:
> 
>   nfsd-23908   [010] ..... 10375.141640: nfsd_analyze_read_dio: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
>   nfsd-23908   [010] ..... 10375.141642: nfsd_read_vector: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47104
>   nfsd-23908   [010] ..... 10375.141643: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0x0 bytecount 0xb800
>   nfsd-23908   [010] ..... 10375.141773: nfsd_read_io_done: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008
> 
>   nfsd-23908   [010] ..... 10375.142063: nfsd_analyze_read_dio: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=46592+416 middle=47008+47008 end=94016+192
>   nfsd-23908   [010] ..... 10375.142064: nfsd_read_vector: xid=0x83c5923b fh_hash=0x857ca4fc offset=46592 len=47616
>   nfsd-23908   [010] ..... 10375.142065: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0xb600 bytecount 0xba00
>   nfsd-23908   [010] ..... 10375.142103: nfsd_read_io_done: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/trace.h            |  61 ++++++++++++++
>  fs/nfsd/vfs.c              | 167 ++++++++++++++++++++++++++++++++++---
>  include/linux/sunrpc/svc.h |   5 +-
>  3 files changed, 221 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e9..4173bd9344b6b 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -473,6 +473,67 @@ DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
>  DEFINE_NFSD_IO_EVENT(commit_done);
>  
> +DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh	*fhp,
> +		 u64		offset,
> +		 u32		len,
> +		 loff_t		start,
> +		 ssize_t	start_len,
> +		 loff_t		middle,
> +		 ssize_t	middle_len,
> +		 loff_t		end,
> +		 ssize_t	end_len),
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +		__field(u64, offset)
> +		__field(u32, len)
> +		__field(loff_t, start)
> +		__field(ssize_t, start_len)
> +		__field(loff_t, middle)
> +		__field(ssize_t, middle_len)
> +		__field(loff_t, end)
> +		__field(ssize_t, end_len)
> +	),
> +	TP_fast_assign(
> +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->offset = offset;
> +		__entry->len = len;
> +		__entry->start = start;
> +		__entry->start_len = start_len;
> +		__entry->middle = middle;
> +		__entry->middle_len = middle_len;
> +		__entry->end = end;
> +		__entry->end_len = end_len;
> +	),
> +	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
> +		  __entry->xid, __entry->fh_hash,
> +		  __entry->offset, __entry->len,
> +		  __entry->start, __entry->start_len,
> +		  __entry->middle, __entry->middle_len,
> +		  __entry->end, __entry->end_len)
> +)
> +
> +#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
> +DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
> +	TP_PROTO(struct svc_rqst *rqstp,			\
> +		 struct svc_fh	*fhp,				\
> +		 u64		offset,				\
> +		 u32		len,				\
> +		 loff_t		start,				\
> +		 ssize_t	start_len,			\
> +		 loff_t		middle,				\
> +		 ssize_t	middle_len,			\
> +		 loff_t		end,				\
> +		 ssize_t	end_len),			\
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len))
> +
> +DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
> +DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
> +

Just a random thought: usually I add new trace points at the end of
the series to keep the deeper patches smaller.


>  DECLARE_EVENT_CLASS(nfsd_err_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5768244c7a3c3..be083a8812717 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/splice.h>
>  #include <linux/falloc.h>
>  #include <linux/fcntl.h>
> +#include <linux/math.h>
>  #include <linux/namei.h>
>  #include <linux/delay.h>
>  #include <linux/fsnotify.h>
> @@ -1073,6 +1074,116 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> +struct nfsd_read_dio {
> +	loff_t start;
> +	loff_t end;
> +	unsigned long start_extra;
> +	unsigned long end_extra;
> +	struct page *start_extra_page;
> +};
> +
> +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> +{
> +	memset(read_dio, 0, sizeof(*read_dio));
> +	read_dio->start_extra_page = NULL;
> +}
> +
> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				  struct nfsd_file *nf, loff_t offset,
> +				  unsigned long len, unsigned int base,
> +				  struct nfsd_read_dio *read_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
> +	loff_t middle_end, orig_end = offset + len;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> +		      __func__))
> +		return false;
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +
> +	/* Return early if IO is irreparably misaligned
> +	 * (len < PAGE_SIZE, or base not aligned).
> +	 */
> +	if (unlikely(len < dio_blocksize) ||
> +	    ((base & (nf->nf_dio_mem_align-1)) != 0))
> +		return false;
> +
> +	read_dio->start = round_down(offset, dio_blocksize);
> +	read_dio->end = round_up(orig_end, dio_blocksize);
> +	read_dio->start_extra = offset - read_dio->start;
> +	read_dio->end_extra = read_dio->end - orig_end;
> +
> +	/* don't expand READ for IO less than 32K */

The code already says "don't expand READ for IO less than 32K". The
comment needs to explain why. Move the rationale from the patch
description to this comment, maybe?


> +	if ((read_dio->start_extra || read_dio->end_extra) && (len < (32 << 10))) {
> +		init_nfsd_read_dio(read_dio);
> +		return false;
> +	}

Nit: Let's replace the raw integer with a symbolic constant. But let's
resist the urge to expose this as a tunable for now ;-)


> +
> +	if (read_dio->start_extra) {
> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
> +		if (WARN_ONCE(read_dio->start_extra_page == NULL,
> +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> +			init_nfsd_read_dio(read_dio);
> +			return false;
> +		}
> +	}
> +
> +	/* Show original offset and count, and how it was expanded for DIO */
> +	middle_end = read_dio->end - read_dio->end_extra;
> +	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
> +				    read_dio->start, read_dio->start_extra,
> +				    offset, (middle_end - offset),
> +				    middle_end, read_dio->end_extra);
> +	return true;
> +}
> +
> +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> +						 struct nfsd_read_dio *read_dio,
> +						 ssize_t bytes_read,
> +						 unsigned long bytes_expected,
> +						 loff_t *offset,
> +						 unsigned long *rq_bvec_numpages)
> +{
> +	ssize_t host_err = bytes_read;
> +	loff_t v;
> +
> +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> +	 */
> +	if (read_dio->start_extra_page) {
> +		__free_page(read_dio->start_extra_page);
> +		*rq_bvec_numpages -= 1;
> +		v = *rq_bvec_numpages;
> +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> +			v * sizeof(struct bio_vec));
> +	}
> +	/* Eliminate any end_extra bytes from the last page */
> +	v = *rq_bvec_numpages;
> +	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
> +
> +	if (host_err < 0)
> +		return host_err;
> +
> +	/* nfsd_analyze_read_dio() may have expanded the start and end,
> +	 * if so adjust returned read size to reflect original extent.
> +	 */
> +	*offset += read_dio->start_extra;
> +	if (likely(host_err >= read_dio->start_extra)) {
> +		host_err -= read_dio->start_extra;
> +		if (host_err > bytes_expected)
> +			host_err = bytes_expected;
> +	} else {
> +		/* Short read that didn't read any of requested data */
> +		host_err = 0;
> +	}
> +
> +	return host_err;
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1094,26 +1205,49 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		      unsigned int base, u32 *eof)
>  {
>  	struct file *file = nf->nf_file;
> -	unsigned long v, total;
> +	unsigned long v, total, in_count = *count;
> +	struct nfsd_read_dio read_dio;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
> -	ssize_t host_err;
> +	ssize_t host_err = 0;
>  	size_t len;
>  
> +	init_nfsd_read_dio(&read_dio);

Initialize only if direct I/O is in use. I think all this new read code
needs the same treatment as the write path: move the handling of the
esoteric I/O types out of the hot (buffered) path.


>  	init_sync_kiocb(&kiocb, file);
>  
> +	/*
> +	 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
> +	 * the next DIO-aligned block (on either end of the READ).
> +	 */
>  	if (nfsd_io_cache_read == NFSD_IO_DIRECT) {
> -		/* Verify ondisk DIO alignment, memory addrs checked below */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> -		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0))
> -			kiocb.ki_flags = IOCB_DIRECT;
> +		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
> +					  in_count, base, &read_dio)) {
> +			/* trace_nfsd_read_vector() will reflect larger
> +			 * DIO-aligned READ.
> +			 */
> +			offset = read_dio.start;
> +			in_count = read_dio.end - offset;
> +			/* Verify ondisk DIO alignment, memory addrs checked below */
> +			if (likely(((offset | in_count) &
> +				    (nf->nf_dio_read_offset_align - 1)) == 0))
> +				kiocb.ki_flags = IOCB_DIRECT;
> +		}
>  	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
>  		kiocb.ki_flags = IOCB_DONTCACHE;
>  
>  	kiocb.ki_pos = offset;
>  
>  	v = 0;
> -	total = *count;
> +	total = in_count;
> +	if (read_dio.start_extra) {
> +		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
> +			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> +			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
> +			kiocb.ki_flags &= ~IOCB_DIRECT;
> +		total -= read_dio.start_extra;
> +		v++;
> +	}
>  	while (total) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
> @@ -1125,11 +1259,22 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		base = 0;
>  		v++;
>  	}
> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> +	if (WARN_ONCE(v > rqstp->rq_maxpages,
> +		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
> +		      v, rqstp->rq_maxpages)) {
> +		host_err = -EINVAL;
> +	}
>  
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> -	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
> +	if (!host_err) {
> +		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
> +		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> +		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
> +	}
> +
> +	if (read_dio.start_extra || read_dio.end_extra) {
> +		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
> +					host_err, *count, &offset, &v);
> +	}
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e64ab444e0a7f..190c2667500e2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   * pages, one for the request, and one for the reply.
>   * nfsd_splice_actor() might need an extra page when a READ payload
>   * is not page-aligned.
> + * nfsd_iter_read() might need two extra pages when a READ payload
> + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
> + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>  {
> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>  }
>  
>  /*


-- 
Chuck Lever

