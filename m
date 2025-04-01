Return-Path: <linux-nfs+bounces-10974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD5A77BE8
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1240A188C576
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843AB76C61;
	Tue,  1 Apr 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hoaISn/Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CaqrkUdl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10013FBB3;
	Tue,  1 Apr 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513597; cv=fail; b=jEA9zcPyijS8inCXrIxbObcigSPFkuAiPs3DAiqdP13k0yGccx83LDrmk4bG+r+9s33eNMQcBTCFfRAyDtZ9nNYdOUSMo2VBxStpLWSI/Svacz4nnCYoXbgNxNOZRwaYV0ZA7+QqviEkiFlpmL9XLlg322oJ9zRjV+vAQImbdXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513597; c=relaxed/simple;
	bh=pGJfSDrutTVL54Mt1p94Kqy9alzDuf3R4pjIscjiAns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neqOoyiULqCSuZNbOooKOnPp0zDwj2hLfujsVDr4R1EJok+M9zyRgJWCXlzf/bYtfzVS11UEAfg0PnYYbtl8LpzB0/58KtgtSecd9gwfUYIIiZ3B4DWy+Ad8kHPjXo3SLP/FWIsT9WV3y94O57Zw/8Y66OZQuzU9y5vNts5eb/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hoaISn/Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CaqrkUdl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531D9LEW011827;
	Tue, 1 Apr 2025 13:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8nt+4lPg6pzhpGxXzSiOukQ7zOScCKcNnb1JG7OVc0A=; b=
	hoaISn/Z5IUyVK5Wu6PDBoFchRRlL3DBeOAJ2uC2c6FzOdpanj9uXwg3pntyp7ly
	+noKvuo7pndHiKqWZVw6c8IJc63kjk+3BuNbUjO0wPnpofVPP0rqTaStteh1Pdj0
	fc2rm0RSwBC1jDneMKZgVO8YIR1Uyg3yo/nbs4b66UGmaKByxbvAVQhifIg+2b2P
	rcwwa4jnhjBw74dSJyxC560eVhaPzvAu5PxKCX8//XTH4MmZXx5Y1TpU5FcNQPre
	kzjmYNDblNQoFq5DVOWCGxDLSJRtL4uZxJ9dep74AmC4fzf/7mC0Q7iItRpSAem4
	agMbvWOjWHxCTvXWgjPWUQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c8746-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 13:19:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 531CuN9e010720;
	Tue, 1 Apr 2025 13:19:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7afdtf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 13:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGEa0NiEQkFrJw/rR8Hyp3fjH++2qGJDzm3CTo41jygarASKqpLi0RBl1YYLh4UCIpD3NpnP+RibZI6mr7C6Ol1b/aOCPLNS3abHZsayrfq2+q6cvk5wJeQQ+J9WA2fblnJg8fKRI5RNqhx5oJo9XZkV0Mx1i2ShpFZvSAbZwY5O3jclerKqZJTIU9RhvMT+i9KJnelu3XcPiip92Cog9XYi4OZB6E4XqBORKNmruy9+UWsDa0eLJRqg25fk4S3Re7oOvOFrsE/nflxdPBF7FzBo1+egbknhAGOuDXIBd8Tvd/0S3eU4AxailFav/3XuMg0hbrXlx8TdXfnyquQJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nt+4lPg6pzhpGxXzSiOukQ7zOScCKcNnb1JG7OVc0A=;
 b=mNoLizAiLG5V3OR0KT+ELUCk668QmRghcjH4msahmu1YrOMIZ+uLvOUPqZHWyeARwCTxJSAeO96N4mOlJxn6v0+dv/5zVpPED+v1EhAf3aEUh/7d01fdCzjdqP/UYDIHhU10NqyXaCe3ydJi915A5VfImy8Msg3pNPUz9WFFyHAcy8cWUcO/PxIozal3XVhavk/cJ0JO0xlXJD+a2id3jHXAJ13KiKTFBTtQlZD7z+nw/jkOTPjbs5WqyOWINyZ3TJQXXZ35XwmkQohzpESxbJ6ntacShLkXSZR7mygVWzYVTpnjgfzn5LYXMSQY/qg+jFyWynuD34rbt6si5Nc++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nt+4lPg6pzhpGxXzSiOukQ7zOScCKcNnb1JG7OVc0A=;
 b=CaqrkUdlTvkFHP645iUN+dpHIFDOop6oh5b+X/khwQRsa4UrVoqotH1Bey/QiIhVcsRVMRJNh/p4fJZzK+gEIA5pt4FF1AC7RvfrhKBPkurn9CREdjDuSCTNYNtJ/2/N/CEQ7QWcuNZp2BjwlQmY7y2uoWmc23NuY/AlWGGaSQ0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by LV8PR10MB7870.namprd10.prod.outlook.com (2603:10b6:408:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 13:19:49 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8583.041; Tue, 1 Apr 2025
 13:19:49 +0000
Message-ID: <4bdc7703-c098-493e-9492-c7a9d6c02f72@oracle.com>
Date: Tue, 1 Apr 2025 09:19:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [for v6.12 LTS] nfsd: fix legacy client tracking intialization
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <e51834a5-2f11-4783-9065-e19a150283b2@oracle.com>
 <2025040119-avoid-roast-01ca@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025040119-avoid-roast-01ca@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::10) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|LV8PR10MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: e39f7bf4-8570-4b43-bfbe-08dd711fe142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0Zvc0VGK3NIQXZxWloxL3JoVlc3V2U5WVF3RmZieWNDdUg3SWJUeGs3bnJZ?=
 =?utf-8?B?SkVudEI2RW9ZaGlZUTJUV053YTc4ckVSUFpBMjJBUFEwdXc3ZmZ3b2NGQWwx?=
 =?utf-8?B?L2Nkem9TYlFlZnR1UHRNajl6ZzAzbnpMMFVYWGUwT08zRmt5RVVPUGxQaERM?=
 =?utf-8?B?ek1YeGJlY2N4b1AvVlJ1cWw4bkNxVTJPQjRoWld0TUcrTDhha1doUzVrME1l?=
 =?utf-8?B?VGlvbWlWd1pkRmRRL3BORVJkQUlrQU4wYVlLeFBMbUM5RFlMUWxLQUxpUjJt?=
 =?utf-8?B?Y2pUblM5TlRmYVVsL2Vxb0dMb0QzTkVZR3VvS1pOa0x0VGo0WW5UZ3dYamtB?=
 =?utf-8?B?dEJpTzE1R2diU1BCdS8waG9YMUFOUHo0ajVNOElzRm5wZXhUTVNSdzFxVWNI?=
 =?utf-8?B?K3djemdKdkRUOXFwVmNDSlVTbkpSY0JuWmlUWC9KSGkzQ280UjIxTnpUS1N2?=
 =?utf-8?B?akwwMmU0RmUremlWS2VhSWpMdXI1dzUwZm5FK2ZaZ3dKbHV6NmgwYzhPdDlo?=
 =?utf-8?B?SkNGQjdhUUVLQmpYai9meGg0dVF6Vy92a3BPbnFxays1VmpMN2VQdnRHemZp?=
 =?utf-8?B?WDRjR2ZCSkYwNG03TkdvY0ZmM2daUnRZZUVQZ25QOEhpSlJTdlZMcWNTT0Js?=
 =?utf-8?B?ODRuZmxvY1Q0blZWUXVITjUwL1grcnVndzcwOHBuamFYOSszb2hIY05HVUhC?=
 =?utf-8?B?bktUR1ZucWw1ZXV0eWc4K0phQ0c0OXpmZmZJOGp5SlowQXJmNGd6YzFSbGVr?=
 =?utf-8?B?M2NIME96Ty82R1YxVEZkdTdzM3k3S0dmQ3lKTG9PSHdWY2tBdkJRTmI4ZW92?=
 =?utf-8?B?aUYzZFlYaFk1dDMrR0ttUHh4TStZSTVJbk5OTFhaNG1jUVlpK1YxakFJdWxZ?=
 =?utf-8?B?OE1XTWg0aUFMUzEyd2NVZWdFaXRqOVMwc1RMbVN1emEwRWVxa3ZSa2RtOEhQ?=
 =?utf-8?B?SnhvUFJvWnBScUh6eVNzc0hXNjhsVVIrcEZXNEZsNlVuNkNJT2thajFMcEFO?=
 =?utf-8?B?bjg2Y2lOazYzUHB1ZkIwZkFjdWhGOXVhcGsvc0VHZWU5Y2xMeHNISGhTZ2U1?=
 =?utf-8?B?NG9zUUhOR2pyaHhRY0RYY1NyVTdPWEhoZGc3bi9YSmpNS0Q2SzJkcTJ0VVEy?=
 =?utf-8?B?WXhjUHhuRlZlSWRhOFVkNDM4QVpzRXI3RkRxY0FFR3pWcXhSTk0rZUQxcXFa?=
 =?utf-8?B?a3FQN1pwNGlERy8xM0lrRHUyMU5vQXlQSGlVWW1rTFN6bVgyeXdZNE1PZFda?=
 =?utf-8?B?K0hvUkFJSDlGbG1QVkVzeDgrTWxsWFJCeG9obUNpbmNKRkltdXd2YXFtUnV4?=
 =?utf-8?B?clhRMS9HUnNuSm1JbUdKTU4rV3NraGk3WW5NYlJLWk9aQ1FZUXJkbHcyOWls?=
 =?utf-8?B?T1pNa2h5Ymc0QUtONTUwTGFlUzMxWTB6NGliZTNWL1ZiUUs2S29KTHFTaENj?=
 =?utf-8?B?dndWNG9YdUIwNnExSFJQVVRGYUdYd3VQS20zbk9BdTQ4MTJrc0pXTnpMVjVs?=
 =?utf-8?B?YzA4L0Q4cW1XQWRLRlhBWGIrUnJwbGFycSsrZXIra2dKdjVEQmcxeVpzZU41?=
 =?utf-8?B?ZTIzc1lpek5uT0RJZ0hzY2czMUR2bzVKMk93ZHhUOHVhQ05tcURmVHNtWVp1?=
 =?utf-8?B?eW1vbzk0VkExY3NyOUI3V3JCYTF1R1dXVDFOWFN1R3NyVk1Tckwvb0dDNEha?=
 =?utf-8?B?NmNsNG9DRlZMdFhId3NTSTJvdXJ2dVduaGVuaDFlUmk5MTJ2WFcyTmdBcE9p?=
 =?utf-8?B?VnVsT21wSlZPT2hjTTJwUW5vU3RaZzcyUFpja1lydzVlbDFuU1psSGdWTmJ6?=
 =?utf-8?B?ZyttNXF3elRGVG94MWxyVE1ka2hmbGRSK3d2aHFlVGh4V1MzRi9xaWF3RVdr?=
 =?utf-8?B?RnY1cDNlMDZtWEpDQVQvNGRGbGYweFNHWkc3MlNGd0JrS0IxcENkTlE4RUNV?=
 =?utf-8?Q?DQzEZY6odLA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXpxY25MNndYRTZCby9xWXFiMFdiUWxyUjZFVjdZaU9xTWN4UU8xLysyQVBa?=
 =?utf-8?B?RnlvQVFaQytDd21TWHZYNWdaZllaOUU2dWZpQ2FrZ0xCUEVlZ0UxaFBvNkRo?=
 =?utf-8?B?UjdJdzUrN1ZNd3BaRHRhS3hxekRaWFhqM0d1VXlBMVErSE5YVGs0Y3pEU28y?=
 =?utf-8?B?RnVBamxEbHBaQ1AwWTZoU2kweVR4OTBTSGNYZXdaYU01d0M3S0ltekNPNkky?=
 =?utf-8?B?N3k0cmg3Zlh2SitVZUY1RTkwTEVUM0tsYnh5VkhTSmU0bFJIdCt5NFNtQjhm?=
 =?utf-8?B?YkJvWWVwK3RqL0xTS1NjSFRtRFlua241NnVxMHdldmFjZXMxZSt0UWpJUWl3?=
 =?utf-8?B?M0hnNzE5dzE5bklnK0N0Wk5nWStlTzlrcUZzb002ajdtdWFWUDZhMWZXNkF0?=
 =?utf-8?B?VE1jNndUMmxHLzR2Vkl0RVRLVS9JblE1c2hwenloVGhJTWtQeDc4b0tBellC?=
 =?utf-8?B?MEtMQUY2d3BGY0dxckpVZTRsTUNMa05KdGxWTEpoVTI4QmdCTjJFNTlDMG5M?=
 =?utf-8?B?b0x2NHFhQzBGcWdtclZQejhRenJ3UU42dGhET1dXaDJyUXhNeU5zenBPdU9h?=
 =?utf-8?B?RXMzdWVZdFBiMVB3NjZPaytab3VySzdERVJ5NDkyT2xZN2d3Vnh1dXhGeTBu?=
 =?utf-8?B?Q3dRSUY0K1J6THpjOUJ6Wll4QTZwSk96a0tPQktjVzdJaDNDcGZUeVZZaDZi?=
 =?utf-8?B?TWpGaXBJcG5kOHFxbVpwbDNQeUZVeGNFUVF5aUZ3ZGJ1SEtxY0VPaFFFU3Iz?=
 =?utf-8?B?TUZBQkUzeEhNelR2ZUJHbVZmcHJJcG56TzNUVzh6RkNrRFJid1VrcFFZU0h5?=
 =?utf-8?B?T1QwWGROME4yMS9HdFBGa3czUmkvZDRkL094bkp6QjBncE82NXJNdWhzRWJs?=
 =?utf-8?B?S1hlSVRweVE4dSt5a3kvcG1GblVKMFpyMnlMUnhNbkh0Z2lOTjMwODlBUGRS?=
 =?utf-8?B?bVRkZ09WTWFjQTdWa0dQSGx0RGtHMmloL2JISXljZjk3d0xwbVV5Vi9tdVRP?=
 =?utf-8?B?YlRUTTNPSFdpaHlmaUpTM1Erd2VzUzB1VlVmdFU3dDQxbTM4czJ5VjlocjI4?=
 =?utf-8?B?bUF3UFRRbTNBSlpteGM0M3ZDL0V0MHNncGVzMG9nUjlGN0RHVTUxeURqVzVl?=
 =?utf-8?B?c2h3OHZVQUpCZlk5V1Nnd0czUWR1Nnh0NmJJZE8yZ01kNzFGNUs1eGRVeS9w?=
 =?utf-8?B?QThaS2psZ3drMGthVWtoTzNqOVVTVldFN0lTNWZkVjZyQ1NFd3IrNmpYejR5?=
 =?utf-8?B?NldsVWZ5TG82bWNlYWpsSTBHU0p1UlplTU0vTjU0OEVrL2IyN3JlYjNxUUxQ?=
 =?utf-8?B?SEw2N0F6RXpTRjE1L1crT0E1alBSeTFhbU44T09sa212Smk2VXBuVEw4WG1q?=
 =?utf-8?B?Y2IxZUJlTkZEY0ljY3dseDUyWUZycVJPZDRUTS8wb1FleWlXS0xrSGQ3T28w?=
 =?utf-8?B?QUhDcSs4YWVGZjlYemZ2d1dMemNlNTVvaTBFNkt2T0hNUXl2aHVRNDZWRW4w?=
 =?utf-8?B?bW8rdGcxTlNPaXNjc0xoK1dMQXZUYzZNb2k0bEZyMVZKVEtjL3ZiQ1NEOEM3?=
 =?utf-8?B?V3N4aURzYm14WllJdWV6MjdEVFYvTWNqR3FQS2FFZ0o3TDJibnB6WWJoV0hW?=
 =?utf-8?B?Q2xPR1FBd3Q0ZHdlemdvVElsK1pDMTh1UmhGMzJpdDNkMUx6TmZKWncvdmRO?=
 =?utf-8?B?R0xveGpWMUFENExINVJjZnhHaCtKT1YzMWZFQndqVUFsL0lOQ2JBUERMNzAw?=
 =?utf-8?B?dFhPOW5ROU1XNUxjalc0NVBaaU9GQWNKYVFHZDZsTTZjaGRkVUt3MUNsOXJ5?=
 =?utf-8?B?TDVQUEpXMW13T3h1Sm8wbVZxSHptYUVtK3NOcElIQ0hHbTdnTzVjSlpzRkZM?=
 =?utf-8?B?YTM2Qk1mMFJiNEJEMnpjdExtaFdnb1h5Q0JuQVRiaFZHTytvLzBEOC92OGVW?=
 =?utf-8?B?eTQ3OXUxNHZWWXkwbUZGb0JTd3AzdUhRR1JzZ1AyY3pBZko1ZVNDdjVteklB?=
 =?utf-8?B?bk1XWTVEZmZyb1dmTkJ3TERwUSt1SDhCVzJ0MWlKMTBQWTBwS2JDQVFXYWVr?=
 =?utf-8?B?OU1BUXB6MFJmR21rUFV4UUtRSzViL3UrVWtlaGVVVmJBaEkrakRudkxIWURn?=
 =?utf-8?Q?D4FEx7342QzxrMPN244Hv6swz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y3lQpUYECoueLFYuzpwVZ1xZ9OY3t7nELzdICPyFpgBn+hp0rMro79XeqK4k9E0g+ad5GTBuDenqQ71lo9DX/CxVuYGB7A6IzcdrsdnssQv8z+ukxT+nEdFnU5BvbIRHQq/GG5yNLm++nZAXJEizOcZI+wwAJRE6rE3B0b/Vu3RZFXuyfp2xvKFo0SlTHt9yUSz1c1et4T8sytiAqXfovH8zUAcXrKVeP1n3OAlc/rPWw8QmlQQoh5IK5RFVcFKEnUcS1PpdqevpTi6QTp3RnZwj4F4EpoplzSChisN5mr5foIhj0D0/XoL+Q98kAlIaqgG4UnF/WI9zjFeiEoFO4zRKDpX5X0Dy7j3gx8MsosQyhh/KTM0gvVgQbLHKCkoWWW8Pw/M/GqV4/XCkmhm1bdVCpRGIbLavy5Z+0LAQ7sXFQVVYQI7B4Nq8yLF0u3M1UdTiOpF3vo6my7ria/Cs7LZQZshwKmVP3TPvuXBVbZw9HqQ23eA2DyPOB+dAp6oTtOHEP/wH5WhsEAGSaUa315Dwa6yhBNEqRpK06voOAXKC/8z8pEl1h+XJxb+l8LyBcImlk7SJiKunJTbom6Zu6HTGCf9xD1XLHRoKCKWop6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39f7bf4-8570-4b43-bfbe-08dd711fe142
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 13:19:49.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2qabg3NwYo6fVWVV1GeN6z8vKllmr21I+exeMLOBd66aV1VHANYa9BX8DMB/u5/cEcnDdX2a7jgMeRqlixTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504010082
X-Proofpoint-GUID: VZvYerqIEIyz1PMJM0kiVo5d0owFvYNd
X-Proofpoint-ORIG-GUID: VZvYerqIEIyz1PMJM0kiVo5d0owFvYNd

On 4/1/25 6:38 AM, Greg KH wrote:
> On Tue, Mar 25, 2025 at 09:21:10AM -0400, Chuck Lever wrote:
>> Hi -
>>
>> Commit de71d4e211ed ("nfsd: fix legacy client tracking initialization")
>> should have included a "Cc: stable" tag. Please include it in the next
>> release of v6.12 LTS.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=219911
>>
> 
> Also added it to 6.13.y as you don't want someone upgrading and having
> bugs.

Yes of course. I misremembered that it was already in v6.13.

-- 
Chuck Lever

