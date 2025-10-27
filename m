Return-Path: <linux-nfs+bounces-15710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79759C0FDEA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 460DE4F04B0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19023126B0;
	Mon, 27 Oct 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RE5tq18+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KA1Cuc56"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA630BF6C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588804; cv=fail; b=YwWpMl76HTfQn/Dr/coG1n+25tpV44/sDxa096FkvGJOJm5fjW8q82zBRT2Jv0ae3+uTrLinPO/8k+mdQIB4FD4FNteeoT9UvjxMNmbWZGmQOCm5XP3HduerSTYqllBzygLOU5MViuCIoI///Hkqfb2vBxwhb0z7nRDYsc2z+PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588804; c=relaxed/simple;
	bh=Qzq/D1MyR2S5nIxaD8HRA4sWrWbek6z9prM8YvPCZVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccTyJ7d6yvF6NaJqaz1j9MBNCML/ETTGOQFsg8/F5RWMesAwLW59inhT7IxT+87H0bnMf9BmAc6ZYlut3okUWxDXXB72TMDn9/q2JZQHhJd+Zaf3E6qbbjDvwlIl2aQt+D8erEVDrJBfLv4UqxiVXn9yQSzN9DSM4GujE9lgqZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RE5tq18+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KA1Cuc56; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYAbQ017846;
	Mon, 27 Oct 2025 18:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uX9al4h18gYHYpU7Mc3pMepgM0cu+F576MMfDEcPayQ=; b=
	RE5tq18+bag9xlAtSequPPC6S37NyDTENYpAK4Dn9uX/zTVySIxulhP863A6gSkw
	DVmaoKX+w9SnIaXpPsKS4ZPJGYMJpMvYB8XuVfMMznhsYIq0Jt/QOvheMfTSPxIF
	rHP88hKvAx6ubY4Oi/QRuewnlDQW4QSVEG+UwazbyiPLnduxT8naAk68ET3/+mhG
	pLvLteyKkgBVJ5h6wa2Wi2OAQX73dtsaZ8mkP6eYSfDKvUsfvcjNajFfX8wxusDQ
	Tf5pY6lPxWBlW7EKSxl+Ziiiu8Je1YU7OMJnw6N1/gShgagSaVqXHkNxFHSlJ41F
	l54LOv92vlFt+FVzBmeXiw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ym82c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:13:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RI0Wht016212;
	Mon, 27 Oct 2025 18:13:15 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0759k1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:13:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozAJJRG5Bl5xHC9WGsYepVVGQr9aO3+0WKS4oL9QrEyZVNV6oDoRk1Kc+mBhZ3N4Qs5GGsIlZ0IeVfkJP+nRnYYEhTHjQs/lo5JAi0SdVpJWFDZMVBMBtKQmWPbQgl2d55K2HVFm5oUZ1wiF6mpBjdwJtS77y0DIAMDXR234ex7n8DEeNmxHGEUQGIeGL9kY/2oyr1iHxCxFUTwqINnTPHTqk0aBhkPf8YiMFuCqF6vZ0upvmyNSIYKaOOElxooODBkNINW1fuySX0V4SqyLTW6JduaiZMPsG1h+2Y9AWSfcNFnW4b0dxPmn4Gn6dYJi973XHkM0Dczs4IVefbtCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX9al4h18gYHYpU7Mc3pMepgM0cu+F576MMfDEcPayQ=;
 b=SnBmrTqVcPrvtNHKfNwg29jqXeqb6RIQZVDeG5ddbnJwF0/1Sw3tphyuvM/qgHMyHiNtVcY1DdyY5SOdlzblAYQ9u5KqBCoaxxwCQosaMdmDKsM60Sc5C/UssoZweX3BtTP2AeSVjZ0Z9d3xcuJ9Y7RVyWdVdE6lvCOIwH6myv3WhrN8Lf93C08SDLO+SXXjY7o4qo1CpHrteADm+pzOLgtlnHorEk+KWKRdrI3j4TM93oqYjAj6K2pezgitf6hrk1sz305Wi4twdO8TRE4+W6rj8w6c0EjdptTiAmekXxCiZ19wwCs7MDT2tc7JRsyqWi6Y3YDpqmDDYhyTGYYO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX9al4h18gYHYpU7Mc3pMepgM0cu+F576MMfDEcPayQ=;
 b=KA1Cuc56qePZFnFERRwJY8UsftxXLrWvx4klds2WuaFRVXSS3QAhxAc6u+lgKbZsK2dqteItmSiNvtl9UOmx2wIYj6M5buFgUhECB2lNXym7GeQ2HgNMHcW+JauAnN9aVmuGI2Mr23XYgcRt6Xjz49qUPP3yoeJ3Dmi6OrBFF2E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8167.namprd10.prod.outlook.com (2603:10b6:208:4f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:13:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:13:11 +0000
Message-ID: <a7d27c56-f250-41f2-83e1-4befa144d5cc@oracle.com>
Date: Mon, 27 Oct 2025 14:13:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] nfsd: fix current-stateid handling after PUTFH
 etc.
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251026222655.3617028-1-neilb@ownmail.net>
 <20251026222655.3617028-2-neilb@ownmail.net>
 <c79a95a9ae87f22f77a5d144f4d43072bd32ba4b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c79a95a9ae87f22f77a5d144f4d43072bd32ba4b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:610:5a::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a98e6fe-9188-4b1c-29c6-08de15847d08
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dXFZbUNtT1ZYck1nV0FHU2VuWUhsUWVvcXhBdWhOZWR2T0xGSXRGY2g3ZTQ0?=
 =?utf-8?B?bG5nR0x3bEJtTTJKRG9nSVpFWUJvRndvQzBYZjhKZFBoVGxhYUgwMWNSMHQ0?=
 =?utf-8?B?aUp5Sm52Nmg2ZTA3QVBtbllWU2ZpY1Rpc0NjWHZ2ZG9XVDdqa0xySFBnZUJT?=
 =?utf-8?B?Ky95QUliVytXd3QyZTY5Skc4UGtBYnhpYWUyY1o0KzJDdDBFbTJwcy9VdE9h?=
 =?utf-8?B?ZnNTS1RrZTZ6WUM2WjdQWmh4K2prOUpLOHdpeWlNcmdOakFXK0p5RHJ6Ni9M?=
 =?utf-8?B?NlJNbUw0bG50WTVBTUlHUEs1aDkrNTRmQ3BMTUh6SXJ1bDd4RDAzZ1FsMTBU?=
 =?utf-8?B?ZTFVRjNTVzJGaGFKYTBHdGdLQkQvOUZYSjA1eDhvK2hnMGdQMWdiWlcyRU1N?=
 =?utf-8?B?OWZpY1VGV0JrZmZDdGQ3b0NRaXh5dy9XdnpBTkM5QTZUdUcvVlBFeUllNUp6?=
 =?utf-8?B?Z1NzeVpNQXBYSEhFdHUrelVzQlA1SVAwbjJTSWZMWWc2MUVJMm51V1V4VjQ1?=
 =?utf-8?B?YTRHNEk3d2JsYkV6Y0g1U0lXUDQwb3lCaVF0RGd1QkRiN2pXejlDeFBGWlM0?=
 =?utf-8?B?WlErL0wzODBsMERzcFNKNndwRzVwU0N6cDVCQ242blNqeXBzN2l2RkpOckNR?=
 =?utf-8?B?UERQZzhhS2hwOW1ZckRCZWlzakhXa3ZlUDJCNHQ4Yk9JdTlxZUhYTlMxZ2hi?=
 =?utf-8?B?cDBPVlFoeDBObTNWdTdzc0IwYmM2Ym5xcC9COFJhczVwaVdrb002b0szdlZP?=
 =?utf-8?B?ZzFVakh1L0xwUmticEtqMG5lUXlDdUlxUzgrOTZKTi8vODNaaTBUYVdjSW5p?=
 =?utf-8?B?cTEwL3JHclBDbGVPcUxJWDk2MERFTTZhZU5FZ3NYZFdOMXNxRkU0a0t6aFpK?=
 =?utf-8?B?TmgwQjF3dDN2Z1haYjRUMUg0UjBrbCtTWElzUExCOHR4Y2wrd0RkbGE4YVZL?=
 =?utf-8?B?eVgxTzVWdGRobnZmc3hjdm9zSVpONUxyeTdWR0Y1RjRZRUJUV2hienZxeXFn?=
 =?utf-8?B?N0tUNWtuREVLYkNYMCtqekN5eXBRSFd1R2w0Rll6eW81Vjlsa0s5YzgzOXkz?=
 =?utf-8?B?L0dQYmhqWis1UDZ6N1pNLzVtVGtXY0NoSlltWndzTTBtZHFIZkUzY1BNQWRG?=
 =?utf-8?B?ekxiOS9kUmJmVWZJMHlocGdVUDVDM1lha2E3dWdjU09rTkRCUUV6am9QQmpQ?=
 =?utf-8?B?U0l5am8zdnNoTE5zN012N1paOUgvRFFrUTNtWjBuVTNVamZEcWR0TVFiOVdy?=
 =?utf-8?B?SVU1RCtSek1VS3c2cXgvemthWmZMYVUzaE9KNlJMS2NwNHhGZ2o4YVIwK1RJ?=
 =?utf-8?B?QkNxcGpPUFY5eGptNURkOHJ4ajF1aXM2dy9yQXk5TkZyM2lNU3RJNnFIZTNt?=
 =?utf-8?B?aEpCSWdkbGk0b1QxTW0xNSsrK0JJb2pldUhHK3VLNUhrdVY2eTJta1U5OEo4?=
 =?utf-8?B?S21CQzlVRkRSTnFNRU1tNmR1TDlTR2NybFhucXhqcmNuV3I3WXZjKzhycXR0?=
 =?utf-8?B?VS9ZeEcwdFRiRHpTTnFWWm5nOHAwUjRqcDl5c1JtdEdQRkpGZVcxOGF6aHpO?=
 =?utf-8?B?bWtlbGNOTEJKUEJvYlBvVzB2WWVVSXg1cTBnOW9ZekVDUENCaWZSMHZkUHdR?=
 =?utf-8?B?U1JmeUxka21DNkRzaExnY3didW10bmZoSUFJRVBsS01LU2grSCtWTXhZZlVq?=
 =?utf-8?B?ZlkxbHppL0MzK1Vjd0dEQmpmYytTcjFuU0ptd2lLYVV6bU5weUNOL2ZjcnJk?=
 =?utf-8?B?bWk3cGxnTWlRaWhLZWIyblRYNFlXVllUMWc4bzhGRlNOOVVyaXVQZTJSK0NK?=
 =?utf-8?B?MGU0czdYOTBwejBvNDFhL01ZVDdMb1VMdHY5OVFSa2VVVllVSmFBbHBKSjR0?=
 =?utf-8?B?WVdvNnRtcXVGMjdFUlg4Mmd1RlhOZzM0ckVPQ1c4WTZMQk1RMXp6U2o2cnha?=
 =?utf-8?Q?au99+ZauKXxn9kQaBOn8FY2berSL6r65?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?allmUzA1dVM4ZWoweFQ4akd2aEV4OVVOZ0tFUXBmaWxDZFl0aUtXUUdoV1cz?=
 =?utf-8?B?YUNPUmQ4VEtleXArM2pCMXA3VG9YQlpuMzYrbzZaNEVxeHkxNzVFTXZ0TGZu?=
 =?utf-8?B?Vjd3NHJ4TGdsSFFXcFBna0hrQWJOUGtNWkl6Tk44ZDVTWjVsOUVXa1VzMmVV?=
 =?utf-8?B?SWtXYUp0c2Rkd2VOd2FqNXBtRFNXSEhwNTNaaktoZlVVVjIreWlPd2hxcGt0?=
 =?utf-8?B?Y3FSN0t2UVRsYWgzbEI1ZE1ZZC9rVmN4MjVSb1VpOHpLd05FeUVoNXJCdE1M?=
 =?utf-8?B?WTVueXVBVTgxL1IrRk1lZXd1QVA4RG9ZUEsrSksrdjhmUWhwRGNCSnBhQWFI?=
 =?utf-8?B?d2JmQmJNaC9XK2FGOFFMWXpxa2JzT2xUVjZTbWtmaUNubFR6bENEeTlzcmpP?=
 =?utf-8?B?dmhBMDNRRThpcmFBRVM5NVpYL3dpOG5XcjcyT2tKQnAvMHE0eFVGdEVuU3dK?=
 =?utf-8?B?ODJKVWxQWGJCZEdQeXFPb0czOTZudVhDaU0zUlhLQjd6ZCszbXpyaUJrNWpn?=
 =?utf-8?B?NzJTUVpJaVJJVWd2OXZCYTBKTnExZFFadVFhRDRFZE02M1hMcC9ibmp2dGJm?=
 =?utf-8?B?M3orRHpoUXYycEpxTDJqYzJleS8yT3B2RGx4YmN5Zm1mTkFtVUE3bTdkVER2?=
 =?utf-8?B?UDlCTElEQk54OFlIZStJK3l6WmpGZjVKdHlpL0VJMGQ3d1V6Y3Rtd05hd0Rz?=
 =?utf-8?B?eFgwM2RwaWxFaE0xZURpUHZDYy9ZODlEUUdpSE5vMnBHTENpMXhkWWVyZjg0?=
 =?utf-8?B?Smx2N1hLRmRzTHhxN1daV3NiTk54TW9ST2Flb3hrcHM1b3kyaHhHRVk4dENo?=
 =?utf-8?B?ektOaVJpTHp4eGZEUFJmYno1cGVYMm9kaGlYZzFZZ05RbENaS0dpbm9ZaUZS?=
 =?utf-8?B?K0dVWVdDYUV5R0docEtpa1Z6RzdpV1p5MzU1RXRyRXpZOENWRjh3QTZLeFdn?=
 =?utf-8?B?bHF2dGRJVnN4bFhTRXVGOWx1MXQvTzdnTDlON3gyVXRJWkMvMG5zVmEwT0s1?=
 =?utf-8?B?OU8yclZBdWxWYVAwZGhTdkhsZnVpYWRySVNuYnI0Ri9MQTIzenZFQjBXODhT?=
 =?utf-8?B?VEFLNkxEUEZuVlYycEM1VDgvM1dsZ2E0T21EN3VhQ3pmZ2hhd0dKWThrUjg2?=
 =?utf-8?B?b0psT2VCV2lqVkpxaEgxTXJrWHk5UE8reU9zSG91MGhnQ2E2aDBIcWNKTXdS?=
 =?utf-8?B?U1ZHL1F1RUtuZ1ZscWphWUZKZkVUd2l3b0ttWHU4SVYwRi9EOG5HVzhxSUZS?=
 =?utf-8?B?YTBwYzEzdVFiUnI3VGtreU1LSVNPbmZiREVJZThRMXZ5QTQ5OHBQeFJvUXdH?=
 =?utf-8?B?UFFSeWRkdk1hV09SaHVNdHQ1YWxEakRvOTNNam5HYXQ5c2VoUHJ3K1N4TTkw?=
 =?utf-8?B?Y2tPVUxYaTdkQ0duUFZnckFBK2JPcWtHV25LdmpSUGJLVkw0ZnNLc1BKVFda?=
 =?utf-8?B?L1g5WEVUdExwVllzd0VGcUhWVWp3MGJodEM4YkMwbkpKVWs1SXRVOEcvSlNV?=
 =?utf-8?B?UXNiZE1RT2tWcmlWYWFnSUhxdG5kUjlHaDNlRGJZNmhaVEZKcHJ5WXBUV0xS?=
 =?utf-8?B?cVVVeit1TDM2MVVGZ3lobDI1a3c1Y0ZSWml3UmYrTS9aK2dKbVNQaFc1R0dt?=
 =?utf-8?B?N1JUQnVxdkpNNkdpaUJxTEVEaDkzTnBHeDRzME92VWtleCt5ZFg5NmpYdEha?=
 =?utf-8?B?ZUEyYW9pS3l5ME1xcU80TWs1dGRpeTZDbklRTWhoaW92dGthd2ZwVDZIeTdX?=
 =?utf-8?B?cXZkUDVqWlkxb2xROWtscWZ0UFUrSWJwODVxTkFpemU4b0xYUzVnZTh5ZHI3?=
 =?utf-8?B?RjZpUDExUDVlVHRFWC8yaEFvemNQU2EwZktGUXVCMys3c0YxL3dlanpHVWgy?=
 =?utf-8?B?OXBNTTFHSlgxT2ROQmh3KzJHSlJxNE1WWVpCQTViSll3UnlMZ3lLN3FTSUhZ?=
 =?utf-8?B?MjJRVHpoQkhIcllyYjB6ZVVyK1IraWw2ckJZOVk3MVN4WVNhZ3pYbmkrZnMy?=
 =?utf-8?B?dytZT3RIOHh5Z1Fnb21TK0R5Q25INjFkaEtZb3FZc01YOTZjVEx5MUZSa080?=
 =?utf-8?B?SDRuU3JmUjNvbTVEY29YS2Z0WXRrWmozVTh5a0Q0dGNsMlpuOVByVHIxRGFK?=
 =?utf-8?Q?roJWYjOcE10x1pKYlQ/VYVK4S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MuNilnVldw92Cn1oWTClT+061QQfa/cdikjsgM8X0wQhPLndA98x8aciqd3WGggk/PNXZRc0zcIlre+58364/mVSbv7+sSsUGb8mNvmzudt8biKVB/r6IVB52S4JJBE9Pl23VhjcE/TeLLfMYK9GkpWRTr3eZiEVPr8dH4Euwoxs+8dMgBrurb2872TZH0elADw28hb8Ya15RfYdYlXdIjt0muYI5+QAwWSzN0p75CH0MluhxkoXqXInjFVgabbkSOGbxqXJ/PrX88yib38zKjqw87sgNiW9lZssFV2bkvRjx9rCFsG7BzU5RUiDbWWUK3MdwSAD3ZJUjhnwEuGx+P8KS0Ydaa4cPv9POZgQAexe9Py/pjHsemhJ3uSfnZhHAt8c5F5MKVf38N1rsuCCZRD5Vo3ZxYw+KNN/cO1iNa5+BJtjTXMFw4fvkPpXJrLX6Ca6Tz5GmLIkrE54JUsdLm/xyv8vknMYBpaxcL3u5IXTZHmn5FAXBvRCLTrZEbjnr6a5WuL4UXu/xoWA79cDwwuCSVRBo9rHymov2C3I+RJs8MjFZrdnIJ2tkScm/ZOVLBHK0Yp79MlAkp0KUkwuysVCNXTWZVFB0GIB06mqOY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a98e6fe-9188-4b1c-29c6-08de15847d08
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:13:11.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y57iXcMbsN7AWSM7k3gsstdxBKtYR153APQ3vp8nJShZt+aOFEDaBF0QxV4luJzowp+6kecubcwTotDBBJ46vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX80VOqsndVO/a
 R1lX5yM1uSqi/0SrDB1LbRICN0RosQ60+/wxLHaUHRvsff4wDOA0oMiul9OOFs32SlpBdGH60tP
 7pIMSlnOAxzXP8FVU2uLCxtNz9WbAY+OgcDkLc32tJVupEJonAum4OGEsNxfRtoB21vt1Yc+LUy
 8wgqhR+m9rrJngybgAzZl1/Z8Pus6E/zdVAdL3lkZ+U5099ern0JIx8oyHWc327Ardw4y8LyyS6
 v8+9/P5ZFEEo9ac2iEGteu6+9SSvTFZVb3TioXdVQDFr9w8CwOmqmivUu/xSbqrlvQV1d6qYKOK
 9OW0SCimP1LSoU/j/pvBsUcGx1H0mZzN6SteSL7+3vZ6/+uaGzq29suCDimnGztCqK+jf7GBbOQ
 r6jaP85j34HsibRW40JNu011Y2ix1oIF4p70iAcefNV/WTD16kU=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=68ffb63c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Awwqc6U953CGRfrzz4kA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
X-Proofpoint-ORIG-GUID: -WQ_xcJ55ktSH6x2nHgUWkSmPVDfbpKW
X-Proofpoint-GUID: -WQ_xcJ55ktSH6x2nHgUWkSmPVDfbpKW

On 10/27/25 8:35 AM, Jeff Layton wrote:
> On Mon, 2025-10-27 at 09:23 +1100, NeilBrown wrote:
>> From: NeilBrown <neil@brown.name>
>>
>> According to RFC 8881 section 16.2.3.1.2 the result of a PUTFH op on the
>> current stateid is that it should be set to the (all zeros) anonymous
>> stateid, not treated as invalid.
>>
>> Currently if a request contains a PUTFH followed by a READ request using
>> the "current stateid" special stateid, it will result in an
>> invalid-stateid error, where as it should behave the same as if the
>> anonymous stateid were given to the READ request.

Wondering if there are implications for pynfs -- either a testing gap,
or a test that is now passing that will will fail as a result of this
change.


>> This is easily fixed in clear_current_stateid().
>>
>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
>>  fs/nfsd/nfs4state.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 35004568d43e..e1c11996c358 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -9091,7 +9091,7 @@ get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>>  }
>>  
>>  static void
>> -put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>> +put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
> 
> Side note: This function should really be named set_stateid() or
> something similar. The "put" there makes me think that it's putting a
> reference, when it's not. If you feel like renaming it as part of this
> set, I wouldn't complain.

Agreed, a get/put pair implies the use of a reference count.


>>  {
>>  	if (cstate->minorversion) {
>>  		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
>> @@ -9102,7 +9102,7 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>>  void
>>  clear_current_stateid(struct nfsd4_compound_state *cstate)
>>  {
>> -	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>> +	put_stateid(cstate, &zero_stateid);
>>  }
>>  
>>  /*
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

