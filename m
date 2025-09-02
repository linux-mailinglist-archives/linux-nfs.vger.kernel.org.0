Return-Path: <linux-nfs+bounces-13976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00DB40621
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86D27B14A2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BA246778;
	Tue,  2 Sep 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNumbvtt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GzxuxneF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD026CE2A
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821885; cv=fail; b=iqK7GBrSygesYONkExzplo2iO9f2iI9etPMdvb4eiAtavuwg95lXTHcuOKiinNsOmREL7lCY7LNSOXVknDfPXYUZVy1rPZvLM+KDfV0SyCuQ3Tao8PiwYkKNmFAAo3N3lPZ80kG39w899tVo02c4owjzATvKoVUXzIls0VSjr3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821885; c=relaxed/simple;
	bh=3ohiPO/nhmPCLQqPdhhmaUFL/rLeLku9YLC13SbgRD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wpv6TDYWLvj9cilELE9gievI3POyuJ/74/R2oYAv/jMYtbH82TK2ghAfJpEeaM9oef/7Yf/zbPflOEw3UXb0Ip8lOudXciSmO/OTvb0miAABGBwVjP8U1/6dL6SAAXkQEJj4XYA05qk9kzlwocWoXo+txvUnBcykJBhdRb+/rE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NNumbvtt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GzxuxneF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DfrIK012413;
	Tue, 2 Sep 2025 14:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1K1vj5ewhZTtx7SevHUftRrLKSx9QP4Twcn4dES8o0Q=; b=
	NNumbvttEqkF/ws8j0SqUgYcR3DSvKcwyacPlnCVflHonYH6vtaglMKMMZ7FGJTC
	wVkTeo5HdMPX/ZoBskW2VxupwfqJFR41MXZ7aHzjy7ClTz/U6juKj0Tu7ovZf61Q
	xc2OCg/N/pnJHBy1Bs6mjdtxHutLP4Cf4u/7pMsfzRu0TEhEy9pfI1hHCyFDvu9v
	IyXMfz1gIAtJsG5XVwLZWnp7p/7yhcmGpvbyr/r+62rSYSuMnaEP1z0ezvqJ1g2d
	jQlxG1EVk1k5O0aHnm53SqwYJ9oyklEzV6zzoxNq3Xq3nPaotqvgk7uG+B2o2Mlv
	yv88qEnTFAvb9chGIlU7Ng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4km81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:04:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582DLvHb040837;
	Tue, 2 Sep 2025 14:04:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8wgxe-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQyquoTQZ5iZzE6WHZMTsXjuYUNsEJXm+liY3G+AR77i0jNyhK0MT12ACWNK8Hjm5mnunulTU4RaSGHP9Yrsx9Q05MPJ6s1JG/mxR85j8ui8RJIw72Goh07u4K8gpHE4fLZ68oyKbF5xetK42wf/Ac8HJbGABl/MmQcW9QfxqAqSEXpiv7w2+g/HS+2uSYZmNWp4AH5ZF09ldJHMXOk5W+QRruAdqOqlogFnYtQFZw9tYwB1pmc2ms2lC1v6TWs/AClHJuCDkqm2Uoj75+2e7atzz6O9LexfkCfP3pu7wf7l5ZIVbDXWx6PjJg7TTvCf2B6jwjDV42LKPsmvVfV0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K1vj5ewhZTtx7SevHUftRrLKSx9QP4Twcn4dES8o0Q=;
 b=gt44sZAn9LwzgSVIl//m15kPcxlT/lmJRy+M4np5zKRGYFHgN0XvLu+leyzAJjmhyf9QBZRyH4ZcNlDcdAEAW8SA+BPuqI9k+uaQNf/xOAKI34nVQWUyH3zukt0fd6yrhZ0ynZuCAAUtDHZEO3nSysPXysJm+Qub7n/NttGIBHlKf3zbYhrTqdFsVgbRHpnEvsoCRAuxLvV+++N5MF293qcVU8qQKaORWV9t5T6QUXA9aXUGe9kCMGsZ6j6kReNfujczxV0VllbsRi3cEvwj2S4tN2gf1cB4v7HxJw46U1aQLpOg0cRASZm7H103vrKp+BH2KXQptcHMMVeuBT+WPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K1vj5ewhZTtx7SevHUftRrLKSx9QP4Twcn4dES8o0Q=;
 b=GzxuxneFDXelhCVWPqWChew6sa1SJK+jPLa2jvAYU/mFKAUTBENugmvXS7CFhG4xWUtyUdEm+MY6RWtHPzTZqGHErSMac6CXj9KKBw1XCfvhlwrNYhHWEp9RwzZ0xw/9KtW93dy/suTserFWTTHQqEAtpFYPxCEI/ESdZxHGWl8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 14:04:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:04:05 +0000
Message-ID: <bb80e3af-8a1f-4d5c-859d-5e9f64db76f4@oracle.com>
Date: Tue, 2 Sep 2025 10:04:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250830173852.26953-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:610:119::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b6ddf1-a43e-4a3b-fa58-08ddea2993b2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a1NSMXVUV3Z4K3UzS0VsVlJoOUNSakljNkJPeUJOeE1KMm9uek9SM3NzbUxU?=
 =?utf-8?B?NFM4S2VxRHNEUUxEUXJJNXdMakpMYlJJckxLeWhWOHo2SlRqZEZ4c3RTY0NJ?=
 =?utf-8?B?NGFmUEg5aHNYYmZlNXJUWVVmKzVSczhaZ3UyQXE2Tk5PMEhvMDdSMXk3a0Fv?=
 =?utf-8?B?QWtJV3lIZFJrbFRQS2c2Sy9TbEw3aVYrd1FycVJqRGF3d3ZOekhLc000NENE?=
 =?utf-8?B?WGVwaDRzbHJqejFVdGJnSmFGb2tuazJ6c0o3ZEVYZTZDazI5dWxmeGdrVTVw?=
 =?utf-8?B?Z05CY3dQNEdRQVB1L2swWkRJUVZMcmVHb0F4NUh3Rmk5UWFTcmdQS3NpdjRy?=
 =?utf-8?B?bDdiUDFKS1Eyd0pIM0R3VEdaVlp5cEk5N21vdW05ZjVXMXA3b3NOWjJRa1do?=
 =?utf-8?B?WVNpaWZxTnFXYTcvM3NGZU4vOFl1eXc5TTZxcjhKY2hKcVlNQnlTTG01TFpp?=
 =?utf-8?B?aEpuUlF5T3N3SDk3Z09kVkFCc0piQXY1eDExdk00QkhUSjJJWC9obW0wUkdC?=
 =?utf-8?B?ZWM5UDRQZlUzU00zQjJPU1RGMVlJNnROSzM3SVRhdTU2c3FrVk1icU83R1ZH?=
 =?utf-8?B?WjBuZnNEQS9UcjF5ckpmbXlNWXhCQlFPcFR1aDR4anlZUldXOWZXMlpFMkt3?=
 =?utf-8?B?Mm94ZllnZm9MclFjYW9PdzI4cnJmaElrZ0dEOWFzLzlNeHpsWHQwb1o4MDhB?=
 =?utf-8?B?a1hTU05NaFh1NmUwclR4NDhwMzI1Q2gzQmhNUEgvWDdJZCtXZjBJeVJ3Vlpw?=
 =?utf-8?B?aTFrTm5XMVNqVXk3aDBEaC9SR2xweDNmRnZQd0ZDMnloOWdmT2VxREVKTDN4?=
 =?utf-8?B?eFFlOG1vUGpzSWFxd2pRbVo4aWtzTy9YaXVzV0dZa1dkSVFlaC8xMml4a3lL?=
 =?utf-8?B?WUNKM1VHNHIzWlJWcS9wdkQvbzZwNXY4cVlzV2lvamVNSXo5Q2V4SGxyOFM0?=
 =?utf-8?B?TzB1Wk0yUlVFaUxYWEdWS29NcXBISHEyZjBoaWd2OERwUVZFcmxoYWt4dzNO?=
 =?utf-8?B?Y1A3elpwKy8vU0FZUTg1dDFXNFpEMTJqeW9PbHVnSS9aZXJOaWgwdTZhcjJ6?=
 =?utf-8?B?UXI0YjdzOXRhVllFR3RCMXZWQlNZWHRTaU5Gdm5HNXFteTZKUEdJa1VFbXdo?=
 =?utf-8?B?VEdjYk5DT0tRZ0JpK0svUUJ4Tzl5RmtnTEtOVWZFMUU5dHErNUdGSVZNa1M2?=
 =?utf-8?B?TzBrNFNtVkRzM3c5eUlIT0N1QjhCdTEwNGJ6YmY3TzZaYVBPbFZiVDVLQVd1?=
 =?utf-8?B?bWNXZFhNMlEzY0lQeVJqZXdkL2hPbFlzM3VPUlgyaVRYR0JDQlhRZmE0UlZo?=
 =?utf-8?B?aUlMK2pHQVVHdjVRdmJBT3pWK053WFI3RVE0TmFaWVZMMytXajMzUHJGNXo3?=
 =?utf-8?B?RmxnTDVoNjdiMHpkZnNmQWZhdUtYSFhVbFJPK2VIM0J4aEFPN1FmdEdCaEJH?=
 =?utf-8?B?bXVsRnc1Y3hleFQ2elc5VndtOUhVN3VVaTZ1bU15RUJoZG5MOVdQenlPU1Bp?=
 =?utf-8?B?WXFGNkRVYlp3Q1Z2ZG0wZjJHa2ZpVHkwclVRTFRVVlErblNaam1jcUZGeE9U?=
 =?utf-8?B?N0p1TnllZHErSXg4L1lFMTFac0xUM0ROM0R0bGJ4T2ZVaHkvSzl5b1VUQ3Bv?=
 =?utf-8?B?MTUvVkF4MldkRFMycjNtVXJsRFR3dnBpMEsvQStMWEV5VXg3TlgxZnRTYmFv?=
 =?utf-8?B?ZXBkd2R0bFdLVzE1eGFPOTJuM0pQcURpM2ZQN3E3U1NyamRjMlQwTUNrUVFk?=
 =?utf-8?B?NVR4dFYxTDlUOWpML3M4M1FHYXhJdnJpV0FHUzVEZ1d3eExjcnlWU1ZHRVdY?=
 =?utf-8?B?QmRCWUlQK1VGNVZRYmdjWkcxcTRWT2xzaWhDeDdMKzk1dW4zTlVqb05PWHdr?=
 =?utf-8?Q?BGZu1DI27ZNOL?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R1N3L0tCa0xTUDQ4d1FXaUNXTEcxS3hrOEgxVmExMHQ2bmRJUVVnOXU2VC9S?=
 =?utf-8?B?ckhoTjVFTlR2SlBXc3NhcjBiVVdDRUY3M3g3OE1MTHU4TURaUlVST1pHcDVq?=
 =?utf-8?B?UTVoM1NNRDZHOExDWVVNUDBiUzc0ZVlMc2Qzc3ozZDl2S2NSVDRKL1IraVRa?=
 =?utf-8?B?d2ZsdXpvWEJDZ241YlYwSmhIenNwdTlJeGROU0l6bElleGJyUkJsRTJOL3JR?=
 =?utf-8?B?L0d1ZHVuRmxiMHUwS0xsc3k4ZEduSEZlSXovYk8xOGxHeWJzZkU5a3pJV3Rq?=
 =?utf-8?B?M2FzSy9nd0RZcnJqOGt4U3J0T1hjNnZla1hlLy9zMWRGTDd2ZnRsbnk3eDhJ?=
 =?utf-8?B?S0RzV3J6ZmFRNllpelRtc3VWak1aaElqTTJMWDltMldiSjlrOFJvZnp1R0tT?=
 =?utf-8?B?dE5yL3BScmZ2YTNjeWpqTjVKVUZOYlJuS2M5U2pBZkMxQlFNZWFXWHQvR2t1?=
 =?utf-8?B?UWJ3QW5rRXhiUW01bXJPZDEvQUxwdnpQY1BjSG0xSFN5Y1ZPUm9PYlEvU2pK?=
 =?utf-8?B?ak5yc0ljN1MvYzNKT0FTb0xLeksxR0VpdmZpazBWNXljdGlTcW82aUd4dnIw?=
 =?utf-8?B?T21mT0lTNnBIa0NLOFh4d3RkNTVublVGT0pPRFdXaWlGVHFXZ21ZK0UzaU9W?=
 =?utf-8?B?MHZnN28yZWZiL3R0emhnOStTRXEvRzJQR2UvNGg1Y0JVZzl1dlcxcmF0ZEJj?=
 =?utf-8?B?SEZObmY4eUptL1YyeHBSbmRucUFWUWZ3aHVTMWZFNzlPV1JXN0xtNnVRUE5x?=
 =?utf-8?B?d2RPcHdFdmJraVU2WXJaNVNzK25yU2wybGlHWm82Q2NwRmtHZXZubHkwVUVN?=
 =?utf-8?B?anE0a3dveWFvZHI2UXB2aU1vV2htbW5NTGs0UW5vUDF1cklRWTdvUlNGbzB5?=
 =?utf-8?B?aUtBZy9sTG9KM01MWUxwcjQzNDVlb1R1a2puekZIaklrNXM1bnZzcU5QYXpq?=
 =?utf-8?B?VUkyQTJZNFA5ZSs0ZDBZbGYzQk9QTFkzWnhQR3JQL3VwNFU4Z2dNdlA2NG55?=
 =?utf-8?B?cVpXOGpVWTR3QkdnaGZDZjZveTdNRS92TmllVmxJdHpwL1FlanI1Y0NjS2Fh?=
 =?utf-8?B?UDEyK2NCemUwZkswRHdnWGJWWmdNN0xDMGdHcVdmMUV4Mkpud0NBajkrdStl?=
 =?utf-8?B?cXRkRUpOSFVleGp2cG1hMmZPbzExYS96S3N6YU5Qd3dxcUdaNnZibEg4ck5Z?=
 =?utf-8?B?aFdzZEhIVFlQeE5LK2RYWTdvQmNLUmtzRnZvWVh2KzA1dEJPT3diWWE4MTds?=
 =?utf-8?B?ZjF4dnlNaUExL1haUFFqQ3hjc0U4ZGV0OUNEYnFsYlRGR3lMUGZuOERjTFVQ?=
 =?utf-8?B?eG04Vm16RVBUU3AwdWRoWWgxR1kyQ294ei8yNEhtdHFFWmU1VFZnL1FwcG9Q?=
 =?utf-8?B?SGlYTmI0WFJSdlJUMEd1TUFSSnhIbHQrQUdCaThyUlNCcForbXE1ZlhRek0v?=
 =?utf-8?B?ZkZ2aHozRkhVeHh4R2JhdnJWdnNzdXZ5SjA5QWVkR2lZYXhXVmFsVHZzcitC?=
 =?utf-8?B?RVhETE9ITWpuOGQ1VWUrMERSU1dFUG1lVHprTkxLcVExcnlITlRqMUdMdDgy?=
 =?utf-8?B?bHdZQ1A4UzJsS3Bucm9UbUVwQ2MzWGp2RUlOR2tCTUtoUWVqZ3pQM2o3Wmhw?=
 =?utf-8?B?R1haak43Q2R3NjRPemM1L2NHU0ZLMThEekxJUU9ZT01DUi9teFBzRzJyRUky?=
 =?utf-8?B?bzZNdGZBaWZiUS90dUcyZVVZamJxOFRyMVRzbVBhYmhIc25MeWI5UDB5R1lD?=
 =?utf-8?B?S0syTTFkNFM5QWkrSUsvVDRmSGptRXc1aGlGdGlGRjRmaGtJdUc0Y3d6YXIw?=
 =?utf-8?B?TVQ3SC9ZbHNJeUc4aGdlbHVINzNoaVYxaldOaHJncy94bkJnN05EMmtXbVN3?=
 =?utf-8?B?eHRudWRCRGNrQmlFM0dOaWo0REs3azkrTUdXeTNTSW8rYXIrRWRydEdTUDB0?=
 =?utf-8?B?V0tXTWsvdXp1SVVtaDVmQWEvTXJKa2lOUTZBSVFUSnltWVpEU0I5UlcyeG96?=
 =?utf-8?B?aUtZSGNtckhjOGxxZXVHN2hSNEMveVdCVEhNV2s3QnFJREdqWWg1S0VEM0tJ?=
 =?utf-8?B?a1JocndBUFh3Y2tQamNBaTg3Q1Q1NWttRjNwNndlRm0xbUNZbjE4VW5lam1a?=
 =?utf-8?Q?Vee0FfRD7dl5wLgQWuqImsh+e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 8i4KdyRk8bSRUJgCybwQHVrl9vK4xCKPFdNwA+iX2nQo9yDF3iUEvSzGXIVrxXeLB1miaVJv2YZmQeKnDjDmYncjkeVOlBlkQwz7Rw/xJSwc0xk0x3R15pmqmwrcCd65SRvB3c7ZS2sTtTb8vjdeRXGBqGY43yBi4jQCHtebaTEy4Iyx4TAo92N3SUjoe72bJ/wzK3j251gkOlmgqOL13vpoXaL6J7uCjW+Gd8OyaBRNAIGQ10B19mPNCcHXydQn4EyITT2T015fVy3tywZ9edCXTm93Upc6Pp1PLK2ZxvdxbgNGh3GagP2iwSYp+0CZC/ad5N2W9wFfRE6MxlsUc48F63GEVkFwOVlc4UY7DQRWCHabPQSD1MCcLjun0tG7vrt389ZzkPK+MwmcKcv4v0LGK7lrBVXcoRelK1yjJip/VluQ/5xBAAOXM2XFo/Bjo1vYLzbxEbmmd2jzYG3IKhSwOFTfBFXNGmJYwJ8/4SUhG8ePDXzO1PldENn1JVGcIDnuZQeM11FAMxD54eyCZB3A2XjN0tUD/2/YYmrGlIs+z10nCRNv0LNnHkanXEfKE9DuZFhFMQMW6PdqwQTlKAEHDScaIr8njoWvu1E0pAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b6ddf1-a43e-4a3b-fa58-08ddea2993b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:04:05.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsNd1BV54CQFpa6r6DTJ9Xz2iDHzGqVqN0Iq+/SkndJHZC3KD32d9dM4jOgky5vt+Xvhh/lKabo0owkoCsdUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020139
X-Proofpoint-ORIG-GUID: uBxwa8Nsk3dWKFSbZY3dsN-pPOF_fiI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX0UZxT1ofa1QT
 pGkuGWRnkOGbfYHsBUeuThuSJbQ0esPnMShY8//SMBFCHBSTc6Sj9M2X33ob6rDVR8fDTk5shZl
 DfXJzJl7BGcAGo8/TaDFjEdQbN/nuy5GctNuaumB+yZebMw50NhoC4sPCvfYvCRC6HuyW1shkYJ
 KX+3lA9FutyP+/ivOomkY+SGicnJySM3dvc+iD8NamkuqAxhBAQiEKY8AJiq6B3Oqg2/p2tWS4k
 ICqTA0776htfNt4Y+RWPC4BdO6Svot9Sa5pwjHI+c3Mi/PNfHbhAMTY7R6RJUMX2KGWZqWKfaqm
 A3Qj4AGze+wAT1Ff3HvZ0pr8yJIql6f4ptD8wfQfyuWuQi8ObFZteAoHI7rjtSSb4zqwSzxcwbn
 10Fb0TQ4
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b6f977 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=SEtKQCMJAAAA:8 a=ayCUYrDm6Xs8eFbvNhAA:9 a=gQcZ_1DtsBQKkBR0:21
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-GUID: uBxwa8Nsk3dWKFSbZY3dsN-pPOF_fiI8

On 8/30/25 1:38 PM, Mike Snitzer wrote:
> From: Mike Snitzer <snitzer@hammerspace.com>
> 
> Chuck Lever advised that allocating a single start_extra_page, to
> avoid RDMA corruption on client, definitely shouldn't be needed:
> 
>     "There's nothing I can think of in the RDMA or RPC/RDMA protocols that
>     mandates that the first page offset must always be zero. Moving data
>     at one address on the server to an entirely different address and
>     alignment on the client is exactly what RDMA is supposed to do.
> 
>     It sounds like an implementation omission because the server's upper
>     layers have never needed it before now. If TCP already handles it, I'm
>     guessing it's going to be straightforward to fix."
> 
> So avoid papering over what seems to be an rpcrdma bug, remove the
> allocation and use of an extra start_extra_page.
> 
> With this patch applied ontop of v8 patchset [0], I get the following
> data mismatch errors at the end [3] when using the NFS RDMA client
> with reproducer documented in associated patch header since v2 [1]:
> 
>     "Must allocate and use a bounce-buffer page (called 'start_extra_page')
>     if/when expanding the misaligned READ requires reading extra partial
>     page at the start of the READ so that its DIO-aligned. Otherwise that
>     extra page at the start will make its way back to the NFS client and
>     corruption will occur. As found, and then this fix of using an extra
>     page verified, using the 'dt' utility:
>       dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
>          iotype=sequential pattern=iot onerr=abort oncerr=abort
>     see: https://github.com/RobinTMiller/dt.git "
> 
> I really did try to call attention to this misaligned DIO READ
> alloc_page hack to make RDMA work, see [2], but I didn't frame it as
> RDMA specific and definitely should've been clearer on that important
> detail:
> 
>     "Also, I think its worth calling out this
>     nfsd_complete_misaligned_read_dio function for its remapping/shifting
>     of the READ payload reflected in rqstp->rq_bvec[]."
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> 
> [0]: https://lore.kernel.org/linux-nfs/20250826185718.5593-1-snitzer@kernel.org/
> [1]: https://lore.kernel.org/linux-nfs/20250708160619.64800-9-snitzer@kernel.org/
> [2]: https://lore.kernel.org/linux-nfs/aG2MDVyyCbjTpgOv@kernel.org/
> [3]: partial output of dt utility that shows NFS client READ data mismatch:
> ++ COUNT=3
> ++ IOSIZE=47008
> ++ dt of=/mnt/hs_test/dt_thisisa.test passes=1 bs=47008 count=3 iotype=sequential pattern=iot onerr=abort oncerr=abort
> dt (j:1 t:1):
> dt (j:1 t:1): Write Statistics:
> dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
> dt (j:1 t:1):       Last IOT seed value used: 0x01010101
> dt (j:1 t:1):        Total records processed: 3 @ 47008 bytes/record (45.906 Kbytes)
> dt (j:1 t:1):        Total bytes transferred: 141024 (137.719 Kbytes, 0.134 Mbytes)
> dt (j:1 t:1):         Average transfer rates: 1004137 bytes/sec, 980.602 Kbytes/sec, 0.958 Mbytes/sec
> dt (j:1 t:1):        Number I/O's per second: 21.361
> dt (j:1 t:1):         Number seconds per I/O: 0.0468 (46.81ms)
> dt (j:1 t:1):         Total passes completed: 0/1
> dt (j:1 t:1):          Total errors detected: 0/1
> dt (j:1 t:1):             Total elapsed time: 00m00.14s
> dt (j:1 t:1):              Total system time: 00m00.00s
> dt (j:1 t:1):                Total user time: 00m00.00s
> dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1): Warning: The bytes written 141024, is less than the data limit 1880320000 requested!
> dt (j:1 t:1): ERROR: Error number 1 occurred on Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):
> dt (j:1 t:1):                   Error Number: 1
> dt (j:1 t:1):          Time of Current Error: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):           Read Pass Start Time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):          Write Pass Start Time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):                    Pass Number: 1
> dt (j:1 t:1):              Pass Elapsed Time: 00m00.10s
> dt (j:1 t:1):              Test Elapsed Time: 00m00.24s
> dt (j:1 t:1):                      File Name: /mnt/hs_test/dt_thisisa.test
> dt (j:1 t:1):                     File Inode: 1199 (0x4af)
> dt (j:1 t:1):                Directory Inode: 1 (0x1)
> dt (j:1 t:1):                      File Size: 1880320000 (0x70136800)
> dt (j:1 t:1):                      Operation: miscompare
> dt (j:1 t:1):                  Record Number: 2
> dt (j:1 t:1):                   Request Size: 47008 (0xb7a0)
> dt (j:1 t:1):                   Block Length: 91 (0x5b)
> dt (j:1 t:1):                       I/O Mode: read
> dt (j:1 t:1):                       I/O Type: sequential
> dt (j:1 t:1):                      File Type: output
> dt (j:1 t:1):                     Direct I/O: disabled (caching data)
> dt (j:1 t:1):                    Device Size: 512 (0x200)
> dt (j:1 t:1):           Starting File Offset: 47008 (0xb7a0)
> dt (j:1 t:1):                   Starting LBA: 91 (0x5b)
> dt (j:1 t:1):             Ending File Offset: 94016 (0x16f40)
> dt (j:1 t:1):                     Ending LBA: 182 (0xb6)
> dt (j:1 t:1):              Error File Offset: 47008 (0xb7a0)
> dt (j:1 t:1):           Error Offset Modulos: %8 = 0, %512 = 416, %4096 = 1952
> dt (j:1 t:1):    Starting Relative Error LBA: 91 (0x5b)
> dt (j:1 t:1):   Relative 4096 byte Error LBA: 11 (0xb)
> dt (j:1 t:1):        Corruption Buffer Index: 0 (byte index into read buffer)
> dt (j:1 t:1):         Corruption Block Index: 0 (byte index in miscompare block)
> dt (j:1 t:1):
> dt (j:1 t:1):
> dt (j:1 t:1): Data compare error at byte 0 in record number 2
> dt (j:1 t:1): Relative block number where the error occurred is 91, offset 47008
> dt (j:1 t:1): Block expected = 91 (0x0000005b), block found = 1919311731 (0x72665f73), count = 47008
> dt (j:1 t:1): The correct data starts at memory address 0x000000003c589000 (marked by asterisk '*')
> dt (j:1 t:1): Dumping Pattern Buffer (base = 0x3c589000, mismatch offset = 0, limit = 512 bytes):
> dt (j:1 t:1):                   / Buffer
> dt (j:1 t:1):    Memory Address / Index
> dt (j:1 t:1): 0x000000003c589000/     0 |*5b 00 00 00 5c 01 01 01 5d 02 02 02 5e 03 03 03 "[   \   ]   ^   "
> dt (j:1 t:1): 0x000000003c589010/    16 | 5f 04 04 04 60 05 05 05 61 06 06 06 62 07 07 07 "_   `   a   b   "
> dt (j:1 t:1): 0x000000003c589020/    32 | 63 08 08 08 64 09 09 09 65 0a 0a 0a 66 0b 0b 0b "c   d   e   f   "
> dt (j:1 t:1): 0x000000003c589030/    48 | 67 0c 0c 0c 68 0d 0d 0d 69 0e 0e 0e 6a 0f 0f 0f "g   h   i   j   "
> dt (j:1 t:1): 0x000000003c589040/    64 | 6b 10 10 10 6c 11 11 11 6d 12 12 12 6e 13 13 13 "k   l   m   n   "
> dt (j:1 t:1): 0x000000003c589050/    80 | 6f 14 14 14 70 15 15 15 71 16 16 16 72 17 17 17 "o   p   q   r   "
> dt (j:1 t:1): 0x000000003c589060/    96 | 73 18 18 18 74 19 19 19 75 1a 1a 1a 76 1b 1b 1b "s   t   u   v   "
> dt (j:1 t:1): 0x000000003c589070/   112 | 77 1c 1c 1c 78 1d 1d 1d 79 1e 1e 1e 7a 1f 1f 1f "w   x   y   z   "
> dt (j:1 t:1): 0x000000003c589080/   128 | 7b 20 20 20 7c 21 21 21 7d 22 22 22 7e 23 23 23 "{   |!!!}"""~###"
> dt (j:1 t:1): 0x000000003c589090/   144 | 7f 24 24 24 80 25 25 25 81 26 26 26 82 27 27 27 " $$$ %%% &&& '''"
> dt (j:1 t:1): 0x000000003c5890a0/   160 | 83 28 28 28 84 29 29 29 85 2a 2a 2a 86 2b 2b 2b " ((( ))) *** +++"
> dt (j:1 t:1): 0x000000003c5890b0/   176 | 87 2c 2c 2c 88 2d 2d 2d 89 2e 2e 2e 8a 2f 2f 2f " ,,, --- ... ///"
> dt (j:1 t:1): 0x000000003c5890c0/   192 | 8b 30 30 30 8c 31 31 31 8d 32 32 32 8e 33 33 33 " 000 111 222 333"
> dt (j:1 t:1): 0x000000003c5890d0/   208 | 8f 34 34 34 90 35 35 35 91 36 36 36 92 37 37 37 " 444 555 666 777"
> dt (j:1 t:1): 0x000000003c5890e0/   224 | 93 38 38 38 94 39 39 39 95 3a 3a 3a 96 3b 3b 3b " 888 999 ::: ;;;"
> dt (j:1 t:1): 0x000000003c5890f0/   240 | 97 3c 3c 3c 98 3d 3d 3d 99 3e 3e 3e 9a 3f 3f 3f " <<< === >>> ???"
> dt (j:1 t:1): 0x000000003c589100/   256 | 9b 40 40 40 9c 41 41 41 9d 42 42 42 9e 43 43 43 " @@@ AAA BBB CCC"
> dt (j:1 t:1): 0x000000003c589110/   272 | 9f 44 44 44 a0 45 45 45 a1 46 46 46 a2 47 47 47 " DDD EEE FFF GGG"
> dt (j:1 t:1): 0x000000003c589120/   288 | a3 48 48 48 a4 49 49 49 a5 4a 4a 4a a6 4b 4b 4b " HHH III JJJ KKK"
> dt (j:1 t:1): 0x000000003c589130/   304 | a7 4c 4c 4c a8 4d 4d 4d a9 4e 4e 4e aa 4f 4f 4f " LLL MMM NNN OOO"
> dt (j:1 t:1): 0x000000003c589140/   320 | ab 50 50 50 ac 51 51 51 ad 52 52 52 ae 53 53 53 " PPP QQQ RRR SSS"
> dt (j:1 t:1): 0x000000003c589150/   336 | af 54 54 54 b0 55 55 55 b1 56 56 56 b2 57 57 57 " TTT UUU VVV WWW"
> dt (j:1 t:1): 0x000000003c589160/   352 | b3 58 58 58 b4 59 59 59 b5 5a 5a 5a b6 5b 5b 5b " XXX YYY ZZZ [[["
> dt (j:1 t:1): 0x000000003c589170/   368 | b7 5c 5c 5c b8 5d 5d 5d b9 5e 5e 5e ba 5f 5f 5f " \\\ ]]] ^^^ ___"
> dt (j:1 t:1): 0x000000003c589180/   384 | bb 60 60 60 bc 61 61 61 bd 62 62 62 be 63 63 63 " ``` aaa bbb ccc"
> dt (j:1 t:1): 0x000000003c589190/   400 | bf 64 64 64 c0 65 65 65 c1 66 66 66 c2 67 67 67 " ddd eee fff ggg"
> dt (j:1 t:1): 0x000000003c5891a0/   416 | c3 68 68 68 c4 69 69 69 c5 6a 6a 6a c6 6b 6b 6b " hhh iii jjj kkk"
> dt (j:1 t:1): 0x000000003c5891b0/   432 | c7 6c 6c 6c c8 6d 6d 6d c9 6e 6e 6e ca 6f 6f 6f " lll mmm nnn ooo"
> dt (j:1 t:1): 0x000000003c5891c0/   448 | cb 70 70 70 cc 71 71 71 cd 72 72 72 ce 73 73 73 " ppp qqq rrr sss"
> dt (j:1 t:1): 0x000000003c5891d0/   464 | cf 74 74 74 d0 75 75 75 d1 76 76 76 d2 77 77 77 " ttt uuu vvv www"
> dt (j:1 t:1): 0x000000003c5891e0/   480 | d3 78 78 78 d4 79 79 79 d5 7a 7a 7a d6 7b 7b 7b " xxx yyy zzz {{{"
> dt (j:1 t:1): 0x000000003c5891f0/   496 | d7 7c 7c 7c d8 7d 7d 7d d9 7e 7e 7e da 7f 7f 7f " ||| }}} ~~~    "
> dt (j:1 t:1):
> dt (j:1 t:1): The incorrect data starts at memory address 0x000000003c596000 (for Robin's debug! :)
> dt (j:1 t:1): The incorrect data starts at file offset 000000000000047008 (marked by asterisk '*')
> dt (j:1 t:1): Dumping Data File offsets (base = 47008, mismatch offset = 0, limit = 512 bytes):
> dt (j:1 t:1):                   / Block
> dt (j:1 t:1):       File Offset / Index
> dt (j:1 t:1): 000000000000047008/     0 |*73 5f 66 72 65 65 5f 63 6f 6d 6d 69 74 5f 61 72 "s_free_commit_ar"
> dt (j:1 t:1): 000000000000047024/    16 | 72 61 79 00 54 43 50 5f 54 49 4d 45 5f 57 41 49 "ray TCP_TIME_WAI"
> dt (j:1 t:1): 000000000000047040/    32 | 54 00 42 50 46 5f 50 52 4f 47 5f 54 59 50 45 5f "T BPF_PROG_TYPE_"
> dt (j:1 t:1): 000000000000047056/    48 | 43 47 52 4f 55 50 5f 53 59 53 43 54 4c 00 4c 41 "CGROUP_SYSCTL LA"
> dt (j:1 t:1): 000000000000047072/    64 | 59 4f 55 54 5f 46 4c 45 58 5f 46 49 4c 45 53 00 "YOUT_FLEX_FILES "
> dt (j:1 t:1): 000000000000047088/    80 | 4e 46 53 45 52 52 5f 4a 55 4b 45 42 4f 58 00 72 "NFSERR_JUKEBOX r"
> dt (j:1 t:1): 000000000000047104/    96 | 78 5f 63 70 75 5f 72 6d 61 70 00 6d 69 67 72 61 "x_cpu_rmap migra"
> dt (j:1 t:1): 000000000000047120/   112 | 74 69 6f 6e 5f 64 69 73 61 62 6c 65 64 00 5f 5f "tion_disabled __"
> dt (j:1 t:1): 000000000000047136/   128 | 64 61 74 61 00 6e 64 6f 5f 64 65 6c 5f 73 6c 61 "data ndo_del_sla"
> dt (j:1 t:1): 000000000000047152/   144 | 76 65 00 6e 66 73 5f 63 6f 6d 6d 69 74 5f 64 61 "ve nfs_commit_da"
> dt (j:1 t:1): 000000000000047168/   160 | 74 61 00 65 78 74 5f 6d 75 74 65 78 00 63 6f 6e "ta ext_mutex con"
> dt (j:1 t:1): 000000000000047184/   176 | 6e 65 63 74 5f 63 6f 6f 6b 69 65 00 54 43 50 5f "nect_cookie TCP_"
> dt (j:1 t:1): 000000000000047200/   192 | 43 4c 4f 53 45 5f 57 41 49 54 00 6d 65 6d 63 6d "CLOSE_WAIT memcm"
> dt (j:1 t:1): 000000000000047216/   208 | 70 00 52 50 4d 5f 52 45 51 5f 53 55 53 50 45 4e "p RPM_REQ_SUSPEN"
> dt (j:1 t:1): 000000000000047232/   224 | 44 00 63 72 6d 61 74 63 68 00 63 61 6e 63 65 6c "D crmatch cancel"
> dt (j:1 t:1): 000000000000047248/   240 | 5f 66 6f 72 6b 00 70 67 70 72 6f 74 5f 74 00 74 "_fork pgprot_t t"
> dt (j:1 t:1): 000000000000047264/   256 | 72 61 63 65 70 6f 69 6e 74 5f 70 74 72 5f 74 00 "racepoint_ptr_t "
> dt (j:1 t:1): 000000000000047280/   272 | 66 6f 72 5f 72 65 63 6c 61 69 6d 00 4e 46 53 45 "for_reclaim NFSE"
> dt (j:1 t:1): 000000000000047296/   288 | 52 52 5f 42 41 44 43 48 41 52 00 5f 73 6b 62 5f "RR_BADCHAR _skb_"
> dt (j:1 t:1): 000000000000047312/   304 | 72 65 66 64 73 74 00 70 68 79 73 69 63 61 6c 5f "refdst physical_"
> dt (j:1 t:1): 000000000000047328/   320 | 6c 6f 63 61 74 69 6f 6e 00 6e 75 6d 5f 72 65 71 "location num_req"
> dt (j:1 t:1): 000000000000047344/   336 | 73 00 5f 5f 53 43 54 5f 5f 74 70 5f 66 75 6e 63 "s __SCT__tp_func"
> dt (j:1 t:1): 000000000000047360/   352 | 5f 70 6e 66 73 5f 6d 64 73 5f 66 61 6c 6c 62 61 "_pnfs_mds_fallba"
> dt (j:1 t:1): 000000000000047376/   368 | 63 6b 5f 77 72 69 74 65 5f 64 6f 6e 65 00 74 61 "ck_write_done ta"
> dt (j:1 t:1): 000000000000047392/   384 | 73 6b 5f 63 6c 65 61 6e 75 70 00 65 78 70 61 6e "sk_cleanup expan"
> dt (j:1 t:1): 000000000000047408/   400 | 64 5f 72 65 61 64 61 68 65 61 64 00 6c 6f 63 6b "d_readahead lock"
> dt (j:1 t:1): 000000000000047424/   416 | 5f 6d 61 6e 61 67 65 72 5f 6f 70 65 72 61 74 69 "_manager_operati"
> dt (j:1 t:1): 000000000000047440/   432 | 6f 6e 73 00 73 72 63 5f 72 65 67 00 63 72 64 65 "ons src_reg crde"
> dt (j:1 t:1): 000000000000047456/   448 | 73 74 72 6f 79 00 63 68 69 6c 64 72 65 6e 5f 6c "stroy children_l"
> dt (j:1 t:1): 000000000000047472/   464 | 6f 77 5f 75 73 61 67 65 00 6e 75 6d 5f 76 66 00 "ow_usage num_vf "
> dt (j:1 t:1): 000000000000047488/   480 | 73 63 72 61 74 63 68 00 50 49 44 54 59 50 45 5f "scratch PIDTYPE_"
> dt (j:1 t:1): 000000000000047504/   496 | 4d 41 58 00 70 72 65 70 61 72 65 5f 77 72 69 74 "MAX prepare_writ"
> dt (j:1 t:1):
> dt (j:1 t:1):
> dt (j:1 t:1): Analyzing IOT Record Data: (Note: Block #'s are relative to start of record!)
> dt (j:1 t:1):
> dt (j:1 t:1):                 IOT block size: 512
> dt (j:1 t:1):         Total number of blocks: 91 (47008 bytes)
> dt (j:1 t:1):         Current IOT seed value: 0x01010101 (pass 1)
> dt (j:1 t:1):      Range of corrupted blocks: 0 - 90
> dt (j:1 t:1):     Length of corrupted blocks: 91 (46592 bytes)
> dt (j:1 t:1):   Corrupted blocks file offset: 47008 (LBA 91)
> dt (j:1 t:1):     Number of corrupted blocks: 91
> dt (j:1 t:1):    Number of good blocks found: 0
> dt (j:1 t:1):    Number of zero blocks found: 0
> dt (j:1 t:1):
> dt (j:1 t:1):                       Record #: 2
> dt (j:1 t:1):         Starting Record Offset: 47008
> dt (j:1 t:1):                 Transfer Count: 47008 (0xb7a0)
> dt (j:1 t:1):           Ending Record Offset: 94016
> dt (j:1 t:1):    Relative Record Block Range: 91 - 182
> dt (j:1 t:1):            Read Buffer Address: 0x3c596000
> dt (j:1 t:1):           Pattern Base Address: 0x3c589000
> dt (j:1 t:1):                           Note: Incorrect data is marked with asterisk '*'
> dt (j:1 t:1):
> dt (j:1 t:1):                   Record Block: 0 (BAD data)
> dt (j:1 t:1):            Record Block Offset: 47008 (LBA 91)
> dt (j:1 t:1):            Record Buffer Index: 0 (0x0)
> dt (j:1 t:1):          Expected Block Number: 91 (0x0000005b)
> dt (j:1 t:1):          Received Block Number: 1919311731 (0x72665f73)
> dt (j:1 t:1):          Received Block Offset: 982687606272
> dt (j:1 t:1):
> dt (j:1 t:1): Byte Expected: address 0x3c589000          Received: address 0x3c596000
> dt (j:1 t:1): 0000 0000005b 0101015c 0202025d 0303035e * 72665f73 635f6565 696d6d6f 72615f74
> dt (j:1 t:1): 0010 0404045f 05050560 06060661 07070762 * 00796172 5f504354 454d4954 4941575f
> dt (j:1 t:1): 0020 08080863 09090964 0a0a0a65 0b0b0b66 * 50420054 52505f46 545f474f 5f455059
> dt (j:1 t:1): 0030 0c0c0c67 0d0d0d68 0e0e0e69 0f0f0f6a * 4f524743 535f5055 54435359 414c004c
> dt (j:1 t:1): 0040 1010106b 1111116c 1212126d 1313136e * 54554f59 454c465f 49465f58 0053454c
> dt (j:1 t:1): 0050 1414146f 15151570 16161671 17171772 * 4553464e 4a5f5252 42454b55 7200584f
> dt (j:1 t:1): 0060 18181873 19191974 1a1a1a75 1b1b1b76 * 70635f78 6d725f75 6d007061 61726769
> dt (j:1 t:1): 0070 1c1c1c77 1d1d1d78 1e1e1e79 1f1f1f7a * 6e6f6974 7369645f 656c6261 5f5f0064
> dt (j:1 t:1): 0080 2020207b 2121217c 2222227d 2323237e * 61746164 6f646e00 6c65645f 616c735f
> dt (j:1 t:1): 0090 2424247f 25252580 26262681 27272782 * 6e006576 635f7366 696d6d6f 61645f74
> dt (j:1 t:1): 00a0 28282883 29292984 2a2a2a85 2b2b2b86 * 65006174 6d5f7478 78657475 6e6f6300
> dt (j:1 t:1): 00b0 2c2c2c87 2d2d2d88 2e2e2e89 2f2f2f8a * 7463656e 6f6f635f 0065696b 5f504354
> dt (j:1 t:1): 00c0 3030308b 3131318c 3232328d 3333338e * 534f4c43 41575f45 6d005449 6d636d65
> dt (j:1 t:1): 00d0 3434348f 35353590 36363691 37373792 * 50520070 45525f4d 55535f51 4e455053
> dt (j:1 t:1): 00e0 38383893 39393994 3a3a3a95 3b3b3b96 * 72630044 6374616d 61630068 6c65636e
> dt (j:1 t:1): 00f0 3c3c3c97 3d3d3d98 3e3e3e99 3f3f3f9a * 726f665f 6770006b 746f7270 7400745f
> dt (j:1 t:1): 0100 4040409b 4141419c 4242429d 4343439e * 65636172 6e696f70 74705f74 00745f72
> dt (j:1 t:1): 0110 4444449f 454545a0 464646a1 474747a2 * 5f726f66 6c636572 006d6961 4553464e
> dt (j:1 t:1): 0120 484848a3 494949a4 4a4a4aa5 4b4b4ba6 * 425f5252 48434441 5f005241 5f626b73
> dt (j:1 t:1): 0130 4c4c4ca7 4d4d4da8 4e4e4ea9 4f4f4faa * 64666572 70007473 69737968 5f6c6163
> dt (j:1 t:1): 0140 505050ab 515151ac 525252ad 535353ae * 61636f6c 6e6f6974 6d756e00 7165725f
> dt (j:1 t:1): 0150 545454af 555555b0 565656b1 575757b2 * 5f5f0073 5f544353 5f70745f 636e7566
> dt (j:1 t:1): 0160 585858b3 595959b4 5a5a5ab5 5b5b5bb6 * 666e705f 646d5f73 61665f73 61626c6c
> dt (j:1 t:1): 0170 5c5c5cb7 5d5d5db8 5e5e5eb9 5f5f5fba * 775f6b63 65746972 6e6f645f 61740065
> dt (j:1 t:1): 0180 606060bb 616161bc 626262bd 636363be * 635f6b73 6e61656c 65007075 6e617078
> dt (j:1 t:1): 0190 646464bf 656565c0 666666c1 676767c2 * 65725f64 68616461 00646165 6b636f6c
> dt (j:1 t:1): 01a0 686868c3 696969c4 6a6a6ac5 6b6b6bc6 * 6e616d5f 72656761 65706f5f 69746172
> dt (j:1 t:1): 01b0 6c6c6cc7 6d6d6dc8 6e6e6ec9 6f6f6fca * 00736e6f 5f637273 00676572 65647263
> dt (j:1 t:1): 01c0 707070cb 717171cc 727272cd 737373ce * 6f727473 68630079 72646c69 6c5f6e65
> dt (j:1 t:1): 01d0 747474cf 757575d0 767676d1 777777d2 * 755f776f 65676173 6d756e00 0066765f
> dt (j:1 t:1): 01e0 787878d3 797979d4 7a7a7ad5 7b7b7bd6 * 61726373 00686374 54444950 5f455059
> dt (j:1 t:1): 01f0 7c7c7cd7 7d7d7dd8 7e7e7ed9 7f7f7fda * 0058414d 70657270 5f657261 74697277
> ...
> dt (j:1 t:1): Reread data does NOT match previous data or expected data!
> dt (j:1 t:1): Writing reread data to file dt_thisisa.test-REREAD3-j1t1, from buffer 0x7f12bc004000, 47008 bytes...
> dt (j:1 t:1): Command line to re-read the corrupted data:
> dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 count=1 offset=47008 pattern=iot disable=retryDC,savecorrupted,trigdefaults
> dt (j:1 t:1):
> dt (j:1 t:1): Command line to re-read the data:
> dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 dsize=512 iotype=sequential iodir=forward limit=94016 records=1 pattern=iot disable=retryDC,savecorrupted,trigdefaults
> dt (j:1 t:1):
> dt (j:1 t:1):
> dt (j:1 t:1): Read Statistics:
> dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
> dt (j:1 t:1):       Last IOT seed value used: 0x01010101
> dt (j:1 t:1):        Total records processed: 2 @ 47008 bytes/record (45.906 Kbytes)
> dt (j:1 t:1):        Total bytes transferred: 94016 (91.812 Kbytes, 0.090 Mbytes)
> dt (j:1 t:1):         Average transfer rates: 656857 bytes/sec, 641.462 Kbytes/sec, 0.626 Mbytes/sec
> dt (j:1 t:1):        Number I/O's per second: 13.973
> dt (j:1 t:1):         Number seconds per I/O: 0.0716 (71.56ms)
> dt (j:1 t:1):         Total passes completed: 1/1
> dt (j:1 t:1):          Total errors detected: 1/1
> dt (j:1 t:1):             Total elapsed time: 00m00.15s
> dt (j:1 t:1):              Total system time: 00m00.00s
> dt (j:1 t:1):                Total user time: 00m00.00s
> dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):
> dt (j:1 t:1): Operating System Information:
> dt (j:1 t:1):                      Host name: plsm121c-06.perf.hammer.space (192.168.1.106)
> dt (j:1 t:1):                      User name: root
> dt (j:1 t:1):                     Process ID: 31703
> dt (j:1 t:1):                 OS information: Linux 6.12.24.17.hs.snitm+ #34 SMP PREEMPT_DYNAMIC Fri Aug 15 22:03:10 UTC 2025 x86_64
> dt (j:1 t:1):
> dt (j:1 t:1): File System Information:
> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
> dt (j:1 t:1):                Filesystem type: nfs4
> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
> dt (j:1 t:1):          Filesystem block size: 1048576
> dt (j:1 t:1):          Filesystem free space: 60990430380032 (58165007.000 Mbytes, 56801.765 Gbytes, 55.470 Tbytes)
> dt (j:1 t:1):         Filesystem total space: 60992310476800 (58166800.000 Mbytes, 56803.516 Gbytes, 55.472 Tbytes)
> dt (j:1 t:1):
> dt (j:1 t:1): Total Statistics:
> dt (j:1 t:1):        Output device/file name: /mnt/hs_test/dt_thisisa.test (device type=regular)
> dt (j:1 t:1):        Type of I/O's performed: sequential (forward)
> dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
> dt (j:1 t:1):       Data pattern string used: 'IOT Pattern' (blocking is 512 bytes)
> dt (j:1 t:1):       Last IOT seed value used: 0x01010101
> dt (j:1 t:1):             Total records read: 2
> dt (j:1 t:1):               Total bytes read: 94016 (91.812 Kbytes, 0.090 Mbytes, 0.000 Gbytes)
> dt (j:1 t:1):          Total records written: 3
> dt (j:1 t:1):            Total bytes written: 141024 (137.719 Kbytes, 0.134 Mbytes, 0.000 Gbytes)
> dt (j:1 t:1):        Total records processed: 5 @ 47008 bytes/record (45.906 Kbytes)
> dt (j:1 t:1):        Total bytes transferred: 235040 (229.531 Kbytes, 0.224 Mbytes)
> dt (j:1 t:1):         Average transfer rates: 828023 bytes/sec, 808.616 Kbytes/sec, 0.790 Mbytes/sec
> dt (j:1 t:1):        Number I/O's per second: 17.615
> dt (j:1 t:1):         Number seconds per I/O: 0.0568 (56.77ms)
> dt (j:1 t:1):         Total passes completed: 1/1
> dt (j:1 t:1):          Total errors detected: 1/1
> dt (j:1 t:1):             Total elapsed time: 00m00.29s
> dt (j:1 t:1):              Total system time: 00m00.00s
> dt (j:1 t:1):                Total user time: 00m00.00s
> dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
> dt (j:1 t:1):
> dt (j:1 t:1): Command line to re-read the data:
> dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 dsize=512 iotype=sequential iodir=forward limit=141024 records=3 pattern=iot
> dt (j:1 t:1):
> dt (j:1 t:1): Command Line:
> dt (j:1 t:1):
> dt (j:1 t:1):     # dt of=/mnt/hs_test/dt_thisisa.test passes=1 bs=47008 count=3 iotype=sequential pattern=iot onerr=abort oncerr=abort
> dt (j:1 t:1):
> dt (j:1 t:1):         --> Date: September 21st, 2023, Version: 25.05, Author: Robin T. Miller <--
> dt (j:1 t:1):
> dt (j:1 t:1): onerr=abort, so stopping all threads for job 1...
> dt (j:0 t:0): Job 1 is being stopped (1 thread)
> dt (j:0 t:0): Program is exiting with status -1...
> ---
>  fs/nfsd/vfs.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f8975ee262b5c..762d745b1b15d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1079,13 +1079,11 @@ struct nfsd_read_dio {
>  	loff_t end;
>  	unsigned long start_extra;
>  	unsigned long end_extra;
> -	struct page *start_extra_page;
>  };
>  
>  static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
>  {
>  	memset(read_dio, 0, sizeof(*read_dio));
> -	read_dio->start_extra_page = NULL;
>  }
>  
>  #define NFSD_READ_DIO_MIN_KB (32 << 10)
> @@ -1121,9 +1119,8 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	/*
>  	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
> -	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
> -	 * start_extra_page, for smaller IO that can generally already perform
> -	 * well using buffered IO).
> +	 * to be DIO-aligned (this heuristic avoids excess work, for smaller IO
> +	 * that can generally already perform well using buffered IO).
>  	 */
>  	if ((read_dio->start_extra || read_dio->end_extra) &&
>  	    (len < NFSD_READ_DIO_MIN_KB)) {
> @@ -1131,15 +1128,6 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return false;
>  	}
>  
> -	if (read_dio->start_extra) {
> -		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
> -		if (WARN_ONCE(read_dio->start_extra_page == NULL,
> -			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> -			init_nfsd_read_dio(read_dio);
> -			return false;
> -		}
> -	}
> -
>  	/* Show original offset and count, and how it was expanded for DIO */
>  	middle_end = read_dio->end - read_dio->end_extra;
>  	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
> @@ -1162,11 +1150,10 @@ static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
>  	if (!read_dio->start_extra && !read_dio->end_extra)
>  		return host_err;
>  
> -	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> -	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> +	/* If nfsd_analyze_read_dio() found start_extra (front-pad) page needed it
> +	 * must be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
>  	 */
> -	if (read_dio->start_extra_page) {
> -		__free_page(read_dio->start_extra_page);
> +	if (read_dio->start_extra) {
>  		*rq_bvec_numpages -= 1;
>  		v = *rq_bvec_numpages;
>  		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> @@ -1276,7 +1263,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			if (read_dio.start_extra) {
>  				len = read_dio.start_extra;
>  				bvec_set_page(&rqstp->rq_bvec[v],
> -					      read_dio.start_extra_page,
> +					      *(rqstp->rq_next_page++),
>  					      len, PAGE_SIZE - len);
>  				total -= len;
>  				++v;

Thank you, Mike. This will help me reproduce the problem. Saves me a
bunch of time!

-- 
Chuck Lever

