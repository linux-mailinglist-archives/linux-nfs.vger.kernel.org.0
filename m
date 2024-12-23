Return-Path: <linux-nfs+bounces-8746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36849FB041
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 15:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1334918905F2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937081ABEC1;
	Mon, 23 Dec 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B36pFmQT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WxgjY4Xb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A618622;
	Mon, 23 Dec 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964322; cv=fail; b=GQ4sx/AsC3odTcKG9/tpwDkT4z4g+L+JJHyP58F4v6+tAvKvDb7BM52TjnR7KMk8IYjqvMivV3xPcN0UfIwmN38xYoPGvs52Gsa9UbXsM34nwb6S4RP8jKuFOWx2mbf5BGwZm9tgnJw3b63kdJv7WsMVuhsu9TExXSDKEOV9BW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964322; c=relaxed/simple;
	bh=KJwK/1GmJKIea2gEKJupj+BfvIsOevRjt5fZZnfXBm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4ymjrI5qgD3MeAZdvLSoQ+CDOqh4zvXc1u4TS/rV/A5ZA9r2HQ2rnbr4vRDSZuZCFJrXhusSAzRm3F7BVLNw7OvHrmtm2AjE7eCk3CTv4LAIGXZgmVFGESk1ehnacd50iehV27HOb9cWpAbFUghRnd5fPyJ6tcgVGLDq+6+uYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B36pFmQT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WxgjY4Xb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNE551t004959;
	Mon, 23 Dec 2024 14:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bBkOYp8lBwLZM68NmLuoNorthiA6TV9s8d+6t6pNl7w=; b=
	B36pFmQTv1Q6BYrRoXS9/UCh3ySen2Oo5Ku3OimDD4ns3lAyUdfWemmnCczpe6Q7
	kx4wp7skyoKZesJnLlW0W5TPIAAy9xBZaybhvzRiGOA9JZpnWE3Ysg3Vyoxv2ALW
	wTEAhy4AwlbMDmDROPDvPweR4DBbelyhrC8QTLKiZnJUmsZox9yJKrhXvSDrJLpt
	oKuz8aS858vEHNuWuzMkq/jkTKnVYEmyMslpHL9wvsr1nY7J8UTMY7F/9NNQNmUA
	bitC/2lWVkfOHXf7SquGYyt0qJd8x++0pemvNuZG8+UXOJhwfTb6mK9A6/seKuHU
	ws2oFwk5CZVfk4o9u3VVTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rjkra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 14:31:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNC6G9H001012;
	Mon, 23 Dec 2024 14:31:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8sv3v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 14:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBLb1vZlBZa0ovS6T1cWVCsgyQBJMHU5IPko2AmOF0r/ugI6Z0264iuT8fLEtquJ3ASxvEj6IBaoFVClr6HYabDGynd47IANUKVhsSJ1WvijWz+0IdSjn0SP7LE0S3iXGDuLLqCvxbtRGmdZrLkOOvZIBWrPTXyqkTC1wsMgeSVOFoVNZiqAIY6JLX69ASUA8L2aLfrYC5Cl3PUuvM5JUs1GbIcyYRLldHaKqdc2ZH6RpNlwKCDIfx1TVYFf+oYIZLaNcUsqiN9vkFs0OK7NcaHJsA9ORGW2UwVcC0Y9anz25V1YsevPkw/F+nHMDje6CTz9Mfu8g/GraI7V3AnmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBkOYp8lBwLZM68NmLuoNorthiA6TV9s8d+6t6pNl7w=;
 b=jiNbBQaiLIB8npOw99dZuxM1IQZ7dFGMDhB7oWJtLT6MgSekZ7ofUDgi7CFl1Q2DEmJlQHoNgYRACQHeIrX9JGmMcTBTVnwPKzUy142ZkOy2i4uNevEbiHRCycA3I3nIwQtaCFar1kUsawcvpWH48WU+S6DHGFstNNIiqQFCPg6S25DSwmTJ2A7SY6gab4Su32U+n3/Et/S8Kd9u6LppB5+qkn46eXE7Qn9/R6VcWKvBDXbtGO7FiOuUril/LVw0/3wH10lB886+uVk2/LXUQPMcstlsuy9C0B9AEyy+HKcdUirS3cEQ0BoVkgH4+3x+Bc7hAejQVfDUmhrs+6ekfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkOYp8lBwLZM68NmLuoNorthiA6TV9s8d+6t6pNl7w=;
 b=WxgjY4Xb315MKlCdOzVM2t0uXObBaNOd8wNYCoqezJI4axLrWVbfD5KfQjjCv/12P08NMnnMXHXHh6l0DgFt7bE8BxGnPxdasvxDuWCX0rifxCwjJt+vn8ryXh08AWf+iwkb1XZXX74h9FUVBUtoKc7jy4i7hLMAZ7GLGPGAphE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 14:31:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 14:31:41 +0000
Message-ID: <3d0804bb-ecc7-4507-9247-1d0dd8305073@oracle.com>
Date: Mon, 23 Dec 2024 09:31:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Encode COMPOUND operation status on page
 boundaries
To: Rick Macklem <rick.macklem@gmail.com>, cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        J David <j.david.lists@gmail.com>, stable@vger.kernel.org
References: <20241223001005.3654-2-cel@kernel.org>
 <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d77903-dee3-4352-b55c-08dd235e84a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhTellnelFWMkxocDdORTg2dzJnSS9CVFlEZWpsTkd5KzFGZlViSDZGcmZq?=
 =?utf-8?B?SElJYnpRTXdETFM3KzdpbWFXNE5wbFQ2bU9nZGVBZGZJaXlFMnFRMTk1ZnRj?=
 =?utf-8?B?U3RlZXBSaTBhWUN5Zks1MUNaTkdFdHNOaE1kOTl0dmJpZDN5M1hWa3ZJU01S?=
 =?utf-8?B?bkIraG92V2l1WVgvVnA5a3ViblJBd1RQSDRCbU54dmNMM3pZWUdReDUydWpy?=
 =?utf-8?B?eTY2YmJybjhqb0dJUFVOajhpV0RvaXRJVTNBQVQvVmxIL1RnS2R1OVJ0YWd4?=
 =?utf-8?B?UkVFZEg1OTliSC84KzFJMGdUTE1aQ0RCY2VtQ09zdlVwSTdqUXJTZ3JuS1R2?=
 =?utf-8?B?QnhwaGlzZE5LNWpBUDRDUGtLeml2ZE80dWJHUUVnY0RLa1Z4ZHZyZndMZlRX?=
 =?utf-8?B?V2d3cTdrUzlIYUFEZGpJS0lhOGo1YzVOcmMrb2lmQlNJbzliSlFJbjJCNCtV?=
 =?utf-8?B?bSthRDVYcUdHczB6cmczWDZ5bDR5U01sZU0yN1QrcHZta0QzdkhOR2E0amtH?=
 =?utf-8?B?ZUxoUDh4TnZsWExZdEtoRmduSHAxVnZmYjR3d1BTbFZYZzB2UmdQS2o1Vlc0?=
 =?utf-8?B?R2hHRG5HdDliRnM0MTU5cFRCTUxxU3RVWnZycTBDdzlwN0VTQ29qbCtUSVk1?=
 =?utf-8?B?dUduTWFWYlhmSk0vY1k2RnZ5VHJkNVpwK2tqTFFXWkRGYmVLMmFaOFhuTVdh?=
 =?utf-8?B?OFcyL0EwaGNqV1dTUiswUjdzTU5ZYTl2UGVXVS9waTVvd1k3akRTNEFHQlJT?=
 =?utf-8?B?OVc4eVlRQy9VNStsUmtJcWpPU1pzM1o1NXhvQWhQb3BPSTQ5VXlUR2dWd2d3?=
 =?utf-8?B?ZjUxVjRiLzNGRWdDazA0Qk1jbFUvWEM0ZGpEbUc0aDdydWFUWms3VTBPcThM?=
 =?utf-8?B?Z1F4emhGREIreWZVY3pDNUR2UGhmbk5RUDhnMEVMcnYwUWtKbmFHbjcxSmJ4?=
 =?utf-8?B?bFJQN3lUbjdMN1hBTVdkczdEZjVaTlFNeitteFdwZUFMVGJ3V09qOGlWaVUv?=
 =?utf-8?B?ck1TK2lEY3RERTNxTk5WUjdOS1V2akJmOFMrY0NkWW9GRDBzU3FFOE9hNGw0?=
 =?utf-8?B?UTBnTWg1bTQ2amZkT3hmeVUyU2FkMWs4TUg3aUs0WG4zZHAvRlY3WG1mNUpy?=
 =?utf-8?B?cml3RlB1NUZTdm1DU2VZeW94QklYWmRoWUZzUXJjM2pTL29rTmRUR0huU2c4?=
 =?utf-8?B?QmVtVWVaNjRDdDBzcmNiQXpNcXBXeWhWWjliT0ljdTcrZHBsVFlrTGMrVTZJ?=
 =?utf-8?B?dE5ZamdVb1MrbHhVcjF6N2tsYThORnpZenZNdndOMXVYbXIremIxTkM2K2dV?=
 =?utf-8?B?TmdiYjljS0JXSFJnVnFKUEJzUnVkSmhiMFp3VWtPTzhFaHBpV2VlazQyMmE4?=
 =?utf-8?B?UnRsa1Q5QTBaY0F1TnI1bU1MbmxYTkEwQWxwQStoMG1ySjM1M200aHZWbXU3?=
 =?utf-8?B?NFIyM3RQRnhaZmJmYmJmb3lBejVUZFhwZXNXa1NnTlhBZVZOeCtybGdpUElo?=
 =?utf-8?B?dXk0enRwRitDamYxMDhTaitqdzZzelo0SnBsbkF1eTNuMHo3ZDJ5QVcvaGtn?=
 =?utf-8?B?MGpmN3l6SG9DRHhrd2RURTNaQVpwTW9ac2ZLbzNJblI3UWtDWTBDSnZvYnJM?=
 =?utf-8?B?T2dXUUlYWVhSY01iOFBmWkRNaUQ3eTdvY2V2a2ttZGMxMzRPblZHeHV6OU8w?=
 =?utf-8?B?Vng3QjBkWG41ckI0RkZEbTNSRHFLNlAybDVSMnZEeGE5ZFA4VUhmdlpmaTF3?=
 =?utf-8?B?Z2FzUXlnaC9NektSVFdBb0tVQXRTcGw4Q0ZDalcwTTRlb0Vvby9yZmlDdEd6?=
 =?utf-8?B?Y3VjQVdyU000NTZlZXhjRmlmSXk3b0w1ekpJZnQrSGhmc0JlbTAvTEFLY2xo?=
 =?utf-8?Q?+BeQ6Sz0V7vng?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9rZk9SK2NyOXdGLzNSeUlQdkxqUU1EMEJGOWFKb2NxSUFkWGZFa2dzK0J5?=
 =?utf-8?B?ZlZWTTFITCtUbXJ2VjlybW5FZDRCUlR3TG5QKzVQdnZidzdFOHhndzQ5dmVO?=
 =?utf-8?B?ZHBHMjBGdFFTVHNOdUUrRVQrVUVZT1laZ3JDaTU4Z3h0MHZEU1BVajBLeUlj?=
 =?utf-8?B?ZkZNTHhkZ2tCUU9CS2luTnR5bmYxRldiWjN1WDhzeG9zSnZ5MytQWWt0NFFK?=
 =?utf-8?B?aFk2OWk3cmRpUHdHUHFBbDZWd3RHbmljNHcyRm9iQVZxWElZaHVpQTNyd1pm?=
 =?utf-8?B?cDlKQVpLRG9TUy9TUUFiSXYyT0dHeG96ckdWNzZBMjJUQ1JFNFNnVDNmTnRa?=
 =?utf-8?B?dVNKb3Zna3Y4U2k0elN2a21pSDVpMGVkaTFsWTQyNVNTaWtFWEdzTTNBRDRL?=
 =?utf-8?B?VTZoUjlzTzF1Zmc2dG5uYzZPZ1ZGYW5qMVp6bFdqb1Y2MWtPSUtHVFI0UFFI?=
 =?utf-8?B?MkJObjAzSGFmSHBTQnJ0Z01xQS9ZMlNMUnJmZGZUM3hNcG9nU3lqNDczY01a?=
 =?utf-8?B?MkgyK0lpWThSSGo4VTRkVFB0alpMMGRwdk1TcUdNQytLbE9kazdwZTkvRDJz?=
 =?utf-8?B?ZllCQmE2R1BUNHRBcGx6L2UzYWljbkhFVFFzOEM4VWFYcFZpUkdqQlkxK3R1?=
 =?utf-8?B?SjNWbmZXakpNUVE2K3BINjB2MUhMRjhSOWJmRWVDejVqRDRhSUs2a2hWaVFl?=
 =?utf-8?B?clV5UFZQNjdVL1F2WDJOREJWcENXaFNvUGN6ZVM2WGRWNFpIeDN5ZHprc0VG?=
 =?utf-8?B?S1JmSzZtYjVFVmRtbnhXbEhkQXhIWmdzdWRnQmZ3bzdIeDIvSE1qNUR1TDBx?=
 =?utf-8?B?aS9GK1lzU2NHRXVWTWQ4eVRTSWpkMmZXTitRS2NTWGJNKzNnR2syUzJxUHJL?=
 =?utf-8?B?ZGM1bnBVNTV5QnlyTkQ0bFZNOUFPNlV3UWZ5d25JUnFHcE9EZVY4ZDQyRkV6?=
 =?utf-8?B?OE8zaGhQY3lLWndZMXVpU2FxWGNhMVhZMk9EaEdkZlBmZWxvUFN0aldIUlhQ?=
 =?utf-8?B?cWFydzJVRVNCOWpiNTErK2xSZ3BUdjhCd1I0M3hYRnh2S01Uc3c5a29wa2M0?=
 =?utf-8?B?bUNmaGlXbjRIVnVGanM5a3hUdVExUjBzQjAzSDVwYUJjeXdpWlVBVnE4VDBo?=
 =?utf-8?B?WDFwVEZGc3JPTVdmdjltTFd4bEczcldvV2F5M3c2bUtxb1VJSk5JVWhTaEgz?=
 =?utf-8?B?ajlVVk82NUlBaFV5NjlYWGx0ekxNdi9UZjdLN1dkY00wU3FmRlc2Szl2SUhK?=
 =?utf-8?B?MTMzMWduL2FVOFJDblNMUUVwNERjR2tHR2JONVdaRUNVUGc3L2JyVnJsMHV1?=
 =?utf-8?B?aXBOV1RQRXJ4U0xFM3dLZ3llZFVLZFdEZjdVTkpCVTRyZkZub2tUOVZnd1ps?=
 =?utf-8?B?aWdWalFDV1JlbnNTeEZtWi9kcSt0SFdnQVRUTFp1aGtrWEhwZ1FRTlBHUGtv?=
 =?utf-8?B?RHdIVXFteGFrSFR0aTc4YW43Q005M1d6QjdIcm5TOVZxMzB0MSswelhJalZZ?=
 =?utf-8?B?WTB3bitXUUZiOWhRWkhMLzR3RERhUVFic3NNSDFJWVJCOFdnVGlhUkorc2t1?=
 =?utf-8?B?QVB0QnNOY2N4bzR1YzdRNWFVek4xblRaellEZDZOaC8rK0RjMlh2bWRtRThH?=
 =?utf-8?B?cCswRzNkK1B3SlNIektobUpDa1N4VGR6TGQ5M1B6QTJMSDMyU29uZGYxUytP?=
 =?utf-8?B?aVJmMVNMcnRxMU90OStZS3N1MnMwbS9SVlZOWm1HR3ZIZzcvYXk2M29ramlk?=
 =?utf-8?B?Ykl6WmlEZXhWK29LZzZYY1NrTUNSWDF3Mkp0MHhUWiswY1NBOU45YmlCZVJJ?=
 =?utf-8?B?NTdzc3JNVnhCUEF1cDBpeE50dCt6SFVTck1pZ0pFT0lwZUtTTWZ1Q0FtZmtF?=
 =?utf-8?B?ekxNNnZ1RmNNTTRxak9haGs2YzhCcjJwQmg1WE5BZXRXOUFqYXJqdS9nQkNv?=
 =?utf-8?B?Vjc3U1NIMWN0NnlBQnNYSWN2Y2hXejR2MzRBZ2V3YStHUWJNT3pJWDB0ODNh?=
 =?utf-8?B?RUd4bU5Ga3dmZGFaa2JUUnhpU0tyNFVJZ1JmT1NJL3JrS0dzNGU2amJGRzdB?=
 =?utf-8?B?SjFTcDB5cGxPVzNoNlFTRGlYWTJhS2s1eDk5N2Z4SU84eWk0YWdicTJkL2tq?=
 =?utf-8?Q?W5J7qbEmQKu/qlLf0/1UhHpsy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lFkP9ZPxBbMvqHsRAoVF7nxs98+J+56pXhwcpPpQPBnd0iyC14Oo/q769MRUTbppQjmQ9sLhSXmixCQBaUW98k6JdpeVJYpK5/xVlPRe/8+wsY6udF6um3NzGS1SYvwaTgKiZAVXnONbB3XiUj5lI0+KvteKcbHeRzy6gTjyIpvrCWWZc/ptBpbpSf/ZWD42ni35J6aO1OWE/3Xtt8RcgHqf+7alaGvphPDclcuMkYq9dznIpFlJdh/a0mOpxuZl5X8G8cKjR7aztRha85H/9WkXJAKn9IYB7sN/QSNR7B3A7mk7NOk/BrK8f+xvxvIfnVrLdhhiBngoNJ75eEqOrKe27FQOuUSugmj3TWiaDclA6NSzIj8c+uzLJisldNRGRaZxMShIBnV0q2xHSgGioQEHxrhDFEcTxd75AR1f6TNfGzZpX2jEmCWvfJRMMgMnt3uEzc942H+f2D+ZQhP2x6xLS8DXREYspCiJtGxh2axhpa2kL5P5IuUZiT5x/ZjRJMUQR1eOnV+1mMI0A1EF28tY7Khdt2yO8ECmyMSgCFL3hvpvxsdVA9ZFZN+aMMdEwtjHnoF2o+zJq0r2CRgAvb2wArlWss9XSCv+cSTUTWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d77903-dee3-4352-b55c-08dd235e84a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 14:31:41.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16gmlp8sLwgqt+pHc+usoQyQOC3RWT4vZGB3aSud23g1gVVbdpw+4afI7xhdmbryswbEZeMahK3pTdcR/lbzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_06,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412230130
X-Proofpoint-GUID: pAw6DR28luJhsro465bO2ESaDOPO920C
X-Proofpoint-ORIG-GUID: pAw6DR28luJhsro465bO2ESaDOPO920C

On 12/22/24 8:25 PM, Rick Macklem wrote:
> On Sun, Dec 22, 2024 at 4:10 PM <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> J. David reports an odd corruption of a READDIR reply sent to a
>> FreeBSD client.
>>
>> xdr_reserve_space() has to do a special trick when the @nbytes value
>> requests more space than there is in the current page of the XDR
>> buffer.
>>
>> In that case, xdr_reserve_space() returns a pointer to the start of
>> the next page, and then the next call to xdr_reserve_space() invokes
>> __xdr_commit_encode() to copy enough of the data item back into the
>> previous page to make that data item contiguous across the page
>> boundary.
>>
>> But we need to be careful in the case where buffer space is reserved
>> early for a data item that will be inserted into the buffer later.
>>
>> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
>> encoding buffer for each COMPOUND operation. However, a READDIR
>> result can sometimes encode file names so that there are only 4
>> bytes left at the end of the current XDR buffer page (though plenty
>> of pages are left to handle the remaining encoding tasks).
>>
>> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
>> then nfsd4_encode_operation() will reserve 8 bytes for the op number
>> (9) and the op status (usually NFS4_OK). In this weird case,
>> xdr_reserve_space() returns a pointer to byte zero of the next buffer
>> page, as it assumes the data item will be copied back into place (in
>> the previous page) on the next call to xdr_reserve_space().
>>
>> nfsd4_encode_operation() writes the op num into the buffer, then
>> saves the next 4-byte location for the op's status code. The next
>> xdr_reserve_space() call is part of GETATTR encoding, so the op num
>> gets copied back into the previous page, but the saved location for
>> the op status continues to point to the wrong spot in the current
>> XDR buffer page because __xdr_commit_encode() moved that data item.
>>
>> After GETATTR encoding is complete, nfsd4_encode_operation() writes
>> the op status over the first XDR data item in the GETATTR result.
>> The NFS4_OK status code (0) makes it look like there are zero items
>> in the GETATTR's attribute bitmask.
> I can confirm that this patch fixes the test case I have, which is based on
> J. David's reproducer.

May I add:

Tested-by: Rick Macklem <rick.macklem@gmail.com>

?


> I also think the analysis sounds right. I had gotten to the point where
> I thought it was some oddball case related to xdr_reserve_space() and
> saw that the pointer used by GETATTR's nfsd4_encode_bitmap4() was
> 4 bytes into a page, for the broken case.

May I also add:

Reviewed-by: Rick Macklem <rick.macklem@gmail.com>

?


> (As an aside, it appears that "%p" is broken for 32bit arches. I needed to
> use "%x" with a (unsigned int) cast to printk() pointers. I doubt anyone  much
> cares about 32bits any more, but I might look to see if I can fix it.)

On Linux, the %p formatter emits a hash instead of the actual pointer
address, for security reasons. There are ways to disable this -- see
the "no_hash_pointers" kernel command line argument for the big hammer.

(Documentation/admin-guide/kernel-parameters.txt)


> Good work Chuck!

Thanks!


>> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
>> across page boundaries") [2014] remarks that NFSD "can't handle a
>> new operation starting close to the end of a page." This behavior
>> appears to be one reason for that remark.
>>
>> Break up the reservation of the COMPOUND op num and op status data
>> items into two distinct 4-octet reservations. Thanks to XDR data
>> item alignment restrictions, a 4-octet buffer reservation can never
>> straddle a page boundary.
> I don't know enough about the code to comment w.r.t. whether or not this
> is a correct fix, although it seems to work for the test case.

The most correct fix, IMO, would be to use write_bytes_to_xdr_buf()
to insert the op status once the operation has been encoded. That
API does not depend on an ephemeral C pointer into a buffer.

The most performant fix is the one proposed here, and this one is
also likely to apply cleanly to older Linux kernels.


> I will note that it is a pretty subtle trap and it would be nice if something
> could be done to avoid this coding mistake from happening again.
> All I can think of is defining a new function that must be used instead of
> xdr_reserve_space() if there will be other encoding calls done before the
> pointer is used. Something like xdr_reserve_u32_long_term(). (Chuck is
> much better at naming stuff than I am.)
> --> If your fix is correct, in general, this function would just call
> xdr_reserve_space(xdr, XDR_UNIT),
>        but it could also set a flag in the xdr structure so that it can
> only be done once until
>        the flag is cleared (by a function call when the code is done
> with the pointer), or something like that?

Well there's no limit on the number of times you can call
xdr_reserve_space(XDR_UNIT) and save the result.

It just so happens that, with the current implementation of
xdr_reserve_space(), reserving up to 4 octets returns a pointer that
remains valid as long as the buffer exists. For larger sizes, that
doesn't happen to work -- the returned pointer is guaranteed to be valid
only until the next call to xdr_reserve_space() or xdr_commit_encode().

The only reason to use the "save the pointer" trick is because it is
more performant than write_bytes_to_xdr_buf() (go look at what that API
does to see why).

So the whole "save a pointer into the XDR buf, use it later" trick is
brittle and depends on an undocumented behavior of that API. At this
point, the least we can do is add a warning to reserve_space's kdoc
comment. The best we could do is come up with an API that performs
reasonably well and makes this common trope less brittle.

I'm auditing the code base for other places that might make unsafe
assumptions about the pointer returned from xdr_reserve_space().
nfsd4_encode_read() and read_plus() both do. Probably the SunRPC GSS-API
encoders do as well.


> Anyhow, others probably can suggest better changes that would avoid this trap?
> 
> Good work, rick
> 
>>
>> Reported-by: J David <j.david.lists@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfsd/nfs4xdr.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 53fac037611c..8780da884197 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -5764,10 +5764,11 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>>          nfsd4_enc encoder;
>>          __be32 *p;
>>
>> -       p = xdr_reserve_space(xdr, 8);
>> +       if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
>> +               goto release;
>> +       p = xdr_reserve_space(xdr, XDR_UNIT);
>>          if (!p)
>>                  goto release;
>> -       *p++ = cpu_to_be32(op->opnum);
>>          post_err_offset = xdr->buf->len;
>>
>>          if (op->opnum == OP_ILLEGAL)
>> --
>> 2.47.0
>>


-- 
Chuck Lever

