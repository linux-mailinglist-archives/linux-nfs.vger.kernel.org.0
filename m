Return-Path: <linux-nfs+bounces-9692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7DA1DAEF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444AF1669A4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40017E918;
	Mon, 27 Jan 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IL5RZscw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HyYBTUNd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAD433CB;
	Mon, 27 Jan 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997287; cv=fail; b=GVhZ/7+UubWlfzl50+CwMa7kJt0ns/StAHTJXrRPqqQalQu0F3iA0f7Md5/sO9S/1wkQ7M3msh20COmwZraEEQ90wCkgH5Gz4QnS2brTCJPWyabZKcWx1mKG1pfaS+CrGc3FMF/wGmYmMRs21YZ12DBGIiJTRKAvl9ySCuSXVk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997287; c=relaxed/simple;
	bh=BZlHj6A2x3uHRHk1s1viafZxIh1+kL1dGPcl4uk9Xi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mM16fG85QkU1IjZITwdxUtjgKD/MIDdUN748usweGLC5hNOxZ/K8jsCmtUVJ+faW5KM/zZJU7123FwbLgnVGVmD1EhSEjjMETLn3Z/Dd/cUUoHz3XPIDLOxrkPSmGTFI3eGeb9GRh79pMEuYGMgC1jQchN3XbzzyXnjNNLOdJpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IL5RZscw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HyYBTUNd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RGb7jb019308;
	Mon, 27 Jan 2025 17:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0xlmentBrGE7ErmgWS2Ay/PodMop7BFS9SJLS44eh+Q=; b=
	IL5RZscwzoPQ5pgkdlhrMTiWJa0vPtPRSSBdoeKmtV/TvNdqTNemzjJNgDgd/ifM
	hZT6ecjrCcW2Nt2oJqMYX8lCnw9rqvf18hLgnZiJBhaEOPkQUb4h2w80Q6/cgDmc
	WuzXMg/RD8rUJcwMHHqQXiajmpAcSr/NneZcLx7CwUgIgYcKIixWNT26T7oyaLxi
	sADoifg8jF3nKCcGA6/0QhDf3HM0ZykLiyQpGb8HtnN+IKXXnApFm4USSh9yjYia
	cRilB9NXtQxVRk3ReusMx7112ZeT+kIoizpfCLDhji2ZHRfRbSf22CVC7Twwax+P
	dobi+Gzt4D9j+taWY0lIZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44edtn020t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 17:00:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RGtFAe037021;
	Mon, 27 Jan 2025 17:00:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd76up1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 17:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRWl+N2HhCGB93h/rZ9/ERtcAhfOVRsPb+pzArd8akHpP8zgloE06yIW6fUA0ssuMAlQqgmqe5BFQMFG9HUIedmomQfSkR3C2NV30gE6ak39KyuaxBfQdV9s14fcd9bkOPY2PqhBpqKWkgGmteOEBcnBJBg83Z5tG83zn4lt5b8ev0jDbtwMpUFfHJvBi7gTQ8ZEXFh++EoaQkCNCeWgaol+2AX8euJuYz7t1g2D2btOHi6zHo8HQZzAttt2DrtsIkECnAOkL+dtt5YJFfRJq+zTBdJgMnfp4RvijwSk3RBPjJC4HZdab5wGLdJcfJ83xnWRloJKfYXJiSiVF9JQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xlmentBrGE7ErmgWS2Ay/PodMop7BFS9SJLS44eh+Q=;
 b=JJGTVmjMaIoIkhcJOhxpM33f4/T4jB2FzE2FN1U5anUB3xFbLrT7kzmkmtRaWc6zGEUVSxssSDv7doTq9T0Km+D5YgB0PiqfBflk2YMgCQ26T4rtlr5sKvAKJizZFEdOUkmVn5M8R3fzo8D9E6EfUQrwVDzJdOjek5lyEXFXA3LMRILDgk7bDx4JWe8gy6SB++APQyNdamJ4E+M9xGqeDwpl5dP2Sj3Q4ORnlx3ik4G1pYO0cEVepbAmGAczfLwXdX44C/U6/Y23/DxF4jaFUvWwiD9T0+Hopdqe11YIbDc91gWTT1ItTRK+Z0SBHSR5K7v5gmzZBe3vCZoCl0olWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xlmentBrGE7ErmgWS2Ay/PodMop7BFS9SJLS44eh+Q=;
 b=HyYBTUNdH38qObZzdhy7vdA1PiZBzSiTEzqvY2izuYApb4AzO7Pvs68a+HPYmbl+RL67h7Bht6JuBaO836ld4Vie5/RWNAJkYucCH94vhachcjCwsY1trs86nXYA1KJEIBF5WppHxy241u4NviYdJLRExWuxdfsbhAmaTo4uylU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 17:00:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 17:00:56 +0000
Message-ID: <f3928cc6-66d5-4dfc-8178-d4b960550dc7@oracle.com>
Date: Mon, 27 Jan 2025 12:00:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nfsd: don't restart v4.1+ callback when RPC_SIGNALLED
 is set
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
 <173784610046.22054.813567864998956753@noble.neil.brown.name>
 <d52cf9b9b83753434c1b0098afe1b77bf65590d4.camel@kernel.org>
 <ac5834d4-1465-4dde-a451-b0804c537f04@oracle.com>
 <7bf69557c04b6c9084cdc153f30bd3ac7cb48065.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7bf69557c04b6c9084cdc153f30bd3ac7cb48065.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc5d146-0027-4eb8-7486-08dd3ef42a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTNZSGlqalRPVGJWbEszZlQ1SXpmL0liUmlNOXpCMHZFNEVVRjBBYy9kM2RG?=
 =?utf-8?B?ekpRTGhzWmFkbWloU1lheDRJWk9hbjZhNm9USUhKMGdZZDNEdmNvZTVNYlFy?=
 =?utf-8?B?bnJ0YXByMkFabjNlNTBsbk5EYjRNTDJDQ3dPS1dTMW5IcFNXcE8zMHhpZ0ZQ?=
 =?utf-8?B?VTZzR25kNFpzN0xrTkthdEpudTNPU2Rpd29qRytUTEc1YldvaVJ5SFRCdEVC?=
 =?utf-8?B?OFhKSzFMUnpwZmR2TXd5OFVwRC94VGxvZnB0RlVSWWk4Mm96TFdRMEhQMmpy?=
 =?utf-8?B?c3ZNUVVhY05IUW9xKzB1UWcrejVKY25meVdHNzBKclZ2UWxqUCsybWtOK1J0?=
 =?utf-8?B?VDdjK1dXRVhBUjRZQVpIeGVTeHBsM0x5L1ZDdmFPU2x4bmh1Rmg3L0k3V2JM?=
 =?utf-8?B?a1MwWlhZcDAyMFEwaGc0TzF2ZDNHR0VZNStrdjE1bVpXaDhzVFgvemJYbnhr?=
 =?utf-8?B?d20vWUtqSVlERjBlMllDeThNVWZCV09RUHNCRXFjUFVtcHJJaUk2d0dBRGg3?=
 =?utf-8?B?WVVGd2ppVGRDRjRIa0c0aTArTStYemFReFhrcmNRbXRLeklxS3BCdE0zQ3d5?=
 =?utf-8?B?Z3UrbzJtazBXRnBlSk5mbTk2RjRibmcyZlBsbkhFRlFLRjQxNE04bTcrekFp?=
 =?utf-8?B?VVpMb1NLcGs2VG1nQ3dBNjBCbFVvcnB3Y2ZJWVUyVzNkVzhkcjVFK1A5WDVD?=
 =?utf-8?B?TTNXZXBoSTdmQksxSTFzOCs2aitzNXZGVnJyNXROazZFS3B4ckY2YnJmZFlh?=
 =?utf-8?B?Ym5ERkhMTmdjdUdsNVpjbjdOSU5nbStRSUl1bndTUlliaDZ1b1MrOC9xa0J3?=
 =?utf-8?B?WEFOWVA5b25CWXZLenJyOFg2djFBbnBRVzgybklITWJPbW4zdFJwalZZTVZ4?=
 =?utf-8?B?MGtHMFcwL1pDRmtMMGIrZWdadDUwM0tlaVBrWWMybURiK09FLzE5SHVlQjZ4?=
 =?utf-8?B?M0JxN0tsWnROOXNyZmVNamhLYVMvR3dTZ1ZpK0U3L01UcHNrQ0d2bkwrSUpo?=
 =?utf-8?B?KzF6d3Y2c1MwVDl1bDZ6dUZOU0F0bGEyMVdLUzlwVnIzVE12QWJjak0zYXZZ?=
 =?utf-8?B?eFl2dCtMUFdxdzVzNytkNlFSOWxYS3VuS0FveXVBWmtMKzN4U0tlTlhFbnNm?=
 =?utf-8?B?a2dGNnB5WHRSNVpHaEc3cjBDRlp4WHZCYmFMRWNlL1ZVUDRtRGJBNlJYd3hs?=
 =?utf-8?B?a1M1NlVaSGJnQWhOTWpvK1B4V1VaZFBCUUFKN2F4Z3dxWG50cDNDa21RaFVS?=
 =?utf-8?B?M1JMZitPK21QaThyTis3Sy9oMkJ6bU9CYnNvbDhZenJpa25YQUtLL3ViZUht?=
 =?utf-8?B?VkY1Zlhpa01yZm5jMzdiWHFwcWpyZEhubU4rYXpteGh1ckhQd3ovZHFPT0RI?=
 =?utf-8?B?bkNJeEh0cHRtMS9xUUI3VzduSU1mRXBBby9ia0sxS2dkdklUbDJpcjdHL2Va?=
 =?utf-8?B?eXZnanlIYW9vT3pPMDlLRFJyaE8zaHdKYjVYNElXc0toWmxZWUxZMm0vSzZy?=
 =?utf-8?B?bWtXZkhMSmJETEs2cjEwK3VRbHQzbDB3MEVwaGRyMW1oVUQ1ZWViSTJlOThZ?=
 =?utf-8?B?b0F4NXNaNG8rRXlnUXg1WmhtS0FKeEI0UXVsTkR5Q0VTaUtFcFpQTXZKZ0Vm?=
 =?utf-8?B?TXArUktJUUhJWDc0OVdha3ZyeGtnbnRrd2Qyb2h5NG1udU1IWWdFc2J1cHNN?=
 =?utf-8?B?YVhsUkVUY1FMcXlZQVNTVC9HQmF6QTFTT2pCMUp0czA5b2kzY2ZubjFEakhp?=
 =?utf-8?B?WkluU1p0OThadllGRjIrMDdVNkdnMkltMTM2dWM4ZXBCTGo3RnVOamcxYklP?=
 =?utf-8?B?bGFlV2NRdW1JUzRxbllRamphWWFqNXdpZTI0WWhLckhFd0s0cGIyZnYzR2Z1?=
 =?utf-8?Q?FSTaWIiaWHOE/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXByWlhLWjZWVjBnSjZGWm9hWDVJQkIzZEZqdmFFdXZ3QXpTVURKWVQwREpU?=
 =?utf-8?B?cmJ0WXg5Ym5jT1BCS3RTcjhjZm9UQXhHYlRPc2I0eTJXL2xBaXJmWXNFSnI2?=
 =?utf-8?B?TStzbzZWM1I3MllTaUxXbGk3OStGUTF4MkJwZ01Bd3NrTGRpb2hsZVVqY2xs?=
 =?utf-8?B?ZE9vQ2ZRRkVrc2dDRWk5WWFWcklXODA5Z01vT2wwUHVYSGt3Z3N4VHBhOUFQ?=
 =?utf-8?B?R3ppR3ZiTXZUVzl0bFp2OXE2Q3FwQk1kRFlUMEhaYjJZVFdkam5zc0ZCT2sx?=
 =?utf-8?B?ZVRvKzRZWHA3dzBhZWlkVWdQWmM1Z0xXN1QxYTRtQ1lxRUZadmtNK0QwOFh3?=
 =?utf-8?B?V0dEK3pLUzBMeTRETHJlVFRhb2xwQ2RpdCtpNDFxdE0vU29kNDk4eHBxU3Bn?=
 =?utf-8?B?alhoUDVEanFYcUNsUVA1U2M4cW9VNEJuRmYxWVk5cWVlZVFyaGlrbGNUdEdD?=
 =?utf-8?B?WXhxNnJsQ0JGYWtSUDZHN2xwWkdBVHJsQ1RqTWhUT2Q1cmM5aExobjBlT0JM?=
 =?utf-8?B?VjU3cjlUWG96Y090UlRkbkErbWt0SWJQQloxaThtcnVwekhzQW93T3V5L00y?=
 =?utf-8?B?WTFDZXhYS3pqK0M1akhyaWJhcERNSlVYaXFQTDJTSjRxN0FJNkM5aEJBdHRE?=
 =?utf-8?B?Zys2WmJ2RVRMMEhYOGh2OVpUd2RCUjhaMDE5eTU3ZFk3TTdrb3ZLMzB4NFFl?=
 =?utf-8?B?S1hxbHIyb0g4TEZPT0pESlZ6Vk9ieGEzdjk2cDcxeTRuVUNscCs1S0RXR1lo?=
 =?utf-8?B?dHRmTWlydHlDL2JKbVRQUlByTEUzdGQwTzNyZStheWJMOHFzd2R6SWp5WWpE?=
 =?utf-8?B?aHp5b3NOUUFuMnpobURQcnplVHZ6V0k5YkI5VTVNRHdMTVRuNis3R2lON24w?=
 =?utf-8?B?a1NnSVpvWE1oZ1h0QzVsTFNwdVFXSXZCeHd1a0VIZmZEQmNtdE1lYzF3ando?=
 =?utf-8?B?OUJXZG1WaEVDbWlkVGtvMlBOYXdIQkQrNjV0c25ZaitpVVRjcHVsb0lOa0V0?=
 =?utf-8?B?SldBclpnT0h3WlRTQ1VvSFhHY1drUEFXS0RsNWtXbURHd1VQYXZpVVkzY3p2?=
 =?utf-8?B?dkRGcU5rbUFVRmtzVi9VRThvcXhEbGN0c1B4NHA1UWVEUUorUjlRT2VGaUZk?=
 =?utf-8?B?ZzVwYjhFZno4M202RytoNWg0dzV6RFphcGhJbldFOGsvSUF6UlJBRTFJYTli?=
 =?utf-8?B?RTUxM056dzdZa2h3SHIwZ1B2Zkh1cHdMZEwwM1IxcEttdU9UejlsSC94Y0k2?=
 =?utf-8?B?ckJjaFJieVRMbndyaUlscytXNzRNQ2RrdVVWbzdld3NQcDRORVFrK2RkYzIv?=
 =?utf-8?B?bC9UQ29JNVJkR2U0YU5LcWpDdUI1RFFlOTNHUFlteVFmUVBObHFORG0xN1dm?=
 =?utf-8?B?alF1UEdmKzBEUnhBQXhrNjBaRG9NbTF5MjVOSTRWK0gwOW5XbCsxZDNIdmJu?=
 =?utf-8?B?ZXhjVnk1K3hTV0UremVXVUk4K0RPNE9yZy9tanRFNU93RWw1cEQ3eXRrYUhu?=
 =?utf-8?B?T2NWRVQ1azhkZnVxc2t4UVl2WkZIVDQzamxOaTVvZDBEQzZtVXdHdzdRZHZF?=
 =?utf-8?B?SGZQRkROaVZRMmtZN3RYUTk0RzlJWE56Y0sxSWl1Kzg5SERTUjNNZVFJbHJ4?=
 =?utf-8?B?eEpqVVBiWlpEc2N6NjdlTkFNbDZMZnNqVDc1Y2dzY2UrYmpORnprdVJXc1Rz?=
 =?utf-8?B?M0M3ZGFwTnNJOUdrbC96ZldLMWx2S0hXdVVjLzVHSXRqYmc1N0dQMHZHYjhE?=
 =?utf-8?B?Wmg0ck42YnkzaCthbFJaZnRoSjZ6NXhXdmhGUE1kTUcxWHQrRW4xRnNXT0FY?=
 =?utf-8?B?VmJVZkdvd3Q2eGlhcUtLdy9haFJzOVpQU3ljTmxHYnlxZ0s1UXhOSzlkY2t1?=
 =?utf-8?B?ZXRmU2dwaldrRHlqeWZITzNtTnlycHEra2VwajBKRW5HRDVrd0EraEhBSDBH?=
 =?utf-8?B?cTFpam5ITnFDbkhPUDlxMkl5TVJXYWNoOGJkT2xHa09ZS0NxMm81UFhKWXU0?=
 =?utf-8?B?dTE3TUs4K1NCbFBBUC90MEU4T1lvQUlYTGVXTHZPYmpodXZiR2lEUmpkVjdz?=
 =?utf-8?B?MnFITGdxTnY4bzNmOHdabktpK3hqNkFqM1NBK3pURWt6dDNFWEV0OEpyb3Br?=
 =?utf-8?B?ZHN3akRxcEQ4RFBXRnhVTzhia21oNkVETVovL0lNMlN2YkM1NWdpYUoyU0J6?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BpuoQOdWQnfr2xWSVms7q2FeAaxcH3XZxhdry6vqt/CkHss/9yoxj8Yn3LBUrnjH8m2ygcl5WuxhmmJSy51XWmfi8s2T1P8igZsY2RBEOO4CK9/InRycTxM9gyVLuDSe0Wybm0asHC+jeWaCftPAbitfEHytkFJNYVsTeMcJWhKCGGqO4TPaSZ96X++Tyt1RODUps9b1rxvZb9IPZY9kjZMFWvg53rtj19kJ46nZVFNOY6tkbQ+o+df00Oi4gHtrbHWzGcFnXjRNY2qj/oDzRiJZkeTB+MZmI8NwYVA2yVruoo7xDOux/TOvnaGM4WgRqwqNQZHV9Uqod5to2CuJLyFx2v+q/aJtuA9ZCiNWAIVOs0u5OZa5QDLHmLxQrXcqKwbadM+nZwbO7FGzmxWGCw0pzSd4tyzl9Gc3rFtXiOKfMEXvZwS5YpnoTbY4yGYXCqLJG54JQrp8m6KZTFCZAXAVsDqlybLja13uPrhtjz3MvYt38jMIhZxBlHwjT9iIeNVaG6zDJPdmunwTUWpz0GjUZm2FLubWt7CAwTMbvni8INTTWc4rTkUrLIgBWfjEo0yPuV28B4OowpNHQ2pcYELdMlO7wNodZ49DyqhqZbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc5d146-0027-4eb8-7486-08dd3ef42a4c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 17:00:56.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHkh/RLU+Cc07DlinhbUWfqaw9mghT6ogdc9VFRvjvCtO+LLJogTQqG55X8xIotHH60f3iNQLHzosphB06eftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270135
X-Proofpoint-ORIG-GUID: qdUN-3a3rZngrtfNcdtteK9NgpjZX5FO
X-Proofpoint-GUID: qdUN-3a3rZngrtfNcdtteK9NgpjZX5FO

On 1/27/25 10:43 AM, Jeff Layton wrote:
> On Sun, 2025-01-26 at 11:41 -0500, Chuck Lever wrote:

>>    - ESERVERFAULT: SEQUENCE was decoded but failed sanity checking. The
>>      reply should be dropped now, and the session marked FAULT. No requeue
>>      is ever needed here.
>>
>>      [ I question whether the sequence number should be bumped in this
>>        case -- the client's callback server replied with the identity of
>>        some other slot. And anyway, this session is about to become
>>        toast. ]
> 
> It didn't necessarily reply with the ID of a different slot. It's just
> that the decoding failed in some way. 

My read is that if the XDR decode failed in any way, the decoder sets
cb_seq_status to -EIO.

-ESERVERFAULT means the decoding went fine, but one or more of the
session ID, slot number, or sequence did not match what NFSD's callback
client expected.

It's not the same slot if either the session ID or slot number doesn't
match what the server sent in its CB_SEQUENCE Call. That seems
equivalent to BAD_SLOT without any question.

If the sequence number is wrong, then it's equivalent to SEQ_MISORDERED,
maybe?


> It could have been any of the
> cases in decode_cb_sequence4resok(). Maybe that function needs to
> return more distinct error codes so we know what was mangled.

My preference would be that decode_cb_sequence() should simply
decode these fields, and let nfsd4_cb_sequence_done() do the sanity
checking. I don't think decode_cb_sequence4resok() should be doing
any sanity checking beyond "does this unmarshal in the space allowed?"


-- 
Chuck Lever

