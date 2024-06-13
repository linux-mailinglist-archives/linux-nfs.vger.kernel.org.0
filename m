Return-Path: <linux-nfs+bounces-3795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D403B907F19
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 00:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5435B2818BF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51B14C591;
	Thu, 13 Jun 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b="YJSGW5Ob"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2094.outbound.protection.outlook.com [40.107.116.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720C1411C3
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318671; cv=fail; b=jn4MZ9vfCY5dt0WMC+2DJnZ4lITbXVwX4T4YTiQZmuFBUi9i7oVpIQPhWCeMkAT8ldxl2O5cWfvk7pC5NeEnUBRfz/UJd2+euiGJeilY2JB2+Xm4+KYFdEyPzR4MYwAhshODZlVe0YPov8D9qt+emTdolaTNlDFLnSd+prIZVNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318671; c=relaxed/simple;
	bh=g4mnreBLoBwN+lTMtq3SgnhIsDw3YZDk/De3nvmj0rs=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=DrYjvnYc0WxBmiJBrU0+5pKHEpcTPSc7RFXMnsMJEmWy4lhn0Fqs9PRnICSqxQAozIzvrc0AfJxhywoaXVLQE6ljxK5w93RxZ5q2ZDlRbgpWnPNy6OtgzbVr2wFGwv69s962gTLbyZ3gZMQ//55ylH4vTGVp3omBVhyljaCYOYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=mail.usask.ca; dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b=YJSGW5Ob; arc=fail smtp.client-ip=40.107.116.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.usask.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AieSPhTmk7vQydyOWEDzkBuBkkL4L7WMTyXd2bl1wk75H1ud+yxYSrqXeIVXKsaZJOJrR+gBoEXtiXQQTc+CfmCgIg1fuzo6yTWRxxwa7Wl0Ll7rnrp0wZ816XuK/jYX8Hs21F3tgrEz7Nn7x0ptrcQCM5Cf/c1c+uj5UhlsXXy8ijQ3+VT4/9oR9oQo8VH0qeMI0mTztk0kA79GbBiHU3iGx2ABC0kkTar6OgzUA/Tas41PifSWd4W2lsTZ5EmPe/vitA6F2jneclXdTicLqJPRlcYEnniE49puMbjrLEwXSzODT2JTtILhNJywK0qMVBfes8l6VVv0bLN3BSdNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmbt9Tk3D3JzxVsQuYotg90JB/GmC9clnLucmQOh7K0=;
 b=jhNzjNxDv2b3HHHd4W01AdJiSrrj7vyZ1i1sM+wKOWsajNGm9MAqd38QX031g09zjt8NlDOLnVAcVlQwimF02G4B1OCW1h8UwWOT5T5EhpJC1UoXrFFJttEwX+5IQxgBrwVWG6Pnx5y4i67Xq3b9iWWYCStKEgAvHwcpc7odFMehbKReN0QB/QxZX65kAOhHc08vU18PZJnGvoEm86ZCPu9otHSoVJqxkwTr1k/oo76zflRRwHcvWHdm+ir1d2w23+gnJOBtK1spzsQ/rkhqqOjSxaZZnBF/EVvueNwpLpVsXgiWiM36vC7yPO4mJXmDmXVMlAH42IHtmZnGKmsS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.usask.ca; dmarc=pass action=none header.from=usask.ca;
 dkim=pass header.d=usask.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usask.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmbt9Tk3D3JzxVsQuYotg90JB/GmC9clnLucmQOh7K0=;
 b=YJSGW5Obq2/aBe39Q0dDvqiJwRBZEJpXW0zOW/VwxIsXr9ur/CU1i2NLlt1ZEXEIyUyAEtyaQ2hGazF89GhPGn3nTH8lSCU3XcScaKZyrQEiBtZiJ9BSZrvlCZduhgIn1C/KkLryDIyntrNsLz4Ne6w+dNAzS1EZroinl2nLonPg1+dJV5XMpMm+5oWFgCLedbYA0HIBJXqU6lPnUTa+qQt4BErDPkoC2amHNxH4GX/sW3Cq2lnJSSaI6ZaPEEDQMRQzkh3M7Hr+A21V1TWtw4kNknuKMVzDMp+CjHVEsa16d101AbVUjpN71Y07iX9cHLKnmhTGIpQBlE8mLDX+YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usask.ca;
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::6)
 by YQBPR0101MB6633.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 22:44:27 +0000
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321]) by YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321%7]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 22:44:27 +0000
Message-ID: <8ac2bb6f-63da-412f-8469-2a5be823fa40@usask.ca>
Date: Thu, 13 Jun 2024 16:44:24 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: Chris Friesen <cbf123@usask.ca>
Subject: Seeing strange behaviour from RPC/NFSD on 6.6.7 kernel, looking for
 debug advice
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::6)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6200:EE_|YQBPR0101MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6df7bf-8fb7-44ba-0720-08dc8bfa612e
X-UofS-Origin: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzMxc2JiU2pxd2p0OVdoVDBoTk4zUFNRUnRSZWpLcHRRYVNhMFBFY1kwK3hC?=
 =?utf-8?B?YlJxSVFJQkpBMnBuaEpINk1jV3VTSG1yclhqRXJtSUdhaEhGKzFzaDcxYjMw?=
 =?utf-8?B?Q09CTVZmZ3JxekdZNTZ5aEQzNzhyUTJoWmQ2THlaR2VMV1RHcUpTR2Vwc0s4?=
 =?utf-8?B?b0I1bkVVQURtS0d3T1lONnZqYjFaRzdVSjNaa2U1Si9tSDFjREEvNkphMVlW?=
 =?utf-8?B?MFdjNVpDU1BRcG1BRFg2VU94MnlpSTJhRitsSUpvbmtTenJkNUxXcGJXWmQ4?=
 =?utf-8?B?WE9uMkJ5NEU1WGdRV1RNRzg2MHpnc1BqcGlwWi9oNTlyMlVsZHBiaXlXM1No?=
 =?utf-8?B?Y3ZaZTk0YUt4V1Vqd0pSRTA0YmRFQ2tMSGhjblhEdFNqcEh2R3V2VmMrTGVQ?=
 =?utf-8?B?TzBBT0lEZVNYY2k5aTNLVGFJNlE3WURkbjY1TEdlSTg4TXcvK2dDRHNPWFk2?=
 =?utf-8?B?RUIrb2kzenUvdUZRekNWRDNVaUxBQ0Yrek82L2w3ZTZRZU9Ua3d2UjNDOENN?=
 =?utf-8?B?VE15MTZFR3ZFZ0hYeFZQTmM5ZkF1Y21YQlFiaERCeXpZeG5LYWZwTW1laTlr?=
 =?utf-8?B?ODB2SHhRVmtJOHA5ejJDUGlyR0xWcFhlTXMrRWVkSlY3eFg0TlRpcVR2anB1?=
 =?utf-8?B?QUtrNVdrMjFDaks3L3pVUnZIK1ZvQWgrZ3ZHeDNjUCt2S2M1dmwvT1hOQ2t4?=
 =?utf-8?B?MnJ0R2VVSnNZUTRkYlN1SHgveDVWbFBONkxGUHcrMy9lbk1POWNISTREc09N?=
 =?utf-8?B?MW9iRXQ1YnNvQlQ3NzZqMkNUSU9ieklKQTZlcW1XeTM4SkZYNWUwSXZ4MU1x?=
 =?utf-8?B?a05FWXJxN2NHOThjaWZEdUs5eTBSZmVmVXJJU1FJQnU2d1dNeG90TjFuVWto?=
 =?utf-8?B?OURTOHlORmRuakQ3dis1NjFMUjhUdkg3Z1FwUStDVTBNWmp2dGZVYm9ZRS9s?=
 =?utf-8?B?M1pkb2NFQ1lBRzNRM0h6dWNJMndQeHBtQ0R5aDdNeHVJY05UdFdtMnBqbFkx?=
 =?utf-8?B?Z3JIVUpqQUtDZ3lHSkpwajhTRlM4QXY3K0t5a2JzUlNMVWxCbTJCOGJJRWdC?=
 =?utf-8?B?NkxJVUlVRXIrRnVoTDAzdGRlMHpRdUlCSmNEb3d5WkU1Q25rUStIWmRxaGlD?=
 =?utf-8?B?MHdLdm5lY2ROVEtXU0lKQXFOQis2aDNST0VYYjJzL1ZnZFBLbjRmVWRNYUl4?=
 =?utf-8?B?R3Q0QU1VVUxpMzlBYldwSUk3NStaV2oxWUdmTHpSclNQZ0J2cERPZlZ4dFJU?=
 =?utf-8?B?Z05iT0RRUWk5bitZMEVETlMzbS81RWZIWjVGYk5RR3pkSFFURDNVRlMwb2JZ?=
 =?utf-8?B?TEhQcEp6S3BPcUloVWQvNTlpSnpYRWMwN2lBenVXN3JUTmR0RndHTDdiVHo4?=
 =?utf-8?B?czZ0TTBmSG5vY2U2S2N4WityQVV3ekZZeUdTR1IvaUl6TkVKcmZ0YUNWMk5h?=
 =?utf-8?B?ZHJWM3k2QlNBQ1ZRZzRRTzRjWlFmZndQTzluRGY5bWZqY0ZxRUdkMjE4eEFL?=
 =?utf-8?B?dDN2ZUkyNEgzcmRkamFxbkg2U2Y2akNkUk9NSHh0TjdPWlhCdkZYSWxnUFZC?=
 =?utf-8?B?WkN1WkRLZHpZbWtNdURYRWdPTnlkYzlQMFZuYVRVc1dXVXhYMHZrcTcvNEZI?=
 =?utf-8?B?MDAzRGtNM1RkbDZXU0ZOS2YyVG9QY3BZTy9BZzljeTlaM2h0TjhTUFlhTnRC?=
 =?utf-8?B?VEVsd0tTOEJlZ0JkTnA4TDN2YUhkWWpMYkZyWEUvcnpkYWZzYU5Fc1lNdlVT?=
 =?utf-8?Q?kIFUJtvqjsl7YXBq3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE9Ccld0Tlg4Q04vRkVKT1U5MFRITEZEWExPNjZIT2gxOGNGWVN5UmNaMEhZ?=
 =?utf-8?B?QncwLzJBRU03MlNmT1pnc0F6aExhM3RlUHBnR2JoYzN3cWxpaWx0SzFOdHJz?=
 =?utf-8?B?TDFNdDFsdVV4RDBLelIwY2tvYWxWeStFQmFTcTdDSHRmamhGaEJzTWtrQ0Rz?=
 =?utf-8?B?NE1yZU5qc2lieTUwbGEwZVB6NnpTcEJGT2dkajF3cUpRRzZYRkVBRVpXVTdH?=
 =?utf-8?B?YW1nTDlpU3VUVm5uUGl2Q1BKb2NNUTJ0L3NTZm05T3NPV0YrWXhmdlFvZTdQ?=
 =?utf-8?B?SEluN2JXeTZOTnJKcnY3TnlSZExob2hNVlRwdjE2ZVBxSzUvWTYwR3d6VXg2?=
 =?utf-8?B?K25PZUNEVHVQM0pmQjFhNDd1UTN1ZUN1UEUvTFVEWHhZblFSRHhSYjBIV21j?=
 =?utf-8?B?Z0JDRWZOdzNILzBQZ0JKMWlKRkxlbGdxWElBaDRET1BiNERseVZwOE5mZ2ph?=
 =?utf-8?B?ZVBYYkdQTDVhRGh1WUF1T3pDSGt3OTNRZURHUmJGYVRTMnk4R0JNM0xnejdn?=
 =?utf-8?B?WEEyR01YeVYrVTEySXRiWi83Y2hFaDFpKzcvZXQvR1ZIbFluWFlMU1c0Tmdi?=
 =?utf-8?B?NVZYc1NwQmdzbDIyVEZEWWduM0pwa0hWYU8wR3JvOVhxT3BGM3BXNmxwRW1a?=
 =?utf-8?B?VTJNOEJ5SGw0SkVkVXoyQTdhTzJlcXZ5aWllUUd0NDllVVZVRlJLV0x3RHVD?=
 =?utf-8?B?SnQ2ZDJzV2I5TXJTV3JEM0k2ekhRZzlpK3YzMGo5eUlzbnc5ZHZRRU80ek9B?=
 =?utf-8?B?TjlRSkNwVjZHajF0NkdqYy9xWmt4dGFMQ0dTRVVsRGIvL3ZBN0ZVYjhrMmZQ?=
 =?utf-8?B?UFpkcFoyMEMvK2Q0VUhST2JuSm5aQ1Zlczh3dUR5SEtrYkxiYnJOaVZmbnBC?=
 =?utf-8?B?R3JJaVVVU1lsdURWV043OVlMMVFsMkJ5dzhtZWw2OTdMZVkvTXZFaS9GNkNp?=
 =?utf-8?B?czB4R0U5VCtNS25ldW1WalUzRDM0a0hkUjE5R3lWbDdVVnlncE9hZE9yalZM?=
 =?utf-8?B?MnU0MUIxeFVDRDR5MGZUSkFZSFNKV0t0cFRLWTdBMkt1b1R2bHBQM1RxQWVi?=
 =?utf-8?B?TWRzK1FNWHB3MHNKTGkwVTJyaW0ralRkWWFxU3dIQ2hLZVZ0RE9rWkt5NXN2?=
 =?utf-8?B?YU10MFVVSW9LcUhDRDJ0V3BDWEZsN2NnTlBmaGRtd1pQbUxCa0tjY0RUdWx1?=
 =?utf-8?B?Y2JMRXVCWTB2RHFlejRjVk83WXpOL29rRWZ1UXFjRStmODJTSFU5ZlBCSHds?=
 =?utf-8?B?ZlZ6MEdOZ25pcDlIdDBHb3kwZ1dyYjFjS0xLT2NKODhta1F1MmpPNm9BMnla?=
 =?utf-8?B?UHhTVEFwWmZHYVJSaENjYU5FV0dLUzlTL1NFWkU5U0pLajBBMlBaR2NIQ2VU?=
 =?utf-8?B?REV6L2tOaHZCaDRMb3FwcGx5Y1pNcGhEUFBHaWh1VWdsZEs0V2E4VWlTNng1?=
 =?utf-8?B?WXd5T2dEUi9Obyt3OWxENmJOT1lGWDJlai9ZbGNkODlwR0FyamlhRnRtM05D?=
 =?utf-8?B?TFYvR0Mvb1FIeGJHUUJldzZOY0JrSFlMcG16YXc2ODVDRjM1UzRkQlNBSzdj?=
 =?utf-8?B?ellSK2FlYTNBbm5wRysxUEgraCtCaFpIZ3lJR0JOY2xncWZac3g1emYzSm94?=
 =?utf-8?B?S2E2WHpKc1B4NnY4RnFLYlkvOEIwSzdGazZTUGJvQUpuL2g0QTg3d3JXbzR3?=
 =?utf-8?B?ZHdWVlRpd3ZnQ0hjdG1UTmwrN1hVMzlWRFB6TWxRZTRwWndNdEJEakZjQXdn?=
 =?utf-8?B?bXhydzVHazJJMUFreHhodThxWk82a3U1S2dRQ0o3YW9zeU4wNlFJaHFjSi9U?=
 =?utf-8?B?RWZEZFhoR1VxdXpHNGdQaEhuaTg1ei9zUTRLazFtWlJodWZvdzRIQlMxMDdE?=
 =?utf-8?B?cDR6VTg5QnR2VlVBVVl0OG9YREJHeXRZQ2pQNXFucG9odEpCOVIwYVJiZzZG?=
 =?utf-8?B?cktCcWFoM2pPck5PR1IzUDc1WHBNbzQyd0JCejZMQnIvZFlvT0ZEOVpVWmox?=
 =?utf-8?B?ZWEra253TndyOGRvejg3YTZldW84R0xINEJYY3RWMG1QTklhRmdUdUk0WnVo?=
 =?utf-8?B?dGt2anRHRDJaUmVTeTdtR0NMZWZnM2lwZjdNYmdRZzNEZ3lMRTdUdG83MFJo?=
 =?utf-8?Q?eBqw6Hn0CAoiCBGNbGsp/AVRj?=
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6df7bf-8fb7-44ba-0720-08dc8bfa612e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 22:44:26.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpgwcA2RHBSkfYgnhXAyOfTQ20v+8VNGKmXNoFtt81THB3Hm7wi9padNGLuJkmA0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6633

Hi all,

I'm not subscribed to the list so please CC me on replies.  I'm seeing 
some odd behaviour and I'm not sure what's going on.

The short version is that I can mount NFS exports from this server 
(including mounting on the server itself) via TCP but not via UDP.

rpcinfo on the server gives the following:

root@controller-0:/var/home/sysadmin# rpcinfo -s
    program version(s) netid(s)                     service     owner
     100000  2,3,4     local,udp,tcp,udp6,tcp6      portmapper  superuser
     100024  1         tcp6,udp6,tcp,udp            status      116
     100003  4,3       udp6,tcp6,udp,tcp            nfs         superuser
     100227  3         udp6,tcp6,udp,tcp            -           superuser
     100021  4,3,1     tcp6,udp6,tcp,udp            nlockmgr    superuser
     100005  3,2,1     tcp6,udp6,tcp,udp            mountd      superuser

root@controller-0:/var/home/sysadmin# rpcinfo -p
    program vers proto   port  service
     100000    4   tcp    111  portmapper
     100000    3   tcp    111  portmapper
     100000    2   tcp    111  portmapper
     100000    4   udp    111  portmapper
     100000    3   udp    111  portmapper
     100000    2   udp    111  portmapper
     100024    1   udp  44993  status
     100024    1   tcp  60561  status
     100003    3   tcp   2049  nfs
     100003    4   tcp   2049  nfs
     100227    3   tcp   2049
     100003    3   udp   2049  nfs
     100227    3   udp   2049
     100021    1   udp  36993  nlockmgr
     100021    3   udp  36993  nlockmgr
     100021    4   udp  36993  nlockmgr
     100021    1   tcp  33239  nlockmgr
     100021    3   tcp  33239  nlockmgr
     100021    4   tcp  33239  nlockmgr
     100005    1   udp  43636  mountd
     100005    1   tcp  49357  mountd
     100005    2   udp  39783  mountd
     100005    2   tcp  54527  mountd
     100005    3   udp  40970  mountd
     100005    3   tcp  41761  mountd


So it *looks* okay to me, but if I probe it I get the expected response 
for TCP but not for UDP:

root@controller-0:/var/home/sysadmin# rpcinfo -T tcp localhost 100003 4
program 100003 version 4 ready and waiting
root@controller-0:/var/home/sysadmin# rpcinfo -T tcp localhost 100003 3
program 100003 version 3 ready and waiting
root@controller-0:/var/home/sysadmin# rpcinfo -T udp localhost 100003 3
rpcinfo: RPC: Timed out
program 100003 version 3 is not available


Oddly the last command returns immediately so it's not actually timing 
out, the error message is a bit misleading.   If I sniff the network 
traffic while running that last command, I see this:

root@controller-0:/var/home/sysadmin# tcpdump -vvv -i lo port 2049
tcpdump: listening on lo, link-type EN10MB (Ethernet), snapshot length 
262144 bytes
20:20:53.159743 IP (tos 0x0, ttl 64, id 58251, offset 0, flags [DF], 
proto UDP (17), length 68)
     localhost.887 > localhost.nfs: NFS request xid 1717614110 40 null
20:20:53.160016 IP (tos 0x0, ttl 64, id 58252, offset 0, flags [DF], 
proto UDP (17), length 28)
     localhost.nfs > localhost.887: [bad udp cksum 0xfe1b -> 0xf663!] 
UDP, length 0


Ignoring the checksums, I get this:

root@controller-0:/var/home/sysadmin# tcpdump -vvv -K -i lo port 2049
tcpdump: listening on lo, link-type EN10MB (Ethernet), snapshot length 
262144 bytes
20:21:49.642588 IP (tos 0x0, ttl 64, id 22026, offset 0, flags [DF], 
proto UDP (17), length 68)
     localhost.934 > localhost.nfs: NFS request xid 1718297876 40 null
20:21:49.642697 IP (tos 0x0, ttl 64, id 22027, offset 0, flags [DF], 
proto UDP (17), length 28)
     localhost.nfs > localhost.934: UDP, length 0


On a separate system with a 5.10 kernel I get a successful response that 
is longer and is properly decoded:

root@controller-0:/var/home/sysadmin#  tcpdump -vvv -K -i lo port 2049
tcpdump: listening on lo, link-type EN10MB (Ethernet), snapshot length 
262144 bytes
22:22:00.388497 IP (tos 0x0, ttl 64, id 806, offset 0, flags [DF], proto 
UDP (17), length 68)
     localhost.808 > localhost.nfs: NFS request xid 1718037578 40 null
22:22:00.388525 IP (tos 0x0, ttl 64, id 807, offset 0, flags [DF], proto 
UDP (17), length 52)
     localhost.nfs > localhost.808: NFS reply xid 1718037578 reply ok 24 
null


Anyone have any ideas what might be going on or how to debug?  I'm 
building a kernel with CONFIG_SUNRPC_DEBUG enabled to see if that gives 
anything useful.

Thanks,
Chris

