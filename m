Return-Path: <linux-nfs+bounces-10313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A98A4239A
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F5189D2B5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930F19258E;
	Mon, 24 Feb 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g82WTtIX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RJQE0MEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622F1624C8;
	Mon, 24 Feb 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407961; cv=fail; b=oKMuSXY6YxvjYLhoOY/C9DlIxSAV8aU54Bw0p6Evm5HiP3saGsExjw+C6g447QpiCtgxLL9kaQjAMblmMPXns+BPWLI4ftinCsLeRrb08gCKAlj4El+DEwEDZcV3nCZbmGyEosw3byINRJx89774KVw36XYFowLpZnSCuKpuaP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407961; c=relaxed/simple;
	bh=Cd/rIRlw029c2Vvc9lZGRjMQFWBWnotHfjq45l0iM+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mW381HcRQpEhS3g0zk58E8dlxs/MS1wPWHuG61fTf8bMM9i/fvByrv0eIMeBiNr7H8s0LmWg5TpNOboZL7B7YwQONoD0bGacFM6bIFtUeKmM11JQ/PJYvWEosARvzI7Z4KNwwrSXqEgsy0Z5HXX1CX8OMGTBcknO2A1AcpELdnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g82WTtIX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RJQE0MEg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMwsd025689;
	Mon, 24 Feb 2025 14:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CJ8VOMg5XSkbU9sN1YYO7yyMvgTSALC11cxhEelspV8=; b=
	g82WTtIXkYX9ygHOxw4Xy/NUfWiWe66e59DZON1sCEOdMK0xHFLfHTToJS14mZX7
	W57l5d03UZCo8DNm0z+7W1a0Rs1ODqx0wAEnbPmSJAr01I3b8wKaFwlQBlat99bi
	Rkxp+VQ9xW0UGiyZOHmHKFpqu+MJM7CKZSR7FQOfdmvp2fR3VuQzw7SC26hwW364
	2LMMOuPVe0MQPmGFoIEP0gDWElPzlggbyXAG0VRJMTnUE//YA3yo+zaqcfZZj+pA
	AV3qmJ8/h//Kdr2Y084eS2iC3QVKPwIhcy7UNrW83ewuLSswUUAy3y3usNJuOlpt
	iThZXUsVJcSQzHzbQ3mquw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t2nqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:38:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OClvWa010010;
	Mon, 24 Feb 2025 14:38:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517fq4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkDIb/vvRrCAU7bmg8abgqMsnFfGDooxvx73vFqNYdGFqau4lOCgOAP7Jhz4D01yGIbAx92xXcBSV0EitqZsWuKbVHnaG5K4WKzlhkAIu4qjzJFRATylemOsk3mIxu0w7ip5nFkbe8SaOCSBk1TiZEuOiQ8nFitgXimSVTLArX0CaZ8iz6r98VR8Z4CvnAOum/mzX12ttX5wXD5KdeoH3+Ql5yW1o8y170q3bM0HOQDal56OaB/OCR6n6zBvji9JCRaaoL77NJfFzstONZCQs+z1aLKbHeBQMTuB3OkaShySgLpSuZ99IEeMI3lamyj0ewVYPFEPa15OBX5FN8SWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ8VOMg5XSkbU9sN1YYO7yyMvgTSALC11cxhEelspV8=;
 b=zB7/0agiqyewXSHdrl2J57mC9O6yCRyxCK9KyW+ERUXShgOapYLPTg2YIFetS76TzkyICalwuWrbGjWoY+FLfcMiNxX+mHpTCcHC7ILSGYGEH4JEum1OiL1aD2DsVdWGocC2q06SMyAjbQotPFRqgkFrGrGLrRFYHyDF31dEBfqfXquK6ETY4HYrpKGr5a4Vwp2KCT1swoMNZKFlbd7UJXERtBR5KDmVvHz8hPViYuAo53PDTIzrJGRDh3RvFAldHCaNG+5wigbl73ADQuCcUd4clLzDPjjS2GtA51oD4Qg/AoZjtKEuoLTbNuOQF8d87nztKt2M85wwChJ/dlgbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ8VOMg5XSkbU9sN1YYO7yyMvgTSALC11cxhEelspV8=;
 b=RJQE0MEg4a5nR/e2nBF7cVkJM1QGeW/oga1iSoQohbuziN5F2oiT8XbyShu8yytyW3yrAKByLVemQrzsl8y2uenst6v/N3DwpzeMokmklY5tvYqXEzkZ3Dih2LKc5BjRHmNYzutEL/L+qZN4b1mPSoktcazKFvR00W2OvSgA+Zw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 14:38:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 14:38:20 +0000
Message-ID: <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
Date: Mon, 24 Feb 2025 09:38:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
To: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
        Joel Granados <j.granados@samsung.com>,
        Clemens Ladisch
 <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:610:119::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 76acd989-fa63-4d87-c6d3-08dd54e0e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktldXE4Y1dCRTRjWmpzVkp5ZnJXeDgwTGxadDRoN2phUkl0Um1yejhycVJU?=
 =?utf-8?B?cCtYUWVkcXMwQ3JlUzczbHFJdWhXbVFQdG0vZ3FqbXQyeGVtMDg5KzlKREdF?=
 =?utf-8?B?R2lVNDlWOFRCdVYzTmZBNmFXT1pkOGRUZ2RFdllJTTFzWkdiL3kwY0xVNElM?=
 =?utf-8?B?cUVGWlFWK0U1MDlSY21SMml5VWErV0NoVkxXaXNJeGl4R2Y1YU1kUW4wRlFT?=
 =?utf-8?B?SE9ZcXZWZys2bk5tYngyYmhqaFBtUnZSbHl4QnoxYngwRFlkVGcwS3dyaDlW?=
 =?utf-8?B?T2FVSWdiUkpYUGsraHhzVkREL0FGSzQwYWZrVG5FcGRKSEtKUG5LYkd4ZmdQ?=
 =?utf-8?B?TXRRbzRUTFc2cGJLbWl3VzRyaUNsQTlnci9tSDQrby9xcnVZU3hiU1d2NFY1?=
 =?utf-8?B?WjVBaDJJYllUeFhoTkxXL2gvUHBLbkNHc3dyOGc0SWV0dzZhOTBoRHBJMVEw?=
 =?utf-8?B?cXE5M21mU1JKUmE5ekhIY29EbFI5RUpxaHdWNlJUWXRFMVdwREVxMm1SbTRL?=
 =?utf-8?B?bnJOZEhDUUVKODdmNEJYYURQUEZyRDlDYW95djM5SS9uZVJneGFyaUxjYkVm?=
 =?utf-8?B?MEhiK1RoeFlGVHRBV08xb3Q2VVlqQnlGS1BuTkNFdkZubnVMcjBySXZtWXVU?=
 =?utf-8?B?NlNaZTdscnRzMGhIVlVHYStnVy9wMmpUaUlOd2lEd3JhSFhVM2dWb283L2lU?=
 =?utf-8?B?U1lVUC9EUTMyaVVQZERVaHlVbkVheTJLRlNNUFVoNEQ2aXd3U0NXT0VDVkJC?=
 =?utf-8?B?TThyWEcxYmVtcTVmZFJucDgySFpOM2FTaG5PSGMvb3hMY3FFNlZzWEx2T1ov?=
 =?utf-8?B?bExzTVJXYjlnYU94SWRndVpYTTZkd0Q2QnhKazZMUWhuQllHd3dmU0ZhK1RI?=
 =?utf-8?B?TUZlUEJQeDVRRzNwdlJUbU1XcjgwQmV1VzdDVk5QNHIyNkVoRmNmZlhWWGRp?=
 =?utf-8?B?bjRPb0VuTU80V3ROS3hYRW5jZTI3NUUySnl5U2R3MTVIUEZOMG1HdDhLSUtx?=
 =?utf-8?B?aUdmYzY3YTFpc2hRZXBjOWxmeDNxZm9ScWttNGlsZjZjbGhCT29GSDBtSnBI?=
 =?utf-8?B?S3plY290L0JNVXBLd09aTGtmcVlDZlVCYmYwUk9YMHV0K2hySVJLL2N0MWNv?=
 =?utf-8?B?bUtRSFNKYldyREw0VG00eUNkZktlNjdSTjNwaFpadmtTK1JzWnhZM3pRY1RU?=
 =?utf-8?B?NWhwK25WbndBdm9hcXFwU1lvelI1VjVMUEY2R1A1QTdLTTVvdHpsb1FxQnVp?=
 =?utf-8?B?cWhEcjZwWTBwbStQK2NwNk1veGlnTjVxVXV1SllyVFhGRUJHTXVmZEdLYnZj?=
 =?utf-8?B?bGlkcHUxY3VTWnZYT0lUVUtPSFZ5MTlOSjg2eDZ5R0NGTG55T3dNNmxSdHUx?=
 =?utf-8?B?bTBVN0VDNjI1VnErVE1WRk9pTnZWM28vbXBUL2M1R2RHN2E0NmFPY3lYWFU1?=
 =?utf-8?B?QVMyMC9RWnFaYWR5MWxYV0E5L2FlTGVHYlp5ZDdXMGJVZFNNYXplaytrYmc0?=
 =?utf-8?B?Y1grdEk4alBjaWRERGFIS3NEckowdHhyZkVPemxkNEprNjJpN201a2tIRVkv?=
 =?utf-8?B?Z3FOVHAySDZJWmRTWXE5d2hoRjZZKzZxQXpsRGQvYXd5RVFpTkV5UVJMdWpw?=
 =?utf-8?B?c3ZZdlhZSzNqVHVUWTFXNGg0SytYZXFka2ZHTnkxVVVaSGhXVzZPOXZ2cHE2?=
 =?utf-8?B?Vk53bm15TzJscWhRSzFqZkxzZVNyemk3Yi9UOUwvVDQya3BNaytZcGhWMi9k?=
 =?utf-8?B?VEhCbnFHaTlUSTV1QlViZ2l1R0R1ZW8xRmgyLzNjTHJESlRrRnl4Y0p5eGJa?=
 =?utf-8?B?S3IvTFN5N2VudndhYW5BZldEc0lsRkcwTklJZ3VwaXZkZ2NYY2VydjRQWnEw?=
 =?utf-8?Q?ybGDjyH+AVJyZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFURDE4NUNQY0pyQ0lnNGVoYVpOeGxwaVN5dFcydDI5OGp5UVNHak50WTBZ?=
 =?utf-8?B?OXpQTVlrMlBHTTBWTFM3MXlFTWNTRW5QOXRCTVBraE9FbGtGQ3MzeHA0NGkz?=
 =?utf-8?B?MGh5MXFZM1cxY1JVZ1ZJbWNsem8xTWtDTFpSQVBPTmlsN3pUT3ZOa09Ha1No?=
 =?utf-8?B?WkU4d1lsYnh4SkxjNjB6Vk90cHE4WkF3OEFMaE1DR1hWM2ZVQ0RGZHNuZVlY?=
 =?utf-8?B?Wi9CTmlxTzA4OHE4d3NlYWtlWG9GS09UbHcrT1lPbS9lYmNCVmZDT3ZiYlY1?=
 =?utf-8?B?TmNHWjVjZmlxdmxTQXI0U2lrT2crbmk1azZXVzZadnB6Mll2OW80a0dUdjZk?=
 =?utf-8?B?TEtJMlhrM2N6b0VWY0R4aUtaVHdYS1NZV3NWQlI3UGM1Z2l4VVhYREMxUjdq?=
 =?utf-8?B?Y0I1N0lBakZuR1dGMGhnUTY4MXJockVIRXZrTkc2OUhHK1BBK0JBN3g2VjU4?=
 =?utf-8?B?OUZFeGZUVjlreEYyRTE0cElBNlcyUjQ1MXVFZ1AwOHdSRllrVTZTanlyeG1B?=
 =?utf-8?B?LzJKV2NMMmxDdmpYK0w1YmVaaSt4SUlIYWxzZXgzNDExM0JPUFZCYlR6Z3VV?=
 =?utf-8?B?VHpPdWRtekc0OGZiMTlrYWI5enpYSU9pZW5VZGNjZ3VLVjVIejM0Z3FFdTJQ?=
 =?utf-8?B?RHN6eDZ6L1krVHFNSXJCV0NmY1dGdEJOaVQydTlWTVRObVhJUUZnQ0F4RjVW?=
 =?utf-8?B?V1Z2Q1UvSlA0N0EwR1FIY1BvS2JhSEtiSUdsTVpEa3lrSDBqbXh6YUF4L2VI?=
 =?utf-8?B?dkQ4VW5CQzJ0b1kyQTlnS0xiQkI5N29FcTcwNkM1NW43dmtKelZZNXlKcVpW?=
 =?utf-8?B?ekhDUUNPS0ZoNW1MTEtsWnhUOVJldGhVUC9jWG9OaDhPSGpBcTRzWE5nSk1Y?=
 =?utf-8?B?UjFrN0NtVTdKaGhsbWVjTTFseDVlZlQwdTNBYXlRcnk4dTFDSmxiT1F3eEFR?=
 =?utf-8?B?VlgvdDk3RWEzN0s0b1hXKzhpWWl2ancyMlhqWlloTVR2L0NTU2l3NFBDWVk3?=
 =?utf-8?B?TDExMkJmU01HRkxUbTBCN2pwRHprVW9iK0QwLzRPalRTTlFjeldudEZTcVBv?=
 =?utf-8?B?TVNDbUh3bm1hNHRaMno0WWlYMkM2b1Z4MVdWZFgveFArR1o1UXJtZ2JybFNu?=
 =?utf-8?B?UlhjbHRFRUIzM3FwazVQd2g1QTVVNHYwRElsMWpMZ2RYbC8rY1pyWlJuRlkr?=
 =?utf-8?B?aG9xczdITitsMnIzeHRralc4Wnc2VFc4T0lVY29sWG1PL2VvS2tiTGxKbEY5?=
 =?utf-8?B?MnFnT2NNNXBGRXZxVVczVW8xb0tUMHUvTFhvZmp2WXFNR1hiUThCWFhPMUE3?=
 =?utf-8?B?RXdYaEpCQUNlczRrRjlhM2N1UDJvUXFvZDlIZVFtRFRBSkE1S0RhYVVuV0hV?=
 =?utf-8?B?RXhwUHIxM0dQbXhCbWk4N1Y1b2JTVFVsaFVLQzhjR2JtcnlRdmtnZ0hJTkJl?=
 =?utf-8?B?a3N6U1dHaURSYmliVFlqR1lZbCtzd0p3MW1yZGpyUWxaNTVqTmFoNVRZd2RX?=
 =?utf-8?B?N0dnTlh0eVR0dnZsNEJaSExWYzlHSTZTbkZQK0VtbW1ZaDh0R0hkYU1HT0hs?=
 =?utf-8?B?NVk0djkxWVRVN0Fqc0xqUUtyNTRKZk9TQTBSR0JZNHo5RjFVT0VkNlBMRTFy?=
 =?utf-8?B?TVduSzdvcHc4ZXVvNUtQK1M3YlJjSjJQZWwrcGVOWG4ya2lRajlKbzJNeVZh?=
 =?utf-8?B?a2FRMWxucG55akYxY20yYkpUNUJCVVVSckcxaEJ1MnBtRy9SMlQyV1M1eDBM?=
 =?utf-8?B?TlFpN0Y2Uk9EWDZ5SW9nVDR3NjRSbitkZGszbGtmdml3YUd1SWdRVG1BcjlK?=
 =?utf-8?B?SzYwczVqNXlGYUtPdWdZQ3FZZk5oSkNqSFA4bmRFUS9rY1FGMExtREsvS3lD?=
 =?utf-8?B?SUhyb3NzeHJqeWt3S2k1Q1AvUFF6TmhGOTM0YU1QMzNpVXk4bk16YkF6UWNk?=
 =?utf-8?B?SXc1S3RRVUlPUUdHRTdhUFhPdG80RUpsTmdIdlNhK3ZMYU4yNE1lRFRhRDd6?=
 =?utf-8?B?MmN1amxXM01nRUxDVndEWlZxb3dkd3l5L1BML2lveWtlbmlxNlRYNlE1R21L?=
 =?utf-8?B?QVk2TFF0S1pNRzA1QWhFZTBMMGkvMTdyN2cySGVBUnY2RUU0RkxId0ZrZ2J4?=
 =?utf-8?B?TWNFZXFpMWxXTFBIa0gyN1IxYTRGUXl1KytSeUhaaWdPZVBaaWR0YVkwbC9N?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4sbDSxw/Sjp7TrCV11eLZQ4lqTFzU+c/F9OL0eMrSP8D+aW6xDj0G3sb7KBPNo0TGjAcnWNJSGQcSfdq55lT4Lu3jWY/1aiDFQfRW6OrjPglXlQ+4scmjh4WMQZaeEeKU1SEDT00w+ugnB1g3caDawzPjI9UUycOf96d5KBOk32dR8qxXpb1mnqTkdyn+C2Aj2GHP07QMMpgPxg1mtGT7vL3kaAzo6q9POuJd4MTYv9/OsPs8hzv7VnRUK8udD5XLD5Jv8rIsurGNxbm1O1GgPi6ap0oXM1+97zg79p0WkQOFeMpC6VaveBMEyZc1Jsr3j77MsfFEfAMQdlQai4Ek6gMvoFaY1sAhJgjuuAXtrC+wjFQf1j/YkkJpf+o67CdPdin9urxqlKA8CSw7zO+wfvgTifCmgvoeIgb3csIUist0fvXk2K5C4t8SApKDs2X4hXgyOCScnBM9bPcs2yvmyIPJJel6Q1i389BomozKHeTS5w7fnPNBq3lOM5HQiUm4plWkEsKFD2BT3fgCZwhizMy7zzvPqXOvDcTKMQV/Bqj5lcFIFPi/aOEdYER6hd/O35iVU6Gk6BsTLPDl2tHfMSkUdgrQegeSLCEt/+vLdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76acd989-fa63-4d87-c6d3-08dd54e0e263
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:38:20.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46qFNT7hfZHocv0tlwttJQ8YBbxhoS0wW0BSdC7lMLuJk/hD1VJGH5ELWpIqudpxh0mMDe7KWdHz3m5p+hiPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240105
X-Proofpoint-GUID: BDSir9tSmm2FFbyipSQDgz6G1OfbU33x
X-Proofpoint-ORIG-GUID: BDSir9tSmm2FFbyipSQDgz6G1OfbU33x

On 2/24/25 4:58 AM, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Bound nsm_local_state sysctl writings between SYSCTL_ZERO
> and SYSCTL_INT_MAX.
> 
> The proc_handler has thus been updated to proc_dointvec_minmax.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  fs/lockd/svc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 2c8eedc6c2cc9..984ab233af8b6 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
>  		.data		= &nsm_local_state,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  };
>  

Hi Nicolas -

nsm_local_state is an unsigned 32-bit integer. The type of that value is
defined by spec, because this value is exchanged between peers on the
network.

Perhaps this patch should replace proc_dointvec with proc_douintvec
instead.


-- 
Chuck Lever

