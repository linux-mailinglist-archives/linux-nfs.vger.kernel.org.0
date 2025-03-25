Return-Path: <linux-nfs+bounces-10864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29950A70A1F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC87B188B2EC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B51A8F60;
	Tue, 25 Mar 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6wE9034";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iKmbcRgw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780B1ACEBB
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929990; cv=fail; b=VqwhAgk9GEOtmLJidohOCiqUnG0QlP8fDjOoN4iZP6CbVjrBe5/ff6wQQ6ttnvWkAiJpvzmo75z+j3WWEMn2sXCZxaO6vzeuQ4l8qaFqFPkmS7IQo8RFqySaVG4auxxeZ+wca/EGdR6Aq5tiQrQnL5v0Zs0Tet4EvIujKP/fJtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929990; c=relaxed/simple;
	bh=Xbv84yzgxswdfipOlRhJdUF+RQmPgi86JnWz7TmE4MY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j30wHi+zfcTtIQBVv/ZfKQqwdofKGCrI8vQV6nxct2OT6kF6DqJDQCKFfnujOSEhPPWxQ13qCM8JGvAsCMCSUc2PFk5aTlBuJ/YA1mpcRK2aX6XUmSvkdvIGI+uR/Ica/Sa6xXusbdkah7cRj4WpA1e7TGkJrBdWVqLXSMpsn4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k6wE9034; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iKmbcRgw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGl6OO026012;
	Tue, 25 Mar 2025 19:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=deaxfY5mUGtDh5C2aSgxeHa761n3O2mC2/c7iu/rixc=; b=
	k6wE9034g75EMaOhpRPwlC/QZ0n/Dq5TXRS4F4zNL4Yf2aaN0z3AtiwszO0vX07K
	VdVo0HAsCCQtmeDDaBKws4cnCY7DjcXnmrNFESaef05fU26RY8Ol1hkqeaxbh/0P
	Xt+Dp6t9x8duRLHuy8Pz4zUzrRDS3lLMr267FSNVNMDPKqbUtxjXuLG3TBriCA+J
	OyVkEBjRYBQDNjf+sQ6cXLAOR5DUhpHMNJgNZ54DOuuDlBc8TDqJOnzK7uDxpR3D
	Jv65m7Ml9aA0XvTBbjY44O5ON3pJ6eNl+14zIhUHB0KOyFHTUD2h6N6Lzxp5E+3Z
	QdEDhBB8KU/vtNkdCiQjbw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dqwwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:13:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PHZ2Cm023835;
	Tue, 25 Mar 2025 19:13:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjce4c8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG/ideDPxdlsFBHNTBeUSFimGqymQ/m3qwACC7wibUngAjuxSEXkd6tmZXOChD7ovChmS3AeS4A7DEqYXZr3h6UW6Gx3Kq6TLwoFecY/LvCi9drjptQ82eiLNLN0hEvZpnXoMvZ9op8QcxrsDO9S4hmZce6e7aPV/+BLBWhRcQ3TlvkVLpXGp5PtOf+L/K24feNwsN0yH8M0YDCts6SK8CWlVonvSPlzaPAKYRXZK4yilOEdO0kVcIYtCCHR0NhIlisZ6YwIxiwUrvE3dj+ttj5RCILqGpxq6eFNqg1PXVk7sSreP+Xn3/X4WArmW7yhYzoTpVCLgQNxL6j2wgFMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deaxfY5mUGtDh5C2aSgxeHa761n3O2mC2/c7iu/rixc=;
 b=uTgIKcT3aFYsiQ9QruKkgc0Wb/aYjfoY3FLxUZmdbZGF9lO4uFDFyyXd+7ZUEGUGFyP2WQNpqV3mZli9xOqG4/wIjmaWVEExCRQrt+u6PfStuEYKjIiR+aXEcLwIqz3zGQte1aT8njyzzJ1mGqkXr8vVqTZDpoS6Z4u+mlQXk4wDNxy71p/td+b0UgxHtqepp5UFvViOUt27GiQ5PRefKfeY/olR89k4DEJOe92Ko/OqwXXm1Ntd2FKMwUqCLX2GdF48K+vt7JLoXAt/qq5qlTPXqK6JpELp9/TwsLWzlzQ9/D0XUWR0Gb1kc5xob1S4WfXGa+wUPYgcJCkp/HMFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deaxfY5mUGtDh5C2aSgxeHa761n3O2mC2/c7iu/rixc=;
 b=iKmbcRgwTL0Y/ocvukex6aGLwtoZC6UHRBZAxZs+s60qp/4dYEac2vzW62LsUTc2F+xTSRo6G4qJ+SrFlMHsO3qgSzquZfv5NFtff3H1xkORJXy61PN1JJ9Dl57cYcMwVLkJu6vIhH4dn9qbRLBdgvzC3oNWDB3lU29FHjs54KQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7932.namprd10.prod.outlook.com (2603:10b6:610:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:13:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:13:03 +0000
Message-ID: <06f68f5b-a9e1-4fb9-acf0-43c11b14efd9@oracle.com>
Date: Tue, 25 Mar 2025 15:13:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel.org CI NFSv4.1 RDMA testing / test coverage?
To: Lionel Cons <lionelcons1972@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPJSo4WFWkrv8u6FSEy0JWZ7nR-KAA1YeRkce8dFbXARSGdrEw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPJSo4WFWkrv8u6FSEy0JWZ7nR-KAA1YeRkce8dFbXARSGdrEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d718769-bbd4-42ae-dc3c-08dd6bd1112c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtQQzFGYWF5dklwamxUUHhaTUdCNDh5VldILzhPbUc5YTdHcGZnRkZ3UzdF?=
 =?utf-8?B?b1g2YnpQMUxtaCtENGtHMlJrUGlIL0p1dnRaR013TjZaQk1sZFFIQzZFbEUx?=
 =?utf-8?B?WHlGT2Y3a1lqVnZqQzdtQ25EY0hreGZ1L3JLWW10d3Vyb3BZeWc5WWdXbzdQ?=
 =?utf-8?B?OEFkcGF4T08rdFUwZHRSVHF0Nmp3WHhWVXlsZDVLdzVuS0hOQTFCM3M2UXdl?=
 =?utf-8?B?UFRObWNyd2JLT0Z5YXNUM0dwdEZOVmRINUhQc3FpSHpZdlRUdFdjMUh5Y2xp?=
 =?utf-8?B?T3A5U0phTnFROEcyUzdPMi96UWtnZUthSmxZYVJWbnI4UmVneUJoMmxvb1ph?=
 =?utf-8?B?ajMvOSs3bU5KZUpic0E2MUEyVlRaQWllbEg4VWFDc3M2a1h3U1YwcmtrUyth?=
 =?utf-8?B?ZWREM1pXM3FuNEhFNFplZEFzS0d3cVFtS3M1NWtMdGE3K2ZWR3hldkF1NmJl?=
 =?utf-8?B?NTJ4cXRNcjNTMEhoUHUvSThVREp5eG5DOVpyRDlSRVFSUTNxejJ3SW5wM0s1?=
 =?utf-8?B?ay9OcVRqRThGUU5oa1RnSFRHbVFldlJwTHNqOEhYYnh6Wk8xbzAwcGorL3VL?=
 =?utf-8?B?Qm96cUN6dGYwS0paZmZWZ2ZsQXkzVjRMR3dJN0IxK2JUVHNKdmpIcW12N3Qz?=
 =?utf-8?B?bFJuT2pvZjNod0lHNDJEbVJOY2cxdDkrd2YvQXhJRDhWS050S2grMHpCMHor?=
 =?utf-8?B?ZjZBN1RBRVhSL3JrTmJ1cGlIQnNVcWR0YWZ1SGxDVnRXMXFTdlYrQ3VLbHhY?=
 =?utf-8?B?RU1sYXVYLzlaSzNvZjg2amJYVFFmSzQ3Z0owSHRpc2N3KzF1dHBqenN4NHpQ?=
 =?utf-8?B?dmlWSXVLZEF5Q3MxaUk1emhOOUd4ZWs1RXNSbjBDckxUTFVac0hHQVhab3Fm?=
 =?utf-8?B?WkhsSGl3RzFNcFVqYnZBZzhXcjFQb1d3aW1kQkdjblFNY1FPeTRFQ3J5ejFC?=
 =?utf-8?B?SE91ODdvb3dIbHQ3eWUxTEFjV0hiaS9Wa3YxdFMvZ2lkOUtIc0ZvOC9oZ2dv?=
 =?utf-8?B?bkFFY2FrWXNxOUl1RGZTTkMyZ2tUTUFCN0NVQVFXZEI3Z0p6dWVhRjNPWFhZ?=
 =?utf-8?B?cTZBRU1kK2F2bzRwRkJ4ZlNTS0VjSUl5YWFOTzcxSFFYUzF2K3V0M2RWN0xs?=
 =?utf-8?B?RkxhUmliQ2V1elpZYUcwYjJ4eTY0clE5MURPMXd4VHpBK3N2ZW9sVFlaNWha?=
 =?utf-8?B?NkIxcGg3S3ZZNHF1cTRnS0JGRi9EY20wMjA1R0F6SXdOU0VEUUtSemt4L1A3?=
 =?utf-8?B?anRzTGxNQkdEbElwY2gyQ2V6OG9zejZ1L1pGanBGa3RqN3llTGlOVG5GQU40?=
 =?utf-8?B?TVJNaXJGeURoMEw5KzdROWpIOEt6UTBtN0NHbHpWd1AxTS9Za2E0RERtY1dZ?=
 =?utf-8?B?cWFhbTJtK20vdTV4MlgwdEZ2eTlVNTU2L1M1QUJGamdxelI0NVdibFJ1K2NQ?=
 =?utf-8?B?Tm03cFlDSWtKU0lmRnA0QnM1c05YVWZmME5DNmxSbzhtVksrcXNYRWhWZU5C?=
 =?utf-8?B?bForTGdWTm9lVUFOaG9iQ2dSbVNGNmdYRFd3bjd2TnNLb2ZQRUV2TktJV1Jo?=
 =?utf-8?B?RjBDZURFVDZYMGI4dVJlaExIbHZzQzAyUGhYZEZSWmxPVWRpWFVmckpmUUV6?=
 =?utf-8?B?OXh0bjR4WEZ2OTE1SFljNVZLRE9NUnozai83MGY4WmNQeEdWb09laGU0em9E?=
 =?utf-8?B?U3BoMVc3L2pPUHh6ZWM5eGxEQ0cvU2dTa3M4b21ZSFBSZlNmc2RLcUpvempu?=
 =?utf-8?B?N2ZMUkUzbUkyUGNZOWRxaFJIWGFMRG5BZXFhdTFmemVhSjBwU1JVSWtyQStK?=
 =?utf-8?B?VHhjSVJpUTBGSmlFZUh1SmIzL0xhYVdLK3JTTndUREVaVjZTT0NqUmViZklG?=
 =?utf-8?Q?Nl52A3VwbEbIt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlVOdnVlMFFOaVYrTW9POXpxUVBlL2E1cmU0MFd2MDdLNDFjZzNGbXJTTG1v?=
 =?utf-8?B?elNiVC90Q3U1T0p5TkhpY1EvMEtaMHdVRXVDL1BoSDllK1lzZDV0Qnk3R2J2?=
 =?utf-8?B?OGpqMEdGMXJUdDI4QXk0bU1LZ2F1UGdpb0RSR01CK1gyZXNYcCtsWnE2T0Q2?=
 =?utf-8?B?cnFaeGxkYkgzVFdqUU11eW12a0M2c1FtNlVtcmRnNXBHYnJaRkVLbDZLeVdT?=
 =?utf-8?B?QUlrMEZZYTEyS2lzbVI3Q09hc1p1dTJ5YWtDanp0TE5DZVFzdUpUV3c2eTd3?=
 =?utf-8?B?N2RXbUEwL1ZwTjZVVi94UnRwOGk2OTNrTTcrVHhtQzlZcTlFTjMzc1JuSmZS?=
 =?utf-8?B?TUxQdU96VFZlSnJ3TmNSUHhsaHNzQ1V5dW14K2JucGxHeC9aUldtWUtZR2FS?=
 =?utf-8?B?UTl0a2dSbjVqSVFyQlhFUEZvTlF5RSt4OVcvUGhrUzVGOEtaeXl3Rm5WUndU?=
 =?utf-8?B?dXJESCtmYnd5YWRhNzRyOGJWblBHY1ViTEFaTmJyTEZUU0lhK0lYUXpYaDZw?=
 =?utf-8?B?ckdBUFo3c2gzNjdDQ3RNQUdPWU9nU09sUll5SFkwbG4zWm12L09GZVFRZDRW?=
 =?utf-8?B?SG4zMU9LY25lVnM3RnFkRTcwYVk5Vk9lUlJXSUtnNkRRR0ZieUVXbE1YTllD?=
 =?utf-8?B?N2s1SVR6Tyt2YmRwL2J0V1lLOHl2andLNmV2ZlcvYy9yUWNPRUFZaW02ZUoz?=
 =?utf-8?B?VS9tNjkvTWFwVFdLck5FZ2dma0VUZGY5TFZRdG5QVVVGRnZDcWdzRXI1SFVy?=
 =?utf-8?B?bTBFc1RNN1dTaThTcExOZDYzaEdTcUYyWHMxZmJQS2ttK0pxb2dlUHMyaXNG?=
 =?utf-8?B?UWtSZmZmYytuYm1JMjI3SWU3dkViRitiaTJtYWJpS0l4Zkx0YlBQSHVtUFBS?=
 =?utf-8?B?ZitlSWtGVVYwNExVb29RSFJWUDFZeG11NnNqVTIzWEF6WnBaZGsxOU10SWV5?=
 =?utf-8?B?MzhtNEM5NkdJNS9GY2xjK1JlekwzS3pKRm9sdXhMaW15Ni9YOUpzcGtXd3hI?=
 =?utf-8?B?SEJkaDkyU2oza0J2OGM3cXFLd1krTWhUZ0EwK3VYU0NYN0NBT1cvU3huc09S?=
 =?utf-8?B?NUtHQjkrR1hKYXpuVk15bmdRZ3ZLdEdjOWVnYmZneDlLd3lzdGI1NjFGMTZx?=
 =?utf-8?B?U00za3BIN2VxaGg0aXF5QW5qbityZDdwNHhEY3ArVk1pcGFDNG85cyt3QXZi?=
 =?utf-8?B?amNVek8yUUw2d2o0VzMyREdRUUdPaCtrYWxLMmRCNzl4MWM0dXRQUElOVDZP?=
 =?utf-8?B?UDNVN25sYTg1Tnp0OU1SSU9iZ1dERHNHN0g1VTZTejF6UjYwNGpVWXlXNDhv?=
 =?utf-8?B?OG9hQ0pxYXIwK0NiOWJCUWVDWTFIZ05hL2ZQdEhLUUtUcGV1MWxQWjlSNlYy?=
 =?utf-8?B?OUhlTG90czRaR0phdVRlRWpXSlNjQ2VMTXNMOGdjOWhQSzB3OUJ6UlN4QzZL?=
 =?utf-8?B?UU9VQWNDbUd5b21paHhxUnpyTTV3Q2pjVlRJektMQUcwbnFWWTZybERhQlhM?=
 =?utf-8?B?bnloU0wxa285c2txQ0o1NUZ4dmtHb21xN2lkUnJNb05neDNTMVBSdHp6NFBw?=
 =?utf-8?B?RW14VnIwV251ckdWZUp2L1cxaXdieVBaektpdWFuSFAvQTA1ZGxNelBGQXJQ?=
 =?utf-8?B?UnIwTnpCY25wWlFMM2FYa1pPWGc2Znp5YWNyWTRwdjh0c20vU3MvZ092TmVs?=
 =?utf-8?B?RTdTUEkrMlh3ejh4SHg0b1JpMjU4UmdUejFJdHdqR0dOL0dlRTFFd24vWUZ6?=
 =?utf-8?B?cy9rYnFWdkRwdDVSWndIekp4YzVEYkF0SzVvamZ0TDN6WFNlQ1BmRmNmOVBu?=
 =?utf-8?B?L01aTlkxekdta0tQSkRVUXFFcEhMK3IzbzZLQVo5WjdlNkY1Qm1NeUdSYy9q?=
 =?utf-8?B?MmphY1g3ZVhOeFYrWjdWMHJFdjRLcmJmeUJQRWs5ZUxDR01VZ3A4aTFGbnBv?=
 =?utf-8?B?Y1hoUzNHVkFyKzhqMWpmU3FaS0dFRVZNUDBvc25xMHlsM0dtZDVJMm9LaWg0?=
 =?utf-8?B?bS9XdE81YWRLNm1hR3czWGJXazlRZzhibWNtbXJBeTBFbUNMTzRVWTlvdXZX?=
 =?utf-8?B?d1BoZDhDOUgwN25PRDJrNmdrOGxzekI4Myt6U3VCVDNaOEdrMmxKTG01QVBj?=
 =?utf-8?Q?LcXs1HN1ju51I2/hbCz9o9dKJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ogkB5t4CEk+zKh5phONiellMMItEifROIcemf5fnSxTazvQlmBiNc/NzElXbEqgsNi5+3DyHEs7ykAg6P1InVXERopNtglofVFbx3Rz4fmNnOEGoArwK0ZAtPu/Mqx0in0qCat23TsYB73yHc0pMNyit7cMrzjYJKGaSLoG6ne1HOok1KtR9qRskEsTIGNFtHjKIRNuVKC6i3O/tSw/UEmKgp/KZqxf4wmqcSVPkpHDFTtv4u99Mt60a6OXeFet5KaRXao/1nd+0Om8mEFLZd1xu2yvrCQ0mLjYvC5uPK/4tzk1eqh4BjQctExNhkIKv9eSSMrx2E1TBNxwwzpav9dMUaEkHm3oq2qVqqcigB94cYkrsufY39r/AJWVOHj94j7dAYaVwn9pRTLETyvJoqqDzggxMuCXPSX9LpiEsO5wfrOy6Rdbq783+mnlJUNOvByVhyXz4khu2XiY78How0v7kNCl5vKkdBs2Zvl111xUpgfqqjXYVfziWRZjshBdVCrKCFaDiG0nFyDcnM3HEdbdqEwh5dPhk3nltVRRbs2CbrcpsUDOTAEERZitSK31IA+UUopUHxQ/V7brM2pIpGL4o9jgV1LUTOM6toR4qnmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d718769-bbd4-42ae-dc3c-08dd6bd1112c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:13:03.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn4RLMSHcxn8Saz/OuFI76NG2Z2Uu9euLkNKYQ2CqZfoeV7DebKomcR2JhAEcQ9+nMbfE7Hh14UkhQtIedCpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250130
X-Proofpoint-GUID: Sb9O1qwSvSCn6TAdTAg9wAPzaIb1rqCr
X-Proofpoint-ORIG-GUID: Sb9O1qwSvSCn6TAdTAg9wAPzaIb1rqCr

On 3/25/25 2:50 PM, Lionel Cons wrote:
> Does kernel.org have a bot (syzbot?) doing NFSv4.1 RDMA testing as part of CI?
> 
> My feeling is that the current NFSv4.1 RDMA support is under-tested,
> and needs better test coverage.

I run tests nightly. What makes you think there are testing gaps?


-- 
Chuck Lever

