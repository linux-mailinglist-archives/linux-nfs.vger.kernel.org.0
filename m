Return-Path: <linux-nfs+bounces-9803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA2A234B2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 20:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE263A516E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199D18756A;
	Thu, 30 Jan 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ib4PqbEx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fDnq/eEW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B91E522
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265593; cv=fail; b=sVFoTDi61tUfED4IYhJF5CuotROAp6ip946zW86tuaAQrwn8dxuXhif04ZnPv53YB5mqvYoxbIsnBzXHo3YJjz2ZwW4YHgowGnSknrm3lwTUGMiA1gbXhv2TKwnm6gP56uEN5WF6dP0d9svDlQWhTmsPrDSDM2BCP6HgNV+Fs8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265593; c=relaxed/simple;
	bh=I+nq5GO3jSv166GDfFmFGBdAsJafhpbzxOwpoZ0PZAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6cmNZtBztvsuQF7V1pGLUm1mMq8YOdOZRdJ7NxT++wrTnPV6hUgh1IQX0BEaEg1JiZrlQVQdtiNSyUQuo44iR3NkErNPuNCx0FgvWWWPacC16e1gM+wpoN+MUxLbI9COwBvDhmhMHkvij145/oHgUXbneOT1msluyFdFlgQ/fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ib4PqbEx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fDnq/eEW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJRX0l029031;
	Thu, 30 Jan 2025 19:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kOXE3w97IX9+mI8NhKIusFI7O/GpVaO3lmBC89Kyg8I=; b=
	Ib4PqbEx6WC9YXHXSPNwSwTcNnifXWxWfpg/4okJbMToxH1mhLVL+8H+zK4ZLrAl
	lPicY3GV3IQXyglenil9Vp9LcV/FMrpYCrx9n/tjxjwV7zCW5Sde1ALf7nT0xZhy
	7vVpTTS+hq22of5F4w+tzW0kmQcXM8SU2IYI32DmJ/KLorK+0lMiL/446Ox4J1k1
	kS8OOwEpi7fXSss69hKaL2pECmbpbuqIoT0FwCAZjJuAknGdxH9uAn69C0MgVjx5
	66oiHHxGxmMgGTU/utD7+0B/E4Ic1KXg6y6dd6PL6e45CXw3DiqWqi9k3FqZQLQb
	9DQVC89HH/YkPeUNuLKlkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gfk980b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 19:33:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UIwfgu006655;
	Thu, 30 Jan 2025 19:33:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdbpwk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 19:33:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJKlfWWMRTiuVaMvTpUBzVyN/X9O7+34dJsPcicGda66ElXuG7DYOLHV/GQj4j5nHrkCl2+7WPxlD4r38ichJRieBWR3RFfxbWk/ATv91Y5ZAHQQASYRq2INgkqB5cPV4WO1HCRcSjsAN+/tkFkrW9xYUbe81kZmmBiOt46nRWqYLqpf7IyNRX5PL1G0JuFfnxPZyHH21LHLrOmB/NK4o5tvW5et+oJkepZt77e0ohJuRyPkpkFxtOUnRwBLNx0ZoR6u23/eIWX28s534FRWU9cjpGV5+8XeGqQM4PW4LNuOjk7GeGRkK0b6kSQebLEZRrQ3CkdmXhU1mafGfaMj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOXE3w97IX9+mI8NhKIusFI7O/GpVaO3lmBC89Kyg8I=;
 b=DOyJRv/laLr1N/VIZ35qkFow2x/aM8sTQntbMkmExtQvJ0cIXJZcZVpv9eVv8dhb2jUWKn+eT+fzPkyCTaEiInT6AMutghC3fKYw9Z1vNGTOKDD80TSn8x9uLqALHvWvGVACVhbjMi6hAlV/jN38MrlBCXF+2yymwzFBQvTv4aP8YZNW+gz+K8r8CDj9UWHzSxa4cvKCyBq1av5rrztX+rZHaAd4r+XrvNwOiZ6eurveJHh2wR6cYVSFHh1oTHIldCodLP39hMFKWg8jJ4rrHEpYzExnt+G/JaS/nvBeBO3KCOYLLDg8nluG647YAkaUB4o4VZtZ20ml0yZVtnm/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOXE3w97IX9+mI8NhKIusFI7O/GpVaO3lmBC89Kyg8I=;
 b=fDnq/eEWGsBVqWwtQt03fa84/FnSnVo7uHzn9vV3ESMjOmLfQXCeC48PylBFvqn58SLI9IMqOZPBMiEtlKDNqajxqf9EnIzXtwwo8mGtjLyhYcuTB3TH2vXJFb392BYhcs7Jznw4YeuAEhlE/hZDwQxmaqNzQYAy9jerD6yB9ZM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4280.namprd10.prod.outlook.com (2603:10b6:610:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 19:32:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 19:32:56 +0000
Message-ID: <934330ba-b3da-4e4f-82ee-e4c9d87b369c@oracle.com>
Date: Thu, 30 Jan 2025 14:32:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] NFSD: fix hang in nfsd4_shutdown_callback
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, jlayton@kernel.org
References: <1738263687-28256-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1738263687-28256-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:610:cd::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 353d25ec-f12b-4ddf-0085-08dd4164e5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNsNEdtS3RVVzZvRVBvMFhSOCtxcy9ncHdGRkVQLy9mNi9BcFg3bGpKSm41?=
 =?utf-8?B?TFNzbkRTYkJGU0lwN1BRWEx1RGVxZ3FoMGl3NldnVWZKS2R5THhqT2x6U2Nw?=
 =?utf-8?B?Ty8vSU5NdWFDemx5Z0VTN0tsRmZXakNESThNL015RTdSZXNrK2NGa2VuSFUr?=
 =?utf-8?B?R2hzeXBDemV5VENIZFdrUUUwODdwelVGeUUwTXN5dm5RUllUeWxmRnFlZzlX?=
 =?utf-8?B?WW4wNGRxSzlCWXBldW9uc2ZDMkdQS0J1VFpJaEZ6VEhoZUFVZ05WTm1VMmE0?=
 =?utf-8?B?d1JrK0V0Q1lxaWFsTXRsMytPWnJNM0p4TjRmdm1CWHNybGRMVVdjVEJWWkRS?=
 =?utf-8?B?ZkcwQ0pPcVBZdGhYQXljY1RwaFArMlFpaWpaRnYxQjlmSVRoc2JkdWxwaFVF?=
 =?utf-8?B?RnFpMjQwbnMxb01IcjZCK09qelovRHdSRnNFUlhXQjBJek1FNkk0R2VZZGJW?=
 =?utf-8?B?YXpxMmtTcjNqNzQvTlUxOEpPWjZvODlUVXJsOHlMZTZQZ0V2UmdvbWNHWWxs?=
 =?utf-8?B?blZ0aENjZE12K21XdWtVUEo4L05ONFZ2RHJVS0FqamFRYXBpUkI1Rjh1a1Mw?=
 =?utf-8?B?YUF3amxVZVlGU0xkQzRQQUczcmcyNDc2ekdMTWRScXZvbEYyK0VPSnlObSt3?=
 =?utf-8?B?UkkvNTFLbFNlSDl5eWtHak5zZmdXYitIaGZxT2ptMzJLK1lKTUxFZ1daNVM0?=
 =?utf-8?B?bFNDbnBING9xV0ZIa3VKa0xpN3Ixa1hyTGNEZDNzd3pDdVRRMTVRLzQvVGZq?=
 =?utf-8?B?L00xZ2xPaHNHemk0R3pHdmZPZHA4akFHakRyMjVYK1FOOFkzVXpOekhFbkNx?=
 =?utf-8?B?Qk1SWVJPcUZwdElzTi90aGJrOGQyTHM3UkxXNTIxbjBabGwvRnh5Si9DeTdy?=
 =?utf-8?B?VTZWb0VXeTVMai9VNk1BY2krQ0REdkhRbU9NNHUyRnJvdGFiYVBvOVFOTVpY?=
 =?utf-8?B?ZENyU1VZTWtubEJUM1c5R0p3Tno1dS93NXgvNVlHaHhWWGt4eDlZaDRVRENn?=
 =?utf-8?B?eGJQZ3B4MnJtMzltcVpQRzh1ZkI5RWtreTVOVEErd0JPZnNDekRGQ0lPK0wv?=
 =?utf-8?B?MVNPTE1SdVhNNkQ1MnUxRGs3TER4QWF0WWwydWpLZjVtc1VHTnVBSjcycFU4?=
 =?utf-8?B?QnlZSlY5TnNMUSt4N0F6Z3F5SVgzS2tyWFE4MlczeS81T01DQ1NTUFVVRHls?=
 =?utf-8?B?UlR4cGM0SDZKeWxoMSs3dmFnVFk3R0dIZkFVRW1HRG5CS0s5VEVqQVQ5a2NC?=
 =?utf-8?B?V3NoNmJlaitzLy84Qm9zWkd2RDZpdFBGYWZ2UE1PK3EvckN0YXg3Yy9HbEN0?=
 =?utf-8?B?UU40YWtTQWQyVm5VU3BNNG1xRStnOTNXU1FxWWMyTW9aU2pPbWtMdkpUTSt6?=
 =?utf-8?B?WWlSTUVrdFJLeEY5RGRRSHg5eDNpUTdCR0V0WXhBK3pBc3J6L2hIeVVkUE1w?=
 =?utf-8?B?c2J1YnpsUVJPZzJaRHZ6UkJRcGtRSDlEbzJLWGdZZU9Ob256SFozVXdseVZS?=
 =?utf-8?B?eHdiUmFDT2dNYjVWaHRxc29MZmxpRG15a2c4dGR6ajR3Z3lvZ0RJbGdkMXA5?=
 =?utf-8?B?TkU1ZVVZNHRndmk0T2NOMG9yOUhzbWNRZGx1R0wrbTBNSGhUK1BqeTJkVHl2?=
 =?utf-8?B?K0QrNHBoTlVTYVEyMkhscEQzS3VrSWhweUNoTkpweE5ubVVscUovMHNFdHZn?=
 =?utf-8?B?N3Z5dzJSbEQ5SWJIY29Hc1l3U0xUczllL3ovcG14WjZHaGhBMjJkYkhQcWJw?=
 =?utf-8?B?bUJHVXVhWElkVmsveHVVaUlWZHc0SzVKNloxZ3lwMzJHTlZYZFpDa0VRU0cv?=
 =?utf-8?B?WHludmNPNWp4Ynl3M05tQlV4a1VuNFJIbWlodWlId09DK1BrUDRYN3BHSkZB?=
 =?utf-8?Q?soOWpWv0Tm4NE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHB3Smlya0hMRkRoODluemdDNUN4cVVGM2dkdDF3QlIxdU16WU5IOGhKTzdG?=
 =?utf-8?B?cmUySVhQSTBJT1JYTEhwMnIyc1d1Ti9QYVlyZ2trS3EvR2grS2FzMzFlTWVZ?=
 =?utf-8?B?clIxeGJqd1h2bURVM1dxeHI2RkYrYmxjTzY4NTdHaCtaUk5YclQ2ZldnREFV?=
 =?utf-8?B?T3lDRVNiWkp4RnZkM3lwSGx0eExyellDOXRrK2JNSEFHVU1WWk8zeXppUlZ2?=
 =?utf-8?B?OHNhZUFCb3M1Vi9nTXl2bEU1THhoZldvU0tkZ3lpNHpUc3NmYnJtRU1oS3pw?=
 =?utf-8?B?ZHphNndkYXI5dWdQYlJvQUFaY2toOWJ3cHd6RU5oRDZON0pOTUszYUl1VFRV?=
 =?utf-8?B?dzN6RmV5cUdKRS9QSDEyWkYyTmd0R0ZkNHRGN2o0bGh6L1dlczRNQnRDZ0NH?=
 =?utf-8?B?UkpsbFRSb1VwMms3RStLa2FHODRiSTIzVUh2VG5XT2l0TllzNlJsVXgwWFZ2?=
 =?utf-8?B?LzY3UTgxeGxMejhoUmxPMWM2KzJtYWVuNER1MjVScFRYdGVQZ04wSzNxWEFU?=
 =?utf-8?B?SU9rTGpLVitWU3NLTlVlaWd1clZtSElyVCtoM2ZHZnJxRGV0Vy8vOXdhdUFm?=
 =?utf-8?B?bjJwQU50ME1yMHU1QVJLakRPa1VOSkprNitEMk9BZHVBWmdOZ2lqVTU4ajlo?=
 =?utf-8?B?RTBYQkVaOHgzNFBuM1RzM1A1S2lvTjRId2dmT253V1pQV25uY2lhWmE3c0to?=
 =?utf-8?B?dXNxQlFTOFkwT0ladk5rSndqRG42VndtZDF1aUpteEQrM21FVUZjVWVRRG5K?=
 =?utf-8?B?OWk5T3cvTGVKdmRYd1d1ZSticVBTTW5PTXFLQ2k5a2UrS1VrN21LRXlWUXJI?=
 =?utf-8?B?Y2Nrb25hRnJLOW81T3Z3NU1CVGdxa0U3bWQ5QlJuRktiS2x6ZUtGMy9SZ3Zo?=
 =?utf-8?B?YitwbVhjaFlKcU1ockJCNjNuLzVDMjNTcnRsV2tZaEVveUtvQi9weVFHLzhI?=
 =?utf-8?B?TW51dVdiK2hkSDR1TUMvZ2VpQnlCNkQ2cTBlMGpsU1NOZWhDQVV4K053NzFz?=
 =?utf-8?B?UldmeE80Y3JzM2ZSRXk3OXN0TXlGampDbEpHZEc1UU5tVEt3QVVhN3E2aEdV?=
 =?utf-8?B?OWRoMmxTSUZtWlNFNW55WGxNQktJRTRoNWZ4d2pFZ21xTnpwTWt4QkdISUFH?=
 =?utf-8?B?ZTZmWEFvZDFiYTBxYUpWZzhiUmdicnN1eHh5MkxzazBrd2JnRlZrT0J4djZ5?=
 =?utf-8?B?Q0FCK1MwcXVYcDJSMFlReXpuclVKMTdyQ2FzMmk0U3Yyb0VSVDNoVUE1ZjBY?=
 =?utf-8?B?clhOR0ZkMFExNEJWVGZIRnl5VVo0d0Y2SkNYVUdkRE1NYnpxUTlTRVZJZEE3?=
 =?utf-8?B?Wjg2Z2paMU4rdWczOVdmU1QyV25zYmRDSFVKeTNFcHVQSTdGaGZIYXBKQnB3?=
 =?utf-8?B?MTFOVUQvVEpxVW9hT0JQSmExVnFmL1JweWx6cmRXWTBRRTNQVXFLVXY4U1Bv?=
 =?utf-8?B?U0kzQ2ZTZVlUc1QwVVFmV1k3SHp2cDBHRml1cnJydHZSMTQyWEVWa3RUT0Ru?=
 =?utf-8?B?dDNtcmhVSkhSQ1E1Z3VudkNPa2VhZTlWUUdhTjEvQUdPQk5OQ1VSTTc4V0Zn?=
 =?utf-8?B?WVV3dDZqQnZ4NTF4UExSZy9vTDFueURITEpOb0laeTVacythNlRQYWtBblBI?=
 =?utf-8?B?YkNEOWdaTDk4Qnkvd0NjU2JMaUN3eTJjSEV0UFNOcEs0VG5uZE50SWtwU0lR?=
 =?utf-8?B?dk5BMVU4Y0RGa0YzUFJOMGJLOHRxbDZ1cjVOVGlRVXZTRTZscVN6MnVtQkF2?=
 =?utf-8?B?NVZDWHZ6L3VJVmNic2Z2MzZkcjhsNXNGeWJ3amppb2xkNHQ3czNQS0QxcWxs?=
 =?utf-8?B?cWV1ay9MdlovdEpqR0lBRFpUWkxWMmtZK3NWZ1BwWjZBaUdPei9jQkpXbWdN?=
 =?utf-8?B?K3VpZklGQ3ZwKzRKTmlyZU04RTBxaXlzTWpmcTlwZmhVWEVNZWcvdEY3N1Fz?=
 =?utf-8?B?cm9YdTd2Sk02WmpTcWZ1MXdBUlVPV2NsQ0lrMGZPSFpYc09WSWFFQTBiL2p0?=
 =?utf-8?B?aHhRV0ZUOGxPb2FuajZ5Vk5HS1dQOEFpMDlkNlc0RXM2Wmh0Rkh4ZVc0V1Fx?=
 =?utf-8?B?emlVdTFYTmlSbGVRRTZmb04rRTQyUUcvdW5Cd1podktLei9HS1pldWgwMkJN?=
 =?utf-8?B?MUlWTWhMcG9LTklvVVh0RWZqWHBuR1orMG9KVjg4Ync1N0hPRWdUOXBkbWNz?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	furovAMFd+OnT/Z1UcGjwWi/xtFkRdsNXH3a5XTO+GYoH7bldF9tg5hIaT5y1Sd0XeeEcT88WEw/P9ul0Ivb5UW8h/Wt7xBopmqBbGGbghWKpcBfXY12p6Kuofo2q360XRFXXTlY//EqA1CbH07WnggLhZAOg/eWfzm/QrzOSMnLDq+RufuL2bBgF3xwL9TvGf25ij6/hnqHTL40OFWq2Ri+lz4M1cG83GLj23ZGVVTShgWDpiwCfUliHj+e+hvhmBRMeHLtJUfcroWr5i+QxdhKGWx+Kb1OhJ9c1i4WJi3Da4liF0OoArfvXk5Mq/VnmAwqKaI8r6wFDQy7jlvk5tgAXOj4Awytw6veB4hjPicooEusEXmp2U9ZkqS7P8bojSug6gVHlwF3HmbTWK2RL9o2r4mpkU6dYTSWD6hdx0nUjxiSn09/17kq6vpTo01VpRpqSGQGkYCYCW9LWnr7hTkEsV1I5juKMwJCGdjXy686X0pkQ0HuWtNCyUeQSDzScoe6I023+zi0zLVdEFpe3O+KoJH2hBcS+nW/dDGKVprieNfhc2+Bm6N2DPdnQk2M4d+xF8Vvgo6EG18rginxWnCMfaS88WiXFw9Ubc9wB78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d25ec-f12b-4ddf-0085-08dd4164e5d1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 19:32:56.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0h+jUZp2sfCJv7z+5lAn1Ama1uT+/V+TChAwu4MzxywIoZwXw9GxDoDv7+dbf1M+/j92As0bde5jEtK0TZcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300149
X-Proofpoint-GUID: bN0O5bTgsoypfD08lra2IuglTmlkyqwe
X-Proofpoint-ORIG-GUID: bN0O5bTgsoypfD08lra2IuglTmlkyqwe

For subsequent postings, please send to all NFSD reviewers listed in the
kernel's MAINTAINERS file. Thanks!


On 1/30/25 2:01 PM, Dai Ngo wrote:
> If nfs4_client is in courtesy state then there is no point to retry
> the callback.

Perhaps this should be amended "there is no point to send the callback."
because this revision of the patch affects first transmissions as well
as retries.


> This causes nfsd4_shutdown_callback to hang since
> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
> notifies NFSD that the connection was dropped.
> 
> This patch modifies nnfsd4_run_cb_work to skip the RPC call if
> nfs4_client is in courtesy state.
> 

Fixes: 66af25799940 ("NFSD: add courteous server support for thread with
only delegation")
Cc: stable@vger.kernel.org


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4..cf6d29828f4e 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1583,8 +1583,11 @@ nfsd4_run_cb_work(struct work_struct *work)
>  		nfsd4_process_cb_update(cb);
>  
>  	clnt = clp->cl_cb_client;
> -	if (!clnt) {
> -		/* Callback channel broken, or client killed; give up: */
> +	if (!clnt || clp->cl_state == NFSD4_COURTESY) {
> +		/*
> +		 * Callback channel broken, client killed or
> +		 * nfs4_client in courtesy state; give up.
> +		 */
>  		nfsd41_destroy_cb(cb);
>  		return;
>  	}

-- 
Chuck Lever

