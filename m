Return-Path: <linux-nfs+bounces-9663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D55A1D702
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C963A3F22
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE31FF5EF;
	Mon, 27 Jan 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYjH6ZCX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zTjxdv8k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D71FDA84;
	Mon, 27 Jan 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985208; cv=fail; b=ef566bQvMW27wrwwAtABlftirrUwzHCTUZzctrME4hm9TFD7qNWW3921UyJQlyikujAV0JX8nJLCGX6vFmQu8/k3sZH40+A4eVHGFrULc7Tq/cr6UVDpa548QOjQrAyXj1IIwAJs0pJeTowFTVYTpc8KGHhRBPRoh9sKvUz9o6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985208; c=relaxed/simple;
	bh=QUPYaUNdWl9TiCWg7Ir/QhcsWgKbKZgLqlarzmkx9bo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=THW6DjlbyANKZKc29mvn8zbPNHaV5FRw9TsCX5wHvnDsovxFeGYz0s9gOuNzmuZemTD8uKhdbV7VKk48kPn9gVdV8CR4T6AN6C1XTV5K5sy+u1fz3unz26mDtHckYbaqy8z5lfPSzMSW3DZyospYD6B+x4ehyeDFHGc8lVAF/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYjH6ZCX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zTjxdv8k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDM8Ob011147;
	Mon, 27 Jan 2025 13:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YReve5oauD68F9wWWPoZpafu27ugROS5HW2YBCqy8zg=; b=
	mYjH6ZCXH4Cy171iQG8oUVT0kCg1ZLFrrWm4GP4uqhBGQWQoebJRtkiV7fgv+opm
	7IzMkryVr/5qs9JKiUpVFZuTXX9KMDun1oNoIRs0dD6WkUPtxP6OVP5w6ErFbpdV
	F7dNZyvsYI8ZtgoObEiTyGWwgVKs1Uc7lkXm0ITsd+r7bxhSlRABbUAUnNHwO6rx
	NAZ/9SGuBx3UahrNPtc2CUYEFyr9nJrgB1evD6KJb9VuaOZsqMFV39b+AsIhIYQ3
	GMGW667UPCBxhOZgUabo55oZvV2C9ZNsvihrVjlGOT/HtJMOvhoeXehhGamlaJfc
	aRmb3WEDIDrlqZxgF2GaZw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44eay6g0ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:39:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RBk6mS036730;
	Mon, 27 Jan 2025 13:39:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6y4p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otxlU2S4T8dJndTQvWzJUbtLT17XspRJYZUBKRJyOf6DW+N35glmu4PeFqxMkNoJgRh7ln8zNjy8RLrLU+qwNPQEfAojW8PwwLVrZ+3RDN97U0d+lLVNzO7QYMR+Xv7ccIZ8I/NQAe3FeNgVjozl2oFV99FkOlf1u29cwAlhlNg1FDhi+NkrMkNOIddiYCtk2ei4J3cEcN/5z9zZKzoQnv7SqHk5yZ8324ybnj+tOTyvrnR8ZwsVirgusgiSDhuLSOhZCWx5Z6iZ9inoXaFb3gFTBUEKVOt/BGnTtMXtSi3mb1SvDZTNINqnWmEZlrsZrwtSe0D8gCZTi7HMqmpqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YReve5oauD68F9wWWPoZpafu27ugROS5HW2YBCqy8zg=;
 b=c04TS80Umkj0ALXO0FuLPnA1usq1Dvu225n34us/EWW5r2Hqd+elh3KZ9Kz1/nRMkSOM/InBS3lfZ/RGGEiOQgwvysnXq4BoclExmAcFCpUkytRMBgccLsmYfDFyovOfNMdwzwLBDwXofPO180mb+sKNiWw9KwMmPQFPPVgrSYV7TrYrddQrre6iZGQkKRPxY23BGfL0/BCwnqn/JrWeKW7qzkL0lBKqUS/yjcfxrh8vRuLyMfrQY0v4NGuwzAc0pihO4yU46VIIvtpwycq+ftPDVF1Xs3OmP7jQSLY1cAifvQgZ/tYrsjYiSmZzF19PJYXkWfE687qe0V6jgz+V3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YReve5oauD68F9wWWPoZpafu27ugROS5HW2YBCqy8zg=;
 b=zTjxdv8kZ4556VkD1zET61OIktNa5ssgvOHq1tHZNDziD/uPVfqnDyK4jQae3B6LeLGCo/DSnDOFPsd61CLEP8vnEEQRIIVXh0H/g1KZKz5UGnGdW7nAKJofNUeG1fCCO0IBM8RoFhf0ZdBZqF+KaBaAcP5Se5gRjQJsw2efepA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6198.namprd10.prod.outlook.com (2603:10b6:8:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Mon, 27 Jan
 2025 13:39:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:39:42 +0000
Message-ID: <ac965f67-db15-4f93-be03-878e6a3d171b@oracle.com>
Date: Mon, 27 Jan 2025 08:39:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Salvatore Bonaccorso <carnil@debian.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <> <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
 <173793694589.22054.1830112177481945773@noble.neil.brown.name>
 <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
 <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
 <5923519a4c8f6bb6d5ccd2697447b313fb61bba3.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5923519a4c8f6bb6d5ccd2697447b313fb61bba3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:610:38::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cce59ab-a29a-4456-3c4b-08dd3ed80dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm52S2cvc3A4TlUxSURJV0xQK0tCUEJPSHNnOXluOFN1R0xJdDBMWk80V1JZ?=
 =?utf-8?B?cFNtUDBEUzBjYkxkK2pnbno1MEdKa2RuL01nOVRkTndZRG9QSGJocjR2Nkla?=
 =?utf-8?B?WHd1RjRPekx6eWo1Uzhtb0krYjVKdkFpWU5CZWxDQ2h4c25lSVE4dklBdUZ3?=
 =?utf-8?B?dUJMeDJyMyt4NUNTWWR6L0hPTm9nVTVFQkh4ZzdubC9BdzlKVVQydUpPaFMz?=
 =?utf-8?B?bEdtSHlZZWFWTDVGZ0VoUHd5eUZqenBnc0lzUmUyRE5kMHBKT2xxWmpYZ0s5?=
 =?utf-8?B?RWd3QVFzNXVJRktLVEJ2STBtR2JIT2QxcHRkQlJRcXJBWVZBTXc3UmNFZFlT?=
 =?utf-8?B?VkdYUkdPVjd6ZmpPL0htSDVmV2t1WlJITXIvemNNVzZVZ1IrZC9YaDdrcHA5?=
 =?utf-8?B?OVFTVkVscFBhaEFIMzE2OWFUQWF2NzJkWEtOWW41Q1dPL0puazF2MHZQQWhr?=
 =?utf-8?B?U3JCUStZN3lNWnR6RzhUUWk5UGYzNUl2cC9rMGljRFgxOWx4OXR6cW0rZDBX?=
 =?utf-8?B?d1NxRjBCdHVreTFoWG1iSnpCbTZnY2g2UCtzR3VsanpxSi9nT1JaVnRKVVdG?=
 =?utf-8?B?MUlwaHJodFBEYzNLRGVVaWlkc3N3cjMzcFdqQXRIaGkyRDI5WG5PZXNFWnVQ?=
 =?utf-8?B?TGpnWkltUGFhYjhVdmdqY2hzNStFOWZoMVJoTHVpSXcwMGNrOW5RVGRxYWpu?=
 =?utf-8?B?WDdjYXBMTUFVZzV2RDNzalZEWE9WQ1hGc1dFZDFRd2VudTgyL3ZIaURnZW50?=
 =?utf-8?B?QjRmU3ZJRTJqQmw2YVJGanhxYTdPakhBOW5zSE9vTWF5UllGekkrYkh1ZGhP?=
 =?utf-8?B?NnJGM1g2QmdOZHYxbWxPNTQzTU9xVzd3OWlESExuVVExbzJ2ZEtkM2phWTY3?=
 =?utf-8?B?dGdEbkZMVXUwK09VUkhPaW41aEF5WlNkT1dtcTRLaThpNERBaDIyNHV0Wmlj?=
 =?utf-8?B?UUVmQ0hsTHBxcVY4cGdKVW9RQW1vL2cwSGtia2RxTzFNNmU0WkdHcHA3QURE?=
 =?utf-8?B?MGdEdGIxTUdXM1JVSzhHekc4aTE2NUFWV0RPby9QeGlBV01icDlMTEo4aCtm?=
 =?utf-8?B?NDdrWG5tVTh0UHUwanFMejZua09HOUE4ZUdHZ1hFbWpiNXpnQ3ZrSHNndW1E?=
 =?utf-8?B?SWp1c0JTaEwrZzlISTJiZDN5Ynlja1BaNjAxMVE3RXBGSHJpZGZHYlJwcFZJ?=
 =?utf-8?B?VGJnTFV0akROc2hIcmpvRUJmVnRCNkpvanZkOEk1NWxiSzkvWCtmcXpiUCt0?=
 =?utf-8?B?NE9nREVhWFlEcnVJL28vd0Q3TjhvSFNGZGZXLzA2aGI2TGNLalg5OXJRN3lS?=
 =?utf-8?B?ZGtqbDRrNHk3SVJtQWh1bEE2dWxwSTkwaE12ejA1TlM3aThUTkp1V3ZHaXVa?=
 =?utf-8?B?SjR6SHg1azdTaGV2NVpCQ2lmLzdBWjVpL0RJYldQWmFlUlBGZmIzeUhGU2xa?=
 =?utf-8?B?c1hpV2FOa3NjSWVJcGFRNkFCQlVJVWx4enlzL0RKOVBHL2dsVEJ5eHJsNmg5?=
 =?utf-8?B?bzlnY2xtNUw1OUNmZDdRYW01OUJnNm53eGh2aHBNQVdZQ1QxdFdGa01SdEd6?=
 =?utf-8?B?L0k2V2VsTHhrS0paRnJIaW9mT3FXWHg4ZThGS0lzcTVTWERsK005bldCajJs?=
 =?utf-8?B?SXpRN0FadWduQVlUT2ZYNjJCcXRtbEkwMExlUlJhK2RTY0k2M2U2UUNkK2t4?=
 =?utf-8?B?b3hiWWRaRDgvL2pOMTR4ODVlWDRNeGtLMnpYcFZkRC9rVU9HRXUxVXQzNlBE?=
 =?utf-8?B?bGNtVDJjRXlBQTltTTlCbzJLbk9GMXBORkFKeXJWcFB4V0NNNC9uUnNyRWNS?=
 =?utf-8?B?QzhxQTQ2Z3A0VjBvaU5DRVFTajNZRU81cDdkQ0h3TktzeWhPeTJ1ZzVUZmUw?=
 =?utf-8?Q?lWXQUK9+mpKNP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJCU2x4MlJTcDRmWSt1S09MdUFMcjl5dEUzcW5yNVQ4WVFDeEtyTm1iL093?=
 =?utf-8?B?Y0hHS2FyREttbzI3bGswVXZIb2VUVm9QRFREYS9rbk9zMzA2WEtXV0hRR0M3?=
 =?utf-8?B?UlhhSjJXK3NFZFV1Vmc3R0s2MEUzWXhaZE9vR3h1dHMzbHBnMTkxWlhYQ2FP?=
 =?utf-8?B?NE5KMldwUTZCWlJxS3ZHSnE3NHZKeVpFZ3MvOS8rWWpEbmx6d3JOSnJia2NP?=
 =?utf-8?B?Y0tHeTlTMHNXNll5WnljSVdoMlRmKzN4SFMzbVVRRnJ5clNJSG9iLzRSQllS?=
 =?utf-8?B?Z1kyeEJYYmFDbjdEdnBLZGo5eUU0R3hyOGo1SUplQ3ZNRGYyTFl0TnhJT1I2?=
 =?utf-8?B?OHlSZXJHNXppV3Y3d3o0Y2VzZzl2L1o4bmE4MjNLMGhlMVdIOFQzKys2U2cy?=
 =?utf-8?B?Nnpvd3p5aTRBN2doaEZUdUg5V1h0anVKWG1DVm1HVDcvWHlLSFhpT25XVmZH?=
 =?utf-8?B?TGFMbTBFWEt6MkVYZWtXbkVQdVNOc3pPRllHN1FzWk5ydHBRTEJZdGxGSDlJ?=
 =?utf-8?B?MjFhVXFSV1dRNFV5MlhqNXY5TGFxZVU1QmJPY3BRdDYveTRzcks1QThYMFBn?=
 =?utf-8?B?WTliOGx1YkJJZXBUczdtQXd5UVdMVTNobXRoUUpaakd1Q0xGWUhLVy9LMHVh?=
 =?utf-8?B?c3U0UEx1Uk1GZUZQczNQbkpIU29GN3ZIeEx0T2dzeUZMVG4xaHI3Z2hOTGVJ?=
 =?utf-8?B?d0YwZWJxQmVyU2tPcXBPQjNOODhacFJXZ3BnZWRwdFhYUGFWVVpRbGMwL3Bh?=
 =?utf-8?B?bzBVYmpqaVR5VEptSE0rbEhCQTh1L1BYTVltOUpFczNncjNDckx5K2lWNWcz?=
 =?utf-8?B?eGNJNHpzMUh3S0pMZ2RacDVjV0RBNk5MR0tRNTNyNk5Pb25QZjNUVmZiaVZZ?=
 =?utf-8?B?ei93NEJDZEZmVmhIQU54Y01TQkdKZ3lWS29NNGFlVnRtMkgyM3gzamkxSXNE?=
 =?utf-8?B?NTVCVnBKMUhGVTJSQ2M4TzFJc0RLMHVnOUpOWTdTS2VvU2dmL1dsZDFNbDMy?=
 =?utf-8?B?eHlFUUxuR05ldWNSMVJvY3dNKzY3NnlSbm91YVF4WG1DTDFjV1ViNWlSWDNI?=
 =?utf-8?B?VU1yQWY2anV6OHpnWU5VTm55eFA1TzltVWJtSE5OQTJvMWpZbnFybnEwNVZq?=
 =?utf-8?B?emY0UDlMS1hycmhTRWF5WHFUTllqNmJBTUd6MERvMHNLTmU5U0phanhObWJJ?=
 =?utf-8?B?ZVhaWis0bml4eENtRE9ORjlrUDc0UVJja1NmdHlQVWE2a3BvMk04V2p4VWJF?=
 =?utf-8?B?blh1QmY4OWRaWWdmUmFUUFdINUlWZndKbjVWaXNqcjNLMCs3OFBtc1V1TGpx?=
 =?utf-8?B?b3pUUHl2SXNpcEJmNzNmVndDQjZSOXByekxTVlZDeE5WRDRKZzdFY1JXSzJ6?=
 =?utf-8?B?YVFVN1QzR1ZzQXBFQkZuejd0YTd3bWR3THc5bTVzdzdGSWVOUE1QVGtpd0VI?=
 =?utf-8?B?Yks1aFJzQTRtcDF1a0lnQjNPazhYNEVUWXBOaDhva0Ivd3lyWEhRdHU3ODNz?=
 =?utf-8?B?enlBQlNjVTNIaUpHK3hKMnJOUU5Qck9BaExJWVdkT3kxeEI4dERIUDVtUDNy?=
 =?utf-8?B?WlJrNC9qSUlXR2lhb09kS0VKTFRUWDhIelRTb0dQcGFiOUV2R1R6aWx2NGNi?=
 =?utf-8?B?SE9XdXFVUm84aSsvZnhoV2NVQTFib3RETk9Vbk5xaEtaRDkyOFlZRWxDRFlt?=
 =?utf-8?B?TWNUeWczTEVkLzFURlc5ZVRyTjlMT05uRFo0M21wbFpvMkJlTFN5NzVNK1lQ?=
 =?utf-8?B?b2hsZ1IxaW5DRUs0ZzR4Q1lOSTg1NEJTbkZuci80QUJNbE5PMjdJNktnMnNl?=
 =?utf-8?B?Rzd3SXI2T1dQWWFVa2pYbHdYOENObE5sMjdGN1YzUS9UK2J5bjRZWnU3OHJu?=
 =?utf-8?B?eGl6ayszSmZPUkNydVFsc1lDZkVhMENkU3NNOVVzVlR1cVR3SzFXNXo4YkJJ?=
 =?utf-8?B?VDN0U2pJUlVQdWtOK0NNd1NUZWlWWS8rY2ZFNkJpRURwU1plTXBnazl6cThw?=
 =?utf-8?B?TUNQc1ZtdWNadUN4Z0duM2VRVHFyNDNYeDFSd1U4Q2kyQytDbXlDdkJIRFpZ?=
 =?utf-8?B?TERpTmt6eDgzdHZreG90WWlRa2tFUkFVWG53Ni8wMS9Tdko3Z2REbVh2TXJS?=
 =?utf-8?B?azJxMkFsWEtIZVJIZXoxNnZVTGdxajFFcS8waWZWMFV1TzZQcFhwaXJvOXo4?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vvqo5bkrzhH2//GvjOVbJu5gfGPKaVHE2ISsaBexIIMOIiS/352cF3G6VaedajXm4McQkN8LYPMLIBhhgbbpWsLPKGr5nl1jZVSaZsxEREvcyDeK924ovedFrG6akzJUfyAf2tQZPdagp3OazZC+v1Q1b5ojRVEVs9ET1jHwUe3LlLWm+Oz5/vwrirSS9du25ccs9u8ko93bE/dHEgdqpVzCUhDESHruFRA7DoCyw7zjerUDNiO2AryBi8IWlmRluIFKsTihrAK7oRHB1FBfU5tJqHHvBF54KEcMvIa6SU5/LcAZGRnxsSgf2rHTlk8Ecc78GLCqgSHa5bPm9B5cXsGvsoqmoEZdHoSor1OAhOie2MD8yCs28SA0LpiHwkN+iTv6bRaPPW9o6PeAzLmx9wc7aU2zCC05ruAWwE6E04FZ3zjE8x/jg07pJ2VCc12Y+t+TXxajPt1ltltsceQTc+487lgSGpTnvixdmhmwh5hGAPcKMrWH4bCBV6tUndaA0o2mA884L7lf00vkATMbrlMFEt2CdqiwnN23k/ufsIc3pv/fBnHMo1Ajfb/j8bLkxzKtfmRR9lZPnxzMvgYkvIXNjAifFWcF00J91/l2RUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cce59ab-a29a-4456-3c4b-08dd3ed80dc8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:39:42.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8i46eD+bZkKKNH1Q0dJGkbkBaGJU6V4T4NwsCrfUwSEmjYgt13AfkcHk6mdarwE+dTxeXIjvJF9eDi2x+yfPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_06,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270109
X-Proofpoint-GUID: 2mrERs-WLlwoLkm9LKC4lXind9OoLt4R
X-Proofpoint-ORIG-GUID: 2mrERs-WLlwoLkm9LKC4lXind9OoLt4R

On 1/27/25 8:32 AM, Jeff Layton wrote:
> On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
>> On 1/27/25 8:07 AM, Jeff Layton wrote:
>>> On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
>>>> On Mon, 27 Jan 2025, Jeff Layton wrote:
>>>>> On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>>>> On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
>>>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>>>>>> nfsd_file_dispose_list_delayed can be called from the filecache
>>>>>>>>> laundrette, which is shut down after the nfsd threads are shut down and
>>>>>>>>> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
>>>>>>>>> are no threads to wake.
>>>>>>>>>
>>>>>>>>> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
>>>>>>>>> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
>>>>>>>>> svc_serv is not freed until after the filecache laundrette is cancelled.
>>>>>>>>>
>>>>>>>>> Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
>>>>>>>>> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
>>>>>>>>> Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org/
>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>> ---
>>>>>>>>> This is only lightly tested, but I think it will fix the bug that
>>>>>>>>> Salvatore reported.
>>>>>>>>> ---
>>>>>>>>>    fs/nfsd/filecache.c | 11 ++++++++++-
>>>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>>>>>> index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd750f43239b4af6d37b0 100644
>>>>>>>>> --- a/fs/nfsd/filecache.c
>>>>>>>>> +++ b/fs/nfsd/filecache.c
>>>>>>>>> @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
>>>>>>>>>    						struct nfsd_file, nf_gc);
>>>>>>>>>    		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
>>>>>>>>>    		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>>>>>>>>> +		struct svc_serv *serv;
>>>>>>>>>    
>>>>>>>>>    		spin_lock(&l->lock);
>>>>>>>>>    		list_move_tail(&nf->nf_gc, &l->freeme);
>>>>>>>>>    		spin_unlock(&l->lock);
>>>>>>>>> -		svc_wake_up(nn->nfsd_serv);
>>>>>>>>> +
>>>>>>>>> +		/*
>>>>>>>>> +		 * The filecache laundrette is shut down after the
>>>>>>>>> +		 * nn->nfsd_serv pointer is cleared, but before the
>>>>>>>>> +		 * svc_serv is freed.
>>>>>>>>> +		 */
>>>>>>>>> +		serv = nn->nfsd_serv;
>>>>>>>>
>>>>>>>> I wonder if this should be READ_ONCE() to tell the compiler that we
>>>>>>>> could race with clearing nn->nfsd_serv.  Would the comment still be
>>>>>>>> needed?
>>>>>>>>
>>>>>>>
>>>>>>> I think we need a comment at least. The linkage between the laundrette
>>>>>>> and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
>>>>>>> doesn't convey that well, and is unnecessary here.
>>>>>>
>>>>>> Why do you say "is unnecessary here" ?
>>>>>> If the code were
>>>>>>      if (nn->nfsd_serv)
>>>>>>               svc_wake_up(nn->nfsd_serv);
>>>>>> that would be wrong as nn->nfds_serv could be set to NULL between the
>>>>>> two.
>>>>>> And the C compile is allowed to load the value twice because the C memory
>>>>>> model declares that would have the same effect.
>>>>>> While I doubt it would actually change how the code is compiled, I think
>>>>>> we should have READ_ONCE() here (and I've been wrong before about what
>>>>>> the compiler will actually do).
>>>>>>
>>>>>>
>>>>>
>>>>> It's unnecessary because the outcome of either case is acceptable.
>>>>>
>>>>> When racing with shutdown, either it's NULL and the laundrette won't
>>>>> call svc_wake_up(), or it's non-NULL and it will. In the non-NULL case,
>>>>> the call to svc_wake_up() will be a no-op because the threads are shut
>>>>> down.
>>>>>
>>>>> The vastly common case in this code is that this pointer will be non-
>>>>> NULL, because the server is running (i.e. not racing with shutdown). I
>>>>> don't see the need in making all of those accesses volatile.
>>>>
>>>> One of us is confused.  I hope it isn't me.
>>>>
>>>
>>> It's probably me. I think you have a much better understanding of
>>> compiler design than I do. Still...
>>>
>>>> The hypothetical problem I see is that the C compiler could generate
>>>> code to load the value "nn->nfsd_serv" twice.  The first time it is not
>>>> NULL, the second time it is NULL.
>>>> The first is used for the test, the second is passed to svc_wake_up().
>>>>
>>>> Unlikely though this is, it is possible and READ_ONCE() is designed
>>>> precisely to prevent this.
>>>> To quote from include/asm-generic/rwonce.h it will
>>>>    "Prevent the compiler from merging or refetching reads"
>>>>
>>>> A "volatile" access does not add any cost (in this case).  What it does
>>>> is break any aliasing that the compile might have deduced.
>>>> Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
>>>> won't think it has the result of READ_ONCE(nn->nfsd_serv) in that register.
>>>> And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
>>>> won't decide that it can just read nn->nfsd_serv again.  It MUST keep
>>>> the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not needed
>>>> any more.
>>>
>>> I'm mainly just considering the resulting pointer. There are two
>>> possible outcomes to the fetch of nn->nfsd_serv. Either it's a valid
>>> pointer that points to the svc_serv, or it's NULL. The resulting code
>>> can handle either case, so it doesn't seem like adding READ_ONCE() will
>>> create any material difference here.
>>>
>>> Maybe I should ask it this way: What bad outcome could result if we
>>> don't add READ_ONCE() here?
>>
>> Neil just described it. The compiler would generate two load operations,
>> one for the test and one for the function call argument. The first load
>> can retrieve a non-NULL address, and the second a NULL address.
>>
>> I agree a READ_ONCE() is necessary.
>>
>>
> 
> Now I'm confused:
> 
>                  struct svc_serv *serv;
> 
> 		[...]
> 
>                  /*
>                   * The filecache laundrette is shut down after the
>                   * nn->nfsd_serv pointer is cleared, but before the
>                   * svc_serv is freed.
>                   */
>                  serv = nn->nfsd_serv;
>                  if (serv)
>                          svc_wake_up(serv);
> 
> This code is explicitly asking to fetch nn->nfsd_serv into the serv
> variable, and then is testing that copy of the pointer and passing it
> into svc_wake_up().
> 
> How is the compiler allowed to suddenly refetch a NULL pointer into
> serv after testing that serv is non-NULL?

There's nothing here that tells the compiler it is not allowed to
optimize this into two separate fetches if it feels that is better
code. READ_ONCE is what tells the compiler we do not want that re-
organization /ever/.


-- 
Chuck Lever

