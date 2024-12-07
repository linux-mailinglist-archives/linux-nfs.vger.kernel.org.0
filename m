Return-Path: <linux-nfs+bounces-8419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4339E828C
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F2C188491D
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0815442A;
	Sat,  7 Dec 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g2HmdZKZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDwQQ1qO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB21F602
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733612101; cv=fail; b=ORKNgNoFXUj+9pmkoFIM5+MvZq9XR+c4eL/ApaO5/i6hA4OptD4O+bk3t0+s06pAzvHYer0efxx0ef0bs42SDFh5ZdHnPmoqFtg6BT7hY3YOzADTyqRSo9/sH+vJSSYRIN6FyApvaDT5F9y/xbU9RDeXa8e00jaoZ6a4aLOjVlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733612101; c=relaxed/simple;
	bh=BOfJddv8iBkLNEslum58Ha/6lP7DgauYcY/VRa8KpdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNF2GBfI5fdCYvMt+6KL5pALK88QxIz+7N+1fPosJQThqFeu+cPmv+/xu+I62zIZVeLNyWlSYcTyEOu35CyyuPAh8oXY5a12ZGHvi0SggguL3S04dsWVHv1NhBho1yMS3zLAJKAVQotAjBmBsFkWNQOe/i8+WZ4Q5NYxS9Y29Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g2HmdZKZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDwQQ1qO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7Msq5R031038;
	Sat, 7 Dec 2024 22:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1S5T42KRDa0+0CYmQar7oLAwplndZFbPSqBxhDI9Hk8=; b=
	g2HmdZKZBcE7Ji5Y2w65jBLsfwtzXS7n9r7Kf1hGGNHI2PyQfHwVAZjCpeuIFuya
	8kBUj+n1XpDZMxKHzQJNjwz/cQeloEifZBPycDXQaYUwNm0LWr3w/3w3tDEpNb6U
	VIufXFAg8mRwaFWgsb0ffQtHvxHiepAj2WKV0tB1vsWw8PCL0fvDc8DQy7RF1rz8
	ZRpARgHwhtd4zPDWDJD8geuqORy/Q7XnlwcVIN8fdogmxXPIyKEIZjDSwoNimzHU
	OmXeQwrEP0Z4GC8epFrsD1osYD2bdKaCZbMOiI9K59LMbehoA3gBXMUfBxCQQ8XF
	SQFkmqS7POj4q6Yn4vW5Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc1055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 22:54:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7Lp3EU035102;
	Sat, 7 Dec 2024 22:54:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctd2epy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 22:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CklCV1ILo2yoBXlo+AbD1OVDrWG9htK1Woh3A5FEoI3fgUflTtqXNe01dHOFwVGR2FOdnjK5Ro13OW4VCfGpJh6hg3usj2ombvE5arTy/WGEET+oMuudoF2tlPcvssFzYd2/MC41+QTKk6Kx8LtZYSl26o2dbZddXakl87eqR2+eQVdiPZ2sZJl1UKrO6ERIdoJEdexLo9Lsnci09kOd6apizPgWNnjg4LmBabeixwoSOGq9fkbu4bvQ+MfiAqRMOjwAKsvlJr/gn0HI+lpViSO6BlNX4dSr9K6F2Rfgc0Inm4L1Sp4noe8vjIE8laYHR7Vwkr2R2i4f5JGTPCeCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S5T42KRDa0+0CYmQar7oLAwplndZFbPSqBxhDI9Hk8=;
 b=qfZlouVM9zYeUYOWzcOklOkk+N09MaMJpMmTiCkDx74d6x7blRJS77Sm5vO4orcwzwg4pDLSxjoBVDjmyg2bgZc+hebdNVZeLBZcEZ0SeHnruPQSAEWWjoPEJTH7bhiI+na0zYIzghhZb80S5S3zXK5Boj90JhSk7FmMM4N4buVYjQbz9EIUY/kLUqjbPMx9hTwWqe+iOwMUZQvNO/ID47bgF0aHFPEbIcJK4rhQQWapxCpkEc98P8b1CGqS1M1Qd06uZtOLtKATMZqc1i6cUXxJ0V5qgGICUJiELQvr6k81SBgP5IjAbeSW0COmXa+PPI5Dpm9ex4fIuGaTKsw+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S5T42KRDa0+0CYmQar7oLAwplndZFbPSqBxhDI9Hk8=;
 b=DDwQQ1qOQaSD/qI5Ppr/fij3N0ESyr72snRm5KWoO71w7fkg9lW8/rSJDTaBVKGc0m31XxXVs61mOBPBAYLpdUrH7WLmgm6FoS5n9foWxVK2aILx0i2qtRgGZVJtMp2ROBjwaI0YmWKFvyNqEEodAehQtpVpFSd9NGvltqzVt+k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sat, 7 Dec
 2024 22:54:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 22:54:47 +0000
Message-ID: <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
Date: Sat, 7 Dec 2024 17:54:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: NeilBrown <neilb@suse.de>
Cc: Roland Mainz <roland.mainz@nrubsig.org>,
        Steve Dickson
 <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <173360478780.1734440.2745315303841080285@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173360478780.1734440.2745315303841080285@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 169ac443-b508-41c5-b101-08dd17122618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJZK01MNVVDUm1BVXlpbk9CRk5hQ3dWMk1PL1hhTmN1SGdpWkF6b2FVL29I?=
 =?utf-8?B?YTdhSkYzeHV2aHZ3OVJXMEEwOUVxS0ZjN243VW9JUk1IV3VEOVRmMVFZY29a?=
 =?utf-8?B?NVhSckVPdkN0cFpJTWI2MFBFaURHYTRWOWJ6VzVMb0FKeEpCcHlHRWlES2Zz?=
 =?utf-8?B?cWJDUjZVV3hXdlFkR3g1WnI3aDVTcXdQcGZ0UHFFaTVIdE5KWWtLT1oreU92?=
 =?utf-8?B?T2ZmWXhodkhrWTQxSkxKcmx3Ky83VGZidnRPRi9GVU9Nd2ZrRXUyb3hWTmhG?=
 =?utf-8?B?NFdDTVF2QWxhcjRBMkNuem9SeEx6NGRscGc1MDFPOFVtRUtTSERDL2RjeVFX?=
 =?utf-8?B?Tm9EbUc2NEcxRFZLdE1kSWlvZ2NhR0ZiSDFtSmxDaENUdVYwUUR0bHl5OU1a?=
 =?utf-8?B?czVRcG11WTYzTHMyWis3K05TbTNHa29aNEZUM09MbzAybzBXaEwzckpEZndw?=
 =?utf-8?B?MTl6T2hqWUZ5QUhtSUI0b00wc3dJS0Q4VHNRTit5ZDBzclJaM2tJOWxKZXZ1?=
 =?utf-8?B?dlArZTJlK2lVaDBRMXRPMW1JNWZJUUdoUzFoYlB3clVkWEg5R1BFZE1mYzZP?=
 =?utf-8?B?MlpxMTZ6bHpST3lBRDJqNmpQd0FyZzZVcW0zTThuY0lGN1ZYTU51SXhNbjcz?=
 =?utf-8?B?NkVhbWhLdkEwekdCK2g2NmRUQzI2ZXJ4ZmtPS2hmMm9jeXp0Ulk3RXAwaTd2?=
 =?utf-8?B?YTBMeGoycTdFMUd6UUUybmFxbEkxTlh5TFZYaktXRThoTEdHQ1JpVXpWMFpF?=
 =?utf-8?B?MXdqRHhLTWQzNVlvdVNYMFAwOTBsRHFaLzM1VkdmYjZaSnFFcW9peHoxOUxQ?=
 =?utf-8?B?S0RMS2FJc0RjaG1UR0dhcXBTT1JjMUJjMjBqb0RDaDlORVV6c21YWFFCUVRa?=
 =?utf-8?B?OUlsMGVxUGtmd3Rid0FvZnJ0blh0WUN4NDZZNGlWbVVhV0UxQ002T3VMYW1K?=
 =?utf-8?B?T1hyMmVKTWhEUnZKU3JRcFJFYm15d1hWdExCZm1VWWNRcHJzNzJ3bkRrQ25H?=
 =?utf-8?B?aE5CcmdHTmtMZCtXbWhMbTQwekRKK0Y3NmMwTXNaTjc5bm9tNTVUc2xKTjBH?=
 =?utf-8?B?RnYzU1l5U2JTU3l5ZVk0VFlUdVJDRWlrR0VkeTdvRlhzVWxaOCt6MHEraGhX?=
 =?utf-8?B?QmRFdjNzQmZvUURreVZ4Ry9oREVEak9jTWl3VGxhM2l3anFJY3I3VUhONFJj?=
 =?utf-8?B?UWZiZ3dhWjhjQjFKMU01bWtIZHFkYytBMjkyL0dOQ3BOQVhPUmJSTlNrZFRC?=
 =?utf-8?B?QVVxazZLN2ZzVkQvMHBFSmJXNllybk5QeFp4bUJ6SllISDlhOVVwMGQweGg1?=
 =?utf-8?B?T1luMFlhcGVISFlZQW9acHpjSDAyUlpRZmNvK1I0ZWYwZGgxTWRiSWVXSnhS?=
 =?utf-8?B?UXZIdGxEWnM4cGJiZk1iUnRKeHhkWk1NWUQ4bFZRYnlkc1JGdnAwcjJITlVt?=
 =?utf-8?B?UGo4OVpieFZPcnFlR0p1ZzV1cHkzdXg1R3V4eXlLM05HcVQ1MnlsRHg4Rmsy?=
 =?utf-8?B?VEs5aXQyMG5JZ1U5RjFuVEU3RmFFbFpKNzVKVTlFcEhiRmg3dXdZOEpmS1h6?=
 =?utf-8?B?eHg3NDIxcDNuR2dKdXAyQjRKR3VvU3pnRXExTU05UXRnenp5Wk5tRGVXSnlG?=
 =?utf-8?B?b1NSRThISUUvRE5nblVtVXljVmJabUFkb1RVZGVqYjd5WENqRUtvbWgyL2NN?=
 =?utf-8?B?eDJpU1k3azZlWmN2OWVSbW9HRGdqZ1UrTXp1SzBmbHRUL0lNUFU4YmJGbWhC?=
 =?utf-8?Q?P8JwtpkdgPFXx68eEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1h0R3h6TUtZTE5EejFqYk1NOWFhYzdpSXE5Z3JOek80T1VtYmVqN1FHUHRq?=
 =?utf-8?B?aGtpRVplbk9YUGpjYWVrc2o2MWtKMFVIaFFMQll6cEFrb2oxdFJOSG14ODVZ?=
 =?utf-8?B?eS8wdmpxbVZXQ3JFMXd6Wm9kekhKalJKMnlKekpDTFZTTlhHOGJrWk5MWDhC?=
 =?utf-8?B?bjdOa0dsWXpNdlFXY0ovQVN1L3M3SnVFbXkwWU9McGFhOWp2Vmh1OTdCRTNi?=
 =?utf-8?B?Y3BGcXlqMHJXSFdLZWM4ZDFRSE9TTllhTk1mMTN2Mm1RRVdxZkhQQW9qZUdk?=
 =?utf-8?B?YzVoUEQwYnpCQlhRbndNQWxPMXRDb2E5Z3BiVG5GaUY1eFFUQTg4cWNGSGh6?=
 =?utf-8?B?NG1mYkZJK2IrczcwaWdjWWNGUDFnSEQ0bGQ1MkVJa2M5RlpxdzZQd000ZEIr?=
 =?utf-8?B?TVZsT2lkMVJVWDA2b3NGNmFKdStJOU5GVEpBR2dPYlcxcysyRkk1RmNEQXp3?=
 =?utf-8?B?Wmc2dVo0ZUJDYmJaZDA2QmQydHQvSnBZRXhhN0x2Q25tL3dRVk1acE4zcCtF?=
 =?utf-8?B?WnFYd3BwVnlhbnVaUmdUMkpKV0pPMTN5WXUxUXNZVmxzd1dLczFGS3dpdDE3?=
 =?utf-8?B?eS9VeGhONDFNbVAxVG5BeHIwQ21BVkVwNTVsbHFldWpwMUZRM0Y4Q0tYczJk?=
 =?utf-8?B?aG5PNERFbGptZmNaRHUzbkJrdWZtamRjSHhlWHRhSlZZZUFFcFlleWRxdkYr?=
 =?utf-8?B?WHNqQ3dDcnd2TjBxMTlJdnhCSGxRenFWeng4TlBYWDZzQ0J2OVduU2xmM003?=
 =?utf-8?B?ZDhYL25rRjUvektGNDhLY0l5SzRXSlVzMmp3NXU0Z2tDY0VIUE5aK2EwdDNn?=
 =?utf-8?B?b21yMlZBYWJNbSsyNzZQMG9JNlhSTk1ES1J0VkZORmtRelBScTNhSXZxSXhu?=
 =?utf-8?B?V01OZXRUWWc4QUxubXdFM1lqeEhlNTRVbWxMdDZyODBhMGZXTEFGbmNzVk8v?=
 =?utf-8?B?QTF0YndLTHU2VW1QYkxtS1EyWTZiSyttT3ZWVFNaalpOeTQ0bThUWDJ6WWU3?=
 =?utf-8?B?aU02ZHFBUGE5NGlXWDVuZ2V1KzE1bGtQaUJsN0sxaGdXOEdDclpKdGRCdGVB?=
 =?utf-8?B?ODZ1RXQyeE5SUVFKekNYektwKy8rL2NmblVTZWxIUXRTbDJ4ajRac2tic3dJ?=
 =?utf-8?B?UTIrZldXUEdmbmxNQ1Q2RGNVN1ppTGZRSVFDUisxb1lPeUU3Qk12Z2g3QU5o?=
 =?utf-8?B?SmE0cFBmbjZ0c3ovLzFtRnZuNzlPVDlwQ2txU0tydDFRTGVMK2V5b2NSTUEz?=
 =?utf-8?B?OHNVcVJTOENqQUlXRVRCejBHcWppNnJod05QK21mb1lWLzVjTEYzdElEUVNi?=
 =?utf-8?B?czVmSzUrODlDNGlsdnRaL0tXTVlJUUpuZitMaE5QVmdsbUJJenE2LzlwcnNH?=
 =?utf-8?B?Tm9Fd25NQVVHMUJnUUFueUd6bkZuTHNjdUpuUCtOTXV2WU9ld1prd3d6L1cr?=
 =?utf-8?B?emYwdFV6TFBVTjkxQjcyeHB5OUUzN1FKYlBOQmdIdGN4LytuYUcwbFlNcnR2?=
 =?utf-8?B?YlVCSDJhOWFRT0hoMmhXNllaS05zZDAvdnFuYnNydldJZlkxV2owejcyVUN6?=
 =?utf-8?B?UlluSVBXMUxnaWVSRmNBNnp2Uk1vYlh2OXVwb0xXdGcvMVlnZk1HT3lQdVZ2?=
 =?utf-8?B?UUtwaE44cmtVVllXQ0hmbXIvY1dZTktkMUJrUFhzQVU1Z0dGTUIxQ216TGsw?=
 =?utf-8?B?REY4TWhnd1pKVFFIRHA3T2IxQk16T1F1NkVuQ1cvUmJVcTkzS3NTOW9CSGJT?=
 =?utf-8?B?b1VDV0FWZ05zQzE0SzRzV3pWejdicVMvNDVtN01wanFGMHAwMlMzeFBrT2NB?=
 =?utf-8?B?YUVLbVArQTd3d3c0ZTk4Z3JDaVFqYWxROEhDNVp6U09NM3RPelh2Ny9vQlho?=
 =?utf-8?B?YThEWFJaaFVPSFNQaEIrc3VIb01Pd0JuSjhQWjZRWmVmQ1NLN0doUkdKOVBo?=
 =?utf-8?B?K2ZLakRTQitsZzJWdlRIZUhHRGI4dXdlUCt2UzNsQjkxbGtacFFETmFwYldC?=
 =?utf-8?B?ZENES09pYzhLYTZGTCtpMkI1bDZSNWZvYk5IaDEwb2hjNjViY1RsaEd6K1FK?=
 =?utf-8?B?VlBHYUozT1gwMjNVTWNmUkFGM2IrNVVJQUFFelAzelZ2eW0zc2N2K1lHUGRG?=
 =?utf-8?Q?kHgZEtnAEBwCjfpyUcchRhlAj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fyQ3KRGdNTFCeEGqS5BrIdjLrznQxB+diD8W7q+oES88PqamPDJukxsehaDIa5rxsIRwUixJ46wayLAPGaFUuvX73VdiKqGh0bd99P0FyAAVP0vDgHIoAyrfnV2RgrxLAxhS4yYJS9+Jd76v+DdNm1AKq4xaDApTWGgS/1AiL16a0iwkar5Xcf3SBz2oz25zUJ8UJQNUbvy2IdpS/4JLQPPTWL6lYJcR2sUKHK2XLMNAj7QvZEDWqpbGdbJnIzUptA237E1chx8hI3OVlvUsT56fbuzGHSx+FyMvpFAFTlvXW/dlEljLwKO5HyeYgzudMHskOeIPozp5los0MLX7h6g138qtxjumcLMEntynEibyN5j2ki1T4f8HayO38ddNaYuN4E1S3t93nK+Xt4DV9ifoaNY2oSBKF14No3efFKFmAwHx0fTOyx+XOiZWEvvfuOvp7sTWg3tABMp8cv49SMdUiLaroxT4yx6xvwhP1Npz6SYE1IZFTVhP/0KA2v3vVAbUnBBfnyurqNy7P5YNI1Cn9wQfvtxrAiggsHU2zg3o5Gm2RLCwiedUmE2tw4u/nNQoTXagpK/9FjWX5qdQ2J5E4tzsgUwdxzfgPXsQb+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169ac443-b508-41c5-b101-08dd17122618
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 22:54:47.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91lUVcnbcbBiFfoKowvThAWOmg8PMz5hFeaSrwgu7K+P8YEAIrrSw/RDvgpQS9ef8PSIolOzYySuUAiDhQCrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_03,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412070193
X-Proofpoint-ORIG-GUID: hbrQh2GURDpgq8fEG77koN4P0Bo6hWPa
X-Proofpoint-GUID: hbrQh2GURDpgq8fEG77koN4P0Bo6hWPa

On 12/7/24 3:53 PM, NeilBrown wrote:
> On Sat, 07 Dec 2024, Chuck Lever wrote:
>> Hi Roland, thanks for posting.
>>
>> Here are some initial review comments to get the ball rolling.
>>
>>
>> On 12/6/24 5:54 AM, Roland Mainz wrote:
>>> Hi!
>>>
>>> ----
>>>
>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
>>> to the traditional hostname:/path+-o port=<tcp-port> notation.
>>>
>>> * Main advantages are:
>>> - Single-line notation with the familiar URL syntax, which includes
>>> hostname, path *AND* TCP port number (last one is a common generator
>>> of *PAIN* with ISPs) in ONE string
>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>
>> s/mount points/export paths
>>
>> (When/if you need to repost, you should move this introductory text into
>> a cover letter.)
>>
>>
>>> Japanese, ...) characters, which is typically a big problem if you try
>>> to transfer such mount point information across email/chat/clipboard
>>> etc., which tends to mangle such characters to death (e.g.
>>> transliteration, adding of ZWSP or just '?').
>>> - URL parameters are supported, providing support for future extensions
>>
>> IMO, any support for URL parameters should be dropped from this
>> patch and then added later when we know what the parameters look
>> like. Generally, we avoid adding extra code until we have actual
>> use cases. Keeps things simple and reduces technical debt and dead
>> code.
>>
>>
>>> * Notes:
>>> - Similar support for nfs://-URLs exists in other NFSv4.*
>>> implementations, including Illumos, Windows ms-nfs41-client,
>>> sahlberg/libnfs, ...
>>
>> The key here is that this proposal is implementing a /standard/
>> (RFC 2224).
> 
> Actually it isn't.  You have already discussed the pub/root filehandle
> difference.

RFC 2224 specifies both. Pub vs. root filehandles are discussed
there, along with how standard NFS URLs describe either situation.


> The RFC doesn't know about v4.  The RFC explicitly isn't a
> standard.

RFC 7532 contains the NFSv4 bits. RFC 2224 is not a Normative
standard, like all early NFS-related RFCs, but it is a
specification that other implementations cleave to. RFC 7532
/is/ a Normative standard.


> So I wonder if this is the right approach to solve the need.
> 
> What is the needed?
> Part of it seems to be non-ascii host names.  Shouldn't we fix that for
> the existing syntax?  What are the barriers?

Both non-ASCII hostnames (iDNA) and export paths can contain
components with non-ASCII characters.

The issue is how to specify certain code points when the client's
locale might not support them. Using a URL seems to be the mechanism
chosen by several other NFS implementations to deal with this problem.


> Part seems to be the inclusion of the port number.  Is a "URL" really
> the best way to solve that need?
> Mount.nfs currently expects ":/" to separate host name from path.
> I think host:port:/path would be unambiguous providing "port" did not
> start "/".

There's also IPv6 presentation addresses, which contain ":" already.

However host:port:/path is not something that other NFS implementations
(eg that might share an automounter map) would understand. There is a
significantly higher likelihood that those implementations would be
able to interpret an NFS URI correctly.

I'm not especially convinced by the arguments about port numbers, but
I don't happen to use alternate ports daily.


> Do we really need the % encoding that the URL syntax gives us?  If so -
> why?

See above. Character set translation issues.

And note that NFS URIs are coming soon to other parts of the Linux NFS
administrative interface. No reason that mount.nfs should not also
support them properly.


-- 
Chuck Lever

