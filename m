Return-Path: <linux-nfs+bounces-11621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A22AB19DA
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C684B1C47C5E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9023644F;
	Fri,  9 May 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZEfkUodb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BmpoTv66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D42233704
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806508; cv=fail; b=pp3a7OO6QKvYOhy6ryRpijD0f8fph6lW8/A4orsZk29K+L8SRH1DFDN6mNUK6WpMokz5HhR8wyNnjfKRbD8ASz98nkPptbB+YYujP2pGbz1U8W9Lc4liXbm9aAAJ6eT/DN+bAHdKgQg5ljEtz+RZ5bN8D5vbCVT+w+VtD68C6SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806508; c=relaxed/simple;
	bh=SKJFxkF+Dj4vUhZE/ud+Ls/lhWQK5eM3C4cAoJZciV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ravGMH2LokB44jQWP58Jjyk5n+dA1BM7yFIvRGjcTrw63Xmu9M61yAfZlh6IFrnTdHgQN0LGZkCaFbWKS5Ah57tCXNyEZptaT5QDhvseGQvSu2034vxZ7XHC5BizwcZL9P46Z423O6EPV4lSx214QqvM6EYQdlQ8h0vUbE51cxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZEfkUodb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BmpoTv66; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549FCZ6g001260;
	Fri, 9 May 2025 16:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IR9LFgrlmpWJxH0xASgUAJuWuT+Pid4CPUlIwiwHG9s=; b=
	ZEfkUodbpoJL8bwtAHEsR3pHT1bLYDmMYGF98p8Kdj1MCu/DBr4J/IjiFqQN4u3Z
	RQF6d3mJHhdJ6LlgmWgxRjyjKvvtyerEBFVxN6CmG+rgQPtROQ+8FAjTo0lBtCs0
	z45TQkjOHpCXAwvNCbbJF8U486c8Us3rFBlLcLY/uDIy17pMj3IZjRNGmocDjKhQ
	fChKm6+Ppzt4Utf+WURkIWnUc09YAv9CqHSQBc4WGmSOL3dJiRR+Jj9mfWtQzKq5
	LDnBtUAx157dvxfTnGqmTU7lh89NVMk+EqynbSPJDcmQJaur0umCiImClfr3ah2S
	d+/DZtjPAt9O+qtst3ONkw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hm4yr3v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 16:01:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549G1EMe032283;
	Fri, 9 May 2025 16:01:41 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kkd07f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 16:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr88KZ7dOEvuYYe8TBSq88I9lctUsqAgZu3kSaKBQp1sYqO7/CKJ4l6L+VDRNqcf+bK2ljAboCNeSbvvsaDrZ72GnBUA7gNZyejXXc6ckIPXrEUxLqgrbTgbEphVGauiSeJ539LedFEiadblnMEcExeGSQHVYB00qdME9Guhiv4lQEYU2xgcJJ5qKOWrfflZOkyrkZ3n8SM4+kfRKpqbkGqiMEQNn5o1F3N7dy+s9rArWJaJWZQK17xEjkRlMECF/yOHAt65bqhepG5XiE3+Y0durub0j5hi7OAhxUpNpu1VJ8nEXnffPhDwf+5Ma7Jj7xHl9Gn9/Hq3UuvG0jUyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR9LFgrlmpWJxH0xASgUAJuWuT+Pid4CPUlIwiwHG9s=;
 b=fxGF5r5jb3+3k/Sh7F87g8DLhz15hY3d4+mCTkHAt5/ed9dzaSr8U3cOMKCeRmNZm6gHU6O1YqVwrp8QycAz10v5hdVHJ3AsQ1yJZP51Wss2WaiCjr+4TQhi9GfLvocZaOwmINqxSU8TOpenxahjHja+jjK5eITLYBk7MIlKCPeEb9XWffFmlwv9gQiaLqRIMzQUWBKQd3htfjN3aCvT16vQz28T5+IT/DLTuSCx1ZAhUdC3XkvvHsKSp/kMeZg+ZN6xJ6iM6JguSLo+i4r0A8fAqOvzemqDmtCX4cBHwG5Yury2PZkAsJ3cgb7qaYpiiA37ZzpatFRDgrih/Wd5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR9LFgrlmpWJxH0xASgUAJuWuT+Pid4CPUlIwiwHG9s=;
 b=BmpoTv66/WUdNyNT/j/qo+fKsPz5t3hwvxfRx4a0bygpAJFps/rhuv2RHG/uDfs/TfeQdcKNs/J1T4YS8nNNDYBe0PCcHdLFTWp1pLG/05BrUHYzZ9GgJLHQ9FNn9tgNs0E2/T1DYx1UWQ+J0Fa8m+Y+jd3IID1N9HmyHFoPjo0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 16:01:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 16:01:21 +0000
Message-ID: <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
Date: Fri, 9 May 2025 12:01:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
To: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        paulmck@kernel.org
References: <20250509004852.3272120-1-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250509004852.3272120-1-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:610:74::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: d49f1705-ff9b-4902-4deb-08dd8f12bdce
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WXB4Q2xidGJKQUhWclZLbUZ0ZlU4aU9xdVAyMlAzOTY0TFFKOFNvR2E2eDlD?=
 =?utf-8?B?ZFBRY3g2SCtxQ0EwRCtxMWdTY0dRNS8rV0F3UEFTNHB2N3dscTJoSFA4Skht?=
 =?utf-8?B?NC9oVEN0bWNzalFWV000cnpEeUJOTnhGcEtiYjR0UTFDVDhnOC9NZ1RmNSt4?=
 =?utf-8?B?R1JaWVpzREJOMGtGY0prZyt2TkJMWFdNWjhVWVlldVpxTGdJY2s1S0RGYXpi?=
 =?utf-8?B?SGlKTmo4Q2JsbVcxV0dIcnBiZlJOSDVDWXdNZjlHVjIvb1UxREZ2YmE2cEQx?=
 =?utf-8?B?cnVOTE5haU9qdElFYTdUZCt0cjQ1d21EaTBocGlWbXBsUTFTc3ZtS2tWT1Ro?=
 =?utf-8?B?blB1eEpudjF1dEdud0ViWU4rWlQrM3A1N0Izcm5CV0UxVGJpbVlPMS9hdjE2?=
 =?utf-8?B?Z1NwWnBOblFqaTVFQmZDWFNXbkhnR3dSbTU4OUpjT0FHMnJYUnJxTDdZbUJI?=
 =?utf-8?B?QnRaekVXOFA3V0hrb0R5a252RmEyV0VJMmg3RnRHbHVVVUpicDRqK1BCV1Ez?=
 =?utf-8?B?VGFPU0JQQjBVc0V2VXY4K3lxNEgveFNySmRrelpJSHJsaDVWNnBaaEpCRldt?=
 =?utf-8?B?LzEzNnlzREg4cFhzVXp1dHBYQU80VG90bzFDalRiWjBXS1F6STNVYitFVGhs?=
 =?utf-8?B?N1FrcTRTdjdjV2V5TFZwQjdrWnc2ZG9WTVBVdzRGaWhsZlNiVklaU0Z2aW1m?=
 =?utf-8?B?dEVNTExGWUdiUXZYaGdqTG1ETmg2OVA3QXczREpWWE1LNUtPMFZwL1lqekph?=
 =?utf-8?B?R1hrWWFJaG0vR1FaaU5NMHlVb0REOERkV1NmU0JvYWcrNFM5WUM2aWRhOFJm?=
 =?utf-8?B?SDNpTlFTR3E1QS94THFBditsK3lXOXFSbHY1eUdSTU9ScE5uck0wZDdLb3Ay?=
 =?utf-8?B?NnY1clN4S0dHT1VHYUQvMVlCckU2VTdvbWxWOE82ZUpHc0dtQ1E4UUdRZU9r?=
 =?utf-8?B?TVNWckttdzNUNW1yeDJFU1VFSGtDUmIvQTdZQjhIZisxQmZET1Nkdy8xb0o2?=
 =?utf-8?B?RDQzZm9lV1FOaUQ3ajQyR09JOFZ3c0ZiMnNmZDhaUEtvdXBNeWZFa1czRk5k?=
 =?utf-8?B?STliN3lEdndiTEZSZXpYYkJPSWxGSE1aNEhLUTVmMnlJbzUxMG8rYjh4MTh6?=
 =?utf-8?B?eERaRU42KzhVcXVMaDBDVzFsVnBGNkplN0NvT09KaC9uVXBQMk1KOVJveGJ4?=
 =?utf-8?B?NTllTWI4VjJxbTRTNmI3eEJJTVgwQWpMaktpai9HZnNOQmdMeEJMZDNGcFFu?=
 =?utf-8?B?MVJxbHBqZFdOTjVXTytuR0lZTzI4Z1FBUURxUmZrbll6amJVSks4U3BERGRG?=
 =?utf-8?B?RmloMFdsSHFuR3VQakkxZ2JkTURSSTBzcEdCNnEwNTYvRGswYS85MFlwcWVE?=
 =?utf-8?B?ZzBkSnNxSnJHdU1xRWViNUdNeW1UWW9MU2FQZFhPd0xaNFVhV0MrTHVVaHVI?=
 =?utf-8?B?TE5WU1RQNEN6TlFFNmF3b29YeFFpeFVheVBYdzY1cDBaczl3RmJ4cUF0c3pB?=
 =?utf-8?B?cmZJRDFnbUZ1Qk1qRHFTZlVmM3BicFJvdkdQMnZzaDkweUorUlRVT1FIeVB3?=
 =?utf-8?B?bFlvWG1OTkxCbWZXRmpFWjB0U2pwZXVBTGd6RGlHb1ZMYzVJSUxXRGVYaGxF?=
 =?utf-8?B?RjNtak1PMWFCd29jZ0FzZ2lraWoySlB0OGVsL1hwRy9yeEFIVTZxTmRDV0JX?=
 =?utf-8?B?UEZYUGdmUjVBbjJsYWFqVkxhaE00VGdJTXhBNjFBdXRMNWV0UWZQQmZoYUxJ?=
 =?utf-8?B?cFp4N0dxQkVaRHhwNHZkMXNlaHRKVWk3cHZEU3EwTjNYa1N6SngvbkFHZHNJ?=
 =?utf-8?B?NUlqK2ptWmRRN25qSExKWGxiWnlFTGRwMUFEZnJxZmxKajJLS2FLaWFrdlU1?=
 =?utf-8?B?WjRWOVJkSFRnRkR6ZGgvN29qRGNac2pDdzRUOFlvclFYWXhub3lQNlpxaFF6?=
 =?utf-8?Q?0uQO1jOK8AE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MWx2eXI3eFBFQUh6UTB2bmlkcUVjMEI0VFdENlhnVzZPZk5yOHN2SFdYd3JU?=
 =?utf-8?B?WG9Fc0Y2L3k2QjRDZGlsK2tpaVAxd0hkeVh2N3JDcERGM3VvNSt3ZXdSdlBm?=
 =?utf-8?B?cGhwTVl5RzhZL3VRRmIyeTNRWWFkd2xtZ2o3ZWh3UHBBdmdQMUhqQzlaWU83?=
 =?utf-8?B?SFhTUmpwWGNBM1c5VXlTRnFUdlJyUFZ6RlNJREdJOVVKcmZ3YTU5L0pyV1pM?=
 =?utf-8?B?UCtKd3V4T2xNdjU3QkJzYk5TUUNINUpkVmVPb0hHdmoxN0FXVU92Vi8yY0k1?=
 =?utf-8?B?Tmp4ZFk5TXBjcG5sc3pSczd1dzFBRTRuZ0I1RFQ1a1hhOGRaYWRCSTFENDZo?=
 =?utf-8?B?WTkzKzgxSkFBUWRaTlVhZzQrUThLVjRJa2xRUG9VT1pob3QrSzhSNkRZQXlh?=
 =?utf-8?B?TEZabEZUWGxHU042bFFiZ01CSm5GSnVzcTMzUzI5S3FjZXNidTY3YlVETisr?=
 =?utf-8?B?em1UYkRia2RSSWJzOVdaS0N2SGx3YzBvS2NHcGk5Q2xlT0dGLzM5TGtBN2NR?=
 =?utf-8?B?TlBYTnFrRTlyTUQwR0N2THp2Qmk5Wm51L1lCQkQ1OXdxNVlsS1dGUFVidExv?=
 =?utf-8?B?WU41SFJBdklvajZMTXYwRmFhU2NUWm5nRHJKS3pmSUlaU2J2R0VLcDZETCtT?=
 =?utf-8?B?RW4zMms5MGhjNFVES2ozOXJRTGdqb3FQR2o3SW4wdGdUZWZBU2xsbTNKWEhF?=
 =?utf-8?B?TFYzV25BT283S3FiaEtPZWNtZHRNWXNzQXoraUtxZlN0MFBPaXRWSElOU215?=
 =?utf-8?B?OEV5VUg5b3JHUURqdjdKKzJtOUJudmxzUVFWajV2eDJ2cDJuT051VzJtbXZt?=
 =?utf-8?B?ZXFyTWdPQlh0OGtyMXZnZU93a3FaY3Vmd2VmckZYUnRWTlp2SDdXR3k2em1x?=
 =?utf-8?B?R0hzUGQzclN0M2ticTJiVC8zc1BzTHlycFFjdnc4SUJqajlpYTdRemkxbEdh?=
 =?utf-8?B?dTQ2U2dKZk9DV2dWd0xMV2hhMllYaFptaWhCWHBtaUE3M2ZjbGlXeHlhVkcw?=
 =?utf-8?B?UkZlZ05RVVpvQ0sxMmtOUUFHVVE0cTdqQjVKR2FReWJmWSthYmRGMTZCMlor?=
 =?utf-8?B?RU45a1pUUDVVK01rbDVDU0NpajNxR3dnSCtKTUNrcmVxek9qSmg3OTBxM2Jh?=
 =?utf-8?B?Qjg4YTFTdHJ6emZycEJtLy9hVFl4amtIUjhuSERMU1JMMlY2RysvTFZEUDhP?=
 =?utf-8?B?NTY0Nys5akxDRjExMWpjbENaTVE0KzUxWGRyOXFRT2VVTkhrWG12VnM0RU1m?=
 =?utf-8?B?ZlVaQlJaek4xM1p0VXpMcHFrb080akg5akh4TjluOWVCZ3d2N2NJOEQwT0RJ?=
 =?utf-8?B?YzRyWlpOWjZaNkNIK29yS1BrbmIyV0VwWHZxTjM3MDdrZlkrOC9VYlF3dDFo?=
 =?utf-8?B?d2NzbnpDYmhYM2F2ajVKdjc3cCtqK05XNnFqekR0dlZnSFlRYUxDTnIzUjhE?=
 =?utf-8?B?bFNIVytzYnZOVXhuUzBMa0xmSnNONFJ2ZWlSWHJsampTRDR1MXRKYWZnbFVJ?=
 =?utf-8?B?MUxnRzM1dHRiK1YyT3VwUFFtZTV3MzdPRlVkVVk5Y2FsRnNBVHJJcVZRTEVo?=
 =?utf-8?B?M1RBZEh5NW42TTZ6amRocGI5bjR6aEdVTS94NDNXVXd5Zk56Yi9DUW9UdGpT?=
 =?utf-8?B?UTIzQVptcDRvQklSaXYydDNwTEdrUHlOaGNUYmV5ZUp5cmo5Q0RvKzBmMHRG?=
 =?utf-8?B?YW52TTVNVlV2ZFFvbjVCdHFqWmFhV0t5eHZpa0pYUjNpT2U0N2pLcHp5TkMx?=
 =?utf-8?B?b0RBWnArR0NBbWE5SUttU1JZMmZwRUpoeTE1SXBpL1R5akQ4K0JkWVpaUTZV?=
 =?utf-8?B?bFNzQy9vMVk5cjRZZ3BaeWJWem5oSDdqdURxQVNOL3E4UjdjVlBqRUdxcnFK?=
 =?utf-8?B?VXViMWR3enJnVE5vM0tVUnJCT3hqeStHNldBdXFtWE1qQWVBcm9ZbEdDa2ov?=
 =?utf-8?B?dDV6d2lONVJxcGQ4blc5dDVLZE1kOG5BY3k5VDBCT2tVODRLVHVGZm9qVUlr?=
 =?utf-8?B?MkJQWkIyVWdZcUM1YU9KTWVGMm9UZ0JiKzJHemVLRThsMDRwRnBQZGdkU3pM?=
 =?utf-8?B?YVNnblFlY2ErWCtkVGIwNnkrK2p5c0l4bmY5dlJqaVljdHV4bGdwWmxyZy9P?=
 =?utf-8?Q?IfEM99IcWb/cHtT4l+t24CDZc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mhUbf6CnvrOBFwT/tY3gHu4on23U4C4BjZJdT4wdfpMUuC6Qu8n3w1nLjByPduhvGbearBcHuHsla4zisjvmZZ2KveQDoDVO/FF8DoP6OB89wewepTsoknD5pwQ7iNWX0vDHbdcituiUmNIIp33UDYN7nfK8shDG+MpHve0QarxhzzuvEaNCvG45DRjuFWoOc0PqORbIe+JFet3H0PdpV89D/Ba5H0H8hM4FZpbQTTygogh09pD+mgjWvtkIJXSuqbyg/9IhHKEMo0n0ZwePXZ+X4mJ2aG4ks8MbqFZcm/od1tHnEJGDACuHtTjNkhzMeDWDuRf5wtcvz0xiG7d/5crulKBerCK982yUzS9i5OW2h7yFzpFIAWjN5f+8DZSyffBzsGadzN6x7G1L34b8oMGqoFbOjVyUIHxCDV7xOlBhh+J+vOHFrjlf7dpxRwH5pW2uUNT4OW0SmPocB2KrZRiVXLWEXId+X8phak5aMZRyITwCoDTJ8LVoGH0ekEbibd702jIkqH1d+UPUIVeChGyhQ/69ryw16A+9qjyxiru/4E10LbxXJ8Q8FU1r5VV9mza4w6iMDp4WDtgqm6fxQ3NnfNE5sGgJUkdCkMo3Sv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49f1705-ff9b-4902-4deb-08dd8f12bdce
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:01:21.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5BdbGkZqK9rmY0XeQyzKdmFwcf3SASAX/UCnzH/aNCixnwKl6LzhOLvoHS7kNPeezRYCuLopOJ3lCwzm8mO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090157
X-Proofpoint-GUID: OUKTlJZ5nXBSNCWNN764PI_Fxr294dV9
X-Authority-Analysis: v=2.4 cv=H8bbw/Yi c=1 sm=1 tr=0 ts=681e26e6 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=h3mv4K3hHkBpZKE0jPkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: OUKTlJZ5nXBSNCWNN764PI_Fxr294dV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1OCBTYWx0ZWRfX9z6LJiAJ8sJ5 TatQKs+vC673LKpJ8fXhf/bAHW44UWG4Qsf3QVaUyobfIrVfy87f3wcMNDFq5mhheLYsNt/GgU8 xAnUwibUZP7yJ9nQimTZbIOgGkVYngDdpmaKQcvH9dqxeamkPtFEbVF5diiB5OFDAxvgBWcGdBX
 oP+ZGonLVclbPuTr4zwq9609WN7ggOPMKwp5VJFUhGg8pEt/11T/qwfQcM4YsGmUBuQPIaaAh42 K7s/wVKtK4HCSmV8jUH5bjTxTl3toOPcasjXF/nXIvkMuIbpd7hcF/losMHinBp1wA2ATF1dF4r BWIVli5zKQQzrcz8ew4o0/Xzrw1Wb+hlLd0ZBna94DmVX9+gkOz/eFyQn/2n+tV4Ev3oKKblEQh
 D6sFxPII0+yKn5WE8UI+R9sCKdVXxoGtPLS0RujyAfBPpfINYhnWP1brGUIq51cRQ0rL6mtw

[ adding Paul McK ]

On 5/8/25 8:46 PM, NeilBrown wrote:
> This is a revised version a the earlier series.  I've actually tested
> this time and fixed a few issues including the one that Mike found.

As Mike mentioned in a previous thread, at this point, any fix for this
issue will need to be applied to recent stable kernels as well. This
series looks a bit too complicated for that.

I expect that other subsystems will encounter this issue eventually,
so it would be beneficial to address the root cause. For that purpose, I
think I like Vincent's proposal the best:

https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw

None of this is to say that Neil's patches shouldn't be applied. But
perhaps these are not a broad solution to the RCU compilation issue.


> Original description:
>   Following the reports of older compilers complaining about the rcu
>   annotations in nfs-localio I reviewed the relevant code and found some
>   races and opportunities for simplification.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 1/6] nfs_localio: use cmpxchg() to install new
>  [PATCH 2/6] nfs_localio: always hold nfsd net ref with nfsd_file ref
>  [PATCH 3/6] nfs_localio: simplify interface to nfsd for getting
>  [PATCH 4/6] nfs_localio: duplicate nfs_close_local_fh()
>  [PATCH 5/6] nfs_localio: protect race between nfs_uuid_put() and
>  [PATCH 6/6] nfs_localio: change nfsd_file_put_local() to take a


-- 
Chuck Lever

