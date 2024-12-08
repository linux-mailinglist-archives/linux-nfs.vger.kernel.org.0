Return-Path: <linux-nfs+bounces-8428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B899E8630
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460FA28156E
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379D157A46;
	Sun,  8 Dec 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kWIpX2WI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUQGnmNE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA513B2B6
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674337; cv=fail; b=R2ayOEd8qPK0KkvTOQAxrxb/soHB2VwV28Jx4gDxCnfq1nivTMWgTf3koYmEv//tqUyEL59qC5WLr7pstJsw431ckvRcPs5KQ7yl3VHGecqxY2iAdUgSzqgXdAC06TnAS6Avi34SJuJCf6BkEEFiVe61TjsQDZhm9PtRycLSew4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674337; c=relaxed/simple;
	bh=fjVRvyq+nmUzCLPdY1rdeGAhweagXp+SFeh3YZF61to=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HvMFFH9dW3SqEiFMYWQlqS4QD2JZKGeWgERWPemRN3Bp/TbS9NJAVtdrfciERrl6NvxLOt1okQi8Ld3YK8ahgX4UmOD9whFmq8+902TcxUEWW7q6/Xmh/zvCwdC4kdUmW69685cIMGs48TkuWGilzQ03GSj2wwkaAcf272emozk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kWIpX2WI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUQGnmNE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8EFBg5010612;
	Sun, 8 Dec 2024 16:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JhTMNJzBBh2zn0dhBFePNUByzYHdxJrNYEkmHTlxzdg=; b=
	kWIpX2WIK2iUmcRH+etEn+Vtp0Zt+uotC7ZbxXD8OkFxKN2K85WQMZe9EOr86zGV
	D/Legob6yoB37HMHws9vRa4RRXU3PQVDH+4prgavsKfl97vLU0qb57rbIoESmMOE
	kkL0qM1uPPAp2tzkR0ks5fASqUAl5cxSvEL79odEb5OnrbhGfpmMF6Zxagai/vjM
	EcQAi0IhmXeQuAe4LfdBqaiEg/z57FcF+fHDTWMKiFI95rXe93m/mCpmMwZDCC4N
	9SG0aIGAbR9vxrGUIw1LHDE97qaRYzwDKKZcA7fgzctvYkuhE8ncQ7SQmhhMDEmt
	bR8pdEJu5kUpAJhjVmxJJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc1x3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:12:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8E28ci037949;
	Sun, 8 Dec 2024 16:12:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcjnrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwPLuKQev2hIkQerN+kS+DPrVDg+7kvHReRXHfTvnzp+qhlodJkqUPBYSho4iQmzswA2WJSqm+C+i3lTCm+d91V+owHRdZGbHMCdaLdWf2XT8JFzP+zKrNqa++coxVrHxGoNyzxKhsMn2yvHCFHH6YIQj8yyV7dGry/0WhdaYCm/bNsEu41CSTB48lEgjaagoNKkfFzkBG+FvGQf45DgjwtHiPnG4G9sSJo9Q2z2Mo1WJjEE3e8UilPpLR99eqfyRxCeNEgAOAcwbMLurfxGHVexT70bGf4ZthUhwinjnapIxADj0fCwNSy2MkwA6SAchHwHKUekWllk9MPw0I4siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhTMNJzBBh2zn0dhBFePNUByzYHdxJrNYEkmHTlxzdg=;
 b=wp4jqJz5H//y+FhA/cqJfwx7t68V12IK54+a9+5u5/5RL1GtPJ9nOUAGrrQh0QqLbB1UMJz65eXCm5b9XaRLDKEXImd2RiYazunPi7JZe85+csL5mBHLDbAsSNQBbvONIHJEHnt5+t9YtqwrsVPIImDQEHluLtlbuqEcxTr3c5fpnUK4yHfxxV91uemH3KdWId6I7zjTF9xJix9s7HCIcw0SujSDPFE/uTRKuBWZ6SYLNeVlcO55y73Mo/iIyofTdN4MyGkGgJoTq5+GcZE6+rOWTiMXEOXIVTKVnMGOkp5XWaaNtHKT7qkU4VS/wbp78C5c2Ltl3KfSnTigVL5xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhTMNJzBBh2zn0dhBFePNUByzYHdxJrNYEkmHTlxzdg=;
 b=yUQGnmNE5jm+BFfN/C+zxTC2qIKuZpN3DCl2E8SJd7ejYczutcy0eA/FWtwwpD2OLlCoDTd3KSIPY1aXrSofs+eGtGbwBApSRjR16Qj1cSjIlXOgxLMy7uwvWGoW4r9RWrC3LnHWgzIHnuPQww/MqtqPSv14rltbhW2Kllaoyjo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5835.namprd10.prod.outlook.com (2603:10b6:a03:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 16:12:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 16:12:09 +0000
Message-ID: <6f09b6a4-04ff-426c-93dc-323f41ce019e@oracle.com>
Date: Sun, 8 Dec 2024 11:12:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
 <CALWcw=GHZe4_9BejU8xzNOcMxY42DVChcKysFfYHQns5uH238g@mail.gmail.com>
 <005d46bf-d017-4419-8f03-8c68cecb1e27@oracle.com>
 <CALWcw=HDeNOhtJaT2p+652hwBc_L5gTXbzO7Ls-6H+_=58scPw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=HDeNOhtJaT2p+652hwBc_L5gTXbzO7Ls-6H+_=58scPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:610:cc::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8722e455-80e0-4470-bd23-08dd17a3114d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnZJNzFUazh4Z2Q2WjBoRE5EcHdlK1JsRnRJYTJnVzIyOGliTWxBVlRjdnY3?=
 =?utf-8?B?OXlMOHIzb0tRclNqM0RHMmFaaDFudzEvZU50dnZldmM5TTFGdnduZWRZUnhC?=
 =?utf-8?B?a0dRRHRyMDhLbjAycVlldzNoVkJLZTVsbWNVVTdXSVIzdXdUS01Ya1l0akwv?=
 =?utf-8?B?Uy9uY0VIS0Zxb3dQNDk5cXNSY1lnVlBIQ3BTdTNQczBmUXl4ZURkVHVsRjdO?=
 =?utf-8?B?bU9NL3BMMXBZTnRJaDdoVnRDd25la3VTbkdkQTNWRmNCUFA5ckhwR0hDQ2E0?=
 =?utf-8?B?Rzg1RjRjWTY2WE9VRmcwWkR3UUQ0UmRudGMyZmFjbU1odnErVXR3UkRoZ3dK?=
 =?utf-8?B?dWpveDhuMHVXcFd4YVROWGRlc2lKcCt0dTBDKy9UbnNTcUZBd3owY1NOMTk3?=
 =?utf-8?B?azZTRi9yQUhMYXYrRlJ3ZXV5QnJkWnFDRzVTaUhPaks5SkZPR2puUDZXYTh0?=
 =?utf-8?B?R203RzBUK0dqeHRPSStUQkNtckVpSUhtc3lOVXpqSjVoZ2VyM0xLUnFBZnVQ?=
 =?utf-8?B?M0xTc0dlQWMrUmJxOFNjNEpNeVBMbDlmQWMxZGpQakw0WVNHWGlNYndhbWZa?=
 =?utf-8?B?dHhuOXN6Y2kxMEFYZHdMZEtRV3Y5QjMxN2VoSGNxWUV6NHlOUnM2UGR3KzNP?=
 =?utf-8?B?VXo4NlBPZmVuQkdLMFQzOWs0Nk1ORkJqOGpodGJ3cXhJemg0K1U1NCt6aklO?=
 =?utf-8?B?dXBydVA5YW56OEV0SDBpcWM3RzdnbGpIZVJuMXFVcGR0TGNTUmcwYVdBaDRm?=
 =?utf-8?B?Witsek90R3NWN216UUVFQmtQOFh4T0JBbXcxUEprcCtzaENSRVVJWXg3RlVK?=
 =?utf-8?B?bVlwZ1dRYkVGd3hVZFhSR01jVUdaWktRRnpYMjVETVJYdkhRNlRPSkpRTm1w?=
 =?utf-8?B?cUJ6cXNJQTFQaUZqOVdCQjBuNFB6U3BXclRyUjNIQzFDTFRNOG5iLzZGV2Zm?=
 =?utf-8?B?aVRoenJmZStjOHBINEt6S0JmUXVJenJDZmtRS2pMbnRvUTU0NWdMU0tDMTBB?=
 =?utf-8?B?RGZ4bVl4VXVmQ1IwVXZEVmhwNnk4WjQrcnlnY1NXSktrZ2xSWHRmZ1FoOHVC?=
 =?utf-8?B?WGpTZlZSVU54Wkh2RzhmeDBYTU0xb3ZzcFVxdkoyMWpKQ3pudmN6V0RkZGp1?=
 =?utf-8?B?YjIzOFBwVWRhbms4Q3krbG1OUlYvZU9rcWZLQjRxdmtDdGkzM0xQc1Q5V3Bu?=
 =?utf-8?B?dTNvd3pGWTJvbHQzN0FrZEpOcXVTc2xTSnN6aWNYbGp2QzVTVXZoQSsxd3lx?=
 =?utf-8?B?aTN2aXJVa2hUSlZkZjVPeXZkcVlRSm9lbVVzSUpTbkJyb3R0VE1FMkJmdzA0?=
 =?utf-8?B?RkI0MVdOKzEyNWNoM3N1ZGNCS0hpU0tOV3FiYUVyaStVa2t1T1NKbUVjNmVy?=
 =?utf-8?B?WHQrR1RkS1hDN3IzbTBMOFhDcC9yenB6dmlZUEVhdFA2ZytRKzZSTEdrWGZV?=
 =?utf-8?B?Yjg5Y3ZJbkRDVW50NjQ3NUxCNmZEVE1yOXJNaGowbys1djFNMFRyekRHempn?=
 =?utf-8?B?anBITlVoYkFJWU5OZkIyZ1ZFQWlGMUNjRXFNOERENnh0R2FjU0lMYjEzZExa?=
 =?utf-8?B?djNvMWNQVUFCVHRYK014MDZmRlFpak5vMEIyZTduVFZPeGJuckU3UXhzMm5M?=
 =?utf-8?B?Y0J2dFJlQTFCUzl0WE1KYnUrZktoZmkva1Z1Wk5ZTWlJOThKMHJFSHBvbDE2?=
 =?utf-8?B?aUQ2Smh5OGlhYUk4YTIreXlOOU9kRmhWZ0dsT2c2OXN3MExWa253K1krN2Vw?=
 =?utf-8?Q?5s7b9wnhzNAse1OV48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnI4QW9IVmhHV3NsQ3ZudzIrRytDK1llWm1yT0NzbWhFb2NvOGNEWmdJWFdI?=
 =?utf-8?B?WEQ1MUFJOUpPTHIvVEt2VnkxTCt1RkR6dG1qMEJ1NkVPQVgvNFBvUE5ub3Y0?=
 =?utf-8?B?WWlzU3VZTE9qWlNtRlBvQUxEQ0h2QmtlcDZ1cUJ2N0s1SGVBSEZDdmo1T2xq?=
 =?utf-8?B?MTRtUU1waC9lZGFKRkZwMnlCbEhJRnBhYU5hVmlPcjNFdnMwQkNTaDB5R1ph?=
 =?utf-8?B?TTE4d0NueUdxMTJVaWJwdCtYZFJFZlgzNG9FUkVOSlo5L2Zrbm5SdDZWYU9N?=
 =?utf-8?B?bU9EaHBSOXRpdHY5Ti9xc0pVYTNJb0V2eTZjKzNteUVNN2Rra3M5bTBrNVUr?=
 =?utf-8?B?MmJFV3NMU1RYOVFJS1Y4SVh2c3NWWGFuMnVBT0ZWZ1pQWjlQMDdlZiszVGVJ?=
 =?utf-8?B?Y3lJVmJKc0IwWmFON0FwVVNIMEMxTzVydDRKdlZobHI0VWJtak4xQm9MQXpS?=
 =?utf-8?B?cGorWmJRTzEzcytzc3VRT1lrNWVMK0x1RWszbmRYS01DYWg3K3RYNXUyajl5?=
 =?utf-8?B?QzEzbEdNZXB0bmExV1M0VUJPaDlsaHBWekxrNVFLbEdRK0toUjZVVG5MeFpM?=
 =?utf-8?B?TXRkbm1BOWhzeVIraHJIOC9HK3FqQUFTR3lSekgzUlYraFpsZytyYnNaN3dI?=
 =?utf-8?B?ek41RHBES0tXNCs4ejUxSmhLbjd6eXQ3Ym1BNHY1N3VwRXNIU1pPRXVRYTR5?=
 =?utf-8?B?NEsyZlhvbStldzVDOVhmKy9pZzNybFErNkc5S1hFQTNkUFB0OTlqckNCOEtR?=
 =?utf-8?B?YzViMm12NkNaQndScGdCeG1ZeE5rZUdaNkNZeFpvK2ZHSm90MkFVM2pHTmtN?=
 =?utf-8?B?NU9kVmRkRWZCNWhUTkpyU3AwbkRSVUQvWTkwN0M2YjdVMXVGWXpKY0l0THRW?=
 =?utf-8?B?dHE3ZEZrcS9KeGVXNlltMm44OWdZTkVYUEtMOVVYRHl6L1JTWm9YckRQM2Z1?=
 =?utf-8?B?M3pBdnc0L3VuK2toT2FCZlNVa0xxYkJGcVR4djY0UlF5c0xNTU1CZVF2U3h2?=
 =?utf-8?B?SGJwTU92NE9YS1c2aEUzOXRZbW5kY1JMTjNiUmhzV3gvT3lpVzFSaERzYUJl?=
 =?utf-8?B?akNhaEVIMHlwU1luYmlTNHRUM2VTRXByNGk4MkxyQ3dmNXoyWi9hNTZZVVBH?=
 =?utf-8?B?bVVHb1oyczJ0K0VDU1F3ZWJBQ2tuczB0MFRpOG96cHVVTytBNDQ3Z2lpYldv?=
 =?utf-8?B?Z1BRMURudjVPLzBVbStaM3p0VU04bHRsRHFNVDhEZXh3bC80RmdtWEtCbVVH?=
 =?utf-8?B?dWZUQ2ZTS1VudG5paTQ2NUxaaDF5Y0NzWURab3pCZTh1NmFTUHA5TXp2SWhI?=
 =?utf-8?B?QVltVzhhMDI2QmVFZzRqOWVhN1JUaVF1M3M5WFZWeGlra1BKRHIreXhLcjZF?=
 =?utf-8?B?Rzlubmd4cGtmVDRsQ2ZnT1dtTVF4WUJPY3ppUFNIL2RzWTdlOXJDZmVEaFlR?=
 =?utf-8?B?aEQ2QW04alVBeWQzbG1wRktVMk1aVVYreXVsOWd3UWgwNXY1aGk4UkRaaVB2?=
 =?utf-8?B?Y1ZsdlJkQUhGQmMyL3FlaTdjeEcrczJ6dklJZDZveTJhZFpmVkhNdytpOTQw?=
 =?utf-8?B?TDl1UGFYb0pGOERCOVJ6aitkZ1d6ZmNPLzJRdHRKblJQa0ZRRmdOd1YzcGZs?=
 =?utf-8?B?R2ROUUJPTXkwcXhnMElSaU84WG80US82TWs0cFI1dExtUUFJRXZzTkdOdFcz?=
 =?utf-8?B?Z3dmdzRPd1lpUGNxS2NqdTZKV1lqMzZCM0VsV3hmRVo3dUFnWTAxbHpTTTI5?=
 =?utf-8?B?MzRIclAxQjc2bzlRdE9lbkpKUm1IMlpxdmRBWktTMkIyYVVnTWk4amErYXYv?=
 =?utf-8?B?TTNOVEF5cFRJRm5FdUloUWlRWUU0VCtpN2NOZ3FFMVdXZzlXU21sS0s3OFFK?=
 =?utf-8?B?TkJrVXErWHA2aEVoS0VUek1XcXZvcXZlWXVBOWM0MUdPWlE3Vys5NjJBTThS?=
 =?utf-8?B?S012c1BTUTRlSnNVam9YaENHVy83ZTdKeXV0ZUNWM0ZDemtuZUxtcm94WStu?=
 =?utf-8?B?U1BoaHFRMTBGTzhBNi9sWmg0L01SL1Y2ZFZwUDBDWStXanRWcjJ4K09JUGs4?=
 =?utf-8?B?a0Uyd0RXSmVFRWdyOGhXa3ZNSmNhZzNuMmlPakppdFNQMnh1eGFFdjlJdk12?=
 =?utf-8?Q?74YOu/JawapOwt0VJHgO39uLv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u9r1oL6/saMrDPm1bspQgFtLnl7eoYmtAvcMGiotgc2nlMlxi4HJ4zD+gTN4coA8qMtHqSqhv9R3RF8Q2FzZLZiLK/1sdyMBYsFjz/vqrGPagFTDFdxwHwzAPkNpV8BxNjHyTLorFAifQKYh0e7Ua3RGAtcRJXg2jpSO31CrG8B4+Z1f/GeYMi8eHfX8w1VOFg2CjcDzBtmoK1EBR9SfoS1dF/l9DeaXzADgWGxBnsuI1TSpzCNO/iYfb9ZlpQuesIDDO1mQhIr9b4TT6xjToPM/8fMIWljoPKCGkUNVxhTemyNwXub+qqA4jYX4H99tbIWqitmks3IzOmq6onZ537f1FlRNq6Iy9jJrZT3lgfOmM5Vzp9wLfiqlo+U2B8hjWbGy7xjZejkPCHg8y5MGDaj2VJabRrpEFnOq1qadcegGdUrZKHvi1WD3NCijiqLCo/eM3Cwsd6F9dGm1IpvcqgFm4tTZfLII/p/lNNFNKzUKK4+qgRVWw9DzNSatbP4H+vGtQh7UugmiokJ88CeAFdUO+dzBybeb50q+CCvg5at37KXNMTBqoRBt6XilH7XqccCwDRIUzB7PjOjOmJV2t/pQrQqH39mBszxNNPGdK3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8722e455-80e0-4470-bd23-08dd17a3114d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 16:12:09.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ApjNMNJJOiAwMLc8/yjZk5Kzsd3u29G9GMIN2DpwMX5DTmGR8hyAU5r9RiKpvv8NZIN80R3tPQoZnKECe5WvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080134
X-Proofpoint-ORIG-GUID: QjkM8Chte9oeA552xQJZl5q0uniVdgEw
X-Proofpoint-GUID: QjkM8Chte9oeA552xQJZl5q0uniVdgEw

On 12/7/24 9:36 PM, Takeshi Nishimura wrote:
> On Sat, Dec 7, 2024 at 6:49 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 12/7/24 12:14 PM, Takeshi Nishimura wrote:
>>> On Fri, Dec 6, 2024 at 10:55 PM Roland Mainz <roland.mainz@nrubsig.org> wrote:
>>>>
>>>> Hi!
>>>>
>>>> ----
>>>>
>>>> Below (also attached as
>>>> "0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
>>>> https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
>>>> adds support for nfs://-URLs in mount.nfs4, as alternative to the
>>>> traditional hostname:/path+-o port=<tcp-port> notation.
>>>>
>>>> * Main advantages are:
>>>> - Single-line notation with the familiar URL syntax, which includes
>>>> hostname, path *AND* TCP port number (last one is a common generator
>>>> of *PAIN* with ISPs) in ONE string
>>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>>> Japanese, ...) characters, which is typically a big problem if you try
>>>> to transfer such mount point information across email/chat/clipboard
>>>> etc., which tends to mangle such characters to death (e.g.
>>>> transliteration, adding of ZWSP or just '?').
>>>
>>> - Server
>>> mkdir '/nfsroot11/アーカイブ'
>>> - Convert path at https://www.urlencoder.org/
>>> '/nfsroot11/アーカイブ' ---->
>>> '/nfsroot11/%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
>>> - Client
>>> mount.nfs -o rw
>>> 'nfs://133.1.138.101//nfsroot11//%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
>>> /mnt
>>>
>>> Works - (◕‿◕) - 素晴らしい
>>>
>>> @Roland Mainz Thank you!!
>>>
>>>> - URL parameters are supported, providing support for future extensions
>>>> * Notes:
>>>> - Similar support for nfs://-URLs exists in other NFSv4.*
>>>> implementations, including Illumos, Windows ms-nfs41-client,
>>>> sahlberg/libnfs, ...
>>>> - This is NOT about WebNFS, this is only to use an URL representation
>>>> to make the life of admins a LOT easier
>>>> - Only absolute paths are supported
>>>> - This feature will not be provided for NFSv3
>>>
>>> NFSv3 does not do Unicode, so this is not going to work anyway
>>
>> There are two purposes for adding an NFS URL mechanism to mount.nfs:
>> one is having a common way to express a server hostname and export
>> path; the other is to add support for percent escape.
>>
>> We still should consider NFS URLs on NFSv3 with the code points
>> that NFSv3 servers can support.
> 
> What "code points"? NFSv3 does not use UTF-8. NFSv2/v3 use sequences
> of bytes and a length, and the filename encoding is up to the client
> and server to set.

Despite the i18n discussion in the NFSv4 standards, that is essentially
what is implemented in Linux for all NFS versions.


> There is no protocol to figure that out, and the choices are plentiful, e.g.
> az_AZ.KOI8-C
> be_BY.CP1251
> bg_BG.CP1251
> bg_BG.KOI8-R
> fa_IR.ISIRI-3342
> he_IL.CP1255
> hi_IN.ISCII-DEV
> iu_CA.NUNACOM-8
> ja_JP.eucJP
> ja_JP.JIS7
> ja_JP.SJIS
> ka_GE.GEORGIAN-ACADEMY
> ka_GE.GEORGIAN-PS
> ko_KR.eucKR
> lo_LA.IBM-CP1133
> lo_LA.MULELAO-1
> mk_MK.CP1251
> ru_RU.CP1251
> ru_RU.KOI8-R
> ru_UA.CP1251
> ru_UA.KOI8-U
> ta_IN.TSCII-0
> tg_TJ.KOI8-C
> th_TH.TIS620
> tt_RU.KOI8-C
> tt_RU.TATAR-CYR
> uk_UA.CP1251
> uk_UA.KOI8-U
> ur_PK.CP1256
> vi_VN.TCVN
> vi_VN.VISCII
> yi_US.CP1255
> zh_CN.eucCN
> zh_CN.gb18030
> zh_CN.gb2312
> zh_CN.gbk
> zh_HK.big5
> zh_HK.big5hkscs
> zh_TW.big5
> zh_TW.eucTW
> ...
> 
> So, which one will you choose? You do have to do that manually, by
> hand, at mountall time you just don't have that info.
> 
> And it's even WORSE than you can imagine - many of the Asian encodings
> are INCOMPATIBLE (!!!) to Unicode, because the morons at the Unicode
> consortium did the cursed "Han unifications". This "unification" maps
> similar looking characters from different languages(!!) into a single
> Unicode code point.
> For CJV users it feels like forcing Americans to spell "New York" as
> "NEW Y卐RK", because of course uppercase and lowercase looks similar,
> and "O" can be substituted with the similar looking "卐". That's what
> the Unicode consortium did to my language.
> 
> So, you just lose data if you try to do a mapping of older GBK, JIS,
> ... encodings to Unicode. For filenames encoded in Unicode codepoints,
> e.g. a URL (which uses UTF-8) there is NO WAY BACK to GBK, JIS ...
> imagine sort of lossy JPEG compression for filenames, you never get
> the original back.
> 
> So forget that concept that URLs and NFSv3 will play along - that only
> works for English speaking users on a whiteboard, but not for Asian
> users in real life.

If there is a strong technical justification for not supporting NFSv3,
then it needs to have been spelled out in the patch description. It
wasn't. So I asked "why not NFSv3?"

I'm not sure other implementations of NFS make this careful distinction.
I don't see that in libnfs, for instance; their URLs appear to support
NFSv3.

We'll have to do some research.


> For NFSv4 it works, because the protocol uses - for better or worse -
> UTF-8 for everything, and fortunately doesn't even attempt to do case
> folding.
> So using an URL for NFSv4/4.1/4.2 is safe.


-- 
Chuck Lever

