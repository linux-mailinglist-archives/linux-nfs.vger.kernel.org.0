Return-Path: <linux-nfs+bounces-14177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA8B51967
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298CD7BD12C
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A532A3D8;
	Wed, 10 Sep 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1xvPLoV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqrqO8yY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769E32A3D7
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514573; cv=fail; b=CFUGSQICR7OSa/EYgGKOHa1UeEaV9jxOVAZIn9KBgelYmVpgu6zlJ4ds80XBrty6VGXz83cApWsH0vz/XDTVv+yzmlgJJbDmTJr6kY9l/euVeBNWY1QXnK6v4aSE3hJnFJbRTNjCzJ/Rv7K5MZNenfu/4wfRodpT5lJQ84oQ6K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514573; c=relaxed/simple;
	bh=4gmcbU7rkkjQT4ogIoWDBmuqrenxwsj499xPX/LVmhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jRGJOWV1FP/MtK3h9NVM6T2ykDf/mk7TfGgtqLwsJvKMuWmB5llcqvhHp8NDNEAxHJfn4efQiAWXWW3yVU8l/sfa11o5l3Yx0oGEGoCYgmyeE8jFadTdTPtZtxy6uAvl07vIe9Xzb3HGmVYgRJxigPB353TRpsUWj6U/ZIlQJ8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a1xvPLoV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqrqO8yY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADC1P6001612;
	Wed, 10 Sep 2025 14:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=53E0avvafT0ATLnX61Fo0lrlYz3vyy9VTuqpgGGuXZw=; b=
	a1xvPLoVN9DczjSB/G1GiHkf23VwrcP+qywXtTX83woPRJTXojy6ygzBKSgk+jJj
	vLgcUM6lULBJrzaZOpH/km9L7MF3A/Li6Q6cN+/eXjL5SsPz9NOTUO5JYgohzDmN
	P4CsthqAzr+14JQY4cA4vM3QdnywzA9wViVs6lpqPHB7ZeMRvBrpbu9pFVnKkAvW
	lEOM6K+J4+B0redYRp9HhvepQiVpSmsuPaTX+TCzZ3UcH63BpSXs6I0k2EbImTia
	6B9qzTDv4YFgGJZTGreHSqOeqJHhab+3eJVM1jPKMQLGmQyflXN4pvZVhbjqgwjN
	XleA8FbNwkTlVp1kxe60wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgv8eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:29:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADFuDU013563;
	Wed, 10 Sep 2025 14:29:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb9ygt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5hrda3jPjoHLPIiakd4CX05lswUakBrjRhvpL0Y5RpKG9HK3aBDauiiKpX9L1Orerr//K58SFh9IxSddLg6TAo/4ky6yg3mxwv8me3L5+UGmOMRsRiY+uzs/edNoiPpd0DxdjoDepNOwaNNT0fFpyJQ/Ul+54a768Cq1Ibcgq5P/14nuxcehjVCq4pjAKB7qqHvRMacFDe+9yEw8O1/OZtqijNFSNAnHTWrrG2F2v3p7AtIly0psbLo+4G614qS9/pIX0FSa2DOR37JWTctm4MBFTSlM6hx4TNVWu4xcaRvPL5UgjgAMEr6yeoDyvfYa4WaTY71mEsBe5MGMKiG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53E0avvafT0ATLnX61Fo0lrlYz3vyy9VTuqpgGGuXZw=;
 b=E+jGMKEbxYyiCLed7x2edVkUgOgc4ZQQ50kKY/0w976degcJ0blbPglYXg5NIjYV5tr9a+JN4yqAAU8QpRf2+76nzB0lSHX5ORKNEm+s6NHjgpkj6+SPXTZTdCQS2DFI5A3T7/Z9pDUSAP5MpvhCXb47PssLfK+I7rBl3yAkCmZrIc2N310j+TRVw0xcGYHUgK3I72yGeGqB7aU8vHLIjxEJIxAikGStuOKVHrMkqntKZ7R8iTD8NEZdwlYEt0VJSgde3WOWhNpMZT2ZNlLZsOUL0YHLyv8i+n9GrvqBjz/XxXeKTji9IJ0YARWY45kd+LFFPbbp77S95qozIgcMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53E0avvafT0ATLnX61Fo0lrlYz3vyy9VTuqpgGGuXZw=;
 b=rqrqO8yYIF6dFNgqTrmBic5g3oC+E4ZuATW3Fjy5QihLpzBzhO5wE4vUI3nzo1W+C9xgkdBFPbRJBtCfNfz+95YLsXTcl+/4afJP6bLW5sTOO5jmthYGUuiZTwCHM8VTAWb6JXhJRT+Py+Tg03eGWExM6lX3FPPjX5/7vyYLEAI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:29:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:29:21 +0000
Message-ID: <0ac2d8a9-1cb5-431b-a99b-695e20a8a6c0@oracle.com>
Date: Wed, 10 Sep 2025 10:29:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sunrpc: add an extra reserve page to
 svc_serv_maxpages()
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20250909233315.80318-1-snitzer@kernel.org>
 <20250909233315.80318-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250909233315.80318-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:610:56::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f46a273-a580-4438-3055-08ddf0766ef1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R0YyVjRxV281dHBRQ0NUZmpuNUFWSGhORGVvUnExRngxK0Y0ejg2dmIvMnQw?=
 =?utf-8?B?ekl1YW9IcDQ3bnlsWDRmUTIrbzJHQTdVdlhlalJ2UWNqWVhVakxyNDhyK0Mw?=
 =?utf-8?B?L1R1aG5DUlZMbW1ZRTZCWXpja3M5ODZ1TXdBVVVUdnVSZjNoOE05N1Y2dSti?=
 =?utf-8?B?S0ZiWW5CcmtKQTVrQ2laLy9sd3A2UlhCNmpGNHUzdC8wckREQVJIeVBPVnpC?=
 =?utf-8?B?VFNvUlZRTVRka05HMmNNUjc3a3lPUTZWNXBnU2ttK2NYWklHelhxL3M3bUtI?=
 =?utf-8?B?ZXRySTVqOU4rMy9aL2F0eGRuaWJyTVJ2ZXJ5UmlHTnJyVkRQbEtjMVRKdmtl?=
 =?utf-8?B?NTBBM211WEZOZ3NQMHR0TWZxcnpyR0tqMDBZNXI2cEFJc3F4cVl4ZXVOQ2Ju?=
 =?utf-8?B?a2psSDE5RTN5cGNxVlJXNWxZYjc5TE1vckNYTU4rZktBQXpVR1RabS9TVlQx?=
 =?utf-8?B?Qy8wL21GODJDeDZST2l5djRUZlA1eTg5enZpdXg2alJkT1ZzUW1maWN2STQ3?=
 =?utf-8?B?bCtIaXdOUi9oaUhFNlpwYktHUWFPRnBxK1Z3aUkrODI3emJ1Rjlab1FpMjds?=
 =?utf-8?B?NXVaSy90VUE3U2JEQ0lCU2F6eGJWbzdmTEFoTUoyRWZRalZXQjhCUWR6VGxw?=
 =?utf-8?B?TnM3a29ka0tXeGJLbWdrUm5IdEtNbXlNVEVwNyt3NXloeWxRN2RYdldaTm9X?=
 =?utf-8?B?eFZlY2kybFFwT1NTaU01c1hFNk1xSU1OZHAzQTRlTG52UGZoYTRwZHprR2VL?=
 =?utf-8?B?blQranFHeS8weGxSeUt6aVBkeDFjaWY1dUlpRlRiR1V2RnFpalN3RXJkTFc1?=
 =?utf-8?B?VmJPSUZaU2puNDZoQXpLd09taUd2aW1tZ2JxNEpiYzluTTFvZnFydWcwd0VN?=
 =?utf-8?B?UEZXUW05SHBSQUxTSUJ6L1pmMGQrWDJ1TnhWZEpWQkl3OW5wbWhoVW1RbFky?=
 =?utf-8?B?T0gySStRUERraUtzTUhLRHRkYk8rNFZEZHQwd2psZ3hlTHVYcTA2b0VKVENS?=
 =?utf-8?B?RWNQb2N1ak9IUUVMY1dzRnBzbG5IVTUrTWd4ZVo0aE01K0tnNERVSWpsSm9G?=
 =?utf-8?B?MWQvT1RwMjVEQ1dIcU9PK3FUVFdqd2VMUXM1R1ZTYXU0ZUFvdGEyK0RjV0ZX?=
 =?utf-8?B?QXBTU0tIelFDVjV6Q2I2QUhkamlsZGNrRVc3NTZvSTB4d09sU1NxUE1xOW1v?=
 =?utf-8?B?bVlhbUlCZWxDaXZ4RUcyNDZpL3VzNkhQd2FOMktBU2dLUHJjU2l1cjE2UUZQ?=
 =?utf-8?B?Y2tmQkl4V2x2dk9OUVBWamloS3hIZ09xOE4raEo1YmJyOW1IWVd1OVZUcGRS?=
 =?utf-8?B?blVPcDkrMHJjc2FUSE5JZHJHVTl6WDV4S3lKTC9uRkQyY29EYSszRDQvVHJK?=
 =?utf-8?B?cHJ4UTZQc0EvbCs5L2dWdkZQRG5JSG1BS3k5ekNwc1JHK3R0Z3JPTXE1dXJn?=
 =?utf-8?B?Z0NSdiswTG9yeU5JSWJpMHJEMmtlazJUMlBCU1hJQ2VtQ1M4Qk5tRzJ1amRI?=
 =?utf-8?B?cGJGVFp3QkhqOGJTMnBXOEMrOG9wWnhiQmZneWx1Rkp1ZlNXRVhuczBndVEx?=
 =?utf-8?B?NkxScVp0WG1XTjZtUUxya2tzZzlNbk9YakJ4ZmJDY2pzaTlQWkdvNE5ldkVB?=
 =?utf-8?B?L083U1dxZU1XVFJubFhnNEREMWptbXI4d0ZMalBPUU5QakN1dURLTWNFQTJy?=
 =?utf-8?B?OXU1Y2tGeE9TSWR1WVg5Y2RZaTRIZFkwbTdpQWxTM3lRZERSU1k0QkdISlNy?=
 =?utf-8?B?Tit2dFF1MndiUzFvOCtVeFk5MWZ0bzQ5OXNKclNFalJXd3BQK3VDUUx1NzVt?=
 =?utf-8?B?UHh3R1JDemVJYkpwTEhVSlpuUitLbGVHWHZ5WitLZmxaUnFIWVZldU9EanZh?=
 =?utf-8?B?VmlKYlhEK1dvc0xZUm54dkNQYis4a09yc3NJUis4cm4yYWdHKy9XdFJDaVl2?=
 =?utf-8?Q?kZPhXb+Ac9I=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGt2MDV5UmJSd05aN0hNRGtDc0J3Z2R4Q0xuOVlzd24vQkxwcTlkRHZHNm1q?=
 =?utf-8?B?eWtMOEVGSEtoRUhaUHp6NVZBK0t6MG1DdXZpcjh3bUNMZFZUTytoL2JRenB6?=
 =?utf-8?B?UFdYVUZzcGkySXBPcERyRFcvcEU5Q3FXczNzREhNSlVFOXRlZ2tDUjBUNzFs?=
 =?utf-8?B?Y3FIamJBRVlUUiszRmFZN05vZlF1enM0ellNTXRybzlNengzaHFDMk9SMmxU?=
 =?utf-8?B?K096eEY2YnJCRitZQ0YwVGZBU29KUEhsTmIwWGZPUk15MGJMdWdMVlF5K0Zq?=
 =?utf-8?B?MC8zeVNEOHluWThqSXp5SXBhRTc3ZDVEVHNBeXZRcXZkY25pTE5hTVJ1Q2VR?=
 =?utf-8?B?NTdmMzd4Tit3TjFJa0o1bDVaZFJuMld2aHhGR0VuaXJmT3lNTkxDRTNZYStN?=
 =?utf-8?B?UHFDRWYxOVp4MDBXNWpBdHBZaVZRRVR1QVh5U2RBT3Fra2JjdmVjQWs4VDJl?=
 =?utf-8?B?RHNGRDNUUTZTM0RheVN2d3gySEVPN0htb3MraHlYNTh1V2NWbDRnUklrSjJo?=
 =?utf-8?B?SmYyUzZ0a3pHamtKZ1dZK1FJc3FxQy8xa0NkZVRxY2tHbDhLQ3Z0bUdnZjRJ?=
 =?utf-8?B?dWdacjVMQlY5ejN4WWpHdkJYSVdoWUVXRGRMdUlKeFdZMDlST1BQanJkK3By?=
 =?utf-8?B?eW5SaW1kajA5S1pwZnFTNUI2Wm5uYW1nZ1NoNm53bmRBL09aWGpPVVlyQlJB?=
 =?utf-8?B?OXVZK3JMVDRuM2plak1hUmthbERZR0d4UzlxQUZLdzIwdjJIK2c4YkhaWnNk?=
 =?utf-8?B?MGlmQlVxblAxemg0bWRuOENXUGNzZnhMMUsvNmI4cGYrUUx1UWlmSkRRelM1?=
 =?utf-8?B?cDRFNC96T3J2UGI1MGlhYTRsUjgyS3dkTUhhZnhyVG42U09EQTFVclhydW5i?=
 =?utf-8?B?b3dGbFhIdXp6VTZlUW1jYWhuY1k1Z3pmeUdSQ1BKVm9iaG42dnZjVzcrbFo0?=
 =?utf-8?B?aXFkM1RtS2NVdndySlYwN0pnQWxUNnVYc0hQeVZUdnV6YzF0aHRYY1l1TG5i?=
 =?utf-8?B?ZG9DUjhKRnJHb1MvNFVyUzkzSlVzdDhQTnRNekQvSGRuNUY2Q2FROFJPUEVV?=
 =?utf-8?B?VEFxcngveUZ5bGl3YVZlK1BkRGNuM05Zd09tYllXR1M0dHVyRU5MSFJSTVRL?=
 =?utf-8?B?SWNrZmNwN01mbXFUVU44V2x6M3hnM3IzZzZOVm9zQnRHYVBBV01ZWmtkb3Bz?=
 =?utf-8?B?Ly9aRTJpUFZVQ0RtTnV2WEl6UC9KVld2TWRsNDl0aHlBYTFMbG8zZkIzaGE1?=
 =?utf-8?B?M1BvV3R5UXRFa2ZsOThCK0pBcXN4QUx1OXllOVVlcy8yWUdUa2o1UHd3NjV2?=
 =?utf-8?B?UGljbWYydHpuNlpxL0NPK0UxTXdYNG1XUWx0MjNGV3FEcW1oeVozbktoTEJn?=
 =?utf-8?B?QzBqeU9DVHd5bU1rTjJNWUNxRVMyRmdkQjNvaXhWMUpqSGZYdXlvbCszL3FP?=
 =?utf-8?B?V1ZlcS9KeFBsR055OUxLQUVEeXR0OTd1WnhKbzArbmdRRk5PZzFKaEZhb1E4?=
 =?utf-8?B?YUc5SnhQdFBhSXBYdUJmSlNVWUMzSzhJWWhtMlllQysyeXBibFZGckI1a3dr?=
 =?utf-8?B?MGI2dENXbHU4dC9FZmp4M3JUYWtzRGd5a2tsNGs1cDZmcjF5UDlLMkFiT3h2?=
 =?utf-8?B?aDhIeHUwY3htYlVPUlM2SzM1eUtQNFpBL21KMmZHS2ZWSW91RmlZYkN5WWRz?=
 =?utf-8?B?M1o2R1dwSFF4bGFyZFE4aWxxQnZDWXlxRWJkSjF4bUhOZlpVNXpXL24xS29S?=
 =?utf-8?B?WTdlMmdsSnpHQmxQUFFucENla2pFWHFic3RVNnRwRDBIbStPcW9zNk5tSEJa?=
 =?utf-8?B?ZTdrSXNoc2ZjRFRudTZPOVl6NzBZUUVhaFdVSzhDU3V2d1Z2UUoxb3c4QjJU?=
 =?utf-8?B?YUl2RjdXZEVlOUY2NnJHazhpM1lteEN2dkM4NXhCQkRpQyt2d0tjNjdyVXBF?=
 =?utf-8?B?Rm9wUjNBb2pNSXdldzl6SGNBNXJSSFozdW8zRGhYcGVoY0ZXQlAvdHVqN3Qx?=
 =?utf-8?B?VEtjMGROSVR1NUtrNzdiZEdFbTUvM0Uvb2MrNG03Q1A5MmlTMDA3MlN3Ymty?=
 =?utf-8?B?TUJGcjVHTnVPZnE5bk5ZNVowM04zMERxUXcwck1EdmFqN0Q5S3poc3ByQWNv?=
 =?utf-8?Q?UVUT1nKzwlN9R1fkLxFoqXQ8z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	udv7kegbX6upbezLyws8fbdJOfIEkVEpQCSduOgmwD65UmYZTuOcEMqk/9AeASqaC9t5vYTWuZTvNX2r0XTwuxSH4q2iZuB2zwepAWq5EJ1e1uJZxYLoe68ob7z0CZrdsWaNPsAWDEV4B+09Rr2xYFPY7+JfIh3JPLb9e0G70XHYLN1jyIoSNXmLeCCDT/xCTSlVzgJAxSDvYvQKrxw39ZsR6mXP1Idc8R8PEYwJ82nzSc2hVu5xAY1lvHakGNQdEYGqfVxDD7LnAG/C4neXgY/TNy3VeDONF3GMxdiC0KG42kfHbQ5ylHqxF0pGCkn8rkLj5i0IyBMuD96VRr2aHqrEkIBexgjHedVklc9xGn9ydLg80cv7PcgeBmFfy36u7MBAZ/MOyrAKQ9Yx0lk3HV3JKGvUrTBKcab176T++Nma1WDAXs4ciX4KTD0jI3gc1Pmdnutj5v0/EJXIe/V3zf8x9BVLVyNld+EivPLtm55rGWJV+itshPScYfrwzn0T3lpahTUD69CnG0iC50ZZX02/9t8YRMdNhaHfotzMgwixCxmVsVmRY48zsIa5i4q/Wf7iIs3cfa5Fw4JgrvVnfkJWoRAF+vZvIs39C/JMhR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f46a273-a580-4438-3055-08ddf0766ef1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:29:21.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMCLW3Vui4vYcjLdvxENF6I8U0rhdH6YS2s69qijCSgvL/Jzm9L8AOHMTKxhr6t3lttF0h09Vwfu3asZUlabFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100134
X-Proofpoint-ORIG-GUID: VLD1g7lH_CfUCDDUUxtULgxp6zvVvaf9
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c18b45 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=mvG4qfvZQuAiJhTWXpkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VLD1g7lH_CfUCDDUUxtULgxp6zvVvaf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX9BqCU3HJOktQ
 Y+HR84idmCWf7ccpGEW/0DT4FnLOQJ434K/zL3E5I30YfJ1oDb6FiIpkgIK9RKqYazzciomEinm
 dVOdQ4+FCZo7UZ/MNDYW1Vb3BtGLlvRqOrn5lH0hwUIlCeqUFTANYz69vFFhFOF3dloftJkVvV6
 NjwoVp+2+t+UllBBjtZO86l90KYgEp8VCxD2DLdZMwqsDv391ebVHlY+/kxOkYcnr/PUyrS85Yt
 5gaAQO6XVCXzq+HEvdsgStFY9gV/0vYqooP6nY7LPoZI40BrgvybuxgIK37s/LTlQSUGnvr5Jlp
 yd7iUhb3qU3LTIuvD6hxk6gstiFfgFffFwx+QAxRkIIs9ueNqiixYFagefOocVzrzYCNARoTjFW
 V1MlDerm

On 9/9/25 7:33 PM, Mike Snitzer wrote:
> nfsd_iter_read() might need two extra pages when a READ payload is not
> DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor() are
> mutually exclusive (so reuse page reserved for nfsd_splice_actor).
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/svc.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e64ab444e0a7f..190c2667500e2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   * pages, one for the request, and one for the reply.
>   * nfsd_splice_actor() might need an extra page when a READ payload
>   * is not page-aligned.
> + * nfsd_iter_read() might need two extra pages when a READ payload
> + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
> + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>  {
> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>  }
>  
>  /*

I'm not convinced an additional page is necessary. The most the direct
I/O range can be is rsize + 1 page, AFAICT, and that seems to be covered
already.

If we want NFSD to support file systems / block devices with alignment
requirements large than a page, then perhaps additional buffer space
will be needed... or NFSD can return a short read.

-- 
Chuck Lever

