Return-Path: <linux-nfs+bounces-8924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA8A01D22
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 02:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B9A162A9C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FB101C8;
	Mon,  6 Jan 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOZu9jv9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VDiE0jXO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F34E574
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736128539; cv=fail; b=Q8qn0FSvyHF7q/bOl7rGir5nKoz3vgD8EoSAxFasT+gilMQxgnGdJ8VXwHomr1BzyazDb+hk/CZ1gnUh6I7LYXYBg2//hOzI2TeKgDg710RGAYhKAA+qAHIr9EFlEK5DuRtsF9ygfZGLWuhqrL7w4r3DZ8fr83vKtqQYj1y7iwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736128539; c=relaxed/simple;
	bh=jUeIEya1BIT9weQTBTpQWoS7DSRZuEirgB42yGe/6v8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lhBkBZzjC+24cP7B1cWs3FT6LJE0b4UJao1IoOodlZZXVAyfyWTsREDawXcPBUp0bzkbWFUJfr0DfEDDKTlW9L/iq1Q8ajNR5R0XKXOs11CdYUo81H/8s2Kq/LTQ2EGwCKiVr1nackKuMQJvr3U5sSozIVM0U4ZvGYxbh7tFx4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XOZu9jv9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VDiE0jXO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505Nn5uW027937;
	Mon, 6 Jan 2025 01:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6r/l/8GG67gaN+gcx7mHQrZj4TamznJ71urYUxQ83rs=; b=
	XOZu9jv9r2LMAdLvWDQdA/IrTLHuFVvKbus0CaGiwDIE2guX8UGrHyxFTg3/d52E
	LCgXU+GcHLm6+6WlITv1gODGdV8vlmoDPoaX77nR+28IR4PCcB4OC06Ec00l0JIB
	izj5NOQ+YylI47d8QSWgj+qRT6dKWwzVr55+wOez40RI6NsCbDq43ao5RL7H0SvZ
	wfVg6LLHQVc2EKPOs6nofriZKF/jAgKD7B4fixljj8RMoe7hZ6Z320l2bb9GnoN+
	vyEdpmwwsHtBUivdPuN8OTXX4Dfi3FzYkXCGl2fNkuLqdeT/xKBRlA5uegNsefdK
	weqn1xRXqEudmpI35xyKWA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus29ssw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 01:55:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5060s44T011202;
	Mon, 6 Jan 2025 01:55:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue6guca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 01:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1+MrLaL/cDgWmoccN8mC62rgJY6tKFGYA6PXybwZJsIiPhhFRt4lLCxy1dytRg/pm2QNeBDos/gzJiBkTQ6aH9rdYd373newuNqILowydEfu+X0YZmC3MuMIVvQcz4lG9LD34OaBG0pzJX01PQMAwLAsDlwuQx07oj5ZA3ivPYnAsUwY/SBBPKN9pI9xIr3kDYVST1tfzdoleaK+8MkZYnEp2XI0eEcGzFAXvmgsRwHJ85FxdCaoK0S1AaN64IQK69B84Ce3i6J8UEDraP6H/lGUl+Ug84UL9irKUyrAmD1WuKEpsaozPP8JWevXmxHSX5v+g2/McWZSdwCsNDqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r/l/8GG67gaN+gcx7mHQrZj4TamznJ71urYUxQ83rs=;
 b=lf8aT6vThjik2uFjDZ2PXSygdda0WKTJ6Hz3Lv5eONV2tplP1xW9/bfXXXTBFX2zK5nKY7nHqrtf70CY/IagVZl9Za2ipGOlgP9vD/ndbuEdscjxZo+vJoN9OwMsfJEO0KcAhnVGqSu6ONwONNgT8FmWLEUWzIz1QLLwnJK7elhWIYnAWcPK0q7GaWu0pcHGv0sYtokRf200awQvfn6olveXq7MXf1K69s2/me7SQSaIDw3qsYrKUCEIVBG+YO1fe+sdi0FzUX2n48qidmo9ZDRhmHqcqVuUo21Dv5rtYLp+vVgQ/AbqbW79REHyZiYSOc3mfXuvuH7ZdvHnSZgRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r/l/8GG67gaN+gcx7mHQrZj4TamznJ71urYUxQ83rs=;
 b=VDiE0jXOstEzBsXvRXNdl8FQLDrZqa0bdIslneH2JhqQSOjEZlcq++k0G4yP0l9vAPiKb6BHRLQwSSC0VEWDzrGlJvLNBzfVM4kkyONq6fwekfn6Oc+Cx0A2ITseMPXdjWHJiAj83lwTxH+51VP8NnGbE8JLDEzXWd5+fEOgLdQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4367.namprd10.prod.outlook.com (2603:10b6:208:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 01:55:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 01:55:11 +0000
Message-ID: <de100fd1-b741-4386-ac9c-21f3957d342e@oracle.com>
Date: Sun, 5 Jan 2025 20:55:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20250105234022.2361576-1-neilb@suse.de>
 <20250105234022.2361576-2-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250105234022.2361576-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 37570cd4-edd9-4b63-199a-08dd2df52757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFNMZGt1REdFSkFhOWI2TkUzSjVBWW1STDFPcElTb0VJYjNGSmlMNmF6WndH?=
 =?utf-8?B?cHlQZWRYOUlZdDY3WDRKTWROb2I4eHU2d1Rab3NCV0hPcXFTbXRHQkZjb0w2?=
 =?utf-8?B?RHdUZlpNOXY0T2ljMERveDZJNndUN2RnRWpNTFNWWVVwbTZXL0FlY2ZDU3Ux?=
 =?utf-8?B?UFNKM2hQVDN6b0pPcjJlR0VGU3dzT1ZlRmdwR2VVTXlIOG1IYVBqZkhhcmlH?=
 =?utf-8?B?Sk5FZE1KQlpmUWFXNFVhZVhDa3Z0SkpvSE9yT3BQWGhqbk13RjZNRHR5VWhH?=
 =?utf-8?B?RC9qOGpmU1VOeDBlUkdzNVdKeGVkWUtFYU90d2lZenNwV0lIdHhxM1pkcnJG?=
 =?utf-8?B?WWppQkYxc0dBcEJEV1BGQkNRWDdjaGcwVExvajR4cUt5WStRbE9LZ1hrUG5z?=
 =?utf-8?B?dFl0TzVGbkYrVzM3aWYwVkY5RURkYmZOU0EwR0xOdU10dTZJcjFkbGJ3eW1W?=
 =?utf-8?B?amQyOHVJL29FcGNKYTB5VDk3a0V1MWxFcWRQYTYvK09ENGtaY1dvb1Z2dThx?=
 =?utf-8?B?eTBIdFFqN3MyZmtkbUY3bTlSMUhxZHR4Q1NtSlU4SGJoZTZvd25KS01MaW5R?=
 =?utf-8?B?ZFpTNnJ1V3NWT2hsbWRQUVNPVHRMd3hmWmpmMExCZzhEbHNaa3pmRGJBYjVF?=
 =?utf-8?B?bzZ3RHF5STdsblpzZ21lNkl4KzFqenN5b3VzSHBuZTRuVVNtNzlSOUQvR0h1?=
 =?utf-8?B?aHFsRGJNckQxL0ZseVZyblJ5V2xWWHlISEp5SFYwTmF2ZlVYUXJnU1J6ZW1i?=
 =?utf-8?B?NVAvWTBNS2RlNXBWVDdCMklZWE9Xckpjd21PMmVXY0xDK1pGQ29mclgzSXIy?=
 =?utf-8?B?SmVZYUtOemUwUDRoS3pqTFpvY20zRFZvUnJNd1lRQ3VNdjllL2h4ZjExeFJX?=
 =?utf-8?B?R09hUThBVXBlSGt2L1NtZm9WUDJxRHN6OHk4S1FzVlBBcHBxTXhORGhCVmlE?=
 =?utf-8?B?a3RFY1VmN2RsdHQrRldCZjBJYjMvbHVsZkg0WUpzbDJJd1VGOUpMblVuS1BL?=
 =?utf-8?B?eTRKZjF4Y29IVWE4aXRnV092QlVXNEpJZnNjWk05cXNBRjhlcjFHSW82Vit1?=
 =?utf-8?B?MUJSZGxjLzgxWDVDbDR4akVDeHZDSDMrQXovS2tqb1pscmRGMisrRy9RVHQ0?=
 =?utf-8?B?TGdjZGptV1h0VEpWeVR0Yi9rUC9SWnJpN2QzZTlTMGtSTm1OWlhLSUtOaWgr?=
 =?utf-8?B?OUlWUDNDM1R2QnFzN0hoNTl3c1VvelA0ajI2TFNyMDFoaU1reDBRMzc2ZENS?=
 =?utf-8?B?QXFmb3BxWlRsRC9iMC9rODNxeTk4cm93ZkFqTGM1dG9yazk3dm1hY1hCVG5X?=
 =?utf-8?B?Y2EyOUMvc0E3SDJaWDhqMHdrMHRyMVdHTEswOWxISUpHUGJGU3picUV0dCsv?=
 =?utf-8?B?ZTVQTXBkeWxIQnU3bUltdzFTaElXcEtTNDR2cEx5elNpVHVhbTQvTDEzTDI3?=
 =?utf-8?B?Q3R1dHNHOU9TVVE4T2Q3ck9yV3NPM2ljNU0zOGVnOWZjYXoyYkFzbExMT3Uz?=
 =?utf-8?B?UE9QdjdkMmZ2V2dvL3FEdDNmcTAxWVRGcWovVjZ6RWl3ODNTV3pHV1Yzd3p1?=
 =?utf-8?B?bDQ3OWdmU3dTYTJYM0ovSmR2aXliS3NSTjJLa1ZQMVVCcGZNZjlFZjA4cWVK?=
 =?utf-8?B?NDlScDU3UG5lQkdnSUxaL1NKSnhlVUNRMFVTSUtpWkhTa0FhYlNNaThxbzhX?=
 =?utf-8?B?Z2Z1NDJOcThYVXZGZ2ZiSTNPRWluTUtOOFNVZTZvK1ljYXJNZXYzdENHRUJP?=
 =?utf-8?B?ZGtoa1J4d2NMK3Y0WVVQYmwrNmEyTm1nWEJTanNmQnBsbk03SDgzbmZxV1ls?=
 =?utf-8?B?NVhwNm9JRnZqcjdOU3lxckROTC9kRlFJWEFHZnZTaVBhdE5TcDdFbmt1dits?=
 =?utf-8?Q?uw5P9k4OAYhMA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNibkcrRzJGbmluR3RFaWlueWQwaXVEbkl2cy9BQzg1U3RsSkN1cEM1Rm1h?=
 =?utf-8?B?eWFtN2JVL2NaOVNzTlpqMmNiaDR4YkUwbFIvazc4UUtEc1BrekhjbFZFdDlx?=
 =?utf-8?B?ZjQ3aTRoRFREblVHQ1BWMzNFeFBFM3MrOHRiOHFlVGtyTjh2cEJjMGNzZnQ4?=
 =?utf-8?B?QW05eEdseVBpdkxxWTFabVFQM3FEcjNsRzBmUlZtMEs0MzU3OFhWVUs1UlA0?=
 =?utf-8?B?c1dVVjNoU0JLK2tVZi8ycVZVVW1pWittRThNM3JXNHhCeFlqUkpqbnNXcDVN?=
 =?utf-8?B?alRGVUJ6cS9oR3RIL05SOHB0clVLMFdvREFDTWVJMS8yWWdZWWQ4bVgrYU10?=
 =?utf-8?B?NmlHL0pQdjJta2pyeUVhdDVBNGMzSm5DbzArQnZVY0FlRmcrZWFoUUhIeG5P?=
 =?utf-8?B?QUdSMjNWMnNUVXAwSU9XdFRkWEtPYUE3NHMxM2NvbzVLUUY4UHZsWHcwU203?=
 =?utf-8?B?ckJLSEFGQ3FqaGpiSXpWV2YxcmNvUjJZVGU2cDZoOWdoVDVQZW10Vkh1anA3?=
 =?utf-8?B?Zmp6dWg0d21BMWNNMkZESHBaUDVRb25KTWdLMkg5UEtBc1k2bmhBQzRPd3lT?=
 =?utf-8?B?OWZHQW4xK0JhempkNG1wOFh1TkZoR0dQWk81aWJVbVVvL0xIWTk2cUVvS3cr?=
 =?utf-8?B?TWlTN1hubS9hSFNpL3NTM0txa3hDMFFkVlZlQlptVGFhcE1VQnY4b1JYdXZS?=
 =?utf-8?B?NjFHRlBuRmNFTU5VTnIrUUt6aVlKWWVlRVhKNmhDZE5YZVllb3BzczJxR3k3?=
 =?utf-8?B?T2NMeWhndnFYY1ZEK0xoSnJsdjNqK0tGK0dsVTE0ei9lUm1BVmFQOU91Q2hS?=
 =?utf-8?B?OVQ5Unk4UU1ZV0Y2dXBhWDFKQUtFcW5ycE54b1VpenB5ZnM1cHl2NittQmZK?=
 =?utf-8?B?QU1XV0RRdUNIaVNxSDI5M01CcFlkVmt4Y1BEaWZCUGJzdnhwbmFFL2cxanZ6?=
 =?utf-8?B?RmdRMnpwV0c3cks1dXlOTndLTWZORlVVTHhia0FVeUdUS1pvZ0dHKzlkU3dj?=
 =?utf-8?B?cmE3MUQ1QTlvcEhNbCt3cG92cnJFZCtwdnEzdm1YdWN0M3BhVmlMZjBrRm9N?=
 =?utf-8?B?amYwUk1oR1FBNFg0MXIrNUhHSWxUSDNibVoyRUlMRTc2dWdON0VoVGRMYmdy?=
 =?utf-8?B?YkE3UjNnRy8yK21jZnZrSDh5TE5Ja2lLbHhZRnpyZEx0UXgydGxRbHE1SGJP?=
 =?utf-8?B?eTBNYTZMQWpEUVN6UEF5RnZFZDVGcUFGMmxFR2h3bnJYTTFBL3VRSTVXQ1hB?=
 =?utf-8?B?bm9UeUF4bStQM2JtZVF6NDZHL0RpdkI3Q0YyUGIxYXU5STlKcWFEdStkL2pW?=
 =?utf-8?B?dkJ6aFZlLzJ1NWhrQ3BUd0UxMUxXRkdpNHNiL1lscnBDZEFLdjlvNmpBL01K?=
 =?utf-8?B?V0tHVDZ5eFJXNnltNGR4R21ycGhzblBlWldjZWgvWnl4c3pVak11N0NFWG0v?=
 =?utf-8?B?NDM5WEdEWnZhMElWOWtGL0tpK1RjaWk5UkZWbi8wTGFBV3pvcEs0ZUlEVVVv?=
 =?utf-8?B?ZTl6Rmo3dHpXeTU4Z0U4dzcyS3IxY290UW5aMlVxS3AzSWwyUiszZVBSMnJq?=
 =?utf-8?B?bkdJRFdrWXhyQU9SZlhmeUVKSDZTUk9xQ0xOcWdKUHNuZk45SDN6Tytka0VR?=
 =?utf-8?B?ZFNLVlBtTEhHTUplVGd5ZmFZSDd0U0VGUVZsMDlsem1tRG52d1VSUWZTZHRx?=
 =?utf-8?B?aDZ6cUhUSzk3UUdwUndWNkJKMDFET211NmtjYzQyb0xBSmhtTzRUNTkxL1p3?=
 =?utf-8?B?WG1aaThCZEUzYnpaaDdLemRtWkxLUFNwSlp6QzlMQVdkSS9WcWxuZXBjTlkr?=
 =?utf-8?B?WEswZHhPYUsrZHRzcmZUb1EwbzYyV0cxNlEyK09TTnN0SVRLTEpvbTVaWWcv?=
 =?utf-8?B?NXVCeHVQWDBoNFpiQkhCYk1MZkVRRXJGc3NheHRvVEZDQXRTTjU1dGZRWVpn?=
 =?utf-8?B?WEpodVdROTJHV2hUclIyYlVrSFQ3WEExd1lQQnFhMEJYYzJQN3B5c2IyU1cz?=
 =?utf-8?B?MEp6aHRmQ0o2NVJPZTV1SkRKMHVEcEVjTVdQd2RxQ0RyOVpBTWQxOVNBdTZt?=
 =?utf-8?B?dHlaUjlUTDNRQ3p4cWRzbmtwUnhlR0x3bE5ValVjaVJjNEtVMDhTZUFVYW4x?=
 =?utf-8?B?Zk9TblJGOFpDZDBXayswSE5Tdi9ySDMrRUtPdjNWczVaaUFTcDlLaisxcDAz?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	filg0yF7ziDprWBleaUMHoOImyesrAHl2fcw/eOOq19eu8cnc3YpF/se3BLPKRtIXmzpNxwf6zP/EXYf/42JJs105C+an8+jVEEriBE5FIipXHsPWUvvshPF1Av2T7gZWti6MHu8+e7FiMpfnXsQ67HgKt/I72hDBv03uUoCdbf5eJE/OGVBYUJtI8BWDnVm/2QfH7hmIAfdiXNxdzlNXyOmvyq7ks0MXlaDKP3PbKt2nlSW1no8y2wt7nDAgowrFp+uaeeXhb3erXdupoDj01DGCwuzZDDfq0P1QA7x2srxBkxFIkx57w6vixZH2UBgTt9FZb8HDQ4UghoC/7aDA1cJEvfx7aTpgA2jLlp6aoAja++Djx56mfxwBj6W+UZlMOKkl7nl0RHC4Be0Mi2kDxYHh5hS0MwRRtSlrwz2wLWdxK0YZ20epfkeF91nM/EiSr72Gb+YeV5+wbBZ7yPw72wvXWGel8c06Zu0oUHDdmHQz0AIsVVbmjvrpGyVH+dLQA9BGlWE+P89J1TPCG5MGIG2cXEatxkNyV/mQSNnLx+yXqZ5GSmnNXbyJW85sL9rENa/wmKW0vaLBa07GSmWx1c7ce4fHToVU0nUkkFRgm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37570cd4-edd9-4b63-199a-08dd2df52757
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 01:55:11.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpa8uwF/XHCGKpG1g+LItfVMOa8jBWayueB9azz5foHE1Su4mwj0ktcP+TTmP3JZw7GVw7NtIQzGemyozqjWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=995 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060015
X-Proofpoint-ORIG-GUID: S9thjUXo11gv3flT0dKHbJUwAIrtrN-F
X-Proofpoint-GUID: S9thjUXo11gv3flT0dKHbJUwAIrtrN-F

On 1/5/25 6:11 PM, NeilBrown wrote:
> Under a high NFSv3 load with lots of different file being accessed The
> list_lru of garbage-collectable files can become quite long.
> 
> Asking lisT_lru_scan() to scan the whole list can result in a long
> period during which a spinlock is held and no scheduling is possible.
> This is impolite.
> 
> So only ask list_lru_scan() to scan 1024 entries at a time, and repeat
> if necessary - calling cond_resched() each time.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/filecache.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..e99a86798e86 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -543,11 +543,18 @@ nfsd_file_gc(void)
>   {
>   	LIST_HEAD(dispose);
>   	unsigned long ret;
> -
> -	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> -			    &dispose, list_lru_count(&nfsd_file_lru));
> -	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	unsigned long cnt = list_lru_count(&nfsd_file_lru);
> +
> +	while (cnt > 0) {

Since @cnt is unsigned, it should be safe to use "while (cnt) {"

(I might use "total" and "remaining" here -- "cnt", when said aloud,
leaves me snickering).


> +		unsigned long num_to_scan = min(cnt, 1024UL);

I see long delays with fewer than 1024 items on the list. I might
drop this number by one or two orders of magnitude. And make it a
symbolic constant.

There's another naked integer (8) in nfsd_file_net_dispose() -- how does
that relate to this new cap? Should that also be a symbolic constant?


> +		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> +				    &dispose, num_to_scan);
> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> +		nfsd_file_dispose_list_delayed(&dispose);

I need to go back and review the function traces to see where the
delays add up -- to make sure rescheduling here, rather than at some
other point, is appropriate. It probably is, but my memory fails me
these days.


> +		cnt -= num_to_scan;
> +		if (cnt)
> +			cond_resched();

Another approach might be to poke the laundrette again and simply
exit here, but I don't feel strongly about that.


> +	}
>   }
>   
>   static void


-- 
Chuck Lever

