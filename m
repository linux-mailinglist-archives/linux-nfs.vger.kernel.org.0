Return-Path: <linux-nfs+bounces-13517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F5FB1EE1E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 19:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92F0623BA0
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C31F4621;
	Fri,  8 Aug 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hxtn30EN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1yNyqgX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5795CDF1
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675957; cv=fail; b=H/6vNM7VnqH9NsGU19XRGAllsAIzjiBzNPD8h8n9xmzBGW+pUDiUkfTFrwxPVRc29qZlVoB85vBErQOlGen1y3OWNYGE6K0eW3AymZghvG4/zkRiltihpAULggROn+jABB95OtZJDX66QnBxkJ1trejr+CP+rMWZhE+GVYxjtGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675957; c=relaxed/simple;
	bh=StUDtdH314PBi4tRuKkruEZxuw1ezoM68P1dmpQNn4w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FD/HdC3hQanPfQLvfhlmtp+cJDWFYJrEBlc9zOCjDpjVO+aQ3GFYCqUVjY06aw6aAgpNv17QTVslXwlmij277fc0QuK+BCx8jqDjJiRl9TRAMrnc/TQ8JqO48k73Wkcapkg2Q/wheI0CK5QeqpJRhS6I0DCnMJMzOStK9BcE+KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hxtn30EN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1yNyqgX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HvVCB005124;
	Fri, 8 Aug 2025 17:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cre8vMrJaC1EjGnNF7jFCaGRwyIFgMUJ4vNqd5wV4FA=; b=
	Hxtn30ENi4YHBlhIPJNie+DPoxeXnR+AiYwd4E+CF6JR7FQFPR+ApQNJFvpG4OuU
	jA+95zGfuQ8EhzvVX2xMV6kJwZbIUBU+U5G9JsL9nlFVRx1hQeVJpM0VZce9DDmG
	Z1O8lrpqzP6QP0E0EfKqqzFX0ffzqDjxdWltqXXx4fk+n3nXVMvhJVQ61VMK/MA7
	AKaQav441WZgQ1iBMZehaXxi7z57IDIH1LKHtVXtCTS1FagX05Y/bNJMvWt7IhV2
	Hi+NSr5fJEZXscm7SsQf5/WDUfiMmSdL82kARYxACsrcKiFGlYrrU9SlKHbkl1sm
	VrpAElZyPpqf32aldAYfWA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgxypu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:59:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578G6w7P005629;
	Fri, 8 Aug 2025 17:59:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpx136de-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHWeS1kEqBaRNNH7zDLsK1vDtDFVnzg9lJc30ZzZ5517HK62CukIzQjfnxPvMi21CRefov9YMXePlYGHJ3uolmXApeZUw12mgd9sHTlyL/XgcW+Kz2Ipkk239F715RsiZJTFbKl22Y2XcHegsZSaJItDBZUO4sa9Zpf4I98y2fgC0VxEITTGsBmY46iw5Khvd6ipljs3yK5JZ3oPBogxmdD5807glF476PSp7ZBXr2A/CU3ByAx2TmqpjHyvea+Do8UhKItzrPwRf4y9LIzgl1JU6VgGM+niYJSavgi/ojaDNfdz8kqXmJA5FFxb2ZTwxwwWEIx7w6CIc209O65F3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cre8vMrJaC1EjGnNF7jFCaGRwyIFgMUJ4vNqd5wV4FA=;
 b=n+SE8lRVpsUU+Kd56NUJTcq3E7eVDJcoEOip32vGIg90uvfSegXUiKSAWr4rshAQ5X0+3nuZL0X5rHEtSWlzgf7sZ6REvyuDwakZo46uoK/kA5K5LH8gPvz4rZvaqYd5CNrwDqqjlgOqepyI2QdSu4F/IIwP3/QPYjnIDhKi3aaN2GlNU5ymViRRTTJ/WgLJAPp0+Kg5ZHkOpSH2R+74t8se+UVlJKlCg6sUbPZTNtwNjiDofbaGwFTg5Q8K9TZBW6tKudm39x7Z2IxnJ+XNslSoxEZeqHT0uisRoGOfH4Ibb8HKNC6kwaUeIVuGaqt5uPKR5zVmy4fRYJYkm0S9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cre8vMrJaC1EjGnNF7jFCaGRwyIFgMUJ4vNqd5wV4FA=;
 b=O1yNyqgX1q2Ah/T8gQpZsFTrnS9XDnpusKnHbn/ATX+4ScuwBjFbOFgIhdbzx9A81sHjfRo4XFTf0t0/gLgREzg7eg+DpB45YcHtihUafRKishbI1+j29gbSkGZ2VFBo7ogBHz+pLmYxtMVkIeq4QAiaYQhH2QmaXFlOp7gpF0U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFA634C6E92.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 17:59:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 17:59:09 +0000
Message-ID: <a7e02c77-381f-4eb3-9a7d-eaefa38ed7ef@oracle.com>
Date: Fri, 8 Aug 2025 13:59:07 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 5/7] NFSD: filecache: only get DIO alignment attrs if
 NFSD_IO_DIRECT enabled
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-6-snitzer@kernel.org>
Content-Language: en-US
In-Reply-To: <20250807162544.17191-6-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:610:57::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFA634C6E92:EE_
X-MS-Office365-Filtering-Correlation-Id: 94734063-a5b8-4a0e-3d17-08ddd6a54620
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bm5TcHhxZjRoditCZ3paQ1RsTkxRWlJRaGNUSUZIa0JQWTRKaHpXQzBqVUE1?=
 =?utf-8?B?ditQQ0VOSzJ4ZzIrMEE0T1JtWjNBNW0zWWN1RnZZckE0MVBxTFpINldRQmhB?=
 =?utf-8?B?VVE0V1h2Vmw3ZUppNllxNjJ2cStCV1JUbDF4UlpRZmVXZHpLa1k2YmpPZlBm?=
 =?utf-8?B?NTc0WFpsRkRSQXB2ODNnaFVrd0Vxdzh0S01uOVR5T2RQamdsTFVMZUlIVUxV?=
 =?utf-8?B?VDZoSEEzUnpTekJhUko5dTRqVXJmOEtYeWRSSkd2MUkyMmllYlkwWWRrekxl?=
 =?utf-8?B?dDJqb1VhZXVQQTlKSGVFOTIzUkMxcHFQRTRCdEc2bk1MRGFJaWhPOHUyd1Fk?=
 =?utf-8?B?RzlydXZLZ2pjUGEvbTlMSzQ2VjRyQmYzRVl0eDdMTlBROS9GcHMrV3RmQWxy?=
 =?utf-8?B?eG5WbGlSQ0pHeEhsU2I2cHJBWkJMNHVjRFhLVjlxTTV1dXFhWVpEajJ1bEVG?=
 =?utf-8?B?alQ5Uk9TWStCS0Q0cFdKOGN5SE9vemduL2kxL3hhZ3h6ajZZWU10N3NJN0lP?=
 =?utf-8?B?NGxmaXpCbWRac0x6R1A2WElTUG8wZnlZQ0NQYnNZL3dTb2tiWFFEU0gvWDU0?=
 =?utf-8?B?MCtlbzhnbURlOXhiWTc2ZHZibnVmdTJRdDMwd1FQc3gxaFo1aFg1eDArUVRX?=
 =?utf-8?B?YmpJcHdSQjNaWkhwUW5yc2hDdUNFMTYxWFo1YkJZb3N6ZHRrUDYvMTdwVDJx?=
 =?utf-8?B?TU93S1g3OTZyMDQrQ0htUnpMK2F5T0RXc1NtUU5IbFJUY0JBc254RWNCUWRW?=
 =?utf-8?B?U2pXNFJaQ2JnMHRiR0NvMi9Gem9rell3SFhNTEJjbWlRZjB4bGg5WGw3U3Bn?=
 =?utf-8?B?bVFiSG52Qmp1YXQxRldkMWc1WnczY2RHaGp1eGFobVBzY1ZndjVmNjlXODNt?=
 =?utf-8?B?Um1mQjlURkJJcHgrMis5LzIwTTl2dEZkbmJBT3RxOW5SbjRZOHQ1WWE4VnZP?=
 =?utf-8?B?cjBKSjFYVUZxaWRhRnNZN0RJRHZiVGp1ZlhzWWpSMlBoRGc1VUY5WTJtSUhF?=
 =?utf-8?B?MUxHNXFyVHJjN3ZZOEpyTkdTd0JNZnVicWg3bXByUXFyd2R1K3RUSGhwekZN?=
 =?utf-8?B?eDJCeFlsRDBmUVlaTWY3d1dXZ3crZkd5WXN5NWFDSXFIanNEUTVCV1BsaGYz?=
 =?utf-8?B?WW9aMkRIZlFlWmc3WXJrbG9PREVZaU52NHlydWRuOUFEVmZyZzZHemxxUFk2?=
 =?utf-8?B?L3FwL29XYi8rNlhnOEd3blRCYzJhWUVVWmhKdHpZYVlnazN0T3RMckh5MTdO?=
 =?utf-8?B?aHd3ajZYRXlITjdVVHFtYUZsVThZVDFYMjl0WWFvemtkUUxKbEsveWZ6cmM2?=
 =?utf-8?B?SlUwY3BxengxTU04MVNpaXN1NllZWklGVXFtWm1ubXl2WHY3OFQzS2k4V2Rn?=
 =?utf-8?B?enpGL0tPVjlndURla0czN0lGZUJBQnpnR3h5b3VZWThOY0FrR1prU1k2Y00v?=
 =?utf-8?B?Vlh3MTg0UHFPSlRlckdBdWpkd09FWk10M2FoWS9wcjJKc0tGMlM2cUxrQ0ps?=
 =?utf-8?B?eXhmTWVWNDVrYkxUQkpRV3d1ZXhSZzB6a1MrYzJOcXAxM0R4T2ZoZFF6NWFO?=
 =?utf-8?B?L3ZhMVJkaGRZemgzNHRyNjFUTG1TYUN6WFlYUGVMSGN6b25VaEJrZW1sc1Rm?=
 =?utf-8?B?d3p5TmlGZEp4TXdHaHA3aDJoZ21IcFc4YTFCVjgyMFdWNTJ4cktBbzZIUzZH?=
 =?utf-8?B?Qi9rYXJiaHBqTjBzYW5uTktHby9LT2lodVdVTWtsVnBrMVVhUTNwQ2k1Y283?=
 =?utf-8?B?anpBTnRPVGtSRVBRcDFpOCtEbGhrenRYYVRZTHZMUVlQYzFwMGo1STBzTzFt?=
 =?utf-8?B?ZzVIWmJieW5waFluMldIQjRPM0c4VTBBckthQmpPdEdwOTh2SVBiR2VEMnY0?=
 =?utf-8?B?aXFvYkszV013TFg2UkFYeFg0aUFyVnM2cW5wa2JOVm5OTDl1RGl4TGYveWd1?=
 =?utf-8?Q?V1QVz31pKQ4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dDlDZmgyR01mWW1IeTVBTFFtaEYvSkF1aW04WFhidldvU0tPeWN6MHFWMUo3?=
 =?utf-8?B?QmlYR3o3OVlJbEtZM3lmdUhvaTNZcXl3K2NNOE80ZFc3aEt6M1ZBRW8rNG1m?=
 =?utf-8?B?aVhaaFJKVXBOOWgyVndETVJQRTh0YURlU0FFNHcrNHJaZU41bnZoZGtvYWFN?=
 =?utf-8?B?YmdIb09LaUxKVHdyZXVwdkhRcWFINkhEMjVCdTdHOFFFRmk0dmlUVy9ZUlNU?=
 =?utf-8?B?YXRoK1ZFRzdNSG9QNHQyQW9uRW1TYmRDTms1bkxqenR1dExxYnArWWpHbjlM?=
 =?utf-8?B?Z0lKMWNrd21DZXJnRkNjRWRFa3I4RG1vcUdiMG5RekpUVmlOMzBiQW8ya3VC?=
 =?utf-8?B?OHRmclc0Y2pCcFc4UnhIQk1pMURMM0c2RFl1VFo3ei9GY3RDNnFRZ0g4QVd5?=
 =?utf-8?B?bTRKT1d6UElYYitaTUhXNUV4YWJqTVFUdnZDYU50OFNnNUFDMXpaN0QzZitl?=
 =?utf-8?B?dWRBdHVJbE5Yd3YzTUNxbWgyblBYNGYvT05lcy91MFVrVEpVYkU1ZXluemlk?=
 =?utf-8?B?bkE4azl4Qmd2eGJZZXc1dnUyNGV4NGwvNnJHaXpvVks1MU5kbnI2bVJObU9l?=
 =?utf-8?B?a0tmcEx2M3g1R2lDMXhNT2lQclY5b1hOTXR1QXZNbWNnNFFXZFRQakpMakpu?=
 =?utf-8?B?ZmNJNnc1cUtTRzdoWjhrTk5QOFQxWlM5S09idWs3UG1lZEJvQlBJYnRRbG5J?=
 =?utf-8?B?M2tGRTBkNmVyOVFrRGNGK1loZDllc1JrUG5sL1AyU0ZOY0F0dloyd1pDU01H?=
 =?utf-8?B?T3hxSFdFK0RwYlY0ZnlYRHB2cmo5RHczckpjazVtVDAxUWFXa2NRQlBWalJz?=
 =?utf-8?B?SDF4ZG1jZndMa1hoQmYwZWFUWU9GWFNicDhrZVZxYmJTN0JpdkhaNllCSlI1?=
 =?utf-8?B?MGhiTVNWRHV5WGZuUkF6djdmUXRXYWFxMmJuUG1Gck5MbGhLL3pFWDhFVXdP?=
 =?utf-8?B?OXMya2lPa3NwQlFKZWNSYVprS3d3TEpYbTdsKzFMU1RITDBSYTlka1FxK2Ex?=
 =?utf-8?B?TUNYeFlhRUkwaHBQSEZKU0VseUNzeHMxVHhSS1BNc09KZllqT1BRdTFXMHJ4?=
 =?utf-8?B?Vkk2Q1p3bjJlKzl4SHBPUS9ldXVXSzBOSjNRTnJXbkZta2RUcnZsMnE0YjEz?=
 =?utf-8?B?SkRZM2RNY2w5NEF1c2RuRzRYNjNNZWhBc3BROW1uSER5QklQVTZIT1NFSUla?=
 =?utf-8?B?UGJLK1htSnY1SUlDTDZIa0JBV04rMjVqbDJIam1ILzBQUncvcFA5c2NTdDA2?=
 =?utf-8?B?aXhCQnJHMjRma3lFelpKQlpKTkUrWmRsZEdUMG1wdFZzUzR2MzlsRVJWMHNy?=
 =?utf-8?B?bTRqVW9pNWVCWVYwRTVIUTdwMmtSb0ZkV1I1bC9OS0t6ZEg1L0Y4aHdsc3d4?=
 =?utf-8?B?NFV3bnZIL1JhOXN3d00rM3Uxa0J3Nm5XOVpGQmN3YW11eGtUUzVjZUJTUTZz?=
 =?utf-8?B?STh6NkZjeTkvc0tvSWZ5UlNsTjNqbUlLSm1CT25xekpNc3hDQUtZbll6WSs3?=
 =?utf-8?B?V3JXSHZreFRVNjZ3VDRraVlRQmJnWDk0cVR2Q1VoTmNqc0Rodk1KRXZCd2pW?=
 =?utf-8?B?UzNGYUVBTUQ4aDc5RExldm1jMFRrWVVWZ2piSlJuOGYxZ0RwZUl2SlNTcE05?=
 =?utf-8?B?SDkybGM5QVM1Q0ZsYi9YVG5SUUdHUlpJUFVkZ2h0ZVNIUmpBWC95NjlnaVUv?=
 =?utf-8?B?cTZzRDNXYm15OWFXSWYzS21PbzhNVGt6LzhMdlU1WFNpV2tpRy9EZDUwMEw3?=
 =?utf-8?B?OUpOS1hEaGF0YnE0VXFmYUU2RVJtQjRJR0N2ZzlKMTVQb1IvZFB6SlBKaGhX?=
 =?utf-8?B?VVYyM2Y3dzJVc0t2clpYTjd2OVBsS0VzQU9Cc1lCWVkzb2ZVd2xQS2xDTEtj?=
 =?utf-8?B?Qk9SNnBVR2psUkNkbTVyVjVhakIwZjZVVHZEMUpNN2Y3K0c1ajMva2RnRTBy?=
 =?utf-8?B?aytuMzkzcC83ZmhxM1d1YVZ3TTVMaXJnWnF3RkFZVyt5L2ZRdnEvazhZOXBZ?=
 =?utf-8?B?RllRbWJMM05iTm9jNUdrT2p3SEc5SG5URWFFUGhFYWxDMXBNREVqVW4ydTVT?=
 =?utf-8?B?RXdGNWFOTHBNQUNyN1NGZjdHRXNVb254d1R4dzgwY3g3QnRJLzFmUHNzQi9H?=
 =?utf-8?Q?Kyxl17/ekGQU0ICqa+SNjx6iG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PTmJROv0HOxOk+qguKBnkh1DSbSfoj3fnMtvs6K/6+vlipcHfrirC3ufKZKud1ouApcPguEMTMMugB4cyexMWdFoqMHRwNWFXqE9OrdUE5k74DMLb/R+Oq2wi8qMnSuKLLLAxgy5xGWLifr/9vafv4xifll9V1zxj4wpxBLnjzD5fabKvOKwHqHA7XoU/iY+X5MdeeqEp1ZKyPKNH3ITOcLT1bG9Q88GZ+ZvVbgcnFRG32rCGSNcBvY1CpbCbicJJdlUesjjZs/U7S1ONvcKpTHcHCfTWie31itOW8Ar34d0Cp6dZxT3uxWzJXL9+KfIPjXPP2js2jL/26zJBTWzHYm/t4x8rz9YK5oGxtnIcKowXgwm8bBoW/DOMsVMWG0zSLBD5HBSeWpYRDYpo0j0MVsFyrky/N3k+1uoj/1b51QHCZ4y0GLa0X7BaUHIDE66mrMv7RqN7XM8JmvXpP7iCizvZmiU27ysLx31+QFAcd4yoJSt2FzC1naen0VgTjm5VPBL8dHswzHT3jpsOurBC8hNAhWx9KdgcNlzn5lKgV0Q9I63TyA/VMeqZczlelKBKnSV+xRLEOhj+ligS4yobaZfuAb6YgR5tbmpVgRK5Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94734063-a5b8-4a0e-3d17-08ddd6a54620
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:59:09.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAEjrVIwKsyoLsb76eTtKeeO1/CfLvgBnSLlodhtFreqHh5nCvYu0rpW8cylZTAuJSeAqX3ToSJWwjBecUC+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA634C6E92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080146
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=68963af2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=sEXsOmny38gNQJFFvysA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: APD0Ibc6MkfX5afGM0lFnRO3o2YVhCR0
X-Proofpoint-ORIG-GUID: APD0Ibc6MkfX5afGM0lFnRO3o2YVhCR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0NiBTYWx0ZWRfX+xpKzFwwfK+6
 YfNGB1xUqSD/s7DGTKLvxt/66AUyMMf3PHNDP1oK93IaFlUAh5k9HGr3w9PM9xiy4GuvvZ1xuxY
 tfLqITz/Cn4EulOqDpfwqe5BN6IznUsg24/TlEB1gsfkgiwNYuJ1IairurQVBHU7V1Irt9uv/kK
 a3Q8VXRbyQqeGg/PJbFwUTlT2rXSq0zO49rI0vVcKC6kIrgV96UIvGJsiRjkaGrWlXqCm3Wkxqi
 2B0C/Vnvv4PwNiw92+jCiPqhSODOJhLqHawRM0c6v/0pMjHK4BY48E8g7RmOpk4gvQD+MkjXywa
 DRw1dQQmZbWmjfG9w8Vk/kmRmDnko2+kATssvL5QOLazWq7fDly9qwYgVYqAaRxN1LN0dLRLN5a
 U/2FAp8YpuHRjdXVxnbKJd1WSFMfS7mK1h8kaerrWjE5ACviLbi7baajohrbOUOVMkR7lyrz

On 8/7/25 12:25 PM, Mike Snitzer wrote:
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/filecache.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 5447dba6c5da0..5601e839a72da 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1058,8 +1058,12 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
>  	struct kstat stat;
>  	__be32 status;
>  
> -	/* Currently only need to get DIO alignment info for regular files */
> -	if (!S_ISREG(inode->i_mode))
> +	/* Currently only need to get DIO alignment info for regular files
> +	 * IFF NFSD_IO_DIRECT is enabled for nfsd_io_cache_{read,write}.

What happens if the I/O mode is changed from buffered to direct I/O
while there are open files? I think you will need to collect the
alignment parameters on all opens regardless of the I/O mode setting.


> +	 */
> +	if (!S_ISREG(inode->i_mode) ||
> +	    (nfsd_io_cache_read != NFSD_IO_DIRECT &&
> +	     nfsd_io_cache_write != NFSD_IO_DIRECT))
>  		return nfs_ok;
>  
>  	status = fh_getattr(fhp, &stat);


-- 
Chuck Lever

