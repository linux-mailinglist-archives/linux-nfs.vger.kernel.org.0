Return-Path: <linux-nfs+bounces-10741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93448A6BD62
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF251889EAC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D676E15530C;
	Fri, 21 Mar 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YnJGDaKy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zoZsIjp8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA815DBBA
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568286; cv=fail; b=VH3XXBYnXnB29W/+Pl2QhkgUWISmiFIevwdm6sKwjfRsCnRyFgdhAo2b0cxBUgSRzbrTd+J1d/G/tHFHYUBldi1X43lF1r/8Ov9RjfyH900948v/VLHrgihtewFu2cwwB2U5gO704UiXo/X5PLuOjyXva6lesuE4XZECQlPzb/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568286; c=relaxed/simple;
	bh=u+1se0WQx3Dg3vvWmcjxfrENkaoo7933tfUeXVumbcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5HLfwC6VAPh4nGeZAlS4zogJY4R24xTfEttlNP2nR12KvBlAkKwijk68ko78UUf79Vv8cm2W9rJDHyDg/KD2SpQAZZA16QkbkK+qbqeTQ/zQP3mVy1KDeUhTFfLL01VY9zXBaJeStzMgHSksi8HLdTIP5VW77LBPTOX+VClDBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YnJGDaKy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zoZsIjp8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBtZF016448;
	Fri, 21 Mar 2025 14:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NkhsQ4EbATls4sqIhGAd+AIhGtpLiQOAdDcHiOzzb9Q=; b=
	YnJGDaKyKssmShW3IxBTvwnSlNjUX0Q0dmks2RWzkhcbel9QEsjn/4Ws0TG+wDhS
	XtbxinmJf0hJDXQeAkAFqQT9LHXAaey8hS1IC9Jun+1QDvt9v10REd++v3RgLKKN
	0zhTQqE6jkRXviCu9Jvonepa7nmudLPdzVsVMDQxifHcAFoB0alifsSmtEoaYj+0
	xW4aV708ySNOgWpTcLDjdxbChdp8EjPDSq1J9D3kFODsSYGA6nikTQRyADd1F3MS
	Sp3GxpmVsZ+NT7oDKulOeHXpw3VwM/N2/fohEyNMcM9+GLqQT1fcTlAYBO9A+Tvg
	CxQpOJn921H9HzSgCvJYiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m18j7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 14:44:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LDHUIG022435;
	Fri, 21 Mar 2025 14:44:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxektft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 14:44:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUo5+E2oXFKT6i/4sxcc+csvClwpp+Gh/oPkPFGbRk/4YrgyVWGg1+dLFJbMYOTh1kCNnRiHPeSiBW65NBskCLgCVDhAyLf+W3H6Oo5xgbuHZ2UElEqlXARIqUHLTFKsEHmUWemUJbuJhq0tA8qU4QxS51kb/E7BSyR/Z/kBNG/0+6OsHUSb5CryTRAwbEbsRIj4n/LuJnsGC4fMCNKrnkSCjebTduU8gcyvwonBE6H+KTQbwjJqcLno/ARRJ18OfeUFnwSwSQQ50nh0fDM0z3ytZGrzyEi+KPwdRZFZS7ovnpfFOM+6K1oSwgSsRssKz7e3tX+lPdhclYZpcpZg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkhsQ4EbATls4sqIhGAd+AIhGtpLiQOAdDcHiOzzb9Q=;
 b=ESzd/NdqE3XpatIcaayGWNpZKkaZQJAho7ZYJfcPE2mzXEqPdAbdE/iAIOqtERiGnGn0cYdsIHCGNzInfxugYPvB6eWyqlG458+1toL4uhVxRm6iI6YnEQQFgLsatDfKv9OwjflpvIY/H4Lfein8T/DQ7vDjZRxGNZkOCFY+J2yCX/+yhuMrhfQk/35QTESAWtBBxOLJQ9c+tn01p9EWAhftwEWO9ZcVdQ5p4c+R7lJem97QcDqbjl5o65NJBKhxgvR2teOOru1vAy0Ft1uo/ekoGfk1U/7qRmrnQinCjbMBItiEZdIg9eOPeEm9IndvMTLR28TydKrPE9um1WYgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkhsQ4EbATls4sqIhGAd+AIhGtpLiQOAdDcHiOzzb9Q=;
 b=zoZsIjp8YgKtNvZl42ztKUQAUrSa0AFgPodBEG4/Zo1BCHizY8SsveGmcgG/GXQN7wY/CqbjZR0al90Agu257nMZ8nwLKlztnT8lgtT6/IdJ+5mXmJIgOz62qkiEkrOzYHIhlDQGuisx/EAvr7gAB6hY+Mx6cqHNkolZnIU7iq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4427.namprd10.prod.outlook.com (2603:10b6:806:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 14:44:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 14:44:29 +0000
Message-ID: <202ab884-c011-4a8f-94fe-37aa11b9d32d@oracle.com>
Date: Fri, 21 Mar 2025 10:44:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Benjamin Coddington <bcodding@redhat.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
 <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
 <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:610:b2::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: f09c1ce2-c7a5-4f4f-7f71-08dd6886e285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9uTWw4UXVvMU1oQkhoSCttOXU5UHkzUWtpT2JqajNBZ0ZTdE5Kb2MzT1dO?=
 =?utf-8?B?cFhSeGJ5bWtoZ2ZFdW54Q0h4K0Fhb1V3bGdkeWJLVVlhc0x2bW5wNllOZW5Q?=
 =?utf-8?B?VXZQUTJLTTZNVmM5NVZMWkVOMVVUNmlnalhZWjlXR3diQVppeVNjN05vM1Jt?=
 =?utf-8?B?bXFwb1FVbnJ0emFhU0tjRndKTHJURGR4QVZrU1ZyaHhiY1o0akNDcGI3R2ZI?=
 =?utf-8?B?MWZSdHB2ZXFJM0RYTmszWGVJdUNZK3k4dEVMUnlZUXhPYVcweFAvaXo4VG80?=
 =?utf-8?B?RTRVOTZOOW5Na09RdHdsaHZic3lHczBZYXFrTWhmTGFaeFI4SjlYUjR6SEJN?=
 =?utf-8?B?NWpFNGxWU2F1YjJLMGVnMlRoT0wvK3JRTTV6ZFV6U1R4NlNleHpXT3lvOHJR?=
 =?utf-8?B?bHA1VzJ0dENzcjJPejdJUFBmT0hDVUtObG5NSUMzUWpVM2haYitaT3Rtcy92?=
 =?utf-8?B?VDZNbmVGSnE0dGdzUXgwem5yODBIQjlLUkFzeWZVMDhoTUc5RGY3MWIzSHFX?=
 =?utf-8?B?YVhzMkNaYVBreGlrODZBU2hsaEdBQ0ErVEE4M3l5UGhPODZ3bmp2WXdiWU1G?=
 =?utf-8?B?RWZWVTdTR3ZQN0RCdFBWT2NWK0QvQlNRcVByWTJRQmNCdnFSeGVxbWZubE5w?=
 =?utf-8?B?eDhyb3NURmJiN0M5TjN5Z0UxYnRxK1NRRmxNR2docnljNTJQa2JTK0hDblAz?=
 =?utf-8?B?YVpRbGhnYkpNVVV1NnVEQVdrZE9iNWxTWm1pRktaeEp1SzBmYkc2OUFhdFZz?=
 =?utf-8?B?dFByVm5WbHhEMWJKelFHeXlBUW8xZFMwWUhxelQxcC9jRnFlelJGSzU4NVh4?=
 =?utf-8?B?dkt3T2liUmJDQkxTWkJmQWs5SkQvdlM3cVgwcFFWS1Nzanc5Zjh4MFNZbVg4?=
 =?utf-8?B?am9yaERtaG14TFNXVGtVVlZpRW5udit3cjZkekhmUjVaM3Q4QUJ2VWxpUlNY?=
 =?utf-8?B?Y0FIQ2dlb0J3S0NUM3JGMlVlMDNJaHl4TnZmUk9BS1ZmaVY2REdzdkgvVWJh?=
 =?utf-8?B?UWxxc0lteHJ6WUU5Z1J4WFIyU3ZlYTY5ckxsYjN5WlF4SXRPVnlEakNBUllH?=
 =?utf-8?B?Rk1aTlFHVnptV2RZay9qTVEza1VVQzlSQmU3a0VCRDF6RzhZMWVOakh2c0F6?=
 =?utf-8?B?RzBhODNmQU9QcXlVWjdQMHdsbFk4aHp2T0FJam5GVU4wVmVudGV5SWVaaTZt?=
 =?utf-8?B?VzhyUkxPbmRIOCtOczBuVEJhQzFGaENEMHFUYzg4WmU4eEdQcVMrMzh2ZVdO?=
 =?utf-8?B?NDB4enFzREN5TXo1d2g4aXBBSDhoK1ZTbnpscXllWEpOY2N2OCt1YXFKdG8z?=
 =?utf-8?B?U0RyNU4rSyt4aUxsdHc0RXE3WG05Zy81NWxPUmZtcmxNSHFPRmh1a0VDY0VS?=
 =?utf-8?B?RGpXWVNoM3pCLyt3bkw5TG9DSzRlYWM4QUVHWURXc3lmeU1vM3ZHMnZoRS9s?=
 =?utf-8?B?eUdrU0pQUmcrN0hiRWQxWk90ZlFEdkRVOVJtN1IwMCtET1REcjQrZ3FyWkxr?=
 =?utf-8?B?dWh4aHpLQzc3WUVWcG5jeVRQMGhvZXljWU5SWGd1SkpTK2FBTGxTRjhnK0tw?=
 =?utf-8?B?U29HSkVVekdCNitSdlJTS085ZFc3K0Y5WHcreFRvMWVmWjRWNm4xbTJPaFRM?=
 =?utf-8?B?TzJOWU4zV1VSMnd3NFZBOHh5OXUwS2tCdThLc3VUZis2U3grZ3hPdjM5d05z?=
 =?utf-8?B?aXluOWQ2NnBqWWkraFYraEI5aWk1TDdOZHozTzAyQlhla3g2YlpaOG9vWHJq?=
 =?utf-8?B?U3l1Ykg3TTdEc1pZbkd3bDMrZXpCcHZWTFhkS3FKWm0zK0lCYzFQYXE3NFZK?=
 =?utf-8?B?Rm5paUF5aE04K1puK213amswdUVJeXA3MFduNkg1a3lONFBNU2tWc3dGNGFC?=
 =?utf-8?Q?EC6dPYXNZZ+rt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRkZ1FkUGllTjl3czlNTFhPbldlNCswS3dmZldDa2x4eWtLTi9zcmhjbCsv?=
 =?utf-8?B?dkxWV0QwUkFNT0NzYUdFTmMveXhqYnI5UTRJNDQ3RHp0UDgvazRIb1pNbWJP?=
 =?utf-8?B?ZU02QkhTMjNNa2J1dzB5ZW9Gd29YS3hKeHl5dGovUEZ1TlZ1YWJPUnAzbUs3?=
 =?utf-8?B?YzBzN2xlVWpwM2R1Zm9acWczeDc1M2w5T29JUEFIWlJOVU5PKy9Xdk5tYnpt?=
 =?utf-8?B?NGxSR0M5dXR4TjVQZnJ3b2dNMTZjWVlFSkw1cmxEdTBUUXQwTDRqTTFZeHY2?=
 =?utf-8?B?M1doQ3JuTlNta2RDZjNNWWZhVFBZZzNqNjNMMDRCRTRjZTkzVENSdkV3enpi?=
 =?utf-8?B?NkIzZnpKYW5hb1p3Q1N2d0E3SXhMaFhwOUkwSGs0cFBXK1NrRjJxRzFZam9Y?=
 =?utf-8?B?Y0x4QnRuTjJIM3FlQzk4ZnhvVTR1b3JWZkw3WUxLeXl3RFhqZE45Zk1FZUtj?=
 =?utf-8?B?c1doc3I3cHJacGIzclBEQXI1Y0hCb0RBd2RUSWtIc2xHQUIvL1E3U3R3R3ll?=
 =?utf-8?B?eHg2amVCakR0UEdYd21iUnFBaDhpaEVyZkVPNmJmYzA4c2xqUForMm90dHo2?=
 =?utf-8?B?b2ZDSXBZWWo4dzhOUnJ5cWxvTUVPc1dSSFRyN1ZFNFZXN25hZjMvOFZ6VWs2?=
 =?utf-8?B?NStkeWZ0UWExdWpoTit0bEdKNUR5bVF6Sk4vSWNPWVlrbFE0MUhYMGQ5Q3Br?=
 =?utf-8?B?cVNGdUxFODVCQ2hTTmdFRXl4ZGNYTnhUNC81bUlUQ3JnVmRsbFBXdEdWMFps?=
 =?utf-8?B?eERrSVg3TjJ5T2pyWlJCRkxEOGdSaWQ3VFpHMVRSLzlnY0M3WWkyOENwd1g3?=
 =?utf-8?B?cEJsbFNENm5aOU1XVFpkck1hczVqQVVEVmFSUWtMWWZWNjl5Ukp6b0NzbUFw?=
 =?utf-8?B?YkZuUHAveHdBQnQzSGRleUsrUndLK0JvbGxFeDltaWtVQnhTSHlCby9UUEIw?=
 =?utf-8?B?OVlKMDYxN2VDbXNwQjVUMG10YU85NXBZd3dYYWhmNGtXQ1dnTHcvZDE5RU1q?=
 =?utf-8?B?SDlOS1o1VjNnZkl2S2ptVGV5WG44M3NZRkpQL1dEN3A0T3ZFRXNUQU9qYlRv?=
 =?utf-8?B?d2V4UHNQZFNHejJDWnQyZUdBMlZyWmYxYUNZaDVhZFFBcWljSWNaY1dnNDdS?=
 =?utf-8?B?L0NuZ1hqL3YzaDFWaDM5WndQWklHNUM1cEVYMGhFUlRhdmkxR1MvR1VrNUly?=
 =?utf-8?B?QW1USkVaeTYwU29TSm5lTDZtL3IzdmZFUE5VRk5Ja0RIczhzUkhSeGpOR1Ro?=
 =?utf-8?B?YVp5d3RNUHJYM2NQRnpITk5BNysyNTVIemI5R3RuTlNleTlRczc0V253STVL?=
 =?utf-8?B?ZnpMd0xDdlp4Z0Y2WnlZNWJZNTYwWk1XaTZjcjRpZERMNEMwMTdsTm5sUDdE?=
 =?utf-8?B?WnNab1E0bEVXM0lrUzRWWC81LzRaUGUydnFKNXFiVUlmdGYwUmtxUGZoeWVh?=
 =?utf-8?B?TTVmYjJTalkxNHZFMWtGdkd1bDFRdzhZTU1FMWMyZ2RJamJtd0NDTVJCL1lj?=
 =?utf-8?B?R0QvMDhUTWd3S05iMTdxT2ZYN0tLU1hrSWxhQ3lEMjVTcDhGZWJqU2ZjazlT?=
 =?utf-8?B?THlJREJicDhWdllSdWN5b2s0L3Y0RWpGWllsazN0bW01S2xUOGZYeS9hYUZ2?=
 =?utf-8?B?Q1VnQ0syeCtRVUtQdm9jTjA4Yi9IYk54N2hqVzFVRWt5QWVnaVNhUi9mUlBO?=
 =?utf-8?B?S3NDaVJ5WGxKdjZ5SVZ0czJZOW1RdUp6V3ZyNmNCclh2WFRDbFBLdXgwa050?=
 =?utf-8?B?dnJtcUhWU1Nmd0Y1a1MwS2lBZSsybGphUHJ4a1RoU0dIM1UrcUplYkFwZ25j?=
 =?utf-8?B?SGU4Vmc2K1ZuWG1qMGpleGlzaHRGTWZhNTcxZFMvejEwOXovTEdGcENCRklS?=
 =?utf-8?B?UXFXTks3U0xBTlZjdTdIUitreTBZai9jaG9DSHNXRmdLL1RicWt6WWtVcUpR?=
 =?utf-8?B?REdXaHhHQmlmWlNVUFZwdTRXZ0hITHV4aHB6U3dCUW9TL2pOd2hGTGh5bitr?=
 =?utf-8?B?ZURXVzZxYmcwd3lJck10QUZ4WDlCcFFXOWtFclgvYXpKN08xc0IyZ1VkUklW?=
 =?utf-8?B?MnQ0VXRWdjl6TFc0VTNvY1A4VmNadTF0UUVacVhxeHJiQ3hyVUxZdDV5a3F4?=
 =?utf-8?Q?4yOTj/iw8l8NqLPIeATg53noA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AbisUvhVM11URXrsxWBrG/zVuX5R4H9hK/xxEyXYbntcCdbMfn5gqlN1rU2ZxNUZowXHX+aAJtFpYfiu1WsDsaHfjZXYkhdZQJTVwxmuQA0M056HbwfcxbPgctnE86coFqqQkXIYoF7/Sc78z9faFfMJqzqUmhd5GawsVdPejvZW3pKoL4k98Nxhq+iT1jAtuGXZcCrz0lyt9nMXkULbsIi+ElnXtgrr7M+yDtY5AZiWkYy48/aWGrAnYg0Li7h9B7CuiInidpNQr3ewa+vAtvBX9TrVyeUuQov6EwtVNp200f4Y4a7bc595mag6Y8Odg52YGxwkFsVCsyHVZbDht2nE1mUhdUnCpyKYHbcGoD+Dcjtxvqzt/FfNnisjPr1BmGi+Z7urP6ztucCmD9LwS2NbrVB0c/GsHUEWnySuGieBaPv3hFNFRbwDdWmPpxGyHOHI3vVO0/h1yVH4+ZRMxVmo3EIHk48AxFA5mnUwQAe7Y2CUv/P6onoqH5mqtVNKCvlQA1p28JcCzemRtyAQjk5Yeg+8JYB7tkuvynwPGOgoszTPZC4kY0C5xvy2odtSrlORwR62WcTgxWkoJZaxrxWISyU/KyW3NAlVwINNYCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09c1ce2-c7a5-4f4f-7f71-08dd6886e285
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:44:29.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikH7Tn8dN8Vd4YC0XQFzn4Vnf+Tv0a+36RjbsGCi/vthrZNK+chXKkoc+zzsOVvuKVKTysC84949DQtlzbWyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=903 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210107
X-Proofpoint-GUID: d3jWrTFUhjp2mDdaZU8Mu-hAfTdNiG62
X-Proofpoint-ORIG-GUID: d3jWrTFUhjp2mDdaZU8Mu-hAfTdNiG62

On 3/21/25 10:36 AM, Benjamin Coddington wrote:
> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
> 
>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>> Hi,
>>>>
>>>> Currently when the local file system needs to be unmounted for maintenance
>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>> on the NFS shares before the umount(8) can succeed.
>>>
>>> This is easily achieved with
>>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>
>>> Do this after unexporting and before unmounting.
>>
>> Seems like administrators would expect that a filesystem can be
>> unmounted immediately after unexporting it. Should "exportfs" be changed
>> to handle this extra step under the covers? Doesn't seem like it would
>> be hard to do, and I can't think of a use case where it would be
>> harmful.
> 
> No. I think that admins don't expect to lose all their NFS client's state if
> they're managing the exports.  That would be a really big and invisible change
> to existing behavior.

To be clear, I mean that a file system should be unlocked only when it
is specifically unexported. IMO, unexport is usually an administrator
action that means "I want to stop remote access to this file system now"
and that's what unlock_filesystem does.

IMO administrators would be surprised to learn that NFS clients may
continue to access a file system (via existing open files) after it
has been explicitly unexported.

The alternative is to document unlock_filesystem in man exportfs(8).

And perhaps we need a more surgical mechanism that can handle the case
where the file system is still exported but the security policy has
changed. Because this does feel like a real information leak.


-- 
Chuck Lever

